package test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DruidJsonUtil {

	public static void main(String[] args) throws IOException {
		String loadData = loadData();
		String filterJson2 = toFilterJson(loadData);
		System.out.println(filterJson2);
	}
	
	
	private static String toFilterJson(String loadData) {
		JSONObject jsonObject = JSONObject.fromObject(loadData);
		JSONObject jsonObject2 = jsonObject.getJSONObject("content");
		JSONArray jsonArray = jsonObject2.getJSONArray("filter");
		String pre=null;
		Map<String, Object> filterMap = new HashMap<String,Object>();
		List<Map<String, Object>> listValueMap = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < jsonArray.size(); i++) {
			
			JSONObject jsonObject3 = jsonArray.getJSONObject(i);
			String dimension = jsonObject3.getString("dimension");
			String op = jsonObject3.getString("op");
			
			filterMap.put("type", op);
			
//			String setType = jsonObject3.getString("setType");
			JSONArray valueArray = jsonObject3.getJSONArray("values");
			
			List<String> filterList = new ArrayList<String>();
			
			Map<String, Object> valueMap=null;
			for (int index = 0; index < valueArray.size(); index++) {
				JSONObject jsonObject4 = valueArray.getJSONObject(index);
//				String rule = jsonObject4.getString("rule");
				String opv = jsonObject4.getString("op");
				String value = jsonObject4.getString("value");
				
				//filter的基本属性
				Map<String, Object> jsonValue = new HashMap<String, Object>();
				jsonValue.put("type", "selector");
				jsonValue.put("dimension", dimension);
				jsonValue.put("value", value);
				String jsonString = JSONObject.fromObject(jsonValue).toString();
				
				
				//构建完整的单个filter
				valueMap = new HashMap<String, Object>();
				
				if(jsonValue.get("dimension").toString().equals(pre))
				{
					Map<String, Object> valueMap2 = new HashMap<String, Object>();
					List<String> filterList2 = new ArrayList<String>();
					filterList2.add(jsonString);
					valueMap2.put("type", opv);
					valueMap2.put("fields", filterList2);
					String jsonString2 = JSONObject.fromObject(valueMap2).toString();
					filterList.add(jsonString2);
				}
				else
				{
					filterList.add(jsonString);//jsonValue存放到list里面
				}
				valueMap.put("type", opv);
				valueMap.put("fields", filterList);
				//将filter存入list中
				pre=dimension;
			}
			listValueMap.add(valueMap);
			filterMap.put("fields", listValueMap);
		}
		String jsonString = JSONObject.fromObject(filterMap).toString();
		return jsonString;
	}

	public static String loadData()
	{
		InputStream in = Object.class.getResourceAsStream("/druid/filter.json");
		InputStreamReader reader = new InputStreamReader(in);
		BufferedReader isr=new BufferedReader(reader);
		StringBuffer sb=new StringBuffer();
		String line=null;
		try {
			while((line=isr.readLine())!=null){
				sb.append(line.trim());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

}
