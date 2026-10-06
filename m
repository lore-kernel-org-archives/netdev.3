Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C747125F
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297078; cv=none; b=NM1eFBHdiILyjsFmYrzSaoajRSS4r7j/fQQnMbtHsNceuNGa+7Wx7xUd/VXqLNJl2JzUzpq+B1gQ6J5+wd5YrOkxsZ+OLWsyenzhLqMaMdgllNkPb9RycGfEJyTW0qoRheOAjHwfuhZ/EMAxv87qEtRS/Oi+gmP/ExHsjbkfHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297078; c=relaxed/simple;
	bh=HlXn+FtkBFTqqln/gxeIdzNBdfoXh+AwkX0gwDP1Flk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7rSh7sx3brcQ1HRUjRhxl9FdmWeh0/rJFD5fatkaOi0Lz7E+5XNmgg+/Xk+/pHYqbg2vHEayYTeYWvKWNMCNl7yLaWi27hBMDTB5iRRfg6zjlszWF4uqE0Ht4VC3gEdk6QwQuS7kXzXLWbLOdifctoVe/dF/D3MrEha5/pf/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2JKM5Ys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2JKM5Ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3D41F0089B;
	Tue,  6 Oct 2026 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297077;
	bh=xEikQtY+9pJcJ2gbkRfEGnrtm/DO5uhTissnAke5xho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X2JKM5YsOqzV63zzsZqTiJiPh5s+ERdS53xXa+8fB0bYAYo6tWcty/D37Yp0a6hF/
	 9Xru5mI5FHu0IcrUx+ojgxcejbkhU7xg02IFRLiYxtIsLIILIC7ZJbczSihWX0XQBY
	 ssqOLtmC4K/2oPYPDercb8HXL/xpF8zi2PhfNQ7Spk3C5E69eVwSjpShV1xoAQMXOM
	 k7MhzwOB7kQctcTuyDATsrTOnx1E9a48rJqXeThL3BNWnTrwP23pCa1VoO6xbfUZR2
	 OrwNiZoeB6Si0z5NEMkOBjQCb6tGcL9+CUhiqgUKpg3OGEaraiAmu1TN9I2y7Q9pEi
	 qUXRqSm0e0zNA==
Subject:
 Re: [PATCH net-next v8 3/8] hsr: Add a magic header for sending PTP packets
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 06 Oct 2026 14:31:15 +0000
Message-ID: <179129707549.434549.12538393070496080930@kernel.org>
In-Reply-To: <20261002-hsr_ptp-v8-3-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-3-60dabc07e554@linutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hsr_dev_xmit() (net/hsr/hsr_device.c) now drops every skb that
  has skb->protocol == htons(ETH_P_1588) unless the first 14 bytes form…
- [Medium] hsr_dev_xmit() treats the first 14 bytes of any skb with
  skb->protocol == ETH_P_1588 as trusted in-band control metadata.
- [Low] At this commit, the new uAPI fields tx_port and hsr_hdr
  (include/uapi/linux/hsr_ptp.h) are parsed and checked in…
- [Low] At this commit, the user-supplied hsr_hdr flag sets mac_len to 20
  without checking that the inner frame really has an HSR tag at offset…

--

hsr: Add a magic header for sending PTP packets

This patch adds a uAPI struct, hsr_inline_header. It must sit in front
of every ETH_P_1588 frame sent through the HSR master device.
hsr_dev_xmit() checks the magic, reads the requested tx port and the
"already has HSR header" flag, strips the inline header and passes both
values to hsr_forward_skb(), which will use them in a later patch.

> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 59df647d2fd45..72347477f4f21 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -223,24 +223,66 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,

[ ... ]

