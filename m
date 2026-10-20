Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500150;
	b=C5Zsg/W//znCZdSJB9iPUNJhAzfRV5HHUOtxp9/ZSFUQ1D6gyRPtop30JWWCSSFKrc+9
	 I+8TZiOzI64SP2OGznS0cQjtgXHmKYPKX8qpteFzjFN/x4/m5cE8obhB5+OUgLwUOp+h4
	 AbMMqExp7wXHRv9voemfywJtgAt3AdhTsrMg2BFt0dnjMqN3xPYQtS5fEKYunjQlmHSpn
	 VPcdnZDrriDnEmu+8rlsPOXTiwHhbi8CvhdVLep0k8hd+aaHlH93fNx7D5ovyCD7Y6Otx
	 zLGMfILkHjWAxpHLYnDvxqGzdOXMcNzOfyENeCcSPYcYqdpfo0aipblDfSlLis8SxYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=czINu4tNn892A/gqG20V0sIiMq+iNhxvP3cIYEKn6GM=;
	b=JSM+b/WA5oKFuGR7ypBWEsTYfbbjiVbrlnHaIOFejYUPE6aTRIHDPoyk1BXvdfoWVHFA
	 rdPxAO3x6b+YmHINdbvjQqZtGidoIdq6XDd0q47DeqO72yCK0YbRtnq4afoQL2NZNOVNj
	 tyduEDWuvvkV/pzcg3QdSl7QwEuYgwIwAr0Xd3NvkvGF/QyO5z2L4ZPAMmK0AoZSY/ztM
	 FtMWTPT/qc9UOskZktxPBq3d9PuW6AR0p34S3h8xPSgBnJgILx3Ps0z/TP9/Y5vJtePQp
	 TMn5SEWvjreyh9TDLMUBakrRDxQuwjfXO5PIcZhX5xNm5cA0os6QAN5zxA+LLkToqtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EJIrdUmF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB68606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB68606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EJIrdUmF
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-5058b105df7so768318b6e.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 05:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792500149; cv=none;
        d=google.com; s=arc-20260327;
        b=sZTMCwJULj3dgVMiSbBCrFz65iOWt3NULCDrN6bfKEaf/QxJZdeQpmyMVAvW2QnNgK
         BgcRFlBF8ISnXrKhoC+UGA97js39jzbL4qj/2x1P9ieDid9w6pUAUoRX3utzxMNlnyCT
         DEdxHxS3Zi27vvC33ILIAGE4MnxQ7hZSohqxX/a0TOZmefr5YOLxTO9IVIwV96D3dayP
         Nl8S3Md/nNR7rPpP9IdZzPp9N4qV1bl/LoDq7wYEMY2EtJ/R/Sy6+7I5UyVM98oY07DU
         8V54efJoDJp5Nd0Ex8i4QdS16wK5eNpJeJeDRLpHa+kR/Ulhhu8aWj27Ro7OvEE2fNdR
         5LvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=czINu4tNn892A/gqG20V0sIiMq+iNhxvP3cIYEKn6GM=;
        fh=ukyY8WytGylQbdha3Io9A1y6t7RnNXVzWA+BzlykTY8=;
        b=qorvM0iNiNiwxYswNJmjq/mmNME0BMffVQQchAjDzUv9r8XZMlbT0N+5KYHtezHIs0
         d0U3xtn+yqWFoyyklfk+Q+Ku0ln6iEKyiQ9Z5hl+RbPD5KNRzoWkaMTFJ7SqpktSdjM1
         tB0jXDGRAGBaH53XwdfJ/5D2L1wPOcqnmvJA1QdbI5UIBDgklXi+IJiT9sEvnC7njVdD
         uWPI4khxlEK2pWr18w+R5wKYgiQnzhxwQle86qSl+WWZlk5zxhOUakeR1OrbwjDX6b4K
         oTKDnKedSBxWDmsTHHuNr6WYih6F1UCPXdaP+lNYYW8vcRYAlDge0MBkEVYXUjYA99yI
         xJGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500149; x=1793104949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=czINu4tNn892A/gqG20V0sIiMq+iNhxvP3cIYEKn6GM=;
        b=EJIrdUmFYW+DvG+uj2erWSVOOTKZ8ZT88oyIgynWGqRk4sOJKBjmO/mDGIMpnqf+1D
         zB8N+05VUwmD+45eRntM+DqOVaJp4WdV3SujVoP5slAaWV+6v0GqMUI7WLkoE1RcR0j7
         TQKnjoVLOwsL13bAk+zKKFiv3TfYYEIFValRhRKzieFcemZtS1FK+olRVBOBnwDVyQ98
         DzekziBC+sEtKYsnyqM0c+BdDqQjhBH1CuIEV63FoTYN6HUfzUUiZw3kiIXb6+ufiGIf
         9Rd1bBcYMC/d7y18mfPznR93LWVbceBLo7qr+5uT7tyQyAjJe95NuYqG1i3RCi2HeGSz
         ZyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500149; x=1793104949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czINu4tNn892A/gqG20V0sIiMq+iNhxvP3cIYEKn6GM=;
        b=JKgX+4odz1x2Zx1JqydK2rj89qr69JdAkJbe0sqmEIdCwcmH0tj/6KSa9rW/kxyABY
         E8uDTOyTBg2H4lr1xkKXo3APiGNWh4jAhWpDyC99sRJwM7WrersxlALtP8VGF8dw4Ru9
         8UrwwHNteHEKHdQnTNL6Kvri2268AlL9qFReDeXNs1fAI52WiRXtIhii96vFYUgJQ7l6
         BBa4F3wkX3lNZOxP9wV0T6uUMMfAk7dXLAWxcZT5YIJq7GVnGrSJsEwFnuisLcnTAKcs
         yxz1C8bcZ86wdAWaowa7oOZv0mqV4jlBeErFquoEbzElpQelYPAPjgEloXGeamUcGIbQ
         Calg==
