Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362203;
	b=H7a9z1oJ+U7fiGGnpB3nZyPwtAUI88YexUJ7nT0fVLgoTjA0xyGoQg6Xx8Fi1WgOUj09
	 X/rOWEBDhwBNtYVVQAz7rNUeDJPqQPox9VTWL2I2/aT2civNKtSqjXBsE6lIL/npu4XRp
	 aD7aOz5Ly34BloyEZj7H98cJcl5XZftw42b1ZZdvE/DE5NmuJdk0QBRB2YtMbnVBiyZaU
	 mGJf1iwT+ovxcQH8TS5BV/WDS4/b8byrjzHtbMBd4DCs9V7OFIsmbgsNbMme1epIYnD31
	 jb7W1Ng2ENbYdTCV9avYakRsycqXkcPsaEtgpnwyG4RDOctrbiuGKlEkb7UAcsE8ecA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362203;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uyfW3OCWnUbkZHwTCgLuveiOBF9GzvaBjVb3gQhT8HY=;
	b=xS9tU5TI8mycwCEuMYtS/QzNy/RBeoZ4UsmTcbJL4VvSgkkGRKH9JECZMijv2sPhS5aL
	 Aew9k0oHTwsDYcQiAlxFs7rUDYnV5A9KfydGs+ls7QmCXxoKV0SRXfOSD9WgI8guRe4IB
	 CzprlhWhM1qzdj8XuYdKpiabjXxs2W3LdVOlOFodak9B7QzGi80d1g0NNNUAfQBaTE08T
	 4/LA6KT9AD3wH/vMGK2dSb+YQSwPgdXy0MIOhZSLVQWj89WM7/Zh+pKyKBF9SfwvhJ/b2
	 oIxJVrqLQZ1oiampUz5IChX9/EwxCZw91WzXxPBTAKQ80Su6oyLkBRdIgP5gXAxsmgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgGCIpXm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D2606A331
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgGCIpXm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B205C1F00A1E;
	Fri, 30 Oct 2026 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362202;
	bh=uyfW3OCWnUbkZHwTCgLuveiOBF9GzvaBjVb3gQhT8HY=;
	h=From:To:Cc:Subject:Date;
	b=LgGCIpXm/lhUu9Lca7InZeS70Mrn+2f/7l0BJAyP1jwMVunrYg2fqHdKviRaxBWJv
	 XQ54+8+uQxqe+gWAOUUyjVun5nK1sMXScEGYKevcqqYdyNMLymkbQTgGVrNUYETp6P
	 xSXHXDNQWAv8eAOeTYnquHxyd0QmWBzyYSZFo7nB+FG6y3Mewv3VmxyFsgZUc5NYW4
	 mBOuX+sKz4mJlOXurq04KORJE7nw0+mZf54Ges7REeBSCasLjH8x1cK2XTRrsVpD7N
	 Jc2ypAkR+Bc0NoMrgFm3VipP8lguSRjyXC4AghesnAaHiJHG78w3qHIORUbHteeSXp
	 DTzOtNgUA+MFw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] soreuseport: annotate data-races around reuse->socks[] and num_socks
Date: Fri, 30 Oct 2026 13:09:56 +0100
Message-ID: <20261030120956.3026324-1-edumazet@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

reuseport_select_sock() and reuseport_migrate_sock() read
reuse->num_socks and reuse->socks[] locklessly under RCU, while
writers holding reuseport_lock can change them.

Readers snapshot num_socks once, then index socks[] with it.
Meanwhile, writers can perform several operations, storing into
slots below the reader's stale count:

- __reuseport_detach_sock() moves the last socket into slot i.
- __reuseport_add_sock() then writes the new socket at the
  (now smaller) num_socks index.
- reuseport_stop_listen_sock() calls __reuseport_detach_sock()
  then __reuseport_add_closed_sock(), which writes slot
  max_socks - num_closed_socks - 1. This can be the slot a reader
  still considers part of the listener region when the array is full.
- __reuseport_detach_closed_sock() can then rewrite that slot.

All pointers stored in socks[] remain valid for the RCU grace period,
but without annotations the compiler is allowed to tear or reload
these accesses. For instance, reuseport_select_sock_by_hash() could
reload reuse->socks[i] between the sk_state/sk_incoming_cpu checks
and the return, returning a socket that did not pass them.

