Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AAB3C414F
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215882; cv=none; b=ehiFtW5UVakOH3NwJxZpbhCa1GQRoXGS3heuVokB6OCBOfeCryKiKcMK4DISHL7DBsfSXkMhUNYiSgP5HemCRlkdqR3D8bdr509y8M5OaMwx2w7zYXecIetyvl/8xMtKPEsS11chqatN4llYhyXl/PPmNG/00BVtfcuqVahLTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215882; c=relaxed/simple;
	bh=/tqBOkf3rZ68oAtuWQMEyBuLNE6bYhAWXGsgJ9b0Abg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XoNVfoRnQ3403OJqTyDQj2WbwCSzJP+wVgV55O632qFJBAa8IvXB8QXkNZHJShopFJ761pMj68ClAiy7u/abmAxYw0E+u4lDkqG+8TzITVpeZaG2lbFvoWq2+rm27aar0WpAcNGocR4QlodbA5wgIvtGDI+DRSvk/VPwVHlWX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSL1w6iU; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSL1w6iU"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd613507bd1so78631a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792215880; x=1792820680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijVuixKGbcFzhxPljdKSrg9qSldEjkdopCfbyGu/Rtc=;
        b=HSL1w6iUGBaLk7CNG4k+OMv7iT0QfTYmhZaJT3IfkoQWVc6b9E7NyHTDtBySkP5e6X
         EB8Bs0+yEENH0m7QMgsZYekmM6HhBxpz7XxWVBN+hT+3nKVEe4JcbTRXMf2VJxaSmbg4
         j3lrW2OL22JnRLxj1M37xbXsCwKP+RWO9sIrg51mioA25mKwFZY564Od9G4CmOHUGJYS
         +rqUf5Miq10DZjVCiyrm3tCzDy+36FWdiCDUd4rhsbsOmU5wPRubaN78eRM04BMvpxLW
         yaQDqcPL08iwwcx8ULZd3W4ahGK82IgLrkcy5vtou2gQI3x5VCfZAVn6+ezorHp4VIAP
         hyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215880; x=1792820680;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ijVuixKGbcFzhxPljdKSrg9qSldEjkdopCfbyGu/Rtc=;
        b=Qq6KKi77UH6fBfoVb+D5C0Mzf0774fhG1w2Fc8mIKffH+wx/zgU1thd6FzPjgAxK2G
         bRBWepdoEXi9IFD9TQ+YiFh3TJ+3kabxgiPg2PUbMZMoz0wnFgAO+a8m866oQqt+NUph
         5mmg2e++pBeCVUsSYzgpyIyZ0umDUmW6BTa0y3umiS5yZ1oWQTxc2Jnltr0+hY2jWiey
         TebRyXxZC/VyOAMrZIlTUKaFcUAeHEFcxshDU/a8LVL6poKzMWz0m3qL3wclvrhhSykn
         ROycKOlLoHMcPFbB/kbQn3uJLJGGOvXpMMyCudtp6wnFI6atToA9rGtkY/mHFj2qXdh1
         b4xg==
X-Forwarded-Encrypted: i=1; AKwUvBwFq2WOltQ21nj2AFSrVXHGZwQuCUUJKj8p57Mm02SyAN1aXr15mDF1pcpTDfopp/radS0Ragc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBi0ZnnIz4LAMIkqacXdaCdCFaH0cP0FtCFhwIGc4XnEXyCieQ
	nBL1e3eu26rZ/oA9WAxcCE/2JsW+iV5XxdPuJyJX8Iduoak2daG3JJJ1
X-Gm-Gg: AYBFou30p1bTJRTTcXF/V4ktZbK+0xwGwsBHeGhkafC2oIbu8mRTt01VJI9B7nVQ8Nb
	+YPyYymSHuUvRJviqiTbWv5WdZoL3btitdlRV2iZ0SG6j6GDoVzmIfzeitOO6PkU5K9GiBkx09I
	VHF7v1luqko8K2pflAoZMfaw36hjlEGhHKmgf444qN1mIgeTUx7EvHi1rHsncsuuymdgpw21TBj
	hMBofcGgrTCs2ELulpnMaEaEPSn8AkvUQxYClFr57DWSnCx7z4CcIq8zpnDAucT2BoE53s7sVhM
	yfFquhV3JB6Dcug9YdtXmK0QE78Wv8i5mv5O6MxtCDd8t7UrMNR+P8crUIH323O/q8MaHP4uvN0
	e0BJTQffkafkFdHTgHZ0b6Qzea4U3UVhHfA2noBlTuyGpRAxatHSCkDK8B+Y1QAysNmrFphLuNV
	oaCYc5/63nYZW/TaHBP4NKtnRINXJ833jxQwpHCuOsBcOPrj7MDADjsApw99OIssHKN+2J5g==
X-Received: by 2002:aa7:88c7:0:b0:891:6aeb:84fc with SMTP id d2e1a72fcca58-8a04be250efmr1456271b3a.22.1792215880096;
        Fri, 16 Oct 2026 22:44:40 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm1958225b3a.23.2026.10.16.22.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:44:38 -0700 (PDT)
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
Subject: [PATCH net-next v12 0/6] net: pcs: add basic support for RK3568 XPCS
Date: Sat, 17 Oct 2026 13:43:58 +0800
Message-ID: <20261017054406.1828061-1-coiaprant@gmail.com>
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

The DTS changes using the PHY property are sent separately to
Heiko/linux-rockchip. There is no hard build dependency; the pieces
can converge during the merge window.

Changelog
=========

Changes since v11:

- Drop the "default PCS_XPCS" for PCS_XPCS_PLATFORM and the
  "default ARCH_ROCKCHIP" for PCS_XPCS_ROCKCHIP. There is no in-tree
  user of the generic snps,dw-xpcs glue that needs it selected by
  default, and new symbols defaulting to enabled on olddefconfig are
  something we should avoid (Jakub).

- Update the PCS_XPCS_PLATFORM commit message accordingly.

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
 drivers/net/pcs/Kconfig                       |  23 +
 drivers/net/pcs/Makefile                      |   5 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 598 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  35 +-
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 10 files changed, 881 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3

