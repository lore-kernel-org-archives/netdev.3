Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033782;
	b=X5HWUJ1wV63w8bn/d5N7micjYOeM8GlHqAOJ6QxCdCZKjebVQ7BJHzYiKF1GnPOQPrBA
	 xwCJtP3S/jv7KgveaQ6XCQ4Z1auZwyyPEZiuIC141/UxaBmEtailPzpM3/H5atb1XKrBy
	 O2vcFvMYhD//9wEmUJHf1C7WrQz1CKj5U0RBJl9EGaEC2CeWedp7vfnu/kCQHb0Asgj4m
	 WB0vAtWBIoakse5kdTPSm1b9VuuWj7ji7+BBHxSRG617bEPZX9/BQkLPD282xjdNHbZCI
	 dX7CkJk5rcUdAX6/zQy9yENmVbqdHhsMs8PiBokLwulydPPX76hWQvLeomuzOAuRDbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033782;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=F7HsIGgAX4kJ2vdSLJyB0ReVskjk1f4s2+YTG04Qsws=;
	b=m4it6w6Mdq2VJTMRt/ZuI2xUUoYRPQuLycjlzWIDv5MbAcPq74253DqKyikpCX9Kz7xf
	 FrA7j036Amj9FMV8OZqAMEH50PwMSpB32teTDwLfcIf1OBRI5EKXCeOygQTc3HcwDScjF
	 qOkrPcd8ucfh0BZhr+AhXPD44HHOKiLO/hGmSQvxi2Rt8q6ElROWMAsn9zsFUgIbc06wy
	 +ZK5FBu0n6DJ1fd73CTAJXdOO0SrwLlIHz1HYh6QxfjkoS9c+jJBD5v1ct8DIsZW9yaew
	 FSFrTu9Lw3Y/UfpEk/AKsxzSZTSgZpBgkCrFStPWMVPaBmRcmyniXTZF9AvDJRkLvSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y7PdC8nF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GmzxOt09;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A465606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A465606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y7PdC8nF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GmzxOt09
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEwRxg2082464
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F7HsIGgAX4kJ2vdSLJyB0ReVskjk1f4s2+YTG04Qsws=; b=Y7PdC8nFYb84EkT8
	53Jiip9p9MA4fsuiX6aA5hG2XK5Rf7ZO4wcX+oMtG1DKKKPXKkCV5Ea0zxH5Ayq2
	7Q568PHjxn0ElgtDNLmIVaseMOHzcNqEnGtCR0PGocGUUEUsELZGqv9wpMmtZuHc
	pMaVB9FYVe7hjheSTNPS2fSrMZ5L3R627798gyzLM3VdbIP52SBb4WPyOHLOZZGi
	QRVfehpBV5ZZrblHjoaw3/VEjfhtqh32J934pbRS3V8tRxcjdXX8BwANJNvJ8VaD
	QSxcs5Y1s5nEcCjwDuNEmurVQQevDmte5Eklk5Ir8X6ETSRPiIpTseesofStoVkL
	1Fn1gg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsuf9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f3969a2a7so578561185a.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793033780; x=1793638580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7HsIGgAX4kJ2vdSLJyB0ReVskjk1f4s2+YTG04Qsws=;
        b=GmzxOt09TNDli66ndOltfH2bu6sfQM1xEegyWqWqRmjwVk/wrhc/S1953sOZ70do6E
         G8qc9MHbd1auEb0OqA9GjkdFQbpZzkXu3hJe76pnU1/K3w1SMrGSQ0BTE7lPap+wMmaR
         v/WJUV9Byi10S4Oltwct7ECCwfonAqZ9/rhHkhNsIqEUUF5/zsiIFGn/GvXQMAV0Yy40
         jQiIuVTIJsU7Yx2DOiY9qPmDYTVsTl3rE6UlzqVcPhpEL9M2QTtHvtKzhhhvrtDOgAkt
         3a6nvf9rGf5gAvwEG6Idiv0LBY5s3kK15pmvcjyCD/Asa8t2eZw4caRs92oMcnDAKT9o
         RNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033780; x=1793638580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7HsIGgAX4kJ2vdSLJyB0ReVskjk1f4s2+YTG04Qsws=;
        b=TLVodYYR18xWd2dtYZtX9l7XzoNRGSf/8/jwsSLjUctOH47yBsqa+0lIOhv1E3AYAm
         9IzU27xzo98mMwalMvv3VL/XOU4ucLahFePc+e0LqM2i29CFi29q+qfBCmIHYUsb0R25
         yLnNcTUE97TT5KMUw5mITg20qjbhNuvf6eD0/ivFYLvhvkK2UDWh3GhPYpU1lVIQpJkO
         0w5Mq+SlpEjLB27uVLCfIlyq+FABjzxNVl2UFfm9eqfa4SApQfRGRJtcfm5xI1e6XLvQ
         zdntX1IeVNl47f3Emevxs7OcwjeyssSgpoBGx/m7kQ83twhbXCBD0u7cSfCbd8uU4vR7
         Kd5A==
