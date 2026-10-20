Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499869;
	b=5lpphaMUws6hNmxGfh79L4CoOLD++POk8md0Vh7ufQtpN+4bxwYB+eHLJ6qehnXvVNjp
	 jFg4iEbPWiix06AK29x4NviWDc2wgEPmshCHKSB1BzVnK8F3uPEQAAqLsIvIrH27lqLt5
	 z3q0U5dnWmA4aSMn661uUyvMlG8uC2fYDBpud0Yhu+Bj4tPeejZXl13cd5suBwRmHI9Ef
	 MVEhDVhknYEP113u67P3hA5Rkpg7AC98K6xRVE5y/XqWK0IEiP4MUotgphpdn3rzBI273
	 kMamYoNI5TRTFL7kx67vSuTtV1ppISEc2XiXeqK2wKdceAU77lDvj+nVa0WnjMmGAGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sAk8vAv8nUAyr6JPeIhpU/yIjHpAZXyzJ6Jytkg7sB4=;
	b=AbZWhxwIcDuW6vwC/Ntsd0xzOAeXUy9o5KRUGJr+zQHBquFgdHv5JCpoDZeL7GRQYqV5
	 N/Sq4v4PU4h2RwgrXNyT6V36ZhDzoMYABcLOO1QZBRVUS1GUbk31Os4yxuDhf+7cdxOBz
	 DE1a+n/OSZxcR4Gios9cR1q6wDZTI4xKv7DMqfpu12UuW2cw6VoslV0i2/jLfrdgVx/+r
	 m45bRJvlyGust+gRjgWpMfYCR3o750SwPwchnA/hK6Fw89WwSgep2VMFNQO/EAi0QnjUi
	 9zZ+Z615fOUrm9UkJuB/GSMYLYSV5FZ+eq5cd4fjVmUeC1xJjuyZMevRWJX0/sKVosw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRxIjce7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D52606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lRxIjce7
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6dde81a6820so2258567eaf.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 05:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792499867; cv=none;
        d=google.com; s=arc-20260327;
        b=UVD/Oxj9NqdKnz+XBc47HC8EmasYo9tLuD5UUtMRuVdjRGgpnfL9dtdaCnhjpYpLao
         7TRPbI1XTA8hCJUd+VACr83aVFbuewBEYLZ8BHsKtH7LdLVeVzt5yLOikEUXCMTUwrJb
         AdaA+Wuq1skM8Hh8VVaPCUC0D/ZlhZ3pyKVhNNGQmNcXf3LA2WnkLmeC+/IhLANd5FoU
         7kY2MpmcDsnGWIEdrDQx8qJPoDiRCdWPDqy9bdKIKm2IX5d66a4dvl0cS10AjHKjstpK
         +8MR4opBy5ZQutwQNBkE4++HcDfCWmdcemOIU7qOhzCRSpSzo2i1RALAuz+B1tuHhYyM
         /rEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sAk8vAv8nUAyr6JPeIhpU/yIjHpAZXyzJ6Jytkg7sB4=;
        fh=kVyRZ/4+O3PW2RVmmlOlBWHBbLldzKBxkBaip/OsdFc=;
        b=Uis6RX1+W0Y1bNyFFh6VTBkQrh12amNJAsYuCv+KsLR/8XNdfn5dBusy2Cs+wj2LQ4
         fArD+0/gjegt3j0BeJXBQfgA8rUNx9wmpUQ8czwwtMvQa1UJMudGBhi2ZdJTGOc/fRSv
         IL9t3SmLmYla3niQofDCdGJRyH5/01V5k4vfl2gu2YMI6Ky1DCUBLW/3EvXYq17tvL2D
         uYQGQV+utoXBUorEU2KJWGEIXSntj6Svpljd1o5oe2Hd7Wvg742ckby/cnQ9kFbS+OLa
         WDlXl3tN7aocO/DwxN/DOvg0O5L0usYJxTDEKG/7rRNq2LLF4zausTgn0eu3lhhVmFL4
         +kNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792499867; x=1793104667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAk8vAv8nUAyr6JPeIhpU/yIjHpAZXyzJ6Jytkg7sB4=;
        b=lRxIjce7c4p5s9C+TaeR8dFSAHuJYut2Flz9NmEEgv1zGqpb4BbQVa2TFONAZmm9z4
         VcnyOV/kmjaLSztdLCulYL7hLAlzuPuLgEPb1eAG+kLm6BdIcscPc5BgAEBrNZtCtEX6
         J8YV8IwxaAJl8mUFB7WRwPm0gqsiyzekghSxApsK5wBrPBAX+4/EGR/ghdqwUEkVsnN8
         h6c1wF7Lir6OB0FsZxg1gt0kuB1OvmQbrKpUNvju16grj9rYQGHRbzqm4NP5a58tF/in
         IWjqz9K9FfJfXdn5VgTfqnSEFpdVtwLBdgqdvO9IUz39XgMqKmj9bWNeLHfOYvgftNRS
         z5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499867; x=1793104667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAk8vAv8nUAyr6JPeIhpU/yIjHpAZXyzJ6Jytkg7sB4=;
        b=lbL5+VbyAJHvU9YaYYcOyYO6cKYV2LT8V8BBxPiid2pXuBz8pdi/HFYFQUOfU5NBK7
         9v5SLt0P4quktM7Zs90DuR9Qi2V291DZBZUjaQbzmCq20DkwIkDUjqObVI5vlLKbSpx/
         rM2cddAWtnxhS50cW3JJT6WNBuWYs3nfhaEaWlzDI1I4DsQQP4Gp8+DFUx32wFCBYdgZ
         TswSq7+2ijF9biSicjWZlMqRv7+NHW1UZKip+XqULv4JYw7YysQ2+G8CgWXopPlsEIWv
         0R5DO5Xw5Lj+YRijWc46aHacpZjXF8GD/BQMTNAtgPoYHjyhVwlXvLQj0/2zclNJtbxO
         Wewg==
