Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7C42E407
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446691; cv=none; b=mmn2hdTbMDipArZSkprNCrhEwfdA+HtIzmbOHlrN/lUxJ6XGVBs9kHykLNwXFyZeR8kOfA+Lz/mWv+aaw3qJQC+bbWGXtDqvV/COcKYOn5ImHyFAtQlWk7BuNKeMSLxPe9GoJz6Dkxu9PK1hAWGitZ9jMh+0E5L4OuIgDTe0bSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446691; c=relaxed/simple;
	bh=oKvcI3k0APoKwfM6GnwrO6L3yJ8TLN247dkCu4dhUUg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dSkl0ymm1Rrs3Fkdy6dMEr+gMA0GEwIvlMIJysLpOgyKvahFK1BwV3KY3a6wq8w9vkAcsEh4Kbf8YLOSRKzi+rpgyxl9IahG1r6HbmduN2bQYPTOUmVU54GZg0D7H31NyS8MEW2GyZ7uVUJAsBLO4QrPu5IszhhhyBAn8oWCtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DoqWOulh; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoqWOulh"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91064f6e75bso126359766d6.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789446656; x=1790051456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bU5E2eJm42YWZAB7cFajL6XZSMc0iwPdLuvluZKu/FY=;
        b=DoqWOulhaZqyd4rYVAYsKxJZcyETfYspb9Zcv/Djztnwr36njOSd/s8RaNIM6HsTFH
         67kSC5dydzBoy+Q+qQ6Sr9a3iY//8yqROsXOqnQMbyd+AkO8FGrxIYITwjLtXS25WMIV
         6zi/sA3PrA6zP5FqN7xn+1r6TqZpjboruxmsRP1XL2viw717UfBGmlMIW6rn8BvvUaji
         CbPEa2f6VlUqenImjWr+cUEujt4j20x9Gt2GeYo534IJTJcCSmKLuFEF1MSRhzOXqdQt
         urSABS0yjZ/r5Pw3sGGhbSlHjB/3jcl/dB65jjbjW2LjzYsdr2gkSMGEN4h2RxCzFjLp
         qV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789446656; x=1790051456;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bU5E2eJm42YWZAB7cFajL6XZSMc0iwPdLuvluZKu/FY=;
        b=QzMnkTz7cB4DaWw6Bg0y+fWdxCZi8JpnhHiJzBfygrDbrwYCbDDsmDmrlqomEj2cHd
         pGYV2USC1F+jAvplXS3mTLWkV4hviHzQ3VvuDzOq5HcrXgUMprOU7Ic8xokrcmrHU0hb
         cR+YxOPdC7e4bY5OOXzHOYn8dRgMLWMBUfdIk7vPbH4drd6QarNdIIKfs3IPcibhwHW8
         H60wpAVXifZunm9cMQrAZp70y8j+5euYmytaIV1uSckUJcAx8qfotroGB3B/r7uXAJ9D
         +XbUn7M/qRsWf5D6hrLm78dRddmUU0rWHuGunsu/5TtpDHfqB7lwpcb5qw/SP/avKK3x
         Bg7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzR26nczqbpMadXSx7E0BLhyjStbHwUEhzaxGnaV7+6koipZ3cwKSXi4IvSYP/83E21399QeEc=@vger.kernel.org
X-Gm-Message-State: AFuF++kv02vdx0qWatfzLSW+XufhD29XZmas0hNknsqYrF/8K8FzyHhZ
	bqoK0dRDdCtvAxiaX3ocFFSo7VawyKiFgY7OcuIAYMIANorS1nbnt1VOEuxu17EilyI0tnscjON
	wWraW8REx1olfHA==
X-Received: from qvqa7.prod.google.com ([2002:ad4:41c7:0:b0:910:6a71:990d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:300e:b0:912:ca4:a542 with SMTP id 6a1803df08f44-9122e549f98mr93366006d6.24.1789446656132;
 Mon, 14 Sep 2026 21:30:56 -0700 (PDT)
Date: Tue, 15 Sep 2026 04:30:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915043055.3441600-1-edumazet@google.com>
Subject: [PATCH net] net: lock the socket in sock_gettstamp()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jungwoo Lee <jwlee2217@gmail.com>, 
	Wongi Lee <qw3rtyp0@gmail.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_flags must only be changed while holding the socket lock,
because sock_set_flag() and sock_reset_flag() use non atomic
operations (__set_bit() and __clear_bit()).

sock_gettstamp() is one of the last places where a bit of sk->sk_flags
is changed from a syscall without owning the socket lock, through
sock_enable_timestamp(sk, SOCK_TIMESTAMP).

sk_set_memalloc() and sk_clear_memalloc() also change sk->sk_flags
without the socket lock, but their callers (nbd, iscsi_tcp, nvme-tcp,
sunrpc, wireguard) need a careful audit, this will be addressed in a
separate patch.

Jungwoo Lee and Wongi Lee reported an UDP socket use-after-free
caused by this bug: a SIOCGSTAMPNS_NEW ioctl racing with bind()
can cancel the SOCK_RCU_FREE bit that udp_lib_get_port() just set,
because both threads perform a read-modify-write on the same word.

  CPU 0 (bind)                        CPU 1 (SIOCGSTAMPNS_NEW)
  --------------------------------    ----------------------------
  read sk_flags = F                   read sk_flags = F
  compute F | BIT(SOCK_RCU_FREE)      compute F | BIT(SOCK_TIMESTAMP)
  store F | BIT(SOCK_RCU_FREE)
  sk_add_node_rcu(sk, ...)
                                      store F | BIT(SOCK_TIMESTAMP)

After the lost update, SOCK_RCU_FREE is clear while the socket is
visible to lockless UDP receive lookups. sk_destruct() then frees
the socket immediately instead of waiting for a RCU grace period,
while the receive path still holds a reference-less pointer to it:

 BUG: KASAN: slab-use-after-free in ipv4_pktinfo_prepare+0x30/0x410
 Read of size 8 at addr ffff888008806610 by task exploit/207
 CPU: 0 UID: 1000 PID: 207 Comm: exploit Not tainted 6.12.95+ #1
  ipv4_pktinfo_prepare+0x30/0x410
  udp_queue_rcv_one_skb+0x51c/0x1180
  udp_unicast_rcv_skb+0x109/0x350
  ip_protocol_deliver_rcu+0x14b/0x310
  ip_local_deliver_finish+0x29d/0x390
  ip_local_deliver+0x24d/0x2a0

Only grab the socket lock when SOCK_TIMESTAMP has to be set,
to keep the common case lockless.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Jungwoo Lee <jwlee2217@gmail.com>
Reported-by: Wongi Lee <qw3rtyp0@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index fa60b7494c58691d3f5d34a62d2176c87086424a..d5e302e21e85b0637a3232f5a3e9dace9978e8ee 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3911,7 +3911,14 @@ int sock_gettstamp(struct socket *sock, void __user *userstamp,
 	struct sock *sk = sock->sk;
 	struct timespec64 ts;
 
-	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+	/* sk->sk_flags must only be changed under the socket lock,
+	 * because sock_set_flag() uses non atomic operations.
+	 */
+	if (!sock_flag(sk, SOCK_TIMESTAMP)) {
+		lock_sock(sk);
+		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+		release_sock(sk);
+	}
 	ts = ktime_to_timespec64(sock_read_timestamp(sk));
 	if (ts.tv_sec == -1)
 		return -ENOENT;
-- 
2.55.0.1032.g73a4cd73de-goog

