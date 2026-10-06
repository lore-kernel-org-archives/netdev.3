Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FB456DE1
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297077; cv=none; b=LH3ymmkUUYITfr/e8e/wIIrqUdTdM59mNSCZb7H9GsKN0o/rovd6GO8YmD/t7aR/EIq09++D8mx1RMiQC94JISecny2m288Rh2npZCmNQ6UYl5QA816YKtxBdTfpUX/ToqZ0/8kZrPMeNlJgWk24SJgQUJFar5Vrq8txw2TxNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297077; c=relaxed/simple;
	bh=yfHQZvCAVD8HAoY2CMhccKGyU5IAToLRAUGY1/Wd2G4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gWKMzrFK8cSTd/Y2CNx9VxSdfm8syL5tTk9zGV9G5GjlR/Ge6ti1nUk7x8o8MaDdldOTdX+tHlgshX0TzFXfySHvgy3FtPEz/R1M+9LwM7zfBotUXgrFe7/Io8vohzahAZGnwJVyrZcpHt7pdyF/NU9uRP7Lqaf33HsUqM64JqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0mD3RoY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0mD3RoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F78C1F0089C;
	Tue,  6 Oct 2026 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297075;
	bh=aU6Fshto+Yj/UeByyhutmnVXQ2wvMRFt9x2RVbzeV2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V0mD3RoYls+uAKTlUj1QzxAXwEROFFQdSCtGsFBIcaPpV++m54Kr1VaUT5Ao8c1aV
	 GHXalFwPk77FxrLygazR/aSvkCe5oRFV2ZFErgVgrl/9zFuiN5iqQJrX5TmGnQqqia
	 VVVVchK4yft0KjwS3keMpL6LmcXPQl+NeNv/wvWOsmPcy7yKWtmiA+S0nBp0qVyI0B
	 ajgkR8psDxsFCE+1INjhuVS3NxP5HmUmZxlSB13G81CtYNo5jSQ7pCOKqfsNXeo3l8
	 BcYn071aNwBORgTrzShBnE0TUzcnBrda2Z28lFVjY3JGil39LkopHPSmlunurBbcw/
	 Qm1dFXEMxyRcA==
Subject:
 Re: [PATCH net-next v8 2/8] hsr: Use skb_clone() while adding the HSR header
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 06 Oct 2026 14:31:13 +0000
Message-ID: <179129707396.434549.16689509180703800541@kernel.org>
In-Reply-To: <20261002-hsr_ptp-v8-2-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-2-60dabc07e554@linutronix.de>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Because of the switch from __pskb_copy() to skb_clone() +
  skb_cow_head(), skb_shared_info.meta_len (XDP metadata) of…
- [Low] The commit message does not mention that the patch changes the
  header layout of the software-tagged skb in hsr_create_tagged_frame()…
- [Low] In the software-tagging path, hsr_create_tagged_frame() now gives
  each slave an skb_clone() whose shinfo (shared, then copied by…

--

hsr: Use skb_clone() while adding the HSR header

This patch changes hsr_create_tagged_frame() to use skb_clone() and then
skb_cow_head() instead of __pskb_copy(). The goal is to keep
skb_shared_info, and with it any timestamp request, on the software
tagging path. The offloaded NETIF_F_HW_HSR_TAG_INS case now returns right
after the clone.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 44f6d9c83180a..73bc4b8950071 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -342,33 +342,41 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  		/* set the lane id properly */
>  		hsr_set_path_id(frame, hsr_ethhdr, port);
>  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
> -	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> -		return skb_clone(frame->skb_std, GFP_ATOMIC);
>  	}
>  
> -	/* Create the new skb with enough headroom to fit the HSR tag */
> -	skb = __pskb_copy(frame->skb_std,
> -			  skb_headroom(frame->skb_std) + HSR_HLEN, GFP_ATOMIC);
> +	skb = skb_clone(frame->skb_std, GFP_ATOMIC);

[Severity: Low]
Each per-slave skb now keeps SKBTX_HW_TSTAMP, SKBTX_SW_TSTAMP,
SKBTX_SCHED_TSTAMP and tskey in its shinfo. However, __skb_clone() leaves
it without an owning socket:

net/core/skbuff.c:__skb_clone() {
    ...
	n->sk = NULL;
	__copy_skb_header(n, skb);
    ...
	n->destructor = NULL;
    ...
}

Will a slave driver with hardware timestamping enabled now take a TX
timestamp for this clone, only for __skb_tstamp_tx() to discard it?

