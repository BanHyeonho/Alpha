package ban.service;

import java.util.List;
import java.util.Map;

public interface ComService {
	
	public List<Map> selectList(String queryId, Map param) throws Exception;

	public Map selectOne(String queryId, Map param) throws Exception;

	public Map selectOne2(String queryId, String param) throws Exception;
	
	public String insert(String queryId, Map map) throws Exception;

	public void update(String queryId, Map map) throws Exception;

	public void delete(String queryId, Map map) throws Exception;

}
