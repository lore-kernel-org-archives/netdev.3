Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250D303A04;
	Sat, 17 Oct 2026 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200337; cv=none; b=N2mp3ZBkBAPuWK5lLMNCLfvkhnQ+MFdgxmE5ugSwmrfhLq6+SC/qUC1z4dTKUhKheyUqsBMR6C/knbMMIoaVawoR66d4Nlr6SX71agcrERgcNPd0Yv71nJUV9A2oxgTKcQFcv4aq4Kv3SljopGusaOVJuWrdPsoHMJmJ9YHG1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200337; c=relaxed/simple;
	bh=TuRConst3u34uVYtzmxrXcek7shQRM9RgoNxVMAJyBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsJMX9473O9i4MfoRer21KNtaO91DFJ88wjs46fmaBiUDC0FOitvlfslxLKS6eIs/BvErgfoY0tjJh0IUf4GSPjjw5LyA2Egkgp5sv+3GFB6AiQ3yyeYe88ZXPf3feMuUqVOC88JssxQ+NpziWebEqEjpAXO5Osx8AM0OC8W/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a/GoxIZQ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a/GoxIZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cs
	XS74tJCjl+nJsx5qBuVjBDMdaQCN2uExL5gwwPBY8=; b=a/GoxIZQ2hLPWqImnd
	Wgnkr1rj7jhn/p5fxoBbm2oE2fW9LV2qnyUJpNH2LcvC22FckVw/IUtsm8WKXK+b
	fotvj6ANb4BLWtXmXoajkyDkS32X5wlwGTxnV+xaYgcBPSb2SwKXcbGeaWbkE1Vs
	eC+VDXx4afEN/rbdk+tRz864E=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3Q3hRztJquyIXAQ--.51309S2;
	Sat, 17 Oct 2026 09:24:35 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gwshan@linux.vnet.ibm.com,
	joel@jms.id.au
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v1] net/ncsi: fix use-after-free of ncsi_package in ncsi_remove_package()
Date: Sat, 17 Oct 2026 09:24:31 +0800
Message-ID: <20261017012431.413648-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3Q3hRztJquyIXAQ--.51309S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF18JrW8Cr17CFy3AFy8AFb_yoW5AF1rpF
	W3Jry5J34vyry0gFWkWrn8WF15Ars7uw1UG3sIgw4Sva45GryUZFySyayY9FyYkFZ7Canr
	Zr4UW34Y9F4DJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziMGQfUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+xMX+mrSzlOztgAA3l

ncsi_remove_package() unlinks the package from ndp->packages with
list_del_rcu() and immediately kfree()s it, after having released all
of its channels the same way.  As with the channels, the generic
netlink package info walkers iterate ndp->packages with
list_for_each_entry_rcu() and dereference the package in the loop body
(nla_put_u8(NCSI_PKG_ATTR_ID, np->id), np->multi_channel,
np->channels, ...), so an immediate kfree() turns a mid-walk reader
into a use-after-free the moment a teardown overlaps it.

  writer: rmmod ftgmac100
            -> ftgmac100_remove() -> ncsi_unregister_dev()
            -> ncsi_remove_package() -> kfree(np)
  reader: sendmsg(NETLINK_GENERIC, NCSI_CMD_PKG_INFO)
            -> ncsi_pkg_info_nl() -> ncsi_write_package_info()

Free the package with kfree_rcu() so that it survives the grace period
the readers rely on.

Tested on an arm multi_v7 kernel (KASAN + SLUB + PREEMPT) running as a
QEMU ast2600-evb guest with a host-side NC-SI responder; the PoC
hammers NCSI_CMD_PKG_INFO while cycling insmod/rmmod ftgmac100:

  BUG: KASAN: slab-use-after-free in ncsi_write_package_info+0xe3c/0xf84
  Read of size 1 at addr c69e2580 by task poc_dump/69
   ncsi_write_package_info from ncsi_pkg_info_nl+0x320/0x63c
   netlink_unicast from netlink_sendmsg+0x62c/0xb98
  Freed by task 65:
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes inside of

struct ncsi_package is 60 bytes and lands in kmalloc-64; a size-1 read
at offset 0 of that cache can only be np->id in this walker (the
u16 vids[] array reads show up as "Read of size 2"), pinning the report
to the kfree() fixed here.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h    | 1 +
 net/ncsi/ncsi-manage.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..082862581ea6 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -253,6 +253,7 @@ struct ncsi_package {
 	bool                 multi_channel; /* Enable multiple channels  */
 	u32                  channel_whitelist; /* Channels to configure */
 	struct ncsi_channel  *preferred_channel; /* Primary channel      */
+	struct rcu_head      rcu;
 };
 
 struct ncsi_request {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..76b2cb9efe4f 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu(np, rcu);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
-- 
2.43.0

