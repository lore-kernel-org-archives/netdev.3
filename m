Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCA4FDA68
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744100; cv=none; b=Un7An7r1JM5aCjbYDBEyPzVYT6YlL5zMnkMwk9nj1QaDcNIvpGApRwNFyrROQ556y3XInOqxPSsNTaFBAaZvAJnGxd8dQUknsj38/fzsqlwuH+ORCVohlZf15SO2LeoAaAfN6oOiUYzpplS4UsN4JOoZyi2rIK+dok4crAhXfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744100; c=relaxed/simple;
	bh=49aWxINg/SXzDP/MwmFDuugpZ+Ixei2L5L+WaGREZOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iKz3nKUdeKix5h9EQ0WoERoacxQTulz8FTNwKOCvLN1j6Br8f9KUmHrldB/jub7XWCLsPRSDZ6z1DLn7fz6e7NyyFi6wiMyKepzSctTPy3eGMgCGHbpAwtUyniDrXysLNlXYw+itfQCXiFFFjy3uMhYpGz6ccHaH/ewQUgl3z8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cFTt8gJ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gDYvRb0v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cFTt8gJ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gDYvRb0v"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOqjI1202149
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OlBe4Pvp148vPgSpn707Os
	b4pDN7dF8jikJ9yczvPEc=; b=cFTt8gJ1rYHep0aW3D2gFJw5MPqCnCV3bkEtfl
	QDbwCPZHybHUEyiMuxg1J+TRtflokDNZyNZ7lHTLlvz0CvppI/t79X/Yfy4qRwnI
	pkcTFysWRVaXag8NLr/4n5+C1QWxASY1+ltswnjhwfq9aCwoEi6oVKDf2e5V8WbV
	nBmzS+dIRqVHh5nS6AQtHF1lmyzhbnFi5Rl4D0IwXYgSIwhAh+LXglQRlfYxvYoU
	XR6/EPA7ah8YLCe+3a8YoemjAqGx0hcvwRn24JQ7/sIvaErbKgvD8q7T21QQjqgJ
	1i8U6LzgK7XnkwINj1vFCG97vxqS+/7L7acbQClxJ4hTnJgg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grxp2tca8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:08:16 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7909e307799so751571137.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789744095; x=1790348895; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OlBe4Pvp148vPgSpn707Osb4pDN7dF8jikJ9yczvPEc=;
        b=gDYvRb0v1ztiLpNkLI4NB+DYqb8UvwiQ4ha3xLC3eIpirrBqTJBswtCFcSNvv8u77z
         +xqIq7MVHCumwk8tIR8LQic1/f3w/UF7nOWzXMBw/Kb1wLD1fI6wGA4b2ReGdsTK1vSu
         DVln2FSk6gfVdZqCnlO9kDeaefGkcBEqtwp1wT6t3itV5Q/p9iJJSi5+eE882v6s6wIV
         WIhCENPC6wzB82pMW6vlNXlZzn3TBVAkQG3CqY8FmY7FC3ypvDRGaDQaiAANlg1vgb8W
         NcBbRp/83rfWiTchzauA7IS+ngTc9wFxkG1HFU/2JJsVA6WZ4hAfb0T59U5NxI4xczOd
         0IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744095; x=1790348895;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OlBe4Pvp148vPgSpn707Osb4pDN7dF8jikJ9yczvPEc=;
        b=JSCBNil3WowNREcv7ODp6sYZ0hCxhVuBN6sauHecHWFjWSbC3w4dOesTkeoEwQ1/Uo
         AE5Nh9tAQQemItSjSh3/f0OA0IU1GLRQxVG6hxd6C0jsMRGxFYLmJoC+YMD3XrPD0T8l
         aDYgFKftv05xIufe4/Lf9ZygHB/5iHKKAMEwsBxPjXejUVA5WRKRsiu7jFaX+0IetlJn
         qqfd11dVwdCsBVm4NdJwgkunL76xz4ekt9/vfOupIgt3g+adExge+7Aq4daApVX4hHkL
         kFC+KyM6hUE2Ql9bd+93vHMl5bBq93C0Wjiy8NCGYjKFED8btSH6q+sI/8uc4vcSb7mF
         FD4w==
