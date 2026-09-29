Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D92BE7DD
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643665; cv=none; b=TODRR2PYLilc046K/XCwKcc+kiM0PTU0jnF5tLRodHPO0b0naNFQKpKd0j5mfYROmhr3Q8kLpQ7RJrvP0gLPNKpMLCUkLZEzg9CnV0CBq4RknxDpTCtlypAI4OnWZlCDCb9ze/hZLshSUZ5dr7kW5QFSf7Q+7nnPTSpmniSUhqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643665; c=relaxed/simple;
	bh=kLH+hkWlzv6KwqEN83XPwxSDzpF15Xuz/III3guLPdk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mk4D94nt5IIrNLdzG/oKEmBAqIRF8vwcPO1Jp55Ak45G9TlAwtIXygNIC3XDQDg44II77GucaE3gp7fRuQIeEUdLtCt1w6sMaPqiNNyWQ++2HnMfuMgWNpHlHPqcMbE5xELR74kG9uDlmkamEyCKWqLjAIdn/z/VjwD8alkg+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWiTCRfk; arc=none smtp.client-ip=209.85.128.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWiTCRfk"
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-895241d7405so57329807b3.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790643663; x=1791248463; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V77BZKlX/8fggfANTTnS2fbkgNxQIxFQL+20zAjt4UU=;
        b=EWiTCRfkyGBuHwOnR5nneGLaxqmv5lGvvTLwO3Daddteq4PTW7eU97saFMmDLYGq17
         FS/ohhW+bx1Sv/vrLq8Ik5UYyhLPj7RBE4TA4u9TDAOHmYKELfhfZMVdFp45lQ97TRPi
         7qPnGWx7dQcLW0+QG9YjeK9Ab8mLMRgDtkHyVxL8YS7IU0pZSuMMQuR86kaeSTf11oAx
         2jNAkb6rkz8uXH4Fm7KdgsglqQ4H57X2oj3zCDHx3H7Gc2hrkJ47PUF+BpAw3T9tpEtt
         8z520FgJggh+y8QZ3NilvjvnGvqYB25Aq9lPciGV60zpRGCv0kPe9O7jlY9L5d31I6bF
         lFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790643663; x=1791248463;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V77BZKlX/8fggfANTTnS2fbkgNxQIxFQL+20zAjt4UU=;
        b=sdgHzSBdx7kamXVXsnv4Pod96+W0BIU0BAHSmdhPVUNe4uUHkPGQ89htcFMlVUsKfR
         UDvNN0j/wloHSbnH0ZUpqmdgKqIZWYMg0+LyWUtfNfP64bZY+Hb5+DH6P99IcWtoLptt
         3UZqjTSat+cseFJ6Qryd/Edf4BsZG7G0dVB4JKRgljZzXl6KwMEKMpKEEsI2grDq+Ol/
         2RnhJGbcfbPQWSYHFQ9//Ps+Wjr6yidboV7Y0nJaUClrjSJeU5acJpd0/wRotf1P8KWL
         pzIARu7o7ot3j4g2LB3NsDHSNba/bbQY9DJ1/c7SYxKIENTUZH/8ily5Y2AgRBoM1CEk
         AZNw==
X-Gm-Message-State: AFq9FYIiFfmIIs0bW25aHnqEwU0aYAcNnOrnVma0phQn16DzebeIKbZg
	NnZMS1Sj5B7jo/Cf8a3zyJS3aux32aOOO8iZ5mgX3Dqhf9wBhhrxr3NnudRDLeLHX2/a1X2XSgO
	tM3ZwngtoaenjrjLYyzTbBtPXJEbZwWblEB5caCGoa5uB49JfRxGZXFo1Bhe6BlqtEydcxoc/6Q
	BNSe1Y9CaaoXlgFk9zGKWpvf+49SsEOlMCLFbqCnwzGmmNeLNlvDnJav3JRrxBQl8=
X-Received: from ywaw21.prod.google.com ([2002:a05:690c:c195:b0:8a2:8824:3d90])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e20c:10b0:8a8:889d:2ff with SMTP id 00721157ae682-8a8889d0740mr31474597b3.67.1790643662508;
 Mon, 28 Sep 2026 18:01:02 -0700 (PDT)
