Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452740;
	b=ybFJ4OGFNOKOFM3XutqMxfrnV+jd2+Sd8NfbB2hA4mQAW8HMlMdqDFfsI5UbeLaY4+Cu
	 TXkNlFmbjx8SMfAx05WcZW2tVrUqdZHr7WaPseNgVUERagAnJDg4kDRqSmUd1yuvkTW6Z
	 rLSlTuiNd6MN5TjbSaZTGhqYRFs4L8me5dZSx5svclDDjmEMf82hqOcDdgHTvziAJmzuE
	 FObRn0BOiyzuj2FS1ZLwLP+C+sNIFMpSJ6jgd+BlY4erdpPG+Gn/5/ccALKeojYyCDR9R
	 i1wp/j1GsXaP3AsW/swSVFnVMuLGTXDlxdR0UVU0xzDOB3L1LRfS1p5LO5PL9hLo31Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IRiEVaj+xrMmJMxJWPuS8a9fcjkcvM/x4QK4LzzqXLE=;
	b=LRhzeF0yeBgfyFAcqYBaaiX5BlaRLLjhOPmV968x+JnlEOIFxTOidigQe2cOr5jNpgOI
	 aMJ8gVrdOHHd+J2yR7BRjNCGAZ45z2FuZbI1DNTT1RORwegIRyhcgIf9xvKhvjqg5MD1i
	 Q1Vb69BbcOgbKeKCoDOyfMmGvt54s6UHDKUpTbUiT1uY/2xzyX65UhiOcUb/LFgQvC7Vw
	 kg7xNH7XXW8rxuyVntAt/uzlZ0k3R1OPl01D35Q0zPQCSOsrcLwJ2PJxB5W4h0OFuiBVy
	 i+ydm+px+57q4ximtprqGRMMSsdgmO+zV7/AugFCbYeeTefwM1C5TO7Ax8sHYUFpZ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S6PxYFm+;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C32606A324
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C32606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S6PxYFm+
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b89c6caffso21126796d6.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792452739; x=1793057539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRiEVaj+xrMmJMxJWPuS8a9fcjkcvM/x4QK4LzzqXLE=;
        b=S6PxYFm+iUtRMxFmdhVnkCw52M6EyiRN/zeT9KamijIqsnTa9Ix7VeBS+6hP86l5zX
         nXveiZoBdUggyR227OB01OWWyLggLTfRyG2U+9k7LtHisxfwKTQ/e40Uw4jzN+iEPyPF
         GSRqHMXGjV4HWi5+jkx0g3vMeEnMnKF6ZWrRFi3+dOsXcgkOYrtXEeVfAj/8Jh2pnjZ+
         PZwr/EKL/1/JMChOtt7MV6xjnMutfmV2NNFosy7brpXdwX5ENyjewVhBi0iEp4geVm+3
         oR/70t50ceLK8XdO0r1gRUgi7S+pPV7AdHUSlAZmpQ+DpqqAknTl/HhJCQRGyKoki0M1
         i+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792452739; x=1793057539;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRiEVaj+xrMmJMxJWPuS8a9fcjkcvM/x4QK4LzzqXLE=;
        b=S8aVzcaxV0Tzkx4+v8gQB/T3xF17D5mBVfnbfN78wS6cA0ZAu0m0ukHfpRzgWiRbz8
         tgAN5HGfd8yp5OQGN2NH0ut54lFQQGuvJzEC3yO60/IYabnKB+1YkxuKz/EIyZWWBQJO
         SVjbxJ6vKL6uYPsE6aEbeR/3EJ34qx4/zA9lrrAlWEM44qy8kSSVBIdhOWynTc+FJ5rO
         s4hbwYi+p3FmIaj4/3H6r0o8eMpdHUeK0aLDeQoHj4RFpHlEtvOphdsuRX0XotmQ6QfE
         dNU1P8SFWfAy7ujTmKVGZzpXvGucT/kO4p7GVdmliOKloQ2OrMU9VZ8ES7q9Mbw/NNZg
         YHig==
X-Gm-Message-State: AFq9FYLwA/kneYk4Yz3YdOVa94JymIIUUjoKVLK+DlcDla+KiPqHz2kF
	BptQNx/K1IObtv4+lpyA86lt3rDegN2jZ6OVCG/oeDCSlMXRq75u+VJK7qm+pH0=
