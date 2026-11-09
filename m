Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214908;
	b=WHgDa+xyNT5tJ/zhOEM1DlhPjA4O5znV+RbA3lZd3pA8IOhmY/Qo6jqqmMzMXwz9EyaA
	 ZzwU6y9wFTPY6kvn/pUav6pYYCW9xu2l4RxW9P4aTKoVR95jdgk3rrqNCx+leLjvjSxqD
	 szord3WLjcZq3xsJFVUBfocbFfqOKgfaQhHfOmT2H9ln/d9YXOQhjPADRyb6GuDL81IjP
	 11p0NogLCoTssackyr7bnZN9hJBUHnKTwtq9kKEGGPFiCSqYUl8usrn8GUrQufOD9VACY
	 gelJ0JID89ly2Vq/vJ70PFW0J8m9rSvbk6niozOmplPf+FgAN1S8HTamCN50rGM+Dgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214908;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VIasCFWP5tseFGIHnj42Zr/FPuOd6ySF94aRn114CSw=;
	b=Y9S+ka5AHnmWFO58zBr/pAyWAiGRxFqbTZagXlZenkJSrIecILZIclzb4Zj2ryyP45NE
	 bD4sW9MDXoZ5I14w4fR9Xi3ajPjqb+ig1626WkXbJgrSIWn3fSI/bPdWS6H1yNGexXeQJ
	 TuB9BdaTQMOqg5h/FAcR4h3l2xsrw2NQra8rJ4OTL74dvZBoFBlUfzBnSLiloUNbrGURX
	 9Id/b7XSPoYcXAdWX3EzrCvZEabPuUEFJnmcHLp4q72c2Gzx06PYivOoCItaWJtXCuwzy
	 zHEqDdllz4G74/KPiHaHWFxD54ffe4HT86Aflw10Ov9ZX2gccuCAo8C8bWehfs1yRQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Wxg3Sz6G;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=XwFbSTvD;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F4606A32A;
	Mon,  9 Nov 2026 09:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137F4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Wxg3Sz6G;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=XwFbSTvD
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96C58M4101903;
	Mon, 9 Nov 2026 04:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=VIasCFWP5tseFGIHnj42Zr/FPuOd6ySF94aRn114CSw=; b=Wxg3Sz6
	G+03q4VRyYz5cffqFlSytiL/pMS+xLrxHKDCG3qxek9HKVsZZnl4KTJc7FDKbQgz
	OJmDXko6qUN1tnJrZvSYh8PCh8PIVnze0VrTPtHgIwpFfHI7Cnvo/GKo6pUZfzex
	d1WMBhi5q21WiJNrIm6P3vZ5FsVmN90qfIzE4A7u7IuJot6i5LTVA2s2EqWQvRiq
	u43nnIPKpCxxKVpHmx1jIarwr1bY0FZSYUVk9sRjYAbIj8nqp+ttWwk8DbdXSQMm
	vYomvQha7EzsLSctIn7aQ8RjtOqHoD4OX+Oqr1dPanecQsCBoxMiSbfZvKe1I09b
	5+S0tkPTzbkMMTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VIasC
	FWP5tseFGIHnj42Zr/FPuOd6ySF94aRn114CSw=; b=XwFbSTvDVqIrVIOQT8XLA
	J5jKvqKU70Sw0Ts4/xgsKjKTG+eFH17KbRvppSnWW/grs1uoe6CnPvLhEjrWgVto
	ifXLEi4594UQSkWS5c4J2P6fU/mJmSBU2Hxy32VQK5AXOBc11aWk049PuLt0Y/OR
	LjGA30KLlRxHm7/YWad2hJ5oQz9xKlTyO3b/e05XJ2UXDszDHp0oAzz/ko0599D3
	3rak7s7x6QKhW3to0/Go/Jj2uiQeb9T47d93cxzv7/mYVuJRYg3xpdCMgFcJXzrR
	ZUp3jsjngO3YMcfwOI9j9nqqghXZNuzvN4d03qzdz8kwu/SRRap4x1tUemzGv2CI
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4htp6knqe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:01:39 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A991cS9045788
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:01:38 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 04:01:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:01:37 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreK024796;
	Mon, 9 Nov 2026 04:01:30 -0500
