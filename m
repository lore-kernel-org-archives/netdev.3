Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4203F8EB3;
	Wed,  5 Aug 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923268; cv=none; b=LjoY8NWhv5NHQyQ6/aVa7XdU6vZw28rWS+azp4fPvDtxG/msb4xAZDRfmpMTaps6YBOzNTR9x0Skxo2JNh+klZW0k+6u1u5MAQCi8HgYEGm5QQBQbZ32UsUhCwoCtxPM0mDacpxjUos2RZSsFRyuCPkQ21vtMbBWDdZLmzlCSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923268; c=relaxed/simple;
	bh=GHEU4O0WNN6MYA4vs8qQuhqOwulGINLrquRjnGs+HmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdIzmnljTHHKG2OWv4nhdO+TI/uxCoBpXTA2TvzJDk31I9iJefZUBj+2GV7X3AL2bBM0zK0HagbFXryGEunvxeI8FunKRmhO4vV23fxA3bCMXv1oZssB45wQCifl8798JBM5UEayGRJNFpbSt6r+/EP8f6tY+lmvoL7gCaj5rmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=de75KOh4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="de75KOh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785923267; x=1817459267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHEU4O0WNN6MYA4vs8qQuhqOwulGINLrquRjnGs+HmQ=;
  b=de75KOh4eTBNfCGqJTQj/yjkyzwQ/pPY0gyFGGUmfNXF7OseefuBYHgH
   klPHL4hEY0Wi4sRHWq9LbJunS/xQ7dbI8nTmbEFq+SDVMty3lLQOLTF/B
   NbKgn2J9i78MRkVTOIFuneq8wF7YXUnHjt2XXjYyvIm+eDJl4V79Lvr0P
   j1ROsSYvABn8vIo0QUpHpxQOB/n4lxurE4LKdFyhMgBHT+QBBDL3fwr9Q
   rghUauQtfFAJpvbxtl7Oq8UFD5ISo8iph0xf3yt0DVEvMG6WIzwdJ9Htv
   FSss6TtjRaaFJbyxOcDakgOZXhjxdHt0e7FahDJM8tZDWlE8QYNifMk5P
   A==;
X-CSE-ConnectionGUID: QOlIBT7YT22ngH/JkZjuoA==
X-CSE-MsgGUID: LbmnqtkXRw2PmhmF3O04rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86502434"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86502434"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:47:39 -0700
X-CSE-ConnectionGUID: NVDVCQaQRlmZU4kQHxwvHA==
X-CSE-MsgGUID: CNUYMUKFSEyhdmFYHTMKaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261207122"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Aug 2026 02:47:35 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrYDk-00000000C3l-2t5l;
	Wed, 05 Aug 2026 09:47:32 +0000
Date: Wed, 5 Aug 2026 17:47:12 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas Poupeau <lucasp.linux@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org, kuniyu@google.com,
	sdf@fomichev.me, brauner@kernel.org, krikku@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: Re: [PATCH] net: sysfs: cleanup coding style
Message-ID: <202608051723.zyzTXXX2-lkp@intel.com>
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
[also build test ERROR on net/main brauner-vfs/vfs.all linus/master v7.2-rc6 next-20260804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Poupeau/net-sysfs-cleanup-coding-style/20260805-152318
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260628185824.231250-1-lucasp.linux%40gmail.com
patch subject: [PATCH] net: sysfs: cleanup coding style
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260805/202608051723.zyzTXXX2-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608051723.zyzTXXX2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608051723.zyzTXXX2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/dma-mapping.h:5,
                    from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:44,
                    from include/linux/netdevice.h:38,
                    from net/core/net-sysfs.c:10:
>> net/core/net-sysfs.c:622:23: error: 'netdev_group_show' undeclared here (not in a function); did you mean 'netdev_show'?
     622 | static DEVICE_ATTR_RW(netdev_group);
         |                       ^~~~~~~~~~~~
   include/linux/device.h:173:36: note: in definition of macro '__DEVICE_ATTR_SHOW_STORE'
     173 |         .show           = _Generic(_show,                                               \
         |                                    ^~~~~
   include/linux/device.h:201:9: note: in expansion of macro '__DEVICE_ATTR'
     201 |         __DEVICE_ATTR(_name, _mode, _name##_show, _name##_store)
         |         ^~~~~~~~~~~~~
   include/linux/device.h:204:9: note: in expansion of macro '__DEVICE_ATTR_RW_MODE'
     204 |         __DEVICE_ATTR_RW_MODE(_name, 0644)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:246:52: note: in expansion of macro '__DEVICE_ATTR_RW'
     246 |         struct device_attribute dev_attr_##_name = __DEVICE_ATTR_RW(_name)
         |                                                    ^~~~~~~~~~~~~~~~
   net/core/net-sysfs.c:622:8: note: in expansion of macro 'DEVICE_ATTR_RW'
     622 | static DEVICE_ATTR_RW(netdev_group);
         |        ^~~~~~~~~~~~~~
>> net/core/net-sysfs.c:622:23: error: 'netdev_group_store' undeclared here (not in a function); did you mean 'netdev_lock_store'?
     622 | static DEVICE_ATTR_RW(netdev_group);
         |                       ^~~~~~~~~~~~
   include/linux/device.h:177:36: note: in definition of macro '__DEVICE_ATTR_SHOW_STORE'
     177 |         .store          = _Generic(_store,                                              \
         |                                    ^~~~~~
   include/linux/device.h:201:9: note: in expansion of macro '__DEVICE_ATTR'
     201 |         __DEVICE_ATTR(_name, _mode, _name##_show, _name##_store)
         |         ^~~~~~~~~~~~~
   include/linux/device.h:204:9: note: in expansion of macro '__DEVICE_ATTR_RW_MODE'
     204 |         __DEVICE_ATTR_RW_MODE(_name, 0644)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:246:52: note: in expansion of macro '__DEVICE_ATTR_RW'
     246 |         struct device_attribute dev_attr_##_name = __DEVICE_ATTR_RW(_name)
         |                                                    ^~~~~~~~~~~~~~~~
   net/core/net-sysfs.c:622:8: note: in expansion of macro 'DEVICE_ATTR_RW'
     622 | static DEVICE_ATTR_RW(netdev_group);
         |        ^~~~~~~~~~~~~~
>> net/core/net-sysfs.c:621:16: warning: 'group_show' defined but not used [-Wunused-function]
     621 | NETDEVICE_SHOW(group, fmt_dec);
         |                ^~~~~
   net/core/net-sysfs.c:143:16: note: in definition of macro 'NETDEVICE_SHOW'
     143 | static ssize_t field##_show(struct device *dev,                         \
         |                ^~~~~
>> net/core/net-sysfs.c:615:16: warning: 'group_store' defined but not used [-Wunused-function]
     615 | static ssize_t group_store(struct device *dev, struct device_attribute *attr,
         |                ^~~~~~~~~~~


vim +622 net/core/net-sysfs.c

   614	
 > 615	static ssize_t group_store(struct device *dev, struct device_attribute *attr,
   616				   const char *buf, size_t len)
   617	{
   618		return netdev_store(dev, attr, buf, len, change_group);
   619	}
   620	
 > 621	NETDEVICE_SHOW(group, fmt_dec);
 > 622	static DEVICE_ATTR_RW(netdev_group);
   623	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
