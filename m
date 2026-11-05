Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907182;
	b=Bp3zmzOvkX+dLedniSJpWxlRCHr5a4UlaKQ3WwURU5kyNqiQIFIjzW5dgfTVS3NWGit/
	 4m/N/DYnG2/aSBou+940oKuQDj0mMgn+LzTHhb/3UmARdd1rj1tQypxK8+yxpyh+kJdNe
	 QZBxeynzIb5KDjiljmEg7USSho1JW5qpi8j56eCG83oOQNdaMN/OESVUZfNmTa4mq42QY
	 tRXAClULSKnD7a2H1ioWbiRAkhX3ne798Aw3kxSafR6ock270M0H22QTRyR+1RNB5vysh
	 y+yDGaFXj+xKi2ItQo54ol8TjWMK9RZ/+huFxvTdtHizgSWwv4og88vvMsmjulI09DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907182;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KxYRMKoqQ5TnAo9ahTf6HCh0udvu+2ZmgUNQu1zf6ms=;
	b=xgxv6uNmQ3G2sXWbfrWpL7Rj9U1cbuE4pM+S2npdHblahYpuHmPcL3MSvY7MX7Gv/B6c
	 I5NCOjpQ/W27pJ2D2z+rPafm+oDi9Ui293zI1vWvAOw9Ne1HY8K+uRbgnD073c7WcIIBT
	 z55z/wL93dPSMhUsSzQ2z96lfcDP1YC9vokBLLOjrMjFzY7yF/5yw3n9RDGeVC9mSF2cV
	 5Cfi9yCYsyMi/hBjReNNG+a4rdJhiz0AmY+SYXNlUvTaLJ4yOdWUGxrxGrcycNQxQnq0s
	 +cQ2W6W0NIuiauhXPMpBnzcY7/cSA22BNedSqMrbgwWrx52Dp02PmDSZ1/vGF9t3cbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jOfpmpLY;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5181606A6C2;
	Thu,  5 Nov 2026 19:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5181606A6C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jOfpmpLY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793907181; x=1825443181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U2hJrtx423sVNdvYtSAVrbMHTJILFCRiIFLpGmwhIKM=;
  b=jOfpmpLYYZtpthv0VTaFjtFt1hdu7pV3MIZvIvV0CsgsTeA1SMSrncnU
   G2nRfRU+wHLrDW33z0gletbIA7AhM91tT1ACCux/bFU51yDtty9VU9FF4
   Wb8ozw4kGzWJCNFmaZjPLaAV6+eSZCc/Gh0CSBr563oe+3YniJS9XvXTX
   7gwSjmvw//5/aJAmaC6ji47sXxFuaxeuzBBOgHNj8239Frxk6ms2UbRi8
   feDCUEJiIzXSVtBSVaz9fQlRoHHdk5fNlivOk+yTVRnEOYlsoZHV57S/d
   nIf4YdoBs62DdYkyz5Tf88XCkaNAmLFXnwbd+upEtkOfDyeuVqZ0kbgi+
   w==;
X-CSE-ConnectionGUID: +MBlz0aFQeajoIomjma54Q==
X-CSE-MsgGUID: UK48iO1RT2+tJoZh/kRbEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2612782"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2612782"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 11:33:01 -0800
X-CSE-ConnectionGUID: GZhcWmofSJua3QNT4LoHNg==
X-CSE-MsgGUID: ndfzCq+qR/y14KywqvrBUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8854806"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 05 Nov 2026 11:32:56 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP3Ce-00000000ml8-3B51;
	Thu, 05 Nov 2026 19:32:52 +0000
Date: Fri, 6 Nov 2026 03:32:11 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/6] net: phy: add additional helper for PHY
 package
Message-ID: <202611060219.OYeac0uG-lkp@intel.com>
References: <20261105105504.1024-4-ansuelsmth@gmail.com>
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
In-Reply-To: <20261105105504.1024-4-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-mediatek-export-__mtk_tr_write/20261105-115457
base:   net-next/main
patch link:    https://lore.kernel.org/r/20261105105504.1024-4-ansuelsmth%40gmail.com
patch subject: [PATCH net-next v5 3/6] net: phy: add additional helper for PHY package
config: sh-randconfig-1000-20261105 (https://download.01.org/0day-ci/archive/20261106/202611060219.OYeac0uG-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060219.OYeac0uG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060219.OYeac0uG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/phy/phy_package.c:82 expecting prototype for phy_package_unlock(). Prototype was for phy_package_offset() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
