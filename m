Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252871;
	b=xRLRjSFEmc0pr0MPphsH6XbUZ3pfZSofOEBpK8FJVVcOn5B82NyD6KW2Ykx96meiES/U
	 S977ibwn/hSPMc4SJEL8wOgVA06Kxk0603CurVpdZ6du4gAB5WDWBlb6fEcpp2C712HiA
	 QaTxmYrsURCUkN9f4a2P3Fr94HUIqUujRmTdFZEg88qC7JbNC4Uv8WSOuT7JA7tfI6SXN
	 CArC9n+8yA8jhQDknHPTKyiq2HU7Ew7fuRA4ttxe+d5zsppnlkyMMFnl/dw0y/+s9Gffv
	 ssgtzxjvb8XOT7Vee3WvIe2g5JbmJME5s5iLu5Mzi4JegDYrQeF5Qs3qeOUCNWfivXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252871;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aQL4EicGq6alzodv4b1ZZDnu/EvQ8TEvCv3eygcBvA0=;
	b=ItjS0E4c2rebLPeWbJhJMWX+SMjv4LYFzSH2OJMLOhWXEajDE2zac6GKy9QgkCJO5lqW
	 7Wm8LlGz0OGks3RNDykki+kR9YaaS6R2SDmKtUHTV8sUSCZQLwo+3+oZ0hV1mP1CnV/PJ
	 9wsCy4XQmv1LYVrEnkA11PddTLJ0cHAmlvvS1tLdC/CVz9Jx+2cJPjlO0WmLdXmSIj1nd
	 HFthpgRaToRNLGKh4fSg3QieMDVE0iJaU8UuM2JQyvxjo6vAq8y61v3nK7k7ubY39UeG9
	 e8olgpMpHPDElxE4gFiW7ZPbR1jfxKDqqmPaGYfzInv3nt6JxxOT5jUIodDwBhgk5gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GfTmYG+N;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XTJBZpQc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7E606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E7E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GfTmYG+N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XTJBZpQc
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5GmQI204330
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aQL4EicGq6alzodv4b1ZZD
	nu/EvQ8TEvCv3eygcBvA0=; b=GfTmYG+NrkeYIclWf6ilLtiCfVN9vn4+RM1wGK
	6N6ulbua5F06dW36LVJgA+1o8CzUHH65TdmzC5PRttJyv3i7n2rqTf6iD0ZETW57
	Xx3U5vzTS8PGN1m26JinJBh1K0MzZzcFb0tmpMdN2HCmcnSEr2/WkWub/3ihAY4t
	Mq7lmQAwVru8rUTRxHOwR0+IuvUN/4tHgD7pG/X1nRA3CPdOfNcA8uH+5XM/+G11
	0U/vLFAJcrBt+9JO5gZIuYtEgR1kZSROcJK8fHTF3pxq8psvHZ1UCSr45nlz8wvP
	YGQZ6XzxeU+Wu4U6tGb9DoqW4W4TTXdbXvsF7wAa8KjMFbJQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneutdgx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:47:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adcb81f487so2725041a91.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793252868; x=1793857668; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aQL4EicGq6alzodv4b1ZZDnu/EvQ8TEvCv3eygcBvA0=;
        b=XTJBZpQc+CRnlhiRy8UDtNoIQ09+ZH/OG8MD9YzdOrGdUVUY6xUQoCcYhX93b8tKET
         WJe9Vr6228SmMYpTmOmSe89f4IsOV+9zKo+9w97zp7SpwfcvmNfPDL6oyX2em2c45VIz
         yjQtCJLJKsIbvuXlaVoJpgcMK/VU/yWrUZ42FssnxnYJiJjPXllABMXDExeBxGxovsKO
         hacrNB6Vyo+4XlY0KaHW2jwbJxtNVVup2PV+9sfkECvnbOZYj+LlHDY6g6nUKHmIB94w
         seyQ+o3qvA30VpofbG0/VpT6RGjLBRk/aonkgNx1CNrOyuQNLpxaMO2E6jTYP8vqmvVL
         8bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252868; x=1793857668;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aQL4EicGq6alzodv4b1ZZDnu/EvQ8TEvCv3eygcBvA0=;
        b=c4E0FaQYGvfBcAX9cbqeZta1TnM4W3qvyndliIHILIfUDn6RehVbyUPPPP1pn6bFzb
         jJss1jSCtIS2nnIU/58ZsOmLNQYIaYRciU3t6LAYvCnOe2RnqoK2+EFM0rhlGr6r5kr9
         tENgHi6HOdenkhaXYa7YFFodkR6elp8JtPYzbu14Vzo7CAwNvMN8SccnYBydHvcA3EU2
         AZaQ6eSC2D3eQcJRBJhS/t/7RRSd1P11CoXRxvrV6cNwoU3xvWbCH1fhcBcpwBSvw72X
         6QPUWlRwrxzuSE5YR2nfPIziBVI8GfcwYhtapEAhhk5BXzncEgx5WOdI1aKcBbmJu1JM
         QOsA==
