Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD02471400
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151884; cv=none; b=HcSfW76UoXccv+wDW6sNEKKpC6b802H3KLSXS3excusQL8dszLgO5MIZwwNIn5tISxl1pKe2rxw3Yabn2NGGuqEILS+8RlNUcQ68fUjDRGkyyColBcG82Wo9aQbEZJ8gxKfg66pbniUTkhcXBcEg5GhDlymAX2Yp/yNR25+dXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151884; c=relaxed/simple;
	bh=jzd33LVj47mWl9pVPPMzl/xI1CbS4cXQuMHq5iLNkKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nEMIsCcSgB3Hiqd1MtdxaEXvDlzot3wb61ffIDjXdZ5fC9/V0hYNx1afbs/vKnis9d6SJxmHkWQvO5SvSv5oVuDS3mbvL8crspZywkLC8MiTYBjTEgAc0O3LITWD/reGeQX9MeOwzEfbSunWDPh3qFnqfGD7QN9nU9tRbWa8f+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G5rLqrTr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJnuNjA5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5rLqrTr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJnuNjA5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8JkFn2975693
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uzoEP2p4qzcZlCTTK8fJcd
	zZzalvcNrfu9vrZl27VqE=; b=G5rLqrTrYwRprBdkrWs6+B9B9HkVhvJn5Rq1Ia
	c1laLcrM/7UMxIivle4BSRCrIJoQiCxWz/jRKemL3sYyuqRHgAxDY+bPYmM7OU4T
	oVofx9KThOOwiCPIyy6NY+eUKVwgm2JSh2NUfJ2r7yEH10BXVdXiTckBU5oOc7t1
	D1Rt7eUNiQsorcEJ7sqapsUQLBwjwoTS2iqrKnYmbLDM9OUprbh/LHGjIXisCu5L
	N+S/CYGOIH17i62NC5ryGuZQfb5BOshhhD6lb5P14Nr1s29uF58YHFqxBu/csPsv
	DHoKEJJIVkSZKwO0RNaLojp+Yf8L/ShBmrkDtHS4M6aVu3vw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n0y5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:24:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33310847fcaso1156244eec.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790151875; x=1790756675; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uzoEP2p4qzcZlCTTK8fJcdzZzalvcNrfu9vrZl27VqE=;
        b=RJnuNjA5Hg1ls2aChUmiHpX0/zj1AMCMidxOlUi+VIDZFyFnTmdJzG10xweZCqnmUL
         LPIghTv8Ni7/oNQIsZthTBViL608m9AtUrK3DnuiXDRpB+ks4lVMRYsmlYGJLzrtc98L
         NoJsQ9LlDOi12Kw9lvE3s6Jysp3+BWeTjNHcKZ0M4sn3M9EvFuJ4TfYQPJYZ6IdvxZs4
         YsxhXaHieqAKJWEn7VSbFzkvAB8eaBkDxCabS7LoCW3HH8IrB02ntbF480cNP7GIX+Cp
         mzw23l2XptWuYwwtevhn6OwecKy0pKS+pstvUvKeCOc4g6Xhy4BkmGms2EAU/LFtygYr
         jZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151875; x=1790756675;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uzoEP2p4qzcZlCTTK8fJcdzZzalvcNrfu9vrZl27VqE=;
        b=kaLFOmd3iXvB4h/3Qmnz5maRqyUxvnHYPKIb4epoiPESXIMjsIIYzt+9cGm8izXNvW
         E9LtHZT9kRMVISpmC0b7fz556aRkC51dUlpYoFni3FX0mtYKUkpLnf2Ip6fsOtq1q4DB
         niOMrYztLzBP8pIWplfEkOxAz+J8zU2vX2uEXhdo9tk6+P+SdJetcl6q7gjLJ4eDRV7g
         3j1F7lC+bbcjmN28dIN/oVbjBGJ4mBzsrQdO8WLOtQwBtwIEvJXuCUR+jqpLdgShQTuI
         o4xbYk9LPaou+lKOsn+4w2ZNfGEyj/qwEStULK6N6FbXR3vEqYafOsHqHz1UZ3Hs+l8/
         8o9A==
X-Gm-Message-State: AFuF++nz6G7UXvg18nebxQ/pQlAzXR/GdMMneeSZP1r3qa9XYQ33jWBE
	VlzJpJfYC1yqGWhTo58fRtv7Mzb3Lzz/OB7TkBJtdANqDG0uG0eZd1brAFWc+cuv8G71iT3MGIz
	f4h3sm5nMjTXKD4u4aIeMkOQHXrhbaqE52tD4vKC/ug46rgnV8TlnuB6NKr8=
X-Gm-Gg: AYBFou0I6MZiPdc+lfNy+Z2WXwVsq0GRrlJx/nha8//1j3jU67O23UhNdwsO9cs7HTR
	BivfRlLM9MNzWNrt54qrjWlRKZtT5yKv61jffC1Py+q/K+dF5J02L8fG7j+AGlnRaMmEmzuUvNf
	MIP7EbN1GI4HPSsY43a1raK7bNJ5Zk6G8SYzopAXvN0atbMWAn4jdLJH7c/7/EBnYgVw/ENhEAI
	f3VC3Bi4HqCsYEh+2/ssUxh/T96Wk14JUqvjRkLX1jdOkCIBjG8nbKcIhFsqiHmAUzM5frd3Jbz
	o8lBfFOa5SuD13LdRnQm7/yH36w5FMkxztHTmyiqzdRYv4YpmwJP7fMImXrYcr69si4qGtumeCa
	hs0okSIGmU8PtijNuC2lMvcaK49K9ZHNGT8KY7+3WE3DMgmTJu6fdAt6DmVM=
