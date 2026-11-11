Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794432421;
	b=t9opjXmVJLCcEPPqMeajAThRQHR656nE3YTovYNV7SmzpgSUC5U38XKpYB6OwZW3Vc2F
	 jD5jzj+/ku0rSs93S0OeUS1bA6VyfQyqVvdghnD0gfbzeu2sLJX6aV6zhukpARmtAuYXD
	 q37Yz8rulWzuYqxMsDsCLuEtf0J2wUaUsHbudyem9T/PBMnf2E6s7n5EPWkm+40Mk8S/P
	 dlhIp22N9Je1cMzBnZ6atjhR9lhXxyrQZo9ZGoXZmZk3Dg++WZ9Q4+zNBN14pFkZ+QXXn
	 WGiq0YcRT0kIhwnme8cGbqyvU0L/jeSZ61DNuXVpeUdXD6C5aZ6oB76IfhNJVIWLrIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794432421;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qmzMLIvZ7smf+narAzjytGAazldlSomsPSAlkZFNulc=;
	b=LMHReDtBfti2xCkw+75QaW9zzlxnHPKLIWN/sFsIzJZfmhNrAqANQG7XFLDR37aNcvCh
	 Tf+X7+zM2jWgY3B4Sl/KtfYLHy1DvcRH2uYnDH5bo0b4V5XcPnciWrFut1vQMDpJGigux
	 PyspaCFQDYj6Kz5c43Lug57k2i6jW9DQDy28UoPj0sJIXzKdbVJiVypkuqWKPtpNmswdy
	 88VHgmpsRd5shPxnHncQtZbJC221CYWCrtG/p4qNTR5356DCQyTJFvvoDDdwOf5WZfcCj
	 WKdJfMVLICOMfjaA9NsKG5cRn3/jX1zjPB4S4UgfEV/S7/sYsxWJEBdIQWQFDb4pIdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fifOHr67;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D7606A321;
	Wed, 11 Nov 2026 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023D7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fifOHr67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794432421; x=1825968421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QvooamukB6dLXpxKs4gwsx2mS4fo83sCV47G3gexn70=;
  b=fifOHr67mes4CkI0CfSbUCoIyti6ntrtgL/9NQpkPLfXbc14N4c2o88x
   yEPOflQHsbbhS4pDGcEuOyPyieNccSPZ+09hvV+odym6kTn1TbNO8sP4+
   TmFuNCsbpgmYRsL7SizBTqN2u2TqZ7b6CAU5vTyQG9l+WkWX1ATDJbbAz
   qlsqacmNb1H65QxBI/Etcgz46x7EEyKqCB+uZHuZ83qOeZg3aXxIFII2Y
   g61NsYy/LpHuZ4siN3DsXO0egGCgOu8KSPje9k4o7g+KzlGQte+F8Eu3F
   OyI+osZ/OiNeP0SIHhx/DggTRt/TQFMWUwCD4zDuVeJiE7pWHC2YzFiuv
   Q==;
X-CSE-ConnectionGUID: 8g/GJGV7RjSdKMl+dotW6A==
X-CSE-MsgGUID: tyJNI4dtT+OHPLTBh1O/Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3219837"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3219837"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 13:27:01 -0800
X-CSE-ConnectionGUID: y+YSjkWNSHydpwcX7GiPYw==
X-CSE-MsgGUID: qBY9x3i4QfaSV++Y/CbwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8821606"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2026 13:26:58 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRFqI-00000000zmP-3f2T;
	Wed, 11 Nov 2026 21:26:54 +0000
Date: Thu, 12 Nov 2026 05:26:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Yao <yaojun8558363@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org, idosch@nvidia.com,
	Jun Yao <yaojun8558363@gmail.com>
Subject: Re: [PATCH] xfrm: avoid stale tunnel pointers in deferred input
 callbacks
Message-ID: <202611120519.EG3LbKfu-lkp@intel.com>
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
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20261112/202611120519.EG3LbKfu-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611120519.EG3LbKfu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611120519.EG3LbKfu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/sock.c:134:
   include/net/xfrm.h: In function 'xfrm_tunnel_info_add':
>> include/net/xfrm.h:777:16: error: implicit declaration of function 'skb_ext_add'; did you mean 'skb_ext_del'? [-Werror=implicit-function-declaration]
     777 |         return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
         |                ^~~~~~~~~~~
         |                skb_ext_del
>> include/net/xfrm.h:777:33: error: 'SKB_EXT_XFRM_TUNNEL' undeclared (first use in this function); did you mean 'DST_XFRM_TUNNEL'?
     777 |         return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
         |                                 ^~~~~~~~~~~~~~~~~~~
         |                                 DST_XFRM_TUNNEL
   include/net/xfrm.h:777:33: note: each undeclared identifier is reported only once for each function it appears in
   include/net/xfrm.h: In function 'xfrm_tunnel_info':
>> include/net/xfrm.h:783:16: error: implicit declaration of function 'skb_ext_find'; did you mean 'skb_ext_copy'? [-Werror=implicit-function-declaration]
     783 |         return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
         |                ^~~~~~~~~~~~
         |                skb_ext_copy
   include/net/xfrm.h:783:34: error: 'SKB_EXT_XFRM_TUNNEL' undeclared (first use in this function); did you mean 'DST_XFRM_TUNNEL'?
     783 |         return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
         |                                  ^~~~~~~~~~~~~~~~~~~
         |                                  DST_XFRM_TUNNEL
   include/net/xfrm.h: In function 'xfrm_tunnel_info_clear':
   include/net/xfrm.h:788:26: error: 'SKB_EXT_XFRM_TUNNEL' undeclared (first use in this function); did you mean 'DST_XFRM_TUNNEL'?
     788 |         skb_ext_del(skb, SKB_EXT_XFRM_TUNNEL);
         |                          ^~~~~~~~~~~~~~~~~~~
         |                          DST_XFRM_TUNNEL
   cc1: some warnings being treated as errors


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