X-Forwarded-Encrypted: i=1; AKwUvBwjZer8JC/jeWUJ+kesaQfOGVLWM5r5EX8L+sqXjDD0gZ0g+dKX9KIB5z/DdUQg6MI75qI1/Go=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjhjb+AweezJ7k5Ewf7HU2B85Hni0tfSwPhZsoWXb2qpyURoSw
	PKdBcHhYGKFWxtTI0IWaIii8AjX21t7v5VBSXpwqgT97RKynwRB/gnRIaUeXYpZ0j1Mq4LPxVR7
	a1WpsHUy1ZYQBKGQx4GX2HBM41ePfiviRtGEIUck=
X-Gm-Gg: AYBFou36TXif6paisfRpqzmE5FRuqSeqJJ27XG92IwZI+0NVU0ClR27O+OKjqD0ypkr
	f9QGWGK7lYN7nOFEtKIPfZVDk/8H1ZuTO34uCEkoiKFNw2un14fPeS5VSx/CA+JmcsIlFzzHA22
	ddJB5ETrCcQuiivO1U/UzXQSYSkh2IbVqzZGArcjGUdT3rY1sCbqe3NBgZXIuFqtyiXdMrfzXSa
	Tb7qYq3NFG//mck0bI79aX1GY9TM80N7cAj4w3ee/vYyIzRsNnuS34ngs/2xpVdAjKYJaPvQqgr
	mzuh0r8ujYF2DuN0l4IE2xE/SR1o43v8JPuTZnaaY3VyBxbI/v2U9DU=
X-Received: by 2002:a05:6820:f023:b0:6f5:a49:6175 with SMTP id
 006d021491bc7-70355983cd8mr7947845eaf.14.1792499867428; Tue, 20 Oct 2026
 05:37:47 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016-wedfix-v5-3-8b02e78fd34f@gmail.com> <179249104276.3135.12420565113536395663@kernel.org>
