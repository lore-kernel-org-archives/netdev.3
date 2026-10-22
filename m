Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648950;
	b=JNqUbBo+sYsDux64YTqEE1WnzpZcgLw0W40tIYK+VYknKs9Pl2YO9O8GiAFi07kQPS0U
	 HwQ2Zixf+b8YT2bT+Nr076ti0pF38Wfxo1KXfF8tnnB1Y9sqitimKARHl3svHLvVV+XlI
	 ZUL+dJP41scsGVElmn+QH1J7VwEBXUmQYS5VtPxYWiUFoq1ZRRPr2PlzfcJJ7xkMmdFUq
	 yNSx0E7Tytr1PwAomsMysgIM3CdJbz/2VVnut2eYVuhXYfugfa8q7ejudx6GpiLbyESsP
	 95Pv8QB3K78W0lJWK3cGFhRfo2YDwXwv7Qdi15T3rlHgJbSUiL19lL2tBRnlYMta6fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648950;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=h7yy4ERCejIWJUHBaiW1M9hFVXwnhpKlFetEGTE4qE8=;
	b=V7/fc7uj7dVtGoGErDEPCcK899wkyEku6iaDQNujKwY62fVTn/UKJt0B1Szu8w093bb1
	 GVS62VD14dyOzXI+xZCIoV4tnut2u1DZhMR5gHtK3CYeMeXe1uBiht2dExqlyj2dtEbxx
	 Fx8oc4E+AG4ZFzAIg94B3kWkneZb4zIlrIV40Kz5qEqN7+AtK6kdWEAdxMTclZ6FPUZUB
	 vIy5wb6N9EwINCoORCnznx13ed7MkPf9ZaxBiGuJkM8p6OpzpeZGUF4lY4sZW+hHtvZLy
	 f8IxIUYSJQKbZo+OEDpFFljZqX3NtNl1fx08R5WovZ/Q7A3fRRW74iFqcZ8gCjHRiBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ejl443HM;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEB606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 06:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDEB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ejl443HM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792648949; x=1824184949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v1kuDdvZyLBvH1hitXXm71AvDg8GURL01c2wxP2YwcE=;
  b=ejl443HMpF5Azd4uK4sCeivJa4Lmgu/zVfkot0qzBX1jJGlPMgcxNWiq
   63SVZeF20MpIgB6IjTs+PCLTo2PZPYj2zyZvT1B1IUWAQF130EtUU0IOY
   N5ZzKRjX6ppgeza5dHdSmTsdU6HD8s/f9H5XEYelpr58VamIyCsn0dorK
   m2hK/BN4xfJ4iMVFfu3nZLSME1IOt8DgHeQ8nKDhVlkzUok2hwDptv/Ky
   ZQB0fVkn3hWFEg6F1xAu9zLynE4DStCpqlHs4mflfaEQgwOMUGfsCNqTm
   MWMxiK44eiZeFAMSTXhFOOJbz8nbyLC57edXNC+wjHGwrxVQvFS3yLWqj
   Q==;
X-CSE-ConnectionGUID: rP9pnOCURfucyuw0GyCPvg==
X-CSE-MsgGUID: dlwDokvWS+qB4Smdmh7IbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1258429"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1258429"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 23:02:20 -0700
X-CSE-ConnectionGUID: 3xt7Bb08QHqzLGMMiaV6SA==
X-CSE-MsgGUID: gg1NACHpR/2u0GnVF9SKgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3161632"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Oct 2026 23:02:12 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xJlsO-00000000Qcc-2m0t;
	Thu, 22 Oct 2026 06:02:08 +0000
Date: Thu, 22 Oct 2026 14:01:16 +0800
From: kernel test robot <lkp@intel.com>
To: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH 07/27] clk: rockchip: Add RK3572 clock and reset support
Message-ID: <202610221315.TGWtYMdM-lkp@intel.com>
References: <20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee@qq.com>

Hi Cunhao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a804c5742bff224d4cb4d25dd383554d598be32b]

