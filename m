Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012027FB05
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156512; cv=pass; b=rFrT7NlyctPyAvyCRJv0uwUMxp0OlX4vmTOdU8auA+Ud/LETrqcRgIr/RdZPmT+kWFmsZkTk/4sTo3Ga/fp1BPtmHM6VjKgCVTccbgMuRLQZ3KFKmNwvDy2Qub+P02qxweOSyM7bu3FzFfWCMH3N1gd9Rc61Y4JStU6shjhB/Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156512; c=relaxed/simple;
	bh=7KZf5ATgJeWcS11kIxBYx/Qfc96hor+WQ+2mUIlQac4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWrB090N5R5IVC76oB3uq5SzRE26mOTbmINJaePLfk26SbQvZPwW9DEyJHBPiI62i2lgy/cOcWG/t/Uk5z/41ayp8HXYxW327O52WralI96PnaZqjm2EMG4MEsl0fVs8eqZhL+9tbCRtaeSoWWjCv49P+laX4Iyi2RPICfvIiM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejlfLfdQ; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejlfLfdQ"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15de09d5c4so355952666b.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 16:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784156509; cv=none;
        d=google.com; s=arc-20260327;
        b=iD2/gdnlrSvFljNisXQ99BGcEgY6E7LDhqgh0V3I41KlKTJF2Q70TTQCdNSAPBWJJ2
         drUq+aq58isllyx2i0M//VF+qlakjyANj7aZ66VDBsvytMOPGSmUeYEbj7DOC2CPGmN8
         GgbFjCKSQvE2sfW2KA5RSWYnHeDnhIjW/CdBKT6Ci2ha918VV9ebSptQjb82fcBK7CWu
         rT8Z0f3swN16HAn4R5owEiA8ZXRoZ2GLnfUi+P9NnD69appdS6EPhVgH1bQNoiRBUFu1
         nJAp3xtSGPoCiAcpMZyP1du4ugf5n5DyAWihmZZ7GlKQ90LMLU1DGzrNzKG+3AVA27+D
         NsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y8obYoQRW0D7bMouRYacqh4D5cOARHGrRdydWcpJ2O8=;
        fh=pwYj56ctDtv4at3UFrnk/cYAGfxwqxQpaXIQpIHyBkY=;
        b=r0bPRpflDrae/3HH+0KpujFpxsVCM+XNoXG3oMjrMKJN+F142DNvnBSyp6E0THoygm
         Fk7bgNFpBZNlyYMpzAv5H8wCdI7GpA+IPVGu5Erhdt13BeFqr2hzSof5kQHp1vObzyHr
         MOFYYWsOHWtonxo6os6+86cEXVlzJ18rdtUhz3SEI6wQosi43IFezg1e9t56CgFykntS
         mnRqM4k6emHQCghPv6GlnCrhnW2jTX4r8LthJ2B/Yfxo9mRIwMulZNGGADUMv3zFBnrH
         QSS5yBTGCXXLunLXbJOFQuUPkd2B0ilbSKpLM58mFS4rBJg4rvvNa713QCpfky3T1ayt
         h89Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784156509; x=1784761309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y8obYoQRW0D7bMouRYacqh4D5cOARHGrRdydWcpJ2O8=;
        b=ejlfLfdQI0DKGa0LwMQ0Kclp+YtUTq5sQP4vU3lZC/ABX4SZmhtrG4o6yAadUbdv3S
         wSPjhZJcW8PmhBocyIap2h5HRvm/lcHUDsN8TZYOMT+0hIPq3gw3zVdBMs9h2x07nTO/
         ywtKvIYDYmqjD+HGKPYdq6JrRuNbpq6GQ6N8R8j2eizGHoy/i4xLFyee2JQuBZc6BE2t
         S/zrDhU3Tz+Lkwn4Meq4CaCV0qKoOoM+u/z/iKoKh1OuEr9ZXHcUk5tVk7AtgsQfsLFy
         58K/lrBhQHXoiKdt1HM0pPXmeDmX3Wco6a+X9J4DRi7iAmZ0n96YFiC9BxebbFHp8CxJ
         uKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784156509; x=1784761309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y8obYoQRW0D7bMouRYacqh4D5cOARHGrRdydWcpJ2O8=;
        b=LVGMssV4JbcD1p0kOabw3cYRHjABhw7xihuOljNiQVsWa20uF1ELPTQwLwClpIKSvH
         LAGwE0aUI44oREML+hKjrLQ4dlkb7Ts+BzOraEYyrKY4MaJ/KBX8AwHdp4iPficohtDK
         6FrSgoVLfjQyWVCm2/SxWs04epCbRzSqSnQdakhUuWp42Ol5PHODDv3vYxd+wNIu78zC
         TZXqF1PEqlpFkGUMw8Pue9kts/FWudXbCTfaMqRXXu+nUNlH7etc20n0VOiTtNjSbciV
         E8XoIZLCJgc3Uj45y6F50R6Pq5ZuPaXSilFl9EzEcIgpcVRfWTBkyQoYL5PBEAnkrAnl
         mVpA==
