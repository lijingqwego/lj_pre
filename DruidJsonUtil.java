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
		String inOp=null;
		String outOp=null;
		
		List<Object> inList2 = new ArrayList<Object>();
		List<Object> outList2 = new ArrayList<Object>();
		
		String isFirst=null;
		
		
		String op3=null;
		String op4=null;
		
		List<Object> firstList = new ArrayList<Object>();
		for (int i = 0; i < jsonArray.size(); i++) {
			
			JSONObject jsonObject3 = jsonArray.getJSONObject(i);
			String dimension = jsonObject3.getString("dimension");
			String op = jsonObject3.getString("op");
			
			
//			String setType = jsonObject3.getString("setType");
			JSONArray valueArray = jsonObject3.getJSONArray("values");
			
			List<Object> inList = new ArrayList<Object>();
			List<Object> outList = new ArrayList<Object>();
			
			
			
			String op1=null;
			String op2=null;
			
			String string2=null;
			
			
			
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
				
				if(i==0 || index==0)
				{
					firstList.add(jsonString);
					continue;
				}
				
				if(valueArray.size()>1)
				{
					if(opv.equals(inOp))
					{
						op1=opv;
						inList.add(jsonString);
						inList.add(firstList);
					}
					else
					{
						op2=opv;
						outList.add(jsonString);
						outList.add(firstList);
					}
				}
				else
				{
					if(op.equals(outOp))
					{
						op3=outOp;
						inList2.add(jsonString);
						inList2.add(firstList);
					}
					else
					{
						op4=outOp;
						outList2.add(jsonString);
						outList2.add(firstList);
					}
				}
				if(firstList!=null && firstList.size()>0)
				{
					firstList.clear();
				}
				
				inOp=opv;
				outOp=op;
				
			}
			
			Map<String, Object> map1 = new HashMap<String,Object>();
			
			map1.put("type", op1);//
			map1.put("fields", inList);
			String string = JSONObject.fromObject(map1).toString();
			outList.add(string);
			
			Map<String, Object> map2 = new HashMap<String,Object>();
			map2.put("type", op2);
			map2.put("fields", outList);
			string2 = JSONObject.fromObject(map2).toString();
			inList2.add(string2);
		}
		
		Map<String, Object> map3 = new HashMap<String,Object>();
		
		map3.put("type", op3);//
		map3.put("fields", inList2);
		String string = JSONObject.fromObject(map3).toString();
		outList2.add(string);
		
		Map<String, Object> map4 = new HashMap<String,Object>();
		map4.put("type", op4);
		map4.put("fields", outList2);
		String string2 = JSONObject.fromObject(map4).toString();
		return string2;
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
