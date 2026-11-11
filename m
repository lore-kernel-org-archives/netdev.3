Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435071;
	b=o6TwBZ9gimrz4LWihiROuxwxQtT4EXseQx+U6SaSvPWpr5EmIQmAB5IwCk7Ca/XmJTdR
	 q1dn5YyXg2iqwEY5ZwdP7H2nOxpj54rd7ma+irE9ZnFIGoQCbu/DTzipUgXEiYaDuJubD
	 7awnArCUEW32fGWU8V5w4CxdDb3BDWAl6Iji3ho0spubbE7fAoZ3hJYgfyu6eOjKCZ4gb
	 uVOhzNjHj3kmGTvds0C3CVlKE1a/sKEJ2wDcUDhAXtsjvg07/Z/5xyzj9byzC+NFkLE+E
	 5IvHs6GupBDaMSe6h3m9kZMQN3g164duqg4etlUdFt47twNGz9vq1Ry6nnEndz8XFWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435071;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=B7bvA7Nju/BDOIqnk/HwpcSYfoLqp80hSTWFZMw6p4A=;
	b=TZ1HNw3tYrw5DhX2/MuBQpvZiAhdNqsXDFqB3r8CQ4L1SGTOkO3wK8jAPd/vUp6BPl24
	 66clX+eZ7Mj9uIkUdZSFJugdtcup1fPSi6byJIcF5cdleo3aeEQ1/bB831d1IwhjM2Rod
	 Z+sMWeBHidzDWXdGs7gyFw9yWEv3UqgxCKMFpopEbS7INonm/3d8hvYNprx/SPaJlR5ZT
	 EUzrFnxmNOJ9cYEzxgk8NkFGmCgx1hmgL1cBD7+eOa6K/802v35T6VowREziVV61NW3tf
	 qcAILHC2YDl0E32j6kkol0AkdRx2e4A4FTmkTAjeeNh5sL3YlLbWJqVMPav1xW9zWfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4Mict27;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271B606A324;
	Wed, 11 Nov 2026 22:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F271B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a4Mict27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794435070; x=1825971070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eedleuqF5kugMdESWoTLW26GExhkbpI898Czm7AFt8w=;
  b=a4Mict27tCl20JlFLDUpRoYbG8ktQW62NvXrZq45EYcNWsuH58+nXjNZ
   I4NbkdIs8Qqor5cjv34syMtYtplILix0GlkzBfiyDJ2x/sj3F/a7P18u7
   rcyIhmWvG/sI8TIec5d2D2sgJivZvkrE+/Sh0UcVklcZcRJ2spbvjLK5j
   SzOMpAUJT5IlQYj2iRkORbvCjNxwkYpdaE+G5QY+a0Aa76bWFLjwTHr+U
   SpIJd2snioj0G1imVlZcFEkv2RzYmBhv3A4er3bI8rO7cotQnX0CxcbZQ
   3AGlKtePtghP7r9ldAn9tMD0g1SwSqBHXYQQLkzxa7NSuldG5P2pwxGs/
   w==;
X-CSE-ConnectionGUID: bjxiJSu4Skig5lbb+INeeg==
X-CSE-MsgGUID: bVgArFVOQZmVb54xsz2eeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3112814"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3112814"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 14:11:09 -0800
X-CSE-ConnectionGUID: FWC1MddSSaaUikIEMciXUw==
X-CSE-MsgGUID: //nFZiDgQZqlx0MDR+ZoNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8500724"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 14:11:07 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRGX1-00000000ztr-2qYG;
	Wed, 11 Nov 2026 22:11:03 +0000
Date: Thu, 12 Nov 2026 06:10:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Yao <yaojun8558363@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org, idosch@nvidia.com,
	Jun Yao <yaojun8558363@gmail.com>
Subject: Re: [PATCH] xfrm: avoid stale tunnel pointers in deferred input
 callbacks
Message-ID: <202611120624.jcKHEACy-lkp@intel.com>
References: <20261111094629.230568-1-yaojun8558363@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111094629.230568-1-yaojun8558363@gmail.com>

Hi Jun,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on klassert-ipsec/master net/main net-next/main linus/master v7.4-rc2 next-20261110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jun-Yao/xfrm-avoid-stale-tunnel-pointers-in-deferred-input-callbacks/20261111-174629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20261111094629.230568-1-yaojun8558363%40gmail.com
patch subject: [PATCH] xfrm: avoid stale tunnel pointers in deferred input callbacks
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20261112/202611120624.jcKHEACy-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611120624.jcKHEACy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611120624.jcKHEACy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/sock.c:134:
   include/net/xfrm.h:777:9: error: call to undeclared function 'skb_ext_add'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     777 |         return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
         |                ^
   include/net/xfrm.h:777:26: error: use of undeclared identifier 'SKB_EXT_XFRM_TUNNEL'; did you mean 'SKB_GSO_UDP_TUNNEL'?
     777 |         return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
         |                                 ^~~~~~~~~~~~~~~~~~~
         |                                 SKB_GSO_UDP_TUNNEL
   include/linux/skbuff.h:697:2: note: 'SKB_GSO_UDP_TUNNEL' declared here
     697 |         SKB_GSO_UDP_TUNNEL = 1 << 10,
         |         ^
   In file included from net/core/sock.c:134:
>> include/net/xfrm.h:777:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct xfrm_tunnel_info *' [-Wint-conversion]
     777 |         return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/xfrm.h:783:9: error: call to undeclared function 'skb_ext_find'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     783 |         return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
         |                ^
   include/net/xfrm.h:783:27: error: use of undeclared identifier 'SKB_EXT_XFRM_TUNNEL'; did you mean 'SKB_GSO_UDP_TUNNEL'?
     783 |         return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
         |                                  ^~~~~~~~~~~~~~~~~~~
         |                                  SKB_GSO_UDP_TUNNEL
   include/linux/skbuff.h:697:2: note: 'SKB_GSO_UDP_TUNNEL' declared here
     697 |         SKB_GSO_UDP_TUNNEL = 1 << 10,
         |         ^
   In file included from net/core/sock.c:134:
>> include/net/xfrm.h:783:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'const struct xfrm_tunnel_info *' [-Wint-conversion]
     783 |         return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/xfrm.h:788:19: error: use of undeclared identifier 'SKB_EXT_XFRM_TUNNEL'; did you mean 'SKB_GSO_UDP_TUNNEL'?
     788 |         skb_ext_del(skb, SKB_EXT_XFRM_TUNNEL);
         |                          ^~~~~~~~~~~~~~~~~~~
         |                          SKB_GSO_UDP_TUNNEL
   include/linux/skbuff.h:697:2: note: 'SKB_GSO_UDP_TUNNEL' declared here
     697 |         SKB_GSO_UDP_TUNNEL = 1 << 10,
         |         ^
   7 errors generated.


vim +777 include/net/xfrm.h

   773	
   774	static inline struct xfrm_tunnel_info *
   775	xfrm_tunnel_info_add(struct sk_buff *skb)
   776	{
 > 777		return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
   778	}
   779	
   780	static inline const struct xfrm_tunnel_info *
   781	xfrm_tunnel_info(const struct sk_buff *skb)
   782	{
 > 783		return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
   784	}
   785	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
