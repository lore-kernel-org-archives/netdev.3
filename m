Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBB37755C;
	Thu,  3 Sep 2026 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421530; cv=none; b=jFpJ3dbMzwqb/cIlmXsn3LFIHEVK5Z7lrUASsNfTmF5wGo+t0x8HWQo96IdNT1ojDCElY9zWxcvGBKRRAVz/3qA7re3lMdpKXtg9VZsA/Qw18uXkunx8W41utISm2UfPlsbuu5yhMGemaZ9/lyoabdxlcYRs34nNQLTBNJqxGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421530; c=relaxed/simple;
	bh=HL3Q2kbZt2SRWlY0cDmnYXibR/H/TXeI5atW4PsqJQk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTQ9eY3FlrUW7/qhu+/7b6LNWNAnu3oziX9m8rEGOgxoSAT0d/68S8vCfKGVKVZGoZLtAjCuW4eOHhFjj+sTa6IkswHSMa7yXv9lp105RWHiB/RhOYbuGoxnFyEB0ksRh0IHFXsDzQOvfN8HzyFXyU9ojSnTyvJfSsDeB9ANOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/KsTRF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/KsTRF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7771F000E9;
	Thu,  3 Sep 2026 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421529;
	bh=Rt/wncSjEwaGnOutPS+SIkmorR0nZr+zhTZYdUwQH/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E/KsTRF24OW49ID4COfnOCw5NtDoBNNnMKlmXKMI191soayCAgP5alLbc1+fJ5ntv
	 74rYKiUjrg/lNXTvRTDYQrYzj/wQkvFDkowc29F0ztaCNO9cIap5kef+K6QQM+gxxi
	 WwXK4BVwaOnuaPxXcw1eaoN3ITqWw3s11BhWhYZlux4+XENlbbHs+Bi8W8CEu62Bn1
	 f8YspWcQPM4yikUm5T2FVfP6xDlS4egL67W++/tlGsMVFFu5ViEhaRHdDK97/ZrPNu
	 nkwx00NuIPnrddyaR1QhXeiglkz1F4OcKEH+QZcY8BT7VPzwdjR+KLUq4oDt6FS1T7
	 w3HHC5BnheLZA==
Subject: Re: [net,v3] net/packet: fix network header offset for non-VLAN raw
 packets on VLAN subinterfaces
From: netdev-bot+sashiko@kernel.org
To: zhangjn_dev@163.com
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 liuhangbin@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjn11@chinatelecom.cn, sunshx@chinatelecom.cn
Date: Thu, 03 Sep 2026 07:45:28 +0000
Message-ID: <178842152801.3394541.15512936705284584859@kernel.org>
In-Reply-To: <20260901074214.57717-1-zhangjn_dev@163.com>
References: <20260901074214.57717-1-zhangjn_dev@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] The new branch added to packet_parse_headers()
  (net/packet/af_packet.c:1950-1966) is a no-op in exactly the…
- [Medium] The only configurations in which the new statement in
  packet_parse_headers() (net/packet/af_packet.c:1963-1965) changes any…

--

net/packet: fix network header offset for non-VLAN raw packets on VLAN subinterfaces

This adds a branch to packet_parse_headers() that, for untagged SOCK_RAW
frames sent on a VLAN subinterface, moves skb->network_header to
dev->min_header_len before skb_probe_transport_header() runs.  The stated
goal is to make GSO see the L3 header at ETH_HLEN instead of at
hard_header_len.  The existing VLAN-tagged correction below is reworked to
reuse the newly computed is_vlan_packet boolean.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 76bde7906d494..8dfb823e819d6 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1938,6 +1938,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>  static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>  	int depth;
> +	bool is_vlan_packet = false;
>  
>  	/* On TX skb->data is the L2 header; anchor it for all socket types. */
>  	skb_reset_mac_header(skb);
> @@ -1946,11 +1947,28 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  	    sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
>  
> +	if (likely(skb->dev->type == ARPHRD_ETHER)) {
> +		is_vlan_packet = eth_type_vlan(skb->protocol);
> +
> +		/* For non-VLAN SOCK_RAW frames on VLAN subinterfaces with
> +		 * software tag insertion, hard_header_len includes space
> +		 * for the VLAN tag while min_header_len is the on-wire
> +		 * Ethernet header length. The user frame carries a
> +		 * standard Ethernet header, so its L3 sits at
> +		 * min_header_len, not hard_header_len. Move
> +		 * network_header to the actual L2/L3 boundary so the
> +		 * transport header probe below and subsequent GSO see
> +		 * the right L3.
> +		 */
> +		if (sock->type == SOCK_RAW && !is_vlan_packet &&
> +		    is_vlan_dev(skb->dev))
> +			skb_set_network_header(skb, skb->dev->min_header_len);
> +	}

