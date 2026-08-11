Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672B38B7DC
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434292; cv=pass; b=SrDbf2Cr8pIBtdkkU9I7KbS+aFJmjlwMI8Sj+DDiKMJ47fGfhYggDmBZj8FRGgsxsnoM8foRLWJ1aPMwhq6E26qPkNKWzu4mkgDtAnS9iHkOOp5djMuSy8ebVSvU88o/jMPkNwFXzY4D+QRlDO9g88YV8xgxgcem55Ks1ywMQTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434292; c=relaxed/simple;
	bh=gN+oA5u6CjDLE62lSk0aBatgqcrIf6ohpiyr8jz28oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+SvKmot8AU6s1Zak3vaOwo9cxBfl6+hjAnOQz63647VpRLP4ksCYMw8g5VvvUO9lQw+rQYqzbNqR6ytQtFNsXR+xM+ONY1Jbmtwi6dbi0JJ9+p90jJQeo5m6ek9Sa8rsiQ4ANCJfHDmhmaevaNh8tXWfbZkpDeM6lmS3Eh/YWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSsC1zJm; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSsC1zJm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e69a2db34so45720517b3.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786434290; cv=none;
        d=google.com; s=arc-20260327;
        b=M2fhw1tQKpLQ/6h44+iqHRMJXWMMzJTpRKi/bOFt0NmV7p9kvCfB5wrz2KwNsLJ4D1
         eoE28rhhyrXYqNteS3W/ulXf/c70Dwg+7xcmRP+K88rTM1aHwVRmhHKeSl+tmWuDEFzQ
         MUClTG2jeVwcpHyuiV09iIzd1IXRh1Ah1xDTOAukxqCeIwWCvDxSovWH17/x+xREqvNC
         kLA+KIXu6b1d+r98pDqvbEyOpBdGFWxmq+7IPw9/6zrY97pE4yGbg+Zesi31LXgKnZT1
         HB+k4J4zks5zdjBVfml+vDTdG7CiGcSBVo8i4LamAhiGHmvTIxKcPHN9Qp3efUhuyTRv
         QG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q2JfKbN1g0WpihiSHX5U7ghwvyYYS2Z/0XHJObnUYWQ=;
        fh=mQVbIC1TMfKXZu/FG4SBCSdj9IEAMqx2fmrTYyZ52oA=;
        b=lwaIqOzV2xcniW7aqInjZKEjkol9zIJyvjLFrIIXB2LT+ev47AJtUWWzQog98yb8r5
         z7fg1Qqhf2FrB1452stpitP9lGkOTOW8qk9p0/DRoiAVdx6vSHSiG35p0fnPTsb2o0cT
         L1uqk2/qU4vnUbjpogpJl6/DMbQoJRNvEwB9bq++941vjxTCnmNgwGqWZIFZ5rWzvZ28
         ReQehA7iLjCfV/hcajzY4wkIoF2m4qxAFJlo+r1daGFvQYYuIdd+iJswkFrTmX7ClH2S
         OpJxUBzTnQQ9DcWfswseOH2QxTjZc6vveVAu2qL/zGvkmhtIAa68mipreR7HlzCbgHVU
         Hnyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786434290; x=1787039090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q2JfKbN1g0WpihiSHX5U7ghwvyYYS2Z/0XHJObnUYWQ=;
        b=dSsC1zJmOf1h05sRchOrTpf/OVtrJmuwCElfYCKYUZOQubZVbXkTEMq2BYrpPad7xa
         cjUZVlYLtCLmFSFRIHJcXCpCjEDQh/eBBPsaHziiGk4J0BT+8a20j73671U3+4Sv1WlL
         dfYvbnjfNUW8DJ68DjdaDIeWmITWzsihnWgZrrxjDs278w3oGPH348T8rbbuPF8+gf46
         d60bIXplfogH41e+sxybcZSfuLsBGjWz1EPM7xkndMVKK6N+bDvPLLS1TijtC/wQDBmn
         NGnXja0Vu1STSTwsBWVv7EmDroq/IZrNBM4PPPLXOFlUNaP29EUavxQ07zQU8oy7/kAX
         UEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786434290; x=1787039090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2JfKbN1g0WpihiSHX5U7ghwvyYYS2Z/0XHJObnUYWQ=;
        b=jbyThoC3fcu2i/Fw/rcgFRUj9x17z1RVGLDfZakJVer2FPs2k+GJfWhVO7z1azy0u6
         Y819tgwGGLGR5LHsZ1QfEJy5HZOSvSrm7cm4nNNooDw39QBXdt8s2atnNWr7s/ebosMq
         6C8wYMq0xfqOC8xIVskWf+EpsZa0j9Xsh+YS4jKaRMp0PXAvQO7TMZvxqJjCtJn1zTkD
         QR/OQPanbeRF7+dF3D+avoAyKRdp7y06o16H1/brcZoLFXUFdcZFMAxp0zuSVGKwdfrr
         VXm4pw4E8+BPRDl1UEmy4AISKCz/4h/9L+r0YDHa4uNUYj6YezLYrs4G44NTnqI7HhNU
         1H2A==
