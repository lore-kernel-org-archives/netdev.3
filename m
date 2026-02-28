Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063323126CD
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273042; cv=none; b=kz5vNwy9fa6PN/Vo6QubeQ53auRLBMXXCi1upbzRnDlMEsdsRgzaHprHhPQMaeP72fdfFkwnw0zqgLswhKArR+PhDNcQxpBHbL/0PmKrdjgQ3dFpaW0OLFQI1hidIea2pmpDMcXFjtMvFa7D4CEFfjWCsqMXo6DOQ+1ymh+CARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273042; c=relaxed/simple;
	bh=PbDLGt89NFjsAyp83UgRTs0VEEXSdks9u2vfwBm3pVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIKwWhvuit4fyqpIhTZd1MQmom6bhmCsHlnOyslP1mSPmRWbqpAo636SeBB+6hVlfMDGHD6Ntj5YNwaCeFPQtDLujykF2JemAmz2eXC3mKFrBawGb/3+tlITbeC6rw8Y0d4jKU+g9/AZPFnQubUR2jG6wbZXs3fEunHv6IX71qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYuiK8WL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYuiK8WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772273041; x=1803809041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PbDLGt89NFjsAyp83UgRTs0VEEXSdks9u2vfwBm3pVc=;
  b=cYuiK8WL/BcNmKmQPqz887A0V7r2qDxc56X9JzvcvqmnWCG/gIsdiPpm
   VhpOx+Szh5IARJhKKnCMc6knHHB5Ss/DFUchvBr67VxqmSAmlRHhufC5N
   sVfCFZQ/G9brIcAAGXW9wZCVzHod8qAsITxnILnxD3PFpcrMx93i9l2p3
   6DVw6adAJ+uoWzfB75UfIVIHVWk21yMsyJiZ6YDM+bGVq91Bflu18XTzo
   Vw338CWNs3NvpZ78g3KBFo0+W3tmuwIMjSEGDOpoBgr35bNQ8bYNPmhf0
   W+yRTrz9D+H3eVk16BDqerDs0g47vIH18JamBB3Rp5BFyWiH3OpmlrCsE
   g==;
X-CSE-ConnectionGUID: om53XQaqTYGc5SBb0Bonvg==
X-CSE-MsgGUID: 3bok741BQv24jx/nBmElIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="83683031"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="83683031"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:04:01 -0800
X-CSE-ConnectionGUID: pa8nyYIeQQGifVZE7S0OGg==
X-CSE-MsgGUID: vRHI+vtoSKa3K3dr+IP5CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="214911570"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 28 Feb 2026 02:03:58 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwHAx-00000000BRv-2Hlv;
	Sat, 28 Feb 2026 10:03:55 +0000
Date: Sat, 28 Feb 2026 18:03:26 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 7/7] net-sysfs: use rps_tag_ptr and remove
 metadata from rps_dev_flow_table
Message-ID: <202602281743.ifacPvjH-lkp@intel.com>
References: <20260228042503.3726451-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228042503.3726451-8-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-add-rps_tag_ptr-type-and-helpers/20260228-122855
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260228042503.3726451-8-edumazet%40google.com
patch subject: [PATCH net-next 7/7] net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table
config: x86_64-randconfig-161-20260228 (https://download.01.org/0day-ci/archive/20260228/202602281743.ifacPvjH-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602281743.ifacPvjH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602281743.ifacPvjH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/core/dev.c:4990 function parameter 'log' not described in 'rps_flow_is_active'
>> Warning: net/core/dev.c:4990 function parameter 'log' not described in 'rps_flow_is_active'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
