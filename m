Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75843BDB5
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226487; cv=pass; b=a8Mt6nSdDzJzR7HwStsqLALdmFwyau4+3PbQWHAXVqqVnV2hXF9JAHJ9L4oK7r8eLRjZzYeZjJLLRDgKD/s4cZ661H5kQQlpo0cEh8tV5iiweTWzRbjros9N28XJJsOrTKgXSXAD8/MNG1cXfA6Srf9zotOC29z+Dc+CxOKwnSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226487; c=relaxed/simple;
	bh=N3XcxuvKeFv0jrHZq7jORW96HDTgTe/U58U3ymleexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC5mhXJiPpPK2pkTY308hwFCHWUrPE/6KEMdBOEB+1PawsGbIXsdDxoKSmG0pIY/xX9u1K51n6AtgHB9L3s8hQgDsDNlRXbyPI3ik00Lufq4GsPwCK/KZuL1NX0FH54H20ZN+1SN4yuGCgbpo9KDPFH8I/RmI872dD8IOnVmVEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h18HZxoa; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h18HZxoa"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e2dab83eso368228566b.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226482; cv=none;
        d=google.com; s=arc-20260327;
        b=HTZ2uHGP9Ug10tfRcI3O0l7/tylYaanWfaMEveIAxprL4N6kM+AMQnBD2H9MKIQRbL
         ane6d7W4tx/L+oA7TImEXKqqCg/US7gxKPvdk1cpHuV+pcTKTULXyfg6WRjpXpIbxKhd
         Mw2SDsQUDmU/Gyk+rJ/OAg75pXglKopTdVPPDJa1Te1txHGRMVpJyaGPhj+8h/VeMV6Y
         TKdULVynxl20n8t4beU2Bgpx6QibUYivX629qh+D/X0fI4HrS2Tj6ghdt2eAs/SKvxqB
         t4YuCEQXNpQvbV6LYCsiu+CQZo1LdaRmKR1OSPRgrToZGcMvOu5LsRjhYa1wT9nHTEz0
         UNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        fh=CpA2/DbiiLm4Ufu29CiSL/jlUKdhBpIyNrx97mi8KPg=;
        b=ObvHcjZIq9cwz75ktn4DEmHxO3u4vQc4KEKVN9yeCG6MsEHRmYKo+hnnJCxbKCAxdH
         tYZEGXeHNtsiUKUZqZXWttfvWDs14a8Jl1IhGJvdCwY4n3e3lEi4hU2Ni2iJBsRfEIEp
         lWT7ngANxXc6cjlSNLYCP56gJ4ZaiitdccPCY0dh4eIFmGbJAhC3zhONFdTU7zADXIT4
         4d5sjXv1CXDmuNsME6BI2ycCQSk/aoMcfWMuwE2sJWZY8CfK4DAJbghKvlEUDDSRSezC
         cGlcdB9DXc8SCMTzlqVhJ6APV4vHUVN8Yr53CAmKJncmel5GkK5FK9x882BSsq6f+KUB
         VMBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787226482; x=1787831282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        b=h18HZxoabvn9m/ScdqEyw2LXvAVg3a8Ks6k+ikg3eexYdUFCrjL54D29ghc9LxQC69
         x9Ih6lttJ/t432qM1uJYNSoVDUi5ARvRmIYuJceIXLw6Vh6PzGybvqvjvr2KFqWwYwak
         J9s7mTgxn3cyEBGN8r+9ztQuC8DUpUagH4QZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226482; x=1787831282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M4ykTKD26brTAJUSy1BqDUBmv6bxfPzSIe8lWvsCYHQ=;
        b=MFLSZQxJx685/wsP/sWzkDhbOgboinOw+jSlkTOTIJIrgKUjqz061TpQ7+4giglPvn
         7eIVr56tgLfjNcy414XKaE7585LKNAJm4nCqIZUnRG4ObJzoLxiHL6kAkgBrQXeZfFBT
         wwjwhbt1PsTEdbUdC6VCg1Du3gt4r3LANJb7PQj4J3D7MCc6Kyk5u/EEZkTuKV3yD/M6
         2Rx1OXWUWFEtuXljFlwdmdtkw/8/UC/7A4mUWpkUAgfOsyFXERtMpER7//zvDOboPS3u
         55l7LK1Behrjjd69wW6MCfFUIiea8A35Kp5yMM9OJaVskzso6adZJwH6osKX6FYR/ct4
         Q9lw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0s9XHsmm6yebILQBT6jnU5NlHJPj5h37LGMXrObZ22gXLpr2Hk8CqV1chH/o58vf6CWglQsw=@vger.kernel.org
