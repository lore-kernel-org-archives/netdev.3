Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409324BEE5E
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172709; cv=none; b=XY4wTU1e49+vxtGF9Jsp4ANAFr27ffkvAFVAy1JHJuwqg1objR9iiaJGfV1TnaJVPETGP7XjZT5EdlFS/vHs6/87yxLtH4uPQdDrXUbaP/johEVmBwnisS/P0WmxZXraH4A++g/k8NINdhMELbJLB4VXIo3HIc7Hw7p6FtlwoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172709; c=relaxed/simple;
	bh=RV07BViCfjhajAEEiMEJRubWk4Kk7JUtEOgtifKYzUI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LpOxMBeXcqloWjTT43sNFGnRZIB6hNV/krHL8IrC/5JWnAYWXskxamH/D4XlkKD9dX+BBZBSu7IARjM0h5d3Fb68XRum7TUfwP3X7Ba1NcoMtT79biPyotr28O83uO3soEcew9eiULMOSrtDaKr76u70uXVrs876ZGO8FY8It9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xeh1qNr7; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xeh1qNr7"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab19127so310567d50.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789172707; x=1789777507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eJAUa0v8AtambqStL4Ts+NgnmAh0NjIHz1wP4CNcV3Q=;
        b=Xeh1qNr7YuFDMZ3s4YpwYoow+ATTmlZaSWm0BuCERSpz0NS7g/bl/EtBm/rJTv8LRi
         uqPjTaQQeyPCXdujEy8Eeunla3EvtIZrhhFErX7SHN/EDoC1OUxgyuEz703myTRv9YVn
         7GesubrythTxhmNeWPU7YRHDvLVQN0dBffM4f5PSyRiPx/c3P7j0Q31GlvE41R2T8oJ8
         wAsvFNpBLMNo84tNffVvJnaJw8W58e2QwQOh0A1hPgMdUrsicTULtChHZGFFw7EOvJ0a
         gy86RaGfcCm6GKarrlim8TRh+7f7Fwd6MJD9AdAFUzj2/x6YqY7CjrSA7BEL+5vvSiYm
         rUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789172707; x=1789777507;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJAUa0v8AtambqStL4Ts+NgnmAh0NjIHz1wP4CNcV3Q=;
        b=CkDJgRdo55699gp3pGyQr/RiXdpX4kl2vqwPjMNZGs+IMl8MEmNLz0qmVFvzYE3OIo
         OHL7/nxyHQ/V7f3Bn8wKQv2i1ClwwcjqV5CooDYSG+Jd0fv/RnrSpS2jgPQp7ZMimprs
         1ocH3HPRAXave777Z24+ioamdNqhfSY3Lno5kbAqku3l0IHUCgELvAQhwK514tfrUida
         l745opaK6yIeEnrc8D7mPJN+RFC2ATt0M6IBevWdxXUfzusx4sPZkjaA1mSvO/wk8Sj0
         isTact4t4e0bjkreOuBbyO8cWjhkwV81EBMPI/3W8f93GJ9vZwyv7ic5qWXG6uPqopJT
         AZ1A==
X-Gm-Message-State: AFuF++lnFT3pnFKeP6K1ZGwyZmAfHNfPdupwaWcET1x+/sOJGgs+0VSO
	HoL5Ts6OtgWCZxJIlmh7M/DgfEkH2osJLPfUF+XctcuaEjFNLanYQ4gF
