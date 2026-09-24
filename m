Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDBE33F8A1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257658; cv=none; b=BqY02pXyeRMU1/2EDlMP24btlcNs6rZjC3Cg/UqIP/GeRHjgutkoiRJuwrpivs2OaVNd6+NyrvIzlKBz47yTh+sEb1vbOab3ptFBTjPoCQRZev3VAzTWU86VE2Iv6DvZ7OGTsYFp8G4ijf4Tr4oF65hTW0D0XrorSelPqrqomfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257658; c=relaxed/simple;
	bh=ebZ0hMa4eQMu9e1kYr/UNCoBKUTJpsMCwaTmULeCZOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iYQjxkarsfZIWHepBi4hj7SEmbEirqUow5PXl6TW6mf5v57z1B8+vzmiUNexROfit5EE/PXkW+dP7yMlFEk2WKx7NlAiX3+vU0i5cCqIyiGOFwxVfySBu2iZs4hazq1vWUsE2Ngs68Vf7OHBiJbyPFUyy7b1FNAYZyilh5VSJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5ZWYlRk; arc=none smtp.client-ip=74.125.224.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5ZWYlRk"
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66e44d96aa0so2004117d50.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257655; x=1790862455; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBrT9cY9T/AjcZ36xhkRlb8riIY5t6eXxi0oQr4qBFU=;
        b=P5ZWYlRkSPmsgz0XUmT1AQJIjKRU0qMAIoLlxsobsT4Dj+llUycGHd/bL+K5PviyD6
         NHOrgcF7RxpiMzdHHNKJKm5cFsFbN73A92I4Sn7XGDeYjhvhNzN/2AShgQesW1Q+NasO
         Q+2jLSb63Ja+0GOU8tVjhL19EVBvGPhQ8v2tuWUU7Hii11IsSMZTtLC4I7IYGu0aJqgE
         E7ZC7FHS5o8ycsH2TEWVjYb5IQfQTQsdyRM1J2qPwuWzzTb5KHJeKAN8kTLgMRDSu7p0
         YgZESMdehms0aRGDODeeeiL3Fcweo8Tn2cjgO+Yxn1911kSxqOnJf1iRbdybYx67dvG/
         jejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257655; x=1790862455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBrT9cY9T/AjcZ36xhkRlb8riIY5t6eXxi0oQr4qBFU=;
        b=ZfUdGyDXITBBwlS6lq0NpMhOBorri4U4as+kZCLpER2Sp4fdS35Lm6BeddGaDbqGbC
         avOUSeRz3UVeJ8x0tcs1A5/zalxGFCC6Xv0PXnIEI4TYnmI+oEH9mUUatv1owiZtmriU
         lVjIi7dxwDx3RdDU2QT7K/83FXfD+gxcjMRzk8MiEUr7b8BN3hD6pYc6PA1PRZVLraC2
         mflTaAlKHazw0kpvPU0oQkxNf7hKhny+/ev3E79kcoFrvXP0DpljArOCk7qhtq5GPLBF
         FyerVfhKuQZUU8t2DZk0kMgdcn5j2LKyfUbTFxyXlXxTxw3REZOWql9Fsh96LNYFaHVp
         Z9AQ==
X-Forwarded-Encrypted: i=1; AKwUvByd1S91sRKUHUXnLZD8OqSNgcWgh7BLQZz23hONfnYdyjMyVhbTN6EzwsSx+w9PkmbRcpm1EBM=@vger.kernel.org
X-Gm-Message-State: AFuF++msJIGCqcd2DishNKJGmZuVsJMTRS3eyyRKwe4VATtKmgqbYEj2
	/q+s/DXm5JJtlxJ9qOOTIKNIo2R1EmSj/0+fN4KAygmsnRRehsdrOYgQGa+Se65pKYQXU35zPd+
	cNGt6TUpa6rtbHQ==
X-Received: from qvvl17.prod.google.com ([2002:a05:6214:291:b0:914:2057:447])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:43c2:b0:671:70f1:3b49 with SMTP id 956f58d0204a3-672ed479108mr990577d50.108.1790257655473;
 Thu, 24 Sep 2026 06:47:35 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:23 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/9] sunrpc: use sk_set_nospace() and sk_clear_nospace()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers instead of open coding the SOCK_NOSPACE
manipulation, so that TCP can later maintain a cheaper private
copy of this bit.

No functional change intended.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sunrpc/svcsock.c  | 4 ++--
 net/sunrpc/xprtsock.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 50e5e7f5b762de28c34d0f58cb0c6feb1e3ce79f..2d8cdee0798d540ba8eae589deaac5bd3ff889fa 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -792,11 +792,11 @@ static int svc_udp_has_wspace(struct svc_xprt *xprt)
 	 * Set the SOCK_NOSPACE flag before checking the available
 	 * sock space.
 	 */
-	set_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
+	sk_set_nospace(svsk->sk_sk);
 	required = atomic_read(&svsk->sk_xprt.xpt_reserved) + serv->sv_max_mesg;
 	if (required*2 > sock_wspace(svsk->sk_sk))
 		return 0;
-	clear_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
+	sk_clear_nospace(svsk->sk_sk);
 	return 1;
 }
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7f60723fa64d84887e260e5e130e44cdbec6f850..b97c70c12f627630509510facfd3c3cf96ab6cb6 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -858,7 +858,7 @@ static int xs_nospace(struct rpc_rqst *req, struct sock_xprt *transport)
 	if (xprt_connected(xprt)) {
 		/* wait for more buffer space */
 		set_bit(XPRT_SOCK_NOSPACE, &transport->sock_state);
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		sk->sk_write_pending++;
 		xprt_wait_for_buffer_space(xprt);
 	} else
@@ -1615,7 +1615,7 @@ static void xs_write_space(struct sock *sk)
 
 	if (!sk->sk_socket)
 		return;
-	clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	sk_clear_nospace(sk);
 
 	if (unlikely(!(xprt = xprt_from_sock(sk))))
 		return;
-- 
2.56.0.rc1.310.g51773c2048-goog

