Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A64D2EDF
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839671; cv=none; b=Asp6r4iFaE0FOTGi17i+0HKNBiPf+eK5jrIPK2MVny2MRCPlPKvQ6liWpNMHBts+gwoCooVh8L+C518ufx1l3iWtrDCdkkGDspT8LBSfJIMCi0juo2wPrIXF3QBrnGWHnh6TbqQY14RX4BUK/sUFlaIB2gkD1niv6RWTGS9vhLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839671; c=relaxed/simple;
	bh=hS26aWzEWMadyMG7bACrE3TWTgvclJJKZSiepySjTmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NNpkRlWbeCNjHzMDnwknzMdvORDDDF8jExpPmFopKejKoAJ/MvilnuuKvLTXMAb1Hb/trbDPPn3C6+TtQNLX5dSBNIkzq7dm/P2OWVmXkYSse37xB/9RXCJoU7mIBW+8VVtowPF2qhW8+wwB5e43mJvE6uHloREKKdcd9epRm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJ4edZc/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RWfb88U0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJ4edZc/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RWfb88U0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJMs3s2211067
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ErFr+tQW2NzUZN/muqWAyk
	nar+olI/llznWFgISvSBE=; b=cJ4edZc/Fi06mbdf/WbGGhh3RzqU0Ljyu4H5zu
	1LtYqGJHY/OGuW+xeDgtzKzlpXMFP8kSgeA8GZ/PmaIuKu3B1fs+T9Px7FQ5QjFH
	yI7C5kpT9Ssr1tC2yNtzi76MloPJMBUmQh8RPuGiZwUvSDNeXCmfHm00tbMB2nP6
	wskQnkFTKQ1/P5naOPEj5J905SrIJUfcyGd3mis+cPHudpkGdGehtSD4AGeKtQuR
	gcSey1FFaq8Rfgyy5ZHT2A76VCAwgHhr6v5lGPKI+CZvH4titlg/QDob5ZzxEsJL
	LU4S9WF/9Z/bBzct3M1FLxvMpnmrdUnm7/Cs6U1bK7B/JwDQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aes1sb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:14:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ca9b53afaso641042785a.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791839669; x=1792444469; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ErFr+tQW2NzUZN/muqWAyknar+olI/llznWFgISvSBE=;
        b=RWfb88U02klyPZTLZU+BRt/JF67DOaLMkNTEzJSvpxEClFRuQbTmWYet0zDoo4YSX2
         0u+VwQvR3kD0DnqaQKWBapwqB45oSEY3VMnjgCDXdsCjne0jEzX7AlgTR1Xlh+gEQSua
         +V8KP/J0+DCZG44LZCNpkh0kzE5XlyryS/Qse/MqCoY0QbtjYSuACFraM3Z7I4inmGWV
         FIIBkYmvuBtGEWyG7xL8z3Wz8ZPR2nQO+2j8bT5NTQqP7RJbM8+luAbvOtGPnG9JnAzM
         5wYFGjPFDI4sOkMUEVqie2ljHmu7oOF3kC1b3so2oX1jBj7YzA6xJiTqO674xE4Y+sP3
         kefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839669; x=1792444469;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ErFr+tQW2NzUZN/muqWAyknar+olI/llznWFgISvSBE=;
        b=cwVw3CF4BijgNMl7fRMi+mlnLmjUN7Xb3jiTqPAk531XPF4hWjLuDpF3+OjiMztGiW
         uL3WCQbTSmsr4ryuVP4SN/qSOsaqc6gPnMPEJOusmjeNPBqbs/jz4KN/fipT5DDpG81h
         VJJtdijohHZ1f+UpNikesUHuQU5DtTFiGmP50ZfewfFX0M5pDIHc6EVfP35t8Nq4y11n
         YRPRLTJRolQ8engdeRXAqQV5H4YogNtcyzADuUmKfokL5n2VsxWp2INo3qagtk1KCh1m
         yZCARhq7hNc3Xg7LFE+GhZRgPzaxgJNHLUHUcEKPY0egPNf5EgmRE50GYcWXFVweaYgG
         slUA==
X-Gm-Message-State: AFq9FYKt4OxspQvki1IRYWuvKFgpQt260Zq+ojmjV9ifdTeDQCqH/0N/
	LqOA6aSqz1feRMb/QoEgawQokvyL5BA/Tj6pISEaWwCuQpxgNjDLpBjnj5SHobXHQSZGjuy42nd
	bX5264u6e8H7wYB7HsLKHkWGj8m3ur+w6yJtm7WSz1QUdkdQx7Zg58xOqoZM=
X-Gm-Gg: AYBFou1wj1XthhTqg9AH/aQ1CK4dtkukVwAmNeZ2yoQGzA+OTHLBRgOS/9t+yir/HZK
	5H7MbY+V63pIJOrrxrBqc3hgq1Bs5eYEIMLhHUqq1F1rO6+f5PTmgKVu6gP+lZCmfgqZWJ3k2Jl
	L15+uyT9idlRLKWdnivZubqkq7Nq2UklBFC7IXNx+MvLADkI43X0TC9CRnTO9qEVZgKBDxY0+h3
	//vgctAbJhGW5I603ZZ+pvnaSM9UM+hhnJbKTKX6MiabE5ohVwwfTLd5aU00soZM/VwapZlKVnY
	mros+yxF0XDJgO0r2GIqoICcChZRTrkie+8Y4r8u9sLFPt3/F+Z6Ucmjk2x7a2vHkV4+Zd9GxRC
	Qb1S2Wl9T8cYPmA==
