Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2112F1F94F
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591162; cv=none; b=jKU9+x6t+Sh+PKN737RNlKs+l4DANzXBXzgg1TcbOBpkbeKKutVsSmowQDctyd76QGOoV+waVXrT/JlpBW8wFb6R7FahGg6OiPriRa1tcHAXcrA+JxkySbR2Ff906dvi8yKyyE16hh/vsaVkSHJ6QceVNJLX3QtNcEz2rlIzUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591162; c=relaxed/simple;
	bh=1Ay9bN2eGeWUpHZsJ2AYo8jafOcl8zrShs1l3EUrEE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyAD/gCN4mcw++OdIc8xwEt/L3kpjm8ZYL0Cwg+0qcRDnNb9SbbIjcq/NZBrDdPItKppw6XxTgY2PHroSbA2si04NpGB6yTMlh0CNitbyzwueaPD/0+7xdxjA5I/mVdsAxtZLEiY5WmMYaGh2g+WHMW7chvF/maLw/8jlwgyw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8hCaN6V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8hCaN6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791591161; x=1823127161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Ay9bN2eGeWUpHZsJ2AYo8jafOcl8zrShs1l3EUrEE0=;
  b=i8hCaN6VZKrqg6VcWttxSnoK1rReJCLrz+GysGmqCZpTSBkFM4XbF/6Z
   XhiLJeiG6fCWJDyZpwl6HKjXia6tV8u6JrEKVtZc7UliZpXcWFJqSQPxT
   jPXpLEFdp42S+6A99Uz3NUcDFeypBo6S/0iL0ZvJ7yLO557XeV2zTYXqi
   wvXdkPG4o+ZWYlO/6hvsWB7PFpismPRBs3rleGPB7noyyG00kJ90fc+RY
   U/At9Plh1xuZ0dpARlPR97iObqLuA2z2azdId+kYmJyM3dX3ff/yqbJNE
   yELXiyg9w4tLFFm0C0ECt8RSIoqJy1Oy9KR512ePSF/iJh6sZpEv3Fh2L
   w==;
X-CSE-ConnectionGUID: iSGwfsB0TyOOi3ux8HGWMw==
X-CSE-MsgGUID: 4RxY3CptS0GqSwXjjtYeDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="284074"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="284074"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 17:12:40 -0700
X-CSE-ConnectionGUID: 4Vg5DPiuSQaBNImMGjKKmA==
X-CSE-MsgGUID: FM/fDYzmT6WuED4Lfm5WYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="529746"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Oct 2026 17:12:38 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFKhX-000000006KK-2sl6;
	Sat, 10 Oct 2026 00:12:35 +0000
Date: Sat, 10 Oct 2026 08:11:55 +0800
From: kernel test robot <lkp@intel.com>
To: Wong Boon Jhee <wongboonjhee52@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	kuba@kernel.org, Wong Boon Jhee <wongboonjhee52@gmail.com>
Subject: Re: [PATCH v9] net/ncsi: Fix use-after-free in NCSI teardown
Message-ID: <202610100859.YrkmZvhQ-lkp@intel.com>
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
[also build test ERROR on net-next/main linus/master v7.3-rc6 next-20261008]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wong-Boon-Jhee/net-ncsi-Fix-use-after-free-in-NCSI-teardown/20261009-162201
base:   net/main
patch link:    https://lore.kernel.org/r/20261009082201.1424955-1-wongboonjhee52%40gmail.com
patch subject: [PATCH v9] net/ncsi: Fix use-after-free in NCSI teardown
config: i386-buildonly-randconfig-1005-20261010 (https://download.01.org/0day-ci/archive/20261010/202610100859.YrkmZvhQ-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100859.YrkmZvhQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100859.YrkmZvhQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ncsi/ncsi-manage.c:2101:19: error: use of undeclared identifier 'nc'
    2101 |                                                       &np, &nc);
         |                                                             ^~
   net/ncsi/ncsi-manage.c:2103:38: error: use of undeclared identifier 'nc'
    2103 |                         ncsi_send_netlink_timeout(nr, np, nc);
         |                                                           ^~
   2 errors generated.


vim +/nc +2101 net/ncsi/ncsi-manage.c

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
