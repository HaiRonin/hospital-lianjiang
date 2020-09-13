package com.jingbao.auto;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

/**
 * 时间格式�?
 */
public class DateUtil {
	private static String[] weeks_total = { "星期日", "星期一", "星期二", "星期三", "星期四","星期五", "星期六", "今天" };
	public static final String yyMMdd = "yy-MM-dd";
	public static final String yyyyMMdd = "yyyy-MM-dd";
	public static final String HHmmss = "HH:mm:ss";
	public static final String HHmm = "HH:mm";
	public static final String yyMMddHHmmss = "yy-MM-dd HH:mm:ss";
	public static final String yyMMddHHmmssfilename = "yyyy-MM-dd_HH_mm_ss";
	public static final String yyyyMMddHHmm = "yyyy-MM-dd HH:mm";
	public static final String yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss";
	public static final String MMddHHmm = "MM-dd hh:mm aa";

	public static final String MMdd = "MM-dd";
	public static final String yyyyMM = "yyyy-MM";
	public static final String yyyyMMddhhmm = "yyyy-MM-dd hh:mm";
	public static final String yyyymm = "yyyy-MM";
	public static final String yyyymmdd = "yyyy-MM-dd";
	public static final String yyyymmdd_CN = "MM月dd日";
	
	public static final String WEIXNTIME="yyyyMMddHHmmss";

