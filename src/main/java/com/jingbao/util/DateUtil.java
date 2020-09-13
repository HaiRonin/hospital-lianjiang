package com.jingbao.util;


import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * 时间工具类
 *
 * @author syy
 * @date 2017/6/21
 */
public class DateUtil {
    public static final String FORMAT_NORMAL = "yyyy-MM-dd HH:mm:ss";
    public static final String FORMAT_NORMAL_MIN = "yyyy-MM-dd HH:mm";
    public static final String FORMAT_LONGDATETIME = "yyyy-MM-dd HH:mm:ss.SSS";
    public static final String FORMAT_SHORTDATETIME = "yyyy-MM-dd";
    public static final String FORMAT_SHORTDATETIME_SPLIT = "yyyy/MM/dd";
    public static final String FORMAT_SHORTDATETIME_SPLIT_TWO = "yyyy/MM/dd HH:mm";
    public static final String FORMAT_YEAR_MONTH = "yyyy-MM";
    public static final String FORMAT_YEAR_MONTH2 = "yyyyMM";
    public static final String FORMAT_SHORTDATETIME2 = "yyyyMMdd";
    public static final String FORMAT_LONGDATETIME_COMPACT = "yyyyMMddHHmmssSSS";
    public static final String FORMAT_SHORTDATETIME_COMPACT = "yyyyMMdd";
    public static final String FORMAT_FILENAMEL = "yyyyMMdd_HHmmss";
    public static final String FORMAT_YEAR = "yyyy";
    public static final String FORMAT_MONTH_DAY = "MM-dd";
    public static final String FORMAT_HOURTIME = "HH:mm";


    /**
     * 获取当前时间的前/后某个时间 如取当前前11分钟：DateUtil.nowDateChange(Calendar.MINUTE,-11);
     *
     * @param oFlag  单位标识，如Calendar.MINUTE
     * @param amount 差值
     * @return
     */
    public static Date nowDateChange(int oFlag, int amount) {
        return dateChange(new Date(), oFlag, amount);
    }


