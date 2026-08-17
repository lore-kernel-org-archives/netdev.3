Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28857218ADD
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930362; cv=none; b=XgcbQBYxZcSjf41hHA2XW+TBrGNQiDdLkC4qnZqjnYNpxTINOmO8WxgAErvHGOqGDwzUA6TA6G4K2MChq1g/rUyXrqsevg4ovasqur+K2H8rJqcxU7DfygLWwWNBKc2zCRqX3HGZrtuxXYBaFUm9AiDUk9I5+lOKanxf0TmwAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930362; c=relaxed/simple;
	bh=5zxpqjA/kx3Wtv66dk33OanKoqsL0EUGG3wmTXXwJk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjrJvNKQ9eQH7dGaANAqLINzbNSPscJYY50TPLN5HCpqG+rR7oCLdfWIxcqOErQmC/4+wXyliiyv1QzOAiFZQMjyR4y8n62UvuEkp1skR6dj208q05ltiOIoQdmylHSUcM37QzA/BJvlSQAgGYDA9uZQ3rawtSeVkSQxGyMFQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui8SLDCP; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui8SLDCP"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6682259cae6so2108783d50.3
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786930360; x=1787535160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3WhukOejwBNTxs5CHVlgLm9bRECOcG8xzg7md60tu1g=;
        b=Ui8SLDCPHMKVm/8I3kkwBFlwS2dRnZ1tXtxuehpTwVhVl3MjqOiHZuLQeqFT2FHA29
         SamRCJJt3HSId8U2cRdABPW+8FURtUJwNUue9/d3PBqD8IgbJ9SKYhNuuAnD8UBcuq+k
         CbsBLKf3WLwLmqXkXdNOG+Qo/9uRHrCtYrhYN75DhJvzrt9dXiFYEFpuKjPb3bC3MVWz
         rqj2G7mz5r/5/KXRBlEEr+lLgVuzHkUrOqRxXYDfUNXcEqQU+rcWe+OhAbIH50r6knxT
         vw48hnSp8eM38DaToGgySEwMrMM3Mp8R5NeD02jcFs30sxm6CVyySh4ZhxSbf1ctLUoK
         34QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786930360; x=1787535160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WhukOejwBNTxs5CHVlgLm9bRECOcG8xzg7md60tu1g=;
        b=RGmhq1xythgEAE3z4J8coXx1iSckdy874qjLiJNznZiJzoaZsvsHwaoYs9kWSI7zKH
         O1d/8WzlicavAl17k9suGmbdKVl/K5cTycQt2sPBeaR3HTIAS1MAtSo44wMZou9aSn5g
         KT8A1FoAVwHjIvayl17WOA1FsijUiMfe9YpyAc0nKHWdJ25OkszXkk11fRgcEI1li87Q
         PStJGX0JLMhA9JT2fhtJDP7RLgXHvdZ4iJqihZBbFj5qEfIqDeESPZBBa6oSlsg8wI3/
         /9TSMpVounuc0WCdvlh9SePT7FgqKJlzI4GTKNVTyMrsx+AgcrdKrcHeSVZstNzS0j+k
         gqxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTnAejS/wm0ZyKgBpvngbhmE0zXWzOrZtqIEY9cNuyvhFus2Yudh5xwzOmIHgnTER0ZF7sct0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywep7YxqqznyR55XUOvbz3NkUAzCzGm0S1jOit0/fhNUCfk1F6a
	mIim56wn4FZVsF3pk2e/ohmH8/usecjrWO3Ki6IjOpoT74ydnqfGaZKQ
X-Gm-Gg: AR+sD12NBRcVYYO237SQqBYQcNid1Vn+Vz9t45Pvr9qF9TtxrNlfheDBKeNLhlThb4/
	tOdCc/4YyloPuHu8b6t2VvgQbda+OVdIwGuCian9CgNk4yz05HOWP9ZWnz06rXr5g7wdWKIXfNj
	JAuTnvzTodh/6b7YJ5F+MIDmLDgfmjFVttOMeGPWbKTFh0U6DzWfzOOC4Js0XqosCX76iOWlhZT
	Q3AJHtpYyuADAZtzS5pEDGiiQtJIc062tbBqxgBwYSbpFIuheQw+lHzE/dDqRFTlm1Ui7RlLUHr
	u7VZStWn7fH04EmnTLOi9pn1Vb6EeW2vOcdvXFWkhle8/UhtajUgsnJ9WJG5KH63hjeTMwgsspV
	hyOMxky+9cYPM8/FlshKz4LdbBKj+Z+0AuIkg08XQ4v6BxeVYZSqG+WFbF2lOKSVH31nRLz25BY
	hfmz5TkXRxGymoyrtaKM7Eqhk8Y7BgQOnAlH8zhuP1IdZuukJ024jsG8dpPsQobwqHYXg=
X-Received: by 2002:a05:690e:58a:b0:66c:4ce5:834 with SMTP id 956f58d0204a3-66c7259d0a8mr5823711d50.0.1786930360064;
        Sun, 16 Aug 2026 18:32:40 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb41e4389sm28728d50.6.2026.08.16.18.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 18:32:39 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] ipv6: avoid divide by zero in rt6_multipath_rebalance
Date: Sun, 16 Aug 2026 21:32:37 -0400
Message-ID: <20260817013237.2797-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt6_multipath_rebalance() calculates the total eligible nexthop weight
in one pass and programs upper bounds in a second pass. Since
RTM_NEWROUTE is RTNL-free, a concurrent
ignore_routes_with_linkdown update can make the first pass return zero
while the second sees an eligible nexthop, causing
rt6_upper_bound_set() to divide by zero.

UBSAN: division-overflow in net/ipv6/route.c:4845:17
Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  rt6_upper_bound_set() net/ipv6/route.c:4845
  rt6_multipath_rebalance()
  fib6_add_rt2node()
  ip6_route_multipath_add()
  inet6_rtm_newroute()

Skip upper-bound calculation when the first pass reports a zero total.
This respects the lock-free performance considerations here and solves
insecure scenarios.

Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5968ce5ad150..68924cff9205 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4840,7 +4840,7 @@ static void rt6_upper_bound_set(struct fib6_info *rt, int *weight, int total)
 {
 	int upper_bound = -1;
 
-	if (!rt6_is_dead(rt)) {
+	if (total && !rt6_is_dead(rt)) {
 		*weight += rt->fib6_nh->fib_nh_weight;
 		upper_bound = DIV_ROUND_CLOSEST_ULL((u64) (*weight) << 31,
 						    total) - 1;
-- 
2.52.0

