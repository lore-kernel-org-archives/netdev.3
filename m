Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691846;
	b=BVCOrqQF3vbtPWYTcWONi3afSv86mx5XtwLDx6uEgBxqqyGL7F7Chs2BRlNaC/PqzYDe
	 sV1dmPawaKF8SXtlllKMgTknoMWFdl3s0PCyyRm3QaqDe/xoaDbAwHKdvkt2WXLLolq+7
	 di3qfIdl8DetiWuEryF7/gZ+F041Nsipdd6LzpN3W31aXG88MeiJAFAcPVwemcsTrj5KS
	 cKdSjPCyj4iFUjgcVsetVoj7T88sqmCjC8f17uaxAFzDnVJF5JNf8rLOBkkOjynnRIhff
	 14HXmIGMyjg/bt2fufnbfgunm7tSFqu03fHzUej6lGzSMBF3mrMNGeXxQbPfpuviJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691846;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kezdcC+FSW+yMTp2Da1WjecVlmYgqS8wNI64QyxYIRY=;
	b=XMyLKdsg5RlRaZAGk/d0mP9Q4EibvMROTseCbzfdUV8QCPDREYWUsUB+lWmWOmMo6589
	 cFa1LREo6zI0b0fLO8PEe6NnSc/SzB2Q7iP4zsGHQcf9NaT9F7OYzj8vwFOcc7D2kbSb3
	 k/e7KXUTpUm5GEHyXYNovkB0h/qEh5dep2lPSVFKvyAGl4TBZINE9etQz5zMwm3j1bjZI
	 odjqegc7of6DCXS4ow1WNfBfWXEQAy8XlJqxm7BcSi1XiIRlZ6iqDJou6JbgPuADlsUQO
	 FbQsyMMtF2BrqK3BTmnmfzxtydq+o1ozRDMvi84lBQ3eiEfVs5eBvV5DAaS8Jp6AEdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWlmzYsX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5A606A329
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWlmzYsX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43351F031EC
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691845;
	bh=kezdcC+FSW+yMTp2Da1WjecVlmYgqS8wNI64QyxYIRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HWlmzYsXxtxFtXk59tbpJnlVi3Eo1x2LZYpEPB5xOjM44lj0VIPkxNqY3mfAtC1Tg
	 JqOisUCzOtZjx6jXvt+i6UPUyvl5/1PpDGRC6cjN3xya5ldpydkEXENdJKNohA6Ul/
	 UMj5x/8eqAOSget0AqX81RuSYWwwcWDu9JqMhKM6v90IWTxydHppNNnP+R+XZwn13K
	 Zq0nlBzVaaNkZfAKDcLCmQHmq71F4UxKDT1xzdPhul4cFpNT3ZTTjSKaTmlOUTRM+l
	 XIu7aYU08FZMJD1RAxXyF8Gu3XISUDcAW75SdNLbaPINRZYtR9JxC8hhAHFlYvFRr3
	 pQjlIxXBhxuNA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso20329211fa.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:57:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx68qebg3sHkGIbaj49QFdu815eYFCN+0kurRrwcuiqh4FEO5w1eleEafDDOiqme11L0oFxw+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoyuH1c0hfXI9oZkiJbwg2yZmTEhkmfIBVo0jVspXLyHyyOcZq
	ayNVw4cZ1g/LBy5sO7rRGwcGyLGnfmdRY8paTscOPWmr20rTmc5P2IeCuFtNwsCoebakZsRB2Wq
	45kEasV/4e8OJqbPbS1SXJvdzoEn9ZKs=
X-Received: by 2002:a05:651c:c019:20b0:3ac:433c:6ac6 with SMTP id
 38308e7fff4ca-3ac440a79cdmr13633081fa.3.1792691844526; Thu, 22 Oct 2026
 10:57:24 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
 <willemdebruijn.kernel.38722ee638a21@gmail.com> <CAM0EoMnJhXQPxfU65oLYvpc-a6MhZSKi-D664fTMLah_6p7G2Q@mail.gmail.com>
In-Reply-To: <CAM0EoMnJhXQPxfU65oLYvpc-a6MhZSKi-D664fTMLah_6p7G2Q@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 19:57:11 +0200
X-Gmail-Original-Message-ID: <CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRCVXMHz+xmmQm2hcA@mail.gmail.com>
X-Gm-Features: AclHuK_nqha3vOjEUCmurV-VfrxxzUbueW59pQsZ8XZJ_XYH3Bsub5nUKrzWM3M
Message-ID: <CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRCVXMHz+xmmQm2hcA@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet
 headers after POP_ETH
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, Ren Wei <n05ec@lzu.edu.cn>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowangio@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 18:01, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Thu, Oct 22, 2026 at 11:21=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > The issue:
> > > act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
> > > subsequent eth_type_trans() may then BUG in __skb_pull() when the fra=
me
> > > is redirected to an Ethernet device.
> > >
> > > The Fix:
> > > Drop the packet at the producer boundary when skb_headlen() is shorte=
r
> > > than ETH_HLEN after skb_eth_pop().
> > >
> > > Conditions to recreate the bug:
> > > - egress tc filter on lo: action vlan pop_eth.
> > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-li=
near
> > >   eth / inner-eth frame.
> > > - The pop leaves skb_headlen(skb) < ETH_HLEN; a following
> > >   eth_type_trans() can BUG in __skb_pull().
> > >
> > > Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions=
")
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88=
e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/act_vlan.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> > > index 6a375fdc63dd..ddf03b08bfe8 100644
> > > --- a/net/sched/act_vlan.c
> > > +++ b/net/sched/act_vlan.c
> > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *=
skb,
> > >               err =3D skb_eth_pop(skb);
> > >               if (err)
> > >                       goto drop;
> > > +             if (unlikely(skb_headlen(skb) < ETH_HLEN))
> > > +                     goto drop;
> >
> > Could it try to pull the header and only drop if the packet is too shor=
t?
> >
>
> What would be the benefit?

Not dropping legitimate packets :)

skb_eth_pop() only guarantees the 14 bytes it removes were in the
linear part. Nothing guarantees anything after them, and many skbs
have exactly ETH_HLEN bytes in their linear part.

For instance, drivers using napi_gro_frags() (mlx4, sfc, gve, be2net,
cxgb4, ionic, ...) when GRO is disabled, or for protocols without a GRO
handler: napi_frags_skb() only pulls the Ethernet header.

After POP_ETH, skb_headlen(skb) is 0 for these packets.
They work today (for example POP_ETH then redirect to bareudp),
and this patch would silently drop them.

        err =3D skb_eth_pop(skb);
        if (err)
                goto drop;
        if (!pskb_may_pull(skb, ETH_HLEN))
                goto drop;

fixes the crash, and only drops packets shorter than ETH_HLEN after the
pop, which are not valid L3 packets anyway.

> Note: the OVS patches pull because they must restore
> MAC_PROTO_ETHERNET and already return an action error, i see a good
> reason there.

The same reasoning applies here: the producer makes the packet
valid for the consumer, it should not punish valid packets.

Thanks.


> > >       case TCA_VLAN_ACT_PUSH_ETH:
> > >               err =3D skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_pus=
h_src);
> > > --
> > > 2.43.0
> > >
> >
> >
