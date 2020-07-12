/**
 * 
 */
package com.jarvis.service;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jarvis.entity.User;


public class MailService {

	public static void sendMailToOnlineFeedbackUser(String from, String subject,
			String body, String cc, User user) throws Exception {
		
		Log log = LogFactory.getLog(MailService.class);
		String to = user.getEmail();
		String[] recipients = convertStSL(to);
		byte[] message = body.getBytes();
		String massageByteArrayToString = null;
		try {
			massageByteArrayToString = new String(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//Set the host smtp address
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host","smtp.gmail.com");
		props.put("mail.smtp.port","587");
		props.put("mail.smtp.auth", "true");
		Authenticator auth = new SMTPAuthenticator();
		
		// create some properties and get the default Session
		Session session = Session.getDefaultInstance(props, auth);
		session.setDebug(false);

		// create a message
		Message msg = new MimeMessage(session);

		// set the from address
		InternetAddress addressFrom = new InternetAddress(from);
		msg.setFrom(addressFrom);
		
		if (to!=null && !to.equals("")) {
			InternetAddress[] addressTo = new InternetAddress[recipients.length];
			for (int i = 0; i < recipients.length; i++) {
				addressTo[i] = new InternetAddress(recipients[i]);
				log.info("Mail TO------------------->"+addressTo[i]);
				}
			msg.setRecipients(Message.RecipientType.TO, addressTo);
			}
		
		// set the cc  address
		if (cc!=null && !cc.equals("")) {
			String[] recipientsCc = convertStSL(cc);
			InternetAddress[] addressCc = new InternetAddress[recipientsCc.length];
			for (int i = 0; i < recipientsCc.length; i++) {
				addressCc[i] = new InternetAddress(recipientsCc[i]);
				log.info("Mail CC------------------->"+addressCc[i]);
			}
			msg.setRecipients(Message.RecipientType.CC, addressCc);
		}
		
		msg.addHeader("MyHeaderName", "myHeaderValue");

		// Setting the Subject and Content Type
		if (subject!=null && !subject.equals("")) {
			msg.setSubject(subject);
		}
		
		Multipart mp = new MimeMultipart();
		// create and fill the first message part
	      MimeBodyPart mbp = new MimeBodyPart();
	      //mbp1.setText(content);
	      mbp.setContent(massageByteArrayToString, "text/html");
	      mp.addBodyPart(mbp);
	      
	      msg.setContent(mp);
	      System.out.println("Mail is going to shoot ....");
		 Transport.send(msg);
	}
	
	
	private static class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			String SMTP_AUTH_USER = "confitechsol@gmail.com";
			String SMTP_AUTH_PWD = "passwd@21";
			return new PasswordAuthentication(SMTP_AUTH_USER, SMTP_AUTH_PWD);
		}
	}
	
	private static String[] convertStSL(String tlist) {

		String[] reqArray = tlist.split(",");

		return reqArray;
	}
	
	public static void main(String[] args) throws Exception {
		
		//sendMailToOnlineFeedbackUser("admin@eforceglobal.com", "suchakraborty@eforceglobal.com" , "Test Mail", "BODDDDDDDY" , "" , null);
	}
}
