Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCE23ED5E;
	Sun, 11 Oct 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726281; cv=none; b=js+FAV2LN7oPE7PxxyP5Hgcmy2SYo0mERqvBPZdnXcUJjsCoZhDuF+qQlYEHiSR1XCV8Qf3mWXX5/CMjasWfO5NTE3iEdC0Ou10+rJNiiQkE+WTMvZSu1jdSCKuad267k/IEuRwjSrYxDycQaozyo8angAd04BiJ7/YFNZxResQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726281; c=relaxed/simple;
	bh=SY1aZ5FFRmCf+dJslwGoOhZMH+FBGqIQNpQZvMzedXI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jeovNFrx76ArL5Hm/Po5qQLbXgdD3w2dU+PgT2gASgQHmPbIDIFMfO1dBtCwjg/8VMflCVHTOWngVm8BsXKsk7rMXMZCFG3U1RJvqfFVEoPJZYJLXn0Hy4MQ84aKYVIa6Fn2h2VzZKNYOULgGHXEIkfiYSblPO7eRRlQ9jDoZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMI/KlHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMI/KlHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8AC1F0089B;
	Sun, 11 Oct 2026 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791726279;
	bh=vu2YEMKauIpc7tvvbmbxBOjYQhZ2cgVTT1RoZH61C8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PMI/KlHobLaSx5EuU461CGRAlXhLirQE/q/5v8VIxncXoqknMmuf8MeEeX8LuYoBC
	 neaMqygQiTTbD6ygjWM/oDvBRyO5EpxVCr/e6L7Av0diTQ871vJBvgzvg/DvPcJP6a
	 u52WQ7sy6y9Wzaws0IIkpVMuxKo0Hk2C1lhYJFhWTxIcMDAAqMXxVTQqOo2aTOVjPW
	 W2Xk9K7AFd5jGiKXgqb1pFuouDul/HKBC1sW0/8TkgZqugd5Jg/OYgy5YC8IYsLGQD
	 gDjmKJPahwzBMOcFcY2O0FjKCuK2R4iHWuPn9IZ6RR9svSWxNt1eqlv9EDJXL/vzgn
	 A2G7RdhdQNm4A==
Subject: Re: [PATCH net] ipmr: do not drop GSO packets that fit the MTU after
 segmentation
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, steffen.klassert@secunet.com, willemb@google.com,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 13:44:38 +0000
Message-ID: <179172627842.434549.17722584347227331391@kernel.org>
In-Reply-To: <20261010131842.2157365-1-julius@bairaktaris.de>
References: <20261010131842.2157365-1-julius@bairaktaris.de>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On VIFF_TUNNEL vifs the patch does not stop the drop it claims
  to fix.
- [Low] The patch rewrites the DF/MTU check in ipmr_prepare_xmit() from
  `skb->len + encap > dst4_mtu(&rt->dst)` (which cannot wrap) to `mtu =…

--

ipmr: do not drop GSO packets that fit the MTU after segmentation

This patch changes ipmr_prepare_xmit() so a DF packet larger than the
route MTU is no longer dropped if it is a GSO packet whose segments fit
that MTU. This matches the skb_gso_validate_network_len() check in
ip_forward(). The MTU used for the check is now dst4_mtu() minus the
tunnel encapsulation overhead.

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c452..06c37b4e653bf 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1908,6 +1908,7 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
>  	struct rtable *rt;
>  	struct flowi4 fl4;
>  	int    encap = 0;
> +	unsigned int mtu;
>  
>  	vif_dev = vif_dev_read(vif);
>  	if (!vif_dev)
> @@ -1940,7 +1941,9 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
>  			return -1;
>  	}
>  
> -	if (skb->len+encap > dst4_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
> +	mtu = dst4_mtu(&rt->dst) - encap;
> +	if (skb->len > mtu && (ntohs(iph->frag_off) & IP_DF) &&
> +	    !(skb_is_gso(skb) && skb_gso_validate_network_len(skb, mtu))) {

[Severity: High]
The new mtu value subtracts encap, so this check seems meant to cover
VIFF_TUNNEL vifs too. Can a DF GSO aggregate that passes it actually be
transmitted on a tunnel vif?

Further down in ipmr_prepare_xmit(), such an skb goes to ip_encap():

	if (vif->flags & VIFF_TUNNEL) {
		ip_encap(net, skb, vif->local, vif->remote);

ip_encap() only adds the outer header:

	skb_push(skb, sizeof(struct iphdr));
	skb->transport_header = skb->network_header;
	skb_reset_network_header(skb);
	...
	iph->protocol	=	IPPROTO_IPIP;
	...
	iph->tot_len	=	htons(skb->len);

It does not add SKB_GSO_IPXIP4 to gso_type, set skb->encapsulation or
set the inner header offsets. ipip_tunnel_xmit() does set up that state,
by calling iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4) first.

Software segmentation runs for fraglist GSO, and on any device without
hardware USO. In that case the path is:

validate_xmit_skb()
  skb_gso_segment()
    inet_gso_segment()
      ipip_gso_segment()

and ipip_gso_segment() rejects the skb:

	if (!(skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP4))
		return ERR_PTR(-EINVAL);

validate_xmit_skb() then frees the skb and only increments tx_dropped.
The skb_gso_network_seglen() check in ip_finish_output_gso() does not
catch this either. After ip_encap(), transport minus network covers only
the 20-byte outer header.

So on tunnel vifs, are these packets still dropped, just no longer
counted in FragFails? Meanwhile vif->pkt_out, vif->bytes_out,
tx_packets and OUTFORWDATAGRAMS count them as sent.

There is also a hardware case, which I have not fully traced. If the
egress device advertises NETIF_F_GSO_UDP_L4 and the aggregate is plain
UDP_L4 from UDP GRO forwarding, could the device get a GSO skb whose
transport offset points at the inner IP header and has no encapsulation
flag? Could it then send malformed segments?

Before this patch these DF aggregates were dropped up front here. The
ip_encap() GSO problem already existed for non-DF GSO skbs, but this
change lets DF traffic reach it as well.

Would it work to apply the exemption only when encap == 0? Other options
are to segment before ip_encap(), or to have ip_encap() set up the
IPXIP4 GSO state the way iptunnel_handle_offloads() does.

[Severity: Low]
The old check was additive and could not wrap:

	if (skb->len+encap > dst4_mtu(&rt->dst) && ...

The new code does an unsigned subtraction instead. On the VIFF_TUNNEL
path encap is sizeof(struct iphdr), which is 20. If the route to
vif->remote has an MTU below 20, can mtu wrap to a value near UINT_MAX?

ip_metrics_convert() only clamps RTAX_MTU from above:

	if (type == RTAX_MTU && val > 65535 - 15)
		val = 65535 - 15;

ip_dst_mtu_maybe_forward() also returns the metric with no lower bound,
apart from subtracting the lwtunnel headroom.

If mtu wraps, skb->len > mtu is false for every DF packet, GSO or not,
so the drop and its IPSTATS_MIB_FRAGFAILS count are skipped. The packet
then gets vif and device tx accounting and goes through the
NF_INET_FORWARD hook. It is only dropped later, by the mtu < hlen + 8
check in ip_do_fragment(), or during GSO segmentation.

This needs a privileged and odd route configuration. Would keeping the
additive comparison, or checking that dst4_mtu() > encap before
subtracting, avoid it?

>  		/* Do not fragment multicasts. Alas, IPv4 does not
>  		 * allow to send ICMP, so that packets will disappear
>  		 * to blackhole.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010131842.2157365-1-julius%40bairaktaris.de
