package ban.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ban.dao.ComDao;

@Service("genericService")
public class ComServiceImpl implements ComService{

	@Autowired
	ComDao comDao;

	@Override
	public List<Map> selectList(String queryId, Map param) throws Exception {
		// TODO Auto-generated method stub
		return comDao.selectList(queryId, param);
	}

	@Override
	public Map selectOne(String queryId, Map param) throws Exception {
		// TODO Auto-generated method stub
		return comDao.selectOne(queryId, param);
	}

	@Override
	public Map selectOne2(String queryId, String param) throws Exception {
		// TODO Auto-generated method stub
		return comDao.selectOne2(queryId, param);
	}

	@Override
	public String insert(String queryId, Map map) throws Exception {
		// TODO Auto-generated method stub
		return comDao.insert(queryId, map);
	}

	@Override
	public void update(String queryId, Map map) throws Exception {
		// TODO Auto-generated method stub
		comDao.update(queryId, map);
		
	}

	@Override
	public void delete(String queryId, Map map) throws Exception {
		// TODO Auto-generated method stub
		comDao.delete(queryId, map);
	}

	@Override
	public void join(String queryId, Map map) throws Exception {
		// TODO Auto-generated method stub
		comDao.insert(queryId, map);
		
		if( !String.valueOf(map.get("nick")).equals("") 
		|| !String.valueOf(map.get("Email")).equals("") 
		|| !String.valueOf(map.get("tel")).equals("") ){
			comDao.insert("com.memberDetailInsert", map);	  
		}
		
	}
	
	
}
