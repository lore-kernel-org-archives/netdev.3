Received: from mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC73C5857
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763054; cv=none; b=t8tOUCZznmX0PCSJm4kjjNuTSuT9hxaLRVprVem6L+XQhtgfqsMFsSjZkXzkYaMTA/PvKI/o4ZEwTJy3nFlEPeOPF6KJ1zoPVmeHTJ9EZ06QcE2JRyJlsMtYNUAhZjSAkt4KmK+XHPmXT+lU1lu3vi1BgqPqjhYSq5CrJ+5cLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763054; c=relaxed/simple;
	bh=3CNEl1wb0uUqz8+HiIjfNQNAeev6erlf740XPZFnfOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yoyg5XZp/+H7XsRsjqJVfa7/UXsnR8wiGoubBKZ7JuJKC13liscpaDYRdJANEmaX3JXWNZHCYBAR4T/Y/KsJFbqd2vxwWgscpPsJQDXBysQ/7DLoAcTKxQkcHiA6+P3xgN90tw7t9Jzn6LxdVoz041IkS3cQn31fXldz24UKk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qB6bT3Uc; arc=none smtp.client-ip=95.215.58.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qB6bT3Uc"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3CNEl1wb0uUqz8+HiIjfNQNAeev6erlf740XPZFnfOg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790763050; v=1; x=1791367850;
 b=qB6bT3UcwsMtMxIzyzZa8ZZA90cLjX1mBPUzhfC0Z3QRHY9lD3iP/P0HOWuR4WJWOI8H0Sjc
 a+x5TnZoAAFPmYbzkFhFvIevJ/zPBPwmMZ3Yxyry29CxkYf/bxwYAXe262qN33z1JbVFHQQwd47
 MJI3+5yXdjzTQ8hWpSuo5zgo=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 935a19923da1bf90;
	Wed, 30 Sep 2026 10:10:50 +0000
X-Mizu-Trace-ID: 935a19923da1bf90
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] tcp_cubic: fix divide by zero and endless loop on bad module params
Date: Wed, 30 Sep 2026 18:09:32 +0800
Message-ID: <20260930100937.206377-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930100937.206377-1-jiayuan.chen@linux.dev>
References: <20260930100937.206377-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

beta_scale and cube_factor are computed once at module init, and they
need 1024 - beta and bic_scale * 10 to be positive: beta == 1024 or
bic_scale == 0 crash right there, beta > 1024 or a negative bic_scale
gives garbage or wraps to 0. Negative beta can also make beta_scale 0.
Reject them.

A small beta also gives a small beta_scale, and (cwnd * scale) >> 3
truncates to 0 for a tiny cwnd (e.g. 2), so the TCP friendliness loop
never ends. Clamp delta to 1.

Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
Target net-next since it is not a big problem.
---
 net/ipv4/tcp_cubic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 119bf8cbb007c..2f04dca5be095 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -298,7 +298,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	if (tcp_friendliness) {
 		u32 scale = beta_scale;
 
-		delta = (cwnd * scale) >> 3;
+		delta = max((cwnd * scale) >> 3, 1U);
 		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
 			ca->ack_cnt -= delta;
 			ca->tcp_cwnd++;
@@ -504,6 +504,11 @@ static int __init cubictcp_register(void)
 
 	BUILD_BUG_ON(sizeof(struct bictcp) > ICSK_CA_PRIV_SIZE);
 
+	if (beta < 0 || beta >= BICTCP_BETA_SCALE || bic_scale <= 0) {
+		pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n", beta, bic_scale);
+		return -EINVAL;
+	}
+
 	/* Precompute a bunch of the scaling factors that are used per-packet
 	 * based on SRTT of 100ms
 	 */
-- 
2.43.0

