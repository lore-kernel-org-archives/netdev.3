Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500008;
	b=yAgRya7vtZYDfii5sHyQJ9dVqOht1O3pygDgzMYQSiDw88SiFQ53x3KQN4CwqX6JBbWY
	 TKAgA5FACliENKnZcZDTEWkPSX4SDlqI8jS5DBMPjyVcziCF+8EACILW3dR6unI+cm0fo
	 AAdrSoQveP5EXu7jJ9XH/fnI4QEQI5kB91gP2nU5pB2v/dSe/GY8sbl4zX+C10VYpf74y
	 UkVlCKw+Za3hDCPBdnGQkCFRYodLaee6E/tob75guQG99AKqfGxDyy+amZXqYwBrU9VZV
	 EgGvtjw3bjTvy9K4Nz0biNE59EjNVM8fOv5OvuUVgwHasq1rx3tm1T4iECLpHN8SiBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BetBMRYgFSc2DhIuFhDdmiOw1ARuIusJ4xRACgSZqH4=;
	b=Fagj2cUVc4Af8xPBOf/TT4PhxX8TD0dHJJbQZ3i/Pia+CyHFZk2bphN3p5MFs9MlR8oT
	 YupEU4CdVyVuaUgOai62N/Td+PnEdUWwcHF8YcVwZ8Yh5hqEAHQ3MbOwzwnfg30/Vtvhz
	 TmPxvfgshMacxn8bu1k35v3+ZMxLI0RV1JcNbwWWyRstKLvynw0uzTaZn7D7TWsKi9Zp2
	 mNe3nIJWK4Bw0TSWefEc8b2DOzqrWMbt/bvbESx2xr/CupPK1HgOpY5QFGRMz5qmezKvX
	 HNRosuIIBcN4reLXDzCGnVEnll1BKoc2Fdaokl2KB3UlC1RQUOjJQ6IwongxeRSAaMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="C/larF+z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C5606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 652C5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/larF+z
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-451a49abd8aso3751360fac.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 05:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792500007; cv=none;
        d=google.com; s=arc-20260327;
        b=R7H4nKa8E5MWBh+Glh0ba2vAy0dz4pXhqXzuSmyFiKmYE4K/YYP31dCgRxGBqcjJ5u
         q+M+hWoAKwTJm7/pZL8C3l3vUxGWjBFCRj5Xn0Nd9bArt6XQkwmO9EVuwvhQLnW35Fy2
         1jtDYCj6a1+quVK+35Bi7gOEbhosUpyK9A14ANHY6s+UXpxUnnxu3yyXfVdUTmvNuo3z
         kfsRItPCCCU3w6H6XpUdmloEyIQrcPdZkhX8XL0sLLGaudGrl2VerU0L7tmiH3ROQDgH
         prXvMsNt+AVB9CFJFnhjcqOBMfAJNtWhccBMwlSvqKsoGnqxqZxGDJS4GhEXv3nVuR96
         /H/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BetBMRYgFSc2DhIuFhDdmiOw1ARuIusJ4xRACgSZqH4=;
        fh=Y6KKmDEX6sMlekIZd/vUDBt2IAP2JItHYGQK0jAar40=;
        b=JYSyzs9ZoHm/pwKiC7NPS2j8zl/mxvHfAfy4hH3SOCRRe9N3G0KHY7z2tkfxBFiK3D
         QQuUXixItcggW8XQIsoFNKekvJ2DRMp8diMds6x9Du97GheDtlB+RtpRtSf+iener7Jp
         tOR3GGKKVSXiyEM0df8e4VtuBIkNuab70puMg5iXAiRlYuB6bM1dVhvG89FyEPIpRR4i
         2UCeene4yUl7FcqX1edeOJ5vNvGlyZN+L4FGBEikZ2sc9S2VDMqfSW7mTijA/WsghsFb
         ADl3gm7e6hVsD28zrzNaLsBxx7RMmMJz6VZtOXMXM12VFv5dZc3vJtcQ6AbErf61p21v
         a35Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500007; x=1793104807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BetBMRYgFSc2DhIuFhDdmiOw1ARuIusJ4xRACgSZqH4=;
        b=C/larF+zQIcvjgUNDA2Zo5UF987wP3ZVjEAbll61xyqzcgvZJL/rF9Rstiprd9MZoV
         zZdiVBpBpBzWI142O8sxZRNlsPzzxbH31d2znQvoYbEpLdgGrGLy9fA55gFiwaqWmLIe
         oD/cbscHGByjiaknlZhq09odxOL5CVBFEhTLRELdmgYYOhmo1uZ35jedg36EYQDOK/Fn
         nRG+iW3RaYzuTv/iGKU8FoWhZ/bs6mnGDT2z+HlkfrEUDqdJsn6juWX7v6izVcUmG6Bm
         r9szi0MR/YdEt90PxGm6p2bnsRviieAVggrS0LXy2Tyr3asOokZutxMXh+YJYhRp+B0J
         LmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500007; x=1793104807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BetBMRYgFSc2DhIuFhDdmiOw1ARuIusJ4xRACgSZqH4=;
        b=W7/uhpTPXgxITyfrHfI5Oj4dKH9ejK1iCVZXr1yMeJzZbFGkEP3Q5DdDEcFBy7PcLQ
         qbocF284Cm048k9LgkQpGe4IdKg7XXrz95nVdyLv7Q3leAdB0hvQFrTdoa8HzxRd/IOy
         j5uS5rxUbPP2Mi+nKZ/tGSTgtBcQ1riGG3RrqTDW4FaEZxKxMO7UxOxNcp9EUcTouBj2
         ZiWb7WAk2asKue2A6LUVhusJMAvJeb5GvsLzpkka9TXFchh4R+Zwe4idZh3wEOYRJ8MK
         d94JzM8uHsHK/mJa3d1+oe/2aWPDFgk8Zg2V0aXjQ195WFysec9ucS8y2hjc72DcFEDN
         xv3g==
