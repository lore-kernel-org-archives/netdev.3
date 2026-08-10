Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F939280D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338892; cv=none; b=nFy9l6Qhql/K1dVf/zWSLCbL64A8Cr16z13qIxWmLW3vmg/rl3i7W5FB669OO9UhvgjuuCHrSG8lLJw0XoscWov92Jvo+Hn6ctTYeuyzDU51v8qsRI0JKhLIebyLOGl1yoRrILwG/QTtSm14Rw9X/PmrYnuZozThdnWpARwDRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338892; c=relaxed/simple;
	bh=TdqKv4AR3ujsrfYlJSXQ6iMaxL+M2xxzqdbZIkMOBfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UklwStM43z7U9t18rfI+dAmtrmTNmiXJI3ddKpt7w1o5z6Lpw9CGriLW3HJ+sjbRHAmwMBxN5qErJqTepWScJdHc48f+xKBlZf51DinFBIfScLZMZh0/5n0iFYV+yCguy3sA6xzFoGAigpVMbYuuRqhDxK7BcwF5nrcfDBDiDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z/DOPfwm; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z/DOPfwm"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1234152a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338890; x=1786943690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgOAjlgnikFE8HrjXq3c7NQQl99d4WlFZ/JkljMrzs8=;
        b=EkT0q5lw+Uw4BsMWQ7MDv/bEMuSrF6O0aWrJ9RkilAPZEGW9vmrMulpTtXlc5PfAoA
         IoagrdzKbaujHf0FlKRmVBoLz2aCEtI47vT1Ab/Jqiuhq2GgvW8DkKkNOKbpEuUIWbhB
         cKt/gcUw8n8Q/bSszunmb9yArpNre2yu+xz4gDKKxT/5eWcJ+Jb9CahR/QaA+65WcMnn
         48FzGWkaBJpRK0PLsTZrT5ptDny4wfnBNr4gWLagq3vPUzZJzZFxdgFfDWF5GzGdge/z
         2JuCxDJ43KpRKyTJcJoVheccE31qDciVrHfgcV2AMT64DjMuSnz/A281WoF/SF6JmNfX
         ElFg==
X-Gm-Message-State: AOJu0Yw7gp5f7OVbnbUA0G2gAqpAP8Wh3xuyGbYUVgem8hRlmCxSz8Cn
	BzVQv/uV+6nJ46dvBQp108h7g3qK5CnlAGtvU003jM4rL13jFbh4Cj6pc1bSmacv7Q6Btwiun4J
	Z5wZsN7KjKkiSwJDtIWedbPAXywe0rsJqyqUHsFUpOkh8JKsSEU5DUrZ7LfvdTUw9mZkdpfwmOG
	7ehuCMtXE7p/aJpVvjwkoEbJ7t6vOXwRzm8gCal7HPWEAAjb2/ghzuPkebJBBvqpb4MVeatOQ83
	2YihSKv5II=
X-Gm-Gg: AR+sD10cb1MqBqqlusTM7oQcHskrF76UOMXdQRDfWwXvlN+2FyYm2tUZ0ff0nSZHMlL
	Jni6KM8nfoKw73e8GMwK5dBBCQSoWir31Er7jwAoGusqN96IlAcojKkXd0axgKx/vUsEUBLl9LH
	ct0oTlWMMYhUZXQeaeOOd/RdNcgn6vzSPuAWH4K1xHXyVDL1WvD6pcbfcJoowvKXmvEWn3HNM1r
	V8t0p4N5CmyytytxmXjFAxJcAaKSOFsIFgDy8dRHHTaSFdpdD1QaGMNRodAkhjKLdJNaSYVNta6
	V+0hWu3T8fI0caHN/I8cjFQJWri4HEmblDwaN8BxLy5+CE59wZqv6hqgY4GZ7PRHKen7XgxusLu
	oeapb54Z//NLJLtoy96ITjkxiwW3PjRthZBJB+NYa9d/8nYGs9sfHSlDZucKo42SOPCj49p7PSM
	I2G/6Yzy+1s7ctiXOvfMP6CRA25BjSFoEJHko=
X-Received: by 2002:a17:90b:5112:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-3903c5919c4mr42228984a91.12.1786338890065;
        Sun, 09 Aug 2026 22:14:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3925fec93a9sm4925076a91.5.2026.08.09.22.14.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso13528121cf.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338889; x=1786943689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgOAjlgnikFE8HrjXq3c7NQQl99d4WlFZ/JkljMrzs8=;
        b=Z/DOPfwm84obpOCGOgKU3dsfOoKB3Z7oOi4zd6ZidiKN9T8H3ghUlAk3JVgmer/sN0
         trrplcE1dpAGICh5sLS92yiTSibjKvdE7gdfzVdBm0haW/paOLyK+FApPhHeubv107hF
         LZEbRIKqUNB9pNujKIHesCV1hJ+VedFYamsHg=
X-Received: by 2002:a05:622a:4811:b0:519:f420:d780 with SMTP id d75a77b69052e-52ce6143784mr452864441cf.30.1786338888885;
        Sun, 09 Aug 2026 22:14:48 -0700 (PDT)
X-Received: by 2002:a05:622a:4811:b0:519:f420:d780 with SMTP id d75a77b69052e-52ce6143784mr452864121cf.30.1786338888299;
        Sun, 09 Aug 2026 22:14:48 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:46 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v6 04/15] bnxt_en: Rename xdp_tx_lock to tx_lock
Date: Sun,  9 Aug 2026 22:13:47 -0700
Message-ID: <20260810051358.1244418-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810051358.1244418-1-michael.chan@broadcom.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

xdp_tx_lock in struct bnxt_tx_ring_info is used to serialize
XDP_REDIRECT on the same TX ring.  MPCs will also need this lock
for a similar purpose to serialize sending multiple messages on
the same MPC, so rename it to tx_lock.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6946ddfb0c63..c50be51139a3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4154,7 +4154,7 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
-		spin_lock_init(&txr->xdp_tx_lock);
+		spin_lock_init(&txr->tx_lock);
 		if (i < bp->tx_nr_rings_xdp)
 			continue;
 		if (BNXT_RING_TO_TC_OFF(bp, i) == (bp->tx_nr_rings_per_tc - 1))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 779162f6893c..7d3311f10ad5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1014,8 +1014,8 @@ struct bnxt_tx_ring_info {
 	u32			dev_state;
 
 	struct bnxt_ring_struct	tx_ring_struct;
-	/* Synchronize simultaneous xdp_xmit on same ring */
-	spinlock_t		xdp_tx_lock;
+	/* Synchronize simultaneous xdp_xmit on same ring or for MPC ring */
+	spinlock_t		tx_lock;
 };
 
 #define BNXT_LEGACY_COAL_CMPL_PARAMS					\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index b485e4d9b26f..d1873124893a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -352,7 +352,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 		return -EINVAL;
 
 	if (static_branch_unlikely(&bnxt_xdp_locking_key))
-		spin_lock(&txr->xdp_tx_lock);
+		spin_lock(&txr->tx_lock);
 
 	for (i = 0; i < num_frames; i++) {
 		struct xdp_frame *xdp = frames[i];
@@ -377,7 +377,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 	}
 
 	if (static_branch_unlikely(&bnxt_xdp_locking_key))
-		spin_unlock(&txr->xdp_tx_lock);
+		spin_unlock(&txr->tx_lock);
 
 	return nxmit;
 }
-- 
2.51.0

