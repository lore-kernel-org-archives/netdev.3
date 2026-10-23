Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792783354;
	b=cgz21V9KpK/OjJRows2tGgdUoRK1yH7nFEIKwIPFslbjgMhAoDJMyJ3593MWWlPutvZ5
	 VFDbXIO5oe+XUsEVBeVnvU/DehAZJAeZ8bqU4e0H4LHtjSRI99+x5FOQHJdT+1S4tTn9w
	 TS1UB9fdaQlVlfxjqpTbrngQaUsIdZgb6cP5IBLUHn35tbfSzAvBOQMqRP7z/dJUp5bYE
	 fPftQ8bV51VVi8hvqwXbNOoCWEFLFvNTfk/Wf9UjoYlpw2p3OuVBUPdMq/WLkFwt7m5+X
	 cMkDxztzVB3rDDTEZmnOGqhpbbatNeneKpkNQGHKDRHl5wcpP/53TICEThAC7HfQtHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
	b=Nsj7xIADQ9BTGAchQ0gT2IA+s5azrd7YPGkw6mvcBqUweJ6pDbGAb6e5GGgdMSSXvEWG
	 aNTHJ8pmF9uQemDXIF/vAoZONnhbWRf0Bsxj0JbuIbcxJOxQMZY+HiYR35WrVwNSl2QcQ
	 NqaXQwi3aZOW9VVvlBYvSc12HR5HxQ9rh55PWKChmm1Bc0D68wBr8qzu5cimhuqpV4XmZ
	 qS7sA3N4AkjXxggq6khACMGKsS27uTF3rzirFkVREwX/gnZi30TAiCgSrEDaMPFWhbk//
	 fvkqYY9h0I754Uvdc1teCNAw4g9ZrLBq6WcLFlryghfyP1jh0Af7HsG206gqqf3Tq+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mXOcn8Pc;
	arc=fail smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85236606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85236606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mXOcn8Pc
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398b3c37877so745451a91.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792783352; cv=none;
        d=google.com; s=arc-20260327;
        b=CHWVZBnrQtctMdMsEo/aMpkDjDpsBb8H9tZm61/XwMrKtwdFdFo7lt+DaZssNFQVTY
         Pp1BL0L8Na5moaWW3EXPG36OUA37GZhjNvGIV+pkoD85G/lxKPWDzhtO78zxXz7xm3g/
         zLCpml4EpN5VYVBH0B1efTGVVq2ADgn2wwg9XOtrDiOckoNuyvAMlpCob3TVLCkWqOok
         1pSBJv8m96Z7asdr7MJZJtFALJ5IAbdQBl2MUEsk6tLPbwoy7rGARBpi1dfTBqYH24Id
         Xw2DOA1lQdjfzNWMaHqfp2CkEZZCwmvB1St6wWBuuXX1RgOiP77dFeRG6QazGF4cGzlF
         hN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=XcflCmuusyZa+4mcwJhW48dRxewPKFCC7pSyAmq2ywNMGz8e3bx9VoHbWSUFzF9nRL
         YcrYm/P2tV/VZ6RrRV/QRwu2UhdiddQ88dryEn6e6x3H7mO73v++hzl//bPwMNxf83m8
         9dNrZ1Hs6buTWB3d1DW+vmxySzspw+dFNXWCXQylOk5wYJlf8GQ9oNczE4iVIRHe3w3c
         Lh+EzXgFYmpDjBtrZlApebPQQgXfX0TBwHI5ZPx+FhIZTwWD9uhek17aoAtUBez+mRGv
         x6M86Roe6wGUaHUv7mvyqcmZS4jAqScLvkZ7IAAaQBvgIX6VGgeBqiPVt0Q4YD3wk5Rn
         v0Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792783352; x=1793388152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
        b=mXOcn8Pcb5uXlfmJsTKeuMl6zVtJrLNg+yXErmU+Mfdd9Yo3GSVnT2KqQhtgkghH1M
         sPmlFRvCAR0gaJH+MScklDupQTIKtAJ7H8geMgWimAcTd3M5k7mWfV8bFf4lzoHzk1Aa
         vLkUZFbX2UZIk7kBATiPu7OCoAG5kp3uCGQlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783352; x=1793388152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
        b=yJSQSwEvUlgczsahWCBs7LBYK2ZzQN/wnNAgzG6eYRVA4uKwR7V9dxCSO+OuWGGbPl
         NMoVOqGkU+bJ6YTbGLxGxku/lRTvlYnZS8GsqNaLEgzmuhVT6mEVbFhVGsfC7xvyXSrA
         p6MfwMh6x3mCR8KklPaRZPvdxRKGU7unPd7HU/TaVWZLeD6cW3+D/9ty7kIxy5Apcu/e
         /Alx3Cs1scbR8pgSE0i+QThkWs5jj9f0ubDFQb+H47pV0Cz2fEsSittwQtKorRR08v0j
         Fc451LzEw23pjPm6CndoLuMyOYY8YzwOf3EuIUfWvQVRTeOa8IE5yR2wLxw8WZ91pTg1
         Z0FA==
