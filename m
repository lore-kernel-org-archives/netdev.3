Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294797;
	b=4RxABcLFLq3PQkRuI8atadbr9kTiUm+OBCkAdZN8XHLhB7wlo5N4Gvmx03YoL96KUR02
	 ZY6Fy1XAReqwfoBm/gmdBPXFvp8vegE73xDVElpVsDeZdV+CE8PyyRqpquirxsApb8RB6
	 b/OnFEEESJeRfCq3FGLJVAFMzAMmcF00Oq1h5I0ZlswxB3vNdSKJkxkTjB8EM1xbiFUhM
	 8W+J6ftxw5y/rUAlTYays0izCdKMSEpAMZsspmR+p/nh8fFZvM77HZjpgrBOCNiJY7nL6
	 9K89drxQEXtJZ3n3qa4bkD1ItaNnQ6+6hDrskb/Rw3Mk4WnezQ4ryHUVCqVEaA5/Okg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294797;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vS6o0Juc0V0aop1XUFdMfaA1iznyLOlFe0EMq9HGeFU=;
	b=HmI7g9tBtEa5aHrAwMEgI2MkUgWga66EFssjOBqvCcWz0VTMJPv0puveW6Dsib8Ezzl7
	 wdgBGksKc5rfxl95gLBMVdFMM1xAWzxNYruLFhSzSNjGZwxStq+4yHvQerSQ3+OPyYQt1
	 tjAzagi7vO0uydORtdZrmTWD+0Ww7rhKE0/8Re/fsT1Qo+LrXNA9vFk+bServfeiPiVHB
	 HLwNDcg90WbQyLudRvZbZK9YnkZStpDinjIdssyAJcli6NzNhFJXfF5SLnWK93lwci+5l
	 wUUC8U2P7T5ygapadTK2nc+m9zrOlruy1oXEMXguT9r0QTDZ45QNnl33+j226Gn7/vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dLLsN7/6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66950606A33B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLLsN7/6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CEF1F008BC
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294797;
	bh=vS6o0Juc0V0aop1XUFdMfaA1iznyLOlFe0EMq9HGeFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dLLsN7/6rSqFDwTydKFXr19mZdybbAk+NkV7n6adBOLLAF0/9sDV56hBuILaozu9f
	 VJwf3YvQbUnA8yfRwn+VjvUEw2AIf+duD1A9WUi6bPg2wNqpFLJ3GMZQhtsYKNxA6i
	 qZ8C7ec9Z6mc0OSaEznOwS1mkEZvCTnWY+jogs8Y3LpKFYxKa45e1bMTkoQiKD8MOD
	 78OEdDVh6XfppIL4+TfFsX9V9tb/fuKVPnUCMSSh3FDIWOpUz+5TQXQUen7IT0XrJ8
	 YKS2WwLoUiVZjbgXZoUgOXUwF0FdBD40oayBfR8GS6CI+3AYYoSir6FvuPS0lu+4uU
	 HtxWPtHMncBoQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-70b875f6f1fso1276432eaf.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 23:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGZ2ijmQQHmYZY3tjDkLuHQDpnVuF11oynA1kkqxV2IsR10kSmUuMZpcg1pLUaH8LIFn8ycYWM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jtdsk+rhrmF0euOr4jtopgmA5lowVZG0yhvvHipbXQhr0d9Kz
	q6PA7z1Gzs80uA5HIfaKgqepUIkGxAHWv3O7FC1aTFT9I8E+bLm9hS0+/Td12O7hidgsFJiq2as
	AcRkudWhGTytiIKPgMeshOnJ2E1kp8FY=
X-Received: by 2002:a05:6820:1355:b0:716:d5d3:b78d with SMTP id
 006d021491bc7-718a77f16ebmr801935eaf.79.1794294796302; Mon, 09 Nov 2026
 23:13:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106110135.2161204-1-edumazet@kernel.org> <179426533453.994134.11750369259085131425@kernel.org>
