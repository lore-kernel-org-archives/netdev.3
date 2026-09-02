Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DC49B216;
	Wed,  2 Sep 2026 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354382; cv=none; b=lxZQbJ5fkWKw+evJzLaqIbU13oi/xBRBz4OjuFNTLg/XxZ6N/lVTlAOR+NVMY5GNPY1Hn0jY0tbZpFy3Y+ekYJ8kf3wBokbLpiFF3jhFdbixuuZm0Umxw1/lPdEJdsIod0YjjoIQcHtlabrOoUmHMym5NZC/+B2dlJnxuci7k/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354382; c=relaxed/simple;
	bh=+bxePfsNVSHSfzlBF3Gm2+qPdi9o4VeP/MfRydTR3BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tisYFnmXqov97C6M0UrPqKoy5tHoPcQCG18V+k7w31Z5yPSfws61w6KbNBL4BcetzcxARgpY6G5AMGhcrAuKoi0J5sHpcJyfAOix0FbwFAQq/PXqHlRsvQK87x3VftZPmICP9qdinf+b5xWy0jqruEgkAsFjfPkU+2TkgA4Vamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjcZz021; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjcZz021"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788354380; x=1819890380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bxePfsNVSHSfzlBF3Gm2+qPdi9o4VeP/MfRydTR3BY=;
  b=gjcZz02129cvi1Y8dqqiCSzbsr95oOci9FWLqCinj6SzzGKVeM8DfZJ3
   LUrY0gDMd+gn4oV3oLSy5mCQv+MOSZA/vWl0DBNMwzR2WNugYYEt7UbOw
   lWjtVmHqqq8YfKYPaENUv2Hb230HbxTWcIDDVHtwpZQYzG+iRA1s9bSIk
   Yr6+hsjmqkYKpSMilU+LWWiQgcMO6o7SMN3iAxjcUiHG7bH41NZAeiIm8
   /hnShgm78jBzApp6DPY9hqKLM/VnhwlIJSimO2er0vCQiLac7tJxlgCZS
   taQLjQ956onKvllHfJB+2XwJiRiBMS5aEYWTQTnggZujbq9lxXxi77qI6
   Q==;
X-CSE-ConnectionGUID: DU7yH6xWTY6oO3PSoB97PA==
X-CSE-MsgGUID: yo1RMJeKRX6enF9tr/qKqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88687357"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88687357"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:06:20 -0700
X-CSE-ConnectionGUID: lVYCjvFGRDWgAblnbTd9OQ==
X-CSE-MsgGUID: sQ20yggwS6qFjAbH976YjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="268098503"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2026 06:06:17 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1kfO-000000002jG-30ZC;
	Wed, 02 Sep 2026 13:06:14 +0000
Date: Wed, 2 Sep 2026 21:06:09 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Elad Nachman <enachman@marvell.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: prestera: avoid overreading a short firmware tail
Message-ID: <202609022030.0pnwZKgS-lkp@intel.com>
References: <20260830142404.37663-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830142404.37663-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/net-prestera-avoid-overreading-a-short-firmware-tail/20260830-222403
base:   08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
patch link:    https://lore.kernel.org/r/20260830142404.37663-1-pengpeng%40iscas.ac.cn
patch subject: [PATCH] net: prestera: avoid overreading a short firmware tail
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260902/202609022030.0pnwZKgS-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609022030.0pnwZKgS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609022030.0pnwZKgS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/prestera/prestera_pci.c:603:18: error: call to undeclared function 'get_unaligned'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     603 |                 writel_relaxed(get_unaligned((u32 *)(buf + i)),
         |                                ^
   1 error generated.


vim +/get_unaligned +603 drivers/net/ethernet/marvell/prestera/prestera_pci.c

   589	
   590	static int prestera_ldr_send(struct prestera_fw *fw, const u8 *buf, size_t len)
   591	{
   592		size_t write_len = ALIGN(len, sizeof(u32));
   593		size_t i;
   594		int err;
   595	
   596		err = prestera_ldr_wait_buf(fw, write_len);
   597		if (err) {
   598			dev_err(fw->dev.dev, "failed wait for sending firmware\n");
   599			return err;
   600		}
   601	
   602		for (i = 0; i + sizeof(u32) <= len; i += sizeof(u32)) {
 > 603			writel_relaxed(get_unaligned((u32 *)(buf + i)),
   604				       prestera_ldr_wr_ptr(fw));
   605			prestera_ldr_wr_idx_move(fw, 4);
   606		}
   607		if (i < len) {
   608			u32 last = 0;
   609	
   610			memcpy(&last, buf + i, len - i);
   611			writel_relaxed(last, prestera_ldr_wr_ptr(fw));
   612			prestera_ldr_wr_idx_move(fw, 4);
   613		}
   614	
   615		prestera_ldr_wr_idx_commit(fw);
   616		return 0;
   617	}
   618	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
