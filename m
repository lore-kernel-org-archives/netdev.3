Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FD3DD505;
	Tue, 26 May 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788875; cv=none; b=MnLFXwnE5/VnFh1ifZ1niKbBKvSlMMNn8Ra4f/bX2tiGpjVHuK5cZzHzundTv79W6zCRictLQ6xZvAaMUb7VqsYFopgoYNlCN4vHo9Nh2oavJqyFoLBGi7hBgsSFgiWqmLUxjjkLjuBFXAUCINVIG41Mbt12c2jZE+dELyaEGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788875; c=relaxed/simple;
	bh=a9/vrEBXQRpufAVt4JV1I3s8sy9rvKKOF9CiOIUxd6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYjwcJZM8q6+qBwceH/KeYKl01lOi2b0Qkyl0l1j/r3Zz0lkGRXdwWpWGM8bmf2ql1kVXql+hw8QZ+0XhAiSk5nrp5KdiPtijBahKRDRb5khSpckFnEuAJuC5gpW90esiqOszQwZLrQGqoii0OPwkhq6GxiNCKVb99vNP/dbC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aVEhiEJX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aVEhiEJX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D0356C79AB4;
	Tue, 26 May 2026 09:47:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8702B60732;
	Tue, 26 May 2026 09:47:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95E3010888590;
	Tue, 26 May 2026 11:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779788871; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=usnJdPNe1BK3Qj7++ffkt4Udbt3lsVQDDSepaOcUG/k=;
	b=aVEhiEJXvRJIaXyoMYWR9ILQlNHWhe9I0qLpxZerojOiq/pd/m+ZNPjYdsSpvsDLRxyWiT
	0SWUM7E9RmF2NKTjRAD1KOxzNd7imR3z8LkbuRlg5I62TwJWZnQMLIVtDlvo1649Twpg2k
	0NzIoOH2Crdg8fVPMy2HJjyZFWZTrPByNYVZcOw4s4c4ZkEzka2G4oOYo9yg6Jfycpy47Q
	usm38PswVHF0DfT4J3pnUCX6wNcaG8G6oXEU2Z34dq8WyfuuZZ+woJJqWWjyT7BpHZHrtn
	kRusyNUYsMlgtSEM3J5ycK2rHByMwnkl0HvK5pWkGpXCL0MhOlhPw75v7WINig==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 11:47:32 +0200
Subject: [PATCH net-next 6/9] net: dsa: microchip: implement .{get/set}_wol
 only if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-clean-ksz-3rd-v1-6-5b63e732149a@bootlin.com>
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
In-Reply-To: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

All the KSZ switches use common {get/set}_wol operations while only the
ksz9477 and the ksz87xx families really support it. These operations are
optional so there is no point implementing them to return -EOPNOTSUPP.

Remove the {get/set}_wol callbacks from the switch operations for the
ksz88xx, the ksz8463 and the lan937x families.
Remove the family check from the common {get/set}_wol implementation.

Note that is_ksz9477() is only true for the KSZ9477 so this change will
also add WoL support for the other switches using the
ksz9477_switch_ops. I checked their datasheet, they implement the same
PME_WOL registers, at the same addresses, so this should go fine.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 4 ----
 drivers/net/dsa/microchip/ksz_common.c   | 9 ++-------
 drivers/net/dsa/microchip/lan937x_main.c | 2 --
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index f297aa03f42a..38549dfdce7c 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2467,8 +2467,6 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz8_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
-	.get_wol		= ksz_get_wol,
-	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,
@@ -2580,8 +2578,6 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz8_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
-	.get_wol		= ksz_get_wol,
-	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 475886b8c255..2d0150b37a40 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3745,9 +3745,6 @@ void ksz_get_wol(struct dsa_switch *ds, int port,
 	u8 pme_ctrl;
 	int ret;
 
-	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
-		return;
-
 	if (!dev->wakeup_source)
 		return;
 
@@ -3798,9 +3795,6 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
-	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
-		return -EOPNOTSUPP;
-
 	if (!dev->wakeup_source)
 		return -EOPNOTSUPP;
 
@@ -3913,7 +3907,8 @@ int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 	 */
 	wol.wolopts = 0;
 
-	ksz_get_wol(ds, dp->index, &wol);
+	if (ds->ops->get_wol)
+		ds->ops->get_wol(ds, dp->index, &wol);
 	if (wol.wolopts & WAKE_MAGIC) {
 		dev_err(ds->dev,
 			"Cannot change MAC address on port %d with active Wake on Magic Packet\n",
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 4cbbcf7993c9..5e55f92fb0d4 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -905,8 +905,6 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= lan937x_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
-	.get_wol		= ksz_get_wol,
-	.set_wol		= ksz_set_wol,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
 	.get_ts_info		= ksz_get_ts_info,

-- 
2.54.0

