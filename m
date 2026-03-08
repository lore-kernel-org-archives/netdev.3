Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43B262BD
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772947041; cv=none; b=ZDcHvnKaRv9+0DjZO70fOwOiNmW1xIZptMAjOME5iVqE6Nq8cqAVulERIPVaGInRiosnq06jhBNfGvADJMoB4Y9VPe2j9G/EP7oZMgd84k0mwzjPrrHkP8+qtIqEEKPV8GYNzlZjCgdn6zPJg5RDn8AivAoHcj4/VZ0CavhO0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772947041; c=relaxed/simple;
	bh=S6zKKAv1818oQHC6PFXV0kOBnRmUIUTHWiAT2Z/rBa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaNMpVu/wXTtlnr560nbFf4ktptSN2OZLUBw3/omjJLwcPIQmr0vOhyBpYGEu1z7+PyN6Sdub5wV8soBMfwvtlh4K2joC4qMo4giMsgGL899bG9AqRM1kGuoJy9+0XPCFaHqVrpCQzAzScYvCmzJGYdHWzFMovYu8aMS6dNwuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMtdTDnt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMtdTDnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772947040; x=1804483040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6zKKAv1818oQHC6PFXV0kOBnRmUIUTHWiAT2Z/rBa4=;
  b=kMtdTDntjW35VZ2xntG+mam4AaWXmy4HavpQt88btMnKL/qJdXw5Fa5E
   8EMp+nSg9HcgS+QqY2I7I6sfMqVYvhZFlyNpHW0quouCcR7NKU8O8+6rf
   4ODEj2/4DYcBfgvBfcYosj4y6qXb6TTFLNkcUv4v/nyqcJCOFK+qCm7I4
   xnhLKSgr9GeE5F5ePlF6DHLpwdZHDA904rnVWzNDCFKWo547XZC0zcv5D
   9jhjB7vZcgUvc34bMbfyYXOqWPHzlS+hOlyrkHQU0eSSSjo9TR4qUdxno
   nNT0hQn1znqHlqiEfMf9cOOb3AsMfY9CNft3Rb/LQGxN1tKcot/ClECWT
   w==;
X-CSE-ConnectionGUID: Nwmn9FqyQ5eicN5osIQc9Q==
X-CSE-MsgGUID: ZgFM75OJSH6DAFhCjjqr2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73201016"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="73201016"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 21:17:20 -0800
X-CSE-ConnectionGUID: tN1zS45cRTqI+UbbVAkkuQ==
X-CSE-MsgGUID: u2xvDk1nSqm0ogC0ydFr4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="257332236"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 07 Mar 2026 21:17:17 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz6Vu-000000002dF-2haZ;
	Sun, 08 Mar 2026 05:17:14 +0000
Date: Sun, 8 Mar 2026 06:17:05 +0100
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: Re: [PATCH net] page_pool: store detach_time as ktime_t to avoid
 false-negatives
Message-ID: <202603080604.nGijPf4B-lkp@intel.com>
References: <20260307204022.1897614-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307204022.1897614-1-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/page_pool-store-detach_time-as-ktime_t-to-avoid-false-negatives/20260308-044057
base:   net/main
patch link:    https://lore.kernel.org/r/20260307204022.1897614-1-kuba%40kernel.org
patch subject: [PATCH net] page_pool: store detach_time as ktime_t to avoid false-negatives
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260308/202603080604.nGijPf4B-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080604.nGijPf4B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080604.nGijPf4B-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/page_pool_user.c: In function 'page_pool_nl_fill':
>> net/core/page_pool_user.c:248:26: error: implicit declaration of function 'ktime_to_seconds'; did you mean 'ktime_get_seconds'? [-Wimplicit-function-declaration]
     248 |                          ktime_to_seconds(pool->user.detach_time)))
         |                          ^~~~~~~~~~~~~~~~
         |                          ktime_get_seconds


vim +248 net/core/page_pool_user.c

   214	
   215	static int
   216	page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
   217			  const struct genl_info *info)
   218	{
   219		size_t inflight, refsz;
   220		unsigned int napi_id;
   221		void *hdr;
   222	
   223		hdr = genlmsg_iput(rsp, info);
   224		if (!hdr)
   225			return -EMSGSIZE;
   226	
   227		if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id))
   228			goto err_cancel;
   229	
   230		if (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
   231		    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
   232				pool->slow.netdev->ifindex))
   233			goto err_cancel;
   234	
   235		napi_id = pool->p.napi ? READ_ONCE(pool->p.napi->napi_id) : 0;
   236		if (napi_id_valid(napi_id) &&
   237		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, napi_id))
   238			goto err_cancel;
   239	
   240		inflight = page_pool_inflight(pool, false);
   241		refsz =	PAGE_SIZE << pool->p.order;
   242		if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT, inflight) ||
   243		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
   244				 inflight * refsz))
   245			goto err_cancel;
   246		if (pool->user.detach_time &&
   247		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
 > 248				 ktime_to_seconds(pool->user.detach_time)))
   249			goto err_cancel;
   250	
   251		if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
   252			goto err_cancel;
   253	
   254		genlmsg_end(rsp, hdr);
   255	
   256		return 0;
   257	err_cancel:
   258		genlmsg_cancel(rsp, hdr);
   259		return -EMSGSIZE;
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
