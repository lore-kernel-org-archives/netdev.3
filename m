Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4F436BF4
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460474; cv=pass; b=oLvwaBZIrfIjoLynudj6aKnnaYzSOgUhSdcPfZpxqbMZd92v1T23S2NIIawXVtbbq+53h39GG89oZY/ddfxkH9Fa6upxupycPu5q2SXRyrS2zUuoj0k1AkN6mHGMnGBKIXOHQEgDpt5GEHM/IEGO2GNuLQgWvHZu+JQmyRW1RC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460474; c=relaxed/simple;
	bh=JSY7FjPX3z5BPlaii9O02tEGU6YcZFqUm/z+a9q3NFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld5DvqMSID4dI8JKG85HfbGgHO11g9JkW6682U2q791PM31h2+blUZK8GXKgttn6ZM9nReI9ivjOr1mFbi2kBL3QfqqiZVNoegWY/5P2KXmJuMvQNqNy44SQuBkhKQ4cTWGpDcIy8pfKqeWPP1QY20cJobJT/nI+IaaZWaRcwUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzjFhXOk; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzjFhXOk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d05d51553so36608025e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 04:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791460471; cv=none;
        d=google.com; s=arc-20260327;
        b=rjBtfsJ7sJzcjjVcUe4Tr+7YhOUVvurVUen++rL+ElpYnTMDHXTvEuCQO2w7zqh1Di
         VgZCihfnp++totqeY0GI59Jt500pqKBa/gM244jy5N08gU8nj2kN4dXceduI+bR3dLYp
         vDdjpGVEGZkqxYAjdyRJbajaUPEvwPaWNOiMoFt9l4ynywbz8hjvLdXXDa7bKnzTXVmF
         82KxNPEvYAZ5j2BVyHc0LPR9KaY2zFexxRWtasvi1HlDWethQRF4Sz5iRIRbYcnwchF0
         i7y+gfvxCIdsnd9zyqrYBpdAfepeT3+v8MP3cuLRu7fbQ5W81D4cP0rIjyWqJJ91Yoak
         JNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hbwotZ9+3Jxb1MnRiz1KrC/3p1ppRlaHEScVsaHdM/4=;
        fh=yKd3z+YmIq6RCdGidYdIDpPl8234WzVfewgxzEAOFOU=;
        b=g3yfPTEr0BPSI7GNW5u8xLZohstD+3FEkgIGuxZAaBlXu1T0ZRtUJekxr8qb3kFiEJ
         IvqqfXntoeJJArGPrp7/ncEiVdTlaTwsA4mzc74M4x63vxsO5BIzrVieRzSEj5NJlNwv
         AR43SAqD0ID7AophZ0gJIlTOTSHZXibBvqfqN8BFDabg3eWGHMs9b6cm/ROsYbmzB8DC
         BJUTYEDk1PXJ6nmpv1SMzGaP7sUG3iHxpDk0z9EAym6RILTIkb4+TlfZpMrv7LY615oJ
         a4vpJoN3xtY5VecUAfmbkdxN4jGK7+75WBzw+aeVmK10OPLj6L5ILO3PX+fkEq2vWKzR
         D1fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791460471; x=1792065271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hbwotZ9+3Jxb1MnRiz1KrC/3p1ppRlaHEScVsaHdM/4=;
        b=WzjFhXOkCuAbnHqvdwdy8evRA0lkVS5y/5G6adQ89IL2bH4Jox05QkYbYfdLVdGX1O
         aVvcAfDFbsJaZCZ1SA0t+w/8ZyVFKPK/mf9NdCJoSkOlteBfUgnIfc9hSCGEnFbR4TuV
         vW2yswrEVzSe2m3CZU8HhkoBNjOek0B7v1X5Zo3o5c8uczVlrJWClYJgREEZjB099Z5g
         nQOOvMo+JaOAvtffDDWNG/vW7W4JAy96560yWr3uUmUOC7dFVzRo3sXsXaICWkSu/42f
         MLnh8TBZaopfOeKGVAeZN49sg2L2M0IUfYgYh9jMsMTduiZtAzrOnhu0bdguJ2O4uFXe
         6o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791460471; x=1792065271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbwotZ9+3Jxb1MnRiz1KrC/3p1ppRlaHEScVsaHdM/4=;
        b=sbj7kXzqzc01Wlv4TGOuNyT3tP5kgOBPHNaP/f+F6V/ifoY3vqDruaxs0zU5NHhaJW
         78+jtLUNOiXmG78b18wtVFaNRZ4IRQ6luXEj+bS1uCBCrEqHXHFQ6VXMB5umPO+cfA1I
         fcaDcHb4Sh3gOaGV4h2goCV+7/4nBm1pcecMRTfIlMQ6pN/n+gwMov2Mj+RH6JBlSWYv
         p/UOyKtex09Xuogz5EBwNWsLSyqSw5i+8jda/VyILgnK2Tlm01SP/TvKTTUfgGb4i4+F
         n7RJ4/akeAr68PnUQORXIQb/lSVPYUB2Uw2b6HtcsVlmB+wQrhEojvJo50lS5/AGSQ9Y
         i2ew==
