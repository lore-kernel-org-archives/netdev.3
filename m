Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBC3A5436;
	Fri,  7 Aug 2026 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122679; cv=none; b=mY/sVVclCTJ+/8fUO+O8IFN4NP2NdpFf6Rt5REkyi3PDSNfDD4YK75ZsAfArRFLiHTftCi6cmcoo5FFLp4xeXeY51dBeHAdIQfWZU5huf3HtCvX/801U09rI7U+N0t0MTGf4RN6rvNOf6i49FZ5CrjFNAB0HPuD8caw8kA/3ZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122679; c=relaxed/simple;
	bh=FpPBp/kHkdf/TXW2T/6BAncmHi4QMT0QVEBLnKOA2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohXoE9V+rD9AkAtqYu05s+7b6cw41+dnf2Uz612IhgdFJUTo9BkfyffnoFJM2r37aVGFFrvEpDXxC5n/ukXwNt6Zqpxl5KsqfMgK8ZnkDjjgnZBdou3rukqteCJu0yEawWWjbVoxXlm9FRn+HZd9+anVBOFrgSYtbH0Ot6OY4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ATNgd90x; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ATNgd90x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786122671; x=1786727471;
	i=markus.stockhausen@gmx.de;
	bh=+fJAx1fvbvPU0rx3tLqlQteMMicwecZnrOg2PhKNb1c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ATNgd90x6r4OOajwNHoapPlpUxdV+fqSzx6cyOf/Fqtpg2HYo0mTCUgz9TTmIDcQ
	 UCr6f+SySiu9a66Twzo56RRigR6JhERDZosYtMpLBp2EeXCH5Bgs1SiS0jzhHLrRf
	 +2zEroHVD8TLVoez2zkgT/dAznIB3k8r7mGirNYgEgzwBDBoeZl4+HC5c/1+Z1tNQ
	 cCWRzUl/nxZP0EGhYsCo04hMrtL9hHV40XlQC5k4RlPFhtXqC9RN3o58T8T2N1b+x
	 8EV1pNiVJtuyurRn2McoN9xzbKd8DwfOwduWXxcVbapmytjjdU3DCHswpqG6q9Sjh
	 t48dXxiDBYsxw32qWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1wvdnc277v-011yEB; Fri, 07
 Aug 2026 19:11:11 +0200
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
Subject: [PATCH net-next v13 01/11] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Fri,  7 Aug 2026 19:10:48 +0200
Message-ID: <20260807171058.522833-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807171058.522833-1-markus.stockhausen@gmx.de>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTDFEXWV8iHFoLXDPFH2YtEFe9coWyDADmX053QbX9QwX9/BbSo
 5s8SmPw6jT2EJo4gEXMWJcXn6M4diEEohYH7En0z8iZNGR444B45BfT7LyGTJjpNiAPBssK
 C9QPFlDYKdjUAA5xH2F1gRHh6CuNlrOf8scOT1M+tG6Y+gv4ObJkh+g9sZDgLN8qX+KI9Q4
 qv+YOYL2ja8v2EJSzV24g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LA0GSWr8EH4=;SkMQC3hq0qrqD8zj0TiFV/pSJvC
 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
 kvaGSt/MQP4UqvEy8YY=

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

