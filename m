Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D1541445;
	Fri, 16 Oct 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170401; cv=none; b=mLOmD5+HwEbeAqGvdo+O4JWOrZ7mZji6QJngIQ78xYWb7/3B3HjhsMC8rOpvk2d8tBNnjKkq4AoDRn+VvdpNMseJWHSNJ1yKR/mhQfVcN1g1tn0IdUe6UibGE/qoPFO7S8vxxPYIe8BqtUL3zHVFwwk33Uku8CeBRjPf4S0ISQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170401; c=relaxed/simple;
	bh=QATHSqJJztJnV0paSL0pCTmsmHHABXkfxxSjlOcycNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so8voWn+2/bDKtirNlGcUykbodPrr/MD8Lu7S6veKgkmLkfh6onXm3+LbRBPR+TJmgxR6YJ/y1aw/rK9qGDrzEryglzUhgRCTt/E/PvXM3YzShuSic0gbYnn+VKD+yEmBVn4sUrAV/e6Kr4I8MUzXwwRGrvQayaSi+Ksgm2/M1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPE/DYLq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPE/DYLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792170397; x=1823706397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QATHSqJJztJnV0paSL0pCTmsmHHABXkfxxSjlOcycNI=;
  b=RPE/DYLquV6X7xwPiucytVOQkwxZ/9TwQS1A0UE70Zghoshsx1+MGwmO
   Xg18bLQRXYK1i4h2UL0JI7D96iSHA0eKD8CPGWfKugSecpGEB5XKwho/h
   qCQ6qygKs33IwWXWqpr1g720P6zGBF9hvDsFhhJ7M6NwWoEv66lIEz9a5
   gHifN1tMsnxZnP4QOqiC7h3Pzac89pmR9ZDiGMn0fyCYR4ajaIl3clNHm
   wIahlEtgnVKsnw/SWPJ6Y/3Hjw3X4AElVDd0Lpx9WlmNyi7JHuhv4/5AR
   HQsq6Xf8T/0oEkbVpgudf2RDKBCRh2DTztlrE9gRFGQXCDohTWOhdOPgn
   g==;
X-CSE-ConnectionGUID: QmkOLJNkTzWrpi5BbMuHfg==
X-CSE-MsgGUID: 1FmeIew/TpSBUgUtMT9rWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="977157"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="977157"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:06:36 -0700
X-CSE-ConnectionGUID: y1tY0Dv3QrOetd2Xls98bg==
X-CSE-MsgGUID: 9N7QS/2nTK+WtvdFc6wO3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2366450"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2026 10:06:32 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHlO1-00000000ISY-14Lc;
	Fri, 16 Oct 2026 17:06:29 +0000
Date: Sat, 17 Oct 2026 01:05:42 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Chao <liuc63@xiaopeng.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: t7xx: fix tx buffer release loop on invalid
 skb
Message-ID: <202610170128.gs8DZ6Gj-lkp@intel.com>
References: <20261016041156.2295670-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016041156.2295670-1-liuc63@xiaopeng.com>