X-Forwarded-Encrypted: i=1; AKwUvBwVcxEPd1XFv5u8+Hg+ysrPMAQaxrHYsLQbrkkjJQbof3r8XxkwonyGAT8BsRcb9erZ3PCBi6E=@vger.kernel.org
X-Gm-Message-State: AFuF++mCRsOQRFBC/LtkiiHzujDzoP8kwFoGzWICYs9FJF6NEsXZfqE4
	cz0K+cV25gaZYpft4bpn6EcQ7Ctx85ltRcwXbkQTED8YI8fibum9MB4hZma23LIQaCVdtgRrEnA
	aAJlOnvJuBNUBuh9DA6AnKReTtuhXvwg=
X-Gm-Gg: AYBFou3n4+TyDYNRxTpqeHaSCeFj/kdQqBLDssKl7Dde8gk0CKAdN97e+Ggycw9RCpe
	NPzDVIhMMjyieQ23e8a0SHIMKgwGS8+9VrShlYJ+A4WCGbHs0qmFyUeWKuMhkl8EdaHAoZOBNIl
	CS5MBblY84SU25Uq6DQ+9nccrFxpoMA12wUy7zHjdC+Ozxsz04RecMSagcEzk9uFTMTCoKjV+RQ
	QXGb4M1xkNyrrB908SdQ8qYJ8Lp4FkbybFXuHLWDcnUs67Cgg872m3EOvoV8MWk+0BvQKZf3bFs
	G+nS1V8ovXni05Mebt6OrZs/t3eLqzTWZ8G4QJbl4u4i23chr6Db92Jo86B1xFo=
X-Received: by 2002:a05:600c:3ba2:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-4a18043dee1mr109269585e9.7.1791460470659; Thu, 08 Oct 2026
 04:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008100423.1256884-1-theodorlarionov@gmail.com> <CAL4WiiqDffWyo7+gbffB2PYuKAbjboK7D=JJD+z=5J5MX=9Y3Q@mail.gmail.com>
In-Reply-To: <CAL4WiiqDffWyo7+gbffB2PYuKAbjboK7D=JJD+z=5J5MX=9Y3Q@mail.gmail.com>
From: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>
Date: Thu, 8 Oct 2026 14:54:13 +0300
X-Gm-Features: AclHuK8EBP8sBxwCAHL7G9F-97FidCR-ex3gbgPZwUHVed67BeOk-y7sotT9Mgw
Message-ID: <CAEZyMPCUQvQ43P5sGTC_moe5boDirjcBS0E+-eTQ9dBBW8w_Qw@mail.gmail.com>
Subject: Re: [PATCH net] net: use the full socket in sk_mc_loop()
To: Eric Dumazet <edumazet@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, kuniyu@google.com, pabeni@redhat.com, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> (Was it a public syzbot report ?)

