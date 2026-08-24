Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652E374E5B
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565573; cv=none; b=sMWaYrtaJVGh1wAbNy2IzKDeu/2A+qIKFrGAGYysLyv0vkOCNy24TkkzfIxByTTIHfRpoBame5cWgxIVEkdIKIo5Xb2Gft8PAUY8yTL99U2jxmdlqtTt6vb82f9FJbNP51K3xpoG7GXsSd1vKkoEHGxRJkm/NMXjjgRYK9WvQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565573; c=relaxed/simple;
	bh=6GUET5YvWZ3QVmPn+q6X2EGeF+YJrcSLgurOiGneylQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S29Th5MEtWDZCQUg8dSX8opk+pKXqjlF66xknJB/GxUcJeaqORBCNHAKsQJHxRB5pWCjzAEESDvDcxbJj5Q9TApl7y60S14NaPPVYRcPKj7K+SwXXgJs7isolPesm9jlKQ/XIEX2KwFJBtCdUlIf8GFsA41qw9U3WbBVi/GAl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzqQnXk7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UyUg4HjS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzqQnXk7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UyUg4HjS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O992dg1377917
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CsskcMB2dvjU+nJnFs1web
	3IeTOM4DlaOeuWxlSh7G0=; b=OzqQnXk7PY3Vj89vH0FzXzO/QKzZHSFWwtgO5e
	n31jdTIsjDrXr8fPpg68OASzXTFSBd/Xr+n7auB6cJtb73c50vK/goekPELqm0HQ
	tMJLaWHMrIX10NemHdPMuiVst2RhBkgyyngVk558tN7Q5w+GTJCNiC2z/KCruh+5
	EO//X+MIiLN0kyPYI+gjK7ulgE8PQsZPf3N5usaXgYZNpAPpS89nmqr5q5KDzMYR
	9H53stiBKlhOQoBHmrgIainO26MAwG/UJqGDIfCLPbOiw4xOxDYKtaTzYNcl1Xcy
	XtwK0gW7rDR21IHmKcWnl7sPi8Hqe5PUmFGDC/+Df2ylhzuQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf0n5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:59:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276aa86d00so35903281cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787565570; x=1788170370; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CsskcMB2dvjU+nJnFs1web3IeTOM4DlaOeuWxlSh7G0=;
        b=UyUg4HjSHSQ/uRVEGZ3NcgRzQ+sCXHjCnvA3tqMUFL4g9O/tCONnUgKPAQoNK1didD
         YKK4hvCQWV0JJcbdRJnS1kFUmj8trXA991j+HiGcZk3U2U0JxZ9ce7RXvWv5egM4zDmf
         dM/C3lqEdengKajFesyv8vTxIWglDYVFH9ILI7fa60WykXsO/hF9Udveez1PpBYlErGu
         /P3ozbrAVcTK7BniZZ9rQ5DqL7AKDU1Cq5XtdjnFF4csPoShk+TiakUz1a8I/YGhCowC
         Iy1JMGicTFVoCXixz7OLlRinjfwPai/HWiN8Ep+GZ/YTIhRDXlLA31WIYmr9nWKl8hoc
         kanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787565570; x=1788170370;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CsskcMB2dvjU+nJnFs1web3IeTOM4DlaOeuWxlSh7G0=;
        b=J2GrQnV3bwO/0h+DsRfg3tJQG6ennT5rD71Tax9xKzxdVyOyFxsnTcEKiohEtVfySP
         X7wuV1CmuUzmcU3r4p1yqiWcQl3OKy8/aIf5HhjfNBuXWmgUSutHryleL+FULL5ydkPg
         NOrK/qQcyCjjDnixsV3haOsLy/Htoc0oFbq0CtDTiPie1yeBG19ruivb41IrwwQCGzIK
         aT7DAWJwBgBynVGklMu1vcGPK9DoHK3kRyzCvy7fJQ1/kyYNS03RBrEE4Olk5ua4rRm7
         eXtoAAn/+e/GPcrhiqo4OGHxcaHp7OirSY50qeNVR9H+8td58Wc90nEU/oXW0obh1fh+
         UAIA==