Hi Liu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main wireless-next/main wireless/main linus/master v7.3-rc7 next-20261016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Chao/net-wwan-t7xx-fix-tx-buffer-release-loop-on-invalid-skb/20261016-121156
base:   net-next/main
patch link:    https://lore.kernel.org/r/20261016041156.2295670-1-liuc63%40xiaopeng.com
patch subject: [PATCH] net: wwan: t7xx: fix tx buffer release loop on invalid skb
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261017/202610170128.gs8DZ6Gj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261017/202610170128.gs8DZ6Gj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610170128.gs8DZ6Gj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c: In function 't7xx_dpmaif_release_tx_buffer':
>> drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c:102:25: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     102 |                         if (!cur_drb_skb->is_msg)
         |                         ^~
   drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c:106:33: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     106 |                                 if (!FIELD_GET(DRB_HDR_CONT, le32_to_cpu(cur_drb->header))) {
         |                                 ^~


vim +/if +102 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c

d642b012df70a76 Haijun Liu 2022-05-06   79  
d642b012df70a76 Haijun Liu 2022-05-06   80  static unsigned int t7xx_dpmaif_release_tx_buffer(struct dpmaif_ctrl *dpmaif_ctrl,
d642b012df70a76 Haijun Liu 2022-05-06   81  						  unsigned int q_num, unsigned int release_cnt)
d642b012df70a76 Haijun Liu 2022-05-06   82  {
d642b012df70a76 Haijun Liu 2022-05-06   83  	struct dpmaif_tx_queue *txq = &dpmaif_ctrl->txq[q_num];
d642b012df70a76 Haijun Liu 2022-05-06   84  	struct dpmaif_callbacks *cb = dpmaif_ctrl->callbacks;
d642b012df70a76 Haijun Liu 2022-05-06   85  	struct dpmaif_drb_skb *cur_drb_skb, *drb_skb_base;
d642b012df70a76 Haijun Liu 2022-05-06   86  	struct dpmaif_drb *cur_drb, *drb_base;
d642b012df70a76 Haijun Liu 2022-05-06   87  	unsigned int drb_cnt, i, cur_idx;
d642b012df70a76 Haijun Liu 2022-05-06   88  	unsigned long flags;
d642b012df70a76 Haijun Liu 2022-05-06   89  
d642b012df70a76 Haijun Liu 2022-05-06   90  	drb_skb_base = txq->drb_skb_base;
d642b012df70a76 Haijun Liu 2022-05-06   91  	drb_base = txq->drb_base;
d642b012df70a76 Haijun Liu 2022-05-06   92  
d642b012df70a76 Haijun Liu 2022-05-06   93  	spin_lock_irqsave(&txq->tx_lock, flags);
d642b012df70a76 Haijun Liu 2022-05-06   94  	drb_cnt = txq->drb_size_cnt;
d642b012df70a76 Haijun Liu 2022-05-06   95  	cur_idx = txq->drb_release_rd_idx;
d642b012df70a76 Haijun Liu 2022-05-06   96  	spin_unlock_irqrestore(&txq->tx_lock, flags);
d642b012df70a76 Haijun Liu 2022-05-06   97  
d642b012df70a76 Haijun Liu 2022-05-06   98  	for (i = 0; i < release_cnt; i++) {
d642b012df70a76 Haijun Liu 2022-05-06   99  		cur_drb = drb_base + cur_idx;
d642b012df70a76 Haijun Liu 2022-05-06  100  		if (FIELD_GET(DRB_HDR_DTYP, le32_to_cpu(cur_drb->header)) == DES_DTYP_PD) {
d642b012df70a76 Haijun Liu 2022-05-06  101  			cur_drb_skb = drb_skb_base + cur_idx;
d642b012df70a76 Haijun Liu 2022-05-06 @102  			if (!cur_drb_skb->is_msg)
d642b012df70a76 Haijun Liu 2022-05-06  103  				dma_unmap_single(dpmaif_ctrl->dev, cur_drb_skb->bus_addr,
d642b012df70a76 Haijun Liu 2022-05-06  104  						 cur_drb_skb->data_len, DMA_TO_DEVICE);
d642b012df70a76 Haijun Liu 2022-05-06  105  
d642b012df70a76 Haijun Liu 2022-05-06  106  				if (!FIELD_GET(DRB_HDR_CONT, le32_to_cpu(cur_drb->header))) {
d642b012df70a76 Haijun Liu 2022-05-06  107  					if (!cur_drb_skb->skb) {
d642b012df70a76 Haijun Liu 2022-05-06  108  						dev_err(dpmaif_ctrl->dev,
d642b012df70a76 Haijun Liu 2022-05-06  109  							"txq%u: DRB check fail, invalid skb\n", q_num);
35baede15130184 Liu Chao   2026-10-16  110  					} else {
d642b012df70a76 Haijun Liu 2022-05-06  111  						dev_kfree_skb_any(cur_drb_skb->skb);
d642b012df70a76 Haijun Liu 2022-05-06  112  					}
35baede15130184 Liu Chao   2026-10-16  113  				}
d642b012df70a76 Haijun Liu 2022-05-06  114  
d642b012df70a76 Haijun Liu 2022-05-06  115  			cur_drb_skb->skb = NULL;
d642b012df70a76 Haijun Liu 2022-05-06  116  		}
d642b012df70a76 Haijun Liu 2022-05-06  117  
d642b012df70a76 Haijun Liu 2022-05-06  118  		spin_lock_irqsave(&txq->tx_lock, flags);
d642b012df70a76 Haijun Liu 2022-05-06  119  		cur_idx = t7xx_ring_buf_get_next_wr_idx(drb_cnt, cur_idx);
d642b012df70a76 Haijun Liu 2022-05-06  120  		txq->drb_release_rd_idx = cur_idx;
d642b012df70a76 Haijun Liu 2022-05-06  121  		spin_unlock_irqrestore(&txq->tx_lock, flags);
d642b012df70a76 Haijun Liu 2022-05-06  122  
d642b012df70a76 Haijun Liu 2022-05-06  123  		if (atomic_inc_return(&txq->tx_budget) > txq->drb_size_cnt / 8)
d642b012df70a76 Haijun Liu 2022-05-06  124  			cb->state_notify(dpmaif_ctrl->t7xx_dev, DMPAIF_TXQ_STATE_IRQ, txq->index);
d642b012df70a76 Haijun Liu 2022-05-06  125  	}
d642b012df70a76 Haijun Liu 2022-05-06  126  
d642b012df70a76 Haijun Liu 2022-05-06  127  	if (FIELD_GET(DRB_HDR_CONT, le32_to_cpu(cur_drb->header)))
d642b012df70a76 Haijun Liu 2022-05-06  128  		dev_err(dpmaif_ctrl->dev, "txq%u: DRB not marked as the last one\n", q_num);
d642b012df70a76 Haijun Liu 2022-05-06  129  
d642b012df70a76 Haijun Liu 2022-05-06  130  	return i;
d642b012df70a76 Haijun Liu 2022-05-06  131  }
d642b012df70a76 Haijun Liu 2022-05-06  132  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
