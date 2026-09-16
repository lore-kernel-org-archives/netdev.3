Received: from prod-dose-smtp-2.daouoffice.com (prod-dose-smtp-2.daouoffice.com [35.216.41.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42897399892;
	Wed, 16 Sep 2026 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.216.41.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525966; cv=none; b=KN7raPHHX+8wrnegOGVMVktJLIxKemeUf9BPoShE+8KPMyQr4SUnqlOKjgCHLHJsgOOe1q7dpzFZwsaFcyxz1FtXuOw5e25/oBMDz5W54UhGULe/fb+g3iPbBezkSuooi1HMxHgRI1Gt9Lr692+Qw7WNUM98V905hwpw+DeerPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525966; c=relaxed/simple;
	bh=td6z8OOnq27AUhhjoCxNOWf9kEpdYb0FDq6/KkiIGdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xeo7s7PQhOazSp8LhnugY7+CwvukHfXcQacI4VipNQ6PnUbohpGK/6QmvlhdpuO3JynsHxpmFgkV/gjTIsa0nnSba83GC9c3J2xNE9e+c21k9U557N5zMZzsbdaSakBuQiZWe007rt1moa+20NDi8cfBs38SMSCfbUpn9pj1Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com; spf=pass smtp.mailfrom=pribit.com; arc=none smtp.client-ip=35.216.41.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pribit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pribit.com
Received-SPF: SoftFail 
	client-ip="106.245.249.210" envelope-from="his1415@pribit.com" 
Received: from [106.245.249.210] ([106.245.249.210]) 
          by prod-dose-smtp-2.daouoffice.com ([10.37.10.9]) 
          with ESMTP id 1789525901.216075.140358845105728.prod-dose-smtp-2
          for <>; 
          Wed, 16 Sep 2026 11:31:41 +0900 (KST) 
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
Subject: [PATCH net-next v2] xfrm: add ARIA CBC and CTR support
X-TERRACE-DUMMYSUBJECT: Terrace Spam system                                  *
Date: Wed, 16 Sep 2026 02:31:35 +0000
Message-ID: <20260916023135.26043-1-his1415@pribit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TERRACE-SPAMMARK: NO       (SR:11.88)                     
  (by Terrace)                                                  
X-TERRACE-SUPERWHITEIP: pribit_com_packetgoOS
X-TERRACE-SID: 1789525901.216075.140358845105728.prod-dose-smtp-2
X-TERRACE-CLASSID: Terrace Spam system                                      

The kernel crypto API already provides ARIA implementations, but XFRM
does not have algorithm descriptors for them. Consequently, ARIA cannot
be selected for ESP through XFRM.

Add XFRM algorithm descriptors for CBC and RFC3686 CTR modes using the
existing cbc(aria) and rfc3686(ctr(aria)) crypto algorithms.

The CBC and CTR modes have been tested with IPsec using strongSwan.

Signed-off-by: Hong In-su <his1415@pribit.com>
---
Changes in v2:
- Drop the duplicate "aria" compatibility alias from the CTR entry.
- Use a 128-bit default key size for CBC.
- Document that the CTR default key size includes the 32-bit nonce.

v1: https://lore.kernel.org/netdev/20260909054530.7861-1-his1415@pribit.com/

 net/xfrm/xfrm_algo.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
index 70434495f23f..7ed84220ad5d 100644
--- a/net/xfrm/xfrm_algo.c
+++ b/net/xfrm/xfrm_algo.c
@@ -512,6 +512,33 @@ static struct xfrm_algo_desc ealg_list[] = {
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
+			.defkeybits = 128,
+		}
+	},
+
+	.pfkey_supported = 0,
+},
+{
+	.name = "rfc3686(ctr(aria))",
+
+	.uinfo = {
+		.encr = {
+			.geniv = "seqiv",
+			.blockbits = 128,
+			.defkeybits = 160, /* 128-bit key + 32-bit nonce */
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



