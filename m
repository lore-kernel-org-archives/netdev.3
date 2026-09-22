Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D54A6887
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106526; cv=none; b=dEG8K7LRZDgsM0cKImSlCD2aPYiF202lXPUN644HpczuH6ynNH8xQo4vKUKHdauQ1NM5UhDkMZH/4XiIIEwjUdLhnjqlWwvlZImpes7uRDQY8LOC/PMus81vAMBkE5UvJxtp0FeV2uH8T7qt/yTndBiitcj7dLK+CP90/CrVrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106526; c=relaxed/simple;
	bh=vxnVhGFWw4jrl9DnCaFJw/l/iEJ5JQ9+0zwI6d/+tsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCiBafhZGSVGRkcCwec7DUnHV+MhFYEvEMjDg2v8gdj3T4kMCtEoPgzLkRuYlFpJ6uJaw4AyrRylATAWCZT8RJiL1OEIBUWcEGuO9xn7JLbPZt0VufKgHMYOwc5U6C+ms0ysL5Ff3MJdsRQxJ9oYokYTtT7mApCxjS9ElZBb7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=S4LVVW7c; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="S4LVVW7c"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f9160b81so70457c88.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790106524; x=1790711324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLkGtM8tazdcdnHvLp+FEgu253YR4i7gpOlAe8BcjDA=;
        b=S4LVVW7c8gptlrl0KKeyWBmzCNnr5co4UIEUcxyviep7qmg0WfNbn8Xg/ix3UoSEji
         94i9F7C1VeoFddlrJ8sKWPmbYfM1gayrL31VlMystolF+pjxXGEQKWf5BGj9xBRv2Eb9
         lJAyjOwzWy0qTwNp2GKE8/eQ7Lgos0Qt73RmS+VDQygOxfrOJEh6tg0jcEQUVDedtoxl
         2l0gqqvuVG3Q7U+radGAUlxzaQC6HmywTCF0hwCoKqJacgxm2EexmCl6W6S90QLv8EC8
         kpB1v5j1ErEi0da3LmbKAb/gQ8jL5Ct+ciWBFoTR/fWEVud3eT1rsLZXH8d8++TGUEU/
         0Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106524; x=1790711324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLkGtM8tazdcdnHvLp+FEgu253YR4i7gpOlAe8BcjDA=;
        b=bnRLE4DhLXoqF1WLa9dJvChSUQ2yCNd42/jELEXfeOin0p9/J7L1va2YZ7qgWa56Ip
         UJiy9dIxhWYSvY0gNJ+Yfw+yk+rvPtxcTp8IHspFgALc4bBf01JUTaScHtwQkk/z3twC
         oc2PDpaMxWBvRoStwIUBhrvh2XNeAFedu++LPDe4B4/ltQrhvp8gRAo/Ffozz3e/14X6
         ZRxt2c4sEbNnI+E4sFVPQ64tpQyjmGIlVKBrcd+NnUqLgjUvqpQMnAxYSlxHPfgtXRhN
         I+XCfenEPPCKJhtyR2xIcJtNNVzIk3MDAdtpVPl+WzS4IdVicQ2ZaYpqEeQmIFXXDT4y
         Igwg==
X-Forwarded-Encrypted: i=1; AKwUvBx9Zh2paA9gakqHf/WqVaRXP2/tQ5Nk+m1ZOHadT5ow/RKIUIHAm675w/+yfP16KbGjd5oaEBc=@vger.kernel.org
X-Gm-Message-State: AFuF++luTNyfUVFHKuKfn4dMj8V5s2lt8AVlbedse1OXabQeXgccohZV
	u861f4tcLo0GOXtyCdfISvT+BWeCEfLgPMUZLnZ3cqz5PgvjvXCrNCXo/6e8H4UbpQc=
X-Gm-Gg: AYBFou2iW1nvtOlwVY6LCb7qGAHgCleFbGUrvzMQXlnhXmZ2pDXYZqyzI/bHsmm5hSq
	HOqao9sNp28+JZUtlIMNuOqGyQY+7EVe5tmvJI7CdPtTEI5+1GdLbtteQDChTDyRmwSxa7mxDvK
	FUE9mL13zjWEuyow5O3bHYz59/Z04pdG72sxQC/xI6g2fgDA1BBwXnCdsGJ3wrjMkTSVxXa/0XT
	JdjWJ+TFZNgk6Ev2Oi9pTc27FpN6d3N9CkAAFgvctiVYnisP8TTVufmKWglkzFjzmOec111l7k8
	Bfyw0oOJOwDiCfvGbPHbaDwzcgk1aJsN/qrHjoNtDu/acyWAt1qjzdFLmaJ4XYL2Wn8NuK5JxL0
	RavnRvSXIrmo+AyFJganDzup42cgDo9LHJrH4Z7dRM3TlbUcuLtymVauuHpWcugCqEoCteKngqd
	yWYRs8wahe3tobzU2+hZPweNeugTE+80V761gT1TSrmMEsrvhV1817bVGJyHrSqoH0QGneZ2KSH
	XmkucQSmFTcHGwB031WpJSzzEgDR6vJqU4HkoEe1eJzHxSbe6Q0itwBdoI7cjbwvlVarN2RQtgq
	CmWpvw==
