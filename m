Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792961434;
	b=ULasWkbFt4DxNXmZd3yEUOFrqLJIYweo235JoxTUAnAG/yWty3lqjC0nFwKB8hJq7fGh
	 AEFdQ7/PM7EYeoXxGtDReKe7D4DcuwibMV5jmfwDtGvwIJSdqC7GJ8To/Aio2KbSzCpvc
	 9Mh75GI4DptWwPBlheysCiGPiY72TvjuArDWltZqDsLPrAli2/FWxOh9DSu7XZFiqW2Hg
	 YBd6LYoqHp7nlovy5Ho2TNWeO9xP69uuAK46XcJv244NTqfRholNrxPouYcxM7sLpvZ4u
	 ahe7CyvN1xELg0iEzYsO9Fmy/DAL1OIEkqqYZOS1v/lBriJNho+C+NHgd8z1aFLbQAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=j5gwkHIhC+Ankz1sh/E0mkDj6bA4mUt4vPq9Teg/4ks=;
	b=ybqRIQRRHYcl8iWdWahtBYRP4empXGpTMBFB96L2xu61L0rzA+YqLp5YcOMv5HEHQml7
	 hP/5aN2smPN/itj6FXUSuHP4PR4hQ5VLQc/+QqeouYvsAqV5enZacr2RTZNkdLlvO6e3w
	 QhvPFZH2+BEw10l6t1O4ssAb7/k7fGOONH5YP9fvenjlYxqiG3owAebnbRkYNNYjEls7W
	 iGsd/KpdDKF7EvrU6+dWbYOWok707jYoCE9sclC2BucsvXkKtcYSsL65BWKRoaqbJvkaD
	 C4Ln7sot8yD5rXOxGVtwM4JlYlHArgVAdALHt0Jqd2U4RlT/f5dJgPEagvjEY2Oe54Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rJHre7hf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31F606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA31F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rJHre7hf
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1234245a91.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 13:50:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792961433; cv=none;
        d=google.com; s=arc-20260327;
        b=CWo8z2g81s4PYDLngWxxkVy0zWII4TWFxB/9CNctFhwKXbZgAfTL0qTsnLL8YSgOC0
         6kxE3yE2wr2q2WL8UCCL2sEXS7f3DF447DfbkZx2TMctEkwy0na/3AQyjqpS2YQ9GAqS
         NDrxAz8QrNWGI+r6vTItTvYPsonYKyPfkh48L7bXM3TfrmYlG3Ud/iJNO1839vXk1Fy8
         8/PKQydDmzGiNEuIBgVJv339M0MQdxQXhOWaKbQnxpksTdHTlwtmvKZDtIE9CK9E/JNx
         WhV+dXvI6NpVL5lwy3V9liitH+c0eAbS1A0WHFFNLshCpBRoCnkgp1n6wALWeWT1TYSl
         PTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5gwkHIhC+Ankz1sh/E0mkDj6bA4mUt4vPq9Teg/4ks=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=S6gxKvkGLFcgu/M0R7l0D6inATN257BoJBcaXuPs1W+RJDyCPn/Sztq0gwqGia1vhV
         ItEQbgDJGmK2fZsB6r45ttTXj3I9g+ZrUAYH7U0N1erHRNyOxXdo3ZBQTvUF6YSEvK21
         lAzn+v/VvUWAJz0HYMS5foFxx7qNBdF5AXwVoByFMnCqiUh0k/4SIzfi6DuvJUI/2dI8
         dFBQrECdulHP1nHwNywjl7XJYZ+1i5kr7vN7z3Y6P72ZpBOOhUGeBUGBxuzXuIUxH88S
         9wufABW4ekn+7aRvhre7kEYDIP0ygJ2fxeCAhdt7nQXFFUSCvI/7M6DENk6XesLn/vog
         mKBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792961433; x=1793566233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5gwkHIhC+Ankz1sh/E0mkDj6bA4mUt4vPq9Teg/4ks=;
        b=rJHre7hfO3QGqRShL7vdQXUIzlEZgUgpbhHbyV7gWW/YEA+4Xecudc16NpWQz0imi4
         tSrEcubqvfEAujDNX7w2cZe4YJvVaybgkwQxcALaLDeIF2XqjZuoZn/IbRZtfXcKf+Fi
         4d9FGfHIwosqlExpN3vmArFDwPHLIIyyXUla0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792961433; x=1793566233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5gwkHIhC+Ankz1sh/E0mkDj6bA4mUt4vPq9Teg/4ks=;
        b=uUKYAdHAY/KSly470dw3piZhviwEE4Qnq8ro2clLXG6PRpX7hFtTT3onispGrPU1uZ
         O8YdeVpCafbMfLkGGCxSU5MeXvxf7FFgmMZC5s8wzY/5cLh8vZkyQDVebzu5Jl5NcVBd
         RzSXjjWbXJjjwjiZAaR3pQNO1hifY8NheP1zl9j1mfj/YB94Z9Zqk2knEj45HfsjMhs3
         Pw5YrepAg5qKeJaTtuzk9602A7lOgpfH6rHRCXJNsOfuIAaUCEYbBrDv5QoY6l6W65sn
         mc4cm737wLcc1yKQL9LHEU4OPBQiHQYtNlmFgeAgetW3JfxAoeJ3rWYXrgQeWye+cZff
         407g==
