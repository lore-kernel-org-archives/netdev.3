Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510D30C143
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150639; cv=none; b=ZLUnefSZiHRKjGwU2g2OJ+uGaQSYEgQz1nE4m/HsTWiv8ji6HzX2+BGgmaq/1gGq5Zk1gBHeEN3Xivde1+2PGGSUvsmogY4LzPgHcx9nW0Xs68yPNsnLS0Da0I8c7tKz0nBefXZFLFsSoEFPa5qj9ImqNazCo97DW+sonEYS868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150639; c=relaxed/simple;
	bh=soWQVDbmNe3rLyARwyMn+CIEuPoaMlH8d+636m3QLlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0N44OdPF9Ie7OzPfZiT2p53mYDFOLN+hWxXl9VoOM+KKRf3YiYI6eCsGyvhhraHZpQHOwv22iXOfCFmHMmi+mSIUPrRfPZFh+ozsPkKlAjQNivYckUAgCJQrrIFSdDbvIwAXfczOG/BZwFQF26nywECTl6VmGt0HQqrtla0s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtC9kngM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtC9kngM"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38deea72eebso89847a91.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150637; x=1786755437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPn1wpDRn2+ycNh5bc3DMlHMWn7d+nIkppWcoRCSD9Y=;
        b=gtC9kngMYcdl46SW232zBxEqLIEWoKEY7A5aZmKpABnF35g4jqXZYRpacCrFRFRIoz
         fcfo3v3HrWnt2bUymYp8lMu20slR1Z2F2Lm5xLBcD3YWK1lBRV8db3dO0TetrJL/2u+0
         RI7cPzzw1LHNq9o2WZw6z9qkGHGTVitWqGGFFTC4lZfy2RAlvlNPghKjJ9GvZ5Hz6OpR
         RIN+lerg4cmEfo3dkjK/hNdfCcuYvZXAHh2CN1enbBXbTpI6lg7BJnkpNIt+Y31yAcvM
         LwWFlq+OsdOx2l/LyupbNn2y1iBu4IXftd3a1+8ZxXkuTV/JPRJ62eVxDG5dB4QwlzpE
         gjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150637; x=1786755437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPn1wpDRn2+ycNh5bc3DMlHMWn7d+nIkppWcoRCSD9Y=;
        b=J4DheFyKMzofy2BQ3tfg0SZWsIZ19S5cTGpepYRjHfro2FfTIj/FnjmhWZzfEdRamz
         +1AhMHy+iT6s36K4WteTGeRifsIBPVb/wbbE2oUZnB8Lvs1YFgjuame1I56aTRlTOk0x
         HVBxE3y8pbqcyqYbxeCr1vIZPCzDAwxxFNpXDA6aMYbmEEbro184/yO2sSZtE4ADQsOq
         lXi6Qn5nWA7fkUk+ozH1vD4oIToCwbo6JXoWz371d/pbqHOFQBCO4xpAOPJincKFWHZ0
         YSEn++on6ntybNLBlzCX6LvrO75up4CqH4MMfLfFEsSw1MgxIYjt6IGphK8zeYVGwGci
         Up1w==
X-Forwarded-Encrypted: i=1; AHgh+RqzBpHdfWwvZ2ucZbsvPUz+Xvb4BTSOn+UTTigxEL+ra6g9r/8Dqc83asIrdwrz2E/K7UEpu/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0x1QDw3q5Hs2A0ku5PFDEwEKbQejHb2J42BXdWJ7j9rSSgsE
	ek5z44KC+VrOkF2qzc4GZqbCEr7VJ7nRxWwO5Suju8Vy3JMD+BnJfcL4