X-Forwarded-Encrypted: i=1; AKwUvBw00FBwdny9KMOQ4ziWqoxWqDqMJ0BvWsVXuGGdjjrHCoGVdbh/appb4gu38BGZ7FSp2fKp+r8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsShjJ5M8Zh6GTO7/bq/J0WE7U3On6UgI+Jfj9j6/YkNNUyqWV
	yBU9KZAXUTWvnkqN4W7NbFrQNlZvBOEtGivYBuJfKCH977genLOnPjoBzD0CZPjhMyeUlIfHQYR
	A3MRtP2Zo+hInWPjAJGi3gwlsaIxFOOk=
X-Gm-Gg: AYBFou0o8KBiizHvtyLA36qkxA4mJK5nODm/RWxxdTPNwlUSZY13127hJZdfNXhcYv3
	8bS888ArqeI/hpsWzRDCReFCh6nPuZD7UkWc7jPOYNitl5+lP2VYn+eJ+1cOs/umTifA5atYCn/
	mkX2t8Ax+QkuqAyhEntWY2i6gw1l86A44aEXEAYlFr+BGptFuwktL6N+mje5ysRfZEs6qQJF/xd
	1Hds/ZNPPTpQ5Ocw/vsOhdTVZqU68Tqk/MLF6Pc8f26FvfRfHC+JwiJNgQEuzlpWSdRthAlXHMv
	1IH/ECoSnCJGaQTlEtTXxeU0D+1bOPPyUnijv1AS4ArWxLNPVod10pzdYg7FVLp1zQ==
X-Received: by 2002:a05:6808:4f62:b0:4f4:b5ba:a236 with SMTP id
 5614622812f47-53ccaf299bdmr10702127b6e.10.1792500149414; Tue, 20 Oct 2026
 05:42:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016-wedfix-v5-5-8b02e78fd34f@gmail.com> <179249104567.3135.3150268582386164073@kernel.org>
