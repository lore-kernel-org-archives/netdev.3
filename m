Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2109356750;
	Thu,  3 Sep 2026 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405598; cv=none; b=XHYBaIyATMZxekiRHUzPg5BYu3VDdNwF8usWB2EXxZcYntH/ALudkOgLuG+lbeGO91tBswVFrZzJMrSafrk/KRVCSCZTiX4bdy1DXwIs07kmDad7NQHVQHE8XrsGdHdk8aczrbQJF1KVxIF2SN9rzg+mE1xXB5p5CtAPXEcOvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405598; c=relaxed/simple;
	bh=an5WckqkIBA/iQ5kZlliwGW/9g1NNpIWv8H3kmGS2ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQzQ21G+3c9fWSc1dflK7BSJ2+WsXlSahTMh/L2c+yRw+ZMqlLax0Vdi//xwbvUPyY2pfPn/tc8iuak+55YFAKxhsDTTn5TxOvUrMKpHIvf0YYhS88ANIxDG9Txy5x73Fq3bposSJxB7NpctXUFysecDf/JI264y2rIkmP5MzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MykM1RHs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MykM1RHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788405596; x=1819941596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=an5WckqkIBA/iQ5kZlliwGW/9g1NNpIWv8H3kmGS2ps=;
  b=MykM1RHshWAD1Nmu7QMSxktzgyUNexqgmfl7pHTgxCfp4PukUnB8XGMA
   XfnrrrtTvmh3zpQgiYG8yHzwE26fUJWsx3LHqZv8fycGT5XAWslTPc2rC
   5VhPPncEbXR4w1duHeNb5/oBrHV+YlO7TTGUi+NgCHLKNyOwGEsihRYAk
   0R+G63lxy/1swwZmA54MrER6Es2OsNUkAc6k2/VEBdJw5BSbDnGlo2IAM
   5CZ7PnId3vq5C/Y3h4iM2niZVdXUCbKj9T74BBQ88j91icOHKqbgrL3k0
   2szF8rgYa4pj00ACo1PFZTpO6PqcChzmSmznOYeArXvzYp1Vk7alV6X0z
   A==;
X-CSE-ConnectionGUID: hFrZ7Gy1QYaLG9+H9yZ4xQ==
X-CSE-MsgGUID: lOOApXqVR76HhW26Qsu0Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92693526"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92693526"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 20:18:46 -0700
X-CSE-ConnectionGUID: y85AdINqR22MuHFX2PnCcA==
X-CSE-MsgGUID: eDDzPY2lRI6kIPwxz0gBkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="263423773"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Sep 2026 20:18:42 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1xyJ-000000003tu-3Yow;
	Thu, 03 Sep 2026 03:18:39 +0000
Date: Thu, 3 Sep 2026 11:18:27 +0800
From: kernel test robot <lkp@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, davem@davemloft.net,
	gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com
Cc: oe-kbuild-all@lists.linux.dev, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH v3 net] octeontx2-af: allocate qmem from page allocator
 to avoid CMA
Message-ID: <202609031155.NJcvrcuy-lkp@intel.com>
References: <20260827070554.3919891-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827070554.3919891-1-rkannoth@marvell.com>

Hi Ratheesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ratheesh-Kannoth/octeontx2-af-allocate-qmem-from-page-allocator-to-avoid-CMA/20260827-123553
base:   net/main
patch link:    https://lore.kernel.org/r/20260827070554.3919891-1-rkannoth%40marvell.com
patch subject: [PATCH v3 net] octeontx2-af: allocate qmem from page allocator to avoid CMA
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260903/202609031155.NJcvrcuy-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260903/202609031155.NJcvrcuy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609031155.NJcvrcuy-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/net/ethernet/marvell/octeontx2/af/rvu_af.ko: symbol 'dma_coherent_ok' undefined!
>> ERROR: modpost: drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicpf.ko: symbol 'dma_coherent_ok' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
