Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794306012;
	b=UGcT/e5MFZRDG27RZeSbLQySh2Wsc2yih5cc/7VKcuYDZbou+C9wYEPB6my8NTBTp/WZ
	 LC4I4na+RtPHOPwY3kPw+RnAoW3nt7ob31dw/IU/jrkm0nWyIyL2CT8MDfuzXy7yYnraD
	 Y7Gvkfbum1mrVQAOxxnpW5vxmrV6uumxoAupOECdow5Bn7gxm6N3OYSyziWEjATTbxRYn
	 LZz6o8i21nGY3dAGw+oZM6/znYM8uoF4HGAbHrhmxVLFGNF/Z6KHzDuGGiBldClMJYH9j
	 Kj2LfvN8g0ybXeg3YxNTd2XCbtqAvkKFGKrgv5DxvkCxe5U4oP4lNyhaRtdXw7HS1DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306012;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KVeJLI262GQOwgkIM+Lo+FJHrkVEyMGjtLIOXJkRGag=;
	b=hczoHYnFRFGuMAZdLTZSfF06WkxixkLDob7u8M8lpyzcdEiTQ2RyUMmmavqbtKIz+mZI
	 Y7snZne8uDFo7X/OTB1xCYYt4KMgJpUT2iR4VVNl9FJ0Qxv40vZDZV9MO0stj5PYX+L0e
	 v+YDheeQJwG7IrLYa6F7reCvPKXKuezwp40B+kL+bucDUMK/861IAqXcNTzT5/aEy/w4i
	 o3FBNdyZubXnD/3eduj0cT2IXbN+GUSRR0QS5uhqvs333YTugGjYbgLXSB81Itu7kpu67
	 k7ay3VUqGnRX3fPpLlWmZeD3r141zOKN9bEy47jwI0PkNg9LF9iDRWgHzFxYZCvTpJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MPcy1tRR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D58606A334;
	Tue, 10 Nov 2026 10:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5D58606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MPcy1tRR
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B949C200735;
	Tue, 10 Nov 2026 11:20:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794306009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVeJLI262GQOwgkIM+Lo+FJHrkVEyMGjtLIOXJkRGag=;
	b=MPcy1tRRynkPh3lAO84usTLQ0b1WgIK1SOOOcse+g1WDMi0BBFzQdtRjLfBK6QPRCSaMdr
	NcVSRUT/gmW5inHKQcQx1VpRZ/Cwkrs3ND7LUby1T6poNx19O2q25hP5qW5KVC4FA+AqFx
	Y/182S8qKWc8tDhg79f8VQrkt50vx2wav5HgLJDt2sNHhrPAN4KmnrO578HeZUA3yhKBz4
	mhIC8PvQmnTz6sRx43BON4osfhuAqzcqMnVqknEoJgAhQFMRRIVv/lnLOvg/zd4ItrEaaO
	By8UNQ39qh6pvwvyHoOKOIhpiBBS0ou0mzewtfRo8jWRatZGiEK46w/SSUZA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794306009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVeJLI262GQOwgkIM+Lo+FJHrkVEyMGjtLIOXJkRGag=;
	b=ACa6qP0Si2rxg7tAxh7RkEwARuwPKsjBtBlgzHgLjJ31Y/VaMDeVG0BMrYZgGDncS4LC7l
	JPNhjIHcLgxGRNfaFo4JVlr7u1+LklyH974roBkjOw7dtxYkK82AIlsS2fBiPEb4Tx93br
	L3v2HS3Neba56MVbafqvgFHn2TvDv+Ft1zZAjbPEJUwbCdDk+FKdV8DStt+posbE2ckqwy
	l5L3GuZ2Liy7puhppBtLW4txNTAr3BYUb3nT584fKgkyrR8fIUs3IBobWlBtX5eE1Hqsdg
	vuC26F4qoj0PsReKue/6qpMYQig44KTKHN4xUetVHtNk4YBf/ixhSzJXs1/WZw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794306009; a=rsa-sha256;
	cv=none;
	b=aMZ5OdKmRqLSmFN5rm0mnesOuzyOx+fZs6QUfEYjoLI+xW+CmlVT7Z92D4rq89b0XkG+Is
	tCklku1Dtds/gEiB4ysn2GdmPIutugVFIPZdgkwTAyQ1j5IL5shll3IGKffnNzEZdF2YiB
	+KqcdZMhCJaHJ7cTqre8QlsdpsSa45lPxQYPhPCBtyRzAqgOyidl0t4LNEWFmep/BoAIYM
	OPfOxaQ0YjaAeN2DmkHVeCOm/+8ShpO9ToZYb8N/sWmG/VeW/4JOHFdEMRcEiChzsWyzEQ
	Pg5XIuZFbrtuAqofPeVqsfOO/f5enP4Aed/oLEEDFFoeWTYS7ZNF/AJY66vWgA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 10 Nov 2026 11:20:05 +0100
Subject: [PATCH net-next v4 1/4] dt-bindings: net: dp83867: add compatible
 and reference ethernet-phy.yaml
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
Message-Id: <20261110-v7-2-topic-dp83867-v4-1-a268f83b1ec1@pengutronix.de>
References: <20261110-v7-2-topic-dp83867-v4-0-a268f83b1ec1@pengutronix.de>
In-Reply-To: <20261110-v7-2-topic-dp83867-v4-0-a268f83b1ec1@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2214;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=NEOV5aHCdVaiw33Ltb5HppAx7bx7Wi+gZ7iCADLS/OY=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9an99d1LPIrnlYeuF2/N6VgU2rY/i3Lai2aOE4JJsTmx
 CzPPbe8o5SFQYyLQVZMkUVlYQWfqMcHz8hpIlwwc1iZQIYwcHEKwESm/mX4X2HCaNDLY3zP/YJk
 79uMO81syToH2dcsvcO5pXPb+ZAwPob/fuvP5/rWNX7I/FVzeNVrIZFLeyawhz2ey3It9v/rJ8s
 2cgMA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

The binding has neither a compatible nor a select, so dtschema never
applies it to a node: neither the example nor any devicetree is checked
against it.

Add the compatible of the PHY ID, optionally followed by the generic
ethernet-phy-ieee802.3-c22, which several devicetrees use. Select on the
PHY ID only, as the fallback alone would select every clause 22 PHY.
Nodes without a compatible stay valid, but are not checked.

The binding also references ethernet-controller.yaml, which describes
MACs; its node name pattern does not match a PHY node. Reference
ethernet-phy.yaml instead, which also describes reset-gpios and the
other generic PHY properties existing devicetrees use.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 4bc1f98fd9fe5..2cd8311ece5e5 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -8,7 +8,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TI DP83867 ethernet PHY
 
 allOf:
-  - $ref: ethernet-controller.yaml#
+  - $ref: ethernet-phy.yaml#
+
+# only the PHY ID, not every PHY with the c22 fallback
+select:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-id2000.a231
+  required:
+    - compatible
 
 maintainers:
   - Andrew Davis <afd@ti.com>
@@ -28,6 +37,12 @@ description: |
     https://www.ti.com/lit/gpn/dp83867ir
 
 properties:
+  compatible:
+    minItems: 1
+    items:
+      - const: ethernet-phy-id2000.a231
+      - const: ethernet-phy-ieee802.3-c22
+
   reg:
     maxItems: 1
 
@@ -130,6 +145,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
       ethphy0: ethernet-phy@0 {
+        compatible = "ethernet-phy-id2000.a231";
         reg = <0>;
         tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
         rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;

-- 
2.56.0

