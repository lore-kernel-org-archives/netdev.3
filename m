Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804993;
	b=a2Kcm2sE4ZqFtf1XUZXrmvYR/JmjRxvwzi4SG5HL3B45+6KlLCb4cLjKbZdyfvs/ZkAz
	 prK25/4hrpSE5Ki8K8dkY4JEdIpSi8RA7TY9D732MZf/iFtv0XOX5/YVYI4QsMELLROll
	 y4KFWRHoCH8sVRTXvsKkHNekqC/uiQ0JIK6JEgH7PfA8KfoYS0dv+cJfKtftChwtRY4xE
	 z8wfEBalPViWnPuMOy0PEiTPhrege2nQQDMiyB1G3MZ/SIzpd3MSByHorOxzyfiglVlLn
	 tXwRdzb6FhAbgLuQwPHaJFaud5Oezi7yC93v56K+SCBPneCKoHeOmsIcTaY6obHtQMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804993;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cFsxHXe85/v7h5RQTtycXAo9hnX3kcBe7fUXrj2gfx4=;
	b=vBFFwWXAZmGwRCZmrahKBq4BXdkMtdi+KI8/aynlCfcMJEWAf+3Kq8+o+7OSW8LriAgU
	 /odhpbD8krFMybdhoQjokbIxCyDY80TOpu5htrKu809f/lzjws0XcQS66mENAoo94HgW8
	 XhhJuTe36yyvOy14RdFG+S8MslXJvk02pmKQaiorth7IczUD8ylyFTeiY/qHRO7/sHG4U
	 G6ObM1EgEwbL+1BwnXRKrkCjNLDQ5OODbJFUPYijHvg45/NiDTFz4QqUI2kgXhPjzxZ4l
	 fmko20eNDGDMlYg4yT9boeTCMM0RzgOZYf9MBdSv85ZbRxRF0pVxptOeozfStXxfUBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfcsDzqu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFB606A32D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfcsDzqu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1391F000C1
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804992;
	bh=cFsxHXe85/v7h5RQTtycXAo9hnX3kcBe7fUXrj2gfx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DfcsDzqu+S4FzxL05RUxiW12C6O9lgK7moKFrGmcF9uCO1nY5QA6TmkojfipwMP46
	 DoH5eBvIQA7Wx7cjZtUHNZVNWbFzyZB0D3lsQg7yfiBNEM9mZrVq2IqS4bz+4cY+Em
	 L2KdRD3LmzPXd/Fdd3YuqbmC4stUc6zWVLkiUDRph38ag5tQpxORfTJ5ZsKzsPgvOw
	 f7GX09s2hcX9/iBuUQ5Nauex6bZ6MCkbEQcAGC2tP3cgOSF21rVP1NtDy8Nsl6lDQV
	 BPdsQFLi9G1JZUvk+s/k3pLEollRAIYKYRrwjB0qUH73soCH1Me2E3LtLyjbQ6IWSe
	 Gy1Ydphn60Q2g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so468462fac.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzIv1rRoPR1pklW9GD7ecCjGq2v7A4uKiwN2ivlcl9m34RMfpH+2AroutFRyj3YZYMLrEDPQjU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/riUdqmnCqREyzVBnQeexqvgCjVjJO9dNpELcgICH3lWnfHv46
	T3HiEKysOggHr5j4JLd4PBV2+ZF1i0GuTkRbDHfBTpqMb5URMcQy+HJiE7GK+w1xx0Pz+qp3SbK
	Rpc9I3t7ov712xJiS5tInptOT4J3jYBA=
X-Received: by 2002:a05:6870:f113:b0:491:a2d5:ab31 with SMTP id
 586e51a60fabf-4a90764ca5fmr10771021fac.12.1793804992258; Wed, 04 Nov 2026
 07:09:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103105752.49542-3-edumazet@kernel.org> <179380083773.488856.10057167003627471575@kernel.org>
