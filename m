Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADC3FB7EB
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437613; cv=none; b=TytImmk0ifTfUKjjMMBul65lz3no6RjlJIcQWSeQqBRDvPICP2VCeitY4Kt/G2TcNFStHbs2ddZnAE1LhNG6rCvj7TutH1Lghy2k75WaVDJJ6ytjsklaYXnXsxCJdpkHlP6S8FL4AcBus4g5EWWYcZRX42F1w2+9AjPW8+8SQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437613; c=relaxed/simple;
	bh=i0keQ4aEEl6kd8FYLEraCKYC+XydEuoMLYlYQDL7T4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtJSSEK2D7O8jcCEDY8BFZ+obij9Rl7uumqRCOcWCS1Fu1EXpsskauGp/tfVgjUIcfkxhxzNDBTeiztNfxomi1wOwhTILouQMh5moiqmBPVRSFGzjdu5JMpR/JHxCK+0XzXZ5wGRgSqREZloWFBFYb1nXj9GKP731tE5gP5Wbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZLNeHCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZLNeHCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786437610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYhQIkr1UHJHEKr6XYHqSWyJzRY6OBRob+m2igGi0bQ=;
	b=GZLNeHCL+DAW/qTiUo6ly1SN2qpKK+VyLDNe1DNwO/PMhr6TNy3U0TtFz8Jtm//F+8XSQo
	LhcHov0MsFPCE/6D+gAD/vwgMmw3Nog7EDoZkbld1ASAL1cwfeABVNaoTYttTwJsupdjxc
	kJJtV8g5NqJLREJ8N/Mm9kP4KoLtn0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-Aq1xe_w_PsOJ-728vok8rw-1; Tue,
 11 Aug 2026 04:40:06 -0400
X-MC-Unique: Aq1xe_w_PsOJ-728vok8rw-1
X-Mimecast-MFC-AGG-ID: Aq1xe_w_PsOJ-728vok8rw_1786437604
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D9D318004BB;
	Tue, 11 Aug 2026 08:40:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B666A195DF91;
	Tue, 11 Aug 2026 08:39:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: parvathi@couthit.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
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
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Date: Tue, 11 Aug 2026 10:39:51 +0200
Message-ID: <20260811083951.24444-1-pabeni@redhat.com>
In-Reply-To: <20260804121644.465118-4-parvathi@couthit.com>
References: <20260804121644.465118-4-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [3]: [PATCH net-next v3 3/3] net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP ---
commit e6e3942b25c7905f76512f3ac3b7e21bb0915c5e
Author: Roger Quadros <rogerq@ti.com>

net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP

This adds NETIF_F_HW_HSR_DUP support by moving the two per-port LRE
transmit queues onto one shared BD ring, so a frame is copied into OCMC RAM
once and both PRU ports transmit it.  The TX path inspects the HSR tag or
the PRP RCT trailer to decide whether to set the LAN A/LAN B duplication
bits, and the receive path switches from the BD Port field to a new HostRecv
bit.

A few questions about the new code below.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index 7031b78d2cc2f..43862946d4f14 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

[ ... ]

> @@ -567,16 +615,19 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  	u16 update_wr_ptr;
>  	u32 wr_buf_desc;
>  	void *ocmc_ram;
> +	__be16 proto;
> +	u8 *hdr;
> +
> +	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
> +				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
> +
> +	if (prueth_is_lre(prueth) && (emac->link || other_emac->link))
> +		link_up = true;

[Severity: Medium]
[Finding: main-5-19]
[Sources: opus-5]
Is emac->link safe to read here without emac->lock?

icssm_emac_adjust_link() mutates it under the lock:

	spin_lock_irqsave(&emac->lock, flags);
	...
	} else if (emac->link) {
		new_state = true;
		emac->link = 0;
	}

The transmit path holds only prueth->lre_host_queue_lock[qid - 2], so the
lockset intersection with adjust_link is empty.

Since link_up decides whether the second write pointer of the shared queue
is advanced, can a sample that races with adjust_link leave the two write
pointers for one ring permanently out of step?

>  	if (!PRUETH_IS_EMAC(prueth))
>  		dram = prueth->mem[PRUETH_MEM_DRAM1].va;
>  	else
>  		dram = emac->prueth->mem[emac->dram].va;
> -	if (eth_skb_pad(skb)) {
> -		if (netif_msg_tx_err(emac) && net_ratelimit())
> -			netdev_err(ndev, "packet pad failed\n");
> -		return -ENOMEM;
> -	}
>  
>  	/* which port to tx: MII0 or MII1 */
>  	txport = emac->tx_port_queue;

[ ... ]

> @@ -607,6 +661,29 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  		free_blocks = buffer_desc_count;
>  	}
>  
> +	/* Fetch queue state for the second LRE port */
> +	if (prueth_is_lre(prueth) && link_up) {
> +		queue_desc_other_port = emac->tx_queue_descs_other_port +
> +					queue_id;
> +		bd_rd_ptr_other_port = readw(&queue_desc_other_port->rd_ptr);
> +
> +		read_block_other_port = (bd_rd_ptr_other_port -
> +					 txqueue->buffer_desc_offset) / BD_SIZE;

[Severity: High]
[Finding: main-3-13]
[Sources: opus-5]
Should this be conditional on the peer port actually having been
configured, i.e. prueth->emac_configured & BIT(other_port)?

link_up is true whenever either port's phy link is up, so with only one LRE
slave netdev opened this reads a descriptor that was never initialised.
icssm_prueth_hostinit() has memset_io()'d DRAM1:

	if (prueth->eth_node[PRUETH_MAC1])
		icssm_prueth_clearmem(prueth, PRUETH_MEM_DRAM1);

so bd_rd_ptr_other_port reads back 0 and, with both operands promoted to
int:

	read_block_other_port = (0 - P1_Q3_TXOPT_BD_OFFSET) / BD_SIZE
			      = (0 - 4128) / 4 = -1032

	free_blocks_other_port = 194 - 0 + (-1032) = -838

> +
> +		if (write_block > read_block_other_port) {
> +			free_blocks_other_port = buffer_desc_count -
> +						 write_block;
> +			free_blocks_other_port += read_block_other_port;
> +		} else if (write_block < read_block_other_port) {
> +			free_blocks_other_port = read_block_other_port -
> +						 write_block;
> +		} else {
> +			free_blocks_other_port = buffer_desc_count;
> +		}
> +
> +		if (free_blocks_other_port < free_blocks)
> +			free_blocks = free_blocks_other_port;
> +	}
>  	pkt_block_size = DIV_ROUND_UP(pktlen, ICSS_BLOCK_SIZE);
>  	if (pkt_block_size >= free_blocks) /* out of queue space */
>  		return -ENOBUFS;

With free_blocks negative, does pkt_block_size >= free_blocks not stay true
forever, so every xmit returns -ENOBUFS and icssm_emac_ndo_start_xmit()
loops on netif_stop_queue() plus the 100us hrtimer retry, stalling TX on
the port that does have a link?

> @@ -656,6 +733,57 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
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
> +		/* Extract HSR sequence number and LAN ID
> +		 * from the tag for the Buffer Descriptor
> +		 */
> +		if (proto == htons(ETH_P_HSR)) {
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
> +			} else {
> +				wr_buf_desc |= (txport <<
> +						PRUETH_BD_LAN_A_SHIFT);
> +			}
> +			wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
> +		} else {
> +			/* Read PRP RCT to extract sequence number and LAN ID */
> +			struct prp_txopt_rct *rct =
> +				(struct prp_txopt_rct *)(skb_tail_pointer(skb) -
> +							 ICSSM_LRE_TAG_SIZE);
> +
> +			if (rct->prp_suffix == htons(ETH_P_PRP)) {
> +				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
> +				wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
> +			} else {
> +				wr_buf_desc |= (txport <<
> +						PRUETH_BD_LAN_A_SHIFT);
> +			}
> +		}
> +	}

[Severity: Medium]
[Finding: main-1-4]
[Sources: opus-5]
Should the RCT branch be gated on PRUETH_IS_PRP(prueth)?

