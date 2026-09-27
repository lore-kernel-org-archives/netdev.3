Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A23BADAA;
	Sun, 27 Sep 2026 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790493694; cv=none; b=FTIE59zYOziu87e242Zs2Kiw+pUz7RE8sarOBRzCWrh6FfDDUCVQLpgTHBXynY5YAWa+4qtylSKx6kgcINy+kCZBQF/aDo9OqXxt2gSwmwsj4z9gWcT5k66U2r5zozNnxb+0ZZKyEh1uscSDvdd0nRNEp3iHma+dJEQnL0tcMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790493694; c=relaxed/simple;
	bh=URBUGbAXYAZQZX39zDVCIRVdQ5TIw/hrHjDr3p8Gnfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K6Z9DrAgCpNOUlXMVRfceg45JY1rojene97yP5pBNadK3SGtB1sIs3IsHPVa9OkVFJV3Fwy2nqiiMiL/ZTKwdRnoPeuShoEdqHAnuV8lKUok8PycFD1s/JiYIjyc6wQ1L8QUQaIIs6VndWqILUUf1sH+QrCUSEq5NOoxHVMYxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 27 Sep
 2026 15:16:21 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 27 Sep 2026 15:16:21 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Sun, 27 Sep 2026 15:16:20 +0800
Subject: [PATCH 1/5] dt-bindings: net: ftgmac100: Add AST2700 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260927-support_ast2700-v1-1-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
In-Reply-To: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790493380; l=1393;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=URBUGbAXYAZQZX39zDVCIRVdQ5TIw/hrHjDr3p8Gnfg=;
 b=xeuAK/TJJlwotFj3GZ2ZT/cOjDi1qR2l4Z38sBJYNXw2L3hV5ene4PNYyTUaZqu2sxC0hupad
 scCS6qnbfWUD9+x83+VM5V2lL1+U4QbAvAt4cuhfHDQtit4g54kRdoL
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add AST2700 to the FTGMAC100 compatible list and document that its
RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line for
AST2700 as it follows the same reset requirements as AST2600.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..bee9570a6f63 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -18,6 +18,7 @@ properties:
               - aspeed,ast2400-mac
               - aspeed,ast2500-mac
               - aspeed,ast2600-mac
+              - aspeed,ast2700-mac
           - const: faraday,ftgmac100
 
   reg:
@@ -30,7 +31,7 @@ properties:
     minItems: 1
     items:
       - description: MAC IP clock
-      - description: RMII RCLK gate for AST2500/2600
+      - description: RMII RCLK gate for AST2500/2600/2700
 
   resets:
     maxItems: 1
@@ -82,6 +83,7 @@ allOf:
           contains:
             enum:
               - aspeed,ast2600-mac
+              - aspeed,ast2700-mac
     then:
       properties:
         resets: true

-- 
2.34.1