    /**
     *  * @param 返回java.sql.Time格式的
     *  *
     */
    public static Time strToTime(String strDate) {
        String str = strDate;
        SimpleDateFormat format = new SimpleDateFormat("hh:mm");
        Date d = null;
        try {
            d = format.parse(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Time date = new Time(d.getTime());
        return date;
    }


    //没注释卧槽
    public static Date getNextDateToMinute(String ts, int i) {
        System.out.println(ts);
        Calendar now = Calendar.getInstance();
        Timestamp t = Timestamp.valueOf(ts);
        System.out.println("t》》》》》》》》》》》》》》》" + t);
        now.setTime(t);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        now.add(Calendar.MINUTE, +(i));
        String dt = formatter.format(now.getTime());

        Date strParseDate = strParseDate(dt, "yyyy-MM-dd HH:mm:ss");
        return strParseDate;
    }

    //没注释卧槽
    public static String getNowTimeStr() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String str = formatter.format(System.currentTimeMillis());
        return str;
    }

    //没注释卧槽
    public static Date strParseDate(String time, String style) {
        SimpleDateFormat sdf = new SimpleDateFormat(style);
        Date parse = null;
        try {
            parse = sdf.parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return parse;
    }


    //没注释卧槽
    public static Date strParseDate2(String time, String style) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(style);
        Date parse = null;

        parse = sdf.parse(time);

        return parse;
    }


    //没注释卧槽
    public static Date getNextDate(Date date, int i) {
        Calendar now = Calendar.getInstance();
        now.setTime(date);
        now.add(Calendar.DAY_OF_MONTH, +(i));
        Date time = now.getTime();
        return time;
    }

    public static Date getNextYear(Date date, int i) {
        Calendar now = Calendar.getInstance();
        now.setTime(date);
        now.add(Calendar.YEAR, +(i));
        Date time = now.getTime();
        return time;
    }

    //没注释卧槽
    public static String getNextDateToStr(Date date, int i) {
        Calendar now = Calendar.getInstance();
        now.setTime(date);
        now.add(Calendar.DAY_OF_MONTH, +(i));
//        Date time = now.getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dt = formatter.format(now.getTime());

        return dt;
    }


    /**
     * 取指定时间的前/后某个时间 如取当前前11分钟：DateUtil.nowDateChange(new
     * Date(),Calendar.MINUTE,-11);
     *
     * @param date
     * @param oFlag  单位标识，如Calendar.MINUTE
     * @param amount 差值
     * @return
     */
    public static Date dateChange(Date date, int oFlag, int amount) {
        Date curDateTime = null;
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            cal.add(oFlag, amount);
            curDateTime = new Date(cal.getTimeInMillis());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return curDateTime;
    }

    /**
     * 格式化Date日期对象为指定格式字符串
     *
     * @param argDate
     * @param fFlag   格式：如 DateUtil.FORMAT_NORMAL_DETAIL
     * @return
     */
    public static String getStringFormatByDate(Date argDate, String fFlag) {
        String strDateTime = "";
        try {
            SimpleDateFormat objSDF = new SimpleDateFormat(fFlag.trim());
            strDateTime = objSDF.format(argDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return strDateTime;
    }

    //没注释卧槽
    public static String getString(Date argDate, String fFlag) {
        SimpleDateFormat objSDF = new SimpleDateFormat(fFlag.trim());
        return objSDF.format(argDate);
    }


    /**
     * 获取当前时间字符串
     *
     * @return
     */
    public static String getNowDateStr() {
        return getStringFormatByDate(new Date(), DateUtil.FORMAT_NORMAL);
    }

    /**
     * 获取现在时间
     *
     * @return返回长时间格式 yyyy-MM-dd HH:mm:ss
     */
    public static String getNowDate() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateString = formatter.format(currentTime);
        return dateString;
    }

    public static String getNowDateForYyyyMm() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
        String dateString = formatter.format(currentTime);
        return dateString;
    }


    public static Date parse(String dateString, String pattern) throws ParseException {
        SimpleDateFormat objSDF = new SimpleDateFormat(pattern);
        return objSDF.parse(dateString);
    }

    public static Date getDate(Date value, String pattern) {
        String dateString = DateUtil.getStringFormatByDate(value, pattern);
        try {
            return DateUtil.parse(dateString, pattern);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * 获取YYYY格式
     *
     * @return
     */
    public static String getYear() {
        return new SimpleDateFormat(DateUtil.FORMAT_YEAR).format(new Date());
    }

    /**
     * 获取YYYY-MM-DD格式
     *
     * @return
     */
    public static String getDay() {
        return getDay(new Date());
    }

    public static String getDay(String format) {
        return getDay(new Date(), format);
    }

    /**
     * 获取生日日期MM-DD格式
     *
     * @param date
     * @return
     * @author YHQ
     */
    public static String getBirthDateFormatDate(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat(FORMAT_MONTH_DAY).format(date);
    }

    public static String getDay(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat(FORMAT_SHORTDATETIME).format(date);
    }

    public static String getDay(Date date, String format) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat(format).format(date);
    }


    /**
     * 获取YYYY-MM-DD HH:mm:ss格式
     *
     * @return
     */
    public static String getTime() {
        return new SimpleDateFormat(FORMAT_NORMAL).format(new Date());
    }

    /**
     * 获取YYYY-MM-DD HH:mm:ss格式的指定日期开始时间
     *
     * @return
     */
    public static String getBeginTime(Date date) {
        Calendar cur = Calendar.getInstance();
        cur.setTime(date);
        return getBeginTime(cur);
    }

    /**
     * 获取YYYY-MM-DD HH:mm:ss格式的指定日期结束时间
     *
     * @return
     */
    public static String getEndTime(Date date) {
        Calendar cur = Calendar.getInstance();
        cur.setTime(date);
        return getEndTime(cur);
    }

    /**
     * 获取YYYY-MM-DD HH:mm:ss格式的指定日期开始时间
     *
     * @return
     */
    public static String getBeginTime(Calendar cur) {
        cur.set(Calendar.HOUR_OF_DAY, 0);
        cur.set(Calendar.MINUTE, 0);
        cur.set(Calendar.SECOND, 0);
        cur.set(Calendar.MILLISECOND, 0);
        return new SimpleDateFormat(FORMAT_NORMAL).format(cur.getTime());
    }

    /**
     * 获取YYYY-MM-DD HH:mm:ss格式的指定日期结束时间
     *
     * @return
     */
    public static String getEndTime(Calendar cur) {
        cur.set(Calendar.HOUR_OF_DAY, 23);
        cur.set(Calendar.MINUTE, 59);
        cur.set(Calendar.SECOND, 59);
        cur.set(Calendar.MILLISECOND, 999);
        return new SimpleDateFormat(FORMAT_NORMAL).format(cur.getTime());
    }

    /**
     * @Title: compareDate @Description: @param s @param e @return
     * boolean @throws
     */
    public static boolean compareDate(String s, String e) {
        if (fomatDate(s) == null || fomatDate(e) == null) {
            return false;
        }
        return fomatDate(s).getTime() >= fomatDate(e).getTime();
    }

    /**
     * @Title: compareDate @Description: @param s @param e @return
     * boolean @throws
     */
    public static boolean compareDate(Date s, Date e) {
        if (s == null || e == null) {
            return false;
        }
        return s.getTime() >= e.getTime();
    }

    /**
     * 格式化日期
     *
     * @return
     */
    public static Date fomatDate(String date) {
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return fmt.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 格式化日期
     *
     * @param date
     * @param format 格式 例：yyyy-MM-dd HH:mm:ss
     * @return
     */
    public static Date fomatDate(String date, String format) {
        DateFormat fmt = new SimpleDateFormat(format);
        try {
            return fmt.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 校验日期是否合法
     *
     * @return
     */
    public static boolean isValidDate(String s) {
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        try {
            fmt.parse(s);
            return true;
        } catch (Exception e) {
            // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
            return false;
        }
    }

    /**
     * @param startTime
     * @param endTime
     * @return
     */
    public static int getDiffYear(String startTime, String endTime) {
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        try {
            // long aa=0;
            int years = (int) (((fmt.parse(endTime).getTime() - fmt.parse(startTime).getTime()) / (1000 * 60 * 60 * 24))
                    / 365);
            return years;
        } catch (Exception e) {
            // 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
            return 0;
        }
    }

    /**
     * <li>功能描述：时间相减得到天数
     *
     * @param beginDateStr
     * @param endDateStr
     * @return long
     * @author Administrator
     */
    public static long getDaySub(String beginDateStr, String endDateStr) {
        long day = 0;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date beginDate = null;
        Date endDate = null;

        try {
            beginDate = format.parse(beginDateStr);
            endDate = format.parse(endDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        day = (endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
        return getDaySub(beginDate, endDate);
    }

    public static long getDaySub(Date beginDate, Date endDate) {
        return (endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60 * 1000);
    }

    /**
     * 获取两个日期相隔天数：忽略时分秒影响
     *
     * @param begin
     * @param end
     * @return
     * @author YHQ
     */
    public static int getDateSub(Date begin, Date end) {
        Calendar begin1 = Calendar.getInstance();
        begin1.setTime(begin);
        Calendar end1 = Calendar.getInstance();
        end1.setTime(end);
        return getDateSub(begin1, end1);
    }

    /**
     * 获取两个日期相隔天数：忽略时分秒影响
     *
     * @param begin
     * @param end
     * @return
     * @author YHQ
     */
    public static int getDateSub(String beginDateStr, String endDateStr) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date beginDate = null;
        Date endDate = null;

        try {
            beginDate = format.parse(beginDateStr);
            endDate = format.parse(endDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return getDateSub(beginDate, endDate);
    }

    /**
     * 获取两个日期相隔天数：忽略时分秒影响
     *
     * @param begin
     * @param end
     * @return
     * @author YHQ
     */
    public static int getDateSub(Calendar begin, Calendar end) {
        return end.get(Calendar.DAY_OF_YEAR) - begin.get(Calendar.DAY_OF_YEAR);
    }


    /**
     * 得到n天之后的日期
     *
     * @param days
     * @return
     */
    public static String getAfterDayDate(String days) {
        int daysInt = Integer.parseInt(days);

        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();

        SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateStr = sdfd.format(date);

        return dateStr;
    }

    /**
     * 得到n天之后是周几
     *
     * @param days
     * @return
     */
    public static String getAfterDayWeek(String days) {
        int daysInt = Integer.parseInt(days);
        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("E");
        String dateStr = sdf.format(date);
        return dateStr;
    }


    //没注释卧槽
    public static long getDaySubtract(Date start, Date end) {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
//			Date d1 = df.parse("2004-03-26 13:31:40");
//			Date d2 = df.parse("2004-01-02 11:30:24");
            long diff = end.getTime() - start.getTime();//这样得到的差值是微秒级别
            long days = diff / (1000 * 60 * 60 * 24);

            long hours = (diff - days * (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
            long minutes = (diff - days * (1000 * 60 * 60 * 24) - hours * (1000 * 60 * 60)) / (1000 * 60);
            System.out.println("" + days + "天" + hours + "小时" + minutes + "分");
            return days;
        } catch (Exception e) {

        }
        return 0;
    }

    /**
     * 把前端传输的日期查询字符串转换成数据库用的字符串,(拼接00:00:00或23:59:59)
     * (解决比如前端传开始和结束传一样时 2018-01-01 ，直接在最上层就自动转为2018-01-01 00:00:00~2018-01-01 23:59:59，避免中途经过多种不同的业务产生某些问题)
     *
     * @param dateStr     前端传的日期（日期，不是具体时间，如:2018-01-01）
     * @param isStartDate 是否是开始时间
     * @return
     */
    public static String parseQueryDateStr(String dateStr, boolean isStartDate) {
//        if (StringUtils.isBlank(dateStr)){
//            return "";
//        }
        if (isStartDate) {
            return dateStr + " 00:00:00";
        } else {
            return dateStr + " 23:59:59";
        }
    }


    //没注释的卧槽
    public static String dateTo0String(Date date) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(date).trim();

    }

    public static String dateTo0String(Date date, String dataFrom) {
        SimpleDateFormat formatter = new SimpleDateFormat(dataFrom);
        return formatter.format(date).trim();

    }

    /**
     * 获取前端显示的实际年龄字符串
     *
     * @param birthday 生日
     * @return
     */
    public static String getAgeStr(Date birthday) {
        //没填生日，返回空
        if (birthday == null) {
            return "";
        }
        int age = 0;
        try {
            Calendar now = Calendar.getInstance();
            now.setTime(new Date());// 当前时间

            Calendar birth = Calendar.getInstance();
            birth.setTime(birthday);

            if (birth.after(now)) {//如果传入的时间，在当前时间的后面，返回0岁
                age = 0;
            } else {
                age = now.get(Calendar.YEAR) - birth.get(Calendar.YEAR);
                /*if (now.get(Calendar.DAY_OF_YEAR) > birth.get(Calendar.DAY_OF_YEAR)) {
                    age += 1;
                }*/
            }
            return String.valueOf(age);
        } catch (Exception e) {
            return "";
        }

    }


    /**
     * 转换java.util.Date -> java.sql.TIme
     *
     * @param date
     * @return
     */
    public static Time changeDateToTime(Date date) {
        Time time = new Time(date.getTime());
        return time;
    }


    /**
     * date2比date1多的天数（包括隔年，闰年等判断）
     *
     * @param date1
     * @param date2
     * @return
     */
    public static int differentDays(Date date1, Date date2) {
        if (date1 == null || date2 == null) {
            return 0;
        }
        if (date1.after(date2)) {
            return 0;
        }

        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);

        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        int day1 = cal1.get(Calendar.DAY_OF_YEAR);
        int day2 = cal2.get(Calendar.DAY_OF_YEAR);

        int year1 = cal1.get(Calendar.YEAR);
        int year2 = cal2.get(Calendar.YEAR);
        if (year1 != year2) {
            //同一年
            int timeDistance = 0;
            for (int i = year1; i < year2; i++) {
                if (i % 4 == 0 && i % 100 != 0 || i % 400 == 0) {
                    //闰年
                    timeDistance += 366;
                } else {
                    //不是闰年
                    timeDistance += 365;
                }
            }

            return timeDistance + (day2 - day1);
        } else {
            return day2 - day1;
        }
    }

    /**
     * 获取某日期区间的所有日期  日期倒序
     *
     * @param startDate     开始日期
     * @param endDate       结束日期
     * @param dateFormat    日期格式,如 DateUtil.FORMAT_SHORTDATETIME  （需要和dateGroupType的分类对应）
     * @param dateGroupType 日期分组方式 0日，1月，2，年   TimeEnum类
     * @return 日期区间的每一天或月份区间的每个月或年份区间的每年
     */
    public static List<String> getDateSectionList(String startDate, String endDate, String dateFormat, int dateGroupType) {
        DateFormat format = new SimpleDateFormat(dateFormat);
        try {
            Date sDate = format.parse(startDate);
            Date eDate = format.parse(endDate);
            long start = sDate.getTime();
            long end = eDate.getTime();
            if (start > end) {
                return null;
            }
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(eDate);
            List<String> res = new LinkedList<>();
            while (end >= start) {
                res.add(format.format(calendar.getTime()));
                if (dateGroupType == 0) {
                    calendar.add(Calendar.DAY_OF_MONTH, -1);
                } else if (dateGroupType == 1) {
                    calendar.add(Calendar.MONTH, -1);
                } else {
                    calendar.add(Calendar.YEAR, -1);
                }

                end = calendar.getTimeInMillis();
            }
            return res;
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return null;
    }


    /**
     * 转换str -> Date类型，转换失败一定要抛出异常，用于检查日期格式
     *
     * @param time
     * @param style
     * @return
     * @throws ParseException
     */
    public static Date strToDateThrowExceptoin(String time, String style) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(style);
        Date parse = sdf.parse(time);
        return parse;
    }


    /**
     * 把字符串转为Date类型，进行多种日期格式匹配 （暂为：yyyy-MM-dd 或 yyyy/MM/dd 或 yyyy-MM-dd HH:mm:ss）
     *
     * @param dateStr
     * @return 如果失败，返回null，不抛异常
     */
    public static Date formatMoreStyleStrToDate(String dateStr) {
        Date result = null;
        // 是否格式化成功
        boolean isFormatSucc = true;
        try {
            result = DateUtil.strToDateThrowExceptoin(dateStr, DateUtil.FORMAT_SHORTDATETIME);
        } catch (Exception e) {
            isFormatSucc = false;
        }
        if (!isFormatSucc) {
            try {
                result = DateUtil.strToDateThrowExceptoin(dateStr, DateUtil.FORMAT_SHORTDATETIME_SPLIT);
            } catch (Exception e) {
                isFormatSucc = false;
            }
        }
        if (!isFormatSucc) {
            try {
                result = DateUtil.strToDateThrowExceptoin(dateStr, DateUtil.FORMAT_NORMAL);
            } catch (Exception e) {
                isFormatSucc = false;
            }
        }
        // ......

        return result;
    }


    /**
     * 获得某天最大时间 如 2017-10-15 23:59:59
     *
     * @param date
     * @return
     */
    public static Date getEndOfDay(Date date) {
        if (date == null) {
            return null;
        }
        /*LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.ofEpochMilli(date.getTime()), ZoneId.systemDefault());;
        LocalDateTime endOfDay = localDateTime.with(LocalTime.MAX);
        return Date.from(endOfDay.atZone(ZoneId.systemDefault()).toInstant());*/
        // MySQL数据库对于毫秒大于500的数据进行进位，上面的方法会直接变成明天的00:00:00，下面的才行
        Calendar calendarEnd = Calendar.getInstance();
        calendarEnd.setTime(date);
        calendarEnd.set(Calendar.HOUR_OF_DAY, 23);
        calendarEnd.set(Calendar.MINUTE, 59);
        calendarEnd.set(Calendar.SECOND, 59);
        calendarEnd.set(Calendar.MILLISECOND, 0);
        return calendarEnd.getTime();
    }

    /**
     * 获得某天最小时间 如 2017-10-15 00:00:00
     *
     * @param date
     * @return
     */
    public static Date getStartOfDay(Date date) {
        if (date == null) {
            return null;
        }
        LocalDateTime localDateTime = LocalDateTime.ofInstant(Instant.ofEpochMilli(date.getTime()), ZoneId.systemDefault());
        LocalDateTime startOfDay = localDateTime.with(LocalTime.MIN);
        return Date.from(startOfDay.atZone(ZoneId.systemDefault()).toInstant());
    }

    /**
     * 获取指定日期的年月日，(jdk8推荐日期类)
     *
     * @param date 指定日期
     * @return 日期信息数组，索引 0:年份 1：月份 2：日
     */
    public static int[] getYearMonthDay(Date date) {
        int[] result = new int[3];
        Instant instant = date.toInstant();
        ZoneId zone = ZoneId.systemDefault();
        LocalDateTime ldt = LocalDateTime.ofInstant(instant, zone);
        result[0] = ldt.getYear();
        result[1] = ldt.getMonth().getValue();
        result[2] = ldt.getDayOfMonth();
        return result;
    }


    public static Date getStartMonth() {
        Calendar cal = Calendar.getInstance();
        cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONDAY), cal.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
        return cal.getTime();
    }


    public static boolean isToday(Date date) {
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        if (fmt.format(date).toString().equals(fmt.format(new Date()).toString())) {//格式化为相同格式
            return true;
        } else {
            return false;
        }

    }
}
