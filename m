Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2264F3EC4
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569164; cv=none; b=nUvh9/cG0xAsCjUeuPE7KVfPIE/Fwzi7PQxmKBJMXi4Cxic2phznXFWBL1UiBCsaEnVJsvi4uQt1nerMSI8VWZ4shR8vjWf2JiQrcQNejuBs+3mMMzMNwxTND/E7mFC7wMuEhkcdqOeIcnJNrCfIZ7EGoi57E3r8puSIgOGdxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569164; c=relaxed/simple;
	bh=Lc316qFGUW8/HqzEomGqw4fI97ObQskjDRWcXxlWakg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWRUe3PRpI7rLrfscKXwe0R334MAOeyc+cP3vVQtCbeHjPXng/oiWrAwQWzdC785vVanPz3GfzDJvrdM9CB6LCUAQBvi6DZsrONhoxmgrwyKG13Ex8k8ZuOLVQOAdfeYlVEhzLOkb3KurdfbMzLRdHG/lnjlLRWSg3EiW8NiN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=H1Pw1dhV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="H1Pw1dhV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a168355946so1718925e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1791569160; x=1792173960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+uN4SzsXGoz881YVEUDcFr/xufMBW/3mKMr+K+qX04E=;
        b=H1Pw1dhVUsTWN8sVf6CrdwtMf7vO1vypYVzRkh0sM5QnA7Sw6HkigNCmvOJLgqYvIT
         e1iMu+S7D7krP3XP3P9xwThQrFMBQn/WCry1gB8A9n6UqryheAhGpAoEQidGHpIOHYzZ
         qccTu4L2mMsdX2kj/9YHem7MXk5Hh29pg7V0gk6QpTvrDLCYU+GqqnhNMR8q0bh9Vysh
         oP/kJVOh3b/lu3lsmyuBVXYZ+hB2Yc7+ZKArMOeOJV8A4DKnFSKuQPBGDtsCMNJi79pO
         NoLRGk+fYRrMputt2Jem43Q2yH2vDl6z4V4X57OWizqZ1+HvU6R3YDiVBLG9kpsUopid
         HGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569160; x=1792173960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+uN4SzsXGoz881YVEUDcFr/xufMBW/3mKMr+K+qX04E=;
        b=pwZHVLBu7xh9EWrRpxAa3s+67cF/tARMpOK26LHvcjtTqjFDUT2w/KDBx/1ttCcnZ7
         ZcbpQ94a3IHpLE/krX3oGcQAjzH5osRRN4fO9sXrcpjlRs74QD/VdbJcLgL/5JT8EmSx
         DnlBVxP06ZKm/zUFAvp0VgbYJdJoPWsvs5wDM1+TMl8cZrybqIZQkrO6s/fkCt+YycJn
         SCif8e4j0VPoN1T/6/I+8FgMUvbYpiJesXc15Bb/5nwUEnoK/h/QTKKBmgFIfHSgvWcU
         FWLnoXxlL6DiFEbuK+O2rsm0c9T6R/ohViCz7HgwS9Wsm9Fr8IcOOR6Rh+sUUv36nTe+
         bQfg==
X-Forwarded-Encrypted: i=1; AKwUvBxvy56WP8EnJEHnJKq31wDTcnm9qmTB3VlFWlfKQM/jb7pQc3r/Sso8nopXPTvEGtLb45kMVC4=@vger.kernel.org
X-Gm-Message-State: AFuF++kH90DLgCDtCGC5/EqC3qxcUVN5S7RjPi1t0xvTTOTxcsXkyagu
	KwssEH8b7KfDPhBF0jmwjbQBDrTlpmTGowrrZ3sN2TGIpak29roiCGLlhPEQB2gjT5w=
X-Gm-Gg: AYBFou3RJ66FkMMaQw0k0RcYOFkVjBBcYyKfAeBFmXbbty2nW2DpTd8bWrSVemNPdsy
	3AqmvNOkXOQ8Ya/OWNgICpodx402w4ZXplJjiQw7f041+Cag//p79CASBKHxnYEfJmjlqh4/PWW
	SkvcUorXANcVR58d+sX2qNTJbQkAi4VN9WbP+ftbnJs6sNG2/4nV6BTdeRNkA7EcPkT8QIyJJqT
	9ya1f0mhtqRgb6DGn/3mojiGuvuVJFU+d1Oym6P0kMXldnRFnvWiBWVMD0R+co0MPcZGVVwzV/O
	2X4u9EkmFGnb9IpiHyXJYx0YWfCtBE+2p3HGxAfsRbzVPRyZJdKxCv09vb+ROb1T3lW12RazP2i
	Cf4495K5qBDH9dQkkEooSJPoWlWOKhE+GVPcXOjF0rWl+7V1lNDVIsxGFuXvY1Quw0SLXRSxieq
	Bf6u1hmNUHYy0w1oMSds77tdLkPzbqaV+3xkDslq4U3VoDyyPtaA==
