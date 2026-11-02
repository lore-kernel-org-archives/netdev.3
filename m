Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635172;
	b=odQBTQ2ApA9Rf/aBcqZ80P1oq2qwVxbqGVH999BhWotRZn6J+INYq3u8HWv4buqB2wM4
	 +Qhi/CarhV6T/zZH/jv4Mb6TX/8IaBTgN899G7tzGTKzCN6Z9PENe9EnNcmb96UqPFXTo
	 mFg2l3BOUel4H/4kl+TPkGsCs7PaxzuaIW2eUzqWs7VQjncT0wEr/1uRO2tqf+V/+I+dS
	 6U8F5TwnTzn8GHxDKP7K9aYE82i9IErPxYHmnDTop7eYjAHRptRev2PjcOx/mu79psLnr
	 ZGtZuiC4OV4OAtniJfuuadAc1cOLVZcfdmBN3YNp5LvGJXqG1KDcI8729zIBicF4KvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635172;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WtmXxxia8xpyKa3DV0JfoN3uO40TGArVU7Dm9wG3Bro=;
	b=UARazTH5SBybYXqBQJEfAKmAyYWIA1Tp87iDZzI7fuv/W/qjGNpQg7wRxQCQV//L/DCe
	 Wdhv3lZK7aOihCzNITMOqpM2rIPDO67qsj9Bbwvjh7q8NAFi2DQ0z0EFL9qwuJfeNP2Md
	 8DopGALHylGK7JEprosX3twshhdzHuc4D5mv0g+1PSqXnj3Oqy2z5Qcel/Jzs21E8mbHc
	 PswOdqQ+DpD+0xDwcWppTdGmP3muiVqN6OliBJDbCnZj1l+/4oeDiVVC1L3aIK0FwGpD+
	 ix5kxufPJak63/lBfnu32m/K9FTrEt0Jhxs9ntqNgEXtpzrkn+6hRxwMbtXtLSMrMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="CH4/Z7pf";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D76606F200;
	Mon,  2 Nov 2026 15:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D76606F200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CH4/Z7pf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793635171; x=1825171171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HR4VM24AxwgtGcs3yOHNCQwdUVq3XuJywZ1ZdX6p5vs=;
  b=CH4/Z7pf8aaa7YxDaImqDQvyFFVqL+2giafPtD9zsmHhcYuSEW4CL50a
   Hsw5VjB6crhI1rFbPxppRQXz9MWACkA9NNZNzmac4RvViTW5DBAEGyssW
   U3bTUN/T2ZWmpJ2R33UG60HXsjrYOD7vV6M2U3670jM6+HaEk5Owjb3WR
   3D+ROpxfrbC6QUSIJy97sC6UH6Ny/FYzB3H+XeIZrEjgzq3Ky0CRzIz8f
   TBsz9LeDj6eITqqUYG7e4pWiPOemV3cggoS/6SmKSWVA5/plSDVv8EDT3
   1SpAyt2fW6fuCFHf/lQ02LXR+QbWc/ijqZD2gQjq1SXpaQW+uiG3fHsXG
   w==;
X-CSE-ConnectionGUID: gkVtA34uTIu2JUrMyWiRDg==
X-CSE-MsgGUID: qUG3EjsoQ1+ET0m+gKViEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2209942"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2209942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 07:59:30 -0800
X-CSE-ConnectionGUID: 06maB2lYQdy8vUnGAOEd3A==
X-CSE-MsgGUID: LtJkTRM4QECyoQZnCHta9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6010178"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Nov 2026 07:59:27 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNuRQ-00000000hFS-3szD;
	Mon, 02 Nov 2026 15:59:24 +0000
Date: Mon, 2 Nov 2026 23:59:12 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Deng <18983559317@163.com>, dsahern@kernel.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Binbin Deng <18983559317@163.com>
Subject: Re: [PATCH net v1] igmp: use copy-on-write RCU updates in
 ip_mc_source()
