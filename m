Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DF34D907
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557912; cv=none; b=UqaXjfe1QYkfwu48uSywtg1yOlZInAxV3/1VrJ7VPLOwpv0xxmenTWps/oIAxuyi+uLuGsCNVBzZCaFCtp3XN/f5nwrmoM2GaDVXm9BEcMDQqx/vuMlR2i545FnJvgpALoP4PmGxqlse7QU0cTHXjlFseiI/vuCC7xTQF07PDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557912; c=relaxed/simple;
	bh=m7IHSkZEUu88sqJeHdwKupt3xgnbuvYT1gJue+XSGfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZpfmRVrZRUd8rEbD33Qf2jI+NwFYBbMO0UWx71suD/V2Uhjn8htQZf5P2Sh0z/zjwOdcTImhER09/NRWjhMNWnMQhJzwuG/yzqksWsk9a8F7sq+kkpcInwdAP4ExO1JMgwaJrtmBd8SDADstxWDwnjIdBo3IWr2Orrb8Mj206I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=oa8IREAk; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=e9VyW/46; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="oa8IREAk";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="e9VyW/46"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=oa8IREAkccNQpBuS+txW5AQUfei8baCofCn3DARIJO918eblyDO7JBlQoOKtlze2f7AOhaGW1k9YTePZFKrFm+mBfhnus7ao2P3dU7D0D0YTNLPWexXMBwFyuyMH9xr6r0lcQ6RtHb7IoZeWIumvDrIaA6vXUf+hQeGmaI+7P3RDMMJ2SuAZn3qrFCxIStjGcChKWJthro+6sQg5273TK95XilgNS6og45JEzPNZ12gIUXbjSjlaPOlQxOmVtctC0X3PMKlLWeyjSjtrbOkGohkm/woihquxx86hKc42zUmm4gCcd9C5ym3jeKMBgv7+OjmFuO9x9TKPhFz96qDJmQ==; s=purelymail1; d=tinyisr.com; v=1; bh=m7IHSkZEUu88sqJeHdwKupt3xgnbuvYT1gJue+XSGfE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=e9VyW/46sbwhnR5qkA+pOcXlvqzcUB5L8+3g4nYfaGxgR/rd3G+BIASNtRYS32pp5gUR+Ajs5jLDLdzhAeD8UuLIxkouBvpl57Db155+d6bLcZY/1fRW5Efd9I1AEJ2IzBb7pNP/XJ3+quk66j6O64cCrhLyTkVaUSXGMmlBsbdmDChzEGterIYpsa9VOAqxI1l8ywjjdSqd1uhgeJlCZSgSgxnd7DAz41jslln9IMSFZXG3QoOAmGTd2lWkfvOWSUzNyYkl2nMlYuD+oVC0oDPQYy6XkSvLSY+Y9A8WRkjD6j1cums5yATi8gsqE+T4Q5zIoeFGx3YJbvCuc387Sw==; s=purelymail1; d=purelymail.com; v=1; bh=m7IHSkZEUu88sqJeHdwKupt3xgnbuvYT1gJue+XSGfE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1206586277;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 26 Mar 2026 20:44:31 +0000 (UTC)
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
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next 1/4] dt-bindings: net: dsa: add MT7628 ESW
Date: Thu, 26 Mar 2026 22:44:10 +0200
Message-ID: <20260326204413.3317584-2-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326204413.3317584-1-joey@tinyisr.com>
References: <20260326204413.3317584-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add bindings for MT7628 SoC's Embedded Switch.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
new file mode 100644
index 000000000000..d3c9df30ed5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
@@ -0,0 +1,101 @@
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
+  The MT7628 SoC's built-in Ethernet Switch is a five port switch with
+  integrated 10/100 PHYs. The switch registers are directly mapped in the =
SoC's
+  memory. The switch has an internally connected 1G CPU port and 5 user po=
rts
+  connected to the built-in Fast Ethernet PHYs.
+
+unevaluatedProperties: false
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
+    description: MMIO address of the switch
+
+  resets:
+    items:
+      - description: Phandle of system reset controller with ESW reset ind=
ex
+      - description: Phandle of system reset controller with EPHY reset in=
dex
+
+  reset-names:
+    items:
+      - const: esw
+      - const: ephy
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+
+examples:
+  - |
+    switch0: switch@10110000 {
+        reg =3D <0x10110000 0x8000>;
+
+        resets =3D <&sysc 23>, <&sysc 24>;
+        reset-names =3D "esw", "ephy";
+
+        compatible =3D "mediatek,mt7628-esw";
+
+        ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            port@0 {
+                reg =3D <0>;
+                phy-mode =3D "internal";
+            };
+
+            port@1 {
+                reg =3D <1>;
+                phy-mode =3D "internal";
+            };
+
+            port@2 {
+                reg =3D <2>;
+                phy-mode =3D "internal";
+            };
+
+            port@3 {
+                reg =3D <3>;
+                phy-mode =3D "internal";
+            };
+
+            port@4 {
+                reg =3D <4>;
+                phy-mode =3D "internal";
+            };
+
+            port@6 {
+                reg =3D <6>;
+                ethernet =3D <&ethernet>;
+                phy-mode =3D "rgmii";
+
+                fixed-link {
+                    speed =3D <1000>;
+                    full-duplex;
+                };
+            };
+        };
+    };
--=20
2.53.0

