Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792778987;
	b=CnjMKB0im9lRAB6nERFfWM1iJSyRtFMLPNJN0aavTi1Rb+VVHyPG11vkgrzC/gfB0ZaH
	 veBVTjup+yyL92Yb0x6d/igWCTcUy+GI1DT6JvzfqxDBbvfxcMczVbWENe8rZEmfI5JOP
	 jakojzD78XQRlVJcbqWSOzuvth6ef8E99cZ52/D1KyKUq9WVyjwVg7NAuX+o4DwaW6AQp
	 5qOK6p/IOvnvs1CEnA55J7M5s1N1Aau8RUq52FQCk0rSASwsOtjh1mQMvd99q0lWGZWDw
	 RodiUZB4gQDQjT88BsmbmLFve4rOXh3ENwb+ZVqkF/DIcpwz1C64U7DKJCZ/9qBARxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
	b=x35+jOyuzpKKDqc9kK/JMIiTHXcSlRDd0N7KdY4yNgQ13YBTgyt8etGLNWfxSQDp0XyZ
	 g3wrLMIHFvi+dsMNQpzsRTKTpESZDzdhELzznvBudM2K3qhy5cXkRPu4nCtIZnSJXDyTr
	 iAnqwhuuDITITDXsRdQ0ko0YEbFqxFoaN6cSxYas0n9I5/6K99e1wGG3OgOt2Uq8VNyOy
	 ps3VrN2aYb+4xsvIeesSYDU2rIpgBipfcwlY8zqSyJsWRYcB0x6zfWgHvwIhuSyOkzJir
	 1ECfiRskJAdFxA8l4DveiJ4D2zl9KoR2CnrIXxGeIZO9HlOa8MMsTB+JMKz1HALWmjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tZOD+mWP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7D606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tZOD+mWP
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a31c892a1fso224706b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792778986; cv=none;
        d=google.com; s=arc-20260327;
        b=fjZSNKuhZ8oiYnfzUKof2c8Y+unRsE983Pnkg8R7SD/9Tdjf7AtZ9S57+UjtPsS1Ht
         jbGY8UV8dwd7kBNpET3/08z/4+RQqgRpM2Cz1PgmtH6snsZN9lnW7aYoAwcMHEqI+6KX
         w+ofxWjHSndQrdake5sc7vY5WegveHImNMIPbT8nqbMqWUNEgXwF6ZRVAZ/x6XnDB9ty
         n6wAQmhk1NVSN9q7VGRsff3HCas2qo8UxXh2lX5htBpW+4a6TgA4DP0ZQhb/IYXV0FmD
         0nfB3ZqHH46Thsf8VoRIxOD6JVevhs/Jtz9SALGw00jRR0PQxjHXDDuk0ciqMFKzDNe7
         EzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=VRulJClixChNeaq2ut7e++TW7L9EPVHWH8YtbqsbGCjkl22MbjONR83NRV/JQKsS34
         5tvvslOF78UZWYL8K4+3yhSgWWA+08X4pfu+c+lJnD/FqNx1y2cQac16HewblPrcMW4p
         sHipqZ9RMRRKHg3Iaoowuqc1njbsgOKXLgOAUfCspunDu5ooKKxUWGdDKZI9rYz97G7m
         wmNzZMSii+OheFis5DxQ89BYvNltjTlsgtrgX2UKpaVMaQSPBkQR2RG6T6PS+V6Itfwd
         rJUNmRJZRAE+0Nl/ialh1hSaJSkO12TPcOPwJdxjVxseAtemPh2Bq/RFxhegfvBIuPtV
         jLGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792778986; x=1793383786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
        b=tZOD+mWP6IHNBHgc87LVL3lXwgEPXc3rr7H5srdZ+OG/y3OMMebAxdNe8j4hO/gkmg
         NRZkhY8yT3UBtypXBKaXsj82zL0qIebAHXBBUTR1VwZwvovz6u8V0M7CkaKi8nm/8khN
         4X3gpHu0AoPBSQCsf43ig5pueV2EeFJD7AME0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778986; x=1793383786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
        b=U1rCcL8JjA6PN+29q/rZXuATYIenCtUdmcgFm9hdZZPl5iBjnbndgZqzgFT3uJzase
         xsoZKIWoHyJjPe1Xv6oblVFRFLigLc+G1fuTKP+/3NSuDbxdaUE5AHcZyTJBUD802jr4
         dWwbAXcKH1w+a8M/d30v4/Kwum8HuwcDpkbODW2s3jXlFSae7f6D1Gm9EqNju4UdtJBt
         8Mdu9jiX9GV+/Jc+FBxriLbW+eyTwhSFzpcnQqWOT6c930IBs+RefGEzsoLS8kpiXPmK
         wxjbvNT5yiknPiXWrLm/3D2WKSoVq3gRsShkaL4T+KljwkoOiL1ZdCG/sRwb+waP2CY5
         VDeQ==
