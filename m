Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60710392C42
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361596; cv=none; b=pn9W3nL1aM5SdhGG0oIUySh6hieITwP0njzWXROGRgiBp5ShsotSGgt60tze6aaKuomgyFsxhtn57jTYZXSFDY3RfOGJw4OU7RWCPrLjrDF3zT83g9/nZFUYdnt6Sia/3OS/Pop+KQYUoqNvyytcduP6u5Ldo805RZOzYal50fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361596; c=relaxed/simple;
	bh=9WEKkcx9Svwoa0/ndt8sME5tWAZ/JM+5CyH/No5fGuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DT+eee53cvXQD4CrTqae4s+jvFar8wG0/2PG27jWSmwpyD296BJmcEUWf6vpDxUGrFMLpJWQSXqSwf8rJmDgOh77ShldavXfDRWvBywdoKPsBOmAsMSmlzQ74WhzQ6+Hff+6npkIldT4W7uhKopzZs+02/faO9E/6wg8qx4vWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c411d6615so1047002f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361591; x=1791966391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tB0xtSwA0keDPf16UgDp3Oe50ABzW8mrbEXvFRXPXyk=;
        b=1GlNLWQOtetxLBWJ65RYVhqO1+qQIFiNPyCSyy26qf3z0jrAGzwTpOPnI9tsyUhWwx
         3vtv84JtbtaSbwV2qcjpmGqPltDBHAGm/HSSoF7cybRtHH26OM7Gx/wTYAbC2rpNDmfM
         bOpRvehjMg8NdJf/oc5pXSSogPW71vPm3X84kLzqe9M1vYDPZn92YaeNko63KglrRXtu
         omgeThh8fl3KD9Ok+HOuhcfeEFuFDjiOJyv/GvRBFzXJQCS3S1d+AY6e3dlUpBIZBhA7
         krxoZFz0b6VOCnsrcN6IzU5Jc32i+lL9GPaM+8hEORbd4fqwt4lFFGHi7KQ6dF2sqaHi
         w9yA==
X-Gm-Message-State: AFq9FYI+YUP4TCJvDorIBkNn6MOh7SBFm+w0PDRaYANkTsXGYJyNHKTb
	aBSnWvPMClHcLLyOGrmWEsdfGP5M1CQ0xTnru7pZqZoUg6rcMx6gGmZY
X-Gm-Gg: AYBFou3I4bJZOp/weZUWRMn+w6OduNCMKFlMA0CXsIgx2eGgRtrKFMcXz3Q9mVAY3Hf
	TSGaGGgOnqg4jWH8cqAqtwdcrx0KSb+MHeuZoRgX8NIFVBStL14NI1LVZm/spZAiFn7XFIDOL2u
	CU5H/4GkHIoA2la3XUIiePsaXiWPCWWZsPrftakvfzd+R/qqJexpAPbGs7ajdtARuv9R8OwpRuc
	XWGhUzFG+fCtnWJizlKQO6TAFmt7YZ0JX6ttYmWxmLhq3g69p2sHlpRu1U20R3UGPdDGuUwd6VZ
	v6R+aZr10NMFf4JE9MJ3tX7MvtuMOiXrHZu5qN921j1p3stJ3ccVy//mpCThHY176GL16f/ZcbK
	S2ndsjG9RfxWn8lqK423XaY4ePUpwAnpo6BBxvvkS/iA6opHo7KXsW+uHqxT1VVeXMgBe4NmEeP
	XDXM5GC0UbnCi6MWrsmdK/rHEchKYpFs6cgqWxd4lBLOKAc2j2kDzJ9GmOeRKR/hCySFGG2De0F
	05NJEmoN4JHc+6Zi4j1rUxOXc+3hbaPDyw=
X-Received: by 2002:a05:6000:4210:b0:48a:fa0a:34d8 with SMTP id ffacd0b85a97d-48c7277eb69mr2959645f8f.38.1791361591588;
        Wed, 07 Oct 2026 01:26:31 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:31 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/7] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
Date: Wed,  7 Oct 2026 09:26:23 +0100
Message-ID: <20261007082627.63807-4-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007082627.63807-1-tanure@linux.com>
References: <20261007082627.63807-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T7 has the same ethernet glue as the G12A, but the controller
reaches memory through a pipeline stage that this SoC inserts in the
bus path. That stage has a gate of its own, which no other member of
the family has, and nothing else in Linux claims it. It is therefore
switched off as unused, and the port can then no longer finish a
transfer.

Describing it needs a fourth clock, and the fourth clock of the
existing list drives the timing adjustment logic, which the T7 never
uses. So the T7 gets a list of its own with the gate in that place,
under the name the SD and eMMC controllers already use.

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

