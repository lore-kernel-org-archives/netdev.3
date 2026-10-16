Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981C466B08
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146633; cv=none; b=uhmc7v5VcqSoUJ/ghUTd/nDDXCUlxBCq1HFdmZt5QThi6jc6CzxkR33m8DN8fdEOuezgWac8XgMM1ooENhTmwyPnMZOa3Bq4tRr6az94FaRBu/Xfxk9D+qyhSOMMiKtpSvE404Ge6gu6xbt5q7ndzRb28Q02Z0OjgTmQuH8yMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146633; c=relaxed/simple;
	bh=Ege0/EoNxjOYq/JSHXKRjvnL6FEhr0EiMU8LIrSzUr8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tg1jRyJ8kxL9LUDQXZFRzr6dLOqEsD8Via564c88Cg9DJcJ7HH2jImsevHrD9EUYr1eTArRNC/oUEK2nEZrAYzxEEUMibaaHICowwo8KC+owScmSQ3tJhOAUbGJDq8sgFzbuDwhL+6NrIbIW+uN/SMtQP/gylvU5moJ68/4zMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibQy4fc7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibQy4fc7"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so5269431a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146629; x=1792751429; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a+WpDzd7OYp8TJV8imDgncnEO+VG7E395HCXpXIMqtU=;
        b=ibQy4fc72nf3RHmGgfh0kBg7LokguvEqtLVZUWx/nQLVCe6R2uyXgkXy5XQl8yZpc6
         8eOa6flFn53jRUUtRZ5cldIuSGx1VvXEGs0L5TQyUTpnb5GFviM0BzsjBWm1KaMpOeR6
         3QYcU5ES7SWdDypn5x1zWV/LGDKLhyF+88zJjhMgDvQfjsNxjA7mjAJcJKbRj5B4XefT
         mjPskxp7RigU7YOV8IZVLazlHP0NHTHm3EXtYjZwTNa63n7KShwkprc1+ougT/4RbFSx
         QKLY+IPUgDxeydXDjDv60e17GNIFsMZB0XhTMTa28f9audxlPfLruaYZaqrFnwWstzR8
         y6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146629; x=1792751429;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a+WpDzd7OYp8TJV8imDgncnEO+VG7E395HCXpXIMqtU=;
        b=cbAXeiOS+pOcJMVEYCrGg969xi8+9iuN65oXpti80HiDoXhkSuajvkcPQ+Siv3EMC+
         m54FPdU4kkSGblpPIBP2LqLVSduKyG2ploFxuUcaa3ZHc2RXuzMjH8kKbvqdNNEGi+IO
         8ACGedJW8h6JLwfaLFwSOu9cEom74O8iAe9y1BQMrRjC2X6ARAwZEOmHaIWW/EHDtsKI
         Or9g7HYR2ODcH51fYuG0BsdtxIPA2azkdZ7du2ugmAN1QGAmz4QAUVqRQrUuQ/gozCr8
         nxdh+zvuAuhLFiAFaTSrrsrcPtb/jDSbuCVK7UB9b/0eAv2S29EvBumeSqRwPVZ4ycf6
         ljsg==
X-Gm-Message-State: AFq9FYKkd540vq9Pz7LbxKZCQDeetJ7JtSa0C6ZTwvtBs0/Dmnd35phK
	/vAf9MTGZ5qi5L5DfPPlG/pFNM/6jJOzfykIKQp+q0L12nEt7w/vLors
X-Gm-Gg: AYBFou3J/4IOTfHfmrcYpRrkzfxtwFOQxTZKl3RoZ0+qidgcYPSAj0assCBASWRZkUU
	HyUo9HoXDnIBFT8Gp6hIAG5GMaszWGebOYjFlOXOlfbaCAaDEuv091XMLJY9rcYK+0i9lkbwcvo
	8iMn90xPbaIZb7Lw9nB8U5+FDVFKYRl0Fh1FWArjxfQa/YxJeBwHQRpCUArjuMqW+OTCyGW6GS9
	A1yRnKkFnH0Ap7XBibHYDrMRXejZ8yHiB5GO8S6COM1B7iRmbeUmICLyx8h0zvvP8KLjtQQgw5l
	KtWk6coBve/LjRdh+zASv16JJUEyzgos/tNb19yhlVD+kqcMadwZzqbr1ZXSURKHvB2zep7wK9b
	PtzAGd5YYnlQqR3OPJLRlSqqmE+zHf3FWjenYeIfFGANvPCWSVZczp3ZKGro9LqZ7U9ydfmkH1E
	MU6PtEjES1GRPaxj2iU54GjH/T0dT+8ChiggRDJKlB8MuW3d9KcUvt5aS0VdcLB9diMI3+DkDgO
	6KvNR1sNngx
