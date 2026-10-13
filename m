Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE4279DB1;
	Tue, 13 Oct 2026 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880048; cv=none; b=b5LG9/fNeMYiuF6kXCHgeDF69REohpu1LlCXo8nbRDYLeTgAyZ0zd3sqG2xIjfPCUgtJ0YOSOpckAhAtMgg724TNpo3KRaPq5n3iiVioU3iMjV/Nm5TLRzJ3jbvMjqS2ZXIYWx0ToaUTgqJqN3W/NWo+FZTAeeXUJOhQFvkYWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880048; c=relaxed/simple;
	bh=IMcM9uBwZa2UWfHdPqyD49fcTAg+agZSvAdE3zCAJAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhHXVcx559hhpnNTfsPZaZ3HB0HDojMtkzpKQild61y/ZUFcFpFLRZ92r8kvvwktBi14S11wqlYIjcTUIdqBTzpd5R4scrNOksYIHF00/mSM8fwQA/lUgZGJyzxvqxHAp1nUFFqZINESLRWgS3kgS6YyUntqLSWI8QjF7VXe/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=aLT682RX; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="aLT682RX"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZtQHud8YUUMLe2ZfjVTIkZB69uQUkcA6EIO8DT8Z1lM=;
	b=aLT682RX/JIP+epyrrcs4V9LzoW/+XiF/iEM9M4Oudyq4DeYGQIanTdnpRbTAa1n9WY51Ivgd
	TjDiF1h1PdDrK2v6UbkH+pqkDrXOeo+9AiQrFETRl22QIn14WTufSFJgCxACyyKDAnb1Vx+N55y
	Pd/sUBrfVqUK5L2/7QtozmY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4j3nFL5pkNz1T4Fq;
	Tue, 13 Oct 2026 16:15:02 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id B7E5420333;
	Tue, 13 Oct 2026 16:27:22 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100001.china.huawei.com
 (7.202.195.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 16:27:21 +0800
From: xietangxin <xietangxin@h-partners.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
	<jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: huyizhen <huyizhen2@huawei.com>, gaoxingwang <gaoxingwang1@huawei.com>,
	xietangxin <xietangxin@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v3] net: tun: fix race condition between tun_attach and tun_get_user with XDP
Date: Tue, 13 Oct 2026 16:37:39 +0800
Message-ID: <20261013083739.862074-1-xietangxin@h-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100001.china.huawei.com (7.202.195.168)

Concurrent ioctl and write() operations on the same file descriptor
can trigger a WARN_ONCE in netif_get_rxqueue():

  virt_tun0 received packet on queue 2, but number of RX queues is 2
  WARNING: CPU: 2 PID: 5989 at net/core/dev.c:5494
  Call trace:
   bpf_prog_run_generic_xdp
   netif_receive_generic_xdp
   do_xdp_generic
   tun_get_user
   tun_chr_write_iter

This bug manifests on three paths, all leading to the same WARN:
1. Initial attach (TUNSETIFF): tfile->tun transitions from NULL to
   non-NULL, but is published before tun_set_real_num_queues().

   CPU 0 (tun_attach)            CPU 1 (tun_get_user)
   tfile->queue_index = 2
   rcu_assign_pointer(tfile->tun)
                                 skb_record_rx_queue(skb, 2)
                                 do_xdp_generic()
                                   netif_get_rxqueue()
                                   // index(2) >= real(2) -> WARN
   tun_set_real_num_queues()
     real_num_rx_queues = 3

2. Re-attach (TUNSETQUEUE): tfile->tun isn't cleared by __tun_detach
   with clean=false, so rcu_assign_pointer(tfile->tun, tun) writes the
   same pointer value that readers already observe.

   CPU 0 (re-attach)             CPU 1 (tun_get_user)
   tfile->queue_index = 2
   tun_enable_queue(tfile)
     tfile->detached = NULL
                                 skb_record_rx_queue(skb, 2)
                                 do_xdp_generic()
                                   netif_get_rxqueue()
                                   // index(2) >= real(2) -> WARN
   tun_set_real_num_queues()
     real_num_rx_queues = 3

3. A write() on the detached fd records a stale queue_index
   via skb_record_rx_queue(), then enters do_xdp_generic() which
   calls netif_get_rxqueue(). Since dev->real_num_rx_queues has already
   been shrunk, the stale index is out of bounds.

Fix this by:
a) In tun_attach(), move rcu_assign_pointer(tfile->tun, tun) after
   tun_set_real_num_queues(), so that concurrent readers acquiring
   tfile->tun also see the updated real_num_rx_queues.
b) In tun_attach(), defer tun_enable_queue() and tun_napi_enable()
   to after tun_set_real_num_queues(), keeping tfile->detached
   non-NULL during the re-attach window.
c) In tun_get_user()'s skb_xdp branch, add a tfile->detached check
   at the beginning.

Fixes: 3fe260e00cd0 ("net: tun: record RX queue in skb before do_xdp_generic()")
Cc: stable@vger.kernel.org
Signed-off-by: xietangxin <xietangxin@h-partners.com>
---
v3:
- Fix race condition between re-attach and tun_get_user with XDP (sashiko).
- Fix write on the detached fd with XDP (sashiko).

v2:
- Defer publishing tfile->tun after tun_set_real_num_queues() instead of
  moving numqueues increment, as suggested by Jason Wang, to prevent
  potential TX packet drops.
  https://lore.kernel.org/netdev/20260920030240.443223-1-xietangxin@h-partners.com/
  
v1:
  https://lore.kernel.org/netdev/20260917074149.1799437-1-xietangxin@h-partners.com/
---
 drivers/net/tun.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd07..dcab0aba6705 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -792,10 +792,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		err = 0;
 	}
 
-	if (tfile->detached) {
-		tun_enable_queue(tfile);
-		tun_napi_enable(tfile);
-	} else {
+	if (!tfile->detached) {
 		sock_hold(&tfile->sk);
 		tun_napi_init(tun, tfile, napi, napi_frags);
 	}
@@ -811,11 +808,16 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	 * initialized tfile; otherwise we risk using half-initialized
 	 * object.
 	 */
-	if (publish_tun)
-		rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
 	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
 	tun_set_real_num_queues(tun);
+	if (publish_tun)
+		rcu_assign_pointer(tfile->tun, tun);
+
+	if (tfile->detached) {
+		tun_enable_queue(tfile);
+		tun_napi_enable(tfile);
+	}
 out:
 	return err;
 }
@@ -1960,6 +1962,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		struct bpf_prog *xdp_prog;
 		int ret;
 
+		if (unlikely(tfile->detached)) {
+			err = -EBUSY;
+			goto free_skb;
+		}
+
 		local_bh_disable();
 		rcu_read_lock();
 		xdp_prog = rcu_dereference(tun->xdp_prog);
-- 
2.43.0

