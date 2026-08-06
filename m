Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739923AC0DE
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979473; cv=none; b=QHrmYJpeVEhqgmPn8zh1G6g1rLix8SocJf1dgabmGRmeiH0PHfXwFNTLxNPQHZ+n3Dq34Cgrf+ciPxGIkgXvVRHpMkbtXplxQWxVcQ08IK2X3HoMUAPLX4JKgvoG/cCEdiyqs6IMgbZBLsG16tX1cYiMF2ql1rvC2b8a0q530oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979473; c=relaxed/simple;
	bh=akgH7FdSu8hkxoqBxRW5GrRYagY+QZDl3N0wKNP3Em8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cs9HKuUtiTmTHDF3KDmNDdR3PlskHspzEm7KLwTPgii+HDIf4BQDwxbjhWa+9E6/61EKuXi9jCJEUo6cBO1gluZtEY5E+e1CMnFrlLSabkNwMdvPMe7ZEmx/oPpL3PnUYkXedtiih/1VZoCf2C8FWV/M0q8KwFY4jKMpTkriAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyH7YJ7z; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyH7YJ7z"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-497e6956acfso384445b6e.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979470; x=1786584270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3lkDhLHoHy7Deukicju73PIuJo/3t9WiJOLY5QufbM=;
        b=FyH7YJ7z9XFZ9jLRWWQt5bbMDPzoKOiyOPuH1KsokP/P8ItHnfmX6Jz0FE4kblJI1c
         tB8mPGLz/O7rcKJDQom4XKPGQPqpqUtSO+ahxh0ygB7DBmtVhQYQeUhGYygxEvNTEpB3
         Yyi+f8Q066znL4+ArZDgyDa3LQO8Q7SgC0VgSAhvAx9K659Bz/agD6JvOssN0oGkXpR9
         MqKmyMammh2wosSYIONa7qJFxd4j0r5oU3/fcpqu9k6OmAgUEnT1dzMkrfUxy1C7P0Xz
         trYN07LfqdkHe533UXs/qctN4LvKtEeLB6U5pkKwCmbu2Y1PNCHGVFkdLKb1WkKW4waK
         2ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979470; x=1786584270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3lkDhLHoHy7Deukicju73PIuJo/3t9WiJOLY5QufbM=;
        b=c28vCePyjSOAmv3WrMkJM1fKbCbcJyzlmR6hyB5VezjB+aAYKf2I3B0H0jiDolRdnA
         Faw/j73/c3RvcjbpAF+GNCeUPHhwWR6PRC4zm9XUVpGgdWgEMpWxSy9BTIuPFpEWXQl0
         kGDCcTisbAwTRX1WC09vbnPDNSSBykXlhTrkDqdIUGev2gNGqb+DkMvF23ng4H85wfrC
         40Zb20yRGvKlPnMerw4CbtaFOTsGRGC9JAUbCn6MasaacOcAr//VJm5MshwbqIE1YF9f
         QoLhv4fxPYi8h/zUcvKrchWs2d2ldvk91+FJTltCTledqRd+JGOScgj5ObxQLMmGmSti
         1g6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpb7jSe/J0IaJFMAaGd65xFOt8Nd+ssboU5wvmnADyLfgsthUVHWSvaEXYIxV4abhgIziaTXQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzxL9EdOvTmrXkH7+87KHzX0/2XLQllb4T2vHVjQPs+9LIwjD
	41m12HFkDRawHH/Y0KKqsqU4PU21wqY0SHctNIfiuRnLdpnDHc6Cj731DfTtNi4x
