Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AA49A3AF
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062652; cv=none; b=YNO+NvJXRZMfrkRhAMFwy7aBKObK9Qrewi1Rya2j6sQuLRTgKK7EBmKp3+k5a0ojwf4ZrVJZLvX1Nod98a9DIPLn2/yQfNYSnPDRSyYn2Z6fRjcUdDo7fMJFcQ90mAdFpnixkiEAPK+zhpvTB1+9c9peEjO6SqryQEH8VY9k+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062652; c=relaxed/simple;
	bh=N79/n1ZvbHX4mfom8pI44n7jL6qS2PZwI+FHPyDnrOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hBQwDNf9JjqjCOxdAGjjHgU9CS3pOazTnNYSZYMUWfdH3pZ7OjJVupe35IegN+64owcUz8gsErbxgmttr/J+HnmPLsV1kgtd/3TFcOyGCHKS/riHvIKd5CiJLIiMzWTP3gxQN+hLDeIMUuCxEo4IQ6nVKWTyWLN5v9b9GMUm3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTfQ9KFJ; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTfQ9KFJ"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so397926a91.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062650; x=1791667450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G9GxU2xgcM1XufCxG+xkaC7kE27M+8TLX7JfExdPFgA=;
        b=eTfQ9KFJuC9QzaUUYfc01zk69FnKTjN6KAQtD/0t702/kcPzvHOPHSeUmA66UdPxpQ
         BCdW9uy2aUnumDDAQY26jhecoxjsybC+jZmZrdk4l8JXfQkQZYNO9jDcVXTUe0ZBurt3
         nKl21AN/qT9pmaE38cS7GQs7vmvK/3CnMSFmM+lxwrYi4JtVIedTpQesc4BhVHLPQae3
         nFGX36e65DBV9OKOtAIcs5dzAgUbfgRJr3w7ZnDmxVHdJz9cYWpUTKwyBMWKp7wtydcM
         4KfljqUFbIbZhTgbi4vU+wEifJ8ckm6Qi8LCRjLd6QOw8rqNJyegjdNAAzTQuJAa+exV
         2yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062650; x=1791667450;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G9GxU2xgcM1XufCxG+xkaC7kE27M+8TLX7JfExdPFgA=;
        b=jadvKydR0XLPEygE6g1oFWRiGDq38ktw9KOHGV12D0eZGA/cBNom8aEahd5CqQKJMm
         4HjwmO0/eWpYtgBkISw4S0sJDwqBkTK3dhQKDBC9ICLt9X7QS10C3ZglaseOHX+lsoy0
         PrLO77GZAtKahEDpxovnnpYuvIN1rlci8kRUQt731eiP5uPaz9k86NHe1Wvm6wyyMmMI
         E587wNZ/e7qNCCljhFtJnxqBCvXZAkLcy7XUGMXtLX+t6hvhKSd1d7+s+j6z6kXF38Lq
         17Ex85EOiWs5BVRvHyHnrjbCxIZ/bqtn2Dmn/GCeDNTEQ/89CMCsEeItfL60LP0Vw5qJ
         4zlQ==
X-Forwarded-Encrypted: i=1; AKwUvByVCi9S0fFuyUxnTaeE6fzFS+BnvMlt4Mu+kzqqkHXU4zc9K6ElIkOzgrbvpaI2Mc8gUizXKq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwGr2nsgzzNn+s4RQMYNBbN0sDL8KYePh5ZNaXYBBQCGgrNV1e
	U130vMwhEoUC4kjssQCXV/7H9uVVdp2g/8ue1iHIwwVw1mFiDTYg+CF8oDoUxpG6PuuVLxOpxKc
	kQ9DRnA==
X-Received: from pjzc8.prod.google.com ([2002:a17:90a:e108:b0:3a4:a19d:1090])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54c8:b0:3a7:7e9d:c27b
 with SMTP id 98e67ed59e1d1-3a77e9dc7a5mr1348235a91.12.1791062649927; Sat, 03
 Oct 2026 14:24:09 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:22 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 9/9] neighbour: Check n->parms->tbl under
 tbl->lock in ___neigh_create().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, netdev-bot+sashiko@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported that if ___neigh_create() is called outside of
RCU, it could create a new entry for dev in a different netns
while __dev_change_net_namespace() is running concurrently:

  creator
    ipv6_neigh_create(dev, ...)
      tbl = nd_table(dev_net(dev))   <- old netns
      <preempted>

  __dev_change_net_namespace()
    NETDEV_UNREGISTER
    rcu_barrier()
    dev_net_set(dev, new_net)
    NETDEV_REGISTER                  <- new in6_dev

  creator resumes
    neigh_create(old_tbl, ...)
      ndisc_constructor()
        in6_dev_get(dev)             <- new in6_dev, live parms

Let's check n->parms->tbl under tbl->lock.

Fixes: cda2962b6e2b ("neighbour: Namespacify neigh_tables.")
Reported-by: netdev-bot+sashiko@kernel.org
Closes: https://lore.kernel.org/netdev/179090663305.434549.17214258093385242325@kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0d883c043956..90335895b415 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -690,7 +690,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 
 	hash_val = tbl->hash(n->primary_key, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
 
-	if (n->parms->dead) {
+	if (n->parms->dead || n->parms->tbl != tbl) {
 		rc = ERR_PTR(-EINVAL);
 		goto out_tbl_unlock;
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

