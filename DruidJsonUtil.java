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

		List<Map<String,Object>> listMap = new ArrayList<Map<String,Object>>();
		
		for (int i = 0; i < jsonArray.size(); i++) {
			
			JSONObject jsonObject3 = jsonArray.getJSONObject(i);
			String dimension = jsonObject3.getString("dimension");
			String op = jsonObject3.getString("op");
			
			
			JSONArray valueArray = jsonObject3.getJSONArray("values");
			
			List<Object> inList = new ArrayList<Object>();
			List<Object> outList = new ArrayList<Object>();
			
			List<Object> inList2 = new ArrayList<Object>();
			List<Object> outList2 = new ArrayList<Object>();
			
			
			
			String op1=null;
			String op2=null;
			String op3=null;
			String op4=null;
			
			String inOp=null;
			String outOp=null;
			
			String firstFilter=null;
			
			boolean isAdd=false;
			
			String tempD=null;
			
			for (int index = 0; index < valueArray.size(); index++) {
				JSONObject jsonObject4 = valueArray.getJSONObject(index);
				
				String opv = jsonObject4.getString("op");
				String value = jsonObject4.getString("value");
				
				//filter的基本属性
				Map<String, Object> jsonValue = new HashMap<String, Object>();
				jsonValue.put("type", "selector");
				jsonValue.put("dimension", dimension);
				jsonValue.put("value", value);
				String filter = JSONObject.fromObject(jsonValue).toString();
				
				if(index==0)
				{
					firstFilter=filter;
					continue;
				}
				if(dimension.equals(tempD))
				{
					if(opv.equals(inOp))
					{
						if(op2==null)
						{
							op2=opv;
						}
						if(!isAdd)
						{
							outList.add(firstFilter);
							isAdd=true;
						}
						outList.add(filter);
					}
					else
					{
						if(op1==null)
						{
							op1=opv;
						}
						if(!isAdd)
						{
							inList.add(firstFilter);
							isAdd=true;
						}
						inList.add(filter);
					}
				}
				else
				{
					if(op.equals(outOp))
					{
						if(op4==null)
						{
							op4=op;
						}
						if(!isAdd)
						{
							outList2.add(firstFilter);
							isAdd=true;
						}
						outList2.add(filter);
					}
					else
					{
						if(op3==null)
						{
							op3=op;
						}
						if(!isAdd)
						{
							inList2.add(firstFilter);
							isAdd=true;
						}
						inList2.add(filter);
					}
				}
				
				inOp=opv;
				outOp=op;
				tempD=dimension;
				
			}
			
			if(valueArray.size()>1)
			{
				if(op1!=null)
				{
					Map<String, Object> map1 = new HashMap<String,Object>();
					
					map1.put("type", op1);//
					map1.put("fields", inList);
					String string = JSONObject.fromObject(map1).toString();
					outList.add(string);
				}
				if(op2!=null)
				{
					Map<String, Object> map2 = new HashMap<String,Object>();
					map2.put("type", op2);
					map2.put("fields", outList);
				}
				////////////////////////////////////////////////
				
				if(op3!=null)
				{
					Map<String, Object> map1 = new HashMap<String,Object>();
					
					map1.put("type", op3);//
					map1.put("fields", inList2);
					String string = JSONObject.fromObject(map1).toString();
					outList2.add(string);
				}
				if(op4!=null)
				{
					Map<String, Object> map2 = new HashMap<String,Object>();
					map2.put("type", op4);
					map2.put("fields", outList2);
				}
			}
			
			
			
			
			
			
			
		}
		
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
