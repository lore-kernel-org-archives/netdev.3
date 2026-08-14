Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908445A28E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698681; cv=none; b=rQOSnCNQlLNVKWYs0oYthb+6qEUutYSErC4Yhh+aUIi+/yG0GafGAv84NRxLX8MJ1+ummj64waHeahpyGN95kezGCrpoQSTFvgUqH194rGRaZIkeGABKkSbtsJxZA8bNcRbS/RCrIYuNfH0Zg58BBiNpwOMsmaC7+y+IpFttiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698681; c=relaxed/simple;
	bh=4T3TGrPOmCcuyK6wQdLMcII19a6AyfhLY97Res9looE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8/m2lSty+aHCaLZMzXK9SYCSIJ/7meMLYjHezFwQZbYVYFy+cgs3OPKS+/fX/ZkHvIme66Q33DzEM76PBxLCguMf1WKfJiDxXIVfg39q1zW2Vg789AHV/ApxdyQV1SG6jjt9YCHxvncag/yLK673JkYw0xyrG9vPQLXVdxUDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MbvyuQ2H; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MbvyuQ2H"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-9087fb771d3so3680066d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698679; x=1787303479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSV0sSSXYSyAmLjxbnCOORhk+yB6Zbd6HUBS6OIrdiQ=;
        b=hM7w7bKwVqvEv2Fo0d+fCuuPtKO0UMgIWFDbskLWbM9SUKQ3ameSCngr9Ou1DSBnLz
         kAAbZ7FoSPxd3Tz4Tis3DYBE1e7wJxPX7YPkZIIsrka5JCVFDVKysr9w+gjytq8Q6pKZ
         P6lI9NEJ2JgDImDJ+Fhfv+gT/e+qb4GesccO8xbylvz70Y+JYqgxvkQwJwJeQ2CzYqHc
         geZTlfeqUQmOar8mKfP2J7t+yAF39+IawA1BIb5P6rWTcyOQoFQM0PI8r1fwmpjbfjne
         ujQWy8+27m2H1dyZbAFIzBOUCaXBUQ1vsSZs/Jw/+k1DogVZc6WWeOSL9fJf/Kn4S8Ly
         2yXg==
X-Gm-Message-State: AOJu0YzkCz+f8a7utrINYWO/jAn/MBdzHocpY+zjblfnYA0H7GSakYYK
	fyes+SGM6c+sr4wxzJIc6PRrTXC21f+kuuOkKUYo+Zf2iseYvEtTmANysOLqLevl8jra8taW8g5
	P/E3U6NMav3l9XAAIAm/vpr09ZDgZE6e+K+LpkuCvgYKcBq+XkszVP+Zh4PxLAitIJQ4I1QTDmy
	dU41qBKzxJ4q6J9RpasEIaj3h8SzhDIsD7DCtBTz9mcakIv6dl9aoo4/Vq4j90e2ycauFdgMYv6
	tQu9pPJBA==
X-Gm-Gg: AR+sD102UHVTdghB8NeGgrnloI6hNYTooAFvw4+++PxGSPkYnFHsi37901gumTdLgmR
	aHYzy0SPGeegXrd1CjFRndoIHTaTGmsTnMf5VTwC3UeXSclJ3SQlFj2YEE0bBxqeo4T8tYh8wrn
	l+gYCCoqFjU3WSkTOnxLe5OJiNz3KEW0NQOaxLygvda6cDyReoTPT3u2GAp0dX4KnXCnVzKfXEf
	KWwcOMZtf+Q0ScfO3wKD3mH9iQ/0XqOxtqYtOuvNeaPeIdiZLdE2Jn1aj/hny28hzJlsa7M/Ho4
	og75ZMwzHN/THjwYcC4+9A8U5NP4tc1duM65rSfU7T5yc/If+R6xKsL/sViGMKpl+FHAkDltzza
	HM2AwHD1LaPSrPFD5aALvBg0kLgbTgTLnm0FhSu+ZV2vHqrHa0hJ4J1UGILUkQMZNvnVOUPWRwL
	qXzjCfhiEoQCLNWhvgWvTyIgjK3c8EQWs=
X-Received: by 2002:a05:6214:5547:b0:8ee:efa3:4466 with SMTP id 6a1803df08f44-90a91dc8aeemr50382786d6.28.1786698679312;
        Fri, 14 Aug 2026 02:11:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-90a93501d37sm115296d6.16.2026.08.14.02.11.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2026 02:11:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so651023a12.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786698678; x=1787303478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSV0sSSXYSyAmLjxbnCOORhk+yB6Zbd6HUBS6OIrdiQ=;
        b=MbvyuQ2HFJ+TziykOY/KQcKkL0RyJQLHJxIpIl2uhO0wywpiViwMsydGqaj3845cQf
         5QoBfAI9dztUyniLBH2bMIyN4onZydXyKIOHSRDtgy22ltRPGunpXPEVheyYjCYbDCIJ
         XIkt9k76sUqGHhh7AdBP+Wudqs2S2URfEpcrk=
X-Received: by 2002:a05:6a20:6f93:b0:3b4:9171:2573 with SMTP id adf61e73a8af0-3cc71e32e45mr4481826637.37.1786698676595;
        Fri, 14 Aug 2026 02:11:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f93:b0:3b4:9171:2573 with SMTP id adf61e73a8af0-3cc71e32e45mr4481785637.37.1786698676204;
        Fri, 14 Aug 2026 02:11:16 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887e3e7sm7056408c88.9.2026.08.14.02.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:11:15 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leonro@nvidia.com,
	jgg@nvidia.com,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	siva.kallam@broadcom.com,
	usman.ansari@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [PATCH net-next 2/2] bnge: add steps in bnge_shutdown()
Date: Fri, 14 Aug 2026 14:40:54 +0530
Message-ID: <20260814091054.359508-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814091054.359508-1-vikas.gupta@broadcom.com>
References: <20260814091054.359508-1-vikas.gupta@broadcom.com>
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

