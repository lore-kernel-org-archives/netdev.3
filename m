Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804740D588
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968754; cv=none; b=GgnjzWiZU/bVXje1nufvGu20PfEkWRudeedCgND+KPUgDmGawKnA0OqZ92sRUJXl8ujYSdmC8yalSTpcLCHumcos9hZvYghxrB8E0XBkMIzdE8D2564BWu5pZzg4vDiLazAISfbwWcWuPt8A139VLzEDYSrKLQx44fK9K9EKjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968754; c=relaxed/simple;
	bh=pRSt0j8aT/8E8YoShpErgRJOJhHFrhtX/mPDVYnU1Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gKd3jrsfR8W7Sqkvw79eb/MASMwh03KVhFwYa0XrBJ/h/5YJ0iaP1LgP3LkFS39ECauUGsNmukNEZrV3glSbnJucu5nSYWUT14gxusSLy7fT7kqoHA9l3gLyIehn5rEOmcBjGyvLJ0XGix1Ph39Ul5YKptRYGQ7f+OCsZzks4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f6JSO9H8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CA390MSt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f6JSO9H8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CA390MSt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E6cPjp2087978
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ABZjvjkoFi6ufA3S7uw9fr
	ak0BnaWuc77CSpR+ZBNTY=; b=f6JSO9H8zEnb+8w0gKovbipSxsQtGdkV+GV4I7
	EseGnhQIlPDDxJ223eqlWCNfdCvvaHS7cvIWw9xsBzpXK2qrTcBB897SU0vrB7A4
	1LtXcSfq0giMlo28SyjzsH+Q/bv/3V8Hx0T8i4EBR96tFftb7fyLX17XqiwU07FZ
	mq6aDGBmKT0VV8I/jGFu1foGrjeEvWzLkyUbE7vzykeEn4MnY7nV36plMI7XBrHi
	Pt7l+noS1n0yvWAVxK8SHPBQJlmWAtZXQCIzyTx145YTV57GjBKDWGJiPaHQ7ND4
	0fiaQNRiT/XGuUm4TMLd5q+WMGXZp27m4UTSG9Zsu5MjEttg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49j0wq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:05:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf7856ffso791570385a.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791968752; x=1792573552; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ABZjvjkoFi6ufA3S7uw9frak0BnaWuc77CSpR+ZBNTY=;
        b=CA390MSttc05fDxP/XLLa++GTBDYr4Qn3hHrp/KAagvWH6lXXqa2H8JBSq6tFCy2m8
         hyKhkuFfU2c+0tGqNYJvcOoSCJRUy6A4C8ddQz32G4B3HkwPryMz7MAND92OQMTaQOwD
         oGZj3ojaZLD7DJXeCluOBShVmfhcfGlZA9MMjOPc+5mFOV71wFgW+urofjeBhq0CAf8A
         +2p6gv0paDX50Nqu3sEI7oV2sbZCRxE8qzxiXG4THHZL0VRWvuKjj8+ZB7BYq0Uawoc8
         uDmf+bLpICdbPeLU4p5o3MqV/g6vMW4SIiVZhuHk44wvFMeLvTjuzcQSJPDes+k9t8Nh
         1j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968752; x=1792573552;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ABZjvjkoFi6ufA3S7uw9frak0BnaWuc77CSpR+ZBNTY=;
        b=2sDy8eQPY6yzp/tXnctn7ixA10GW0xtMrOv4XP0Od9kUIrtA9lCtzUjS6Ct43gC99c
         te1z4hpuv/1fALU3gSYZld5ZY6e2s/peregXQ7NGNN2VDNBCENdn+65MfqeFIxOjqT0j
         1VRVwVp5KyAgGN9eSa+8yzPD6ATcrZuHJM32gcMVbXOEPOzQQQwPATI4qcKxsZym3cat
         9sFBO7kCt5ftQFpfZRDMIDUFlMmPPf+bHuyWDIpPSvzSs1NLUvbYPna4T+BbzYaFbTh+
         /M2omLDGH2jM3l3ZCiOeRKtyJVl8J9rUn1hP87yP1bnsUEmLm4/CS3fwdPfyXSdqTve2
         p3aw==
