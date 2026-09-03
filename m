Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30374EA361;
	Thu,  3 Sep 2026 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451896; cv=none; b=h7N2aDprKsbQNtYsYMKR51pej99ogzyIBT8MdRcljkF43iAYLoUdShvVlizqfTxwYcDWV063VKn5sia5xtrh3/G3Nu0wM1/WVI8C7RsCd5hARo2t4rUiEhHEpTbVbqLn3SHLpgPtEO/gLMbyZr1N3o6nmY5haIPw4msbssedX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451896; c=relaxed/simple;
	bh=09ziLNC0bkLsTmgMG4PhrQqdi09zCihTIjajLC7U9J8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hvy0wuLKfZbRf8vs0YglrxXUVF1Ianl0fKAGL1TkeLc6V515600gxa+MqWW6K6s9M5SvpxT/011lZBvqz+St18fINrNguyTjKplSdHUn7jSlVjVqPORlIMfwo1XMSb/Nqyu+e611bkd7zpv9UDqVNSKIiIwb5dG8Jd0lwka7Qgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Z0MaIcIS; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Z0MaIcIS"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G9KPi1341998;
	Thu, 3 Sep 2026 09:11:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=gzeDU9um1jAYuDEMPjMsxXO
	DB2aqVTNmcDZoJtxG/OY=; b=Z0MaIcIS8hLCkAg+w8XZfEK/ksGuH6IgnlhfM3h
	QHLAanVfLraAVISiMfKFUwLkv/36HsAYwoUysglzMqbva9hDd+44G394D7mlFLMm
	TAq7VA6iCWWE+6ZbsCtXnQcuQBtfUDpeSxyJiFXkGfY9Pyl9W9+pstreseZFlqq2
	Vfk+HGxwdJe0aJlB8gLz+hHUUU/1xCD8c//BUFpl9FuIU8+Lp6LHH0ylFBJ9zyQL
	wAO6b06X30UEOORQa5MEPK/5Oa5x1Y8P+d0E7kWaokHp6TeDl5jgd/9sQQJZ9XbW
	vsD8Dtbha8UPbowbAwmWaHZ5MYyNobfgToFF5aMAdC1X3xQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gew3k2xde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 09:11:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 09:11:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 09:11:24 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 3DB9E3F7063;
	Thu,  3 Sep 2026 09:11:20 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Christina Jacob
	<cjacob@marvell.com>,
        Jesse Brandeburg <jbrandeb@kernel.org>
Subject: [PATCH net] octeontx2-pf: Fix autoneg reporting in ethtool
Date: Thu, 3 Sep 2026 21:41:16 +0530
Message-ID: <20260903161117.2856633-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0zmHevKY1Vpdmro97tLSYzp8ULKLaK0M
X-Authority-Analysis: v=2.4 cv=OYSoyBTY c=1 sm=1 tr=0 ts=6a999c2d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=jf-fmDdCkoYWP8ysx5oA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzOSBTYWx0ZWRfX6U/dvkTS1sdW
 ai+JOerXTUfNz22ERGA6XlPZfjYo4WkoObqXLyLLxFoIwBZhBUc+MG5Dal0i/Tb4Z7vk7XAKJ/3
 /SUa2cBcVrSBtej+t80SekoW/OG8/UWdQWLGaS4p1CDF8H25prifL5MrxlXR7WHIrO5Yi4Im+fL
 mYEepYGrIqgRrPspRYE8d655zDwO+B64GC7dL0FMrP+Mr3JJNfDZyUPqx0IymeXHVhAVmqCbsTz
 Xna/IcK6cF6YFum5mfeNFncCbH2h0VtzEtruzqmm7aGTWv2nSs/TIOnVYeUF6xb3XmF4+7r6EOC
 L+wlkesI0Wth0LJfUPurwSmC1jiTKplLQ/fEeeapv8+2Ba84RD5H1q96pvnmEyShuVEWadlkKpg
 ni2XuH+jdJfHyD/Yl82yYQBisXSBPrrONMZw55/NtbwIYDDv44nUmGSjYwXkkc4z9Um5L+2jMNr
 5cjFrYN/cJiky6mXFIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzOSBTYWx0ZWRfX5JqNAe9heGUU
 rVzjIuSDujfWlkEatCN4MX2PguRitVkuk93E8JK/hqIHKi3od3JwVQ+ukqJWLwlTarASbD+Otcj
 cLuLmXYo4kQ7ZEtpJFgXWkr1WSx41nI=
X-Proofpoint-GUID: 0zmHevKY1Vpdmro97tLSYzp8ULKLaK0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

The driver adds the supported autoneg bit before copying the supported
link modes. The copy clears the bit, so ethtool does not report
supported autoneg correctly.

Add the supported autoneg bit after copying the supported link modes.
Also add the advertised autoneg bit when firmware reports it.

Fixes: 1a50280c25ec ("octeontx2-pf: ethtool physical link status")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 9bee1b91eeaa..612fefc41a17 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1218,19 +1218,23 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
 	if (IS_ERR(rsp))
 		return PTR_ERR(rsp);
 
-	if (rsp->fwdata.supported_an)
-		ethtool_link_ksettings_add_link_mode(cmd,
-						     supported,
-						     Autoneg);
-
 	otx2_get_link_mode_info(rsp->fwdata.advertised_link_modes,
 				OTX2_MODE_ADVERTISED, cmd);
 	otx2_get_fec_info(rsp->fwdata.advertised_fec,
 			  OTX2_MODE_ADVERTISED, cmd);
+	if (rsp->fwdata.advertised_an)
+		ethtool_link_ksettings_add_link_mode(cmd,
+						     advertising,
+						     Autoneg);
+
 	otx2_get_link_mode_info(rsp->fwdata.supported_link_modes,
 				OTX2_MODE_SUPPORTED, cmd);
 	otx2_get_fec_info(rsp->fwdata.supported_fec,
 			  OTX2_MODE_SUPPORTED, cmd);
+	if (rsp->fwdata.supported_an)
+		ethtool_link_ksettings_add_link_mode(cmd,
+						     supported,
+						     Autoneg);
 	return 0;
 }
 
-- 
2.48.1

