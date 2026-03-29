Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7AD165F16
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774755376; cv=none; b=EZ5K5vLHKGc29XoJqNsU622URlLJMsHXkaTxRqsTaahUbCf/ZW8XG/a+PelOALCLq95iy42QRiB0xHzRQTmPWDDLQCLqAoWiw73OQlKbL/HjjhoCp9+D4uY//tTmFiz+5QqVW0bCyAkAVn6d9qbIioOqqm6GNSQODqhFLHLiHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774755376; c=relaxed/simple;
	bh=9ytAeKE/UzFshfNCHXMHWpVFEfff5dpY5i6td80F2xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRrG3/Izzl6nFzsLLhi9loXZ9dSOVbvVk88wJuXL7j37Iswh8JXBbNzIqSYwn88KPOiy/rHUyEysKEL3Jy1S6YZkIbL+70Fcw9eynOjPhXISo+q0l5TIYv2pRQGRrVszG7tvrWvT4VHR1ztx77qm2Kq5ixZsT2Dg5y3r4nuNVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXuZwpdl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXuZwpdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774755375; x=1806291375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ytAeKE/UzFshfNCHXMHWpVFEfff5dpY5i6td80F2xg=;
  b=QXuZwpdlTerkISOOLx4XUOs1JHAP6Xe4AgVhk0fVNFrxTb6mT9KRTPir
   /gArLIkrOKRAR8eUtJ0DpoTUO0CS2gDa0ysJ8b+tQO0dvJ3C8T8WmgQDM
   P3sGbBjVrCJazQNsoNpT0ZEWpVuGAtcdJxqu0JjMS7vcBF79ptJh6mDrC
   Q/B7+wzYUGaI9835g3DOWLWyuLcMQRIUx0dp1YuIO0WJGmR/Eu0pyrz0P
   PZi+dHO6dR8Uzfh/cyQrzgxOdWSPCTNnVuFL7hV41rlvO63rS+BSjS2ub
   36UBbBEVcspEWckvi8q/d017jRzKxVfDMZgyIHbiBipJdKYNBLtcqnudY
   A==;
X-CSE-ConnectionGUID: k6o5B2+xRB2qKH2DMYylyg==
X-CSE-MsgGUID: F42SkCEzSzuUyP1gopIlgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75753743"
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="75753743"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 20:36:14 -0700
X-CSE-ConnectionGUID: f+eshzxOQVWnGfKu5XPiQA==
X-CSE-MsgGUID: m6ahOgrAT2ul745eGhzoRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,147,1770624000"; 
   d="scan'208";a="222386413"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 28 Mar 2026 20:36:12 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6gwb-000000007oz-3fPe;
	Sun, 29 Mar 2026 03:36:09 +0000
Date: Sun, 29 Mar 2026 05:36:06 +0200
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
Message-ID: <202603290553.sJzkZoGo-lkp@intel.com>
References: <20260327213441.3781433-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327213441.3781433-1-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tun-Ignore-tun-in-netdev_lock_pos/20260328-220059
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260327213441.3781433-1-kuniyu%40google.com
patch subject: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260329/202603290553.sJzkZoGo-lkp@intel.com/config)
compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260329/202603290553.sJzkZoGo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603290553.sJzkZoGo-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-gnu-ld: net/core/dev.o: in function `netdev_lock_pos':
   net/core/dev.c:540:(.text+0x8088): undefined reference to `tun_link_ops'
   aarch64-linux-gnu-ld: net/core/dev.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `tun_link_ops' which may bind externally can not be used when making a shared object; recompile with -fPIC
>> net/core/dev.c:540:(.text+0x8088): dangerous relocation: unsupported relocation
>> aarch64-linux-gnu-ld: net/core/dev.c:540:(.text+0x808c): undefined reference to `tun_link_ops'
   aarch64-linux-gnu-ld: net/core/dev.c:540:(.text+0x29d70): undefined reference to `tun_link_ops'
   aarch64-linux-gnu-ld: net/core/dev.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `tun_link_ops' which may bind externally can not be used when making a shared object; recompile with -fPIC
   net/core/dev.c:540:(.text+0x29d70): dangerous relocation: unsupported relocation
   aarch64-linux-gnu-ld: net/core/dev.c:540:(.text+0x29d74): undefined reference to `tun_link_ops'


vim +540 net/core/dev.c

   529	
   530	static inline unsigned short netdev_lock_pos(const struct net_device *dev)
   531	{
   532		unsigned short dev_type = dev->type;
   533		int i;
   534	
   535		for (i = 0; i < ARRAY_SIZE(netdev_lock_type); i++)
   536			if (netdev_lock_type[i] == dev_type)
   537				return i;
   538	
   539		/* the last key is used by default */
 > 540		WARN_ONCE(!netdev_is_tun(dev),
   541			  "netdev_lock_pos() could not find dev_type=%u\n", dev_type);
   542		return ARRAY_SIZE(netdev_lock_type) - 1;
   543	}
   544	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
