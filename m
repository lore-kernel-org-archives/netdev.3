Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298198;
	b=cJQRS9tZduFeqNIXPYYVrI01iEiKzLPd1yDu1AXY9h6KzqXEt0VQisjdxICqys834P3c
	 IHUvJCxpXkLSg7k0xMwPuG6gG5fnApeVprLhQfxJfWyRQRMOdfUlk9Ew8OJv9ERJPqWTR
	 uvlb7yr6U74GVDtC65vzgMnicbqy2Bedx7f5iaMVbKZlZ6QGcNoN7miJGsyVvEGksCNpm
	 lQ8dDnH4c51ZPvEIN5kt6KEiRnODvEW6SfceqWGsunEdDXjVmFK7ZSfaI6ioGmRnptIkE
	 Jh+xtrfq03b+e3NR+t0i7MWozYsuZb10HvrVGA9UwVNIUAo/dLXz1ZS0f9aLW78+WnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298198;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mAsNz2wU4tkU9iMdH/MDnugvOUYR1tryRMDLG8PieSs=;
	b=OtvNkZxUfAyfCsVsiBc8668XMyyIWaajyE1Z9+QduU3SxHZf/BUDkTeJON/Gb72vF5rW
	 davjBPdPT4BZ+nKrCIm+qzt85Zeid4cvTpvsznACGy5ct5vAi6d/DZK3kg9WDcMkXhXpw
	 tHO0wIfojtpC/D4qjAsL55qHNMOTA89/D0iMuExrBexnSrwkDsx3h8rCpqT8yrw7Kg+tS
	 O/VAK/5hcZsBYI6PShVAGXsewx4BVJstZilQYDQZVwNDJ3iEB9VZxlx0yyhPlFlGE5VKR
	 BSVWAWXZediUQfuukx1M7/eoKCBI8gfR3Y6Hl9Ubpw/iZVa+75mhC6SfBsEGYCgzVSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=gLhHTBNs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WiQbL1r2;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6065606A33F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6065606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=gLhHTBNs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WiQbL1r2
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23DD914001FA
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:09:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 03:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794298197;
	 x=1794384597; bh=mAsNz2wU4tkU9iMdH/MDnugvOUYR1tryRMDLG8PieSs=; b=
	gLhHTBNsGwwONeFy3jv61bF0w157U81RBmFSchgQNe72kbplQTWsNlqPXsDiZFgj
	Ij/jtLKO2i1I1w5GMqB0wl0dlwC9MeUB6OzOFg35D5W0Ro4ttwWudZMLyFlBA6ES
	pwsmSBxuFm9oATudCf685QYgZjkzhXpy5MpmRDJLjCxW92OrSS/JFGW1ML5cPvUx
	uqCeTdTCJGTa4vWG6l1twLMks4SKgMFsMSGUWsn9DOcLg8uZTpyY7oQdwegw1g6w
	d0i9gT0C3nPvhe5LEedapQIpGD1hYsjU6mQbX6CSWxMYPNdCojklVGRE/0slUzbe
	5bOFH4ZkjOJY3Ubgysi+FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794298197; x=
	1794384597; bh=mAsNz2wU4tkU9iMdH/MDnugvOUYR1tryRMDLG8PieSs=; b=W
	iQbL1r2Bm6+renO7FBVKkDNwTqawuFGFwqBzFI+/wIsfkRKoBN/leJEEYjlypOu7
	zKYfGG/qriegy1JGmv6IHTulmvqyMnUJNgdBI6pf9fCDBuaBRIrS+pdF59++XYg4
	xg+h4TscvBE4Y18jMHlcIbYjWwL+goNmKlqJKKIeERrJS/qxARh18miqt2WvHjO/
	uoiCiHvjfkhDpDnN0O49Vk3owDDunz8+o1HjIGcxH30O/kOPA09wdmfHvjorY0/D
	Uo74qBKyKGK+SD8LmUy45SDxNXjaLYxkR6Mu+AF5CLJnc2CHFVv/iaRezu1iBZe5
	jXi8xbwMfI52NOLdD7U1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794298197; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DcWJ2XlG9T6SJLrxzmI5gkcXRiSuZj0vmkJ3sJmwRrMJ638
	N0vjIHB4YCxmljifXmXz0JX6FcAsO3oqwvi5NleQcDL+XPWlpPr0eFZ3gIyMxwEK
	FYaiIMw08tF3+bwDcEAMuWv9D0yJeVTTindPwHqdGcD22G7QZr4I1rSdI4zZ6d76
	SwY2/5mTTsui3oIX2JDfSn83p/Z7hs0oZENhc9eUoGb9OCJDFsOJkGuHcRrmpQKT
	Q/Yg4xUoB9+9uQRjpmCU75ZMjssoByrBuB/cmj6V7VB0Vxfn6p8/05azNIvLnETc
	joRWgKYSubth2xSGzpVQdaf3H8iNfaUbNU7FsSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4pLA6B2Sfoz1E8ZJ0ztvbOfb/+sGjMeUONMqcxVhpY0=:IKW77qCm2N7IYJJxo6Jwz1BHr7NbbtXTQu9qbnUEDaQ=;
