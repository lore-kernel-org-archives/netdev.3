Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288CF24B28
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593595; cv=none; b=VFaW4nBojRzZc7oiOioalWwJEWpp4wY3ekCm20iKg1ZZUIPibMa3ANd+pdkxt2aLGeXknVHdvmcvw+FDAQ5m6CRDATl8f93eIPkxR1AtTHoIaMWnlGVJewvwRTu5PN54DaHm1nvlhqjY7rjxnbzEhwadB4yOHyiDrGgW8u5MuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593595; c=relaxed/simple;
	bh=oNkVvo+ZL5dxLMpRXtXEwsCBWgd5+FJvCCRPlRI0SHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gdHLDFg0T+MCv92fEOi2ugEMrWXQhQzTnKHqnP2FVzVhSdJn6rOpfHJfoG8BndUESgpuILeib0DKMeiSzwZ288cKFqkDFkA++catTriKOTSPqappdWmXckf8RrInkvJsV6O5+wTdHXqRAH0V66MwFO1mnuC0PAMASIA5R2wEu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=opQMH1cw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QswU3QRj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="opQMH1cw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QswU3QRj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OH89uI3138165
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/YiyuDQDgrAZIpdgTwrDK4
	kXwmBpmKtp2/U0jYeeTno=; b=opQMH1cww9OVaof7Ohg2xNARlePSxjt6quxPOh
	EdnTByDoeyi0ov828H3NZBQvJqzDCg0xXP2nD+7IhC/v4pY5hJsvE7hbNizBAhw2
	k+9Q25FeTTeesK1j/4vK61vKYJ2dxbShSedzrYzknVgW7iMkTlGw2TV3sryb43TF
	shjvese12OxRXDxE3vAyRUtH9RxYfqBW3vIsFp98QxB0jmWxu6TPL/KU3Tj3c/vD
	3s1W/72dHlOtQbX5B/1leKhkP6qSDXfy28wiascjB7WzxFFeD/X13YFFU3CnosNO
	OXMXIstwkmJOTl+hPOF9b+/eyHEYym3c87EMr+/PF1g/DrIQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8t3dr526-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:46:32 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-75116a48926so3048786137.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787593592; x=1788198392; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/YiyuDQDgrAZIpdgTwrDK4kXwmBpmKtp2/U0jYeeTno=;
        b=QswU3QRjAxcRayP+Lt7j4fUKA7lm/gEqdvNZuKRJgY8AL7r1u5yz0pcobxE8cYIOT5
         hUqNiIFzp4RGYHq6yAwO/7tsB0cSLIzw5YAX1M0e1IwdOhJcHddSaHSjuTtFxBMvtm9q
         F0fsQzHJjUMIkccTFIh/GWE70gb7pIV5rvKeX+l6hnRAEHAaZJ4dM5wAJyYtkP2SnjN7
         qiZUrKO0pHB558ojtzBl9d6W6hJea7RCxszMWKeLShZ6bPMvPyyrhLV4j794PSBnb7Fc
         9go6Z039vgiQZoX15DXiMO/8F7QV0ODneItDHPdgrSpKdAH5ifplCIpz6JhHmKra2Naj
         lRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593592; x=1788198392;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/YiyuDQDgrAZIpdgTwrDK4kXwmBpmKtp2/U0jYeeTno=;
        b=TAppfdNEBpeKz3NoQ1qENYA/qgfICtwwrTyZSe2NtKxinTDsdqXAkEflwUVa507tIe
         J5GzqORVC11wNWzHOzfIvkBa6WNlrseMFr9j64375EVls9GupvsWnLo3fxfGu2jbMHM5
         5+bkODU6q/VOa7LtiMsL+NBxPOrhLoy4amjTkJQ2QaDpcgS8dO+d0w5Iuzs6y1zA7Pac
         /ipqbLoYlL+sh/6iyi0+7IDrckyLorNIeEePUBRT9CSm3+Q6xcU0K4XXozI1e/2rfxs2
         2ZDGcCsZqlH4NPPKMK2Ql/qXO5OR/TAhritYK0wz5GUEaq87ZOzrtcW6mf088TyiQOlB
         wKww==
