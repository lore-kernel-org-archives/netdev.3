Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB3248F72
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808051; cv=none; b=so2OMKVrybs4kqlrdawjsbsUDSltj7ycbk/kX8RHCdyjeLihEjO4ON63bQK7+ubEmJE4dl75ujM2NQxsUIUnHYQ7mYN9AhdNn+R6m7zJL3zv+6iwm8+94oWhl87IGj7xfLYMELgVzSM/kYmj7XKoKvH6JZ8998e9c/j/1PdgeaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808051; c=relaxed/simple;
	bh=APcx9K35DMKblVF+0j+9P6be8HvN191a+B2dFfG8i1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quhIMicEh78AdM+EHsLh+JxKIfsevjDtpnxQw5mc0D9WZiIb9zOwWA4Q2bWg3ThiKv8Fux+HURILacAL5VbVk7bijIhwpUEEYqToQcvDk/64TTWvLyeAItV1oBU0v5sTNKwzmhPtQgWrn8wX+PuT/ID4vZkPh59yBrgHn4UPy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nt+LoF/l; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nt+LoF/l"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso4742913b3a.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785808049; x=1786412849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sLr3KOJuwu9lQ9y4+Qdhpzg+GLfZHNHrSE0VnJskiH8=;
        b=nt+LoF/lP3k6RwN+8PPwK3zy3V5Ziie29dQU1ZDGmnSObs/0HmKiRPeL0tHc2gD+fz
         bvjyPq1o6a3RkvfPuj3/aGDGHeEa3Egwzx5P4eV8/q2K7RsBZuCxk9J9l9HMFt0ImUIK
         QIZ9Oh5eFID6CGmSnOjzJhJf6OIzgX690Vo79JEmfM7TQtBRkvk7b8w0VaR84MldBkgr
         MprRPKmItdHN9NItlPEGPljGiHlUa83YFc09WBo/HIMD52Q5fIJdko+XuS72LIIr1zLX
         jsfyCgAIPLYgM7yD4mU5zGzn8iX6nm/oJw2uuPmPpeMLnI2a2tl/WVn79Cs0w2AWkSBH
         hZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808049; x=1786412849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLr3KOJuwu9lQ9y4+Qdhpzg+GLfZHNHrSE0VnJskiH8=;
        b=HrElwHlHT/DIgWchWAeQ6A3qwSVbamDQpZ3VMOfEJ/bfyb6TZ8PWNOwKHv2Tod4H9d
         tszV0bUsoPhbuDI2DotVQd9+1MvkFvSOOlTdq+odxBwxjsr9nCn6t8rhb0Klyy0Pj7Np
         rVxVs8xl00RDNEv8tDh7B+e8jGxLyfBfV88KRpM0cHc9Kpeug3jnyPn52tHnFI8f0erb
         obFaFkHa8Rq4eUnrdea6iGmNqWmgbA1BK19ZWwpIEY63zgfgzLDkUuGMwaJzwTVun8/r
         5TEu+CxEmz7ZXkOy8FZDQd9AWk6NoYywlxxJ74BBII1c5um0zQpWK7A8RF6Zq5xeTbw3
         9/gA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5gKms2Ujw8WQVaKFYAzjs9FMIoqCIsaiP4gzETbatiDhNnJdt7wg1blvASKlG/xj5+rFaWvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwiE4atrGwNfEvXsxYaUAO3Grtz7kMu6HOs/Uj0hgSaC2FeOLq
	sLWOTwhtptRs26GgjZe2X+lX4Yaxxtxreq/neWXE3tCvb91JP+7jpkXe
X-Gm-Gg: AR+sD11yJGeChW+FiqBAo4Wy5kF1+yDV3vTF3yFrKDI2Gez2TZoyMyTLiHqTV8KCiGf
	RKSc1vGNPyXygML2frKl5HLd05omTy5UVD6ig19Ih4lEhTot/vT3sWRL6+Q00NBO64RWCR4Bu+B
	pqBkafewO80DZ1Ip7KpMGddCRVbJj3e9NaYWt33GVlKQ/V12o3qtSVWa4Li2QT7+Pfi8PQNf50d
	c4xmm47iAYP7IVfHTcfl7hwaKGYJhVJrTpb5k91v+IsXgeD84IRGIh59mh7pUFa3Q48U8SoT4yH
	afEwZgwxpbZcxfe46tqDwGdIJDXQJeUVwaOp4tVzZ1dBzQCfl0ljnW/7daNbjPuZDgsalInQ3EQ
	9voyY3YqirdYNbhJq4APuyzHgUrqMB4YlWrf4jpuV+FuLQklDfXTw0oOyWkBCqy88YT0SVPBzaO
	5wJqZAZRrfGC2yyUiGl9ARr9vD/d7utHcsIBy6m6Jf+SoZAA4gnvbEV8TyxhpM0RK1KgqygXSh8
	CL9NUBpLo6ibvYDq94BuUl3fXHBruNkR6tmdC0UwPQj0XMd3qk=
