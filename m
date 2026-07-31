Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769E44DB64
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515402; cv=none; b=Pa+xM0WQPUOEPNvv3N3e8wNSonUpFD6NHOIC6QYx/+Z8iq0ECOfdM/HQYsWdpIGxizW9pN6gdqZk33xZldSWtcTimRglbWUpOjZkVx3f9Xy/iaIEgl3sGAOZyEaVUONPimvUPT3MjDZIh8YpD0ACDoeSkcCJVX8XStv+PlLM+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515402; c=relaxed/simple;
	bh=jGDarGoCosi22LNoT8W76BEldiYKRotoaVhCB39/8xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bq7vUlyzkLkcDtpU6HYkwIDcTcAyxNvwHUf5FbPPdp9CGoeySgSYBiRVtr9i76DGqLvbyVDrMoizBdnLN62nnNJf4+bNfQfG/7JyKdN8y4yt9Q1sfcD9DIKB1Jt2W8uywJVbc/7aBQAnpJQgA3LqK5VFDSRj033lASb/Nk7/yC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9ZfZfP5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9ZfZfP5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38f0f3c8da5so141579a91.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785515401; x=1786120201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sZ9QZ52VgaJYmqEYMkc9RIQ8PoagjOPOXOHcuoYV6SE=;
        b=q9ZfZfP53xqOnBRVO3sopnk6fiHMlFNNHbXnBHBPjxxc8BekzRzh7W9rzwlvl5cL+X
         bm3z1SALV3dX5gRCWZZv6NCfi4qDFiT0IjJQlX6aNMUv8gUAEalxaXZHDZQR3fCq25Wn
         S8M6a+l0cKi1GSrcHJylw/MYeSmPf+PJppPE6J7LKj9o5HqQ1i7lz1WqmvhTDi/Fbv8N
         rl7gnLXR8NW7xv6RgKiYAi9bNUvXdef34HLcGaUNwPvuvWZH2LUBh5S+rVIHuoeSNTuw
         EQuphtB9hJlFg7Uhv00TtR2TmfOkTLRMGB+wRRbX2yTkMxX2wC81R9OcGHg1ameLNHFG
         7LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515401; x=1786120201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZ9QZ52VgaJYmqEYMkc9RIQ8PoagjOPOXOHcuoYV6SE=;
        b=onDm7eg2LNo0xZ2FhAWIw6Cg96B5NhYXHF9HN4evqQ8pQrl90rrSmkEjBMhOCvfaWo
         obOXwVhuJpSPjNtpucrA2QpTakyoCBP9L9/Ro7VOjt5fx1fGem4Rd9G6RZPjwoY9QIwr
         MMDHaSC25Hi05S7rIeNqTOwT0DvizDoqzWIXCakB2Cv0c4SB+vaHXwYlrAQPDrO1x+Mq
         f32fYkLeEbJMPepjZYK9QBsdLmKgYU5jSpm20g/o9eOGig0C9PQeyGxfhLifTZOEzXWS
         /K22DMhfOtAO5pLnpEwvkdOlytGHHlyVAHntJRD6OzF2ZbVXwxYwFKAehrW0kG7t6yMH
         yb9Q==
X-Gm-Message-State: AOJu0YzVs4Li7VThS07XNvy7hjUjR25p6l0qlG3jbmOLBVy2xcJASZhV
	39Roy0wekQqFlQRHwwk40Ui0HyZ6q7rlyQtW8hfAQ3UqWkMnQjoP3veZ
