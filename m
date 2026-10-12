Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBB547056
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791766486; cv=pass; b=Uv88P/nJYwo2tdMe7ZThtbmq+62QIw36TgNCMW4TsRieUCsfOaMx/YFLUoFFy7NONtD0Tw7JNDreLJJp8Tk+F35jyvaQd5mtMxgKltUkoigqYVoikXu7KkbKSqrZNEeIewxhACADF0I1fUEkuZeVs4OvnSt6eWyOZxpJR9pSVJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791766486; c=relaxed/simple;
	bh=z73L5s6hared9oAt/obXy0ATGlrzfh6sbHRRtAq+RH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHqMDnxXartSQ6z0EuzbpNt0qCL25p89jeBIPXpxN3kC2a0oW9buOwUNozZSDIwxIa9CYv6NRPO2sAGTirfk/X2244clj+Vm4s85sAunBxdn7oBn9K/PnwEH0XUrbLYRV97sMEMptd8zJocutcyVzLmzv75+4VZyrwyjA9Mqu1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=odl9ciT3; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="odl9ciT3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e4f0d7d77so175914785a.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 17:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791766484; cv=none;
        d=google.com; s=arc-20260327;
        b=rNL8oNKavu8HLEdLu6d3SE1rLdZMESSeEXEcCdQ8Ld1Bu5dU6bIMb1cNGn8RZc3PC1
         ZYnlahSVsk5ZkPWkdSf8Mk8x8IZMIXFvLNW4jo2dAFjWAGPa8EymVqiB8BlOv80EiWLg
         JzjKseS0eOd2xx0YUC/odJW3RwnkuclUidSw0sexF5uAyCSKTeLdIGRBbVLUd6teVAo1
         YsSeWYJMKr2y5KYawyBS9C2Qivv+pxE3UlVl8ponmsorpfyAi7R1aQQJEqmFp83XKWqw
         N4sDOAJXtzqmGpj/7r2chooyGtB020SCZa5REYRFf5rxvb3iCGErGReNEdof+yQEWwQU
         zwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z73L5s6hared9oAt/obXy0ATGlrzfh6sbHRRtAq+RH4=;
        fh=chX2r1uUbcMmGmGJ8BxQ3LbJH1vqbzN9FNuCSV3JpnM=;
        b=c0qKATg4uNYrCjo/Aa3nCBxM6qqJ+P6/h80lx4JyC1lOI6isWpGuUrwU/hYdHCDspY
         uLZR2Ee1Zpgfepc4a5WAqDFfKQjKTEFLQ30NQjMyeM6oNS4LkdxGQR9OHuMezcMmapIk
         wZ3eLH6DguRSxH+53C4Eq6fDM3w49Sy9ElXDfKEMIM2ZOCTdK7I3iAoW3VsYoial88M2
         SlaZoTLUvttful1OcPp8QRdhsLjubD5M5wpFOC4PJJDbnfRpP5mkbo+CRa+dH0gLz7oO
         6HMvFbRrGcaUk14Y45UdL+Vi/iE62ObgsHnITJjBEo5kZ86fB5fbpyGFImY7gfwTNax4
         RmAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791766484; x=1792371284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z73L5s6hared9oAt/obXy0ATGlrzfh6sbHRRtAq+RH4=;
        b=odl9ciT3nV3wd9Uwxo4veYr02lJSyQMmDbo0aerb2f6DwfghsQyBw7WEi1ig35fy/Z
         Ba1eCA1hDrDPY2k5PfvpNJECZKr4rj/ZYwv2Tf3u8zbZ7WOOaOTE3oK9j8mTVoqDJWKs
         pX+zC5ltq8IxvGq3ceNAoe/9rjdhb1hD2p49/q51i12JkzVAEJBEGGtREO3K8ndojjG0
         pB+sBUtOYbqk/l6urGs/f4m83e5KXjmjHEm4xFDcyPLN87V0H1Pb4mzMzuajMY8x/guS
         uGxHfjrzUqKfUjwrs5feVcFk3q+tHnMxIPJpYcQOyLzFqVWYpb8JB0OpeBjs/wXgozw5
         un/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791766484; x=1792371284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z73L5s6hared9oAt/obXy0ATGlrzfh6sbHRRtAq+RH4=;
        b=cK/DwNkCLEcMTyQozhZ7kmNfsYMb23zLghjOUxiOsHNWClNaN6pj2HdeNTgL53Jp1a
         ooqzAZl5PjjgnhXmz62YGu0a+uUzm+JTcmX8wfsps4n/OmcYLJR1lKS7iw4wHiAdDTB8
         +QnFN00WBOR8sA53et/a3xOK8N+8ROHg9pf/BdZnuiWmqqQJHo9ovziEj23Fzjn1d8uf
         QRbrWvGiE8Nojb7uO62YdKcMwFpeODjFz+nCr8mstJBautpB/t2gBeTe6wwXSNySPd1Z
         phcdwJsdFDUt/GqOTyBZV07IiHwwwg1/M3ZPtJrhtHppdWEgugOAzp4uVODl0wT8ruwn
         vIsQ==
