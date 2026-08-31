Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6940BCD2;
	Mon, 31 Aug 2026 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180866; cv=none; b=GiaLBWQBlL6rqEiTSKN8JHjn2v+e+MTVoZ9LlM0e+DBaoGRjymGHHSX6ZYeXNOiGgn5lOYQSrRqZa0LeRuyFWiWX5IHl/jPiSPIZa7g6X76k59xIhxnVwCK13HSkt5vcioOSw0It8HX/1JMiqB1g83gWw6oTwZx3Ea+alsf5jVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180866; c=relaxed/simple;
	bh=KRwObc38dCsL+DMjX+ACtzzAkYCQQKuVBqUWh2pJ4J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLFx9tZsjO+/YESRaVLZYFAt8ex8dL7DJKAaF6BzgZujjbPiw2qaNPttET5aX/ASknODjXl1MPR9hzYiAgVJHarh4BNfQ0ImqkiDdjpg7RMUoxuVxFMqN6XPYkeYUvzbVRUKWLUgl9DQd7hJ6KadgmLKz+beu2e0lB6I9bOh0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=Fr5MeDL3; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="Fr5MeDL3"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7978B3EE25;
	Mon, 31 Aug 2026 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788180857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9XpjJvgDZb76wpKWcPbjb14vGucnYqZwnzLbwbLtnE=;
	b=Fr5MeDL35t8J+SZpmUgygaQfLyjPfVVTGjMx59abeuta1U+pjjjMCTgyqfCG44ia1ru8/s
	ukwrVUrkG5XsX6ucVTEtPm258pQcprCyWvKgoP64jET+mukTgs9ql6pbLftJO0DZAP9Yao
	zUswqg9SXr0wXHiITQPYFXqdTcx3q2T2qZsTXFREClDN4JsTcMGOBjFqLYb1Fc5B1bsZRH
	FuDSzliasfkJoMqvfvI4TFft1j9q9gTWdWHBhVrnTFDgMYjJA4pIta2H+eAgURjvkz+q2z
	dhdBrsLgbtywwxSVwRmgB4dP00yy06ZQ45EDxByyzy86BkCICQ1+Q62anJueKw==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Mon, 31 Aug 2026 14:53:35 +0200
Subject: [PATCH net-next v6 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-wiznet-link-gpio-v6-2-abee6c5c966e@marmottus.net>
References: <20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net>
In-Reply-To: <20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTFnAYAbPsQmdBbSjjcIcCyVvtkyvcgvrXKYgeL3G39/dtl9jIE01puh6LxyPBp3VxJ/IAZv/5LqgNcKN8gQC+IIMVX3Jx2hVd076mC8HvsfENZKpY02epCMBDk1TI3O835BtM/38lsgtyFEnfDFIHqAAoobwiH3gA3uyLT01Y0eXgq01XLUURWMTPCqZMGDaOoiM1jVFIpUbExF7A1xzqnmsoxIWykHUG+pj7aap/+a6spNV3uR1lLMo6YX9bnrgOWWyiQs+vG6vOv8o8W0yaHlgOszd6qPQ5GMk0pcinjVyF/g0p9X0fQ/12gWOzayfW2E3ATH7aZ6S+ojMKMVS6L5BxGxT1Tr8zBZqx+kZW1/+5bJ0yVL/ONjrNcg3XkzHtTZCR4an5xA5zwxZkb38W2L8CiF3RYboPaMLQ38dg1aPUqU9yyGABPD68S9AnwZS4xbepkq5TbwZpq28FF6W35Nq4lU6AJ9/16wCMj4rvzTPYfFDkzaK3DJstp9JpSbk+oBDb/tcjpNh0EUDPJm+2f0CI6b0dIo9KOS+FnCKNPbLk/HWM581KdsouVEW+1bdCg1oYmr9E3LVQ11wbxH3vQGZyuYVpwT3Wl62SqRDn7rdbWjKKqecHjRq8TBfUql/QltKT+FWvUi6nc/n5DEheYdBwfWdzPBko9jHvM7QN5bWQ
X-GND-State: clean

Add an optional link status interrupt which can be connected to the
LINKLED pin on the device to detect link status changes.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>

---
v6:
- Fix DT error: use minItems
- Remove conditional properties

v5:
- Make the DT interrupts property dynamic from the compatible one
- Fix DT bindings errors

v4:
- Update interrupts in DT bindings

v3:
- Fix DT binding errors

v2:
- Convert device tree binding to YAML
---
 Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
index 601d828bae92..d0717ab45de6 100644
--- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -24,7 +24,11 @@ properties:
       - wiznet,w5500
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Main interrupt (INT pin on the device).
+      - description:
+          Optional interrupt for link status changes (LINKLED pin on w5500).
 
   reg:
     maxItems: 1
@@ -58,7 +62,8 @@ examples:
             pinctrl-names = "default";
             pinctrl-0 = <&eth1_pins>;
             interrupt-parent = <&gpio>;
-            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>,
+                         <24 IRQ_TYPE_EDGE_BOTH>;
             spi-max-frequency = <30000000>;
             local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
         };

-- 
2.55.0

