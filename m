Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFC30F534;
	Tue,  2 Jun 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417970; cv=none; b=Z+UG9TJlBZZ4CVsT5sQr9dVPCy8YWzAXOcoG2gD/EVc/u9yEFY0LnbN7/KcNAlpGf7XCX13H9vtAZw0x8rD4fPKBIORNjB+P4/ZTRal4hCgFjwG4eVZ6aXXdclrAPmBxSPm/Iw1EoHwgzGlUQXPs7wMj1MqJmYlm2FxnK0RgFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417970; c=relaxed/simple;
	bh=aafgjk7IkndpTWX6p1gsvH55laMnwGYU5wIA42mzzd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DzczHwapuIeLfBvsm2bJhuNS5Ia/OuI3V0CMD69etCNbd4wV5I2x447zKyggJp5ovnbjJIl6uUxwxcH0qvQA/k4dVf6sossPHfKzeDUzfjFQ6olll+VgSNI5k3ZWroYryhTCs9NR7uIeuJCLRySBopKnaNsABBpJzwe4tJLkEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=g7123H2r; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="g7123H2r"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40c8332c9;
	Wed, 3 Jun 2026 00:27:36 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	maze@google.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net v2] raw: annotate data-races in raw_v4_match()
Date: Wed,  3 Jun 2026 00:27:27 +0800
Message-Id: <20260602162727.893863-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8929771403a1kunmd096a18c192f09
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk8eVh8eTElKTxhKGklISFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=g7123H2r26rFs2xEGPxIf9+gP8BSYgrZBMxxoTL1zzdePYXiJboqkymIQRUuK+MME++kkFnuwYLF1s4ubD244yW1Lg5Sk9hhEdLVK/rTHOnayuyIjfw07/SRcS0FA3onQ3sqLNsVyxTdlZr9RflG8LZ6nwgYMkRZFcCK4LoqKkU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=VCmpVCwuPaUwKCK0tSVDf99xBwTW6Bmc0cwOI64+CEs=;
	h=date:mime-version:subject:message-id:from;

raw_v4_match() is a lockless match helper under sk_for_each_rcu()
and still reads inet->inet_num, inet->inet_rcv_saddr and
sk->sk_bound_dev_if with plain loads.

inet_num and sk_bound_dev_if already have WRITE_ONCE() writers, and
raw_bind() should use WRITE_ONCE() for inet_rcv_saddr as well.

Add matching READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Note that inet_num and sk_bound_dev_if already have WRITE_ONCE() writers
- Add WRITE_ONCE() in raw_bind() for inet_rcv_saddr
- Previous version: https://lore.kernel.org/r/20260601073937.1137673-1-runyu.xiao@seu.edu.cn

 net/ipv4/raw.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 5aaf9c62c8e1..faa49f3d239a 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -120,11 +120,14 @@ bool raw_v4_match(struct net *net, const struct sock *sk, unsigned short num,
 		  __be32 raddr, __be32 laddr, int dif, int sdif)
 {
 	const struct inet_sock *inet = inet_sk(sk);
+	unsigned short match_num = READ_ONCE(inet->inet_num);
+	__be32 match_rcv_saddr = READ_ONCE(inet->inet_rcv_saddr);
+	int match_bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
 
-	if (net_eq(sock_net(sk), net) && inet->inet_num == num	&&
+	if (net_eq(sock_net(sk), net) && match_num == num &&
 	    !(inet->inet_daddr && inet->inet_daddr != raddr) 	&&
-	    !(inet->inet_rcv_saddr && inet->inet_rcv_saddr != laddr) &&
-	    raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
+	    !(match_rcv_saddr && match_rcv_saddr != laddr) &&
+	    raw_sk_bound_dev_eq(net, match_bound_dev_if, dif, sdif))
 		return true;
 	return false;
 }
@@ -727,7 +730,8 @@ static int raw_bind(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (!inet_addr_valid_or_nonlocal(net, inet, addr->sin_addr.s_addr,
 					 chk_addr_ret))
 		goto out;
 
-	inet->inet_rcv_saddr = inet->inet_saddr = addr->sin_addr.s_addr;
+	inet->inet_saddr = addr->sin_addr.s_addr;
+	WRITE_ONCE(inet->inet_rcv_saddr, addr->sin_addr.s_addr);
 	if (chk_addr_ret == RTN_MULTICAST || chk_addr_ret == RTN_BROADCAST)
 		inet->inet_saddr = 0;  /* Use device */
 	sk_dst_reset(sk);
-- 
2.34.1
