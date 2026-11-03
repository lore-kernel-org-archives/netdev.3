Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693101;
	b=Rk1rqdbhmhTvzggUpaarqMYsFEYo7ANKxcHgAJHr9iPg7k9UbfjB8DYmTgTCrJSIiH5I
	 U1w/apgGLVrkCeSo8Lh7CF87owSUXPbPUh+UIC7Iy9hjTlvvyrMKjnrzIroQ8Nv6QN4AQ
	 9N1CfLQEaaDA69WqOS7sgavX239DVjlBuc7RlkrV6d3zsIKs4fY2HEFkjG7S25FpmTuuS
	 /+1kT0UKf54sVlQYdTIa1A39SMG+L86espACA0oyY94VJfYKCYmQsmrQnIFjzM98qW2ie
	 cRgGUbHxTBL582CT+56aWOjOsjP7KhMm66ljcZpnPfJOT10nmXJMS5QSk9JzNdd647Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693101;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Is/N+iZUjDfSN1sneuH4OTqgyHfI3K+lOnHcdE9f2kI=;
	b=J7oeyWXP2HwlUCKp3ZoHZwHLXJLb4b7a07QAAL4z0tdL/duyet52nzpCCatcPt4Ahibr
	 WtKtBakCXmHEXWNUqIyjsBS4Z5iRUYjm/1Ig6LpJ3Xl5dS5/MHRVlSJYqiYmF+e1ZNCkA
	 20tSNkjEm++xds+5g/thIVnRrQLUOyCMs5LuBx9I5PvTZSOwwsN4JZ8ycT+fXoOhiXO6G
	 ka38x5oY/Cw7oJj4xzU8zho2Rv7sr0Ne8c1HlfS2zSr9aGGWcIhVMkv3ZEoisgouGB2By
	 R52HX5ybloEF/GI4GwYREXhN+R5sCjdVszkoM6dyUcgtRYpsw+ls96PDxnfrDqu9VrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTeTSc3Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D96606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTeTSc3Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C1E1F000C1;
	Tue,  3 Nov 2026 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693101;
	bh=Is/N+iZUjDfSN1sneuH4OTqgyHfI3K+lOnHcdE9f2kI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lTeTSc3QfYhWvuPfAwmmfB5lR1QE5T49UChRIxT4UelAEjq5Kvh3RqWFpAPm0RKqm
	 fKSlWpSz6fHH1eVfOJeiiHC7GCgtEn8f3uMvlkGvEUZrkKyNPoy5ywBOolwNWLzQre
	 JUH1oBijiFJk4HEFGSFNuIVY5tvXTe8P6tABoVwQM09En4O20hazimhsatFW3R2Boh
	 uFSjHOtecr+fEONySdblZRn7Iy/1kdrHmQKOBVWvCJu91+AuxkXQ3s6Y/+hKWNzF1j
	 YZ77toCQIdNdTCJgl7dIJN/FOD27YQSQ/5kh5PkxLA4gstQpQ+t/miYrUGUVnFlD9W
	 zSQoKkKHWJOAA==
Subject: Re: [PATCH 02/14] xfrm: interface: validate the IP header on xmit
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:00 +0000
Message-ID: <179369310046.488856.2145189284558172500@kernel.org>
In-Reply-To: <20261102100451.2505200-3-steffen.klassert@secunet.com>
References: <20261102100451.2505200-3-steffen.klassert@secunet.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In xfrmi_xmit() (net/xfrm/xfrm_interface_core.c), the new
  header checks look only at skb->protocol.

--

xfrm: interface: validate the IP header on xmit

This patch adds a pskb_inet_may_pull() call to xfrmi_xmit(). It also
drops packets whose IP version does not match skb->protocol, and IPv4
packets with a malformed ihl. The aim is to stop xfrm4_transport_output()
from working on an unvalidated header when packets are injected into an
xfrmi device.

> diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
> index 688306bf62c5a..9835fbe63ccb8 100644
> --- a/net/xfrm/xfrm_interface_core.c
> +++ b/net/xfrm/xfrm_interface_core.c
> @@ -531,8 +531,13 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	memset(&fl, 0, sizeof(fl));
>  
> +	if (!pskb_inet_may_pull(skb))
> +		goto tx_err;
> +
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IPV6):
> +		if (ipv6_hdr(skb)->version != 6)
> +			goto tx_err;
>  		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
>  		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
>  		if (!dst) {

[Severity: Medium]
Can an skb marked ETH_P_IPV6 pass this check and still reach
xfrm4_transport_output()?

The new check in xfrmi_xmit() looks only at skb->protocol. The transform
that actually runs is picked by the dst family, and then by
x->props.family.

When skb_dst(skb) is already set, xfrmi_xmit() skips the route lookup.
The dst family is never compared with the header that was just checked.

In collect_md mode, xfrmi_xmit2() also swaps in a different dst after
this check:

net/xfrm/xfrm_interface_core.c:xfrmi_xmit2() {
    ...
		if (md_info->dst_orig) {
			struct dst_entry *tmp_dst = dst;

			dst = md_info->dst_orig;
			skb_dst_set(skb, dst);
    ...
}

xfrm_lookup_with_ifid() then takes the policy/state family from that
dst, not from the packet:

net/xfrm/xfrm_policy.c:xfrm_lookup_with_ifid() {
    ...
	u16 family = dst_orig->ops->family;
    ...
}

A tc BPF program could reach this with the following sequence:

bpf_skb_set_xfrm_info()
    info->dst_orig = skb_dst(skb);    /* IPv4 rtable */
    attaches the per-cpu metadata dst
bpf_skb_change_proto(skb, ETH_P_IPV6)
    skb_valid_dst() is false for DST_METADATA, so the metadata dst
    and the IPv4 dst_orig are both kept
program writes an IPv6 header with version 6
xfrmi_xmit()                  /* dst != NULL, only version check runs */
  xfrmi_xmit2()               /* collect_md swaps in IPv4 dst_orig */
    xfrm_lookup_with_ifid()   /* family is AF_INET */
    ...
    xfrm_outer_mode_output()
      xfrm4_transport_output()

A plain IPv4 rtable does not survive bpf_skb_change_proto(), because it
drops non-metadata dsts. So this appears limited to the metadata dst
ordering above.

With an AF_INET transport mode state, xfrm4_transport_output() takes ihl
from the low nibble of the IPv6 header's first byte. That nibble is the
top four bits of the traffic class, so it can be anything from 0 to 15:

net/xfrm/xfrm_output.c:xfrm4_transport_output() {
	struct iphdr *iph = ip_hdr(skb);
	int ihl = iph->ihl * 4;
    ...
	__skb_pull(skb, ihl);
	memmove(skb_network_header(skb), iph, ihl);
    ...
}

pskb_inet_may_pull() only made 40 bytes linear for IPv6. For a small
packet, skb->len can wrap and the memmove() can read past the end of the
data. If the skb has paged data and a linear length under 60 bytes,
__skb_pull() hits BUG() instead.

One step has not been confirmed end to end. It is not certain that an
AF_INET policy/state lookup matches a flowi that xfrm_decode_session()
filled in as IPv6. It looks plausible with a 0/0 selector, because the
ip4 address fields overlay ip6 address bytes that the sender controls.

This path also needs CAP_BPF/CAP_NET_ADMIN, a collect_md xfrmi, and an
AF_INET transport mode SA and policy.

The commit message says:

  "xfrm4_transport_output() uses iph->ihl for __skb_pull() and memmove()
  and expects the header to be valid."

Would it make sense to also drop packets whose final dst family (after
the collect_md dst_orig swap) does not match skb->protocol, so this path
is covered too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
