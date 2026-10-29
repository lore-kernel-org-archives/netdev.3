Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270059;
	b=XfSWal71+YRVmLv/DQxi4QtZ63jUQx1A7ktJ/uOrpw0QuFvh8zdHFHQHlBNbD5apkoI9
	 dDssDxRWgbEzXiyw3IcCUQONBn0OazG+Q6LozpA3ylfh1OgRbWaYNimMK0hdn4UfldTpt
	 nF5tl3UySNWpCDIa31IYp8pWPwHq3ZjurpXxxRITI3np6jhr6CjVg+RtKwuvOwqyGrlVv
	 4a893nFwX7hWQ3bMDunZ1bwqTj2iz/GHwtbNDhMEMG4ojo/3nEz+0UMDgjMGRBsrtQxDz
	 uGAWBe7ImjnAeb4lKfTdM6Z2xIPVQHnFUW3gopb51KpNrq5llYfz7UdasydyTD9ecrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270059;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6ZgcBYpVxbMnsK6nHBTY3WX9f6ciMQ447QxCKtwKiOo=;
	b=BMIO3LoUYwpE3sfBMHmjSzLQowSz6o+pFb5ONqejc5FLvK5dHtoOXLPBmtdi7Hpk3p7P
	 9VTqaFq0q8BHxD1pso6jw6Q5zzdU/Il2+7JlSnmgA/AbSkh473VQheIvVop9ckjYFQYze
	 dm5FYBML2PUhepYzzNA8oKM9/jMr+mQ0A+JbqkTVZyaYO0EwKY8T/DoldKQKDkiIAQlmR
	 nnum9rL2qrT36GBBIlfJLMdgjoHl+T+VkrlPU+5OEJ1laX19jXGB0yHKqBBwJB7luso92
	 QpgLdXe35IbRB6uyzPAC0mrvGEtFWAMyQsUavSb0nqdulPSYDTgQp9wN3aqAbJWC8iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9R9JZ2z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BAI+aVsQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CA606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F36CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9R9JZ2z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BAI+aVsQ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vD992912456
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ZgcBYpVxbMnsK6nHBTY3WX9f6ciMQ447QxCKtwKiOo=; b=O9R9JZ2z8+NfTTo3
	u6o0ybGnyy3CXUIWcZ7CCm9tvr5hGfB6qsjURK0qObJWJzlngf5KJe4F/AFmWBZ5
	Ec6DAhL+2TpQXq6y+4uJbr4Wm8OxRce3sk3kbgIO5gZVCWlXbFmq9bh7KssPnWsr
	DBQq6ZZTiIXByumDSGddIZ8VtT6a6mMtQEMjNGis3nMrEIvM+iTXX3LGiF8vb6bp
	E+83kg/WB+o9lTPSiEgDJqRQp+S+S8IimXkDesE+TjzAJsuwGdad296VyK33lMDI
	kDfP2rVoHJQMtRCNXqeN2rpzGhQ5kGuzzM5BXzNI+kf5h4Nj1Q3OIkNlRFjOo8xL
	6XdXrA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2bhru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93c5ab5c136so300804285a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793270057; x=1793874857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZgcBYpVxbMnsK6nHBTY3WX9f6ciMQ447QxCKtwKiOo=;
        b=BAI+aVsQWZNDgxBxUXCF538NOO6usLg21JkcDVzE9+AfYGEoCA9Ucjf+N7xQ26Ixs6
         NrSRkXj2L5efIiqZnui4HekkLpuakNi5eHz8XLd16xUtW9sp2xWRXdUnpp52BSJWOTYn
         HVltcJFahztGFvlAS2k6+Mnh0kog04dvhmlIXgdOosk8Tmq4ojFlX+YqIAE+7fQXc+En
         tiGJ0JukqPSLencgIQFLlHU1xdmMsmq4A9eOPFGQLDeK6+sfyJKTUhNSI4MEIgYilwUP
         oV904iXH4KN+Aqi6WoTIsqvYKQg/qU419QN9r7pX8lB/4S2t2fSyGy/isBdykKePj0QD
         b/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270057; x=1793874857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZgcBYpVxbMnsK6nHBTY3WX9f6ciMQ447QxCKtwKiOo=;
        b=znyc17Kf8RMs/lxYa4fzn2FouOU+LekYx5KfkijWRV6YhmxXjvusI/3u6yWxTcKJJy
         itLeLqlxLCuckBcUuuRcpqJNNo4HBkTaOwIjO/en7/rvHb2sycPJByJVhcQuJf/3rJlH
         d7mLpUWp6djJ2AFUi8cyGBMMuwtt3XPiEm0dT6501S99qnFV9rcLqAcYtXS60bJHUEWh
         WDVU5bVQhk1Miv+ffS6gs2LCfyK6okyQRlHuM1RAq/z+apq4RD6rstEgoJzw6QhBlZdn
         XxtQgrl6hFogwgBHx6SgZR3TI9lVLlcRhLVzEqR0wVUk1tc5B2aeq6pBi1mas2FywFiZ
         j+aA==
