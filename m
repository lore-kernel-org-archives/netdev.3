Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD523D649F
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307345; cv=none; b=JMHXRG8mULN3iQX2dvJ4zrJ6auLqzoZmyqOIG1x37tuAd6cQWv2wLioOkSc3uep3xjRPAeQSAhZZc84az5NwnNzcwRgORJDj6sV1UCuRkewJh3kDTaAgJ6VM383J3TyvguCt8llKH6e7QfXXJ1BPVh/2eXOgnUi7NEIrlxdDi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307345; c=relaxed/simple;
	bh=vXJST93REa+QH10dPJYzmKclTq5eGMoIGhB/tPIJFyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9yWjEwRs4J9GNL8AYB9bf3L8jrjG6kxofkYtHdw6N4KIuKjY4y8RGAbZBV7rbZkZaJ1y0TlUqooMn7ZZoiz2fAWDUYRTntWPdkMJR2bMaD8j/p4iZEP3CLuncv+iizRlFuCJg4X1cOluhXP9GPposhuBuq3sMWgkttdKFtao0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Im1ncH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Im1ncH"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb9b427da2so2133308a34.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307342; x=1786912142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6fiFh2L3bx9YuuvYvD9BsidmGnYklyUdwY2Tqg6czVo=;
        b=E1Im1ncHIl4r3LX7WB7u+NEAscNVD/QSFsC9pb0C44ZeWH51udBqlUQO3YgFveX3PQ
         vwNecbChmAOyiPFxdSo12zkknrZL006NvkR0Qzze90AmedBSlYzNhjrmbhs58qaamKnj
         HIdTnFNt0Gih+ij0w8cEwyysmmlHbCkqVGEYx0Vl9BvZBDXlNX2gYun6EH4fK3aM6IqP
         +q3MiVFdtWdPVXy+EBLsnbS1AWQ6wZuMfElpjdhYg7HWfjH9eg/4G5pFiFmPvnHekxe3
         KkCGoh6gEuuBaR932DwNAh+UUCMWF8FbMO9aJU5YSK7OxhvAmyPXpscgdPCsIDMLZlYx
         A6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307342; x=1786912142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fiFh2L3bx9YuuvYvD9BsidmGnYklyUdwY2Tqg6czVo=;
        b=CTyeuEV9Jy2TrxfbysJHC+ZGSMdNb8XgzTdM/5hRuL+bHR+vwaMXdmalnBvD/hKtMG
         Gl/KWk0aKB0yDmSIdtj/x8wtsAERsCc9EuIAIP19I4UoXXOoRtxOlubQABDgnfLoRMRL
         fg7QKW7411iKjnxzEYOsPYMXThtjuI+z6vFeGOOgxw48NbfnBv5xCn+5tlIpCkhPADSR
         D8EMegnJPsq6wezj4XmUJK5VpXtexfUvpC38oKl3gpDXnV6RIF/qm63oiRM7o9MmjskO
         Z2WACmezzjcY2nKc9RgMzHBEIi9BK1d50XRl+8ppOkV7zOdsbIyga2KwGU0AgAJYoSR0
         JVyw==
X-Forwarded-Encrypted: i=1; AHgh+RpzDbDeCzJd/Be8k5DOJLehOx62nkJ7DXLiMrixHVZNT8qRY+iwS9yDKZqy44jba64CNSEssiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniAeSeuS0VVnBpytp3QvZu6jtGZCOaYFAfHfYdCKNWmcylX8s
	xy+/4Ax4wJtX7RRfdDhWR8AsfBxFvjE5YpH2XgtgQ0zj8slIKFWZqLm5
X-Gm-Gg: AR+sD129vyZV3dYexT1Hu+xIFyEOdZnYxJjEQmXp0UvIVeO0biU+L/j2b5040fHjJdT
	5JCJ2bpkayIUl+RhzEAjZm6oEngEE3/GfEPoNWZQfNGqtvpw99Rk9ykjABBxU/rprQ4dvFXRCeA
	0n9QMkWaxENhCSDRvQjorrbQHBkR5Pa62hCI7UsVx6un9BQWpkuzGif01rZoQy4HRQ5xqOYNKkC
	sWuR1KFyyXwte7qtTSgAf5CcPcKGHiEjfoIfohpuKite6tzaysYVHMQ/xS6Ze7T9svX4A9GdKJZ
	Juu7+9vgbKtKcCK/Q4cl8VJxGY12r4JtGIsoSR8dXbsTgB9GMuic1iF/ka8y9HmCP7LSeSZIpWt
	HmQPa8zJDyAPYoQZY9lplY5AWalYl44YVTPo7xl4PVl7x2hinpAK75rKncDjwW57iedVvBp7g/T
	rTb66FCfjUkzeA+e7CiXEPPUBooE/ONjNGPkIHnnJPGOPsfkDvU2UFp2iQbhtyFQ7EnwVBe8VA/
	KLcvhoD9KmG9iL+YxUbvdDb28Ql5/gTkwYVbNSpISuc++dXNjZNijirorqUpmfJNLuZrKYzTfpG
	XT3KvoxntbcQGFqEcN7kkADPH7EypTrqIQMfuJcwZwbaR8C9SMzSVNuLMxDfuvQd+2hOS4265BY
	9740ovHsXgiM6pZtacGcPts/uQHaY
X-Received: by 2002:a05:6820:1996:b0:6ae:960e:d285 with SMTP id 006d021491bc7-6b045204fa2mr7051201eaf.15.1786307342322;
        Sun, 09 Aug 2026 13:29:02 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f19fd31csm6975362fac.1.2026.08.09.13.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:29:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 09 Aug 2026 14:28:31 -0600
Subject: [PATCH net-next v5 1/5] dt-bindings: mfd: x-powers: Add AC200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-submit-acx00-of-dynamic-v1-v5-1-bfa1f8518b28@gmail.com>
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
In-Reply-To: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

Describe the parent device and its shared input clock. The Ethernet PHY
is represented by a PHY package on its MDIO bus, with a phandle back to
this device for access to the package control registers, so it does not
require an MFD child node. Function-specific supplies belong to their
consumer bindings rather than the shared parent.

The input clock must run at 24 or 27 MHz when the Ethernet PHY is used,
matching the rates encoded by its documented clock selector.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/mfd/x-powers,ac200.yaml    | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
new file mode 100644
index 000000000000..609831b15c80
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
@@ -0,0 +1,49 @@
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
+required:
+  - compatible
+  - reg
+  - clocks
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
+        };
+    };
+...

-- 
2.53.0

