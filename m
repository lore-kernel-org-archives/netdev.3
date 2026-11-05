Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888249;
	b=KrxeNbyc6vz2CFnQiQCxv0mUySN0fJfHDEAMX/znLe2AFZA8g7JzbBlAHOyhoquS6m3P
	 UF5zgVLs8GHdlN9XQyFUzUM1zAl87F49dIrzxjFYKO2qmsPItwN4ePDfsI+Luuof5DmCU
	 KVJBRDdiPV0gNLUSxCj41GSArBUz3vcw0IUAGmwQfN87jdWW3b0ho0AZxUpDUYbZkf/I8
	 aX032WPUrFu6ruYbQiSkr1EMxUVtxTypgUMK5AHHjKxNQYpw0RBMPi53hesMlFOGJlKPu
	 eq7zG7Adoh5SS+Toyr8exnuaFdRIb5G/TM/+uoseAA/r6nOogtd+ywFASy58kvR6qoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888249;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc;
	bh=Zm1SeUU+Jxb7BuZJDD+o5hL962TS6FgnURIAybrs8rY=;
	b=QB4KsG0c6vL0ZLDmkBKORbn0UmBgOmgiOVHbbuLqGWsIwKVrMFmBh5DvvYSibju/gmyS
	 9C2HyGkAnY6J31snADOq9FM85Q1Gzhux3ryvAI3ptEGvg17N4nQd3REXBRTpJIqyv7pSN
	 SNa8wtbZ1KogC1JoIdbJzWhaLSwRl4/xtqW1ESVdd03BrBPTY6JK52DqfUtxdBC/6ntyB
	 jcjLEFIS9f51axcGeP/JrvSKNlXWeGh/xzApo1Ybyxk9Suk77CeKZYBo2UvIr/ZmTLKw4
	 B7F0/mI6XhbWSneBznFh2v5WLWfoVdNlg+pYCfathLKvTN7/3uq2ignYmwf92i/wzSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0TbWIw15;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Xroi6Sbz;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62215606A337;
	Thu,  5 Nov 2026 14:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62215606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0TbWIw15;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Xroi6Sbz
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793888247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zm1SeUU+Jxb7BuZJDD+o5hL962TS6FgnURIAybrs8rY=;
	b=0TbWIw15Q9SG4yCRbGARaQKknDn/ebQYf6/F26WHHt3/Sjc0ADD3BM1BLLrT4ojv7SYuwi
	UNwAPfF1iAruJkwGPoO01l94asqtdStWgZ3TpRMtGBkqoo8yFH1jWcCFcRE4ZdzbkhSjBX
	AXPcEesJik8N+dgeOZ2SWWItD2ggO5rBEQHQC6vMdk7SnJHMfxioPKSsgtm07QM6AMyPvC
	xzk2KZc0RSxnDRbwe6HeLiipS544nc6fEcvB1EuvUW2KX7E+vrVmke3BwzbVoNcNa0nEqC
	FRJ6Zf4CytY2N3CNijL6BvTA3HpS7fbtsV2RjADC0elz1aZei66MczAQ+al38g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793888247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zm1SeUU+Jxb7BuZJDD+o5hL962TS6FgnURIAybrs8rY=;
	b=Xroi6SbzBEwxwVWNtjaQoiRXAHTnxP0+MMHpchhUSQrpLKffpNYz4xiwomjGRoREhsn4Yl
	tCU4aslSydrIh7Bw==
Date: Thu, 05 Nov 2026 15:16:47 +0100
Subject: [PATCH net-next v4 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch function
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
Message-Id: <20261105-devel-vstrassheim-soce-dsa-ml-v4-3-02f3cde2afa1@linutronix.de>
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

Add a binding for the Ethernet switch function integrated into SoC-e
SWIP cores.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 .../bindings/net/dsa/soce,swip-switch.yaml         | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml
new file mode 100644
index 000000000000..daac779c466d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/soce,swip-switch.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/soce,swip-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC-e SWIP FPGA Ethernet switch function
+
+maintainers:
+  - Vasilij Strassheim <v.strassheim@linutronix.de>
+
+description:
+  Ethernet switch function of the SoC-e Switch IP (SWIP) FPGA core. The port
+  count and presence of VLAN and STP register blocks depend on the FPGA
+  synthesis configuration.
+
+$ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: soce,swip-switch-00-04-0c-10
+    description:
+      This compatible identifies the register layout; its suffix gives
+      the offsets of the core version and feature identification
+      registers (0x00, 0x04, 0x0c, and 0x10). Port counts and optional
+      features depend on the FPGA synthesis configuration and are
+      detected at runtime using this register layout.
+
+  reg: false
+
+  reg-names: false
+
+  ethernet-ports:
+    type: object
+    patternProperties:
+      '^ethernet-port@[0-9a-f]+$':
+        type: object
+
+        properties:
+          reg:
+            maximum: 30
+            description: Switch port index, from 0 through 30.
+
+          phy-mode:
+            enum:
+              - mii
+              - gmii
+              - rmii
+              - rgmii
+              - rgmii-id
+              - rgmii-rxid
+              - rgmii-txid
+
+        required:
+          - reg
+          - phy-mode
+
+required:
+  - compatible
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet-switch {
+        compatible = "soce,swip-switch-00-04-0c-10";
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-port@0 {
+                reg = <0>;
+                phy-handle = <&switchphy0>;
+                phy-mode = "rgmii-id";
+            };
+
+            ethernet-port@1 {
+                reg = <1>;
+                phy-handle = <&switchphy1>;
+                phy-mode = "rgmii-id";
+            };
+
+            ethernet-port@2 {
+                reg = <2>;
+                ethernet = <&eth0>;
+                phy-mode = "gmii";
+
+                fixed-link {
+                    speed = <1000>;
+                    full-duplex;
+                };
+            };
+        };
+    };

-- 
2.39.5

