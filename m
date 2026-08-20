Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5C43C7C8
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787227186; cv=none; b=k5/G2sZ+RwjGjT0461oFzLLc99LyfALEi7F/Q/6tFWhVpHgmlvB3UH/gQKvTghstf+8ukzno7ty1UVmYHi7+RiKU/A9Tr7fk67qRvOYrDeS9+wNbt140SeeJhS8dHwoFJuan4tOFgSZm8TWbLZ9h3uUVGO35bGjmrLzio8eWiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787227186; c=relaxed/simple;
	bh=diX554OBl0W3vwW6SuH+V3gsfZ0jJ2r8Sz7urKKnovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LULDgYCl01qBP5nJAay2YIbQYcvGSXpEv2C7mrtEATqsdm8IBOHdYNyafesO3DSa1B4E/eeKHbn168+I9XjQpC3KGVkvHG+mUzXHnDOIrLJpPi9jjaufdqPow/wi+nSjAt5i1zIHgOyNmqGIlsnbmIsqLwXkuEq8iPKwb9XDRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivl0NpEU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivl0NpEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787227184; x=1818763184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=diX554OBl0W3vwW6SuH+V3gsfZ0jJ2r8Sz7urKKnovk=;
  b=ivl0NpEU0VUAoIdW0YqFzU2p3B8XaYzqB/eMHPglbLfKIYltR5ezJK64
   vKeLX/848NtoEGJdTE4SaAuRogIii+Pg+oEvMuUvtMu/e17hu/hQzCl3O
   1UuoFMfOdWHHfIknHV1sJkauOaGzv0qVP5iTh79w9vpB/9fb5aiXuepqr
   ezLHUicugnvHzFmEMcQSoRRUsZZDiN2fpABldJhw7pcaQVPjzqo3T/hWh
   ZJ8oVtqT3kwI9qQiqE/USNMjQYDTT4CcczTLVB5PpxxL7gU46egYyy5MC
   R9ZBOoE3oVdTn+OnDeg6mudGB4f5OP5MSnYzg3GWi0BEH293QSvkNyHL5
   Q==;
X-CSE-ConnectionGUID: hWmVvwwrQUCCl2uRMaSF3w==
X-CSE-MsgGUID: K94hNRwUQCKcxFm5OWjp9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98916003"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="98916003"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:59:43 -0700
X-CSE-ConnectionGUID: rGwitO/QRS2scau7Yg2e6g==
X-CSE-MsgGUID: F4YmSQm8ScG0DSOgS0ZahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="264670674"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 04:59:41 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wx1Qp-00000000iuf-04bn;
	Thu, 20 Aug 2026 11:59:39 +0000
