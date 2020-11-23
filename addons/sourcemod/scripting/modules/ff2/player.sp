
methodmap FF2Player < VSH2Player {
	property bool Valid {
		public get() { return this != INVALID_FF2PLAYER && this.index; }
	}
	
	public FF2Player(const int index, bool userid = false) {
		if( !index ) {
			return ZeroBossToFF2Player();
		}
		return view_as< FF2Player >(VSH2Player(index, userid));
	}
	
	property ConfigMap iCfg {
		public get() { 
			return GetFF2Config(this);
		}
	}
	
	property int iBossType {
		public get() { return this.GetPropInt("iBossType"); }
	}
	
	property float flRAGE {
		public get() {
			return this.GetPropFloat("flRAGE");
		}
		public set(const float val) {
			this.SetPropFloat("flRAGE", val);
		}
	}
	
	property int iLives {
		public get() {
			return this.GetPropInt("iLives");
		}
		public set(const int val) {
			this.SetPropInt("iLives", val);
		}
	}
	
	property int iMaxLives {
		public get() {
			return this.GetPropInt("iMaxLives");
		}
		public set(const int val) {
			this.SetPropInt("iMaxLives", val);
		}
	}
	
	property FF2AbilityList HookedAbilities {
		public get() {
			return GetFF2AbilityList(this);
		}
	}
	
	property bool bNoSuperJump {
		public get() { 
			return this.GetPropAny("bNoSuperJump");
		}
		public set(bool state) {
			this.SetPropAny("bNoSuperJump", state);
		}
	}
	
	property bool bNoWeighdown {
		public get() { 
			return this.GetPropAny("bNoWeighdown");
		}
		public set(bool state) {
			this.SetPropAny("bNoWeighdown", state);
		}
	}
	
	property bool bHideHUD {
		public get() { 
			return this.GetPropAny("bHideHUD");
		}
		public set(bool state) {
			this.SetPropAny("bHideHUD", state);
		}
	}
	
	public float GetRageVar(FF2RageType_t type) {
		switch( type ) {
			case RT_RAGE: 		return this.GetPropFloat("flRAGE");
			case RT_CHARGE: 	return this.GetPropFloat("flCharge");
			case RT_WEIGHDOWN: 	return this.GetPropFloat("flWeighDown");
			default: {
				static char key[64]; FormatEx(key, sizeof(key), "flCharge%i", type);
				return this.GetPropFloat(key);
			}
		}
	}
	
	public void SetRageVar(FF2RageType_t type, float val) {
		switch( type ) {
			case RT_RAGE: 		this.SetPropFloat("flRAGE", val);
			case RT_CHARGE: 	this.SetPropFloat("flCharge", val);
			case RT_WEIGHDOWN: 	this.SetPropFloat("flWeighDown", val);
			default: {
				static char key[64]; FormatEx(key, sizeof(key), "flCharge%i", type);
				this.SetPropFloat(key, val);
			}
		}
	}
	
	public void PlayBGM(const char[] music) {
		this.PlayMusic(ff2.m_cvars.m_flmusicvol.FloatValue, music);
	}
}

static ConfigMap GetFF2Config(FF2Player player)
{
	static FF2Identity id;
	return ( ff2_cfgmgr.FindIdentity(player.iBossType, id) ? id.hCfg.GetSection("character"):null );
}

static FF2AbilityList GetFF2AbilityList(FF2Player player)
{
	static FF2Identity id;
	return ( ff2_cfgmgr.FindIdentity(player.iBossType, id) ? id.ablist:null );
}