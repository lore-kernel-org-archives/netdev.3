Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DDA2E229F
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788015563; cv=none; b=neMAKfFdK2NKD+mPRJ0o1wRnmkmpljvgF2jfv7r4vDX7NVhn4zKp5aRfZDcl5SYghZOykwbPgzJmi51r5Xr7vR42CMhXXMIeijxXr0VtjLKROTawYuMeBsNYgtXszzUnRo7C2pt+sMxnRdSSID0MsAEEZMRzdX9mb6BklrfrviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788015563; c=relaxed/simple;
	bh=qOyBvfXMlfQ8upidsqZBpfNTzqO1ILjMsi+2dQLsqtQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FKmrWP+sxkZU2653GFGXHjXnCiadN2o3BJlvCuyYNJRmO5BGTAvQ+8nxc9w00u/+4hZd8fL53yG+MP4FrhvvHWOrlEGM6i6pbASQylfsropGKiOc8h+rXIX1+aQULLrQOxvKp6o/svVwa41UNd+8EK7dOxChMtUmvnpOwKtKfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67TEx6Xs091344;
	Sat, 29 Aug 2026 23:59:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67TEx1EC091305
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 29 Aug 2026 23:59:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <271af679-34c1-4f7e-875c-4761c22595eb@I-love.SAKURA.ne.jp>
Date: Sat, 29 Aug 2026 23:58:58 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] net: track raw dev_put()/dev_hold() usage under
 CONFIG_NET_DEV_REFCNT_TRACKER=y
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Network Development <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp>
 <39ed6ba0-bef0-4710-9790-ab13092521b1@I-love.SAKURA.ne.jp>
 <591e7555-a399-4753-becb-b00df2df660d@I-love.SAKURA.ne.jp>
 <56c707e7-1fb0-43ec-b8fb-cf6f451e513e@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <56c707e7-1fb0-43ec-b8fb-cf6f451e513e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav313.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is still reporting

  unregister_netdevice: waiting for DEV to become free

problems. There is netdevice_tracker which helps identifying culprit
module, but one of barriers is that not all existing callers are using
netdevice_tracker and nobody is willing to convert existing callers to use
netdevice_tracker. Recently, AI system is acquiring ability to analyze
imbalance of raw dev_put()/dev_hold() usage (i.e. without converting to
netdevice_tracker), as long as we succeed to dump all dev_put()/dev_hold()
usage [1].

This patch introduces buffer for tracking raw dev_put()/dev_hold() usage.
This mechanism helped fixing 10 bugs using linux-next tree [2]. However,
since remaining bugs are no longer easily reproducible in linux-next tree,
I want to make this mechanism available in networking trees.

Since dumping all dev_put()/dev_hold() usage of a netdev which is stuck
at NETDEV_UNREGISTER event might emit 100+ call traces, it is important
to reduce amount of printk() messages in order to increase likeliness of
syzbot successfully capturing all dev_put()/dev_hold() usage. To reduce
amount of printk() messages, several functions are explicitly marked as
"noinline", and a filter function tries to reduce common part of traces.

Link: https://lkml.kernel.org/r/73ed3aa5-f6e1-47b6-9e5d-428ac1f4cbf3@I-love.SAKURA.ne.jp [1]
Link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 [2]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
To: Eric
  Please see off-list mail <e2f7c53b-fe15-4047-8149-145c91de297f@I-love.SAKURA.ne.jp> .

Changes in v3:
  - Repost as v3, as sashiko's review comments at
    https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e513e@I-love.SAKURA.ne.jp
    was addressed. I assume that no more technical problem remains, and only how to split
    this patch into several patches for getting approval from relevant subsystems remains.

Changes in v2.2:
  - Addressed sashiko's review comments at
    https://sashiko.dev/#/patchset/591e7555-a399-4753-becb-b00df2df660d%40I-love.SAKURA.ne.jp .

Changes in v2.1:
  - Addressed sashiko's review comments at
    https://sashiko.dev/#/patchset/39ed6ba0-bef0-4710-9790-ab13092521b1%40I-love.SAKURA.ne.jp .
  - Dropped NETDEV_DEBUG_UNREGISTER event.
  - Added rcu_do_batch() as one of explicit "noinline" functions.

