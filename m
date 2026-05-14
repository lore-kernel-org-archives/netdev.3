Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE29282F3A;
	Thu, 14 May 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790547; cv=none; b=qD+5oqpGA+Nx/wN0MHvlJAcxyL6Ut3mxpyTNGvI05GsdzwyXjy0rWgvK00wiMHKK27IF2Jhn9EFyhF5IbiwcL/eZzi8rh7pnjYTUYZdaMlkQrsxe/7UbVRMaGavcOJ1QFErFuysTbh5EIgCBVd8dZE8w/uGb6fX3zVUmLGShHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790547; c=relaxed/simple;
	bh=WYEZ+dPObHt5hmrhhbH7GFqUbFObKwL+IZ1qBKpCbqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buWIUmkKcj+YdsSmb08yjctv+q+IfS9aIuykVeBQ55OViMIksIPKVX1M5kXZo7PtIMXcm2Gxn7OsHvfktS4bv9bpVWgvVBxETr8iP+yYubQHnX2dlzcodxdu6PrSRBeL2h8g5/r+fyGtuVHM9exWXS1OTeTkuofUimOuz2FNbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfVLs6PB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfVLs6PB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778790545; x=1810326545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WYEZ+dPObHt5hmrhhbH7GFqUbFObKwL+IZ1qBKpCbqE=;
  b=MfVLs6PBU5eOxjpIg8VoRaNFQqUS60n9Du4fcWFiXkqoksa70eTmP+GS
   NE3MRBALeYPl30mM/ov3MCiKiSThlx4UUz9fa1zg7eL4DJoPHT5jCJyMR
   bvlxGeHD4mSywQd6ryC0xKQeiV3v+ndrDtvaKvVzX6tnUWdm3MFHMucvx
   vH8FqxDaIs36gXssJLBWqijF6SufLrjebshZzPRLqUsy4L55oJMk3/fZx
   o/iI2sUVx+deaKTYDS/sPz3muiWBGfuOWYucQ5Np1wO46cji+kHHRa6sQ
   +uDCSFzIUtMVLIr5fn2BBSM6bWtzNYNXoGt2k14qSbUBNSqJaZmDtC9YA
   g==;
X-CSE-ConnectionGUID: XId8jSmaROOeriqRxFADfw==
X-CSE-MsgGUID: 2ook4UjhSayyw+Nx+XV1Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83355268"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83355268"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 13:29:05 -0700
X-CSE-ConnectionGUID: G6h6ELAETkesj8PpJAy8FQ==
X-CSE-MsgGUID: To/4DETzS4GEq19uZxuA5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="232092652"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 14 May 2026 13:29:01 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNcfz-000000008rh-0Xcq;
	Thu, 14 May 2026 20:28:59 +0000
Date: Thu, 14 May 2026 22:28:54 +0200
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml
 format
Message-ID: <202605142234.F1IZjPJb-lkp@intel.com>
References: <20260512214704.1084890-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512214704.1084890-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-net-dsa-Convert-lan9303-txt-to-yaml-format/20260514-202017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20260512214704.1084890-1-Frank.Li%40nxp.com
patch subject: [PATCH 1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml format
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260514/202605142234.F1IZjPJb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605142234.F1IZjPJb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
   Warning: Documentation/doc-guide/parse-headers.rst references a file that doesn't exist: Documentation/userspace-api/media/Makefile
   Warning: Documentation/leds/leds-lp5812.rst references a file that doesn't exist: Documentation/ABI/testing/sysfs-class-led-multicolor.rst
>> Warning: Documentation/networking/dsa/lan9303.rst references a file that doesn't exist: Documentation/devicetree/bindings/net/dsa/lan9303.txt
   Warning: Documentation/translations/it_IT/doc-guide/parse-headers.rst references a file that doesn't exist: Documentation/userspace-api/media/Makefile
   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/ja_JP/process/submit-checklist.rst references a file that doesn't exist: Documentation/translations/ja_JP/SubmitChecklist
   Warning: Documentation/translations/zh_CN/doc-guide/parse-headers.rst references a file that doesn't exist: Documentation/userspace-api/media/Makefile
   Warning: Documentation/translations/zh_CN/filesystems/gfs2-glocks.rst references a file that doesn't exist: Documentation/filesystems/gfs2-glocks.rst

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
