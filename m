Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564814;
	b=M7BWGO4tz4ogFZa2jc9h0xFir9uwrc7kXVsNGmGNVXdskeqyEz+v1WhlZNr24zFqmnAW
	 CQCjZpUfLqAXApyTDVFwh1mIQAtvnaxTqutx7rRlMx0XFXUJJxvzdSphjBQxFHlb+IDxt
	 VXTgw1jQM2Z7hQi5Lfg1ZBaDXDLzdO/Bj8B2vxBuZPg2HrWN4qCriKB4wRHIVme63pQ4T
	 NreBsu5YJoL2Ds6wSl+crKatLQJlTDpIwcmfTwWOUJGoXAOiL5HBowMCscIuUQNwE6wmz
	 MbIA1uCa19dy/+iaO6mEkteQGD2kbYAHDbBwQEPJHwMWWza6qxdT/YPSoAkOmC5vepQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564814;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cP9mBTTtOaaE43IcpziwZvt0RzsuA2Jb7C//CDklSMs=;
	b=v83RJyS2ebUnlridRfBC/MWlbjxw1vVIHmon0EWviS3LkdOx3AyjyahPFWsUU8/Xhiuo
	 vdjXCFMpOR3AzS1FdgrqnKGAs4SdgxsNn4IUL17TMFn1Z1GpgLaJHc6mPjprsNlT5mjxk
	 w4Q4Vplw5GmeZYUiXHQqqkp4H5m7HHjZgnMU2eYRmuHa/IgtH394tglQrBsS5GpzS7cJR
	 +TsSFaWe8OaSp/r91BPDlonit2yFTNy0JSsNlUVvMSxKcZK+MutFLZ5XwvSS0n/0sgipB
	 ACETsqL7/Gftc68NYxZmVd/VC2ScVJSqgQL3tbsliOlcCL5lwhC1W8caAkW/P88NRPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qu7chctB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aKwLkQ7M;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29240606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29240606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qu7chctB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aKwLkQ7M
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5jEMh3712419
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cP9mBTTtOaaE43IcpziwZvt0RzsuA2Jb7C//CDklSMs=; b=Qu7chctBBNJIQ0ns
	EkwPOZvZZgkrQ/URAfWzkQEeEM4sZ+df8fZ11QDylEBvRzggjKIMjZur/pbR7k0G
	cOw0Tdb4VPmzjfgbbwvnMH1EHlVGWSOmRKC8RRzWfvzv4nQ6JmMeHlpVhkTL79Ps
	K/IgL0cm9/+waJHDOsQvoWGewp7bZKyVIHkCO/yO7C8ATwOOJ3RD3D8hP0uqIbE0
	injjcvUTBV5C6diUW+wQ7AGI9oGyUiQVhPCihPuV/ZDwSJ3TT/lRw17y4ClkruPU
	+a/YrnJn6Go6uVenVyhrWHc4ZQPK2ePW4CXWpVdTJPwfwACIWa0lfjwXeuXsu0tj
	+mhOfQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v2db5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:40:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so452256a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792564811; x=1793169611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cP9mBTTtOaaE43IcpziwZvt0RzsuA2Jb7C//CDklSMs=;
        b=aKwLkQ7M1B6FYRmOMkMBm2oKc2QOJ3xOJdfv1pqUaAZ6pxZgmtiCnq7cjZKkYhhMpa
         WWE8IGSgMtllLR6miWIy8GF6bCDhep9/E8SBKzcNQ9Gsg7WwHl5l0nSWngsoj6Uj9B/4
         GMWcELwcW2rV102zeQUB4cNYVvU85tNBIBlFsYx08CTEeI8YNbhljhRSHUcSOovVkggK
         rU+uti1y4LNx7inZ2XNwbm1to/ZhlXvY2aw50Gw8d9Ib4VTOg02k1u+3f6vGCzQAK2YH
         Y2nAJ2UHe7a+Pq/fLHi+kB9FdjDDEKdvYrVS0iImrRZhhK2/62oF4kkqSCMYSOtOXeRU
         4J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564811; x=1793169611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cP9mBTTtOaaE43IcpziwZvt0RzsuA2Jb7C//CDklSMs=;
        b=Vgl9ZVt48oBOQY4DokdDspuGvBkYRF1DK800TZx9nM57vUqFaVs6Qrm+4euQ3MeB6A
         DrpSgD3BXsdMzvWUunpUrsStSW5lvz6sofKUyUkDUWKBuDdFJ+HSO+h1SGJfgasBOg7P
         jAUnzeYRuCGMtXLd4Gk2xNc6PnJM4QAZ/krjtx1f5ouqmbT7laumJ5xs9yOT3QZ5zdHl
         SdoYUZkmdKzqbwJgn0TpsMntpLLcUPHJEPogBk7pV6tGQ97Wy3dprQ79AM+plWI4FMvx
         qz91Ye1dp/HrXo+zhazIiiIDo+lQnvblvbJEdk1yZxSM36QZfTmidkDz0D+gU0mcnRSG
         LhlQ==
