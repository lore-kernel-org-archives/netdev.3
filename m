Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423730;
	b=yYb+aJtMyoyORful5S+9eF6TSK6JHmereUqrAHoorky5BNhafO6tVFpCeRbSPQDLG1IV
	 qL71i85TuDECmwFcwFp4MvrpQXgYPZynsA52B++zjnf4kH950nMpiWIQtoKKSY2cBSPv7
	 pnp0q6Zo2O9PtovKAR/RJ+tT6SiSbUAVOAY46kxVBQkH+tjzd8R7u/VRP6X9OiGhY5RH/
	 fuU313alqsnjtTu0/OvBUp+vjAbXNBusP/xyrL4rYGM6ijgHIZHigTK5/iK0Of0EQH//B
	 HfLX7cjgM6VrRuxCrguuOMB3eymNbsyG2G/iGz/DxBXB8PJLTvIgmF6ssQpfnSAYZ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423730;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=bppZo3I5JD/laDzucSCMcEHXq0XRsoF4ETRLYmZ5nIg=;
	b=3dei3d/6bh6PCSnM1+QIa9zhCkKAsoibSgFG7TRFTGnuDwJrgx/cA2FUeFZTGiotliXs
	 iJ86VkogelGhU6JKm/Q6Q8gl0yiKJJ/I3Bg6VcfSAQq1uvWyYZjDu9U8OVCz2JecLtriu
	 vvGa5EiCQ6SfR/aSclSUJfGYlcS0a0b+aOUef5c6rH2/RUvvgzF67tw2G+Vi1O/LDkz1d
	 d5fH4cxIXWPnqM7dSqcYs+f8q/SuYWNTErSIVYkOaaqP6hZM7Z1x+06rP8Q+yHhzBs1N7
	 jg5TEGRgIv99NLrL+MTxShXB9Z05BPUXTu3V1GqiImaMr6set7+utREUAJyqWl8SaZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aD3nWxSY;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532E606A335
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4532E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aD3nWxSY
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso1793035a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423730; x=1795028530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bppZo3I5JD/laDzucSCMcEHXq0XRsoF4ETRLYmZ5nIg=;
        b=ohCS4E4/qDsV2J39CXV/CEJ6RAIYcO41huMmwszb5ng23rwuLtoBMmgiT6x74b1LdY
         zxC5mAswixz4K6Dmb8IqQP6HNDNQskaJFJzDUx0/F/eDuJtWVDh7g39/F129l6QwpwG8
         k86BxvVzO32Q56s/cZeO2BPEAr07tT62e01GdJT2LdwobKOeFZ4WLQJFR4wZ88iEMUP+
         +EgInlzrO+Gfm67xoS+lh/Bjot9jPqEY8sS7sSikZIX1eLhFr1gipuNckH8U7ANBZUIo
         eKNpS2XvvB0L0sqlywktCj9Vc0dmgqyaJ6+7lC0YDkbH4Ke4a3oVNZDUitcppJz1Y3hW
         H3tw==
X-Gm-Message-State: APuU4Z+yH/xjIWUxc6VeNkrWb8O5BvSB5PztrheHuvBDjzT6zL0mVRaY
	KMk9v9Gr+xScQxU6GzikDUMeEA3hrYxKB1vWLZxSPwPuNkuZjeOyco6AexGBiyi/MXRo4RkY4r/
	xnbf4XCoaycBh/HgTkoTImTrbIZ4kkvzwSEi8vbIhxnjmuqhC1hacNGWVQUPm7/mm6TTVDDLnpA
	4uJyHy6NXVezMncEIodibe8ze2PJMLFBxb50hWfzSCHjoD29ePZLsuDqzyuIJ6z6B3qRZZowrBZ
	UOjdHJXXfHquaicgg==
X-Gm-Gg: AYBFou1ewL6QR0Jyx8wK420ztjhDPomkjtEqsEXklMRbdZg3TByJrd91nHkTpGP6zZR
	0wPSCBb5sE2ZITeLng5hL405A+FHZTx0UEIIVsOznirY5rWceB82iDv74eYutsavaMYP7wiK5pX
	Do12ar+1+CvRaAaZ+uiJF5IHZRDrtF4bvFdBrqE73o+jntNrAxfJLkoZOHKFi/urnP5fq0cZosS
	7pUVvDtWTaht4U2Va1pxHO5aynehZnYo40cmFBIfXr8BmqrwrOAOt8aLYuqQ0R2TAL5H/9nEECQ
	5nxVBVcWRqFdUfEpxc7osgdxqtqb1HgG0PuXJDQSHxMlWjzjCUnLGwN+83fYwaGL5b1kz6Lsah1
	Bm1mcoELsXljS3I3CN2IrgsXhHyL38/WVzxytnqNMG3gA8U3nOcDvyqHGKlLMQBaSAoyiqTIEor
	428SuoXC4Evkg3SqxH3Kq/C7PHrnyDzKPrAjPqQaELxA==
X-Received: by 2002:a17:90b:4f43:b0:3ae:4dc8:3d3d with SMTP id 98e67ed59e1d1-3b182f5fad5mr3253824a91.58.1794423729517;
        Wed, 11 Nov 2026 11:02:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b182e2e06bsm884859a91.3.2026.11.11.11.02.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:02:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5690225eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794423728; x=1795028528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bppZo3I5JD/laDzucSCMcEHXq0XRsoF4ETRLYmZ5nIg=;
        b=aD3nWxSYLkxfgQW6/AqhU2Lgn8lrUhZ5h2kvx4I0+/sFfynCAgHK77m5GBHYFfb7Cw
         If6iAqI4pkiVWMUzrMEA05xe7p6ZQaiM6gtqwcMjT8r65Nor4zk2VYeOOHz5dmNqs0RY
         YuKnvcRh7uMhRdVAwXomDp1fPzr25RE/FzDDo=