X-Forwarded-Encrypted: i=1; AKwUvBwZ+kWzeNZangH61p9F3CZOxIrng/DTco0Xric7qOC/gkxun+6J4Wp0JlynnlwBt+o1EXkBdEA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7MwQ80YruaDFfCZxT2UUypNPd+B+mVdp71EOKLAzia/eFEEQQ
	9wRa3escf3Uk0TAcR6deXP8aPJk4E3uj3YeZ/j5o/SJ9J+YMJUq5SSHi6OjNk50vzOersXGs91H
	+zl3mtD2AnKwO5o9oFETPl49i9i6vV9w=
X-Gm-Gg: AYBFou3Qj0UENVoN6UWp48f06W5NutSOIxLOxJYCUk9Pbm/zcIb0L78nkIh0ZuGl54R
	Y8fdlaM6FEiDINJqoTp58vPwqhTj+iq/rfIaFe4gfO6nwGBrlRB/brDBCc5rru5xkONQ1dMARbQ
	HrraK/Q82lZe0ustFJLLWUQKrPu3Ts6CQNdOfQ7Z72DjRu0eoxnzUaEN+oe5JatL4KcLYIcF2GG
	QuRdQWUhKrsyaUBeSNPHf8mCF0bhkSnfa9s2Sd6MshDCRiQy77O1mf/dlSK0YbahUsMqiamha1k
	cm5Eul+5sqhOjmlcrBtgTOIpXiJhWsHBlhwH828WlrzQJ7WXqR6k480X
X-Received: by 2002:a05:6871:3318:b0:48f:e107:9092 with SMTP id
 586e51a60fabf-4a757aae6afmr8050396fac.59.1792500007232; Tue, 20 Oct 2026
 05:40:07 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016-wedfix-v5-4-8b02e78fd34f@gmail.com> <179249104422.3135.15395792602371896876@kernel.org>
In-Reply-To: <179249104422.3135.15395792602371896876@kernel.org>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Tue, 20 Oct 2026 20:39:57 +0800
X-Gm-Features: AclHuK_65U3PRBzb3igZvto9UCP0w6AudGK3kTF-_hnuxHejq2eqf-9Bb3Meip0
Message-ID: <CAHGaMk_vCEyCB2_oeH89VNdaizKQ9uRd2a_Xj1Lz7FEDEbyC0Q@mail.gmail.com>
Subject: Re: [PATCH net v5 4/5] net: ethernet: mtk_wed: setup WDMA_RING_TX(0)
 for non-DBDC MT7986