Message-ID: <202611022340.iFWNzlRb-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Deng/igmp-use-copy-on-write-RCU-updates-in-ip_mc_source/20261102-175312
base:   net/main
patch link:    https://lore.kernel.org/r/20261102095312.47767-1-18983559317%40163.com
patch subject: [PATCH net v1] igmp: use copy-on-write RCU updates in ip_mc_source()
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20261102/202611022340.iFWNzlRb-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261102/202611022340.iFWNzlRb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611022340.iFWNzlRb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/igmp.c: In function 'ip_mc_source':
   net/ipv4/igmp.c:2976:34: error: invalid storage class for function 'igmp_mc_get_first'
    2976 | static inline struct ip_mc_list *igmp_mc_get_first(struct seq_file *seq)
         |                                  ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:2998:27: error: invalid storage class for function 'igmp_mc_get_next'
    2998 | static struct ip_mc_list *igmp_mc_get_next(struct seq_file *seq, struct ip_mc_list *im)
         |                           ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3017:27: error: invalid storage class for function 'igmp_mc_get_idx'
    3017 | static struct ip_mc_list *igmp_mc_get_idx(struct seq_file *seq, loff_t pos)
         |                           ^~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3026:14: error: invalid storage class for function 'igmp_mc_seq_start'
    3026 | static void *igmp_mc_seq_start(struct seq_file *seq, loff_t *pos)
         |              ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3033:14: error: invalid storage class for function 'igmp_mc_seq_next'
    3033 | static void *igmp_mc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
         |              ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3044:13: error: invalid storage class for function 'igmp_mc_seq_stop'
    3044 | static void igmp_mc_seq_stop(struct seq_file *seq, void *v)
         |             ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3054:12: error: invalid storage class for function 'igmp_mc_seq_show'
    3054 | static int igmp_mc_seq_show(struct seq_file *seq, void *v)
         |            ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3094:25: error: initializer element is not constant
    3094 |         .start  =       igmp_mc_seq_start,
         |                         ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3094:25: note: (near initialization for 'igmp_mc_seq_ops.start')
   net/ipv4/igmp.c:3095:25: error: initializer element is not constant
    3095 |         .next   =       igmp_mc_seq_next,
         |                         ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3095:25: note: (near initialization for 'igmp_mc_seq_ops.next')
   net/ipv4/igmp.c:3096:25: error: initializer element is not constant
    3096 |         .stop   =       igmp_mc_seq_stop,
         |                         ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3096:25: note: (near initialization for 'igmp_mc_seq_ops.stop')
   net/ipv4/igmp.c:3097:25: error: initializer element is not constant
    3097 |         .show   =       igmp_mc_seq_show,
         |                         ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3097:25: note: (near initialization for 'igmp_mc_seq_ops.show')
   net/ipv4/igmp.c:3109:34: error: invalid storage class for function 'igmp_mcf_get_first'
    3109 | static inline struct ip_sf_list *igmp_mcf_get_first(struct seq_file *seq)
         |                                  ^~~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3138:27: error: invalid storage class for function 'igmp_mcf_get_next'
    3138 | static struct ip_sf_list *igmp_mcf_get_next(struct seq_file *seq, struct ip_sf_list *psf)
         |                           ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3164:27: error: invalid storage class for function 'igmp_mcf_get_idx'
    3164 | static struct ip_sf_list *igmp_mcf_get_idx(struct seq_file *seq, loff_t pos)
         |                           ^~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3173:14: error: invalid storage class for function 'igmp_mcf_seq_start'
    3173 | static void *igmp_mcf_seq_start(struct seq_file *seq, loff_t *pos)
         |              ^~~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3180:14: error: invalid storage class for function 'igmp_mcf_seq_next'
    3180 | static void *igmp_mcf_seq_next(struct seq_file *seq, void *v, loff_t *pos)
         |              ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3191:13: error: invalid storage class for function 'igmp_mcf_seq_stop'
    3191 | static void igmp_mcf_seq_stop(struct seq_file *seq, void *v)
         |             ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3204:12: error: invalid storage class for function 'igmp_mcf_seq_show'
    3204 | static int igmp_mcf_seq_show(struct seq_file *seq, void *v)
         |            ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3225:25: error: initializer element is not constant
    3225 |         .start  =       igmp_mcf_seq_start,
         |                         ^~~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3225:25: note: (near initialization for 'igmp_mcf_seq_ops.start')
   net/ipv4/igmp.c:3226:25: error: initializer element is not constant
    3226 |         .next   =       igmp_mcf_seq_next,
         |                         ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3226:25: note: (near initialization for 'igmp_mcf_seq_ops.next')
   net/ipv4/igmp.c:3227:25: error: initializer element is not constant
    3227 |         .stop   =       igmp_mcf_seq_stop,
         |                         ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3227:25: note: (near initialization for 'igmp_mcf_seq_ops.stop')
   net/ipv4/igmp.c:3228:25: error: initializer element is not constant
    3228 |         .show   =       igmp_mcf_seq_show,
         |                         ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3228:25: note: (near initialization for 'igmp_mcf_seq_ops.show')
   net/ipv4/igmp.c:3231:23: error: invalid storage class for function 'igmp_net_init'
    3231 | static int __net_init igmp_net_init(struct net *net)
         |                       ^~~~~~~~~~~~~
   net/ipv4/igmp.c:3262:24: error: invalid storage class for function 'igmp_net_exit'
    3262 | static void __net_exit igmp_net_exit(struct net *net)
         |                        ^~~~~~~~~~~~~
   net/ipv4/igmp.c:3270:17: error: initializer element is not constant
    3270 |         .init = igmp_net_init,
         |                 ^~~~~~~~~~~~~
   net/ipv4/igmp.c:3270:17: note: (near initialization for 'igmp_net_ops.init')
   net/ipv4/igmp.c:3271:17: error: initializer element is not constant
    3271 |         .exit = igmp_net_exit,
         |                 ^~~~~~~~~~~~~
   net/ipv4/igmp.c:3271:17: note: (near initialization for 'igmp_net_ops.exit')
   net/ipv4/igmp.c:3275:12: error: invalid storage class for function 'igmp_netdev_event'
    3275 | static int igmp_netdev_event(struct notifier_block *this,
         |            ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3294:26: error: initializer element is not constant
    3294 |         .notifier_call = igmp_netdev_event,
         |                          ^~~~~~~~~~~~~~~~~
   net/ipv4/igmp.c:3294:26: note: (near initialization for 'igmp_notifier.notifier_call')
   net/ipv4/igmp.c:3316:1: error: expected declaration or statement at end of input
    3316 | }
         | ^
