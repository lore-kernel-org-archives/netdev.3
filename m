Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89842B72C;
	Tue, 20 Jan 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912744; cv=none; b=NMBQ/2HzHcceQm1RXtc13Pldi+/6LFzD7p+y9RhVuoWRqiyIOrcmkXCBZ9i1oBJmWPOCMJF7kaHSpgJrd/npKbzUCe8TcJJmyPsy4A8sjIgJVD/4Qorna6fdNmxk+RIVp3nGudeG1iL+cIyCxo2H9TemnaGHW1EYPUKgJ8kGRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912744; c=relaxed/simple;
	bh=kCqO2ZJkcDyyuTwrrkKrfVhZlwsoYyDv6tsJCP9WnZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqmWl3X9Hjkb8isDM2FCEZGxgxfTGOzuPfYqpRm6Tf3rhfOus9034V+Zb6c4DddIuJbqgllh2yrAxewRaevgP+dfZRVrORZsDNa/ITxtQkeYnpo6Kk8mb9iI8b9lnVASpoyY7XPB5BRAeglkZUgTo1Hq5SStuB3HkQd3cAW6d6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jFYrdIlD; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jFYrdIlD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oTXEVLgDumVCBFxpbO8s07ckXDCKC5Us7m6vOmueETk=;
	b=jFYrdIlD6scNu1lCaG+lOb4ovAPAm3AE9S1DxjPS7XzWJTmJ91siw+9jJyf+J11uZU12gG9yH
	LrnTfdTLhSwbMToijlqDkRUVizKzS3vHaCZhmU4HQ65F+hNejkdJvNhi2AWqUghbMyFPrVX1hO0
	jCqW7GUZ1Ef7kIbZk0dcWgE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dwRck2hqpz1prLv;
	Tue, 20 Jan 2026 20:35:34 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 924AA20104;
	Tue, 20 Jan 2026 20:38:59 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 20:38:58 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net v01 5/5] hinic3: RQ use RQ_CTXT_PREF_CI_HI instead of SQ_CTXT_PREF_CI_HI
Date: Tue, 20 Jan 2026 20:38:43 +0800
Message-ID: <3e9283e95663ddb23c2f1e5fef05f893af94e8e8.1768911232.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1768911232.git.zhuyikai1@h-partners.com>
References: <cover.1768911232.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Separate the CTX_PREF_CI_HI of rq and sq to improve readability.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index d86cd1ba4605..90887d2bb127 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -162,6 +162,9 @@ struct hinic3_clean_queue_ctxt {
 #define SQ_CTXT_WQ_BLOCK_SET(val, member)  \
 	FIELD_PREP(SQ_CTXT_WQ_BLOCK_##member##_MASK, val)
 
+/* reuse SQ macro for RQ because the hardware format is identical */
+#define RQ_CTXT_PREF_CI_HI(val)            SQ_CTXT_PREF_CI_HI(val)
+
 #define RQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
 #define RQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
 #define RQ_CTXT_CI_PI_SET(val, member)  \
@@ -629,7 +632,8 @@ static void hinic3_rq_prepare_ctxt(struct hinic3_io_queue *rq,
 			    RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD));
 
 	rq_ctxt->pref_ci_owner =
-		cpu_to_le32(RQ_CTXT_PREF_SET(SQ_CTXT_PREF_CI_HI(ci_start), CI_HI) |
+		cpu_to_le32(RQ_CTXT_PREF_SET(RQ_CTXT_PREF_CI_HI(ci_start),
+					     CI_HI) |
 			    RQ_CTXT_PREF_SET(1, OWNER));
 
 	rq_ctxt->pref_wq_pfn_hi_ci =
-- 
2.43.0

