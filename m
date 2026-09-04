Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7F3FBEA5
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512686; cv=none; b=TVFf6+8hayGxa+6iUNDtEc2/7xPCZ5PY1Crd3Ahiy5jGEMQsxcCLDIYAf+3iAXhRsukoEbiI7DSmI373t9Rg0yL+Gsn73oNqAfZhEewMrT/+DSblmIANY35mBH3cllVjvH4fUrNJ6mBZg7nxpCrei92qBSMYsZal8w1U/A1jrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512686; c=relaxed/simple;
	bh=46yNrrqQ0p1nx/BzYAJFdzyMPSIbGlCMbf06pHCPZoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K/WfuBqnc/vbjSyJgR3wUgPP7oYVKRsd6PmDFmnBtoTdOux0BkD6c4fFfp0830oWxiFNJpiB3mW/+UPfuJoktbsv9VcBfGEJP3Fn2QGfB4p2t2euaEf5+i6aDDnOpM3ss33OYDnrpBIqfs9TLHQfeyJ44+EYnxcqIJeSjJk/Sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cS+d0mG/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juRY1IMg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cS+d0mG/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juRY1IMg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mlBn3234616
	for <netdev@vger.kernel.org>; Fri, 4 Sep 2026 09:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5UQCFI/el1nQf607Is8vrL
	Fj0vTVoBDdpenBgLQKMj4=; b=cS+d0mG/evrjo9csVsye1HokgJ8CfL2R0Jw/yS
	Jc7XoZeXuYg1mYJUH2Ki+44I2X6qhgonEcU1y+1nVvrlCrDaDg6+5d+D/VDv6QA0
	/oa3jVj6sGJwJSRqLWwAMQ4yyfcHkoBjt2YIfznQbXydtrSHstOxk6LSIKQNL2Na
	mbmiamT3cLQ+09jxYZh8c+K7h9OL4HZQ1Rl34+UBg3eGwZXZxD7Fs8CUMDhpE0D/
	fBnHROFRrDXiPyYGhZwR7c8PRBQjq2W7fLKvmiL9yqTOS3B9bngiGi1y/NjJBr2B
	R3pKIigFL267AojgcIYcEFKMxN6ldbQKewKBPSDmoubbDKJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r10cs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:04:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939694871aaso136707085a.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512683; x=1789117483; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5UQCFI/el1nQf607Is8vrLFj0vTVoBDdpenBgLQKMj4=;
        b=juRY1IMgVUC2KzQ4l+RyZEBN3XbqxvNPqPsK8eK/s+pGtpUoOMFRZipT3JKa0/RRlt
         /geF0emJ2rEM4RVu5GkPW8bM3N8gD66vWb/EGUe4Ko1sqEWKifSPSFCka9yKk/L2q9ro
         mrwnI/QCqxBLajMdlVcnfHCm7Dj9/2tSQAIXylvj3XK00Lx1ve5OT6qaGvCUXPjm6a9z
         WRIV/XDKEYembdcu1y0AY2Fz8iIuAo2Wa4rlgxGyES0GcoU9MrgkVYUo+NVfL/u9AJUP
         cnFtix4/6j9dc+/E/yUCVnNiCALRpdIs3kBH1lRx3coEGiZB+ynndF194qWtAzIUy50M
         1uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512683; x=1789117483;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5UQCFI/el1nQf607Is8vrLFj0vTVoBDdpenBgLQKMj4=;
        b=gefyQYkG1tPMhpNt9X42M54Kbu9x3uoTj9UbPLrHh5MvQSaBI0XtqpOVK+WKf0HWJC
         nalmvDjkuU0/S1dRtoT54eH71ugloTHQojRsrRrQ3xsbzEQ5Y1k1Pcbi5d5l6Ftv1Snc
         7Ns/hZoiU9Bxf2Z9KFFurUZaXp1wy1RXwiGh71tkeMmP8AwiYBWPH+iWgFXP/68gxfQf
         NS7wuUhsAs4kOlNN/TsaKbRFj2Q/DXx4IaxIX6XCxFV5ckzPP4Oe9nSb4XL9b9/hzE46
         31dBJVXtjldegxWKwQqmM4j6rIZhdY7Fp19+waSEG8N02+pjvhbPqOImRnfVcxImHzhG
         26ug==
