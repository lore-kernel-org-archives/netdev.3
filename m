Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793951947;
	b=4g2R5Cwz4EcjsqpjLLGMlVtec880I0/ijmdHO5dSOgNOYLc2xuCTHpGG49vVYnaU6BG6
	 GjAWyVPKEOF+qe1sVS7NK3Z8jQzpCaYdn0couQ2k3xHP2h0Yt9yFUDEfMHPBnqqNnPuUu
	 0OB3AgVRiBcNlQ8uQ1GIWKmEunIBhL0UQQM6Wturv/bOBiqjHSiM/VVXhsSGMjTr3E3JR
	 vPS4HNckrkBxACRi6uWjnIGhuMQeTCiLK7R596EedzT+aPl4Je6FgCV5IjlFwqqszTYx0
	 bUHHIQia5w6EP9so6niVlp+wLlR8JZ1jBJzNDVM+6kOAet6VlqbbSDzqp36tADCkItA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951947;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kPbSQnSE/QJ3x1rfPbGOXpcL9+sompGSau+wLZMj/jY=;
	b=od2q4CHzX7aXJqgB2BnCP408LTZwg3ykkYYKINzcZKJO4GFajVYGnPNKRvul3WdYlzAV
	 4js+rEtKdwP98/wH4bJrSx3Hs5XQy6yYqnSDZ+DH3arBPuxnBU+vJs3s9SQDOsgBRyAxS
	 SF7bkhfGpgL93Z5kH/NPzgboQLv3uulqkMrkV055s1zZr+1JwTyD6c4g4jGqpM9K3thwA
	 Ts/+KSH2yZMkOOqWScnwH4V5VUlFK0uGyHDeKUfUraJYZSEg3PrXjkwI9hSehfUKl9HHZ
	 bNIErD2yuUeiB7byoelnPHnmOg6pER/iIurp/DD2/YaiQpgx0W8Yw+L3xxSf9MTO2GQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ReNeYfCO;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAC606A329;
	Fri,  6 Nov 2026 07:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60DAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ReNeYfCO
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9F45F20041D;
	Fri, 06 Nov 2026 08:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kPbSQnSE/QJ3x1rfPbGOXpcL9+sompGSau+wLZMj/jY=;
	b=ReNeYfCODfomlVdCheXppJS3kDPTfv3rlI0YZvjJ/dtPnNwHYpmcExyjMdsrh/CBRF2XY2
	qolZHRay0uslgFVT01et+9/nYwOVCUyFhQiSkmMhbPOTcEN4c5QSCohzHrjMumo1gfg+1F
	OkR9MtMtd1Bjg9FGot7qliNj2NAugwfv6NReWAYR7pjuPXwYjhV4TNNZK9ywcw1hQEiZNJ
	Fc938oMv1iLS5M60NIpuPFZvhQxAMl1Zb5974ZVPpkeGhp8+lurrhv9KTwuD5gQDW+q+Wh
	qqfp1IIVpSIcazMCtGwhanKbqCYswz88GaDV6EkYGBHCJRvwJonREXBXywIhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kPbSQnSE/QJ3x1rfPbGOXpcL9+sompGSau+wLZMj/jY=;
	b=KE90NvHM+cd2vMrolv6/WcqIH2pfZ/OfuyV/xvREFuN7lMNiNc1WumxkyXqq9GQJjInHzV
	rAgCQMJXolHuSArrE5EftrtTuBBAXAeO07Q2q9MrZzCIWR/pHjFy0FQqyIbYZNmqhEfTPz
	LIULrT36MOdWrxRbSavmPmwXdDRxC3nandjHlCrOHGdj9q+AsriMdGbNT+Q/zwqi5AT04z
	kZPUKfTqK0iEF2xXlFleXXZuG/uTXCZBHEZsLHXXD3nDMOT1ASwkc17wZYX+Ywboj1uZUB
	BT0iP57vMSNsSpeX3xxno/PwiLLIbJLHXuEH8HSXAkmmu4XtBT4bvbQGIATmuQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793951942; a=rsa-sha256;
	cv=none;
	b=fe87B8CcFvG6lvmdFWK1W5h7Pm0mxXwDrwUAG40Be9cPrlZucaA5nxWsS+Q8YKOn2fG7mJ
	w1NixVzFu4R1w0CHb7smXBiWVMTSWquCdBnsc5q7LUmg3tU/JUjDa7GR+yO80ylY6GTuvv
	i7iq3kUNb22R9qMGofTpnXOhw/F9HC2hNOcluTu+pxrRuWbW1+uua1r3SFEJMlXA3m/z0y
	ekwqoQs7VgtyVdsllm1x9xAdsGQ65V34Q3jz+/9cNOqHi+uIo5jjWE5XPtRv66l5GkMPgG
	Lvh206Ob04fPrpJ8zEELL6p+4tEuAha0WYOtFd26tezgNPwSZjUkJgE4VR/vrQ==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH net-next v3 0/5] net: dp83867: add new output-impedance DT
 binding
