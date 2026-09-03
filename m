Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE540F8E3;
	Thu,  3 Sep 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432290; cv=none; b=Im1xIAUMvX+7+Wb37oO/Wrw0I8/ToF0h/nC6i17Z2RbmZfi775b+yZz+Qiq/oqRHK5gtjUOdtWRkiLjTp2Tip0bY3ZryZOmfxlRd+9wEYnpLT0jnHMCdkGCS2YKRoIT+bzBtOB1kGlbCeCZulHAYQ5/YsVeztkIU2Q2evZEGvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432290; c=relaxed/simple;
	bh=QpI/UgSWvuHbrm4um+SsKOLm27lIxK1ESWRukfP4YpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLhF+NeJHeLoDa/dwbTap9EGhM8LmdInn7STipKSLW6j3IL1ZrYGf2FchTs5mlEmkn3IdxJ+VsyJedhBeJI3xFPgfZXYl9p3Gpm0W9baNp9eDX3sqSOdYjLzgCB/5ImwBtb/a8i5qP1RR+iyadF+XWP7pEbps7sEe4hI1bweKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=E+gsez0X; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="E+gsez0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sr
	3wCpan+elwvh65luVRE7s2DYBBu8bEJj0qSCuyV+c=; b=E+gsez0XpsNM6EA4jw
	bYhF0thBlJTD8sBn99I56vcrPTBg+ooAUFB9+6dNq9h9M8GW1QFWtFSirzU+hQNJ
	SZC/7dV0499LJn/G7R7tyHhJ14e849NpAD4IkjvpOyB+FdONuWttunFKk07Tzk+i
	31ZZR/SKrO9qHRX730vOivHAQ=
Received: from deepin (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgD3P1MvSJlqapWfBQ--.42003S2;
	Thu, 03 Sep 2026 18:13:04 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH net-next v2] tcp: fix mdev comment in tcp_rtt_estimator()
Date: Thu,  3 Sep 2026 18:12:56 +0800
Message-ID: <20260903101256.8879-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgD3P1MvSJlqapWfBQ--.42003S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWDtF45Jw4fKF13XrykuFg_yoWDCwb_Ca
	yjkFWDGry8X3Wayw4DAF4Yya98CFWxAa4Sgr1fGayDKw18GF4fGa92yF9rZ3W7Cr43KF95
	Zws0q343trn3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNhAf32qZSDBUWgAA3j

The old comment "mdev = 3/4 mdev + 1/4 new" only describes the
common case. However, when RTT decreases and |rtt - srtt| > mdev/4,
the code applies a finer gain of 1/32 instead of 1/4, resulting in:
mdev = 31/32 mdev + 1/32 * new.

Express both cases with a unified formula using variable
gain g.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 net/ipv4/tcp_input.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf..b4a6aba21 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1108,7 +1108,11 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 		} else {
 			m -= (tp->mdev_us >> 2);   /* similar update on mdev */
 		}
-		tp->mdev_us += m;		/* mdev = 3/4 mdev + 1/4 new */
+		tp->mdev_us += m;		/*
+						 * mdev = (1-g)*mdev + g*new, g=1/4 normally,
+						 * g=1/32 on RTT decrease when
+						 * abs(rtt - srtt) > mdev/4
+						 */
 		if (tp->mdev_us > tp->mdev_max_us) {
 			tp->mdev_max_us = tp->mdev_us;
 			if (tp->mdev_max_us > tp->rttvar_us)
-- 
2.51.0

