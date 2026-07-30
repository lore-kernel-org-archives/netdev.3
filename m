Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36683175A6D
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416405; cv=none; b=XYtmUFWb6nF0leSKQ5Hs8WkDcGfxOaV+YSY1xAO2dwmZN2a9M9imwU4qvFUl1qRkGF4go9ixYKogJtlQfyXhYw5DJV/PL/wQWzlUhE9lfQjomk0QpbR+Ft1rmy+fq0X5Y/e8b7Hbvlp31gW+/YJP7ugLQNc9Eg0j8EvF0GZzjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416405; c=relaxed/simple;
	bh=ZzCZgf7zi3PxfRlsedClVlAtAeTeJZnMe7sdpJyZmLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0KOKV0SZrNKmqC2clC3yoRsC/lexpR0zEpPW6+0Z95yCMCk1O22KL7F0RWutmCwxmAROfEd8fiXD6bgVZ3Uf4jXCZw69j5ENCsb7klNfk6prbAP4iR70dCMk/doW6cidMaTY9dD24mfKPjdJrick1w0CkdyTx53Yore0835B/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=hmcms0Va; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="hmcms0Va"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381072761d4so1186268a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785416403; x=1786021203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XW02DbVNfiX4V+H6AfgQPgkkIBldoyelc/rTwEQL+DI=;
        b=hmcms0Va1wjMFUfsv+7BEBhkopTw97/KDo13Josch/qd/JgVNUe0wE00XlS3pI1aSS
         UL7pN8YfdxJ6+EmOjaSn7RLL8xUXUYlfDbC5O3ldnzR5080qN4wuW0aD43HbDh70UmEC
         FF5k0O1vLY3pRv+p+MR+8/WPdNK3Y/A1UolYhtqNV+qoMnF3o4gqEimgXv/kQR1KmjDQ
         ifAVKJAxI5AiN7svEXajQUh4Pn2VfLkBVTR9S03vJ+6WI+8q5y2hH2ibUAasYnZVvwXG
         Kk25lncO7CBG/klaxZjPDrGFZ3DK/VSotD+WCIdKAeYjNQPlVbMfLCHL54zAAH4bB+Qr
         CMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785416403; x=1786021203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XW02DbVNfiX4V+H6AfgQPgkkIBldoyelc/rTwEQL+DI=;
        b=Ym/hvFgOFdZaPtXP24DZcCIHeamAwJe9VKBTbFLqiOI6jWfdtV4bsRUYOhTsTvQm0K
         POEwU77cYUnh02U+dXywbYGzv+evA6R0oHgwcW4Eu/Y5ahF9MFIIRiHNClWR5bNuEMKi
         UVX1/XHAI4pC++34SldWSfd5z7eMR4o2TSHwWD/pHpis9KxPQ8zq7u46Di20bGO1UX8K
         /JP6I287WUKIq561D8zFLx5/OmlMYfVaUCcO7JnbbnS6KACKZUn8zvPOrDsxP5xmajpI
         J8zlH33NrNyQTEhwKDdnQulm6b9RugtpM0iatJgzP4/l7yG2aeRmoTrY0UthEs7pbObY
         g2FQ==
X-Gm-Message-State: AOJu0YxFyWfmImPCIj/tFpIdS/My3+rgNotLuwGKuKF925/W0su7uy3p
	iLMuzjc2bJonGEunlH0rtKrcJr3EMtc3lytlLYKx75Pfs5FNmq4pa5OySOa0y5J852Y+rwYiYL5
	euWQW2UvNcJo=
X-Gm-Gg: AR+sD10gp5AZZGWmp/QiEgms3CqfwaI9ObGkF/+jlHqFFmNxXXA6dvJQ252PkhsO+Ew
	oBqNilRWevlgkv8evuixE8x11eBj3vjpeLjsb94VACBMTtg9LEueK8aJgcvl6vOjRCH72tNqTnM
	yTvOYiq5EgRNpOM8maJ2o29AaeESePD3Wa/yvWUVerejl5bMRciD6GDbQTFAHF/gQjKtGptCXQS
	rL+Aodd6smrJ90w4F1Ja1DCgGPafBwC56o+mubiDdyZ/utEK2oYX4vgtqqnoH6+E4edR6TaygMl
	1gxg1FErzsAESRvi3udCqzhfPtmQGSgwlGEDTdrJhwkTuVOMBm5lgQnw8Z5wvlV5MeAO+IftjoP
	IVIr4sq3cuXaOMJea7zNXbH6JErNkZfsxO6vpYorTwoNRH6+drm6WH/9zuApzIRcaYUteBIYc/H
	KO5q6RyO6xDfe+orfP8cd7zy30YkNOOl++hvJ/IcoOEo9BScuKBb9dGi6NUgv+1KJH9+fc9zU=
