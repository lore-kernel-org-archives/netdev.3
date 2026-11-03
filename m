Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696416;
	b=ZQU8ee1KD5fBHlpNUAyHYB+bY3KEtUcfvcyQRSOlaYLQ+qwdG/sTNx4bIHWURNJjKX/J
	 ySs6Iy7jhpRfjQMmf249umrcG7L26zzAMhxthXFY9HgvUPEk8OsQWf62MQx3cjwDA38VX
	 V0EL4tMNQ/4WUPXAo4SsMyOzGacfEXJnUKJNGJwyf6MhBlapyNLMlHEFyNxfrHcRMDclS
	 o+NFAfsuD5T3Ta4Bn/3oLG2JVrR2IKk0kvet/l/erTeT8wjPSRJ0BWJz7ULNSYRdE+fjz
	 sov3ceD6UkhzoU+sQOXunOdESUrwR3gD97x8Jq/moA68+47YZnz3VLzoInOgVkSWKvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kxOyIYnvoWhwWvAY8qOlWrcUjoUSuzMbDmciaf1jYGg=;
	b=RsSS+nflKIeLdrQvGsMwO8Y60JI2oea+pvbL4i+MLsy5vZ/H/ImUPpWxi/g5iWmANFfm
	 UTpNkqOP8LOyhb3rMeCQaEbANzWwBxI0JBoztXY1PB/+yIA+XOV/x92zlhBlIs9bKLRPZ
	 HBqKGzKiRTzyTRLZsXeJXyfdBGwK83pwM7qBqU7UwiG42uGHdX6YYA/TGeJzFajzVrPpM
	 VBvSeJxbf9pcXfIokhTNUKYjrHoWqzE5DpbTPFUWqSoo4f3zlBo7hy8Cj2qu44SNJnod2
	 fQbLzONS+iZpK+J2uyW0RD0T6oktIFDxi0LDNK45fEVTpkBMhGk60nv02TDE0BVMwMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvhaXuOl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB4606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvhaXuOl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F3D1F00919;
	Tue,  3 Nov 2026 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696415;
	bh=kxOyIYnvoWhwWvAY8qOlWrcUjoUSuzMbDmciaf1jYGg=;
	h=From:To:Cc:Subject:Date;
	b=KvhaXuOlw4yIBHjyUXuph03PS8XtZtRGdrs7OtYr8wHsD+6nFu6T38iibC5on050e
	 xh/WEk9iG4r9NzT1UwQomkHc/w0b3GG/CsPlD/In6EmSMhN49ezN6kSeN+vK4nwv4Q
	 hCVGy4UzhOO7P4wNCgNxttHHMHl75Pu5n5RFSYQjHtYFM73+55hUyZaKUtDDEupzbH
	 +nCcV5CSp7eeF242c6VDONiMBso1vIpojMQL41EUi64zWGVytubxyXiTzFMCeyh/nY
	 IUGf5lja+iLL/4yZRjyS9AFyefpCOLluHgqxKLtR7eDuWUj3M8qcmL8j80cCE+nzuO
	 XByMjDgFFqAsQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
Date: Tue,  3 Nov 2026 10:00:11 +0100
Message-ID: <20261103090011.4128420-1-edumazet@kernel.org>
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

ireq->ipv6_opt is only set by calipso_req_setattr(), when a CALIPSO
NetLabel mapping is configured.

Request socket migration (net.ipv4.tcp_migrate_req=1, or a
BPF_SK_REUSEPORT_SELECT_OR_MIGRATE program) clones the request
socket with inet_reqsk_clone(), so that the old request socket and
its clone share the same ipv6_opt, then reqsk_migrate_reset() clears
the pointer in the old one.

Another cpu holding a reference on the old request socket can still
be using these options, sending a SYNACK from tcp_v6_send_synack()
or creating a child in tcp_v6_syn_recv_sock(), when the clone
is freed. tcp_v6_reqsk_destructor() frees ipv6_opt with a plain
kfree(), leading to a use-after-free.

Both readers already run under RCU, like their IPv4 counterparts.
Use kfree_rcu() in tcp_v6_reqsk_destructor(), as commit e3f33b0a1d89
("ipv4: free inet_opt and ireq_opt after an RCU grace period") did
for ireq_opt.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179369559062.488856.15441115725436277776@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Found by Sashiko while reviewing another TCP fix :/

 net/ipv6/tcp_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d406cd3c8ceabfdbb66f3e1b4f9e9a74754e8d0b..b1dec5d86d633db67a754c70ee1c63290a9acb5a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -607,7 +607,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 
 static void tcp_v6_reqsk_destructor(struct request_sock *req)
 {
-	kfree(inet_rsk(req)->ipv6_opt);
+	kfree_rcu(inet_rsk(req)->ipv6_opt, rcu);
 	consume_skb(inet_rsk(req)->pktopts);
 }
 
-- 
2.53.0

