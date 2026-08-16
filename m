Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF852E737D;
	Sun, 16 Aug 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786907669; cv=none; b=m3wiJ6aT3WQaNW7GElb3WhP65cqnCSM1U9NK/8EvzfvFTtk2NgzcuF/YSvlxBzESx2nDmq3+AQD940AWZV8pHjCazalE/2FL8quX0mdrneyuwayRWzFJ5lTImpDmhrCtP7jqagtT+Lzr01hVFjK7FKpWpWLsrhb9/C/lVRdj2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786907669; c=relaxed/simple;
	bh=KsoGZUWwqWT7YxWEX2EGvAYCxlN98u9/J74PvkCj4g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J95UB4QsvPu/p/nOgFk8iHMz+ykRTRHRK2VLrEfODXhs4t5vXrMG5j83PI8fhUv+jmcomfZ/U9TeuvtIKoP/gTDNYDMsMsVFt8rhccDBF5T1xad+ofw0b9K41uFTbqCE7emJNa/AYKXiejm1CmUSVimh0y9GgpgdxVQewcrA8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOF8AaVc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOF8AaVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786907666; x=1818443666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KsoGZUWwqWT7YxWEX2EGvAYCxlN98u9/J74PvkCj4g4=;
  b=WOF8AaVcunXVga99cZ4nHYRUKhFw7uVtSvsN9+FxsQp+ReBI1FBfPVYm
   nBDQuEUxevK3n05QSNVjxDnPJiQWKVd316gZ6PK4ldc/pAMDarSz5g4kU
   rGx3dUFMcs02MI5qyQzCS13mBdtZmbNCAb4L4ARyW1mdyMtejtOsQN5gt
   4+pyiKi7XsX+q/YM9GW80zW3Ah+fBdawOmXP1HMm5JCz2Px8Ogb25jnIj
   hECrFJ5iFSgcg2Q+H7v0Fhnnff7xTWiP53LseYO0QIlpL20LUb+9CECv8
   1uBLlcmRkJPlLPhB01cW3nQBRDQVDvINnqTfCWUe9qv8QGba1VGzouSyg
   g==;
X-CSE-ConnectionGUID: 7rwy5vB5S5Kju8beEL34tQ==
X-CSE-MsgGUID: GGr/O7O2Sj+Lvha8ePEkpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91265526"
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="91265526"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 12:14:25 -0700
X-CSE-ConnectionGUID: z7WCAQKFTdCAL0hVgqTwrw==
X-CSE-MsgGUID: 8zAWAEm1Qt20UC2728YQQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="269920232"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Aug 2026 12:14:22 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvgJH-00000000d4E-2WbN;
	Sun, 16 Aug 2026 19:14:19 +0000
