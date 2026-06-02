Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6592C21C7;
	Tue,  2 Jun 2026 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360229; cv=none; b=JPC76djTKjUpTnWgsS8ZKJArOHbT7Vx1JCkSBNHEM6kzSExa5w5q4IX+fC8PnqbzHHEpGG0L2NiQAeeb4EISMA7PJ6RKiagGQkyq2gheK35Fr1WvFaIzZHzPeOHr4URHbodfbygydqJPhmm/CldGTHf8ps5BKd9cNMWNEHLDuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360229; c=relaxed/simple;
	bh=MYZMelWdI1c1RUTBJwC+vAruQPtgmq8YDan79uWO1H0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPPAU0DQAKd1TpSScBIugslSCfpae9huGdUgksDqklsr6RJeEGxRf7CQUsrk8sYHsi6N/7voec+eCiWpUDxAnm4JPjRJexFaup2f4BUOo9RAqOQhBFDmf72eVcWUtkaZjg3v5WqREzkd3uE87Xq3JmYI59QHK/6ELsgXApSIk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=GpcpjZWH; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="GpcpjZWH"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40a8c3cb7;
	Tue, 2 Jun 2026 08:25:15 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	edumazet@google.com,
	horms@kernel.org,
	david.laight.linux@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net v2] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Date: Tue,  2 Jun 2026 08:25:06 +0800
Message-Id: <20260602002506.1519901-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e85b8667703a1kunm4cf733bc14f30f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0hJVk9KHh8dTRpMS0hIGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=GpcpjZWHfeE3blNnugiPvEaJMVJkpOKozboq7MwVaUlj71V/QTF5Joz+ynDDTafRjgqA1SzibH6fwDoHkTM9XazDVwL52+cJ4Rnl0UPq3QtnihCbbLAOtOAzBFfTjN14YQobjkcbcMYSwzJm3G1sv9rdlU/Wxfv6kCQZs040gfI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=PAs4YotzjN+LG8SuuNUltAd/vJ5Y/sDzOViO5aMsfjk=;
	h=date:mime-version:subject:message-id:from;

ipv6_flowlabel_get() reads flowlabel_consistency and
flowlabel_state_ranges locklessly.

Use READ_ONCE() for these sysctl accesses.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Shorten the commit message per review feedback
- Drop the Fixes and stable CC trailers

 net/ipv6/ip6_flowlabel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index b1ccdf0dc646..1ab5ad0dcf24 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	int err;
 
 	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
-		if (net->ipv6.sysctl.flowlabel_consistency) {
+		if (READ_ONCE(net->ipv6.sysctl.flowlabel_consistency)) {
 			net_info_ratelimited("Can not set IPV6_FL_F_REFLECT if flowlabel_consistency sysctl is enable\n");
 			return -EPERM;
 		}
@@ -633,7 +633,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 	if (freq->flr_label & ~IPV6_FLOWLABEL_MASK)
 		return -EINVAL;
-	if (net->ipv6.sysctl.flowlabel_state_ranges &&
+	if (READ_ONCE(net->ipv6.sysctl.flowlabel_state_ranges) &&
 	    (freq->flr_label & IPV6_FLOWLABEL_STATELESS_FLAG))
 		return -ERANGE;
 
-- 
2.34.1