Date: Tue, 29 Sep 2026 01:00:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929010058.4063305-1-namangulati@google.com>
Subject: [PATCH net v2] net: gro_cells: prevent enabling threaded NAPI on gro_cells
From: Naman Gulati <namangulati@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: bigeasy@linutronix.de, kuniyu@google.com, 
	syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"

gro_cells allocates a per-CPU struct gro_cell with per-CPU queues
(cell->napi_skbs), per-CPU local_lock_t (cell->bh_lock), and per-CPU
napi_struct (cell->napi). On !CONFIG_PREEMPT_RT, local_lock_t only
provides lockdep annotation (and is a complete no-op when
CONFIG_DEBUG_LOCK_ALLOC is disabled), relying on per-CPU locality and
disabled BH context for mutual exclusion; it does not provide cross-CPU
synchronization.

When threaded NAPI is enabled on a device backed by gro_cells (e.g.
gre0, vxlan, geneve) via sysfs, unbound kernel threads are created for
each per-CPU NAPI. When gro_cells_receive() on CPU A enqueues a packet
to cell_A and calls napi_schedule(&cell_A->napi) while holding
cell_A->bh_lock, the woken kthread can run concurrently on remote CPU B.

When CPU B runs gro_cell_poll(&cell_A->napi) and calls
__local_lock_nested_bh(&cell_A->bh_lock), lockdep detects that the lock
is already held by CPU A's task and triggers a warning:

  WARNING: CPU: 1 PID: 377 at net/core/gro_cells.c:66 gro_cell_poll
  DEBUG_LOCKS_WARN_ON(l->owner)
  CPU: 1 UID: 0 PID: 377 Comm: napi/gre0-0 Not tainted 7.3.0-rc2
  Call Trace:
   <TASK>
   __local_lock_nested_bh include/linux/local_lock_internal.h:92
   gro_cell_poll+0x5aa/0x6c0 net/core/gro_cells.c:66
   napi_threaded_poll+0x39b/0x600 net/core/dev.c:7048
   kthread+0x71e/0x870 kernel/kthread.c:464
   ret_from_fork+0x5d/0x90 arch/x86/kernel/process.c:167
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:264
   </TASK>

On !CONFIG_PREEMPT_RT kernels without lockdep, concurrent execution of
__skb_queue_tail() on CPU A and __skb_dequeue() on CPU B without
cross-CPU locks leads to silent queue corruption.

Virtual per-CPU NAPIs (like gro_cells) cannot support unbound threaded
NAPI or busypolling. For NAPIs that set NAPI_STATE_NO_BUSY_POLL,
napi_hash_add() skips adding its NAPIs to napi_hash and assigning a
valid NAPI ID, which already prevents enabling threaded NAPI on them via
Netlink.

Check NAPI_STATE_NO_BUSY_POLL in modify_napi_threaded(), and fail early
with -EOPNOTSUPP when trying to enable threaded NAPI via sysfs on
netdevs where all NAPIs have NAPI_STATE_NO_BUSY_POLL set. A more
fundamental check like napi_id_valid(napi->napi_id) can potentially
break userspace that tries to enable threaded napi on netdevs that are
down. This check brings threaded napi control via sysfs closer to
netlink.

Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Reported-by: syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6aad6d7b.0c43d342.320d00.0001.GAE@google.com
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Naman Gulati <namangulati@google.com>

---
v2:
  - Check NAPI_STATE_NO_BUSY_POLL in modify_napi_threaded() instead of
    adding NAPI_STATE_NO_THREADED (Jakub).
  - v1: https://lore.kernel.org/all/20260918173413.3222413-1-namangulati@google.com/
---
 net/core/net-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 352173df7578..286c7b4139df 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -743,17 +743,17 @@ static ssize_t threaded_show(struct device *dev,
 
 static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 {
-	int ret;
-
-	if (list_empty(&dev->napi_list))
-		return -EOPNOTSUPP;
+	struct napi_struct *napi;
 
 	if (val != 0 && val != 1)
 		return -EOPNOTSUPP;
 
-	ret = netif_set_threaded(dev, val);
+	list_for_each_entry(napi, &dev->napi_list, dev_list) {
+		if (!test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
+			return netif_set_threaded(dev, val);
+	}
 
-	return ret;
+	return -EOPNOTSUPP;
 }
 
 static ssize_t threaded_store(struct device *dev,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

