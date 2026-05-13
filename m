Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB81481FCA
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691033; cv=none; b=Gy02Y+xfH7n5bZdXN20QQAuQJi4CAAaI2C0G580ZkPAUgLJHn+tFAMnxZiyxBXp3yqTB6DfndiiwGgdlyDqsVN2BNd/aKXIPj/l/s8qGOBf847DK4kzcmJtfbBlRGfbM6gGGnoLE+rg7r9fM1XZsGn88esf4DhxT0jq7UPt5Hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691033; c=relaxed/simple;
	bh=sw1Ea6QD/tQqsM6g6dqnWXK/fQZ92k8rIM4OdgbSqAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJT11FHAbOWqHEmt6OU1JyznJ5F/rMVIVutEddKIj8jeMc55nQsKOP/rkc72I4+GvGZZXw9ZO+PtpJmE3DCFoLpuG+Fkil5X9w5dy0rh18irm/e5LCcCXHqju53/KQBbBiQsLVam6HJWOEC4ofh3ozf07aNwS5luEQeSxkG7aQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCpJxy3Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCpJxy3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A31C2BCB7;
	Wed, 13 May 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691031;
	bh=sw1Ea6QD/tQqsM6g6dqnWXK/fQZ92k8rIM4OdgbSqAI=;
	h=From:To:Cc:Subject:Date:From;
	b=nCpJxy3YrIjRJxCjGeB9QOe2fxy6JButyMTTCqWxovdZuZMIUG3JapztVVDlYb+GT
	 lPaAyDKYLkgEiFtdy0H7TTtZgx3HnXO0WxyBuDuE3oXvie+Aeidvsx+pN2pWIKnOtN
	 GZurIDbWnkwrEzZas864al1iQ9ql5NRTzXw5s5wtnDUlo48CDeqlVxau0ggscyzYde
	 f6mm2dseDfd00ScBK9aimN4392y6URbp1UZitNfzGnxqeaW3a41g7VAGNG7ybZBBbf
	 UZ6h35dImI7Hdjy8wsPoGKoIfhlDaK4lQrEVTedgF0GV/yJuYBh0ELKhQVje8Hcjqk
	 IazkLRIRv1ARA==
From: David Ahern <dsahern@kernel.org>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH net-next] xfrm: Reject excessive values for XFRMA_TFCPAD
Date: Wed, 13 May 2026 10:50:24 -0600
Message-ID: <20260513165028.33171-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Ahern <dahern@nvidia.com>

tfcpad is a u32, but that full range is excessive for padding.
Limit it to max IP length (64k).

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 net/xfrm/xfrm_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 38a90e5ee3d9..e8c31633f4f1 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -937,8 +937,14 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 				   attrs[XFRMA_ALG_COMP], extack)))
 		goto error;
 
-	if (attrs[XFRMA_TFCPAD])
+	if (attrs[XFRMA_TFCPAD]) {
 		x->tfcpad = nla_get_u32(attrs[XFRMA_TFCPAD]);
+		if (x->tfcpad > IP_MAX_MTU) {
+			NL_SET_ERR_MSG(extack, "Excessive TFC padding");
+			err = -EINVAL;
+			goto error;
+		}
+	}
 
 	xfrm_mark_get(attrs, &x->mark);
 
-- 
2.43.0

