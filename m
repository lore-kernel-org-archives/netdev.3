Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3F3AF65C
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884301; cv=none; b=EanBobtMFwrIP/q4ej9G0HZx74p2sCC7V2nbkwdENWlLXuXAbECz+0Y99OVAbs4+SmJLdGUwL20/uBzGg3TNM3pHoTnGkosIXMq4Dw9jRnbXMsJLREQiL2/6sD9HXdgxJV5t8ezcUFCdSatR+qbb6a/glN1Cz50pZboSdnOUc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884301; c=relaxed/simple;
	bh=n13yysFJZCNEaNkwoIHZqoISKfk+9d7PvnkHCq6VVPA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ql5a9Im2gbzOBTeuVp9OSlAaCDwbyxhcPjiyh/qe2GWEAA7xE+kZx8cVapTN5UV30HGOPNJT3nhYxLTi0EBGdbGbZeNlM+78GLmBiYZ25LllsZ6lbWtcCg18fL+9tY7DNk1OYmw7G6xM+aOjw+BnRqHrkoRJ//3wdAgvH+pRESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fU4KcK1W; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fU4KcK1W"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93106d8affcso12540385a.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784884299; x=1785489099; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VQBmjGLGwetCcn/UWfIY4WLCBP7RfOT4Cbb4+INMfl0=;
        b=fU4KcK1WrIMnOXLNDgCOzpChuFo+QMDd0w8jxxPETsz2G2Phlestux5kqQSBKIXkh0
         MCtXxICNoYX75NMjZZ2s9L/woEB4WWh+J06Zk6QSmwrEhlHr7El1HAfkujSg1VAx0Ghk
         laZLINWLi1fcrap3PU8qvrjt2Je4daAg9eyhdbk6pLi9X/TFOCTitGewkEtXe1+Gkdab
         HfxaVeOYkTCaf/NsZitbxNZz7GaMHsP3v7iOLCbQsqwmzZrsQkBO6TL6yKJGSs+atCda
         t2vm1e8xDvROeovIGt0AZYl8MwfgVOWYOkNmVNaTXQWf+Fh00TYsYvk+C8swjM2t0+4q
         KYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884299; x=1785489099;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQBmjGLGwetCcn/UWfIY4WLCBP7RfOT4Cbb4+INMfl0=;
        b=iid4fL42WB6uLgz/3MHh3M1X5zyk0d++/adct/ElZDGaEcakUQuaR+l4UVOOmdls98
         3oHKWOMXZZ5MfSzz77XqKUpU3exahTLmomtvJ821ld3GOmCesirVxmN3ndXnOdnVapl+
         BPVWhY7LPKzQtpV0+f7T5G56QnvBiFvQ3+CgwHyagWJfQZRefC0MOpHGGLmEi4bWunpk
         zTRIpQ0X3TXfGcByVQof8Fpp1/8wc8mLly6p3NNNXFF1Nc+z8M190xqIXMxm+XdgzSNe
         yg2ngc9Qaa9tDyG9Cg5ZIRiDVylbxKATFmvtb6OTVFPYwrSxFu34aEnDr68s4bQjYx9E
         jfYg==
X-Forwarded-Encrypted: i=1; AHgh+Rq96+aoflYcYawma7CnOnZZyQGFhMavu43ScJQ3lv809ltLVEt08j0fYtVMp36ss1WTeYP28kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpTItekhyDB3mYffs3gckqFLkCxENeCHu7EupRfc9clSOSbsP
	oGkLMEe1n7NjMq7R9Hd1v5goPUzp7edsPomlLLCDa4gbjI1k12fWxQrP4E5fn38WBxQa7hgK+OK
	NL5vAXRB2bOQEMg==
