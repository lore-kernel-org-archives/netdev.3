Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743037;
	b=eNDMTmOJ/ZWrPRsGnKPNhXV8g8ENm9v7ogeVJ+9omYbI4YoS59nXL7h72W7grgfMKzV5
	 65TO3KBP6EnlKNy/f38I4q/nsGzd9KH4TU/eCemSCAHy+m0fGOiFP5Q65jEPQSAVEAWy5
	 mtj9pSvTXd+9GkvKF6lpQlKFEc+Rke1WGDEZcBlgXsRvLMwHfs+BXJ3D1yBwHirzapE3j
	 HKzmAwyWTB1p0wLz5Z5qMCulHJ7sqJjdCvvJDVlDOIsONipeVB7QV9FLYY1U75907OHJz
	 JiqVPaCosTyJ/qLG8AOZAI954xlE07q9g6W9sz7kYZKsBue4XFqS/z3DcrZztThFgvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Hjsj/Qn6cco0asQU0YaZXGiDQnlGG6v8Jw6AH2fRivQ=;
	b=AGVr/YaiYl3HU2HLrwWCcy7bejHBUfM1e3JutoR8NdVfI0i2Yd7yYNSng4ixtzSMuONX
	 kmm8A94CrEtkeCVoUtzGveB/ytosii4OzC/7yJo2YrjH6B6aNlMXuojBMNts4Oby7GM7+
	 S2CSyaLhE+faJKCw4kk3ksYeNKfOGdQfmhyP2VpB9FWYhvT1ioHwfHsYO7yc2d18UiFEt
	 pXGuL6O70vmFAIwrF4C1Ogc7D56V26eoq5LUbt/3H1o3KzaQTrhtmPfARmXcUin0JntiA
	 CR9IOY4j6gUkF7tujzMe8oKNfBGdUzdem0DPa6Me2pSfSo3y2JRZOHJeZP25pqw0UNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d6C4hTMN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qk+3JUlu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975B606A324
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9975B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d6C4hTMN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qk+3JUlu
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FDhE1767180
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hjsj/Qn6cco0asQU0YaZXGiDQnlGG6v8Jw6AH2fRivQ=; b=d6C4hTMNpEtUC447
	unNLVYCVe7XrfP+HPlZXXy4woRtzXQ8SC52PiAW29aKYJ4nhQhdYmkrA/XXuTItT
	oZY4EW6qKxcGOsSKM+wcttT6RCQT/uyiKBzvNwqDrZyOJ/4YY/qCrBwAbnZqv2qe
	+1wXM+OErzJIFFNEbCEG52yH2IQWDs65RXDMeoNcnNPdX2h1fRUB9oj5UhUizY2Z
	MU68g6lzWXnwjemKCplsSAjS16mx0OLwrfC7WE5AHNydU4fzOQrHDbAlUu4KDcxL
	HoEAmopwGaHyrwzoAse4yOKqtmZPl0RgpYwcE+x/84Hyc0ZH95I1oNew2ndSDQeI
	BDZWJw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahu3d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cbf2fd504so113071085a.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743035; x=1793347835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hjsj/Qn6cco0asQU0YaZXGiDQnlGG6v8Jw6AH2fRivQ=;
        b=Qk+3JUlu0MGWc++vCFX1Dux27l5/MQme6NH+EqoK6kzOF2Iix2gGihF7ToBzdtp8+P
         LGU+9GXf7t12Eg4Qk9T00LbKHFZCRSptoi6kFtNiuNdJYU7keTb9TT+DtE9/1Dsyig5X
         hzp9Q3vz2gApJQTA0jjVmGfwGw17le+XnkB+6eK1SI3qHOKgaPz3hOZMZjWsQieihLZA
         5U/4xRgPZWZraIL6rTP6sBsRUa/h9PZ+pu2Ck4TFvqIb0W+zBkgLxu09wZnRd6EGcXEr
         /99tejPx7rcNdzyveSLFPyEAwNBt5wfwqaTaeWBFwOtwiYVXII2dOLBfBZVsp5qA/1j4
         MQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743035; x=1793347835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hjsj/Qn6cco0asQU0YaZXGiDQnlGG6v8Jw6AH2fRivQ=;
        b=0Y+Kk6BwKrT5zRmeDc5bOKnTCCsCXcmjDjFWDHIGrCYaoFf4Gl5NblFl7flYbXHaS0
         cM9ySbdUnVPeMMqlAOULLj98MB6v1gJhaC+FubVjnSBJguwjM0pH9FdCv4PD/4wRvg0c
         ehd/OLFihQtboiKD5IxBpP4L1EDuIG0Oo/NoXCHh0M8S9GwBxdyrU/3pLBNUj7NXXN6X
         0jYcU06neuHp3lSPjwL5OsH+x/KmKjjrhABSKb5xEvs5Mx0xsam4UAyneKTf0jszRwC1
         VorvR+jJZA0GEj3agl8TXbgQhIKGLpMCi3Nx5kXB/kdC+V2qb8Hy+ptakqQ86G9RJlfc
         6/hw==
