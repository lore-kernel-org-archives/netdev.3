Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC02EB5A6;
	Sat, 10 Oct 2026 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672928; cv=none; b=qijjnGQ3rAoF8S6hUNqjE8n0p3nWtYZOZ4IJ31K5cFnnMBGpYRoX4RfqPGPCt+J6IgqLE7g7tkGj8ihMIpy+nGo5gJF07iRYJjgbwahF00lxQRkhEY44hnbuaJx3dp+jAqgf8g8EPiPrT6mxUvon4IIRE/c4/ENjFqgV0qB6jpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672928; c=relaxed/simple;
	bh=8tW8rAE+eE/eNh5YcVMToCv90gA/Ws9SqwXJci1pu9k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocltdTxkUiweY3bfu61nJr3AcWdxcj9Rg7kCDvoJXGOCagDogeVx6AkiA9/RhEb4gneajcdaG8oJWVSSYJtd++fFYIjGkkVSquW/SE1oHEkcqXrG41sjgDv1Ps+tg2RwsQfJSofteu48rFWRNChiynHDSy2sWBuQKPzyCap/n1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOvZgFyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOvZgFyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD8D1F000FF;
	Sat, 10 Oct 2026 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791672927;
	bh=UFidDHfPgzSoA+VCpVceQ/Rf0gYg4cuwioXX6rky4GM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oOvZgFyPqIubc5nSKNOZ4bK6cy43etI+AgunHHUSja+SMd/twzZaX3vBj08b3IUZ3
	 snt79imNWKcgEpocdB+ieMFQO2y8NXcampCngHsdoEqYnRamU2+KwCO/M0UTHk0xbx
	 bilOUMRr/aeAQMoDhIADJi0S/Gj/kbau4i1jAUZaHGZYnzv+M9GmTGUqH4rvZP0h7p
	 NygrULrLDnx9Omm4iLuDgdLUA4eh1NPNJYZweriwS4ZKB4V0/AL3cU+1Mcw3dnLNFR
	 pezJdeSWjW96rSn4j3y15EtB70tEd2fRm9yh6508ggfZodnoohdPLj9VYyluIVc77l
	 L/+ZoEFb/pd5g==
Subject: Re: [PATCH net-next v2 2/2] bnxt_en: Pad short SW USO segments to
 BNXT_MIN_PKT_SIZE
From: netdev-bot+sashiko@kernel.org
To: joe@dama.to
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 22:55:25 +0000
Message-ID: <179167292595.434549.1613365899561738680@kernel.org>
In-Reply-To: <20261009215426.2377946-3-joe@dama.to>
References: <20261009215426.2377946-3-joe@dama.to>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch fixes a bug in released kernels but has no `Fixes:`
  tag and no `Cc: stable`.
- [Low] The patch adds a drop that the commit message never mentions.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  `bnxt_sw_udp_gso_xmit()` never checks hdr_len against TSO_HEADER_SIZE…

--

bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE

This patch pads a short last SW USO segment to BNXT_MIN_PKT_SIZE. The pad
bytes are zeroed in the inline header slot and sent through an extra pad BD.
When gso_size is too small for any segment to reach the minimum,
bnxt_features_check() clears the GSO features. If such skbs still reach
bnxt_sw_udp_gso_xmit(), they are dropped there.

> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Joe Damato <joe@dama.to>

[Severity: Medium]
Should this have a Fixes: tag and Cc: stable, and go to net?

bnxt_sw_udp_gso_xmit() has not padded segments since it was added in:

  cc5d90667db8 ("net: bnxt: Implement software USO")

That commit is already in released kernels.

When BNXT_FLAG_UDP_GSO_CAP is clear, bnxt_start_xmit() passes every
SKB_GSO_UDP_L4 skb to bnxt_sw_udp_gso_xmit(). It returns before the
skb_put_padto(skb, BNXT_MIN_PKT_SIZE) call, so stable trees with SW USO
still send frames shorter than 52 bytes.

