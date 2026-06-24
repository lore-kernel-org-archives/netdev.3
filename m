Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6462EEE71
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290799; cv=none; b=BB1/7taQi1a74M/pMcDeYv1x40pZUG9/P/DDO87NOA9f87u1A0UNrcpRs4z2QVWnM8vu8yjWLICXBdNy62tvBN2L6r7R82UGYeK2M7VF1CvxU2TPxjGEeGx2ZIZsiC/fdG2Dq0NM3vDJTRJqkKsSU4Rdi/BObA5ruoJLGiOOwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290799; c=relaxed/simple;
	bh=iJnYjsvlFEQcTUEBJKIAHZNJZeAQoRS5+2RUTfWmdhc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=emUxKWBh4Ohnu8A/Di5kQ+aOYZ+AuJaBQmABBbslCJK1v4e3Os82pEPnq5OaJPF79cjFkRd48WNE4d1PPyQpAyj3QPMqTHF7+gyF5YoQMYJoazyD5fwUvv2IgseexSibf7V+V2qAV0sOPfjpSx/a0xGNl+F2QtpUar76oHG7boU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqCA0qU4; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqCA0qU4"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-37dd266c32eso597773a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290796; x=1782895596; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VaTXxl/rE8HFkzzKKmqnaZrWWCZtpV0ev/8QevFoQa0=;
        b=XqCA0qU4kM+N5D9vP6q741Pqnt4e1zjsDeDeKk/IW8yOulIBwZHauqAkdsja1/akx5
         Jf34p91GgxrozbpghPVLtMMtNz8qHhcwXLCcJAfMYHPvVys6rqpOMxB5/W5NC6JkeEuj
         sUOta3Agn2MeBQZCs2xfhVr8282vfTvMunuH1v5f2AZ3maBU7B97Vu+45RHCGUAWISmL
         SleL3yOkJmF1ZvWhWeZSCFJeefdpAV54EeYD/IB/zjlVx9p5IbHAKkm0MzSREiR0Iqma
         jNeXwlaut7JvkhMHdD0xR3dt+hBzqCrFgG97hIfgirO5XTDhz4GFGL9vrWjpJsIbAIUi
         9gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290796; x=1782895596;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaTXxl/rE8HFkzzKKmqnaZrWWCZtpV0ev/8QevFoQa0=;
        b=UyM0l5uIB7XLj9drVW30gM4J8r/eoDpZ80AnXsncP5rsfITQTa5aWlkoeQHd5ju2jn
         WpyW6PNOHQET0dtzVgb6eQtjt6CNAR6jSmQdereYPeAcDNTAFuy/l1blCa0tdftgGHqE
         I1cd1OwBvrCyYNduOHWhxO58xeoSl2xCc6FR//VxQky/YPQyd/nQWz5+mdUs464+0k2w
         mVH8BOQw7StC/bio1w0mmbIBWqMII/n3Q+KL71Hg4BHdmdx0YTAoyctc2ojvhWjen0vt
         107E+0sFhyiTaz7HjnPNKPqChxWhrYzWBZvX9nRe2Np5m/gdcrkYZOEPbJXkvwFUD/UO
         Guaw==
X-Forwarded-Encrypted: i=1; AHgh+RqFEkGymtbAeuXvJRK4zP3s7iKIuP/edVh+RQgLKXhMyXkKOv9qx/BxD/o9iNBAaPIpSmKL8Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfu1bKwC0atspJ7+XluM5MWccnrfEyVLihE7flEHO20goCbwTL
	rNx+3/TfVex+XMOB4IvEV/g52WOt7Xn/1XHXz740Ht2Aw6YhO9BYhxSQ
