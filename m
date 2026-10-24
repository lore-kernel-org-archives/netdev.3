Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792835685;
	b=RDj+qZdFYurOeWZXy0hxRYAnU14IPRsCdqvzW/fbZ8TBez9Ns73rj7MHwqrHs9Anp7HA
	 4WTiAQ68QmvyLoXE6eJ9ic7wCfmeQtzqMLqWLaEKiNOYlCeOuBKtr74EticL5d8WOeTHv
	 L5ObnBjzCX0yAT9psLoOXsXDZUlzYL138Kqa2GDYrOHCRgrhCQklttrvZ+NqojntrC5Xr
	 Or87TTOvQA/Heh51MZsjcz2sIEMQ+bDoDoqujIMdSdGBKGZuykUBXMjoiHZ2gHHx7e36r
	 gSHIHmW3wa+gTNbmjkWyiF5ZO4dPblXjvgP5IJlqiRzINDAZIHuoeelC8LHaZZoLh0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
	b=g481kFb1sdVnVqmvOCMVCJaHCiNX+3xy5nyd87tRpNhBDssnhMMI4izFPvrsnlwvqRMX
	 d7Z+bTDmGY7EN5nzEriot04tZXiZN0EOidAUhvCL1xSVJUSUHPs4k3Hos3C86ehkW8I6F
	 HjihQ3Lx/+h1yaIqPlCWbC2oOzx0H0wz514HrYatk08+Db6vMXSbhBl6fc38JMiSATY8g
	 zOHLiq2dLOMq5j7I6Hu8AaiKxvjt9GHq22hOkcigxy13Rz9yKsoue3L/IDSjEOb7IGGPf
	 jE9WA3nR/et1sye1SqZ6lZcO5Znoh+qoIFWaQh8eKdERD/cBMgNa+tLucMOSd1RHbzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xYuLJUtj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A1606A31D
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 09:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792A1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xYuLJUtj
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso855930a12.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 02:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792835684; cv=none;
        d=google.com; s=arc-20260327;
        b=oVWop2UjJFFqmk86inGFohlynxCEOZZ0BuT2LcWKqDDvzb9Dd2ZaIwoqXxuCaZPM7C
         tk71jOav0iYJ4W1MkCK1zEwBMInws8a9zc1AMwsKI+7ERt3vgS8hWptjvK+WwVIm6f2w
         IQ/kGaq69p0aUSPk9I4I3keJVH22t/jDrEp99RTiXxpUyJpkKjiv2pfJXR3+1XTt//FX
         6fDdurFeoWBL0Y+LiBFf6ubwEcSQRh72SGzMktpvMoKye/VYHBXVjVg6eOrYQWJ577Kg
         3QqGmum8iy+0tDTOHXD1xp2dKXnUoKbihJPMAlcaV7RYjZAIdaCcjxA9U5MqOdArZCEL
         A58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=s9eIQEbnPkMdOgNevFhptc0M1hEU9CKdVYqfwgPbq5tG5jf5hFh5fD2ZRQ9SbtU1Uk
         5MuprCyrG0rSSIvO8f1XzUI//EzTvmfJuOrA/Cluah/wl5b8G/wJt+t5Ew506H1LX7fD
         7hAekGVZNsv4IKcC8uY2DFkRPsc4BtV6gn2LueRwBLaLrl/FOLFuHgjphqS8OBcpxP+S
         Qke1T8vh8bAQQpZXgUqXcaSzFXRxgKh50P44JORSORI1dSULZTaT5h41UuYDKPrptB6x
         F98FyahwQqfjOJudadLY6Lz/8cRXtCds1RWK77a1DPGwzfE6T6Udn9wfqmSulQejqTkW
         wM7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792835684; x=1793440484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
        b=xYuLJUtjK7ChZW8JwqJRH//MAhrs4S+v2TQtv/Lhw8WgAaK7+KSJumkA3m+X5PiId6
         uExYt+M9I+AQu1K306CriByd9pLvjJBxsXxWOpIBkKJkscDxEuWG3jvUZuD4qfMr5qIk
         VoW5emT13A6ywa2xvsda9FgrnmkgBR7lbybCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792835684; x=1793440484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSHUqM6sVNj4KA+FGbxHG4caWaVLve4l4npIRz/orKk=;
        b=zzAQve9StckvnKC4E7q5biotha2elHbP8mMaHF/CELvOVusZtNhSGEvWVbkNtuaBj4
         5Tj2ZU2pxaL560rgY9skVW+F91sKy4rG7a9DI3Z+KxR9VgMKCpi7a5RZTvQm6yEz8UoQ
         WtQyiGNnEVbl1vc0bP69Mke8wA0845z7Dwo9BmcckkG67jPBEiSAUl+WErYQmh7MfPtM
         vu+xRR+MuD2ZBxnKOH0SX0b5sedNKhGmjDBCvhr5b1701Skpu8rQDciexIPdu1sZg7VL
         G5cHTOes2PsBBJsqCHH7mhJ9j3xiigepZ+sLiFVar7B33wVcjlDFBITKLh2GOXT0XPVk
         ycPQ==
