Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FD49A3D4;
	Tue,  6 Oct 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298853; cv=none; b=Jieb6zJOF7yhWP3CyjTS0y/jXXZniRnamfZxvPpNknjaKaWmW5TVJwL1X6jlw01yo3uA1kc3txEFewWF6eoIf2p9MC73UKuAIwJbYgFSPMaFq1bPNCtxUS3wCUcWoOE8V+8UQ8xGEChuIi+VdpsEJtaf16kKGTzZrsaqJ11EyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298853; c=relaxed/simple;
	bh=7g4Smrx8884lwN5v+obe08hYFPCt/AWdmPKUfDj0BEk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3ukAo3OovQvtnWf4lyk0p7r/skDie+/KqDJMnMOyCZIfabdkHk+mh5flTaKufyy6oKRbyG2TyZYC3An8Az4sxmvcKF1Q5+NpFcLsjUHvz8xSDRUmghGEypThm0RMbQgaAfNfYx9DKs3NNJOIcNx4O4nJbpeYi57/4ot7UMJVSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N27VYqLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N27VYqLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9712F1F0089D;
	Tue,  6 Oct 2026 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298851;
	bh=KB01WqDJzhhYagPaxv84HFTqXtdUStrY+p0yDAzY9ZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N27VYqLbAtWUglOz9zHsXyDvlI6o3nRkiR02pzWnwyo7Z9b0vcPI31NDWeRamh8SP
	 QrI+Q6kanL085azGRvz3LE3aZuNI0OyqzNBoWZU1ddSxSpUi29v97jTJUG34DHFGqL
	 HZL3tbSbs+P6PDX5X363MJlNWQiT7kBZhq7Z+uz8t32GAQXpqqyvZVXe2o/DsPiMf0
	 GHJWPARG9+EMSsTQLheV+QbPxMImrwc3KPeyM1TTBICRBndbVadVLu9CXywGy3KXlw
	 RMytU+gPwLhmyxM9gvcfdEYHQxdqd50TNryElh5JjML+YmvagWr7OiVQxvOsHhZBhS
	 QiAlY5wDws7pA==
Subject: Re: [PATCH net-next 4/4] net: rmnet: optimize rx handler by replacing
 skb_linearize with pskb_may_pull
From: netdev-bot+sashiko@kernel.org
To: koen.vandeputte@citymesh.com
Cc: netdev@vger.kernel.org, quic_subashab@quicinc.com,
 quic_stranche@quicinc.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 15:00:50 +0000
Message-ID: <179129885016.434549.7297882654644186322@kernel.org>
In-Reply-To: <20261002143529.3217189-5-koen.vandeputte@citymesh.com>
References: <20261002143529.3217189-5-koen.vandeputte@citymesh.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Regression in rmnet_rx_handler()
  (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:220): the patch…
- [Medium] The commit message misstates what the RX path needs and what
  the change does, and it hides that the patch undoes a crash fix.
- [Medium] Shared skb data modified without copy-on-write for non-linear
  cloned MAP command packets.

--

net: rmnet: optimize rx handler by replacing skb_linearize with pskb_may_pull

This patch replaces the unconditional skb_linearize() in rmnet_rx_handler()
with pskb_may_pull() of sizeof(struct rmnet_map_header). After the change,
only the 4-byte MAP header is guaranteed to be in the linear area. The goal
is to avoid copying large aggregated frames on the RX path.

> When receiving large, hardware-aggregated frames
> (e.g., 16KB or 32KB from USB modems via qmi_wwan),
> this forces the network stack to allocate a massive
> contiguous buffer and memcpy the entire scattered payload
> out of paged memory.

[ ... ]

> On a slower embedded board, this improves throughput by ~10%.

[Severity: Medium]
Can the throughput gain come from this change in the qmi_wwan setup?
skb_linearize() is:

	return skb_is_nonlinear(skb) ? __skb_linearize(skb) : 0;

That makes it a no-op for linear skbs. The usbnet rx_submit() path used by
qmi_wwan allocates linear skbs with __netdev_alloc_skb().

The only skbs this change affects are non-linear ones. Those are the skbs
that then reach the linear-only parsers described below.

> This severe performance bottleneck is completely unnecessary
> because the RX handler only needs to inspect the initial
> 4-byte MAP header to determine the logical endpoint
> and route the packet.

Is this description accurate? The same RX path goes on into
rmnet_map_deaggregate(), rmnet_map_validate_packet_len(),
rmnet_map_process_next_hdr_packet(), rmnet_map_checksum_downlink_packet()
and rmnet_map_command(). All of them access the full frame through
skb->data.

> This preserves the zero-copy architecture for aggregated frames,
> drastically reducing CPU overhead, cache thrashing,
> and memory allocations on the RX hotpath.

The aggregated path doesn't look zero-copy. rmnet_map_deaggregate()
allocates a new skb for each record and copies into it:

drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c:rmnet_map_deaggregate() {
    ...
	skbn = netdev_alloc_skb(skb->dev, packet_len + RMNET_MAP_DEAGGR_SPACING);
    ...
	memcpy(skbn->data, skb->data, packet_len);
	skb_pull(skb, packet_len);
    ...
}

