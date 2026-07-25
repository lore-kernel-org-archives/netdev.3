Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF533993
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784984205; cv=none; b=m5Gu0H+6t84IYbQX5Z5gp9z2ENUAv5mkcQ4+wls/aDhC86HZVsRTQeRtB5kKs89EhwMhNgb2Rj1RqGaAHyE1KchURe0uFzcvStdKj2zZ8tgNf/ZmXZr7XJJCTDU/M0ReNPt1FNKlrfvwCAxibWBD+6BbPbt2xrlQ4WwuGApJ7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784984205; c=relaxed/simple;
	bh=Ot1QowPC314VXeon9n3iHdxxE/xIMFurwRFMl/uXPt4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UpUfEtH3XkmBFS1REpB7Y67DoIF6qDJSsdsRgqj9Z9kcfqFebSdnH/PyvjMI2XuBD9FfH0u0YND7DXjComjN56AC/g56qxICqLQfNh3dmlgkxLhdYBTpkuVh2fIRr+Nip9ZGUHpaUOcoK7bjGI83TM3R5dQgdYfVfIN+78SaUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 66PCudYu041299;
	Sat, 25 Jul 2026 21:56:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 66PCudb5041296
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 25 Jul 2026 21:56:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp>
Date: Sat, 25 Jul 2026 21:56:38 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Network Development <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH] net: track raw dev_put()/dev_hold() usage under
 CONFIG_NET_DEV_REFCNT_TRACKER=y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
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
When I queried about this patch at
https://lkml.kernel.org/r/e0c7030b-261c-4ed1-b6b0-bf3b83a41d60@I-love.SAKURA.ne.jp ,
I received little interest/response and the conversation died immediately.
I hope we can continue conversation this time...

 include/linux/netdevice.h |  15 +++
 kernel/softirq.c          |   4 +
 kernel/workqueue.c        |   4 +
 net/core/dev.c            | 187 ++++++++++++++++++++++++++++++++++++++
 net/core/lock_debug.c     |   1 +
 net/socket.c              |  32 +++++--
 6 files changed, 236 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..987c3c87f14f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2142,6 +2142,8 @@ enum netdev_reg_state {
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
+ *
+ *	@netdev_trace_buffer_list: Linked list for debugging refcount leak.
  */
 
 struct net_device {
@@ -2298,6 +2300,9 @@ struct net_device {
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+	struct list_head	netdev_trace_buffer_list;
+#endif
 
 	unsigned int		operstate;
 	unsigned char		link_mode;
@@ -3248,6 +3253,7 @@ enum netdev_cmd {
 	NETDEV_OFFLOAD_XSTATS_REPORT_USED,
 	NETDEV_OFFLOAD_XSTATS_REPORT_DELTA,
 	NETDEV_XDP_FEAT_CHANGE,
+	NETDEV_DEBUG_UNREGISTER,
 };
 const char *netdev_cmd_to_name(enum netdev_cmd cmd);
 
@@ -4469,9 +4475,15 @@ static inline bool dev_nit_active(const struct net_device *dev)
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev);
 
+void save_netdev_trace_buffer(struct net_device *dev, int delta);
+int trim_netdev_trace(unsigned long *entries, int nr_entries);
+
 static inline void __dev_put(struct net_device *dev)
 {
 	if (dev) {
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+		save_netdev_trace_buffer(dev, -1);
+#endif
 #ifdef CONFIG_PCPU_DEV_REFCNT
 		this_cpu_dec(*dev->pcpu_refcnt);
 #else
@@ -4483,6 +4495,9 @@ static inline void __dev_put(struct net_device *dev)
 static inline void __dev_hold(struct net_device *dev)
 {
 	if (dev) {
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+		save_netdev_trace_buffer(dev, 1);
+#endif
 #ifdef CONFIG_PCPU_DEV_REFCNT
 		this_cpu_inc(*dev->pcpu_refcnt);
 #else
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4425d8dce44b..a3bd54de8259 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -576,6 +576,10 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+static noinline void handle_softirqs(bool ksirqd);
+#endif
+
 static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78068ae8f28a..78f25afb4a9d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3203,6 +3203,10 @@ static bool manage_workers(struct worker *worker)
 	return true;
 }
 
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+static noinline void process_one_work(struct worker *worker, struct work_struct *work);
+#endif
+
 /**
  * process_one_work - process single work
  * @worker: self
diff --git a/net/core/dev.c b/net/core/dev.c
index 5933c5dab09e..d7e8cb7a3ef4 100644
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
@@ -11581,6 +11582,14 @@ int netdev_refcnt_read(const struct net_device *dev)
 }
 EXPORT_SYMBOL(netdev_refcnt_read);
 
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+static void dump_netdev_trace_buffer(const struct net_device *dev);
+static void erase_netdev_trace_buffer(const struct net_device *dev);
+#else
+static inline void dump_netdev_trace_buffer(const struct net_device *dev) { }
+static inline void erase_netdev_trace_buffer(const struct net_device *dev) { }
+#endif
+
 int netdev_unregister_timeout_secs __read_mostly = 10;
 
 #define WAIT_REFS_MIN_MSECS 1
@@ -11654,11 +11663,16 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 
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
@@ -12058,6 +12072,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	dev->priv_len = sizeof_priv;
 
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+	INIT_LIST_HEAD(&dev->netdev_trace_buffer_list);
+#endif
 	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev");
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
@@ -12234,6 +12251,8 @@ void free_netdev(struct net_device *dev)
 
 	mutex_destroy(&dev->lock);
 
+	erase_netdev_trace_buffer(dev);
+
 	/*  Compatibility with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED ||
 	    dev->reg_state == NETREG_DUMMY) {
@@ -13338,3 +13357,171 @@ static int __init net_dev_init(void)
 }
 
 subsys_initcall(net_dev_init);
+
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+
+#define NETDEV_TRACE_BUFFER_SIZE 32768
+static struct netdev_trace_buffer {
+	struct list_head list;
+	int prev_count;
+	atomic_t count;
+	int nr_entries;
+	unsigned long entries[20];
+} netdev_trace_buffer[NETDEV_TRACE_BUFFER_SIZE];
+static LIST_HEAD(netdev_trace_buffer_list);
+static DEFINE_SPINLOCK(netdev_trace_buffer_lock);
+static bool netdev_trace_buffer_exhausted;
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
+static void dump_netdev_trace_buffer(const struct net_device *dev)
+{
+	struct netdev_trace_buffer *ptr;
+	int count, balance = 0, pos = 0;
+
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		pos++;
+		count = atomic_read(&ptr->count);
+		balance += count;
+		if (ptr->prev_count == count)
+			continue;
+		ptr->prev_count = count;
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
+	spin_lock_irqsave(&netdev_trace_buffer_lock, flags);
+	while (!list_empty(&dev->netdev_trace_buffer_list)) {
+		ptr = list_first_entry(&dev->netdev_trace_buffer_list, typeof(*ptr), list);
+		list_del(&ptr->list);
+		list_add_tail(&ptr->list, &netdev_trace_buffer_list);
+	}
+	spin_unlock_irqrestore(&netdev_trace_buffer_lock, flags);
+}
+
+int trim_netdev_trace(unsigned long *entries, int nr_entries)
+{
+#ifdef CONFIG_KALLSYMS
+	char buffer[32] = { };
+	char *cp;
+	int i;
+
+	if (in_softirq()) {
+		static unsigned long __data_racy caller;
+
+		if (!caller) {
+			for (i = 0; i < nr_entries; i++) {
+				snprintf(buffer, sizeof(buffer) - 1, "%ps", (void *)entries[i]);
+				cp = strchr(buffer, ' ');
+				if (cp)
+					*cp = '\0';
+				if (!strcmp(buffer, "handle_softirqs")) {
+					caller = entries[i];
+					break;
+				}
+			}
+		}
+		for (i = 0; i < nr_entries; i++)
+			if (entries[i] == caller)
+				return i + 1;
+	} else if (current->flags & PF_WQ_WORKER) {
+		static unsigned long __data_racy caller;
+
+		if (!caller) {
+			for (i = 0; i < nr_entries; i++) {
+				snprintf(buffer, sizeof(buffer) - 1, "%ps", (void *)entries[i]);
+				cp = strchr(buffer, ' ');
+				if (cp)
+					*cp = '\0';
+				if (!strcmp(buffer, "process_one_work")) {
+					caller = entries[i];
+					break;
+				}
+			}
+		}
+		for (i = 0; i < nr_entries; i++)
+			if (entries[i] == caller)
+				return i + 1;
+	} else {
+		for (i = 0; i < nr_entries; i++) {
+			snprintf(buffer, sizeof(buffer) - 1, "%ps", (void *)entries[i]);
+			cp = strchr(buffer, ' ');
+			if (cp)
+				*cp = '\0';
+			if (buffer[0] == 'k') {
+				if (!strcmp(buffer, "ksys_unshare"))
+					return i + 1;
+			} else if (buffer[0] == 's') {
+				if (!strcmp(buffer, "sock_sendmsg_nosec") ||
+				    !strcmp(buffer, "sock_recvmsg_nosec"))
+					return i + 1;
+			} else if (buffer[0] == '_') {
+				if (!strcmp(buffer, "__sys_bind") ||
+				    !strcmp(buffer, "__sock_release") ||
+				    !strcmp(buffer, "__sys_bpf"))
+					return i + 1;
+			} else {
+				if (!strcmp(buffer, "do_sock_setsockopt"))
+					return i + 1;
+			}
+		}
+	}
+#endif
+	return nr_entries;
+}
+EXPORT_SYMBOL(trim_netdev_trace);
+
+void save_netdev_trace_buffer(struct net_device *dev, int delta)
+{
+	struct netdev_trace_buffer *ptr;
+	unsigned long entries[ARRAY_SIZE(ptr->entries)];
+	unsigned long nr_entries;
+	unsigned long flags;
+
+	if (in_nmi())
+		return;
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(ptr->entries), 1);
+	nr_entries = trim_netdev_trace(entries, nr_entries);
+	list_for_each_entry_rcu(ptr, &dev->netdev_trace_buffer_list, list,
+				/* list elements can't go away. */ 1) {
+		if (ptr->nr_entries == nr_entries &&
+		    !memcmp(ptr->entries, entries, nr_entries * sizeof(unsigned long))) {
+			atomic_add(delta, &ptr->count);
+			return;
+		}
+	}
+	spin_lock_irqsave(&netdev_trace_buffer_lock, flags);
+	if (!list_empty(&netdev_trace_buffer_list)) {
+		ptr = list_first_entry(&netdev_trace_buffer_list, typeof(*ptr), list);
+		list_del(&ptr->list);
+		ptr->prev_count = 0;
+		atomic_set(&ptr->count, delta);
+		ptr->nr_entries = nr_entries;
+		memmove(ptr->entries, entries, nr_entries * sizeof(unsigned long));
+		list_add_tail_rcu(&ptr->list, &dev->netdev_trace_buffer_list);
+	} else {
+		netdev_trace_buffer_exhausted = true;
+	}
+	spin_unlock_irqrestore(&netdev_trace_buffer_lock, flags);
+}
+EXPORT_SYMBOL(save_netdev_trace_buffer);
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
index 63c69a0fa74e..1d10fa2d91e2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -698,7 +698,11 @@ struct socket *sock_alloc(void)
 }
 EXPORT_SYMBOL(sock_alloc);
 
-static void __sock_release(struct socket *sock, struct inode *inode)
+static
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
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
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
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
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
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
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+noinline
+#endif
+int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys, unsigned int flags,
+		    struct used_address *used_address, unsigned int allowed_msghdr_flags)
 {
 	unsigned char ctl[sizeof(struct cmsghdr) + 20]
 				__aligned(sizeof(__kernel_size_t));
-- 
2.52.0

