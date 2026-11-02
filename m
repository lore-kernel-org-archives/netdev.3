Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643064;
	b=SO7NZ4h3ecYOcca4ucIgzeQl6XL8Msl1GiYV6uV1G9EwEvrMM/TFrRbJY3vViqf3MAPU
	 1T5bwkW/9lqyCksBSbfdGGSuVIySam7dOsUzF1lBwBAPVz+kQhp8plBaGjpUmwUbo22ji
	 cl4+DDydJSUvlGxHL0aRQT0Sv75H2C6HkrIPvQuwCDzv0fDWq9F8OPvS737FwHLWiPnNh
	 VeJtWdKORpcjwTc9AuQ9Xmt2AGgia9BihNnKP8huiZrwW7ZTIksMCcRUHCDADTjicpxy/
	 pXOzvFKWcgmGChO+U7IMSYyyDOMhXS/gk+iADE8MiRQ3gC/fm71ntWFUn66qmc1RQuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643064;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bjvJoJc/GTpSMbKiG3k1l8fW3FUFv6sMHWG+G/+EbEY=;
	b=y10Jm5Rq0UlNkZfUxphat7JDTfiGAP01QLOoSbTPR1crV18GkhgtcxgRemwKJWKB5W/3
	 Sb3BGuhcc1mzYvdP+kEvjc+ADZV9vAz3owMM+vxIb/qoUyJJW4Ba19CoSAdnx0CbQeajE
	 BDIOi1zZT8Z0UHSHbiZklqdhEMspitBlaWxmMLpP0oN4kDYL++YJwRyjRJorDYbfmV4dZ
	 4C9IA77M7e2K6exEX8iQQ1gTFSW1OQCok2i7Mtei/EVIitbHH9OmdXmAScl3gAmH8d5BG
	 vmsL4kbyUgjAdTf+Pi7s+NiFNDtq5Sxpy995qbRFVLIVp3MEstmvc/lkPb+6soqN1XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBfzWQNH;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F63C606A327;
	Mon,  2 Nov 2026 18:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F63C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBfzWQNH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793643064; x=1825179064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ARYRBjuRpiAfnJqS9ZxGEd/Hf5DQbR9n3T1V6+4Bh2I=;
  b=kBfzWQNHFHNp/x+QXK58joP8xlzwETbGvgzYMn/AlFmYP86GGZeepOFa
   d/LWvwTo+okdjwkouI36pCzKr7YmoLTLgjpSlKi7W1IoICPbhdMkJJaxE
   t4gEU0W7nVMgl54NftFSCFXpCedalSIUcmsu2EGZc+2TiY9hLGiL8p3F9
   qtPy9ywsdQulxCK0n6Nh572LoIM7DFlfLuyUtHGSTeF/7qL33gI6YQ0u8
   iQD3BwFqra1hpA432mcSvl9FS0Nw6jA5rtbESudPLFlnfIn0E6TKjaycT
   gqVDqqKbAH2hQWywEetL2GYlIMt4//oIT6w5JxGmhvFyjpLR7AYpX1Y3G
   w==;
X-CSE-ConnectionGUID: 3I0N0JHXTiCymFquxBbeFw==
X-CSE-MsgGUID: pTavKk0tSXqMAsY1Xd+pxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2364937"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2364937"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:11:04 -0800
X-CSE-ConnectionGUID: NwbxsqZBTwWoiRPuuqyvpg==
X-CSE-MsgGUID: pqzIkRSeSW6iLT9RKtxPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6184129"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Nov 2026 10:11:01 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNwUk-00000000hcC-0SV1;
	Mon, 02 Nov 2026 18:10:58 +0000
Date: Tue, 3 Nov 2026 02:10:03 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Deng <18983559317@163.com>, dsahern@kernel.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: Re: [PATCH net v1] igmp: use copy-on-write RCU updates in
 ip_mc_source()
