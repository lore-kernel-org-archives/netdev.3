Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A342AFB1;
	Tue, 15 Sep 2026 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513819; cv=none; b=c39B8WpOL0sX+Hj8b3YCXpp5T2HbFPu3CI3meZxaJjDdLp1xswtYBDxRdPFVKE94LItveVKMfd7glxog86O/gbHDxVlD8eczvFt8H8BpNOgzb38MMAnx5+DGx+y6OhZOZVC+aIrHQldwpC1Tp4iqZga6sI+YhEZoLRAewyIT93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513819; c=relaxed/simple;
	bh=9Gk0LrH3CLMU7DiA29jf13FlZlmc921jIY+RqM7B3sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuhPfPqd+JgvmauZuh5Hn4X9cOdM/G18tAjkJoQJe8JebXBRK96tZGlpQ04sH9MO2nRVzG68yDE/1+iqoizt1eQ//stti0oXSbndTcSs6fpZ46iNYXv8CsxIkgu+1tA60anV24FaUaDIdniJlozoKiMfof2nUP+1Dzwm44bUeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vx419V6g; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx419V6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789513818; x=1821049818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Gk0LrH3CLMU7DiA29jf13FlZlmc921jIY+RqM7B3sY=;
  b=Vx419V6geokFdux8OKW+RYa2EAdT6yzQKiZm+3+qCWdp/SrFGacAE/ZB
   L6qsLnpb2qOH5BoIiw7tqq6pUEb3MuqS/9HnyeimjzEahmzn7uSjEJCk7
   VXbOwYTDBeXtRNG8wFeP4mymu0RsFN3HthraOJmROKvfGep3bCUfVyiHI
   znijQv5UmYJfbabUPCWS0prji78w1iHQ6VBhtGXOGyjLxcKYiMXo9Dn6G
   z5dJyzydE5/JI5UWxB1egqN9YLk/b8isW/YsreKTzbzeedw+Ur7Qpg2FN
   HMDLIHxG61ht1oJ4b7j9Pwsg1fjh1IybIUPQFEnvFrpz2zN6JWIGuM23e
   A==;
X-CSE-ConnectionGUID: ZYHlxwOLSVqewB7jCLkXaQ==
X-CSE-MsgGUID: ns1JXAd3SaCvD8QlTofQyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100552589"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100552589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:10:18 -0700
X-CSE-ConnectionGUID: zz8NMjNcSySXXZRgsIecqw==
X-CSE-MsgGUID: tH4lm4YXS7ihvqpE9F+z+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298209722"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 16:10:14 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6cHz-0000000059d-3v8Y;
	Tue, 15 Sep 2026 23:10:11 +0000
Date: Wed, 16 Sep 2026 07:10:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, davem@davemloft.net,
	gakula@marvell.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sgoutham@marvell.com, Subbaraya Sundeep <sbhatta@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: nix: Remove redundant BPID setup from
 block init
Message-ID: <202609160743.DeZuvi8V-lkp@intel.com>
References: <20260915072029.975824-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915072029.975824-1-rkannoth@marvell.com>

Hi Ratheesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ratheesh-Kannoth/octeontx2-af-nix-Remove-redundant-BPID-setup-from-block-init/20260915-125029
base:   net/main
patch link:    https://lore.kernel.org/r/20260915072029.975824-1-rkannoth%40marvell.com
patch subject: [PATCH net] octeontx2-af: nix: Remove redundant BPID setup from block init
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260916/202609160743.DeZuvi8V-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260916/202609160743.DeZuvi8V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609160743.DeZuvi8V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:516:12: warning: 'nix_setup_bpids' defined but not used [-Wunused-function]
     516 | static int nix_setup_bpids(struct rvu *rvu, struct nix_hw *hw, int blkaddr)
         |            ^~~~~~~~~~~~~~~


vim +/nix_setup_bpids +516 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

