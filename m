Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB823438B1
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339161; cv=none; b=gMLHgqj5ArBtAtSGTw1QoJVqnBB1++VAl9FB8ZwqcovfXTY1IpVjbB4qTfnn5hzNFcJ3h2pX7i1bsa8URpWh/S+7Bazm0fGhlSkJFemCcCZfFQJ7hPOtIDGyyMjFxGxbG5pPftBij+Mg5JrGVh2vohyEqvCSTHwSTcrxAdTWdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339161; c=relaxed/simple;
	bh=fB62E0OIGJkoODKj8OfLkWohj+7ux5Lo1J4Ll9O/2Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF352VVDHh6ldA0Ee+gjb7Vy2z1L1aX00tBtfaQI9XzYhQEX2mp9wHepduzBpDGGHbkfXkyfwsFCGoHybHTS7i1SpBSEvqplQP6gydPdD/1k00HY/oDbRbjfW8e4UCABpd85DeW8+9nCJ8L7uKNCnywlXp4AiNKRQNRPlPCNzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8TgVGya; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8TgVGya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779339160; x=1810875160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fB62E0OIGJkoODKj8OfLkWohj+7ux5Lo1J4Ll9O/2Kw=;
  b=O8TgVGyaRj3UppPk2t6ChCoolWbS2cxX3rKP72aiuJaKBycIOLZPBYoA
   BX5H+eB3bHSoKRFK174NpIN89tIXMswO19uxbj9aPR0vyGyMrX4bGXnFs
   MR1XoyDZHpZjHl5vSDn06SPPqkRT+/nbJwDQaLCXFiKaEoY4/Dfh/+EJL
   rM64LHvcqoRUgr6u95Y/dLNQ4bzZcnriEC9gZBNpVV2piWs947UUgn0e6
   2Qi3wNzxWK136QgVZ2Il1F1Cakycb5RePcLbF5DJLUYYxWqeM/ICsP3ny
   rUHdTf1QU+HKmXgpVVdmLwu9FkWaY+L+k5nSAg+8jwHp08X3hX9w8G58X
   Q==;
X-CSE-ConnectionGUID: q7Exyi9DSRm9/nPikfb8yw==
X-CSE-MsgGUID: nATaS9RiQh+ibG7tv5J16w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="82830366"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="82830366"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 21:52:39 -0700
X-CSE-ConnectionGUID: /D/HkRmxTeyI78Cdn0v9pw==
X-CSE-MsgGUID: FYGcMwYaQaK7q2hzrEVfGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="237393057"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 21:52:35 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPvOD-000000004Pl-3rvW;
	Thu, 21 May 2026 04:52:12 +0000
Date: Thu, 21 May 2026 12:51:12 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jayachandran <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v4] hsr: Allow to send a specific port and with
 HSR header
Message-ID: <202605211206.puPhEK7J-lkp@intel.com>
References: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9e0898f1c0f134c6bad146ca8578f73c3e40ac0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/hsr-Allow-to-send-a-specific-port-and-with-HSR-header/20260515-223023
base:   9e0898f1c0f134c6bad146ca8578f73c3e40ac0a
patch link:    https://lore.kernel.org/r/20260508-hsr_ptp-v4-1-aa19aa7c6a71%40linutronix.de
patch subject: [PATCH net-next v4] hsr: Allow to send a specific port and with HSR header
config: mips-randconfig-r123-20260516 (https://download.01.org/0day-ci/archive/20260521/202605211206.puPhEK7J-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605211206.puPhEK7J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605211206.puPhEK7J-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/hsr/hsr_device.c:242:42: sparse: sparse: restricted __be16 degrades to integer
>> net/hsr/hsr_device.c:243:39: sparse: sparse: restricted __be32 degrades to integer

vim +242 net/hsr/hsr_device.c

   223	
   224	static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
   225	{
   226		enum hsr_port_type tx_port = HSR_PT_NONE;
   227		struct hsr_priv *hsr = netdev_priv(dev);
   228		struct hsr_port *master;
   229		bool has_header = false;
   230	
   231		rcu_read_lock();
   232		master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
   233		if (!master)
   234			goto drop;
   235	
   236		skb->dev = master->dev;
   237		if (skb->len > ETH_HLEN * 2) {
   238			struct hsr_inline_header *hsr_opt;
   239	
   240			BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
   241			hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
 > 242			if (hsr_opt->eth_type == htons(ETH_P_1588) &&
 > 243			    hsr_opt->magic == htonl(HSR_INLINE_HDR)) {
   244				has_header = hsr_opt->hsr_hdr;
   245				tx_port = hsr_opt->tx_port;
   246				if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
   247					goto drop;
   248	
   249				skb_pull(skb, sizeof(struct hsr_inline_header));
   250				if (has_header)
   251					skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
   252				else
   253					skb_set_network_header(skb, ETH_HLEN);
   254			}
   255		}
   256	
   257		skb_reset_mac_header(skb);
   258		skb_reset_mac_len(skb);
   259		spin_lock_bh(&hsr->seqnr_lock);
   260		hsr_forward_skb(skb, master, tx_port, has_header);
   261		spin_unlock_bh(&hsr->seqnr_lock);
   262		rcu_read_unlock();
   263	
   264		return NETDEV_TX_OK;
   265	drop:
   266		rcu_read_unlock();
   267		dev_core_stats_tx_dropped_inc(dev);
   268		dev_kfree_skb_any(skb);
   269		return NETDEV_TX_OK;
   270	}
   271	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
