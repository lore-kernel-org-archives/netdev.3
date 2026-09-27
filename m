Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4633F105F
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515469; cv=none; b=XYP+nC63coE/yq49a6pfGLelyLGQgkyknl8aQqGWFsRbB3aTdNcAGq87zKvdSBxvjxxCU+Oc4N+VEA712vngmL3lWu9gfaqKh47SdNfT2UKI+JJS0KA4nlMQ/Y4e9jj3dxjl37pWXNfwNXxB+DtqsvckGoy6JLKHv/VaP7yGbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515469; c=relaxed/simple;
	bh=tiK8frxJvv94Zt4/bZU2kkv5mFO/hS1JNcHI3kNrBjY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrNjkM6Gkfr7nXL2HlUY7+G7gMs6MTLt0o8YAugFfkkGR45/NpC7TVZtsSvBfAzjRRyfk9uK6elAMXNjXlrKGMPlgx+qMItrHSjFsCMd8NMfdylSr8LS2P/jKHGrnpwroT5Lj5Pho0obSxcB1yOUJOa5m5gnnNqWstziAvVStyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDN25UbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDN25UbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1C21F000FF;
	Sun, 27 Sep 2026 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515467;
	bh=vGG1e2Kb2EUkFBTSzHMrJDVKvAe/euvKakHL86oopEg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dDN25UbY0i3bmOQ7ISn9oI/7ievDoZHMOAkFfAvbXLuy1T3i3T6AMI4ZicQHb9n/t
	 2PJihtT18V2iAbqKgu+6BrzaNBijgsFtqRswEp8CdlyTvlDwPVsGd9bTls3ZdQrthe
	 R4+WZlGNGux29QmUPQl0InKuxqJ7+pKHNlS3T4Oi35m+HpbZyk5VTXjHVtjDz0o5D8
	 1f8rxxkpcpwZ839MYO36G+PQ3e4OGytl1nKKEA8Sa494UFmPsXkEtQTVH3XFVK26Hj
	 BcYWfKXDytnmjiLvQtOqnGF28ozOZOXi6TgbyDwwgQE8DrUQOiuLgPLeUBOX1mMNsF
	 6EvqfeUDITxBg==
Subject: Re: [PATCH net-next v6 5/8] hsr: Use the port and header information
 in hsr_forward_skb()
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Sun, 27 Sep 2026 13:24:26 +0000
Message-ID: <179051546635.2160803.2544150614309315963@kernel.org>
In-Reply-To: <20260923-hsr_ptp-v6-5-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-5-6ea07b3fb8a8@linutronix.de>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes the per-protocol
  hsr_proto_ops->fill_frame_info callback responsible for handling…
- [Medium] hsr_forward_do() now applies the requested TX port
  (`frame->req_tx_port != port->type` then continue) and the pre-built-…

--

hsr: Use the port and header information in hsr_forward_skb()

This commit makes hsr_forward_skb() use the TX port requested by the upper
layer, and a flag that says the skb already carries an HSR header. When the
header is present, the forwarding path skips sequence number assignment,
node lookup and source address substitution, and sends a clone of the frame
unchanged on the requested port.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index bb111a18d24e9..b68aada1a1393 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -575,6 +576,17 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
>  			continue;
>  
> +		/* PTP TX packets have an outgoing port specified */
> +		if (frame->req_tx_port != HSR_PT_NONE && frame->req_tx_port != port->type)
> +			continue;
> +		/* PTP TX packets may already have a HSR header which needs to
> +		 * be preserved
> +		 */
> +		if (frame->has_foreign_header && frame->skb_std) {
> +			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +			goto inject_into_stack;
> +		}
> +

[Severity: Medium]
How does this work on slave ports that advertise NETIF_F_HW_HSR_DUP or
NETIF_F_HW_HSR_TAG_INS?

The commit message says "If the port set, deliver it only on the requested
port". Here, though, the port is only selected in software. After
dev_queue_xmit() hands the frame to the requested slave, the lower device
may still duplicate it. For DSA, dsa_xmit_port_mask() in net/dsa/tag.h
does:

	if (IS_ENABLED(CONFIG_HSR) &&
	    unlikely(dev->features & NETIF_F_HW_HSR_DUP)) {
		...
		dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
			mask |= BIT(other_dp->index);

tag_ksz.c and tag_xrs700x.c both use this. The TI icssg driver also sends
the frame as undirected when NETIF_F_HW_HSR_DUP is set.

Would a PTP message meant for one port then go out on both rings?

For NETIF_F_HW_HSR_TAG_INS, hsr_create_tagged_frame() normally leaves tag
insertion to the hardware:

	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
		return skb;

The new has_foreign_header branch skips that. It passes a frame that is
already tagged to hardware that is set up to insert its own tag. Depending
on the device, could that produce a second HSR tag or a sequence number
assigned by the hardware?

A later patch in this series ("hsr: Move struct hsr_ethhdr to a global
header") notes that when offloading, the network driver has to inspect the
HSR header to turn off offloading for PTP. However, the series doesn't
change any driver or tagger.

Should this path reject the offloaded case, or handle it?

[ ... ]

> @@ -666,6 +679,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *skb,
>  	struct hsr_port *port = frame->port_rcv;
>  	struct hsr_priv *hsr = port->hsr;
>  
> +	if (frame->has_foreign_header) {
> +		frame->skb_std = skb;
> +
> +		WARN_ON_ONCE(port->type != HSR_PT_MASTER);
> +		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
> +		return 0;
> +	}

[Severity: Medium]
Does prp_fill_frame_info() need the same early return?

The generic code now assumes that every proto_ops->fill_frame_info()
handles has_foreign_header:

- fill_frame_info() skips hsr_get_node(), so node_src stays NULL.
- hsr_forward_skb() skips hsr_register_frame_in().
- The bypass in hsr_forward_do() only runs if frame->skb_std is set.

Only hsr_fill_frame_info() was updated, though. hsr_dev_xmit() accepts
hsr_hdr and tx_port without checking hsr->prot_version. A PRP device can
therefore reach prp_fill_frame_info() with has_foreign_header set.

If the frame has a valid PRP RCT, prp_fill_frame_info() does:

	frame->skb_hsr = NULL;
	frame->skb_std = NULL;
	frame->skb_prp = skb;

hsr_forward_do() then skips the bypass and sends the frame through
prp_create_tagged_frame(). That function calls prp_set_lan_id() on the
caller's trailer in place. It then returns skb_clone(frame->skb_prp) with
no socket owner.

Wouldn't that change the header that should be preserved, and also lose
the PTP TX timestamp? The later patch "hsr: Assign a socket for cloned
skbs" only covers hsr_create_tagged_frame() and the foreign-header branch.

If there is no valid RCT, handle_std_frame() still takes and increments
hsr->sequence_nr. The frame is then sent unchanged by the bypass, so the
sequence number is never used.

On these PRP paths, node_src being NULL doesn't seem to be dereferenced
today. That only holds because of how prp_register_frame_out() is
currently written and because the master port is skipped.

Could has_foreign_header handling be added to prp_fill_frame_info()? The
other option would be for hsr_dev_xmit() to reject hsr_hdr and tx_port on
PRP devices.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-hsr_ptp-v6-0-6ea07b3fb8a8%40linutronix.de
