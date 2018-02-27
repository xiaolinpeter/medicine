package com.peter.shiro.service;

import jxl.Sheet;
import jxl.Workbook;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.peter.shiro.model.Question;
import com.peter.shiro.model.Student;
import com.peter.shiro.util.UUIDGenerator;

/**
 * @author by fk
 * @version <0.1>
 * @created on 2018-01-23.
 */
@Service
public class AdminService {
	@Autowired
	private DataService dataService;


	/**
	 * 查询指定目录中电子表格中所有的数据
	 *
	 * @param file
	 *            文件完整路径
	 * @return
	 */
	public  List<Question> getAllByExcel(String file, String teacherId, String fileId) {
		List<Question> list = new ArrayList<>();
		try {
			Workbook rwb = Workbook.getWorkbook(new File(file));
			Sheet rs = rwb.getSheet(0);
			int clos = rs.getColumns();// 得到所有的列
			int rows = rs.getRows();// 得到所有的行

			System.out.println(" lols:" + clos + " rows:" + rows);
			for (int i = 1; i < rows; i++) {
				for (int j = 0; j < clos; j++) {
					// 第一个是列数，第二个是行数
					String id = UUIDGenerator.getUUID();
					String title = rs.getCell(j++, i).getContents();// 默认最左边编号也算一列 所以这里得j++
					String content = rs.getCell(j++, i).getContents();
					list.add(new Question(id, title, content, teacherId, fileId));
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}


	public  List<Student> getStudentExcel(String file, String teacherId, String fileId) {
		List<Student> list = new ArrayList<>();
		try {
			Workbook rwb = Workbook.getWorkbook(new File(file));
			Sheet rs = rwb.getSheet(0);
			int clos = rs.getColumns();// 得到所有的列
			int rows = rs.getRows();// 得到所有的行

			System.out.println(" lols:" + clos + " rows:" + rows);
			for (int i = 1; i < rows; i++) {
				for (int j = 0; j < clos; j++) {
					// 第一个是列数，第二个是行数
					String id = rs.getCell(j++, i).getContents();
					String name = rs.getCell(j++, i).getContents();// 默认最左边编号也算一列 所以这里得j++
					String sex = rs.getCell(j++, i).getContents();
					String password= rs.getCell(j++, i).getContents();
					String email = rs.getCell(j++, i).getContents();
					list.add(new Student(id, name, sex, password, email));
				} 
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 通过Id判断是否存在
	 *
	 * @param id
	 * @return
	 */
	public boolean isExistQuestion(String id) {
		JSONObject data = dataService.toJSONObject("select * from t_question where id= ?", id);
		if (data.length() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	
	public boolean isExistStudent(String id) {
		JSONObject data = dataService.toJSONObject("select * from t_student where id= ?", id);
		if (data.length() > 0) {
			return true;
		} else {
			return false;
		}
	}
}
