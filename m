Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A63346E55
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820364; cv=none; b=eSIIdIyt1UBosKWmFr9Zhi+korrZE9UBD6KM4Wofg01rR3L+fCrFtXb9xktEXiKi4BWSyDpiFKvE3JhAxo6tDp1C3AHYF1VqfShXmzeLvvAizRIRhWUhUjROxFU9XSYxx/O7CwJZCMbiWPntJPqGwcC+R9m7PjmtCLCM1O4w+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820364; c=relaxed/simple;
	bh=VMDQ5Yg8DCFYUJFdKdJTTFR7iu9BxC3IjQ7xLhN4EqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APokGBMiiLMSVCMjG6X1VvzXdexpA0G5LHfjd0D/7PSInakzDbGyykRxlf/ZAksNNkuTGN96Ss/7TxhyJlQ8RTW1ez9NOYpn8wwkMK7UinDVkhYV8Cw+8BO5wcNslUiTcZuQMG81Fz/sQB+D7rBHTs0i6zbj5JOE0BXyfsAN5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gi//W0Uw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gi//W0Uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772820362; x=1804356362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VMDQ5Yg8DCFYUJFdKdJTTFR7iu9BxC3IjQ7xLhN4EqM=;
  b=Gi//W0Uwg4nAqZU8eR6wgnc+ayGtJqg7GfvhywTVzlHnO1HUjh96MsJP
   fCz3kO2EtSQRWuYWztShpgr2uWZGN/RUXAnoQOB+/gyt6QopA4vWyf9Is
   SlO3cjU3/vbYTJSmm+0vbPvRKAz0c7xATaiKtwej8akrqqnV/ZwOYHYDY
   OoTkkk66DwanBzaOplsd9K1yCNKPir0AYX8hG2Px3+ixR2hceel033s4Z
   COcvDWWUhS9vxG5pre1fRy/csXLKNtb1vl1rwBb90u6BHKoJO+majEreF
   ZPJWuVtdHWohy7NeT7eVHUrTydi5WlfpFU5qx/jzd1c2aA//3Q9RpbzC8
   Q==;
X-CSE-ConnectionGUID: T8Y0ruBwRNaxBumragf3+w==
X-CSE-MsgGUID: 72AfeRMJQtqbI7UN3cIejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="84569103"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="84569103"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 10:06:02 -0800
X-CSE-ConnectionGUID: YQXmBd72SHu1SoNel6V9gw==
X-CSE-MsgGUID: HypUqcfAQqCMvXFitCLhhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="218241820"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 06 Mar 2026 10:05:59 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyZYj-000000002In-128R;
	Fri, 06 Mar 2026 18:05:57 +0000
Date: Fri, 6 Mar 2026 19:05:28 +0100
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] net/sched: do not reset queues in graft
 operations
Message-ID: <202603061942.KTg7xG4K-lkp@intel.com>
References: <20260306113402.435055-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306113402.435055-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-sched-do-not-reset-queues-in-graft-operations/20260306-205258
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260306113402.435055-1-edumazet%40google.com
patch subject: [PATCH net-next] net/sched: do not reset queues in graft operations
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260306/202603061942.KTg7xG4K-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603061942.KTg7xG4K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603061942.KTg7xG4K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: net/sched/sch_generic.c:1377 function parameter 'reset_needed' not described in 'dev_deactivate_many'
>> Warning: net/sched/sch_generic.c:1377 function parameter 'reset_needed' not described in 'dev_deactivate_many'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