X-Gm-Message-State: AFq9FYKVjF7cFP/tWZDiJ13ceui8rkAUdDQ8Fuhh02tB944kTCkGPEj9
	KgXX/6QYNg/A5t1fXNPRZHI6JJhDTOg/j/+HPt5BGE7RJzlJUPwwSuVmz1Gk9M3buo2zDWaUxgN
	u2s+texA7ozevyElQDgXGFGvxk1jcbj4/jJ9auAwWHluiXNh0So42iD8ZpnXJOZQlIPs=
X-Gm-Gg: AYBFou1WaAzvclYdPehPRrjSv5U+0KPyEM2r9y9dX2Nvo5WhGjAbQGsfMuGORI3hFxb
	PH5jCiPkGXRqh6XqEUbvtWx8h6AZ/W7g/l1UKIoVpC/WSfUYyzgmTXBHtJBkoOPTzO78lSY3525
	sX7zjYORhovFJ//oKIN/xF2JzuucfSqgHsgarzIDDhDlBXQFb0Awm1IykJ0d4J+7cDAsHJfRURD
	UO089HvcS7w+KXykpRgq6vmNQswcerc/7aOyGw3zN5MHsTD9X9On/km2jKgyPLaJy3k/U1PKxSF
	+q3mkcuTo+nSjuHZ73DNmgxiEMfDn3/taqypSbmbs8BtshwK9+pTNaLew2Zc2eX1W+la/lz1paP
	KQt43G5AxPttjRA==
X-Received: by 2002:a05:620a:618c:b0:93c:735c:2477 with SMTP id af79cd13be357-93ebd228f5fmr2484049185a.21.1791968751411;
        Wed, 14 Oct 2026 02:05:51 -0700 (PDT)
X-Received: by 2002:a05:620a:618c:b0:93c:735c:2477 with SMTP id af79cd13be357-93ebd228f5fmr2484044285a.21.1791968750756;
        Wed, 14 Oct 2026 02:05:50 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf214a1sm489166355e9.7.2026.10.14.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:05:49 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:05:25 +0200
Subject: [PATCH net-next v2] net: stmmac: fix mqprio and cbs combination
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-stmmac-mqprio-cbs-combo-v2-1-372249daa81a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQqDMBCFryKz7oiTSP9W3qO40HSsgSbRTCoW8
 e4NXqCbBx8f770NhKNlgXuxQeTFig0+gzoVYMbOvxjtMzOoSp2pIoWSnOsMunmKNqDpBU1wfUB
 d00DqUt8MK8jtKfJg12P5AZ4Tel4TtNmMVlKI3+NyocP/XV8ICa+aWCvNfc1DE0TK+dO9s3dlD
 mj3ff8BdVsd1c8AAAA=
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
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf45f0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=P-IC7800AAAA:8
 a=6U8f6XgL5L5c0sPS4z0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=VOpmJXOdbJOWo2YY3GeN:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX9+kBK25SuRf/
 piY7khSndomTNpN5ya1POEpuPUSkghELF13jFMmmsBZdtJCkQAu3fvBXBbZ1B3wfjpzQ91NxCOy
 rRCCgN+rJtqOWftndq1Dpvm0NStC1o5Gq8gVDWEivFFHlZgVWYDPDuT0Izo1LXn5T+TQnWhN4dS
 caMqj4cTxFACd0VvuAuzgI0xUKivq37GngzJbG0SUBVYI+LfPlGreWJWEA96rS3SUdWFz8XjXE8
 oUW/XQ4egbNUA7LBUi3NGs4pzYxKnuw5POoQU3eWo0Wb3ixAwVYJhPySySrE++K/Q3P0pymctBS
 Bh2Yl03spRvU/zg65x9sl8Y87NwIj7ZLu1DIFWcsQVHyAFGLz6YRIA1zB+j1xx5JMncpfz2FAh0
 FP7vjpSgw/B2eAmxEumx7mdhJmcqcmWDgpIeEQGKVcptabQgFKJJntkJ+Vg3s9HfWQaMgnfFxPX
 x59IGnRT9bhVTJzJZNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX+tW6KxHYUTeF
 Jk4Dq4Zp6YKYxQ919pgGBvHDyo2j4atW5yi+wTlB73rs1SJJK0CruD6qINKGzCR0s7lP5gtbX7j
 rRBpwHx3+5RjLullxCgrhqhCSczX0PQ=
X-Proofpoint-GUID: 1qrJA9isAGZK8P2l13-SGxiar2zpY4PG
X-Proofpoint-ORIG-GUID: 1qrJA9isAGZK8P2l13-SGxiar2zpY4PG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140036

