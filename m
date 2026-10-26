Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007680;
	b=rM+RHzSOR3p3l4kX+BKfaMdJtdfoTnrfMWb64MlVEMgyEK0UI2l8t/I+gXATFEo9/KpK
	 +DhLKhi3/kjYEgaOXCpKvd4iGj8AVqhP0AfajNqo/2V2VYlABIZqFfKFomowhx4clh2ZF
	 KPUdSHU5sLX4PpJCpLIEmavQq8DqxnLNn2l2HiBsV0JyxCB8A9tdCiOthtwHlRLn4tAZ1
	 Ub/R0FAA3wbVVZNa+BR7CPIPb4dPRstsxVc+AAT91H/RLvuW5jHm0XEYTWFkJF0/lLJ09
	 i8X8YKbRLM/CQnegzT+T0i+qR5vkTHj8jS+uEZQP+iIeHrATWHV8nWPhPKlneQIqY6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
	b=lpyvYHXZ57aB3a6UA1HDPZowXdI8bFDdCnhBOZyGwPQ3WBJ173Dr0LArls9aVr3a1EPd
	 FTzCuEdCv1ZnagborXnJqEZOKIIBX5WCArMFJvhSHv5/UkDKakzZouORhWBZ9HVE4bGD4
	 NOmFhxDuD2MDmDL1zfgnLN30rTJo++Rt/TscvYG8oHHmp42op7YvCEIpOfoiuTj2ZFAkM
	 Hmh0tVFhG47VAIJqHpPT14aG8b+IM53KtmibIsrUnyO75P46ndauM/G9zXnNfBiwN4ZKS
	 INCkiIeAwi22YeBtHTFGTzEWqtnCZhhG/ZWnzwc2gSeDOrsEkeLRRItYpE6Qa6qRlnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ua891DVI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909360A2624
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4909360A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ua891DVI
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89ff475a152so1006540b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007679; cv=none;
        d=google.com; s=arc-20260327;
        b=sfmnW2o/LMvvUQzYpuLV3GQfbqfPSVopMEEVdXcWcrXQTLO/OTnv6EAzbknP3Z5gbo
         H/IzE121LF5wtN+E8kATP2PPI11mQd0tRgmw4ymGPvxpAuFZdzd/FAu09DXX3jOfBSM4
         CJp44aSv5Yz3q8OkVCU4TuGSqHUfEFtr53HrTl53y5Puh9hS9FJdGYiUDpDAktcZD7uf
         D1BOS+OKovicNYAw9RaObqRyFY0P98Rmp0LMUe/S0M+0i3uTHpXCGi8dIJTuHNHtAtxI
         JToB60lAJR+1+1eReSFt3ubAepf7QPsQA1jbyOY3jNS1NaiT2WvdwdDfFcuZuCkNHIJd
         2RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=l6hxWZGgWYIfrB46YRkXSZ1hEXrnsdTUr+XO9+oQaz+c0Tx8yb8/PwPvrnu4MfVsnH
         3kuPVCceqmz7nj2O0Bz2CArPggmL9aJ+/oovfOX92YeGB+W2AAl0qShXp//6vYX79EEN
         t3qkAyQA+qY6Xe2iqigdUYAKqihKDe23nNw3sU57Dtc+oQSN6OPZ/EgSm/qUgU/5hyE3
         2S+PgPDJEyXhb8Bwli4+4Z6w931IHR4P1u+2DUP4RvsdBcbuZq9i6JF2eCxPBIXHjm7E
         PST2OKz392nIzcFGxG2v8sNDJujPhNIdxylVHAWSpzaWZH8MlmSgkekhczgaOCGjtpKr
         7DMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793007679; x=1793612479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
        b=ua891DVI/vtebzFUMuYOmcWft3UELTZZSw3AaMRCcrLZznkX8LdQoBSfiOfHcwf3RB
         5x5HkF4Wqplv4R+QezQHIdzf9xHekp+YHj1p8PhHjw7cjK3Bpt6nPAuHNH6/GQPVuXcE
         9NNIsF9pnRwYw06uFCLr1YqezvT3/FR1FxtZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007679; x=1793612479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39E6vW6/aAvA+MOoCKzNKPwKqzjWsVvMXH1IH4y+mQk=;
        b=jIKLyIboYC1UmnHpIRFeyRMHIwl1PTC5a7t62UYoBTJ2QRyryhBjAseccQd9ZZYNnh
         6lqtYIRWc1O+FE6RJU/Cn8WKeCIIDleXSPTXqbN7yzZLGumnObxtmHEBF5iSvsToe9yF
         H2V0v05DbWVWWV6PkmYeuMy70SJAfAztV+IBAdjnjeS31WqQKSCAic3waHA8b0pmyYIe
         ebJGmpfoJCeEs8keYrNoXE1CHCCH/VZJpjOwX2TzQbKoVe418fxeLvmyDTat/jhxYppq
         /4lxgvlKJN8PGwv12QBncBP0Ua2Dfty/Z80Pj/zceyPuZ+8zJLqUcDpqeAS9thAg8Ocg
         d4gA==
