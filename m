Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C547D951
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326873; cv=none; b=n21jpdv52f/Fp59AFwucc1Q95l4MHoGmuV77LRmPU+We27yI0Jmt4cONGOkbFU5rb307I6qCGdSPmirNxZ5SrLCSWtpwvsG0kSN8cSQAaYjG7o4vVw/nMzA2k4Am93AD3L7oq2FhE2S1IsX8cDCwv6VBZJo+BnDVr51B1asTEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326873; c=relaxed/simple;
	bh=T4d/PEXZNs6ifbkGXcXMa8zZC7Ih8RIE41MHYVn0pWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZWrlRRa4lFKFr8LbUCg35UgvOXP+AP/JBu6espJgIyvFOWzHirlp0P2m3NevyQjE4YOYQAbkX9g87pxrtyC5AFq4qEOhaiQnoqRWPwt3uvEgYwNG2avH5zOzkO57EM0NV2zYAhW/h41FCTn9tn4pBnKmkYTvK6a/0bctZ/13XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNt+XKOn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNt+XKOn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a2dcede83so1115114b3a.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326871; x=1785931671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVlBM8baZnY3XWsIGKCw1XL7pOs30aO7ASNtPvRepdA=;
        b=PNt+XKOnhX/EPNNCiBWo8RTgiHhweWM5g6HHyheIX5827OmSahCH1U5lg3X41gmoSI
         svTtJ8MeUaeINtqbS65xAA/+cQ8HDnYG6Ted+J8SZLvg6G20Zww3qCJZI8XZUExMJ557
         ivYXe4NSWWMWvd4TorjlTx+Jka12+urAHBn/f6593+uzbvXlWfUpmLhBkfBNLHRxR1hq
         DSHr+B7CNVAYRH+kyGn5XLhZKyc6x/KrhdPLdU/uzE8zkUr1wwUYxF2U+kFIu8ozgRED
         n9HpP9azBN6lpIJm4zyeXiYcGlKueEjJ4lnrIx9fETtQSIYS8JkyHj9LThqTQQUIVEch
         LoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326871; x=1785931671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WVlBM8baZnY3XWsIGKCw1XL7pOs30aO7ASNtPvRepdA=;
        b=iMfQ+4kfOXoxTpNzhnS4zGXHXTGCiOUXXXTDDkfVVR6P30za1hwHuvbCiMZE2ZkVlO
         JSFnavsclqEibYpv+QtJOpHMKgCizUcKLPVqFZAhQQqLLW043qCv9S9NIsII9O4zlaII
         K2ZkIJckSjZ6h2/Yg/iHYwUCDmk8ixxdP9RMyGa3fCGMvgErJZpl9i8ia++gBpSf22nN
         Sij2QrkH+QJaUIRSX+oA9pn5yIy7YKp28bUNj7LuoDnLd2GJeqmJ/E6T/0nlHF6V7lW0
         hfLBYmH4XbFjlY13PG5uobjc2AEXC8VKGUynbDh8g9PKaON0bvbhNUirm1DoYBRMAVOR
         UUYg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8wiMuRmRmQbVxFrN1kjh7CQB3V5TrLLLmzcHmasFxRoBTGGeQ2tAq+4HcgeAXMSf4O0n6LSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDEPH0WEqzVpeSMRorIZO1iaoRvOPia4e8fA4NrI+H7XNsIwu
	IQU39HWlCBcv63RUYgSxArs+3KQlPvaWR+bpGxKtvyJGRupl3rIhJJIF
X-Gm-Gg: AR+sD10/HsVtud5cSSK9dyqshx7VxM8xdAv6CLtJNthOWwpk1OpywkgAysQMcfL7MRA
	hd1MoLYpfvNUGdJ0SiKoIH79F2qeFsQw21h7ds80kyLV3/TduUvttqTk80CEmb+mU7SbcSkbic0
	XktCL6TsQq3O1fMk4eOyBlxTY16nQT8lz4uk8Xj7hrx0aLh2hk6JeF8fvNOtLNKd/uo/Gg1+IwT
	bI8hpvbJ3Rcvyi5OZu8oE2wGbAGKjVNCQSq9Cjfrww1W7YiXsMZA3TrgG/XedMn69Zop0BWwB/C
	Up0ouDWylJwUEjf7T3EgUuu9tvqv04pyn+hvH8sFY+EOf7iMMUnlA3YG8R2yK4+AC4jzTcYbf7L
	wYt2CaqPKyaHdm9FyvEffZbl+kyzZB7RTk07jofVZIJRlg4WbfiHIjO2E61O4pVz3in1DKoRD50
	PAmKWFEEF9ZWne3it/4c53Sny7GSqA29dZamFwPLBnsqfXfDrd2GjpXF5Eu0lOBy5FUsEF0PhvL
	UBHNGh1YCURrT5dq0UMXc/c95092whTtamXhQ==