The channel-mode mqprio offload and the CBS offload can currently not be
enabled at the same time. tc_mqprio_validate_chan_mode() refuses the
mqprio offload as soon as any TX queue is configured in AVB mode, and
tc_setup_cbs() refuses to enable CBS while the strict-priority scheduler
is active. As a result the combination is rejected whichever order the
two are configured in.

The strict-priority scheduler selected by the channel-mode mqprio offload
and the per-queue CBS shaper are stored in independent MTL fields on
dwmac4/EQoS cores (MTL_OPERATION_MODE.SCHALG vs MTL_ETS_CTRL.AVALG), so
the two checks are over-restrictive there. On XGMAC/XLGMAC they are not
independent: the TX scheduling algorithm and the CBS shaper share the
per-TC MTL_TCx_ETS_CONTROL.TSA field, so programming the scheduler
rewrites TSA on every queue and would disable CBS on any queue configured
in AVB mode.

Drop the checks and re-apply the AVB/CBS configuration with
stmmac_configure_cbs() after the TX algorithm is reprogrammed in
tc_mqprio_config_queue_prio() and stmmac_reset_tc_mqprio(), so the
combination is offloaded correctly on all cores. The stmmac_reinit_queues()
check is dropped as well, since a subsequent ndo_open restores the AVB
queues.

The following configuration, which was previously refused, now works:

  $ tc qdisc replace dev eth0 handle 100 parent root mqprio \
        num_tc 4 \
        map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
        queues 1@0 1@1 1@2 1@3 mode channel hw 1
  $ tc qdisc replace dev eth0 parent 100:2 handle 102: cbs  \
        idleslope 800000 sendslope -1700000 hicredit 494    \
        locredit -1049 offload 0
  $ tc qdisc replace dev eth0 parent 100:3 handle 103: cbs  \
        idleslope 400000 sendslope -2100000 hicredit 247    \
        locredit -1296 offload 1
  $ tc qdisc replace dev eth0 parent 100:4 handle 104: cbs  \
        idleslope 200000 sendslope -2300000 hicredit 124    \
        locredit -1419 offload 1

Fixes: 47891d501e34 ("net: stmmac: add tc mqprio hw queue priority offload")
Tested-by: Daniel Thompson <daniel@riscstar.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Reconfigure AVB queues if necessary.
- Link to v1: https://lore.kernel.org/r/20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 20 ++++----------------
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 08b68441f9c8..120d01c04d61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -440,6 +440,7 @@ static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 	return !!priv->xdp_prog;
 }
 
+void stmmac_configure_cbs(struct stmmac_priv *priv);
 void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 56d89a696272..1fdb4ca56591 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3467,7 +3467,7 @@ static void stmmac_set_tx_queue_weight(struct stmmac_priv *priv)
  *  @priv: driver private structure
  *  Description: It is used for configuring CBS in AVB TX queues
  */
-static void stmmac_configure_cbs(struct stmmac_priv *priv)
+void stmmac_configure_cbs(struct stmmac_priv *priv)
 {
 	u8 tx_queues_count = priv->plat->tx_queues_to_use;
 	u32 mode_to_use;
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
index b09e9a89cee8..e137fb9012d4 100644
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
@@ -1288,6 +1285,8 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 
 		stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
 					      priv->plat->tx_sched_algorithm);
+		/* Re-configure AVB queues if necessary */
+		stmmac_configure_cbs(priv);
 		priv->xmit_qdisc.algo = priv->plat->tx_sched_algorithm;
 		priv->xmit_qdisc.prio_offload = false;
 	}
@@ -1334,6 +1333,8 @@ static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
 	}
 
 	stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP);
+	/* Re-configure AVB queues if necessary */
+	stmmac_configure_cbs(priv);
 	priv->xmit_qdisc.algo = MTL_TX_ALGORITHM_SP;
 	priv->xmit_qdisc.prio_offload = true;
 }
@@ -1341,7 +1342,6 @@ static void tc_mqprio_config_queue_prio(struct stmmac_priv *priv,
 static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
 					struct tc_mqprio_qopt_offload *mqprio)
 {
-	struct plat_stmmacenet_data *pdata = priv->plat;
 	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
 	int i;
 
@@ -1351,18 +1351,6 @@ static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
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
base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
change-id: 20261012-stmmac-mqprio-cbs-combo-341f12749ce2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

