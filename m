Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA147B425;
	Wed, 15 Jul 2026 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120011; cv=none; b=LQgdWw/SeECuukpW77Fy1odtuaSwvrqM4Rbc4BG1p1PMfq92l/1adiUfoK4efKuxxAQ0fLOqJX6FSHfg7DhUY1E5JTQmVvUOPaST5Hdk+ZXRDmKX85BPXCSXl5pj85Cz37rF25M//kMfq2/rPq1wVfTgXMMVXTJ7dR/vEfadA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120011; c=relaxed/simple;
	bh=o+8gjlkkIUbCquLzezvoIJqnERkBe2IcsrvkWGP4NNA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=enPXyiR1vmujfh9R0xk0ZqNzulVLCvBdaTynA8INpK86CyX1JdfM98kEp3YtYZTLCrXOXwlL1TPEDzEn/zvm0VS8RnZ005nNRnPc6sGGAGs0EA/IMVk9ajAjp+nqEC6AQDnHY9s2WtJRzzAROaZibNszXJ5CFDoSxF1AJKkNf4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=fMpWoh43; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="fMpWoh43"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2j8qNg1TZAuuoBuFwSmVDdooQbzuPXNTIeMajXTwQh0=; b=fMpWoh43dW0oiLVc5h0q/lxYvg
	JZLp0vpajZcawbfYhFtg2GdYanzOAgok90Lv6roEWBptUftVznC9uJZNgu+OnAnauEVQEeiQlocwe
	GbfhRaXGfbT0ZL/UezZB49LDTQVxApzwvUk8XYbZ30DICTt/KaakOVxv3gJ+BuxWSfYHvTVsfRfMH
	k6xUGXa/u+sNW4cI+EC/a8n54vpu3t5MDCRy0VVOlOL3s3WQk2k2LFSa1/S7Vt75Ep9cpFJlt+H4Z
	JeFKCvQZGjhPl2eLQfD8fjf5aOL41aA3vh8OQouK/iSfnKb7WN0e3V6E/dFIIC9vEVsmZtqGp7wzX
	NdAgT7YQ==;
Received: from [115.246.246.98] (port=16428 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wjz70-00000003gyD-1ffo;
	Wed, 15 Jul 2026 08:53:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 8F4D71A074AB;
	Wed, 15 Jul 2026 18:23:12 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id j6AoR9ENA7iZ; Wed, 15 Jul 2026 18:23:09 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id D8FF11A0738B;
	Wed, 15 Jul 2026 18:23:09 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id JRtNYSvA4aok; Wed, 15 Jul 2026 18:23:09 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B617D1A074AB;
	Wed, 15 Jul 2026 18:23:09 +0530 (IST)
Date: Wed, 15 Jul 2026 18:23:09 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: parvathi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>, 
	afd <afd@ti.com>, basharath <basharath@couthit.com>, 
	arnd <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	m-malladi <m-malladi@ti.com>, krishna <krishna@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1628011287.1652279.1784119989651.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260706091338.134754-1-pabeni@redhat.com>
References: <20260630124958.894360-4-parvathi@couthit.com> <20260706091338.134754-1-pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] net: ti: icssm-prueth: Support
 duplicate HW offload feature for HSR and PRP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC150 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Thread-Index: 8eRlRYgRYydSxPavBiZeI1p59ppDYA==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