X-Gm-Message-State: AFuF++m7kJcS1IzgYVaqmrHsy2kMtvgJTw+7PXDI8YBdI2y5dZ6iL7Ap
	gneU5rRX07f/Y5nmEHrCTAaI/FqgsAo55w8mP6DOjXgoU8M4OmKEP6KGaaEL1pnG9NA2KYn0igL
	eH5fMucoLLQUVY30rvVhnyvYstg98MF2gVzd0vCiv7IalYYGRLRKOtxAFXZ8=
X-Gm-Gg: AR+sD12VRgPuEvK+Lw2Pv3zpBSp4opU+0W2RuAZOb9ONJ0QVvIhqudYO0jmUQkYIITX
	LKpUCx9YCqcxWmfKDRcXqj1v4/EOPBnFWkSA4RiaeTyOwVCbL3jsoKfIQb1QSW64vs5xMBaNiOc
	5adkQeTN6XU3Wdguu6Nc0s5WT87IL2OTE163Rg9OL+ct1SdyVcHswHHDiQS3pnDpCtOy/cvVXif
	pOdO0ovKbUiw8Z1hd7HgtT2yoAd29u6E1AQncSBFmb6qpNLrOE1CZsGGjbRnyx0rwISrhjQ1rGJ
	E112RkGrFDrciuMbGNAQ/ZX7wx1Pi6QE7mq4j886VWvGesLNyWiKHRGz91pPbPMNI64xSrC0HvG
	Rn6P+Tfvi6W+EX34=
X-Received: by 2002:a05:6102:3ece:b0:772:dae3:d4d5 with SMTP id ada2fe7eead31-77a622293d5mr11922415137.1.1787593592230;
        Mon, 24 Aug 2026 10:46:32 -0700 (PDT)
X-Received: by 2002:a05:6102:3ece:b0:772:dae3:d4d5 with SMTP id ada2fe7eead31-77a622293d5mr11922345137.1.1787593591096;
        Mon, 24 Aug 2026 10:46:31 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e001305sm10346144a12.4.2026.08.24.10.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:46:29 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 19:46:07 +0200
Subject: [PATCH net] net: stmmac: hold runtime PM reference in setup_tc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-stmmac-setup-tc-enable-pm-v1-1-45172d241a4b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ6CMBBG4auQWTsJVATxKsbFWH51ElubTiUkh
 LvbuPwW721kyAqjS7NRxqKmn1jRHRryL4lPsM7V5Fo3tGfXs5UQxLOhfBMXz4hyf4NT4K6fRE7
 DcR6nkWqfMh66/t9Xiih02/cf8hEh1nAAAAA=
X-Change-ID: 20260824-stmmac-setup-tc-enable-pm-149aa563d797
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 8pZof8V9CXUVnJvlFq09cgj6Yk153eXh
X-Authority-Analysis: v=2.4 cv=OLAXGyaB c=1 sm=1 tr=0 ts=6a8c8378 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=O7mAVgsXz2YliqE_5DUA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 8pZof8V9CXUVnJvlFq09cgj6Yk153eXh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE1MCBTYWx0ZWRfX4QSgZE5sQNj0
 8f2nCRwPckBJG0X8JyOP8zYTFgb5muET4zwwntNZOFouy1LGj+3ed7dBdm46/B9z9G9zi+xABiD
 nVjm6Pi/wXJ49mDFGDiD73WI2VLALmg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE1MCBTYWx0ZWRfX56XGw1D6Ebm1
 v9lmVMA5/Eb7WFPXP6d/TNhMijy1D6wmZ1mIuSG7RGcLhKYehREwCCzPVLkJSJNt2d7/+zIVZnJ
 /0xROm3hVQnpT7ZD1PsPnBPKgY3DJwxoUMyCYFio4iZED2vksBomgT+PukzVqlUvPHgulU0qMaX
 EAyFcj9xPLptZIRpVk8P5s6SOvmOIvTcwb6pm7fkUCezeVwRnBsP6BmwjVNUyrGe79B93zmx1iT
 +BcDlsTz66uDs3R9OuEbprK358yakaGC5yKH24qe298EpUe5GK9Vo2okyM+oDJHUh6cuCeOIqBs
 bwNEqHK7ldLMbyWP9PgiNaLEbhtDB7JZP/DyO9UISVNdngRyfopcJ0JnCR+7V+Um1+KGH3YW3WK
 njBBDyhMVW51SNSw7YadeJBs94oNiL7slAwMJcXr7HuWn29ZoAUU87HqJA6Ye2LI0Xk1/qewtAy
 sVHxGHNIS/i17fF5MCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240150

