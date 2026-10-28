Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203732;
	b=mF7iiRRPp43+biaqYYiBFQc8V74aJv0JeMOpahGL5QqlICacNuLHe4LV2ehYd21d60h4
	 kPbYvqRmeI6thzMeD1HjlqpnYjo0Pld76F53EMthQGwO/8XBBPaJJOgRdMlgeBF0OFvVW
	 QuTbU2H4Jdmr/e0hOhUKFGPudunKYrrZlfV3wRirbHsEs7pS1Qm+eCWzYrm4jkIp9tPDd
	 ZYjf9ueG5QjpUycEz7O3cbtgogWZhji1D+N8/SCdXk1SnEsSUTPV/SU4k0daF85SsSjoa
	 TG0otlNw2cxvg0z6GCvS94w73nVgxU4yLm2WIaJjQ7AUMRMmS02/NpcPiRBPeo0V7jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0NH1WrPlq7yZpSU2WOQZm/GOD2d8fwIL5CRaboGRWDE=;
	b=uKouhvyAqJykMxgAv7Obx7U2Wdg35nrqrTSMHVQJb6cdup98udMfns6UDMzGyUfN79BV
	 HTPXel7Uvk37WYpmr66BnlYKIBcnIcL1L2ja550QzGzetq7CAxgBMcEl6hArK94HLk890
	 1DrxrFcBnJJoRal91YvkrKQbv4eL4zv7LMOeg0ZUIW/4XqrcyGn7p3xH8Y2jvPA3071Xn
	 ZILa0iVc5H9Rvqj1bQDRbf7k7EB4gf1wgSiprx8l40oJNi9LXSbBX9XuGyKYr61jZCJ6h
	 JuqU3bnfTfqlhcEOkb6IpIq49hVLcfvHi9eGcM750DkHwQ7f2miWjtOAUpBk718HbRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuZZAPHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03B606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CuZZAPHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D540D1F01300;
	Wed, 28 Oct 2026 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203731;
	bh=0NH1WrPlq7yZpSU2WOQZm/GOD2d8fwIL5CRaboGRWDE=;
	h=From:To:Cc:Subject:Date;
	b=CuZZAPHwb2lJNKLUKsXMQMgnArC4CEblhdDl5WtVZo5Z+NVaj14USixZh5sy9pk4b
	 kcO7kZsiu9ccAYx7jxoaM//kaPCpxILs6RqwmRVb4zwDwLutAeMeDVBq8OxvgbdTcC
	 6koACSp/iYVlwvM+G6P7NH5CY1TOCfhb6fMQlvrpglKUku+DYb/lNArU5t5PCZuQD9
	 gDel1ByCLUaoYcicv1BRSSlpHjTxc700jfojMujj9MZRJ+2X8y13G7NWgfmAcxQR7I
	 H9srrtGJR/mhGLcMA8+Yvj2f4qxJJvSzlE2xGiIzsma9SwuZZCI2ZkpvOH1V1b6pTS
	 nL5nx1QWkxyXg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] tcp: avoid double destroy in tcp_abort() of an unaccepted child
Date: Wed, 28 Oct 2026 17:08:47 +0100
Message-ID: <20261028160847.2170959-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

tcp_abort() checks for TCP_CLOSE while only owning the socket lock,
then grabs the BH lock before calling tcp_done_with_error().

For a child still sitting in a listener accept queue (which can be
reached via SOCK_DESTROY or bpf_sock_destroy()), inet_csk_listen_stop()
can run in this window: it only holds the child BH lock, and calls
inet_child_forget(), which disconnects, orphans and destroys the child.

tcp_abort() then calls tcp_done_with_error() -> tcp_done(), which sees
SOCK_DEAD and calls inet_csk_destroy_sock() a second time, leading to
a double sock_put() and a use-after-free.

Recheck TCP_CLOSE after acquiring the BH lock, unless we just closed
a listener ourselves, in which case tcp_done_with_error() must still
run to report the error.

Note that the WARN_ON(sock_owned_by_user(child)) in
inet_csk_listen_stop() can still trigger in this window.

Fixes: bac76cf89816 ("tcp: fix forever orphan socket caused by tcp_abort")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: recheck TCP_CLOSE under the BH lock instead of moving the test, smaller diff]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1f56d8c0c5fe947072eb5ce50217b13fd33ff74d..6a9566f179e02c3a2e3c91f4ffa96a85190c861d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5128,6 +5128,8 @@ void tcp_done(struct sock *sk)
 int tcp_abort(struct sock *sk, int err)
 {
 	int state = inet_sk_state_load(sk);
+	bool listener = false;
+	int ret = 0;
 
 	if (state == TCP_NEW_SYN_RECV) {
 		struct request_sock *req = inet_reqsk(sk);
@@ -5162,21 +5164,31 @@ int tcp_abort(struct sock *sk, int err)
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
 		inet_csk_listen_stop(sk);
+		listener = true;
 	}
 
 	/* Don't race with BH socket closes such as inet_csk_listen_stop. */
 	local_bh_disable();
 	bh_lock_sock(sk);
 
+	/* An unaccepted child might have been closed by
+	 * inet_csk_listen_stop() while we were not holding its BH lock.
+	 */
+	if (!listener && sk->sk_state == TCP_CLOSE) {
+		ret = -ENOENT;
+		goto out;
+	}
+
 	if (tcp_need_reset(sk->sk_state))
 		tcp_send_active_reset(sk, SK_RST_REASON_TCP_STATE);
 	tcp_done_with_error(sk, err);
 
+out:
 	bh_unlock_sock(sk);
 	local_bh_enable();
 	if (!has_current_bpf_ctx())
 		release_sock(sk);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tcp_abort);
 
-- 
2.53.0

