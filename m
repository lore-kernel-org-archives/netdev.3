Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C5420879
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446359; cv=none; b=L0ZoxjJAGWHFloWnUZiP58hePjyyMINgqB45FEwMnASjNnm4hPqJHboC9Xauh/kcTmqrSeng6UgFP/uif7yaccUkyGP8QHS6K5KeKhBR6hsygxDKkTfXEysFF6aqlR3ol5QVAytij13nEF2EW2CxRpuQX80r9Vj1fhJwPL+QDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446359; c=relaxed/simple;
	bh=eEs/YQV/qeA9HZI+EBdLncpxBy0xa/0PUPdxwQPtSR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=fP1sOidGREGCRRao/hbY1mrwX39J0TPhIMmnLawdWBZTP0udTGgPSboFJX1cRpiUrJHr6rWuKpSXV80fZnbIevaGE3ke3DQN2dCxAtZpB76cc5FIM4Aq2smIDJ481/b3KUbiqmg22L3fc6tzkmu00jszP7kZrc4fT2//JsTtosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vS115uFR; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vS115uFR"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174556euoutp015154957414102b5d1bd6037a8b5c6133~AEwMiU0OT0163301633euoutp014
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707174556euoutp015154957414102b5d1bd6037a8b5c6133~AEwMiU0OT0163301633euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446356;
	bh=EouyGj5sjPo+B4PHzNf53hocta38XiCJlMuSXmrEmIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vS115uFRSA9jV+Q2D5fuZY7+w6Rjcc+W6YeD6PNNC3CVtcfRF431uRrj3+M9swFe1
	 Ae9pPmdRxYoXVUX2lRIEOA6RePzwAhFE8sGYYpt9P5fWQAljiRIbAtq9rXFVg6rayM
	 Kat5FZ0lyVtB7lSfUVBQEcONyZaPIeF8N+K+Wc2w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174556eucas1p141142a61e5669032194f9eedf6393895~AEwMImIM00456104561eucas1p18;
	Tue,  7 Jul 2026 17:45:56 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174555eusmtip23cbd0982b060a2d218f86b6508de3608~AEwLe3I761463414634eusmtip2R;
	Tue,  7 Jul 2026 17:45:55 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 1/2] net/stmmac: Check for STMMAC_DOWN flag in all
 XDP paths
Date: Tue,  7 Jul 2026 19:45:50 +0200
Message-Id: <20260707174551.1264558-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707174551.1264558-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
X-EPHeader: CA
X-CMS-RootMailID: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
References: <20260707174551.1264558-1-j.raczynski@samsung.com>
	<CGME20260707174556eucas1p141142a61e5669032194f9eedf6393895@eucas1p1.samsung.com>

Currently STMMAC_DOWN flag is only set/cleared by stmmac_reset_subtask(),
to notify driver to stop processing of TX/RX frames. One of these processing
paths is for XDP, but it is only ever checked in stmmac_xdp_xmit(), which
leaves all other XDP paths vulnerable to processing data while interface is
restarting.

Make verification of STMMAC_DOWN flag consistent by applying check to
all XDP paths.

Fixes: 8b278a5b69a22 ("net: stmmac: Add support for XDP_REDIRECT action")
Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..b9ffff001baf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5260,12 +5260,18 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 				struct xdp_buff *xdp)
 {
 	bool zc = !!(xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL);
-	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	struct xdp_frame *xdpf;
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
 	int queue;
 	int res;
 
+	if (unlikely(test_bit(STMMAC_DOWN, &priv->state))) {
+		xsk_buff_free(xdp);
+		return STMMAC_XSK_CONSUMED;
+	}
+
+	xdpf = xdp_convert_buff_to_frame(xdp);
 	if (unlikely(!xdpf))
 		return STMMAC_XDP_CONSUMED;
 
@@ -5310,7 +5316,9 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
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

