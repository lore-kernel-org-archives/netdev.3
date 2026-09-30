Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9659317173
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763019; cv=none; b=X4TErYT7ANUHEaOueRXFPjfQ0EXMdJo6AVUoojKapmvZ0k5jW+S3hBQUqN1QiKTlaMo2a1ZTdi/35Sv/PuZ385pl697h17xhFAhQvgfoTZxJXEVtPnFOiJ5dM6wFIzAccf9AiDUoWmYP6/brF77sogN61p16o899NXehrQBAPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763019; c=relaxed/simple;
	bh=Q5AkoNztmUhqfq/M4oFXRdYxicGteR+QcwAAPrg1Geo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkuAkf72fQkZmOuNmW6tJVaBbZgGwR+Tlp3+GnUBh4CMzTXl9rxusVyzCt+7Bot5UFWVvNIMdwSfJK4i44AB3camH0hmSsQ7LlMXfUBhBAtcvHXN8IAd3jp3xx4ptkPha1cZt9KElEpUPMJJQ5eI1M1X12l0ggYTg9KgqFPrNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qN9qmlv/; arc=none smtp.client-ip=91.218.175.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qN9qmlv/"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q5AkoNztmUhqfq/M4oFXRdYxicGteR+QcwAAPrg1Geo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790763013; v=1; x=1791367813;
 b=qN9qmlv/8QcEOSl+1thrlcRMRU+eCgNLyDOHFC7iSt/sMM51b+US/nxxccMEi+wCzsKwPNxN
 EYDjgmi7QfPdQXPlBJJtQveL80iw2tJgUS2pqrGP140EdyXkjatSiFV3/+glT1dttWBYhZAFc8m
 n72WdU1MTRffI5B0cIEYQzuI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f03b88fa8acaa0b7;
	Wed, 30 Sep 2026 10:10:13 +0000
X-Mizu-Trace-ID: f03b88fa8acaa0b7
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	VEGA <vega@nebusec.ai>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] tcp_bic: fix divide by zero on max_increment == 0
Date: Wed, 30 Sep 2026 18:09:30 +0800
Message-ID: <20260930100937.206377-2-jiayuan.chen@linux.dev>
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

max_increment is how many packets cwnd can grow per RTT, so 0 makes
no sense, and bictcp_update() divides by it.

Reject values below 1 when the parameter is written.

Fixes: 83803034f423 ("[TCP]: Add TCP BIC congestion control module.")
Reported-by: VEGA <vega@nebusec.ai>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
Target net-next since it is not a big problem.
---
 net/ipv4/tcp_bic.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bic.c b/net/ipv4/tcp_bic.c
index 65444ff142413..27d2e38ff7932 100644
--- a/net/ipv4/tcp_bic.c
+++ b/net/ipv4/tcp_bic.c
@@ -27,15 +27,25 @@
 					  */
 
 static int fast_convergence = 1;
-static int max_increment = 16;
+static unsigned int max_increment = 16;
 static int low_window = 14;
 static int beta = 819;		/* = 819/1024 (BICTCP_BETA_SCALE) */
 static int initial_ssthresh;
 static int smooth_part = 20;
 
+static int max_increment_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops max_increment_ops = {
+	.set = max_increment_set,
+	.get = param_get_uint,
+};
+
 module_param(fast_convergence, int, 0644);
 MODULE_PARM_DESC(fast_convergence, "turn on/off fast convergence");
-module_param(max_increment, int, 0644);
+module_param_cb(max_increment, &max_increment_ops, &max_increment, 0644);
 MODULE_PARM_DESC(max_increment, "Limit on increment allowed during binary search");
 module_param(low_window, int, 0644);
 MODULE_PARM_DESC(low_window, "lower bound on congestion window (for TCP friendliness)");
-- 
2.43.0

