Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F5356773
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594202; cv=none; b=ubOChIH6hiZO0P7LJSLePMG6I1pvDnAhVFVj5fisRFggNx5YiYXU+XG/wwZRZflb08nKQIzZYauWiAYdMTZgfkza0YEFeD1vChgPY6qv9PO/Br0K7hUWjgUKhghYsuWvukSht1EU5sMDFlXG8byE0Lg2ck3P200lplEKTfGrMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594202; c=relaxed/simple;
	bh=yfzH03Zpfn3qqQcJ//TofgsfNJygcYN7t4VAVJQKlMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lPdtp/ilxomdaPgFB5pUpuo73HpyR69Zk7oIN8dNwb06hKOIxupeHoJWunfMgWG7n3oJManYlaugoyFpQ2gFXo9TwgA+9fxZtP5n3Kz7sdYVOONeNgaJDgcJzaGIne186iVr1OtBMaIjmn6Gu64d0+dZcTyuwKkSaO73l7JdQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLXAkM3F; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLXAkM3F"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc6bb7476dso2655325ad.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785594194; x=1786198994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2cmtp3VyguNZ1YwnWT1LsNqPKC7k3AOpkhFk6RHh98=;
        b=BLXAkM3FkCQ2cUT+gAe2TOBcgziSYRBWtxrGKtI+Xv8282cPyqyNBNwZwCjN0Qnr/b
         5VUIJ8eCDWegqsNS+it63zv1kD4Ym5XnRQsyKkA4fkiCrx3a6qskyfEGAQ5y6GkSMENW
         sOO1JwXhmBlf8XGHhUn1YP7kwzGljG0CJrZeqs/vx2jaM5PQTvuLfPyvCpNtpjb+/15Z
         M4glmO5pTWvGIsSu/HT+vIrPYBYGBRrtjOZBEP5qfPliqn9iB4Jt4IyN4KY6FlkjrySF
         Q6NG9oV6SnmjVZ0oLUhe7XMv2GosjdAoP0Qn/jl95wvLBV5yDUQjBZ8CLvxZfTYIzi9o
         RE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785594194; x=1786198994;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2cmtp3VyguNZ1YwnWT1LsNqPKC7k3AOpkhFk6RHh98=;
        b=VyWCDBom8194t2Lo4+FThmOka0nRBNJN5fCFoo3DKfpecz0r+Lxab6HgCIGDBHxqFl
         KAjB6NbCbvOVrK464QIlODLWlV6zLKhTj0dmfDnu9/9CUWgWuDN6NMvsC2jmrW5azNZ3
         TOAduxkbBV8HiIS8+j4RsAcOii7zqiKhSwMaZ1XZI9J6QJKFi6kHqW1no5KHsOG+79xj
         dmLUB/oMdzuOCd8ESrM0bTHoiR+K3xd59+S6wAEeUaglJ1KIu5luPt5wmVJyWYT+wEBy
         7GdkgflTtwm/56VirfPxBNR83/qXEzYe/s8VY5goojWAsAbk7vTXje4PHe2SdrKpjeFq
         H2dQ==
X-Forwarded-Encrypted: i=1; AHgh+RquSJwILcX53t7QGlAkSG1EUSifhhBxa+AsRnO98jtuS9tYfBeOqPoWKih7xWiptEVxVK2LA8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOn7dzfxd0hs5POuDr+WcHsRMvTD7nqdtoA0+Zj5zjdZ+0j5w
	SKLuuegeKsG0qhaN4ZCC3H1gaRG4tcwWeJ91ee4biJerTe3uhVu2vCcT
X-Gm-Gg: AR+sD10G2QZkz6MFIyd7EJAgSWDLttDD7RmKWMEcr0ZI914VAPGBVcDk6ckWTeBT1fA
	rp4cUwGJxR1aUCpk/OENG5sCdDQMahDWF/rlu0T41/yQLya7Y/JcoftgWdRSEAiVcTv2bbwuynm
	ouhzv4b3U036CrqsM0rbvJJPJHB+BJgKEH9A34cuuHbIz0WeXpAEXOBC8OKOfIxuOjmvyUoNiS5
	Gy88oviD+yr2BUR5pPVbDRRaJhj+8r6P1thtOm9uogyXHRTDyoDueKtee6IfVYwVG06lF/pfrBG
	z5bLVm45BZj9MbndlPy5e9WGGq8DJFoetRwtWvr/T819tc44vjccBryaHCq6FWbvliQLinGHXG9
	cFs0DQK3qtPDTpEoMN7Ecj4ojfsGuy61neEL3S6sc6mMww9ZPLl1XGki/0LmmdSj3VBTyVaqt29
	XDl+eH9uKu1MMl8labLPwqvapV9B9OSDQ6z6GqfOzPaDosauXyX09iQYU=
