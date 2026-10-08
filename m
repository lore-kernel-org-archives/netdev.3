Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8A4963BA
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463481; cv=none; b=e1tg8czAPuu6b0eWv2EYyNe6rCgBJ5yzBhNFX0XjjGRXhmrSzh/G7D2qJz13l1UbsiR5+2bkRxBds2TBHaGWB7e5xd57n+k0EApRx40BIcMuWfGpHsUdQRjS37mpujwvSd32nZpLtRv2qw7DCH8Z4vKpKOQZUQj4b5CwBkw7FtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463481; c=relaxed/simple;
	bh=1wmo1JdXpHAEF33ghsK5ngwfDfCrfwSZJ8Lt5pDXSyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDMoRlZ9vyklHqgNBF8vUva91EwlG7EF7Lo7AqmUkvshpN+Vvwwob8CeABORAgoA4gJc4ZDptTcJo2X5F8Lsxsqdr07dDGgBBKy2eOvLH3chDuxtlJnmstw6G4K4ZypZiclfHFImx3iqe+/2QacXoR5YAO8OTGmVkpVPRzcQsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Gd2NkD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Gd2NkD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49ff680331aso56757965e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791463478; x=1792068278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=umbLSqkVyKq6IzM8iFkLDvRc9MitdtRPDOB4w8coJ8A=;
        b=Y4Gd2NkDvpVJOQVt7RmGJHtNHdEomMjbiWaY49XDBWX5hMpq3eeNxgIf6MflYhAo0o
         vD6Gd1zV5KxRjm+KH9+aa5RRePrc0wvHXhGUKGtLc2zrxk8FZUur8EZW7T5rE8aFn81V
         MmlSJUUfyVPzSgi+IvvRkiy0V0F5xvTRgt1P3UTLoM05WH+Tdq2VHPONODA57RrY/f10
         J8qc8Zjmqu5aWqBFn09dz+5Rl7LPwR17leezcjpl3uFdgFcPKYF058nEQt2NJB2Q+sUc
         B+HrT8dUea/WfKnSxQ1oRKho7O8KeoVohyV3pYFrUy4HSvH0M1VqEQSTmcrF/PLlB7JG
         xYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463478; x=1792068278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umbLSqkVyKq6IzM8iFkLDvRc9MitdtRPDOB4w8coJ8A=;
        b=vc4iGmiWS4OrBqdzjtzg9acGfetpFe+lAmlisIu5ZGnKO4O2hn+gQgqK3zeWe/1+T+
         Bg/c/h9f0HoaKbv+rvrBnWlymLD9aL2j/qzaRtiRfM3Wc+xEc7ucmLzmq/sGO4JlK/lW
         kU4+WPPIcK8Vg+b/gqecNGGDYgZWxaSi27MHn2Uph3gUcT27yqMnHlyuek416r+qPZ/g
         86Ye/Og85Qa6RRl3P8hqBwLnkoN3hf4xE7eFZHJ/FBZ6G5pTb2229oLPFOvs7ms6asGu
         r4Ntmwn6S7DBBVu6B4GlzKHzurWNLxjDpfUzKs6VBDhETtZ//8B2LM/WOD6clWuBB4i7
         bjtA==
X-Forwarded-Encrypted: i=1; AKwUvBysuJdJaTBOH1CDDQw2FnIdY3mHNBgr8Nfd3D21VQoUPETOxY4DH4tZo5IOftH4KfNO2LyQNK8=@vger.kernel.org
X-Gm-Message-State: AFuF++kFFF6i//uDPmtp9j+hGAsi4JqzS7PFfS1wT2DqlrIK7pvd7i8z
	VvYlGroUgUKWd0UT1kREmJpZW+9ZFcmobwtKsMb8kgfp4WMTbfYaLiQq
X-Gm-Gg: AYBFou2X+AEeG3+gN0IIXjcl6+a51hI4HRpAJIzFR41SiWJFEVScN9maVxR5MRjp2+W
	DXmaA8W9u81RnqFySoNXGhK4rpnPu65RzgAwxNznCKf0qKSCnwTjxTzjCSjAebV4+5m2vbBvP3D
	2q9JxSczqqgKztYWRcJQ3+Lcg56oFlCpxSI6rkMRfFQfHZsGBi0c4h9fHXiAr2B9gm7316kjdep
	m88KaA2LNYIJjiW8FnpDmAQbhGupzVWMuo7v53lDog2OKxXljBpZ0WGwoX6pSlNZAeOEQ3SqDkp
	DcLpr/NGw/f3iqqvw65unfbFTxPZz0jzgYNlF/pCebzOpW+ROj9emknICpSREtWokGm8TmWLg/q
	LZx/6p/GODGG0SkT34c6vo7SAuTsFXIldiTA7xAzHq2E1RpLCDrgP440D1VJKYatljLzDYPjapy
	D05qOCI+br+jnJw7Gc4kjgiiKCclo+xVEIT3p0ZBjFyDbxNVIMeWU0P/5RmDl2HAZCaryRtc/yb
	uj+7YDImveUnLSat4rhBZlOonOUuU7Sj+QifpQ3AfFYv60z80WiEj0=
X-Received: by 2002:a05:600d:848a:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4a1825a5968mr52235585e9.32.1791463478037;
        Thu, 08 Oct 2026 05:44:38 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.41.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1ffd2sm10885399f8f.34.2026.10.08.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:44:37 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rtnetlink: comment the RCU and SRCU waits in unregister paths
Date: Thu,  8 Oct 2026 14:44:22 +0200
Message-ID: <20261008124423.11543-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_link_unregister(), rtnl_af_unregister() and rtnl_unregister_all()
wait for readers before tearing down what those readers use, but most
of these waits do not say which readers they are waiting for.

A missing wait is then easy to overlook: rtnl_link_unregister() lacked
its synchronize_rcu() until commit 3b70edea393d ("rtnetlink: wait for
RCU readers in rtnl_link_unregister()"). Add a comment to each wait
that lacks one, naming the readers it waits for.

Suggested-by: Eric Dumazet <edumazet@kernel.org>
Link: https://lore.kernel.org/CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/core/rtnetlink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 15bffafbf0a9c..80f8577816760 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -526,6 +526,9 @@ void rtnl_unregister_all(int protocol)
 	}
 	rtnl_unlock();
 
+	/* Wait for rtnl_get_link() callers under RCU that may still
+	 * dereference tab.
+	 */
 	synchronize_net();
 
 	kfree(tab);
@@ -711,6 +714,7 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	 * not yet taken ops->srcu.
 	 */
 	synchronize_rcu();
+	/* Wait for rtnl_link_ops_get() callers to call rtnl_link_ops_put(). */
 	synchronize_srcu(&ops->srcu);
 	cleanup_srcu_struct(&ops->srcu);
 
@@ -843,7 +847,11 @@ void rtnl_af_unregister(struct rtnl_af_ops *ops)
 	list_del_rcu(&ops->list);
 	spin_unlock(&rtnl_af_ops_lock);
 
+	/* Wait for RCU walkers of rtnl_af_ops, including rtnl_af_lookup()
+	 * readers that found ops but have not yet taken ops->srcu.
+	 */
 	synchronize_rcu();
+	/* Wait for rtnl_af_lookup() callers to call rtnl_af_put(). */
 	synchronize_srcu(&ops->srcu);
 	cleanup_srcu_struct(&ops->srcu);
 }
-- 
2.53.0

