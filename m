Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD5361962;
	Fri, 28 Aug 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958160; cv=none; b=cPpXdgGosFn3T4TN6LLzxh2TgGf4E6KWQLakt+ljd8fet67sEVEVnpj+1tBW9a7MCHd6g6pVT6xWvy25kv/fbF2QB+bA3Uo0fhR/iuZduvoTejVu+NR9Uttof4Gz6SM/a75KMAxpBXOupPGEW/5JNBQGX1wcSUNVJRCMdDButR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958160; c=relaxed/simple;
	bh=q/aVOx1Jt9m85nGg+OvYtcABg73VkxcEEHgDL2KhNNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIZToNF1F6rZCYsRkCZed8caiKGP7ELymuqolhihO+e48WCdYU2P1jqM1551pZLrM1sOPMCU+BIkpwWECawLq2eG9qPrsJOIgTn7HkRID23cY26UUibB4h+g/+X5FkAp8SkPA8/iiaRNGlRYaGG3i+KLcAFdtyUhQmSRGd6xLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e11TqV0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e11TqV0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6481F000E9;
	Fri, 28 Aug 2026 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787958158;
	bh=aq3GNAIJo2tBgR45pzAz2up2J0gJA/DyPscT3N9oqlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e11TqV0tAfLXqXIskD5M0HWR8Vc7vJRtWcCTCrXOlOUXYSiCC1zJrWMRHuP3kYeST
	 fzgiMQ0vsY/2bVEWP7gP2TiWmMioMj5Oy4257C/dv9O28UCRS9k+ruQijS+QIGnjAc
	 AErDW/0Dc79J4lRrZ/jgHWz9nljCyVOitrpWcTRZton/luGn/sgptw7L2OSSj3C3Xp
	 /DiMRkszfU/KVE7iE/YcDexeUeMmlqGHLfVh6SkV+dSnp+7YdobLCQ6zl3XGveE+oh
	 EgZJGtM5u4rU6AydVibPDFBYVQkhUcd6EgfMiUm+oUcjvagKhd4fWomEQSM64TeGjt
	 DKyLrMRbOdCaA==
From: Jakub Kicinski <kuba@kernel.org>
To: 4ncienth@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] udp: revalidate socket family before publishing an IPv6 cork
Date: Fri, 28 Aug 2026 16:02:36 -0700
Message-ID: <20260828230236.380559-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825160630.1888866-1-4ncienth@gmail.com>
References: <20260825160630.1888866-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "You have to repost this with appropriate people in the
CC list, before you do please check the following AI generated
review."
---
udp: revalidate socket family before publishing an IPv6 cork

Adds a recheck of sk->sk_family after lock_sock() in udpv6_sendmsg(), so a
socket converted to AF_INET by IPV6_ADDRFORM during the lockless flow/route
preparation no longer gets an AF_INET6 cork published on it.  The mismatch
path bails out with -EAFNOSUPPORT through the existing error label.

> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index fd875908ac0c6..566c634a5a594 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1716,6 +1716,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	}
>  
>  	lock_sock(sk);
> +	if (unlikely(sk->sk_family != AF_INET6)) {
> +		release_sock(sk);
> +		err = -EAFNOSUPPORT;
> +		goto out;
> +	}

[Severity: High]
Does this branch leave the IPv6 dst published in sk->sk_dst_cache?

The lockless preparation earlier in udpv6_sendmsg() calls
ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected), and for a connected
send that function stores the route on the socket before the lock is taken:

net/ipv6/ip6_output.c:ip6_sk_dst_lookup_flow() {
	...
	if (connected && !IS_ERR(dst))
		ip6_sk_dst_store_flow(sk, dst_clone(dst), fl6);
	...
}

That store happens inside the same window the recheck is meant to cover.
The new mismatch path then does release_sock(sk) and goto out, and out:
only drops the function's local reference with dst_release(dst).  Neither
do_ipv6_setsockopt(IPV6_ADDRFORM) nor inet6_cleanup_sock() calls
sk_dst_reset() - inet6_cleanup_sock() only frees pktoptions, rxpmtu,
flowlabels and np->opt - so the converted AF_INET socket appears to keep an
rt6_info in its dst cache.

Can the IPv4 path then consume that entry as an rtable?  udp_sendmsg() does:

net/ipv4/udp.c:udp_sendmsg() {
	...
	if (connected)
		rt = dst_rtable(sk_dst_check(sk, 0));
	...
}

dst_rtable() in include/net/route.h is a bare container_of_const with no
family or type check, and sk_dst_check() only discards the entry when
dst->ops->check() returns NULL.  On the IPv6 side the cookie is ignored
when sernum is set:

net/ipv6/route.c:ip6_dst_check() {
	...
	if (rt->sernum)
		return rt6_is_valid(rt) ? dst : NULL;
	...
}

and sernum is non-zero for pcpu routes derived from nexthop objects:

net/ipv6/route.c {
	...
	if (f6i->nh)
		pcpu_rt->sernum = rt_genid_ipv6(dev_net(dev));
	...
}

so sk_dst_check(sk, 0) from the IPv4 path can hand the stale rt6_info back.
The skb then gets a 20-byte IPv4 header from ip_make_skb()/__ip_make_skb()
and is handed to dst_output() == ip6_output(), where ip6_finish_output2()
reads ipv6_hdr(skb)->daddr at offsets 24..39 of a 20-byte network header.

Isn't that the same uninitialized read in ip6_finish_output2() the commit
message says this change eliminates?

The commit message states:

    the retained IPv6 dst routes the skb through ip6_output().
    ip6_finish_output2() consequently consumes the unwritten 20-byte tail.

If the retained dst is part of the described failure, should the mismatch
branch (or the code before the lookup) also invalidate the socket route
cache with sk_dst_reset(sk)?

Also, the same ip6_sk_dst_store_flow() publish happens on the !corkreq
lockless branch, which never takes the socket lock at all:

net/ipv6/udp.c:udpv6_sendmsg() {
	...
	/* Lockless fast path for the non-corking case */
	if (!corkreq) {
		...
		/* ip6_make_skb steals dst reference */
		goto out_no_dst;
	}
	...
}

Is that path covered by anything here?

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
since this change adds a family recheck on the send side, the peer site in
do_ipv6_setsockopt(IPV6_ADDRFORM) looks inconsistent between TCP and UDP:

net/ipv6/ipv6_sockglue.c:do_ipv6_setsockopt() {
	...
			if (sk->sk_protocol == IPPROTO_UDP) {
				if (udp_sk(sk)->pending == AF_INET6) {
					retv = -EBUSY;
					break;
				}
			} else if (sk->sk_protocol == IPPROTO_TCP) {
				if (sk->sk_prot != &tcpv6_prot) {
					retv = -EBUSY;
					break;
				}
	...
}

The TCP branch refuses the conversion when sk_prot was swapped out (added
by commit b6f6118901d1, "ipv6: restrict IPV6_ADDRFORM operation", for the
sockmap case), while the UDP branch only looks at pending and then
overwrites the proto unconditionally:

net/ipv6/ipv6_sockglue.c:do_ipv6_setsockopt() {
	...
				WRITE_ONCE(sk->sk_prot, &udp_prot);
				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
				WRITE_ONCE(sk->sk_family, PF_INET);
	...
}

UDP sockets can have sk_prot swapped the same way.  udp_bpf_update_proto()
installs &udp_bpf_prots[family] via sock_replace_proto() and keeps the old
proto in psock->sk_proto, and sock_map_sk_state_allowed() accepts any
hashed UDP socket:

net/core/sock_map.c:sock_map_sk_state_allowed() {
	...
	if (sk_is_udp(sk))
		return sk_hashed(sk);
	...
}

A connect()ed AF_INET6 UDP socket is hashed, so sockmap membership and the
ADDRFORM preconditions can hold at the same time.  After the conversion the
sockmap-installed proto is discarded, so sock_map_close and
udp_bpf_recvmsg no longer apply.  Later, when the psock is dropped,
sk_psock_restore_proto() -> udp_bpf_update_proto(restore=true) ->
sock_replace_proto(sk, psock->sk_proto) writes udpv6_prot back onto a
socket whose sk_family is now PF_INET and whose ops are inet_dgram_ops.

Should the UDP branch also check sk->sk_prot != &udpv6_prot, the way the
TCP branch does?  Reaching this needs privileges to create and populate a
sockmap.
-- 
pw-bot: cr
