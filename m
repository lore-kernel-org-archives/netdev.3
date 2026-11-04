Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769253;
	b=nLgEanPBVOaB5k+ZYAL6UjelbblC9KI76WO5RDcSIamBiTMfC9hj2cFOpeq2H5eYIacZ
	 lazl8cjEAgyCi0ntvIyUOgVWHlkDJQakcyKkvnyx3ObJO8OqTO2xPODO9JjmrN94lAin4
	 /vVMB2YZ7e+izDkPOs7fr179Ljn/HuKAeAZxjG65rF5HR2jge5Hf0UIzqoEQMAWQgOUch
	 7tCYjA1FzkflhVEHTvBuBPslkKehlDwh9qvNf1/wyk3JfBzJxDqhISyD59H+hrl2bAsF0
	 xyClzVyp9aOq5kVk10f712Gn8UovqTLvxC7SExV1ykcDV6zEYhVNR184UqbdMFPvl1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769253;
	h=DMARC-Filter:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eN0NtEB6jg3HIcBqjCn9zZymsC74FOS9Aw+1tsYSRX0=;
	b=KglR6/jwqSG81dBOK8fm0uEL2/jdeM65UJCw3mYwUxMcJqps5QI/ThBJ73RRD28zL/0/
	 EU8jlFvwjDjpfh/hIcnjiWB26dYNnwDZfbxoNtDEyNE3c8bwb4ofqhGmfKCiC724tK+eI
	 ToVIH21SFwelzL3SgIjnVnlkiYpOp1tLETiFoc8wTXxBh9UPnlnw4GmGFgNiB+qntoCP3
	 PiGbbZXBoRmn+S9JM3TLITWkShvzLAuEp7J+NJ7D4e1vSfLDcuYY93p15Frhdz3b43M1O
	 TUF5uOmeMAAktf+7ArqMhia5JbMyhIYcqf4hRQYiPbAd1elFQ6DdTBM+LRKw8JYAvgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FC606A31B;
	Wed,  4 Nov 2026 05:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 506FC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 13:14:09 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 13:14:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v5 0/7] net: ftgmac100: Add AST2700 support
Date: Wed, 4 Nov 2026 13:13:53 +0800
Message-ID: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIABG/6moC/23NwWrEIBQF0F8ZXNfyfBoTZ9X/KKUYfTYumgS1Y
 cqQf6+4KAPO8nK5595ZphQps+vlzhIdMcdtrWF4uTC32PWLePQ1MwTUoFHy/LPvWyqfNhccAbi
 ewiy08lYNjtXVnijEWxPf2UqFr3Qr7KM2S8xlS7/t6hCtb6rBsVMPwYGbADKg8egmfLN5J/KF3
 PLqtu8GHviPCADdI1gRqT0NIswTaP0UkQ+IGHpEVmTyozFGjMI69RRRDwhCj6iKKC/1rMBIM8s
 OOc/zDzxCusWMAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793769249; l=7037;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=djMCj6AB5n/3H1RyoxXpvxeIZPe7HuyxfkZIqp+v0UU=;
 b=sGCHL1vgNwkaswSgLlVxhtlvWtnMQ9v8rGQxFRsQwI+WIOeRTfXRJC9/IGkyDtVKRH8wwPTgB
 Cve6POVtgd3CvicJDUN4xxL73Mr+e4NEUh9TG0yjZa9R3yGlqeg20qq
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
Changes in v5:
- Pick up Reviewed-by from Rob Herring on the AST2700 binding
  patch.
- Link to v4: https://lore.kernel.org/r/20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com

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
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20260623-support_ast2700-68fb164da45c

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>

