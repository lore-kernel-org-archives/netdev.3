Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364950;
	b=keo9YH/jiEAIbNECm4HyL/z8bt60LTcqEeO5Sa/uN+xrIuulSvJH7KrD+1M4lq4SlTPt
	 gOleUP6cnXR3Mmuz71vKBQPAVVGkOF4048pNWu8kKs5J8qWKSNgmNUrsZyzvYWHFANWQp
	 ssz2S6+OV/CwRT3o6P9V/egllMXLRXgz/arB6iCcg8Mhn4M7FMDFsr4O610mqApleYod9
	 JbXK/wVfMTw3NnUPfPvtcL2xhZsuMhEms6Rpld5zp7TO3ZUUMg074jx4S4rLi9LHhRXlN
	 lXkAt/syYId1fkVpVIQPubeWDBAkej1z48WFzWBJlSPYmmOe3D55hgscnCY2mOKLIvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364950;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ON7QinVc902aeVEzYzz8+w/vmPY5VyhJWl7QR/N4vOs=;
	b=G98hnPeenNj8a9PSCecufZhJDqDmR/3yahQJqjMJDGCaCGjPxnmX3YC26NWsgh+PS+nV
	 5wtEyE518AslThTVdA1pIgFsysLZNhbTZf6qsnioAeOkZgK16gX0qmP00R3onB4a7IfGn
	 4qS3OwUpuW9XiKb3XthJGQPNmCZNCmUCN0wz04PO9WkoctLBpKCD+qpJvBWr/YV0Shyel
	 ux5wPjsJDzYoXMdlEm/i32mJMzIT9WNpKMQqRmqZ0u9/FvzUBXAqVJD3JfS9MiUDciA/O
	 Oq+y3xBDgn5t5BDBS/50i0UEU0/FMWl6zyf+KdtdnU5LmXu+wfIFip6zmLBSzm7/xuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMPesgJa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF63606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMPesgJa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9062E1F00A17
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793364949;
	bh=ON7QinVc902aeVEzYzz8+w/vmPY5VyhJWl7QR/N4vOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eMPesgJapObLCKdEIZmgx7tvtfNSRus7nxool2QTdCUZsvS/vaZooIXgIoVZr9O3k
	 MZvtWZ1CdgxELoz2cygvgGxq5uSq8hCfy4YbQ61E8E44FBYK1UtezOjLEwRN75aC0q
	 lUUXry1xRLov8VKMl4LE7no5rT+0quBTn67/bU6o65rFY8pPoI5vLT4PCslfU4YLQz
	 JMj1rJnDzfb/e/A96+1sOQGi3BQk4JlVEoGUotx2jY0sSm6VJE12OJi/ManTrySBgk
	 NAM47O2IKIALEoWthrolu84PelasWLpenwRCbkhsLyt28MFbABXDjL7Z8xGthiSNRx
	 2ZAFH2GV4g5+A==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-475920b9ca2so202862fac.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:55:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByI/lO3s+XUniyn2UFz9DVecXi7C4lfjO7sjfUbDf7PHv+u9Zh62mzvAjrfu79dA+h1aSjBJ50=@vger.kernel.org
X-Gm-Message-State: AFq9FYJk4H8FeDTl2yV6fty4GhS0n49qF29xUipdu5+R+W4+9/iQVnOO
	Td+EcQ7BFz2FnQzyj7Ewo9Flg5IHCWqco3c+Wh5NucjD3IOvqaj93/V9zrFXb0IiTycAMsDEpWx
	2prLc0YTjEFRml+e/v905wM6Mnw5xJKk=
X-Received: by 2002:a05:6870:288f:b0:494:5ad9:dd0e with SMTP id
 586e51a60fabf-4a90729a87fmr1406350fac.3.1793364948879; Fri, 30 Oct 2026
 05:55:48 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028141325.2103814-3-edumazet@kernel.org> <179328332931.3134.13112846034720235073@kernel.org>
