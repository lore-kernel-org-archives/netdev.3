Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7783A6F1B;
	Tue, 23 Jun 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226013; cv=none; b=LrzIyXi35+YmZ9OuQ37+RwqGzjeBfWEA2b9dRsqdHnJcdNk10fm13KCcEEnIBQE347kc0HrMYZ6bQ0ZMc34hoLknPsGBMnGa93YF/xiOVQBqyTCsNiF3NxRMSrryYMg6oa5JqIWiPPqzaBzTN53wZ5mRflmk1a4q9B5tvk3OsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226013; c=relaxed/simple;
	bh=povnuXEA513+gRbbDL0wMhrfNwaSACORlU6Kd9sYe2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKLqJRpRnOsWhO4gMou+luVo+bn3ToALbLsxnI6FPt9gzUYzgexPUG7EMONp5/JoqaNT0XQjTmlb1zEAWLyHFqM9wdE9B0yKYuBZ1puWIcn5A7sLPfwstNtWpjRS8aXhFia2ZMNqZ9cbE8koZt/nwtY2B1zKjq1ZKrWSPaFPPmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Hl6Y/2jj; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Hl6Y/2jj"
Received: from regular-pc (unknown [78.36.167.44])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6997E45F8F2F;
	Tue, 23 Jun 2026 14:46:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6997E45F8F2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1782226000;
	bh=wNJ3vxmx3EP7h0YSCriATTA70ne1vkBpxAunQFVDC3k=;
	h=From:To:Cc:Subject:Date:From;
	b=Hl6Y/2jjuk0jhkjidCWc6DSy5wKN/uvp18jjJ9yJz5p8cKaAR8y26MmMgqCx4ZC+W
	 q95+dyerkL7LLp6pjJ97WUYGZ6ncrNczx8KUYqmevaWScoq9UVVQD+R5Qqbz9LPz25
	 aDfam0TQlxz3mEB1jnkvacCYvdPNwnxkuDunDEbo=
From: Matvey Kovalev <matvey.kovalev@ispras.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Matvey Kovalev <matvey.kovalev@ispras.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] qede: fix out-of-bounds check for cqe->len_list[]
Date: Tue, 23 Jun 2026 17:45:54 +0300
Message-ID: <20260623144602.3521-1-matvey.kovalev@ispras.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move index check before element access.

Fixes: 896f1a2493b5 ("net: qlogic/qede: fix potential out-of-bounds read in qede_tpa_cont() and qede_tpa_end()")
Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index e338bfc8b7b2..33e18bb69774 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -961,7 +961,7 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
 {
 	int i;
 
-	for (i = 0; cqe->len_list[i] && i < ARRAY_SIZE(cqe->len_list); i++)
+	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
 		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
 
@@ -986,7 +986,7 @@ static int qede_tpa_end(struct qede_dev *edev,
 		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
 			       PAGE_SIZE, rxq->data_direction);
 
-	for (i = 0; cqe->len_list[i] && i < ARRAY_SIZE(cqe->len_list); i++)
+	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
 		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
 	if (unlikely(i > 1))
-- 
2.54.0

