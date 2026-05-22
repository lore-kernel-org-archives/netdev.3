Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159D11CAF;
	Fri, 22 May 2026 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412639; cv=none; b=HWGGE4ItcBP67LZJLrUrOxR5x19u0AOq/8VI2CMBseZF52XBxXi0sOvmUgJXxXdT+0nYXy8yz9HjahyXunGmPodWknFJCrVnKGhlAqSJhMxZUh6WBbjVtbsJaudksmJbESZnCmGOLe4zMQSCDbQzrcLoLDANfQpjJXq1Aqfx0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412639; c=relaxed/simple;
	bh=8SDtOnmUdsIHETLv+JxXHaX2XfvnSGeokYjGqmuI6O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgWnG1PGxrRo/zc8hC17p6MvfM/oxbpV6eQY32c96kq9UFCe3OD8/sXf6UimK6u61zRzRxyTRcpc/ncAQQ3Tc/Xv2nzt1dMJO2x3RnB4D0zMm+5GOCnclGXsYE5jC9qWoPS9aOfnRCDRWU3wEuztRadUNZw6bq6u9t6RNEThIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+jTNclZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+jTNclZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779412634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IKJ+X1WNjuIEeqP8tG1jQwI+VA6DwxQun0tsoICkQG8=;
	b=C+jTNclZYDSG9TXOzP3At9TXYuQYkHD+rKJPiGxNUcGfHgeOLOvcBEG5UeI5au9MgtU0bV
	YwX2baOyfDD7j4g/OlHZZzKfsV+VzJ9Ynjd6+DtqBP4G96yuGoshGfT3tjxp8VXFH4BL/H
	6NW/aH+Nv0ZVKKMYvvlOoO5FfK7k7rs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com,
	Allison Henderson <achender@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy Grover <andy.grover@oracle.com>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] rds: annotate data-race around rs_seen_congestion
Date: Fri, 22 May 2026 09:16:20 +0800
Message-ID: <20260522011621.304470-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

rs_seen_congestion is read in rds_poll() and written in rds_sendmsg()
and rds_poll() without any lock.  Use READ_ONCE()/WRITE_ONCE() to
annotate these lockless accesses and silence KCSAN.

Fixes: b98ba52f96e7 ("RDS: only put sockets that have seen congestion on the poll_waitq")
Reported-by: syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a0f8d94.050a0220.6b33c.0000.GAE@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/rds/af_rds.c | 4 ++--
 net/rds/send.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 76f625986a7f..93b2da63ed42 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -219,7 +219,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 
 	poll_wait(file, sk_sleep(sk), wait);
 
-	if (rs->rs_seen_congestion)
+	if (READ_ONCE(rs->rs_seen_congestion))
 		poll_wait(file, &rds_poll_waitq, wait);
 
 	read_lock_irqsave(&rs->rs_recv_lock, flags);
@@ -247,7 +247,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 
 	/* clear state any time we wake a seen-congested socket */
 	if (mask)
-		rs->rs_seen_congestion = 0;
+		WRITE_ONCE(rs->rs_seen_congestion, 0);
 
 	return mask;
 }
diff --git a/net/rds/send.c b/net/rds/send.c
index d8b14ff9d366..e5d58c29aabe 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1388,7 +1388,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
 	ret = rds_cong_wait(conn->c_fcong, dport, nonblock, rs);
 	if (ret) {
-		rs->rs_seen_congestion = 1;
+		WRITE_ONCE(rs->rs_seen_congestion, 1);
 		goto out;
 	}
 	while (!rds_send_queue_rm(rs, conn, cpath, rm, rs->rs_bound_port,
-- 
2.43.0

