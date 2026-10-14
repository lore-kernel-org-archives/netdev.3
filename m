Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF434FECCF
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983405; cv=none; b=ebtvrrC64uByX7yLPoPxSnl8kqdOb+GlfwX90+29CVp/PoZBp8EXqVLcYSBX1hUX5ComrJ9HMtuRdSgtm52Z2nSikRf+OXiuRix/j2sQ38OtzUOO/wFd8TBfSJ0NYU9XWxGIilwodI9OQ3sOF+1JYVk85boWqxpg8Oka/2wCDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983405; c=relaxed/simple;
	bh=ULM+TPq1QRua0r7KugW9vSANeUcVvwwH/Z3MUe21LLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTPQITpw8l5IjC65B9f7hHXpnDJjHW4ESoT7rivyEv3Nma3IAg8HHTuTu1tmfAz1Fx43YpPCZNjgri2g9zHMMnUZ1mbd5DW855yRWWc3v8oZG2BLkneE5Au2iJ/behIcewiv33QdU2P2+y7bODzEDLXBRB/nXd+X8gYE2ZCKHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XUhfRrSN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5XdBYEb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUhfRrSN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5XdBYEb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBRQQo2516002
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/M5NnOjUNxwzJe64yCg4dQMGH9jNm9FmAahLCCnknSs=; b=XUhfRrSNI6K7JEtH
	Xj8al2ZuCdt+1nGywiaamP4ppp29UXkdbSWJabVA/TVo3OlwIZqDCsaBJRK6JdjG
	OF3isxHjx0gWc5cHEtLvUAJAA35QgcITy/b2kWssjRfSTRbIENVAKktMotLYEAYv
	WFwqMw2ku30dthlRHEXxUo9lzOU+oSdkksLBayj7yG+efARYG9kkhsEsP0S3X+N1
	505s3bOr/Hon8xgVBkmZulsxsa2sQ5n5SPdsOfLA6l7yeS6lDfTnyIc9oJC3QQqr
	OVv5A/IvcJnIlqsryLRIPSuY98oDCf5G9iiz4GqQu44YLhjP9qiS8pUhNXhuG5k1
	dGlp1w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4709p1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:10:02 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98331b577e4so2861962241.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983401; x=1792588201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/M5NnOjUNxwzJe64yCg4dQMGH9jNm9FmAahLCCnknSs=;
        b=V5XdBYEbrdqeEAdNroEEmWghOESMRqq+o2Q+0NzecnmVf2Q1f6T03sKFYTxGCEz4yL
         Wv5QfWRqaDAyJ2voNeNWavrWwdjz9M1DKeQ8PQxqS3Q8Bii67zBTKF5bvjqubYUpMEu0
         6Jv+RUPC/cEQ/Qb+9RW+GuEWFfJG6lOWUyNwN83UqdzjBXQ6fYZxmbnoPnN/xpYZrGFa
         EPkRqoeLs3IqYUDzSNR6pYGb694EArF0jGgOzlttffVnMHF1ALh2GujCncv5c4O1PgEg
         3QwzGWJyOm98WpMguNjTXbr/qESkOm2scwl2zR5/BpSsJibCTZmEwO0YGrwa3u8MHf5C
         HCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983401; x=1792588201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/M5NnOjUNxwzJe64yCg4dQMGH9jNm9FmAahLCCnknSs=;
        b=Cj0Shg9H2hcfv0RJ9SK45ke7wbXWhJpT7VusEaYwxbselmZv3bv7+QDDEQ43bi6N35
         EGG5Osf0RsK94DLsItRKBTye4rPrMHMQRgN1XQMXZudOQETcLozTneyx6f6Lstirm8ZK
         aDDcsVx8iubpKEIBUH/fcmvOlYtZLnsMpOCjMH+yygKRsw22oD7NpMnLgVgxGXZbRyZn
         hTA7aHmroEiSs+xv0jQLwbjEnkFEWA3TAtO9ypMu6NhrfjbqpyioHjhWBePjqCwfRCAt
         TTHIqjjy15hyQwMfbLxsq+HqMTN64Tv/yT4bELwQsCO5BJEh9RPxw71nciuNd+uKtl6y
         RMyw==
