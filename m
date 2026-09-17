Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AD37F30A;
	Thu, 17 Sep 2026 02:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611242; cv=none; b=E1d8s/l8dGkxKS+mb/i9N333Uisy8Hp0CITQLFtT406OdM26tyRKAYgERShivy/59PwvUQysSbjSRwvB8C42NKetW8blVPYlSNq5eE1fB8V3qtQ3HvDhM2xtChzgqflZtRFtev197Wb6u7ixlRdJFSTb4T3h8JwmQzpoWIpUj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611242; c=relaxed/simple;
	bh=qKL6VzIHy8fYD9P82qSgmcOD60vtNuCECmmLFFqLXII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5XaS6rD5bJYp7pQS7tmYWAIpbmK1uLSc44+/arVTDbNTC3KaenYIME5mOsQsNETb9ogO+QrApin2Gu+sqvYZPi2KAL6wxRjbshkbQxSqIkw4q5KOpHVM2P6uHIpyZ1aITAEb4MzUW7REGNVSZR4ZSMxKojd+gby5pzY204c3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UrYZRFTf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UrYZRFTf"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H00d6D2578021;
	Wed, 16 Sep 2026 19:13:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LMbT0JmCI+rLg44rP/aR0Sg
	2kzqMWG1VSxt5wdgVr70=; b=UrYZRFTfB9fKMmN7H0s9dmSPYGqFt0PmmzCOt3R
	L7Zq0f8YgDuUGKIQgE105KHvXobDWMfmI2R8dbOLyMIW0IgwNAujkAHrkIpVOBsV
	pDfBpwDm9NyqBeYv9bWNpRegSTO742vLx47Psf1xC7ZDVOXEei/zLgN7snF9L8cL
	cR+LLHc6VsuDJmqGsbWOJ6t/8EFTaEgzo8TfSfkodkK/9VlW0/OZ3zu6jTgwZSLu
	ge8tUcMigWR0m441UlYwaWsw9Bi9GZZOIjDk4R+fZ5DFW/AoNpMpwhoH2Su7WpS3
	nW0Mfugxg/SeP1OHLYMYR0N1pBKg807qXeI6alZi2xT089Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gqqujny21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 19:13:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Sep 2026 19:13:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 16 Sep 2026 19:13:39 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D23CB3F7053;
	Wed, 16 Sep 2026 19:13:35 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: nix: Log TX scheduler queue validation failures
Date: Thu, 17 Sep 2026 07:43:27 +0530
Message-ID: <20260917021327.1124199-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAyOCBTYWx0ZWRfXxObxhNtNeA4Y
 7GdSKkqPK0jMdiToZqrlngxZRHx38/fey3MKYyJKmFQ2s+06T2eV341+lWD3u9JdHkehK+0KXq/
 Y778Qc3ddlQGijb5U5A/Sfje1gyYqWIHK68vAFZNpw/KnN5nSVGERQ2dNdroAfOrX5zsJPFNtNJ
 OdrQshGGk5S0p395HYpSUTyo8VfUz5Wgt7Q3pw+dVEVjglYDti+52JDp7/8qn3dreCVM3tPktGA
 AoKng+bDBG/Yd4OatKrKe93mdh2VPGwD4B1OUhnEk8gVwdberA3pt3VXPRh2+IBMM5D/IUghJ00
 yzE81PTwtAO8ixljrudNL/6jaf8NApj+SEGl+1CZfqEJrWsaleL11PV33yRrxhXCSZV/NOZN6yf
 QMC8KhKiymtkopJohL59pomNIInbN1ps0LmI1cNXH6jlyUy5JULd6HPuhGS4xqXdMav3DObJla/
 2bk34ZrA7+kXTwkJaWQ==
X-Proofpoint-GUID: BigU30hSahoM8F9aeMLufZM_1zGb54ZS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAyOCBTYWx0ZWRfX7LqoaLzMuAVV
 H+X8re6TiQwn9qy1RD2VCYHpELX4XWS0QNDixS9WDbog5iw+pBIH7yVXLMJWoYAoKvI8gjR7tym
 NcVbd5ShVCoOHEEy6yQO9uma4anOqN4=
X-Authority-Analysis: v=2.4 cv=F6LC5ahN c=1 sm=1 tr=0 ts=6aab4cd3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=IgfSDKnIuoUFKMqXljMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BigU30hSahoM8F9aeMLufZM_1zGb54ZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

Emit dev_err() when is_valid_txschq() rejects a scheduler queue
mapping so misconfigured TX scheduler allocations are easier to
diagnose.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..995ca8ccf2ae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -325,14 +325,22 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 		if ((nix_get_tx_link(rvu, map_func) !=
 		     nix_get_tx_link(rvu, pcifunc)) &&
 		     (rvu_get_pf(rvu->pdev, map_func) !=
-				rvu_get_pf(rvu->pdev, pcifunc)))
+				rvu_get_pf(rvu->pdev, pcifunc))) {
+			dev_err(rvu->dev,
+				"Invalid tx link: pcifunc %x map pcifunc %x\n",
+				pcifunc, map_func);
 			return false;
-		else
+		} else {
 			return true;
+		}
 	}
 
-	if (map_func != pcifunc)
+	if (map_func != pcifunc) {
+		dev_err(rvu->dev,
+			"pcifunc %x map pcifunc %x not equal\n", pcifunc,
+			map_func);
 		return false;
+	}
 
 	return true;
 }
-- 
2.43.0

