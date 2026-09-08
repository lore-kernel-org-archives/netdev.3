Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99238576ED7
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907744; cv=none; b=Z9PrvNBQ2s2JWsJSr0CRRG+xoCzdvX3G6yEH4O4JjoZJ107JI1XMwVceBXJVOcARCGVUEvHqPdyNWifpQBrPJVy7jGQcaWXhkicMo228yMmXBwwm1ocK7MvzAmnmEw4QDhN/IzZ7e387ND0z0iWf+m/3V4ovDTa9Rogn4itARyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907744; c=relaxed/simple;
	bh=VRc+F6fT0RIK3LXB9CH70sPfs/XkcPi1PB+P9kNXNTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWNYshSnsYUnZXntAHqian6Hr1GMstmBlkYyB5WtzXeEDducxGfxkVYzOXHPHktzRqyw9wU0LNhP3mBAxrtHJCcw4Yr69jPaol170/Qztz6xnBlAxr/x1e0iICUkIS8BwSVXu5X03qQq3HepnFHhP/59KB6wCZ+KbH28Rcorl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka3R/F4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka3R/F4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FCA1F00A3F;
	Tue,  8 Sep 2026 22:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907737;
	bh=Z+9o9EuSi4fHUV1eqTwMTAay9JDXAuufmSUFbS69x80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ka3R/F4oo2bJY2dEnKk2/yqRprBgCJvyvFkQykfCMHpDsbi/h6egj1sGkusHIB/py
	 zJdtUuqf1KSA/2U2Dzp9MQEOqlKj/WooVH9dPKzIaUcVG9PkBY2M1UQhkTYdtFAEZD
	 joVbxcxqAkCciQ3MaCz6XrdRhSXfsW8z4Dtn6VFytKmdmQ89qNpsLdEzMS80HH08yb
	 KSDpxIFoKXUUMonoaHV7gQul23ly/2UKBCIzUEVd1eNxfW+V/SWep/UNATazzy+O8S
	 ZXNPRo0PjQBrRW3OEAwQfWp1lGZJeR5Wq31CKn57JY2dMRazhUGjIvMI/9v+EPi+TW
	 LAySzT3VJCH+A==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 05/12] ipv6: xfrm: use full sockets in local error paths
Date: Tue,  8 Sep 2026 15:48:56 -0700
Message-ID: <20260908224856.1591189-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-6-steffen.klassert@secunet.com>
References: <20260907093020.2228346-6-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ipv6: xfrm: use full sockets in local error paths

xfrm6_local_rxpmtu() and xfrm6_local_error() used skb->sk directly and cast
it to a full inet/IPv6 socket, which is wrong when a SYN-ACK skb is owned by
a TCP_NEW_SYN_RECV request_sock.  Both callbacks now resolve the owner with
skb_to_full_sk() and return early when there is no full socket attached.

> diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
> index 512bdaf136997..44b221a09a0c8 100644
> --- a/net/ipv6/xfrm6_output.c
> +++ b/net/ipv6/xfrm6_output.c

[ ... ]

> @@ -31,7 +34,10 @@ void xfrm6_local_error(struct sk_buff *skb, u32 mtu)
>  {
>  	struct flowi6 fl6;
>  	const struct ipv6hdr *hdr;
> -	struct sock *sk = skb->sk;
> +	struct sock *sk = skb_to_full_sk(skb);
> +
> +	if (!sk)
> +		return;

[Severity: High]
Should the IPv4 sibling of this same afinfo->local_error hook get the same
treatment?  xfrm4_local_error() in net/ipv4/xfrm4_output.c still hands the
raw skb->sk to inet_sk():

net/ipv4/xfrm4_output.c:xfrm4_local_error() {
	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
		       inet_sk(skb->sk)->inet_dport, mtu);
}

inet_dport is skc_dport and stays in bounds, but ip_local_error() starts
with:

net/ipv4/ip_sockglue.c:ip_local_error() {
	if (!inet_test_bit(RECVERR, sk))
		return;

which expands to test_bit(INET_FLAGS_RECVERR, &inet_sk(sk)->inet_flags).
inet_flags sits after the embedded struct sock in struct inet_sock, well
past the end of a tcp_request_sock allocation, so isn't this the same read
beyond the request_sock allocation that the commit message describes for
IPv6?  And if that out-of-bounds bit happens to read as set, execution
continues into sock_queue_err_skb(sk, skb), which touches
sk->sk_error_queue - also outside the request_sock object.

Is that path reachable today?  For a SYN-ACK, tcp_make_synack() attaches the
skb to the request sock:

net/ipv4/tcp_output.c:tcp_make_synack() {
	case TCP_SYNACK_NORMAL:
	case TCP_SYNACK_RETRANS:
		skb_set_owner_edemux(skb, req_to_sk(req));

and for an IPTFS SA the output path goes
iptfs_output_collect()->iptfs_is_too_big(), which gates on the sk argument
(the listener) rather than on skb->sk:

net/xfrm/xfrm_iptfs.c:iptfs_is_too_big() {
	if (sk)
		xfrm_local_error(skb, pmtu);

and the AF_INET branch of the dispatcher does no full-socket check either:

net/xfrm/xfrm_output.c:xfrm_local_error() {
	if (skb->protocol == htons(ETH_P_IP))
		proto = AF_INET;

The classic ESP path avoids this because xfrm4_tunnel_check_size() checks
skb->sk && sk_fullsock(skb->sk) before calling xfrm_local_error(), so the
contract looks like it is enforced only at some call sites.  Would it make
sense to fix xfrm4_local_error() in the same series, or push the
skb_to_full_sk() check up into xfrm_local_error() so both families are
covered?

>  
>  	hdr = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
>  	fl6.fl6_dport = inet_sk(sk)->inet_dport;

[Severity: Low]
Does this now report the wrong offender port?  sk_to_full_sk() replaces the
request sock with the listener:

include/net/inet_sock.h:sk_to_full_sk() {
	if (sk && READ_ONCE(sk->sk_state) == TCP_NEW_SYN_RECV)
		sk = inet_reqsk(sk)->rsk_listener;

A listening socket has inet_dport == 0, while fl6.daddr on the next line
still comes from the packet, i.e. the real peer.

ipv6_local_error() stores that value:

net/ipv6/datagram.c:ipv6_local_error() {
	serr->port = fl6->fl6_dport;

and ipv6_recv_error() hands it to userspace:

net/ipv6/datagram.c:ipv6_recv_error() {
		sin->sin6_port = serr->port;

So with IPV6_RECVERR set on the listener, the SO_EE_OFFENDER sockaddr_in6
ends up as <real peer address, port 0>.  Before this change the same
expression read the request sock's skc_dport, which is the request's actual
remote port.  Would using the request's remote port (ir_rmt_port) when the
skb owner is a request sock keep both halves of the error record
consistent?