X-Gm-Message-State: AFq9FYIiAyBypHthib3RVdtDVdMHvYeogAm33dqQ6KN+AERWAzrG3uMK
	IhTBGrgj0iKBiqnh6PxvsJXIxxP60EZo6pC/gwj+ZkbrrJt0i6dZsibdkcYVEfjNpWw3SwjV+JS
	Xntj1PoTsm3XvET3QMPr32/tv2IEtCC4xP0g7G/EhRlcGJo5o9CzHR+uBEWs=
X-Gm-Gg: AYBFou3ygg9M2TVKOWA6jlGhpkHIYNgwxkOuYNUw5MFONfIgCTH19cuSBRDX4h4f7zh
	tmNf+TBVhab5Lmbu19R4acfTzxxzZbcDb5Hh7b9tm0HT3nDtpV3xH34XKsYETx+eUPhUvhHiJH8
	esdHfjL1gHs67DcoW3cFfreh3We1EHFEUV79ogtw/aZrwCan1pl6HItxK4E5hLkMT8BM3KdSf04
	6SyojUS3OBCSEJgzDygh1B827v/rwvHofYFeUNhvfHAW6/sRYqbRLyXpKZed7cJL3xoPehg5bO8
	b6tFlte7dd2GPbIhkStg30T4G5u2ES6XTfPG3GvCMCQOfjHkGcmvBBvKLjkbewVoqGx/IGopltp
	VNKFtklKy5tyEDw==
X-Received: by 2002:a05:6102:5cc7:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7cb373e1426mr5095282137.29.1791983400069;
        Wed, 14 Oct 2026 06:10:00 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc7:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7cb373e1426mr5095254137.29.1791983399314;
        Wed, 14 Oct 2026 06:09:59 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b489742csm34280125e9.2.2026.10.14.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:09:58 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:09:37 +0200
Subject: [PATCH net-next v7 3/4] net: stmmac: drop multi-buffer frames in
 XDP mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-stmmac-rx-mb-v7-3-5d2d70f052cd@oss.qualcomm.com>
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
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX1tN7DsxXWROA
 axzcMMr+TvR+uUYuXqLowbjtfhxkRigHEsUz7+JvImGjZw/Huy8Iu5YC0dRrDVR+Ua1a7qWBiio
 +8FHEd87RlUbsUO14U5xEKK0+AbZQ7oIcpP8jHFpeJZGJx5JYkNMTvwCVVqOWb6zYYguCrTGJm3
 FYONG7CAeI6RvAa7q94bVg/w0r3ZeBcNcS+NjoloKOiuC7IZVyHdvXAGhK+oqfYk616BjU6Azll
 6adV1ip8ZohZwUbZj02Ld5Buk+kJSXrUCmChA0fSQCLHc+IrnUAi4KK7y0RYSkz6s/Hckt4nnKm
 KOx5EWq/tTIA38FEsZP75aPQ9twizblzdV2kX3V6k2LHajoDpFanjaecQ327IjOISreR1exIrll
 t/nzNLQiyMQlgNEJIRpva73QTrC93KKy+nKqVh0r9HSz6Xbo6YngaLciY0OZldVD98MK5iZX0iv
 vdcebQhLvhs6vy5Iamw==
X-Proofpoint-GUID: BIDBdAW9HbJa9rMy1p5qqZYNcN8AkLfg
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acf7f2a cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=b-cMl9P36as69-4SBTgA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: BIDBdAW9HbJa9rMy1p5qqZYNcN8AkLfg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX1MqwDDl1IPo7
 rNZsgbLCnhj0MWQERUGFUH6l6Id8BJeqeKQN37/MIIufYCzadzJVe8DLGDpkKS9YQWFd7naGVZR
 7uAwsnMrC6UEhPRsytbLxZk9hQu2uT0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140052

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
rework, so drop the whole frame instead: mark it as errored as soon as
a non-last descriptor, or a descriptor using its second buffer, is seen
while an XDP program is attached, drain and release every descriptor -
including the last. Removing the re-parse lets both XDP verdict branches
simply complete the packet via next.

Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" accumulates the whole frame into a single xdp_buff and
supersedes this patch; the fix is kept so the net portion of the series
stands on its own.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 10ea72cbf889..f4beb0ff6fd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5888,18 +5888,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5911,6 +5916,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5960,17 +5973,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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

