Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346714;
	b=ymyTSD/XaVXM0gRpQdHE71Vt/5GU3NDBlj0//iLMBrgpuYrw3HeWCOviyhkRYcoWLsnt
	 HryAW2x8DNQvSc+cmGbYJEX7AWrQvHf4PahBPW3kXBOYyF2ptRw+r0xdh+ylLQxAUZpUY
	 8jJQgB/D08e9OYYds1Jx0BJ64YrOdtklplbJq69M1H4CZGOgE3oVvIcTra2bG+fuJp4uV
	 QlSvZLbinp25g1u4zbUy9m5Zz/X3hovoGgSip3cS4tIdQSO72nJZFxZdAIioquCvEz9vV
	 Y+hCO6GJM+Z/GNTlJGc2DqIQdq4ypK05s9M8xson8Tv83pSGKCJuutxl9fxs87d880g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346714;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+2EtztaLud2IzUZ+lbv0E3lQlpb4tzuYE5ybIQ9MuL4=;
	b=wMQFp2MdyLsTD/8dSIcTMkMxwNBKi5pX4SAe2qIaRwEQC44TSo0wf6CQlr+TZ4V0PASg
	 WtlhMqzw+2+p6uTDKKPLMSDwd+GSOpqLhHrYpI/TxhS6nHtKOfAsqb+GvioL9UoMMidQU
	 sDxYALGWDcax8tjQnWMehZ57HxKOlbhdHQMQt1JEr8ktq+dsr1kONgyp72P9sLdBXZVMb
	 Ba2OJ/Nz+h14fkqpnQXIPzWNvpzyAj9p+BoAGuWJxF7/SjJpYj03rdoBcpbfrjtrgtJfj
	 xnSpcoiJLxnDoweCclxKckSFejdSWVpsWJIrxhtqkP1Se2lWG6bORKAQ6VsTHRIYUmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="mVOQ+/5I";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="QA1D/Bph";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1396606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1396606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mVOQ+/5I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QA1D/Bph
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U5F7bm725327
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+2EtztaLud2IzUZ+lbv0E3
	lQlpb4tzuYE5ybIQ9MuL4=; b=mVOQ+/5IkDmkp6mRBTEFtMCR0fwykXqEH6DXSG
	a/lzP6FCFZVUzzW3sq2aSKs6yJysgxskMf+0uQ43XqZhSHlD7Hmtlz4olu1a1kI+
	S8WKHRtDPNoevchr6J36gTnN4rjybRsjF43iP+Fyf93w1kMM4rq9IFm569jWQALG
	pY8GXZuecObKzJ4mZmOEzpA1ECSUeQzju0sNo44fhqkPgzfhoulNVV/r+7Bec/4T
	dIY1WfY177q5wsjEczDyNBldC4zgszibayH9be59GIkgpZTYvZ8MfOrD3KXN9aNK
	5a8/kMDv6gzTwLpLpTZFLFUGOw2KYIVr1qDsV9FM1x5Cuu7Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6phttu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:51:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-189d17eca17so413057c88.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793346712; x=1793951512; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+2EtztaLud2IzUZ+lbv0E3lQlpb4tzuYE5ybIQ9MuL4=;
        b=QA1D/BphWnOtecACxvVMVG9Q9AXhQzacZvWbE69v8R+ACZpGX0j96wos9Ncph/REvF
         /riEaQAkVthHjmJ/BfxPZNPCg+mCYZ0etRIh/gy58XAQAz4OLlJ4OEPTWBt6ZTxw4VfS
         qLB2v+/RkS3JbyOC4znC3oj+LzUZGWREXe61DRHyohc3/sa2kQZK6KBkqUD5pOz+pW0h
         IOzfrlUmJ7Rg9yx4HFchOVe2VVdD3XjR0Ska99Qje/TDMrlGXNikfmTa4jxtKNwQKOd2
         KJjttd1IlDyCdmlLkZEzPYrtM3imPwUUL/YXYNOX+hS5ftYkOWsL5qsr1WlDUTnjJdGp
         N5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793346712; x=1793951512;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+2EtztaLud2IzUZ+lbv0E3lQlpb4tzuYE5ybIQ9MuL4=;
        b=ZUfCqpQKZ9+aQssQsEFm1fETa6VvxZKIvhLg3xCXS1k0yRIn8W+wPwKEqC1x0S4i0v
         soh4If8cuqWWjJWGMNmrCmNnZUkrazTGu2XjpxxlD22YXZ8/O/Mk9Rk5e/bhLD/dmjIw
         r0kuNpWEbPLJNjpSaoRK6e7YtVg8EpLDQniQ66CbFv8ZvTeV5DsnXMkgBmALvsKmSXCE
         T1dt4+LdTyLFEzF/wcfdM1+MldWhx6+1GjlGzizLvhF2dUqib+DnJqTkYknFa40K7Ju9
         QssgKYMFNCis/IzqQ3um44KHQsuGvqBkogwVk+lfDpChswmkKR3G2xScUHXSwyjUukmF
         0l9w==
