Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAA46F4BE;
	Wed,  5 Aug 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936052; cv=none; b=sUlCc5m5NJ7VUlbFeCkn0CLneQwJQ1sSBvWP6L/LzR5bBxPap+4iYDFkHpdKBYfymrFs8NxpP4+He+CXLSvLGcrWXMviQcPJFUy3J65GHHfAXuoZPyNmYJJry22+FbEKx0IguGY6GkFQiLTXH9H2jt3BXG489yau7YNTLz1N2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936052; c=relaxed/simple;
	bh=JMePd5VeyNB0Ef2pt7sFja4wGNwTmMTGZrlBvhZLVP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmGTklQGC2sdOfFJNoVOzblHtY0Z4rZZoQNk/7YRHsj/Ql85bnuf7695+43gxPvTS1WaXLVxHGlTChYPj06SuJ4xYPq14P7xh1hxZ18zADNnYBH67iXFsV5yJUH5t5BQVZkmfgK6Yz/ILiZ8KstfhXaRQpv7jBGbgYZbW9TBShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=As+d/VPI; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="As+d/VPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xP
	XoB6ZXcu+Q1U2yXVUy9XxTUSvKqEZ57BrnkUq1mX8=; b=As+d/VPIpS8hmj96mE
	rWXdx7pTRUsB7prWW32EfDoTTi74gj4tuooA1P/Rn5XloPi9RDnjIc0vaiYRj0u8
	pPORAvi3oz29kGO6hvjXbHWeMVZGukT/0+oDtZ3v6RUsME4paqgqQOstzyiO9oNb
	uK5p0x6xRD49njeFsAwBiy7yk=
Received: from deepin (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPSA id Ms8vCgAXEAeBOHNq1DJBAw--.21228S4;
	Wed, 05 Aug 2026 21:20:21 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH] tcp: clarify comment for mdev_us in struct tcp_sock
Date: Wed,  5 Aug 2026 21:19:27 +0800
Message-ID: <20260805131927.27661-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgAXEAeBOHNq1DJBAw--.21228S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW5KF45Gry5uw4fuFWUXFb_yoWkuFb_uw
	4kZrs2yr1DZFy7Ja18Jr1S9wn3Ww18JF1fWr1rtrsFqw1vkFs3Xw1kJF9a9r4rGFZI9FyD
	Jwn5ur92qF4fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIRWqa2pzOJVHgAAA3G

The existing comment for mdev_us says "medium deviation", but this
term is inaccurate. The field stores the "mean deviation" of RTT,
as originally defined in Van Jacobson's paper "Congestion
Avoidance and Control", and it is scaled by 4 (<< 2) in the Linux
implementation.

Update the comment to reflect the correct terminology and storage
format.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 include/linux/tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 8a6807082..6a8c77719 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -274,7 +274,7 @@ struct tcp_sock {
 	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
 	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
 	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
-	u32	mdev_us;	/* medium deviation			*/
+	u32	mdev_us;	/* mean deviation of RTT, scaled by 4 (<< 2) in usecs */
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u32	max_packets_out;  /* max packets_out in last window */
 	u32	cwnd_usage_seq;  /* right edge of cwnd usage tracking flight */
-- 
2.51.0

