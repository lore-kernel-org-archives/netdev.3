Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4B223DE5
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785640837; cv=pass; b=T8k0L5obr6r9T/xvJNjbFeEJIryoGwOziUUiOeM5bWtakxDuudUo3PEX90wQvJU2Yo0PlgLc1bzR16c+yDMJLXfjgMSfHBkSc+OHL9sfccjahyO38OqgWOgyMfTDTVgWnEkHcoQGSFcSYGr0e0zdPLidi7cFDjsP9mkU+SlJ1s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785640837; c=relaxed/simple;
	bh=37d6zNcTsy1RXjb9J/nKzOHniDYn2k4MTPlFufKuap8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUBDTcP93JnR7j4HN4pX9dXdDbvcMjnOl9WFD20dOgzp4umd7nPByEEKhWt9EPj2rWDmLlEgGVIbNhPM9TNFgPnYzi7IjXFY4LG7+spZ2HuDJECMjjTrQuY+MS/fXa8uNQpwzmEJgcF8dPE2qbTnWmak97cXS2Ay4utkgQzql+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnNAYU/q; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnNAYU/q"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15e0279316so85373966b.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 20:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785640834; cv=none;
        d=google.com; s=arc-20260327;
        b=PbkdlT1YtTU4wJC3J7kYhpm/nGejsTIoIKpw/KC9xlnNbbv4Q/7csbtz915uf9G4h9
         rlbaoq8I9u6DZWejybgDidD7fePn08HQAxBcrjdm+OWLTo5Ey5IUTu/9g/Lm1xZre/Av
         nZUETUB04A8oYaCNuCy1/PfWP8e75DvfuaMG7X4yO+7aJ1zvKtjc5x8bJc2Dm5BMCOJI
         AY3JjjmSdFZPqRDoDdfmLHna0ZUL0yW/XEYa9xXOsNGCU+Tff4O15xqrDSeVaC5hSvAI
         hBu1sfPUkRI4p4BsU9AqgV4kv7s84+k4fX526c73kAm7blgM50WJaBxv0q3nC6NcHNo3
         +DUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dokjfNwvvyjCQVfo5U9weDVNiEMz1GgnQwdVbTp72Qk=;
        fh=WWKSx3+PIPMY1QFEuZlvo+XE+UC2jZ/vrfD8fLlCe2k=;
        b=pe6bQi/t+BFNAXJvMmMLkukkjpOZskOSLyM4ronZyjNZVUEEJcbHgYuQL5qJTK3mUL
         Bp5aN1An3dqYqxcP2z71UAsAvvaibp39QKtYoiiHKNh0oLlrhI1efMcsWR5F7RvLPdIJ
         e46sa1O4EavFF/y+FQd1ZFK3x2HAov8JvEf5V5WdvAigiNbUMAEhwbTQN61GBNR7XJnM
         WJOu9IZpeppyBy6mMJB6Zh6M9HRn4DxDvC4wAG209TNfMxbgWP6cwJU8TOem3KWPAuEw
         S3dNNt5oR3yWkUiterbs0b+fBPRO3B/0a/SqC/G+jsI2rAGMvKZjMdeOa34G6ImAwnd2
         Vtvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785640834; x=1786245634; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dokjfNwvvyjCQVfo5U9weDVNiEMz1GgnQwdVbTp72Qk=;
        b=hnNAYU/qFKRWgbc9r02o1IF6tYDO/BO1e8m64CwVS5kBQHjdRuKCYgVYhf74i0R5BH
         cGBdQ6JZ4UrXdC3oF18WgNUtl7nHGplbFFhcronjm4KpbYbkD1gYJyqZwJXF15Euno57
         KHz4kcSZBKRcULimuOdOXV6sNcshQ0MDZPDy9rYa4IAkMkmfq5ShyO7ctrq1lTy4StuZ
         Q/KONhpR44pETAqPulATKeBDmn7LQ7XpNoayV4MeWo+c/0j1xTHkQCMaeNnO06o1jHjV
         wXwst5kPVLgCbzWT0YyLE0V7SrPk4dewcY285s76FaTIMjsI4wm7C9qImApL7c0XubIx
         ESCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785640834; x=1786245634;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dokjfNwvvyjCQVfo5U9weDVNiEMz1GgnQwdVbTp72Qk=;
        b=Q4UYGguc54Uufj7gk4Fz3wurz6H+eOqFhnnAOikO9sQYIGpGr87bGodwRTTIn7u0fE
         06Ay7qe6zaHulChjeRKKr3al3THrmRvWCZPoDTeaebZqhWpIY6k0gUfxuNNTFWAuI+2w
         qNv0Pvc6XLylyeer41VsQARpOyKyaNMsoOc+CB4KuII81OBydpki1O7Mig38CX5ytIiq
         E6vfIxVr8PYdb2ILgJst5Ze/uqJd8+e69CUm3pkQHqsPFkU8BjFhg1JknbYDjOUIeUBn
         XFO2jJhbrIN3Gs990IhxW9wYfzCI6aCmySsl832gjl9QfC6ZPpxssVEsteApuzzNrXgC
         1cKw==
X-Forwarded-Encrypted: i=1; AHgh+RoSRrFLpOwkzrTedrDvEUPnHG12IdqKb600M+7lAf+EwR7L9WV9NFmFB0pa4DwPG9+Equk+5cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u5fWY9bNnYBTUyWjIgD8xWXd54YyPyVQTA9uZNjDBxvMbNcz
	2Mn9f5SQivUZex2FnHEUV9u1isW+ezGVvjX3+ELG7MpfTDtDknWoFkK6AIM/qX/cbkmlLi1ZsAf
	rNwsCdAOwpu7LTo7dubNA7qqbV2bGrWc=
