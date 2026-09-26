Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A6415B6E;
	Sat, 26 Sep 2026 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790420949; cv=none; b=JMDedJ0AalJNNSJouh8vytlezE0XPZkhVU5s2FJj2V11pVi0nyfRjuu5wJg1tAyenFcvHqDU4iW5sCoEAjzHQ9zLtgE7dlzJp0ivKMpqyJOdOu1bRdYD1+OKfGvQD7J4CQtD/323nPgWsJQyug/KmQXimKj7lACT+u9jp8J1VfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790420949; c=relaxed/simple;
	bh=DKiUHwOK/x73XxFXAzjap/JskM7x2k2D+Zd1wUoYq4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrGzwTJpVSX7IrJ/1GO6bapiMpEOolYHF0m0ZCa57F9KnXcokoOOAVmD+7mWXINm+aj+80ovVmC2dh3Sv68+e+MO0Z4XTwaFVbExTnuVea/LKqVMd2HuEVZF+ck1DqOhB6fIhe9mX1X35lam8f5eeW2sns26pgggL1sY5Q7Den4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLUKHm4g; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLUKHm4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790420947; x=1821956947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DKiUHwOK/x73XxFXAzjap/JskM7x2k2D+Zd1wUoYq4Y=;
  b=LLUKHm4gvF86h3z0DDrQeKu1cxbKm7AfL2N9csA+WWUsBRzJyb5mz9bD
   sWPjq5BikJ2f29b58oepoNUERotwHv2Eidyy1bkq0Elvy4Ku0Dz+sgdnF
   Gm1MPBpyGS8zgJ6j7RM+TCGu2DPX2iQ13289Lb6R15GRgt/xCthaNYK7H
   EiuHErmmeTBCWde6d5XLsu/y21qkY8l87b/WXoPvCLBovCMb1HQxZvUxK
   KYR83ZbsTcIit+Qchn7PR7cQTqUdOLyr9+8VJiVX6rbF3mORZHEGTgzxV
   V70pKKaMUAudCIWTlT8W9wcJY3C04aDw4jHQPVWVOw4s8/n6vzyBtmu+1
   Q==;
X-CSE-ConnectionGUID: n/03og4wTJOzEEq99+ywFg==
X-CSE-MsgGUID: KPjQcGvUQtSL+c/t3yii/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="107570102"
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="107570102"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 04:09:07 -0700
X-CSE-ConnectionGUID: JkIKC/OmQoms6DP43x8YKQ==
X-CSE-MsgGUID: EhbnnXAWQReuHjusOFEfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="302499075"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Sep 2026 04:09:02 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xAQH5-00000000Ljh-3rNY;
	Sat, 26 Sep 2026 11:08:59 +0000
Date: Sat, 26 Sep 2026 19:08:25 +0800
From: kernel test robot <lkp@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com, horms@kernel.org,
	grzegorz.nitka@intel.com, vgrinber@redhat.com,
	zoltan.fodor@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: Re: [iwl-next v15] ice: add support for unmanaged DPLL on E830 NIC
Message-ID: <202609261833.lptlCpVW-lkp@intel.com>
References: <20260922132946.3241002-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922132946.3241002-1-arkadiusz.kubalewski@intel.com>

Hi Arkadiusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1562ff70880100d14a32b6b68eef044f1a334df1]

url:    https://github.com/intel-lab-lkp/linux/commits/Arkadiusz-Kubalewski/ice-add-support-for-unmanaged-DPLL-on-E830-NIC/20260922-152945
base:   1562ff70880100d14a32b6b68eef044f1a334df1
patch link:    https://lore.kernel.org/r/20260922132946.3241002-1-arkadiusz.kubalewski%40intel.com
patch subject: [iwl-next v15] ice: add support for unmanaged DPLL on E830 NIC
config: x86_64-randconfig-1014-20260926 (https://download.01.org/0day-ci/archive/20260926/202609261833.lptlCpVW-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260926/202609261833.lptlCpVW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609261833.lptlCpVW-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/net/ethernet/intel/ice/ice.ko: symbol 'ice_cgu_get_num_pins' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