Use WRITE_ONCE() for all socks[] stores done while the array is
visible to readers, and for num_socks updates (readers already use
READ_ONCE()). Use READ_ONCE() in the two lockless readers.

Fixes: ef456144da8e ("soreuseport: define reuseport groups")
Link: https://lore.kernel.org/netdev/20260902071900.395567-1-ruanjinjie@huawei.com/
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
These issues were spotted while reviewing Jinjie Ruan's patch converting
the num_socks smp_wmb()/smp_rmb() pair to release/acquire, which can
build on top of this fix.

 net/core/sock_reuseport.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 29948cb44b7d1a8864ff680aaeb2b4582ede5ff4..fccbdd0430b05984e82c19b17b6b723b0a3a03a1 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -124,10 +124,10 @@ static int reuseport_sock_index(struct sock *sk,
 static void __reuseport_add_sock(struct sock *sk,
 				 struct sock_reuseport *reuse)
 {
-	reuse->socks[reuse->num_socks] = sk;
+	WRITE_ONCE(reuse->socks[reuse->num_socks], sk);
 	/* paired with smp_rmb() in reuseport_(select|migrate)_sock() */
 	smp_wmb();
-	reuse->num_socks++;
+	WRITE_ONCE(reuse->num_socks, reuse->num_socks + 1);
 	reuseport_get_incoming_cpu(sk, reuse);
 }
 
@@ -139,8 +139,8 @@ static bool __reuseport_detach_sock(struct sock *sk,
 	if (i == -1)
 		return false;
 
-	reuse->socks[i] = reuse->socks[reuse->num_socks - 1];
-	reuse->num_socks--;
+	WRITE_ONCE(reuse->socks[i], reuse->socks[reuse->num_socks - 1]);
+	WRITE_ONCE(reuse->num_socks, reuse->num_socks - 1);
 	reuseport_put_incoming_cpu(sk, reuse);
 
 	return true;
@@ -149,7 +149,7 @@ static bool __reuseport_detach_sock(struct sock *sk,
 static void __reuseport_add_closed_sock(struct sock *sk,
 					struct sock_reuseport *reuse)
 {
-	reuse->socks[reuse->max_socks - reuse->num_closed_socks - 1] = sk;
+	WRITE_ONCE(reuse->socks[reuse->max_socks - reuse->num_closed_socks - 1], sk);
 	/* paired with READ_ONCE() in inet_csk_bind_conflict() */
 	WRITE_ONCE(reuse->num_closed_socks, reuse->num_closed_socks + 1);
 	reuseport_get_incoming_cpu(sk, reuse);
@@ -163,7 +163,8 @@ static bool __reuseport_detach_closed_sock(struct sock *sk,
 	if (i == -1)
 		return false;
 
-	reuse->socks[i] = reuse->socks[reuse->max_socks - reuse->num_closed_socks];
+	WRITE_ONCE(reuse->socks[i],
+		   reuse->socks[reuse->max_socks - reuse->num_closed_socks]);
 	/* paired with READ_ONCE() in inet_csk_bind_conflict() */
 	WRITE_ONCE(reuse->num_closed_socks, reuse->num_closed_socks - 1);
 	reuseport_put_incoming_cpu(sk, reuse);
@@ -521,7 +522,7 @@ static struct sock *run_bpf_filter(struct sock_reuseport *reuse, u16 socks,
 	if (index >= socks)
 		return NULL;
 
-	return reuse->socks[index];
+	return READ_ONCE(reuse->socks[index]);
 }
 
 static struct sock *reuseport_select_sock_by_hash(struct sock_reuseport *reuse,
@@ -532,7 +533,7 @@ static struct sock *reuseport_select_sock_by_hash(struct sock_reuseport *reuse,
 
 	i = j = reciprocal_scale(hash, num_socks);
 	do {
-		struct sock *sk = reuse->socks[i];
+		struct sock *sk = READ_ONCE(reuse->socks[i]);
 
 		if (sk->sk_state != TCP_ESTABLISHED) {
 			/* Paired with WRITE_ONCE() in __reuseport_(get|put)_incoming_cpu(). */
-- 
2.53.0