X-Gm-Message-State: AFq9FYI9Kzw4Tu6l7hEUCC18TH3gFHwraTIuuvV5t5tI/B4RK4ZdLkvo
	wMBHzOcdQtfAPCBnuxXjP4kSSRXTW3geODGCLHADJRH+kLE5mMSfpeWGKnG/9BL4zb1FCmcsaM4
	rw+2ZETKJh2fLzFF+EizBDETOgSWIBqz9kUmj3WMrKczo0uar+bU12AF36ZarDl+oCyI=
X-Gm-Gg: AYBFou0gfIQlx+l51zdxf/5d+VKMLVrwCMQvMwL41GdF+KSrk2VlDk5nJIH08yxhse/
	wqJvfkjTyquqxqajHh6N9RSJeO0dvGkW5DlITgLIQHFcvWbjcASNuJWPh1u02dZUCPerulUvJzC
	UCVrkXhsWPJK7wrr2eW9+b0d97l2JT2huPtpX/lFyUc2x+or2oNYRa1z/6oBVqgNg9S4WTtIbfD
	26idzAyXgdENtwaWrVEjevHYdl3hRvycLKv5+s+FXLjQbxnenkWNrQL/3hsdKDT+gLkWpNNDj8i
	ERL5wZhPiOThsmV/y4dPs5MpOYn0YeFtvsi61XaCuLvRcjneJlgXcNvr7QGhPa8NLj8gU/Z9IwK
	Jeds/mFkaZPutcMaLVPnqXO8Zw7EXBVzSg7yVzIxlQ3wz4iedhhRCJ2aY+ZIpjr8igl6V5NCuKT
	69wb66C6bdt+vVvdlu7QdiHakaPcfYCIPA
X-Received: by 2002:a17:90b:3c8f:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3ae5832091bmr3853149a91.61.1793252868276;
        Wed, 28 Oct 2026 22:47:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8f:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3ae5832091bmr3853140a91.61.1793252867822;
        Wed, 28 Oct 2026 22:47:47 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ac746sm2419141a91.1.2026.10.28.22.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:47:47 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 13:47:41 +0800
Subject: [PATCH net-next v3] net: phy: aquantia: Add support for 5GbaseR
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
Message-Id: <20261029-aquantia-support-5gbaser-v3-1-f1f9346553d0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPzd4moC/42OzQ6CMBCEX4X0bAltQagn38N46M8CNdpiWwiG8
 O4WvJroZZPJznwzCwrgDQR0yhbkYTLBOJsEO2RI9cJ2gI1OGtGCHgtOGRbPUdhoBA7jMDgfcdV
 JkSAYaloTqYG3DUcpPnhozbyjL8hCxBbmiK6fTxjlDVTcyJu3NyE6/9pXTGRP/C6cCCa4YrVmX
 MpGsersQsiT+67c45Gns7dN9F8eTbxS1w3XipKSNF9467q+ATEww9wzAQAA
