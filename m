Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD83C8C68
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902389; cv=none; b=uG/9K124LKT0TM6Iwyy6KWL0TNtw+tbmZJGhMdp1t+LWuBHG/zDCx2nhaBYhvR0XdDHwdVrAj/ll90TaMBt8UWoFa8/gTDNCMqmTXhIwgIkJGrhtm197o+xhdwfPlJRj1HiBCcRwNl7h7uJ/zqb1BWFM8EyKSYBPQgQPwqFTqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902389; c=relaxed/simple;
	bh=vBI8qiNqWfdig8f1no8oTqj+y0xtSZOX4W0VabQ4hQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KC/bILtFdpkBIKuTpf7Uj20Dv3NH0bF2nh3uKioRYtHsCYVKHbFlNC5VxwJxCo26S/TGgFo3ecXtC9V6KcvhOtoKjClkJko4ZHFOPP706h+aI1U/evqiOmCLhXux8z4TLS4zY6cVJYOR6/FDlJZYVtrXMGCf/B3qlaaxmTr6dZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h1JSJnCB; arc=none smtp.client-ip=91.218.175.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h1JSJnCB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vBI8qiNqWfdig8f1no8oTqj+y0xtSZOX4W0VabQ4hQQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787902384; v=1; x=1788507184;
 b=h1JSJnCBlMknLaew8Ga8mBoEkz3z9Br+rABbaYqz/S4ai14yL1LFJmw6FAesqY7uW8h8DIUt
 IlXoMVMJKNV6CpRqDbgFHtkzI4G/fEakGkSCh/5tBkPelLse8iG/pnhHFeFzeYSUFuwZZS8TC+y
 OYUpZQ+FSUqYxnTLhDdyyJd4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7da2a8fcb4e03abb;
	Fri, 28 Aug 2026 07:32:54 +0000
X-Mizu-Trace-ID: 7da2a8fcb4e03abb
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
Cc: syzbot+8e808eb853386f575d86@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] ppp: ppp_async: simplify tty disc_data access
Date: Fri, 28 Aug 2026 15:32:36 +0800
Message-ID: <20260828073245.126804-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty_ldisc_hangup() invokes the hangup callback while holding only a read
lock on tty->ldisc_sem, so it can run concurrently with other line
discipline callbacks. This currently forces async PPP to maintain
separate lifetime protection around tty->disc_data.