X-Received: by 2002:a05:693c:2518:b0:339:794b:c068 with SMTP id 5a478bee46e88-33e8e6a0a3amr1950223eec.40.1790151874613;
        Wed, 23 Sep 2026 01:24:34 -0700 (PDT)
X-Received: by 2002:a05:693c:2518:b0:339:794b:c068 with SMTP id 5a478bee46e88-33e8e6a0a3amr1950188eec.40.1790151873837;
        Wed, 23 Sep 2026 01:24:33 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96946d0csm4859652eec.21.2026.09.23.01.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:24:33 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:24:24 +0800
Subject: [PATCH v2] net: phy: aquantia: Add support for 5GbaseR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALeMs2oC/42NQQ6CMBBFr0K6dghtg1BX3sOwaMsANUqxU4iGc
 HcLXsDNJC958/7KCINDYpdsZQEXR86PCcQpY3bQY4/g2sRMFOJcKCFBv2Y9RqeB5mnyIULZG50
 igJWouGlRdbVi6X0K2Ln3kb41P6bZ3NHGvbcbg6Pow+fYXvju/TGzcOBQyqqVypjayvLqifJkP
 6x/PvN0WLNt2xcIz3s12QAAAA==
X-Change-ID: 20260923-aquantia-support-5gbaser-e7271bde9f89
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790151870; l=2434;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=jzd33LVj47mWl9pVPPMzl/xI1CbS4cXQuMHq5iLNkKg=;
 b=j/npe6FyuqJgX2aDH8GYzjz9Pe/aoIWlOeYwrBZo4S4VZwL/S1bfuJFbh4ASo+8i45yVS3ZRh
 h1HGcXl3SpXBBaPohyA1+r7xEioL1jIm1PV7G50QI9ZQovFFBdK1X+t
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMyBTYWx0ZWRfX3/FrVjZeLDTV
 +hHEcbCAZzeYNr6mFS58WE7XEkTgxqnhVnXTSGwJWXVqGFp2+0iZaT8SX9ZfucfMdWzLluqubwR
 gWewAvxqNMzPbiUjXNi9Nu5R9If6y0U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMyBTYWx0ZWRfXyXxIktvQFXWa
 G9fPeUqBRGnJn+C2LOFfPs+n2Zav+WSOAPmKZGgwtW/q+S6+smSqSkEVh40ZaQmn4Imx37auQ0R
 RXG9EEfRGIUFpssffgPDDEvxPEHy5lJYxFSP0UowQ1Ef6x8Ql7nMq9mm/T091CYXj3I73zn7DIk
 dWz2EQ6OP6Ix9QjDQLRF/wHRCOZ4okRjJ79b3bKvyJHVnzH2xiTgmaVjE2+Ri2HSSLIxAMbwhFF
 RTsr/Gi///9YTPL9244jpkVLEiYBCILdS4d0punscU6mquv9sZBadPAuiYKHU5+pRQ2Dkv8eZaw
 ue6t47jRyfPc9N4ceA2RlKjtNaGsjtoALRRAEX5LEblmS1ujUKYIUbRlJEYKwD0VmS3aYDhrkCW
 oFxn3YACmLzaJmjRmPxH6L5Xfq/ma9CaycCE9MaO/HWFXTVDb4xEr/OyLp++nQN4zNMS/bi3WRt
 8YN6UWfCRfWUoDXToxg==
X-Proofpoint-ORIG-GUID: 5qKVU-rAllOlYqGMYJ15SRR-rXz4Ell9
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab38cc3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=JMcY5lylPf_IzVq4k34A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 5qKVU-rAllOlYqGMYJ15SRR-rXz4Ell9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230033

Add support for 5GbaseR within Aquantia phy driver.

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260923-aquantia-support-5gbaser-v1-1-537d39bb8c35@oss.qualcomm.com
---
 drivers/net/phy/aquantia/aquantia_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..0bcec88fcf72 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -49,6 +49,7 @@
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF	9
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
+#define MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G   12
 
 #define MDIO_AN_VEND_PROV			0xc400
 #define MDIO_AN_VEND_PROV_1000BASET_FULL	BIT(15)
@@ -585,6 +586,9 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
 		interface = PHY_INTERFACE_MODE_2500BASEX;
 		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G:
+		interface = PHY_INTERFACE_MODE_5GBASER;
+		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF:
 	default:
 		phydev->link = false;
@@ -786,7 +790,8 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GBASER &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
-	    phydev->interface != PHY_INTERFACE_MODE_RXAUI)
+	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
+	    phydev->interface != PHY_INTERFACE_MODE_5GBASER)
 		return -ENODEV;
 
 	WARN(phydev->interface == PHY_INTERFACE_MODE_XGMII,
@@ -1040,7 +1045,8 @@ static int aqr_gen2_get_rate_matching(struct phy_device *phydev,
 				      phy_interface_t iface)
 {
 	if (iface == PHY_INTERFACE_MODE_10GBASER ||
-	    iface == PHY_INTERFACE_MODE_2500BASEX)
+	    iface == PHY_INTERFACE_MODE_2500BASEX ||
+	    iface == PHY_INTERFACE_MODE_5GBASER)
 		return RATE_MATCH_PAUSE;
 	return RATE_MATCH_NONE;
 }

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260923-aquantia-support-5gbaser-e7271bde9f89

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