X-Gm-Message-State: AFuF++kwcXTGBs7Ii1YMvH1X0qt9n+avlXYS/0mKOCR8f852jYTWnTiy
	RtBzxD0zXzCmLQMsa0475gDItxeTo3FwvwiB/oC9xbSW7N1zyCP/LcnEetShhhOZA4sLMkiO0xW
	pZooTCWSGbNUMfz4d/7fxmZVINTu0BkGtdpJOpoYNNzSi/JOjVh3vmdc1SQDgjGhufSk=
X-Gm-Gg: AR+sD101BAa3J9PTK89APr4V21Ju9xvfqKJD73sKJ515LPuFmr85yRDKiRVfTVl3eR3
	1Dvs7SteqYGJNoHxmST1SgiJF6s+JsfopRq0ESm25VmaAtBr0aLk9qG7bGvimDTgGVde82NkaxJ
	NO3rMO+bx3m0IMA4FSXZR42zMvCU5RvZnh72i41klLU7hrv7I8lXt7OQ4yo1s/NtcqQmvCAUKfz
	yK4jtE/Yq9UW2nGkfnpv16CUzrZ9flTivcMz9h+koUAfbXMq5J3Y9DEOQZ6e8l0/gN6teKsgq0p
	SYGLpmSQirLyCxzajIM6maZd34wiJleDHLbMrvj+koxhg/ehH/+YYBXUv3MFhJLlV5wsfEfwdJR
	CjgbTk4iHK+UHMk4=
X-Received: by 2002:a05:622a:1315:b0:51c:b900:513f with SMTP id d75a77b69052e-52df5712136mr245717461cf.10.1787565570499;
        Mon, 24 Aug 2026 02:59:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1315:b0:51c:b900:513f with SMTP id d75a77b69052e-52df5712136mr245717191cf.10.1787565570104;
        Mon, 24 Aug 2026 02:59:30 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9cbcsm1315592766b.29.2026.08.24.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:59:29 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:59:08 +0200
Subject: [PATCH net v3] net: stmmac: drop gso_enabled_types and rely on
 netdev features
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-stmmac-fix-tso6-features-v3-1-c73a7a4a0ec7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNSw6CMBAG4KuQri1ph1dx5T2Mi1Km0kSodgrRE
 O5uw8qF0c0k/zy+WRlhcEjsmK0s4OLI+SmF4pAxM+jpitz1KTMQUAslFKc4jtpw6548kq+5RR3
 ngMQb25sK27JUCCyd3wOmpZ0+swkju6Tm4Cj68NrfLXIf/ZcXySW3CjrZVG0lKjh5ovwx65vx4
 5instsLfHgSfniQvAZM0YkaO9WXX7xt296J0u4HHAEAAA==
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4NCBTYWx0ZWRfX9vfLerK3AogJ
 INd+NiReQZgnlgffvzpNRUcgMe0WEpTyAFQR2Zjgc55vuLNZJreVJ3QVsceAOkLH2l7IuJ8zYFJ
 iFF4NYowwsRNzbXX4+8uy947Vx4yLdI=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c1603 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=v9nI2CDhc2Qv1RY0d5sA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: YGLTf1ahCzM6mlgbt0Y77O9-gcRjwyDV
X-Proofpoint-GUID: YGLTf1ahCzM6mlgbt0Y77O9-gcRjwyDV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4NCBTYWx0ZWRfXybg6Iwm1hwCi
 RlkcUIEdAIetf3iezIV6uHGqGmZkHoZTxVpQ5BmwO234nY05cpHuwo12AaVFncvBLGZk1iBXYmC
 ywkUdCQHR/DwtJIKD8sfnQO4rTyP3XrCEus/ihEhhmo5sXXP1jjD+Fy2VzYp4e8MaY7EeqIVxlR
 HxeW+p875Y9gsX/nRJ65lMsPm11+FPKXhKwoXGOL9KF+Ho8m7EFuLZllgU2OxDqx1jhuz4ig/7A
 SxeEPOjCrREyNuYCLoaTVzIlkrUiih58G2IcziTsI1Qzm+fBsjey9JlelMDiV047bM7vc0C3kvf
 jVfIX7ezRnJW4+DEZxpAuumkNZ0ogR8KR7Cq5Q4AEIBNglOzlk9Nfslg8cOhIIT419Krb0k6KYf
 HsZAyoDr6TgxQOqE3Tw33m1DgGsIZX1L6Idv+2h2KZwg42/KDzhGiaApKsTIcaTQVe20l0QEYaW
 FX93IXFEsTeTMZBDv9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240084

