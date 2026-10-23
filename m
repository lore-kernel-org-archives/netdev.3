Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795841;
	b=bIJU6Uv6ZbKcKmgI1F0aNNh0cq3FSBW9VJIWUEUhD9e5HoWtXKk6iav331VQbcWakgIQ
	 DBPxnRd/vHUUXFwLgcnwT2KvhOsSWFTAAcqq5/wqt+yIasd4Iv//2nljO2BTk8wMdaQyt
	 D74jAoFPczay/31iOjGEcuaAh7+YcrDdhITb2+X6kfv+1Hgvg/GaVSGLoLZvk9+2VyO4z
	 C8sHELcbeL/ThmoTj7Fyw2qj3XQTurz4UEEcXNAOmIIMk8WtElM4NCM2IAT3LeuGlg2/6
	 MeWsoOcAbDFqyA9GvEI/EvunpuKdnUcSvhcDYAHfMHvZHb+UHem1M1QDlD5UbCg9lfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K1kqIbMsAUnJjJAIxawXyXTN3L6ruGMn8HAjM0XC0hc=;
	b=pnt6geqOFTjPVxm2zO/p4wDoRP2OCmDShZQahLbtOanRckyrog2V52nC+7F6bx48ecHz
	 4S8ppU/jEDY3TWgyQWr4g6wfkFTPZEE0pVr9Xrf18tB8mcE0vi1s9HtrSl0ViC+eRjhVA
	 IbP4ruVZ1exu8YMK6SVit6uLGzGtbEWi+SkEDrGCxF9hJoAVh1k8y5RAiGcFZ673OqOVP
	 7HQJSAICWRAKT1MdsXbV2aUzFVE9geNofsOlWqTTA3JKV/pmQo2987nEq2V7Gu5L5rTol
	 KeZoLr88rCsCCVU7Kl7Wqz4qniSnXMa4MOwsfknHQejN0WGgv4yoptAYrfYyy4yWYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YM3hutAN;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C93606A321
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C93606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YM3hutAN
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7907f01e487so432625137.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792795840; x=1793400640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K1kqIbMsAUnJjJAIxawXyXTN3L6ruGMn8HAjM0XC0hc=;
        b=YM3hutANSZtsmRwYIVJ+5YhrU1I4fninv6v1VO29Ts+c3VTYb91Iu4xpkES7D30gOG
         uUUJpjetgTkF507g8u/kBfJGiUEBI5JGQaGYx1HsnjeJNELmloUKf+IEeu0fTYtoc+0g
         TFNQ5q4oVhcxR0apYjJbUaU2eQ+Bmd83tOticCUGP1xp0KdJVpJeAzc4TRMBqcrsjtOq
         jWYFDQflIdkMiH7LGL7tPQESE55hf+DeuH+Va0FXdXe3mHm4QE34T8lv74aOPaRmNaEQ
         OqB4X1g6zgc/tSYgMCHmsLTNMX4CbTXG7/R1ErpSrB4c37QvyoB4Zlj7qTJZz5dschhZ
         60qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795840; x=1793400640;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1kqIbMsAUnJjJAIxawXyXTN3L6ruGMn8HAjM0XC0hc=;
        b=NpFSDRxNsQYGGKArpe2wCBJR/uJkqdqQFJmdlizAvENDggpshEUW0gINLk6fxDRv4k
         UgpzS5k+MJ9+Yt8wtIizgG/tMmz4EtaMvV66FRyauOxUFpQW9fX7/AkyfZn7Bko51ChW
         c6ICyXxOG8mQ7Z85MumBvv2QOzrLMTZ/51EtTvzvVc3bXWYbPDFhX76MlwS64H/94mzL
         K4yDT7HYvlGwQ1OBry5d+1cklqvUdmW8QGWipU6ldxyWWF5/w5GY0NgxEvZF/fYpgLPl
         2iXbUO01kMeWvRxF5y7RtagnpxLT1cpwkuhM1eqnbdfDiRUcD2kdBJInkdbw75RR3/hh
         633w==
X-Gm-Message-State: AFq9FYI8MZuJaBk1f05TEOTI2aKWy3tzX/jPp8tcDea6umQrVZ5WAyiD
	kZcDeKU8/UCCefJV/NY0nsydfULbkgg/arwEOPLFMPkqMcfi13hacETd
X-Gm-Gg: AYBFou34zzZUhyEPzzRg7dA/z8z9lPlzTMXLoejJRKKDj0jvPWeIH0B6yIDSGpWBWXZ
	LubAkasyfeN1CcvCrAJT2qBl0ecsv8d4F9YEXFcxFnHcoPhu3YIklLldIOtam9tvi/cCH+/eWGO
	W5yjElNvGkEghQjuZm3EPRhRlZ83LLUn0Ov3n4Y+CLVDDzMAAknndomgk0c0lrgv4Mi7NCJD2b4
	NaFUw8yP6er/2fMR7n341XYE22Z3KHqUn2ARZh3eydKYENn+WxL4SF2nki+P709+LEU8Yy5WAfS
	bLS9KDbqeSokp3B7cvHl2qGicFt7R3DQ80Mg1oOSG7SkBD0cm6QTY1caTyilwcP6v3JW16x/QEK
	BcFyAiimscHeOjriOesJqznXgI6+DoTSK/Zr5SObzHwM3yxbQyqR0RSC3WhgHb0QcsVIJnIiNl5
	F1XXQf5kUbAngTtK8L5PnSsILtNUVWPaNimRHzIDU8VqpEicDWwbvyrjfKLDsSLRHXCV0+QqRNT
	MuU3xj8PxCkjdzb0WGdg1AiUEDewL2UrOWw1UFVKEs72Tcn3v0wRyvIjEl942uqhbRxuklxgJC0
	2IJA4cYt1X5jca4TiAPMKVgJhECeBgkcUdORiOrpn/8rZbhkaxCOIvfTnULv6HrzvncGlNnKjoG
	2hA7W84lny59PikknkFI=
