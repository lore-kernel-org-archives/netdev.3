Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832983F5BC5;
	Wed,  5 Aug 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971464; cv=none; b=r5wLJQ4xb0hyIo5mKrzfMQXpVF5X1oGKef+zlPByeNUQ56U8LXnV0StVsRN8Qv5eO+B1ishRyn25SfaDYs3dh+b9HyWqj7o3R3OarOsnPBAeAXOz4IcfT47f9UeyMARCjMjzqxS3qsO8UfkA/QTFjrDo/aRKFQmHEL+5lOX2IZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971464; c=relaxed/simple;
	bh=uYzNSLJGSdyb5yvUy/AY7ZteAKWQVS6i1sP1EiovRh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtHgy8u5sICjRl1/c34hFj4b09PKi0cII8NOyhGy9/zHarZHkxm7LJswf89oYycJphsB88wXV/zwcH8a49wTkQphLRLZlW23vYKLGagrkySS4gydGpfT5czQ5woyF6hAcyxPxYx0TdJ8MZCwWd6qM/jyg26ARU5jkyb2bQIjyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hE5Vn+L7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hE5Vn+L7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785971461; x=1817507461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYzNSLJGSdyb5yvUy/AY7ZteAKWQVS6i1sP1EiovRh0=;
  b=hE5Vn+L7vUXAe+ENAlGM7fHJAcRI5A9bt7mFYBI8bVQfoy/JP7q5tEW0
   qc9YD+RDJT9o6nh+gsl7lOZB6K3CL0iqW+Fr0hqyIEAv4Q+nu7LFiReOq
   ZJwxp9VYlPny1q0r5sh3nGSeT1Sqh/d7C6A3gkvisizlFX/RFnbNl8v65
   9PcYMqxh+1DCS9O7CHo3PzwSvbVV8ZtJH4r9hH4CDhP+VtFcECfn4QdBq
   J63UAdb+G/KpqnUjZYKxUyxNQkbgTKnv5uDAp2Egv/nL9NBdqG5OMCufN
   zEDXNv4cgKGfr1EQKryyW82yIZuDYga69GAKeApqJDwyOthCqYgPruzLL
   w==;
X-CSE-ConnectionGUID: ThWZaJaJSZ+ZSF1mlQ5wtg==
X-CSE-MsgGUID: LMqjig2XQh6Jy/Gj7ovBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90376918"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="90376918"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 16:10:55 -0700
X-CSE-ConnectionGUID: eyE7IjR7TS2Tn3OodI3uww==
X-CSE-MsgGUID: p8Z6mGeETRytpSFJssjV1Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Aug 2026 16:10:52 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrkl7-00000000Ddh-29rN;
	Wed, 05 Aug 2026 23:10:49 +0000
Date: Thu, 6 Aug 2026 07:10:29 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas Poupeau <lucasp.linux@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	kuniyu@google.com, sdf@fomichev.me, brauner@kernel.org,
	krikku@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: Re: [PATCH] net: sysfs: cleanup coding style
Message-ID: <202608060631.yZqGaOTZ-lkp@intel.com>
References: <20260628185824.231250-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628185824.231250-1-lucasp.linux@gmail.com>

Hi Lucas,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main brauner-vfs/vfs.all linus/master v7.2-rc6 next-20260805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Poupeau/net-sysfs-cleanup-coding-style/20260805-152318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260628185824.231250-1-lucasp.linux%40gmail.com
patch subject: [PATCH] net: sysfs: cleanup coding style
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260806/202608060631.yZqGaOTZ-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608060631.yZqGaOTZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608060631.yZqGaOTZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/net-sysfs.c:622:8: error: use of undeclared identifier 'netdev_group_show'
     622 | static DEVICE_ATTR_RW(netdev_group);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:246:45: note: expanded from macro 'DEVICE_ATTR_RW'
     246 |         struct device_attribute dev_attr_##_name = __DEVICE_ATTR_RW(_name)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:204:2: note: expanded from macro '__DEVICE_ATTR_RW'
     204 |         __DEVICE_ATTR_RW_MODE(_name, 0644)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:201:30: note: expanded from macro '__DEVICE_ATTR_RW_MODE'
     201 |         __DEVICE_ATTR(_name, _mode, _name##_show, _name##_store)
         |                                     ^~~~~~~~~~~~
   <scratch space>:22:1: note: expanded from here
      22 | netdev_group_show
         | ^~~~~~~~~~~~~~~~~
>> net/core/net-sysfs.c:622:8: error: use of undeclared identifier 'netdev_group_store'; did you mean 'netdev_lock_store'?
     622 | static DEVICE_ATTR_RW(netdev_group);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:246:45: note: expanded from macro 'DEVICE_ATTR_RW'
     246 |         struct device_attribute dev_attr_##_name = __DEVICE_ATTR_RW(_name)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:204:2: note: expanded from macro '__DEVICE_ATTR_RW'
     204 |         __DEVICE_ATTR_RW_MODE(_name, 0644)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:201:44: note: expanded from macro '__DEVICE_ATTR_RW_MODE'
     201 |         __DEVICE_ATTR(_name, _mode, _name##_show, _name##_store)
         |                                                   ^~~~~~~~~~~~~
   <scratch space>:23:1: note: expanded from here
      23 | netdev_group_store
         | ^~~~~~~~~~~~~~~~~~
   net/core/net-sysfs.c:189:1: note: 'netdev_lock_store' declared here
     189 | netdev_lock_store(struct device *dev, struct device_attribute *attr,
         | ^
   net/core/net-sysfs.c:622:8: error: use of undeclared identifier 'netdev_group_store'
     622 | static DEVICE_ATTR_RW(netdev_group);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:246:45: note: expanded from macro 'DEVICE_ATTR_RW'
     246 |         struct device_attribute dev_attr_##_name = __DEVICE_ATTR_RW(_name)
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:204:2: note: expanded from macro '__DEVICE_ATTR_RW'
     204 |         __DEVICE_ATTR_RW_MODE(_name, 0644)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:201:44: note: expanded from macro '__DEVICE_ATTR_RW_MODE'
     201 |         __DEVICE_ATTR(_name, _mode, _name##_show, _name##_store)
         |                                                   ^~~~~~~~~~~~~
   <scratch space>:23:1: note: expanded from here
      23 | netdev_group_store
         | ^~~~~~~~~~~~~~~~~~
   3 errors generated.


vim +/netdev_group_show +622 net/core/net-sysfs.c

   620	
   621	NETDEVICE_SHOW(group, fmt_dec);
 > 622	static DEVICE_ATTR_RW(netdev_group);
   623	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
