Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265336;
	b=FizXhnkl1/SZrFfHJluIjp0I7CpF17Fz5uvlr+C9AyC7VtjxG88dPJPYj3o7Le43dTjx
	 VT9G8vZ2ZBJqMmi2WarJWui59D2ZsEP0YxweeLHQCLTC1yqhd+Wr1QswHfPd6+A+3o7YG
	 NHAFS+mMMi+32f3veNl4MAhkdpypPTs6XBwSMMuvJp2WEztsVEVYz+xKz5Bi+ni9HfOLj
	 Q6+C7346+Lm0ObJvGVNfqwlT5WR6uV7dehnFaDhfPWQWuDNqGPIRNIxONkgJmb2QPtCV6
	 baCP0idIx4+m6h4tDVs5UoJTLboI/PlgLPRjc988NVKrbh7uRaAkdoOLqkgnhZh6hQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265336;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jnnudFivQXRA6ZoeOMrEtcMeJdKY4hVR8OblfVoIrLM=;
	b=Uc1uaHnVYHn9XDWIfCnq9tgT36xOL7wIBYjvKmzVzi7sMDf/MIp9aGMXwCE7/ZlDAECE
	 2hyWa5V7lWQndKmW5OrrM8Y1drJHLADn41S64nD7pVzx2DKkQp9JRpoLxWVsQVXaJvSyO
	 AietxQHX8Rp35/QHDa4z0PcK9nuZNe7W9U0mDha09GteRLwt26QKsQrbGcdExrgdE6JvY
	 TFi4rCBGKyTgjdF/yDVYo0AaViYAf4/crBhZuKMyPuDNQ9ZWOrauptXRYx9RxtwoZ/I+o
	 x7BcgVQuv/frjtuh5YfL7L/mmZM/Ea+ECsG+oI8Mg0r1Tm8FuryCD61qqhyjlfJa1uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irvrdGgU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF3606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=irvrdGgU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D381F0089F;
	Mon,  9 Nov 2026 23:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265335;
	bh=jnnudFivQXRA6ZoeOMrEtcMeJdKY4hVR8OblfVoIrLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=irvrdGgUPau4WjJqhec+myLZlpaBf74naHLH1ru90JkMXj3XktKHhyJDZ/PtYRdoD
	 31g9+n2ICQ7oqBfFd/bkjQWgfdsqK5aala6y1V1BzotjxoY9qPLntJoB/hwgaEmVgn
	 o9YcsZ+2eSaevokTLfReQCOMX9R8AnxWsCVsBtzJ98JiPp8C/PlKGBkUa301kkMkL1
	 v95gWKeGKnoRiO7MDORy3jvXrLLp15vd7pahQkaBrNuh/Ck49JMDjR9cb0XrpmiBei
	 pngOEzKTB1VLb+6ueVpaPGTVNrlWoaKxsoe6HogrtBvhqcm000RwJELR8v/NrU0l2o
	 JjxD108oZuEFA==
Subject:
 Re: [PATCH net] udp: do not use a cross-family sk_rx_dst in early demux
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org
Date: Mon, 09 Nov 2026 23:02:14 +0000
Message-ID: <179426533453.994134.11750369259085131425@kernel.org>
In-Reply-To: <20261106110135.2161204-1-edumazet@kernel.org>
References: <20261106110135.2161204-1-edumazet@kernel.org>
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

- [Medium] The commit message says "TCP does not have the same problem",
  but tcp_v6_early_demux() (net/ipv6/ip6_input.c) uses the same pattern…

--

udp: do not use a cross-family sk_rx_dst in early demux

With this patch, udp_v4_early_demux() and udp_v6_early_demux() use the
cached sk->sk_rx_dst only when dst->ops->family matches the packet's
family. Without the check, a dual-stack socket connected to a v4-mapped
address can attach an IPv4 dst to an IPv6 skb, or the reverse, because
the dst_check() callbacks can ignore the cookie.

> TCP does not have the same problem: sk_ehashfn() hashes a v4-mapped
> socket with inet_ehashfn(), while IPv6 lookups use inet6_ehashfn(),
> so IPv6 packets do not normally find a v4-mapped TCP socket.

[Severity: Medium]
Is this statement about TCP fully accurate? tcp_v6_early_demux() in
net/ipv6/ip6_input.c uses the same pattern this patch removes from UDP.
It never checks the family of the cached dst:

net/ipv6/ip6_input.c:tcp_v6_early_demux() {
    ...
		if (sk_fullsock(sk)) {
			struct dst_entry *dst = rcu_dereference(sk->sk_rx_dst);

			if (dst)
				dst = dst_check(dst, sk->sk_rx_dst_cookie);
			if (dst &&
			    sk->sk_rx_dst_ifindex == skb->skb_iif)
				skb_dst_set_noref(skb, dst);
		}
    ...
}

A v4-mapped AF_INET6 TCP socket caches an IPv4 rtable in sk_rx_dst.
That covers a dual-stack child accepted over IPv4 and a socket connected
to ::ffff:a.b.c.d. ipv4_dst_check() ignores the cookie, so dst_check()
here does not reject that rtable.

Take a spoofed IPv6 segment from ::ffff:C to ::ffff:S with matching ports
(ip6_rcv_core() now accepts it). inet6_match() would accept the
v4-mapped socket for it. The only thing that keeps the socket out of the
lookup is the sk_hash comparison:

net/ipv6/inet6_hashtables.c:__inet6_lookup_established() {
    ...
	hash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
    ...
		if (sk->sk_hash != hash)
			continue;
		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
			continue;
    ...
}

The socket's sk_hash comes from inet_ehashfn() in sk_ehashfn(), keyed by
inet_ehash_secret. The lookup uses inet6_ehashfn(), keyed by
tcp_ipv6_hash_secret.

These are two independently keyed 32-bit hashes. A collision for a given
tuple is unlikely but possible. The secrets are fixed for each boot, so a
tuple that collides once keeps colliding.

If such a collision happens, the IPv4 dst would be attached to the IPv6
skb. Then ip6_rcv_finish_core() would skip ip6_route_input(), and
ip_local_deliver() would parse the IPv6 header as IPv4. Is that the same
misparse this patch fixes for UDP?

The XFRM non-refcounted socket issue does not apply here, because
__inet6_lookup_established() takes a reference and the destructor is
sock_edemux.

Could the same family guard go into tcp_v6_early_demux() (AF_INET6) and
tcp_v4_early_demux() (AF_INET)? Otherwise, the commit message could say
that TCP relies on the hash mismatch rather than on an explicit check.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106110135.2161204-1-edumazet%40kernel.org
