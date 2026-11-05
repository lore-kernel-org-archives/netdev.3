Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914148;
	b=iCrRQZprRrCYLxlngwnwFrjZza/EGRYu7ETrKK1hvH2jC7ANlcybYurYnmGwVQ7EFaCP
	 ufR6wkJ2yKq8kDP18SfJbtlBNlkt7nj3rTjwJCBf7n729mtHVHETKyDbJaqomzcnlO+UM
	 FhQOc9Y+4JY60i5TLmFDsgl86fb7Jr4RBfAcu7ic16pOvozUbwozcCeX7O+cMJdgh4Pmx
	 YtnnEMqGhOcaTGDul4li0qifyN+IKEw+TBThgfJwVz8syBUlvQry9RgEfQ4sW1hM2cSOx
	 8dpeJB+HQunzyQc9ITWFzk3JDq0VKVrbDtvtIpXjgSpM+ZqbTtwhXI5glaPl33YAvrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cEpfhx8IFoiyPAiB1xDtLyJw1N+YiOtPxhgpgxKhjok=;
	b=C6i8AVtqnwN7oy6Ggn+oMEH3CpjbC2BY1c99kjos0Jl2OTiPwk7zaVdQSCiWji+qPinw
	 JsmeodxYOJx/cOkxjQs9JFFtjET5pK21SFCH+e2kCjgwNaV/9vE3MkiqJgcCNyARS6tGw
	 0djnkp9c388362G17c9eDCi9QTv9g8VY9j84ksSsXA5he5OUEMX4BO1uvZxMupEeBTUfs
	 K0IMAj0KAOOHh7ze6wsd+tBK6leULLkom92piTWXCU16Um3lC8OXH1ugZBtp+biUMxu5V
	 BQq/3ur9XqYqCCLmc+5LmvLFsAeljMrari53+mVJUTp46OFQI56p6MxAwt+X2DevTEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RrlZ18Tr;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C9606A339
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663C9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RrlZ18Tr
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed08904845so32206535ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793914148; x=1794518948; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEpfhx8IFoiyPAiB1xDtLyJw1N+YiOtPxhgpgxKhjok=;
        b=RrlZ18TrCxuzqtqXjPZTgD9GOPMX742/cyRlQV4w9ibTtiBaQklq9crWDzHijOeKIV
         Wn2e6a4/9WE/jgQzJ8GPiD34iu6uZr20pY+81OZ62NGQSsPUaLk5ZB6bra5yGQeR2OFO
         9mlJVvKyJUFLk9VtkFKoA0dACM8tumVyd8BTOVcb53H0LChnim5WxcfhZJF02UVd6XIx
         35gsl4q0CKJ58bzwqh9lY2z/EE5TRlm648qJgB/8DD3xSeqGYefIwUqH+P/69Csu+KPH
         DOGGoazb3bNk8pYn3hncISOsO3JIJ2GFRd8XfMAinBwtCBOjnKtGzt/a1zmhMaQn/H7u
         OBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914148; x=1794518948;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEpfhx8IFoiyPAiB1xDtLyJw1N+YiOtPxhgpgxKhjok=;
        b=TToArbE0kVLEta9NPA+ja3KX1zI1IAjiZTrGgNGP40a1TbwiSdgmq2wAwNuOSuxcrb
         /1FfdtZj72ijro1W+BUbGJrqK6SLQ2epr0iLDB8Sh2yY/BQZwLZ6OyOc0aHpefdRPrqi
         3v9OqWHvlJQrH7gOOxsE/qKZ9P1jh73Z2z3dnyIQIvQiGj98N6s1gMFaffZOMKbJIpcf
         kJjkVDAxJh5zgXqv8hvaIhzX7QOfXvQMrZAj++yQgZccrOjLNxa8Kii3CF1EQjnLw3GW
         BC3mM1XW6z/1Llds9xeat6coXoYnNP2sSqdlODnniUdAGHpSbXM9ZjSayrC9RiNmM0Ts
         /oOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjiXOjPGF1Afd/8K9nxCGSijWip66a7bldplp2Jbca/n6Z+JaJn2+uXgrTXWYO8twCyrUw9p0=@vger.kernel.org
X-Gm-Message-State: APuU4Z987EeUXgOPWntCrjM19o8iNYfcxqfXdtzUIPt7hFHRA4Exb8w/
	ah8AEsqSJs6GOF9sS+6NXd2XNuMQrgLvZQnWsb70xj8qUzMQs0Yr0PS+w4bO0E+yRL7fsVs1Yra
	1vNHYqg==
X-Received: from plblh11.prod.google.com ([2002:a17:903:290b:b0:2e8:7c73:6eb4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f547:b0:2dd:c100:a5df
 with SMTP id d9443c01a7336-2ed41c097afmr8522315ad.51.1793914147474; Thu, 05
 Nov 2026 13:29:07 -0800 (PST)
Date: Thu,  5 Nov 2026 21:29:00 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105212905.3122712-1-kuniyu@google.com>
Subject: [PATCH v1 net] net: Fix memory_allocated leak in __sk_mem_raise_allocated().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__sk_mem_raise_allocated() calls sk_memory_allocated_add() and
reuses the return value to check if it was called.

However, sk_memory_allocated_{add,sub}() cache a value in per-cpu
counter, sk->sk_prot->per_cpu_fw_alloc, up to sysctl_mem_pcpu_rsv
before reflecting it to sk->sk_prot->memory_allocated.

Thus, sk->sk_prot->memory_allocated could have a negative value,
and proto_memory_allocated() returns 0 in such a case.

Then, if mem_cgroup_sk_charge() succeeds, sk_prot_mem_limits()
checks are bypassed, and if mem_cgroup_sk_charge() fails,
sk_memory_allocated_sub() is not called, leaking counters.

Let's use sk->sk_bypass_prot_mem instead of allocated.

Fixes: 7c268eaeec63 ("net: Allow opt-out from global protocol memory accounting.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Found this while converting sk_memcg to obj_cgroup.
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e2401d735c5a..ad414878dc5b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3427,7 +3427,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 			goto suppress_allocation;
 	}
 
-	if (!allocated)
+	if (sk->sk_bypass_prot_mem)
 		return 1;
 
 	/* Under limit. */
@@ -3508,7 +3508,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
-	if (allocated)
+	if (!sk->sk_bypass_prot_mem)
 		sk_memory_allocated_sub(sk, amt);
 
 	if (charged)
-- 
2.56.0.455.g6c5a503b38-goog