X-Gm-Message-State: AFq9FYIiACVNVEbRIGnhTc2HpAgTKj2QLEimPFo6sVzb3pbx+JmKqdKn
	lnYZ9SLV4cqtOcvhlhs8oWIGmz3seqQQPZNR8j5i9KlvYgU3KbAouBWVUlU/V5qnnvwW57+G+lO
	++zDfWt6imHPqr1QAj6YVHX4vBqwmf3bQtFrrucZ/iZZSNdWaU/q5El4BxlY=
X-Gm-Gg: AYBFou1tUXJMXs0hRu6vEaV9VFat5l7OINtpNsqbYTLkyHktDDbRC98PHK6gWgD9wyb
	nW7BpCnOsdwb66usPHvVnkicjQ0KhK7NWYR/WRzn7xN2W4G9m4TCmzCG9fGfGilHYBC3gexDyIx
	zJ2o2TfLNy+5UlSKtjJL6cUagLa90HjohFfjkObYLPT0MJjwu14ac1tOoxurYmstm2lshZ3eHbN
	nA3TkkW+iGaJXaQ2IPGPAN4ZClWds/W0r3jNUnuYZCSjfmD7Y3/QuW+dNflYjsTAdPoNOkrr/Hl
	D4o/QlaCv0MaCMXKGvvDEC8VCmIMSgljPjezEQihFF9UkC8i1VWDFatx0GvAIbOReyjfXZiK/Ww
	w2Oelp3dl4o4=
X-Received: by 2002:a05:620a:6f01:b0:93f:322b:2209 with SMTP id af79cd13be357-93f6f7dc507mr282689685a.28.1792743034508;
        Fri, 23 Oct 2026 01:10:34 -0700 (PDT)
X-Received: by 2002:a05:620a:6f01:b0:93f:322b:2209 with SMTP id af79cd13be357-93f6f7dc507mr282686485a.28.1792743033886;
        Fri, 23 Oct 2026 01:10:33 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210361ad6sm55148055e9.7.2026.10.23.01.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:33 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:53 +0200
Subject: [PATCH net 1/6] net: stmmac: take ownership of saved RX state at
 poll entry
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-stmmac-xdp-fixes-v1-1-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX2/wYxRFK1Nzn
 XfRvdA9np3R23++eBA/UrgERF6IciybsW5thZlJ1SDFY6oh/r3kH/UhuirUkaifMllvjQbh5P4G
 wXrlQdeNobLYWYpfffPmMoRxun5HVwU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX7umrBzqOhW6m
 ZxCcWNFYFve3pKbwag8sbDdhCHHEtnp98YhrFvKuT9RG6qxgB6TjkYkNeS104aAuKG82ndTkhoD
 Eo+8AiXQhW0zs45G4rKU3helrPDWPF5W2bNktrcAkqR2J7gN/vx6oag8dJtx0hTAV7t3yAdG3/M
 bBVEzdSiDmVtWUQ75IlmAfmBozHkqIMqFfnofueu87XGQgsyuOgo65TtW9xpyK3eQg/t3ut6am2
 +OMm8WwzEC1R8avAklIeh5yxLriVUhAhfw4Lnip2mSljRVIEtTmVpWzBvgO4iFhctFoj4VtzjUx
 j3IWofZo82WMEOHaribzq+QXZHXQ94JbKYMKjxhLuYd7wD8wVrLuEu8FoknkX6OcSh9w6XVywK5
 JBO4+b6Va6Iuc7nQYAbhj/Cmq2xZX/nxAuVag5dUNYJVGNba3lETyHih9fNfCRt3ji1HSjb6gIq
 I8J22k1IeNiKwYAgKDw==
