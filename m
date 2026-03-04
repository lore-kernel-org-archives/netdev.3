Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD53659F7
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594230; cv=none; b=F9R+XEnw3E45evjZjGiXwx0k+0Lhib/rf3w4l0JyyB3rGfZ8JNg6il26FusbPjlj6qeC73Pg6ADGxsoQit1zZHWADlvAAkCjwQr1I8w2qQFQiawM+FEaI+r/Zhs5rQPEhoYVx26c9kABdADm/3AGZAlOtOQjhIRPBr++K5akGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594230; c=relaxed/simple;
	bh=hJUekrPbKKJGtmrhvXdFBYLPnYJ/hqVMzcyIC6G/7QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFiiQR0V+HAKE4CWJVJ9jQAmazBEGDj8WtFV2oxvnEvwESWP99NESw7eh1szKaoUdR15TSe7sNtXuOsUwWu7OyZV/oRc23nadLdCRagWpB+HlybZob8mo5KFqMSueyiLpe1Db0o0Yx3bjcS9IVYfKtSgyRbT9Dv+EmeEqDci5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGE8JbSl; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGE8JbSl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772594216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DGcf3MqPW8cDqwJnm5iVow/I/Vkachm9gMvppZmd8OE=;
	b=iGE8JbSlh0AIfFDh5IUopXWDZJsJBISB82spvLkAKvxGELJh9VLGfwXh45/9hlhVJBiQ8m
	hAPjjNJzErGeZjWSs2iLvtAAd74B+HtLxwYOCZtQXahKNN75zi799fdWhL4BqrXiTfvUs7
	5QWxXu3OzUqlcZQnBENQg80PPy492nU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] net: annotate data races around sk->sk_prot
Date: Wed,  4 Mar 2026 11:16:24 +0800
Message-ID: <20260304031626.356955-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

inet_sendmsg(), inet_recvmsg() and sock_common_recvmsg() access
sk->sk_prot without lock_sock() or any other synchronization.

sock_replace_proto() (used by sockmap), TLS and MPTCP can change
sk->sk_prot under us, so these functions need READ_ONCE() to avoid
load tearing.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/sock.c    | 2 +-
 net/ipv4/af_inet.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f4e2ff23d60e..79b659cebbb1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3968,7 +3968,7 @@ int sock_common_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 {
 	struct sock *sk = sock->sk;
 
-	return sk->sk_prot->recvmsg(sk, msg, size, flags);
+	return READ_ONCE(sk->sk_prot)->recvmsg(sk, msg, size, flags);
 }
 EXPORT_SYMBOL(sock_common_recvmsg);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index babcd75a08e2..e95ffa070568 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -852,11 +852,13 @@ EXPORT_SYMBOL_GPL(inet_send_prepare);
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	return INDIRECT_CALL_2(sk->sk_prot->sendmsg, tcp_sendmsg, udp_sendmsg,
+	prot = READ_ONCE(sk->sk_prot);
+	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udp_sendmsg,
 			       sk, msg, size);
 }
 EXPORT_SYMBOL(inet_sendmsg);
@@ -882,11 +884,13 @@ int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags)
 {
 	struct sock *sk = sock->sk;
+	const struct proto *prot;
 
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	return INDIRECT_CALL_2(sk->sk_prot->recvmsg, tcp_recvmsg, udp_recvmsg,
+	prot = READ_ONCE(sk->sk_prot);
+	return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udp_recvmsg,
 			       sk, msg, size, flags);
 }
 EXPORT_SYMBOL(inet_recvmsg);
-- 
2.43.0

