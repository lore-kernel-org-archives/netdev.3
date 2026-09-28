Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DCE13DBBD
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614122; cv=none; b=Ub6njP5Siw+TlV1U+k3SE2Xl7FEIoeWc5fdSxhYxLP9pP9NPgZufTSWWGF5EZzIRuNpfB+l9wNqGsCS2dvC09vVt65Umua6ed1S5JUnXLpfpVU+3of2OqK8R5Z4KMOjn3k5RPMiJ4KIlUx+V5NwKRmJ/tuUNWBhzjioQgRJtbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614122; c=relaxed/simple;
	bh=vJLGNzketnmdjap6Xt7D980LcTD4u/y6CPel+hPK4Io=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OdHGWA7GrqVJYA0VcP+PQQm/FeyRDqNsyecghxvDCnpsJNa5j/s7UN7VuiXWkeOdC2WYutIJ+aCJXT7fx0RMf3PjsKSl02bbXTnptisqm+l0+GQB9ULz49v7efNUUUONyIMIeOBFo3+xxx52IDvyzbqxoDF9/OBaHteXgPrznwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lIEA1Q+a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QeAuMNi9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lIEA1Q+a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QeAuMNi9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEe3E92298484
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WuXnvt8j9PQBj6KrjYCUa/
	E2KkBCNN0xgbe5L81YaOo=; b=lIEA1Q+af4rYgL0mhGOaPNXzGX6mbl04C2cyji
	/uP8Qzsaxl2UJ1D41jpQLWUQ8vpUGEsFGfO+54kWwhxM8mTjTfZLNR/Rw8Q3bjsD
	8Gct3TZ1KINhYMu0Aqjqkdcx/4X4e2UE6dFUbOopYtqW2YY/BhE+BAWWAQVarNC/
	FOMXxjvLlTOupPGzPaLDrAcxAIUxOxEiCkh3raJypxfds/utzDf4jYmnSmX+b9Ob
	a6vW6PqncT/K9iBKTmHdQwc5WXcs12VwAjpG9GD+zOFi5JLfrjUpdL/WmToWbVjP
	SSOitEtHXUf3yv2SNgdmtxsA6QLu5KEK2UQlPLH93fAFxcAQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6htva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:48:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso8320585a.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790614119; x=1791218919; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WuXnvt8j9PQBj6KrjYCUa/E2KkBCNN0xgbe5L81YaOo=;
        b=QeAuMNi9+BHBu8Wb2Zl1ju4EORgvdktEFC35jZqoojy9Fbh2SYlWq7/DgCyKhJLXF5
         3/62sEthLuzd+6bhMtfYk02A7VEaPsZ1UzMRtb9AzsaTQ0nA77AKMItA2YYz0rvYL9rm
         rLLMISOjLFXJo1wPi+fu/m5lHId+Io4YiPJxQEkC0uQWxp1/c7lfMxscVGblzZHGA5vm
         L71Z9Y3hRMoikuDfT2hLub9M9AVZxK7idLKRTODrfw5N89ddJXjXyMW6xyXRK/CnIANK
         fcUIwf8fZeZd46G1k2+u8c09hpv4Iou1+WACjhW9yGCvLcthZMH/skk0Ka3x4DQv+Gde
         sMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614119; x=1791218919;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WuXnvt8j9PQBj6KrjYCUa/E2KkBCNN0xgbe5L81YaOo=;
        b=1nQpeuujmqclsc3NK+HkJlFePtwPeew4hOlAtt9BJ1Kvw3z+HPKRKH2h5KjLsEgKz+
         0yzxW2hO3FIcqyO/OfmKrOrCxeys5nqv+a8RPjIeInNhlcIDANZOjJaUt7cfPtRJmjnL
         SYER/RvBOOxpR5h8dzGgs/HxiJQT0t9ug74Al9pwj2h5EOhV7kLJc13ftOaDDX4eBOFT
         qv3kSLHejw9ILbZz2j37VORny3knOOnp7ugurmc1/jkxkHvOBW03p1Ti9E6X+buRhqZq
         Pms/JNBAXiGEyR3SQ/R1eLC4/diXcvVAbyJArpHByhFuflVQTe1VGw5qRnR8qzbVYRKD
         ldGw==
X-Forwarded-Encrypted: i=1; AKwUvBxfdjJCss7OAPjRJw/dFdUyD1rsQo4SKAaaf+yc5y+vQYCI5ipH5I/D5fGzeflNCjlfJ7mdCr0=@vger.kernel.org
X-Gm-Message-State: AFuF++mjosXCQQYbkVmXEhk0eQPTljRxNP+aPMB35y7WSbDtqNU9K3b0
	Qgbid6GfeX9ZZdDJTgQb4C46ow6KKCSXCVDywGYLGpkjYF7DzdqTT9OF37ljO4n9X54kJfn3hbd
	67Rt7kFc83tWcFcaLXOGB3/IDZbaLIQA5WGwZE8PLVkwEgV+0ycRaq9Fzatw=
