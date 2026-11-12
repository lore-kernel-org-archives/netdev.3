Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472760;
	b=feE9xMInoa8b3dSSiV4SK8rws6j7hcjUXs2Gh9mu76ZC90ZYaOicIDPAE+RW1IZVNKjB
	 yEzN1T6+4bnDpPeSQKx7PAyTUljtgAN0DySyg1h0HyG1+gl0g3/X8iFAh4RFlwomYWP+X
	 DkT0eOT2o72zKCLCEZkLr7Gwh6V1dv7tmf9Bmpq+zx7XT9ynsvnLNDQJJaAB+akLlGrEO
	 ZQ4rkpYOba9X9QiNjU6FKRfqBadIUCKUZovGRGkI0U17AcZJMTtpJaA0D3WUKFQnfH/Ap
	 Y5eMgyPYc3rDX/tqklS44G17Te2i7Sx2EM/BdmAkY/Yvd6TDutPGsbb+pVADiSThWMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472760;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rZR8cQuwm55RyNWc0AN8ri0/dkKM2LPB6ffT7kd/zlE=;
	b=f1z9f6SxxWNbgh9a/HFfjbNYHUSdP8ZN85FR9FnwTG4/mTo/+V3gAmDPGaRg1zNM7HDL
	 JVRpB7lNpupASjNFTxT8RfpM6eB9dZ+opJSHACnBt47seW7zhcOZQu2DVMNKuj2tYhKpU
	 Kg7gLVByptVdgDTFLfa+J9P8ZsWXOPPE0Vl/clF1HvWcg3m+nEt5RphJ7f9qyGdieUciJ
	 5/CbB+2NfHi8NbjSkqyF5qMn+djanB1N3sENJa749OilNYRvqkTmLFIw0C6Ag/WAIZZMj
	 FNC4CSJsMLnGzvO//UekVGStGNpnAsHJj8BX7NDD5ltY+BvVu0K7/tgeXCO7HzyMYUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB1606B249;
	Thu, 12 Nov 2026 08:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36DB1606B249
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
Date: Thu, 12 Nov 2026 16:39:08 +0800
Subject: [PATCH net-next v6 2/7] dt-bindings: net: ftgmac100: Add AST2700
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
Message-ID: <20261112-support_ast2700-v6-2-238020bf46cf@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472748; l=2464;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=cnjMloD4cGC19+VX7doc5SC+7rPxEzfRFMfrrkrbMdI=;
 b=kPQa+tvZD2rMz0o1aOWRDrDJCGjIBAzjoim+9wHcHSuFWEeCVD2aWTGt203ngJgiVo55vFhPg
 16WLEXBBKkwCrMd0eMsyJWodTvnS9yCXvj/t3fhqn2bgQO26mvy6oJ0
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add AST2700 to the FTGMAC100 compatible list and document that its
RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line
for AST2700 as it follows the same reset requirements as AST2600.

Require "phy-mode" to be present in the device tree when the AST2700
compatible is used, matching the driver's probe-time requirement.

Add aspeed,ast2700-mac as a standalone compatible, consistent with
the other Aspeed compatibles.

Extend the per-compatible clocks/clock-names validation to also cover
AST2700, since it shares the same one-or-two-clock layout as
AST2500/2600.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml         | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 9d352e3686aa..613d4f1caa4f 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -16,6 +16,7 @@ properties:
       - aspeed,ast2400-mac
       - aspeed,ast2500-mac
       - aspeed,ast2600-mac
+      - aspeed,ast2700-mac
 
   reg:
     maxItems: 1
@@ -27,7 +28,7 @@ properties:
     minItems: 1
     items:
       - description: MAC IP clock
-      - description: RMII RCLK gate for AST2500/2600
+      - description: RMII RCLK gate for AST2500/2600/2700
 
   resets:
     maxItems: 1
@@ -79,12 +80,21 @@ allOf:
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
   - if:
       properties:
         compatible:
@@ -105,6 +115,7 @@ allOf:
             enum:
               - aspeed,ast2500-mac
               - aspeed,ast2600-mac
+              - aspeed,ast2700-mac
     then:
       properties:
         clocks:
@@ -124,6 +135,7 @@ allOf:
                 - aspeed,ast2400-mac
                 - aspeed,ast2500-mac
                 - aspeed,ast2600-mac
+                - aspeed,ast2700-mac
     then:
       properties:
         clocks: false

-- 
2.34.1