X-Change-ID: 20260923-aquantia-support-5gbaser-e7271bde9f89
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793252864; l=3752;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=oSCOzNQKtZlS/9NWiCfaP2XeMMAzavYIrT1WQCBspgw=;
 b=LR3/PRYXfTU5BpG4rw4s1uMi52naf05m04Rqw5kV8/sYUVFN/B/b7xRQgFO57xQJgqji5N++2
 moD76OgCzT0D3qBaasYfyU0y/qJsY9+D7zw8O+wqyk84P/IydZfr2Gl
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX4RuGQN11cB0a
 87J1MAJIWdjysWNMeXJTzaM9/DH6+DL4u3obRyR5mBxLDablcJx8NuYo7q8fYZcNQQmmcr1PwKh
 ioSQfQtwbzHnta0gvLodHbkA2sRSGixdVMey2tBJOFc+rqianJQ4ObAt+/7oLVtm+LPhD6EG7+H
 ZL5QKu53EjAfRQUMs6kfoZfpfMDffdNvMQZvPwynV39XVTrFAbhSjkE+Pq1PFRgAJXzpELGQqzx
 j9pkucr3siLWRR9pRhD9iRIOMyrXpdsJnd4AMQqX0Y8tOzQbV1cdKXBqf+8GAqBhtWaRqlaQX3v
 HRoX2CkJlM0FF+RQYQtEfOM9o0nWXLNcY0Lo2uJ227L+/jI89xaDwAEduzmT0BxC/v8fVsjdvqd
 Ozz4X6gsrT9tuw+TDGOhCddHdzFnpYfi+If3O39aeS4JEbQIyTNWKO6LwJlmgG4EKvHevJS9Zrj
 mAJpGyZp+1bGxXqqZOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX7CZB6PpA+WqC
 HYm8UoMmVWL+K1GNnHMQTvYAoStvV3H3an8crYYpgLQ9ahyGyyeq3FECnQ0dV2SOXsLN9bJUmsd
 lYTCPMdbmxdNCLd7/tzUrHUP1jpmRLA=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae2de05 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=bEtV3SpGoilhSLS3K0MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: RScOHjw9G2DXmizbeTc6mJG3J0aGVCP-
X-Proofpoint-ORIG-GUID: RScOHjw9G2DXmizbeTc6mJG3J0aGVCP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290021

Aquantia PHYs can operate with a 5G USX interface between the PHY
and MAC, reported as interface type 12 in the PHYXS vendor interface
status register (MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G).

Without this change, aqr_gen1_read_status() falls through to the
default case and sets phydev->link = false when the interface type
is USX 5G, preventing 5G links from coming up.

Add the missing PHY_INTERFACE_MODE_5GBASER handling in three places:

- aqr_gen1_read_status(): map USX 5G interface type to
  PHY_INTERFACE_MODE_5GBASER so the link is correctly reported
- aqr_gen1_config_init(): accept PHY_INTERFACE_MODE_5GBASER as a
  valid interface mode, otherwise the PHY is rejected with -ENODEV
- aqr_gen2_get_rate_matching(): return RATE_MATCH_PAUSE for
  PHY_INTERFACE_MODE_5GBASER, consistent with 10GBASER and 2500BASEX,
  since the MAC-side interface runs at a fixed rate and the PHY handles
  rate adaptation via pause frames

Co-developed-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Signed-off-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
Changes in v3:
- Add git tree name net-next to the subject line. [PATCH net-next]
- Add Co-developer
- Link to v2: https://patch.msgid.link/20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com

Changes in v2:
- Fix the local variable assignment error in API: aqr_gen1_read_status,
  should use interface rather than phydev->interface,
  interface = PHY_INTERFACE_MODE_5GBASER.
- Link to v1: https://patch.msgid.link/20260923-aquantia-support-5gbaser-v1-1-537d39bb8c35@oss.qualcomm.com
---
 drivers/net/phy/aquantia/aquantia_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..1e3df47365e4 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -49,6 +49,7 @@
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF	9
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
+#define MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G	12
 
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

