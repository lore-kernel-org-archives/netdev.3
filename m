Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785877;
	b=M1pcJuwWsdqnz8pE9j0hZB1uMWhoP1nWM2m58dAHLrVBcs1VNIH1YOExWTucbNI9Vvpz
	 /++/THvDrvKdo1vT4LGiLNLLoSbbCYdBKMINoJkaMwMNFhYtUieRLmBRG0GJJg1+j2apP
	 gt30wKN76z/KTbhBCIGnTzUyAEl2c5sQrExLggQh2KdmoYntu709s0XvB4OHXfdXllk00
	 w2gpJP3sfo9cyuuoHFPdXWFm9s73xJJALGFMW3zQJjBWQ38QW0HkLjpk8zJO/49syBij9
	 J7qPoAuz0PEltLtTcVXqxOe3SvhtrycfMhaxzn9BfyPeA82AcpiMfle4iUpKgDn3/qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785877;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oojRhALGnxSxyxmQajAogvjEsQGOsY9/BMU8rYXtxHA=;
	b=IPEk5elmlofqj4koF+BeNgrkgTjEA2VO9hUJayDnTupg3jUQ6xJ3OuzRWWnT9YDk2r3S
	 aTikaYlVJX0uPZARIowB+Jaw1ZuqIjnntIjdeU3vg2uYwrN2vBfV6oZVHRXRi8+5iZ5Kc
	 tzPFj1hXVvierV9u/xMl623HtEfYtkP6cr9U6iVZsZ8q03zElrOuegwPiBPrxLiQMpQD/
	 WKJw/4xCr5GyMcsncRsn0+lLJ5F0MmWRSsR2Iwls1bXqTT7AWhgzxNo7zddh/JP9MdycT
	 JyFXTHWbbC53W4VCicNGetTFLmWD6GPT7yCy0of1MGqCRyLUMCv2zb+Ei8USxMBJbCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNEvKN31;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD008606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNEvKN31
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627EE1F00A15
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785876;
	bh=oojRhALGnxSxyxmQajAogvjEsQGOsY9/BMU8rYXtxHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gNEvKN31QMSPR2Y/tFdlB1WbCay38cMmkGAxG8T+kCgAVdRTnq/s1XaG5JFrLoFMX
	 dTXnsU5evxZJfNlQofHA/WAs67ObYLzKigwzuIoPab23Nkblc6MjjWQIwdqf8Ijd2r
	 6EZ43ul1VuQyR869uns+JlIIQKtgmav5C+hgEqMuFG7DccDgO+OmUzZ8TXXNVlpTU5
	 qjYHiUs8gUJz6zCHqLpxXot5Hf5urVAVktCUjAcdRx2s7AfW18HgdDt9P7qBrHCFW7
	 tO11pu9mONt39IYvgcgmFSZsroW112vi3kiJsb6ys+BLk+fuLJico+S+NBYA8NRs5e
	 vITiyyJqoLt/A==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-49e08af5fd4so229943fac.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:51:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwsj4FjsQBk/1y8VLMog51pZOcJPkYWSp/u/RcvMKMLswsdEGvL5k5LBQfnxyLsmfv03Use1w4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ID4qfCypdmVL1Phzc/ko8oSUg0xj6ecG/qIbMF6nATCdg8iE+
	2LWRYhGcrrF0w2BfZaYV6gqaTP1nLZyVrEB1/6T04OCmjGMgVObH2PvYx1NMNL9G8gUC+vtK2L3
	8kvRWUOGD9cdQT3DNXoD70+60X8oluLY=
X-Received: by 2002:a05:6871:ec4a:20b0:4a9:58d3:b60c with SMTP id
 586e51a60fabf-4a958d3b7d2mr4822097fac.32.1793785875663; Wed, 04 Nov 2026
 01:51:15 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103092957.4164530-1-edumazet@kernel.org> <179378464765.488856.7246331085173485104@kernel.org>
