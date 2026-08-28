Received: from mta1.migadu.com (out-202.mta1.migadu.com [95.215.58.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DB348C66
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902386; cv=none; b=sLNzTAvUj3y1PgmDaAMvSLkU2iWZ7SonwCmSAGflE6KyXx1UURxhlL66oA2hyy7El3mrpuA5xSMa0E0z/zu1Bj+uX/zZ0LwJtI1mItZs207Ft7LilIqcNXtx6Lc02ShZThsjNbQe6qM9PEnHvKBI5hgv1Lvt6uQuhr5CLJJ2PM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902386; c=relaxed/simple;
	bh=gWwqFx7eGoDYJW4LAidi2bOnpDrK4JL69AvBg6fvSjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgSGKlLrvnEC48zuIfXZVu5GGDcK/OQUYla0WhS9QbQLdt0Na853vc6j6S1x0bPGriKw0W69jiO2enylWZq/mfpqC983rngcbxOzPaOreorscbf6W9/PP9UUlgU4ZBij4c6HucW5ZCE3H1fWaeHn8gfz2jUwVeKTq4HqiJteOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtHvMpFB; arc=none smtp.client-ip=95.215.58.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtHvMpFB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gWwqFx7eGoDYJW4LAidi2bOnpDrK4JL69AvBg6fvSjg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787902382; v=1; x=1788507182;
 b=ZtHvMpFBxAKPkS46dCZzZrYqxZZz4v73uJ4JBAPM9wnOtCZCKZWHB/aBcP42JMPGnIwGSslk
 FExgtQBXzt4G50Eub3tH4W6BV0lJ177d30BJohGtSnrKaAjIuGrxJAbKPjnrIGSJzGAnoZvcaN3
 w3DOIdgM3ndsXiGxYfEYGeDg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2197b6c7e29ec2dc;
	Fri, 28 Aug 2026 07:33:02 +0000
X-Mizu-Trace-ID: 2197b6c7e29ec2dc
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+b503105c2410c3433459@syzkaller.appspotmail.com
Subject: [PATCH net 2/2] ppp: ppp_synctty: simplify tty disc_data access
Date: Fri, 28 Aug 2026 15:32:37 +0800
Message-ID: <20260828073245.126804-2-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828073245.126804-1-qingfang.deng@linux.dev>
References: <20260828073245.126804-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply the same simplification as the preceding ppp_async change.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b503105c2410c3433459@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=b503105c2410c3433459
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_synctty.c | 83 +++--------------------------------
 1 file changed, 7 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 0b1bd1635c39..f87d43faeeab 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -38,11 +38,9 @@
 #include <linux/ppp-ioctl.h>
 #include <linux/ppp_channel.h>
 #include <linux/spinlock.h>
-#include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-#include <linux/refcount.h>
 #include <linux/unaligned.h>
 #include <linux/uaccess.h>
 
@@ -67,8 +65,6 @@ struct syncppp {
 
 	struct tasklet_struct tsk;
 
-	refcount_t	refcnt;
-	struct completion dead_cmp;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 };
 
@@ -116,37 +112,6 @@ ppp_print_buffer (const char *name, const __u8 *buf, int count)
  * Routines implementing the synchronous PPP line discipline.
  */
 
-/*
- * We have a potential race on dereferencing tty->disc_data,
- * because the tty layer provides no locking at all - thus one
- * cpu could be running ppp_synctty_receive while another
- * calls ppp_synctty_close, which zeroes tty->disc_data and
- * frees the memory that ppp_synctty_receive is using.  The best
- * way to fix this is to use a rwlock in the tty struct, but for now
- * we use a single global rwlock for all ttys in ppp line discipline.
- *
- * FIXME: Fixed in tty_io nowadays.
- */
-static DEFINE_RWLOCK(disc_data_lock);
-
-static struct syncppp *sp_get(struct tty_struct *tty)
-{
-	struct syncppp *ap;
-
-	read_lock(&disc_data_lock);
-	ap = tty->disc_data;
-	if (ap != NULL)
-		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
-	return ap;
-}
-
-static void sp_put(struct syncppp *ap)
-{
-	if (refcount_dec_and_test(&ap->refcnt))
-		complete(&ap->dead_cmp);
-}
-
 /*
  * Called when a tty is put into sync-PPP line discipline.
  */
@@ -177,9 +142,6 @@ ppp_sync_open(struct tty_struct *tty)
 	skb_queue_head_init(&ap->rqueue);
 	tasklet_setup(&ap->tsk, ppp_sync_process);
 
-	refcount_set(&ap->refcnt, 1);
-	init_completion(&ap->dead_cmp);
-
 	ap->chan.private = ap;
 	ap->chan.ops = &sync_ops;
 	ap->chan.mtu = PPP_MRU;
@@ -201,34 +163,18 @@ ppp_sync_open(struct tty_struct *tty)
 }
 
 /*
- * Called when the tty is put into another line discipline
- * or it hangs up.  We have to wait for any cpu currently
- * executing in any of the other ppp_synctty_* routines to
- * finish before we can call ppp_unregister_channel and free
- * the syncppp struct.  This routine must be called from
- * process context, not interrupt or softirq context.
+ * Called when the tty is put into another line discipline or it hangs up.
+ * This call is serialized against other ldisc functions.
  */
 static void
 ppp_sync_close(struct tty_struct *tty)
 {
-	struct syncppp *ap;
+	struct syncppp *ap = tty->disc_data;
 
-	write_lock_irq(&disc_data_lock);
-	ap = tty->disc_data;
-	tty->disc_data = NULL;
-	write_unlock_irq(&disc_data_lock);
 	if (!ap)
 		return;
 
-	/*
-	 * We have now ensured that nobody can start using ap from now
-	 * on, but we have to wait for all existing users to finish.
-	 * Note that ppp_unregister_channel ensures that no calls to
-	 * our channel ops (i.e. ppp_sync_send/ioctl) are in progress
-	 * by the time it returns.
-	 */
-	if (!refcount_dec_and_test(&ap->refcnt))
-		wait_for_completion(&ap->dead_cmp);
+	tty->disc_data = NULL;
 	tasklet_kill(&ap->tsk);
 
 	ppp_unregister_channel(&ap->chan);
@@ -237,17 +183,6 @@ ppp_sync_close(struct tty_struct *tty)
 	kfree(ap);
 }
 
-/*
- * Called on tty hangup in process context.
- *
- * Wait for I/O to driver to complete and unregister PPP channel.
- * This is already done by the close routine, so just call that.
- */
-static void ppp_sync_hangup(struct tty_struct *tty)
-{
-	ppp_sync_close(tty);
-}
-
 /*
  * Read does nothing - no data is ever available this way.
  * Pppd reads and writes packets via /dev/ppp instead.
@@ -273,7 +208,7 @@ ppp_sync_write(struct tty_struct *tty, struct file *file, const u8 *buf,
 static int
 ppp_synctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
-	struct syncppp *ap = sp_get(tty);
+	struct syncppp *ap = tty->disc_data;
 	int __user *p = (int __user *)arg;
 	int err, val;
 
@@ -314,7 +249,6 @@ ppp_synctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
-	sp_put(ap);
 	return err;
 }
 
@@ -323,7 +257,7 @@ static void
 ppp_sync_receive(struct tty_struct *tty, const u8 *buf, const u8 *cflags,
 		 size_t count)
 {
-	struct syncppp *ap = sp_get(tty);
+	struct syncppp *ap = tty->disc_data;
 	unsigned long flags;
 
 	if (!ap)
@@ -333,21 +267,19 @@ ppp_sync_receive(struct tty_struct *tty, const u8 *buf, const u8 *cflags,
 	spin_unlock_irqrestore(&ap->recv_lock, flags);
 	if (!skb_queue_empty(&ap->rqueue))
 		tasklet_schedule(&ap->tsk);
-	sp_put(ap);
 	tty_unthrottle(tty);
 }
 
 static void
 ppp_sync_wakeup(struct tty_struct *tty)
 {
-	struct syncppp *ap = sp_get(tty);
+	struct syncppp *ap = tty->disc_data;
 
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	if (!ap)
 		return;
 	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
 	tasklet_schedule(&ap->tsk);
-	sp_put(ap);
 }
 
 
@@ -357,7 +289,6 @@ static struct tty_ldisc_ops ppp_sync_ldisc = {
 	.name	= "pppsync",
 	.open	= ppp_sync_open,
 	.close	= ppp_sync_close,
-	.hangup	= ppp_sync_hangup,
 	.read	= ppp_sync_read,
 	.write	= ppp_sync_write,
 	.ioctl	= ppp_synctty_ioctl,
-- 
2.43.0

