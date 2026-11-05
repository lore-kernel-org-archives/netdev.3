Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888249;
	b=0NgEb88XUSQXEKOxF7PSTIerapBOKjBdVC/0ee/ImeqlP7YbW2rSt3ivOnXQuLVjwxRR
	 lDYNmIrltnUHyio2Bwul1BPH2R9C6Gae2s0n+nyvUeulou45EKLUPgcaCgZ2yNQx9yvu/
	 DEE2ec/W/sCR5rfPwn7rCOPW1xO7qzc6jtitX+0WZ1UiyFekeT8mFBQcGCgv0JF7F+9eU
	 iEo4BWd0PwZmTFC6t7qdwEkEiuWxfwkGrkW1gQtG7/kEqPbK+L31pq1suTX1dm11pFUpP
	 dQ+e8JGspvBPVM0GhjsRGxxRDNMCV4uwiZ5Wo6Jy0zsAiTbEVQ6hWS/XoLkrdV2+OlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888249;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc;
	bh=ayCS7YjxC0rYRgHPPNliFHTX6NulF62RGdEjDbL3Cig=;
	b=f/pw+ySHNBW6UXbsOspwrmCO8orHiBZgzvZp4dbxnEJLXEvDgbWSIlcB9O81E5NURtoV
	 18Zlj972rkWK3QgmLR3w3bdeZ2OK8POVnv38B3YSqJQoqYam7XKPpI2iYevrVAJqak6hP
	 RPbTnS47Kl+7+gVB1IrnEjg0seoP83v3M9A0PhviLB5pUQ608mQUdSfA7MFvpeub/jf5g
	 H7WAFFbwbYc2fzbVH85A/SaGSCrYdsIL0krVX6on6U5UIRd5QfkNOaLbQOrqahmJe3rhr
	 bqCX8/4xO+dhBR1pBh1Zwx9PkZxukmaGKfcPoPydfE2l6zVNCegcpb8mIMHxYCopCXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EHg4GB5k;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9hA6OXBe;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF5606A32E;
	Thu,  5 Nov 2026 14:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8EF5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=EHg4GB5k;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9hA6OXBe
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793888247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayCS7YjxC0rYRgHPPNliFHTX6NulF62RGdEjDbL3Cig=;
	b=EHg4GB5kqdm4aTM7e6j9PE658YvDBcj9MUwSY/GpkwHliD5tFsrI+86l2SWSLwyoOh5Jrd
	gyixsfa68vBxc5CQoxNT4jvA6NeF6mHYFJlVXIqjaaE7wwu0LsLsc7gq0Tc4cXuWdkuxuq
	KxicsIqf7HQjkx4AgCMqpY5vjoEBb/bKryCAvrN1qxX6gnoIug6EKzB3q+gNrqk2LplldF
	yhVyRqxwMgS7v5AJsc/KA/JtAOp3OXGR9IGblDeZIqJEt5Ina8EIJlEYVVx2BydL4cYiIG
	A4pEPW9W7toaV7UQo/RVeMxNjUNfU39BYzih+aS4W7cpaE9jGnFxn1LpuF4HsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793888247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayCS7YjxC0rYRgHPPNliFHTX6NulF62RGdEjDbL3Cig=;
	b=9hA6OXBefr59y6njiC31Z8f7ZlnxsfAWLexsjxH0/JMOyTM1jVKuT8JbBvi2IeTcCxDz3i
	eqQeYc9alNqIBPDA==
Date: Thu, 05 Nov 2026 15:16:46 +0100
Subject: [PATCH net-next v4 2/8] dt-bindings: net: Add SoC-e SWIP MDIO
 controller
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
Message-Id: <20261105-devel-vstrassheim-soce-dsa-ml-v4-2-02f3cde2afa1@linutronix.de>
References: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
In-Reply-To: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Lee Jones <lee@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, mfd@lists.linux.dev, 
 Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>

Add a binding for the MDIO controller integrated into SoC-e SWIP
Ethernet switch IP cores.

The binding describes the transaction data registers and the lower
16-bit half of the control register shared with the external MDIO bus
selector. A sibling generic MMIO MDIO mux uses the upper half to select
the external bus.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 .../devicetree/bindings/net/soce,swip-mdio.yaml    | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
new file mode 100644
index 000000000000..7a0b8bd3ab71
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/soce,swip-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC-e SWIP FPGA MDIO controller
+
+maintainers:
+  - Vasilij Strassheim <v.strassheim@linutronix.de>
+
+description:
+  MDIO controller integrated into the SoC-e Switch IP (SWIP) FPGA core.
+  External MDIO buses are selected through a sibling MMIO MDIO mux.
+
+$ref: mdio.yaml#
+
+properties:
+  compatible:
+    const: soce,swip-mdio
+
+  reg:
+    items:
+      - description: MDIO parameter, write data, and read data registers
+      - description: Lower 16-bit half of the MDIO transaction control register
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
+        compatible = "soce,swip-mdio";
+        reg = <0x204 0xc>, <0x200 0x2>;
+        reg-names = "data", "control";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.39.5

