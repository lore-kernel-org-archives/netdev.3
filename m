Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF5346ADA
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787200501; cv=none; b=kJKrISwdHE8RIle4nn27zQivjMUDAFm0/LF/KeU3AdhWt3MkfFb4lFBK866u3dbiu7oSn+/8yKg3gPVSsWQWGlqr0aWZaIz3UwQQEkI06rFQCku1MF07C6EB+MgQlfvWXIe5RfkR+5Hao4giNm3JAGenpZshKqz2vxBVUD7R68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787200501; c=relaxed/simple;
	bh=GvtSTZxk6c1AET8skQRQ6AlY97BVrDfltIxcfZmExtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA4+BH5arIvKh2GxK3cPrjbgsKtpFc1d++IaPLLFiesdiiyKHJ9CLrNEBD9eyVa1D3OmIrd0hJItPv75Q9ee1TnOkLNKBLIFod3jiEgEf4NWt6GaDkhvbaF8snDYbiJMfv20C9BCJiCk6gOICIAMeEchJsEogyWep3n5PIOgKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PX9RSFoV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PX9RSFoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787200498; x=1818736498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GvtSTZxk6c1AET8skQRQ6AlY97BVrDfltIxcfZmExtI=;
  b=PX9RSFoV+7MEkcl9pEh0ebqw6eqPMVxgSIr5TPUJtNiOiK2KbhZZBJoW
   todsJr0qjBz/zF/cyx86zByahrTwP26JGF81gxmDkb+zm7VSW3JFgXGuE
   gE4UuvzPo8c4+qAQCBVU/Pr2Ve1OeWNc0GGkTHcsyaYjP2UKMs+kh3jRJ
   q013oeRAK5bDYJeNwK457x+sWEVE1uDNZyBow/VBpFAhTZw3f8mDdIZZA
   yRnWcJbesF8xbTyPQ2UbQeO2fwzvh8Y0VHu09zpx0oe7SeTuNZVwsenrj
   huAIpLtH6N8CzS59Fx9eBl8nE18woVtK4o8inenRY+auq1umwzMh99DrE
   Q==;
X-CSE-ConnectionGUID: ja7hYxbXSH2M66e9jHvttw==
X-CSE-MsgGUID: NbQVw1Y6QQeORv48aas4sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91406449"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="91406449"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 21:34:57 -0700
X-CSE-ConnectionGUID: 9QrfKN9LR8+XO1MunaGbig==
X-CSE-MsgGUID: udasI/SwQUaLy/6EU0s6LQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2026 21:34:55 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwuUO-00000000hmn-2BC7;
	Thu, 20 Aug 2026 04:34:52 +0000
Date: Thu, 20 Aug 2026 12:34:30 +0800
From: kernel test robot <lkp@intel.com>
To: Xander Wilmink <xwilmink@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Xander Wilmink <xwilmink@gmail.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH net-next] net: sfp: Add quirk for Dell M14MK module
Message-ID: <202608201239.Hqp9r0YB-lkp@intel.com>
References: <20260807213025.1206-1-xwilmink@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807213025.1206-1-xwilmink@gmail.com>

