Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665754793
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628589; cv=none; b=u6Eo3QXhSHZIWTuZULgGPPJ2i4XrN7SrVxqNkd8ClDJs7TQcMzo4PZlOpypHi59kSxswIQQMlMNIHcfscyhvJbWihG1HQ+YOakQtYThv5Gsrb4D30sv2upTjbrTWlyv1oua+E5dOY4e7WtBbCy78qghtP1Qh6Uca1gUCbelubrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628589; c=relaxed/simple;
	bh=Ki0Q35d6eYa016/cHUOaW/nm1p1rCufECKjtLWEVWJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0dp9ltSdJdEjXQtQlopWVtZmgln8tAdwV0PklC0qoyn1uY8xfNrCJkQ70MRr5ScoWFPnrBBIT/JW0mbPUNfOWclWpSsQI0x+xiVqdeQNuWgh3Pn/+GkyeTlJdIWsoR8F5j1V5BT841RiUcST3dCcXNoymwADLEZaETLyWXkAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2wFiNCj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2wFiNCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791628588; x=1823164588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ki0Q35d6eYa016/cHUOaW/nm1p1rCufECKjtLWEVWJ8=;
  b=V2wFiNCjIjRRbv4wPp1SDVQcJw33RGcxpZP60lpYyQzu51+PpYdDrLeQ
   itVf0JNXuHXmLNcYQe9CFBYXDxQzS0HmBIMoAvPCm0opk3Na4bJpTh06E
   5QxgJ1TW6B5virDq4vzbqLC10YeqWlopu7tJHvVMbZsSzAU5hN+0z7kvi
   OjWvClrpDfN+0Vdl+KOBZQsNHc9esVkqtwC0ZT0AauyahPAqMkMTLWvdz
   lfTmdxAHWo9eGwK+NhzB9c77i6Hsid7bR3DAkG4QhxPsYo4fYtzvIi85z
   9Un2W3a48Icb1Xjb9EcPofUZCOfujAJcmNsPrdiV5BTY54K0jvgEa9Xuv
   A==;
X-CSE-ConnectionGUID: wMXtcJSsQIyM8OVpsDjZmw==
X-CSE-MsgGUID: LQZC1jdbQ0aIcukbY728+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="302373"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="302373"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 03:36:27 -0700
X-CSE-ConnectionGUID: VQ1V6L+/TkWhHgQSokTcKw==
X-CSE-MsgGUID: k7tE2lfKR9SKoxFR/wJkXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="969819"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Oct 2026 03:36:26 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFURD-000000009ZT-3Z53;
	Sat, 10 Oct 2026 10:36:23 +0000
Date: Sat, 10 Oct 2026 18:35:58 +0800
From: kernel test robot <lkp@intel.com>
To: Wong Boon Jhee <wongboonjhee52@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, kuba@kernel.org,
	Wong Boon Jhee <wongboonjhee52@gmail.com>
Subject: Re: [PATCH v9] net/ncsi: Fix use-after-free in NCSI teardown
Message-ID: <202610101826.cLJcdod0-lkp@intel.com>
References: <20261009082201.1424955-1-wongboonjhee52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009082201.1424955-1-wongboonjhee52@gmail.com>

Hi Wong,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master v7.3-rc6 next-20261009]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wong-Boon-Jhee/net-ncsi-Fix-use-after-free-in-NCSI-teardown/20261009-162201
base:   net/main
patch link:    https://lore.kernel.org/r/20261009082201.1424955-1-wongboonjhee52%40gmail.com
patch subject: [PATCH v9] net/ncsi: Fix use-after-free in NCSI teardown
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20261010/202610101826.cLJcdod0-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610101826.cLJcdod0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610101826.cLJcdod0-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ncsi/ncsi-manage.c: In function 'ncsi_unregister_dev':
>> net/ncsi/ncsi-manage.c:2101:61: error: 'nc' undeclared (first use in this function); did you mean 'nr'?
    2101 |                                                       &np, &nc);
         |                                                             ^~
         |                                                             nr
   net/ncsi/ncsi-manage.c:2101:61: note: each undeclared identifier is reported only once for each function it appears in
   net/ncsi/ncsi-manage.c:2084:23: warning: unused variable 'flags' [-Wunused-variable]
    2084 |         unsigned long flags;
         |                       ^~~~~


vim +2101 net/ncsi/ncsi-manage.c

  2078	
  2079	void ncsi_unregister_dev(struct ncsi_dev *nd)
  2080	{
  2081		struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
  2082		struct ncsi_package *np, *tmp;
  2083		struct vlan_vid *vlan, *vlan_tmp;
  2084		unsigned long flags;
  2085		int i;
  2086	
  2087		ncsi_unregister_dev_prepare(nd);
  2088		for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
  2089			struct ncsi_request *nr = &ndp->requests[i];
  2090	
  2091			if (!nr->used)
  2092				continue;
  2093	
  2094			if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN && nr->cmd) {
  2095				struct ncsi_cmd_pkt *cmd = (struct ncsi_cmd_pkt *)
  2096					skb_network_header(nr->cmd);
  2097	
  2098				rcu_read_lock();
  2099				ncsi_find_package_and_channel(ndp,
  2100							      cmd->cmd.common.channel,
> 2101							      &np, &nc);

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