X-Forwarded-Encrypted: i=1; AKwUvBziUBK4Y1ArwM1WlxGqFrFUJbo5xVEMs7mDhC7QNeVFkTame/TdfQ+tsiYji/aDpn2/LiLcMgw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhGYkxZbwrK5UPzOcHO1YnWbo96DuRLj6mi1z0OPIN+qe8vDUk
	05hI94a/iRhxhgMTKJsgI9/6OPA33QpEbBT2yHIGV9JuxJe45CbOz3QNPEKeeIEZyzjW77sXiqw
	2JLWIxY45IkBZRJxtkyXu91c5dqYxUfSTnI7GUttMoobwLLsu9oniDemLuf4=
X-Gm-Gg: AYBFou3BYl0JPY43QcNvVnSbh07dBTruK89a58EJ7d5QZEqEGq3xVNTF+egAY6LNvgL
	J0vsIwDtF2xN30PxDb1MLoHkKdIFbTeHZjQhw0yTfPfofuEDLYwfgOuHBM90+ouh38wNHAGVbeB
	dwyR/m04WPkSKmgSlD60NfdbL0P9Mw6kWzi+GNtZO2n7mw8eywUhu2FQISlm0XlPdDmRv/Y6QIi
	qjqhMZt0rT60rHljo2Gb3XVxrpZsbT0mbdFba9pCb+vkvo+6vUBbOMECiSTl2AQrVPS4DrgzMR0
	/ULeJm//AFIzUz6sx7pN7vQEcHcL8ytGaL7Ny8KK1SdFXa5vyt+mxRH042uzvl8H6ashBewBWsr
	GDNrLRmRIcxa2jlyCdQIFpMf1lxjHnDc2he4=
X-Received: by 2002:a17:90b:1dcf:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3ad86f10199mr840934a91.49.1792564810752;
        Tue, 20 Oct 2026 23:40:10 -0700 (PDT)
X-Received: by 2002:a17:90b:1dcf:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3ad86f10199mr840918a91.49.1792564810312;
        Tue, 20 Oct 2026 23:40:10 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad82f0c0b1sm1163101a91.0.2026.10.20.23.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:40:10 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:09:44 +0530
