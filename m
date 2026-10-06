Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3A4CCDCB
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330679; cv=none; b=o0eFml6Vm0J4XKGWeCK6Csoo+SjafeLHNlFf40k2WeW9Zypo1qh5BwgYD+9uUAw0nMZYsIniNHpYiPKB3uXOQPK3jniTfSbpAEncLu8pvsViQTJ+rdnX2vDBrze41BY+N9HhVGaajRqwyxOyNVR1+U2jKmwLVF1gdvxQeC4zZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330679; c=relaxed/simple;
	bh=EPjqlJfvpd0fno9Mf3dBWpstxKj5CD8GlBCztw4eDpw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sA/hpBTFEQlUirJBaezcoIVw0yVCBsK7eTa2pSz2D4sEpU299PLHqq7W3P5qOi9n5u0PC0P2DyLpli4pT8PI2uO31YOA+ZDrBg8O+5tPQsdLP+NPtz/vUBFNherYpzXVj4qnsQpjw8AEKoAN3CHeniDZ4wgvvs00w1oL5JXJ2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GUBD8hz3; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUBD8hz3"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5339739b343so58574421cf.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791330677; x=1791935477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3iQnWPJWCktj5578LSdS2f8w0vrsJ1nfZaYjzTcnylc=;
        b=GUBD8hz3kSpukB5AHfCrHO0b5GqfszXekprCv+gQfCweslciC54QGqjX9aDUKRX1Tm
         0oInq3TGGYSuKkBmJX9HiDHCcZIEOa5YBjZ1p/ARPT3VyPmUkUYlz6/Kpo/q8rTlaqZI
         vwO3HPVrXKspMITO/jqvZETxx/QG944BfWSPXZdgQv/cVW5HIJrXFvNVUrGjLu3fd2lj
         uEz+yEPH2SCmQAIPsuPwX2sf+/7zBSFJsTo+m0S7145iZcM0bVupgIf1rFafbLsPbwLp
         NDRrm3+W68dmsx6K8VUDvxlNAvMs5eJlstF2hi+8vnrsikrnBKAa146iFo5abuJBPCPw
         PE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791330677; x=1791935477;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3iQnWPJWCktj5578LSdS2f8w0vrsJ1nfZaYjzTcnylc=;
        b=bmFPl5+Hw7m+a8GJS+fKU/uI/1My+UVHwqivDynPxbsnyypR2lVNCzK/Kp71+FcHBA
         7Vr0H65BXhT/W/WQr5X/Rx0zqbZxXq5HL4LCEiTB59mG9y7/VZY+oFiwVwMo3c3r44oj
         KiuwJWhqyrYKoNy3YqOhGfe7IlUq8s1hS21r1QrAJWLL9Q+sVrjpbx4u+9xrWkNXh/UH
         bEu0C+jLb7SeKIEtF2t6nPfbYmk8/LlfRIHMIfu4x9Q37Sx4IbEC2BTKJ6vGmWhdSNxi
         BMROHqzOo5Jr/1CPsSNgj4VH9b/6wa1GH/KlFO6bGYQ/QJzdZsHoCLe4FBx+8ZpNft77
         sKJQ==
X-Gm-Message-State: AFuF++k77OytWHuGHTMRoG8moLTLsiDzYf2V75fiWojS9z7DQ2guMRCH
	dHkJX15Z8almu3xkmcAb1okZuWBh6b1WqpTg+obpNAh+O+7USKf6SxL1f/UHxEbTAcjLD4TUBp/
	kf5GCHrXRsRAgVZqog+CxreKc0DYZqjID+xLV9F8EE2vB9wOKt1plCxjMUkGxhHwX7Gl40APVd7
	LL6YRQLPXuwXjD66/mhlwHOVnLDEzJLK3Y4MnJjHhbHQZ81nqdwsfAXS/nXs2H3fs=
X-Received: from qtnc5.prod.google.com ([2002:ac8:5185:0:b0:535:3635:8d08])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5cc8:0:b0:532:d36c:7096 with SMTP id d75a77b69052e-535756cd707mr8625191cf.56.1791330676825;
 Tue, 06 Oct 2026 16:51:16 -0700 (PDT)
