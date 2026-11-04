Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769255;
	b=gWkavO1OsgA3QwwHpv7Dg6qLWCnCOkp+iK0f3TOuYCp3yOFteDDzAFtRilDrnkf5l/wv
	 fXpGCWHvRU4objuY6H43q+ywsMHRYhQRerKc/DUCcJ8GYVQXPV+4JhdcqdYlvt3avhl6A
	 Hi8VFT0J80WBpRDE7TvMkdiZgZdYm8gzedZaEGLTheyGbnJXt3A0EK3KW8cp5mNpS9ErB
	 cImHIksDcJMlV2EFQ4P/kWhxHLIe/wnnsBK46qKEY5obQdyk30CckBMgPn84140k8cmCg
	 An93xLqJZq0mKA5wmK/mSHFpsRrhyexEZVstiYYaro52+hHypWOyvlN6B3+I1PmZR3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769255;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=P8+jAXau/Bi0wos+mJ2Eqb8cW5DkPhqbTg/6gv3WuHQ=;
	b=cdgIlW5bhp/eIMGeul40dHFFiotsh2fDnfSu0CuPd8NZeEZHCr8ETKc+K5YQiRvIFwpZ
	 AWbXwmxprsqZEUiOTxMvxsn+s3h8FLqSXtWVeYJWSI5b2xGE6xtqpLSXzDRb5X6B/AvP7
	 SeQnmPBwQ3xUy3VmMvJ6rXzMXIin8gYxobgGs4RfPGZD37REVj9NNuR5WsYmHJYC1qhXf
	 HXpz50WhNW1Le2CYKVMt70TKHeGCO/MVJlRBN7nMS3Ginr/zzrF4OxmM7pB4/lu875yGN
	 vaRZLejsv40qWiorD+7SEQIiqwHZmj7BJt/xWPn6M3g/HgBa/GY/zbiq7//JrdePyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD03606A334;
	Wed,  4 Nov 2026 05:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFD03606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 13:14:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 13:14:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 4 Nov 2026 13:13:55 +0800
Subject: [PATCH net-next v5 2/7] dt-bindings: net: ftgmac100: Add AST2700
 compatible
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
Message-ID: <20261104-support_ast2700-v5-2-44057f4dde75@aspeedtech.com>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
In-Reply-To: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793769249; l=1916;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=5qANQSIovmy+Pbyb8pie3VdsuBQOVCAKP1ZjoCqetos=;
 b=0ANLizeKxw/1qP3KNLmXwOzfouNf8oIgzNValW7l+M5T2m7Z71c5OBS+q/WCWAFO8wv7dVhVu
 Z4kUPHuM7PgDgleJnBQB6LbNJZiChpPmDGUg7FwmWxGrSPnV2LMx6gw
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add AST2700 to the FTGMAC100 compatible list and document that its
RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line
for AST2700 as it follows the same reset requirements as AST2600.

Require "phy-mode" to be present in the device tree when the AST2700
compatible is used, matching the driver's probe-time requirement.

Add aspeed,ast2700-mac as a standalone compatible, consistent with
the other Aspeed compatibles.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index c870dd0bda7b..0a376b849a91 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -17,6 +17,7 @@ properties:
           - aspeed,ast2400-mac
           - aspeed,ast2500-mac
           - aspeed,ast2600-mac
+          - aspeed,ast2700-mac
 
   reg:
     maxItems: 1
@@ -28,7 +29,7 @@ properties:
     minItems: 1
     items:
       - description: MAC IP clock
-      - description: RMII RCLK gate for AST2500/2600
+      - description: RMII RCLK gate for AST2500/2600/2700
 
   resets:
     maxItems: 1
@@ -80,12 +81,21 @@ allOf:
           contains:
             enum:
               - aspeed,ast2600-mac
+              - aspeed,ast2700-mac
     then:
       properties:
         resets: true
     else:
       properties:
         resets: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2700-mac
+    then:
+      required:
+        - phy-mode
 
 unevaluatedProperties: false
 

-- 
2.34.1

