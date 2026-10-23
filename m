Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743045;
	b=xh1PZ0j/J6y3M0/XOBBPK02vcf7Hx/77WCHPnulMq6mxw4O/e+xbaYreSsdHRSDLi+ji
	 Ct3znU7geS4woXdTXetAKFmYnQrobI05uz0OO51KYgSBDEL6eW20sbawZW4N4dkIAULMn
	 VatAYnOi3gLRSRtYNBIlsRblKypfzfwcpkbBWxEucNF7QIYbMb4YVFgUsYvQZmF43V0cT
	 hSoRgk+JVORwswPoVSKoLRDKM904vn2xRpYL70bTOqmns/1WqFFRHvsoIZpzywYjrtNaB
	 49hTURtm0BFbu3RT2HnV5wLkUn8kpGjQjfT5vmMwSkX8wyT+nemTvJ52m586e4Q1CTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=;
	b=GzyO4Oi7VDAyPnbV2NQuTFXDZlI/nSIEwx0tDcfGcrbUaZnRijmRtbl6Jr0RtaCIw+PN
	 iDBsTHr31fUzsfm1jx9KBKH0EJEC+R2yAQN/iDp/Y1oQGwHjUuHZBAy/YI+8MnewjJTpJ
	 FIS/HW8nSeMNWajOBcKRjR6QVQxykJ6qc2zN7RM5Xd7gGNAXJQT5zYKQDNz+37IXlEJ98
	 BHVfjy4z2CVF3UnybHkZr99YwCe/kCB6EInq9d5ARf19gLkkCn5iXakxs3LDntTl0u86C
	 YvV4AHbWKTkcneNxAVxZd5jrPTHBXlsQKLM+2Syu7pGQHYBsVjzgDFRFGLod959vgwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y+Kzydqg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZsGW8WRC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79F606A33A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E79F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y+Kzydqg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZsGW8WRC
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FT082650369
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=; b=Y+KzydqgVm57vbKr
	1/4d5clgmk1xev0MNqnpDNtziAEKpwB1nQJZkd8szBg4V+CjP4WTmYxp5vOn7Lge
	+TXrUpFF/fmSLPJGmFAgZrMn/cpbG1x8fiC1hkTuovsFnQR98Snyvfvv4GPMW2kz
	KLXIuGf3LZBbvaCwWLfJkf2zuP3w8if36oaGS3tEVCOhg+LjUAFJ/CwziPVvmkhJ
	xyVntjFJstKtf/ZVHxiFVsESr8EL+MM8K0oMGXskMn1qINktXxvmuhAIRLGuSlvE
	BmZtx6iJIWilwhPwNrfFyq1Hl7dfdVPdvXn07HEnIyfIk3wZ/VNx12bpH15lp0/W
	y1hWQw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjapmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:10:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so140200385a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743044; x=1793347844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=;
        b=ZsGW8WRCNl15aTjELjNlZQqb+g8VKYgmcFS7Enqosvh7eFGvRG4a4tf1tpckaI0mUi
         d7cXoTjU7RF+M2EfBtVxy2uaac/uaFkaGPflWLVw9Qo+8NDOSsEocNMjeO2PD30g7XKc
         KEs9l/cMjlSe17yGk8i6mQlPanOfup5buKZDqMwiRqB/K4t/p6oxySDOhK9cvRDmN7QU
         f/SsXdLjLDZA8kw7DjMRAJbYEEfeAJaTJjZJVD6qZP66oTa0lGfJKxzrPEBMsy6eSWok
         z6wFHYoEF/D5At2ZFdkErOexHqPcQ6IfVqljM+fMa7pMCJXZ1PuDQu9gWRcaRe9SNTZK
         +B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743044; x=1793347844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jY4VkvVIYr6et0hnvUEcfNLa0BLx4p3BFPFF8mFr3Fo=;
        b=pehtsQw+j+c51+dV5ri2JJxjENHnADkQMwURlqQs2+9fr1JMEd8UYqq6VFNtn9leo6
         J5RMASgyLbqmC6kzTb8xkSxR6Mqzh+P1g0duYEQLJ7XkVhk0QJ2Sg8o9Vb+i8h6Paa9B
         okv0UFURl0Ia8/aDcZUSaQtQ7ukDVkqaJTotlcGek58doe+gq0cGhyT0RGLKzgxMtApt
         if1YTTEH3jXfPy6RfeBl/re8SAX6QlMp/TaIhCFzfrlf1OprEvQuUrLRT275rl26SJdj
         W8aPuvOB2FlzulhOyhqnfRf7158EcwEp8bPqA+Lj5nVe5n4kES/6dSF/kVTYb3S0be1A
         uajw==
X-Gm-Message-State: AFq9FYJAjYYkIOuzWDpBQfDSQZdHf3rY6E6hQxVhC3VL/LaLdLNu60Vw
	3ghv3n6eoZDyf5oukaCFUdn0RtvW+qQ6I8tO/lGxhnAl5FpRMuCw/WnZKJ56QTKue3jlWNaZANa
	CIWH9g0YOZYmKjg2eUoWmA5vyNM5DBwmBWFCzbOl/NCLO1wWgt3wiK+cn5ww=
