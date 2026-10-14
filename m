Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8E48D879
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962598; cv=none; b=KwtqZDy3Qd98vV1bZUTORlhVsvsxc+HCeQU3S6Dyyn/whB/Zo8+H+CrwH3csH3l5HfjEAphyIZuv3M9DEkDe9E1NW01WeVapuViwvUlLP4bnQJQO3eOdIJTt0wch3OEQSk4wY/Wuy5r+0bF1PDK60riQFWwrj09XM5aMAI7KWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962598; c=relaxed/simple;
	bh=NZWAEkceALgPMAo23xyfHb6V9DmgRO6Dus9f8KjTAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5tf6aiBdzXUKYiwiPg+jlapJm88L5qr3TxDM1vI1p+XMKRS2aEMbJQTya02Tgvrc5RchPbknOH8eLrUPP+5A6burR5bGdSSrETnIaHrTF86IjnGOaON2p182rYyqnLCQxiRDvO+pXWus3tW6ESgrrFb1kfmDm+oGNjnjyumnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9IW5m3W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9IW5m3W"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2304435f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962591; x=1792567391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGflw6Hieq74yfbfa4F0lEdKuK34IyaMLqXOMrFMFTk=;
        b=o9IW5m3W1nExc0TdTFfB+SoLtfkyI+WZv0KYkQK7Q/nY/3PweJlAob8J8bAE5cLhjS
         27dCIisSOkzw3w34Jbp8c/ptaPrExlp3gNFI/pb9Ix9rXMBHRucwmoMVR7WqarAcRrNE
         Df1dgCVaez4GXyTJSpKHXBK68zV2+elDKEdxFaPAZQsjIaHBCLzPcjfyOET/nlcyPvP4
         DC+CIapgWLKt5msfAAWyZGMDdX5mtAu7NnC9yAbmsH8uDHXA6Gt9BPwf4ddUYJ7SK7Bp
         U8hiwUd8ih/QwxZLpANQLuez05U+DHCJHExzt5c9TPtYUaOvlF/CUn+F0TdvWt04PojM
         wbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962591; x=1792567391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGflw6Hieq74yfbfa4F0lEdKuK34IyaMLqXOMrFMFTk=;
        b=qt9HRsouM2fTYd5YHWlkHFkVIsyBXzmpMdNV1RdXz4h0SghSmvQBtGFrDtDnttpUEk
         YoGBXLMcZKD72qctT8zpnCGSVJza53hdqv5mPj1gNFfkph5xHtay1vuYndt6rxor9DxI
         WJH9gF197hmlByppIPfM5TDHNXeVRqpBazQKXMft4wZPTk0qYiMDJx/V/52YEabGVyVB
         hwQC3xuc7uCuhC2JiPHF6rUsCP9kg5ur2pxa0OgtXTyRgaM07l2yUCsqVEG00d0WVbZn
         udrZL5QE4R6GYBR2VliWczkUKTbHNYHUut01CgCXZcY++vBtdw2+SETPeCGf4PofciPe
         j4BA==
X-Forwarded-Encrypted: i=1; AKwUvByljd1bZcVWpYNmpPiVZ3uUfv3NjmGDm/0oQTqjU03hWqEV2DeY5nQUDC4VTkr1c0O9aGDw5+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpzNvN7qeYaB604adqB8UnRmcrfDhLl2mvaVTwgKi9n1zcMQwd
	OON1gyI5bJgnh3f1GQ9/agB1CvfXo9VL8lAdgiMBPmdJu0gTKEaZvu76
