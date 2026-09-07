Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218304BD0FB
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795518; cv=none; b=Mh4A7m3LJ2kxz1FuR9I8wJl4on9v363R1OfgPbAPtSi1oi2qprYKXbFlxYlEhN8nzMF9m6kqZDw9zv4hVEKgOzdBO+1Nyxjom4Wmk3gJFs98BNRPenhGP7glm7Iqwztu7ThoQHPsCBJcnnP+NOPQ3nia0ot2P9iLStYqyCWhW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795518; c=relaxed/simple;
	bh=1Ps4VafmU8Q1oglZMuvI2tEeUA1bHQsB9cffSURZ27Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VRhJVZhktaCYipEkvMn666KtXEu41DEwiVwymbs8dfxe76lteFtyLJkQ3/zR3QiqnVm2/lHIvPBzkhKrFsUB/YAJHZywqcirW08KTuymMXoDSDHK0En6qd7E7QqfBhMya5RXYRdKoKpY1FTn1PoHET4rNvP9zy/3ttOG/JRxErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUi150uX; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUi150uX"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d9181b7e1bso4325785ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795516; x=1789400316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hq1rNKVGmliGTWsiFEwtrdEOPueQghmo9INX52ut/jY=;
        b=ZUi150uXqPvsIDOAmEGOs3DnmVb/FPf+oqcW63+ZYyvYRYkh/UT5JyR+KQlSK2Ipz5
         FA4KARKO+D7/IsnUHNiG4q5fr8qIqEbzGA0SpgyYhP4yR9pmftXy+Zxg2oZ0/5dMLcs6
         nt3qe7mrTOs8ojvDfoD4ZeFrZK9GP1JOa0XUjMs6SnAgOePGvNyUuQix+ulA86xXZpWf
         Vf+vxnPxS01b5A/bgvtbEE5iXq72ZKFlJ0Id8br2VA9NwqSmGef4cbPIfh7F4ljztRlp
         z0nutIFuAgabz8EKZvLJd8WhXIdL0EC54NbZS5wY7VC4N3t31xmffMpPYD1Asqf1DRYJ
         /USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795516; x=1789400316;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hq1rNKVGmliGTWsiFEwtrdEOPueQghmo9INX52ut/jY=;
        b=Q1XTt+fGE5SlSdC4kHChOW4GlF0n2i0w1GkhVjdJ6egxjnd0CqLq0TCAowhIx3HHVC
         BLLd5bv/FlcMekGM5Kjq5rpKIBlL96IS4wiMp+ubyOtZWihQ0qYcfSsSeIYEdElIj7d9
         3fkDsNNpmQdvPvRlHfAuZp3cLWaqd8urS7PHbz1FjoSmZ+FDvQU89lEWPHRsvwbM/h6e
         QeQB4XNt4bP9Axm2QjUYelKXS8iLs0O84ZOeWHgR7xZarR8V5/cKwklyxdPMIuLgOaaN
         VrLJcr1Ngz/fAfJOc9trPIpeM8tQ8X1ThAB7h2Mf8eJ5mUhthrcI0HzgWfbuuGiZX2yW
         zrkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxQLlSolOZgfTWqX8EhWVeR9l6bbEqMrMCt111CW0nKI4cyPv/AEAJOuRmnIBBHEGRkVEh+mw=@vger.kernel.org
X-Gm-Message-State: AFuF++nnU1KmhVz0rUE7Y/NZ1bPJ9b9IIf4S72IKwy4lM7P6snH6jZ39
	ovfteIwoCipntGwXVSS9B7cy4qC5Hy6oJPnR/BodvlfQyygMpouvA5cr
X-Gm-Gg: AYBFou1ykFxU8zb3sLxdWZ2CGjBf1RBEde48AmY6kNs+Tb54qpVoEuofmEVm0jrMUw8
	K2BCG3ZVg/HlOSUrVEyKYYAowQVMELyh3zaNJhTr81fZGG06vf8HmQUkONPpTOfqzqc+ueC9Eo0
	KfBuwaovWyiLT3szlrcHcP9eLVf3wHyoXkDpmwChUyGq8LNCpgyI6pWQS/tZWU2M2CDFKTooEUK
	KUY6HreuB9+qBgwxK14bYaAtT1Gw+Ryme4mHI6slA2bD2tp7q7B/AgQzJoeRWCg1UAK1Lh1pLL+
	paICmPT5VbtQ9JPI266QtBcaK2Cs8qrljHvifXvy5Zv0eligCHt+tRQpplWD2U/QEQfajidZWK+
	YiZImBlTRR9Iw04+zXOPP5prG6+GLXPezmqwqUmE1YJZZBRHitK8/1AeE70Q/o/sbaOnKPORdo4
	DV2oyxQXR1rLXq74qRH14AubuUv7BLn+Gb7Ph2wlqflgsIDSO3vKG7nzHUlH8=
X-Received: by 2002:a17:90b:5110:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39b8bd4aef3mr1404027a91.7.1788795516238;
        Mon, 07 Sep 2026 08:38:36 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm21690121a91.9.2026.09.07.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:38:35 -0700 (PDT)
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
Subject: [PATCH net-next v4 00/10] net: pcs: add basic support for RK3568 XPCS
Date: Mon,  7 Sep 2026 23:37:03 +0800
Message-ID: <20260907153713.2572547-2-coiaprant@gmail.com>
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

Changes since v3:

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Reverted Makefile change to keep pcs_xpcs as a composite module
- Switched from manual `devm_pm_runtime_enable()` to `pm_runtime_enable()`
  and use `pm_runtime_force_suspend()` in `xpcs_rk_exit_clk()`
- Removed `xpcs_rk_remove()` callback entirely; cleanup is now fully
  managed by devres via `xpcs_rk_exit_clk()`.

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
 drivers/net/pcs/Makefile                      |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 543 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  16 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 18 files changed, 1015 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

