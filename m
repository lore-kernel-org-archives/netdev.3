Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6757267A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963990; cv=none; b=tHKe1DMLNS6Nd45+GfKLcBk6uiO6pw9JTFx5SVSbyeVa8lcdTy7vTJkt1ECvPwZyTl6RTSwN1sXgGh16Ok+416+m0C4LhImV7/GL80e+JkdZ9nP6T+69BSCjv5szYofKZFdF9SnJpcVkI/ngcF2AnBfJbDy3KRYS5bGUwnlWQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963990; c=relaxed/simple;
	bh=KIPSu7LnShJtGhkrS5b66L2z/6GZehxGDVWmv1e84sc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YE1yOzne4zH2o5tJHUCxcTiCVMYNSuFfFI4iNv9khye9Fb+mLPibGX45pRrVXu8oRigvg4Q4UAk2PY998XV9N9HAvOvQ5nmrPAssnxOTNGr2uzf6mPyFZ8a4ddOaCQdJsbNkZ3aSjSFLUcoPUDeW78U9lEgAho8Bh27AeiGudM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fiNENcS1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EM2FVaxQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fiNENcS1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EM2FVaxQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU6bR599687
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 14:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JR+7V3ELA9sqnRkBsDPxRp
	m0VgnUHbPahmeijDV/V78=; b=fiNENcS1XYTPBkeRrnQ339/NgAivJA+xwqNr+0
	lceaQEXeHdqt/V7NnbtP9w4fZogyIEh1nhDT0g1TVpMHM9AXNpVoAnfUtUhtEImB
	WTU73LmDd+orTPbos2pgKKMJKXuAjuLS+76YEACtw/0rzohommFYUbPSO5IwGw+R
	qOX7N4GFMvlySBrs3QY5yzbCFeAGU/WdRQLa0DQhhJBgiW4DobE+J4kmzhTii8v5
	+epKA+Y0liACRb3YSe7RMi+aozrvinK8fAnTLhl/jk8frZtozeZteRwb8DNFQZMM
	UsXp7Thj1+1bBNqBlwEhHputtY3JRVa8DuweOEOGS4ZCZqTw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjywr2kkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 14:26:28 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c7a3b3c06bso1814104e0c.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788963988; x=1789568788; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JR+7V3ELA9sqnRkBsDPxRpm0VgnUHbPahmeijDV/V78=;
        b=EM2FVaxQeCxYcF+ISVcgPrI1VwHygx+euQYrtuwO/lGIFFMXHz+wiL7pZsm6BNV6UN
         air/NZyoJg/+JiLHqaWozYlayIRMxGPMFuYzuSVGxZaTCqYTg6ECITWs8PesAF/zKqJY
         67TzO8bmV0TAM4vdNLu7TFhxKoX7q9p0Gqj4HDjIQNf1DAAjHoA7Gp75oWx57+xlYU+j
         aGhFPorHhcmnNLiEKQUeZqKM75+rAFuTDNTNvvIQwHhB1ZhqvJpPz+FFNXJ+6IGIRROY
         0wVsyReqtyOGVtMF7Jl8x06ahh9KqgveNUDFEeLRdOYSvk0A2H7mZhqx/Fs4itqOrqMg
         Inzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963988; x=1789568788;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JR+7V3ELA9sqnRkBsDPxRpm0VgnUHbPahmeijDV/V78=;
        b=TvdUIgn3vfzPLKhSH/1kO196DfvD8+EOxR0FFImlX3bdu3To/tQfqJH697hl11PKt4
         rZ2O/Hzk0Y3S9rly6skBLxAF2n+lY3WB64Vukf3gLdd6g6zp9XLteKI22VuztzIRwrXm
         LS+7QdNbp1uz/3CL5miOOHEIPvHh+jKd6MNwcUHF9n8lsbajr40jqP6J+aRPGRDb6bjC
         4GYhzJOFRDM+gbMKOoEu/yfw+6iwLFeHeFmuNvo2OpPQbu+ygcZSyUI3iBrppQk0yLSY
         Jx448mPG9pJsTZS4o4dn3WngD4TWyyj31/rASmE57Wk69xapVd+5Zb9blzSdo4dixgwh
         lxtA==
X-Gm-Message-State: AFuF++mO2DVHsd9FHOmU7br1AsaxkuDJlCP4IXTuwJytsvtkyARilmLi
	GXRW0Xy2AwMUl8uKog5Kr6LBAzaYA03q/4WRJ38qVIWB2XxdDs+p2NcFz77NhE1s9xqthJlLkZ+
	40kxLJ+pzIG9DyhH9bAU05HolOlcP2ZwJnqaxRrpVEuSetE66pH8rvc/7Z/w=