Date: Mon, 17 Aug 2026 03:14:12 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Manish Chopra <manishc@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rahul Verma <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netxen: validate unified ROM directory bounds
Message-ID: <202608170305.r8VtBUCF-lkp@intel.com>
References: <20260706093702.81687-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706093702.81687-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/netxen-validate-unified-ROM-directory-bounds/20260813-084956
base:   linus/master
patch link:    https://lore.kernel.org/r/20260706093702.81687-1-pengpeng%40iscas.ac.cn
patch subject: [PATCH] netxen: validate unified ROM directory bounds
config: csky-randconfig-r122-20260816 (https://download.01.org/0day-ci/archive/20260817/202608170305.r8VtBUCF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260817/202608170305.r8VtBUCF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608170305.r8VtBUCF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:597:23: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] entries @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:597:23: sparse:     expected unsigned int [usertype] entries
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:597:23: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:598:26: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] entry_size @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:598:26: sparse:     expected unsigned int [usertype] entry_size
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:598:26: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:599:22: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] findex @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:599:22: sparse:     expected unsigned int [usertype] findex
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:599:22: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:608:32: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] tab_type @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:608:32: sparse:     expected unsigned int [usertype] tab_type
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:608:32: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:631:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] entries @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:631:17: sparse:     expected unsigned int [usertype] entries
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:631:17: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:632:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] entry_size @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:632:20: sparse:     expected unsigned int [usertype] entry_size
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:632:20: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:633:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] findex @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:633:16: sparse:     expected unsigned int [usertype] findex
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:633:16: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:651:15: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:651:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] idx @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:651:13: sparse:     expected unsigned int [usertype] idx
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:651:13: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:658:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] entry_size @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:658:20: sparse:     expected unsigned int [usertype] entry_size
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:658:20: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:659:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] findex @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:659:16: sparse:     expected unsigned int [usertype] findex
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:659:16: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:667:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data_off @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:667:18: sparse:     expected unsigned int [usertype] data_off
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:667:18: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:668:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data_len @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:668:18: sparse:     expected unsigned int [usertype] data_len
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:668:18: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:686:15: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:686:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] idx @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:686:13: sparse:     expected unsigned int [usertype] idx
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:686:13: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:693:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] entry_size @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:693:20: sparse:     expected unsigned int [usertype] entry_size
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:693:20: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:694:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] findex @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:694:16: sparse:     expected unsigned int [usertype] findex
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:694:16: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:702:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data_off @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:702:18: sparse:     expected unsigned int [usertype] data_off
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:702:18: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:703:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] data_len @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:703:18: sparse:     expected unsigned int [usertype] data_len
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:703:18: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:726:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] entries @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:726:17: sparse:     expected unsigned int [usertype] entries
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:726:17: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:727:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] entry_size @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:727:20: sparse:     expected unsigned int [usertype] entry_size
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:727:20: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:728:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] findex @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:728:16: sparse:     expected unsigned int [usertype] findex
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:728:16: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:748:33: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:749:42: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:750:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] file_prd_off @@     got unsigned int [assigned] [usertype] offs @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:750:47: sparse:     expected restricted __le32 [usertype] file_prd_off
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:750:47: sparse:     got unsigned int [assigned] [usertype] offs
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:797:19: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:797:19: sparse: sparse: incorrect type in initializer (different base types) @@     expected int idx @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:797:19: sparse:     expected int idx
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:797:19: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:808:26: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:807:16: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:807:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] offs @@     got unsigned int @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:807:14: sparse:     expected restricted __le32 [usertype] offs
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:807:14: sparse:     got unsigned int
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:810:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:819:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offs @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:819:22: sparse:     expected unsigned int [usertype] offs
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:819:22: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:832:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offs @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:832:22: sparse:     expected unsigned int [usertype] offs
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:832:22: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:864:38: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:865:33: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:878:33: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:878:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:878:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:878:45: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __le32 @@     got unsigned int @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:878:45: sparse:     expected restricted __le32
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:878:45: sparse:     got unsigned int
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:891:28: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:893:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:893:45: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:894:58: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:893:70: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __le32 @@     got unsigned int @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:893:70: sparse:     expected restricted __le32
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:893:70: sparse:     got unsigned int
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:942:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:942:21: sparse:     expected unsigned int [usertype] val
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:942:21: sparse:     got restricted __le32
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1030:72: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] @@     got restricted __le64 [assigned] [usertype] data @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1030:72: sparse:     expected unsigned long long [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1030:72: sparse:     got restricted __le64 [assigned] [usertype] data
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1045:60: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] @@     got restricted __le64 [assigned] [usertype] data @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1045:60: sparse:     expected unsigned long long [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1045:60: sparse:     got restricted __le64 [assigned] [usertype] data
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1056:60: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] @@     got restricted __le64 [assigned] [usertype] data @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1056:60: sparse:     expected unsigned long long [usertype]
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1056:60: sparse:     got restricted __le64 [assigned] [usertype] data
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1130:23: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1130:23: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1130:23: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1154:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1154:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1154:24: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1154:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] flash_fw_ver @@     got unsigned int @@
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1154:22: sparse:     expected restricted __le32 [addressable] [usertype] flash_fw_ver
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1154:22: sparse:     got unsigned int
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1158:46: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1170:21: sparse: sparse: restricted __le32 degrades to integer