The companion fix a51d233ccd48 ("bnxt_en: fix DMA mapping length for
padded small packets") was sent with Fixes: and Cc: stable. Its changelog
says:

    Note that SW USO segments are still not padded: with IPv4, a segment
    carrying less than 10 bytes of UDP payload (small gso_size, or a short
    last segment) is sent as a frame shorter than BNXT_MIN_PKT_SIZE.
    This is a separate issue, left for a followup patch.

This patch looks like that followup. However, it is based on net-next, after
the prep patch "bnxt_en: Add helper to fill SW USO payload BDs".

Would something like this be appropriate?

  Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> index ef04c9d08066d..80d5c4f963a95 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
> @@ -82,11 +82,19 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
>  	if (unlikely(num_segs <= 1))
>  		goto drop;
>  
> +	/* bnxt_features_check() makes the stack segment these, but paths
> +	 * that skip validate_xmit_skb() (e.g. generic XDP_TX of a GRO'd
> +	 * skb) can still get here. Padding every segment would need more
> +	 * BDs than bds_needed reserves below, so drop instead.
> +	 */
> +	if (unlikely(bnxt_sw_gso_pad_len(hdr_len, mss)))
> +		goto drop;

[Severity: Low]
Could the commit message mention this new drop?

The changelog only says that bnxt_features_check() clears the GSO features
so the stack segments these skbs. That covers callers that go through
validate_xmit_skb(), but not callers that skip it, for example:

  generic_xdp_tx()
    netdev_start_xmit()
      bnxt_start_xmit()
        bnxt_sw_udp_gso_xmit()

On these paths, when hdr_len + gso_size is below BNXT_MIN_PKT_SIZE, the skb
is now freed and tx_dropped is incremented. Before this patch the skb was
sent as short segments. The comment in the code explains this, but the
changelog does not mention it.

[ ... ]

> @@ -133,12 +141,14 @@ int bnxt_sw_udp_gso_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,

[ ... ]

>  		last = (i == num_segs - 1);
> +		pad = bnxt_sw_gso_pad_len(hdr_len, seg_payload);
>  		offset = slot * TSO_HEADER_SIZE;
>  		this_hdr = txr->tx_inline_buf + offset;
>  		this_hdr_dma = txr->tx_inline_dma + offset;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Is hdr_len
ever checked against TSO_HEADER_SIZE before tso_build_hdr() copies the
header into this slot?

Each slot is TSO_HEADER_SIZE (256) bytes. They sit in tx_inline_buf, which
bnxt_alloc_tx_inline_buf() allocates with kmalloc() as
BNXT_SW_USO_MAX_SEGS * TSO_HEADER_SIZE bytes. tso_build_hdr() then does:

net/core/tso.c:tso_build_hdr() {
	int hdr_len = skb_transport_offset(skb) + tso->tlen;
	...
	memcpy(hdr, skb->data, hdr_len);
	...
}

The driver then writes uh->check at skb_transport_offset(skb).

If hdr_len is larger than 256, can this overwrite the next slots? For the
last slot, can it write past the end of the tx_inline_buf allocation?

The validate_xmit_skb() path seems safe. bnxt advertises NETIF_F_IPV6_CSUM,
so gso_features_check() removes NETIF_F_GSO_UDP_L4 from IPv6 skbs with
extension headers.

The paths that skip validate_xmit_skb(), which the new comment above
mentions, do look reachable. One example is a remote peer sending IPv6/UDP
datagrams with large hop-by-hop or destination options headers, which
ipv6_gro_pull_exthdrs() merges. The skb then takes this path:

  __netif_receive_skb_core()
    do_xdp_generic()   /* XDP_TX */
      generic_xdp_tx()
        netdev_start_xmit()
          bnxt_start_xmit()
            bnxt_sw_udp_gso_xmit()

Neither bnxt_features_check() nor bnxt_exthdr_check() runs on this path.

A generic XDP program that prepends bytes with bpf_xdp_adjust_head() can
also make the transport offset larger. bpf_prog_run_generic_xdp() only
resets the network header.

Would it make sense to drop skbs with hdr_len > TSO_HEADER_SIZE next to the
new bnxt_sw_gso_pad_len() check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009215426.2377946-1-joe%40dama.to
