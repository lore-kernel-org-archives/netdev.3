Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE782538D91;
	Wed, 23 Sep 2026 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178847; cv=none; b=h6nNPc3WwXsVUabC4UzmUW2Bvf1dmfFkIXdlA2lhxT0u6hvSLSv6aumhsaZeMxREhsto6bCTYG0I9ve8nZtprei3D5EMJN6ueJcKOX5Tt13MToD+CnWIoU7RJg+WQqfkgE3WLNWcr7Obnimz9Yxz7zqq7r+UFD/5gE0DjcRqFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178847; c=relaxed/simple;
	bh=u/EwzTM/NnzSfEVRVlTGSUu5KUBYwA6lJMr21sRdsVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6lG7WmmSvenu8vK3Jy4wJR2J0vccS7cJcz7k1P/lqQrIeYH5PaYKo0R1r1eaUKTf7dl1Uvv5DtWrlX8CMfBWW3OAPn4osBHBzeCu2TrcHR92tV19UflR5My+0+Jy8aqPcyc0VjsfcPghSBndz8DfBTsVNf14T27S1Rb+wY56KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XswdCqAa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XswdCqAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790178844; x=1821714844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/EwzTM/NnzSfEVRVlTGSUu5KUBYwA6lJMr21sRdsVY=;
  b=XswdCqAaCIbFxxdECoTsS3fZ3p+tPQkUv6iFPIPpLrbxqiF/aMh1rj9f
   LmiXy/DnqbJjV5Dl4AfKftA8LtIERv14LPVaM+uRDigL6pwWqFtHmqCLZ
   THOvlId3RGGMCEgJml08AFKYAtqfxp2OvYeDO/aOZyB9fQjKb7jFKwdsY
   S3So9IOPb6jT2l5lMHObsWIDBDvMX5OUzEFl8iYoBDy1E2mfoHuxVSO9i
   NNaWgk0d+B1xRakvsJ/or8+3A/Qiy+rvi5SHwEQVqCs895US3CZx2r7BC
   FNq3q8VZeb0C+vorO0ZOHfo0ohb9abfh8SQk1wq5aAWiKAXmlT6l2AZ4G
   Q==;
X-CSE-ConnectionGUID: 5unWjHipRPa+8a8lreBPFw==
X-CSE-MsgGUID: DNgVM7L2QsiFymg9jIkH1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78445058"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78445058"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:54:03 -0700
X-CSE-ConnectionGUID: 7lue524bROaPLXzmdodnwA==
X-CSE-MsgGUID: 36FTiqfuQTOcmIIrMf9pGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4756769"
Received: from igk-lkp-server01.igk.intel.com (HELO 1bbc298b9a73) ([10.211.93.152])
  by fmviesa011.fm.intel.com with ESMTP; 23 Sep 2026 08:54:00 -0700
Received: from kbuild by 1bbc298b9a73 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9PIA-000000000j5-0Jdb;
	Wed, 23 Sep 2026 15:53:54 +0000
Date: Wed, 23 Sep 2026 17:53:25 +0200
From: kernel test robot <lkp@intel.com>
To: Coia Prant <coiaprant@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: Re: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak
 when the PHY clock fails
Message-ID: <202609231728.boP5N9Xr-lkp@intel.com>
References: <20260919174223.2356964-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919174223.2356964-1-coiaprant@gmail.com>

