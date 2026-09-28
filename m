Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EB415F20
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576074; cv=none; b=kBgsA41hBGcTD6/6rV80j++NQbSQ17B63ju2G/DkG8faKX2At3hIWeqfsF0lQmSV8Tt80x4fmKdjkbyX22LrC+YKWuR9s0gxNhOp53fhXIPH3hNIL97ldgVfokH4dNR05G7MUPW6FuKQUx0ZwpYUAkD5L4FywRR8+Xh1BATvDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576074; c=relaxed/simple;
	bh=AfKbEq4vpCeOBJVQFeSu9eRnmEwoRe/jktzsvMFglZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3RNIDs/ijDQ7auM10Mu9rgqZ64E33kkF+oZbpTl3/zT4p56nwK+EghVmVkoEtCYZt9wZM5FoHtzcZfnRRNKQZ2lteg91TFFB6uIt89vOtk62Krp8Dx7O/2WNKCylLhN2w7lldbF1uJXj9tkjVHuzKqVe0sJxQnO1CsKEZvOMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fBvoklcS; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fBvoklcS"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-869d181419bso452995b3a.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576054; x=1791180854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRLChZZmnfzku4p+thWspm6MZWbJ15XjLV3VTmK3xhw=;
        b=GhMa69BXctzFO1Q0KLYicGH16Ysrzs8sV7U/kiVVA+LdvSVHKeIOZC7HA5FyoeqhNV
         hXo1P0zM0W9mL6nmDse6oAzax+aarDf4hQFnnaPzXK3x0FWkOZNPyj8i4u1uqla2kUN+
         c3DDSghSyR53ufqZt6toCVlayG6ZwENJh2s5H0bsbZd9WG+82vqKvq+zh1rjAqfyEQeI
         WoSrcg4LpSqSxJlHKtRaZKlBZuC79GldD5vbSCyurK7wmYH8wo8UwV+bTlGTlLHWEoqV
         ths8Ht36cYLePn82MnXcMkfzl/5HesWjgWtL4mMpzaSk/DeyNYXGCjOmercVJ6bKWFv5
         Cjbw==
X-Gm-Message-State: AFuF++moUp0iSDoewZXYjd+6ZtPbKDdoIy5MqVcthWvuF0djqAC7vDkH
	IeXeQ59CKgyCQnTRvRXS8m6WV851tfMrIIzHVINlE8R0Wxu8loF+Nyii4zH8Bj6xJBPytaAutj6
	TgCdC4HERoNbFdNOB2qjvS0uhc/R5AJG/Hak358swF2iXCQUUGSq8kTNVJCdM/agMYcm99NkMhj
	PXEIvqQu9taGfHaqvrVDNsVSHHjXYR4iUMK3t+GYdEYffCX+zzWmbbEYxdruqb6JFZTuI88xTjC
	mTxER3Ksw==
X-Gm-Gg: AYBFou3wJe/8lk+TdXl4/ENVMVjS2lv7D7hrCpmuD7GQVq73bFWMoRt4KCuya4Z4vVd
	KEI8C+SwW5JP/+oZoBMlKFovBFtmfTInW60+OfDh/sL0crxYhzu7vg1p6cBnD+GydRZ/rYydiOl
	XN0iZZQNn3Bct4mHMD9RcHzk0XlKSYIJj2LxaDQlh4Dx5UGmbuJvXZWhoqN0WQR/MRZyrQpt9Rc
	JNK6z+suYyeG2NgbVvDOPLtSOM0C7Bk+i4O5EXJ6dNA1h24GTHWtfVQjNTZAJIDOadBYt7dO8Kj
	mRDopFVENBfGqwnOu0v6RMkVmbAKbStbAm4jYGaHCnYpY9lbC9q9zkbu7IEF0WE+8Kjrl5O53nY
	NNKhmYKIBKQwocbyyZZ/kgQGzXQQW/bXLFJACS4/9hghMAfgJd+6wzfFz80W9JQo3Q2NKaeLQ8Y
	WsHPMPKU2J/yiUGBIELQv8DKx/UkvuEOl+FStK
