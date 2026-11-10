Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794306012;
	b=47pz/1izyZFwJzFTRbsG5/HSo7WesJGPBWAxyQZaPflxGIxRazQwt0bO/ctbmTxSn2FV
	 8CwvO1SlBpVOZsfQnR1H+1kgkSHm5Iyw855py040p4jMjtjJSkVTAV07Xmw3XmZS8Pwhk
	 W114f3CGAI+MLh8j2GA3xPNE0MAPnzwlpqyV9kHhYN1ek4MV6QviFzPvCn3AI59E9/WIj
	 gmh4Ucxi5h4JW7PZub01GW7V2wI9PKyge80I4lzySbDFSSDrAVjlJ1YPhO97AMhspfrJq
	 j2xPc2aczvlBcHvetEB0jfVop50KC215CxwLtX2fADhRFIXOnEVrtufsjhuyRCrtYHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306012;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bX/uUUUq5zpCBJOKITgDDQ+yzfwVENJcIRvnSi0VT/o=;
	b=ckAwoqkWJYEhChgbcOVzMAuF//AUTP87KgsxvW8SFq/ynir7z8nxdU3T+JuIRy2cEzLN
	 VQbFXVjPJ0eVVnvXZmjjAMlg9WKEOeAUEjMCnqj7vB43L8UZBnzdDt7rgSWgGZokjMx91
	 ruj/IfGtjA5yQrFbuxn9F7J1NXmg91HEB3vjKHYiRLD4LG+HU4tf+hj/SvMiydkeyOUxt
	 B7Qe79EjbY/5iRaIrZRTnJct7tv3jFpi4dWbtZsjjvhw1j6lKTEo0OGx90NYUfkPJOWmc
	 75I7/kfLmzX6uwckslVBvZLvZdXUY4nnphDwxaeXB+TQ4SBYA/Bcy/aueN2OoMfBVnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UugiCK21;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24411606A33C;
	Tue, 10 Nov 2026 10:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24411606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UugiCK21
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1FAC0201EBB;
	Tue, 10 Nov 2026 11:20:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794306009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX/uUUUq5zpCBJOKITgDDQ+yzfwVENJcIRvnSi0VT/o=;
	b=UugiCK21pv9l6/5HpqAmmsy3nT+yM1zPQDEflnBoNQDMA10K+Tlgd5O4+Rcs9q/RYi46Ea
	CuEp/culbGqDO0+lC8SnpWb0zTuDXkfQLJZHKOIjV8TY4VK/nD6O1x67H7yC8Cw20ryoQA
	97d2tYW/BqW5TfoI/s4yw+R+Wf6FgzjVRlBZTk1cIyInCiC/4xUmGUULtQQA0HBq4fr7az
	nlNfAb1XOeUms8AllmFzre1DiHZZFeL7s5Wc/xKDnyvjHJu5y7k14TBQPeSC6JhwKFSszn
	0AlH5HX9+KBdj4MlGxhVGAMceOcF50nkoDMp0j/svUCA0RUBTeuvNOrCI6bhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794306009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX/uUUUq5zpCBJOKITgDDQ+yzfwVENJcIRvnSi0VT/o=;
	b=amzx7bJokyYSKJ4oUZljP4OMzlVK5a7C9b5QdxcoQBaUl7PwH1dfr9LLWl2Ym4cktihnuj
	mDjo0vwJ2ROyTDb5C2nmOUDgrpYC1KGnnPPqHe85JXh0Zj0PpCEuzv2Fy5+CYH8Eqd3EVF
	rKOq4eTQAKUy40Oncrc4yogTWQFwl7nh8p7X7MFNFMhzHtIPT+8zg5h+6opp9o/20yJyX7
	/9LqbR+Pn9xMHcJ5H/p2o+4YrfwsxxGyh1LIIk9hW7GPwft3Lw30fQmTNVtjlXDRn6sceN
	aInf5521KH9+5cavd9h4QTK02Wbyux2PutaAwBpjcy48Y8Xo/5hNr4+EwVmgDw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794306009; a=rsa-sha256;
	cv=none;
	b=ET2nnB+duEP3MA4yizB4ELO/Bs971uRePT0WEBMjEt4EI8jCiW52Uskow3rf4o+rEDN+t+
	vHHTCZJ/YXsBaanAfVjM5hFxHBJXGGcgqj+kreIGQVgBotdGg9nfvhyj6oluT91HSdaIF9
	pLdmv4WdZZ/AGhSqcRnN6ck+YCkS46L84TXR9+JPjS+UDBkayimjB7pAdIlDQIAJm7o2aF
	oX3BEPNpuHlu5UGjYsTBc/zrIE4mFlmW83j9Nt9B0xj9LujlGdEsf6XsEANlYbmO0HuayG
	qJWC4PRaHbONnJxyHIMvIp8bCKQjLFieOlA/2aU/nOM24t72XH+rBJlLIPSqEA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 10 Nov 2026 11:20:06 +0100
Subject: [PATCH net-next v4 2/4] dt-bindings: net: dp83867: make
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
Message-Id: <20261110-v7-2-topic-dp83867-v4-2-a268f83b1ec1@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=sRMCwpzFKvkFIO6648eNAR7IxA+Kn/25bR6VPl9CbK8=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9an99c/PmLP3/slr535hIL+HVbWlY0bX694wChnWbRgt
 cgr+aKcjlIWBjEuBlkxRRaVhRV8oh4fPCOniXDBzGFlAhnCwMUpABO5G8fwk/Fl3NzKn56PPbTr
 rLi2XJDLqD7oJzn5ib7+Lw7Zo3paTAz/c27OuKRw4kp4A3+WxO30eVc0/JbPKgplYn65cobnztc
 xzAA=
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
index 2cd8311ece5e5..833540743bdf6 100644
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