In-Reply-To: <179426533453.994134.11750369259085131425@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 08:13:04 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqayAnVa81Ss7B1E5T0A3wD7w3X7jd0ZH_+zoJdL95Bgg@mail.gmail.com>
X-Gm-Features: AclHuK9G--FsiODO56tYxOZVPkAu-Zvj8Ru_wUn_U4yCfzdu8x17wurZZA0t6zk
Message-ID: <CAL4WiiqayAnVa81Ss7B1E5T0A3wD7w3X7jd0ZH_+zoJdL95Bgg@mail.gmail.com>
Subject: Re: [PATCH net] udp: do not use a cross-family sk_rx_dst in early demux
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	willemb@google.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 00:02, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says "TCP does not have the same problem",
>   but tcp_v6_early_demux() (net/ipv6/ip6_input.c) uses the same pattern=
=E2=80=A6
>
> --
>
> udp: do not use a cross-family sk_rx_dst in early demux
>
> With this patch, udp_v4_early_demux() and udp_v6_early_demux() use the
> cached sk->sk_rx_dst only when dst->ops->family matches the packet's
> family. Without the check, a dual-stack socket connected to a v4-mapped
> address can attach an IPv4 dst to an IPv6 skb, or the reverse, because
> the dst_check() callbacks can ignore the cookie.
>
> > TCP does not have the same problem: sk_ehashfn() hashes a v4-mapped
> > socket with inet_ehashfn(), while IPv6 lookups use inet6_ehashfn(),
> > so IPv6 packets do not normally find a v4-mapped TCP socket.
>
> [Severity: Medium]
> Is this statement about TCP fully accurate? tcp_v6_early_demux() in
> net/ipv6/ip6_input.c uses the same pattern this patch removes from UDP.
> It never checks the family of the cached dst:
>
> net/ipv6/ip6_input.c:tcp_v6_early_demux() {
>     ...
>                 if (sk_fullsock(sk)) {
>                         struct dst_entry *dst =3D rcu_dereference(sk->sk_=
rx_dst);
>
>                         if (dst)
>                                 dst =3D dst_check(dst, sk->sk_rx_dst_cook=
ie);
>                         if (dst &&
>                             sk->sk_rx_dst_ifindex =3D=3D skb->skb_iif)
>                                 skb_dst_set_noref(skb, dst);
>                 }
>     ...
> }
>
> A v4-mapped AF_INET6 TCP socket caches an IPv4 rtable in sk_rx_dst.
> That covers a dual-stack child accepted over IPv4 and a socket connected
> to ::ffff:a.b.c.d. ipv4_dst_check() ignores the cookie, so dst_check()
> here does not reject that rtable.
>
> Take a spoofed IPv6 segment from ::ffff:C to ::ffff:S with matching ports
> (ip6_rcv_core() now accepts it). inet6_match() would accept the
> v4-mapped socket for it. The only thing that keeps the socket out of the
> lookup is the sk_hash comparison:
>
> net/ipv6/inet6_hashtables.c:__inet6_lookup_established() {
>     ...
>         hash =3D inet6_ehashfn(net, daddr, hnum, saddr, sport);
>     ...
>                 if (sk->sk_hash !=3D hash)
>                         continue;
>                 if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif)=
)
>                         continue;
>     ...
> }
>
> The socket's sk_hash comes from inet_ehashfn() in sk_ehashfn(), keyed by
> inet_ehash_secret. The lookup uses inet6_ehashfn(), keyed by
> tcp_ipv6_hash_secret.
>
> These are two independently keyed 32-bit hashes. A collision for a given
> tuple is unlikely but possible. The secrets are fixed for each boot, so a
> tuple that collides once keeps colliding.
>
> If such a collision happens, the IPv4 dst would be attached to the IPv6
> skb. Then ip6_rcv_finish_core() would skip ip6_route_input(), and
> ip_local_deliver() would parse the IPv6 header as IPv4. Is that the same
> misparse this patch fixes for UDP?
>
> The XFRM non-refcounted socket issue does not apply here, because
> __inet6_lookup_established() takes a reference and the destructor is
> sock_edemux.
>
> Could the same family guard go into tcp_v6_early_demux() (AF_INET6) and
> tcp_v4_early_demux() (AF_INET)? Otherwise, the commit message could say
> that TCP relies on the hash mismatch rather than on an explicit check.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261106110135.2161204-1-edumazet%40kernel.org

The analysis is correct in theory, which is why the changelog says
"do not normally".

For TCP, an IPv6 lookup can only find a v4-mapped socket if
inet6_ehashfn() of the v4-mapped tuple equals inet_ehashfn() of the
IPv4 tuple. These are two independently keyed 32-bit hashes, and the
sender knows neither secret. It has no way to tell which tuple
collides, and each attempt needs its own established IPv4 connection.

UDP is different: ipv6_portaddr_hash() puts both families in the same
slot on purpose, which is what made this bug trivial to trigger.

I would merge this patch as is, thanks.
