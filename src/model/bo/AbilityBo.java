package model.bo;

import model.bean.Ability;
import model.dao.AbilityDao;

public class AbilityBo {
	AbilityDao abilityDao= new AbilityDao();
	public Ability getAbilityByUserId(int userId){
		return abilityDao.getAbilityByUserID(userId);
	}
	
	public void addTrainerAbility(Ability ability){
		abilityDao.addTrainerAbility(ability);
	}
	
	public void editTrainerAbility(Ability ability){
		abilityDao.editTrainerAbility(ability);
	}

}
