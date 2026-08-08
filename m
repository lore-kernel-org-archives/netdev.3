Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7042FE074
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150615; cv=none; b=fMFHIs6aVFL1VrDKnmED5O/c7TFTLaoR1F+9FJWSAjW53yI4RU/sxKEuBE7tIRTfN3nmsQ0q2gXlM1+q4O4mtt1hruNBEmN2E9IeA/8TNgIsr9Jea0ks3EfYMQCepExJV978OEX9G8l22ZPgd669Ze0HRt7J8cWdZsUSchSLjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150615; c=relaxed/simple;
	bh=T0RjTWuQ+2/lL9aoFWrGRiZzgtI2eOK8+W6T0zf9pak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+D8eyRcoPj9Bu4IqTRakLeq3FF9vgXGJUJ7O1+BVDBpqdfDUOd1LVOvWa1SxRwXgAzdPkX09DISnsyXSLO3yTnyFFN5Po0fa6QbZ2jlRUPvqs2CG3eFGirX+ZRB95bCwNzMGCZ1k8cFDtQXp1KaLmAOzWfeUz1OZEJZO80foGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6F7gfOL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6F7gfOL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e347638adso124167a91.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150614; x=1786755414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/1TzYDcUXNZpa7mQIBzWuP+KknfPHzOJXzXsgHlbeQ=;
        b=f6F7gfOLiiL6pdiBs3AMPsiBuVIyZQlGPVyBZTetDX5rpVdNr/1M1tyghxMs4J9wnq
         oI54r+CtoEMjck1rnojGkFz+7mfkbYNSPD6l+I2uK+sh6SLkIgFUI/YFLTDk/5NSba0Q
         EHhc54tQHztgkAd+sgmGOK4lRMsf1cESS99iGUOcPYva7o3waCw3w56ELAe77uvnk/Pk
         jWGrPcu2BPMwexu7xQ9oEzBgxGPh2CEej5sS3pD1Xdshlc4XAhca87ihaM1TOiV8R3Su
         Z0mtF/1esEH4VA54af8xCkFVcVHgPmk9GiGS426mNFLec5Zh9Dj+wPGO6z9kOsikMBeP
         Hn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150614; x=1786755414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/1TzYDcUXNZpa7mQIBzWuP+KknfPHzOJXzXsgHlbeQ=;
        b=iKvuQHqq9SrI9DmvNMISU8M5c5Tu7HkXtMX791xD8poFdgF/69Crp1CjggJCHbAsRf
         BQ6nM53Ic86WvAv2bFnD9o5GN6AltIckDVGyAKPAM9lSF8FMNGPZNRA8aKqd/NJRO5Zk
         52W9neOalRd3IY2MaDQeMbQhpWP2wnvhy1J4/xOGmDTfq/8AbIJblaSJ9HH5F4wRqzAZ
         WYPonaon3YZ1KCbbH7+1SeZuVpNAxhY0koGvuyygWtbd8qWbzLAbbOvwk1xDn5cybgEs
         16hhKKIGi2xFlVY8C9R62iE3pzmHGWOQPT8EQwkqFUn4zkykXWY3MvtjLTr9UbEOtFev
         xSig==
X-Forwarded-Encrypted: i=1; AHgh+RpQLxo3wKuy2WluEXgakh02lkgEaBI4+hfE8KV3mNMwzVlqpg50BxgYvcqagyc4u6xwMppKEKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGLsGwYbQwYRWEtQ9xnNd5kaMSpyog8OYiXo/mYWWPFfLuKvJ
	L/6NeKEdFyzewEgGWEQOCcvNBzGwzuNm1K6xeyZHfWyXj2gQBuLAOzvc
X-Gm-Gg: AR+sD133zMK0D6WKsTcGArjkxFmZ21XcItAhBoVLPYCbO6YNV1Ha43SWVTMKlOjkYxW
	Odr0o0zCfuOeg5OWlYCWi2VImR60eS12rm8U1smYHQL4vfvfTbtQEO44YYM2MgPXruhfRvlAJDN
	Kza2ECzoh3wBxL9WrfXw1OeMSiYg5H/LVLsXFMfzMIV7TuisowVxSiDxQEm1ldBNXbx3YeOKjCu
	nCDKQah0t58/QyE2m8+LmsDwxIOTMBm88xgk7NlUsKOCnEmKIG43MBjSTfpN43vkL7+5z26GX4n
	o6pXIvYwEgAXf02ZzwYftyP0NGc/i5V8RCVNR6+kky0VKTzIR2eTW/MUCaz662yCw9q2kK15VGE
	b6ocPo2dW+qkbcGB5AeifVYsQl7P0a7XOBGPhQJrSpqI4qSP4adlK3Q2UP3uW50wKx0RIljM29X
	/NDu2z4f5JITTSQKHc6xe96/CzfYOldalMPbxnT4x4B2fCFFAiQ05ng40pGMSSC7aItLYY6sAFf
	ibvW56F6PQJ5O1KNtkPDwdHZ9zVyFvQ6cfpKq9/rho3hPh73Oo=
X-Received: by 2002:a17:90b:2e46:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-39282430494mr3914716a91.11.1786150613992;
        Fri, 07 Aug 2026 17:56:53 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:d7e9:6449:7464:1dfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm4205182a91.2.2026.08.07.17.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:56:53 -0700 (PDT)
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
Subject: [PATCH net-next v6 01/10] ipv6: add ip6_del_rt_reason()
Date: Sat,  8 Aug 2026 09:56:33 +0900
Message-ID: <20260808005642.26901-2-sigefriedhyy@gmail.com>
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

Add RTA_DEL_REASON and enum rt_del_reason to the rtnetlink uAPI, and
add ip6_del_rt_reason(), which takes the reason a route is being
deleted. It has no skip_notify argument: a caller that records a
deletion reason wants the notification that carries it.

The reason is unused for now. Subsequent patches propagate it to the
deletion path and report it on RTM_DELROUTE.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/net/ip6_route.h        |  2 ++
 include/uapi/linux/rtnetlink.h | 25 +++++++++++++++++++++++++
 net/ipv6/route.c               |  8 ++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..cc045705862d 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -126,6 +126,8 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd,
 int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 		  struct netlink_ext_ack *extack);
 int ip6_ins_rt(struct net *net, struct fib6_info *f6i);
+int ip6_del_rt_reason(struct net *net, struct fib6_info *f6i,
+		      enum rt_del_reason del_reason);
 #if IS_ENABLED(CONFIG_IPV6)
 int ip6_del_rt(struct net *net, struct fib6_info *f6i, bool skip_notify);
 #else
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 27265fd31e5f..3988b51db539 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -399,6 +399,7 @@ enum rtattr_type_t {
 	RTA_DPORT,
 	RTA_NH_ID,
 	RTA_FLOWLABEL,
+	RTA_DEL_REASON,
 	__RTA_MAX
 };
 
@@ -407,6 +408,30 @@ enum rtattr_type_t {
 #define RTM_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct rtmsg))))
 #define RTM_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct rtmsg))
 
+/* RTA_DEL_REASON: why the kernel deleted the route. u32.
+ * Emitted only on RTM_DELROUTE notifications, and only when the deletion
+ * path records a cause. Absence means either an older kernel or a
+ * deletion path that does not (yet) record its cause - consumers must
+ * treat "absent" and "unspec" identically. New causes may be appended.
+ * Currently only IPv6 deletion paths record a cause.
+ *
+ * The attribute is notification-only: the kernel rejects it in
+ * requests, so a notification must not be echoed back verbatim.
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