In-Reply-To: <179328332931.3134.13112846034720235073@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 13:55:34 +0100
X-Gmail-Original-Message-ID: <CAL4Wiirfu-b2ogscXjs4-=GPmsyyF00M2d-4Tow6+BMWnzh7WA@mail.gmail.com>
X-Gm-Features: AclHuK_NCk1dB0NJanXcEUc6Zsry3CyosWh6vY3zvQFK7NcLi5UeabK6B6qexcQ
Message-ID: <CAL4Wiirfu-b2ogscXjs4-=GPmsyyF00M2d-4Tow6+BMWnzh7WA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: gro: invalidate frag0 after a pull
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, steffen.klassert@secunet.com, 
	AutonomousCodeSecurity@microsoft.com, netdev@vger.kernel.org, 
	tsgatesv@gmail.com, cenzhang@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 15:15, <netdev-bot+sashiko@kernel.org> a =C3=A9=
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
> - [High] skb_gro_header_slow() (include/net/gro.h:172-180) calls
>   skb_gro_frag0_invalidate() only after pskb_may_pull() succeeds.
>
> --
>
> net: gro: invalidate frag0 after a pull
>
> The commit adds skb_gro_frag0_invalidate(), which clears
> NAPI_GRO_CB(skb)->frag0_len. It is called after the pulls in
> skb_gro_header_slow(), skb_gro_receive_list(), udp_gro_receive_segment(),
> esp4_gro_receive() and esp6_gro_receive(). The goal is to stop later
> skb_gro_header() and skb_gro_network_header() calls from using a frag0
> that points into a released page fragment or a freed skb->head.
>
> > diff --git a/include/net/gro.h b/include/net/gro.h
> > index b560e866683b0..78373e9caf68b 100644
> > --- a/include/net/gro.h
> > +++ b/include/net/gro.h
> > @@ -160,12 +160,22 @@ static inline bool skb_gro_may_pull(const struct =
sk_buff *skb,
> >       return likely(hlen <=3D NAPI_GRO_CB(skb)->frag0_len);
> >  }
> >
> > +/* A pull can release the page fragment frag0 points to, or reallocate
> > + * skb->head. Make sure later skb_gro_header() and skb_gro_network_hea=
der()
> > + * calls no longer use frag0.
> > + */
> > +static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
> > +{
> > +     NAPI_GRO_CB(skb)->frag0_len =3D 0;
> > +}
> > +
> >  static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned =
int hlen,
> >                                       unsigned int offset)
> >  {
> >       if (!pskb_may_pull(skb, hlen))
> >               return NULL;
> >
> > +     skb_gro_frag0_invalidate(skb);
>
> [Severity: High]
> Should frag0 also be invalidated when pskb_may_pull() fails?

Right.

Only the linear case is exposed: skb_gro_reset_offset() sets
frag0 to skb->data when skb_headlen() is not zero. Page fragments are
only released after the last failure point in __pskb_pull_tail(),
so a frag0 pointing to frags[0] stays valid on failure.

>
> pskb_may_pull() can fail after it has already reallocated skb->head. In
> __pskb_pull_tail(), pskb_expand_head() runs first, and the frag_list
> handling after it can still return NULL:
>
> net/core/skbuff.c:__pskb_pull_tail() {
>     ...
>         if (eat > 0 || skb_cloned(skb)) {
>                 if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
>                                      GFP_ATOMIC))
>                         return NULL;
>         }
>     ...
>                                 if (skb_shared(list)) {
>                                         /* Sucks! We need to fork list. :=
-( */
>                                         clone =3D skb_clone(list, GFP_ATO=
MIC);
>                                         if (!clone)
>                                                 return NULL;
>     ...
>                                 if (!pskb_pull(list, eat)) {
>                                         kfree_skb(clone);
>                                         return NULL;
>                                 }
>     ...
> }
>
> The kerneldoc for that function says the skb does not change on failure.
> That doesn't hold once pskb_expand_head() has freed the old head.
>
> If that happens, the early return NULL here skips
> skb_gro_frag0_invalidate(). NAPI_GRO_CB(skb)->frag0 then still points
> into the freed head, and frag0_len keeps the old headlen.
>
> The outer handlers keep running after the inner pull fails. With VXLAN
> RCO and VXLAN_F_REMCSUM_NOPARTIAL, for example:
>
> vxlan_gro_receive()
>   skb_gro_remcsum_process()      /* frag0 fast path, sets grc->delta */
>   eth_gro_receive() / inet_gro_receive() / udp_gro_receive_segment()
>     skb_gro_header_slow()
>       pskb_may_pull()            /* fails after pskb_expand_head() */
>   skb_gro_flush_final_remcsum()
>     skb_gro_remcsum_cleanup()
>
> include/net/gro.h:skb_gro_remcsum_cleanup() {
>     ...
>         size_t plen =3D grc->offset + sizeof(u16);
>     ...
>         ptr =3D skb_gro_header(skb, plen, grc->offset);
>         if (!ptr)
>                 return;
>
>         remcsum_unadjust((__sum16 *)ptr, grc->delta);
> }
>
> plen falls inside the range that the remcsum fast path already checked,
> so it is no larger than the stale frag0_len. Would skb_gro_header() then
> return the stale frag0, so that remcsum_unadjust() writes 2 bytes into
> the freed head? gue_gro_receive() in net/ipv4/fou_core.c also calls
> this cleanup helper after its inner handlers.
>
> The new calls in skb_gro_receive_list() and udp_gro_receive_segment()
> have the same order, invalidating only when pskb_may_pull() succeeds.
> udp_gro_receive_segment() can run as the inner UDP handler under VXLAN.
>
> The helper before bd56a29c7a4e also invalidated only on success. Still,
> the commit message describes exactly this case: a stale frag0 after
> pskb_expand_head(), followed by the 2-byte write in
> skb_gro_remcsum_cleanup().
>
> Could these sites invalidate frag0 before calling pskb_may_pull(), or on
> both outcomes?

Yes, v2 calls skb_gro_frag0_invalidate() before the pull in all five
places (skb_gro_header_slow(), skb_gro_receive_list(),
udp_gro_receive_segment(), esp4_gro_receive() and esp6_gro_receive()).

Clearing frag0_len only forces later accesses to use the slow path,
so doing it when the pull fails is harmless.