X-Received: from qknqk11.prod.google.com ([2002:a05:620a:888b:b0:92e:5f54:20e9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c4d:b0:92e:fd2c:6a26 with SMTP id af79cd13be357-931035f924cmr650654985a.24.1784884298250;
 Fri, 24 Jul 2026 02:11:38 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:11:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724091137.1792543-1-edumazet@google.com>
Subject: [PATCH net] net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+eca845fb8c18dd6b44c1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a memory leak [1] in the UDP tunnel NIC offload code.

When device registration fails (e.g. in register_netdevice()), netdev core
unwinds by sending a single NETDEV_UNREGISTER notification. If work was queued
during NETDEV_REGISTER (utn->work_pending is set), udp_tunnel_nic_unregister()
returns early:

	if (utn->work_pending)
		return;

Because failed registrations do not enter netdev_wait_allrefs_any(), no
subsequent NETDEV_UNREGISTER rebroadcast will ever occur. As a result, the
struct udp_tunnel_nic allocated in udp_tunnel_nic_alloc() is leaked
permanently.

Fix this by removing the early return. Instead, synchronously cancel any
pending work with cancel_delayed_work_sync() before freeing @utn.

To be able to call cancel_delayed_work_sync() while holding RTNL (the work also
needs RTNL), switch udp_tunnel_nic_device_sync_work() to rtnl_trylock(). If RTNL
is contended, requeue the work with a 1 jiffy delay (via queue_delayed_work())
to prevent high CPU contention while waiting for RTNL lock.

The utn->work_pending bookkeeping is no longer needed and is removed, as
the workqueue core already tracks the pending/running state of the work.

[1]
BUG: memory leak
unreferenced object 0xffff888127d5f840 (size 96):
  comm "syz-executor", pid 5806, jiffies 4294942188
  backtrace (crc 99fdb6c8):
    __kmalloc_noprof+0x3bf/0x550
    udp_tunnel_nic_alloc net/ipv4/udp_tunnel_nic.c:756 [inline]
    udp_tunnel_nic_register net/ipv4/udp_tunnel_nic.c:833 [inline]
    udp_tunnel_nic_netdevice_event+0x804/0xab0 net/ipv4/udp_tunnel_nic.c:931
    notifier_call_chain+0x59/0x160 kernel/notifier.c:85
    call_netdevice_notifiers_info+0x7d/0xb0 net/core/dev.c:2250
    register_netdevice+0xc10/0xeb0 net/core/dev.c:11478

Fixes: cc4e3835eff4 ("udp_tunnel: add central NIC RX port offload infrastructure")
Reported-by: syzbot+eca845fb8c18dd6b44c1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a632b15.dde6c935.cf6c8.0011.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp_tunnel_nic.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 3b32a0afa9798d3c416d9ae570e6d529f70e6697..53a1a9c1f8bff01674481e8d88238f2af61d8bb1 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -32,13 +32,12 @@ struct udp_tunnel_nic_table_entry {
  * @lock:	protects all fields
  * @need_sync:	at least one port start changed
  * @need_replay: space was freed, we need a replay of all ports
- * @work_pending: @work is currently scheduled
  * @n_tables:	number of tables under @entries
  * @missed:	bitmap of tables which overflown
  * @entries:	table of tables of ports currently offloaded
  */
 struct udp_tunnel_nic {
-	struct work_struct work;
+	struct delayed_work work;
 
 	struct net_device *dev;
 
@@ -46,7 +45,6 @@ struct udp_tunnel_nic {
 
 	u8 need_sync:1;
 	u8 need_replay:1;
-	u8 work_pending:1;
 
 	unsigned int n_tables;
 	unsigned long missed;
@@ -301,11 +299,10 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 static void
 udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
-	if (!utn->need_sync || utn->work_pending)
+	if (!utn->need_sync)
 		return;
 
-	queue_work(udp_tunnel_nic_workqueue, &utn->work);
-	utn->work_pending = 1;
+	queue_delayed_work(udp_tunnel_nic_workqueue, &utn->work, 0);
 }
 
 static bool
@@ -731,12 +728,17 @@ udp_tunnel_nic_replay(struct net_device *dev, struct udp_tunnel_nic *utn)
 static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
 {
 	struct udp_tunnel_nic *utn =
-		container_of(work, struct udp_tunnel_nic, work);
+		container_of(work, struct udp_tunnel_nic, work.work);
 
-	rtnl_lock();
+	/* We cannot block on RTNL here, otherwise we would deadlock with
+	 * udp_tunnel_nic_unregister() calling cancel_delayed_work_sync()
+	 * while holding RTNL. Requeue with 1 jiffy delay if RTNL is contended.
+	 */
+	if (!rtnl_trylock()) {
+		queue_delayed_work(udp_tunnel_nic_workqueue, &utn->work, 1);
+		return;
+	}
 	mutex_lock(&utn->lock);
-
-	utn->work_pending = 0;
 	__udp_tunnel_nic_device_sync(utn->dev, utn);
 
 	if (utn->need_replay)
@@ -757,7 +759,7 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 	if (!utn)
 		return NULL;
 	utn->n_tables = n_tables;
-	INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
+	INIT_DELAYED_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
 	mutex_init(&utn->lock);
 
 	for (i = 0; i < n_tables; i++) {
@@ -901,11 +903,11 @@ udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic *utn)
 	udp_tunnel_nic_flush(dev, utn);
 	udp_tunnel_nic_unlock(dev);
 
-	/* Wait for the work to be done using the state, netdev core will
-	 * retry unregister until we give up our reference on this device.
+	/* Make sure no work is running or queued before freeing @utn.
+	 * The work handler uses rtnl_trylock(), so it will not deadlock
+	 * against the RTNL we are holding here.
 	 */
-	if (utn->work_pending)
-		return;
+	cancel_delayed_work_sync(&utn->work);
 
 	udp_tunnel_nic_free(utn);
 release_dev:
-- 
2.55.0.229.g6434b31f56-goog

