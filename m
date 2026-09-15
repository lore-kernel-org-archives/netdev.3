Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA248CD6D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475914; cv=none; b=FC1dT+CpyJNK9gOiz7J9lEvcEKedHm+8DaEVt+6JZOngnc7efolH4Dvzdp00yBMRNk9NHnT6BnjLX2roZzVlU7q+nktD49s3Zyp3SeEQsOgwrXcKx0UzBPJiVC+XQuVeeHPpw7AY3H0p+HO8kH2e9uskRPc22lfMeBylk1UGIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475914; c=relaxed/simple;
	bh=TtDaz1S2XoJCAkQ6yMlNi5cT9gUGaF3jEIf99JQb45s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqDppXVzIpOECFExWzs9FzPrlEgc96cXcYqtSUpQ4QXuu4VD5XFRVp8XCrDFxvc3/BhEGLqJGjtuR/s8hSjBB4YhOGCA18+SfQoTSiwgN2M2qbu+sieWLdBrhQSgcRS5cgxCzynkATJuJkwDwErBjW/R2SIE0vAgEvr5cpItWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYc5zfEu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYc5zfEu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so1514855e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475910; x=1790080710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nefrNojAo6vQreAbsmdFBgT6xPV/rOTuu+Wp6J/Zb/c=;
        b=OYc5zfEu76sHW1wnerfnIKyW1fD1vynot6VGL3XSvenq2+YFw7BlBHs+C9enH39Lc8
         WuRKK68NSTDmVDD2beBlBP33HCvKXoRzwUFN+P/wV9KUe1K8NrDavA5Dn/VMF1xfzzY9
         ylHF3xCb0b847fzV/T2F5hTf0lnYwWVI2Ps9gVKu82cOh75hZKiFX/tsOxdLK+xygVq8
         s+svJnQe0Wm3AOBgmQNhcA3vVXV6MotJQI1KnxAg4kpjN9wzaqLMn18G6ahagx3fEyam
         qZZtjPQRiqyaS3chSGIfMHhjsnzYUyeL1VJjJ/NxF+BGP9tYUiIqXySKpG/1ZPJ+fX4b
         Y9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475910; x=1790080710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nefrNojAo6vQreAbsmdFBgT6xPV/rOTuu+Wp6J/Zb/c=;
        b=hoxnSlPvpJsji/SeSzrkVf+VwGh1xGuHzV76dsO4t64AxntcbnzVcrJW69t/1PnG7S
         NzGe4sj5c/lBS0iiOcubEDRRfvlv4XF34ujH45k6sQ8QhvcUaqO1SQPRxN/tSJ5xWw6/
         /VbrHWH0nt7rz+1NUJupiPZQWl8hFNHtgffsHTFy45pVJL3mLsbH3fGk4hSAvITPHxSD
         obbVbZJ3aBm5VwgutN9HQZcNYbSHy1Q5aDwt7A1qFSFfHyJwp8uwWnNU7tnryAecKimz
         W622wLmYd7Y9lqv5KhCRUcQPl1FWgcY/bXRyTg9oH5N5OxAdW2yIZTI1921dwf3MF44y
         mozw==
X-Forwarded-Encrypted: i=1; AKwUvBwErTRlInOnGhHcn0vvNTTE1d7dT9S2PitFHQIuI8zq5w2j57lzJtHK4ZoF4JTw++Vde53osvE=@vger.kernel.org
X-Gm-Message-State: AFuF++lXQ2dqzemAqBk4UmU+n3NoYm4tMdOkhaDx6aQeelUHsjN8LarD
	Uc663zX/BKwZcsyd2r/jYljFIuirlQVWEsxh0hb32n8cgNr7EJ1la2+u
