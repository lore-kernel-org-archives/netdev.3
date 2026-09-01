Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23663EFFD4;
	Tue,  1 Sep 2026 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230644; cv=none; b=HZKcxAn6S7ouI8YzQUr7wX00KsGf37a8BixxFJTFhFYSHm2dhvzxW8TidIorih6nNJzIW/3P9X6ANZyk6zTndgBRy3j3umP8Q8wfy64CJ0oDa5OSEJRDYwK0Yt6Dv+r9KTVdh97mY/ypUc5B/IyM6wJp/S3r9GXtijpmcb5qCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230644; c=relaxed/simple;
	bh=MWpT/0P1Af7d09VLzwF2GmeaI7uTka5XJYtq5CvCkps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biDE15jFqP1AK+Z3SF7MO6UCF/WjZJo487i2WsrigQoa97z59HDPBAiirAXzLG2GH3MRloDVdQr3OM43oHNgeCHTsterGJk7fCZQwy+nYG7O3rLKxddVFclfTsSkNG4DT4z0hxDmcJNWiT7xc5cLxlu27QFA0KGrv310WJgotxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hT3I+iRw; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hT3I+iRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=H3
	1g108x3AGghVZiee+8fPu3Xnu7PnV0hFSaohOMJko=; b=hT3I+iRwvjJmeMQ0yn
	knE8hXfMlNB3B3wzUvkNpcazKLHrVw5wXbpV+CdSrBm+RKkbZibvJzp8BqcCwXtq
	Kvo1JLf2ONkwih2HtDXIHeaoFf4dV5HQG3EX/+EjK4YSUyi6cJ+NLWOiRl7Hgfxl
	VCXkqBqEn34VuEDqz2HFzN60Q=
Received: from deepin (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgCnaf8zOpZqjCNzBQ--.36566S2;
	Tue, 01 Sep 2026 10:36:36 +0800 (CST)
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
Subject: [PATCH net-next] tcp: fix mdev comment in tcp_rtt_estimator()
Date: Tue,  1 Sep 2026 10:35:38 +0800
Message-ID: <20260901023539.6986-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgCnaf8zOpZqjCNzBQ--.36566S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWDtF1DWFWDZFy7Cw4rKrg_yoWDGFcEka
	4jkFWUGry8Xw42qw4DAF4YyFZ5CFs7A3WSgr1fGayqkw1UJF4fGan2yFy7X3W3CrsIkF93
	Zwn0q34avr1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIhTbnGqWOjT9awAA3V

The old comment "mdev = 3/4 mdev + 1/4 new" only describes the
common case. However, when RTT drops sharply, the code applies
a finer gain of 1/32 instead of 1/4, resulting in:
mdev = 31/32 mdev + 1/32 * new.

Express both cases with a unified formula using variable
gain g.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 net/ipv4/tcp_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf..2c9feb181 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1108,7 +1108,10 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 		} else {
 			m -= (tp->mdev_us >> 2);   /* similar update on mdev */
 		}
-		tp->mdev_us += m;		/* mdev = 3/4 mdev + 1/4 new */
+		tp->mdev_us += m;		/*
+						 * mdev = (1-g)*mdev + g*new, g=1/4 normally,
+						 * g=1/32 on sharp RTT drop
+						 */
 		if (tp->mdev_us > tp->mdev_max_us) {
 			tp->mdev_max_us = tp->mdev_us;
 			if (tp->mdev_max_us > tp->rttvar_us)
-- 
2.51.0

