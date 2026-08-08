Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60191C84BC;
	Sat,  8 Aug 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786186958; cv=none; b=X2V3Zi/BLmX3v/wuBnpoL118oV4jJUV6gYh4nViJ/PHNFC6D6mrf6YYQujkvJoeEAHbzNe972N2pcTQXugqPi4VytW6nA6Cl6P1arW4YNyqszHT2HOgpPhPbiZz57mm2E7HjDOu8kt89eXuRRf0aUqaPU3GA8jN4pc8ZIq5XVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786186958; c=relaxed/simple;
	bh=ZX8DEm/tchk9zoG5qv++1CkRgB9/GbbbuxDx75UCUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWt2VMOunXpMUCHuoMB2Ixpll9r8HM2ANXU+tGJJnLHxQAH482yRC1arxyzxEH2BB26nGilZJY+adZh2nS3xwPnHbUhV/0XBO+/vOr8dkeuWdOjTXBVlanHBf0boVCzwDfax+xpwuYn4S66rG336VjPENOhbKC4v3FzQzKaFIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hlzng+hb; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hlzng+hb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6E
	EFqsqlqUNUW19mDTieOJor4R28eegdtmINXcoUzDw=; b=hlzng+hbpucpkxEkeP
	jedZ+5NoB3Mp+p4GJSbwuNnxhBWsgul2CE504Uye6NPfiT7EuGxsyb61WczMPt+8
	einbRaXrO9kuFr1o3km/aip8BZpWVO9bZ95/4fqQORnF45Co/cCtaiOlN6B8kIIZ
	Xl80YcMw/AyK0y1KJd7DqCGmw=
Received: from deepin (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPSA id Ms8vCgD3HRZyDHdq7Y1xAw--.25025S4;
	Sat, 08 Aug 2026 19:01:43 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH net-next] tcp: use likely() for srtt check in tcp_rtt_estimator()
Date: Sat,  8 Aug 2026 19:00:54 +0800
Message-ID: <20260808110054.6892-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgD3HRZyDHdq7Y1xAw--.25025S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFy3Kry3ZrykWrWfWr4Uurg_yoWfKrgEka
	s29a1kuw4xXr4xZF4DZw4Ygwn8GrZ3JFyfCr1fJFWUK34UJan8Can2kr9rZrnY9rsrGrZ8
	Arn5WFy5ZryI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNRegYWp3DJevVgAA3c

In tcp_rtt_estimator(), srtt is initialized to a non-zero value
after the first RTT measurement (srtt = m << 3) and never returns
to zero for the lifetime of the connection. Thus, the "srtt != 0"
branch is almost always true.

Marking it with likely() helps the compiler generate better code
for this hot path.

No functional change is introduced.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5b6378b94..a4c4d4760 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1089,7 +1089,7 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 	 * does not matter how to _calculate_ it. Seems, it was trap
 	 * that VJ failed to avoid. 8)
 	 */
-	if (srtt != 0) {
+	if (likely(srtt != 0)) {
 		m -= (srtt >> 3);	/* m is now error in rtt est */
 		srtt += m;		/* rtt = 7/8 rtt + 1/8 new */
 		if (m < 0) {
-- 
2.51.0

