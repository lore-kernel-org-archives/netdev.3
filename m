Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684904;
	b=GlRimFAvr0QpFle8+wh5F+0DzAyaxdfKA78gBJZ6aghPtreehpShNgmahtI8wdNRL+Aw
	 fjWEHiH7PcT0s4jtkA7QkiXwZFLlsdJiLbFB4mGP2AizmTdKYjgQRnnBMyyj8cmaFl6ck
	 JrBdMJVM0oHS73rSV5wNsskD8fCGEOx4h6NHHR+SjAzWxh/0sDk89x8oEvCQY78bcJ7on
	 5N14jk1GAUDEqaomE0QHU1H9Aak68GVVmENJ+uLIJZ2OT9AmelQE58VIATpB6G8HEEJlM
	 AXwa6KSjvGAq0iq5ya236z0eD+VTiBWs0C2WOSzXx/Xp1rM6VMb18rT+cu9v8+QxwDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
	b=3Y2RrSstVxO3XK92aw8lNl72pkqJFUMFgSm/g33cJLhQ2XqLqEVqjMNR6i+E0IXZWO7b
	 BhtMOQ3azw50fs5ZR50RL+lYnr5pC0HNS7gRjyT5hRBN5MZJmEav0BoMJBQMOEGF0u/Sa
	 oNNvqWmf/C0BpIZOLUlCdMSgrDaWIEDgqEqDUkQZvC3Kc+6WF4uXKuS4cloz7EF0LmLMq
	 DzmQuT8Ri8nAYYidHkrPbRhYH6D8WbEQNqPk76IL6bkBNZVb5EjgRDLn3pAXEiEN60MCv
	 xorLZ5vbkeEyDz4/1UOVF68iwiYncqUowbjjlOnLYYilXVmuyrjKQqL3KPhf0LMPyFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=m+f5lWNJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB357606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB357606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=m+f5lWNJ
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a0924e2741so12303b3a.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792684903; cv=none;
        d=google.com; s=arc-20260327;
        b=b5nPlq96V2Y+wBVfWvPJLQNdYWEO/EXSNw0CirByHwzmAoXDdObVB2Rxv/Q9qxIgqD
         amNaRMAmafzfal7+VRAFFkDgEWFOlb+NyKEhEuNImj8EAz/hcGppA79ZBEwhPdPhxWlU
         LEIXFIjYlw69xKAfCzZ50pAhMdXNvXSbqlwezmp/3E8cndzfNLjkjnhU+ZGb0IcfKK8n
         NIKq8oAgM3YSwytJemOx/gIgCUFPs8OWk7GNj+P4UudH1snL3TnyHa55kDfKrGRAQHoy
         UxMY52b/BQa37OBvvC9YO1mOzDGebEE5ArEDQd0SAhNYXL2MW4eH8V2va3Uq7TKryZg4
         1d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
        fh=c9s+EvnmmTeAzVBmPxreLJ0DMHCW31/2P/AI8aS6akA=;
        b=s88UrqYtteGwbdJ9u0bwRWqE88wAz5v0qZEcNJEnTWaOmlZAionnGNwgj1EV3vDbAg
         b6KkVnKs+ghLac0/Z/YkaUI7IYXpi5OzoyyoEzGc7VMyUj4vJLiTRL4oXGaZK8iPRw/c
         M941VOeDcr+08TBv+SUzNJO47nQsmN9g9dOyZCHMdb95H68zIhAZWbG2Mxak3LmPjkxD
         IETEREn9S/Q5YiwtPDy79fZE1jES+vWneMuGn4HYpDhmYE4fG8LYCpzVvJEagL+6Sg/V
         hRodL3WZxEnFlTWxTgyWQYwSbcYpz64ijl9258m3jLxhEViE5oSPzGB9bkai1urdH5zA
         T9Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792684903; x=1793289703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
        b=m+f5lWNJhnrnTVhzqermTyNGDuwZEXtHxT8p9i91KKg5Rufk4Rp8jE6prA1pkVWRY1
         NBZU2CvMI/pTtWypFk9W3AaAUnmI8m/m4aPg7xTGF0W8eI92FoAnZiCqqV2ZRaFQ8AXf
         gGsNJZAnWjV72cTsGrSG6yKBtX95pM2MHqRMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684903; x=1793289703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6BzR53XkcYWnJTROJDWWc96U2wGkZB/h4YFyc/vD1Y=;
        b=V9S8fSLsxh9PKq1j3NT9Uw57Rv3bhrCavVWWW+bpox4frWOPBE4e9glu/E03Tf1Bt3
         ub7NgfDZYLhQO8gjOLp4IJ3TPAQ4ZRGVnkoc6bE3OK+VkF4rIt8RWyNf5TR9nbBgpPLp
         Lphvdt371uwUtap8XEUd43V70vvJZueGx7E8O+wvOmaDWYiByKBh7Ms8p3+HtPn7+a76
         XVaykNqkzK9u4V+0tL3QJ7Y0xhEr81pifQ9S4nwohHIm4f4a+u4uw28vcOLUvSn/vUfS
         vBng12H97Zl+IofdUJC1VOhCumOTK3MRsw7V37JPBn9fsu5Kvi928lgMlRafBwrZ6ZhD
         WirQ==