As written the else arm also runs in HSR mode, for every frame whose
(VLAN-inner) ethertype is not ETH_P_HSR, for example an untagged PTP, ARP or
IPv6 DAD frame sent directly on the slave netdev.  The last six bytes of
such a frame are then reinterpreted as struct prp_txopt_rct, and if the
final two payload bytes happen to be 0x88FB the frame gets

	wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
	wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;

and is duplicated onto both LANs.  With a raw socket those two bytes are
fully caller controlled.  The commit message says "Frames without an RCT
are sent on the originating port only" - is that still what happens here in
HSR mode?

Also, the two comments say the sequence number and LAN ID are extracted
from the HSR tag and from the RCT, but neither sequence_nr nor
lan_id_and_lsdu_size is ever read.  Could the comments be reworded?

> @@ -668,6 +796,10 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  	update_wr_ptr = txqueue->buffer_desc_offset + (update_block * BD_SIZE);
>  	writew(update_wr_ptr, &queue_desc->wr_ptr);
>  
> +	/* update the write pointer in queue descriptor of other port */
> +	if (prueth_is_lre(prueth) && link_up)
> +		writew(update_wr_ptr, &queue_desc_other_port->wr_ptr);
> +
>  	return 0;
>  }

[Severity: High]
[Finding: main-1-5]
[Sources: opus-5]
The BD write and the OCMC payload copy above are unconditional, but the peer
write pointer is only mirrored when link_up is true.  Can the two
descriptors that describe the same ring diverge permanently?

icssm_emac_ndo_open() does not stop the TX queue and emac->link stays 0
until the first icssm_emac_adjust_link() callback, so a frame sent right
after "ip link set ethX up" (with the peer also down) takes this path:

	writel(wr_buf_desc, sram + readw(&queue_desc->wr_ptr));
	...
	writew(update_wr_ptr, &queue_desc->wr_ptr);
	/* peer wr_ptr not advanced */

On the next transmit with link_up true, update_wr_ptr is computed from the
local descriptor and written into the peer descriptor, so does the peer PRU
jump over BDs it never saw as pending and transmit whatever ring content is
there now?

Separately, because the condition is an OR of both links, a peer whose link
is down still clamps free_blocks via free_blocks_other_port.  Should the
peer's rd_ptr only be consulted when that peer is actually draining the
ring?

> @@ -680,8 +812,10 @@ void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
>  	else
>  		pkt_info->start_offset = false;
>  
> -	pkt_info->port = (buffer_descriptor & PRUETH_BD_PORT_MASK) >>
> -			 PRUETH_BD_PORT_SHIFT;
> +	/* Flag from BD to indicate packet is valid for HOST or not. */
> +	pkt_info->host_recv_flag = !!(buffer_descriptor &
> +				      PRUETH_BD_HOST_RECV_MASK);
> +

