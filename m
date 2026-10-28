Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188416;
	b=J2I/7Hi8Bd9JtgBK3NQGr25d3o8cucWO/lZTLTbTjFBHcwPSTtA4FKEDrvg9GCJKUNgg
	 oT+d9IO9hrkYXuDvRz9pH5u18QIqKVvEoF68lO9DdVduDbEUSQa3ZwF8NqVBFWPu+6m2a
	 E0JW7CeoJKSanfOudfdnHu6r47W6Y1JX3bO++XnktgY66Iu2b4tp+7zkbc6dQhKpAHcC5
	 ePKkL7Djy/NnIIBGtetg75d9zxoXDYs4nPI2JqCcHgtkMmcgrVzMwUcqsAQI9IorvtmV3
	 5tTCCt4OKUD6VXfaUM4VJGruk2vxarkibWMNAA+XDWbxesYIyFelX+GLbYAW9+aPrCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
	b=Kje9qDLDOh0PaD1TzQpJYoWBUrzQo8f7U/FV7NidFCiSb5/fHyl653wlgNB0Qaml5RW4
	 QALq3zU2q5cwSAXkRDbe98XuScYmJ9IyF2WnNXOv7n+bOOah3DCLdf5quq+fct4bA+r92
	 AGI45DFL3hDKZCpZcnofdc2MSj7B+XJzQc/V5MFqg20RQBdAIRxgvvPAobR7T3MYV5g0T
	 t7N1zWWp8OQ01Iu7Z7mjz8Ms2agDiDLXibWBndnlVPEymH26oHwDZvRPaobdb2QLAh7CT
	 l0grHUvpMVthtZwFIcuMuoX/gix5jrU6McmtCUNKqe/lEZ7gV9G0WQNL2Xu6ln6EfeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WUVYd0kE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77A606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 11:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F77A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WUVYd0kE
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso529836a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 04:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188415; cv=none;
        d=google.com; s=arc-20260327;
        b=fwkuSU3/uFI30DDmTrP+uN+grf1AbjQWys/NU3uaQFov5tAFvnYqULRGuf8WRORC+7
         vdq66ju5O8p15z/gMcEi12N726uF72QWlb8ywZPxkvTDH66mYDpRF52OaX2F7Wok2MSY
         /H6y1O1tBsCOlSWfkLZjoMuuDA1/jTrSYauZkDG1TV8Eze5ADlvkmMR2I3rnb7t8+EKp
         DBsJ9IZFBwgQ41fOcv4IV6HOM0sytflLdvYPOgmYzthK6kXi5zECm12Znba/jn0choFs
         DopSyX51J0JKZJoK9ilZcj5VCMf6pWz+RZVTWr+AWhABfUeIyqS6pDM6wyZBeQDOC6aw
         3ENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        fh=y83Bws/Bc2DRxCOMXCh2pF+xteaqWakIZp+0urZt1PI=;
        b=YvEFYxNCs7cGXYm5msd7lzRQe1VCjNg7YaHLxCJx616s9xcy1K1BNXoLcflsoYAK3F
         EiHnBBy2YDrNmc/CuFKBVSiF4RMcxLb7e73ATSL0GliaQ+cPrJXf8aMC24MqysxGoq3P
         N0Ff0IgaIs4KealqulF8IhucnkFELT/JGXwJFu8LJKOnGdk/LH4IlmIUiuZ8+Phvd99W
         nGWAPauCsVbGHPCqUZMja8wC07+2HSFyqqi8NvDZ9fvP+1SNop7xBIfUyXduifRyDLZo
         XiH15BKRoO7Yg49QJc3oJdMaUjW+05DjwehHHX/4cggZ8LhG62ZMz4I/HJuXDiq3FRoi
         dAUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793188415; x=1793793215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        b=WUVYd0kEFrDYGXYAbPFdn+FZT0g4tovRk5OV3qLEhnQMP4yhV6yXzlJfn7ZIM0in39
         uFhhYE+n4MK5SPak2DLasq4/ZRPvpv7tIBqUr1zxvixb9Lx8AisSUHghr/Uh3kVeYoDS
         1fygngZNYVuxVlLs+c5VEO2d3PfmV/8Ftw/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188415; x=1793793215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        b=MMYskIjNLeStyUsmlLp1/oKfEWv4MGc+eJ9OLv6e5tadwduKTya3RSyhvwuBT1xbOx
         ruiiOihknJJBM+zsNVmBF2of+ul1ebDh4OD8hwWK1aKc3KCrFqQnfaPZlLIm93sTWXUy
         TpHbnK+eWc5+BTYxrtJJtiVx8AfdG2X8+rn1mNV5NBjMLJdEQOQRlKNwBuTQ9XrxhH//
         uIe1LBkKysArIlGdJbRD54NiZcGrllHp+5p7fWNmesuRIzowsylFJNDVo+6zJ+v1u5tt
         bLFuXuV5wQVkjCuV6EF3LxfcQbAswxShCbRTYETcxJbmS0kJXUqZFnGTiTOgwoIDpADX
         refg==