X-Gm-Message-State: AFq9FYKKgnE9kPW6Q3Hjf8PsOHkwxShArZrMli8t7b1iuXawxmbYOVyg
	r3j3o0Bxhpf8u93YtRjI5gtJnbJMfZqNXPQAmoTat6WZPC2hBbGRLA6LUnXz3ym2fTsbIMgxs/d
	uMv0yjb0e5a+4fZh/3NZ7vf0N9+xIFMJLiCGdaERxN46hhsTBouer45hPFPU=
X-Gm-Gg: AYBFou1eEwYuwZBROK9xYTUpxklh1zQkw5UKe5FKFoAwRou/iplBYnFvBy4d4H29wrc
	+ZaxCRYMJqzPszWjNRPAPTIu9cLg6j4GCV9kkViz8IX8A5G7HZeLNVFvFJ7Adq+VruCz9C0cRTM
	v61G/HsckVFfVkDcrXIFkUy9NVWs7vQrRHpfBbzUnOkg5NipRG4pel84peX3F3L4EId9ZRq1wU2
	2r3ILNlMXDVxU0eUJM/sQl81l0HOp7SItYnol2QY1mXSCy2VSseia4Loz/nmtkPtz0AfNrtugBN
	VOAJtmooxXgws83tDP5WdR7OjpVqZF6lIBgJKY9azVSE7LbbTaIEcP+hR6M6JXBJGwd6TMZFMpe
	0PXTBl8V1qWNMadtTMLsWz2LruviuI9smgtXi5x9D1DTSOTf7/OJucGltiZQfI4Hbuq9iA89nTI
	RqTXg8P4ro6Z7lw66DTCPzeXYy1JK6bkQ5
X-Received: by 2002:a05:7022:b047:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1ac5e6f4e87mr2276911c88.46.1793346711845;
        Fri, 30 Oct 2026 00:51:51 -0700 (PDT)
X-Received: by 2002:a05:7022:b047:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1ac5e6f4e87mr2276864c88.46.1793346711105;
        Fri, 30 Oct 2026 00:51:51 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm5670791c88.11.2026.10.30.00.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:51:50 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:51:42 +0800
