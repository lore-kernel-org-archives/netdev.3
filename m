Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06CE377574
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828733; cv=none; b=sw+GqkQfFM75E2tf0cIhdYDDsGQ+JuI5l9RRq1hqTzqZtHMw6ResdeSfR7dcLk6KSHzpKsVEA3zMiuMiEepNVyaDLdGdrCP8NKZeIrYMb+Bq5KXG2yW97m38S7J7cHzR/9HDM71KwbPGX4Xbwj3IVVWTAKfWf/I40AcLsIopi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828733; c=relaxed/simple;
	bh=GpzhhMRYN/iYCunxpNPlT1YqMOQKr247+Sq6sjGne+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mI3RhVQybc0UMbyX1Q7MyymK1pmChbI2mWkTA+sDfkrCRCZIRa5O2T5pbssjvm/7ArRI7K0beFMGqtD0RLJ1RZMzJHGdnQje08xpUrVK797GbSbYcZ4TraBePDB/IGB8jr29pLC/98yWkTciwUotXCqklsw8R/aCfKpT90KDH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfe7Wols; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfe7Wols"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1054923a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828723; x=1785433523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RgqjbyFDcZMHfHX0tAra4Pr08m1zwCx9sNwlnEiHric=;
        b=Yfe7WolsKTrTRTopElVAHT0zVMTaeGr0sk3bPh8RBYndlxFcxN6nANsNqrUlBmt2nx
         HYf+QNfwuzrnm45F0n25pHVGKGFQWAV6oCizSwRNW/7DKxqu/pxFwQDIKU7awLNiF3wR
         CBZ2sxPo7TlO522nHS95h/xcvnHVJMkApvEau+XQYsvCoLWA7cyZusatAU0Nssz7+m5X
         WTjlaf1+PIjp4ArCHzkobVCFoBL9BDIcv7uLncmikHJX8K+hmgch1T8AK1V23aFlLheY
         rvAJ9/nVlQ/UJRd+hmw4V0mYsT32bs3A7/Mc3mcn3PX/isGKLe2MMIYLRWgoeL6RDRg5
         Gt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828723; x=1785433523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RgqjbyFDcZMHfHX0tAra4Pr08m1zwCx9sNwlnEiHric=;
        b=CIzFqzzc1AbczJ1mp6SYg7AiwU8/k5r9w9F1Bdjo5DCzndjT8LhdEoTvk4a6UD4A/M
         Yc4Jdpiev9lM1fNtRXsy7fvu4rM6MvkJ9zLph4FGjp93+I0XdAb+lQGQve+cX2YiMwMs
         jatbjd6Pidy8q5AF1yPkHoAqBKu9unoLdIUUxJm6qYD1zT4hZenFlQYWgSHO8abRCBdp
         4D9RjMQUZ1RPWjbpazee/IvPwYTvu4boF7/iwBcSgkgoir2eIyY684oZQM2WjUFA3cqO
         0TuesjExKero7yFVdwHCOI3qfUoydY4C0GZbo84ze6Cs4ktCDqq/fvxW482IDLe7hl/Z
         1rVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rom5Z/QsO0QrWs1jv1bTReAy7YJRWiQI5wCwKLl3Jvk35oL8PLaRB5vIHSyf7BAkmusgIo9Niw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+G+m0VSQeMcUn+14JlH73+941BgE77XTsQX9ZC3AUG/vueQMx
	rOwWrKKZgLCN8u/U3I7RBMPcib52T58t+rwJzSl5ywJZ/AK1/ki4Ssa4
X-Gm-Gg: AR+sD11O8rYtiom/GpAI/xTIDePjFlz9oJqrSz4kEtaPJOHM0xuTi5qL1/VWVLbU4C+
	xpeoRD9TkxyCrdNq+TKIhRMS6u1+moBHcGHmwupBocq0HW77cJv+rOImbewsBufmYNFFvYhllTt
	+xBlQB+U0WRxyOEn830jF7cIdxD+NugtvUEYcBIc/MApnkgTecXx1DpGfmG1jb8Gr+jX0MKFpNG
	bv30cm6HNSvXQ0DvFrjlufzPtVqU/xq+ui7whtxMR6qrTIydJWETZqDsjHcAlU2CwYlTUaL6xom
	bLoJCymorLeYKQOIRdlrK1HytzoP6eBHTpU2HLYIN03FXfk5nDNMvTaAkuovNhUOpbKqs7K67Kt
	HCO1di4+o6dLnH/EuoLBXiJrmD8QQr3k6WOIikUX8Ha7yPbmZws4THxNyWR2nBm2RS2O429Pcj0
	ZNPAQ8SGXRkRbUKMBU0mkel9BtTRCrFD6+9dGxiyFnm5cQmUs=