	public static Date parseToDate(String s, String style) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
		simpleDateFormat.applyPattern(style);
		Date date = null;
		if (s == null || s.length() < 5)
			return null;
		try {
			date = simpleDateFormat.parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static long getTimeStamp(String date) {
		long epoch = 0L;
		try {
			epoch = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
					.parse(date).getTime() / 1000L;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return epoch;
	}
	
	public static String getCurrtime(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String currTime=df.format(new Date());// new Date()为获取当前系统时间
		return currTime;
	}
	

	public static long parseToDateLong(String s, String style) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
		simpleDateFormat.applyPattern(style);
		Date date = null;
		if (s == null || s.length() < 5)
			return 0;
		try {
			date = simpleDateFormat.parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date.getTime();
	}

	public static Date parseToTimesDate(String sTime) {
		Date date = null;
		if (sTime == null || "".equals(sTime)) {
			return null;
		}
		date = Timestamp.valueOf(sTime);
		return date;
	}

	public static String parseToString(String s, String style) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
		simpleDateFormat.applyPattern(style);
		Date date = null;
		String str = null;
		if (s == null || s.length() < 8)
			return null;
		try {
			date = simpleDateFormat.parse(s);
			str = simpleDateFormat.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return str;
	}

	public static String parseToString(Date date, String style) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
		simpleDateFormat.applyPattern(style);
		String str = null;
		if (date == null)
			return null;
		str = simpleDateFormat.format(date);
		return str;
	}

	public static String getNowTime() {
		Date nowDate = new Date();
		Calendar now = Calendar.getInstance();
		now.setTime(nowDate);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str = formatter.format(now.getTime());
		return str;
	}
	
	public static String getNowTimeStr(){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String str = formatter.format(System.currentTimeMillis());
		return str;
	}

	public static String parseToString(long curentTime) {
		Calendar now = Calendar.getInstance();
		now.setTimeInMillis(curentTime);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str = formatter.format(now.getTime());
		return str;
	}

	public static String parseToString(long curentTime, String style) {
		Calendar now = Calendar.getInstance();
		now.setTimeInMillis(curentTime);
		SimpleDateFormat formatter = new SimpleDateFormat(style);
		String str = formatter.format(now.getTime());
		return str;
	}

	public static String parseToHHString(long curentTime) {
		Calendar now = Calendar.getInstance();
		now.setTimeInMillis(curentTime);
		SimpleDateFormat formatter = new SimpleDateFormat("HH");
		String str = formatter.format(now.getTime());
		return str;
	}

	public static String parseTommString(long curentTime) {
		Calendar now = Calendar.getInstance();
		now.setTimeInMillis(curentTime);
		SimpleDateFormat formatter = new SimpleDateFormat("mm");
		String str = formatter.format(now.getTime());
		return str;
	}

	public static String parseToDate(long time) {
		Calendar now = Calendar.getInstance();
		now.setTimeInMillis(time);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String str = formatter.format(now.getTime());
		return str;
	}

	public static String parseToMD(long time) {
		Calendar now = Calendar.getInstance();
		now.setTimeInMillis(time);
		SimpleDateFormat formatter = new SimpleDateFormat("MM-dd");
		String str = formatter.format(now.getTime());
		return str;
	}

	public static String getNowShortTime() {
		Date nowDate = new Date();
		Calendar now = Calendar.getInstance();
		now.setTime(nowDate);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String str = formatter.format(now.getTime());
		return str;
	}

	public static String getNextDate(String ts, int i) {
		Calendar now = Calendar.getInstance();
		Timestamp t = Timestamp.valueOf(ts + " 00:00:00");
		now.setTime(t);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		now.add(Calendar.DAY_OF_MONTH, +(i));
		String dt = formatter.format(now.getTime());
		return dt;
	}

	public static String getBeforeDate(Date date,int i){
		Calendar calendar = new GregorianCalendar();  
		calendar.setTime(date);  
		calendar.add(calendar.DATE,i);//把日期往后增加一天.整数往后推,负数往前移动  
		date=calendar.getTime(); //这个时间就是日期往后推一天的结果   
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
		String dateString = formatter.format(date);  
		return dateString;
	}
	
	public static String getNextTime(String ts, int i) {
		Calendar now = Calendar.getInstance();
		Timestamp t = Timestamp.valueOf(ts);
		System.out.println(t + "     " + ts);
		now.setTime(t);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		now.add(Calendar.MINUTE, +(i));
		String dt = formatter.format(now.getTime());
		return dt;
	}

	public static long formatDateMills(String s, String style) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat();
		simpleDateFormat.applyPattern(style);
		Date date = null;
		if (s == null || s.length() < 5)
			return 0;
		try {
			date = simpleDateFormat.parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date.getTime();
	}

	public static String getSendTimeDistance1(long sendTime) {
		String timeDistance = "";
		// 时间差
		long time = System.currentTimeMillis() - sendTime;
		// 判断时间是否大于一天
		if (time < (24 * 60 * 60 * 1000)) {
			// 判断时间是否大于一小时
			if (time > (60 * 60 * 1000)) {
				timeDistance = DateUtil.parseToHHString(time) + "小时前";
			} else {
				timeDistance = DateUtil.parseTommString(time) + "分钟前";
			}
		} else {
			timeDistance = DateUtil.parseToMD(sendTime);
		}
		return timeDistance;
	}

	public static long getPreTime(int year, int month, int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.add(Calendar.DATE, day);
		calendar.add(Calendar.MONTH, month);
		calendar.add(Calendar.YEAR, year);
		return calendar.getTimeInMillis();
	}

	/**
	 * 判断是否超过半小时
	 */
	public static boolean isTimeoutHalfhour(long longtime) {
		return (System.currentTimeMillis() - longtime) > 30 * 60 * 1000;
	}

	/**
	 * 判断是否在24小时内
	 * 
	 * @param longtime
	 * @return
	 */
	public static boolean isTimeoutIn24hour(long longtime) {
		Calendar cstart = Calendar.getInstance();
		cstart.set(Calendar.HOUR, 0);
		cstart.set(Calendar.MINUTE, 0);
		cstart.set(Calendar.SECOND, 0);
		return cstart.getTimeInMillis() <= longtime&& (cstart.getTimeInMillis() + 24 * 60 * 60 * 1000) > longtime;
	}

	/**
	 * 获取时间段
	 * 
	 * @param start
	 * @param end
	 * @return
	 */
	public static String getTimeBucket(int start, int end) {
		return String.format("%s:00 - %s:00", new Object[] { start, end });
	}

	public static String getWeeksNameTotal(long time) {
		Calendar c1 = Calendar.getInstance();// 当天
		Calendar c2 = Calendar.getInstance();// 当天
		c2.setTimeInMillis(time);
		if (c1.get(Calendar.YEAR) == c2.get(Calendar.YEAR)
				&& c1.get(Calendar.MONTH) == c2.get(Calendar.MONTH)
				&& c1.get(Calendar.DAY_OF_MONTH) == c2
						.get(Calendar.DAY_OF_MONTH)) {
			return weeks_total[7];
		}
		return weeks_total[(c2.get(Calendar.DAY_OF_WEEK) - 1) % 7];
	}

	// 获得当天0点时间
	public static long getTimesmorning() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTimeInMillis() / 1000;
	}

	// 获得当天24点时间
	public static long getTimesnight() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.HOUR_OF_DAY, 24);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTimeInMillis() / 1000;
	}
	
	/**
	 * 获取当前时间戳
	 * @return
	 */
	public static long getNowTimeStamp(){
		return System.currentTimeMillis()/1000;
	}

	public static void main(String[] args) {
		System.out.println(getBeforeDate(new Date(), -4));
	}

}