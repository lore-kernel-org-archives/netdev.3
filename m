Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EE3BD659
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158936; cv=none; b=BYPvB/NPFF9CfzFcWe8d/SrOKsKOzZWHZCa5H8EI2IszZbUOpr+W6ruOipW4esEks/APxxyukTbeBgsLxID5PiDhwW3h5ZLZqDbso7IxhRqm0BB/YuSZnF4aP5g5L8BpksuURqFl4Bq5AwffRiNwFZvEK1+JEakBIDtrwfe+iY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158936; c=relaxed/simple;
	bh=OtlIa+OE0zWjsovZ1zYmvcmiIyq6+RX+bn+CJ2yq0es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZBceQ+Pykvw24bsA9LDTTrYS75gUGHwEv1sVbtco4OSzRJCv1EiT9ynRPGme3TLb7iMSDsZflcJEgH94Va1vjpKMgiCvqDB+KsGBe4e0NtrX6hotoNU1oRpzkJav9knDB6pCQp77JyjDJ/QSJGkgufhXEzYWrvr/lBVrFRedi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aV4zbXro; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H2iWwuv/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aV4zbXro";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H2iWwuv/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52bOW2061074
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tCbLbmKY4GcRljOMUqkVhV
	dQxtRWJPaJL1JlyTIkcdw=; b=aV4zbXrozEosL8DrmQ+0jvVGDfuyw3jZCocJyt
	xb5GkfnOo1qP0SFrco8JS3ED7ZJzrI7462EfjEf72ccSKIONm41Q4BGAf1O+mga7
	p46gZjSFmZZ+tIaJfCPkmGm9t++UsBsk4Mhn7VNep+5mY66ud+hQdmP3eacCBIkq
	FLtyKfZZ8Z5CF1mtVd5B6j/2Odeis9YH1MlSRHLOt+gydWPpEcxJAU0t1l2JLHwX
	EEiKe2VVhxtIyndmdYnCGbU7qwlbE1LaEd2Fsv+v25ngkUy0yi67gMXMeTnezeHI
	M9Kd6Bq/RbuKB+H2psZ1X1NeqLobor52alvW56jhnxBXrAog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbr6dvwre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:48:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494527488so525707885a.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788158933; x=1788763733; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tCbLbmKY4GcRljOMUqkVhVdQxtRWJPaJL1JlyTIkcdw=;
        b=H2iWwuv/qs5r5QMxN8R0LULXxb8oF2Dnn5BRkKLC0LlqEjCJ7u/qJMubEN2MrVXhMK
         l9/bVYhAnm1IZPI66aMfhpxT7qnX9SS2QBbb44K3rWx/ngB4KEFMlju6sGJoE01MubP7
         s7I/E8BmjaQfsaFbsYg+j9jnODoSmhmWnSFd8CZ8wt/i2GVn2rnldcNtVzpeuvlEFgeY
         yD6yIpZF1T5nFVcpOXFGCnzw0jybYM2tETSV45SF7Fe+yyeh7DG49kxlc3nnD0IzIu3C
         a3qs7ylNqW92UinIJSrMM7Zu+yRW0k0EBpslpFg5aCbwuz1UfkEeK8kHdTACIxlTQFGZ
         kt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788158933; x=1788763733;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tCbLbmKY4GcRljOMUqkVhVdQxtRWJPaJL1JlyTIkcdw=;
        b=d1iVcpdPSwIgsQj0b4m512Brc8svwN2cOqi+hdaYUn8FdaPYF0gaQigut5D/scKj4o
         ACH1f7keQdmNN6WPIUqBWd730thGUV349qUmdjqv9tedqxxqP39/hTlKrtJqjXqbagW9
         gX6JmfNT6l0Lz5BL1K2rNjjv2UNVLCC+hDdo8TMIksUHRmipWjoIn6fI7dviHUTAalo+
         bwWyjPBnOz6ZkKTecGiZhOKnaEQvDds0cL1IZ9vGsGW/vUIZmmAGzI9gEzh9uku4VhPR
         uq+TV7hPOeY6lLzp9bdxuzKojAertGP5+Pxhr+mqFDAGXyzej7edgCcoXDke8NB4V9fl
         eg8w==
X-Gm-Message-State: AFuF++ntwgUSvMwT8viqtZuvxU726JjEfvNfkyt3oxRV98o3SAuiH3qV
	nId2XZR4SgzABT2VdwCyIsKX7msjHrm1GwRFPOBlRA0x8+EpI5vBVZONitnyB6/aBYDaJELpOvB
	M72kFrI/zFpE8oHuO5hHMRbNocjxYHED+b8wqjAiUbJm+oNHBfq1gsLKN7QI=
X-Gm-Gg: AR+sD11zoJYB4gilSGgyALCruH08osREO/Olfxkt91tzyeqcSriy9e5dkYU2WPCkn8m
	YJ8ODytrP5h8TQlSAhYkbIRhKDXp6RYAlUBb7uE5kYgHhvX5sfKV49wRpbLoajvBq/ApEERC4Pj
	l7EcIdtnZ1vwclJTrea1+wTzNz8ceMFCYgevfaOJEOhGdtU6WGUQbZOJN5Vs3BD1ASmmHL9up/u
	rEVyphX1bVXPKVyhPZQznbVIPnj/AfqDjFMw1dW7c0d+jTzIEQFnYizvumvCA368aPxI9nNoZQ/
	lRjDDer1O2P2kdg2jeUzLmb4Nk25XvQUtrhMH0f5ukjF2kQdaE4g36IsIdlRcqCvQ/NxvNxzzsB
	IVvaJB3dPHPYcoA==
