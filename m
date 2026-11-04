Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798269;
	b=BCXPHfKSqFXxTXvoeyz72Z8PSULIiMn6JA/HgYtCZV7gjR5rWI7cv6XxcsyS/9VSvIjE
	 Iz1XJmXc8BzoQEOVOMtLP4RxBBENRVE5pQjBuQDHedjQNN8A4MpwbzqKk7RV92To5dn9i
	 rv78QABjEpiGoWJWQaaJcaw4CCHihalngO1AR0f2e3WTCcyD70vwWaxVW5my+LkpEEmBV
	 lsMtHsfl4r3q2hRq6D6KHP4ozuy+5jpxtB7ImMPWgB1Bzp2xbYslv9thOmM/QeV5vlMgl
	 YIEElD1nviUg2Khlr/idBycDCj1dSMk+NyPV9GCHw4vAGKt6Ges46BcHIU+aZhSXzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AdsRuRBv1q0efjh9PWzRNkus3LcWHxPayL2UonP+dDg=;
	b=KJT/UMfxERkzPdefDaNfW6AasPzuVl6V1cfTUcB2IA7twaS7AMo22lPjHNURueTf4puQ
	 RicMAqJdDYLkzKNsQh75EWL1qScLRtblnm5Sp8muLbVtGXwrJEsBfP2wAaOxYkaAAAM5p
	 7J+UVrHYeifmC0eub2V3uN/mMPg0daWMdYynwDvc1txaZSqej7kcBNa6btmuXipwecm9n
	 hyFKzy2tFrHTl0Sb3mwgHuMdBas++d1LOeQU0+fombLoOYVSh5wk6Jd7Kss12TRWxZ/jG
	 oWf6XUXt6OKPS+bSVbAvIvEtw2YB/cfmv6r9he6ioYQIDu9dt4wzmYiQPkKgKgvQOhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtP+fJPt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27E606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtP+fJPt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD161F000C1;
	Wed,  4 Nov 2026 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798268;
	bh=AdsRuRBv1q0efjh9PWzRNkus3LcWHxPayL2UonP+dDg=;
	h=From:To:Cc:Subject:Date;
	b=RtP+fJPtsN/e17Su/gXzm2+A2oLPAQDLVf1Nl5hCu84JPBJq0xRhsJ/gq/edqe/RB
	 1Vr0LMLlPZ6Ca+3+Z86XYG3BMn5fevKmZRp0dkbPBpahZylkFtxb1YPUVGkv/tbqzy
	 ey+3ACNQSmkYZ0tTH2KLFCdintE4lSKS6LMZ30YSOO0kFMyS1buJsbrrCsJnHhs6UR
	 OCLsJyYcahm1yMD0IvlXiZL977W4Y/B29edoXlppGY6d/mgdbwKfdJynfEoAD8LA36
	 2e33/o1AxdaLreZyHe/IaeqXHDnBmE4wcnp8A1KX96fmE8ZfNHdq9sGJYrQJEuruPC
	 E24lAEkoeIf0g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net] net: protect negative destination advice with RCU
Date: Wed,  4 Nov 2026 14:17:44 +0100
Message-ID: <20261104131744.1056562-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

SO_CNX_ADVICE calls __dst_negative_advice() while holding the socket
lock. Connected UDP sends can still invalidate or replace sk_dst_cache
without that lock. A concurrent sk_dst_check() can drop the final
destination reference and allow an RCU callback to destroy it while
__dst_negative_advice() retains only a borrowed pointer. This can cause
a use-after-free while accessing dst->ops or running the negative_advice
callback.

The writer-side ordering fixed by commit 92f1655aa2b2 ("net: fix
__dst_negative_advice() race") does not protect this reader from an
independent cache replacement.

Hold an RCU read-side critical section across the lookup and callback.
This follows the datagram release callbacks and covers IPv4, IPv6, and
XFRM advice without changing cache-reset or reference-ownership rules.

Fixes: a87cb3e48ee8 ("net: Facility to report route quality of connected sockets")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/sock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb..0c1a6895d347 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2218,10 +2218,13 @@ sk_dst_get(const struct sock *sk)
 
 static inline void __dst_negative_advice(struct sock *sk)
 {
-	struct dst_entry *dst = __sk_dst_get(sk);
+	struct dst_entry *dst;
 
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
 	if (dst && dst->ops->negative_advice)
 		dst->ops->negative_advice(sk, dst);
+	rcu_read_unlock();
 }
 
 static inline void dst_negative_advice(struct sock *sk)
-- 
2.53.0

