Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3A34B682
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062598; cv=none; b=BVS/IbbJ3IlwOkrTIKh/Zk2+kgPZgdIypD69zVv/yOEbC1C+9SGdZYzXrQHJSbt2MVB+mWHmF2a87F3lpAXy8jEwl0J+/HAcFCPKlOcvJthJPGWdUqjWhyRhvyX7IZhH/HhDwUZ4zjAC8CFqYnQChiTIicgBPo7NsC8GC56xjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062598; c=relaxed/simple;
	bh=oaSgVKV9ncFjBqihKduiLJz1tSTFNFSOynfsh1SPsOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzphD06v67I5/UqbS3BUbpEFB958RL6ibkvf34329Ypc5gpK0/pw16JDRpQrPPGSqtkAeeuCLN8X91PI+92/kqWYi0GH8Ti+SI49zZeH2LPb/bmzgo9Vdxp+xe2AMmNAjJB0h5xNpD+kFAV1iLhuwXytx2cz6hkrPycrrQqY/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=c0vUjQ0t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="c0vUjQ0t"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso4322141a12.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1785062595; x=1785667395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3rQnhT50p6yjZujzGtzsuREMMxUVoqKZSjoa9Muf3VQ=;
        b=c0vUjQ0tMDJWCLtAr/VD6a3qWX2RwjF5Xnkngatbx894TfNMwItqmuvFsAKkMmHO58
         fHMv1ZG60qx1kMPyxzcAYuXTVkUgZdd2z6CGJNxoRzk5iiJEKrmJfKCkP6d9WqdfKf7S
         7pfx8V6nROZu/hRN75x9ByVss6amLtCxI0fRZ/NK1UuVOmFBLi4XP8WvaCic4hCZTy+7
         e9sW4sTjfN5gRmDFT20aSl2AnDKAiRb22wpKM2FPlWe1caREViUwye90d0QIpwAKURjH
         jtAu2qeOkMu7CZhDxoT/bZsA273sNlLY5aNV3UNyDDhPjxKqh1PAQ7l/mXysFL3AxPQn
         BADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062595; x=1785667395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3rQnhT50p6yjZujzGtzsuREMMxUVoqKZSjoa9Muf3VQ=;
        b=tVbcFniEqZBJg6MxKxYWPwGsK1mCirvHv9q3nDN0ytMf4+kIx3EcNL+l20rx0IJ+84
         /QHmv6Gi6E9pn0Ui9EDQAlGgFK1XESXiAiN1vttDOC9v/aw/o1t3nT/QunhhNBOvkWlh
         IKU8kYbR4qAmg4gk3tyvT8RggOBDBByiTbG2SupphD7RYkwHRdm/gghnA9iPeRbC8qE5
         yg0PP8kk+dSz0EBrnw5N5WCo2p1GDnyUAbSoqN8CV6YIQ05NhMeSY7udLcKraodLC4eA
         mGvMMyuRwB/P9OqUP9dKq4114IW5uM97hRjN1Amd5XRCyRMqo3YXklD0Ci6Ts/sUDvd+
         SwKg==
X-Gm-Message-State: AOJu0Yz6GMtbFN33QvS7SknguMsOwGQ1or1ZnLIuM2ELJ9WwSWoiW4i0
	98mgmPxDlH0K9yfxozD5tkxkQm/3dDPtbVUtQgDxn0o9f/Kg44Ch5065bo0qrO/Nb5AWdkq7SJL
	XxxQX
X-Gm-Gg: AR+sD10PwfutO8/oZKy2AozLdRHoy1HnofMKRGtUy06Vo+wZO7JZX29Llh499BEYUQS
	sGULX9342Pfh/A20qryGD6Ph2MZxyZzmKo6RH7QmkJEkawgi8dvrtDwOZDZZjT1aI9FCsSG52A+
	NZmAsRluAqjCVEOVA/MSbCQ2wxBcloyeF5BkMy7WNUMk5W6b8iRkZwzvTyYffN6HRxgPm5p5Xrw
	NDkLsQAiVGZVr1M9Ql5KiX58scxC8Q4+7CHh/w6FpWnMT0iKebW6KDZIq+/xpDvmWdl6MzNQco/
	TB/0NhXrhTsDOvW0HqLNl47lxq6m1zefWNn0UAI8kHSNrt726Rz/sUaYsJ3z6x77q3vThmsSB3z
	wWiRVa8xppxCIdfOqpRCn3UI/QWl8uEGJjp9w8G8aKygA2SrEtsF4an7HVjEBdhjICrdz/c6oJM
	jArw==
X-Received: by 2002:a17:906:8317:b0:c1f:e5f:4d2d with SMTP id a640c23a62f3a-c1f13557742mr204925666b.19.1785062595194;
        Sun, 26 Jul 2026 03:43:15 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:5de5:23d5:d37f:a3e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32c90b58sm517750966b.39.2026.07.26.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:43:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: netdev@vger.kernel.org
Cc: den@openvz.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/1] qede: sync udp_tunnel ports outside qede_lock in the recovery path
Date: Sun, 26 Jul 2026 12:43:11 +0200
Message-ID: <20260726104311.1782900-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A TX timeout on a qede NIC that has VXLAN/GENEVE tunnel ports
configured wedges the rtnetlink control plane of the whole machine:

  NETDEV WATCHDOG: ens6f1 (qede): transmit queue 2 timed out 10226 ms
  [qede_tx_timeout:586(ens6f1)]TX timeout on queue 2!
  [qede_recovery_handler:2665(ens6f0)]Starting a recovery process

