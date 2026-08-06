Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82E374E55
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027041; cv=pass; b=VqUP27Ix7dRiOiw6ZkBRWNorV1+BqHxrKwcrowVjDnfXMkbaILa0LrsoDwl1mijdh+zjC8m04yZia3xdlfJhnR+LPyBdXM2h3G0Rfb8NG4FL28gTqY7EPtGt9nHJQHSDzkXaI7qvPYUDe+pRcrenxHLrTyPeRD3wVnVIc9N1JXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027041; c=relaxed/simple;
	bh=w7f4jEU753DyqT8Dz8vA89VvYOkXJUGdtOZKTndqS5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQfWjaHNo4k4ucMfxjeYMqndma9rUYgl/7CJUuuvsTJXDMaANtWQgew+RAdrlGdiJlpAhyzQ3FqBhVbtP/WfNdnhW9eViO2sa5b9CmuR98RR6yAotG3DW5qbP9k/FTxFSeBEF4xeVFZmrp2VRsbJjpDjJrY84WPxYpGWjBfTeNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni5T3VXq; arc=pass smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni5T3VXq"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-6a14f40cf1eso1413439a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786027038; cv=none;
        d=google.com; s=arc-20260327;
        b=W96h02fGLyq5ANLB5aviSmBv6aQJRDvlvlZ/x5TCsoPg4fD8FMWdJu8rUjjpyIIEhw
         QcIPjxNFBY5599+KmRuSytt84cc2jKHV4icuJ/Dx84cRB0yaWT2GXHMQNwP9lknQY+4W
         PsKS3Y7+laOGj2ST4QeefWChwWJFDaOjTVW+WjNFR9FPJUOYPm72WfTrH13QAkzx6tmz
         UNY4GD6NsEbx+U0t2GQ5ItFx2rLQBNPGApAsDxZQpRTW9RWXSQL8jsFFSpQ459CBl2mA
         zImO99SOp+LWwUmXC/BvM012YNApW7IWWxFfLM0irK3fkV2B6tyWkopr7s7e2yvHGAUD
         1rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bm5BP89+hYEVtcyVkLS5Qjs1T3/LfUuhKO2G7nsDJlg=;
        fh=E3zTUoNwUiVsqUoj08C00zzPJBAkcxMiPgGWW6rFvaA=;
        b=OtjWmEXCzmnEs12wYzOP7+TkThZnCA4aL45ZLgyYuxX5JHHjguzLCjF7lO92SNWhJT
         D2EPDbYl6cYKZtTdn7+7GYIrXlt7mx+TMyL04wj5+mYlimtBox+tZp7TXtROSPgbbexr
         y9XlvFij9poa9HO9Ugx2grXCs66XiinzKj/852GvBP4tADaQXSDTxGksHprycdUvEUeT
         /OjN3S5ko8Q4e/lyMiQBqGVgwe5A+IsHWEth55cFXJrKC33rqpnVIsrTR6gL6oMB1Vtu
         ef6PIHJaNygv2bo1LXAH/o33qg1TN3kD8GouD/6tNUGSaZq3grwpMagVfFX/XbyUZpHa
         tdXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786027038; x=1786631838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bm5BP89+hYEVtcyVkLS5Qjs1T3/LfUuhKO2G7nsDJlg=;
        b=ni5T3VXqC93gvXjHwvE6exHZfqhPC5iW7V66wHj/S+2UlnmFgR4jkN/WlIN7sXnbw3
         EhGhhke19Rc5/xWXS2SvWVihf390jOdO0/KmwZXJ/fw4NnPTRUHcXdWyDyrX8x5k9XzN
         h96SiFT+xnz9rm3OpMEzRsVI9oxDzcjgVtv11fQS3h/VVSVq5chQqMILziIWrhWZ5NSg
         CUFzfGFiFBx5jBoUrILdT37HjVmpDzY2ijGUo+8IHha33MTNNt+ZrzpIuPq0bDynYMj2
         wrdtBVgu0rw1Y79MUjevwZvkkhIUrh44Okvfxvcw4Za1XtwxdD2BWttjTI8XnlIZHQsJ
         aN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027038; x=1786631838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bm5BP89+hYEVtcyVkLS5Qjs1T3/LfUuhKO2G7nsDJlg=;
        b=I9im8fgTu86iAXUh9Vi/6iPA8mE5db+EdE3tjgyVLqQkmCThg1+ywjXk39ylS7pne+
         lKjzSdjhJAkORea+H79mLlVl7TcyjMgcaGg1I44FJq2OrwLhIWTV1KMLqj7STStuQzCT
         jx94sllttd5tsUe1+XWusaUTMuboJV5+mHs9jYtCkxw/vt8dn96TmzuSbVtix7yDvtH+
         5JfgaFyqNIwHDI0HK4v3nQIwQcV/hSI2gNEtJTwpNJYDKBCB7klRKQZNufGg9OmS43T4
         dM5mJyEBwIHHehUhmvEiqjJxdxNR3Up51AY6EeEg2CoO0C5BWgUboqYkwqpViXo7M16B
         e9zQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsVDuH995LNuUV4C8HTIbCXEYi8xodpoP/6b0Sfzp5GCCuS6j32Lsd9elGKPsnE/HiY7ihjZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJxTHRNN5htBYUBfwduzXVzgyuZddRA04ZfTYts2isym5UM9T
	FzM4fslldXvOKD/vXxTRdajkrvS5oYqWKgr2KQaRx4bedrRNs3esRY7lWk//htcfiMKg7g/yVkN
	KjMFzYbTWrNrJ0jw7fffvvHg5puooP8g=