X-Gm-Message-State: AFq9FYJzz1mfPJJJQu4aS+vmh5yg6Xfl6+vYmE6ml0aHtKh9GHyJbOlL
	krjMZmH7uypwT1oHUrWKXsD7PTMoC/uez1wbJsbStRTWQKRd5cm0y+lJtZolKhPbN0Hxb71Q1wK
	xVJ7DT3QXpq1VbsbrD5sWRan6a10gyjnjGzXbWRvR
X-Gm-Gg: AYBFou0SB5VB3/gJ1TgwNzM6lnSDQQxWI8aIvPFchQzxTE/lEN33e+nBc99vJx4nHga
	W7WoLcqA+eR2MVNDejYmeSb/C23mZnidz017QS+raqKnqwJlxMDqR5T9QtPk3wXNuvl/97SKRX/
	cnsnG+/5jlpYu0ETRd5elzhugrBa3BwmhCUJLXnB4iQxtsTOOvOEU1fhgcy/UDuKQlEAQzqXkSZ
	Tz+AFJG1npz4lVkgHAxKDe0Kym50+2oNOiIQLVPx5DRtx8PwqSL9KwQ2tGRmAGBkwQrWpV8q42u
	4dVnkXnbjPOP0YNJZaD7H+2FjC09LfDj32LRxwqSl5Eflpvi8v8jViKnt8SRwiwnw62Uvo2Zegq
	ruTHcQjoDbDdbgzIf9taj23MFIgIJ8iva7fcseBu5eyIJ1LNtaRAGXWicm1EpQiioK6/1Mx+TFF
	K8CWm1G86g6B/G8Uc=
X-Received: by 2002:a17:90b:4488:b0:3ac:7749:2f0 with SMTP id
 98e67ed59e1d1-3adead4c649mr4105124a91.44.1792961432840; Sun, 25 Oct 2026
 13:50:32 -0700 (PDT)
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
 <CAM0EoMnj7pkfGUg=VFjpbU7AGw7ysD_tQOeuUu==YEc9rfQJ0w@mail.gmail.com> <CAM0EoMmEuj+k4HXOD08rdtS8+aD-8oTWFedED2kt5XfBR8=V3Q@mail.gmail.com>
In-Reply-To: <CAM0EoMmEuj+k4HXOD08rdtS8+aD-8oTWFedED2kt5XfBR8=V3Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 25 Oct 2026 16:50:21 -0400
X-Gm-Features: AclHuK9shJNuXJv8KDGbiIN0zkdq9FnauAm0wDnMWSVe0HxV8W43GziN820qRLE
Message-ID: <CAM0EoMkvAgc6+HNsTUrYZ1RHqRrr5Z2vzJkWsz03jMt6NVcEpQ@mail.gmail.com>
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