In-Reply-To: <179380083773.488856.10057167003627471575@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 16:09:40 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqwUhcLVvkcLzDcyUUvEvqffFBWLiwb760iuo+fuJ4vyQ@mail.gmail.com>
X-Gm-Features: AclHuK8skOyT40Y0SuONlcxb2OlQdL3nuEJPupGI6O1KWHIXg1XphjooR5KpWV4
Message-ID: <CAL4WiiqwUhcLVvkcLzDcyUUvEvqffFBWLiwb760iuo+fuJ4vyQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: gro: invalidate frag0 after a pull
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, willemb@google.com, steffen.klassert@secunet.com, 
	tom@herbertland.com, cenzhang@linux.microsoft.com, 
	AutonomousCodeSecurity@microsoft.com, stable@vger.kernel.org, 
	tsgatesv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 15:00, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
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
> - [Medium] The patch adds a fallback in gro_try_pull_from_frag0()
>   (net/core/gro.c:465): when frag0_len is 0 it calls `pskb_may_pull(skb,=
=E2=80=A6
>
> --
>
> net: gro: invalidate frag0 after a pull
>
> This patch adds skb_gro_frag0_invalidate(), which clears
> NAPI_GRO_CB(skb)->frag0_len. It is called before the pulls in
> skb_gro_header_slow(), skb_gro_receive_list(), udp_gro_receive_segment(),
> esp4_gro_receive() and esp6_gro_receive(). It also changes
> gro_try_pull_from_frag0() so it copies from frag0 only while frag0_len is
> not zero, and falls back to pskb_may_pull() otherwise.
>
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 1b033855a20db..49e7f64f27756 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
>
> [ ... ]
>
> > @@ -454,8 +455,14 @@ static void gro_try_pull_from_frag0(struct sk_buff=
 *skb)
> >  {
> >       int grow =3D skb_gro_offset(skb) - skb_headlen(skb);
> >
> > -     if (grow > 0)
> > +     if (grow <=3D 0)
> > +             return;
> > +
> > +     /* frag0 can only be used if no pull happened. */
> > +     if (likely(NAPI_GRO_CB(skb)->frag0_len))
> >               gro_pull_from_frag0(skb, grow);
> > +     else
> > +             pskb_may_pull(skb, skb_gro_offset(skb));
> >  }
>
> [Severity: Medium]
>
> Is it safe to ignore the return value of pskb_may_pull() here?
>
> gro_try_pull_from_frag0() still returns void. Before calling it,
> dev_gro_receive() has already incremented gro_list->count (or called
> gro_flush_oldest()). After it returns, the skb is held unconditionally:
>
> net/core/gro.c:dev_gro_receive() {
>     ...
>         if (unlikely(gro_list->count >=3D MAX_GRO_SKBS))
>                 gro_flush_oldest(gro, &gro_list->list);
>         else
>                 gro_list->count++;
>
>         /* Must be called before setting NAPI_GRO_CB(skb)->{age|last} */
>         gro_try_pull_from_frag0(skb);
>         ...
>         list_add(&skb->list, &gro_list->list);
>         ret =3D GRO_HELD;
>     ...
> }
>
> Before this patch, gro_pull_from_frag0() was the only thing done here,
> and it could not fail because frag0_len is bounded by the tailroom.
>
> One way to reach this point with frag0_len =3D=3D 0 is through
> esp4_gro_receive() and esp6_gro_receive(). With this patch they do:
>
>         skb_gro_frag0_invalidate(skb);
>         if (!pskb_pull(skb, offset))
>                 return NULL;
>
> This returns without setting NAPI_GRO_CB(skb)->flush. For an ordinary
> unfragmented IPv4 packet, inet_gro_receive() computes flush as 0, so
> dev_gro_receive() takes the GRO_HELD path.
>
> offset =3D=3D skb_gro_offset(skb), so the retry in gro_try_pull_from_frag=
0()
> is the same pull that just failed.
>
> If the held skb's linear area does not reach skb_gro_offset(), later
> packets in the same bucket would read stale tailroom bytes as headers:
>
> net/ipv4/af_inet.c:inet_gro_receive() {
>     ...
>                 iph2 =3D (struct iphdr *)(p->data + off);
>     ...
> }
>
> The same applies to ipv6_gro_receive(), udp_gro_receive() and the
> tcp_hdr(p)/udp_hdr(p) lookups.
>
> If one of these bogus headers matches and a merge happens,
> inet_gro_complete() writes tot_len and check through skb->data + nhoff.
> Those writes would go into tailroom rather than the real header, and the
> aggregated packet would keep its original single-segment tot_len.
>
> The window looks narrow. The retry can only fail for an skb that entered
> GRO with headlen =3D=3D 0 and frags[0] mapped as frag0, and that skb must
> also be either:
>
>   - cloned, with pskb_expand_head(..., GFP_ATOMIC) failing, or
>   - carrying unreadable frags while frags[0] is a normal page.
>
> No concrete in-tree source of such skbs has been identified, but they
> don't look impossible either.
>
> Could gro_try_pull_from_frag0() return a bool? On failure,
> dev_gro_receive() could undo the count change and take the normal path
> instead of holding the skb.

Yes. In v4, gro_try_pull_from_frag0() returns false if the pull fails.
dev_gro_receive() calls it before changing gro_list->count, and takes
the normal path instead of holding the skb.
