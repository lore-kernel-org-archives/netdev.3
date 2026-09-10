Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57E49E12D
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083982; cv=none; b=fdKFmRfcmieEVeCXQU+L4KGj+DNK4emnzUxTpo9F5Cwt1A1itwuw6IjADeLUDRgd38Kn97Fa2EeQ6IXKZQFGFn55zWY+DgPKzXz/qvBa5G2wkVm3a+a4DMIAdCf+i4CMF1YKHUMdBcgVK/3R8pxCtI2LDBybYOL7naeRczThAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083982; c=relaxed/simple;
	bh=M6jIXaEoyrgc6/WiURsN+U8IhrrnZ9zZFg+Oj7F70yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KOUJbTpQstBXvLzXXJd9LBE8NdVhActoF5OrH706cQKYxE4NAqTbULf3/sFoVjBQLRr83umClu+nDuSc9lwdSS7wraDZp178UL1yDiliV9JHYsxD8rf000LIATjiFerf2uXcFedS2ShQ0tWZ8/PI2SyBIwtS4uHNY8VNeduadZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2zxLEdh; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2zxLEdh"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f4b94d72acso346628a34.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789083980; x=1789688780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kbyz7e2Zj6Paq1U1ORPGnZB2czddhzmepRdeHB+cyyk=;
        b=h2zxLEdh2X+9pBLiJGXLrsF7DuPx0SdMZj202+AUvu8KfSElB9fEgE145Bxigj4AaA
         u1LgPi24WJzLIPC3Ul4quk3T72yvOtIRcand7Ete+47fyfL//NNTyMG3PXMj/iqH4+Ny
         QNkg2Mhy7ddOPMQ0mBNHQVU4UY1ipAIiXRL+GNmwUvf23+NQm6ZL2AAITHbxx0/6egQN
         6gq/FI7XVpOyAQS+//I6tkbUIJ6SRTYa6fUodc/SD8sHgCYev3YBRNMA3q39ZK04nnYu
         n0UGk+hwJgpsllh4x8XRiPAePsH8aZ83TNZMX8lYIjm2Bl2L0f0Api6sCwAHuAmN3TN2
         mClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789083980; x=1789688780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbyz7e2Zj6Paq1U1ORPGnZB2czddhzmepRdeHB+cyyk=;
        b=S0cUGhE3NgYCIzH1o4knyBq0cfxsag4f5xX91ZlaK02EDnZX5FnTrqKWIKQgxrTFPE
         DWcUSXRQsnhKdlrNkUh9MXn6XtbQEKh/TQgaHYVGb/3JBvkvNcT/diVeNCgsM7xzqBib
         7rvKA5Ocqjey/Z7evewFI+KUMFumIwUdOFkXr5STAaLKUGJY3uEkoG/7XNU3+ky0KAgg
         q+WjAc8jkm96pzfsbP1F2oN42yB5o8e2nz4rTQ9+NghIKs/pGBvml5ExY5yn3KFHXMcE
         T5rd7pR2Sw79ov65JsZseApV2Zb+5YMRaJVa+oc6sWxqPqProdfldG0g0fA8oYiZAI9j
         kLuA==
X-Forwarded-Encrypted: i=1; AKwUvBwqHZspOynydpRsP5QhFgKxlY5fNJAH5Vm9VivM8MC+FTfo9gYTuOTgbMRQU4ahZ//F9YoC3vs=@vger.kernel.org
X-Gm-Message-State: AFuF++kKXI388j9hbZxQ9f/ODUtqynq+BGUSC+oJFGr+a6HsPex+GsHQ
	q8Ap3NCaSaBLKDabFPkJ/x+sRRYTUELNaJ5UzMpKcTw/OUcGgYWQFUXCJXs5+u8v
