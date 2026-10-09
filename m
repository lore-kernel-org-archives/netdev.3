Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C03392C46;
	Fri,  9 Oct 2026 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517431; cv=none; b=B2WzOWkp3gu+s+wKCX7cguvxDJSXZ1+FCRd6rOJ0rMxs/rkoqLMUrWCaEzUgodYrGyL4s0Xi0tyQXldi73Kyt3T9EdcEomaSQbbaUcnUjSxcbqionHCjFA5graf/GKXtfymC1Pxrf+HzjxO/RW5yCgbTQz9YNkVs6jFrhiYwTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517431; c=relaxed/simple;
	bh=OE3j6p/eSZ4j2U99bYr9J1OY5SZgfON8jBAURM+bIUY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYaVn0LgJYFumm8yjL69EmKJGDQu2xIFFE6kFy/q35tOnWfrOLe6IQWU/HTk8SSYapDiDXIBid2dKu+Sea1s9fPwhmQH+Z2VMhcmjnGpjTwDwJl25MsKr1MO/sFwdSwbvXyw3KZlc6POl1eq6UQqnt1tOnA8y6szbAWnXISA884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvuKJOST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvuKJOST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AD21F00898;
	Fri,  9 Oct 2026 03:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791517417;
	bh=/M5uttZhx9Ttep54rV7zXTzpJ7YZvtnUtuCRojRtt7k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lvuKJOSTw1Wm5W/xa0RtNeY8oi5DjXfjSwbblDip+aOVDgXHZosR3VjDRHLv+bJj1
	 H/uI0DRqQAso5rhXgH/V4gt9cFKFlyp8JtSHcRxzLncpXAog8QbB0PS+I79ENGb55V
	 4CcrD4XwOw30wyksgFTDxI7HVWG9t3aVguvQi3W9XtZdfECFnL47juNcAfd4E91V96
	 fHJy7QSTqQVnANplREAAifMmS2M3YLraqylIm/zAfrBE11sadY/sHDu139IPMdg+/c
	 UtnV6KBNGr5y4lRk5noQCPGu994yVwY5LkIPn5x0kYCcBIJ+TJfnK1TLXY8GsJb6td
	 KFAa8l3FB0EtQ==
Subject: Re: [PATCH net-next v5 3/3] net: ti: icssm-prueth: Support duplicate
 HW offload feature for HSR and PRP
From: netdev-bot+sashiko@kernel.org
To: parvathi@couthit.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, afd@ti.com, vadim.fedorenko@linux.dev, haokexin@gmail.com,
 basharath@couthit.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 horms@kernel.org, pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, m-malladi@ti.com,
 krishna@couthit.com, mohan@couthit.com
Date: Fri, 09 Oct 2026 03:43:35 +0000
Message-ID: <179151741543.434549.12128472133562069089@kernel.org>
In-Reply-To: <20261005154654.576663-4-parvathi@couthit.com>
References: <20261005154654.576663-4-parvathi@couthit.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 7 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch silently changes the driver/firmware contract for
  HSR RX and LRE TX.
- [Medium] HSR-tagged PTP frames sent through the HSR master lose their
  second transmission once hsr-dup-offload is enabled.
- [Medium] Coupling three features (HSR_FWD, HSR_TAG_RM, HSR_DUP) in
  icssm_emac_ndo_fix_features() breaks incremental enabling.
- [Medium] Enabling hsr-dup-offload on only the port that becomes HSR
  slave B silently loses redundancy.
- [Medium] icssm_prueth_tx_enqueue() cannot tell a full ring from an
  empty one.
- [Medium] The TX path now reads prueth->eth_type (through
  prueth_is_lre()) several times with no synchronisation.
- [Medium] In LRE mode, icssm_prueth_tx_enqueue() finds the L2 header
  with skb_mac_header(skb) instead of skb->data.
- [Low] icssm_prueth_tx_enqueue() identifies PRP frames only by checking
  that the last two bytes equal ETH_P_PRP…

--

net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP

This patch adds NETIF_F_HW_HSR_DUP support to the ICSSM PRU ethernet
driver. Each HSR/PRP frame is written once into a TX queue shared by both
PRU ports, and the firmware duplicates it. On receive, a new HostRecv BD
bit is used to drop the duplicate copy, and the driver strips the HSR tag
itself while copying out of OCMC.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index 42c83946f17a7..e5e888a1e6f49 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

