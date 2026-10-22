Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661597;
	b=x16sAdmPh4b2xQwevrrVZjX/1bLAUF4ixoZV3syh8iIp2ktX/RmceRq0rm40rNmA6ReP
	 C9PFMEZv5ZIhT5TuZRSBa0g7cbqHWgMh/PC/9PqcA7XXYAYjDAjV7vM/hfldS5FzRTt2m
	 u4q4SHG7qJRTOiCViEgjGq9VasGWKLvtCzbOGqgt19BjgVUdxcQ1jRVbxUOCT3U03cFQT
	 eIomW8FnoBZVFMRdx0Gl44n0Ldj17DQveRKa7yBf4CgQMMat12exss1w/5VP77nExPNbo
	 KHYJdUSn/MQda8G37Bfzi50u6QEh422GJT6OdoWiomi4GYrCxaAC8GkHWPI0JIfftKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661597;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pxeHPu72hzHe03AD6HAsRMMpCMUek2XkaAeZNt/w6uo=;
	b=Muuo1JA+pWTiS6YI+FAFRgnISfhD07JeAOiDp3I8HBNxN9aZ36D2kvCXg3Zu7IgbNGdc
	 CoI2phkB54Rky4Dwm+rO8PSPfYizn6tEDFlfqE33SyoqwFC+O0IG9MsGJR19419CkUCEu
	 0A3wRBqhVizizgxCRfhQ7j8Q83JETRkOi+v5tU3wR30rZgeSrxxTtu5W+SlBj5dM4aNlQ
	 WKp7yhI0PuQN+pApir4D4Z5Hc7sMMpqcVb2OftTGAx36bYJFpF/nSVPKLesajWlK4D2Tn
	 RCCO4g1qCvcum7jHssGOpZS28MrYBchK4ES76CZ8R7vzAzU4EH+37TglQbiVPHPatBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N2tuw6rJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="F/ZJ1WmD";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9138606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9138606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N2tuw6rJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F/ZJ1WmD
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M705941995964
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pxeHPu72hzHe03AD6HAsRM
	MpCMUek2XkaAeZNt/w6uo=; b=N2tuw6rJ949QiMqE2H+n+gni/wAapLN6ElqGp6
	ItCL6ntJn0vaZzXekJ0+7Q+JYUYSAClnGFe0uXG4MXOWXW1amqvuHpjfpOLqwLrW
	zowlLpOt3lqJqtFZYmIxAP8S9NqGaSe/h1L3MPojrWDGWvGPsPPvlc/jVyscoxM0
	LJWChkTGQqnH/l3fwC/8Yen7vHgbvpOgtw9m1KlYQldB0RJ8lOQFgIUNeR2hZ+vV
	jey2+ZR74U7vJQCMgYIOsrddC0ifFg3mFudT7BzMOJ83fjsUSVqODAC35sb44qKe
	IwGZCws0CaO9GCpGCYE6TGmoyQbkuchLPg+sznty1epwPcog==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bsp8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:33:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-155a75f91e1so701814c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792661595; x=1793266395; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pxeHPu72hzHe03AD6HAsRMMpCMUek2XkaAeZNt/w6uo=;
        b=F/ZJ1WmDwx1Y+S2HpsdcN4IrQ7pURBa+aoUmBitGKTEbBytRz41mLz1qbjEZ0V48CF
         Qp4/FeoGT3ENLmtyfC/7Aim/pLB8ODoeox/F9P3cXYgVfRwqVH2C88EjFGjLijgtwmVY
         0v/SRhDrqVcD+URCbYUkm4aBgUFtOS+UCBbHmQWGO3TZwEE13x5N4eK4LFjckPsx8KYb
         vl2EDzDtoigQE6rRZdSnbJaQT9KBpcxrM07+qIe67gCGBQrrlq2CZPkgSEao3RdGM+Uw
         qvrXfLh/oBbzkWkXLw+GhVWkb5sIyXkeV42bhf4u/UjDP2o/3/iHO5KMLaTUf9ryC9Rj
         4xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661595; x=1793266395;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pxeHPu72hzHe03AD6HAsRMMpCMUek2XkaAeZNt/w6uo=;
        b=V2KVaBvn3QyTZf/svs9yNACAQySq9Y7wlVMym4XXl52RIg7BkufzEta22eK/zLIDjP
         bpxWZGfKQm66zwfwaUo54VdznVxVw1oimGlHO0Ii/XkfWocGOulQ90jObQE9ePts2YsX
         WCPXqNDwMM3fQ3f2f/nwEIooSy7Mho0vn1ENgwKfMe6TaQhzhqY9iVr5d/dkXQkNlRjW
         itOYQ0lxosXuE+2k4Oe4DnimG5PmMrFCqOnkfXYlI70/DJwv/nmF0Y8L5oelPDHrc54f
         AT34AofotrYQm7iycK8TE52pL4YP87S7Dt7kW1CpvZI5EOaBw2XvIB/+hDpBLRoOU71W
         Zakg==