> 
> This commit introduces hardware duplicate offload for HSR and PRP modes. It
> implements a common shared queue between the two ports, writing frames once
> to OCMC RAM and relying on the firmware to replicate the transmission.
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> index 2ab78a98f8568..cbe666a212c3b 100644
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> @@ -97,6 +125,17 @@ static void icssm_prueth_write_reg(struct prueth *prueth,
>>  static enum pruss_mem pruss_mem_ids[] = { PRUSS_MEM_DRAM0, PRUSS_MEM_DRAM1,
>>  					  PRUSS_MEM_SHRD_RAM2 };
>>  
>> +struct prp_txopt_rct {
>> +	__be16 sequence_nr;
>> +	__be16 lan_id_and_lsdu_size;
>> +	__be16 prp_suffix;
>> +};
> 
> [Severity: High]
> Does this structure definition need the __packed attribute?
> 
> This struct consists of three 16-bit fields but lacks the __packed attribute,
> so it inherits a 2-byte alignment requirement.  Later in
> icssm_prueth_tx_enqueue, a pointer to this structure is derived directly
> from skb_tail_pointer.
> 
> If an ethernet frame payload has an odd byte length, wouldn't casting and
> dereferencing this pointer cause an unaligned 16-bit memory access, resulting
> in hardware traps or panics on architectures that do not support it?

The __packed attribute is not needed as this will be handled by C packing rules. See feedback
from an earlier series: https://lore.kernel.org/all/20250708175301.599c82b8@kernel.org/

> 
> [ ... ]
>> @@ -549,15 +588,24 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac
>> *emac,
> [ ... ]
>> +	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
>> +				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
>> +
>> +	if (prueth_is_lre(prueth) && (emac->link || other_emac->link))
>> +		link_up = true;
> 
> [Severity: High]
> Could this logical OR cause the shared transmission queue to stall completely
> if only one of the slave links goes down?
> 
> If one port loses its link, its emac->link is 0, but the other active port
> will still evaluate link_up as true. The active port would continue sending
> duplicate frames to the shared queue.

No. emac->link only reflects the PHY carrier state and does not indicate whether the
firmware servicing the shared queue is running. When one PHY link goes down, the
corresponding firmware continues to consume descriptors and simply discards the frames.
Therefore, using OR here does not cause the shared transmission queue to stall.

> 
> [ ... ]
>> @@ -605,6 +659,29 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac
>> *emac,
> [ ... ]
>> +		if (free_blocks_other_port < free_blocks)
>> +			free_blocks = free_blocks_other_port;
>> +	}
> 
> [Severity: High]
> Following up on the link_up logic above, since the available queue space is
> bounded by the slowest reader here, wouldn't the inactive port's read pointer
> remain frozen?
> 
> This appears to exhaust the free_blocks pool, causing the active port to
> eventually spin and return -ENOBUFS permanently, defeating the redundancy.

The inactive port's rd_ptr does not remain frozen just because its PHY link is down.
The firmware continues advancing the read pointer while dropping the frames, so free_blocks
is not exhausted in this scenario. We confirmed this behavior by testing.

Unplugging one link does not stall transmission or lead to a permanent -ENOBUFS. A stall
occurs only if the firmware itself stops running, which is a different failure mode.

> 
> [ ... ]
>> +		} else {
>> +			/* Read PRP RCT to extract sequence number and LAN ID */
>> +			struct prp_txopt_rct *rct =
>> +				(struct prp_txopt_rct *)(skb_tail_pointer(skb) -
>> +							 ICSSM_LRE_TAG_SIZE);
>> +
>> +			if (rct->prp_suffix == htons(ETH_P_PRP)) {
> 
> [Severity: High]
> Is it safe to directly dereference rct->prp_suffix here?
> 
> As mentioned above regarding the struct definition, this might lead to an
> unaligned memory access on certain architectures. Perhaps using the
> get_unaligned_be16 helper would be safer here, or adding the __packed
> attribute to the structure definition.

The __packed attribute is not needed as this will be handled by C packing rules. See feedback
from an earlier series: https://lore.kernel.org/all/20250708175301.599c82b8@kernel.org/

> 
> [ ... ]
>> @@ -1341,18 +1516,30 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct
>> sk_buff *skb,
> [ ... ]
>> +	raw_spin_lock(lock_queue);
>> +	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
>> +	raw_spin_unlock(lock_queue);
> 
> [Severity: High]
> Does this need to use the irqsave variant to protect against cross-device
> deadlocks with netpoll?
> 
> The lre_host_queue_lock is shared between the two ports. If a hardirq
> preempts a CPU while it holds this lock during a transmission, and the
> interrupt handler invokes a printk that triggers netconsole over the second
> interface, netpoll might bypass the netif_tx_lock.
> 
> When the second interface calls into ndo_start_xmit, it would attempt to
> acquire the exact same lre_host_queue_lock, causing it to spin forever on
> the same CPU.
> --

We will address this in the next version

Thanks and Regards,
Parvathi.
