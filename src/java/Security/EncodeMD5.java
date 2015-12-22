package Security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.jsp.tagext.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.*;

public class EncodeMD5 extends TagSupport{
   private String password;
   private String var;
   private static final char[] CONSTS_HEX = { '0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f' };
   
   public void setPassword(String pss) {
      this.password = pss;
   }
   public void setVar(String var) {
      this.var = var;
   }
   
   public int doStartTag() throws JspException {
        JspWriter out = pageContext.getOut();
        pageContext.setAttribute(var, encodeMD5(password) );
        return SKIP_BODY;
  }
    
   public static String encodeMD5(String message)    {
        try{
           MessageDigest msgd = MessageDigest.getInstance("MD5");
           byte[] bytes = msgd.digest(message.getBytes());
           StringBuilder strbStringMd5 = new StringBuilder(2 * bytes.length);
           for (int i = 0; i < bytes.length; i++)
           {
               int bajo = (int)(bytes[i] & 0x0f);
               int alto = (int)((bytes[i] & 0xf0) >> 4);
               strbStringMd5.append(CONSTS_HEX[alto]);
               strbStringMd5.append(CONSTS_HEX[bajo]);
           }
           return strbStringMd5.toString();
        }catch (NoSuchAlgorithmException e) {
           return null;
        }
    }
    
}