X-Gm-Gg: AR+sD13+DXPzN+C0tWtaf8qHGjVhgSdfcNiGwjnv/xIiz/Vid0WUJ9bP3krMSB2VuQ5
	x1wgWiBvXLQY3JxAU55y5B0Vo879xWCXkeF1GWEACjWDiLDfkHVEzW1L4OUF4H8qY70T1KLx6Rf
	dD1Byjz2utfY0FfIHzq3xP9xggNHrra/K76sXUXU68vSyIvclDWI9NqYOKcbMa0utf7Z2krK6kL
	1sWk2mig4ZLP8SFqbYgSLubeJCNQ2j1scBW4bNt/O1wRKjYlhek3Fy1J++74eYoplY3gALa1EDI
	03TI2J2TkMU2Qj9eQxlEyEDfQSCq1dUWlbbwLq2LmNYX9qTkHYYnO4dKIO8tBiAaxoMjx1ZVoP7
	y2EzITVSoN6e0Hf3lscbylbvyARiotCfV1HVYLMtHR0FiWpNeIxAHV1eKIO+GDfTlK+u7RpTAJP
	lcidpP4PeHXmmWdKvbi/DqLN8PsNWjDrGdeyCw8Nk8+mmrMSwInMYbO5jBcvaHleFLJ3Sr6o5Ml
	7UqaRD5RehUoWXTnR4xU4G0Oxpm6gL9xTGsMA2YkhlzkHDiQwmgaTGG6pcGQ/s1+LYc5c+5J9O7
	IA==
X-Received: by 2002:a17:90b:58c3:b0:38e:ab3f:2c99 with SMTP id 98e67ed59e1d1-38fbc4c673dmr657748a91.2.1785515400659;
        Fri, 31 Jul 2026 09:30:00 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm4279637c88.15.2026.07.31.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:29:59 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] ipv4: fix use-after-free in fib_nhc_update_mtu()
Date: Sat,  1 Aug 2026 00:29:38 +0800
Message-ID: <20260731162938.3388534-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
RTNL does not serialize this walk with PMTU exception updates. The walk
uses rcu_dereference_protected() with a constant true condition without
holding either fnhe_lock or an RCU read-side critical section.

The following interleaving can therefore occur:

  CPU 0                              CPU 1
  fib_nhc_update_mtu()               update_or_create_fnhe()
    load fnhe                          spin_lock_bh(&fnhe_lock)
                                       fnhe_remove_oldest()
                                         unlink fnhe
                                         kfree_rcu(fnhe, rcu)
    <quiescent state>
    access fnhe after grace period

KASAN reported:

  BUG: KASAN: slab-use-after-free in fib_nhc_update_mtu+0x3df/0x410
  Read of size 8 at addr ffff888107d49000 by task poc/90
  Call Trace:
   fib_nhc_update_mtu+0x3df/0x410
   fib_sync_mtu+0x7a/0xd0
   fib_netdev_event+0x229/0x3f0
   netif_set_mtu_ext+0x33a/0x570
   dev_set_mtu+0x88/0x120
  Allocated by task 89:
   update_or_create_fnhe+0xa80/0x1110
   __ip_rt_update_pmtu+0x8f2/0xcd0
   ipv4_sk_update_pmtu+0x49e/0x690
   udp_err+0xd92/0x1080
  Freed by task 0:
   __kasan_slab_free+0x43/0x70
   kvfree_rcu_cb+0x12f/0x420
   rcu_core+0x509/0x18e0

Protect the full walk with rcu_read_lock() and use rcu_dereference()
for the RCU-published pointers. This prevents reclaim from completing
until all references held by the walk have been dropped, without
serializing PMTU updates against the entire hash-table traversal.

Fixes: af7d6cce5369 ("net: ipv4: update fnhe_pmtu when first hop's MTU changes")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/ipv4/fib_semantics.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..6ecc6654427c 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1879,16 +1879,17 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 	struct fnhe_hash_bucket *bucket;
 	int i;
 
-	bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
+	rcu_read_lock();
+	bucket = rcu_dereference(nhc->nhc_exceptions);
 	if (!bucket)
-		return;
+		goto out;
 
 	for (i = 0; i < FNHE_HASH_SIZE; i++) {
 		struct fib_nh_exception *fnhe;
 
-		for (fnhe = rcu_dereference_protected(bucket[i].chain, 1);
+		for (fnhe = rcu_dereference(bucket[i].chain);
 		     fnhe;
-		     fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
+		     fnhe = rcu_dereference(fnhe->fnhe_next)) {
 			if (fnhe->fnhe_mtu_locked) {
 				if (new <= fnhe->fnhe_pmtu) {
 					fnhe->fnhe_pmtu = new;
@@ -1900,6 +1901,8 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 			}
 		}
 	}
+out:
+	rcu_read_unlock();
 }
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
-- 
2.43.0

