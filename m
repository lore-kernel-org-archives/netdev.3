Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B214883F;
	Thu,  4 Jun 2026 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553042; cv=none; b=kHs59DzEb1RVSb2/2h/nPQBfAAm0/9s7VZx/AZemL8ocPv3EYPXgUsosyZjqW2VlIkkE173K3u/iAinbqWvJf9LAsC4PKIBKb4CcnMOJYKeelA6KPfv9+4AGm4T6k1tQNw5tmPrDxTRtK6yIwil7Q3hCpQQlTCyU1FKB/ez+YtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553042; c=relaxed/simple;
	bh=CiAF47QrFNb3VQSmiI1gAWPARMkmVShzbMohSB9skDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNKqm5KiXSq0StyHOFSvrCMlV3vYv5gDudPilV3DDsvVDoDv24Kfb1etrZSsJ0zaov9mKtHr/Rw5c2U5BbcYDDIohEpGSn3HvgI/SflaV7chUeUGC3a538c5SozkcwuBYccythg+YvTZz4GkWvOZEJe9uLXP1PO/KDo82oMOQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJvpn/qM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJvpn/qM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780553041; x=1812089041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CiAF47QrFNb3VQSmiI1gAWPARMkmVShzbMohSB9skDA=;
  b=fJvpn/qM3073y/2hfHx7jaROjj45LMy6LUzSS+LVaA57oBNPavCfANDg
   5oJzCUXaTkbFbUtpND6yGlG06jcEtkB/dJNT96JKWxDukKB8DabB8A3+Q
   Vdn+8D1ajiy5VfLjGwKUbK5SnoODWTpug937mjewQ8h3w087MidYq7GCe
   IftfX4abRm3ARbLtHWI1RPFoBxj9oZayf6Cg2knb3YKi8FuH7C+z2k2yq
   nSoYd9tC3+yBzlSB80EWs17Ya/4kvTqHNNp3wnLqo/opnkhV7ejCeKbrf
   03MH125X1xaLGxKl/6CyyXqPyr7sRjlYlh0Q+LBeR3/lNyAfcCTvr4IZv
   Q==;
X-CSE-ConnectionGUID: qc+Kki1hQvOiNS7qK4xxLw==
X-CSE-MsgGUID: y18nxBh9TCutvyIq4ODC2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92858496"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92858496"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:04:01 -0700
X-CSE-ConnectionGUID: rW2snc4ATBmWtyOd08pxfw==
X-CSE-MsgGUID: DMk6Ah2STY2ZVZIFf0OH7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="243381899"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 03 Jun 2026 23:03:58 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wV1BL-000000002HX-0huY;
	Thu, 04 Jun 2026 06:03:55 +0000
Date: Thu, 4 Jun 2026 08:03:38 +0200
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net,
	skhan@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
Message-ID: <202606040736.mHgLfIxh-lkp@intel.com>
References: <20260603162943.2406080-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603162943.2406080-1-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/docs-exclude-driver-and-netdevsim-bugs/20260604-003949
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260603162943.2406080-1-kuba%40kernel.org
patch subject: [PATCH net-next] docs: exclude driver and netdevsim bugs
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260604/202606040736.mHgLfIxh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606040736.mHgLfIxh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Checksumming on output with GSO
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ [docutils]
   Documentation/process/maintainer-netdev.rst:295: ERROR: Unexpected indentation. [docutils]
>> Documentation/process/maintainer-netdev.rst:299: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   MAINTAINERS:40: WARNING: Inline strong start-string without end-string. [docutils]
   Documentation/userspace-api/landlock:504: ./security/landlock/errata/abi-4.h:5: ERROR: Unexpected section title.


vim +299 Documentation/process/maintainer-netdev.rst

   292	
   293	Additionally, netdev does not consider bugs to be ``net``-worthy
   294	if they fulfill **all** of the following criteria:
   295	 - bug is in a hardware device driver;
   296	 - bug is either a missing error handling or is part of the error handling flow;
   297	 - bug was discovered by a static analysis / AI tool;
   298	 - bug was triggered/observed only with kernel changes or fault injection.
 > 299	Fixes for such bugs should default to ``net-next`` and should **not** contain
   300	a Fixes tag. Networking or driver maintainers may redirect such fixes to ``net``
   301	at their discretion if they consider the condition to be relevant enough.
   302	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
