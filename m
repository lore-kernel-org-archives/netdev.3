Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063CF35AC00
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348866; cv=none; b=RtDeuh8NQ4tS8u9jVhBMQkr0wEg9qU7BKThDwyBqxxPMs/O1RtynuyGXtYDYTeYw9bnIFubvLPg+J8WMpRHVz+Vq/e282oLqg5RbelLxZ+32kXHOWj7XaV1EqnesTklGeYMlqVHJlnKspb4jKkr0NYVmwxowUVtCgQZDXCKNH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348866; c=relaxed/simple;
	bh=7scUbGGukbWsszs2PDSE+tTAAKfh1GDaFhy2/fY25ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcWxobBLKRDbz/26lXoB/1a+sQj7QIVblOLnzqKXHyLkwjLxyxzHwpNNLT//XE8n9Vp8BG9fs6Yf8beMilRM+ts3E7oAY3ZYBHy22XpYU8hk9u0lO3QRxxCkh+ijoFCFSAVw1/YaStdSXAS+oGLUs+drpbvvhAb/suVJeWK7hC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYaC8bQ1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYaC8bQ1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db710396ffso8699685ad.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 21:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791348864; x=1791953664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBd+OEzbKsaLTS0j2Uj6XjGnIaSZtWgAGMx+4GEFr2k=;
        b=SYaC8bQ1/W77VWvIidTExtP/9aWaT+JAlLRy0jaq6RmYM3XzgeAt1TREMyiUlZOiwF
         jdG2OT7jLeXwOvYypq20R8v3MMnHobZrrIPHNce6kyk0fIsybThnVvntilZV09gcz9VK
         1OfVTeouY3h1pExHpK/PoL1SiBxbrLj2+QO6rm7XOILTNCEEqphTx10gMgBXc94aeOBC
         C0W13v3kr1b3xCOIyR1UxbG4tCjoSlDQrd5rquKpavPi0XhPNUhMEdxrDkphblzQmIek
         tZiV8u7y1DFyMSVJkh+flLMCzA412Ekqv9m4X6bsmW9CfeQ1ganABuz1syYcd2PuBHvP
         F3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791348864; x=1791953664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBd+OEzbKsaLTS0j2Uj6XjGnIaSZtWgAGMx+4GEFr2k=;
        b=mm37a0rGvX+1nl3OnGX22il+LJptZ9nmvIbC54mSDEMaPhi6IKibDxfX8dFaFuWN8D
         3VKaTiXF12CqXpGtdIkBLqWh1W27Ofoa4GUFc4R7XgdqGwDJCWyuzl6yihXiMjfOPDdS
         ONkS42vIPrL3JK/kyN3LZXdBmC5RPrJ1F/wf6r2yc7BQu+ugVdhnkMuBz8Ujf4Dy2m3j
         AYX5BE5mApTdGTp/3QvjI3rjkbCfJ+4sXl82AAnvmAGkm72nauqDH+GeHBoirs6n8G3e
         relIVrVGKGC52oH2wLuOdOt2Rz4sIsKAzBDwqvaiXH/jERuo9+PLSaqJ/SaLvtO3J6uu
         4L9g==
X-Forwarded-Encrypted: i=1; AKwUvBzemoxSTFLsGiycCLFBPlQXstjcmLPwEJ13XrxY0vdvMNFFtPOdfWD72FCO6N/F1zLX1CbEF+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9taCH9YiKzHaGs7OKA3YGJ92t3oTz7bPGxeB29RgxxaUvmVTg
	kXK8uGxxBbKQyb0l8KO+aKB/mj/Y34taceODlo8Pt96v8Baz0BoPRLt+
X-Gm-Gg: AYBFou12OEnB30iFG7DD3wBfrtCrfwUnSTvPayIHL/78R1yc8OclOB8NO/xZHS53EZh
	Sm580NH2zWw89PjUIt2J3ruZztUR5Ko/W+HeG24DZjA6FSxnorMSWxvl5vicKegu13bEBHn1QHf
	SVjh5lh/D/IngdIRZ84v+VpZEDpTOBsP7gvW2vh/vls/Y0dij3n5rjjrEwJnAG51w2oJjkmOE/t
	U802C8LUJB/1Lqnh6X+uGlDd52YIv02nQW6FIwrp2Liou80DuKEMVZDEb+gPAWoN7sc2p43dNEG
	yrJ4DgBjD58HhXS12Mq1+59MXXQMh5VCPV9PXPsLuAEYWoynpim9U+HbozToDALoQIW/WB7IM5l
	++A29SF4dELnIJLehj2RygaNaifm6UJJoDuKe7a70TXoySRsihRbHYk5lDO+QkqhgvXZUpUFwo8
	nTojffIYs62stAIZulSuGQ3VtH78ctINH/d/NywgJwj1XK6b6VRqKMkLC6S/ZzNyMwzhEGJYkht
	J2sosXEBtM=
X-Received: by 2002:a17:902:ba90:b0:2df:34c0:7301 with SMTP id d9443c01a7336-2e5c54bc15fmr17707965ad.38.1791348864280;
        Tue, 06 Oct 2026 21:54:24 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60494c323sm4530895ad.69.2026.10.06.21.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 21:54:23 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] ipv4: do not warn on route notification size race
Date: Wed,  7 Oct 2026 13:54:10 +0900
Message-ID: <20261007045410.3806739-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 680aea08e78c ("net: ipv4: Emit notification when fib hardware
flags are changed") added asynchronous route notifications for hardware
flag changes.

fib_alias_hw_flags_set() sizes the skb with fib_nlmsg_size() and later
fills it with fib_dump_info() while holding only RCU.  With nexthop
compatibility mode enabled, a concurrent replacement can grow the group
between these independent snapshots.  fib_dump_info() can then
legitimately return -EMSGSIZE, so the warning does not prove a sizing bug.

Remove the warning.  The existing error path still frees the skb and
reports the error to listeners.

Fixes: 680aea08e78c ("net: ipv4: Emit notification when fib hardware flags are changed")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/netdev/20261004082043.GB92032@shredder/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
No new build or runtime test was run.  This is the exact two-line deletion
suggested in the linked review.

 net/ipv4/fib_trie.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index acb1e43859143e..248514dce0cdd5 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1079,8 +1079,6 @@ void fib_alias_hw_flags_set(struct net *net, const struct fib_rt_info *fri)
 
 	err = fib_dump_info(skb, 0, 0, RTM_NEWROUTE, fri, 0);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in fib_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
 		goto errout;
 	}

base-commit: 23609bce9e1de525d1d0e73fc68c6e7971d0b49e
