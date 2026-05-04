Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86730F52B;
	Mon,  4 May 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880778; cv=none; b=ADhmSpE2yoIWkMzJwc7OLftIn8J9xHCbRrJQ14k/WDmcV5hrBEdegv3ClMWBdTM3uNoQs64ZY7Q5PinT0p7khlbdLWBUDNa803CtL/4BlhVn03yCtXt+5QLpK7e7XA1QRJLvVQu56CT92Np3ZaU1PrkHcU47ECvP8SvLDFdckSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880778; c=relaxed/simple;
	bh=RkNWOK1O3+B+djujvd45woxQHnvTBC9apbGki4tNSWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4q5b5+ah1drcyBUtXXbp0eWOj2MISXbJY26pbXr8JgouLRXhyIClUSaquFuj3ANZhQ9YPh2ltb6D1QmNmV459kKGaJPRL3AAM0+1al0i3pUs36mW4wo5BeOUHBnxKnCuQx4YLhQGWHoZPulz/UTWX+qGMYM3sK8HlJNP+/V0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6mRKpQJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6mRKpQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880777; x=1809416777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RkNWOK1O3+B+djujvd45woxQHnvTBC9apbGki4tNSWs=;
  b=T6mRKpQJ49IOQ9AwnUfRGCJzcTiki7cbtXFyB5gy4lu8yF8cd98tF494
   CJzYVQJkgtdxj5tTuvVair7PiLTVYFCDWJ/zdRc2qgwRD/gd6ltghR2i6
   x3/CRuShoDZWcownFII2HOyWUUrPX/xfZso/d0HmfLFHColwHFKGzlFdw
   V0SWOVaikHcCmfh22Rxx7WduU6t8fhXMEgLmORffeMvMrEVRtfkwe/4i9
   A+D3GATGvyJ5aRXTTJ38JgouEB3iXoUjq/Wy0XAdDPzLqBeiiftq29ZUt
   neI9FIy+3Xs9edinbONNqIClPkqnB+C6BAIeqE+gjfczN2R0ABmg9hLdT
   w==;
X-CSE-ConnectionGUID: UZEjpPgITYCzSX4Expb4yg==
X-CSE-MsgGUID: mIGQBWE3RLWb6fCqQCtkHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78440496"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78440496"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:46:15 -0700
X-CSE-ConnectionGUID: u7rkxLouSY+0BhTIFpCu/g==
X-CSE-MsgGUID: G+nAB4BmTY+RKZjDTo+8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235704822"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 04 May 2026 00:46:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0FFF49B; Mon, 04 May 2026 09:46:11 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1 2/5] net: mvmdio: Switch to using fwnode_mdiobus_register()
Date: Mon,  4 May 2026 09:29:53 +0200
Message-ID: <20260504074610.40799-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
References: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace custom implementation of fwnode_mdiobus_register().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 3f4447e68888..62fbe22c01cb 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -18,16 +18,15 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/acpi_mdio.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/fwnode_mdio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
@@ -379,13 +378,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		goto out_mdio;
 	}
 
-	/* For the platforms not supporting DT/ACPI fall-back
-	 * to mdiobus_register via of_mdiobus_register.
-	 */
-	if (is_acpi_node(pdev->dev.fwnode))
-		ret = acpi_mdiobus_register(bus, pdev->dev.fwnode);
-	else
-		ret = of_mdiobus_register(bus, pdev->dev.of_node);
+	ret = fwnode_mdiobus_register(bus, dev_fwnode(&pdev->dev));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
 		goto out_mdio;
-- 
2.50.1