X-Gm-Message-State: AFq9FYI0tDIiw4vC0g7PS1i7sVwLifaMfDwJt9aWBXtP99f1QmsESF5S
	CeilcFvFaLPr8deIHvOi+M5betFJwWL2yQjpGRN691C/XGMM3fuf5rRhSjwd3xGAkSXdNP7rPuF
	D5OFP+wKp1lJKHJH+o4GorXzLasNsTrRG4YpeYCFR55lHIaVRKvIt/IQ8zxY=
X-Gm-Gg: AYBFou2bvMUgPgdYi33UcPNKF0bZudtoHmXjVk0nej0W/Xk+5h6b3BsdlqSgJtiTp7G
	M7xAlto5ZHpCYNbS8TvhdFHxeRk5BQhYSgXN+Dtt+Knl3ooX5omKdmnFtkXLNkILRTfyzpk544O
	T6LcITBcDbsYsKdSd7QMoV1ic5Txn+bZlcinJj1Gm9qAPTjvzw0EiCXn1gBxqpjaDA1RHDDx6s2
	ZboJjLMZZ/g5WQ4h8N3wgy64CWIQpxP7CmGEq3jgg0IEduQJb3q9rlZHpueVmB9KrjflE3OqtOZ
	W9wCBXMpAUt/H5yOp3csWv1gUD0MzfeLX7fzJRzKa3srDvnInlWtNugA8n8BXf4TiS+8tvHoTcV
	DCyveGmBRWjpmoQtUGdXt/j17TJ2EoFt2UyhvNs9BFhiyo22yQxYFAkScZR2N5I140NZUXD/DUD
	yGR6AJfq582RDSlsZ9VxKJjw==
X-Received: by 2002:a05:620a:2b4a:b0:93e:3824:4123 with SMTP id af79cd13be357-940ef9a6b9cmr1108920685a.65.1793033780210;
        Mon, 26 Oct 2026 09:56:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4a:b0:93e:3824:4123 with SMTP id af79cd13be357-940ef9a6b9cmr1108914085a.65.1793033779685;
        Mon, 26 Oct 2026 09:56:19 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a56992dsm195870245e9.6.2026.10.26.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:56:18 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 17:55:56 +0100
Subject: [PATCH net v4 1/3] net: stmmac: initialize est_lock at probe time
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
Message-Id: <20261026-stmmac-est-fixes-v4-1-999dac4de44f@oss.qualcomm.com>
References: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
In-Reply-To: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX+26j+Vv4a3/2
 u6BLCNKfuArS2xjlqRYtrPwZDwXimXYmh91r8EwvAzFZZWePi1LUECpkjGnbORfb+hOIjzS5Wz5
 gIWbXVXnlAbScimp6cnHbhkhf/PFGn8=
X-Proofpoint-GUID: klcidFkaHy6K7zZU5u7Auf4pULQX5o6o
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf8635 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=122XcF769uAcj9t3WpgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: klcidFkaHy6K7zZU5u7Auf4pULQX5o6o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX/0x1wf96hF0y
 mDgrYwD6qZ+6y6gWtwN5tUXr3W6NRMoN73uNFwPAPDnZ3o6dC6xq8UJRDIIjMCIxA/KUkU/AkbC
 pgTa7vvl/v8yn4WNjp+YopxogxfimR1nOMAbmBMxHz/pnDjWxPt5LdnxGs08RfESi66SQ3Aixmx
 51ae3DISubDBR8BQV039+L5OJIKds+MB7olN5c9BoD65oXC4H/Zl1gs48Qbl8dL0HNLhAgu3BWu
 tNTKlGed7fAGbcVmIuiaeMIHtLNHqbyLuWXLsuma+gjgAMbgELeSPGMmkHmIqgZ0Ifad6jQwquX
 TMWUc7DY44XUJeNSpVHUvgejHZwyPnY/r3abOiMKPmryHBzN0+1gqWA7sf3fdbw2yEhAKcGXN5q
 741eFyuA2WhHGs8dAyNZpcYaqbIxi1v7sGIlX8WGP4DEJX8xm1qg+1QGPCB6cHW9g4L2IqmcZhq
 FP8YWrLUgTTw5kyh+OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260067

priv->est is allocated with devm_kzalloc() on the first TAPRIO REPLACE
and priv->est_lock is initialized in the same place, which ties the
validity of the lock to whether TAPRIO has ever been configured. The
lock is also never destroyed.

Initialize priv->est_lock in __stmmac_dvr_probe() next to priv->lock
and destroy it in stmmac_dvr_remove(). This keeps the lock valid for
the entire lifetime of the device, independent of the TAPRIO state,
and removes the lazy initialization from the TAPRIO configuration
path.

No functional change intended.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b20e5038eead..9e09e11cc35e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8204,6 +8204,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->est_lock);
 	rwlock_init(&priv->ptp_lock);
 
 	stmmac_fpe_init(priv);
@@ -8337,6 +8338,7 @@ void stmmac_dvr_remove(struct device *dev)
 
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
+	mutex_destroy(&priv->est_lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
 	pm_runtime_disable(dev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index e137fb9012d4..aea235a69105 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1028,8 +1028,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 					 GFP_KERNEL);
 		if (!priv->est)
 			return -ENOMEM;
-
-		mutex_init(&priv->est_lock);
 	} else {
 		mutex_lock(&priv->est_lock);
 		memset(priv->est, 0, sizeof(*priv->est));

-- 
2.56.0

