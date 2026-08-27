Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935F3CD8C9
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818439; cv=none; b=fwjGx9qha0qceyBNSz9O+gQC4BxHbfuPqn7V6LQEPXO67pAiyKZBHMJfkRxggvf6EQNkX/ifACCk4mUbQhLA9jrvRiJ4FwI0ZNQCnibnO6PLVF7uHCqnX2bY2XyRztJFUFGPpR3pVjr3IrOMYRG8r3hSu930eXJ3VsFdukpfw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818439; c=relaxed/simple;
	bh=cV9cx0MBO/JEtv6zOXgIrZG1pIzZhV7wMUh+pHxFXcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQICtjwwjZZbS8808+HsssilYEiLrQ40KqmSzUbAYyEuEUagAo1524RDleTdyotNAUdQtn+926r442r42/4foLavsrwGfSN70H33FmebsIOH/JlONfYh2ZzP68w8b6ic2L07VuoWfVd81XcATe7cSarHWzUBj1IK6lCBxTw1cTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YI7uwVEi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YI7uwVEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787818435; x=1819354435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cV9cx0MBO/JEtv6zOXgIrZG1pIzZhV7wMUh+pHxFXcs=;
  b=YI7uwVEirceiLlqJH51LqnW6R15vMnE6ZFHlfCck1QyQs2olrFmd8IdC
   b7WGjWM/0EK/gNUBuCS4KMYlZSM+cvsqzgsHL0/+ppc2zxPC6JZ/Wx92l
   dh2AzxZOVlm2bQZgCytI8XigYwkvbEae5YctFbBcMV7lcpjyD+jBKqk70
   K7dt5fIb0L4V+HLyjtwGAx+utUIPjxK03u2g4sBFcgC91e1E3fyhy6Peu
   FPgFjsxA0BI2VKDIm6Xiax81d+LqvuxLi9Df2xqGArTEMCANX4KnvOHTt
   h3ACe2TgIJoto/DGs3ZCn4tBB/to0hmOisJE/tg0zeWU/y87efw6cJgoy
   g==;
X-CSE-ConnectionGUID: bfJEr6jCSDWQrtgfve79Dg==
X-CSE-MsgGUID: wSd9GT3wRP2Sx8wHIKvJuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88191047"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88191047"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 01:13:40 -0700
X-CSE-ConnectionGUID: zFKQKmfSSAOV1iZKqq7VGA==
X-CSE-MsgGUID: bdFyUYYgS1KN5tFO+38JMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="269753352"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Aug 2026 01:13:38 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wzVEt-0000000099J-06Ny;
	Thu, 27 Aug 2026 08:13:35 +0000
Date: Thu, 27 Aug 2026 16:13:25 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	syzbot+a5a07d2f6a71972dc5ed@syzkaller.appspotmail.com
Subject: Re: [PATCH net] igmp: convert struct ip_sf_list to RCU
Message-ID: <202608271655.mXCyurGJ-lkp@intel.com>
References: <20260826115913.3381537-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826115913.3381537-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/igmp-convert-struct-ip_sf_list-to-RCU/20260826-115913
base:   net/main
patch link:    https://lore.kernel.org/r/20260826115913.3381537-1-edumazet%40google.com
patch subject: [PATCH net] igmp: convert struct ip_sf_list to RCU
config: i386-randconfig-062-20260827 (https://download.01.org/0day-ci/archive/20260827/202608271655.mXCyurGJ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260827/202608271655.mXCyurGJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608271655.mXCyurGJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/ipv4/igmp.c: note: in included file (through include/linux/igmp.h):
   include/uapi/linux/igmp.h:60:32: sparse: sparse: array of flexible structures
>> net/ipv4/igmp.c:3114:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ip_sf_list *psf @@     got struct ip_sf_list [noderef] __rcu *sf_next @@
   net/ipv4/igmp.c:3114:13: sparse:     expected struct ip_sf_list *psf
   net/ipv4/igmp.c:3114:13: sparse:     got struct ip_sf_list [noderef] __rcu *sf_next
>> net/ipv4/igmp.c:3130:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ip_sf_list *psf @@     got struct ip_sf_list [noderef] __rcu *sources @@
   net/ipv4/igmp.c:3130:21: sparse:     expected struct ip_sf_list *psf
   net/ipv4/igmp.c:3130:21: sparse:     got struct ip_sf_list [noderef] __rcu *sources
   net/ipv4/igmp.c:3098:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ip_sf_list *psf @@     got struct ip_sf_list [noderef] __rcu *sources @@
   net/ipv4/igmp.c:3098:29: sparse:     expected struct ip_sf_list *psf
   net/ipv4/igmp.c:3098:29: sparse:     got struct ip_sf_list [noderef] __rcu *sources
   net/ipv4/igmp.c:3098:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ip_sf_list *psf @@     got struct ip_sf_list [noderef] __rcu *sources @@
   net/ipv4/igmp.c:3098:29: sparse:     expected struct ip_sf_list *psf
   net/ipv4/igmp.c:3098:29: sparse:     got struct ip_sf_list [noderef] __rcu *sources

vim +3114 net/ipv4/igmp.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  3109  
^1da177e4c3f41 Linus Torvalds 2005-04-16  3110  static struct ip_sf_list *igmp_mcf_get_next(struct seq_file *seq, struct ip_sf_list *psf)
^1da177e4c3f41 Linus Torvalds 2005-04-16  3111  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  3112  	struct igmp_mcf_iter_state *state = igmp_mcf_seq_private(seq);
^1da177e4c3f41 Linus Torvalds 2005-04-16  3113  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @3114  	psf = psf->sf_next;
^1da177e4c3f41 Linus Torvalds 2005-04-16  3115  	while (!psf) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  3116  		spin_unlock_bh(&state->im->lock);
^1da177e4c3f41 Linus Torvalds 2005-04-16  3117  		state->im = state->im->next;
^1da177e4c3f41 Linus Torvalds 2005-04-16  3118  		while (!state->im) {
6baff15037693c Eric Dumazet   2009-11-11  3119  			state->dev = next_net_device_rcu(state->dev);
^1da177e4c3f41 Linus Torvalds 2005-04-16  3120  			if (!state->dev) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  3121  				state->idev = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  3122  				goto out;
^1da177e4c3f41 Linus Torvalds 2005-04-16  3123  			}
6baff15037693c Eric Dumazet   2009-11-11  3124  			state->idev = __in_dev_get_rcu(state->dev);
^1da177e4c3f41 Linus Torvalds 2005-04-16  3125  			if (!state->idev)
^1da177e4c3f41 Linus Torvalds 2005-04-16  3126  				continue;
1d7138de878d1d Eric Dumazet   2010-11-12  3127  			state->im = rcu_dereference(state->idev->mc_list);
^1da177e4c3f41 Linus Torvalds 2005-04-16  3128  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  3129  		spin_lock_bh(&state->im->lock);
^1da177e4c3f41 Linus Torvalds 2005-04-16 @3130  		psf = state->im->sources;
^1da177e4c3f41 Linus Torvalds 2005-04-16  3131  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  3132  out:
^1da177e4c3f41 Linus Torvalds 2005-04-16  3133  	return psf;
^1da177e4c3f41 Linus Torvalds 2005-04-16  3134  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  3135  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
