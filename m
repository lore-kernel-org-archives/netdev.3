Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0614F0557;
	Mon, 31 Aug 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186921; cv=none; b=IquexZnNds0Nk3lebQE114esBc0ru5nG/cJWv9wEn3lKk6upgPDXEbKS1h2DQ8QmbHpg2iN2zEOcc0dXND/v28q3s5wex/cNJzS7xwQ4ppqM2D3F/dCtHcLUkQBepaj+5uSU7Bxu/1CtflOestpexYcbE0SycMeG3AjjMeoG/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186921; c=relaxed/simple;
	bh=FpPBp/kHkdf/TXW2T/6BAncmHi4QMT0QVEBLnKOA2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKlxvkIuzlZN3I4R8O9lpEaL9VBaKrU1NUCfKOIZiuiVUD4JHyEk/SS0sQt44xzu1hc3grwVReNgzdK9vVGU4Bs/JpsbFqRrClsjhfAy6EegmNFTrYsX2Um0Taz8I+QXT00hyuN6YMF1tOx9vvnnKzwcabTWM0UivurOEt7OzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=pk7Y8R7n; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="pk7Y8R7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186896; x=1788791696;
	i=markus.stockhausen@gmx.de;
	bh=+fJAx1fvbvPU0rx3tLqlQteMMicwecZnrOg2PhKNb1c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pk7Y8R7nwBfz1VEKtKwr0J78IzThNTXQa8jLO06xqIeyf44Qq62uk/M/NeyA4i0x
	 kyHBffyt8uyFgrxGsfCKNJiHU7K6J4pvt+ynLMrfctcyW8MjJwltFtG6+YHdEQLzh
	 5OT5HsKWWT4S3edtQH227rsqJRe6oTttRPZFfe1qPXx+fwz0ummLku/OkSuVg7bW5
	 cOZNjHuikpovp7AdIXSoqDyRGz9RQV3MrpkKxYjjMLLJzVi//AA/Qs6oO/ch7PBNB
	 qA4T8oWvv9chNFlMwsn+FG2YeSQl1RNKkDBD+XA6CJqj08kbbE6Fuy8Bz6ORHdCP4
	 RVnpYq0sYsfsLU2H1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1wQLIg3Gp3-00gGe1; Mon, 31
 Aug 2026 16:34:55 +0200
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
Subject: [PATCH net-next v15 01/13] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Mon, 31 Aug 2026 16:34:27 +0200
Message-ID: <20260831143439.2404484-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJ6Dtj5lOKyTG8uFgcYFs3KkpnmJACmiXJADUphwgAQ52yLrAHL
 Zlwvqdh3SdnsMvM/ro7zLR90oVhYXlyCl5Z8Sy34sAZaZUtSpSy8FbWAdoov0GeV/Mwk3Vz
 TSU4mZ+YY954ql2SwvYBw7RMqE3CFOc/LziL6OqFtopKUH7vZS/a+SptMMSxBvtyFJr6+ka
 nrGCCxhVwTwvSPJ6qZKCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9KcyaR5Ot+k=;9YoKk/En/+cKd3dzzrbXbhFpeAM
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

