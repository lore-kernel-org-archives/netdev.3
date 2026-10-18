Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402404D0A1D
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340553; cv=none; b=Ub4T+7cySrjg69uJERWxx0BClLNgPKVJdPj0KxYx302ZabtThFL57z5aWgPztqN/+S7H19LBLVUUTyAkIEsg7eVvHORNCRhg7Vf2b4r3E5t7ugh76/2oUAcg1Roq4hVkYhrhnQa79cv2/3u8pPTH9A0EnIGdU2HeKBtBtJ6ocT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340553; c=relaxed/simple;
	bh=td5+03OzHbTI03GKtAD9pk36sOBQN8LIJH3ZHfBBvaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTIwUxC+SHgpgfYgHtpB37JVpi0g/YsinTnudGRYsaNxJDmUUt820RnBUyksWmVg6HQy8IqcsZ+i+adEXInjm9gNQllNgnCWl8q6nwhcxXT5AibYvwqXgaurQnrKvi03VxFsdHOHMPPDzVzL3KBFUj6u8DnF0eeMyLAYMJpAkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=q2MaYdvQ; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="q2MaYdvQ"
Received: from terra.vega.svanheule.net (2a02-1812-1620-5d00-3535-4149-dfc3-da80.ip6.access.telenet.be [IPv6:2a02:1812:1620:5d00:3535:4149:dfc3:da80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 4DD01955C9F;
	Sun, 18 Oct 2026 18:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1792339986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAW1p1GPxKNfBVYIG/Y9yC+5L7hEJx2FZQ0m8ROd75g=;
	b=q2MaYdvQ9H4iVj/2Y+yIu7q8jiMnAbmMOhjskMYq/xU3s29j3Sf2MqMiTR4G4c772JTo5B
	T67ES758BemD3//+ppVlZUxlKoEJIAisLpUkZJ13PazII0KtHPy2Eko3EKvMbNqtN/SoXp
	pFHbeyY4slhmDLBUvYpaDBdItsOPxuFx22izjrD2vEY+WSvOsgZUgUS/FNuHMPdr2tK+Py
	D3LTYWwJDPjH9yYum5DkDTdsZOlI+DJRAwqQPCX0UaZoHyA6UZrxYBtETnZDADc2wtewhO
	YDxF0CIkmwKGMUKmOta8pCeWWH+cVWTpeMnpiLC8k5Ww7mrMfZ/EcRcy/q/g9A==
From: Sander Vanheule <sander@svanheule.net>
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH net-next 1/2] dt-bindings: net: pse-pd: realtek,pse: add gen1 I2C transport
Date: Sun, 18 Oct 2026 18:12:47 +0200
Message-ID: <20261018161248.376205-2-sander@svanheule.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018161248.376205-1-sander@svanheule.net>
References: <20261018161248.376205-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the gen2 protocol, the gen1 protocol can also be used over both a
raw I2C transport and an SMBUs transport. Add a compatible for the
former and the compatible for the Ubiquiti Unifi Switch Lite 16 PoE
device that uses it.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
index 3bb32349c28c..526f8525bb4d 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
@@ -54,6 +54,12 @@ properties:
               - zyxel,gs1920-24hp-v2-pse
           - const: realtek,pse-mcu-gen1-smbus
 
+      # I2C, raw framing
+      - items:
+          - enum:
+              - ubnt,usw-lite-16-poe-pse
+          - const: realtek,pse-mcu-gen1-i2c
+
       # UART
       - items:
           - enum:
@@ -100,6 +106,7 @@ allOf:
           contains:
             enum:
               - realtek,pse-mcu-gen1-smbus
+              - realtek,pse-mcu-gen1-i2c
               - realtek,pse-mcu-gen2-smbus
               - realtek,pse-mcu-gen2-i2c
     then:
-- 
2.56.0