X-Received: by 2002:a05:620a:444a:b0:93e:c12c:f13d with SMTP id af79cd13be357-93ec12d05e2mr1648440785a.71.1791839668577;
        Mon, 12 Oct 2026 14:14:28 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:93e:c12c:f13d with SMTP id af79cd13be357-93ec12d05e2mr1648437285a.71.1791839668048;
        Mon, 12 Oct 2026 14:14:28 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18f3b43efsm366484935e9.1.2026.10.12.14.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:14:26 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:14:06 +0200
Subject: [PATCH net-next] net: stmmac: fix mqprio and cbs combination
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDQAxA0atI1g2YKC16ldKFprHNYmbsZBBBv
 LtDl2/x/wGu2dRhbA7IuplbihV0a0C+U/wo2rsauOU7tcToJYRJMPzWbAlldpQU5oRdTwvxox9
 EGWq9Zl1s/5+fELVg1L3A6zwvSwLX6XMAAAA=
X-Change-ID: 20261012-stmmac-mqprio-cbs-combo-341f12749ce2
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Thompson <daniel@riscstar.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: qMSen8P4F21-i7qDDNqhVxSivQLQYLsn
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6acd4db5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=RGP7YYwxf8wD1rvbjroA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4NCBTYWx0ZWRfXxXhFmv+brNLR
 rLFVoePw5CcbeQeZ9KDYy8P6j/tGAE9dKmWX53Gkidgf6vAc/zc4CfLkXzrfDKSZXluTkBhmW3r
 WhKgcLj3M+tlcQDH865jOXlH9wA5IJI=
X-Proofpoint-ORIG-GUID: qMSen8P4F21-i7qDDNqhVxSivQLQYLsn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4NCBTYWx0ZWRfX9LURaZ1voBrH
 J/Y+MwXFFP6EVuPgqeNSIK+Y8G/f8tLOZ1IvDuVEPwvOPA/Bm+Nxhv9CDM58ra8FxM1a2TOxcS4
 LqtB/T2BNENMenJwNID4N000B/yYZ52N1gjVm3JVD/K5BU6gqdhpHd2i37goyhTe7Zbdhohv/iN
 60uX6GY+4MbdOXFKdB5Qrn3jCkVDvFrAWu3n2bBvSA1AkVMf3cJ6uk8qbxFdQbDLvjHpeWGSkQI
 gX12FaX6hx7UZ+Tn0OHB/Compfk4dd9g4lC6UJUkRJYdMk1NEvMOftcefTUdDoBtvH7jALNACjm
 A0Fkx4cQ7NuOctFR7AVcuwk6IvFN8Bp21GnmDr4zVuSPoKTBkRsannyeEeP2Xqine5kzyIwjF2o
 ZmS9LC4qm8fZgcLNwNngVvI6PG6XWYKAuGkOGzeTSrIxlI8okDhmTLgaVCa06E3dC1pJg0C7VFP
 92zsdqNPCHq5EU2SatQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120084

The channel-mode mqprio offload and the CBS offload can currently not be
enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
mqprio offload as soon as any TX queue is configured in AVB mode, and
tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
is active. As a result the combination is rejected whichever order the
two are configured in.

The strict-priority scheduler selected by the channel-mode mqprio
offload and the per-queue CBS shaper are independent MTL settings and do
not conflict, so drop the checks and let the combination be offloaded.
The following configuration, which was previously refused, now works:

  $ tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
        map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
        queues 1@0 1@1 1@2 1@3 mode channel hw 1
  $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
        idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 offload 0
  $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
        idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 offload 1
  $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
        idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 offload 1

Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority offload")
Tested-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  8 --------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ----------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 56d89a696272..51d502930219 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7740,14 +7740,6 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
 		return -EINVAL;
 
-	if (priv->xmit_qdisc.prio_offload) {
-		for (i = priv->plat->tx_queues_to_use; i < tx_cnt; i++) {
-			if (priv->plat->tx_queues_cfg[i].mode_to_use ==
-			    MTL_QUEUE_AVB)
-				return -EINVAL;
-		}
-	}
-
 	if (netif_running(dev))
 		stmmac_release(dev);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index ea1f97d6f0bd..175236ba379d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -346,9 +346,6 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
 
-	if (qopt->enable && priv->xmit_qdisc.prio_offload)
-		return -EOPNOTSUPP;
-
 	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
 
 	if (qopt->enable) {
@@ -1340,7 +1337,6 @@ static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
 static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
 					struct tc_mqprio_qopt_offload *mqprio)
 {
-	struct plat_stmmacenet_data *pdata = priv->plat;
 	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
 	int i;
 
@@ -1350,18 +1346,6 @@ static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	/* Forcing strict priority conflicts with the CBS algorithm
-	 * of AVB queues, so reject the offload when any queue is
-	 * configured as AVB.
-	 */
-	for (i = 0; i < pdata->tx_queues_to_use; i++) {
-		if (pdata->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB) {
-			NL_SET_ERR_MSG_MOD(mqprio->extack,
-					   "SP conflicts with AVB queues");
-			return -EOPNOTSUPP;
-		}
-	}
-
 	for (i = 0; i < qopt->num_tc; i++) {
 		/* The offload switches the MTL scheduler to strict
 		 * priority, which only supports a 1:1 TC to TX queue

---
base-commit: d0bd617658ddfa5a115e64d1ab687bf155f6331f
change-id: 20261012-stmmac-mqprio-cbs-combo-341f12749ce2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

