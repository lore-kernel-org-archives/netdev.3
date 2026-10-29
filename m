Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264001;
	b=yrKYlaF7/GbaDmtnA72Y/0eLxOfeVc3fCckfu5TxOqezHgDp2xlONWIu81ZtL3Di684D
	 2rd5A4HHqNw2eKXWWJG8ntQchdnV6GBBLHbvw/V9iCdsno9FY23GxyHcLSMOsF3PLethS
	 XfCdw9qkGYGQ8D7OFfmEhUq6BZObo9g+kBhRB2Bzye18qTTLS3ztqWNDoY3W69M0N5SfB
	 tu1ETYLVDBwERCZEsf3vCcj+rWQOpdq8PLPQQ1noRM5Ax+6O86LF3cvyEq1fk87BsQ8NK
	 tj224ydXliaREFh05izpXW/LPg8jQukrRRra+iMADKy/ogGdt7hLpuZRSCZYOuV6cTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264001;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TBANKr0NROD0yWN5I9m9kfTf64HNcn3lFXt3pm6HxEk=;
	b=U2ll/pHscfAwMLl6uq2BzBrN2Wi1DDpQKmC9jWePlaEjQ2rd3QlSCbVAteyDFdS/s/HF
	 43+8BV94+dun4690yCKiwfZTAeZOqpydZv4pAqhY6QAidDbENZVLQ4JQArSs5IYXAFwaj
	 f7Jv2c7cflcmdhtPmRWlC9pg70iFnlT1XM2Wd0wZ0elBuNNKCmJhLh7gKF5gRq2NGS+BF
	 YsxUd8BlExbweMkh2RjoRUdBdsa7rURtGs+VTnotnntrJ4oh6q9Sy/RZo2h0UG1WS7lkZ
	 G1yuovQKebhb+5mmUI+eNgWXpFAKly4vL7zGHMSXaeY86qh+RhOMQmIxnBLUs5aMzEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HXmlTX3x;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JmSv0JXZ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79E606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E79E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HXmlTX3x;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JmSv0JXZ
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5Gu4G3341092
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TBANKr0NROD0yWN5I9m9kf
	Tf64HNcn3lFXt3pm6HxEk=; b=HXmlTX3xFjZW/Io7gkLRYh3IUNnYRf6QFmTyn7
	MW6vuqCBSNrdNqvCF58ZIKfaSKDCNQ0OjlzIxT2g2Su+4bOFb0gtNAIUfkJdWWLi
	UElsFpTnkCojkev8FJHZu3JMTW05P1NqbL0WTreHPUwnYqLx60JpZY08mkphDvrm
	VLtp8fNxFNkaD7bnjMZGOLh3tKGjzkPxpUoRaLFG+4DSilDvrdKbB3MpkrtCSWLj
	lZK/93c0PRsEHgraIBnE1B2grSv5Pctcy6bjUzDK8F1f6bYvgTnw3vMnvqhpKSwt
	+iTcwkMj3UYEgA6RJgzZKQrpVUxXgcFTLdpHfk95DNlZTvXA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3hhyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:53:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e832c03576so28446515ad.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793263999; x=1793868799; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TBANKr0NROD0yWN5I9m9kfTf64HNcn3lFXt3pm6HxEk=;
        b=JmSv0JXZaOJT8bG5/ZFA1WSBk8fG7uptjpbdVfh5gZu/mIMvceTu9Z3P5nUtwwjU9+
         u7oXbu+dMRITKW1USCzQ4kmzMEyS6verYadiuWtOnjRyA7/w7J2axKFmDdCG5CPkV9xF
         0wh79d0jr4q6sFpRM1Yr/zxVKFSoHq6to9p2qbSWlcXsktnPGBi592HIXaRnTCOU+6ad
         aHnAlwCQDzDN2DaKijey+zbE6eJSup8qXnMDDXx2iriSzAy7r7jQtJoVCOPYF2CRvnoF
         mrYP+h4+luxY8TkfIO1x8po15ZwNjXLC0kCa7oovgsQ+djzuf4N0FzsVE0aSiqLZCEzz
         k2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263999; x=1793868799;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TBANKr0NROD0yWN5I9m9kfTf64HNcn3lFXt3pm6HxEk=;
        b=Fe6xpriIOaL9nmlIW/1UoEm6HU7hMZJTeVK/lw7iWhzsU24/LV0kIy/DBTQotAWCCV
         dN5/LhYwaILDf1uBLvAmRsAI3jmdu3Q73ohEOXlUQL2A3ZelHQm/+GcATzh1xRqXPOQl
         Tz2wcKOoPh/6uQ8d4k5t+yMFiqjh958CUk1vAdeCV+AuBgfg5FAciyvPkKtsRxJOYkOu
         ruTk9rluSBO9D5k70bEIGg+Xl3s4L4GMwWvdqCVm7LsFYFVdo1XMYrCxXS2Og/07qOl8
         RdQrYZwz+M4lfWpXQQ3eYLTMh0aZ+6qIPs6c37vFrB7D902vL6xgCRmhQTBukodG2HCq
         CBRA==