X-Gm-Message-State: AFuF++l6TA7sfCxUxD5JspNDniPc/Sxzq59C4TA5JUXN4HBOBujtjQ2y
	jpGTUA40hCwkSAcW0akuEWTyoq0kAkxi2NmAuIS6qfrToRWwZX0AYy2k3jz9RyFt/qGlb82lvjr
	MjzyMi8R8jLuf024rRtBiuLpql0FF4sd7SkSofLzm8IrlemAA/Z/BhuOAFsY=
X-Gm-Gg: AYBFou2MiP9r8jPjMjw2oGlwnsYtNwCmMOXkHtYVknbvXmjQzwXA0PlaZiyFiFrHsmq
	zwHGG0yx9u7fNzGduNCIJ4h0ZMlNtcOZWzv5Hpet14+UB3oCsHOb0SWPZ5yGkAcxq0p3Cxu0VYq
	beiDGuovVpqDSEGZmwfj5AFYT7/TKZ7ZrcMLXfSFLfDyyDm6TcHAUSjGuhWTlZ9ocpnt6jZubg+
	HzBBmE1W2McTncNaWvwxkqO+ELio3Wm+3LpgiSpgWeVay2OACDGNFM1ozPeMv06rB5uXEnll3si
	NU2FnLyR2gI0cXVtRT+W7FxGAmqk4Vl6jXrPjziYDJEOBvP1yfRO6rWEybn61ce4gcgV1iAs7Qx
	k5Bxrk07dil8vVA==
X-Received: by 2002:a05:620a:8016:b0:930:a635:a782 with SMTP id af79cd13be357-939802f7476mr467452985a.11.1788512678193;
        Fri, 04 Sep 2026 02:04:38 -0700 (PDT)
X-Received: by 2002:a05:620a:8016:b0:930:a635:a782 with SMTP id af79cd13be357-939802f7476mr467448485a.11.1788512677671;
        Fri, 04 Sep 2026 02:04:37 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm3440555f8f.22.2026.09.04.02.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:04:36 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 11:04:07 +0200
Subject: [PATCH net] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-stmmac-ptp-error-propagate-v1-1-80f01b03dafa@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBAF0KvIrDsQQ7DYq5Qu0vhrZ2EyTEIRx
 Ls3uHybd1CFCSo9hoMMP6lScsd4Gyh9Y17BsnSTd35yswtc27bFxNqUYVaM1YrGNTbwlNwY7u+
 Q4GfqgRo+sl/5kzIavc7zD+4+E2dxAAAA
X-Change-ID: 20260904-stmmac-ptp-error-propagate-6c0147b4ce29
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfXzUt/AzduKoC1
 DkRw8dJ5Se2TxzsIOyWsRN6lDi/nd+uc+hEtj13M4sBuI9nuGNGyFwvbR21JT0Zs8UvuynJQpyk
 6CxZKCN9iUwXBDp72BDHbRpE80pKm+8=
