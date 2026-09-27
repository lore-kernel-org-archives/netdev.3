Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9A3B8BBF
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540682; cv=none; b=Nidq/NiM8/qmcyX7cH/phmxH/h99gB4sb+xaMl8jNbULFunaoBg3NX8d78+VelZpdTwoXzWG7uFi/rqbCFYuoEXPRBE+jkEtt5hXw1qcTva/2DuWfH2MhZFjYhHYBIUUJMngmlwdGpijs+Mzmh3bStMoCUPe4x13jQ898lQALNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540682; c=relaxed/simple;
	bh=qIpoQtqE2/MR7ZDNyoks+Ks+ZhsGXOmjKk9A9ta0yHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RljdGB8ZpZnwN7XjtuLBiRRy9n9D5ub3qJ/FSuixWW7YK8r8Ks317F8mxGyqZxtpBeYoMdkIUtIbhjzulqUxOI0bk36ptEkEiylsCoKJoh5xAsXIFE33mSb2WDJVi84CK2MY42+CQEERHFRstBn/byYnE4PW5dlkeJLutB6pLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2n/ikgo; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2n/ikgo"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so2426058a91.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790540680; x=1791145480; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmVlVigYHsi+s/Ejaejdyy7SMCDA9n5B8aD7+vkGexE=;
        b=J2n/ikgozwuWd4mUro1M2wISKdEO2cn6AZqXf5AJ5UQhXiJq6k/4til+iC54DGaAWR
         CrOybRrYj0z2F68LChuDK5/WfrI+zG4RZRDyn+pM1c/gxx4grhRdAUPJFyax35qGrIix
         w05q7YSTqq7ixOB0+TvKCr5AeEhpUm3Jyw2eStMMDgIGXNHzhBF8/tH762LIpqQ/eatN
         Yj9ZlcrHUBX9jg4HJBh+bb1NcvaAETbFqMNOydOy5oQ7tINuuDiP+SMRFTKpkqWxmnqE
         02DRzYVbUZwTBGGmfiPfNThjqHVfAvg3Ir759LxrJA6zgDURGJdaaGo0Tjly7tbXjOB4
         E+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540680; x=1791145480;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmVlVigYHsi+s/Ejaejdyy7SMCDA9n5B8aD7+vkGexE=;
        b=v1vUIDgHhd5jg0HZrD0jywR/zpkcou1jovxncRdOTkz/wSfKsFTSjoIeTxIC6NEykr
         roGVHPIMWMv4O/XgZHaOZBcWMril4SbLTUiiRkjNtPyVkv6qB6mQkODhAqtVvc9fot2s
         cCmtQ+PLZ4UViIhDnzsFcXQkIS9nrTT7pHf0WN9LzBeQc1OJZeYMdsTL5xQ8EgIf5V0x
         uX3K1B+eVtQiB3gy4pUSbHaJoRnkYJfO8SxqigSBWELqtBWdSaG35Kvj01KCVQzDMPR4
         51wh8LsXz8tx/jkrR24lWFBjgCVRnWR3EofWI2VoqxC0Qji3B2FTmHsJQAjFdqw+aQj5
         Bxsg==
X-Forwarded-Encrypted: i=1; AKwUvBz3hRRH2oGW2guxx0x8LgYLD8ocivSsaQDZdl8rIRnpo8kLUMrYeDptdkIXPr0+lp1t3+W31Bc=@vger.kernel.org
X-Gm-Message-State: AFq9FYID3UFxZLZtEz/ZimiliAtoOmo0fyvC/vctk5KJpAty+CBefMyd
	smeynYEn7mJo0AM004l2+O9MmHDWz7eqzu/ICCbPweCCNlGTB/5rST+ALu3Uf+AjGrbo9UAaGEh
	Fdv2T8g==
X-Received: from plld21.prod.google.com ([2002:a17:902:7295:b0:2db:1fc8:4e2e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d43:b0:3a2:ae51:f4ad
 with SMTP id 98e67ed59e1d1-3a2ae51f583mr1216209a91.28.1790540679421; Sun, 27
 Sep 2026 13:24:39 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:23:39 +0000
In-Reply-To: <20260927202429.2452589-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260927202429.2452589-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927202429.2452589-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/5] net: Add ->pre_exit_batch() to struct pernet_operations.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While unregistering a netdev, we must find and clean up all
resources holding refcounts of the device.

This operation is usually triggered for each component via
NETDEV_UNREGISTER and typically requires a full scan of hash
tables, etc.

For example, rt_flush_dev() and rt6_uncached_list_flush_dev()
are called for each netdev and iterate over the global per-cpu
lists to find uncached routes tied to the device, resulting
in O(N_dev x (N_cpu + N_route)) loops during netns dismantle.

Moreover, rt_flush_dev() and rt6_uncached_list_flush_dev()
do not even require RTNL.

To batch such cleanup across dying netns without holding RTNL
before ops_exit_rtnl_list(), let's add a new ->pre_exit_batch()
hook to pernet_operations.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/net_namespace.h | 1 +
 net/core/net_namespace.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index b4247e767d13..58b2601bb869 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -488,6 +488,7 @@ struct pernet_operations {
 	 */
 	int (*init)(struct net *net);
 	void (*pre_exit)(struct net *net);
+	void (*pre_exit_batch)(struct list_head *net_exit_list);
 	void (*exit)(struct net *net);
 	void (*exit_batch)(struct list_head *net_exit_list);
 	/* Following method is called with RTNL held. */
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 0e13de0cd36b..476fbf913bad 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -160,6 +160,9 @@ static void ops_pre_exit_list(const struct pernet_operations *ops,
 		list_for_each_entry(net, net_exit_list, exit_list)
 			ops->pre_exit(net);
 	}
+
+	if (ops->pre_exit_batch)
+		ops->pre_exit_batch(net_exit_list);
 }
 
 static void ops_exit_rtnl_list(const struct list_head *ops_list,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