X-Forwarded-Encrypted: i=1; AHgh+RrdOxxBuLSPWolPCVkHMYGhQ8dOpnr2Wz27l77Jt3U3noPJNHp7xpnflSRIdhdzv28gRTxr+0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSHrIRiIYqGXLAcVhGzFCEiFnWp7qRVrIM/dtvODydK919MnH
	RNZ7rVnmhdRLEvraPU2T4WNJG+LYttkNwKd1EsrZ8uJpzDU+oUveho3GX9G0+UAlmDVYYY0q5Qc
	5PedBGaRACgiz5hN3DHdTHsNmKIor6hY=
X-Gm-Gg: AfdE7cmT5Gybj/n0miVEYEXs/ywLso1GGPmPFhFcWbHiDsLSa73FOsoP4rLaqxb5d3P
	KGPU82xs5sLCuMsB1sqQAsfbj94XYc1+iGmU03xGZzC19rGCyv0/qTLFI5rBeKUymIB+a+dYFv7
	DGmr9nvw3DD3blwh2/wGpuWoYhLMb4CLhd/7RJkxUvQRn7W6eUVG4k72esddghwntnbsdhNeeND
	h3aCkxgwJfTYb6wrq0lNNW6x7ij3cNIVUxclea21IALI4tMmjdTjFUHVxI4jdn+
X-Received: by 2002:a17:907:3f22:b0:c15:9350:dfa6 with SMTP id
 a640c23a62f3a-c16619ad2b0mr539188966b.60.1784156508425; Wed, 15 Jul 2026
 16:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-8-coiaprant@gmail.com>
 <4823c1d9-51d9-45fa-a96c-f2caab1cb29e@bootlin.com> <CALj3r0h4cFd-tp9-UVxihL9-a1W7_4nvnKoXW_cP5WECKc66Hw@mail.gmail.com>
 <1d92078f-3009-43d1-a228-c3e67a1f4f4c@lunn.ch> <CALj3r0gBnyEVwo3rK-dKssYN9F4nFn93QJ24FVv8YBLjNNgPmg@mail.gmail.com>
 <039c2cce-e76e-4321-ba4a-cd80801f136e@lunn.ch>
