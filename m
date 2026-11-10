Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285762;
	b=HMl778amdvcn9tyH6LTCI2+RNrgXKuemn0n/6MUZL89tCOER7p1kkbqyf5MBTglUFrjM
	 nWs46CMDhYcgo23FLAUBHElYZ9uwakNizhBzGrw26YF1h1hHrejJY+LfhHIBxqOfSDYop
	 W2jER9uI4Qicu3t/XQpH2jSTAK85NGCeyoKcKhiASR69O8118GK30Q2eUr2TSqqG/de4R
	 AIlu0BGlMwz0H2h6XCjRq04BBqhFgBNxW/b5VP9Lsnk/IFxyai7fIRGdi2JzDJacIkFhB
	 teBBVTOZKmwsDx20EODZMQpVniF0TfItQ7WAWidOzrxZKXwFsrqHVW3njbFo7sdcw5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zjN9AV5mzraDlHKgRwS5EnbdBlxMZ/ilvo3TRXjmvng=;
	b=G200vMx6R2lQBK99ztoC/dYnKqf953bp+JC3VCLka/VOgS6MsGyG+xqGMG6WMX/ezIGK
	 xVBsWVH0Qtbz1So2Z9Lbaz0nXte8ICvmjj+o2JSTXfLtYhXJndO1W82T6hQr2ypuV0eXN
	 TDrmH9KKMw97/8mlJPeGtkv4v5ZisHhLc1Kf8E0T+3paTA+4DYvRQkHUUb6dfIJluj700
	 UR5zYWpA0tkBT+tRT1fExWLo/FkUy5oOnyHQOJGGI+uXnTyD/vnH3kOtN+oy1pFY+jLdu
	 4RBdYkZlZ9b0TEWpBSgsV5TTEw3keOlozcHDrVlvke66sw0ZvrUA5r3wyRRvinFY+fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eeWnCd8j;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F3606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B5F3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bcochrane.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eeWnCd8j
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3b5b49cabso899177c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794285760; x=1794890560; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjN9AV5mzraDlHKgRwS5EnbdBlxMZ/ilvo3TRXjmvng=;
        b=eeWnCd8jXIUHKbfa9Xrz0rtcXM3AgvADP0FvNdqo4440HM1gtwWo4+7f6Rl99cArn8
         oxZS9hbnlDuEW+oob1IpXf7QnMHAiM9UNnaS8gGPFZmFqAsk9Qt/VLoOKm9Spi3m2tNi
         GDH+RowL6K38bvEc3yDKYQjOKJvJfs/KxxaAr04yojDCb/4QMd1xjI9nDGA3769dnMOI
         qtdRRmUkaX6wxILx9SC4pg37Ca5EFx5P6jz+iMSGkRuxZ0cDg7uvIxDxicxy0C7JNJWO
         XjzeCY1tTGD7E67S9Ex5OL03YLZYf2iGgJNn6c37zgjKgDKSJ7cF4idxzktCnU4qvJNC
         5OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285760; x=1794890560;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjN9AV5mzraDlHKgRwS5EnbdBlxMZ/ilvo3TRXjmvng=;
        b=jhJz9ceutOdf2qhyYPj16xO4r1YPjqgXEKGj0XXS9gj8uvNIlaqGDFzMlNFKDVGKXz
         69AtzmzNr6KUC0LOmkrXxzU4a9bOk/II6PO7QA3Bmt8L1N3TI0Tr+U+3hkrRQ96mi2c0
         HGyXmdie8JW3ZIWyEYD68NqQCvkyvAbVwbJqz1eBEjz+UmA5oJ6DkO8rzqzOHvjAPrdk
         vB0VrBMy/rWW7QOUk6tz0t/ahIVAajKQiRb05QYHivmd2V75SWwtVgTBspLeTn6zYsbj
         mWeAPpd6kkuljJS9BbbadE6HyMGSxmuj42Ab49vRYz9DR2wJ19pmHuvT7i+6bKpwbfcU
         wIlg==
X-Forwarded-Encrypted: i=1; AL+hErFkYX8bpJUbL6A++q//Me8xmin7PXAEqLNzXFum90SRlirA3oUjgfrNGGGarTbiFcFjvXU08kg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YhHc5TODe3jQvlfI+OQFumnnh38Ex5oMtyS/z3tBX0i7dAH5l
	YBt8dbEtpaxs9dJOeM+lz23VydpgVX4Zd06vEqs0ge7cCesEOzCXVOlS3BoHqT+xLLlmXqnCiyH
	uUzs2k1dMpJgrlR4nLQ==