X-Received: by 2002:a17:90b:52d0:b0:38e:9e9e:ec57 with SMTP id 98e67ed59e1d1-38ec667a731mr4035830a91.43.1784828723369;
        Thu, 23 Jul 2026 10:45:23 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13002f39sm18210216c88.1.2026.07.23.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:45:22 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] nfc: digital: fix use-after-free in nfc_digital_unregister_device()
Date: Thu, 23 Jul 2026 10:44:51 -0700
Message-ID: <20260723174450.1015153-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_digital_unregister_device() cancels cmd_work and cmd_complete_work
once each and then frees the command queue.  The two works re-arm each
other: digital_wq_cmd_complete() ends with schedule_work(&ddev->cmd_work),
and digital_wq_cmd() hands a command to the driver whose asynchronous
completion schedules cmd_complete_work.  cancel_work_sync() only waits for
the instance it cancels; it does not stop the work from being queued again.
A work re-armed after its cancel_work_sync() therefore runs concurrently
with the cmd_queue cleanup and dereferences a digital_cmd the cleanup has
already freed.  digital_wq_cmd() widens the window by dropping cmd_lock
before using the command it took from the queue, while the cleanup loop
frees the commands without holding cmd_lock.

It is reproducible with the software NFC simulator (CONFIG_NFC_SIM): start
an NFC-DEP exchange between the two nfcsim devices and unload the module
while it is running.

 BUG: KASAN: slab-use-after-free in digital_wq_cmd (net/nfc/digital_core.c:174)
 Read of size 1 by task kworker/1:5
 Workqueue: events digital_wq_cmd
  digital_wq_cmd (net/nfc/digital_core.c:174)
  process_one_work
  worker_thread
  kthread

 Allocated by task 5124:
  digital_send_cmd (net/nfc/digital_core.c:234)
  digital_in_send_sdd_req
  digital_in_recv_sens_res
  digital_wq_cmd_complete (net/nfc/digital_core.c:134)

 Freed by task 4994:
  kfree
  nfc_digital_unregister_device (net/nfc/digital_core.c:859)
  nfcsim_device_free [nfcsim]
  nfcsim_exit [nfcsim]
  __do_sys_delete_module

Use disable_work_sync() instead of cancel_work_sync() for the two command
works.  disable_work_sync() cancels the work and disables it, so any later
schedule_work() -- whether from the sibling work re-arming it or from the
driver's completion callback -- becomes a no-op.  Once both works are
disabled no work can run, and the cleanup loop frees the queue with no work
able to reach a freed command.

Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2: retarget net-next -> net (Daniel Zahka); no code change.

disable_work_sync() is v6.10+, so this is not Cc: stable; a backportable
shutting_down-flag variant can follow for -stable if wanted.

 net/nfc/digital_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 7cb1e6aaae90..6def5132a4a6 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -843,8 +843,8 @@ void nfc_digital_unregister_device(struct nfc_digital_dev *ddev)
 	mutex_unlock(&ddev->poll_lock);
 
 	cancel_delayed_work_sync(&ddev->poll_work);
-	cancel_work_sync(&ddev->cmd_work);
-	cancel_work_sync(&ddev->cmd_complete_work);
+	disable_work_sync(&ddev->cmd_work);
+	disable_work_sync(&ddev->cmd_complete_work);
 
 	list_for_each_entry_safe(cmd, n, &ddev->cmd_queue, queue) {
 		list_del(&cmd->queue);

base-commit: b2ff91b752b0d85e8815e7f44fd85205c4268094
-- 
2.43.0

