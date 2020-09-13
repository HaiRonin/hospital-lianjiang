package com.jingbao.webservice;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;

public class CXFClient {
	
	private static final String WSDL_LOCATION = "http://qkbtest.17lf.com:8080/services/HisUser?wsdl";

	public static Object[] call(String funcName, Object...params) throws Exception {
		JaxWsDynamicClientFactory clientFactory = JaxWsDynamicClientFactory.newInstance();
		
		Client client = clientFactory.createClient(WSDL_LOCATION);
		
		return client.invoke(funcName, params);
		
	}
}