Subject: [PATCH net-next v4] net: phy: aquantia: Add support for 5GbaseR
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
Message-Id: <20261030-aquantia-support-5gbaser-v4-1-7dfb0cf306de@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI1M5GoC/43OSw7CIBAG4KsY1mIKlLa48h7GBY9pxShUoI3G9
 O5iTVz52kzyZ2a+mRuKECxEtF7cUIDRRutdDuVygfReug6wNTkjWtCqEJRheR6kS1biOPS9Dwn
 zTsmMYKhpTZQB0TYC5fU+QGsvM71FDhJ2cElo9+zEQR1Ap4f8mN3bmHy4zl+MZN74fXAkmGDOa
 sOEUo1mfONjXOXpo/an0yqX+dpI//Vo9kpTN8JoSkrSfPDYyyMFFV88lr2WtIKVFefMFG+8aZr
 u9scWVYMBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793346708; l=3950;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=+MK+tPcBQCfj27wF095lR2jy4Qy+rnqWGg/co78Ru1g=;
 b=tTKRTjuqNKcej3ryTbrkmweskkCPh7rJtoZOZ+HUlzOj7Qlnu8BCWDho5i17zt3G4Unj7UisL
 DseNJM/CnI1ApwHRq1vJK+3eZ0mjOjKyGAkGzevUImA75aFJXKJG+WN
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzMSBTYWx0ZWRfX2hSD/mZUM4gT
 ID08adQq/mXCyboYDX9TDt/bgfsPizt5y9jYTnpprZ3Bi1FswV16nXEVtig+aj/Tq/nSBLKzHSS
 55B/wc+oXbsxQ6+sc1EWdB7xETbgUYDD9KvsC8czKnFckp0Q9twq0XYsAQH2zQq/j+t11lFCKYK
 KkSbz20r1R8fV8p3QrP98xRjxxeH8ToHZbgXZJCny5Z0x+MzFF6uPdAq/Ihg5L9dMU6a6xCCNXX
 u+9HVHpsuMEl4wZnihjAV+7HWFQSh1KrILPeVS2/0yFpUFBrEHSJSVJN9cUS+m1U7gcnfVSCLBf
 EAbe0Idkya1OazkPJrRjxDHTmCmdq8uabDPxGgUWflk0dutIF8Om0SE73hKJdAwfO1DK9/+SAKe
 Umi6P3yVFA4uxAjb9t6ho8K0GiN6CFIdpHhhQTIcWq0skTDS4x+/K74jCvJE2mKddk1xJYoqmoh
 APodLTmk/8soBCD5N2Q==
X-Proofpoint-ORIG-GUID: amuAg4GCF_NbsLYdv1ZVYXNV8djBFshZ
X-Proofpoint-GUID: amuAg4GCF_NbsLYdv1ZVYXNV8djBFshZ
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae44c98 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=xUtIZhO9L1281Tkm8lsA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzMSBTYWx0ZWRfX5Fjgam4plhug
 H5tvZ0EkXBR5F3A6CUTnzsaDS6MlZtw+eSr8+kFZExQAUlwTvLRhPmxyY//DB+W+yxXG8nC2JCQ
 9oeeb6EL0tWXFfLRCxg856cjnVAE3kc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300031

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
Changes in v4:
- Keep interface modes sorted by speed in aqr_gen1_config_init()
- Keep rate matching conditions sorted by speed (10G, 5G, 2.5G)
- Link to v3: https://patch.msgid.link/20261029-aquantia-support-5gbaser-v3-1-f1f9346553d0@oss.qualcomm.com

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
 drivers/net/phy/aquantia/aquantia_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..dffc81b9eb52 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -49,6 +49,7 @@
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF	9
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
+#define MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G	12
 
 #define MDIO_AN_VEND_PROV			0xc400
 #define MDIO_AN_VEND_PROV_1000BASET_FULL	BIT(15)
@@ -582,6 +583,9 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI:
 		interface = PHY_INTERFACE_MODE_RXAUI;
 		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G:
+		interface = PHY_INTERFACE_MODE_5GBASER;
+		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
 		interface = PHY_INTERFACE_MODE_2500BASEX;
 		break;
@@ -782,6 +786,7 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
 	    phydev->interface != PHY_INTERFACE_MODE_USXGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_5GBASER &&
 	    phydev->interface != PHY_INTERFACE_MODE_10G_QXGMII &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GBASER &&
@@ -1040,6 +1045,7 @@ static int aqr_gen2_get_rate_matching(struct phy_device *phydev,
 				      phy_interface_t iface)
 {
 	if (iface == PHY_INTERFACE_MODE_10GBASER ||
+	    iface == PHY_INTERFACE_MODE_5GBASER ||
 	    iface == PHY_INTERFACE_MODE_2500BASEX)
 		return RATE_MATCH_PAUSE;
 	return RATE_MATCH_NONE;

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260923-aquantia-support-5gbaser-e7271bde9f89

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

