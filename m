Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664436;
	b=hjGjbvioOe4jE16sSXDHitddPp36JW1mjs6+O//5hlWMLWRiAUYBoMu5qe3FbYBQGSCV
	 7blgKojtdACqpG7gJBhX6XaiQ0W89If4WEY8rBSvuyhz5jYZBHFURpOsYSKJmXZ1/rPiD
	 8evbQPXW7NhIaT4xxQ/+F3XHBfDPPo0oBXbVTj/0LBdcH6sPTBjdrEekI0C6Bvey5dyC6
	 idY9wUqZxlg04z0FlC72XAUg3X3u6h3PccU+6ltZnzeWbkoqB9pvUcd58y10d7I+0Tifp
	 7DFihTvvD1ey6+Bw0pCY0pCO9rzYagk50W9RDiOpY+vhsqXpQ6sn2jAPLxqu/LULLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3vKPZGLbGg8SgNS3ZOGatM6rK+DoeZPwIOGkhzcYMsM=;
	b=g3u758qRqEZPmxbvw8VzuVS/vkHgOOQfJnT9gQB/hO24LQVmn8GVy11IJXpbQe/A7aIG
	 tYMZtMqdW2NkZfF9fFpB14XxsRWlYONzoToXZgMtXgCc9vm1RqOpi8PA1UInB1XWaSlmJ
	 uJrRU3dcg8l5h4xXtTcsyv3ZHibAQnZU393NCTfx6CQ+Tm0cB4o+JcH5hspB22GhuUNiK
	 mn4HMlBBJzDqMHaPIIKA2TR6AMIieSA3nKmTYmtV8IDepf2T0NyhzYPJFn0w869um8wa0
	 I2OQdy/JsX61NheeNmmMXPw90OxpkNEociMabcyXtkZeq1F++M96bfpEQ0L1CT7YJmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SVx4r7s0;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B32606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 00:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B32606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SVx4r7s0
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0865e4282so979213b3a.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 16:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793664435; x=1794269235; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vKPZGLbGg8SgNS3ZOGatM6rK+DoeZPwIOGkhzcYMsM=;
        b=SVx4r7s06v1pK0bd11P6PxluUF6yRNLdWV4YmvSO26AJ7FQATZMTppS6Ia6N0bRdp2
         VmXhpAEjqZqa41WzyYVjAyoeM2ehySTaltIocP0RyWBjbQH8Y75U/yUEaGN8xTghtOwh
         vEy9E5tvfTBDD6alW8GyU7VYxIOXvDucWQFebZAixKXS/a636AG1s3PulATQrHC7OQuF
         ckZtIiSf4AFXP0+qmM5IH6yYjK1Pe+yywldi8O0Zb7eW9bP/SbD1R5/OGExMrq8SmA8o
         hxSnNkyroMH2ehlOkevWrq883vLhJeH9mZ494zACXAWLiE0u7bS3pMm2ORevGnBlDDap
         uj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664435; x=1794269235;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vKPZGLbGg8SgNS3ZOGatM6rK+DoeZPwIOGkhzcYMsM=;
        b=z1y0b52bmfr9gPR2xZGXPf1gnBjP13jne+LhbyatJM6P5m1uR0yB5NX/3vgyM0ROr7
         ENxJLtxU6MKAySwxjpYWo/+sCq3wl9X1y32fkkss49M2lLDAsn/Rr/7HYL2WIomS4bhl
         ePAgGAomtOcjiqGk0bM9cQKMldEtGKCVJ/eCtA8jNG6piu5zKCgYHU+px6zbLoJm+4Ku
         T8NlQuG64/kK/L8bfNuPjS+9L5ELBX1+VQKJEWheW0FPPBCiXTrbzMJCPoDniULSMOoa
         XaEdK8hBhru5glrdgNCs3Vb9yxWEaM6BdLE02VwLJDF7oLhl2ZMrF3E+MZ3fBKmhD8wJ
         a15w==
X-Forwarded-Encrypted: i=1; AKwUvBwuCnt100u6Aa7JICeijQI3eLzy1qv0D0LfFn/GjKLdvobUg7pO+aqlNTLvAqoAJdByqCCvS9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/95L7MhDhTBFL+SV9RiBfvMqqyKYUjRNpiZbaAEUwlO55ED0Ob
	4RcOdFUJdWEJDrmKz31WcUcToRe6vSFWJae/dx2/ea3h8S8cMCn6BtpCGxsXRus7RCDqanbit8K
	3Dp+XJA==
X-Received: from pfei10-n1.prod.google.com ([2002:a05:6a00:c04a:10b0:87f:c4bd:8a29])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3911:b0:881:e626:74a0
 with SMTP id d2e1a72fcca58-8a9be490bb2mr8269558b3a.47.1793664435191; Mon, 02
 Nov 2026 16:07:15 -0800 (PST)
Date: Tue,  3 Nov 2026 00:06:02 +0000
In-Reply-To: <20261103000712.658501-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103000712.658501-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103000712.658501-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/2] psp: Check pas->tx.spi in psp_sk_overhead().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Thaison Phan <thaisonphan@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch moves psp_sk_overhead(sk) from icsk->icsk_ext_hdr_len
to __tcp_mtu_to_mss() and tcp_mss_to_mtu(), which can be called
between psp_sock_assoc_set_rx() and psp_sock_set_tx_key() while Tx
packets are still sent in cleartext.

Currently, psp_sk_overhead() only checks if sk->psp_assoc is set,
and even without the next patch, if ipv6_update_options() is called
between psp_sock_assoc_set_rx() and psp_sock_set_tx_key(),
psp_sk_overhead(sk) is added to icsk->icsk_ext_hdr_len twice.

Let's check pas->tx.spi in psp_sk_overhead().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
not worth backporting, no one does that, only theoretical issue.
---
 include/net/psp/functions.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index b23c30898389..410adb6718c1 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -145,9 +145,9 @@ static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 static inline unsigned int psp_sk_overhead(const struct sock *sk)
 {
 	int psp_encap = sizeof(struct udphdr) + PSP_HDR_SIZE + PSP_TRL_SIZE;
-	bool has_psp = rcu_access_pointer(sk->psp_assoc);
+	struct psp_assoc *pas = psp_sk_assoc(sk);
 
-	return has_psp ? psp_encap : 0;
+	return pas && pas->tx.spi ? psp_encap : 0;
 }
 #else
 static inline void psp_sk_assoc_free(struct sock *sk) { }
-- 
2.56.0.385.gac671c819a-goog