From: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>
CC: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
        Ciprian Regus
	<ciprian.regus@analog.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iustin
 Stolniceanu <iustin.stolniceanu@analog.com>
Subject: [PATCH net-next v2 5/7] net: phy: adin1100: Skip the soft reset on ADIN1110/ADIN2111
Date: Mon, 9 Nov 2026 10:59:50 +0200
Message-ID: <20261109085952.105331-6-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfXxsKPjtWD+9tp
 Lf5+1gONvzdAEjJcGGEdSGU5maXlvEfIVhJm/EweceoFlSMlyIQjSsyHxlMwBV7Nn+IsSVB+eTW
 HdYnOXK4AhHB+VhEWt1Rf+Jr+514acoh8rvYaIdN7G/xQad/N6NP
X-Authority-Analysis: v=2.4 cv=C9l8WgP+ c=1 sm=1 tr=0 ts=6af18bf3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=XQJP7wW7p6eG8R4eeJgA:9
X-Proofpoint-ORIG-GUID: fZTHiuLu9NTznWcJMNLncrBsjyGuFdwf
X-Proofpoint-GUID: fZTHiuLu9NTznWcJMNLncrBsjyGuFdwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX35n1essDoTB+
 e9Pv0w5r3/HkCRfi7Iu6/DboeBYf6+SuDx9vGeWJJiJ455RIa6NzjG4hida2GFpVqVSx69VTCDT
 iFeLDRAuWtlwcKR0R6b+iew+f862Rzv2Aoqyda1/rrPBcXSsZw3f/f6bTFg5FQIm8Y/PDYDtUHV
 vhvPKh8qXKtpqgo8vDI+IbOQiTDPMGdVvNZTRz53iQTxxdcwCMdBzK5YXRo+WLYWLc9KrWivU87
 q+neknf9bseridiWAcjvsLrxGRlwy1hqIYPLdTO/vVeqC/nI7Riyl413RHaCEUhrN2rfZUhOdd3
 NY71NVsMjNHwccl0/hwAZ3PbgA9ryRmJrTdY/IPsN31aIOOLmr2UfSVtrGlwOaQuFlLFOsPvIYV
 3h9r/dLHlSCnYHjj5Tk/NoLkKm8s5ziCPOr9xdEaptQYm7wH3l+8XMH8zRf+7yCHxiJQPzeGaul
 SEUSx9cQVAjoFyxH9XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035

The ADIN1110 and ADIN2111 MAC-PHYs integrate the ADIN1100 PHY and use
this driver. On these devices, CRSM_SFT_RST resets the whole chip, not
only the PHY, undoing the configuration done by the MAC driver before
the PHY is attached. MDIO reads also return stale data until the reset
completes.

This is not an issue with the generic SPI protocol, where the adin1110
driver configures the MAC in ndo_open, after phy_connect(). The OPEN
Alliance TC6 protocol support, added in a following patch, configures
the device in oa_tc6_init() before the PHY is attached, and the
configuration would be lost.

The MAC driver already resets the chip before attaching the PHY, so
don't set .soft_reset for these devices.

Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/phy/adin1100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index b946cb86b6c4..ddb91b0e7081 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -341,7 +341,6 @@ static struct phy_driver adin_driver[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1110),
 		.name			= "ADIN1110",
 		.get_features		= adin_get_features,
-		.soft_reset		= adin_soft_reset,
 		.probe			= adin_probe,
 		.config_aneg		= adin_config_aneg,
 		.read_status		= adin_read_status,
@@ -357,7 +356,6 @@ static struct phy_driver adin_driver[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_ADIN2111),
 		.name			= "ADIN2111",
 		.get_features		= adin_get_features,
-		.soft_reset		= adin_soft_reset,
 		.probe			= adin_probe,
 		.config_aneg		= adin_config_aneg,
 		.read_status		= adin_read_status,
-- 
2.43.0

