Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCA39B4A6
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119384; cv=none; b=Xh3ZjHR3CDVnkeCc8h4GLdvyPE1cMoyVisM5KgjKUUf+WpgXRQ5Z41I45rGiHIb8zrRcvyvgDgcZ2qnrAZ8ybO5K+3W9XqVqghufqg0jJqU+Gyg4KYnrNVsxmaT8dAXdJaTfc4N5rUjOB/naNXItllpOYlMNJtvTibPjfg47w4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119384; c=relaxed/simple;
	bh=/hlDrhU2v9TGXsg6MNSxhtxz8k/cV1tZgnyIOxl3bkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGUSVB0wV8QGUEfAPzt/q9rUvQKi2lp+GI8MT/KigIH/WdxbwGcl3djaM9sf26l2non9i1s9ojyWGeaOCu3CO8zJ7WvSwCPqmjRuhbpbZ0ih0cbWIovA6W6dXumkyzIJB9Kd+4HxFQ6K5CRqK/yZhxfx92QpX1ELNlf+yaDYgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLFYp7mF; arc=none smtp.client-ip=91.218.175.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLFYp7mF"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/hlDrhU2v9TGXsg6MNSxhtxz8k/cV1tZgnyIOxl3bkI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787119381; v=1; x=1787724181;
 b=CLFYp7mFhAq91QiJQluO2rP6VRfA6gLbII3ss+iZjBtMaiCaxxn/jok8bLF6Z7brUZwT6qZ7
 mxMs6ZeLQtagaibb2+rxbyPmofw/C5EBTKPxXm+n9UsEGDtd3oXQ9ul8haU3zYGSxes/Hc9ao9q
 hHesnT5VIL8ofX0/1Cu5pJSw=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 88d3608cbd2aacfa;
	Wed, 19 Aug 2026 06:03:01 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v3 2/5] net: phy: unregister SFP upstream before port cleanup
Date: Wed, 19 Aug 2026 14:02:33 +0800
Message-ID: <20260819060236.24665-3-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Commit 4497f5028675 ("net: phy: Clean the phy_ports after unregistering
the downstream SFP bus") established that an SFP upstream must be
unregistered before its phy_ports are destroyed because SFP callbacks
may access these ports.

phy_setup_ports() does not follow this order when a later port setup
step fails after phy_sfp_probe() succeeds. It destroys the SFP phy_port
and leaves phy_probe() to unregister the upstream later, creating a race
between port destruction and SFP upstream callbacks.

The error unwind is also split across three functions. If
phy_setup_sfp_port() fails, phy_sfp_probe() leaves the upstream
registered and relies on phy_probe() to remove it after
phy_setup_ports() returns.

Make each layer unwind the resources it successfully set up. Unregister
only the upstream in phy_sfp_probe() when SFP port setup fails, since
the failed port has already been destroyed. Add phy_sfp_release() for a
successful SFP probe, and make phy_setup_ports() use it before cleaning
up the remaining ports. Once phy_setup_ports() has rolled back all port
setup, make phy_probe() skip this cleanup.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 59ee5a76af2ba..538e9ca44d093 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1723,12 +1723,41 @@ static int phy_sfp_probe(struct phy_device *phydev)
 			phydev->sfp_bus = NULL;
 	}
 
-	if (!ret && phydev->sfp_bus)
+	if (!ret && phydev->sfp_bus) {
 		ret = phy_setup_sfp_port(phydev);
+		if (ret) {
+			sfp_bus_del_upstream(phydev->sfp_bus);
+			phydev->sfp_bus = NULL;
+		}
+	}
 
 	return ret;
 }
 
+/**
+ * phy_sfp_release - release resources set up by phy_sfp_probe()
+ * @phydev: the PHY device
+ *
+ * Release the SFP resources set up by a successful phy_sfp_probe(). Unregister
+ * the upstream before destroying its phy_port, so SFP upstream callbacks cannot
+ * race with port destruction.
+ */
+static void phy_sfp_release(struct phy_device *phydev)
+{
+	struct phy_port *port, *tmp;
+
+	sfp_bus_del_upstream(phydev->sfp_bus);
+	phydev->sfp_bus = NULL;
+
+	list_for_each_entry_safe(port, tmp, &phydev->ports, head) {
+		if (!port->is_sfp)
+			continue;
+
+		phy_del_port(phydev, port);
+		phy_port_destroy(port);
+	}
+}
+
 static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
 {
 	return phydrv->config_intr && phydrv->handle_interrupt;
@@ -3522,13 +3551,13 @@ static int phy_setup_ports(struct phy_device *phydev)
 	if (!phydev->is_genphy_driven) {
 		ret = phy_sfp_probe(phydev);
 		if (ret)
-			goto out;
+			goto err_ports;
 	}
 
 	if (phydev->n_ports < phydev->max_n_ports) {
 		ret = phy_default_setup_single_port(phydev);
 		if (ret)
-			goto out;
+			goto err_sfp;
 	}
 
 	linkmode_zero(ports_supported);
@@ -3555,7 +3584,9 @@ static int phy_setup_ports(struct phy_device *phydev)
 
 	return 0;
 
-out:
+err_sfp:
+	phy_sfp_release(phydev);
+err_ports:
 	phy_cleanup_ports(phydev);
 	return ret;
 }
@@ -3719,7 +3750,7 @@ static int phy_probe(struct device *dev)
 
 	err = phy_setup_ports(phydev);
 	if (err)
-		goto out_sfp_release;
+		goto out_reset;
 
 	phy_advertise_supported(phydev);
 
@@ -3791,9 +3822,7 @@ static int phy_probe(struct device *dev)
 		phy_led_triggers_unregister(phydev);
 
 out_sfp_release:
-	sfp_bus_del_upstream(phydev->sfp_bus);
-	phydev->sfp_bus = NULL;
-
+	phy_sfp_release(phydev);
 	phy_cleanup_ports(phydev);
 
 out_reset:
@@ -3817,9 +3846,7 @@ static int phy_remove(struct device *dev)
 
 	phydev->state = PHY_DOWN;
 
-	sfp_bus_del_upstream(phydev->sfp_bus);
-	phydev->sfp_bus = NULL;
-
+	phy_sfp_release(phydev);
 	phy_cleanup_ports(phydev);
 
 	if (phydev->drv && phydev->drv->remove)
-- 
2.43.0

