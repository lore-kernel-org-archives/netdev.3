Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472760;
	b=ek8iKNUwJBV3+zrxUqn7fACDQKzWKTzTs1+eMmNwI+j2OLRrLyKTXbx+QAg2rOYbQuvt
	 j55tLAEyvSr1a9b27q73pqkzFL7tIwiqHaY8TvDFeeYJ989PWa9vRjRDyn6dUp/cVY/xA
	 xMvbGjh68d4Ih86tAdA/WDLi87KYiKs0n7tIrYGuLqk+PCQCDwSkEF7+gc9o00FnFty/B
	 hrBccpotXKyPdkGqcHxOrM0VKfj3pVlkOz4OlPW7n3j3lYibQvBzdjVOhYCUwHu4h5ddB
	 favda4sb+QOhUWT9R4PGMFmDqX2t/YY4Kd2Y6NFWlOgda5H02uZzBl6F/55inu41PLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472760;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2RxUdAyVdSwRgSZWlCZeRtYQ8ANbZoRIT48fGOdPh9k=;
	b=Wjp3ZKqmfk/OCdVuzFi/YLL8gEAicTI9n3cbg+I07UTNSqZmWDEWSXbI3nQJbDZ4PQOX
	 eNOWGjD+pSqTcIMXQgA8WepzYJczmKuRUIZnEau+b5AKlDnFo9vH8a9C/sO/ZleTrBi7c
	 VMITQo+tfCrH61zemGhv9QSKETH+/6uIKBhwlIyDnxVNaQeq7StndgI0+kX4txQe1A0dr
	 oEScDmR5oXm/8cyAmtmT5PCBS2wJigzah9L5pOkoWSxBdOUTxQd8qA3A++lbav0ny/WDq
	 2W45qzhoX1dGnP+18kYHio4YRZ3r+BCb/epDjukdVyvUFf9hfoY5BK6GAUEUJmADPTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F64606B241;
	Thu, 12 Nov 2026 08:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F64606B241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 16:39:08 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 16:39:08 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 12 Nov 2026 16:39:07 +0800
Subject: [PATCH net-next v6 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
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
Message-ID: <20261112-support_ast2700-v6-1-238020bf46cf@aspeedtech.com>
References: <20261112-support_ast2700-v6-0-238020bf46cf@aspeedtech.com>
In-Reply-To: <20261112-support_ast2700-v6-0-238020bf46cf@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472748; l=4637;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=y2/7dHAFpz+HzURl/lsqkis0My8D3WV1bMFE28qKQ78=;
 b=43xy9PKOInSbIWiupaGeZaLP6V6FaISm4bWuBfvzxZbEXsMKyk/sO63VJUGltiJsMOjn9I7xI
 /BU6uzzEIVADs+O/FLvDB7FPRL5rIwKOPvSNcEpfCcpNjeOZ5RIvJ9I
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
compatibles are currently only valid when paired with the generic
"faraday,ftgmac100" fallback: if a node ever bound through the
generic entry alone, ftgmac100_probe() would set
rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.

Make each of them a standalone compatible instead, so none of the
Aspeed compatibles require the generic fallback alongside them.

Now that the Aspeed compatibles no longer need the generic fallback,
also constrain the clocks and clock-names properties per compatible
instead of leaving them generically optional: aspeed,ast2400-mac takes
exactly one clock, aspeed,ast2500-mac and aspeed,ast2600-mac take one
or two, and the plain faraday,ftgmac100 compatible takes none. Require
clock-names whenever two clocks are listed.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

---
ftgmac100_of_match[] has had dedicated entries for AST2400, AST2500,
and AST2600 since commit 03a2aba50b2c ("net: ftgmac100: List all
compatibles"), so there is no known kernel + devicetree combination
where a node has actually bound through the generic entry and gotten
the wrong EDORR bit. This part is a binding correctness fix, not a fix
for an observed failure.

Note that arch/arm/boot/dts/aspeed/aspeed-g4.dtsi, aspeed-g5.dtsi, and
aspeed-g6.dtsi still declare their MAC nodes with the two-string
"aspeed,astXXXX-mac", "faraday,ftgmac100" compatible, so this will make
dtbs_check warn against those files until the redundant fallback
compatible is dropped there as well. That .dtsi change will be sent as
a separate series through the Aspeed/arm-soc tree, since dt-bindings
changes don't go through that tree.
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 71 +++++++++++++++++++---
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..9d352e3686aa 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -11,14 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: faraday,ftgmac100
-      - items:
-          - enum:
-              - aspeed,ast2400-mac
-              - aspeed,ast2500-mac
-              - aspeed,ast2600-mac
-          - const: faraday,ftgmac100
+    enum:
+      - faraday,ftgmac100
+      - aspeed,ast2400-mac
+      - aspeed,ast2500-mac
+      - aspeed,ast2600-mac
 
   reg:
     maxItems: 1
@@ -88,22 +85,76 @@ allOf:
     else:
       properties:
         resets: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2400-mac
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+      required:
+        - clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2500-mac
+              - aspeed,ast2600-mac
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 2
+        clock-names:
+          minItems: 1
+          maxItems: 2
+      required:
+        - clocks
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - aspeed,ast2400-mac
+                - aspeed,ast2500-mac
+                - aspeed,ast2600-mac
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+  - if:
+      properties:
+        clocks:
+          minItems: 2
+    then:
+      required:
+        - clock-names
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
     ethernet@1e660000 {
-        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
+        compatible = "aspeed,ast2500-mac";
         reg = <0x1e660000 0x180>;
         interrupts = <2>;
+        clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
         use-ncsi;
     };
 
     ethernet@1e680000 {
-        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
+        compatible = "aspeed,ast2500-mac";
         reg = <0x1e680000 0x180>;
         interrupts = <2>;
+        clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
 
         phy-handle = <&phy>;
         phy-mode = "rgmii";

-- 
2.34.1

