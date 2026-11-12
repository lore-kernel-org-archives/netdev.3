Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504117;
	b=L/SuO+UHuyWmTdZZXgTjR9+NerrYLVoc/cJPK6lPjKHVb0kOpctGLHqF2vTNozMipK87
	 F32x4/HbMNb5aNza6DmJQMoE/CxPE8DoT9eh7xSzCimX9J3vuQIclr5w0qmK/9ielkIND
	 mE7Jy1EEvVKRxT3+/MwI1WG3CA/sLQ33s5t1QsA06kLB7TiWD9DGaYEzAi4/Iji9c31Ka
	 MM0WGmq/LqcUCQ01Pycgj7NTXwfzLryhKrT4QmOT36AbYSqNd9LyK5Iuc8EXuKCZmYq01
	 B+JbkvtIzaTaN1gYweo6ifQM6U5g3fWj55GdiFpuUANSg9iCoEDtNtyvuRJVjzaocWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RMTzFB73wRCkjilaTwDIf3wsPQNxn4uql3pqUcPvaJk=;
	b=Av8Jg1x7owHMpYOnxFKt1IzHHncwiQxeoA/vMoOC9mEoJJA9sSumZJb29HqrU/kWqavM
	 hDQ6RAVngBAWgYDsej7w0G5XftRpdzTN5IuO/J+jNcWQBcLBNZ6Psw4tDgjja3xC6v4p8
	 8FRpchJtzy0F6xeuZtn6GjRdhL93mgrAkFdgLiLiN58VwEn7AQKo9xWOOlfCWTwRXCYHT
	 gDnslosiyYgeItq6qh3LgM9UD9DulPrQooVRcuoQT32YG1Bnb32edWTs8lsISKzLkKFrH
	 DdbuTViSUM4OFW0mGC/lPrcBNFo0tGLx5xEKWafN1/6DHBvXgdnXSzjk2WleErUBWNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=theori.io;
	spf=pass smtp.mailfrom=theori.io;
	dkim=pass header.d=theori.io header.i=@theori.io header.a=rsa-sha256 header.s=google2026 header.b=G0Wekqxe;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7B606A886
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B7B606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theori.io header.i=@theori.io header.a=rsa-sha256 header.s=google2026 header.b=G0Wekqxe
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e09aa5264so2625040f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google2026; t=1794504115; x=1795108915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RMTzFB73wRCkjilaTwDIf3wsPQNxn4uql3pqUcPvaJk=;
        b=G0WekqxezQih4/CxNOTg3eZ6gRN85MDuSKCrziTFZVBB4Gi46ftZ+GSchNZbg769DJ
         XAw2wEqI0QCirJLmOcb6ZT5uKkTN/npSe782oZnrjMMDW1OVHLoyEQO0ltIzmBQYy2vc
         h/r2AgLlpNsU+OzmiDw3Y+sZdkmUC5UaZT5EEDwIFsgaAJCFpiC7f5EDR1p0zD9A4yQ7
         RnJBlGFRwbiZhyjokWLUAyBzEKW8PS1cvxzKi1d+iNdcQllq3mXkJLazkoT6Xs9K2+f/
         BSLKRKgHyg/YvjgZd+KSTlBdJTda7VwS506j2t1qsDLzYJtSxjzJfgFRrixwl+otbHWi
         FaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504115; x=1795108915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RMTzFB73wRCkjilaTwDIf3wsPQNxn4uql3pqUcPvaJk=;
        b=zWmJmvgrf0oCOkkzncrcizJDF2TmBQdGswVrxR7GpE4NMC4o3Piu71c1nPEOcneYRe
         cZPHR+qZb04jLuu7RPcGRGzsAanZk8MzzloKSoYjerZQefqJfkbfhCH7oJwhkr1WQM4/
         6XsqpAEicqBhwkPKJV45t+e7haKIPeb5GUOx1lSlL5WFgMQmmIA5y7s1aBBYhqMsirPI
         G2gAXitx0BzxbTHiSdkfML8+nGV6M6S27y1mlnek4+I0TO0iEhkfE6nOKQmC85TQkhhX
         al6VZgl4CSdKpl+yZqXSlVjsXdjeVNB+PoMN7ynpNQsoKAN28nDMcwXQYG/uhUlVIqi+
         6Jkw==
X-Forwarded-Encrypted: i=1; AL+hErGdwTaQlTSuEAUyX45emBLmh57pbowOfQBeoNXVu3m+GaeZnc1mdRqwapJn7LlNmelKjPX1fp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SeL0qK6gu0VU34JinTYRS4zL19vft29nRGy6TC5zIyl6eXyMX
	R5QjBFboE8UbMyG6CbVXVqvpU74YVE3/tLOMV9SAuGJnq/+UTMznSJm7BxQPZA5wXTI=