Hi Xander,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xander-Wilmink/net-sfp-Add-quirk-for-Dell-M14MK-module/20260807-213025
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260807213025.1206-1-xwilmink%40gmail.com
patch subject: [PATCH net-next] net: sfp: Add quirk for Dell M14MK module
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201239.Hqp9r0YB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201239.Hqp9r0YB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201239.Hqp9r0YB-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/phy/sfp.c: In function 'sfp_quirk_25g_10g_dual':
>> drivers/net/phy/sfp.c:487:13: error: invalid storage class for function 'sfp_quirk_disable_autoneg'
     487 | static void sfp_quirk_disable_autoneg(const struct sfp_eeprom_id *id,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:493:13: error: invalid storage class for function 'sfp_quirk_oem_2_5g'
     493 | static void sfp_quirk_oem_2_5g(const struct sfp_eeprom_id *id,
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:503:13: error: invalid storage class for function 'sfp_quirk_ubnt_uf_instant'
     503 | static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:615:43: error: initializer element is not constant
     615 |         SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:523:48: note: in definition of macro 'SFP_QUIRK'
     523 |         { .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
         |                                                ^~
   drivers/net/phy/sfp.c:615:9: note: in expansion of macro 'SFP_QUIRK_S'
     615 |         SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
         |         ^~~~~~~~~~~
   drivers/net/phy/sfp.c:615:43: note: (near initialization for 'sfp_quirks[19].support')
   drivers/net/phy/sfp.c:523:48: note: in definition of macro 'SFP_QUIRK'
     523 |         { .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
         |                                                ^~
   drivers/net/phy/sfp.c:615:9: note: in expansion of macro 'SFP_QUIRK_S'
     615 |         SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
         |         ^~~~~~~~~~~
   drivers/net/phy/sfp.c:631:42: error: initializer element is not constant
     631 |         SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |                                          ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:523:48: note: in definition of macro 'SFP_QUIRK'
     523 |         { .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
         |                                                ^~
   drivers/net/phy/sfp.c:631:9: note: in expansion of macro 'SFP_QUIRK_S'
     631 |         SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |         ^~~~~~~~~~~
   drivers/net/phy/sfp.c:631:42: note: (near initialization for 'sfp_quirks[26].support')
   drivers/net/phy/sfp.c:523:48: note: in definition of macro 'SFP_QUIRK'
     523 |         { .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
         |                                                ^~
   drivers/net/phy/sfp.c:631:9: note: in expansion of macro 'SFP_QUIRK_S'
     631 |         SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |         ^~~~~~~~~~~
   drivers/net/phy/sfp.c:650:45: error: initializer element is not constant
     650 |         SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |                                             ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:523:48: note: in definition of macro 'SFP_QUIRK'
     523 |         { .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
         |                                                ^~
   drivers/net/phy/sfp.c:650:9: note: in expansion of macro 'SFP_QUIRK_S'
     650 |         SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |         ^~~~~~~~~~~
   drivers/net/phy/sfp.c:650:45: note: (near initialization for 'sfp_quirks[37].support')
   drivers/net/phy/sfp.c:523:48: note: in definition of macro 'SFP_QUIRK'
     523 |         { .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
         |                                                ^~
   drivers/net/phy/sfp.c:650:9: note: in expansion of macro 'SFP_QUIRK_S'
     650 |         SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |         ^~~~~~~~~~~
>> drivers/net/phy/sfp.c:653:15: error: invalid storage class for function 'sfp_strlen'
     653 | static size_t sfp_strlen(const char *str, size_t maxlen)
         |               ^~~~~~~~~~
>> drivers/net/phy/sfp.c:667:13: error: invalid storage class for function 'sfp_match'
     667 | static bool sfp_match(const char *qs, const char *str, size_t len, bool prefix)
         |             ^~~~~~~~~
>> drivers/net/phy/sfp.c:679:32: error: invalid storage class for function 'sfp_lookup_quirk'
     679 | static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
         |                                ^~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:697:21: error: invalid storage class for function 'sfp_gpio_get_state'
     697 | static unsigned int sfp_gpio_get_state(struct sfp *sfp)
         |                     ^~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:713:21: error: invalid storage class for function 'sff_gpio_get_state'
     713 | static unsigned int sff_gpio_get_state(struct sfp *sfp)
         |                     ^~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:718:13: error: invalid storage class for function 'sfp_gpio_set_state'
     718 | static void sfp_gpio_set_state(struct sfp *sfp, unsigned int state)
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:754:12: error: invalid storage class for function 'sfp_i2c_read'
     754 | static int sfp_i2c_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
         |            ^~~~~~~~~~~~
>> drivers/net/phy/sfp.c:794:12: error: invalid storage class for function 'sfp_i2c_write'
     794 | static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
         |            ^~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:821:12: error: invalid storage class for function 'sfp_smbus_read'
     821 | static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
         |            ^~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:878:12: error: invalid storage class for function 'sfp_smbus_write'
     878 | static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
         |            ^~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:933:12: error: invalid storage class for function 'sfp_i2c_configure'
     933 | static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
         |            ^~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:981:12: error: invalid storage class for function 'sfp_i2c_mdiobus_create'
     981 | static int sfp_i2c_mdiobus_create(struct sfp *sfp)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:1004:13: error: invalid storage class for function 'sfp_i2c_mdiobus_destroy'
    1004 | static void sfp_i2c_mdiobus_destroy(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:1012:12: error: invalid storage class for function 'sfp_read'
    1012 | static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
         |            ^~~~~~~~
>> drivers/net/phy/sfp.c:1021:13: error: invalid storage class for function 'sfp_module_present_i2c'
    1021 | static bool sfp_module_present_i2c(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:1034:21: error: invalid storage class for function 'sfp_i2c_get_state'
    1034 | static unsigned int sfp_i2c_get_state(struct sfp *sfp)
         |                     ^~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1056:12: error: invalid storage class for function 'sfp_write'
    1056 | static int sfp_write(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
         |            ^~~~~~~~~
   drivers/net/phy/sfp.c:1061:12: error: invalid storage class for function 'sfp_modify_u8'
    1061 | static int sfp_modify_u8(struct sfp *sfp, bool a2, u8 addr, u8 mask, u8 val)
         |            ^~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1077:21: error: invalid storage class for function 'sfp_soft_get_state'
    1077 | static unsigned int sfp_soft_get_state(struct sfp *sfp)
         |                     ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1100:13: error: invalid storage class for function 'sfp_soft_set_state'
    1100 | static void sfp_soft_set_state(struct sfp *sfp, unsigned int state,
         |             ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1129:13: error: invalid storage class for function 'sfp_soft_start_poll'
    1129 | static void sfp_soft_start_poll(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1154:13: error: invalid storage class for function 'sfp_soft_stop_poll'
    1154 | static void sfp_soft_stop_poll(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1164:21: error: invalid storage class for function 'sfp_get_state'
    1164 | static unsigned int sfp_get_state(struct sfp *sfp)
         |                     ^~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1179:13: error: invalid storage class for function 'sfp_set_state'
    1179 | static void sfp_set_state(struct sfp *sfp, unsigned int state)
         |             ^~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1190:13: error: invalid storage class for function 'sfp_mod_state'
    1190 | static void sfp_mod_state(struct sfp *sfp, unsigned int mask, unsigned int set)
         |             ^~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1198:21: error: invalid storage class for function 'sfp_check'
    1198 | static unsigned int sfp_check(void *buf, size_t len)
         |                     ^~~~~~~~~
   drivers/net/phy/sfp.c:1210:16: error: invalid storage class for function 'sfp_hwmon_is_visible'
    1210 | static umode_t sfp_hwmon_is_visible(const void *data,
         |                ^~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1307:12: error: invalid storage class for function 'sfp_hwmon_read_sensor'
    1307 | static int sfp_hwmon_read_sensor(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1321:13: error: invalid storage class for function 'sfp_hwmon_to_rx_power'
    1321 | static void sfp_hwmon_to_rx_power(long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1326:13: error: invalid storage class for function 'sfp_hwmon_calibrate'
    1326 | static void sfp_hwmon_calibrate(struct sfp *sfp, unsigned int slope, int offset,
         |             ^~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1333:13: error: invalid storage class for function 'sfp_hwmon_calibrate_temp'
    1333 | static void sfp_hwmon_calibrate_temp(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1344:13: error: invalid storage class for function 'sfp_hwmon_calibrate_vcc'
    1344 | static void sfp_hwmon_calibrate_vcc(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1352:13: error: invalid storage class for function 'sfp_hwmon_calibrate_bias'
    1352 | static void sfp_hwmon_calibrate_bias(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1360:13: error: invalid storage class for function 'sfp_hwmon_calibrate_tx_power'
    1360 | static void sfp_hwmon_calibrate_tx_power(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1368:12: error: invalid storage class for function 'sfp_hwmon_read_temp'
    1368 | static int sfp_hwmon_read_temp(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1381:12: error: invalid storage class for function 'sfp_hwmon_read_vcc'
    1381 | static int sfp_hwmon_read_vcc(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1394:12: error: invalid storage class for function 'sfp_hwmon_read_bias'
    1394 | static int sfp_hwmon_read_bias(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1407:12: error: invalid storage class for function 'sfp_hwmon_read_tx_power'
    1407 | static int sfp_hwmon_read_tx_power(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1420:12: error: invalid storage class for function 'sfp_hwmon_read_rx_power'
    1420 | static int sfp_hwmon_read_rx_power(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1433:12: error: invalid storage class for function 'sfp_hwmon_temp'
    1433 | static int sfp_hwmon_temp(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1499:12: error: invalid storage class for function 'sfp_hwmon_vcc'
    1499 | static int sfp_hwmon_vcc(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1566:12: error: invalid storage class for function 'sfp_hwmon_bias'
    1566 | static int sfp_hwmon_bias(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1633:12: error: invalid storage class for function 'sfp_hwmon_tx_power'
    1633 | static int sfp_hwmon_tx_power(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1700:12: error: invalid storage class for function 'sfp_hwmon_rx_power'
    1700 | static int sfp_hwmon_rx_power(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1767:12: error: invalid storage class for function 'sfp_hwmon_read'
    1767 | static int sfp_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
         |            ^~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1798:12: error: invalid storage class for function 'sfp_hwmon_read_string'
    1798 | static int sfp_hwmon_read_string(struct device *dev,
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1847:23: error: initializer element is not constant
    1847 |         .is_visible = sfp_hwmon_is_visible,
         |                       ^~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1847:23: note: (near initialization for 'sfp_hwmon_ops.is_visible')
   drivers/net/phy/sfp.c:1848:17: error: initializer element is not constant
    1848 |         .read = sfp_hwmon_read,
         |                 ^~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:1848:17: note: (near initialization for 'sfp_hwmon_ops.read')
--
   phy/sfp.c:1061:12: error: invalid storage class for function 'sfp_modify_u8'
    1061 | static int sfp_modify_u8(struct sfp *sfp, bool a2, u8 addr, u8 mask, u8 val)
         |            ^~~~~~~~~~~~~
   phy/sfp.c:1077:21: error: invalid storage class for function 'sfp_soft_get_state'
    1077 | static unsigned int sfp_soft_get_state(struct sfp *sfp)
         |                     ^~~~~~~~~~~~~~~~~~
   phy/sfp.c:1100:13: error: invalid storage class for function 'sfp_soft_set_state'
    1100 | static void sfp_soft_set_state(struct sfp *sfp, unsigned int state,
         |             ^~~~~~~~~~~~~~~~~~
   phy/sfp.c:1129:13: error: invalid storage class for function 'sfp_soft_start_poll'
    1129 | static void sfp_soft_start_poll(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1154:13: error: invalid storage class for function 'sfp_soft_stop_poll'
    1154 | static void sfp_soft_stop_poll(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~
   phy/sfp.c:1164:21: error: invalid storage class for function 'sfp_get_state'
    1164 | static unsigned int sfp_get_state(struct sfp *sfp)
         |                     ^~~~~~~~~~~~~
   phy/sfp.c:1179:13: error: invalid storage class for function 'sfp_set_state'
    1179 | static void sfp_set_state(struct sfp *sfp, unsigned int state)
         |             ^~~~~~~~~~~~~
   phy/sfp.c:1190:13: error: invalid storage class for function 'sfp_mod_state'
    1190 | static void sfp_mod_state(struct sfp *sfp, unsigned int mask, unsigned int set)
         |             ^~~~~~~~~~~~~
   phy/sfp.c:1198:21: error: invalid storage class for function 'sfp_check'
    1198 | static unsigned int sfp_check(void *buf, size_t len)
         |                     ^~~~~~~~~
   phy/sfp.c:1210:16: error: invalid storage class for function 'sfp_hwmon_is_visible'
    1210 | static umode_t sfp_hwmon_is_visible(const void *data,
         |                ^~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1307:12: error: invalid storage class for function 'sfp_hwmon_read_sensor'
    1307 | static int sfp_hwmon_read_sensor(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1321:13: error: invalid storage class for function 'sfp_hwmon_to_rx_power'
    1321 | static void sfp_hwmon_to_rx_power(long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1326:13: error: invalid storage class for function 'sfp_hwmon_calibrate'
    1326 | static void sfp_hwmon_calibrate(struct sfp *sfp, unsigned int slope, int offset,
         |             ^~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1333:13: error: invalid storage class for function 'sfp_hwmon_calibrate_temp'
    1333 | static void sfp_hwmon_calibrate_temp(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1344:13: error: invalid storage class for function 'sfp_hwmon_calibrate_vcc'
    1344 | static void sfp_hwmon_calibrate_vcc(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1352:13: error: invalid storage class for function 'sfp_hwmon_calibrate_bias'
    1352 | static void sfp_hwmon_calibrate_bias(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1360:13: error: invalid storage class for function 'sfp_hwmon_calibrate_tx_power'
    1360 | static void sfp_hwmon_calibrate_tx_power(struct sfp *sfp, long *value)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1368:12: error: invalid storage class for function 'sfp_hwmon_read_temp'
    1368 | static int sfp_hwmon_read_temp(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1381:12: error: invalid storage class for function 'sfp_hwmon_read_vcc'
    1381 | static int sfp_hwmon_read_vcc(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~
   phy/sfp.c:1394:12: error: invalid storage class for function 'sfp_hwmon_read_bias'
    1394 | static int sfp_hwmon_read_bias(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1407:12: error: invalid storage class for function 'sfp_hwmon_read_tx_power'
    1407 | static int sfp_hwmon_read_tx_power(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1420:12: error: invalid storage class for function 'sfp_hwmon_read_rx_power'
    1420 | static int sfp_hwmon_read_rx_power(struct sfp *sfp, int reg, long *value)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1433:12: error: invalid storage class for function 'sfp_hwmon_temp'
    1433 | static int sfp_hwmon_temp(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~
   phy/sfp.c:1499:12: error: invalid storage class for function 'sfp_hwmon_vcc'
    1499 | static int sfp_hwmon_vcc(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~
   phy/sfp.c:1566:12: error: invalid storage class for function 'sfp_hwmon_bias'
    1566 | static int sfp_hwmon_bias(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~
   phy/sfp.c:1633:12: error: invalid storage class for function 'sfp_hwmon_tx_power'
    1633 | static int sfp_hwmon_tx_power(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~~~~~
   phy/sfp.c:1700:12: error: invalid storage class for function 'sfp_hwmon_rx_power'
    1700 | static int sfp_hwmon_rx_power(struct sfp *sfp, u32 attr, long *value)
         |            ^~~~~~~~~~~~~~~~~~
   phy/sfp.c:1767:12: error: invalid storage class for function 'sfp_hwmon_read'
    1767 | static int sfp_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
         |            ^~~~~~~~~~~~~~
   phy/sfp.c:1798:12: error: invalid storage class for function 'sfp_hwmon_read_string'
    1798 | static int sfp_hwmon_read_string(struct device *dev,
         |            ^~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1847:23: error: initializer element is not constant
    1847 |         .is_visible = sfp_hwmon_is_visible,
         |                       ^~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1847:23: note: (near initialization for 'sfp_hwmon_ops.is_visible')
   phy/sfp.c:1848:17: error: initializer element is not constant
    1848 |         .read = sfp_hwmon_read,
         |                 ^~~~~~~~~~~~~~
   phy/sfp.c:1848:17: note: (near initialization for 'sfp_hwmon_ops.read')
   phy/sfp.c:1849:24: error: initializer element is not constant
    1849 |         .read_string = sfp_hwmon_read_string,
         |                        ^~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:1849:24: note: (near initialization for 'sfp_hwmon_ops.read_string')
   In file included from phy/sfp.c:5:
>> include/linux/hwmon.h:444:9: error: initializer element is not constant
     444 |         (&(const struct hwmon_channel_info) {   \
         |         ^
   phy/sfp.c:1853:9: note: in expansion of macro 'HWMON_CHANNEL_INFO'
    1853 |         HWMON_CHANNEL_INFO(chip,
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/hwmon.h:444:9: note: (near initialization for 'sfp_hwmon_info[0]')
   phy/sfp.c:1853:9: note: in expansion of macro 'HWMON_CHANNEL_INFO'
    1853 |         HWMON_CHANNEL_INFO(chip,
         |         ^~~~~~~~~~~~~~~~~~
   phy/sfp.c:1899:13: error: invalid storage class for function 'sfp_hwmon_probe'
    1899 | static void sfp_hwmon_probe(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~
   phy/sfp.c:1945:12: error: invalid storage class for function 'sfp_hwmon_insert'
    1945 | static int sfp_hwmon_insert(struct sfp *sfp)
         |            ^~~~~~~~~~~~~~~~
   phy/sfp.c:1955:13: error: invalid storage class for function 'sfp_hwmon_remove'
    1955 | static void sfp_hwmon_remove(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~
   phy/sfp.c:1969:12: error: invalid storage class for function 'sfp_hwmon_init'
    1969 | static int sfp_hwmon_init(struct sfp *sfp)
         |            ^~~~~~~~~~~~~~
   phy/sfp.c:1976:13: error: invalid storage class for function 'sfp_hwmon_exit'
    1976 | static void sfp_hwmon_exit(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~
   phy/sfp.c:2001:13: error: invalid storage class for function 'sfp_module_tx_disable'
    2001 | static void sfp_module_tx_disable(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2008:13: error: invalid storage class for function 'sfp_module_tx_enable'
    2008 | static void sfp_module_tx_enable(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2016:12: error: invalid storage class for function 'sfp_debug_state_show'
    2016 | static int sfp_debug_state_show(struct seq_file *s, void *data)
         |            ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/debugfs.h:16,
                    from phy/sfp.c:2:
   phy/sfp.c:2044:23: error: invalid storage class for function 'sfp_debug_state_open'
    2044 | DEFINE_SHOW_ATTRIBUTE(sfp_debug_state);
         |                       ^~~~~~~~~~~~~~~
   include/linux/seq_file.h:207:12: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     207 | static int __name ## _open(struct inode *inode, struct file *file)      \
         |            ^~~~~~
   phy/sfp.c:2044:23: error: initializer element is not constant
    2044 | DEFINE_SHOW_ATTRIBUTE(sfp_debug_state);
         |                       ^~~~~~~~~~~~~~~
   include/linux/seq_file.h:214:27: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     214 |         .open           = __name ## _open,                              \
         |                           ^~~~~~
   phy/sfp.c:2044:23: note: (near initialization for 'sfp_debug_state_fops.open')
   include/linux/seq_file.h:214:27: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     214 |         .open           = __name ## _open,                              \
         |                           ^~~~~~
   phy/sfp.c:2046:13: error: invalid storage class for function 'sfp_debugfs_init'
    2046 | static void sfp_debugfs_init(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~
   phy/sfp.c:2054:13: error: invalid storage class for function 'sfp_debugfs_exit'
    2054 | static void sfp_debugfs_exit(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~
   phy/sfp.c:2068:13: error: invalid storage class for function 'sfp_module_tx_fault_reset'
    2068 | static void sfp_module_tx_fault_reset(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2085:13: error: invalid storage class for function 'sfp_sm_set_timer'
    2085 | static void sfp_sm_set_timer(struct sfp *sfp, unsigned int timeout)
         |             ^~~~~~~~~~~~~~~~
   phy/sfp.c:2094:13: error: invalid storage class for function 'sfp_sm_next'
    2094 | static void sfp_sm_next(struct sfp *sfp, unsigned int state,
         |             ^~~~~~~~~~~
   phy/sfp.c:2101:13: error: invalid storage class for function 'sfp_sm_mod_next'
    2101 | static void sfp_sm_mod_next(struct sfp *sfp, unsigned int state,
         |             ^~~~~~~~~~~~~~~
   phy/sfp.c:2108:13: error: invalid storage class for function 'sfp_sm_phy_detach'
    2108 | static void sfp_sm_phy_detach(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~
   phy/sfp.c:2116:12: error: invalid storage class for function 'sfp_sm_probe_phy'
    2116 | static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
         |            ^~~~~~~~~~~~~~~~
   phy/sfp.c:2153:13: error: invalid storage class for function 'sfp_sm_link_up'
    2153 | static void sfp_sm_link_up(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~
   phy/sfp.c:2159:13: error: invalid storage class for function 'sfp_sm_link_down'
    2159 | static void sfp_sm_link_down(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~
   phy/sfp.c:2164:13: error: invalid storage class for function 'sfp_sm_link_check_los'
    2164 | static void sfp_sm_link_check_los(struct sfp *sfp)
         |             ^~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2186:13: error: invalid storage class for function 'sfp_los_event_active'
    2186 | static bool sfp_los_event_active(struct sfp *sfp, unsigned int event)
         |             ^~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2196:13: error: invalid storage class for function 'sfp_los_event_inactive'
    2196 | static bool sfp_los_event_inactive(struct sfp *sfp, unsigned int event)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2206:13: error: invalid storage class for function 'sfp_sm_fault'
    2206 | static void sfp_sm_fault(struct sfp *sfp, unsigned int next_state, bool warn)
         |             ^~~~~~~~~~~~
   phy/sfp.c:2220:12: error: invalid storage class for function 'sfp_sm_add_mdio_bus'
    2220 | static int sfp_sm_add_mdio_bus(struct sfp *sfp)
         |            ^~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2239:12: error: invalid storage class for function 'sfp_sm_probe_for_phy'
    2239 | static int sfp_sm_probe_for_phy(struct sfp *sfp)
         |            ^~~~~~~~~~~~~~~~~~~~
   phy/sfp.c:2263:12: error: invalid storage class for function 'sfp_module_parse_power'
..


vim +/sfp_quirk_disable_autoneg +487 drivers/net/phy/sfp.c

23571c7b964374 Russell King (Oracle     2022-09-13  479) 
008809b6223aa2 Xander Wilmink           2026-08-07 @480  static void sfp_quirk_25g_10g_dual(const struct sfp_eeprom_id *id,
008809b6223aa2 Xander Wilmink           2026-08-07  481  				   struct sfp_module_caps *caps)
008809b6223aa2 Xander Wilmink           2026-08-07  482  {
008809b6223aa2 Xander Wilmink           2026-08-07  483  	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
008809b6223aa2 Xander Wilmink           2026-08-07  484  			 caps->link_modes);
008809b6223aa2 Xander Wilmink           2026-08-07  485  	__set_bit(PHY_INTERFACE_MODE_10GBASER, caps->interfaces);
008809b6223aa2 Xander Wilmink           2026-08-07  486  
50e96acbe11667 Russell King (Oracle     2023-03-21 @487) static void sfp_quirk_disable_autoneg(const struct sfp_eeprom_id *id,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  488) 				      struct sfp_module_caps *caps)
50e96acbe11667 Russell King (Oracle     2023-03-21  489) {
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  490) 	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, caps->link_modes);
50e96acbe11667 Russell King (Oracle     2023-03-21  491) }
50e96acbe11667 Russell King (Oracle     2023-03-21  492) 
50e96acbe11667 Russell King (Oracle     2023-03-21 @493) static void sfp_quirk_oem_2_5g(const struct sfp_eeprom_id *id,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  494) 			       struct sfp_module_caps *caps)
50e96acbe11667 Russell King (Oracle     2023-03-21  495) {
50e96acbe11667 Russell King (Oracle     2023-03-21  496) 	/* Copper 2.5G SFP */
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  497) 	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  498) 			 caps->link_modes);
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  499) 	__set_bit(PHY_INTERFACE_MODE_2500BASEX, caps->interfaces);
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  500) 	sfp_quirk_disable_autoneg(id, caps);
50e96acbe11667 Russell King (Oracle     2023-03-21  501) }
50e96acbe11667 Russell King (Oracle     2023-03-21  502) 
23571c7b964374 Russell King (Oracle     2022-09-13 @503) static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  504) 				      struct sfp_module_caps *caps)
23571c7b964374 Russell King (Oracle     2022-09-13  505) {
23571c7b964374 Russell King (Oracle     2022-09-13  506) 	/* Ubiquiti U-Fiber Instant module claims that support all transceiver
23571c7b964374 Russell King (Oracle     2022-09-13  507) 	 * types including 10G Ethernet which is not truth. So clear all claimed
eeee5a710f26ce Marek Behún              2026-03-26  508  	 * modes and set only one mode which module supports: 1000baseX_Full,
eeee5a710f26ce Marek Behún              2026-03-26  509  	 * along with the Autoneg and pause bits.
23571c7b964374 Russell King (Oracle     2022-09-13  510) 	 */
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  511) 	linkmode_zero(caps->link_modes);
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  512) 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  513) 			 caps->link_modes);
eeee5a710f26ce Marek Behún              2026-03-26  514  	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, caps->link_modes);
eeee5a710f26ce Marek Behún              2026-03-26  515  	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, caps->link_modes);
eeee5a710f26ce Marek Behún              2026-03-26  516  	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, caps->link_modes);
eeee5a710f26ce Marek Behún              2026-03-26  517  
adcbadfd8e05d3 Marek Behún              2026-01-29  518  	phy_interface_zero(caps->interfaces);
adcbadfd8e05d3 Marek Behún              2026-01-29  519  	__set_bit(PHY_INTERFACE_MODE_1000BASEX, caps->interfaces);
23571c7b964374 Russell King (Oracle     2022-09-13  520) }
23571c7b964374 Russell King (Oracle     2022-09-13  521) 
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  522) #define SFP_QUIRK(_v, _p, _s, _f) \
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  523) 	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  524) #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
13c8adcf221f1f Marek Behún              2022-09-30  525  #define SFP_QUIRK_F(_v, _p, _f) SFP_QUIRK(_v, _p, NULL, _f)
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  526  /* Like SFP_QUIRK_F, but matches the part as a prefix; the vendor name
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  527   * is still matched exactly. Use for modules whose EEPROM vendor PN
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  528   * field reads back with garbage past the legitimate characters instead
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  529   * of the SFF-8472-mandated space padding, so sfp_strlen can't trim the
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  530   * field down to the legitimate length.
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  531   */
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  532  #define SFP_QUIRK_F_PREFIX(_v, _p, _f) \
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  533  	{ .vendor = _v, .part = _p, .support = NULL, .fixup = _f, \
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  534  	  .part_prefix_match = true }
13c8adcf221f1f Marek Behún              2022-09-30  535  
23571c7b964374 Russell King (Oracle     2022-09-13  536) static const struct sfp_quirk sfp_quirks[] = {
13c8adcf221f1f Marek Behún              2022-09-30  537  	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
13c8adcf221f1f Marek Behún              2022-09-30  538  	// report 2500MBd NRZ in their EEPROM
90cb5f1776ba37 Shengyu Qu               2024-10-12  539  	SFP_QUIRK("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex,
90cb5f1776ba37 Shengyu Qu               2024-10-12  540  		  sfp_fixup_ignore_tx_fault),
13c8adcf221f1f Marek Behún              2022-09-30  541  
008809b6223aa2 Xander Wilmink           2026-08-07  542  	// Dell M14MK, 10/25 GBit SFP28 module. Labeled as Dell S28-10G-25G-SR-85C.
008809b6223aa2 Xander Wilmink           2026-08-07  543  	// Runs at 10 Gbit/s in a SFP+ port, but does not advertise this properly.
008809b6223aa2 Xander Wilmink           2026-08-07  544  	SFP_QUIRK_S("DELL", "M14MK", sfp_quirk_25g_10g_dual),
008809b6223aa2 Xander Wilmink           2026-08-07  545  
13c8adcf221f1f Marek Behún              2022-09-30  546  	// Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
23571c7b964374 Russell King (Oracle     2022-09-13  547) 	// NRZ in their EEPROM
13c8adcf221f1f Marek Behún              2022-09-30  548  	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
5ffe330e40bdfa Russell King (Oracle     2023-10-03  549) 		  sfp_fixup_nokia),
13c8adcf221f1f Marek Behún              2022-09-30  550  
71cfa7c893a05d Marcus Hughes            2025-12-07  551  	SFP_QUIRK_F("BIDB", "X-ONU-SFPP", sfp_fixup_potron),
71cfa7c893a05d Marcus Hughes            2025-12-07  552  
ddbf0e78a8b20e Aleksander Jan Bajkowski 2025-08-31  553  	// FLYPRO SFP-10GT-CS-30M uses Rollball protocol to talk to the PHY.
ddbf0e78a8b20e Aleksander Jan Bajkowski 2025-08-31  554  	SFP_QUIRK_F("FLYPRO", "SFP-10GT-CS-30M", sfp_fixup_rollball),
ddbf0e78a8b20e Aleksander Jan Bajkowski 2025-08-31  555  
6999e0fc9a552c Marek Behún              2024-04-23  556  	// Fiberstore SFP-10G-T doesn't identify as copper, uses the Rollball
6999e0fc9a552c Marek Behún              2024-04-23  557  	// protocol to talk to the PHY and needs 4 sec wait before probing the
6999e0fc9a552c Marek Behún              2024-04-23  558  	// PHY.
5859a99b52254b Russell King (Oracle     2023-05-20  559) 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
5859a99b52254b Russell King (Oracle     2023-05-20  560) 
05ec5c085eb7ae Martin Schiller          2025-02-27  561  	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to talk
05ec5c085eb7ae Martin Schiller          2025-02-27  562  	// to the PHY and needs 4 sec wait before probing the PHY.
05ec5c085eb7ae Martin Schiller          2025-02-27  563  	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_rollball_wait4s),
05ec5c085eb7ae Martin Schiller          2025-02-27  564  	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_rollball_wait4s),
cd4a32e6006178 Marek Behún              2024-04-23  565  
d387e34fec407f Christian Marangi        2023-09-19  566  	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
d387e34fec407f Christian Marangi        2023-09-19  567  	// NRZ in their EEPROM
d387e34fec407f Christian Marangi        2023-09-19  568  	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
d387e34fec407f Christian Marangi        2023-09-19  569  		  sfp_fixup_ignore_tx_fault),
d387e34fec407f Christian Marangi        2023-09-19  570  
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  571  	// Fiberstore XGS-SFP-ONT-MACI is a MAC-mode XGS-PON ONT stick with
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  572  	// ONT-class serial-passthrough TX_FAULT/LOS wiring and slow startup;
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  573  	// mask both signals and extend T_START_UP via the potron fixup. The
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  574  	// PN is the product name (XGS-SFP-ONT-MAC-I) truncated at the 16-byte
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  575  	// field width, so the field is fully occupied and matches exactly.
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  576  	SFP_QUIRK_F("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron),
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  577  
13c8adcf221f1f Marek Behún              2022-09-30  578  	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
13c8adcf221f1f Marek Behún              2022-09-30  579  
a92a6c50e35b75 Hamza Mahfooz            2026-01-13  580  	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
a92a6c50e35b75 Hamza Mahfooz            2026-01-13  581  
ad651d68cee75e Daniel Golle             2023-04-02  582  	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
ad651d68cee75e Daniel Golle             2023-04-02  583  	// 2600MBd in their EERPOM
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  584) 	SFP_QUIRK_S("HG GENUINE", "MXPD-483II", sfp_quirk_2500basex),
ad651d68cee75e Daniel Golle             2023-04-02  585  
13c8adcf221f1f Marek Behún              2022-09-30  586  	// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd NRZ in
13c8adcf221f1f Marek Behún              2022-09-30  587  	// their EEPROM
13c8adcf221f1f Marek Behún              2022-09-30  588  	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
87d12685215846 Álvaro Fernández Rojas   2026-03-06  589  		  sfp_fixup_ignore_tx_fault_and_los),
13c8adcf221f1f Marek Behún              2022-09-30  590  
95aca8602ef70f John Pavlick             2026-04-06  591  	// Hisense LXT-010S-H is a GPON ONT SFP (sold as LEOX LXT-010S-H) that
95aca8602ef70f John Pavlick             2026-04-06  592  	// can operate at 2500base-X, but reports 1000BASE-LX / 1300MBd in its
95aca8602ef70f John Pavlick             2026-04-06  593  	// EEPROM
95aca8602ef70f John Pavlick             2026-04-06  594  	SFP_QUIRK("Hisense-Leox", "LXT-010S-H", sfp_quirk_2500basex,
95aca8602ef70f John Pavlick             2026-04-06  595  		  sfp_fixup_ignore_tx_fault),
95aca8602ef70f John Pavlick             2026-04-06  596  
95aca8602ef70f John Pavlick             2026-04-06  597  	// Hisense ZNID-GPON-2311NA can operate at 2500base-X, but reports
95aca8602ef70f John Pavlick             2026-04-06  598  	// 1000BASE-LX / 1300MBd in its EEPROM
95aca8602ef70f John Pavlick             2026-04-06  599  	SFP_QUIRK("Hisense", "ZNID-GPON-2311NA", sfp_quirk_2500basex,
95aca8602ef70f John Pavlick             2026-04-06  600  		  sfp_fixup_ignore_tx_fault),
95aca8602ef70f John Pavlick             2026-04-06  601  
95aca8602ef70f John Pavlick             2026-04-06  602  	// HSGQ HSGQ-XPON-Stick can operate at 2500base-X, but reports
95aca8602ef70f John Pavlick             2026-04-06  603  	// 1000BASE-LX / 1300MBd in its EEPROM
95aca8602ef70f John Pavlick             2026-04-06  604  	SFP_QUIRK("HSGQ", "HSGQ-XPON-Stick", sfp_quirk_2500basex,
95aca8602ef70f John Pavlick             2026-04-06  605  		  sfp_fixup_ignore_tx_fault),
95aca8602ef70f John Pavlick             2026-04-06  606  
86a8e8e0ddbc3d Marek Behún              2026-01-28  607  	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
86a8e8e0ddbc3d Marek Behún              2026-01-28  608  	// incorrectly report 2500MBd NRZ in their EEPROM.
86a8e8e0ddbc3d Marek Behún              2026-01-28  609  	// Some 8330-265D modules have inverted LOS, while all of them report
86a8e8e0ddbc3d Marek Behún              2026-01-28  610  	// normal LOS in EEPROM. Therefore we need to ignore LOS entirely.
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  611) 	SFP_QUIRK_S("Lantech", "8330-262D-E", sfp_quirk_2500basex),
86a8e8e0ddbc3d Marek Behún              2026-01-28  612  	SFP_QUIRK("Lantech", "8330-265D", sfp_quirk_2500basex,
86a8e8e0ddbc3d Marek Behún              2026-01-28  613  		  sfp_fixup_ignore_los),
13c8adcf221f1f Marek Behún              2022-09-30  614  
a7dc35a9e49b10 Russell King (Oracle     2025-09-16 @615) 	SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
324e88cbe3b7be Marek Behún              2022-09-30  616  
ac2e8e3cfe4843 Josua Mayer              2023-05-22  617  	// Walsun HXSX-ATR[CI]-1 don't identify as copper, and use the
5859a99b52254b Russell King (Oracle     2023-05-20  618) 	// Rollball protocol to talk to the PHY.
5859a99b52254b Russell King (Oracle     2023-05-20  619) 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
ac2e8e3cfe4843 Josua Mayer              2023-05-22  620  	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
5859a99b52254b Russell King (Oracle     2023-05-20  621) 
dfec1c14aecee6 Chris Morgan             2025-06-17  622  	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
dfec1c14aecee6 Chris Morgan             2025-06-17  623  
1bb028baab5419 Aleksander Jan Bajkowski 2026-07-19  624  	// HORACO HC-10GE-113C uses Rollball protocol to talk to the PHY.
1bb028baab5419 Aleksander Jan Bajkowski 2026-07-19  625  	SFP_QUIRK_F("OEM", "HC-10GE-113C", sfp_fixup_rollball),
1bb028baab5419 Aleksander Jan Bajkowski 2026-07-19  626  
0805d67bc0ef95 Daniel Golle             2024-04-23  627  	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
0805d67bc0ef95 Daniel Golle             2024-04-23  628  	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
0805d67bc0ef95 Daniel Golle             2024-04-23  629  
324e88cbe3b7be Marek Behún              2022-09-30  630  	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  631) 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  632) 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  633) 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
5af067bf8a64da Wei Qisen                2026-05-26  634  	SFP_QUIRK_S("OEM", "SFP-2.5G-LH03-B", sfp_quirk_2500basex),
5af067bf8a64da Wei Qisen                2026-05-26  635  	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
324e88cbe3b7be Marek Behún              2022-09-30  636  	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
324e88cbe3b7be Marek Behún              2022-09-30  637  	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  638  
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  639  	// OEM XGSPONST2001 is an XGS-PON ONT stick with broken TX_FAULT and
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  640  	// LOS indicators and slow startup, just like potron. On cold
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  641  	// power-up the EEPROM vendor PN field reads back with non-printable
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  642  	// garbage past the legitimate string instead of space padding, so
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  643  	// match the part as a prefix.
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  644  	SFP_QUIRK_F_PREFIX("OEM", "XGSPONST2001", sfp_fixup_potron),
03fa69146f2fe1 Martino Dell'Ambrogio    2026-08-12  645  
1c77c721916ae1 Marek Behún              2024-04-09  646  	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
324e88cbe3b7be Marek Behún              2022-09-30  647  	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
324e88cbe3b7be Marek Behún              2022-09-30  648  	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
911e2c050963cc Jan Hoffmann             2026-03-29  649  
911e2c050963cc Jan Hoffmann             2026-03-29  650  	SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
23571c7b964374 Russell King (Oracle     2022-09-13  651) };
23571c7b964374 Russell King (Oracle     2022-09-13  652) 
23571c7b964374 Russell King (Oracle     2022-09-13 @653) static size_t sfp_strlen(const char *str, size_t maxlen)
23571c7b964374 Russell King (Oracle     2022-09-13  654) {
23571c7b964374 Russell King (Oracle     2022-09-13  655) 	size_t size, i;
23571c7b964374 Russell King (Oracle     2022-09-13  656) 
73472c830eae5f Russell King (Oracle     2022-09-13  657) 	/* Trailing characters should be filled with space chars, but
73472c830eae5f Russell King (Oracle     2022-09-13  658) 	 * some manufacturers can't read SFF-8472 and use NUL.
73472c830eae5f Russell King (Oracle     2022-09-13  659) 	 */
23571c7b964374 Russell King (Oracle     2022-09-13  660) 	for (i = 0, size = 0; i < maxlen; i++)
73472c830eae5f Russell King (Oracle     2022-09-13  661) 		if (str[i] != ' ' && str[i] != '\0')
23571c7b964374 Russell King (Oracle     2022-09-13  662) 			size = i + 1;
23571c7b964374 Russell King (Oracle     2022-09-13  663) 
23571c7b964374 Russell King (Oracle     2022-09-13  664) 	return size;
23571c7b964374 Russell King (Oracle     2022-09-13  665) }
23571c7b964374 Russell King (Oracle     2022-09-13  666) 
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12 @667  static bool sfp_match(const char *qs, const char *str, size_t len, bool prefix)
23571c7b964374 Russell King (Oracle     2022-09-13  668) {
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  669  	size_t qs_len;
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  670  
23571c7b964374 Russell King (Oracle     2022-09-13  671) 	if (!qs)
23571c7b964374 Russell King (Oracle     2022-09-13  672) 		return true;
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  673  	qs_len = strlen(qs);
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  674  	if (prefix ? qs_len > len : qs_len != len)
23571c7b964374 Russell King (Oracle     2022-09-13  675) 		return false;
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  676  	return !strncmp(qs, str, qs_len);
23571c7b964374 Russell King (Oracle     2022-09-13  677) }
23571c7b964374 Russell King (Oracle     2022-09-13  678) 
23571c7b964374 Russell King (Oracle     2022-09-13 @679) static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
23571c7b964374 Russell King (Oracle     2022-09-13  680) {
23571c7b964374 Russell King (Oracle     2022-09-13  681) 	const struct sfp_quirk *q;
23571c7b964374 Russell King (Oracle     2022-09-13  682) 	unsigned int i;
23571c7b964374 Russell King (Oracle     2022-09-13  683) 	size_t vs, ps;
23571c7b964374 Russell King (Oracle     2022-09-13  684) 
23571c7b964374 Russell King (Oracle     2022-09-13  685) 	vs = sfp_strlen(id->base.vendor_name, ARRAY_SIZE(id->base.vendor_name));
23571c7b964374 Russell King (Oracle     2022-09-13  686) 	ps = sfp_strlen(id->base.vendor_pn, ARRAY_SIZE(id->base.vendor_pn));
23571c7b964374 Russell King (Oracle     2022-09-13  687) 
23571c7b964374 Russell King (Oracle     2022-09-13  688) 	for (i = 0, q = sfp_quirks; i < ARRAY_SIZE(sfp_quirks); i++, q++)
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  689  		if (sfp_match(q->vendor, id->base.vendor_name, vs, false) &&
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  690  		    sfp_match(q->part, id->base.vendor_pn, ps,
f53167e29b8e91 Martino Dell'Ambrogio    2026-08-12  691  			      q->part_prefix_match))
23571c7b964374 Russell King (Oracle     2022-09-13  692) 			return q;
23571c7b964374 Russell King (Oracle     2022-09-13  693) 
23571c7b964374 Russell King (Oracle     2022-09-13  694) 	return NULL;
23571c7b964374 Russell King (Oracle     2022-09-13  695) }
23571c7b964374 Russell King (Oracle     2022-09-13  696) 

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
