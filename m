Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652830CD89
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792130397; cv=none; b=jQafs9jJDp+8N9Z5xQ0JIVLCmnEUs6iFqFYvT57Yh0IFfan2QDU9eI22JjJ9xzUIvMAmUV0PHcOzeTeDjNNrcPGbtXu2ZdVBKzm4N2dT4aXNHFZPfpRVD/VBbTBiFNkksxaGPL4D1zXs6Ria1YFzhkenGezrJf7OlmJdEALfGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792130397; c=relaxed/simple;
	bh=ffT1uC8Tx5LWXnu0ZHL17b8Pkk4WgBDhMPPfK8nul2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2G85mVVRdI2/ASTw0+XxaZ8TFodgNyoMnuVn/hdwZ/n7yY/kTzMFJB/c0wgQxMSRCLF7IUQV6iiztx4HS/AdKcVOW4c9nJtSHFqAYAfS5UkJHxcxZTzA0/JTyZsqfzO9/TssqxwO9xbvvMHNDxE0ZAE5RUlXOwZRe9NbI4Uiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J56dckrd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J56dckrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792130395; x=1823666395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ffT1uC8Tx5LWXnu0ZHL17b8Pkk4WgBDhMPPfK8nul2M=;
  b=J56dckrdL0WJ54Cmmoxx4ljIF+4p5CJMzlRGUZxpu5uyWYf9+4QYkVGh
   OnsG4NAbef/81Sx6RR4BI/2zEH5/psUohSlq53p6NqShFrlehV75IiBY2
   c2VqbhCAc4CGB0bPvEpSrsi4ZaXAw+uoAKVKZ86QwH+wv685z974VsUKU
   BnE0qwi2X1BddbhhwT7ZculvXGGoWrIopKmVzppgdgirsIDNZwvIT33na
   Gz4YfwCx+cwZQnvUBKn4UV/kAqxcMkAmniJxs8AtXbCrzWUem2swV0R5G
   vm/xffaSOiMh8mRtuaCkn10ipsOYHUdNgAortze2Fo0Lq/R3KEMwxxi7z
   w==;
X-CSE-ConnectionGUID: 537kF1z1TqOqCPY41GSurw==
X-CSE-MsgGUID: NbWWu1RYTuueZ4LfwT0Viw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="777886"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="777886"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 22:59:54 -0700
X-CSE-ConnectionGUID: s6K5pGUBTr+Dk4bRSngZrw==
X-CSE-MsgGUID: 5Bg4tbOVRF6nQQ+UylFw9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2239417"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Oct 2026 22:59:52 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHayr-00000000Hha-3SjE;
	Fri, 16 Oct 2026 05:59:49 +0000
Date: Fri, 16 Oct 2026 13:59:41 +0800
From: kernel test robot <lkp@intel.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, dhowells@redhat.com,
	davem@davemloft.net, marc.dionne@auristor.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: Re: [PATCH] net/rxrpc: Simplify rxrpcpeerseq_next()
Message-ID: <202610161338.9QHAZ7bn-lkp@intel.com>
References: <20261015200115.59571-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015200115.59571-1-chelsyratnawat2001@gmail.com>

Hi Chelsy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master dhowells-fs/fscache-next dhowells-fs/keys-next v7.3-rc7 next-20261012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chelsy-Ratnawat/net-rxrpc-Simplify-rxrpcpeerseq_next/20261015-130115
base:   net-next/main
patch link:    https://lore.kernel.org/r/20261015200115.59571-1-chelsyratnawat2001%40gmail.com
patch subject: [PATCH] net/rxrpc: Simplify rxrpcpeerseq_next()
config: nios2-randconfig-1000-20261016 (https://download.01.org/0day-ci/archive/20261016/202610161338.9QHAZ7bn-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261016/202610161338.9QHAZ7bn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610161338.9QHAZ7bn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/rxrpc/proc.c: In function 'rxrpc_peer_seq_next':
>> net/rxrpc/proc.c:355:30: warning: unused variable 'n' [-Wunused-variable]
     355 |         unsigned int bucket, n;
         |                              ^


vim +/n +355 net/rxrpc/proc.c

bc0e7cf43370a8e David Howells   2018-10-15  351  
bc0e7cf43370a8e David Howells   2018-10-15  352  static void *rxrpc_peer_seq_next(struct seq_file *seq, void *v, loff_t *_pos)
bc0e7cf43370a8e David Howells   2018-10-15  353  {
bc0e7cf43370a8e David Howells   2018-10-15  354  	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
bc0e7cf43370a8e David Howells   2018-10-15 @355  	unsigned int bucket, n;
bc0e7cf43370a8e David Howells   2018-10-15  356  	unsigned int shift = 32 - HASH_BITS(rxnet->peer_hash);
bc0e7cf43370a8e David Howells   2018-10-15  357  	void *p;
bc0e7cf43370a8e David Howells   2018-10-15  358  
bc0e7cf43370a8e David Howells   2018-10-15  359  	if (*_pos >= UINT_MAX)
bc0e7cf43370a8e David Howells   2018-10-15  360  		return NULL;
bc0e7cf43370a8e David Howells   2018-10-15  361  
bc0e7cf43370a8e David Howells   2018-10-15  362  	bucket = *_pos >> shift;
bc0e7cf43370a8e David Howells   2018-10-15  363  
bc0e7cf43370a8e David Howells   2018-10-15  364  	p = seq_hlist_next_rcu(v, &rxnet->peer_hash[bucket], _pos);
bc0e7cf43370a8e David Howells   2018-10-15  365  	if (p)
bc0e7cf43370a8e David Howells   2018-10-15  366  		return p;
bc0e7cf43370a8e David Howells   2018-10-15  367  
bc0e7cf43370a8e David Howells   2018-10-15  368  	for (;;) {
bc0e7cf43370a8e David Howells   2018-10-15  369  		bucket++;
da940c1bf91ae9e Chelsy Ratnawat 2026-10-15  370  		*_pos = (bucket << shift) | 1;
bc0e7cf43370a8e David Howells   2018-10-15  371  
bc0e7cf43370a8e David Howells   2018-10-15  372  		if (bucket >= HASH_SIZE(rxnet->peer_hash)) {
bc0e7cf43370a8e David Howells   2018-10-15  373  			*_pos = UINT_MAX;
bc0e7cf43370a8e David Howells   2018-10-15  374  			return NULL;
bc0e7cf43370a8e David Howells   2018-10-15  375  		}
bc0e7cf43370a8e David Howells   2018-10-15  376  
da940c1bf91ae9e Chelsy Ratnawat 2026-10-15  377  		p = seq_hlist_start_rcu(&rxnet->peer_hash[bucket], 0);
bc0e7cf43370a8e David Howells   2018-10-15  378  		if (p)
bc0e7cf43370a8e David Howells   2018-10-15  379  			return p;
bc0e7cf43370a8e David Howells   2018-10-15  380  	}
bc0e7cf43370a8e David Howells   2018-10-15  381  }
bc0e7cf43370a8e David Howells   2018-10-15  382  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
