Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA54E1C70
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399593; cv=none; b=F206qNItuGveLi1Oa+enGxde5ghquORK/gK2HLLfHq4faDE6Nsi/RY++6KPt2imx2R+adtV6ALW35lvq8QN3QIe0MiOq+/YfWZhzeLtIS2V6pVo+uLI576RqXDBR6zE5c/qSM5ZQHaclfQWmGLUu66lRf047hy/Tdqy+BSEzZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399593; c=relaxed/simple;
	bh=b7yMhkaSYbeQa+Z0ZXC871qZ9vtm62NtXuwUO1AwSxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfjj8W4tVHfy0d5XctXB1tEVx4NTVQbJKH+xQPigMWAsWHR/HfNkUkCmdI1JwrL7KGh6JSoeLOMsWX7wY0rZTaGSVMic7JQclTWhNuFB+lP0+jTmUPQqEusAjjuP+5l7tmlTLk18wnZ+T7PkIheHHyN6Mhc9H2esAkRQTgyTesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=HIxQEaYJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sijuyOYY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="HIxQEaYJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sijuyOYY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1852F1400178
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:59:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Oct 2026 14:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791399591;
	 x=1791485991; bh=smouyl7shGi7QR226vwSNYtvx5mi1iLwWwIpfbTDOJM=; b=
	HIxQEaYJ5QDVqZryZUc6hOnHuGrW71kZaYmMvkYvIrVGUc/GY1muTXt2GvC40vKV
	fnuZ9Scp8Mztg/ffl4YW44MzsUQRZTr2WUby6eUZapkCX9J1B/fc2GYKQ04AIjUm
	DegsUXvitYKpTCAIz0Rxn8X1AUUaa4uPL6YoGBySVa+Td5ntEEbCrVcXVcKWmlfI
	0B4hJ8OSHcsP4b0u9GbkRe6sgZceUFG7+RNkZoMNlmIa1JRkNYtaicKxW9iygfSK
	+hrx4FS3qkmSTsg8YI/0/kqrZ0ifrVMQNrv9nHltGaCWFGet2ChQM4F1MTQzNHw6
	PbG12sgsnns9BxwkRWvaeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791399591; x=
	1791485991; bh=smouyl7shGi7QR226vwSNYtvx5mi1iLwWwIpfbTDOJM=; b=s
	ijuyOYYAVuP8bY7C0Qrjipwkr1L8NMJkqmSudszyBGg1OszzgH/up2asMTyqqqMG
	JP7mFoklYAOYVffNw+9ggPZnkpg8q4RT8UnvXzW+EVBpLWn7PA4iqE6AzYYcObag
	SoZvTYJodmNEIGSHAXwQuwCzPxQ8DQa1FfPXMYBj5DqCpxhLo5/bycOzq3Yjjnvu
	2ZIm4vEY3HoVm8cgfv2adNuiNdKCJXbrmMJetpVp85jaNw7Jv7u346nHeR0g1FPI
	IHwcYekZ+a4FETCGGOLhqUH9lFAIprJVgk/1Rby3gxDvgV/AZpedsRZF1EVqgqnw
	BG3Fu5a8NAyRYWUdUuVfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791399591; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:h9m3NRBmVGVlf0z2AOF5OdwI2Si/u1eCLLnKFTDMgKPQ07i
	RCordvitUILQOIsZTfSk8Sx/M8fyh20s66rilu1SvGLrYBffTEBjIMNsouaoXX2E
	5YUU4DPI3tFhmLLc4Y/0Jr/aeaKLf3J/LGQ+ifJTOYbKX/W7ZLEPCA94M6E0kdsj
	0FEkFyO0AaSgRpEOeYtDtDZyZyW18fNyItbAwwcMaNKWDnrop5KKZKyLoqQ3UpaK
	7IGQsoWWhhOJGumONoCDtQbdp3ZFPcAsoEZznt6j+p5PhnhRxVUouyvJAhf7PaXm
	CRVFW+dzeyFRkXKPeiMfvXtaylVfyUGRy6Da+wQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mP8x15mLR9rtFcvuFwwOfOYfiIM4u/k85OcenmeYTOE=:b7yMhkaSYbeQa+Z0ZXC871qZ9vtm62NtXuwUO1AwSxo=;