X-Gm-Message-State: AFq9FYKTGAJ68yuXhOcLHTQjBbBtnhB0H8CSAIdjNQMGs5LCYgitLl4H
	fwaJ2OKhoG5uxSEJDZWuR1uBLSEuHWOq+Jc6PSesqrzcttSRxScwnK1JWbuLHmC0WCOZr0E8QqJ
	Z2IZdK51/uQabslBnEPmU/7kqqx/Xn3l+7iueDXZABt9QLeOH6Vz0h0Fu9ik=
X-Gm-Gg: AYBFou23ePUYbh7n2Pjw8QNN5c+4w/6/HvMKpeINneIDtzLH1RU+qNBUzi3cg10+aoI
	Z90BRfSehybWpwQqBz9DeOJpWgFzyJ8eigL8ZLrfenAImWfqWps/makbwUbNi36lYtVEN+nkcU4
	0eE5P8y9z8silDmP4xvv+NbPzcB5gzgKK2SaGuJHeGDPNO5sJ4FgJ0olK+xcadNi5VwrAIdnQ3t
	Zz0N8jBLMUlqgB9F+7x2MnBu4I6zKylxzLZsf+LyiHLwz/VTSosNAAbr7iga4EuHdLQv/rabkoZ
	jmMDV//sUSfQA95mr1ylJ6OzpJg4GXRsqBO6i24PJHKTTaiaqCvfiPQNtc3hdJN9O4Ckd0vEX+R
	T3pOaymSk9MrRn4ynh4c1Eykk/8Ay42frEQX/amB+gQAe2c0RQf/5dxHShdw=
X-Received: by 2002:a05:7022:995:b0:14b:355e:2888 with SMTP id a92af1059eb24-192f5e1493dmr3047445c88.27.1792661594517;
        Thu, 22 Oct 2026 02:33:14 -0700 (PDT)
X-Received: by 2002:a05:7022:995:b0:14b:355e:2888 with SMTP id a92af1059eb24-192f5e1493dmr3047406c88.27.1792661593948;
        Thu, 22 Oct 2026 02:33:13 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25904494eec.2.2026.10.22.02.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:33:13 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Subject: [PATCH net-next v4 0/2] net: phy: aquantia: fix PMA capability
 reporting and EEE discovery
Date: Thu, 22 Oct 2026 17:33:07 +0800
Message-Id: <20261022-net-phy-aqr113c-fix-pma-capability-v4-0-95a17f75dd7a@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAFPY2WoC/42Oy47CMAxFfwVlPUZ2UtpmVvMfiEWSpjQj+iAJF
 RXqv5MWCc1ikLqxdGXfc/xgwXpnA/vePZi3owuu71LIvnbMNKo7W3BVyowjz1FSAZ2NMDQTqKs
 nEgZqd4ehVWDUoLS7uDhBVVRYGm1kWUiWQIO36WqVHNnS7+w9stNrE27615q4OJbbxoXY+2n9Z
 6S18VJzsUU9EhBkshAHKQhrzH/6EPbXm7qYvm33aazekf8lZ5vIPJG51JjzUmisxQeyeJMJKd9
 EFoCAWmvSZYbiUP1Dnuf5CViVA/erAQAA
