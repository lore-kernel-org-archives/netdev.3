Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DC3F1066;
	Thu, 15 Oct 2026 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046829; cv=none; b=Mp75VKZpNlv85u91citBiTD1Qz+hHcQra7afueFzx4VdjmqPk6CW9lLnb5NNMykH+MDHQ/tkgv3LCNn1T0grwcJR8o0/QETSaselekN1bgW8jGMKRgiL0rGMOFTrdx22EiVc9Nf6Nghz0FLn1H71eBwUhW1IHwedHJMjppY9W48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046829; c=relaxed/simple;
	bh=0gSIMPlTvIMhYNEQn6cjs7L0xaHQ/QGFUDm7CncjlLg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=UnYm3l+jdeou02fJAhErRM4HVlK1NNp7LkQAxhhiH/z4KTwmU/uk3p4n8mfoiQDyzxTFgSx5GXj8tlVOPIzmZ9TGzVhHfbunR+a5CN4n1MBJiffookW4R35XXtalNpR8tLbHVopfJ653P1u74aZ8tZbKlmCPRhSkttUnOtFv4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 Oct
 2026 14:46:59 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Oct 2026 14:46:59 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v3 0/6] net: ftgmac100: Add AST2700 support
Date: Thu, 15 Oct 2026 14:46:52 +0800
Message-ID: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANx20GoC/2XNQQ6DIBQE0Ks0rEvz+SpqV71H0zQKn8qiYIAaG
 +PdS1h043IymTcbixQsRXY9bSzQYqP1LofqfGJqGtyLuNU5MwSUILHi8TPPPqTnEBO2AFx2ZhS
 y1kPdKJZXcyBj1yLemaPEHa2JPXIz2Zh8+JarRZS+qD22B3URHHhvoDLYa1Qd3oY4E+lEaroo/
 y7ggn9EAMgjghmppKZGmLEDKQ/Ivu8/orLiWQIBAAA=
X-Change-ID: 20260623-support_ast2700-68fb164da45c
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792046819; l=6384;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=0gSIMPlTvIMhYNEQn6cjs7L0xaHQ/QGFUDm7CncjlLg=;
 b=maNKLlHV+kOaRruSPAuqy334NGpp/AsI6ETyQ396+fzym0O0jNoEgxlCcUEyo1TdXU0k9Ho42
 WwHlqSY7vs/DbvKFw6LOSbn/maAot7xI734Ue9FVtSZzt6sXJogzz35
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add the pieces needed for the FTGMAC100 driver to run on Aspeed AST2700
systems.

AST2700 keeps using the FTGMAC100 MAC IP, but the enablement is not
limited to a new compatible string. The SoC can boot with the MAC on
ARM64, needs the Aspeed-specific RMII mode bit programmed when a port is
wired for RMII, and requires the driver to use the upper DMA address
fields in the ring base registers and packet descriptors. Those fields
expose a 35-bit DMA address range on AST2700, so the driver must request
a mask that matches the address bits the hardware can encode.

The series first documents and wires up the aspeed,ast2700-mac
compatible. It then treats AST2700 as an Aspeed MAC in the driver,
enables the RMII mode programming, writes the AST2700 high descriptor-ring
base registers, carries the RX/TX descriptor high address bits, rebuilds
full DMA addresses before unmapping buffers, and requests a 35-bit DMA
mask. The high ring base registers are only touched for AST2700 so older
Aspeed device tree register windows remain unchanged. With that in place,
the FTGMAC100 Kconfig entry can be made available on ARM64 while keeping
the existing Aspeed MDIO dependency for AST2600 and newer ARCH_ASPEED
systems.

RGMII delay is configured at the bootloader stage, the same way it is
handled for AST2600, not by this driver. Aspeed's SDK bootloader
configures both AST2600 and AST2700 boards with the RGMII delay
disabled and advertises "phy-mode = rgmii-id" to match, mirroring the
OpenBMC bootloader change that stopped inserting delays on AST2600 so
its device trees could use the correct "rgmii-id" setting. On AST2700,
every on-chip MAC is likewise configured by the bootloader with RGMII
delay disabled and "rgmii-id" phy-mode. Because the delay is already
resolved before Linux boots, the ftgmac100 driver does not need to
program any RGMII delay for either AST2600 or AST2700.

This series has been validated on AST2700 EVB and AST2600 EVB.

