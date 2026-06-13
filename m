Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8C30D3E0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781374817; cv=none; b=KRdmj+xGBc5jQVTbG9eAp7MQfB8nNvgz2LcMSXge8LVhMslYeqSuUUUPxvhKnosPAYIFGZuXBbrHLD4auwQNdlCgQf6dZcfXzy2fTY1YbayLN9Z/Eg3Q2xDrGz+OYm/Yk/j7Xk64wyp7SriS8Y7pdm9TAsFtF2ElVOLndeYCfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781374817; c=relaxed/simple;
	bh=1T1ByAraUkYOdhjn7ASEmsGXb0gsHFuGHtFnsbcTujU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a40+BeWUhwSAt0G7DJoyZsvZ+HN5dsl7LHKUiSorBPyhCGYTY4GMFY5x3uJXHmVSQ+S6N8p5KFUsrZy7nVBnxOgN7rhDiSPMtiw9S/KEPWARHPElHhvbiMM8whe1njBAGVZu695doJzacY8e37vdM/gcFAGk0gG84kqYEt2sUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=WC0jOT5W; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YD5z4CQP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="WC0jOT5W";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YD5z4CQP"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=WC0jOT5WzmuxtjPfPVwjfNP21NE5kwcLQY35vrDpJ5FSVSsYznYYVxdevXLslxb81lW7RFDvQBOsKjzNMYWHhBFlxN1pibPz1mNviB787Xv6hZfUuCD+pSVxXMzXxy0Av1FiCDR1oCouPAsgClH37jjTp/u5bKbDEgHiRIc5L96Qvf2LC+qGDkO17KqonsyeScwwCQQ+VPBddCb57KVg6XMDB7SNM4bRXSKdFVlzwpuEiPu5Kmz/kn7THdPpPk81TjD/ZrtcZw56SURwEzDIi1Z4MmU+AvxVlkI82G4EL+lwqSsnODvme32NkQQmqM2oKHZ6VFL3YBZqXo8hB7FaEA==; s=purelymail3; d=tinyisr.com; v=1; bh=1T1ByAraUkYOdhjn7ASEmsGXb0gsHFuGHtFnsbcTujU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YD5z4CQPtzESOu3/iK7snHhyAGwF3oUQLQRLPE9jBW2nxFoQnSjMg3QdJpyf/UbmpmLQ+Ghtixb9Xp3huatMv/K/4tdmJLIn74i8ugBKSXy1ac2o8aD+6WfK/c65HX1nxLm27DLoXEqhrKhBsTse+STOP6kZxZRFeF7TYfVX0+XjTSjg8dTfSZZOuf/7fct5tJuNHvcif3aE0Y53NGmhMK3XCM+Vex4oBqXhBXrtdF0Ldx4C2/0tjI0oXjhE3YyxiBlJYDNqGfbUr/ai55GO4YLMOBuTIKGGgqHuz7hpProv5/dgwvil+xs7u2/qp7k/mltyQO89Lsuv6NJNMCbmRw==; s=purelymail3; d=purelymail.com; v=1; bh=1T1ByAraUkYOdhjn7ASEmsGXb0gsHFuGHtFnsbcTujU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1738339834;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 13 Jun 2026 18:20:06 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v5 1/4] dt-bindings: net: dsa: add MT7628 ESW
Date: Sat, 13 Jun 2026 21:18:42 +0300
Message-ID: <20260613181845.111877-2-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613181845.111877-1-joey@tinyisr.com>
References: <20260613181845.111877-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add device tree bindings for the MediaTek MT7628 embedded Ethernet
Switch.

The Switch provides 5 external user ports and 1 internal CPU port, with
integrated 10/100 PHYs and fixed port to PHY mapping.

The CPU port is internally connected and uses port index 6.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
new file mode 100644
index 000000000000..e0e7ffef6648
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/mediatek,mt7628-esw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT7628 Embedded Ethernet Switch
+
+maintainers:
+  - Joris Vaisvila <joey@tinyisr.com>
+
+description:
+  The MT7628 SoC's built-in Ethernet Switch has five user ports and one
+  internally connected CPU port. The user ports are all connected to the S=
oC's
+  integrated Fast Ethernet PHYs. The switch registers are directly mapped =
in
+  the SoC's memory.
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: mediatek,mt7628-esw
+
+  reg:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: internal switch block reset
+      - description: internal phy package reset
+
+  reset-names:
+    items:
+      - const: esw
+      - const: ephy
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    switch@10110000 {
+        compatible =3D "mediatek,mt7628-esw";
+        reg =3D <0x10110000 0x8000>;
+
+        resets =3D <&sysc 23>, <&sysc 24>;
+        reset-names =3D "esw", "ephy";
+
+        ethernet-ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            ethernet-port@0 {
+                reg =3D <0>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@1 {
+                reg =3D <1>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@2 {
+                reg =3D <2>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@3 {
+                reg =3D <3>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@4 {
+                reg =3D <4>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@6 {
+                reg =3D <6>;
+                phy-mode =3D "internal";
+                ethernet =3D <&ethernet>;
+
+                fixed-link {
+                    speed =3D <1000>;
+                    full-duplex;
+                };
+            };
+        };
+    };
--=20
2.54.0