Changes in v2:
  - Addressed sashiko's review comments at
    https://sashiko.dev/#/patchset/bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd%40I-love.SAKURA.ne.jp .

 include/linux/netdevice.h |  13 ++
 kernel/rcu/tree.c         |   4 +
 kernel/softirq.c          |   4 +
 kernel/workqueue.c        |   4 +
 net/core/dev.c            | 272 ++++++++++++++++++++++++++++++++++++++
 net/socket.c              |  32 ++++-
 6 files changed, 322 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e..d518338cd074 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2153,6 +2153,8 @@ enum netdev_reg_state {
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
+ *
+ *	@netdev_trace_buffer_list: Linked list for debugging refcount leak.
  */
 
 struct net_device {
@@ -2312,6 +2314,9 @@ struct net_device {
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+	struct list_head	netdev_trace_buffer_list;
+#endif
 
 	unsigned int		operstate;
 	unsigned char		link_mode;
@@ -4498,9 +4503,16 @@ static inline bool dev_nit_active(const struct net_device *dev)
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev);
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+void save_netdev_trace_buffer(struct net_device *dev, int delta);
+#else
+static inline void save_netdev_trace_buffer(struct net_device *dev, int delta) { }
+#endif
+
 static inline void __dev_put(struct net_device *dev)
 {
 	if (dev) {
+		save_netdev_trace_buffer(dev, -1);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 		this_cpu_dec(*dev->pcpu_refcnt);
 #else
@@ -4512,6 +4524,7 @@ static inline void __dev_put(struct net_device *dev)
 static inline void __dev_hold(struct net_device *dev)
 {
 	if (dev) {
+		save_netdev_trace_buffer(dev, 1);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 		this_cpu_inc(*dev->pcpu_refcnt);
 #else
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96848fc1f02b..20c4c92708b8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2566,6 +2566,10 @@ static bool rcu_do_batch_check_time(long count, long tlimit,
 	       local_clock() >= tlimit;
 }
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+static noinline void rcu_do_batch(struct rcu_data *rdp);
+#endif
+
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Throttle as specified by rdp->blimit.
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7980a4a232f9..ad9889563288 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -599,6 +599,10 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+static noinline void handle_softirqs(bool ksirqd);
+#endif
+
 static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3c034cbc5bb3..60daae1c6f17 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3259,6 +3259,10 @@ static bool manage_workers(struct worker *worker)
 	return true;
 }
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+static noinline void process_one_work(struct worker *worker, struct work_struct *work);
+#endif
+
 /**
  * process_one_work - process single work
  * @worker: self
diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..93a7594d586e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11639,6 +11639,14 @@ int netdev_refcnt_read(const struct net_device *dev)
 }
 EXPORT_SYMBOL(netdev_refcnt_read);
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+static void dump_netdev_trace_buffer(const struct net_device *dev);
+static void erase_netdev_trace_buffer(const struct net_device *dev);
+#else
+static inline void dump_netdev_trace_buffer(const struct net_device *dev) { }
+static inline void erase_netdev_trace_buffer(const struct net_device *dev) { }
+#endif
+
 int netdev_unregister_timeout_secs __read_mostly = 10;
 
 #define WAIT_REFS_MIN_MSECS 1
@@ -11721,6 +11729,7 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 				pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
 					 dev->name, netdev_refcnt_read(dev));
 				ref_tracker_dir_print(&dev->refcnt_tracker, 10);
+				dump_netdev_trace_buffer(dev);
 			}
 
 			warning_time = jiffies;
@@ -12121,6 +12130,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	dev->priv_len = sizeof_priv;
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+	INIT_LIST_HEAD(&dev->netdev_trace_buffer_list);
+#endif
 	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev");
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
@@ -12223,6 +12235,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 free_pcpu:
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
+	erase_netdev_trace_buffer(dev);
 free_dev:
 #endif
 	ref_tracker_dir_exit(&dev->refcnt_tracker);
@@ -12292,6 +12305,7 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->pcpu_refcnt);
 	dev->pcpu_refcnt = NULL;
 #endif
+	erase_netdev_trace_buffer(dev);
 	free_percpu(dev->core_stats);
 	dev->core_stats = NULL;
 	free_percpu(dev->xdp_bulkq);
@@ -13418,6 +13432,12 @@ static struct smp_hotplug_thread backlog_threads = {
 	.setup			= backlog_napi_setup,
 };
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+static void __init net_dev_refcnt_tracker_init(void);
+#else
+static void __init net_dev_refcnt_tracker_init(void) { };
+#endif
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -13426,6 +13446,7 @@ static int __init net_dev_init(void)
 {
 	int i, rc = -ENOMEM;
 
+	net_dev_refcnt_tracker_init();
 	BUG_ON(!dev_boot_phase);
 
 	net_dev_struct_check();
@@ -13529,3 +13550,254 @@ static int __init net_dev_init(void)
 }
 
 subsys_initcall(net_dev_init);
+
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+
+#define NETDEV_TRACE_BUFFER_SIZE 32768
+static struct netdev_trace_buffer {
+	struct list_head list;
+	atomic_t count;
+	int trimmed_entries;
+	int nr_entries;
+	unsigned long entries[20];
+} netdev_trace_buffer[NETDEV_TRACE_BUFFER_SIZE];
+static LIST_HEAD(netdev_trace_buffer_list);
+static DEFINE_RAW_SPINLOCK(netdev_trace_buffer_lock);
+static bool netdev_trace_buffer_exhausted;
+static unsigned long start_of_handle_softirqs __ro_after_init;
+static unsigned long end_of_handle_softirqs __ro_after_init;
+
+static int netdev_trace_buffer_init(void)
+{
+	int i;
+
+	for (i = 0; i < NETDEV_TRACE_BUFFER_SIZE; i++)
+		list_add_tail(&netdev_trace_buffer[i].list, &netdev_trace_buffer_list);
+	return 0;
+}
+pure_initcall(netdev_trace_buffer_init);
+
+static int trim_netdev_trace(unsigned long *entries, int nr_entries)
+{
+	char buffer[KSYM_SYMBOL_LEN] = { };
+	char *cp;
+	int i;
+
+	for (i = 0; i < nr_entries; i++) {
+		sprint_symbol_no_offset(buffer, entries[i]);
+		cp = strchr(buffer, ' ');
+		if (cp)
+			*cp = '\0';
+		if (buffer[0] == 'p') {
+			if (!strcmp(buffer, "process_one_work"))
+				return i + 1;
+		} else if (buffer[0] == 'k') {
+			if (!strcmp(buffer, "ksys_unshare"))
+				return i + 1;
+		} else if (buffer[0] == 's') {
+			if (!strcmp(buffer, "sock_sendmsg_nosec") ||
+			    !strcmp(buffer, "sock_recvmsg_nosec"))
+				return i + 1;
+		} else if (buffer[0] == 'r') {
+			if (!strcmp(buffer, "rcu_do_batch"))
+				return i + 1;
+		} else if (buffer[0] == '_') {
+			if (!strcmp(buffer, "__sys_bind") ||
+			    !strcmp(buffer, "__sock_release") ||
+			    !strcmp(buffer, "__sys_bpf"))
+				return i + 1;
+		} else {
+			if (!strcmp(buffer, "do_sock_setsockopt"))
+				return i + 1;
+		}
+	}
+	return nr_entries;
+}
+
+static void dump_netdev_trace_buffer(const struct net_device *dev)
+{
+	struct netdev_trace_buffer *ptr, *tmp;
+	int count, balance = 0, pos = 0;
+
+	/* Update trimmed_entries field. Do not modify nr_entries field
+	 * in case save_netdev_trace_buffer() is called again.
+	 */
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		if (ptr->trimmed_entries == ptr->nr_entries)
+			ptr->trimmed_entries = trim_netdev_trace(ptr->entries, ptr->nr_entries);
+	}
+	/* Merge duplicated entries using trimmed_entries field. */
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		/* Skip empty entries. */
+		if (!atomic_read(&ptr->count))
+			continue;
+		tmp = ptr;
+		list_for_each_entry_continue_rcu(tmp, &dev->netdev_trace_buffer_list, list) {
+			if (ptr->trimmed_entries != tmp->trimmed_entries ||
+			    memcmp(ptr->entries, tmp->entries,
+				   ptr->trimmed_entries * sizeof(unsigned long)))
+				continue;
+			/* Skip empty entries. */
+			count = atomic_read(&tmp->count);
+			if (!count)
+				continue;
+			/* Move count from non-first entry to first entry. */
+			atomic_add(count, &ptr->count);
+			atomic_sub(count, &tmp->count);
+		}
+		/* It is safe to call cond_resched() because this function is
+		 * called from schedulable context.
+		 */
+		cond_resched();
+	}
+	/* Report all entries for this device. */
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		/* Skip empty entries. */
+		count = atomic_read(&ptr->count);
+		if (!count)
+			continue;
+		/* Report this entry. It is safe to call cond_resched() because
+		 * this function is called from schedulable context.
+		 */
+		pos++;
+		balance += count;
+		pr_info("Call trace for %s[%d] %+d at\n", dev->name, pos, count);
+		stack_trace_print(ptr->entries, ptr->trimmed_entries, 4);
+		cond_resched();
+	}
+	if (!netdev_trace_buffer_exhausted)
+		pr_info("balance as of %s[%d] is %d\n", dev->name, pos, balance);
+}
+
+static void erase_netdev_trace_buffer(const struct net_device *dev)
+{
+	struct netdev_trace_buffer *ptr;
+	unsigned long flags;
+
+	/* This function is called after free_percpu(dev->pcpu_refcnt) was already
+	 * called, which means that no more __dev_put()/__dev_hold() call can be made.
+	 * Therefore, no more save_netdev_trace_buffer() call will be made, and we can
+	 * safely return list elements to netdev_trace_buffer_list.
+	 */
+	raw_spin_lock_irqsave(&netdev_trace_buffer_lock, flags);
+	while (!list_empty(&dev->netdev_trace_buffer_list)) {
+		ptr = list_first_entry(&dev->netdev_trace_buffer_list, typeof(*ptr), list);
+		list_del(&ptr->list);
+		list_add_tail(&ptr->list, &netdev_trace_buffer_list);
+	}
+	raw_spin_unlock_irqrestore(&netdev_trace_buffer_lock, flags);
+}
+
+void save_netdev_trace_buffer(struct net_device *dev, int delta)
+{
+	struct netdev_trace_buffer *ptr;
+	unsigned long entries[ARRAY_SIZE(ptr->entries)];
+	int nr_entries;
+	unsigned long flags;
+
+	/* This function is not NMI-safe. Give up if called from NMI context. */
+	if (in_nmi())
+		return;
+	/* Get stack traces. */
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(ptr->entries), 1);
+	/* Trim traces of process context now if called from softirq context, for
+	 * we will easily exhaust netdev_trace_buffer_list if we don't trim traces
+	 * of process context when trying to compare with existing entries.
+	 *
+	 * Avoid kallsyms lookup, by using cached address resolved upon boot.
+	 */
+	if (in_softirq()) {
+		int i;
+
+		for (i = 0; i < nr_entries; i++) {
+			if (entries[i] >= start_of_handle_softirqs &&
+			    entries[i] < end_of_handle_softirqs) {
+				nr_entries = i + 1;
+				break;
+			}
+		}
+	}
+	/* Compare with existing entries at best-effort basis. Since duplicated entries
+	 * created by race condition will be merged when reporting, we don't use lock here.
+	 */
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		if (ptr->nr_entries == nr_entries &&
+		    !memcmp(ptr->entries, entries, nr_entries * sizeof(unsigned long))) {
+			atomic_add(delta, &ptr->count);
+			return;
+		}
+	}
+	/* Add a new entry. We don't re-compare with existing entries with lock held, for
+	 * duplicated entries created by race condition will be merged when reporting.
+	 * But we use raw spinlock here in case this function is called with some other
+	 * raw spinlock already held.
+	 */
+	raw_spin_lock_irqsave(&netdev_trace_buffer_lock, flags);
+	if (!list_empty(&netdev_trace_buffer_list)) {
+		/* Remove one entry from netdev_trace_buffer_list and initialize it. */
+		ptr = list_first_entry(&netdev_trace_buffer_list, typeof(*ptr), list);
+		list_del(&ptr->list);
+		atomic_set(&ptr->count, delta);
+		ptr->nr_entries = nr_entries;
+		ptr->trimmed_entries = nr_entries;
+		memmove(ptr->entries, entries, nr_entries * sizeof(unsigned long));
+		/* Append it in RCU manner, for readers are lockless. */
+		list_add_tail_rcu(&ptr->list, &dev->netdev_trace_buffer_list);
+	} else {
+		netdev_trace_buffer_exhausted = true;
+	}
+	raw_spin_unlock_irqrestore(&netdev_trace_buffer_lock, flags);
+}
+EXPORT_SYMBOL(save_netdev_trace_buffer);
+
+struct timer_completion_struct {
+	struct timer_list timer;
+	struct completion completion;
+};
+
+/* Resolve address of handle_softirqs() and cache it, in order to avoid looking up
+ * kallsyms every time.
+ */
+static void __init netdev_addr_resolve_func(struct timer_list *timer)
+{
+	unsigned long entries[40];
+	int nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
+	char buffer[KSYM_SYMBOL_LEN] = { };
+	unsigned long offset, size;
+	char *cp;
+	int i;
+
+	for (i = 0; i < nr_entries; i++) {
+		sprint_symbol(buffer, entries[i]);
+		if (strncmp(buffer, "handle_softirqs", 15))
+			continue;
+		cp = strchr(buffer, '+');
+		if (!cp || sscanf(cp, "+%lx/%lx", &offset, &size) != 2)
+			continue;
+		start_of_handle_softirqs = entries[i] - offset;
+		end_of_handle_softirqs = start_of_handle_softirqs + size;
+		break;
+	}
+	complete(&container_of(timer, struct timer_completion_struct, timer)->completion);
+}
+
+static void __init net_dev_refcnt_tracker_init(void)
+{
+	struct timer_completion_struct tc;
+
+	timer_setup_on_stack(&tc.timer, netdev_addr_resolve_func, 0);
+	init_completion(&tc.completion);
+	/* Schedule a call to netdev_addr_resolve_func(). */
+	mod_timer(&tc.timer, jiffies);
+	/* Wait for netdev_addr_resolve_func() to be called. */
+	wait_for_completion(&tc.completion);
+	/* Wait for netdev_addr_resolve_func() to complete. */
+	timer_delete_sync(&tc.timer);
+	timer_destroy_on_stack(&tc.timer);
+}
+
+#endif
diff --git a/net/socket.c b/net/socket.c
index c05d86e63abf..b3ddcc283cbb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -723,7 +723,11 @@ struct socket *sock_alloc(void)
 }
 EXPORT_SYMBOL(sock_alloc);
 
