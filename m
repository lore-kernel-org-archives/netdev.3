Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFB3BED46
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475908; cv=none; b=g0/raLpgZTzRqPptHPwGYDZC+KJHd33mTIHhTQp9jDyyOtLVacOJLHjCH0VWGixxMJ9cCigW3uJ02o9EVbdW1IB4kLEyyNkVhHywqnEOk1HSUMtWq3ALGU3piAceZg4pQodmYVZ7/HJD3Rr7UAxnvf+6DferyWWmVXMPEZEMU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475908; c=relaxed/simple;
	bh=3U3FFMpL/0KFQ9aJbDcohV/C+gz2MYQFunwiq3cxfnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0zn7ucHwHhimKbtXz+ueFB0bptapHrrCG8ln1FizpW+MkSip+9jEuFgk8f61dmwirmY6ldochz4eBWJXMuJO1fmdqZkmW1Ln78C8zqZhLnNKkOpJqVxfvGmPcRtA8kp45XDt20YGjY/Qb6jFR8ocml95Hf2hTqTm1yEaw+piaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKn/r/WV; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKn/r/WV"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso3001140a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475905; x=1790080705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXqazLDcNN+nNV7C/3qAYrA4z9CX2iKq+iwX27rl4Qk=;
        b=oKn/r/WVGJUsvDruw5SPl7Tq8tdBsG/vaF2Vf0CG3eKAZ5yDBy7hgcGSDJR+0K3tfb
         BU17/kjqSlZFJ2ZBssGT56n1iWqAHpyWLDhtEvPIOz7sR1Pv4cUaP3DSmR6HzIkRUGSp
         sQ1NVqucCQBGdtzCw22v8K9yrlXLMHvctrRTC4R9/V4kxu2B4kmNXIwE7zBUrng+4JWh
         Vz8T4WqI6dEhhvU1f76wmFFGLcqPrfysPDVHEtzlxHbrJ77mt9oHOz8XD7cr1JOqYVH3
         lMI/2jk43DdxQiCElO0fhVIvxRKyPYE+FXxVMaQhLMeXRrgxZ9KrvtHimqXZiW6d+xx3
         0ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475905; x=1790080705;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SXqazLDcNN+nNV7C/3qAYrA4z9CX2iKq+iwX27rl4Qk=;
        b=LI9vaDpMVzS3rZEzsXTu3+oA+S40tQNjEsruOvArSFu332xaPFa7vuny5GxYUwJUJ0
         cE4b7gVWVYNULp7sR+Ddt7zAQC6tKyVH24aeKHZbhwBHh6StIOd5oC9sCC5hxdqclSd3
         BBW7aI5LZMedp8iFY0WShnHZ/Mx5BCZQfvP4FIZgYDDH7GXrfFApUxhtBOa2dvsh3fRt
         gR26fzpDNzPOPFf9UQeEatrsEOadVzX5ortHVbghZ/WwcgrBIkKmctBcDiTl1D0n3X7Y
         3kZE1WOmlujOZy16yDCLJxgpPvqfIjguXmBiQx3OHKQwciqFvhu8bH//eYPngG9gEjiE
         jl3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwtSpXSgnyml7wnZMRxy2YEUxbXSrJET+ag3xsNmdPh/TP/JaAecCZcPnawp8s3ukwMh5LXPGg=@vger.kernel.org
X-Gm-Message-State: AFuF++ntAQuNCSMD2LYIHkkzajymzVcKnxIVaImZlaQw+xVK+5nCIidX
	7PbLpCbDM8oE19eYP+PKmBcKsRhIo/3HtzFloVOhxt2x2b6LcMitnueF
X-Gm-Gg: AYBFou0qmS1uVHCk/77znc87a/OdDvB9bLvp1XlEbgyzZEbIOYKpynadqNqSVpzQZoh
	NWqUNAYFU/PlaKljvmviU8NPIpPeUfoo6IvKn66EYebLnQfDWidD14ca5e9OU43OX2z7DPHfqmK
	J+Z6G6wYTMz/LLNs646UBjT3pB8PLeYsvg0DQD8w+bZ4NSeoQe5r/wBwfpRPU976XkvGWbDcSWx
	++uPxdMK+HmRqePiNw5GmFe9CVl01svT3gwIjwsMJBRxLCr/jL1shl3RUJ7WSdx+HqITIH4W+i7
	dMPCPnX+ndtFooT5167E2HS57t1gZTFN+uJLHEjYHrJV+RapY0COojkUzjOb33ZsPxAvFyBkfuK
	W3BbLDH1K3cZ1FO1ASiz/f+BFGS/DQQC3F0vFZhL/94Uq6m6boW+qt2lAFu0UHQ9nnUHBvEspCM
	um++XULw++0jsWyMZ18Xq2yOtDIZNVLMkW59W2LW5FGbba/C/L+XwMjgt9VO8ZoYdoDz7CsQ==
