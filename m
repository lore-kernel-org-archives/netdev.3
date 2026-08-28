Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F33644A6
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888102; cv=none; b=pZ3ZzRmssAaKdrQZzh6Yh+4QHDWjUEFzqNhWYs9HGR+EOSAnHl7k2IbCnkKalRoJ6QWjKbbMnuRjRxTJvPTLP4DxCQuBjUxlEIQ13DPBLNv52/3rjadxl2VW+5fg8NFExE2Cj1JNKAngGgAbWZUkLn4eY5qsBRoPydPgOf63dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888102; c=relaxed/simple;
	bh=bGbiVB/lr//yzff+veufoYp4ay18R2tNbJazcW+MhxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHKrLSl5uTD7Wjmm87yWhxMYCucl/sCam8VeP0WXvdtkGQrFTYXGSxIXtxkMlxvXoBPCQrBnfFKkVzDC/bzFtgjvHTKeJH82izpL7wxKADVkNzPeU7quxDsm07X+xSm6nn5umEK4WYfhOLLHH35roNFWNVznSxEnkWae2+XpkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScaQthX1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScaQthX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787888099; x=1819424099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bGbiVB/lr//yzff+veufoYp4ay18R2tNbJazcW+MhxQ=;
  b=ScaQthX1L2ONNUYhWH2bWaLdIG96zzDtGQuSKjbjyQMMWJAMR0HJg8Al
   lqWB099ddRfa3xJdLPuMSsqlWWpl/PgOTIv7hBH6f+orEximygSIt5rrk
   WuCaLdz7Ng0VnjhLiCFs+gjWGlKqR7crmPGo5QJoaGf2K5VrqVbABpRWh
   iyfT2ZCZMFjcjb3u/ncmZqQSrIkMIrxK3gmCW13aQeGNRCYUpwUir+vaI
   KevWriZlbq9oKYLbwrWlec1vAk90TjMfKTRqA5GQE39ols2Uhs7ocDqUQ
   GhGJqZ2ed+9p8S6wLy9J/w9QtyshuMRdbqzXXquaJAN5g21SXCnNBEn+n
   g==;
X-CSE-ConnectionGUID: WJRTyT7KRRG1vrXMWDOCYg==
X-CSE-MsgGUID: LF6nKHvDSe2QyCPSREQ9fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="98729945"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="98729945"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 20:34:59 -0700
X-CSE-ConnectionGUID: Whkqq+FeRHSkrUvs80CzxQ==
X-CSE-MsgGUID: 5mEGUJyhRua651Tebv7Q5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="264799199"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2026 20:34:56 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wznMj-00000000AJ3-0ZjL;
	Fri, 28 Aug 2026 03:34:53 +0000
Date: Fri, 28 Aug 2026 11:34:14 +0800
From: kernel test robot <lkp@intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net v3] net: libwx: protect ring accesses with RCU
Message-ID: <202608281122.ImEa1DuX-lkp@intel.com>
References: <20260824103606.303-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824103606.303-1-mengyuanlou@net-swift.com>