X-Received: by 2002:a17:903:3905:b0:2cc:80d6:b72 with SMTP id d9443c01a7336-2d0536caf12mr31901555ad.20.1785594193454;
        Sat, 01 Aug 2026 07:23:13 -0700 (PDT)
Received: from server.lan ([103.213.4.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5ac3dsm18043845ad.23.2026.08.01.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 07:23:11 -0700 (PDT)
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
Subject: [PATCH v2 00/10] net-next: add basic support for RK3568 XPCS
Date: Sat,  1 Aug 2026 22:22:24 +0800
Message-ID: <20260801142244.679437-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v1:

Patch 2 (dt-bindings: phy: naneng-combphy)
- Changed `rockchip,sgmii-mac-sel` default from 0 to 1 to match
  hardware reset value (GMAC1)
- Added `if-then` conditional in `allOf` to restrict the property
  to `rockchip,rk3568-naneng-combphy` only
- Updated commit message to reflect hardware default

Patch 3 (phy: rockchip: naneng-combphy)
- Changed `priv->sgmii_mac_sel` initial value from 0 to 1 to match
  hardware default
- Updated commit message to align with binding changes

Patch 4 (dt-bindings: net: pcs: rockchip-dwxpcs)
- Fixed `reg` format in example to pass `dt_binding_check`
- Added missing `#include <dt-bindings/phy/phy.h>` in example

Patch 5 (arm64: dts: rockchip: rk3568)
- Clarified commit message: "all nodes disabled" refers to XPCS
  device nodes, not fixed-clock nodes
- Noted that `assigned-clock-parents` are applied at board level
  (Patch 9), not in SoC dtsi

Patch 6 (net: pcs: xpcs: add ANRESTART support for SGMII link recovery)
- Split the original RFC patch into two: the SGMII state reading fix was
  sent separately to the net tree and has been merged. This patch now
  only adds the ANRESTART functionality as a new feature for net-next.
- Removed unintentional `BMCR_ANRESTART` change in c37_1000basex
  (this was not tested and should not have been included)
- Kept SGMII path changes for RK3568 only

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Added `.remove` callback with `pm_runtime_force_suspend()` to fix
  potential CSR clock leak on device removal
- Added compatible string validation in `xpcs_rk_create()` before
  dereferencing drvdata (using `of_match_node(xpcs_rk_of_ids, pcs_np)`)
- Removed `__maybe_unused` from PM runtime callbacks
- Add `depends on PM` in Kconfig to ensure `CONFIG_PM` is enabled for 
  this driver

Patch 8 (net: stmmac: dwmac-rk)
- Moved `gmac_clk_enable()` call before SGMII check to ensure clocks are
  enabled before register access in SGMII mode
- Added unified error handling (`clk_disable` label) for all failure paths
- Added error handling for default (unhandled interface) case

===

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
- Fixing the XPCS driver's SGMII AN state handling
- Refactoring stmmac PCS lifetime management to allow platform drivers
  full control over PCS creation/destruction
- Adding a Rockchip XPCS platform glue driver and wiring it up in
  dwmac-rk

Series overview
===============

Generic:
  Patch 1: move XPCS lifetime management to platform drivers
           (introduces pcs_init/pcs_exit callbacks)

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
None. All patches apply cleanly on top of torvalds master tree (v7.2).

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
  dt-bindings: net: pcs: add rockchip,rk3568-xpcs binding
  arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
  net: pcs: xpcs: add ANRESTART support for SGMII link recovery
  net: pcs: xpcs: add Rockchip RK3568 platform glue driver
  net: stmmac: dwmac-rk: add SGMII support for RK3568
  arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
  MAINTAINERS: add entry for Rockchip XPCS driver

 .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 127 +++++
 .../phy/phy-rockchip-naneng-combphy.yaml      |  13 +
 MAINTAINERS                                   |   9 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   |  77 ++-
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
 drivers/net/pcs/pcs-xpcs-rk.c                 | 538 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  17 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 18 files changed, 1030 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

