Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7833AC0E9;
	Wed, 16 Sep 2026 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533693; cv=none; b=nR1Y7eGlwtexEmE6Y1WuCvy/7rrEJXdyI+WPbr7pDQGrqPcR0aDqSwb3T+qkAJgDqNZgW7W6ZunuM6lQtdDhttiRXSgwGhYU9MgVQ8Dr3+lkYiAfNM5C1IwaC47Zb/3RA4QB7bChXO+BlZBGQBcbWxMAccZtZQ5rzWJINrnIhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533693; c=relaxed/simple;
	bh=uZjsORFcCwvkT2AAbXO2aZSM8USV3slRXFzd5UB31wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6NGknRPSXLGwZte4AZ3i4RoUb552NRHJ66V2l1YtjZYQptFKP3PgzBEo+xupDkonabYBAc3vk0oVaVoTAu1Ldny7YvSxOxLlwH8yQgPSigCP3JGKGzHUWymp3YaYqBqv18Mx6zo3U8lj3tXrm6Si2CkhtBBVRGWpbbVZTkuJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=UlWnZZ+U; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="UlWnZZ+U"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id B042B40B5A;
	Wed, 16 Sep 2026 14:41:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789533679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xTOSXHHE0Mp7WmhyDX8b5V5DuyvbmNcf+A+5A/N8sLo=;
	b=UlWnZZ+UVMEPdKCU7xcAFSbFO3th1cLIUDQAVgxHnxVx1R+lEdIoyMk1vV0Zvwe2nSIpwL
	ZFyTQtYBEJxngpet4wEa3OPi+HSxb4lNcF1PXZITorzVYPJT4u3LOS8vxeo3DLrUmsfe6B
	TewlUlT2TQQ1Jy3bYF7TtfNh9XyrThGWCMlvR+GJSfOutXpYKeisnXx9dwWGRF8qlWMsEG
	auLx73Cc4M2pirx+S2/HIHW1devcpDo59O9lqW8cz8l750238DpVNnbKOBNHEZyWKcO5j5
	Zhfw65agxQeObJuk7lgCCccPAoV2TQR2qaioEusCk4c4fTDd7nGlets9PDlnOQ==
X-GPT-Reason: legitimate; the email is a technical software patch
	submission for the Linux kernel (net-next) regarding Allwinner
	SoC hardware support. The sender (alastair@d-silva.org) matches
	the personal mailbox list provided in the environment context
	(alastair@d-silva.org), and the content is highly specific technical
	documentation with no marketing, phishing, or scam indicators. There
	are no URLs, no requests for sensitive information, and the subject
	line directly corresponds to the technical body describing driver
	and device tree updates.
From: Alastair D'Silva <alastair@d-silva.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH net-next 0/4] net: Add Allwinner H616/H618 EMAC1 and AC300 EPHY support
Date: Wed, 16 Sep 2026 14:41:15 +1000
Message-ID: <20260916044119.475666-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the secondary Ethernet MAC controller (EMAC1)
and the co-packaged AC300 Fast Ethernet Physical Layer (EPHY) found on
Allwinner H616 and H618 SoCs.

The Allwinner H616/H618 SoCs feature two EMAC instances: EMAC0 (typically
used with an external RGMII Gigabit PHY) and EMAC1 (Fast Ethernet,
connected internally to the co-packaged AC300 EPHY). EMAC1 uses a
dedicated clock control register in the syscon register space, which is
accessed via an offset index in the DT syscon property.

The AC300 is an integrated 10/100M (100BASE-TX / 10BASE-T) Fast Ethernet
PHY communicating over MDIO at address 16 + phy_addr. It requires
retrieving factory bandgap calibration data from the SID nvmem controller,
managing internal power rails and clocks, and optimizing transceiver signal
parameters.

To ensure reliable link establishment and MAC software reset with the
internal PHY, dwmac-sun8i is updated to defer MAC software reset until
sun8i_dwmac_init() after the internal PHY has powered on and begun
clock generation.

The series is structured as follows:
- Patch 1: DT binding for Allwinner AC300 EPHY.
- Patch 2: PHY driver for Allwinner AC300 EPHY.
- Patch 3: DT binding update for Allwinner H616 EMAC1 and syscon index.
- Patch 4: dwmac-sun8i driver support for H616 EMAC1 clock index and
           internal PHY deferred reset.

Testing:
- Tested on physical Mellow Fly-C5 hardware (Allwinner H618) running
  Armbian with sustained 100Mbps full-duplex network traffic (DHCP,
  iperf3, NFS rootfs).
- Device tree bindings validated with dt_binding_check.
- Separate SoC and board DTS additions will be submitted via the
  linux-sunxi tree.

Alastair D'Silva (4):
  dt-bindings: net: phy: Add Allwinner AC300 EPHY binding
  net: phy: Add Allwinner AC300 EPHY driver
  dt-bindings: net: allwinner,sun8i-a83t-emac: Add Allwinner H616 EMAC1
    and syscon index
  net: stmmac: dwmac-sun8i: Add Allwinner H616 EMAC clock index and
    internal PHY support

 .../net/allwinner,sun50i-h618-ac300-ephy.yaml |  79 +++++
 .../net/allwinner,sun8i-a83t-emac.yaml        |  14 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  65 +++-
 drivers/net/phy/Kconfig                       |   9 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/ac300-phy.c                   | 331 ++++++++++++++++++
 6 files changed, 486 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.yaml
 create mode 100644 drivers/net/phy/ac300-phy.c

-- 
2.53.0

