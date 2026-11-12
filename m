Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519591;
	b=QzwUU0ZRGwP/cm+MFmQfelHdA/RIRKLDaqQ4oAFjbGy44nHRrAgmwbKT/4U7fcEJgYcq
	 bVd42zY7fz8fMvUQhqnJec8eBNvrqg9p5Yg/dTJWJwiPqaR6rJUNHO9jmG5IqYMx5pg5x
	 LI+KXWhYTkhdlVrQ5fbSvxo77rlTC7HFAISSjNISkHG05Lomg2GexjMrV2IMaTCnXB6Im
	 s45vZC75MMtXojthCK3Umdo9+kAutsQhapfeQ0KB0y3A3ot09Nu7MrfIOQo1vp3dMKADB
	 WZtxtchsrNVBAMj7pEQ0y0+4jwODXPo47NNbv3DksEtInuOUY7y47j6aQDHMBCqwPYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519591;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Puf+AwKlK/UoaD94UU9LY8C6D1KGt2kJdgn/b7m046U=;
	b=0kRboL291TQC5f5yLohFdH08Xpp3eI2UgEfHkVNcwC/AiKSpBEhRPTi1VOmxWanN6SDG
	 FBMRyJN7fKAkw+ZwPMbKF7xatazL0x9RuSL1ParEkdU7ZJNdmynchi10NAI+nod+/fh1W
	 /t8pJ2wccJRxbemwyvmx7L1Ggx8jV/l8c6+RASGc7FjqAjKD8IS9Ej+5sNHnNit864bCI
	 iFk2Y7mcpvvnxu9KnSGvvOnJgvC7ttD5qOUH05+LDiDNqiAtJSoQeNgj6TWgyozuvKmWL
	 o6CK9RkfDLN5I1iUegR8LxjzbMtxQJvYiP9HMylKlsLUl/qlAjPlJlirGo48eJ4HVxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhc0cVeQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499B606A323;
	Thu, 12 Nov 2026 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhc0cVeQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794519590;
	b=CiDqdVHycVXnS391JWwCwbUjGH4AiLQNLIm3QCETlivtrGtvOI6jpybJLit211k0H1IZ
	 V1V/6DNbnQ91juBpqIErAxPTT4W7jrznXFfCAHmlrCBLoTFTAskLY8tiqlaI3mBx9Tb/6
	 MXbieaW6/W16J8RLiJukVX5a8yNLil6F6HmfXfY+hAQtzGkUO4vjXryv1tPN+1k0QX9q/
	 NmHrw905xpycrXQkHC/pOryXI2Cd/VT6VIvs2vpyeL01Ih0VJbF2fFi2s/rWp/NLgOPGO
	 u0NZEk4IOMSL/t/s8D969dAPlGU50gEfa158/w5SvW6Qh6qZKVHGgylqPdoOwL7NVQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794519590;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Puf+AwKlK/UoaD94UU9LY8C6D1KGt2kJdgn/b7m046U=;
	b=vuPB/zS5HR/AaQTjI1xentYZIofCOaWe5HCDvUpW7+QrAUEEdg5H1UcA7K5rL1O7Q3yy
	 yThswD+8cCmJLWdsS/H5OWZStdrVJD6DMmhv0imuttM/4vfBtADw4SlaloY7zsz2sh8o8
	 cOIzKyt+pblcKn5xSgHgb0hSKJMPE5M2VPjVvMSXXz/X+L/GXv15gxgI3abxprHF128dK
	 FeRa5o41VxkYCkD6/6P/Upy4STngeSfPtZVkHpZaNOAoTTjUN5Ubp+WrZ/oZCKgJiKN10
	 9XI+tt9p1fKOUmdNVcLmv80iIgZd2hRlX4uN63kpcDWV/eB4e0BeIHjWX1NlbKlruyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 09A311F000C4;
	Thu, 12 Nov 2026 21:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794519590;
	bh=Puf+AwKlK/UoaD94UU9LY8C6D1KGt2kJdgn/b7m046U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Mhc0cVeQqFspzY0dCwjQHldHOzsOcGtCkVpcjJ2tBD2J/iFRhN9YtG267cQ/QJWqT
	 gVecffeqtQI/FlfL25TPZJ9TjvxxqemtXjV/DywRe+a/hPIXUUYbJkt5yPw4uW9i84
	 nJbD0Qe4JhXh9MShS4hiU8us/dGKWdgDk+DSE2A1xJhTBDcGpRfDLpQJVquTjyfGty
	 +8Vgjl+UppTJl9wqBssm6yIojwZ/D3W+tYSzhhKBMOcQijkBcb4cvFTXKxLWTp0ejO
	 7aTFHFuqK0z5WFrPErS0ngjsW7Lc1/0AMg42iWHeePCgNv99SopnvyMaYV2i0FQClM
	 GUId1N78FpzIw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7274A4750E;
	Thu, 12 Nov 2026 21:39:49 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Thu, 12 Nov 2026 16:39:40 -0500
Subject: [PATCH net-next v3 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 reset-gpios
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-mxl-gsw1xx-reset-v3-1-863e82074893@telaak.dev>
References: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
In-Reply-To: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794519588; l=2157;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=4FEhgpkbRSKonFfieQreIMKCdNlc7jHkKu3BjReGMyw=;
 b=b+7gb1Oc++Mwg6Q50MuJLkWAgy2Sx1MWTgsgyJaW+v7gIa39B1WPEdZ/AI527fgJvGKz2HhKB
 GxXCULKYkq4CjJp3VSdH8SEvWowcxUlHJAIrWKcmI61xkaNC6NbQRSc
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

The standalone GSW1xx switches have a hardware reset input, and boards
wire it to a SoC GPIO. Allow describing it. The SoC-integrated GSWIP
variants have no such pin.

A reset through it returns the RGMII slew rates to their power-on
defaults, so say so where the slew-rate properties say that the
bootloader's configuration is otherwise preserved.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 49af5573e4..89f78a1bc1 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -40,6 +40,11 @@ properties:
       - const: mdio
       - const: mii
 
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the hardware reset input of a standalone switch.
+
   mdio:
     $ref: /schemas/net/mdio.yaml#
     unevaluatedProperties: false
@@ -120,7 +125,8 @@ patternProperties:
                 1: Slow
 
               If not present, the configuration made by the switch bootloader is
-              preserved.
+              preserved, or the power-on default after a reset through
+              reset-gpios.
           maxlinear,slew-rate-txd:
             $ref: /schemas/types.yaml#/definitions/uint32
             enum: [0, 1]
@@ -131,7 +137,8 @@ patternProperties:
                 1: Slow
 
               If not present, the configuration made by the switch bootloader is
-              preserved.
+              preserved, or the power-on default after a reset through
+              reset-gpios.
           maxlinear,rmii-refclk-out:
             type: boolean
             description:
@@ -173,6 +180,7 @@ allOf:
         mdio:
           required:
             - compatible
+        reset-gpios: false
     else:
       properties:
         reg:

-- 
Git-155)


