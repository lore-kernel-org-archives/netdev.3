Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254127;
	b=bFLJaTgNV5N25cSVfBbwwjzoI3IDcsAmbOTyo953TWCfPghAe1emBayBgHUJuUE+PNfQ
	 M3MFVqxyWrbGun1nuxkZfcFQ8VgsCy0mtnZqBumz/kEF0pATycrXKmrBKoe7rNEk+ZYpi
	 D8KitKqrMALNZf0DB+ow8ADqpAaKuaJFYYGOdW9EEd3tNFUauhrdpfW6fiWa5fBypVqG1
	 k9BygrdLn9PHRr4fGDuvXTG7GBrSb3SLeo8NpX4YzRFmMmZcr7KtyKrfk/0YtvPA8wxJ9
	 zwBdG6qOAfmo0Z8ACcPoObW1ALyQPe5ar/Ng+g5ayV+FzEGfHrUQnh8BrLZZTLrA6hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254127;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y2XNmKanTGTkW27e2r5d5GXVy0nZhgqPRVdw1F7k67A=;
	b=qH4pWNTMvN0PBVE70E8zUxBagccWRs6LZF07Up0S8EIFquFzQiQN0L8CNvC4FGjkbdH9
	 Fm4NJTXGuNDcXoOEdZp1LKn7+Og9osvByuXgI2cHAPP6b1RI1jQuR/qo38K88Crb/ilyV
	 XHjohzlYyqqVsLmO/usfpnOJKc6wqMwnXJaL7w3hNc1Oex7mWUTIcKsiYxzVp5ZBwr0oQ
	 CYbMiJW/Pzq2xMnvD341AGGLimsoLTZJw7tEQKxEjUhwH+RecpNr+pMEfpmyKT1DQ0T5Z
	 wPYCws2OwYPVN57GLKiziib1UqS3GiCAPHsD8zJjmmePcLUuet7Jrk9k/VmREzsPY8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmSyFLWH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64E606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmSyFLWH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511001F01825
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254126;
	bh=y2XNmKanTGTkW27e2r5d5GXVy0nZhgqPRVdw1F7k67A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nmSyFLWHNTvjCZV8/Cpdmeua+RYItxgnSSkmZoE/zhLIFt0AEBQGZXcaCYoRiideG
	 2T4z6dyctpmnqYLTB9SDvNG8cPFpGfBMLM8p9EXceKXAlIi8LSmwNUu7/3xFq62y+7
	 hQL/xIfprQP5ybmQHK6kF6owOggOMto4w5laZiv61P1uhvksarCNtR1GYWQZBrgdhC
	 hFcrm+WeCNQEjZqJenxTVJZ/TvBbhWr1it9kJT8TiztuXdnYhL8q3SWycmVMFqXrkv
	 sgfPUjSfNqcNTzWuhdvAK+K0qHyPtRqQ/VqSb8WPEwi79elAz8TW+7LH2cY4HxuI+p
	 8kos4tEt8rZNA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4a6fb4040cfso596659fac.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBztVrWU1pjkPBaTGunMk42fKpcsRptTxFU3N8700n0DuVeX4SDUPyuilfjK5eZZ601xpzPlLaA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYLRdRHWps5s9a9S9OaffyNeIbBvfoqjVpxW14kDgzQiKcIS9D
	fbtAUqpywbv2X48KII0CPkHSKHg31nnKvq5KRB/AUa7pug+KJ1yRlq7dOaQxIdyKCIdDDG5/wxY
	TnCWya730CS98YN4/WDtZ45RizOR3F1s=
X-Received: by 2002:a05:6870:1714:b0:494:9c66:77a0 with SMTP id
 586e51a60fabf-4a8bb48cd97mr3242621fac.34.1793254125006; Wed, 28 Oct 2026
 23:08:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028171350.2205175-1-edumazet@kernel.org> <willemdebruijn.kernel.207a67bdeedc5@gmail.com>
