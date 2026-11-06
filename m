Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793951947;
	b=c4JII6g3j6jO/Ola6ylTX9QXnDI6n5NWcsOIRJy85fDJzmFMUv+uvsTmo112G9vqhDOl
	 JIJ/z5VBUlt2BrxQIGGBYoxBZ8+SXjDgTcqf5zCnKTeZBIh3phviY1PHV19v+mgjrFkUg
	 tlbkhShDepqUBY46PsBoOcMbEVyqf/thz7hgmwhT3vrH0EgUVvDl2+sxPphtcI5Q8jJpG
	 63WeP+TIam5xT3jz5XHumctpK4Rwn1K6yUKptX7oEWMSFcg6CkxN7aXIczR3xnlSswsKG
	 vLBSDaI0abtOggGb5p2FU/Z5etj0fHif/mjezc7alpyIpMBekVAol+N2EQ83h+YjuOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951947;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jcrs75do3SplBoI37hg1MInUN49XcuGYOTz0cGN/Z2U=;
	b=qgvVmk0RybEsXQ4krVOhAzt7SX1aQ9/6LCAEKFu+/SC1iU5Oelklfk/+wPwJZr0BBrtA
	 qFNeC0DWKr3BsBq5p1ufWcau/tu5RJoyR9FGdeK5ZGG37k8YWprN9s32g9p1jYcUZSlqk
	 tt9sYOMf+rYmkXAQFfRUtjE/lxNOKYun0UxtNYTXpWSYpdQWuinlZosAZ9cnUzxrhh4ml
	 cJgSRjk2xURRnaufCD7eT014aHmZuYp/OxYSldr+Brtl8ySuGqsLx1QJcmDIwmqLHMIGw
	 Qnkx1FM4EBJpS541+N3KVnYkfjrA8ABpQ/LoJaG/9cVPUJ38ZEW/oNcpesaOVKj27SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="gaIfR7Z/";
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93835606A32C;
	Fri,  6 Nov 2026 07:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93835606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gaIfR7Z/
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C3691201E0D;
	Fri, 06 Nov 2026 08:59:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcrs75do3SplBoI37hg1MInUN49XcuGYOTz0cGN/Z2U=;
	b=gaIfR7Z/rBK5v7/l5FOzbBZOTAeKLfInkphiV52Tw6o/Ll1d9W3wQqXEOehOJ/ePTA8nuZ
	ZVQkPOYlPdfMWjzqUnjE6Ml+xxiNqWM7qNQp+lOIQ1NrEq8tZNG6KnKHryk+9DGbo7sRjw
	x8isu4sjSTZUcA4XVk4aQyziJQNe3/j5rOzO9a1qO82gqKL5lP7nTUxo1Ju6bceuXeeTVg
	tsQEYiR5WAaTCTHUCXnI7JhmAvc34JSgQlLtdYOx03xOgxrcDghpOLarXExBmm6hVvQg1n
	qtJRI5qCpKXUBOTRW2JehP7sRJjrIuMtxUzv2a/TjfCU+Yje/pxfXHmqTkCqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcrs75do3SplBoI37hg1MInUN49XcuGYOTz0cGN/Z2U=;
	b=fCBxgE3viVsRpP+rjwaXGWHKARDheIlK204FI1x+iXJwI5I2jAqsZXRUYyXTBDYPTjFnzu
	GBwRSZXs2LhJEBFfhHfkDowcimhYwEU7r0ng+HPl6i1urHJpDjHVTiaAx5+Y2DkMXTbFiH
	Ca8Cnl7ZEtZEXP/1oLkIa4h1Gj1jFkiEcZvLExkjaJqRjCjycb2CBN79TQ1WjyPEJMF/GD
	yC6sinPHbDLkAF2KY0uIbSkDqQ2yYHaOXWHtdAiRq3F9GHoaxLaPDJ7EU4pvui4fRLe0BD
	5mXWX7v+cHqzBWCC5F1SzOTbmuzp0zl5AvtEQ7gSqkUzjiK9pzzAG5czIPeKMA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793951944; a=rsa-sha256;
	cv=none;
	b=WSyx0Jgb6GNVRPcN38i9ytAWGLn+XNeqVhMxqbCCuOmkY6pQfUKpyFcSUpHydv021O4dVO
	4LOzThaEUhBy8jbBwsaoHzGnbHygE3fmPJT6zFMVFkM37eqWIW/22VgpdK5/U8OHQ1s8Yt
	NjAuwsDgrEeWE6UDSzcFwKiCiqWeHONrbm9Rm090KCOkBucJcHC/Hn1yO0Bb9TVEkXUMb1
	7mjaLuQi8O95aRj9E15WnyqqRWKF7CrEkuIvwnqrUcGmm0OKvyEqzsvxxRD3ScrSrbDo6j
	j9ofV/qu+q/Wr5mDJk1hY5yhjYksEvBCFNjHCkSph3tQwd6JwBV3n8IlrYQTKA==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 06 Nov 2026 08:47:27 +0100
Subject: [PATCH net-next v3 3/5] dt-bindings: net: dp83867: make
 exclusivity explicit
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-v7-2-topic-dp83867-v3-3-45e1d3adf1bf@pengutronix.de>
References: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
In-Reply-To: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Michal Simek <michal.simek@amd.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=zOfh/nRl7qM9sGEpSyKo6sDagN6Ev7ZFJAk2eCa2Wwo=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bbjqOaF1p+5/yVfqW/plDsevLuc68/tH6YeDpjserpr
 NCaLumjHaUsDGJcDLJiiiwqCyv4RD0+eEZOE+GCmcPKBDKEgYtTACbCVMbI0Kng7ejBfPuk23Vn
 5WcrfllOevC+6eMBf2NNjRuLVOSypzMyNLt5lvls3Vmj0fpEu6nT/WHk6/ZowfpYDt6/X9eGR2q
 yAgA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

The io_impedance_ctrl nvmem cell and the properties
ti,{min,max}-output-impedance are mutually exclusive, as noted in the
ti,max-output-impedance description.

As this is only stated in the description and not made explicit in the
schema, the binding checker will not catch if this condition is ignored.

Make it explicit in the schema that only one of them can be used. With
that, drop the note, which also described a precedence for device trees
that the schema now rejects.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 2cd8311ece5e..833540743bdf 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -7,9 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI DP83867 ethernet PHY
 
-allOf:
-  - $ref: ethernet-phy.yaml#
-
 # only the PHY ID, not every PHY with the c22 fallback
 select:
   properties:
@@ -67,11 +64,6 @@ properties:
     description: |
       MAC Interface Impedance control to set the programmable output impedance
       to a maximum value (70 ohms).
-      Note: Specifying an io_impedance_ctrl nvmem cell or one of the
-        ti,min-output-impedance, ti,max-output-impedance properties
-        are mutually exclusive. If more than one is present, an nvmem
-        cell takes precedence over ti,max-output-impedance, which in
-        turn takes precedence over ti,min-output-impedance.
 
   tx-fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -133,6 +125,15 @@ properties:
       Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h for applicable
       values.
 
+allOf:
+  - $ref: ethernet-phy.yaml#
+  - not:
+      required: [nvmem-cells, "ti,min-output-impedance"]
+  - not:
+      required: [nvmem-cells, "ti,max-output-impedance"]
+  - not:
+      required: ["ti,min-output-impedance", "ti,max-output-impedance"]
+
 required:
   - reg
 

-- 
2.56.0

