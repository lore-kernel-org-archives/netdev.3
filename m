Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA88388E75;
	Sun, 10 May 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416968; cv=none; b=lzX2wWPOsiMgfmwVhNWxcKqJ7S4ZFDrefPF5HqmEWnY7hbnwqn72LVr2pvdiMtMbTymjp6FV7zjZXKVI6byjXb3G+k2Nto6wBonCbXKFNiKwTgXpwG6KK4qUb+p6GHr18ZAo+/nW8wM/RsQvGQGcfdw53ZL9zunF+/ED0e8qssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416968; c=relaxed/simple;
	bh=/60CTdOmhFw7w8TxfJ1EtfjlkwUbc3InAg+lUYT5eEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av8Fo7ghEnr1WUrp6kx6Mox8VUxIRY1Y/R2WzvmHc9x01gnowiXRffDy3qD5YG8gbFId3hV2Meo0p+LH6Y0m0OKw5cEpfIQ4PcYwIry2vdeG24QYdRaAb4/iG5G4rOu0F+wynHpuFxF1A0SjhDF4I7Heexiu9kTvUdFL0ep9vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt8JJ+n+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt8JJ+n+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778416965; x=1809952965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/60CTdOmhFw7w8TxfJ1EtfjlkwUbc3InAg+lUYT5eEg=;
  b=Zt8JJ+n+k+6t77U6+yddxBVx2CcStY9GbLrKPoy39ewMclLXpdU9aG9Z
   lO1ZQMaMizZlNklVF69504/VELrdO6vgNcJMA8vA+Nbn5MLogcGkKzvED
   wKU78JVNJVsuw13msSOxSddHa5ofFgeNy+GMPskVADzHl9w0Vy5HMmvZG
   DcCdxek1+QYPA18TKHZii66rYe2GOwSPlArvQ4BnGNPQGTXn5S9bLNtcB
   prTtDzJZKoXXiqSSba/XfD8J1hUJV3kKnF2wHSnzbgtPHf07FAzGtez39
   BXdViNrqIGkiit2xKw/lZGCRGR5ZhG76J139CO+3DARgx9CYXWtiX/Bbb
   A==;
X-CSE-ConnectionGUID: du7K3U2jRzOFM9LBIYeO3Q==
X-CSE-MsgGUID: rXwcmAb+QEOXSd980krcLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="90792633"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="90792633"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:42:45 -0700
X-CSE-ConnectionGUID: NN2vNHRmQ1KiXiunPx3uOg==
X-CSE-MsgGUID: 26UwaYqjTvOfoVcncvQ0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239028669"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 10 May 2026 05:42:42 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wM3UW-000000007in-0uil;
	Sun, 10 May 2026 12:42:40 +0000
Date: Sun, 10 May 2026 14:41:52 +0200
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 5/5] net: mdiobus: Hide acpi_mdio.h
Message-ID: <202605101457.OWzRvBTB-lkp@intel.com>
References: <20260504074610.40799-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504074610.40799-6-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/net-mdiobus-Provide-fwnode_mdiobus_register/20260510-124038
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260504074610.40799-6-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH net-next v1 5/5] net: mdiobus: Hide acpi_mdio.h
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260510/202605101457.OWzRvBTB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101457.OWzRvBTB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101457.OWzRvBTB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/mdio/fwnode_mdio.c:197:10: error: call to undeclared function '__of_mdiobus_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     197 |                 return __of_mdiobus_register(mdio, to_of_node(fwnode), owner);
         |                        ^
   drivers/net/mdio/fwnode_mdio.c:197:10: note: did you mean 'of_mdiobus_register'?
   include/linux/of_mdio.h:81:19: note: 'of_mdiobus_register' declared here
      81 | static inline int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
         |                   ^
   1 error generated.


vim +/__of_mdiobus_register +197 drivers/net/mdio/fwnode_mdio.c

   192	
   193	int __fwnode_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle *fwnode,
   194				      struct module *owner)
   195	{
   196		if (is_of_node(fwnode))
 > 197			return __of_mdiobus_register(mdio, to_of_node(fwnode), owner);

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
