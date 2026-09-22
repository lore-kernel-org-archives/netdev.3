Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B1542808
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080050; cv=none; b=RgMAf25aWyNAKbTOcuK5xUcLkMgxKbX1uGPPZxwoPVApeNSypj0IER8kOwguhF+QX0C6IPXrvyi81h+vYjbeZUTmxt/qhzY6TD51eg3Cw/goDkdP5DtQe1MnOOHNSR7mVezH2WQJlkd5r1Pm8vqBr8i6Da8Q/SEdhvGD23mLwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080050; c=relaxed/simple;
	bh=6N+mINR3e4X72mH7fiC19z6yIKmOTDxIFXEwmDqMxpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xiq4hICNlVOZudP6wK9To15z+yppl0ub528yHTcK1vdBDIJGDG4HPfLA2h8SfzF9+A+iDOr5PCwqZSG32ZwqudT+2C1PEJ6Y3j8UNOXBv7iGcUVemsAhQQU7e6lkGj1JSy9zx7SODoNuMG94dKAVOxn69GCadYb7pr/UBWFVXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1L0NYPD; arc=none smtp.client-ip=209.85.222.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1L0NYPD"
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-98304865f02so3447174241.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080047; x=1790684847; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCZ2wb1Hvl9ju7HWHII+yJt5gbw5hSn5Z0a92aLPka4=;
        b=l1L0NYPDKgDzC2E7M2+tUzr0ztRWVZRvJlNYdDAcjSqhF54p1GSZW7HJKlnOil/IZs
         XZyPqGVKzrQ3b9SwiJnvIQGDkzHFRy/W917PTe2DiOq5uM9lgHr6E+eyRSS66PFP12Le
         16kuMJKfN/B7/xAv2WZQu/6pc/3vcAdBezi0c6vHPAtRFcyx+QadxA6lNe0C/k9zI+zg
         UeA70gXBM/z9N/1WwO9bvtE/mRJs00+UHbJJBPh3yW3WQoRt/MecyYXRKLk5fyqX16rE
         C93Kksffg3URvgfql9B+VYxq1ueJIb1kl72CrtYb4jeaO59sIVkGT9wHUsIcsLi5NQcz
         QHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080047; x=1790684847;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCZ2wb1Hvl9ju7HWHII+yJt5gbw5hSn5Z0a92aLPka4=;
        b=0Y0eAXghzBrQ1KRzOPrnheB1zinNklgFdt2pL2tXV3DEqQpgSfDQjDe+FEFOafOsRS
         Gh8KBwnC5XmB9Ggos/H9Uk1COZWdIAtoWq4hWRgFGOubJBB6rcG/5+pmfcTW5/ghESdz
         ZabHJ65h53YRZ+64d/4iqsVka/0cJWiYFIbMNSI+Xbhh33dkBODoq7UmFtM+IOEqx3UB
         uc5A1DXtYpgNe60MPNQT6hb1GrOeYzv3cSX2HUN33hqh/wu2Cd6OB8y8gXFEgY1Iz3cH
         a8/Sa0v4bIEfdLu4bkpvcBJeMCHRAHK6lX6rWidVIb5FRupsU54PFSSzWzhQ/ziKi1nq
         Je4w==
X-Forwarded-Encrypted: i=1; AKwUvByKNYvv3l/VCHw0MR+92UccZNQRITBLtuUD3pCPqT4oGnXyxj0LGEmfg11d1NqgPW5u7zkY/fY=@vger.kernel.org
X-Gm-Message-State: AFuF++kJWFvRvEVS+Cm0aSQeys6sLN0THPoYkNeAx8Qn03I8iF0tlPt4
	zs+47Ze5ZxMReyytkIYXk/zPxatGRnQbb4Ek5JHK0hlFxuuIiRxJtpZzHxMHpZtVHzmEwT7R13G
	4EHs8QfOPmMYVWg==
X-Received: from qvc22.prod.google.com ([2002:a05:6214:8116:b0:910:6d7a:5e05])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:41ce:b0:7a1:f7d2:e819 with SMTP id ada2fe7eead31-7a56fb38022mr5022028137.18.1790080046863;
 Tue, 22 Sep 2026 05:27:26 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:14 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-4-edumazet@google.com>
Subject: [PATCH net-next 3/9] sunrpc: use sk_set_nospace() and sk_clear_nospace()
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
2.55.0.1082.g2b9226bbc0-goog

