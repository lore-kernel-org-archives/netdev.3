Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674063845D3
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822308; cv=none; b=Fr9gPOlxmOGCjc+F0rU0exAzs3U7pDGA9hLL4OpaEJLtj9QDEegVOgk5QyK3iZ26q1T++LBb48jkbWajIx6juTg0ULEVZLA4P4PcMLLC2ckmxOFvGkSgSyso1T7EcAinyh/hFI7Bjv5Kubrm6td4603WOPFJgewcp2Prxw70hXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822308; c=relaxed/simple;
	bh=NIJkPdrb34c+GXUZql5gIGKgt46vdTtKGO6ZMghyykQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omGzZ6XKovmoL3ZeHt0t1SY92DZYLOBjE2uFECCv6gbzMnEtODV6gATMwSWWSv7g3mEFHhG2iey+u8+KGp6piSLQk9cWp6Oy9Hdzd6P5n6aR8WdNY2CDvqE165CNkMzr2YWMZnuvZWN7qRRb2ax+teR2HbYpjv59v4sl7I5Mw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI/zaacI; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI/zaacI"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e37c430bbso686508a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789822306; x=1790427106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeS5LqLOuIKT4KDWIZgKWwOtuHWnT7hUVImYY975124=;
        b=bI/zaacIqyY3JPP921Jr3f3kTHtIMpjWqDZafaaZ+/btLyXs/qCh4VdYj7PLblAhFX
         wNugegYlPFRZxNQXqnX1Uu92pAo9HRCod4uesoaJa5uTOMkSrUftkoqMd1TYvMsBn52L
         SviSRHlNij0c73Uvnl2e1gzDVbSdMR0o1DnYAN5wLZTQ8ij1nrWoMC/PkCRFNw2BvtOL
         XVqHnBlN5W5Fq3AKY2mbThGOP+FSJ7A2MzQFs8C/cYPH/kFbkmn5IKIWlemeDPvelRH+
         +ql7QgssUoNFtekVLASq9ycb6fVimZl9uFu9ydryibyqwgOh2p9/MLwLdAFczuAMEpOs
         bEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789822306; x=1790427106;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WeS5LqLOuIKT4KDWIZgKWwOtuHWnT7hUVImYY975124=;
        b=beDq53Sj5mOql+V/zKnTh3HyBN9O/cvIwyKm3bZYR265YWwAQzoo/MHJg6gMltS+5A
         vgLGmyB0D0vW0wC5ACayPVJbbpaimbZQqHLdRlvAnvKpg+xJsnLWLe4CLjNOia/jjohd
         //f4PRdItD0cs53nAJChpAaBbabxK4H5laWkFlHmNaEScFw1s341jtLiYnIy9JmlIo5O
         B/BAjmkqGP0n/443PqyVdeZQK7EzoJy0wLt9R1VajTGW7YDtbCHJ9K4kL3PBWMPoNEEy
         t7cGSduUtWlRf5yby835t0ZJBgTQ6zRGRGuv3i5l8NcnxscK8h65vCYXyafH+6uU7UiC
         iiLw==
X-Forwarded-Encrypted: i=1; AKwUvBzF9IfNbH6WiRq6h/wzrZxUYzULRrC+jqsqNnDjG5NZmchYE5Mbu1TBpc1XXrwe8L16lgXApG4=@vger.kernel.org
X-Gm-Message-State: AFuF++lFM+RLL3Jg8oahhThkPvdmVcSb7fhN1P+AykUQBr1AUCwyNkLf
	ZS+6q7VlCpnMSZEYUxqAQ3J7a9XfE2/Xv3XOKis+CzHcwn6vVySLPEAB
X-Gm-Gg: AYBFou3kOh4cmzmQzzfui8rJjP0Zekreuft+nNGViaccBWz+ZlghVGdfei7/RIMI8HW
	XJQgOTnUXomJ4/Az7yUzXdqGWWblDqEmnLzaFtWJe07QJFUvz38+CPlgUnsfgKLvs3WeJwd/YUb
	vOIzh8o0oxnQnKvm+j4hDkl1GNUsA99c29N/K+tshYYbaXtx5fy+/9GB4OlrEW0AHyEvOcOcBlj
	JvIKm641MDJpUiCPq2P1EDp3MZlThH2TbN4F2S6uE582Ax4U9RIzuK+QClPjXd+HjP4m6EMCrUn
	2W0ACcDWMDkhb/qAgZXmEFaUjrPhaH0IMah9ud29B1AyL2w9GvOaaHHuk8LBA8Xope6uY+bDEpL
	/PVk8sxLxkqh/E3rcXPOeB5IL432QvmiyMojQpKQH2eIUt+owGN/4GTq5sLky4eYKxgE7C4+/Ft
	waRv4DkuYmhBFsY0LUjBC9b0zDou0s6Nyn+RjLx1XZ2G//DNZT2za1eoRsbmNfC1slltbrbA==
X-Received: by 2002:a05:6a00:4309:b0:874:708d:b636 with SMTP id d2e1a72fcca58-874df60bf54mr9495073b3a.34.1789822305666;
        Sat, 19 Sep 2026 05:51:45 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa0026b2sm991805b3a.44.2026.09.19.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:51:44 -0700 (PDT)
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
Subject: [PATCH net-next v8 00/11] net: pcs: add basic support for RK3568 XPCS
Date: Sat, 19 Sep 2026 20:51:07 +0800
Message-ID: <20260919125119.2107089-1-coiaprant@gmail.com>
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

Changes since v7:

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Fix a use-after-free window in xpcs_rk_create(): device_link_add()
  does not fail on a supplier that is unbinding (it creates the link in
  DL_STATE_SUPPLIER_UNBIND), so the drvdata could be freed between the
  link creation and the platform_get_drvdata() call. Read the drvdata
  under the supplier's device_lock with a device_is_bound() check, so
  a concurrent unbind is detected and the probe defers.
- Correct the comment above device_link_add(): the link does not keep
  the supplier alive by itself; device_lock() plus device_is_bound() is
  what protects the drvdata read.
- Change the Kconfig select to "select PM_GENERIC_DOMAINS if PM" so a
  COMPILE_TEST build with CONFIG_PM=n does not force PM_GENERIC_DOMAINS
  on against its own dependency.

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