X-Gm-Message-State: AFq9FYKDrHQZhnx5ZMz+VZ64Bv2qOZXWnBddf73G4RN4WO4jX/kImJTx
	fospUBELURdbgfK+hIDJXhinheReE0uCAiiVUQBWMXkJUXZyab1foLLQYZCRAgGJBhvRT9OXtYr
	A6Ebly1y/KjJEXKIQigwHqjW81iZKpl7nXleAGt8P
X-Gm-Gg: AYBFou1Yb+pLwR9GwJRGtrg6uKDghqeFut1/ljywUGFhVf1tUX21v9hILoWalMwKUvA
	rVqA5yAUTex0UdoCn4APw469HN2nKej/4UgDsB7egsVMktXo2aczxpZ3XJ73gyDjlWGTMrCzesd
	jeRyD2LCj9yzqGYfr8pkylU1KGHwYoBFDpj9h6qM9JyqfxYFVGS2jlOIjv3Hy1XaWY8+6upLWhU
	j0dr1hTFIqfK1AbaKrFC2wfGUVOaolwX9Qaz8hJjmJSr9nMYDzqqlu+ssH02Lqn2lv2zpxrdOqU
	7bUYknEppj/aNZyOgzXIKiMYg4yV7Wli1Cpo4GnmRzuh6206tsFxg9mlrwPfUc1DiYRmYyAPCZB
	zQhiH3MRcKvS24iAUma/BzrH+j3QnK+CWoVN8Vl8pknZL5PbLiPBWMXmVnil7QvapL9dwBmguLz
	ULu/b4+LRhyIWTMdY=
X-Received: by 2002:a05:6a21:880d:b0:3e2:8c23:5d35 with SMTP id
 adf61e73a8af0-3e7a1b8a544mr3717353637.0.1793007679641; Mon, 26 Oct 2026
 02:41:19 -0700 (PDT)
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
 <CAM0EoMnj7pkfGUg=VFjpbU7AGw7ysD_tQOeuUu==YEc9rfQJ0w@mail.gmail.com>
 <CAM0EoMmEuj+k4HXOD08rdtS8+aD-8oTWFedED2kt5XfBR8=V3Q@mail.gmail.com> <CAM0EoMkvAgc6+HNsTUrYZ1RHqRrr5Z2vzJkWsz03jMt6NVcEpQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkvAgc6+HNsTUrYZ1RHqRrr5Z2vzJkWsz03jMt6NVcEpQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 05:41:08 -0400
X-Gm-Features: AclHuK-S6M5HVrCrcktozs8lmc6x1ni0POvowYyPX-T1Tv2bgs8iy1Y_kr9wG_c
Message-ID: <CAM0EoM=t0zL+QDKaEJRhzK38XdpwkimsYgoc8p4SF7dFo3fOjg@mail.gmail.com>
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

On Sun, Oct 25, 2026 at 4:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Oct 25, 2026 at 3:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sun, Oct 25, 2026 at 3:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Sun, Oct 25, 2026 at 4:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Sat, Oct 24, 2026 at 12:14=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jamal Hadi Salim wrote:
> > > > > > On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@m=
ojatatu.com> wrote:
> > > > > > >
> > > > > > > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > > > > The issue:
> > > > > > > > > > > act_mpls POP can leave the inner Ethernet header in a=
 page fragment after
> > > > > > > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=
=3D 0) or chained after
> > > > > > > > > > > act_vlan POP_ETH.  A following eth_type_trans() can t=
hen BUG in
> > > > > > > > > > > __skb_pull().
> > > > > > > > > > >
> > > > > > > > > > > The Fix:
> > > > > > > > > > > After the pop, if the original MAC header is shorter =
than ETH_HLEN, pull
> > > > > > > > > > > the inner Ethernet header into the linear area and dr=
op only when
> > > > > > > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() d=
oes nothing when the
> > > > > > > > > > > skb was not MPLS, so no separate state is needed.
> > > > > > > > > > >
> > > > > > > > > > > Conditions to recreate the bug:
> > > > > > > > > > > - egress tc filter on lo: action vlan pop_eth action =
mpls pop
> > > > > > > > > > >   (chained), or on an L3 device where mac_len =3D=3D =
0.
> > > > > > > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D=
28, and a non-linear
> > > > > > > > > > >   eth / mpls / inner-eth frame.
> > > > > > > > > > > - The inner header is in page frags; a following eth_=
type_trans() can BUG
> > > > > > > > > > >   in __skb_pull().
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulati=
on actions to TC")
> > > > > > > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9=
271c0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYee=
W0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel=
@gmail.com>
> > > > > > > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpl=
s.c
> > > > > > > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > > > > > > --- a/net/sched/act_mpls.c
> > > > > > > > > > > +++ b/net/sched/act_mpls.c
> > > > > > > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(=
struct sk_buff *skb,
> > > > > > > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, ma=
c_len,
> > > > > > > > > > >                                skb->dev && skb->dev->=
type =3D=3D ARPHRD_ETHER))
> > > > > > > > > > >                       goto drop;
> > > > > > > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pul=
l(skb, ETH_HLEN))
> > > > > > > > > > > +                     goto drop;
> > > > > > > > > >
> > > > > > > > > > Is this first condition needed?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > That was me conjecturing from Eric saying in v1 "...the c=
heck can only
> > > > > > > > > matter when the original MAC header is short.."
> > > > > > > > > Since i have to send a v3 (Thanks Eric;->) I will remove =
it
> > > > > > > > >
> > > > > > > > > > More importantly, can it hide a bug?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > What kind of bug?
> > > > > > > >
> > > > > > > > Two kinds. One, if original mac_len is larger, gets popped =
and the
> > > > > > > > resultant packet is still too short for ETH_HLEN afterwards=
.
> > > > > > > >
> > > > > > > > But this can probably not happen, as skb_mpls_pop only pops=
 one MPLS
> > > > > > > > tag.
> > > > > > > >
> > > > > > > > What this patch tries to ensure is that the subsequent Ethe=
rnet
> > > > > > > > header is linear.
> > > > > > > >
> > > > > > > > The second potential bug is this assumption that after the =
MPLS tag
> > > > > > > > lies an Ethernet header. Is that a valid assumption? Or cou=
ld we drop
> > > > > > > > a valid packet with smaller header.
> > > > > > > >
> > > > > > >
> > > > > > > tbh, I was thinking more about skb frags earlier.
> > > > > > > You are right only ETH_P_TEB promises an inner Ethernet heade=
r; for
> > > > > > > other inner protocols the pull is wrong, so I=E2=80=99ll chec=
k for
> > > > > > > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this chec=
k in the
> > > > > > > current fix - good you responded before i sent out.
> > > > > > >
> > > > > > > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > > > > > > pskb_may_pull(ETH_HLEN). A brute approach is also to check fo=
r TEB:
> > > > > > >
> > > > > > >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may=
_pull(skb, ETH_HLEN))
> > > > > > >                 goto drop;
> > > > > > >
> > > > > > > Note: skb_eth_pop() only removes the outer ethernet header bu=
t does
> > > > > > > not change skb->protocol
> > > > > > >
> > > > > >
> > > > > > I am going to send it without this 1/6 change - it just doesn't=
 feel
> > > > > > like good taste. I will add a comment in the changes to say i
> > > > > > considered it but decided not to. I also spent time eyeballing =
the
> > > > > > code, i dont think there's a potential way to craft a packet th=
at will
> > > > > > hit the perceived issue. In any case the 24 hour embargo lifts =
in a
> > > > > > few hours so i am not posting yet.
> > > > > >
> > > > > > cheers,
> > > > > > jamal
> > > > > >
> > > > > > > thoughts?
> > > > >
> > > > > I'm actually a little confused why the tc layer has to anticipate=
 the
