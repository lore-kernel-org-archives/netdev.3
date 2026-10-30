Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358355;
	b=AI0qHNniRInIqztEZbju3OpPQ+bHeMzd+cuxx6zcQ1WVRuBPsEPSga5pxD+P1Nzg/DTG
	 2vpKdkwLqi4f5VaC1roiyc01MtbXoKRIPPVcaU8vC1FsI6WwXPmJ9bU6TiTge0zpDx2kL
	 ddokwu53kJ0b0LxT6gBOQOBpAUsWHJrO7p0ARJ6h31y/dwRYp9bSbxGU9dd7T/bDQX9H1
	 UObFnQQbJzcRVZvQD2XpLes911+Lj1txsoAGxqAjROA6WYsrM+GJggtG8g1bPQG9UHKGi
	 51AhXo9smP0ueYQ9HaViYlQkW945lSwCwAcCbNO5HITKlW1VkxWdmVU+2QjfP8shORQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358355;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zCm2nV5O4wlaDx56bSSyYv3tpFjUlYFnDPRRhQYENCY=;
	b=tvFVPSegP6fPG4YS84AheAC1oJBk0/FSh/FF+QjYreoVUWEte7GCFx5OjZxUB65xFd+J
	 bn6xYqNMcvbHEHaNGbuZqn3IL2QxxcTjN4SngmYTGDV1DQk5X3vP3j2gEKEpK0QqHGFXB
	 jDeaHk1kswABXg6BvqVGwu7gXo8yblJzfSSl85MyFNU8JjdUlkXuFxZ7+Hi4OUAZ1DPza
	 WqUVc5zT9btnjLOy1EPuenelhPn2MFXGuna1/8DmE90sQW/a7b9XQCTgCv/0sCO8Bchtx
	 HVg758HTVmJ/WJm9brUicog3HZEQo/u5OwkETzYPzjbMZ0kw2PIkwFSXDYDM79zcAGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cu/Uv6KU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9C606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cu/Uv6KU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5B91F0093A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358355;
	bh=zCm2nV5O4wlaDx56bSSyYv3tpFjUlYFnDPRRhQYENCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cu/Uv6KUdwyXLwmE8crIxiA/ITPP7K/e13QHBjTS871iAVf3rn5h+wMU1VYv+cFjF
	 FkkLtjWz1iaVRtaQ0f3ZmLhyexXKkzzZ096u5COAxm9CPcg6cuCHjbY6vRWLoj9mNE
	 XczLkHKg6RJJP41AfoaHmvjrH8gyA/hEv7Wc+B3AkXHDaZLiqttVEQWfBWJYFfPlyr
	 vLSa5M9YDGg+0f4SQwbww0nbsKRCRp3TgBnnnmy2LoqNGjhk4YbGRbDkFkqaFf6nVF
	 nnoNS765Q3+bTOqccEwvTqqeudbL6lT6dCDy1Z6e4My8XCFXqpTN/yb5WO12yVFiD6
	 MuUw6umStHeLg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a75a5fa32dso119778fac.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzH6ybnTyuF3LOX0CTo3aBu/YbXbQ4mW+FN2OjyvJgNMTQ90+QBmJggUnUUE4tVEMeQIT8IHJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI17TEoSN1+RK/RIjdIfPwu1Dn/J6V8ghKj9+6ryOE+OkjHawzx
	M96lLfgEKR/VoGqkroWI2cAddy+e0nEEmrmeMqXoq8V+s9rk/YTWnbvDat0v933+WhvV8glZDJi
	VK/9rcviUPXBbO1M2U8zqI5ZDR0HCmsg=
X-Received: by 2002:a05:6870:8101:b0:491:88f1:f3aa with SMTP id
 586e51a60fabf-4a9076a4e0dmr1167286fac.26.1793358354538; Fri, 30 Oct 2026
 04:05:54 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027130617.1550253-1-edumazet@kernel.org> <179321450338.3134.9348301510643981873@kernel.org>
