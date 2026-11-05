Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888250;
	b=bz3TGKEFIj6gO4kpE8sqVTfnQ9qszM9S9NQTb6mXhkQrDFNRKr3zcdtHE7pZwC3hRuBC
	 vwzdwC7EvxDJxarxzHdl+cGsvtzIIJm0mM6kN43WLelH9llnQS5uBXNU42qZ9UhbBTPG5
	 0bAr+y4lkuLQVG4Q9E3yI4la9eDQJWqL84dNTkSYqodF7xyKl2dsXBAawm2rur1HTjoYO
	 pnu4qqYvg+N8T8i78OjvsXA0i4MRD+nbPPXegAhlOUQQwpvMC0m6U7Lm+e9hjcHV2XMDN
	 fabtOlVOGpag/L820me49dNj4RN3tpVORLbK/gTY9FwMziew/ENJe2jrEmHBZwWox2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888250;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc;
	bh=6Ru6gjoQ5MsQd77m28FaMDGQ7f6+6z3eR5pPIjPeQGU=;
	b=rX19e8WCQEb+Ngx7dc4ypwFe+02hawfzzGAaTpp8uVYh9ccU5CDQ00v474zSw4YytZDg
	 NtaSI2MKBcyecNQoHAbbEIHs8T5k+maXg6DgwWqjPRqXjJJ0+BCp/kTcYKV2/upzCVctZ
	 fWao+B+ILT+39J/MLlEu/qDG20QtjVPEV2jT3LP1zFyRcI7ZSjKc/b92eubvafV0728RK
	 JGI/zl2a9ec0kThgcFZtzkefkD8bdV2UPWTtGXLTANBALaPBEtu042il6v2d4750kyJxf
	 nm3WoRbiGZaEBTbqP6hHX643s0W+ExwZPZ6qPG6SLNfhJfCp3dD235NFreomVHS9arw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4edhbzBX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6x04r1QN;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3605606D803;
	Thu,  5 Nov 2026 14:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3605606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=4edhbzBX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6x04r1QN
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793888248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ru6gjoQ5MsQd77m28FaMDGQ7f6+6z3eR5pPIjPeQGU=;
	b=4edhbzBXw2g4B0ukuFnfwFuKHQrPg5XgWLLjDI9FXwgw9jJEiu0JP/nEsUxm2RcICUxJIv
	oDEp73Ry2f/vbEv+b1MSYqU9i54q1Q4HGVHzIq7ssQP/brcCSO8Vvo15vtbBHlP0n93BKP
	vbhkDQA5HUO3dsfxsYhHwvoHsJrOY8hGE9j5rIXvoTD2RrnhtL+clITNQLCfRw9yM00zFp
	XwVdme1/Hw6S2JvxMQjdX/tl5h2N7j4vxe+ue1dG9kYltaTkSxBdyILi+JwRf1E8iSeJxR
	2qYs/i19vqlBHsaBZAkMcxPYDfv4SUUemSOD33vE+SHxcIVdCFuNcKBADUlvPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793888248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ru6gjoQ5MsQd77m28FaMDGQ7f6+6z3eR5pPIjPeQGU=;
	b=6x04r1QNN5lh1/kbkc0Ti8wr/wMdQ/k/KTWLClVfQm5wiQfGI2XG5yo7NC7qDschp0zIui
	IkpPCS7+N/0LPBAA==
Date: Thu, 05 Nov 2026 15:16:48 +0100
Subject: [PATCH net-next v4 4/8] dt-bindings: mfd: Add SoC-e SWIP parent
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
Message-Id: <20261105-devel-vstrassheim-soce-dsa-ml-v4-4-02f3cde2afa1@linutronix.de>
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

Add a binding for the SoC-e SWIP multifunction FPGA IP core.

Describe the shared MMIO address space and address translation for
the required Ethernet switch child and the optional integrated MDIO
controller and MMIO-controlled MDIO multiplexer.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 .../devicetree/bindings/mfd/soce,swip.yaml         | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/soce,swip.yaml b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
new file mode 100644
index 000000000000..625be299e262
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/soce,swip.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/soce,swip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC-e SWIP multifunction Ethernet switch FPGA IP core
+
+maintainers:
+  - Vasilij Strassheim <v.strassheim@linutronix.de>
+
+description:
+  SoC-e Switch IP (SWIP) cores integrate Ethernet switching logic, an
+  MDIO controller, and an MDIO bus multiplexer in one memory-mapped device.
+  The MDIO bus multiplexer is wired to the integrated MDIO controller.
+
+properties:
+  compatible:
+    const: soce,swip
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+  mdio@204:
+    $ref: /schemas/net/soce,swip-mdio.yaml#
+    unevaluatedProperties: false
+
+  mdio-mux@202:
+    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
+    unevaluatedProperties: false
+
+  ethernet-switch:
+    $ref: /schemas/net/dsa/soce,swip-switch.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+  - ethernet-switch
+
+dependentRequired:
+  mdio-mux@202:
+    - mdio@204
+
+additionalProperties: false
+
+examples:
+  - |
+    ethernet-switch@80020000 {
+        compatible = "soce,swip";
+        reg = <0x80020000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x80020000 0x10000>;
+
+        mdio_parent: mdio@204 {
+            compatible = "soce,swip-mdio";
+            reg = <0x204 0xc>, <0x200 0x2>;
+            reg-names = "data", "control";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        mdio-mux@202 {
+            compatible = "mdio-mux-mmioreg", "mdio-mux";
+            reg = <0x202 0x2>;
+            mux-mask = <0x07ff>;
+            mdio-parent-bus = <&mdio_parent>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mdio@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switchphy0: ethernet-phy@1 {
+                    compatible = "ethernet-phy-ieee802.3-c22";
+                    reg = <1>;
+                };
+            };
+
+            mdio@1 {
+                reg = <1>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switchphy1: ethernet-phy@1 {
+                    compatible = "ethernet-phy-ieee802.3-c22";
+                    reg = <1>;
+                };
+            };
+        };
+
+        ethernet-switch {
+            compatible = "soce,swip-switch-00-04-0c-10";
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    reg = <0>;
+                    phy-handle = <&switchphy0>;
+                    phy-mode = "rgmii-id";
+                };
+
+                ethernet-port@1 {
+                    reg = <1>;
+                    phy-handle = <&switchphy1>;
+                    phy-mode = "rgmii-id";
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    ethernet = <&eth0>;
+                    phy-mode = "gmii";
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+            };
+        };
+    };

-- 
2.39.5

