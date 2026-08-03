Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F7391849
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734139; cv=none; b=dxf0rPrxhyZ3bYcCyREIDCaNRB1jBxHzQH8UuTdMS6eR9fMxphh054U58lZ3ZtMNcj2au0ZxxKwR4i3P5RWSDTQ+oiBkyQrEn2HM5D+VgF2Om+hjQrl7hwRXjQQgxI6ERMtR+NtxLx7bKSQC/Mw7apBI/7yyH1JD9go5VUwP6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734139; c=relaxed/simple;
	bh=vV8lMZbs024nEM6mXjaIv6nOjnfVCGoiA5FCDI8jrNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elEh52t5Xc9klOHjAlsM6bJkAqOqJrgvWxFnLAoD7AHxySGpaxgxTABLAlggb5se8k5YNCsVbfjhjKC0NRECS25F1KPWhp2UvfBaN48bXvmGfuRDDFSYVAn+LUBTdj8v+jSsMKJ0LnrZJuCk6Nb2ag8PZvu4kCbjUukXX6UAVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfbjh3oy; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfbjh3oy"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso1038863a34.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734130; x=1786338930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ufELgsZA/AuhdmDVFD2N+JzOSgNytpSBYv7TBEiLCKU=;
        b=Sfbjh3oyaoEsE9+InTii9WpDet+Fq1zhOpdjiV70hWzaIYHb/8RirXYyvwcto4uLD5
         nzNNry4SjVMVav5+BrZOqamYstY7octMOrhSQFXpech5OcdwXoKdMEXnsIZ+nwjVO5Aw
         Api7tDacZoVqER+CfYlgqOyHJxK/roVP/ObD8AgqL1ZA61qgl5F3mGjmRVqqlJlND2A5
         AEuLbycVdpGiMv+pVX3+VcC7V14foxm8Bt2j6fsZLxNdMLoFpgkjIt4Z6vK8doXkUcQQ
         wyccMhfb/psg3ZJvDUEI533yMkY+VcxGawp9xWshVUtZ165EHcDzmecCrHnhBmNnOLws
         hDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734130; x=1786338930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufELgsZA/AuhdmDVFD2N+JzOSgNytpSBYv7TBEiLCKU=;
        b=PoTexuwHrIrox+u4ZKK+g0yYjDXjasBQnMwWHt2XuMCnppDFMEn59Q2C2vQfp6Eb1s
         mjMtiiRgxdcURZRH9rUWL9Fuf9WZYznJ70v683NmEuMbq/VQidZLqKGCovmzVLWl/AvQ
         dgRynLFZ0rLVqLaL69ZuNtkerWRN/GKxgKCEA0Z3k7FgemT2F+aOosyCk9O0oDTC/ElE
         CtZnaR4lS0+KfoW8u1zFlJCTl6/koCIE33oUUXbtvsLjUMfJOW6fdRW1nEXVclzsnLFp
         Rw9N0PqoAhraoi84BQmUEJSF46jBEyZpa0QVkYrZZXfvQerbJ7imdZ7STTvZzt5FwdjC
         MayA==
X-Gm-Message-State: AOJu0YwGqzRMwuEbTdl+TQTRvmQBREeolsTik2dI9yBpmZpDxOMp+Mck
	GS33wNG6JqlHPZDOMW3t8EOSO3u7vSG6njpdny3ZIxV7E0NbndCBA5BJ
X-Gm-Gg: AR+sD13UGf4jKco/cpt/4fJ9EF+N4TMo1Bkt5sTwfmeZ9hpWEGYz3wqshOjvYoKd74d
	4f1fz8PmTkBqojqj1SN5o++Dy7P7bx2F7vRF38A5QQMfY/Mj9gcXZq7M9PcYTNbeFng/9JKzh0M
	vg6k1isAPsapLM/uelh5OZN2RyNL7JCZzIXWw7Sh7/YwJfvvV9q0l45b/D9mGGAwUasQMyeud6F
	2uD+Yk3Q9h3Usnn796dGoZWMNL0U1ZKto+9ZqCrwES2y+E2ORQ+z98Ls5TAmgJOnqmxlkm2P7i6
	WIQCB3Z4/49jCLxRr1Xi28/pzUHbl+uRV1E0jvZUP7gC/SKdxUg68FiLw63jdud2V6RYMXwxlBf
	VxMPCghEotYPMBee6Tn6Z1toni7xZxu8w6zmNeY41Iu8J2fJceWck6cwLT634FauZ+Imy52f0rf
	ojP3z+Az6XYQZ1XK7BBZ4YFPbTE5XchsqBWjtWg3aLcL2mwQWkJty6TnHh3D2YrNinccXfMjMVq
	vwsuMtkGqEXoCrIcDsB5N5tIl1iNn+v3sARPTLT3AjDAO1FwjEF8qgFWoj2xtgnV5g20zeeNcqL
	xc4O46yelUe05dXnEcieI8+SFOqoV8pmJPbap/0lEpl4sDPVWkJFK9lYB5eLnnerGvGkZ4OrkFR
	xogiAl1xEV/EUl9eqLlYHT8jGE1ep
X-Received: by 2002:a05:6830:81f0:b0:7e9:cad9:4bd0 with SMTP id 46e09a7af769-7f196b1550cmr14686937a34.3.1785734130353;
        Sun, 02 Aug 2026 22:15:30 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:17 -0600
Subject: [PATCH 07/21] dt-bindings: net: x-powers: add AC200 EPHY control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-7-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The AC200 companion IC contains a Fast Ethernet PHY controlled through
the parent AC200 I2C regmap.

Describe its control function, including the interface mode and optional
SoC SID calibration cell. The vendor sequence adds three to the calibration
value modulo 16 before writing the BPS_EFFUSE field. If the SID cell is
omitted, the driver can use the AC200's internal copy of the calibration
eFuse. The link-PHY driver supplies its Clause 22 address when enabling the
control function.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/net/x-powers,ac200-ephy-ctl.yaml      | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,ac200-ephy-ctl.yaml b/Documentation/devicetree/bindings/net/x-powers,ac200-ephy-ctl.yaml
new file mode 100644
index 000000000000..b3337c3aa62a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,ac200-ephy-ctl.yaml
@@ -0,0 +1,46 @@
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
+  phy-mode:
+    enum:
+      - mii
+      - rmii
+
+required:
+  - compatible
+  - phy-mode
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+  nvmem-cell-names: [ nvmem-cells ]
+
+additionalProperties: false
+...

-- 
2.53.0

