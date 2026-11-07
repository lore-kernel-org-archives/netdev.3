Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794070889;
	b=YvFWOeLY6BU76ACPQnBjim7V/yJQBQGnlz9VoStN8/hDg95KHp0ibP+JrPz/m5gJgTG5
	 1CwbFkP6Og00pgAM0HSFtK3UHOH/EGLA8BHaNF1iAJwZGPPRF5WR7TS7gTdC/TP+ayutS
	 9oxBb2Vyw54MO+kM0hf1wD+/YlT65Va0kVoh4fFE8vxKTTFfCsPXEqN2vqhDiI/nD+BY0
	 FSYLgzLrzH54D1ELMzqG89azn8p0tlc2IvILH+fT3/EzWYh31hHxSFZDex/b7JDL1o4Lb
	 fiYctqnW6M6wSEmZq3vCXEt9r0LisKrdmSr6ZmghQ9wy1uR774x+OZ6+sPeUbWjXniA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=obYO6TFy1Ty23KbAzYDL7ZaQNHsENqMf56bYIzds5Mc=;
	b=1xeq2Z0QSh81M61SaEpg9JBgttHF/n0oBZaBr+suYTUwX5zHu1jTMEb/GTo/JBDU1NK6
	 TfNAG59T55+oxudGNbkBoGQrMZB1BSC0Q6ON75GBDVlGJr6o4TpNeK5wYjofdk6PIKzPA
	 uOcvBYnfJ2ilEpGNsgpdOD84s41XhbmwfsvWf8TeC9clW6GI7U6o98ha9ZVXKCr5r34wz
	 X34Oj5dM/yGcfw+tYA4jcEwpB2EiDFrIBNlGfDiKQ9s3zO+iIPjZdb4/bMXe7mgkAECHJ
	 BdjxndGj4fLF6Ym4HcihDHa3jY6LzSG/kHoHIc4XCSsRCnXN+ZSN1wLPyI/tE7vyClg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bgzshof9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF5606A33C;
	Sat,  7 Nov 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bgzshof9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794070888;
	b=wHnpAyrHMvVvg//kvPUUjIJp6YVurK2qKXOcL6TXCnbdF+bhG7J2pyADyEg78Y8Kt3oW
	 tCmpB+i1ZCkihrM+yU/RQo9XcGNwR3YA7IKMgtHbHTtojO3cVBFzgE9fFXffpT3ozWBve
	 mJjqdtsq5H4hcLP8KC3OFUY4URoj7NaJHxbRMQ1hEZKLfksIs54wShQy3YyZYR4BWGwWI
	 FSUZ73KgyH6EsbvgLIs0gb9DfBzPi08ReSrPwbweeJUjD0uRunQP1Tgce4cZJz2xMR6rS
	 TjTgkso249zGjCxZwmDZXb/yCHpIFDzrKD9BpA885rGiP1VXoE/Dnhu7lVTbIxernaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794070888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=obYO6TFy1Ty23KbAzYDL7ZaQNHsENqMf56bYIzds5Mc=;
	b=j1IDth/60nvKb9mgOn7nQ2qf5+jSFSEM0bLbY0LuW/kQZ/pYtJePvK/tbu7/cfPFzFZF
	 YqttWgDxaaEh1V1rwbvrgB8WFiUB9sgN51W80igBh6VjuZB8kXWM3/3vLcunQDjinMRJ/
	 W416Bmr8N3xOwdqECzuMGe5xXKTLA3Z5B1tnp95bKNxj9Gk8c6KA+O/K2BqrgT60qF3Cn
	 VS7u9VWLRq8VSJDxSWZMcNpSl4P1t0b43HeK5esemjSEuMICdMCNiKWDcQO2vrFRFS5Up
	 /b/DY7Cw2f1mHX2RGGRsfJZ7sy9oiicQ0Ns5F/CGm3tMICivtOKbic2cR+YA+n0/zBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1EF0D1F008A3;
	Sat,  7 Nov 2026 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070888;
	bh=obYO6TFy1Ty23KbAzYDL7ZaQNHsENqMf56bYIzds5Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Bgzshof9+nBRozgIlpJYY3cINh1JkrLUyMQUpPK16bIRIzAqbqvZMHe4uaJJHMRU9
	 4TL09h1nQDtiud7JfqkHq5fjwJmaPNwn2/4LwhXJ8Dl0VwQwbfhK7fNETcomE0P5LB
	 0C9F4U6QHtHWWRLJWVzLlwDV+uUBBrNmKl9edpvTOXyM+MVnP4pqJuuU8+D4+Mo7Jd
	 sZQmjwqkQWam6LbUXwBgqaRe32UAiBkaLRV0b6F+zCmUGN7sLPqRTkNIe+02QFP0TU
	 QEBX7lksfsHdd/itwjM0jYuw9HzGs1Ab9vEZArsiLQRW8nns7EuOxO/h5ssuaRVpSh
	 4T4hB8GPAGxEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 93C4347C8D;
	Sat,  7 Nov 2026 17:01:26 +0000 (UTC)