In-Reply-To: <willemdebruijn.kernel.207a67bdeedc5@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 29 Oct 2026 07:08:34 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqgTTAD_j_Djkec1RJj_wT4bE2V2=Wrk+a=FJ34cyA0vQ@mail.gmail.com>
X-Gm-Features: AclHuK9NRTr0SjCkbISMZE8VhnOeq0ZwYH4TjrWlZCPMVu3Ithpp6wBLvVJSXJM
Message-ID: <CAL4WiiqgTTAD_j_Djkec1RJj_wT4bE2V2=Wrk+a=FJ34cyA0vQ@mail.gmail.com>
Subject: Re: [PATCH net] gro: do not GRO GSO packets with inconsistent payload
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 29 oct. 2026 =C3=A0 00:33, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> a =C3=A9crit :
>
> Eric Dumazet wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > tcp_gro_receive() excludes empty non-GSO packets with the unsigned
> > len - 1 check, but its GSO branch only checks that gso_size matches
> > the held packet's MSS. A trusted TCP GSO skb can reach GRO again with
> > no payload after TC pedit increases its TCP data offset.
> >
> > If the skb is fully linear, skb_gro_receive() then enters its fragment
> > transfer path with nr_frags =3D=3D 0. The do-while loop copies skb_frag=
_t
> > entries backwards beyond both fragment arrays. An unprivileged process
> > using its own user and network namespaces can trigger a KASAN
> > slab-out-of-bounds write and panic through veth, pedit and GRE.
> >
> > More generally, the payload of such a packet can be shrunk to any
> > value, making it inconsistent with its gso_segs, and a GSO packet
> > with gso_segs =3D=3D 0 contributes no segment to the GRO packet.
> >
> > Do not aggregate GSO packets with gso_segs =3D=3D 0, and require the
> > payload of GSO packets to be consistent with gso_segs and gso_size,
> > the last segment being allowed to be short. This rejects the empty
> > skb before either TCP merge helper, and covers both IPv4 and IPv6.
> >
> > Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack"=
)
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > [edumazet: check payload against gso_segs, refuse gso_segs =3D=3D 0]
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > ---
> >  net/core/gro.c         |  5 +++--
> >  net/ipv4/tcp_offload.c | 12 +++++++++---
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index ff828a3dce3ca649e149a840bd6e3dfd9ddaf0c4..1b033855a20db6b8b996179=
f0b81e38393d3864a 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
> > @@ -513,9 +513,10 @@ static enum gro_result dev_gro_receive(struct gro_=
node *gro,
> >       NAPI_GRO_CB(skb)->count =3D 1;
> >       if (unlikely(skb_is_gso(skb))) {
> >               NAPI_GRO_CB(skb)->count =3D skb_shinfo(skb)->gso_segs;
> > -             /* Only support TCP and non DODGY users. */
> > +             /* Only support TCP and non DODGY users, with a sane gso_=
segs. */
> >               if (!skb_is_gso_tcp(skb) ||
> > -                 (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
> > +                 (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) ||
> > +                 !NAPI_GRO_CB(skb)->count)
>
> Or make tc_pedit set SKB_GSO_DODGY? BPF already does.
>
> In pedit_l4_skb_offset and pedit_l4_skb_offset.

Good idea, this would also make sure gso_segs is recomputed if
such packets are later segmented.

I would still keep the !count check: ixgbe and libwx RSC packets reach
GRO with gso_segs =3D=3D 0, and the payload check in tcp_gro_receive()
relies on count being non zero.

pedit is also not the only way to change the TCP header of a GSO
packet (nft payload on older kernels, NFQUEUE with
NFQA_CFG_F_GSO, bpf_skb_store_bytes()), so I prefer GRO to stay
robust anyway.

pedit can be changed later in net-next to set SKB_GSO_DODGY on
GSO packets it modifies. Note this needs skb_unclone(), which can
fail. pedit does not drop packets on allocation errors today, so
it would probably leave the packet unmarked, another reason for
GRO to not trust these packets.

Thanks.
