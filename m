Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00B1B808;
	Fri,  9 Oct 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579087; cv=none; b=ElNFMVBI2c8qvMHx95ln2fwNCT008gb9zIzzf/aecW/xpPDbtoMGiKBGSTUyKil4paQdR9A6WEQe+crW4WKyvJeyPAAPNvLy8VsC+ihhQ60Mig9IVMUakLZh5bUXiVbmlwiQeOHONPMgdN07odlfYKpS6Qyi0Ed46d8AQxwXW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579087; c=relaxed/simple;
	bh=mO4JRlde3fyBWnbVIcOK3lxvQZkqW1Kcnw2zhKxOLXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxLfhlJfEGGsC96L7KOwVsdq7SH1PFt4K+dYbRQJ3F7qVeqhZI/gjvZ4P+lYLC94p1oKqiLh8ZMiirmaadE07Jb6/B4cyl3xdyDbmWQq2kUqsMRavsmsOgcxsHI1rhhSOOliahykAabScCDlZ37zx26lF1n4nfSn8XRnQ9HqKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=henZWXe2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="henZWXe2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791579084; x=1823115084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mO4JRlde3fyBWnbVIcOK3lxvQZkqW1Kcnw2zhKxOLXE=;
  b=henZWXe26GWWqp988a0Y8CPSpxMefS3nnXIckmuscRxVL/yllXMA1nVR
   y6tN6ic6UefOpk+Tv6bd1w3v7aNiXbJwP0ZqnV7HA/AunP0VhI2GOahtc
   OQmCo9Zl6/hNOMuP4rXouE8IY0iNJrIEmoZZNswHH7hHK9rib4k9k5Thw
   jM4tXmH4+P0Q6tJbUWL4g/oNcG34REFmwA++2YsBU2jfSspi5hhl6VIPG
   WIgFEaKD7ZPiLMP1O65Oa76elESUDc2YNts8gcjUpVZ1WrWqWoFARaCmT
   /oWlPJOsYz32In+iIkne4G5IH/BRNWKPDvOCpw+6uQy0FnQwJhvj+oGQE
   A==;
X-CSE-ConnectionGUID: JmAyqJOhRX2qJMAfx0z7qw==
X-CSE-MsgGUID: pOINpP7jS9OQ8nTznP9NTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="278170"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="278170"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:51:23 -0700
X-CSE-ConnectionGUID: LoEIyudnSVGZNcfAIi7YIA==
X-CSE-MsgGUID: EzDvV8EbSYWC2P/rtAjbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="722734"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Oct 2026 13:51:21 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFHYk-000000006BE-1lBG;
	Fri, 09 Oct 2026 20:51:18 +0000
Date: Sat, 10 Oct 2026 04:51:02 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Meshkov <skyline@mail.ru>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: marvell: add LED support for 88E1116R
 PHY
Message-ID: <202610100452.oJWOdesg-lkp@intel.com>
References: <179152610952.2918676.6625057760354797023@mail.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179152610952.2918676.6625057760354797023@mail.ru>

