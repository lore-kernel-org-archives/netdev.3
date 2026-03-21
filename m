Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120543016FB;
	Sat, 21 Mar 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119297; cv=none; b=Bdthe+iYiq2UUWrIldpwOHGjp/Us/Vi/xauM2zVRkz9S4B0MAh9CLCso8Pfo4z587zljT5GF4PL2XPWeuY6LDDlHKrbFi1oWQxbwxX9oyb13ZNfh1UALHeEH5eySW6iIMfi3wNkggMWrQaBdloe6xau4DydJYyQfC6Cw6y4T+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119297; c=relaxed/simple;
	bh=lcUjA2tOXH6xrPM+MteHiFBZw46mc+U013QORqy5ogs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ef8ph9vzLbBHdx2Vxl1gwrsodPxlFtzNSDiAutDUpWcecvx4JGhsRQPYmxkFZGdGpgqdpqGQbgce41OAts9pG+MPsOC9I3zoePFylPblA2qn7XARqt0Er58FcrKyPhrXl/7bAK4Zz6BHDHXt06Lk/QONBozlIIJAT0kD+yht4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B9ySxL+x; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TEzKBDnw; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B9ySxL+x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TEzKBDnw"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fdT3F3BY4z9vDH;
	Sat, 21 Mar 2026 19:48:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774118905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xaB175QEGmnw0RID6ZBF0oUHABZ4Kfsd8JaellT99Zs=;
	b=B9ySxL+xQrypQhLjspzbMqPpdiixyaMfXFKFobJgPQGridPkTkdhk2j6d6u8DU2SvT0H1n
	UpXbcEML83x2kiskGdJK0qHKdKxanaqU99rQYfZU19uMymIgErxBCKvMGDJDyDj9dKsbpL
	h2TWwCbi7OixULibBmxUVXhHdzyq2dTtyvdHFv1WOJiCAgqQADbcr877IDBQqgh1btyxAZ
	DHHlpIp6NzuuJOXeiChfaF2/0kb8KDwnlyxHHgNyTaAwk+tYNuydfM2jMWkljkigtH8a/m
	QkM1yzqCeLy3fjtw+0s4CKdgyHzLZ71m+msHnNjVLdoB7ZbDes+aVNpnSpTmDg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774118903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xaB175QEGmnw0RID6ZBF0oUHABZ4Kfsd8JaellT99Zs=;
	b=TEzKBDnwxJmsWvVaMwHRu9vKmPkUXgBmRnWuBbnGGWhiQsA0RbNKVB7Y5Grs37+4SYQNn4
	2BTPtVzE+SA8RbzCf2re3TCCzwvypzOvy9bT0gyk3lDTE5WNukdY/YYR+Zv0zCcbo9UwXM
	HlELhgNBHVSeemzOYgf1p7RuTgq4zXYa/wG/39MGVpPPXijyGxirXfKgcgrwZhNU8A+ptx
	ADdEVeOMnBTCv00vbQwmbziiMXeThxrq3Q08IQq0OmshSW5Ru6n8++AF9ULrIiVnfvH0Wd
	BGBHTOLnlxiIV0blgQ8+z1s3vwKU49mGMlhZfk05+PfhoEl5DDpOLggt9q2H/w==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v4 1/3] dt-bindings: net: realtek,rtl82xx: Keep property list sorted
Date: Sat, 21 Mar 2026 19:47:41 +0100
Message-ID: <20260321184815.148485-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4tcst1quwihjhkgp4krxphrq9r4jokzq
X-MBO-RS-ID: f76902603a2f2e71159

Sort the documented properties alphabetically, no functional change.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: No change
V3: No change
V4: Add AB from Rob
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2b5697bd7c5df..eafcc2f3e3d66 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -40,15 +40,15 @@ properties:
 
   leds: true
 
-  realtek,clkout-disable:
+  realtek,aldps-enable:
     type: boolean
     description:
-      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
+      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
 
-  realtek,aldps-enable:
+  realtek,clkout-disable:
     type: boolean
     description:
-      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
+      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
   wakeup-source:
     type: boolean
-- 
2.53.0

