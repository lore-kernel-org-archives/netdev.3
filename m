Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62329AAEA;
	Sat, 13 Jun 2026 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781325272; cv=none; b=cuHkSRRQJF3lwRM1uClsA4pbVnMSmGMygj9PdVrvJb4znvCuR2VjN26Q3yi0aMSuxCPSQ4IDb+aEcPDPW8S/y9v+Dbnx3rENgNjGm8nfzkEijT2ihcAQUXdZQB6sHz6tZeubsXfN1f0gSwJEhvomdyoj8SBlkOGqe8Fh6AClDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781325272; c=relaxed/simple;
	bh=2oVlZD/eKm6fjGF9+21E5QiBwDrMzDrPZ4Ln5jJf898=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgVJMsYctdIZ6eZed0C91he2VIg0A4lXYxyPI3goXICj2iQB2yL2MH1VkHVX23WXMOoXueKOw1gyUL79/uB3PSanXgJCQI5gKHnDY5QNiHst9YBoenLP5U4VUUYM6IwDp6BUZyk5spVW+xy6KZD7udxn9oTiaD36mDtCYVb2a8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P70Dn95B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P70Dn95B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781325271; x=1812861271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oVlZD/eKm6fjGF9+21E5QiBwDrMzDrPZ4Ln5jJf898=;
  b=P70Dn95BGm+VyIfPaqaMkDNzpLji6apNN3OiL308UB2MDZbnKQJJpDY/
   xQixS6BIZItlbMCs6wM8NhDpaXBCBuKeWhiaf/pAZwGCMSPsuKFKGoc+q
   PXKZrvGWELCEB9EeRCgV/N5wv6yhOyxhEQVBN2uBqJz+C9nHWtBepvpYD
   Nyk83O+/RqAbPAVE1kLo3oLxebqqNtkTDrnbJ/hWgIVXPrHxYUuyWQ61H
   by8N4PUwD+KAcvy9RP2n0kARMxkqUzE7swhqk6+RRko7zIVAq4DDcZuMk
   EzuzVygwyjrXFn/mp8IQv1KvG15TdKNhjiXbegJD6jLCwwvS784fv8JxC
   Q==;
X-CSE-ConnectionGUID: 8TkN4igZSwCxPk5IyeWDyA==
X-CSE-MsgGUID: xxqJ8o7qQHKCijVNudAoFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="86002027"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="86002027"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 21:34:30 -0700
X-CSE-ConnectionGUID: RoHeqTSYRk+plyewKRAVaw==
X-CSE-MsgGUID: 1zmCHVafTx+PcyhpO4AIlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="277187557"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Jun 2026 21:34:24 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYG4Z-00000000Pfq-3Iuw;
	Sat, 13 Jun 2026 04:34:19 +0000
Date: Sat, 13 Jun 2026 12:34:18 +0800
From: kernel test robot <lkp@intel.com>
To: xur@google.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: correcting section tags for .init and .exit
 data/functions
Message-ID: <202606131256.P9NXJENl-lkp@intel.com>
References: <20260612162257.896792-1-xur@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612162257.896792-1-xur@google.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce]

url:    https://github.com/intel-lab-lkp/linux/commits/xur-google-com/net-correcting-section-tags-for-init-and-exit-data-functions/20260613-002737
base:   2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
patch link:    https://lore.kernel.org/r/20260612162257.896792-1-xur%40google.com
patch subject: [PATCH] net: correcting section tags for .init and .exit data/functions
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260613/202606131256.P9NXJENl-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 305faf498a4e0b52b40742c927af63ab2082e1a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260613/202606131256.P9NXJENl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606131256.P9NXJENl-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: tcpv6_init+0x74 (section: .text) -> mptcpv6_init (section: .init.text)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
