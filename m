Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E006381AF4
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325957; cv=none; b=CtlUB4K2bw2UOrkN1wU40/gFk3o23J82W4NlwC2x1kCritNy9SCYscBHIjOVZ5tKiLDf5/SWEmVAOvInipf/y253DvUd85e8a2BQQ5+AjRcWdl8NPpQ/QN0SxX9PRie0S5zWO4yePJSCbflRx5QfiRtMMh6BLJcPDNdxTfx8dOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325957; c=relaxed/simple;
	bh=FJM9wV+J9k7NMLPvudxwiAXFIO0V5kvU44NpxbEbtRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HXF3AW/1krhR+JpyiSJt3PSdJSwSDOjoNWwVf+kii74cpif6D3TYXlZlvvF4Q3OBzI1oR2owJEsbxOQdqQYIrjdms8XLGZqeQmf9Rj3NdALgWEQwhbrC25hmFtAud84ZrAMAMFkCJNIbXoXNH478x3SjyPLSZRXcKZmHCDhH+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbPuqAZM; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbPuqAZM"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d9080b18b6so24498645ad.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789325955; x=1789930755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aq4zy6PfsqGNGjFtyNQAEe67ibyvhyM2nHkT21RqtJM=;
        b=kbPuqAZMWlevVDjndXZfmGFxgddOHtuAONWmY/UbKTELa54IyAABXLOhEYp2WM3wF2
         JIR6Dfido1MzSbsNOaCiq2TmeglG/vqilCBT+5Cp3NGHHVJBpTyZFsY+DwM0DRcUG9cU
         rjoWU49GocCXDjKFyRFn6elB+cpxfrKph6G39biEN5OnSGboRTOHt0fPjUK1hZerSKbr
         SfiJ88wt34FjE9g5AenIcAObqPIdwdmkRvt0/Mw3EorYfRsuG7BuemkLWg87+LB2A940
         Cf8p9AcaF+aYxBaxPI7xI02qLBSeaj5wSOiA2t0HeZXjGulOMTIKgrpASOU6+yuryyU0
         NevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325955; x=1789930755;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aq4zy6PfsqGNGjFtyNQAEe67ibyvhyM2nHkT21RqtJM=;
        b=K0IZQj5b9/t9JB0brJQrZKHH84L7TclxJYprTncLPgT3INmKES7b8OF0VALJCgJ7Jv
         1Z6sAiPGX+aeKJ1umRuBN+VuNlHu9wFb1wdsM0umQ8RZ3UdiDH//UazcsovKcKT5vX1r
         CLFAJVkzzB/R5QBsxEB6PB/r3PtKCdWZ+qqVWGuUSY2vYnVNBiw/qK024f/TwQgjo3+m
         KGMYi8ogDIrKtQDpbBj5llpleX25wmC1MMK7bfq9zBj2A38GYBb1sT5XH+UfVRNTFtfd
         wm40t+xJx2EDyeG3JaBtda0bNYt5GjtTuZysi3i9XKXdWuNU/6b+iNLELzFHVa+GAeWy
         CS/g==
X-Forwarded-Encrypted: i=1; AKwUvBwxksvDHSRC6aF03MxOeR9yaBTngRDoj1YBdegfTUJM9cz0Bq6VfhrdLNu6tBAVXH8XasbDVQY=@vger.kernel.org
X-Gm-Message-State: AFuF++nWKvy6hB6l9iXEDdd1MNa7X/jxUwyMTaLQB7tu0SaTklP2HqwN
	K/89ahiB9WORqzaqyf10LzGO2E1KvO0G8FPnY8vtrngHMKWjCh8zoqG9
X-Gm-Gg: AYBFou0ZY+eOZUW3afEIdcV4OTeIRJ6T0EOoB/ICQhdavQK9+HabiQymhISkp6/jTcD
	Hg9GRQ8TZlgJkzy6fzrcQlf/CVPSu7GBeCuAW4e36R0eMhrHPkzLG5Pyw8gJ/7PMfhy9uJ/AWk5
	wAsY01FLopIqswirnkFl8bmLEvxfrkcKXVH37B45OZlaQQ1W7oGLApc2NOj5CxP2Ykvqee3DJyg
	+nEy5seOZsbhCNIWI8leVSXhPZNKGDgwMSvHO98vAIkDN4Wp3qf7azavVKShVMreUEEzhuhuBts
	Lse+wh0ucOwQy4h/HBI50tZzZivKvPunlvy6FgFH6T6op5/p18c4XNz8s/5vn9AUVoKB2RKNsz9
	QOtR3zPGi8KuAd/kwvJWxkh5VUDZrw7qBCxQAVZGzzLROhK/uVXQkc6aEEJV4webVsIPXEx+t2M
	PNlN+1Dnbum8e23VWcpGy1pDv0bdJjRaDKyuP96gSHtOFBMsKjqvxHgAZjgUZKorppM3WxXw==
