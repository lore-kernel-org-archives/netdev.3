Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395244470A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937479; cv=none; b=uHwiJUYxmU54rI9DAmvQk5NibN+rGZdmkuo0Z2bIKet/WUi7t/UTHHLBTSLSmmK7p5/rBTy9kudiOfTjrhVcH3hWUW+EQ9y4KRtah+1CBQprejYmdlwXMfyPUy/8+SNlj1BS0p3DlislbrEaaPgSGj9kN3Leaq7uV2LT7V5m5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937479; c=relaxed/simple;
	bh=qqY0nQKJw7PnHXT/5wfpO7Z78q38N/zBUPuD4QeG8fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G8r+utdXzZt+TCKxnuJyMbd6u5n5bHhzfLOdFYKBpOrlP77nA/NymzffwrU8Aj2Hifon0MoqZ/raK6N0bSq0lmIzX0cgKh5tp5IA8reC3BT7chs5dMb433DYH53L6K8Z5fcco870/rZkGLHc5mgHRvVA18SQ6oQtO4JKwCumR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODepL0zb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9r1Mzx9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODepL0zb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9r1Mzx9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929nSDr2135494
	for <netdev@vger.kernel.org>; Fri, 2 Oct 2026 10:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K491LnzWM9Tj5ojvjk2Jwr
	4QE+N/sscu3wT90FEFOPs=; b=ODepL0zbDytGOTxfFAVoWGIGNfk3S0eim2j79c
	I9czJIUVMjp463+9vD/Y8WoBWNuEikb6OxFYludp3lpqYgumyky0q1suk9kxNrj/
	SK5yuy3KLe9ZY36Z2rEg+Fms5lCi9KCuAIrQSLee5GpA/WMk3dlmLsaBNIWnRKQj
	LgRTk1YvcCFiaqnBOdhA4bgh9sMpmLApM5oYaqp6LienVDGCWq5Cd+kXg3KyWdTU
	tlu9iBO30CZlCYrQLeopg0pIEPb8VCdbP/3FLI2NfJGL7SNvSJAmIBpNRbwe8fSL
	kerj57JmYonb6lkxA4h2SVcr+zyJy/U0+gdDjo+l4ncVkGHw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp0xfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 10:37:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e46c120dfso24077585a.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790937476; x=1791542276; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K491LnzWM9Tj5ojvjk2Jwr4QE+N/sscu3wT90FEFOPs=;
        b=g9r1Mzx97DrZ/K2xgKn1zbNSzSFw7N8KZQNMT1ngtCd9aLBze/yiUBmf8d4lwaSdli
         dVse7cqnzFRFl2jg6lq6+VWmQrjFF8mAczEqZLdNDLyW9IEfMXA93SETBfURAPADJlIl
         CGc5OQ7gqcXcrAWK5yM38CReMgUwDUdepa49DAJbAxSO15YUXXcVGjnmEGhHQmhwDOm7
         Y/yhv2N0VS6r1uCNLZwRFNfHmk0mosdAEJTKsJYSiTyNjrrNI5sIOm7asRNe1cZxzcIM
         Zs2b3BJnNv+Q1mnFUMm5N/GqayYEm2QjXqlF4DROJh+ClssgkLKarMvEYtvlVQIuxM4J
         bWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790937476; x=1791542276;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K491LnzWM9Tj5ojvjk2Jwr4QE+N/sscu3wT90FEFOPs=;
        b=NKlwE75uGYBRkuBQuMRP+li7Hrql9TygqXn4GwGiC4n9HQ16ZeBim27NWFySw29ItR
         rGhx5+ppII8MEiLwSlaHiHKE9loOHnwIqNHy+/eOeZ+Ft9YtG79ALN+9zZh0JWxebpqc
         8skZT0Yb5lrlnkata546bqoqBDPFM4JgQREUeEdgwt085Z9JIvf6+jgMX72pi+ZfcCSJ
         OxW2t7ObENzb6kZ6siXWrAicJTKjbDVuw0L/BLmB8b0PPBoDh4JgEiyk92ujuN3/uRxG
         uLwzsgiak69ClAoe4GpN4mc9qFoukAmV4sXpi7I5KVSPrmh/I7eRmzNO3AFWB1UV/8lE
         ukqw==