X-Received: by 2002:a17:906:ef0e:b0:c3f:c878:7c1d with SMTP id a640c23a62f3a-c3fc887c5f8mr325847366b.9.1792146629272;
        Fri, 16 Oct 2026 03:30:29 -0700 (PDT)
Received: from localhost.localdomain ([193.107.16.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce133sm60613866b.31.2026.10.16.03.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:30:28 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH v2 0/5] arm64: dts: rockchip: add Forlinx OK3568-C
Date: Fri, 16 Oct 2026 15:29:32 +0500
Message-Id: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIz80WoC/22NQQ6CMBBFr0JmbU0pGWJdeQ/DAsoURoWaFomG9
 O62uHX5kvff3yCQZwpwLjbwtHJgNydQhwLM2M4DCe4Tg5KqlrqSwt0rrE/CCCM1aoVdSaqGpD8
 9WX7vqWvz4/DqbmSWvM/GyGFx/rN/rWX2/mTXUkjRSmt7RItG42WYWn4cjZugiTF+Ae77i1qyA
 AAA
X-Change-ID: 20260930-ok3568-c-c095925b1e26
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Dmitry Yashin <dmt.yashin@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146625; l=2792;
 i=dmt.yashin@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Ege0/EoNxjOYq/JSHXKRjvnL6FEhr0EiMU8LIrSzUr8=;
 b=gQMaPTFI9gCYRJTK2Gs8mv2HzZL8Bu9hcZ52inWpJiLiEgR03jDdpuRHrtWBGfnPpScKzLCtG
 VKmL8wHlDVMCtYsn7sviLOi6bVj8Ske/TfJX84rqBsFp1J7gmTO7CYI
X-Developer-Key: i=dmt.yashin@gmail.com; a=ed25519;
 pk=vBe9jaaOEH5bQEvfzb1tWOlz3AMIcXCu/GL/CdlwJco=

This series add support for Forlinx OK3568-C board based on FET3568-C
SoM (rk3568).

Patch 1 adds missing reset-gpios property to rfkill-gpio binding.
Patches 2-4 add .dtsi for FET3568-C and .dts for OK3568-C (depends on
 patch 1 to suppress dt warnings).
Patch 5 adds .dtso for FIT-PCIE-SATA adapter that allows to connect
 SATA drives to the board.

Note: tested on v1.1 board. On v1.2 RTL8211F phys use dedicated
crystal oscillator instead of 25 MHz reference clock from SoC. Patch
should be compatible with both revisions, as in [1] solution.

[1] https://lore.kernel.org/all/20250704-rk3576-rock4d-phy-handling-fixes-v1-1-1d64130c4139@kernel.org/

---
Changes in v2:
- added patch for rfkill-gpio's dt-binding with reset-gpios property to
  suppress dt warnings
- removed mmc-pwrseq. AW-CM358SM has only power management PDn pin
  for both wifi and bt. Using shared wifi_bt_reg_on regulator fixes
  bluetooth failure on cold boots
- added bluetooth wakein/wakeout pins
- moved leds/common.h to the SoM dtsi
- switched gmac's phy-mode to rgmii-id
- added rfkill-gpio for modem reset
- dropped unused wifi and bt pinctrl's
- Link to v1: https://patch.msgid.link/20260930-ok3568-c-v1-0-a0ffd55f5c95@gmail.com

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org

---
Dmitry Yashin (5):
      dt-bindings: net: rfkill-gpio: document reset-gpios property
      dt-bindings: arm: rockchip: add Forlinx FET3568-C
      arm64: dts: rockchip: add Forlinx FET3568-C
      arm64: dts: rockchip: add Forlinx OK3568-C
      arm64: dts: rockchip: add FIT-PCIE-SATA overlay

 .../devicetree/bindings/arm/rockchip.yaml          |   7 +
 .../devicetree/bindings/net/rfkill-gpio.yaml       |  23 +-
 arch/arm64/boot/dts/rockchip/Makefile              |   6 +
 arch/arm64/boot/dts/rockchip/rk3568-fet3568-c.dtsi | 332 ++++++++++++
 .../rockchip/rk3568-ok3568-c-fit-pcie-sata.dtso    |  16 +
 arch/arm64/boot/dts/rockchip/rk3568-ok3568-c.dts   | 579 +++++++++++++++++++++
 6 files changed, 962 insertions(+), 1 deletion(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260930-ok3568-c-c095925b1e26

Best regards,
--  
Dmitry Yashin <dmt.yashin@gmail.com>

