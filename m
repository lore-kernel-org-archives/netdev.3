Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4D34BA20
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433435; cv=none; b=GtxDvKtLbJ+N+ukBVo2Ah/2jLdD/0LmBmQSCcX6jnGSi3/1+na01xPa+24Vv39OoZLTl0XwX3LkVBrocUGL7zaZmJtDABsFb8/ORU/PCWAgsYDHv5EJzWO9xsh7bDWofX/NyBI47dO08RvdWfPm7KcF+9f41/Sk9HziJQ2gfxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433435; c=relaxed/simple;
	bh=c8bFi1eRju1L7vEtsiQHSIuqFxoYZANvVh7IdYZgZcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df/8mFn4ibLCchaJFIuF9nPjU5Ri87viOdj98i8CKnyESTpyQkLu/Gy8OZco4HuB+F6pAPtOrW3g+kHUBxChJfsfbNvhdZknRO+z8x0nEAYiXMwVEhxrqoXnd6UJihFUF0mKbupF9gXoa9Rmw0QL8RYq8erDqf25E/FrRsH89rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEt49bHc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEt49bHc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780433434; x=1811969434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c8bFi1eRju1L7vEtsiQHSIuqFxoYZANvVh7IdYZgZcw=;
  b=CEt49bHckzysc78IhGkPWcnN1UOn9FytOyUjr15nrcFLXWd5azWBcW9B
   X6oNf8glTx7TJ8IeergsfFIUSssSSbcRcD6a6SMfIhYP3qBqs57dZUs6R
   2LWjuO7IulAo8cFc4Vd55d476PO3oZZWN92uSYb8VrH1DPaF2nzyZNqiq
   UaDkipsuHj/4N3SzVPc7QLjGN3taShYVe2y8G+Fby0YRp81DCOJjGaeMt
   2IO0KXrqi7S2oYL0ufY3ZN4Km36tcMnGtmVI9jeUWjo8alEMbrQbres1o
   WOQ9dZYnOdJXo/vWOjenWoRJW+Etw7b6cJhCP3PBSGpziHHnbCUpmZJd1
   w==;
X-CSE-ConnectionGUID: vz+z035ASXC0I6hDjnRLOw==
X-CSE-MsgGUID: OQLJlqNuRRqOdt8u9Y4cTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80969319"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80969319"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:50:33 -0700
X-CSE-ConnectionGUID: 6sx5f/l8TGmPjP6Z2GLYZQ==
X-CSE-MsgGUID: qzsigZNmQHyZ+v3bwCsmzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267653490"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 02 Jun 2026 13:50:30 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUW4C-000000001rB-2E0Q;
	Tue, 02 Jun 2026 20:50:28 +0000
Date: Tue, 2 Jun 2026 22:49:38 +0200
From: kernel test robot <lkp@intel.com>
To: Lei Zhu <zhulei_szu@163.com>, kuba@kernel.org, sukhdeeps@marvell.com,
	davem@davemloft.net, andrew+netdev@lunn.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: atlantic: aq_utils_obj_{set|clear}
 optimizations
Message-ID: <202606022243.HUNSnMWR-lkp@intel.com>
References: <20260602092949.263270-1-zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602092949.263270-1-zhulei_szu@163.com>

Hi Lei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lei-Zhu/net-atlantic-aq_utils_obj_-set-clear-optimizations/20260602-174147
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260602092949.263270-1-zhulei_szu%40163.com
patch subject: [PATCH net-next] net: atlantic: aq_utils_obj_{set|clear} optimizations
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260602/202606022243.HUNSnMWR-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606022243.HUNSnMWR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606022243.HUNSnMWR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/aquantia/atlantic/aq_main.c:10:
   In file included from drivers/net/ethernet/aquantia/atlantic/aq_main.h:12:
   In file included from drivers/net/ethernet/aquantia/atlantic/aq_common.h:17:
>> drivers/net/ethernet/aquantia/atlantic/aq_utils.h:21:38: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'int *' [-Werror,-Wincompatible-pointer-types]
      21 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:1275:38: note: passing argument to parameter 'old' here
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                      ^
   In file included from drivers/net/ethernet/aquantia/atlantic/aq_main.c:10:
   In file included from drivers/net/ethernet/aquantia/atlantic/aq_main.h:12:
   In file included from drivers/net/ethernet/aquantia/atlantic/aq_common.h:17:
   drivers/net/ethernet/aquantia/atlantic/aq_utils.h:31:38: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'int *' [-Werror,-Wincompatible-pointer-types]
      31 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:1275:38: note: passing argument to parameter 'old' here
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                      ^
   2 errors generated.
--
   In file included from drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c:10:
   In file included from drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:15:
   In file included from drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_common.h:17:
>> drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_utils.h:21:38: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'int *' [-Werror,-Wincompatible-pointer-types]
      21 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:1275:38: note: passing argument to parameter 'old' here
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                      ^
   In file included from drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c:10:
   In file included from drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:15:
   In file included from drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_common.h:17:
   drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_utils.h:31:38: error: incompatible pointer types passing 'unsigned long *' to parameter of type 'int *' [-Werror,-Wincompatible-pointer-types]
      31 |         } while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
         |                                             ^~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:1275:38: note: passing argument to parameter 'old' here
    1275 | atomic_try_cmpxchg(atomic_t *v, int *old, int new)
         |                                      ^
   2 errors generated.


vim +21 drivers/net/ethernet/aquantia/atlantic/aq_utils.h

    13	
    14	static inline void aq_utils_obj_set(atomic_t *flags, u32 mask)
    15	{
    16		unsigned long flags_old, flags_new;
    17	
    18		flags_old = atomic_read(flags);
    19		do {
    20			flags_new = flags_old | (mask);
  > 21		} while (!atomic_try_cmpxchg(flags, &flags_old, flags_new));
    22	}
    23	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
