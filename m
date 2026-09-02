Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B63A9DB6
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380240; cv=none; b=C+O23ciIWDNupB5U2qA0hPB3AsybnENSoYQ2adAKqirNyXNDAI6Ixn+mxt50Voe+A+IkXtAzFtGOEwbtKep9ZHSgNwuB3C40LtsNcUwNfgtR/7i9OxhVjJVV8L29v/m0E41JW7rFxMbXVOAZOikWaQh8U30KVrS+mcoWoy4Y3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380240; c=relaxed/simple;
	bh=t4swezEkwjTju7eoo7IP5anUuA1EzokWFqk3jDjY8Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPGZShppomcaPxRbzxUqK88MVwPlzutEpfugnVYHE5QElhN4RQKmrZ1b36lm5+5Z3ammk9nhUino6TZBJQETT/cK6okMBrLKmL3rcbV555AfQypuUBRlhYzZ1w4EegUVVADFWx8w3OTeLCmUEtKVv35nSLnBZrpYFLTKN7Syjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tg1l795e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGJGRF65; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tg1l795e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGJGRF65"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHIkd2417953
	for <netdev@vger.kernel.org>; Wed, 2 Sep 2026 20:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NtMn0vuZ1S6fAeVGasp6DFeMidREg8EdpU12F4TnYNk=; b=Tg1l795eo2aALyo4
	SVpxxhv2JL+3yDCzn1mmt2lEk1/Y9nt22uT+/ZYeSdHrVNLeuk1Sn43N5pMWefk5
	htHIUi31zQtAuZ04Dlcjy55hmfA/8fWYFQCONOlEOjuwY/DAXtPypeht0d+kZheC
	ZdPHbqDYVr1LhyN4DRUZjrX6hT9FpgNedxuwmuKfgcvHrtE+ZAvks6nbU4DiT9I5
	wElkGAvxcpSCpO1HuvmuvyJiZgnOQUeAH3/c0F9BHDFC2cYEKiIVq4o7ZWfr3UIv
	iab0KClEsPtZc6E+7L0MNRACfFYqM50gHjwBzc3f4L9wlBM2iuiUV3f8W+1Xg/iP
	2eZYLw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdsem4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 20:17:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93494cce712so307227085a.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380238; x=1788985038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NtMn0vuZ1S6fAeVGasp6DFeMidREg8EdpU12F4TnYNk=;
        b=FGJGRF65vAcZz+A1IiGTCqbEZqsbf2FOpM8+mmfexKecP5RtDTy4ADAw1tqehxN8iY
         NIwDop0rytPwrkRLMlESSqFArQzl8viEqeyqRupFe1IAaUBgsjBQ7obKB+P4wyItkV5D
         zkeSraqs6W3coq6hdQVaLizx4YVmzHyZ+VRKqmo0raPrPyli20tvdnpo/+hX7BT/adeE
         tioUlYgxCR3TjdnVtG9Na0D9RgoYjOKgR23PPJgAngsfi/tBM9HGwejvgLThCbhcdN2O
         u4JRUkfYVWkCZcfBPMte410PLTHPCKIBBi1x5igJKVyz+6MUIn+TFcA7SjDUGCN5jnxh
         53nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380238; x=1788985038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtMn0vuZ1S6fAeVGasp6DFeMidREg8EdpU12F4TnYNk=;
        b=LqABSdgozldaXYgA9tjPJV0AZpYgX1fRFSIWUz4A9mQIc36DOr/4bZ+5FqETZ7NbNT
         302S7HYgL9WxtOjZmDIi0YGSVoSXL7luRv57b7LNwK2DUyPhqmSYfXCKA+x5EHUNLPVB
         eGYabaJWU/galYFC5jtGre8lrDxqeuF3YZTCuA2Cs7QZbRrEtODULxMl3n9FjhUiChbs
         Bsqu27KBsh0jsmxip5iW2S60wtjE+vk18O86Tpn0YQmbNQtQUeTFMgRtc0tjIoWjdzdj
         rS/bApjuM6qclCyhxqHTxIW254yurQrW6otbIkxqVItG+MCFKyeQZFa0jvyUHLsZX9d2
         IP5A==
X-Gm-Message-State: AFuF++kRCKJXvkqY00CQ24spdDtjPbvykCEuhx9SskDaVuY5tcjBazrI
	kVxxZ5JTIDzxe/+RzxDfGIGCoIiwx455PINr6pcBksRh4JDSjeVACRcU1ZNp22zcxu5OKTo59Tn
	IBnLRosTPdeLWumN6PUFXWQTgJhlLxUDFVVNQwRSRJY1YxAYyw7WRUXL3QTa7P7nYxAA=
X-Gm-Gg: AYBFou0I1Ox5W3cd2s2ERNFQ7OEXAUaTQkYUu73H2dGP6hKMBZ5D17UBwbxegJf7+1h
	GOba7BldDkGeE8wiA2XW1DerzuU7zUQneybHYFda8VuQ1dMrFCsWK1Vdhakw/Zg4DtNCJrVZ6BB
	ch7Ubo7EHuWU8ZbSvRYgFd+4PGxSdGEhNKtKfAXOU823RnR3vpcke/ZALwo/VIimswUxGiRmMRA
	54XurU63KAh5sOz9IcQNfsltGQimZDEfdgI3Illm2ommOBLZlqUKszLI8SRGfdaNdKhGqUtSYjQ
	OQNhbaIazYodDRVJjhVLJcqBOXxIsauUjHP6uMhrUSKIoNYgtsZDZhqNRSWAZxq//Qg26Zuo+6S
	Xh2b2m/lXzvbgfA==
