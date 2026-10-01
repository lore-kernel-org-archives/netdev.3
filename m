Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5040960D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854217; cv=none; b=OXCnJW2+3V6pyCuiMjN6v70GWuUGLmX35YvyfELhUWLXmrFwJDwHq8fLDZvypSRa2QKkx8A6rgF36B3yzNwA8S0oMPulaXiCYr8UcOsugEx57ma4O0U8gCDyZVQDrTKtuoaRd0aONBwjuOOQnWc6y/bDDDtv4g82rmtRbLCyw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854217; c=relaxed/simple;
	bh=SjbMw+wxVwqnc2+u/HZnWR9k+sH+pYYIMyAY1Z6Aovo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8Lkm2f2O/LMq8O8BmF1sjwHf7FXxciEBrNcTUmV7mSImaORqYgWp1nXsf1Lhdg4Y1KgLj9XMP+8QovpXqDcZNUNtFYL6IESlZSFpwmDh1YCtQjaxkCe+zz/3mECSvdYiHAgi2TYTHJMCV+Q08nkBiq+wjRFxHcwCilYuZbzRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TIgy+jJC; arc=none smtp.client-ip=91.218.175.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TIgy+jJC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SjbMw+wxVwqnc2+u/HZnWR9k+sH+pYYIMyAY1Z6Aovo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790854209; v=1; x=1791459009;
 b=TIgy+jJC7yNMTTGxEkdSpv1c5KHB2lBNtWmVhmQGmm2WRNLY4ed9+I7Tuxx/2wTstewiXJn9
 1f2ZdB99oJNB9yFUZXsUAJTic1VvL/+KYC4eDhvtXTAdDSKzgNcS+KZe/NnzY77S9lilOxDkU8c
 /HXjjbz6XvNs15MvIC4fLPMY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d01d38ee60a240a4;
	Thu, 01 Oct 2026 11:30:09 +0000
X-Mizu-Trace-ID: d01d38ee60a240a4
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	VEGA <vega@nebusec.ai>,
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
Subject: [PATCH net-next v2 1/3] tcp_bic: fix divide by zero on max_increment == 0
Date: Thu,  1 Oct 2026 19:29:41 +0800
Message-ID: <20261001112948.322463-2-jiayuan.chen@linux.dev>
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

max_increment is how many packets cwnd can grow per RTT, so 0 makes
no sense, and bictcp_update() divides by it.

Reject values below 1 when the parameter is written.

Fixes: 83803034f423 ("[TCP]: Add TCP BIC congestion control module.")
Reported-by: VEGA <vega@nebusec.ai>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
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

