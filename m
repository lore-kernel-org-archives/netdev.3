Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C64266B2;
	Fri, 31 Jul 2026 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506382; cv=none; b=umkTmMb34h0TOHaYhEYCSAQ5xbobCicRE8wwoS+b+W699dbcyUwtQOXw/1ZPlNVacDGQbsunvxfWrT/Q1SXq4R4p0qvnXoGwIk9QV21nEW0DVKxDrBHdMsbA9qPbKYUvJGRzuQOMRtu71XAvpjyQxyG3SXQPwdntFfGBV2uOCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506382; c=relaxed/simple;
	bh=+XV+enkyZxfJAKv056yIwFw5Xr9BJehT8qLm/+5QHME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byMUnSIEmUDOvCrxPxwa6wZkGQ0p8t3WjfM1lBfZLQfSNss8YQUe9Ny4faE24wRHR4GxHDrfv6tqO7t9qazo5XmiqQn0XLxO8xJe3FVfqYEWwTS9s9ZOWlmUhiNUE6yl3eG80yTmTnjY1g8KH6wLX1tkx8g7aJYyZrNO/1kouIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byq7vO7j; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byq7vO7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785506380; x=1817042380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XV+enkyZxfJAKv056yIwFw5Xr9BJehT8qLm/+5QHME=;
  b=byq7vO7jFEFxgozZLU7ytlB+djd2TY2EYdg6/qjmYvrb9ZWWSbvYhHLw
   VKhFVZYhPPSRXWNqVSqwNmR1wts1SZb3gK5/hE7IsqGemXtf1pBa3Wi55
   nKtgPm7jB9IGfxrIOZlOqEuH3Wzc21kDCeTQlBUhwWDP7+Q4UhaGewcMH
   pDps35zD1szlJdCeB+3pnc1HpQN+Gt5sG7PcvH7DwQ1u7O63NtVwwNwg4
   eT9bCcP6aSjdyRxn50ITOcXwnxriwKLNcmjkZvEsPITQnjYidSqKnvhBJ
   MpqmTFTbRoH+fSVXKbm9jZBcuq+Zlc3GjxBgdlBEk3YE0PN4+d9YKIYBJ
   g==;
X-CSE-ConnectionGUID: 1+IAVpSYQZmgSDOg3TaW/A==
X-CSE-MsgGUID: uqtJkAZzRLKKxtdnvBb25A==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="111677895"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="111677895"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 06:59:34 -0700
X-CSE-ConnectionGUID: BS6hcmAFQrip23A/ScQoGw==
X-CSE-MsgGUID: +zgHyQdySzK2BovyQs/ahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="260646806"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2026 06:59:33 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpnlq-0000000035m-1L5K;
	Fri, 31 Jul 2026 13:59:30 +0000
Date: Fri, 31 Jul 2026 15:58:35 +0200
From: kernel test robot <lkp@intel.com>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>,
	netdev <netdev@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	andrew <andrew@lunn.ch>
Subject: Re: [PATCH v2] net: usb: net1080: add error handling to
 nc_vendor_write()
Message-ID: <202607311511.xIUupBfm-lkp@intel.com>
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
[also build test ERROR on net-next/main linus/master v7.2-rc5 next-20260730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashwin-Gundarapu/net-usb-net1080-add-error-handling-to-nc_vendor_write/20260731-180509
base:   net/main
patch link:    https://lore.kernel.org/r/19fa888e049.512e8c5e24030.7986824281565553606%40zohomail.in
patch subject: [PATCH v2] net: usb: net1080: add error handling to nc_vendor_write()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260731/202607311511.xIUupBfm-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260731/202607311511.xIUupBfm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607311511.xIUupBfm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/usb/net1080.c:132:2: error: #endif without #if
     132 | #endif
         |  ^
   1 error generated.


vim +132 drivers/net/usb/net1080.c

904813cd8a0b334 drivers/usb/net/net1080.c David Brownell 2005-08-31  129  
904813cd8a0b334 drivers/usb/net/net1080.c David Brownell 2005-08-31  130  
904813cd8a0b334 drivers/usb/net/net1080.c David Brownell 2005-08-31  131  
904813cd8a0b334 drivers/usb/net/net1080.c David Brownell 2005-08-31 @132  #endif
904813cd8a0b334 drivers/usb/net/net1080.c David Brownell 2005-08-31  133  
904813cd8a0b334 drivers/usb/net/net1080.c David Brownell 2005-08-31  134  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
