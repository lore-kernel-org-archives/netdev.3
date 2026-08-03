Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102936B934;
	Mon,  3 Aug 2026 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750773; cv=none; b=tc7jD26z1lt1aA9hE/LtHjzdesij6Mbqe5kL+dtWs2VOmef52GFX9G/pzVzw7TNHkkEms8yj8zvvHQWKbB0YTAFHkUWtnJoCrAkqwTCh1DQ7PwbpfehAv8TJXER9lyb0FjVlJ3SxvEePvexFnP6zj3IKdP1/osivNnkIOdj7378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750773; c=relaxed/simple;
	bh=LVnvGiOieHd+XJvGm99GQcQVlMlewiOhTJ7dLKCtiY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4+kLPUAvm5h2R2VtHwrI++pN9GdkRzU1K6rIcy/kAsvCcMzNKf1KuznGF7MLUsof1MT6u1Yy7x4rEfSOzJ9yEvd6BDTQ6OFUwFNUvdKyF9Q+yFutyLxPjyfqA7Oa9Euhfr3sVmC53diGeI0pXqMan8Me63Ok5xlMlTpy5buD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=UU+Tx4wU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VBhPqKAz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="UU+Tx4wU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VBhPqKAz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C78414000EA;
	Mon,  3 Aug 2026 05:52:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785750770;
	 x=1785837170; bh=gPIfil4OJWXKE+cPhQ3VvjLvj1+8dgNtFN6E32wGS8g=; b=
	UU+Tx4wUuHmrkOf8RWifCWHRnrnnX9FIDf141yUpaXK8nI6Ut2Jglh6FTH2yBdLB
	IiRCBN61GFrfi8Qp7wq2kZJi7F/Mk5Blqt6WgTnFRb7uN2Ak1V8Q6YnNmjh72oZX
	sU/NZ4wM5S58n4VFRePGXHo9asBVU9VAzGqvc+38Ff3r/atIVogw14mthyDljHZH
	8RQHzhFs5o4rVzsnCyYDZVo+YCU8JCJlrfnZkWNdNWsiyWBjq83O3KmBoGYkXE8s
	L0nIXcxeSYLbiNKSVIA5CJ6M5Qbl54ipBsTU0rmFY5MwsU4cH0S0UzLRLso1bYi/
	Rn6YU+2sndGp4Sbpco9o4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785750770; x=
	1785837170; bh=gPIfil4OJWXKE+cPhQ3VvjLvj1+8dgNtFN6E32wGS8g=; b=V
	BhPqKAzEym17aZdlPMPicWfo3q0oCAL+wA5ZEijZ9LKuEHedfBZ+NSpWQIuEC/zJ
	s4N8P9WL2Tf0hrZQWkimc9QB+YTJ21e/vkkNFO5ktwGiYrmLUtS8p4bGPXn1vrn2
	7wfxWI5O+NZ5rg7twGte3XpoQ3BpLX/MoVLjX1fgpPAudOWT6jMv7ftgMlW4mI4u
	ZDDQ5dIE6WFrC3EkbHKkSyjk7AaZ6F5oLHbFS/i1cQwdA82YdvQZ8A+TibDRqnhG
	5XypDXUl3tZON0Qfi0NZvm1qR3n+eH8ZqvJNGX7Bg0fIvjFg/VSGJgvF0sIs/o2/
	YI0QFjlqBtDnmmVXptsnA==
X-ME-Sender: <xms:8mRwalO-mmffWh0GJT87HE3uMWEOv_DuizanPs1CrkBOwJpFrEPU7A>
    <xme:8mRwapUygPSNVmbnSDvIlUe1GBsnnbkbQDapa-s8OETSYaIujHGnGicL12HLd9m-d
    PqPLnC-9lMwQxFsJgqRgT4Nf0sgbJWw4O2ae1rdADvWQ8LJpY6_vzBi>
X-ME-Received: <xmr:8mRwatgmGruYtSfo0xfIhaYp6nz8_DxjqzPLja84mLPsIXBawgJR1DkaiLWcmQdGxVa2WkRiztYfgqSZLGWQLYbv1tdapLI>
X-ME-Proxy-Cause: dmFkZTEO1UYlvuVhLJUMtijhb1LwOPe3aQDHMkSckFeiZ5/ic7keZTFx1yDzntUd8bkWhw
    plWNcRxym0s67z+2aJsnzDzaR7UxjGQQYm9eWbUo60SucofwtozuwQZo/r5mvk0tjtbBZ5
    OMCaFzg9ZmUCj33vNXmaRiSLTtXSAUXJPT02G6AVT7Jevw6r08/2rOnSuuPndlLT3oFtYq
    BzAl/v12hDCW+iBTWVfxis6qNqnPUFQny00XUIRsGemaZxVG4oIf31ZoC2T0bhdNFv98/L
    e+SepMPxqsO17PNH7c9LH9UD7Kj4uxBTiv20blv1EnMPs7Ci31g3hmeGcUrPUEgqVhQ7tW
    snVMjYgOmdFrcuh+1L9WmR+8j/9sXxCr99vgRwR58To1a0Jzvo3APcx9+6Wq0AwboAKlYk
    Ntgw0HRuBXgaRq6MB7b70Y5vW4RA96pAhy+1wgsshzAkS12q9knFhZFNLVw3f5RbMoTc3U
    n21z39RQRZ2Amy4XpQOIFkWn4Nbb2SPnKY3gJ3oUOYEoVZRWjS1x17SYXTVpuKEMO54eyw
    oBshsWvs36GT+enjHMsI4qqfGqVOeSWvLsh2QdraUBKHAv6Vbeu064m1tu5+BRnJ+ZP8zD
    r2kCOxwsIxlW5vyJXTRa6h2BwWBAecaSFPnuL1pqRtZHUQTFYDt+MWS4A9HA
X-ME-Proxy: <xmx:8mRwap9QH0xTZectZiS07grNkJ8vnrFAzIaWRvR2Q0cbG1oMHmLlAw>
    <xmx:8mRwakQ3_tWHC-OBgyA0qNlBCzyd-BuLRmHDUwPCp8ECsrMAdA7U7g>
    <xmx:8mRwaov9d4KEXlA30LfdB_EwHePWNdUAClqln3Exg5WF4cgyEi3-Rw>
    <xmx:8mRwam4o9VLNEake0kYPqckM8mxxMuDt0YDMFCwVQ4BJNvxh3LfLQg>
    <xmx:8mRwaiItvTUtl9nCShYOsQuKsbzhf-vNkq8Tlj8ychpkKEruak_lawiu>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:52:49 -0400 (EDT)
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
Subject: [PATCH net-next v6 1/3] dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4
Date: Mon,  3 Aug 2026 11:52:30 +0200
Message-ID: <20260803095232.3527111-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260803095232.3527111-1-niklas.soderlund+renesas@ragnatech.se>
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
index 932ea1db048e..ba83c5792c8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22941,6 +22941,12 @@ S:	Maintained
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

