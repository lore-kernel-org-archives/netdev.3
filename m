Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649D327BFC
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651907; cv=none; b=MSgnRT7vixBDqb6FWgiRRYn5StxQFsQf/N7IslgE6kYBdoN88NLeCDZ75EABOJP/fQFrYenQrP95kYaV97Zy/ZBlrrq80Y9Uy71xZlETEE+eeGI/gBpjxlJ8jQ3fQiBMrXBox/OZz7DiDZyDg5YWW0GNjYHDiGdj1PYJEN/a7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651907; c=relaxed/simple;
	bh=IIsg5LNJf5aQ0cLtyQoPoijCSzNNTN3r5SiNIC4aJic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyQhmmORZMQlDtYEvAXBlnKBrC/7h2Q/Wi2dMwikzhUPSPZMiEmUXeOIBzo9vICL3tgGdnQHYfNPBO1BcJzFoz6Jslq4COYDF/wsdZ7tZ0yHT83PLsSf1PeHlYKHJBOR1FtliZAg/vcY3f8ng5cdEzj3hSDTP9RflCKv9u4Uu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2FLJO+k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2FLJO+k"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso122243545ad.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784651905; x=1785256705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5KmYNoNui/9hjo/Me1fX33BIrL3ENZ8CEuolPxOI8Y=;
        b=i2FLJO+kTlfE60kdhQDcgjGae3WJjcOMUCjNdrOS1Tq+xj+cR/KXmgGWllBYXR4RZR
         3054P+Harm9GIy3UPJ+keKDYqMXwFmUXl8jiC+tlmTV5C/WSAjwxqPr7NxIH7184Q9cI
         1AyFAXj7qEroXoSGLMNzI5osGkEaJcwfb0HJBDwOnKlnNL4yD4D7zY/DWgSohZeQ0A5a
         /R+ZmfmiN/7PGgMcuxXjcledjVI8sEzM7A1jswJzsSR4nCqk3W5RUBXg8XADUtVnaPMw
         nvpk1zZpf5Ou+S7D2brt7gQqi+JgohwTHADMngJADVMPGOIYc7MnSYj8693l2vy96JNL
         M+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651905; x=1785256705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5KmYNoNui/9hjo/Me1fX33BIrL3ENZ8CEuolPxOI8Y=;
        b=siPViuAL5HAa/+yVvxPC6YQ9CfxZjB1u/ff9+akfYU5dXdOXvd885EBvdzpE7dKI52
         QRmMiHFbVkpyKVjPzlW2oQhciGh3XmSlUZQU8c8zj+bGeuOt7ulmx1seTrkQ4VGFwlOn
         YLA9kcv7Kl5bhDdLkvCYvQZ7X1SA2T2K9jQ9gszTNqN/zMCSUFIoaYdD/T49VEg+ZH1r
         KMeN58il0tiTX8Si+UQJO1oQOrSRaCzup7HKTNl2/3tQH9m5P6bf3o4KmZV8KjDPNH0X
         KQX/hpf+pJMnI5GLc9J5oAdO4/0K1BtOdjD3jrPRjzEjJbLQtR50wPLmohVJosFfARzt
         QdXw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0VAEIPgiju4XQbcDYtvF2k0zXOTyKISRQhmH1hQFIUpsCNxPrP5wSamA2gaIdOf39CamC+FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Gte89//upqo5W64LCXCrqqyEH3ky0XHY+ftURLGYEcBAGiUw
	3EG3BLQCH/pYSFdMXrTnHfK+f5gGCpt1MlwyE+OoHFzWUJeHEdbEspuY
X-Gm-Gg: AR+sD13hV32r8BiGyCgielXFwd6M8UIQtTAVp5Npv4SuyBZ2RoJTXqPGh/KsZl1mgH0
	2kVXgr9NnCT6sHhHFIjVpk2jFSiYeWStM+88CuHtP+YxxwImvZrj3wS8Fw7gq5ZeqpwWGJHbywN
	ukyNvZEwl4ZxmZ3UGl8YbBtv6CxCeMUsDuKBIqrxYoQjn71+yslcTocKgB1D7Wea74oaNALBzzZ
	md9ZiLGHmtAbiNcomqVxltICKC7S5UYbViLhsuvanHhZPzwZ3/LyeQRVmCZsTe5lR50Xv8LsPIp
	va5i6j6+wjjV8reaMfs8TiH5uYDhpSXx/QvkJZHjZ//oMewXlaUK1UHjPa2xk6w1UbKz0yZ1AZg
	ZNULBqje9GZSNKcYApFefT8JLOZdaVo0CDbwRKOj0/ph/fiIrKk01z27VYnINZblXbY+jSlEdhB
	Q+QFJNRUEWdleeFNnfL5wnuJAMURBew5VngO3cAeX17tkGRyP+528SPEcYWg==
X-Received: by 2002:a17:902:dad0:b0:2c9:97a8:afe5 with SMTP id d9443c01a7336-2cf349eee08mr204790805ad.40.1784651905156;
        Tue, 21 Jul 2026 09:38:25 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e07000fsm1053708eec.21.2026.07.21.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:38:24 -0700 (PDT)
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
Subject: [PATCH net-next] nfc: digital: fix use-after-free in nfc_digital_unregister_device()
Date: Tue, 21 Jul 2026 09:36:32 -0700
Message-ID: <20260721163632.1570651-1-bestswngs@gmail.com>
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

base-commit: d4932951a19a5f1ec93200260b85e1a4c080ff77
-- 
2.43.0