X-Gm-Message-State: AFq9FYKQFeR7vgbqKdXEzAvnGYYOg2+Bu2JxW+NoiRIPjMY7WNY/tmQ5
	rVWxj6ADO3LpokygVPXmCEmFJN5N7C0uNI3cw0PMaigji2TcGvMJXBiGI/94y8arivDc4dNTIsJ
	ALh++7FKNwe7acy0WrbLQe7RdnXVeawf499vukYR7
X-Gm-Gg: AYBFou1l2lmT/+S1eCElkfhBKLYr2H5UTt3/QWRP+4pfBlRXBuBanrR0tQMbNAc9VM2
	JL1faF+YCTis6X6M5Lvg2ZRx21zPjTgFp/XDDd0IiXEi4kSSTS9wsZ479sZDuUvZSod2wkIdkbx
	aOvdn5gQ6Mu8xAuaV/sWH/ZBhnyZPffV9UcBnBhOsE1Jn7qcaVWH9U36miMKIeOIBotY8Y4Jomf
	ALInLEqoZfzIEf2l66ZawYHBCs3WhKZZ5DjiVcVzHpx2OfeZqXgK22kISzqWoTEdmx1ccio7f+Q
	U7Uhar596uvyRA72BrFsPN2XxmDGFn/d7KuWyxE3ZPnIArN0II1QTlaCE4YPAsBO2ppQViDCS+g
	LOt/67Ac7BdllgKkmCEtqmlo/moinez+/AaVdvA2nqojZxKTNMSZTlmI22z0FIusO0JbnbAwIM5
	MK5a2uVz+aSAV5ucI=
X-Received: by 2002:a05:6a00:2d91:b0:89e:f8e9:205e with SMTP id
 d2e1a72fcca58-8a369072e1bmr56680b3a.40.1792778986330; Fri, 23 Oct 2026
 11:09:46 -0700 (PDT)
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
In-Reply-To: <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 14:09:35 -0400
X-Gm-Features: AclHuK8HN_xi05mcVg0MDRYHrOglk-5vDJvBmXSDY9jfeHaTyXNLXPV37NRYe9A
Message-ID: <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
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

On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > The issue:
> > act_mpls POP can leave the inner Ethernet header in a page fragment aft=
er
> > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chained af=
ter
> > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > __skb_pull().
> >
> > The Fix:
> > After the pop, if the original MAC header is shorter than ETH_HLEN, pul=
l
> > the inner Ethernet header into the linear area and drop only when
> > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when t=
he
> > skb was not MPLS, so no separate state is needed.
> >
> > Conditions to recreate the bug:
> > - egress tc filter on lo: action vlan pop_eth action mpls pop
> >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-line=
ar
> >   eth / mpls / inner-eth frame.
> > - The inner header is in page frags; a following eth_type_trans() can B=
UG
> >   in __skb_pull().
> >
> > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3=
b.1782548651.git.bronzed_45_vested@icloud.com/
> > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zP=
rGKrbB9wZknpqf1-w@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/act_mpls.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > index 4ea8b2e08c3a..5363bca892fb 100644
> > --- a/net/sched/act_mpls.c
> > +++ b/net/sched/act_mpls.c
> > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *sk=
b,
> >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> >                                skb->dev && skb->dev->type =3D=3D ARPHRD=
_ETHER))
> >                       goto drop;
> > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN))
> > +                     goto drop;
>
> Is this first condition needed?
>

That was me conjecturing from Eric saying in v1 "...the check can only
matter when the original MAC header is short.."
Since i have to send a v3 (Thanks Eric;->) I will remove it

> More importantly, can it hide a bug?
>

What kind of bug?

cheers,
jamal

> Simply running pskb_may_pull is cheap if no pull is needed.
> >               break;
> >       case TCA_MPLS_ACT_PUSH:
> >               new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_pro=
tocol(skb, true)));
> > --
> > 2.43.0
> >
> >
>
>
