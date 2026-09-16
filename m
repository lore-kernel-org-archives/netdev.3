Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC29191F94
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540184; cv=pass; b=IH9hwQcyLK+iDjwTxwy2S0DmRqfI3O/Gd4210p/cs5PBlxILl6hp/Af4Cdro7JzgtpMXUvoEEdbg4HDCqkLPOgVXCHrOFbKBD0/hCsVad+wZw95cyomRKWrmCjUGRMJdqLl1g/QRFCborPWIZ7X8r6sH8M7nxTcKyJyJ1fFvNoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540184; c=relaxed/simple;
	bh=vxwJtKP5dyGMaNoczGK/7UXp394tRjI7aLg0dpu/cdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meJ+EKSkxwePCcxE74gUCgHCcvU6EGZU1y8JjbGlIHBWS1jHO0gW1hnH2oG+bPIYQEmgcpSeDWyKS+HwYIYNbHzOKrUmmvfCGM1L/0D5RJj1xcCwPQwraGy+mp3IwS79ZEt8+1VsK4RINA7JOy5BwO2bHahqpqmbppAIM8DdQtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSdPIk8Q; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSdPIk8Q"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97eaa1155b1so296047241.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789540182; cv=none;
        d=google.com; s=arc-20260327;
        b=j4UUddfYlKaB17WaqpRegkMsEIFMK2JaLvyKRkin49wSr+chYRBO4zWietabcOeeIE
         3cM691Zwzoy0ag3ukqjJRrG85qdvUfnsYzuHu3Q3baA68Y5FYp/obBY4t1cW445TUQdL
         MRDLURV23oGrbrKwyC3/OhFvW0kuzS6jBIEakZs8XjWmkWnReNpjo5aK2037rwAgcjr9
         aFRpFfWZRBZ0sZRu+Fc6rGupLrZXc1pkrHxnFGfU2l887n9KanHiOxMblobWPqrejNy2
         TrOgCzB5Is3yTD9HOl8K4CEsl7HaxM2csg/gdN0Cf4cr+RYD5kGEeudem968rYxuU2+C
         3flA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fLQJlPVwEEi5+s2qt4TvZ0WfYKHDL+3w8HRDzcqcQ8c=;
        fh=jBgoB4DwDdE+9vfQkS0UcWxyT37qt9q7MhSX98EnUA4=;
        b=rqITPLBDn58rU0kuj3sZcn/eZzoeCpt4FWhk2hNQfSTzifKeoNcxxRcXiYM5kGu0Es
         rNsF/NJOSoZDKt/KHk8VFl13qZhF70O+xuIk9v01fhUUaTXap7bYpL4lu0INgsqHaTnS
         fTGT5Fonimply2Yw7Lyg3khKfZ292DxZDfPAv+1lJhD91isW3XFkRcnCxAgeYbw3aUC+
         NqnU5YxF1VPWeoXpEdgkWX8eRFeVpUIevgq+wwqQiu/SjmMesCVlqYV59kCDfAdtOEVa
         2yT4ufFtH4Z29Ax6ZytuihWO7jqH/fnyWvEswzK8qreIRAyJhXiFNzlmjam3TCM0Qijy
         zn8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789540182; x=1790144982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fLQJlPVwEEi5+s2qt4TvZ0WfYKHDL+3w8HRDzcqcQ8c=;
        b=VSdPIk8QtSsqlbhk10jiflIRjv3ecXSilDdxODs8YfeBkFbJ05RTbaYB06O/8VGSU4
         3YF4ps1fzrGJTymh4Q8xkKnvDjpFaIEZGNEAPfJ6oZMRtZCWWkW5cjhEy4RmLXEU/PT1
         4ihUWv9z640YKZNVdBkEoOddM8MG/th872mPE/pgsQJsIEM92wQakqmqkXYCDvkZICke
         i09Y3myRwwO6vsDBY0PcA/rPRgwfGNK5tmA6FmVaflb4vwYNpbeJzGvVrwEmXAXF7PZd
         pRVDSaqZAHFT5FwX5Ecg9IrKH3qL0CPopNBztr6a4Dm8Rqtl1ZhTJainKYbVoJ4zhTkM
         Zy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789540182; x=1790144982;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLQJlPVwEEi5+s2qt4TvZ0WfYKHDL+3w8HRDzcqcQ8c=;
        b=rmEtZSS2HZAcjhJn8GNpneEhb+q8py60TYVowVmJV0kzPCvZkwNHtAW8rEwO4wXGtG
         eF4cGaMMpct+9CV6o2Le3cJLUm4HvauT4Ub2JCO+98xaXGi8wmaN/69SrIODfbO51Yke
         c78gwDhEit8J2xheWE5nqxckOZ6fIsEHl5Abpa6stFAk+IlKqmiu9VZOg27Cw9GgDUDI
         en93kX7Odj1bikqzsFatyBcsDlIvZlSWZ+/cw7Jl2qfaNNVc1CtOgKIi0wxEGnEFgGv8
         HBlh57kETYGBkVKy5pvfRDuHJtamX+xh9Fupl9X5b2do4ZjQKwZS8pn9EnRr6zEFeAWv
         LMcw==
