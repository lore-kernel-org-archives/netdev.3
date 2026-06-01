Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A530146C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331596; cv=none; b=KWMn+LRoK0g9cVzlazq1CKUtzro/0e5OvRXys9YPh3Z2aE284830jB1Ow+pTy0zQGApAHz4BvzIjxmwy0f1nIkU3mzG2UZUyPmoBjftXZFv1a1/4zXbP/sF4/4sWMKMwgj22dGKs9TyQvrrnkUPohj6TXt+2lLC86nwQblP4Ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331596; c=relaxed/simple;
	bh=MrT8KCpNuJ2beuJ0fBZyYSQeC1y2cht3fAid+dBOeQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JauXrHrhSEI1ehxzEnAn8MqLbDiVjQbuP6LLUuq+RTMYln4B4FE75rDdmQ7w5G+qfK2fNnle1dxlvy8yRBDpueJvfgLhkAQkTDLXPEaz4B5QuLAIIlwikJorNTl7k+9e6NIGdJrKles5iUE8NOvgCdFNQ4gfzK3fKax9O6bN/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hbPD9o2i; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hbPD9o2i"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260601163313euoutp022c4ba4df8c0588794c5bdc9088481b33~1AibxTn1H0786707867euoutp02V
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260601163313euoutp022c4ba4df8c0588794c5bdc9088481b33~1AibxTn1H0786707867euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331594;
	bh=CwVX9Xlp1GxUSggNQyPTSVCeqeA8PpQKM2TtfU6IUbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbPD9o2i6p7TiY/7esmf9y/wuEKlgwa1qe+M54zJkAJNSgRZ4tOluZqDMSgfzeKB2
	 2R7e67LlhbssFjY02ghfJ1yk/wOzhBaelRHnCuUyQqh64bWeEiwSL9FdUes0vfhyPV
	 1bwL8cnvTnRi8CWmCQCDYPohz5gBQjlATpPdDtd0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3~1Aia6RTyf0909509095eucas1p28;
	Mon,  1 Jun 2026 16:33:13 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601163312eusmtip1876d78af876174606227e42fad1180f3~1AiaSpEkC0917909179eusmtip1m;
	Mon,  1 Jun 2026 16:33:12 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 1/2] net/stmmac: Check for STMMAC_DOWN flag in
 all XDP paths
Date: Mon,  1 Jun 2026 18:32:57 +0200
Message-Id: <20260601163258.554300-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601163258.554300-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
X-EPHeader: CA
X-CMS-RootMailID: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
References: <20260601163258.554300-1-j.raczynski@samsung.com>
	<CGME20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3@eucas1p2.samsung.com>

Currently STMMAC_DOWN flag is only set/cleared by stmmac_reset_subtask(),
to notify driver to stop processing of TX/RX frames. One of these processing
paths is for XDP, but it is only ever checked in stmmac_xdp_xmit(), which
leaves all other XDP paths vulnerable to processing data while interface is
restarting.

Make verification of STMMAC_DOWN flag consistent by applying check to all XDP
RX paths.

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..3a66f2842527 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5267,6 +5267,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	if (unlikely(!xdpf))
 		return STMMAC_XDP_CONSUMED;
 
+	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
+		return STMMAC_XDP_CONSUMED;
+
 	queue = stmmac_xdp_get_tx_queue(priv, cpu);
 	nq = netdev_get_tx_queue(priv->dev, queue);
 
@@ -5308,7 +5311,9 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 		res = stmmac_xdp_xmit_back(priv, xdp);
 		break;
 	case XDP_REDIRECT:
-		if (xdp_do_redirect(priv->dev, xdp, prog) < 0)
+		if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
+			res = STMMAC_XDP_CONSUMED;
+		else if (xdp_do_redirect(priv->dev, xdp, prog) < 0)
 			res = STMMAC_XDP_CONSUMED;
 		else
 			res = STMMAC_XDP_REDIRECT;
-- 
2.34.1

