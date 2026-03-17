Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3236F400;
	Tue, 17 Mar 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773236; cv=none; b=fVx5ksD7tpN5+kNi3eRQUSEJewph2jXZJwSsUx1Eg6VcsitddODQPD94UVgtlraL0TACdx74qKYbYspabUR+hN/X8SlWrAv9XtQAAGLRoxD97BWXieydVB0eT54FKKpGHJJ8/NbrXeBlbX9WLsQRiiaC20lM7Dg1HenOvHRb6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773236; c=relaxed/simple;
	bh=Cedk0kISEt8TAES4ZFcIQMzVN5OpSY5zP/DM376NvYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdM8Kxpk8eodmgvlKq8YTeKYvrdDUVFbBCHS9B1yvMVM5clopab1BpSw4xk6SpR6kqcL0c+8x42hIz2iGvtqTdKGXKfhoHVuorrTdTiZ9idblBM59G54nYlVZlm2fig658yO02D36YLBKNk2D6fPyCJrTmjhMQOC8ypJSkIIgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jHjLNLiW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jHjLNLiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773773235; x=1805309235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cedk0kISEt8TAES4ZFcIQMzVN5OpSY5zP/DM376NvYc=;
  b=jHjLNLiWA0QPeGPsN5srp9e3zQyIDxV81f1ljRCaxnQ43Js26O6jDDDr
   JJcHpTSfgVrLMCVuvb88edQ0DGthCuj72MsB700U3p0LJEbOmEa/oVi5B
   co0f3TnxEOtGqf/BbaZYLT3HxnXhwEzW9izhUNw9oRLUQKuO7xvScPYiK
   LI94Re6Gg5QKMbFDuoTTr14yqe/nthkp4BoryHW87FMursx0M7EoalaHx
   73J51lclv0KC69IfZQrXoRUJT4EYeMa6Qg/N/lMekkzucpMr9g85Gcmyp
   cr8bZ28/0syrO0emyEyvAh0WbilxeaietgS8aj//bXUXpOSUaHWuReTxH
   g==;
X-CSE-ConnectionGUID: wahvWo40QRmVOyIEFQPcXQ==
X-CSE-MsgGUID: +GDTgvTcQNunFvgqpemg1A==
X-IronPort-AV: E=Sophos;i="6.23,126,1770620400"; 
   d="scan'208";a="222060298"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:47:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Mar 2026 11:46:39 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 17 Mar 2026 11:46:38 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/2] Add support for PIC64-HPSC/HX MDIO controller
Date: Tue, 17 Mar 2026 11:46:08 -0700
Message-ID: <20260317184610.315852-1-charles.perry@microchip.com>
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
39, which yields an MDIO clock of 1.95MHz. This is the clock configuration
I've used in my tests.

This was tested on Microchip HB1301 evalkit which has a VSC8574 and a
VSC8541.

Thanks,
Charles

Charles Perry (2):
  dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
  net: mdio: add a driver for PIC64-HPSC/HX MDIO controller

 .../net/microchip,pic64hpsc-mdio.yaml         |  61 ++++++
 drivers/net/mdio/Kconfig                      |   7 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-pic64hpsc.c             | 207 ++++++++++++++++++
 4 files changed, 276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
 create mode 100644 drivers/net/mdio/mdio-pic64hpsc.c

-- 
2.47.3