X-Gm-Message-State: AFq9FYJzKlCjlspE6dVDs5xi2M+9VCvrXDSi3oNmdm/uZrQZxMmf4BYL
	y3wpgRFwLut4DlFHEghCJCHzMFoGX/TOUxAzBX5p0b58cJ1kLXJOiTeLpw2WNfNSj6qXkZx5MBi
	xI91OMR8emuKgUmVPYPwnsqbYSoGrt1c9qGQJpyBILkusMP+9QFj/Wu9tN0A=
X-Gm-Gg: AYBFou0ZsZuMzaK9CsVncuIl2v+9d8Yv5b3rvKumSrqONTMkxwtqq3ug+/M6YudxUF6
	2msphUteKsIPOeb39USLaFwSW2kIMuKmrEgL7qdwBEK52YCv0jAv5pAwZM2eePuLF3OgG3JecDQ
	e2HAwZMnhnHbVPFFj50NqgJX/e3fHysttMNaupg/vXz8+WoTG4G8r7TSKOOiOLSR4ViL8QoRSIq
	df+03qC9GdnDZypPVpWlcJDTxWo0wmJMa9EIRdLwTKVmRJlqQrrWVJKsafwJ4S6BsD7uBQfWB/W
	5/ezXql84OfdxJZNcH7MWtLe4TklwRcGUpRGnP3A+yYYS1ga53/NwH9M9sww8QNOhF7HKSKgtWx
	YmbpTv7nvXO/gE02ADKUo/l5hVFRy09xdOtCPIh6TvL5Sb2DkXNOfh50Rhts1DHPj6HVhWynz0u
	+lneP3uZCKN9949UthY5tZN6NR1NyiRkwc
X-Received: by 2002:a17:90b:17c5:b0:3ad:50a2:9abf with SMTP id 98e67ed59e1d1-3ae582adce0mr4176346a91.38.1793263998957;
        Thu, 29 Oct 2026 01:53:18 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:3ad:50a2:9abf with SMTP id 98e67ed59e1d1-3ae582adce0mr4176295a91.38.1793263998247;
        Thu, 29 Oct 2026 01:53:18 -0700 (PDT)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7fe923sm3660024a91.8.2026.10.29.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:53:17 -0700 (PDT)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 16:53:12 +0800
Subject: [PATCH net-next v5] net: phy: aquantia: add get_features() for
 AQR113C
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
Message-Id: <20261029-net-phy-aqr113c-fix-pma-capability-v5-1-e57e9b9118cd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHcJ42oC/43OzWrDMAwH8FcpPk9FspM43mnvMXbwVxaP5qNxG
 hpK3r1OCqWHFXIRCEm/v24s+iH4yD4PNzb4KcTQtanJPw7M1rr99RBc6hlHXqAiCa0foa9n0Oe
 BSFiowhX6RoPVvTbhFMYZnHRYWmNVKRVLUD/4tLWFfLP1vvXXkf08JvFi/rwd14x1tw5x7IZ5+
 2ei7eIRzcWe6ImAIFNS5EoQVlh8dTEezxd9sl3THFPZcif+Kme7ZJ5krgwWvBQGK/FGFk+ZkIp
 dsgAENMaQKTMUuXsjZy8y57vkLMkq1yQrmTsn9T/ysix3mperTgUCAAA=