X-Forwarded-Encrypted: i=1; AKwUvByr294MmAkK0dk9GrMURXjauGL37MGdhRJdv7D/TND3/qjco341WT7no9aWO5JO+mqRHRmj3gY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+jr5e+7Hze8KZ3y+k7KaZBc368Xe4rYeyEI1EqoEFHy1jM7/O
	55sm/o6uvVhgZ6MvAAVNeVK9Scv/qG8LtHlvxJMo7QNxPtXHiC2m65otrlsI4bul2tvxS07jysh
	ktoE9Y0jpBVDQ7hA0yy5sHXJIhW3rwtZdazPzHe2m
X-Gm-Gg: AYBFou34uZxDXHLmPL1wycpSbcgBaex6u9wfUiqia2EkrtNhi7/bX9Mv/WWvqRenN3D
	cpVyW7RDO2RV9CLZPx6phhEDMlJS3JN7sunwxhwLkjNeRkvjBJachkGREezH8buKq6M1tSTsHFA
	vVqWrFWIDFVg1Uf2Up4AKJERlur3pmILX23QnU36zKU8zXR2bdc8/YmBpMVxpI47Skn7xaQFgUr
	WWej99eRQxHJ1DpDuo14K9aMtploKrTxhqoetoARub1yJbwtCu0kAmXWQAtGVww8y432Mt5scOr
	VUEKOf8lN4mFiOHKHiRHHTiuQbZONMmxZLzNP2a+7b6Zsv03qpha1cGk/+eBL8jkmUEpXvvGVdx
	SV3PHB4t+In54dfPyss/nQkYV0IhPQhreevm0vaJw+ub5aneyqq/Ak/dRjm6DxIuJuxnEfw6IwQ
	Ox0xQh+Ws8Loev1d4=
X-Received: by 2002:a05:6a21:39a:b0:3e2:8f64:e4ff with SMTP id
 adf61e73a8af0-3e9023c11b2mr1864941637.31.1793188414925; Wed, 28 Oct 2026
 04:53:34 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
 <2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org>
 <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
