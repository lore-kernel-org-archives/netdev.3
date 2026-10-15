Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEB47DD56
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049871; cv=none; b=VbcBKzUS9p2hN7SJvAgctmn1QOo1DCl3CTODCxcYkdrEbpOlxD8smJAXf6lzaUzfuu2y1iRYOXV0vF9lLlcFQ08vQmYxSfIdC6r09jWk/eADfMH4FboN0wMKdzbZ7Has8su7+ANR9F0IwRs3Tb/FuAVIWp/Dyijv/vkr3eerrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049871; c=relaxed/simple;
	bh=MJaPpi6RTOlShP6v9t/9OUQeZWJvnSNSFOIjHeG0OoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AP60UaLOffIa+5lIMOWfJlol/SGzJPB3aX2SPU5p0OSAFfSjGHA/lfBCnH3g02tg6kvWQfTfUyXFqjXyR03FGfCE0XEcIUnpCGtXZaQhHmNpNWvj9mrv41Mrg4eMyVcbGJqy72gBtPN4B8tsjDf6N5YV/ugtjyXkCA17wirCh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGFxMchv; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGFxMchv"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab868fe362so6553197a91.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792049869; x=1792654669; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yp2Dhep6A7rooakSo9IViYNGjbkwaIM50zIM/h/7sTw=;
        b=aGFxMchvWhOp8VLtFgjj/SaQt2UEKHJsp1VWLMTfBojwW1i00K+LJIjocRwlEh0oPj
         vAe1er0mQv9cdmONiaPenhFgckGVrdmmWOqlZSObyJxUVaFhXi7djeWq/l7xir3AhJ0B
         1U7aO2QDiQabrb4c/a8DjjWWq9SvZno83p9dv9YmXmf0QAzfyFksodbWroQSQSkusHGY
         SZA04ni5bcFir2ZByI0GO44q6mzEs9pG6gNi6s/q+5/REBWXXTE0G3XQ9c0oVrcK52CQ
         8dCTo5deQcxQ6FAJwZTK1kbNpAJg8LFS4vGOeZKon9PQVemBcTWrDk3TbDMV4YprrOoC
         Hkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049869; x=1792654669;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yp2Dhep6A7rooakSo9IViYNGjbkwaIM50zIM/h/7sTw=;
        b=YDYRmZwz9UTr6kfE9x6XRxmnoIgmEa8A/TN64GEtMHCKXwOyq3rK+qBNYIjEgs/CdS
         J+vwW3tN3mMI+omfMSJtFFyg3rB2IYEOyHYTMR/X4nkFYn3USDIAbj/1rQ5xrHnevQDw
         3psUaqlIm9Htu5gaL3t2W6cnOvzCAu9uGZTcmS4xdVyDz33JgK37q9AKlFTlfQmaeF3u
         Aw+N0P8AinRkVzsidf9MfPkq94ypxQ1Avu0k1nRoVXYw+6IiGOuGV6e05LN0B5cytDAI
         Eb/q7vUYofcVdid6ny7ByhiDKdOm787rvieqiCjjLjP/wNYYHtraBHT4WU4DYXqRKh57
         cEOA==
X-Forwarded-Encrypted: i=1; AKwUvBx5/nhLtMpktXxdIw2tUYnySup2Q9Nx34sHaIpJt9G2T4FPsuqHa6WT+v+a/eh+LRQIHLozmUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6CUaOq8HCqRoDuY/CZNQypyW87OUCTYyoqKesoyYz+rO5tAI5
	8sRk5RZxLBlePI1d3WzlGO1z2unqOE22/iGhLgc87AQebrUxrKn/2O3zjyF55NhO1MZjQHoAMsX
	z8g==
X-Received: from pjbhg16.prod.google.com ([2002:a17:90b:3010:b0:3ab:82b4:1ca])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28cb:b0:3ac:8897:7ba3
 with SMTP id 98e67ed59e1d1-3ac8897834bmr2487610a91.62.1792049868678; Thu, 15
 Oct 2026 00:37:48 -0700 (PDT)
Date: Thu, 15 Oct 2026 07:37:35 +0000
In-Reply-To: <20261015073736.2944215-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015073736.2944215-1-tavip@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015073736.2944215-2-tavip@google.com>
Subject: [PATCH net 1/2] tcp: clamp return value of tcp_wmem_schedule() to non-negative
From: Octavian Purdila <tavip@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

When sk_wmem_schedule(sk, copy) fails under TCP memory pressure and
sk->sk_wmem_queued already reaches or exceeds sysctl_tcp_wmem[0],
tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc).

However, sk->sk_forward_alloc is a signed int that can transiently
become negative when tcp_collapse() re-packs partially read or high
payload-to-truesize SKBs in the receive queue and charges newly
allocated SKBs via sk_mem_charge() before freeing the original SKB.

If tcp_wmem_schedule() returns a negative value, tcp_sendmsg_locked()
passes that negative copy length to skb_copy_to_page_nocache() ->
copy_from_iter_full() -> check_copy_size(), where it is converted to an
unsigned size_t > INT_MAX, triggering a WARN_ON_ONCE(bytes > INT_MAX)
and returning -EFAULT instead of waiting for memory or returning
-EAGAIN.

Clamp the return value of tcp_wmem_schedule() to [0, copy] so callers
treat negative sk_forward_alloc as 0 available bytes.

Fixes: 849b425cd091 ("tcp: fix possible freeze in tx path under memory pressure")
Assisted-by: LLM
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87ef6d5cbfeba..0e062fcd94a6c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1037,7 +1037,7 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
 	left = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) - sk->sk_wmem_queued;
 	if (left > 0)
 		sk_forced_mem_schedule(sk, min(left, copy));
-	return min(copy, sk->sk_forward_alloc);
+	return clamp(sk->sk_forward_alloc, 0, copy);
 }
 
 void tcp_free_fastopen_req(struct tcp_sock *tp)
-- 
2.56.0.176.g3575e65682-goog