url:    https://github.com/intel-lab-lkp/linux/commits/Cunhao-Lu-via-B4-Relay/dt-bindings-clock-rockchip-Add-RK3572-CRU/20261022-001058
base:   a804c5742bff224d4cb4d25dd383554d598be32b
patch link:    https://lore.kernel.org/r/20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee%40qq.com
patch subject: [PATCH 07/27] clk: rockchip: Add RK3572 clock and reset support
config: arm-randconfig-1001-20261022 (https://download.01.org/0day-ci/archive/20261022/202610221315.TGWtYMdM-lkp@intel.com/config)
compiler: clang version 21.1.8 (https://github.com/llvm/llvm-project 2078da43e25a4623cab2d0d60decddf709aaea28)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261022/202610221315.TGWtYMdM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610221315.TGWtYMdM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/rockchip/clk-rk3572.c:121:40: warning: implicit conversion from 'int' to 's16' (aka 'short') changes value from 47185 to -18351 [-Wconstant-conversion]
     121 |         RK3588_PLL_RATE(266580000, 1, 178, 4, 47185),
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/clk/rockchip/clk.h:607:7: note: expanded from macro 'RK3588_PLL_RATE'
     604 |         .p = _p,                                                \
         |         ~
     605 |         .m = _m,                                                \
     606 |         .s = _s,                                                \
     607 |         .k = _k,                                                \
         |              ^~
   drivers/clk/rockchip/clk-rk3572.c:116:40: warning: implicit conversion from 'int' to 's16' (aka 'short') changes value from 52428 to -13108 [-Wconstant-conversion]
     116 |         RK3588_PLL_RATE(604800000, 1, 101, 2, 52428),
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/clk/rockchip/clk.h:607:7: note: expanded from macro 'RK3588_PLL_RATE'
     604 |         .p = _p,                                                \
         |         ~
     605 |         .m = _m,                                                \
     606 |         .s = _s,                                                \
     607 |         .k = _k,                                                \
         |              ^~
   drivers/clk/rockchip/clk-rk3572.c:112:40: warning: implicit conversion from 'int' to 's16' (aka 'short') changes value from 43690 to -21846 [-Wconstant-conversion]
     112 |         RK3588_PLL_RATE(773000000, 2, 258, 2, 43690),
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/clk/rockchip/clk.h:607:7: note: expanded from macro 'RK3588_PLL_RATE'
     604 |         .p = _p,                                                \
         |         ~
     605 |         .m = _m,                                                \
     606 |         .s = _s,                                                \
     607 |         .k = _k,                                                \
         |              ^~
   drivers/clk/rockchip/clk-rk3572.c:98:41: warning: implicit conversion from 'int' to 's16' (aka 'short') changes value from 52559 to -12977 [-Wconstant-conversion]
      98 |         RK3588_PLL_RATE(1186812000, 2, 198, 1, 52559),
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/clk/rockchip/clk.h:607:7: note: expanded from macro 'RK3588_PLL_RATE'
     604 |         .p = _p,                                                \
         |         ~
     605 |         .m = _m,                                                \
     606 |         .s = _s,                                                \
     607 |         .k = _k,                                                \
         |              ^~
   drivers/clk/rockchip/clk-rk3572.c:97:41: warning: implicit conversion from 'int' to 's16' (aka 'short') changes value from 52581 to -12955 [-Wconstant-conversion]
      97 |         RK3588_PLL_RATE(1186814000, 2, 198, 1, 52581),
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   drivers/clk/rockchip/clk.h:607:7: note: expanded from macro 'RK3588_PLL_RATE'
     604 |         .p = _p,                                                \
         |         ~
     605 |         .m = _m,                                                \
     606 |         .s = _s,                                                \
     607 |         .k = _k,                                                \
         |              ^~
   5 warnings generated.


vim +121 drivers/clk/rockchip/clk-rk3572.c

    43	
    44	static struct rockchip_pll_rate_table rk3572_pll_rates[] = {
    45		/* _mhz, _p, _m, _s, _k */
    46		RK3588_PLL_RATE(2520000000, 2, 210, 0, 0),
    47		RK3588_PLL_RATE(2496000000, 2, 208, 0, 0),
    48		RK3588_PLL_RATE(2472000000, 2, 206, 0, 0),
    49		RK3588_PLL_RATE(2448000000, 2, 204, 0, 0),
    50		RK3588_PLL_RATE(2424000000, 2, 202, 0, 0),
    51		RK3588_PLL_RATE(2400000000, 2, 200, 0, 0),
    52		RK3588_PLL_RATE(2376000000, 2, 198, 0, 0),
    53		RK3588_PLL_RATE(2352000000, 2, 196, 0, 0),
    54		RK3588_PLL_RATE(2328000000, 2, 194, 0, 0),
    55		RK3588_PLL_RATE(2304000000, 2, 192, 0, 0),
    56		RK3588_PLL_RATE(2280000000, 2, 190, 0, 0),
    57		RK3588_PLL_RATE(2256000000, 2, 376, 1, 0),
    58		RK3588_PLL_RATE(2232000000, 2, 372, 1, 0),
    59		RK3588_PLL_RATE(2208000000, 2, 368, 1, 0),
    60		RK3588_PLL_RATE(2184000000, 2, 364, 1, 0),
    61		RK3588_PLL_RATE(2160000000, 2, 360, 1, 0),
    62		RK3588_PLL_RATE(2136000000, 2, 356, 1, 0),
    63		RK3588_PLL_RATE(2112000000, 2, 352, 1, 0),
    64		RK3588_PLL_RATE(2088000000, 2, 348, 1, 0),
    65		RK3588_PLL_RATE(2064000000, 2, 344, 1, 0),
    66		RK3588_PLL_RATE(2040000000, 2, 340, 1, 0),
    67		RK3588_PLL_RATE(2016000000, 2, 336, 1, 0),
    68		RK3588_PLL_RATE(1992000000, 2, 332, 1, 0),
    69		RK3588_PLL_RATE(1968000000, 2, 328, 1, 0),
    70		RK3588_PLL_RATE(1944000000, 2, 324, 1, 0),
    71		RK3588_PLL_RATE(1920000000, 2, 320, 1, 0),
    72		RK3588_PLL_RATE(1896000000, 2, 316, 1, 0),
    73		RK3588_PLL_RATE(1872000000, 2, 312, 1, 0),
    74		RK3588_PLL_RATE(1848000000, 2, 308, 1, 0),
    75		RK3588_PLL_RATE(1824000000, 2, 304, 1, 0),
    76		RK3588_PLL_RATE(1800000000, 2, 300, 1, 0),
    77		RK3588_PLL_RATE(1776000000, 2, 296, 1, 0),
    78		RK3588_PLL_RATE(1752000000, 2, 292, 1, 0),
    79		RK3588_PLL_RATE(1728000000, 2, 288, 1, 0),
    80		RK3588_PLL_RATE(1704000000, 2, 284, 1, 0),
    81		RK3588_PLL_RATE(1680000000, 2, 280, 1, 0),
    82		RK3588_PLL_RATE(1656000000, 2, 276, 1, 0),
    83		RK3588_PLL_RATE(1632000000, 2, 272, 1, 0),
    84		RK3588_PLL_RATE(1608000000, 2, 268, 1, 0),
    85		RK3588_PLL_RATE(1584000000, 2, 264, 1, 0),
    86		RK3588_PLL_RATE(1560000000, 2, 260, 1, 0),
    87		RK3588_PLL_RATE(1536000000, 2, 256, 1, 0),
    88		RK3588_PLL_RATE(1512000000, 2, 252, 1, 0),
    89		RK3588_PLL_RATE(1488000000, 2, 248, 1, 0),
    90		RK3588_PLL_RATE(1464000000, 2, 244, 1, 0),
    91		RK3588_PLL_RATE(1440000000, 2, 240, 1, 0),
    92		RK3588_PLL_RATE(1416000000, 2, 236, 1, 0),
    93		RK3588_PLL_RATE(1392000000, 2, 232, 1, 0),
    94		RK3588_PLL_RATE(1320000000, 2, 220, 1, 0),
    95		RK3588_PLL_RATE(1200000000, 2, 200, 1, 0),
    96		RK3588_PLL_RATE(1188000000, 2, 198, 1, 0),
    97		RK3588_PLL_RATE(1186814000, 2, 198, 1, 52581),
    98		RK3588_PLL_RATE(1186812000, 2, 198, 1, 52559),
    99		RK3588_PLL_RATE(1109000000, 3, 554, 2, 32767),
   100		RK3588_PLL_RATE(1100000000, 3, 550, 2, 0),
   101		RK3588_PLL_RATE(1051000000, 3, 525, 2, 32767),
   102		RK3588_PLL_RATE(1008000000, 2, 336, 2, 0),
   103		RK3588_PLL_RATE(1000000000, 3, 500, 2, 0),
   104		RK3588_PLL_RATE(983040000, 4, 655, 2, 23592),
   105		RK3588_PLL_RATE(955520000, 3, 478, 2, -15730),
   106		RK3588_PLL_RATE(903168000, 6, 903, 2, 11009),
   107		RK3588_PLL_RATE(900000000, 2, 300, 2, 0),
   108		RK3588_PLL_RATE(816000000, 2, 272, 2, 0),
   109		RK3588_PLL_RATE(786432000, 2, 262, 2, 9437),
   110		RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
   111		RK3588_PLL_RATE(785560000, 3, 393, 2, -14419),
   112		RK3588_PLL_RATE(773000000, 2, 258, 2, 43690),
   113		RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
   114		RK3588_PLL_RATE(697000000, 2, 232, 2, 21845),
   115		RK3588_PLL_RATE(610400000, 3, 305, 2, 13107),
   116		RK3588_PLL_RATE(604800000, 1, 101, 2, 52428),
   117		RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
   118		RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
   119		RK3588_PLL_RATE(408000000, 2, 272, 3, 0),
   120		RK3588_PLL_RATE(312000000, 2, 208, 3, 0),
 > 121		RK3588_PLL_RATE(266580000, 1, 178, 4, 47185),
   122		RK3588_PLL_RATE(216000000, 2, 288, 4, 0),
   123		RK3588_PLL_RATE(96000000, 2, 256, 5, 0),
   124		{ /* sentinel */ },
   125	};
   126	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
