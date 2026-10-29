Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283342;
	b=fd44Z5VpK6EG5hVK93C0qrKEJyn26iDvFYhiRBBLaTpjVVOL8SnX+tOurqyBkdvqr3Rs
	 5Nfl3eyOjYXrMRfKZkfg7IpE1gNqd49OfoQBtjYZCOv/Lkpiz/H72+PGZYTAmr1ssQqbK
	 ATUnAdNMg/nHuggA7nLfNCgHOhH93QlTc5VX2mfBN11bwcwjSNgzeqPe5ptRDvDigLphn
	 M03QRu5kYg3g6bw/UyrHH+mFJrTheZL5AQogiBdtbp+W9AxYxLVZ5smL/3Rk7CVGlVZ9A
	 sLfUPSzHLdWioGoKEvCgLNJ4PRNBhIjR6sU+5N+fKBCcWavaQmouXDq2vRQNxO0mCLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YenbS62NAlWG6owZ+KD+JytwJQD+4kiAv8kfExfGsRY=;
	b=VDZcjoob80Wzeypk6Q+V23mF1OEYx3f5MM2FzDALUaF6fLwDYHSI3fvsbyt9VWLqXHdX
	 H7nb5ldEslOxiX//5v5KRQQnVOpDmPf/uIpHDLrYqyrmfRnYUQfSUv0CJiS/ckWopUVrH
	 6a8CGSan+weQ/U5EG6G6QeouiDO3zZwrHJiPDgUXiaN8ooRMIhF4fI/53sUp/CON3O5HR
	 kKCf2WqpNPR+ZKH8DTY556fqCpkkwjWsK8713hgcJoJtaI4Rl8ZwUtg0lrC9bhF1fU6S0
	 jCjaw89rZTt9siLbBJqZMPn/pOCTdd0e8s0EZhf/N1zJUDBwfRAWzvtgc+oV1EKA2ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFk4WNJo;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8F606A32C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E8F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFk4WNJo
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so774308137.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283341; x=1793888141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YenbS62NAlWG6owZ+KD+JytwJQD+4kiAv8kfExfGsRY=;
        b=QFk4WNJoAHOqN7jEl1daDZa9qTLze937RmcBLJS42hj1Z6E/BeDI/liQG1bWLW4aqX
         C76kCqGDx/TIhvWStNrUrmw1Di4OOWVS29zMtMji6mjI3+Dl1q4P/QvgFyv3cgyWGYy1
         RHL/uqwqCbLfXxoP5G/UIQegLphudaXJE6VgMfO5evPHN+nRSkjq8E7dvNNQh4a8TkEE
         /vrg06Z1e3k1cy9sRmZ9omoXqrMmuXnVJYLKHc65rTiTwoEwShZMkX3AHCglKnLCj9bS
         KSxBk+/6rGd7FbTps1hhm0Wk9fdbNK+srGDfaGTJUYvQGAGQhtwzPzV1lPqsSs//SEsE
         VqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283341; x=1793888141;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YenbS62NAlWG6owZ+KD+JytwJQD+4kiAv8kfExfGsRY=;
        b=b2JcRc7ngnaHqi3UIOwZvr6BegDhU+trMj4Vpw4zw4O/Bn5sbz7NCAOOaMOoFfSFRt
         KM0D//Ns2di+PFrg6hCJF2vdBWUJMppLA7IJGBrfMuHVK2p7OZ3sbVgNFaVwab8649FW
         PrqD9qMwAM2M4Ftq7eeVpVe0183hsdxIGyZCTlzU6YHMvs4LTUOLBFzzJViQzJauwNsA
         06d3XMz4Fh80EGvGSqBLZ7vWEQtBAV82IVxMcZB90BEEDli8Y8XOTNJH6oEq/ZruNkqG
         QnoOG2pnf92LznqKPEbonPKdDfM8/VDjUkNDR0VzRpaZZL4+NNCllIvqu8mZfuied1uv
         W6tw==
X-Forwarded-Encrypted: i=1; AKwUvBy1z5U9UFCnLszcEoYbpbCy8QoP1IeRfcTrAjfDkXKUAkXil0mOmPXxQ8f2my3QDLCO05v2Cfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI47Pt3EogyknuED3foccPjrvSdDUJ17CXhx6MLFogMdqMtYGfZ
	E8JL57ITCcq0eijWTyRdyNaT3Ty7hRg7PV4oga71YkHjxV75Kr9ogzQx
X-Gm-Gg: AYBFou2k8axjJtYOfRhqm6wuHIOdkZUCRPrtp95FKkM/f8fL557luVZOocoDIedPN24
	61+zQx6+bNFEztWabViUt9u/9hzDbyc1NCUg54EN6LoJ3Z3KdMKwyMDUl253sXsjIwH/CYx3fnu
	ULF1EaGuuJcLIgYLslBebpeiACoSk1KrE3zRdcw+qptfaLsXfTvAYA+NVZ+pBNU4EalL5PXHB/8
	HRwh/AXJfFk8vXIjhhBfosXpts3ycrkMcqOcxQpIzWnskYBcFeZPbHT2KaJQpiXSRCDHJZr20Y3
	JmtideJE2jb4SR/LXAh9nepwXznPHDz8jyXW6nl9i2IYQduqFJ2A/ZT+brFiDn1//CSBKoHTJft
	/84m9WnQ0pKL7nO6mm7T6qY+g/YYRiurw4oNjk9QiC+YbD0/WpcZT5Bim/42Lsr1Y9spzzd8rGt
	0ojoGqtX9aBppdTc9tyOqTX9L3/zAbT6+B1zf8bQWL5+qQMlURe95R+nD+xec2Fn5X2QLx8CC8i
	QzaniBFD9Kuz+foUfMDOxuKkmcqNtbo1kXILdGF3ajW6zdyZws4v+wQ7mzetebRn0S1lMVMleks
	SthDki2FocCL4plsfMPpBVWFu/Gm3B7kr7dZtoMwnBOJZhBAI9VfghgxTrukBU7zyeXa5JO6+WF
	UXs5MUn5TGpYwsqgGquQgE/An3kiil/E+TglSuQPa9zc3c/wCI/+9PKZij61AKdruyEuS