X-Received: by 2002:a05:6a00:4fd5:b0:87c:9094:b72d with SMTP id d2e1a72fcca58-87e98994aa5mr9464939b3a.6.1790576053598;
        Sun, 27 Sep 2026 23:14:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-87fedff3c63sm4674495b3a.6.2026.09.27.23.14.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:14:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3441e2b3fc3so1252121eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790576052; x=1791180852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRLChZZmnfzku4p+thWspm6MZWbJ15XjLV3VTmK3xhw=;
        b=fBvoklcSF5gxN3tlxqG1fvW6Rmi6N5mV0x4TA+Zk4noCqIako9aJsL/tM4hahVDcHa
         LuHpE0Y4Is2OThag3DPFGJ2ZoMGmD3jZydErEKbx+DNGpcZ63Shi1j2IQRY0KFl0VBHJ
         In6ueoh3WWaFqjZghU1ZhUeyvY4FqSBiWbbBk=
X-Received: by 2002:a05:7022:5f1c:b0:149:7f69:a3ad with SMTP id a92af1059eb24-1497f78ea23mr2517364c88.13.1790576051903;
        Sun, 27 Sep 2026 23:14:11 -0700 (PDT)
X-Received: by 2002:a05:7022:5f1c:b0:149:7f69:a3ad with SMTP id a92af1059eb24-1497f78ea23mr2517330c88.13.1790576051189;
        Sun, 27 Sep 2026 23:14:11 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm17355561c88.17.2026.09.27.23.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:14:10 -0700 (PDT)
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
Subject: [net-next, v4 10/10] bnge: add cpu_rmap support for IRQ affinity
Date: Mon, 28 Sep 2026 11:43:07 +0530
Message-ID: <20260928061307.1172344-11-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When CONFIG_RFS_ACCEL is enabled, allocate and populate a cpu_rmap
for the RX IRQ vectors so that the kernel's aRFS infrastructure can
correctly map flows to the RX queues serviced by the nearest CPU.

This ensures that NTUPLE rules created by the kernel steer packets
to the optimal queue based on CPU/IRQ affinity.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index de7818d2c2af..a4156a12c871 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -18,6 +18,7 @@
 #include <net/ip.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
+#include <linux/cpu_rmap.h>
 
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -2437,10 +2438,23 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 {
 	struct net_device *dev = bn->netdev;
 	struct bnge_dev *bd = bn->bd;
+	int rc;
 
 	bnge_setup_msix(bn);
 
-	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+	rc = netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+	if (rc)
+		return rc;
+
+#ifdef CONFIG_RFS_ACCEL
+	if (bn->priv_flags & BNGE_NET_EN_NTUPLE) {
+		dev->rx_cpu_rmap = alloc_irq_cpu_rmap(bd->rx_nr_rings);
+		if (!dev->rx_cpu_rmap)
+			return -ENOMEM;
+	}
+#endif
+
+	return rc;
 }
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
@@ -2456,6 +2470,11 @@ static void bnge_free_irq(struct bnge_net *bn)
 	struct bnge_irq *irq;
 	int i;
 
+#ifdef CONFIG_RFS_ACCEL
+	free_irq_cpu_rmap(bn->netdev->rx_cpu_rmap);
+	bn->netdev->rx_cpu_rmap = NULL;
+#endif
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 
@@ -2475,6 +2494,7 @@ static void bnge_free_irq(struct bnge_net *bn)
 
 static int bnge_request_irq(struct bnge_net *bn)
 {
+	struct cpu_rmap *rmap = NULL;
 	struct bnge_dev *bd = bn->bd;
 	int i, rc;
 
@@ -2483,10 +2503,30 @@ static int bnge_request_irq(struct bnge_net *bn)
 		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
 		return rc;
 	}
+
+#ifdef CONFIG_RFS_ACCEL
+	rmap = bn->netdev->rx_cpu_rmap;
+#endif
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
 
+		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
+		    rmap && bn->bnapi[i]->rx_ring) {
+			rc = irq_cpu_rmap_add(rmap, irq->vector);
+			if (rc) {
+				netdev_warn(bn->netdev,
+					    "failed adding irq rmap for ring %d, disabling aRFS\n",
+					    i);
+#ifdef CONFIG_RFS_ACCEL
+				free_irq_cpu_rmap(bn->netdev->rx_cpu_rmap);
+				bn->netdev->rx_cpu_rmap = NULL;
+#endif
+				rmap = NULL;
+			}
+		}
+
 		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
 				 bn->bnapi[i]);
 		if (rc)
-- 
2.52.0

