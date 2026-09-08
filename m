Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B068526A86
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865259; cv=none; b=ZFYW3gk6P7fMPOrAptupkeGTrRaOh/KFrrYH8dCJoLBskdQsGDghHVl6ndCHByDqxWDPyVRAR8Xw1mic2k6q7S+nfuv0J8COnrt9eXmgE7l5+pXIqV+X6Ibg0KcP52C8D/+xnQKQTQkH9dzYyj5OvUhLKGIcvhS4ORwv4R5X2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865259; c=relaxed/simple;
	bh=G3W7Fl1LacFOokqHTd9CX7RKJMU6j2SuLuYb9ISTylU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eS/Tt43ol1fMa6GIM8qXWYsrG3ICDHloHJZP8w8jU4LYWT646PFq/wqDjpRcHA0VxtYY1Y5GfrpLaSi2oBxd2D9UZKQbX/6s0iqGWUmzm7Y0/xr7DfZvh7yyDxhypiCHVd+Q/XQRnEH7EexQkXazedTkQ+XROmqO//J3MCWUf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6//Qn5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6//Qn5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2121F00A3A;
	Tue,  8 Sep 2026 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865256;
	bh=qg5o7+9/FULt/2C4ljKcXQwACGdYiDxd9k0i5jJAg8Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j6//Qn5KYbWsZqAG/RFW5bInAQHgECX4Qjh4Pc+Yx+JTg5c0tF+FtUIx0xFc7l054
	 u2QLSiw5wHuC4IZtZJFh1u5nqUP89FO5vxuBbTKZo8nq0Dl+ngagMYLXU8cmJTxYXZ
	 pH3AhhZgEFjZo4Y0NVLbRhAXISarKqsLkBiWT0S132lQUwRTnj1BIpS6Z4TZ6zTZyu
	 hzodgWdCBnE9gSfOfZNQLrKhaRC6RZ1mn5D75gcgQpJf8n9miWY8iTkh6FkI/ietMb
	 V5x5d1Rbxk7gpYk5Oy29yh/S+jYkmts4zE3SgpOcIM1f5Taf5/qf4cDKRfCi3CQq+/
	 NKAgu7u8wZIlA==
Subject:
 Re: [PATCH net-next 4/9] sit: annotate data-races around tunnel->fwmark
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 lorenzo.bianconi@oss.qualcomm.com, iprintercanon@gmail.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 11:00:55 +0000
Message-ID: <178886525512.219967.3771940422889437678@kernel.org>
In-Reply-To: <20260907075846.2913645-5-edumazet@google.com>
References: <20260907075846.2913645-5-edumazet@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Incomplete fwmark annotation for sit devices:
  ipip6_tunnel_update() now publishes tunnel->fwmark with WRITE_ONCE()…

--

sit: annotate data-races around tunnel->fwmark

This adds READ_ONCE()/WRITE_ONCE() annotations around tunnel->fwmark in
the sit driver, since ipip6_tunnel_xmit() runs locklessly with
dev->lltx == true. It is preparation for running ipip6_fill_info()
without RTNL.

> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 9a2bbd76d3794..e85fa80e80d1a 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -929,7 +929,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>  	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
>  		goto tx_error;
>  
> -	flowi4_init_output(&fl4, tunnel->parms.link, tunnel->fwmark,
> +	flowi4_init_output(&fl4, tunnel->parms.link, READ_ONCE(tunnel->fwmark),
>  			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
>  			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
>  			   sock_net_uid(tunnel->net, NULL));

[ ... ]

> @@ -1153,7 +1153,7 @@ static void ipip6_tunnel_update(struct ip_tunnel *t,
>  	t->parms.iph.frag_off = p->iph.frag_off;
>  	if (t->parms.link != p->link || t->fwmark != fwmark) {
>  		t->parms.link = p->link;
> -		t->fwmark = fwmark;
> +		WRITE_ONCE(t->fwmark, fwmark);

[Severity: Low]
Should the other lockless transmit path of the same sit device also be
annotated?

ipip6_tunnel_xmit() is only one of the two xmit paths.  For IPv4 and MPLS
payloads, sit_tunnel_xmit() dispatches elsewhere:

net/ipv6/sit.c:sit_tunnel_xmit() {
	switch (skb->protocol) {
	case htons(ETH_P_IP):
		sit_tunnel_xmit__(skb, dev, IPPROTO_IPIP);
		break;
	case htons(ETH_P_IPV6):
		ipip6_tunnel_xmit(skb, dev);
		break;
#if IS_ENABLED(CONFIG_MPLS)
	case htons(ETH_P_MPLS_UC):
		sit_tunnel_xmit__(skb, dev, IPPROTO_MPLS);
		break;
#endif
	...
}

and sit_tunnel_xmit__() -> ip_tunnel_xmit() reads the same field with a
plain load, right next to an already annotated read:

net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
	...
	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
			    tunnel->net, READ_ONCE(tunnel->parms.link),
			    tunnel->fwmark, skb_get_hash(skb), 0);
	...
}

So for a sit tunnel carrying IPv4 or MPLS frames, an RTNL writer running
ipip6_changelink()/ioctl -> ipip6_tunnel_update() -> WRITE_ONCE(t->fwmark,
fwmark) still races with an unmarked read, and KCSAN can still report it.
The field is a naturally aligned u32, so the read cannot tear; the visible
effects are the KCSAN report plus one route lookup using the pre-update
mark.

Note that the generic writer in net/ipv4/ip_tunnel.c:ip_tunnel_update() is
also still a plain store to t->fwmark, so closing this would mean touching
the generic ip_tunnel code as well, which may be outside the intended scope
of this series.  It was checked at the end of the series and the plain read
in ip_tunnel_xmit() is still there.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907075846.2913645-1-edumazet%40google.com