X-Received: by 2002:a05:7022:f901:b0:134:cf34:b8e0 with SMTP id a92af1059eb24-144f908714amr417661c88.9.1790106523570;
        Tue, 22 Sep 2026 12:48:43 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:c016:77a6:d382:7611])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98a288esm708550c88.13.2026.09.22.12.48.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 12:48:43 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 6.1.y 1/2] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
Date: Tue, 22 Sep 2026 15:48:33 -0400
Message-ID: <20260922194838.26223-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922194838.26223-1-artem@trailofbits.com>
References: <20260922194838.26223-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 94d9ba9f9888b748d4abd2aa1547af56ae85f772 ]

Use-after-free can occur in hci_disconnect_all_sync if a connection is
deleted by concurrent processing of a controller event.

To prevent this the code now tries to iterate over the list backwards
to ensure the links are cleanup before its parents, also it no longer
relies on a cursor, instead it always uses the last element since
hci_abort_conn_sync is guaranteed to call hci_conn_del.

UAF crash log:
==================================================================
BUG: KASAN: slab-use-after-free in hci_set_powered_sync
(net/bluetooth/hci_sync.c:5424) [bluetooth]
Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124

CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W
6.5.0-rc1+ #10
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work [bluetooth]
Call Trace:
 <TASK>
 dump_stack_lvl+0x5b/0x90
 print_report+0xcf/0x670
 ? __virt_addr_valid+0xdd/0x160
 ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 kasan_report+0xa6/0xe0
 ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 ? __pfx_hci_set_powered_sync+0x10/0x10 [bluetooth]
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_cmd_sync_work+0x137/0x220 [bluetooth]
 process_one_work+0x526/0x9d0
 ? __pfx_process_one_work+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? mark_held_locks+0x1a/0x90
 worker_thread+0x92/0x630
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x196/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>

Allocated by task 1782:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 __kasan_kmalloc+0x8f/0xa0
 hci_conn_add+0xa5/0xa80 [bluetooth]
 hci_bind_cis+0x881/0x9b0 [bluetooth]
 iso_connect_cis+0x121/0x520 [bluetooth]
 iso_sock_connect+0x3f6/0x790 [bluetooth]
 __sys_connect+0x109/0x130
 __x64_sys_connect+0x40/0x50
 do_syscall_64+0x60/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Freed by task 695:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2b/0x50
 __kasan_slab_free+0x10a/0x180
 __kmem_cache_free+0x14d/0x2e0
 device_release+0x5d/0xf0
 kobject_put+0xdf/0x270
 hci_disconn_complete_evt+0x274/0x3a0 [bluetooth]
 hci_event_packet+0x579/0x7e0 [bluetooth]
 hci_rx_work+0x287/0xaa0 [bluetooth]
 process_one_work+0x526/0x9d0
 worker_thread+0x92/0x630
 kthread+0x196/0x1e0
 ret_from_fork+0x2c/0x50
==================================================================

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Backport to 6.1.y: the source change is unchanged; only hunk locations
  in hci_sync.c differ. ]
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Stable submission note: patch 1/2 in the CVE-2023-53762 series for Linux
6.1.y.

CVE: CVE-2023-53762

Build: This patch was included in an x86_64 allmodconfig and
CONFIG_WERROR=y build.
It produced vmlinux and modules with no new warnings or errors.


 net/bluetooth/hci_sync.c | 55 +++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d5856448d46782..da9e6e55bc1d00 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5587,6 +5587,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err = 0;
 	u16 handle = conn->handle;
+	struct hci_conn *c;
 
 	switch (conn->state) {
 	case BT_CONNECTED:
@@ -5600,43 +5601,57 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	default:
+		hci_dev_lock(hdev);
 		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, reason);
+		hci_conn_del(conn);
+		hci_dev_unlock(hdev);
 		return 0;
 	}
 
+	hci_dev_lock(hdev);
+
+	/* Check if the connection hasn't been cleanup while waiting
+	 * commands to complete.
+	 */
+	c = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!c || c != conn) {
+		err = 0;
+		goto unlock;
+	}
+
 	/* Cleanup hci_conn object if it cannot be cancelled as it
 	 * likelly means the controller and host stack are out of sync
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
-	if (err) {
-		struct hci_conn *c;
-
-		/* Check if the connection hasn't been cleanup while waiting
-		 * commands to complete.
-		 */
-		c = hci_conn_hash_lookup_handle(hdev, handle);
-		if (!c || c != conn)
-			return 0;
-
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, err);
-		hci_dev_unlock(hdev);
-	}
+	hci_conn_failed(conn, reason);
 
+unlock:
+	hci_dev_unlock(hdev);
 	return err;
 }
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 {
-	struct hci_conn *conn, *tmp;
-	int err;
+	struct list_head *head = &hdev->conn_hash.list;
+	struct hci_conn *conn;
 
-	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
-		err = hci_abort_conn_sync(hdev, conn, reason);
-		if (err)
-			return err;
+	rcu_read_lock();
+	while ((conn = list_first_or_null_rcu(head, struct hci_conn, list))) {
+		/* Make sure the connection is not freed while unlocking */
+		conn = hci_conn_get(conn);
+		rcu_read_unlock();
+		/* Disregard possible errors since hci_conn_del shall have been
+		 * called even in case of errors had occurred since it would
+		 * then cause hci_conn_failed to be called which calls
+		 * hci_conn_del internally.
+		 */
+		hci_abort_conn_sync(hdev, conn, reason);
+		hci_conn_put(conn);
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.39.5

