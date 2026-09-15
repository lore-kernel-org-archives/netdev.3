Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F84C77AF
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513911; cv=none; b=XWQKiq1BoplZlfippzIv/hqgYjUPYtB9czwPAQbGTGDBNTadW3H+7WwtUuNArLYZvwCb9dhh4ZVAju0weelvjiJAUGtGx4BNH9mdlQGHmSlehEtreqZUGN3M6asjKIUtSzdezN1X6nOx9dR5LTOFLw98syw+4s2Hii+ZFdLDCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513911; c=relaxed/simple;
	bh=xzj5JrRuqTHk4w5P83m1fBmEhky7Q1Rt52JCaIt8jAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQ9ZNmU9f20aKRryJxNfdIkC79eu0jJi8iojf3+RhqmSUs0ok5XjVUs9qppf94gW5H+RkgrI6ddOqfP1kJN70zmdZ4wfsYiDSKA43e0mvjFjY5eqPnNcFh6M1JwyTE4YBEAp0e2r7VIqcs7on0b/KQcKyjkDTgRj6ZqO6GacJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D40axnn7; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D40axnn7"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae7089c1so184398eaf.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789513909; x=1790118709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5Dyg4FJfrbU72mUF+76bVoG1ydsA+8WdETFK/WQ+0Q=;
        b=D40axnn7QYqyz0kopw4Uevs/zqqRWx3ZCOWebqGJbHiVauQm8wp2zvP7fXsJNHKSyy
         HWWtoUparUZg6qJ6TFIqNDdDMae8/Ko8B+m/2W7EMjZ3BX+l+3I/ApOi6UG36VlTGOY7
         Oy6M8S1fDyqWHahpWChjy7+2BZxvmTL4/iMQ+dWmqW1vy6v2NZuzLSDSZey2no8AlxtU
         gQGPnqpLE5fgXTvgUVxY7kfitVaEcoYsSRBaSvQ/lsOW8IxuzeCVuc9sedZUZz3SqsK3
         j/QsYJ4f/Xap2VTdrGRkqjlib67GfOWFfm5qvlC1pR+9qkEC3jHszKKtwV6oXAstbeGo
         Gmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513909; x=1790118709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5Dyg4FJfrbU72mUF+76bVoG1ydsA+8WdETFK/WQ+0Q=;
        b=ZMopDS9ogfE/lvHwBq4EWa8YPQWLFBxqNCCUCmDtutAdQVX1gzgDz4kZT2TIFcCzgT
         oan8Nxfd2PxsOBwd415zXVAL5dIUSNGxPzq5n8C9Z/pjkH0UNHKhIvu3ivc9EvcgEER9
         DeBAPRmDePaPoJt31Ygq6z7zlM1fKi7Lczq9v8BrmzhITq5HU3F1Hf83iJ/dgAhVn/2o
         8RXrpWNtzRKGdsJvnHZe6QxVjIrJcM9b4fPGg9wDxRVI/7kr1VRQxKbFXXc4Tw9boqhS
         R4Jhg9RhNUpcxoZ2jPfgj9x0hrROftHF98waAjhBVeaSEjBqB3suhPJVQxFxudBf+I1g
         WvBg==
X-Forwarded-Encrypted: i=1; AKwUvBzyN0z00mDYelcs6UjqwjJKcYcaHowNWNxSCuVS5aVH6mO7ViiV4NXhg/r/sePiVxIUlreJCNU=@vger.kernel.org
X-Gm-Message-State: AFuF++nG4xcorbUQgXJX9076wj9QrO3v+P0fyGtsRCpEWFlZ4VyCdUV2
	1IyvyvPp98BGnnzRfpyx4oAeCKiPV3ZsaxM3YXfeoE9A2Q1YwdSR3Ort
X-Gm-Gg: AYBFou1ftXtA0biMWVzeqZZXvXa9V9yq4rPdhsaKJD9gDNGLurxNFQsgN8Xr00szKh6
	HbsCfy6MeXsS+QX5kdviSDZ3msNujpQTdv+Uqk9cNJcN0Kndh26LmqmF46DbQweq6SlL2xiK4lR
	/MqFNuPq7+6IFSbyBlsHxR5tY9z0DSJAPfTzxHXbVvYwkFw87S0GQcMOA5Kx7YGNMelFjc+9DOw
	gy8CtY7EtPweLbQWU1ukMGTuiQFWqqqiMlZqTyxA5c7Dg7aXCVJ0klEJYXweFgn29zB8pHXp6kY
	7DYIyQe464SxlTNPvUmXoUdQDgMnPG6un97s7fkSrV3/ZolaafshlA5VVD6X6cm/6k1Jfzbe08w
	4vyiPm0QicaTjCUVPavGYVqYQgtc6jEYxGsdOC1AMndtBK3Dwt1tjWxREfKzCs8hEn0wPz9eft2
	COf/debUabcyuRnahMeL1mmEC15odAo8z9YAtlxPsBeig8H/mwJTUydQZdYA/lQ/55