X-Gm-Message-State: AFq9FYJY//JOrY8rRuR79Zu6UaAQa3iWdLa2vofK33ZxHBvD7E7lggy3
	VsUZ1XH+9QzERHrt7T06SIUXpNPwe/SDpVEP5SIZaLfM+UDG7vdICIuicgHR0RMEQ2iZLZWe+v0
	ARPR9jUhSu/xdrn/7jAf65TnYTJjaPRVw8Xk0+38c
X-Gm-Gg: AYBFou2IbUdiYxQroA6N4TduGF6JFzqbZKjZZU+Z+bZtfKiTlqalWgkVe/LmkKOSN3T
	5Vn1SwpHEoZuriaHQTDaoe/HlcxQku5DH9Q2gsmZMRbdYDUVm4EtPDfUdfJKBJ1i/k9K9+MJsYg
	5WPbuRtYF72PGOy7nZslsREuEp7qrvxtS7vY/FNlM2FB6MWW86SJPfHLUJXa+gCmG0s7ZQMXRoe
	jSBCXo8aM4jt27kegOuUHiaZjJxfG7cXESCLOwzxDkhyTufVRUSfmB9L1AHw6dPEQiIHfrD+0Fy
	f2auTKeROJhtVvHZQDOitK3+B3AlDf64F9njva/kJLmy1r0FEwHoPVFm6hn3UhEf+2YjFfRVO43
	o1cDgOt12F32Ez4TlfKnOGY6YIrTsbL/40A2DUHro74jlL8cqHH5JtUWhCCSOlMJW0idDQbFy5Y
	Kh93+0+IWMcwUNk0Q=
X-Received: by 2002:a17:90b:57cd:b0:3ab:884b:65a9 with SMTP id
 98e67ed59e1d1-3adeae9c162mr1503965a91.25.1792835683692; Sat, 24 Oct 2026
 02:54:43 -0700 (PDT)
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
In-Reply-To: <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 24 Oct 2026 05:54:32 -0400
X-Gm-Features: AclHuK8x6YsYN68U8TrqczucCZRfN0vZR36J_wmmtKQG0gjq4OLQPKHjLwQKBEk
Message-ID: <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com>
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

On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jamal Hadi Salim wrote:
> > > > > The issue:
> > > > > act_mpls POP can leave the inner Ethernet header in a page fragme=
nt after
> > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chai=
ned after
> > > > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > > > > __skb_pull().
> > > > >
> > > > > The Fix:
> > > > > After the pop, if the original MAC header is shorter than ETH_HLE=
N, pull
> > > > > the inner Ethernet header into the linear area and drop only when
> > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing =
when the
> > > > > skb was not MPLS, so no separate state is needed.
> > > > >
> > > > > Conditions to recreate the bug:
> > > > > - egress tc filter on lo: action vlan pop_eth action mpls pop
> > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a no=
n-linear
> > > > >   eth / mpls / inner-eth frame.
> > > > > - The inner header is in page frags; a following eth_type_trans()=
 can BUG
