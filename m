Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA0382287
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419042; cv=none; b=GxViJgHJBYucxqUkglNM5cjokigiANwG7U58Dj3XYNZx1V7IYkzynHcTFCgG5iWXmGaCsLpkKcvApDZ+pXbUTgTypq3+X6pJuW15WLp6tBbkbn/cgyC7GhELLNGaXMOF71iB1SX6Dt2YIEGx80kS5aMlj7yzQBCMVGpXkGmLkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419042; c=relaxed/simple;
	bh=7eMlGmFaqMGm+HHVzDWIR+mgIhi73HauiaZs45xeWx4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HVl2AIVoW7nQcBBEF9v6wvkZ+Mn57riKStw4rNS3NBhPl0DGdoysBYFnNbPPVaRxlD7ToJcREnkD1Oj5hvi7u9Ganh0BIwnrVNvpYNgjnzKDWX7BA6ND8ZL30bkOMky7w4bVyhpTiGM2IO5ghZQAYWER7fJVJrZjQvocCRL44GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cwxt8lch; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cwxt8lch"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9156cb14b1cso354534085a.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780419037; x=1781023837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TajIYzrLGZgS2BCjNwAujadaw0bJ+tFhUrgeiG+ry8g=;
        b=Cwxt8lchZmjWarNr0xmABXx2s12drqFme/v/Yqtke0fHmAGkV1B+yrLUPTl3J39ByB
         qltppVfQIKXTobmM0WQK8itPI99nhRyKImVRg+Bh1NXOT/VoNEXvxmU7HCXMdt2qUMbq
         KdWRLAgt95B4ICOGF4N/lopiYQIX12bG0U6MGxnj1G/8K8DxtsZO9MquS3L0aPWWIFZl
         k+QAYHyv9GkKovD5OizWRSKKb643QhFK6E2Bq28YjYwby2s37x5dpbntiEb0QYs3ec90
         FSjF7QU5hXiNnm1IMJShgVace9aGp5obrU63Kw9sLm/qoRqrWRNABKa7ZnSGDcSQ3Xmj
         Y7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419037; x=1781023837;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TajIYzrLGZgS2BCjNwAujadaw0bJ+tFhUrgeiG+ry8g=;
        b=tIUb+hAa0TaEzrRJQ/wzI7MA9JCXwYvHVKfZ8jv72Lg2HU4TkGkbdMtyFLibnhVnab
         1XUfqjwgM4FGPmBd8G9zuE98vlQlq3HIhOS9kRio2Lro6nptC6aXmi2vp0QqdKn1dcUo
         +EgYhsVwyi4PVMgue9uEmNIg7LkpyLvvgtZ/Bx+foGU/caWjLVU0iXmRn8DDUjSpUmGS
         kdtw2RXsV+O1f1USOHtILeY10Eawnh8H4XOkFKmH4tctVjsCbNJtlIKrMD8Q3s15xu7j
         qwMsoJULcfMg08KGRPD48evv6YSp5Sxw1rlAv4znk24YFKuch2+7AAGRJSXg75t9STY3
         yHTA==
X-Forwarded-Encrypted: i=1; AFNElJ/inBix68Lhah8bK7/UNGxUF6kp2i3/f3IKp5W0T22+fxrXHHHTi7Opw1qFzs0WgY9zGKrmbxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nuKTv0t4NPpDl7Q1AjT9cvvfNvEHPPgdhyU+m7Prx94gAmzD
	FMm773OYuenR0BK9wCZSXT8/Ljf+yOugEL/CV4c17692krAPFz/getVaXFeCwzWXIdGRGTzJrmN
	oxJjYAKsZqqK1TQ==
X-Received: from qknqp29.prod.google.com ([2002:a05:620a:389d:b0:914:babf:d7d1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:688c:b0:914:ea37:6f1a with SMTP id af79cd13be357-91589fc6d9fmr462585a.6.1780419036935;
 Tue, 02 Jun 2026 09:50:36 -0700 (PDT)
Date: Tue,  2 Jun 2026 16:50:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602165036.2712408-1-edumazet@google.com>
Subject: [PATCH net-next] ipv4: raw: remove six obsolete EXPORT_SYMBOL_GPL()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

IPv6 can not be a module anymore, we no longer need to export:

- raw_hash_sk()
- raw_unhash_sk()
- raw_abort()
- raw_seq_start()
- raw_seq_next()
- raw_seq_stop()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/raw.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 68e88cb3e55cbdfd5625705ea557b9d0f88c7a5c..e9fbab6ad9146315bf5fd8fd7968483c8d41bd8c 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -103,7 +103,6 @@ int raw_hash_sk(struct sock *sk)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(raw_hash_sk);
 
 void raw_unhash_sk(struct sock *sk)
 {
@@ -114,7 +113,6 @@ void raw_unhash_sk(struct sock *sk)
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	spin_unlock(&h->lock);
 }
-EXPORT_SYMBOL_GPL(raw_unhash_sk);
 
 bool raw_v4_match(struct net *net, const struct sock *sk, unsigned short num,
 		  __be32 raddr, __be32 laddr, int dif, int sdif)
@@ -928,7 +926,6 @@ int raw_abort(struct sock *sk, int err)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(raw_abort);
 
 struct proto raw_prot = {
 	.name		   = "RAW",
@@ -1009,7 +1006,6 @@ void *raw_seq_start(struct seq_file *seq, loff_t *pos)
 
 	return *pos ? raw_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
-EXPORT_SYMBOL_GPL(raw_seq_start);
 
 void *raw_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -1022,7 +1018,6 @@ void *raw_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++*pos;
 	return sk;
 }
-EXPORT_SYMBOL_GPL(raw_seq_next);
 
 void raw_seq_stop(struct seq_file *seq, void *v)
 	__releases(&h->lock)
@@ -1031,7 +1026,6 @@ void raw_seq_stop(struct seq_file *seq, void *v)
 
 	spin_unlock(&h->lock);
 }
-EXPORT_SYMBOL_GPL(raw_seq_stop);
 
 static void raw_sock_seq_show(struct seq_file *seq, struct sock *sp, int i)
 {
-- 
2.54.0.1013.g208068f2d8-goog

