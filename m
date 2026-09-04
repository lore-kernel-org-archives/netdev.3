Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB8265623
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491528; cv=none; b=AEuayjt46JLiANMXvEE5KPIfBBkofS0bjV5x9fTR3oLmqYkWcHV+BNyVqVGw7RycJy2rQ8U8QAqlWo3SUCJibs56Yx1F6K+DF2qN9zF8WgU7Ze8FetxEPdP0gi5UpfGFkzv725s7l+nOtO6GELn/hky3F1AHLYrc5jkdBsDbjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491528; c=relaxed/simple;
	bh=TRSI57ZXmdXSks+6IaYGJFhIqlTFRUIhrcHMelJl930=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jj4TPy31OXSyj96p8d1iNHLXsyLTbHTey0bHwszOSxGD4Xp54u4NAhp8TwfviXjdDZywiKeed0LeLLmSrTreze2FFAHd/ZxSprJDUXtQCQXsgS+kxY70b6oGEub34uwhu2Nx+iRRC9zkncaw2w47XdU1O7nt8HLyn96vySgTovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eFGcFYJS; arc=none smtp.client-ip=91.218.175.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eFGcFYJS"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TRSI57ZXmdXSks+6IaYGJFhIqlTFRUIhrcHMelJl930=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788491524; v=1; x=1789096324;
 b=eFGcFYJSMumw9fh4tXQXrKiFkz9H4DUci5QCy5bL2F1J5W8mkqtOYWLTQsQ7/5HdbhUBeyYI
 NJO9uRLkjp1IWNQcqynrFRI78GTbXcT+VrCX+kjZ+y5HriEH7Tw30gNXVKlKh3WSiV59W7CyxCw
 BFwBpMaVJiYihnrqBkRedDmY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c2659f6d9c71e7ea;
	Fri, 04 Sep 2026 03:12:04 +0000
X-Mizu-Trace-ID: c2659f6d9c71e7ea
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mitchell Blank Jr <mitch@sfgoth.com>,
	Chas Williams <3chas3@gmail.com>,
	Simon Horman <horms@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Felix Fietkau <nbd@nbd.name>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net
Subject: [PATCH net-next] ppp: pass private data to channel callbacks
Date: Fri,  4 Sep 2026 11:11:39 +0800
Message-ID: <20260904031153.30304-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PPP channel callbacks receive struct ppp_channel only to retrieve the
driver's private pointer. Pass that pointer directly instead.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_async.c   | 13 ++++++-------
 drivers/net/ppp/ppp_generic.c | 12 ++++++------
 drivers/net/ppp/ppp_synctty.c | 13 ++++++-------
 drivers/net/ppp/pppoe.c       |  8 ++++----
 drivers/net/ppp/pptp.c        |  9 ++++-----
 include/linux/ppp_channel.h   |  6 +++---
 net/atm/pppoatm.c             | 21 ++++++++-------------
 net/l2tp/l2tp_ppp.c           |  6 +++---
 8 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index ea7fe9608ffd..e73b0fce86b9 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -91,13 +91,12 @@ MODULE_ALIAS_LDISC(N_PPP);
  * Prototypes.
  */
 static int ppp_async_encode(struct asyncppp *ap);
-static int ppp_async_send(struct ppp_channel *chan, struct sk_buff *skb);
+static int ppp_async_send(void *private, struct sk_buff *skb);
 static int ppp_async_push(struct asyncppp *ap);
 static void ppp_async_flush_output(struct asyncppp *ap);
 static void ppp_async_input(struct asyncppp *ap, const unsigned char *buf,
 			    const u8 *flags, int count);
