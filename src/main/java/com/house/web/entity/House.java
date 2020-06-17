package com.house.web.entity;

import java.io.File;

import lombok.Data;

@Data
public class House {
	private int id;
	private String name; 
	private String real_price; 
	private String gu; 
	private String dong; 
	private String full_address; 
	private String mortgage; 
	private String about; 
	private String bus; 
	private String subway;
	private String house_info;
	private String floor; 
	private String full_floor;
	private String charter_monthly;
	private String host; 
	private String lessee; 
	private String reg_date; 
	private String incident_num; 
	private String purpose; 
	private String appraisal_amount; 
	private String row_appraisal_amount;
	private String progress; 
	private String date_of_sale; 
	private String remark; 
	private String incident_case; 
	private String start; 
	private String dividend_request_date; 
	private String billing_amount; 
	private String file_real_name;
	private String file_path;
	private String house_num;
	private File up;

}