>> net/ipv4/igmp.c:3317: warning: control reaches end of non-void function [-Wreturn-type]
   At top level:
>> net/ipv4/igmp.c:3297:12: warning: 'igmp_mc_init' defined but not used [-Wunused-function]
    3297 | int __init igmp_mc_init(void)
         |            ^~~~~~~~~~~~
>> net/ipv4/igmp.c:2923:5: warning: 'ip_check_mc_rcu' defined but not used [-Wunused-function]
    2923 | int ip_check_mc_rcu(struct in_device *in_dev, __be32 mc_addr, __be32 src_addr, u8 proto)
         |     ^~~~~~~~~~~~~~~
>> net/ipv4/igmp.c:2897:6: warning: 'ip_mc_drop_socket' defined but not used [-Wunused-function]
    2897 | void ip_mc_drop_socket(struct sock *sk)
         |      ^~~~~~~~~~~~~~~~~
>> net/ipv4/igmp.c:2849:5: warning: 'ip_mc_sf_allow' defined but not used [-Wunused-function]
    2849 | int ip_mc_sf_allow(const struct sock *sk, __be32 loc_addr, __be32 rmt_addr,
         |     ^~~~~~~~~~~~~~
>> net/ipv4/igmp.c:2800:5: warning: 'ip_mc_gsfget' defined but not used [-Wunused-function]
    2800 | int ip_mc_gsfget(struct sock *sk, struct group_filter *gsf,
         |     ^~~~~~~~~~~~
>> net/ipv4/igmp.c:2736:5: warning: 'ip_mc_msfget' defined but not used [-Wunused-function]
    2736 | int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf, sockopt_t *opt)
         |     ^~~~~~~~~~~~
>> net/ipv4/igmp.c:2645:5: warning: 'ip_mc_msfilter' defined but not used [-Wunused-function]
    2645 | int ip_mc_msfilter(struct sock *sk, struct ip_msfilter *msf, int ifindex)
         |     ^~~~~~~~~~~~~~


vim +3317 net/ipv4/igmp.c

4aa5dee4d99978 Jiri Pirko      2013-07-20  3292  
4aa5dee4d99978 Jiri Pirko      2013-07-20  3293  static struct notifier_block igmp_notifier = {
4aa5dee4d99978 Jiri Pirko      2013-07-20 @3294  	.notifier_call = igmp_netdev_event,
4aa5dee4d99978 Jiri Pirko      2013-07-20  3295  };
4aa5dee4d99978 Jiri Pirko      2013-07-20  3296  
72c1d3bdd5bf10 WANG Cong       2014-01-10 @3297  int __init igmp_mc_init(void)
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
72c1d3bdd5bf10 WANG Cong       2014-01-10  3316  }

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