From: Hleb Shauchenka via B4 Relay <devnull+me.marleb.org@kernel.org>
Date: Sat, 07 Nov 2026 18:00:46 +0100
Subject: [PATCH net-next v2 2/3] net: phy: realtek: return MDIO read errors
 from hwmon
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
Message-Id: <20261107-realtek-hwmon-tz-v2-2-6b9a69d44470@marleb.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=me@marleb.org;
 h=from:subject:message-id;
 bh=6gM5E4J0rm2zZGPKen73mZQlszekR/xfc4TyxcghaYg=;
 b=owJ4nJvAy8zAJTZJnM368y8lXsbTakkMWe8jUxXnvfZNqxCsenZs1ZQEq0JH59TA2bLLrKfvj
 lP9mbgo6lVHKQuDGBeDrJgiy6bmItGnK6PfulbvyYKZw8oEMoSBi1MAJtK+mJFh1UTJyj1FoSKu
 u56KRQaof1vyPzbxVr7cLuUHK6qOzLz8g+F/bEjTtIcF3yuVZ1m0HxFlnPGp8wDbkWbNNTu4265
 OdvvDDgBC6UmZ
X-Developer-Key: i=me@marleb.org; a=openpgp;
 fpr=B2837215E5A95BED457BBC6A9217063BF3FA220D
X-Endpoint-Received: by B4 Relay for me@marleb.org/default with
 auth_id=1394
X-Original-From: Hleb Shauchenka <me@marleb.org>
Reply-To: me@marleb.org
Content-Transfer-Encoding: 7bit

From: Hleb Shauchenka <me@marleb.org>

rtl822x_hwmon_read() masks or shifts the value returned by
phy_read_mmd() without checking it and returns success, so a failed
MDIO read is reported as a temperature: -EIO reads as -2.5 C and
-ETIMEDOUT as -55 C.

Return the error instead. Once the sensor feeds a thermal zone, the
thermal core then keeps its previous state rather than acting on a
bogus reading.

The problem was found by an AI review of the previous posting, and
this patch was prepared with AI assistance (Claude Opus 5.5). It is
build-tested only: I could not provoke a failed MDIO read on hardware.

Fixes: 33700ca45b7d ("net: phy: realtek: add hwmon support for temp sensor on RTL822x")
Signed-off-by: Hleb Shauchenka <me@marleb.org>
---
 drivers/net/phy/realtek/realtek_hwmon.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
index ac96e2d1e..b6b2806e2 100644
--- a/drivers/net/phy/realtek/realtek_hwmon.c
+++ b/drivers/net/phy/realtek/realtek_hwmon.c
@@ -30,13 +30,17 @@ static int rtl822x_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 
 	switch (attr) {
 	case hwmon_temp_input:
-		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSRR) & 0x3ff;
-		*val = rtl822x_hwmon_get_temp(raw);
+		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSRR);
+		if (raw < 0)
+			return raw;
+		*val = rtl822x_hwmon_get_temp(raw & 0x3ff);
 		break;
 	case hwmon_temp_max:
 		/* Chip reduces speed to 1G if threshold is exceeded */
-		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSSR) >> 6;
-		*val = rtl822x_hwmon_get_temp(raw);
+		raw = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_TSSR);
+		if (raw < 0)
+			return raw;
+		*val = rtl822x_hwmon_get_temp(raw >> 6);
 		break;
 	default:
 		return -EINVAL;

-- 
2.56.0


