Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09585347505
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128958; cv=none; b=izPnYLtrGDYQsbX5EdE9dCgd9LcE/NZJ2hewzWiSSEb7idMnxpYGjxgbogm9taJoHVaEoHzLcZJSxHdZDAu/spx8qEjD6/TnNNfTPVpz8anWc3v2QnPsPbe8p7YDn5cGBbmSJJeOVazhCMKcg/dYp96xYDBy/DSsORIRzk/Zobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128958; c=relaxed/simple;
	bh=yR52cI+W3yCIKULKBSOSPmSo+h756iq8LAJZ8BdAlIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fIdU6RQZEmKXw6vv9Mt4CeDb69Ri8zkSlbME6hrNQVI0R+9VuJyF6hFpxBCL1XBnCdJaVJIKZjJ+vkPtdlH54KC8mHL4Z7eAkZcTHlLv/LnBuHwt2+drGYdCWD8vuLsSaM+3P21nHsYdQrpPS4YpcXLjITMPphT9Q+jw2DaOMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T7usJ9CJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WfJBE2so; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7usJ9CJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WfJBE2so"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7F9g368089
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zpzd2/MiJRtpjQ4xf1ctxa
	s8MJd59+RoSaXAKWCLA50=; b=T7usJ9CJOaz+Ue9qyIncfLdWpDpVKsZ+ZxFh0G
	Aic3nu0e2N/2uIZISsIuU2nQdREA998J4O2Irzg/4eWZAhdt6UQ1a4gDSiJmgH4X
	tH3Twg/M4SkZBzJtPXXVxcoW2NxMPlIc1ZckxBId0yVYj5vJ3FUt63/naxu8x3C4
	jHkdm6TjX1ZEO11O3I1VZNSJtkqeBRluanL/4REWFNsBq/QGdnhGH8eZzUUvrfmV
	mcY3FZToSy16bHIQYE2v/JE8KtgC98O/rPx+n+HHbol4fdjL957ldzhqaR3SWQJJ
	uA0le46WuLs0lGrIIG+8Yupwx8ZJ5iCcrIeEhubZFjWjJ/rw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurntbwmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:02:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33bb08e80a8so404894eec.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790128955; x=1790733755; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zpzd2/MiJRtpjQ4xf1ctxas8MJd59+RoSaXAKWCLA50=;
        b=WfJBE2soU5aF3/eZKKIocmeFxOeVB0n/ZsJtKIhVQ0eoGYx5QPwjcDaI/a7w0HkPax
         Y8eWgrpM0+K0eYqCcu39j3inwW/M9p0+5t7+Yf1jf9L2ydoykniKHigRZklszjVROwTr
         WlutDPhIthsnNL29rmrYGZe4NPRHbxGCtk05sgWyrMYv9LtMBviEXcs/y4ccm/JOWpqr
         ksaKvrbynRuuEZj2GaBNJFvXxrFxpvVe4+ygaKCOcNXKjvv1Tta40ue12e0+R8spmzul
         bmPFioPdTKB6DrLCc4kyoXhGXCKa2JXKJLwsrW67vLYQaZxoYmY/5lTQMk3YKkbUZ30x
         Gb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790128955; x=1790733755;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Zpzd2/MiJRtpjQ4xf1ctxas8MJd59+RoSaXAKWCLA50=;
        b=0AozvNA7dvWrOHyu1XEeP2UTxYC8tmxLBU2V27Y2Qy6BV806f9gSUChDj8qGs2pkEg
         /vGJlvXxRxAlYYfaAblpy5UsVCYgZPq2m6nOdiA5AwpQxxQB9y3dr67ecP6V5DwttiCc
         0lT54PwlVimrZS24QaGMsqUb8upWHWphAHO1w6NrqDUuUP5wMhM8hM7mte178vAbigZB
         k8N/bsjiTR4th7IyZMiazg8tXCdP168TJ6Ks4WxaajAYVjf57xAmgLamY7VGIX6+hpVd
         pJbNAd491P6NXy5EypeJdqueCUGJfhqfocZPwfj5Fa1oh8xnYaQ/CgCe2dN1MY6TgkVG
         uhtw==
X-Gm-Message-State: AFuF++klcRjYm6mG3a0HdI9K81httg+2jUN8s9N2jy2R0hebtnGf6fgb
	f2uPIa1HD6LVFBPBsD36mTqjX+ReRTbeibK8xh7/fYfjkd34gS/nR7iBtRoxQWN/1phbj57V1MP
	8u2QvuE/G0uCZvvEndyXdkVtkGtjZzEBYQJAdhZXYGfZmnhpIUt49b/pdDLA=