X-Received: by 2002:a17:90b:3c88:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-38f9bdb3885mr1954544a91.19.1785416403242;
        Thu, 30 Jul 2026 06:00:03 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b95ec97sm1019301a91.5.2026.07.30.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:00:02 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
Date: Thu, 30 Jul 2026 12:59:26 +0000
Message-ID: <6f53fa797fcaeb26966432ed7ae9bb87c4961f37.1785411220.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785411219.git.zihanx@nebusec.ai>
References: <cover.1785411219.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_nlmsg_size() still estimates nexthop space as if every gateway is
encoded as an IPv4 RTA_GATEWAY attribute. IPv4 routes can also carry an
IPv6 gateway, which fib_nexthop_info() dumps as RTA_VIA.

As a result, route notifications can allocate an skb that is too small.
fib_dump_info() then fails with -EMSGSIZE and rtmsg_fib() hits the
WARN_ON() that marks such failures as a fib_nlmsg_size() bug. With
panic_on_warn set, this becomes a kernel panic.

Mirror the actual nexthop dump layout in fib_nlmsg_size(): account for
IPv6 nexthop gateways dumped as RTA_VIA, for the no-header rtnexthop
layout used inside RTA_MULTIPATH, and for RTA_FLOW only when it is
actually present.

Fixes: d15662682db2 ("ipv4: Allow ipv6 gateway with ipv4 routes")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - drop the unused rt_family argument from fib_nexthop_nlmsg_size()
  - remove the unreachable AF_INET6 else branch
  - swap the RTA_ENCAP and RTA_ENCAP_TYPE comments
  - use NLA_ALIGN(sizeof(struct rtnexthop)) to match nla_reserve_nohdr()
  - v1 Link: https://lore.kernel.org/all/cover.1785058094.git.zihanx@nebusec.ai/
 net/ipv4/fib_semantics.c | 67 +++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..78f84ae3ee12 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -490,6 +490,34 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
 	return -1;
 }
 
+static size_t fib_nexthop_nlmsg_size(const struct fib_nh_common *nhc,
+				     bool skip_oif)
+{
+	size_t nhsize = 0;
+
+	switch (nhc->nhc_gw_family) {
+	case AF_INET:
+		nhsize += nla_total_size(4); /* RTA_GATEWAY */
+		break;
+	case AF_INET6:
+		nhsize += nla_total_size(sizeof(struct rtvia) +
+					 sizeof(struct in6_addr));
+		break;
+	}
+
+	if (!skip_oif && nhc->nhc_dev)
+		nhsize += nla_total_size(4); /* RTA_OIF */
+
+	if (nhc->nhc_lwtstate) {
+		/* RTA_ENCAP */
+		nhsize += lwtunnel_get_encap_size(nhc->nhc_lwtstate);
+		/* RTA_ENCAP_TYPE */
+		nhsize += nla_total_size(2);
+	}
+
+	return nhsize;
+}
+
 size_t fib_nlmsg_size(struct fib_info *fi)
 {
 	size_t payload = NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -507,32 +535,35 @@ size_t fib_nlmsg_size(struct fib_info *fi)
 		payload += nla_total_size(4); /* RTA_NH_ID */
 
 	if (nhs) {
-		size_t nh_encapsize = 0;
-		/* Also handles the special case nhs == 1 */
-
-		/* each nexthop is packed in an attribute */
-		size_t nhsize = nla_total_size(sizeof(struct rtnexthop));
+		size_t mpsize = 0;
 		unsigned int i;
 
-		/* may contain flow and gateway attribute */
-		nhsize += 2 * nla_total_size(4);
-
-		/* grab encap info */
 		for (i = 0; i < fib_info_num_path(fi); i++) {
 			struct fib_nh_common *nhc = fib_info_nhc(fi, i);
+			size_t nhsize;
+
+			nhsize = fib_nexthop_nlmsg_size(nhc, nhs != 1);
 
-			if (nhc->nhc_lwtstate) {
-				/* RTA_ENCAP_TYPE */
-				nh_encapsize += lwtunnel_get_encap_size(
-						nhc->nhc_lwtstate);
-				/* RTA_ENCAP */
-				nh_encapsize +=  nla_total_size(2);
+			if (nhs != 1)
+				nhsize += NLA_ALIGN(sizeof(struct rtnexthop));
+
+#ifdef CONFIG_IP_ROUTE_CLASSID
+			if (nhc->nhc_family == AF_INET) {
+				struct fib_nh *nh;
+
+				nh = container_of(nhc, struct fib_nh, nh_common);
+				if (nh->nh_tclassid)
+					nhsize += nla_total_size(4);
 			}
+#endif
+			if (nhs == 1)
+				payload += nhsize;
+			else
+				mpsize += nhsize;
 		}
 
-		/* all nexthops are packed in a nested attribute */
-		payload += nla_total_size((nhs * nhsize) + nh_encapsize);
-
+		if (nhs != 1)
+			payload += nla_total_size(mpsize);
 	}
 
 	return payload;
-- 
2.43.0

