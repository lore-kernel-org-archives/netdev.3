Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E832BF51;
	Tue, 21 Jul 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640653; cv=none; b=pifwDOKYXnHgW3ajOXtqOLhFR6Y9M2rjKVZvMyFtK6eIBgb5Jpui5iFtsOpexloSEcgRQBnWKlN5qAvFdgkA8GSlkOSIjTOrUbDCqTmFIAXLKBzVxd8hdq2ghhLGSImkh/MO+TMMpIQ//gcxE5bG+M3rMSYMb5jbpuPjU9ntvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640653; c=relaxed/simple;
	bh=hdm1z9iMsJlbjV+coDlihMkkeFDS2E0ooPl0hGi03XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrivxhZT544I20B4fEpKxIFCpF6pcPPTctlHjhllMdZWAxQdy4XNkd18Cn9504OhLyJwPYykWF3YxHiPm94KZ2as5ywEoP7n+7Hm6guLpKWiaPIQf8wsxtiijoDL/6VgIW0P7p+1NO0MlmmKRvHR1f2rDehIazRHNddBHXSI2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=2BtnBFF9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gobeB9h9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="2BtnBFF9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gobeB9h9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 64FEEEC01DF;
	Tue, 21 Jul 2026 09:30:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 09:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784640650;
	 x=1784727050; bh=nBYhBomxIJce1ndUEXgHNoen1njZkz83h7XP6tFRSbw=; b=
	2BtnBFF9Uvb70zv56W7Dtqi86bh52t0P3i7EQSxoz5oK2sOv3k1ZFU2cLCG91K68
	8XEWaPHu7O8/JoW8LVc3mOk00FZNngvoxPa1gZr/6VExvE3hyHeiBm+ArriU9SHP
	b038ESeeefoKR4+z1nMguitNg6seJHt7eo1THB8ktYSaNjSEehmxxogB9gC80Q3A
	+gmHVKForyFAWYmpjAjP1Gq+JThNsMoKLnXbK4nqhkBQJi30Boav03exs931hozE
	93hn5cNhP8NorXmjMztm4Zong07IGAdG+vJXaEcDCf0whMYhBvkBf7a26A3ro7LZ
	zV4zwqnwARTuSPLiD01C3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784640650; x=
	1784727050; bh=nBYhBomxIJce1ndUEXgHNoen1njZkz83h7XP6tFRSbw=; b=g
	obeB9h9IYWz39pabBbBNaZWYxqpiSvA7u2Tsta71lbbywEJuqT7ICgfdBdJZWUDi
	Om1Bs3c6Ruy5/ocls4kniYEuxFUOoRWG3QxDx+YZnQ//UsuTUCM6P86vVOIAbSpE
	Baw7VoUblnKF28xyQp/Or8SxJb5qgAK9GzFX+dJ4xdCVpaB7XwHYSCl1s8GqJ0m8
	/bB5uEn7bcy8mMlQodw9y2DFSTN9+DlRnpXTer9T7pUpvPQEO+uFN6szIwTRfcb1
	Y1lLo67tbjWtReT15OgBC+dnnqy4tHRsxJTEdN3K9uTHAkr8TGsAOJP62kye+Q4P
	aVc2NsJ7y7UN0HORKrGdA==
X-ME-Sender: <xms:inRfalvvExe0reFdquhiu2s4xGQjLfI_bxiTaEI9t6QkYS-5hvXR9w>
    <xme:inRfav1Ch7Coga3FuOFDcb2s_DmwzE0PE4oM2n7fOtAPtxfzI5cc5oWDBNeDIV0LK
    E3O0W0yYcNdKqTUwYljytU4YXTvEtSytlaWhI9Zh7XV7ZwlzUSFhQ>
