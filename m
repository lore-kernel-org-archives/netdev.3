Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0F3C5833
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896919; cv=none; b=TEwpq2LjmQeFUbWdqK4LEbwznwcJ1CmPwm02slnJpBb/ZZMDKmy29I4yxBvGw3FcUEkqkJ4WzQJFblCAbyv42Xm/qjiN0n5TbebFxyCE5PLOTUKx+mCarrU5w4hxOawqWKVB8hYVII4uV+c07gRsyrd1Z/TsQIDdduE8cpQmBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896919; c=relaxed/simple;
	bh=x9Lw0syNJki2K15bJqB51uvJ4FZQCZJczX77O6639L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pq7XLzOFHN6sFUkbRp8qbZzpc0v1hQJOBgd//UTA8gEhmaqCrjcpdW54ADfTdbvtZBr7ANtvYM7LSVSTgRSpuNSe2ch8Hp3SLgoRRpUOZ+esw9srZNC9kHLSFLb7IfqOddh1g/ZsIvKscBvbdPMbs6iJN1K7KGNROfiRVSx9Q3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eek7uyu6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eek7uyu6"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso611744a34.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785896915; x=1786501715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MjVtijpmJ/oNZWvDUTBmnWApL7aWLNJ+r5jlKeKXMpI=;
        b=Eek7uyu6hr/hilnOqZTQ6zEY+2BdCD4XLP4X2HrLhK1Y0dR6xt/gzWNzuuXDC13G0h
         DITxayog+UCRDpfBerqX81SdbmurJQei+qZPeU2k/PDkYaAOEiJU26YnBxjRQDduR0zx
         3iBfZtPXBjVK9UmVkI1Hw4AR+pclKc17bJf55MhZiKrDdFu8EH5tguYhs51h3wlVAjOC
         /THzF8BmIonJ9Zt29v398OtILyQR/9lPLVkKAjv9/BasSgPhgtehOnxs2TOyDUCtMF9t
         7/wy/tOq+KhsGe5IGa6Z2qDAT2/ct/hXsigQmRUk5Be6xHeY7UZYUo7a29etc9XhPsEX
         6xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896915; x=1786501715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MjVtijpmJ/oNZWvDUTBmnWApL7aWLNJ+r5jlKeKXMpI=;
        b=LKNrfa1jZeJ1cOEPjR8I4EvUieW3mgGZ2Ur8XeAuBLBJ22JzGcMayaNwVLs5HBn/sR
         HCoSivcc73EAlxHvg71BwpOL8JVbN/5UtrO2d7FCjv2tPv5Mq8AqL9D6+N+ecTwKYLOy
         XRuX8m14sb2AyngRO51PJONl9HZg3eaXAnA85M0Bgqw9aYbIvKRvW7HUQZOnG8DlwIwB
         zmCX2hTa3pihCvC801zUk7cW+6LQMP0QsqJnMmkLQtu3TZcOT4UK4l6BadXuDHa9ds05
         vtU9C1luxqXQYQC5WabDBybKb/jjtOzpdrv5ZkT2IpcHoJtizrTwKpKjlP883i4T+4zv
         78qA==
X-Gm-Message-State: AOJu0YzYkSftcHl79alxFegzVda/mQE1ZlLTXaEgfRE/wLe15bpNxJ8A
	l6BzOUxOGz1URXtPPzT/0dv6ojuk1M/J6aYdorkNXni7DO9+Gn7yag62
X-Gm-Gg: AR+sD13XZcZKouXywQDOk8qRqmrUTgTUUu/h0V6hwuqHlczwLarNdk+ceUWK3uo5nLS
	u7xaqqlprOVPVr5+tdAXIoh1U8NOquld0QfdJm5GM6gI/3Qh0EKFvyr9Z8TPTMpkKbOY1Pd6Wxd
	dGDXfD0flvqUNu1C3grdej6et7zy2upbInrs0/Ppx8u7Drfqfte0plIxX/C5mtHD4pj6QlOl5BA
	7Ix0S9I6L3Kjmtu5dAMVbuheptzPp5CzXVPdVc1fr7Gdb5d2zhjIwzGOomSvc3fv7rvxCO+hL6W
	zKN4spD4j+LQmY47xwCX5//b+Wi+LbP6aE7iE+98DNDOVqEtJ4yRv8JUjirUa/x4dG0YheF9Gcc
	66NGgnnz9Fe/6+9YK1UN/lX8X22rn+lENXWC3ec/umf63hQDerEUR69x3eEkIIi1ujAHz3nPXLM
	lpBmwkB0k7ysJZsG448s/xiIUAL5SoItDqA3cvHK1W0Einy8X/EoTa0vmsz71Utca1ka5NnxtG4
	1irBeJG6MfhsEN3uUzT/VNMtfhG9D0CFZwbifL0hejWUyguTzmb2eXZeMF27borUNPYMHQ2SOJc
	MkvMxJGH9Dl6+xMVo5ZFc53vYiTNaa9+M18fp2ZhfRojxmM0S4TEv3pgRgnzblfA1um0zAXFcRh
	0+N2aC/A5Opu7JWOifLYEBW0H66E=
