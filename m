Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786C4C14E8;
	Mon,  5 Oct 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214189; cv=none; b=urhuDY5SLFOThxYMaOYbngMHaWxYawU5CnmulNARNgtr/8iCAL7poNGTBgvMFwl/gbTd9AFsWt0pMb5KCsw3aAo0iAkYn/RQCazdNReaT4gIMC/z9TclMakb2q7ZtGJIxjTbnSnTO5A6Zwyfj8WyyIl8EvUfPrbEExmAyE206Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214189; c=relaxed/simple;
	bh=k9XXlvljwpDdINjTABSNq9Rbsq2vVAtJliRAQQI6XO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLZT+h19ideLSNkXJzKjP1cm0IYXrIpfL9FKUS/wcJ05fiddhJcnSsSuoDDe8NKiXpUgYZzr5J7ALEn3jrcjT3XpCEDDrtgqjsrJ0j62ohwH1Dek5mDnWfzfcTFB12e9FuPS/Echuig2t5+QCBR2sOmdf1pcF0HEIyMC/zVeWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=EuqX+ssf; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="EuqX+ssf"
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 3F0B52409F1;
	Mon, 05 Oct 2026 17:29:40 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 0946E240412;
	Mon, 05 Oct 2026 17:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1791214178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoHN9rbVJnagWmiztRfXDSYAqexM84S3RYzPvuSehBg=;
	b=EuqX+ssfqPeBFKZwIswroV1qEhbe82/BfJi5nbPG4CeJSiX/SFEYnpyCQYW4fktp59H6zy
	fJm2CJGj5ANNWoqnbbkyiJ7zpNp2VC+d/eq8F7ScOpHsh99PvSvYQbAlxM4yd1+CdzbuhL
	2kdc20XZC/TupScQjne5DXOiXsD/QQ5RS5zCGnVzSExl+E3O+MxOvFX2WZnF2XKZa26LqM
	C2GoGFUTFYZNfuP9OWIzsDgeVl/iTcz+/HeE3o79wsM/5dCCa2XRA0x7mr9R6MATefSf7x
	cWn+MYyV7doNaJHkbiJfDjA67cw+C5FOMEqIZybZ+MjA7VUF2+/Me6Cwb6dYTA==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 7C00E24048A;
	Mon, 05 Oct 2026 17:29:35 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: Luo Jie <jie.luo@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next 3/4] dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5332 support
Date: Mon,  5 Oct 2026 17:29:14 +0200
Message-ID: <20261005152915.101780-4-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005152915.101780-1-mail@tk154.de>
References: <20261005152915.101780-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: e122ff
X-Rspamd-UID: 5a958b

IPQ5332 uses the same PPE architecture as IPQ9574, but has two front
panel ports instead of six and four interconnect paths instead of seven.

Add the qcom,ipq5332-ppe compatible and constrain the interconnects
and port nodes per SoC: IPQ5332 takes four interconnects and only
ethernet-port@1 and ethernet-port@2, while IPQ9574 keeps seven
interconnects.

The PPE core, EDMA and MAC clock functions are shared, but IPQ5332 also
needs the GCC IM sleep clock. The PPE core uses one reset and each MAC
uses three resets on both SoCs. IPQ5332 EDMA needs separate system and
configuration resets; IPQ9574 uses one combined reset. Constrain the
clock and reset counts accordingly. Keep EDMA resets positional, with
the system reset first and the configuration reset second on IPQ5332,
consistent with the existing unnamed IPQ9574 reset.

IPQ5332 EDMA has 24 TX/completion rings, 16 RX descriptor rings and eight
RX fill rings, so the full EDMA interrupt set comprises 49 interrupts.
Constrain the interrupt counts and ring names per SoC as well.

The IPQ5332 clock and reset functions are described by Qualcomm's NSSCC
driver submission. Its sleep clock is also listed in Qualcomm's
PPE DTS submission. The ring limits come from QSDK 14.0.1595.1665,
qca-nss-dp hal/soc_ops/ipq53xx/nss_ipq53xx.h.

Link: https://lore.kernel.org/r/20240829082830.56959-7-quic_varada@quicinc.com
Link: https://lore.kernel.org/r/20240110112059.2498-3-quic_luoj@quicinc.com

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 .../bindings/net/qcom,ipq9574-ppe.yaml        | 92 +++++++++++++++++--
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
index 1a78e2c82b90..29dd34210ac8 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
@@ -28,11 +28,15 @@ description: |
   supporting various modes such as SGMII/QSGMII/PSGMII/USXGMII/10G-BASER. There
   are 3 UNIPHY (PCS) instances supported on the IPQ9574.
 