X-Received: by 2002:a05:6a00:4b0d:b0:84c:3900:95d4 with SMTP id d2e1a72fcca58-84ee482ad3cmr10771372b3a.11.1785808049287;
        Mon, 03 Aug 2026 18:47:29 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:cb1c:934a:3e5f:ef88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm4410164b3a.43.2026.08.03.18.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 18:47:28 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nimrod Oren <noren@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 01/10] ipv6: add ip6_del_rt_reason()
Date: Tue,  4 Aug 2026 10:47:05 +0900
Message-ID: <20260804014714.4362-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804014714.4362-1-sigefriedhyy@gmail.com>
References: <20260804014714.4362-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RTA_DEL_REASON and enum rt_del_reason to the rtnetlink uAPI, and
add ip6_del_rt_reason(), which takes the reason a route is being
deleted. It has no skip_notify argument: a caller that records a
deletion reason wants the notification that carries it.

The reason is unused for now. Subsequent patches propagate it to the
deletion path and report it on RTM_DELROUTE.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/net/ip6_route.h        |  2 ++
 include/uapi/linux/rtnetlink.h | 22 ++++++++++++++++++++++
 net/ipv6/route.c               |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..7bcf0e5bd887 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -128,6 +128,8 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 int ip6_ins_rt(struct net *net, struct fib6_info *f6i);
 #if IS_ENABLED(CONFIG_IPV6)
 int ip6_del_rt(struct net *net, struct fib6_info *f6i, bool skip_notify);
+int ip6_del_rt_reason(struct net *net, struct fib6_info *f6i,
+		      enum rt_del_reason del_reason);
 #else
 static inline int ip6_del_rt(struct net *net, struct fib6_info *f6i,
 			     bool skip_notify)
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 27265fd31e5f..66cfc17ede0e 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -399,6 +399,7 @@ enum rtattr_type_t {
 	RTA_DPORT,
 	RTA_NH_ID,
 	RTA_FLOWLABEL,
+	RTA_DEL_REASON,
 	__RTA_MAX
 };
 
@@ -407,6 +408,27 @@ enum rtattr_type_t {
 #define RTM_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct rtmsg))))
 #define RTM_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct rtmsg))
 
+/* RTA_DEL_REASON: why the kernel deleted the route. u32.
+ * Emitted only on RTM_DELROUTE notifications, and only when the deletion
+ * path records a cause. Absence means either an older kernel or a
+ * deletion path that does not (yet) record its cause - consumers must
+ * treat "absent" and "unspec" identically. New causes may be appended.
+ * Currently only IPv6 deletion paths record a cause.
+ *
+ * The value space is family-agnostic: a value must never be
+ * reinterpreted per address family. A cause that only one family can
+ * produce still gets its own value rather than reusing another
+ * family's.
+ */
+enum rt_del_reason {
+	RT_DEL_REASON_UNSPEC,		/* cause not recorded */
+	RT_DEL_REASON_EXPIRED,		/* RTF_EXPIRES lifetime ran out (GC) */
+	RT_DEL_REASON_RA_WITHDRAWN,	/* zero-lifetime RA / PIO / RIO */
+	__RT_DEL_REASON_MAX
+};
+
+#define RT_DEL_REASON_MAX (__RT_DEL_REASON_MAX - 1)
+
 /* RTM_MULTIPATH --- array of struct rtnexthop.
  *
  * "struct rtnexthop" describes all necessary nexthop information,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index fc42d67e5822..ca374b056f5a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4004,6 +4004,14 @@ int ip6_del_rt(struct net *net, struct fib6_info *rt, bool skip_notify)
 	return __ip6_del_rt(rt, &info);
 }
 
+int ip6_del_rt_reason(struct net *net, struct fib6_info *rt,
+		      enum rt_del_reason del_reason)
+{
+	struct nl_info info = { .nl_net = net };
+
+	return __ip6_del_rt(rt, &info);
+}
+
 static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 {
 	struct nl_info *info = &cfg->fc_nlinfo;
-- 
2.43.0

