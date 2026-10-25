Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792918568;
	b=KrRGXwbNvRYtz3t7PNn7Vi0tTaicQkwhF5W8NvNO8sNBlH3KARRKC9B/pz/O5WYg/+Ub
	 vRySyj9x3R+7SQR1Z+iX/+RefSP3+dlaxGkQDLrWAXUICfPFapXffSCal0upTmhecJnV1
	 vym13CK7Q3FxZuDMAI7C/mtAiBGJsk4ZGrZr4rL1IL5gySo58fkLphG0gKV6d0Og55B1f
	 3cHXTnid0BWpLSNyvdyH5MdVKhJNsmJWLLWJBv6Xt7haE5zxQtUiU2D3OvjK9Y++uUq5f
	 txBlzRMNXtXu38CLw3YjXw0ykGlAdKJSdP2j94l9CX7qaTaLlFMKSXtbIMX9f+hvpiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
	b=x9E3Nt9dHZElleiDtbWktdedmUrF2lJxjlskXUa/QcsM5rhYlNIkAVYhRRF0ntSRqqcA
	 kTiojTLv9HWKQMv3LwN/qAhH4y3fVsw7ZKValiH/ZDLKLJR22OYggDryxD1TTK737esFW
	 pZcxB/ymk+75vOeD/4g+eyApUNz7+qHD2jplff6/jowMPu5iqjylWV2NYOGIWwCedGb5w
	 u200NLwJdzYeXqEwBk5yF8tW44IaYt6cqqrfVmB/GeZrYT+ang3UmYzwpZ6gwOckb9xMx
	 /UKFz7ol78hLOYC+oiRbYbfyLLCEd9uSKtFdzoxwVM3CrtRM5dq17fWcrbVueREMjWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mi05lP3G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C76606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 08:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mi05lP3G
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so1501815b3a.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 01:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792918567; cv=none;
        d=google.com; s=arc-20260327;
        b=dSRu2AQaYTKniopVlfkEELN9Yy6h0ipifLqGNFT8+fVWXsy7A5bNmdyHe0ZzwS4eNV
         ecyx7YltlJTzpgw3w2fgJ2qF2UC4VtJycd9Inbp1/DgZfanNOVJxV3CJHZCXo7vksjr2
         vNd5MPgyp/uxtOszcXWsu5qOmItTkad+g1jer68TfHwqkOnbJNTsmK0YMcD8x9go9GbK
         Mna4d7MqkkOk67ArY2DttzWHNBhtIEt8USZGaI/R0/wt+RtLy9JAV6Z/hcUsU3PKyuZR
         dinPr0hY6EDLHABH5WaRlALwerVFDShybUEiVHip3tc+VgbIun98xYqfxEeuOBHs81k+
         xlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=dW/KpCtKbKgwvl22tH8I19zlfbwyOvczDKz7ties8uq3h8YIrLFPNGbQcxV45RSmzX
         hk1Uzx42Jr6noyJl8bmG+RavMg2q0QsbZSLn3Adpv/hrqn2kYtXTQyC9I0CNjsHMKSJ/
         3ZgfV3XjNwDO6E3RsyosfCOdjyP5lJYgGQg1Js7UWO6xu/VvuuBbS+Q4WfaQ3SnCfhLl
         IFMzct79D8exv2MEV7IFUsiDRvZ+wHJYZl7fE+lrI+ghzwd2mDv6HYlkJGotBej3sJmI
         blZT9pjHGnGBII5KdPSbJGTIyYk18523sfjrqV2pF3oMqbR3hxLMVZ28lBkvMeET4I7k
         8UqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792918567; x=1793523367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
        b=mi05lP3GpYLdTOXHFSZx440AR9EZif9K/sR71vpfrZw10gO003EZpj7eZM8pCSuEMI
         CdEvSp55VnFp0RdnW1Eg60KgDqkRdse3OjAlE4f6yTRy8XS2grhxxmqqj+/FOxHJyy1k
         RiqFqc2/k9qOfnk18SGgMoyDle5frgqKr2O9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918567; x=1793523367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
        b=HySG0wahpPBdDdFUkWbarfOAxlwqr397Ug6twD7PQoVSYu8j7Dm/9N2F1SgUwgcDKH
         1tjOWLz1QW0NhqSREKxVibNXwkWAgjTNbgIRRvlb/WoUpLlN2Jhl5NOWeV3NMELibRSu
         o1enySEQeg1XnAWKs32VYe6Z0Y7BQv+kWaLAHJ4Dxp1bRW0vOYTB6oD4jTEVfiQ5O+Iq
         CIM8Tc9nZCzSiJ1am6RDO18OyVpoGq+S1vZ5sAKspo8op3zyCs/1FjciyIRHlay7Uvp6
         0AtLvbBBtHlsGP0Yebn20l4a8EtIQEnJGKh0RFaVFeX0qv7AEY0dP8V1zMhFbKRCZkxZ
         VLwg==