X-Gm-Gg: AR+sD1323grOTMxsDC74Q+SpVXudylwi60VfVHIH0VoqYHHIIP/mxw2ZmqZrfGj/Dn1
	uop0mt9cDNmQwqV6XaE4ac8ujv0ENc4vMp34Es/4HbuEr8qknmCs5kDaDRVl74wdFrgrG/MJYEO
	EkwBrNKd8qwc0400djXvy9T4tO1SZ1Myls7CO0nLdlX/VLDDS3azd6sm4LA1+B24MwlpxmYBQm0
	2LSltjMQ6qQ+/uojhHqLRtOibdJE4fJQinBcaC+eH2gm1WT1DD4HQAC0SnVHADOep3/MBOsWsiZ
	Q8idqV4dCYqfF8ZSG7r5mD5cbCeEy189aUvFKfkYuqu5ON5FUYfk7NrEHtpmosr9TqRfYg==
X-Received: by 2002:a17:906:d8c3:b0:c12:b227:614b with SMTP id
 a640c23a62f3a-c1fe80d4099mr321593066b.27.1785640833516; Sat, 01 Aug 2026
 20:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-9-coiaprant@gmail.com>
 <23d8e994-8552-466f-98e6-c47d5783525b@lunn.ch>
In-Reply-To: <23d8e994-8552-466f-98e6-c47d5783525b@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 2 Aug 2026 11:20:27 +0800
X-Gm-Features: AUfX_mxFPztNas3fSYA9l7Pdws6J-Z60lqG9o0kXKtJ3uRladP8seNb6Ax7e_y4
Message-ID: <CALj3r0i5yVcJY8V75y0Hm5xjtZSBpH0DXSAWKsAUqguChVcxYA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Sat, Aug 01, 2026 at 10:22:31PM +0800, Coia Prant wrote:
> > The XPCS block contains four MII ports (0..3), each of which can be
> > routed to GMAC0 or GMAC1 via the pcs-handle property in the MAC node.
> > The hardware maps these ports to different MMDs:
> >   - port 0: MMD 7 (ROCKCHIP_MMD_MII)
> >   - port 1: MMD 2 (ROCKCHIP_MMD_MII1)
> >   - port 2: MMD 3 (ROCKCHIP_MMD_MII2)
> >   - port 3: MMD 4 (ROCKCHIP_MMD_MII3)
>
> Why is port 0 called ROCKCHIP_MMD_MII not ROCKCHIP_MMD_MII0 ?

Hi Andrew,

The naming follows the Rockchip TRM. The hardware documentation refers to
the MMD for the first port as simply "MII" without a numeric suffix, while
the other ports are named "MII1", "MII2", "MII3". I kept the naming
consistent with the TRM to make it easier to cross-reference.

As I understand it, this is probably because the MII controls not only
Port 0, but
also the entire PCS (these registers are read-only in Ports 1-3 and reflected
back to the MII).

If you prefer, I can rename it to ROCKCHIP_MMD_MII0 for consistency. Let me
know and I'll update it in v3.

>
> > +static int xpcs_rk_read_c22(struct mii_bus *bus, int addr, int reg)
> > +{
> > +     struct dw_xpcs_rk *pxpcs = bus->priv;
> > +     int dev;
> > +
> > +     if (!xpcs_rk_mdio_addr_validate(addr))
> > +             return -ENODEV;
> > +
> > +     dev = xpcs_rk_mdio_read_remapping(addr, MDIO_MMD_VEND2, reg);
>
> Does this mean C22 registers are mapped into the first 32 of C45
> MDIO_MMD_VEND2?

Yes, exactly. The C22 register space (reg 0-31) is mapped into the first
32 registers of the VEND2 MMD (MMD 7). This is how the hardware is designed
and matches the standard C22 to C45 address mapping.

>
> > +static int xpcs_rk_read_c45(struct mii_bus *bus, int addr, int dev, int reg)
> > +{
> > +     struct dw_xpcs_rk *pxpcs = bus->priv;
> > +
> > +     if (!xpcs_rk_mdio_addr_validate(addr))
> > +             return -ENODEV;
> > +
> > +     dev = xpcs_rk_mdio_read_remapping(addr, dev, reg);
>
> Should it be returning an error for dev == MDIO_MMD_VEND2? Or at least
> if reg < 32?

No, we cannot simply return an error here. The generic xpcs driver uses
C45 reads to access the VEND2 MMD for various operations, including reading
the device ID (xpcs_read_id). If we returned an error for VEND2 or blocked
reg < 32, the xpcs core driver would fail to identify the device and the
PCS would not work.

The VEND2 MMD is fully accessible on this hardware and contains the
standard C22 registers (0-31) as well as vendor-specific registers.
The remapping function maps the C45 address space to the correct
hardware MMD, and then the read/write functions handle the actual access.
This design matches how other xpcs platform drivers (e.g., pcs-xpcs-plat.c)
handle similar hardware.

For invalid MMIDs (e.g., MDIO_MMD_PCS, MDIO_MMD_VEND1, etc.), the
xpcs_rk_mdio_read_remapping() function returns -ENXIO, which is then
returned as 0xffff (meaning "no link" / "unavailable"). This is the
standard MDIO behavior for unimplemented registers.

Thanks,
Coia