In-Reply-To: <039c2cce-e76e-4321-ba4a-cd80801f136e@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 16 Jul 2026 07:01:37 +0800
X-Gm-Features: AUfX_mwFPn4a5IZZI8ivW-vw003zPra-aQ5NOk6yPm8eSjdntp4P_3w-2rjiAlg
Message-ID: <CALj3r0gmNudG2pCebGzd+453ORVakkyct4oDYR+SrqLPkx1nFg@mail.gmail.com>
Subject: Re: [RFC PATCH 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B47=E6=9C=8816=E6=97=A5=E5=
=91=A8=E5=9B=9B 06:25=E5=86=99=E9=81=93=EF=BC=9A
>
> > The current design
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The dependency chain I chose is simple:
> >
> >     stmmac (GMAC) -> pcs-handle -> XPCS node -> phys -> SerDes PHY
>
> Maybe we need to be more accurate here.
>
> In QSGMII I _think_ it is actually
>
> stmmac (GMAC) -> pcs-handle -> XPCS node -\
> stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
> stmmac (GMAC) -> pcs-handle -> XPCS node -/ /
> stmmac (GMAC) -> pcs-handle -> XPCS node --/
>
> There are four instances of stmmac, four instances of the XPCS, which
> then all come together into one PHY.
>
> When using SGMII, does it look like this ?
>
> stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
> stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
> stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
> stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
>
> There are four of everything, all working independently.
>
> Is there 1 QSGMII PHY and 4 SGMII PHYs? Or does one of the 4 phys
> support SGMII + QSGMII, while 3 are SGMII only?
>
> > 2. User misconfiguration: even with reference counting, if a user sets
> >    `phys =3D <&combphy2 PHY_TYPE_SGMII>` for GMAC0 and
> >    `phys =3D <&combphy2 PHY_TYPE_QSGMII>` for GMAC1, the same PHY would
> >    be initialized in two different modes.
>
> I would hope that results in -EINVAL.
>
>   Andrew

Hi Andrew,

Thanks for the follow-up. I've dug through Rockchip's BSP and found the
exact device tree configurations they use for their EVBs, which I think
clears up the topology question.

For reference, here are the relevant BSP device tree files:
- QSGMII: https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr6.1/arch=
/arm64/boot/dts/rockchip/rk3568-evb2-lp4x-v10.dtsi#L185
- SGMII: https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr6.1/arch/=
arm64/boot/dts/rockchip/rk3568-evb5-ddr4-v10.dtsi#L208

Hardware topology confirmed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
The BSP shows that for RK3568, the hardware is indeed a shared resource.

One important clarification: the XPCS block has four logical entities
(corresponding to the four MII ports, pcs-mii@0..3). In my driver, these
are all attached to the same MDIO bus and distinguished by address.

To clarify the PHY topology: there is only one physical SerDes PHY on
RK3568 (combphy1_usq). In QSGMII mode, this single PHY provides four
logical ports via time-division multiplexing. In the device tree, all
four ports are attached to the same MDIO bus and distinguished by
address (pcs-mii@0..3).

So it's not "4 PHYs" but "1 PHY with 4 logical ports", all accessible
through the same MDIO bus with different address. The BSP EVB2
configuration confirms this:
both gmac0 and gmac1 reference the same combphy1_usq with
PHY_TYPE_QSGMII.

To clarify the difference between SGMII and QSGMII:
- SGMII is a single serial link at 1.25 Gbaud, providing one Gigabit port.
- QSGMII is a 5 Gbaud SerDes protocol that multiplexes four SGMII links
  onto the same physical lanes.

So for RK3568: one PHY for SGMII, or one PHY for QSGMII (both GMACs share
the same PHY, each using a dedicated logical port).

For SGMII mode, only one of these ports can be used at a time, and only
one GMAC can use the SGMII link. The BSP EVB5 configuration shows this
clearly: gmac0 uses SGMII, while gmac1 falls back to RGMII.

For QSGMII mode, the BSP EVB2 configuration shows both gmac0 and gmac1
configured with phy-mode =3D "qsgmii", both referencing the same combphy1_u=
sq
as their phys. This confirms your diagram: multiple MACs converge on a
single SerDes PHY via the XPCS, with the four logical ports time-division
multiplexed onto the single PHY.

Why this matters for the design
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
This BSP evidence supports my current design where the XPCS node owns
the SerDes PHY:

1. It matches the hardware: the XPCS is the central multiplexer.
   Placing the PHY under the XPCS node in the device tree accurately
   reflects this hardware reality.

2. It's the only viable path for QSGMII: as the BSP shows, QSGMII
   requires multiple MACs to share one PHY. If the PHY were owned by the
   MAC driver (dwmac-rk), we'd need complex refcounting and cross-MAC
   coordination. The XPCS-owner model solves this cleanly by making the
   XPCS the single point of control.

3. It aligns with the BSP's own logic: even though the BSP uses a
   non-standard property (rockchip,xpcs), the underlying idea is the
   same: the MACs point to a shared XPCS node, which then manages the
   PHY. My design just does this using the standard kernel frameworks.

So, I believe the current design is correct. It's based on the hardware
reality confirmed by Rockchip's own BSP, and it uses the standard kernel
interfaces to do so. I'm happy to keep the XPCS as the owner of the
SerDes PHY in v2 if you agree.

Thanks,
Coia
