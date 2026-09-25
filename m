Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB824E80C3;
	Fri, 25 Sep 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354413; cv=none; b=rpe92FIlNDjZPf4W+L7bpd40ecTNU7Vv9eHidnmQnX42I6unC/zcIs6fo7/vKbxllApRNV+vP+g738h/l9mrt7twgtBfA/PvfCTY9mGvbpzug3X1Q7IUmWX41STG4UQq0OypfrYB0n5vQiBp9l+nu3ZwJ9ARtizVcQWY7NZhWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354413; c=relaxed/simple;
	bh=fdXA+7OaBsNV8TRWDics8GbB+kxJtdx9lSKqXXMCMog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON60tTvVHKW9SvJmNGBQ9DYadY/pdwsIIpUNp4tsHe/MFXfvq0Y6Jvr2vCyBMSn7r/TWwJq7OFzfk7VaMuuFX5xEFkYMVGNOx3QcUCg+lvypyNNh3ZwF2WkoNEJrsErMHL8Haoz2yp8ocLYdXVVQz+a5NNE1R/SPH4Ynhcp7beg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7Wx1Jx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7Wx1Jx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031F61F00893;
	Fri, 25 Sep 2026 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354392;
	bh=1jykViny6r6kbRxSStwd/fOT3w6GsHOrhLRb0gYmw/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d7Wx1Jx0c4Byv+JWmPgJYpTuBza3tRPkQOYu6w8gVNI5VCVeKHnBMVRhliUozczTe
	 cyGTjd6dikhJwhCzlrUJbX6fjK9lSkN3FbMRZAAJ6ye4mHAIbSxGfvbjgB3IF5FDiD
	 4woQ0hDHe9SUyqI5RPhkkxpyz38Q23X1JpThgmd4hgaKqouo/7C+fSLl26ayCoUtAW
	 bHXYJd1lkJru3N+WlIjR2g0Hqd+8wIl9ZpX2Teu2CW7LUpxUaivqisgbFFQihGWeT1
	 5hBPqMCNXPiEzYYDttrDlUw618iC+v+z2b4n+syqfpc0YzKN6rXGieQJ30XldtKj3B
	 5u7FIUQdawUOQ==
From: Simon Horman <horms@kernel.org>
To: parvathi@couthit.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	vadim.fedorenko@linux.dev,
	haokexin@gmail.com,
	basharath@couthit.com,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v4 3/3] net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Date: Fri, 25 Sep 2026 17:39:44 +0100
Message-ID: <20260925163944.721179-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921134343.200426-4-parvathi@couthit.com>
References: <20260921134343.200426-4-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260921134343.200426-4-parvathi@couthit.com?part=3
---
net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP

This commit introduces hardware duplication offloading for HSR and PRP in
the PRU Ethernet driver. It uses a shared queue to write frames into OCMC
RAM once, replicating transmission in firmware, and adds receive-side
handling for duplicate frames.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
[ ... ]
> @@ -656,6 +725,57 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  	if (PRUETH_IS_HSR(prueth))
>  		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);
>  
> +	if (prueth_is_lre(prueth)) {
> +		ethhdr = (struct ethhdr *)skb_mac_header(skb);
> +		proto = ethhdr->h_proto;
> +
> +		if (proto == htons(ETH_P_8021Q)) {
> +			vlan_hdr = (struct vlan_ethhdr *)ethhdr;
> +			proto = vlan_hdr->h_vlan_encapsulated_proto;
> +			is_vlan = true;
> +		}
> +
> +		/* Check if the SKB has HSR tag */
> +		if (PRUETH_IS_HSR(prueth) && proto == htons(ETH_P_HSR)) {
> +			hdr = skb_mac_header(skb);
> +
> +			if (is_vlan) {
> +				hsr_ethhdr =
> +					(struct hsr_txopt_ethhdr *)(hdr +
> +								    VLAN_HLEN);
> +			} else {
> +				hsr_ethhdr = (struct hsr_txopt_ethhdr *)hdr;
> +			}
> +
> +			/* PTP frames (ETH_P_1588) carry no LAN ID
> +			 * in the HSR tag
> +			 */
> +			if (hsr_ethhdr->hsr_tag.encap_proto !=
> +			    htons(ETH_P_1588)) {
> +				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;

[Severity: Medium]
Is it expected to unconditionally duplicate the frame here?

The driver exposes NETIF_F_HW_HSR_DUP as a toggleable ethtool feature, but
this data path checks PRUETH_IS_HSR() and always performs duplication. If a
user disables hw-hsr-dup, the software HSR core will duplicate packets and
send two copies. The hardware will then duplicate them again, causing a
broadcast storm.

Should this check the active ndev features instead?

> +			} else {
> +				wr_buf_desc |= (txport <<
> +						PRUETH_BD_LAN_A_SHIFT);
> +			}
> +			wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
> +		} else if (PRUETH_IS_PRP(prueth)) {
> +			/* Check if the SKB has PRP tag */
> +			struct prp_txopt_rct *rct =
> +				(struct prp_txopt_rct *)(skb_tail_pointer(skb) -
> +							 ICSSM_LRE_TAG_SIZE);
> +
> +			if (rct->prp_suffix == htons(ETH_P_PRP)) {

[Severity: Medium]
Could this lead to unaligned memory accesses?

Since skb->len can be odd for arbitrary payloads like ICMP packets, the
tail pointer may be unaligned. The struct prp_txopt_rct contains __be16
fields and is not marked as __packed. Dereferencing rct->prp_suffix
directly from an unaligned address can cause unaligned access exceptions on
some ARM architectures.

> +				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
> +				wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
> +			} else {
> +				wr_buf_desc |= (txport <<
> +						PRUETH_BD_LAN_A_SHIFT);
> +			}
> +		} else {
> +			wr_buf_desc |= (txport << PRUETH_BD_LAN_A_SHIFT);
> +		}
> +	}
[ ... ]
> @@ -741,11 +871,36 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
[ ... ]
> +	actual_pkt_len = pkt_info->length;
> +
> +	if (has_hsr_tag)
> +		actual_pkt_len -= ICSSM_LRE_TAG_SIZE;

[Severity: Medium]
Does this unconditionally strip the HSR tag regardless of the netdev feature
configuration?

Similar to the duplication offload, NETIF_F_HW_HSR_TAG_RM is exposed via
ethtool but not checked in this data path. If a user disables tag removal in
hardware, the host stack might fail to parse the packet since the driver
still forcibly strips the tag.

>  
>  	/* Allocate a socket buffer for this packet */
>  	skb = netdev_alloc_skb_ip_align(ndev, actual_pkt_len);
[ ... ]
> @@ -1309,17 +1473,31 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
>  						struct net_device *ndev)
>  {
>  	struct prueth_emac *emac = netdev_priv(ndev);
> +	/* Spinlock for Tx Queues */
> +	spinlock_t *lock_queue;
> +	unsigned long flags;
>  	int ret;
>  	u16 qid;
>  
>  	qid = icssm_prueth_get_tx_queue_id(emac->prueth, skb);
> +	/* Select the TX queue spin lock for this queue ID */
> +	if (prueth_is_lre(emac->prueth))
> +		lock_queue = &emac->prueth->lre_host_queue_lock[qid - 2];
> +	else
> +		lock_queue = &emac->host_queue_lock[qid - 2];
> +

[Severity: High]
Could a race condition occur here when the interface mode changes?

Because icssm_prueth_change_mode can modify the eth_type (which changes the
result of prueth_is_lre) and calls ndo_stop directly without waiting for
in-flight ndo_start_xmit calls to complete, there is a time-of-check to
time-of-use vulnerability.

If eth_type changes between this lock selection and the lock acquisition
below, one thread could acquire host_queue_lock while another acquires
lre_host_queue_lock. Both might then evaluate prueth_is_lre() as true inside
icssm_prueth_tx_enqueue, concurrently modifying the exact same shared LRE
queue descriptors and causing queue corruption.

> +	if (eth_skb_pad(skb)) {
> +		if (netif_msg_tx_err(emac) && net_ratelimit())
> +			netdev_err(ndev, "packet pad failed\n");
> +		atomic64_inc(&emac->stats.tx_dropped);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	spin_lock_irqsave(lock_queue, flags);
>  	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
> -	if (ret) {
> -		if (ret != -ENOBUFS && netif_msg_tx_err(emac) &&
> -		    net_ratelimit())
> -			netdev_err(ndev, "packet queue failed: %d\n", ret);
> +	spin_unlock_irqrestore(lock_queue, flags);
