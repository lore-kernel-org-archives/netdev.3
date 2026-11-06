Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793951947;
	b=TaffJHdvUFjAF/gnzEWRmrJbRHO70nSKweHCLJnNv4vPj+QjJjGL8uPC9vDOHsKb5pfS
	 wDBM4HmLhBBOoMew7LgWEo+3Hnxd3VBs2FxuPZi3bVTXdXMCe/a/dfLymGu2wJ3owl0eI
	 NOsv+5Y/niakaty5oJu1Anhhsm54p18Iya52I1E7hz7VXPryK/2x0BICF3OHZxgK3DAv/
	 f450JFZf/2Y9MjDDC6QLhBcTyryWc/TXu1ynXtXrZb9kIHJ9Pv8nkHmVm80A8HcS/mci2
	 HESOZzvoWS6xx6rGSyQSk836pHOiyZL5eDVSfS55MwlrOpKThy0AldC3aNO/YrI9eJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951947;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eXbCjigGU5BS75dolvYG5VKNnOMuu6Ek4bzwOKxp0Ac=;
	b=wGqZpkRIp0jk/9ALuut2qU27UeStWvqJHz1OIxEuzjWSOIT8NZiyW2GbSF+OY98ALY64
	 yO6SwcE4SmN+uiMSf/eni57nTKdEmy+o4XOMTkTxmV7WcXpkaZ18EUmJrQOA2tLRJVu6W
	 sR0hW9XMIGptVmKIZIhzD9jChpZBvqWGqYofqFnYG6FBEeZw0UIBc+L0JJduwbEfOcf8V
	 QxsbOZTsI+68tu6qOtf8C0+A+h49oLEBtDDMy98vXUKm/lSgruP5j6HmycrbaSS6b0l0f
	 mqbPy+P03G6pHSWskFMgm/GP9a1GRjmZQVRYJsYLJ1fdtDg43yS4Lrgktw71jXfYpeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gDLYvGNQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB4606A328;
	Fri,  6 Nov 2026 07:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60CB4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gDLYvGNQ
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 66CB620178A;
	Fri, 06 Nov 2026 08:59:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXbCjigGU5BS75dolvYG5VKNnOMuu6Ek4bzwOKxp0Ac=;
	b=gDLYvGNQKrC0vSft805W2WWjHT75atIiGd8aK8pETwcsO5YDbouw+MZ9fj5fmrRutmldQ+
	LE/9NQC6hGLPCuUVOUuXhqGysZehz+IQR7QB6IL2J2HmnJko8GV4R/+YNN75pGpMRfGtZM
	TrzC3Pq/+K/qL9A/nGFTiJQ/xCPpwCduE+g2ujU2FcQVhAOT6y/7SN0rtSr3496vNftQc5
	dmhCPoW1/iTNjGBOF1XprvHPgJcLresUxGbxFxY57uJYLIZYtsDUihGiil3noFlaBaWZ38
	ivnIqw//la3AzzM+YJFCHAc21rW9l2DLXUrE1eTU+jzPr/6jL5JAxlzItmCqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXbCjigGU5BS75dolvYG5VKNnOMuu6Ek4bzwOKxp0Ac=;
	b=W31InUM7Vkx4gbu9EAYsejRuJ2G21k8hpvdSgaqucK28vJEWjmwyqBb7KMF7tN4yV9Wqzw
	xiGAq+ZLVUDl3ofYjoo+LwXzWFL3hQUxtFWdlPM1t0iPvQRr2fblrlW46q0qBoS1WDSN9A
	yXXHynGge7qpdtD2A2b2oi4QTuJ3IRKD/NyQith4KzlorlqwjAW1+Yb18EDtvAhWDLN56g
	nEvZaaWUzn6Jg27WWX18ZDQfb6kLlif2YC4dPM7zMyNyMjJM8i1D0f2GmFeeGANm02ufHB
	DTsa6G/xe7Hba3RjUr8P0ezeEe1CaOdkW421HSUkckCo2vwaAMQcaEPAWXtEyA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793951943; a=rsa-sha256;
	cv=none;
	b=SbVbQcaoQhcofB8Qr1xkAGgqiq3TKkO+QRirDx1XwgK8NCuwmNcSikbh5lBz35qX7fyWqC
	pFJ8wrLmpfdY/NTMNTAafjQn6A3Ape1SvGVK1KkYO38Ak4KPlAAMwIgxvGdiYaozc2HTqY
	MXptJBl8u0HfTDwktM4O5vTBI8IPHSJ1NMDCGUHGA0w/k2y9pwosceam6Iym6X9w1Gnuev
	7zDBp+pLjg0IWdjlgN530S3+erongjebbnbE9MaNNZWc+fqEtJHwbkcYTjYGtOltKEhn/6
	KLIysmsfjgWzQEkUzzznRFhlj92cVe20I1O0huo9o2q7W1JTPXKlTEQsZ/uAew==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 06 Nov 2026 08:47:26 +0100
Subject: [PATCH net-next v3 2/5] dt-bindings: net: dp83867: add compatible
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
Message-Id: <20261106-v7-2-topic-dp83867-v3-2-45e1d3adf1bf@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=Sg2dYJ3IiZs2iqpA2t9cb0c8fY3JPwCcoA8EgjGoAdE=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bbjqNlhxj92Jal8ZRPzrGtm6n+6xdTu9iJfQaTvvCZr
 7/56lpORykLgxgXg6yYIovKwgo+UY8PnpHTRLhg5rAygQxh4OIUgInYCDIytM9Urk59NZnrycvM
 8z+Wsgs7ufJvy/0eKh2/0imRqyl5A8M/TaMpAVuEzsqbnG9/8Mb77MMz1Uvu7jSu9jjz+khkT2g
 kJwA=
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
index 4bc1f98fd9fe..2cd8311ece5e 100644
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