X-Gm-Gg: AfdE7cmh5VX8Y+rlMdcPNYQpYsGMag0Lfi47Rpd374Yg4OBt/tagAEJ0/iJ9/KlwhfA
	8BcGDd2mUJRZKi44n4jTjJr1lNIfCIK8IqD+UxsR2ioGFy4Bd6zvc4frdGVidgvuVhEDGAbjmr+
	AZuGoMfssLTldXAfnQC5qUZlphM6u+HRTX8F0aamCD2pX5IfXY7ZmTCQc+Vw/msV+CHajeW++rK
	JmElCvP1aOakyYSbblvZCFwfmp6w1RUuHSLCKnIZYZ8pgDv0Y46TthPQ/AtoulXijPK21fhf6Ka
	+4m+8Shoyix9teXCfbvizLWNHYNmbJHcsAUZ/J1OPDRhs4tmNBDTOyTiPLp6a2BauNwmxfgzzv7
	oo98RNbYukOdPix65WF5kynqQp2uHWxm85dFHXpJqTKVaTraPNoPXmo4Y7LSKnUnmKoREuctkfH
	XKlhgjUc4l3sMHvTKyv49PHw/j
X-Received: by 2002:a17:90a:d005:b0:36d:649a:39f7 with SMTP id 98e67ed59e1d1-37de42bb597mr2631365a91.22.1782290796126;
        Wed, 24 Jun 2026 01:46:36 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3d152f4sm2138146a91.14.2026.06.24.01.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:46:35 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Subject: [PATCH 0/7] ARM: rockchip: rv1126: Add support for Alientek
 ATK-DLRV1126
Date: Wed, 24 Jun 2026 16:44:37 +0800
Message-Id: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3M2woCIRSF4VcZ9nWCSon1KtGFhz21SyzUZEB89
 7GZLr8F62+QMRFmuEwNElbK9I4D4jCBe5h4R0Z+GCSXiiuhWapCSMVMIIwFX8yH/+LPR2O9m/V
 Jcxj3T8KZli19ve3OX/tEV3496H0F2yK6+nwAAAA=
X-Change-ID: 20260618-rv1126-alientek-dlrv1126-d94abdcf8580
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290789; l=2033;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=iJnYjsvlFEQcTUEBJKIAHZNJZeAQoRS5+2RUTfWmdhc=;
 b=eAmpN/LKqYFNFMAnnsJDd9ohedM5OOImfapRIiKBxmQZmuQsg34keypt4x4eW24GHkC/Y1ECB
 nUQ/RXKU2rtBBikIZF9qoSlbOOUqSmnD3bfzpThwHvlNvdNsa/IGU1a
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=

The ATK-DLRV1126 board consists of a CLRV1126F core module and a
DLRV1126 carrier board. The core module contains the Rockchip RV1126
SoC, eMMC and RK809 PMIC. The carrier board provides Gigabit Ethernet,
SD card, AP6212 WiFi and Bluetooth, PCF8563 RTC, ADC keys, GPIO LEDs and
audio connectors.

This series adds the Alientek vendor prefix and board compatible, updates
the Rockchip DWMAC binding and driver for the RV1126 GMAC reference
output clock, adds missing RV1126 SoC description pieces, and finally
adds the CLRV1126F core module and DLRV1126 carrier board device trees.

The board was tested with Ethernet/NFS boot, eMMC, SD card, SDIO WiFi
enumeration, Bluetooth LE scanning, RTC, ADC keys, GPIO LEDs and RK809
audio card registration.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
Yanan He (7):
      dt-bindings: vendor-prefixes: add alientek
      dt-bindings: arm: rockchip: Add Alientek DLRV1126
      dt-bindings: net: rockchip-dwmac: Allow 9 clocks
      net: stmmac: dwmac-rk: Enable refout clock for RGMII
      ARM: dts: rockchip: Add RV1126 GMAC refout clock
      ARM: dts: rockchip: Add RV1126 I2C5
      ARM: dts: rockchip: Add Alientek DLRV1126

 .../devicetree/bindings/arm/rockchip.yaml          |   7 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/rockchip/Makefile                |   1 +
 .../dts/rockchip/rv1126-alientek-clrv1126f.dtsi    | 277 +++++++++++++++++++++
 .../boot/dts/rockchip/rv1126-alientek-dlrv1126.dts | 258 +++++++++++++++++++
 arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi     |  10 +
 arch/arm/boot/dts/rockchip/rv1126.dtsi             |  18 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   6 +-
 9 files changed, 577 insertions(+), 4 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260618-rv1126-alientek-dlrv1126-d94abdcf8580

Best regards,
--  
Yanan He <grumpycat921013@gmail.com>

