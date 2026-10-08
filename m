Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5D3B3C0F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481975; cv=none; b=mwVEfBba2TNoX7ZndvoQ5xA6QX2Lq/zL6LyUiM23NX4zf/ZxCOb8QUjWN8aLvlD16hSCqR+9M6SFgxOMonHVw0FTYEEDrfKLUdRf4UjX8nEbmUsAJPkQbjOBTu8HBtxwKlY1buKdapRAEJOpi7nQP/hWLkxNnM0p53Y29ASHybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481975; c=relaxed/simple;
	bh=prJ7nICdPY2rXNL3i/aciFMCMxkYdjelmYxtge20GFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eNn/FcehYNAMcUVQdooDekOxM+xERYas5dZ2efLqMvFlsGB4LXBZRJRK1I9jqYX2lN9h2SigNaDt4C3QxpIxfIfAiVIrlpvVTqY4YGAR4fzrrBDYLoHaRldFIMmvmJQaHwBHPNfjMXVIMzfyr+KunZQcOgmD+wtXQG+8Ov6mmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQUk8/Zo; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQUk8/Zo"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3a7026b3123so929394a91.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791481973; x=1792086773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BwFMzvpnh5keZRavPMezlpByqLkrvmuKFAvrVdTgl0=;
        b=FQUk8/ZoC9+Z/mevJiI1tlQXfhzUHTKYzrPjC95Jj+LBNLSmeA254fYpeDZkbZf5Nm
         CuHWtYR3imVERY23bmB3N4pIMWOT00o3xigNFRByeTMFLbkBALPbf/eHuNzlpBDLHoeN
         2sveRS006wQHMhZ7l74WHGS1oYvnInpevcAe09M1L4sqSszDXGEasZqFnrpp23LrpoyM
         LRSXmUphgZQ4nHifh6am9JOIi0w6GDzJX7XYw8PYSWfswU7+siK6+P/OS5/iwGskoVFx
         exb73RdCza1ZfrqnuJqaWYrl/mXMznf0P8ajAMaVMP51vQjv+iLOTsh1MgxalL8yIQNN
         dBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481973; x=1792086773;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9BwFMzvpnh5keZRavPMezlpByqLkrvmuKFAvrVdTgl0=;
        b=dhZenMQo88+jIQmMtTIEqECLLDa9CEjFS88X339RymbA0WAfVrU6SFsPUxUlfeXSZf
         rqGktnr9H//JzvqzoyO6meNrEt34f8TzxfAHInCBcaEBrSBatpe0viT4Yhz4VjXONjD4
         KOD3NcKwe9pBbZBkdFGq/aJQx4RV7jJEQXwoH+nm3DP6cq4tQxcgNwIcEo6H4UMh9X71
         +8RmSmjMp2ChGfY27HC0FbVsiBOc85hATxrqkiy55sXT7mF1MUM9Qp3tzLnISZyTGW6J
         uBgzLm0gM3f9wjXiGDCSFzdPytGnCusYBcUTJWEZlHy8HLXAwTOAbv90c48TFwe0KFRN
         7geQ==
X-Forwarded-Encrypted: i=1; AKwUvBw67fPSKyq747/z5ZxnWg8IXHG8M8FcK2/zBu4suGf7jPOyi3vWiAP8Lg7NWtWiNaeLDrF0oYo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKo548nyRcaj0Cf2xvwu6YnRDRSA6iDwd1UXa1mp2HHCwiWdqLb
	znFqf/e56M0Cpstam8zBMbjzHyuuM9a0AqG8akTqSqYMbXlfzH/H4qx5
