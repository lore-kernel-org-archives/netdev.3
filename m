Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743040;
	b=KUyni0TS+6DAOHjk83pDpEGLXZbsHok30urh23j3uRDs1q/BAuDU45QwqW0lCpYTUJhD
	 gdB9NfYPvOlbV/WGxV5azBQlczSOyYEqqJq+whVLkoTGBFUUM7yGD4BTiaC4vYhglUj8J
	 stRXWNROGAQKQZoNm3EHn01WK34y5lCF9JOAZ6pB+dpTlS6rtOUDiCC+sT2LJHPjUfSaW
	 HfQtaccAvB8Fr1AfImE47cVFApCWD6dgOKqLjW49OCxUNNHh+0qC+EE4OGpmj9gWzoRa8
	 IDMT8wPlbphrRO4YMOF+diAvCaUxD3KZ22+lVKhSvmLboxVPuEISrsiW553T0wsLVqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743040;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=;
	b=wGx3PYyjv16qBy3lJCBna/zmMSR5OQoMJ8o09XdP5uof2RihSZQze9Xj8EqyEYh2DT00
	 v6O1M+goTX3txV9mGiqLDIvhZ+pMElSB9wpJ4uClqjSUnz6zYo5DvrsKw4oGLKbwVNaKc
	 pPsAu6mYFQUtigCRWyekn2ZPhWBUI1IRvB6mvlb8aVGWbQKfVc0FfWOYDSnmHUmAPVWTM
	 1EOwFw0ohzn5WlXNKjwN8esLSbBu3N/W11p5qQXZiuZAOrLFM157aEV6R8TMvknxb0TzN
	 4fKiK831k/b15nUD4nuj6zUYU8GWvYMcYijVmNoT4FJKjmb7CgLQ5WGlQjGQBfA3t6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3xbbkAj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=McNFQ2QS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402D606A335
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2402D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3xbbkAj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=McNFQ2QS
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FMsw2572492
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=; b=P3xbbkAjSM6PTpwT
	25b+uEaHBDAV6siqu+2b0KoO3acB7nnNcruCCFiNlszL9xnhNTOIDqnRQCllPR6f
	3epEogKOiDQhNlpAiChTX/PzipfYVVmw4JICO6S7x3iXm2DxuTuyMyW7POXQoNFj
	e+Q2a6LjaBCp2bUfCR0U50dtpcgrNTRluSX+zEhNll71P68RJ6QE5eE7BupSeF/d
	Luygs+q4gOs6okZ4T/UxiHI5i5c4PMuiGxwW8UVYMJUkbZcK5Xltjpi5If2W9K8n
	PJlDnmgSGv8YvAQEbwCXIAqanx9Ry2I5Bxo8N0ZAKC5+fCPqTrytQscaGaQhs1Y8
	4rKPEA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0k6tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1e62510cso135300385a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743038; x=1793347838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=;
        b=McNFQ2QSaTaT1Ye/FqZguoiyjIycPYSMtNu3MWcYlWnJtnJsYv14BxHj/jWBDlxlMk
         TfeNHb0T8zjx3OQZ6QSuPqdYc7SqcoX/fmxeYEIWStiwgo9/T1WFi3IPDpHjUrYIwih7
         UyRAOO5rkUzAws0OIHpt78/FWNeVqIDTIM0OnWS0cNYXBKhfdqCXpZIr86hZvtXFTVAK
         gQCM5mCVO3oywhfE7YcWEomOowSPwMCJ/7SnPBY0ycyU2rsepCPkXG/0ca6veoF8mhN6
         CXscEc+kjL2JcdBBpcFX89jmfzWjDJcqSUL+wF4iMNH06PqmuQZMQIPtnIEDxUtncDY1
         Ahng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743038; x=1793347838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=;
        b=ggPHeTfIeHfXc65MdxxCES+fwHVA4xPxdGI9rK3bSXykAKFxNLoHPdQgWGGhpPlmJ2
         tbQe3aYdav3wmxBQUbDyCTMmIn0B5/Oomldw4JlNLwtu/ThJiddmSNAVf8jhQW0D246Y
         xG5nK8iIxb/CuTu7RL/cDYSOyipm+82hXTW0glEpcBMDPH6icV4o8H5NkoaffDmNkOX9
         PanPH2rFy57i9S1hmQRuvmhHzgxg2AptpAjyl3yaUKzduRa3VWD+f7D1uuX0APBCVxoR
         vs5n9a00QsbtHbhstRpXk2GpexT8dpG2y89uGsJTYmX8ysYbmjHn0GEUE536gre89LV5
         tNUw==