Patch layout:
- patch 1 updates the binding for the AST2700 compatible, RMII RCLK gate,
  reset support, and requires "phy-mode" when the AST2700 compatible is
  used. It also drops the "faraday,ftgmac100" fallback compatible
  requirement for aspeed,ast2400-mac, aspeed,ast2500-mac, and
  aspeed,ast2600-mac, giving them the same standalone treatment as
  aspeed,ast2700-mac.
- patch 2 adds the AST2700 match data and OF compatible.
- patch 3 programs the AST2700 RMII enable bit and documents why
  netdev->phydev can never be NULL at that point for AST2700.
- patch 4 makes "phy-mode" a required device tree property for AST2700
  and fails probe if it is missing.
- patch 5 adds AST2700 upper DMA address handling for rings and
  descriptors.
- patch 6 enables the Faraday/FTGMAC100 Kconfig options on ARM64 and
  selects MDIO_ASPEED for ARCH_ASPEED.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v3:
- Require "phy-mode" in the devicetree binding when the AST2700
  compatible is used, matching the driver's probe-time requirement
  added in v2.
- Drop the "faraday,ftgmac100" fallback compatible requirement for
  AST2700; "aspeed,ast2700-mac" now stands on its own in the binding,
  matching how the driver already matches it independently.
- Drop the same "faraday,ftgmac100" fallback requirement for
  aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac as
  well, per review feedback. The same EDORR/EDOTR bit mismatch applies
  to all of them if a node ever bound through the generic
  faraday,ftgmac100 entry alone; there is no evidence this has ever
  happened in practice since ftgmac100_of_match[] has had dedicated
  entries for these SoCs since commit 03a2aba50b2c, but keeping the
  binding correct avoids leaving the same landmine in place. Folded
  into this series rather than sent as a follow-up, to avoid
  self-conflicting with a later series touching the same "compatible"
  block. Note this makes `make dtbs_check` warn against
  arch/arm/boot/dts/aspeed/aspeed-g4.dtsi, aspeed-g5.dtsi, and
  aspeed-g6.dtsi, which still declare the two-string compatible; that
  .dtsi change will be sent separately through the Aspeed/arm-soc tree,
  since dt-bindings changes don't go through that tree.
- Document in the RMII-enable patch why netdev->phydev is always
  non-NULL by the time ftgmac100_start_hw() checks phydev->interface
  for AST2700: ftgmac100_probe_dt() always attaches a phy_device
  before register_netdev() can succeed, via a discrete PHY
  (phy-handle), a fixed-link node, or NC-SI's internal fixed 100Mbit
  PHY, and any failure in that setup aborts probe first.
- Drop Reviewed-by from Krzysztof Kozlowski on the dt-bindings patch
  since its content changed.
- Link to v2: https://lore.kernel.org/r/20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com

Changes in v2:
- Make "phy-mode" a required device tree property for AST2700 and fail
  probe if it is missing, instead of silently defaulting to RGMII.
- Document in the cover letter how RGMII delay is configured at the
  bootloader stage for AST2600 and AST2700.
- Simplify the MDIO_ASPEED Kconfig select to ARCH_ASPEED only, dropping
  the redundant MACH_ASPEED_G6 condition, and update its help text to
  mention AST2700.
- Pick up Reviewed-by from Krzysztof Kozlowski on the dt-bindings patch.
- Link to v1: https://lore.kernel.org/r/20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com

---
Jacky Chou (6):
      dt-bindings: net: ftgmac100: Add AST2700 compatible
      net: ftgmac100: Add AST2700 compatible support
      net: ftgmac100: Enable AST2700 RMII support
      net: ftgmac100: Require phy-mode for AST2700
      net: ftgmac100: Add AST2700 upper DMA address support
      net: ftgmac100: Allow building on ARM64

 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 26 ++++--
 drivers/net/ethernet/faraday/Kconfig               |  7 +-
 drivers/net/ethernet/faraday/ftgmac100.c           | 98 +++++++++++++++++++---
 drivers/net/ethernet/faraday/ftgmac100.h           |  7 ++
 drivers/net/mdio/Kconfig                           | 16 ++--
 5 files changed, 123 insertions(+), 31 deletions(-)
---
base-commit: 518bf436318e8d1162391cd77d69d65198a4a25b
change-id: 20260623-support_ast2700-68fb164da45c

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>

