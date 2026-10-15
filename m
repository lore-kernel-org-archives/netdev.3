Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDA48FF81;
	Thu, 15 Oct 2026 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046831; cv=none; b=hZJYVJ7AnDu+oLPJ3kF5Hx44dAM4vuhVy37xkJlcZUI1AaseHZY+EcB0tomrcBTR0w0fPFILYnUPNg0YLUrNO3PO0fI4ZvtgjcNlbWh20+y3WAZbCvxx4hRxt3Korm1owRd7WUpyWKgNuq4wLnADgHEIsp+fE4ye2iQWZUaz1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046831; c=relaxed/simple;
	bh=PXf2XO3MBhJWRc0IsvS+AKmFUUyFXMPbKU4RplU4KaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tDxszR6GS+6M3yS18LmUMLdDPK1MJFDIOcJPv7coaPcpsWQmkklR9zUR0GyrW+sczpm52a41vODwqd9/3NsisSR0E6JtSmDqfFiM1gHSP4ET5yHTMxkoTZDifRBQK3cBdCI7lKATMi81dP5Ebtah8ToB/y+Im32ftXbm262cJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 Oct
 2026 14:46:59 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Oct 2026 14:46:59 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 15 Oct 2026 14:46:53 +0800
Subject: [PATCH net-next v3 1/6] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261015-support_ast2700-v3-1-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
In-Reply-To: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792046819; l=4101;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PXf2XO3MBhJWRc0IsvS+AKmFUUyFXMPbKU4RplU4KaM=;
 b=QwybckJM3mfxlHN5JXcSeIpySm9FXTH0qpSt8rHtJm2FoBKTB2UiUo922P3hP4C8EWuTHM/oX
 vwxPJCozpSSDh0sWviv4UrMubE6FvmrI9fHCUscc5eBdz/2hYTePiEU
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add AST2700 to the FTGMAC100 compatible list and document that its
RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line for
AST2700 as it follows the same reset requirements as AST2600.

Require "phy-mode" to be present in the device tree when the AST2700
compatible is used, matching the driver's probe-time requirement.

Make aspeed,ast2700-mac a standalone compatible instead of pairing it
with the generic "faraday,ftgmac100" fallback: if a node ever bound
through the generic entry alone, ftgmac100_probe() would set
rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.

The existing aspeed,ast2400-mac, aspeed,ast2500-mac, and
aspeed,ast2600-mac compatibles have the same structural problem: they
are currently only valid when paired with "faraday,ftgmac100", and a
node that bound through the generic entry alone would hit the same
BIT(15) vs BIT(30) mismatch. Give them the same standalone treatment as
AST2700, so none of the Aspeed compatibles require the generic fallback
alongside them.

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

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 26 ++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..0a376b849a91 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -13,12 +13,11 @@ properties:
   compatible:
     oneOf:
       - const: faraday,ftgmac100
-      - items:
-          - enum:
-              - aspeed,ast2400-mac
-              - aspeed,ast2500-mac
-              - aspeed,ast2600-mac
-          - const: faraday,ftgmac100
+      - enum:
+          - aspeed,ast2400-mac
+          - aspeed,ast2500-mac
+          - aspeed,ast2600-mac
+          - aspeed,ast2700-mac
 
   reg:
     maxItems: 1
@@ -30,7 +29,7 @@ properties:
     minItems: 1
     items:
       - description: MAC IP clock
-      - description: RMII RCLK gate for AST2500/2600
+      - description: RMII RCLK gate for AST2500/2600/2700
 
   resets:
     maxItems: 1
@@ -82,26 +81,35 @@ allOf:
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
 
 examples:
   - |
     ethernet@1e660000 {
-        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
+        compatible = "aspeed,ast2500-mac";
         reg = <0x1e660000 0x180>;
         interrupts = <2>;
         use-ncsi;
     };
 
     ethernet@1e680000 {
-        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
+        compatible = "aspeed,ast2500-mac";
         reg = <0x1e680000 0x180>;
         interrupts = <2>;
 

-- 
2.34.1

