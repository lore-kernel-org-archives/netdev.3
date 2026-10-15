Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878149CF54
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073381; cv=none; b=gWYCr5xuwW3q4f9BAOp79/04qgkbAqDbsJcbHC5sroeL3Xp9wSN2bHFehv7rqDsJMjXpDKx4sAeiYdYFuvMmaNnHPfitXRGPbp33NGKfF7AmTDITQuLqzqQyb/olG9/SsgGkHXvG71zQAeTrbyoiFWIYqzN/GIHT8GLrCRadytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073381; c=relaxed/simple;
	bh=E4Z2ILIU8tW0DpZFFQ5YOJ8dxkHXQFmBgd1ma+smWpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uac/coWQMtjuUW8whKDUkAuoutn2oTwCQM0hn1t8ZJDMYZsK5xSn15lelTK6Tbhy5fimHRhZfj0KCU1itp9KNgKdX/sQbWVeCoAJ5Ixt6eFsnaXcji/213gs25zrIT9TE+4fCBt8riEW2w2H59QCNSqClK6oCQZiJQewMdBg4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfe1VcxB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfe1VcxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792073378; x=1823609378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4Z2ILIU8tW0DpZFFQ5YOJ8dxkHXQFmBgd1ma+smWpM=;
  b=Vfe1VcxBdzSxlz1IHKxmp1IInfMu7drAlwAvuBNUUCrwgETxwIlg1UIx
   liyyJmGyrS3wlzx+Ik+2s8ecLaBKti10QkcFiCXGF9p1w0prMWq1CiPTn
   HtyzvZzMGYY9elirDqvBDcjUwJBgGAXnq40ODpdG7SZ/wDnnOQN7jGQ89
   iEQKAa6GY6XJzlVAFpVjpwWpVmHk0w/c/3ti/7AaXs95uIyfEDPQEQcxC
   BN77PRWcBAebaSO684jl3/M+qfuQydMRuO0HlZG8/raTH+KssQj4B1KM/
   NqxmJhNsNoIf1XhA0YAEX1q/wVJIUKv42kQgw8d+ZfmEW9cIsiLWazYlt
   Q==;
X-CSE-ConnectionGUID: AFIIIB6vToGQxqcgnQDQjQ==
X-CSE-MsgGUID: gDNBt0KYRlmfhxKCBmv2Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="746545"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="746545"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:09:38 -0700
X-CSE-ConnectionGUID: fpb+epDzRUawD1U3ICt33A==
X-CSE-MsgGUID: 7r9bj5XwTTidcpKQVjrCLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1722190"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Oct 2026 07:09:36 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHM9F-00000000Gco-1tKt;
	Thu, 15 Oct 2026 14:09:33 +0000
Date: Thu, 15 Oct 2026 22:08:33 +0800
From: kernel test robot <lkp@intel.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	bharat@chelsio.com
Subject: Re: [PATCH net-next v4 11/12] cxgb4: extend debugfs support for T7
 adapters
Message-ID: <202610152202.xxgjlBCN-lkp@intel.com>
References: <20261014221257.436789-12-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014221257.436789-12-bharat@chelsio.com>

Hi Potnuri,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.3-rc7 next-20261012]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Potnuri-Bharat-Teja/cxgb4-add-T7-hardware-definitions-and-firmware-interfaces/20261014-181246
base:   linus/master
patch link:    https://lore.kernel.org/r/20261014221257.436789-12-bharat%40chelsio.com
patch subject: [PATCH net-next v4 11/12] cxgb4: extend debugfs support for T7 adapters
config: x86_64-randconfig-1000-20261015 (https://download.01.org/0day-ci/archive/20261015/202610152202.xxgjlBCN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610152202.xxgjlBCN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610152202.xxgjlBCN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c: In function 'cxgb4_setup_debugfs':
>> drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c:4365:32: error: 'clip_tbl_fops' undeclared (first use in this function); did you mean 'cctrl_tbl_fops'?
    4365 |                 { "clip_tbl", &clip_tbl_fops, 0400, 0 },
         |                                ^~~~~~~~~~~~~
         |                                cctrl_tbl_fops
   drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c:4365:32: note: each undeclared identifier is reported only once for each function it appears in


vim +4365 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c

  4355	
  4356	int cxgb4_setup_debugfs(struct adapter *adap)
  4357	{
  4358		static struct t4_linux_debugfs_entry cxgb4_debugfs_files[] = {
  4359			{ "blocked_fl", &blocked_fl_fops, 0600 },
  4360	#ifdef CONFIG_CHELSIO_T4_DCB
  4361			{ "dcb_info", &dcb_info_debugfs_fops, 0400, 0 },
  4362			#endif /* CONFIG_CHELSIO_T4_DCB */
  4363			{ "resources", &resources_fops, 0400, 0 },
  4364			{ "sge_qinfo", &sge_qinfo_debugfs_fops, 0400, 0 },
> 4365			{ "clip_tbl", &clip_tbl_fops, 0400, 0 },
  4366			{ "tids", &tid_info_fops, 0400, 0 },
  4367			{ "trace0", &mps_trc_debugfs_fops, 0600, 0 },
  4368			{ "trace1", &mps_trc_debugfs_fops, 0600, 1 },
  4369			{ "trace2", &mps_trc_debugfs_fops, 0600, 2 },
  4370			{ "trace3", &mps_trc_debugfs_fops, 0600, 3 },
  4371			{ "l2t", &t4_l2t_fops, 0400, 0 },
  4372			{ "crypto", &chcr_stats_fops, 0400, 0 },
  4373		};
  4374	
  4375		static struct t4_linux_debugfs_entry cxgb4_t7_debugfs_files[] = {
  4376			{ "trace4", &mps_trc_debugfs_fops, 0600, 4 },
  4377			{ "trace5", &mps_trc_debugfs_fops, 0600, 5 },
  4378			{ "trace6", &mps_trc_debugfs_fops, 0600, 6 },
  4379			{ "trace7", &mps_trc_debugfs_fops, 0600, 7 },
  4380		};
  4381	
  4382		if (IS_ERR_OR_NULL(adap->debugfs_root))
  4383			return -1;
  4384	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
