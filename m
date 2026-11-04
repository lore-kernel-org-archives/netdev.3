Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769254;
	b=QDQed3xrImla3LuJhC8H5SKC/LQbxWpPX8wS9abjwYV5xJBQDZG/w6yQ1/z9O7tDS7q8
	 ajlX6XWgEjj/F3/l7a9cZNdWcSDwtZFK0xrBsdzfttSxO+ns4lpG87CVgin2ona5V1F0t
	 sN85gvowZWHkjmand1j+8uafHVIQyXaNa0aOE7rRDv2lh5al4pk/ThmsLbyYPaZI35Dug
	 UhfOz6J5VWymrLSp/T7RF5FK57zQPTtDr3Zfnadz7708HYNR0Ti6lQSa5liEuqaAhw2+w
	 Ki6JYgRvwB9VQzmU2fyocNDsoIqJPEjoT+AxzcuAMG4az5zCykZg1XdMXqSy+UHGkQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769254;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/RdDdlZQkQkhB5job68w1V+dpTPFunI5igUntY4AjPk=;
	b=x6nai034PoF0tFrc9YUzdeeiXDDhX5t1AyN44+rwTM0ZyVBzj56LwDRXmeYOBKAEO9qe
	 5N3Uj7tRycBDVvl4bNgcUK0b39pdIs9x+xOYVLX7TRxRy3ELfvnvo5CMk95kKzt54kzdm
	 rtQbfFtT6bwP1MroJdH68vs0ERJFNYkQPPmbBBErWpH/SfT8AWUgSW2k9/gJJaUG7YXkq
	 DnV6Uw9FKndb5uValcxfe/kvijDT2Eng1fK4/ExLF+C2cWRw7LsfQgqea8M+oYxEoHlhO
	 udOGygffjCNG/jAVg9lusx3IH3+rQF1s7j26wBYM8Hwar9wpao7bp2S16itJ5yYc7Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB5606A32D;
	Wed,  4 Nov 2026 05:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CB5606A32D
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
Date: Wed, 4 Nov 2026 13:13:54 +0800
Subject: [PATCH net-next v5 1/7] dt-bindings: net: ftgmac100: Make Aspeed
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
Message-ID: <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793769249; l=2822;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=9QbfrCu2gROJjfiyPf4so69mFqmkSbnzSchCShQ4QY4=;
 b=itAWxG9FfGRrrGw0wpANKLORs0SLNT1QPqutyY2WWkjjxF38OxMPhcCuYe8suIjbA6/BMQ9pK
 7k+77P0LrTpAOrorIYh0PrUNVIWPncamnaMLhcMqYTOT3/sRegFtqNp
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