X-Gm-Message-State: AFuF++mPo8hsVT6K3J5T0q3y9yZ2XLtGKjPE83tO8xtxFWABAa3xUmlh
	b2B4gGnwpiic075js6DuSs9coeagQSy69y5kTSDanjUqDo+dHf0dWnNlc7C8NDT0Vi31Qo15TYb
	awHFkrwCDXof3Dq9cApFOufYe6xpF6M6tB/owIiTk
X-Gm-Gg: AR+sD13/ouqGypF3gjkuosDbKd9hRkYcbs8RVuyG0fbBq64TRhK76dNiASm/RHpmRxg
	WZkJhI8F3V9N06lNmZD0SZYRMWXi2MVamIacvWjrcZYPuxlt/D4v9TG9q9mFPWGcq+GXn9eER8l
	2EPvaJTtPhY7Xtnx+6h6CZTOXQZx4QPZIoA0SWx7HWWi4l1tlGeTj37MUaKEdHaQu0EwqomJMvr
	bj6PJOJ050AtDWlROKl8qjLzkniFTHbIcSN3EDnh8q+Z31honV9jBuwF37I28LfNfXzpFEnuDc3
	ZYPqxN4/U2m024tB0BZIlAbiC0WE64Vr2lmsACjwvV4=
X-Received: by 2002:a17:907:c08c:b0:c21:96e8:578d with SMTP id
 a640c23a62f3a-c242e22d1e9mr985944566b.15.1787226482262; Thu, 20 Aug 2026
 04:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810121121.210040-1-vlad@zlab.su>
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 05:47:49 -0600
X-Gm-Features: AcwNN1XeIHyrOI_JtbOBD7QmUWCfs6jOmGCxaoJ2CvViBz-nzt4BaJLUZj-8m5s
Message-ID: <CAFLszTiGPVD1UvGcdE64H1To3OWjOYTd9BNV+jHM0=_dEkMsDQ@mail.gmail.com>
Subject: Re: [PATCH 00/25] ARM: rockchip: Add peripheral support for RV1106
To: Vladislav Leonov <vlad@zlab.su>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Aurelien Jarno <aurelien@aurel32.net>, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, 
	"David S. Miller" <davem@davemloft.net>, David Wu <david.wu@rock-chips.com>, 
	Eric Dumazet <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heiko Stuebner <heiko@sntech.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Olivia Mackall <olivia@selenic.com>, 
	Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladislav,

