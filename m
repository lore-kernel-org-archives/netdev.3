Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04E51C04D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752879; cv=none; b=HF4EwhNbNb6Gf9sWFnVv5EInAFiR/kns9IICTUK4T7Da3CmKf/fjzmmQ0yUm30s3/u2LMPRlmymEn2PDnOZis7t8ardykCN9rYx+k2laHWobPAZ/1Uhm9lU3Ih/fHqeGmP78qxCFsZfHBmIBLN5m1wH5+g9SLRYtgtv5OeubA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752879; c=relaxed/simple;
	bh=0/XPLyNXFdmG/2rLT7tRv7BIlIWTa5xqE/HKbfeGTlw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kbLzbcdH3KTem5t43N1WthQOHqRDFNPmHUzwOYAcyYMtEv46/PkN7naKca1oj8w1quUEbeZixI004Y9tlQZjE7QcRvxW4ZGO+bL9yxf2+yP1JgI7QIAY4dChuM39qhQTzPT58U9UVIEqVPoi8DOaQcwW806rimGaO9JlgkoLoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMCDCopD; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMCDCopD"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1b824e84so198761385a.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789752868; x=1790357668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C6AEc4cXydGQr/Exrh5t746/leuXeKYVLsE6wKQpIs4=;
        b=SMCDCopDTtHput4Zhi2tNQBr0wIcHetsRp48qWRHEgU5zmf2iPj+9EhZcxakNqjMml
         1d3w4hTyI+MHAn7otG9wOab92nBdiBNu0pw3URAA5ZZL7flXLyJseOIXGBnxkC49lQp3
         qmxkSWfJJkRN2lG3PEcnrzryJ7SmwjwTjdrCqPPCFSkp/DtYoFZ2C/I8Iw/XGCnLPhFo
         +QTs6eKXE/Su0BPVCEDRJiF5XGMInpI+gk1MifpraNn+E/wGSyvUdvb3YBtoQ2bGSL6P
         jo1MZ1dNrkzPvneTm5VXWfWdHlXeO9+W81z99m4shjNc2NH12ATnEllbbOiY+cSl+eFh
         2Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752868; x=1790357668;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6AEc4cXydGQr/Exrh5t746/leuXeKYVLsE6wKQpIs4=;
        b=a+BZQVpOhGMriA0oXCn2CvySlu2mwdguIeTYim/xhes7tBq3hs2Qho0MUj2KkxIXyQ
         +t4okZsgs3ZvvzcZFsgTlqrjIFqVudiMb6eaqK+uiKh+mF9VkPmTZatf7E16lv+4DM7p
         FIMzCcFYDL0FJqwo8p5fEBVVKJ70NwUW1xCXsj7GIP0EgEQ+aq6pLJIZOmNyYvUpclOx
         z+78chlY9gHzA7JmpyEYBOqW1lLmbNWrySGRl42zyAFk3RnnDah1RCXyEhdSH0oSBCyk
         vpolLABAhZiHPgEpadPOj92fwaqniVaqz6/Nz7EOpnOxxL6CFIJX5+r6VGGntL9JO7s7
         Ub5g==
X-Gm-Message-State: AFuF++nkYvXU3wjDtJ61DoBE1d4hvc3uknhjVsE+U55eRipV46UIfEll
	mDdfFqmog+MndipXxwQa7ZqdNgdJsG6T35SJCXe9E941RCBTUEDlh3lCwZmQv77desUhSq2vms6
	n0Yq2AqeeNMBWwrW7kEBy+vXJwT0nS5kvqLT56WLCwwJYjZxbnIVI9URuFQDqOZy0F4bCXLbcfi
	fqyPkX9AEVtcxIdos/K30aih5FXJe8bOZh+c11FfH5TVJ9h1l5qt6DwptxK6DS+30=
X-Received: from qknxx24.prod.google.com ([2002:a05:620a:5d98:b0:939:eccf:df56])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4148:b0:93a:5d6:9ef2 with SMTP id af79cd13be357-93bdc70b23emr475000685a.36.1789752867495;
 Fri, 18 Sep 2026 10:34:27 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:34:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918173413.3222413-1-namangulati@google.com>
Subject: [PATCH net] net: gro_cells: prevent enabling threaded NAPI on gro_cells
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
gre0, vxlan, geneve) via sysfs or Netlink, unbound kernel threads are
created for each per-CPU NAPI. When gro_cells_receive() on CPU A
enqueues a packet to cell_A and calls napi_schedule(&cell_A->napi)
while holding cell_A->bh_lock, the woken kthread can run concurrently
on remote CPU B.

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

Virtual per-CPU NAPIs cannot support unbound threaded NAPI. Just as
gro_cells sets NAPI_STATE_NO_BUSY_POLL because virtual NAPIs cannot
support busy polling, introduce NAPI_STATE_NO_THREADED to indicate that
threaded mode is not supported.

Set NAPI_STATE_NO_THREADED in gro_cells_init(), and fail early with
-EOPNOTSUPP when trying to enable threaded napi on gro_cells netdevs.

Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
Reported-by: syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6aad6d7b.0c43d342.320d00.0001.GAE@google.com
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Naman Gulati <namangulati@google.com>
---
 include/linux/netdevice.h | 2 ++
 net/core/gro_cells.c      | 1 +
 net/core/net-sysfs.c      | 4 +++-
 net/core/netdev-genl.c    | 3 +++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e..951734bc8b36 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -433,6 +433,7 @@ enum {
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
 	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded NAPI poller will busy poll */
+	NAPI_STATE_NO_THREADED,		/* Threaded mode is not supported */
 };
 
 enum {
@@ -448,6 +449,7 @@ enum {
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
 	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_NO_THREADED		= BIT(NAPI_STATE_NO_THREADED),
 };
 
 enum gro_result {
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index d8c0a2867120..9f8884d56f59 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -92,6 +92,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net_device *dev)
 		local_lock_init(&cell->bh_lock);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
+		set_bit(NAPI_STATE_NO_THREADED, &cell->napi.state);
 
 		netif_napi_add(dev, &cell->napi, gro_cell_poll);
 		napi_enable(&cell->napi);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 352173df7578..296fdc007862 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -743,9 +743,11 @@ static ssize_t threaded_show(struct device *dev,
 
 static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 {
+	struct napi_struct *napi;
 	int ret;
 
-	if (list_empty(&dev->napi_list))
+	napi = list_first_entry_or_null(&dev->napi_list, typeof(*napi), dev_list);
+	if (!napi || test_bit(NAPI_STATE_NO_THREADED, &napi->state))
 		return -EOPNOTSUPP;
 
 	if (val != 0 && val != 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index cb18db681640..661f87e2f015 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -334,6 +334,9 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
 		int ret;
 
+		if (test_bit(NAPI_STATE_NO_THREADED, &napi->state))
+			return -EOPNOTSUPP;
+
 		threaded = nla_get_uint(info->attrs[NETDEV_A_NAPI_THREADED]);
 		ret = napi_set_threaded(napi, threaded);
 		if (ret)
-- 
2.55.0.1082.g2b9226bbc0-goog