X-Gm-Message-State: AFq9FYLUMpkjEVp9mcUh+zqIZic/SVmMxi1RHKL/ob0r6ujNwfxtU9X8
	ysPb3qGwlhCXUBtNQ5sZuLEq/kvGRU+HhZx0/op0XyR+7ROUszalbYpMJ4MuyryX6X0Jv9TfBky
	Bc91KEYk1WturjCwRA2mOJKjr1ZsaU4YrirwaTyCS35xVIoO0mehiJ8G2Kk4=
X-Gm-Gg: AYBFou1dIppexeJjmDyaYaeSblFFHp/fCYlav1+Dkraf6KGmWOdjI/7XDH7C+/sli0Y
	VjmYscTPENPPj3GaKHH4cqkeWovQrntcihB0uEhMSbDCkgADzMVC/XifdggJ9ckYK0Nw/K3og5L
	DyWSkiU8oPZshNKhLvXGUxcyNX8OFN6HNpRLdxh3VNIZZgyFFzMTqrB6bzLDadh70F04r7KwIt2
	ka4qZLcZwI8GcZFPUlk3FYwm2IlqsbVYZutXzJIYHUF+Ri9pdWeDD8ndDsIvuDgFJ9AubaQUPSo
	6q2MccAHgMaQ1hAOmqVv8Nc+2HxNl6msJdmXx9/pbBdNwB3ArasHzWJVMDn1mf7y1x4FbkCrx9o
	HR0KD+UOsqNFFZ0Lflp6kTQufs1v/6D1YGbITUlWQyKtj/oRjVvjcdu3guVRnPFWZPyDHS0w6ES
	5Im3HbpygvCgT8+VkNSFGRsA==
X-Received: by 2002:a05:620a:a40c:20b0:944:941:c060 with SMTP id af79cd13be357-9440941c610mr516891985a.15.1793270057124;
        Thu, 29 Oct 2026 03:34:17 -0700 (PDT)
X-Received: by 2002:a05:620a:a40c:20b0:944:941:c060 with SMTP id af79cd13be357-9440941c610mr516889085a.15.1793270056548;
        Thu, 29 Oct 2026 03:34:16 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm19352255e9.15.2026.10.29.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:34:14 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:33:55 +0100
Subject: [PATCH net v5 1/3] net: stmmac: initialize est_lock at probe time
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
Message-Id: <20261029-stmmac-est-fixes-v5-1-85b830a795a9@oss.qualcomm.com>
References: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
In-Reply-To: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae3212a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=122XcF769uAcj9t3WpgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 7z32M0f9c3GPhCVdXBoLUw5YbalsJHU_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX5HdAyo6u5Oji
 bRNRL+MtVqJ/Vy2x3FtY0x8RXGTSghdaL8i7MpMGx5Al5fTEihDoJXazOS0q5pYom9bEoHLla8/
 4tsEymIKotf+DfTT61JlvlqdVpbUiNc=
X-Proofpoint-GUID: 7z32M0f9c3GPhCVdXBoLUw5YbalsJHU_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX5LpZCQz9nCzH
 NMQ6BHoVNBKnMd6uYXbkdBIcSFHeUFOX4MH3ySkD76NMQuF8G23WDoMbGkakAp7u8XXZAhDkU4Y
 EDrEPIrazGPjm1owsFzElzNqZEQm6YWQDtBe84Eqj2F6hAh2EjXH3VlZ2orQeofY23vO81p4TSv
 UtoxBCBNX/umdWQCEIBAMLKOy3c2Zs+zIa46zSQy5AAy5W5z3PwA2jQgIEzdlv5T4DqPp2d4uES
 qz+D5jbsLvyiY+UM8JW0duPM+mpWBFEAHyKXn9KMDnW6Qz9yZQWBL7CeIYkIoTiED37orL4b7aw
 bcXKEX/TgH7wkjmSxTyNNtMKV0eJhGpojeZnYKAaUYXYc8s1Eawe4G7DnLaIDZxM1mWB/2+d2EN
 2yM6mEM/Gp8d5nErUr33r7aHTNg+qgZjzsvPHlGXMpoLpv6bV2bJLqile1xhXpFVAUEHMJKTvxm
 n9pZusSNca8ADmR+pqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290040

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

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9ded31150fbe..2163e79fea9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8213,6 +8213,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->est_lock);
 	rwlock_init(&priv->ptp_lock);
 
 	stmmac_fpe_init(priv);
@@ -8346,6 +8347,7 @@ void stmmac_dvr_remove(struct device *dev)
 
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