X-Gm-Message-State: AFq9FYLYoug2Tg0CxFM3yQ11pOQC4OFEm4Wh3D41UC+xK34ZqZA4RDhn
	R6Qi6w7jdV7kvYl7BDECxVdSkPAJ1bqdOdsU/4UcReeIGmnY17LFnJAVw+akiUl1+LBou6o6i23
	mSA9l+Qeqkhe+YkslZyrPOriD7q5/7zahW4VFUD6sPQ4aeoJvZ9K6/1VkoW4=
X-Gm-Gg: AYBFou2BIcP72DA9Rq/hrJzGKwjkqXM+sldIKF99BLib7JHozv154sFrlQNqoHVeyo/
	15eLLZE/fLc8nmibNp7XobLJDEdbDv78HrIFI5X9cXOQ2uKoYUVsGQqd26LeB3gEQ9No2POeayY
	6CTEJFXB0gphZbmMiv1bks9xRsup0V5mhwx1F7v2dNsX5sSl1aJuq2Fn0a5q35YCusJa8OdfEh8
	DcNlrd18g2yIwPubnR0MqLVW+/r/42sLqChM0rSpe9fVPKJ5R0Idb6eOjH7aMjZ8OdLRQRWM9xX
	IJINIMgXadLt5sSV2Serato7YvQ0rGHMLwY22gzyw5aiRv8qgsuoamIjCSDdoSKvTqBOipap2NC
	VzwExz0Ios1y42MV7HkjNigwdZgJ/kqyvIxu5pNK28AQIW2tK
X-Received: by 2002:a05:620a:8389:b0:93c:c73b:39ed with SMTP id af79cd13be357-93f6f7c4facmr264310785a.39.1792743038184;
        Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
X-Received: by 2002:a05:620a:8389:b0:93c:c73b:39ed with SMTP id af79cd13be357-93f6f7c4facmr264306885a.39.1792743037606;
        Fri, 23 Oct 2026 01:10:37 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38062dc6sm3347597f8f.55.2026.10.23.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:36 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:55 +0200
Subject: [PATCH net 3/6] net: stmmac: drop multi-buffer frames in XDP mode
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-3-efb37e19f5bd@oss.qualcomm.com>
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
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 1woLPilXwenaSALRvGcH0XPOtQh95Nth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX9kpTmxXLuz+0
 i9m+6jLrKvLwjM5U3BjV8+3Oz12JSHvczIJvrRDNTBZuSPIOGF81dDxTUrVHPy2Sd5Sll/J4QX3
 bQYK8jl8mv4YEO4B7ktXgZxiefthMkPRtx3gFkIAA46s7Z6bv1xhKJ3tqnW6wSBUbh1xaF3H13v
 w9FRorSC1gyhrUkx2RkPDRIem49DFTJoUPIVp8eDQA8x4msoWzvjKHyhxyh4zcpvUq8NWTI2kbL
 qhbOIu9xpN7RLmx1JeA9BZ5kL9iEwGtunkIdHmFl6DtANpCJaOPh4DFO+U3ULmFHxzqbIYx9n6D
 MHmS26bWNv42y7Mp48co3oAIe4fG+GM5a3LlwAWazfwVt8latjZwkRKw92HonuJOgZKKm7/62cr
 VxNEIof13tfiw44OZTJJXq+736Ur8+v240itrYFOgfh6AvoF4a4jaJKc8Vj3Pjx4oStKTPP0qp3
 3OP3Tw9Hs1pFVmOXjHQ==
X-Proofpoint-GUID: 1woLPilXwenaSALRvGcH0XPOtQh95Nth
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXySEMmPJTq96Q
 dO3G8be8bsA4MLfJOZKwvlnqjtzeA59zRrnhkx2j/5nrkhGg2xv0j13XQKrdHF3orFmTQMfPGez
 lzfk/9uNIW7icgm0d/4GoyLOBAW0qHA=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6adb167f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VR_YHCPEGhNri-7XuWcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

