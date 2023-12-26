package com.ezen.buybuy.api;

import java.net.URI;
import java.util.Collections;

import org.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

public class ImgurBO {
	private final String API_URI = "https://api.imgur.com/3/image?privacy=private";
	private final String CLIENT_ID = "32e50e1b9e984d9";
	private final String CLIENT_SECRET = "8e3f8ab6aaadf8e12e6468d0147839ffaeee7478";
	private final String REDIRECT_URI = "http://localhost:8080/buybuy/imgur";

	RestTemplate restTemplate = new RestTemplate();

	public String requestUpload(byte[] imageData) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		headers.set("Authorization", "Client-ID " + CLIENT_ID);
		headers.set("privacy", "private");
		
		RequestEntity<byte[]> requestEntity = new RequestEntity<byte[]>(imageData, headers, HttpMethod.POST, URI.create(API_URI));
		ResponseEntity<String> responseEntity = restTemplate.exchange(requestEntity, String.class);
		
		JSONObject jsonResponse = new JSONObject(responseEntity.getBody());
        String uploadedImageUrl = jsonResponse.getJSONObject("data").getString("link");
		
		return uploadedImageUrl;
	}
}
