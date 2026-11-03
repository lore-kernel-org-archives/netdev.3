Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722231;
	b=XFG1xqKxZxrlTeTSWPhP/yjF6UVzVXrpS73WXPFXxT7wHs+8vVHhYd9uBmkahA5Go0Q8
	 avPzaezoD2wrJ7Qr+7BrDIBHCu+jE7VwGubO6dHEOriB9wZWRTf61CWmw4TbH67DXZKlJ
	 i0vEsaKTno/gMAci5lETncvzmVtl/BwWmhQUvq4kLavUoszwvRSO9yS6IwuSAfVoNm9ef
	 2XLzGG88NiC5y5eZyBGEo0vOdmav7hPbUgPf6w4U2IrgHYeD+yGmGKbpiGSGfmgge7ReL
	 AKq2BVxLSIaduu/sjT1I0kxP1IAE/Jd6RrWrWcqhN+rVXAnVY5F002epLDHemHwpRzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722231;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7MeU2UwpgLKUJoYFTQgE0EdDaOdwDP5amaQCMtBXgOk=;
	b=rADGm2dYj97XfSZJZGk9vx3S6BynqR8eanMi0BljpEMIUi+ERIisx6wc8mOaUdiFo/mc
	 n1r51FaDCcW8Pp/eAiJTwKcFtVwcSFb/awkLepXNaSAZ5WDTWW+pTIJEgA8ZGzkxfPWCo
	 J8f7aIg3AaQcCKNDVCvdQe4/FsDZvUhjtKd4gJiigGUJru+DMiiXL1g5qElpa+1Saw7SU
	 aBF33//SSdMSwoGWjp0OXo8s0E6V8Ij84fHN5k8wVyjsM6zLKqafpwJyGaOFaw36xOTVg
	 LCcESQ4GHCgg9B7XWAv1oeYX2i1ZOhW47C/+SUxIm3waJbatteZvDntLIocU0L5zhtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TLsrb5vN;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PgD2ZFNS;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87E606D809;
	Tue,  3 Nov 2026 16:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B87E606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TLsrb5vN;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PgD2ZFNS
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E83XY3533130;
	Tue, 3 Nov 2026 11:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=7MeU2UwpgLKUJoYFTQgE0EdDaOdwDP5amaQCMtBXgOk=; b=TLsrb5v
	NCF67bPVgs0ExKgxKChu7qHC6lUyAKZoDWqeQyKdSwhJQdFn0zgZQVle+3ab2wWk
	Q37dh9WPRpoLPsWsZYWmBRuSIY2LjMOtAlNPYJi1eVJ+AMoKkiJnQRFPBfZ+3N0N
	3BwGAYK9LQhIbaBYTFSKVkim2hJGxklrVyF5Al9RvLsbibXGLIUd1psfpzve3Q34
	Ewr7oYZj5wXdz3uvFhf7FLk9EE/Wi/evISbPmqtmFo//vHwwwtGogkU68kfnFzg6
	sXatZAkuqODLNd+FRggVUTpza1RfObNU1G67Fhdv95Q8ZHKZF5v6dlU/j1Yhb2Ye
	At8QckhEIFuKb5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7MeU2
	UwpgLKUJoYFTQgE0EdDaOdwDP5amaQCMtBXgOk=; b=PgD2ZFNShukPxpWOgDrNA
	Twe0AZaJr2qsZeWOvnl3unRFzCwHcZDPNq7Cv4XKkcUulqKueRSy5coUl6iUO3a/
	ON5BRBMtoaQSYTm0Q0TbrryTrG7IA/7UkvS+6N+AfqyGzWUfwU9fgFHzf39ehc2w
	8037BgfA2Wd2x6ejZRmkEjHAB76O7yEt/EYPSWng4I7TIY5NX5Efn25+laCJEXbG
	ntpQ1vvPZd50MSqVS1jbvuAQ/eJobkamoBPPfScQPMCEMzfjuuU6OjvYEQw78Twa
	OSvgL4xn7jrdhl4y9gGQGd4Dx4Z409UI7OlkwMkOCs1fZA1PK/mCR6blY105EwoS
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hpjhb2dvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:10:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A3GAJVT003143
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:10:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 3 Nov
 2026 11:10:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 3 Nov 2026 11:10:18 -0500