X-Proofpoint-GUID: YxmS1rLFM1Q4qztKyg5WN5s8I7kGxpVZ
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb167b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-gjLCbu4MZEjzEcwt_QA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: YxmS1rLFM1Q4qztKyg5WN5s8I7kGxpVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

From: James Hilliard <james.hilliard1@gmail.com>

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned.

Track the frame-in-progress flag independently of the status read from
the next descriptor. The old code keyed the save on the status of the
last descriptor looked at, so a loop stopped at a DMA-owned descriptor
(rx status not yet valid) could drop the saved error/length bookkeeping
in stmmac_rx_zc().

Drop the saved state both when the queue parameters are reset and when
the ring is destroyed. stmmac_reset_rx_queue() is reached from
__stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
stmmac_enable_rx_queue(); without draining it there, a partial frame
saved before suspend (or before a queue is disabled and re-enabled)
survives while cur_rx and dirty_rx are re-armed, and the first poll
resumes that stale skb with descriptors from the freshly initialized
ring. __free_dma_rx_desc_resources() releases it on teardown.

Apply the same state handling to stmmac_rx_zc(), which also leaves
state_saved set when a saved frame finishes at the budget boundary.
That path saves only error and length bookkeeping, not an skb pointer.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 72 +++++++++++++----------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b20e5038eead..fba21599a5e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2182,6 +2182,9 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
@@ -5629,12 +5632,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int count = 0, error = 0, len = 0;
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	u32 rx_errors = 0, rx_dropped = 0;
 	unsigned int desc_size;
 	struct bpf_prog *prog;
 	bool failure = false;
 	int xdp_status = 0;
-	int status = 0;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5645,23 +5648,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		struct stmmac_rx_buffer *buf;
 		struct stmmac_xdp_buff *ctx;
 		unsigned int buf1_len = 0;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		int res;
 
-		if (!count && rx_q->state_saved) {
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5700,6 +5705,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
@@ -5772,7 +5779,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5814,9 +5821,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
-	int status = 0, coe = priv->hw->rx_csum;
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	enum dma_data_direction dma_dir;
+	int coe = priv->hw->rx_csum;
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
@@ -5836,25 +5844,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		skb = rx_q->state.skb;
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state.skb = NULL;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		u32 hash;
 
-		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			skb = NULL;
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5883,6 +5894,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -5895,11 +5908,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
+
 		if (unlikely(error)) {
 			dev_kfree_skb(skb);
-			skb = NULL;
-			count++;
-			continue;
+			goto next;
 		}
 
 		/* Buffer is good. Go on. */
@@ -5973,9 +5985,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;
 					buf->page = NULL;
-					skb = NULL;
-					count++;
-					continue;
+					goto next;
 				}
 			}
 		}
@@ -6032,10 +6042,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Remove FCS if needed */
 		if (!fcs_stripped && pskb_trim(skb, len)) {
 			dev_kfree_skb_any(skb);
-			skb = NULL;
 			rx_dropped++;
-			count++;
-			continue;
+			goto next;
 		}
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
@@ -6060,14 +6068,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb_record_rx_queue(skb, queue);
 		napi_gro_receive(&ch->rx_napi, skb);
-		skb = NULL;
-
 		rx_packets++;
 		rx_bytes += len;
+next:
+		in_progress = false;
+		skb = NULL;
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
+	if (in_progress || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;
@@ -8412,6 +8421,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
 }

-- 
2.56.0