Message-ID: <202611030211.aklzSdgm-lkp@intel.com>
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
config: sparc64-randconfig-1001-20261102 (https://download.01.org/0day-ci/archive/20261103/202611030211.aklzSdgm-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030211.aklzSdgm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030211.aklzSdgm-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/igmp.c:2646:1: error: function definition is not allowed here
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
   net/ipv4/igmp.c:3277:1: error: function definition is not allowed here
    3277 | {
         | ^
>> net/ipv4/igmp.c:3294:19: error: use of undeclared identifier 'igmp_netdev_event'; did you mean 'igmp_ifc_event'?
    3294 |         .notifier_call = igmp_netdev_event,
         |                          ^~~~~~~~~~~~~~~~~
         |                          igmp_ifc_event
   net/ipv4/igmp.c:884:13: note: 'igmp_ifc_event' declared here
     884 | static void igmp_ifc_event(struct in_device *in_dev)
         |             ^
>> net/ipv4/igmp.c:3294:19: error: incompatible function pointer types initializing 'notifier_fn_t' (aka 'int (*)(struct notifier_block *, unsigned long, void *)') with an expression of type 'void (struct in_device *)' [-Wincompatible-function-pointer-types]
    3294 |         .notifier_call = igmp_netdev_event,
         |                          ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3298:1: error: function definition is not allowed here
    3298 | {
         | ^
>> net/ipv4/igmp.c:3316:2: error: expected '}'
    3316 | }
         |  ^
   net/ipv4/igmp.c:2485:1: note: to match this '{'
    2485 | {
         | ^
   11 errors generated.


vim +3294 net/ipv4/igmp.c

4aa5dee4d99978 Jiri Pirko      2013-07-20  3292  
4aa5dee4d99978 Jiri Pirko      2013-07-20  3293  static struct notifier_block igmp_notifier = {
4aa5dee4d99978 Jiri Pirko      2013-07-20 @3294  	.notifier_call = igmp_netdev_event,
4aa5dee4d99978 Jiri Pirko      2013-07-20  3295  };
4aa5dee4d99978 Jiri Pirko      2013-07-20  3296  
72c1d3bdd5bf10 WANG Cong       2014-01-10  3297  int __init igmp_mc_init(void)
7091e728c57015 Alexey Dobriyan 2008-12-25  3298  {
72c1d3bdd5bf10 WANG Cong       2014-01-10  3299  #if defined(CONFIG_PROC_FS)
4aa5dee4d99978 Jiri Pirko      2013-07-20  3300  	int err;
4aa5dee4d99978 Jiri Pirko      2013-07-20  3301  
4aa5dee4d99978 Jiri Pirko      2013-07-20  3302  	err = register_pernet_subsys(&igmp_net_ops);
4aa5dee4d99978 Jiri Pirko      2013-07-20  3303  	if (err)
4aa5dee4d99978 Jiri Pirko      2013-07-20  3304  		return err;
4aa5dee4d99978 Jiri Pirko      2013-07-20  3305  	err = register_netdevice_notifier(&igmp_notifier);
4aa5dee4d99978 Jiri Pirko      2013-07-20  3306  	if (err)
4aa5dee4d99978 Jiri Pirko      2013-07-20  3307  		goto reg_notif_fail;
4aa5dee4d99978 Jiri Pirko      2013-07-20  3308  	return 0;
4aa5dee4d99978 Jiri Pirko      2013-07-20  3309  
4aa5dee4d99978 Jiri Pirko      2013-07-20  3310  reg_notif_fail:
4aa5dee4d99978 Jiri Pirko      2013-07-20  3311  	unregister_pernet_subsys(&igmp_net_ops);
4aa5dee4d99978 Jiri Pirko      2013-07-20  3312  	return err;
72c1d3bdd5bf10 WANG Cong       2014-01-10  3313  #else
72c1d3bdd5bf10 WANG Cong       2014-01-10  3314  	return register_netdevice_notifier(&igmp_notifier);
^1da177e4c3f41 Linus Torvalds  2005-04-16  3315  #endif
72c1d3bdd5bf10 WANG Cong       2014-01-10 @3316  }

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
