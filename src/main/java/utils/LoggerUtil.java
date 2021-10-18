package utils;

public class LoggerUtil {

    /**
     * 用于将exception转化为String输出到日志中
     * @param ex
     * @return
     */
    public static String getStackTraceString(Throwable ex){
        StackTraceElement[] traceElements=ex.getStackTrace();

        StringBuilder traceBuilder=new StringBuilder();

        if(traceElements != null && traceElements.length>0){
            for(StackTraceElement traceElement : traceElements){
                traceBuilder.append(traceElement.toString());
                traceBuilder.append("\n");
            }
        }
        return traceBuilder.toString();
    }
}
