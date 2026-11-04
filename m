Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816479;
	b=D19MEg5yxSF/snBFiwAcUGz/DxNvhpdELslWMVwJI588ukvET7jMJ6v71Tx2OlrdPQtg
	 +A1+HOyPlFSpOAsHJj+88lvctNjLzK5YFMFr1a9dsWF8QVqwx0rafm+aMO2c6NHAoKlFe
	 MVKN60MoCz5rQx59UmptV2FO3tVnpDmlA9HljgvA8UKlMStvlLD4POcnnY3Ucvd4C+EJy
	 A32YIu0/0q1BZjtF8pBp+Q5HTiLBc8HPu6eNkdQd/ZoK3ljv+Zd1r5ISZeW93A4GnTJWk
	 SySL+xKTKMbSdcjXrGh9pExF1zylqN+6AVms4UixTHbqEBJpqSJ18XT032G2HnwMEkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xFvESBDRc03vw3r4G764xn86wJOmVghZmhz8uSPjRmw=;
	b=IXdy7Y34kEHm3NRu2Rhy3EAaxvq1hlHrsIJRvOZW2h6xgNNDkSRV3nNvJHXzwMI4kz+Y
	 7D4GXot/SeTfpzFRKbe9d+PYtIH/AzN3qIMxwwRe9PQTZhVAEyp/hzrm0cHbmNwaz0eBQ
	 kwNtP44xabDR/EKw6wz6gyH0ctHUnfc0J7sPCYoFjk77aAqixfkKdnChQa/WSar2gsslX
	 1qMoPSHet3IdkUTCeQ1oP1E25ulBXxb/2qiggbc/io7LXtpW7dklvCel5dNu/nTiFQMfH
	 aIw7dokvWgS1+XFYwK6134qbiV9K/R7VorhDKVpqYzZeFdMwLVogguOnWSb1ycbpiiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mc2YvxkD;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374C606D825
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F374C606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mc2YvxkD
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so934093f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816477; x=1794421277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFvESBDRc03vw3r4G764xn86wJOmVghZmhz8uSPjRmw=;
        b=mc2YvxkDKEeg2lcrOssOXv0I+WaqYQYrqleUksf2y8thSRC/rHemThvT7wQcFheOf4
         osQJ6NhXScf07S4avWAH2B43pAlG1y0GWM41g5kRwBOvatoiSl1gOLxuPaNxXFU/eHsC
         RxwLTYH/fGt+0xvlHbcZxw6iJyGvI1KJ71nr5rGwn5wew0ztYNmDZkVrmrFawweApqdc
         qFD15KvSU6EKoKCRxvTxIWfeYFuhZLXYRj6MTY85hk29aqVH4zH2WLFyMMCE/v9Ehc+g
         xpdzZ0MZgcfZ7seqORjj266fQ1l2huUXps5oqIRJUW61KFvrTaPcnw1Vj1YzMDIRvLSg
         TulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816477; x=1794421277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFvESBDRc03vw3r4G764xn86wJOmVghZmhz8uSPjRmw=;
        b=LJzI8ZtZuIn8fylG3XlBHAEs5FycNC19DLAK6qkID70iqh1+TzBNBYc/4YdIPpW9Fz
         eUhWBJuDxIPY7JOZFtz28c1vwBje/U5aBjqcmJZtQLgM82APT1MJU0WoGaBlPLBmbOoV
         RwlAZnYbU66wd11ZeAKyZXZFgvMGZfUm42EM6ou6wPWRhKhIwvzmUHIKD1yBHd1j3BY5
         zncRoN+jJAaw4vNA5l0T0qsG+1aw1b/cVMHhX9vNg7h+dYrTs4zevAfFpXAF0pG2R5VT
         BWQ63XDpn8WKqNEM50N8/5T02uRRzJc25NVM5qUlIhWIpflOG8X8qdP5mx6ydbdLIUoj
         2thg==
X-Forwarded-Encrypted: i=1; AKwUvBwBGu2qy5/O/babW1svVflREs0FlU+ne2B/lVTAeLSpSWAXAADgZ97OurTG8zIOLyuMl+k8fso=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hs80whPTurVIYkvCalbjl/cfyaPXUrkDKi2bgIM4tjpv/XeFx
	EnZIzc2OcxXDxc0AsLD+qtM1phf7zVEhD1RNU6DcvEM/E9QRpJjURU8b
X-Gm-Gg: AYBFou1pp46Hl0S5fhWU0p59uOr6XNyl4r99vzI1H/FzR1vHhJ18kQoyygnwjSUY74K
	70NyvDKCvEW9JVmUl0gM0X+6pAvApUUs/qL0BMg7+iTlp/l6y3Y3yKFW6Oat7BuKrKGG737h2CV
	NlegoGsnDCwFB6A9M1Tfe6Wx0POSIHkRgX26fovUyOIjmc1Dzokj3jqeDhBpvdIF10iDn4aY6fe
	4GhQtygSOdPjINNA1Ld38e+jbPEK31eT9Ue6udp3X2kX6sYJdSrT9NVPugR9CBkpvHxZrt1HCdo
	HXJGaWulFqo4LO8g4YQ74PYEWF58YHEAdGWL52bs8ChvTFELmVJ7qGz9c3Da0McScySHOU/c70G
	URVnlijQxd1WKt/oU5BQkpBbexJ7ufm0K1rKdSte4bRF/yIXBoPu8st6Xvj7/Qlm42QRB9fPY5I
	eWZjSyAgWKnTcbYh3Sri+K+F38H/OhPW0t4jl0fx6uqOfqQlOjaU/JIwn5bTsc3M45gpVRNZqY4
	VR7hksh6Xie3EYtKE90T/7XqjYDgrCxZi3QatK8OehG1G7EYX39ZXXYTlt/87eLJLDCcYJbzjUa
	c1f63jPpKJN7BD7M3jhVwikZd1A4jlP9s/GYIxnP8QCJTQ7YK7T/+OuZ53xVQvx4KBKY0IO6FYT
	+sFwBBTuDlQ7s+dyH+Kn1G+WD7IdMRNqBOG/2+g==
X-Received: by 2002:a05:6000:290d:b0:48e:75f:477d with SMTP id ffacd0b85a97d-48e6e2dba63mr36517267f8f.7.1793816477063;
        Wed, 04 Nov 2026 10:21:17 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:16 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 05/14] dt-bindings: net: dsa: renesas,rzn1-a5psw: Disallow ports beyond port@4
Date: Wed,  4 Nov 2026 18:20:53 +0000
Message-ID: <20261104182105.1102555-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Restrict the A5PSW ethernet-ports node to ports 0 through 4, matching the
hardware configuration of four external ports and one CPU/management port.

Although the schema pattern limits port nodes to port@0 through port@4,
additionalProperties: true allows other port nodes to pass validation.
Set additionalProperties to false and explicitly allow #address-cells
and #size-cells so that ports beyond port@4 are rejected.

Existing in-tree device trees describe only port@0 through port@4 and
are unaffected by this change.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Added reg items validation for ethernet ports

v2->v3:
- New patch
---
 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml         | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
index 9c477ceb170b..250c59e58439 100644
--- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
@@ -63,12 +63,22 @@ properties:
 
   ethernet-ports:
     type: object
-    additionalProperties: true
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
     patternProperties:
       "^(ethernet-)?port@[0-4]$":
         type: object
         additionalProperties: true
         properties:
+          reg:
+            items:
+              - maximum: 4
           pcs-handle:
             maxItems: 1
             description:
-- 
2.56.0