X-Gm-Gg: AYBFou3gL846xJBxyqb0FvzOF36DF7OQGNJuyVAXIvzdSkVS3iJtVo+Q0LRGcJixPuj
	W7J/xGl8uYif/JFcqd+15RzbBEOcc/zckr7r6PabVQwr9bCMUAXdA7HV8Fp3UcXsDxvGf/8BCNi
	yfAjin6ua/XTJglW2lAPCY/r1GvJNzfpTTbunKeEelv25iTxtuATTJhRLspQaeZsQYlKHIl9+4E
	XMWjk+2MBXGxcBrCNzRECTNIgr1gJJnvutn3bLCZdpkcXidQ6MhFjc25vfKfChc8S78D3qrKD+D
	G/2kX4JDN5KoOCWVyGk3owgkGt4CspmMUJ5rxSrnM1p46Qqv048N2k2HRKS4uhKh6J2vr4io3y6
	gYJkXot65An4ToIJ7DNAvALFNkQMxV8BRvFu55NS41VRl+Hw3RGZCB65m4HZWRuiOQfEmgmd9p6
	tPv/78EwRUlui8eA5r1UaKZkm6bxtOt0CvbRyXNkOeDc/xnAULPb5r0pSMQI65i4VxB5oTvhsGa
	PeCBSzxXmasZwY4pzM58gLuIgNdkFONrfS+QioFqDVPsKxGJ/es4Xg9CaiR3fMB9C3GVWa6If7w
	s3Qlsj66Mz9jiaX/y/xylDdrBmeh
X-Received: by 2002:a05:6214:509e:b0:91b:d5d7:8c81 with SMTP id 6a1803df08f44-91bdec36aa2mr166266396d6.7.1792452738813;
        Mon, 19 Oct 2026 16:32:18 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c04092870sm9428006d6.23.2026.10.19.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 16:32:17 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net v2] net: hns: stop service work before device resource teardown
Date: Mon, 19 Oct 2026 19:32:13 -0400
Message-ID: <20261019233213.792821-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hns_nic_dev_remove() unregisters the netdev and releases ring and AE
resources before cancelling service_task. An already running service
worker can therefore use the released ring or AE handle.

Set NIC_STATE_REMOVING before teardown, join any in-flight TX watchdog
callback which could have passed the scheduling check, and shut down the
service timer before draining the work. Drain service_task before
unregister_netdev() and resource teardown. Call cancel_work_sync() without
holding RTNL, since the service worker may need to acquire it before
completing.

The service worker already takes RTNL for hns_nic_net_reinit(). Recheck the
DOWN, REMOVING and RESETTING flags after taking RTNL: ndo_stop() may have
run while the diagnostic dump was executing. Leave hns_nic_dump() outside
the RTNL critical section because dumping all device registers can take
a substantial amount of time.

Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethernet support")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
v2:
- Keep hns_nic_dump() outside RTNL and recheck state under RTNL.
- Drop extra RTNL locking around the link-status update.
- Leave notifier cleanup in its original location since the HNAE notifier
  does not directly queue the service work.

 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2035,10 +2035,17 @@
 		    (type == HNAE_PORT_DEBUG ? "debug" : "service"));
 
 	rtnl_lock();
+	/* ndo_stop may have run while the diagnostic dump was in progress. */
+	if (test_bit(NIC_STATE_DOWN, &priv->state) ||
+	    test_bit(NIC_STATE_REMOVING, &priv->state) ||
+	    test_bit(NIC_STATE_RESETTING, &priv->state))
+		goto out;
+
 	/* put off any impending NetWatchDogTimeout */
 	netif_trans_update(priv->netdev);
 	hns_nic_net_reinit(priv->netdev);
 
+out:
 	rtnl_unlock();
 }
 
@@ -2397,6 +2404,18 @@
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hns_nic_priv *priv = netdev_priv(ndev);
+
+	set_bit(NIC_STATE_REMOVING, &priv->state);
+
+	/* Join any ndo_tx_timeout() which might have queued service_task. */
+	if (ndev->reg_state != NETREG_UNINITIALIZED) {
+		netif_tx_lock_bh(ndev);
+		netif_tx_unlock_bh(ndev);
+	}
+
+	/* Stop the timer producer before draining the service worker. */
+	timer_shutdown_sync(&priv->service_timer);
+	cancel_work_sync(&priv->service_task);
 
 	if (ndev->reg_state != NETREG_UNINITIALIZED)
 		unregister_netdev(ndev);
@@ -2415,9 +2434,6 @@
 		hnae_unregister_notifier(&priv->notifier_block);
 	priv->notifier_block.notifier_call = NULL;
 
-	set_bit(NIC_STATE_REMOVING, &priv->state);
-	(void)cancel_work_sync(&priv->service_task);
-
 	/* safe for ACPI FW */
 	of_node_put(to_of_node(priv->fwnode));
 
-- 
2.52.0
