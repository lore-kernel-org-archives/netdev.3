Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBD3E7BB0
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493196; cv=none; b=e/OjQAEB87DZcxRJIp1NhbEWwSyO8fQyqY1YOlziIhJqhwzYKuJpQcNn6w05jxwpbuLPQ51sbvWechbH37nKGdnHZ+OaW1puL8sqXHocC2EQGB1uQP+uVGBdG3BIpA13v8B8dL0M/Eaq8TFyWCkFUgDAueOqFZNeBYuUQULmc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493196; c=relaxed/simple;
	bh=qvFaAifF1fTntockERUiok0vYuoGWsDv7nbDVki6Dfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHjvHnFx0kmlBUWv6VvJY2zk6aAGLBfoNJhJsd1dvwXkmEeTIkt4RqllAfpT1n8utq10xZFMOQXpsNdCbEZ2X5enq8XqA3SzRI6jbjUQ2r85T1WSsfbqmn85fXKfWhxi9Sy8CCGPo4rnuPQTB6f+myvdIaZE63ODrEw5Vk2MMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CglkFJB/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CglkFJB/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1381451a91.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785493178; x=1786097978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Fm4l+XBZNPZNokjVv0ih44ynafzkizelSQk/oJzlO0=;
        b=CglkFJB/GxvX4e/1aF4Mpd0iwKY3Vq7OTMFELuFevahYoCiyraszZplWdZkGFw6A7V
         Y6ABvQR3y3SJTS0yupHhle9Pzwa/cEc3s4mgDl3Cl3Fdj4LZr2vHrpTwGWcf5QUwaGHI
         jf4MAl8zoUFoSbe4FvnZxetlOvNKyR0dYuAYX0JAOLgztSP3Mmeq7F5pQ5VrU3DI/SNK
         7anZrPR+HSqmmuQTnteMxSRVOwVkRXkG5aiCKaqVKHgGk75zYz+7/DZz+KXo84Xv+2Qj
         yZaYGiirlbWmzq3YvrXxUXVHQ6DAy2YtyV3t5Tu7JHvZv6z6SHnwXo7o6fdUYLspkB87
         +pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785493178; x=1786097978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Fm4l+XBZNPZNokjVv0ih44ynafzkizelSQk/oJzlO0=;
        b=ra4esvkUAXA/tYFxrJSdCF2WkrldXtNoNUq3BVqADY9I/xXeDb0vwbF+z6OFFMSJqg
         drIZV+MlKkgcI244uphwZ4t9fpAzoYshJAN3DKA4/REcmbYjji2v9GGIKilg4NeV3s48
         F+dYVq3D+lwQeCnpxLt7YkN/XVY7cA3e0V7x+QBt+raqxDcOV2HD/IwfKCxc2LIC8QOm
         tggu9euBT3/wtaJZNbWwAnRFmR4ECL5EgBrfbfZuMfGWliCSZ4RCMqg8OS8tf0TmlvAj
         XAX9K8hvUdIRnoXalLMgwWndwfiIv9rNnZKWhs+GqWxuhKpm3U/M2eWXahkdTP5iQlbY
         zQoQ==
X-Gm-Message-State: AOJu0Yybfy+zCbHb+sjS6J/8iQZ5Lbu4bpVEiiNMTciQnEj6Wyl8jCra
	e1G9qSG1xq2E6cPNXoElYQUWx7uOPCOrACUwjPq43cjDeZKMbDT5pD86RjHRPlkedEk0fXKv
X-Gm-Gg: AR+sD13KIn2XLF4Wl49RY/AwJlQA01KkFzWNUHMhT+sg3RDcNT8hC2eKRIrKf0Qo49D
	Vtw2LwM4NmyRd4t51PH7thvKCShRgm+nmiEq1TXuyUI6JkSn4TlRImKFwj+W83pcIUyj3NLVRaj
	u3tXp/lRGdlrhhRDRmtOqI8O0OLmMmjtv8vhiZ2RgLr5YRHUvASK802jDsHt4H96DAt+OVdLzLT
	tliHFaB4f9YDi5UAuqJosdWeIX3tmZHxLblAorDE27hbFNCBsIK3xYTSFr3xNpGGwb0GkPomOTp
	TWSP7D24PmHJ3uFA+BuV316pLK0gTEF/juogNLxlWNCGfnCTghXevMppdscQpXc/l5xUabdw0ee
	m/ZrmWpyM6IkMAYODs6hhIs3ezpXAmyMai2RTaxWCJLKc43U5foFTi1LzaMJyZLyGoMzFq0t/rv
	RznbxwjRfV5ZfGkXp4IFzqu82/1K2x2CpIvAo2mayiJhMXx0OjoiK8ywdXKZE/w0DugrcJinFHD
	KZuc5/X1lqIZ16XgO0gcAViTZM=