X-ME-Sender: <xms:VdHyahBLqyVyIhyGny0645MvjsUYpZdHmJN-3xzMiZAnmt2Cyp-sAw>
    <xme:VdHyauyN1SZLvmNYKKCBx3dszQ4dZdMFMH4F4STJ7yKNm9dZlGmEzyPrHqHSl7LpK
    -oakVyS_TeD175QMBiU_M3hUGhHmR8TL9-yYeEB5ICqjIy9bhS0ymir>
X-ME-Received: <xmr:VdHyavZpXv7eMKN6GJD-yN6jONNJEC7lqHvYdOY10N0FVe_7EZgDFlWI5S20URsjsOQ8Sfs_rzMHg-aBoaLwwbdl-augd2s>
X-ME-Proxy-Cause: dmFkZTFRqnIPbVAAxHQTnsB0XAecYTyUtpzT7Rey3ZWbIkncitU3D3Cy0zCgWXjl26mX6A
    ee/FtMmnnDuuG2wkyioUBgraXKtLYEkeLZ74JflzlIdQfcWSmG4BTPAFycYTVoxoeoWwtj
    pacWoqufih+d6yja/sWK3ADWOsFBCcd1yR8gJoyI+oSJj2qyoCb0uhTfG3NtYblS+iR9mX
    thXD/yEne1DpdCk5BwCH8mD21AncEj4c3aC+CO7h3SGME69yPzaBOV3vUZQE2pivytjuRL
    +/PwzjeVFkNhrWKq5tqVsXpFGHHqzfxdNQFKfWJmfnfrfF6K+MHlU1ADjpxELrMmvAb8LX
    7MkqFeE51gJw0GghpGaH+z7vgeQGeAqfZunPPufI/UE/Zsfjf2otc5528UXE10IYk+hijN
    Uv+i6fwLB9kkqtl+eckHRvngAWIa56JOezsw1pQxlUin/xTO0u2v8YDoZifZIs0lJ4vztY
    xTWMSCIXcE0zz215Ao0tmq19mSxQveHfrrxxaE0vp0BqAlEN9NuBlTNzyS12GlqCO77dgS
    29l5QJmqy0RC6vUGAd/8mcO4xqbyWg0TNctyIa/7DQeRnDGCZU04MXIJxokgbE2d+IUJaX
    yAGLDiDzk7/54GDV1rz56R6gzT5OWPeo5u2K1yWhe0tcrTw5N5/7OA1onNMg
X-ME-Proxy: <xmx:VdHyajT5_6D8FdahPFWovMR8CYAQAFlDnsN6PRvhUfRGXTpCyHOPfA>
    <xmx:VdHyaqgbHo50Fmmjm5h5W1C1z7uo-KHvQEqIsifB-f2e8O6Vgnqvfg>
    <xmx:VdHyam4FjpptWF2y_vMeGzbV8wy-ohxob3Yvh541UGzGHDxBeg29Xw>
    <xmx:VdHyatkK1dUMUJcYCs8qQhGnoF5ZzQju9uUiI4EK0WguneAaNBTpgw>
    <xmx:VdHyakMQDTwMiR-xY4T05x8lp4J7MW1g4QlWFfQuskLUZKlc9RsMCmTV>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 03:09:56 -0500 (EST)
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
Subject: [PATCH net-next v8 1/3] dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4
Date: Tue, 10 Nov 2026 09:07:25 +0100
Message-ID: <20261110080727.2377040-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110080727.2377040-1-niklas.soderlund+renesas@ragnatech.se>
References: <20261110080727.2377040-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
index fe23913b1e43..085fedac38ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23822,6 +23822,12 @@ S:	Maintained
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