Subject: [PATCH net-next v3 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
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
Message-Id: <20261021-qcom-bam-dmux-vmid-ext-v3-2-cedd1f681102@oss.qualcomm.com>
References: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
In-Reply-To: <20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102@oss.qualcomm.com>
To: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564791; l=8482;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=mJhzhF/7WA8BSFcvRLcEwOGKZ7+vE9/EnrF4/T3J3iI=;
 b=emO+9SrGjvx+wA0OFUXk9RK+aVV0cpEIu/5mK4fq9uchgmzmzu1cqCL5yIQpJp//y0uFtAufR
 wm/zk/YF+h7D6M1IbnN3vN0lRurpZ/fHgus991ibi+DCfO4MywxqxwP
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX9u+QWksPQpz2
 +oNlNeE3Hmii4nz0e9ChV4atDfcxs96jImeA1XfXEogLtFlB6kBdgtvMkJNwPWbDhUn+7LUa7S6
 kITKUduOBgI1fYhMN0qRf1Kj/TLtRw8=
X-Proofpoint-ORIG-GUID: 0kXGwj25jpKqBTE11-ixT5zpt2sUQcLM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfXzwiLv18iiMN3
 aCU8Axliylwch7vWIVwRNokq9NrPqJSYiRN/uaDjgPhmjOeqT6CrHwmO2/7F0jGdCftaA5QrZe3
 7RnqO5XDrGmhS7BKiCA48Brr6GBVN+9R2WunxGwY6Azlst+EYHeRCyu4kgMh9ytZ37GlH71G5qF
 U6B+UWyeYhjddYhd8CTQfb1vUN2xL2FImnsySj+uocY4nYJpB4Sp8jSwLaxqbpA23hmCQXnmV0T
 5p1fc4JZi5ec/6BiWDj+0vADCjaojkKEoH2+iQFyt15CqEWgNZkV0Fq66mStMoFQcPSlMomubHw
 +/UHF7p1DUAyC0Q+g/3qRsv6VFXMHqO6pd/1E/h1WQZUJV5+YltI9HP3dEGDcYngvQYP75QBxwl
 GE+xg1pstkJgNHkXlGgCbmeECDD29bLtOfFgnDzr82IVTKk7C3x0NyjQx5EW0DmKXfj2UcvcQcL
 hkbHb2Jr/i7rTbJIG4w==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad85e4b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bDPAjwpS2HP9AAYYRpEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 0kXGwj25jpKqBTE11-ixT5zpt2sUQcLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210026

Some Qualcomm SoCs, such as Shikra, run the modem in a separate security
domain with restricted access to system memory. BAM-DMUX DMA mappings
and BAM descriptor FIFOs must therefore be constrained to a designated
memory region that can be shared with the modem. Accesses outside that
region can trigger an XPU violation.

When qcom,vmid is present, require a restricted DMA pool and assign the
entire pool to both the local and remote execution environments before
requesting the DMA channels.

This ensures that BAM-DMUX mappings are within the assigned region. When
the BAM DMA controller references the same pool, its descriptor FIFOs
are covered by the assignment as well.

Track the assigned execution environments explicitly and reclaim the
pool for the local environment after DMA channels and mappings are
released during remove or probe error cleanup. Skip the reclaim and
leave the pool assigned if the remote side did not acknowledge the
power-down, since it may still access the pool.

Fail probing when restricted DMA pool support is unavailable, when the
VMID property is malformed, when memory-region does not reference a
restricted DMA pool, or when the pool is not attached to the device.

Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
 drivers/net/wwan/Kconfig         |   1 +
 drivers/net/wwan/qcom_bam_dmux.c | 119 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 958dbc7347fa84ee869439bf8b503037faab8bef..1b133c56231615269698140187ca3141dfe48dbf 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -65,6 +65,7 @@ config MHI_WWAN_MBIM
 config QCOM_BAM_DMUX
 	tristate "Qualcomm BAM-DMUX WWAN network driver"
 	depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  The BAM Data Multiplexer provides access to the network data channels
 	  of modems integrated into many older Qualcomm SoCs, e.g. Qualcomm
diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8d64371eb8d00c638a39b234ee540b83c9..fa3621224a56e34086635e1abe1220c3ae40e899 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -9,14 +9,17 @@
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/if_arp.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/spinlock.h>
+#include <linux/swiotlb.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/pkt_sched.h>
@@ -75,6 +78,9 @@ struct bam_dmux {
 	struct completion pc_ack_completion;
 
 	struct dma_chan *rx, *tx;
+	phys_addr_t dma_pool_base;
+	size_t dma_pool_size;
+	u64 dma_pool_perms;
 	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
 	struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
 	spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
@@ -762,6 +768,96 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
+{
+	struct device *dev = dmux->dev;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+	struct qcom_scm_vmperm dst[2];
+	u64 src = BIT_ULL(QCOM_SCM_VMID_HLOS);
+	u32 vmid;
+	int ret;
+
+	if (!of_property_present(dev->of_node, "qcom,vmid"))
+		return 0;
+
+	ret = of_property_read_u32(dev->of_node, "qcom,vmid", &vmid);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read qcom,vmid\n");
+	if (vmid == QCOM_SCM_VMID_HLOS || vmid >= BITS_PER_TYPE(u64))
+		return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid %u\n", vmid);
+
+	if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "qcom,vmid requires DMA_RESTRICTED_POOL\n");
+
+	rmem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!rmem_np)
+		return dev_err_probe(dev, -EINVAL,
+					     "qcom,vmid requires memory-region\n");
+
+	if (!of_device_is_compatible(rmem_np, "restricted-dma-pool")) {
+		of_node_put(rmem_np);
+		return dev_err_probe(dev, -EINVAL,
+				     "memory-region must reference a restricted DMA pool\n");
+	}
+
+	rmem = of_reserved_mem_lookup(rmem_np);
+	of_node_put(rmem_np);
+	if (!rmem)
+		return dev_err_probe(dev, -EINVAL,
+					     "Failed to look up restricted DMA pool\n");
+
+	if (!is_swiotlb_for_alloc(dev))
+		return dev_err_probe(dev, -EINVAL,
+				     "Restricted DMA pool not attached\n");
+
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	dst[0].vmid = QCOM_SCM_VMID_HLOS;
+	dst[0].perm = QCOM_SCM_PERM_RW;
+	dst[1].vmid = vmid;
+	dst[1].perm = QCOM_SCM_PERM_RW;
+
+	ret = qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
+				  ARRAY_SIZE(dst));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "SCM assign restricted DMA pool failed\n");
+
+	dmux->dma_pool_base = rmem->base;
+	dmux->dma_pool_size = rmem->size;
+	/* Track the destination VMIDs explicitly for the reclaim operation. */
+	dmux->dma_pool_perms = BIT_ULL(QCOM_SCM_VMID_HLOS) | BIT_ULL(vmid);
+
+	return 0;
+}
+
+static void bam_dmux_reclaim_dma_pool(struct bam_dmux *dmux)
+{
+	struct qcom_scm_vmperm hlos = {
+		.vmid = QCOM_SCM_VMID_HLOS,
+		.perm = QCOM_SCM_PERM_RW,
+	};
+	u64 src = dmux->dma_pool_perms;
+	int ret;
+
+	if (!dmux->dma_pool_perms)
+		return;
+
+	ret = qcom_scm_assign_mem(dmux->dma_pool_base, dmux->dma_pool_size, &src,
+				  &hlos, 1);
+	if (ret) {
+		dev_err(dmux->dev, "SCM reclaim restricted DMA pool failed: %d\n", ret);
+		return;
+	}
+
+	dmux->dma_pool_perms = 0;
+}
+
+static void bam_dmux_remove(struct platform_device *pdev);
+
 static int bam_dmux_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -796,6 +892,10 @@ static int bam_dmux_probe(struct platform_device *pdev)
 				     "Failed to get pc-ack state\n");
 	dmux->pc_ack_mask = BIT(bit);
 
