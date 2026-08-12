Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC083594A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509519; cv=none; b=RY8lteIfymyVhh+W2/Ny4G3im8qCDa/0GUY4UBc88oNEOlPlgib2+y+IyMlbE5E7A1sn9JGqfHS6gPoaG0B6hn5VOlbL7ZFgRqXi4BZN6ge/4zojEZhVk8KAinXEOCt/ZCWwXRnvYrPyqRaaTkiZrb88S/i/zrj0t/KC8XhfOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509519; c=relaxed/simple;
	bh=iTz+MsOWrYRHHGjiIOhVyAFJR3EzWcm4T/qdaln7B/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hgRENi9OcrYEL4+hBjDHIF5Ir7EWWubqDAt9zidMaWWkvKnStHa1W5XZaU1g57vmr6bvvMJcu72ng1IwZObzOK5z8gNEX677Mm07R0XjkngBmF699CezP/f+AG6e0pThwNpWdj8ZvOSfmxAlm/mV5iJjAQ8Usphk0ziCeqTdibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDGKzETu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AGX+xyU+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDGKzETu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AGX+xyU+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C4UFkc2675278
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 04:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KdFIJwL/ItKbdlpitmpyns
	ip1Jdt+5SlhtYQlqlCk0g=; b=dDGKzETudy29AjLkkhcrI3J8T/ooJ3pvWamvwH
	aZUQlH8jGMRBYkLFtMn/raO7fadcVhwKMxeuuV7MSztfP5u11IiyIO8HO/IMeSSs
	rvegBRhU5LL+tvgGSLgRy683dW4zN1LxG8T8mRuzHWt0vxtRKGVl2kxMDlu4HiDL
	TJnDPG7ITzrNvFPowflV2TkY2ePiTi4D2wp/hcKHlMQO4f5J/MzsWYO5VuBAz0CX
	dKgWC+8apkGrGHVxjJCdat0AA86TXXgaNRHyOhorBUkNaisfVotUPF4ZSPC9O1pw
	XuX37hLw06XvveTz/9ifCbtdvM52at/9Ee0+1wtcMxbNG3Gw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1g2mq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 04:38:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d001671a54so13303245ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786509516; x=1787114316; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KdFIJwL/ItKbdlpitmpynsip1Jdt+5SlhtYQlqlCk0g=;
        b=AGX+xyU+44QCXJnzlknnI7cGRVO6XdC0uc1CUXs161aNFuexw0RgvsdnuZ7oRpDBui
         TPUFlBzg0k+tIeug21b6bF6ln97LOQJIlsFB4NH4OGPoDDxos0NzP3Wv/rKjvD/LZSAY
         G76hYwcw9tKDg+idkl4KrPmnTbMhcw/1SuAI0Bp9+sPpAze9DczJEkAbmHNmm98A+8Le
         DhQWGMpdynMxTlMx1pirkv4p1aAwLcffNztm4HVOtyOA7yO3WWdRv1QI3YtJmqKo9XQY
         5WVpyCv2ag84srTzZ1WdX8ViWBP5R+yUxPzVBn7ZGUIeI0+IVrS0IvCLlzruc74ikewB
         5RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786509516; x=1787114316;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KdFIJwL/ItKbdlpitmpynsip1Jdt+5SlhtYQlqlCk0g=;
        b=spszmA2ul6lOUbywP6CP3tu4Dpl1801aH0NHcg5rxNSt1fxU6KprNMP/hG4XwgmXy/
         yg9YSRWrYepMXil9iZHZpKYFGKok5WfRiyWz4fgL//gft22NDu+Ghk6etzLpmSgriIly
         M2sD7jqsXt0e3yHnK9UArAJwrpt4mSPcP6P6i+cf4OaLE7TEwYQv8sAKeGZ80rJJwFna
         W+Beunnq203guJ9yIPeEtjJdJhMRXQiUH/r+NybHvfYVqiGPVAy0e3WZ1905RH8P+sy0
         1QOykmFdoMUz43Y3PkpNLnhDoZOWbdu8Y6uzjmAtaJTCEcRjuBu3gc9z4UXBibQX2xEw
         TPrQ==