X-Received: by 2002:a05:6102:370d:b0:7cc:26e4:1947 with SMTP id ada2fe7eead31-7ce5cd5c9aamr209203137.20.1792795839798;
        Fri, 23 Oct 2026 15:50:39 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e6cfb52sm886486241.2.2026.10.23.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:50:39 -0700 (PDT)
Date: Fri, 23 Oct 2026 18:50:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Jiri Pirko <jiri@resnulli.us>, 
 Victor Nogueira <victor@mojatatu.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Martin Varghese <martin.varghese@nokia.com>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Vega <vega@nebusec.ai>, 
 John Hurley <john.hurley@netronome.com>, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.30ca6285209f7@gmail.com>
In-Reply-To: <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
 <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
 <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
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

Jamal Hadi Salim wrote:
> On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > The issue:
> > > act_mpls POP can leave the inner Ethernet header in a page fragment=
 after
> > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chaine=
d after
> > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > > __skb_pull().
> > >
> > > The Fix:
> > > After the pop, if the original MAC header is shorter than ETH_HLEN,=
 pull
> > > the inner Ethernet header into the linear area and drop only when
> > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing wh=
en the
> > > skb was not MPLS, so no separate state is needed.
> > >
> > > Conditions to recreate the bug:
> > > - egress tc filter on lo: action vlan pop_eth action mpls pop
> > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-=
linear
> > >   eth / mpls / inner-eth frame.
> > > - The inner header is in page frags; a following eth_type_trans() c=
an BUG
> > >   in __skb_pull().
> > >
> > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to =
TC")
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e=
88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xi=
S4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
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
> > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff=
 *skb,
> > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > >                                skb->dev && skb->dev->type =3D=3D AR=
PHRD_ETHER))
> > >                       goto drop;
> > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLE=
N))
> > > +                     goto drop;
> >
> > Is this first condition needed?
> >
> =

> That was me conjecturing from Eric saying in v1 "...the check can only
> matter when the original MAC header is short.."
> Since i have to send a v3 (Thanks Eric;->) I will remove it
> =

> > More importantly, can it hide a bug?
> >
> =

> What kind of bug?

Two kinds. One, if original mac_len is larger, gets popped and the
resultant packet is still too short for ETH_HLEN afterwards.

But this can probably not happen, as skb_mpls_pop only pops one MPLS
tag.

What this patch tries to ensure is that the subsequent Ethernet
header is linear.

The second potential bug is this assumption that after the MPLS tag
lies an Ethernet header. Is that a valid assumption? Or could we drop
a valid packet with smaller header.

My LLM raised similar points and says it better than I could:

  1. Missing protocol check: tcf_mpls_act handles popping MPLS to arbitra=
ry inner protocols (ETH_P_IP, ETH_P_IPV6, ETH_P_MPLS_UC, ETH_P_TEB).
  Requiring ETH_HLEN (14 bytes) unconditionally when mac_len < ETH_HLEN d=
rops valid non-Ethernet packets shorter than 14 bytes (e.g. popping
  an outer label to reveal a 4-byte inner label stack entry on an L3 path=
 or after pop_eth). Pulling ETH_HLEN only applies when popping to
  Ethernet / TEB (p->tcfm_proto =3D=3D htons(ETH_P_TEB)), exactly as done=
 in patch 5 for Open vSwitch (pop_mpls).
  2. Gating on mac_len < ETH_HLEN: mac_len here is the pre-pop outer MAC =
length. pskb_may_pull is already a no-op if the linear buffer is
  sufficient; gating on pre-pop mac_len is unnecessary and risks skipping=
 the pull when mac_len >=3D ETH_HLEN even if the revealed header is in
  fragments.
  3. Downstream metadata invariant: Popping to ETH_P_TEB exposes an inner=
 Ethernet header at skb->data, but skb_mpls_pop leaves skb->mac_len
  at 0 and resets the network header to 0 (skb_network_offset(skb) =3D=3D=
 0). Downstream actions such as act_mirred (with patch 3's
  skb_network_offset(skb) < dev->min_header_len check) will treat the pac=
ket as headerless and drop it, causing regressions in L2VPN
  forwarding (tc_mpls_l2vpn.sh). When popping to TEB, the L2 MAC header b=
oundaries (mac_len and network header offset) need to be properly
  established.
  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  ### Summary of comments:

  =E2=80=A2 Patch 2/6: Missing inner protocol check (p->tcfm_proto =3D=3D=
 htons(ETH_P_TEB)) before pulling ETH_HLEN; drops non-Ethernet payloads <=
 14
  bytes.
  =E2=80=A2 Patch 2/6: Unsound pre-pop mac_len < ETH_HLEN gate.
  =E2=80=A2 Patch 2/6: Incomplete header bookkeeping (mac_len and network=
 header offset) on TEB pop breaks subsequent redirect actions (act_mirred=
).*