> +	skb->dev = master->dev;
> +	if (skb->protocol == htons(ETH_P_1588)) {

[Severity: Medium]
Does this drop every PTP frame that lacks the new inline header?

The gate looks only at skb->protocol, so it also catches senders that
know nothing about struct hsr_inline_header. With a normal Ethernet
header, the magic check below reads bytes 0-3 of the source MAC. These
frames then go to the drop label, and only tx_dropped is incremented.

Before this patch, hsr_forward_skb() forwarded these frames to both
slaves. Some cases that look affected:

  - AF_PACKET SOCK_DGRAM senders. eth_header() builds the header, so the
    device MAC sits where the magic is expected.

  - PTP frames that an L2 forwarder sends into hsr0, for example with
    hsr0 as a bridge port via br_add_if(). eth_type_trans() has already
    set skb->protocol to ETH_P_1588.

  - PTP sent through a VLAN upper of hsr0. hsr_dev_setup() advertises
    NETIF_F_HW_VLAN_CTAG_TX, so the tag stays in skb metadata and
    skb->protocol is still ETH_P_1588.

The commit message says:

    Sending PTP packets (ETH_P_1588) via the HSR stack is pointless in its
    current shape because the requested PTP timestamp is not routed to the
    sender.

That covers local senders that ask for TX timestamps. Does it also hold
for transit PTP traffic, or for PTP traffic that doesn't use
timestamps?

The commit message calls the header mandatory. It doesn't mention that
existing senders without the header now lose their traffic.
hsr_dev_xmit() isn't changed later in the series, so this stays in place.

> +		struct hsr_inline_header *hsr_opt;
> +		struct ethhdr *eth_hdr;
> +		unsigned int hdr_len;
> +
> +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> +
> +		/* need to access the magic header */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> +			goto drop;
> +
> +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> +		if (hsr_opt->magic != htonl(HSR_INLINE_HDR))
> +			goto drop;

[Severity: Medium]
Can a remote host provide this control header?

The only check is a constant magic in the source MAC position, and the
struct maps directly onto dst MAC, src MAC and ethertype.

Some frames are received from the wire and forwarded into hsr0 by tc
mirred (ingress to egress) or by an OVS output action. They keep
skb->protocol = ETH_P_1588 from eth_type_trans(). Their first 14 bytes
are the Ethernet header that the remote sender chose.

Consider a frame with:

  - dst MAC {01 or 02, hsr_hdr, 00, 00, 00, 00}
  - src MAC {af:48:53:52, 00, 00}
  - ethertype 0x88f7

It passes this check. The bridge rejects it because the source is
multicast, but tc mirred and OVS don't. OVS and promiscuous NICs accept
the crafted destination MAC.

hsr_dev_xmit() then strips those 14 bytes. It sends the inner frame on
the port the sender picked, with the hsr_hdr flag the sender chose.

The later commit "hsr: Use the port and header information in
hsr_forward_skb()" makes has_hsr_header skip several steps:

  - hsr_get_node()
  - hsr_register_frame_in()
  - sequence number assignment
  - source MAC substitution in hsr_xmit()

As a result, the frame goes out unchanged with a spoofed source MAC,
HSR sequence number and path id.

Without this patch, forwarded frames are always re-tagged with the local
node's sequence number and source MAC. Forwarded ETH_P_HSR frames are
rejected by the mac_len < sizeof(struct hsr_ethhdr) check, because
hsr_dev_xmit() sets mac_len to 14.

Could this be used to poison the duplicate-discard tables of other ring
nodes, so that legitimate traffic from the spoofed node gets dropped?

> +
> +		has_header = hsr_opt->hsr_hdr;
> +		tx_port = hsr_opt->tx_port;
> +		if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> +			goto drop;
> +
> +		if (has_header)
> +			hdr_len = ETH_HLEN + HSR_HLEN;
> +		else
> +			hdr_len = ETH_HLEN;
> +
> +		/* Ensure the real header after the stripped one can be
> +		 * accessed
> +		 */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header) +
> +				   hdr_len))
> +			goto drop;
> +
> +		eth_hdr = skb_pull(skb, sizeof(struct hsr_inline_header));
> +		skb_set_network_header(skb, hdr_len);
> +		skb->protocol = eth_hdr->h_proto;

[Severity: Low]
Should hsr_hdr be checked against the inner frame before it is trusted
here?

With hsr_hdr set, mac_len becomes ETH_HLEN + HSR_HLEN. Nothing checks
that eth_hdr->h_proto is really an HSR ethertype.

Take a VLAN-tagged frame with an encapsulated ETH_P_HSR and hsr_hdr = 1.
It gets past this guard in hsr_fill_frame_info(), which would otherwise
reject it:

	if (skb->mac_len < sizeof(struct hsr_ethhdr))
		return -EINVAL;

Then hsr_get_skb_sequence_nr() and hsr_set_path_id() read and write the
tag at mac_header + 14, which is inside the VLAN header, instead of at
mac_header + 18.

The pskb_may_pull() above keeps these accesses within the linear data.

The later commit "hsr: Use the port and header information in
hsr_forward_skb()" makes hsr_fill_frame_info() return early when
has_foreign_header is set. hsr_forward_do() then sends a clone of
skb_std without calling hsr_set_path_id(). So this affects only this
intermediate commit.

[ ... ]

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 73bc4b8950071..4afe9e1d65b7e 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -773,7 +773,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  }
>  
>  /* Must be called holding rcu read lock (because of the port parameter) */
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type tx_port, bool has_hsr_header)
>  {
>  	struct hsr_frame_info frame;
>  

[Severity: Low]
At this commit, hsr_forward_skb() accepts tx_port and has_hsr_header but
doesn't use them. The body still does:

	if (fill_frame_info(&frame, skb, port) < 0)
		goto out_drop;

hsr_forward_do() still sends to both slaves. This patch already exports
struct hsr_inline_header as uAPI. At this point in the series, a frame
that asks for a single port is still sent on both ports.

The commit message says the values "will be used later". The follow-up
commit "hsr: Use the port and header information in hsr_forward_skb()"
adds frame->req_tx_port and frame->has_foreign_header. It acts on them in
fill_frame_info(), hsr_fill_frame_info(), hsr_forward_do() and
hsr_xmit(). So this only matters when bisecting onto this commit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-hsr_ptp-v8-0-60dabc07e554%40linutronix.de
