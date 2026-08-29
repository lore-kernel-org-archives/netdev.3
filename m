Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0813264C7
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787992166; cv=none; b=QIw+Zet5dMD3OvMUweON8S7D4WuXj0DimuewFtzzmIvSB5ZB2DmUH0EK3g3csq+Lfq9Oo5lWHzdMJjPhl6zolsKd2nKtKCA1Jo9hE2EiooW4NhnwhM5GrgyKG1hdURg3o6hxw8wxPlMSELaBwDeDzsjTzBjtKBE+nInPn3NN43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787992166; c=relaxed/simple;
	bh=dFpkxZ6S0GABT+n/bMxQ5rDAGck+CMsMGlaFbIsqlXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhiaD+4aKrPYwFtM5aee//ZQqX0upcwxpeYZehEnHoy8tgFAR9L8oFtzbdQjPKS0+LQWmbfLJ5d+Yvez4wNKo/g11zg9r10JlUKfpR5K7Cw/MnUEAl+VfOYlw544wgJX2fU6YgaHqM5LSO2165ilFHVjjvwccEaLbrpRnmgw5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJKBSSSo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T/9GTDdb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJKBSSSo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T/9GTDdb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T81B8S741542
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MKn8lekjkFoQYC6eM+ArO7Rdiu2dZ1XkkIrsn13g+Yc=; b=cJKBSSSoupBmZTTP
	T/dTW7GGPzY3YpdwrZQJwEKYl05vFjdYOjrRErAisvoVkfx2pSypT9ySWKmbgk0c
	msp6sDG3C0ubEIg7WI0P9WDQMX+LIpiz7zML6HaQrRfw6xBDLv4b69RkCoTwwSpr
	HoweePevxdxn50qlPJ8O/lQ47Bygjvi2LdSR6X2fe4UdcGvXN5XRGuo1va4Of30y
	dvW8MXn7tNMXsCSe9gvQYW8tbTlLgvZSpO7WihBsP+/laT827SnLASq4JhqibO6/
	/n16/yY6eKVrBgkz0TCevRvQEuTaj6KTX7xi+fZiNBqNQFLLXdkwg3OxudjFB/2y
	engASQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6gfmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52e7a49452aso25188681cf.3
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787992163; x=1788596963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKn8lekjkFoQYC6eM+ArO7Rdiu2dZ1XkkIrsn13g+Yc=;
        b=T/9GTDdbmFlj7UtfftwSzhpeVxk4kl+pQsOE15Ol5jQtu1IXVnbnieGn11kwp8yuQW
         Dd/0j8jJhVZPqOdWTWfdjpR/yHB3rah/vpyj7DzWpBifijh1Dp+kr3j/o0gXgQvkalk+
         iRucbm4BDs4/HbGMPDzK8Uj13sfBppEO8l8CAjp5/AByxK6oWy/rKyCkSe2Pkz71rovt
         C+O0f+fEx72r39z0NWj/InGTBqBrmNAitglo8f4X13yprtrR9ImggxbjXYt4ygSfcUCW
         g6yX+BP/XALvWDHI+uzCUeSW0RBm0tMxFBfmMpdD1p1j6SjSuqwWCd47vM5aTnAwzOJu
         m8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787992163; x=1788596963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKn8lekjkFoQYC6eM+ArO7Rdiu2dZ1XkkIrsn13g+Yc=;
        b=tAtKTUx0bWf8oiuVQCu1E75xV0Eed/CdvD3oCdVL3ntZYjSiKfcHUOZLwAo7NBefW7
         60gW6TVyk2fj/KNf8kss862Rxg/PYD/2oc/4Zh6rwoB1jaVLhtRlppeW/XbFKaVtDbve
         qnqArfdepfZHvlBtqIXY8QRyvgXWoBdtnvesGk28Zi5o/kfSM53fEAK6oW+Tt8ewAQf1
         uRuVyzgR7fRaJ8OiWMfP4TvMTHgVoE/xnNHyYYmxYOiMcyPlXhlJ4DYSRLdZjZr/Rvb0
         krPTuSnnuGM3Y8E+kAE97HPiOBkAvsmS4odPXW3kkp2CJhW5lY/c2Pkgp3NXvS8KfZaz
         bYvw==
X-Gm-Message-State: AFuF++mWEMt9VXuYVD9LIO3Nn5Zs/RK9pVfguXCfx8KTNyHXAt72wdQ7
	G+ylJXGZx3OosaN6oiBosqQgp+VBQES7g0QN5ehLGIXz4/B0htgeuR12G/Bo8A/zrdXmbZmnr6r
	sIBxP1aBXvYNez4eXOl4m2KvhiIvrT+y14ThnGkJ5XxBjK60xgGrTGswmpSY=
X-Gm-Gg: AR+sD117Tg2D4x/aTJl4z0hYSEtCla016kJ01HVx9/6BfKdfdr1PcFQN2zFBh54Lm9T
	4nt7Rn46Gqv5f9oawxHh8sKjW5OSqG6vpzRCWtyjF67h+1GFvWc2mucP9O6iiOnneyX28EA0pMZ
	pDDWRFMZL5B5/midxqCZQvbKIjeo3CVpvNDOXDDo2G+x+KaGkT2EXfi8u2BZ5UrhllV3EnHxfom
	i1xuzEoLbycbBu/2z10Kt5uLWCrHpQuVFbyiIrx9Tmvw/N0suvEEqFDXg+UiS9TQxKjGgDubBjN
	lYidJudqUB9vUEryGBX3QwijE7k64KFCYxgNDOwhvxA/U/nRgsJtgrn8aI8kz2XMH71BVvltt19
	7CakHZCUi2j6uAA==
