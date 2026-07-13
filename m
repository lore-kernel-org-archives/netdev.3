Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31430433E65
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949129; cv=none; b=b3oRFUv+NWCrhjmXA52i7ohBcqBQcVOfa7Fv2AHML2M/29740CYwlHRoVSbWocUwX7JWgdNI3PQqXtnihQ9R6OaahWaRqfEyqiplg6t/vb6A3xLmO3EEqzF89NIytjFW/hDOHvREBinYzarSlFpq0r/eseJTBreqo+Hk27hWgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949129; c=relaxed/simple;
	bh=YTZIugLN4IiaJdfBc70pfN2xjrX1JYrbfy7t5+whm/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkMOMMf3m8zh+Qip09BFGSZCavlYY8WAOlkeOSHwY7SfHx7b8WiWlIMCjdQM0r/XK5f0gwPPaUwCCLqNHgC0pwfNZvK5LFHLtb182qTudOGbgDv5Y+r49KQiExnC1ks+yf4+/KxvbmpOvos4rbP9RtNq0SRuxOszezqNjqUwToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAG0nL3F; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAG0nL3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783949127; x=1815485127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YTZIugLN4IiaJdfBc70pfN2xjrX1JYrbfy7t5+whm/A=;
  b=NAG0nL3F97gGjYbjNSnN78H8YypWjeSeIbkkM2jW/mjqnFJO4PnSxVsN
   kPaxEIrkO2Xa0Kt1/NccTT5d8cf0xk6doeePvqSV0nyYLeQc6khkIjmi2
   UaBvVy0jSfBJKjqsuC7aMZcsQDk5b/y6/iWXj3qsXkgglsXIfD574VPLd
   xnc0G68koNogfjGoPoPn0H/5HWGAmizcL8rhZ+uE3tFmMlPvbj2HT6L3x
   PFvSZvvF/NCegkf4EhI+6Jzu1LlEGLRrxmkPiYc91gl6bHSj/+8U7UQcz
   4XgbwvlleAmqRePZQW5rW3arxwzPxQvmEb9wVR69MpIHU5E+ST+ZsLgz3
   w==;
X-CSE-ConnectionGUID: Pd/dTBoQTV6wT5OacuKZnQ==
X-CSE-MsgGUID: CG2sllLUQ9Ouzklvnm1uVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83535565"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83535565"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 06:25:20 -0700
X-CSE-ConnectionGUID: +lCnMDODQaOe+e/33U3UUw==
X-CSE-MsgGUID: 21JMF5jpTASzccV2oFwccQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259136810"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2026 06:25:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjGep-00000000Lid-3xXF;
	Mon, 13 Jul 2026 13:25:15 +0000
Date: Mon, 13 Jul 2026 21:24:52 +0800
From: kernel test robot <lkp@intel.com>
To: David 'equinox' Lamparter <equinox@diac24.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	David 'equinox' Lamparter <equinox@diac24.net>
Subject: Re: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
Message-ID: <202607132109.n8GCw6cD-lkp@intel.com>
References: <20260713080634.296011-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713080634.296011-1-equinox@diac24.net>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-equinox-Lamparter/mptcp-sockopt-implement-IPV6_TCLASS/20260713-162825
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260713080634.296011-1-equinox%40diac24.net
patch subject: [PATCH net-next] mptcp: sockopt: implement IPV6_TCLASS
config: sparc-randconfig-001 (https://download.01.org/0day-ci/archive/20260713/202607132109.n8GCw6cD-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260713/202607132109.n8GCw6cD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607132109.n8GCw6cD-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: net/mptcp/sockopt.o: in function `mptcp_setsockopt_v6':
>> sockopt.c:(.text+0x908): undefined reference to `ipv6_setsockopt'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
