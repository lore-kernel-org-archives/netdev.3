Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520145A2A9
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932121; cv=pass; b=MhbF6/A9RklBAgsdpSrIKW3wPa5qZaLcFpycu/h8XQgZfTR8fCwUyFYsfc7J6zoiLjy3ggV2DGa6OarrkSExaw2LuKdj3aRy9oOY6QpxmSrryUHH5yjX0ibOmNfsOZ0AbkCZIUsV5fzQLb+F5Eueili7AiCJEtQjg00KUgxOOwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932121; c=relaxed/simple;
	bh=hM4rW4kBHXb6Csn7q4yA3plGYOehTY7q6ezg7XG/M7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmHy9boDfJ8OTKTLJYa/UoqOG+zFkeiNU/ymYnWk/6mTdOVlKMYzkSG3ygUAiWDOXvXxFUM2rsw53c/dybF3GBl6nHZUVpk8Xk0LjA8k+KLnMd2faUUGPLWPdenGj6nUEuu4xCArPLoOjezIcT4nVOEindvsG1k9cdNhmlhdv4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5bOtfK9; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5bOtfK9"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20363107f4so98752466b.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 05:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785932117; cv=none;
        d=google.com; s=arc-20260327;
        b=LzUPMMX6skIgi+9zdtr7yB+9uzmEQX1IHnesiexY16lPdm9uLb8trjomHrXtvSlstB
         VURRkh6JUdjJPmD6yEM7eOWjjRz0KPkYMbSwUezn5BCah3BaXit+cvSDVoRVunJ6slF+
         oeGwZZUjJwznQtVmJcqOJggNj/cCSjxw0WqWrBt/Ig2a8hYMjWz0HmOi08u10BoLrjdg
         +4Qs56P02efMggQ4nUgLtFVbPNaz4TMCAnMx/UlT4Ddcn1CocxPGjcVgQixFFCNpbMoB
         Lzvws5CVY5Q1dQVIFIp2YxV6zXseDxZ/4NXxRy56marSQLf0bqNpYQfA41m3OT7PVJCN
         W8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iMWwIcs0xWh1pHKE4O8EfEzUf2rTBX1k3h8OgCjQgKc=;
        fh=Ogvbgo1P1Wfr8NB38WGpaY8rJFsLAMBjWSIBBratApo=;
        b=U0Eh1PUowdm5OrY5mWXpxcRCGtH+BkJQvV+sbF0Amu4gNVBGD1grk3Moe75+s+hK7Q
         WFvzSKBONoNlUjh+GQ0jb4qzaiAVjIq8jnd1LHJ8Ci2pV6EBVEi6bReUwMBCvYMopYpi
         noMWGw+9pqiHX2qUczFKeGnmVdk4sPb5Uz6pm6S/hfiFT8iKc41EgGiihB5arAUZVEEO
         rGmD0GNvfTmD7HUvds1ZNmSjzWec3tMbuLwTebtWPgoMnfhbq0Fpgyqy5BMvkb+6oZqQ
         HfPg8H/JlDODmjueERbO7n3dxJcHM+fvgMRk9RgSC9bs/IO/pUzDuOvN9v1lT8Cv2FtI
         ezBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785932117; x=1786536917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iMWwIcs0xWh1pHKE4O8EfEzUf2rTBX1k3h8OgCjQgKc=;
        b=V5bOtfK9ETf0QbgyuoPA5mMyc2zNqv70SmIdobV56htQWgsZMX7K4Z+xRypnE5rEWH
         NLL0WglP72Vt8Y1HK/AMzO2D1Ne+BeLJ4m0t0CuHugEj4u+4Lpl/zNewNOqYvIvjHrxx
         OvsizvxO+/JN5dVPPLhERMSEt6lOGB1V0PtHcqJ+CaHD5TMK0DM9c+GLkzDk+6/epXCn
         0iSVNSyTUuQtzA5cWBL6C+E07BLUQX37jR1la+GLPclUUTY7OP4RPXjgBKn9etcZe0Ka
         x/Tn8QKMjw1/TOm2R7CJot4Z7HUqqB6/V8cyWTLUcQwuYk2x+ZqUz6UvI8qSlzKmEoyt
         h4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932117; x=1786536917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMWwIcs0xWh1pHKE4O8EfEzUf2rTBX1k3h8OgCjQgKc=;
        b=IbJqBNMKzsYnmbgLd/FxK4/bjRYvuxnkM8e655l0YiLgWHp/y7V1wJQKxBeFGj/Lqu
         dd3eDZdcguvNbDmW5H3+5FplUuNyqCxMWYcO427A7cjvfHuKnamXL9pRPgtqVfHVYbCp
         U0iz9+EyPBZLCaQizqgXIhR/O1J8Xt5R3CoDdZmz2cbbx3yjRaqrXYcpqXuePNimm/Nf
         puZLrdSDja9HwqsU9kMz1bD9i+1M+mm7AG+QctEunwiKSwOiu8DxpvlSdPQO6aDKX2v2
         yTZEZZzkftR7A6lpEM2W+9DUg7C/AJAdFlv8MVJxvpge3XY5Esr1BMNZwn6rcSKOrWVP
         abYQ==
X-Gm-Message-State: AOJu0YwNAJZQEaf3iFn5EVXFLwPA5EcmucRCRrBOqGxOVtEqkl1XUZdr
	sh8Fl14+mLX1H6wL0hjLMjBNjeK1FM1sU6AIKtvjOYhkc8ySQnhoOoYh0wSAuE0xxVgje1auX6O
	/pmUEz99ve7MahfbL/pGAeXUJgt+QhPc=
