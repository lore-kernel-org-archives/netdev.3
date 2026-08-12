Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7546F49B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548853; cv=none; b=nqBN1jhG/ezrLB/B3TvleNwNREx2OXD5iYPzLL3nwZf8HlP6Jw1+NYFUtnXNP8rY92Gikz4zPxqMNRLJ6csvVv7VUi4wXzXLZ0Ep098XhtnL0h/ev2j70lUL47gqyW9L06ZjBMIwcSXIb1QSfY+OPpj1Qs4eanwbiK6XfFXEST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548853; c=relaxed/simple;
	bh=WwNgWwnXrUpWxkH6PwiaJh+4hLqmBIFUwOVjCIvnU3c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=r28WMhcMBqK6ilCbUMZnhS+MWXfvigSSHsp0KfPAc+WxcKsofr3vDuVJPpyuDTB4EmrL/c3Rd8W2S3wOMQpT5ESch+mrp4GQwvtupXti4xdv1qhc9z7yofz6nGwwcaKHIvE2uDnjcsN5FdnVzcOR4oFJK8y08aHj499PKMoNxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67CEshs6068999
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 23:54:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67CEshsg068996
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 23:54:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <39ed6ba0-bef0-4710-9790-ab13092521b1@I-love.SAKURA.ne.jp>
Date: Wed, 12 Aug 2026 23:54:38 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH v2] net: track raw dev_put()/dev_hold() usage under
 CONFIG_NET_DEV_REFCNT_TRACKER=y
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Network Development <netdev@vger.kernel.org>
References: <bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

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

