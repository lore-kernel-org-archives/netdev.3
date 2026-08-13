Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4747FB1B
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627816; cv=none; b=aTtr6dSHnwybX+CQ9qn5p01wktdYGsVpxQ6fGvAPUEviBVjet/rx2Fzan8SIYYuf88CMpgoncSyBA97Vxoqj1IDkp6IcQZY3Y39klRwaPxah3yJK22Qo6+bD7nAdPMqyRkDGdHpG6bnAw8EIZsIXcgBZzGaIjWnJsXxwAgUdCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627816; c=relaxed/simple;
	bh=lq25oIu9+o+ffSjW1NcfTAHgbjcyHjlkGa5P9ei4HLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdN+ihfjWTdM3pgOEGjNjNK4iYGfWAgwEPvOdo9CUnGrFhpKk3Bf6sV4/RDtJGp2JPAce3beNxOHKLukU3eKj8J8bRKzTwRnB3dblma0Fg68y+tXwuY7jPo1qlao27M+ceeTaL/dgQuaxWMIIq70ufLRBT58Infn6CmP5W7J/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nnVPnsb+; arc=none smtp.client-ip=95.215.58.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nnVPnsb+"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lq25oIu9+o+ffSjW1NcfTAHgbjcyHjlkGa5P9ei4HLQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786627812; v=1; x=1787232612;
 b=nnVPnsb+04zYXDznLGHMi5p1vqZ6kx9rX+Hld+6JHhdcP+Cw6+mtlKo+RUijItf4mMdBOVXP
 rHuOKy3XV2TmuDvMEfG0Z0fphTdUKcQ7mwcwZJsEsMah/jYKJe4M+IOXHQ1R2xoELTXEdNIvze3
 zDX4u2w8SdkPeu33TbAFyf8w=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 025b893fb563e32c;
	Thu, 13 Aug 2026 13:30:12 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2 2/5] net: phy: unregister SFP upstream before port cleanup
Date: Thu, 13 Aug 2026 21:29:42 +0800
Message-ID: <20260813132946.116176-3-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
References: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
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
index c9976ffa7128c..9c7ed9c61e6d5 100644
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
-		goto out_ports;
+		goto out_reset;
 
 	phy_advertise_supported(phydev);
 
@@ -3791,9 +3822,7 @@ static int phy_probe(struct device *dev)
 		phy_led_triggers_unregister(phydev);
 
 out_ports:
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

