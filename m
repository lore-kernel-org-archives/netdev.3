Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F767448D1A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616109; cv=none; b=Q9AjW1ZdOD+QzrME+cZjJeft39mYZs0F38MqxPyqCy4klMZczwdZMtzY//NJd6Q5fjeO94QeKfjwq3+2PTcL0wWu9cF8wXwBBHAc7UxnEw/1gBMSw0rHO/zfgDxgeCRtVWVAtZVH+UA6atJnLwA82A+p1CPDmTT6mLhsVZ+wrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616109; c=relaxed/simple;
	bh=D2yPvNtau/kOVHppZZCraVB6idXisjUBxS4o2URT8QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnCQ4+pNyXd+BqKhy4T8FFjbhn8pnTZEkH563UIH/4sTi2F1jwJYaGQPk8gEoIPl7juBOSYKbjuRjWxKt7HkBlT5dcZ2JNgbmpZZ9XaEMg2mHWiCilWtHfyw+dQaezCQor3mG6r9XEoNLQUtNNugdxiFUMuTX5KtLO6CGLjstCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+wxpht3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+wxpht3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786616102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJwHj9BlZboAK6MqX2l8f+DQBEAC3FSBz4UATs1Sbrc=;
	b=Z+wxpht35W58p278wipy+KkDNu0Obo2xr1m3z4if/PZpGYpbF7Gy/4lghMhJUuDyFXGReI
	6d6uUSLSiHjT4CxQPop42TiD6Q7kklBpSAFCkIA2nDoPcXVXhN6X+sOwEcr0yTASEWYNo7
	hmzxKZheN/3vlC8XcsLAd9mkH3S2t4k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-NHAzf3qDOG2pqVm7JH_ewg-1; Thu,
 13 Aug 2026 06:14:59 -0400
X-MC-Unique: NHAzf3qDOG2pqVm7JH_ewg-1
X-Mimecast-MFC-AGG-ID: NHAzf3qDOG2pqVm7JH_ewg_1786616098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3D2B18005B3;
	Thu, 13 Aug 2026 10:14:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13A7F1800348;
	Thu, 13 Aug 2026 10:14:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mail@david-bauer.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] l2tp: account for IP version in SKB headroom
Date: Thu, 13 Aug 2026 12:14:00 +0200
Message-ID: <20260813101400.145692-1-pabeni@redhat.com>
In-Reply-To: <20260808224315.1092263-1-mail@david-bauer.net>
References: <20260808224315.1092263-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
l2tp: account for IP version in SKB headroom

The patch caches kernel_sock_ip_overhead() in the new
tunnel->l3_overhead field at tunnel registration time, and uses that
value instead of sizeof(struct iphdr) when computing the transmit
headroom in l2tp_xmit_core() and the device MTU in
l2tp_eth_adjust_mtu().

A few questions on the new field and its users below.

> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 4712cc41881a..d6fa0f743662 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1237,7 +1237,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
>  	 * make room. Adjust truesize.
>  	 */
>  	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
> -	headroom = NET_SKB_PAD + sizeof(struct iphdr) + uhlen + session->hdr_len;
> +	headroom = NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_len;
>  	if (skb_cow_head(skb, headroom)) {
>  		kfree_skb(skb);
>  		return NET_XMIT_DROP;

[Severity: Medium]
Does the PPP pseudowire still hit the extra copy this patch aims to
remove?  The producers in net/l2tp/l2tp_ppp.c were not converted and
still reserve an IPv4-sized L3 header.

pppol2tp_xmit():

	headroom = NET_SKB_PAD +
		   sizeof(struct iphdr) + /* IP header */
		   uhlen +		/* UDP header (if L2TP_ENCAPTYPE_UDP) */
		   session->hdr_len +	/* L2TP header */
		   2;			/* 2 bytes for PPP_ALLSTATIONS & PPP_UI */
	if (skb_cow_head(skb, headroom))
		goto abort_put_sess;

pppol2tp_sendmsg():

	skb = sock_wmalloc(sk, NET_SKB_PAD + sizeof(struct iphdr) +
			   uhlen + session->hdr_len +
			   2 + total_len,
			   0, GFP_KERNEL);
	...
	skb_reserve(skb, sizeof(struct iphdr));

For an AF_INET6 tunnel socket tunnel->l3_overhead is at least
sizeof(struct ipv6hdr) (40), so the requirement in l2tp_xmit_core()
exceeds what pppol2tp_xmit()/pppol2tp_sendmsg() just reserved by around
20 bytes and __skb_cow() calls pskb_expand_head() again, this time for
every transmitted PPP-over-L2TP packet.

PPPOL2TP_HEADER_OVERHEAD, which drives po->chan.mtu, is likewise still
a fixed 40:

	/* Space for UDP, L2TP and PPP headers */
	#define PPPOL2TP_HEADER_OVERHEAD	40

Would it make sense to convert these sites to tunnel->l3_overhead as
well, so the benefit is not limited to the l2tp_eth pseudowire?
(l2tp_ip_sendmsg() in net/l2tp/l2tp_ip.c also uses sizeof(struct iphdr),
but it is AF_INET-only, so it is only stylistically inconsistent.)

> @@ -1688,6 +1688,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
>  	}
>  
>  	sk->sk_allocation = GFP_ATOMIC;
> +	tunnel->l3_overhead = kernel_sock_ip_overhead(sk);
>  	release_sock(sk);

[Severity: Medium]
Can this snapshot go stale?  kernel_sock_ip_overhead() intentionally
includes mutable socket state:

net/socket.c:kernel_sock_ip_overhead() {
	case AF_INET:
		overhead += sizeof(struct iphdr);
		opt = rcu_dereference_protected(inet->inet_opt, ...);
		if (opt)
			overhead += opt->opt.optlen;
	...
	case AF_INET6:
		overhead += sizeof(struct ipv6hdr);
		...
		if (optv6)
			overhead += (optv6->opt_flen + optv6->opt_nflen);
}

This is the only assignment of tunnel->l3_overhead in net/l2tp/, and
after release_sock(sk) the tunnel fd stays open for user-provided
sockets (tunnel->fd >= 0), so setsockopt(SOL_IP, IP_OPTIONS) or the
IPv6 sticky options (IPV6_HOPOPTS/IPV6_DSTOPTS/IPV6_RTHDR) can change
the real overhead with nothing refreshing the cached value.

Before the patch l2tp_eth_adjust_mtu() re-read the value live under
lock_sock() each time a session/netdev was created, so the sequence

    create tunnel -> setsockopt(fd, IPPROTO_IP, IP_OPTIONS, ...)
                  -> L2TP_CMD_SESSION_CREATE (pwtype ETH)

now computes dev->mtu and dev->needed_headroom from a too-small
overhead, and l2tp_xmit_core() under-reserves headroom for every packet.
Since l2tp_xmit_queue() sets skb->ignore_df = 1, does this end up
fragmenting every full-size frame?

Would reading the overhead where it is consumed (under lock_sock), or
refreshing it when the socket options change, be preferable?  If the
snapshot semantics are intentional, could the field comment and the
changelog say so?

> diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
> index ffd8ced3a51f..aab574376d95 100644
> --- a/net/l2tp/l2tp_core.h
> +++ b/net/l2tp/l2tp_core.h
> @@ -167,6 +167,7 @@ struct l2tp_tunnel {
>  	u32			tunnel_id;
>  	u32			peer_tunnel_id;
>  	int			version;	/* 2=>L2TPv2, 3=>L2TPv3 */
> +	int			l3_overhead;	/* IP header overhead */
>  
>  	char			name[L2TP_TUNNEL_NAME_MAX]; /* for logging */
>  	enum l2tp_encap_type	encap;

> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
> index a4956ef9574c..66d1fc3ad409 100644
> --- a/net/l2tp/l2tp_eth.c
> +++ b/net/l2tp/l2tp_eth.c

[ ... ]

> @@ -197,22 +196,17 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
>  		dev->needed_headroom += sizeof(struct udphdr);
>  	}
>  
> -	lock_sock(tunnel->sock);
> -	l3_overhead = kernel_sock_ip_overhead(tunnel->sock);
> -	release_sock(tunnel->sock);
> -
> -	if (l3_overhead == 0) {
> +	if (tunnel->l3_overhead == 0) {
>  		/* L3 Overhead couldn't be identified, this could be
> -		 * because tunnel->sock was NULL or the socket's
> -		 * address family was not IPv4 or IPv6,
> -		 * dev mtu stays at 1500.
> +		 * because the socket's address family was not IPv4
> +		 * or IPv6 - dev mtu stays at 1500.
>  		 */
>  		return;
>  	}

[Severity: Low]
Can tunnel->l3_overhead still be 0 here for the reason the reworded
comment gives?  l2tp_validate_socket() rejects everything but
PF_INET/PF_INET6:

net/l2tp/l2tp_core.c:l2tp_validate_socket() {
	if (sk->sk_family != PF_INET && sk->sk_family != PF_INET6)
		return -EPROTONOSUPPORT;
}

and l2tp_tunnel_register() only assigns tunnel->l3_overhead on the
success path after that check with a non-NULL sk, so
kernel_sock_ip_overhead() returns at least sizeof(struct iphdr) or
sizeof(struct ipv6hdr).  The one previously reachable reason
(tunnel->sock == NULL) is the one that was dropped from the comment.

Should the guard just be removed, or the comment changed to describe the
actual invariant?

>  	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
>  	 * UDP overhead, if any, was already factored in above.
>  	 */
> -	overhead += session->hdr_len + ETH_HLEN + l3_overhead;
> +	overhead += session->hdr_len + ETH_HLEN + tunnel->l3_overhead;
>  
>  	mtu = l2tp_tunnel_dst_mtu(tunnel) - overhead;
>  	if (mtu < dev->min_mtu || mtu > dev->max_mtu)

[Severity: Medium]
This isn't a bug introduced by this patch, but the same expression is
worth a look while it is being touched.  Both subtractions here are
unsigned, and the fallback assignment escapes the min_mtu/max_mtu
check:

	mtu = l2tp_tunnel_dst_mtu(tunnel) - overhead;
	if (mtu < dev->min_mtu || mtu > dev->max_mtu)
		dev->mtu = ETH_DATA_LEN - overhead;
	else
		dev->mtu = mtu;

For an AF_INET6 tunnel socket the L3 overhead includes
opt_flen + opt_nflen from sticky extension-header options, which can be
a couple of kilobytes each, so overhead can exceed ETH_DATA_LEN and
ETH_DATA_LEN - overhead wraps into a near-2^32 value written straight
into dev->mtu.

The fallback branch is reachable because l2tp_eth_create() sets
dev->min_mtu = 0 and l2tp_tunnel_dst_mtu() returns 0 when no dst is
cached, so mtu = 0 - overhead exceeds dev->max_mtu.

Would an early bound such as "if (overhead >= ETH_DATA_LEN) return;"
be worth adding here?
-- 
This is an AI-generated review.