X-Gm-Gg: AYBFou1TCzX6bNIG7rn9hgHXKWi0UvTBEjHfY9uzpoumkPt2rwCrONHqjp96XfRMbjs
	XTUZjYWV87jzBFnBpYuJ3MJwxvn9iFs0v2VGUP5mlTxZ4DECmles689Kaf49Q8GDH15Lc2EBlUc
	flCvpKrpYFQR3MVVptKRfu/nvxApfy+0kkC0phqea8M80KcDMn6Aj9kmKL8sZ0sNtPzEvSodGE2
	Sg06tWaaTilkAc+h5xrS1PfzfK8qjnFT++tBrspVicHrjA7NSBwcEh4jApubyNzqLcwNEiNIMqY
	EFqr+ZC5liFcUGXtXjQfBIdYzQim+X/8Hon6ETc/UdbX5TrznE9JxETLOUq5bFclfSoGRJjlfXC
	nAkhjR/r1tRU=
X-Received: by 2002:a05:620a:a888:10b0:93e:b0c3:388d with SMTP id af79cd13be357-93f6f54c958mr203883485a.11.1792743043556;
        Fri, 23 Oct 2026 01:10:43 -0700 (PDT)
X-Received: by 2002:a05:620a:a888:10b0:93e:b0c3:388d with SMTP id af79cd13be357-93f6f54c958mr203882485a.11.1792743043078;
        Fri, 23 Oct 2026 01:10:43 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210299910sm57399365e9.1.2026.10.23.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:41 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:58 +0200
Subject: [PATCH net 6/6] net: stmmac: fix XDP RX buffer DMA sync length
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-6-efb37e19f5bd@oss.qualcomm.com>
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
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: SYx7oP7lbrfdQBmSXxl4PSkZk4M37oeE
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb1684 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LaBVFg8F59WyocPVFFMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX41H1QPeSwWrh
 OmuQz6fOkOkoL+KAfaWZ3gKA+QXYgYs37gpuX+CrzBb4RWHFWq5sfzE3Q8mNVkCCH2n19X0WdPu
 MZNPKwRuA9gRlkx9GLtwtC02ibzWUtg=
X-Proofpoint-ORIG-GUID: SYx7oP7lbrfdQBmSXxl4PSkZk4M37oeE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX1li0ltfBEE6E
 K0MEOyazaZWvBIi9Bdr9WA7LTPdWnfqcvfa8h5aUfw/neUoHxivOMNiMzPcylPtPqBW0GNgf0cl
 jb8F0WL2JTwftEzmA0in1hr7mJop+SmiSxuaClCEq4jGBMp0h4lPm0uMuxoRF/zb4qUdU7WPI/U
 urA594ydXrH+3nXzv9g8i7IsKW2SiQL6SCf/pIyPgERyMFRXH4J0aVXjAvvNoOcyN1eKGzYFBXo
 tIFoMYbk5fGvXooaatpY5u0GPVGF9K7ZLLJMe4rtxiH/sWqGI5t+mzPG7geAWYgl32/l6v6DkPB
 h2WkVnKSXM9saBOa7qFA/6AXUisp/FccccxUZoK1erMLzyjVGnjMG2xikhZ1ObnCYOZfbZilKmy
 cF+2tAL0XthyL4OQ/RntuWrrCDe9+Oa+vd3NW91HUdPGLuylDm+S7DLVgeD9sukAkIu+Ul9u6fm
 5RQBzbYynqJpT3X248A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

Since commit 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
moved the page_pool DMA window to offset 0, the sync range no longer
starts at the XDP headroom. The XDP path still computed sync_len as

        data_end - data_hard_start - buf->page_offset

so page_pool_dma_sync_for_device() synced [base, base + len) instead of
[base + page_offset, base + page_offset + len).

On a non-coherent platform an XDP program can write packet data, write
metadata or grow the tail. If the program then returns XDP_DROP/ABORTED,
or a redirect fails, the driver recycles the head page with an incomplete
sync. Dirty cache lines in the tail of the frame can be written back
after the device has DMA'd a new frame into that page.

Include buf->page_offset in the sync length so the whole CPU-touched
window is synced before the page is reused.

Fixes: 88095728511e ("net: stmmac: fix rx Scatter-Gather support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 32b2c5834c34..c51358c51fae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5980,8 +5980,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
 
-			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				  buf->page_offset;
+			pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
 
 			ctx.priv = priv;
 			ctx.desc = p;
@@ -5991,8 +5990,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			/* Due xdp_adjust_tail: DMA sync for_device
 			 * cover max len CPU touch
 			 */
-			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
-				   buf->page_offset;
+			sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
 			sync_len = max(sync_len, pre_len);
 
 			/* For Not XDP_PASS verdict */

-- 
2.56.0

