Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803814156ED
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798615; cv=none; b=lY8pFMCq4+uSb3Yri12tsKxLlirmZAQAvGpk7FXqhfXgBmW5nDmy+e980rM5lwhxs4CC5jK8zf1ed+PdZXPl8+xfX5Pu/NuV+zdGW4tRhzlt/Jhp8DOIt1GThCLza6l04kzL6lUp17gztnttubYDsZAyaTdkiufQspHwyCf/uRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798615; c=relaxed/simple;
	bh=P9yNaSRFw6ONfkYB/KFuvnl5DbYIe+uxAeeecMtVkok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qpKYAyhfDHfsUdWLH/H4Pwd/x4xPY1ZI7ReqgdgT2iN6b0k9K1Nl38iEq3tXoYyQfs0HkgzeXp1+IXxWP5eN4xwI5aWgDj2aozfYe74QpS8ejXwVc5XScRoWtPeU+7gnkZiGBDsdVgcDLWu/DdKakQmS1Tm1OvsAikhqEuXnNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+M5dhe0; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+M5dhe0"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df5a65671eso1405785ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798613; x=1791403413; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kl/+9o+vqH+ggoXnQi5qXo6haYFflVOEKmtyvgF2KK8=;
        b=e+M5dhe0pWs8gXiuFxjIMX0A7clOq8Be2YePmVhzPDh9SPCnrxRUNvw/FSiwCKJDAS
         k4VcshuXbc2DItKp9eWMI9ex2aYLP9y7Kl3cxfFOUPwpxJEzRK5ajBS/D5lvfVLm4rtp
         WPBcNCjr+M5lXZuFDx+w2OfXEf7WueY1/wisshewhTD/mPm5erIeu96FqgagNVNFVr5N
         5cAbisI5h7XtZS17IPqkeiHae1LaeGGLg5KCO+0JjNFFkOhiuGTw6Y7zzl9aKFZISNlN
         hAjMtM7pitZ7bpNgky4uRbrhNKiJh4DsNDGWC5Nswp7Ek3pW9rzKdKH7RXnCG3SDTwwd
         JToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798613; x=1791403413;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kl/+9o+vqH+ggoXnQi5qXo6haYFflVOEKmtyvgF2KK8=;
        b=UfPLk/IlsQT4zTIm94e6B/JDT958f58QRNTNwmw7A7eYAvI8d9PuD/GWtA3vMJzB87
         saqUfaZCXVIj8qz5Zkfq3c9r2fZqusjai95EGLRe3Ti/zfN6931gVQnwnwIs/H98a3S0
         Y7ukiUGPT722lgyaMi/CLzlqfDMjlbE88N3HOwwBVgqH2vOmzG0UVuDr5ah9D4mtXlZy
         aDOoTnEpoCayHOrAOxBfaj658fHsPqfav9M4yTwvMAIo8AU3Fi28fKjThnCx3OYc6j2b
         hwrBNtQtRDicKM74F+bbGiQImoozyZBrbUJZEqCV09mPCZEmSRm0tIjStLHg7xf1K8RG
         ZkQA==
X-Forwarded-Encrypted: i=1; AKwUvBxdp0Yuj50rXddOTFOtgrdMasH8FMSoor9C5+c/nWqW1H1hwQXCWPXwO626RP+Sc0IEhJMFSDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMkmPUCSx1KEshVWXNTUeldfNb+bVdRciUVFmBP2UQUCGO0ClD
	39mEpi/2KYeGr6CfZ+Lgfue32O9rZ8CuMKNSG8/HHE3nb9sQQqjnc4OaE8pA/KCCoOprAt3DEkw
	UN8CtBg==
X-Received: from pgcfh15.prod.google.com ([2002:a05:6a02:66af:b0:cc7:e1f3:e015])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c86:b0:3a4:c540:afd7
 with SMTP id 98e67ed59e1d1-3a4f3a64835mr390201a91.37.1790798612404; Wed, 30
 Sep 2026 13:03:32 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:11 +0000
In-Reply-To: <20260930200326.718459-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930200326.718459-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930200326.718459-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/8] ipv4: Add wrappers for neigh_lookup() and neigh_create().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_lookup() accepts struct neigh_table *tbl and struct
net_device *dev, and both of them must exist in the same
netns.

It is error-prone to require callers to fetch a netns and
get neigh_table, which might belong to a different netns
than dev_net(dev).

Let's add IPv4-specific wrappers for neigh_lookup() and
neigh_create() that always fetch netns from dev.

Note that we do not add wrappers for __neigh_lookup() and
__neigh_lookup_errno(), which we will remove later.

__neigh_lookup_errno() is a simple combo of neigh_lookup()
and neigh_create().  __neigh_lookup() is almost the same
but converts errno from neigh_create() to NULL.

So both names are confusing.

For IPv4, __neigh_lookup_errno() is only used in arp_req_set()
and is not worth a new wrapper.  Instead, it should be inlined.

arp_process() uses __neigh_lookup(create=0) but it should
simply be neigh_lookup(), and then __neigh_lookup(create=1)
is only used in arp_process(), so this should be inlined too.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/arp.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/net/arp.h b/include/net/arp.h
index e932def63d62..329a5456987a 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -51,6 +51,22 @@ static inline struct neighbour *__ipv4_neigh_lookup(struct net_device *dev, u32
 	return n;
 }
 
+static inline struct neighbour *ipv4_neigh_lookup(struct net_device *dev,
+						  const void *pkey)
+{
+	struct neigh_table *tbl = arp_table(dev_net(dev));
+
+	return neigh_lookup(tbl, pkey, dev);
+}
+
+static inline struct neighbour *ipv4_neigh_create(struct net_device *dev,
+						  const void *pkey)
+{
+	struct neigh_table *tbl = arp_table(dev_net(dev));
+
+	return neigh_create(tbl, pkey, dev);
+}
+
 static inline void __ipv4_confirm_neigh(struct net_device *dev, u32 key)
 {
 	struct neighbour *n;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

