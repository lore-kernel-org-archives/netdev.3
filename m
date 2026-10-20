Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496063;
	b=GXNQ8V8yqmkk7/VqeRjQGuspwa8yP6nPu+3w9JdIJCfviMggPmwZZBFh7k9afWI/J7O0
	 wck2mt1tm8EvH1r2jSwOyqkFjwBW+j1RGiBc3D9Vz6qMhWL2O4z3jdpemXLa297nyOJll
	 j1wK9csL+ZzIAXNEmyPnctdgI+0Wwqs2Aja/xIklBN9JXHScAND9E+BBOLC27fL8Ac5cV
	 L96/qHgrZPk/eLpcdpNXDevr5Yf9h6p4Y884nvUI/zEtl4lkB7BoW99kOeq6zUWkkicrv
	 XTUG9tkcFnLlR3JZ5d012Ou7xfskIppVfETqE22rlxpahEr86eceNneWdlKS0+JjbYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496063;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/RdDdlZQkQkhB5job68w1V+dpTPFunI5igUntY4AjPk=;
	b=vU5q9L8nJ6RzwkR/Pg3Hu5KaGNb9hMsfG+2kdtM5H2wP5+sv4JRbbMBW+O/YkMmLQ+6e
	 ernbuy8zsmung6D0nyPqX8YlyWWaf+NDzeEtTvSRYnF3+vbGHCh4LMi3gsn7y9EmVK0g5
	 Q6N2FMn5RBk1qkkbVqkb/3bRok1HOoF1Uqq3yjorktVBH1vK4aT+GHKJpN8//lGf0wMjb
	 Zw6klORrX4wkYR9Rxr0Oxe5G6izoN5uo/YtPM+YxPXkJBqcJFxlcUXuJPduiZEv+Vtx3A
	 UdipVpCiZklPesQS+6G/ubjEyKo67ehJ94MuUYJPxAFVgal8aRRTDNXauMn2V7OC7aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53E606A31C;
	Tue, 20 Oct 2026 11:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD53E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Oct
 2026 19:34:13 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Oct 2026 19:34:13 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 20 Oct 2026 19:34:12 +0800
Subject: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: Make Aspeed
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
Message-ID: <20261020-support_ast2700-v4-1-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
In-Reply-To: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792496053; l=2822;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=9QbfrCu2gROJjfiyPf4so69mFqmkSbnzSchCShQ4QY4=;
 b=RBJp9dmZe7xo9rCCel6649wXGMsR8imnq4x4Gnmzj0Fe/4vMf70+kQ3ETHSLEg3ek1SIdk6O7
 37hLe/OCQNIADMoSTqtG/ttXBPYl6ATRJ403Ig+dNkbD+zmuWKBHlMN
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
 .../devicetree/bindings/net/faraday,ftgmac100.yaml         | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..c870dd0bda7b 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -13,12 +13,10 @@ properties:
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
 
   reg:
     maxItems: 1
@@ -94,14 +92,14 @@ unevaluatedProperties: false
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

