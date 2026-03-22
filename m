Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE830EF64;
	Sun, 22 Mar 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774169044; cv=none; b=nPiaHjrROrPZ2xBfypHFLTBFgc5muKJ93N9oZsRlSLcwYuc5BUCq/+QqEUHLwYIp+WkLSnmV57ys41kBpnGwKahQ1QyCACzeX7GsJb4RWl5EiuKLyUdr7laP4/IR622Ev/IkZjPn9M/ttyL2X2RKKKVFNbNjJEqcJK8gSl4JgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774169044; c=relaxed/simple;
	bh=SyMIigT+e2e9E37xK1DVsQ9UBFu+02X93Nc+ytohWXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srRCdphU6o+C4hhg2FmvBDo4c9ecl/8fkprS3USuR/HkY9yCFRO3z9MvXwpcYKp9eRyD74+rb37vmtzzH4rc9l4DuhNyWdiasE8D7CJZFr45JG4wyUeEBhTvkicAUwodMtYnMAmsficvMMw2dDV0Cyzqyrd+HaMUa1k3UB+/gqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DL6qab4H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DL6qab4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774169043; x=1805705043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SyMIigT+e2e9E37xK1DVsQ9UBFu+02X93Nc+ytohWXo=;
  b=DL6qab4HryaUUZypX9l2THFfbhWnQW9VJqGmdr9Qvcn9rx6f7f6u0jQ6
   NX3HhYAD3vA1O39WIAZQ2xUsaGD1U9MLo1v0lJPu4sL7NmszhYZpiUWo5
   qZPvZ3IwmB78epKcsFcwyg38303KzXECztbo+LZgf6lzxdQCCHLvGtfgc
   9+tD7sfHDzyJIfUZP079Ku+oDEiR1FhZF5zxBMBNX05aCYhefiSDJVAyN
   IwBVwLEqSukFjBDUyGYhlmi+4L5oPt8pOgySiVd3y0o9DGBe7qee9PnQn
   gCLe7VCg0o7zvogyRZphltSX8lS3h6ERFgsveHkOA7QC0JgbVm5c+Xqna
   Q==;
X-CSE-ConnectionGUID: fLsFoH5/Q4OGebDNyp9rEQ==
X-CSE-MsgGUID: Qa4G1aABR4GoD2F0uhlMDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="92579289"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="92579289"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 01:44:02 -0700
X-CSE-ConnectionGUID: SGU5imfxR3G586WO9zNpHg==
X-CSE-MsgGUID: B9BfFrloT6mtujDaTqK4yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="223704068"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 22 Mar 2026 01:44:00 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4EPc-000000001sX-3TgI;
	Sun, 22 Mar 2026 08:43:56 +0000
Date: Sun, 22 Mar 2026 16:43:44 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	linux-kernel@vger.kernel.org, leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: Re: [net-next v4 08/12] net: bnxt: Implement software USO
Message-ID: <202603221823.WbZUThzj-lkp@intel.com>
References: <20260320144141.260246-9-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320144141.260246-9-joe@dama.to>

Hi Joe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9f4960b94f1a044f76da98a765d6cbd294c22c92]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/net-tso-Introduce-tso_dma_map/20260322-071901
base:   9f4960b94f1a044f76da98a765d6cbd294c22c92
patch link:    https://lore.kernel.org/r/20260320144141.260246-9-joe%40dama.to
patch subject: [net-next v4 08/12] net: bnxt: Implement software USO
config: i386-randconfig-012-20260322 (https://download.01.org/0day-ci/archive/20260322/202603221823.WbZUThzj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603221823.WbZUThzj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603221823.WbZUThzj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c: In function 'bnxt_sw_udp_gso_xmit':
>> drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c:43:20: warning: variable 'last_unmap_addr' set but not used [-Wunused-but-set-variable]
      43 |         dma_addr_t last_unmap_addr = 0;
         |                    ^~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c:41:22: warning: variable 'last_unmap_len' set but not used [-Wunused-but-set-variable]
      41 |         unsigned int last_unmap_len = 0;
         |                      ^~~~~~~~~~~~~~


vim +/last_unmap_addr +43 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c

    33	
    34	netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
    35					 struct bnxt_tx_ring_info *txr,
    36					 struct netdev_queue *txq,
    37					 struct sk_buff *skb)
    38	{
    39		struct bnxt_sw_tx_bd *last_unmap_buf = NULL;
    40		unsigned int hdr_len, mss, num_segs;
  > 41		unsigned int last_unmap_len = 0;
    42		struct pci_dev *pdev = bp->pdev;
  > 43		dma_addr_t last_unmap_addr = 0;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
