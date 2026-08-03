Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBA42122F;
	Mon,  3 Aug 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777582; cv=none; b=jTL316Pz3xJKZZJVW/pgd2cQG9h7EZ8mopaTh6TKA22LUA2TNHJSzwpq2DBHWZvnvLAG0lbbboQeJjFejZOdMggvmD130k9P6+1OU9ebEf//maHyVZZ92NJndyKd0Ni4bVsJncggzIfbebyCGQNP4wxU7Z6pcdwyS5W11ZNjFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777582; c=relaxed/simple;
	bh=FpPBp/kHkdf/TXW2T/6BAncmHi4QMT0QVEBLnKOA2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBbRBwl1EesDLc5V6rGeItiiQKIcPrfvvKz5h7KpJmoBOBnr/2sdwovSAosa8Yyhwo7SC3+avbZR1huLdE+F76iN/k1OxQWSUIfEpA1f4EDhGG64rugM5QUEVEJZMZtx3/4BRSbs0APJvx64NhG/QO2HeIu3V3CmWMdeWsR27gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=q35WseHl; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="q35WseHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777551; x=1786382351;
	i=markus.stockhausen@gmx.de;
	bh=+fJAx1fvbvPU0rx3tLqlQteMMicwecZnrOg2PhKNb1c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q35WseHl0LoaJHUxJLW+2KZ2kBpH1scMu8YvVF3Bd0/yUanffXwAa8FBIJRcLRRa
	 vJomGJg/SGSPvGsRrG/grqKUu/8I5BHNkehBLUJuzt6LC+wvcCr0F6HCAvMQ/RfZm
	 54xAFZYbM5i2RwFbHdylK4lHLNA0cPVQOhZjUgUKAO8X5EKL/X25M96YesRTCndeW
	 tppOiQmgYAzCR5yTWGDQtsxKi7N8sXShBZTbe32ohS7bFEh+4c0Ex7faSSMAi+fEn
	 EN0Q4x0hO4Cjl1taHtE6cEfQhqCYH3d1XE6zeMVa3PSW0daitf6ufCRsIrHuzwMZB
	 o7JbjAHWiBOMxuHbLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1x3PEW46jG-010u8w; Mon, 03
 Aug 2026 19:19:11 +0200
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
Subject: [PATCH net-next v12 01/11] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Mon,  3 Aug 2026 19:18:43 +0200
Message-ID: <20260803171853.507506-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:suV4b5a1bG80Aa0yZn/Ycx7ohv+s/2DTj8gEO+IVDFmX7uyF7T8
 bgK5bP2xpIPGaTadfbO2jRH+qh2EFuzccEJ2YrdrT7z3g41NJFIYFJWhA3Pf+nqxGAowmaa
 Y8jvdMHBUczaamT8oBQGCi0E4QaTyuSyMvpI5Sv3+QoAC2HE1an5Q8xnEAIi4GWIeTZKWfO
 jo1Glb8nLXGYIbRhRu2eA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XR0K4ey28es=;ulm5fFfAy2h3R6qp7afTTueA4GH
 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

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

