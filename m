Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5A374A1A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628882; cv=none; b=qQrMec+xrFAyw+RBC7oA9v6t8www9GT472Ab6uWxW/PJO1/Uz2urAQG0Y76oGETwHPnzw840b3tOexk3rfScWcWSAjdCL3cw/vkixKXh9boXnG9SpyZxVqcnexal9mMUCnJiN5EwV6yl6Oq1sl4Cms+WrGV6Q9yTvp717kKfyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628882; c=relaxed/simple;
	bh=gd3TEBQoE6oxIwP8gdHgJ9N0eWO1d5ePmBRO22eYo+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag1dme9d8FvxYD2IDEhPtW5TXOClb3jOzR/yUamOkiGFk/ZGcdIqzmTnMPdPkiZgSK50mfMgmHcxM2ezWf78nJZB7VmXaMsPeitGdwAf1LUtzE030fsD4j14muq8SrcCyHD5spOKpq8T1hlb35wlbLauYPoMRHJTmbArspe8iKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaRgaAgz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaRgaAgz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786628878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6W6peVx2R0LbNWc5Ilzh3NLTkRs9G0IRVQxsG3XW9rc=;
	b=OaRgaAgzuAcQ1AYw+eC9qB7uLo2yGtX24e5KHFZ2LfuRPtvSom/sIiOtz3lp6toAW9xQAt
	6PQRebLWwPh7t9Jqh6Qu39y4E54JUI+Dn2I5AZD8MIZuL+qvNx7G5NctQ6mfl+oaDDOh/z
	gkz4RlJyJv7ra13NEJ1UgentFIKOa2E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-OQawKh9DOrGwDmEuFNwoyw-1; Thu,
 13 Aug 2026 09:47:54 -0400
X-MC-Unique: OQawKh9DOrGwDmEuFNwoyw-1
X-Mimecast-MFC-AGG-ID: OQawKh9DOrGwDmEuFNwoyw_1786628872
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C6841955BEE;
	Thu, 13 Aug 2026 13:47:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87771180049F;
	Thu, 13 Aug 2026 13:47:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mail@david-bauer.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] l2tp: unify headroom calculation
Date: Thu, 13 Aug 2026 12:14:58 +0200
Message-ID: <20260813101458.146438-1-pabeni@redhat.com>
In-Reply-To: <20260808224315.1092263-2-mail@david-bauer.net>
References: <20260808224315.1092263-2-mail@david-bauer.net>
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
l2tp: unify headroom calculation

This introduces three inline helpers in net/l2tp/l2tp_core.h that compute
the UDP header length, the per-session encapsulation overhead and the
required skb headroom, and switches l2tp_xmit_core() and
l2tp_eth_adjust_mtu() over to them.  A few questions below on the new
helpers and their users.

> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index d6fa0f743662..f52bf3b53290 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1227,18 +1227,16 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
>  	struct l2tp_tunnel *tunnel = session->tunnel;
>  	unsigned int data_len = skb->len;
>  	struct sock *sk = tunnel->sock;
> -	int headroom, uhlen, udp_len;
>  	int ret = NET_XMIT_SUCCESS;
>  	struct inet_sock *inet;
>  	struct udphdr *uh;
> +	int udp_len;
>  
>  	/* Check that there's enough headroom in the skb to insert IP,
>  	 * UDP and L2TP headers. If not enough, expand it to
>  	 * make room. Adjust truesize.
>  	 */
> -	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
> -	headroom = NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_len;
> -	if (skb_cow_head(skb, headroom)) {
> +	if (skb_cow_head(skb, l2tp_session_skb_headroom(session, tunnel))) {
>  		kfree_skb(skb);
>  		return NET_XMIT_DROP;
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but since the patch re-touches
exactly these reads, would it be worth snapshotting session->hdr_len once
into a local here?

l2tp_xmit_core() reads session->hdr_len three times for the same packet
with no lock held: once inside l2tp_session_skb_headroom() for the
skb_cow_head() reservation, once for the header push:

	if (tunnel->version == L2TP_HDR_VER_2)
		l2tp_build_l2tpv2_header(session, __skb_push(skb, session->hdr_len));
	else
		l2tp_build_l2tpv3_header(session, __skb_push(skb, session->hdr_len));

and once more for udp_len further down.

session->hdr_len is written at run time by l2tp_session_set_header_len()
from contexts that share no lock with the transmit path: netlink session
modify on L2TP_ATTR_SEND_SEQ, pppol2tp setsockopt PPPOL2TP_SO_SENDSEQ, and
the receive softirq LNS-mode auto-enable in l2tp_recv_common():

	if (!session->lns_mode && !session->send_seq) {
		trace_session_seqnum_lns_enable(session);
		session->send_seq = 1;
		l2tp_session_set_header_len(session, tunnel->version,
					    tunnel->encap);

The last one is driven by whether the remote peer sets the S bit in
received data packets, so the window can be opened by remote input rather
than only by privileged configuration.

If hdr_len goes from 6 to 10 (L2TPv2, send_seq turned on) between the
__skb_push() and the udp_len computation, does the UDP length written by
udp_set_len_short() and the pseudo-header used for the checksum end up
describing four more bytes than were actually pushed?  sk->sk_lock.slock is
taken only after the push, and none of the writers hold it.

> @@ -1290,7 +1288,9 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
>  		uh = udp_hdr(skb);
>  		uh->source = inet->inet_sport;
>  		uh->dest = inet->inet_dport;
> -		udp_len = uhlen + session->hdr_len + data_len;
> +
> +		udp_len = l2tp_tunnel_udp_hdrlen(tunnel);
> +		udp_len += session->hdr_len + data_len;
>  		if (udp_len > U16_MAX) {
>  			kfree_skb(skb);
>  			ret = NET_XMIT_DROP;
> diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
> index aab574376d95..2c41877b6ce5 100644
> --- a/net/l2tp/l2tp_core.h
> +++ b/net/l2tp/l2tp_core.h
> @@ -335,6 +335,25 @@ static inline int l2tp_v3_ensure_opt_in_linear(struct l2tp_session *session, str
>  	return 0;
>  }
>  
> +static inline int l2tp_tunnel_udp_hdrlen(struct l2tp_tunnel *tunnel)
> +{
> +	return tunnel->encap == L2TP_ENCAPTYPE_UDP ?
> +		sizeof(struct udphdr) : 0;
> +}
> +
> +static inline int l2tp_session_overhead(struct l2tp_session *session,
> +					struct l2tp_tunnel *tunnel)
> +{
> +	return l2tp_tunnel_udp_hdrlen(tunnel) + session->hdr_len +
> +		tunnel->l3_overhead;
> +}
> +
> +static inline int l2tp_session_skb_headroom(struct l2tp_session *session,
> +					    struct l2tp_tunnel *tunnel)
> +{
> +	return NET_SKB_PAD + l2tp_session_overhead(session, tunnel);
> +}

[Severity: Low]
The hardcoded formulas in the PPP pseudowire are pre-existing and not
introduced by this patch, but the helpers land in the shared header while
the equivalent open-coded computations in net/l2tp/l2tp_ppp.c stay as they
are.  Was the PPP pseudowire meant to be part of this?

pppol2tp_xmit() still computes its own value:

	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(struct udphdr) : 0;
	headroom = NET_SKB_PAD +
		   sizeof(struct iphdr) + /* IP header */
		   uhlen +		/* UDP header (if L2TP_ENCAPTYPE_UDP) */
		   session->hdr_len +	/* L2TP header */
		   2;			/* 2 bytes for PPP_ALLSTATIONS & PPP_UI */
	if (skb_cow_head(skb, headroom))

pppol2tp_sendmsg() allocates with the same hardcoded IPv4 header size:

	skb = sock_wmalloc(sk, NET_SKB_PAD + sizeof(struct iphdr) +
			   uhlen + session->hdr_len +
			   2 + total_len, /* 2 bytes for PPP_ALLSTATIONS & PPP_UI */
			   0, GFP_KERNEL);

pppol2tp_tunnel_mtu() still uses the fixed PPPOL2TP_HEADER_OVERHEAD instead
of l2tp_session_overhead(), and pppol2tp_connect() still sets
po->chan.hdrlen = PPPOL2TP_L2TP_HDR_SIZE_SEQ, which is the PPP-layer
analogue of the dev->needed_headroom this patch fixes for l2tpeth.

Since sizeof(struct iphdr) substitutes for tunnel->l3_overhead, for an IPv6
tunnel socket the PPP paths ask for at least 20 bytes less than the
subsequent skb_cow_head(l2tp_session_skb_headroom()) in l2tp_xmit_core()
requests.  In practice __skb_cow() rounds the expansion up with
ALIGN(delta, NET_SKB_PAD), so this normally only costs a redundant
pskb_expand_head(), but the tree now carries two disagreeing definitions of
the same quantity.

Also, the changelog says "Unify the calculation to determine the required
headroom for each skb" - could it be narrowed to say which pseudowires were
converted, since the PPP paths keep their own calculation?

> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
> index 66d1fc3ad409..687ce1c6db94 100644
> --- a/net/l2tp/l2tp_eth.c
> +++ b/net/l2tp/l2tp_eth.c
> @@ -190,12 +190,6 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
>  	unsigned int overhead = 0;
>  	u32 mtu;
>  
> -	/* if the encap is UDP, account for UDP header size */
> -	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
> -		overhead += sizeof(struct udphdr);
> -		dev->needed_headroom += sizeof(struct udphdr);
> -	}
> -

[ ... ]

> @@ -214,7 +206,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
>  	else
>  		dev->mtu = mtu;
>  
> -	dev->needed_headroom += session->hdr_len;
> +	dev->needed_headroom = l2tp_session_skb_headroom(session, tunnel);
>  }

[Severity: Low]
Should NET_SKB_PAD be part of dev->needed_headroom?

Before the patch the field accumulated only bytes this device actually
prepends (sizeof(struct udphdr) for UDP encap plus session->hdr_len).  With
l2tp_session_skb_headroom() the value also contains NET_SKB_PAD, which is
the generic skb allocation pad rather than a header the device prepends.

include/linux/netdevice.h describes needed_headroom as "Extra headroom the
hardware may need", and it is added to hard_header_len for every skb the
stack allocates for transmission on the device:

	#define LL_RESERVED_SPACE_EX(dev, hlen) \
		((((hlen) + READ_ONCE((dev)->needed_headroom)) \
		  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)

It is also propagated to stacked devices via netdev_get_fwd_headroom():

	return dev->priv_flags & IFF_PHONY_HEADROOM ? 0 : dev->needed_headroom;

so when the l2tpeth device is enslaved to a bridge, br_if.c's
update_headroom() pushes the maximum port value into every other port with
netdev_set_rx_headroom(), and the extra ~64 bytes get charged to unrelated
devices.  A grep over net/ and drivers/net/ did not turn up another device
that folds NET_SKB_PAD into needed_headroom.

Would dropping NET_SKB_PAD from the value stored in needed_headroom (or
keeping it only in the skb_cow_head() request in l2tp_xmit_core()) be the
intended reconciliation?  Either way, the changelog does not mention this
change of meaning for needed_headroom.
-- 
This is an AI-generated review.

