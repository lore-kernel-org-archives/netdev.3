Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8636C9C0
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752266; cv=none; b=nu5Hwwra5BVYo/KQf47lZgoMlqeb/yGStco8UYMrGsfqRHSsBW8Fk9MBsDYDpn4wPmNme3x2+nottzcm+QW3ChvRiB62WUB/ziLo1Nj2jXbQ/Hsxj+SU5o535qJtVTUPhJubsha6N17xPSp73W4IlqRuzczhKWTjYffyHkjAAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752266; c=relaxed/simple;
	bh=ihxYljt9TvSONhIQg9chU2CaRvgGK8sqjjqdKQaNFaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJvFkltOXexs4rV7YT9//gOfprpOuAmDueG0y828TJ7BDGQVfVo/GCPGf8b48qzsMoa65nM2UTmqiuyb/0xgBMyhX90tJlbI45XayqHsih02Sf8n8HEH35fqldKFsSCVNguWV3+WF06ThguSjNVPqc1fvGGpV5SQxwi34ZY9KxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDJmuL9g; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDJmuL9g"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c12614b81c9so514837666b.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752262; x=1786357062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BKK29opAwoDm9NA+sehIYh0i1MrAbhgyis4MH0MRWRg=;
        b=aDJmuL9gyjSBcG4iVbPCUm7TiQzojbCezEL+HyIjpOeywEipBGURuE4FBVMrzk5rqG
         Zs4nNmDPEopLq9z1YkAnrxbMNLWNTNfK8QxYDw74PgZpiqgKVsgutl+MLdoy/d7Gber6
         KFL6NX83G7WgYch9CRL72A738yRVFRjRzcHTFbn3/S0+4BK9iSNtYif5EYkpfDewTOLo
         ToHDsGOCKK6f5asNDKuc/E4qNlWyB3H9QEhBSyVV+m1cAdWgsVY0Jxp3aokMG2tjgdLS
         aExfG4qv2vdk4MT/rncz8jAEQ8LfluiWX/V59Kb+kdOT7XNT52rfYrp5aO6ysozYBDMA
         14cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752262; x=1786357062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BKK29opAwoDm9NA+sehIYh0i1MrAbhgyis4MH0MRWRg=;
        b=JbrTSIFEU5XNo46Rw4Rch4DF7pejFDQY8FRxsLxKRsn8P13pPMyqEBnlMOTlycbhws
         O9Nva2HjQPNxWhO0uDFJN4UU/8UO7F75GToOtzGPxedN2CrHExuRkMoHsTsMgNfHm2fn
         Xa4WPqwsCtNMzxKULrZUpf34ISyQ1SOg+qnZC4katvJ/lvpN/4Bi9bKnYf/sgRaSECxd
         fxVieZvfPfE0JGAXmn9WQn3viE9lPRinqj8U0XEk/TDqe6+jJYb4Z2qPzIUJVfjycJDE
         ji3ptva5avGhhG5JssFmYyrmZ7Df1goFkFUJKSMQ6FK/l8nSfG8whgdTLN5U2xZHn2+Y
         7ZYg==
X-Gm-Message-State: AOJu0YwZ3u5LamBQ/FaIancnM1m7Ty7n2MOcbTcSsFETP5IR4d9qWCiN
	KgK6KxR8FA9CCkfXOcI57LIdY7VruuILCMSpSXDu0GpVm9cuKIP6RZtKzEDKRQ==
X-Gm-Gg: AR+sD12dVemz4p3a3kH5DeEGUGqiYPy3Hs2JGQVrkkjI6xscrStovdR02MGi6J+cTiU
	dKY25e0f5cxkHsqMsFNYSGNNp+NzDPjhhbnmafv3vquVWa9bjmk/OUyw02Nt61Zgpr1SKJa1HRJ
	9jKHJHOLoK1MJPgJsXzz9qbofll/cB6rIa7yarp1HvJDuyvX9FUxRKYI9U0qXN4Z8dXoLKA5VPx
	AYdrZOIdFJVV1ebxTlvrAX45cq2Qifh/ycLgJ5Xs3YRwlmJapiqRXYkyj3erJt9RQ1WEofmEnj3
	Ta8C8BqHGaz/CT2Wh4a3eOfQ40E/jx0X68ZZUNWDXJbmgjvYeP5TJRsg4VGNHXv371AuI2sYpEn
	w05e2t0W8yoKgaw2uh3J6OSvHfQVgdq62q9M/jnw20vy5JgBWuWoDoDU5RK62vNnixsOYU0j6BT
	8PEM6d2OVo2IN0RYyK5MGvi+aApb4JF9OcDhPEqOwGH2GNX6TRX59n2gO+a6G/Ph2uY7mve3C9
X-Received: by 2002:a17:906:dd9:b0:c1c:4afd:8d8c with SMTP id a640c23a62f3a-c1fe7f67f8bmr472940466b.14.1785752262065;
        Mon, 03 Aug 2026 03:17:42 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c6566b3sm5355731a12.23.2026.08.03.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:17:41 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/3] dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
Date: Mon,  3 Aug 2026 13:17:33 +0300
Message-ID: <20260803101734.270821-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101734.270821-1-a.shimko.dev@gmail.com>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
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
with a default of 1950 ps if not specified.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../bindings/net/dapu,dap8211r.yaml           | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml

diff --git a/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
new file mode 100644
index 000000000000..fb78fa4f58ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
@@ -0,0 +1,62 @@
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
+        };
+    };
-- 
2.43.0

