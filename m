Received: from mta1.migadu.com (out-244.mta1.migadu.com [95.215.58.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560413F4106
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371352; cv=none; b=YabiP5Nv1AaABG6csAF9bnIuRLlTxgYvED5onksrEA1QZ2Dk2E5Bcb1tINf50rfDIiHgDL4Iymz+kbg6St2mETkDlWQ8hb+Bi8CMIzwu4ds5nk4fhhvsbZIQ+FLQwAM8huxvbE0E0+/VFDjkpP3cA+zPqR92+nFhc4Kndf4/7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371352; c=relaxed/simple;
	bh=ff4LuV6jHqcdhp0XotpOVpYLtl8eBcAQM+iD7p+pNgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHtRDQ1IPMlXW/Zx4wZu0OyIWoBCvH3JC1R0j6UC/TH3nbLa2icd6l6eyrZT38MBaBggZaw407JMEa1BquNhneRehQWvCVt9m7YsZ5JInTLUAp5Zna9d9DNoLRs9LQKZmU1U20BWUMLm0VTIauMuWU6kpb8ep6pEoM4FbYRKW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xPOrofuG; arc=none smtp.client-ip=95.215.58.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xPOrofuG"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ff4LuV6jHqcdhp0XotpOVpYLtl8eBcAQM+iD7p+pNgI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371348; v=1; x=1786976148;
 b=xPOrofuG8y6u/KzfIW8HW5vLtX8Qsi0KuA7o2Nq4Y4zHJR4qWLW9PTwNpE+kmt5uy+U5aiYG
 T73ZikbzZ7IejKrgOc0y3CHdDzwfKqDrgVWCfjpHZkC6NMapVYFukHBwDgAkZrmVcznWwC79HJw
 VbQbTXQ9/V/CYGfC87teF50A=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by mta10.migadu.com with ESMTPS id 00a30766d2c9193a;
	Mon, 10 Aug 2026 14:15:48 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	andrew@lunn.ch
Cc: kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v5 1/4] net: phy: add PHY package locking helpers
Date: Mon, 10 Aug 2026 22:15:08 +0800
Message-ID: <20260810141511.73204-2-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
References: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PHY package API provides private data shared by all PHYs in a
package. Drivers are responsible for synchronizing access to this data,
but the API does not provide a lock for that purpose.

Add phy_package_lock() and phy_package_unlock() for drivers to serialize
access to package-private data, including its initialization.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_package.c | 23 +++++++++++++++++++++++
 drivers/net/phy/phylib.h      |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/phy/phy_package.c b/drivers/net/phy/phy_package.c
index 16ae8d1c1f89a..735806c5bea88 100644
--- a/drivers/net/phy/phy_package.c
+++ b/drivers/net/phy/phy_package.c
@@ -52,6 +52,29 @@ void *phy_package_get_priv(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_package_get_priv);
 
+/**
+ * phy_package_lock - acquire the PHY package lock
+ * @phydev: PHY device that has joined the package
+ *
+ * Use this to serialize access to package-private data. Release the lock
+ * with phy_package_unlock().
+ */
+void phy_package_lock(struct phy_device *phydev)
+{
+	mutex_lock(&phydev->mdio.bus->shared_lock);
+}
+EXPORT_SYMBOL_GPL(phy_package_lock);
+
+/**
+ * phy_package_unlock - release the PHY package lock
+ * @phydev: PHY device that has joined the package
+ */
+void phy_package_unlock(struct phy_device *phydev)
+{
+	mutex_unlock(&phydev->mdio.bus->shared_lock);
+}
+EXPORT_SYMBOL_GPL(phy_package_unlock);
+
 static int phy_package_address(struct phy_device *phydev,
 			       unsigned int addr_offset)
 {
diff --git a/drivers/net/phy/phylib.h b/drivers/net/phy/phylib.h
index 0fba245f97458..c6e26ac6b28f0 100644
--- a/drivers/net/phy/phylib.h
+++ b/drivers/net/phy/phylib.h
@@ -12,6 +12,8 @@ struct mii_bus;
 
 struct device_node *phy_package_get_node(struct phy_device *phydev);
 void *phy_package_get_priv(struct phy_device *phydev);
+void phy_package_lock(struct phy_device *phydev);
+void phy_package_unlock(struct phy_device *phydev);
 int __phy_package_read(struct phy_device *phydev, unsigned int addr_offset,
 		       u32 regnum);
 int __phy_package_write(struct phy_device *phydev, unsigned int addr_offset,
-- 
2.43.0

