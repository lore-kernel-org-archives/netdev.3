Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08320455617
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124854; cv=none; b=MwZaGVDkDy2B2WAeJ90kxIeLeCV+nq/rPZDZ5wJdzQS5fOetSHyWPsq4UNjaug8lFo42yXH21ruHcAZAHMEG984ME8b83ZCg/OgvC5wSFYRdEcFyjeZbABN24vI0Ksfb2fTL3yxkq85bVy+K3FFxxLIah/xmppKEJcB7L5MPJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124854; c=relaxed/simple;
	bh=6L0A/1hwlgu3ZBemNtOVZ3kfBVIJlVHUD/x3pYd8d2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8UMva1CnFRkbvGOyqENiKBVX9FPqxnIwZwm4tSYDO4u7jK2/uJqxKnrfkanUnPOgysZZC524NmpDhMePLYfob60thjW7r6suvTbNZDCkZDtCdFyuzNCI3GhTbYAL2it0r3gE4Q6RUqLM/CGHRJxUPNWQ9cmySS4exuBgHtMyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so6772935e9.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791124850; x=1791729650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cr3LEhlSfFRZpLIfOzA7XjGagn89G0+3vtw0RCWpTl0=;
        b=SHFpD36u5+0gR+83B/FbNvUiXCo8297wCnalhFNprAC5nal1diZGvvQjJ3ZDKJqzDZ
         P2pQ55G//XVnKlmSnBI37Xn5qt58dMxHYvDxlKoVLHVIuGh8+75ildPoxDw32SpyIjcR
         m3Bs8k8HbC202YKwZLPXQUO9JK5g6rjG3h0O2fj+vAFTVkXcGCSmMvov2Z+xW8rwu9KI
         5ghpPN9BcuCiSqMA/F8Zh+qi6Sax1aXrsRenKgkjKip4K6kAWsqa+ouh1nx411W/RMBX
         ejq2J463gwrqNTCx8NSUnHnGFNU4VtMl2ofuGFrox3/T/NZLJQAjwhMfkOKl4I4Ph1ON
         8EHQ==
X-Gm-Message-State: AFuF++nGcDH/pc97Wx6f7jg05UR32noZtJYkWl5BX9cKO2iw1cUuI6y4
	jLLe02AV3W/mQqWy83+IzZ5E4vpJvUdnzPLw93LMm7qdRLlz7QSuJFbU
X-Gm-Gg: AYBFou0bm5V3N1GI/dF66vsCL26jpibqApEEAEvhE8Ve8RBE/4FtkUP5q0l/GjTWpwe
	pRZu8kwyKRiO7DyizKGeBpWRcYgRwiRi2TOVSVVLACIJ2KlxvjMcp6Dt8AKL70Tn1/5mBNYdmi3
	fcbroB2Rym2yyIQXRt8z9YoWhfAau2Vfd3BAJMGWWBQlSKnfnjG7X610lwjmlXs3XU/C/TtwkKJ
	ZIVOkzS7FVZ8H712s/hOgqxl09SeaNFxum5eJ+7Dt7/IveYq7pKP36JE+sa4M3ed8w5m69zoLNh
	kmzywse21aKkl8TmZZMTfmrn8e0/iuMuI8kgOUhYrPmdWO7xAQ2/RVfzfMoZVWfKgWgVsRwZH5i
	TsgKoMPPF/ge+wWhgjALOEyPQRVC2CqG8Bwaa1K37McBDJAF2nNOoSWNZXAQbbthkO/2QuEaAXU
	EOvtV4BJXzdWjV9eaflPTe2PfwQM6X8s4HRKAbMuaTzzMS8AbcQrREiWgcmwNa5w6UfGnbEq6d9
	i5kiB+Cz713yw1imotQqGrH97iXQ2KpoQ==
X-Received: by 2002:a05:600c:c091:b0:4a0:1f90:594b with SMTP id 5b1f17b1804b1-4a1680fd78fmr60092225e9.22.1791124850158;
        Sun, 04 Oct 2026 07:40:50 -0700 (PDT)
Received: from threads.localdomain ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm298907685e9.13.2026.10.04.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 07:40:49 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 2/6] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
Date: Sun,  4 Oct 2026 15:40:42 +0100
Message-ID: <20261004144046.391444-3-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004144046.391444-1-tanure@linux.com>
References: <20261004144046.391444-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T7 has the same ethernet glue as the G12A, but the controller
reaches DRAM through a pipeline stage that the hardware design inserts
in the bus path. That stage has a gate of its own, which no other member
of the family has. Nothing else in Linux claims the gate, so it is
switched off as unused and the port can then no longer complete a
transfer.

Describing it means a fourth clock, and the fourth clock of the existing
list is the one driving the timing adjustment logic. The T7 applies the
RGMII RX delay through PRG_ETH1 and never enables that logic, so it has
no use for that clock. Give the T7 a list of its own with the pipeline
gate as the fourth entry, under the same name the SD/eMMC controllers of
this SoC already use for the equivalent stage on their own bus path. All
four entries are required, since the port cannot move data without any
of them.

The RX delay range is the one the G12A has, since it is the same
register field.

The compatible pairs the T7 name with the 5.10a Synopsys core the MAC
reports, and with the generic fallback.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 90ef79161ab1..96118b4d1560 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -23,6 +23,7 @@ select:
           - amlogic,meson-gxbb-dwmac
           - amlogic,meson-axg-dwmac
           - amlogic,meson-g12a-dwmac
+          - amlogic,t7-dwmac
   required:
     - compatible
 
@@ -57,6 +58,47 @@ allOf:
             - const: clkin1
             - const: timing-adjustment
 
+  # The T7 applies the RGMII RX delay through PRG_ETH1 and never enables the
+  # timing adjustment logic, so it has no timing-adjustment clock. What it does
+  # need is the gate of the pipeline stage the controller reaches DRAM through.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-dwmac
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GMAC main clock
+            - description: First parent clock of the internal mux
+            - description: Second parent clock of the internal mux
+            - description:
+                clock of the pipeline stage inserted in the bus path between
+                the controller and the DRAM. Without it, the controller cannot
+                complete DMA transfers.
+
+        clock-names:
+          items:
+            - const: stmmaceth
+            - const: clkin0
+            - const: clkin1
+            - const: pipeline
+
+  # Delay definitions for Meson8b and newer (including T7)
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8b-dwmac
+              - amlogic,meson8m2-dwmac
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+              - amlogic,meson-g12a-dwmac
+              - amlogic,t7-dwmac
+    then:
+      properties:
         amlogic,tx-delay-ns:
           enum: [0, 2, 4, 6]
           default: 2
@@ -106,6 +148,7 @@ allOf:
           contains:
             enum:
               - amlogic,meson-g12a-dwmac
+              - amlogic,t7-dwmac
     then:
       properties:
         rx-internal-delay-ps:
@@ -143,6 +186,10 @@ properties:
               - amlogic,meson6-dwmac
               - amlogic,meson8m2-dwmac
           - const: snps,dwmac
+      - items:
+          - const: amlogic,t7-dwmac
+          - const: snps,dwmac-5.10a
+          - const: snps,dwmac
 
   reg:
     items:
-- 
2.56.0

