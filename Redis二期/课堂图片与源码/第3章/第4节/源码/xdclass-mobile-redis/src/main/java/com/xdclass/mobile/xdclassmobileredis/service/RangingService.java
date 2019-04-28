package com.xdclass.mobile.xdclassmobileredis.service;

import com.xdclass.mobile.xdclassmobileredis.RedisService;
import com.xdclass.mobile.xdclassmobileredis.domain.ScoreFlow;
import com.xdclass.mobile.xdclassmobileredis.domain.User;
import com.xdclass.mobile.xdclassmobileredis.domain.UserScore;
import com.xdclass.mobile.xdclassmobileredis.domain.UserScoreExample;
import com.xdclass.mobile.xdclassmobileredis.mapper.ScoreFlowMapper;
import com.xdclass.mobile.xdclassmobileredis.mapper.UserMapper;
import com.xdclass.mobile.xdclassmobileredis.mapper.UserScoreMapper;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class RangingService implements InitializingBean {


    private static final String RANKGNAME = "user_score";

    private static final String SALESCORE = "sale_score_rank:";

    @Autowired
    private RedisService redisService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ScoreFlowMapper scoreFlowMapper;

    @Autowired
    private UserScoreMapper userScoreMapper;


    public void rankAdd(String uid, Integer score) {
        redisService.zAdd(RANKGNAME, uid, score);
    }

    public void increSocre(String uid, Integer score) {

        redisService.incrementScore(RANKGNAME, uid, score);
    }

    public Long rankNum(String uid) {
        return redisService.zRank(RANKGNAME, uid);
    }

    public Long score(String uid) {
        Long score = redisService.zSetScore(RANKGNAME, uid).longValue();
        return score;
    }

    public Set<ZSetOperations.TypedTuple<Object>> rankWithScore(Integer start, Integer end) {
        return redisService.zRankWithScore(RANKGNAME, start, end);
    }


    public void rankSaleAdd() {
        UserScoreExample example = new UserScoreExample();
        example.setOrderByClause("id desc");
        List<UserScore> userScores = userScoreMapper.selectByExample(example);
        userScores.forEach(userScore -> {
            String key = userScore.getUserId() + ":" + userScore.getName();
            redisService.zAdd(SALESCORE, key, userScore.getUserScore());
        });
    }


    /**
     * 添加用户积分
     *
     * @param uid
     * @param score
     */
    public void increSaleSocre(String uid, Integer score) {
        User user = userMapper.find(uid);
        if (user == null) {
            return;
        }
        int uidInt = Integer.parseInt(uid);
        long socreLong = Long.parseLong(score + "");
        String name = user.getUserName();
        String key = uid + ":" + name;
        scoreFlowMapper.insertSelective(new ScoreFlow(socreLong, uidInt, name));
        userScoreMapper.insertSelective(new UserScore(uidInt, socreLong, name));
        redisService.incrementScore(SALESCORE, key, score);
    }


    public Map<String, Object> userRank(String uid, String name) {
        Map<String, Object> retMap = new LinkedHashMap<>();
        String key = uid + ":" + name;
        Integer rank = redisService.zRank(SALESCORE, key).intValue();
        Long score = redisService.zSetScore(SALESCORE, key).longValue();
        retMap.put("userId", uid);
        retMap.put("score", score);
        retMap.put("rank", rank);
        return retMap;
    }


    public List<Map<String, Object>> reverseZRankWithRank(long start, long end) {
        Set<ZSetOperations.TypedTuple<Object>> setObj = redisService.reverseZRankWithRank(SALESCORE, start, end);
        List<Map<String, Object>> mapList = setObj.stream().map(objectTypedTuple -> {
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("userId", objectTypedTuple.getValue().toString().split(":")[0]);
            map.put("userName", objectTypedTuple.getValue().toString().split(":")[1]);
            map.put("score", objectTypedTuple.getScore());
            return map;
        }).collect(Collectors.toList());
        return mapList;
    }

    public List<Map<String, Object>> saleRankWithScore(Integer start, Integer end) {
        Set<ZSetOperations.TypedTuple<Object>> setObj = redisService.reverseZRankWithScore(SALESCORE, start, end);
        List<Map<String, Object>> mapList = setObj.stream().map(objectTypedTuple -> {
            Map<String, Object> map = new LinkedHashMap<>();
            map.put("userId", objectTypedTuple.getValue().toString().split(":")[0]);
            map.put("userName", objectTypedTuple.getValue().toString().split(":")[1]);
            map.put("score", objectTypedTuple.getScore());
            return map;
        }).collect(Collectors.toList());
        return mapList;
    }



    @Override
    public void afterPropertiesSet() throws Exception {
        System.out.println("======enter init bean=======");
        this.rankSaleAdd();
    }
}