X-Change-ID: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793263995; l=4313;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=fI6LoT1ToaWO1I5UKQO7dKjkd2DPJ2g79MMqQnLrdC0=;
 b=JGrm4CCJhsLESXpr1nS2sCBsm5KaW2WKA0WxuZMw89//3+c6yra5z7Z4gvpKzhbb2bZOlAjwp
 68b82hA00tUDIrYG4tkm0WjtX9xwCZW8uDEl9M0WSDQ8bP9YJGKK0YC
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX9eUGT94wdIvk
 YgHre5fN++2BDPVAbWsNh1RZVEu5l6X44Ovl1H9Xo08bg5pMuaSD1v5EI9krutMcCiCyij2g+gh
 yW3GmigtahgL9L1rS3yPGObkKZ8YEeU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX0WLUfFqmvvL2
 f85GhLqlmMvYqhVetHeGPkCHrWTCXhKRbNSZVcMkf8q1uh5W3n1a7ephADi7WLYRAFtVm0+4jqc
 OatR9z1kgS/zAW0r/nCuZSZ0pBJnLzeGeorF7KxlD+JiBfRWSfcydkvw9aDgL3HCE340r8JqPDF
 K6gUNJhARXfSsBSa2Pp/f7uV3X/vdsgHp+w09c6mv0XF5+HwL9VJ9N02J/EKjulxgqs+qH0ZDZW
 mHKzE0ArZXq5tPISPB8Dug/evJEL+TvpH3D263PVs5OUv8kmRoX7Gz4X//8OSRjIaXQgmPVjay2
 NgmoXsVjximICfXJb0aUnrXYUjSQmgsKLPDzqqt/SXahH/9cS5CM2ge6S6U7zWtnStc8ZshYjn9
 24Nto/qq4j2iNt9KcpMfWUaw697hvFB2i3OSTCGLS2HAanyU1pXOvuGJGbOjQuZUd0+rCP7UD9o
 7gKdhk1Y1yZUkyt9NrQ==
X-Proofpoint-ORIG-GUID: G1OfeRs6VhNoKGVdTQb9zfT0i2FBf-_v
X-Proofpoint-GUID: G1OfeRs6VhNoKGVdTQb9zfT0i2FBf-_v
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae3097f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=PHq6YzTAAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=AFLgWDODZm6VlcZumOgA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290034

AQR113C does not correctly report its supported speeds in the PMA
extended abilities registers. Without a get_features callback,
phy_probe() uses genphy_c45_pma_read_abilities() directly, which
produces an incorrect supported mask.

Add aqr113c_get_features() that calls aqr111_get_features() as a base
(which uses phy_gbit_features as base and forces 2.5G/5G that the PHY
misreports) and sets 10000baseT_Full explicitly since the PHY also
misreports 10G.

The AQR113 likely has the same issue since it is a closely related
variant, but this fix is limited to AQR113C as that is the only
hardware available for testing.

Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")

Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
Changes in v5:
- Drop patch 1; EEE discovery for AQR115C/AQR111/AQR114C is a separate
  concern which is not related to this series
- Fix the comments from Sashiko: call genphy_c45_read_eee_abilities() 
  in aqr113c_get_features() after the full supported mask is built;
  do not return EEE read result from get_features(), EEE read failure
  should not fail phy_probe()
- Link to v4: https://patch.msgid.link/20261022-net-phy-aqr113c-fix-pma-capability-v4-0-95a17f75dd7a@oss.qualcomm.com

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
 drivers/net/phy/aquantia/aquantia_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..e963ee60e27b 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -1094,6 +1094,24 @@ static int aqr111_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_get_features(struct phy_device *phydev)
+{
+	/* AQR113C does not correctly report 10G in PMA extended abilities.
+	 * Build on aqr111_get_features() for 5G/2.5G and add 10G explicitly.
+	 */
+	int ret;
+
+	ret = aqr111_get_features(phydev);
+	if (ret)
+		return ret;
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			 phydev->supported);
+
+	genphy_c45_read_eee_abilities(phydev);
+	return 0;
+}
+
 static int aqr_gen4_config_init(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
@@ -1444,6 +1462,7 @@ static struct phy_driver aqr_driver[] = {
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
+	.get_features   = aqr113c_get_features,
 	.link_change_notify = aqr107_link_change_notify,
 	.led_brightness_set = aqr_phy_led_brightness_set,
 	.led_hw_is_supported = aqr_phy_led_hw_is_supported,

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260917-net-phy-aqr113c-fix-pma-capability-d7d08cbc9879

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

