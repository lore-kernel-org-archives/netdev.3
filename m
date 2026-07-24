Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCE3515E4;
	Fri, 24 Jul 2026 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872603; cv=none; b=Kokh1ezd5kd3ari8u8NuOeFEWy68hWwUEGEpN9tXiVOqb+n0++ZxoGyzbVnvLO++uGOq6nFgIbqkn9hWgrhCgrNFv0vsN4eMb704SDEeATwgLtA1lOk5K0759luOVacecZNJP35UPvgiZfkPe/kCjqogqzGJ9GdONbiLY8Kv8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872603; c=relaxed/simple;
	bh=7XF7MAFcn6wmhhyC+2PeG3mULjc+Z8/NfTpPK7cRYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe62thc6h/wnppQADi71lMUVfKU/YQw8lL0bQYy1kSCX9ffPiopd2BZSSVYGLJuT3b7079hhpKsm5wk4noh1lT52sOg21luo5R2fLOFQKm3KKnYdaEtaBk5y3/HrSvsgPAB1PtQT9uJw3Dcjty+ThXvFfCvNZEH56fhL3Btomvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=K0B9k8c7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="K0B9k8c7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872584; x=1785477384;
	i=markus.stockhausen@gmx.de;
	bh=/v477jxGFogne2VF+I/GTTEyVDOS7HCOFPYfuuxedmk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K0B9k8c7hl2ttJYFq96VbWmApU5rzCcGD7e7uQPkxGROLpe8VgmM9JcYYKCguq5L
	 c79+I2vHdliT2l4tUgjQ0Wa9ttHvFjcbnvGRsVPWzWn4Y1GAwDR7kptpsK0hcK2uv
	 5c7C3ZNwXm8RV07YmullH04UBUyY9Ho320sYXP8KXYU3ytfUsN/qTuD6FFc8DQPst
	 N13d3A1NqHoG5yq1JkIAR9ytO+9Wpyt95F7zhME298uOQgql+z0nvPZCBcT5HUci/
	 tT5lzlV6wwmOPmtSlLyuXe0MHU9qJ1WH29tXtkxUJRh+kWjZBDIlrv35j2Gdjz+rV
	 /zOfCr6QYC2kEFSgZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1wQkR92qRf-00Z0YD; Fri, 24
 Jul 2026 07:56:24 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v6 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Fri, 24 Jul 2026 07:56:04 +0200
Message-ID: <20260724055611.1008577-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
References: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eWpJ5TASNu+8IfJGZAiOI7cSkRUe1uaSpRvNjtG9A5JHyGLWzpe
 /JpH1zXlnlBP0KzpdyiCs8loFBlcU5I85Tcb7NXsb6qhsFXyDofrg6zDxbPU5V7mYUsFbf0
 TzEFpzs/wfXDcqbYm0d5apyZIsZKPpOkR/VCn2ODoTdCL2AAY8idCX7yAA4e+MR75paaTY3
 EMMc6VApmDEw4xwgIJUAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TKbaxvZvYvE=;4C5rEPZuOgzZw9fxDSJQN9Pa7JR
 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
 SeyVqaBsnclXkItRhehvZ

The lower end Realtek Otto switches provide 1G only and are divided into
two series:

- Maple  : RTL838x up to 28 ports
- Cypress: RTL839x up to 56 ports

The Maple based devices have 3 different SoCs: RTL8380, RTL8381 and
RTL8382. The Cypress series consists of the RTL8391, RTL8392 and
RTL8393 SoCs. The MDIO controller of these switches works like the
existing RTL93xx logic but has different characteristics and different
registers. Add new compatibles in the device tree.

With the extended compatibility list change the title to better reflect
its scope. Especially add the "Ethernet" tag as these devices have
multiple MDIO controllers.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml         | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 271e05bae9c5..67e0b23a8470 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/realtek,rtl9301-mdio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Realtek RTL9300 MDIO Controller
+title: Realtek Otto Switches Ethernet MDIO Controller
=20
 maintainers:
   - Chris Packham <chris.packham@alliedtelesis.co.nz>
@@ -12,6 +12,16 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8381-mdio
+              - realtek,rtl8382-mdio
+          - const: realtek,rtl8380-mdio
+      - items:
+          - enum:
+              - realtek,rtl8392-mdio
+              - realtek,rtl8393-mdio
+          - const: realtek,rtl8391-mdio
       - items:
           - enum:
               - realtek,rtl9302b-mdio
@@ -24,6 +34,8 @@ properties:
               - realtek,rtl9313-mdio
           - const: realtek,rtl9311-mdio
       - enum:
+          - realtek,rtl8380-mdio
+          - realtek,rtl8391-mdio
           - realtek,rtl9301-mdio
           - realtek,rtl9311-mdio
=20
=2D-=20
2.55.0

