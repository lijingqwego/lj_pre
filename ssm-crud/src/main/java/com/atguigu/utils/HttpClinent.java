package com.atguigu.utils;

import java.io.IOException;
import java.util.Map;
import java.util.Map.Entry;

import okhttp3.FormBody;
import okhttp3.FormBody.Builder;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class HttpClinent {

	public static final MediaType JSON = MediaType.parse("application/json;charset=utf-8");
	
	public static String httpGet(String url) throws IOException {
        OkHttpClient httpClient = new OkHttpClient();
        Request request = new Request.Builder()
                .url(url)
                .build();
        Response response = httpClient.newCall(request).execute();
        return response.body().string(); // 返回的是string 类型，json的mapper可以直接处理
    }
 
    public static String httpJsonPost(String url, String json) throws IOException {
        OkHttpClient httpClient = new OkHttpClient();
        RequestBody requestBody = RequestBody.create(JSON, json);
        Request request = new Request.Builder()
                .url(url)
                .post(requestBody)
                .build();
        Response response = httpClient.newCall(request).execute();
        return response.body().string();
    }
    
    public static String httpPost(String url, Map<String,Object> params) throws IOException {
        OkHttpClient httpClient = new OkHttpClient();
        Builder builder = new FormBody.Builder();
        for (Entry<String,Object> param : params.entrySet()) {
        	builder.add(param.getKey(), param.getValue().toString());
		}
        FormBody formBody = builder.build();
        Request request = new Request.Builder()
                .url(url)
                .post(formBody)
                .build();
        Response response = httpClient.newCall(request).execute();
        return response.body().string();
    }
}
