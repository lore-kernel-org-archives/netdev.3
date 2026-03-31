Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668793AA1B3;
	Tue, 31 Mar 2026 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960785; cv=none; b=GnATHrumsPPrNm3fu6m23Yg7xqiZw4dh3wUWHmhvAH9G7XPGQXtK3JnLSJB2Pdk5Ga2lcMTgN38dgDIct3lciEay7SNMUTqUb5M+Ou0HpkEBcpWh4HBRNMYusAss7XKHCbKvMKEhrTS4IqbHz7i+8rddvoJbVgrdN3kp7MD+Bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960785; c=relaxed/simple;
	bh=772edPr32akcN4/lSuBkHqnI85q/7dwsylSD1qKkd1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lIC+FO1nSMhFmtFTld1wWvHjqmQSb1YeQmzPvBuiXVDMEptY4PrrhtogkiQDmuN3IvDOQXo+mK70v2HjnYWP0k49q7LkHBfKGRUB6CEvYEiWSLw4RL3qzaHFu6xH/6BzPelRU12uyFKxnNa7f8KdkT6XcEyb0ITwkcT8njJ4ZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RWWncYbX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RWWncYbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774960784; x=1806496784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=772edPr32akcN4/lSuBkHqnI85q/7dwsylSD1qKkd1Q=;
  b=RWWncYbXceaxEfLn6KJBhMcbp8RJU3eQxkFpF5duvEPNhuXSbElUje+R
   4PFkrcXoaHVAmH01gQPhmsbAjGRCenL38Fu228LMoTHR13IO36TFiK/ac
   G/Q+jHNK1zOKgEI2a6UzvSNwEu+KM7fbY6upetKZNn60y5+AXTwGM81t/
   YUQKt2s4y4upDcgKsnVPPHPuZZ1xGjzbjItiFPw8fsTHsrlCTfTm3nfzv
   oiPwlWoFJI1OFFr9dtMaIoXjc1jJlJDpwklhyVf0hiQCXVzWeaSsEoFD1
   ccbajwOtJ4e2l52g1JeT0m5EGnAi+snyTEs8Xi4AfTi+YofHJkec6EBN6
   w==;
X-CSE-ConnectionGUID: ON5PEU2gSTOMkNUYCRIrMQ==
X-CSE-MsgGUID: luN5CsS7T4mJrrknJDAMXg==
X-IronPort-AV: E=Sophos;i="6.23,151,1770620400"; 
   d="scan'208";a="222728241"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2026 05:39:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 31 Mar 2026 05:39:40 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 31 Mar 2026 05:39:40 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 0/2] Add support for PIC64-HPSC/HX MDIO controller
Date: Tue, 31 Mar 2026 05:38:52 -0700
Message-ID: <20260331123858.1912449-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hello,

This series adds a driver for the two MDIO controllers of PIC64-HPSC/HX.
The hardware supports C22 and C45 but only C22 is implemented for now.

This MDIO hardware is based on a Microsemi design supported in Linux by
mdio-mscc-miim.c. However, The register interface is completely different
with pic64hpsc, hence the need for a separate driver.

The documentation recommends an input clock of 156.25MHz and a prescaler of
39, which yields an MDIO clock of 1.95MHz.

This was tested on Microchip HB1301 evalkit which has a VSC8574 and a
VSC8541 with clock frequencies of 0.6, 1.95 and 2.5 MHz.

Thanks,
Charles

Changes in v3:
- 2/2: Add a MAINTAINERS entry (Jakub)

Changes in v2:
- 1/2: Make "clocks" and "interrupts" required (Andrew)
- 1/2: Add a default value to "clock-frequency" (Andrew)
- 2/2: Remove #define for unused registers (Maxime)
- 2/2: Add "c22" to clause 22 read/write ops (Maxime)
- 2/2: Remove the call to platform_set_drvdata() (Andrew)
- 2/2: Make the clock mandatory (Andrew)
- 2/2: Use 2.5MHz if no clock-frequency was specified (Andrew)
- 2/2: Change the error message for bad clock-frequency (Andrew)
- 2/2: Fix a use without initialization on bus_freq (Andrew)

CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Heiner Kallweit <hkallweit1@gmail.com>
CC: Russell King <linux@armlinux.org.uk>
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org

Charles Perry (2):
  dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
  net: mdio: add a driver for PIC64-HPSC/HX MDIO controller

 .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
 MAINTAINERS                                   |   6 +
 drivers/net/mdio/Kconfig                      |   7 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-pic64hpsc.c             | 192 ++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
 create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c

-- 
2.47.3

