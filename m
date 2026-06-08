Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EF30E82C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952411; cv=none; b=D6YRFapM+TLwZO5NZh1VC6aIXmzhPQweNcPbZUfzjTlE7vdRhg8TzGUDdRyXV4v7NA7qx8c+NCeyTwPjv2fEiS1ekKnBFGiTmvGSd1MtcuJYY1XMGrLpMY0oNXeTJSvvf6nnnknl6vUPvW/Nxt+ESS6DpPjFZa5MU2blVJleERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952411; c=relaxed/simple;
	bh=EzPcnQ7vHIJ+uEHwcq52m+xA51HveVoU2O9tNfJu+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp2CuW5y0BQQLrfuhNlX65YZbCB83BuywYbih+B3ovJfGLCOChsBV9N6J3esPbxuIv9NVcIM8YHMy0ylIOFnJGWPW+mlZ7Rscq9SWGeQvixowdy/ftvYi6lutC74bd40bNgEpy1zYApxpbRh0w+dz0zuGLDs5l5ISC4MmP6CQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUa454LN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUa454LN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780952409; x=1812488409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EzPcnQ7vHIJ+uEHwcq52m+xA51HveVoU2O9tNfJu+6U=;
  b=XUa454LN1KH/2zqs8QbgMiVMT+NFOGOyzN6QvFe3dxIzjr4t9AE199yq
   Hh5y+zMWcZVGsEFcxWJfP1+JRy3opeX+36Amyt0wIsbn4EYjTnqpsKr5F
   o0BybrIDf6IEIsTtU4oxWLpvtSnHYzvDAs6djHcsL8JCl7fbpBDoQhqJt
   xgQ1QJHFWFF+3ozxwN+GKqvdq2lp3qXYZ4PQWUZfjqiMLL2RTjYt3Vzb9
   GTIMq0A+vf1JlbwNrdA94eCVwhGa4WdTro0CZzQE/XryBbXVRZS74Oo6P
   wRz0VmAXOTZSsGfJZfQ8i2N2goQi4qDx1a+IbyYsrIGfVneIAYkOims2N
   w==;
X-CSE-ConnectionGUID: YsVQX+LNRjK6OZNIM3Tzug==
X-CSE-MsgGUID: w05O9kwyQEKIhr9UKQrAlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99280848"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="99280848"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 14:00:08 -0700
X-CSE-ConnectionGUID: mQ9mMAbJSVWt2topQGUFpQ==
X-CSE-MsgGUID: sJDIxbvhQyKzvwiMXfo4pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="275849295"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 08 Jun 2026 14:00:05 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wWh4l-000000003JJ-2Dgf;
	Mon, 08 Jun 2026 21:00:03 +0000
Date: Mon, 8 Jun 2026 22:59:44 +0200
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>,
	syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,
	syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: watchdog: fix refcount tracking races
Message-ID: <202606082235.DIth7s08-lkp@intel.com>
References: <20260608123935.524879-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608123935.524879-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-watchdog-fix-refcount-tracking-races/20260608-205327
base:   net/main
patch link:    https://lore.kernel.org/r/20260608123935.524879-1-edumazet%40google.com
patch subject: [PATCH net] net: watchdog: fix refcount tracking races
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260608/202606082235.DIth7s08-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260608/202606082235.DIth7s08-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606082235.DIth7s08-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/sched/sch_generic.c: In function 'netdev_watchdog_up':
>> net/sched/sch_generic.c:594:39: error: incompatible type for argument 1 of 'IS_ERR_OR_NULL'
     594 |                 if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
         |                                    ~~~^~~~~~~~~~~~~~~~~~~~~~
         |                                       |
         |                                       netdevice_tracker
   In file included from include/linux/cleanup.h:6,
                    from include/linux/jump_label.h:78,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:620,
                    from include/asm-generic/bug.h:31,
                    from arch/x86/include/asm/bug.h:193,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/barrier.h:5,
                    from include/asm-generic/bitops/generic-non-atomic.h:7,
                    from include/linux/bitops.h:28,
                    from net/sched/sch_generic.c:10:
   include/linux/err.h:90:68: note: expected 'const void *' but argument is of type 'netdevice_tracker'
      90 | static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
         |                                                        ~~~~~~~~~~~~^~~


vim +/IS_ERR_OR_NULL +594 net/sched/sch_generic.c

   584	
   585	void netdev_watchdog_up(struct net_device *dev)
   586	{
   587		if (!dev->netdev_ops->ndo_tx_timeout)
   588			return;
   589		if (dev->watchdog_timeo <= 0)
   590			dev->watchdog_timeo = 5*HZ;
   591		spin_lock_bh(&dev->tx_global_lock);
   592		if (!mod_timer(&dev->watchdog_timer,
   593			       round_jiffies(jiffies + dev->watchdog_timeo))) {
 > 594			if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
   595				netdev_hold(dev, &dev->watchdog_dev_tracker,
   596					    GFP_ATOMIC);
   597		}
   598		spin_unlock_bh(&dev->tx_global_lock);
   599	}
   600	EXPORT_SYMBOL_GPL(netdev_watchdog_up);
   601	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