X-Received: by 2002:a05:622a:1308:b0:52d:844c:b0c2 with SMTP id d75a77b69052e-52fb9429883mr141022281cf.12.1787992163555;
        Sat, 29 Aug 2026 01:29:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1308:b0:52d:844c:b0c2 with SMTP id d75a77b69052e-52fb9429883mr141021991cf.12.1787992163169;
        Sat, 29 Aug 2026 01:29:23 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20793sm8640067f8f.17.2026.08.29.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:29:22 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 29 Aug 2026 10:28:50 +0200
Subject: [PATCH net 2/2] net: stmmac: preserve FPE preemption class across
 qdisc replacement
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-stmmac-fix-graft-overwrite-v1-2-a4f84c4c264e@oss.qualcomm.com>
References: <20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e@oss.qualcomm.com>
In-Reply-To: <20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: -8JuP8UJ_BYNq2wYPDCrMPUV2qSL8wP1
X-Proofpoint-GUID: -8JuP8UJ_BYNq2wYPDCrMPUV2qSL8wP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA3MiBTYWx0ZWRfX4wGJ4BM5jirz
 M9xGmhJz07TSXWkvqBZPJBD3ZOCvkvQ6PUoaObAlot3AeeLGzw0cemI62zWzdO/TYdffoJUBHRh
 y8AHRiOKWNYan4Q2OsWw7//1Zgqwv4+/wp30eJzqWxeCgPwA8vExfvrgmj3/Bv4pVR0DTf30+wh
 qyhe4M8fM3Susf8cgaNeFJLjpJ8/8uo+PKsvXO05baNg6mYxyf7YEel8dbDmKqChTY+ck2//mnp
 RwDJzvLK+p7o/PRWIKzVZbso906Hyr73MbpfpD23ZYgUccv1EPSGKxwKvHNqQRgiHxWapBn/IX5
 m+wm+AZst7ARkK/YqOPI9l1Jzj0maX04Oect87/P+RgMSGdALmztTwxKHlHnMt6vKEhiYcZ+Z3U
 jmgH/maChskUn4Fo0IQgGRjgd2T5R/YnvrxMCqgQW3OH8zAmIv+ZMwjM5+mAvuJP6T7ics0h9JP
 TBmsMNyUGfdwRZ/TMRw==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a929864 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Z2yARmqO49GXmbJYkD0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA3MiBTYWx0ZWRfXwMC3B5ULzOZe
 aKXwVPAHm3RR1ouxKrIN+rU804G3wkhQElruWYTfX9P0A5/83fx/3ougYJBvaBwyr/P838Gg5xY
 pUV0UNgRHUmviKO+CesUe1/KumcihNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290072

The kernel replaces a root qdisc by creating the new qdisc first and
destroying the old one only afterwards (qdisc_create() then
qdisc_graft() -> notify_and_destroy()). For a cross-kind replace this
means the teardown of the old qdisc runs after the offload of the new
one.

This breaks the FPE preemption-class mapping when replacing between
qdiscs that both program it. For example replacing taprio with mqprio:

  1. the mqprio offload (REPLACE) programs FPE_MTL_PREEMPTION_CLASS
     with mqprio->preemptible_tcs
  2. the old taprio is then torn down; tc_taprio_configure() runs the
     TAPRIO_CMD_DESTROY path and resets the preemption class to 0

Track which root qdisc policy is currently offloaded in a new
priv->qdisc_type field and only clear the FPE preemption class during
teardown if the qdisc being destroyed actually owns it.

Fixes: 15d8a407a547 ("net: stmmac: support fp parameter of tc-taprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h    |  7 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..957317ec1461 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -258,6 +258,12 @@ struct stmmac_msi {
 	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
 };
 
+enum stmmac_qdisc_type {
+	STMMAC_QDISC_NONE = 0,
+	STMMAC_QDISC_MQPRIO,
+	STMMAC_QDISC_TAPRIO,
+};
+
 struct stmmac_priv {
 	/* Frequently used values are kept adjacent for cache effect */
 	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
@@ -299,6 +305,7 @@ struct stmmac_priv {
 	/* Protect est parameters */
 	struct mutex est_lock;
 	struct stmmac_est *est;
+	enum stmmac_qdisc_type qdisc_type;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index be8ddda2aa76..7fe587b47d52 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1103,6 +1103,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (ret)
 		goto disable;
 
+	priv->qdisc_type = STMMAC_QDISC_TAPRIO;
+
 	return 0;
 
 disable:
@@ -1120,7 +1122,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+	if (priv->qdisc_type == STMMAC_QDISC_TAPRIO &&
+	    qopt->cmd == TAPRIO_CMD_DESTROY) {
+		stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+		priv->qdisc_type = STMMAC_QDISC_NONE;
+	}
 
 	return ret;
 }
@@ -1266,9 +1272,15 @@ static void stmmac_reset_tc_mqprio(struct net_device *ndev,
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
-	netdev_reset_tc(ndev);
-	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
-	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+	if (priv->qdisc_type != STMMAC_QDISC_TAPRIO)
+		stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+
+	if (priv->qdisc_type == STMMAC_QDISC_MQPRIO) {
+		netdev_reset_tc(ndev);
+		netif_set_real_num_tx_queues(ndev,
+					     priv->plat->tx_queues_to_use);
+		priv->qdisc_type = STMMAC_QDISC_NONE;
+	}
 }
 
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
@@ -1318,6 +1330,8 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_num_tx_queues;
 
+	priv->qdisc_type = STMMAC_QDISC_MQPRIO;
+
 	return 0;
 
 error_reset_num_tx_queues:

-- 
2.55.0