Hi Konstantin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Meshkov/net-phy-marvell-add-LED-support-for-88E1116R-PHY/20261009-090829
base:   net-next/main
patch link:    https://lore.kernel.org/r/179152610952.2918676.6625057760354797023%40mail.ru
patch subject: [PATCH net-next] net: phy: marvell: add LED support for 88E1116R PHY
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261010/202610100452.oJWOdesg-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 242243a5814307de825db3428662d67b064e2cbc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100452.oJWOdesg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100452.oJWOdesg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/marvell.c:3916:23: error: use of undeclared identifier 'm88e1318_led_polarity_set'; did you mean 'm88e1318_led_blink_set'?
    3916 |                 .led_polarity_set = m88e1318_led_polarity_set,
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                     m88e1318_led_blink_set
   drivers/net/phy/marvell.c:3293:12: note: 'm88e1318_led_blink_set' declared here
    3293 | static int m88e1318_led_blink_set(struct phy_device *phydev, u8 index,
         |            ^
>> drivers/net/phy/marvell.c:3916:23: error: incompatible function pointer types initializing 'int (*)(struct phy_device *, int, unsigned long)' with an expression of type 'int (struct phy_device *, u8, unsigned long *, unsigned long *)' (aka 'int (struct phy_device *, unsigned char, unsigned long *, unsigned long *)') [-Wincompatible-function-pointer-types]
    3916 |                 .led_polarity_set = m88e1318_led_polarity_set,
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +3916 drivers/net/phy/marvell.c

  3666	
  3667	static struct phy_driver marvell_drivers[] = {
  3668		{
  3669			.phy_id = MARVELL_PHY_ID_88E1101,
  3670			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3671			.name = "Marvell 88E1101",
  3672			/* PHY_GBIT_FEATURES */
  3673			.probe = marvell_probe,
  3674			.config_init = marvell_config_init,
  3675			.config_aneg = m88e1101_config_aneg,
  3676			.config_intr = marvell_config_intr,
  3677			.handle_interrupt = marvell_handle_interrupt,
  3678			.resume = genphy_resume,
  3679			.suspend = genphy_suspend,
  3680			.read_page = marvell_read_page,
  3681			.write_page = marvell_write_page,
  3682			.get_sset_count = marvell_get_sset_count,
  3683			.get_strings = marvell_get_strings,
  3684			.get_stats = marvell_get_stats,
  3685		},
  3686		{
  3687			.phy_id = MARVELL_PHY_ID_88E3082,
  3688			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3689			.name = "Marvell 88E308X/88E609X Family",
  3690			/* PHY_BASIC_FEATURES */
  3691			.probe = marvell_probe,
  3692			.config_init = marvell_config_init,
  3693			.aneg_done = marvell_aneg_done,
  3694			.read_status = marvell_read_status,
  3695			.resume = genphy_resume,
  3696			.suspend = genphy_suspend,
  3697			.cable_test_start = m88e3082_vct_cable_test_start,
  3698			.cable_test_get_status = m88e3082_vct_cable_test_get_status,
  3699		},
  3700		{
  3701			.phy_id = MARVELL_PHY_ID_88E1112,
  3702			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3703			.name = "Marvell 88E1112",
  3704			/* PHY_GBIT_FEATURES */
  3705			.probe = marvell_probe,
  3706			.inband_caps = m88e1111_inband_caps,
  3707			.config_inband = m88e1111_config_inband,
  3708			.config_init = m88e1112_config_init,
  3709			.config_aneg = marvell_config_aneg,
  3710			.config_intr = marvell_config_intr,
  3711			.handle_interrupt = marvell_handle_interrupt,
  3712			.resume = genphy_resume,
  3713			.suspend = genphy_suspend,
  3714			.read_page = marvell_read_page,
  3715			.write_page = marvell_write_page,
  3716			.get_sset_count = marvell_get_sset_count,
  3717			.get_strings = marvell_get_strings,
  3718			.get_stats = marvell_get_stats,
  3719			.get_tunable = m88e1011_get_tunable,
  3720			.set_tunable = m88e1011_set_tunable,
  3721		},
  3722		{
  3723			.phy_id = MARVELL_PHY_ID_88E1111,
  3724			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3725			.name = "Marvell 88E1111",
  3726			/* PHY_GBIT_FEATURES */
  3727			.flags = PHY_POLL_CABLE_TEST,
  3728			.probe = marvell_probe,
  3729			.inband_caps = m88e1111_inband_caps,
  3730			.config_inband = m88e1111_config_inband,
  3731			.config_init = m88e1111gbe_config_init,
  3732			.config_aneg = m88e1111_config_aneg,
  3733			.read_status = marvell_read_status,
  3734			.config_intr = marvell_config_intr,
  3735			.handle_interrupt = marvell_handle_interrupt,
  3736			.resume = genphy_resume,
  3737			.suspend = genphy_suspend,
  3738			.read_page = marvell_read_page,
  3739			.write_page = marvell_write_page,
  3740			.get_sset_count = marvell_get_sset_count,
  3741			.get_strings = marvell_get_strings,
  3742			.get_stats = marvell_get_stats,
  3743			.get_tunable = m88e1111_get_tunable,
  3744			.set_tunable = m88e1111_set_tunable,
  3745			.cable_test_start = m88e1111_vct_cable_test_start,
  3746			.cable_test_get_status = m88e1111_vct_cable_test_get_status,
  3747		},
  3748		{
  3749			.phy_id = MARVELL_PHY_ID_88E1111_FINISAR,
  3750			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3751			.name = "Marvell 88E1111 (Finisar)",
  3752			/* PHY_GBIT_FEATURES */
  3753			.probe = marvell_probe,
  3754			.inband_caps = m88e1111_inband_caps,
  3755			.config_inband = m88e1111_config_inband,
  3756			.config_init = m88e1111gbe_config_init,
  3757			.config_aneg = m88e1111_config_aneg,
  3758			.read_status = marvell_read_status,
  3759			.config_intr = marvell_config_intr,
  3760			.handle_interrupt = marvell_handle_interrupt,
  3761			.resume = genphy_resume,
  3762			.suspend = genphy_suspend,
  3763			.read_page = marvell_read_page,
  3764			.write_page = marvell_write_page,
  3765			.get_sset_count = marvell_get_sset_count,
  3766			.get_strings = marvell_get_strings,
  3767			.get_stats = marvell_get_stats,
  3768			.get_tunable = m88e1111_get_tunable,
  3769			.set_tunable = m88e1111_set_tunable,
  3770		},
  3771		{
  3772			.phy_id = MARVELL_PHY_ID_88E1118,
  3773			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3774			.name = "Marvell 88E1118",
  3775			/* PHY_GBIT_FEATURES */
  3776			.probe = marvell_probe,
  3777			.config_init = m88e1118_config_init,
  3778			.config_aneg = m88e1118_config_aneg,
  3779			.config_intr = marvell_config_intr,
  3780			.handle_interrupt = marvell_handle_interrupt,
  3781			.resume = genphy_resume,
  3782			.suspend = genphy_suspend,
  3783			.read_page = marvell_read_page,
  3784			.write_page = marvell_write_page,
  3785			.get_sset_count = marvell_get_sset_count,
  3786			.get_strings = marvell_get_strings,
  3787			.get_stats = marvell_get_stats,
  3788		},
  3789		{
  3790			.phy_id = MARVELL_PHY_ID_88E1121R,
  3791			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3792			.name = "Marvell 88E1121R",
  3793			.driver_data = DEF_MARVELL_HWMON_OPS(m88e1121_hwmon_ops),
  3794			/* PHY_GBIT_FEATURES */
  3795			.probe = marvell_probe,
  3796			.config_init = marvell_1011gbe_config_init,
  3797			.config_aneg = m88e1121_config_aneg,
  3798			.read_status = marvell_read_status,
  3799			.config_intr = marvell_config_intr,
  3800			.handle_interrupt = marvell_handle_interrupt,
  3801			.resume = genphy_resume,
  3802			.suspend = genphy_suspend,
  3803			.read_page = marvell_read_page,
  3804			.write_page = marvell_write_page,
  3805			.get_sset_count = marvell_get_sset_count,
  3806			.get_strings = marvell_get_strings,
  3807			.get_stats = marvell_get_stats,
  3808			.get_tunable = m88e1011_get_tunable,
  3809			.set_tunable = m88e1011_set_tunable,
  3810		},
  3811		{
  3812			.phy_id = MARVELL_PHY_ID_88E1318S,
  3813			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3814			.name = "Marvell 88E1318S",
  3815			/* PHY_GBIT_FEATURES */
  3816			.probe = marvell_probe,
  3817			.config_init = m88e1318_config_init,
  3818			.config_aneg = m88e1318_config_aneg,
  3819			.read_status = marvell_read_status,
  3820			.config_intr = marvell_config_intr,
  3821			.handle_interrupt = marvell_handle_interrupt,
  3822			.get_wol = m88e1318_get_wol,
  3823			.set_wol = m88e1318_set_wol,
  3824			.resume = genphy_resume,
  3825			.suspend = genphy_suspend,
  3826			.read_page = marvell_read_page,
  3827			.write_page = marvell_write_page,
  3828			.get_sset_count = marvell_get_sset_count,
  3829			.get_strings = marvell_get_strings,
  3830			.get_stats = marvell_get_stats,
  3831			.led_brightness_set = m88e1318_led_brightness_set,
  3832			.led_blink_set = m88e1318_led_blink_set,
  3833			.led_hw_is_supported = m88e1318_led_hw_is_supported,
  3834			.led_hw_control_set = m88e1318_led_hw_control_set,
  3835			.led_hw_control_get = m88e1318_led_hw_control_get,
  3836		},
  3837		{
  3838			.phy_id = MARVELL_PHY_ID_88E1145,
  3839			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3840			.name = "Marvell 88E1145",
  3841			/* PHY_GBIT_FEATURES */
  3842			.flags = PHY_POLL_CABLE_TEST,
  3843			.probe = marvell_probe,
  3844			.config_init = m88e1145_config_init,
  3845			.config_aneg = m88e1101_config_aneg,
  3846			.config_intr = marvell_config_intr,
  3847			.handle_interrupt = marvell_handle_interrupt,
  3848			.resume = genphy_resume,
  3849			.suspend = genphy_suspend,
  3850			.read_page = marvell_read_page,
  3851			.write_page = marvell_write_page,
  3852			.get_sset_count = marvell_get_sset_count,
  3853			.get_strings = marvell_get_strings,
  3854			.get_stats = marvell_get_stats,
  3855			.get_tunable = m88e1111_get_tunable,
  3856			.set_tunable = m88e1111_set_tunable,
  3857			.cable_test_start = m88e1111_vct_cable_test_start,
  3858			.cable_test_get_status = m88e1111_vct_cable_test_get_status,
  3859		},
  3860		{
  3861			.phy_id = MARVELL_PHY_ID_88E1149R,
  3862			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3863			.name = "Marvell 88E1149R",
  3864			/* PHY_GBIT_FEATURES */
  3865			.probe = marvell_probe,
  3866			.config_init = m88e1149_config_init,
  3867			.config_aneg = m88e1118_config_aneg,
  3868			.config_intr = marvell_config_intr,
  3869			.handle_interrupt = marvell_handle_interrupt,
  3870			.resume = genphy_resume,
  3871			.suspend = genphy_suspend,
  3872			.read_page = marvell_read_page,
  3873			.write_page = marvell_write_page,
  3874			.get_sset_count = marvell_get_sset_count,
  3875			.get_strings = marvell_get_strings,
  3876			.get_stats = marvell_get_stats,
  3877		},
  3878		{
  3879			.phy_id = MARVELL_PHY_ID_88E1240,
  3880			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3881			.name = "Marvell 88E1240",
  3882			/* PHY_GBIT_FEATURES */
  3883			.probe = marvell_probe,
  3884			.config_init = m88e1112_config_init,
  3885			.config_aneg = marvell_config_aneg,
  3886			.config_intr = marvell_config_intr,
  3887			.handle_interrupt = marvell_handle_interrupt,
  3888			.resume = genphy_resume,
  3889			.suspend = genphy_suspend,
  3890			.read_page = marvell_read_page,
  3891			.write_page = marvell_write_page,
  3892			.get_sset_count = marvell_get_sset_count,
  3893			.get_strings = marvell_get_strings,
  3894			.get_stats = marvell_get_stats,
  3895			.get_tunable = m88e1011_get_tunable,
  3896			.set_tunable = m88e1011_set_tunable,
  3897		},
  3898		{
  3899			.phy_id = MARVELL_PHY_ID_88E1116R,
  3900			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3901			.name = "Marvell 88E1116R",
  3902			/* PHY_GBIT_FEATURES */
  3903			.probe = marvell_probe,
  3904			.config_init = m88e1116r_config_init,
  3905			.config_intr = marvell_config_intr,
  3906			.handle_interrupt = marvell_handle_interrupt,
  3907			.resume = genphy_resume,
  3908			.suspend = genphy_suspend,
  3909			.read_page = marvell_read_page,
  3910			.write_page = marvell_write_page,
  3911			.get_sset_count = marvell_get_sset_count,
  3912			.get_strings = marvell_get_strings,
  3913			.get_stats = marvell_get_stats,
  3914			.get_tunable = m88e1011_get_tunable,
  3915			.set_tunable = m88e1011_set_tunable,
> 3916			.led_polarity_set = m88e1318_led_polarity_set,
  3917			.led_brightness_set = m88e1318_led_brightness_set,
  3918			.led_blink_set = m88e1318_led_blink_set,
  3919			.led_hw_is_supported = m88e1318_led_hw_is_supported,
  3920			.led_hw_control_set = m88e1318_led_hw_control_set,
  3921			.led_hw_control_get = m88e1318_led_hw_control_get,
  3922		},
  3923		{
  3924			.phy_id = MARVELL_PHY_ID_88E1510,
  3925			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3926			.name = "Marvell 88E1510",
  3927			.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
  3928			.features = PHY_GBIT_FIBRE_FEATURES,
  3929			.flags = PHY_POLL_CABLE_TEST,
  3930			.probe = marvell_probe,
  3931			.config_init = m88e1510_config_init,
  3932			.config_aneg = m88e1510_config_aneg,
  3933			.read_status = marvell_read_status,
  3934			.config_intr = marvell_config_intr,
  3935			.handle_interrupt = marvell_handle_interrupt,
  3936			.get_wol = m88e1318_get_wol,
  3937			.set_wol = m88e1318_set_wol,
  3938			.resume = m88e1510_resume,
  3939			.suspend = marvell_suspend,
  3940			.read_page = marvell_read_page,
  3941			.write_page = marvell_write_page,
  3942			.get_sset_count = marvell_get_sset_count,
  3943			.get_strings = marvell_get_strings,
  3944			.get_stats = marvell_get_stats,
  3945			.set_loopback = m88e1510_loopback,
  3946			.get_tunable = m88e1011_get_tunable,
  3947			.set_tunable = m88e1011_set_tunable,
  3948			.cable_test_start = marvell_vct7_cable_test_start,
  3949			.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
  3950			.cable_test_get_status = marvell_vct7_cable_test_get_status,
  3951			.led_brightness_set = m88e1318_led_brightness_set,
  3952			.led_blink_set = m88e1318_led_blink_set,
  3953			.led_hw_is_supported = m88e1318_led_hw_is_supported,
  3954			.led_hw_control_set = m88e1318_led_hw_control_set,
  3955			.led_hw_control_get = m88e1318_led_hw_control_get,
  3956			.attach_mii_port = m88e1510_attach_mii_port,
  3957		},
  3958		{
  3959			.phy_id = MARVELL_PHY_ID_88E1540,
  3960			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3961			.name = "Marvell 88E1540",
  3962			.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
  3963			/* PHY_GBIT_FEATURES */
  3964			.flags = PHY_POLL_CABLE_TEST,
  3965			.probe = marvell_probe,
  3966			.config_init = marvell_1011gbe_config_init,
  3967			.config_aneg = m88e1510_config_aneg,
  3968			.read_status = marvell_read_status,
  3969			.config_intr = marvell_config_intr,
  3970			.handle_interrupt = marvell_handle_interrupt,
  3971			.resume = genphy_resume,
  3972			.suspend = genphy_suspend,
  3973			.read_page = marvell_read_page,
  3974			.write_page = marvell_write_page,
  3975			.get_sset_count = marvell_get_sset_count,
  3976			.get_strings = marvell_get_strings,
  3977			.get_stats = marvell_get_stats,
  3978			.get_tunable = m88e1540_get_tunable,
  3979			.set_tunable = m88e1540_set_tunable,
  3980			.cable_test_start = marvell_vct7_cable_test_start,
  3981			.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
  3982			.cable_test_get_status = marvell_vct7_cable_test_get_status,
  3983			.led_brightness_set = m88e1318_led_brightness_set,
  3984			.led_blink_set = m88e1318_led_blink_set,
  3985			.led_hw_is_supported = m88e1318_led_hw_is_supported,
  3986			.led_hw_control_set = m88e1318_led_hw_control_set,
  3987			.led_hw_control_get = m88e1318_led_hw_control_get,
  3988		},
  3989		{
  3990			.phy_id = MARVELL_PHY_ID_88E1545,
  3991			.phy_id_mask = MARVELL_PHY_ID_MASK,
  3992			.name = "Marvell 88E1545",
  3993			.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
  3994			.probe = marvell_probe,
  3995			/* PHY_GBIT_FEATURES */
  3996			.flags = PHY_POLL_CABLE_TEST,
  3997			.config_init = marvell_1011gbe_config_init,
  3998			.config_aneg = m88e1510_config_aneg,
  3999			.read_status = marvell_read_status,
  4000			.config_intr = marvell_config_intr,
  4001			.handle_interrupt = marvell_handle_interrupt,
  4002			.resume = genphy_resume,
  4003			.suspend = genphy_suspend,
  4004			.read_page = marvell_read_page,
  4005			.write_page = marvell_write_page,
  4006			.get_sset_count = marvell_get_sset_count,
  4007			.get_strings = marvell_get_strings,
  4008			.get_stats = marvell_get_stats,
  4009			.get_tunable = m88e1540_get_tunable,
  4010			.set_tunable = m88e1540_set_tunable,
  4011			.cable_test_start = marvell_vct7_cable_test_start,
  4012			.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
  4013			.cable_test_get_status = marvell_vct7_cable_test_get_status,
  4014			.led_brightness_set = m88e1318_led_brightness_set,
  4015			.led_blink_set = m88e1318_led_blink_set,
  4016			.led_hw_is_supported = m88e1318_led_hw_is_supported,
  4017			.led_hw_control_set = m88e1318_led_hw_control_set,
  4018			.led_hw_control_get = m88e1318_led_hw_control_get,
  4019		},
  4020		{
  4021			.phy_id = MARVELL_PHY_ID_88E3016,
  4022			.phy_id_mask = MARVELL_PHY_ID_MASK,
  4023			.name = "Marvell 88E3016",
  4024			/* PHY_BASIC_FEATURES */
  4025			.probe = marvell_probe,
  4026			.config_init = m88e3016_config_init,
  4027			.aneg_done = marvell_aneg_done,
  4028			.read_status = marvell_read_status,
  4029			.config_intr = marvell_config_intr,
  4030			.handle_interrupt = marvell_handle_interrupt,
  4031			.resume = genphy_resume,
  4032			.suspend = genphy_suspend,
  4033			.read_page = marvell_read_page,
  4034			.write_page = marvell_write_page,
  4035			.get_sset_count = marvell_get_sset_count,
  4036			.get_strings = marvell_get_strings,
  4037			.get_stats = marvell_get_stats,
  4038		},
  4039		{
  4040			.phy_id = MARVELL_PHY_ID_88E6250_FAMILY,
  4041			.phy_id_mask = MARVELL_PHY_ID_MASK,
  4042			.name = "Marvell 88E6250 Family",
  4043			/* PHY_BASIC_FEATURES */
  4044			.probe = marvell_probe,
  4045			.aneg_done = marvell_aneg_done,
  4046			.config_intr = marvell_config_intr,
  4047			.handle_interrupt = marvell_handle_interrupt,
  4048			.resume = genphy_resume,
  4049			.suspend = genphy_suspend,
  4050			.get_sset_count = marvell_get_sset_count_simple,
  4051			.get_strings = marvell_get_strings_simple,
  4052			.get_stats = marvell_get_stats_simple,
  4053		},
  4054		{
  4055			.phy_id = MARVELL_PHY_ID_88E6341_FAMILY,
  4056			.phy_id_mask = MARVELL_PHY_ID_MASK,
  4057			.name = "Marvell 88E6341 Family",
  4058			.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
  4059			/* PHY_GBIT_FEATURES */
  4060			.flags = PHY_POLL_CABLE_TEST,
  4061			.probe = marvell_probe,
  4062			.config_init = marvell_1011gbe_config_init,
  4063			.config_aneg = m88e6390_config_aneg,
  4064			.read_status = marvell_read_status,
  4065			.config_intr = marvell_config_intr,
  4066			.handle_interrupt = marvell_handle_interrupt,
  4067			.resume = genphy_resume,
  4068			.suspend = genphy_suspend,
  4069			.read_page = marvell_read_page,
  4070			.write_page = marvell_write_page,
  4071			.get_sset_count = marvell_get_sset_count,
  4072			.get_strings = marvell_get_strings,
  4073			.get_stats = marvell_get_stats,
  4074			.get_tunable = m88e1540_get_tunable,
  4075			.set_tunable = m88e1540_set_tunable,
  4076			.cable_test_start = marvell_vct7_cable_test_start,
  4077			.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
  4078			.cable_test_get_status = marvell_vct7_cable_test_get_status,
  4079		},
  4080		{
  4081			.phy_id = MARVELL_PHY_ID_88E6390_FAMILY,
  4082			.phy_id_mask = MARVELL_PHY_ID_MASK,
  4083			.name = "Marvell 88E6390 Family",
  4084			.driver_data = DEF_MARVELL_HWMON_OPS(m88e6390_hwmon_ops),
  4085			/* PHY_GBIT_FEATURES */
  4086			.flags = PHY_POLL_CABLE_TEST,
  4087			.probe = marvell_probe,
  4088			.config_init = marvell_1011gbe_config_init,
  4089			.config_aneg = m88e6390_config_aneg,
  4090			.read_status = marvell_read_status,
  4091			.config_intr = marvell_config_intr,
  4092			.handle_interrupt = marvell_handle_interrupt,
  4093			.resume = genphy_resume,
  4094			.suspend = genphy_suspend,
  4095			.read_page = marvell_read_page,
  4096			.write_page = marvell_write_page,
  4097			.get_sset_count = marvell_get_sset_count,
  4098			.get_strings = marvell_get_strings,
  4099			.get_stats = marvell_get_stats,
  4100			.get_tunable = m88e1540_get_tunable,
  4101			.set_tunable = m88e1540_set_tunable,
  4102			.cable_test_start = marvell_vct7_cable_test_start,
  4103			.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
  4104			.cable_test_get_status = marvell_vct7_cable_test_get_status,
  4105		},
  4106		{
  4107			.phy_id = MARVELL_PHY_ID_88E6393_FAMILY,
  4108			.phy_id_mask = MARVELL_PHY_ID_MASK,
  4109			.name = "Marvell 88E6393 Family",
  4110			.driver_data = DEF_MARVELL_HWMON_OPS(m88e6393_hwmon_ops),
  4111			/* PHY_GBIT_FEATURES */
  4112			.flags = PHY_POLL_CABLE_TEST,
  4113			.probe = marvell_probe,
  4114			.config_init = marvell_1011gbe_config_init,
  4115			.config_aneg = m88e1510_config_aneg,
  4116			.read_status = marvell_read_status,
  4117			.config_intr = marvell_config_intr,
  4118			.handle_interrupt = marvell_handle_interrupt,
  4119			.resume = genphy_resume,
  4120			.suspend = genphy_suspend,
  4121			.read_page = marvell_read_page,
  4122			.write_page = marvell_write_page,
  4123			.get_sset_count = marvell_get_sset_count,
  4124			.get_strings = marvell_get_strings,
  4125			.get_stats = marvell_get_stats,
  4126			.get_tunable = m88e1540_get_tunable,
  4127			.set_tunable = m88e1540_set_tunable,
  4128			.cable_test_start = marvell_vct7_cable_test_start,
  4129			.cable_test_tdr_start = marvell_vct5_cable_test_tdr_start,
  4130			.cable_test_get_status = marvell_vct7_cable_test_get_status,
  4131		},
  4132		{
  4133			.phy_id = MARVELL_PHY_ID_88E1340S,
  4134			.phy_id_mask = MARVELL_PHY_ID_MASK,
  4135			.name = "Marvell 88E1340S",
  4136			.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
  4137			.probe = marvell_probe,
  4138			/* PHY_GBIT_FEATURES */
  4139			.config_init = marvell_1011gbe_config_init,
  4140			.config_aneg = m88e1510_config_aneg,
  4141			.read_status = marvell_read_status,
  4142			.config_intr = marvell_config_intr,
  4143			.handle_interrupt = marvell_handle_interrupt,
  4144			.resume = genphy_resume,
  4145			.suspend = genphy_suspend,
  4146			.read_page = marvell_read_page,
  4147			.write_page = marvell_write_page,
  4148			.get_sset_count = marvell_get_sset_count,
  4149			.get_strings = marvell_get_strings,
  4150			.get_stats = marvell_get_stats,
  4151			.get_tunable = m88e1540_get_tunable,
  4152			.set_tunable = m88e1540_set_tunable,
  4153		},
  4154		{
  4155			.phy_id = MARVELL_PHY_ID_88E1548P,
  4156			.phy_id_mask = MARVELL_PHY_ID_MASK,
  4157			.name = "Marvell 88E1548P",
  4158			.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
  4159			.probe = marvell_probe,
  4160			.features = PHY_GBIT_FIBRE_FEATURES,
  4161			.config_init = marvell_1011gbe_config_init,
  4162			.config_aneg = m88e1510_config_aneg,
  4163			.read_status = marvell_read_status,
  4164			.config_intr = marvell_config_intr,
  4165			.handle_interrupt = marvell_handle_interrupt,
  4166			.resume = genphy_resume,
  4167			.suspend = genphy_suspend,
  4168			.read_page = marvell_read_page,
  4169			.write_page = marvell_write_page,
  4170			.get_sset_count = marvell_get_sset_count,
  4171			.get_strings = marvell_get_strings,
  4172			.get_stats = marvell_get_stats,
  4173			.get_tunable = m88e1540_get_tunable,
  4174			.set_tunable = m88e1540_set_tunable,
  4175			.led_brightness_set = m88e1318_led_brightness_set,
  4176			.led_blink_set = m88e1318_led_blink_set,
  4177			.led_hw_is_supported = m88e1318_led_hw_is_supported,
  4178			.led_hw_control_set = m88e1318_led_hw_control_set,
  4179			.led_hw_control_get = m88e1318_led_hw_control_get,
  4180		},
  4181	};
  4182	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
