Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C33B8D45
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723058; cv=none; b=WASRPvoLJ2Yy6e08ndBN7jFiev4CWxAOZqRMgtotVpVEtVRLMk/gQOlJKcbNFcgyg4yn2w800O06/7Ud3qJDUgez26Mj+R7Y/HG237pHeP4ou6hfDJFgp37qG51FMis26AAWpUhCoAwmTCNQTUflX4jj8xzl56kPIAxPbg1AImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723058; c=relaxed/simple;
	bh=5wxwiq4VIobAfJHdecyamTEf+OoyWrzsHIBMAPVbEws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeMzisCN1bDx3xdy0Qptly3FUOwEc62eju26Lo7KLQWsMx9OEg/JS4BpMQ12rMOLApLy/xMbd/ZFc6oSD/nwVfV7o7jW3Um0RLyZ/Xz+vsaI8nlkOHAQBQsqFDyWvpZkH6a5Txc8oAGxNmh3/3WSljd5z4Ju1bxlJrMiqAoW1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlDB5Zha; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlDB5Zha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772723056; x=1804259056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5wxwiq4VIobAfJHdecyamTEf+OoyWrzsHIBMAPVbEws=;
  b=DlDB5ZhayGbplPB7Ckn1x/4Gi2u131W28b/NQvkYIkLYRYEYPM7kydVy
   jX953bht2LJv6avXbI76DsqVj2ghTzUL3faDotTbttVXYCZM3uFEDOAQW
   5KhRINvma9AETYcnvTvGUxqYhgFEMFdey/c2iukyfKO6Wakq/Pv969mei
   VIayT4katMFRnv5woJkXP5ROgAlN3v9BvRwSYkyO4UHMaDhpu9SqVzma9
   htaav3qZIvy/jB2TINxmgds3Co8/NGi8ea55KuI7v3/NmVPTymZxCgAlW
   08+XYcmJmlrn/PCtH27DUsW03GZa69+vw8wFpQOm2uf7uu6Ed6v4weZ5w
   Q==;
X-CSE-ConnectionGUID: nq4zPuaVQryNybL6w+FTFA==
X-CSE-MsgGUID: Z6ZVBiMWSwqC/ZllYxan1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85159657"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="85159657"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 07:04:15 -0800
X-CSE-ConnectionGUID: usvt2dM8TLWex7RgE5vOeA==
X-CSE-MsgGUID: j8oWaiXyQ1qKirqrmIGgMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="218703737"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Mar 2026 07:04:13 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyAFF-000000000nC-3E7y;
	Thu, 05 Mar 2026 15:04:09 +0000
Date: Thu, 5 Mar 2026 23:03:20 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 04/15] ipv4: Retire UDP-Lite.
Message-ID: <202603052252.qcNefHFm-lkp@intel.com>
References: <20260304193034.1870586-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304193034.1870586-5-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/udp-Make-udp-46-_seq_show-static/20260305-033454
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260304193034.1870586-5-kuniyu%40google.com
patch subject: [PATCH v1 net-next 04/15] ipv4: Retire UDP-Lite.
config: nios2-randconfig-r131-20260305 (https://download.01.org/0day-ci/archive/20260305/202603052252.qcNefHFm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603052252.qcNefHFm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603052252.qcNefHFm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/udp.c:3748:29: sparse: sparse: symbol 'udp_seq_ops' was not declared. Should it be static?
   net/ipv4/udp.c: note: in included file (through include/uapi/linux/swab.h, include/linux/swab.h, include/uapi/linux/byteorder/little_endian.h, ...):
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini
   arch/nios2/include/asm/swab.h:25:24: sparse: sparse: too many arguments for function __builtin_custom_ini

vim +/udp_seq_ops +3748 net/ipv4/udp.c

f44b1c515833c59 Aditi Ghag        2023-05-19  3747  
c3506372277779f Christoph Hellwig 2018-04-10 @3748  const struct seq_operations udp_seq_ops = {
a3d2599b24462c7 Christoph Hellwig 2018-04-10  3749  	.start		= udp_seq_start,
a3d2599b24462c7 Christoph Hellwig 2018-04-10  3750  	.next		= udp_seq_next,
a3d2599b24462c7 Christoph Hellwig 2018-04-10  3751  	.stop		= udp_seq_stop,
a3d2599b24462c7 Christoph Hellwig 2018-04-10  3752  	.show		= udp4_seq_show,
a3d2599b24462c7 Christoph Hellwig 2018-04-10  3753  };
73cb88ecb950ee6 Arjan van de Ven  2011-10-30  3754  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