X-Gm-Gg: AR+sD13ejalHq0Wbh6+5wXV+5RG7jq5X24byfFzwzWNHdi8/76HIMOw0ygJrg88WthN
	dUOpM3OdH38RzL0O6xNLFQvgwugWg4f/0Wf1q5lGRmvo03Y+2tuTybkzJDWlv5EvPPmx/XUNAFq
	uSJGLKZojrm5En1+YDYgMPj8phMJ1rQ3lEF4BmO9+fz1dFpkr7yQCR3Z7Xuh7pveOkGuRSYXSEN
	bCoT54TF0gY57zM/jB20B2Ug0WW5Co8iFp8xL8qxHBuIqbhQk1LHgJCi+/KvqSuvkCSv5pLM2A8
	Hb94aq0J1M4aeiy0R/Lk52Ce7IqXH2+7tvQn+0Cp0fUhSNFIOHjKJIZ38RFwZlOWsbldFg==
X-Received: by 2002:a05:6938:a08d:20b0:c20:5121:89c1 with SMTP id
 a640c23a62f3a-c205121911dmr431715766b.12.1786027037242; Thu, 06 Aug 2026
 07:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-6-coiaprant@gmail.com>
 <20260805-stirring-wondrous-mule-faf37d@quoll>
In-Reply-To: <20260805-stirring-wondrous-mule-faf37d@quoll>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 6 Aug 2026 22:37:12 +0800
X-Gm-Features: AUfX_mwaP0yLJ9HCO94OK0aTh4w5tIMmxMB_NLgFfaixnrT58_1pSbbkFIzX-Ko
Message-ID: <CALj3r0iFULLqkfqPA6RdGPc1PQ4CvOPw82_+QmRn8vBhWnBMHA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs binding
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=886=E6=
=97=A5=E5=91=A8=E5=9B=9B 14:49=E5=86=99=E9=81=93=EF=BC=9A
> I don't understand any of these. There are none of my quotes. I don't
> get what you are referring to.

Sorry for the confusing previous reply, I didn't quote your original
comments properly. Here's a clean response with your points quoted.

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 15:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Aug 01, 2026 at 10:22:28PM +0800, Coia Prant wrote:
> > Add device tree binding documentation for the Synopsys DesignWare
> > XPCS integrated on the Rockchip RK3568 SoC.
> >
> > The XPCS is accessed over the APB3 bus and internally connected to
> > a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
> > QSGMII modes, with four MII ports.
> >
> > The binding describes:
> > - Required properties: compatible, reg, clocks, clock-names
> > - Optional properties: phys, phy-names, power-domains
> > - pcs-mii sub-nodes for each MII port (reg 0..3)
>
> Irrelevant paragraph. We can read the diff. Drop.
> A nit, subject: drop second/last, redundant "binding". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L23

Okay. I will drop these in v3.

> > +properties:
> > +  compatible:
> > +    const: rockchip,rk3568-xpcs
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
>
> reg is always the second property.
>
> Also, use consistent style of quotes.

Okay.

> > +
> > +  reg:
> > +    description: |
> > +      Base address and size of the XPCS register space mapped over the
> > +      APB3 bus.
>
> Drop description, redundant.

I'll drop the redundant description paragraph from the commit message
and keep only the essential information.

> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: |
> > +      Clock sources for the XPCS:
> > +      - csr: APB3 bus interface clock (clk_csr_i), required for regist=
er
> > +        access.
> > +      - eee: EEE clock (clk_eee_i), required for Energy Efficient
> > +        Ethernet (EEE) operation.
> > +    minItems: 2
> > +    maxItems: 2
>
> No, instead list items with description.

I'll change to items with descriptions.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: csr
> > +      - const: eee
> > +
> > +  phys:
> > +    description: |
>
> Do not need '|' unless you need to preserve formatting.

I'll remove unnecessary '|' where not needed.

> > +      The phandle of SerDes PHY (Naneng Combo PHY) that provides
> > +      the serial lanes for 1000BASE-X / SGMII / QSGMII.
> > +      The SerDes must be powered on and initialised before any XPCS
> > +      register access.
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: serdes
> > +
> > +  power-domains:
> > +    description: |
> > +      Power domain for the XPCS.
>
> Drop sentence and |

I'll drop the redundant part.

> > +      On RK3568 this is typically the PD_PIPE power domain, which also
> > +      supplies the SerDes PHY.
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  "^pcs-mii@[0-3]$":
>
> Why `git grep pcs-mii@` gives me no results? Are you doing this
> similarly to existing devices or is this quite different device than
> every other hardware?

I used "pcs-mii" because the Rockchip TRM refers to these as "MII ports"
and they are functionally PCS instances. I see a similar pattern in the
Renesas RZN1 MIIC binding (renesas,rzn1-miic.yaml), which uses
"mii-conv@[0-5]$" for its ports.

If you prefer a different name (e.g., "port@0"-"port@3"), I'm happy to
change it. Please let me know.

> > +    type: object
> > +    description: |
>
> Same here
>
> > +      One of the four MII ports of the XPCS.
> > +      The port number is specified by the reg property (0..3).
>
> Drop sentence, redundant. Schema tells that.

I'll fix this to use items with min/max.

> > +      The port is linked to an Ethernet MAC controller via the
> > +      pcs-handle property in the MAC's device tree node.
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 3
> > +        description: |
>
> As well
>
> > +          MII port number of PCS.
> > +
> > +      status: true
>
> Nope, do you see anywhere code like this?

I'll remove this generic property.

Thanks,
Coia
