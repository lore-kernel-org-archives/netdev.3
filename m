Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCB3D5C3C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475911; cv=none; b=hXAgBZ0SH7kR1o7VrcU3YnKP393e1tW9St4igteLyQuDBjn0Ke91X0e5XY0Gvb36mOW8eI7uf27gtgK1nWlhvT8N34At+GacPt80ZnoIVwR8Zdq4mUEG3fo0gD5ZPzQ1YUsJiHMsptzOLHZCUGXbCsF8MwFTsl0+m62sdYWTmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475911; c=relaxed/simple;
	bh=7y5S0ThKweBnJIFIdstxVs81WWiUsDlt//Wvk+p7bhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHRWoP2tQ9u8CsAm5SvRtQ5FsjMh7QdFYWuk8a2vVwccOxTrFe0/8aF8ZXrwGFZf0k0dnZO+JEWd9eUlIRxmMMu2k0ixpXpt9O5UF4k00kZxx/lJw4c8929zqGMwka6ABn81OXXkBcrW7hX/2l/RRRSJNV2ZevJ70eRov4Dcvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHuDjvhk; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHuDjvhk"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso22843675e9.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475906; x=1790080706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EBth4tRMg8GOGvhksLcEkRFTz5ARAzMlbCo5jt8vu2Q=;
        b=XHuDjvhkpfjjroKtuJvBdH1GP2adgn85txZ3kkfo868eqPh0bEZ1Zri65czug5ym3C
         6512mXmJ0rPVdFcKSYhvG/LiX9lFQ84vng7yy3AnuGWwuh3eR67pn8Ed6Q/nydbCe1qK
         jDJN4OFQe2upv9VrFOdnAqFP7i44pB8ptoRMgj9fz1SAIcgbutQVxtyDroNH7C5fStjc
         qg3+/Tb2KHmAZ0aEPAsytEUF+BsxZ0yrwjU6r8Fax/1kAGvLmqi0uA1xIxLWaLaVN4qw
         06CKTabqCks70lFOYBArMm6z7W+9dZPwnpOXEhjNDtX09WHHyD0SLPrxUSuW8PHXcz3l
         KndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475906; x=1790080706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EBth4tRMg8GOGvhksLcEkRFTz5ARAzMlbCo5jt8vu2Q=;
        b=ELzMaNom5L7b5amyAVUSJziob5f9LFdWYBDy32nv2X0ocIN/i3F+3j9g8DZzYqNrZk
         /0thH3y62Cso33BfzvfO541cpCuHVrVMe/G2qbm1rTwk/UTJ3vIoKIjDmwPc78cnRKOP
         t/QGAulc19ECW0H8y0DfupdEAf7SLqaSOjezudZthNtZ0Z4dqMI/SOqEXsr/5eeeJ9mK
         7e5NkCSgmkmLTiQICfHhjXzAVvMKy32BPTd/v5e+/n4ByszsIzN3SpfAQWEMq9IFSlGJ
         VkARXNnoSZswC778/pEs2Pc38np8i8akzv/HJ4UuE04tXbMFZU44T6ql8tL2VtznF0qA
         +r8w==
X-Forwarded-Encrypted: i=1; AKwUvBwCLMoYyg0Lv9RJy8kLcoIaT/X1/D6MQCa2Uu+EBbEZwzuoNM6c01zTmxxVn2kvT/DVjO3jbCU=@vger.kernel.org
X-Gm-Message-State: AFuF++mbYr2CTRKoBazLdTwyE+mOQ3v93SsVEohdCMqE3RnK1nKaUMvE
	bs8Yt7rmD+td2QDYJCp4MgkjlgCSvZO0SpEuq83YWq/PafTWdDmucLR2
X-Gm-Gg: AYBFou1pKd9FrI52zRoueZSmQXvkM0VrLQ93g0UzHKXlfyKFx4H4IwvfDGZIJtipYTq
	Ta9TEUwzvvvTlOoNTILuILnjyJ8/PPVAp9Ua29T5vVoNdr1O//6RjCMtnHeLkye9ENqI2eZeyuv
	BQ5C//OGSmo0YXWFBOXS+tY1ajY4yzG4o3eco0GQoSnQDiQ6ifdZIW7vnJ1k+1nlOrWpV3HzZ4k
	x1/64dR++wCg6ZNjzbYi9eRRkCyCjdgT+JyyFBzbY76TNfNRy/+O3tMw8/1oVAJDwvzKNUMHL8l
	F6deMyPhnZJlRAAP4qOkJD3PF+ApVWwkDXpAlppA67je6PaJ5tyVtH1vznpGb+bag1P8eg2ed+n
	Z2ZVENYCW8q9YKXv7AwriCk/ljojbAiFN7grKgkSS6JYSwbUgf98LCpjDVHYVxTX7Um53yuDBZc
	/3+uXdCq7wrk3jiQBzt43XWuVkQyNj57lJ9Rrvf9eda/FafgmBevIvoG49B8hBsiqKQyQU5a7QI
	YTw1xGg4n0N8vsp4pofdp4/Gs0tiZW9STmK5+pts6aO5wJsZJI70u7AY9L4YI7J
X-Received: by 2002:a05:600c:3b89:b0:49c:ff3c:973f with SMTP id 5b1f17b1804b1-49e7a692d5emr106570525e9.24.1789475905719;
        Tue, 15 Sep 2026 05:38:25 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a8d5asm62958635e9.9.2026.09.15.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:38:25 -0700 (PDT)
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
Subject: [PATCH net-next v22 1/9] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Tue, 15 Sep 2026 14:37:58 +0200
Message-ID: <20260915123812.14747-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915123812.14747-1-ansuelsmth@gmail.com>
References: <20260915123812.14747-1-ansuelsmth@gmail.com>
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
2.53.0