To: netdev-bot+sashiko@kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	sujuan.chen@mediatek.com, rex.lu@mediatek.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:10=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In mtk_wed_start()
>   (drivers/net/ethernet/mediatek/mtk_wed.c:2362-2363), this commit adds=
=E2=80=A6
> - [Medium] mtk_wed_free_rx_rings()
>   (drivers/net/ethernet/mediatek/mtk_wed.c:954-956) decides whether to=E2=
=80=A6
> - [Low] The new comment in mtk_wed_start() describes the motivating case,
>   a non-DBDC MT7986 that allocates only rx_ring[1]/tx_wdma[1].
>
> --
>
> net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
>
> This patch makes mtk_wed_start() set up WDMA_RING_TX(0) on WED v2 devices
> when rx_ring[0] was not allocated. This is the case on a non-DBDC MT7986,
> which only sets up ring index 1. If tx_wdma[0] is already allocated, it i=
s
> reset instead of being allocated again.
>
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethe=
rnet/mediatek/mtk_wed.c
> > index b8264435acbe5..3a7c2bb33691f 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> > @@ -2355,6 +2355,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 ir=
q_mask)
> >               if (!dev->rx_wdma[i].desc)
> >                       mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
> >
> > +     /*
> > +      * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] durin=
g setup
> > +      * but tx_wdma[0] is also needed for WED to function.
> > +      */
> > +     if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
>
> [Severity: Low]
> This isn't a bug, but the comment covers less than the condition does. Th=
e
> guard matches any WED v2 device where rx_ring[0] was not set up, and MT79=
81
> also has .version =3D 2. It is not limited to a non-DBDC MT7986.
>

This is incorrect. MT7981 is DBDC which means two rx_rings.
My condition check is correct.

> Could the comment describe the condition as it is implemented, the way th=
e
> commit message does?
>
> > +             mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE=
, !!dev->tx_wdma[0].desc);
>
> [Severity: Medium]
> Should the return value of mtk_wed_wdma_tx_ring_setup() be checked here?
>
> On the first start, tx_wdma[0].desc is NULL, so reset is false and the
> helper allocates the ring. If the allocation fails, the helper returns
> before it programs any WDMA or WED ring register:
>
> mtk_wed_wdma_tx_ring_setup() {
>         ...
>         if (!reset && mtk_wed_ring_alloc(dev, wdma, MTK_WED_WDMA_RING_SIZ=
E,
>                                          dev->hw->soc->wdma_desc_size, tr=
ue))
>                 return -ENOMEM;
>         ...
> }
>
> mtk_wed_start() keeps going anyway. It calls mtk_wed_hw_init() and then
> mtk_wed_dma_enable(), which does:
>
>         wed_set(dev, MTK_WED_WDMA_GLO_CFG,
>                 MTK_WED_WDMA_GLO_CFG_TX_DRV_EN |
>                 MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);
>
> It then sets dev->running =3D true. At that point WDMA TX is enabled but =
the
> ring 0 base was never programmed.
>
> The other caller of this helper, mtk_wed_rx_ring_setup(), does pass the
> failure back:
>
>         if (mtk_wed_wdma_tx_ring_setup(dev, idx, MTK_WED_WDMA_RING_SIZE,
>                                        reset))
>                 return -ENOMEM;
>
> A later patch in this series, "net: ethernet: mtk_wed: bail out when
> failed to set up rings in wed_start", wraps this call with a dev_err()
> and a return. With that patch applied, the end of the series is fine. Can
> the check be added in this patch so it works on its own?

ACK. Will do.

Best regards,
Zhi-Jun
>
> [ ... ]
>
> [Severity: Medium]
> This code is not part of this hunk. It comes from the earlier patch in
> this series, "net: ethernet: mtk_wed: free up rings during detach". It is
> mentioned here because mtk_wed_free_rx_rings() is also what frees the
> tx_wdma[0] ring added above. Does the flag check test the right array?
>
> mtk_wed_free_rx_rings() {
>         ...
>         for (i =3D 0; i < ARRAY_SIZE(dev->rx_ring); i++)
>                 if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
>                         mtk_wed_free_ring(dev, &dev->rx_ring[i]);
>         ...
> }
>
> mtk_wed_rx_ring_setup() sets MTK_WED_RING_CONFIGURED on
> dev->rx_ring[idx].flags, not on tx_ring[idx]. So if rx_ring[i] is
> configured and tx_ring[i] is not, the coherent descriptor buffer for
> rx_ring[i] is not freed. After that, __mtk_wed_detach() calls
> memset(dev, 0, sizeof(*dev)) and the pointer is lost.
>
> One setup where this appears to happen is MT7988 with an MT7992 using
> hif2. mt7996_dma_init() registers the band1 rx queue on the primary WED
> as MT_WED_Q_RX(1). mt7996_register_phy() sends band1 tx to wed_hif2. The
> primary WED therefore has rx_ring[1] configured but not tx_ring[1].
>
> Does primary rx_ring[1] then leak on every detach, for example on a
> module reload? Should this check dev->rx_ring[i].flags instead?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261016-wedfix-v5-0-8b02e78fd34f%40gmail.com