X-Forwarded-Encrypted: i=1; AKwUvByf8kcTXFHevBsnWicXgORTITr88Mboo6HZhy0nY+eWy3LGF283uhqJ5l29TclMG2aGhaWgihs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKEPdPKRlYPnc767u3S5PMKDxLLFDyph64DlvdJ6WBydSGKTLv
	i82qt5DFv1pdMKhzWBkJxjwa9dnOoTanWyMv4S1Afoo6H5jFycwvKTHgKlFqWtcN0MNLpHKjRCY
	i1hU+Ja6OMTD+hW/X5a0PE/4ZAFsIlNlnVhRLOoIwIz9tJO+UXFLBt8G0au4=
X-Gm-Gg: AYBFou13HWVh/Oxd3VMXFFaL92sbMdaYy0WtJk0iNF30axb7paU9IeVHSr7o13MhajH
	slEEBTqjfqEVdzdL+d7VDnbcQIb/GXx08xcYBviClq9PvryIJVafl4MDml1iJzqZacAjXJX7wzF
	BCiwkuEPiZABvkhB2tF18VFj6+U7djf036W4q1DNDirzwWF/oZIzGKQAWJWqfShArr0Y74VD+FA
	znv2MmtnkzR9zFI3/c1U6ky3hFGaxE6gPoqGvbsjUkxSon42Y24YoUASqFecsuvqj5HM4trEwrO
	7+T5rPDYTVvaYWQEEyaLEhB4CtihQIsTuGqD9MJ7VONXRjvFy4Xys1Ng+Z8U1ZvdjA==
X-Received: by 2002:a05:620a:1711:b0:93e:c173:f68d with SMTP id
 af79cd13be357-93ec173f8abmr1211663185a.33.1791766484355; Sun, 11 Oct 2026
 17:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009143506.2507607-1-jjc@jclark.com> <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com> <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
 <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com> <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
In-Reply-To: <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
From: James Clark <jjc@jclark.com>
Date: Mon, 12 Oct 2026 07:54:33 +0700
X-Gm-Features: AclHuK-h1OFPlo0ZWt0hvoY6EkyW_QWQiWizvFOHFe2U9C08x_069ctmbPv6tuU
Message-ID: <CANz3_Eae-M6V9XROx4GqPB+BVjVWWuO5JqGoBOybh0-D7DNZVw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Doug Berger <opendmb@gmail.com>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Russell King <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 8:22=E2=80=AFPM Nicolai Buchwitz <nb@tipi-net.de> w=
rote:

> > Let me just confirm how I would need to adapt my patch with that fix:
> > in the pdata branch of the probe, I would call devm_clk_get_optional
> > to find the clock on the mdio node, falling back to pdata->clk. I
> > would still add the chip-specific compatible string because the number
> > of MDC periods has only been measured on that specific hardware.
>
> In the unimac patch you would only need clk_get_rate() and can gate
> write_sts() on it. Not sure about pdata->clk though: bcmgenet passes
> its "enet" MAC clock there, which isn't necessarily the MDC reference.
> If write_sts() only trusts a clock on the mdio node itself, you don't
> need the compatible either.

Sashiko wanted write_sts limited to BCM2711 because the 63.5 to 64.5
window has only been measured on BCM2711 and we don't have evidence
that it applies elsewhere. If it doesn't, then we could potentially
violate what PTP_SYS_OFFSET_EXTENDED promises. I think one could argue
that this is too conservative: clause 22 specifies 64 bits and the
63.5 to 64.5 range falls out of that given a free-running MDC and some
other reasonable assumptions. Andrew made a similar point on 4/5
(https://lore.kernel.org/netdev/c136b0ad-6d7e-4695-b988-55eb37550d01@lunn.c=
h/).
Florian said he wanted a compatible string but I am not sure whether
because of this or because of the clock. In any case, I am happy to do
it whichever way you and Florian decide.

In the probe, I believe I still need to add a call to
devm_clk_get_optional() in the pdata branch, which is used when GENET
creates the UniMAC device. At the moment this branch does priv->clk =3D
pdata->clk, so it would not pick up the new GISB clock from the mdio
node. I think this new clock would live alongside the existing
pdata->clk: the write_sts rate would come from the mdio node clock,
but pdata->clk would be used for gating. I was not planning for this
series to make clk_set use the new GISB clock.

James
