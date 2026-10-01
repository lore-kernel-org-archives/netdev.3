Received: from mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B663F0750
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854256; cv=none; b=bs+/ZouE8z19A5ZLG2ALBE9QRCym0oi6w8XnPsrcPf0DHvzeQqF4fjI9w5sTIL8Lks1RYiI+Zznoo6jYK/ohysa6L4plCxQQJXDmzVKzNyt/x0yV+PDSanzq4X7IDHDWyhcIY7X6yBnwOcuyjCmSvXu2vWfFWfWblGfskkz0HlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854256; c=relaxed/simple;
	bh=x+Oyc+mIHQbj+rIt7MH4GY0poqNIrSWauSWjBGRoLwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU2Di3GdxxfKVqCzgPZFyuYGXZYGyYMjNApSp/DCplgUSNR9OnuTJDJ6Zr9hl3Yf90ZpeMNorVSFPY3isolSZbIYwAaKiFKsKiKRyCSnzMJSGCiii5k7PudrFQype+hwhv+wOnXw3Ue+BKNT5XV0nxV4/0r/xS087YCdo5pDx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=poqJq+5M; arc=none smtp.client-ip=91.218.175.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="poqJq+5M"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x+Oyc+mIHQbj+rIt7MH4GY0poqNIrSWauSWjBGRoLwY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790854248; v=1; x=1791459048;
 b=poqJq+5M7OGEZtEyCo5TTXeamj1yBag/+BGeRBr7s1tY0H0HH4Q465FPe6c795grNQpgbtor
 F0WRHCmzAXMb2sXXc4BIn0YLZEffHcSecsxFEXwva5OVOMeKQU3t6Cz01/qAPYnKw6rHKMgETAt
 2mYSLUTl18ZXvxVfERLNRq/c=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b4c826c531023aac;
	Thu, 01 Oct 2026 11:30:34 +0000
X-Mizu-Trace-ID: b4c826c531023aac
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and endless loop on bad module params
Date: Thu,  1 Oct 2026 19:29:43 +0800
Message-ID: <20261001112948.322463-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001112948.322463-1-jiayuan.chen@linux.dev>
References: <20261001112948.322463-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

beta_scale and cube_factor are computed once at module init. They need
1024 - beta to be positive and bic_scale * 10 to neither be 0 nor
overflow: beta == 1024 or bic_scale == 0 crash right there, and other
out of range values give garbage. Negative beta can also make
beta_scale 0. Reject them.

A small beta also gives a small beta_scale, and (cwnd * beta_scale) >> 3
truncates to 0 for a tiny cwnd, so the TCP friendliness loop never
ends. Make sure beta_scale is at least 8 at init, so this is always
>= 1 with cwnd >= 1 and the fast path is untouched.
This also caps alpha_cubic at 1 for beta < 512, which only affects
such unusual settings.

Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
Target net-next since it is not a big problem.
---
 net/ipv4/tcp_cubic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 119bf8cbb007c..33b383e1307fb 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -504,12 +504,21 @@ static int __init cubictcp_register(void)
 
 	BUILD_BUG_ON(sizeof(struct bictcp) > ICSK_CA_PRIV_SIZE);
 
+	if (beta < 0 || beta >= BICTCP_BETA_SCALE ||
+	    bic_scale <= 0 || bic_scale > INT_MAX / 10) {
+		pr_err("tcp_cubic: invalid beta %d or bic_scale %d\n",
+		       beta, bic_scale);
+		return -EINVAL;
+	}
+
 	/* Precompute a bunch of the scaling factors that are used per-packet
 	 * based on SRTT of 100ms
 	 */
 
 	beta_scale = 8*(BICTCP_BETA_SCALE+beta) / 3
 		/ (BICTCP_BETA_SCALE - beta);
+	/* bictcp_update() needs (cwnd * beta_scale) >> 3 to be >= 1 */
+	beta_scale = max(beta_scale, 8U);
 
 	cube_rtt_scale = (bic_scale * 10);	/* 1024*c/rtt */
 
-- 
2.43.0