X-Gm-Gg: AYBFou2/PEIrqnr59W+aROL1sAuORQdpe1x3ZCoFrtvY7TmHaAADKdFU/Hb84XnRNjn
	Wdx/C3TwekKN0Rt3TJS6ENpCHQ1CvedgCRnitOmuqHTDWhAet1gXm4iJ9Dm5pZCnB0Dkg9aL958
	dcWUltyS/vY1gxYklXKG145UQCJuHBNbJoCvSj+URNFMJlbwzzVuVUdieLTbS4yJ/raZQW9vkUn
	7QnYC8772yX0Y8xhw/WD9d5nXfd+VUhKF5nXyaBs+uFUmtrSgY8fZtvZ5kwT+KQKPbGDnAM5x4p
	QCnXjuYX9uLVZskWqViOy24f2dxXhEeF6BPBiJPc2fQxxwVwKqBbT28je4pjlx9VGCca6Lk9ntP
	s256+yAz2yzMW2Q==
X-Received: by 2002:a05:620a:6086:b0:93c:3863:ff7f with SMTP id af79cd13be357-93c8bb5a7d3mr1851185a.0.1790614119255;
        Mon, 28 Sep 2026 09:48:39 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:93c:3863:ff7f with SMTP id af79cd13be357-93c8bb5a7d3mr1846485a.0.1790614118704;
        Mon, 28 Sep 2026 09:48:38 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0f68basm3662345e9.12.2026.09.28.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:48:37 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v3 0/2] net: stmmac: Introduce hw queue priority
 offload
Date: Mon, 28 Sep 2026 18:48:12 +0200
Message-Id: <20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NSwqDMBgE4KtI1v3FxKqxq96jdBHzqAFjNEmDR
 bx7Q1ZdlNLNwDDwzY68dFp6dCl25GTUXts5lfpUID6y+SFBi9QRqUhb9ZiCD8YwDmZdnLaQwyo
 1WSagFpQI2qlu4BQlYHFS6S3jNzTLALPcArqnZdQ+WPfKrxHn/Z+DiAFDUxOKm07xoaFX6325P
 tnErTFliqxH8iGS80+RQAVKCDq0vVScqy/icRxvF2bcjycBAAA=
X-Change-ID: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Davide Caratti <dcaratti@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX4xYHVKM06iQ1
 64awCzOqiiZk7xIHI1gNeahRBmrryYoZ2tGXPQShsjwCPtu8Ee7pmyIQ2QcEbENFa4MDLButSUE
 iM9Vj39ZQjD3p5ZL5hW3COUWFDrAcrpqKqL6HjjI/0vMNnM6XJNmWP2VCLYixkRdZtbEeSQBIOC
 JVrIw+/kvjo0Hsy/Pc72SBl11JSot3P++ClxCp6JQTGVFJCF/DxuKZJHzOM9APHSPRktmT+f/A0
 q8/1iAMNAVX+fXDr7ub2hC6pYgN4fHN5EHRbs42qYBtx0TPhXAekQxyeiUHpzxWQ0h2A+rgapn8
 Ur8DB2eeyuA/ANTlXdxpVvdG6Ujwn85BpLuf0Dy46GuVZhoXc7EW3BKAhFRa/LgPQfBkW3ORr9y
 zdofjEO2Pe+cDOklJiAUlbPEYI+wQNtZm215RbKOHhs6e/pRhS1eJuEvtHxpLSenm/9FQV4fM6c
 l//p7K5qZJCtWDqQhOw==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6aba9a68 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qGTJnaR_OStqIhYHjaMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfXyC4Wups3U1mg
 rg6Z3lu7ec7o5CzxAePHKRFc73rPzYJ0Uw/732GtzOBFm/TwuBWO9GC42pqGgwpGMj9Z7kbiJbe
 90ohpmkkWyDIqNWqOGJ4H3X4HNyOjfw=
X-Proofpoint-ORIG-GUID: XxpTXpqHLCuSoEmkrLnVoXZlOwyNFxEk
X-Proofpoint-GUID: XxpTXpqHLCuSoEmkrLnVoXZlOwyNFxEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280066

Implement the offload of the tc mqprio hw queue priority in the stmmac
driver. This feature requires the mqprio to be configured in channel
mode.
Do not overwrite real_num_tx_queues configured by the qdisc in
stmmac_hw_setup().

---
Changes in v3:
- Fix cbs overwriting removing mqprio qdisc configured in dcb mode.
- Return an error in stmmac_reinit_queues() if configured number of tx
  queues is lower than xmit_qdisc.num_tx_queues and mqprio offloading is
  enabled.
- Link to v2: https://lore.kernel.org/r/20260924-stmmac-mqprio-prio-offload-v2-0-fdd8b69efccf@oss.qualcomm.com

Changes in v2:
- Forbid cbs queue offload if mqprio is already enabled.
- SP requires 1:1 TC to TXQ map.
- Fix the real_num_tx_queue overwrite during device open.
- Require the qdisc to be configured in channel mode to enable hw queue
  priority offload in order to not introduce any regression in the
  previous driver behaviour.
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-mqprio-prio-offload-v1-1-5328157fcb58@oss.qualcomm.com

---
Lorenzo Bianconi (2):
      net: stmmac: add tc mqprio hw queue priority offload
      net: stmmac: align real_num_tx_queues to mqprio configuration

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   9 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  37 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 144 ++++++++++++++++++++--
 4 files changed, 169 insertions(+), 23 deletions(-)
---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

