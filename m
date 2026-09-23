Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05033D6D6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205417; cv=none; b=j80XwXaKIAP55Mmfzlkjr/dj5e3cZOVQjTEGTKx3mCmNKQERkBiT4YilB/OuSk3G40nYN3Qny76Zob4chVdv6RgFPVu3yC+xFuSFu8Qjq8CsY7klS7pBm1s47gtZ2sq5M2Bp7pr2tFNHPUq7avSodPtrnGFnRDgvOcb/Do144ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205417; c=relaxed/simple;
	bh=pJiQzfEtxkf5k9yaCp4XwKPrj6ad9HuAVEdVLL0rdQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbLxLsXUgLelDYTBDRVcaOOKhJsxyLv5+x07NXkS3fL/pRjj55hJ/SL4be1y6240PnPepHZLFqAYBzYiQM7FCsmM2ZviaGn9xCTAloAlxxlS9W/COeTd+PbWQyE4TkdldEMD9dQbo5V3dawa7e8477Mm+F6CzokQgVmwSRXiMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZ+bxKCJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZ+bxKCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790205416; x=1821741416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pJiQzfEtxkf5k9yaCp4XwKPrj6ad9HuAVEdVLL0rdQg=;
  b=GZ+bxKCJZvZ+8UYiwm2PQczw8aElXncwkG0lN+YdPnc/k2hvbCcFfipJ
   fza0ZgZ4OOQtuKEKLg3SAGc7ndz2KAMJhmhPvXzG+rbDni+fZGq1Kd0jW
   LwIk9NF8AOriXGbkwqvts6E7KZ3VW+6mpOfvXN84p0ggCsmLL4wJs86mc
   j0IA6Hoqmbpb2jmXmB3J3gOqNntJg2DP3poKvQTUKo3DrbSulS0PfyQmT
   cX+ieMEkHUDwvrrCgoVleFUF380eFljeFlxO01kSSxNMm8pVl9TNElyP+
   hwkJ7Cu7Ft8HDLb7fzwjd+y6ICJRSgMwjuCS1SEIZLqZWcl1yyKqOBI+Z
   A==;
X-CSE-ConnectionGUID: 1bK/dELqTDyNd+OQzXDAkQ==
X-CSE-MsgGUID: Q4ABhHQUQLWIHsxfvFIKmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="116476159"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="116476159"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 16:16:55 -0700
X-CSE-ConnectionGUID: 60YdIln9QK2Mk04bYRgL3g==
X-CSE-MsgGUID: xN7tmTuoQa+vPJTNSyldsQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2026 16:16:51 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9WCl-00000000Hwc-3oRt;
	Wed, 23 Sep 2026 23:16:47 +0000
Date: Thu, 24 Sep 2026 07:16:40 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: Re: [PATCH net] net: stmmac: propagate PTP addend and system time
 programming errors
Message-ID: <202609240727.6U1AzUEr-lkp@intel.com>
References: <20260920-stmmac-ptp-added-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-stmmac-ptp-added-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-stmmac-propagate-PTP-addend-and-system-time-programming-errors/20260920-150002
base:   1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
patch link:    https://lore.kernel.org/r/20260920-stmmac-ptp-added-systime-error-v1-1-8ac9e7a3fce2%40oss.qualcomm.com
patch subject: [PATCH net] net: stmmac: propagate PTP addend and system time programming errors
config: arm-defconfig (https://download.01.org/0day-ci/archive/20260924/202609240727.6U1AzUEr-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 6e714c8d91116794cb699cdf80c26afe9cda3ef3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260924/202609240727.6U1AzUEr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609240727.6U1AzUEr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:613:2: warning: variable 'sec_inc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     613 |         stmmac_config_sub_second_increment(priv, priv->ptpaddr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     614 |                                            priv->plat->clk_ptp_rate,
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~
     615 |                                            xmac, &sec_inc);
         |                                            ~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/hwif.h:517:2: note: expanded from macro 'stmmac_config_sub_second_increment'
     517 |         stmmac_do_void_callback(__priv, ptp, config_sub_second_increment, __args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/hwif.h:15:6: note: expanded from macro 'stmmac_do_void_callback'
      15 |         if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) { \
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:617:25: note: uninitialized use occurs here
     617 |         priv->sub_second_inc = sec_inc;
         |                                ^~~~~~~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:613:2: note: remove the 'if' if its condition is always true
     613 |         stmmac_config_sub_second_increment(priv, priv->ptpaddr,
         |         ^
   drivers/net/ethernet/stmicro/stmmac/hwif.h:517:2: note: expanded from macro 'stmmac_config_sub_second_increment'
     517 |         stmmac_do_void_callback(__priv, ptp, config_sub_second_increment, __args)
         |         ^
   drivers/net/ethernet/stmicro/stmmac/hwif.h:15:2: note: expanded from macro 'stmmac_do_void_callback'
      15 |         if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) { \
         |         ^
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:613:2: warning: variable 'sec_inc' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
     613 |         stmmac_config_sub_second_increment(priv, priv->ptpaddr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     614 |                                            priv->plat->clk_ptp_rate,
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~
     615 |                                            xmac, &sec_inc);
         |                                            ~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/hwif.h:517:2: note: expanded from macro 'stmmac_config_sub_second_increment'
     517 |         stmmac_do_void_callback(__priv, ptp, config_sub_second_increment, __args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/hwif.h:15:6: note: expanded from macro 'stmmac_do_void_callback'
      15 |         if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) { \
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:617:25: note: uninitialized use occurs here
     617 |         priv->sub_second_inc = sec_inc;
         |                                ^~~~~~~
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:613:2: note: remove the '&&' if its condition is always true
     613 |         stmmac_config_sub_second_increment(priv, priv->ptpaddr,
         |         ^
   drivers/net/ethernet/stmicro/stmmac/hwif.h:517:2: note: expanded from macro 'stmmac_config_sub_second_increment'
     517 |         stmmac_do_void_callback(__priv, ptp, config_sub_second_increment, __args)
         |         ^
   drivers/net/ethernet/stmicro/stmmac/hwif.h:15:6: note: expanded from macro 'stmmac_do_void_callback'
      15 |         if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) { \
         |             ^
   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:609:13: note: initialize the variable 'sec_inc' to silence this warning
     609 |         u32 sec_inc;
         |                    ^
         |                     = 0
   2 warnings generated.


vim +613 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

   603	
   604	static void stmmac_restore_subsecond_increment(struct stmmac_priv *priv,
   605						       u32 default_addend,
   606						       u32 systime_flags)
   607	{
   608		bool xmac = dwmac_is_xmac(priv->plat->core_type);
   609		u32 sec_inc;
   610	
   611		stmmac_config_addend(priv, priv->ptpaddr, default_addend);
   612		stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 > 613		stmmac_config_sub_second_increment(priv, priv->ptpaddr,
   614						   priv->plat->clk_ptp_rate,
   615						   xmac, &sec_inc);
   616		priv->default_addend = default_addend;
   617		priv->sub_second_inc = sec_inc;
   618	}
   619	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
