Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108949;
	b=xN4MEl9hRutD7f0ngpDmYB0c7TSnA7IcDYmTO2ZdMzLOzb5z+t/LXT7/pBpR90aZEmqB
	 m6Y3XRuSJqQHHm1PxRr0T/Jj3Jyia8MxSh/CgCvq/Sgqf5E2N5l+puIx0l5GjS9uWThAk
	 s6Z/lS/RIHpjfDM1E3nj8gbm8pMi//C5LoBCaATHRjeKGVWybpP6nvjFhkDpafDw4KwQA
	 1nD+KswjYpCPQwCGMSIAc9LAsIPtMEoWKE8674uXzclz2iss8o4iW8ElZZdj9y9yGT4OR
	 R6BBTy9Iq/BSKjUhm5dPtdsGfMGE4ZBlbpuHrjhMfY2M14vZq0Ld3wjLBkNYVdmz8Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=;
	b=RMDqVjvhdASvb90pJkE9LWOPJQZ1BH+hJhTAm28Tivuo/aQ1K8xGnpugZqL7RzEm8StW
	 NmVdUl8Lf8ZgzL9iOoAfhRuE5L5nuhzJguv8MH+4+vKifu7I6w+COvOghimLKG1/u5gLj
	 eGxEOpfweh2P12+Mok36AQxsLZa/sqQyJnLN0gXYWLPe2osxFduCSsFxyOr06JdztFYtu
	 G81FEVI/ageQZH3pq2BaCA8UYV7eGkhoyWGwsQtFJgn9mgUoaNGmMtuRUU+TC+GC7F5zq
	 XBw/hV2IjHANWzdPVOEdENSbs02Q8RhyqsNVsr2t9/H8808TJ+dFugMMJUA010yvegg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VVaSGVw0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cz2KQzI7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34451606A33E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34451606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VVaSGVw0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cz2KQzI7
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe4L61935912
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=; b=VVaSGVw0c/4DeoQe
	FFIo2iPP+suk/zTD0Euu2q8iV5EErkpjwp6/SIV1RJ44OrIJGSBqCOTSqR1t/C9c
	ZWV/DdlNEyF8y1pDyfV+bmyZouDjHgDAAberJIyS4mcXYDKjeySwMFdeJvkXXEcU
	AiPS9/jFR+rR/FIDCvAL19aaCON+Qa1d085jQ+jLB1donLg5CrQb/8mDyEPNf0Hi
	7OHyyCfPzDlEPzBqZagkB2Id8IOLysWyDogpCu+MDIrQ6Ey0/8j2WdLQayoKiEHg
	sr2Nyvra3vYNw/PGs0VDonP7E1CGL15plgnJQmhT7YHa1M/eAioN+5pSLs9Eudgb
	Al/FWA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavu55p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844cb60so210098785a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108947; x=1793713747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=;
        b=cz2KQzI7N1zivqPR8+/KX7rHE4fMJrWE/iH3N7AmxSpYEeTXMOXm6cCRoAV9upfNrC
         YATfXVbbBwR8baOHaOChcb+LnmNAh/dT0zYQKNfXZ6j2ie0B2KkHrj5y/mwgVTMp1Glm
         6pyU74AvGxaRea4L5ujsyhHynYYfJq79rBgLH1fLKABTWIzB43n02R+5W7GpZgmZdZY6
         +3ho6PYY2HovHod00FGlJ9B+X9ScxZxogTN/wQcbQqqENeD7r/zptbn/eyU/X9NBJ6JK
         SJnAPYg6CxmT8C404Ui4aWKjTFOpBU/bwUoz3xzvbCg5SCCBFEkzfWkO3W+EuX1vWtzX
         FO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108947; x=1793713747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWBn7ZAhYyu9Hdvf/allBo9irsjsdWVIpt+Znd8jRKk=;
        b=W7sCtyH3iS/UF6LQ6L6YXEIkkZzH+dUwQuMZ8dkqdB75ZvTtxifrg/FaNi17DJvExt
         HLtw6BnsYK9UmwE6wBqIdtlP9jSXNHCjEdgm6QTX2HRvuifKPM1cOlOR40KGOOxYMfBf
         FjYNsdH7N+JA39LXMQzRGMefP+Dd8HNLdWVnhs6ucST3f5YLcneI8Iq/dmDorEjafiVy
         f9iJPTQ6oRItnOLyusvvYirXnD6uXyj9bJY1+m8cBZTfSTmrJkDa7tQZv0PW8DpLPFwH
         yxTN/pcr3NoCkU7ljQO+MQTrbSxoQ0E8nJfxPYvZLCRsLCVQ1Kie87NMBKpAV5tPOIOe
         s6qA==
X-Gm-Message-State: AFq9FYJTkWBCMPYacxkXR/ikNYYU9fEgy8LwzRwPpbzF71TKQLKDf30O
	QRHbgk2rJpSNHNHRJ9MLqZsryAUtBYegbvvc+Ely53S3Tlf+H72aFGCG3OGvGg8DOBMTg8ymkj4
	4chZuMtuehxiHzbtAu+NHTY3sHEf3y+DorviPDERM8Nq1UUcggof1bzHXckY=
