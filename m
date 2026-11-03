Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693108;
	b=zYadw2JEQWn3UJNwwX9QXoXhR3uUtP0dsSxtWLEkhMYvsJ3k06jtUsi+3pqoVlgjGGA3
	 g4a0LmxZ5LHNYU5uL2tQ5TDJSJgvuwq9Jc9G9rUw5qqbPxqXA2j+zF686uhS01F1Kzu6e
	 wB+GXDgL8aR8sw29atazd+qnEoRCd4EnVJ1SPyHhRTkPpB+bEfZVU5ueoflvcNwQUiTqX
	 OfdnBPOjqFQB9w0icx7d/uwZz5t7KuGwIo+usBkO6bo7v28iC4luxzuMdQzW2BWV65s3E
	 7SEdsphSFKPzyF2rrGOtAlAtKlSeHmfPXRN6MxkW/R0jzyskEZi2AUJVWqUyl4M4YVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693108;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SCNrFq/IyVeCgzExKAFHfQqPlenHg05qBHN9+qI3/bU=;
	b=UoBPTncnc2r+VKz3sQf70jbvSEf1J3YNyg9L3NwFqPwDBUnXwcqxpzi1IpxABPNsug+K
	 XOB9kRvUZ5t8VmxDvGkbHdHq0NooqOtR7yQdyH7UXnWBxbE0JMKYwv8+7MjUdAuiMQpXK
	 3vGvgm0p/2w9Mdv2h2JGcFkN4iO89VcS76sV2gFl6XWH/5C383GARDw+TCfx8evmmcSKM
	 /MKvBGGO7tB1bRRKAKiHnkPngN0GOGeS+JtW0XkhtwoUcDOqMFypTRFdAt5PRUWCRbhrV
	 KpHtUbO0FJ4MciOPWKn8sMUXhiCtaAiXyLTXF9IfF/aVljYTAASy4GAOCH6RWDm6NPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C1kjPu/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B661606A33F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1kjPu/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89081F00A16;
	Tue,  3 Nov 2026 08:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693108;
	bh=SCNrFq/IyVeCgzExKAFHfQqPlenHg05qBHN9+qI3/bU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=C1kjPu/ZBOxehBQZeqakz2dzXQW/iZKO+uUnvTYQhs2tIx0Vb6+1imlCNsdbv4lMC
	 X2n4C1VQwi4AbyF8Y1Aq0wCYhq+ExtmBL6GKqDQJ+p/hBBDJZcKuz0qaB0ptPvsI9u
	 crBcXyd6bqo0yIzkYiSkPBECtWZIue8rL9AVj6Pndztho3stAz2MJy3Xr5oQ3pt7YA
	 DZVhBd0HDM5K0/l6bMlvREHPUQHYwh6sRGci29wUsxfS3CXivyAVhTJ1MAfacXGqUc
	 s2jUcsgrm09PLlm3dHZuQomLEkPqIuHSPzZ6v3pZbhrhu98k9tEQv7aSyfIYXiCG8A
	 UrCJd2JGwhwKQ==
Subject: Re: [PATCH 14/14] xfrm4: use a full socket for local errors
From: netdev-bot+sashiko@kernel.org
To: steffen.klassert@secunet.com
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
Date: Tue, 03 Nov 2026 08:05:07 +0000
Message-ID: <179369310739.488856.16665150928122536725@kernel.org>
In-Reply-To: <20261102100451.2505200-15-steffen.klassert@secunet.com>
References: <20261102100451.2505200-15-steffen.klassert@secunet.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds the full-socket check inside the callee,
  xfrm4_local_error(), not in the IP-TFS caller.
- [Low] The commit message's root-cause explanation is wrong for IPv4.

Pre-existing issues:
- [Critical] IPv6 version of the same IP-TFS too-big path: a NULL pointer
  dereference of skb->sk is still reachable.

--

xfrm4: use a full socket for local errors

This commit changes xfrm4_local_error() so it resolves the skb owner with
skb_to_full_sk() before it calls inet_sk() and ip_local_error(). A request
socket is mapped to its listener, and the function returns early when no
full socket is available. This fixes a slab-out-of-bounds read when IP-TFS
reports a SYN-ACK that exceeds its payload MTU.

Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel.org/

> xfrm4_tunnel_check_size() already checks sk_fullsock() since commit
> 1620c88887b1 ("xfrm: Fix the usage of skb->sk"), so iptfs_is_too_big() is
> the only remaining IPv4 caller passing a request socket here: the sk it
> tests is the listener, while skb->sk is the request socket.

[Severity: Low]
Does this description hold for IPv4?

For IPv4 SYN-ACKs, tcp_make_synack() makes the request socket the owner:

net/ipv4/tcp_output.c:tcp_make_synack() {
    ...
	case TCP_SYNACK_NORMAL:
	case TCP_SYNACK_RETRANS:
		skb_set_owner_edemux(skb, req_to_sk(req));
		break;
    ...
}

tcp_v4_send_synack()->ip_build_and_send_pkt() then passes skb->sk as the
dst_output sk:

net/ipv4/ip_output.c:ip_build_and_send_pkt() {
    ...
	return ip_local_out(net, skb->sk, skb);
}

