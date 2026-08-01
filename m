Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3852ED141
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611988; cv=pass; b=AdTVkcLBY6rCVof5lix8jXOBmJpBD5N5GSW7FsnzSb0imm7rCkiDv1ihapMPTB5i0HlF2HH2w57Scparl8K84de8udg10gY035yZ4LuO2f5jEwGdWut4UmPa7rTn18yZzkmeEDOkv7wXxxh9XKX/+F7xM1eMeXjrQ55D4/DDDAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611988; c=relaxed/simple;
	bh=xMvoIasJmU6rvejNbR2b8pxLU/mmd1jsnCBevW1xB+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDWnRckfiyhknImCM+QeRfO4E84Fm0geE9j9Jz+ChXIBwzIJ5V6PMivYmFackLfRtifiCMilSMo6MMEI3UM3pEgva1QpfXa91oxpKgXsnqApDll2urcuwVCXGbmv6Y3tQXjRbRrWl/W7F9FN0yuSlOjy5ayTycRmkIB61vlAt+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDQolbSL; arc=pass smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDQolbSL"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-69e9826d38aso838613a12.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 12:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785611985; cv=none;
        d=google.com; s=arc-20260327;
        b=RDb1oHCDoNCtoMK73Sd5TuRgQ7TBFOGToAaAFttw7U0JFf+KmFFZWXITZ71R7JSNsT
         y/9axpUVu3NVaYO1DPy05l+6zazHfJsIZHKG/KyF213u+rmXi+9Wq89valbh9IOONggz
         m6ILrai2mS789P1xSRHRW1+J/ElqXs0tQ1Hj4HZHCCP1hLQOVukel3CaIlskN0Ope+BX
         WjgiGmp2qMRaBa3mrg9R97yOf6C2S1JxOCOW3bihuM8C8vDkajNKF0b+pRWK7wRgcjPM
         K2sILthjrZfg7NoHm6IkTDjeTepBgpFqRzYD5ra99GPAwixma2xLMhN2/W1A/nzNnLNN
         MhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SCQm3Q/ph03r/XdeQCWy2Yw7OKUkw0PP1SQeQ3TZ+Pw=;
        fh=gMNP1tcC1eXsf+lp1HdcmzMaGVzyV1cFJPGMatT9uBE=;
        b=SgNsIPpxL9jVfM61B5zIq/SbzVu7Rai2Eu+gLcwDkOYsMCSA4NgLgu/UXiYcg5hlBI
         +8SkmyRJf2N1m3wv6MlipUr/+tD8c3pZpRLwVz3HbDOllZ8a/7HEQZQLXKIaonN6sJi/
         imA6wS9bLGIStbQ3022qLd727z0gJ5FQR7UNn50Bxp/QQZXiQpJbfttIKBwgWoVncOWl
         st+mexKjn/dVopm+bKajTPgYij5uqz1aWX/JP1GVQtEbJA/CZO0wvDm43zlR22Rqs9dy
         nTRRQy+4cvxA0uADvpcjlrlBP2DNeteqs4oATea7BrR1XviFn2MRILNiKjtIdagHhLxq
         nzyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785611985; x=1786216785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SCQm3Q/ph03r/XdeQCWy2Yw7OKUkw0PP1SQeQ3TZ+Pw=;
        b=YDQolbSLvcKW3PmlbCdNuRM1F3fJieiCmt9/fdP9GWFwrweEpvP0/6Lqu9rabJAPmw
         D//rGYZD3/2j0iOGQvLpgnWvF0xtqyInO/19CMs1aO3HEOLC/iIfVjDuItsvK2I4KG0n
         bEk6jpAbqvHPnwubK1Furla9u2kaosTveIjXIxVnk9iQkgFnJ6dE6znvfPqCJbjlHYuM
         F2miucV5axP1/24hc7ve1i4nmQb8Dhk5Ee/csj/0krHn8fiOdMNXBKdIeUBr+lHc+ccg
         04MzJ47NedLrKsVq9oZ8gicPRtYMg273OSXYXIqDvJXJ9u7/V9mjcVMaxDmD7K/aWD/0
         X/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785611985; x=1786216785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCQm3Q/ph03r/XdeQCWy2Yw7OKUkw0PP1SQeQ3TZ+Pw=;
        b=I7M8nab/6Fvpvi2T88UNp/DHsiCzkHB2WQQCQY83eS01ub6VkTEZgyT4H/kx3WudZA
         dOEWldtycrdDrlqRQXyW1qVDjcQJbsCRznAwMzr4mPOxfOp8E1ILco5mX+bh2RbgJWfZ
         GsvoymOzWHXtalVDN3+oQkqv4QHSpSJ4c5uHtmBIpzG+5vR1QXaGGkkrqua7iLYb94a9
         4j323CKBTRCObTgpsSvB8nqHxWPjZw1JEaXtBmbd4/zQ4GJpq9fdTo8ZM7seN7uLNwER
         jss1Zif6iGvB/9OTwsKM4PyjRWOxo7yvX0IUN4fKrtyTKqMvDY76ilHQVTLCR0lKj8WO
         2U1w==
