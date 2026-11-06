Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793951947;
	b=Us2MYxmdgQtb9bDl0d2xx8X14l6cX8yV7zwwPIYTfxiNJvdqMgibFjTE/nKH3rLGjF41
	 LiT/oY8b7eHcoYYKxAaM/djOwverniYuIsO/JEezAkBbunQJ6blSfIR3v/sOGwliizrzD
	 ADWKeJmYbaXPtEkHeYFMNGFWxBbEwHvqEweNT0n/2LU/ZTiixrMHYR9iBmcEZ5osLEzqy
	 AIwaybF57/iPaaUzvteoUPb6LqUPPuiiwL/ZoblTCSCEQL76NPI2KenFqpBiEj7JGSRQ1
	 aWrTrOksdKtrfKPl7JPZ+3UxulC0yAztdSRwKyrYK8IPUnOcdlUYxnnv6xQqJ8WrIPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951947;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2FNHujqf/xW+WUTfvx7yJ09qH4DYbXo0SGisGW1B1tg=;
	b=0DxxKq+Q+aUyBS4tTjKlMMl+jMXSQMz1asrwVrl0oCQbSEsGmeD6p+cl8ztMmo0Km/Ip
	 A/WuhUYOBuZB/dOwaokyuiumVUdP5uHoX/sHjjKVi3W6Hp9B3oUplbU26eCTPhOwkdqd1
	 vxb0vqb+niHIYyif8xN8HtOdqrAPEfFcZSzJEtjIxb1OtbyWhEEMwVf4rdvixuUYf3Vf0
	 owWkBhSb0PbTRfz2EHkzrxgghcbcggZDYrmSPgNy6fmnp8WCtc/V2hc9h6CmZH17loT3g
	 fixR0A7z7ZOp8TSh0fl/v41qVsFH+GniEBCKIhBuIyILSiV2PRPNYinvv/D7pWH2BoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fm9edfda;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350F606A32D;
	Fri,  6 Nov 2026 07:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E350F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fm9edfda
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2CB2720291F;
	Fri, 06 Nov 2026 08:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FNHujqf/xW+WUTfvx7yJ09qH4DYbXo0SGisGW1B1tg=;
	b=Fm9edfdaJHMQzHYTEMRMNWQ7bDrHC87XClNqfzmPjXJYCU8iH6FUVIP/gygd7aDMpravOM
	Z4tLLNUhXYqfKXKKqjQ5W+ixjyKeONLu+bebo7Z9qkFx8FRUBFA5u/HoAccjDWCcL7pQTo
	JLZVd9JHqmZaMBEaB/0nfWRMVrWjNYuNs2Fn9jlLRUMk3eJQQSLFOZNwMHN2NZMTFuDA+1
	pE4QYKaIFf/MM58p3sGH8g5bapx+2tLRJH7EgHBBDWRx1esGgP3bFOeY85ukS+twDlCLPb
	apfpig9jF5cP1guyEzvrXT27O2zD3NiSgc8I1mG1jsysIfOxzXuTHjMd+zAmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793951944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FNHujqf/xW+WUTfvx7yJ09qH4DYbXo0SGisGW1B1tg=;
	b=JiLKs7Uv3TStW+q1zLmUQbTDuIS76f61w2SRbpB2sX5Wr0EIvAW6NFSEd4pA+UET1SBGJj
	sYWs+u1cJEsmaK1Ic7Igy8nDP3DfZsEadEZfyP0bQEURj0qROAuG0k96iIcXRUzzVlgVpz
	I7M9LSlQdQ9uavlyvBf/6iEkMo8kAyN+MtCTBM0S2+6Q2kUIjmJrC1CvYYoBaPRUUkqAWU
	0kNpHUjN6PabHK3/K3InxEolWKNc1QyeFQBIJq8pfQ4H9l+ShyvYsxDTXOHu19A4bNKlnQ
	s4WvIiNGp7E2MUb2lZpGKkdW/SRj9kAMxMdGXaI+67sPpUvGQ6Ne4Wi+TqQDZw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793951944; a=rsa-sha256;
	cv=none;
	b=WlfXEyqKTfPKwMo20+4+tLabKqz2pfqQdAuce240RY3ZLio95ImDK1dzVBbqnv4mlVA2Qh
	BZ4DC+8pz6xLaEN20bmdTPNN/MlrGzA7R6F+2TC1tH7vgIMbTvjA7TEA7tgueUXrLduxhg
	f45K+ZmHAShUertYVZ+wetJYfMz/kH+Ysyu6XsmCOw+IjnTqhzKg++Ud5ax4b0/SE3ys8Q
	08yA3UzLGSh67/nkJB2+wLdxtpYALfFfgpw8D8g5CUJuwbJqnZt6B26bgkAWjc5SYew8Or
	r1oRqSLeDOY4BCDH35R5y3PJOaHT6Kae+wZXahbASuVGzG1eXVqOJ1Vy+899Ww==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 06 Nov 2026 08:47:28 +0100
Subject: [PATCH net-next v3 4/5] dt-bindings: net: dp83867: Add
 ti,output-impedance-ohms
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
Message-Id: <20261106-v7-2-topic-dp83867-v3-4-45e1d3adf1bf@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=UNoS9edile30rBgykZiF8/v6sxxNw5SeyOvKa8PLluA=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bbjmO3+kXnRxjxHfx0K/Om7rFvi9zZfikukfqfo1PA3
 HT/+K3+jlIWBjEuBlkxRRaVhRV8oh4fPCOniXDBzGFlAhnCwMUpABOJaWVkOFXxmanlTt3B+cKM
 Tj5Cqy0eTM7aVnFFaaH479odhv6RPxj+KZy5uDR0YefJyx/mSRkJJ0mvV/v/Uqj1wMWmIGX57nu
 n2QA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently, the output-impedance can only be set to default, minimum or
maximum or via a nvmem cell.
In cases where there is no backend for a nvmem cell, a value can not be
set.

Add a DT binding, 'ti,output-impedance-ohms', for specifying the
output-impedance in ohms, between 35 and 70. Like the existing
properties, it is mutually exclusive with the nvmem cell and with
ti,{min,max}-output-impedance.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 833540743bdf..557d2517a72e 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -53,6 +53,16 @@ properties:
     items:
       - const: io_impedance_ctrl
 
+  ti,output-impedance-ohms:
+    description: |
+      MAC Interface Impedance control to set the programmable output impedance
+      to a value between minimum (35 ohms) and maximum (70 ohms). The PHY
+      has 32 settings in this range; the datasheet does not specify the
+      impedance of each setting, so the value is mapped linearly to the
+      nearest one.
+    minimum: 35
+    maximum: 70
+
   ti,min-output-impedance:
     type: boolean
     description: |
@@ -133,6 +143,12 @@ allOf:
       required: [nvmem-cells, "ti,max-output-impedance"]
   - not:
       required: ["ti,min-output-impedance", "ti,max-output-impedance"]
+  - not:
+      required: [nvmem-cells, "ti,output-impedance-ohms"]
+  - not:
+      required: ["ti,output-impedance-ohms", "ti,min-output-impedance"]
+  - not:
+      required: ["ti,output-impedance-ohms", "ti,max-output-impedance"]
 
 required:
   - reg

-- 
2.56.0

