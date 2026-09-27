Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229073EDE64
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790513201; cv=none; b=EjlBlUNOANFX442DuwyT/g6odSY51ZnXoxwvBCGfra2vw13lNeNPtEFi3g3Em+mqmL16pnnW/Nb7F9C5v/9FVCiB9E1ADp3sah2pr6pLBFOQ8Iu2fpB9P+Sq8y6dSOvaHZw48hLM2NHalV3qJA33/AYTpJN7yQoFxiz57KDv2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790513201; c=relaxed/simple;
	bh=5T+a23aIGmK2iqABM7bsnn+JBjwEBOQqZO+RU3YCAIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYIbylbFJmvCbYOsQyXbsg5xWLxpG8u39aWBx3rpacEqNskOldcHzyeLPfWrVN0ysTWT1p2AF9F3sUTSrJNen+V079HwmK0BrG6NmwVyA/a/oX4voxwh8V5U8isYtGfR/L/8tey245rJHqq74+haUiXjEo7znmOcGtFWCza1oH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVMk8HLh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVMk8HLh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so16269715e9.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790513197; x=1791117997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YshmIf8br7QZ8gBxtu/Vo13g09V/Sk1mprmtIBCHo2o=;
        b=QVMk8HLhJkoGlvjM1+CL0xPLSAHlQlhhLu0zcACJ3H1J8nliHJ6pgtPD8OVnvfa788
         bDao1vT5By0Y0LpmBY6pPjGhwTQ8F1MF+LmK0Z6iMxKi9EOJ4O/EMlY6ouE5PekHxGb9
         /PXwsqWfnZfh2RxeZfOQNlxriyyTHi8SK5kFf8UmRTaDlfMLZLlbepbwCNjrNIOJ1YgU
         SnGtgnAw6/TVGhdWJBk8Cueq17wTFjhN8hNu0tIYSNAtjax1lQpBWy6V5PEa81oBYMcD
         tzV4Y1uw5ZpH9oTSk6dec/GJcXt72NqdIqY3AEQHLY/Zpl/mjUugq/9p1tJ/caG9uDuc
         vdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790513197; x=1791117997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YshmIf8br7QZ8gBxtu/Vo13g09V/Sk1mprmtIBCHo2o=;
        b=TboLRqSYy8QcgLKrjjT0pSmDKs86xvwu5g4n8eAjwFYaeeDspFsSOxRAKqhV9BvtXU
         WzEGMMlSc6JCmUjb3mfJetlxf7T2tGgmZN1VO5age2l8Oy2IfgRfbCG0fGtGMT2gR/xz
         vFtVq874eALRrB5x4wEDsK6Lx8T+mNwXbM6V9nNt8BUIiUpkFew7HkxwQXlh0lyNNflQ
         bsOR3YG6wswl0hhfEyuNJZDGGzBLt6+KZ3UtYgcEy17/JxxdNfz0AefJRSPfUGC9j3Hr
         8tQduCNB/B4LVafcdLgNnU9pVKVyWTz/4p7Kj4N4DIMLm9mvbKBS+xb0bxFOD7lp61+w
         1LLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzX1GAJTGup/aNgB9j499zoowTyz3l5lEbClweZyjb7DwH3JACz/KShm9hPUboCNiW+HslOHv8=@vger.kernel.org
X-Gm-Message-State: AFuF++m6vxxBrBdzoIEdMH8R4sW4YoZCQjz7KQNh0ObzarHJCGPuBofH
	p9fkOPw5YadDjxBaVHWJpQhZ6YdfyWpUw4W4ID5R0IyN05L+5XYyCHqD
X-Gm-Gg: AYBFou0/pvcJHQ9j6MQWE71LMYUorv2PUgFCAomp2jsrNaenlpsxbg6Fk0rZVqtONXL
	wUnzSOJCGfPqN3p4iUIFnb0kASWXEhyQWMPpKu853UQi8Fzde04reXqmLJ6siy4GJcwzf2vK0uA
	IiGQBbJX/5rxxsmxEm1qGw+9UXUfpUY7JVrnAfNX9zBDRa8CQPcXRI+lPvvY9jLMVoZOA2bqTi7
	arPiqiA0cerESvaVAgBJJdm6K1QBndJ43Er6gu0CLll4qaWFenTHXp3ZwayV8PjBmkjgUVrCVXl
	/+n6Ee963OEIWDSL5oGXQT5Mzx/tds0n6WxJz83SRHlFstet5srHja/eRcsly1daibcxpPI3I9n
	uIPWmRvwvMVPn/DeJ3CTvVYNal+DngbEWnPb2Mv7kldCwuWZPeUfXD2o8rG6dDjh9H2rm5asYHT
	tsFo3rqPZmZKYo8PhJdZwfNC1t5o3hClCBFVgsnr+/RAYf7LPhNLe1G0ImA0NmNPNORRYgNTYQ0
	7B1PG/YIJobHX/ofJlkMHhnYlZnG0GzzAIRtr0DRbX/n6TydoZdZX41IKMS7BudO36xjo57aCQ0
	iqoxNPXExAmEdHEoBVZiow==
X-Received: by 2002:a05:600c:4ecc:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a001745829mr23006575e9.28.1790513197048;
        Sun, 27 Sep 2026 05:46:37 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm148440605e9.4.2026.09.27.05.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 05:46:36 -0700 (PDT)
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
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 03/12] dt-bindings: net: micrel: Fix RMII clock select property type
Date: Sun, 27 Sep 2026 14:46:18 +0200
Message-ID: <2596c9e2fd59d04abb2eb4f4abb98767d2d2ebdb.1790512621.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790512621.git.stefano.r@variscite.com>
References: <cover.1790512621.git.stefano.r@variscite.com>
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

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
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
