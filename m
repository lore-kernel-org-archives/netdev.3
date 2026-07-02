Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33953478E51
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983264; cv=none; b=ib0L0yhBsl7i2mp5EK3/2dvbvJ4mejRDiurD3wLak2Cpn+WJzuohDGPv9yv7SR/T+FT7IDAOXZ/+FihnGZvgHOv3p1jxO99BFVOyhCcjGpWeyXR22wePkR3E6/R39fnP1b6f4TDiTg/rjNN+K0xRS3K8EnyjQgahRi492BSN/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983264; c=relaxed/simple;
	bh=SXewiVuT//ReUsVnkrtZSc8fPGmn1OQXshl7TEPUxjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWpPAExoU9BSwdMUaE1bt3vUDsixaswUnzgj0odYS21HSyMRoKctB+uz8lFnrZT2zKX+/NgRZ56AaOekteeQ+VMK6S1LYylVkcgFvY38Xy+iEXL21FDROg1HPuaeDXPEGHhkRUW6s0YHIdd6aJtkD304E+1a8b8BKnVm5zb7YeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n4I0WDe6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n4I0WDe6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F3CB1C4FED5;
	Thu,  2 Jul 2026 09:07:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A83CD5FF03;
	Thu,  2 Jul 2026 09:07:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20AFA104C960F;
	Thu,  2 Jul 2026 11:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mPz0PGlj4JdjKtZi4aur+wFR8UC3TrILqJNKm4/S18w=;
	b=n4I0WDe6Em+rr7fuTqLf1wpvQfWNeixdsaFHDe9Xmfv3RYqgP1kX0/JnLph3cJNgYFsP3W
	353MJjv2TxALf/rsEbnr/H69JUvI3dQlcXekzFvrtlY79zQEb9bSEQ6q642WyIn9GXXCoB
	cAhHoiM9FAahCrS9vf9VBpqqa3hbhgCB+mA/M4e0cbpcQGtVu52BcWlaJECad/ub8t1rwQ
	dsGlKJrl8UztAke4MnqWUupBdYtIFjPyEUWHSYcPH6pG/6PL/7S3bOWZDer0kvUsCrLKZ7
	jZ4V7kcvAfNVlNgfPq13pmg+jNLit8HFUT0QhtU3yUyab0CnKoIC3GLRyZqCTA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:25 +0200
Subject: [PATCH net-next 03/10] net: dsa: microchip: make
 ksz_is_port_mac_global_usable() static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-3-93441e695fa4@bootlin.com>
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ksz_is_port_mac_global_usable() is exposed in ksz_common.h while it's
only used internally.

Make ksz_is_port_mac_global_usable() static.
Move its definition above its first call.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 56 +++++++++++++++++-----------------
 drivers/net/dsa/microchip/ksz_common.h |  1 -
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 686bdbfe8b6a..be7738ae1f2a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3670,6 +3670,34 @@ int ksz_handle_wake_reason(struct ksz_device *dev, int port)
 				pme_status);
 }
 
+/**
+ * ksz_is_port_mac_global_usable - Check if the MAC address on a given port
+ *                                 can be used as a global address.
+ * @ds: Pointer to the DSA switch structure.
+ * @port: The port number on which the MAC address is to be checked.
+ *
+ * This function examines the MAC address set on the specified port and
+ * determines if it can be used as a global address for the switch.
+ *
+ * Return: true if the port's MAC address can be used as a global address, false
+ * otherwise.
+ */
+static bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port)
+{
+	struct net_device *user = dsa_to_port(ds, port)->user;
+	const unsigned char *addr = user->dev_addr;
+	struct ksz_switch_macaddr *switch_macaddr;
+	struct ksz_device *dev = ds->priv;
+
+	ASSERT_RTNL();
+
+	switch_macaddr = dev->switch_macaddr;
+	if (switch_macaddr && !ether_addr_equal(switch_macaddr->addr, addr))
+		return false;
+
+	return true;
+}
+
 /**
  * ksz_get_wol - Get Wake-on-LAN settings for a specified port.
  * @ds: The dsa_switch structure.
@@ -3863,34 +3891,6 @@ int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-/**
- * ksz_is_port_mac_global_usable - Check if the MAC address on a given port
- *                                 can be used as a global address.
- * @ds: Pointer to the DSA switch structure.
- * @port: The port number on which the MAC address is to be checked.
- *
- * This function examines the MAC address set on the specified port and
- * determines if it can be used as a global address for the switch.
- *
- * Return: true if the port's MAC address can be used as a global address, false
- * otherwise.
- */
-bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port)
-{
-	struct net_device *user = dsa_to_port(ds, port)->user;
-	const unsigned char *addr = user->dev_addr;
-	struct ksz_switch_macaddr *switch_macaddr;
-	struct ksz_device *dev = ds->priv;
-
-	ASSERT_RTNL();
-
-	switch_macaddr = dev->switch_macaddr;
-	if (switch_macaddr && !ether_addr_equal(switch_macaddr->addr, addr))
-		return false;
-
-	return true;
-}
-
 /**
  * ksz_switch_macaddr_get - Program the switch's MAC address register.
  * @ds: DSA switch instance.
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index f276f2452684..f367d6f96fa2 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -393,7 +393,6 @@ int ksz_switch_resume(struct device *dev);
 void ksz_teardown(struct dsa_switch *ds);
 
 void ksz_init_mib_timer(struct ksz_device *dev);
-bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port);
 void ksz_r_mib_stats64(struct ksz_device *dev, int port);
 void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port);
 void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);

-- 
2.54.0

