Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957017;
	b=N3Y7m/iDHQpZv+ZA/inNTyDUbCKNlG/Mqv4cvkkn9cb3Jq6jAPVLO7oRudiK0E2ImcFh
	 /bt5recxOCUeWpxJnFCNJl3XkJdbctNG3dYnL0ImoGO8SMwCw1ePyyitmJAy87APJg45U
	 3to3buT38GyrQDO0bYW7QN/sGTos1Qssora6YJkYJeDitpD0Ll7VYDMaVKVDFZkip4VV7
	 wTiygbAV+BNQoXs7S6wCOWADMudUnvuAfOdpEZgmNpEWqTz5ubQ24mMlDFAk2AigXFPFN
	 SQmxLeL2BbvAh2XQUO+QyP5HdGPVAYBKMLVcxyPJMLMDx49H2K57tvrGOjMTvjVaDEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=FkyWJop/mb6aNzKVDcPYdXhzK9QyO4mdZuzhtZY4mdI=;
	b=V6pMsjlBeJeSg3Dq290HCjxy8ZRvzvNVCbU8p26lkNMtLRk+vNorqdRPtIt3ro4xtD+L
	 4DODsTrM1MAWc/y8Zvi1PHYMGDe+SKQSQQD4ZUQouvWW4SyN4QoG+db2k33JjUDoauwdv
	 Ob3ybCVeb1d2akBcEmhJQBWuWMvyoUHYBCANGn0tZsdauNQHFTF0LbeWGkz+MAW5yfrZL
	 L+DeRUutVMWO0ftNJrcdyucrhZFxwuna696IhvKoVNn3sI9ik9yfmUalWUySn8cyr+5qg
	 40rhX7CukeVJGwhDD9jQQUhIlyeXPf9xzM6/xCPOE+oreDoKtDf5FIftYyPtcC7Z5nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KVJ4PHU5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC2606A321
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 19:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9DC2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KVJ4PHU5
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1196124a12.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 12:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792957016; cv=none;
        d=google.com; s=arc-20260327;
        b=IjCDX4/Cnvq3XVrWGlItD7ZDg0JyzuO8/DKegt0BOk6xDxmE4dnWa8RKB1T3yJiz15
         dU13+eJ8DZX+OnQ4WrLeyLXqnYKX3czX1/M09OCJbOXKLJNQpNud/nJVbNmMmrITeLua
         s8qXQh802AzFLWyXIIGkr8qGFFc8oa4fqFrk8S5yAseWHkxmNHuq0dnI7mpXihHlmvBa
         4dRQSliSrXfxXZrX9YD2frPVFWHuscPjsal4kN8pJMgYeZ9kMEsbY9eSY7QQYQojQx/S
         R3jFZ9tXUjjQ5SOJB8dWrGZ4bkWs4glFHjwa1QC6/kYCttA3/yZx/XcISKOB//7TJ1j1
         r1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkyWJop/mb6aNzKVDcPYdXhzK9QyO4mdZuzhtZY4mdI=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=hFJMP878PWpHHsDAcTMwjpW89atcATszPpx1myYl8ehh+cnRKRoiU9q4GDh2Hq0O9I
         Bg4BCVCpM7FrunEleR7Swa6LEF4f/1TZR93oYfmTftNN1bp1ATRLlXRXaTYE++QZJMmM
         BsyNQyZuzemGBq8e+DDxx2L3tzALEcW3cEx1ztx08zc7FfVeE0H6uH2qxhPBYvhVy701
         cDrsp86RU8EhP645R3nQ32JFh//7h7R+FPSiyEbXaWfUcJz0JKcosxQShNd3GomXSp91
         dpYq/E6CgZ/N27qVIfQh1y8+nPkzD5OqqjzroaqAnjqSjtV3QRa63A8Zg2D7nAXssZVP
         4D+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792957016; x=1793561816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FkyWJop/mb6aNzKVDcPYdXhzK9QyO4mdZuzhtZY4mdI=;
        b=KVJ4PHU5vclDEllxKdUmcoG1GqiWFjjx6slq7Q+fgMaUXlfGR/7jPd1XpK9fuFbitB
         sH4rwQ/IzQgA4yw4Cc+lgBvXs5keE1YrZ6uGa+AwX2f6qYfSCGHcYW0q0ZwdjQxN3wue
         AI7uq+vVmuFY7zIKv2lu3TMeYl79xNLKXnvvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792957016; x=1793561816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkyWJop/mb6aNzKVDcPYdXhzK9QyO4mdZuzhtZY4mdI=;
        b=giM8aCCQChv90sr1jkJgmHndNASWDRqWxk4Bix3dmSWCcB1iiFJnaIbr4ka1oU1Gf1
         QIkqhzwKv1YkusY0xKh0spv+6Vkc/opnV1316Hfpn1Uc+urJRLblzFusNCEajxCExJSA
         fBtBOzWT7L5Pia8NuKq/xxn20j6DAWOGWq6KTk9C0TeP9nggkmumnwr9k6WTtq8OM5v8
         5WSYUjVf2pZO6jHqlgc6qhQ1L+2x6Vr6F/sxDgo+sxQpNgzP6TCavetdOr3ZLrj+7SXe
         HqC/AolUnP5DL/VfOCIxU87z7XO9rk9i25JZW0lxh3NjbLzNJ5CWBUFvv1TzZrMEjqEt
         4DlQ==
