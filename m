Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59C39A04C;
	Wed, 16 Sep 2026 04:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533698; cv=none; b=m8LZ42AQBVlLRzb+wvALpI4MFfNR4drsAZRkwhKK9KVoVwojX4llvizzNbnmb+ZD979Uluu8dplglTLHDypcBpBZ0IdNgJ7nDV7dvkS8qPyT+diUtG7sP7ioEfNZ13AU6nthHhgq/F1/cDki/JSWvKkpaLxpzf1qtgeyxeEWICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533698; c=relaxed/simple;
	bh=7NPwQy2auI7LmLQm3SpYdb8l1i8zjUHB0l13I1dVu+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJErwAUV8DItRYz5DwWKEsUFNkikz+H8PO0PvrnHXWYKPfYbFplyKFIFX7rTcEcsUhSlBhsQnnMO2ZD4UehG/lFblEEz9JoiRqqjp/3RlJ3JJ4x5SW85oTmIcKBnvx0WjmyhRsoBHT6DEsYGMPHc9KkQsAWGigtZxbxEYfErvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=TVevDxfh; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="TVevDxfh"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 5165D424F1;
	Wed, 16 Sep 2026 14:41:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789533687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/UK2qpKtNV1mnmu2lxIpo6gk6uPMJBOxxrjbjHOjE8=;
	b=TVevDxfhqAX54sA9vZQWaBqtG2zSD+Fe4J8ZB3UfbBQbzBqtslXdfrAEeqtC1fQ96qI76z
	5AfPBj+mSDZoIrTHZDbnK0/kAvULYaMDkDb5IXM5+1UWsD21tn0VtitEEzOM1XSpsp4t0X
	TjhGRUUlZTgYMNWnBcstLBe6HvvG5M0v1LKn6Zu+AHLNs8qx468UcZaLwtaqLRfP93v4UK
	mbzORxn1jAJMkLN+Jp7l1AquUN2gxO6FsamKTCbbNAKiDquqOKCVgZNXoCiYKlN44CLkTU
	pDs6OkpBpQ2zyVIsaGpX5laoY6fOgDs5L6NPF/Q+H2vUuR4GqgvAojeeGH1nHA==
X-GPT-Reason: legitimate; this is a technical Linux kernel patch
	submission for device tree bindings. The mailbox (alastair@d-silva.org)
	aligns perfectly with the sender (Alastair D'Silva <alastair@d-silva.org>),
	and the content is a standard git-style patch for the net-next
	mailing list. The URL domain (devicetree.org) is relevant to the
	technical topic of hardware bindings, and there are no indicators
	of phishing, marketing, or urgency.
From: Alastair D'Silva <alastair@d-silva.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH net-next 1/4] dt-bindings: net: phy: Add Allwinner AC300 EPHY binding
Date: Wed, 16 Sep 2026 14:41:16 +1000
Message-ID: <20260916044119.475666-2-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916044119.475666-1-alastair@d-silva.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the Allwinner AC300
Fast Ethernet Physical Layer (EPHY) co-packaged on Allwinner
H616 and H618 SoCs.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---

Notes:
    Tested on Mellow Fly-C5 (Allwinner H618) under Armbian with Linux 6.18 and
    7.x kernels, verifying schema validation with dt_binding_check.

 .../net/allwinner,sun50i-h618-ac300-ephy.yaml | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.yaml

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.yaml b/Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.yaml
new file mode 100644
index 000000000000..a04416e78138
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/allwinner,sun50i-h618-ac300-ephy.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/allwinner,sun50i-h618-ac300-ephy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner AC300 Ethernet PHY
+
+maintainers:
+  - Alastair D'Silva <alastair@d-silva.org>
+
+description:
+  The AC300 is an integrated Fast Ethernet Physical Layer (EPHY) co-packaged
+  with Allwinner H616 and H618 SoCs, communicated with over MDIO.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: allwinner,sun50i-h618-ac300-ephy
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: ethernet-phy-id0044.1400
+      - const: allwinner,sun50i-h618-ac300-ephy
+      - const: ethernet-phy-ieee802.3-c22
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: 25MHz reference clock from CCU
+      - description: 2MHz reference clock from PWM
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ephy
+      - const: pwm
+
+  nvmem-cells:
+    items:
+      - description: Calibration data from SID
+
+  nvmem-cell-names:
+    items:
+      - const: calibration
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id0044.1400",
+                         "allwinner,sun50i-h618-ac300-ephy",
+                         "ethernet-phy-ieee802.3-c22";
+            reg = <0>;
+            clocks = <&ccu 81>, <&ac300_pwm_clk>;
+            clock-names = "ephy", "pwm";
+            nvmem-cells = <&ephy_calibration>;
+            nvmem-cell-names = "calibration";
+        };
+    };
-- 
2.53.0

