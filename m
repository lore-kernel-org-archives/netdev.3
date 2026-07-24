Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF243E080
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903435; cv=none; b=GXmrzlivFQKLr1vwSTtVopveo7RWpdCxys+jttjVDI5evCfSZDlNM4XQdgzyUqxsOGUNk9EivIu/FhDXB8PmnBfLy5NyuXSqUVZVYVAOOVzdHn/o9KAM+2uzBP1DlIrLL7ON7z9wBcuVcOJvnL1zPxWGgJiujq9LvOqrk4//MMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903435; c=relaxed/simple;
	bh=4T3TGrPOmCcuyK6wQdLMcII19a6AyfhLY97Res9looE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbnGl40/kTm9MLAN0QW5irwrEqeYrrrArSEAXEwnANkiaGAZs3603H/yQGgsaEcrzSPQwxlviQp4ctTF9ivApk64VYQD2DQyjTyjVPc0USgnbZL6J7IXe2nZ4u0fXchZ5mJGaaN5S4PjtYFAfL1tNjcMRXjcIKrJSXQfWhso90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C03TPZf6; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C03TPZf6"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso152497e0c.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903433; x=1785508233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSV0sSSXYSyAmLjxbnCOORhk+yB6Zbd6HUBS6OIrdiQ=;
        b=Shkam6c4fLVzJ2AFwmz8IQoD6OYJ1JVRveGHAri4gbcELdWZIXLtgnsEkE5aSdtQrI
         DNKkFNsvLjKzMZQJnEx4Bq9eLVh6eX5AN3oZ5Pj2trUYfXN6nbEUehUGLQWNB3Kpyg+M
         KKxycSgohS2kgSv4rZzuOwfNb4EiRSPGqII8N+xLkQM+k5TubEo0NXLyrrR4h0ek45S/
         dEEzrJhZQbKEL+3DRNZRLlGfNiEoPH4u5+j+dT0IMyNPB0Y1eKtb4KjNAc14ZNnDGlwh
         Wu12k5YRxL/SnCvlY8fIbVzITvrD3i+Obz5MnP0v1gU71cQaLTqB6zcDK8nowrcseYAa
         X+JA==
X-Gm-Message-State: AOJu0Yx7hrGwtg9GjBQn8dPF361aIOKBS0i9KS7n6UDn8W/wXB5gc/Ex
	/KCEN3IlnNOZl+hxLoXbWkmT2m3+R9Brf5uijGAUI9Gof4gmm3NjuH11sNb0/qiVgBuUm7mbPyC
	M465ByyYcS4DENFUW4pxBvcJwHPkc0mUGqq9r5tZvS/y46qSd6X8ehWe7lnioPaKJ5wW32wy+tk
	p2vzcBC1rUOewxBS0xOghSLunTDx9DUemJbQ/go1xy4QbSsWHbrXzdwI7OD4uu8Av7DqQaIQE02
	NCsoeYUdA==
X-Gm-Gg: AR+sD126S+M4XMt46gC0JyJKwBDmGHoWKJ9LI/qhaIUBMsXlJV1Q4wpmvt2sHw+L5X9
	Z9FS3YE7aHII4jm0W9jLPJOHOBo+FN6Gru7li7pemF/jQvBBFOmpPLWevXCoOZ8HHsX2GWohny3
	lFzlPJ7cYQ1i4VA9U5gG44DcFSH4KzNjOM6IzVkqi6sGmlUtYxwwtr3AkyxEcy3L9im2Vujrmje
	pbX1mDnNnFjhflyhe/de0rHyz+vlho/6d0amT31XURSS/eIxJWsU9PcyZJZoodIZqpK23P3CguS
	ejA6zqrV9iVGKIx8aJ0p3IQVHWWNo4no8D05j7VcYPzm0isPLzxgqpJoWh4MidR+3FrKZUXzybe
	yavNKuwqEfZzpSPLHgkQi+jHsFr9xZbFqgyJ0m/qiBjFV85RCNx0wCWQjKtYBzWyB4jCA9F5alq
	fMn5qOxxmtoT1GIdHHroNg0FG7MmvuPT8pRA==
X-Received: by 2002:a05:6122:1352:b0:5bd:b27c:bade with SMTP id 71dfb90a1353d-5c2da06aaeamr3466069e0c.5.1784903432932;
        Fri, 24 Jul 2026 07:30:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c2c6275da7sm875895e0c.1.2026.07.24.07.30.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:30:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so771395a12.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784903432; x=1785508232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSV0sSSXYSyAmLjxbnCOORhk+yB6Zbd6HUBS6OIrdiQ=;
        b=C03TPZf6cGw7y791sMQSyNWDE/1RhbxZ2lXe9LVi2XtySOCQITMcxtoYsIFyygwuvq
         JXelc1CgKMPGxIcF4nfsONbtY7U4NedpzPT973r7NHWcDT0qHsGbVN6/wrj1Qg/QVZlY
         lBbrCm2/9T52N3GZVgcjZo6zcJ9iMWDt6kGcA=
X-Received: by 2002:a05:6a21:7317:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3c44afcf8b1mr7850184637.20.1784903431667;
        Fri, 24 Jul 2026 07:30:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:7317:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3c44afcf8b1mr7850146637.20.1784903431100;
        Fri, 24 Jul 2026 07:30:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm259643eec.31.2026.07.24.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:30:30 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 1/4] bnge: add steps in bnge_shutdown()
Date: Fri, 24 Jul 2026 19:59:51 +0530
Message-ID: <20260724142954.3101980-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Since the driver now implements ndo_open and ndo_close with full link
management, the shutdown callback must mirror the close sequence to
ensure the device is brought down cleanly.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 68b74eb2c3a2..9846d29b4fe3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -5,12 +5,14 @@
 #include <linux/crash_dump.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/rtnetlink.h>
 
 #include "bnge.h"
 #include "bnge_devlink.h"
 #include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_link.h"
+#include "bnge_resc.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_SUMMARY);
@@ -406,12 +408,34 @@ static void bnge_remove_one(struct pci_dev *pdev)
 
 static void bnge_shutdown(struct pci_dev *pdev)
 {
+	struct bnge_dev *bd = pci_get_drvdata(pdev);
+	struct net_device *dev;
+
+	dev = bd ? bd->netdev : NULL;
+	if (!dev)
+		return;
+
+	rtnl_lock();
+	netdev_lock(dev);
+
+	if (netif_running(dev))
+		netif_close(dev);
+
+	if (bnge_hwrm_func_drv_unrgtr(bd)) {
+		pcie_flr(pdev);
+		goto shutdown_exit;
+	}
+	bnge_free_irqs(bd);
 	pci_disable_device(pdev);
 
 	if (system_state == SYSTEM_POWER_OFF) {
 		pci_wake_from_d3(pdev, 0);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
+
+shutdown_exit:
+	netdev_unlock(dev);
+	rtnl_unlock();
 }
 
 static struct pci_driver bnge_driver = {
-- 
2.47.1

