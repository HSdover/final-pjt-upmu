package com.fpjt.upmu.mail.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fpjt.upmu.mail.model.vo.MailAttach;
import com.fpjt.upmu.mail.model.vo.Mail;
import com.fpjt.upmu.mail.model.vo.MailExt;
import com.fpjt.upmu.mail.model.vo.MailReceiver;

@Repository
public class MailDaoImpl implements MailDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public MailExt selectOneMailCollection(int no) {
		return session.selectOne("mail.selectOneMailCollection",no);
	}

	@Override
	public int insertMail(MailExt mail) {
		return session.insert("mail.insertMail", mail);
	}

	@Override
	public int insertAttachment(MailAttach attach) {
		return session.insert("mail.insertAttachment", attach);
	}

	@Override
	public int selectMailTotalContents1(String i) {
		return session.selectOne("mail.selectMailTotalContents1", i);
	}

	@Override
	public int selectMailTotalContents2(int i) {
		return session.selectOne("mail.selectMailTotalContents2", i);
	}

	@Override
	public List<Mail> selectMailList1(Map<String, Object> param, String i) {
		int offset = (int)param.get("offset");
		int limit = (int)param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("mail.selectMailList1", i, rowBounds);
	}

	@Override
	public List<Mail> selectMailList2(Map<String, Object> param, int i) {
		int offset = (int)param.get("offset");
		int limit = (int)param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("mail.selectMailList2", i, rowBounds);
	}

	@Override
	public MailAttach selectOneAttachment(int no) {
		return session.selectOne("mail.selectOneAttachment", no);
	}
	
	@Override
	public List<MailAttach> selectAttachList(int mailNo) {
		return session.selectList("mail.selectAttachList", mailNo);
	}

	@Override
	public List<Mail> searchMail(Map<String, Object> searchMail, int i) {	
		if(i == 1) {
			//보낸 메일함 검색
			return session.selectList("mail.searchSenderMail", searchMail);
		}
		else {
			//
			return session.selectList("mail.searchReceiverMail", searchMail);
		}
	}
	
	@Override
	public List<MailReceiver> searchReceiver(String searchReceiver) {
		return session.selectList("mail.searchReceiver", searchReceiver);
	}
	
	@Override
	public String deleteMail(String str, int who, int now) {
		int result;
		String resultStr = null;
		
		if(who == 1) {
			//보낸 사람이 삭제
			if(now != 2) {
				result =  session.update("mail.hideSendMail", str);
				resultStr = "hide";
				
				if(result != 1) {
					resultStr = "beforeDel";
				}				
			} else if(now == 2){
				result = session.delete("mail.deleteMail", str);
				return result + "";
			}
		}
		
		else {
			
			if(now != 2) {
				//받은 사람이 삭제
				result = session.update("mail.hideReceiveMail", str);
				resultStr = "hide";
				
				if(result != 1) {
					resultStr = "beforeDel";
				}	
			} else {
				result = session.delete("mail.deleteMail", str);
				return result + "";
			}
		}
		return resultStr;
	}
}