X-Received: by 2002:a17:902:f68e:b0:2d9:2fc9:570f with SMTP id d9443c01a7336-2dd2a3502e9mr246863745ad.16.1789325955422;
        Sun, 13 Sep 2026 11:59:15 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b7bsm36808655ad.3.2026.09.13.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:59:14 -0700 (PDT)
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
Subject: [PATCH net-next v5 00/11] net: pcs: add basic support for RK3568 XPCS
Date: Mon, 14 Sep 2026 02:58:35 +0800
Message-ID: <20260913185849.907479-1-coiaprant@gmail.com>
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

Changes since v4:

Patch 1 (net: stmmac: move XPCS lifetime management to platform drivers)
- Corrected commit message: pcs_init/pcs_exit callbacks already exist in
  the baseline; this patch simplifies the dispatch, not introduces them
- Fixed description of the priv->hw->xpcs clobber: it happens on the
  plat->pcs_init branch, not the else branch
- Corrected the list of affected platform drivers: only Intel mGbE moves
  its XPCS creation; renesas-gbeth, rzn1 and socfpga only get the
  explicit NULL assignment in pcs_exit()
- Changed the "No xPCS found" message to a more generic "Failed to
  initialize PCS", since three of the four pcs_init() implementers do
  not create an XPCS
- Dropped the redundant NULL initializer in intel_mgbe_pcs_init()

Patch 3 (phy: rockchip: naneng-combphy)
- Added the TRM bit polarity (0 = GMAC0, 1 = GMAC1) and the hardware
  reset value (1) to the commit message

Patch 4 (dt-bindings: net: pcs: rockchip-rk3568)
- Renamed from rockchip-dwxpcs.yaml to rockchip,rk3568-xpcs.yaml
- Renamed pcs@ / pcs-mii@N to ethernet-pcs@ / ethernet-pcs-mii@N to match
  the sibling snps,dw-xpcs.yaml binding

Patch 5 (arm64: dts: rockchip: rk3568)
- Renamed clock nodes to clock-xpcs-gmac0 / clock-xpcs-gmac1 to match
  the preferred clock-<name> pattern in fixed-clock.yaml
- Aligned the labels (clk_gmac0_xpcs_mii / clk_gmac1_xpcs_mii) with
  clock-output-names

Patch 6 (net: pcs: xpcs: add ANRESTART support)
- Updated the comment in xpcs_config_aneg_c37_sgmii() to explain that
  although the DesignWare databook says AN restart is not needed for
  MAC side SGMII, some implementations (RK3568) require it
- Propagated the return value of xpcs_modify() so errors on the restart
  path are visible

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Added GENERIC_PHY and PM_GENERIC_DOMAINS dependencies to Kconfig
- Derived the EEE multiplier at runtime from clk_get_rate(), and call
  xpcs_config_eee_mult_fact() in xpcs_rk_create()
- Moved device_link_add() inside the device_lock() critical section to
  close the race window where the supplier could be unbound

Patch 8 (NEW)
- dt-bindings: net: rockchip-dwmac: document pcs-handle

Patch 9 (net: stmmac: dwmac-rk)
- Added a rk3568_set_to_rmii() callback that explicitly clears CON1 bit 7
- Updated the commit message: the clock enable reorder prepares for the
  SGMII path that skips rk_get_phy_intf_sel(), it does not fix a
  pre-existing SError
- Documented the in-band-only limitation of the SGMII support
- Kept supports_sgmii unconditional to match the existing RGMII/RMII
  handling; phy-mode is fixed by DT and does not change at runtime

Patch 10 (arm64: dts: rockchip: rk3568-photonicat)
- Reordered properties in &combphy2, &gmac0 and &xpcs to follow the
  file's convention (alphabetical, status last)
- Corrected the changelog to say the property is added to an already
  enabled combphy2

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
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 134 ++++-
 .../net/ethernet/stmicro/stmmac/dwmac-rzn1.c  |   7 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  39 +-
 drivers/net/pcs/Kconfig                       |  25 +
 drivers/net/pcs/Makefile                      |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 559 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  35 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 19 files changed, 1076 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

