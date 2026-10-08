Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A04FD79E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488428; cv=none; b=fxhYRLw/IpTlXyVkEZC0uHNZ/yRFY1ZEKhsbw8OSBBz27+wqlWD8CdsQWrKddWgZ28i4jhCtM4cyM5QBDY4C14oDbKkDAGsC9buQm3DZcyEP6hntIKOA6V9LPRKKpWT7bjlPPKKrYFxs1Qs2ZNuO/pL3cdqbccN622FNomRhk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488428; c=relaxed/simple;
	bh=louYATGthOtYvcZekgYD8gJCu1Mw18vnkIVWgcBPVp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+lO20jA/qo7ypb3IBG+dBHK2bDgkZkXhkGvjwMbWyJ/8juM4VtbJvYzbAc8hvzoYhNn1fnAtxvqNkGLbQol1J11nL/aYck70kTIrmWEs01gQJ9VUJzNDeV/pJhj1k22jYz/wqZqhe9jT/Njn0Hfq8kfL/INUGqxs0hX4JTlQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvcpFw7P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvcpFw7P"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d05d51553so40284975e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488424; x=1792093224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3V/KESF44OWIlxoBBD4DKvOD0PQK3Y0aOYvdpaZuhdA=;
        b=dvcpFw7PCXfcFXqjfhi0ibDez9viIX4betznDOMv+kngZUjJigAJhrLzHkInthkAMP
         ocI/v+yWhumN/ASabbXyqL8YfPaIO8THos9LIU4huXFV/O44Ov5AO4F3JNBVOUmnJ+43
         ftF6n5ADJFklL9iBSovS23OZ91MsYmFPkBlqrbf+wvyw7OyiJKzh9svw/CiwRRm/4VeD
         D9K8dk+wK77/PNlPdj7BfTkBJScaDHulJmyhxkaxXB4ZVgiQnLHvI8IhaQiEHTUudMca
         WvvIRcU2ELMG7QdN1ryofZG6umNsdAtpuouxPBqStRakdRz13UwNN+LOxkqdxJ7ih9/J
         JCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488424; x=1792093224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3V/KESF44OWIlxoBBD4DKvOD0PQK3Y0aOYvdpaZuhdA=;
        b=wnbqNIpkorN/nxL2j1icA3uHz06iI3Nk+XMJjPlz7pcTnvC9PxMPPJngL7XrZ6njH4
         sRxTXl0nF+KtJ99ePST3+7JIiRCpELq6aCTOeSAra/nUGpyOHO3iQhIGnuBUdCJAI2v5
         RELjIWIMk7H6v2RqeiIJgvuHIoeUeu91k210Ls6dEXdhL6zl78OABfaCMYMBIYxHj32l
         1BWMDBx2BKemUwvNMUaSDmhmQIBISbIQS7udVjNNweBwfLHcBiHAYwZyCV2ZTzRZdpin
         0aFbi8Nf/Qug5XgSV5U3W/PrKWfOq573dWGyohl3+7kxUjFwbIYkHgNa2iVLvVl1fh4J
         rCBw==
X-Forwarded-Encrypted: i=1; AKwUvBzagxBhWRYJtEZ0IhzkG+xZzM3MDdpbN2V1pNDy3wCcyCNQypCtfDIMCFK5CTKN1B9VPzLEucs=@vger.kernel.org
X-Gm-Message-State: AFuF++m75qeoD+wxBqBV/uFI0tjc2iCvXFrhe7vXhG64euch/JAeee8W
	usDSqcR4kSUhwT1sBAFP4Yc0BljKHxUaTJh2ZxdX2dLlR3GlUaNmWtJp
