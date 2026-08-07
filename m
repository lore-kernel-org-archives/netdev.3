Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A0367F4D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106630; cv=none; b=TPpcAGNMWWxu5aljlhj3VSkUD8GHRBPvewu5XOqiYAOxUJxNnzV8+OS9uuC9g8EoThu5cyLG44A/1UWK7C76kgCa5ZkCI5UHDANaPKw1A0hHfksd1h1+gxvM9KzrePYc4sHZR9uYQNbcXxy8H5bGl2+Xq5DoUFHmP8cmv9+seGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106630; c=relaxed/simple;
	bh=hDzllD0JCnydU+Twy5rH3c+JkzOdK1MbAUdttGY51BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xs4yK7S7GOUWxcDNUNrt2xH6LcBKv4JXxDSBeKH2IxGQw9PsLTO/g/01Hb9IcLqYIiKjwWQJUTgTkvYABSblZd51EYMRjOPTtIZNzxDXdoFciSvGl5qP5SmMeTXwnRnS6gcaEnfAy3U8wasB4N+KO+JHCE9T7ODJOn4BnmOBBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kke22YSB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K5y5J1PI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kke22YSB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K5y5J1PI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgGNs942881
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 12:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mgSv8+oHtpxPxVfoRcwvHz
	b7euoA3AH08sFzhJMyAUA=; b=Kke22YSBGxqVOG7uQykH2NywrhenohZ+X0TrC5
	4r75G3+h5jUWYvvcbijKTPP8ThUa2HFSQ9t92s+s9G6kiz7UX5hMVozCiuGlkFtu
	8sP75ct/HY/38p5De2n0oH/64FbyAzqbjKr8FJTz8v0mlqy6SlPOt2vrk9MDEdu0
	1zz7BUKb5388/x/TMA+DHWWuXKXs3ItjQzu6uH7kt90mgU+9sM33skCdDkTyBrcJ
	dkUBj0cFb6j/tPyDJXZ8vK7FiPIoKilFRd4/M4vKCOFQTI+M5zODOquX45krL9Xw
	fXx71nsFaiZqEu8sub2BEoNuerOxKWJ3NyNEMtTl0VERCFaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hbxff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 12:43:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso36233651cf.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786106621; x=1786711421; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mgSv8+oHtpxPxVfoRcwvHzb7euoA3AH08sFzhJMyAUA=;
        b=K5y5J1PIyPraLxpihqtXW90PelkZiuOApsfp9gnMeytTBxQt19ExtBgXg7ifpwmdsc
         w/N/IsISa2md0Rxg9YUenEtm+Owrdz2e74yCfj1Ib553XxwSV8dZhA4tw6upbDZ8bVOg
         Jvz74dzT3zZmiTAgpSdFfSNJ8BAwmVrDuSl5mJb3F/R30YlTK5nDFsdESuNTXK4/D3Zj
         iyZKjFnGcURhLXUahaJcMC1XM7g4HNWxz1O35mbPvJ+SFDnicFZnhLDRSsOFR55FshMH
         AVXRWY6kzsu5ADxg0Nn3Mf6vXOBXk6/AaUTUfo7m+JD+sDjz8OO5YE3DQ6qLC/1+XgBc
         sXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786106621; x=1786711421;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mgSv8+oHtpxPxVfoRcwvHzb7euoA3AH08sFzhJMyAUA=;
        b=rVoAigNTYK8iWkP1hCroj50pi/xXpBeu3R5wFOKIYEoz3YVsYNX8lERhRBH5uBoxGN
         UNXcmEc0m/wqVKjiOB+powhyt8e4yIAcZ6NxZp93PG27bZkoGAVEGO4Ymbc8IKM2GLRg
         54KmtrL/5spu/zH8d4oBJXxxn+HELu/CWkxXJYLW6OA6PS8gqmgsgqzfJNsbnfCWAliY
         fgs6bzGrUCZjyFFCy2zIAReTqzxKCAylpHULmgkU9e37lZo0rpN2Kd7kxPwW1QQpEAW0
         wlEPf2vtsVj8xUvQsAoUmHdHb3zNgZmbVAD/1jN7KqARNTZsrbodyhJDXROf72qOFDTZ
         DOSg==
X-Gm-Message-State: AOJu0Yz4MY5d0TPUtuiSvLVryLAYjJ72HZuVVOR0APsyznP86u1LIgIz
	ycVoerGGP16WCO9OA8/weiomI9b7ulIUaoTmvOArVhFeyoS1NMo4ItEHuohbdD6P8B2nabWjspV
	Oof4Sm90VHNmwFGRuMzfdabwrxMadnO7jqZlDWtcP1syiiGOFJ959hznQ9Rk=
X-Gm-Gg: AR+sD11dFrEp2z+b44i+buX7kWVrDB5hXOm+mRfxsV/Ts7iAPnMJHmRQ0XtDY7xzbZ9
	5ZKoaa5GzhcJCNJfpVSLksS5H2p+cvdfpmZMI4gHVRQRDwpOkpSFUKzHO2sv77h1vvgeOVlx4cN
	whOOHEfLSleiCaT8U+7XRAuwdVRcdxxTmmdejf8uwuCU/w5giMHuI6zRQ+sbe2gNw7GlujMPPwZ
	9ZClbtVGquwXwX8lrcrRoTH5lQ1V9VVnNbg/RtF0ftm89+kfzxQz9g/NkKA8ojzQrd6vudZDk3x
	LbUBY4PlFQQ46e3JvzQ0kYkDB6MDYQyH4G9bI6+ZHjDwXG+CqA/v6QWibmCcLDVlQl0BNxqod3m
	j4U+cBjtm1CF4dM4=
