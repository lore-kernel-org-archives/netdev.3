Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6030E851;
	Tue, 21 Jul 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638093; cv=none; b=AFM+dRvgiy0mCkrRNR2HpjU9afNjfajTZLY1hr1GOiyHRJi7kIvP5l8DZQ+7l9l412KDDaploK/9cJj+CAQ75S0a0MIXaTSN+fSS1QKp8wNmMnNVfeFCsWnzMmiPQd/we56XBHGgqEmY8q3J6jRICpKHgD9r+bNfP8/xOuOBj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638093; c=relaxed/simple;
	bh=3hb3MJA1XeYJMyWxNd0a24N9Rx19kjRJVv2oCwEAeZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utAGvOx7+PO9NSNAlPtlIm7b3kXX2XRb2/hx3hI8N1J1dszXFI6LOr6j68ew2aFaw2FkRtZUFjcOSS64G0ND83udtUov6ySHauG4U4z8bLZocHt87IWvyMrM1LaG9g2hQeTu+wB3ofq9JL0tR9nCiS8igrFulUPkMlPq98yd7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liULPMML; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liULPMML"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784638090; x=1816174090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3hb3MJA1XeYJMyWxNd0a24N9Rx19kjRJVv2oCwEAeZM=;
  b=liULPMMLaypMkBVZfB5IpmuDvz5TSbM0JKQohgmW3DNP5N+zpGNec1m2
   tObYwLcWltoAQ0952zUsjKIJBxFSx5M9+0KxIW3mb4kw1NMYeROyb3uGb
   rs32QX1EQ8FnKrzBLZnLCPxviNI3Z5CtaAoXmfH++ZbPl6wNg3CgrBLGU
   emO+hUaRMtslxGz1aTL+0GE0b3yeN8VSlVv+uPXJuQW9T9MGurc49lj9O
   kru+zBlsbexn8Cizs7X0/EdmU8OyB0PTvToTBnTEobmK+CczpuT3u85+H
   12In25yhLL9ybVJRBr7ELIO05bcq76sBLExNP6J2CEraFbOzHppftgt/G
   A==;
X-CSE-ConnectionGUID: 1V0wODc6Tnq6WdeYsXVsEQ==
X-CSE-MsgGUID: 23cA1yZlT4mDtYXz0p9UHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85275230"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85275230"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 05:48:09 -0700
X-CSE-ConnectionGUID: bl2i8qpmTOm3x0zynrViPw==
X-CSE-MsgGUID: 2aqjFEavRPyyFE4qv33RIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="261315092"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 21 Jul 2026 05:48:07 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wm9tE-000000006Nh-1inf;
	Tue, 21 Jul 2026 12:48:04 +0000
Date: Tue, 21 Jul 2026 14:47:53 +0200
From: kernel test robot <lkp@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] mlxsw: pci: Quiesce EQ tasklet and CQ NAPI before
 teardown
Message-ID: <202607211419.DxdkHKb7-lkp@intel.com>
References: <20260721062105.55014-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721062105.55014-1-mhun512@gmail.com>

Hi Myeonghun,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Myeonghun-Pak/mlxsw-pci-Quiesce-EQ-tasklet-and-CQ-NAPI-before-teardown/20260721-142527
base:   net/main
patch link:    https://lore.kernel.org/r/20260721062105.55014-1-mhun512%40gmail.com
patch subject: [PATCH net] mlxsw: pci: Quiesce EQ tasklet and CQ NAPI before teardown
config: x86_64-rhel-9.4-bpf (https://download.01.org/0day-ci/archive/20260721/202607211419.DxdkHKb7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260721/202607211419.DxdkHKb7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607211419.DxdkHKb7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_cq_init':
>> drivers/net/ethernet/mellanox/mlxsw/pci.c:1077:32: error: 'truea' undeclared (first use in this function); did you mean 'true'?
    1077 |         q->u.cq.napi_enabled = truea
         |                                ^~~~~
         |                                true
   drivers/net/ethernet/mellanox/mlxsw/pci.c:1077:32: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/mellanox/mlxsw/pci.c:1077:37: error: expected ';' before 'mlxsw_pci_queue_doorbell_consumer_ring'
    1077 |         q->u.cq.napi_enabled = truea
         |                                     ^
         |                                     ;
    1078 |         mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1077 drivers/net/ethernet/mellanox/mlxsw/pci.c

  1036	
  1037	static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
  1038				     struct mlxsw_pci_queue *q)
  1039	{
  1040		enum mlxsw_pci_cq_type cq_type = mlxsw_pci_cq_type(mlxsw_pci, q);
  1041		int i;
  1042		int err;
  1043	
  1044		q->consumer_counter = 0;
  1045	
  1046		for (i = 0; i < q->count; i++) {
  1047			char *elem = mlxsw_pci_queue_elem_get(q, i);
  1048	
  1049			mlxsw_pci_cqe_owner_set(q->u.cq.v, elem, 1);
  1050		}
  1051	
  1052		if (q->u.cq.v == MLXSW_PCI_CQE_V1)
  1053			mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
  1054					MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_1);
  1055		else if (q->u.cq.v == MLXSW_PCI_CQE_V2)
  1056			mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
  1057					MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_2);
  1058	
  1059		mlxsw_cmd_mbox_sw2hw_cq_c_eqn_set(mbox, MLXSW_PCI_EQ_COMP_NUM);
  1060		mlxsw_cmd_mbox_sw2hw_cq_st_set(mbox, 0);
  1061		mlxsw_cmd_mbox_sw2hw_cq_log_cq_size_set(mbox, ilog2(q->count));
  1062		for (i = 0; i < MLXSW_PCI_AQ_PAGES; i++) {
  1063			dma_addr_t mapaddr = __mlxsw_pci_queue_page_get(q, i);
  1064	
  1065			mlxsw_cmd_mbox_sw2hw_cq_pa_set(mbox, i, mapaddr);
  1066		}
  1067		err = mlxsw_cmd_sw2hw_cq(mlxsw_pci->core, mbox, q->num);
  1068		if (err)
  1069			return err;
  1070		mlxsw_pci_cq_napi_setup(q, cq_type);
  1071	
  1072		err = mlxsw_pci_cq_page_pool_init(q, cq_type);
  1073		if (err)
  1074			goto err_page_pool_init;
  1075	
  1076		napi_enable(&q->u.cq.napi);
> 1077		q->u.cq.napi_enabled = truea
  1078		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
  1079		mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
  1080		return 0;
  1081	
  1082	err_page_pool_init:
  1083		mlxsw_pci_cq_napi_teardown(q);
  1084		return err;
  1085	}
  1086	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
