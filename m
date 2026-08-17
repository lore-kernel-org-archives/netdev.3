Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335244E654;
	Mon, 17 Aug 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984032; cv=none; b=tSgGHNycx1DVNJhaY/JgcedYQNLEASibHZSYdH1H3EdgTe/xr1uDsiCT7aLUgscrL6B96zpRfQ9UaQbHf3uF/OPihx7g1vNOy/bVi1CBFu5BESqW1Nq9n3d2ensxpaYGf4bFyAVZDnKIgOv9i/KRFo0Wev+bWrA6fHjzqcb35jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984032; c=relaxed/simple;
	bh=FpPBp/kHkdf/TXW2T/6BAncmHi4QMT0QVEBLnKOA2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmzX9JTPAUWRnTT8gSbmD9OaaHIjkQeQmRUU/1ynNgw0G8O9Vrz74esR5Aa465bi6gBkclARV03Tqp1072jv+rAuGw4X6CCtxlPpGlPOX3dU08qhfhmKRkhX5sgiwRxDVgvh1pNfpfJHUMeCyKHaWsMH4G0+zj9++rcgUBeIr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=oukc8xHt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="oukc8xHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786984009; x=1787588809;
	i=markus.stockhausen@gmx.de;
	bh=+fJAx1fvbvPU0rx3tLqlQteMMicwecZnrOg2PhKNb1c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oukc8xHtJhuX2e4asN/+SIR2pMNbDtYcsDbpDcCtkU87eKNeNXSkYhoydD8VnaxV
	 SfGsmpfgv6EKw/viRbpI7b1EJQ1mU9Lt9culL0iSxuOP1Kvv6io+oloG4AsZUxrln
	 /RdqE4xsJfGYE/0SIpp9pfafiLHlAWyaSC5Z+QIhgYyMzfD63K2Pl/f5Ok6LI9jpG
	 8kgd4zPpJ916hwVsj/iJkMALgU+da99hbBfOuMMVSSJwYh4WWdymxAkDMDH0xwbaf
	 X8hYGkibvC1vz2FQP4lNlgMucceMQYEBSCg4vuU7qfmiSUpe3BtsUYLaf6vZGED4A
	 FXQRsM1mbyfRLSYhvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1wVyd40AQp-00orJz; Mon, 17
 Aug 2026 18:26:49 +0200
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
Subject: [PATCH net-next v14 01/13] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Mon, 17 Aug 2026 18:26:20 +0200
Message-ID: <20260817162632.1208891-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7XPb05bMQYBz5sVo/CCrcri/M7hTCr1ipwyt53rGLO8wXhK89qz
 sIzE1BC/IVIIaoWz+QW2V3m4tSGLrtwL1Az+yjzRK7cu6VsyP/Otf4PVfmuTG4gOOGkvOQw
 nmP0XsUhbD8n/YZOWam1lETpi3Co+YyY5bCwE7R37k3VpdkqIBCfV/nsyyxUWjBUHN5w5SN
 NSCrvS/tt6mzGxBvLJdPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bjjkTknPHWU=;yQloqzXPWtMWc37SziGNDFTu0fC
 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
 Soj/WhsmkFXBZpXqKts=

The lower end Realtek Otto switches provide 1G only and are divided into
two series:

- Maple  : RTL838x up to 28 ports
- Cypress: RTL839x up to 52 ports

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

