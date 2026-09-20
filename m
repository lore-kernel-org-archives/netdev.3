Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42913BD62F;
	Sun, 20 Sep 2026 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872754; cv=none; b=pMUF65cPDxoY+1AtmrqhtWLlnycIq4nVFfhqDg5x3GmbwZvcYmD7uLY+oaPO7bC9DPzl3Jisra4ZQetaVMgIesFQkNtFXWjuvrK99nRnUmu6f/s0XfJOO0AScDQvsDkdgG5rbWmP08jEJR2H/H7vkCmFKwVim8t3yZg1W9cxqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872754; c=relaxed/simple;
	bh=QXb/cV89VsaP/9zRd2dab8d7D+flttke5bcHo40KykA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oj1fGP/nq1J5SANiNj8G4HFcJA2ymZLREcla8H0qiHiBOGeuDSuKGOb70W8u1tZjqkzI7ZuvxkB6sRS4aBcWPd0ou33Z5V4sEt917kleOGrX4aOsDpLIezEVKu3MrDJp3jOAcfktPvwl9XkZIbg7jnzqYDoP1UwAf6MXk4of2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=cKUwYex9; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="cKUwYex9"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XTqWSSuBf9KtefvaLEkU3prx7X2Sj4g8zqOqV2yeZww=;
	b=cKUwYex9nJ/5e313I3ljvFa+LoWUB+dJuOSv4Vq/HtsEiZi1Ims4sF7aJ8lGEDDL5VV2pRn37
	rlMJ8Kucnb7chx/6GBvb0q/Dacrl32bUouIGz94VqhNUlqRf9KH8PMv9RS4gyeMfBI9L8o0y9eX
	k7P9zfpFfRdBU6JujHsMANk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hnVvx0f6dzpStW;
	Sun, 20 Sep 2026 10:40:29 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 389F820333;
	Sun, 20 Sep 2026 10:52:21 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100001.china.huawei.com
 (7.202.195.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 20 Sep
 2026 10:52:20 +0800
From: xietangxin <xietangxin@h-partners.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
	<jasowangio@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, huyizhen
	<huyizhen2@huawei.com>, gaoxingwang <gaoxingwang1@huawei.com>, xietangxin
	<xietangxin@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: tun: fix race condition between tun_attach and tun_get_user with XDP
Date: Sun, 20 Sep 2026 11:02:40 +0800
Message-ID: <20260920030240.443223-1-xietangxin@h-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100001.china.huawei.com (7.202.195.168)

Concurrent TUNSETIFF ioctls and write() operations on the same
file descriptor can trigger a WARN_ONCE in netif_get_rxqueue():

  virt_tun0 received packet on queue 2, but number of RX queues is 2
  WARNING: CPU: 2 PID: 5989 at net/core/dev.c:5494
  Call trace:
   bpf_prog_run_generic_xdp
   netif_receive_generic_xdp
   do_xdp_generic
   tun_get_user
   tun_chr_write_iter

Because tfile->tun is published before tun_set_real_num_queues()
updates dev->real_num_rx_queues. Concurrent tun_get_user() can
observe the newly attached tun file and process packets with
the new queue_index before dev->real_num_rx_queues is updated.

CPU 0 (tun_attach)         CPU 1 (tun_get_user)
tfile->queue_index = 2
rcu_assign_pointer(tfile->tun)
                           skb_record_rx_queue(skb,tfile->queue_index)
                             do_xdp_generic()
                               netif_receive_generic_xdp()
                               bpf_prog_run_generic_xdp()
                               netif_get_rxqueue()
                               // index(2) >= real_num_rx_queues(2)
                                 WARN_ONCE
tun_set_real_num_queues()
  dev->real_num_rx_queues = 3

Fix this by moving rcu_assign_pointer(tfile->tun, tun) after
tun_set_real_num_queues(). This ensures dev->real_num_rx_queues
is updated before any concurrent packet processing path can observe
the attached tun file.

Fixes: 3fe260e00cd0 ("net: tun: record RX queue in skb before do_xdp_generic()")
Cc: stable@vger.kernel.org
Signed-off-by: xietangxin <xietangxin@h-partners.com>
---
v1 -> v2:
- Defer publishing tfile->tun after tun_set_real_num_queues() instead of
  moving numqueues increment, as suggested by Jason Wang, to prevent
  potential TX packet drops.
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..2dfca25b86e9 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -811,11 +811,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
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
 out:
 	return err;
 }
-- 
2.43.0

