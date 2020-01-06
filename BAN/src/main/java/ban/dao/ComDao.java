package ban.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ComDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
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

	public void update(String queryId, Map map) throws Exception {
		sqlSession.update(queryId, map);
	}

	public void delete(String queryId, Map map) throws Exception {
		sqlSession.delete(queryId, map);
	}
	
}
