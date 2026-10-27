Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108944;
	b=sydt+kNj4Yc+pJc9MxZN+nwdlmm4n/OorQphTW3FvIRJpOUT7qcMPrjWZZLIsdHuWe+r
	 lz3WiizZQTk98W/DnLcNFXpiOwDUBIP9D+2eSwWYg9cH+J2Sqpc4tjJRQ6goSvTLY487l
	 fwLLpYN21VERU2osntUlqf/DNWKiRLHnbaCPH7RwXbgG4TVKmE0/R/WZVXzMr9Z1VlR3F
	 Kf10hJdZH2NzMw/sT6901sp8qN75PCNVoN/SYTrTP0BleM6xFqGxFAYqQanW2LDhQfaLj
	 gdDYsvTWvwao/q7gGbM1MX1R1eWlJ8pFQ6jcv78cVACjoNzzOFqQIGTp+X12IO+Nb1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TAHG93Jw5WBCEkJju41yzTkSNHwNbIhjwuxHHKNfrho=;
	b=eRJhWVOMJMKo4Uqz/Fx566q/jjVYxIRvp8nj24GQb+CE8cx10rj0+Kc0ex8+qeu2ONXr
	 lbtNaRYiMWwLo0dmbIbGLKJT71qAgrGPDkkO7nrpCXdl4XL2TKsfCb2ZfRGZnOTZqr955
	 BvMFcAFkjHekEQpxESGIzw4gUPseFk7pKQQ4fIM/lyi/iVmXF73sT19+6ZfIsus7wXZOF
	 11g/VpQoNLFQ5N8/yflPgp2fG8m4VI1nqMJVYd0jACFJuOTWv9kY6N5kyOHSXTUxiuYT5
	 zC1V2ZkeAmjXbMPXBYd7AxV3GrjFjCP6lfOlVAlMtVFYskRLcmQq3mWKMfp2DMbb6Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M4Vi62mK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K94GvGyf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C1606A326
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M4Vi62mK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K94GvGyf
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDWiRN1278345
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TAHG93Jw5WBCEkJju41yzTkSNHwNbIhjwuxHHKNfrho=; b=M4Vi62mKIIbm663A
	ixdkIjmwTdD4Iu25W02GjjE28zo0PebNlAP0MH3MNk6wqyAnu+AJsPpx277lTEEg
	yKHZNzbXiw9muelIlPwjLSRCD95CmkicaCf7fooypNSyRY4DvubCe4T7MEczJUOx
	EqibN65+s1b7VvWRCi8B8egNHovG7YNJtd9p+Az+SPqkNBOTCdSyYW8xtvAAeWVY
	qZHYSgudtrW7UzIuHlS5atQ8YPj2f6nT4/Kvmw9On+A9vGDOlUW/E7EV2Sv1LnZO
	0dGv54UY0DOAuJqCPvBxhCIcLmyWr4UdJitAHY69T4PPWUMjeTbV7b2TbdPf5XOJ
	vWfBJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98ayf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:49:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f559420f3so393912685a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108942; x=1793713742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAHG93Jw5WBCEkJju41yzTkSNHwNbIhjwuxHHKNfrho=;
        b=K94GvGyfO6MmVhH8v13O/q3XRZGXMvNMlOVVmu+XPlaiapeCr79/AkB0234LYe/3jx
         XxrjzVVC1PC3j1TYUXO5OdXqpUpHTMXYM4EtlZaQnSJzVoCGs6zel6kWFs2Ga/6wKoUx
         Nh2DQIyMBfaqxaDebxiHzcLmZIhugSD/KEnijVE5iQ4O1KoulUS/EAI0d0no6GE5Mzhd
         mJOB1IyQ3axzdH5QiSzz1sQRjikmq6FQCnhj/TDDhE3MIuDMT2MA2SDpuSNcQv6KiOwC
         zoUspMWWTUT1oA1hoiSRQygWrj11nZEdb4senaQWKJaka7CNZG5LOAGGQrchHL1NpXqT
         Ktog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108942; x=1793713742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAHG93Jw5WBCEkJju41yzTkSNHwNbIhjwuxHHKNfrho=;
        b=X85dc+9frtF6UjwHxYQ+8sq+ShLA2QL9Ahm/rRSNb/Sga0CIJfwiausWChGtWl7D9n
         +5LFdM0Flmis9d1QmnKi0KAt+nLRyOvpPUT8li0Alrrbj6t/A94ST57jfMpBW+x9RSrw
         VJjulsNd0ser77gFHcl0gW/SVlp98RPVMY8r1ho9DEsXAhNJjFivNcDKejvKvj+S7sIY
         VCkCF6sEO6ZFgLC4n4MVL6oTTn+YsmdWC8VJXr5g50W9ixgd8FliDlUi65J9BsQDcwiZ
         v0YYNPQfcoOYHmZKXCEWeqoy4ysplxN1mKFNxh2hNTVgPQnxZk+f0MqSIqKjVSLWj2BS
         /6Qw==
