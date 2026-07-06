Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5F3FE344
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329308; cv=none; b=CwMaZX0Y+PAQqy4ELjwXb6TM4IaizYlyFvPNpDxk989z/rb3YF1KWf9nQIIeQVYeHDdYFl8UqqoBSrFS4OOQIguetux+pjDuX6bvcsP/SUTNerjEIJLhBiMC1XLnHAZ1c5+fpidotWYUTr7+sewg1CF5h2nf5Pmh29RfV+bkBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329308; c=relaxed/simple;
	bh=cLIYaTp8BMdNpvmeNN9IHEGffrelsNbt22peLlfH/xI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TyfkveYa4WURseohmst9rpa7SnoVr7vglV5vfUlfKPfIJTQhJEE2JO81TN/UMTLb1iZvTSuRsmVJG5aC/cM+LuqlszTtrTNon31KQVpPMpB4EPZ+1n5obU1yP/YH1INnrcptwHcLAHO1STF7iEWnjpHpxdtsIzapQMC49s6X0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo8T5weg; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo8T5weg"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-847aa193d98so2246398b3a.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783329297; x=1783934097; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lr2T/VNgeTFspDjmoHod2aovQh7y4rJk7xKdeAYkRu0=;
        b=jo8T5weg/vHPDISdYCYykZua/c679JikDK8+sZbpu/U/yoOegNqys1P+u3MciEXDLD
         z0V0t1vWJYWbWFzQSy4nQRO7XKTl1MObiLWyx0m9RsI5eiPhJQFNjKAQbzm/S9NSIsN/
         eDOcq12sRSmQ077GCQBW5DiAvKRfFUsKl2jiApSVmQIH4xmjrlFwapEAYXDApSh3dR23
         yoT9BvZkCqRF2Dx76AD3J0jJ2LLMBDDz+Mw3Ak0ISjA86uRfDyjv+tQGrXjq50YOGS0t
         FqVwTY2qrK/nWmKIqPm6akr9IIxFFWOKF3PaIp8aoCJFFQG6Kyc7Kt83/ia4ElBV07UL
         OWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329297; x=1783934097;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr2T/VNgeTFspDjmoHod2aovQh7y4rJk7xKdeAYkRu0=;
        b=gXwHxrE6B3HW+CFCVQoePlsPq09ZvHT8by7dg1yQst1eFT2g/Seudeo60tjpaXogT1
         Ppp/XOKqyCBb/Xoq4af2zR6Eb2JX1fEBNvKpu/3TCkfyOfEZ2QpRjCnyCdNCoEiEDhh6
         7s9BsK7vaH6xJJdfzWYtZmS9KKqTRlR/O5pbZqd9RLAaTRyAmbYYX6+pHLWgQMMwY5rc
         vS8zy8BaVZZFKx6oPcF7LuRBqS7pjTYBYVqvetaHJ7hFznEprCQwzleDhM83i1i2EMBY
         E5kbRpyXJzIMx5IALhKLk4bVVfcVIUGwyq3U+wxfoTr3Y/VaGLOB2gL/pNF24UKeg3p9
         Y5HA==
X-Forwarded-Encrypted: i=1; AHgh+Rrv8w7NBNubhuaog6qnKRug0tFc7Xs1ZuISPfXcQm1ROgs0YDQd0YH9PFQPrec2xYPX5zgBzU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTqk/NiNASJC+4HtIjmzIbXjiACWMRz9LylqZ5ZwhPJ7iEUk+
	CBLsw6p6sBf9Vh6RmixjQoAsHYOx+52FjmzeoMXBpVmLIEsQHpNFFg66
X-Gm-Gg: AfdE7ckFAlIA0ggIl/GVpwb/5lI6m+AexsTpbAztiB3Uw1Sbnrb+MosU/u7amSUCAS2
	WRXwvCo4w202myX/Y2mQ497YUfkI9btwtkfYktHM6S3FKIdybiW6vxMqp/Q8RpgadfnGPxi/i2L
	Iawat8JpBCJ+HCUMqoNPuvDEm7LxZjoGhgNKm6CsGzgfaI6jWkHUv1xVzFLNQZU8WXbTOGJsyYV
	LY/eIdsgXbODTkJ1xMYxeOSeXuIhH312MtfMqElcApzxtp8qBPqha1JOHbIhNYWDM2ZriB4rSq3
	Sg3b5wxSOgm/vBgoMgxMi9ME6GYCGT32Mo0EpylHYpo5WlVZjsOwX20ppPrGUg/sbB4hKpVXtTd
	P02a/ixoO6FXLVNOzic34Fu7zhx1rDqCuuGd9gzubsNcamjP+qVbKL/nuHbf3OSKWsyvlQotHMR
	XFW6pr10AZKbhShQBWLoB/LQm1
