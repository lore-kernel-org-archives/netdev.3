Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1512FF669
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614876; cv=none; b=NervLFMwqtR0DDq4LEeM66/UEMBf50RU+QMeOEEvcv03QDT+z/D6BQuApe5YlBA+SaXQdky53zPTb3xu40n/iXqO279jIUOehltXUDtJn/UjktnNrR8/Twncwoqe4N7ojuorqei9+lUS9/T9CxYJ5/9r4gItRCJm6muBEXVetMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614876; c=relaxed/simple;
	bh=Z5JtswQaHr1Y7GmBpKLV/7trzctnR3N3Z+5orguOzWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufA1GzxATn6GjPpdGGNUScWBAnStAcb7waqzAj2U14lOT2Uekqh5GohMS93XGMUcUQrD4cY9zOS1Nudjd7AwXhD66l5cTMPjffkbGRGXulOBOn14Gtxs5nBy4kBUwfvh1j/mUSsKfjCdHIZQseoUx9hdtl8eKQ9yUvswoBIEZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmkp+bax; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmkp+bax"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485b358552so11785881b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784614875; x=1785219675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jozBZSV92V3+3MNH1S/1bqlBdEbp9HS15y2+rq2hqt8=;
        b=cmkp+bax3sLzMrPbQzoRKz2RfrJiVq98Un2c5da2i8Eqn6CYm5dvn4N8w4u9B/NkA3
         yGekHVvVs92B2IccyjfD1O0vHxWryNJSYiQ07FSMwErb4El2sI2S7c+/klTENzSawmq+
         wsPhVxcuzYwt6b+8w1+5Qx33TLvkwM8ZqHBJVYWglT6jgscdICAtKdIPDxB/iDEwDgd5
         edBRo/knxsFELoNxwSCfaxWzjFGHUjvShBeuAWpHarDUB+dBfzmiz6lr4Ez0JP0bSSm5
         rEmifAnMuKmlyoMuYltR6VZ4xv2aVFLURuVprXfOYwH1867PQ4bwrOf+Zc/r+jQIYWZY
         uPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784614875; x=1785219675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jozBZSV92V3+3MNH1S/1bqlBdEbp9HS15y2+rq2hqt8=;
        b=sTFOoZcgCvEYZyscQAl4XZTYwmtvXlvKNp5AF6xUBFZZTHfmbcRaX0oxlu34rdpwFd
         p/IN7H3SEgRI2j7bMmq5j/50pxJ8nQ6G9QYvCemIKuaKFsqWuz+m/g9r+REWttNQoOA1
         xXlojYqrE/DE3Zrog/dNXHfxf0j10J/Q+IgK9H8IhssDO037Mk6StQWDkjsIJ59rgbNS
         omyY7vFOyHsjk8IxOPt+t3PfYNZ9m3VU+wYY6YWJ0OxeWzAfOEuzNd3x/kzNlMX0/Fn0
         XViGuzIf6tsDrei3WqPMSDw04k3Q94YRs/FltEqYmh/bqqxkYPNlmvcrNdvglcrZa3C9
         I2ug==
X-Forwarded-Encrypted: i=1; AHgh+Rrw2H+6TOsB++FY/m152Z/STbffb0QAYHywG91KzMk3GttqNnFAxqr2tb8EbwhkwgKhNNJiCiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0iemuHjLPNa/XgzmZktDz8BTx4HzzW7HIJtkwm/bNgiVCzB5
	SUK50ijNbOEKAceTwYlwLY6ZkIQpHEaPQBurh7h+yJkt4fyTfeLzxMo=
X-Gm-Gg: AR+sD10d0Mbqe3s43EZ4jiklRlnU08cTtgO4hAcAuV2tbCByZrFAMj6ptp6kUX9L6dt
	HoWO9FFNCgU1R+jG+QRojVJpgoobWg81xT6y+QVvnhUWDEKFvIRgCbsbqQJyOYtXfnosHqcS2+v
	VqulT3NP2Zt4AM8TyOkT9047+r3ugcu8Ad203JP/kDCie1cHNmqe41GWYZO/gfaAgua/o3Q3B/J
	gY0uOFUbmOWGyr4Zz49KFNcPpMiztdzuJtgKLpwWXJfJ5UcyYWaOH/klnp2OD/4RIb17DmaQCwX
	4LTEUPzW/4SxvDtC3Hsg1Ij35UB4E/d0lumpde+Nrpg5iyQ6/1pGpOnLZHdfbghheX26YUNr6Oa
	RmhJbjYR8sk/Q3EFKiwlcIv54l8GJdKdYO+FkmrtCWIjGxjF91sTZVmWpRRv89fSll/OnKRrAsG
	me15Vl9JeNpTLnG6gfXwMl0aM0of8HOMRLXQjgUhmZgOs5hSxB4fJzmW2HIMUotDh8jxdWevPHi
	/242/zaIGP7Y8p89NaMEqckeKfWL0FTTZlvuLO/
