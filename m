Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA153B358
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695086; cv=none; b=JBwJD3cGVFZSueJiTyXPClic2eg2J8123xBDncjhWqa/Qe2vLkKQWXrjFvdGcPbdUwGzkGV4q+fOZmphQErT8HNVV0E6nEnyWkbDRxlPg1M65xHqqcd8HC1qpyeAMyd0wdSxR1Bxj7kmLqwht7DcWAUwOa5/ybiD7rDfcVuC0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695086; c=relaxed/simple;
	bh=5T+a23aIGmK2iqABM7bsnn+JBjwEBOQqZO+RU3YCAIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcGTqHSouTFQVNLgC4cOXl3aU51pCat7pcWgLkQQC3exwc9XK74s41e8JydHpboyskQifgdVdn+SSmLHzZIqRYNhgB0jFMDALNeMZGMHdW/SYxDdILKaRg1vvQ6QP4WLMJzcudoTvmn+vNJSUtETKQoxo6SqTsJR6b6al0VZg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEwKTkXs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEwKTkXs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a00713639cso17007245e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695073; x=1791299873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YshmIf8br7QZ8gBxtu/Vo13g09V/Sk1mprmtIBCHo2o=;
        b=dEwKTkXsbcUwSRywhPvI/PTqFIaOSeEA09fN3+c6KiMxzu2EjStXCNOxOwfE8qiZVW
         5gdwWYj+xeSONbh18IVtKnzV1Syb4E0owhv2hF0iBs4mTmrhU+ZQmSYVh76yq51g+ExU
         OIeon1/9tAAktz7ELeYqDb2cTqShLnJR+NHc8fkIYpF7fgv6L79P50Ii82GD3IlsWpI5
         RmhyEhFD714ebA847EQuYkr2Sh4SAIQNm/hQ/AFuFLQSutGVrWZl69D3y5tyEhKJF+Kx
         WjCLqxdlwTnLGJa9EygR5nooHlzR4C29pymvG4QkxqOtjX/Otws1FOb4qH49dcv/NKpq
         bJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695073; x=1791299873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YshmIf8br7QZ8gBxtu/Vo13g09V/Sk1mprmtIBCHo2o=;
        b=FzB0mfc5bw7yzqHYTk6lXpPPwEWZp2dcYrxiRnZCNw9YQeXNmMdp1Qw6EbD+APcrre
         lb96cBohuhGvkDPTWLeYkmCIkIELLLFogL7EYxNZwm8UYWltSN8IwXUzCkDp/vw3P/eY
         PQFVf3teNiAvc+Gr/YHHPu2AZY01d//p9aliZGAQzXLZ0n1BivPI6coxCK7i3z138c8j
         fcsGF149WnSRqOHXXs9fUKFC7JmXdpsGLQrhbjd4s1XCIb1S2Bx+w7pF+f+aKSJK+I5y
         B+EHM7Lpqaz9ZbBzG5KZ+c3wgCtFCPAA65eqENoGMKB14+FrWIooRXaqxm7zxdFD2Rej
         LyGw==
X-Forwarded-Encrypted: i=1; AKwUvBx6g5J766dtPMCAJvKRpLPfD2ieGrIywG/26m786m6lw7e3cXM3JCaLv1E+R2VASxEr4LyRI/U=@vger.kernel.org
X-Gm-Message-State: AFuF++l6pDiBgUsub2h6aK6JZjf8NO5bKy4H+trH5wzMJshwg3qnK7aV
	qxv8/ns7sFktzgN4M7UPjjzANkKOu63mJSIO0ZfE+YJoGOf5omgoD3kv
X-Gm-Gg: AYBFou3wMrfI2LAJUCnQSoV1SmJD394FqbqrJ6wEHPdN7a+CIlD4ha9Vr8EQgDLKHYz
	dFiXe8IfPgcUIo07Y/WDdP1dfs2t41qMzrzoGrmh+TRgEtIaeUjQlFpODAeGEwHB4z7XSiBwkvo
	TFroIzwqWjsBqYR0NtpauqFfOE8EfPXlz7qWkddHHnTa4RovwIoLI9pTGKzfmxdn7D18QuWFRSe
	qEh+tCXPzlghddt7QEvzsW9Jj76ypQ12K7mrXuOPbrLSfpJEQ/SqPoTMR4cBa+ciqv5d9HQ8+yG
	axnX56vxN/bN85UhS9eHdWzta0ZX0FGWQWM/7iQmeJrjM+jrFJi85uwK3A9UvRFBXJm/2u3u0S4
	MR6QvnuxqU26tfcvMyIARdWNoJ8du7tqz21xBA/GoHBshjLzVwRiiCKpIweFGhtyPwMZ0wkoIqA
	4u3G79GKK6yyhLwhf422X8yV6FMEFkPJqqomoYaA62uTT/HNa9cRtrwox+EXPOvTguYLiAlqeu1
	lGQaGG/GkXuFY+1+iepl2r8vgIDgYAn49YuyadhME6IYaBvqzi4syDDJKBXqSBw5opx0nJPZXUG
	ekZFwuoe0P7IBUlXWlz47JFvFJAxpxMp
X-Received: by 2002:a05:600c:c3c1:10b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49feaa1d628mr198851025e9.19.1790695073277;
        Tue, 29 Sep 2026 08:17:53 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013cf8402sm10313705e9.2.2026.09.29.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:17:52 -0700 (PDT)
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
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v4 05/13] dt-bindings: net: micrel: Fix RMII clock select property type
Date: Tue, 29 Sep 2026 17:17:32 +0200
Message-ID: <9a0f70dc168278a484bb336835bf2e419a9d089d.1790693249.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790693249.git.stefano.r@variscite.com>
References: <cover.1790693249.git.stefano.r@variscite.com>
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
