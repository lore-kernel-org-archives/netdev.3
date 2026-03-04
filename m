Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2930E84D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606609; cv=none; b=Qeg+0fVrR1BkZvcB2uKwBd0HV2efGeDoeyOrMmztTPRF8mJfcejEDo3xn4Zad5QpNEEeg1IYgWKku2uB/LMlQpA+xzv/RaxIdoK5Xhf+QMRgLL7mmg2A9mpTM3B7JT9Vz7PcyYddO1Kx689U7sfq5MhYIIwNpnmjYEiAlXjBB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606609; c=relaxed/simple;
	bh=5Jc5E7E5Ppccpg54E1+lRK9bgM0BWkc5blEhCU1E6EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rruws9IIu8S18LvbVdAXW+mKObmkiRXkUjiTQID6+s7TMszVFjvIpqZVAWoLCwOqbIGYo/hsWWwEH+XaJNANWHdyK8rh2FsAEU51WVjuB3pJViYNjvZaIk6MH47XfC4fb3CnAnA2DMqhIPH33g3XthwIuVG78PpLcxDklZJV2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CwR+G3yw; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CwR+G3yw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lRrYV3zzQRK3YIu7E8khBRhY3YoRX+UMNCW59Ca0MVQ=;
	b=CwR+G3ywoQb2lcasajPnic8Yy6Tb9I/UeB/+u42Wp+pXiXQaYh21ZNAX3OOkmEb7YXWD1d
	NBTddT9MznsyPv15zlzW0sCHhWPaSPNGrHon49EwPVQ0xQd6YTa8DYOh0ocRfYMRi0ndaO
	fbAyCDnBlhPUOjXy0DDjYCtdbDvYx1c=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	kuniyu@google.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: annotate data races around sk->sk_prot
Date: Wed,  4 Mar 2026 14:42:52 +0800
Message-ID: <20260304064253.16955-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

inet_sendmsg() and inet_recvmsg() access sk->sk_prot without
lock_sock() or any other synchronization.

sock_replace_proto() (used by sockmap), TLS and MPTCP can change
sk->sk_prot under us, so these functions need READ_ONCE() to avoid
load tearing.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/af_inet.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

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