In-Reply-To: <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 Oct 2026 07:53:22 -0400
X-Gm-Features: AclHuK-GhnK-qd0xLjJB1wtnuCO2c4dWn9lENZM0luOK9ZkwfIjPDiJ_LxTY9Ho
Message-ID: <CAM0EoM=ETuLerW3nd85zuEjwqydrd_9E4r0TbDekYyUZnEBSpw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: Eric Dumazet <edumazet@kernel.org>
Cc: bot+bpf-ci@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	dsahern@gmail.com, kafai@fb.com, martin.lau@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, victor@mojatatu.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:40=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mer. 28 oct. 2026 =C3=A0 11:19, <bot+bpf-ci@kernel.org> a =C3=A9crit :
> >
> > > bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
> >
> > TL;DR: The new skb->mac_len < ETH_HLEN check in __bpf_redirect_neigh() =
may
> > wrongly drop valid packets on tc egress and netkit, where mac_len is of=
ten 0;
> > a regression that would reach stable.
> >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index b7ac145b68b1..95a8a728a71d 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> >
> > [ ... ]
> >
> > > @@ -2451,10 +2451,14 @@ static int __bpf_redirect_neigh_v4(struct sk_=
buff *skb, struct net_device *dev,
> > >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_devi=
ce *dev,
> > >                               struct bpf_nh_params *nh)
> > >  {
> > > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > > +     struct ethhdr *ethh;
> > >
> > >       if (unlikely(skb->mac_header >=3D skb->network_header))
> > >               goto out;
> > > +     if (unlikely(skb->mac_len < ETH_HLEN ||
> > > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > > +             goto out;
> >
> > Does the new skb->mac_len < ETH_HLEN test drop valid packets on tc egre=
ss
> > and netkit?
> >
>
>
> The bot is right, sorry Jamal, I missed this when looking at your
> first version.
>

agreed - i will send a v2. I will also test egress/netkit path.
That was fast! (in 7 days on the sashiko nipa i dont remember the
context given the number of fixes)

cheers,
jamal

> skb->mac_len is only set on the receive path. On tc egress (and netkit),
> it is usually 0 for locally generated packets, so this would drop all
> bpf_redirect_neigh() traffic from egress programs.
>
> In both cases skb->data is at the MAC header when __bpf_redirect_neigh()
> runs (sch_handle_ingress() pushes skb->mac_len before skb_do_redirect()),
> so you can use skb_network_offset() instead:
>
> if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
>      !pskb_may_pull(skb, ETH_HLEN)))
>         goto out;
>
> This still rejects the 1-byte header from bpf_skb_change_head(skb, 1, 0),
> and also covers the existing mac_header >=3D network_header test.
>
>
> > skb->mac_len is only set on the receive path, where
> > __netif_receive_skb_core() calls skb_reset_mac_len().  The transmit pat=
h
> > only calls skb_reset_mac_header() in __dev_queue_xmit(), and nothing in
> > ip_finish_output2(), neigh_output(), eth_header(), sch_handle_egress(),
> > tcx_run(), cls_bpf_classify() (egress branch), netkit_xmit() or
> > netkit_prep_forward() writes mac_len.
> >
> > A packet built by a local socket starts with mac_len =3D=3D 0, because
> > skbuff_clear() zeroes everything before 'tail', and skb_clone() (used b=
y TCP
> > transmit) copies that 0.
> >
> > For example, with tc egress and a locally generated IPv4/IPv6 packet:
> >
> > ip_finish_output2()
> >   neigh_output()
> >     dev_queue_xmit()
> >       __dev_queue_xmit()          <- skb_reset_mac_header() only
> >         sch_handle_egress()
> >           tc_run() / tcx_run()
> >             prog returns bpf_redirect_neigh() =3D TC_ACT_REDIRECT
> >               skb_do_redirect()
> >                 __bpf_redirect_neigh()
> >
> > Here mac_header < network_header passes, because an Ethernet header was
> > pushed, but mac_len =3D=3D 0 < ETH_HLEN, so the skb goes to 'out', gets
> > kfree_skb() and -ENOTSUPP is returned.
> >
> > The same happens with netkit:
> >
> > netkit_xmit()
> >   netkit_run()
> >     NETKIT_REDIRECT
> >       skb_do_redirect()
> >         __bpf_redirect_neigh()
> >
> > with mac_len still 0.  Netkit programs are BPF_PROG_TYPE_SCHED_CLS, and
> > tc_cls_act_func_proto() allows BPF_FUNC_redirect_neigh.  Forwarded traf=
fic
> > that arrived on a layer 3 device (mac_len 0 on receive) and leaves thro=
ugh
> > an Ethernet device's tc egress would be dropped as well.
> >
> > Before this patch these paths worked, since the Ethernet header is line=
ar
> > (dev_hard_header() pushes it into the head) and skb_pull(skb, ETH_HLEN)=
 was
> > fine.  bpf_out_neigh_v4/v6() calling sock_confirm_neigh(skb, neigh) als=
o
> > suggests the helper is meant to handle locally generated skbs.
> >
> > Elsewhere the kernel already treats mac_len as unreliable at egress.
> > act_mirred uses:
> >
> >     mac_len =3D at_ingress ? skb->mac_len : skb_network_offset(skb);
> >
> > and act_mpls uses skb_network_offset(skb) when not at ingress.
> >
> > The bpf_redirect_neigh selftests (test_tc_neigh, test_tc_neigh_fib,
> > test_tc_dtime) all attach at tc ingress, where mac_len is valid, so the=
y
> > would not catch this.
> >
> > Would testing the real MAC header length work instead, for example
> > skb_mac_header_len(skb) < ETH_HLEN (network_header - mac_header), or
> > skb_network_offset(skb) < ETH_HLEN with skb->data at the MAC header her=
e?
> >
> > That would still reject the 1-byte header from the commit message (pop_=
eth
> > followed by bpf_skb_change_head(skb, 1, 0)) without dropping egress and
> > netkit traffic.  Since the patch carries Cc: stable, this regression wo=
uld
> > also reach stable kernels.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/4066=
6397744