X-Forwarded-Encrypted: i=1; AKwUvBw/NnlOBF3sXuRxevmBA8FVNgMD/FaiCw9xF5eoN3QANOgvax4z8LGZQEaghGvzoUEiaUCFBqs=@vger.kernel.org
X-Gm-Message-State: AFuF++mg6UdtlRzEotRVyXJbyHXgNll+IMGOwssyshiANMGYSpEEdf6y
	VDwE1nPK7qI7S/sDVt+rdFrenAL4aejwUlGLAC77CAf87Af8W1KWgdmfSC2z/yeDDtHxkYXesJ0
	RznKbHQ/1yjat5zklodfoGhlqVscC5Yw=
X-Gm-Gg: AYBFou2ybQiHfmDolFtLbnulbeTwuuMbwZkZ8QKuNGKiKHhDjusYPEKT0PXBMYD+xg6
	HCX8Gx3/BpscGtQagljv+GwE0Fq+0JGn5iF2IILTjtO1AebVEiR21+vy9/hP48FVChCogAXc6kO
	2A/Us32yYSbnwRzByP2Wh5KbcJTVCcWz1AhAWVqyTc6HLd6uC0EvNIuUyjt+jR5kr8wfSoSAIAh
	tidkPyhy2l646LLZdrzv8AHglh7RdefKEZmoYNgzf5HwixTmWnRJLYCwSiZGlHU2tNFfLaBH2v2
	xlZLwPqmCd8qhhMNkDEb2F+lXmgWOJZFo8kRXlGVPa3oTenL8Nz0zALDMhXPNfyqB5c01w0upib
	egQkqcIHJOtIFZr2SrhadXUkNkYeDGyK3KuXqeAUbgzYb0jnTXdPvdQv+qmDIf9aavy9HD/evuC
	TcWFBPhXh0Bq4gLL/Gnkm3w8jN+ikmt7rPlwUy7Nqf1xyL
X-Received: by 2002:a05:6102:3ec7:b0:79b:b116:2c5 with SMTP id
 ada2fe7eead31-7a023d19677mr1268443137.2.1789540182266; Tue, 15 Sep 2026
 23:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916044119.475666-1-alastair@d-silva.org> <20260916044119.475666-5-alastair@d-silva.org>
 <579d7650-583e-49bd-aa51-02fc52940ea1@bootlin.com>
In-Reply-To: <579d7650-583e-49bd-aa51-02fc52940ea1@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 16 Sep 2026 00:29:29 -0600
X-Gm-Features: AcwNN1UffeYUy4Pp1zpzsKWqvpGpKHs9ZXj5jRY360cdZ_TOsQDRhTD1ZCtKs60
Message-ID: <CADvTj4pC2xGn4m5Medhpn16wwLj34uatw7v266CCmYWOyWPAZw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: stmmac: dwmac-sun8i: Add Allwinner H616
 EMAC clock index and internal PHY support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Alastair D'Silva" <alastair@d-silva.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	richard.genoud@bootlin.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:25=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On 9/16/26 06:41, Alastair D'Silva wrote:
> > Support EMAC1 and the internal Fast Ethernet PHY (AC300) on Allwinner
> > H616 and H618 SoCs:
> > - Allow reading a register index from the syscon property to offset the
> >   regmap field for EMAC1's dedicated clock control register.
> > - Add emac_variant_h616_internal with support for internal PHY, MII,
> >   RMII, and RGMII modes.
> > - Delay the MAC software reset until sun8i_dwmac_init() when using the
> >   internal PHY, ensuring the PHY has powered on and begun generating
> >   the receive clock before the MAC attempts to reset.
> > - Skip setting H3_EPHY_SELECT for H616 internal EMAC, which does not
> >   use the H3-style EPHY select bit.
> > - Handle -EPROBE_DEFER cleanly during clock and reset control acquisiti=
on
> >   in get_ephy_nodes().
> >
> > Assisted-by: LLM
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
>
> Even if this is a duplicate some of the work done by James Hilliard, this
> raises interesting points.
>
> > Notes:
> >     Tested on Mellow Fly-C5 (Allwinner H618) under Armbian, verifying s=
table
> >     EMAC1 probe, deferred soft reset with the internal AC300 EPHY, and =
100M full
> >     duplex operation under load.
> >
> >  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 65 ++++++++++++++++---
> >  1 file changed, 55 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > index 48c52eb96233..1728893589a6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > @@ -130,6 +130,16 @@ static const struct emac_variant emac_variant_a64 =
=3D {
> >       .tx_delay_max =3D 7,
> >  };
> >
> > +static const struct emac_variant emac_variant_h616_internal =3D {
> > +     .syscon_field =3D &sun8i_syscon_reg_field,
> > +     .soc_has_internal_phy =3D true,
> > +     .support_mii =3D true,
> > +     .support_rmii =3D true,
> > +     .support_rgmii =3D true,
> > +     .rx_delay_max =3D 31,
> > +     .tx_delay_max =3D 7,
> > +};
> James's series [1] says this SoC only supports RMII (yet includes RGMII t=
iming
> control), and here for seemingly the same device, there's MII and RGMII
> support listed.
>
> [1] : https://lore.kernel.org/r/20260915-submit-h616-emac1-v1-v1-0-195de0=
bb1f8a@gmail.com
>
> Maybe you can coordinate with one another, can we connect that SoC to a n=
on-internal PHY ?

The SoC, yes, on emac0 for H616, but not for emac1.

> If so, can we use MII, RMII and RGMII ? or is it just RMII ?

Looks like it's just RMII.

>
> Maxime