[ ... ]

> @@ -608,6 +644,29 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  		free_blocks = buffer_desc_count;
>  	}
>  
> +	/* Fetch queue state for the second LRE port */
> +	if (prueth_is_lre(prueth)) {
> +		queue_desc_other_port = emac->tx_queue_descs_other_port +
> +					queue_id;
> +		bd_rd_ptr_other_port = readw(&queue_desc_other_port->rd_ptr);
> +
> +		read_block_other_port = (bd_rd_ptr_other_port -
> +					 txqueue->buffer_desc_offset) / BD_SIZE;
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
>  	if (pkt_block_size > free_blocks) /* out of queue space */
>  		return -ENOBUFS;

[Severity: Medium]
Can the shared ring wrap onto either port's reader here?

The check accepts pkt_block_size == free_blocks. In that case update_block
lands on the reader's block, so the new wr_ptr equals rd_ptr. The queue
convention is that rd_ptr == wr_ptr means empty, so the firmware would
never send the pending blocks. The next enqueue then sees write_block ==
read_block, takes the "all free" branch and overwrites them.

The own-port calculation had this off-by-one before this patch. The new
free_blocks_other_port calculation repeats it, and the ambiguous wr_ptr
is now written to both firmware consumers.

Should one block always be left unused, for example by rejecting
pkt_block_size >= free_blocks?

> @@ -657,6 +716,51 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  	if (PRUETH_IS_HSR(prueth))
>  		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);
>  
> +	if (prueth_is_lre(prueth)) {
> +		ethhdr = (struct ethhdr *)skb_mac_header(skb);
> +		proto = ethhdr->h_proto;

[Severity: Medium]
Is skb_mac_header() always valid in the xmit path? The rest of
icssm_prueth_tx_enqueue() uses skb->data.

The AF_XDP copy-mode TX path does not seem to reset the mac header:

xsk_build_skb()
  __dev_direct_xmit()
    netdev_start_xmit()
      icssm_emac_ndo_start_xmit()
        icssm_prueth_tx_enqueue()

In that case skb->mac_header still holds its initial ~0 value, and
skb_mac_header() returns skb->head + 0xffff. Would this read h_proto, and
later the HSR tag, from memory about 64KB past the skb head? Those values
then set the LAN/RED BD bits.

Would reading the header from skb->data avoid this?

> +
> +		if (proto == htons(ETH_P_8021Q)) {
> +			vlan_hdr = (struct vlan_ethhdr *)ethhdr;
> +			proto = vlan_hdr->h_vlan_encapsulated_proto;
> +			is_vlan = true;
> +		}
> +
> +		/* Check if the SKB has HSR tag */
> +		if (PRUETH_IS_HSR(prueth) && proto == htons(ETH_P_HSR)) {
> +			hdr = skb_mac_header(skb) + ETH_HLEN;
> +			if (is_vlan)
> +				hdr += VLAN_HLEN;
> +
> +			hsr_tag = (struct hsr_tag *)hdr;
> +
> +			/* PTP frames (ETH_P_1588) are directed frames
> +			 * so skip the duplication
> +			 */
> +			if (hsr_tag->encap_proto != htons(ETH_P_1588)) {
> +				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
> +			} else {
> +				wr_buf_desc |= (txport <<
> +						PRUETH_BD_LAN_A_SHIFT);
> +			}

[Severity: Medium]
With hsr-dup-offload enabled, do PTP frames sent through the HSR master
now go out on only one LAN?

hsr_forward_do() in net/hsr/hsr_forward.c sends the frame on the first
slave and then skips the second:

	if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
		continue;

The HSR core has no ETH_P_1588 exception. Here, though, every frame with
encap_proto == ETH_P_1588 gets only the originating LAN bit. So neither
the HSR core nor the firmware would send the second copy.

This check also cannot tell frames that came through hsr0 apart from
frames that userspace sent on purpose on a single slave.

> +			wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;
> +		} else if (PRUETH_IS_PRP(prueth)) {
> +			/* Check if the SKB has PRP tag */
> +			prp_ethtype = get_unaligned_be16(skb_tail_pointer(skb) -
> +							 ETH_TLEN);
> +
> +			if (prp_ethtype == ETH_P_PRP) {
> +				wr_buf_desc |= PRUETH_BD_LAN_INFO_MASK;
> +				wr_buf_desc |= PRUETH_BD_RED_PKT_MASK;

[Severity: Low]
Should this also check the LSDU size field of the RCT? Only the last two
bytes are compared with ETH_P_PRP. The HSR core's PRP detection checks the
LSDU size as well.

Suppose a non-PRP frame is sent directly on a PRP slave and its payload
happens to end in 0x88fb. Would it be duplicated to both LANs and marked
as a redundancy frame, instead of going out on txport only?

[ ... ]

> @@ -669,6 +773,10 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
>  	update_wr_ptr = txqueue->buffer_desc_offset + (update_block * BD_SIZE);
>  	writew(update_wr_ptr, &queue_desc->wr_ptr);
>  
> +	/* update the write pointer in queue descriptor of other port */
> +	if (prueth_is_lre(prueth))
> +		writew(update_wr_ptr, &queue_desc_other_port->wr_ptr);

[Severity: Medium]
Can queue_desc_other_port still be NULL at this point?

The TX path reads prueth->eth_type several times with no
synchronization:

- icssm_emac_ndo_start_xmit() reads it to pick the lock.
- icssm_prueth_tx_enqueue() reads it to choose the queue table, to set
  up queue_desc_other_port, to set the LAN bits, and once more here.

eth_type can change while a port is transmitting. In
icssm_prueth_hsr_port_unlink(), port 0 is reopened in EMAC mode. If port
1's ndo_open then fails, the old mode is restored without stopping port
0's TX:

	ret = icssm_prueth_change_mode(prueth, PRUSS_ETHTYPE_EMAC);
	if (ret < 0) {
		dev_err(prueth->dev, "Failed to enable dual EMAC mode\n");
		prueth->eth_type = prev_mode;
	}

Suppose an xmit on port 0 sees EMAC at the "Fetch queue state for the
second LRE port" check and HSR here. It would then dereference
queue_desc_other_port while it is still NULL. The free_hsr path in
icssm_prueth_hsr_port_link() has the same pattern in the other direction.

Mismatched reads could also take emac->host_queue_lock while writing to
the shared LRE ring. That lock does not serialize against the other port.

> @@ -681,8 +789,10 @@ void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
>  	else
>  		pkt_info->start_offset = false;
>  
> -	pkt_info->port = (buffer_descriptor & PRUETH_BD_PORT_MASK) >>
> -			 PRUETH_BD_PORT_SHIFT;
> +	/* Flag from BD to indicate packet is valid for HOST or not. */
> +	pkt_info->host_recv_flag = !!(buffer_descriptor &
> +				      PRUETH_BD_HOST_RECV_MASK);
> +

[ ... ]

> @@ -742,11 +856,36 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,

[ ... ]

>  	/* calculate new pointer in ram */
>  	*bd_rd_ptr = rxqueue->buffer_desc_offset + (update_block * BD_SIZE);
>  
> -	/* Exclude the HSR tag bytes already stripped by firmware, if any. */
> -	actual_pkt_len = pkt_info->length - start_offset;
> +	if (PRUETH_IS_HSR(emac->prueth)) {
> +		if (!pkt_info->host_recv_flag)
> +			return 0;
> +
> +		ethhdr = (struct ethhdr *)src_addr;
> +		proto = ethhdr->h_proto;
> +
> +		if (proto == htons(ETH_P_8021Q)) {
> +			has_vlan = true;
> +			vlan_hdr = (struct vlan_ethhdr *)ethhdr;
> +			proto = vlan_hdr->h_vlan_encapsulated_proto;
> +		}
> +
> +		if (proto == htons(ETH_P_HSR) && !pkt_info->timestamp)
> +			has_hsr_tag = true;
> +	}

[Severity: Medium]
Has the driver/firmware contract for HSR RX changed here? And does the
firmware the driver loads match the new contract?

The previous patch in this series trusted the firmware START_FLAG. It
skipped ICSSM_LRE_TAG_SIZE bytes because the tag was "already stripped by
firmware".

icssm_emac_rx_packet() now ignores start_offset in HSR mode. It reads
h_proto at buffer offset 0 and strips the HSR tag itself, except for
timestamped frames. The commit message does not mention that exception.

icssm_parse_packet_info() still fills start_offset from
PRUETH_BD_START_FLAG_MASK for HSR. The kernel-doc in struct
prueth_packet_info still says "true if frame carries an HSR/PRP start
offset".

If the firmware still shifts the frame, the ethertype is read at the
wrong offset. If it does not, the HSR RX path in the previous patch was
already broken, and the series does not bisect cleanly.

Every BD without the new HostRecv bit (bit 10) is now dropped silently.
On the TX side, the driver now relies on firmware support for the shared
queues and the LAN/RED BD bits. icssm_prueth_sw_boot_prus() still loads
the same firmware names, with no version or capability check.

With an older firmware image, would all HSR RX frames be dropped and the
shared TX queue layout be ignored?

[ ... ]

> @@ -1568,19 +1726,22 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
>  static netdev_features_t icssm_emac_ndo_fix_features(struct net_device *ndev,
>  						     netdev_features_t features)
>  {

[ ... ]

>  	if (!(ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES))
>  		if ((features & NETIF_F_HW_HSR_FWD) ||
> -		    (features & NETIF_F_HW_HSR_TAG_RM))
> +		    (features & NETIF_F_HW_HSR_TAG_RM) ||
> +		    (features & NETIF_F_HW_HSR_DUP))
>  			features |= NETIF_PRUETH_LRE_OFFLOAD_FEATURES;

[Severity: Medium]
What happens if hsr-dup-offload is enabled on only one of the two ports?

This check only looks at the current device. With both ports down, DUP
can be enabled on just the port that later becomes HSR slave B.

When hsr0 is created, icssm_prueth_ndev_event() calls
icssm_prueth_hsr_port_link() only for ports that have
NETIF_PRUETH_LRE_OFFLOAD_FEATURES set. So hsr_members never equals
all_slaves, the firmware stays in dual EMAC mode, and linking still
succeeds.

hsr_forward_do() then sends on slave A, which has no DUP, and skips slave
B because B advertises NETIF_F_HW_HSR_DUP. In EMAC mode the frame sent on
A is not duplicated, so only LAN A receives it.

Should NETIF_F_HW_HSR_DUP be rejected or cleared when offload mode is not
actually active?

>  
>  	if ((ndev->features & NETIF_F_HW_HSR_FWD) ||
> -	    (ndev->features & NETIF_F_HW_HSR_TAG_RM))
> +	    (ndev->features & NETIF_F_HW_HSR_TAG_RM) ||
> +	    (ndev->features & NETIF_F_HW_HSR_DUP))
>  		if (!(features & NETIF_F_HW_HSR_FWD) ||
> -		    !(features & NETIF_F_HW_HSR_TAG_RM))
> +		    !(features & NETIF_F_HW_HSR_TAG_RM) ||
> +		    !(features & NETIF_F_HW_HSR_DUP))
>  			features &= ~NETIF_PRUETH_LRE_OFFLOAD_FEATURES;

[Severity: Medium]
Does coupling three features here break enabling them one at a time?

__netdev_update_features() starts from dev->wanted_features, and
ethnl_set_features() adds only the requested bits to wanted_features. The
bits that this function turns on automatically never get into
wanted_features.

For example, with both ports down:

  ethtool -K eth2 hsr-tag-rm-offload on
    wanted = TAG_RM
    first block sets all three: features = FWD | TAG_RM | DUP

  ethtool -K eth2 hsr-fwd-offload on
    wanted = TAG_RM | FWD
    first block skipped because ndev->features has LRE bits
    second block sees !(features & NETIF_F_HW_HSR_DUP), clears all three

So all three offloads end up off, the opposite of what was requested.
With only two coupled bits, the same sequence left both enabled.

Similarly, after "ethtool -K ethX hsr-dup-offload on", wanted_features
holds only DUP. Any later recompute, such as toggling an unrelated
hw_feature, would then clear all three.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005154654.576663-1-parvathi%40couthit.com
