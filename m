Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E67364052
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230171; cv=none; b=WRcva0m2u4llIzGzuNzCwVUyGScPCJat8LsTk7s6pxJpHgtXvzLPyOJz1SH63dvV7VLlNEAKcs/LwSIGh4lsnXBvczTbazaBn6spQlVu+rDcr1RKakUD/poAP+Wx/9eGTMvbeqAquJmr2RdZoQ7jh+0+Vao4VHVpqN54w5kb/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230171; c=relaxed/simple;
	bh=V3WSP+eiM9+d0ZifcOV9ub6UMZ7U9odjgtO0fakZYUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRb0eTGW50DEHQwNmR/iXE51J4OgS+sUbU4lpSt1hlaLBMrwjfntDci5xrQoXv1iah/+IXKl0u3vevxjMrcM615b1/tvSKb4JmZY3z8JMCd3k3AY/FLLcQwp70Nj9XPKx+vFI4SGzXRLgNrpciJoOkOBH2KmFL/zRmMTjlrel2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIhu2bgc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIhu2bgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791230170; x=1822766170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3WSP+eiM9+d0ZifcOV9ub6UMZ7U9odjgtO0fakZYUU=;
  b=aIhu2bgc77QgeODQbcmuCCKtAb8eKSJxnhVj/cjRuv4rwfdlXeXxhMul
   ivmRRq6WeSHLjTlnuW2hU6fSpGXB/pTgieB1fDWt6xm6jR17aeb/GgPVu
   MKzPiZzjo39FLEYWqY1chslKWL6QRFB/Z4Gwes8BkQ6lSkBCA0ODuw2Hm
   g0JIQrhtVgv/eqzWFr16MTEI6dsioGCbC4sjDZRVadXm9RXIMwNjAcPHM
   5BnsnnkJlJ0Ajt5hcBE9Rd7b+GpGDmIKe9C41j5SAX1NkX85RhiXyFPVn
   GK/4RRrWD2HATuqX2sL34D17YzYGR/lTIHdaBiEDlebNyknHBp58SqI0B
   A==;
X-CSE-ConnectionGUID: RVlrveyHRFSBsjHqGi91kA==
X-CSE-MsgGUID: JhmPjCnNRV6qJh38wPzQQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94621019"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="94621019"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 12:56:09 -0700
X-CSE-ConnectionGUID: OYbDjfG7QOS9MOnMYW3x2w==
X-CSE-MsgGUID: lXguA6/HSK21sI8Qwd80kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="303176760"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Oct 2026 12:56:06 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDon5-000000000m0-3yuE;
	Mon, 05 Oct 2026 19:56:03 +0000
Date: Tue, 6 Oct 2026 03:55:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tung Nguyen <tung.quang.nguyen@est.tech>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com,
	horms@kernel.org, tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: Re: [PATCH net] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
Message-ID: <202610060355.bPzTfoXZ-lkp@intel.com>
References: <20261005041053.22695-1-tung.quang.nguyen@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005041053.22695-1-tung.quang.nguyen@est.tech>

Hi Tung,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tung-Nguyen/tipc-fix-several-race-conditions-caused-by-tipc_node_write_unlock/20261005-111023
base:   net/main
patch link:    https://lore.kernel.org/r/20261005041053.22695-1-tung.quang.nguyen%40est.tech
patch subject: [PATCH net] tipc: fix several race conditions caused by tipc_node_write_unlock()
config: parisc-randconfig-1001-20261006 (https://download.01.org/0day-ci/archive/20261006/202610060355.bPzTfoXZ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261006/202610060355.bPzTfoXZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610060355.bPzTfoXZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/tipc/name_distr.c:281 function parameter 'publ_list' not described in 'tipc_update_nametbl'
>> Warning: net/tipc/name_distr.c:375 function parameter 'publ_list' not described in 'tipc_named_rcv'
>> Warning: net/tipc/name_distr.c:281 function parameter 'publ_list' not described in 'tipc_update_nametbl'
>> Warning: net/tipc/name_distr.c:375 function parameter 'publ_list' not described in 'tipc_named_rcv'
--
>> Warning: net/tipc/name_table.c:820 function parameter 'skb' not described in 'tipc_nametbl_withdraw'
>> Warning: net/tipc/name_table.c:820 function parameter 'rc_dests' not described in 'tipc_nametbl_withdraw'
>> Warning: net/tipc/name_table.c:820 function parameter 'skb' not described in 'tipc_nametbl_withdraw'
>> Warning: net/tipc/name_table.c:820 function parameter 'rc_dests' not described in 'tipc_nametbl_withdraw'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