X-Gm-Gg: AYBFou2Z5Os31u5I4Rmr5MuBVRf8CkYVnLlJk3ASwifBdeO6F18OdoNt66rlCsRMFqW
	/eV4Cuf+f2vW+eY3UbuhfoSndD0x99IVVOB69X4O7pFOrORg7Yw54FEOzraARjWe3FMm/HpmQ8a
	BDKeuG5ZxZx7GbkvU1BojB+vp0ZaUfclY3+8+ShMCgGMn8qBvGMS9dTXx52OxdHOB6VeI/9f7Pm
	InRWRIrnv+868Czh3tClj+Qz2Ns28aH9VH8XEACsMdauF+LdnoCKJyHZNtc47NORC2UI+jq3ozl
	SV3stMJeCRw6wx+o/0kF7V+x17wsgH2gjP5tEEI24ilbIB38TPJmlkQ5EARCsuF2s/h2zo/IK39
	u8yN7HBhwEKAwLwNgUoERupWae9a5b6ps02w2UiEf5nJirFsHOHG5QZOD3UTYmxXMHvPZGSKEiX
	VDit1ZYgRmPiZHID+F/wtdDMkzYu5rAhAOnlsg05fkOYhlYnM3FsMcuuaipJZ3/1oV1ETd
X-Received: by 2002:a17:90b:288c:b0:3a6:fec5:c186 with SMTP id 98e67ed59e1d1-3a8a0f3be3emr5184679a91.46.1791481968566;
        Thu, 08 Oct 2026 10:52:48 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3277c459sm144332a91.16.2026.10.08.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:52:48 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v11 0/6] net: pcs: add basic support for RK3568 XPCS
Date: Fri,  9 Oct 2026 01:51:54 +0800
Message-ID: <20261008175225.3375274-1-coiaprant@gmail.com>
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
  Patch 1: add ANRESTART support for SGMII link recovery
  Patch 2: DT binding for Rockchip RK3568 XPCS
  Patch 3: implement the Rockchip XPCS platform glue driver
  Patch 4: DT binding for Rockchip DWMAC PCS
  Patch 5: wire up SGMII support in dwmac-rk
  Patch 6: update MAINTAINERS

Dependencies
============
- Generic PM domain (genpd) changes:
  https://lore.kernel.org/all/20260925041751.495818-1-coiaprant@gmail.com/
- PHY binding+driver (Naneng Combo PHY SGMII MAC selection):
  https://lore.kernel.org/all/20261006162807.2843858-1-coiaprant@gmail.com/
- stmmac XPCS lifetime management fix:
  https://lore.kernel.org/all/20261005221749.1104430-1-coiaprant@gmail.com/

The DTS changes using the PHY property are sent separately to
Heiko/linux-rockchip. There is no hard build dependency; the pieces
can converge during the merge window.

Changelog
=========

Changes since v10:

- XPCS binding: drop the ethernet-pcs-mii child nodes and the phy-names
  property. The MII port used by SGMII is derived from the MAC it is
  routed to (GMAC0 -> port 0, GMAC1 -> port 1), so the ports do not need
  to be described.

- dwmac binding: require phy-mode for rockchip,rk3568-gmac, and require
  pcs-handle only when phy-mode is "sgmii". Without the explicit
  required: [ phy-mode ], the "if" would match even when phy-mode is
  absent (Rob).

- XPCS glue driver: use pdev->dev.links.status instead of
  link->supplier->links.status, and drop the unused reg argument from
  the read remapping helper.

- dwmac-rk: document that the MII port passed to xpcs_rk_create() is the
  GMAC id, matching the hardware routing. Rewrite the in-band vs
  out-of-band section of the commit message to match the driver
  behavior and the actual clock rates.

- DTS: drop the ethernet-pcs-mii sub-nodes; pcs-handle now points at the
  XPCS node itself.

- Commit messages updated.

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
  net: pcs: xpcs: add ANRESTART support for SGMII link recovery
  dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
  net: pcs: xpcs: add Rockchip RK3568 platform glue driver
  dt-bindings: net: rockchip-dwmac: document pcs-handle
  net: stmmac: dwmac-rk: add SGMII support for RK3568
  MAINTAINERS: add entry for Rockchip XPCS driver

 .../net/pcs/rockchip,rk3568-xpcs.yaml         |  69 ++
 .../bindings/net/rockchip-dwmac.yaml          |  27 +
 MAINTAINERS                                   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 131 +++-
 drivers/net/pcs/Kconfig                       |  25 +
 drivers/net/pcs/Makefile                      |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 598 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  35 +-
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 10 files changed, 883 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