X-Gm-Message-State: AFuF++mWl0I1L4EjhdoGgcSu516mXlMNjlMlYqro/9Wk64hxhwakS+4I
	iMeK0E1lpz/S543WPG4tHZp3+qWFKZmeQOuaFrz51GNQVesqmW4Mw7eowq+5pOHeZ/cJQEuUiWw
	7lDrtSsrO0/esCf8r02AIRqlffLpcRFxPoDBSjURtiE6gw+2OJBhiIOBNQF4=
X-Gm-Gg: AYBFou0OLOj4gLCcc/a95F4vByQDQQThgBhdZg93hT/aZCV8H2gw6lwoMJAcZaSpsnS
	sVuyrm+rV8BqCtS6P8/NfXWaGuDGtqsBzwFNwbUzKExx9bsqLuFXUAS9pasHN8sIozapQnpbccc
	Hrm0k/NCX9f2Lnwp4U08L72KGSdF8DhZTuX/GvxzDBO8u3R7DA1azjdCt0QRy6AZ2RgyoNN562S
	B1AMEgWaLo51dbY0pwRKpeh6axhvlr3rAznZpe3K41t/39t2Bz5Y7kgi9MDZ0/N6K2MdkX+LZ4D
	zFtaIXMEmYz6LK1c6gNdsT7GqVf/uBDm13FSpVjAyhgHmz42hce8wpCgwbPXChAoPDsYHKuJ1gh
	fotDing2SMP8nVg==
X-Received: by 2002:a05:6102:5094:b0:7a1:f951:664d with SMTP id ada2fe7eead31-7a55ce8983bmr1351817137.20.1789744094996;
        Fri, 18 Sep 2026 08:08:14 -0700 (PDT)
X-Received: by 2002:a05:6102:5094:b0:7a1:f951:664d with SMTP id ada2fe7eead31-7a55ce8983bmr1351758137.20.1789744094393;
        Fri, 18 Sep 2026 08:08:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7cba562sm38508285e9.2.2026.09.18.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:08:13 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 17:07:41 +0200
Subject: [PATCH net-next] net: stmmac: rework stmmac_rx to support XDP rx
 multi-buff
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBtIEfu5SrQwm2oWWqiEEN09a
 fkt3nsgUWRKMIoHIt2c+AwVshHgDht2Ql6rQbXKtIPsMWXvrcNY0C8ojTaDVZ3UZKEmV6SNy7+
 bIFDGQCXD/L4fpWgTGWgAAAA=
X-Change-ID: 20260918-stmmac-rx-mb-16469a2714ea
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNSBTYWx0ZWRfX8AL4laNdWN/s
 VkB8+LR1AQKz/jVrGsk2zzGpiSprWK26pYeyX5p+NAXwnddS9UYv0JDkq5MGh8goB/4C8i6YQEZ
 hnDb0seeLq+Tf7J3/iq1UrMvvEDPlAc=
X-Proofpoint-GUID: UrWA4aSTfDHQGTvcHUa3jdJQ4gqmR7Gm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNSBTYWx0ZWRfX6ZB4dT02cXkJ
 NWYuCY5swR2RCGXwloQOLOKJqdnl0LGAPojh32LJb2ETKg5vkKfOowSu2nEhpiPJXhdDvE5mFDx
 mULoewZYpQerPF+ZQ2VzJ+LxPHu120EUoZ58d0RC/BbEEK/nZB1blkVUZF51ZkDpoV8q8zn5o27
 7T2+SL3kC7as80IF3wAuC8jmL44FGexawLFIw+w0Fv9Sbh70AOhg1HlgtmVyB1+hiDv/CJeHMOe
 lSocS3yPcnW2hwkC8QRsLa7AoVDjsrOm+Sko5fJeH+ycJI6J+M3Zp+giqpha06W3HZ/BZuJfiZS
 43+fSZrMCA6H2q6UgRbsjBMVpDEqWM7XoPnQ8E3OD8JysOYhi7EDSoQlNRct8VJaFQ0BWwhP/Mi
 NI2obEuMWSZQ1m9DxcG6yhacIwtGna6O4Iss9bTFOsR+UH25/2WIIr1WmUdBmb7338ZNzk17VHe
 aAPiH9Epa0HXeYOPiEQ==