X-Forwarded-Encrypted: i=1; AHgh+RrJGs6Qnr/exEFesPhPxJUg1RGuGZTBvPfxHkLcCFpacEPI3/e0KlG96sFZ8AnnRtFxqxFGpLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCncOixv0ZJmrc4GKyoGIfYl3fvzv8nn5EiNWNaakXJtfspX33
	ktaEl82SK4NIoG2/evElskT3WF2LOexBmJcXMyuBH4qiJWXUsKLpWENWG8xEArIf1WYiAP6Kfx0
	NPOiiFNpEooxCKZWKZqYJupdj8JVPZlo=
X-Gm-Gg: AR+sD10R7jw/U6VmWkjUB3Qlc64bs698Xu8kNaRvkGs8msi1RdGVUx+89v6W7yABJCT
	UJ+sycRmKq6yAlEj8z6xWSLohIav0y+mr8PSBdrIv9ZyczEn1HqLaVU8BATtBjBZEIOB3UaelDU
	QVmbLHrk43Y6cCI10rAdDyVTSwTGOHSoWMMMuTmaidTh7XRq9Fd9hOP707+xSoxE0ayqOb/2us5
	WQz0ZoRrSnM3R9d9mLyJeQYwmmaUUoBeTi0kwR45UMH0CsHdLn+8RTsGQEdxHsw0dsEDOiiFxzV
	gj/ruhx6Is4BzQrt6qW4nBCmeKgWqe9M9hoksqCEJgHQ0Kg9mYEr0Iovup3TIFJ1DnWe0LDQMY+
	vPa3spoPeBT7NFbKdlr+NwTaLIlkZji6uYQH7AO9gDnf8cJ2XtUG1ZHHbkVpaGNH4VmMCtPVE8I
	MYR2DfE0Gz
X-Received: by 2002:a05:690c:d0d:b0:80c:ddcd:c4d2 with SMTP id
 00721157ae682-82f2ef152c9mr8349707b3.32.1786434289760; Tue, 11 Aug 2026
 00:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806073119.387-1-strst.gs@gmail.com> <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf> <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf> <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
 <20260810120821.lykofvogbrn2y2ps@skbuf> <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
In-Reply-To: <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 11 Aug 2026 09:44:37 +0200
X-Gm-Features: AUfX_mzJ3V_GaBHMLEnYRLuVHb1QQS_ez3zkxbv0KWmbbSLl_VLjgu_oKlfhvYY
Message-ID: <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Semih Baskan <strst.gs@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:25=E2=80=AFAM Semih Baskan <strst.gs@gmail.com> w=
rote:
>
> Hi Vladimir,
>
> > What about VLAN-unaware bridging? Can packets with VID=3D100 be forward=
ed
> > autonomously between two ports of a vlan_filtering=3D0 bridge if that V=
LAN
> > is not programmed to hardware?
>
> No. On every b53 switch measured so far it cannot, and it fails in the
> same place on all of them. The frame passes ingress admission (with
> filtering off the driver programs VC4_NO_ING_VID_CHK and clears
> VC5_DROP_VTABLE_MISS, one shared code path for every chip), then the
> forwarding stage resolves the egress set from the VLAN table entry for
> that VID. A VID that is not programmed resolves to an empty member set,
> so there is nothing to forward to on any port.
>
> > Does the behaviour depend on silicon capabilities, or is it the same fo=
r
> > all switches handled by the b53 driver?

VLAN-unaware bridging does work on BCM5325 and BCM5365. The driver was
originally written for this family (before upstream submission).

There is a register bit that controls what happens when a VLAN-tagged
frame is received for which no (valid) VLAN table entry exists.
Default is drop.

On BCM5325/5365, setting this bit makes the switch *forward* the frame
regardless. This is why it works on those switches even with
VLAN-aware mode enabled in hardware.

On later generations, the bit's function changed to "redirect to CPU".
Stand-alone ports still work there, but VLAN-unaware bridging does
not. Everything goes to CPU, and the tag driver marks it erroneously
as offloaded.

But I didn't notice this until recently. Partially also because there
is no kernel test for VLAN tagged forwarding on a vlan-unaware bridge,
only for standalone ports. Everything saying OK with a vlan-unaware
bridge made me think everything works as expected.

> The port-to-port part has been the same on everything measured. What
> depends on the silicon is only whether the CPU gets a copy of the miss
> frame. Three chips have data across these two threads:
>
>   - BCM53011 (bcm5301x, my RT-N18U): measured for the CPU direction.
>     Every ingress-check setting (NO_ING_VID_CHK, VIO_FWD, VIO_TO_IMP,
>     plus clearing the VC0 miss-drop bit) delivers 0 of 7; the frame dies
>     at member-set resolution, not at admission. Whether a miss frame
>     reaches the CPU at all depends on the IMP routing from the other
>     subthread: with port 8 as IMP it does (indiscriminately), with the
>     in-tree port 5 topology it never does for LAN-class ports.

Only port 5 is an invalid configuration, so no wonder it breaks. The
only valid configurations are port 8 or port 8 + 5, but not port 5
only.

>   - BCM63268 and BCM53115: Jonas measured exactly this case there.
>     Standalone RX works even on a table miss, so the CPU copy exists,
>     but forwarding between ports does not. That is the case you are
>     asking about, on two other generations of this silicon.

Note that BCM53115 also supports a dual IMP / CPU setup, and has the
same limitations, so this isn't something new to BCM5301x. The only
difference is that on BCM5301x the switch is embedded and has ports 5
and 8 (and 7) hardwired to internal MACs, which led to the incorrect
usage of (only) port 5 as CPU.

Best Regards,
Jonas