X-Gm-Gg: AR+sD10oA1eg6Iw7R2J9XRGba7L1F2dxPYwyOCBB5jFBsgfv0yHQvrl2lD7M6orM+JF
	Vh31TDWAIe+v2W8khcxgxhusCNi/AACydKT0cgxm3oFF7VaF9XbeQV5ptB9nUEOHWnkizBNZeq4
	TfRXaWD/3BI1feFa88hN98pXUIqu+5XV0JUMscJP+NMracizlua6mnH9HznBnp4fGLwfO2GtnhE
	UDAD0wVbDT/P7627QzQ18qvokC9UVaTIkdu9KleZNIYzTgwCdI8z34KHnbsZ5SxmU0vlMZLiKzW
	Vsi8Qk3z6Lng+6MJmwNlTH/h0TT9K/F8gK850PTbxj6pel2vclFo/zxCvO+ZdgTvwBCL4Waq8Ci
	XDC3sPbT9FWVLMkKI4Y7HV66QNg0Tt25/GDsxI17c/Fv26gzqTF/WWX3TdvdRAgz3fM8I/M6lgJ
	B3DgIl3W12FxH601cjVtZgBbS8GlMrtgfP3zXXVmELLaCeGM+VS8WlVOVICmdeeeADFL+2ANnyn
	JsAD82XO1JzUk0K6LHbUbobQMji8PfddbelZxFJLbVurLlajjzvV+SgBB2WrTl1QAMa1owPi3vu
	dSf/OKeNDF08cU9QBTcxneq86zbIVy0e9SxI9fwSBiTZl4pNu2qNA4M2kYnoF615xKQZiEl7OQu
	X9tV20r3rX1YZUBki
X-Received: by 2002:a05:6808:19a2:b0:4af:58c9:2541 with SMTP id 5614622812f47-4afcc0278f1mr181689b6e.15.1785979470332;
        Wed, 05 Aug 2026 18:24:30 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae75db20sm3274755b6e.14.2026.08.05.18.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:24:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 05 Aug 2026 19:24:18 -0600
Subject: [PATCH net-next v3 1/4] dt-bindings: mfd: x-powers: add AC200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-submit-acx00-of-dynamic-v1-v3-1-32c3210a6f25@gmail.com>
References: <20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com>
In-Reply-To: <20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2

The AC200 is an I2C-controlled mixed-signal companion IC containing
audio, video, RTC and Fast Ethernet PHY functions.

Describe the parent device, its input clock and the four package
supplies. The Ethernet PHY is represented by a PHY package on its MDIO
bus, with a phandle back to this device for access to the package control
registers, so it does not require an MFD child node.

The input clock must run at 24 or 27 MHz when the Ethernet PHY is used,
matching the rates encoded by its documented clock selector.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/mfd/x-powers,ac200.yaml    | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
new file mode 100644
index 000000000000..b7e8d9bd5661
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/x-powers,ac200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC200 mixed-signal IC
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC200 is a mixed-signal companion IC containing audio, video, RTC and
+  Fast Ethernet PHY functions. Its control registers are accessed over I2C.
+
+properties:
+  compatible:
+    const: x-powers,ac200
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      AC200 input clock. When using the Ethernet PHY, its configured rate must
+      be 24 or 27 MHz, matching the rates encoded by the documented EPHY clock
+      selector.
+
+  ac-ldoin-supply:
+    description: 3.3 V supply for the audio-codec LDO input
+
+  ephy-vcc-supply:
+    description: 3.3 V supply for the Ethernet PHY analog front end
+
+  rtc-vcc-supply:
+    description: 3.3 V supply for the RTC
+
+  tv-vcc-supply:
+    description: 3.3 V supply for the TV encoder DAC
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - ac-ldoin-supply
+  - ephy-vcc-supply
+  - rtc-vcc-supply
+  - tv-vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mixed-signal@10 {
+            compatible = "x-powers,ac200";
+            reg = <0x10>;
+            clocks = <&pwm 5>;
+            ac-ldoin-supply = <&reg_3v3>;
+            ephy-vcc-supply = <&reg_3v3>;
+            rtc-vcc-supply = <&reg_3v3>;
+            tv-vcc-supply = <&reg_3v3>;
+        };
+    };
+...

-- 
2.53.0

