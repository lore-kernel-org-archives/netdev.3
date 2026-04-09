Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC622379EEF
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719745; cv=none; b=ZbEJ2QhEk61/jpypM1+PaeYO6746tulTqDTmV0+Uk7CJETTrPwptWOSAcBhKCX/NUiN0UuWpKyF1ThQZCJpNQPm9YKxtU99KHECfWCxj6IEjgMrbGML1n++FLz7b/aGNRpcknlqPzWzlVpLQq3H3m4S2SrBQRe+MsPBGSUdB1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719745; c=relaxed/simple;
	bh=IBKDApS8cl9ptSAnQtUs+GTa1DVVnMGBPGv+drTGiIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VCnKzdoYLUfBvdUE7+0azvw654vht34omIaR72J8WuRJXOD7s7WiyGVcA3wbDaymr8OkFAmXpJ9vn+Y29v0sW8kCYhENOXoK6TelwGxgCbhi+M8OvOq1Kz23OHDqkK25f3yzdXYXJYUCsiFwvuH5fo5ZNpn9W6lsVk9me5zpFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=0JIuvQF1; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="0JIuvQF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1775719741;
	bh=B9Ky8dM7FipFI/IZO7wupdIYKTEbpR7DFPjKqs0Wqbs=;
	h=From:Subject:Date:Message-Id;
	b=0JIuvQF1wk5S91AyN3uFM+B9Kz6rZGHZOFHN1G8H1CDD79jKVQTsrLg8QyMfRT/NE
	 HFYyTWrt954sVsZkEjuqPTkjc1celxhiS1237co53f/DuY8MFJevwGJ/S4XbaCP0UE
	 aeD2YWPmyGTxS4mM3HC+ULc9qgFeX/JUxYKJ6toI=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.21) with ESMTP
	id 69D754A500005FD3; Thu, 9 Apr 2026 15:26:34 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 6621113408540
X-SMAIL-UIID: BA6D2CF94FC24441B027FD2B1276A3BE-20260409-152634-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	imv4bel@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	luiz.von.dentz@intel.com
Subject: [PATCH 5.15.y] Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
Date: Thu,  9 Apr 2026 15:26:29 +0800
Message-Id: <20260409072629.621981-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 598dbba9919c5e36c54fe1709b557d64120cb94b ]

sco_recv_frame() reads conn->sk under sco_conn_lock() but immediately
releases the lock without holding a reference to the socket. A concurrent
close() can free the socket between the lock release and the subsequent
sk->sk_state access, resulting in a use-after-free.

Other functions in the same file (sco_sock_timeout(), sco_conn_del())
correctly use sco_sock_hold() to safely hold a reference under the lock.

Fix by using sco_sock_hold() to take a reference before releasing the
lock, and adding sock_put() on all exit paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 net/bluetooth/sco.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d98648bcc1a8..d0ef74c45914 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -311,7 +311,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -320,11 +320,15 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %u", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
-- 
2.34.1

