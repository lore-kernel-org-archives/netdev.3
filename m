Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5C2765DF;
	Sat, 11 Jul 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763579; cv=none; b=tqwH8fsD4vSaYaeQrj9759X2xbo4WEiV98LuG/kVYa8sfcr7X7GJCMXSTFNAOQOy4qAR/4V0o2Ga7bRcN9XKVbEjkJFCPxx3NGi+JR616EoU59S+kiAj4r0gXymRFlea7R9D7q/6WzFbmKozkRbzWfibMLwuxPCD41xWO21kzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763579; c=relaxed/simple;
	bh=oZc3NSz7j9XFr46H+8xpiMK6v3yVoJA0eq+KdYbGdZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6JkNpfIbN7lfOFk4lopVGfKzphnKNXuxgnj19E0Pe9tALFtRny2ioK370lOTxpaxJ+j0CXpqjhV/vcAKLT3Dpr9lx3BedXt0aZFUGnsVq+KpK9ZyIbcWXlD63qBxYsPd/N0wEYzQMHxu3+uNCn2FwULFMCYCcwfZptOXKybWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W5YJ6DJ+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W5YJ6DJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=93
	qzzp18BdHpg6UCOEk9nGzKJUd97R3FzqELx1kJMXU=; b=W5YJ6DJ+2ZGQPQ0rem
	U+8wa+c4BIFbFG6n2IyBEx9jD06lJr5RL1UAAbaAOl6/edT9WSOq/1kXfJlVAQpf
	pgLK78r4rEIgCeFM8C9N6rJWutgew/pJScjrya8VN7o3372OPPWG53RYcbClmP4w
	x9wUUskwc+cKOIBDnw/Fj7WvQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnf0BFElJqxwn1Ig--.25654S2;
	Sat, 11 Jul 2026 17:52:06 +0800 (CST)
From: albin_yang@163.com
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	albinwyang@tencent.com
Subject: [PATCH] af_unix: add cond_resched() when flushing receive queue on close
Date: Sat, 11 Jul 2026 17:51:47 +0800
Message-ID: <20260711095147.1972419-1-albin_yang@163.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnf0BFElJqxwn1Ig--.25654S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw13ZFWrZFW8Gw1rAw4rGrg_yoWkuFg_uF
	97Kr1DGF4rJr4xGayq9rs3X3ya9FWrXF1rZr1xCF17G348CFWYk3yDCr45G345W397KFnx
	GwnYqF9rKr15ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8v38UUUUUU==
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/xtbCzQbEZ2pSEkaXqQAA36

From: Wei Yang <albinwyang@tencent.com>

unix_release_sock() drains sk_receive_queue in a tight loop with no
rescheduling point.  Each iteration may do extra work depending on
the socket type: kfree_skb() runs unix_destruct_scm()->fput() for
SCM_RIGHTS fds on data sockets, and a LISTEN socket recurses into
unix_release_sock() for each embryonic child.

A long receive queue can hog the CPU and trip the softlockup watchdog
on CONFIG_PREEMPT_NONE kernels.  We have reproduced this multiple
times under stress-ng stress testing.  Add cond_resched() as done in
similar teardown loops (inet_csk_listen_stop, inet_twsk_purge,
close_files).

Signed-off-by: Wei Yang <albinwyang@tencent.com>
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..8b4624ce4178 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -724,6 +724,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 		/* passed fds are erased in the kfree_skb hook */
 		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
+		cond_resched();
 	}
 
 	if (path.dentry)
-- 
2.43.5

