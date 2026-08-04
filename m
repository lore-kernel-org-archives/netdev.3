Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759D3DAAAB;
	Tue,  4 Aug 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847617; cv=none; b=jxE31Bpc1eBIQl/rviNXmF9Ncd33wpDXFWxN82b6iRiPL35blDWuMFmDGA9DypAiyd+djmqYS9dcHFAqSLbhV8lz+nNuMfeU5g8RjdMAZePXwNT2IegQIrQpvg2Ohf642hayJ+9m1y6Ifocb4RbkjBc2EBWTzzQWej6swAV/XEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847617; c=relaxed/simple;
	bh=H4LHYlQc45mhuD0f86b1o6mPUaOz+kZIrnMaufA3GyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcY+qPPygRQ85VVN8xzB4KMS2RksMTLJ4t6/KNBimJir9HEzx4lB/ALH3M++KhyIc7ToNfU9VLE5p8irYtziefpLgmhc4SXUqowo7CDYPWT6EkGvKpBqvnyorpX3rzkuudsbNbtdwTWqU4mstNWyaaCVW8VyY7qIt+sW1czdPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 885C2200F83;
	Tue, 04 Aug 2026 14:46:46 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wrEXe-002s0o-1I;
	Tue, 04 Aug 2026 14:46:46 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 04 Aug 2026 14:46:34 +0200
Subject: [PATCH 2/2] net: phy: dp83867: support setting output-impedance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-v7-2-topic-dp83867-v1-2-1ca79eb54eef@pengutronix.de>
References: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
In-Reply-To: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=H4LHYlQc45mhuD0f86b1o6mPUaOz+kZIrnMaufA3GyE=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ1bhfdPV4qvunTf1z77LpZ7zYWGf/t8nSxRSmisXLp2o8
 nBWo/jdjlIWBjEuBlkxRRaVhRV8oh4fPCOniXDBzGFlAhnCwMUpABOZ8pWR4U3AMcN6v7lPilY/
 OiWVnBZzL936VNu32eX77puaF23894bhf3oax7I7lg6+Nv0eS5fP/e9R+MhVtn7R6101Cdy/12Z
 zsAAA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently the dp83867 supports setting the io impedance to minimum,
maximum, default or a value from a nvmem cell. In situations where there
is no backend for a nvmem cell, the value can not be set to anything but
minimum, maximum or default.

Add support for the ti,output-impedance binding, allowing to specify the
impedance via the devicetree. The existing boolean bindings for minimum
and maximum take precedence over this new binding. The nvmem consumer
still takes lowest precedence.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/phy/dp83867.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cdb..e98c5d940410e 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -542,12 +542,19 @@ static int dp83867_of_init_io_impedance(struct phy_device *phydev)
 						"failed to get nvmem cell io_impedance_ctrl\n");
 
 		/* If no nvmem cell, check for the boolean properties. */
-		if (of_property_read_bool(of_node, "ti,max-output-impedance"))
+		if (of_property_read_bool(of_node, "ti,max-output-impedance")) {
 			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX;
-		else if (of_property_read_bool(of_node, "ti,min-output-impedance"))
+		} else if (of_property_read_bool(of_node, "ti,min-output-impedance")) {
 			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN;
-		else
+		} else if (of_property_read_u32(of_node, "ti,output-impedance", &val)) {
+			if ((val & DP83867_IO_MUX_CFG_IO_IMPEDANCE_MASK) != val) {
+				phydev_err(phydev, "'ti,output-impedance' contents out of range\n");
+				return -ERANGE;
+			}
+			dp83867->io_impedance = val;
+		} else {
 			dp83867->io_impedance = -1; /* leave at default */
+		}
 
 		return 0;
 	}

-- 
2.54.0