> > > > >   in __skb_pull().
> > > > >
> > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions t=
o TC")
> > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb=
7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4=
xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > Cc: stable@vger.kernel.org
> > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > ---
> > > > >  net/sched/act_mpls.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > --- a/net/sched/act_mpls.c
> > > > > +++ b/net/sched/act_mpls.c
> > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_bu=
ff *skb,
> > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > > >                                skb->dev && skb->dev->type =3D=3D =
ARPHRD_ETHER))
> > > > >                       goto drop;
> > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_H=
LEN))
> > > > > +                     goto drop;
> > > >
> > > > Is this first condition needed?
> > > >
> > >
> > > That was me conjecturing from Eric saying in v1 "...the check can onl=
y
> > > matter when the original MAC header is short.."
> > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > >
> > > > More importantly, can it hide a bug?
> > > >
> > >
> > > What kind of bug?
> >
> > Two kinds. One, if original mac_len is larger, gets popped and the
> > resultant packet is still too short for ETH_HLEN afterwards.
> >
> > But this can probably not happen, as skb_mpls_pop only pops one MPLS
> > tag.
> >
> > What this patch tries to ensure is that the subsequent Ethernet
> > header is linear.
> >
> > The second potential bug is this assumption that after the MPLS tag
> > lies an Ethernet header. Is that a valid assumption? Or could we drop
> > a valid packet with smaller header.
> >
>
> tbh, I was thinking more about skb frags earlier.
> You are right only ETH_P_TEB promises an inner Ethernet header; for
> other inner protocols the pull is wrong, so I=E2=80=99ll check for
> p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in the
> current fix - good you responded before i sent out.
>
> 1/6 (act_vlan POP_ETH) has a similar unconditional
> pskb_may_pull(ETH_HLEN). A brute approach is also to check for TEB:
>
>       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pull(skb, E=
TH_HLEN))
>                 goto drop;
>
> Note: skb_eth_pop() only removes the outer ethernet header but does
> not change skb->protocol
>

I am going to send it without this 1/6 change - it just doesn't feel
like good taste. I will add a comment in the changes to say i
considered it but decided not to. I also spent time eyeballing the
code, i dont think there's a potential way to craft a packet that will
hit the perceived issue. In any case the 24 hour embargo lifts in a
few hours so i am not posting yet.

cheers,
jamal

> thoughts?
>
> cheers,
> jamal
>
> > My LLM raised similar points and says it better than I could:
> >
> >   1. Missing protocol check: tcf_mpls_act handles popping MPLS to arbit=
rary inner protocols (ETH_P_IP, ETH_P_IPV6, ETH_P_MPLS_UC, ETH_P_TEB).
> >   Requiring ETH_HLEN (14 bytes) unconditionally when mac_len < ETH_HLEN=
 drops valid non-Ethernet packets shorter than 14 bytes (e.g. popping
> >   an outer label to reveal a 4-byte inner label stack entry on an L3 pa=
th or after pop_eth). Pulling ETH_HLEN only applies when popping to
> >   Ethernet / TEB (p->tcfm_proto =3D=3D htons(ETH_P_TEB)), exactly as do=
ne in patch 5 for Open vSwitch (pop_mpls).
> >   2. Gating on mac_len < ETH_HLEN: mac_len here is the pre-pop outer MA=
C length. pskb_may_pull is already a no-op if the linear buffer is
> >   sufficient; gating on pre-pop mac_len is unnecessary and risks skippi=
ng the pull when mac_len >=3D ETH_HLEN even if the revealed header is in
> >   fragments.
> >   3. Downstream metadata invariant: Popping to ETH_P_TEB exposes an inn=
er Ethernet header at skb->data, but skb_mpls_pop leaves skb->mac_len
> >   at 0 and resets the network header to 0 (skb_network_offset(skb) =3D=
=3D 0). Downstream actions such as act_mirred (with patch 3's
> >   skb_network_offset(skb) < dev->min_header_len check) will treat the p=
acket as headerless and drop it, causing regressions in L2VPN
> >   forwarding (tc_mpls_l2vpn.sh). When popping to TEB, the L2 MAC header=
 boundaries (mac_len and network header offset) need to be properly
> >   established.
> >   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> >   ### Summary of comments:
> >
> >   =E2=80=A2 Patch 2/6: Missing inner protocol check (p->tcfm_proto =3D=
=3D htons(ETH_P_TEB)) before pulling ETH_HLEN; drops non-Ethernet payloads =
< 14
> >   bytes.
> >   =E2=80=A2 Patch 2/6: Unsound pre-pop mac_len < ETH_HLEN gate.
> >   =E2=80=A2 Patch 2/6: Incomplete header bookkeeping (mac_len and netwo=
rk header offset) on TEB pop breaks subsequent redirect actions (act_mirred=
).*
> >
> >