X-Gm-Message-State: AFq9FYIy8fjLgCAiEcvZv/ygRdMAC67y+AhN6YUnW3FuzXPqZdo6fGW3
	sBtAekZPmm5ohnC7j+LxzuxqWyV4K7hHX1Wl5pZSU6jwazDnSf1pXRruMcbbFVZBXMg26RM+JOE
	h8TjV1gZ1TBbU5jhby4UWRo8Cc9RHkOJZn1VLV/90X36gwBGRiTCme1Szv2s=
X-Gm-Gg: AYBFou3Q3VKENWlpMCz/XJXDEMCDweXUd07mxgDT6mFPLmBZh7DIsD6tHvx2I1oxSpB
	LpVAacH22jSOlGrIF/3TSEZIDiED2694QBrOfYDA/16QwyR9PbuJPMCK6Zt9ckjdEM+0HiCdLH2
	TRRIOjnxWjf/fsVYd+CVfatHO/oW0Ge0jGG7T4viNzRoRn7OcR0FWWFxQ9hjywOY/BUH/gY8/IH
	DCZaxG/dlups7ApnSUdTmcWkMAN4T5UknLSculOUU0qYCvkpZJMBz46BlE/H8sQHsObaPQlZsx6
	PlpoyskDZfl3wX+rwSxa9BRHDLWHEe+iz2S+PqoPlmAZndBeQMdpoBvxVBOc+gExDnCyrOeGPFU
	lYOSNjSg1UME=
X-Received: by 2002:a05:620a:6288:b0:93f:2f37:2e5f with SMTP id af79cd13be357-940ef93965bmr1460191985a.30.1793108941580;
        Tue, 27 Oct 2026 06:49:01 -0700 (PDT)
X-Received: by 2002:a05:620a:6288:b0:93f:2f37:2e5f with SMTP id af79cd13be357-940ef93965bmr1460185685a.30.1793108940951;
        Tue, 27 Oct 2026 06:49:00 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4ea0ccsm463830566b.16.2026.10.27.06.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:49:00 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:38 +0100
Subject: [PATCH net v2 3/6] net: stmmac: drop multi-buffer frames in XDP
 mode
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
Message-Id: <20261027-stmmac-xdp-fixes-v2-3-10eae8a093a8@oss.qualcomm.com>
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
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0abce cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VR_YHCPEGhNri-7XuWcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Gb3td2q6B8V9lRbXwlzdhp5TzBAej_hd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX+8KAgZnWXpxN
 H+SzGOO1Q4v6KTZqb0rvYZiz4woNscjHjxz94ZlX5v1kIEdVK9tdbz8A3He5O2gzoxp7U3+CSz7
 nwUC4YbUOq7vne+HmM/Xzl8VnR09qQZ6qwzPdWJ/VkzXVMoXdiW2CMsZVfpgPG2qYUKB1phTUah
 anF4izd7vJ/CGmGqpHeoBu+bQDCqaXE78uvfd1o8QZr26OoCjNxFUPlNj1sYCwwu5Bk22ycr6NN
 Z3axiN9QZve4RV1JBnUa2751RBJYow5loMJLlv6M4S8etzaIv22zHlQu1gGUKuAi7azTIXxeV75
 HiI4rl6ra5hxbPtn3/j5+r+NAvMZqy0WujYnVzBX7x+V+fQ/slZ+4tJT5QfihdZq0iztl+MYUlD
 uQk8uouOW3r9dlBSGKkhKPhM7rMCxOKT430x/+s8VG21qHePOb+3e6AxNYUR8n946KzvTTJM5t8
 toxHdRog4HcgZ0FTvSA==
X-Proofpoint-GUID: Gb3td2q6B8V9lRbXwlzdhp5TzBAej_hd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX2iciHYDKoND4
 8L3Ztqx5EwL3O0Jd6fcZnzKh68KGkiERBPLFBCUAdsXpHZksNrxlNkD2qdo/28iM3ukciMZOcaY
 QY5im5kkkrgNjCIDwYaNq4+URY/oSS4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

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
buffer2 is now handed to the hardware for non-SPH frames on GMAC4/XGMAC,
so a frame up to 2 * dma_buf_sz can land on a single descriptor while the
XDP program still only sees the first buffer. XDP_TX then transmits a
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
Fixes: 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 33814672c842..71858af6fd66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5912,18 +5912,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							   status);
 		}
 
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
@@ -5935,6 +5940,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5984,17 +5997,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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