Line discipline close is called under the write lock during hangup
processing. Remove the hangup callback and rely on close for teardown,
as done for SLIP by commit 23c53269f2ba ("slip: remove slip_hangup() to
fix use-after-free in slip_receive_buf()"). This serializes teardown
with all other line discipline operations.

disc_data_lock, refcount and completion are redundant with that
serialization. Remove them and access tty->disc_data directly.

This also eliminates a lockdep warning reported by syzbot. The warning
does not indicate a real deadlock because the write side runs only in
process context with hardirqs disabled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+8e808eb853386f575d86@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000002fbad30611e25849@google.com/
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_async.c | 82 ++++---------------------------------
 1 file changed, 7 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 583426d06381..ea7fe9608ffd 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -63,8 +63,6 @@ struct asyncppp {
 
 	struct tasklet_struct tsk;
 
-	refcount_t	refcnt;
-	struct completion dead;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 	unsigned char	obuf[OBUFSIZE];
 };
@@ -114,38 +112,6 @@ static const struct ppp_channel_ops async_ops = {
  * Routines implementing the PPP line discipline.
  */
 
-/*
- * We have a potential race on dereferencing tty->disc_data,
- * because the tty layer provides no locking at all - thus one
- * cpu could be running ppp_asynctty_receive while another
- * calls ppp_asynctty_close, which zeroes tty->disc_data and
- * frees the memory that ppp_asynctty_receive is using.  The best
- * way to fix this is to use a rwlock in the tty struct, but for now
- * we use a single global rwlock for all ttys in ppp line discipline.
- *
- * FIXME: this is no longer true. The _close path for the ldisc is
- * now guaranteed to be sane.
- */
-static DEFINE_RWLOCK(disc_data_lock);
-
-static struct asyncppp *ap_get(struct tty_struct *tty)
-{
-	struct asyncppp *ap;
-
-	read_lock(&disc_data_lock);
-	ap = tty->disc_data;
-	if (ap != NULL)
-		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
-	return ap;
-}
-
-static void ap_put(struct asyncppp *ap)
-{
-	if (refcount_dec_and_test(&ap->refcnt))
-		complete(&ap->dead);
-}
-
 /*
  * Called when a tty is put into PPP line discipline. Called in process
  * context.
@@ -180,9 +146,6 @@ ppp_asynctty_open(struct tty_struct *tty)
 	skb_queue_head_init(&ap->rqueue);
 	tasklet_setup(&ap->tsk, ppp_async_process);
 
-	refcount_set(&ap->refcnt, 1);
-	init_completion(&ap->dead);
-
 	ap->chan.private = ap;
 	ap->chan.ops = &async_ops;
 	ap->chan.mtu = PPP_MRU;
@@ -203,34 +166,18 @@ ppp_asynctty_open(struct tty_struct *tty)
 }
 
 /*
- * Called when the tty is put into another line discipline
- * or it hangs up.  We have to wait for any cpu currently
- * executing in any of the other ppp_asynctty_* routines to
- * finish before we can call ppp_unregister_channel and free
- * the asyncppp struct.  This routine must be called from
- * process context, not interrupt or softirq context.
+ * Called when the tty is put into another line discipline or it hangs up.
+ * This call is serialized against other ldisc functions.
  */
 static void
 ppp_asynctty_close(struct tty_struct *tty)
 {
-	struct asyncppp *ap;
+	struct asyncppp *ap = tty->disc_data;
 
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
-	 * our channel ops (i.e. ppp_async_send/ioctl) are in progress
-	 * by the time it returns.
-	 */
-	if (!refcount_dec_and_test(&ap->refcnt))
-		wait_for_completion(&ap->dead);
+	tty->disc_data = NULL;
 	tasklet_kill(&ap->tsk);
 
 	ppp_unregister_channel(&ap->chan);
@@ -240,17 +187,6 @@ ppp_asynctty_close(struct tty_struct *tty)
 	kfree(ap);
 }
 
-/*
- * Called on tty hangup in process context.
- *
- * Wait for I/O to driver to complete and unregister PPP channel.
- * This is already done by the close routine, so just call that.
- */
-static void ppp_asynctty_hangup(struct tty_struct *tty)
-{
-	ppp_asynctty_close(tty);
-}
-
 /*
  * Read does nothing - no data is ever available this way.
  * Pppd reads and writes packets via /dev/ppp instead.
@@ -281,7 +217,7 @@ ppp_asynctty_write(struct tty_struct *tty, struct file *file, const u8 *buf,
 static int
 ppp_asynctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
-	struct asyncppp *ap = ap_get(tty);
+	struct asyncppp *ap = tty->disc_data;
 	int err, val;
 	int __user *p = (int __user *)arg;
 
@@ -322,7 +258,6 @@ ppp_asynctty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 		err = tty_mode_ioctl(tty, cmd, arg);
 	}
 
-	ap_put(ap);
 	return err;
 }
 
@@ -331,7 +266,7 @@ static void
 ppp_asynctty_receive(struct tty_struct *tty, const u8 *buf, const u8 *cflags,
 		     size_t count)
 {
-	struct asyncppp *ap = ap_get(tty);
+	struct asyncppp *ap = tty->disc_data;
 	unsigned long flags;
 
 	if (!ap)
@@ -341,21 +276,19 @@ ppp_asynctty_receive(struct tty_struct *tty, const u8 *buf, const u8 *cflags,
 	spin_unlock_irqrestore(&ap->recv_lock, flags);
 	if (!skb_queue_empty(&ap->rqueue))
 		tasklet_schedule(&ap->tsk);
-	ap_put(ap);
 	tty_unthrottle(tty);
 }
 
 static void
 ppp_asynctty_wakeup(struct tty_struct *tty)
 {
-	struct asyncppp *ap = ap_get(tty);
+	struct asyncppp *ap = tty->disc_data;
 
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	if (!ap)
 		return;
 	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
 	tasklet_schedule(&ap->tsk);
-	ap_put(ap);
 }
 
 
@@ -365,7 +298,6 @@ static struct tty_ldisc_ops ppp_ldisc = {
 	.name	= "ppp",
 	.open	= ppp_asynctty_open,
 	.close	= ppp_asynctty_close,
-	.hangup	= ppp_asynctty_hangup,
 	.read	= ppp_asynctty_read,
 	.write	= ppp_asynctty_write,
 	.ioctl	= ppp_asynctty_ioctl,
-- 
2.43.0

