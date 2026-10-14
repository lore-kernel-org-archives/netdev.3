Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF54E5343
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983399; cv=none; b=G8aqNhFvJHoGOyxWKfs4I3jBNCH3JCtjhJZ0N8lbArpHAsPkPhzx+gMaIdYMAGv5GVvVVP5UYkOe+jmk7706VATQgwC4YK3gZ45G2YB3dRIPkUdRiltodkdh6zLT1gm9awHkjIXA3dhwjTN9ixq7Y3L9wLfUk6SRfvEf3XuYTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983399; c=relaxed/simple;
	bh=FIFNwJbaSxI8VP7uTGpabUdKU9anJ+XUJEb6IpEliOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gG5htfABnSsToSq3yeUhOXN65YGFBTp3LO1NivDDHko/Tbe4kaas1XldHpl8mfauyM9XiAzOBoXaThxm5j/AUug61HrkA6UtDIG/x9eThpW0K9N+twX/697ZCIltZjhIyROvEBK7DDoEsKF4UIPbsrU3fOInlJN0TzlKYInBfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdMrvq32; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVmEfbMh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdMrvq32";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVmEfbMh"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBWlB33365336
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FuauHqAYJcl8PxqGK0q+3PiavaDVcWJtRS+LDFPXsAA=; b=QdMrvq32MuedGw49
	cUwtjRCp/zpa06rkb7rKfPu5yOj1bOD+eN4fKAaHzr6DiT+3bdw/qV/W1iK4jJq9
	6uxSBsY87bA91zyJv1ncWD4p6lwnespSOs6W3plhc1J5O9Lvgy56R4FtOJfvzFE4
	dyzRyodaFT/XnQ8FU9e/YlP239ASklnOh4exLrpwJQwiAZbnJlt50gazBYmc0IEM
	8Tjk1a6Ghi+G8XfddBqZ/5stGUr1xngd/biHVFSgwLOqu/RObyIXcSClH+XJ2lsJ
	+dEssA5cwmd5+s1TJEwMniY5NE8GqO+V7KVxkKi3gGUjMxEoMahWaDNGYEQm4TAN
	5K6wjQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621q9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:09:57 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e91f39ad57so84180e0c.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983396; x=1792588196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuauHqAYJcl8PxqGK0q+3PiavaDVcWJtRS+LDFPXsAA=;
        b=FVmEfbMhIUSqs2SO0BRztHbA34DWNbXq3YjKp2xY9IfdNM1TACAEzdnGUkqt1XCHa7
         uomm2h0lWdgu1DaeIpo33Ku+rvWcneFH/nhTFXUBhu3vJv5xhH3EjTOj0Z+ev3RRpUuz
         QyHCeo3rKUiklRMsDKM4wLMyrzJnp0EwldZLGEwJ9EwPuKmGdqdUWQW7q5KKSAZG1tEA
         qYnoZH9QJ86cy8Uy/KZUBoS1Ojv5WZKQUhUQF52HYE5sTMGlpg1NXVyJmoJ3JosQKAha
         3EeV8uAwUscTZfZrK2tiXApZ+shfAx4kjdIh7Q6agwluYgiSfGCVPF0e3d0HyTUZVfYM
         1N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983396; x=1792588196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuauHqAYJcl8PxqGK0q+3PiavaDVcWJtRS+LDFPXsAA=;
        b=FizoigCNsprgXACPZOLHNz9L2zQ6k21Fzqt2wyoqYNop4W4kb7UDbLkQTWJXBXN6/w
         dwxuCAwj8FFu8KDlTOyhpvyag3fv+Rn8SkdKvA9Q8P9Y5N6DkOOagArEeCsUfGoYUAPz
         arVClIDBQ/Ixht9tqdK0fqvTYmDI7TomGqeRlHuS+sPA86zYnJ2im1MeYIzfgZJpIHmE
         CO2kcEwREGYByibqw6YIcmfnxXy1hHW0x8MH4+WnlZYKXCUjA8OzZXx9KDTQyA+QeD0V
         Fzy5DC/pRMGsNxlm8Uxid/MqVxorRNYCcjRKmBL7jwPSzV3A2P/+7KFbEazL/nNtX+jk
         qbwA==
