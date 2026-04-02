Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B23DA7F3;
	Thu,  2 Apr 2026 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135626; cv=none; b=KY/2Hr15iNySuGd82Vq/ZiLyYNsjBI7MitCtJBduFi/LBox/xIG6QqRfdjrug0qUjCf5U/9HHh5cMKq+VV40Fo8eupWGs2Xh3wXPQlRFUbgrdo3vOBjC17E37KYHBS2Ddb1/NfaJsK00yuVhzu4vODRrM5mtPPVISQGyKxUGBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135626; c=relaxed/simple;
	bh=9J04dCwa/PtETLbw9AxUT8HLph5CiL5GvXuX5fSNofs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F14eMtEHxerFYKUU1tmlflU3rRr53LSl2wSRXF/w7c+TeUkp4m/6a49MIyIeXyaHEyx+DEokQvYP/MgqUnanmlQYillpJbEH6Q/1IAiaDjEVbP1rGkYUKpNwvMqHurQ+iE8yVdeebPKYHZ0JIqV5E/zMhLhQDWGLJaDMePYOT+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XrbtmThY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XrbtmThY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775135625; x=1806671625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9J04dCwa/PtETLbw9AxUT8HLph5CiL5GvXuX5fSNofs=;
  b=XrbtmThYxRowp/rSReOYhEeV4rm3EyLAmm6FZOEkszIyzYPyJK34DtLm
   KpnxK06iilTRJ1yrqz25ZKwnMmo58wVcPG19yZqLrcECQX1MlNh4444F7
   uXXYnuqmMf6tDhCKujPby1OH8/vOyBPohh14d9FLPFd84DEdjCnYdM6w+
   NjyygJ9JfC3mJ9ocnEFFe4CEfhYUS1bHa+e1Z28krxbrrKIcxO40UPWSK
   l7VvJ59yqObQI633WEFTAZwHvK/hBSTZt9mxYpgXnkTS2Bb+DyKvFReuB
   6seKegNXkg3UEJpyokLLeHil++GQIiMsXvsNRW8K3QOov78OFDbPsR+w+
   A==;
X-CSE-ConnectionGUID: UGofO4cJSXOAkJsSzS2N8A==
X-CSE-MsgGUID: bKgYiNHZRi2D3ah/YMRG9A==
X-IronPort-AV: E=Sophos;i="6.23,155,1770620400"; 
   d="scan'208";a="55583671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 06:13:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 2 Apr 2026 06:13:20 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 2 Apr 2026 06:13:19 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when disabling interrupts
Date: Thu, 2 Apr 2026 06:12:24 -0700
Message-ID: <20260402131229.319599-4-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402131229.319599-1-charles.perry@microchip.com>
References: <20260402131229.319599-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

MDIO bus controllers are not required to wait for write transactions to
complete before returning as synchronization is often achieved by polling
status bits.

This can cause issues when disabling interrupts since an interrupt could
fire before the interrupt handler is unregistered and there's no status
bit to poll.

Add a phy_write_barrier() function and use it in phy_disable_interrupts()
to fix this issue. The write barrier just reads an MII register and
discards the value, which is enough to guarantee that previous writes have
completed.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---

Notes:
    Changes in v4:
      - Add this patch (Russell, Andrew)

 drivers/net/phy/phy.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13dd1691886d..2be0b90e9947 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1368,14 +1368,39 @@ void phy_error(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_error);
 
+/**
+ * phy_write_barrier - ensure the last write completed for this PHY device
+ * @phydev: target phy_device struct
+ *
+ * MDIO bus controllers are not required to wait for write transactions to
+ * complete before returning. Calling this function ensures that the previous
+ * write has completed.
+ */
+static int phy_write_barrier(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read(phydev, MII_PHYSID1);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 /**
  * phy_disable_interrupts - Disable the PHY interrupts from the PHY side
  * @phydev: target phy_device struct
  */
 int phy_disable_interrupts(struct phy_device *phydev)
 {
+	int err;
+
 	/* Disable PHY interrupts */
-	return phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
+	err = phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
+	if (err)
+		return err;
+
+	return phy_write_barrier(phydev);
 }
 
 /**
-- 
2.47.3

