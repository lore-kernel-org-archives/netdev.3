Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316500;
	b=GbS5iwu0Vg59RaMkcJ/jZwETXhn8bWcwh7xxFXcLvj6PisOfbqToRTX992iKFwCtMQNa
	 bOlr67O4Xm9H1Ditvk+fONNuvpJ1exDO62Kvb4mTt3X71AiAYH0YKJLZVA3mk/qdtm329
	 Uqat8ZLLE6UFwX+zqhLpgISmu1Y+PGAIaEJo7zu0XSB90fC0r4MEXc4Vbtqx2UO64ACUr
	 D73vb/ee9FQTlzx+NL8Uad9hVqGicEB+wHhN2l+i9GBFX2e/MGl89JKpMkjSXCt1EnNXQ
	 meOlSpgmBLL5zkgVpge3ji5nfYqPBdldgFRR6yT+aX6Z9YAbVJDD98t7Ecw94dtERPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316500;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=5dr9bNWaIhdjJG0fm9SUq1goSVkHSKkAdi+tGZYU5TM=;
	b=Xkj+DekYfYLBIoYq0WKtM4Sy2mOIRyz59pzd0ogvoTkJgrsMJxgJBAlq1sMEZrtujluw
	 GbSsDagb5shX6rLJkboD/9pqcFqYyPXxAJDAgy5seRZ3S4DgCSL6FIRC+ZTJr0Nz9RjnH
	 cUXuckPqqUgZxtIiNTN3s7hp+6ZozyaVOL7+KiAvHsi9tbKyTVzIpZvHAzJ8AtqTlO+vh
	 EcQ1kaRKbNuudse+dT9NRIb4UNFoiWexM0kEoDXixkLlzWi+iJZaBEcM0zKjXtoU5rU6g
	 UyDfMOCvVe9wAdYPi3ff3XwXrVDKPsVG3anyxv1LDURjOU9/XSvMCA7moyxyoT4P2jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=j4VqbkZn;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3213606A76C;
	Tue, 10 Nov 2026 13:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3213606A76C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=j4VqbkZn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=5dr9bNWaIhdjJG0fm9SUq1goSVkHSKkAdi+tGZYU5TM=; b=j4VqbkZn2RvsGkkHFFzv9L7QHx
	CogszTlE+gjYdLG4K808kKsgcZAb2K0nCWtAKC2de2hYJpltFQtZcFh1E3y60UVgxdvmkOpCLZqcQ
	plq9UmJk0hGbBr8/asWTTnUQP5FDANpriTk3O32wwaDjLBF/mg6jCsh8FYuE3jD0+h0ETIrVyhTSL
	4u2ompFULYT1IJY92q6t+x7GcNTHbMmjvQP1Rnq1rmPZ0TMVXoANjuXRcoxBDhbNqM9c4kVkJE9wD
	T+yC0n0OKN4NKphWMHvyWJoEZfo4wtKcZbgfKXzS4ZeHyZebb2CYItR3ZnJpZre+zGrHMumUDSPFg
	cZ/dtetQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQlga-00CQcq-15;
	Tue, 10 Nov 2026 13:14:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Nov 2026 05:10:01 -0800
Subject: [PATCH net-next v2] netconsole: register one console per target
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
Message-Id: <20261110-netcons_one_console_per_target-v2-1-bebf45b2733f@debian.org>
X-B4-Tracking: v=1; b=H4sIAK0X82oC/4XNTQqDMBBA4auEWZtiQv1d9R5FQkxGDZSJTIJYx
 LuXSvfdPXiL74CEHDBBLw5g3EIKkaAXuhDgFkszyuChF6BLXStVVpIwu0jJRELzjfhCsyKbbHn
 GLJu2bbSr0LV3BYWAlXEK+wU8gTBLwj3DUAhYQsqR35e8qev/kPofsimppNOdt86PnVPTw+MYL
 N0izzCc5/kBImOYu9cAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15601; i=leitao@debian.org;
 h=from:subject:message-id; bh=HEwWPpvFCwkUPwnYBZFAaWn867s9Z2rnoMirFW8O5SE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8xjICg5LQVkHW+63ZlADLlxMtH0/FZcRfsYqt
 1nzbzqSexOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavMYyAAKCRA1o5Of/Hh3
 bfgXD/4jbokCope4JRVg0rRdWaHqQG78432YnC2nfB2eXnHlkZS9pyp5IPZfzNIgPO0lDjxOi/K
 gh6jl8pzBCGeZ5vLKkOLZG/aXqAwpCKfryfhsstvj2uw6WGC8XP6bF6/5vGeJDil7OSvVrXdUBB
 OMFyDWfExUjeCjusLl3D/mFSvCxpbN/cFWORkM4AGna8sohnJTfrlZ1cjlSxhbb+OitvaNKuKt0
 xercIAdGWEOHs3/zJMni/akPbHUGqGsNDxXGzCzMOt7SSap2tvETkJSCVV269vAHeEqG2K5SsyJ
 cb0+xh6GeMEieRumwObhU8QKwaOKaQkCzKn2elVVV0XLwcp5wl4HwHYSB38j5ZiOTxGbtQ5/s3J
 2OmRQc+vXoqhJM/qXSXK5hAEiCwOje6PjzVfpHZGrHAYzg/Fptm0O8drl8UZjjlyKRzJdV/mlvF
 mM/syiyekm9wwHFels7tZnCMq4aAncE1aN/yLgDIZ2RDa7ljdQFam5XlnuinFEk1GLH3XRtOAJW
 R9vwggudziWhvMsOfN89GcElZn6asJsBrxKh3OdhqeTAIFZ7Vc1JcdRY6DJyjkdX3xhDtDejh3X
 YfarsRZ5oDSbbZ1+IzTpRfHF6QvNq0FkPBlKdRmD+hdnyMoYvL3mFKA+CBWjmez1FXccPlQF6Pq
 0te3fxkpbXuP/2g==
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