Hi Coia,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Coia-Prant/net-ethernet-stmmac-dwmac-rk-fix-bulk-clock-leak-when-the-PHY-clock-fails/20260920-014223
base:   net/main
patch link:    https://lore.kernel.org/r/20260919174223.2356964-1-coiaprant%40gmail.com
patch subject: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260923/202609231728.boP5N9Xr-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260923/202609231728.boP5N9Xr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609231728.boP5N9Xr-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c: In function 'gmac_clk_enable':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1165:25: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1165 |                         if (ret)
         |                         ^~
   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1168:33: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1168 |                                 return ret;
         |                                 ^~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c: At top level:
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1177:11: error: expected identifier or '(' before 'else'
    1177 |         } else {
         |           ^~~~
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1189:9: error: expected identifier or '(' before 'return'
    1189 |         return 0;
         |         ^~~~~~
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1190:1: error: expected identifier or '(' before '}' token
    1190 | }
         | ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c: In function 'gmac_clk_enable':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1177:9: warning: control reaches end of non-void function [-Wreturn-type]
    1177 |         } else {
         |         ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c: At top level:
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:199:12: warning: 'rk_gate_rmii_clock' defined but not used [-Wunused-function]
     199 | static int rk_gate_rmii_clock(struct rk_priv_data *bsp_priv)
         |            ^~~~~~~~~~~~~~~~~~


vim +1177 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

7ad269ea1a2b7d Roger Chen            2014-12-29  1152  
7ad269ea1a2b7d Roger Chen            2014-12-29  1153  static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
7ad269ea1a2b7d Roger Chen            2014-12-29  1154  {
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1155  	int ret;
7ad269ea1a2b7d Roger Chen            2014-12-29  1156  
7ad269ea1a2b7d Roger Chen            2014-12-29  1157  	if (enable) {
7ad269ea1a2b7d Roger Chen            2014-12-29  1158  		if (!bsp_priv->clk_enabled) {
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1159  			ret = clk_bulk_prepare_enable(bsp_priv->num_clks,
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1160  						      bsp_priv->clks);
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1161  			if (ret)
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1162  				return ret;
7ad269ea1a2b7d Roger Chen            2014-12-29  1163  
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1164  			ret = clk_prepare_enable(bsp_priv->clk_phy);
ea449f7fa0bf3f Sebastian Reichel     2023-04-07 @1165  			if (ret)
cb278e6780d874 Coia Prant            2026-09-20  1166  				clk_bulk_disable_unprepare(bsp_priv->num_clks,
cb278e6780d874 Coia Prant            2026-09-20  1167  							   bsp_priv->clks);
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1168  				return ret;
cb278e6780d874 Coia Prant            2026-09-20  1169  			}
23c94d63a7e395 David Wu              2018-06-28  1170  
5c1fc7cb81dfed Russell King (Oracle  2026-02-04  1171) 			rk_configure_io_clksel(bsp_priv);
5c1fc7cb81dfed Russell King (Oracle  2026-02-04  1172) 			rk_ungate_rmii_clock(bsp_priv);
2f2b60a0ec2826 David Wu              2022-08-30  1173  
7ad269ea1a2b7d Roger Chen            2014-12-29  1174  			mdelay(5);
7ad269ea1a2b7d Roger Chen            2014-12-29  1175  			bsp_priv->clk_enabled = true;
7ad269ea1a2b7d Roger Chen            2014-12-29  1176  		}
7ad269ea1a2b7d Roger Chen            2014-12-29 @1177  	} else {
7ad269ea1a2b7d Roger Chen            2014-12-29  1178  		if (bsp_priv->clk_enabled) {
5c1fc7cb81dfed Russell King (Oracle  2026-02-04  1179) 			rk_gate_rmii_clock(bsp_priv);
7f864458e9a6d2 Sebastian Reichel     2025-10-14  1180  
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1181  			clk_bulk_disable_unprepare(bsp_priv->num_clks,
ea449f7fa0bf3f Sebastian Reichel     2023-04-07  1182  						   bsp_priv->clks);
fecd4d7eef8b21 David Wu              2017-08-10  1183  			clk_disable_unprepare(bsp_priv->clk_phy);
fecd4d7eef8b21 David Wu              2017-08-10  1184  
7ad269ea1a2b7d Roger Chen            2014-12-29  1185  			bsp_priv->clk_enabled = false;
7ad269ea1a2b7d Roger Chen            2014-12-29  1186  		}
7ad269ea1a2b7d Roger Chen            2014-12-29  1187  	}
7ad269ea1a2b7d Roger Chen            2014-12-29  1188  
7ad269ea1a2b7d Roger Chen            2014-12-29 @1189  	return 0;
7ad269ea1a2b7d Roger Chen            2014-12-29 @1190  }
7ad269ea1a2b7d Roger Chen            2014-12-29  1191  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
