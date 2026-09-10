Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57758FD1C;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070886; cv=none; b=I9WAA0TiMi8+M1bHKGepoG4jPgNqEi9LYTbnsuAUiOg01TqpwzUEwbA6ZRlqfTkqZPT9hFPB98Q93p8BVis5pWKG+1bJNGhzZ4htAnPxhT7yKlMHRGbbutZzZxoZoKVeJa+wyUBpu0dvDy7pBbTWisKiMfUWbdGpi4zWas9TeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070886; c=relaxed/simple;
	bh=/VnniTwnoXBjNPQywRgCjcaFLbM4HVvnjXa4xa8hFgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuiIARyFGQJw//nMdtgj5u4/QZlM1VaFPDit4HNfFb8AwJRj1yHIyMaC+3oXi4mYyHOOSKO9WlSXJYZMPgzBrtjmv3fRY/JlDJk2FJcfzQgZq9DmTjFGER2NVTdgF69eEs7NyR6E0yjs75ohZSsSUkA5pgmr2YSjHcHCfN8lnVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdkRXoGi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdkRXoGi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45D1BC2BCC7;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789070886;
	bh=/VnniTwnoXBjNPQywRgCjcaFLbM4HVvnjXa4xa8hFgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kdkRXoGi94iN41xheavB3cTnVsP5efmQfDi1CeB32187VgOG098t/NG35ImCGVxG5
	 9e53sEwE1sEsL/gurWcWQr9khC52cj9hGQD5BQZnRPuqm5qdv20Fpy/kMRMdMLckew
	 JiBOM3+NAu9zLLLfVbEwDHx9wqu7jCQrQkQdb50irLeXcMHVM/likMMmpZ+OKmnN/F
	 1b8SqHhfFBT38bECWijZ7Wc0yAAsIyyE5jo/BmRLtHa9ZxZ1+sIMA/Hz5GldtRGinu
	 3TcCiQNiPBvSkxKqQ0lIbrj6qtegxtshVKN0PoBPPzK/tiDwnJDMg7CZ20spFCNlwB
	 LUOP4/QroIo6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22262C88E42;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Thu, 10 Sep 2026 22:07:51 +0200
Subject: [PATCH v5 1/7] dt-bindings: net: add Realtek RTL8125 PCIe Ethernet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-1-c1b9e5f10cd6@pardini.net>
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
In-Reply-To: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Ricardo Pardini <ricardo@pardini.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=UYU35l2Y2GghYNHCV52xHFRYzHVpr2XQI3dZsBGSAww=;
 b=owGbwMvMwMFoHWf/eN7xty8ZT6slMWQt5lOWM3t2ZK3S1tNpTK9OCSe3XHS5U1wTZPzuS818+
 a+61Va8nYz+LAyMHAyWYoosaySUeb6tf3XqjkfHZJhBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx0DHmIGLUwCmWluP/X9B3hG25g/5JxiX1P4+8lTgW6R29I4khja+hl+9bGcs9mbklnzJaT0
 9+0rbq1N7zTK5QrgVFSf8Niit/BK0vCbWWFrn+ZrvyYJMSUn16946pt24wxQ77dGiSSUML4VevH
 kjt8H6UYB3wxYP/RL9BTeenuqP6Hlr7DCr4ICes6jR7ZwgqYnRr+5xG5rbzXIyMKq886HnVvFZT
 ZWtftEKG4R4Vdf/nO3p2HVujtTib3Y7fmY+++xT8N31vDOzh47KjmDv0izD5Tw79D85PFV7dnFL
 I+PFDyWrLd0+9t7xTo6+NWvB1IjpsenX2FsvH4pJemL43nJtUpSxXMXlus6yaPt9ccvMF4gcZZe
 /7LT6OQA=
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net

From: Ricardo Pardini <ricardo@pardini.net>

Add a binding for fixed/soldered Realtek RTL8125 PCIe Ethernet
controller. As a PCIe device, its "pci10ec,8125" compatible is the
Open Firmware spelling auto-derived from its PCI-SIG vendor/device IDs
and is already covered by the generic dtschema pci-device.yaml. The
compatible itself therefore needs no binding to be valid.

A dedicated binding is needed because board DTs describe these
soldered function nodes in order to attach ethernet-controller
properties to them: a placeholder local-mac-address that the bootloader
fills in today, and potentially nvmem-cells, phy-handle, etc. in the
future. This binding references ethernet-controller.yaml so those
properties are validated on the RTL8125 PCI function nodes.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 .../devicetree/bindings/net/realtek,rtl8125.yaml   | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
new file mode 100644
index 0000000000000..eee13fbc1e6a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/realtek,rtl8125.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL8125 2.5 Gigabit PCIe Ethernet Controller
+
+maintainers:
+  - Heiner Kallweit <hkallweit1@gmail.com>
+
+description:
+  The Realtek RTL8125 is a 2.5GBASE-T Ethernet controller with a PCIe host
+  interface.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    const: pci10ec,8125
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet@0,0 {
+            compatible = "pci10ec,8125";
+            reg = <0x10000 0 0 0 0>;
+            local-mac-address = [00 00 00 00 00 00];
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6215fcb077705..f74c559a3fd06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -134,6 +134,7 @@ M:	Heiner Kallweit <hkallweit1@gmail.com>
 M:	nic_swsd@realtek.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
 F:	drivers/net/ethernet/realtek/r8169*
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER

-- 
2.55.0


