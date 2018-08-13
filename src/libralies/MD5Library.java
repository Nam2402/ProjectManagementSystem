package libralies;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;


public class MD5Library {
		
	public static String md5(String str){
		String result = "";
		MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("MD5");
			digest.update(str.getBytes());
			BigInteger bigInteger = new BigInteger(1,digest.digest());
			result = bigInteger.toString(16);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static String getRandomPwd() {
		String UPPERCHARS= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String LOWERCHARS= "abcdefghijklmnopqrstuvwxyz";
		String SPECIALCHARS= "!@#$%^&*";
		String DIGIT="1234567890";
        String ALLCHARS= UPPERCHARS + LOWERCHARS + SPECIALCHARS + DIGIT;
        
        StringBuilder pwd = new StringBuilder();
        
        Random rnd = new Random();
        
		while (pwd.length() < 1) {
			int index = (int) (rnd.nextFloat() * UPPERCHARS.length());
			pwd.append(UPPERCHARS.charAt(index));
		}
		while (pwd.length() < 2) {
			int index = (int) (rnd.nextFloat() * LOWERCHARS.length());
			pwd.append(LOWERCHARS.charAt(index));
		}
		while (pwd.length() < 3) {
			int index = (int) (rnd.nextFloat() * SPECIALCHARS.length());
			pwd.append(SPECIALCHARS.charAt(index));
		}
		while (pwd.length() < 4) {
			int index = (int) (rnd.nextFloat() * DIGIT.length());
			pwd.append(DIGIT.charAt(index));
		}
		while (pwd.length() < 8) {
			int index = (int) (rnd.nextFloat() * ALLCHARS.length());
			pwd.append(ALLCHARS.charAt(index));
		}
		
		String pwdStr = pwd.toString();
		return pwdStr;
    }
	
	public static String getHashCode() {
		String UPPERCHARS= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String LOWERCHARS= "abcdefghijklmnopqrstuvwxyz";
		String DIGIT="1234567890";
        String ALLCHARS= UPPERCHARS + LOWERCHARS + DIGIT;
        
        StringBuilder pwd = new StringBuilder();
        
        Random rnd = new Random();
        
		while (pwd.length() < 10) {
			int index = (int) (rnd.nextFloat() * ALLCHARS.length());
			pwd.append(ALLCHARS.charAt(index));
		}
		
		
		String pwdStr = pwd.toString();
		return pwdStr;
    }
}
