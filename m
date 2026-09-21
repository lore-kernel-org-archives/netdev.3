Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED97427FBF;
	Mon, 21 Sep 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007558; cv=none; b=r3JaJ2V6qf2IbKWKaVn/8vPY8QhlpG6+N+IleFzQ1LcfFdctagGXz3Otlhd1XtOItLEFRAE6Bx5XRXhmQw7iV2tiJvM8QN2kv0tOYtfdL+0//Gwop0QEjLBqtTM4ZMm+ygiBBv4Bp0Uv3rXfj5X5Kj8TIqoqagSvtLUVqlK6MMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007558; c=relaxed/simple;
	bh=QMm3vwIw+3qxFYIpDANXpo+I45U7Se4M2ZGEhuo3gZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSo8FqNxwqvaEuCSIlcu78JX/sjjeTqBY9o6C/mFxf1rxaOx5npB7a0j8woht+NEZ9E4SfIQIerA2bCd8zg6qR2ptKGN/6qUo0o9EmkNjbvY98rPmnNiRqrZC7N5hba9yeH0EurcM9TBEiRKSZUw0mBGnpIpnshAWTE/A3Yrzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GhrhzAHF; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GhrhzAHF"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hpT2361PKzKmyp;
	Mon, 21 Sep 2026 18:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790007547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Le64RsYvCGahq8/ababfY4rfv5JVe6qomxkNAO5ZXbs=;
	b=GhrhzAHF8NlksQxDJq14lkgr9r5rxcAXaMZTJtrj8O3R1ryMFaolIqIODjUuUlyiNJptuB
	ghI4QRobP6NXlxZrHYk82gP9c1EjFv0nYtbEkNotAmK1cHEBNSicVtrVKRsyCMYHPDqr/3
	sEgWQ61x/Yj4b/aC6Pj2LmiDntqUfUKkh/2BYhQKWLL1Sncxp7dvOwfmjoonhcnnTXxIuD
	3zogJRhJNjuMdEI/EiCkybeO7Rkx5RSt1HY7+KMvl5QrIqtoyzdTgDvezajFLCnMTPwmRu
	/nD4u/gXxewN2vkg3UHYktu8zMjtUHfGYK/OrFgdCdBLqBMPxwtBF3aMA/eDzg==
From: Simon Polack <spolack+git@mailbox.org>
To: andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: f.fainelli@gmail.com,
	javen_xu@realsil.com.cn,
	chad@monroe.io,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] dt-bindings: net: realtek,rtl82xx: Document RTL8261C/D PHYs
Date: Mon, 21 Sep 2026 18:18:15 +0200
Message-ID: <20260921161817.565185-2-spolack+git@mailbox.org>
In-Reply-To: <20260921161817.565185-1-spolack+git@mailbox.org>
References: <20260921161817.565185-1-spolack+git@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4kideuxsxq6zrqgadh9u8i84sh4qa9u7
X-MBO-RS-ID: 69ad2751ed9221f7a8d

The RTL8261C/D family reports PHY IDs 0x001cc898 (RTL8261C/D),
0x001cc899 (RTL8261CE) and 0x001cc89a (RTL8261D_VM). Add the three
corresponding compatible strings.

These parts drive four LEDs from the VEND2 LED register block, so allow
the leds node for them the way it is already allowed for the RTL8221B.

They also accept the generic tx-polarity and rx-polarity properties to
invert the host-side SerDes lanes, which is needed on boards that route
the USXGMII lanes inverted between the SoC and the PHY. Reference
phy-common-props.yaml so those properties are described, restrict them
to the compatibles that implement them, and add an example using both.

Signed-off-by: Simon Polack <spolack+git@mailbox.org>
Assisted-by: LLM
---
 .../bindings/net/realtek,rtl82xx.yaml         | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 07b39ef1fc62..b21efcb9b255 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -27,6 +27,9 @@ properties:
       - ethernet-phy-id001c.c862
       - ethernet-phy-id001c.c878
       - ethernet-phy-id001c.c880
+      - ethernet-phy-id001c.c898
+      - ethernet-phy-id001c.c899
+      - ethernet-phy-id001c.c89a
       - ethernet-phy-id001c.c910
       - ethernet-phy-id001c.c912
       - ethernet-phy-id001c.c913
@@ -74,15 +77,35 @@ unevaluatedProperties: false
 
 allOf:
   - $ref: ethernet-phy.yaml#
+  - $ref: /schemas/phy/phy-common-props.yaml#
   - if:
       not:
         properties:
           compatible:
             contains:
-              const: ethernet-phy-id001c.c916
+              enum:
+                - ethernet-phy-id001c.c898
+                - ethernet-phy-id001c.c899
+                - ethernet-phy-id001c.c89a
+                - ethernet-phy-id001c.c916
     then:
       properties:
         leds: false
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ethernet-phy-id001c.c898
+                - ethernet-phy-id001c.c899
+                - ethernet-phy-id001c.c89a
+    then:
+      properties:
+        rx-polarity: false
+        rx-polarity-names: false
+        tx-polarity: false
+        tx-polarity-names: false
 
 examples:
   - |
@@ -96,3 +119,30 @@ examples:
             realtek,aldps-enable;
         };
     };
+
+  - |
+    #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/phy/phy.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id001c.c899";
+            reg = <0>;
+            tx-polarity = <PHY_POL_INVERT>;
+            rx-polarity = <PHY_POL_INVERT>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@3 {
+                    reg = <3>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                };
+            };
+        };
+    };
-- 
2.55.0

