Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BA4DDB25
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562277; cv=none; b=QAiID+Zn04TRDOWnZogRnxWxNx5qCAQMqzp9yMlHXsbHUM8i2mGNGCB+lduJ3WLM6DfPQdTGDlZmob0j2QZ/Skc3m3kIQrdixw0dSgyGoeEywnXp1eWLKMTjOt+nPGu0QEL/nCop2Vgqew785CHWRP4YODkyklyB5xwqT3kYkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562277; c=relaxed/simple;
	bh=eGGtJucMub/H5IDPYhp85xFBOadbNNPXVb/tk0RokT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmBcPbxFcnDpNyzwc0eEc1GrQGwvjQS+WXz3KmCgJjj+fJ5V9V9SZG5gjWEhlpvPmiT9ycYfiK6AdDsr1WfyUhFtxjHr4qUqhbUk9vQUE5doTnDDqdbAZsb0y7wSH4cSf9zgY2k3ZD+ixXBm3MZi6nWljZS7Q/hyfbD2AgZvTkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf4uIxRe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf4uIxRe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso3506394f8f.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562273; x=1792167073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sGFrWQujhzJh9uPF6notnBiKMTrdwWirz/MP50Av2KE=;
        b=hf4uIxRecs4IjO0NfSMyIrWk5qlQSqlHTdUiLQhYbbR8nG2EDg7YQnXeQzxGmXYl76
         9qb1TLXcdgYm2zyMjVl9JB4yg7J6Uk5GpAY96donflSkQ2NEtxkFSf+DpaD2dEAC7sYe
         oQLQVWfi22udYUc0E4KlFl000kGiZi4riHLjxKZJeW4gcEtsw/IDmSQRQv4Exa2YzO8S
         XG+VWYi2J4/ACFFmK4j0jw+PcjiqmPWndzBlR0rmycQyVPEfC+mix0WxmgTv9UYJmh1d
         hI/xjHbfWao81LhDdR4aw+mkK5BvYXRI6DeFOMVuiD0t+lNjqfz5dSbzHwuGUqvdCrzW
         0g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562273; x=1792167073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sGFrWQujhzJh9uPF6notnBiKMTrdwWirz/MP50Av2KE=;
        b=yRhFK1AsrTFpkf9R46Iznh0MLzduaZd0c53KHHVY1mDiNXPUGPpJ+WupOpFZbLjIYM
         Fbh+Y/+BYr8nFEGYFCoslTbRwahWhTRNFi20R4r635hiZ3W+QGbExEPSe6rKOFUz0uUs
         8qZtvnhBmQkDGSwZ4PCQtO3vACZSqAOes8b27FKqoXYWYIPT1iMDMdgeKznEs1eq5pg+
         XcL5EV1uXcAmqmLE8ezHL2OY75W0QCubSBDeZZBv4iy67YGUIEgY4mkFmu4oeJhG35sx
         9XdC6VG7qXV+CmogKr+pslVSXTMx3uUyvFiRSKGiCs5y92dhLK8YDV+dPTuPWR6AnhG4
         Sofw==
X-Forwarded-Encrypted: i=1; AKwUvBy7mpK1P8KWhdDfnHjBYpodkuLJQWJyzV1yc7I3Ea90tinQwYXnb2slhU4bp0dtqM+LUWooEw0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbyZ9KoQIm0EZUN9oEtsxTlxLPUenl2R88g3MZdhlup69vYU0s
	b7ofopxPYpzOYC9Gin9Qz3IyqGlsEY9GMNd2F0IWszS/n3kxVBYrr7tG
X-Gm-Gg: AYBFou1GbOsajdiC5QUqxf6vWsa2q1T8iczLTXZU343MZN8iM+9B4wFcRibZsPpNABQ
	1zevyIrkylqjg3/nIX/fNE19ntI4rJPTLsGSNnxGaIMDi2TJx4H75tQwBwP2AWHUOuqiihipcfS
	Y6AQ1ue3GuYmyT1T5M/EUCEUoYKPGS/dACES+UNSVL5bwVJ1RbVVK/e6xzHwH+e9IUfXZ6CD8zC
	byla4TiR0fUb5fqPe/zWgE8x445hnI8mXKyXUkgUijX1USFtfmIVZMxOF2FxyJam/D/3b0Lsyxz
	jUpnhVoHMv+uNYyDpX4lBOT2OyVEFHUTA8CluBmO6vZuBkw62OpXrhbC9cExLpinubz2SoJOBct
	DPPjucoRnSyBVU53iWLycz7y0LpC6f6s3wFBkwFCusOIU+S8otB3yDlO5nLA8Xu4ApM5t2H1cYs
	+K/qvz6gag41ALcM2K++FshfIrqNPg/xFqBDgRR4elcgx7gKvKVFZ9+8tj9dihaVse6shbZlKSr
	rZ31Vkk/fZ/umfaCPq9wunRJ8vc44m62wdE+ogel5vUibvVsklrGj1lCn9JkKNvFkWkHci0BeWz
	p63GwB+DUIXMRr2gzA==
X-Received: by 2002:adf:e007:0:20b0:48c:656a:f36c with SMTP id ffacd0b85a97d-48dba77cefbmr3915875f8f.3.1791562272816;
        Fri, 09 Oct 2026 09:11:12 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e2f08sm4744701f8f.15.2026.10.09.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:11:12 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v25 01/10] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Fri,  9 Oct 2026 18:10:46 +0200
Message-ID: <20261009161102.38961-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009161102.38961-1-ansuelsmth@gmail.com>
References: <20261009161102.38961-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 5-port Gigabit Switch.

It does expose the 5 Internal PHYs on the MDIO bus and each port
can access the Switch register space by configuring the PHY page.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
new file mode 100644
index 000000000000..5ad9b9e13983
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Gigabit Switch
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch.
+
+  It does expose the 5 Internal PHYs on the MDIO bus and each port
+  can access the Switch register space by configuring the PHY page.
+
+$ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: airoha,an8855-switch
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet-switch {
+        compatible = "airoha,an8855-switch";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                label = "lan1";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy1>;
+            };
+
+            port@1 {
+                reg = <1>;
+                label = "lan2";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy2>;
+            };
+
+            port@2 {
+                reg = <2>;
+                label = "lan3";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy3>;
+            };
+
+            port@3 {
+                reg = <3>;
+                label = "lan4";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy4>;
+            };
+
+            port@4 {
+                reg = <4>;
+                label = "wan";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy5>;
+            };
+
+            port@5 {
+                reg = <5>;
+                label = "cpu";
+                ethernet = <&gmac0>;
+                phy-mode = "2500base-x";
+
+                fixed-link {
+                    speed = <2500>;
+                    full-duplex;
+                    pause;
+                };
+            };
+        };
+    };
-- 
2.55.0

