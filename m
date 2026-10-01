Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E363264D2;
	Thu,  1 Oct 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860265; cv=none; b=duthJlSaVRu1FRvTkHrlBDru7gxPhuXgAhCcK9ZuUoZojzB3gxnk6Wqcb6pkvZEPOWxiHXCK6DNL+2DvIqfpELjXJPi7Rm1X7y2CXjWkZ2+7xQf7quOS+S+ZvUwwgOeKCIPtXVQhwwofbi5H7mGws56AcWCxav/rtVw50AI1OfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860265; c=relaxed/simple;
	bh=Pa6GRL5xb/2R4M/aLYve8miceUGft23vf5SDoLi9e8M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=L+/8lqJVPRBAiHOUzQntaBxThNxraphBThmqcRVOljxJL07G9WgvxQBXSiOnZMwB2JMKRMG+p2Se96sUhjxNCbBhrks+Akh7vePcZyYiyTBaaAjVC9LRu2N7etU2xNO5Hxa270W2ROHH+ZROQkCRfPvzy8cDOrX2RcwAp/C+6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=tXfNsmpq; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="tXfNsmpq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GL7ZDdP4Fbo0/jHz9SylqsQ2xSeu+fLePqrzmsWP+8c=; b=tXfNsmpq3wAAFO3JIipdwGPpZL
	dFxygGX3Wi39Xv4x5dfPL0f604sc+4ipFIrwUQ3YxYj10MUzn1d9IHcqP520JRRXnkGoxCJwBROTl
	jN5TjoR887SOhh6k17kEIktCwiJ35G1QUylKOIR7hno1/JUkNIpGZTvI1kNCER8nTLjTTY1kNTgUW
	mYwddTkvlEzQW1AO9UFvapEY6Icir7zRPFkLZK+GvBfTNiKUR5LRpPWcXVDILTAT5VzC4mvO69N6a
	dKbDs0ULhIMW+OdQN+M0+ezJNZCUe9cblXjGGP8iUgI8wVAt8fEW0MML5wHAzcXHgTEorUcVk+vcW
	CcQhHc9Q==;
Received: from [115.246.246.98] (port=38216 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <parvathi@couthit.com>)
	id 1xCGYu-00000000upB-35wd;
	Thu, 01 Oct 2026 09:11:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id BCE431A08960;
	Thu,  1 Oct 2026 18:40:57 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id NCaKiwFU2_z3; Thu,  1 Oct 2026 18:40:55 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 9184F1A0895F;
	Thu,  1 Oct 2026 18:40:55 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YqyNMpkImhzc; Thu,  1 Oct 2026 18:40:55 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 6A6231A08960;
	Thu,  1 Oct 2026 18:40:55 +0530 (IST)
Date: Thu, 1 Oct 2026 18:40:55 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Simon Horman <horms@kernel.org>
Cc: parvathi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, afd <afd@ti.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, haokexin@gmail.com, 
	basharath <basharath@couthit.com>, arnd <arnd@arndb.de>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	m-malladi <m-malladi@ti.com>, krishna <krishna@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <61177290.492777.1790860255343.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260925163944.721179-1-horms@kernel.org>