In-Reply-To: <179249104276.3135.12420565113536395663@kernel.org>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Tue, 20 Oct 2026 20:37:35 +0800
X-Gm-Features: AclHuK9NT-9EOIYyPIth6-MRT74ZwJUNVrZ8OhqVSMXdfi7sbVHRzVyLo962vUM
Message-ID: <CAHGaMk9E7b=3vJku55Qs2shoV8pkXF5OtBsDC37-H7AuEu0iJg@mail.gmail.com>
Subject: Re: [PATCH net v5 3/5] net: ethernet: mtk_wed: free up rings during detach
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
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] Copy-paste bug in the new rx_ring cleanup loop in
>   mtk_wed_free_rx_rings()=E2=80=A6
> - [Medium] The new flag gating in mtk_wed_free_tx_rings() causes a leak
>   on partial setup failure.
> - [Medium] The patch now frees the rx_ring descriptor memory in
>   __mtk_wed_detach() =E2=86=92 mtk_wed_free_rx_rings(), but WED never dis=
ables=E2=80=A6
>
> --
>
> net: ethernet: mtk_wed: free up rings during detach
>
> This commit adds frees for rx_ring and tx_wdma in mtk_wed_free_rx_rings()
> during __mtk_wed_detach(). It also sets MTK_WED_RING_CONFIGURED in the
> tx/rx ring and wdma tx/rx ring setup paths, and only frees rings that hav=
e
> that flag set.
>
> Link: https://github.com/mediatek/mtk-openwrt-feeds/blob/main/25.12/files=
/target/linux/mediatek/patches-6.12/999-wed-04-Fix-reinsert-wifi-module-cau=
se-memory-leak-issue.patch
>
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethe=
rnet/mediatek/mtk_wed.c
> > index 3f0be70c3f145..b8264435acbe5 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> > @@ -949,6 +949,16 @@ mtk_wed_free_ring(struct mtk_wed_device *dev, stru=
ct mtk_wed_ring *ring)
> >  static void
> >  mtk_wed_free_rx_rings(struct mtk_wed_device *dev)
> >  {
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(dev->rx_ring); i++)
> > +             if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
> > +                     mtk_wed_free_ring(dev, &dev->rx_ring[i]);
>
> [Severity: High]
> Should this check dev->rx_ring[i].flags instead of dev->tx_ring[i].flags?
>
> The flag on rx_ring[idx] is set in mtk_wed_rx_ring_setup(), and that
> function never touches tx_ring[idx]. The existing reader in
> mtk_wed_dma_enable() also tests the flag on the rx ring itself:

ACK will fix it.

