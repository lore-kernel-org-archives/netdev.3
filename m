Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768142;
	b=08l5XStKGcBt0b0UUvwiadB00GoLkfZJaRPCIihsqnWV3On0XVtmZ9Obos5orGUdpo9z
	 9IQcWiedmlK0rQ8zYN4GZlqzjiMi4YY5JAPnnB7pGATgUlmN+sng/T28aAySh4FBfFY8F
	 z3RhCJ9HBIQTIcSJVNI+jDLwbUweZS7DE/wnLRkgGuVcipvXGpFBwHiXT7eQHJXE5Rw43
	 YXLAQ8e1GkOt2NNolzFwfnhRsZbGJIwRzkbSrrCWcZWE092oQ+tMNqWcVOB2EK+yqsgc0
	 iL9gCVLeoTcM2fdnm1I6K0sEkitW3IvaUmd2X3k6zVpuLuGq88+e4ea+t+8uQ/CmbsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fyg2Lfr0HdPSioS70GnDwBHK6gsJqmKsD2MC7JLmcRM=;
	b=0toaoL2cQhKo4yZ/YuibES2hHNED5M7kjNhKEvRESCRukpUqWb4qnTMDeMctVAd9Vxh6
	 8eQJYuuBBd5uzzN+qGUaNsv/baS2BqlI4PD/uUfShHyXxm06jRuJZM8472uj/iWVXGDAu
	 MNkTX5d9KKAqwpubgvd1T65ZwVCGcGnEis1Dza9tmdIslTGhL7LnY7788fwx6x7+sK2xS
	 klHdhlVp5h7WeGS2Yqtift8zDgTUhL2643+i2sMmQMvp4welY41pbpL2WZgitjo27WEv9
	 M36o8gcqEEPQ2OHn492r1g/uyukAaSJpltKW50Vmo9eK9sTA3Sohl3IM3nefQALiWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kXv71ivi;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA05606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 04:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA05606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kXv71ivi
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b0d864826cso1227002c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 20:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793768141; x=1794372941; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fyg2Lfr0HdPSioS70GnDwBHK6gsJqmKsD2MC7JLmcRM=;
        b=kXv71iviNlO9l3Zi8g+QxMcbDuwwUsRuZODaQ2rZ+/NM5M/bib5aimbNDl3aiEp8w5
         OlZfTQ7zXOOnIGkgkekaUgryL2hAaq85NWVDD9sdxFGwgITX7vEgyOeGYefO23oT5vO1
         nrNGP+ouIcCrYoiSKCW9xgq45gk/psOHpFhYnkbvw1nJePfnEhFIy4jcBodQgGv6qjGB
         0edgErj6a+7+O8xZis7ObiYOQSnxH5JZTIsWZWIM/tw7L1RX8jkkjbXvm7uKBBxsleGC
         MgvtC7CUsmkucup3Xyw63LPYFlr216/SSqw2nWYgv3m6JIscQEJm0X1lMsUeHqbgWPrX
         lCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793768141; x=1794372941;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fyg2Lfr0HdPSioS70GnDwBHK6gsJqmKsD2MC7JLmcRM=;
        b=SY7ia0WP2hr/mTaZoHI0FdKUV1FQav+GUktbeE9YbV8i5bU8K1ejEtSW4giSBJYHWE
         ajTdyuwqhxi3MqFDhG35V7Y1wA4fqy/QcsQgxDz0n+KnySf1PhkkLxWE9NT2k3ARC3ZI
         0eIrmlyrX/DSPTXQ0Lgv+poPKT7RcCuUPZH1PBNMjDV68sBDsLHzr6/W+HNvr5uu1hk8
         DwVmgn3L0/HyTfnHeWOqu/r68v7+Kyh4oD4x+15ryVFOP532FWjhHyCKIyF6KpHeblMY
         wrO04dr3blXCRQS3EL9X0nagHsPspSQ/3U6gc5PjXkCLsJmF2mgqTcaCRxFgbgXzLGQJ
         4qaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+RZyEzR1c1aix9tAsmWuYaWH7JJ96596rmhjKSaoCBIb352q/yNgs3ffrIOoc0AHHuuJ5Z1M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+abropWirSjjgu8sgE7sRAw+09Tf7cMjfcnRUA/ERPERQTCPa+
	DgYp2bExMOtS4va6WJNF6gPAfSIqTDvF1VBtW8kR5Tg6jlQtzPtdwxJYlw8ER4uh22M9CT9HlC3
	mw1KT7HaXJVlQkgGGkg==