X-Gm-Message-State: AFq9FYJ3oY2of8ITPJeRdHW4yj22KuPsV2JMaGt5Nh/8updOrjD02pzu
	KVVMtm/0VUgfqy/RWRr67r6uPZ+HiE6kQa7dUYWWuslj1E+vlnXS8YRXiA3V/rTiKytlrD26bi8
	kwfNifSyP8aP8fbyTDqUPvp0nvLrc4LvDQ1i17d8l
X-Gm-Gg: AYBFou0eYJqvTnoT64gnr2v2Ha3WfdqDbpE1CakNIxbaSJ4+EJhxPIuhdvtPgl8fdtg
	xHStkc5g/jUdzMUzJtAQGSrY0OrAP2/fDphZvTMpQkqDoY2dorHk3fxiK5ueol8pSbDooB1mHTV
	fgZhDbK8Pie0yi1poC9/A3mNygia68/W4u4z79pWDDw20jVlfpUWi6jX0X5qhv/UCAyRjjeyFqH
	vt2UOjPW1cTSKkrAE5X7GJKfS3RoBteoaAseK1eYR9mEKJyHXXr6Tc4baVZU3+prHJgmtwWdCXD
	/7cpfXif31ILwX+AWms23X2CyHAQPzGBcsCXuz7eLEpUH6MnblOVfcMIWolKA7ZbnXvHiGulXVB
	OckGEkIvDYWek54g51feF+yCDvXftokwp4tI6xT7MuE4kIRyjZybrz2rAuILjyNqOEh1gNdbfMk
	fRsHhedADi1pDkpAxqOStH6ytGFfw26QegC5fR
X-Received: by 2002:a05:6a20:3c8e:b0:3e2:3ce:4ebd with SMTP id
 adf61e73a8af0-3e7cd58c8ffmr3635755637.49.1792918566745; Sun, 25 Oct 2026
 01:56:06 -0700 (PDT)
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
 <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com> <willemdebruijn.kernel.eb29d53899f1@gmail.com>
In-Reply-To: <willemdebruijn.kernel.eb29d53899f1@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 25 Oct 2026 04:55:54 -0400
X-Gm-Features: AclHuK99nqdl0ku1cQx0dq1jsmNpklmHQLpCQExJVZpP5q9dm1lvzAJpxrv8jM0
Message-ID: <CAM0EoMnQWjN24gBye1kZdcJUJgXDPDy-=dM+NQ6dqCny7O851g@mail.gmail.com>
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