X-Gm-Gg: AYBFou3DsJT26ybdh8RO+PLo20GpoQomv6VAXsAqEsSuutKL5D6lnMM+12Ex+wlOPAG
	hnzYRdBLBHSD0KdFVkU8JzqwZHUaZAglqtzl09mq24qSVGF/JhlhkfEeT2a9fILNs/a4cJcy9Pv
	B9XZD20jcRo6P79cYcGiLEvkXRkXoHz8VsVgfnLwVDDQSI9qXhMvEr35pP8qSGdkaBzR+PEVpez
	YVxBAJm7RErMAUIJRwkKAGTP+zrf3db7Wo/1qCOybI1K69OfQjMGzmQtNUaIfdRm1xPxqkHrlj4
	M+IfY96L9UWBQBBdB32nLLq/xMf1zc7yjQmB6tdV3WZTYqyfA+Cm29Ar+mp4dmDxAUkKtczTS0c
	bdFYbOUWJKTMF7loYfDD8dXzguLxL2/tapyUxVlZdog79O886yjXLEjz5fAY=
X-Received: by 2002:a05:693c:8005:b0:33c:3994:60d7 with SMTP id 5a478bee46e88-33e5cad2586mr1415924eec.20.1790128955268;
        Tue, 22 Sep 2026 19:02:35 -0700 (PDT)
X-Received: by 2002:a05:693c:8005:b0:33c:3994:60d7 with SMTP id 5a478bee46e88-33e5cad2586mr1415885eec.20.1790128954656;
        Tue, 22 Sep 2026 19:02:34 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e97236754sm1745366eec.29.2026.09.22.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:02:34 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 10:02:29 +0800
Subject: [PATCH] net: phy: aquantia: AQR113c fix up PMA capabilities
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADQzs2oC/yXNQQrCMBCF4auUWTuQVGgaryIuksloRzTGJIql9
 O6Nuvzg8b8FCmfhAodugcxvKfKIDXrXAU0uXhglNEOv+kFZbTByxTTN6J5Z6z3hWT6Y7g7JJef
 lJnXGYIIayZMdjYUWSpnb6ndyPP1dXv7KVL9lWNcNuUo6tYYAAAA=
X-Change-ID: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790128951; l=1712;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=yR52cI+W3yCIKULKBSOSPmSo+h756iq8LAJZ8BdAlIA=;
 b=MY8iws+HYRWUzveGEpO22VbtMy+gFLK3dVi7fTQ0dpWI+9WSK9LqJYHU5K3VxOkvVRqmzWkKK
 lRz1BQOolyyAwlN/PFDCJI/6bv429bsWOksqTcPr5T6LngzilTyVrsw
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-ORIG-GUID: swWIhihfnocdAc6LquorUTv5DWywyOyh
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab3333c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ifKEyN3FPcZ-MFGMvG8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNyBTYWx0ZWRfX393fhMSqwb9m
 5rf+w6ARgCmIuxM+6o6f9jxm8MQJgqm7PVkGO0E4pbNFX3H5bqOnkEub6sVCo/ufGTr2jo5ycQY
 j3MwtXysGh5H7uMf0RggL1WxoLpWcU3letQn3iueE0xfxfIdz7/G7a50IaGDikf4zQGG+5fD/7G
 UI2Na3OtLiIrgw1qH7/txAP/PPa9UPaWLIOj+8oBHpQE3hDun2C0bM6RXvNy3eglMSXxy+ahlfN
 vHo6nqyNtluHYQEgDJ1gIG5ueXAqMxoPCPw5hVqYbj2TNBZbAJKgKwRtqXUC1RUQoL6FPLGDuUy
 axxIDnNE+oAW3g5UV7YA/EQlpfASSnlkSPHXe4GcZXavyqcLTl4PlHEEFXldDXCztJ0D5sgN2/2
 eLLzUNl2cAQwP82DS/UJPrv5muhW3KWeanuzlrk/ryoNSMoDjbcWOFePzCDI78SdBWi4ry7o7yv
 JselubiBRFF56E9/zDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNyBTYWx0ZWRfX3v/rTmBomopW
 gzpUBwetB3rg8lpAixhwwR4zEN+Up1OvmHh4qaP0EGzoEipQum5auA3whQZjwumA5D7LkTxTzo4
 YprHsqyo/tgW6WTvFsgHvLb1Dccx33I=
X-Proofpoint-GUID: swWIhihfnocdAc6LquorUTv5DWywyOyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230007

AQR113c does not report few of the supported PMA
capabilities which includes speeds like 10G/5G/2.5G,
add get features support within aquantia driver to fix
the same.

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..604f5492515d 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1094,6 +1094,18 @@ static int aqr111_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_get_features(struct phy_device *phydev)
+{
+	/* Generic C45 PMA abilities do not fully describe the PHY's copper
+	 * autonegotiation modes, so add the 10G mode explicitly.
+	 */
+	aqr111_get_features(phydev);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported);
+
+	return 0;
+}
+
 static int aqr_gen4_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
@@ -1444,6 +1456,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr113c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,

---
base-commit: 063510768490d85454a99b27be303aad5efdf624
change-id: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