On Sun, Oct 25, 2026 at 3:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Oct 25, 2026 at 3:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sun, Oct 25, 2026 at 4:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Sat, Oct 24, 2026 at 12:14=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jamal Hadi Salim wrote:
> > > > > On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@moj=
atatu.com> wrote:
> > > > > >
> > > > > > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > > > The issue:
> > > > > > > > > > act_mpls POP can leave the inner Ethernet header in a p=
age fragment after
> > > > > > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D =
0) or chained after
> > > > > > > > > > act_vlan POP_ETH.  A following eth_type_trans() can the=
n BUG in
> > > > > > > > > > __skb_pull().
> > > > > > > > > >
> > > > > > > > > > The Fix:
> > > > > > > > > > After the pop, if the original MAC header is shorter th=
an ETH_HLEN, pull
> > > > > > > > > > the inner Ethernet header into the linear area and drop=
 only when
> > > > > > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() doe=
s nothing when the
> > > > > > > > > > skb was not MPLS, so no separate state is needed.
> > > > > > > > > >
> > > > > > > > > > Conditions to recreate the bug:
> > > > > > > > > > - egress tc filter on lo: action vlan pop_eth action mp=
ls pop
> > > > > > > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28=
, and a non-linear
> > > > > > > > > >   eth / mpls / inner-eth frame.
> > > > > > > > > > - The inner header is in page frags; a following eth_ty=
pe_trans() can BUG
> > > > > > > > > >   in __skb_pull().
> > > > > > > > > >
> > > > > > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation=
 actions to TC")
> > > > > > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe927=
1c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0=
Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@g=
mail.com>
> > > > > > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > > > > ---
> > > > > > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.=
c
> > > > > > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > > > > > --- a/net/sched/act_mpls.c
> > > > > > > > > > +++ b/net/sched/act_mpls.c
> > > > > > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(st=
ruct sk_buff *skb,
> > > > > > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_=
len,
> > > > > > > > > >                                skb->dev && skb->dev->ty=
pe =3D=3D ARPHRD_ETHER))
> > > > > > > > > >                       goto drop;
> > > > > > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(=
skb, ETH_HLEN))
> > > > > > > > > > +                     goto drop;
> > > > > > > > >
> > > > > > > > > Is this first condition needed?
> > > > > > > > >
> > > > > > > >
> > > > > > > > That was me conjecturing from Eric saying in v1 "...the che=
ck can only
> > > > > > > > matter when the original MAC header is short.."
> > > > > > > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > > > > > > >
> > > > > > > > > More importantly, can it hide a bug?
> > > > > > > > >
> > > > > > > >
> > > > > > > > What kind of bug?
> > > > > > >
> > > > > > > Two kinds. One, if original mac_len is larger, gets popped an=
d the
> > > > > > > resultant packet is still too short for ETH_HLEN afterwards.
> > > > > > >
> > > > > > > But this can probably not happen, as skb_mpls_pop only pops o=
ne MPLS
> > > > > > > tag.
> > > > > > >
> > > > > > > What this patch tries to ensure is that the subsequent Ethern=
et
> > > > > > > header is linear.
> > > > > > >
> > > > > > > The second potential bug is this assumption that after the MP=
LS tag
> > > > > > > lies an Ethernet header. Is that a valid assumption? Or could=
 we drop
> > > > > > > a valid packet with smaller header.
> > > > > > >
> > > > > >
> > > > > > tbh, I was thinking more about skb frags earlier.
> > > > > > You are right only ETH_P_TEB promises an inner Ethernet header;=
 for
> > > > > > other inner protocols the pull is wrong, so I=E2=80=99ll check =
for
> > > > > > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check =
in the
> > > > > > current fix - good you responded before i sent out.
> > > > > >
> > > > > > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > > > > > pskb_may_pull(ETH_HLEN). A brute approach is also to check for =
TEB:
> > > > > >
> > > > > >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_p=
ull(skb, ETH_HLEN))
> > > > > >                 goto drop;
> > > > > >
> > > > > > Note: skb_eth_pop() only removes the outer ethernet header but =
does
> > > > > > not change skb->protocol
> > > > > >
> > > > >
> > > > > I am going to send it without this 1/6 change - it just doesn't f=
eel
> > > > > like good taste. I will add a comment in the changes to say i
> > > > > considered it but decided not to. I also spent time eyeballing th=
e
> > > > > code, i dont think there's a potential way to craft a packet that=
 will