X-Received: by 2002:a05:600c:6297:b0:4a0:62d:4424 with SMTP id 5b1f17b1804b1-4a18e4a1756mr50175605e9.8.1791569160480;
        Fri, 09 Oct 2026 11:06:00 -0700 (PDT)
Received: from remote-01 ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm118184915e9.8.2026.10.09.11.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:06:00 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v5 2/4] net: phy: put the driver module the attach took
Date: Fri,  9 Oct 2026 21:05:48 +0300
Message-ID: <20261009180551.1234107-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009180551.1234107-1-f@lex.la>
References: <20261009180551.1234107-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_attach_direct() pins the PHY driver module through d->driver, and
phy_detach() releases it by reading d->driver again. Unbinding the PHY
driver while the PHY is attached clears that pointer, so a detach that
runs while the driver is still unbound skips the put and the module can
no longer be unloaded; if a different driver binds in between, the put
lands on a module that was never pinned. The NULL test added by
commit c2b727df7caa ("net: phy: Avoid NPD upon phy_detach() when driver
is unbound") avoids the oops but skips the put.

Found by reading phy_detach() while chasing a PHY driver unbind race on
a Keenetic KN-1012 (MT7981, air_en8811h built as a module). The leak
itself was not observed there: unbinding air_en8811h under the attached
lan4 DSA port and then unbinding the switch faults earlier on that
board, in phy_free_interrupt() or under phy_stop(), before
phy_detach() gets to the put.

Remember which module was pinned and release that one.

Fixes: cafe8df8b9bc ("net: phy: Fix lack of reference count on PHY driver")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v5:
- The driver module is read once, so the module pinned and the module
  recorded cannot differ.
- Rebased on net-next: the failed generic bind unwind keeps the
  interrupt restore it got there.
- On its own, this patch can still leak a reference when one consumer
  attaches while another detaches the same PHY. Patch 3 closes that.

 drivers/net/phy/phy_device.c | 12 ++++++++----
 include/linux/phy.h          |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6bc9cdb7fa69..68691c487eee 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1728,8 +1728,8 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
 	phydev->phy_link_change = NULL;
 	phydev->phylink = NULL;
 
-	if (phydev->mdio.dev.driver)
-		module_put(phydev->mdio.dev.driver->owner);
+	module_put(phydev->drv_owner);
+	phydev->drv_owner = NULL;
 
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
@@ -1794,6 +1794,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct device *d = &phydev->mdio.dev;
 	struct module *ndev_owner = NULL;
+	struct module *drv_owner;
 	int irq = phydev->irq;
 	int err;
 
@@ -1830,11 +1831,13 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		phydev->is_genphy_driven = 1;
 	}
 
-	if (!try_module_get(d->driver->owner)) {
+	drv_owner = d->driver->owner;
+	if (!try_module_get(drv_owner)) {
 		phydev_err(phydev, "failed to get the device driver module\n");
 		err = -EIO;
 		goto error_put_device;
 	}
+	phydev->drv_owner = drv_owner;
 
 	if (phydev->is_genphy_driven) {
 		err = d->driver->probe(d);
@@ -1942,7 +1945,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	return err;
 
 error_module_put:
-	module_put(d->driver->owner);
+	module_put(phydev->drv_owner);
+	phydev->drv_owner = NULL;
 	phydev->irq = irq;
 	phydev->is_genphy_driven = 0;
 	d->driver = NULL;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6c..a5a419bc400e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -578,6 +578,7 @@ struct phy_oatc14_sqi_capability {
  *
  * @mdio: MDIO bus this PHY is on
  * @drv: Pointer to the driver for this PHY instance
+ * @drv_owner: Driver module phy_attach_direct() took a reference on
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
  * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
@@ -689,6 +690,7 @@ struct phy_device {
 	/* Information about the PHY type */
 	/* And management functions */
 	const struct phy_driver *drv;
+	struct module *drv_owner;
 
 	struct device_link *devlink;
 
-- 
2.53.0