>
>         for (i =3D 0; i < MTK_WED_RX_QUEUES; i++) {
>                 struct mtk_wed_ring *ring =3D &dev->rx_ring[i];
>                 ...
>                 if (!(ring->flags & MTK_WED_RING_CONFIGURED))
>                         continue; /* queue is not configured by mt76 */
>
> TX and RX rings are set up separately, so their flags can differ. Take
> MT7992 with a second HIF:
>
> - mt7996_dma_init() puts band1 RX on the primary WED's rx_ring[1].
> - mt7996_register_phy() sends band1 TX to wed_hif2.
> - mt7996_init_tx_queues() then uses MT_WED_Q_TX(0) on wed_hif2.
>
> So the primary WED's tx_ring[1] is never configured.
>
> In that case, is the rx_ring[1] descriptor memory still leaked on every
> detach? This loop skips it, and the pointer is then lost to the
> memset(dev, 0, sizeof(*dev)) at the end of __mtk_wed_detach(). That looks
> like the same leak the commit message says it fixes.
>
> mtk_wed_free_ring() already returns early when ring->desc is NULL. Would
> dropping the flag check here be enough?
>
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
> > +             if ((dev->tx_wdma[i].flags & MTK_WED_RING_CONFIGURED))
> > +                     mtk_wed_free_ring(dev, &dev->tx_wdma[i]);
> > +
> >       mtk_wed_free_rx_buffer(dev);
> >       mtk_wed_free_ring(dev, &dev->rro.ring);
> >  }
>
> [Severity: Medium]
> Can rx_ring[i] be freed here while the WLAN chip's WFDMA RX engine still
> points at it?
>
> mtk_wed_rx_ring_setup() writes ring->desc_phys into the WLAN chip's PDMA
> RX ring registers through wpdma_rx_w32(). mtk_wed_dma_enable() then turns
> on the chip's RX DMA:
>
>                 val =3D wifi_r32(dev,
>                                dev->wlan.wpdma_rx_glo -
>                                dev->wlan.phy_base) | MTK_WFMDA_RX_DMA_EN;
>                 wifi_w32(dev,
>                          dev->wlan.wpdma_rx_glo - dev->wlan.phy_base,
>                          val);
>
> mtk_wed_dma_disable() never clears MTK_WFMDA_RX_DMA_EN. On normal teardow=
n
> mt7915/mt7996 disable DMA before mt76_dma_cleanup() detaches WED. The
> mt7915 probe error path does not seem to do that:
>
> mt7915_init_hardware()
>   mt7915_dma_init()
>     mt7915_dma_enable()
>       mt7915_dma_start()
>         mtk_wed_device_start()     <- WFDMA RX enabled
>   mt7915_mcu_init()                <- fails, returns without DMA disable
>
> The probe error label in mt7915/pci.c or mt7915/soc.c then runs:
>
> mtk_wed_device_detach()
>   __mtk_wed_detach()
>     mtk_wed_free_rx_rings()
>       mtk_wed_free_ring(dev, &dev->rx_ring[i])
>         dma_free_coherent()
>
> If the chip writes back an RX descriptor after this point, would that
> corrupt memory that has since been reused? Before this patch the ring
> leaked, so such writes landed in memory that was still allocated.
>
> The error path leaving DMA armed predates this patch, and the RX packet
> buffers were already freed in this window. Whether the chip really writes
> descriptors after MCU init fails depends on hardware behaviour. Freeing
> the descriptor ring here is the new part.
>
> > @@ -959,9 +969,11 @@ mtk_wed_free_tx_rings(struct mtk_wed_device *dev)
> >       int i;
> >
> >       for (i =3D 0; i < ARRAY_SIZE(dev->tx_ring); i++)
> > -             mtk_wed_free_ring(dev, &dev->tx_ring[i]);
> > +             if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
> > +                     mtk_wed_free_ring(dev, &dev->tx_ring[i]);
>
> [Severity: Medium]
> Does this leak the tx_ring[idx] descriptor buffer when
> mtk_wed_tx_ring_setup() fails partway?
>
> mtk_wed_tx_ring_setup() allocates the descriptor before it sets the flag:
>
>         if (!reset && mtk_wed_ring_alloc(dev, ring, MTK_WED_TX_RING_SIZE,
>                                          sizeof(*ring->desc), true))
>                 return -ENOMEM;
>
>         if (mtk_wed_wdma_rx_ring_setup(dev, idx, MTK_WED_WDMA_RING_SIZE,
>                                        reset))
>                 return -ENOMEM;
>
>         ring->reg_base =3D MTK_WED_RING_TX(idx);
>         ring->wpdma =3D regs;
>         ring->flags |=3D MTK_WED_RING_CONFIGURED;
>
> If the rx_wdma dma_alloc_coherent() fails, tx_ring[idx].desc stays
> allocated but the flag is never set. The -ENOMEM travels up:
>
> mt76_wed_dma_setup()
>   mt76_dma_alloc_queue()
>     mt7915/mt7996 dma init
>       probe error path
>         mtk_wed_device_detach()
>
> Before this patch, mtk_wed_free_tx_rings() freed the ring because
> mtk_wed_free_ring() only checks ring->desc. With the new check the ring
> is skipped, and the memset in __mtk_wed_detach() then drops the pointer.
>
> mtk_wed_rx_ring_setup() uses the same order. A failure in
> mtk_wed_wdma_tx_ring_setup() returns before rx_ring[idx].flags is set, so
> the flag-gated rx_ring free in mtk_wed_free_rx_rings() cannot reclaim
> that ring either.
>
> Since mtk_wed_free_ring() already guards on ring->desc, what does the
> MTK_WED_RING_CONFIGURED check add in these free loops? The commit message
> does not explain why the frees are gated.

The flag was from the original vendor patch.
I will change to rely on ring->desc.

Best regards,
Zhi-Jun


>
> >       for (i =3D 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
> > -             mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
> > +             if ((dev->rx_wdma[i].flags & MTK_WED_RING_CONFIGURED))
> > +                     mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
> >  }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261016-wedfix-v5-0-8b02e78fd34f%40gmail.com