X-Change-ID: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661591; l=2456;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=imazqWx1QzR1C8tFiACB+D5otXOIrb2gIqpGREoOoO4=;
 b=4pPpvTK3vdoAgWVvXy+AxSVSsbQm7kQUvaBE4Tin/iXlWnKDDW/ZF9CDskq1SS4r2CMJsf6Gp
 Z2ART9Ai0B6Bvn41Ir2VEaoBkEpDCdt+xLQk0RwxfdLo07yiA79YVqJ
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-GUID: 8au-kSFmunqR-TgwtICa4XqDZsSszxF6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfXxErfxHj1hdFo
 STfbIk4JpQVVY/b4zd7CcRsj6R5MANnyK+KfPBgB0m1100+9yGwURiA/JGovh98qETFtgjhZJPQ
 AJA801QcoVAUBSrX+T0capdzMUCXUOc=
X-Authority-Analysis: v=2.4 cv=F4fC5ahN c=1 sm=1 tr=0 ts=6ad9d85b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=PHq6YzTAAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=LtJoxy8KcpIoDjkYT3AA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: 8au-kSFmunqR-TgwtICa4XqDZsSszxF6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNyBTYWx0ZWRfX8A4Owtf7Y2ju
 ECBUMXKVkC5ymrb6qy2HYRbZd0uO1koKdFv4AYXRv+SSVYh+04I7ATYsUr3v+Y/ix9WOC6dH29K
 iqx7LPIL9Lz8ciTUnSIY21YDw0Vjcrt4tl2BAl1Raf7AsJqKdkiPt06VfM9E85uvOy0JVDsLNs7
 x59A3EUPq3wNcZJNZCwPZ3QBmfK3nAF3rZAO9/ZVBcKw0ayH6/o0n2B4tm+X6OhyKNxmIUJWC9S
 kAGzOaZrMbMOYz/Fh6rIAPdYH3ICwSlaM8cvzYrgPSOBNiufcdlBIcdL4WAF/89RjBLbi8oX+4R
 CQAInPrlbObZziIvvvP+2NXX4PnjXIv3HmYphda9jWQjCwqprdSWrwql95HpmBCTjnRRiNwbRsu
 PktA/UGWHd1g76gWBgHdmB6lH/lKPAocByNXUWQtk+Jdy9uuoMQPJ9wWSd0BF5SI+EkPe+WpCpc
 podrO+mx/BlOFET+DoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220037

This series fixes two related issues in the Aquantia PHY driver:
- Patch 1 restores EEE discovery for AQR111, AQR111B0, AQR114C,
  AQR115, AQR115C and AQCS109 by calling genphy_c45_read_eee_abilities()
  after the final supported mask is built. The phy_gbit_features base is
  preserved because these PHYs misreport PMA capabilities.
- Patch 2 adds get_features() for AQR113C to correctly declare 10G/5G/
  2.5G/1G support, since the PHY misreports these speeds in PMA extended
  abilities registers.

---
Changes in v4:
- Fix the comments from netdev-bot+sashiko
- Patch 1: keep phy_gbit_features base instead of genphy_c45_pma_read_abilities();
  call genphy_c45_read_eee_abilities() explicitly after supported mask is built
- Patch 1: update commit message to accurately describe the fix; add missing
  affected PHYs (AQR111B0, AQR115, AQCS109); add Fixes: tags
- Patch 2: fix commit message PMA reads still used as base and add Fixes: tag
- Link to v3: https://patch.msgid.link/20261016-net-phy-aqr113c-fix-pma-capability-v3-0-0bbb1b84035d@oss.qualcomm.com

Changes in v3:
- Add patch 1 to fix EEE discovery regression in aqr115c_get_features()
  affecting AQR111, AQR114C and AQR115C
- Extend commit message to note AQR113 may have the same PMA issue
- Link to v2: https://patch.msgid.link/20260924-net-phy-aqr113c-fix-pma-capability-v2-1-29b06283b0f3@oss.qualcomm.com

Changes in v2:
- Fix subject prefix to [PATCH net-next]
- Limit scope to AQR113C only as AQR113 not tested
- Link to v1: https://patch.msgid.link/20260923-net-phy-aqr113c-fix-pma-capability-v1-1-497359310f06@oss.qualcomm.com

To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Hongmei Xu (2):
      net: phy: aquantia: restore EEE discovery in get_features callbacks
      net: phy: aquantia: add get_features() for AQR113C

 drivers/net/phy/aquantia/aquantia_main.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

