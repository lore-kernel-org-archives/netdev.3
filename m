Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589174;
	b=W5koCU8RKIaT1ttHV4JBiGRUwT2YMk638b2eDocC7bjNX16Jxhu3/Y3wQ85O6lzOwO04
	 y9yUS4wq/cLR6rYgmaMDK3QTM6eOw5kOzlLRxNbgZHbz1EV7VdNXAfx8jk2UzeMh5x8hS
	 4bWPaV/jFSq/+MHW97SidWFLOOBfI0HwaqlfoGXa1VclIUAQs2h8pMSSFycaoEvFXffxY
	 MC8XgTtI8XJLM7D+arL9eIpGZr2GgHS+6+Ueqm1FqO91+P78MJzaMGc9XEw76NIWKO6lG
	 RHC1nuu5Om0Di1DRRaE/M++UnavmSqfVqZ0gJL6hNqGtDNfcBCtZTi/BF0yQBh2d+Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589174;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jmOffP14quhOszj41G3AzG2mASrLh6OsTCTzGgE5dqE=;
	b=BGEJW1i0OOzG/lRkFD8XaWcgeRru4YXFLLZ5jv8jiebKXZqZDgheQaIwcI69AfuGk1yB
	 YtHU8ahuvYjl2jSCD3WYy/zQ8tF0nrCiUxAK+beV5S/6SYouyBSQaspXStjfU1j6RpcE0
	 bTm7ChZCqQ4SEI7QxlHxTZokj14Zz1zYPoHG4ZBVyC7ezjj8FKS0PRaFjS9N4hcenBOz0
	 7DtxLWfKv5xMtlBpA5zkwycjXlsYeW3kJ7xX7Q+A40nrxY9mkNMqdppyB2OPf7sId1Nf3
	 JeRj2TKGaN6qAEVoi3dbqnrV3QZAI30Y/3J9VUsbKZMNpyF7T51SNiIz6LFFmtX7UEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+3w+jUI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16160A263A;
	Fri, 13 Nov 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+3w+jUI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589174;
	b=f8LDIUhVYEVnYHNqbD/d6l/rSjdiBu/RRImpddP41pl21q5LjBI5oQFLqd79v2IFPVbB
	 bJBqvVPOFKLTN9jUhlbDHOnCpl3v9NS70RC8mwkbClRSLzksMKKzCIYE00GZxss/Whges
	 XwZ41keQW4a0bOso644e9L95QYk0ZPAWGdhHYM9OdJJE0twPq1jNoDkTbJ1rYABUQdnYG
	 Gasm+TEHqJJ7ukf21Jr0ZzifCSiwzVOYkg1WxfN6q7/oVlUzKk+6hEFDmr8OzkO2FM+ZV
	 eHVmwgxu+FyKlIIBFGPwCEI/w6ujO/0MhuVSe1PlSqN3rvwDyRWK5AMDqINux6yiLGA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589174;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jmOffP14quhOszj41G3AzG2mASrLh6OsTCTzGgE5dqE=;
	b=EzpRd48E0ycbkIymWca1Lw1bGIvZCW99qwca1kNwi7u8R5VBl20LLkm3g83lkScuNihP
	 7Gx161trVscu5kCWr9pR9RvpH1ZPbDp5ICFXmav9QJe1JT+RShwNwwWMndv5DYAgZB22i
	 7dseDZTZCzBho/JGj4Fs69U/maFrcf61+eEm9AM/looRTh344vz2bbrRqXDdh3ZSH8xtz
	 qjAVTDlXFut/bSrbjatlssbMK3xJog4DHEaOLSon+WP6roBwtp8UmViCO/hFzUToelsxM
	 /TNoYKOUb6QMTuEm64SzJ28jVDxkg5OyF6I5oMlFmUUjro0Gy7tXPvUzBsydIN23rLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 382FB1F00933;
	Fri, 13 Nov 2026 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589174;
	bh=jmOffP14quhOszj41G3AzG2mASrLh6OsTCTzGgE5dqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k+3w+jUIgqe5oWWGsx7FPvb4LDlFJ4Sdkzud2RkJ0v0sNnJuRJwPmQIPltd2arD2D
	 njTWxMVkdvpH73dDSJh0+tBM8iiLSBb1QlG51jvBw7WyZPRK3gz5lgPIqMHn3XHPwN
	 TH4/Uxq8+SBBe3buiLu0QXUHB8PApHYArcamFIk0xgsp5Xm0hYpF2EbpO0687WVYq9
	 4XZsDCruowzSo9sBKZvJ7QjFd/Lg+cnR6N8jLvyUBuItnj1oWoFtCUey4zbpTWKYng
	 iQF5d7hu4eBcQFnzNQYUdusO/LghIOaXRqCsBIMKQk8q7ebEoxeeNh1jM7rAtuh5JC
	 pJhCtrY7k8S1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EF92449A3B;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:31 -0800