X-Gm-Message-State: AOJu0YzASU8W8WN5ehRoWDdqv8GaK6EXHBZYbSi7vXSMrPFe+4QSaGPF
	Mg0oQMfs0jmFVpBX0l0AqpAv532qaJ8k895+ajgHYyJx/969s2zPFK5kmCA1bcWh3QIQ167//95
	P5EHq6oNc23BZAWsyYg3eiWpUWBhIHF3CMCBhz1XuFnxJJ6Z/nDpj8eI71M+0ze512ergRA==
X-Gm-Gg: AR+sD12/MIh6F3XrAlqJAemrxyxEeXn6CVvEqA+fiqCZ07UNNoZlcxQ+prsfhwaMw5z
	4wwFZ52Mb0dNodgDp+z6nev7ADGpihTixJBQ5iV/Nj5bT5PvgRc0kQFEOBJ/IZisBjRAW7kQq+m
	mn7EAH0JVHbRyYFvwu7Yo3J99g5m1mZwOECfzDzBc7UgSm4Ia/NgWpgTHvDdnpMwwghX9/nGch5
	cRApmhplzs3rfRMQD8f6tgzTylfQ2/Yfm6rHXOBPOlzz0wpS4xsFa1iJgeRyfPAG06Lo9vKmQsL
	pyLnLzzdCNhVeghA2HHji8NivVbsOOvXDF1fWTXzz71cCQpfOFNpsMhMBDsZVjvYqJEmP9omR8R
	JhregavZjNdQj9Q==
X-Received: by 2002:a17:903:320b:b0:2ca:ecf6:910e with SMTP id d9443c01a7336-2d3450e0539mr33371405ad.0.1786509515768;
        Tue, 11 Aug 2026 21:38:35 -0700 (PDT)
X-Received: by 2002:a17:903:320b:b0:2ca:ecf6:910e with SMTP id d9443c01a7336-2d3450e0539mr33370935ad.0.1786509515282;
        Tue, 11 Aug 2026 21:38:35 -0700 (PDT)