X-Gm-Gg: AYBFou0wV9Sv0J5LX5fZkr9o96SxSyP7qC1/E3CFDE5RzYCH1ezHq0cvQq0gExpzZ4O
	cp5U9gu/BC0Ew3DPUqlecf3FXgs4jvRVpYzIKLDrPoNQdiKxywM2Thj6o2wJbBF/Ozyfw2rJoQ3
	IPzsR64KzK6d+KMKAsEYSPtzADCBNbCKUtTHULvPRXSTZsHXkq38a4MS7kZCAAWcDMbd9A2IXXv
	GMKs/rDMtuzu9/R4/YhbBNaELfrpT2nQ1ptErdswrcEsgG//DXDTTa2XL+4P9/eZtI4MdvsG4ay
	bPdNlAsi40DwCKlRWuMH+TVH46OruL1vYCYPvoMOS3/1ODB3TqYFxXSrHs4XhoM21yANNqxQcam
	u1uWYEkC/O4LE/EM52h1f2nc8Vm5kjHZcb5poBRGvmtKNMcCBy84JKIXNiS+W8BFOwSVK+KPyep
	iGTx6DoOU++H3aAc59/Or+LLRwZKrt13zB66ijo+G53vILc6pxdHiI5AjkfnP70fmCLGKXMDdCC
	t1bnrl90MjPS2Z6E6PgZKjVwQV7FIGRmAAdYPrOGpKadD3NGnDa0OLwlOH4j0coBD/3Xit8nd5J
	Cipr+EfBbqhTTewLRE7w2w==
X-Received: by 2002:a05:600c:8b51:b0:4a1:7d56:663b with SMTP id 5b1f17b1804b1-4a18066ca69mr110758385e9.24.1791488423759;
        Thu, 08 Oct 2026 12:40:23 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm1419065e9.0.2026.10.08.12.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:22 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Joseph Guo <qijian.guo@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v5 05/13] dt-bindings: net: micrel: Fix RMII clock select property type
Date: Thu,  8 Oct 2026 21:37:45 +0200
Message-ID: <759d62ee229f0cbb83a51cacbb70ed7dacf4ea3b.1791487179.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791487179.git.stefano.r@variscite.com>
References: <cover.1791487179.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

The binding describes micrel,rmii-reference-clock-select-25-mhz as a
boolean. dt-schema requires properties ending in -mhz to contain an
unsigned integer value. A bare property therefore produces a
property-units.yaml type warning.

Describe 25 MHz selection as <1> and keep the property restricted to
KSZ8021, KSZ8031, KSZ8081 and KSZ8091 PHYs, which have the RMII
reference clock select bit. The driver checks only for the property
presence, so this does not change runtime behavior.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v4->v5:
 - Collect Rob Herring's Acked-by; no binding changes.

 .../devicetree/bindings/net/micrel.yaml       | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
index 6fa568057b92..a1f876dc00de 100644
--- a/Documentation/devicetree/bindings/net/micrel.yaml
+++ b/Documentation/devicetree/bindings/net/micrel.yaml
@@ -63,6 +63,14 @@ properties:
     minimum: 0
     maximum: 3
 
+  micrel,rmii-reference-clock-select-25-mhz:
+    enum: [ 1 ]
+    description: |
+      RMII Reference Clock Select bit selects 25 MHz mode.
+
+      Setting the RMII Reference Clock Select bit enables 25 MHz rather
+      than 50 MHz clock mode.
+
 allOf:
   - $ref: ethernet-phy.yaml#
   - if:
@@ -90,6 +98,18 @@ allOf:
     then:
       properties:
         micrel,led-mode: false
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ethernet-phy-id0022.1555
+                - ethernet-phy-id0022.1556
+                - ethernet-phy-id0022.1560
+    then:
+      properties:
+        micrel,rmii-reference-clock-select-25-mhz: false
   - if:
       properties:
         compatible:
@@ -105,13 +125,6 @@ allOf:
           description:
             The RMII reference input clock. Used to determine the XI input
             clock.
-        micrel,rmii-reference-clock-select-25-mhz:
-          type: boolean
-          description: |
-            RMII Reference Clock Select bit selects 25 MHz mode
-
-            Setting the RMII Reference Clock Select bit enables 25 MHz rather
-            than 50 MHz clock mode.
 
 dependentRequired:
   micrel,rmii-reference-clock-select-25-mhz: [ clock-names ]
-- 
2.47.3

