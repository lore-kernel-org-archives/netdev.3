Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685943E084
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223219; cv=none; b=kLG3+jiUaNkJSOqeoOdZFboygwobhRSw+WAPwzn9GnMSiAcDVVABYnQkU0vIbazaUIqVWHGwrtgb+Ev5G67iqTCKcuQu0caI9eRMdjsQTgQVLAV+aajVky4KcZdYeTbnOTg7c7R4xBBystejPFOtcpdgVq6TwDrEYsn/NcbiKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223219; c=relaxed/simple;
	bh=HC9Umllw/UhQV3rgBtTIo/fWCOVWhQWvCTMxwy1tUJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db9hQzoayTfdwY9u5dySClGLd5PH+lzfFd7hbEM0CsQPE9V/RHnzWdSy1v6hy+Dm+Esa+X2l4muuIhJWyON6VnJsVqNFK4OL94Bgf2TjtJ9zYVV99RHEzGh/+XADrb/rJb/E9YmQDWq3KTUipkKu70Lcz8JdHF+KnvMmjGbR9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI+Ek/tx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI+Ek/tx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso49193355e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223216; x=1784828016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryr2s2w0siIeOD0ExeDIYeRjYrw6WRSyoBeAvMjxr1M=;
        b=NI+Ek/tx9cmtbNdVo8PjdLFZXyYZrP+wcgAyyN93JpEMW/HdEJ/QHMJ41Hsl5epUa1
         W+S3kHCZupfC9OE+009gRyXTr4z4hLjV/nZQOF01UQZcKE2duasTHb8kFH8z7rHtAguS
         WkDQV/WHxN4s44CTfJ3Qq2cO0jUF64WN/0NTK0rUn+ggD8cWKPDStcoiiCum8CIZ2sBi
         RmP/vtzfG4JacoNMXz5TupqE0D4iNTQF3lfm08dfX4qdXHR0mbEM1/JnJZPIW0fG+1nb
         I/4DX0G1Fg/SFiaQMXKkUgromHxilWvS4nUYA37N0/uMAqumzZoZocIxz1cRdHyXP8P8
         LkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223216; x=1784828016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryr2s2w0siIeOD0ExeDIYeRjYrw6WRSyoBeAvMjxr1M=;
        b=WH7lFgptBXa0GGlE9LdOOttwUnvjXs+u3+8+gTbVd2NRaTJuJeaoOnz0VbHu4491ev
         7QT7xHnBgzM13teFnjeVZOxx6EsQ3Pj5DB9WQT5xyb3qaay7+0ndxbif+H7rtUoVUizV
         isTn5VUi/y2wKsXVSBEKxO0abH11KnqIv2A7+6KI6kk7gpw2ufS0eAsgUyIXiBbCuYg4
         avmYUPKj8SD/Jic1m+wIafA3ZZkulBuxiZji1QeIgrbINCcmT4/7h34rEoSuVXm5CQ7u
         QNYwOMscYp7WGcJizys5Xm+vrSluh4dlTdn2/g5XKB+LhsJRxeFf9q3M4rp1hb2sujPs
         LE5w==
X-Gm-Message-State: AOJu0YwPACeGV2gOHns2mMfDjDax4pB6dv+O4DPNd2fprEXua2/dtIfS
	trU3keQzbJPhnAQSYHpGMxE2uKkacdxUYJwlT9SuadZZ2YeCmz9yVz438BIr4A==
X-Gm-Gg: AfdE7cmvvGqfOXUa7KZ2V45uU+eBTE3ih2ofnN1KS04yCPgwVFlP3z4jQuBEPJx2KBj
	HLzJqB6aefT9w1J12/L5ByqA4rGX5PB0KWwVE/uVepWa4yA/yXhzufmYsMwBfG5qgGDgaBEVTig
	VmVmMsHPrdxGYbNYr+DLGMFLo8vYH0738TiojqIKeLuO/kNgIfs508wYRXxahxZ/tz8CeQLpmd+
	om75Alnu8PUCXIN9SsWIx/lkWuelmQE2HKGokHPSxtZcM9j5/j4yY2UqcuJXjZvIZunGDhHK0iQ
	ttjpS/m6N9SBCrdyoLOgspoy6l7UxS3PZPx/dBcjHnbbZMcfNHoHU31Xkh1gzhuqPIxJDzUqK++
	YTLw12l//T+lRE/f0ULv3iAZ4FH2XhoVmupDmglbq+Dk7vXgFG9aSlUvQSqGMuvRbqQGKqSMVxD
	pKlGLLOAfifPGj0bJS0Yr+ILv9J3J53A==
X-Received: by 2002:a05:600c:8189:b0:493:bed6:85e6 with SMTP id 5b1f17b1804b1-4953c157129mr88207735e9.15.1784223215797;
        Thu, 16 Jul 2026 10:33:35 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb0343sm71768905e9.10.2026.07.16.10.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:33:35 -0700 (PDT)
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
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 1/2] dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
Date: Thu, 16 Jul 2026 20:33:24 +0300
Message-ID: <20260716173325.653164-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716173325.653164-1-a.shimko.dev@gmail.com>
References: <20260716173325.653164-1-a.shimko.dev@gmail.com>
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

