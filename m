Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C836DA1D
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345011; cv=none; b=HfwHjezsJ8b0dvBarkXUpycjfWIVbc7SHb7KfQAoiSiC7tZEozsXe1oV3Mep3ZqnwKWVxLEiS05FFspJoIRZMUt675wT7TJvFBxuup5XdxFWfqWuvlYea6nqMVPmF6cIPTl7b27qriytYcARJ75w4x0xP7GfvIHrkvq7P2w0SlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345011; c=relaxed/simple;
	bh=5T+a23aIGmK2iqABM7bsnn+JBjwEBOQqZO+RU3YCAIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K89fBEu09rVEDNzkfBTPiO99JUuHnGErfdd4zbdztu0s2qrm9/xVcwDz5IAkCz4Bd5DGjAOSk8J9ppCep0K2+WK6xF97vyN/4fy56RuvMgAEK2eBV1BkOcwYXSq3hlkDGIPCO/ySANJLxG3xTZ1qni4MkW12TxiaoeiqBfrO1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEoe9NQH; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEoe9NQH"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so816642f8f.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790345007; x=1790949807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YshmIf8br7QZ8gBxtu/Vo13g09V/Sk1mprmtIBCHo2o=;
        b=cEoe9NQH8UIinLr1nj94nO79Vgz4xmARsXXRQ9vGGeLcdLejzPjZvGYXcbFZ1/3ANY
         yQcmFgHPVYGDsZlqOvl77BnFvs9X2T+dNv/HZkJvD6ChxEGXHDvynCm6hcPLxs8IcCAS
         ZNm6AGrWi0DSsEH0KTN8HP+usQkTqY1Yh682tjnWD/dDru4gd1R5JxhYRvD73KYfE5uv
         jaenZIb4jIMVNeSgqEN5N9JZzw2GQMIQjkfnkYa7q+Bz+LdAxEDgMgWiX4Na4cQFNcCV
         H72/x+CVjvBaCXxFt0WYK58s8SuZTTgBOUHl3sID+6ogvEiJMHK+XbVAgH7+dKmKBIlT
         jLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345007; x=1790949807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YshmIf8br7QZ8gBxtu/Vo13g09V/Sk1mprmtIBCHo2o=;
        b=oRGdzCX64/6XGDVlvTR+XHaJjlzGTKM3TfJWLQcEEx+b7ZJtWn/6uKOq8zLaZcvrXe
         C+RQauukuAnjVKGnCFFPmzVzIYU1oCT9UbdWda728h9Yjwplg3VRv+MOTUI+byxMeumH
         dpdurOXodisqES6uAS+/t2gXhmhuWBqNTK1okwey8Ftz6BU7CmNa2y1dWnJhVW2phnAf
         FvfXn4zZb4TCw+lMR+w4W2NCxhQWTVgJHRSd7bAMNCkPEHeojf1x6xC2GQSIXsWFGv3m
         JwGtPCb0LhYwNdgdKVMDtxx8llN9t84Rg2RQ9wblwrjqKBvH0WVELbsKOH+JoFb5vYZ6
         OIQw==
X-Forwarded-Encrypted: i=1; AKwUvBzanfUV7SX+cs37FJtXqNw2BS3l6FpJY3oJrZOwQ5Q6X/d+Og1vRtxk8e0DSj6hZZwV7BufY7s=@vger.kernel.org
X-Gm-Message-State: AFuF++nKPikCev41sBqjldMKi+IAgHOrgF3dpgcHiSV8gpvoAl+N566Y
	jiCweruABoF5JDV1aNcJuq3jO7TjMn8TOUEn0LJm+wNqJx2HQQTCduKi
X-Gm-Gg: AYBFou3adFm6Szal9pStUKaUl6TdLZqAN8Zs6zuU639YPnWOD2Pke6+UBH5kg5IlnQq
	M+ebfvoY3P6S5DfnqwbGD/f57aU3PRw5D3HW1gg7341Gfi8T7layF8NwRO35gjm4CDnIC7P33EA
	liCjyRQL7r/haH0E+/0mszkFnKpCHJswl7aXwLdJy1Gk91NXpsmNSgNiT1VRaHTvFhfINgyw8AW
	fqY9YxwRDPmpcu6hvM/Q7A+WzmjnY18hn/GiicQPkVaiIdIu02K6RorhZmgN/H95lSmrk83UfK6
	SqNygl4A3f9bJPml8qA+HEtnpgwUR57/jRmzyHgWhYmd0Cx+LufevfyS9mpKcIrPkYNKwfXXY+l
	tcDesFRchHKYIP7toxFqF2SC5VqUBzG61nmiVK0QL+o+ocbSrsK/W+FwZELcVFdjr/tWozy+clA
	c/xz5UO+nDfKvCaIkLT0gcsGfw48rQ05qaxMaPLPFiHaJJiD9JpOJvQGRv9rqtgvaWByeM7QZyt
	9n49t4YALi0JaxiCukmXpo1A3yoyns+qEWGP7kRgkXtdM1vtDlRIccnXNO8NhFDK1rzVsZQ9D/z
	N8dKiV4zgkR4bi0k/r/9Xg==
X-Received: by 2002:a05:6000:2511:b0:487:27f9:840 with SMTP id ffacd0b85a97d-48871726b7cmr10342107f8f.53.1790345006448;
        Fri, 25 Sep 2026 07:03:26 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm7522431f8f.19.2026.09.25.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:03:25 -0700 (PDT)
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
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 02/11] dt-bindings: net: micrel: Fix RMII clock select property type
Date: Fri, 25 Sep 2026 16:02:19 +0200
Message-ID: <6580cb8231c0ccada44d3e510374f6c21b65d283.1790344389.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790344389.git.stefano.r@variscite.com>
References: <cover.1790344389.git.stefano.r@variscite.com>
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