X-Gm-Gg: AYBFou29kkZrF71RPdMOPlqFeXNF84SJXnFarCXbzXRQ+XJgPZY/qhwIeoN+epuA/2O
	omX3tSWCAhZpF0kl5vcFB1SsVGIUzIq5gG+rVW1qBDFV99qbW4eNn7GpQ3Oufqt2WEAn5RgNS20
	2fjzk8Wiz8DgwzV0uga3++ncuZLnKvhIvBjX95lfTZGKan6jtzlNCdwbzZ7+dxQrZTzsLrbn+rN
	KdFcNq6Lgt+zJYwsHLmgxmZGyknX2Vuq2+dQWYEfxnl/vAB0sMgdY06NOI/fXIRSfOwaskhP4AK
	0W25OrVJcgoCL50/ztutbn1tf0Ccnr15gY6N5TW32GKzN3m9li6sVPtyy7o9zVXcw4bZMJdvXb5
	Qi5tcIR2wrLKGcQ==
X-Received: by 2002:a05:6122:1785:b0:5bd:c27a:dafd with SMTP id 71dfb90a1353d-5c7ed3b1b2cmr17726316e0c.3.1788963987582;
        Wed, 09 Sep 2026 07:26:27 -0700 (PDT)
X-Received: by 2002:a05:6122:1785:b0:5bd:c27a:dafd with SMTP id 71dfb90a1353d-5c7ed3b1b2cmr17726204e0c.3.1788963986664;
        Wed, 09 Sep 2026 07:26:26 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm39428246f8f.5.2026.09.09.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:26:25 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v2 0/2] net: stmmac: restore previous state if
 tc_setup_dwmac510_mqprio() fails
Date: Wed, 09 Sep 2026 16:26:08 +0200
Message-Id: <20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-0-8158b8333b3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OXQ6CMBCEr2L22SX9QVGfvIchpNBFmlha2oIaw
 t1tOIIvk3wzycysECkYinA7rBBoMdG4MYM4HqAb1PgkNDozCCbO7MokxmSt6jB1TaQ0+0a/M54
 4a+zkg3FIIbiAXqUBL7qshCqllr2AXOgD9eazjz1gpAR1NgcTkwvf/cDC9+ifrYUjR2p5xVutZ
 cnU3cVYTLN6dc7aIgvU27b9AEp1IkjwAAAA
X-Change-ID: 20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-8d472a43d3f2
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=a4YAM0SF c=1 sm=1 tr=0 ts=6aa16c94 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UB8DtK870HQNYGIhTBYA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2MSBTYWx0ZWRfX10mGwPWbbTR+
 KZHHgLgRjYCMD3eXtFfExp2zH2N5+4oQ/PPyPU++WbQeazn5Kq2PZOR9vAyr37wSlamnkJ7V0WR
 Qt+o2evbTD7YkigY9g2vSEJZWuMS+cSjeq/iDxEhFZJPeM0+8qBFN7cZcVpiYUAyeuKRRo8T+tC
 SQ78xPrRIZvMm+w6sJvPBZBO1OZh2rMWQnS67+tiqTSstzPPoo7eMvJP6dLLg+pGBgDPsunrYLs
 jx9rmXpysDYRdqLoPgt+2+Zus5f2bW0H29SB01A8henCHts7+txwGswOC7SOAImO3JHoXvVt7R+
 TlQQEAT50yfmdB5D4oA5WiBEuxbmbpHcidXI5CW7t5BSm3EP0qXB9OhuKdXM9IIO5QdE/XW3Uhq
 RWwcxl3mD5wRLXutPOWHnCs8KjELeBdoZQih+NMgxfHhrpCfbkcmw2rvvA2fwuMQH29dppA1Qyj
 dwNqukirhG0l6h3hb1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2MSBTYWx0ZWRfX9Ftbftgj4Lqz
 LcpMvLngNb9wtEPSrEOEqx24/hsZ2cE/0ifCBB3sP59i76N2tz7yadml7n1uIajOA6ZAU+EXmBj
 88sx8Ea47g68reVdcLWtQObz4YXbNYU=
X-Proofpoint-ORIG-GUID: PBKjYinlOeP0ujrU_mVAFT2dnPYTiqY9
X-Proofpoint-GUID: PBKjYinlOeP0ujrU_mVAFT2dnPYTiqY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090161

Restore previous mqprio qdisc configuration if
tc_setup_dwmac510_mqprio() fails running the following configuration:

  $tc qdisc add dev eth0 root handle 1: mqprio queues 4@0 4@4
  $tc qdisc replace dev eth0 root handle 2: mqprio queues 2@0 2@2 fp E P

Propagate FPE preemption-class mapping errors in
tc_setup_dwmac510_mqprio() and tc_taprio_configure().

---
Changes in v2:
- Move stmmac_fpe_map_preemption_class macro definition in a dedicated
  patch.
- Improve commit message providing a configuration example.
- Link to v1: https://lore.kernel.org/r/20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-v1-1-eb171bdd340a@oss.qualcomm.com

---
Lorenzo Bianconi (2):
      net: stmmac: propagate FPE preemption-class mapping errors
      net: stmmac: preserve real_num_tx_queues on mqprio setup failure

 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 97 +++++++++++++++++--------
 2 files changed, 69 insertions(+), 30 deletions(-)
---
base-commit: 382a373d9ea7a6ac4de9c022385b6217f65ae3cc
change-id: 20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-8d472a43d3f2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