-static void __sock_release(struct socket *sock, struct inode *inode)
+static
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+noinline
+#endif
+void __sock_release(struct socket *sock, struct inode *inode)
 {
 	const struct proto_ops *ops = READ_ONCE(sock->ops);
 
@@ -795,7 +799,13 @@ static noinline void call_trace_sock_send_length(struct sock *sk, int ret,
 	trace_sock_send_length(sk, ret, 0);
 }
 
-static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
+static
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+noinline
+#else
+inline
+#endif
+int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 {
 	int ret = INDIRECT_CALL_INET(READ_ONCE(sock->ops)->sendmsg, inet6_sendmsg,
 				     inet_sendmsg, sock, msg,
@@ -1145,8 +1155,13 @@ static noinline void call_trace_sock_recv_length(struct sock *sk, int ret, int f
 	trace_sock_recv_length(sk, ret, flags);
 }
 
-static inline int sock_recvmsg_nosec(struct socket *sock, struct msghdr *msg,
-				     int flags)
+static
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+noinline
+#else
+inline
+#endif
+int sock_recvmsg_nosec(struct socket *sock, struct msghdr *msg, int flags)
 {
 	int ret = INDIRECT_CALL_INET(READ_ONCE(sock->ops)->recvmsg,
 				     inet6_recvmsg,
@@ -2653,9 +2668,12 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
 	return err < 0 ? err : 0;
 }
 
-static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
-			   unsigned int flags, struct used_address *used_address,
-			   unsigned int allowed_msghdr_flags)
+static
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+noinline
+#endif
+int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys, unsigned int flags,
+		    struct used_address *used_address, unsigned int allowed_msghdr_flags)
 {
 	unsigned char ctl[sizeof(struct cmsghdr) + 20]
 				__aligned(sizeof(__kernel_size_t));
-- 
2.52.0

