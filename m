Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246C35C692
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923727; cv=none; b=t+rGejlbnNx7Qztt10etzF79MyO5en2f/FGrK6hIc4mR0VdBhxDScdBLDVnnyQ66Ta7BOZTsKuJe5gBPOTTuzWvZIWpfyeK2mHfjHsXByly/5MIbby6ONlehXzth5WL3/s2auSJiX5IRB3rCoQAMg47qM0BKTjFmPJpJOK3nWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923727; c=relaxed/simple;
	bh=Hwepoi05XJzQFBKNDY51EwqDHlxM4/AUrIMff0K76dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fo/kXtipLa5zgbafXGPBKlVUhZG4hYTw78Pk7vKXFwOgYhn15PuenG9Y0twMGcXrnwtI0vAjIctKlxbarWSmGAk6RjiHTz5PDQpKlHa6u2zOYnrqKuNd2dLQD939CK76Cq1c+DFmPqobGkBLZQh1L12CBBATzhUrrSf7FzHSSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWAVyjHX; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWAVyjHX"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca7fcfe1669so1274012a12.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923725; x=1790528525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvaA1R/5NGHCUWO468vfak0l7lZ8RN7fNc21wJSy80Q=;
        b=OWAVyjHXPPoY3UHl3BAQlrx7WdEgqOWxnEH5aZY182QRubRSHsON9WUSC+xQ3SIS9F
         qWub6wqGXXNDD8slRWmhSbRek2l3T3dhhMhBiVMOSq9iXijw0gzdBMyIPLJuq8I7+bN6
         uAZHHlo+DY5BhfHS8UoHEzb/t2k00GKxL1gGwnRlbGSSz1JiMJzGq0/KTMwYtzuDaMjJ
         9fNaMcMg8V908V3Jt/ySgtmpt+Y/sq6ClsyhAAIdnKU7eHClBCyNoazePXF67C46hqDo
         Ko5OYP8xYWVpbDFvy44d2sJcqvq4O6aeQmTY7iaNtq3QVRACw2WdcWHCljBpJHmQ/U8I
         LMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923725; x=1790528525;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zvaA1R/5NGHCUWO468vfak0l7lZ8RN7fNc21wJSy80Q=;
        b=DN6Ac+NeL5KnDLO8vSQSibFUYVDiOWaGa0a2os1+6XNsNWQbqKRL2a5ycdk3pPL+8X
         D2oUTkK6mcwsl4VFgkkDqN6244QYqCBXGK3pB44tONZTlAHBgImWAY8Eoqc9CXPR/GIX
         3WGv/nEfa3y0vg0wneYNX+Q62SMwAemUIMC5kNJMZsosUAc0snw+hD6hZWavM4pnkqKl
         u3bCMRYGYp81XZiBeqe3OTK4PNrg9TZtJ4YDaUS0jTBiClMt3MbAcg5ruG6mX9V632Xh
         9F7AC0yS02trFRlpGh8Q/YTh4nPV3gfFUEj8iuvfNEa6ZRW08DdU0xQep4Umg8YDIPCO
         b1Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxM7fkwu4QkM9eXpMURC3Vu7JHbI8BCa5FSXoCqvJya+ubxCN6hVQVZDZfPwtYCa6AegC4n7Hs=@vger.kernel.org
X-Gm-Message-State: AFuF++kGsryza8onvVjipb7kqf5kty6VPl0Jqo7OxSH2JZ1TSyB11kjD
	PNvwbHE4Z1q7Q9uwMIWjM3Lq3g68tonkVZWR1eNWZ/5kNJB52OWDtiCh
X-Gm-Gg: AYBFou0w0/KS+Z7+fSQl1HxqtanNrmp5751SjgA0a13Dg8ixmuHYYUvxKE+3aqOOi/d
	Fq2xQ0lcjaO2/oFHQSRqXauOW0MhIsXwz/l0optt6IpaltwZLpUMw/VaKZXdS0zB2RcVMMoPg+r
	KLvF4ENDmV/Bza/cq/Z+meL47sFoAlYLgmaThlAqUjnoE7cV/f25/VmwdPnhx8Xc9H8XZO/ajF2
	97XwFU+WhK6HH/AHOaAPeS2DALlcKnB+EuQGhQj/GY73NEKCxHFnTOkyvQRAZcYde9gHrCGHfOt
	gw7/KuVpURFACbEjxb8TYJtk9DkVFGjxBbIkWS3bMPaSvq2bhx5q2LO3B+qjmFGwxDwXHngEH+S
	bfmePryZBLW7ddlXt5szx4eGkW69iPknshyoxr3CeBsNbtfG9Tt9HlJuDsoLN2rHizZ83q/lFyk
	Yp2JIulvPxBcuk+yi1sDYjOUkb3o6cL4GTgN1VgSh+UPnPcKPVz7IN6tRX9vkfn2Rgh6OK5w==
X-Received: by 2002:a05:6a00:3a18:b0:871:41fa:d1c9 with SMTP id d2e1a72fcca58-874ddffca64mr11441916b3a.25.1789923725129;
        Sun, 20 Sep 2026 10:02:05 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm2140646b3a.42.2026.09.20.10.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:02:03 -0700 (PDT)
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
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v9 00/11] net: pcs: add basic support for RK3568 XPCS
Date: Mon, 21 Sep 2026 01:01:04 +0800
Message-ID: <20260920170116.3624104-1-coiaprant@gmail.com>
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

Changes since v8:

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Replace the device_lock()/device_is_bound() check in xpcs_rk_create()
  with a check on link->supplier->links.status. device_is_bound() only
  tests whether the supplier's driver pointer is set, and that pointer
  is cleared at the very end of the unbind path, after devres has
  already freed the drvdata. Checking the device link's supplier state
  instead tells us whether the link actually pins the supplier: if the
  supplier was DL_DEV_DRIVER_BOUND when the link was created, the link
  is in DL_STATE_CONSUMER_PROBE and unbind waits for this probe; any
  other state means the supplier is not usable and we defer.
- Drop the device_lock()/device_unlock() pair, which is no longer
  needed since the link state itself carries the protection.
- Update the comment above device_link_add() to describe the new
  reasoning.

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
 .../bindings/net/rockchip-dwmac.yaml          |  18 +
 .../phy/phy-rockchip-naneng-combphy.yaml      |  13 +
 MAINTAINERS                                   |   9 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   |  74 ++-
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  45 ++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  44 +-
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |   7 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 130 +++-
 .../net/ethernet/stmicro/stmmac/dwmac-rzn1.c  |   7 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  39 +-
 drivers/net/pcs/Kconfig                       |  25 +
 drivers/net/pcs/Makefile                      |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 599 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  35 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 19 files changed, 1115 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

