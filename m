Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A237F8CB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239435; cv=none; b=I+DfiNZ845UDYrmMenziwNF5Thp8J6ZZia3sOhmLkG0vswr4735pbLdKxvpF0dh+5H/Gs+MbPecM3T/vynQDt9E0/R0T6abzggqgzr2pmOyytxpzC2KNe1Sp5gRh5b7MMrDltOZhqB1ibd2/0Mgc9LzvdSL95Tdu55isGRUzbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239435; c=relaxed/simple;
	bh=Vjeigs5miKxyS1Mz1zv2jrkkwIdisPU5Qrdz/GVZQQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ilG9Q35nhu1vpQ23R99HvFq1RMA9U6feIecSi1SpQrisLrwgTUNEOQVn1gINI0uBlH4Kk2WGK3MhzUdBHRuhyovhk9cpv9BpirMS0uatG5anFwLg6BjBLy/vurT7ahKz1GGbfzHyRr8RK3TZ9EBT73gXpki7hWM5BY0FTnXIR2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaQ7rKAn; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaQ7rKAn"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3a4883304bdso559361a91.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791239434; x=1791844234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dyXKafz8ImkayNO8unQ7aikTx/yLC8/flyV0cIQnH0=;
        b=PaQ7rKAnVI50eaZQRD00SziP3ZIJvfuRrrtEB2K8hNvkcCJRUrA8ZYQ27rBKdi+up3
         sCCZEgB8UlDWapDLL2+srzAoTHJdMQ9PfpZvyLYD9JmOXcvO+x04VbB+mu9c7mZtb5EO
         s+HCNxZotjDuex5mNJxRwYo0L/rCUS4+13w5IjS5AJyZSlB0ZdgT+ETK55mrTN9QFX+F
         VFEhUaGqnlNH4AjKRj7wtp9nDjkBLubVTec/5o9abuF7c+Qifu2eEfbJmcAc5PA0Z+yb
         Z8/ODVcrHZ82m3M/6vryojXgfSco+VAtCPoBGlN7zZ6KJ+baElZKOACdCIlCX+7+g3Z4
         o2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791239434; x=1791844234;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7dyXKafz8ImkayNO8unQ7aikTx/yLC8/flyV0cIQnH0=;
        b=aV5mrE7yN8eUmmISNam1yeFI5URMb0wZEBN3/EUbk9OX2SYTJJeRUkT0AffzVJE7vs
         8b8CALQG0HnaFiWV+wSzd1UTE1E9T5aG0/NYABKyl188TLeyey61hL7gLTGKabNcXYYR
         KOaPvXh/s4z5Bvgm3doM96BgXg99JcwztY6wRBFAw8DOL3u5ldaZe3n8nfgWQYXXw8KT
         4j+1Z2FdxtWy7I2C9gJ8J7PFtDLbXUV5YDbjb64CA1wQ6A/bI22+8ZNCf2TQQ6aIQ0jy
         4+x2uTqeld/j0ogrFqaKD2P8qpCfvdWRFa5ynjSynMcnCoi+micolWzroB8kiFeCuZk4
         TLGw==
X-Forwarded-Encrypted: i=1; AKwUvBweptUuev4zJW89uzAmz5vNZj8A2BX5RGPBGRLMmCBcpMwUpxfJyaNVBhhccJZfhhpLZjwE9Xo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2q+WbCSXkeDvolaBwG5pWLmQrYZXdaodmgFAgzJEHiq+VZzum
	+nZUAQwD86AUfUbs7tQIvPEmcRck6Ho7XxUck981UMx0oDssIcZuUfDG
X-Gm-Gg: AYBFou2HfeniTWOaz/Ddokc0C2juiJbeKLgkLV0WJTfuBu7OZVSm88MvQoRH70FsYkJ
	VWtEDG2rcElPvG3w6Lyu+r3imehW5J6UW0iQvSYkLLGoLV3J1Myqsmf4MR7u9iTpGfBuzjpJAAZ
	RpJi5F6GdsxXy9ZL+Dwe94+8+EaU5m3T85M5Hc82gZD+sM7oGaXkF6f60DMxY9oxjYcGiDd6VM+
	2wJmeYi/X4DMm1MhEOZZO+oDgRmEhKPr3ocbiwMP3SlvKQP4VPhwxo0JPFydRfS2mNVJ68g2QAV
	VTMxB9CGvGsG0PxgmWJpBp3WTBhz/BR/hBnTe72LjHhZhAWXymGN4VvBSVPLK11xNnZD6NlMUi/
	MRJqwsmAyBWcutn/LmS+PQeBYc36nbDBWbQLpCfe+WX+w8a2PIQiA4jgs+GsfmSA3EoHEuk9oXR
	ZSDnHFSa/+5xmFMkWjvuXYIRDMpPHZpvlmyvEWvG2h0Y1cgZEkEPR6RLJMqLOyzNaGTuvP
