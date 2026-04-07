Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672237C909
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596810; cv=none; b=PcBWmQEC5J4a0su+MULECjlG6nPD7jMJK/fVbRr7yf5g7UoMT46WaruTrw3+kZAL1aPD+hslrDevFpWEJQBmogEfQ2oOJC0e96CmBT1ZD9Ub+wTiC8n+awF7TvLjEc9P3IwMZPpuzBcNu9kkjQVM5Zmmbc3leFirgpgpmWiJPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596810; c=relaxed/simple;
	bh=85NwjJ3H2J0e+cJDk12xqiUFz0xzv5PNzEnG0HkjAB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RlwUvEKBKh1lkD1JJYoPQwxPJomGX8f28wqoZx7ynm8z/mZrZpDas7g4RrPXr9Am+0EhMTG9MZsDjiezrMqnmhj2JXmkRQS1Iu/GoQUh206LIFe+JOSz2ObBHsGr5bODacJ0BCWqeF/HG75t4tF1iOmVC48ops4aoRDUeJhDhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCSjrPmH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCSjrPmH"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c70d1f65aso3158716b3a.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596809; x=1776201609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Ukw+3WOtgevBIixpHo7V3kfG6o5IMXV3NBaxMtdyw=;
        b=PCSjrPmHGTpAG0zu2S79/Hc9baEITMaiN4alH1zWzUBLGq8IacTyWCfLwzrU4wF85Y
         wR6l+d5gfRcotAZDW69/xWG/LWc1YKmTOE6s11Ttf71LXUhHvF0QX1goggY/s8lP+GAL
         oNxue7dKuh8o4h/o3RuoruJPfdp6dqDrp0ZdZj6qybUmeyZZbky5jtLv0FverRRKVsiK
         qrKtuCaI0aL8GMxFRGG0U0n4P9ypu9P9WLaizejcPtEsDuHHgEutZ4wjq47fz2f/xfwI
         bmWn6Uxs8r8wH0m+EfkNmxct2oHrEearSXVcoiyoRSVX5tjnWzpt+AmBSIhB/vN89cx+
         OYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596809; x=1776201609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Ukw+3WOtgevBIixpHo7V3kfG6o5IMXV3NBaxMtdyw=;
        b=kVXl+r6vm+Fxyj/lbHkzWCIlsCKG8jKx4kZ1EYOgx8gvg0bYohNQnN2NmG7vcj7LkV
         Z961gx4NPuXSJIzUCbak8L7q6pXgmfAzbB6bS/SfSMQzupcDY0fDDLd2cYS2wBAB9UXf
         6fYqnxK8fgIf+SxvNL0ox0AB+b+pB8AsLbyIJ1b68EoM55KowmWS1IdYpCmIhuA65kyu
         rsEDplXQZbUNQzd4NOULbA82F2UOEAMLDZ9lbOJJO9kc2Q5l960r8CJgODjbh0owCpjb
         /gmm8xvikW13aFxnrc/P/+mUlRWb6s5cQu0upX7AOV8Uyj3xQiMtqRLURSUh4FI67wTH
         VcSA==
X-Forwarded-Encrypted: i=1; AJvYcCUAKMm8wFzVMwUGHrp79khlbETNsZtnBUGiRPw4iSM1+2ZxXp/BGPCLrvkjFT5Ae1iqaS1cWtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybNrN1Ie5EL2o3p90jK/nwQoMHII9mRmZhJbRUprgv9U4nflfh
	RHNrTJGH8bdx9I79XDn9GkKa1x8XS/6lASzTkjWdsKbEtTERefBF4gzBz/Apjb6kcvRAl9XWYSQ
	zlnX0Aw==
X-Received: from pfar2.prod.google.com ([2002:a05:6a00:a902:b0:81f:7391:1ea6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a5:b0:823:12cb:f5d1
 with SMTP id d2e1a72fcca58-82d0da3de84mr17666757b3a.6.1775596808587; Tue, 07
 Apr 2026 14:20:08 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:36 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/15] ip6mr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These fields in struct mr_table are updated in ip6_mroute_setsockopt()
under RTNL:

  * mroute_do_pim
  * mroute_do_assert
  * mroute_do_wrvifwhole

However, ip6_mroute_getsockopt() does not hold RTNL and read the first
two fields locklessly, and ip6_mr_forward() reads all the three under
RCU.

Let's use WRITE_ONCE() and READ_ONCE() for them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 5755244e226c..5d368ee39b28 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1783,7 +1783,7 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			return -EINVAL;
 		if (copy_from_sockptr(&v, optval, sizeof(v)))
 			return -EFAULT;
-		mrt->mroute_do_assert = v;
+		WRITE_ONCE(mrt->mroute_do_assert, v);
 		return 0;
 	}
 
@@ -1803,9 +1803,9 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		rtnl_lock();
 		ret = 0;
 		if (v != mrt->mroute_do_pim) {
-			mrt->mroute_do_pim = v;
-			mrt->mroute_do_assert = v;
-			mrt->mroute_do_wrvifwhole = do_wrmifwhole;
+			WRITE_ONCE(mrt->mroute_do_pim, v);
+			WRITE_ONCE(mrt->mroute_do_assert, v);
+			WRITE_ONCE(mrt->mroute_do_wrvifwhole, do_wrmifwhole);
 		}
 		rtnl_unlock();
 		return ret;
@@ -1873,11 +1873,11 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 		break;
 #ifdef CONFIG_IPV6_PIMSM_V2
 	case MRT6_PIM:
-		val = mrt->mroute_do_pim;
+		val = READ_ONCE(mrt->mroute_do_pim);
 		break;
 #endif
 	case MRT6_ASSERT:
-		val = mrt->mroute_do_assert;
+		val = READ_ONCE(mrt->mroute_do_assert);
 		break;
 	default:
 		return -ENOPROTOOPT;
@@ -2180,20 +2180,20 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
-		if (true_vifi >= 0 && mrt->mroute_do_assert &&
+		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
 		       so that we cannot check that packet arrived on an oif.
 		       It is bad, but otherwise we would need to move pretty
 		       large chunk of pimd to kernel. Ough... --ANK
 		     */
-		    (mrt->mroute_do_pim ||
+		    (READ_ONCE(mrt->mroute_do_pim) ||
 		     c->_c.mfc_un.res.ttls[true_vifi] < 255) &&
 		    time_after(jiffies,
 			       c->_c.mfc_un.res.last_assert +
 			       MFC_ASSERT_THRESH)) {
 			c->_c.mfc_un.res.last_assert = jiffies;
 			ip6mr_cache_report(mrt, skb, true_vifi, MRT6MSG_WRONGMIF);
-			if (mrt->mroute_do_wrvifwhole)
+			if (READ_ONCE(mrt->mroute_do_wrvifwhole))
 				ip6mr_cache_report(mrt, skb, true_vifi,
 						   MRT6MSG_WRMIFWHOLE);
 		}
-- 
2.53.0.1213.gd9a14994de-goog