> > > > > hit the perceived issue. In any case the 24 hour embargo lifts in=
 a
> > > > > few hours so i am not posting yet.
> > > > >
> > > > > cheers,
> > > > > jamal
> > > > >
> > > > > > thoughts?
> > > >
> > > > I'm actually a little confused why the tc layer has to anticipate t=
he
> > > > needs of downstream code and pull headers here.
> > > >
> > > > That directly lead to this guessing of what may be the next header,
> > > > such as Ethernet. Which may often be correct, but not always.
> > > >
> > > > All protocol parsing code itself should already be robust and call
> > > > pskb_may_pull where it is needed. Sounds like there are some target=
s
> > > > post TC where that is not true *and* we think there are too many to
> > > > update those targets directly, rather than this transformation logi=
c
> > > > that exposes them to unpulled packets?
> > >
> > > Not "too many updates" rather the main motivation here (which i kinda
> > > empathize with) is pushback from Eric that you have to "fix at the
> > > producer" to avoid performance degradation at the "consumer". i.e
> > > rather fix the vlan action than have loopback vet as in the original
> > > patch  (and you just witnessed him stand up and push back on tun for
> > > that same reason ;->).
> > > IOW, we are anticipating so that eth type transfer doesnt bug out
> > > (_for ethernet headers_) when invoked at the downstream consumer
> > > (loopback etc). Essentially it is a game of whack-a-mole until the
> > > next bug or malicious use shows up.
> > > Generally, policing intoxicated drivers from getting on the autobahn
> > > isn't the best philosophy; it's better to complement that with a
> > > "driver beware, you may encounter drunks" warning but that would slow
> > > down the fast car on the autobahn ;->
> >
> > Actually the more i think about this the more i am concluding just
> > fixing the producers wont be sufficient (Eric!).
> > If i have an incompetent or malicious ebpf program it could do
> > whatever it wants.. I am going to try something with ebpf.
>
> And the reason i am bringing up ebpf is because i noticed sashikos
> after like several iterations of a patch find a way to sneak in some
> ebpf corner case. So i am sure that is coming (if indeed an issue can
> be reproduced)

confirmed.

    #include <linux/bpf.h>
    #include <linux/pkt_cls.h>
    #define SEC(NAME) __attribute__((section(NAME), used))
    static long (*bpf_skb_adjust_room)(void *skb, __s32 len_diff,
                                       __u32 mode, __u64 flags) =3D
            (void *)BPF_FUNC_skb_adjust_room;
    SEC("action")
    int shrink(struct __sk_buff *skb)
    {
            bpf_skb_adjust_room(skb, -1, BPF_ADJ_ROOM_MAC, 0);
            return TC_ACT_OK;
    }
    char _license[] SEC("license") =3D "GPL";


 ip link set lo up
    tc qdisc add dev lo clsact
    tc filter add dev lo egress matchall \
        action vlan pop_eth pipe \
        action bpf object-file /mnt/shrink.o section action

tc filter show

    action order 1: vlan  pop_eth pipe
    action order 2: bpf shrink.o:[action] ... jited default-action pipe

And boom:
    [    6.748140] kernel BUG at ./include/linux/skbuff.h:2830!
    [    6.748154] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    [    6.749434] CPU: 1 UID: 0 PID: 301 Comm: mini_poc Not tainted
7.3.0-rc7+ #271 PREEMPT(full)
    [    6.750115] RIP: 0010:eth_type_trans+0x335/0x500
    ...
    [    6.757723]  loopback_xmit+0x1c1/0x580
    ...
    [    6.778076] Kernel panic - not syncing: Fatal exception in interrupt

Eric, any ideas?

cheers,
jamal