X-Received: by 2002:a17:90b:134f:b0:3a0:ca03:3e1f with SMTP id 98e67ed59e1d1-3a7872b2fdcmr6955612a91.32.1791239433477;
        Mon, 05 Oct 2026 15:30:33 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5f05321sm13203705ad.78.2026.10.05.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:30:32 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v10 0/6] net: pcs: add basic support for RK3568 XPCS
Date: Tue,  6 Oct 2026 06:30:02 +0800
Message-ID: <20261005223011.1124347-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds proper SGMII support for the Rockchip RK3568 SoC
using the integrated Synopsys DesignWare XPCS, along with necessary
fixes and refactoring in the stmmac core and XPCS driver.

Motivation
==========
The RK3568 integrates a DW XPCS accessed via APB3 and connected to
a Naneng Combo SerDes PHY.  Several boards (e.g., Ariaboard
Photonicat) use this interface for Gigabit Ethernet.  However, the
current upstream stmmac driver does not support this configuration,
and the XPCS driver has issues in SGMII poll mode that cause the
link to be reported incorrectly.

This series addresses these issues by:
- Adding ANRESTART support for SGMII link recovery
- Adding a Rockchip XPCS platform glue driver and wiring it up in
  dwmac-rk

Series overview
===============

RK3568 XPCS/SGMII:
  Patch 1: DT binding for Rockchip RK3568 XPCS
  Patch 2: add ANRESTART support for SGMII link recovery
  Patch 3: implement the Rockchip XPCS platform glue driver
  Patch 4: DT binding for Rockchip DWMAC PCS
  Patch 5: wire up SGMII support in dwmac-rk
  Patch 6: update MAINTAINERS

Dependencies
============
- Generic PM domain (genpd) changes:
  https://lore.kernel.org/all/20260925041751.495818-1-coiaprant@gmail.com/
- PHY binding+driver (Naneng Combo PHY SGMII MAC selection):
  https://lore.kernel.org/all/20261005221229.1095843-1-coiaprant@gmail.com/
- stmmac XPCS lifetime management fix:
  https://lore.kernel.org/all/20261005221749.1104430-1-coiaprant@gmail.com/

The DTS changes using the PHY property are sent separately to
Heiko/linux-rockchip. There is no hard build dependency; the pieces
can converge during the merge window.

Changelog
=========

- Resend and split: PHY binding+driver sent to linux-phy, stmmac
  lifetime fix and XPCS binding sent separately, DTS sent to
  linux-rockchip.

Key design decisions
====================
- The stmmac core now delegates XPCS creation entirely to platform
  drivers via pcs_init/pcs_exit.  This is necessary because the
  generic XPCS creation logic would override any XPCS set up by the
  platform driver.

- The Rockchip XPCS driver creates a virtual MDIO bus over the APB3
  registers and implements address remapping.  The generic XPCS core
  handles all PCS configuration via phylink_pcs_ops.

- On RK3568 in SGMII mode, the MAC clock is fixed at 125 MHz and
  cannot be dynamically changed.  In-band mode is used, and the
  generic stmmac set_clk_tx_rate callback is disabled to prevent
  incorrect clock updates that would break RX.

- The SerDes and power domain are attached to the XPCS device tree
  node rather than the MAC node. This reflects the actual hardware
  topology and simplifies the dwmac-rk driver by keeping all PCS-related
  resources self-contained. It also prepares for possible future QSGMII
  support, where a single SerDes serves multiple MACs and would be
  more naturally managed under the XPCS node.

Testing
=======
Board: Ariaboard Photonicat (RK3568)
OS: Armbian (trixie)
Kernel: 6.18 (backports)
Result: The SGMII interface obtains an IP address, SSH works, and
        ping traffic passes without loss.

Notes
=====
- When testing out-band mode with set_clk_tx_rate, only 1000Mbps
  works on both TX/RX; 10/100Mbps only works on TX side.

Acknowledgments
===============
This work was inspired by and builds upon the excellent work of others:
- Serge Semin's Synopsys DesignWare XPCS platform driver (pcs-xpcs-plat.c)
- Clément Léger's Renesas MIIC driver (pcs-rzn1-miic.c)
- The Rockchip TRM and downstream OEM drivers

Thanks in advance,
Coia Prant
---
Coia Prant (6):
  dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
  net: pcs: xpcs: add ANRESTART support for SGMII link recovery
  net: pcs: xpcs: add Rockchip RK3568 platform glue driver
  dt-bindings: net: rockchip-dwmac: document pcs-handle
  net: stmmac: dwmac-rk: add SGMII support for RK3568
  MAINTAINERS: add entry for Rockchip XPCS driver

 .../net/pcs/rockchip,rk3568-xpcs.yaml         | 110 ++++
 .../bindings/net/rockchip-dwmac.yaml          |  18 +
 MAINTAINERS                                   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 130 +++-
 drivers/net/pcs/Kconfig                       |  25 +
 drivers/net/pcs/Makefile                      |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 619 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  35 +-
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 10 files changed, 935 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

