Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5F242D9B;
	Sun,  2 Aug 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659764; cv=none; b=jt2qmr3Le16r47Qrpyr+pda37AY7fx2/y/Y3UsBY3yIT+btWgckXH2UEBVkpbEEH/Ak8uzP21aRrEIFJjEZI00qny31lXvpssEzmEbfQl21QVd+cAd10+hlRSQoedmfRl9KpcDEmhCDXxzLiDEXaLxLuUvjcrdf3FaZMIqwtLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659764; c=relaxed/simple;
	bh=FpPBp/kHkdf/TXW2T/6BAncmHi4QMT0QVEBLnKOA2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVbdavNTocg9hdOIFVveza8l8XGnjIi+40akA9Uvf8jSf5r7oRH3nCxZzu9iATUZKZv1tT38Kv006y6cEP0d5/38/OXCFJp/nJhqZh7XddKnTOimzLGvtzBHBcJ3owwjaaYlZHljgTKwDo/RqbOqShiAx4TNOiyj/f854EmTcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ivObkKc3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ivObkKc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659744; x=1786264544;
	i=markus.stockhausen@gmx.de;
	bh=+fJAx1fvbvPU0rx3tLqlQteMMicwecZnrOg2PhKNb1c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ivObkKc3sAua5WWjTZp4GjdaUiy+BH+FEDjkBl6JtPbPZR3lNXLdKepdSRwbgmDv
	 bmin1U2t01TtvzmtjFcXhH+8X9OwLBLqFGEqwtQlgeMSvcBugAKszLH4KD+bIpNV/
	 v+NRqgB0NISebup3WpDwYXvmSwi1QtUttqQwk24N2JN99Zc8eKDL1N1iBrUD1zV7F
	 f8t0IkHo82sDua0R9SZZ9O35JoiqzC2wuO9v7rE6Ue3CAgluwA7c4JUEob55G1gUz
	 PjoqzMrVn8EjEMdy2UhcdQKc/KPVF5VLvPNoNgWix+oNgjJkMZk1eYyjPrEk9h5hS
	 Q5uvngRoyQf5bsKuQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1wMrYi0pq8-00S9Eh; Sun, 02
 Aug 2026 10:35:44 +0200
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
Subject: [PATCH net-next v11 02/10] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Sun,  2 Aug 2026 10:35:20 +0200
Message-ID: <20260802083528.490216-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OeMemhz4hrxSrsssdfhQ6Xo/475OXbdJB8srfbvhLc00E9dALvr
 LP9Qrv41ocBU4xGiBtac0KvUK7tlIfBC1tfI93VnOYq9syvbGNPefYJNLO2UrYqrHo/ibkK
 3OSn2PPC8QEEuJ+ZPxXmFC6DsoBT7K/SWMUUqNpL7Rfj9r11OQegnQNnCsTOC2HgwDKdjXP
 NKLFc03NRFAFiF4NaiKCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s5TXIJ4LO4g=;OQeNwoslmDPqHNdJobt1jpVXVJC
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