Date: Tue,  6 Oct 2026 23:51:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006235113.2394030-1-namangulati@google.com>
Subject: [PATCH net v3] net: gro_cells: prevent enabling threaded NAPI on gro_cells
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

Virtual per-CPU NAPIs cannot support unbound threaded NAPI. While
gro_cells also sets NAPI_STATE_NO_BUSY_POLL (which skips napi_hash_add()
and prevents configuring them via Netlink), NAPI_STATE_NO_BUSY_POLL
cannot be used to reject threaded NAPI in sysfs because drivers such as
WireGuard set NAPI_STATE_NO_BUSY_POLL on per-peer NAPIs while running
them in threaded mode by default.

Introduce NAPI_STATE_PERCPU to mark per-CPU NAPIs that cannot run in
unbound threaded mode. Set NAPI_STATE_PERCPU in gro_cells_init(), and
fail early with -EOPNOTSUPP in modify_napi_threaded() and
netdev_nl_napi_set_config() when trying to enable threaded NAPI on
NAPI_STATE_PERCPU NAPIs, while still allowing disabling (writing 0) as a
no-op.

Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Reported-by: syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6aad6d7b.0c43d342.320d00.0001.GAE@google.com
Signed-off-by: Naman Gulati <namangulati@google.com>

---
v3:
  - Introduce NAPI_STATE_PERCPU instead of checking
    NAPI_STATE_NO_BUSY_POLL, which broke sysfs threaded control on
    WireGuard devices (Jakub, Sashiko).
  - Only reject enabling threaded mode (val == 1 / threaded != 0) so
    writing 0 continues to succeed as a no-op (Sashiko).
  - v2: https://lore.kernel.org/netdev/20260929010058.4063305-1-namangulati@google.com/
v2:
  - Check NAPI_STATE_NO_BUSY_POLL in modify_napi_threaded() instead of
    adding NAPI_STATE_NO_THREADED (Jakub).
  - v1: https://lore.kernel.org/all/20260918173413.3222413-1-namangulati@google.com/
---
 include/linux/netdevice.h | 2 ++
 net/core/gro_cells.c      | 1 +
 net/core/net-sysfs.c      | 8 ++++++++
 net/core/netdev-genl.c    | 6 ++++++
 4 files changed, 17 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e..eeba45b6a5be 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -433,6 +433,7 @@ enum {
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
 	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded NAPI poller will busy poll */
+	NAPI_STATE_PERCPU,		/* NAPI handler is run per-CPU - incompatible with threaded mode */
 };
 
 enum {
@@ -448,6 +449,7 @@ enum {
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
 	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_PERCPU		= BIT(NAPI_STATE_PERCPU),
 };
 
 enum gro_result {
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index d8c0a2867120..a321cc005607 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -92,6 +92,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net_device *dev)
 		local_lock_init(&cell->bh_lock);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
+		set_bit(NAPI_STATE_PERCPU, &cell->napi.state);
 
 		netif_napi_add(dev, &cell->napi, gro_cell_poll);
 		napi_enable(&cell->napi);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 352173df7578..9876616638cd 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -743,6 +743,7 @@ static ssize_t threaded_show(struct device *dev,
 
 static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 {
+	struct napi_struct *napi;
 	int ret;
 
 	if (list_empty(&dev->napi_list))
@@ -751,6 +752,13 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (val != 0 && val != 1)
 		return -EOPNOTSUPP;
 
+	if (val) {
+		list_for_each_entry(napi, &dev->napi_list, dev_list) {
+			if (test_bit(NAPI_STATE_PERCPU, &napi->state))
+				return -EOPNOTSUPP;
+		}
+	}
+
 	ret = netif_set_threaded(dev, val);
 
 	return ret;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index cb18db681640..2e54809fa61a 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -335,6 +335,12 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 		int ret;
 
 		threaded = nla_get_uint(info->attrs[NETDEV_A_NAPI_THREADED]);
+		if (threaded && test_bit(NAPI_STATE_PERCPU, &napi->state)) {
+			NL_SET_BAD_ATTR(info->extack,
+					info->attrs[NETDEV_A_NAPI_THREADED]);
+			return -EOPNOTSUPP;
+		}
+
 		ret = napi_set_threaded(napi, threaded);
 		if (ret)
 			return ret;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