X-Gm-Message-State: AFq9FYI0AbDXjbS++CGFnbhk0y4SbZRbY7a997KFUV576jT0c0gcGl5p
	Ip/BiHSRO0zxYm6k+e89ED8t0LAs/V67Goul+m9cWALCertbvbca207Ps84WcsYaPE6b2rHE/nc
	2i8JySedx/sCVxhKfoIzq0TQB5+4kCULC0XSYYsNp
X-Gm-Gg: AYBFou0j3flnwO2ZAZSzMoL5dPKiGimGOuDQtgpMDXnjxeV+8fdah0CbY/V5UaVYgIO
	rpSW+jzsq12lACufOjzQqxdt1Ob4Ehw7KuuQIlOwWKEjPjGh7sOOZtnw0K4b+BKdqfd80wcyqDX
	YfT2caK1Qr9cZ0s4u9RS52XnFgv7wZxaKNSi5j+LpiCxrHgoMTVi0j8lhiQouwkrZSDk/v3GSdu
	JNJ45KiPUaHWT+Qn2Y/tqsg2C0MTFsFj9J2Fp4DxZa+kpL0wNxJM6dZ1EXI+WepR0ssy/XAB40j
	hJvPBv82vGk7oNIeHSIt53QZ74V5Tk+MKyaH45T4fRWijBFHv3p8l7TqfqzLIfopmh5r3Qg/2Wd
	hki92UAFZQyhXKCJdiq0Cj+4tSpPQ6Ei69WXcSHLfuMAEig5Gm7tqJcWCV6A/Jv38W0gEheaqYp
	OUFPY4nWdTGmhWGxE=
X-Received: by 2002:a05:6a00:94f2:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8a089d4b9demr4627712b3a.52.1792684903101; Thu, 22 Oct 2026
 09:01:43 -0700 (PDT)
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
 <willemdebruijn.kernel.38722ee638a21@gmail.com>
In-Reply-To: <willemdebruijn.kernel.38722ee638a21@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Oct 2026 12:01:30 -0400
X-Gm-Features: AclHuK-5CkW0mOltEfM9Zb_u_0BHBPvpxVVM8r2c2XDj_cPKyz7BcCck9T_aWJE
Message-ID: <CAM0EoMnJhXQPxfU65oLYvpc-a6MhZSKi-D664fTMLah_6p7G2Q@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet
 headers after POP_ETH
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, Ren Wei <n05ec@lzu.edu.cn>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowangio@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:21=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > The issue:
> > act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
> > subsequent eth_type_trans() may then BUG in __skb_pull() when the frame
> > is redirected to an Ethernet device.
> >
> > The Fix:
> > Drop the packet at the producer boundary when skb_headlen() is shorter
> > than ETH_HLEN after skb_eth_pop().
> >
> > Conditions to recreate the bug:
> > - egress tc filter on lo: action vlan pop_eth.
> > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-line=
ar
> >   eth / inner-eth frame.
> > - The pop leaves skb_headlen(skb) < ETH_HLEN; a following
> >   eth_type_trans() can BUG in __skb_pull().
> >
> > Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3=
b.1782548651.git.bronzed_45_vested@icloud.com/
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/act_vlan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> > index 6a375fdc63dd..ddf03b08bfe8 100644
> > --- a/net/sched/act_vlan.c
> > +++ b/net/sched/act_vlan.c
> > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *sk=
b,
> >               err =3D skb_eth_pop(skb);
> >               if (err)
> >                       goto drop;
> > +             if (unlikely(skb_headlen(skb) < ETH_HLEN))
> > +                     goto drop;
>
> Could it try to pull the header and only drop if the packet is too short?
>

What would be the benefit?
Note: the OVS patches pull because they must restore
MAC_PROTO_ETHERNET and already return an action error, i see a good
reason there.

cheers,
jamal

> >               break;
> >       case TCA_VLAN_ACT_PUSH_ETH:
> >               err =3D skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_push_=
src);
> > --
> > 2.43.0
> >
>
>