> > > > > needs of downstream code and pull headers here.
> > > > >
> > > > > That directly lead to this guessing of what may be the next heade=
r,
> > > > > such as Ethernet. Which may often be correct, but not always.
> > > > >
> > > > > All protocol parsing code itself should already be robust and cal=
l
> > > > > pskb_may_pull where it is needed. Sounds like there are some targ=
ets
> > > > > post TC where that is not true *and* we think there are too many =
to
> > > > > update those targets directly, rather than this transformation lo=
gic
> > > > > that exposes them to unpulled packets?
> > > >
> > > > Not "too many updates" rather the main motivation here (which i kin=
da
> > > > empathize with) is pushback from Eric that you have to "fix at the
> > > > producer" to avoid performance degradation at the "consumer". i.e
> > > > rather fix the vlan action than have loopback vet as in the origina=
l
> > > > patch  (and you just witnessed him stand up and push back on tun fo=
r
> > > > that same reason ;->).
> > > > IOW, we are anticipating so that eth type transfer doesnt bug out
> > > > (_for ethernet headers_) when invoked at the downstream consumer
> > > > (loopback etc). Essentially it is a game of whack-a-mole until the
> > > > next bug or malicious use shows up.
> > > > Generally, policing intoxicated drivers from getting on the autobah=
n
> > > > isn't the best philosophy; it's better to complement that with a
> > > > "driver beware, you may encounter drunks" warning but that would sl=
ow
> > > > down the fast car on the autobahn ;->
> > >
> > > Actually the more i think about this the more i am concluding just
> > > fixing the producers wont be sufficient (Eric!).
> > > If i have an incompetent or malicious ebpf program it could do
> > > whatever it wants.. I am going to try something with ebpf.
> >
> > And the reason i am bringing up ebpf is because i noticed sashikos
> > after like several iterations of a patch find a way to sneak in some
> > ebpf corner case. So i am sure that is coming (if indeed an issue can
> > be reproduced)
>
> confirmed.
>
>     #include <linux/bpf.h>
>     #include <linux/pkt_cls.h>
>     #define SEC(NAME) __attribute__((section(NAME), used))
>     static long (*bpf_skb_adjust_room)(void *skb, __s32 len_diff,
>                                        __u32 mode, __u64 flags) =3D
>             (void *)BPF_FUNC_skb_adjust_room;
>     SEC("action")
>     int shrink(struct __sk_buff *skb)
>     {
>             bpf_skb_adjust_room(skb, -1, BPF_ADJ_ROOM_MAC, 0);
>             return TC_ACT_OK;
>     }
>     char _license[] SEC("license") =3D "GPL";
>
>
>  ip link set lo up
>     tc qdisc add dev lo clsact
>     tc filter add dev lo egress matchall \
>         action vlan pop_eth pipe \
>         action bpf object-file /mnt/shrink.o section action
>
> tc filter show
>
>     action order 1: vlan  pop_eth pipe
>     action order 2: bpf shrink.o:[action] ... jited default-action pipe
>
> And boom:
>     [    6.748140] kernel BUG at ./include/linux/skbuff.h:2830!
>     [    6.748154] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>     [    6.749434] CPU: 1 UID: 0 PID: 301 Comm: mini_poc Not tainted
> 7.3.0-rc7+ #271 PREEMPT(full)
>     [    6.750115] RIP: 0010:eth_type_trans+0x335/0x500
>     ...
>     [    6.757723]  loopback_xmit+0x1c1/0x580
>     ...
>     [    6.778076] Kernel panic - not syncing: Fatal exception in interru=
pt
>
> Eric, any ideas?
>

And worse, i just tested a non ethernet next header for mpls (the TEB
check is a bad idea) and it killed the kernel as well:

tc filter add dev lo egress protocol all flower action vlan pop_eth
pipe action mpls pop protocol ip pipe action  gact pass
BUG at include/linux/skbuff.h:2830 in eth_type_trans  via loopback_xmit

I am going to withdraw this series - lets reach some consensus first.

cheers,
jamal
> cheers,
> jamal