X-Forwarded-Encrypted: i=1; AHgh+Rpzv2qf70jfcISvTF4QGEKYPnGI1OSse75j/MlHKeQZwjoLucQ/VQ1c56YGzoNRtDl5O073/WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyde7x9zY4gWfQdZpgTnuh+kYol2lBcQCuU8MEEZqO2ZerYR2Vt
	4cu5rgN8H5/IbxjYoemsmCRt/JyzObzoIDd3iA/+9AVSzlu22QY1l+4mxF3Mp90+hfSw0hOym2J
	So7ENJKe+Rn8cR+NW/tFLOTLu2N0bSGc=
X-Gm-Gg: AR+sD11RQTKjZKtiMADvC/gN3hVzqld4zLCK6BqXrd2sQfu34aGfW81k2cPZFRuciTJ
	TEgVqmR95USKkrDHa6NGx2/VJB1xgaATLD6bLbIYcMakVscoy5Da8tcrvbqnAemQUpgWcrOvrdR
	7qOUOXj1Uh+tR2NqJ2k4eJaDi4kQAZHGhjqXsrZhmt90klZ5a272Wu/9AHVhcbKx+Ez/9AqdS4m
	xgu8R6WKGgcwFN7/N99wTrHQIe/Z9iVJL0UGJZ3BVBor2dMM1RF8BFnw9IYk9mOIi3rZ0oWlW8O
	v1F2y93riTjBn4BiEk2uvseGwgWzhlUoP99eF10oFtoJOtJopLTTSf8cZUoh
X-Received: by 2002:a05:6402:440e:b0:697:f70f:8238 with SMTP id
 4fb4d7f45d1cf-6a0a7c6b76amr3103144a12.4.1785611984460; Sat, 01 Aug 2026
 12:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-7-coiaprant@gmail.com>
 <2847036.GUH7pLUipS@diego>
In-Reply-To: <2847036.GUH7pLUipS@diego>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 2 Aug 2026 03:19:37 +0800
X-Gm-Features: AUfX_mxTVYa8KO_KHMFv70Oru7_6E2Erl1Ah7ifU-aGIuPNS6S04bHqAgUqfw5o
Message-ID: <CALj3r0gqvFZPb2SKRMPwf9chCx076rwCnXEoOMFch_V-fOKV6w@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] arm64: dts: rockchip: rk3568: add XPCS and
 fixed-clock nodes
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
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

