Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313B52E077;
	Fri,  4 Sep 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560688; cv=none; b=JbFUKWTthrY3KsVW4+bEzD+z0Vw/C4baQMSNa/GGog1mnI5Wl8CeBii6FPCoYD4gDXnL/U/rVSwBlCPwUXmhgxoeAgRApLhf+1uXPxr24NiYDjTgzlo2MkcNYLUdh7TjdKJh/la8o83ynRmHDc+RjLvX5P9SLqOj2icQh+ooLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560688; c=relaxed/simple;
	bh=BgX5cqZ0bslRChkmzM3+wVHqLdprMk6Ak7II2HkFAp8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UevEcaeCN94BzoRyOKvtwFzaTYPP2zE4jwoKyExJcK34xBkf5G5hQwQw0kr2tiFuy1ciU85GST6Q8Gm7r3ly7mL3VqjqJn0HKfPfHgeQU+wIH71aXMzVRDNBTPMVxJnhuBOz/XFbh2c30wPCSddM0lUqPPxQtlh4kAlH+2Mf9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EekLT6Ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EekLT6Ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6D1F00A3D;
	Fri,  4 Sep 2026 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560683;
	bh=s6nq/sYtvdRzwOuOQYFworKtPDwTnU11dzRl3rHs4Bg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EekLT6TawyR+Ys6PtViPvveCCI8H7tx0S+wf8+in3gxLLuEHRNlXaWCm3PtQ7XSqg
	 Xrme1dC23i2961sspWKEHmxX5IObnS1jS5YFZmo79pXRLyol5/cEXpflIxur+PgTOP
	 yMx7L7G+ShprEHf3PPqbwqROngDAPKshjsOpKTwGgJvbPJsqx94A2QLWod9DDfPoEc
	 PG+T3Iv24abSvpYn9RtOb61kjgLniar4xEw2XM4m/N5mS2r4Nf0t8cLNelk+48rjom
	 CHu8Lt/iv/m0x91zDv6xkSWCCpFwiRqu5JiPB0b52vDtw6vTGkA9CGer1VhrQ0zXZf
	 DTgQK0w4crMvw==
Subject: Re: [PATCH net v2] net/packet: fix network header offset for non-VLAN
 raw packets
From: netdev-bot+sashiko@kernel.org
To: zhangjn_dev@163.com
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 liuhangbin@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjn11@chinatelecom.cn, sunshx@chinatelecom.cn
Date: Fri, 04 Sep 2026 22:24:42 +0000
Message-ID: <178856068266.219967.8739522272038197328@kernel.org>
In-Reply-To: <20260831072034.40044-1-zhangjn_dev@163.com>
References: <20260831072034.40044-1-zhangjn_dev@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] The new guard in packet_parse_headers()
  (`skb->dev->min_header_len < skb->dev->hard_header_len`) can never be…
- [Medium] packet_parse_headers() decides the L2/L3 boundary from
  `is_vlan = eth_type_vlan(skb->protocol)`, i.e. from the socket-…
- [Medium] packet_parse_headers() re-reads the live
  `skb->dev->hard_header_len` and `skb->dev->min_header_len` to decide…

--

net/packet: fix network header offset for non-VLAN raw packets

This changes packet_parse_headers() so that non-VLAN AF_PACKET SOCK_RAW
frames on Ethernet devices whose hard_header_len is larger than
min_header_len get network_header moved to min_header_len before
skb_probe_transport_header() runs.  The existing VLAN correction is
reorganized to reuse a new is_vlan boolean.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index b22cda322136..9a4c70b659d4 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1938,6 +1938,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>  static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>  	int depth;
> +	bool is_vlan = false;
>  
>  	/* On TX skb->data is the L2 header; anchor it for all socket types. */
>  	skb_reset_mac_header(skb);
> @@ -1946,11 +1947,28 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  	    sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
>  
> +	if (likely(skb->dev->type == ARPHRD_ETHER)) {
> +		is_vlan = eth_type_vlan(skb->protocol);

[Severity: Medium]
Is is_vlan a reliable statement about the frame layout here?  For SOCK_RAW
the protocol is only re-derived from the frame when it is zero or
ETH_P_ALL, just above:

	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
	    sock->type == SOCK_RAW)
		skb->protocol = dev_parse_header_protocol(skb);

Otherwise skb->protocol comes from the bind protocol or the user supplied
sll_protocol, assigned in packet_snd() as skb->protocol = proto shortly
before this call (and similarly in tpacket_fill_skb()).

So a socket opened as socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IP)) that
sends a frame which does carry an inline 802.1Q tag keeps
skb->protocol == ETH_P_IP, is_vlan stays false, and the new branch below
forces network_header to min_header_len, i.e. onto the VLAN TPID rather
than the IP header.  The frame-inspecting correction at the end is gated on
the same is_vlan, so it does not repair that.

For the devices where the new branch actually fires with
hard_header_len - min_header_len == VLAN_HLEN (for example the usbnet
gl620a and ps3_gelic_net, both 18), the pre-patch offset of 18 was the
correct L3 offset for such a single-tagged frame.  Does this turn a correct
offset into an incorrect one for that case, and would parsing the frame be
preferable to trusting the socket-declared protocol?

