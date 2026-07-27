Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EB42E8FA
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176071; cv=none; b=Ni1rDgzr8AKxgPTSQ+t2wjRlGl5U/jPFn+s6QSeC5YQa9voukwnNp9HO58MgwWHQdzIMLQiP62xzYm14gt96oHhWCJBc3wb8TGxZp/lcrsUmSI/09nZCIpB5bTlC1vUZybUtzJ6QpkzUYVHHgxdOewMx/jenKlH75ZiR/T8BIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176071; c=relaxed/simple;
	bh=5yebpJwQJI8y9bx3k/I4bthTKeB3t5Ynzh68//cpRGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSrfJNsWdEW5boD3KYUQJCJS/L6QZMIHceW+1hcgiK83bPKfMfJeBge8yXShMEoOwfbGTrYzXoQ9O1iHuF3SmL4Gd8xNCBNS8eacrLKYTi7JVFbvM2SbxRF5zDj+ZZBPWiY+76yDbZTOmx9QzrliCRZkYdtN2w6w7zBdTQSyhiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2wr/Zd/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2wr/Zd/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3209531a91.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785176069; x=1785780869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0op6ZDiFlVikGslY5Mrah8c+5cFvBsdr4/4NzW0IZnk=;
        b=S2wr/Zd/r/UQEBYApKTM0bOgpH4TUXEBh41mYBFpIm+79RbzLoR4SX2WTqlZQwy4Zm
         YNtFa0YtSmrSo1lKpyC35c0IrYaY/N5tLJfd3kDhjYis/lmUmtbfM5QmhG1VCzeA5lK8
         8WSOeuMs7cBqI3yFaxOVpKt3BDgWf26Jte82TqRLTdWi09BXMRypZznEqEJ5SAZNNcLe
         RMMj5QfMRaGGPoy3LJltd6yDr8k5gsmls11ejIt6gon+u6WLd2W07CtAv9Pikk/VP/V5
         vELsoHFT9bMhPrE2C0o0RSnrzyMHR9p1xUQTob1hg9FWUJNjLxIRV6YIy9cHAS9p2n4S
         2Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785176069; x=1785780869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0op6ZDiFlVikGslY5Mrah8c+5cFvBsdr4/4NzW0IZnk=;
        b=WDN0kiSKllTvpAyuFTavmbpZINtnFDvphk0InqXUdCpmjGzbHJ9slvb7vl1qJlb0gB
         vrgqy9AxfTqjKjIdq8RBMj/oQ5/UnRMEh71RiJYG/JsHG7ICHgM3FYmMslIrm7vdJ2AK
         MjZ8j7yUqDuTJ8RxlGA28R71+Z1W1HBoG6thfLldnkP9L+hWfDJqQr4CZ9jasGPD6VRP
         v5GqbX0Bmaa4jUzkawSYf6xGxOFVTQM8r7FVti144R/U6uEKdM9mljBELqXIgX1rQmK6
         F0Lxk4VdazXXDmV0FNg2RomCY6liYu7UAn5f/7duD94357UvFhS4HIJnU0ZXjBo7WMID
         G+lw==
X-Gm-Message-State: AOJu0YyHwz2JbFBjywDLasMzJKHsRM+EVIcQ14nMMmeEqd0hrL6pUlLC
	StVyLE5S2qKyil1dMzLzyrjmQcgW18GdRHVWRMzvUWU3Whul70gKvGOiIWIvssRhP03T3A==
X-Gm-Gg: AR+sD101sasX4CBoNjWBR2VgPXA5mVl515Y5tfurUD7YKQfcKP63IKUCnBCzrhrUejh
	X5HRva1YN2zD9tQf3GVBeLqdIc1ikPWz9byJ5hMGBMIm7LRP1L+mWvp0S3fa1QvF/RP3+btGh42
	LYsG3yU8iXs3LJOhZK+TuRTl32VmSGoxAMCaZO4fGHs/aCTK9zJsuO2fC4xxl7e27JeSxGI6Ek4
	HQLYgWLDClW3rKKCdmzhfvJDEcWOrI9yPB5BYYLkrRY7cS52qtLOs8xfanNQnlwlbQAp/C2Jt/Q
	boqfQGYRQddKdsdE9V4QBKqJyNZFpoTsNmj4DwtqSjAACJqhdJ2EZsl58Y4nzlD2wxTs2d5neJ/
	gQ8aaWfd363lhRg/R2mNewJym3PlvdVTdCyCCL+DRsS8osftS6yrw6TgQqDgGGUnEmuNUvjeZsB
	uqXDlZ5tlyMcOYlZk52/W/pzLaUP278Bk=