X-Received: by 2002:a05:6830:3741:b0:7e9:ea28:4c1f with SMTP id 46e09a7af769-7f1e5d893e2mr2408593a34.8.1785896915399;
        Tue, 04 Aug 2026 19:28:35 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm2078153a34.16.2026.08.04.19.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:28:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 20:27:05 -0600
Subject: [PATCH net-next v2 7/8] dt-bindings: net: x-powers: add
 AC200/AC300 EPHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-submit-acx00-of-dynamic-v1-v2-7-3eef49ff1d8c@gmail.com>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The AC200 and AC300 MDIO link interfaces report the same Clause 22
identifier and use a compatible link-side paged register layout, but need
different package control interfaces before that identifier can be read.

Describe the forced-ID PHY and require exactly one reference to an
enabled AC200 or AC300 control device. The PHY node's reg value is
programmed through the AC200 control interface. For AC300, it must match
the address selected by the package straps and is therefore limited to 0
through 7.

Allow a system to provide its optional two-bit SID configuration field.
Bit 0 identifies the AC200 or AC300 package and must agree with the
described control device. Bit 1 selects the AC300 low-calibration tuning
sequence. Omitting the field skips package validation and selects the
normal calibration sequence.

Also describe the optional xMII receive-clock inversion needed by some
integrations. Requiring an X-Powers control reference distinguishes these
integrations from the Rockchip RK630 PHY, which reports the same
identifier.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/net/x-powers,acx00-ephy.yaml          | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy.yaml
new file mode 100644
index 000000000000..c280bcf8aa25
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/x-powers,acx00-ephy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC200 and AC300 Ethernet PHY
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC200 and AC300 expose Fast Ethernet MDIO link interfaces which report
+  the same PHY ID and use a compatible link-side paged register layout. Each
+  package uses a different control interface to make its MDIO endpoint
+  accessible. A fixed board references its enabled AC200 or AC300 control
+  device. The PHY node's reg value is programmed through the AC200 interface;
+  for AC300 it must match the address selected by the package straps.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-id0044.1400
+  required:
+    - compatible
+  anyOf:
+    - required:
+        - x-powers,ac200-control
+    - required:
+        - x-powers,ac300-control
+
+properties:
+  compatible:
+    const: ethernet-phy-id0044.1400
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Optional two-bit SoC SID configuration field. Bit 0 selects the package
+      variant, with zero for AC200 and one for AC300, and must agree with the
+      described control device. Bit 1 selects the AC300 vendor low-calibration
+      tuning sequence. Omitting the field selects the normal tuning sequence
+      without validating the package variant.
+
+  nvmem-cell-names:
+    const: configuration
+
+  x-powers,ac200-control:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AC200 Ethernet PHY control function
+
+  x-powers,ac300-control:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AC300 MDIO Ethernet PHY control device
+
+  x-powers,xmii-rx-clock-inverted:
+    type: boolean
+    description:
+      Invert the xMII receive clock inside the PHY. This is required by some
+      SoC integrations, including the Allwinner H6 AC200 connection.
+
+required:
+  - compatible
+
+oneOf:
+  - properties:
+      x-powers,ac300-control: false
+    required:
+      - x-powers,ac200-control
+  - properties:
+      x-powers,ac200-control: false
+    required:
+      - x-powers,ac300-control
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+  - if:
+      required:
+        - x-powers,ac300-control
+    then:
+      properties:
+        reg:
+          maximum: 7
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
+            compatible = "ethernet-phy-id0044.1400";
+            reg = <0>;
+            nvmem-cells = <&ephy_configuration>;
+            nvmem-cell-names = "configuration";
+            x-powers,ac300-control = <&ac300_ephy_ctl>;
+        };
+    };
+
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id0044.1400";
+            reg = <1>;
+            x-powers,ac200-control = <&ac200_ephy_ctl>;
+        };
+    };
+...

-- 
2.53.0