X-Gm-Gg: AYBFou0qWMlYKL5YkuaRAP29QrwIp/KkFijQYZAXq7kZBnyJHHwcM0HSiw2L446ABZN
	bB5eJZwu5lWD5DjGmHDCqr+ei7ookG2CGVBMrqyloaBvE4vFi3kA/GO58dkyPLCqeuxQuNuyFcj
	uRuOkOPDuHAjPMVETFjEfrULG2eb4PA1RG9DsrhGXL6Wo+O/z0Ytr3/mYA47w64YTCUpsaxomPB
	fh5morhl7o18tmBhWHD+77ElCmw0iY4oVS5SlwDGMuqnoZUuBOHUKprICcZb8FIKS0dd+rH5HSx
	9++ovmAvwEsMILuiaUe6LaDPvthU10IAq6OpP6zPy5cL2ujgQY4RgrWh+3Bv5es5q3fkF0d5UYp
	dHxoTTT5+KmZcd1HnwhIW2he5jJa8ZagpC4b5c7YCgwU+0V5XXDuouSLXmx2Mnrep37+wWyqu3l
	efi2iMw+B8Hfoc+9pPVZgLuiJ1zlSu9LEdWXOmXQxexSIOPchbGnOUqQrh8AQNJzghgWXRzAtnr
	YmSQ6hxCSRQKoCsMVBAFrSzb7O3xbssipXI+OPl/idGu+hJyp5HfQ5N7KSjV8tb/cn5wGo21wDu
	O3wPCdkDfL1Rt4jM2eCTLQ/VDZgdOgaN0iNDso8otbB3NLGV/2blCGlsy+mDPiJmqg9IuJLs8gj
	8p+KDgg==
X-Received: by 2002:adf:e19e:0:b0:487:b50:101c with SMTP id ffacd0b85a97d-49c6fc9dc98mr124584f8f.5.1794504114498;
        Thu, 12 Nov 2026 09:21:54 -0800 (PST)
Received: from localhost.localdomain (bbcs-110-227.pub.wingo.ch. [144.2.110.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7390fe82sm1909f8f.17.2026.11.12.09.21.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 09:21:53 -0800 (PST)
From: Yves Bieri <yves.bieri@theori.io>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yves Bieri <yves.bieri@theori.io>,
	stable@vger.kernel.org
Subject: [PATCH net v2] sctp: do not free a new asoc peeled off while sendmsg slept
Date: Thu, 12 Nov 2026 18:21:49 +0100
Message-ID: <20261112172149.27355-1-yves.bieri@theori.io>
X-Mailer: git-send-email 2.54.0
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

When sctp_sendmsg() creates a new association and sending on it fails
with anything but -ESRCH, it frees the association. The send can
sleep in sctp_wait_for_sndbuf(), which releases the socket lock, and
meanwhile another thread can peel the new association off to a new
socket. The wait then returns -EPIPE, and sctp_sendmsg() frees an
association that now belongs to the peeled-off socket, without holding
that socket's lock.

If the peeled-off socket frees the association first, e.g. on close(),
sctp_sendmsg() frees it a second time. Otherwise a syscall running
concurrently on the peeled-off socket can use it after sctp_sendmsg()
freed it. Both are reachable by an unprivileged user. The double free
on net with KASAN:

  BUG: KASAN: double-free in sctp_tsnmap_free+0x5c/0x80
   sctp_association_free+0x1eb/0x750
   sctp_sendmsg+0x15ff/0x2020
  Freed by task 836:
   sctp_association_free+0x1eb/0x750
   sctp_primitive_ABORT+0x85/0xe0
   sctp_close+0x22a/0x8d0

Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
sleeping on it") fixed this double free by denying the peeloff.
Commit cea0cc80a677 ("sctp: use the right sk after waking up from
wait_buf sleep") replaced that check, and commit a0ff660058b8 ("sctp:
return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
reverted it to return -EPIPE, without restoring the check.

Fix this by holding a reference on the new association while sending
on it, and by freeing it on error only if this socket still owns it.
asoc->base.sk only changes in sctp_sock_migrate(), which runs with this
socket locked, so the ownership check is stable. The reference keeps
the check safe if the new owner frees the association meanwhile.
Userspace still gets -EPIPE, and the association stays with the socket
it was peeled off to.

This was found by Xint Code, an AI code review agent, and reproduced as
an unprivileged user on net with KASAN (trace above), without modifying
the kernel or using error injection. With this patch the sender gets
-EPIPE and the association keeps working on the peeled-off socket.
Without a peeloff, a failed send that created the association (EAGAIN,
EINTR) still frees it, and a peer ABORT while the sender sleeps still
frees it exactly once. The SCTP selftest sctp_vrf.sh passes. The
reproducer is available on request.

Fixes: a0ff660058b8 ("sctp: return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
Cc: stable@vger.kernel.org
Signed-off-by: Yves Bieri <yves.bieri@theori.io>
---
v2:
  - move the hold to right after the association is created (Xin Long)
v1: https://lore.kernel.org/netdev/20261110224233.82977-1-yves.bieri@theori.io/

Tested on net at b71c101bbb98.

The fix and this message were drafted with Claude, and reviewed and
tested by me.

 net/sctp/socket.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index b5a57f6..6ed184e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2063,6 +2063,11 @@ static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
 
 			asoc = transport->asoc;
 			new = true;
+			/* sctp_sendmsg_to_asoc() may release the socket lock,
+			 * and the new asoc can be peeled off meanwhile.  Hold
+			 * it, and free it on error only if sk still owns it.
+			 */
+			sctp_association_hold(asoc);
 		}
 
 		if (!sctp_style(sk, TCP) && !(sflags & SCTP_ADDR_OVER))
@@ -2084,8 +2089,11 @@ static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
 
 	/* Send msg to the asoc */
 	err = sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo);
-	if (err < 0 && err != -ESRCH && new)
-		sctp_association_free(asoc);
+	if (new) {
+		if (err < 0 && err != -ESRCH && asoc->base.sk == sk)
+			sctp_association_free(asoc);
+		sctp_association_put(asoc);
+	}
 
 out_unlock:
 	release_sock(sk);

base-commit: b71c101bbb9814d163c00234d43c41f0a17907d4
-- 
2.43.0
