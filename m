Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794070888;
	b=uykfu6NXmgSt/08/HvqdxUQVrzEyHecSq6KGSlGATewd7qsA33+XcDyTnAW8UUpEKuSn
	 Y36b8pvGAl77bYQ6+JiXLbz4c5pvjDLD/xJXt6iqkteQwAYSf7jAuyZidZrEnJHs5IVZy
	 2wmk7M7LiUaTZUmj+iFIfC4jNN8FJC7I9qtUjApS2sAPkBnm9+oYty3y4+a6dJN0uz0he
	 Rfwrdqt/nD1wE9jeVxIPrgdTHzgv2mMWQkqNlBgZ1Vqu3pucGtZeaC/73cMvJ+Bwj9wYs
	 xozS0efEpqXWPxCAY9BW0LT0I9vMXFJwMKEwLbIq2T7py6uQRfd34ba1gid2/JQDhLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070888;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uzjNXgt46wd9zIfWGFy0z8XRbAiX3V0Ch45qLXmgn0M=;
	b=OfMBwzKXay9ynCib5CXopTaEr4gJw9T7g9+AnXXTJNOVocY05MvDe7cC7r3fLXzT1nQG
	 wYRhwzB7YuOSbRhk/uc/KAK1Prk1sXUhoE0mfLnqLjGYPBh4OZPQqHHz2sFd62MGTHQu7
	 b5MuX1A4KOO1teeCXFiq5EvJpJ5p7FBdc4G6DWrlib4cSgpryEOzYkRV6Yiys5JBkiag/
	 osAsk95KATlfqEPn68g53YXh003GHQFIVLb6gWFaso5HPcDQ6QMzP7yPGxhXFKMkPfgJP
	 aNgm63J7/4Kwv6gnlE75+Scp3y3jEEBn4U+tMQPYHioksZWTIlQQ4mKEJ6pspiqdyIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/LsD9Ap";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAB606A334;
	Sat,  7 Nov 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/LsD9Ap
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794070888;
	b=2mbS07L0TxB8pQwcZwmVxQwFyAySJFn7TS6tLqaWFuDg5MCOq5xojOG+JcWGlCF/vThO
	 oADY6Hh8ZsmzUqIPM1blW85hEuLDIYUffecJw3pBrA0uSKkoC6/BNZA9P/6G/BWALOsT7
	 Xmn1yb0MfvxivGZ6RIEofv5NSWOL6vLfuDS8QVRrC5x58UP3FQ3yzVfEndaKDYaDQzF//
	 2nyeWMILvMo0LoKd4Yj4FilLoPy6SDGrwFNfB48W0xKy5NluziCh7el9cJtKVZ7j8lfaK
	 0dGy5LuzX8ugo31bnxyzv2FymiH6YVbEjZ4EMQeT9rvc3ycVoPF3FzQigILFaPUtc3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794070888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uzjNXgt46wd9zIfWGFy0z8XRbAiX3V0Ch45qLXmgn0M=;
	b=S2neqICYnORdWQqVqv8wUsfNRA88Jv/9vXjumqgT3yq8OWmccI2MFaU8sNMECrlqmCS+
	 /3aUMtY7+rDWVLva2i+FKZmOHFXJx6YfT+2mRWjMHNhc09n/4g7tocQi1G4jbuzHDzOJl
	 A3VnnEDD5LbbDX3OJq2HMTF6AsDcUGShO7Tl5yWx/f/826eiutAAMzte2a1nfqmXDWw/u
	 JspKrOt3iEl8nWfx+gXc2XOGNdTknzeIURbywqo9HhnzXaMxnkeI8T8IJgHX5eYsl+WBB
	 l5IUV4VwW4alfmV6U+70BIfYpXgx4zjSYq20P71kLygO3ignZHM2+BsyZKTRnKc3kWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E2DB1F008A1;
	Sat,  7 Nov 2026 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070888;
	bh=uzjNXgt46wd9zIfWGFy0z8XRbAiX3V0Ch45qLXmgn0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=b/LsD9ApkIw8gH3eqvwVX3ndU+nDYPCTQEzfCJZYYnPtZSvRD1Q+teoLvbOWsnIsw
	 qwf896np5c2vBLkZvhOgq4fNicOKKA/m+tSp0zXq/6tMAL/LkZ5hr2f4eSZZ0OvtBu
	 5gIh1VqwlxRPNyIEhe15hN/r2HTfYbDoOiFNx4mOOHzWBqYDE7fB0+YdjrqVTa6XJz
	 DBHYRCsdPHIFJ3Vq5uflc9QMs9STt+rlc8+dMkU4e+DB97I4qqu2rD6ImJqedwdEK/
	 PLKe/3zViueWsAEp8BJV93SlM8Vx3mv89/egL8+fqCLZHoPL8qmJqkd5Iq+Z4JHlXR
	 mO5mVWDCBRlUA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8314347C86;
	Sat,  7 Nov 2026 17:01:26 +0000 (UTC)
From: Hleb Shauchenka via B4 Relay <devnull+me.marleb.org@kernel.org>
Date: Sat, 07 Nov 2026 18:00:45 +0100
Subject: [PATCH net-next v2 1/3] dt-bindings: net: ethernet-phy: add
 property #thermal-sensor-cells
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
Message-Id: <20261107-realtek-hwmon-tz-v2-1-6b9a69d44470@marleb.org>
References: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
In-Reply-To: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hleb Shauchenka <me@marleb.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=me@marleb.org;
 h=from:subject:message-id;
 bh=VRuFxemFp//Th1i9H61fWbV1u2h1anUlOxoYWqWx9q0=;
 b=owJ4nJvAy8zAJTZJnM368y8lXsbTakkMWe8jU1vCJM7/avVac2vXYu5HlrZ79kdtD3cWWFmz8
 LDbsbav/T4dpSwMYlwMsmKKLJuai0Sfrox+61q9JwtmDisTyBAGLk4BmIjvHUaGrZvXHbo7iUX1
 +dPNhrZzD4s9NW/csG6zxL/Wt18fXWpj9mL4w8/16nh+7c1XC1fqBbrLVt815mT2lNnPf6xuy3f
 RxT7XuQGD2ktR
X-Developer-Key: i=me@marleb.org; a=openpgp;
 fpr=B2837215E5A95BED457BBC6A9217063BF3FA220D
X-Endpoint-Received: by B4 Relay for me@marleb.org/default with
 auth_id=1394
X-Original-From: Hleb Shauchenka <me@marleb.org>
Reply-To: me@marleb.org
Content-Transfer-Encoding: 7bit

From: Hleb Shauchenka <me@marleb.org>

The Aquantia and Marvell PHY drivers register their hwmon temperature
sensor with the thermal framework, and a following patch does the same
for Realtek PHYs, so a thermal zone can reference the PHY node through
thermal-sensors. That requires #thermal-sensor-cells in the PHY node,
which no PHY binding allows: dtbs_check rejects it under MDIO buses
whose PHY children use unevaluatedProperties: false, such as
realtek,rtl9301-mdio.

Allow it in the common PHY binding.

This patch was prepared with AI assistance (Claude Opus 5.5), after an
AI review of the previous posting pointed out the missing property.

Signed-off-by: Hleb Shauchenka <me@marleb.org>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index df50c4c33..e2e9e615f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -269,6 +269,12 @@ properties:
       have to be placed on board. When omitted, the PHYs default will be left as
       is.
 
+  '#thermal-sensor-cells':
+    const: 0
+    description:
+      Present when the PHY has a temperature sensor that thermal zones can
+      reference.
+
   marvell,reg-init:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     deprecated: true

-- 
2.56.0


