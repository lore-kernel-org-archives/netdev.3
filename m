Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B6255F28
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451636; cv=none; b=PteNXblGHA24KxuqySm3GVwtdVW1FRibHQ7PMV2Ap/xPDjpnWsLBh9Q3ipY4ZJzPDv+7V+8hYWC8czxH6RrBuD+J9O1LS/ScDWUxZw912kjyljNSCj9D1YMwsRjupPs5Oa2PdY0z3BNnYi6f7ukEpRTeOD0xUUGFL9xGXUi9AS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451636; c=relaxed/simple;
	bh=0ck5ithvBGW93geJPgrByTIMhkEmXEuMFvvikU8cDTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEjp9dz4d2o6DtxnRYH46ZLniG6pFVu7rLxJytm9XNfRkyPCoy8aQ8td19pOzSHam3ToAt5qyq9mw7gnX62FoM9rR4UAuPaKlb+1N2b9IXRI4jydqeTTzM5b/38Q2uQ+CPMbak5ZjMyClvPEOYXUeO8y44JOiCp/7WTsoVFWU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f87V4bNJ; arc=none smtp.client-ip=91.218.175.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f87V4bNJ"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0ck5ithvBGW93geJPgrByTIMhkEmXEuMFvvikU8cDTI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791451632; v=1; x=1792056432;
 b=f87V4bNJLD/R0RMDumoF7+sIPkzZ+ehtlGn1A9WEYjv35RdDqyC6nio8i4ZbA/CR2l1mhjBd
 jUTa2lMz5jW76sMp5poFs3diGPOSYxqGg0sZyf0TjiDbX+3lgL3N0TNotZJXJyf4q5Oej6J1Tun
 zGj9HxltqtsAJREUjjk6/oZA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b42e9c1b4e4dd29c;
	Thu, 08 Oct 2026 09:27:12 +0000
X-Mizu-Trace-ID: b42e9c1b4e4dd29c
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
Subject: [PATCH net-next v3 2/3] tcp_hybla: fix divide by zero on rtt0 == 0
Date: Thu,  8 Oct 2026 17:26:35 +0800
Message-ID: <20261008092641.140777-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008092641.140777-1-jiayuan.chen@linux.dev>
References: <20261008092641.140777-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtt0 is the reference RTT in ms, so 0 makes no sense, and
hybla_recalc_param() divides by it right from hybla_init().

Reject values below 1 when the parameter is written. Also cap it at
U32_MAX / USEC_PER_MSEC, since rtt0 * USEC_PER_MSEC can wrap to 0 on
32-bit. An rtt0 above that (about 71 minutes) makes no sense anyway.

Fixes: 835b3f0c0d7e ("[TCP]: Add TCP Hybla congestion control module.")
Fixes: 740b0f1841f6 ("tcp: switch rtt estimations to usec resolution")
Reported-by: VEGA <vega@nebusec.ai>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
No __MODULE_PARM_TYPE() on purpose, same as dctcp_shift_g in
tcp_dctcp.c. It only changes the type suffix modinfo prints.
---
 net/ipv4/tcp_hybla.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_hybla.c b/net/ipv4/tcp_hybla.c
index abd7d91807e54..b9b482180d30b 100644
--- a/net/ipv4/tcp_hybla.c
+++ b/net/ipv4/tcp_hybla.c
@@ -26,8 +26,20 @@ struct hybla {
 };
 
 /* Hybla reference round trip time (default= 1/40 sec = 25 ms), in ms */
-static int rtt0 = 25;
-module_param(rtt0, int, 0644);
+static unsigned int rtt0 = 25;
+
+static int rtt0_set(const char *val, const struct kernel_param *kp)
+{
+	/* avoid rtt0 * USEC_PER_MSEC overflow */
+	return param_set_uint_minmax(val, kp, 1, U32_MAX / USEC_PER_MSEC);
+}
+
+static const struct kernel_param_ops rtt0_ops = {
+	.set = rtt0_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(rtt0, &rtt0_ops, &rtt0, 0644);
 MODULE_PARM_DESC(rtt0, "reference rout trip time (ms)");
 
 /* This is called to refresh values for hybla parameters */
-- 
2.43.0

