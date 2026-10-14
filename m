Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE42D23A6;
	Wed, 14 Oct 2026 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958122; cv=none; b=FZcYrPhHh1xmEWiVLxbrh0zsy5E9riVc3N2PlqZYOtREPo9WgO8kNwNzPLtoqH3KDCKuZBFuJT0HJnTCif5TMQqIj7CAoaLIZkIeWhS6adOrf6gepP3PMK/nM2jYZsv+LXDAHQs6wVdWekeLjj/ZOeutZpx+mry1KicVPYDTOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958122; c=relaxed/simple;
	bh=GRSZNsf+QHJX/h1fyRZ6q1w2Yh25nGjUFvhpmQKeDN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6t8RnvvJNVmauepf+hf8Efznm8+QZBV/V1a42mFlOewRV75mA8JC+XrA44xOXvzEwY2ndTxsJiT+lBFpb5c1Q6mY+inrYc2pMq21HzfT6oE5EII5V1pedgAi1GZavHnLJutJQTcTvQRLSplTaNW80s0LKTavfHp0gXVyrYhOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MYpQJnO3; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MYpQJnO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ic
	myl/IGq96hz/NgoyoogxTowXyKer1gdJWsLVRkjwE=; b=MYpQJnO34Wcs1f7/Qf
	v6m2zwYDBt05TzR6hxnLoN3+J5N8JhVkwefl6n8fmKUwUE/v2d4ubl+hQGkojDqA
	XRtsqh68gNWKQAOEd1L0ddqrhNtyUcB2DBfzMcX46V8bQjd3W6ISVB1sQva14DYv
	TNGbvVv1LTazd3VJhxg9NQrjA=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3179FHM9q18NZEg--.64391S2;
	Wed, 14 Oct 2026 14:08:06 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v1] net: sit: unlink PRL list before RCU free
Date: Wed, 14 Oct 2026 14:08:03 +0800
Message-ID: <20261014060803.286885-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3179FHM9q18NZEg--.64391S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1kKFWDtF4rWr18Ww48WFg_yoW8Zw4Upr
	WSg395tF4DJr18AF4ftF18Cr1xAFs3JF9rW3sa9rsYy3Zxuw40qa42kayqkFsxCFWrGF45
	t3ZYqa45Ja1UG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRhjjDUUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC-AamimrPHEbt7gAA3q

Deleting all PRL entries queues the old list for RCU freeing before
t->prl is cleared. A reader that enters an RCU critical section after
call_rcu() but before the pointer is cleared can still fetch the old
list, and that critical section is not guaranteed to be covered by the
grace period associated with the callback. RTNL does not prevent this
race: RCU readers do not acquire it and the writer remains preemptible.
It can lead to use-after-free.

BUG: KASAN: slab-use-after-free in ipip6_rcv+0x165b/0x1d60 [sit]
Read of size 4 at addr ffff888003aac488 by task poc38/3102
Allocated by task 3106:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 __kmalloc_cache_noprof+0x158/0x370
 ipip6_tunnel_siocdevprivate+0x96b/0xde0 [sit]
 dev_ifsioc+0x776/0x1530
 dev_ioctl+0x6ca/0xdd0
 sock_ioctl+0x42f/0x590
__x64_sys_ioctl+0x134/0x1c0
 do_syscall_64+0xf9/0x540
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 3100:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x43/0x70
 kfree+0x121/0x380
 prl_list_destroy_rcu+0x32/0x60 [sit]
 rcu_core+0x50a/0x1740
 handle_softirqs+0x18e/0x590
 __irq_exit_rcu+0x60/0x130
 sysvec_apic_timer_interrupt+0x36/0x80
 asm_sysvec_apic_timer_interrupt+0x1a/0x20

Fix by clearing the publication pointer before call_rcu().

Fixes: ef9a9d1183b3 ("ipv6 sit: RCU conversion phase I")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ipv6/sit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 19b7fa8d1a2a..b850f06fd734 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -447,8 +447,8 @@ ipip6_tunnel_del_prl(struct ip_tunnel *t, struct ip_tunnel_prl *a)
 		x = rtnl_dereference(t->prl);
 		if (x) {
 			t->prl_count = 0;
+			RCU_INIT_POINTER(t->prl, NULL);
 			call_rcu(&x->rcu_head, prl_list_destroy_rcu);
-			t->prl = NULL;
 		}
 	}
 out:
-- 
2.43.0

