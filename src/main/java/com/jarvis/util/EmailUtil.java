/**
 * 
 */
package com.jarvis.util;

import java.util.Date;
import java.util.Hashtable;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.jarvis.common.Constants;




/**
 * @author msaugata
 *
 */
public class EmailUtil {

	public static final String CC = "cc";
	public static final String BCC = "bcc";
	public static final String FROM = "from";
	public static final String TO = "to";
	public static final String SUBJECT = "subject";
	public static final String BODY = "body";

	private static Hashtable DEFAULT_SETTINGS = new Hashtable();

	static {
		DEFAULT_SETTINGS.put("mail.transport.protocol", "smtp");
		DEFAULT_SETTINGS.put("mail.smtp.host", Constants.MAIL_HOST);
		DEFAULT_SETTINGS.put(FROM, Constants.MAIL_FROM);
		DEFAULT_SETTINGS.put(BODY, "no body");
		DEFAULT_SETTINGS.put(SUBJECT, "no subject");
	}

	/**
	 * Static Method: sendmail(Map mail)
	 *
	 * @param  mail A map of the settings
	 */
	public static void sendmail(Map mail) throws Exception {
		Authenticator auth = null;
		Properties props = new Properties();

		props.put( "mail.transport.protocol", EmailUtil.returnDefault(mail, "mail.transport.protocol") );
		props.put( "mail.smtp.host", EmailUtil.returnDefault(mail, "mail.smtp.host") );
		props.put("mail.smtp.auth", "false");

		/*if (Constants.IS_MAIL_AUTHENTICATE.equals("true")) {
			props.put("mail.smtp.auth", "true");
			auth = new SMTPAuthenticator();
		}*/

		Session session = Session.getDefaultInstance(props, auth);

		Message msg = new MimeMessage(session);

		msg.setFrom(new InternetAddress( EmailUtil.returnDefault(mail,FROM) ) );
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(EmailUtil.returnDefault(mail,TO)));

		String cc  = (String) mail.get(CC);
		String bcc = (String) mail.get(BCC);
		if (cc != null &&  (!cc.trim().equals("")))  msg.setRecipients(Message.RecipientType.CC,  InternetAddress.parse(cc,  false));
		if (bcc != null && (!bcc.trim().equals(""))) msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));

		msg.setSubject(EmailUtil.returnDefault(mail,SUBJECT));
		msg.setSentDate(new Date());
		msg.setText(EmailUtil.returnDefault(mail,BODY));

		Transport.send(msg);
	}


	/**
	 * Static Method: returnDefault(map, key)
	 *
	 * @param  map		Map
	 * @param  value	String
	 * @param  default	String
	 *
	 * @return the value, or the default value if the value is null
	 */
	private static String returnDefault(Map map, String key) {
		String value = (String) map.get(key);
		String realValue = (String) ( (value == null) ? DEFAULT_SETTINGS.get(key) : value );
		return realValue;
	}

	/**
	 * SimpleAuthenticator is used to do simple authentication when the SMTP
	 * server requires it.
	 */
	private static class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			String SMTP_AUTH_USER = Constants.AUTH_UID;
			String SMTP_AUTH_PWD = Constants.AUTH_PWD;
			return new PasswordAuthentication(SMTP_AUTH_USER, SMTP_AUTH_PWD);
		}
	}	



}
