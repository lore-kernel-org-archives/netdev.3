Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15048C8AE;
	Wed, 23 Sep 2026 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159997; cv=none; b=H0AuabqkGztcnBDJS6oSVs7i3Ne32AGGPIrs0u4QGy/FulvDEl85+cB+QKqIewSjWCzRiKFU84IU5vcpRdTYmHyJ5OfMDHPSlH8306Qm5uF0zhoJ2gYifee/ZD+Z+RL2547uNZxvSs9prPyFJ5UTQ5uRsbaLmIwAN95F6wja644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159997; c=relaxed/simple;
	bh=ReWPecma+TFKe2saPhApRyIrViwQ/YokOyxWxkliJVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBdywMwuJNLP3JoIsbPo8C3PR9Beo5KaK8zTHYUDmE7e2fHoK684Xuf2/KczmoF0bkwXamZIvbppVCkSE5RmL6XdheZlCcO9Hcirgw3qRXRd/+Usow3DLidUhLkvIApZQX5SHTTmQ/spWcB23UwXnUi+ZpYOTsTInkSCYB40IEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BEF0rN1e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHrBGlzy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEF0rN1e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHrBGlzy"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1sJUfBEmsZ9rDD7pl7MAlsVj7stcmcCx9IW4KMl91g=;
	b=BEF0rN1ewo6uLm5rsGyZlPEonKfTcieU+J2SwfL42QSfdceXz0ey1vxN2iXMkaLQ7auk0t
	fNOoOzswmhvi5pxFwFNILjQcqkqtqQUfewDviueTegG/P4wCk9BCrmSmiUMpFJJ/ZDO0u4
	XQFv5KPDcBhmV5xoMwDpslzaUt/N0PUVImJuQbHJlGLYy56vgUXchZYuIrcMW2giNMCEzz
	o3Vl9yAjj7U9UKsDcYW45NpWEb3GT53KUkyzig38CD7ge+Cp9wT2/VFxgLCxtrpLRp6GFp
	4F+NDpTtzEzZEQydkqPYF6/K30Dx227pxG2CHVFFVcvZyhBnIpMtQx+bcl04wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1sJUfBEmsZ9rDD7pl7MAlsVj7stcmcCx9IW4KMl91g=;
	b=bHrBGlzyQJ+2eS/5gI12VBwr87G46Q35c2Yg/7lrsvmW8ikqlbZiW/RsgrjTx+LRbj3tiI
	rgCnygaajX1GzeAw==
Date: Wed, 23 Sep 2026 12:39:29 +0200
Subject: [PATCH net-next v3 2/8] dt-bindings: net: Add SoC-e SWIP MDIO
 controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add a binding for the MDIO controller integrated into SoC-e SWIP
Ethernet switch IP cores.

The controller exposes separate register regions for transaction data
and for the shared transaction control and external bus selector
register. It acts as the parent bus for an MDIO mux used to access the
external MDIO interfaces synthesized into the switch core.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 .../devicetree/bindings/net/soce,swip-mdio.yaml    | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
new file mode 100644
index 000000000000..3cf4bde0508a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/soce,swip-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC-e switch IP MDIO controller
+
+maintainers:
+  - Vasilij Strassheim <v.strassheim@linutronix.de>
+
+description:
+  MDIO controller integrated into SoC-e Ethernet switch FPGA IP cores.
+  The controller accesses multiple external MDIO buses through a mux.
+
+$ref: mdio.yaml#
+
+properties:
+  compatible:
+    const: soce,swip-mdio-23-02
+
+  reg:
+    items:
+      - description: MDIO parameter, write data, and read data registers
+      - description: Shared MDIO transaction control and bus selection register
+
+  reg-names:
+    items:
+      - const: data
+      - const: control
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio@204 {
+        compatible = "soce,swip-mdio-23-02";
+        reg = <0x204 0xc>, <0x200 0x4>;
+        reg-names = "data", "control";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.39.5

