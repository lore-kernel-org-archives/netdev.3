Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE56448D02;
	Thu,  8 Oct 2026 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791503999; cv=none; b=mWxUf6IHknxfFd2UUN9jHlyga/TgOuiLApKgQQuQltia91T0aNySYFIVJh9i3WU+NN4G4HJgwpTOLwLKmhmpVnC/AmdyjcaIeXUCif5YG8/2ML/Zx83ywORPgbHhs/8CdvY89r6QcvGU+8jeC0ACx66BToW0957kfkLs62DqqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791503999; c=relaxed/simple;
	bh=8O7QGNoYuQknRz+b/JCuamzNlQi9OXLlLH8Pn9qIFCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP422ir0SKMsCPiB1IQEBD99mZA2aNSZCEN8b/PDmVvUA8Vmg4kv/H5EuJOKC9lTPHYzyaTIfP1wxrUa19eFnh3hxyPlFF5Bs0IjmKtwz62wYAc3i7hyx7jusDlZ1FG/Fvl6jnY++uCQVmklbQpEsfxvpN8aeDcXHv4G+bFMAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBHc1Hin; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBHc1Hin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791503998; x=1823039998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8O7QGNoYuQknRz+b/JCuamzNlQi9OXLlLH8Pn9qIFCI=;
  b=OBHc1HingMF3S8xnBR6A2xihagE2CIdWqUmPDqiT0ZtQfyKPpSFl3jev
   0JpTaELHbVb7wK043cYPda4DnwTMRnm0N1mS4wiUcIgMFHRXeI8YNS5Nb
   wKMIrHgdspUc5H5bfkEO5c3KWtnc6zrYjtvy99it333QhUsavg4D0fO75
   HaxY1IsSjEiksX2uC+RMGXtfMsfsfyj8md2MCKlK8Ii6ppIrIgTXfsYfS
   l8lg6Z3sHmIyRNlTTvz2NVcNqZD9ImldOlvg7n2A7kYqVMRbnrnphY9Pp
   utVkjPIpNClwuHkuXxMf6o8cCXjzTYE1p0e4zCZf/QDHIVoDRJtZ506cl
   g==;
X-CSE-ConnectionGUID: wwsRKxhfTuuda6CTxdbv6A==
X-CSE-MsgGUID: 2xMN1ASRQ2KBgnJ5+/6X7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="199528"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="199528"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 16:59:57 -0700
X-CSE-ConnectionGUID: 1AKn2IkRTtqk7ZR9LfAblA==
X-CSE-MsgGUID: AE+TyOCrSLe0te4G7jjtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="277701"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Oct 2026 16:59:53 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEy1e-0000000054C-0Eo3;
	Thu, 08 Oct 2026 23:59:50 +0000
Date: Fri, 9 Oct 2026 07:59:34 +0800
From: kernel test robot <lkp@intel.com>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: Re: [PATCH net-next v2 7/8] net: qualcomm: rmnet: Add DL coalescing
 statistics
Message-ID: <202610090707.TY5x2Oyd-lkp@intel.com>
References: <20261008005543.2630828-8-subash.a.kasiviswanathan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008005543.2630828-8-subash.a.kasiviswanathan@oss.qualcomm.com>

