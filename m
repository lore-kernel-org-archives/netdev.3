Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687647AF6B;
	Wed,  5 Aug 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948917; cv=none; b=FDwPkpaH9hCBUbTfPImYdTDqOH601Wj6NDeXoYGpYgHdKTTr5BbPWaF60Uz0M16wosbzwW4JfIbET80K6lDaOmCV4KB4AYLUkphknfhUHbK7xbn5kMHrfVayaP6pCCdLYaru6GQMw/pOjXLKoD/9E/f6gve6Vib40TCtJVAFHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948917; c=relaxed/simple;
	bh=uNzqO44Fhh1InmcxRUWdvCvljt6LWpXyHHLfS09W548=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APucguyNWDAiVm/J/z9Fx5sTDQMrXAneHiRwUrmDt1ON4ZjN704OoNfB1BldpmjngpIABMkktK7IjSDdj7JG/rYZ9C/S8iFefzIIlRU437HXR+86ZYkdcQVTWk5kiPb2yxJGrTyVcwAFZ+L7Gggatxuxxpv3ILLPUOtLqnrZuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTdE3aYc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTdE3aYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785948916; x=1817484916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uNzqO44Fhh1InmcxRUWdvCvljt6LWpXyHHLfS09W548=;
  b=KTdE3aYcnWZKW+GNXleCZM7rkobZ+lt9ScvVMBZZWF1YzttOFvdITdCp
   I042rgCuNDDReRoj6YVQ8RAml+yfIvhhMZGpDcqE8CEbaMLrfP6dHH2p5
   ZyChHUgP44KSm+YwCZkwcrylalbvwk1qUjzG3H/4qLbCIQXmyme3xZfVQ
   g2JdKoN11S3Elw6X+mbL7tvZvB4urM2p8CrV3AOho7Ga9W0mBjR6JbxH8
   vChdqT5EHrzpc+PbnOpj7450E1AgeP5Ex5TWyjc6p7U8Umacirpba6y+Q
   it4qxdadRkZapaOu2xBOev706azC/MltK+35QMurMkB5DNmDFRjwoD36Q
   w==;
X-CSE-ConnectionGUID: 3z2OHVq+Qlm8ORfeNc3Ulw==
X-CSE-MsgGUID: x57nSjUaTN+1Ut0p7QZQ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97125972"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97125972"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 09:55:15 -0700
X-CSE-ConnectionGUID: U15s6pn5QJ6IxBebqAaObQ==
X-CSE-MsgGUID: 3w5YAeD6T56mt40D5iOPGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="286518989"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 09:41:21 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wregB-000000004QI-2duv;
	Wed, 05 Aug 2026 16:41:19 +0000
Date: Wed, 5 Aug 2026 18:40:31 +0200
From: kernel test robot <lkp@intel.com>
To: Lucas Poupeau <lucasp.linux@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	kuniyu@google.com, sdf@fomichev.me, brauner@kernel.org,
	krikku@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: Re: [PATCH] net: sysfs: cleanup coding style
Message-ID: <202608051816.a53s4Y2e-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260805/202608051816.a53s4Y2e-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608051816.a53s4Y2e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608051816.a53s4Y2e-lkp@intel.com/

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