References: <20260921134343.200426-4-parvathi@couthit.com> <20260925163944.721179-1-horms@kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: ti: icssm-prueth: Support
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
Thread-Index: Li9uaJOhO8YSLEr4VnoTnJWJqE6+bw==
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

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at:
> https://sashiko.dev/#/patchset/20260921134343.200426-4-parvathi@couthit.com?part=3
> ---
> net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
> 
> This commit introduces hardware duplication offloading for HSR and PRP in
> the PRU Ethernet driver. It uses a shared queue to write frames into OCMC
> RAM once, replicating transmission in firmware, and adds receive-side
> handling for duplicate frames.
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> [ ... ]
>> @@ -656,6 +725,57 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac
>> *emac,
>>  	if (PRUETH_IS_HSR(prueth))
>>  		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);
>>  
>> +	if (prueth_is_lre(prueth)) {
>> +		ethhdr = (struct ethhdr *)skb_mac_header(skb);
>> +		proto = ethhdr->h_proto;
>> +
>> +		if (proto == htons(ETH_P_8021Q)) {
>> +			vlan_hdr = (struct vlan_ethhdr *)ethhdr;
>> +			proto = vlan_hdr->h_vlan_encapsulated_proto;
>> +			is_vlan = true;
>> +		}
>> +
>> +		/* Check if the SKB has HSR tag */
>> +		if (PRUETH_IS_HSR(prueth) && proto == htons(ETH_P_HSR)) {
>> +			hdr = skb_mac_header(skb);
>> +
>> +			if (is_vlan) {
>> +				hsr_ethhdr =
>> +					(struct hsr_txopt_ethhdr *)(hdr +
>> +								    VLAN_HLEN);
>> +			} else {
>> +				hsr_ethhdr = (struct hsr_txopt_ethhdr *)hdr;
>> +			}
>> +
>> +			/* PTP frames (ETH_P_1588) carry no LAN ID
>> +			 * in the HSR tag
>> +			 */
>> +			if (hsr_ethhdr->hsr_tag.encap_proto !=
>> +			    htons(ETH_P_1588)) {
>> +				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
> 
> [Severity: Medium]
> Is it expected to unconditionally duplicate the frame here?
> 
> The driver exposes NETIF_F_HW_HSR_DUP as a toggleable ethtool feature, but
> this data path checks PRUETH_IS_HSR() and always performs duplication. If a
> user disables hw-hsr-dup, the software HSR core will duplicate packets and
> send two copies. The hardware will then duplicate them again, causing a
> broadcast storm.
> 
> Should this check the active ndev features instead?
> 

No. The HSR offload features can only be turned on or off together, and they cannot
be changed while the port is an HSR slave or running. The firmware enters HSR mode
only if these features are enabled when both ports join the HSR device. Otherwise the
device stays in EMAC mode and this path is never taken. So PRUETH_IS_HSR() here always
means hw-hsr-dup is enabled, and frames are never duplicated twice.

>> +			} else {
>> +				wr_buf_desc |= (txport <<
>> +						PRUETH_BD_LAN_A_SHIFT);
>> +			}
>> +			wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
>> +		} else if (PRUETH_IS_PRP(prueth)) {
>> +			/* Check if the SKB has PRP tag */
>> +			struct prp_txopt_rct *rct =
>> +				(struct prp_txopt_rct *)(skb_tail_pointer(skb) -
>> +							 ICSSM_LRE_TAG_SIZE);
>> +
>> +			if (rct->prp_suffix == htons(ETH_P_PRP)) {
> 
> [Severity: Medium]
> Could this lead to unaligned memory accesses?
> 
> Since skb->len can be odd for arbitrary payloads like ICMP packets, the
> tail pointer may be unaligned. The struct prp_txopt_rct contains __be16
> fields and is not marked as __packed. Dereferencing rct->prp_suffix
> directly from an unaligned address can cause unaligned access exceptions on
> some ARM architectures.
> 

We will address this in the next version.

>> +				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
>> +				wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
>> +			} else {
>> +				wr_buf_desc |= (txport <<
>> +						PRUETH_BD_LAN_A_SHIFT);
>> +			}
>> +		} else {
>> +			wr_buf_desc |= (txport << PRUETH_BD_LAN_A_SHIFT);
>> +		}
>> +	}
> [ ... ]
>> @@ -741,11 +871,36 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16
>> *bd_rd_ptr,
> [ ... ]
>> +	actual_pkt_len = pkt_info->length;
>> +
>> +	if (has_hsr_tag)
>> +		actual_pkt_len -= ICSSM_LRE_TAG_SIZE;
> 
> [Severity: Medium]
> Does this unconditionally strip the HSR tag regardless of the netdev feature
> configuration?
> 
> Similar to the duplication offload, NETIF_F_HW_HSR_TAG_RM is exposed via
> ethtool but not checked in this data path. If a user disables tag removal in
> hardware, the host stack might fail to parse the packet since the driver
> still forcibly strips the tag.
> 

No. The tag is stripped only when the device is in HSR mode, and HSR mode is entered
only when both ports join the HSR device with the HSR offload features enabled. These
features can only be turned on or off together, and cannot be changed while the port
is an HSR slave or running. If they are disabled, the device stays in EMAC mode, this
path is not taken, and the HSR core removes the tag in software.

>>  
>>  	/* Allocate a socket buffer for this packet */
>>  	skb = netdev_alloc_skb_ip_align(ndev, actual_pkt_len);
> [ ... ]
>> @@ -1309,17 +1473,31 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct
>> sk_buff *skb,
>>  						struct net_device *ndev)
>>  {
>>  	struct prueth_emac *emac = netdev_priv(ndev);
>> +	/* Spinlock for Tx Queues */
>> +	spinlock_t *lock_queue;
>> +	unsigned long flags;
>>  	int ret;
>>  	u16 qid;
>>  
>>  	qid = icssm_prueth_get_tx_queue_id(emac->prueth, skb);
>> +	/* Select the TX queue spin lock for this queue ID */
>> +	if (prueth_is_lre(emac->prueth))
>> +		lock_queue = &emac->prueth->lre_host_queue_lock[qid - 2];
>> +	else
>> +		lock_queue = &emac->host_queue_lock[qid - 2];
>> +
> 
> [Severity: High]
> Could a race condition occur here when the interface mode changes?
> 
> Because icssm_prueth_change_mode can modify the eth_type (which changes the
> result of prueth_is_lre) and calls ndo_stop directly without waiting for
> in-flight ndo_start_xmit calls to complete, there is a time-of-check to
> time-of-use vulnerability.
> 
> If eth_type changes between this lock selection and the lock acquisition
> below, one thread could acquire host_queue_lock while another acquires
> lre_host_queue_lock. Both might then evaluate prueth_is_lre() as true inside
> icssm_prueth_tx_enqueue, concurrently modifying the exact same shared LRE
> queue descriptors and causing queue corruption.
> 

We will address this in the next version.

Thanks and Regards,
Parvathi.