The gso_enabled_types field is used by stmmac_xmit() to decide whether a
GSO skb should be passed to stmmac_tso_xmit(). It is updated in
stmmac_set_features() based solely on NETIF_F_TSO, so disabling IPv4
TSO while keeping IPv6 TSO (NETIF_F_TSO6) enabled zeroes the mask. As a
result IPv6 GSO frames, which the networking stack still generates since
NETIF_F_TSO6 is enabled, fall through to the non-TSO xmit path where
they are not handled.

The networking stack already manages the GSO logic: a GSO skb is only
delivered to the driver when the matching offload feature (NETIF_F_TSO,
NETIF_F_TSO6 or NETIF_F_GSO_UDP_L4) is enabled, otherwise the frame is
segmented in software before reaching ndo_start_xmit().
stmmac_features_check() also validates each GSO frame against the TSO
hardware constraints and falls back to software GSO when they are not met.

Drop the gso_enabled_types field and rely on skb_is_gso() in
stmmac_xmit() instead, which correctly routes IPv6 GSO frames to the TSO
path when NETIF_F_TSO is disabled. This also removes the data race
between stmmac_set_gso_types(), called from the feature-set path, and
the lockless read of gso_enabled_types in stmmac_xmit().

Fixes: 2e4082e4b739 ("net: stmmac: simplify GSO/TSO test in stmmac_xmit()")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Drop gso_enabled_types field and rely on the network stack to manage
  TSO/GSO logic.
- Link to v2: https://lore.kernel.org/r/20260812-stmmac-fix-tso6-features-v2-1-72c3b06eb8d4@oss.qualcomm.com

Changes in v2:
- Fix possible race between stmmac_set_gso_types() and stmmac_xmit().
- Fix fixes tag.
- Link to v1: https://lore.kernel.org/r/20260808-stmmac-fix-tso6-features-v1-1-f82b17595052@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 --
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +------------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 8ba8f03e1ce0..7582fca63741 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -265,8 +265,6 @@ struct stmmac_priv {
 	u32 rx_coal_frames[MTL_MAX_RX_QUEUES];
 
 	int hwts_tx_en;
-	/* skb_shinfo(skb)->gso_type types that we handle */
-	unsigned int gso_enabled_types;
 	bool tx_path_in_lpi_mode;
 	bool sph_active;
 	bool sph_capable;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..3a956c8b611b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4375,18 +4375,6 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
 }
 
-static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
-{
-	if (!tso) {
-		priv->gso_enabled_types = 0;
-	} else {
-		/* Manage oversized TCP frames for GMAC4 device */
-		priv->gso_enabled_types = SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
-		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
-			priv->gso_enabled_types |= SKB_GSO_UDP_L4;
-	}
-}
-
 static void stmmac_set_gso_features(struct net_device *ndev)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
@@ -4420,8 +4408,6 @@ static void stmmac_set_gso_features(struct net_device *ndev)
 	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		ndev->hw_features |= NETIF_F_GSO_UDP_L4;
 
-	stmmac_set_gso_types(priv, true);
-
 	dev_info(priv->device, "TSO feature enabled\n");
 }
 
@@ -4771,8 +4757,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
 		stmmac_stop_sw_lpi(priv);
 
-	if (skb_is_gso(skb) &&
-	    skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
+	if (skb_is_gso(skb))
 		return stmmac_tso_xmit(skb, dev);
 
 	if (priv->est && priv->est->enable &&
@@ -6206,8 +6191,6 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
-	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
-
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		priv->hw->hw_vlan_en = true;
 	else

---
base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
change-id: 20260808-stmmac-fix-tso6-features-7fdc5e9448e2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

