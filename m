Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150049;
	b=tLEIF++rxSbXhdUYVmiPToiD9z+u4pUWmTsZsmRy3CXim0AtkqxFePlSnP4kFK2OoRKY
	 h3kbL/Aaxhu+SoMQJ9nlkhUTUhn4fZ3Kl3s8zgcY1xCZcrc43Vz+4q+kVLpTS2Nani6Il
	 1+jnaNd4Kze3vL9mwmUz5aSvLLe14T7orwuLDT29ScIce8Gxzk+LSHnWkjB28CdgRcNq2
	 Ucz+wtmHOOxkHAQG6KVaGNVgf2WIUwsG/dn+hfJnIAuOWUlJCpTwTncVDQlbHXFOLjw3C
	 2er9FtmUd25f2c5Fhu9WZ3w2Ej3Kt0VnEGJJbBVFVX2XqKZY/bAgnNHkOI+1HwmB7vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150049;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=7mGz9c5j7qfN9eG7dQvgcA1AagbKKPWBpRjHm9HlsGI=;
	b=j9C3exCSYi/DeadHtodYA4evvONQoCDZT1x73yZx6NF2DzxPJCgEYeS+ozql8oaWGIZp
	 ijdy8UFjsQLT6FgXpAG30tnDlxV7rqFcirE28UKVEEZYiqHMOkV+Fqyy/4MF4HVHqbDY8
	 jyz/x4mKZX8Upo/uR06UPIC+JMIgK76c5XmJX300zEz09s+h753WUmFxHnQQMKM+k4A5L
	 Pg4XtHTFMPQfGUtnuPeFJ4zUezb1KL6jL9ulJXBRq+qJs6+IhdnTbJLdrjAadRUOI4FwH
	 usuydsQ1JqiOtRb9SQayDZS3D45/NEnOCNVH85s1sc89a86HzWJgV6B9ZPZpBFxJrGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=GJZYhmSY;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A55606A33C;
	Wed, 28 Oct 2026 01:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A55606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=GJZYhmSY
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A984F149C1A;
	Wed, 28 Oct 2026 02:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793150041; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7mGz9c5j7qfN9eG7dQvgcA1AagbKKPWBpRjHm9HlsGI=;
	b=GJZYhmSYRjjyoGnMF5kdYoVuMhzyOS69YSS0y3gevYYqkdxO+qoOOLsi08Qt2dQNU2CHgR
	AAxR7rSUr6mDNeAdbzOW2CyR+Ag++ccyEpDDahEfQi4reotb8bZX7K5qEMuCK/Y8bkCp16
	HhdPYZg08OOtTxsN9n8zmDRED4uUTtLqLjK89Y5u0n2voNm8LD+69c18D7AXxUEUgVj+BE
	wbv/ijayaz9T2fJwvDa/kIWefmHcNRGyUCNRyEucLIylRHBAnFqFrCUX5yfKHC5XA2OvcT
	hPKUR5zrx1EsbirGzAO5E7cNC+KnewaN9+EMMUto7XIH+ReAFgF3glatWgoSGw==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	linux@armlinux.org.uk,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v3 6/7] dt-bindings: net: dsa: mediatek,mt7530: add econet,en751221
Date: Wed, 28 Oct 2026 01:13:16 +0000
Message-Id: <20261028011317.1557238-7-cjd@cjdns.fr>
In-Reply-To: <20261028011317.1557238-1-cjd@cjdns.fr>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EcoNet EN751221 MIPS SoC integrates an MT7530 switch memory-mapped
in the SoC register space. It is similar to the econet,en7528-switch
except that ports 0..3 are 10/100 only, port 4 has a gigabit PHY, and
port 5 has no PHY, but is in some implementations connected to a
downstream MT7530 multi-chip module via a TRGMII link.

The downstream MT7530 is similar to the MT7621 multi-chip module and
has all gigabit ports.

Add the econet,en751221-switch compatible with the same constraints as
the other built-in switches and also add the econet,en751221-gswitch
multi-chip-module switch whose port 6 is configured as a DSA link port.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 .../bindings/net/dsa/mediatek,mt7530.yaml     | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index e29fb8693498..b73732d28d8c 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -29,6 +29,12 @@ description: |
   and the switch registers are directly mapped into SoC's memory map rather than
   using MDIO. The DSA driver currently doesn't support MT7620 variants.
 
+  EcoNet EN751221 SoCs have a memory mapped MT7530 with 3x 10/100 PHYs and 1x
+  gigabit PHY. Some EN751221 chips such as EN7513G and EN7526G have a multi-chip
+  module implementation of the MT7530 as well as the on-die switch. In these
+  packages, the multi-chip module is connected to port 5 of the on-die switch
+  via a TRGMII link and allows for 5 gigabit ports.
+
   There is only the standalone version of MT7531.
 
   Port 5 on MT7530 supports various configurations:
@@ -111,6 +117,14 @@ properties:
           Built-in switch of the EcoNet EN7528 SoC
         const: econet,en7528-switch
 
+      - description:
+          Built-in switch of EcoNet EN751221 SoC
+        const: econet,en751221-switch
+
+      - description:
+          Multi-chip module gigabit MT7530 in EN751221 SoC
+        const: econet,en751221-gswitch
+
   reg:
     maxItems: 1
 
@@ -160,8 +174,8 @@ properties:
   mediatek,mcm:
     type: boolean
     description:
-      Used for MT7621AT, MT7621DAT, MT7621ST and MT7623AI SoCs which the MT7530
-      switch is a part of the multi-chip module.
+      Used for MT7621AT, MT7621DAT, MT7621ST, MT7623AI and EN751221 SoCs which
+      the MT7530 switch is a part of the multi-chip module.
 
   reset-gpios:
     description: |
@@ -223,6 +237,20 @@ $defs:
                 phy-mode:
                   const: internal
 
+  mt7530-passthrough-dsa-port:
+    patternProperties:
+      "^(ethernet-)?ports$":
+        patternProperties:
+          "^(ethernet-)?port@[0-6]$":
+            if:
+              required: [ link ]
+            then:
+              properties:
+                reg:
+                  const: 6
+                phy-mode:
+                  const: trgmii
+
   mt7530-dsa-port:
     patternProperties:
       "^(ethernet-)?ports$":
@@ -330,6 +358,7 @@ allOf:
             - airoha,en7581-switch
             - airoha,an7583-switch
             - econet,en7528-switch
+            - econet,en751221-switch
     then:
       $ref: "#/$defs/builtin-dsa-port"
       properties:
@@ -337,6 +366,16 @@ allOf:
         mediatek,mcm: false
         reset-names: false
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - econet,en751221-gswitch
+    then:
+      $ref: "#/$defs/mt7530-passthrough-dsa-port"
+      required:
+        - mediatek,mcm
+
 unevaluatedProperties: false
 
 examples:
-- 
2.39.5

