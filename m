Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641804;
	b=MTtWeM5GfAyh6o6q7xrjH/u5GzENDVjS5Ps4lhglwbYMm8ktCu2BuExbFaMBS2ugwg3d
	 vesMS+CVCuwPvgBY0SWbAyBuqwBPUKvoOKLR/O9VegwtPEbvs9l09+4mhKf2C9qpsm0cJ
	 ob4XwIX5i05REfHAIgc6c/WvFQgk/pWOFs/AzBqGBGE2GtfKAGMzMHkBSdLjY4lzJ8hkc
	 zc2lNev7crVc0T/Ne/Bx9Uo/kAbiTCBmIR15dmG4ojf6kEKfsi9sg9uNY++hbKIodOjj4
	 3ET3i+qzVBqPT7WABfkG/aVGTuTVMJnNrTjynupeE117zBmptInN9oAnirzPILeBhSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641804;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=T1ticfJydrYA1SjDeUoJpfnM83pkS1wa5V7oY625kH4=;
	b=P3f7E+7G9ElRPdllenLztoe0kF8nebibHTlLhZJPH+iyAqKaRGtSFu0n0ITjssiiVtYN
	 sCg36wXMm/tjdZdEdPk8zeDQOB13jPynDVudIw67RDJSG3ESzcXWyDmUNYecyeUqhFloG
	 LtK06++fwgxmzY6zOyNvRVJ/SkW98oG14GJE4sORWdj6HiJvJW+f6R0Qehp8oL/+GNm7V
	 +lYdi/B/wPS7tdLIZ53A6cr9rq49QT57i+4i8xBY0irR1ju8BRWQuLwo8ZTAmwlwhpRM+
	 EGlMOan6i7qGjtJeYuUnPoT//E6J+FD8982H4j6LRZjGpQyZk4WHQvFC0PIjA0wAXrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Se0Vj9l7;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E929606A337;
	Mon,  2 Nov 2026 17:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E929606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Se0Vj9l7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793641804; x=1825177804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSCF7zBSudjiGOzT24V0nGQydsXVadvfVgF/yDTTR6Q=;
  b=Se0Vj9l7F6NZ5RRMbW9cSVpJTIk32iuaOoiO12kclXmKNDSx6UB2XYnN
   mDthGNKO+usEvtFS4h2RaET6HNWgGnKlHvsQUdllokW8V+z/lOSZGmO5N
   vlNcfdyvt+Q7sjAgzw7w80L7IzM1llkm/ZbGQvD9Ue9g7zxjXUi3M6ywi
   mqHWjxXFDymKxMgmL0pbeyL6DHvGZTaYqYR4BP9veojWeI7yTfTzoiUfX
   eYa16YQJiUF8ofb0AuYxeTHj7s0Cq44NUbWDiYSYpiEFsHIgPhuO/RxKz
   3wOUs8RT1yehybgVB1SqpULepb3Z2Juz7Zonz0NVqruqr7+HPXmqLAgBJ
   w==;
X-CSE-ConnectionGUID: OYkVfngXSJCnP+VDIoDzkQ==
X-CSE-MsgGUID: bJ1z0YkKTxCB5vyy+wk2gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2375148"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2375148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:50:03 -0800
X-CSE-ConnectionGUID: vAvJJhCZStKaIHnfZCdEXw==
X-CSE-MsgGUID: GN9Lo8r8RTaqWIvzavueyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6094170"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 09:49:59 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNwAO-00000000hbQ-46TU;
	Mon, 02 Nov 2026 17:49:56 +0000
Date: Tue, 3 Nov 2026 01:49:32 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Deng <18983559317@163.com>, dsahern@kernel.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: Re: [PATCH net v1] igmp: use copy-on-write RCU updates in
 ip_mc_source()
Message-ID: <202611030103.U23Q9Kyn-lkp@intel.com>
References: <20261102095312.47767-1-18983559317@163.com>
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
In-Reply-To: <20261102095312.47767-1-18983559317@163.com>

Hi Binbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Deng/igmp-use-copy-on-write-RCU-updates-in-ip_mc_source/20261102-175312
base:   net/main
patch link:    https://lore.kernel.org/r/20261102095312.47767-1-18983559317%40163.com
patch subject: [PATCH net v1] igmp: use copy-on-write RCU updates in ip_mc_source()
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20261103/202611030103.U23Q9Kyn-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 65303e81f481bbfe386b8596423f94c43198ba94)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030103.U23Q9Kyn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030103.U23Q9Kyn-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/igmp.c:2084:6: warning: variable 'changerec' set but not used [-Wunused-but-set-variable]
    2084 |         int     changerec = 0;
         |                 ^
