Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159953932F9
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086525; cv=none; b=VWcdxIqWx75LYZvUTR+mhYl74kmBmrmdm+zTeiiidAfwiHkzJpFrVnpPYaNzZRjklcG1JtM5psQAq2LTiEyzordh+g0FjxUYp132OFlSE5szSLSRjDni7G3njSxlCGBKqIRg1VlrVfB7dpjkx4HRwF+efYw9C9JrS3UAHJhq56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086525; c=relaxed/simple;
	bh=lIk8CKl/DY6gEGIDotY/La7Qoc8QphtfocCqZraPYqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4o3jaDuY+YnZ32e+wERTfiz0AsKRHfGRXy4i8nzq1pb9T4RLZywo7GasI09gHmqfm9hH6Eh+5uXL/XKeOP5STjb9Pk5/Zg2M90pSTvCNamspwZfX4vvB3cwJqWmqdFfkzQBcDWOX7gWXdeGY+B8UNdx+V1IUd0qzt594cBWWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eu+mi97P; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eu+mi97P"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786086520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vR9PO7CiL7olE82jJsxDGtW722YzElPf9IL7QLa9rlE=;
	b=eu+mi97PmTDgZVSIyXqDkAO9FCyWO7BmD1MnWVWsKmc1COQ8SmMcekfWQSGQaG2SgQWcl2
	WgRNR6nRfXp4ippKkzFEIPxVwT3HfID99AdNe11Ya07/FOE8aK+YZXHnrr8uF9g2bSxWY8
	AxC/h7jBXbbK5qhyg/S4Xj9+hYqDXKs=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v4 1/4] net: phy: add PHY package locking helpers
Date: Fri,  7 Aug 2026 15:07:26 +0800
Message-ID: <20260807070729.12545-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The PHY package API provides private data shared by all PHYs in a
package. Drivers are responsible for synchronizing access to this data,
but the API does not provide a lock for that purpose.

Add phy_package_lock() and phy_package_unlock() for drivers to serialize
access to package-private data, including its initialization.

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

