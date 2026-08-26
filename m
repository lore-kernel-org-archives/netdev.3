Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CA536AB46
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776098; cv=none; b=akdspyFis/Kjc+O+O4K5JLVtBiYqZpJkqbgFkUwe0U3JozSD9vtfViJbvYU+ZvNiyIE17+ls/f5RqjjqJ/5M3ua15cQXXFYTu/xL4bq8J+CRKZaBLwAcOBDVzfDcOmrIqNss/3oq3kovAKaBaEo693ib7VVjUXZlOAfMJBOme1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776098; c=relaxed/simple;
	bh=5oYtPm6z4ArC+5zm0cngRv2jRsYWShcxBZPm/ZjfTu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkSy0Hpdas/Q9HMHJb5fqksYuV8bgEnvFXBHxkOCV/0cA9whHLJM2XCzQ4VLj1taFHM2WwZyox8/l1ThuGIJaOl5Py8VukjXcIfPhppFvAktRopk1PrVUawO7ojAMuOaYCvTWXBYwnR/IWax+rSyyYHEAZUnbNASJlDmcSH+aqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YY2acPzY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YY2acPzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787776096; x=1819312096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5oYtPm6z4ArC+5zm0cngRv2jRsYWShcxBZPm/ZjfTu8=;
  b=YY2acPzY0zZlEHeBHozQkW+9HNe7RyN1aslXAobNGx3kTg0m3Z8hC5hp
   VhBSxRKUzoeW/OFAvigv6lu2UX2HXr9Hrwv+/HWZT43Pu9uA0RyCe/mDQ
   HtyvXpNUIlc7aIUTax3fIdc5hZBG8N/aWUam3BoXVpvQ0MRgzQzffo+Ai
   GF2ptFWJHgdBtRAhw8+TMCVdIFnVe9kCHXB9AOfQHUs7gSbHoSqfIoDsP
   wyK63fZTCrbLF7YFD8vUB9Q7tvfUyxmX96hgwwnrTHkb8Qu9ivicToT/J
   B43zUYjs1fclPbzkgHxvyaALfPMZtG3zYf24C5qFVjFdQdyODhWjqapgf
   g==;
X-CSE-ConnectionGUID: ORTW1ye0Qca/9NP0nz/+yA==
X-CSE-MsgGUID: IXLMa4saQWmWViOwFZDs6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87398555"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="87398555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 13:28:10 -0700
X-CSE-ConnectionGUID: jdEWrRVHS9GUyRJBktZK7Q==
X-CSE-MsgGUID: 0csEfiItQuusfvRnoD6mTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="297562630"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2026 13:28:08 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wzKE9-000000008ST-075W;
	Wed, 26 Aug 2026 20:28:05 +0000
