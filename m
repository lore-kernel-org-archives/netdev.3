Received: from mail-m1052.netease.com (mail-m1052.netease.com [154.81.10.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB6341AC7;
	Mon,  1 Jun 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299588; cv=none; b=HWnIp4a9eRQ7Arg40ZIabB3+bSxUYgJAFHsQsjlapBngeriJtpUzurpZxcs4AHTA8SDG3iUybe5rtsBtigbgXy9sMe1qWoKXRdCkJpns1CxJrdFKW5E22vZ6VUZ9Fe+OQXRJ1s/bqETvWgVF/2AhoCkOk1tvU5PfimJgCUSAdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299588; c=relaxed/simple;
	bh=yjobHZVal6yZiqC5k1k55bV/H8VFvvmOxpDQKK8+U8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gR5I1hBmg656dYxyjiK4cAMvtzdy5LdJxqnu1eLhMimyR2PEW21Ar0ISxWYNC7X/SWs8+yGmkNPngOkeF0mYhce350+3DcJix2xsLezFQ04CxIqxYIHAPbX87Bb7xSikPYsBLty/xj5f5Nt/QMc2dkwU+hki/q3aa+EePQgEmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Z30ekauL; arc=none smtp.client-ip=154.81.10.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Z30ekauL"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 408fa7841;
	Mon, 1 Jun 2026 15:39:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net] raw: annotate data-races in raw_v4_match()
Date: Mon,  1 Jun 2026 15:39:37 +0800
Message-Id: <20260601073937.1137673-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e821fc88203a1kunm3b935cb712fd0c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh0aVkhMGklPGEtOTE1DQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Z30ekauLEaHDAPZbWYR444mxjTjJZx2WQs0wa8sF1JZrCpGopZ9K52jqPbeH4bBOJ+iUtacK4EGdxPLQOPKRIJdZL8zpbZi12FdntlgqYmyf1q/FeQRHasysaBSns5x1fq/m4PEpJfbz0JvaeiPbSWHUXO3eIScG4J37UWQ/RYU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=VnBHQ8lsS3n2o8lO2QgduK9WjfspnXxXmay2iA95oRQ=;
	h=date:mime-version:subject:message-id:from;

raw_v4_match() is a lockless match helper under sk_for_each_rcu()
and still reads inet->inet_num, inet->inet_rcv_saddr and
sk->sk_bound_dev_if with plain loads.

Add READ_ONCE() annotations for these fields.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ipv4/raw.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

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
-- 
2.34.1