X-Received: by 2002:a05:7300:f54b:b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-37685c7a866mr3388898eec.25.1794423727403;
        Wed, 11 Nov 2026 11:02:07 -0800 (PST)
X-Received: by 2002:a05:7300:f54b:b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-37685c7a866mr3388850eec.25.1794423726578;
        Wed, 11 Nov 2026 11:02:06 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212ec002sm20860468eec.26.2026.11.11.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:02:05 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Kumar Mudide <kumar.mudide@broadcom.com>,
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Subject: [PATCH net-next v4 2/5] bnge: add bnge_err()/bnge_warn()/bnge_dbg() logging helpers
Date: Wed, 11 Nov 2026 19:00:08 +0000
Message-ID: <20261111190011.53437-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111190011.53437-1-bhargava.marreddy@broadcom.com>
References: <20261111190011.53437-1-bhargava.marreddy@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

netdev_err() and netdev_warn() print "(unnamed net_device)
(uninitialized)" instead of the interface name while the netdev has not
been registered yet. Later patches in this series run NQ0 init before
register_netdev() in probe, so messages from the HWRM ring alloc/free
paths and from NQ0's async event handling would be logged that way.

Add bnge_err(), bnge_warn() and bnge_dbg(), which take a struct bnge_dev
and log through the netdev once it has been registered, including while
it is being unregistered and after, where it keeps its name. Before
that, fall back to dev_err()/dev_warn()/dev_dbg() on the PCI device.

Convert the HWRM ring alloc/free error messages, the IRQ affinity hint
warning and the async event debug message, which are reachable from
those paths. No other message is changed.

No functional change, apart from the log prefix of these messages
before register_netdev().

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Kumar Mudide <kumar.mudide@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h      | 18 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |  8 +++++---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c   |  5 ++---
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c |  4 ++--
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 4479ccd071f5..e76ba4e063bb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -220,6 +220,24 @@ struct bnge_dev {
 	u32			phy_flags;
 };
 
+/* The netdev has no name until register_netdev(), so log through the PCI
+ * device before that (e.g. during probe).
+ */
+#define bnge_log(level, bd, fmt, ...)					\
+	do {								\
+		struct bnge_dev *__bd = (bd);				\
+									\
+		if (__bd->netdev &&					\
+		    READ_ONCE(__bd->netdev->reg_state) != NETREG_UNINITIALIZED)\
+			netdev_##level(__bd->netdev, fmt, ##__VA_ARGS__);\
+		else							\
+			dev_##level(__bd->dev, fmt, ##__VA_ARGS__);	\
+	} while (0)
+
+#define bnge_err(bd, fmt, ...)	bnge_log(err, bd, fmt, ##__VA_ARGS__)
+#define bnge_warn(bd, fmt, ...)	bnge_log(warn, bd, fmt, ##__VA_ARGS__)
+#define bnge_dbg(bd, fmt, ...)	bnge_log(dbg, bd, fmt, ##__VA_ARGS__)
+
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
 {
 	return bd->flags & BNGE_EN_ROCE;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 651c5e783516..fb960bff85fa 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1302,7 +1302,8 @@ int hwrm_ring_free_send_msg(struct bnge_net *bn,
 	bnge_hwrm_req_drop(bd, req);
 exit:
 	if (rc) {
-		netdev_err(bd->netdev, "hwrm_ring_free type %d failed. rc:%d\n", ring_type, rc);
+		bnge_err(bd, "hwrm_ring_free type %d failed. rc:%d\n",
+			 ring_type, rc);
 		return -EIO;
 	}
 	return 0;
@@ -1395,7 +1396,7 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 		req->int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		break;
 	default:
-		netdev_err(bn->netdev, "hwrm alloc invalid ring type %d\n", ring_type);
+		bnge_err(bd, "hwrm alloc invalid ring type %d\n", ring_type);
 		return -EINVAL;
 	}
 
@@ -1406,7 +1407,8 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 
 exit:
 	if (rc) {
-		netdev_err(bd->netdev, "hwrm_ring_alloc type %d failed. rc:%d\n", ring_type, rc);
+		bnge_err(bd, "hwrm_ring_alloc type %d failed. rc:%d\n",
+			 ring_type, rc);
 		return -EIO;
 	}
 	ring->fw_ring_id = ring_id;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 04f5aa75f70e..d95c3c1469da 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2702,9 +2702,8 @@ static int bnge_nq_request_irq(struct bnge_net *bn, struct bnge_napi *bnapi)
 		cpumask_set_cpu(cpumask_local_spread(bnapi->index, numa_node),
 				irq->cpu_mask);
 		if (irq_set_affinity_hint(irq->vector, irq->cpu_mask))
-			netdev_warn(bn->netdev,
-				    "Set affinity failed, IRQ = %d\n",
-				    irq->vector);
+			bnge_warn(bd, "Set affinity failed, IRQ = %d\n",
+				  irq->vector);
 	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 472b02cc43b3..2f382514c6ea 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1135,8 +1135,8 @@ static void bnge_async_event_process(struct bnge_net *bn,
 	u32 data1 = le32_to_cpu(cmpl->event_data1);
 	u32 data2 = le32_to_cpu(cmpl->event_data2);
 
-	netdev_dbg(bn->netdev, "hwrm event 0x%x {0x%x, 0x%x}\n",
-		   event_id, data1, data2);
+	bnge_dbg(bn->bd, "hwrm event 0x%x {0x%x, 0x%x}\n",
+		 event_id, data1, data2);
 
 	switch (event_id) {
 	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE:
-- 
2.47.3