>> net/ipv4/igmp.c:2646:1: error: function definition is not allowed here
    2646 | {
         | ^
   net/ipv4/igmp.c:2737:1: error: function definition is not allowed here
    2737 | {
         | ^
   net/ipv4/igmp.c:2802:1: error: function definition is not allowed here
    2802 | {
         | ^
   net/ipv4/igmp.c:2851:1: error: function definition is not allowed here
    2851 | {
         | ^
   net/ipv4/igmp.c:2898:1: error: function definition is not allowed here
    2898 | {
         | ^
   net/ipv4/igmp.c:2924:1: error: function definition is not allowed here
    2924 | {
         | ^
   net/ipv4/igmp.c:2977:1: error: function definition is not allowed here
    2977 | {
         | ^
   net/ipv4/igmp.c:2999:1: error: function definition is not allowed here
    2999 | {
         | ^
   net/ipv4/igmp.c:3018:1: error: function definition is not allowed here
    3018 | {
         | ^
   net/ipv4/igmp.c:3028:1: error: function definition is not allowed here
    3028 | {
         | ^
   net/ipv4/igmp.c:3034:1: error: function definition is not allowed here
    3034 | {
         | ^
   net/ipv4/igmp.c:3046:1: error: function definition is not allowed here
    3046 | {
         | ^
   net/ipv4/igmp.c:3055:1: error: function definition is not allowed here
    3055 | {
         | ^
>> net/ipv4/igmp.c:3094:11: error: use of undeclared identifier 'igmp_mc_seq_start'; did you mean 'igmp_mc_seq_ops'?
    3094 |         .start  =       igmp_mc_seq_start,
         |                         ^~~~~~~~~~~~~~~~~
         |                         igmp_mc_seq_ops
   net/ipv4/igmp.c:3093:36: note: 'igmp_mc_seq_ops' declared here
    3093 | static const struct seq_operations igmp_mc_seq_ops = {
         |                                    ^
>> net/ipv4/igmp.c:3095:10: error: use of undeclared identifier 'igmp_mc_seq_next'; did you mean 'igmp_mc_seq_ops'?
    3095 |         .next   =       igmp_mc_seq_next,
         |                         ^~~~~~~~~~~~~~~~
         |                         igmp_mc_seq_ops
   net/ipv4/igmp.c:3093:36: note: 'igmp_mc_seq_ops' declared here
    3093 | static const struct seq_operations igmp_mc_seq_ops = {
         |                                    ^
>> net/ipv4/igmp.c:3096:10: error: use of undeclared identifier 'igmp_mc_seq_stop'; did you mean 'igmp_mc_seq_ops'?
    3096 |         .stop   =       igmp_mc_seq_stop,
         |                         ^~~~~~~~~~~~~~~~
         |                         igmp_mc_seq_ops
   net/ipv4/igmp.c:3093:36: note: 'igmp_mc_seq_ops' declared here
    3093 | static const struct seq_operations igmp_mc_seq_ops = {
         |                                    ^
>> net/ipv4/igmp.c:3097:10: error: use of undeclared identifier 'igmp_mc_seq_show'; did you mean 'igmp_mc_seq_ops'?
    3097 |         .show   =       igmp_mc_seq_show,
         |                         ^~~~~~~~~~~~~~~~
         |                         igmp_mc_seq_ops
   net/ipv4/igmp.c:3093:36: note: 'igmp_mc_seq_ops' declared here
    3093 | static const struct seq_operations igmp_mc_seq_ops = {
         |                                    ^
>> net/ipv4/igmp.c:3094:11: error: initializing 'void *(*)(struct seq_file *, loff_t *)' (aka 'void *(*)(struct seq_file *, long long *)') with an expression of incompatible type 'const struct seq_operations'
    3094 |         .start  =       igmp_mc_seq_start,
         |                         ^~~~~~~~~~~~~~~~~
>> net/ipv4/igmp.c:3095:10: error: initializing 'void *(*)(struct seq_file *, void *, loff_t *)' (aka 'void *(*)(struct seq_file *, void *, long long *)') with an expression of incompatible type 'const struct seq_operations'
    3095 |         .next   =       igmp_mc_seq_next,
         |                         ^~~~~~~~~~~~~~~~
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +2646 net/ipv4/igmp.c

^1da177e4c3f41 Linus Torvalds          2005-04-16  2644  
^1da177e4c3f41 Linus Torvalds          2005-04-16  2645  int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf, int ifindex)
^1da177e4c3f41 Linus Torvalds          2005-04-16 @2646  {
9951f036fe8a4e David L Stevens         2005-07-08  2647  	int err = 0;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2648  	struct ip_mreqn	imr;
63007727e0bb09 Al Viro                 2006-09-27  2649  	__be32 addr = msf->imsf_multiaddr;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2650  	struct ip_mc_socklist *pmc;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2651  	struct in_device *in_dev;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2652  	struct inet_sock *inet = inet_sk(sk);
^1da177e4c3f41 Linus Torvalds          2005-04-16  2653  	struct ip_sf_socklist *newpsl, *psl;
877acedc0d3ea0 Daniel Lezcano          2008-08-13  2654  	struct net *net = sock_net(sk);
9951f036fe8a4e David L Stevens         2005-07-08  2655  	int leavegroup = 0;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2656  
f97c1e0c6ebdb6 Joe Perches             2007-12-16  2657  	if (!ipv4_is_multicast(addr))
^1da177e4c3f41 Linus Torvalds          2005-04-16  2658  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2659  	if (msf->imsf_fmode != MCAST_INCLUDE &&
^1da177e4c3f41 Linus Torvalds          2005-04-16  2660  	    msf->imsf_fmode != MCAST_EXCLUDE)
^1da177e4c3f41 Linus Torvalds          2005-04-16  2661  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2662  
54ff9ef36bdf84 Marcelo Ricardo Leitner 2015-03-18  2663  	ASSERT_RTNL();
^1da177e4c3f41 Linus Torvalds          2005-04-16  2664  
^1da177e4c3f41 Linus Torvalds          2005-04-16  2665  	imr.imr_multiaddr.s_addr = msf->imsf_multiaddr;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2666  	imr.imr_address.s_addr = msf->imsf_interface;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2667  	imr.imr_ifindex = ifindex;
877acedc0d3ea0 Daniel Lezcano          2008-08-13  2668  	in_dev = ip_mc_find_dev(net, &imr);
^1da177e4c3f41 Linus Torvalds          2005-04-16  2669  
^1da177e4c3f41 Linus Torvalds          2005-04-16  2670  	if (!in_dev) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  2671  		err = -ENODEV;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2672  		goto done;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2673  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  2674  
9951f036fe8a4e David L Stevens         2005-07-08  2675  	/* special case - (INCLUDE, empty) == LEAVE_GROUP */
9951f036fe8a4e David L Stevens         2005-07-08  2676  	if (msf->imsf_fmode == MCAST_INCLUDE && msf->imsf_numsrc == 0) {
9951f036fe8a4e David L Stevens         2005-07-08  2677  		leavegroup = 1;
9951f036fe8a4e David L Stevens         2005-07-08  2678  		goto done;
9951f036fe8a4e David L Stevens         2005-07-08  2679  	}
9951f036fe8a4e David L Stevens         2005-07-08  2680  
1d7138de878d1d Eric Dumazet            2010-11-12  2681  	for_each_pmc_rtnl(inet, pmc) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  2682  		if (pmc->multi.imr_multiaddr.s_addr == msf->imsf_multiaddr &&
^1da177e4c3f41 Linus Torvalds          2005-04-16  2683  		    pmc->multi.imr_ifindex == imr.imr_ifindex)
^1da177e4c3f41 Linus Torvalds          2005-04-16  2684  			break;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2685  	}
917f2f105ea4bb David L Stevens         2005-07-08  2686  	if (!pmc) {		/* must have a prior join */
917f2f105ea4bb David L Stevens         2005-07-08  2687  		err = -EINVAL;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2688  		goto done;
917f2f105ea4bb David L Stevens         2005-07-08  2689  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  2690  	if (msf->imsf_numsrc) {
e6a1f7e0b0fe59 Gustavo A. R. Silva     2021-08-04  2691  		newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr,
e6a1f7e0b0fe59 Gustavo A. R. Silva     2021-08-04  2692  						      msf->imsf_numsrc),
8b3a70058bfe71 Kris Katterjohn         2006-01-11  2693  				      GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds          2005-04-16  2694  		if (!newpsl) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  2695  			err = -ENOBUFS;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2696  			goto done;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2697  		}
^1da177e4c3f41 Linus Torvalds          2005-04-16  2698  		newpsl->sl_max = newpsl->sl_count = msf->imsf_numsrc;
2d3e5caf96b944 Gustavo A. R. Silva     2021-07-31  2699  		memcpy(newpsl->sl_addr, msf->imsf_slist_flex,
2d3e5caf96b944 Gustavo A. R. Silva     2021-07-31  2700  		       flex_array_size(msf, imsf_slist_flex, msf->imsf_numsrc));
^1da177e4c3f41 Linus Torvalds          2005-04-16  2701  		err = ip_mc_add_src(in_dev, &msf->imsf_multiaddr,
^1da177e4c3f41 Linus Torvalds          2005-04-16  2702  			msf->imsf_fmode, newpsl->sl_count, newpsl->sl_addr, 0);
^1da177e4c3f41 Linus Torvalds          2005-04-16  2703  		if (err) {
e6a1f7e0b0fe59 Gustavo A. R. Silva     2021-08-04  2704  			sock_kfree_s(sk, newpsl,
e6a1f7e0b0fe59 Gustavo A. R. Silva     2021-08-04  2705  				     struct_size(newpsl, sl_addr,
e6a1f7e0b0fe59 Gustavo A. R. Silva     2021-08-04  2706  						 newpsl->sl_max));
^1da177e4c3f41 Linus Torvalds          2005-04-16  2707  			goto done;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2708  		}
8713dbf05754aa Yan Zheng               2005-10-28  2709  	} else {
^1da177e4c3f41 Linus Torvalds          2005-04-16  2710  		newpsl = NULL;
8713dbf05754aa Yan Zheng               2005-10-28  2711  		(void) ip_mc_add_src(in_dev, &msf->imsf_multiaddr,
8713dbf05754aa Yan Zheng               2005-10-28  2712  				     msf->imsf_fmode, 0, NULL, 0);
8713dbf05754aa Yan Zheng               2005-10-28  2713  	}
1d7138de878d1d Eric Dumazet            2010-11-12  2714  	psl = rtnl_dereference(pmc->sflist);
^1da177e4c3f41 Linus Torvalds          2005-04-16  2715  	if (psl) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  2716  		(void) ip_mc_del_src(in_dev, &msf->imsf_multiaddr, pmc->sfmode,
^1da177e4c3f41 Linus Torvalds          2005-04-16  2717  			psl->sl_count, psl->sl_addr, 0);
c85bb41e93184b Flavio Leitner          2010-02-02  2718  		/* decrease mem now to avoid the memleak warning */
e6a1f7e0b0fe59 Gustavo A. R. Silva     2021-08-04  2719  		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
e6a1f7e0b0fe59 Gustavo A. R. Silva     2021-08-04  2720  			   &sk->sk_omem_alloc);
dba5bdd57bea58 Eric Dumazet            2022-04-29  2721  	} else {
^1da177e4c3f41 Linus Torvalds          2005-04-16  2722  		(void) ip_mc_del_src(in_dev, &msf->imsf_multiaddr, pmc->sfmode,
^1da177e4c3f41 Linus Torvalds          2005-04-16  2723  			0, NULL, 0);
dba5bdd57bea58 Eric Dumazet            2022-04-29  2724  	}
cf778b00e96df6 Eric Dumazet            2012-01-12  2725  	rcu_assign_pointer(pmc->sflist, newpsl);
dba5bdd57bea58 Eric Dumazet            2022-04-29  2726  	if (psl)
dba5bdd57bea58 Eric Dumazet            2022-04-29  2727  		kfree_rcu(psl, rcu);
^1da177e4c3f41 Linus Torvalds          2005-04-16  2728  	pmc->sfmode = msf->imsf_fmode;
917f2f105ea4bb David L Stevens         2005-07-08  2729  	err = 0;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2730  done:
9951f036fe8a4e David L Stevens         2005-07-08  2731  	if (leavegroup)
9951f036fe8a4e David L Stevens         2005-07-08  2732  		err = ip_mc_leave_group(sk, &imr);
^1da177e4c3f41 Linus Torvalds          2005-04-16  2733  	return err;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2734  }
e12e04f5ab54cd Breno Leitao            2026-09-14  2735  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
