Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971836;
	b=Swxy0Uxep7zvgCLLHSRRKjCNAjlCHHRL88uG/xsHtHN0PfNCRzvQ6q5pVMSLxMkUHzVm
	 iInFXX7LO7IHvZKUHl/qOcEHoENDeKUQeWJPObRRrW7H5YoY5KtoN5T2DuUukZkla+3oL
	 TtrZ+nO0Gcc54CfrMxQTjiWelGPxHaAVo/5Y3EN7vwbAgH2k+sszZ2VuZz9gXLqXPOJgt
	 s8napizTZNT0IEFSxFrAHFoXiwDeZYfY3d9zKjiNQtzJ8IebhX53i97LLnmHfwPv/yf3C
	 rbklg/pnxu52WS65MTlII81KCw2HXzOErlSZ9zJ8+LDjGsQj3XxxY8fnsTvDF2WTkKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971836;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=wmrPTmKfshGHLhJn310+XiWJGSalq0hLwbca6zt2fFE=;
	b=THjPQ2fno/oSQ7UbL93HdIK5DK9Me1pw9UJXtcOLIpGVnONY379EMEKn3KsE9o9Axs7c
	 guFK2scqBqzbSat0KTxLtcfasKRuaKHVFmq+dY4HDKTzzM03aTqco4MXp1LQdZ5NP9fu9
	 Pgju0a2UOGwaHx7XRPzT2OUaAUSxKQlQLF16PWFeAgGLrnjPp+KQi2UOJbUMXbMLRcWdr
	 aOchcF/x42Dfnfcof1SnmQmjoW2TQrsybzDfO13PjC4leMVTl185ocVqsr7PTCtCJfzlb
	 L+A5qgA4f2k9S7S4jaVquoX/iSqZA+K99huGdZko4c8BjsfuP+FzoLTeIJpGeINfRxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VOhmFjaw;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E8606A32F;
	Fri,  6 Nov 2026 13:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C57E8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VOhmFjaw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=wmrPTmKfshGHLhJn310+XiWJGSalq0hLwbca6zt2fFE=; b=VOhmFjawDWvrrOpP3B+h6Ows3n
	Ckoi8QnwJCBwBit478dbKdVnXLLWxZ/tAOllKy7HCotNrPqQMt4w+EwPTJ+MV+8J3vS8ofHZ5cP6m
	4jq8bLnOorgdOCJK2ZjYvX/lMmuQCFp5Ska+qgupH8OEa+uAYwnrR6xtOzEnqrv4BFfO2O87JqsFz
	X8HLtL9X13d0ixZNKD2c3tryNDbcqVgU1MSIYqbdlHT571nP1MRRld8SFSF6z9d7FcHlzrHBHq0gx
	TIFS4BNlubjpG2fVFe3C/NbJSg2GQVTpSEwHVWtjoARFITjKtxW/3MuWdGRwSfeaEmr86gc+GMKF1
	2BZpxY4w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPK1T-009Jfo-2b;
	Fri, 06 Nov 2026 13:30:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Nov 2026 05:16:39 -0800
Subject: [PATCH net-next] netconsole: register one console per target
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-netcons_one_console_per_target-v1-1-c29dacdb9c1f@debian.org>
X-B4-Tracking: v=1; b=H4sIADvT7WoC/x3NQQrCMBAF0KuEv26gCdaGXEUklPitAZmUSZBC6
 d1Fd2/3DjRqYUM0B5Sf0koVROMGg/xaZKUtD0QDP/qrc+NkhT1XaakK0w/1zbRRU190ZbdzCLP
 PE3O4OAwGm/JZ9n9wg7Bb4d5xP88vvxwZ/3oAAAA=
