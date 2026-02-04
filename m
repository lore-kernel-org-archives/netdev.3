Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320936E497;
	Wed,  4 Feb 2026 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247905; cv=none; b=gLP0RHMIzU0SMIPUPwczF2+IMQJNmHuWfUp4imcU4XiO7BpfWfYsBO+jpPmaUdkTT91lhUkielzKK5Rpkvi4dtqJB7UpdU10enC0OBOjIiuybhALt8PF64ZK92P3nlOr1sl6O4PIWzSR3nUixGJ51BBuK7iidZ/dRIw5uxpOLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247905; c=relaxed/simple;
	bh=A/mvAOGLp0G4x6EUjGVks/0dtJp82veA/rORZI0S8Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj6Q8NaUxHQEeSj2TnsHgRhXplwBsCmO+zOvAQ5jT7qpU8HjsJTERH5Qxoa4K35fUhBVfZzX2dsQa8UoGXkX/UW7Mk6MwD99NFP8IfqA9yVEHq0Y8+hMkGkUxKo9AOBjf6K7fuxwwIUdD2NAHQ9PaSeF6fJ0SKOPcdEs7cfd74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSnkKvbE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSnkKvbE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770247905; x=1801783905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/mvAOGLp0G4x6EUjGVks/0dtJp82veA/rORZI0S8Wg=;
  b=GSnkKvbEES2fpUd30PUr2nSXFqhisrJxzjKtTkVOdEXtoPnPm5LdCalh
   PVvDcvkSH30kwVSu3rTEoIwBOZEsyNakCfMqiP1LtAoVOxrKu/tg6a5m/
   NbranFlIy4mCVOBHs3X3Ez3kGzGfDxYoCMfwujgOgHxGqzysKHKiGTVlU
   kBfWlvWZq5GeVmsb2QwkB67wlAtUdqHVojdaSoT4EPY+8OtdRRg2hhBvr
   l/tCzQpHF8TXrNVnjuJh1QH6NRRn8s99MZBw53ZnH4DRO2W3vg/KhDdbL
   VLRS5wYpGKmII1oLpCd0P2kBN+7uYVk2rIePHXtR3HzoQiukKHMgoB3y7
   A==;
X-CSE-ConnectionGUID: E1WpT/teS4u6+A3kf/h/yA==
X-CSE-MsgGUID: Le8sz9ZzSeqwRJaLt8Np+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70639524"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="70639524"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 15:31:44 -0800
X-CSE-ConnectionGUID: iEEz9+dLScWuQn2rczeETA==
X-CSE-MsgGUID: X4qQQThbRaKum4g/bOa/uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="210340839"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 Feb 2026 15:31:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnmLR-00000000jEu-1zGT;
	Wed, 04 Feb 2026 23:31:37 +0000
Date: Thu, 5 Feb 2026 07:30:53 +0800
From: kernel test robot <lkp@intel.com>
To: Meghana Malladi <m-malladi@ti.com>, vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com, horms@kernel.org, parvathi@couthit.com,
	afd@ti.com, vladimir.oltean@nxp.com, rogerq@kernel.org,
	danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
Message-ID: <202602050744.pYAnjG71-lkp@intel.com>
References: <20260204140044.4086725-3-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204140044.4086725-3-m-malladi@ti.com>

Hi Meghana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9a9424c756feee9ee6e717405a9d6fa7bacdef08]