X-Received: from dled18-n1.prod.google.com ([2002:a05:701b:42d2:10b0:1b2:4d89:1614])
 (user=bcochrane job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b90c:b0:1b2:471f:c4c with SMTP id a92af1059eb24-1b3b607b931mr2215434c88.19.1794285760256;
 Mon, 09 Nov 2026 20:42:40 -0800 (PST)
Date: Mon,  9 Nov 2026 20:42:35 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110044235.204386-1-bcochrane@google.com>
Subject: [PATCH net v5] bnxt_en: Take RTNL before netif_close() when aborting
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

In bnxt_fw_reset(), only a PF can reach the bnxt_get_registered_vfs()
error path that calls netif_close(), so take RTNL up front via
bnxt_rtnl_lock_sp() when BNXT_PF(bp) is true and keep bnxt_lock_sp() on
VFs. That avoids dropping the instance lock mid-reset (which would
expose a transient BNXT_STATE_IN_FW_RESET and let a concurrent devlink
health recover set BNXT_STATE_IN_SP_TASK), avoids racing with
bnxt_sriov_configure() updating active_vfs outside RTNL, and keeps VFs
from contending on RTNL during recovery while PFs already run on the
single-threaded bnxt_pf_wq.

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
v5:
 - In bnxt_fw_reset(), take bnxt_rtnl_lock_sp() up front when BNXT_PF(bp)
   is true (keeping bnxt_lock_sp() on VFs) instead of dropping and
   reacquiring locks on the bnxt_get_registered_vfs() < 0 path, and drop
   the bnxt_in_sp_task() change from v4. Dropping netdev_lock mid-reset
   exposed a transient BNXT_STATE_IN_FW_RESET, while guarding
   clear_bit(BNXT_STATE_IN_SP_TASK) in bnxt_[rtnl_]lock_sp() risked a
   deadlock with devl_lock during devlink health recover (reported by the
   netdev Sashiko review). Using BNXT_PF(bp) rather than active_vfs avoids
   racing with bnxt_sriov_configure() while still keeping VFs off RTNL.
v4: https://lore.kernel.org/netdev/20261108222942.1233295-1-bcochrane@google.com/
 - Return to the synchronous close in bnxt_fw_reset() from v2, using
   netdev_unlock() + bnxt_rtnl_lock_sp() as suggested by Michael Chan,
   and guard BNXT_STATE_IN_SP_TASK in bnxt_[rtnl_]lock_sp() and
   bnxt_[rtnl_]unlock_sp() with current_work() == &bp->sp_task. Deferring
   the close to bnxt_fw_reset_task() in v3 still hung when entered via
   bnxt_fw_recover(), raced with bnxt_hwrm_if_change() clearing
   fw_reset_state, and marked the reporter SEVERITY_FATAL (reported by
   the netdev Sashiko review).
 - Omitted Michael's Reviewed-by and Stanislav's Acked-by from v2 due to
   the new bnxt_in_sp_task() check.
v3: https://lore.kernel.org/netdev/20261104045534.79783-1-bcochrane@google.com/
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 33c4cacc8ffe..8b7ebf2eefaa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14838,7 +14838,10 @@ static int bnxt_get_registered_vfs(struct bnxt *bp)
 void bnxt_fw_reset(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
-	bnxt_lock_sp(bp);
+	if (BNXT_PF(bp))
+		bnxt_rtnl_lock_sp(bp);
+	else
+		bnxt_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state) &&
 	    !test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
@@ -14884,7 +14887,10 @@ void bnxt_fw_reset(struct bnxt *bp)
 		bnxt_queue_fw_reset_work(bp, tmo);
 	}
 fw_reset_exit:
-	bnxt_unlock_sp(bp);
+	if (BNXT_PF(bp))
+		bnxt_rtnl_unlock_sp(bp);
+	else
+		bnxt_unlock_sp(bp);
 }
 
 static void bnxt_chk_missed_irq(struct bnxt *bp)
@@ -15547,9 +15553,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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
@@ -15682,9 +15687,11 @@ static void bnxt_fw_reset_task(struct work_struct *work)
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

base-commit: a45dbf182137275f44ad7c8bc8acd23f7af6b2cf
-- 
2.56.0.506.g506a7eabc5-goog

