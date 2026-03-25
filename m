Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C815351C37
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420735; cv=none; b=uBHrO58OrdJ6dMMUIRwW4rm8UmWhN3qfIiVBTv6zyBXDrC7ArsAuedYrv1tAyLrmQYT+Lrdz2K3pKEwJ4MoqqGGYeeNsAjYCt+NCD7I3Wr4dpxfu7E2Zwh+ZXgYpgIJNTlALBvR5DJz+pgqsMh7jFMUosZ6Io3IPjo/gmPB+Z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420735; c=relaxed/simple;
	bh=Dvk5vhl0CIvLArJHpPcg4CQ7xAl0HOrfl9NgAH6cT1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ti3HMLME1hSYGYlJA1EqJQRnYaSGgUqpq0JNdFUFxJWiF6rkKnJBxPQYOvINULsL4gRLylP5DXUnYw/oPbdC449X9PdWe/R44G8MvfraUvkGFtMpxl08ypHyTK39R46141Qtq/euOGZymL4xgn3H+twxjm4saRp/0ZNr3nJTWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVIJWWkH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVIJWWkH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35ba237d2e0so5806002a91.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420734; x=1775025534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe7lwzU/0LJm5TPvDH/KfFTCZrDEcrbFnFZJiKYD2Dg=;
        b=dVIJWWkHI0+UrjpBMaV80kUi31Kk8Oqk4UkSkPJwDw8TnjyjqFUL0QLXl5Y21piddB
         nbJ08c52Guq9AN3nXmDhpeRTCxfcJIvoHP+44t88hhjULjEcjyVELNV/21d6XH2lKny5
         vhHfSm9DPuTFUkiCzEYo1FNNJoemdjrKACA3BOPpWRxCgUhl0Lz/cjjyo2GjAcPmlFhe
         pfiQmzU5Iw9pH/OhfAXf0XX9EKqfJaKZjmPgidQZj/B7OIbG27AU5ghTfLHLdOu4HXbJ
         IFe1/FCzqTJR7Zbqr8Mqo4NLPNKfZuyHsN7KSfsA+VReEuFo/zSWN5jz6/wwqauOl3SH
         ejgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420734; x=1775025534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe7lwzU/0LJm5TPvDH/KfFTCZrDEcrbFnFZJiKYD2Dg=;
        b=lexyxe/b1ecu1yz2B0H4RbKFHqkU1NIY2UL4UpzEujMj5nQB+Y3ESrcNaNCVpQkD3D
         zMZaEC9oPfTbltv/i8OljYMvFeFTb0tb4WVaBrzIXNi/vesZhf0FK0kpj/p/GHeMpEVL
         fx6sH4+AfY9aGAJO9+eqNJizewydKJPhkpzZhGNn0PsqtcGLtYt8s1q4aY5AmvFl5K0j
         gd6MUPV+GIOhYCKR7QOdqSvNmKWFGtPF+G7eBHdcKajXeo66e+U3Kj47zVAehwpv9Fbs
         7coCjdph4XQVmtOQ/vC8HJHQcsndgV4YmfhAtMaasYrJRnc/A/lYcuGE/q5AX3arXSYe
         mfUg==
X-Forwarded-Encrypted: i=1; AJvYcCUJK2Ok7mYuRUqaPJdlBNd/yOo/WDSxt+f4ctdeRSpnr1R3T++YnzdOH2OeM6gxzfVPzLU2zAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuG8s1kLPiVpKR291FqO2dI0Xh9uboGu/Dj4HcdIxutnUR+NEJ
	RKZQs2qq4glEgRHc1R189HV38oLA6qRpqTbrSpWqjzyrdMEs4SCO5VyZuaxAHDL2h8bz9QgyEv4
	neVUXzg==
X-Received: from pjbfz5.prod.google.com ([2002:a17:90b:245:b0:35b:8f3f:2b30])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cf:b0:359:f77f:8cff
 with SMTP id 98e67ed59e1d1-35c0dd6a759mr2063094a91.19.1774420733796; Tue, 24
 Mar 2026 23:38:53 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:22 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-2-kuniyu@google.com>
Subject: [PATCH 1/5] nbd: Remove redundant sock->ops->shutdown() check in nbd_get_socket().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit 9f7c02e03157 ("nbd: restrict sockets to TCP
and UDP") (s/UDP/AF_UNIX/), NBD only accepts TCP and AF_UNIX
SOCK_STREAM sockets as backend.

nbd_get_socket() currently checks if sock->ops->shutdown()
is sock_no_shutdown(), but sock->ops->shutdown() is always
inet_shutdown() or unix_shutdown() for these socket types.

Let's remove the redundant check.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/block/nbd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fe63f3c55d0d..fc714cba1f23 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1228,13 +1228,6 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 		return NULL;
 	}
 
-	if (sock->ops->shutdown == sock_no_shutdown) {
-		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
-		*err = -EINVAL;
-		sockfd_put(sock);
-		return NULL;
-	}
-
 	return sock;
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog

