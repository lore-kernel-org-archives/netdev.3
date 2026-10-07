Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A97448B8A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361594; cv=none; b=N4E/9rJT15DhCCDPln3d7VmgT+AYLmTXtRd26yKmzO+FhEyNve/wC5KsmHiTv0vcVkVJgPfyn3QqoBaWAQ0Gc6DN0+HMdqmuhV/SiaDM/SFZidIPhj8QGi3TBhaxUb2CJdT1WQqr2l+0dIHRiQVbmWDiJNLMSEiricmNCF3Axxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361594; c=relaxed/simple;
	bh=5hwn9dmZm2lL4gEzMv7nMKFRmoByFyt7ooc5m5FQqRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI0rqiW1ZJ6p5UlhFlW3Pb3GP3Iu+IelFS5HclLkQtqVaQGRHJxKnqlqJrNNN5DxJmdcWLGwcONAPopyhUrms+oy7Dtiy21vFH21VXY+94LKyA2jvGjROdc+Hb/yYuyVL9/yohO42WIaK9TeG4Grm8fVU35q83ST9yzuxaAgAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4207ac26so1094677f8f.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361591; x=1791966391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9iDEeSRYepWdUPmgZSkaxaPn0y4xYgwY4k/M0MT4wvc=;
        b=kvCBmjyrI89T8uxFvwRMBRKrfD7Hm/Q59CE+wCs7GoPaLOjzsco+6AUEb73ulHRcXW
         QcGEjxIZ1NOygaQ0KWf+UnyyujV/TbAoMLfsJDFjfWCDD5kn8rFa1PZkNRihdA0wleb0
         ezfN5wSAfzFIedo2HlnrtwRoEFhQX0SVWfSoJepmwruRsWdtOWZbScJ1akH+L53eNYTt
         3ryawBe6+WdSm/HAJSmzGO6mo6t16S4QMvGMYj+ztwUI4R3b4Vuv8/VpbEg0M/O5AG3M
         FUOO1LGu93n4dWJers8FThcFn9x+3nWhde73A9gebCrsrWWSBvZYqRMGLd4k1R1oAich
         jbyA==
X-Gm-Message-State: AFq9FYKzBPLk2Nx9gqfGXdQBkJLdQa9yNBwvL0LtUjRVQfjsZ10g0M5M
	WIqXpZ6HQ3xIDq/5OVq57NE74nmFe1YXYxBmrxxC3E8xBWlXUmOtBplh
X-Gm-Gg: AYBFou0MQLTe4m/hbYx6kSQhxxfvhcOwR4kygA6emugaWbeY0YvEiIqStvyAAirxosy
	2gBaYryELWMjr4InaSh3ePBQ7Hb6rHIpFYb/uudagimQBLCPk9/0Q9nBfv/Kvm8ITDBezB1tXKT
	TwsIqvgt6RMPL960sgRR9VaBaozcgUhP1jOk8kRYLPHNPVrHQzFkZJ/oKYiFLhQHJ0BnJy7Hogy
	8497xncMTeUX+fN85AdgXj0makJ+bdClR0MDh81HaoldxbSXVwXixchO0NNFq05Pov2zSPXVBTn
	jmSTGZqXxUfvi6C3ozpUyeJ+/ECJ+0idO+ReeGtiSq2znTWdlsQXZftjuolMBH8Y1pcHa67QfnO
	mE5Tl2Rq6fvcLBBb7g4GsYh63yqXQIIr2K5NJ0dru3LZi9l5mtEBtj4F7MaQ0SDWUFDWVtrnPOT
	5X/nSGqMq0hwbATE19MqkxIPvIlV59dlYapb2DL+tNaIjsqrh0/MmhgWTWqGYHTx7IZ0Ck7f7u0
	4W3yNPWuFzamh+m6JHQA6cdCDD99JXyqKY=
X-Received: by 2002:a05:6000:2dc9:b0:48b:123e:2f5c with SMTP id ffacd0b85a97d-48c7278ef3fmr3047018f8f.29.1791361590762;
        Wed, 07 Oct 2026 01:26:30 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm4251370f8f.52.2026.10.07.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:26:30 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RFC PATCH v2 2/7] dt-bindings: net: amlogic,meson-dwmac: list the compatible combinations
Date: Wed,  7 Oct 2026 09:26:22 +0100
Message-ID: <20261007082627.63807-3-tanure@linux.com>
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

The compatible property only checks that the first entry is an Amlogic
name and that "snps,dwmac" or "snps,dwmac-3.70a" appears somewhere in
the list. It cannot express which fallbacks each SoC takes, so a SoC
built on a different Synopsys core cannot be added without loosening
the check for every other one.

List the combinations the device trees actually use: Meson6 and
Meson8m2 fall back to "snps,dwmac" alone, the others also name the
3.70a core. The example used a two-entry form no device tree has, so
give it the Meson GXBB combination.

Assisted-by: LLM
Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 5c91716d1f21..90ef79161ab1 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -129,20 +129,20 @@ allOf:
 
 properties:
   compatible:
-    additionalItems: true
-    maxItems: 3
-    items:
-      - enum:
-          - amlogic,meson6-dwmac
-          - amlogic,meson8b-dwmac
-          - amlogic,meson8m2-dwmac
-          - amlogic,meson-gxbb-dwmac
-          - amlogic,meson-axg-dwmac
-          - amlogic,meson-g12a-dwmac
-    contains:
-      enum:
-        - snps,dwmac-3.70a
-        - snps,dwmac
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson8b-dwmac
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+              - amlogic,meson-g12a-dwmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - enum:
+              - amlogic,meson6-dwmac
+              - amlogic,meson8m2-dwmac
+          - const: snps,dwmac
 
   reg:
     items:
@@ -172,7 +172,7 @@ unevaluatedProperties: false
 examples:
   - |
     ethmac: ethernet@c9410000 {
-        compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+        compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac-3.70a", "snps,dwmac";
         reg = <0xc9410000 0x10000>, <0xc8834540 0x8>;
         interrupts = <8>;
         interrupt-names = "macirq";
-- 
2.56.0

