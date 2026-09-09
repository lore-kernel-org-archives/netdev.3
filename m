Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4EA395ACA
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996707; cv=none; b=VPKwIDvAOrYDSgUAKQfND4x0zTegiUd+ezs2sx+q0tRqTqUtFBo9VyGGbogTtm3FuKuTPbGG8BNf2CNVPMS/xpmL7A2KwqkSNZO8mxuBgSavS4FJ9bXw2/BZgF3Tvgpjca/sG2eG39/ia8o0I2j3aoYfIMyVuJRHXWjv099TolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996707; c=relaxed/simple;
	bh=FFsX9aEfPiqhu1HYC7dl7/3Wuom2iIf3o9LVF5LzoWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TlmwJXsCITD0B7QB5KTisMTvT9cQk1phabG5RbaA+EJnwkXN4PbLiJVr+A4yo2b+atPv11guMxzWbTIKtM/7nUG7sQiAu11sLtC1M78vpL06mshvyy0GLLSWYIDnvxSafvcfVLKE3dtefbkSjMmjWHxo+ORf7oVMx9sRq2QzqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+CSlK1i; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+CSlK1i"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc39363cc88so6701748a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788996706; x=1789601506; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTlonvPA4nxXqMEPQKlVBNQhp1E9YHM6YUzSy9JJULc=;
        b=r+CSlK1iiA8SbhN1JLL91u78oVbuvwaCO5IwAbbqqLTGNcZe5iH6fqRDoJYf3L9yxn
         zrENs+AlbYZqn8SoS1gGVuVfgSv0ytRTl5oS8I+wIS4t7YRrCQXPjISCkN3OkMP4Rb7l
         +dQZtGuAb0woP4WPuicEqr+Tw2USLz61N5+3cPwCzL7AH8Yx4CFyiKwZzNzTf/dSiqxL
         efULEgqQD8ykSupuoV8fII/OzLRShc4qs2CcsFGKScybM7I57Ubqzn5k1rCYUrL/AkZ3
         NnOFcDxq9RaylWtIJSVLdUGrmxcyggOpyXSqBE35Kq1AM/bVAzb7sE9V5TMfmgysVFBo
         J+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788996706; x=1789601506;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTlonvPA4nxXqMEPQKlVBNQhp1E9YHM6YUzSy9JJULc=;
        b=k2/BkMzaSdIIz4IknqaXBrGohqsw44IXks2W6Pqy2UHOC/xxIi0TVWfNIZ0HRCi1z2
         VgOBdqMRhVN5/GH/H3LBDmgUCkT5BzZXKQkP8z7LmQeZxiPPjYdNpzsl6+sCDZaxKTD8
         i9mYDPOJ4iYDrGhyKrpqZQxkg1ruB5cCKq+jTNvw0sWfJ5ahpTfm+Ye+ck+47sZnfWkU
         5oMffpkY2GeDM9GFrjSmdTn1TjM524FLi1xSG1olVbXc3RIo289+rSELGMMF8rshc6KN
         mRx8uUFfVAWNTQALQ4D3XqDgjdYodPA5occlwr7QemEXYPO8cbG4DqM23051hpmDCBhd
         G9wQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2s8+NHIZFUPqPW5bQoDCbFj5GUxMAxs0eVERURSHOuL8HG8c3FqVeX4gumQwaony5a5uJczA=@vger.kernel.org
X-Gm-Message-State: AFuF++mKsGfEJIZmc3Pz56QmsaBe7sn5nAJ8OFP0P+smfHAO/sNmTiwl
	wJ0gWsdCmnnigklRrunQCZFGm4ndOKB0LDYh09CTFxs6Pl3IMrsbAItJLqju9IgvcT88HTTobE7
	zwXFviA==
X-Received: from pfqf13.prod.google.com ([2002:aa7:9d8d:0:b0:847:9472:cf8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:48a:b0:3d0:c5c0:d9b3
 with SMTP id adf61e73a8af0-3da39ff0220mr62226915637.18.1788996705549; Wed, 09
 Sep 2026 16:31:45 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:31:23 +0000
In-Reply-To: <20260909233143.2401847-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909233143.2401847-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909233143.2401847-2-kuniyu@google.com>
Subject: [PATCH v3 net 1/4] neighbour: Add missing RCU annotation for neightbl_dump_info().
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

Let's use list_for_each_entry_rcu() and skip the default parms.

Fixes: 4ae34be50064 ("neighbour: Convert RTM_GETNEIGHTBL to RCU.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
v2: Use list_for_each_entry_rcu() and skip the default parms
---
 net/core/neighbour.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..49dd7df149ef 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2611,11 +2611,14 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			break;
 
 		nidx = 0;
-		p = list_next_entry(&tbl->parms, list);
-		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
+
+		list_for_each_entry_rcu(p, &tbl->parms_list, list) {
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
+			if (!p->dev)
+				continue;
+
 			if (nidx < neigh_skip)
 				goto next;
 
-- 
2.55.0.1003.g10538fe699-goog