On Sat, Oct 24, 2026 at 12:14=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jamal Hadi Salim wrote:
> > > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jamal Hadi Salim wrote:
> > > > > > > The issue:
> > > > > > > act_mpls POP can leave the inner Ethernet header in a page fr=
agment after
> > > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or =
chained after
> > > > > > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG =
in
> > > > > > > __skb_pull().
> > > > > > >
> > > > > > > The Fix:
> > > > > > > After the pop, if the original MAC header is shorter than ETH=
_HLEN, pull
> > > > > > > the inner Ethernet header into the linear area and drop only =
when
> > > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does noth=
ing when the
> > > > > > > skb was not MPLS, so no separate state is needed.
> > > > > > >
> > > > > > > Conditions to recreate the bug:
> > > > > > > - egress tc filter on lo: action vlan pop_eth action mpls pop
> > > > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and =
a non-linear
> > > > > > >   eth / mpls / inner-eth frame.
> > > > > > > - The inner header is in page frags; a following eth_type_tra=
ns() can BUG
> > > > > > >   in __skb_pull().
> > > > > > >
> > > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actio=
ns to TC")
> > > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c=
54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6=
ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.c=
om>
> > > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > ---
> > > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > > --- a/net/sched/act_mpls.c
> > > > > > > +++ b/net/sched/act_mpls.c
> > > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct s=
k_buff *skb,
> > > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > > > > >                                skb->dev && skb->dev->type =3D=
=3D ARPHRD_ETHER))
> > > > > > >                       goto drop;
> > > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, E=
TH_HLEN))
> > > > > > > +                     goto drop;
> > > > > >
> > > > > > Is this first condition needed?
> > > > > >
> > > > >
> > > > > That was me conjecturing from Eric saying in v1 "...the check can=
 only
> > > > > matter when the original MAC header is short.."
> > > > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > > > >
> > > > > > More importantly, can it hide a bug?
> > > > > >
> > > > >
> > > > > What kind of bug?
> > > >
> > > > Two kinds. One, if original mac_len is larger, gets popped and the
> > > > resultant packet is still too short for ETH_HLEN afterwards.
> > > >
> > > > But this can probably not happen, as skb_mpls_pop only pops one MPL=
S
> > > > tag.
> > > >
> > > > What this patch tries to ensure is that the subsequent Ethernet
> > > > header is linear.
> > > >
> > > > The second potential bug is this assumption that after the MPLS tag
> > > > lies an Ethernet header. Is that a valid assumption? Or could we dr=
op
> > > > a valid packet with smaller header.
> > > >
> > >
> > > tbh, I was thinking more about skb frags earlier.
> > > You are right only ETH_P_TEB promises an inner Ethernet header; for
> > > other inner protocols the pull is wrong, so I=E2=80=99ll check for
> > > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in the
> > > current fix - good you responded before i sent out.
> > >
> > > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > > pskb_may_pull(ETH_HLEN). A brute approach is also to check for TEB:
> > >
> > >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pull(sk=
b, ETH_HLEN))
> > >                 goto drop;
> > >
> > > Note: skb_eth_pop() only removes the outer ethernet header but does
> > > not change skb->protocol
> > >
> >
> > I am going to send it without this 1/6 change - it just doesn't feel
> > like good taste. I will add a comment in the changes to say i
> > considered it but decided not to. I also spent time eyeballing the
> > code, i dont think there's a potential way to craft a packet that will
> > hit the perceived issue. In any case the 24 hour embargo lifts in a
> > few hours so i am not posting yet.
> >
> > cheers,
> > jamal
> >
> > > thoughts?
>
> I'm actually a little confused why the tc layer has to anticipate the
> needs of downstream code and pull headers here.
>
> That directly lead to this guessing of what may be the next header,
> such as Ethernet. Which may often be correct, but not always.
>
> All protocol parsing code itself should already be robust and call
> pskb_may_pull where it is needed. Sounds like there are some targets
> post TC where that is not true *and* we think there are too many to
> update those targets directly, rather than this transformation logic
> that exposes them to unpulled packets?

Not "too many updates" rather the main motivation here (which i kinda
empathize with) is pushback from Eric that you have to "fix at the
producer" to avoid performance degradation at the "consumer". i.e
rather fix the vlan action than have loopback vet as in the original
patch  (and you just witnessed him stand up and push back on tun for
that same reason ;->).
IOW, we are anticipating so that eth type transfer doesnt bug out
(_for ethernet headers_) when invoked at the downstream consumer
(loopback etc). Essentially it is a game of whack-a-mole until the
next bug or malicious use shows up.
Generally, policing intoxicated drivers from getting on the autobahn
isn't the best philosophy; it's better to complement that with a
"driver beware, you may encounter drunks" warning but that would slow
down the fast car on the autobahn ;->

cheers,
jamal
