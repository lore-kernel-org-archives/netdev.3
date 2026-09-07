Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7F43CE4E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818338; cv=none; b=hAZqZIM+Yz/iAt8wV4egWHpOfIH3/an8mnCnai0UM8pYVFFX4oyPg9m/xEruvp47ln5Ndo1/glJGc/Lz04fkKpO9eqBpJuCZ9vXvRC2PS9Ka7y4C6A2tMcZw1rlFeoqao7gX9OFxnS8uq2GZ0CPtuiUd4JYW66IqfYFqgHHtr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818338; c=relaxed/simple;
	bh=4kRTvUIP5xrgxvfiWig46DrOjm3KAGteGiFISzpX4o8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NHgKZzGWBCX+0WYKcBcbUxwAAI6QmAtarft+mhd4T9DRJVo8UA+Unol8+apa2cH0rI0V1+/DX+wMTegWwtdRn0nxOBLS6GtTc5rquK66+lRX5aQy1szXqiNVigWww/th/TdHDghdzLh6Z4NjOtzHZnpi2v4rSZXgNPAt6m+JQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTfBLNDg; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTfBLNDg"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so4918317a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788818337; x=1789423137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/niKzSDY8TtvzULkW48ERULsof2DyAXi6+5XOojw88=;
        b=rTfBLNDgI+3JCNLx9YLYeOgBiPuqYZ2Wg5j1Uaao97jSMGcWAfUO3LovJ9w1RwzUG1
         HfnREoMvp4KWSIJPpL62D4K1lZ25iue3Rkk60ePHxKmoe20VwVMqPeAKf4ncwIS8If75
         tf5y4KPPRc1xYNkvm3VtT46bBijj+LbGcEbpJ5FdKagFul36Gwz7bqhpfTEVX+2eAyEo
         1kEA+1xStbuzjxnDX/2CpdIJwmdcGh+sL0zmtDSR2b9E7UgA88aixR4OyErKN8j+2xy4
         vY1Z5GOMA6v7ZhzX+7OJH0xrESNf13gLKLMQwi+6Tz1MQ4HxXvDBp/F4p5+H3KKg5BkT
         Um8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818337; x=1789423137;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/niKzSDY8TtvzULkW48ERULsof2DyAXi6+5XOojw88=;
        b=IjLmIUXHULBdG9CPjVg4TZLKgSrWT7HhJjFKnjUdYAWyg2yNHNgZzdpytSg/JPJtf3
         iJRDQakHmuIqTu9gvuDPfsueQ+HocLSFJ5sOfuptPfzUf8SWoYdDgm/na39hdL7WD3Qf
         jYpJyrIPA5xLR2tsg0NQ2dynzkvI5YhY2KNhEGIEjttZ3nej6yc03h9Qz651o7R48aXN
         QDFcUx9LIMeP23G9uppFhCxG9c4JI9YwJWnEneCDbY6PZRei27vGOVzXzHMdROK79b4p
         gyp0+gsbhM6GhcqnVXw6/355nFbJKOyEKkLMJnasUrxxXqVAfA56/U++GorHI8nx9skR
         SeZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnhff6slnJB1UbPU/Vbk9gBWY/TUiL3oCV9j4gmp1almQDHBp7bR1MWJeSodmYLihKD4AypqY=@vger.kernel.org
X-Gm-Message-State: AFuF++lilFpiftUU8dCGswMfUn4m9wUL62HQx5Xa3+g8BTwKR1b7+ZNK
	heV2ZV5t067c/CZRVkyZ9PrdXYJ6qO6Utf8vp5QvWf2gowglYfkR9JOgb5JxVQjHXXYjgKNPmii
	NDAxb/A==
X-Received: from pgar19.prod.google.com ([2002:a05:6a02:2e93:b0:cc4:3eb9:12ac])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4387:b0:857:726d:2e9b
 with SMTP id d2e1a72fcca58-8616b467fcemr36402863b3a.24.1788818336621; Mon, 07
 Sep 2026 14:58:56 -0700 (PDT)
Date: Mon,  7 Sep 2026 21:57:52 +0000
In-Reply-To: <20260907215853.3709987-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907215853.3709987-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907215853.3709987-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/4] neighbour: Add missing RCU annotation for neightbl_dump_info().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neightbl_dump_info() fetches the first non-default neigh_parms
with list_next_entry(&tbl->parms, ...) and iterates through the
list with list_for_each_entry_from_rcu().

However, list_next_entry() does not use RCU helper.

Let's fetch the default parms with list_first_entry() and
use list_for_each_entry_continue_rcu() for iteration.

Note that the first entry is always tbl->parms, which never goes
away, so list_first_entry(&tbl->parms_list, ...) is safe.

Fixes: 4ae34be50064 ("neighbour: Convert RTM_GETNEIGHTBL to RCU.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..4b17c2a15594 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2611,8 +2611,9 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			break;
 
 		nidx = 0;
-		p = list_next_entry(&tbl->parms, list);
-		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
+
+		p = list_first_entry(&tbl->parms_list, struct neigh_parms, list);
+		list_for_each_entry_continue_rcu(p, &tbl->parms_list, list) {
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
-- 
2.55.0.1003.g10538fe699-goog

