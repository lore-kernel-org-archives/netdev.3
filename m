Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6949BD9C;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340529; cv=none; b=W/t45g4WxLd+u14DnniaJU4LHh59KiIwRz65Nv3tbCFbc8UF56lWkLXUdyR7ivN51s/crpcG6rVPJX9WM6iLlbGDz7xtnVIvrCBdf0DTnrE95975xNMr46L/aoVt/iOcVgVIY/ljT7E5C0XV9CXpdnxbOqCFd5MiCJ1KdJTLvU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340529; c=relaxed/simple;
	bh=l0a9nm7zRadFigfojIMROvbCPA/7dLyM8g88PgXKFCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GETZDmvL4g4IC+m4N/lDiLE91QTVjnkuL8kYEc5UP4OE0ROSNWW4uhp48cvEywQl9ipIJg+VYHS8olptZB667xbXMPbp+HpTJAnXt/zDOBE7/iUnqWC/rhm79gwslh8W4vcuXgiaFU5x3+mB98QYkuC5dE/xKRdnWPEx1LlT4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2VeIgM7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2VeIgM7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AFE7C2BCFA;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790340529;
	bh=l0a9nm7zRadFigfojIMROvbCPA/7dLyM8g88PgXKFCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y2VeIgM7iZGIgUsdiss+KvISFc2VkwuhUb4L/rAOJNo5CAZW61mBANWI3/DOoeS6p
	 TIqgfDLq6uzG9ajA5MInG94GDg6cgZjPfNsPSYNHKNYmI2Ziw24cDhLaZ3HRjOtOS6
	 egPBcgM+sKonVmErbTFaTFQy5OUxw3mYOrSQblagn44CIT7j1RcVVuDs2taXzgl90j
	 RD4o5qFZcJJxIXUIky0XNacIcGiY3rPfxn4WgHXP02+UWYRKjBKiat5bB45K2cnbz3
	 6odu4DnhZfJ66QdrIEmLRgZ50Ap4y/an88MG+T/J4HOuljqlFW1N1WWxwEh+RSswM4
	 Dd2G91+G2xUIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A449C98328;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 25 Sep 2026 05:47:57 -0700
Subject: [PATCH net-next v5 2/2] mptcp: annotate lockless access to
 sk->sk_err
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mptcp-sk-err-net-v5-2-0cac04d6ea48@proton.me>
References: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
In-Reply-To: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790340527; l=2847;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=MYYGmpLCYlWB4PjQJ+2gmFy11ZXQGpGk+UmDvXVc1xs=;
 b=PSelBSjLNL/6R29LWg3MMaIU1/FhF2hnG/6jI86RRD+MBgVheh88kPBgUIQPcKLsrRbQHKf3G
 xn1oEsmSpl3A0Ra36e13CQ5sjppwrWa2welXcd2acIGwV5im+Dp1qis
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

sock_error() can clear sk_err with xchg() without the socket lock.

On the no-data msk recv and splice paths, call sock_error() once and
only stop when it returns a non-zero error. Annotate the remaining
msk send and subflow error-report peeks with READ_ONCE().

Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/protocol.c | 14 ++++++--------
 net/mptcp/subflow.c  |  4 ++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f08f71cdb1..e37a8642a4b0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -969,7 +969,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 
 	moved = __mptcp_move_skbs_from_subflow(msk, ssk, true);
 	__mptcp_ofo_queue(msk);
-	if (unlikely(ssk->sk_err))
+	if (unlikely(READ_ONCE(ssk->sk_err)))
 		__mptcp_subflow_error_report(sk, ssk);
 
 	/* If the moves have caught up with the DATA_FIN sequence number
@@ -2028,7 +2028,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ret = -EPIPE;
-	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
+	if (unlikely(READ_ONCE(sk->sk_err) || (sk->sk_shutdown & SEND_SHUTDOWN)))
 		goto do_error;
 
 	pfrag = sk_page_frag(sk);
@@ -2429,10 +2429,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    !timeo)
 				break;
 		} else {
-			if (sk->sk_err) {
-				copied = sock_error(sk);
+			copied = sock_error(sk);
+			if (copied)
 				break;
-			}
 
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
@@ -4655,10 +4654,9 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 				break;
 			if (sock_flag(sk, SOCK_DONE))
 				break;
-			if (sk->sk_err) {
-				ret = sock_error(sk);
+			ret = sock_error(sk);
+			if (ret)
 				break;
-			}
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
 			if (sk->sk_state == TCP_CLOSE) {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..ec9668fe8d5b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1541,7 +1541,7 @@ static void subflow_data_ready(struct sock *sk)
 		if (mptcp_data_avail(msk) < parent->sk_rcvlowat &&
 		    (tcp_sk(sk)->rcv_nxt - tcp_sk(sk)->rcv_wup) > inet_csk(sk)->icsk_ack.rcv_mss)
 			inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
-	} else if (unlikely(sk->sk_err)) {
+	} else if (unlikely(READ_ONCE(sk->sk_err))) {
 		subflow_error_report(sk);
 	}
 }
@@ -1889,7 +1889,7 @@ static void subflow_state_change(struct sock *sk)
 	 */
 	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
-	else if (unlikely(sk->sk_err))
+	else if (unlikely(READ_ONCE(sk->sk_err)))
 		subflow_error_report(sk);
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);

-- 
2.55.0