X-Proofpoint-ORIG-GUID: a_P3585aMDMz_4edJDayQsQRKvl0fDVn
X-Proofpoint-GUID: a_P3585aMDMz_4edJDayQsQRKvl0fDVn
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9a89ab cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=kkejPvnTCPuT7LAjvx8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MiBTYWx0ZWRfX39+fgYPEUZ3x
 t/vyyRZdTa1FCSofpcYrmx3mL6BPSVK5s+vGGgaEEi8LBs2da8WygZgKgLsNYtIuiL6n+NvVSeN
 MrDGdPbIMdTr/ZunF+h0uBTZTSEYOF2VN8fFuUVw0UBToNoPNWIUCmvysBihldMcHe1iJAl1ytc
 yBeG9XRqqV3nIsNdQT64pTGVn5geMrUvZv+18d9PRpDafG4tcKh5N77E2v2I9eqd2cfZc/roBYw
 spEiRKQAs72CRQpBgZ7+Vmih7kJS4KI+orSLl35EV57Gyvk2IymJ6uQbnd2PHoPzRB3BXZopoZ9
 ucW2wBl185mnZxdA2uNzzmCUUALMlTI3Pu7odM0X4paDSo/3BSDtwEFQB+9oac+Ni5npam10/qV
 7fkcMf0WIeqzdgY2j0l4MIYGDukObjeyhMoiNs/0kRUV0l2o3KiUutZJZiHxfRVf6etMtfFL6B1
 NyMM3DI/Jz2zMfNPkqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040082

stmmac_setup_ptp() returns void and swallows both PTP setup errors:
the PTP reference clock enable and stmmac_init_timestamping()
failures are logged but never propagated. When they fail, the MAC
system time counter is left in its post-reset, non-running state,
while the driver keeps operating as if timestamping were up.
This matters for TAPRIO/EST qdisc offloading, which derives the EST
base time from the hardware timestamp counter: arming the gate list
against a non-advancing time base would leave the schedule permanently
stuck. Make stmmac_setup_ptp() return an error code.

Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Fixes: 0ad2be79f254 ("net: stmmac: Balance PTP reference clock enable/disable")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 66 ++++++++++++++++-------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24656b35350b..d33c82bd3ee4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -885,6 +885,11 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 	return 0;
 }
 
+static bool stmmac_check_timestamp_cap(struct stmmac_priv *priv)
+{
+	return priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp;
+}
+
 /**
  * stmmac_init_timestamping - initialise timestamping
  * @priv: driver private structure
@@ -900,11 +905,6 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 	if (priv->plat->ptp_clk_freq_config)
 		priv->plat->ptp_clk_freq_config(priv);
 
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
-		netdev_info(priv->dev, "PTP not supported by HW\n");
-		return -EOPNOTSUPP;
-	}
-
 	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
 					       PTP_TCR_TSCFUPDT);
 	if (ret) {
@@ -937,22 +937,39 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 	return 0;
 }
 
-static void stmmac_setup_ptp(struct stmmac_priv *priv)
+static int stmmac_setup_ptp(struct stmmac_priv *priv)
 {
 	int ret;
 
+	if (!stmmac_check_timestamp_cap(priv)) {
+		netdev_info(priv->dev, "PTP not supported by HW\n");
+		return 0;
+	}
+
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
 
-	if (stmmac_init_timestamping(priv) == 0)
-		stmmac_ptp_register(priv);
+	stmmac_ptp_register(priv);
+
+	return 0;
 }
 
 static void stmmac_release_ptp(struct stmmac_priv *priv)
 {
+	if (!stmmac_check_timestamp_cap(priv))
+		return;
+
 	stmmac_ptp_unregister(priv);
 	clk_disable_unprepare(priv->plat->clk_ptp_ref);
 }
@@ -4161,10 +4178,12 @@ static int __stmmac_open(struct net_device *dev,
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
 
@@ -4187,9 +4206,10 @@ static int __stmmac_open(struct net_device *dev,
 
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
 
@@ -8326,13 +8346,14 @@ int stmmac_resume(struct device *dev)
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
+	if (stmmac_check_timestamp_cap(priv)) {
+		ret = stmmac_init_timestamping(priv);
+		if (ret)
+			goto error_stop_dma;
+	}
 
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
@@ -8356,6 +8377,15 @@ int stmmac_resume(struct device *dev)
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
 

---
base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
change-id: 20260904-stmmac-ptp-error-propagate-6c0147b4ce29

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