Heiko St=C3=BCbner <heiko@sntech.de> =E4=BA=8E2026=E5=B9=B48=E6=9C=882=E6=
=97=A5=E5=91=A8=E6=97=A5 00:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Am Samstag, 1. August 2026, 16:22:29 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Coia Prant:
> > The RK3568 SoC integrates a Synopsys DesignWare XPCS that provides
> > the Physical Coding Sublayer for 1000BASE-X, SGMII, and QSGMII
> > interfaces via its four MII ports.  Add the XPCS device node and
> > its pcs-mii sub-nodes to the SoC device tree.
> >
> > The XPCS device is accessed via the APB3 bus at 0xfda00000 and
> > requires the CSR clock (PCLK_XPCS) for register access and the EEE
> > clock (CLK_XPCS_EEE) for Energy Efficient Ethernet operation.  The
> > PD_PIPE power domain must be enabled before any register access.
> >
> > Also add two fixed-clock nodes (xpcs_gmac0_clk and xpcs_gmac1_clk)
> > providing the 125 MHz reference clock for the GMACs when operating
> > with XPCS.  These clocks are used as the assigned-clock-parents
> > for the respective GMAC nodes in board-level device trees.
> >
> > The XPCS node and its pcs-mii sub-nodes are disabled by default and
> > must be enabled at the board level when 1000BASE-X/SGMII/QSGMII is
> > in use.  The fixed-clock nodes are always present and do not have a
> > status property, as they are static clock sources.
> >
> > The XPCS node also requires a reference to the appropriate Naneng
> > Combo PHY via the phys property at the board level.
> >
> > Signed-off-by: Coia Prant <coiaprant@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 45 ++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot=
/dts/rockchip/rk3568.dtsi
> > index 3bc653f027f1f..989e164c0eb39 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> > @@ -110,6 +110,51 @@ sata0: sata@fc000000 {
> >               status =3D "disabled";
> >       };
> >
> > +     xpcs: pcs@fda00000 {
> > +             compatible =3D "rockchip,rk3568-xpcs";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             reg =3D <0x0 0xfda00000 0x0 0x200000>;
> > +             clocks =3D <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
> > +             clock-names =3D "csr", "eee";
> > +             power-domains =3D <&power RK3568_PD_PIPE>;
> > +             status =3D "disabled";
> > +
> > +             xpcs_mii0: pcs-mii@0 {
> > +                     reg =3D <0>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             xpcs_mii1: pcs-mii@1 {
> > +                     reg =3D <1>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             xpcs_mii2: pcs-mii@2 {
> > +                     reg =3D <2>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             xpcs_mii3: pcs-mii@3 {
> > +                     reg =3D <3>;
> > +                     status =3D "disabled";
> > +             };
> > +     };
> > +
> > +     xpcs_gmac0_clk: xpcs-gmac0-clock {
> > +             compatible =3D "fixed-clock";
> > +             clock-frequency =3D <125000000>;
> > +             clock-output-names =3D "clk_gmac0_xpcs_mii";
> > +             #clock-cells =3D <0>;
> > +     };
> > +
> > +     xpcs_gmac1_clk: xpcs-gmac1-clock {
> > +             compatible =3D "fixed-clock";
> > +             clock-frequency =3D <125000000>;
> > +             clock-output-names =3D "clk_gmac1_xpcs_mii";
> > +             #clock-cells =3D <0>;
> > +     };
>
> I don't fully believe those clocks are "just there" inside the SoC.
> Instead I _assume_ they are generated by some oscillator on the
> individual boards?
>
> Because as described there, they would be just magically be there.
>
> So please aim for a real clock description (likely on a board-level)
>
>
> Heiko

Hi Heiko,

Thanks for the review.

During my tests, I found that the 125 MHz clocks (`xpcs_gmac0_clk` /
`xpcs_gmac1_clk`) are actually outputs of the Naneng Combo PHY
(SerDes) when it's initialized for SGMII/QSGMII mode, rather than
independent board-level oscillators.

Since these clocks are part of the SoC's internal design and
consistent across all RK3568 boards, I think keeping them in the SoC
dtsi makes sense to avoid unnecessary duplication. However, I also
understand your concern that they might appear to be "magically there"
without any explicit dependency.

To address this, I'm considering adding `status =3D "disabled"` to both
clock nodes in the dtsi, so boards that actually use SGMII/QSGMII can
explicitly enable them together with the XPCS node and the
corresponding Combo PHY reference. This would make the dependency and
activation requirements clearer.

What's your thought on this? Would you prefer adding `status =3D
"disabled"` to clarify the dependency, or do you think the nodes
should be moved to board-level dts entirely? I'm open to either
direction.

Thanks,
Coia
