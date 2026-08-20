Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920FB3D45EA
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213604; cv=none; b=qw3zs+iumiFqjb6gSRHhDlIY3MXivC1HOO6WDUH4eoSix79jF0aAFFo018wqF7dClcrSUqmBexB0df8QU5Frv1n8u1KPX0OTwv+yIucf9XtxzsENNZgp3tZA17k7Fde/CC20pKgDSJaxx3wZkrIWFp62ypWwc6JGp/ie60HzhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213604; c=relaxed/simple;
	bh=L0l3/NPI3XmylUki0M92R+bbLp0LGOe7pArLvSqRzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNflJmF3ZR+z8MyR137G+ojVOJHng370B2RKSPQ5ocDP1xhOf6WIkgRjAOa9I+iPxCnh4P7BlKkpKmUZXT/qP4f5tocat0DiO38jIm+dOSfcVbozoRBRA9Jqqvc9fobAjdbjeM9+EUGwMvXQiLI8GLxTtwAoctfVWP3v9zZqdvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWlqhwTP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWlqhwTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787213602; x=1818749602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L0l3/NPI3XmylUki0M92R+bbLp0LGOe7pArLvSqRzDg=;
  b=RWlqhwTP9LeCMoqQ0mJe9e5+4YTLB1gfwIIyrNu7iGu7Ejj5pSIrPJXy
   MvYDWRAjRGmy8i2ntRWAhM9bgY4XcULVGQv1RmVOr+AV/bGtKdlw51lAP
   4tf5nLLUjn5u3o3i669zENR5fIf255fAoIn443ZJMB6lAm7TDLtECcaK5
   ATrz2EBErQaRpPGHt7S4GVscEBSiSlu6i7d49GXukVvK6ZXg+jSEgo3uw
   uM6eFsdfRe75kCxAeQPZKwkHIJ6ABFVRe3dIwgu6Wl8xjjtpiuILaScLs
   bFe1aXhTxJ57x41v/ufw77/ZO757rPn569bEdVmKAWjqvfcWka+DlYgqq
   g==;
X-CSE-ConnectionGUID: VDNlZE03QQqNeoRUnHr1uQ==
X-CSE-MsgGUID: zywYfQRbRemD8W9+zpJIpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="110528064"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="110528064"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 01:13:22 -0700
X-CSE-ConnectionGUID: k+D1crMcToyoPAL7p6HSzg==
X-CSE-MsgGUID: 3v/Gl3rCT2us0j3ENjKLZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="270167176"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 01:13:18 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwxtj-00000000iKn-3HQ9;
	Thu, 20 Aug 2026 08:13:15 +0000
Date: Thu, 20 Aug 2026 16:12:18 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com,
	James Chapman <jchapman@katalix.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on
 seq_file release
Message-ID: <202608201604.4Zj72hcA-lkp@intel.com>
References: <20260810141125.1176545-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810141125.1176545-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on horms-ipvs/master]
[cannot apply to net/main net-next/main linus/master v7.2 next-20260819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/l2tp-fix-tunnel-and-session-refcount-leak-on-seq_file-release/20260810-141125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
patch link:    https://lore.kernel.org/r/20260810141125.1176545-1-edumazet%40google.com
patch subject: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on seq_file release
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201604.4Zj72hcA-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201604.4Zj72hcA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201604.4Zj72hcA-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/l2tp/l2tp_ppp.c: In function 'pppol2tp_proc_release':
>> net/l2tp/l2tp_ppp.c:1641:17: error: implicit declaration of function 'l2tp_session_put'; did you mean 'l2tp_session_get'? [-Wimplicit-function-declaration]
    1641 |                 l2tp_session_put(pd->session);
         |                 ^~~~~~~~~~~~~~~~
         |                 l2tp_session_get
>> net/l2tp/l2tp_ppp.c:1643:17: error: implicit declaration of function 'l2tp_tunnel_put'; did you mean 'l2tp_tunnel_get'? [-Wimplicit-function-declaration]
    1643 |                 l2tp_tunnel_put(pd->tunnel);
         |                 ^~~~~~~~~~~~~~~
         |                 l2tp_tunnel_get
--
   net/l2tp/l2tp_debugfs.c: In function 'l2tp_dfs_seq_release':
>> net/l2tp/l2tp_debugfs.c:311:17: error: implicit declaration of function 'l2tp_session_put'; did you mean 'l2tp_session_get'? [-Wimplicit-function-declaration]
     311 |                 l2tp_session_put(pd->session);
         |                 ^~~~~~~~~~~~~~~~
         |                 l2tp_session_get
>> net/l2tp/l2tp_debugfs.c:313:17: error: implicit declaration of function 'l2tp_tunnel_put'; did you mean 'l2tp_tunnel_get'? [-Wimplicit-function-declaration]
     313 |                 l2tp_tunnel_put(pd->tunnel);
         |                 ^~~~~~~~~~~~~~~
         |                 l2tp_tunnel_get


vim +1641 net/l2tp/l2tp_ppp.c

  1634	
  1635	static int pppol2tp_proc_release(struct inode *inode, struct file *file)
  1636	{
  1637		struct seq_file *seq = file->private_data;
  1638		struct pppol2tp_seq_data *pd = seq->private;
  1639	
  1640		if (pd->session)
> 1641			l2tp_session_put(pd->session);
  1642		if (pd->tunnel)
> 1643			l2tp_tunnel_put(pd->tunnel);
  1644	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