X-Gm-Gg: AYBFou3hZa0WAtDynbBhdd8VYP02sP0mRfmUWjpigdkfdj8U+km47EUC2jMuoOLtAn5
	1s2Iijm3m0ZyuYNTuBTKtpZajRmjEbouia75nLeigG4bpVUdSM8fu/R0Mx2X/PSuIRAnKBVShNu
	pZ8/rCaJOdtt8G/w07QfKERvmpHqFTLKAuxO7UE9pMFcYVrUnP0UZ/e6etwfr6gMxgLyUbwlcgG
	W21oKmKoK7qic2A+7ZL/WSYkDasyK6OSh6MC1tXj4LANruvz7SMh14xn/0Y26YJw9+VgCmTOEK0
	6At+qDHuHCQ4tGn6Wr08sJmJm1Oal0mcgfwzGNRT9TIHR/bXbEOAdeJm+sxzXUWgZp8Nu1fSrh5
	X6HvASzOd0bo=
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id af79cd13be357-943f4b8ce2amr420871585a.20.1793108947112;
        Tue, 27 Oct 2026 06:49:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id af79cd13be357-943f4b8ce2amr420865485a.20.1793108946506;
        Tue, 27 Oct 2026 06:49:06 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49640f1b9sm40758a12.19.2026.10.27.06.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:49:05 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:41 +0100
Subject: [PATCH net v2 6/6] net: stmmac: fix XDP RX buffer DMA sync length
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
Message-Id: <20261027-stmmac-xdp-fixes-v2-6-10eae8a093a8@oss.qualcomm.com>
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
In-Reply-To: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: s-uMY2tFz0ErABoXyzVHFcpEJ_FJu_9o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX2nNIckgJ6809
 G/xxMApK2MEKLjGdhhXW3utaj4kR/df0nmEY3rxGn8FDxHioNQgRV1Y+CnseCrjC4Xoivh0Wop3
 +TcM/+/PrMs47nhXFWeP/jYtOchppQI=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae0abd3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=xzJaxtAIzuUiCKeOh8cA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: s-uMY2tFz0ErABoXyzVHFcpEJ_FJu_9o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX+i9lTjibrUzj
 7V0KpuCB0G98OCONgTBYo7ZYId44SvGhsT8ez+fjpYnRL5P9Fn8CtQuHQxbHf4/MXJNEd0KK0dX
 HOd4dRC5M+y70jpJDERvJT6o5M2ARq9uwbKJK7AoRCczRE0zW64ur3ixTSIddPqa0YSXefO7jKv
 PcW2P6XUoYJPvwIxPw6vQVMZuVyUtDo6GsBrYR/1PaaEHDOpsyyIGIF1vWycZdrgu3PtfJzMGcP
 pJVeO4GUu76QS0yRhLT1y7U5vv9h8unrCiplzT8fI81Xh+v1wPrSg3DWJgA3yYvH7pZ/PIeHAeg
 tL8w/thr3g9SlG6PQUMAS14KmYP1Etkryqo4Ihu5GzNnfeDjAR9HQbFbHQDfz3i63aI4fIsF57Y
 cM0M61ZmoAmykhlDO7KnYREKX3Y7sgIQrXarNqFpcxghpPndhHfCtfbPF1lhSOZWoXggFluB7T0
 3gCDczoOi/rozy/8o9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

stmmac_rx() bounded the DMA sync length by the largest data_end seen
before and after the XDP program and passed it to page_pool_put_page()
on the XDP_CONSUMED path. bpf_xdp_adjust_tail() zeroes the grown area,
which dirties the CPU cache, but a later negative adjust only moves
data_end back. If the program grows and then shrinks the tail, both
endpoints miss the zeroed range, so those dirty cache lines are not
written back before the page is reused.

The length was also wrong since commit 88095728511e ("net: stmmac: fix
rx Scatter-Gather support") moved the page_pool DMA window to offset 0
and set max_len to dma_buf_sz + page_offset: the driver still
subtracted buf->page_offset, so it synced [base, data_end - page_offset)
instead of [base, data_end).

On a non-coherent platform those dirty lines can be evicted after the
device has DMA'd the next frame into the recycled page and corrupt it.

Sync the whole page_pool DMA window on the XDP_CONSUMED path with
page_pool_recycle_direct(), as the PASS path and page_pool allocation
already do. The device only writes [page_offset, page_offset +
dma_buf_sz), so syncing [base, base + max_len) covers every cache line
it can touch, regardless of how the program adjusted the packet.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Fixes: 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fb3b7174599e..b038472b9817 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5970,8 +5970,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			len -= ETH_FCS_LEN;
 
 		if (!skb) {
-			unsigned int pre_len, sync_len;
-
 			/* Each frame starts here: reset the FCS handling */
 			fcs_stripped = false;
 
@@ -5989,29 +5987,18 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
 
-			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				  buf->page_offset;
-
 			ctx.priv = priv;
 			ctx.desc = p;
 			ctx.ndesc = np;
 
 			skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
-			/* Due xdp_adjust_tail: DMA sync for_device
-			 * cover max len CPU touch
-			 */
-			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				   buf->page_offset;
-			sync_len = max(sync_len, pre_len);
-
 			/* For Not XDP_PASS verdict */
 			if (IS_ERR(skb)) {
 				unsigned int xdp_res = -PTR_ERR(skb);
 
 				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_put_page(rx_q->page_pool,
-							   virt_to_head_page(ctx.xdp.data),
-							   sync_len, true);
+					page_pool_recycle_direct(rx_q->page_pool,
+								 virt_to_head_page(ctx.xdp.data));
 					buf->page = NULL;
 					rx_dropped++;
 					goto next;

-- 
2.56.0

