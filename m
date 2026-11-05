Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888248;
	b=J8ZMy25NiM1yPJoLiYW4Am/b1U9DjuVncn8Z77ixPrwZ2FunZCvzw4NmF68JkFI0LCbm
	 6w5amyYZefIEknPXyMKMmxrJsc76Fn5Y9xa58d1pshwIBdpzIRrYmLlYHHkJuBnrvYrYR
	 3nbKTHq/8uSAKd2RWD1hiaD/bHXjnIAV8ZaEDdQ1GsQxGtTyfS2AdS6LWJm7FU38PMNVG
	 R8vkRA7CFJxkmWpGFoyNf2Mnch3LAC3Yo0A9kIyaVQsEs3Ya78YQhvdUSfubDgACLpQI3
	 j2yP8ApoBZ2XBTY1B/CTn8Shpqnjt9RkXoUlzFDGBH1pGZPe/juN6HSVGB4rO+4xMTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888248;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc;
	bh=iBP+b6prP6kyCPScuNa8zQ2uYPSjomx3LSDLJkMRsj4=;
	b=Gu8nVdMsuJSjdMlKu3X9R+B5fVndTsIizCRQU2O2HvNl+MNMcHqp6LMi5BkvYBAojdic
	 KTL5IMRy2wqCkwLp4rs8DsHpPnA5OMA5xKIyelD2Tn9RgLgkVJbimzh92qKy0FcWLjbmq
	 icAChT8iJACb48xqo41GE+iD+g5FLd64ZWafZCPS7QCwQXAi5iUjk0MJthArzoOGkjPcF
	 bk1yxGBaSB5CjZsUzFuQBYZp1OeNDLsMdX21XNgMbghfWVsmcUGlqM7nADkoU+y1dTww7
	 /D/V0P5w2tzWQ9e4yfINNmEGdCjAxKQIAabLvU7ajdAe5mOK73vla4J92XrKNnOUNCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OI4Gz62K;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="2tj8U/8w";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C796606A328;
	Thu,  5 Nov 2026 14:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C796606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OI4Gz62K;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2tj8U/8w
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793888246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBP+b6prP6kyCPScuNa8zQ2uYPSjomx3LSDLJkMRsj4=;
	b=OI4Gz62KXEPlhBiFiNBdlvkJqtOFm+oP5wedOTzxgUi3ixBjuDEZ27GboXZbDwjUl6DyMB
	GmZTBR6rZwwGRQEwsD8oZ4DUhvR4hiHJLeRaJgkOUDkUGVjOFkVr3aghANwDxMIM5KRK3n
	csz3J7teXT6r8TkbsJ9Ocn64bExLO/HA7Sfo3FkUbWOXtYF2fLI7PFFMtN67LZDUNX3ThH
	Ka7mlWmv0uCeLNNUzmxhqPQO6BoYW7fWjqnbh4tPjIpGjLNrHHGRpnBAduJq/Ju0+XzH0k
	Hlvk+NI5PCWYUk2fcvbKESXeMvOqvPnlCK0yHh+0nZnc5cz2fCAej8VJZU7e/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793888246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBP+b6prP6kyCPScuNa8zQ2uYPSjomx3LSDLJkMRsj4=;
	b=2tj8U/8woslDp+1Wy7NAGBItta3NCXfzj8cBvhOJYGOKgIfh2/x/8e3dAfLg+EWHQadUgX
	WF15C13RESls7pDA==
Date: Thu, 05 Nov 2026 15:16:45 +0100
Subject: [PATCH net-next v4 1/8] dt-bindings: vendor-prefixes: Add soce
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
Message-Id: <20261105-devel-vstrassheim-soce-dsa-ml-v4-1-02f3cde2afa1@linutronix.de>
References: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
In-Reply-To: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Lee Jones <lee@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, mfd@lists.linux.dev, 
 Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Document binding for System-On-Chip Engineering, S.L.

Link: https://soc-e.com/
Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..20a850a6e86f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1599,6 +1599,8 @@ patternProperties:
     description: Standard Microsystems Corporation
   "^snps,.*":
     description: Synopsys, Inc.
+  "^soce,.*":
+    description: System-On-Chip Engineering, S.L.
   "^sochip,.*":
     description: Shenzhen SoChip Technology Co., Ltd.
   "^socionext,.*":

-- 
2.39.5

