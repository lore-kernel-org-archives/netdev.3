Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734337BE64;
	Mon, 10 Aug 2026 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350084; cv=none; b=emsiHH10wunhzLpzIQcZmB61BEJGIdSFFk6TdCf6cftDNU2SvYBvUHlMxcKc0e5B7M4OBzqYMv6K0YsKZNbCPf5Vv2ImL8vvbUyfP6PYDTH6+ynYhLkL0ajA/VhkVPw+ocxcbWvmGmog7BvEyOaStNpayPyHX3HO4li0Ym7ecrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350084; c=relaxed/simple;
	bh=Uds+KfnCuVCHCjE6IJNNEt0K81+/pL4NyqOKLJwsz2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWNmQAl4sLQnUsUMtaSoawvx+3Jdr3Eub0Isq6coNYyNayhbDbU97jlDxCT8qig21d0ybGCGqolZ40tuI7stiY3hnoWM70UIDO6NNmOvVLEP5bUBgSvRT5IBJJEyPH7hfHpzCQoBrMaDxX4tBjrGCWbKpQmkq6tFkDxP5zcYR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIlqDs/+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIlqDs/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350082; x=1817886082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uds+KfnCuVCHCjE6IJNNEt0K81+/pL4NyqOKLJwsz2Y=;
  b=hIlqDs/+OmdInEA7AU/xStO9FweG2q4TwuMDPMy1Ke4jEeIXIET9JxSd
   3xybyu3ygeyDduH2jXlsOhHR3VyXYoPz/n+IyqBstBQLgKLfeYeHbjrRh
   kWfKFHALO7nIEDmwpvRlLiQ7oy3UpBhbzpizx6NCIsTESDrniB80+09HA
   1djcdeBwGB4H6CmpdJ7yAy3zL0CaCkxryfmZ+1tUj9kaoehKuwkV6UrEx
   RDw/7OPxqNRtd0RS0IJlYiV3qyR6FdiyAKyxEeJxY92rh/P3pmCLxK7tn
   LIwHk9epzX5hOHuz9xw3v1SDIwYImbqQ8q1dR/bfP3J5lFy6knwU+qgFA
   Q==;
X-CSE-ConnectionGUID: tcpYOt1+SAuV011DbDptow==
X-CSE-MsgGUID: ij8Y3uRETF6zv6yfaNc3kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86617211"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86617211"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:21:21 -0700
X-CSE-ConnectionGUID: e/5yw1o9SMegScwc7Nmp0g==
X-CSE-MsgGUID: ObiF1C4LRwi39QobwjDH9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="263023521"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Aug 2026 01:21:20 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wtLG0-00000000N2U-3YJN;
	Mon, 10 Aug 2026 08:21:16 +0000
Date: Mon, 10 Aug 2026 16:20:33 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Foster <colin.foster@in-advantage.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH v1] smsc911x: add second read of EEPROM mac when possible
 corruption seen
Message-ID: <202608101549.Sbhie1Im-lkp@intel.com>
References: <20250828214452.11683-1-colin.foster@in-advantage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828214452.11683-1-colin.foster@in-advantage.com>

Hi Colin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on horms-ipvs/master]
[cannot apply to linus/master v7.2-rc6 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Foster/smsc911x-add-second-read-of-EEPROM-mac-when-possible-corruption-seen/20260810-123819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
patch link:    https://lore.kernel.org/r/20250828214452.11683-1-colin.foster%40in-advantage.com
patch subject: [PATCH v1] smsc911x: add second read of EEPROM mac when possible corruption seen
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260810/202608101549.Sbhie1Im-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260810/202608101549.Sbhie1Im-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608101549.Sbhie1Im-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/smsc/smsc911x.c: In function 'smsc911x_read_mac_address':
>> drivers/net/ethernet/smsc/smsc911x.c:2179:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    2179 |         u8 addr[ETH_ALEN];
         |         ^~


vim +2179 drivers/net/ethernet/smsc/smsc911x.c

631b7568c7d8f0 drivers/net/smsc911x.c               Steve Glendinning 2008-12-25  2160  
31f4574774e98a drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2161  /* copies the current mac address from hardware to dev->dev_addr */
8489ec1f970064 drivers/net/ethernet/smsc/smsc911x.c Bill Pemberton    2012-12-03  2162  static void smsc911x_read_mac_address(struct net_device *dev)
31f4574774e98a drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2163  {
31f4574774e98a drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2164  	struct smsc911x_data *pdata = netdev_priv(dev);
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2165  	u32 mac_high16, mac_low32;
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2166  
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2167  	mac_high16 = smsc911x_mac_read(pdata, ADDRH);
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2168  	mac_low32 = smsc911x_mac_read(pdata, ADDRL);
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2169  
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2170  	/*
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2171  	 * The first mac_read always returns 0. Re-read it to get the
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2172  	 * full MAC
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2173  	 */
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2174  	if (mac_high16 == 0) {
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2175  		SMSC_TRACE(pdata, probe, "Re-read MAC ADDRH\n");
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2176  		mac_high16 = smsc911x_mac_read(pdata, ADDRH);
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2177  	}
8b1e595e2e7800 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2178  
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18 @2179  	u8 addr[ETH_ALEN];
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2180  
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2181  	addr[0] = (u8)(mac_low32);
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2182  	addr[1] = (u8)(mac_low32 >> 8);
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2183  	addr[2] = (u8)(mac_low32 >> 16);
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2184  	addr[3] = (u8)(mac_low32 >> 24);
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2185  	addr[4] = (u8)(mac_high16);
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2186  	addr[5] = (u8)(mac_high16 >> 8);
f15fef4c0675d4 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2187  	eth_hw_addr_set(dev, addr);
31f4574774e98a drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2188  }
31f4574774e98a drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2189  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