X-Gm-Message-State: AFq9FYJbOAQ7tEz7uYY+aw9ObIf6hoPYWrIMzkkoCFxvxiSyrOHakPks
	SKf305pS0v/oaFWvKZzdq/dzAHH5rGA9CKS+dr/vDs0E7mPyKpEeReftYX16Ukj/tEThQK/HW3b
	jGQi0v7+eVa7kmfs+ac4UBLuAcGefrhOq9BI1b5yV3+Jz8JIfFCAoR9eq3oI=
X-Gm-Gg: AYBFou3IPJe/TlfuiAjSRLQryl2LQkdjd2S6lCWrGGSxmKumqsVaTheIKMO5GWYXMfE
	826CJJW99ZfXzGzrG7fXCv4bOi9MshPH64Fl41LMfD1pdaZEL2gapH2/7Ma+t6noow+r7AsqueL
	wjkLgjSaX6jTLe93Fae0hGg3CTKC0xrR1fXLZF0PQCqX4RHQJ+LO3/K+zTS6z77ECfYceWRParp
	+6lfGlu5YkpyYiBP7XLUUJmdhwgUddH1/LdZ6Pvz/782Z/1BDAD6IpAoO8ANNiSE3al+5Ka4k3v
	yTpPyBUFKeUSv0BssDsgBZIZpoXPt49jCcA5lOL1WnAeZAAvHNcNUG3ZkEF4DGlUF+lSqiF+UKg
	Qd94t+QyzdSAS2Q==
X-Received: by 2002:a05:6122:3286:b0:5ca:fc48:5634 with SMTP id 71dfb90a1353d-5e91f47b6e6mr4751596e0c.11.1791983396152;
        Wed, 14 Oct 2026 06:09:56 -0700 (PDT)
X-Received: by 2002:a05:6122:3286:b0:5ca:fc48:5634 with SMTP id 71dfb90a1353d-5e91f47b6e6mr4751540e0c.11.1791983395431;
        Wed, 14 Oct 2026 06:09:55 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bcebf6aesm997105e9.6.2026.10.14.06.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:09:54 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:09:35 +0200
Subject: [PATCH net-next v7 1/4] net: stmmac: take ownership of saved RX
 state at poll entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-stmmac-rx-mb-v7-1-5d2d70f052cd@oss.qualcomm.com>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
In-Reply-To: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: CLZ_UFeEvs4_PfDB7VZ_cNMLxiIj0Gd5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX0Wnm4T15metH
 tI0fSpQeuc6Hof5wXA5BgVH4+D3/G8Gezl4A30Me9Uzg6ZMfmT79eco7Lqq8/JYu20OHw+V3frS
 IWcJ7wqPqE/dKaTXMeNW6NwLR3cjheTTycT9kU74NEY+3KJG1fcoCt/16Ntcz9ZHQDegphWKJZh
 NIUPDvqhF9uUE4Iaxv2GW49haiz31oaY6PWIoTZDbxka1yWZl5qKDNVeYRe4npkRfB8r3kk7SES
 oaCzJ+kfyxFYqDubQwV8pj3MHIe84v8vG2es89qr93sUlzkDHY7axyR7MfhaE3XRbMaVPY1V0Lr
 BTNa8J1ZI/1snk2V7CA9ZDMfsw1rUU03QEUFUPQ8GicElsYKO4cO06aLWkm1zQEqlQw8bXuUegi
 abs3hwUy5joDTeDQjdgZKyImvFII1OlfRjnTmUacVU6nwut9Uafov28uuJI7E4BrAjBAO5iGtr/
 CqFK5e2gihQ10wiRuOg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf7f25 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-gjLCbu4MZEjzEcwt_QA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX3BkjuWhHMDKs
 Ibhnw2O8TutpmWyc4PwgMZGOxTImCY5CPTiV06+TUrGDmcDPmmnIovcZYsPRStPWtLFHlpxUtO9
 bggrX9Ve58lJV/TotgpFbG3L0T1j6v8=
X-Proofpoint-GUID: CLZ_UFeEvs4_PfDB7VZ_cNMLxiIj0Gd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

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
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 72 +++++++++++++----------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 56d89a696272..f0835be2f65a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2180,6 +2180,9 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
@@ -5614,12 +5617,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5630,23 +5633,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5685,6 +5690,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
@@ -5757,7 +5764,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5799,9 +5806,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5821,25 +5829,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5868,6 +5879,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -5880,11 +5893,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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
@@ -5958,9 +5970,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -6017,10 +6027,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -6045,14 +6053,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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
@@ -8399,6 +8408,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
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