The qdisc offload callbacks invoked by stmmac_setup_tc() program
MTL/MAC registers, but they can be reached while the interface is down,
when stmmac_release() has dropped the runtime PM usage counter and the
device may be suspended with its clocks gated. Accessing the registers
in that state can trigger a bus error.

Hold a runtime PM reference while configuring the register-touching
qdisc offloads (mqprio, cbs and taprio) so the device is active, and its
clocks enabled, whenever the MTL/MAC registers are programmed.

The TC block callback stmmac_setup_tc_block_cb() programs the MTL/MAC
registers as well, but it runs asynchronously from stmmac_setup_tc(),
outside the runtime PM reference held there. Hold a runtime PM reference
for the whole stmmac_setup_tc_block_cb() call as well, covering the
cls_u32/cls_flower setup and the queue enable/disable accesses.

No reference is held for the TC_SETUP_BLOCK bookkeeping itself, the
TC_QUERY_CAPS query or the tc-etf path, since none of them touch the
registers synchronously. In particular the block bind/unbind must reach
flow_block_cb_setup_simple() even when the device is suspended, so the
driver never leaves a stale flow_block_cb on its block list.

Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
Fixes: 4dbbe8dde848 ("net: stmmac: Add support for U32 TC filter using Flexible RX Parser")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 34 ++++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..4baf40fb01dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6392,9 +6392,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				    void *cb_priv)
 {
 	struct stmmac_priv *priv = cb_priv;
-	int ret = -EOPNOTSUPP;
+	int ret;
 
 	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
+		return -EOPNOTSUPP;
+
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
 		return ret;
 
 	__stmmac_disable_all_queues(priv);
@@ -6411,6 +6415,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 	}
 
 	stmmac_enable_all_queues(priv);
+	pm_runtime_put(priv->device);
+
 	return ret;
 }
 
@@ -6420,26 +6426,46 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret;
 
 	switch (type) {
 	case TC_QUERY_CAPS:
 		return stmmac_tc_query_caps(priv, priv, type_data);
 	case TC_SETUP_QDISC_MQPRIO:
-		return stmmac_tc_setup_mqprio(priv, priv, type_data);
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+
+		ret = stmmac_tc_setup_mqprio(priv, priv, type_data);
+		break;
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &stmmac_block_cb_list,
 						  stmmac_setup_tc_block_cb,
 						  priv, priv, true);
 	case TC_SETUP_QDISC_CBS:
-		return stmmac_tc_setup_cbs(priv, priv, type_data);
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+
+		ret = stmmac_tc_setup_cbs(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_TAPRIO:
-		return stmmac_tc_setup_taprio(priv, priv, type_data);
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+
+		ret = stmmac_tc_setup_taprio(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_ETF:
 		return stmmac_tc_setup_etf(priv, priv, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
+
+	pm_runtime_put(priv->device);
+
+	return ret;
 }
 
 static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,

---
base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
change-id: 20260824-stmmac-setup-tc-enable-pm-149aa563d797

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