No, this one is from a syzkaller-based fuzzer extended to target nftables.
The fuzzer reached it through an nft "dup" rule in prerouting, which
re-injects the SYN over loopback with its dst already attached, so the
martian check never sees the multicast source.

A raw IP_HDRINCL socket sending a SYN from 224.0.0.1 to an address on
a dummy device also reaches it, without nft. That is the repro in v2.

v2 with your inet_csk_route_req() check, the changelog, the trimmed
splat and the repro is here:
https://lore.kernel.org/netdev/20261008114942.1376889-1-theodorlarionov@gma=
il.com/

Thanks for the review,
Theodor

On Thu, Oct 8, 2026 at 2:23=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> Le jeu. 8 oct. 2026 =C3=A0 12:04, Theodor Arsenij Larionov Trichkine
> <theodorlarionov@gmail.com> a =C3=A9crit :
> >
> > tcp_make_synack() sets skb->sk of a SYN-ACK to the request socket.
> > If the SYN-ACK destination is multicast, ip_mc_output() calls
> > sk_mc_loop() on it, and inet_test_bit(MC_LOOP, sk) reads inet_flags,
> > which is past the end of the smaller request_sock object.
> >
> > KASAN reports a slab-out-of-bounds (or slab-use-after-free) read in
> > sk_mc_loop() from tcp_v4_send_synack() when a SYN with a multicast
> > source address reaches a listener.
> >
>
> How does such a SYN reach a listener ?
>
> ip_route_input_slow() rejects a multicast saddr as a martian source,
> so this can not come from the wire.
>
> I guess this needs a local sender : raw socket with IP_HDRINCL, and
> the packet going through loopback, where the dst is kept
> (skb_dst_force() in loopback_xmit()), so that ip_rcv_finish_core()
> skips ip_route_input_noref().
>
> Also the SYNACK route only uses ip_mc_output() if RTCF_LOCAL is set
> and the output device is not loopback, so the SYN must target an
> address of a non loopback device, and the source must be a group
> joined on this device.
>
> Please describe this in the changelog, and include the (trimmed)
> KASAN splat, and a repro if you have one.
>
> (Was it a public syzbot report ?)
>
> > Map the socket to the full socket before reading its flags.
> >
> > Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets in=
stead of listener")
> > Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmai=
l.com>
> > ---
> >  net/core/sock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index e8551df8330f..1302c1e848b2 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -769,6 +769,7 @@ bool sk_mc_loop(const struct sock *sk)
> >  {
> >         if (dev_recursion_level())
> >                 return false;
> > +       sk =3D sk_const_to_full_sk(sk);
> >         if (!sk)
> >                 return true;
> >         /* IPV6_ADDRFORM can change sk->sk_family under us. */
> >
>
> This only addresses the out-of-bounds read, masking the root cause.
>
> We still answer a SYN with a multicast source. With this patch the
> SYNACK is looped back depending on the listener MC_LOOP setting,
> and syncookie SYNACK (skb->sk =3D=3D NULL) were already sent.
>
> tcp_v4_conn_request() only looks at the input route flags, ie the
> destination of the SYN. tcp_v4_connect() refuses RTCF_MULTICAST and
> RTCF_BROADCAST routes, I think we want the same check on the route
> used for the SYNACK.
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 6a30f11384547e6adaeff13a005c7ce1d316a602..aa928015cd143234d3d0c72e2=
b607d8347f73269
> 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -779,6 +779,9 @@ struct dst_entry *inet_csk_route_req(const struct soc=
k *sk,
>                 goto no_route;
>         if (opt && opt->opt.is_strictroute && rt->rt_uses_gateway)
>                 goto route_err;
> +       /* Never send a SYNACK to a broadcast or multicast destination. *=
/
> +       if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
> +               goto route_err;
>         rcu_read_unlock();
>         return &rt->dst;
>
> pw-bot: cr