X-Gm-Gg: AR+sD13RrHoyKEOkUfj22SVlKkFSNGOOcu6V7ZtoH0NMyL6LyI3CCaWcVGvyipvUKN+
	UXtN477tXfqudPtpXiumJIVeltnZDeRJQpqHuPh6YsNoshry97KhXvsgGI91y6yayHXsVbMjp2l
	JdUEiqpu+IhfM0b8i9KPruaMramsQYa1nvMcDL+u3Qj46r+Wmcy+1PuKA/Gum0IBWtM5s1hYbNB
	eMSjRbihQBOg7hm8JdUmHx6niOiDxJNM9K0r9oTEGzsK/VR7dnbsVJREZmaGQ/1i/BnpHT2aQ+b
	YwkN/VGOmL31Z2AMBwYU6v3L6ukX/neW4n3xxoqXub+3aih+GEUbzdsGLhVmulj4ylGQuWj+XmJ
	spwu4lUesgkbB56zQcoBR3DwhnXTttMNOnNISK9eM+30Rt4tGXSYkBKMbKkvDqUwXnM+B6G3ATw
	LqIV3RTjAyEKaBOHDu5JQDE5pmIiEeaEvHmAU6lPy0v+rlJ9CFjgkIJnxrFY1C1Kde7RzgWTzwX
	mLSYuiUaeYMWr8cu5ODlwPb2sD7sXWZJ5gZ6sVjj4x6zpZapjI=
X-Received: by 2002:a17:90a:e706:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-392824a96eamr3586255a91.13.1786150637002;
        Fri, 07 Aug 2026 17:57:17 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:d7e9:6449:7464:1dfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm4205182a91.2.2026.08.07.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:57:16 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 06/10] ipv6: add inet6_rt_del_notify()
Date: Sat,  8 Aug 2026 09:56:38 +0900
Message-ID: <20260808005642.26901-7-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808005642.26901-1-sigefriedhyy@gmail.com>
References: <20260808005642.26901-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the body of inet6_rt_notify() to __inet6_rt_notify() and give it
the deletion reason. inet6_rt_notify() keeps its prototype, so the
route addition path does not change.

Add inet6_rt_del_notify() and call it from fib6_del_route().
RTA_DEL_REASON now reaches user space on RTM_DELROUTE for routes the
kernel deleted on its own.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip6_fib.h |  2 ++
 net/ipv6/ip6_fib.c    |  2 +-
 net/ipv6/route.c      | 20 ++++++++++++++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 0ba5d3c56543..232289b439c3 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -533,6 +533,8 @@ static inline void fib6_rt_update(struct net *net, struct fib6_info *rt,
 #endif
 void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		     unsigned int flags);
+void inet6_rt_del_notify(struct fib6_info *rt, struct nl_info *info,
+			 enum rt_del_reason del_reason);
 
 void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
 			 unsigned long now);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index f8a9ec7fa616..3e382ba1573e 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2057,7 +2057,7 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 			call_fib6_entry_notifiers_replace(net, replace_rt);
 	}
 	if (!info->skip_notify)
-		inet6_rt_notify(RTM_DELROUTE, rt, info, 0);
+		inet6_rt_del_notify(rt, info, del_reason);
 
 	fib6_info_release(rt);
 }
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d3bf2dd209bd..1704359d3960 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6378,8 +6378,9 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
-		     unsigned int nlm_flags)
+static void __inet6_rt_notify(int event, struct fib6_info *rt,
+			      struct nl_info *info, unsigned int nlm_flags,
+			      enum rt_del_reason del_reason)
 {
 	struct net *net = info->nl_net;
 	struct sk_buff *skb;
@@ -6398,8 +6399,7 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		goto errout;
 
 	err = rt6_fill_node(net, skb, rt, NULL, NULL, NULL, 0,
-			    event, info->portid, seq, nlm_flags,
-			    RT_DEL_REASON_UNSPEC);
+			    event, info->portid, seq, nlm_flags, del_reason);
 	if (err < 0) {
 		kfree_skb(skb);
 		/* -EMSGSIZE implies needed space grew under us. */
@@ -6420,6 +6420,18 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 	rtnl_set_sk_err(net, RTNLGRP_IPV6_ROUTE, err);
 }
 
+void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
+		     unsigned int nlm_flags)
+{
+	__inet6_rt_notify(event, rt, info, nlm_flags, RT_DEL_REASON_UNSPEC);
+}
+
+void inet6_rt_del_notify(struct fib6_info *rt, struct nl_info *info,
+			 enum rt_del_reason del_reason)
+{
+	__inet6_rt_notify(RTM_DELROUTE, rt, info, 0, del_reason);
+}
+
 void fib6_rt_update(struct net *net, struct fib6_info *rt,
 		    struct nl_info *info)
 {
-- 
2.43.0