X-ME-Sender: <xms:ppbGaqmKONpZ5-QldK1Q4ZXdKo5RQp-ZGPEtWRtuAfgUujrERolN6A>
    <xme:ppbGahEYKT1P5SN8iIRXYOYZddeLX6ymCxsvQHzV12dfJVQdloz56bapKBH4L3qqA
    IvzRRtsrI-3JONPHKKRXk_Sxy9Hj-1M5PXUq66OF8nd3Er4QwIjZJf1>
X-ME-Received: <xmr:ppbGard5Kf5-rE1_AFaW4jP5PKmqX-2nESRD7WNo00_xJkedVy5vfv9zIQAmHGHr97bhWuHgYoLcGuq9frSciLXqx-m3pq0>
X-ME-Proxy-Cause: dmFkZTE9wkCt8UfPkTNFANuveG4fI/yaQ247fMDJXho/PgmweyBolN8KKLG5z60VTnfhfR
    Yh2IPyccOdEtzz8GWAkc1Z6ZyOfDzvOVl1guRnKMECy9YEbV2VbIYKqZEJsWXteURO/Ach
    SEC4BqsSX1y8mGd4/mbVT3Ke+VdMyD0pfXUKoP7HJIwfRFci2Qb7H3AhMGn7AzrVXc2e6a
    ofLzgAImc1qd7pBGRURu8brhBJncghkj2BjmrAq00EN+YnB0btn2k6wNy8FDybOBMzoSP9
    Jx/6G4PtVTNsv21kkISl3KsDi2V0xMXReWJcCdXCyHjYJcvjCzr8CSdBF7uRflBbLuW0Lv
    dGbR0M9nHuJ6eWYZY2U1dtWrsbbWOZPB5SRHpdOOQFLK20ljAci2U8RAKLHOioS81T2Udq
    uMJILLGzX7qlhBo47tpmRRg0/jRnXajq1rzPRi3D3JCWQ+PUqGMKPIFAUcdNEgj2cJGgA7
    Seo1sb6r7c9JCMlevGwADmRlB6mymgFABMD33+SBkBOb5KmqsQRBKnKfAiDcEyX3fsPcPH
    24Eq4kkdyXdUWpR2D47qEfz5LyVWEgGhwAw0qRLIRg6maZYdt1jg7smFDjuDhIL/rsA527
    6JqHX/lR8saOOcc5bkTZDG26v9+Q9zD/s3SHF9ls5OxlB+1Z/vKcBaLWfYCQ
X-ME-Proxy: <xmx:ppbGamEUid6qmTFRh8MwRpfBhB0BRZj8JZEeZKAxrW53UugXF-AlDA>
    <xmx:ppbGatEbZQNhnQNjzB4mgaG_9aENQLC8gAAzy6QkNmsOdPJEwG25yw>
    <xmx:ppbGauPsuQc3Y_soi7vaR_56z00dW3etQgTZcaV9qmu6nrH4xhJ_-g>
    <xmx:ppbGaqq1VZktIhJ1kRdQ8vxotVjdQsCcE5N23IcaTUQxLo01PWcHWg>
    <xmx:p5bGahhZamNR0mDkA2FAw7qOUR_ywym7T57-cuvOg2y8eXRJuAHRD_nX>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 14:59:50 -0400 (EDT)
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
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v7 1/3] dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4
Date: Wed,  7 Oct 2026 20:59:18 +0200
Message-ID: <20261007185920.4042783-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007185920.4042783-1-niklas.soderlund+renesas@ragnatech.se>
References: <20261007185920.4042783-1-niklas.soderlund+renesas@ragnatech.se>
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
index 72ca3aab2106..9c1d592cd788 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23199,6 +23199,12 @@ S:	Maintained
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