X-Change-ID: 20261105-netcons_one_console_per_target-78872c5ec841
To: Gustavo Luiz Duarte <gustavold@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Sam Crossley <samuelcrossley@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14433; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ok16H57kkWgPW1QINuB8Qbok8080EITbEBSzZMpCV4E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq7dZvp6o/F1EKQMXboMe5flLTvcD9bSPcL8Zfe
 n86i5qLqSSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCau3WbwAKCRA1o5Of/Hh3
 bc0QD/417SVRxzf4xfnJyMQiLYJyxD8o19Y9mJYTGxRwIgleXtJ5ThLuWXulaNGkQGPei8oYKOk
 1acPYlY59u7VcPHuWx2RDQx7MJOAV9LFuym+H4TD0RWV/MsHgT6Hvm1jhN4bKQNTfNLA68rrXbk
 yJbVyZL4y8EfGQf6z6t1EChlYS2S81uK4tmttCyp9xFV2Wc+n6kO1b9z7r0yp+8ZJ1pB77hgl//
 ov0JM4ygZJ2u0jBuLPbTVcp/zb4KYecGKhKdsG8l2f4yBjlf4zaHYVmKsxjxGG6pK0E+/2WSFGk
 H3cQ+42cyamSIZEgaK4Ixd4uN9wuzXzpIcN7lZwnjm6i9CFrKyyRi1pr58XbN0N9kx87i1D07eE
 yo64B5X3mSX26EeFvO47WdVtMRGYPvxHVhlnne7IQOLQV5zntqBBZd2Ev/waZEfhBvuPpmBQuvN
 h/BtiNLZ8gxNgk/RdO/zE0UIooXT5sTRif3XJyjL9ejIQdBIFDW8GiqLB6xXv/ULK+RAsNGxmM0
 pHxH4pFrAjYSMmV0woG2O+RrLqqYEV5EtxofvVKX8Ud6EAmYUUoAZ1PnXR9EjMrM9YGZEE9lfFT
 DaCsCooChkYtXq6yk62q3vWW8mROBTYezbNC+rfz7f3xfKVUTFVuaplO2yPKeS5scmaS3zi1VEK
 pwTlhpfRB2tfREw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

netconsole registers a single console (or two in case someone wants
basic and extended at the same time), independent of the number of
targets.

This was not ideal, but, there was no reason to change.

Now that we want to replay some messages [1], we cannot do it per
target, but, per console [2].

Embed a struct console in netconsole_target, so, each target has its own
console, named `netcons_<target name>`. struct console holds 15
characters, so longer names are truncated, and two targets can end up
with the same console name.

No ->match() callback is added: netconsole consoles set CON_ENABLED and
register without a console= match. console=netcon0 no longer refers to
netconsole.

Unregistering a console sleeps until the console has flushed and its
printer thread has stopped, which the netdev notifier should not do
under RTNL. A target stopped by an interface event keeps its console
instead, and the write callback skips the target as it does today.

The console is replaced when the target is enabled again or resumes.
The user may have switched the format in between, and printk has to
format the records the way the target sends them.

Today, a target switched to the other format while deactivated resumes
silently if no console of that format is registered.

target_list_lock remains the device_lock of all the consoles, as the
state changes that race with the write callback are made under it. The
printer threads of the targets serialize on it, like the two shared
consoles do today.

/proc/consoles now lists one entry per enabled target, and per target
stopped by an interface event, for example:

	netcons_foo-1        -W- (E  N   )

This makes the mental model easier to understand, and also simplifies
the code.

Link: https://lore.kernel.org/all/20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com/ [1]
Link: https://lore.kernel.org/all/auDjNKi336lstU7j@pathway.suse.cz/ [2]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 194 +++++++++++++++++++----------------------------
 1 file changed, 76 insertions(+), 118 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 267254f046de9a..8353dd56789c19 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -111,23 +111,12 @@ static DEFINE_MUTEX(target_cleanup_list_lock);
 
 static struct workqueue_struct *netconsole_wq;
 