4b05528ebf0c3f Sunil Goutham   2018-10-22  513  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  514  #define NIX_BPIDS_PER_LMAC	8
d6212d2e41a0cb Geetha sowjanya 2024-01-31  515  #define NIX_BPIDS_PER_CPT	1
d6212d2e41a0cb Geetha sowjanya 2024-01-31 @516  static int nix_setup_bpids(struct rvu *rvu, struct nix_hw *hw, int blkaddr)
d6212d2e41a0cb Geetha sowjanya 2024-01-31  517  {
d6212d2e41a0cb Geetha sowjanya 2024-01-31  518  	struct nix_bp *bp = &hw->bp;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  519  	int err, max_bpids;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  520  	u64 cfg;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  521  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  522  	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST1);
d6212d2e41a0cb Geetha sowjanya 2024-01-31  523  	max_bpids =  FIELD_GET(NIX_CONST_MAX_BPIDS, cfg);
d6212d2e41a0cb Geetha sowjanya 2024-01-31  524  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  525  	/* Reserve the BPIds for CGX and SDP */
d6212d2e41a0cb Geetha sowjanya 2024-01-31  526  	bp->cgx_bpid_cnt = rvu->hw->cgx_links * NIX_BPIDS_PER_LMAC;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  527  	bp->sdp_bpid_cnt = rvu->hw->sdp_links * FIELD_GET(NIX_CONST_SDP_CHANS, cfg);
d6212d2e41a0cb Geetha sowjanya 2024-01-31  528  	bp->free_pool_base = bp->cgx_bpid_cnt + bp->sdp_bpid_cnt +
d6212d2e41a0cb Geetha sowjanya 2024-01-31  529  			     NIX_BPIDS_PER_CPT;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  530  	bp->bpids.max = max_bpids - bp->free_pool_base;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  531  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  532  	err = rvu_alloc_bitmap(&bp->bpids);
d6212d2e41a0cb Geetha sowjanya 2024-01-31  533  	if (err)
d6212d2e41a0cb Geetha sowjanya 2024-01-31  534  		return err;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  535  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  536  	bp->fn_map = devm_kcalloc(rvu->dev, bp->bpids.max,
d6212d2e41a0cb Geetha sowjanya 2024-01-31  537  				  sizeof(u16), GFP_KERNEL);
d6212d2e41a0cb Geetha sowjanya 2024-01-31  538  	if (!bp->fn_map)
36323f54cd3231 Haoxiang Li     2026-06-23  539  		goto free_bpids;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  540  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  541  	bp->intf_map = devm_kcalloc(rvu->dev, bp->bpids.max,
d6212d2e41a0cb Geetha sowjanya 2024-01-31  542  				    sizeof(u8), GFP_KERNEL);
d6212d2e41a0cb Geetha sowjanya 2024-01-31  543  	if (!bp->intf_map)
36323f54cd3231 Haoxiang Li     2026-06-23  544  		goto free_bpids;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  545  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  546  	bp->ref_cnt = devm_kcalloc(rvu->dev, bp->bpids.max,
d6212d2e41a0cb Geetha sowjanya 2024-01-31  547  				   sizeof(u8), GFP_KERNEL);
d6212d2e41a0cb Geetha sowjanya 2024-01-31  548  	if (!bp->ref_cnt)
36323f54cd3231 Haoxiang Li     2026-06-23  549  		goto free_bpids;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  550  
d6212d2e41a0cb Geetha sowjanya 2024-01-31  551  	return 0;
36323f54cd3231 Haoxiang Li     2026-06-23  552  
36323f54cd3231 Haoxiang Li     2026-06-23  553  free_bpids:
36323f54cd3231 Haoxiang Li     2026-06-23  554  	rvu_free_bitmap(&bp->bpids);
36323f54cd3231 Haoxiang Li     2026-06-23  555  	bp->bpids.bmap = NULL;
36323f54cd3231 Haoxiang Li     2026-06-23  556  	return -ENOMEM;
d6212d2e41a0cb Geetha sowjanya 2024-01-31  557  }
d6212d2e41a0cb Geetha sowjanya 2024-01-31  558  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
