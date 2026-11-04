Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797673;
	b=SsldoPD+LXhWzprmjWP9AHC07LxbnmNPGPv/u1/onse0J14Ouwml+hohs33zF8uSwNDX
	 SXIgCsovv6f326/NU/AICcYFw08l+62dIt6wwe+tpBxYJHpkh3ATkgIotsHoT9d4DE+1q
	 r6IKtaKi9VRZAyOe4rbI53TjVst9GhJgx6F7P5GCE8MBdg0F1Y1+4WEoWO+R91q/zbGLQ
	 yB7FG8FFEIFLIkbezAXxMdHkrKFqYEI2ZaPmdz9mRA3CtKpdzU6JR18zUknx2L/vaHPBn
	 qBLa/0sJ7mMmFMV37ZCZABGwVnmgUmJ6t78jpZaQ6uzEugp/tEAfPkX+9Ryu1cKYB7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=syN+KxszM/EDpPfFgs02hxOZ/ZWREys7/rnS23nuAlE=;
	b=uX54wUEVdBN+OhqxcT8whkb8C2CEpGz4xrXknjAeBoOqYZRQlLjbqsCeLo5ElusVraXM
	 g68XsZDpUCIcFYMzf4CpPxZgccsCsebM8bwePOQOjBPcn2gkHdkbGzP3IbN5BjEP2NPhy
	 PSwds+SpGnYn8IC8lYy9wZ0VF5zlMBOk79sMp0FXH8cnSDmH8iQXUhIHhP3Rg3XctNSuf
	 +ovLk3zvyxw5UvssOilIeVlDHDT7w6lDOrdbzbVDj8Sp4Dt8sW/LDstiJsuvSrYl3/NMb
	 m0DV2R3/YQ4P+Jdf1A2hETrKVW5+gImpOPf1MMovSMhKbd5YOK5h8LcgFBdX0GGs6oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJnhdI2I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE9606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJnhdI2I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F8F1F000C1;
	Wed,  4 Nov 2026 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797673;
	bh=syN+KxszM/EDpPfFgs02hxOZ/ZWREys7/rnS23nuAlE=;
	h=From:To:Cc:Subject:Date;
	b=SJnhdI2IfqcGzRljkh5nil+pwIzBkghlSS3vwg0+M61NYsNa505ZchC5Y0jP9lc7h
	 KqdIBXgb+3miOgN8yU4OSiTY6pl15nvTGuUa1LxcFFobd4z7snZih22mhMy9iOk9Xs
	 JtSAJlr95Wra379/TtPf4Wo6zQtIj3cXcsIXqIsgr2YSFIXKmqyShEAK29iFmwIUho
	 2INLC8treLP6duC0bCpfO7pmQT4XRMPv+h1ACOS8fpOvJXUXeWfAYr855riDK4acOH
	 Wr7DLARoRNAHtQd7u/cJG14zAFyhh7JA5ak3JSyyle89OnkeqAsq60PRtnnORf4seB
	 RBx8fJjZJbnRA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] mptcp: reject DATA_ACKs against a reversed send interval
Date: Wed,  4 Nov 2026 14:07:47 +0100
Message-ID: <20261104130747.1045741-1-edumazet@kernel.org>
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

ack_update_msk() samples snd_nxt before taking the data lock, but reads
snd_una after taking it. Concurrent transmission and ACK processing can
therefore leave the sampled upper bound behind snd_una. Active-open
completion also exposes a reversed interval when it initializes snd_una
to IDSN + 1 while the socket-owned state synchronization is deferred.

A peer-supplied 64-bit Data ACK half a sequence space away can pass both
wraparound comparisons against such an interval. The resulting snd_una
can make __mptcp_retrans() inflate a fragment's already_sent field. Later
ACKs can then underflow data_len and cause out-of-bounds page fragments
to be passed to TCP.

Read snd_nxt after acquiring the data lock and reject reversed intervals
before checking the received Data ACK. This keeps the interval shorter
than half the sequence space, so the existing upper-bound check cannot
accept an advance beyond snd_nxt. Preserve the existing handling of old
ACKs and keep the transmit fields under their existing socket locking.

Fixes: 7439d687b79c ("mptcp: avoid a few atomic ops in the rx path")
Fixes: 3f83d8a77eee ("mptcp: fix more tx path fields initialization")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/mptcp/options.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 64aa7a516a23..02e785a14b8a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1122,9 +1122,9 @@ static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
 {
-	u64 new_wnd_end, new_snd_una, snd_nxt = READ_ONCE(msk->snd_nxt);
+	u64 new_wnd_end, new_snd_una, old_snd_una;
 	struct sock *sk = (struct sock *)msk;
-	u64 old_snd_una;
+	u64 snd_nxt;
 
 	mptcp_data_lock(sk);
 
@@ -1133,10 +1133,14 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	 * more dangerous than missing an ack
 	 */
 	old_snd_una = msk->snd_una;
+	snd_nxt = READ_ONCE(msk->snd_nxt);
 	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 
-	/* ACK for data not even sent yet? Ignore.*/
-	if (unlikely(after64(new_snd_una, snd_nxt)))
+	/* The active-open state sync can defer the snd_nxt update. Do not
+	 * accept an ACK against a reversed interval, or beyond snd_nxt.
+	 */
+	if (unlikely(before64(snd_nxt, old_snd_una) ||
+		     after64(new_snd_una, snd_nxt)))
 		new_snd_una = old_snd_una;
 
 	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
-- 
2.53.0