X-Proofpoint-ORIG-GUID: UrWA4aSTfDHQGTvcHUa3jdJQ4gqmR7Gm
X-Authority-Analysis: v=2.4 cv=cNF1IVeN c=1 sm=1 tr=0 ts=6aad53e0 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=caUVuM0fXGGZm3fvLi4A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180215

Build the xdp_buff by accumulating all the descriptors that make up a
frame, so the XDP program runs on the full (possibly fragmented) packet
instead of just the first buffer. When the frame is not consumed by the
program, assemble the skb from the head buffer and the collected
fragments via napi_build_skb()/xdp_update_skb_frags_info().

To do so, store the in-progress xdp_buff in rx_q->state instead of the
partially built skb, so the accumulated head and fragments survive a
NAPI poll boundary (mid-frame dma_own or dirty_rx break). The state is
saved only while a frame is in progress and cleared as soon as it
completes.

In addition:
- build the skb head with napi_build_skb() passing xdp->frame_sz, so
  skb_shinfo() lands on the same shared_info the fragments were
  accumulated into;
- release all buffers belonging to a frame when it is dropped on RX
  errors, instead of leaking the ones already attached to the xdp_buff;
- cap the number of fragments at MAX_SKB_FRAGS, returning any excess
  page to the page pool;
- skip zero-length fragments, which can happen for non-first
  descriptors when split-header (SPH) is enabled.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 180 +++++++++++++++-------
 2 files changed, 122 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4fc96b317d79..69bdbbf4b920 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -132,7 +132,7 @@ struct stmmac_rx_queue {
 	dma_addr_t dma_rx_phy;
 	unsigned int state_saved;
 	struct {
-		struct sk_buff *skb;
+		struct xdp_buff xdp;
 		unsigned int len;
 		unsigned int error;
 	} state;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bf9e7e4cb1c3..1de8d9626c64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1695,7 +1695,8 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 		if (!buf->sec_page)
 			return -ENOMEM;
 
-		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page) +
+				buf->page_offset;
 		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
 	} else {
 		buf->sec_page = NULL;
@@ -5140,7 +5141,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 			if (!buf->sec_page)
 				break;
 
-			buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+			buf->sec_addr = page_pool_get_dma_addr(buf->sec_page) +
+					buf->page_offset;
 		}
 
 		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
@@ -5735,6 +5737,82 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	return failure ? limit : (int)count;
 }
 
