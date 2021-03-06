package ban.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class ComDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSessionTemplate sqlSession;
	
	@Autowired
	@Qualifier("batchSqlSessionTemplate")
	SqlSessionTemplate batchSqlSessionTemplate;
	
	public List<Map> selectList(String queryId, Map param) throws Exception {
		return sqlSession.selectList(queryId, param);
	}

	public Map selectOne(String queryId, Map param) throws Exception {
		return sqlSession.selectOne(queryId, param);
	}

	public Map selectOne2(String queryId, String param) throws Exception {
		return sqlSession.selectOne(queryId, param);
	}

	public String insert(String queryId, Map map) throws Exception {
		sqlSession.insert(queryId, map);
		return String.valueOf(map.get("seq_pk"));
	}

	public int update(String queryId, Map map) throws Exception {
		return sqlSession.update(queryId, map);
	}

	public int delete(String queryId, Map map) throws Exception {
		return sqlSession.delete(queryId, map);
	}
	
	public void batchInsert(String queryId, Map map) throws Exception {
		batchSqlSessionTemplate.insert(queryId, map);
	}
	
	public void batchUpdate(String queryId, Map map) throws Exception {
		batchSqlSessionTemplate.update(queryId, map);
	}
}
