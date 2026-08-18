Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02933C18B;
	Tue, 18 Aug 2026 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043583; cv=none; b=n8TuofxslVftXSNqX4Jbw3YXxUe4PVlNqlZ9CVA9MEDu5HcXdKkfzaKP33Im/20LM/bpNMGWeTei789VV0ImBS8AawxhdBgWBEXEHEYrQCetLv5R9ODneArYRSk+xPSlbLcNnJvbux3ejIOJGGRlrUhm0hKG/gr9HEIw7PsXQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043583; c=relaxed/simple;
	bh=MWpT/0P1Af7d09VLzwF2GmeaI7uTka5XJYtq5CvCkps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdzcjvTr0D9l9CzCOU5XUbJE7VKp9fOIRgVzx2chvJAbEHi11Xno8sSNHCgomUILwDWgqq1HpKjonfoI18PQLN0f1FsTvgsVqMnd4TRrADaUejBVaQheKRYe8nR63KQMdRBt/9i0uTzMyYjjqJ6VvsekikG0RcLbLuh6amlczpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qBD9o/hI; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qBD9o/hI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=H3
	1g108x3AGghVZiee+8fPu3Xnu7PnV0hFSaohOMJko=; b=qBD9o/hI5Xo//066i1
	awO7UdMgEeFokZMExH5oE9Zv28CJAjkN6ZIDKXwqDPTBw7ZkjKc1SgPjyJKczmvh
	bhrI0WIbACz4Mgj1TlLtr6/CUL5+ZTAb1lzswafCmzOn3EAKWiurBOTl9LbI+OjI
	ZcCc216OqfjifMr6lgZGr5xPo=
Received: from deepin (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgD354ZFHYRqM8_VAA--.54052S2;
	Tue, 18 Aug 2026 16:52:23 +0800 (CST)
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
Date: Tue, 18 Aug 2026 16:51:53 +0800
Message-ID: <20260818085153.18509-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgD354ZFHYRqM8_VAA--.54052S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWDtF1DWFWDZFy7Cw4rKrg_yoWDGFcEka
	4jkFWUGry8Xw42qw4DAF4YyFZ5CFs7A3WSgr1fGayqkw1UJF4fGan2yFy7X3W3CrsIkF93
	Zwn0q34avr1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIAcU1GqEHUcMWQAA3G

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