X-Gm-Gg: AYBFou2TtBUza+NuBzOrO2GvGoroOqQpTCBD+uG/j41wf4IZlCniFLUsg+L3vaqWrNY
	gwimMNxgsXwBp7G8X1Y8eAfdwiEbw8qSn9Qks3aOF7ZpSe7lo2i82onkTYWXJHi/rNze2VEX3LY
	zINPgPbcg/TkUcHBknIhtixIJ+pG2Gp+A3LHg90biY+LlVhKF6RSkNBuYJ+U1AYofbxPxZBLvHM
	e5LTttPkvas0ej3x23BfOIlMOqHawdxpfCeSMVNE56h5M3iVvflhwJe3m+KRttIk6U6fhfBWvAk
	FTuMXGS33Cqqx0Q6gU+iOxCVCrTvrLrywAWgffIpY3PDN3ZFjuwt+aMH80B+LusVdQTFg4CRdvJ
	jLcZ1pgshSFujftwAL1VeanxTHllNxr1CI35P3eVPyT/4nx4aoU02Ig23nkZnqED4ZN5VjzP8ti
	UKNlL51dpaVIU/DImGzunpQgaBz97IeUI9eRB7An5iCXE9obpwowA+dWCGBe64984K6VxfOpzYr
	6/S72JcOm0LGL7XVPj02ZTh+amvxYgSvJyp3BJFP8P2/xcdiygRtg==
X-Received: by 2002:a05:690e:d58:b0:66f:c1d9:c029 with SMTP id 956f58d0204a3-67124767292mr2976235d50.53.1789172707047;
        Fri, 11 Sep 2026 17:25:07 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884873fa467sm16724717b3.25.2026.09.11.17.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:25:06 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:25:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.20893f9a2f273@gmail.com>
In-Reply-To: <178914679401.219967.11906428098360110344@kernel.org>
References: <20260910171131.2532487-2-willemdebruijn.kernel@gmail.com>
 <178914679401.219967.11906428098360110344@kernel.org>
Subject: Re: [PATCH net-next v9 1/7] net: rtnetlink: add pacing_offload
 attribute to net_device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1 (1)
> =

> - [Medium] `pacing_offload:1` is added as the first *runtime-mutable* b=
it
>   of the `struct_group(priv_flags_fast, ...)` bitfield word in struct=E2=
=80=A6
> - [Low] Concern (verified as NOT a defect): dev->pacing_offload /
>   IFLA_PACING_OFFLOAD is claimed to have no in-tree consumer at this=E2=
=80=A6

TL;DR: I think all reports to this series are false positives.

I'll respond in detail, skipping only some too obvious low ones
(e.g., "this feature is not used yet, but will be in a next patch").
 =

