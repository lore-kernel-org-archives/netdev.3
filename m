Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC093F1064;
	Fri, 11 Sep 2026 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106974; cv=none; b=W+zyiXhzROdkcy5ZwAVk8Yf8/GrRYr/f9KBSA8+RCZfOCUJflgD77bCe4DS2wcLck/DCh8vO2/VZqEVMjozFnPKAuks6RLKZC/mlUMwOK5niIubaQw54HwhvQxTMbzXuPLl9EwaybGYZ/lRd+OOjT/BBq/fFGpWumAyVepOSk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106974; c=relaxed/simple;
	bh=xpHi2y93RUA82E2fdr76LYWr3ZVpPGRzmMYKFfoF8cg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hbCqdoC7+hLscU65QztbvbpTeY/FQCtjjNJajF7O3x125YmngcHNiiQUeqlTysJ5m7N+x+wFH4ZM+FbceInabAdxrbvadpiHDIx2QeIjoY/uOjVs48DPWGB2SZAm0WDM4Xu1LKAquOk+Cvnemw3+/KSlG1mBpwt+jnem3udOvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hF3KgBxq; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hF3KgBxq"
Received: from seu.edu.cn (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d62c4fbb;
	Fri, 11 Sep 2026 14:09:26 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH RFC net] icmp: skip IPv6 probe lookup when IPv6 is disabled
Date: Fri, 11 Sep 2026 14:09:25 +0800
Message-Id: <20260911060925.94441-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08f15cf2e03a1kunm4e9390461c736a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSEMeVktPQh9KSUgdGB0dSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=hF3KgBxqm9FQc10dxrhDQVgwF7X1D5cyk7ofVIypZc1KG8L3kE1DQyv6bwh/xwP9sG0zZlYwbiaowBLS9+xpuN41L6dVVmp3v7dV04QO9o1m0ItIamHxlj9kp4UhsP/njeKzSFQYYYGj8qUidv/Dw1hZ7NlHlgnTgT6LlDZBLUM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=9sYhRjdJJhunqm8Ev2yVmyNONJv2TlPA3Rb+eceYvhc=;
	h=date:mime-version:subject:message-id:from;

With CONFIG_IPV6=y and ipv6.disable=1, inet6_init() skips address
configuration, leaving inet6_addr_lst unallocated. An enabled IPv4
extended-echo probe can still request an IPv6 address lookup.

Check ipv6_mod_enabled() before the lookup so the existing no-interface
reply handles this case. This fixes the new lookup-internal NULL access;
it is not a patch for the removed IPv6 stub ERR_PTR sink.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: d98adfbdd5c0 ("ipv4: drop ipv6_stub usage and use direct function calls")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 net/ipv4/icmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 0caedfc7ca92..d8683b0151b7 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1360,6 +1360,8 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 		case ICMP_AFI_IP6:
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
+			if (!ipv6_mod_enabled())
+				break;
 			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
 			dev_hold(dev);
 			break;