X-Received: from dlaf18.prod.google.com ([2002:a05:701b:2412:b0:19e:9bf:dc47])
 (user=bcochrane job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4512:10b0:181:73fc:e53 with SMTP id a92af1059eb24-1ac5b7e21fdmr23206658c88.29.1793768140660;
 Tue, 03 Nov 2026 20:55:40 -0800 (PST)
Date: Tue,  3 Nov 2026 20:55:34 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261104045534.79783-1-bcochrane@google.com>
Subject: [PATCH net v3] bnxt_en: Take RTNL before netif_close() when aborting
 FW reset
From: Bryan Cochrane <bcochrane@google.com>
To: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <joe@dama.to>, linux-kernel@vger.kernel.org, 
	Bryan Cochrane <bcochrane@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

netif_close() must be called with RTNL held in addition to the netdev
instance lock: __dev_close_many() asserts it, and the NETDEV_GOING_DOWN
and NETDEV_DOWN notifier chains it runs rely on it for serialization.

Commit 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
replaced rtnl_lock() with netdev_lock() in bnxt_fw_reset_task() and
bnxt_fw_reset(). That is sufficient for the paths that only tear the
NIC down internally with __bnxt_close_nic(), but the abort paths close
the netdev via bnxt_fw_reset_abort() -> netif_close(), and the error
path in bnxt_fw_reset() calls netif_close() directly. Those now run
without RTNL and trigger a WARN_ONCE() cascade when a firmware reset is
aborted:

  RTNL: assertion failed at net/core/dev.c (1740)
  WARNING: net/core/dev.c:1740 at __dev_close_many+0x1be/0x1f0
  Workqueue: bnxt_pf_wq bnxt_fw_reset_task [bnxt_en]
  Call Trace:
   netif_close_many+0xb5/0x190
   netif_close+0xa2/0xd0
   bnxt_fw_reset_task.cold+0x8d/0x213 [bnxt_en]
   process_one_work+0x19d/0x3a0
   worker_thread+0x1af/0x320
   kthread+0xe3/0x120

followed by the same assertion from call_netdevice_notifiers_info(),
fib_rules_event(), inetdev_event(), rtnl_fill_ifinfo(),
devlink_compat_phys_port_name_get() and ip_mc_down().

This was observed on a machine in real use with a BCM57504 (4 PFs,
FW 236.1.153.0) running v7.1.6: the firmware crashed, announced a
"Fatal firmware reset event" and then failed to come back within the
advertised max wait, so bnxt_fw_reset_task() aborted the reset on all
ports:

  bnxt_en 0000:c1:00.1 eno16905np1: Firmware reset aborted
  bnxt_en 0000:c1:00.1 eno16905np1: fw_health_status 0x448100

Take RTNL (before the netdev instance lock, matching the OPENING state
which already uses rtnl_trylock()) in the fw_reset_abort path of
bnxt_fw_reset_task() and route the POLL_VF abort through that same
path.

bnxt_fw_reset() cannot take RTNL in its bnxt_get_registered_vfs() error
path because it already holds the instance lock, and dropping that lock
to reorder would let a concurrent devlink health recover enter
bnxt_fw_reset() and set BNXT_STATE_IN_SP_TASK through bnxt_unlock_sp(),
which the subsequent close would then wait on forever. Instead, mark
the reset as aborted and let bnxt_fw_reset_task() perform the abort via
the same fw_reset_abort path. The normal reset flow, which may run on
many VFs at the same time, keeps running without RTNL, and the ULP is
restarted after this abort like after the other aborts.

The bug was found by inspecting the kernel log of the affected machine
and the driver source; the fix was prepared with the help of an AI
coding assistant (Gemini based) and reviewed by the submitter. It is
build tested (allmodconfig with W=1, plus the same change on top of
v7.1.6 built as a module for the affected BCM57504 host). The aborted
reset path itself only runs when the firmware fails to return from a
reset, which could not be reproduced on demand.

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan Cochrane <bcochrane@google.com>
---
v3:
 - Do not drop and retake the locks in bnxt_fw_reset(). Route the
   bnxt_get_registered_vfs() failure through the bnxt_fw_reset_task()
   abort path instead; this also restarts the ULP after that abort. The
   v2 unlock/relock window let a concurrent devlink health recover set
   BNXT_STATE_IN_SP_TASK via bnxt_unlock_sp() and hang the close
   (reported by the netdev Sashiko review).
v2: https://lore.kernel.org/netdev/20261103042210.2984373-1-bcochrane@google.com/
 - Keep bnxt_lock_sp() in bnxt_fw_reset() and take RTNL only on the
   bnxt_get_registered_vfs() error path, to avoid RTNL contention when
   many VFs recover at the same time (Michael Chan).
 - Dropped Stanislav's Acked-by because of the change above.
v1: https://lore.kernel.org/netdev/20261029032832.1511180-1-bcochrane@google.com/
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 33c4cacc8ffe..f48e67670ccf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14860,8 +14860,8 @@ void bnxt_fw_reset(struct bnxt *bp)
 		if (n < 0) {
 			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
 				   n);
-			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
-			netif_close(bp->dev);
+			bp->fw_reset_state = BNXT_FW_RESET_STATE_ABORT;
+			bnxt_queue_fw_reset_work(bp, 0);
 			goto fw_reset_exit;
 		} else if (n > 0) {
 			u16 vf_tmo_dsecs = n * 10;
@@ -15524,6 +15524,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 	}
 
 	switch (bp->fw_reset_state) {
+	case BNXT_FW_RESET_STATE_ABORT:
+		goto fw_reset_abort;
 	case BNXT_FW_RESET_STATE_POLL_VF: {
 		int n = bnxt_get_registered_vfs(bp);
 		int tmo;
@@ -15547,9 +15549,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_timestamp = jiffies;
 		netdev_lock(bp->dev);
 		if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
-			bnxt_fw_reset_abort(bp, rc);
 			netdev_unlock(bp->dev);
-			goto ulp_start;
+			goto fw_reset_abort;
 		}
 		bnxt_fw_reset_close(bp);
 		if (bp->fw_cap & BNXT_FW_CAP_ERR_RECOVER_RELOAD) {
@@ -15682,9 +15683,11 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		netdev_err(bp->dev, "fw_health_status 0x%x\n", sts);
 	}
 fw_reset_abort:
+	rtnl_lock();
 	netdev_lock(bp->dev);
 	bnxt_fw_reset_abort(bp, rc);
 	netdev_unlock(bp->dev);
+	rtnl_unlock();
 ulp_start:
 	if (!rc)
 		bnxt_ulp_start(bp);

base-commit: 787268686c64be60023743b527645a907e38ccca
-- 
2.56.0.398.g882cbad275-goog

