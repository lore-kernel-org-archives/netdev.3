Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4B3EFD2D;
	Wed,  1 Jul 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896798; cv=none; b=S7/kCxeS08fiApyaXrkQSG+RPHn6hZvBw+K/Ft/A8pH9dT+nPq7Bhjxc5Gr7HOgE6kP/NYOE/58dFYDBQvYFmO+j0ncT4Zkn4G6ici7axCDrny6I+bSrQIMSVOZ8NjzQpvbmXZmD9OZETPuzL/BddKLiLEtvk9fvv1CJrb7OCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896798; c=relaxed/simple;
	bh=rykKa1icV/JrCkWGNeioXd57lQrQTnPbXyjwOzvIgsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILzYUk5a2/DQG1aFgb3pN1iVodNbtiwNplASMfUanf/vIVLbIFya5148XMjoz9zNJZw4kQFrgskyg5chLLrcQR8XXetJgKiFwrS4sPdGTpoBDjnlBWM54bPV94iHXBvjdpIB1PqywE5NyQbIx9H6PztVVLadrBkC3UJg8+myF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ZCOT9rXU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUzdCKoL; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ZCOT9rXU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUzdCKoL"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9F087A0076;
	Wed,  1 Jul 2026 05:06:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 01 Jul 2026 05:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782896792;
	 x=1782983192; bh=RY71qZ1/mTMhQJKHTcMYAxKIoqb7zdEicrCDzqr/cbM=; b=
	ZCOT9rXUnm1AdQnbCQ0Efa3BXXRv75ZQJRA+515lQtZcFTulkjK9uEPwBqvlbPTA
	8SzvgiTGi9KXMruR6Cvc5GjY+cHPz26KGhj4Iie3SurLyby6BvNQYNAs+9oNvGJ4
	ivzYWVSTUwnQYSOVqOjKIst7tlAGZViwuwT/HYCDHJ9D+Um05N2k5b4ROqPMmJMD
	MTlrl4tfjfUnPQM7IHBpdQikm0s+9d376aR8MDhST3WuAwKygbP+UNtmc9Zo/bhs
	NBStgutNoc25XqhP6MSXPW0GbWyxJnpFzm7u1/KGd1jmDhcaBZT28bWmKKK0yi2f
	saqWEOYcjHASuQnAjpEdWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782896792; x=
	1782983192; bh=RY71qZ1/mTMhQJKHTcMYAxKIoqb7zdEicrCDzqr/cbM=; b=H
	UzdCKoLM0HEcvCTIrtzeGt6IOowXTa+yKaaTyAXBRVsVv/AeqxITps9Ps3EME0O4
	XegXY3+1l/U/Zt4rx6nN3ua5meV+ADNccR7WBx/ZVRyW7MJqPhf2j0g6MOHv5Zz6
	/2u6ouNqOYT0S/u1vUC7z2DSZX2gWuQPQTDeG7Xlh9Zxp6aUez8trP2GiDYesSBm
	H4Cg8POFsD5MX/zJtL1MQBYYVbE0WBK4H6Y7KtJSsW2XVZuk+mDl3e+fK5JPqXj8
	Xn+SLcty4fFiKg2h/oxqobu4d2j0d5iSE2AWZ8j6LsKV6Az+z6WiYcf36SAKuk8H
	HVwL0aLEBJ9VvalHoKETA==
X-ME-Sender: <xms:mNhEalKtKOcwvQRcKRuMFDAWIChDaoGnhxItWvL8J0FH3o-fGcDCGA>
    <xme:mNhEatE25iTcNKFzCY5pGO3NGT_is-niMFEq50KVQEX6YMmgrXB1OzQDZsHT6hm5v
    sEpghMs4PuCRP1YD3cjWN9SOuQFwDhIKTVNJJwzU_6iKKhgq1IsQpQ>
X-ME-Received: <xmr:mNhEaj250hQuj1ovpPpo3cICxVjAYTWEQFJwlDAxQX-GmJ3qqGgzlKyrqYqPv_YbMCLS6q-iITHMnzyb5pewO8GOKY_FMQI>
X-ME-Proxy-Cause: dmFkZTGNDibWHxkWFSfs++nrlQIRtDUuthtZrO1pJME/XBgH2cWthISDtRu0/57sC5xAVb
    MLXR4CPBanKl7AoJ6V0e/N16Q3XOHNbTAMMCUo2FLnLHY58N4O+rZr1ltMEcrZ+1n1cl9Q
    hmqDprh7MJSa98oZheV4VfgUWQ+OuLjBGBWBq2KZxOYCccjk881T3X7IrHI/agPK3fnb3v
    1aBJp2MpLtr4MDIztgAqQnncVGHfa5gUMHI0mqvcuQYmujiRgMjUHwb+YeT+WjsJ/1OVu3
    oJ7Qod4G48IAdiffZXT/nywy6NMgwfOEnvmOV68UjeWv7b7FjyTbEKf4udVzMdZzgt76jt
    virzir/BMGPOdHWGDkNQAsG3Zv/TK7SSonEzUNPlY4IaAhPxreUkB5BxK+Mkm7R3cI3AAC
    rSqvmPqQfH8OdvQC9xWSnlLj5cxEU0J12wdUpZ9uiqiNCYYoPl/UrZlxHOMiFI+LUWU6yN
    dJhfkjQJenIRO75pxqGS0/JfWL5mS9ccrntOkWIUJbh/qTA703fA/jbEx8QvIng8GquAuN
    2leSjG4LdFDhQcCRIntdLwCbGFWP0zzQMO6Zeyh5rHulduRJhZeYZhgTKFqMom0H3ot9nL
    wt/BhkXmwU8rdMOnD7zvkqrtuOlxqtXU3ilbkRl4izrAZB3VGrAvDbLNGicQ
X-ME-Proxy: <xmx:mNhEasyFB_0vGT1RI2CM2oxiaTZf28Lhs2JA99HUeZJypoPB3Xz4-Q>
    <xmx:mNhEaqjyOMt2Hidgij1wNYXz4q2e43zMtMQnKv3J6bRA3c5Q1x1_2w>
    <xmx:mNhEajzdSrFmU1TL_AClLPNWk4S8TaYz4jXOKxX4dyXry4JEV_GrTw>
    <xmx:mNhEagw6kwXqk510L3AT4nXdRPfbxKoaF3oo9R_LeCyYvUThOJ5awQ>
    <xmx:mNhEap7gZpKFAoYK1Y26uZlObfhIeg47vQqsapjbm1KfQrloau-ed0sv>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 05:06:31 -0400 (EDT)
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
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v3 1/3] dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4
Date: Wed,  1 Jul 2026 11:06:05 +0200
Message-ID: <20260701090607.1108208-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701090607.1108208-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260701090607.1108208-1-niklas.soderlund+renesas@ragnatech.se>
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
index 15011f5752a9..ef17128d6f3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22901,6 +22901,12 @@ S:	Maintained
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