X-Gm-Gg: AR+sD13JRhlla9JTotq/U2f7fZ2W/DJxrL6Mn43wwlU31rPy+KntTod6SKziHrFpfJh
	rRNpRtGsNp11KV7UloS8v5A+iXPWdf7tjTBnQ0iu6y52V35+lYVJaQMSq03FQxxvxGFQxpBDygb
	o+33Xkp1O/L69sMuBVE/dLUtKCkvbUjfcIuy84bpdTsblfgJKk8UG35AU0Klbi5CkEv0dkpUGCi
	XCUPbxOTyHysC80v69y66Ru6QVV1LzlmGV7XBzV2JynB4u3kxrNvBXAXDORMO7IbrM+AlXyN67X
	TGV6LTMFcdI8Mp+OBfL+hpJz47zxl5N9s+DNjEuFg7wF/sDsecwZDKJJ
X-Received: by 2002:a17:907:94c3:b0:c16:5cf0:3aff with SMTP id
 a640c23a62f3a-c2039ef01abmr283671566b.18.1785932117071; Wed, 05 Aug 2026
 05:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805070851.2885888-1-pawlik.dan@gmail.com> <anMJcp-R17Hx6DQL@lore-desk>
In-Reply-To: <anMJcp-R17Hx6DQL@lore-desk>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Wed, 5 Aug 2026 14:15:05 +0200
X-Gm-Features: AUfX_mxi7EYRrp2aol42yH7BvJv5JuaOmq_wG_46Ap5ob4pD0cDCrwN83dn9Pyw
Message-ID: <CALC2AphygKfbqvAx2_gcSV0bfZiTd9roe+c8Ekw8LfVFOOMu_A@mail.gmail.com>
Subject: Re: [PATCH] net: airoha: npu: use coherent DMA for mailbox messages
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, win847@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,
thanks for taking a look.
Hardware where I see the regression:
- Board: Gemtek W1700K (OpenWrt U-Boot layout), aka Quantum Fiber W1700K
- Airoha EN7581
- WiFi: MT7996 (eagle), NPU firmware
- Tree: OpenWrt main branch + patch related to update kernel to
6.18.42 - https://github.com/openwrt/openwrt/pull/24551

Please let me know what you need next (dmesg, DT snippet, etc.).

Thanks,
Daniel

=C5=9Br., 5 sie 2026 o 11:59 Lorenzo Bianconi <lorenzo@kernel.org> napisa=
=C5=82(a):
>
> > Commit 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox
> > buffer") switched airoha_npu_send_msg() to DMA_BIDIRECTIONAL so
> > non-coherent CPUs invalidate caches before reading NPU GET responses.
> >
> > On EN7581 + MT7996 that change regresses probe: the mailbox completes
> > successfully, but WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0 and
> > mt76 never binds NPU offload. Healthy boards report 0.1111.
> >
> > Mailbox messages are tiny and already copied by the caller. Bounce
> > through dma_alloc_coherent() so the CPU observes the NPU-written
> > response without relying on streaming DMA direction.
> >
> > Verified on Quantum Fiber W1700K (EN7581 + MT7996).
> >
> > Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox bu=
ffer")
> > Assisted-by: Cursor:composer-2
> > Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/airoha_npu.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/eth=
ernet/airoha/airoha_npu.c
> > index b679bed952de..d2f6c9c084b8 100644
> > --- a/drivers/net/ethernet/airoha/airoha_npu.c
> > +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> > @@ -166,12 +166,21 @@ static int airoha_npu_send_msg(struct airoha_npu =
*npu, int func_id,
> >       u16 core =3D 0; /* FIXME */
> >       u32 val, offset =3D core << 4;
> >       dma_addr_t dma_addr;
> > +     void *dma_buf;
> >       int ret;
> >
> > -     dma_addr =3D dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL)=
;
> > -     ret =3D dma_mapping_error(npu->dev, dma_addr);
> > -     if (ret)
> > -             return ret;
> > +     /*
> > +      * Mailbox payloads are small and bidirectional (CPU sets the
> > +      * request, NPU writes the response). Streaming DMA_BIDIRECTIONAL
> > +      * mapping regresses EN7581+MT7996: MBOX reports success but
> > +      * WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0. Use a
> > +      * coherent bounce buffer so the CPU always sees the NPU response=
.
> > +      */
> > +     dma_buf =3D dma_alloc_coherent(npu->dev, size, &dma_addr, GFP_ATO=
MIC);
> > +     if (!dma_buf)
> > +             return -ENOMEM;
>
> I tried to reproduce the issue locally, but it does not occur for me.
> Moreover, I guess dma_alloc_coherent() is not the right approach since it=
 is
> usually used for long-standing descriptors (e.g. tx/rx DMA descriptor rin=
gs).
> Can you please provide more details about the hw you are running?
>
> Regards,
> Lorenzo
>
> > +
> > +     memcpy(dma_buf, p, size);
> >
> >       spin_lock_bh(&npu->cores[core].lock);
> >
> > @@ -191,7 +200,9 @@ static int airoha_npu_send_msg(struct airoha_npu *n=
pu, int func_id,
> >
> >       spin_unlock_bh(&npu->cores[core].lock);
> >
> > -     dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
> > +     if (!ret)
> > +             memcpy(p, dma_buf, size);
> > +     dma_free_coherent(npu->dev, size, dma_buf, dma_addr);
> >
> >       return ret;
> >  }
> > --
> > 2.55.0
> >



--=20
Z powa=C5=BCaniem,
Daniel Pawlik