So the sk that reaches iptfs_output_collect()->iptfs_is_too_big() looks
like the request socket itself, which is the same pointer as skb->sk. The
listener versus request socket split happens on IPv6, where
tcp_v6_send_synack() calls ip6_xmit() with the listener.

Would it be more accurate to say that iptfs_is_too_big() only checks that
sk is non-NULL and never calls sk_fullsock()?

> diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
> index 0ae67d537499a..fffa3c4f456ee 100644
> --- a/net/ipv4/xfrm4_output.c
> +++ b/net/ipv4/xfrm4_output.c
> @@ -38,9 +38,12 @@ int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  
>  void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
>  {
> +	struct sock *sk = skb_to_full_sk(skb);
>  	struct iphdr *hdr;
>  
> +	if (!sk)
> +		return;
> +

[Severity: Low]
Can this early return drop a too-big packet without sending any feedback?

iptfs_is_too_big() in net/xfrm/xfrm_iptfs.c chooses between a local error
and ICMP by testing the sk passed to dst_output(), not the skb's own
socket:

net/xfrm/xfrm_iptfs.c:iptfs_is_too_big() {
    ...
	if (sk)
		xfrm_local_error(skb, pmtu);
	else if (ip_hdr(skb)->version == 4)
		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(pmtu));
    ...
}

When that sk is non-NULL but skb_to_full_sk(skb) returns NULL, the code
now returns here. No error is queued, no ICMP_FRAG_NEEDED is sent, and the
skb is freed with SKB_DROP_REASON_PKT_TOO_BIG. Two IPv4 cases appear to
reach this:

TIME_WAIT replies: ip_send_unicast_reply() calls
skb_set_owner_edemux(nskb, orig_sk) with a TW socket, and ip_send_skb()
passes skb->sk to ip_local_out(). sk_to_full_sk() maps TW to NULL.

UDP tunnels: iptunnel_xmit() calls ip_local_out(net, sk, skb) with the
tunnel socket for forwarded skbs, where skb->sk is NULL.

Both peer callers gate on the skb's own socket and fall back to ICMP:

net/xfrm/xfrm_output.c:xfrm4_tunnel_check_size() {
    ...
		if (skb->sk && sk_fullsock(skb->sk))
			xfrm_local_error(skb, mtu);
		else
			icmp_send(skb, ICMP_DEST_UNREACH,
				  ICMP_FRAG_NEEDED, htonl(mtu));
    ...
}

xfrm6_tunnel_check_size() does the same with sk = skb_to_full_sk(skb).

Before this patch, these paths were a NULL dereference or an
out-of-bounds inet_sock read, so ICMP was never sent here either.

Could the check go in iptfs_is_too_big() instead, gating on
skb_to_full_sk(skb) as the peers do, so the ICMP fallback is kept?

>  	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
> -	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
> -		       inet_sk(skb->sk)->inet_dport, mtu);
> +	ip_local_error(sk, EMSGSIZE, hdr->daddr, inet_sk(sk)->inet_dport, mtu);
>  }

[Severity: Critical]
This is a pre-existing issue, but is the IPv6 version of this IP-TFS
too-big path still open to a NULL dereference of skb->sk?

The commit message points to 6973a21ee73c for xfrm6_local_error(). Before
that code runs, though, the xfrm_local_error() dispatcher reads
skb->sk->sk_family without a NULL check:

net/xfrm/xfrm_output.c:xfrm_local_error() {
    ...
	else if (skb->protocol == htons(ETH_P_IPV6) &&
		 skb->sk->sk_family == AF_INET6)
		proto = AF_INET6;
    ...
}

Since iptfs_is_too_big() tests the dst_output sk, there are IPv6 paths
where that sk is non-NULL but skb->sk is NULL:

tcp_v6_send_response() for an RST with no matching socket. buff comes
from alloc_skb() with no owner and is sent with
ip6_xmit(ctl_sk, buff, ...).

tcp_v6_send_synack() in syncookie mode. tcp_make_synack() does not
attach the skb for TCP_SYNACK_COOKIE, but ip6_xmit() gets the listener.

udp_tunnel6_xmit_skb()->ip6tunnel_xmit(sk, ...) for forwarded VXLAN or
Geneve traffic.

In each case skb->protocol is ETH_P_IPV6, and the path is:

dst_output()
  iptfs_output_collect(net, sk, skb)
    iptfs_is_too_big(sk, skb, pmtu)
      xfrm_local_error()
        skb->sk->sk_family   <-- skb->sk is NULL

This needs an IPv6 IP-TFS SA with XFRMA_IPTFS_DONT_FRAG and a packet
larger than pmtu. A remote SYN to a closed port or a SYN flood could then
trigger it from softirq context.

The commit message limits this fix to IPv4, so this was not introduced
here. Gating iptfs_is_too_big() on skb_to_full_sk(skb), as
xfrm6_tunnel_check_size() and xfrm4_tunnel_check_size() do, would cover
both families. Another option is a NULL check on skb->sk in
xfrm_local_error() before it reads sk_family.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102100451.2505200-2-steffen.klassert%40secunet.com