vim +597 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c

   592	
   593	static struct uni_table_desc *
   594	nx_get_table_desc(const u8 *unirom, size_t fw_size, int section)
   595	{
   596		struct uni_table_desc *directory = (struct uni_table_desc *) &unirom[0];
 > 597		u32 entries = cpu_to_le32(directory->num_entries);
 > 598		u32 entry_size = cpu_to_le32(directory->entry_size);
 > 599		u32 findex = cpu_to_le32(directory->findex);
   600		u32 i;
   601	
   602		if (entry_size < NX_UNI_DIR_ENTRY_MIN_SIZE ||
   603		    !netxen_rom_table_valid(fw_size, findex, entries, entry_size))
   604			return NULL;
   605	
   606		for (i = 0; i < entries; i++) {
   607			size_t offs = findex + (size_t)i * entry_size;
 > 608			u32 tab_type = cpu_to_le32(*((u32 *)&unirom[offs] +
   609							NX_UNI_DIR_TYPE_OFF));
   610	
   611			if (tab_type == section)
   612				return (struct uni_table_desc *)&unirom[offs];
   613		}
   614	
   615		return NULL;
   616	}
   617	
   618	#define	QLCNIC_FILEHEADER_SIZE	(14 * 4)
   619	
   620	static int
   621	netxen_nic_validate_header(struct netxen_adapter *adapter)
   622	{
   623		const u8 *unirom = adapter->fw->data;
   624		struct uni_table_desc *directory = (struct uni_table_desc *)&unirom[0];
   625		u32 fw_file_size = adapter->fw->size;
   626		u32 entries, entry_size, findex;
   627	
   628		if (fw_file_size < QLCNIC_FILEHEADER_SIZE)
   629			return -EINVAL;
   630	
 > 631		entries = cpu_to_le32(directory->num_entries);
 > 632		entry_size = cpu_to_le32(directory->entry_size);
 > 633		findex = cpu_to_le32(directory->findex);
   634	
   635		if (!netxen_rom_table_valid(fw_file_size, findex, entries, entry_size))
   636			return -EINVAL;
   637	
   638		return 0;
   639	}
   640	
   641	static int
   642	netxen_nic_validate_bootld(struct netxen_adapter *adapter)
   643	{
   644		struct uni_table_desc *tab_desc;
   645		struct uni_data_desc *descr;
   646		const u8 *unirom = adapter->fw->data;
   647		u32 data_len, data_off, entry_size, findex, idx;
   648		u32 section = NX_UNI_DIR_SECT_BOOTLD;
   649		size_t offs;
   650	
 > 651		idx = cpu_to_le32(*((int *)&unirom[adapter->file_prd_off] +
   652				     NX_UNI_BOOTLD_IDX_OFF));
   653		tab_desc = nx_get_table_desc(unirom, adapter->fw->size, section);
   654	
   655		if (!tab_desc)
   656			return -EINVAL;
   657	
   658		entry_size = cpu_to_le32(tab_desc->entry_size);
   659		findex = cpu_to_le32(tab_desc->findex);
   660		if (entry_size < sizeof(*descr) ||
   661		    !netxen_rom_entry_valid(adapter->fw->size, findex, entry_size,
   662					     idx))
   663			return -EINVAL;
   664	
   665		offs = findex + (size_t)entry_size * idx;
   666		descr = (struct uni_data_desc *)&unirom[offs];
 > 667		data_off = cpu_to_le32(descr->findex);
 > 668		data_len = cpu_to_le32(descr->size);
   669	
   670		if (!netxen_rom_range_valid(adapter->fw->size, data_off, data_len))
   671			return -EINVAL;
   672	
   673		return 0;
   674	}
   675	
   676	static int
   677	netxen_nic_validate_fw(struct netxen_adapter *adapter)
   678	{
   679		struct uni_table_desc *tab_desc;
   680		struct uni_data_desc *descr;
   681		const u8 *unirom = adapter->fw->data;
   682		u32 data_len, data_off, entry_size, findex, idx;
   683		u32 section = NX_UNI_DIR_SECT_FW;
   684		size_t offs;
   685	
   686		idx = cpu_to_le32(*((int *)&unirom[adapter->file_prd_off] +
   687				     NX_UNI_FIRMWARE_IDX_OFF));
   688		tab_desc = nx_get_table_desc(unirom, adapter->fw->size, section);
   689	
   690		if (!tab_desc)
   691			return -EINVAL;
   692	
   693		entry_size = cpu_to_le32(tab_desc->entry_size);
   694		findex = cpu_to_le32(tab_desc->findex);
   695		if (entry_size < sizeof(*descr) ||
   696		    !netxen_rom_entry_valid(adapter->fw->size, findex, entry_size,
   697					     idx))
   698			return -EINVAL;
   699	
   700		offs = findex + (size_t)entry_size * idx;
   701		descr = (struct uni_data_desc *)&unirom[offs];
   702		data_off = cpu_to_le32(descr->findex);
   703		data_len = cpu_to_le32(descr->size);
   704	
   705		if (!netxen_rom_range_valid(adapter->fw->size, data_off, data_len))
   706			return -EINVAL;
   707	
   708		return 0;
   709	}
   710	
   711	
   712	static int
   713	netxen_nic_validate_product_offs(struct netxen_adapter *adapter)
   714	{
   715		struct uni_table_desc *ptab_descr;
   716		const u8 *unirom = adapter->fw->data;
   717		int mn_present = (NX_IS_REVISION_P2(adapter->ahw.revision_id)) ?
   718				1 : netxen_p3_has_mn(adapter);
   719		u32 entries, entry_size, findex, i;
   720		u32 section = NX_UNI_DIR_SECT_PRODUCT_TBL;
   721	
   722		ptab_descr = nx_get_table_desc(unirom, adapter->fw->size, section);
   723		if (ptab_descr == NULL)
   724			return -EINVAL;
   725	
   726		entries = cpu_to_le32(ptab_descr->num_entries);
   727		entry_size = cpu_to_le32(ptab_descr->entry_size);
   728		findex = cpu_to_le32(ptab_descr->findex);
   729		if (entry_size < NX_UNI_PRODUCT_ENTRY_MIN_SIZE ||
   730		    !netxen_rom_table_valid(adapter->fw->size, findex, entries,
   731					     entry_size))
   732			return -EINVAL;
   733	
   734	nomn:
   735		for (i = 0; i < entries; i++) {
   736			size_t offs;
   737			__le32 flags, file_chiprev;
   738			u8 chiprev = adapter->ahw.revision_id;
   739			uint32_t flagbit;
   740	
   741			offs = findex + (size_t)i * entry_size;
   742			flags = cpu_to_le32(*((int *)&unirom[offs] + NX_UNI_FLAGS_OFF));
   743			file_chiprev = cpu_to_le32(*((int *)&unirom[offs] +
   744							    NX_UNI_CHIP_REV_OFF));
   745	
   746			flagbit = mn_present ? 1 : 2;
   747	
   748			if ((chiprev == file_chiprev) &&
   749			    ((1ULL << flagbit) & flags)) {
 > 750				adapter->file_prd_off = offs;
   751				return 0;
   752			}
   753		}
   754	
   755		if (mn_present && NX_IS_REVISION_P3(adapter->ahw.revision_id)) {
   756			mn_present = 0;
   757			goto nomn;
   758		}
   759	
   760		return -EINVAL;
   761	}
   762	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
