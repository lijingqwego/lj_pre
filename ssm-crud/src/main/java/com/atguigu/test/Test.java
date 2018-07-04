package com.atguigu.test;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.atguigu.utils.HttpClinent;

public class Test {
	public static void main(String[] args) throws IOException {
		String res = HttpClinent.httpGet("http://192.168.109.129:8080/emps?pn=1");
		JSONObject jsonObject = JSON.parseObject(res);
		JSONObject extend = jsonObject.getJSONObject("extend");
		JSONObject pageInfo = extend.getJSONObject("pageInfo");
		JSONArray list = pageInfo.getJSONArray("list");
		for (int i = 0; i < list.size(); i++) {
			JSONObject emp = list.getJSONObject(i);
			String empId = emp.getString("empId");
			String empName = emp.getString("empName");
			System.out.println(empId+"------------"+empName);
		}
		
		System.out.println(res);
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("empName", "testEmp2");
//		String result = HttpClinent.httpPost("http://192.168.109.129:8080/emp",params);
//		System.out.println(result);
	}
}
