Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1B2D7DE9;
	Tue, 27 Jan 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553302; cv=none; b=u/nuPPbu+aoekmkkvdVRn11a5DHh0yU9QdmBCQinlbjrTS96sWiAhwZcYTTUzDsGTwmfwuZuNm5nWLM1IOMaOwCFmeJnTM8sHAoymlEnKYNhyovw6FeV678mdPi+z7keawIZjs3Stz9InifD+vN84S6ZMXkSRFi6q6PskVN6Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553302; c=relaxed/simple;
	bh=T86Adm8Nhx36P0x4VdzPRcfRvJ/b8s2RNm1T0Qjr02c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St7Ql/Dj9SezYlpwdVJ2mi8E4DFf1QTKAk8eoRBQ5RXUeokOaW58p6DbTzxB8ZboZsw306TfeRaR32mrKzr1O2TMPO/gCjq5CsD4ihfWnoV2IT4t7qyol0bypL3Yn2UYOdHnphqAjE4mHiJM0XDQSDlet5OFpGiyiC6WMlDyA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A79q9qOd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A79q9qOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769553301; x=1801089301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T86Adm8Nhx36P0x4VdzPRcfRvJ/b8s2RNm1T0Qjr02c=;
  b=A79q9qOd3mYg8a/53NkeSGXt4tmbqh64QloET0qq/pq0fG5WvV1V07eL
   jjKTINwxWt29yEIM61YKoagzTxougIdRbPTgGVrii/u1lfzY+lkqH5ZPO
   3bfpdexE8lrQmybI20v/sKwMP95vP8n94hYL15u09V2jzPtXc+mSvw+h9
   DCCbY6WxtCm6IoTgHFJCyx04nhn1OF2N7gm8b851FbFrl8Q0klsw5IzO6
   BvHMt2UDmgPszeSP2DVaAEKAc6KckZ2zNxVEGKDdDBGtSfx7lMRss21Tk
   OPoHphHzOL2mhc+6xnrpoGSC5zCkGnz0Kz+ge9E3MKTm6tLk9RPdpbcwu
   A==;
X-CSE-ConnectionGUID: b6hzHjHmRziEO/PpQ6HbMg==
X-CSE-MsgGUID: B9FZTRGvTbi3UFaEJ50Oow==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70655685"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70655685"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:34:59 -0800
X-CSE-ConnectionGUID: RqcPyomiRli3p/TX3Nkb+g==
X-CSE-MsgGUID: Qz3il7tNQHaz8ZZCBnu26A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212201827"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Jan 2026 14:34:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkre9-00000000Yym-1m98;
	Tue, 27 Jan 2026 22:34:53 +0000
Date: Wed, 28 Jan 2026 06:33:56 +0800
From: kernel test robot <lkp@intel.com>
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
	nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Javen Xu <javen_xu@realsil.com.cn>
Subject: Re: [PATCH net-next v1 3/3] realtek: Update Makefile and Kconfig
Message-ID: <202601280645.owh2ZlCS-lkp@intel.com>
References: <20260127113425.1989-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127113425.1989-4-javen_xu@realsil.com.cn>

Hi javen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/javen/r816e-add-a-fake-driver-r816e-for-RTL8116af/20260127-193831
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260127113425.1989-4-javen_xu%40realsil.com.cn
patch subject: [PATCH net-next v1 3/3] realtek: Update Makefile and Kconfig
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260128/202601280645.owh2ZlCS-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601280645.owh2ZlCS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601280645.owh2ZlCS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/r816e/r816e.c:48:32: warning: unused variable 'rtl816e_pm_ops' [-Wunused-const-variable]
      48 | static const struct dev_pm_ops rtl816e_pm_ops = {
         |                                ^~~~~~~~~~~~~~
   1 warning generated.


vim +/rtl816e_pm_ops +48 drivers/net/ethernet/realtek/r816e/r816e.c

638d27c0a2f682 Javen Xu 2026-01-27  47  
638d27c0a2f682 Javen Xu 2026-01-27 @48  static const struct dev_pm_ops rtl816e_pm_ops = {
638d27c0a2f682 Javen Xu 2026-01-27  49  	SYSTEM_SLEEP_PM_OPS(rtl816e_pm_suspend, rtl816e_pm_resume)
638d27c0a2f682 Javen Xu 2026-01-27  50  };
638d27c0a2f682 Javen Xu 2026-01-27  51  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