-  Ethernet DMA is used to transmit and receive packets between the six Ethernet
+  IPQ5332 uses the same PPE architecture with two front panel ports and two
+  UNIPHY (PCS) instances. Its Ethernet datapath has a CPU port (port0) and
+  two GMAC/XGMAC ports (port1 and port2).
+
+  Ethernet DMA is used to transmit and receive packets between the Ethernet
   ports and ARM host CPU.
 
-  The follow diagram shows the PPE hardware block along with its connectivity
-  to the external hardware blocks such clock hardware blocks (CMNPLL, GCC,
+  The following diagram shows the IPQ9574 PPE hardware block and its
+  connectivity to external clock hardware blocks (CMNPLL, GCC,
   NSS clock controller) and Ethernet PCS/PHY blocks. For depicting the PHY
   connectivity, one 4x1 Gbps PHY (QCA8075) and two 10 GBps PHYs are used as an
   example.
@@ -77,24 +81,29 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,ipq5332-ppe
       - qcom,ipq9574-ppe
 
   reg:
     maxItems: 1
 
   clocks:
+    minItems: 4
     items:
       - description: PPE core clock
       - description: PPE APB (Advanced Peripheral Bus) clock
       - description: PPE IPE (Ingress Process Engine) clock
       - description: PPE BM, QM and scheduler clock
+      - description: PPE sleep clock from GCC
 
   clock-names:
+    minItems: 4
     items:
       - const: ppe
       - const: apb
       - const: ipe
       - const: btq
+      - const: sleep
 
   resets:
     maxItems: 1
@@ -105,6 +114,7 @@ properties:
     description: PPE switch miscellaneous interrupt
 
   interconnects:
+    minItems: 4
     items:
       - description: Bus interconnect path leading to PPE switch core function
       - description: Bus interconnect path leading to PPE register access
@@ -115,6 +125,7 @@ properties:
       - description: Bus interconnect path leading to enhanced memory NOC from NSS NOC
 
   interconnect-names:
+    minItems: 4
     items:
       - const: ppe
       - const: ppe_cfg
@@ -130,7 +141,9 @@ properties:
     description:
       EDMA (Ethernet DMA) is used to transmit packets between PPE and ARM
       host CPU. There are 32 TX descriptor rings, 32 TX completion rings,
-      24 RX descriptor rings and 8 RX fill rings supported.
+      24 RX descriptor rings and 8 RX fill rings supported on IPQ9574.
+      IPQ5332 supports 24 TX descriptor rings, 24 TX completion rings,
+      16 RX descriptor rings and 8 RX fill rings.
 
     properties:
       clocks:
@@ -144,15 +157,18 @@ properties:
           - const: apb
 
       resets:
-        maxItems: 1
-        description: EDMA reset
+        minItems: 1
+        items:
+          - description:
+              EDMA system reset. On IPQ9574 this also resets the configuration.
+          - description: EDMA configuration reset
 
       interrupts:
-        minItems: 65
+        minItems: 49
         maxItems: 65
 
       interrupt-names:
-        minItems: 65
+        minItems: 49
         maxItems: 65
         items:
           oneOf:
@@ -165,6 +181,7 @@ properties:
           Interrupts "rxfill_[0-7]" are the Ethernet DMA RX fill ring interrupts.
           Interrupts "rxdesc_[0-23]" are the Ethernet DMA RX Descriptor ring interrupts.
           Interrupt "misc" is the Ethernet DMA miscellaneous error interrupt.
+          On IPQ5332, only "txcmpl_[0-23]" and "rxdesc_[0-15]" are supported.
 
     required:
       - clocks
@@ -238,6 +255,65 @@ required:
 
 allOf:
   - $ref: ethernet-switch.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq5332-ppe
+    then:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          minItems: 5
+        interconnects:
+          maxItems: 4
+        interconnect-names:
+          maxItems: 4
+        ethernet-dma:
+          properties:
+            resets:
+              minItems: 2
+            interrupts:
+              maxItems: 49
+            interrupt-names:
+              maxItems: 49
+              items:
+                oneOf:
+                  - pattern: '^txcmpl_(1?[0-9]|2[0-3])$'
+                  - pattern: '^rxfill_[0-7]$'
+                  - pattern: '^rxdesc_([0-9]|1[0-5])$'
+                  - const: misc
+        ethernet-ports:
+          patternProperties:
+            "^ethernet-port@[1-2]$":
+              properties:
+                reg:
+                  maximum: 2
+            "^ethernet-port@[3-6]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq9574-ppe
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+        interconnects:
+          minItems: 7
+        interconnect-names:
+          minItems: 7
+        ethernet-dma:
+          properties:
+            resets:
+              maxItems: 1
+            interrupts:
+              minItems: 65
+            interrupt-names:
+              minItems: 65
 
 unevaluatedProperties: false
 
-- 
2.56.0

