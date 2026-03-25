Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAD39A814
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433675; cv=none; b=Z3x8NnAsZTTdExhExvuMDAJiEhj0XyBlewMjyXBnqMwX5mFp9a+wXFEhjIhrgJPDFHkX5FVN9qIy15nDAQLfe8oc4CtbNWEWx8nDh3T9bVaGRCC6oTwqeBlVVLn7lWDTR2s46F5J8vTq0hmpqIGhzrpL5NgvgUjiCBKD7os2YsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433675; c=relaxed/simple;
	bh=1HQunXwctl1ifAye9q05SCcLeZKJxhkVVazF3cGdS/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvn1ZhRifG0UzR2/wNKuFzFLa3r7BeClL55DDgEsdNYUJvVFmNQFHsfSBiW1rgMaWAxsa1iOkZ6bt2G/asm36KFuHUk22A1DqOIZZUPSZQhzrHAEOR69AhS42Dze86E67eL5T2pZ4GQFOj399+Mibklhrgehfmyo9R6CtTb426Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jhn0uOGz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jhn0uOGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774433671; x=1805969671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1HQunXwctl1ifAye9q05SCcLeZKJxhkVVazF3cGdS/A=;
  b=Jhn0uOGzUaHGjbL3dsPYvBFat5WPaP5GtG6JM3mk2HzWCqwtkx0uVuN8
   +gZCip4tye5Dal3FcNfibARo0K8K3X5AJA7rdIe6JqscA1Ekldw/sOgAG
   fqndgaf32R7UfWPKyyKwlI/FtF6JpAF1Y9x1dx+4Yw83E3TKX9ixMPX0p
   kz2baqdGEjYRZrIR1ae49GZpw6wooN/TzDeaVMQp/c9+goi5EtRhnwWc9
   kvcxomp59pkXQwnWr1ejlcgA+mrXo1Us17R9K0n/NXUcdOAVa8p9rJ+a5
   AI6By/NrdOO8zzzB5QNCahPyR1GPQl6EQD8hj/h2VL/sLa05rn2PiQiWj
   A==;
X-CSE-ConnectionGUID: uCkaTkXrTSafzVVbJFs3Eg==
X-CSE-MsgGUID: xHMCnF//TpaRLLnHRezvvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79062176"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79062176"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 03:14:31 -0700
X-CSE-ConnectionGUID: FvRNbSgoTFKR59qMuZurBg==
X-CSE-MsgGUID: MkgIVVB9TSK+pj5/yK7LWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224645513"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 25 Mar 2026 03:14:30 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5LFr-0000000074P-2A6z;
	Wed, 25 Mar 2026 10:14:27 +0000
Date: Wed, 25 Mar 2026 11:14:09 +0100
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next] devlink: unify
 devlink_shd_get_priv() into devlink_priv()
Message-ID: <202603251148.Sjx5pVxc-lkp@intel.com>
References: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323132136.13191-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/devlink-unify-devlink_shd_get_priv-into-devlink_priv/20260325-130848
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260323132136.13191-1-przemyslaw.kitszel%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next] devlink: unify devlink_shd_get_priv() into devlink_priv()
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260325/202603251148.Sjx5pVxc-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603251148.Sjx5pVxc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251148.Sjx5pVxc-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/devlink/sh_dev.c: In function 'devlink_to_shd':
>> net/devlink/sh_dev.c:36:16: error: returning 'char (*)[]' from a function with incompatible return type 'struct devlink_shd *' [-Wincompatible-pointer-types]
      36 |         return &devlink->priv;
         |                ^~~~~~~~~~~~~~


vim +36 net/devlink/sh_dev.c

    33	
    34	static struct devlink_shd *devlink_to_shd(struct devlink *devlink)
    35	{
  > 36		return &devlink->priv;
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
