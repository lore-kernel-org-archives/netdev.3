Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F437AA8B;
	Sun, 26 Jul 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050311; cv=none; b=rhK5+k53kFuR4FbXnbbX01f71xOu14Dn2M5mtgZmSY2Xgxzh/xFKdLHhdABw0BpZkMOjv7vLKA1uXtCTL5CYol0d/bIjM6tCwExSFn4a8r9UFP6rKszJAmZmoV/NM/2RWeOiJVFVTY6dZwfQgJBAfdagcclSZ4IvhmdE9tXFsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050311; c=relaxed/simple;
	bh=7XF7MAFcn6wmhhyC+2PeG3mULjc+Z8/NfTpPK7cRYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptkopu7OT2V/RXc3V0rzEeAAUo6L1ZjDKFHYTgWS/gw0s+rhjurJj62WDoPEE3S85n+qdVpC6gCsAhCTO5+7KCgIKxiZxQ6j80MDBQaI1phQsR+Cw7r8l6NnJzKoMjmwMlcJYke+89WUwHEhlwFsWjYjAmMX6sVUHoyPF838cjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=TflTbYbg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="TflTbYbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785050288; x=1785655088;
	i=markus.stockhausen@gmx.de;
	bh=/v477jxGFogne2VF+I/GTTEyVDOS7HCOFPYfuuxedmk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TflTbYbg+XQ01sI4ZdmM0hfCDFZaRa9gT9IYducr+LNP7PrUP/O/IOnpHg6l01Nt
	 TbxmfXeGSQT9X3mB+NOnniCYzjbpvD4mgam0U4a4MdL8AH9cTa04wJgRjH0k8VPRq
	 r5BYH4DouhQ+/WyFL+ir/dwMvpXwIGidfJ7/Lo6tr5FyLdxupWbl+ESet4ZwgR7Bd
	 CvU2GSCMkn/ptaA2aUt6fu/lwdrhgPC1iA5WZOhsD4MiHYSTBbN/50AeJcdu4p0UO
	 NbvXMrg/VpmM5q2fovnx15RqJKjX2GQ/Pus3Wio8FYBzG3a1jbIcufOwGlBmQURQH
	 qZzKJ9MTtzlLZ+F46w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1xOslS3iWn-00pqTX; Sun, 26
 Jul 2026 09:18:07 +0200
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
Subject: [PATCH net-next v7 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Sun, 26 Jul 2026 09:17:44 +0200
Message-ID: <20260726071751.1359156-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
References: <20260726071751.1359156-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/myO70W5wnThRGTJOdFl03nynkKSGRPY8EluFQtqkD0HtDn/OXP
 YSigI+3lBi5WKisBIkjYRB691U20SumHZKYNraU7Oc19lAn1+TTitCIYLDx4EnmsVUxvDat
 Js/13AV898gb/n1GYZfLiWLCHG2cCunrNrbzjOiEHBIi+Anc+XDRptWjNjky6VvHNi4dL4W
 +KOzu5Y9CKz2bO4EySDmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e4YluDzUIeo=;koJkWVAMEx3rWM5zhQq0pOM2ayz
 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
 2hk9T2R61XtWzQkrrDG62

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