stmmac_rx() runs the XDP program once per descriptor buffer and uses
skb == NULL as the only marker for the start of a frame. A frame larger
than one buffer is split by the hardware across several descriptors;
GMAC4 enables jumbo frames unconditionally (GMAC_CONFIG_JE in
GMAC_CORE_INIT), so an on-link peer can deliver such a frame even when
the interface MTU is left at 1500.

When an XDP verdict ends a non-last descriptor, skb is cleared and the
next descriptor of the same hardware frame is parsed as a new frame.
For XDP_CONSUMED this happens via read_again with len preserved, so
stmmac_rx_buf1_len() then returns min(dma_buf_sz, plen - len) for the
last descriptor, which can be as small as 0-3 bytes. buf1_len -=
ETH_FCS_LEN underflows and xdp_prepare_buff() puts data_end far past
data; on XDP_PASS this produces an skb whose length is close to 4G that
reaches the network stack (skb->tail and skb->len are 32-bit and wrap
below skb->end, so skb_over_panic() does not fire). A 4+ byte tail is
instead offered to the XDP program and delivered as a standalone
mid-payload Ethernet frame on XDP_PASS. XDP_TX/XDP_REDIRECT instead
falls through to the next iteration, resetting the running length, so
the tail is re-parsed as a full-size new frame.

The same fault exists when a single descriptor uses its second buffer:
GMAC4/XGMAC always provide a second data buffer per descriptor, so a
frame up to 2 * dma_buf_sz can land on a single descriptor while the XDP
program still only sees the first buffer. XDP_TX then transmits a
truncated frame, and XDP_PASS appends the second buffer only after the
program has already run over the first one.

XDP does not support scatter-gather frames until the multi-buffer
rework, so drop the whole frame instead. When a non-last descriptor is
seen while an XDP program is attached, mark the frame as errored and
drain the remaining descriptors, including the last. A descriptor that
uses its second buffer is dropped directly before the program runs as
well; in XDP mode it is necessarily the last descriptor of the frame,
so it does not need the error marker. Removing the re-parse lets both
XDP verdict branches simply complete the packet via next.

The buffers consumed by the discard path are no longer returned to the
page pool, and the new SG and second-buffer drops do not return them
either. They stay in rx_q->buf_pool[] and stmmac_rx_refill() reuses them
in place, allocating only when a slot is empty. This is safe because the
drop checks run before the buffer is synced for CPU access or
prefetched. The discard-path change and the in-place reuse apply with or
without an XDP program attached.

The !error guard on the discard check also changes the accounting for
errored multi-descriptor frames on dwmac100/dwmac1000: rx_errors is
incremented once per frame instead of once per descriptor. This too is
independent of XDP mode.

Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" accumulates the whole frame into a single xdp_buff and
supersedes this patch; the fix is kept so the net portion of the series
stands on its own.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3fa2c15222d8..30a2774d722b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5903,18 +5903,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 
-		if (unlikely(status & discard_frame)) {
-			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
-			buf->page = NULL;
+		if (unlikely(!error && (status & discard_frame))) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
+		/* We do not support SG in XDP mode */
+		if (unlikely(!error && (status & rx_not_ls) &&
+			     stmmac_xdp_is_enabled(priv))) {
+			rx_dropped++;
+			error = 1;
+		}
 
 		if (unlikely(error)) {
+			if (status & rx_not_ls)
+				goto read_again;
+
 			dev_kfree_skb(skb);
 			goto next;
 		}
@@ -5926,6 +5931,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
 		len += buf2_len;
 
+		/* Drop the packet if it is split over buf1 and buf2 on a
+		 * single descriptor if the interface is running in XDP mode.
+		 */
+		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
+			rx_dropped++;
+			goto next;
+		}
+
 		/* ACS is disabled; strip manually. */
 		if (likely(!(status & rx_not_ls)))
 			len -= ETH_FCS_LEN;
@@ -5975,17 +5988,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							   sync_len, true);
 					buf->page = NULL;
 					rx_dropped++;
-
-					/* Clear skb as it was set as
-					 * status by XDP program.
-					 */
-					skb = NULL;
-
-					if (unlikely((status & rx_not_ls)))
-						goto read_again;
-
-					count++;
-					continue;
+					goto next;
 				} else if (xdp_res & (STMMAC_XDP_TX |
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;

-- 
2.56.0