X-Gm-Message-State: AFuF++kK2CiKYWL5+L+5G47Q8cB6LvxE8kBoWxNVzG7bltraGqTmSvGS
	tXfIOOUJy+wUzKBgv8iZE+3CX0OGFgoISIFWq0MVCatrrjPaxmJl/oq4d6SkjbjLgmLnqAoAnCD
	tbs/v6NYL/B7oC8ECjs5/q/BJsnuv47/cmBmUDsfbQzGcUkINWSMZHCJi1O03VH7zL/M=
X-Gm-Gg: AYBFou2iOd1c3A4wt9AVnXLygSEjkVrO3QBZfk+l6VfWWSMpV7lO5ObPmU/tkxqtEW3
	Ymd49/9ibnTLKvXBbPEUQh231syS+aApVZ6Ci0o127wX6BCO+8sSsaaIBjyDakB793EQ0IxDgce
	z94/7zzcM2BsdsNM2TWPAOtU35B3g3e0QoQhFzLWtMg6oYp2PGS9zz1nplygG1ZQpFvPFhURwSf
	Mr3YBoEyRaArEBcDpNpBogQ4kBd1pJbqmyebOY7POvztgUubmY97zqms2pytsfr2NTPM3+MKgO6
	Mdyp0cpLi38bme0Y3c1E9JJ4r7PUlSZq0vkpdhMnulHhSZm9Qjj2sc9xAR5sIuDkfQQk/5LvEiB
	zapSCIWfLbV/MQQ==
X-Received: by 2002:a05:620a:800d:b0:93c:7d49:7b83 with SMTP id af79cd13be357-93ce7c0ec12mr378983785a.11.1790937475747;
        Fri, 02 Oct 2026 03:37:55 -0700 (PDT)
X-Received: by 2002:a05:620a:800d:b0:93c:7d49:7b83 with SMTP id af79cd13be357-93ce7c0ec12mr378977185a.11.1790937475064;
        Fri, 02 Oct 2026 03:37:55 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm50479835e9.2.2026.10.02.03.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:37:51 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 02 Oct 2026 12:37:26 +0200
Subject: [PATCH net] net: stmmac: serialize PTP timestamping configuration
 with priv->lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAwA0F+RnBeonVT0V2SHLmYatlZpigriv
 1t2fJd3gnISVuirExJvorLEgvpRAc0+TowyFoM11tXGWNQcgiec96zZhxWDqEqc8LfQF9/Ot13
 bkWueBKVYE3/k+PcDRM7wuq4b0rY6enMAAAA=
X-Change-ID: 20261002-stmmac-hwtstamp-missing-lock-b6a7979c643c
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6abf8985 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PlVWoO2b25ILWCNQflAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: N0DLNH0EdPc6uRxhiCh962D55PRz-Kbk
X-Proofpoint-ORIG-GUID: N0DLNH0EdPc6uRxhiCh962D55PRz-Kbk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX+xsC4j/EK1+v
 Jo4P8rTpkKfFcTtBp7GoEhutJ7m+HfCBU/KFUe+HMB1IvWfzmGXBYa9Z1oIKbc7z8sCgO0p3vL8
 4Cwy3XL5Zsfdmqp3o88zap/OCCaq7sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX08u0X1Wj12ho
 tHoq+e4W4+NKos5JOQHtMYPaFYtfhqb+wW58MUPcQVICpkVka8gJMKEzTYXAWgiQy9hJPmqrS2R
 +IsSVJ9K/RGByQdjSWTy0pr02DhzeUuQlDU4wGhqQCrE1e+Bpz+v2T7wa1SY4fwhAGwW1QSoTaY
 6s0ep24yLhezkmGVbddifSvYoY8V9wgkSKfuhtfjSXXyV7NuGj9mVp5zEtmaO9h9fS7ReTsBxJn
 8i7sah/5NDGjFs/VsRGCf1yxssvuTiIz18HZQ11Xrsp2rnVAQqsC+Jzg+8lbGN3TkUtn2gFZtrx
 iJNWQZFpCgoBonsaXyEah3O/NCDHM5gWqd69kfyDDyP/Ku/Z4lCjiEqNW8ZyTi5I9sxUnXDtV2X
 iC7fnsNWsvQnQunhwEqmASoLusi4LJtDGcBOauEIKIc2/7VLV54Rqv0c8W0GJwREDuFS96MYtpm
 bwZjFDeC6oH/yTUTnCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020042