Date: Thu, 27 Aug 2026 04:27:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net v3] net: libwx: protect ring accesses with RCU
Message-ID: <202608270436.2nJKiNXZ-lkp@intel.com>
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
config: microblaze-randconfig-r133-20260826 (https://download.01.org/0day-ci/archive/20260827/202608270436.2nJKiNXZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260827/202608270436.2nJKiNXZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608270436.2nJKiNXZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:208:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:208:54: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_vf_common.c:208:54: sparse:     got struct wx_ring [noderef] __rcu *
--
>> drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c:179:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c:179:56: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c:179:56: sparse:     got struct wx_ring [noderef] __rcu *
--
>> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:158:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:158:22: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:158:22: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:173:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:173:22: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:173:22: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:808:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:810:36: sparse: sparse: dereference of noderef expression
--
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:1717:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:1717:17: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:1717:17: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:2662:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2662:45: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2662:45: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2704:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2704:49: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2704:49: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:2778:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
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
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:3327:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3327:58: sparse:     expected void const *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3327:58: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3343:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *tx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3343:57: sparse:     expected struct wx_ring *tx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3343:57: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:3345:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3345:43: sparse:     expected void *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3345:43: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3355:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3355:58: sparse:     expected void const *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3355:58: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3371:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3371:57: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3371:57: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3372:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3372:43: sparse:     expected void *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:3372:43: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_lib.c: note: in included file (through include/linux/if_ether.h, include/linux/etherdevice.h):
   include/linux/skbuff.h:2904:28: sparse: sparse: unsigned value that used to be signed checked against zero?
   include/linux/skbuff.h:2904:28: sparse: signed value source
>> drivers/net/ethernet/wangxun/libwx/wx_lib.c:2061:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2068:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2075:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2080:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2101:28: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/libwx/wx_lib.c:2104:28: sparse: sparse: dereference of noderef expression
--
>> drivers/net/ethernet/wangxun/libwx/wx_hw.c:1602:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:1602:51: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:1602:51: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_hw.c:1800:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct wx_ring *rx_ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:1800:25: sparse:     expected struct wx_ring *rx_ring
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:1800:25: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/libwx/wx_hw.c:2025:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2025:53: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2025:53: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2251:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2251:53: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2251:53: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2842:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2842:58: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2842:58: sparse:     got struct wx_ring [noderef] __rcu *
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2845:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2845:59: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/libwx/wx_hw.c:2845:59: sparse:     got struct wx_ring [noderef] __rcu *
--
>> drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c:40:36: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c:42:36: sparse: sparse: dereference of noderef expression
--
>> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:409:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct wx_ring *ring @@     got struct wx_ring [noderef] __rcu * @@
   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:409:52: sparse:     expected struct wx_ring *ring
   drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:409:52: sparse:     got struct wx_ring [noderef] __rcu *
>> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:425:41: sparse: sparse: dereference of noderef expression

vim +1717 drivers/net/ethernet/wangxun/libwx/wx_lib.c

09a508800952f8 Mengyuan Lou 2023-02-03  1696  
09a508800952f8 Mengyuan Lou 2023-02-03  1697  netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
09a508800952f8 Mengyuan Lou 2023-02-03  1698  			  struct net_device *netdev)
09a508800952f8 Mengyuan Lou 2023-02-03  1699  {
09a508800952f8 Mengyuan Lou 2023-02-03  1700  	unsigned int r_idx = skb->queue_mapping;
09a508800952f8 Mengyuan Lou 2023-02-03  1701  	struct wx *wx = netdev_priv(netdev);
09a508800952f8 Mengyuan Lou 2023-02-03  1702  	struct wx_ring *tx_ring;
09a508800952f8 Mengyuan Lou 2023-02-03  1703  
09a508800952f8 Mengyuan Lou 2023-02-03  1704  	if (!netif_carrier_ok(netdev)) {
09a508800952f8 Mengyuan Lou 2023-02-03  1705  		dev_kfree_skb_any(skb);
09a508800952f8 Mengyuan Lou 2023-02-03  1706  		return NETDEV_TX_OK;
09a508800952f8 Mengyuan Lou 2023-02-03  1707  	}
09a508800952f8 Mengyuan Lou 2023-02-03  1708  
09a508800952f8 Mengyuan Lou 2023-02-03  1709  	/* The minimum packet size for olinfo paylen is 17 so pad the skb
09a508800952f8 Mengyuan Lou 2023-02-03  1710  	 * in order to meet this minimum size requirement.
09a508800952f8 Mengyuan Lou 2023-02-03  1711  	 */
09a508800952f8 Mengyuan Lou 2023-02-03  1712  	if (skb_put_padto(skb, 17))
09a508800952f8 Mengyuan Lou 2023-02-03  1713  		return NETDEV_TX_OK;
09a508800952f8 Mengyuan Lou 2023-02-03  1714  
09a508800952f8 Mengyuan Lou 2023-02-03  1715  	if (r_idx >= wx->num_tx_queues)
09a508800952f8 Mengyuan Lou 2023-02-03  1716  		r_idx = r_idx % wx->num_tx_queues;
09a508800952f8 Mengyuan Lou 2023-02-03 @1717  	tx_ring = wx->tx_ring[r_idx];
09a508800952f8 Mengyuan Lou 2023-02-03  1718  
09a508800952f8 Mengyuan Lou 2023-02-03  1719  	return wx_xmit_frame_ring(skb, tx_ring);
09a508800952f8 Mengyuan Lou 2023-02-03  1720  }
09a508800952f8 Mengyuan Lou 2023-02-03  1721  EXPORT_SYMBOL(wx_xmit_frame);
09a508800952f8 Mengyuan Lou 2023-02-03  1722  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