The recovery path deadlocks on the driver's own mutex:

  qede_sp_task
   rtnl_lock()
   mutex_lock(&edev->qede_lock)        <- taken
   qede_recovery_handler
    qede_load
    udp_tunnel_nic_reset_ntf
     __udp_tunnel_nic_device_sync
      info->sync_table == qede_udp_tunnel_sync
       mutex_lock(&edev->qede_lock)    <- same task: deadlock

The mutex is not recursive, so the kworker blocks on itself with
rtnl_lock held, and neither lock is ever released. Every task that
calls rtnl_lock() afterwards (ip, ovs-vswitchd, lldpad, IPv6
addrconf, sshd) blocks forever while the node still answers ping.
In a vmcore from an affected production node rtnl_mutex.owner
decodes to the very kworker blocked at the innermost mutex_lock()
above.

Re-sync the tunnel ports from qede_sp_task() after the internal lock
is dropped, still under rtnl_lock as the udp_tunnel API requires.
This mirrors qede_open(), which calls udp_tunnel_nic_reset_ntf()
under rtnl without the internal lock.

qede_recovery_handler() now returns whether it has successfully
reloaded an open device, and the caller re-syncs the ports only in
that case. This keeps the old gating exactly: a device that was down
or a failed recovery returns false, as those paths never reached the
udp_tunnel_nic_reset_ntf() call before either.

This was the only user of the qede_lock()/qede_unlock() helpers, so
remove them.

Fixes: 8cd160a29415 ("qede: convert to new udp_tunnel_nic infra")
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 44 ++++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index cb0ae0650905..7ed17faced54 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -107,7 +107,7 @@ static void qede_remove(struct pci_dev *pdev);
 static void qede_shutdown(struct pci_dev *pdev);
 static void qede_link_update(void *dev, struct qed_link_output *link);
 static void qede_schedule_recovery_handler(void *dev);
-static void qede_recovery_handler(struct qede_dev *edev);
+static bool qede_recovery_handler(struct qede_dev *edev);
 static void qede_schedule_hw_err_handler(void *dev,
 					 enum qed_hw_err_type err_type);
 static void qede_get_eth_tlv_data(void *edev, void *data);
@@ -1043,21 +1043,6 @@ void __qede_unlock(struct qede_dev *edev)
 	mutex_unlock(&edev->qede_lock);
 }
 
-/* This version of the lock should be used when acquiring the RTNL lock is also
- * needed in addition to the internal qede lock.
- */
-static void qede_lock(struct qede_dev *edev)
-{
-	rtnl_lock();
-	__qede_lock(edev);
-}
-
-static void qede_unlock(struct qede_dev *edev)
-{
-	__qede_unlock(edev);
-	rtnl_unlock();
-}
-
 static void qede_periodic_task(struct work_struct *work)
 {
 	struct qede_dev *edev = container_of(work, struct qede_dev,
@@ -1094,6 +1079,8 @@ static void qede_sp_task(struct work_struct *work)
 	 */
 
 	if (test_and_clear_bit(QEDE_SP_RECOVERY, &edev->sp_flags)) {
+		bool reloaded;
+
 		cancel_delayed_work_sync(&edev->periodic_task);
 #ifdef CONFIG_QED_SRIOV
 		/* SRIOV must be disabled outside the lock to avoid a deadlock.
@@ -1102,9 +1089,17 @@ static void qede_sp_task(struct work_struct *work)
 		if (pci_num_vf(edev->pdev))
 			qede_sriov_configure(edev->pdev, 0);
 #endif
-		qede_lock(edev);
-		qede_recovery_handler(edev);
-		qede_unlock(edev);
+		rtnl_lock();
+		__qede_lock(edev);
+		reloaded = qede_recovery_handler(edev);
+		__qede_unlock(edev);
+
+		/* The udp_tunnel core synchronously calls back into
+		 * qede_udp_tunnel_sync(), which takes the qede lock.
+		 */
+		if (reloaded)
+			udp_tunnel_nic_reset_ntf(edev->ndev);
+		rtnl_unlock();
 	}
 
 	__qede_lock(edev);
@@ -2645,9 +2640,13 @@ static void qede_recovery_failed(struct qede_dev *edev)
 		edev->ops->common->set_power_state(edev->cdev, PCI_D3hot);
 }
 
-static void qede_recovery_handler(struct qede_dev *edev)
+/* Returns true if an open device was successfully reloaded and its
+ * udp_tunnel ports need to be re-synced by the caller.
+ */
+static bool qede_recovery_handler(struct qede_dev *edev)
 {
 	u32 curr_state = edev->state;
+	bool reloaded = false;
 	int rc;
 
 	DP_NOTICE(edev, "Starting a recovery process\n");
@@ -2677,17 +2676,18 @@ static void qede_recovery_handler(struct qede_dev *edev)
 			goto err;
 
 		qede_config_rx_mode(edev->ndev);
-		udp_tunnel_nic_reset_ntf(edev->ndev);
+		reloaded = true;
 	}
 
 	edev->state = curr_state;
 
 	DP_NOTICE(edev, "Recovery handling is done\n");
 
-	return;
+	return reloaded;
 
 err:
 	qede_recovery_failed(edev);
+	return false;
 }
 
 static void qede_atomic_hw_err_handler(struct qede_dev *edev)
-- 
2.53.0