Received: from localhost ([4.43.230.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d352208fa5sm1111035ad.62.2026.08.11.21.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 21:38:34 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 06:38:13 +0200
Subject: [PATCH net v2] net: stmmac: keep gso_enabled_types in sync with
 netdev features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-stmmac-fix-tso6-features-v2-1-72c3b06eb8d4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4VNSw6CMBC9ipm1Q0pDobjyHoZFLVNpYql2CtEQ7
 m7DBdy85P03YEqeGC6nDRKtnn2cC5HnE9jJzA9CPxYOUshWaKGRcwjGovMfzBxbdGTykoixc6N
 V1DeNJgml/kpUQsf0DWbKMBRx8pxj+h53a31Y/5fXGmt0Wt7rTvVKKHmNzNV7MU8bQ6gKwLDv+
 w94huD1zAAAAA==
X-Change-ID: 20260808-stmmac-fix-tso6-features-7fdc5e9448e2
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 0vTA5R1RfeIvzWq1r2QeyB3UR5A7wDrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAzMyBTYWx0ZWRfX3I4mtieBdP6O
 wc02eGkJpjwHTYbWyxiM6CmoMDPlYYEXOkBy7QUgi6DC6U8IUIQ/yUykvwPaCOTa4aWwzSRI9+x
 dCzU//lG2DfY1HY31kqophzhi4l3ipwug1OgxmYeZMeeDUsXOEcYqTBFnva1tHBv+lmuvO/46Uu
 GiKT2twUD3S15Uofl3lQ9wC3NGuQJDRy1VZoQ84dXxUqX1ubaAKBvK36BsEZfEzNQjvZNHfovnk
 9XvozCvLHoFrhSqm9it9ePAxrFpO0VI6wXkIElaOsuO66wn3JLqrEr0sPfjnz9klfTTQS4L5+i5
 bakslbJ/1iivwVmoz1weRf96leOJo5KNROMfxYk7sUSanE2FeAGVQoAQX/0QVSrpUMIXUcsavs2
 M2bSfLyOPlB1TPxy2Z/Th0YJnjdJdVIZIHIbx+rDU27kJBbjNHKQUxomiiIQm98YO42e+JWIDp7
 rmXRjO8Zn10hV7mn+Tw==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7bf8cc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=f2H3biQdujjI0Mw2rri0Ng==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3uZi2X7aTxeIN_KhKxEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 0vTA5R1RfeIvzWq1r2QeyB3UR5A7wDrj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAzMyBTYWx0ZWRfX6qR9gZlgslRZ
 9v6Ob8IntOdmNuXPQzGO2IoQlGzY3DSWibvWft/agOt+TuIdinb3ja3fJAiz7xloQAmfj47TKnV
 BVwkNpO3rFTpEfnjimyWqtxig4CDx3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120033

stmmac_set_gso_types() derives priv->gso_enabled_types all-or-nothing
from NETIF_F_TSO, but stmmac_set_gso_features() advertises NETIF_F_TSO,
NETIF_F_TSO6 and (on GMAC4) NETIF_F_GSO_UDP_L4 as independently
toggleable features. Since netdev_fix_features() only ties TSO6 to the
checksum features, disabling TSO (ethtool -K ethX tx-tcp-segmentation
off) leaves TSO6 enabled in dev->features while gso_enabled_types
becomes 0.

For a TCPv6 GSO skb the stack then keeps the frame unsegmented
(NETIF_F_TSO6 is still set), stmmac_features_check() does not clear the
GSO mask, and the stmmac_xmit() gate (gso_type & gso_enabled_types) is
false, so the multi-MSS skb is transmitted through the ordinary
descriptor path as a single oversized frame.

Derive each GSO type from its own feature bit instead, so the mask stays
in sync with dev->features and TCPv6 (or UDP L4 on GMAC4) segmentation
keeps working when only TSO is disabled.

Fixes: 9edfa7dab811 ("net: stmmac: enable TSO for IPv6")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Fix possible race between stmmac_set_gso_types() and stmmac_xmit().
- Fix fixes tag.
- Link to v1: https://lore.kernel.org/r/20260808-stmmac-fix-tso6-features-v1-1-f82b17595052@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a71f0df26378..df3549f55741 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4371,16 +4371,20 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
 }
 
-static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
+static void stmmac_set_gso_types(struct stmmac_priv *priv,
+				 netdev_features_t features)
 {
-	if (!tso) {
-		priv->gso_enabled_types = 0;
-	} else {
-		/* Manage oversized TCP frames for GMAC4 device */
-		priv->gso_enabled_types = SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
-		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-			priv->gso_enabled_types |= SKB_GSO_UDP_L4;
-	}
+	unsigned int gso_types = 0;
+
+	if (features & NETIF_F_TSO)
+		gso_types |= SKB_GSO_TCPV4;
+	if (features & NETIF_F_TSO6)
+		gso_types |= SKB_GSO_TCPV6;
+	/* Manage oversized UDP frames for GMAC4 devices */
+	if (features & NETIF_F_GSO_UDP_L4)
+		gso_types |= SKB_GSO_UDP_L4;
+
+	WRITE_ONCE(priv->gso_enabled_types, gso_types);
 }
 
 static void stmmac_set_gso_features(struct net_device *ndev)
@@ -4416,7 +4420,7 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		ndev->hw_features |= NETIF_F_GSO_UDP_L4;
 
-	stmmac_set_gso_types(priv, true);
+	stmmac_set_gso_types(priv, ndev->hw_features);
 
 	dev_info(priv->device, "TSO feature enabled\n");
 }
@@ -4766,7 +4770,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_stop_sw_lpi(priv);
 
 	if (skb_is_gso(skb) &&
-	    skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
+	    (skb_shinfo(skb)->gso_type & READ_ONCE(priv->gso_enabled_types)))
 		return stmmac_tso_xmit(skb, dev);
 
 	if (priv->est && priv->est->enable &&
@@ -6198,7 +6202,7 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
-	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
+	stmmac_set_gso_types(priv, features);
 
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		priv->hw->hw_vlan_en = true;

---
base-commit: 7b53449540502cb21b32bca62a6258e22cd97bbe
change-id: 20260808-stmmac-fix-tso6-features-7fdc5e9448e2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