In-Reply-To: <179249104567.3135.3150268582386164073@kernel.org>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Tue, 20 Oct 2026 20:42:18 +0800
X-Gm-Features: AclHuK9W4Es3s2qEoBcM8btZ9Y3bS_NG69-SBXVVPIf84hDXQvp4ykMnqjjWBv0
Message-ID: <CAHGaMk9LPyH-kCGLxP0q8s4-_Soed_NBqLVtdvUB7KOB1xJikw@mail.gmail.com>
Subject: Re: [PATCH net v5 5/5] net: ethernet: mtk_wed: bail out when failed
 to set up rings in wed_start
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
> Critical: 0 (1) =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new bail-outs in mtk_wed_start()
>   (drivers/net/ethernet/mediatek/mtk_wed.c) log a dev_err() and return,=
=E2=80=A6
> - [Medium] net: ethernet: mtk_wed: memory leak on ring setup error paths
> - [Low] The commit fixes error handling for two calls in mtk_wed_start()
>   but has no Fixes: tag.
>
> Pre-existing issues:
> - [Critical] This problem wasn't introduced by this patch, but it is a
>   double free in the same reset -> start lifecycle.
>
> --
>
> net: ethernet: mtk_wed: bail out when failed to set up rings in wed_start
>
> This commit checks the return values of mtk_wed_wdma_rx_ring_setup() and
> mtk_wed_wdma_tx_ring_setup() in mtk_wed_start(). When either one fails, i=
t
> prints an error and returns early.
>
> Link: https://lore.kernel.org/all/179000700034.2160803.105942816913840150=
89@kernel.org/
>
> > Add error message and return when fail to set up tx/rx wdma rings.
> >
> > This is suggested by Sashiko.
>
> [Severity: Low]
> Should this patch have a Fixes: tag?
>
> The previous patch in this series, "net: ethernet: mtk_wed: setup
> WDMA_RING_TX(0) for non-DBDC MT7986", added the
> mtk_wed_wdma_tx_ring_setup(dev, 0, ...) call checked here, and that patch
> carries Fixes: 4c5de09eb0d0. Without a tag on this patch, a stable
> backport of the earlier one could land without its error check.
>
> The unchecked mtk_wed_wdma_rx_ring_setup() call comes from commit
> 23dca7a90017 ("net: ethernet: mtk_wed: add reset to tx_ring_setup
> callback").
>
> Every other patch in this series has a Fixes: tag. The line "This is
> suggested by Sashiko." is free text and does not say which bug is being
> fixed.
>
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethe=
rnet/mediatek/mtk_wed.c
> > index 3a7c2bb33691f..86845893ae20f 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> > @@ -2353,14 +2353,20 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 i=
rq_mask)
> >
> >       for (i =3D 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
> >               if (!dev->rx_wdma[i].desc)
> > -                     mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
> > +                     if (mtk_wed_wdma_rx_ring_setup(dev, i, 16, false)=
) {
> > +                             dev_err(dev->hw->dev, "wdma rx ring %d se=
tup failed\n", i);
> > +                             return;
> > +                     }
>
> [Severity: Medium]
> Does the caller ever find out that start failed here? The same question
> applies to the tx_wdma[0] return below.
>
> mtk_wed_start() is static void and is installed as the .start op. In
> include/linux/soc/mediatek/mtk_wed.h the op is declared as:
>
>         void (*start)(struct mtk_wed_device *dev, u32 irq_mask);
>
> The early return therefore skips mtk_wed_hw_init(),
> mtk_wed_configure_irq(), mtk_wed_set_ext_int(), the v1 PCIe mirror map
> write, mtk_wed_rro_cfg(), mtk_wed_amsdu_init(), mtk_wed_dma_enable() and
> dev->running =3D true, and nothing is reported back.
>
> mtk_wed_device_active() only checks the ops pointer:
>
> #define mtk_wed_device_active(_dev) !!(_dev)->ops
>
> so mt76 still treats WED as active. mt7915_dma_start() has already put
> WFDMA into WED mode and written MT_INT_WED_MASK_CSR before it gets here:
>
>                 mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
>         }
>
>         irq_mask =3D reset ? MT_INT_MCU_CMD : irq_mask;
>
>         mt7915_irq_enable(dev, irq_mask);
>
> It then returns 0, even though it returns int and could pass an error up.
> mt7996_dma_start() does the same after writing MT_INT_MASK_CSR.
>
> On WED v3 with hw_rro, mt76 later calls mtk_wed_start_hw_rro(). That
> function has no init or running check. It writes MTK_WED_WPDMA_INT_MASK
> and MTK_WED_INT_MASK and sets MTK_WED_RRO_MSDU_PG_DRV_EN. Because of the
> early return, mtk_wed_hw_init() never programmed MTK_WED_RX_BM_BASE or
> MTK_WED_RRO_PG_BM_BASE.
>
> Can this leave a half-initialized WED that the wlan driver keeps using as
> if it had started, with only the dev_err() to show anything went wrong?
>
> Would it be better to have ->start return an int, so that mtk_wed_start()
> and the mt76 callers can propagate the error and unwind?

I will let the maintainer decide what to do there.

Best regards,
Zhi-Jun

>
> >
> >       /*
> >        * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] durin=
g setup
> >        * but tx_wdma[0] is also needed for WED to function.
> >        */
> >       if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
> > -             mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE=
, !!dev->tx_wdma[0].desc);
> > +             if (mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_=
SIZE, !!dev->tx_wdma[0].desc)) {
> > +                     dev_err(dev->hw->dev, "wdma tx ring 0 setup faile=
d\n");
> > +                     return;
> > +             }
>
> [Severity: Medium]
> This is outside the lines changed here. It is the same ring setup
> error handling this patch is tightening, though, so it seems worth
> raising.
>
> In mtk_wed_rx_ring_setup(), mtk_wed_ring_alloc() first allocates the
> descriptor memory for dev->rx_ring[idx]. If the following
> mtk_wed_wdma_tx_ring_setup() call fails, the function returns -ENOMEM
> without setting MTK_WED_RING_CONFIGURED on that ring.
>
> mtk_wed_tx_ring_setup() has the same shape. dev->tx_ring[idx] is
> allocated, and a failure from mtk_wed_wdma_rx_ring_setup() returns
> without setting the flag.
>
> The teardown helpers only free rings that have
> MTK_WED_RING_CONFIGURED set. In both cases the coherent DMA buffer
> for the wlan-facing ring is therefore never released by
> mtk_wed_free_tx_rings() or mtk_wed_free_rx_rings(). If setup is
> later retried with reset =3D=3D false, mtk_wed_ring_alloc() overwrites
> ring->desc and the old buffer is lost for good.
>
> mtk_wed_free_rx_rings() also looks like it tests the wrong array. It
> frees dev->rx_ring[i] based on dev->tx_ring[i].flags. Whether an rx
> ring is freed or skipped then depends on the tx ring with the same
> index, not on the rx ring itself. That makes the rx side leak more
> easily still.
>
> Should the error paths in mtk_wed_rx_ring_setup() and
> mtk_wed_tx_ring_setup() free the ring they just allocated? Or should
> the free helpers key off ring->desc instead of the flag? And should
> the check in mtk_wed_free_rx_rings() test dev->rx_ring[i].flags?
>
> [ ... ]
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but it sits in the same reset
> and start lifecycle. mtk_wed_rx_reset() does:
>
>         mtk_wed_free_rx_buffer(dev);
>         mtk_wed_hwrro_free_buffer(dev);
>
> When dev->rx_buf_ring.desc is non-NULL, mtk_wed_free_rx_buffer() already
> ends with its own call:
>
>         dev->wlan.release_rx_buf(dev);
>         dma_free_coherent(dev->hw->dev, dev->rx_buf_ring.size * sizeof(*d=
esc),
>                           desc, dev->rx_buf_ring.desc_phys);
>
>         mtk_wed_hwrro_free_buffer(dev);
>
> mtk_wed_hwrro_free_buffer() frees everything but never clears
> dev->hw_rro.pages or dev->hw_rro.desc:
>
>         dma_free_coherent(dev->hw->dev, dev->hw_rro.size * sizeof(*desc),
>                           desc, dev->hw_rro.desc_phys);
>
> free_pagelist:
>         kfree(page_list);
>
> Does the second call in mtk_wed_rx_reset() then read page_list[] from
> freed memory? It would also __free_page() the hw_rro pages,
> dma_free_coherent() hw_rro.desc and kfree() the page list a second time.
>
> This looks reachable on every SER/DMA reset on WED v3 with wlan.hw_rro
> set, which mt7996 does for the primary WED:
>
> mt7996_dma_reset()
>   mtk_wed_device_dma_reset()
>     mtk_wed_reset_dma()
>       mtk_wed_rx_reset()
>         mtk_wed_free_rx_buffer()
>           mtk_wed_hwrro_free_buffer()
>         mtk_wed_hwrro_free_buffer()
>
> There is a second, separate issue: mtk_wed_free_rx_buffer() leaves
> dev->rx_buf_ring.desc pointing at freed memory. Suppose the next
> mtk_wed_start()->mtk_wed_rx_buffer_alloc() fails at dma_alloc_coherent()
> before that pointer is reassigned. Could a later
> __mtk_wed_detach()->mtk_wed_free_rx_rings()->mtk_wed_free_rx_buffer() the=
n
> free it again?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261016-wedfix-v5-0-8b02e78fd34f%40gmail.com
