Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDA53C3CC
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074581; cv=none; b=tuQuQjFJqHj1jOwrE/5q2jSxJ8iNK/SWZQjlNBm4HwgxnlYLcceh/VntDb6jlSLHHvfSNjTdjPrDF0HasvVFQhpq/LujFdBV1cLZ73usIx9n2hVH7uLf/sgUn2WIhSSckQCum1sZTgns4DOyVbjOl/0vx0pL8/2Q0EPgSYK3LeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074581; c=relaxed/simple;
	bh=uncBtlF1xpx3h5ek9X8UOtwJsZFpqeJZ3skgqWBmY1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTzKMXfnio09Y0ksMTqi3jg9nqOBqfwuTjo2Q4V0jsRq5th6YgFw3DXoD6j+wlX9xIQvuPWOta49/uAmRcYWSFc46vb4QePsP02BGIRk1kt60Q7L2i32tTFA7O2Hjg0LXh4QWV8XNqDCcbIknt6ipDkbY+U7sHVL9+HFCQjbUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZANMjyoH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZANMjyoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792074581; x=1823610581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uncBtlF1xpx3h5ek9X8UOtwJsZFpqeJZ3skgqWBmY1w=;
  b=ZANMjyoHYUlmgA1wBkNLeVMCkarPUYn6cI7iXAy5fizqqFcyQCF87jD1
   w5ohGjPH25BBFWXbrc/EAK1+s/cbUYf6ZqiTDcwYvruk7B2ypEP6ug1Kn
   p0T1MF2GmSkFWG5okl2Oo0YU0USzZ+HCyYdOIoUvgl0TRg5aVZFO1MD9I
   91GcWEHq+lEh6HO1C0WZQKfByfGIxAeTi3MSj+InnOl/GJFhe2hH/E76C
   xKyBj82zgdyhrMnL1m45vatWY4fPMaUgyzvBuG5zBSkTyy5oxCvBxFK+y
   C97N2JUo7cOoqmNy8SX6wj3tMURNzU+t/A0ZRdUOEbbwXu7PoT6E5BNew
   g==;
X-CSE-ConnectionGUID: FBTU38xQS8uAMkCz8g2Jxg==
X-CSE-MsgGUID: 33/P6CdaSVWW2+d1DipVjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="877374"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="877374"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:29:40 -0700
X-CSE-ConnectionGUID: 8PmyWNjKR/O4xRfeUXALaw==
X-CSE-MsgGUID: AlEmYPTcTUqHmbTg0onzOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1617077"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Oct 2026 07:29:37 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHMSc-00000000GeM-2PJ0;
	Thu, 15 Oct 2026 14:29:34 +0000
Date: Thu, 15 Oct 2026 22:29:08 +0800
From: kernel test robot <lkp@intel.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: Re: [PATCH net-next v4 11/12] cxgb4: extend debugfs support for T7
 adapters
Message-ID: <202610152254.VdQcytWi-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20261015/202610152254.VdQcytWi-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610152254.VdQcytWi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610152254.VdQcytWi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c:4365:18: error: use of undeclared identifier 'clip_tbl_fops'
    4365 |                 { "clip_tbl", &clip_tbl_fops, 0400, 0 },
         |                                ^~~~~~~~~~~~~
>> drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c:4390:5: error: invalid application of 'sizeof' to an incomplete type 'struct t4_linux_debugfs_entry[]'
    4390 |                                 ARRAY_SIZE(cxgb4_debugfs_files));
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   2 errors generated.


vim +/clip_tbl_fops +4365 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c

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
  4385	#ifdef CONFIG_DEBUG_FS
  4386		t4_setup_debugfs(adap);
  4387	#endif
  4388	
  4389		cxgb4_add_debugfs_files(adap, cxgb4_debugfs_files,
> 4390					ARRAY_SIZE(cxgb4_debugfs_files));

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
