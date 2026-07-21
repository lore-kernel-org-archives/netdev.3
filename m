Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD031F999
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638685; cv=none; b=jtk7Zu1Uy83UGM9SKkLaVTPBnur4cJic5oJzdoTYX4TspF6TAOlZfoWsSzrq5XpPs63CqICUfgTOPKSuEIrMw6PErjscxw/9Z6AT0O13WIP6faXbF6E2WtUPfx6TIWaPCnD/alYqz8G2k5IH660Wu9Dayd3hA939thIppHhMSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638685; c=relaxed/simple;
	bh=Q4eKJ2ImM8e8lGf2MQNLTSMnqIhXEGtQmzGQpTJQ+ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7pqL7XiF9stvlwpxbBqMhwTJfUSgSdDIYy4rqT7IM76Fnl6EBWpQq4786jTmVb4y88mXHQI2Soy15PdQ4DCRMGT0h6qv/CHHQ07k6SGzha22oC3eAkFOg+p2C0oAT+1CCcRNeKCnZfcg6V0zsJRSH+GHtZpgoO847/g6gPEaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6v1qFWS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6v1qFWS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso129135185ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638684; x=1785243484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+2xZATE9SS7MPQKiwdFFZ9m5kc+pqZTwZJzYBneK4Qk=;
        b=g6v1qFWSqFKwxhc6q3gbQce+l5FVRhc0f749Gqoo2I7GSx+QzMfgGMYc6u/5T6/5WE
         /fACg1M+8SY46W+P7WlSEAb+Egc7A/eL4p/smxaXucFbUiCSfuy67QsNtbXGQLK/wJTD
         Kay5hewMKjv8cfHqQBcAkGTrh0J7x17fMHfVpzfGBDhKCOPr/JQs/w4NdUrY4HmZ/pSz
         me9Ho3qac+HiaZrtmcWRDeIJta/Jg6j4ooG/NYZ0BsKT3pU66ZaQr7i01tMm6fmLB5V6
         siXsYBhyI5q7E1ZOohJZfpTcNHWWicYlKJTNRTE9/9hLxv5GEmtziVLMqsdEewCuyAyu
         JUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638684; x=1785243484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2xZATE9SS7MPQKiwdFFZ9m5kc+pqZTwZJzYBneK4Qk=;
        b=RUP/7tBdegfnyWpRy7VlsP+7CQmmqWP+EKykXEuGM/FPAQ58gQb6tnSP5wtVBnvLSc
         UZMJSch/hIRm+4ANHhvzXmzvaOC3sdRPDY2tuCiqJxZUnzUm0jlrPMzWrOE1A1kBYhic
         39/EJvTRUFv6lRQbBlxx4k1yTZ3YFUsIkndBU84ZZaUK1iauKShn0L/bpaOp6HrQq0G0
         F2lXf2SN317VxB/B8AVmQHWQ2Rq78G+lOARlKLcxgCyB2OqLc8Hmwxa1Smw7GfFOCI4N
         asHYU1NpdYurisSTAsuiSPmJczYmWj/wCwsupKRzFpbhY//zEtPL9Io3D/BuEb3dSnWq
         KgPg==
X-Forwarded-Encrypted: i=1; AHgh+RqrrQjk85Mst56CTN8x38yuI7DeJ9Q+U4pgLEgY00ZTeYuJv5TS7Epkr2xlkAsOU5zDV9GJnpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhBGVHStJd2tZms2PAm5b1UtBQnGt5hRRBjQvcVPFCbznAllp
	ZocM97V1Mut6o3CXWo/U+2UjC8bNNIQxJYkdbN8f+OhkfWTed5Sl9Cw=
X-Gm-Gg: AfdE7ckdXEQl7fvAuVCNYCI51ZyrqCreR22IycRATizHZgDhVt8qWYu3pumlw5VE7XL
	xRl3I5yAulWcNs83wHsJ6bOvCjVuNfk+ty8ATK8CS6ASFyd8HrOVdQ5Sew+Guu5/B0eos4F3v8Z
	tGuY4+9NTjED6tFJae+rD6QwEysV/TN20n0tDruAYe89hd/SVcqIh6SiU+9GT/4GtTWeZppFvUM
	U1sQx5EGSvytiUhQbmhZ8My/TpfhVmw6OnqF2dWmIrQv9htOIZttd8bOvVDJ92bH2w4V9ivHYCB
	+u3GojXVFWHVLeuyzMoQg6H6FORV9jRFngXsWNvCz2GuXzHBP1gW0NeC+zB/HpvFPJC4MvNVuua
	q/0SbEsJwH/52dy4FMcfafE06opnvboiKVXw8rYsQNLmGR6ePgchNGjECtlWUglfmwQZ5lNPV3B
	ILnX2zFdnsLHottiTPTyJvxVYIncb04vXmwRbqUTMqbxYScbNVcEoJ+Aqyq6NaVtE+D8Ci3Z3NK
	NPGFizzutGQ9bKCRNhzZibm7HO5+OgFJTteXOk=
X-Received: by 2002:a05:6a21:a8b:b0:3bf:6f30:1ccd with SMTP id adf61e73a8af0-3c3ad8ecb2amr19867230637.42.1784638683904;
        Tue, 21 Jul 2026 05:58:03 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcb09sm53375189eec.9.2026.07.21.05.58.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 05:58:03 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	kernel test robot <lkp@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net v2] mlxsw: pci: Quiesce EQ tasklet and CQ NAPI before teardown
Date: Tue, 21 Jul 2026 21:57:53 +0900
Message-ID: <20260721125753.35944-1-mhun512@gmail.com>
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
v2:
- Fix typo in napi_enabled assignment reported by kernel test robot.

v1: https://lore.kernel.org/r/20260721062105.55014-1-mhun512@gmail.com/

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
+	q->u.cq.napi_enabled = true;
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
