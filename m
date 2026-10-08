Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328641C3F0C;
	Thu,  8 Oct 2026 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454263; cv=none; b=WkCIIDLs40VrTRDPqtLtaI3dga+WLVJws5WU+bpu/hgIZ5pjTP8MaziX/TgzFTk1siFZGofclGHrUczuNDarXB62V9sqiWKizugRgxD1KNdYS1WjD5jozd7+Q59SbgaWyc2Kol3GTSgMvmRKo77TJw7y8U8rN+NW5NUy8tA+ZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454263; c=relaxed/simple;
	bh=Ve29xGws9ObLnNv+1Drlon8wCGymFhsD6OD8owNuXBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TowePfippYsjrjSHc3QZB2ILO/VgJb5WNAFXFJiFZp3dginWCbiPsVRVBsG9+fKK8oTHNBDwJZUAuzrudUURx3I5yUa2IaAeIPJZL8Tp5bN2YcdtTjpZzsQ/gMb6ye3yly2etAcoN4s1lTQ5lgqUfORB7ZLqNb8Br6Y7t4FYgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jds53j/6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jds53j/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791454261; x=1822990261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ve29xGws9ObLnNv+1Drlon8wCGymFhsD6OD8owNuXBY=;
  b=Jds53j/64ZLkeWGMI86KCEEFy1vz2On+IDYUTI1eu++gLHfQBaO2ZDcb
   ZDgd3IgQs8i46wM0hx881hraMC1sA1MRwDobo0bz4sRyLst1vX3SEg3py
   VZv74N990ZFVFdC3sYMifKzLO7yX1F1zWRMOal5FaxlxTClx5/xDrKEsV
   f7iKSBBl+9WtsdKsU3AcbsvBYfvNHT76uDKK9rpPqKwzJthBqCaOhq5zg
   POykaU0MXWv4HcSA5IohdqppeJ9kdtWO5UHWEBbQakyg/o7YFK9EbYz37
   0dFB7Pgixsm2vFH7UciCxxLgih1frGdeTQItb2GgnzF41jdSgaOit8BIx
   w==;
X-CSE-ConnectionGUID: +4DRSBDiS9qzS+3xAgVhcw==
X-CSE-MsgGUID: QccwghbYSg+U+G+Q4b/kUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="239619"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="239619"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 03:11:00 -0700
X-CSE-ConnectionGUID: dZlUOiglTrS40/koRBLTUw==
X-CSE-MsgGUID: 3Mp+bY1rSfy1uxR/zSkSJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="108420"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Oct 2026 03:10:56 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEl5R-000000004Gu-00T4;
	Thu, 08 Oct 2026 10:10:53 +0000
Date: Thu, 8 Oct 2026 18:10:40 +0800
From: kernel test robot <lkp@intel.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>, linusw@kernel.org,
	alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk, luizluca@gmail.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 8/8] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
Message-ID: <202610081722.Zoeli0ix-lkp@intel.com>
References: <7e3518aa-4f99-4aae-bd9b-3984bdc4b548@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3518aa-4f99-4aae-bd9b-3984bdc4b548@yahoo.com>

Hi Mieczyslaw,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mieczyslaw-Nalewaj/net-dsa-realtek-rtl8365mb-detect-RTL8367S-VB/20261007-223615
base:   net-next/main
patch link:    https://lore.kernel.org/r/7e3518aa-4f99-4aae-bd9b-3984bdc4b548%40yahoo.com
patch subject: [PATCH net-next 8/8] net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
config: i386-randconfig-1000-20261008 (https://download.01.org/0day-ci/archive/20261008/202610081722.Zoeli0ix-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610081722.Zoeli0ix-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610081722.Zoeli0ix-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_lock' not described in 'rtl8365mb'
>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_relatch' not described in 'rtl8365mb'
>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_relatch_count' not described in 'rtl8365mb'
>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_misc_target_val' not described in 'rtl8365mb'
>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_lock' not described in 'rtl8365mb'
>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_relatch' not described in 'rtl8365mb'
>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_relatch_count' not described in 'rtl8365mb'
>> Warning: drivers/net/dsa/realtek/rtl8365mb_main.c:981 struct member 'sds_misc_target_val' not described in 'rtl8365mb'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