net/core/skbuff.c:__skb_tstamp_tx() {
    ...
	if (!sk)
		return;
    ...
}

Before this patch, __pskb_copy() did not carry these flags over on the
software path, so the slaves never saw these requests. Some NICs have only
a single in-flight TX timestamp slot. On those, a concurrent PTP request on
the same slave might be skipped.

The later patch "hsr: Assign a socket for cloned skbs" calls
skb_set_owner_w() only when frame->req_tx_port != HSR_PT_NONE. Ordinary
traffic sent over hsr0 by a socket with SOF_TIMESTAMPING_TX_HARDWARE would
still reach this through:

hsr_dev_xmit()->hsr_forward_do()->hsr_create_tagged_frame()->
    hsr_xmit()->dev_queue_xmit()

The NETIF_F_HW_HSR_TAG_INS path already sent sk-less clones like this
before the patch. Should the timestamp request flags be cleared on clones
that have no socket attached?

>  	if (!skb)
>  		return NULL;
> -	skb_reset_mac_header(skb);
>  
> -	if (skb->ip_summed == CHECKSUM_PARTIAL)
> -		skb->csum_start += HSR_HLEN;
> +	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
> +		return skb;
> +
> +	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
> +	if (skb_cow_head(skb, HSR_HLEN))
> +		goto err;
>  
>  	movelen = ETH_HLEN;
>  	if (frame->is_vlan)
>  		movelen += VLAN_HLEN;
>  
> +	/* The entire header area needs to be linear */
> +	if (!pskb_may_pull(skb, movelen))
> +		goto err;
> +
>  	src = skb_mac_header(skb);
>  	dst = skb_push(skb, HSR_HLEN);
>  	memmove(dst, src, movelen);

[Severity: Medium]
Can skb_shared_info.meta_len end up describing the wrong bytes here?

skb_clone() shares the shinfo of frame->skb_std. pskb_expand_head() then
copies both the shinfo and the head contents, so the XDP metadata length is
kept. __pskb_copy() used a fresh shinfo, so meta_len used to be 0 on this
path.

skb_metadata_end() returns skb_mac_header(). This code pushes HSR_HLEN,
moves only the ETH(+VLAN) header 6 bytes earlier and resets mac_header. As
a result, the range [mac - meta_len, mac) begins with 6 bytes that are not
metadata, followed by only the first meta_len - 6 bytes of the original
metadata. The memmove() also overwrites the last 6 bytes of the original
metadata with the start of the Ethernet header.

The kernel-doc of pskb_expand_head() says:

net/core/skbuff.c:
 *	Note: If you skb_push() the start of the buffer after reallocating the
 *	header, call skb_postpush_data_move() first to move the metadata out of
 *	the way before writing to &sk_buff->data.

__vlan_insert_inner_tag() follows that rule.

In RedBox mode, an skb with XDP metadata received on the interlink port
(generic or native XDP calling skb_metadata_set()) takes this path for
each slave:

hsr_handle_frame()->hsr_forward_skb()->handle_std_frame()->
    hsr_forward_do()->hsr_create_tagged_frame()

A tc BPF program on slave egress that reads __sk_buff->data_meta would
then see misaligned and partly overwritten metadata.

Should this use skb_postpush_data_move(), or clear the metadata with
skb_metadata_clear() after the clone?

> +	skb_set_network_header(skb, HSR_HLEN + movelen);
>  	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);

[Severity: Low]
The commit message only covers preserving skb_shared_info for timestamps:

    hsr_create_tagged_frame() creates a new skb where the HSR header can be
    prepended via __pskb_copy(). This does not copy the skb_shared_info part
    of the original skb so any timestamp request is lost.

Could the changelog also mention the header layout changes made here?

With the old code, __pskb_copy() only ran skb_copy_header(), so the
head-relative offsets were copied unchanged into a buffer with HSR_HLEN
more headroom. Only mac_header and csum_start were fixed up afterwards.
That left network_header pointing at the HSR tag, transport_header
HSR_HLEN bytes too early, and mac_len at 14 (18 with VLAN).

With this patch:

- skb_cow_head()->pskb_expand_head()->skb_headers_offset_update() moves
  all offsets, which replaces the manual csum_start adjustment.
- network_header now points past the HSR tag.
- mac_len becomes 20 (24 with VLAN).
- A new pskb_may_pull() drop path is added.

So the patch fixes the transport_header offset and changes what
network_header and mac_len mean for these frames. Neither change is
described in the changelog.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-hsr_ptp-v8-0-60dabc07e554%40linutronix.de