X-Received: by 2002:a17:90b:582b:b0:398:dcef:c040 with SMTP id 98e67ed59e1d1-39dec0aac20mr14226976a91.19.1789475904683;
        Tue, 15 Sep 2026 05:38:24 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm5307259a91.10.2026.09.15.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:38:23 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v6 00/11] net: pcs: add basic support for RK3568 XPCS
Date: Tue, 15 Sep 2026 20:37:49 +0800
Message-ID: <20260915123802.1561724-1-coiaprant@gmail.com>
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
- Refactoring stmmac PCS lifetime management to allow platform drivers
  full control over PCS creation/destruction
- Fixing the XPCS driver's SGMII link recovery
- Adding a Rockchip XPCS platform glue driver and wiring it up in
  dwmac-rk

Series overview
===============

Generic:
  Patch 1: move XPCS lifetime management to platform drivers

PHY:
  Patch 2: DT binding for Naneng Combo PHY SGMII MAC selection
  Patch 3: implement the PHY SGMII MAC selection in driver

RK3568 XPCS/SGMII:
  Patch 4: DT binding for Rockchip RK3568 XPCS
  Patch 5: add XPCS and fixed-clock nodes to rk3568.dtsi
  Patch 6: add ANRESTART support for SGMII link recovery
  Patch 7: implement the Rockchip XPCS platform glue driver
  Patch 8: DT binding for Rockchip DWMAC PCS
  Patch 9: wire up SGMII support in dwmac-rk
  Patch 11: update MAINTAINERS

Board enablement:
  Patch 10: enable SGMII LAN port on Photonicat board

Changelog
=========

Changes since v5:

Patch 6 (net: pcs: xpcs: add ANRESTART support)
- Document the DW_VR_MII_AN_INTR_STS clear and the return value change
  in xpcs_config_aneg_c37_sgmii()

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Fix eee_mult_fact overflow on 32-bit builds: use a 64-bit intermediate
  and clamp the result to the 4-bit DW_VR_MII_EEE_MULT_FACT_100NS field
- Drop the nested device_lock() in xpcs_rk_create() and establish the
  device link before reading the supplier's drvdata, to avoid lockdep
  recursive-locking warnings. The link is removed explicitly on failure
  paths, since DL_FLAG_AUTOREMOVE_CONSUMER only removes it when the
  consumer device is released.
- Select GENERIC_PHY and PM_GENERIC_DOMAINS from PCS_XPCS_ROCKCHIP
  instead of depending on them, so DWMAC_ROCKCHIP can select it without
  unmet-dependency warnings
- Document why the EEE multiplier is derived at runtime rather than
  hardcoded (the clock is muxed between 200 MHz and 125 MHz and can be
  changed by the board), and the MII write remapping in
  xpcs_rk_mdio_write_remapping()
- Add TRM reference for CRU_CLKSEL_CON29

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

Dependencies
============
None. All patches apply cleanly on top of torvalds master tree (v7.3).

Acknowledgments
===============
This work was inspired by and builds upon the excellent work of others:
- Serge Semin's Synopsys DesignWare XPCS platform driver (pcs-xpcs-plat.c)
- Clément Léger's Renesas MIIC driver (pcs-rzn1-miic.c)
- The Rockchip TRM and downstream OEM drivers

Thanks in advance,
Coia Prant
---
Coia Prant (11):
  net: stmmac: move XPCS lifetime management to platform drivers
  dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel
    property
  phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
  dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
  arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
  net: pcs: xpcs: add ANRESTART support for SGMII link recovery
  net: pcs: xpcs: add Rockchip RK3568 platform glue driver
  dt-bindings: net: rockchip-dwmac: document pcs-handle
  net: stmmac: dwmac-rk: add SGMII support for RK3568
  arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
  MAINTAINERS: add entry for Rockchip XPCS driver

 .../net/pcs/rockchip,rk3568-xpcs.yaml         | 110 ++++
 .../bindings/net/rockchip-dwmac.yaml          |  15 +
 .../phy/phy-rockchip-naneng-combphy.yaml      |  13 +
 MAINTAINERS                                   |   9 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   |  74 ++-
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  45 ++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  44 +-
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |   7 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 133 +++-
 .../net/ethernet/stmicro/stmmac/dwmac-rzn1.c  |   7 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  39 +-
 drivers/net/pcs/Kconfig                       |  25 +
 drivers/net/pcs/Makefile                      |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 573 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  35 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 19 files changed, 1089 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

