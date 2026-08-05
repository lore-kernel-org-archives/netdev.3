Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01754570FF;
	Wed,  5 Aug 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932813; cv=none; b=T9BSijRmySmls9R4z2302/581TqyoifuontZm3yAXXdAb7xrDG4LgEaRSctwsR/P+kZu7hmSfdtzAQ9PIxR6eRQi8L6AbbR9tdVGQGTZv89ezNfEGudwIdiyWB+ZDoiupA5K9UtkP70K4RqNA0m0RXDgFDEQbXWKwuj+LfQT1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932813; c=relaxed/simple;
	bh=uqmQXf9AW6etaZgYbZKcqE3mPAZ2aOwMC8yLbR19ebQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skAA4wDezvpOMT47KXBJ0xqb0z4hv7J9kA9sRdiERETlWNwk8yTcmAXiwG/fIi2hgCN+3/V7B3Qasur72ys4ep/b5bcixANJgdEhAoqNmFHEVEek4u8JXexe3QkPNC6TWtqikPxzCiU9ItWa7zHtAUzkCmriTugad1kTPY54/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOw48LHh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOw48LHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932812; x=1817468812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uqmQXf9AW6etaZgYbZKcqE3mPAZ2aOwMC8yLbR19ebQ=;
  b=YOw48LHhwkcx6Lfx66I6UeB030ynVASBYK4CgdPkQBks5+2D4snyF6O7
   sgkuJHsjIj2x9pmMwIEMqiyvKVPjMoeabghuoedmPpvrxpqYw6Nq+Ye1M
   GkaV/mzuv4OEbewWE86LxoInwbAWVB+Yxi6YEws4cZL31q4CCo0pu0JI9
   FYhLFlY74aApXnYSGBOMIq1mtDeTjJ95G1BGH1iCE+BRASR1buB3LXcvQ
   mEmSfkl6f1XK0BO4m3PRXaRJAgzx2/Vtw1Tvb7Mr+zA1ABMZYk6iG1ETt
   1lLZUWpn9B2Q7lzBQv+9CgMOGBfJoetG54HqmZxOvDWXFDHhUyFQpHd1f
   A==;
X-CSE-ConnectionGUID: vreUpdsNQsuFPyDC2xMVYA==
X-CSE-MsgGUID: OFrZDzcxRZqN5tUZdSmWrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90320140"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90320140"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:26:42 -0700
X-CSE-ConnectionGUID: YgxTbfAySVysgKcM9hBq1w==
X-CSE-MsgGUID: DOZ7DtYTQJiKyve5zv5HgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265635846"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 05:26:39 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrahg-00000000CRR-2i0j;
	Wed, 05 Aug 2026 12:26:36 +0000
Date: Wed, 5 Aug 2026 20:26:19 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Switch <kyle.switch@motor-comm.com>, Frank.Sae@motor-comm.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianmin.wang@motor-comm.com,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Message-ID: <202608052037.5FzKDBji-lkp@intel.com>
References: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714111203.3852126-1-kyle.switch@motor-comm.com>

Hi Kyle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on linus/master v7.2-rc6 next-20260804]
[cannot apply to net-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Switch/net-phy-Add-driver-for-Motorcomm-Quad-2-5GbE-phy/20260805-175843
base:   net/main
patch link:    https://lore.kernel.org/r/20260714111203.3852126-1-kyle.switch%40motor-comm.com
patch subject: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260805/202608052037.5FzKDBji-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608052037.5FzKDBji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608052037.5FzKDBji-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/phy/motorcomm.c:519 function parameter 'val' not described in 'ytphy_write_top_ext'
>> Warning: drivers/net/phy/motorcomm.c:3230 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * configuration YT8824 to one template test mode.
   Warning: drivers/net/phy/motorcomm.c:3255 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * enable YT8824 serdes isolate.
   Warning: drivers/net/phy/motorcomm.c:3284 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * do YT8824 UTP softreset.
   Warning: drivers/net/phy/motorcomm.c:3321 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * disable YT8824 template test mode.
   Warning: drivers/net/phy/motorcomm.c:3356 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * disable YT8824 serdes isolate.
   Warning: drivers/net/phy/motorcomm.c:3464 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * external YT8824 init
   Warning: drivers/net/phy/motorcomm.c:3933 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * internal YT8824 init
>> Warning: drivers/net/phy/motorcomm.c:4351 expecting prototype for yt8824_config_aneg(). Prototype was for yt8824_aneg_done() instead
>> Warning: drivers/net/phy/motorcomm.c:4380 function parameter 'status' not described in 'yt8824_read_status_paged'
>> Warning: drivers/net/phy/motorcomm.c:4380 function parameter 'lpa' not described in 'yt8824_read_status_paged'
>> Warning: drivers/net/phy/motorcomm.c:4454 function parameter 'reg_space' not described in 'yt8824_utp_power_on'
>> Warning: drivers/net/phy/motorcomm.c:4487 function parameter 'reg_space' not described in 'yt8824_utp_power_down'
>> Warning: drivers/net/phy/motorcomm.c:519 function parameter 'val' not described in 'ytphy_write_top_ext'
>> Warning: drivers/net/phy/motorcomm.c:4380 function parameter 'status' not described in 'yt8824_read_status_paged'
>> Warning: drivers/net/phy/motorcomm.c:4380 function parameter 'lpa' not described in 'yt8824_read_status_paged'
>> Warning: drivers/net/phy/motorcomm.c:4454 function parameter 'reg_space' not described in 'yt8824_utp_power_on'
>> Warning: drivers/net/phy/motorcomm.c:4487 function parameter 'reg_space' not described in 'yt8824_utp_power_down'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