X-Received: by 2002:aa7:88d3:0:b0:845:c0db:3924 with SMTP id d2e1a72fcca58-84c2928b6a4mr16155187b3a.24.1784614874820;
        Mon, 20 Jul 2026 23:21:14 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c4b640050sm4017004b3a.45.2026.07.20.23.21.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 23:21:14 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] mlxsw: pci: Quiesce EQ tasklet and CQ NAPI before teardown
Date: Tue, 21 Jul 2026 15:21:05 +0900
Message-ID: <20260721062105.55014-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlxsw_pci_eq_irq_handler() schedules the EQ tasklet. The tasklet reads
the EQ ring and schedules CQ NAPI instances. The CQ poll callbacks, in
turn, dereference the RDQ or SDQ associated with the CQ.

mlxsw_pci_fini() unregisters the IRQ and immediately tears down the
asynchronous queues in RDQ, SDQ, CQ, EQ order. free_irq() waits for IRQ
handlers, but not for a tasklet already scheduled by one. In addition,
mlxsw_pci_cq_fini() disables each CQ NAPI only after all RDQs and SDQs
have been freed. A pending tasklet or NAPI poll can therefore access
freed queue storage.

Kill the EQ tasklet after free_irq() so it cannot schedule any more CQ
NAPI instances. Disable all CQ NAPI instances before freeing the first
descriptor queue, ensuring their poll callbacks have completed. Track
the enabled state per CQ to avoid disabling a NAPI instance twice when
the CQ is later destroyed, while preserving the partial initialization
unwind.

Fixes: eda6500a987a ("mlxsw: Add PCI bus implementation")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Found by static analysis on v7.2-rc2; not tested on hardware.

 drivers/net/ethernet/mellanox/mlxsw/pci.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0da85d36647d..feeb32134d2a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -86,6 +86,7 @@ struct mlxsw_pci_queue {
 			enum mlxsw_pci_cqe_v v;
 			struct mlxsw_pci_queue *dq;
 			struct napi_struct napi;
+			bool napi_enabled;
 			struct page_pool *page_pool;
 		} cq;
 		struct {
@@ -989,6 +990,15 @@ static void mlxsw_pci_cq_napi_teardown(struct mlxsw_pci_queue *q)
 	netif_napi_del(&q->u.cq.napi);
 }
 
+static void mlxsw_pci_cq_napi_disable(struct mlxsw_pci_queue *q)
+{
+	if (!q->u.cq.napi_enabled)
+		return;
+
+	napi_disable(&q->u.cq.napi);
+	q->u.cq.napi_enabled = false;
+}
+
 static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
 				       enum mlxsw_pci_cq_type cq_type)
 {
@@ -1064,6 +1074,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		goto err_page_pool_init;
 
 	napi_enable(&q->u.cq.napi);
+	q->u.cq.napi_enabled = truea
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -1078,7 +1089,7 @@ static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
 {
 	enum mlxsw_pci_cq_type cq_type = mlxsw_pci_cq_type(mlxsw_pci, q);
 
-	napi_disable(&q->u.cq.napi);
+	mlxsw_pci_cq_napi_disable(q);
 	mlxsw_pci_cq_page_pool_fini(q, cq_type);
 	mlxsw_pci_cq_napi_teardown(q);
 	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
@@ -1439,6 +1450,14 @@ err_cqs_init:
 
 static void mlxsw_pci_aqs_fini(struct mlxsw_pci *mlxsw_pci)
 {
+	struct mlxsw_pci_queue_type_group *queue_group;
+	int i;
+
+	queue_group = mlxsw_pci_queue_type_group_get(mlxsw_pci,
+						     MLXSW_PCI_QUEUE_TYPE_CQ);
+	for (i = 0; i < queue_group->count; i++)
+		mlxsw_pci_cq_napi_disable(&queue_group->q[i]);
+
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_rdq_ops);
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_sdq_ops);
 	mlxsw_pci_queue_group_fini(mlxsw_pci, &mlxsw_pci_cq_ops);
@@ -2089,6 +2108,7 @@ static void mlxsw_pci_fini(void *bus_priv)
 	struct mlxsw_pci *mlxsw_pci = bus_priv;
 
 	free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
+	tasklet_kill(&mlxsw_pci_eq_get(mlxsw_pci)->u.eq.tasklet);
 	mlxsw_pci_aqs_fini(mlxsw_pci);
 	mlxsw_pci_napi_devs_fini(mlxsw_pci);
 	mlxsw_pci_fw_area_fini(mlxsw_pci);
-- 
2.47.1
