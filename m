Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8D1DF248;
	Fri, 31 Jul 2026 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504366; cv=none; b=lCGfsSE5TtVCLEvN7J8GPEEsR9s4Rjqx+gYYeQqXlDgYaa/1bIVVN5+hdV8xoXTUyOd3Rdb5ppYoh5qONQjmeRzOw8JORKNWGMVK8coxKHLyCwaAlre9KvBcZJzw9/73iMwmNiBEPMf1010AKaKERmLvCPwyDuoCjou9rhYaJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504366; c=relaxed/simple;
	bh=nIG1qcZnbAITJ9F8ZcApjWSQKYFtXcVE4l1QYZI96G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VECs61frIUqyVyY7kr0m8z/aO/YkZhP4PhMMNjXBJ3nrPcwEat+QFyoNOnK19VNVlPTCJRWZt+i8Gcue6XMIwDWspY1eGz7zafJLPykh/kKqqHTK3WMjTiboiPxM3T8tQXZsTNlyoyCU4TyDk77Vc1X9/uX5MJW2KbcHQsVv0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKdYqz7p; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKdYqz7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785504365; x=1817040365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIG1qcZnbAITJ9F8ZcApjWSQKYFtXcVE4l1QYZI96G0=;
  b=YKdYqz7pdlNGW3HVCRol62V5OLDSZ4PggX2hDRmlFqa+jvNQdAIeWgkH
   h/5C3D/2Msswx8ytDooTQQ9MQ4SIvE7+eqhF3qeDxGQw6Zln1Eo3UhK/E
   4jHNl0qZh7v6e+J9EEfDqrlTI3BHzxmFKgh+vpwkJGxquOmEn3Vp/0dMt
   1a6TkvGnwOdiT8pVw3MuJmUD6jjFGvhW/wUj5QkA9SuL/036VaZxLZMx6
   a3gFcj+Htobon2VM6kO5Dlb9KL65Io5+iJ+vVenEdjWXAPHINbkw6nITH
   4I2RGNXWGoyENSZVaQVprtdNBQYDhtw9bfzyBw1bvqcmMnkuL9YjnOMZk
   g==;
X-CSE-ConnectionGUID: rvMHO45bR1q3ym54DKzuIg==
X-CSE-MsgGUID: CjGJdaJLSyyxQOfP/BA04Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="108923135"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="108923135"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 06:26:04 -0700
X-CSE-ConnectionGUID: UxNIjUXkTquD1ugO/6HpYw==
X-CSE-MsgGUID: 0PL/vfzxSYKNYmgmepgoRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="262544045"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jul 2026 06:26:02 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpnFP-000000000yn-132C;
	Fri, 31 Jul 2026 13:25:59 +0000
Date: Fri, 31 Jul 2026 21:25:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>,
	netdev <netdev@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	andrew <andrew@lunn.ch>
Subject: Re: [PATCH v2] net: usb: net1080: add error handling to
 nc_vendor_write()
Message-ID: <202607312111.RaYDdcfw-lkp@intel.com>
References: <19fa888e049.512e8c5e24030.7986824281565553606@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fa888e049.512e8c5e24030.7986824281565553606@zohomail.in>

Hi Ashwin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master horms-ipvs/master v7.2-rc5 next-20260730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashwin-Gundarapu/net-usb-net1080-add-error-handling-to-nc_vendor_write/20260731-180509
base:   net/main
patch link:    https://lore.kernel.org/r/19fa888e049.512e8c5e24030.7986824281565553606%40zohomail.in
patch subject: [PATCH v2] net: usb: net1080: add error handling to nc_vendor_write()
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260731/202607312111.RaYDdcfw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260731/202607312111.RaYDdcfw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607312111.RaYDdcfw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/usb/net1080.c:132:2: error: '#endif' without '#if'
     132 | #endif
         |  ^~~~~


vim +132 drivers/net/usb/net1080.c

904813cd8a0b33 drivers/usb/net/net1080.c David Brownell 2005-08-31  129  
904813cd8a0b33 drivers/usb/net/net1080.c David Brownell 2005-08-31  130  
904813cd8a0b33 drivers/usb/net/net1080.c David Brownell 2005-08-31  131  
904813cd8a0b33 drivers/usb/net/net1080.c David Brownell 2005-08-31 @132  #endif
904813cd8a0b33 drivers/usb/net/net1080.c David Brownell 2005-08-31  133  
904813cd8a0b33 drivers/usb/net/net1080.c David Brownell 2005-08-31  134  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