Date: Thu, 20 Aug 2026 19:58:54 +0800
From: kernel test robot <lkp@intel.com>
To: Xander Wilmink <xwilmink@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Xander Wilmink <xwilmink@gmail.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH net-next] net: sfp: Add quirk for Dell M14MK module
Message-ID: <202608201918.cysp4l1G-lkp@intel.com>
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
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260820/202608201918.cysp4l1G-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 935bfc708590c60147a79c7df145bb6e68b1d388)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201918.cysp4l1G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201918.cysp4l1G-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/sfp.c:489:1: error: function definition is not allowed here
     489 | {
         | ^
   drivers/net/phy/sfp.c:495:1: error: function definition is not allowed here
     495 | {
         | ^
   drivers/net/phy/sfp.c:505:1: error: function definition is not allowed here
     505 | {
         | ^
>> drivers/net/phy/sfp.c:615:36: error: use of undeclared identifier 'sfp_quirk_ubnt_uf_instant'
     615 |         SFP_QUIRK_S("UBNT", "UF-INSTANT", sfp_quirk_ubnt_uf_instant),
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/phy/sfp.c:631:35: error: use of undeclared identifier 'sfp_quirk_oem_2_5g'
     631 |         SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |                                          ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:650:38: error: use of undeclared identifier 'sfp_quirk_oem_2_5g'
     650 |         SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
         |                                             ^~~~~~~~~~~~~~~~~~
   drivers/net/phy/sfp.c:654:1: error: function definition is not allowed here
     654 | {
         | ^
   drivers/net/phy/sfp.c:668:1: error: function definition is not allowed here
     668 | {
         | ^
   drivers/net/phy/sfp.c:680:1: error: function definition is not allowed here
     680 | {
         | ^
   drivers/net/phy/sfp.c:698:1: error: function definition is not allowed here
     698 | {
         | ^
   drivers/net/phy/sfp.c:714:1: error: function definition is not allowed here
     714 | {
         | ^
   drivers/net/phy/sfp.c:719:1: error: function definition is not allowed here
     719 | {
         | ^
   drivers/net/phy/sfp.c:756:1: error: function definition is not allowed here
     756 | {
         | ^
   drivers/net/phy/sfp.c:796:1: error: function definition is not allowed here
     796 | {
         | ^
   drivers/net/phy/sfp.c:823:1: error: function definition is not allowed here
     823 | {
         | ^
   drivers/net/phy/sfp.c:880:1: error: function definition is not allowed here
     880 | {
         | ^
   drivers/net/phy/sfp.c:934:1: error: function definition is not allowed here
     934 | {
         | ^
   drivers/net/phy/sfp.c:982:1: error: function definition is not allowed here
     982 | {
         | ^
   drivers/net/phy/sfp.c:1005:1: error: function definition is not allowed here
    1005 | {
         | ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +489 drivers/net/phy/sfp.c

23571c7b964374 Russell King (Oracle     2022-09-13  479) 
008809b6223aa2 Xander Wilmink           2026-08-07  480  static void sfp_quirk_25g_10g_dual(const struct sfp_eeprom_id *id,
008809b6223aa2 Xander Wilmink           2026-08-07  481  				   struct sfp_module_caps *caps)
008809b6223aa2 Xander Wilmink           2026-08-07  482  {
008809b6223aa2 Xander Wilmink           2026-08-07  483  	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
008809b6223aa2 Xander Wilmink           2026-08-07  484  			 caps->link_modes);
008809b6223aa2 Xander Wilmink           2026-08-07  485  	__set_bit(PHY_INTERFACE_MODE_10GBASER, caps->interfaces);
008809b6223aa2 Xander Wilmink           2026-08-07  486  
50e96acbe11667 Russell King (Oracle     2023-03-21  487) static void sfp_quirk_disable_autoneg(const struct sfp_eeprom_id *id,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  488) 				      struct sfp_module_caps *caps)
50e96acbe11667 Russell King (Oracle     2023-03-21 @489) {
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  490) 	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, caps->link_modes);
50e96acbe11667 Russell King (Oracle     2023-03-21  491) }
50e96acbe11667 Russell King (Oracle     2023-03-21  492) 
50e96acbe11667 Russell King (Oracle     2023-03-21  493) static void sfp_quirk_oem_2_5g(const struct sfp_eeprom_id *id,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  494) 			       struct sfp_module_caps *caps)
50e96acbe11667 Russell King (Oracle     2023-03-21  495) {
50e96acbe11667 Russell King (Oracle     2023-03-21  496) 	/* Copper 2.5G SFP */
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  497) 	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  498) 			 caps->link_modes);
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  499) 	__set_bit(PHY_INTERFACE_MODE_2500BASEX, caps->interfaces);
a7dc35a9e49b10 Russell King (Oracle     2025-09-16  500) 	sfp_quirk_disable_autoneg(id, caps);
50e96acbe11667 Russell King (Oracle     2023-03-21  501) }
50e96acbe11667 Russell King (Oracle     2023-03-21  502) 
23571c7b964374 Russell King (Oracle     2022-09-13  503) static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
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
a7dc35a9e49b10 Russell King (Oracle     2025-09-16 @631) 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