X-Gm-Gg: AYBFou02j9PbLaHS5d6ViPvSPTk64Ur60aDc6g6LSdqn5jKCM7GZ6CnNHQXZOPymaXf
	hSmcnDUvXPKDWNh53G4TOHUEhDkDPmNuBzCyW8wsixi6oUoXqQ271z2kGnftcEbxEPdfZTPfjs1
	X7oho3/bfgTfCDKNJ56x6eRVhh9UqOQ3dr2AuFNSxMMHwMljdm/sPW1EU8K9EzjufuS2UHiWObm
	RRd488GdrohpSPD5G/I/DepX7NLFrmnkzVyYuYZgH8VRYahdeDItE4W2sgkwEgbyhjJGjVYNW6Z
	E8s6u55EZaIC+ARLUR7LiU3s+tkpf9A/3ka4gqMrBawLN1bc9F7O70ADSX89woVPajXIaAf4Rze
	PY2xTZvU9dObNxLY9hmkieE9yxLO9+p58ggxXG4iOO4ZyFK10Ps1ym3M3cpyxU+Rvtl8sfZxG9O
	ijZ65DzAI2gXeOPI3KoigiiEMmglG33ktHeVoHI6S0rHNaXnxSz0iMmD8N6DltoyC8vtMtsB1y6
	7slGjhWZq7D5AJzxaxCw+UmE7JCdmdAI/kv4KhwSUSuxX25w6LPitRLH4+FZoWjeHT9Xg305U+0
	T1LS3i07PT+8alkaufIL3uAcoTapo4vasbc/OSH+eLNGxHCGflEDcHmWCruQvw==
X-Received: by 2002:a05:6000:401f:b0:48d:eeaf:d2ec with SMTP id ffacd0b85a97d-48deeafd35amr380402f8f.49.1791962591088;
        Wed, 14 Oct 2026 00:23:11 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:10 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/24] dt-bindings: net: Add ZTE ZX279128S Ethernet switch
Date: Wed, 14 Oct 2026 08:20:57 +0100
Message-ID: <20261014072109.1759502-18-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the switch, receive interrupt and per-port PHY modes and MAC
addresses.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 .../bindings/net/zte,zx279128s-gmac.yaml      | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml

diff --git a/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml b/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
new file mode 100644
index 0000000000..fcbdbafa76
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/zte,zx279128s-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE zx279128s Ethernet switch
+
+maintainers:
+  - Navid Ghahremani <ghahramani.navid@gmail.com>
+
+description:
+  The ZTE zx279128s has a five-port gigabit Ethernet switch with a traffic
+  manager, a buffer manager and a DMA engine that connects it to the CPU.
+  Each port is described by a child node of ethernet-ports and becomes its
+  own network interface, with the MAC address given in that node.
+
+properties:
+  compatible:
+    const: zte,zx279128s-gmac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: The traffic manager's interrupt, which signals frames
+      received for the CPU.
+
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^port@[0-4]$":
+        type: object
+        $ref: /schemas/net/ethernet-controller.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description: Switch port number
+            maximum: 4
+
+          label: true
+
+          phy-handle: true
+
+          phy-mode:
+            description: internal for the SoC's own PHYs of ports 0-3, gmii
+              for an external PHY.
+            enum: [gmii, internal]
+
+        required:
+          - reg
+          - phy-handle
+          - phy-mode
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ethernet-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        phy8: ethernet-phy@8 {
+            reg = <8>;
+        };
+
+        phy10: ethernet-phy@a {
+            reg = <10>;
+        };
+    };
+
+    macaddr: nvmem {
+        #nvmem-cell-cells = <1>;
+    };
+
+    ethernet@92000000 {
+        compatible = "zte,zx279128s-gmac";
+        reg = <0x92000000 0x400000>;
+        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                label = "lan1";
+                phy-handle = <&phy10>;
+                phy-mode = "internal";
+                nvmem-cells = <&macaddr 0>;
+                nvmem-cell-names = "mac-address";
+            };
+
+            port@4 {
+                reg = <4>;
+                label = "wan";
+                phy-handle = <&phy8>;
+                phy-mode = "gmii";
+                nvmem-cells = <&macaddr 1>;
+                nvmem-cell-names = "mac-address";
+            };
+        };
+    };
-- 
2.55.0