Hi Subash,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on next-20261008]
[cannot apply to linux-review/Subash-Abhinov-Kasiviswanathan/uapi-if_link-Add-RMNET_FLAGS_INGRESS_COALESCE/20260929-221339 net/main lwn/docs-next linus/master v7.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Subash-Abhinov-Kasiviswanathan/net-qualcomm-rmnet-Update-MTU-handling-during-format-changes/20261007-175538
base:   net-next/main
patch link:    https://lore.kernel.org/r/20261008005543.2630828-8-subash.a.kasiviswanathan%40oss.qualcomm.com
patch subject: [PATCH net-next v2 7/8] net: qualcomm: rmnet: Add DL coalescing statistics
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20261009/202610090707.TY5x2Oyd-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 242243a5814307de825db3428662d67b064e2cbc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090707.TY5x2Oyd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610090707.TY5x2Oyd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c:286:13: warning: stack frame size (1392) exceeds limit (1280) in 'rmnet_get_ethtool_stats' [-Wframe-larger-than]
     286 | static void rmnet_get_ethtool_stats(struct net_device *dev,
         |             ^
   1 warning generated.


vim +/rmnet_get_ethtool_stats +286 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c

bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  285  
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15 @286  static void rmnet_get_ethtool_stats(struct net_device *dev,
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  287  				    struct ethtool_stats *stats, u64 *data)
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  288  {
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  289  	struct rmnet_priv *priv = netdev_priv(dev);
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  290  	struct rmnet_priv_stats total_stats = { };
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  291  	struct rmnet_pcpu_stats *pcpu_ptr;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  292  	struct rmnet_priv_stats snapshot;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  293  	unsigned int cpu, start;
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  294  
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  295  	if (!data)
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  296  		return;
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  297  
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  298  	for_each_possible_cpu(cpu) {
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  299  		pcpu_ptr = per_cpu_ptr(priv->pcpu_stats, cpu);
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  300  
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  301  		do {
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  302  			start = u64_stats_fetch_begin(&pcpu_ptr->syncp);
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  303  			u64_stats_copy(&snapshot, &pcpu_ptr->priv_stats,
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  304  				       sizeof(snapshot));
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  305  		} while (u64_stats_fetch_retry(&pcpu_ptr->syncp, start));
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  306  
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  307  		total_stats.csum_ok += snapshot.csum_ok;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  308  		total_stats.csum_ip4_header_bad += snapshot.csum_ip4_header_bad;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  309  		total_stats.csum_valid_unset += snapshot.csum_valid_unset;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  310  		total_stats.csum_validation_failed += snapshot.csum_validation_failed;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  311  		total_stats.csum_err_bad_buffer += snapshot.csum_err_bad_buffer;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  312  		total_stats.csum_err_invalid_ip_version +=
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  313  			snapshot.csum_err_invalid_ip_version;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  314  		total_stats.csum_err_invalid_transport +=
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  315  			snapshot.csum_err_invalid_transport;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  316  		total_stats.csum_fragmented_pkt += snapshot.csum_fragmented_pkt;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  317  		total_stats.csum_skipped += snapshot.csum_skipped;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  318  		total_stats.csum_sw += snapshot.csum_sw;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  319  		total_stats.csum_hw += snapshot.csum_hw;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  320  		/* Custom rmnet coalescing diagnostics follow. */
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  321  		total_stats.coal_alloc_fail += snapshot.coal_alloc_fail;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  322  		total_stats.coal_rx += snapshot.coal_rx;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  323  		total_stats.coal_pkts += snapshot.coal_pkts;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  324  		total_stats.coal_hdr_err += snapshot.coal_hdr_err;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  325  		total_stats.coal_hdr_pkt_err += snapshot.coal_hdr_pkt_err;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  326  		total_stats.coal_bounds_err += snapshot.coal_bounds_err;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  327  		total_stats.coal_csum_err += snapshot.coal_csum_err;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  328  		total_stats.coal_csum_drop += snapshot.coal_csum_drop;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  329  		total_stats.coal_reconstruct += snapshot.coal_reconstruct;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  330  		total_stats.coal_ip_invalid += snapshot.coal_ip_invalid;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  331  		total_stats.coal_trans_invalid += snapshot.coal_trans_invalid;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  332  		total_stats.coal_close_non_coal += snapshot.coal_close_non_coal;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  333  		total_stats.coal_close_ip_miss += snapshot.coal_close_ip_miss;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  334  		total_stats.coal_close_trans_miss += snapshot.coal_close_trans_miss;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  335  		total_stats.coal_close_hw_nl += snapshot.coal_close_hw_nl;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  336  		total_stats.coal_close_hw_pkt += snapshot.coal_close_hw_pkt;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  337  		total_stats.coal_close_hw_byte += snapshot.coal_close_hw_byte;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  338  		total_stats.coal_close_hw_time += snapshot.coal_close_hw_time;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  339  		total_stats.coal_close_hw_evict += snapshot.coal_close_hw_evict;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  340  		total_stats.coal_close_coal += snapshot.coal_close_coal;
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  341  	}
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  342  
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  343  	/* The first four fields are reported through netdev queue statistics. */
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  344  	memcpy(data, &total_stats.csum_ok,
2a458504868286e Subash Abhinov Kasiviswanathan 2026-10-07  345  	       sizeof(total_stats) - offsetof(struct rmnet_priv_stats, csum_ok));
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  346  }
bbde32d38bfbbc4 Subash Abhinov Kasiviswanathan 2018-05-15  347  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