stmmac_dl_ts_coarse_set() runs under devl_lock only while
stmmac_hwtstamp_set() runs under RTNL. They read/write
systime_flags/tsfupdt_coarse and run stmmac_config_hw_tstamping().

stmmac_dl_ts_coarse_set() snapshots priv->systime_flags, programs
PTP_TCR, PTP_SSIR and PTP_TAR, and only then publishes tsfupdt_coarse
and systime_flags. A concurrent stmmac_hwtstamp_set() can read the
stale tsfupdt_coarse, build fine-mode flags, program PTP_TCR in fine
mode and set hwts_rx_en.

Take priv->lock in both stmmac_dl_ts_coarse_set() and
stmmac_hwtstamp_set() so the timestamping configuration is updated
under a single lock.

Fixes: 4347287b8627 ("net: stmmac: propagate PTP addend and system time programming errors")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++++++++---------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9741f97fa37a..a6793054a179 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -685,14 +685,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	u32 snap_type_sel = 0;
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
-
-	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
-		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
-		priv->hwts_tx_en = 0;
-		priv->hwts_rx_en = 0;
-
-		return -EOPNOTSUPP;
-	}
+	int ret = 0;
 
 	if (!netif_running(dev)) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -700,13 +693,23 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 		return -ENODEV;
 	}
 
-	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
-		   __func__, config->flags, config->tx_type, config->rx_filter);
-
 	if (config->tx_type != HWTSTAMP_TX_OFF &&
 	    config->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
+	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
+		   __func__, config->flags, config->tx_type, config->rx_filter);
+
+	mutex_lock(&priv->lock);
+
+	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
+		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
+		priv->hwts_tx_en = 0;
+		priv->hwts_rx_en = 0;
+		ret = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	if (priv->adv_ts) {
 		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
@@ -829,7 +832,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 			break;
 
 		default:
-			return -ERANGE;
+			ret = -ERANGE;
+			goto unlock;
 		}
 	} else {
 		switch (config->rx_filter) {
@@ -859,8 +863,10 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
 
 	priv->tstamp_config = *config;
+unlock:
+	mutex_unlock(&priv->lock);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -7753,9 +7759,12 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 {
 	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
 	struct stmmac_priv *priv = dl_priv->stmmac_priv;
-	u32 systime_flags = priv->systime_flags;
+	u32 systime_flags;
 	int ret;
 
+	mutex_lock(&priv->lock);
+
+	systime_flags = priv->systime_flags;
 	if (ctx->val.vbool)
 		systime_flags &= ~PTP_TCR_TSCFUPDT;
 	else
@@ -7768,13 +7777,15 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 	if (ret) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "failed to reconfigure PTP adjustment");
-		return ret;
+		goto unlock;
 	}
 
 	priv->tsfupdt_coarse = ctx->val.vbool;
 	priv->systime_flags = systime_flags;
+unlock:
+	mutex_unlock(&priv->lock);
 
-	return 0;
+	return ret;
 }
 
 static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,

---
base-commit: 232d49dd4b40a666283de9e722899f088ed581b2
change-id: 20261002-stmmac-hwtstamp-missing-lock-b6a7979c643c

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

