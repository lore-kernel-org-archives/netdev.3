Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668FC37999D
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704254; cv=none; b=QUsD2A1mEKoJG18kwoLC/W+l/uvZo/AvfSdAFVc/I/4ygdocVa06Tx9aI3kbFYVJErGLWoy2E/6l4x7XmHwR3jR1fgV+4cdP8PrVACOvBdOjLInZV7vFpakLWFGgpLyPTFPepDV5sVBvst5DvHzOW4jYWhaLf2FpMVhtJ/KOi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704254; c=relaxed/simple;
	bh=loarNLtT4VCaLQk1B9B1QzIFq8ttTnJYOAjEkPYNMg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvPVC0sD+mUf8gtxnntrrgUPsVhZuAP7E03rZfQtEjgsV1QrVDZTzYpLoDLico8kCIUnchp0Y+/TWHWJLM3/TNsvbYsJrwvms7CWaKmyMLjtvv8paqrAQnTwrppCrm+yk1lIxy0vm2Xfrk0aFSaVGI2DDpZ/8Nj5PzissRTyEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYOLDkHf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYOLDkHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772704252; x=1804240252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=loarNLtT4VCaLQk1B9B1QzIFq8ttTnJYOAjEkPYNMg4=;
  b=aYOLDkHf83INxJE1HLS+crDNYeWgup34lnSfRH5YrjZzFVT201X1jlcn
   SLP1weu/9GrYjxL0O1wohytElFZoYhgG4y/12ts78ctTBzRM5ajSFuOir
   H3QtXjZMzRiReZHXyom9CCy5FrifVtKfhekjO/yt70eg7qvBHO59gf7hj
   KPfnl/dpwumvPaV8zIyTkj+jwrklWiWKKZ4I2OeAcOLH9ei8iy0hfL7KB
   3g1pRqbou+YqGjOFqEREkD6jMr4x4v4ubpSjvzA9XT6aEEO90sEdk2xiN
   jatsLc8aJ4WGJMOCI0CvETqV+7cVBy5eiDA8Klh2ldtTUWQLSLnmGUsaL
   Q==;
X-CSE-ConnectionGUID: 7oJh+VBIRqyXi8AwTX976w==
X-CSE-MsgGUID: VpGee59DTeCxuILManuexw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73656601"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="73656601"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 01:50:51 -0800
X-CSE-ConnectionGUID: ZWHJkIw+RwCGc8NxHZfNyg==
X-CSE-MsgGUID: qVRzyqLcRL2FZBk8g08Ayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="249093266"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2026 01:50:45 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy5Lu-000000000Qs-13af;
	Thu, 05 Mar 2026 09:50:42 +0000
Date: Thu, 5 Mar 2026 17:50:16 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Use also port
 number to identify timestamps
Message-ID: <202603051716.XWkBTVcW-lkp@intel.com>
References: <20260304080318.FyNGmyyP@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080318.FyNGmyyP@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/net-ethernet-ti-am65-cpsw-Use-also-port-number-to-identify-timestamps/20260304-161208
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260304080318.FyNGmyyP%40linutronix.de
patch subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260305/202603051716.XWkBTVcW-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051716.XWkBTVcW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051716.XWkBTVcW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/ti/am65-cpts.c:1011 function parameter 'port_id' not described in 'am65_cpts_prep_tx_timestamp'
>> Warning: drivers/net/ethernet/ti/am65-cpts.c:1011 function parameter 'port_id' not described in 'am65_cpts_prep_tx_timestamp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