The commit message also leaves out commit d698e6a00a60 ("net: qualcomm:
rmnet: Fix rx_handler for non-linear skbs"). That commit added this
skb_linearize() to fix crashes with non-linear skbs. Should it be
mentioned here?

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> index 95c3e3934fd3c..a2379df69a6d0 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> @@ -217,7 +217,7 @@ rx_handler_result_t rmnet_rx_handler(struct sk_buff **pskb)
>  	if (!skb)
>  		goto done;
>  
> -	if (skb_linearize(skb)) {
> +	if (!pskb_may_pull(skb, sizeof(struct rmnet_map_header))) {

[Severity: Critical]
Does this bring back the crash fixed by commit d698e6a00a60 ("net:
qualcomm: rmnet: Fix rx_handler for non-linear skbs")? That commit says:

  There is no guarantee that rmnet rx_handler is only fed with linear
  skbs, but current rmnet implementation does not check that, leading
  to crash in case of non linear skbs processed as linear ones.

Now only 4 bytes are guaranteed to be linear. The downstream parsers still
treat skb->data as covering the whole frame. They check lengths only
against skb->len, which includes paged and frag_list data.

Non-linear input does happen in-tree. For example, mhi_net_skb_agg() in
drivers/net/mhi_net.c builds frag_list skbs that end up in rmnet.

With RMNET_FLAGS_INGRESS_DEAGGREGATION:

rmnet_rx_handler()
  rmnet_map_ingress_handler()
    rmnet_map_deaggregate()
      rmnet_map_validate_packet_len()
          if (skb->len < packet_len)
              return 0;
      memcpy(skbn->data, skb->data, packet_len);
      skb_pull(skb, packet_len);

Won't the memcpy() read past skb->tail into tailroom and skb_shared_info?
That memory would then be copied into the packet delivered to the stack.

When packet_len > skb_headlen(skb), __skb_pull() would also hit:

	skb->len -= len;
	if (unlikely(skb->len < skb->data_len)) {
		...
		BUG();

The MAPv5 next_hdr at data + sizeof(*maph) in
rmnet_map_validate_packet_len() is also read without a pull.

Without deaggregation, __rmnet_map_ingress_handler() has similar problems:

- MAPv5: rmnet_map_process_next_hdr_packet() reads next_hdr at
  skb->data + sizeof(struct rmnet_map_header). Then 4 + 4 bytes are
  pulled in total, so BUG() fires when the linear head is shorter than
  8 bytes.

- MAPv4: rmnet_set_skb_proto() reads skb->data[0] after the MAP header
  has been pulled. rmnet_map_checksum_downlink_packet() dereferences
  skb->data + len, and len comes from the device-supplied pkt_len. The
  IPv4/IPv6 helpers also read IP and L4 headers at raw skb->data offsets.
  Could the CHECKSUM_UNNECESSARY verdict end up computed from
  out-of-bounds memory?

- skb_trim(skb, len) goes through __skb_trim()->__skb_set_length(). That
  does WARN_ON(skb_is_nonlinear(skb)) and returns without trimming, so MAP
  padding and the checksum trailer would reach the IP stack.

With RMNET_FLAGS_INGRESS_MAP_COMMANDS, rmnet_map_command() reads
cmd->command_name at map_header + 1, and rmnet_map_send_ack() writes:

	cmd = (struct rmnet_map_control_command *)(map_header + 1);
	cmd->cmd_type = type & 0x03;

Is this an out-of-bounds write when only the MAP header is linear? The
skb_trim() in rmnet_map_send_ack() would also hit the nonlinear WARN.

The aggregation section of
Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst also
says the MAP packets are "delivered to rmnet in a single linear skb".

Would it be better to keep the linearization? The alternative is to make
every parser frag-aware:

- per-record pskb_may_pull() or skb_copy_bits(), or clone plus
  pskb_trim(), in deaggregation
- pulls for the csum header, the trailer and the command
- pskb_trim() instead of skb_trim()

A single 4-byte pull at the top doesn't seem to be enough.

[Severity: Medium]
Can this leave the head of a cloned non-linear skb shared when rmnet later
writes to it?

If a packet tap is active on the real device, packet_rcv() in
net/packet/af_packet.c sees skb_shared() and queues a skb_clone(). The skb
that rmnet_rx_handler() then receives is skb_cloned().

Before this patch, skb_linearize() on a non-linear skb went through
__pskb_pull_tail(), which does:

	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))

That gave rmnet a private head. pskb_may_pull(skb, 4) returns early when
the MAP header is already linear, so the head stays shared.

With RMNET_FLAGS_INGRESS_MAP_COMMANDS and without deaggregation,
rmnet_map_command()->rmnet_map_send_ack() then does:

	cmd->cmd_type = type & 0x03;

There is no skb_cow() or skb_ensure_writable() before this write. Would
the packet socket reader then see the captured command request changed
into an ACK? The netif_tx_lock() taken afterwards doesn't serialize
against that reader.

The same write already happened for linear cloned skbs before this patch.
The non-linear cloned case is what this patch adds.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002143529.3217189-1-koen.vandeputte%40citymesh.com