[Severity: Medium]
[Finding: main-1-0]
[Sources: opus-5]
The commit message describes transmit-side duplicate offload only ("The
driver writes the frame once into OCMC RAM", HSR tag and RCT inspection),
but the patch also changes the receive path for every eth_type:

- icssm_parse_packet_info() stops decoding the BD Port field and decodes
  the new HostRecv bit for all modes
- icssm_emac_rx_packet() silently returns 0 for HSR frames without the
  HostRecv bit, with no drop counter, while the caller still counts the
  descriptor as used++
- software HSR tag removal excises six bytes from the middle of the frame
- the OCMC to skb copy is restructured into MAC header, optional VLAN and
  body stages for EMAC, switch, HSR and PRP alike

Could the changelog mention these receive-side changes?

>  	pkt_info->length = (buffer_descriptor & PRUETH_BD_LENGTH_MASK) >>
>  			   PRUETH_BD_LENGTH_SHIFT;
>  	pkt_info->broadcast = !!(buffer_descriptor & PRUETH_BD_BROADCAST_MASK);

[ ... ]

> @@ -744,9 +880,19 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
>  	/* calculate new pointer in ram */
>  	*bd_rd_ptr = rxqueue->buffer_desc_offset + (update_block * BD_SIZE);
>  
> +	if (PRUETH_IS_HSR(emac->prueth)) {
> +		if (!pkt_info->host_recv_flag)
> +			return 0;
> +	}
> +

[Severity: Low]
[Finding: main-2-6]
[Sources: opus-5]
The new bit is documented in icssm_switch.h without any protocol
qualification:

 * 10		HostRecv	Set if the frame is destined for the host port

and icssm_parse_packet_info() fills host_recv_flag for every eth_type, but
the only consumer is inside if (PRUETH_IS_HSR(...)).  In PRP mode the flag
is parsed and then ignored, so BDs the firmware marks as not for the host
are still copied into an skb and passed to netif_receive_skb().  Is that
intentional, and if so should the header say the bit is HSR only?

>  	/* Exclude the HSR tag bytes already stripped by firmware, if any. */
>  	actual_pkt_len = pkt_info->length - start_offset;
>  
> +	if (PRUETH_IS_HSR(emac->prueth)) {
> +		if (!start_offset && !pkt_info->timestamp)
> +			actual_pkt_len -= ICSSM_LRE_TAG_SIZE;
> +	}
> +

[Severity: Medium]
[Finding: main-1-3]
[Sources: opus-5]
This removes six bytes from every HSR-mode frame whose BD has neither the
start-offset bit nor the timestamp bit, without ever looking at the frame's
ethertype.  Can that corrupt untagged frames?

The same new code already reads the ethertype a few lines below for the VLAN
test:

	type = get_unaligned_be16(src_addr);

and the transmit side of this patch does discriminate on
proto == htons(ETH_P_HSR), and sends non-HSR protocols untagged on the
directed port.  So untagged frames do appear on the ring.

For such a frame, actual_pkt_len is reduced by six, src_addr is advanced by
six past ordinary payload, and the wrapped-copy path applies the same
adjustment to bytes.  Would gating the strip on the frame actually carrying
an HSR tag avoid delivering the frame six bytes short with a hole after the
MAC (and optional VLAN) header?

>  	/* Allocate a socket buffer for this packet */
>  	skb = netdev_alloc_skb_ip_align(ndev, actual_pkt_len);
>  	if (!skb) {

[ ... ]

> @@ -767,6 +913,29 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
>  		   (read_block * ICSS_BLOCK_SIZE);
>  	src_addr += start_offset;
>  
> +	/* Copy destination and source MAC address */
> +	memcpy(dst_addr, src_addr, PRUETH_ETHER_TYPE_OFFSET);
> +	src_addr += PRUETH_ETHER_TYPE_OFFSET;
> +	dst_addr += PRUETH_ETHER_TYPE_OFFSET;
> +
> +	adjust_for_hsr_tag += PRUETH_ETHER_TYPE_OFFSET;
> +
> +	/* Check for VLAN tag */
> +	type = get_unaligned_be16(src_addr);
> +
> +	if (type == ETH_P_8021Q) {
> +		memcpy(dst_addr, src_addr, VLAN_HLEN);
> +		src_addr += VLAN_HLEN;
> +		dst_addr += VLAN_HLEN;
> +		adjust_for_hsr_tag += VLAN_HLEN;
> +	}
> +
> +	/* HSR tag removal handling */
> +	if (PRUETH_IS_HSR(emac->prueth)) {
> +		if (!start_offset && !pkt_info->timestamp)
> +			src_addr += ICSSM_LRE_TAG_SIZE;
> +	}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> index 9af19617967ee..2447fb8b99e79 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h

[ ... ]

> @@ -314,9 +317,13 @@ struct prueth {
>  	u8 emac_configured;
>  	u8 hsr_members;
>  	u8 br_members;
> +
> +	/* Per-queue TX lock - LRE uses only the two high-priority queues */
> +	spinlock_t lre_host_queue_lock[NUM_QUEUES / 2];
>  };

[Severity: Low]
[Finding: main-2-9]
[Sources: opus-5]
This isn't a bug, but the comment says "the two high-priority queues" while
the queues the LRE transmit path can reach are PRUETH_QUEUE3 and
PRUETH_QUEUE4:

	emac_pcp_tx_priority_queue_map[0..3] == {QUEUE4, QUEUE4, QUEUE3, QUEUE3}

and this same patch labels them in icssm_switch.h as

	#define QUEUE_3_TXOPT_SIZE	194	/* Protocol specific - High Priority */
	#define QUEUE_4_TXOPT_SIZE	194	/* NRT(IP,ARP, ICMP) - Low Priority*/

which is one high and one low priority queue.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> index 43140add81725..a99cdbb79bbf0 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> @@ -137,16 +137,13 @@ static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
>  			used++;
>  		}
>  
> -		/* Zero the BD after consuming it, a misaligned rd_ptr
> -		 * would otherwise mistake stale data for a valid incoming
> -		 * frame.
> +		/* Leave the BD intact after reading. Firmware reuses it to
> +		 * forward the frame to the second LRE port.
>  		 */
>  		if (port == 0) {
> -			writel(0, shared_ram + bd_rd_ptr);
>  			writew(update_rd_ptr, &queue_desc->rd_ptr);
>  			bd_rd_ptr = update_rd_ptr;
>  		} else {
> -			writel(0, shared_ram + bd_rd_ptr_o);
>  			writew(update_rd_ptr, &queue_desc_o->rd_ptr);
>  			bd_rd_ptr_o = update_rd_ptr;
>  		}

[Severity: Medium]
[Finding: main-1-2]
[Sources: opus-5]
Should this removal be gated on prueth_is_lre()?

The justification is LRE specific, but this is the common host receive
routine: icssm_prueth_lre_napi_poll_hpq()/lpq() are registered and enabled
whenever PRUETH_IS_SWITCH(prueth) || prueth_is_lre(prueth), so RSTP switch
mode loses the invalidation too.

The immediately preceding patch in this series added the zeroing with the
opposite reasoning, and the single-port path still does it:

drivers/net/ethernet/ti/icssm/icssm_prueth.c:icssm_emac_rx_packets() {
	...
			/* after reading the buffer descriptor we clear it
			 * to prevent improperly moved read pointer errors
			 * from simply looking like old packets.
			 */
			writel(0, shared_ram + bd_rd_ptr);
	...
}

In switch mode, after any rd_ptr skew, including the two length-error paths
in this same loop that force update_rd_ptr = *bd_wr_ptr_p, can a stale
non-zero BD word be re-parsed as a valid length and flags descriptor and up
to pkt_info->length bytes of old OCMC content be pushed to
netif_receive_skb()?

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
> index 9d67fc7c23acc..bda2fac13d749 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c

[ ... ]

> @@ -983,6 +1177,109 @@ static int icssm_prueth_sw_port_config(struct prueth *prueth,
>  	return 0;
>  }
>  
> +/* Configure TX/RX queue contexts and buffer descriptor tables for LRE port */
> +static int icssm_prueth_lre_port_config(struct prueth *prueth,
> +					enum prueth_port port_id)
> +{

[ ... ]

> +	/* queue size lookup table */
> +	dram = dram_base + QUEUE_SIZE_ADDR +
> +		port_id * NUM_QUEUES * sizeof(u16);
> +	writew(HOST_QUEUE_1_SIZE, dram);
> +	writew(HOST_QUEUE_2_SIZE, dram + 2);
> +	writew(QUEUE_3_TXOPT_SIZE, dram + 4);
> +	writew(QUEUE_4_TXOPT_SIZE, dram + 6);

[Severity: Low]
[Finding: main-2-10]
[Sources: opus-5]
For PRUETH_PORT_QUEUE_MII0 the entries QUEUE1 and QUEUE2 of
lre_queue_infos describe host queues 3 and 4:

	[PRUETH_QUEUE1] = {
		P0_Q3_BUFFER_OFFSET,
		...
		P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
	},

so the firmware is told HOST_QUEUE_1_SIZE / HOST_QUEUE_2_SIZE for rings
whose buffer_desc_end the driver derives from HOST_QUEUE_3_SIZE /
HOST_QUEUE_4_SIZE.  All four constants are 194 today, so nothing breaks,
but should the sizes be derived from the same constants the queue info
table uses?

> +
> +	/* queue table */
> +	memcpy_toio(dram_base + queue_desc_ofs,
> +		    &hsr_prp_txopt_queue_descs[port_id][0],
> +		    4 * sizeof(hsr_prp_txopt_queue_descs[port_id][0]));

[Severity: High]
[Finding: main-3-13]
[Sources: opus-5]
Is it safe to reset these descriptors while the peer port is live?

hsr_prp_txopt_queue_descs[MII0][2..3] and [MII1][2..3] both point at
P1_Q3_TXOPT_BD_OFFSET / P2_Q1_TXOPT_BD_OFFSET, so the two per-port
descriptor sets describe the same BD ring and the same OCMC buffer.  This
memcpy_toio() rewinds rd_ptr and wr_ptr of that shared ring to its base.

The path is reachable from ndo_open of the second slave, and again on
"ip link set ethX down; ip link set ethX up" while the other slave is up,
because icssm_prueth_sw_shutdown_prus() returns early while
emac_configured is non-zero and icssm_emac_ndo_stop() only clears the
port's bit, so both PRUs keep running.

Also, this runs with no lock held, while the peer's
icssm_emac_ndo_start_xmit() holds only prueth->lre_host_queue_lock[qid - 2]
when it reads queue_desc_other_port->rd_ptr and writes
queue_desc_other_port->wr_ptr.  Should the configuration path take the same
lock?

> +
> +	/* In HSR/PRP mode both slave ports share the host receive queue
> +	 * descriptor region (P0_QUEUE_DESC_OFFSET). The firmware arbitrates
> +	 * ownership; the driver always reads from the same host-side descriptor
> +	 * base regardless of which physical port the frame arrived on.
> +	 */
> +	emac->rx_queue_descs = dram_base + P0_QUEUE_DESC_OFFSET;
> +	emac->tx_queue_descs = dram_base +
> +		lre_rx_queue_infos[port_id][PRUETH_QUEUE1].queue_desc_offset;
> +
> +	if (port_id == PRUETH_PORT_MII0) {
> +		emac->tx_queue_descs_other_port = dram_base +
> +			lre_rx_queue_infos
> +			[port_id + 1][PRUETH_QUEUE1].queue_desc_offset;
> +	} else if (port_id == PRUETH_PORT_MII1) {
> +		emac->tx_queue_descs_other_port = dram_base +
> +			lre_rx_queue_infos
> +			[port_id - 1][PRUETH_QUEUE1].queue_desc_offset;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
> index 13b1b93ef4c27..b0d623b4979b0 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
> +++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h

[ ... ]

> @@ -49,20 +52,18 @@
>   *				For RED, NodeTable lookup was successful.
>   * 7		Flood		Packet should be flooded (destination MAC
>   *				address found in FDB). For switch only.
> - * 8..12	Block_length	number of valid bytes in this specific block.
> - *				Will be <=32 bytes on last block of packet
> + * 8		RED_INFO	Set if the frame carries an HSR or PRP
> + *				redundancy tag
> + * 10		HostRecv	Set if the frame is destined for the host port
>   * 13		More		"More" bit indicating that there are more blocks
>   * 14		Shadow		indicates that "index" is pointing into shadow
>   *				buffer
>   * 15		TimeStamp	indicates that this packet has time stamp in
>   *				separate buffer - only needed if PTP runs on
>   *				host
> - * 16..17	Port		different meaning for ingress and egress,
> - *				Ingress: Port = 0 indicates phy port 1 and
> - *				Port = 1 indicates phy port 2.
> - *				Egress: 0 sends on phy port 1 and 1 sends on
> - *				phy port 2. Port = 2 goes over MAC table
> - *				look-up
> + * 16..17	LAN		Destination LAN for transmission:
> + *				bit 16 = LAN A, bit 17 = LAN B, set both to
> + *				duplicate to both LANs.

[Severity: Low]
[Finding: main-2-7]
[Sources: opus-5]
This header still serves the EMAC and switch firmware, but the bit table
now only describes the LRE interpretation.  The Block_length description
for bits 8..12 and the Port description for bits 16..17, including
"Port = 2 goes over MAC table look-up", are gone, bits 9, 11 and 12 are
left undocumented, and PRUETH_BD_PORT_MASK/SHIFT are removed.

icssm_prueth_tx_enqueue() only programs the LAN bits inside
if (prueth_is_lre(prueth)), so could the comment note that the RED_INFO,
HostRecv and LAN meanings apply to the LRE firmware only, and keep the
EMAC/switch meanings alongside them?

Thanks for looking at these.
-- 
This is an AI-generated review.