This patch also introduces NETDEV_DEBUG_UNREGISTER event which is fired
when "unregister_netdevice: waiting for DEV to become free" is emitted.
This event offers ability to execute custom debug code only when
NETDEV_UNREGISTER event is failing to drop refcount. The  "#syz test"
command cannot be used without a reliable reproducer (and remaining bugs
are difficult to reproduce), but the ability to execute custom debug code
conpensates for lack of a reliable reproducer because it allows us to test
whether doing something after the kernel concluded that unregistration got
stuck makes differences. For example, commit 4efa91a28576 ("xfrm: always
flush state and policy upon NETDEV_UNREGISTER event") was made because
I succeeded to confirm that executing xfrm_dev_unregister() upon
NETDEV_DEBUG_UNREGISTER event made difference [3]. NETDEV_DEBUG_UNREGISTER
event has been also used for emitting debug messages and doing some actions
when debugging this problem in e.g. net/can/j1939 and drivers/infiniband
modules.

Since dumping all dev_put()/dev_hold() usage of a netdev which is stuck
at NETDEV_UNREGISTER event might emit 100+ call traces, it is important
to reduce amount of printk() messages in order to increase likeliness of
syzbot successfully capturing all dev_put()/dev_hold() usage. To reduce
amount of printk() messages, several functions are explicitly marked as
"noinline", and a filter function tries to reduce common part of traces.

Link: https://lkml.kernel.org/r/73ed3aa5-f6e1-47b6-9e5d-428ac1f4cbf3@I-love.SAKURA.ne.jp [1]
Link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=fc0f090e41e652d158f946c616cdd82baed3c8f4 [3]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  - Addressed sashiko's review comments at
    https://sashiko.dev/#/patchset/bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd%40I-love.SAKURA.ne.jp .

 include/linux/netdevice.h |  14 ++
 kernel/softirq.c          |   4 +
 kernel/workqueue.c        |   4 +
 net/core/dev.c            | 266 ++++++++++++++++++++++++++++++++++++++
 net/core/lock_debug.c     |   1 +
 net/socket.c              |  32 ++++-
 6 files changed, 314 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8840b126979f..12dc2c1dc031 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2144,6 +2144,8 @@ enum netdev_reg_state {
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
+ *
+ *	@netdev_trace_buffer_list: Linked list for debugging refcount leak.
  */
 
 struct net_device {
@@ -2300,6 +2302,9 @@ struct net_device {
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+	struct list_head	netdev_trace_buffer_list;
+#endif
 
 	unsigned int		operstate;
 	unsigned char		link_mode;
@@ -3250,6 +3255,7 @@ enum netdev_cmd {
 	NETDEV_OFFLOAD_XSTATS_REPORT_USED,
 	NETDEV_OFFLOAD_XSTATS_REPORT_DELTA,
 	NETDEV_XDP_FEAT_CHANGE,
+	NETDEV_DEBUG_UNREGISTER,
 };
 const char *netdev_cmd_to_name(enum netdev_cmd cmd);
 
@@ -4466,9 +4472,16 @@ static inline bool dev_nit_active(const struct net_device *dev)
 
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
@@ -4480,6 +4493,7 @@ static inline void __dev_put(struct net_device *dev)
 static inline void __dev_hold(struct net_device *dev)
 {
 	if (dev) {
+		save_netdev_trace_buffer(dev, 1);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 		this_cpu_inc(*dev->pcpu_refcnt);
 #else
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4425d8dce44b..c5c194bec36e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -576,6 +576,10 @@ static inline bool lockdep_softirq_start(void) { return false; }
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
index 78068ae8f28a..d761268686f2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3203,6 +3203,10 @@ static bool manage_workers(struct worker *worker)
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
index af260ff5462a..86fdaa096aed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1875,6 +1875,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd cmd)
 	N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTATS_DISABLE)
 	N(OFFLOAD_XSTATS_REPORT_USED) N(OFFLOAD_XSTATS_REPORT_DELTA)
 	N(XDP_FEAT_CHANGE)
+	N(DEBUG_UNREGISTER)
 	}
 #undef N
 	return "UNKNOWN_NETDEV_EVENT";
@@ -11582,6 +11583,14 @@ int netdev_refcnt_read(const struct net_device *dev)
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
@@ -11655,11 +11664,16 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 
 		if (time_after(jiffies, warning_time +
 			       READ_ONCE(netdev_unregister_timeout_secs) * HZ)) {
+			rtnl_lock();
 			list_for_each_entry(dev, list, todo_list) {
 				pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
 					 dev->name, netdev_refcnt_read(dev));
 				ref_tracker_dir_print(&dev->refcnt_tracker, 10);
+				call_netdevice_notifiers(NETDEV_DEBUG_UNREGISTER, dev);
+				dump_netdev_trace_buffer(dev);
 			}
+			__rtnl_unlock();
+			rcu_barrier();
 
 			warning_time = jiffies;
 		}
@@ -12059,6 +12073,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	dev->priv_len = sizeof_priv;
 
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+	INIT_LIST_HEAD(&dev->netdev_trace_buffer_list);
+#endif
 	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev");
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
@@ -12158,6 +12175,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 free_pcpu:
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	free_percpu(dev->pcpu_refcnt);
+	erase_netdev_trace_buffer(dev);
 free_dev:
 #endif
 	kvfree(dev);
@@ -12226,6 +12244,8 @@ void free_netdev(struct net_device *dev)
 	free_percpu(dev->pcpu_refcnt);
 	dev->pcpu_refcnt = NULL;
 #endif
+	erase_netdev_trace_buffer(dev);
+
 	free_percpu(dev->core_stats);
 	dev->core_stats = NULL;
 	free_percpu(dev->xdp_bulkq);
@@ -13229,6 +13249,12 @@ static struct smp_hotplug_thread backlog_threads = {
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
@@ -13237,6 +13263,7 @@ static int __init net_dev_init(void)
 {
 	int i, rc = -ENOMEM;
 
+	net_dev_refcnt_tracker_init();
 	BUG_ON(!dev_boot_phase);
 
 	net_dev_struct_check();
@@ -13340,3 +13367,242 @@ static int __init net_dev_init(void)
 }
 
 subsys_initcall(net_dev_init);
+
+#if defined(CONFIG_NET_DEV_REFCNT_TRACKER) && defined(CONFIG_KALLSYMS)
+
+#define NETDEV_TRACE_BUFFER_SIZE 32768
+static struct netdev_trace_buffer {
+	struct list_head list;
+	atomic_t count;
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
+	char buffer[32] = { };
+	char *cp;
+	int i;
+
+	for (i = 0; i < nr_entries; i++) {
+		snprintf(buffer, sizeof(buffer) - 1, "%ps", (void *)entries[i]);
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
+	/* Trim common traces. */
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		ptr->nr_entries = trim_netdev_trace(ptr->entries, ptr->nr_entries);
+	}
+	/* Merge duplicated entries after trimming common traces. */
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		/* Skip empty entries. */
+		if (!atomic_read(&ptr->count))
+			continue;
+		list_for_each_entry_rcu(tmp, &ptr->list, list,
+					/* list elements can't go away. */ 1) {
+			if (ptr->nr_entries != tmp->nr_entries ||
+			    memcmp(ptr->entries, tmp->entries,
+				   ptr->nr_entries * sizeof(unsigned long)))
+				continue;
+			/* Skip empty entries. */
+			count = atomic_read(&tmp->count);
+			if (!count)
+				continue;
+			/* Move count from non-first entry to first entry. */
+			atomic_add(count, &ptr->count);
+			atomic_sub(count, &tmp->count);
+		}
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
+		stack_trace_print(ptr->entries, ptr->nr_entries, 4);
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
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 8a81c5430705..c1a44594c492 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -29,6 +29,7 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
 	case NETDEV_UNREGISTER:
+	case NETDEV_DEBUG_UNREGISTER:
 	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGEADDR:
 	case NETDEV_PRE_CHANGEADDR:
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e..af7e99636495 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -698,7 +698,11 @@ struct socket *sock_alloc(void)
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
 
@@ -770,7 +774,13 @@ static noinline void call_trace_sock_send_length(struct sock *sk, int ret,
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
@@ -1120,8 +1130,13 @@ static noinline void call_trace_sock_recv_length(struct sock *sk, int ret, int f
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
@@ -2624,9 +2639,12 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
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
2.55.0
