package com.debbie.twapit.validators;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.debbie.twapit.models.User;
import com.debbie.twapit.repositories.UserRepo;

@Component
public class UserValidator implements Validator {
	private UserRepo userRepo;
	
	public UserValidator(UserRepo userRepo) {
		this.userRepo = userRepo;
	}
	
	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}
	
	@Override
	public void validate(Object object, Errors errors) {
		User user = (User) object;
		
		if(!user.getPasswordConfirmation().equals(user.getPassword())) {
			errors.rejectValue("passwordConfirmation", "Match");
		}
		
		User userCheck = userRepo.findByEmail(user.getEmail());
		if(userCheck != null) {
			errors.rejectValue("email", "Check");
		}
		
		Pattern p = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
		Matcher matcher = p.matcher(user.getEmail());
        if(!matcher.matches()) {
        		errors.rejectValue("email", "Invalid");
        }
        
//        Pattern passPattern = Pattern.compile("((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%]).{6,20})");
//        Matcher passMatcher = passPattern.matcher(user.getPassword());
//        if (!passMatcher.matches()) {
//            errors.rejectValue("password", "Invalid");
//        }
            
	}
}