X-ME-Received: <xmr:inRfaiCTuXIQfmARawgBod6VeSjgtaljsR2KChbRxKv7QJYkQd-0iLqj7DekG72WRc4N7gNt4gyn1P7gb4CHrswVWQ_vDnE>
X-ME-Proxy-Cause: dmFkZTF575ZcECJFrMdyDOFXiBqlpXf0yhJc4wJMGRSk1x6GE76JbdZNoYn99qsG6N3LS7
    USpQE+ZKunF24wrYSvawlBt8W4qEMWKfUSJTDnVEopJvF1+Q62r8MvTdfgpHsNvbNGrf1D
    vKpAOQ4I3FBNejt01hlSCxMBJSb2IVwTag8kF3nu1RLPuqjE5TxSJfHwK+Op9j9S83ygI6
    ZgWIzHc6Kx6a/UZvErQchcOraZWT/TwGxDoAThTI3dmc16PbrH4O8objPTsteFmCRfv6rX
    Q4At1kl+MQqqzqG4Q9/mzL8gQuEkKgewxIcLI85kyIjyMpjV1vFmzivnzrUb7wggFcj9NH
    AY+NU/NZmKIrmwUJoYgYkgr9c+xX3Jt9iT5GQmaKy/oaalLXlwU/gd7GJmNpk3XkpOrE+r
    lJ2fQmAk+fQFBCeJ20L5pHGQHHDgcfEdi+d8vWP48uLD8iMiFPRk21jLn6luIGSgDGfKT3
    uBl8sLfQ/mgtsz7HkTFCxmacNgD1+TZhQGnMtj+jpl5CGq13E0zdUZ6UyQ9M+l4o12A8ji
    zjbGZ3Z3yw4xwD7oM2Cz0fDDqaPmSobO/OirM+8y7YnntBrXPgZtLejyx9xtm5PFnp712d
    zGcngarlvnVt+Sr2piKUrZewrBpj7wSiFOUR5Su8K3QghCBrDhDwMT9ZV61w
X-ME-Proxy: <xmx:inRfakcbqfjWpwJ19dPa2Kymp5AMq-E_N3T4nfzL0XAdkv7fB-mQNg>
    <xmx:inRfasxwnJu9OofujgY-4iqmVzEyUSxqIlcEo_onuZ1JgDZuSvj6ZQ>
    <xmx:inRfanOs5scsWCEGesa_v3ZR6YEXprBZ_jHX-Kd0sFlwY1gI9xaaNw>
    <xmx:inRfajYRGsJqZchyOuf9EsXWrtZ7F4igkciniNsmP6UsZ46mvcIhWg>
    <xmx:inRfaoO-NS5L7e-Yd7A0tc_uM-ZpuIdM0d6XQrCCgt7Ir3AHxKhkxuN4>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 09:30:49 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v5 1/3] dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4
Date: Tue, 21 Jul 2026 15:29:34 +0200
Message-ID: <20260721132936.1331318-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add bindings for the R-Car Gen4 gPTP timer. The timer enables accurate
synchronization of the clock in the control system. The timer is
system-wide and used by different Ethernet devices on each Gen4 platform.

  - On R-Car S4 it is shared between RSWITCH and RAVB.

  - On R-Car V4H it is shared between RTSN and RAVB.

  - On R-Car V4M it is only used by RAVB.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
* Changes since v1
- Drop 'binding for' for patch subject.
- Drop comment for renesas,rcar-gen4-gptp compatible to match other
  Renesas bindings.
- Drop unused label in example.
- Rename node ptp in example.
---
 .../bindings/ptp/renesas,rcar-gen4-gptp.yaml  | 64 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml

diff --git a/Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml b/Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
new file mode 100644
index 000000000000..3edd64d40038
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2026 Renesas Electronics Corp.
+# Copyright (C) 2026 Niklas Söderlund <niklas.soderlund@ragnatech.se>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/renesas,rcar-gen4-gptp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car Gen4 gPTP timer
+
+maintainers:
+  - Niklas Söderlund <niklas.soderlund@ragnatech.se>
+
+description:
+  The R-Car Gen4 gPTP timer enables accurate synchronization of the clock in
+  the control system. The timer is system-wide and used by different Ethernet
+  devices on each Gen4 platform.
+
+    - On R-Car S4 it is shared between RSWITCH and RAVB.
+    - On R-Car V4H it is shared between RTSN and RAVB.
+    - On R-Car V4M it is only used by RAVB.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r8a779f0-gptp # S4-8
+          - renesas,r8a779g0-gptp # V4H
+          - renesas,r8a779h0-gptp # V4M
+      - const: renesas,rcar-gen4-gptp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
+    #include <dt-bindings/power/r8a779g0-sysc.h>
+
+    ptp@e6449000 {
+            compatible = "renesas,r8a779g0-gptp", "renesas,rcar-gen4-gptp";
+            reg = <0xe6449000 0x500>;
+            clocks = <&cpg CPG_MOD 2723>;
+            power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+            resets = <&cpg 2723>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6940aa3d498b..4e1c4ed038c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22914,6 +22914,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/renesas-nandc.yaml
 F:	drivers/mtd/nand/raw/renesas-nand-controller.c
 
+RENESAS R-CAR GEN4 GPTP DRIVER
+M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
+
 RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 L:	linux-iio@vger.kernel.org
-- 
2.55.0

