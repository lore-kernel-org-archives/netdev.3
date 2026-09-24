Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61201351C0B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257664; cv=none; b=tSevUFywN+XEVqrZp2dNvzI1HKI+Z8wLI4WWLjsBA+POi0Vz9VOJxtj0OoAIsE9fijBxkKp+C9AFCbZU5zX93n1UzZWiphacCqMlgVt/7mcJiPy6Zd/GM3tQf9M+DUzvUA4MbJ4owUFv7X44mwkcLB8PtX31Hzk4Qq958kZ4oHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257664; c=relaxed/simple;
	bh=j0mMLmo/36lUOHxt/rkUG0745LA1zAyYPURv2UOL4Vg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dC2s6Unc9XxKTzq3R6K9kdGH4gagt/Utf/Ay61BujQMBjWs9R+ceYUTRIYh/vNODf16mc7fZeSxwZKpIs4wP4ZZviAFB0vrZeOTVEv/vqeRUXoQa9qIK+BW62y5rjQAEPXO6HnuE+VvP+skHu/52h7Rph6uERwi6PLj1HMfzgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOcG2MNf; arc=none smtp.client-ip=74.125.224.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOcG2MNf"
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66c70fa2ba4so225069d50.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257662; x=1790862462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlBEwjo1fUCJnmp7PQPdVu2wwGFZSgLh0FhR/8RZjxI=;
        b=pOcG2MNfstacEookyH79QA+X9PWzIpzw5kcg+SohRxj4hCwFs2wCrfVCOetf+6l633
         bRTBRe1ZsXJhZpjAykrVfWJAyI/rKr1L6JsJnKvGBuZ5MnEhkRjUouF0nHhH3iSLroRK
         S7/TQnm+GoT2Z74zZl+FdHv/TDei9+2pQfdy9W8KufDTx15kqpB95VPbwFLtsdraQLAY
         FuBnHNiq/PnkH/5eUNfuMhnOOdGFb2EKYYp9GAvday4j9kbsK3As+bR3/iACN32QJVfL
         T7KlcvQL6rLvZMEwPvX3zoMvePTrghQqp000fBjrCC8MT/E8UspA7ToZ8T7IDSwqIKGO
         7EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257662; x=1790862462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NlBEwjo1fUCJnmp7PQPdVu2wwGFZSgLh0FhR/8RZjxI=;
        b=ky5LXLUOPzTd/VXkR6jsZF7pG1Na4HkA8qqvND8pHDTkLmCk21SbGaDoWAna8SQBGx
         tV6Usxlx7AwMtwiRNxXDARG0b9ZshMiphcHOYod4r/WcQabAeg3udeJSgT4484FyunuR
         tgtNzeYY1+oUW1FNNrx3E7rmWErZbfhZ4xmbJzO2miqb3Ibh+Ys6vOjpgEYBfekv+DZu
         Ahoq1Swhs052p7dS47pX5wWCBH29951PI9LLYzJFT31efKLdGcoMYnxHT6kc1zS3Pj5o
         Tyru9WG/pCDdqQNwC/krXBNBt3iKt3+AuXI2eK/FXnNVwFxOYN056wk1rOjanPkEdzG3
         POCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTbEKvHx5EKDn4dlHbedBMdE108QUjQoXu7hwixs5KkYEFr0zOWpRMdq+IASbvzOJym1zhm0I=@vger.kernel.org
X-Gm-Message-State: AFuF++knvoZe1TtcV/305R/nrjbLuSbBs75qPgqL2GpgEL0Fbe+kN/rj
	fvTU2BxwLVz8qRRpyFyxMDPu4PjACsfP4CUMWAwlDJGXIRin4aNPQwuBy+jItAx6yvopui126aR
	ogbSxbdYt/0MOsQ==
X-Received: from qvxg8.prod.google.com ([2002:ad4:57a8:0:b0:914:1ca6:ddeb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1686:b0:672:a52c:daf8 with SMTP id 956f58d0204a3-672ed57808fmr1494544d50.107.1790257661882;
 Thu, 24 Sep 2026 06:47:41 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:27 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-8-edumazet@google.com>
Subject: [PATCH v2 net-next 7/9] nvme-tcp: use sk_clear_nospace()
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
 drivers/nvme/host/tcp.c   | 2 +-
 drivers/nvme/target/tcp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b22c2e4c9fd60d09ed8e50051262d..b853ca2d598fa4cb8ea9cb66513f1e1070cd1fb4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1133,7 +1133,7 @@ static void nvme_tcp_write_space(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
-		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_clear_nospace(sk);
 		/* Ensure pending TLS partial records are retried */
 		if (nvme_tcp_queue_tls(queue))
 			queue->write_space(sk);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e598101752620448423925d2385b606e0b4346e8..c38ea3501ea5def168b6f180b56734b99d21bdea 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1686,7 +1686,7 @@ static void nvmet_tcp_write_space(struct sock *sk)
 	}
 
 	if (sk_stream_is_writeable(sk)) {
-		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_clear_nospace(sk);
 		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 	}
 out:
-- 
2.56.0.rc1.310.g51773c2048-goog

