Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE483019D8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623951; cv=none; b=FEe5ewIXNP9OVL+sHCyjaVrtUYqb2k+WzO4llFrVprQXPK+ByJBIgGFrVbJP7uJpq62DCZ2H5eh7eEIL/eFTA8ox/yjqtNc6Q8Ivk3TTZToF4qanGnLOSYQv3D5dSdktXNK/qLBLTRc2s33c72ZenB3Y38bUsp1B8FAMDT0C8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623951; c=relaxed/simple;
	bh=umCgMUKPQPll6S43CofHLcyYoPkxfOBRKdMbZYySOTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKTNhD1sUFOVcvgD1u6qv5EPLRElLvrFuNx1NTYij07KZ3dmjIi5WHG3Q21t1rLZEcLhx4i3xcc6OT/pCtPvR/aE0H50/9f0dMQpu/tN1GlQNim/ITGVupRNa6hpipU50OTI+FJI1KN8jXDsDfjrY6OZ9e6VthV2v5fSz62RnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ful83ZpO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ful83ZpO"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso3454460a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787623949; x=1788228749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuFfc3mYGtCYXOj2mOxxwwBg8bUodS6/wtLWaXsVGqs=;
        b=ful83ZpO12cbUqyRo4o1fJbLdDzuLvz7iiueFvgSOT2WQi1X1qBTBv9hTMsCe5/xKD
         R+2W1p+85PZH/PPVRVl9MDThxP/RWiHB6KLpx6dwsN5cY0RK7scgCKjQd1aXFvCXcBA4
         unavskMoZ6VpbHOiWewV3dpbmgAVL6oz4vau5ZyLPLiEu6Qshj11TwNKBL2A4C9exRja
         ujVjcQA/YWdkwiaESjYABLCJN1/xC/Y+7bn4a6KBvX74Hwgf2MM7UxP7B+IRV5cAA4Kg
         5SYLX7SNTI5pgCaT3WKlXwIs3etdSQznQh6wtdfbbdcLhheYAHyVJdfH78RtZTmoEx2v
         FE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787623949; x=1788228749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuFfc3mYGtCYXOj2mOxxwwBg8bUodS6/wtLWaXsVGqs=;
        b=lJ6H/GJhwtHIPVRkB5Cyf6XAe/pIFpBkJ/5f2CbwzCupE2lJ0V5u1cbkoVS6Hk/yMR
         OUGfx2I6Rm3ge79rlgehr/HatswLcNMubaUmFTsTNpPWot6Wo8DpxvOl79Kp3LeBN0fb
         mcaYXj4S4Go6NQA4odhv1KuY4YalqoXI4hmE8l73KaPoi+QH9L/zeoPl02wLM5B40bVG
         uLCJws/pDzAojL/CFBGQuXuwpTDD2wfk0uGNPPsASeRZEkpFdwCnNtB2K4QTDvFmAzgZ
         2VHpqVfuGlDYZldyTt5BBdAutri3X1vbEm4dSXr7LsE+LrHBzJcVfZCSmbI57Adjlghg
         tTow==
X-Gm-Message-State: AFuF++lL7Ee4Eh60sig8FPZW3vrBI/6wk5JADsbH7y04/AhWDtHFcIPz
	AAvZjlSy5OToTztbod+i4XK49J3V5n8yVi+nF0kCAK9fK6dNXqhTkEY12iyNL2c0/UzSpA==
X-Gm-Gg: AR+sD122Fu/tYk7A9/s+Q24uTN/py6IoNDxX/s5gXYP9kfdoSj/o35e0genPJjSlwAz
	VhFbFpgf0E2375vrT/6qawsgHWLVpRjTMFBJnjh2yzYMBjti+tlY5v737WTUfS+G0yhJI2k8OAF
	fHi5QjnWulmZw3YAYXyVZRrM0ZMPwMiicar9iyPPlld6y4faaXFq0Gh1MtGMi5wZ/SmYBET0KJe
	AYkujn3RjBOnQYAg17Txx3MLZE22S6rLooysVpfZUtXd5RfZtxkRCFIp1bpgpV5N5ldFtGDoHKZ
	EZrMFlytbnBqFN1ncJGKb0AGh0EFFKKx832C9CkzWdj9IksmcedUnqab55ZEEvAoCn+rG8oE9kT
	nPhgFuYL2pBSrp1cGWlZFxJLkB8qwRX4eKNA7xecyXIH7jRXCAzlmmP0r20nSZIwIyW8N6jL17Y
	O5EDAIU21bVMjJo3/UF47Ue6QEouqJ+dsLD2SHVbhKbuGetPm7qVTFYXt3f/IjyBQMf/tioA4Y7
	Kohi0PQ/7iDc+w9S9jrDP0CAw==
X-Received: by 2002:a17:90b:55cc:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-395c334042emr62141979a91.1.1787623949022;
        Mon, 24 Aug 2026 19:12:29 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm1706996a91.10.2026.08.24.19.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 19:12:28 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: netdev@vger.kernel.org
Cc: Allison Henderson <achender@kernel.org>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: rds: fix uninitialized trans dereference in CM event handler
Date: Tue, 25 Aug 2026 10:12:23 +0800
Message-ID: <20260825021223.3483044-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

rds_rdma_cm_event_handler_cmn() assigns trans only when the RDMA
device is an InfiniBand CA (RDMA_NODE_IB_CA).  On any other device
type, e.g. an iWARP RNIC such as siw, trans stays uninitialized, but
the event switch dereferences it: unconditionally in the
RDMA_CM_EVENT_CONNECT_REQUEST case via trans->cm_handle_connect(),
and (with a connection context) in the ROUTE_RESOLVED and
ESTABLISHED cases.

An RDS listener on an iWARP device therefore crashes the kernel as
soon as a connect request arrives: with CONFIG_INIT_STACK_ALL_ZERO
the wild load becomes a NULL dereference at offset 0xa0
(&trans->cm_handle_connect) in the iw_cm_wq workqueue.

GCC masks the bug in default builds by folding the uninitialized
load into &rds_ib_transport; Clang-built kernels take the real
uninitialized path and oops.

The iWARP transport was dropped long ago and IB is the only
transport left, so make that explicit: initialize trans to
&rds_ib_transport at declaration, drop the conditional assignment,
and reject events from non-IB devices before the event switch.

Fixes: dcdede0406d3 ("RDS: Drop stale iWARP RDMA transport")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
v2:
- Enforce the IB transport directly instead of NULL-guarding trans,
  as suggested by Allison Henderson.
v1: https://lore.kernel.org/netdev/20260824111701.2979194-1-ljp1205831794@gmail.com
 net/rds/rdma_transport.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index b15cf316b23a..2c5481f1fcb4 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -52,7 +52,7 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 {
 	/* this can be null in the listening path */
 	struct rds_connection *conn = cm_id->context;
-	struct rds_transport *trans;
+	struct rds_transport *trans = &rds_ib_transport;
 	int ret = 0;
 	int *err;
 	u8 len;
@@ -60,9 +60,6 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 	rdsdebug("conn %p id %p handling event %u (%s)\n", conn, cm_id,
 		 event->event, rdma_event_msg(event->event));
 
-	if (cm_id->device->node_type == RDMA_NODE_IB_CA)
-		trans = &rds_ib_transport;
-
 	/* Prevent shutdown from tearing down the connection
 	 * while we're executing. */
 	if (conn) {
@@ -80,6 +77,12 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		}
 	}
 
+	/* Only the IB transport is supported. */
+	if (cm_id->device->node_type != RDMA_NODE_IB_CA) {
+		ret = 1;
+		goto out;
+	}
+
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
 		ret = trans->cm_handle_connect(cm_id, event, isv6);
-- 
2.43.7