X-Received: by 2002:a05:6a00:928f:b0:842:80c5:c420 with SMTP id d2e1a72fcca58-847f6ef68camr8193652b3a.40.1783329295132;
        Mon, 06 Jul 2026 02:14:55 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm3445963b3a.53.2026.07.06.02.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:14:54 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Subject: [PATCH v2 0/5] ARM: rockchip: rv1126: Add support for Alientek
 ATK-DLRV1126
Date: Mon, 06 Jul 2026 17:14:40 +0800
Message-Id: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ML3aIyQ0MjM93EnMzUvJLUbN2UHKhIiqVJYlJKcpqFqYWBElB7QVF
 qWmYF2OjoWAi/uDQpKzW5BGSeUm0tAHxpGmR8AAAA
X-Change-ID: 20260618-rv1126-alientek-dlrv1126-d94abdcf8580
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783329286; l=2237;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=cLIYaTp8BMdNpvmeNN9IHEGffrelsNbt22peLlfH/xI=;
 b=n9ZjERAhzjx2V7crs7HJzpo3tqAmQ8t8NqGgffNufU3uJAKs2gRa4YnXgybLrwGB6BscbMpTf
 6R7McTRg+88CmER536i37fi+k30MyFTlhzIpbLcmMPD4KH0VhdznWAN
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=

The ATK-DLRV1126 board consists of a CLRV1126F core module and a
DLRV1126 carrier board. The core module contains the Rockchip RV1126
SoC, eMMC and RK809 PMIC. The carrier board provides Gigabit Ethernet,
SD card, AP6212 WiFi and Bluetooth, PCF8563 RTC, ADC keys, GPIO LEDs and
audio connectors.

This series adds the Alientek vendor prefix and board compatible, updates
the Motorcomm PHY driver to consume an optional external PHY reference
clock, adds missing RV1126 SoC description pieces, and finally adds the
CLRV1126F core module and DLRV1126 carrier board device trees.

The board was tested with Ethernet/NFS boot, eMMC, SD card, SDIO WiFi
enumeration, Bluetooth LE scanning, RTC, ADC keys, GPIO LEDs and RK809
audio card registration.

Changes in v2:
- Model CLK_GMAC_ETHERNET_OUT as an external PHY clock consumed by the
  YT8531 PHY instead of keeping it alive from dwmac-rk.
- Add optional clock enable support to the YT8531 path in the Motorcomm
  PHY driver.
- Use phy-mode = "rgmii-id" for the Alientek DLRV1126 GMAC.
- Keep the PHY reference clock in the ethernet-phy node, following the
  rk3588-tiger.dtsi pattern.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
Yanan He (5):
      dt-bindings: vendor-prefixes: add alientek
      dt-bindings: arm: rockchip: Add Alientek DLRV1126
      net: phy: motorcomm: Enable optional clock for YT8531
      ARM: dts: rockchip: Add RV1126 I2C5
      ARM: dts: rockchip: Add Alientek DLRV1126

 .../devicetree/bindings/arm/rockchip.yaml          |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/rockchip/Makefile                |   1 +
 .../dts/rockchip/rv1126-alientek-clrv1126f.dtsi    | 277 +++++++++++++++++++++
 .../boot/dts/rockchip/rv1126-alientek-dlrv1126.dts | 256 +++++++++++++++++++
 arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi     |  10 +
 arch/arm/boot/dts/rockchip/rv1126.dtsi             |  15 ++
 drivers/net/phy/motorcomm.c                        |   7 +
 8 files changed, 575 insertions(+)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260618-rv1126-alientek-dlrv1126-d94abdcf8580

Best regards,
--  
Yanan He <grumpycat921013@gmail.com>