X-Gm-Gg: AYBFou0op+LpGnecdrZgbqO3SSYTIS1VPMop6UF7uimonHiR7kYv+RhtTE8KSkNncOj
	p39vzcDD8XdthDvWm4JNFy24IsR5U75n90XqAvzfU663iu93sqfqIslbRdM/P84/me6ei5QCLZS
	yZS837B1/iNZJ/JYhpWne5JuzpTExUBF44Mc3mXro3nazcPAheGgSbU54OvJDHULH4MSYpVNmrs
	r0o84KQ9u/6eywbfhO3NaI8Gsu86uwgqQXkPPqJ/JQoK4sQWp4yw4mPZbgjD9NSTVCekubTIJxd
	lXuFZK2xxNMdEBDPXVitoVqncSIqtWmxBMl+hLkfblqA2YZyhtfTu/NHMVf58gbUzId2Dy8rhyY
	Reu81xaJ4gRfERl70IryusN7Gfy5Gm13ohU+iZEDX2oZ1puxjEghZXieuFyPdb0Xr6TOzN6A4Sp
	ezHzwa2fyGiU+jellnkOl5zC+UoeVGlSXp7YCYtYF/QxVZXVh5QMOWiOMJuf3AQrpiBjk=
X-Received: by 2002:a05:6830:81cf:b0:7dc:df37:844b with SMTP id 46e09a7af769-803fadd1e9dmr1084870a34.4.1789083979942;
        Thu, 10 Sep 2026 16:46:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5adf6absm926604a34.6.2026.09.10.16.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:46:19 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 10 Sep 2026 16:46:04 -0700
Subject: [PATCH net 1/2] net: psp: avoid conflicts with skb->decrypted and
 sk_validate_xmit_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-psp-ktls-fix-v1-1-e3f30aaeca4e@gmail.com>
References: <20260910-psp-ktls-fix-v1-0-e3f30aaeca4e@gmail.com>
In-Reply-To: <20260910-psp-ktls-fix-v1-0-e3f30aaeca4e@gmail.com>
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
sk->sk_validate_xmit_skb(). Offloaded TLS conflicts on both sides in
both Tx and Rx. SW TLS could mistake skb->decrypted in the Rx path set
by a PSP device as being a decrypted TLS record.

Prevent PSP from being used with other socket features that use
skb->decrypted or sk->sk_validate_xmit_skb().

For now, we include all TCP ULPs in the sk_has_decrypt_user() check,
even though TLS is the only one that conflicts with PSP via the
decrypted bit. This is intentional because PSP was not designed to be
used with ULPs. It is best to close off surface area that may make bugs
reachable, until someone wishes to design and test an actual user of PSP
with ULPs.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 include/net/sock.h | 11 +++++++++++
 net/core/sock.c    |  7 +++++++
 net/ipv4/tcp_ulp.c |  4 ++++
 net/psp/psp_sock.c |  4 ++++
 4 files changed, 26 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac2..ba5e5092f192 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2312,6 +2312,17 @@ static inline void sk_gso_disable(struct sock *sk)
 	sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
 }
 
+static inline bool sk_has_validate_xmit_skb(const struct sock *sk)
+{
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	return !!sk->sk_validate_xmit_skb;
+#else
+	return false;
+#endif
+}
+
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
index 2aa442128630..f3e0c9d379bb 100644
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -136,6 +136,10 @@ static int __tcp_set_ulp(struct sock *sk, const struct tcp_ulp_ops *ulp_ops)
 	if (icsk->icsk_ulp_ops)
 		goto out_err;
 
+	err = -EINVAL;
+	if (sk_has_decrypt_user(sk) || sk_has_validate_xmit_skb(sk))
+		goto out_err;
+
 	if (sk->sk_socket)
 		clear_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 1a2a6b7516b0..509035617894 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -143,6 +143,10 @@ int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
 		NL_SET_ERR_MSG(extack, "Socket already has PSP state");
 		err = -EBUSY;
 		goto exit_unlock;
+	} else if (sk_has_decrypt_user(sk) || sk_has_validate_xmit_skb(sk)) {
+		NL_SET_ERR_MSG(extack, "Socket has incompatible state");
+		err = -EINVAL;
+		goto exit_unlock;
 	}
 
 	refcount_inc(&pas->refcnt);

-- 
2.52.0

