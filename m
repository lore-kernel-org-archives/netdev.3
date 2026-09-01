Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D040B0E0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274918; cv=none; b=Z6LQValjAobMUXb9MasTkvZ3p8T5s20cB00nxVA8pdW66GDYScRV1OT1biFttnFgL2jh8w3O+taZqJmGHRjZW7N99xAwraaj3gj2YuMCSJOnztS7BbR8ncHhrIj9MSgoeae3LTzISOj5KqOxMLxgmi5SJp/QeN+rZzbGsOTNahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274918; c=relaxed/simple;
	bh=pL+Q+ktqyanz07sm0nXL98eQ+x5pe/qTN9ZqL+Jo3cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TrWTmH5/g0NnDAaU/9JVxF1AbBeyP4yqDwzVdvvi2ZchBvp0gTrIQks1p7wsfD+2nQUmghFYp2Q7Oql2OLO/Y/c+Vgnl27PjaHtrxTdfSblwbRFethbfW/aFQNdCPSXQ5S+iv7A+zNQFM2RLLjkl6yYF1wD07NfmklPEOFgWGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oneb0NLT; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oneb0NLT"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so1695092a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274916; x=1788879716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4upqtk25tpRU54+kLrj9L2TKzcfs0ynaE33ROHv7ww=;
        b=Oneb0NLTMtQUkOFx9t+KDg2RPjuF+G94VFSQiFYxjCLQdqjrGvSa6Ck4B9Vzp68FpC
         OAgoSrm+XA0NqremssGx3pdHkpHl6NIr8OzFqITD6IrzIyshzrT3xxw5db+s+gMiI57v
         9NHmJldEs/HDIEqteELKFVEFHWJqGbd1ywrXVtmYa/cV6ggEF5LzPng9n3an6dQ71RlT
         2rMgOfgQA302Yw0TOZH2fEE/kBu1iiWYRhbu6c866woHsOXEu+3DwsYa3wFNKpXIq+90
         b5xs3Qe8SOC4ylCxv8oDk233JTttdI7K58O0XwSFrMqeh/F57z5rhmlyRus1B61Mq4d8
         TU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274916; x=1788879716;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4upqtk25tpRU54+kLrj9L2TKzcfs0ynaE33ROHv7ww=;
        b=NHVzgnqnTW+CsxidGlTWI9zNqSCKEEsUjAROkDWPW5fNVSNMrCp9002GwTlgF73yxR
         J8Q3IzlZ5z4Ns12RnyurKL6ngHe0X/3afDLS+3M8gDwJP3BmeIa9pZ15X16EWUjhKd2x
         4MYG6HPuxPw5WW71zY/1ISpTht87yeDFLMp3uKlT4gDg/iJlu+TBoGeRLyHInDGrmvF9
         6GnO55Lm4VmKwBjk1A9HlsrCzzxhLm4OxkQBWRrMp3QLdONuFCPiT7piFgRmWYcAjII9
         7SV6yXnqwqCDSsmIsGcL4vt0OFsSjM1qq2xAsvmZer/NNtbGso2x6pKcGT5Url/G4aZa
         QD+w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+9FazDwLXumz/TDLdzKBQHmMtUQ/GwzJe4ws2FbeK9Dj6eb7XCS8YiAg99J1KOntuNsqaZN8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+Hq8Bw6VZyYdhQe/pjU5NvMffgT1jbCJ/UsXZlF3gRc2S4vRr
	VEX0mTnZ29vMDJULbm/D/Qppcm1axXcg7bbyjo8jTSrfURxqaVm6qUvd
X-Gm-Gg: AR+sD10M++bufP/d24zdJWcRl5lgAkbO6Uhw98Vn63kYDVyXUmK8cEsxL732kXywI7C
	53OctoU1e31UmAJR0WPgiQpn1btmOjMF+DiFqigVZzn9pE2Jsq6BpwB0kSNP77yzt77wVhHkTln
	ycA9bS8o0Ojb0X6jsgiH25edFruTPVh++1oZEVorELhvh7oNhz2ZQVCoy2x+rXRJ3SQ6TcGYVNx
	iK8fhH/AHNjMO/FkxF5cQ52thmqEonBZxPV0Bzib38Oc4wTczaIefSP7mCuIdsNTHHTYcnjW7rn
	ZyNtOyw3WE2jzxqFsO3hRoAL9TvZNQguVdJGGwT3vrFycTq1HfSPbU2NjNmBXeOKWov7pLRxfjk
	oePRa6MmRxoFP4y5yY/SukXm71qq9y+vEmuGrUDenhPuvkXgzUbwxhVvJzhXVzYgv/d5ijZvihh
	zIVHh7Msrk8k4Y1DsjI+2DOIfewBDvZxGx7QN9H7cRl/zItODwX8TOUpDSAsI=
X-Received: by 2002:a05:6a00:2d82:b0:857:73e2:9106 with SMTP id d2e1a72fcca58-85773e29373mr34165922b3a.22.1788274915955;
        Tue, 01 Sep 2026 08:01:55 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:01:54 -0700 (PDT)
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
Subject: [PATCH net-next v3 00/10] net: pcs: add basic support for RK3568 XPCS
Date: Tue,  1 Sep 2026 23:01:00 +0800
Message-ID: <20260901150111.141037-1-coiaprant@gmail.com>
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
  Patch 8: wire up SGMII support in dwmac-rk
  Patch 10: update MAINTAINERS

Board enablement:
  Patch 9: enable SGMII LAN port on Photonicat board

Changelog
=========

Changes since v2:

Patch 4 (DT binding for Rockchip RK3568 XPCS)
- Made phys, phy-names, power-domains required properties
- Removed redundant descriptions
- Fixes reg ranges requirements for MII port

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Removed `depends on PM || COMPILE_TEST` from Kconfig,
  ARCH_ROCKCHIP already selects PM.
- Added `default ARCH_ROCKCHIP` in Kconfig
- Added comment in xpcs_rk_serdes_phy_poweron() and xpcs_rk_remove()
- Added device_lock()/device_unlock() around platform_get_drvdata()
  in xpcs_rk_create() to prevent concurrent drvdata access
- Added error handling for device_link_add() failure
- Switched from SET_RUNTIME_PM_OPS to DEFINE_RUNTIME_DEV_PM_OPS
- Changed .pm from direct pointer to pm_ptr() for proper PM handling

Patch 9 (arm64: dts: rockchip: rk3568-photonicat)
- Changed PHY compatible from "ethernet-phy-id0000.011a" to
  "ethernet-phy-ieee802.3-c22" (generic C22 PHY)
- Removed eee-broken-* properties (unused properties)

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
Coia Prant (10):
  net: stmmac: move XPCS lifetime management to platform drivers
  dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel
    property
  phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
  dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
  arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
  net: pcs: xpcs: add ANRESTART support for SGMII link recovery
  net: pcs: xpcs: add Rockchip RK3568 platform glue driver
  net: stmmac: dwmac-rk: add SGMII support for RK3568
  arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
  MAINTAINERS: add entry for Rockchip XPCS driver

 .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 110 ++++
 .../phy/phy-rockchip-naneng-combphy.yaml      |  13 +
 MAINTAINERS                                   |   9 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   |  74 ++-
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  45 ++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  44 +-
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |   7 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 121 +++-
 .../net/ethernet/stmicro/stmmac/dwmac-rzn1.c  |   7 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  37 +-
 drivers/net/pcs/Kconfig                       |  23 +
 drivers/net/pcs/Makefile                      |   7 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 561 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  16 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 18 files changed, 1033 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

