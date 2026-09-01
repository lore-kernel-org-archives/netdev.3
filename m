Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16432EAB6F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788221775; cv=none; b=I0YR81RZMvzFJsoT8P9CC0/P35zPCgTsSks1aUsniCHpKA9XyVrftbj74OweGvbZ6Q9oSstIIWw8AJCav5GjdJ2k304LfNimk1Gyw1BX4UD+snLEwCm8fJlSfTyZT5pUmCRAjg2xTpHRJjsUwJmfRKu4FyPQtXH8B1Ad9doWIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788221775; c=relaxed/simple;
	bh=StKsJNsPtTcRRY8bo5L6swA7DbwLeXDGPuaR8jqYlVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SoTaO8HRRIjveAEHHtgzKTnYzznD4xrBkYrkKgq6ZAsKJ3n7CPZSW/j+S7fbKZvRaGHQCTcMZ+1OrKlzNZgNKJ5ugp12omX1CXTUI3toU5UurTHQixB2pLGev3ZlOZJCZGdb6lgFWtR0zNYDi2odq57OqWbyewebYeWj+MrrGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgR+3pbn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgR+3pbn"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9d290216d0so650176a12.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788221772; x=1788826572; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oh1Bjs24XivyOxbmYNyWwsD17pfqdQrLoXvFWU23HTU=;
        b=cgR+3pbn7jPG685EFN9dM6J83+zM5UvUNddmVBveC6qLJALpBJw8G+Yk5qauJntQZR
         ea20qIv32VxIJeUu0rcxmBKp9kg+qkJb3RRbgUDOjgHYKe9uCpKX/Uonu9PmO/N4SPy4
         kJqVmsQzOjusRv4jm/jZaBUHYGMK+82hDzGn0rFd0eEDvcI9y5gc74MOtGO6i0r43d5d
         2EggXW7s7rjDdMA/f2mPxPna98sfMaPXzl/SI2XYEBqpUBA+gD+6nT7ADLvRR29OM99u
         J5CQIEQ3iDThbZgPr942SbH3/lDqL8tulm0V+2mITua3x/w6X6Wl78Ncl1Fpr1kGNbXA
         W9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788221772; x=1788826572;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oh1Bjs24XivyOxbmYNyWwsD17pfqdQrLoXvFWU23HTU=;
        b=jlwybNK2YlHrhmJlISWt+fFhWS5FvdVyMPBmoIHCXpsrY5/IboI4Vdh7AyWV4YpGkE
         PVPuN6bg8gkmQJhd61GcuBkKnnN/BUt8X3gUE82h+nhSiE+OpGvE6UHk+drKUZjHa4OH
         tmGczyJ7erzhn1dFk2vdAaNfejmVBz21R+33Ag2crETxxue1Uf4ZAibVLvEpnUq/T7zb
         /lwqtvr+DDS+mLCgTR9qcXf2MkRa3iPAvdFZnhfEXBauXoLxFfJUUt0L5ap9/eEo9lOl
         EfQZ5A6G3YatVDLxtXf9IP9Jmp+uGqjbFI6eiYOppKluuqQD9Yn9o9gvnpsnC0qyEUDO
         1FZA==
X-Gm-Message-State: AFuF++kIYf9VeuSGnUKoZetpu1HFZldh1r8O/ri2F25K34/vT9JluPwY
	4Tm102ub7PeaVxEUoGui2PvBqKp0cFloYYAPr8gBBy/lxjd2Ss5tr16i