> +
> +		/* For non-VLAN SOCK_RAW frames on Ethernet devices whose
> +		 * hard_header_len exceeds the on-wire L2 header length
> +		 * (min_header_len) -- e.g. software-offload VLAN subinterfaces,
> +		 * or Ethernet drivers that reserve extra space in
> +		 * hard_header_len for driver-internal wrapping -- the SOCK_RAW
> +		 * send paths leave network_header at hard_header_len, while the
> +		 * user frame's L3 sits at min_header_len. Move network_header
> +		 * to the actual L2/L3 boundary so the transport header probe
> +		 * below and subsequent GSO see the right L3.
> +		 */
> +		if (!is_vlan && sock->type == SOCK_RAW &&
> +		    skb->dev->min_header_len < skb->dev->hard_header_len)
> +			skb_set_network_header(skb, skb->dev->min_header_len);
> +	}

[Severity: High]
Can this condition ever be true for the reproducer described in the commit
message?  The message says:

    "e.g. software-offload VLAN subinterfaces, where hard_header_len =
    ETH_HLEN + VLAN_HLEN = 18"

and

    "Observed on a virtio_net NIC (KVM guest) that advertises
    NETIF_F_HW_VLAN_CTAG_FILTER but not NETIF_F_HW_VLAN_CTAG_TX, so VLAN
    subinterfaces use software tag insertion (hard_header_len = 18)."

In this tree vlan_dev_init() no longer inflates hard_header_len; the tag
space went to needed_headroom:

net/8021q/vlan_dev.c:vlan_dev_init() {
	...
	dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN;
	dev->needed_tailroom = real_dev->needed_tailroom;
	dev->header_ops      = &vlan_header_ops;
	dev->hard_header_len = real_dev->hard_header_len;
	...
}

vlan_transfer_features() repeats the same unconditional assignment, so
toggling NETIF_F_HW_VLAN_CTAG_TX does not change hard_header_len either.
This came in with commit 447cbe95ebb9 ("vlan: fix skb_under_panic and
races when toggling HW VLAN offload").

min_header_len for ARPHRD_ETHER is only ever set by ether_setup():

net/ethernet/eth.c:ether_setup() {
	...
	dev->hard_header_len 	= ETH_HLEN;
	dev->min_header_len	= ETH_HLEN;
	...
}

and VLAN devices reach it through vlan_setup() -> ether_setup().
virtio_net does not touch hard_header_len at all.

That leaves min_header_len == hard_header_len == 14 for both the VLAN
subinterface and the real device in the described setup, so the branch is
skipped and the -EINVAL from inet_gso_segment() would still happen.  Is
the fix a no-op for the configuration it was written for?

The devices that can satisfy the test are unrelated ARPHRD_ETHER drivers
that enlarge hard_header_len after ether_setup(), such as the usbnet
gl620a, dm9601, rndis_host, smsc95xx and cdc_eem drivers, thunderbolt,
cxgb2, ps3_gelic_net and br2684.  Should the changelog and the comment be
reworded around that device class instead of software-tagging VLAN
subinterfaces, and could the reproducer be re-checked against the current
vlan_dev_init()?

[Severity: Medium]
Should these two reads use the caller's snapshot rather than the live
fields?  packet_snd() takes one:

net/packet/af_packet.c:packet_snd() {
	...
	hard_header_len = READ_ONCE(dev->hard_header_len);
	if (sock->type == SOCK_RAW)
		reserve = hard_header_len;
	...
	} else if (reserve) {
		skb_reserve(skb, -reserve);
		if (len < reserve + sizeof(struct ipv6hdr) &&
		    dev->min_header_len != hard_header_len)
			skb_reset_network_header(skb);
	}
	...
	packet_parse_headers(skb, sock);
	...
}

That snapshot arrived in commit 03390aa32e669 ("packet: use consistent
hard_header_len in non-ring send paths") because dev->hard_header_len can
change under a sender, for example from bond_setup_by_slave():

drivers/net/bonding/bond_main.c:bond_setup_by_slave() {
	...
	bond_dev->hard_header_len   = slave_dev->hard_header_len;
	...
}

tpacket_fill_skb() is even passed hard_header_len as a parameter for the
same reason.  If hard_header_len shrinks to min_header_len between skb
construction (which reserved the larger value) and this point, the branch
does not fire and network_header stays where the commit message says it is
wrong; if it grows after the skb was built with reserve == min_header_len,
the branch fires on a length that was never used to lay out the skb.

Would passing the already snapshotted length into packet_parse_headers(),
or at least a single READ_ONCE() here, keep the offset decision consistent
with the layout that was used, and avoid the plain concurrent read?

>  
>  	skb_probe_transport_header(skb);
>  
>  	/* Move network header to the right position for VLAN tagged packets */
> -	if (likely(skb->dev->type == ARPHRD_ETHER) &&
> -	    eth_type_vlan(skb->protocol) &&
> +	if (is_vlan &&
>  	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
>  		skb_set_network_header(skb, depth);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831072034.40044-1-zhangjn_dev%40163.com