Received: from HYB-6AVb5If9qTU.tail230d3d.ts.net (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A3G9KcR032393;
	Tue, 3 Nov 2026 11:10:11 -0500
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
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Subject: [PATCH net-next 5/5] net: phy: adin1100: Skip the soft reset on ADIN1110/ADIN2111
Date: Tue, 3 Nov 2026 18:09:18 +0200
Message-ID: <20261103160918.409701-6-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXwBV7z5PQ6y0y
 Uo5XCxzlhE9u26X5ClKqXLHPhHoWPZxyA3Cl7e/ZMl+jpOkr8+IRDglghhjfmXZdpCdf7DavIKY
 eFpET6FSwohJ1aqJcqv7zX7qHLxuQKmNe6OwrQxJ+V69/zOSRNf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXzPFSHRWockt6
 bpuGHyioqZoehXfmXy9NCcQxy3/NW0i9CdyJpvWbat+3uMk18IzTFoMi/S3JiDgN5PEWCHNS4Z0
 6+oXLclAefocTfRvsrCfWwH47Kh2H93edISNCb0h7xIuPc3fIrqAhf6Z9AvpzjLcAtLDj3qcfKC
 pPS1mabCzlVgDOcas2E3scVYL99hbyAQe/Q+Rf2jDge6H7xfGp96pGbtpKD/LY/hynVq2BpfV5D
 7N/fbCloCWd/uHEktYooL+BpFPS5j5ddcDMufJdfnZLfK0WAffOcDP4mCx/iplLNxVBFeRgHoSO
 Ud6vqtaPgM6su7zESyCTxMZwtufmVdShh99SAsaqhygjFT30QfzRZekUWKkOK7piCgVbqLB+XfX
 +SQCD7CK2Ga5aXfXhamcD0DTfhi2IFBCLa+eUPU6Q8ZCqf7zV+fntoGGzmiFD9pw+JgG/cTem3U
 294RsyqivX/16lOhcHg==
X-Proofpoint-GUID: IDzOpoRxQGMElTLKwAFOwVDlNxn7Ajk9
X-Proofpoint-ORIG-GUID: IDzOpoRxQGMElTLKwAFOwVDlNxn7Ajk9
X-Authority-Analysis: v=2.4 cv=cbtHPXDM c=1 sm=1 tr=0 ts=6aea076c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=Ls8NjqXsghbD5vl97lYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

The ADIN1110 and ADIN2111 MAC-PHYs integrate the ADIN1100 PHY and use
this driver. On these devices, CRSM_SFT_RST resets the whole chip, not
only the PHY, undoing the configuration done by the MAC driver before
the PHY is attached. MDIO reads also return stale data until the reset
completes.

The MAC driver already resets the chip before attaching the PHY, so
skip the soft reset on these devices.

Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/phy/adin1100.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 8f9753d4318c..7b4e68285a9d 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -232,6 +232,15 @@ static int adin_soft_reset(struct phy_device *phydev)
 {
 	int ret;
 
+	/* On the ADIN1110/ADIN2111 MAC-PHYs, CRSM_SFT_RST resets the whole
+	 * chip, undoing the MAC driver's setup, and MDIO reads return stale
+	 * data until it completes. The MAC driver has already reset the
+	 * chip, so skip it here.
+	 */
+	if (phy_id_compare_model(phydev->phy_id, PHY_ID_ADIN1110) ||
+	    phy_id_compare_model(phydev->phy_id, PHY_ID_ADIN2111))
+		return 0;
+
 	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, ADIN_CRSM_SFT_RST, ADIN_CRSM_SFT_RST_EN);
 	if (ret < 0)
 		return ret;
-- 
2.43.0

