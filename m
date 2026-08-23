Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5501E33EB06
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505209; cv=none; b=IECPWt4+z3TDzoSylqj3ebmke3gjGhEuoGndUMNDXDDwXjodz/B2HpsSFEUwSaQIfOZDcBCh0Q8A84NOgdSsygiRUQYd5np9DSzxP8ZHQySA2Di8n704YlICX04GfDGG5VDIcqfEIgbrPiAfbKRTcQtAP6+1SqUK5yGzhaHGmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505209; c=relaxed/simple;
	bh=3jSiq+FO/4/9/VRkAbD3H5MfrUkpE36IgW2CPhZQQWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLMBOJu178iOHVhXZui5RnkE+yF8qb5d+X9dwilWGSmW6G30yEKxFltmfLAD5+Ib4V6mSQimwXoFzYM5ZTmOjnZF1YadKyiNDmTp9JIhFemNBm5qwBvPotAJ++z47R3rgfK7nLrvlofEz3rxQ15M2J5tg2qZuibY7ZiQS0m2JAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e04F7x2v; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e04F7x2v"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66cfa67ab9bso87286d50.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505206; x=1788110006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hDQw1kvEsyYloAFpXiqHj/OLCldDy2zpyWy3P7+rHDs=;
        b=e04F7x2vre18WzASfM8A8UTA30auCA7kkv94bokUpwmoQ2jppsbKGVvaF4vJJ+MZM0
         nViFBBWZciztYTvpU11s6a1XDVWDZi5E0GDb48dVQo9Vb3zjdwjy1bR/9TcQeN5tMU+0
         h0hnVwt77ProPjn03Lx8vrvHldsWE5zmWr4PyEEzasjsM8a/wbpNq/OAfT62q/JkHkbB
         tU2jbt2dQyLu5eLwGfgYZM/HLr4yjP8comzNL4SprUgdL438ynK2zQhtqjSUq/B/rn8m
         2CQy7j3Ly8o47cp6zQxglqPF/L2v62QnapB6YyjkTRimXZP9rj629sGTMc12CUWWiZZP
         gaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505206; x=1788110006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDQw1kvEsyYloAFpXiqHj/OLCldDy2zpyWy3P7+rHDs=;
        b=hL9bKkziezCOsl3YPX2WIBF3TE9b9V+TiBzzBu8niWRn5MsDT0tJreEPIoyxF4hp9L
         LIONg0qy0+y+oAgI9YoY+M0ZI5ntkmEXw5DGwwlHodH/33GTFztMjq0UVnUrlY7hC+jc
         p3hn5a8fP2ro5j3m0G33v3ScWMgLtGnMEnvAcNuYf9xrv5s8bycc+1ONBF0D4XRw+Dzv
         IvShPQ/Y6bChor7OXm7zV6DdVwcJMKA+NWs/JmnoNeCVGVrJ1oAC9o1UpBxY67fm/42J
         heqPG7kKKYq8V8AvvMuZmXWRPd0aZL6dMduAsgWuqQAfghYPOA6SOI9PN15oqWEZgHnc
         sgQQ==
X-Gm-Message-State: AFuF++mqRcSCWGk3O5k3Yf5MojKZ15diwp9GFR2eUYy+xB5z+cewTa3O
	WH6hcFVulLA/gKvMrK/vucs9kLfMW3KBTyQZfVE24g+NmqbppQWp+oEt
