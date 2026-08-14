Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9C931E847
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719058; cv=none; b=Ht+QPgmL/ugHIoAUlVG+WApkLT5jXmIjonrR0bxSRqff4+Fn5cKgluvWQRTeOhSeohCyXhHsp7eO/lN+SIeLEh5wd1a6wtK9vvGCrM4RKE5v1yXfYOg2J9Iei+UNKeRQ9H0ZYDlwETsdR4Eh/JvUaRbF6s/cazUlwht6yHbpIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719058; c=relaxed/simple;
	bh=92B9TlJsr3BMYc4vrrM7ZIwJPo2f/aTDXkUNIm14iVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEwGhyIVENUFJtW8EN6M9pcUNbXZMIq5JqUtAs1c8ENC80UStcu/tDp1Uy9oketmoApPDVBf8HngmwUs5D4KPkTZauFXyfHLPoUBzkWQPg3mz5t21tMOyJ6pKh66MbUdOhA6TAY7xS7r5XoMKH9hoDMRh/9RkMvztaezrUH6VAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVGwHFtU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVGwHFtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786719051; x=1818255051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=92B9TlJsr3BMYc4vrrM7ZIwJPo2f/aTDXkUNIm14iVQ=;
  b=nVGwHFtUh1sQ52kTDYOUCxk9Dik1R0RKFNjc9YCZ12c1jWN35S6gUpTo
   5DDawn94NglAfZUZOcE6IWHklxKsqcRakuJ4p0aEHZyHPwtPwBQmTi+sJ
   9tSAkUVujnhM9pg2ghKAMHC8FgO5WcXdo+TdCRtju5k8fxna1t74IWSjf
   c0YNRRSFDfs5ijyse4lBgUEVRKvUl7OOIjkt7780/OTKVD6yGx/MxR7LQ
   Ibb1mRslN+BTdjAl0VysDctb4MCitp4l8NBQV7P2qBk9FW63leSboRtbC
   FMY4+fNux5e0fVEmk0K+8Rabh9hKoZDlw4/78N8I0xFOFWDRU6V8UHntx
   w==;
X-CSE-ConnectionGUID: sY7PYka5S8i0xJj0TmyMvg==
X-CSE-MsgGUID: zWjQ8z6hSGCZP6s6TN7FqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87319032"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87319032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 07:50:46 -0700
X-CSE-ConnectionGUID: SzcQX8pCT4+6sYgVwfjWBQ==
X-CSE-MsgGUID: wqCE1cKWSeCEx09ysMOEAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302483635"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 14 Aug 2026 07:50:42 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wutF2-000000006Hf-3RqH;
	Fri, 14 Aug 2026 14:50:40 +0000
Date: Fri, 14 Aug 2026 16:50:17 +0200
From: kernel test robot <lkp@intel.com>
To: Tung Nguyen <tung.quang.nguyen@est.tech>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com,
	horms@kernel.org, tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>, Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH net v10] tipc: fix NULL deref in tipc_named_node_up() on
 empty publication list
Message-ID: <202608141616.ndguFzxL-lkp@intel.com>
References: <20260804021628.28607-1-tung.quang.nguyen@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804021628.28607-1-tung.quang.nguyen@est.tech>

Hi Tung,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tung-Nguyen/tipc-fix-NULL-deref-in-tipc_named_node_up-on-empty-publication-list/20260807-042503
base:   net/main
patch link:    https://lore.kernel.org/r/20260804021628.28607-1-tung.quang.nguyen%40est.tech
patch subject: [PATCH net v10] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260814/202608141616.ndguFzxL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608141616.ndguFzxL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Checksumming on output with GSO
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ [docutils]
   WARNING: ./include/net/page_pool/types.h:105 Excess struct member 'fast' description in 'page_pool_params'
   WARNING: ./include/net/page_pool/types.h:105 Excess struct member 'slow' description in 'page_pool_params'
   Documentation/networking/tipc:184: ./net/tipc/name_distr.c:261: ERROR: Unexpected indentation. [docutils]
>> Documentation/networking/tipc:184: ./net/tipc/name_distr.c:262: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/userspace-api/landlock:550: ./security/landlock/errata/abi-4.h:5: ERROR: Unexpected section title.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