Subject: [PATCH net-next v11 12/14] net: phy: Add helper to modify only the
 PHY loopback bit
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
Message-Id: <20261113-s2500-mac-phy-support-v11-12-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=3182;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=RL9y6WXjC9i9YRoszTZLdBOdvmvDtwuoqd7Nc6APYAs=;
 b=vhcPPLPGLnOLAbG/2RLBr399qiYitV4Uuj8Y4vvGmYyJR4fTQePPlEQSoFQ/73ZPHLe7aGvSZ
 u+vJRyu9PhxDOGXqaTKgSkf9Rr2b5qzpT4yVZ/8vpHGc+rFtblebrXc
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add a generic helper function, genphy_loopback_no_speed(), to modify
the loopback bit of the PHY only, without setting the speed. This will
help the PHY drivers, like 10BASE-T1S or any other PHYs that want to
handle the loopback bit only.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Made the changes to phy core into a separate patch. Previously
    changes were in a patch that also had vendor code changes.
  - Documentation in the comments section is made accurate.
changes in v10
  - No change
changes in v9
  - replaced "fixed_speed" with "no_speed" for the API.
  - Improved the comments to be specific about not setting the
    speed.
changes in v8
  - No code change. Changes were in two different patches.
    Merged into one.
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - Moved the onsemi implementation to a new, genphy API to
    make it vendor agnostic.
changes in v3
  - Added loopback functionality for onsemi's PHY driver
  - First patch
---
 drivers/net/phy/phy_device.c | 24 ++++++++++++++++++++++++
 include/linux/phy.h          |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b39e945cebd7..80d93bb43312 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2923,6 +2923,30 @@ int genphy_resume(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_resume);
 
+/**
+ * genphy_loopback_no_speed - Enable or disable PHY loopback, speed unchanged
+ * @phydev: The phy_device struct
+ * @enable: Flag to enable or disable the PHY level loopback.
+ * @speed: Speed setting. Not supported: -EOPNOTSUPP is returned if it is
+ *         non-zero when enabling loopback. Ignored when disabling.
+ *
+ * Description: Only BMCR_LOOPBACK is modified. It fails with -EOPNOTSUPP if
+ * @speed is non-zero when enabling loopback, or with the error from the
+ * BMCR access.
+ *
+ * Returns: 0 if successful, negative error code on failure.
+ */
+int genphy_loopback_no_speed(struct phy_device *phydev, bool enable,
+			     int speed)
+{
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
+			  enable ? BMCR_LOOPBACK : 0);
+}
+EXPORT_SYMBOL(genphy_loopback_no_speed);
+
 int genphy_loopback(struct phy_device *phydev, bool enable, int speed)
 {
 	if (enable) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b17..6e57f83757bb 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2317,6 +2317,8 @@ int genphy_read_status(struct phy_device *phydev);
 int genphy_read_master_slave(struct phy_device *phydev);
 int genphy_suspend(struct phy_device *phydev);
 int genphy_resume(struct phy_device *phydev);
+int genphy_loopback_no_speed(struct phy_device *phydev, bool enable,
+			     int speed);
 int genphy_loopback(struct phy_device *phydev, bool enable, int speed);
 int genphy_soft_reset(struct phy_device *phydev);
 irqreturn_t genphy_handle_interrupt_no_ack(struct phy_device *phydev);

-- 
2.43.0


