Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680936;
	b=gjv8HIkdbDjAtMR/r20DkKoMqWWM7joIeDQBbxa4MV5A0yXjtGsY5RgtHtaOOjJavfCm
	 vPkH7Env6n/Tux7m51zQDgKm2iznqDj2/u9fZazz1sGi1khzo3iiyXGYyJ+MmfAYAG+Mp
	 ZqOuETHAWs0dB64bX4NyOLmv3GiCvWt7nVR9Tcf95urKx+6c4wrJNqoHX9nPtDRf4WEob
	 ENZ+UF3wLSjjP/2aVXc9xHxo0uNKP/Wr7XOO/R8B3FzV9FxYNMZ+dQ+xEjrcEIJGc9JwH
	 mwvKQwnfEYpMrzRI6eUwy+lHoJX5Dt596FHqVuUncwVy/esFVuXdPowwsMc3GowyATA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ybjWfspnAqdGGBNWr2dJAt6iizJ8PYeVMQvsdRJjBSg=;
	b=ge5LH3G1mRQStHtBDD6JVRdKVvlxB3Hf6M9I6preCJoVSD1WVsRU9tBW0gmzZnzk1f0V
	 uL0ub68u7LkOrqYb1mlw01ztRckguTl1s51CDfo3zsT5QzF4+1oXV2HxnM5BGlHRtzXg5
	 VaXOw8JBvuWDc7YIPUYMwNGa+m/W8IuCJomG/4G5ZWlA5w41G1QFmv8HkAtOzroDr106u
	 h8JAm/3KGq0oYx8n7AxSInX/ZnR3QV/P1k82zEA9T/q265yISfbvlC9QtiW3wU8KqLH0o
	 4lW8NLutmsk6L+bzwswxTgi6lEC1DtxqWA5YrpsNkpXtnwKIlHHSAT5gGfT/Iz4rKog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QMyMfVWt;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12D606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A12D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QMyMfVWt
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89e05d31e54so2529274b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 20:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793680935; x=1794285735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ybjWfspnAqdGGBNWr2dJAt6iizJ8PYeVMQvsdRJjBSg=;
        b=QMyMfVWtmS92oWX/V0fqS/vzlxoNSPG2JCAlzgPRoqK/SS5lLpT5vio1MhTmKgoG10
         1r/InManb84f5RSWzM7tqlg2t339xBEqrOZLSFHiZ8wLrh5nHE7J4RMXeD572MtMyptk
         SshS4c0NeqRIpFTo6JADkmUr3JLsz0A5fRFtpkRUfVz5WIQw6GpEDrUkREXRgwVwL4Ki
         xEhEcEnm1N5be31hiHUlSiMkVAQdYt7iqF6mrLzOlQda0qxIs4xGs1+TxLrYk8SvzmoP
         RKLvJmQYF+cHblONZOx7/llOKwJhvWJxfBlJa8ppUYDB/BGd67JDiXsW/o6DUjd0SZ2o
         B/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680935; x=1794285735;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ybjWfspnAqdGGBNWr2dJAt6iizJ8PYeVMQvsdRJjBSg=;
        b=gPHCu/hZ0D7adBGgKQcQFndvfrjzHH0miAO0Xk6YR7x+kChJA4crcyisfnUeO5AcZa
         wAP08vJ2LAdJFLU2e94l0colVdgbR9COy0SqMB+kvtY9S4v1Jn3D7kDEwF/b2r2Qd1w9
         dBE0lFDdAWO8DsXHWm9sRVRbeEkvf4rv4EQuEOO+VpfP2EiUcxxtwKrucGH/h8M0zZEH
         yDynxUYLuGnggG/e8J+vLC+5c4lDoPhDVAiJYapctcTDTL0qGaW+l9+Ax8h2W9ECAktF
         9zD/K1AcxGIadJCErCwtkpddE2ZWI3MkC3k2F1SbM6ZDeQYQyMhF345rT2hfkn3GOKNS
         SFkA==
X-Forwarded-Encrypted: i=1; AKwUvByb6Y9NC9FAkxaGxv+0GJ2sURhuj7AcGlyyqUAu6JoF9kFwRmmfGPyKb0W2U+rA6umVclqYXHk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5lVrCix6ydgwscwGZ9zs3E3iAH2A1H86rZfsJ1ePQUxH6OyAl
	YkiACifGblRE0iwZzSLVR6cH8a3XFtLFe+qgLTEEGr8kgjt6vI1Qk0kjZ40YvopXehRODdvuT3H
	UJqH8UA==
X-Received: from pfbeb25.prod.google.com ([2002:a05:6a00:4c99:b0:8a2:1bc3:8884])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a0c:b0:881:e737:8213
 with SMTP id d2e1a72fcca58-8a9ba806f29mr7630119b3a.7.1793680935209; Mon, 02
 Nov 2026 20:42:15 -0800 (PST)
Date: Tue,  3 Nov 2026 04:42:06 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103044213.1336347-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] net: Shrink skc_reuse:4 to 2 bits.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

skc_reuse now consumes 4 bits.

However, SK_NO_REUSE, SK_CAN_REUSE, and SK_FORCE_REUSE
are mutually exclusive and fit in 2 bits.

Let's reclaim 2 bits.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
This is to give a bit to SO_NO_RFS instead of sk_flags.
https://lore.kernel.org/netdev/20261031113330.45704-2-vitaly.zuevsky@gcore.com/
---
 include/net/sock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb..4c831eec2045 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -125,6 +125,7 @@ typedef __u64 __bitwise __addrpair;
  *	@skc_net_refcnt: socket is using net ref counting
  *	@skc_bypass_prot_mem: bypass the per-protocol memory accounting for skb
  *	@skc_bound_dev_if: bound device index if != 0
+ *	@skc_unused: unused bits
  *	@skc_bind_node: bind hash linkage for various protocol lookup tables
  *	@skc_portaddr_node: second hash linkage for UDP
  *	@skc_prot: protocol handlers inside a network family
@@ -176,11 +177,12 @@ struct sock_common {
 
 	unsigned short		skc_family;
 	volatile unsigned char	skc_state;
-	unsigned char		skc_reuse:4;
+	unsigned char		skc_reuse:2;
 	unsigned char		skc_reuseport:1;
 	unsigned char		skc_ipv6only:1;
 	unsigned char		skc_net_refcnt:1;
 	unsigned char		skc_bypass_prot_mem:1;
+	unsigned char		skc_unused:2;
 	int			skc_bound_dev_if;
 	union {
 		struct hlist_node	skc_bind_node;
-- 
2.56.0.385.gac671c819a-goog