X-Received: by 2002:a05:6a00:94d6:b0:847:8b11:5966 with SMTP id d2e1a72fcca58-84e931b4c84mr7075564b3a.1.1785326870437;
        Wed, 29 Jul 2026 05:07:50 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:c705:d3b3:a6d9:8512])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm1263482b3a.35.2026.07.29.05.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:49 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
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
Subject: [PATCH net-next v4 01/10] ipv6: add ip6_del_rt_reason()
Date: Wed, 29 Jul 2026 21:07:30 +0900
Message-ID: <20260729120739.47880-2-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729120739.47880-1-sigefriedhyy@gmail.com>
References: <20260729120739.47880-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RTA_DEL_REASON and enum rta_del_reason to the rtnetlink uAPI, and
add ip6_del_rt_reason(), which takes the reason a route is being
deleted. ip6_del_rt() becomes a wrapper that passes
RTA_DEL_REASON_UNSPEC, so its callers do not change.

The reason is unused for now. Subsequent patches propagate it to the
deletion path and report it on RTM_DELROUTE.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/net/ip6_route.h        |  9 +++++++++
 include/uapi/linux/rtnetlink.h | 17 +++++++++++++++++
 net/ipv6/route.c               |  8 +++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..92ad5a0d03a2 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -128,12 +128,21 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 int ip6_ins_rt(struct net *net, struct fib6_info *f6i);
 #if IS_ENABLED(CONFIG_IPV6)
 int ip6_del_rt(struct net *net, struct fib6_info *f6i, bool skip_notify);
+int ip6_del_rt_reason(struct net *net, struct fib6_info *f6i, bool skip_notify,
+		      enum rta_del_reason del_reason);
 #else
 static inline int ip6_del_rt(struct net *net, struct fib6_info *f6i,
 			     bool skip_notify)
 {
 	return -EAFNOSUPPORT;
 }
+
+static inline int ip6_del_rt_reason(struct net *net, struct fib6_info *f6i,
+				    bool skip_notify,
+				    enum rta_del_reason del_reason)
+{
+	return -EAFNOSUPPORT;
+}
 #endif
 
 void rt6_flush_exceptions(struct fib6_info *f6i);
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 27265fd31e5f..fe00e624f3c3 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -399,6 +399,7 @@ enum rtattr_type_t {
 	RTA_DPORT,
 	RTA_NH_ID,
 	RTA_FLOWLABEL,
+	RTA_DEL_REASON,
 	__RTA_MAX
 };
 
@@ -407,6 +408,22 @@ enum rtattr_type_t {
 #define RTM_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct rtmsg))))
 #define RTM_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct rtmsg))
 
+/* RTA_DEL_REASON: why the kernel deleted the route. u32.
+ * Emitted only on RTM_DELROUTE notifications, and only when the deletion
+ * path records a cause. Absence means either an older kernel or a
+ * deletion path that does not (yet) record its cause - consumers must
+ * treat "absent" and "unspec" identically. New causes may be appended.
+ * Currently only IPv6 deletion paths record a cause.
+ */
+enum rta_del_reason {
+	RTA_DEL_REASON_UNSPEC,		/* cause not recorded */
+	RTA_DEL_REASON_EXPIRED,		/* RTF_EXPIRES lifetime ran out (GC) */
+	RTA_DEL_REASON_RA_WITHDRAWN,	/* zero-lifetime RA / PIO / RIO */
+	__RTA_DEL_REASON_MAX
+};
+
+#define RTA_DEL_REASON_MAX (__RTA_DEL_REASON_MAX - 1)
+
 /* RTM_MULTIPATH --- array of struct rtnexthop.
  *
  * "struct rtnexthop" describes all necessary nexthop information,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a1301334da48..9f82829923ab 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3994,7 +3994,8 @@ static int __ip6_del_rt(struct fib6_info *rt, struct nl_info *info)
 	return err;
 }
 
-int ip6_del_rt(struct net *net, struct fib6_info *rt, bool skip_notify)
+int ip6_del_rt_reason(struct net *net, struct fib6_info *rt, bool skip_notify,
+		      enum rta_del_reason del_reason)
 {
 	struct nl_info info = {
 		.nl_net = net,
@@ -4004,6 +4005,11 @@ int ip6_del_rt(struct net *net, struct fib6_info *rt, bool skip_notify)
 	return __ip6_del_rt(rt, &info);
 }
 
+int ip6_del_rt(struct net *net, struct fib6_info *rt, bool skip_notify)
+{
+	return ip6_del_rt_reason(net, rt, skip_notify, RTA_DEL_REASON_UNSPEC);
+}
+
 static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 {
 	struct nl_info *info = &cfg->fc_nlinfo;
-- 
2.43.0