X-Gm-Message-State: AFq9FYJMiRuv3l/Frl4+xWG6BndgVRcAWP8X5tpSQrrWyxH6dU7sSNd8
	kpWAzxTotJgo95hjC0qZfENMweraYAB3gr2x0vGyfwre9xOiBRPKxg+Z53w3UHJfoybHYl+tW7r
	jjuvi4E7IZHmBgNmmzQM1QQTIs4hiQeE0ONc4WEQ7
X-Gm-Gg: AYBFou1yqvgs2QaDLYi8gARlXw8YdxV3CIEfmkCgPsjbS8FRdTTQXfz4QWID+wP4LD+
	R2nxjlqy9L57L5Ip+FEnxdWRA0O2k4OlEdmXvIfXWpqKOjErYLt7fKTWwT5Y6OEO8I/e05vlms6
	9FDg5vmTpKzaStDg/lf5tWuT/TCZS8SCzFWkYOC16IVLx0fhF7V8CDhTC7cQLKnQ1ElRzoWGSaX
	fhtoa/L58NMs81vsrtAU0WzHSt/t44Fh3oLUNeqNqcqLOuws+F/ZMhKjDtj6p56DnduBOJ4J8ss
	ZZhOKq8uudYjdWFiGIB6qga/t5S1PtLkFnRkCEYhgrkQKMnBwCgypodDaC7i1C3fT8nOdC1HIq3
	MzjZXMc+Gm28gFlRPz07ThKE+gAGYoXxYFB0IhksyFnb4ruNLAsqedWxeX+U6Fck/l0JUKheBkK
	UkI+jpHl20DZD1t+k=
X-Received: by 2002:a17:90b:518d:b0:3a4:e735:b39d with SMTP id
 98e67ed59e1d1-3adeb122d3bmr172533a91.64.1792783352551; Fri, 23 Oct 2026
 12:22:32 -0700 (PDT)
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
In-Reply-To: <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 15:22:21 -0400
X-Gm-Features: AclHuK_SSRm_avQLF9vquj0NeUZRfG1s170MkX5bZ8MJjhrYnJHkyeTCVdYVAmU
Message-ID: <CAM0EoMk8-wZ_aMoa91PttzWBB2_FwUpmQjrGJpa6ZjhpPqEKsg@mail.gmail.com>
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

On Fri, Oct 23, 2026 at 2:09=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > The issue:
> > > act_mpls POP can leave the inner Ethernet header in a page fragment a=
fter
> > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chained =
after
> > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > > __skb_pull().
> > >
> > > The Fix:
> > > After the pop, if the original MAC header is shorter than ETH_HLEN, p=
ull
> > > the inner Ethernet header into the linear area and drop only when
> > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when=
 the
> > > skb was not MPLS, so no separate state is needed.
> > >
> > > Conditions to recreate the bug:
> > > - egress tc filter on lo: action vlan pop_eth action mpls pop
> > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-li=
near
> > >   eth / mpls / inner-eth frame.
> > > - The inner header is in page frags; a following eth_type_trans() can=
 BUG
> > >   in __skb_pull().
> > >
> > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC=
")
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88=
e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4=
zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/act_mpls.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > --- a/net/sched/act_mpls.c
> > > +++ b/net/sched/act_mpls.c
> > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *=
skb,
> > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > >                                skb->dev && skb->dev->type =3D=3D ARPH=
RD_ETHER))
> > >                       goto drop;
> > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN)=
)
> > > +                     goto drop;
> >
> > Is this first condition needed?
> >
>
> That was me conjecturing from Eric saying in v1 "...the check can only
> matter when the original MAC header is short.."
> Since i have to send a v3 (Thanks Eric;->) I will remove it
>
> > More importantly, can it hide a bug?
> >
>
> What kind of bug?

Lol - never mind, stoopid question.

cheers,
jamal
