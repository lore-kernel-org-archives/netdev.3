Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FE3C13E0;
	Mon, 27 Jul 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179802; cv=none; b=Hv1FxzL9dHIzK3psYuwrmjHt7tgxLWhng6KbX0pPzRjL7eGrkUb578Cs7vSChWBoKGAPzMuYZXu0B6WajPgYsuWRHjXiTaLPaonKNu4YEHok/tCyY4g+Ecc2uHMPTgsjAOqIdxayOMNMMIXZD+0dsayboFkc7sWEndD9URSjgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179802; c=relaxed/simple;
	bh=7XF7MAFcn6wmhhyC+2PeG3mULjc+Z8/NfTpPK7cRYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdM4GY9VRkZnkoiWENPjmX6WA+u3kvfUu962GbSarTx1aWK8BRq4SaU0oixdtKRFO0mlnbu2U7ZahXmQ28c6jJkhNQcHc+QHFTmRk1hihwX5Q/uBD6jevAaOTZrt8s/PRoN8f6XQXRVY89djKKuRG8NzeLZhylx/7lGwyNoFdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=cxTnSK6V; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="cxTnSK6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785179772; x=1785784572;
	i=markus.stockhausen@gmx.de;
	bh=/v477jxGFogne2VF+I/GTTEyVDOS7HCOFPYfuuxedmk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cxTnSK6ValAYviDzviaMTJ+ovlWZkFOKulV68fzWWCIH6aB+RL+IkLZN2iGI+D1+
	 NHCzGA0ogH4dxwGoKBP43ch+eUmzeyHCqcaMxaWCdNNmRTwDd8eVZHGrhblVHLQos
	 JJgd2Mx9RsSpHGy5iFijl5TdqFRe+Li25XvhHU35YY4EhNEUHJwi5USCF2axQczh5
	 J/TSnGlw+yDcykYWuefy4OL2lGbXT0oqt0r/Iu4YwFfuY5rN7Zf6TMtTPKpIBn2Cf
	 XaqrahVGTRdjuYvMbjl2CfZNx033yEOZPu9AOiGH5CvQJS7BlZHaROTGIi/zgNmgP
	 z/wbZo+5nO9tgpANDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1xG1W31R5H-00hKt2; Mon, 27
 Jul 2026 21:16:12 +0200
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
Subject: [PATCH net-next v8 1/9] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Mon, 27 Jul 2026 21:15:51 +0200
Message-ID: <20260727191559.19617-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727191559.19617-1-markus.stockhausen@gmx.de>
References: <20260727191559.19617-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KrddehAlKccXJg1O9WIby3PGUbRA8ifHtkaFiVdMWT2Phu8FqK9
 E2ykfKLyfnq0cCDINcO7+knDxfVv3Z4a6SI5cd86YeTsdm8J9uB0gPBaFDw7RF5tBBwaQjb
 OryMvko1PYKtFKseGZf/uaRDLxJqFTpcuIsExDnCIo2xRnt8xYPNaQjbeHjOflDxGMiQaIP
 bNHJJrhg8+QQrhRZlI51w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wOdM6Xhmwoc=;vBAFGh5NMEtv1A+xeLIm6ZCKEZh
 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
 blxW829CMsoPDrstg/Ly9

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

