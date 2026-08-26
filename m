Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B552D0617;
	Wed, 26 Aug 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727128; cv=none; b=YHQ0ky2a6zusQCITIP4ck+pgubCMc78+s3hKpV3U2QqAaXYDlfKL9+svB2vjyvty5CgKKL//3ufoeWZdffvhLML9CYVyIebZLahWT2/UiVxPOoIiIPm5WLUq+O6fgiLHWk47QB9+f5VpjNvkbFh9zjM7F2Etln/IQQKiwsW4Zsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727128; c=relaxed/simple;
	bh=wqWPTIvAKL83aGl0HiFpgUZP2uLr9zLOEr57abq342M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYd16wTGRfNE41St6PAJfZO272fVXoy3IZqc4tl5bhhz8WuCB+7X8clACgBmJ3YraDtk511HpIDboY2h/tnhYCbLbgbw5ZT+k/FOS9x21rlJg1sAjuZTO1vTkDNGGaFpjN8BNjvBTmdwcqdKh5YO3n1ILkhDr2EgXO2nDQtox2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xw24+Y7m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xw24+Y7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787727127; x=1819263127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wqWPTIvAKL83aGl0HiFpgUZP2uLr9zLOEr57abq342M=;
  b=Xw24+Y7mKrhlfZzzJ22SerFdc63vRsMYaOwMlTXD8LNeiyd0dqm9Xj1l
   7LUNGGPelkHz6SjidQ284dc6Hsp3YD1clm28hqfg0ksjgBN+c7YPcfP6i
   oTsxecIBFVB1NhdMxc7a52/wPe/5gTXq7zw7W6zaavxV7pLoIVldbIJy8
   5ZfK3n4/b5/B7VgKbOHmWOqfnVeG28FU+a1NyuaEJ4uulrmt2whXAFk6s
   tU+RzZDZDKNt7gzxmiKBZEeLl+C8ZpKc/FgKAV2PG27TB+sB+pzq/8VMW
   zmJ742XLgZtXmTdhvkSiakMoXWY6tH2MSBRFvk3EoeHACG/c0RHXaOo9Y
   w==;
X-CSE-ConnectionGUID: hHQuW3oZRPaZWVNXHwwh6Q==
X-CSE-MsgGUID: g6KGNCRuQp+Ib144zVQLKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="98536834"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="98536834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 23:52:06 -0700
X-CSE-ConnectionGUID: Wmo/hLY9TVOKTT5iQ+30nA==
X-CSE-MsgGUID: c/E8q47PQtyQ9arsJUYhEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="268073434"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Aug 2026 23:52:01 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wz7UM-0000000077T-0xzT;
	Wed, 26 Aug 2026 06:51:58 +0000
Date: Wed, 26 Aug 2026 14:51:22 +0800
From: kernel test robot <lkp@intel.com>
To: Caleb James DeLisle <cjd@cjdns.fr>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
	naseefkm@gmail.com, joey@tinyisr.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: Re: [PATCH net-next] net: phy: mediatek: add driver for EcoNet Fast
 Ethernet SoC PHYs
Message-ID: <202608261446.DGUqZP2A-lkp@intel.com>
References: <20260825180421.1804729-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825180421.1804729-1-cjd@cjdns.fr>

Hi Caleb,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Caleb-James-DeLisle/net-phy-mediatek-add-driver-for-EcoNet-Fast-Ethernet-SoC-PHYs/20260825-180421
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260825180421.1804729-1-cjd%40cjdns.fr
patch subject: [PATCH net-next] net: phy: mediatek: add driver for EcoNet Fast Ethernet SoC PHYs
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20260826/202608261446.DGUqZP2A-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260826/202608261446.DGUqZP2A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608261446.DGUqZP2A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/phy/mediatek/econet-fe-soc.c:184 function parameter 'phydev' not described in 'poll_cal_complete'
>> Warning: drivers/net/phy/mediatek/econet-fe-soc.c:184 function parameter 'ctx' not described in 'poll_cal_complete'
>> Warning: drivers/net/phy/mediatek/econet-fe-soc.c:233 function parameter 'phydev' not described in 'en751221_fephy_cal_cycle'
>> Warning: drivers/net/phy/mediatek/econet-fe-soc.c:233 expecting prototype for poll_cal_complete(). Prototype was for en751221_fephy_cal_cycle() instead
>> Warning: drivers/net/phy/mediatek/econet-fe-soc.c:184 function parameter 'phydev' not described in 'poll_cal_complete'
>> Warning: drivers/net/phy/mediatek/econet-fe-soc.c:184 function parameter 'ctx' not described in 'poll_cal_complete'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
