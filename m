Received: from prod-dose-smtp-2.daouoffice.com (prod-dose-smtp-2.daouoffice.com [35.216.41.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2E3A4539;
	Wed,  9 Sep 2026 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.216.41.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933567; cv=none; b=nfwpmFzdTh4N0fucL7I1qp7II9J0xUTMhCD/5YEovHirWkcKBbLfrYuY8J0NgJSX+XCoba97lBI7xjSf4IPotihjVYUGrauBFZvrNk6TaDoN6dpkjM+5FLJAnUya4meWqvHSqM9WHT2eoXxJiZL/WmQjHZc111NdpEudUJ0me7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933567; c=relaxed/simple;
	bh=2M2zx9hp3tqqYZmU/CXChcbgNyX/bw3kynPSH8S4Szc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4Ss0TU/lZAMbxIPfD52GtlX+cz5HmxvY/nIbDWYx12s2WAlu33u5DSGH5+2GBsZBYpq5QEeh9a7+jfB9PNQS/+uBcxgb43O5rMKcpN7z+SkAc5JHScJzZ2ac3gcblZq7sWDZy4eg8Blg7d+IjgOzIlw8SH6ZATrMDRFGhSFGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com; spf=pass smtp.mailfrom=pribit.com; arc=none smtp.client-ip=35.216.41.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pribit.com
Received-SPF: SoftFail 
	client-ip="106.245.249.210" envelope-from="his1415@pribit.com" 
Received: from [106.245.249.210] ([106.245.249.210]) 
          by prod-dose-smtp-2.daouoffice.com ([10.37.10.9]) 
          with ESMTP id 1788932748.202706.140060550747712.prod-dose-smtp-2
          for <>; 
          Wed, 09 Sep 2026 14:45:48 +0900 (KST) 
From: Hong In-su <his1415@pribit.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Hong In-su <his1415@pribit.com>
Subject: [PATCH net-next] xfrm: add ARIA CBC and CTR support
X-TERRACE-DUMMYSUBJECT: Terrace Spam system                                  *
Date: Wed,  9 Sep 2026 05:45:30 +0000
Message-ID: <20260909054530.7861-1-his1415@pribit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TERRACE-SPAMMARK: NO       (SR:8.70)                     
  (by Terrace)                                                   
X-TERRACE-SUPERWHITEIP: pribit_com_packetgoOS
X-TERRACE-SID: 1788932748.202706.140060550747712.prod-dose-smtp-2
X-TERRACE-CLASSID: Terrace Spam system                                      

The kernel crypto API already provides ARIA implementations, but XFRM
does not have algorithm descriptors for them. Consequently, ARIA cannot
be selected for ESP through XFRM.

Add XFRM algorithm descriptors for CBC and RFC3686 CTR modes using the
existing cbc(aria) and rfc3686(ctr(aria)) crypto algorithms.

The CBC and CTR modes have been tested with IPsec using strongSwan.

Signed-off-by: Hong In-su <his1415@pribit.com>
---
 net/xfrm/xfrm_algo.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
index 70434495f23f..16c70dc1a426 100644
--- a/net/xfrm/xfrm_algo.c
+++ b/net/xfrm/xfrm_algo.c
@@ -512,6 +512,34 @@ static struct xfrm_algo_desc ealg_list[] = {
 		.sadb_alg_maxbits = 256
 	}
 },
+{
+	.name = "cbc(aria)",
+	.compat = "aria",
+
+	.uinfo = {
+		.encr = {
+			.geniv = "echainiv",
+			.blockbits = 128,
+			.defkeybits = 256,
+		}
+	},
+
+	.pfkey_supported = 0,
+},
+{
+	.name = "rfc3686(ctr(aria))",
+	.compat = "aria",
+
+	.uinfo = {
+		.encr = {
+			.geniv = "seqiv",
+			.blockbits = 128,
+			.defkeybits = 160,
+		}
+	},
+
+	.pfkey_supported = 0,
+},
 {
 	.name = "cbc(twofish)",
 	.compat = "twofish",
-- 
2.43.0



