Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8A3A1C9
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896912; cv=none; b=Dpu5URal6QA9cgNwul5nfF915gJcSafEPIGzwMNeNWrLRK/PQA5X0XBNE8vXg0DEKODdUISZFyL0BD8oa2iHfoQDwJrxz44atjYZO4q8vlO0z0j2se5T0cFyjEvIdACB+ubeUTUhkWOgfA44pOnJQOmACKYcowUmIY4e10d+ZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896912; c=relaxed/simple;
	bh=R6g0JPwxdv7PypX7v84NybJBf7f2xtEhtnKMo6TTQpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7Yb7NgbpGhXhUIbQxVbcNSjz8RVgPV6xPqmwOinYVHnS16WoYd+JJhS5d/QsoVQuz9wUx69Hqt1Dnij/FxehOlVN9BBgmjtU1o9qQWR2TcchhyY63zsVQVDoum8uk4sT9NJTPfyHrxyR2UYMifh2/PWbUK0gEPFwNXG2YiXb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqGjSr+o; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqGjSr+o"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so464368a34.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785896909; x=1786501709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azC4yJVvIjculgK3P7AokYSHVCXvbgOhfjCyepYSyOo=;
        b=kqGjSr+oa9DN+NL0fyYNKVaFUIJrRBsEzIyoQRoXuSXn0+eazbdjEHfBT5SvKPwpKr
         rSjqHe7BNmlBoPxlWCfHyhLbbOsHAzwV34f2raJvc9fQS1gZ1plRKRzMw4GI18URKzA3
         N5XSt0iZk7sKQXZKqQj5C7lKgQPNQVPcyGX/xA/pei/tkVBrNc95ZuzgTGuJMzRNIyu9
         J3WEEkSzAAtfrH0MehIFL0KSyAP2RHLsFw6zjLXYo+Ybmd+/QT3Ou1s76I5Yj/LaTxln
         y8XWL8NgfsPTQHzmy1vCoKGfL3rJ1fLSELf1Gimx2iKKYmVPOdMchtFLx8BAw/3iZpzE
         pxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896909; x=1786501709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azC4yJVvIjculgK3P7AokYSHVCXvbgOhfjCyepYSyOo=;
        b=RNHMxaQLoW7UizTPvrR2wKKn3UGdFi0ZlGwv8myUt8+AXrJfDIfFS+H6ID6+J7j6bO
         Uxp/8UL6A6HFgckBDFguhN9aq0wOhswcPdarfbFF1ypmhEKf3Wlc6nwTDotVIKXjRTrZ
         ULhDoE0W2XMgkYdWPrYwO2Y0PVOcU9zMbmW/esSdibfTEsWmJaMST6BilsIhFTpYRDip
         tOctfkEMkMIqYH+DvNY9n26QvfhkCAfxDhf9zT7hnIwSEjwOd1P7NAeOrYwmcKk+cCWM
         W+tzsSrDyRbu/3HIvemt137x5YP81/dQCSJh/bGYvhMFPdt7eu9uuywAnhx9L+xyRQ5O
         7gTQ==
X-Gm-Message-State: AOJu0YyuZLXEqqQVLxhSjLkPYNxUl+aKD/g1EzNl4TwMPPEeVSLugfHx
	K2eOinRRYe9h2cLbCL3QJnrK/LEgK3JLU2TL1clFLXLgBDxvhNjjgNAP
X-Gm-Gg: AR+sD11MMkrJmgGQ5Vldz/2mpzyBaQ6/X/ILGZenKJBskVUIWAf4SrpPzZSf0rG/gBI
	7e3B9H0BaC1VySHYsuilB00wOC9eEAzK663kfuWcoYCok4V0fdoIMbCw50R4H98y3Va7up+98hP
	KgZla+q4JlDaIdDuYGXpIR0SfgwCKNwMEgfIGZ+2u8im9/zz1MK6yDo9qpc6Jl3la5vBCEfBDFz
	Qh8UG48OGIhPsrFJ7f6Oy4TXilY9/N0Nt7z6Bvowg5r/wcwza5Wzz12dFF5M1HHAkCQAFzx1YRG
	zSibyFaiGdfV+/HDT/CbXiPE73qIoKx68n0J6k3wVOBgB6OgVmuVU8x3PMgLuD7zR+9oZMolWDi
	Bs+HA2olCB0iTvQLfwKp09kcWhGC736Y/qbUZzKxZUjxS6M8rSxcdY89EI+/HjCAKGaNRsVlsRE
	xrRvBZX0T2hrMkLH0Uf2gm6LREPSITcKKAWSbn0mRhemol3Y7a5gF5R1nsyh8WQR7ttVnrpmLD3
	WXMNzfcBhAuc4xlTX8w2ecmu5WipGT8kDyrnMO3oZMaB1NNNnoHBN2jeV3+0jE2T2vYRQu2IxGc
	UaNotDWuA1eE39vFScyiZQWowA+CZHd+IWdRXFwa7TeZmCmnT6XKRfs2xoG5kPVuZ+84zICDQ7E
	Cidg5oCNcaa6oBRaV
X-Received: by 2002:a05:6830:2116:b0:7d7:ed69:81b2 with SMTP id 46e09a7af769-7f1e5d0f2e8mr2637298a34.5.1785896909187;
        Tue, 04 Aug 2026 19:28:29 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm2078153a34.16.2026.08.04.19.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:28:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 20:26:59 -0600
Subject: [PATCH net-next v2 1/8] dt-bindings: net: x-powers: add AC200 EPHY
 control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-submit-acx00-of-dynamic-v1-v2-1-3eef49ff1d8c@gmail.com>
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

The AC200 contains a Fast Ethernet PHY whose power, calibration and
interface-selection registers are accessed through the parent AC200 I2C
regmap.

Describe this control function and its optional SoC SID calibration
cell. The vendor sequence adds three to the calibration value modulo 16
before writing BPS_EFFUSE. If the cell is omitted, the driver reads the
AC200's internal copy of the calibration eFuse.

This node represents the package control logic, not the Clause 22 PHY.
The latter remains a separate ethernet-phy node on the MDIO bus, which
supplies its address and the MAC-selected interface mode at runtime.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/net/x-powers,ac200-ephy-ctl.yaml      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,ac200-ephy-ctl.yaml b/Documentation/devicetree/bindings/net/x-powers,ac200-ephy-ctl.yaml
new file mode 100644
index 000000000000..5bb60542030f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,ac200-ephy-ctl.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/x-powers,ac200-ephy-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC200 Ethernet PHY control
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC200 Ethernet PHY control function configures and powers the Fast
+  Ethernet PHY in the AC200. Its registers are accessed through the parent
+  AC200 I2C regmap.
+
+properties:
+  compatible:
+    const: x-powers,ac200-ephy-ctl
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Optional SoC SID cell containing the Ethernet PHY calibration value
+      written to the AC200 BPS_EFFUSE field after adding 3 modulo 16, as
+      prescribed by the vendor initialization sequence. If omitted, the
+      driver reads the AC200's internal copy of the calibration eFuse.
+
+  nvmem-cell-names:
+    const: calibration
+
+required:
+  - compatible
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+
+additionalProperties: false
+...

-- 
2.53.0