X-Received: by 2002:a05:6102:578e:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7d03a509ee8mr2217292137.7.1793283340823;
        Thu, 29 Oct 2026 07:15:40 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991dea4e74bsm44272241.7.2026.10.29.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:15:40 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:15:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 Kyle Zeng <kylebot@openai.com>
Message-ID: <willemdebruijn.kernel.370d112bcff2a@gmail.com>
In-Reply-To: <CAL4WiiqgTTAD_j_Djkec1RJj_wT4bE2V2=Wrk+a=FJ34cyA0vQ@mail.gmail.com>
References: <20261028171350.2205175-1-edumazet@kernel.org>
 <willemdebruijn.kernel.207a67bdeedc5@gmail.com>
 <CAL4WiiqgTTAD_j_Djkec1RJj_wT4bE2V2=Wrk+a=FJ34cyA0vQ@mail.gmail.com>
Subject: Re: [PATCH net] gro: do not GRO GSO packets with inconsistent payload
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> Le jeu. 29 oct. 2026 =C3=A0 00:33, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> a =C3=A9crit :
> >
> > Eric Dumazet wrote:
> > > From: Kyle Zeng <kylebot@openai.com>
> > >
> > > tcp_gro_receive() excludes empty non-GSO packets with the unsigned
> > > len - 1 check, but its GSO branch only checks that gso_size matches=

> > > the held packet's MSS. A trusted TCP GSO skb can reach GRO again wi=
th
> > > no payload after TC pedit increases its TCP data offset.
> > >
> > > If the skb is fully linear, skb_gro_receive() then enters its fragm=
ent
> > > transfer path with nr_frags =3D=3D 0. The do-while loop copies skb_=
frag_t
> > > entries backwards beyond both fragment arrays. An unprivileged proc=
ess
> > > using its own user and network namespaces can trigger a KASAN
> > > slab-out-of-bounds write and panic through veth, pedit and GRE.
> > >
> > > More generally, the payload of such a packet can be shrunk to any
> > > value, making it inconsistent with its gso_segs, and a GSO packet
> > > with gso_segs =3D=3D 0 contributes no segment to the GRO packet.
> > >
> > > Do not aggregate GSO packets with gso_segs =3D=3D 0, and require th=
e
> > > payload of GSO packets to be consistent with gso_segs and gso_size,=

> > > the last segment being allowed to be short. This rejects the empty
> > > skb before either TCP merge helper, and covers both IPv4 and IPv6.
> > >
> > > Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro st=
ack")
> > > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > > [edumazet: check payload against gso_segs, refuse gso_segs =3D=3D 0=
]
> > > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > > ---
> > >  net/core/gro.c         |  5 +++--
> > >  net/ipv4/tcp_offload.c | 12 +++++++++---
> > >  2 files changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/core/gro.c b/net/core/gro.c
> > > index ff828a3dce3ca649e149a840bd6e3dfd9ddaf0c4..1b033855a20db6b8b99=
6179f0b81e38393d3864a 100644
> > > --- a/net/core/gro.c
> > > +++ b/net/core/gro.c
> > > @@ -513,9 +513,10 @@ static enum gro_result dev_gro_receive(struct =
gro_node *gro,
> > >       NAPI_GRO_CB(skb)->count =3D 1;
> > >       if (unlikely(skb_is_gso(skb))) {
> > >               NAPI_GRO_CB(skb)->count =3D skb_shinfo(skb)->gso_segs=
;
> > > -             /* Only support TCP and non DODGY users. */
> > > +             /* Only support TCP and non DODGY users, with a sane =
gso_segs. */
> > >               if (!skb_is_gso_tcp(skb) ||
> > > -                 (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
> > > +                 (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) ||
> > > +                 !NAPI_GRO_CB(skb)->count)
> >
> > Or make tc_pedit set SKB_GSO_DODGY? BPF already does.
> >
> > In pedit_l4_skb_offset and pedit_l4_skb_offset.
> =

> Good idea, this would also make sure gso_segs is recomputed if
> such packets are later segmented.
> =

> I would still keep the !count check: ixgbe and libwx RSC packets reach
> GRO with gso_segs =3D=3D 0, and the payload check in tcp_gro_receive()
> relies on count being non zero.

Should those get fixed instead (eventually).

> pedit is also not the only way to change the TCP header of a GSO
> packet (nft payload on older kernels, NFQUEUE with
> NFQA_CFG_F_GSO, bpf_skb_store_bytes()), so I prefer GRO to stay
> robust anyway.

Argh. Good point. In that case:

Reviewed-by: Willem de Bruijn <willemb@google.com>

> pedit can be changed later in net-next to set SKB_GSO_DODGY on
> GSO packets it modifies. Note this needs skb_unclone(), which can
> fail. pedit does not drop packets on allocation errors today, so
> it would probably leave the packet unmarked, another reason for
> GRO to not trust these packets.

