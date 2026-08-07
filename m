Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86993CF21F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786078320; cv=none; b=cX7IBhy3SraEF9JdZD96OAJKNvc3pyLtnRTjw4W3b9DtDcrAhYoSmR878a5+ZbAx/oTwuu7QnlmjEVbNLLDPwTFw0PzNLEa6sJ753gcl9sfnYT7H1VSxskjr5vWwNqqkSpWV4WOQGuRdo1FxjStIuk4yH6lFn7WzrzGzElJpQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786078320; c=relaxed/simple;
	bh=akgH7FdSu8hkxoqBxRW5GrRYagY+QZDl3N0wKNP3Em8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WOL14pRA2Misq7IJJvqXZozIRkrPguP2tt9tQx7TTrijF76wZ5uYkDhtACBiNldOHOnTKIbcjObdoAtup/duOOg8jvgR/DaGs0vvjvMowIBvozYRRpBnuEWBAxarXrBxNLw5rgPnhTGlXB0H/83tG82rTOlfKS9Pd5EfRUeTkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVrsIXl6; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVrsIXl6"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6afcf32fb65so663684eaf.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786078299; x=1786683099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3lkDhLHoHy7Deukicju73PIuJo/3t9WiJOLY5QufbM=;
        b=FVrsIXl6OE9cuNfhHiseBY+FKmPwv7vKVL1xDapMz18tzSQKKWaEJfIOJgj5pV8qFB
         aM7MK092m7Gjy4UvnxKN0j6T7KwN/W6GFqN0prKcOV/j6AdcmXW5LZvDEAepzpOcsF4E
         H1ycg9blekSm06NNQvIXR9U5IMBoA6Zx0e2xM3QIR4cJulyqkCJkpU03x3yuVWhrVphH
         AKneDsx5xdNdyQHyKwjGtdEsw/9+ChzER2cH6tGaQPCP7hc+gT91AeW/dWzh711zuh5o
         VFrkt58GSNNiFbEo0gWyEhaQ/OMuQA683aFsyHnkCmbl5I0yDOMemgjV+cC6V5PHdEhh
         WEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786078299; x=1786683099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3lkDhLHoHy7Deukicju73PIuJo/3t9WiJOLY5QufbM=;
        b=ce0KTCdks2ej2eJ9DrwkzXaI8BCCWZmtBnKrLv747R+Q5OMni8W5ouL/YV6AdrbsFA
         INJxpQwnBZdIhZDIQIPUetyv6iZ2xA30Z03RBkQ+23tOY5h+k72o69StKMa2LAon89dS
         8q+nbN47i+hc8HyKPm9Z50MaUKpYRkKqqm2eUs6nWNZAiAYbC5NChszYNvT7gqVZY8Vc
         6JXzWhUkJUjlPOA4tzAu+/tpM19rC92bKfNRTJ1a2TXgxcQj3WLm3gBiMDvRTs1KN0N0
         bWq6jbNOtKbnsVn9KWvndQbwsjrlNhHwWnjIszN6TQH2BiOQUuZP0eC1G1RJUJ9VfZgw
         tF5A==
X-Forwarded-Encrypted: i=1; AHgh+RrWf7zCsUU3aqW6+XEMi7MUB4qnm/cL7iRjxBZ76VAEWSZt+N8vUceR4rrGWmJKkVH+xt/FZlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoNQVn2S7pMswrqQkwV0MnW5DsLGWB9y3+ARha2Tcv2R7jlT4
	GYXkjgm1+GwWR266XA94by+6GRS1vhubVDO3a9LEC8pX6EudYLbJ6r7q
X-Gm-Gg: AR+sD11gwn0q6wXaw5/ontJSyGRBJolVeg2IFZ2AYQ3rO+AcIdJJvr8R8OdpWtrCswo
	H2ssLtT4Ly3Ua5ZzzPD4FgUwLgETBnvQdPKr0txhaJxuWhutTAAtaHlM1t7zWCjxB7sjYU6+Ksr
	94p9EkoPYYKn3mYYHzi5lcAmla29NB08/Z7Wi+wZLEYVf5uukk+xybeM2La7YNnCxNU72B6bNj3
	ApKxiJALVWg56NjcQlszWbbeHaTQ4w0EUNL0B0sQhdBx4puOBE5aDcEXTulBNN3+cedJMepvDgS
	kH8RyUP3ACCEtC9D3nSk4d3HCXKduhpeJ3S8ksMFsN/IpAVir1RLyrX1b4mj3efB+ZKqED0ITa+
	3vFue/DrK+vzhZyXnE+YTSCZtle3TvCdP6lSAMcZbpAZmRae+9tmCl+JEYwUHOBJCfk0mdBmAvG
	fGp8CBrt0lXI116xlvs4+Ek7lmmyDw2U0PZM+uLS1Awp/0njz5+rGT02q8ikZF5/ahpHQm2zjwE
	5vs8qG6HFxRFbd7ibNSJnADD4kyWB+RKdGX/3MRHj/mgp6T4Q1BVVvEayXMuNqjFYfyd5ToUE7W
	DekJ8/pRKVpO6kGfoFRXX1cY/QfEt4fEbNgHcsKrw4Yi/7fvqbj2jyCWBP9+TLa9hPkgvfnyh4S
	oEKu4yg1Ef5+oY6hM6w==
X-Received: by 2002:a05:6820:1996:b0:6b0:1b86:fa8 with SMTP id 006d021491bc7-6b01b8625afmr4347810eaf.15.1786078298727;
        Thu, 06 Aug 2026 21:51:38 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bbbf755sm1519726eaf.2.2026.08.06.21.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:51:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 06 Aug 2026 22:51:26 -0600
Subject: [PATCH net-next v4 1/4] dt-bindings: mfd: x-powers: Add AC200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-submit-acx00-of-dynamic-v1-v4-1-9bf2f7441632@gmail.com>
References: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
In-Reply-To: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
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