In-Reply-To: <179321450338.3134.9348301510643981873@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 12:05:43 +0100
X-Gmail-Original-Message-ID: <CAL4WiirihJKbubcDmnvUeuDEM0dsjOgQd6yuUdzfKUPj3cQDyg@mail.gmail.com>
X-Gm-Features: AclHuK_L8nVT0i3ZS28VaWzM1pq_HNFt9aJCz0YujAXDUb2S8lO79SsajklSykc
Message-ID: <CAL4WiirihJKbubcDmnvUeuDEM0dsjOgQd6yuUdzfKUPj3cQDyg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 28 oct. 2026 =C3=A0 20:08, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch sets TCP_MAX_SND_CWND to 1U << 24 (16,777,216).
>
> --
>
> tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
>
> This patch changes the default snd_cwnd_clamp from ~0 to a finite
> TCP_MAX_SND_CWND of 2^24 packets. It also caps the locked RTAX_CWND
> metric, TCP_BPF_SNDCWND_CLAMP and TCP_BPF_IW at that value. The stated
> goal is to stop congestion control u32 arithmetic from misbehaving when
> cwnd gets very large.
>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 0265c27a5fd77..be1609cd78840 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1553,6 +1553,12 @@ static inline unsigned int tcp_packets_in_flight=
(const struct tcp_sock *tp)
> >
> >  #define TCP_INFINITE_SSTHRESH        0x7fffffff
> >
> > +/* Default and maximum snd_cwnd_clamp, in packets.
> > + * Far above any usable BDP, but low enough that congestion control
> > + * arithmetic such as 100 * cwnd in CUBIC cannot overflow a u32.
> > + */
> > +#define TCP_MAX_SND_CWND     (1U << 24)
>
> [Severity: High]
> Is 2^24 small enough for the claim in this comment? 100 * cwnd fits, but
> CUBIC has larger u32 products on cwnd:
>
> net/ipv4/tcp_cubic.c:cubictcp_recalc_ssthresh() {
>     ...
>         if (tcp_snd_cwnd(tp) < ca->last_max_cwnd && fast_convergence)
>                 ca->last_max_cwnd =3D (tcp_snd_cwnd(tp) * (BICTCP_BETA_SC=
ALE + beta))
>                         / (2 * BICTCP_BETA_SCALE);
>     ...
>         return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
> }
>
> With beta =3D 717:
>
>   cwnd * 1741 wraps once cwnd is above about 2.47M.
>   cwnd * 717 wraps once cwnd is above about 5.99M.
>
> Both points are below 2^24.
>
> At cwnd =3D 2^24, ssthresh comes out as 3,358,720 instead of 11,747,328.
> last_max_cwnd comes out as 1,679,360 instead of about 14.3M.
>
> Just above each wrap point the product is close to zero, so ssthresh
> would drop to a few thousand or to the 2U floor. The wrong Wmax then
> reaches bictcp_update(), and the comment there says that code is only
> overflow-free for cwnd below 1 million packets.
>
> Other in-tree modules have the same pattern:
>
>   dctcp_ssthresh():          cwnd * dctcp_alpha (up to 1024, also the
>                              default), wraps at 2^22
>   bictcp_recalc_ssthresh():  cwnd * 1843 and cwnd * 819
>   tcp_cdg_ssthresh():        cwnd * min(1024U, backoff_beta)
>   tcpnv_recalc_ssthresh():   cwnd * nv_loss_dec_factor (default 819)
>   tcp_roccet.c:              cwnd * beta and cwnd * (1024 + beta)
>
> DCTCP at cwnd =3D 2^24 is the clearest case:
>
>         return max(tcp_snd_cwnd(tp) - ((tcp_snd_cwnd(tp) * ca->dctcp_alph=
a) >> 11U), 2U);
>
> Here 2^24 * 1024 wraps to 0. ssthresh then equals cwnd, so the ECN
> window reduction never happens.
>
> The inputs named in the commit message can still put cwnd at the clamp
> directly. That skips any real growth in flight:
>
>   tcp_init_cwnd() returns min_t(__u32, cwnd, tp->snd_cwnd_clamp)
>   for RTAX_INITCWND
>   TCP_BPF_IW now sets min_t(u32, val, tp->snd_cwnd_clamp)
>
> Either path can set cwnd to 2^24. The next RTO or recovery then calls
> the CC ssthresh callback with that cwnd:
>
>   tcp_enter_loss()->icsk_ca_ops->ssthresh()
>   tcp_init_cwnd_reduction()->icsk_ca_ops->ssthresh()
>
> The sk_sndbuf argument in the commit message limits packets_out. These
> callbacks read snd_cwnd, not packets_out.
>
> The generic stack has a similar product as well:
>
> net/ipv4/tcp_output.c:tcp_tso_should_defer() {
>     ...
>         u32 chunk =3D min(tp->snd_wnd, tcp_snd_cwnd(tp) * tp->mss_cache);
>     ...
> }
>
> With a 1448 byte MSS, this wraps above about 2.97M packets.
>
> Would a lower bound work here, around 2^21 or less to cover multipliers
> up to 2048? The other option is widening these products to u64.

Good point, 2^24 is too big: the ssthresh() handlers multiply cwnd
by factors up to 2047 (CUBIC/BIC/ROCCET 1024 + beta), and DCTCP wraps
to zero at 2^24 with alpha =3D 1024.

I will send a v2 using 2^20 instead. This covers all in-tree
multipliers (< 2048), and also matches the "cwnd < 1 million packets"
assumption documented in CUBIC bictcp_update().

2^20 packets does not limit real flows: a peer can not advertise
more than 65535 << 14 bytes (~1GB), which is below 2^20 packets for
any MSS >=3D 1024.

I prefer this over widening each product to u64, which would touch
many CC modules and still leave bictcp_update() limits in place.

The tcp_tso_should_defer() products (cwnd * mss_cache) can overflow
with large MSS regardless of this patch, but they only affect
the TSO deferral heuristic. This can be addressed separately in net-next.

pw-bot: cr