X-Gm-Gg: AYBFou01bco5egaH3yACPksCrsyL8nPRGBO5sA71pHS9kRkxPRRrGaYz9SKUfm4gX0D
	5I48c4SMCYSUanmFwJ8div/YK8hI+4wCJbiFsVKBR+d/+u7GAK/0FtoIIvW574EmE/IDh6x8rQg
	mNfEKzU6KylUdj3ky00voyNImXcHg78xXKOqb2INuK1g0VhhPoK0jzc6PoprdZeIOF2uMbqf03A
	255DL2z5xJB5NYNZSbaL/xFkMRTPoBgK1c1O/wYNFiRmEUYWm6t9cym5c/Q2DqHVyoYufDysUEm
	ZT2U2fcDLVhFxGdgUg7M5cr7lyYUi1lQ2lcqMA/z936KPX/iN1CjJiaFMxKDhSnw4mzlzFTG/NV
	Vqw5cRpPektGIwuuMZMBmJe80W9F0dpB7Unfyd8wQ8dLI36JCBnO5KOi3oLbdrm1lHkaMmO5vj/
	9os7Sn3OYpuDHH05vSQlm4IVj4Nn64FmWTNP/3iEbT2DtMwvcTWzaKG+/LOOVbRaNV6zD7p80=
X-Received: by 2002:a17:90a:d2c3:b0:398:cee0:67dc with SMTP id 98e67ed59e1d1-398cee06896mr8018745a91.5.1788221771896;
        Mon, 31 Aug 2026 17:16:11 -0700 (PDT)