> Pre-existing issues:
> - [Low] Pre-existing YAML spec gap adjacent to the change: the shared
>   getlink do/dump reply list (`&link-all-attrs`,=E2=80=A6
> =

> --
> =

> net: rtnetlink: add pacing_offload attribute to net_device
> =

> This adds a new IFLA_PACING_OFFLOAD link attribute plus a matching
> pacing_offload:1 bitfield in struct net_device, so pacing offload can b=
e
> turned on and off administratively.  It also marks
> IFLA_MAX_PACING_OFFLOAD_HORIZON as NLA_REJECT and documents the new
> attribute in the rt-link YAML spec.
> =

> A few questions below.
> =

> > diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation=
/netlink/specs/rt-link.yaml
> > index 5217d0bb4a3a5..7a72cd1b7e1ee 100644
> > --- a/Documentation/netlink/specs/rt-link.yaml
> > +++ b/Documentation/netlink/specs/rt-link.yaml
> > @@ -1091,6 +1091,10 @@ attribute-sets:
> >        -
> >          name: tailroom
> >          type: u16
> > +      -
> > +        name: pacing-offload
> > +        type: u32
> > +        doc: Enable EDT pacing offload (0 - disabled, 1 - enabled).
> >    -
> >      name: prop-list-link-attrs
> >      subset-of: link-attrs
> > @@ -2559,6 +2563,7 @@ operations:
> >              - devlink-port
> >              - gso-ipv4-max-size
> >              - gro-ipv4-max-size
> > +            - pacing-offload
> =

> [Severity: Low]
> This isn't something introduced by this patch, but while the shared
> getlink reply list (&link-all-attrs) is being extended here, should
> max-pacing-offload-horizon be added as well?
> =

> rtnl_fill_ifinfo() emits it unconditionally in the same nla_put chain a=
s
> the new attribute:
> =

> 	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
> 			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
> =

> The same holds for netns-immutable, headroom and tailroom, which are al=
so
> always emitted but not listed in the reply set.
> =

> The commit message advertises reading the horizon with
> =

>     ynl --family rt-link --do getlink ... | grep pacing
> =

> which works, because the Python decoder resolves reply members from
> attribute-set: link-attrs, but consumers generated from the per-operati=
on
> reply list would not see these members.

This patch follows the established behavior of other recent read-only
rt-link attrs.

It's a limitation of how get-link and set-link use the same attrs.

This is a damned if you do, damned if you don't issue where the bot
will call you out either way.

> > diff --git a/Documentation/networking/net_cachelines/net_device.rst b=
/Documentation/networking/net_cachelines/net_device.rst
> > index 512f6d6fa3d8f..8eceaa80b6860 100644
> > --- a/Documentation/networking/net_cachelines/net_device.rst
> > +++ b/Documentation/networking/net_cachelines/net_device.rst
> > @@ -11,6 +11,7 @@ Type                                Name           =
             fastpath_tx_acce
> >  unsigned_long:32                    priv_flags                  read=
_mostly                             __dev_queue_xmit(tx)
> >  unsigned_long:1                     lltx                        read=
_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_=
UNLOCK(tx)
> >  unsigned_long:2                     netmem_tx:2;                read=
_mostly
> > +unsigned_long:1                     pacing_offload              read=
_mostly                             sch_fq
> >  char                                name[16]
> >  struct netdev_name_node*            name_node
> >  struct dev_ifalias*                 ifalias
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 707b2e51c2b97..1f0710eef185b 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> =

> [ ... ]
> =

> > @@ -2170,6 +2171,7 @@ struct net_device {
> >  		unsigned long		priv_flags:32;
> >  		unsigned long		lltx:1;
> >  		unsigned long		netmem_tx:2;
> > +		unsigned long		pacing_offload:1;
> >  	);
> =

> [Severity: Medium]
> This puts the first runtime-mutable bit into the priv_flags_fast group.=
  On
> 64-bit, priv_flags, lltx, netmem_tx and pacing_offload all live in one
> unsigned long, and adjacent bitfields are a single memory location, so =
a
> store to one of them is a read-modify-write of the others.
> =

> do_setlink() writes the new bit under RTNL only:
> =

> 		if (dev->pacing_offload !=3D val) {
> 			dev->pacing_offload =3D val;
> =

> but priv_flags in the same word is modified from softirq context with n=
o
> RTNL held, in net/ncsi/ncsi-rsp.c:
> =

> 	ndev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
> =

> That appears in ncsi_rsp_handler_oem_bcm() and ncsi_rsp_handler_gmcma()=
,
> both reached from ncsi_rcv_rsp(), which is a packet_type receive handle=
r.

The bug here is in ncsi_ imho.

The other fields are written at net_device init and immutable
otherwise. The rule for these fields is immutable or RTNL held, AFAIK.

> Can these two read-modify-writes lose each other's update, so that eith=
er
> IFF_LIVE_ADDR_CHANGE is silently dropped, or pacing_offload reads back =
0
> after do_setlink() already set DO_SETLINK_MODIFIED and sent a notificat=
ion?
> =

> A second point on the same field: a 1-bit bitfield cannot be accessed w=
ith
> READ_ONCE()/WRITE_ONCE(), yet the net_cachelines row added above docume=
nts
> pacing_offload as a read_mostly field consumed lockless by sch_fq.  Eve=
ry
> neighbouring netdev field in these paths is accessed with
> READ_ONCE()/WRITE_ONCE(), including max_pacing_offload_horizon right ne=
xt
> to it.
> =

> Would a plain bool/u8, or a dedicated unsigned long used with
> set_bit()/test_bit(), work here instead?  That would make the update
> independent of the neighbouring bits and allow marked lockless reads.=