url:    https://github.com/intel-lab-lkp/linux/commits/Meghana-Malladi/net-ti-icssg-prueth-Add-Frame-Preemption-MAC-Merge-support/20260204-220543
base:   9a9424c756feee9ee6e717405a9d6fa7bacdef08
patch link:    https://lore.kernel.org/r/20260204140044.4086725-3-m-malladi%40ti.com
patch subject: [PATCH net-next v2 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260205/202602050744.pYAnjG71-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602050744.pYAnjG71-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602050744.pYAnjG71-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/ti/icssg/icssg_prueth.h:48,
                    from drivers/net/ethernet/ti/icssg/icssg_prueth.c:34:
>> drivers/net/ethernet/ti/icssg/icssg_stats.h:93:38: warning: 'icssg_all_miig_stats' defined but not used [-Wunused-const-variable=]
      93 | static const struct icssg_miig_stats icssg_all_miig_stats[] = {
         |                                      ^~~~~~~~~~~~~~~~~~~~


vim +/icssg_all_miig_stats +93 drivers/net/ethernet/ti/icssg/icssg_stats.h

c1e10d5dc7a1be MD Danish Anwar 2023-08-01   92  
550ee90ac61c1f MD Danish Anwar 2024-08-22  @93  static const struct icssg_miig_stats icssg_all_miig_stats[] = {
c1e10d5dc7a1be MD Danish Anwar 2023-08-01   94  	/* Rx */
550ee90ac61c1f MD Danish Anwar 2024-08-22   95  	ICSSG_MIIG_STATS(rx_packets, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22   96  	ICSSG_MIIG_STATS(rx_broadcast_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22   97  	ICSSG_MIIG_STATS(rx_multicast_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22   98  	ICSSG_MIIG_STATS(rx_crc_errors, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22   99  	ICSSG_MIIG_STATS(rx_mii_error_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  100  	ICSSG_MIIG_STATS(rx_odd_nibble_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  101  	ICSSG_MIIG_STATS(rx_frame_max_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  102  	ICSSG_MIIG_STATS(rx_max_size_error_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  103  	ICSSG_MIIG_STATS(rx_frame_min_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  104  	ICSSG_MIIG_STATS(rx_min_size_error_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  105  	ICSSG_MIIG_STATS(rx_over_errors, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  106  	ICSSG_MIIG_STATS(rx_class0_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  107  	ICSSG_MIIG_STATS(rx_class1_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  108  	ICSSG_MIIG_STATS(rx_class2_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  109  	ICSSG_MIIG_STATS(rx_class3_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  110  	ICSSG_MIIG_STATS(rx_class4_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  111  	ICSSG_MIIG_STATS(rx_class5_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  112  	ICSSG_MIIG_STATS(rx_class6_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  113  	ICSSG_MIIG_STATS(rx_class7_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  114  	ICSSG_MIIG_STATS(rx_class8_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  115  	ICSSG_MIIG_STATS(rx_class9_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  116  	ICSSG_MIIG_STATS(rx_class10_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  117  	ICSSG_MIIG_STATS(rx_class11_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  118  	ICSSG_MIIG_STATS(rx_class12_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  119  	ICSSG_MIIG_STATS(rx_class13_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  120  	ICSSG_MIIG_STATS(rx_class14_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  121  	ICSSG_MIIG_STATS(rx_class15_hits, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  122  	ICSSG_MIIG_STATS(rx_smd_frags, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  123  	ICSSG_MIIG_STATS(rx_bucket1_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  124  	ICSSG_MIIG_STATS(rx_bucket2_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  125  	ICSSG_MIIG_STATS(rx_bucket3_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  126  	ICSSG_MIIG_STATS(rx_bucket4_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  127  	ICSSG_MIIG_STATS(rx_64B_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  128  	ICSSG_MIIG_STATS(rx_bucket1_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  129  	ICSSG_MIIG_STATS(rx_bucket2_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  130  	ICSSG_MIIG_STATS(rx_bucket3_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  131  	ICSSG_MIIG_STATS(rx_bucket4_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  132  	ICSSG_MIIG_STATS(rx_bucket5_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  133  	ICSSG_MIIG_STATS(rx_bytes, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  134  	ICSSG_MIIG_STATS(rx_tx_total_bytes, false),
c1e10d5dc7a1be MD Danish Anwar 2023-08-01  135  	/* Tx */
550ee90ac61c1f MD Danish Anwar 2024-08-22  136  	ICSSG_MIIG_STATS(tx_packets, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  137  	ICSSG_MIIG_STATS(tx_broadcast_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  138  	ICSSG_MIIG_STATS(tx_multicast_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  139  	ICSSG_MIIG_STATS(tx_odd_nibble_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  140  	ICSSG_MIIG_STATS(tx_underflow_errors, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  141  	ICSSG_MIIG_STATS(tx_frame_max_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  142  	ICSSG_MIIG_STATS(tx_max_size_error_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  143  	ICSSG_MIIG_STATS(tx_frame_min_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  144  	ICSSG_MIIG_STATS(tx_min_size_error_frames, false),
550ee90ac61c1f MD Danish Anwar 2024-08-22  145  	ICSSG_MIIG_STATS(tx_bucket1_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  146  	ICSSG_MIIG_STATS(tx_bucket2_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  147  	ICSSG_MIIG_STATS(tx_bucket3_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  148  	ICSSG_MIIG_STATS(tx_bucket4_size, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  149  	ICSSG_MIIG_STATS(tx_64B_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  150  	ICSSG_MIIG_STATS(tx_bucket1_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  151  	ICSSG_MIIG_STATS(tx_bucket2_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  152  	ICSSG_MIIG_STATS(tx_bucket3_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  153  	ICSSG_MIIG_STATS(tx_bucket4_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  154  	ICSSG_MIIG_STATS(tx_bucket5_frames, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  155  	ICSSG_MIIG_STATS(tx_bytes, true),
550ee90ac61c1f MD Danish Anwar 2024-08-22  156  };
550ee90ac61c1f MD Danish Anwar 2024-08-22  157  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