-/*
- * Console driver for netconsoles.  Register only consoles that have
- * an associated target of the same type.
- */
-static struct console netconsole_ext, netconsole;
-
 struct netconsole_target_stats  {
 	u64_stats_t xmit_drop_count;
 	u64_stats_t enomem_count;
 	struct u64_stats_sync syncp;
 };
 
-enum console_type {
-	CONS_BASIC = BIT(0),
-	CONS_EXTENDED = BIT(1),
-};
-
 /* Features enabled in sysdata. Contrary to userdata, this data is populated by
  * the kernel. The fields are designed as bitwise flags, allowing multiple
  * features to be set in sysdata_fields.
@@ -214,6 +203,7 @@ struct netcons_userdata {
  *		successful netpoll_setup() / netpoll_cleanup() pair on @np.
  * @refill_wq:	Work item that asynchronously tops @skb_pool back up to
  *		MAX_SKBS after find_skb() drains an entry.
+ * @console:	Console printing to this target, registered once it is enabled.
  */
 struct netconsole_target {
 	struct list_head	list;
@@ -243,8 +233,13 @@ struct netconsole_target {
 	struct work_struct	resume_wq;
 	struct sk_buff_head	skb_pool;
 	struct work_struct	refill_wq;
+	struct console		console;
 };
 
+static void netconsole_register_console(struct netconsole_target *nt,
+					short flags);
+static void netconsole_unregister_console(struct netconsole_target *nt);
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 static struct configfs_subsystem netconsole_subsys;
@@ -630,6 +625,11 @@ static void process_resume_target(struct work_struct *work)
 	list_del_init(&nt->list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 
+	/* The console registered before the deactivation may still be around,
+	 * and extended may have changed since. Drop it here, a new one is
+	 * registered below once the target is enabled again.
+	 */
+	netconsole_unregister_console(nt);
 	resume_target(nt);
 
 	/* netpoll_setup() took a net_device reference and dropped the RTNL
@@ -660,6 +660,8 @@ static void process_resume_target(struct work_struct *work)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 	rtnl_unlock();
 
+	netconsole_register_console(nt, 0);
+
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 }
@@ -964,33 +966,6 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	return sysfs_emit(buf, "%d\n", release_enabled);
 }
 
-/* Iterate in the list of target, and make sure we don't have any console
- * register without targets of the same type
- */
-static void unregister_netcons_consoles(void)
-{
-	struct netconsole_target *nt;
-	u32 console_type_needed = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&target_list_lock, flags);
-	list_for_each_entry(nt, &target_list, list) {
-		if (nt->extended)
-			console_type_needed |= CONS_EXTENDED;
-		else
-			console_type_needed |= CONS_BASIC;
-	}
-	spin_unlock_irqrestore(&target_list_lock, flags);
-
-	if (!(console_type_needed & CONS_EXTENDED) &&
-	    console_is_registered(&netconsole_ext))
-		unregister_console(&netconsole_ext);
-
-	if (!(console_type_needed & CONS_BASIC) &&
-	    console_is_registered(&netconsole))
-		unregister_console(&netconsole);
-}
-
 static ssize_t sysdata_msgid_enabled_show(struct config_item *item,
 					  char *buf)
 {
@@ -1037,6 +1012,9 @@ static ssize_t enabled_store(struct config_item *item,
 	if (enabled == current_enabled) {
 		pr_info("network logging has already %s\n",
 			current_enabled ? "started" : "stopped");
+		/* Interface events stop a target but keep its console */
+		if (!enabled)
+			netconsole_unregister_console(nt);
 		goto out_unlock;
 	}
 
@@ -1046,18 +1024,8 @@ static ssize_t enabled_store(struct config_item *item,
 			goto out_unlock;
 		}
 
-		if (nt->extended && !console_is_registered(&netconsole_ext)) {
-			netconsole_ext.flags |= CON_ENABLED;
-			register_console(&netconsole_ext);
-		}
-
-		/* User might be enabling the basic format target for the very
-		 * first time, make sure the console is registered.
-		 */
-		if (!nt->extended && !console_is_registered(&netconsole)) {
-			netconsole.flags |= CON_ENABLED;
-			register_console(&netconsole);
-		}
+		/* Interface events disable a target but keep its console */
+		netconsole_unregister_console(nt);
 
 		/*
 		 * Skip netconsole_parser_cmdline() -- all the attributes are
@@ -1080,6 +1048,7 @@ static ssize_t enabled_store(struct config_item *item,
 		}
 
 		nt->state = STATE_ENABLED;
+		netconsole_register_console(nt, 0);
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
@@ -1095,10 +1064,7 @@ static ssize_t enabled_store(struct config_item *item,
 		list_move(&nt->list, &target_cleanup_list);
 		spin_unlock_irqrestore(&target_list_lock, flags);
 		mutex_unlock(&target_cleanup_list_lock);
-		/* Unregister consoles, whose the last target of that type got
-		 * disabled.
-		 */
-		unregister_netcons_consoles();
+		netconsole_unregister_console(nt);
 	}
 
 	ret = count;
@@ -1770,6 +1736,10 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 
 	/* Initialize the config_group member */
 	init_target_config_group(nt, name);
+	snprintf(nt->console.name, sizeof(nt->console.name), "netcons_%s",
+		 name);
+	/* No index, the console is named after the target */
+	nt->console.index = -1;
 
 	/* Adding, but it is disabled */
 	spin_lock_irqsave(&target_list_lock, flags);
@@ -1788,6 +1758,8 @@ static void drop_netconsole_target(struct config_group *group,
 
 	dynamic_netconsole_mutex_lock();
 
+	netconsole_unregister_console(nt);
+
 	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
 	/* A target moved to target_cleanup_list by netconsole_netdev_event()
@@ -2470,50 +2442,37 @@ static void send_msg_udp(struct netconsole_target *nt, const char *msg,
 }
 
 /**
- * netconsole_write - Generic function to send a msg to all targets
+ * netconsole_write - Send a msg to the target of a console
+ * @con: console of the target
  * @wctxt: nbcon write context
- * @extended: "true" for extended console mode
  *
- * Given an nbcon write context, send the message to the netconsole targets
+ * Given an nbcon write context, send the message to the netconsole target
  */
-static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
+static void netconsole_write(struct console *con,
+			     struct nbcon_write_context *wctxt)
 {
 	struct netconsole_target *nt;
 
+	nt = container_of(con, struct netconsole_target, console);
+
 	if (oops_only && !oops_in_progress)
 		return;
 
-	list_for_each_entry(nt, &target_list, list) {
-		if (nt->extended != extended || nt->state != STATE_ENABLED ||
-		    !netif_running(nt->np.dev))
-			continue;
-
-		/* If nbcon_enter_unsafe() fails, just return given netconsole
-		 * lost the ownership, and iterating over the targets will not
-		 * be able to re-acquire.
-		 */
-		if (!nbcon_enter_unsafe(wctxt))
-			return;
-
-		if (extended)
-			send_ext_msg_udp(nt, wctxt);
-		else
-			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+	if (nt->state != STATE_ENABLED || !netif_running(nt->np.dev))
+		return;
 
-		nbcon_exit_unsafe(wctxt);
-	}
-}
+	/* If nbcon_enter_unsafe() fails, just return given netconsole
+	 * lost the ownership.
+	 */
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
 
-static void netconsole_write_ext(struct console *con __always_unused,
-				 struct nbcon_write_context *wctxt)
-{
-	netconsole_write(wctxt, true);
-}
+	if (nt->extended)
+		send_ext_msg_udp(nt, wctxt);
+	else
+		send_msg_udp(nt, wctxt->outbuf, wctxt->len);
 
-static void netconsole_write_basic(struct console *con __always_unused,
-				   struct nbcon_write_context *wctxt)
-{
-	netconsole_write(wctxt, false);
+	nbcon_exit_unsafe(wctxt);
 }
 
 static void netconsole_device_lock(struct console *con __always_unused,
@@ -2670,6 +2629,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	} else {
 		nt->state = STATE_ENABLED;
 	}
+	/* netcons_cmdline<N> does not fit, printk shows the index after it */
+	strscpy(nt->console.name, "netcons_" NETCONSOLE_PARAM_TARGET_PREFIX);
+	nt->console.index = cmdline_count;
 	populate_configfs_item(nt, cmdline_count);
 
 	return nt;
@@ -2682,6 +2644,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
+	netconsole_unregister_console(nt);
 	cancel_work_sync(&nt->resume_wq);
 	if (nt->state == STATE_ENABLED)
 		netconsole_skb_pool_flush(nt);
@@ -2692,29 +2655,38 @@ static void free_param_target(struct netconsole_target *nt)
 	kfree(nt);
 }
 
-static struct console netconsole_ext = {
-	.name = "netcon_ext",
-	.flags = CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
-	.write_thread = netconsole_write_ext,
-	.write_atomic = netconsole_write_ext,
-	.device_lock = netconsole_device_lock,
-	.device_unlock = netconsole_device_unlock,
-};
+/* Register the console of an enabled @nt, @flags can request CON_PRINTBUFFER */
+static void netconsole_register_console(struct netconsole_target *nt,
+					short flags)
+{
+	struct console *con = &nt->console;
 
-static struct console netconsole = {
-	.name = "netcon",
-	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
-	.write_thread = netconsole_write_basic,
-	.write_atomic = netconsole_write_basic,
-	.device_lock = netconsole_device_lock,
-	.device_unlock = netconsole_device_unlock,
-};
+	if (nt->state != STATE_ENABLED)
+		return;
+
+	con->flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE | flags;
+	if (nt->extended)
+		con->flags |= CON_EXTENDED;
+	con->write_thread = netconsole_write;
+	con->write_atomic = netconsole_write;
+	con->device_lock = netconsole_device_lock;
+	con->device_unlock = netconsole_device_unlock;
+
+	register_console(con);
+}
+
+static void netconsole_unregister_console(struct netconsole_target *nt)
+{
+	if (!console_is_registered(&nt->console))
+		return;
+
+	unregister_console(&nt->console);
+}
 
 static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
-	u32 console_type_needed = 0;
 	unsigned int count = 0;
 	unsigned long flags;
 	char *target_config;
@@ -2730,13 +2702,7 @@ static int __init init_netconsole(void)
 				goto fail;
 			}
 			/* Dump existing printks when we register */
-			if (nt->extended) {
-				console_type_needed |= CONS_EXTENDED;
-				netconsole_ext.flags |= CON_PRINTBUFFER;
-			} else {
-				console_type_needed |= CONS_BASIC;
-				netconsole.flags |= CON_PRINTBUFFER;
-			}
+			netconsole_register_console(nt, CON_PRINTBUFFER);
 
 			spin_lock_irqsave(&target_list_lock, flags);
 			list_add(&nt->list, &target_list);
@@ -2759,10 +2725,6 @@ static int __init init_netconsole(void)
 	if (err)
 		goto undonotifier;
 
-	if (console_type_needed & CONS_EXTENDED)
-		register_console(&netconsole_ext);
-	if (console_type_needed & CONS_BASIC)
-		register_console(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;
@@ -2795,10 +2757,6 @@ static void __exit cleanup_netconsole(void)
 {
 	struct netconsole_target *nt, *tmp;
 
-	if (console_is_registered(&netconsole_ext))
-		unregister_console(&netconsole_ext);
-	if (console_is_registered(&netconsole))
-		unregister_console(&netconsole);
 	dynamic_netconsole_exit();
 	unregister_netdevice_notifier(&netconsole_netdev_notifier);
 	flush_workqueue(netconsole_wq);

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261105-netcons_one_console_per_target-78872c5ec841

Best regards,
--  
Breno Leitao <leitao@debian.org>