-static int ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd,
-			   unsigned long arg);
+static int ppp_async_ioctl(void *private, unsigned int cmd, unsigned long arg);
 static void ppp_async_process(struct tasklet_struct *t);
 
 static void async_lcp_peek(struct asyncppp *ap, unsigned char *data,
@@ -321,9 +320,9 @@ ppp_async_init(void)
  * The following routines provide the PPP channel interface.
  */
 static int
-ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
+ppp_async_ioctl(void *private, unsigned int cmd, unsigned long arg)
 {
-	struct asyncppp *ap = chan->private;
+	struct asyncppp *ap = private;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	int err, val;
@@ -550,9 +549,9 @@ ppp_async_encode(struct asyncppp *ap)
  * at some later time.
  */
 static int
-ppp_async_send(struct ppp_channel *chan, struct sk_buff *skb)
+ppp_async_send(void *private, struct sk_buff *skb)
 {
-	struct asyncppp *ap = chan->private;
+	struct asyncppp *ap = private;
 
 	ppp_async_push(ap);
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893b..3b83ff8cf589 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -790,7 +790,7 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			chan = pch->chan;
 			err = -ENOTTY;
 			if (chan && chan->ops->ioctl)
-				err = chan->ops->ioctl(chan, cmd, arg);
+				err = chan->ops->ioctl(chan->private, cmd, arg);
 			mutex_unlock(&pch->chan_sem);
 		}
 		goto out;
@@ -1603,7 +1603,7 @@ static int ppp_fill_forward_path(struct net_device_path_ctx *ctx,
 	if (!chan->ops->fill_forward_path)
 		return -EOPNOTSUPP;
 
-	return chan->ops->fill_forward_path(ctx, path, chan);
+	return chan->ops->fill_forward_path(ctx, path, chan->private);
 }
 
 static const struct net_device_ops ppp_netdev_ops = {
@@ -1932,7 +1932,7 @@ ppp_push(struct ppp *ppp, struct sk_buff *skb)
 			goto out;
 		}
 
-		ret = chan->ops->start_xmit(chan, skb);
+		ret = chan->ops->start_xmit(chan->private, skb);
 
 out:
 		spin_unlock(&pch->downl);
@@ -2142,7 +2142,7 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
 		/* try to send it down the channel */
 		chan = pch->chan;
 		if (!skb_queue_empty(&pch->file.xq) ||
-			!chan->ops->start_xmit(chan, frag))
+			!chan->ops->start_xmit(chan->private, frag))
 			skb_queue_tail(&pch->file.xq, frag);
 		pch->had_frag = 1;
 		p += flen;
@@ -2175,7 +2175,7 @@ static void __ppp_channel_push(struct channel *pch, struct ppp *ppp)
 	if (pch->chan) {
 		while (!skb_queue_empty(&pch->file.xq)) {
 			skb = skb_dequeue(&pch->file.xq);
-			if (!pch->chan->ops->start_xmit(pch->chan, skb)) {
+			if (!pch->chan->ops->start_xmit(pch->chan->private, skb)) {
 				/* put the packet back and try again later */
 				skb_queue_head(&pch->file.xq, skb);
 				break;
@@ -2300,7 +2300,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 	}
 
 	skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
-	if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
+	if (!pchb->chan->ops->start_xmit(pchb->chan->private, skb))
 		kfree_skb(skb);
 
 outl:
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index f87d43faeeab..54d8402e18c4 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -81,9 +81,8 @@ struct syncppp {
  * Prototypes.
  */
 static struct sk_buff* ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *);
-static int ppp_sync_send(struct ppp_channel *chan, struct sk_buff *skb);
-static int ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd,
-			  unsigned long arg);
+static int ppp_sync_send(void *private, struct sk_buff *skb);
+static int ppp_sync_ioctl(void *private, unsigned int cmd, unsigned long arg);
 static void ppp_sync_process(struct tasklet_struct *t);
 static int ppp_sync_push(struct syncppp *ap);
 static void ppp_sync_flush_output(struct syncppp *ap);
@@ -312,9 +311,9 @@ ppp_sync_init(void)
  * The following routines provide the PPP channel interface.
  */
 static int
-ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
+ppp_sync_ioctl(void *private, unsigned int cmd, unsigned long arg)
 {
-	struct syncppp *ap = chan->private;
+	struct syncppp *ap = private;
 	int err, val;
 	u32 accm[8];
 	void __user *argp = (void __user *)arg;
@@ -491,9 +490,9 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
  * at some later time.
  */
 static int
-ppp_sync_send(struct ppp_channel *chan, struct sk_buff *skb)
+ppp_sync_send(void *private, struct sk_buff *skb)
 {
-	struct syncppp *ap = chan->private;
+	struct syncppp *ap = private;
 
 	ppp_sync_push(ap);
 
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index bf7414b46a26..758453503525 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -841,9 +841,9 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
  * sends PPP frame over PPPoE socket
  *
  ***********************************************************************/
-static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
+static int pppoe_xmit(void *private, struct sk_buff *skb)
 {
-	struct sock *sk = chan->private;
+	struct sock *sk = private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct net_device *dev = po->pppoe_dev;
 	struct pppoe_hdr *ph;
@@ -895,9 +895,9 @@ static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 
 static int pppoe_fill_forward_path(struct net_device_path_ctx *ctx,
 				   struct net_device_path *path,
-				   const struct ppp_channel *chan)
+				   void *private)
 {
-	struct sock *sk = chan->private;
+	struct sock *sk = private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct net_device *dev = po->pppoe_dev;
 
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index a797a0606f6b..8f7190d7067e 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -146,9 +146,9 @@ static struct rtable *pptp_route_output(const struct pppox_sock *po,
 	return ip_route_output_flow(net, fl4, sk);
 }
 
-static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
+static int pptp_xmit(void *private, struct sk_buff *skb)
 {
-	struct sock *sk = chan->private;
+	struct sock *sk = private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct net *net = sock_net(sk);
 	struct pptp_opt *opt = &po->proto.pptp;
@@ -573,10 +573,9 @@ static int pptp_create(struct net *net, struct socket *sock, int kern)
 	return error;
 }
 
-static int pptp_ppp_ioctl(struct ppp_channel *chan, unsigned int cmd,
-	unsigned long arg)
+static int pptp_ppp_ioctl(void *private, unsigned int cmd, unsigned long arg)
 {
-	struct sock *sk = chan->private;
+	struct sock *sk = private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct pptp_opt *opt = &po->proto.pptp;
 	void __user *argp = (void __user *)arg;
diff --git a/include/linux/ppp_channel.h b/include/linux/ppp_channel.h
index 2f63e9a6cc88..d9cfb8ef0ffa 100644
--- a/include/linux/ppp_channel.h
+++ b/include/linux/ppp_channel.h
@@ -27,12 +27,12 @@ struct ppp_channel;
 struct ppp_channel_ops {
 	/* Send a packet (or multilink fragment) on this channel.
 	   Returns 1 if it was accepted, 0 if not. */
-	int	(*start_xmit)(struct ppp_channel *, struct sk_buff *);
+	int	(*start_xmit)(void *, struct sk_buff *);
 	/* Handle an ioctl call that has come in via /dev/ppp. */
-	int	(*ioctl)(struct ppp_channel *, unsigned int, unsigned long);
+	int	(*ioctl)(void *, unsigned int, unsigned long);
 	int	(*fill_forward_path)(struct net_device_path_ctx *,
 				     struct net_device_path *,
-				     const struct ppp_channel *);
+				     void *);
 };
 
 struct ppp_channel {
diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
index 6da52d12df68..913324f9685f 100644
--- a/net/atm/pppoatm.c
+++ b/net/atm/pppoatm.c
@@ -91,11 +91,6 @@ static inline struct pppoatm_vcc *atmvcc_to_pvcc(const struct atm_vcc *atmvcc)
 	return (struct pppoatm_vcc *) (atmvcc->user_back);
 }
 
-static inline struct pppoatm_vcc *chan_to_pvcc(const struct ppp_channel *chan)
-{
-	return (struct pppoatm_vcc *) (chan->private);
-}
-
 /*
  * We can't do this directly from our _pop handler, since the ppp code
  * doesn't want to be called in interrupt context, so we do it from
@@ -286,9 +281,9 @@ static int pppoatm_may_send(struct pppoatm_vcc *pvcc, int size)
  * as success, just to be clear what we're really doing.
  */
 #define DROP_PACKET 1
-static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
+static int pppoatm_send(void *private, struct sk_buff *skb)
 {
-	struct pppoatm_vcc *pvcc = chan_to_pvcc(chan);
+	struct pppoatm_vcc *pvcc = private;
 	struct atm_vcc *vcc;
 	int ret;
 
@@ -366,16 +361,16 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
 }
 
 /* This handles ioctls sent to the /dev/ppp interface */
-static int pppoatm_devppp_ioctl(struct ppp_channel *chan, unsigned int cmd,
-	unsigned long arg)
+static int pppoatm_devppp_ioctl(void *private, unsigned int cmd,
+				unsigned long arg)
 {
+	struct pppoatm_vcc *pvcc = private;
+
 	switch (cmd) {
 	case PPPIOCGFLAGS:
-		return put_user(chan_to_pvcc(chan)->flags, (int __user *) arg)
-		    ? -EFAULT : 0;
+		return put_user(pvcc->flags, (int __user *)arg) ? -EFAULT : 0;
 	case PPPIOCSFLAGS:
-		return get_user(chan_to_pvcc(chan)->flags, (int __user *) arg)
-		    ? -EFAULT : 0;
+		return get_user(pvcc->flags, (int __user *)arg) ? -EFAULT : 0;
 	}
 	return -ENOTTY;
 }
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index ef8fdfaf051d..c1cda1d7fbf6 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -122,7 +122,7 @@ struct pppol2tp_session {
 	struct sock		*__sk;		/* Copy of .sk, for cleanup */
 };
 
-static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb);
+static int pppol2tp_xmit(void *private, struct sk_buff *skb);
 
 static const struct ppp_channel_ops pppol2tp_chan_ops = {
 	.start_xmit =  pppol2tp_xmit,
@@ -327,9 +327,9 @@ static int pppol2tp_sendmsg(struct socket *sock, struct msghdr *m,
  * the skb it supplied, not our cloned skb. So we take care to always
  * leave the original skb unfreed if we return an error.
  */
-static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
+static int pppol2tp_xmit(void *private, struct sk_buff *skb)
 {
-	struct sock *sk = (struct sock *)chan->private;
+	struct sock *sk = private;
 	struct l2tp_session *session;
 	struct l2tp_tunnel *tunnel;
 	int uhlen, headroom;
-- 
2.43.0

