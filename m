Received: from mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993335B5AB
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880590; cv=none; b=sYSaxtZY6RztEJMyuEKz3yIQK4IHIFqMuDpO+ppydxy2cX2cykd6rFa4/t2NVib/P2+oS39zZAY3hNV+2YJugxANdiDb49W6KqE+HrBpw87B8ZWbRsKO3YOMYq1bil162jVWQlffHRSz/XUkXQFW5JLaNte8SVEx0YkhF5q8bM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880590; c=relaxed/simple;
	bh=4ygC9ah4cB4DgeiEpBWlR8jEegKdsLhI7vBzbtIkI4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vr5Et528WLODwUhCSwgZ37t13ym9FD4CGkCia3r2wCAiUr/Xt1ws+hgGet0vPGDNG9okogWmQYUlKvpioO3qWRByHoql6V1tbcFMpaeB74kpTzPKfrVq5gZktzEI+Sl+YJCmYfTSnBxon1CoZ6r3wybKus5MeW87ZC0D8TWOkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uOUITyK8; arc=none smtp.client-ip=91.218.175.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uOUITyK8"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4ygC9ah4cB4DgeiEpBWlR8jEegKdsLhI7vBzbtIkI4g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787880585; v=1; x=1788485385;
 b=uOUITyK8fRDkeh3JQK6MioRc4znsla7GBpGQqRjAD7tnZi0SxEQRTWXCrMxyDOpzmTU0MG1f
 JaFXDg6+RuD5r88L/qZS5eVhZZzs+UeZ+LVUT8IhiYbITweOuEpko4UOU4/tXFy20kfRPXt3b4Y
 aAOzg/piWzrJdcOnKDTlcNjQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 414351384a47a7c0;
	Fri, 28 Aug 2026 01:29:45 +0000
X-Mizu-Trace-ID: 414351384a47a7c0
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH net v1] raw: annotate disconnect-side IPv4 match writers
Date: Fri, 28 Aug 2026 09:29:18 +0800
Message-ID: <20260828012918.1461-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

raw_v4_match() reads inet_daddr, inet_rcv_saddr and
sk_bound_dev_if locklessly under RCU. Bind and connect writers are
annotated, but __udp_disconnect() still clears the same fields using
plain stores.

Commit 18f116931f52e ("raw: annotate lockless match fields in
raw_v4_match()") added the lockless readers and annotated the raw bind
and datagram connect writers. Its v4 revision intentionally left the
shared disconnect-side IPv4 writers for follow-up cleanup.

Complete that follow-up by using WRITE_ONCE() for the disconnect-side
stores, including the inet_rcv_saddr reset in inet_reset_saddr(), to
pair with the lockless raw socket matcher.

Fixes: 0daf07e52709 ("raw: convert raw sockets to RCU")
Link: https://lore.kernel.org/netdev/20260716142958.3064224-1-runyu.xiao@seu.edu.cn/
Suggested-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 include/net/ip.h | 3 ++-
 net/ipv4/udp.c   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index a8f57b4f4aa23..6f602df72ee62 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -704,7 +704,8 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 
 static __inline__ void inet_reset_saddr(struct sock *sk)
 {
-	inet_sk(sk)->inet_rcv_saddr = inet_sk(sk)->inet_saddr = 0;
+	inet_sk(sk)->inet_saddr = 0;
+	WRITE_ONCE(inet_sk(sk)->inet_rcv_saddr, 0);
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == PF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index af96032174441..6ff5670bf6ed1 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2166,10 +2166,10 @@ int __udp_disconnect(struct sock *sk, int flags)
 	 */
 
 	sk->sk_state = TCP_CLOSE;
-	inet->inet_daddr = 0;
+	WRITE_ONCE(inet->inet_daddr, 0);
 	inet->inet_dport = 0;
 	sock_rps_reset_rxhash(sk);
-	sk->sk_bound_dev_if = 0;
+	WRITE_ONCE(sk->sk_bound_dev_if, 0);
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
 		inet_reset_saddr(sk);
 		if (sk->sk_prot->rehash &&
-- 
2.43.0