X-Received: by 2002:a17:90b:3c8e:b0:37f:d265:18d2 with SMTP id 98e67ed59e1d1-38fb2b0dfa6mr945985a91.7.1785493177965;
        Fri, 31 Jul 2026 03:19:37 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2afa8f3sm261162a91.2.2026.07.31.03.19.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 03:19:37 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: purge cong_links under the socket lock in tipc_release()
Date: Fri, 31 Jul 2026 18:18:52 +0800
Message-ID: <20260731101926.31514-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

tipc_release() frees the elements of tsk->cong_links after release_sock(),
i.e. with no lock held:

	tipc_sk_remove(tsk);
	sock_orphan(sk);
	release_sock(sk);
	tipc_dest_list_purge(&tsk->cong_links);	/* no lock */
	tsk->cong_link_cnt = 0;

Every other accessor of that list runs under the socket lock, including
the SOCK_WAKEUP handler in tipc_sk_proto_rcv(), which does
tipc_dest_del(&tsk->cong_links, ...) while holding only sk->sk_lock.slock
via tipc_sk_rcv()'s spin_trylock_bh().  Because the purge never acquires
that spinlock, it provides no mutual exclusion against the wakeup path.

A SOCK_WAKEUP delivered for this port can therefore run concurrently with
the purge: tipc_sk_rcv() looks the socket up and takes a reference before
tipc_sk_remove() unhashes it, is then delayed past release_sock() so
sock_owned_by_user() is false, its spin_trylock_bh() succeeds, and it
list_del()s and kfree()s a struct tipc_dest that the closing task is
walking at the same time.  Both paths free entries of the same list.

__tipc_shutdown() does not close this window: it waits on
!tsk->cong_link_cnt but ignores the return value of tipc_wait_for_cond(),
which returns early on timeout, on a pending signal, or on sk_err, so the
close can proceed with cong_links still populated.

  BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x1ce/0x280
  Read of size 8 at addr ffff888105ddda88 by task poc_cong_race/7856
   __list_del_entry_valid_or_report+0x1ce/0x280
   tipc_dest_list_purge+0xad/0x240
   tipc_release+0x9a5/0x1340
  Allocated by task 7856:
   tipc_dest_push+0x11c/0x2f0
   __tipc_sendmsg+0x1443/0x17a0
  Freed by task 7851:
   tipc_dest_del+0x1ce/0x280
   tipc_sk_filter_rcv+0x1da7/0x2e70
   tipc_sk_rcv+0xdaa/0x1a80
   tipc_udp_recv+0x42a/0x7e0
  Oops: general protection fault ... Kernel panic - not syncing: Fatal exception

Move the purge above release_sock() so it runs under the socket lock, the
same discipline commit 844cf763fba6 ("tipc: make macro tipc_wait_for_cond()
smp safe") established for the wait condition.  A concurrent tipc_sk_rcv()
then either backlogs the wakeup because the socket is owned, or processes
it against an already empty list, and no new delivery can arrive because
tipc_sk_remove() has already unhashed the socket.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/tipc/socket.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d5d70eb230b5..9b45b16d0a31 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -647,11 +647,17 @@ static int tipc_release(struct socket *sock)
 	sk_stop_timer(sk, &sk->sk_timer);
 	tipc_sk_remove(tsk);
 
+	/* Purge under the socket lock: a straggler SOCK_WAKEUP that looked the
+	 * socket up before tipc_sk_remove() can still reach tipc_dest_del() on
+	 * this list, and it only holds the socket spinlock.  Purging after
+	 * release_sock() would race that list_del()/kfree().
+	 */
+	tipc_dest_list_purge(&tsk->cong_links);
+	tsk->cong_link_cnt = 0;
+
 	sock_orphan(sk);
 	/* Reject any messages that accumulated in backlog queue */
 	release_sock(sk);
-	tipc_dest_list_purge(&tsk->cong_links);
-	tsk->cong_link_cnt = 0;
 	call_rcu(&tsk->rcu, tipc_sk_callback);
 	sock->sk = NULL;
 
-- 
2.55.0

