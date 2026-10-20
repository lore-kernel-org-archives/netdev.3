Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496062;
	b=VJG2U2YvgXtdqcHUC0oLnKqJW6a5ABYh+r6AUq5P8c/Nou+Txd3m1CdbNSQvCbgb6X1N
	 s+cvWPB9pNz6Vs88scQ4VTvz0xQaYG1LdzJPHKWMVLNdsXmju3GJ8Klhcd7AYg8eHUvLu
	 +UWWzwwCLALJXuES6Aoux4RCRFDkekKwP4UnSrrpTkdgLBx3eNb2lOOQGuGb7fzQ3BL7K
	 PBcY2hsD9guq06XH9hpjTr4nJ1JfTeb/azAHR1KJJNDqwmnkrjuh7Rvvk3ucarZtpZmF9
	 AHsK7utUXrLQZTNxCsCjcz5OoVvC9ALAk9xXu4X/SqdqUpoF/BNlC+88xxH8bEZC2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496062;
	h=DMARC-Filter:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NLbq3VXoYb8Pt372mEk41S2SaoxcfIfMfhiTEQEnkKQ=;
	b=Z74LW2Lcy3RgwgKMGtOgrCD3eFjrzN3C/5QtQfgusZuUrnNIBohrpvAPCxy99K2gVAMO
	 qSpOpJ2U0uhpy+r4rdSiJYOFmRTu1qQNumCTtSLakIjtiKwHnd3h77KU1NTmw4O4lX2OO
	 S1fKVcBimqgOeWl4wnA4F++Au4pywGbUxBpw958cu6h+CPQuLQoZyHEfAXqJqNFwVnbDY
	 549CBpuc6792lFlYks9DaeKL5uw4Nk05/NL8F0nhwv9clstwnqBZhh5WS7ET+GKw3zA4d
	 F/P9ySW53XXTFtanWNJcpbo+WcJsZyxnrqK1EFUsrzr5f2fq24opmpChV5+/dWGiSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF8606A331;
	Tue, 20 Oct 2026 11:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48AF8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Oct
 2026 19:34:13 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Oct 2026 19:34:13 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 0/7] net: ftgmac100: Add AST2700 support
Date: Tue, 20 Oct 2026 19:34:11 +0800
Message-ID: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNR12oC/23NwYrDIBQF0F8prmt5PhMTu+p/DMNg9dm4aBLUh
 gwl/15xUQrp8nK55z5ZohgosfPhySItIYVpLKE5HpgdzHgjHlzJDAEVKJQ8PeZ5ivnPpIwdAFe
 9vwrVONO0lpXVHMmHtYo/bKTMR1oz+y3NEFKe4n+9WkTtq6qx26mL4MC1B+lRO7Q9XkyaiVwmO
 5zsdK/ggm9EAKg9ggWRylEr/LUHpb4i8gMR7R6RBeldp7UWnTC22SHbtr0AidtV+EcBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792496053; l=6847;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Yds/NwfjB1reHnu8XcL7pcgERRJuEaARPT4bGqdxCh4=;
 b=EoU99xXyyRlDM1BCDIiTyVRa/lDRgbNotVm7uVPx7JTdfwDp/Ajvc81zj7y8uLTURKGz6N32A
 1t3RmZjxWaGDBxLQ/xsGoZ8SFZWL91QmuG6BunBVX8DMOw8On98bBkW
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
- patch 1 makes the existing aspeed,ast2400-mac, aspeed,ast2500-mac,
  and aspeed,ast2600-mac compatibles standalone, dropping the
  requirement to pair them with the generic "faraday,ftgmac100"
  fallback compatible.
- patch 2 adds the aspeed,ast2700-mac compatible to the binding, with
  its RMII RCLK gate, reset support, and the "phy-mode" requirement.
- patch 3 adds the AST2700 match data and OF compatible.
- patch 4 programs the AST2700 RMII enable bit and documents why
  netdev->phydev can never be NULL at that point for AST2700.
- patch 5 makes "phy-mode" a required device tree property for AST2700
  and fails probe if it is missing.
- patch 6 adds AST2700 upper DMA address handling for rings and
  descriptors.
- patch 7 enables the Faraday/FTGMAC100 Kconfig options on ARM64 and
  selects MDIO_ASPEED for ARCH_ASPEED.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v4:
- Split the dt-bindings patch into two: one making the existing
  aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
  compatibles standalone, and a second adding the new
  aspeed,ast2700-mac compatible, per review feedback that these are
  two separate concerns.
- Link to v3: https://lore.kernel.org/r/20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com

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
Jacky Chou (7):
      dt-bindings: net: ftgmac100: Make Aspeed compatibles standalone
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
base-commit: f09123082704b08d56fd044a2166e3e39fa68563
change-id: 20260623-support_ast2700-68fb164da45c

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>