Date: Fri, 06 Nov 2026 08:47:24 +0100
Message-Id: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBAF0KuYrh1T2tqCK+9hXEAZoC5K05YGQ
 7i7BTcmGpc/M//9hQT0BgO5HBbiMZlgRpsDPx6IHmrbI5g2Z8Iok7SkApICBnF0RkPrSl5KBah
 4XQrNFS0kyUXnsTPzjt6IxQgW50ju70uYmgfquJnb72BCHP1z30/F3vg3lQqgUOhaVdicBWJ3d
 Wj7KfrRmvnU4r6S2IfD5E+HZaeuVCM0aokV/3LWdX0Bo/XfkB0BAAA=
X-Change-ID: 20260804-v7-2-topic-dp83867-e73a84c37016
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Michal Simek <michal.simek@amd.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3673;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=al1FHRm3IZNEtLnKufWsjtPBIJAxTPWvgFsTaGtRGec=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bbjkOe/0v7VvdolUyb6bB+Zt1LjwpB5n/Sx6pElKsZK
 owPRUV1lLIwiHExyIopsqgsrOAT9fjgGTlNhAtmDisTyBAGLk4BmEhiF8N/97kc0xfz3rPgU2f2
 sXTsks1+V7PPL+mhcen1nsk1s/8GAVVcT32xNLDO7tp1SX/trFO8Ft/WHy361ubHesO7uU3EgBM A
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently the dp83867 supports setting the io impedance to minimum,
maximum, default or a value from a nvmem cell. In situations where there
is no backend for a nvmem cell, the value can not be set to anything but
minimum, maximum or default.

Add support for a ti,output-impedance-ohms binding, allowing to specify
the impedance in ohms via the devicetree. It is mutually exclusive with
the nvmem cell and the boolean bindings for minimum and maximum; the
binding schema now enforces this for all of them.

Until now, dtschema never applied the binding: it had neither a
compatible nor a select. The binding gets the compatible of the PHY ID,
which several devicetrees already use. The Xilinx ZynqMP devicetrees
then fail validation on an unused #phy-cells in their DP83867 nodes;
patch 1 drops it. It does not depend on the rest of the series and can
go through the Xilinx tree.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v3:
- new patch: drop the unused #phy-cells from the Xilinx DP83867 nodes,
  which fail validation once the binding applies to them
- new patch: give the binding a compatible and reference
  ethernet-phy.yaml; without a compatible or select, dtschema never
  applied the binding, so the new constraints would not have been checked
- ti,output-impedance-ohms takes ohms (35..70) instead of the register
  value, the driver maps it linearly to the nearest of the 32 settings
  (the datasheet does not specify the impedance of each setting)
- fix the range check, out of range values were silently masked
- describe the mutual exclusivity instead of a wrong precedence in the
  commit messages
- fix typo in commit message
- also forbid ti,min-output-impedance together with
  ti,max-output-impedance and drop the precedence note from the binding
- rename the binding patch to "Add ti,output-impedance-ohms"
- Link to v2: https://patch.msgid.link/20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de

Changes in v2:
- change 'u8 *val' to 'u32 *val'
- fix logic in driver
- update description of new binding
- rename ti,output-impedance -> ti,output-impedance-ohms
- make mutual exclusivity explicit in binding
- Link to v1: https://patch.msgid.link/20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de

---
Steffen Trumtrar (5):
      arm64: dts: xilinx: drop unused #phy-cells from the DP83867 nodes
      dt-bindings: net: dp83867: add compatible and reference ethernet-phy.yaml
      dt-bindings: net: dp83867: make exclusivity explicit
      dt-bindings: net: dp83867: Add ti,output-impedance-ohms
      net: phy: dp83867: support setting output-impedance

 .../devicetree/bindings/net/ti,dp83867.yaml        | 47 ++++++++++++++++++----
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso      |  2 -
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso      |  2 -
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso      |  1 -
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso      |  1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |  1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |  1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts  |  1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |  1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |  1 -
 drivers/net/phy/dp83867.c                          | 29 +++++++++++--
 12 files changed, 65 insertions(+), 23 deletions(-)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20260804-v7-2-topic-dp83867-e73a84c37016

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