X-Gm-Gg: AYBFou3Q0H7pmHXwrfTokSrrXnv7Y3kAvVpEzUJnxAYB7JNT4y1MFNJaUxa5UFsLKXF
	d2NTkOFdaMmWodPtnLJNT1hfY8qGV3s0eOtJ1dexwzaCaz0u9C/tY2T4AR1lINH49jJLkh2N4e+
	XtfmsCgjRVeuZ9R0M9LIZtledk6NjoKDtxNHBohf/Kuf6jr4TrOndA/gMQW89ldL0rFpeefo5Nl
	hdkeVSWxp4wIVvFSXAP6qW94Uq+KEGxn8ItlutF6u5t5uQuAx6Lu8EaXDWm1/lmBAMNZf1ZMf7A
	sODh+gWpHe7SlI+5nJlCWGHRqpgsFWk5i+PTeLW0G2A3+NDoXhusLiPsljGORXBd4bJ8keGp+br
	fS/srp5TzPwmEgc5v1ndBP8SfKQXaQlRucJQ2UyMBQjaAhXBVLtv1DzwRlW6+cqSwA5b8BASXrM
	rqEQq4TnUHN7kSvZYthOdtNyVbMJw4dEb2safLcUsD3OyaSO85WmvnbsTjL4ihwVovEeSN0RX4n
	CMTQg4SE6yk+gKIhJfAzlq1nLmduX5TOV0dpD8/Wo06ac+78zQFeHgFGZ2y24A5
X-Received: by 2002:a05:600c:46d1:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49e82213fffmr15058835e9.3.1789475909648;
        Tue, 15 Sep 2026 05:38:29 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a8d5asm62958635e9.9.2026.09.15.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:38:29 -0700 (PDT)
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
Subject: [PATCH net-next v22 3/9] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Tue, 15 Sep 2026 14:38:00 +0200
Message-ID: <20260915123812.14747-4-ansuelsmth@gmail.com>
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

Document support for Airoha AN8855 Switch SoC. This SoC expose various
peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.

It does also support i2c and timers but those are not currently
supported/used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/mfd/airoha,an8855.yaml           | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..48127e956c96
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch SoC
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 Switch is a SoC that expose various peripherals like an
+  Ethernet Switch, a NVMEM provider and Ethernet PHYs.
+
+  It does also support i2c and timers but those are not currently
+  supported/used.
+
+properties:
+  compatible:
+    const: airoha,an8855
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  efuse:
+    type: object
+    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
+    description: EFUSE exposed by the Airoha AN8855 SoC
+
+  ethernet-switch:
+    type: object
+    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
+    description: Switch exposed by the Airoha AN8855 SoC
+
+  mdio:
+    type: object
+    $ref: /schemas/net/mdio.yaml#
+    description: MDIO exposed by the Airoha AN8855 SoC
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - mdio
+  - ethernet-switch
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        soc@1 {
+            compatible = "airoha,an8855";
+            reg = <1>;
+
+            reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
+
+            efuse {
+                compatible = "airoha,an8855-efuse";
+
+                #nvmem-cell-cells = <0>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+                       reg = <0xc 0x4>;
+                    };
+
+                    shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                        reg = <0x10 0x4>;
+                    };
+
+                    shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                        reg = <0x14 0x4>;
+                    };
+
+                    shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+                       reg = <0x18 0x4>;
+                    };
+
+                    shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+                        reg = <0x1c 0x4>;
+                    };
+
+                    shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+                        reg = <0x20 0x4>;
+                    };
+
+                    shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+                       reg = <0x24 0x4>;
+                    };
+
+                    shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+                        reg = <0x28 0x4>;
+                    };
+                };
+            };
+
+            ethernet-switch {
+                compatible = "airoha,an8855-switch";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        label = "lan1";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy1>;
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        label = "lan2";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy2>;
+                    };
+
+                    port@5 {
+                        reg = <5>;
+                        label = "cpu";
+                        ethernet = <&gmac0>;
+                        phy-mode = "2500base-x";
+
+                        fixed-link {
+                            speed = <2500>;
+                            full-duplex;
+                            pause;
+                        };
+                    };
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                internal_phy1: ethernet-phy@1 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
+                  reg = <1>;
+
+                  nvmem-cells = <&shift_sel_port0_tx_a>,
+                      <&shift_sel_port0_tx_b>,
+                      <&shift_sel_port0_tx_c>,
+                      <&shift_sel_port0_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: ethernet-phy@2 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
+                  reg = <2>;
+
+                  nvmem-cells = <&shift_sel_port1_tx_a>,
+                      <&shift_sel_port1_tx_b>,
+                      <&shift_sel_port1_tx_c>,
+                      <&shift_sel_port1_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+            };
+        };
+    };
-- 
2.53.0

