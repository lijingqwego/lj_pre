package com.atguigu.test;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.alibaba.fastjson.JSON;

public class GroupByDayTest {

	public static void main(String[] args) {

		List<Map<String, String>> structData = structData();

		
		List<Map<String, String>> newstructData=new ArrayList<Map<String, String>>();
		Set<String> set=new HashSet<String>();
		for (Map<String, String> map : structData) {
			for (Map.Entry<String, String> obj : map.entrySet()) {
				
				String value = obj.getValue().substring(0, 10);
				boolean add = set.add(value);
				if(add)
				{
					map.put(obj.getKey(), value);
					newstructData.add(map);
				}
			}
		}
		set.clear();
		Object json = JSON.toJSON(newstructData);

		System.out.println(json.toString());
	}

	private static List<Map<String, String>> structData() {
		List<Map<String, String>> arrayList = new ArrayList<Map<String, String>>();
		for (int i = 30; i < 60; i++) {
			Map<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("startTime", "2018-07-04 23:27:" + i);
			arrayList.add(hashMap);
		}
		for (int i = 10; i < 30; i++) {
			Map<String, String> hashMap = new HashMap<String, String>();
			hashMap.put("startTime", "2018-07-05 23:27:" + i);
			arrayList.add(hashMap);
		}
		return arrayList;
	}

	// 把二个时间的的年月日分别对比，完全相等就是同一天，代码下：

	private static boolean isSameDate(Date date1, Date date2) {
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(date1);

		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(date2);

		boolean isSameYear = cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR);
		boolean isSameMonth = isSameYear && cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH);
		boolean isSameDate = isSameMonth && cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH);

		return isSameDate;
	}

}
