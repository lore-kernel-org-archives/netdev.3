Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330783;
	b=tYgBB1sg1j3lrabs26+aEwJVZmZdLgtz5Gv0HKfZ2XfGkjO8QY1gzBdD3oPLkpV8Aybj
	 fnKMy4wZNLeIBM1w7Wy849Km+VLoasHZ0Yg7rHhpAlGXQxl2jkJSGgW7rOqOyrX9hNn6N
	 MaUmpvPuACmiftfYB96Dra6HIIJHIdb/GnWp2f0jcDPaPG3mZsHgQUYDrcJNE3ET/bqji
	 J83HVcyzN9WdAPiRLiExkZbshVSk2u5VQEIlSHpEOEETz6/IiDTyXl6T1QDf+9yKSRGQD
	 6nUMZ2iekKvh5+uaOnD+X+LTJ+vAo391gJdYwRHrvYoRRXzUqBdNcMNFrRsRIWA8yTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FQPXKr3w+/Ds5uyhexgQpZ3Q50KApvR7JQ4uZtG0Rss=;
	b=bjMwHbkpfgOv4l8U5LW6YRSkgAXrfTBB2xHLszfLbtgWqA8AeDQfHIIe/vfnZHsBULRr
	 RYvnIZfbrw79oBlwnbuO730E/C/hhN9/verrMjrJvCDgyKqm9BAKOnprF7jJW2jiDoLm5
	 969aLihDqu4Jzz4vsbqMyr0Nr4eIQ4w1Fwn17li+laaQvy8CkpAWONKUNZRO4OBwYl4TC
	 SGaPy3ucc473neKrIr8UygDDuizOdWRui3rOuKLcdmkjlFqa/db1FLmekXdVLFPi3nZkp
	 4TVREm4FUgYlmp5uuYN409XfFpaGF8bQ7e9PxEH6AUL2IAwKwry1ULZsj37yMUcK+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=cvziuYvO;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FCD606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8FCD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=cvziuYvO
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-536717a4d83so1833301cf.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793330781; x=1793935581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FQPXKr3w+/Ds5uyhexgQpZ3Q50KApvR7JQ4uZtG0Rss=;
        b=cvziuYvOVzFZocDxF+ucfhtYbfLsWTaXChkz3r6vlmZ6/7GMz4SXolSLq3chMpwqfr
         R6IsQYrNGpb5cjr7F8LnSVgSapPZCK1S0d/WsePhsWkrxpFU0fydNG7qvL1fwmbtwXjd
         pK98kpt7dN6w2n4q4E56rDGZ5yU9HJAcmWl+hjjRSJccZkSOe76GDbWf6G1dPs85y7PD
         Sgp3V1ZemkhjA8hpQQ/lkz4s0ckSgeZZ5TGK2e/BDWi7Q59kjk8rgQr5ryQMURVUJ6o2
         Dyl5/c+w1p955BNE5H+nXA57po6+hzGKd7NhqQ2f8PC6zUTwicswoX0eqb7LbIYJg0Ek
         rRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330781; x=1793935581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQPXKr3w+/Ds5uyhexgQpZ3Q50KApvR7JQ4uZtG0Rss=;
        b=P85abO0xBZtwK0QoaPkRciFzuQdrgbCke6t7dMRyTAcSap5xOlq5pyX8eWAR+X9F4m
         ywRcSIHG8r+HMG+pG9KRQ1hW8jZ7yBJvTEDJyPjX4lHCqsQCQ2JXelQOg2Y8zEoi9FmY
         ESDP2TUcVYUkE6Ee4a10fMYksRX02UIY8Ymhqy0VxHDedFtVNyzpQ9VGA13KdYbIHEu9
         K/5Is1f2ugIHO8T9I5nDS2ypkIIenDwsudXEn1K/8Idae1OJqXY5MQ/bQOgNEZtWqsWV
         ceMtpbPSYV13fg4q4+rCXnLK5uQXd4xUoAZZTenS59f4HeMGcfU2SICNpjlekUeHdJFd
         FX6Q==
X-Forwarded-Encrypted: i=1; AKwUvByzWE2UDJ1U2ezbWZsqFQqD7J3GGpBt8dgReWp9po7UfUQ0BcRxZ0GUx/rhtl3Tg3whavcD1uM=@vger.kernel.org
X-Gm-Message-State: AFq9FYId3kARy9LiVrHHi4+L3D/Z70ygMP1kMRReo1mlg0Xgpivnb/XO
	b4n7RBzOAXNtrq2TUBndC1+twBTjCKE2ZnWrBTQPBj9kqdS2fByyuJiiC3u8+jeTk0RP6taqTma
	VAKv1kQ==
