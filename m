Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0B3B2D0A;
	Thu, 16 Jul 2026 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196580; cv=none; b=A1F+fHF75MeRQHqRM9EgrXhywwYaCZgY9RA73b7Ib3Vtg6sU8kObenk3f+1jRtb25Sw+c3CgY+GmsJ0G3JvkigQ223g0FOqtxCFtzOQqs1oB6ykF9IszGDgj4ymIs0uJIVBkJE4DmOBxabKq/s8OQvNNsvcNGNrw8ruRgb1Qfiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196580; c=relaxed/simple;
	bh=sMiTwCTRMY23bbD7HyzUawalPOrNsgJdKKL7Fv5F+wc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Z46hgtwXKgYOaUWfrFoybItdFoNyN6ALj44pGI0Bw9c5sfWZFEtStgOyFlg7yuy+KEJqxDe/BrhN1q/FkT8b9HQtFdlVBeANbm4yes1n59o77nYbuZJtWyV295qPnsTjCJ6Z4Gy/kLJPswP37I/vewsHGpCHSyoghSZ0SkL4Xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=si4OSZjV; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="si4OSZjV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RZF8J3EVWRTD4m8geaWRGNcSfY2UjAL6ypi6vxz1ZiM=; b=si4OSZjVuV3aO1+Bf5Kg9CiEPo
	SbrxmmulHEijVPrF3cCaxLBoXxjgOupitdUUOxucP51SXWC5QRDmahRjrAvAzPpOMX+RiQLMvb/k9
	u/ISFkfaM/C+cRpgOoWhMq2gddc4+uTlvz44VM54wEaDzVh3rtTE0DN7YrqI6WFXpqgfDoHaQ3bq0
	/nL/NOKD1CEYqc4R3aOITFTuw+kA/HEVMchadkZUZE5h2NqcrErOSBUbhKskef486rzdPr+xvqXVb
	L3I87URz8DKVZtQ77GyEhgI8hAQ49mtYKX35NGiDBYFqIkYSyoFmGAaa01vUs/scy+6ax0ptd7WVc
	3kOlDjhQ==;
Received: from [115.246.246.98] (port=53693 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wkJ26-00000004Z2G-21xZ;
	Thu, 16 Jul 2026 06:09:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 2A2621AE3058;
	Thu, 16 Jul 2026 15:39:26 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id JCZ0B0y1mChg; Thu, 16 Jul 2026 15:39:22 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id CCBC61AE6C11;
	Thu, 16 Jul 2026 15:39:22 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id aaHAZZhn33uX; Thu, 16 Jul 2026 15:39:22 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id A6D771AE3058;
	Thu, 16 Jul 2026 15:39:22 +0530 (IST)
Date: Thu, 16 Jul 2026 15:39:22 +0530 (IST)
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
Message-ID: <902430959.1662289.1784196562619.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260706091328.134740-1-pabeni@redhat.com>
References: <20260630124958.894360-3-parvathi@couthit.com> <20260706091328.134740-1-pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] net: ti: icssm-prueth: Add priority
 based RX IRQ handlers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC150 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Add priority based RX IRQ handlers
Thread-Index: q3fiJzThNFJaNfpR71Y/scOAQ6P02g==
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
> net: ti: icssm-prueth: Add priority based RX IRQ handlers
> 
> This patch adds support for priority based interrupt handling for the STP/
> RSTP Switch, HSR and PRP protocols along with extra logic to address first
> come first served to avoid port dominance. The driver will read the RX HW
> timestamp from the frame to achieve wire-arrival ordering.
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> [ ... ]
>> @@ -1188,26 +1188,26 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>>  	/* disable the mac port */
>>  	icssm_prueth_port_enable(emac, false);
>>  
>> +	netif_stop_queue(ndev);
>> +
>>  	/* stop PHY */
>>  	phy_stop(emac->phydev);
>>  
>> -	napi_disable(&emac->napi);
>>  	hrtimer_cancel(&emac->tx_hrtimer);
>>  
> [ ... ]
>>  	/* stop the PRU */
>>  	if (!PRUETH_IS_EMAC(prueth))
>>  		icssm_prueth_sw_shutdown_prus(emac, ndev);
>>  
>>  	if (prueth_is_lre(prueth))
>>  		icssm_prueth_lre_cleanup(prueth);
> 
> [Severity: High]
> This is a pre-existing issue, but is the LRE duplicate detection timer
> prematurely canceled when a single port goes down?
> 
> In icssm_emac_ndo_stop, icssm_prueth_lre_cleanup is called unconditionally
> when any interface is brought down.
> 
> If one port in the HSR/PRP bridge goes down while the other remains active,
> this cancels the shared tbl_check_timer, potentially causing duplicate
> frames to stop being detected and dropped by the hardware.
> 

We will address this in the next version.