Received: from [10.60.78.252] ([2409:40c2:5002:4362:354a:8f21:7ceb:c8a6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b49c867f5sm19196398eec.2.2026.08.31.17.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:16:11 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 01 Sep 2026 05:45:50 +0530
Subject: [PATCH v3] dt-bindings: net: ti,davinci-emac: Convert to DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNywqDMBBFf0Vm3ZQk1jy66n+ULkIy6kDVkkhoE
 f+90ZVQujwXzrkLJIyECa7VAhEzJZrGAvWpAt+7sUNGoTBILhU3QrOZWHCZRk8MB+eZRm91i95
 daoRivSK29N6L90fhntI8xc9+kMW2/m9lwQTjUiptglUK7a0bHD3Pfhpga2V59M2vL4tveKNrF
 axF1Rz9dV2/LAFRdu4AAAA=
X-Change-ID: 20260817-ti-davinci-emac-7ec97feca43e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788221759; l=6674;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=StKsJNsPtTcRRY8bo5L6swA7DbwLeXDGPuaR8jqYlVk=;
 b=tRSTQ5iiDd4Dk/+xCnjIYv9ghT7Ha9LQpqAE/d7Nm0Gg1LQalXmKjINT6nLGeGuh9E6OFW15g
 1eAqjAiQlbHBCu5FRbvo3Fx/sXvYZPWJnG4L16KN0Y4hPSLMtVZOqO8
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert Texas Instruments DaVinci EMAC binding from text to DT schema.

Changes from the original binding:
- Add clocks, clock-names, syscon, power-domains, and ti,hwmods
  properties that are used in existing DTS files but were undocumented.
- Disallow syscon and clock-names for ti,davinci-dm6467-emac since they
  are not applicable to that SoC.
- Allow 1-2 reg entries for DM816.
- Make clocks a required property as driver probe fails without it.
- Mark ti,hwmods as deprecated.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v3:
- Rebase to latest mainline rc.
- Allow 2 regs for DM816x only.
- Link to v2: https://lore.kernel.org/r/20260818-ti-davinci-emac-v2-1-805736d99e65@gmail.com

Changes in v2:
- Remove original text binding that was left in v1
- Link to v1: https://lore.kernel.org/r/20260817-ti-davinci-emac-v1-1-022678d966e9@gmail.com
---
 .../devicetree/bindings/net/davinci_emac.txt       |  44 -------
 .../devicetree/bindings/net/ti,davinci-emac.yaml   | 127 +++++++++++++++++++++
 2 files changed, 127 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/davinci_emac.txt b/Documentation/devicetree/bindings/net/davinci_emac.txt
deleted file mode 100644
index 5e3579e72e2d..000000000000
--- a/Documentation/devicetree/bindings/net/davinci_emac.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* Texas Instruments Davinci EMAC
-
-This file provides information, what the device node
-for the davinci_emac interface contains.
-
-Required properties:
-- compatible: "ti,davinci-dm6467-emac", "ti,am3517-emac" or
-  "ti,dm816-emac"
-- reg: Offset and length of the register set for the device
-- ti,davinci-ctrl-reg-offset: offset to control register
-- ti,davinci-ctrl-mod-reg-offset: offset to control module register
-- ti,davinci-ctrl-ram-offset: offset to control module ram
-- ti,davinci-ctrl-ram-size: size of control module ram
-- interrupts: interrupt mapping for the davinci emac interrupts sources:
-              4 sources: <Receive Threshold Interrupt
-			  Receive Interrupt
-			  Transmit Interrupt
-			  Miscellaneous Interrupt>
-
-Optional properties:
-- phy-handle: See ethernet.txt file in the same directory.
-              If absent, davinci_emac driver defaults to 100/FULL.
-- ti,davinci-rmii-en: 1 byte, 1 means use RMII
-- ti,davinci-no-bd-ram: boolean, does EMAC have BD RAM?
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt.
-
-Example (enbw_cmc board):
-	eth0: emac@1e20000 {
-		compatible = "ti,davinci-dm6467-emac";
-		reg = <0x220000 0x4000>;
-		ti,davinci-ctrl-reg-offset = <0x3000>;
-		ti,davinci-ctrl-mod-reg-offset = <0x2000>;
-		ti,davinci-ctrl-ram-offset = <0>;
-		ti,davinci-ctrl-ram-size = <0x2000>;
-		local-mac-address = [ 00 00 00 00 00 00 ];
-		interrupts = <33
-				34
-				35
-				36
-				>;
-		interrupt-parent = <&intc>;
-	};
diff --git a/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
new file mode 100644
index 000000000000..f0c539d1bac7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,davinci-emac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DaVinci EMAC Ethernet Controller
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,davinci-dm6467-emac
+      - ti,am3517-emac
+      - ti,dm816-emac
+
+  reg:
+    minItems: 1
+    items:
+      - description: EMAC core
+      - description: EMAC control module
+
+  interrupts:
+    items:
+      - description: Receive Threshold
+      - description: Receive
+      - description: Transmit
+      - description: Miscellaneous
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ick
+
+  ti,davinci-ctrl-reg-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: offset to control register
+
+  ti,davinci-ctrl-mod-reg-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: offset to control module register
+
+  ti,davinci-ctrl-ram-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: offset to control module ram
+
+  ti,davinci-ctrl-ram-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size of control module ram
+
+  ti,davinci-rmii-en:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: Set to 1 to enable RMII (Reduced MII) mode.
+
+  ti,davinci-no-bd-ram:
+    type: boolean
+    description:
+      Indicates that the EMAC does not have on-chip buffer descriptor RAM.
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to a syscon node providing access to the System Control
+      Module (SCM) registers. Used on AM3517 and DM816x to read
+      factory-programmed MAC addresses from eFuse registers.
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: TI hwmod name
+    deprecated: true
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,davinci-ctrl-reg-offset
+  - ti,davinci-ctrl-mod-reg-offset
+  - ti,davinci-ctrl-ram-offset
+  - ti,davinci-ctrl-ram-size
+  - clocks
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,davinci-dm6467-emac
+    then:
+      properties:
+        syscon: false
+        clock-names: false
+        reg:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am3517-emac
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@220000 {
+        compatible = "ti,davinci-dm6467-emac";
+        reg = <0x220000 0x4000>;
+        ti,davinci-ctrl-reg-offset = <0x3000>;
+        ti,davinci-ctrl-mod-reg-offset = <0x2000>;
+        ti,davinci-ctrl-ram-offset = <0>;
+        ti,davinci-ctrl-ram-size = <0x2000>;
+        local-mac-address = [ 00 00 00 00 00 00 ];
+        interrupts = <33>, <34>, <35>, <36>;
+        clocks = <&psc1 5>;
+        power-domains = <&psc1 5>;
+    };

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260817-ti-davinci-emac-7ec97feca43e

Best regards,
-- 
Bhargav