On Mon, 10 Aug 2026 at 06:15, Vladislav Leonov <vlad@zlab.su> wrote:
>
> Basic support for the Rockchip RV1106/RV1103 SoCs currently under review.
> This series builds on top of that and enables the peripherals needed to
> bring up a board beyond a serial console:
>
>  - CRU reset controller support (dt-bindings + clk driver), needed
>    by most of the other peripherals below.
>  - Ethernet (GMAC) via dwmac-rk.
>  - USB2 PHY and USB3-OTG (DWC3).
>  - I2C (rk3x).
>  - DMA (PL330) + support DMA for the UART nodes.
>  - SPI, including a new SCLK_IN_SPI1 clock gate.
>  - RNG.
>  - SDMMC1.
>  - A dts-only quirk (arm,cpu-registers-not-fw-configured) needed on
>    the ARM timer node when booting without a secure firmware that
>    pre-configures the CPU timer registers.
>  - PWM.
>
> Each new dt-binding is added ahead of the driver and dts nodes that
> depend on it, so the series bisects cleanly.
>
> This series depends on:
>  - "Add support for the Rockchip RV1106 and RV1103" (v3)
>    https://lore.kernel.org/all/20260729133609.3465563-1-sjg@chromium.org
>
>  - "pinctrl: Add support for the Rockchip RV1106" (v3)
>    https://lore.kernel.org/all/20260729132736.3807082-1-sjg@chromium.org
>
> Testing: boot-tested on custom RV1106 board, with every peripheral
> touched by this series: reset/CRU, Ethernet, USB2 PHY/USB3 DWC3,
> I2C, DMA+UART, SPI, RNG, SDMMC1 and PWM - exercised and confirmed working.
>
>
> Vladislav Leonov (25):
>   dt-bindings: reset: Add RV1106 CRU reset definitions
>   clk: rockchip: Add reset controller support for RV1106
>   ARM: dts: rockchip: Add reset bindings to RV1106
>   dt-bindings: net: rockchip-dwmac: add RV1106 compatible
>   net: ethernet: stmicro: stmmac: dwmac-rk: Add RV1106 support
>   ARM: dts: rockchip: Add Ethernet GMAC node for RV1106
>   dt-bindings: phy: rockchip,inno-usb2phy: Add RV1106 compatible
>   phy: rockchip: inno-usb2: Add support for RV1106
>   dt-bindings: usb: rockchip,dwc3: add RV1106 SoC support
>   ARM: dts: rockchip: Add USB2 PHY and USB3-OTG (DWC3) nodes for RV1106
>   dt-bindings: i2c: rk3x: Add RV1106 compatible
>   ARM: dts: rockchip: Add I2C nodes for RV1106
>   ARM: dts: rockchip: Add DMAC node for RV1106
>   ARM: dts: rockchip: Add DMA support to UART nodes
>   dt-bindings: clock: rockchip: Add SCLK_IN_SPI1 for RV1106
>   clk: rockchip: Add SCLK_IN_SPI1 gate for RV1106
>   dt-bindings: spi: rockchip: Add RV1106 compatible
>   spi: rockchip: Add support for RV1106
>   ARM: dts: rockchip: Add SPI nodes for RV1106
>   dt-bindings: rng: rockchip: Add RV1106 compatible
>   ARM: dts: rockchip: Add RNG node for RV1106
>   ARM: dts: rockchip: Add SDMMC1 node for RV1106
>   ARM: dts: rockchip: add arm,cpu-registers-not-fw-configured to RV1106
>     timer node
>   dt-bindings: pwm: rockchip: Add RV1106 compatible
>   ARM: dts: rockchip: Add PWM nodes for RV1106
>
>  .../devicetree/bindings/i2c/i2c-rk3x.yaml     |   1 +
>  .../bindings/net/rockchip-dwmac.yaml          |   2 +
>  .../bindings/phy/rockchip,inno-usb2phy.yaml   |   9 +-
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml |   8 +
>  .../bindings/rng/rockchip,rk3588-rng.yaml     |  11 +-
>  .../devicetree/bindings/spi/spi-rockchip.yaml |   5 +
>  .../bindings/usb/rockchip,dwc3.yaml           |  35 +-
>  arch/arm/boot/dts/rockchip/rv1106.dtsi        | 426 ++++++++++++++++++
>  drivers/clk/rockchip/Makefile                 |   2 +-
>  drivers/clk/rockchip/clk-rv1106.c             |   4 +
>  drivers/clk/rockchip/clk.h                    |   1 +
>  drivers/clk/rockchip/rst-rv1106.c             | 340 ++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  55 +++
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c |  76 ++++
>  drivers/spi/spi-rockchip.c                    |   1 +
>  .../dt-bindings/clock/rockchip,rv1106-cru.h   |   2 +
>  .../dt-bindings/reset/rockchip,rv1106-cru.h   | 305 +++++++++++++
>  17 files changed, 1272 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/clk/rockchip/rst-rv1106.c
>  create mode 100644 include/dt-bindings/reset/rockchip,rv1106-cru.h
>
> ---
> base-commit: ac414f5eda0814030636177593400acdacfe5e1e
> branch: rv1106
>
> --
> 2.47.3
>

Just to note that I applied this series and tried it on my Luckfox
Pico Mini B (also RV1103 but more basic) and it boots fine. I enabled
the RNG node and the driver seems to work (i.e. the CRU is good).

For the series:
Tested-by: Simon Glass <sjg@chromium.org>  # Luckfox Pico Mini B (RV1103)

Regards,
Simon