In-Reply-To: <179378464765.488856.7246331085173485104@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 10:51:04 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiowpe6mFG2tZ3Qtqod3Rkv4V0Ed3M5V1B1Y8P1vq0kTcQ@mail.gmail.com>
X-Gm-Features: AclHuK_i8Q3E2HW_M_daroL4NRGLMWacYRtS_V3G7bXliFwkea254yA8nCoUAzo
Message-ID: <CAL4Wiiowpe6mFG2tZ3Qtqod3Rkv4V0Ed3M5V1B1Y8P1vq0kTcQ@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: bound the wmem charge of the socket
 completing a reassembly
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, 
	netdev@vger.kernel.org, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 10:30, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
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
> - [High] In net/ipv4/inet_fragment.c, inet_frag_wmem_ok() (lines 533-540)
>   reads sk->sk_wmem_alloc without any socket-wide lock or reservation=E2=
=80=A6
>
> --
>
> inet: frags: bound the wmem charge of the socket completing a reassembly
>
> This patch adds inet_frag_wmem_ok(). The new helper refuses a reassembly
> when charging the queue's truesize to the completing socket would push
> sk_wmem_alloc above 2 * sk_sndbuf + 4MB, capped at INET_FRAG_MAX_TRUESIZE=
.
> The aim is to keep sk_wmem_alloc from saturating while several reassemble=
d
> skbs owned by the same socket are alive at the same time.
>
> Closes: https://lore.kernel.org/netdev/24feda7d-ae49-45af-9596-2cc5f149f2=
8e@redhat.com/
>
> > diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> > index 0b8d22ffafca6..c11d7e976dfa5 100644
> > --- a/net/ipv4/inet_fragment.c
> > +++ b/net/ipv4/inet_fragment.c
>
> [ ... ]
>
> > @@ -519,6 +520,25 @@ int inet_frag_queue_insert(struct inet_frag_queue =
*q, struct sk_buff *skb,
> >  }
> >  EXPORT_SYMBOL(inet_frag_queue_insert);
> >
> > +/* When a socket owned fragment completes a queue, the truesize of all
> > + * other fragments is charged to its sk_wmem_alloc, although they were
> > + * orphaned when queued and possibly sent by someone else.
> > + * Bound this like ip_append_data() bounds the memory a socket can
> > + * allocate (2 * sk_sndbuf), plus slack for fragments inflated by a
> > + * refragmentation using a small MTU. Otherwise, several reassembled s=
kbs
> > + * alive at the same time can saturate sk_wmem_alloc, and leak the soc=
ket.
> > + */
> > +#define INET_FRAG_WMEM_SLACK SZ_4M
> > +
> > +static bool inet_frag_wmem_ok(const struct inet_frag_queue *q,
> > +                           const struct sock *sk)
> > +{
> > +     u64 limit =3D 2ULL * READ_ONCE(sk->sk_sndbuf) + INET_FRAG_WMEM_SL=
ACK;
> > +     u64 wmem =3D (u64)refcount_read(&sk->sk_wmem_alloc) + q->truesize=
;
> > +
> > +     return wmem <=3D min_t(u64, limit, INET_FRAG_MAX_TRUESIZE);
> > +}
>
> [Severity: High]
> Is this check safe when other reassemblies charge the same socket at the
> same time?
>
> inet_frag_wmem_ok() reads sk_wmem_alloc without a lock. The charge it
> approves is applied later, in two steps:
>
> inet_frag_reasm_prepare()
>     refcount_add(ts_delta, &sk->sk_wmem_alloc);
>
> inet_frag_reasm_finish()
>     /* after the loop over every fragment */
>     refcount_add(sum_truesize - head_truesize, &sk->sk_wmem_alloc);
>
> The only lock held across this is the per-queue lock, for example
> spin_lock(&qp->q.lock) in ip_defrag(). The IPv6, nf_conntrack and 6lowpan
> callers follow the same pattern. That lock serializes one queue, not all
> the queues charging the same socket.
>
> Suppose several CPUs complete different queues for the same socket. Can
> they all read the same sk_wmem_alloc value W, all see
> W + q->truesize <=3D limit, and then all add their charge?
>
> The limit is at most INET_FRAG_MAX_TRUESIZE (INT_MAX / 2). So three such
> completions racing would seem to be enough to push sk_wmem_alloc past
> INT_MAX. That is the saturation and socket leak the commit message
> describes.
>
> One possible path from an unprivileged user/net namespace:
>
> tun_chr_open() sets tfile->sk.sk_sndbuf =3D INT_MAX, so the limit works o=
ut
> to min(2 * INT_MAX + 4M, INT_MAX / 2) =3D INT_MAX / 2.
>
> tun_build_skb() and the sock_alloc_send_pskb() path leave the skbs owned
> by the tun socket via skb_set_owner_w(), so is_skb_wmem() is true. These
> skbs are not orphaned before tc ingress, and tun_get_user() takes no
> per-write lock outside the napi_frags mode.
>
> Add clsact plus act_ct on the tun device and raise ipfrag_high_thresh.
> Then several threads writing the final fragments of different datagrams
> to the same tun fd would each reach this path on their own CPU, each
> under a different q->lock:
>
> netif_receive_skb()
>   tcf_ct_handle_fragments()
>     nf_ct_handle_fragments()
>       ip_defrag()
>         inet_frag_reasm_prepare()
>           inet_frag_wmem_ok()
>
> The window between the check and the second refcount_add() covers
> skb_clone(), skb_morph(), skb_unclone() and the whole fragment loop in
> inet_frag_reasm_finish().
>
> Would this need an atomic reservation on sk_wmem_alloc instead? For
> example, add the charge first and then recheck and roll back, or use a
> cmpxchg loop.

Right, and tun sockets default to sk_sndbuf =3D INT_MAX, so the limit is
INT_MAX/2 there.

I will send v2 with an atomic reservation (cmpxchg) in
inet_frag_reasm_prepare().

pw-bot: cr
