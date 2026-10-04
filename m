Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F822F60CC;
	Sun,  4 Oct 2026 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129208; cv=none; b=lZtaWB6Zp+bxYuxflqrnOEnlJTLbZQnmpgKbCld7sfRsuJal8pj+fKRgArvKJ1/6/6dhOy0VpLgB1f17kv3+zO7AszEm7daDx8CDv9kGzNiEhPaReUsyHK0EvfLQgMVn8fstg0u1recrqeem1UuJC/1P9D5AP8T4XJXGZNKxB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129208; c=relaxed/simple;
	bh=lv1tuIGYGldphto25KVS1nVNoKz+O4guecPc91FwUq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEFsKoHi/v1bpIfBOxmS4xBOQWaaX32buCc/0o2URskMXEZP3ElC+3YQfcvf8gT6YjnCqNQD7uoCFkrpNbu7L6hzh0j5+I7GSbB2nRCE0I51T8bABvpulAiYH6abK5DiC10ZbtlUC80lKtnMXbBXzIXwG1pn+yLLg+FMdidBPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/rhd/M+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/rhd/M+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791129205; x=1822665205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lv1tuIGYGldphto25KVS1nVNoKz+O4guecPc91FwUq8=;
  b=a/rhd/M+HNhyj7UGj4+jyBY4CpPsxLeTN/XKLSYpdSLMpdr4d5kugj1l
   fAf1zNW7MuI6RXVHwyAgcg0b/f94pzOw/SJkytwwlHiPFJZGw9HeA2QS7
   bPS1jf14N+9K3nyDWUiai0W53NeiWNJ1VegNe0CBBtFa2MZhTV2onlM9X
   88MA1CdmjbOX2D9VSEW9/RG4PoVCtP81+ypn3CV8yCfuG7akvcA9QSqKv
   4maMcLKifI1kDfWEorJxl7JzA3N4hPTQACblGq9rofCKi7nOGTzW/zAne
   F1hhrg3vXH9iXspA3JydVGtZ0OHTa0A0YMgtw6WH2LpPozWq2LixruGPK
   Q==;
X-CSE-ConnectionGUID: R/5P0wIPTKeHbxZGDXb/Tw==
X-CSE-MsgGUID: hPVCoSMdS0+TN9Te4Q+JGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="95627949"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="95627949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 08:53:23 -0700
X-CSE-ConnectionGUID: oEBoJPlCQ2G9hBPfsJYkmw==
X-CSE-MsgGUID: tlqqacLyQbeHvEGJeU3+Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="314637099"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Oct 2026 08:53:19 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDOWa-00000000UqT-0uUY;
	Sun, 04 Oct 2026 15:53:16 +0000
Date: Sun, 4 Oct 2026 23:52:18 +0800
From: kernel test robot <lkp@intel.com>
To: Birger Koblitz <mail@birger-koblitz.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Eric Dumazet <edumazet@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, Jianhui Xu <neuromoments@gmail.com>,
	Birger Koblitz <mail@birger-koblitz.de>
Subject: Re: [PATCH net-next v16 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <202610042301.MlmvbRpS-lkp@intel.com>
References: <20261004-ax88179a-v16-13-2a9ae4e68f7b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-ax88179a-v16-13-2a9ae4e68f7b@birger-koblitz.de>

Hi Birger,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 071876fd50482a68603a9460d80dd6dd58827ee1]

url:    https://github.com/intel-lab-lkp/linux/commits/Birger-Koblitz/phylink-Add-phylink_mac_interrupt/20261004-073905
base:   071876fd50482a68603a9460d80dd6dd58827ee1
patch link:    https://lore.kernel.org/r/20261004-ax88179a-v16-13-2a9ae4e68f7b%40birger-koblitz.de
patch subject: [PATCH net-next v16 13/13] ax88796b: Add support for AX88772D, AX88179A and AX88279
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20261004/202610042301.MlmvbRpS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261004/202610042301.MlmvbRpS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610042301.MlmvbRpS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/m68k/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:369,
                    from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from drivers/net/phy/ax88796b.c:6:
   drivers/net/phy/ax88796b.c: In function 'asix_ax88772D_get_features':
>> drivers/net/phy/ax88796b.c:217:42: warning: unused variable 'mask' [-Wunused-variable]
     217 |         __ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
         |                                          ^~~~
   include/linux/types.h:10:23: note: in definition of macro 'DECLARE_BITMAP'
      10 |         unsigned long name[BITS_TO_LONGS(bits)]
         |                       ^~~~
   drivers/net/phy/ax88796b.c:217:9: note: in expansion of macro '__ETHTOOL_DECLARE_LINK_MODE_MASK'
     217 |         __ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mask +217 drivers/net/phy/ax88796b.c

   213	
   214	static int asix_ax88772D_get_features(struct phy_device *phydev)
   215	{
   216		int ret;
 > 217		__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
   218	
   219		/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
   220		phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
   221	
   222		ret = genphy_read_abilities(phydev);
   223		if (ret < 0)
   224			return ret;
   225	
   226		/* AX88772D does not support reported 1000baseT mode */
   227		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);
   228	
   229		return 0;
   230	}
   231	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
