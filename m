Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710541C2EF
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201912; cv=none; b=X3NZPPumFepEwYe0htq599zUgl+exrzCl7zRuFjlR/TjjEMqqiiRb5V6GdcL6Dsz4YUVS2WO8M6Ex6guW+qJ+9tzAekntL43nFgcZDJFQgnPLgxPYRmjXH2F+du6MtpxA7rC9ZHTBMhP6iurfhQeiJVccebB4IMPm14/vYOGbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201912; c=relaxed/simple;
	bh=HC9Umllw/UhQV3rgBtTIo/fWCOVWhQWvCTMxwy1tUJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnswoC/tzsjHCLHgQK9ObP+MgMXVESJaL5tdVQ/BaoGt7LsKwsLnaroYOVYzx8aCQ2p8P71JXnOoYxkWU4o8wFN8ZvbQGWPRQGa72JxC9ikIxPAsUbnmtiV5V3iqMOoYwo6lnR9ANJwig5VkQ4YBrs/TUcMkyVsDvkHjpBi7UsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9z1q4L/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9z1q4L/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49546c690ffso275605e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784201907; x=1784806707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryr2s2w0siIeOD0ExeDIYeRjYrw6WRSyoBeAvMjxr1M=;
        b=F9z1q4L/jczupaarn5vp6gCOcvuO+NTPIbS+0YF9myjMLeFa8bJmaoJ/s6Ax565ikP
         +XqR1oDZdpcW771cPizVXNJsLr2eieNjFU4DFGG97RJXQXPuUq0dhgq32mB+ws0CsA47
         s8u8sWheWN/JKUJSFITEbLug8eKWu2q57ekYaM23pKCVK37t5OjdMk9kfyh9vXHJOuIi
         pEOCtm30lZFHWF4rpyFEY/u2ReUEVjGSPx1SmruG+DgViYNevq1ijkYB+mKTDbpkCFMj
         5GUN0SbsCEfcMQnfxhkAABe7IPDU2ajIvAjDxTpKG6np8x0WX1upase5r/T+kSiuqZ0k
         cqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784201907; x=1784806707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryr2s2w0siIeOD0ExeDIYeRjYrw6WRSyoBeAvMjxr1M=;
        b=tAkHSISDaql+GSJqqXJactIhIBmCmj6IESg/olRW+qywOei/GB/zPpN852AL5wQ7/7
         MIeHtxnu7spQxMMrrCwBhdnY5eBguM/TR4XkjwXY9d1/Nl5tMQYHZnCcu7AeUvwDc1ze
         IUvwfIvKqWTI3hD8ErINuBX0oiCkXS1gd9OyTtUT4vMsKZPJ6dEZaE4dXkPziZNFSQ78
         WaXPqdlouvjBEdeEl3USC9DS5QZZ7U+6rQin6xTQdmnhAMxoE71t0ONhIte0bnK3KM2l
         mxNgNlqjCA/NMjqr2Km13bAZ6Jn6YcpI7ZxhKi+HyPrvCUXn8oYJBlSPZ7b0z/ySgpr7
         qSAw==
X-Gm-Message-State: AOJu0YziUtRt9EAlR4mNMrHyzkN9db7LKolx1y09Ljl5CufJzWjZkY2+
	zVMLz5p9VKfGmLSbqVgPLIF2X3tBqeNiaJnM4Z2R6cqaMhx2X2lN9GQ+hRYq3g==
X-Gm-Gg: AfdE7ck6sRkC7oQIedKVnfhMYDTsymXi30Nhp3St5JRlCFWUY4z9TgmiVfWgdVpqW/o
	ztppkWZ+gOkA7M3e/YgoObz5sJHi4+hSIbAS6rZAHBzUsa8gFfcMd6UKqPp0ODoDqmg9ZOcwgnU
	dZ/qX/grpl2omCVSbxWYRFjnNK/s/p9ROsBbGOBdHf/UvPXa/YEESo1ypUwjsjmkNJt1FRQ9Ksl
	1/Hnei3tC+Fe3LGY8t0z1o1hfqAsWwRPY/nF2np6IOu0IyawYU9BjGA+NzDSvgvaudyLKHK8/iU
	qGTHCZZ8Q3MrqxH5wCtz+vXnr/1J9OoYUhxBWb0Zov5BNkQ0m7KQUoBsLLV8Ww4IvvjQaOwxqum
	arCVtDc6Ek7T5jTLqhdRANxZW7aUT0RjBSgGmZYi6KQhQJbxI32wKw64PmQ6k8zfTOxZL/ZoeyQ
	xe0oIK/W+qH62izQLgpl8=
X-Received: by 2002:a05:600c:1908:b0:492:41c9:886b with SMTP id 5b1f17b1804b1-4953c1620c0mr74288235e9.14.1784201906695;
        Thu, 16 Jul 2026 04:38:26 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83bcbsm49217165e9.4.2026.07.16.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:38:26 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
Date: Thu, 16 Jul 2026 14:38:03 +0300
Message-ID: <20260716113805.593215-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716113805.593215-1-a.shimko.dev@gmail.com>
References: <20260716113805.593215-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the DAPU Telecom DAP8211R(I)
Gigabit Ethernet PHY.

The PHY supports TX and RX clock delays in 150 ps steps from 0 to 2250 ps,
with a default of 1950 ps if not specified. The dapu,tx-inverted-clk flag
provides a vendor-specific extension for boards where PCB trace length or
MAC requirements necessitate 180-degree clock phase shift.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../bindings/net/dapu,dap8211r.yaml           | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml

diff --git a/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
new file mode 100644
index 000000000000..d4012fa17a1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dapu,dap8211r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY
+
+maintainers:
+  - Artem Shimko <a.shimko.dev@gmail.com>
+
+description: |
+  The DAP8211R(I) is a Gigabit Ethernet PHY with RGMII interface,
+  supporting IEEE 802.3az Energy Efficient Ethernet, IEEE 1588 SyncE,
+  and an internal packet generator for diagnostics.
+
+  Specifications:
+    - 10BASE-Te, 100BASE-TX, 1000BASE-T
+    - RGMII with configurable TX/RX clock delays (150 ps steps, 0-2250 ps)
+    - IEEE 802.3az-2010 Energy Efficient Ethernet
+    - IEEE 1588 SyncE support
+    - Internal packet generator and checker for link diagnostics
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    const: ethernet-phy-id0008.011b
+
+  reg:
+    maxItems: 1
+
+  rx-internal-delay-ps:
+    description:
+      RGMII RX clock delay in picoseconds (0 to maximum).
+    multipleOf: 150
+    maximum: 2250
+    default: 1950
+
+  tx-internal-delay-ps:
+    description:
+      RGMII TX clock delay in picoseconds (0 to maximum).
+    multipleOf: 150
+    maximum: 2250
+    default: 1950
+
+  dapu,tx-inverted-clk:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, the RGMII TX clock to the MAC is inverted (180 degree
+      phase shift relative to the data lines). This is a vendor-specific
+      extension for boards where PCB trace length or MAC requirements
+      necessitate clock inversion. Only use this property after hardware
+      signal integrity validation.
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id0008.011b";
+            reg = <1>;
+            rx-internal-delay-ps = <2100>;
+            tx-internal-delay-ps = <2100>;
+            dapu,tx-inverted-clk;
+        };
+    };
+
-- 
2.43.0