+	ret = bam_dmux_assign_dma_pool(dmux);
+	if (ret)
+		return ret;
+
 	init_waitqueue_head(&dmux->pc_wait);
 	init_completion(&dmux->pc_ack_completion);
 	complete_all(&dmux->pc_ack_completion);
@@ -829,8 +929,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
 
 	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
 				    &dmux->pc_state);
-	if (ret)
-		goto err_disable_pm;
+	if (ret) {
+		/* The PC IRQ may already have powered up the RX path */
+		bam_dmux_remove(pdev);
+		return ret;
+	}
 
 	/* Check if remote finished initialization before us */
 	if (dmux->pc_state) {
@@ -845,6 +948,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
 err_disable_pm:
 	pm_runtime_disable(dev);
 	pm_runtime_dont_use_autosuspend(dev);
+	bam_dmux_reclaim_dma_pool(dmux);
 	return ret;
 }
 
@@ -853,6 +957,7 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	struct bam_dmux *dmux = platform_get_drvdata(pdev);
 	struct device *dev = dmux->dev;
 	LIST_HEAD(list);
+	bool remote_suspended;
 	int i;
 
 	/* Unregister network interfaces */
@@ -872,13 +977,21 @@ static void bam_dmux_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 	/* Try to wait for remote side to drop power vote */
-	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
+	remote_suspended = wait_event_timeout(dmux->pc_wait, !dmux->rx,
+					      BAM_DMUX_REMOTE_TIMEOUT);
+	if (!remote_suspended)
 		dev_err(dev, "Timed out waiting for remote side to suspend\n");
 
 	/* Make sure everything is cleaned up before we return */
 	disable_irq(dmux->pc_irq);
 	bam_dmux_power_off(dmux);
 	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
+
+	/* The remote side may still access the pool if it did not suspend */
+	if (remote_suspended)
+		bam_dmux_reclaim_dma_pool(dmux);
+	else if (dmux->dma_pool_perms)
+		dev_warn(dev, "Leaving restricted DMA pool assigned to remote\n");
 }
 
 static const struct dev_pm_ops bam_dmux_pm_ops = {

-- 
2.34.1