X-Gm-Message-State: AFq9FYKHp0TN7s47+2K2DfEqKnXXkw1JH0SEuMhSWggtEmXJ/oukPrsY
	weqhbZoRxbndcT0VTm6Xqo+RiaCKQR38/NmFe4WF5p8uZWFwkijCuAJ6Q8KwjGIebvhPlLQLwP+
	Cs4mUGjPpY+8EztOPoEkCQ3rY4d5GwFMQjow3k7ZU
X-Gm-Gg: AYBFou3QbdvZOgSwvJUcmTsZ5q83AT56fJGSYChvrlHw7u+8opXYjweXFda92xrmlDy
	Ill3/FNYB7IAwPGNgIbvwJ1HQdvLEYftkWaVMdbOzhT8zryO4olKaxmdkbG4Nn+KH+MHVa+0AaO
	C//g6I+Zj3dA0BSOWc7X9AqYywNbeA/CZHOZ9KBt/D+VrOFM6bpF3mYaodznUW+fzAwGOdappO0
	tGzVAQA1r8bv8eat94tBNExMjZAKCSeMKYxx92UoGM9iwfuNNQ955h4RNjA8kt3K2ignGxOlEee
	LQY/OFNktK14OlJCcqnRcSNWTpyHl63FlNQTqo5Zz1YjtQZ0epiFGBpgblrd2H3TMV35qqTuEFm
	I6euMyNhdFCyTrpX4om+9CiDWkKxybSd/Ob9ZvXGxzCx9YfbEtDRilVKRKlSNrqn3uF56frJmI5
	NuNTfgB5kf3SdXkFYm3fbDN45q8/rTkvJKbmIO
X-Received: by 2002:a05:6a21:1f81:b0:3e1:8a96:7bbb with SMTP id
 adf61e73a8af0-3e7cd589540mr3601401637.51.1792957016189; Sun, 25 Oct 2026
 12:36:56 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
 <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
 <willemdebruijn.kernel.30ca6285209f7@gmail.com> <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
 <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com>
 <willemdebruijn.kernel.eb29d53899f1@gmail.com> <CAM0EoMnQWjN24gBye1kZdcJUJgXDPDy-=dM+NQ6dqCny7O851g@mail.gmail.com>
In-Reply-To: <CAM0EoMnQWjN24gBye1kZdcJUJgXDPDy-=dM+NQ6dqCny7O851g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 25 Oct 2026 15:36:44 -0400
X-Gm-Features: AclHuK-NxE2mgpKUo3Y9YUuL_YsnS-HsIKDDI_Fsw6pAyCpGI6Tw3uu0tHMMLXI
Message-ID: <CAM0EoMnj7pkfGUg=VFjpbU7AGw7ysD_tQOeuUu==YEc9rfQJ0w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	John Hurley <john.hurley@netronome.com>, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 4:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, Oct 24, 2026 at 12:14=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jamal Hadi Salim wrote:
> > > > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > The issue:
> > > > > > > > act_mpls POP can leave the inner Ethernet header in a page =
fragment after
> > > > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) o=
r chained after
> > > > > > > > act_vlan POP_ETH.  A following eth_type_trans() can then BU=
G in
> > > > > > > > __skb_pull().
> > > > > > > >
> > > > > > > > The Fix:
> > > > > > > > After the pop, if the original MAC header is shorter than E=
TH_HLEN, pull
> > > > > > > > the inner Ethernet header into the linear area and drop onl=
y when
> > > > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does no=
thing when the
> > > > > > > > skb was not MPLS, so no separate state is needed.
> > > > > > > >
> > > > > > > > Conditions to recreate the bug:
> > > > > > > > - egress tc filter on lo: action vlan pop_eth action mpls p=
op
> > > > > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, an=
d a non-linear
> > > > > > > >   eth / mpls / inner-eth frame.
> > > > > > > > - The inner header is in page frags; a following eth_type_t=
rans() can BUG
> > > > > > > >   in __skb_pull().
> > > > > > > >
> > > > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation act=
ions to TC")
> > > > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f=
7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_G=
K6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail=
.com>
> > > > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > > ---
> > > > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > > > --- a/net/sched/act_mpls.c
> > > > > > > > +++ b/net/sched/act_mpls.c
> > > > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct=
 sk_buff *skb,
> > > > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > > > > > >                                skb->dev && skb->dev->type =
=3D=3D ARPHRD_ETHER))
> > > > > > > >                       goto drop;
> > > > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb,=
 ETH_HLEN))
> > > > > > > > +                     goto drop;
> > > > > > >
> > > > > > > Is this first condition needed?
> > > > > > >
> > > > > >
> > > > > > That was me conjecturing from Eric saying in v1 "...the check c=
an only
> > > > > > matter when the original MAC header is short.."
> > > > > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > > > > >
> > > > > > > More importantly, can it hide a bug?
> > > > > > >
> > > > > >
> > > > > > What kind of bug?
> > > > >
> > > > > Two kinds. One, if original mac_len is larger, gets popped and th=
e
> > > > > resultant packet is still too short for ETH_HLEN afterwards.
> > > > >
> > > > > But this can probably not happen, as skb_mpls_pop only pops one M=
PLS
> > > > > tag.
> > > > >
> > > > > What this patch tries to ensure is that the subsequent Ethernet
> > > > > header is linear.
> > > > >
> > > > > The second potential bug is this assumption that after the MPLS t=
ag
> > > > > lies an Ethernet header. Is that a valid assumption? Or could we =
drop
> > > > > a valid packet with smaller header.
> > > > >
> > > >
> > > > tbh, I was thinking more about skb frags earlier.
> > > > You are right only ETH_P_TEB promises an inner Ethernet header; for
> > > > other inner protocols the pull is wrong, so I=E2=80=99ll check for
> > > > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in t=
he
> > > > current fix - good you responded before i sent out.
> > > >
> > > > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > > > pskb_may_pull(ETH_HLEN). A brute approach is also to check for TEB:
> > > >
> > > >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pull(=
skb, ETH_HLEN))
> > > >                 goto drop;
> > > >
> > > > Note: skb_eth_pop() only removes the outer ethernet header but does
> > > > not change skb->protocol
> > > >
> > >
> > > I am going to send it without this 1/6 change - it just doesn't feel
> > > like good taste. I will add a comment in the changes to say i
> > > considered it but decided not to. I also spent time eyeballing the
> > > code, i dont think there's a potential way to craft a packet that wil=
l
> > > hit the perceived issue. In any case the 24 hour embargo lifts in a
> > > few hours so i am not posting yet.
> > >
> > > cheers,
> > > jamal
> > >
> > > > thoughts?
> >
> > I'm actually a little confused why the tc layer has to anticipate the
> > needs of downstream code and pull headers here.
> >
> > That directly lead to this guessing of what may be the next header,
> > such as Ethernet. Which may often be correct, but not always.
> >
> > All protocol parsing code itself should already be robust and call
> > pskb_may_pull where it is needed. Sounds like there are some targets
> > post TC where that is not true *and* we think there are too many to
> > update those targets directly, rather than this transformation logic
> > that exposes them to unpulled packets?
>
> Not "too many updates" rather the main motivation here (which i kinda
> empathize with) is pushback from Eric that you have to "fix at the
> producer" to avoid performance degradation at the "consumer". i.e
> rather fix the vlan action than have loopback vet as in the original
> patch  (and you just witnessed him stand up and push back on tun for
> that same reason ;->).
> IOW, we are anticipating so that eth type transfer doesnt bug out
> (_for ethernet headers_) when invoked at the downstream consumer
> (loopback etc). Essentially it is a game of whack-a-mole until the
> next bug or malicious use shows up.
> Generally, policing intoxicated drivers from getting on the autobahn
> isn't the best philosophy; it's better to complement that with a
> "driver beware, you may encounter drunks" warning but that would slow
> down the fast car on the autobahn ;->

Actually the more i think about this the more i am concluding just
fixing the producers wont be sufficient (Eric!).
If i have an incompetent or malicious ebpf program it could do
whatever it wants.. I am going to try something with ebpf.

cheers,
jamal

> cheers,
> jamal