X-Received: by 2002:a17:90b:2f10:b0:36d:689a:cb27 with SMTP id 98e67ed59e1d1-38f64906659mr349241a91.24.1785176069040;
        Mon, 27 Jul 2026 11:14:29 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6413fe85sm199851a91.12.2026.07.27.11.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:14:28 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
Date: Tue, 28 Jul 2026 02:14:20 +0800
Message-ID: <3dac596cfe0ad1559c1bd1314dd4777dbcf22ee2.1785058094.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785058094.git.zihanx@nebusec.ai>
References: <cover.1785058094.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

fib_nlmsg_size() still estimates nexthop space as if every gateway is
encoded as an IPv4 RTA_GATEWAY attribute.  IPv4 routes can also carry an
IPv6 gateway, which fib_nexthop_info() dumps as RTA_VIA.  RTA_VIA needs
more space than RTA_GATEWAY, and multipath dumps also store each
struct rtnexthop with nla_reserve_nohdr(), not as a standalone nlattr.

As a result, a route notification can allocate an skb that is too small.
fib_dump_info() then fails with -EMSGSIZE and rtmsg_fib() hits the
WARN_ON() that marks such failures as a fib_nlmsg_size() bug.  With
panic_on_warn set, this becomes a kernel panic.

Add a small helper that mirrors the per-nexthop attributes emitted by
fib_nexthop_info(), account for RTA_VIA when the gateway family differs
from the route family, account for the no-header rtnexthop layout used
inside RTA_MULTIPATH, and only include RTA_FLOW when it is actually
present.

Fixes: d15662682db2 ("ipv4: Allow ipv6 gateway with ipv4 routes")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ipv4/fib_semantics.c | 71 ++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4f3c0740dde9..3b6f6cc9ffe0 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -490,6 +490,37 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
 	return -1;
 }
 
+static size_t fib_nexthop_nlmsg_size(const struct fib_nh_common *nhc,
+				     u8 rt_family, bool skip_oif)
+{
+	size_t nhsize = 0;
+
+	switch (nhc->nhc_gw_family) {
+	case AF_INET:
+		nhsize += nla_total_size(4); /* RTA_GATEWAY */
+		break;
+	case AF_INET6:
+		if (rt_family != nhc->nhc_gw_family)
+			nhsize += nla_total_size(sizeof(struct rtvia) +
+						 sizeof(struct in6_addr));
+		else
+			nhsize += nla_total_size(sizeof(struct in6_addr));
+		break;
+	}
+
+	if (!skip_oif && nhc->nhc_dev)
+		nhsize += nla_total_size(4); /* RTA_OIF */
+
+	if (nhc->nhc_lwtstate) {
+		/* RTA_ENCAP_TYPE */
+		nhsize += lwtunnel_get_encap_size(nhc->nhc_lwtstate);
+		/* RTA_ENCAP */
+		nhsize += nla_total_size(2);
+	}
+
+	return nhsize;
+}
+
 size_t fib_nlmsg_size(struct fib_info *fi)
 {
 	size_t payload = NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -507,32 +538,36 @@ size_t fib_nlmsg_size(struct fib_info *fi)
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
+			nhsize = fib_nexthop_nlmsg_size(nhc, AF_INET,
+							nhs != 1);
 
-			if (nhc->nhc_lwtstate) {
-				/* RTA_ENCAP_TYPE */
-				nh_encapsize += lwtunnel_get_encap_size(
-						nhc->nhc_lwtstate);
-				/* RTA_ENCAP */
-				nh_encapsize +=  nla_total_size(2);
+			if (nhs != 1)
+				nhsize += sizeof(struct rtnexthop);
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