X-Received: by 2002:a4a:ee06:0:b0:6b3:f762:4d95 with SMTP id 006d021491bc7-6c7d12d21a8mr637679eaf.7.1789513909152;
        Tue, 15 Sep 2026 16:11:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48427b2b702sm1361980fac.1.2026.09.15.16.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:11:48 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 15 Sep 2026 16:11:37 -0700
Subject: [PATCH net v2 1/2] net: psp: avoid conflicts with skb->decrypted
 and sk_validate_xmit_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-psp-ktls-fix-v2-1-0eedc3b148ec@gmail.com>
References: <20260915-psp-ktls-fix-v2-0-0eedc3b148ec@gmail.com>
In-Reply-To: <20260915-psp-ktls-fix-v2-0-0eedc3b148ec@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13.0

PSP conflicts with TLS ULP in its usage of both skb->decrypted and
sk->sk_validate_xmit_skb().

Make PSP mutually exclusive with TLS ULP, the only other user of either
of these. As other users of skb->decrypted come along, they can be added
to sk_has_decrypt_user(). It would make sense to also assert that
sk->sk_validate_xmit_skb() is also NULL in both of these setup paths for
similar future proofing, but the PSP listener/sk_clone() path is still
broken and it could be seen as a regression to not allow rx assoc to run
on a child of a listener socket with PSP tx assoc state.

Include all TCP ULPs in the sk_has_decrypt_user() check, even though TLS
is the only one that conflicts with PSP via the decrypted bit. This is
intentional because PSP was not designed to be used with ULPs. It is
best to close off surface area that may make bugs reachable, until
someone wishes to design and test an actual user of PSP with ULPs.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 7 +++++++
 net/ipv4/tcp_ulp.c | 4 ++++
 net/psp/psp_sock.c | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac2..60ea55dc1885 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2312,6 +2312,8 @@ static inline void sk_gso_disable(struct sock *sk)
 	sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
 }
 
+bool sk_has_decrypt_user(const struct sock *sk);
+
 static inline int skb_do_copy_data_nocache(struct sock *sk, struct sk_buff *skb,
 					   struct iov_iter *from, char *to,
 					   int copy, int offset)
diff --git a/net/core/sock.c b/net/core/sock.c
index fa60b7494c58..9489d9c47949 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -142,6 +142,7 @@
 
 #include <trace/events/sock.h>
 
+#include <net/psp.h>
 #include <net/tcp.h>
 #include <net/busy_poll.h>
 #include <net/phonet/phonet.h>
@@ -2670,6 +2671,12 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
 
+bool sk_has_decrypt_user(const struct sock *sk)
+{
+	return psp_sk_assoc(sk) ||
+	       (sk_is_inet(sk) && inet_csk_has_ulp(sk)); /* for tls */
+}
+
 /*
  *	Simple resource managers for sockets.
  */
diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
index 2aa442128630..b58045df101e 100644
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -136,6 +136,10 @@ static int __tcp_set_ulp(struct sock *sk, const struct tcp_ulp_ops *ulp_ops)
 	if (icsk->icsk_ulp_ops)
 		goto out_err;
 
+	err = -EINVAL;
+	if (sk_has_decrypt_user(sk))
+		goto out_err;
+
 	if (sk->sk_socket)
 		clear_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 1a2a6b7516b0..e9b53eedf8db 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -143,6 +143,10 @@ int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
 		NL_SET_ERR_MSG(extack, "Socket already has PSP state");
 		err = -EBUSY;
 		goto exit_unlock;
+	} else if (sk_has_decrypt_user(sk)) {
+		NL_SET_ERR_MSG(extack, "Socket has incompatible state");
+		err = -EINVAL;
+		goto exit_unlock;
 	}
 
 	refcount_inc(&pas->refcnt);

-- 
2.52.0