Unregistering a console waits for an SRCU grace period and for its
printer thread to stop, which the netdev notifier should not do
under RTNL. A target stopped by an interface event keeps its console
instead, and the write callback skips the target as it does today.
Writing to its enabled attribute drops that console.

The console is replaced when the target is enabled again or resumes.
The user may have switched the format in between, and printk has to
format the records the way the target sends them. A target whose
console fails to register is disabled, as it would not print
anything.

Today, a target switched to the other format while deactivated resumes
silently if no console of that format is registered.

target_list_lock remains the device_lock of all the consoles. A target
is enabled before its console is registered, so only disabling it and
interface events race with the write callback, and both change the
state under that lock. The printer threads of the targets serialize on
it, like the two shared consoles do today.

/proc/consoles now lists one entry per enabled target, and per target
stopped by an interface event, for example:

	netcons_foo0         -W- (E  N   )

This makes the mental model easier to understand, and also simplifies
the code.

Link: https://lore.kernel.org/all/20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com/ [1]
Link: https://lore.kernel.org/all/auDjNKi336lstU7j@pathway.suse.cz/ [2]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Rebase on net-next, on top of the rate limit series.
- Fix sashiko findings
- Link to v1: https://patch.msgid.link/20261106-netcons_one_console_per_target-v1-1-c29dacdb9c1f@debian.org
---
 drivers/net/netconsole.c | 218 +++++++++++++++++++++--------------------------
 1 file changed, 97 insertions(+), 121 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index fcc1050c75f58c..a9f9477da1ec77 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -124,23 +124,12 @@ static DEFINE_MUTEX(target_cleanup_list_lock);
 
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
@@ -228,6 +217,7 @@ struct netcons_userdata {
  *		successful netpoll_setup() / netpoll_cleanup() pair on @np.
  * @refill_wq:	Work item that asynchronously tops @skb_pool back up to
  *		MAX_SKBS after find_skb() drains an entry.
+ * @console:	Console printing to this target, registered once it is enabled.
  */
 struct netconsole_target {
 	struct list_head	list;
@@ -259,8 +249,13 @@ struct netconsole_target {
 	struct work_struct	resume_wq;
 	struct sk_buff_head	skb_pool;
 	struct work_struct	refill_wq;
+	struct console		console;
 };
 
+static int netconsole_register_console(struct netconsole_target *nt,
+				       short flags);
+static void netconsole_unregister_console(struct netconsole_target *nt);
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 static struct configfs_subsystem netconsole_subsys;
@@ -689,6 +684,11 @@ static void process_resume_target(struct work_struct *work)
 	list_del_init(&nt->list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 
+	/* The console registered before the deactivation may still be around,
+	 * and extended may have changed since. Drop it here, a new one is
+	 * registered below once the target is enabled again.
+	 */
+	netconsole_unregister_console(nt);
 	resume_target(nt);
 
 	/* netpoll_setup() took a net_device reference and dropped the RTNL
@@ -719,6 +719,8 @@ static void process_resume_target(struct work_struct *work)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 	rtnl_unlock();
 
+	netconsole_register_console(nt, 0);
+
 out_unlock:
 	dynamic_netconsole_mutex_unlock();
 }
@@ -1052,33 +1054,6 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
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
@@ -1122,6 +1097,9 @@ static ssize_t enabled_store(struct config_item *item,
 
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
+	/* Interface events stop a target but keep its console */
+	if (!current_enabled)
+		netconsole_unregister_console(nt);
 	if (enabled == current_enabled) {
 		pr_info("network logging has already %s\n",
 			current_enabled ? "started" : "stopped");
@@ -1134,19 +1112,6 @@ static ssize_t enabled_store(struct config_item *item,
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
-
 		/*
 		 * Skip netconsole_parser_cmdline() -- all the attributes are
 		 * already configured via configfs. Just print them out.
@@ -1167,6 +1132,9 @@ static ssize_t enabled_store(struct config_item *item,
 			goto out_unlock;
 		}
 
+		ret = netconsole_register_console(nt, 0);
+		if (ret)
+			goto out_unlock;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
@@ -1182,10 +1150,7 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -1915,6 +1880,9 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 
 	/* Initialize the config_group member */
 	init_target_config_group(nt, name);
+	/* The index stays 0, printk shows the console as netcons_<name>0 */
+	snprintf(nt->console.name, sizeof(nt->console.name), "netcons_%s",
+		 name);
 
 	/* Adding, but it is disabled */
 	spin_lock_irqsave(&target_list_lock, flags);
@@ -1933,6 +1901,8 @@ static void drop_netconsole_target(struct config_group *group,
 
 	dynamic_netconsole_mutex_lock();
 
+	netconsole_unregister_console(nt);
+
 	mutex_lock(&target_cleanup_list_lock);
 	spin_lock_irqsave(&target_list_lock, flags);
 	/* A target moved to target_cleanup_list by netconsole_netdev_event()
@@ -2615,53 +2585,40 @@ static void send_msg_udp(struct netconsole_target *nt, const char *msg,
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
 	if (oops_only && !netconsole_kernel_dying())
 		return;
 
-	list_for_each_entry(nt, &target_list, list) {
-		if (nt->extended != extended || nt->state != STATE_ENABLED ||
-		    !netif_running(nt->np.dev))
-			continue;
-
-		if (netconsole_ratelimited(nt))
-			continue;
-
-		/* If nbcon_enter_unsafe() fails, just return given netconsole
-		 * lost the ownership, and iterating over the targets will not
-		 * be able to re-acquire.
-		 */
-		if (!nbcon_enter_unsafe(wctxt))
-			return;
+	if (nt->state != STATE_ENABLED || !netif_running(nt->np.dev))
+		return;
 
-		if (extended)
-			send_ext_msg_udp(nt, wctxt);
-		else
-			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+	if (netconsole_ratelimited(nt))
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
@@ -2816,6 +2773,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 */
 			goto fail;
 	}
+	/* netcons_cmdline<N> does not fit, printk shows the index after it */
+	strscpy(nt->console.name, "netcons_" NETCONSOLE_PARAM_TARGET_PREFIX);
+	nt->console.index = cmdline_count;
 	populate_configfs_item(nt, cmdline_count);
 
 	return nt;
@@ -2828,6 +2788,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
+	netconsole_unregister_console(nt);
 	cancel_work_sync(&nt->resume_wq);
 	if (nt->state == STATE_ENABLED)
 		netconsole_skb_pool_flush(nt);
@@ -2838,29 +2799,58 @@ static void free_param_target(struct netconsole_target *nt)
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
+/* Register the console of an enabled @nt, @flags can request CON_PRINTBUFFER.
+ * If that fails, disable @nt, as it would not print anything.
+ */
+static int netconsole_register_console(struct netconsole_target *nt,
+				       short flags)
+{
+	struct console *con = &nt->console;
+	unsigned long irqflags;
 
-static struct console netconsole = {
-	.name = "netcon",
-	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
-	.write_thread = netconsole_write_basic,
-	.write_atomic = netconsole_write_basic,
-	.device_lock = netconsole_device_lock,
-	.device_unlock = netconsole_device_unlock,
-};
+	if (nt->state != STATE_ENABLED)
+		return 0;
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
+	if (console_is_registered(con))
+		return 0;
+
+	pr_err("failed to register console %s%d, disabling its target\n",
+	       con->name, con->index);
+	rtnl_lock();
+	spin_lock_irqsave(&target_list_lock, irqflags);
+	nt->state = STATE_DISABLED;
+	spin_unlock_irqrestore(&target_list_lock, irqflags);
+	/* An interface event may have released the device already */
+	if (nt->np.dev) {
+		netconsole_skb_pool_flush(nt);
+		netcons_release_dev(nt);
+	}
+	rtnl_unlock();
+
+	return -ENOMEM;
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
@@ -2876,13 +2866,7 @@ static int __init init_netconsole(void)
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
@@ -2905,10 +2889,6 @@ static int __init init_netconsole(void)
 	if (err)
 		goto undonotifier;
 
-	if (console_type_needed & CONS_EXTENDED)
-		register_console(&netconsole_ext);
-	if (console_type_needed & CONS_BASIC)
-		register_console(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;
@@ -2941,10 +2921,6 @@ static void __exit cleanup_netconsole(void)
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
base-commit: 6db9448a443afde26231aaed7b112ed17b33f468
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261105-netcons_one_console_per_target-78872c5ec841

Best regards,
--  
Breno Leitao <leitao@debian.org>

