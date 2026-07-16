Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858F43F0B9;
	Thu, 16 Jul 2026 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187113; cv=none; b=OrX+O55ej0/rsEgjElPcbg0zL9o7CXuD7vEINlpoFP02H9jEBoTvJLNNWFVZ6sMXQ1TElrNW+weCs5DdX0bcKSXfkIppDza0aaKeq+h3sRhYap8ffzV2QJfJyW0HCWDkfHtfzViWCnKm/HSqCyuZ4t/m2kaXDFKAbv4dOXWuq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187113; c=relaxed/simple;
	bh=qVBjct/4FSbp/lTowy14ehat9srNnwRVSv+9n61qO3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2TbfK/K2uDL/Dy2NtKwVL2JR06BZT9GMT3DLMJDvc4CFH6w5NMcnuLsAmINW3LGr9zxP7DfjRvj/TFZLwW5vcQ697r++8cnIQgekwSIZwXYfEjMeloISuFVZCLlYscgg6VY/axqUE9cW2wxzhbw6C7BAf0ruqOfvup4j1ucPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 61b80dc280e811f1aa26b74ffac11d73-20260716
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ef98318b-9b93-4073-95dd-58be883efd48,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:ef98318b-9b93-4073-95dd-58be883efd48,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:b3e6e2f899dd81e4c165f96a7ff2a441,BulkI
	D:260716153139LFYB9YIR,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61b80dc280e811f1aa26b74ffac11d73-20260716
X-User: tanze@kylinos.cn
Received: from desktop-od00ebi.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1200005047; Thu, 16 Jul 2026 15:31:38 +0800
From: Ze Tan <tanze@kylinos.cn>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tanze@kylinos.cn
Subject: [PATCH v2 1/3] net/9p: handle replies racing with interrupted RPCs
Date: Thu, 16 Jul 2026 15:30:49 +0800
Message-ID: <72509c9d98f3ac1baf656176b351710a4b1ac0f8.1784186316.git.tanze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784186316.git.tanze@kylinos.cn>
References: <cover.1784186316.git.tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A reply can arrive after io_wait_event_killable() reports an interruption
but before the client starts cancellation. In that case the request is
already complete and must not be flushed or returned as an error.

Recheck REQ_STATUS_RCVD before entering the flush path in both regular and
zero-copy RPCs.

Signed-off-by: Ze Tan <tanze@kylinos.cn>
---
 net/9p/client.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index ef64546c6d52..b9860ccb224b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -612,6 +612,11 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		err = req->t_err;
 	}
 	if (err == -ERESTARTSYS && c->status == Connected) {
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+			err = 0;
+			goto recalc_sigpending;
+		}
+
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
@@ -697,6 +702,11 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		err = req->t_err;
 	}
 	if (err == -ERESTARTSYS && c->status == Connected) {
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+			err = 0;
+			goto recalc_sigpending;
+		}
+
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
-- 
2.43.0