X-Received: by 2002:a05:620a:a188:20b0:939:5421:3467 with SMTP id af79cd13be357-93960e1950emr743488485a.12.1788380237286;
        Wed, 02 Sep 2026 13:17:17 -0700 (PDT)
X-Received: by 2002:a05:620a:a188:20b0:939:5421:3467 with SMTP id af79cd13be357-93960e1950emr743483985a.12.1788380236802;
        Wed, 02 Sep 2026 13:17:16 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce592b018sm15234935e9.2.2026.09.02.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:15 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 02 Sep 2026 22:15:41 +0200
Subject: [PATCH net v3 1/4] net: stmmac: propagate PTP init failures in
 stmmac_setup_ptp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
In-Reply-To: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a98844e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=g2_bYGZ4nwCPDnqYkxMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: m4WmLKMAzl_BhGj4V6oh9rKBGW2v1GDZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXxzG/yssGQ7MY
 chlkC3RFFR7KFxaEfnn1AMcM25VRTPZk/eTiALpG4FldxyCBeN04NLhqNK5WvX2bg7tQJk2nAQY
 G0iBtI3JbsgrnmP56MqBFl7QQTWg4E5vQhXQ/j/6/gQo+ZYQ50XIcXU8WsOd0DtoaO+8aXvW4x9
 GwrLJSCbqyxUdan0Z0Q++lqsmEIggrXww49j0Rh2DYQbERMqw9F5mhxPJBADV7KjfOQ/J5TAaT1
 mgVH/Q+Y20yzahTtBrsM4fvZ/D1q0RxDxeKe0t9KGklJEA6T9y9SrsnkPmJIYa8iU5LMqhkUlBY
 jnjy2cb2lhMRHNq5o0BXCxwvnjx66I7H3DnGph58Raao9Ay7Pder0/VDCh4uWv6fm3hi3stjrOR
 a14DeDHmVpiIbomI35Bgv4DoIujhaSaHlpMQKOdrWjIbXtTuJ9zhJV2y52DvfHiq+AZ842oO90P
 JfhZowCG6RZQCFkKjFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX5pZm4LsZBSlQ
 1uwI8SkiGvzNXiMjPw3K5/EmWNRduGxqoFHFMLx2sgqOgonxOZoBvEps6+5jF3NsRZb7a8+FSoe
 dfjuen4J5Wz8TWWZr9LKW4Yxwda1908=
X-Proofpoint-ORIG-GUID: m4WmLKMAzl_BhGj4V6oh9rKBGW2v1GDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020179

stmmac_setup_ptp() returns void and swallows both PTP setup errors:
the PTP reference clock enable and stmmac_init_timestamping()
failures are logged but never propagated. When they fail, the MAC
system time counter is left in its post-reset, non-running state,
while the driver keeps operating as if timestamping were up.
This matters for the upcoming taprio offload re-apply, which derives
the EST base time from the hardware timestamp counter: arming the
gate list against a non-advancing time base would leave the schedule
permanently stuck. Make stmmac_setup_ptp() return an error code.

Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Fixes: 0ad2be79f254 ("net: stmmac: Balance PTP reference clock enable/disable")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 46 ++++++++++++++++-------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d576059c04df..47295845371a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -937,18 +937,27 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 	return 0;
 }
 
-static void stmmac_setup_ptp(struct stmmac_priv *priv)
+static int stmmac_setup_ptp(struct stmmac_priv *priv)
 {
 	int ret;
 
 	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
-	if (ret < 0)
+	if (ret < 0) {
 		netdev_warn(priv->dev,
 			    "failed to enable PTP reference clock: %pe\n",
 			    ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = stmmac_init_timestamping(priv);
+	if (ret) {
+		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		return ret;
+	}
+
+	stmmac_ptp_register(priv);
 
-	if (stmmac_init_timestamping(priv) == 0)
-		stmmac_ptp_register(priv);
+	return 0;
 }
 
 static void stmmac_release_ptp(struct stmmac_priv *priv)
@@ -4153,10 +4162,12 @@ static int __stmmac_open(struct net_device *dev,
 	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		goto init_error;
+		return ret;
 	}
 
-	stmmac_setup_ptp(priv);
+	ret = stmmac_setup_ptp(priv);
+	if (ret)
+		goto ptp_error;
 
 	stmmac_init_coalesce(priv);
 
@@ -4179,9 +4190,10 @@ static int __stmmac_open(struct net_device *dev,
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
-
 	stmmac_release_ptp(priv);
-init_error:
+ptp_error:
+	stmmac_stop_all_dma(priv);
+
 	return ret;
 }
 
@@ -8318,13 +8330,12 @@ int stmmac_resume(struct device *dev)
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		stmmac_legacy_serdes_power_down(priv);
-		mutex_unlock(&priv->lock);
-		rtnl_unlock();
-		return ret;
+		goto error_unlock;
 	}
 
-	stmmac_init_timestamping(priv);
+	ret = stmmac_init_timestamping(priv);
+	if (ret)
+		goto error_stop_dma;
 
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
@@ -8348,6 +8359,15 @@ int stmmac_resume(struct device *dev)
 	netif_device_attach(ndev);
 
 	return 0;
+
+error_stop_dma:
+	stmmac_stop_all_dma(priv);
+error_unlock:
+	stmmac_legacy_serdes_power_down(priv);
+	mutex_unlock(&priv->lock);
+	rtnl_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stmmac_resume);
 

-- 
2.55.0

