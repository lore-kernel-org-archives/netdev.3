Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67E2BEC23;
	Thu, 17 Sep 2026 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630300; cv=none; b=Y6TUakPLb4rzq9k4Xh/yQszN+bZn2a8arNP4U26H2JjMhIFyjJ5KmgsefLNhX1hnRjt9m6QP/6unen8Jxg8cniPPuvZCuU6YKnR54p2DxJOh5qzeCA4RzMkEHWcMv8vX03WU0Jv4UTsSRg/dBQlrahpbgGt0tPxzyBuB4E+Z7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630300; c=relaxed/simple;
	bh=7nfqPkWorX3eXoaV+JOhDFIXNM/mucQ/rx94rQSp2l8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fSAd/85RyFd13lFCk8O6Ddsn5tKX1D5maNsaUPBeFc3dCygpZ0QZzYUmYGOjO47WFV66FYjShcb9oMhsN2pXni5ptsaiFpDTWcclWyZdUU5Yt9nLtnt1l3QLf4fJUsA98YhrecpCPuSYPOXcQevogmJNK/UFmMuFukiBxng/XlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=nlsSPQJQ; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="nlsSPQJQ"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ab0t+i5nnrof6CvOdbOMvW8GucM3FAS252b7jVA/X6A=;
	b=nlsSPQJQniLR551mo3DJOpMhFXUUZZxKcDo8ZkJ1Ca27SkpTbE1plUepc1OWLXDWb9pJURpjc
	RnqqjXbAG7j7tfmEdiMpCmiQHkvFss+bgNqqZp7jNujMn2N9azGD7QyJYfctEc3cUYNDi9d4oNt
	TW7AJ0UDDHt+QbpgrAJKYlM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hlnGQ1ZNszmV8g;
	Thu, 17 Sep 2026 15:20:30 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C5E2402AB;
	Thu, 17 Sep 2026 15:31:29 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100001.china.huawei.com
 (7.202.195.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 15:31:28 +0800
From: xietangxin <xietangxin@h-partners.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
	<jasowangio@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, huyizhen
	<huyizhen2@huawei.com>, gaoxingwang <gaoxingwang1@huawei.com>, xietangxin
	<xietangxin@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: tun: fix race condition between tun_attach and tun_get_user with XDP
Date: Thu, 17 Sep 2026 15:41:49 +0800
Message-ID: <20260917074149.1799437-1-xietangxin@h-partners.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Fix this by increase tun->numqueues and call tun_set_real_num_queues()
prior to publishing tfile->tun. This ensures dev->real_num_rx_queues
is updated before any concurrent packet processing path can observe
the attached tun file.

Fixes: 3fe260e00cd0 ("net: tun: record RX queue in skb before do_xdp_generic()")
Cc: stable@vger.kernel.org
Signed-off-by: xietangxin <xietangxin@h-partners.com>
---
 drivers/net/tun.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..2fb8df036d8c 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -807,15 +807,16 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	 * refcnt.
 	 */
 
+	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
+	tun_set_real_num_queues(tun);
+
 	/* Publish tfile->tun and tun->tfiles only after we've fully
 	 * initialized tfile; otherwise we risk using half-initialized
 	 * object.
 	 */
 	if (publish_tun)
 		rcu_assign_pointer(tfile->tun, tun);
-	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
-	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
-	tun_set_real_num_queues(tun);
+	rcu_assign_pointer(tun->tfiles[tun->numqueues - 1], tfile);
 out:
 	return err;
 }
-- 
2.43.0