[Severity: High]
Is this new assignment a no-op in exactly the configuration the changelog
describes?

The commit message says:

  "On VLAN subinterfaces with software tag insertion, hard_header_len
   includes space for the VLAN tag (ETH_HLEN + VLAN_HLEN = 18) while
   min_header_len is the on-wire Ethernet header length (ETH_HLEN = 14)."

That does not appear to hold in this tree any more.  vlan_dev_init() copies
the real device's value verbatim and accounts the tag space in
needed_headroom instead:

net/8021q/vlan_dev.c:vlan_dev_init() {
	dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN;
	dev->needed_tailroom = real_dev->needed_tailroom;
	dev->header_ops      = &vlan_header_ops;
	dev->hard_header_len = real_dev->hard_header_len;
}

vlan_transfer_features() does the same, so toggling
NETIF_F_HW_VLAN_CTAG_TX no longer changes hard_header_len at runtime
either.  This came in with commit 447cbe95ebb953 ("vlan: fix
skb_under_panic and races when toggling HW VLAN offload"), which is already
an ancestor of the baseline, and whose changelog states "AF_PACKET SOCK_RAW
network header offsets remain correctly aligned at
real_dev->hard_header_len".

min_header_len is never touched by net/8021q; vlan_setup() goes through
ether_setup():

net/ethernet/eth.c:ether_setup() {
	dev->hard_header_len 	= ETH_HLEN;
	dev->min_header_len	= ETH_HLEN;
}

So for a VLAN device over an ordinary Ethernet NIC, including the reported
virtio_net guest, hard_header_len == min_header_len == 14, and packet_snd()
has already placed network_header at mac_header + 14:

net/packet/af_packet.c:packet_snd() {
	skb_reset_network_header(skb);
	...
	} else if (reserve) {
		skb_reserve(skb, -reserve);
		if (len < reserve + sizeof(struct ipv6hdr) &&
		    dev->min_header_len != hard_header_len)
			skb_reset_network_header(skb);
	}
}

tpacket_fill_skb() reaches the same offset via skb_reset_network_header()
followed by skb_push(skb, hard_header_len).

If hard_header_len is 14 there, does skb_set_network_header(skb,
min_header_len) write back the identical offset, leaving the reported
inet_gso_segment() -EINVAL unchanged?  If the failure is real, would it be
worth re-deriving it against 447cbe95ebb953 and keying the fix off the
frame's actual content rather than off device header-length metadata?

The in-code comment and the Fixes: tag also describe device geometry that
447cbe95ebb953 removed, and would propagate that description into stable
trees.

[Severity: Medium]
The only stacks where this statement changes a value are VLAN devices whose
real device has hard_header_len != ETH_HLEN.  Does it then conflict with the
deliberate reset in packet_snd()?

The short-frame safeguard there is gated on precisely the same inequality
that makes the new code effective:

net/packet/af_packet.c:packet_snd() {
		if (len < reserve + sizeof(struct ipv6hdr) &&
		    dev->min_header_len != hard_header_len)
			skb_reset_network_header(skb);
}

That reset came from commits 993675a3100b16 and 88a8121dc1d3d0.  For a VLAN
created over, say, drivers/net/usb/dm9601.c (dm9601_bind() does
dev->net->hard_header_len += DM_TX_OVERHEAD), any SOCK_RAW frame with
14 <= len < hard_header_len + sizeof(struct ipv6hdr) gets network_header
reset to the MAC header by packet_snd(), and then moved back to
mac_header + 14 by the new statement a few instructions later.  Which of the
two sites is meant to win?

There is also the reverse case.  cx82310_eth is ARPHRD_ETHER, does not set
NETIF_F_VLAN_CHALLENGED, and zeroes hard_header_len:

drivers/net/usb/cx82310_eth.c:cx82310_bind() {
	dev->net->hard_header_len = 0;
}

vlan_check_real_dev() only rejects NETIF_F_VLAN_CHALLENGED and non
ARPHRD_ETHER devices, so a VLAN device over it inherits hard_header_len 0
while min_header_len stays ETH_HLEN.  dev_validate_header() then accepts a
SOCK_RAW frame shorter than 14 bytes.  For such a frame, does
skb_set_network_header(skb, min_header_len) place network_header past
skb->tail, so that a later skb_reset_mac_len() (net/core/gso.c and
net/core/dev.c) computes skb->mac_len = 14 with skb->len below that?  That
looks like the state 993675a3100b16 was written to avoid.

Would gating on the frame contents, or on the actual position of the L2/L3
boundary in the skb, avoid touching these unrelated device stacks?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901074214.57717-1-zhangjn_dev%40163.com
