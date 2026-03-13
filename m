Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C401337107;
	Fri, 13 Mar 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410837; cv=none; b=QorbNYn1rELFZvHkXpIagW+8i4A37FIwtlX1tm8LSy3EVa9LFL7bQiki5/dXKRTo/ftdCSEZPcdCC7iFO9B9TePwil6/yqj7rJAxACbm31LPj+/pkZYz8xNKKib+bjHVtqmVeljHbRuz165zXfGaIAL9eToHw4k8FdTJNAk6Gjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410837; c=relaxed/simple;
	bh=HawlHMbKqQEUAIZwuHIEqJZkK8v/PI2v1qykelfqb3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAiwHrgE1hovnLZaRPskDGfTp0N5vqHLpnIrqbp+8mIwO1zfsZJhvxCMy+9CKa2/StY3SbJi24mHHQYrM1v/AFKEqH45hivR+Q/azxkyWNwDlTeN+3oVEM0wV0ChRnuIHFWvpwg841xMQ9zZptHa1HlAe+uOnyJSMhP8qAvAWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OkYwhIsY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OkYwhIsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773410837; x=1804946837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HawlHMbKqQEUAIZwuHIEqJZkK8v/PI2v1qykelfqb3w=;
  b=OkYwhIsY6jQfeeiXYbtJZGCqEaS2/AcDDeubYVeWuP1F/7r/Y8PQL2ZA
   f0y0OZLcHxSPxBUynPOSQZkXMLmaq3wIkn70OVWdzJMXX8xdsE2KS4OWR
   Dw9p6qKDbVzeImUWZCxw9Xk2LCrHpzjt0eWn7d4MG05o192OsUuQb4ygH
   Tmdd4YTWXWuxDhctnI4K54tufrfXzg5Am3UPjwAh+Lxjv3RKOktTq6pM2
   /Kvq5ySPMSGOj+mE9LKaCJ1vc+Qaqs1LDkmUxdvVZ+UuM60u8toJSb85f
   WTcQgNJmRz6XIrNtp8snkRbp4CSHU8i7p+d+jZhAHbFz7+GrF8fsFNITg
   Q==;
X-CSE-ConnectionGUID: iiONvliHS4OR8XOcf1jIpw==
X-CSE-MsgGUID: jeoNdeoKShmmn+Z2vZ9MVw==
X-IronPort-AV: E=Sophos;i="6.23,118,1770620400"; 
   d="scan'208";a="54622084"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:07:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 13 Mar 2026 07:06:39 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Mar 2026 07:06:38 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 1/3] dt-bindings: net: cdns,macb: add a compatible for Microchip pic64hpsc
Date: Fri, 13 Mar 2026 07:06:08 -0700
Message-ID: <20260313140610.3681752-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313140610.3681752-1-charles.perry@microchip.com>
References: <20260313140610.3681752-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add "microchip,pic64hpsc-gem" for "PIC64-HPSC" and
"microchip,pic64hx-gem" for "PIC64HX", compatible with the former.

The generic compatible "cdns,gem" works but offers limited features.
Keep it as a fallback.

The GEM IPs within pic64hpsc have their MDIO controllers unconnected
from any physical pin. Add a check to prevent adding PHYs under the GEM
node.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/cdns,macb.yaml    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index cb14c35ba996..feb168385837 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -70,6 +70,14 @@ properties:
               - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit ethernet interface
           - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
 
+      - items:
+          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
+          - const: cdns,gem
+      - items:
+          - const: microchip,pic64hx-gem   # Microchip PIC64HX
+          - const: microchip,pic64hpsc-gem # Microchip PIC64-HPSC
+          - const: cdns,gem
+
   reg:
     minItems: 1
     items:
@@ -196,6 +204,17 @@ allOf:
       required:
         - phys
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,pic64hpsc-gem
+    then:
+      patternProperties:
+        "^ethernet-phy@[0-9a-f]$": false
+      properties:
+        mdio: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.3