Hi Mengyuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mengyuan-Lou/net-libwx-protect-ring-accesses-with-RCU/20260824-183606
base:   net/main
patch link:    https://lore.kernel.org/r/20260824103606.303-1-mengyuanlou%40net-swift.com
patch subject: [PATCH net v3] net: libwx: protect ring accesses with RCU
config: csky-randconfig-r113-20260826 (https://download.01.org/0day-ci/archive/20260828/202608281122.ImEa1DuX-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260828/202608281122.ImEa1DuX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608281122.ImEa1DuX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:1717:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:1717:17: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:1717:17: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2662:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2662:45: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2662:45: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2704:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2704:49: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2704:49: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2778:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2778:45: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2778:45: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2826:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2826:49: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2826:49: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2936:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2936:56: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2936:56: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2948:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2948:49: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2948:49: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3039:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3039:56: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3039:56: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3051:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3051:49: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3051:49: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:3327:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3327:58: sparse:     expected void const *from
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3327:58: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3343:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3343:57: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3343:57: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:3345:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3345:43: sparse:     expected void *to
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3345:43: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3355:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3355:58: sparse:     expected void const *from
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3355:58: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3371:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3371:57: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3371:57: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3372:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3372:43: sparse:     expected void *to
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3372:43: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c: note: in included file (through include/linux/if_ether.h, include/linux/etherdevice.h):
   include/linux/skbuff.h:2904:28: sparse: sparse: unsigned value that used to be signed checked against zero?
   include/linux/skbuff.h:2904:28: sparse: signed value source
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2061:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2068:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2075:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2080:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2101:28: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2104:28: sparse: sparse: dereference of noderef expression

vim +3327 drivers/net/ethernet/wangxun/libwx/wx_lib.c

3b05aa997c4914 Jiawen Wu    2025-04-21  3314  
0ce45ae881fd90 Mengyuan Lou 2026-07-10  3315  int wx_set_ring(struct wx *wx, u32 new_tx_count,
883b5984a5d290 Jiawen Wu    2024-01-03  3316  		u32 new_rx_count, struct wx_ring *temp_ring)
883b5984a5d290 Jiawen Wu    2024-01-03  3317  {
883b5984a5d290 Jiawen Wu    2024-01-03  3318  	int i, err = 0;
883b5984a5d290 Jiawen Wu    2024-01-03  3319  
883b5984a5d290 Jiawen Wu    2024-01-03  3320  	/* Setup new Tx resources and free the old Tx resources in that order.
883b5984a5d290 Jiawen Wu    2024-01-03  3321  	 * We can then assign the new resources to the rings via a memcpy.
883b5984a5d290 Jiawen Wu    2024-01-03  3322  	 * The advantage to this approach is that we are guaranteed to still
883b5984a5d290 Jiawen Wu    2024-01-03  3323  	 * have resources even in the case of an allocation failure.
883b5984a5d290 Jiawen Wu    2024-01-03  3324  	 */
883b5984a5d290 Jiawen Wu    2024-01-03  3325  	if (new_tx_count != wx->tx_ring_count) {
883b5984a5d290 Jiawen Wu    2024-01-03  3326  		for (i = 0; i < wx->num_tx_queues; i++) {
883b5984a5d290 Jiawen Wu    2024-01-03 @3327  			memcpy(&temp_ring[i], wx->tx_ring[i],
883b5984a5d290 Jiawen Wu    2024-01-03  3328  			       sizeof(struct wx_ring));
883b5984a5d290 Jiawen Wu    2024-01-03  3329  
883b5984a5d290 Jiawen Wu    2024-01-03  3330  			temp_ring[i].count = new_tx_count;
883b5984a5d290 Jiawen Wu    2024-01-03  3331  			err = wx_setup_tx_resources(&temp_ring[i]);
883b5984a5d290 Jiawen Wu    2024-01-03  3332  			if (err) {
883b5984a5d290 Jiawen Wu    2024-01-03  3333  				wx_err(wx, "setup new tx resources failed, keep using the old config\n");
883b5984a5d290 Jiawen Wu    2024-01-03  3334  				while (i) {
883b5984a5d290 Jiawen Wu    2024-01-03  3335  					i--;
883b5984a5d290 Jiawen Wu    2024-01-03  3336  					wx_free_tx_resources(&temp_ring[i]);
883b5984a5d290 Jiawen Wu    2024-01-03  3337  				}
0ce45ae881fd90 Mengyuan Lou 2026-07-10  3338  				return err;
883b5984a5d290 Jiawen Wu    2024-01-03  3339  			}
883b5984a5d290 Jiawen Wu    2024-01-03  3340  		}
883b5984a5d290 Jiawen Wu    2024-01-03  3341  
883b5984a5d290 Jiawen Wu    2024-01-03  3342  		for (i = 0; i < wx->num_tx_queues; i++) {
883b5984a5d290 Jiawen Wu    2024-01-03  3343  			wx_free_tx_resources(wx->tx_ring[i]);
883b5984a5d290 Jiawen Wu    2024-01-03  3344  
883b5984a5d290 Jiawen Wu    2024-01-03 @3345  			memcpy(wx->tx_ring[i], &temp_ring[i],
883b5984a5d290 Jiawen Wu    2024-01-03  3346  			       sizeof(struct wx_ring));
883b5984a5d290 Jiawen Wu    2024-01-03  3347  		}
883b5984a5d290 Jiawen Wu    2024-01-03  3348  
883b5984a5d290 Jiawen Wu    2024-01-03  3349  		wx->tx_ring_count = new_tx_count;
883b5984a5d290 Jiawen Wu    2024-01-03  3350  	}
883b5984a5d290 Jiawen Wu    2024-01-03  3351  
883b5984a5d290 Jiawen Wu    2024-01-03  3352  	/* Repeat the process for the Rx rings if needed */
883b5984a5d290 Jiawen Wu    2024-01-03  3353  	if (new_rx_count != wx->rx_ring_count) {
883b5984a5d290 Jiawen Wu    2024-01-03  3354  		for (i = 0; i < wx->num_rx_queues; i++) {
883b5984a5d290 Jiawen Wu    2024-01-03  3355  			memcpy(&temp_ring[i], wx->rx_ring[i],
883b5984a5d290 Jiawen Wu    2024-01-03  3356  			       sizeof(struct wx_ring));
883b5984a5d290 Jiawen Wu    2024-01-03  3357  
883b5984a5d290 Jiawen Wu    2024-01-03  3358  			temp_ring[i].count = new_rx_count;
883b5984a5d290 Jiawen Wu    2024-01-03  3359  			err = wx_setup_rx_resources(&temp_ring[i]);
883b5984a5d290 Jiawen Wu    2024-01-03  3360  			if (err) {
883b5984a5d290 Jiawen Wu    2024-01-03  3361  				wx_err(wx, "setup new rx resources failed, keep using the old config\n");
883b5984a5d290 Jiawen Wu    2024-01-03  3362  				while (i) {
883b5984a5d290 Jiawen Wu    2024-01-03  3363  					i--;
883b5984a5d290 Jiawen Wu    2024-01-03  3364  					wx_free_rx_resources(&temp_ring[i]);
883b5984a5d290 Jiawen Wu    2024-01-03  3365  				}
0ce45ae881fd90 Mengyuan Lou 2026-07-10  3366  				return err;
883b5984a5d290 Jiawen Wu    2024-01-03  3367  			}
883b5984a5d290 Jiawen Wu    2024-01-03  3368  		}
883b5984a5d290 Jiawen Wu    2024-01-03  3369  
883b5984a5d290 Jiawen Wu    2024-01-03  3370  		for (i = 0; i < wx->num_rx_queues; i++) {
883b5984a5d290 Jiawen Wu    2024-01-03  3371  			wx_free_rx_resources(wx->rx_ring[i]);
883b5984a5d290 Jiawen Wu    2024-01-03  3372  			memcpy(wx->rx_ring[i], &temp_ring[i],
883b5984a5d290 Jiawen Wu    2024-01-03  3373  			       sizeof(struct wx_ring));
883b5984a5d290 Jiawen Wu    2024-01-03  3374  		}
883b5984a5d290 Jiawen Wu    2024-01-03  3375  
883b5984a5d290 Jiawen Wu    2024-01-03  3376  		wx->rx_ring_count = new_rx_count;
883b5984a5d290 Jiawen Wu    2024-01-03  3377  	}
0ce45ae881fd90 Mengyuan Lou 2026-07-10  3378  	return 0;
883b5984a5d290 Jiawen Wu    2024-01-03  3379  }
883b5984a5d290 Jiawen Wu    2024-01-03  3380  EXPORT_SYMBOL(wx_set_ring);
883b5984a5d290 Jiawen Wu    2024-01-03  3381  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
