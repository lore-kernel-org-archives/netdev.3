Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416551F192E;
	Wed, 15 Jul 2026 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093730; cv=none; b=rS5AtnJ5JQOYMrSxV02frgtaXS1eHyXT14turU3L3PiSYKu6o8HaeMDvVGYdAm+Zdk82gZVys6oeHty8tjB/fHYPmSiC89oO91DR88ABESIyeIt/3XCqm6fx8BlIxne14+lqMdTLzW+L5IOlu2mS0o/JuxMw3iym0zGYgrkXCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093730; c=relaxed/simple;
	bh=qzNd4lJnp8G3pQxoGfnqn/XQndLFNVA0827fMrZlCRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1ENnluJt0xAt4FP+DvsBGOtlK/fdPNPwnoMAsjdhTshVverXvhnT6uyOZEBRrGg4pK6X/4ibcuSffC5s1Mxs/Qp1mt3n1uXEQ2GN6Cnz35gPlFj4EBm1Bp2MtIczs/hpP8y0RWzSCxdiEtLIoDWGuf6D7E4O0w8tXhHzQkMZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJHaqb0f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJHaqb0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784093727; x=1815629727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qzNd4lJnp8G3pQxoGfnqn/XQndLFNVA0827fMrZlCRc=;
  b=TJHaqb0fkmahdqlBw5UyKv7DDHkpT0CZYto3K/bmsZsToEfVYGLkM6nV
   2tFv9/9XZF0a5zhsFeV+PYoMRlGkMVTJAq3OOpATYsAE22oLSqPdHNQw4
   6lA8mYmGh5wSxUsC1w0N4RxJuMrtC8hEE9+Aw69L7grniNqLtKMwYXmVe
   2YkV8VRpH6CUQefErNKJcl0tSoKr2TpK3Go5tsRiQNZ/gFYtT6Yop0QYg
   Zro07OwZtLqaV10F5dPyIrYm5hqHBjpMGGeJjAyFtkgfP7wNs9qAfQr7S
   D/7o+GplqLw/0cF94ES5O9ssgDwwpM68yWtAyS034iNkJ6Ids1Lf1twjx
   Q==;
X-CSE-ConnectionGUID: KzLNWknhRNeYxsyOn0PQGw==
X-CSE-MsgGUID: I77V9ubjTxG+Hq9egnSjxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110268527"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="110268527"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 22:35:26 -0700
X-CSE-ConnectionGUID: 9pIJRe8aRP+qwaC22jXy/w==
X-CSE-MsgGUID: oYSLFNM1SYes8v1QU8WBXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="256107748"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 14 Jul 2026 22:35:23 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjsHA-00000000NKV-12iR;
	Wed, 15 Jul 2026 05:35:20 +0000
Date: Wed, 15 Jul 2026 13:35:09 +0800
From: kernel test robot <lkp@intel.com>
To: Weiming Shi <bestswngs@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Tung Nguyen <tung.quang.nguyen@est.tech>, xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v5] tipc: serialize udp bearer replicast list updates
Message-ID: <202607151342.sJOXeRCT-lkp@intel.com>
References: <20260714192140.1810202-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714192140.1810202-1-bestswngs@gmail.com>

Hi Weiming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Weiming-Shi/tipc-serialize-udp-bearer-replicast-list-updates/20260715-033047
base:   net/main
patch link:    https://lore.kernel.org/r/20260714192140.1810202-1-bestswngs%40gmail.com
patch subject: [PATCH net v5] tipc: serialize udp bearer replicast list updates
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260715/202607151342.sJOXeRCT-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260715/202607151342.sJOXeRCT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607151342.sJOXeRCT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/tipc/udp_media.c:106 struct member 'disabled' not described in 'udp_bearer'
>> Warning: net/tipc/udp_media.c:106 struct member 'disabled' not described in 'udp_bearer'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