X-Gm-Gg: AR+sD1310sXmwEuHAA35TDEjdcaiV8WKxNSmcCyWR5dEdHTwZm8upfok9fUpbmjAp/R
	W/xjzu/9+skWfoTQSNOY8XUILA0KiNZ4TPrW9DD5pCfS8tpQDpwJR88A0zIadunoxYtUbJJptJz
	qT/v5cfiG45sGZJEjS9RAvCO9bG+lz+n6Y3E9HxBKXuTCqoQvgdOFk5hBzc07ZGvgOBoyO15Rs+
	XgsXMNpYpODxlj/qMTHZwP7oDLemBju0QCNUsvuF9av2osa7dwJSuWH7TEsdTElkc2R6tZUMmUg
	PD3NzK58fN3ozMPyGlv4dF1m5EiBt5Nh5t8ig5p3iDRoRoFgkuU6gTym8nF68paJoOXGP52TwhE
	GqZnzBblfkhQ438r8ABXBrwls7/TsQ0HKuw1GIBZGIbtVIM/vzpU20v0vmAeflNSiWHMjZpw0gn
	DBF0CFLnfw0FaUFcMDQxwsk86XSCLzzHxqhWDWUIhwbJUDiXJq5nrNp6fEZ23kc0MTo/W9bMPBo
	RecRwx6HdRPtlTCj+ZAP9c9yRuZh1d280W8K7lXwfysDvVU9LKkGtc=
X-Received: by 2002:a05:690c:9b02:b0:80f:3e90:f021 with SMTP id 00721157ae682-849f5fe8a53mr63778107b3.4.1787505205972;
        Sun, 23 Aug 2026 10:13:25 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caabb8b67sm22212627b3.25.2026.08.23.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:13:24 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Frank Filz <ffilzlnx@us.ibm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net] net: pin protocol module before socket allocation
Date: Mon, 24 Aug 2026 01:13:11 +0800
Message-ID: <20260823171311.3857087-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_prot_alloc() reads prot->slab and starts allocating the socket
before it gets a reference to prot->owner. A protocol module can begin
unloading after its protocol was selected but before the reference is
taken, allowing this interleaving:

  CPU 0                                CPU 1
  slab = prot->slab
                                       proto_unregister(prot)
                                         kmem_cache_destroy(prot->slab)
  kmem_cache_alloc(slab, ...)

kmem_cache_alloc() then dereferences a freed struct kmem_cache and can
crash or corrupt memory. The kernel reported:

  Oops: general protection fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range
  RIP: kmem_cache_alloc_noprof+0x63/0x370
  Call Trace:
   sk_prot_alloc+0x74/0x2c0
   sk_alloc+0x2b/0x6c0
   inet_create+0x2cd/0xd40
   __sock_create+0x1c3/0x430
   __sys_socket+0x116/0x1d0

Take the module reference before reading prot->slab so module removal
cannot destroy the cache during allocation. Drop that reference after
freeing the allocation on either failure path; on success sk_prot_free()
continues to release it as before.

Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable protocol modules")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/core/sock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25..59f4b15fd594 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2240,33 +2240,34 @@ static struct sock *sk_prot_alloc(struct proto *prot, gfp_t priority,
 	struct sock *sk;
 	struct kmem_cache *slab;
 
+	if (!try_module_get(prot->owner))
+		return NULL;
+
 	slab = prot->slab;
 	if (slab != NULL) {
 		sk = kmem_cache_alloc(slab, priority & ~__GFP_ZERO);
 		if (!sk)
-			return sk;
+			goto out_module_put;
 		if (want_init_on_alloc(priority))
 			sk_prot_clear_nulls(sk, prot->obj_size);
 	} else
 		sk = kmalloc(prot->obj_size, priority);
 
-	if (sk != NULL) {
-		if (security_sk_alloc(sk, family, priority))
-			goto out_free;
-
-		if (!try_module_get(prot->owner))
-			goto out_free_sec;
-	}
+	if (!sk)
+		goto out_module_put;
+
+	if (security_sk_alloc(sk, family, priority))
+		goto out_free;
 
 	return sk;
 
-out_free_sec:
-	security_sk_free(sk);
 out_free:
 	if (slab != NULL)
 		kmem_cache_free(slab, sk);
 	else
 		kfree(sk);
+out_module_put:
+	module_put(prot->owner);
 	return NULL;
 }
 
-- 
2.43.0