X-Received: by 2002:a05:620a:318a:b0:936:9f46:cec8 with SMTP id af79cd13be357-939139040fbmr2328088985a.20.1788158933394;
        Sun, 30 Aug 2026 23:48:53 -0700 (PDT)
X-Received: by 2002:a05:620a:318a:b0:936:9f46:cec8 with SMTP id af79cd13be357-939139040fbmr2328086085a.20.1788158932910;
        Sun, 30 Aug 2026 23:48:52 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c52fdbsm200870475e9.0.2026.08.30.23.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:48:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:48:33 +0200
Subject: [PATCH net-next v3] net: stmmac: drop the queue-0 pinning for GSO
 frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-stmmac_select_queue-tso-fix-v3-1-d9c215fe7a85@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQqDMBAF0KtI1o3EqRrbVe9RisQ4rQFNqhPFI
 t69IasuSulm4M+H9zdGOBkkdk42NuFiyDgbwvGQMN0p+0Bu2pAZCChFJSQnPwxK14Q9al+PM87
 IPTl+NysXpdZFVba5AGBBeE4Y3lG/MoueW1w9u4WmM+Td9IqzSxb7vxaWjGc817msZKNaAc3FE
 aXjrHrthiENJ/ILfJLVbxICWcpMFg2cpAT8Qu77/gbmu+z0KgEAAA==
X-Change-ID: 20260807-stmmac_select_queue-tso-fix-06cc586d4022
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NyBTYWx0ZWRfX0dciiNl6k/JE
 ehEDxOFMxiR68Bx4IjJ93OjYlTKgT72JFWPgAln1dqZPFdFgdSb7ymsVdFBgBR8GSMRYEjaaNyh
 EJ9SAvjzXBj08Ih1SISrKzPQ1d1YfAOUI85BKdut7ddSIvNuK+lRyMGtqFlVIc84CIOkgoCQxaE
 KJ2X6qjPtUkMtNi/H08sXXRmiG3MnmeTE/N4cijmFwglFWboNOLOct7K1Tpylu8Qae6JXAMZd9L
 zBa+zze2E8q8gPXpgFjQ4upUiWe8BqBd3rw6VQvg2Spe8olKFUF/+mp91hJkMmD3b77nIRfD5HV
 vKmdtOtQx+C6KPwIs5D1GEhpLY+slhvjIgmkY7z4c10fgWfE2Cmy0FSpmJJdVqcZkz/7E1dzdrq
 X56r5EeYHr8nVtcfjBbFNWYgFWcJXkGKNMg8sLrvGWjdKYsWalnUyQ3NTtlL2RrihrxlnmAyc5/
 28INVPwATr28826yyvA==
X-Proofpoint-GUID: DNcWsbl1VJK20sl2OGSyb3ju3DwJKr_u
X-Authority-Analysis: v=2.4 cv=Zakt8MVA c=1 sm=1 tr=0 ts=6a9523d6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3NDt2XGU82yDlc6fJAcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NyBTYWx0ZWRfXy/HZm/qBdLim
 MoPq4JNyCDdT8hVyN8+42Z3jTzGiin/A4CypPTFHMhAUf/r+tRUW0AOJ8hHa8i8WsDoFnX1LjEv
 ZgT1D9+M3H42Evyr5/QJ5Gf6JAqDEhk=
X-Proofpoint-ORIG-GUID: DNcWsbl1VJK20sl2OGSyb3ju3DwJKr_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310057

stmmac_select_queue() forces every GSO frame (TCPv4/TCPv6/UDP-L4) onto
TX queue 0, relying on the legacy assumption that at least queue 0 is
always TSO/USO capable. This is no longer needed since
stmmac_features_check() already validates each GSO frame against the
capabilities of the queue it is mapped to, clearing the checksum and GSO
features for queues that cannot perform TSO (e.g. TBS queues or queues
without TX checksum offload support).

Remove stmmac_select_queue() so GSO frames are selected through the
regular queue selection path (XPS, flow hashing and priority mapping)
and can be spread across all TX queues. This also fixes the case where
queue 0 is not TSO-capable while other queues are, which previously
forced all TSO traffic into software GSO. Non-GSO traffic is unaffected,
since the core already falls back to netdev_pick_tx() when ndo_select_queue
is not set.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Drop ndo_select_queue() callback and rely on network stack to select
  the proper TX queue.
- Link to v2: https://lore.kernel.org/r/20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com

Changes in v2:
- Take into account when checksum offload is not supported.
- Link to v1: https://lore.kernel.org/r/20260807-stmmac_select_queue-tso-fix-v1-1-4c4787bad02b@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f2fc89176654..2eb1c42a7c27 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6426,24 +6426,6 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	}
 }
 
-static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,
-			       struct net_device *sb_dev)
-{
-	int gso = skb_shinfo(skb)->gso_type;
-
-	if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6 | SKB_GSO_UDP_L4)) {
-		/*
-		 * There is no way to determine the number of TSO/USO
-		 * capable Queues. Let's use always the Queue 0
-		 * because if TSO/USO is supported then at least this
-		 * one will be capable.
-		 */
-		return 0;
-	}
-
-	return netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
-}
-
 static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
@@ -7298,7 +7280,6 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_eth_ioctl = stmmac_ioctl,
 	.ndo_get_stats64 = stmmac_get_stats64,
 	.ndo_setup_tc = stmmac_setup_tc,
-	.ndo_select_queue = stmmac_select_queue,
 	.ndo_set_mac_address = stmmac_set_mac_address,
 	.ndo_vlan_rx_add_vid = stmmac_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = stmmac_vlan_rx_kill_vid,

---
base-commit: c4a839e06d0036c9a4af756d24688e0d34a18ca2
change-id: 20260807-stmmac_select_queue-tso-fix-06cc586d4022

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

