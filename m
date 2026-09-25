Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B34409273
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360696; cv=none; b=CiRsa0Rbx58DXPmP+lTSRGPNs8U6pIWVLfaMNLgK/6syrUEB400dBbi6hqh4qoehj2gLADXhhls6Hjq7rqkFDaZOPVoaZNbGXqFdyVdCG3xChIIOD25zM2ISJuUqJEFLa/Euc8TG4gcLUIpwQjHbP8uXxXA7ypPQNuta4pIkYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360696; c=relaxed/simple;
	bh=eGGtJucMub/H5IDPYhp85xFBOadbNNPXVb/tk0RokT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2J2zeRXHsHlvBhJa56IKJ3ugk5LZeY7sdKx73URazUeEax1SwSgHChsQinIqJDuVFzwAbiwj7wlBVaC9qQd9B4Io0Pi1Hj1ShsrVQVr4fBSMiL0CsEY+Yk6Mh1dUdfheNyP9vFYwCy4I2iOkIpnQbBYKn4XtWWS2GbSa61lunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHx6nf/j; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHx6nf/j"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887840c529so427249f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360692; x=1790965492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sGFrWQujhzJh9uPF6notnBiKMTrdwWirz/MP50Av2KE=;
        b=SHx6nf/jKVF/rh3Bhkgmi9Yy9tZsndxQ1iVeVwOqVulKh8ryPGsjBw3IGpEIk29FnS
         m+3FtUzyNanqBrRm0CfOkKBfSsHnTHGtqH1wAVj06JttA0yhLhCdinMKElTRNXnnG9vo
         VdMH6CzjiNbHWT1rxYcPNN0VYFdk+mNGgEI0OAUn6XHvjVBrWIeqkNMykjdOgng0WFr3
         X+pJLfu1iKW0a53PZV8WYbrChofrU5TB9W2YuTt8USgsVgaaeE3bGDCUW874oTBP2mdn
         4TX8u0kIv4QnOQOFM4xRQ/m3J0dLbVjfhI7xYTJLVsibuzjfSr+QiEA2PFj0zqni3w4F
         26Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360692; x=1790965492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sGFrWQujhzJh9uPF6notnBiKMTrdwWirz/MP50Av2KE=;
        b=Fu6cglKVOHpP+O9jJSkkgagdny991rBUi+YF5GoQh/LtqMHWqxcsdDRT43JJmr8idU
         pFHFfHpYZqKPysRzETVARyIGL2Fji45ydA5DmQUhC4Z+7ybRQzcb9EjZTIL0b8upwKoN
         Q8NBJQxKKgk7All1ol9UJ3r43uFLVEqcMsLBK925gtm80THStiYswEDP6AKrp+Ybqp/U
         4ivOMBGxF9e9q4LNZQorRWqw+9jQ63QZB/oJKdu+7aW5XcqpbZZuYW/9W8n5kNM0h0bL
         aggqn5ZMUu4b1UGf9i7o4qrEwlPmLT0iwIO4LmsqcyRNLptYK80VYDUDF5DPmo2OVwsh
         7CLw==
X-Forwarded-Encrypted: i=1; AKwUvBw8G9Po8DMqdlpJwfkxCH/gvJ1fL5U1ShezYABUQoEi9sHPEfbgtZ1/UMn6czYGvIFerYcq/G8=@vger.kernel.org
X-Gm-Message-State: AFuF++lWtfZQIW05NgGtGLx1eX5CqgktN5GSmZbTLRI5vByjK+zBB87T
	F1GzpCq+npkW+sW9RYRqfHs4u1UJQivE2HhXw9p4gl3CeoKXUqhCYNmM
X-Gm-Gg: AYBFou20b0i+d6JXQn41gZhFgS7hAfgd7sVZLl+L5zjaAOqcl7sNqCAZXs3hQ6zpece
	72ZZlOFXeEZkhVNpxUi3qwzjStwQkOjSJZ3p32oBtfz9i9J6ZY09Hf/rvcJMe6fkdieJ80eNAqz
	sYtcwovtDIt6egcLkYAR6sIgCnYSXP4vOqlox0JmqWd7MFGR7us/eiFuRliOfvZxg3QR42PzcIz
	9ubUmHGUad+KdjuCrh49dktyntE6gJ3uI/qJ/402AuMjxbmSWuk5CmdtwvyU5AraIPB4qsm13SP
	Yf6dX2IctpU7bLFnv7M3mHwk9IAYbqpC00Lh9ZwMm0oX+B4aCsYz+ENxD4ppLGDJ1vI3sxMpjI/
	LRv+WMfQlJ6waXSyjvPtpxrTziF48qPeQjnmMtJuLEL70zfwkDrusvnpvb5LUtuhBzfc71LjGXG
	gzfefxW61int/tSpeD21DyCcwY3K08yHh4UWLs22fvRu/PpsJXrAEqeJonhJgEjy6A5S3pgzU7k
	eO2ch8GtJSFwCEQ+Ohkl2QgTgX0kd4lScPsCBp0Mlxc3wIcdkVmJJSneX2d158QeA==
X-Received: by 2002:a05:600c:630f:b0:49f:d69a:1a04 with SMTP id 5b1f17b1804b1-49fe6704682mr112960035e9.16.1790360691982;
        Fri, 25 Sep 2026 11:24:51 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-29-83-136.business.telecomitalia.it. [79.29.83.136])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm266231245e9.12.2026.09.25.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:24:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v23 1/9] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Fri, 25 Sep 2026 20:24:23 +0200
Message-ID: <20260925182435.21207-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925182435.21207-1-ansuelsmth@gmail.com>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
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