+static void
+stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
+		    int sync_len)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i;
+
+	if (likely(!xdp_buff_has_frags(xdp)))
+		goto out;
+
+	for (i = 0; i < sinfo->nr_frags; i++)
+		page_pool_put_full_page(rx_q->page_pool,
+					skb_frag_page(&sinfo->frags[i]), true);
+out:
+	page_pool_put_page(rx_q->page_pool, virt_to_head_page(xdp->data),
+			   sync_len, true);
+}
+
+static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	u32 metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+	u8 num_frags;
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		num_frags = sinfo->nr_frags;
+
+	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb_mark_for_recycle(skb);
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	skb_put(skb, xdp->data_end - xdp->data);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
+					  num_frags * xdp->frame_sz,
+					  xdp_buff_get_skb_flags(xdp));
+	return skb;
+}
+
+static void stmmac_build_xdp_frags(struct stmmac_priv *priv,
+				   struct stmmac_rx_queue *rx_q,
+				   unsigned int len, struct page *page,
+				   unsigned int offset,
+				   enum dma_data_direction dma_dir,
+				   struct xdp_buff *xdp)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	dma_addr_t dma_addr = page_pool_get_dma_addr(page) + offset;
+
+	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
+
+	if (!xdp_buff_has_frags(xdp)) {
+		xdp_buff_set_frags_flag(xdp);
+		sinfo->xdp_frags_size = 0;
+		sinfo->nr_frags = 0;
+	}
+
+	if (sinfo->nr_frags < MAX_SKB_FRAGS) {
+		skb_frag_t *frag = &sinfo->frags[sinfo->nr_frags++];
+
+		skb_frag_fill_page_desc(frag, page, offset, len);
+		sinfo->xdp_frags_size += len;
+
+		if (page_is_pfmemalloc(page))
+			xdp_buff_set_frag_pfmemalloc(xdp);
+	} else {
+		page_pool_put_full_page(rx_q->page_pool, page, true);
+	}
+}
+
 /**
  * stmmac_rx - manage the receive process
  * @priv: driver private structure
@@ -5756,11 +5834,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
+	bool first_desc = true;
 	int xdp_status = 0;
 	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
-	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	bufsz = rx_q->napi_skb_frag_size;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5780,9 +5859,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		u32 hash;
 
 		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
+			ctx.xdp = rx_q->state.xdp;
 			error = rx_q->state.error;
 			len = rx_q->state.len;
+			first_desc = false;
 		} else {
 			rx_q->state_saved = false;
 			skb = NULL;
@@ -5831,6 +5911,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
 		if (unlikely(error)) {
+			if (!first_desc) {
+				stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
+				first_desc = true;
+			}
 			dev_kfree_skb(skb);
 			skb = NULL;
 			count++;
@@ -5855,9 +5939,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			}
 		}
 
-		if (!skb) {
-			unsigned int pre_len, sync_len;
-
+		if (first_desc) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 			net_prefetch(page_address(buf->page) +
@@ -5866,6 +5948,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
+			first_desc = false;
+			buf->page = NULL;
+		} else if (buf1_len) {
+			stmmac_build_xdp_frags(priv, rx_q, buf1_len, buf->page,
+					       buf->page_offset, dma_dir,
+					       &ctx.xdp);
+			buf->page = NULL;
+		}
+
+		if (buf2_len) {
+			stmmac_build_xdp_frags(priv, rx_q, buf2_len,
+					       buf->sec_page, buf->page_offset,
+					       dma_dir, &ctx.xdp);
+			buf->sec_page = NULL;
+		}
+
+		if (likely(status & rx_not_ls))
+			goto read_again;
+
+		first_desc = true;
+		if (!skb) {
+			unsigned int pre_len, sync_len;
 
 			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
 				  buf->page_offset;
@@ -5887,10 +5991,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 				unsigned int xdp_res = -PTR_ERR(skb);
 
 				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_put_page(rx_q->page_pool,
-							   virt_to_head_page(ctx.xdp.data),
-							   sync_len, true);
-					buf->page = NULL;
+					stmmac_xdp_put_buff(rx_q, &ctx.xdp, sync_len);
 					rx_dropped++;
 
 					/* Clear skb as it was set as
@@ -5906,7 +6007,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 				} else if (xdp_res & (STMMAC_XDP_TX |
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;
-					buf->page = NULL;
 					skb = NULL;
 					count++;
 					continue;
@@ -5914,51 +6014,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			}
 		}
 
-		if (!skb) {
-			unsigned int head_pad_len;
-
-			/* XDP program may expand or reduce tail */
-			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
-
-			skb = napi_build_skb(page_address(buf->page),
-					     rx_q->napi_skb_frag_size);
-			if (!skb) {
-				page_pool_recycle_direct(rx_q->page_pool,
-							 buf->page);
-				rx_dropped++;
-				count++;
-				goto drain_data;
-			}
-
-			/* XDP program may adjust header */
-			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
-			skb_reserve(skb, head_pad_len);
-			skb_put(skb, buf1_len);
-			skb_mark_for_recycle(skb);
-			buf->page = NULL;
-		} else if (buf1_len) {
-			dma_sync_single_for_cpu(priv->device, buf->addr,
-						buf1_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->page, buf->page_offset, buf1_len,
-					priv->dma_conf.dma_buf_sz);
-			buf->page = NULL;
-		}
-
-		if (buf2_len) {
-			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
-						buf2_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->sec_page, 0, buf2_len,
-					priv->dma_conf.dma_buf_sz);
-			buf->sec_page = NULL;
-		}
-
-drain_data:
-		if (likely(status & rx_not_ls))
+		skb = stmmac_build_skb(&ctx.xdp);
+		if (IS_ERR(skb)) {
+			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
+			rx_dropped++;
+			count++;
 			goto read_again;
-		if (!skb)
-			continue;
+		}
 
 		/* Got entire packet into SKB. Finish it. */
 
@@ -5991,9 +6053,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
-		rx_q->state_saved = true;
-		rx_q->state.skb = skb;
+	rx_q->state_saved = !first_desc;
+	if (!first_desc) {
+		rx_q->state.xdp = ctx.xdp;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
 	}

---
base-commit: 4bb9710c6a68d35207f123aef55dcd50e7195ec5
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