X-Received: by 2002:a05:622a:64e:b0:528:583:a6c6 with SMTP id d75a77b69052e-52d18e1b942mr26001541cf.6.1786106620549;
        Fri, 07 Aug 2026 05:43:40 -0700 (PDT)
X-Received: by 2002:a05:622a:64e:b0:528:583:a6c6 with SMTP id d75a77b69052e-52d18e1b942mr26000761cf.6.1786106620072;
        Fri, 07 Aug 2026 05:43:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f060bsm39042535e9.7.2026.08.07.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:43:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 14:43:01 +0200
Subject: [PATCH net-next] net: stmmac: improve TSO/GSO queue selection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-stmmac_select_queue-tso-fix-v1-1-4c4787bad02b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrCQAxG4auUrA3EQcfiVURKSX91wE51kpZC6
 d0dXH5v8TYylASja7NRwZIsTbnieGhIX31+gtNQTUFClFYubD6OvXaGN9S774wZ7DbxI60sUfX
 cxuEkIVA9fApq/t9vlOGcsTrd9/0Hklx9k3cAAAA=
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
X-Proofpoint-GUID: U57SxLyE2YxB0XxNEIEcP9A-cXpESUaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5OSBTYWx0ZWRfX3aeuE5GO14pW
 FrTIMPUsN2oTgz2wMqJxJy7RBntQqotau7xKOuCsI0xuBP9FWH0SKmDshZaLQGc/bhvMCJPcb8w
 qbMsDKRhqiVh8om1N06LjE/lrwBebf2EmNGfEIxJpg3x+anWuFGscfnUVn57ZtJqSalc/TxZFMz
 gIepSybj1DXR8kbUKYiNzfnrU2hMVSiY+wfivH8RdrBQZmdh5ELWbXYRL3cQPCvklePq+jId5uL
 7ZJBlPrgH3HwMvcA1FXFm9gnHBWXfenYD9EvOJ7gxtVzWz2Dss0TrHiccJ13dPzHmDOblvytHpR
 pMRL9AB7/8LNmqsVNdYlsoOVOnXeXEzddB1B8lRK4Ndo9Fe4Z7oHYm/MzA2++8o0ZCUNo4WeX2J
 KP8hPjW6uI04/b7dDT2PaHBcY1iFwPl0IT+jfYoWY7TYkR3zCRDeh1K/TKgX7bqtbwwPrJMNbD/
 xUCoT3aJY8GNdrNUKjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5OSBTYWx0ZWRfX0PQHwG/f+RA9
 hVMXRdZ/GWYxUmtMqnykUrD2hWzWog1rYHkctUOVYRI0Nkwb/JSgoJzv0ds+3foK6R+kaji6Jz8
 N66fWy6nbsF8/rWkyd0x2YK4zUTFXW0=
X-Proofpoint-ORIG-GUID: U57SxLyE2YxB0XxNEIEcP9A-cXpESUaU
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a75d2fd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=nGs_K6xH0Xy296EihTkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070099

GSO (TSO/USO) frames are currently always sent through queue 0 since
the driver assumed there was no way to determine which queues are TSO
capable. This unconditionally pins all GSO traffic to queue 0, bypassing
the per-flow queue distribution and any XPS setup.

Instead, pick the queue through netdev_pick_tx() and only fall back to
queue 0 when the selected queue cannot run TSO, i.e. when TBS is enabled
on it, since TSO and TBS cannot coexist on the same channel (see
stmmac_tso_channel_permitted()).

While at it, base the check on priv->gso_enabled_types rather than a
hardcoded GSO type mask, so it matches the TSO/USO capability actually
used by the transmit path (e.g. UDP segmentation is only offloaded on
GMAC4).

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..99fc7313f247 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6445,19 +6445,18 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,
 			       struct net_device *sb_dev)
 {
-	int gso = skb_shinfo(skb)->gso_type;
+	u32 queue = netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
+	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6 | SKB_GSO_UDP_L4)) {
-		/*
-		 * There is no way to determine the number of TSO/USO
-		 * capable Queues. Let's use always the Queue 0
-		 * because if TSO/USO is supported then at least this
-		 * one will be capable.
+	if ((skb_shinfo(skb)->gso_type & priv->gso_enabled_types) &&
+	    !stmmac_tso_channel_permitted(priv, queue)) {
+		/* GSO frames need HW TSO/USO, which cannot run on TBS queues.
+		 * Fall back to the queue reserved for TSO (queue 0).
 		 */
 		return 0;
 	}
 
-	return netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
+	return queue;
 }
 
 static int stmmac_set_mac_address(struct net_device *ndev, void *addr)

---
base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
change-id: 20260807-stmmac_select_queue-tso-fix-06cc586d4022

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