>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
>> @@ -0,0 +1,286 @@
> [ ... ]
>> +static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
>> +					       int quota, u8 qid1, u8 qid2)
>> +{
> [ ... ]
>> +		if ((*pkt_info_p).length < EMAC_MIN_PKTLEN) {
>> +			/* Undersized frame: firmware should have filtered
>> +			 * these before they reach the host queue. Advance
>> +			 * the read pointer to skip it.
>> +			 */
>> +			update_rd_ptr = *bd_wr_ptr_p;
>> +			ndevstats_p->rx_length_errors++;
> 
> [Severity: High]
> This is a pre-existing issue, but does this error path flush the entire
> pending RX queue?
> 
> When the driver detects an undersized or oversized packet, it attempts to
> skip it by updating the read pointer. However, setting update_rd_ptr to
> *bd_wr_ptr_p appears to assign the hardware's write pointer (the very end of
> the queue), rather than advancing by one descriptor.
> 
> Could this discard all pending descriptors instead of just the malformed one?
> 

Yes, it flushes the pending queue. This behavior is pre-existing for the plain
EMAC RX path. Since it's not something introduced by these patches, we'd like
to evaluate it and fix it separately rather than bundle it into this series.

> [Severity: High]
> Does this introduce a race condition on the network statistics?
> 
> This patch introduces split NAPI polling with separate priority threads
> (napi_hpq and napi_lpq) that process the high and low priority queues across
> both physical ports. These NAPI instances can be scheduled on different CPUs
> concurrently.
> 
> Both instances invoke icssm_prueth_common_emac_rx_packets, which updates raw
> unsigned long statistics like ndevstats_p->rx_length_errors (and 64-bit
> stats like emac->stats.rx_bytes in icssm_emac_rx_packet) using += without
> atomic instructions or locks.
> 
> On 32-bit platforms, could this cause lost updates for concurrent writers, or
> torn reads when read by ndo_get_stats64?
> 

We are in the process of reviewing this comment and checking the statistics update
path with the split NAPI polling changes. We will incorporate any necessary updates
in the next version of the patch series.

>> +		} else if ((*pkt_info_p).length > EMAC_MAX_FRM_SUPPORT) {
>> +			/* Oversized frame: firmware should have filtered
>> +			 * these before they reach the host queue. Advance
>> +			 * the read pointer to skip it.
>> +			 */
>> +			update_rd_ptr = *bd_wr_ptr_p;
>> +			ndevstats_p->rx_length_errors++;
>> +		} else {
>> +			update_rd_ptr = *bd_rd_ptr_p;
>> +			ret = icssm_emac_rx_packet(emac_p, &update_rd_ptr,
>> +						   pkt_info_p, rxqueue_p);
>> +			if (ret)
>> +				return used;
> 
> [Severity: High]
> This is a pre-existing issue, but does a memory allocation failure in this RX
> path cause a permanent RX queue stall?
> 
> If icssm_emac_rx_packet fails to allocate an SKB, it returns -ENOMEM. The
> driver immediately aborts the NAPI polling loop without updating the hardware
> read pointer or consuming the packet.
> 
> Because it returns used (which is less than budget), it triggers
> napi_complete_done() which re-enables the RX interrupt. Since the packet is
> still pending in the hardware queue, the interrupt fires again immediately in
> an infinite loop.
> 

This appears to be a pre-existing issue in the RX path and is not introduced by
this patch series. We'll investigate the reported behavior separately and address
it in a dedicated patch series if changes are required.

>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
>> @@ -152,6 +152,14 @@ static void icssm_prueth_lre_protocol_init(struct prueth
>> *prueth)
>>  	       dram1 + ICSS_LRE_SUP_ADDR_LOW);
>>  }
>>  
>> +static void icssm_prueth_lre_config_packet_timestamping(struct prueth *prueth)
>> +{
>> +	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
>> +
>> +	writeb(1, sram + ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET);
>> +	writeb(1, sram + ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET);
>> +}
>> +
> [ ... ]
>> @@ -202,6 +210,11 @@ void icssm_prueth_lre_config(struct prueth *prueth)
>>  	icssm_prueth_lre_init(prueth);
>>  	icssm_prueth_lre_dbg_init(prueth);
>>  	icssm_prueth_lre_protocol_init(prueth);
>> +	/* Enable per-packet timestamping so the driver can order
>> +	 * received frames by arrival time across the two slave ports.
>> +	 */
>> +	icssm_prueth_lre_config_packet_timestamping(prueth);
>> +
>>  }
> 
> [Severity: High]
> Does this fail to enable hardware timestamping in Switch mode?
> 
> The patch introduces timestamp-based packet ordering for Switch, HSR, and PRP
> modes, requiring configuration via ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET and
> ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET.
> 
> However, icssm_prueth_lre_config_packet_timestamping is only called from
> icssm_prueth_lre_config, which is gated by prueth_is_lre() (only true for HSR
> and PRP).
> 
> In Switch mode, these registers appear to never be written, potentially
> leaving timestamps disabled in firmware and breaking the wire-arrival
> ordering logic.
> 

We will address this in the next version.

> [Severity: High]
> This is a pre-existing issue, but are the dynamically allocated FDB learning
> work items tracked for cleanup?
> 
> When learning a new source MAC address in icssm_prueth_sw_learn_fdb()
> (drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c), the driver dynamically
> allocates a struct icssm_prueth_sw_fdb_work and queues it.
> 
> If these are not tracked in a list, unloading the module could leave pending
> work items that execute unmapped memory, potentially causing a kernel panic.
> 

As this is a pre-existing issue related to the FDB implementation, we'll address
it as a separate patch series rather than merging it into this series. This avoids
expanding the scope of the current patch series.

> [Severity: High]
> This is a pre-existing issue, but can the unbounded GFP_ATOMIC allocations
> for FDB learning lead to memory exhaustion?
> 
> Every received frame with an unlearned source MAC address triggers
> icssm_prueth_sw_learn_fdb(), which uses kzalloc_obj(..., GFP_ATOMIC) without
> rate limiting.
> 
> A continuous flood of frames with randomized source MAC addresses could
> trigger thousands of allocations per second, potentially exhausting the
> kernel's atomic memory pools.
> --

As this is a pre-existing issue related to the FDB implementation, we'll address
it as a separate patch series rather than merging it into this series. This avoids
expanding the scope of the current patch series.

Thanks and Regards,
Parvathi.
