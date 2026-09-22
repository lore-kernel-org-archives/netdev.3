Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D94B1262
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107442; cv=none; b=cYv14RpploPDPc018TwAbZoIQBpTMltIew3Cp8gM0mopQVPLNsHMQxrrysTrAOua/Mddwl7k1tGLmskprJDjgvgzRJp+tNKvuBRhqDKZ01K0XUF8jMhEfguN+CNtu8V+IVKTxk0scxXr5a6wIezu9NtCBXsjDbL4P7UjItLXe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107442; c=relaxed/simple;
	bh=U+Ef+njUhKSDrdsVjIV/jZGXnWIx3qurrLz00hATNN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LSJVA9X2jU3qTkUU012lc1FB5zyChE3AwOEELtGHqJkXDoTy/9yJtXoeKvBSsPX61UqO162Ge+ZexaRNMOcXdENzuPUkn5D4MYZE+ikMPBzF0zkzmpoZubdfEIHZtd6blF/dosxQzqFI5mZx+AxDPc/9/RlXS75H7ztB/0fCnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNOR05T8; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNOR05T8"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso497725ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107428; x=1790712228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLf44y0wjXekRKRabcqObNjHMHH8+Vthi1ry2XuMnz0=;
        b=lNOR05T8az3xETlzdh1sV+1XBAIwmnE0hhuXGdy47J1hjpX8TJwxTabCtQSgnvDhhR
         QT1yc6QaYV46Bqgzb6tS6vXrFzt3Qugokk0Om7EvmihwV7zWixML9bZmYtkaugGoWL6M
         sZ3oYmH/w/aSVsnyuG7XtbSWY+rqMMtCSNDIeKsUC3YSIBtSsF9su2qDTEQvO9dP8WNn
         OKeNoJyj7FMS+qoJsJJ7MaJqG2GtbXgIa4VOhrcF8+pEFAwtfnkLOxeUl3ypQIT2GgaI
         kWu8FDu9C/SmRXJr87H1XNApHRFZ3IXUgcjq3GGWYlUyXCQcVrfUGZ1JXQWySRvaIRku
         075Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107428; x=1790712228;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tLf44y0wjXekRKRabcqObNjHMHH8+Vthi1ry2XuMnz0=;
        b=kRSKukUwCdy7Wgx5xcxu35fybPpKjY1Nvo/Wm1BJnPMuP7K1ltdmQIz3LHtc0MkMCQ
         UexIaThSUuR8SaDcfswdnbRrKPrE5R4KS1nea6/fSmQrsm9v1CTt3RUbOIkepmXe5p+d
         nviNZf35fnwKNgmuSA8TAa4Da9oRzcAGeJdB9fzMIf2Lh7AClC3kidL1In0Rog6mdgff
         M1QkY6/pPfQmZ3JmZ2ezUf70OyhNgm7qY3sdwEwcoD7mvWGSeuGySgiRdMvOqHg+TXy/
         ur8AFOYamHCmB5yQ674Mc19hJHFyoKUavEWhe+yoEzWXZEvVOpwwTQSd0pwB/U+onLoC
         6wsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQ9d/CjpSiPWLnK6a8taqsQKR0Xw5p/uevv964w77dHin1bS2Av7cPv518nF/54e4wsgTmQsY=@vger.kernel.org
X-Gm-Message-State: AFuF++n1QndrHxa5+3vRfsHcdoBeBZcW2A4DbSsGV95RJ7bo200Q4QHT
	FZ8Yfs3jhBwohCCWRAsCrAxDNGDXY2Hh3cLPpdYJR2XLlyKwwp3rPL81
X-Gm-Gg: AYBFou1NkzFOlRkmBtVdrQrSKDRcoX/1fMqjpxiyLfgxVP5E9e9/gWoDaOI7gSrKJyN
	u/F6FZcASdzjcYN23dP8YXSJZlgidQHkCPXRjCzfR42H3toSi79Dt4fHrqT6D6qcFuKZ5BUDP4s
	x2xVXusre1mZrJkPdAJYbFWgY4lQpEMEsIByOKScGJPEXTnFbGIKw9AaaJMZakChq2OtHe78jPV
	JmFwzxPkyopkobTrVYfOMVpphVHYQfWfFo0V5LLNtgzrQNeXdaO0xi8zxmLvl0sjroxUmHGA95P
	I+KADXQbmO0R0t2TVjCXiQQ8v5AwjvRmIshAUwVeXAxT5KTddU8HbwlcsVTSta0q3R0pzEhBAyb
	gMBVh22l1IfI78E0jPFkppeg9v9ouiZVqJXTJHGyWGg6zNOAv7fy7Hvqw9EOpucxunFtoNr2Pqe
	bNaIpfTVmlpGaiX/MeCs3UU2etQULzlSvdWJMAaHUxChJA6bb/B8yXZVoCyfk9sImrot12p7a5U
	yZZ1mdqq+M1xQQ+IA==
X-Received: by 2002:a17:902:fc4c:b0:2dd:c053:e0f7 with SMTP id d9443c01a7336-2df69ddf21cmr4274665ad.38.1790107427896;
        Tue, 22 Sep 2026 13:03:47 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:03:47 -0700 (PDT)
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
Subject: [PATCH net-next v10 00/11] net: pcs: add basic support for RK3568 XPCS
Date: Wed, 23 Sep 2026 04:03:24 +0800
Message-ID: <20260922200336.2201212-1-coiaprant@gmail.com>
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

Changes since v9:

Patch 5 (arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes)
- Move the two fixed-clock nodes (clk_gmac0_xpcs_mii and
  clk_gmac1_xpcs_mii) from between the XPCS node and pipe_phy_grf0 to
  the top of the root node, alongside the other non-reg nodes, and
  sort them alphabetically. This addresses a DT coding style violation
  reported by the Sashiko AI review. No functional change.

Patch 7 (net: pcs: xpcs: add Rockchip RK3568 platform glue driver)
- Add system suspend/resume callbacks and switch from
  DEFINE_RUNTIME_DEV_PM_OPS to _DEFINE_DEV_PM_OPS so that system
  suspend and runtime suspend can use different callbacks.
- Mark the XPCS as part of the wakeup path in system suspend via
  device_set_wakeup_path(). PD_PIPE is shared with SATA and PCIe;
  without this, genpd would power the domain down once every consumer
  is suspended, killing the SerDes and breaking MAC WoL. Runtime PM
  behaviour is unchanged: the runtime callbacks only gate the CSR
  clock, and dev_pm_genpd_rpm_always_on() already keeps PD_PIPE on at
  runtime.
- Clarify the comment above the power domain access: the XPCS lives in
  PD_PIPE, and the domain must be powered before any register access.

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
 drivers/net/pcs/pcs-xpcs-rk.c                 | 619 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  35 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 19 files changed, 1135 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