X-Gm-Gg: AYBFou0UNWbwTz53LXculMiQTQuWlhn5mpk2MavlbOhIoqdXs7WCwBvpuJWC/5tXUa4
	xwsDJQihJPcxIC6DoRnCwKvWwyYktF+XDnBnjXEtT1OAhkQ2F7suv+WiwIDGLEZZslnHJhIk+iI
	vgJa1OqX15l1Lgxr1ulxhLg9dhnpgmFTPjH+3j6osCbJECZ+HhVX9mpvXJPwHHUV/vKLolRLnWX
	Ej2E+vjg/8FEbHJAys2P79MAdoThG93qdLxy7L7aoQVl6zN2gPjdJy7Z4NNbXG3aoL52RyigrEv
	b98QlxNr04NCPlNg8Z14xn1WuFRqkc5uh1oRDC7a5VQ/0b6yczTj2k2tgKO80TDN7tx6cJAVui9
	EUyDe39tFwR0b9l+WEhGAFFB3Wee6IG9AR6+0+18jbBgnpBYxulTY4QCzB3SQwQwV4lt52mYI+f
	MA9ez2dLNTAtdfn+s1BJNQaeMVLqwavdXuVXdpt+HQ08Yu2kmD66NxJkeza1yU8mY/HwLAZYEud
	CDvh92EoU5ft8Mo6USz+MBpJN9++X84b8VLMdX38vR3E2JpncWoANZ8uxyNDU+BJdwKEx79eHIB
	pz33hVtK6xgStM4ErQ5qFW7t6Q1qaNp3p3JoJWkmiFA5wUUSCQeZ
X-Received: by 2002:ac8:6f12:0:b0:51c:fc4:a144 with SMTP id d75a77b69052e-542b405957emr16806811cf.4.1793330780610;
        Thu, 29 Oct 2026 20:26:20 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca804dc9fsm4001476d6.24.2026.10.29.20.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:26:20 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	jchapman@katalix.com,
	tparkin@katalix.com,
	gnault@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] l2tp: only return sessions of the given tunnel in l2tp_session_get()
Date: Thu, 29 Oct 2026 23:26:17 -0400
Message-ID: <20261030032617.4065353-1-hengyul@cs.unc.edu>
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

Commit 5f77c18ea556 ("l2tp: use IDR for all session lookups") made
pppol2tp_connect() and the netlink session commands find sessions with
l2tp_session_get(), passing the socket of the tunnel they name.

L2TPv3 session IDs are unique per network namespace, except that
sessions carried over UDP are only unique per UDP socket, the socket of
their tunnel. However, l2tp_v3_session_get() only checks the socket when
another session has the same session ID. Otherwise it returns the
session, whichever tunnel it belongs to. As of now, a session command
that names the wrong tunnel acts on a session of another tunnel, and a
PPPoL2TP socket for a second L2TPv3 tunnel fails with EEXIST, because it
finds session 0 of the first tunnel.

The issue can be reproduced with:

    ip l2tp add tunnel tunnel_id 3 peer_tunnel_id 3 encap udp \
        local 127.0.0.1 remote 127.0.0.1 udp_sport 5003 udp_dport 6003
    ip l2tp add tunnel tunnel_id 4 peer_tunnel_id 4 encap udp \
        local 127.0.0.1 remote 127.0.0.1 udp_sport 5004 udp_dport 6004
    ip l2tp add session tunnel_id 3 session_id 7 peer_session_id 7
    ip l2tp del session tunnel_id 4 session_id 7
    ip l2tp show session

Before that commit, the delete fails with "No such device", and session
7 of tunnel 3 is still listed. After that commit, the delete succeeds,
and session 7 of tunnel 3 is gone.

This patch will make l2tp_session_get() return NULL when the L2TPv3
session it finds does not belong to the given socket. The receive path
calls l2tp_v3_session_get() directly and is not changed.

Fixes: 5f77c18ea556 ("l2tp: use IDR for all session lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Compare the session's tunnel socket with sk instead of the tunnel ID
  (Guillaume).
- Describe session IDs as unique per netns, and per UDP socket for UDP
  encap, in the commit message.
- v1: https://lore.kernel.org/netdev/20261025145831.2133617-1-hengyul@cs.unc.edu/

Tested with the commands above, the same session ID in two UDP tunnels
(still allowed) and in two IP tunnels (still refused), and two PPPoL2TP
tunnel sockets.

 net/l2tp/l2tp_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 7e042a3e648c..0cd3e38bf662 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -315,10 +315,19 @@ EXPORT_SYMBOL_GPL(l2tp_v2_session_get);
 struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
 				      u32 tunnel_id, u32 session_id)
 {
+	struct l2tp_session *session;
+
 	if (pver == L2TP_HDR_VER_2)
 		return l2tp_v2_session_get(net, tunnel_id, session_id);
-	else
-		return l2tp_v3_session_get(net, sk, session_id);
+
+	/* l2tp_v3_session_get() doesn't check sk if the ID hasn't collided */
+	session = l2tp_v3_session_get(net, sk, session_id);
+	if (session && session->tunnel->sock != sk) {
+		l2tp_session_put(session);
+		return NULL;
+	}
+
+	return session;
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get);
 

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.53.0

