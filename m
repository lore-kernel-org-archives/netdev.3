Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470013242D9;
	Sun, 27 Sep 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790493692; cv=none; b=qml9xWuIczz5rUCGaht3CYNpnsh9amLaoNarCOWwY/8H/RNvdLljJF0kWZqREofhLzFrPqF3u0KWE9+PIWMaH/6t3GHzZzKjrg6wfgctiKJpNpZbVvfDyBQNciX03r54xBGEdLLTCPGB/XTJcB3FqYjv0O//msj5U9jNIzp0vdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790493692; c=relaxed/simple;
	bh=rvDgu+Qe7KFMKwdCJL2pEoBGjfUUlIHlF1QMFOeu8Ds=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=TH9jONFKt+Krt5lW9Y++OISFpZ+t09Z906Klo2vqzBzz7iLxet4zOdBLDHTn3bDDH253ItdD0eXs0RIATGL2voAjN1LDbRGLbboPQYs/V+HBsCWdgqiLRwZxQs61c6UpZDrPAU+kTvVbynfS3c9j5jbTuHFjVYswllKF+Ak5NGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 27 Sep
 2026 15:16:20 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 27 Sep 2026 15:16:20 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH 0/5] net: ftgmac100: Add AST2700 support
Date: Sun, 27 Sep 2026 15:16:19 +0800
Message-ID: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPCuGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNj3eLSgoL8opL4xOISI3MDA10zi7QkQzOTlEQT02QloK6CotS0zAq
 widGxtbUAumDGZ2EAAAA=
X-Change-ID: 20260623-support_ast2700-68fb164da45c
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790493380; l=2557;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=rvDgu+Qe7KFMKwdCJL2pEoBGjfUUlIHlF1QMFOeu8Ds=;
 b=8MEK+Xv59yMmITLCPH459kHI6x2Ht4I0kZn2uS2UbcVTxRZ+/Z/lqwWkMtjFXL13c1OwaFf2x
 D3vpOsQn0V3AhYpiQTjBCe4Ot1js9JcSNILC3c0ZMszp7zbCKDxq2vz
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

This series has been validated on AST2700 EVB and AST2600 EVB.

Patch layout:
- patch 1 updates the binding for the AST2700 compatible, RMII RCLK gate,
  and reset support.
- patch 2 adds the AST2700 match data and OF compatible.
- patch 3 programs the AST2700 RMII enable bit.
- patch 4 adds AST2700 upper DMA address handling for rings and
  descriptors.
- patch 5 enables the Faraday/FTGMAC100 Kconfig options on ARM64 and
  selects MDIO_ASPEED for ARCH_ASPEED.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Jacky Chou (5):
      dt-bindings: net: ftgmac100: Add AST2700 compatible
      net: ftgmac100: Add AST2700 compatible support
      net: ftgmac100: Enable AST2700 RMII support
      net: ftgmac100: Add AST2700 upper DMA address support
      net: ftgmac100: Allow building on ARM64

 .../devicetree/bindings/net/faraday,ftgmac100.yaml |  4 +-
 drivers/net/ethernet/faraday/Kconfig               |  7 +-
 drivers/net/ethernet/faraday/ftgmac100.c           | 86 +++++++++++++++++++---
 drivers/net/ethernet/faraday/ftgmac100.h           |  7 ++
 4 files changed, 88 insertions(+), 16 deletions(-)
---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260623-support_ast2700-68fb164da45c

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>

