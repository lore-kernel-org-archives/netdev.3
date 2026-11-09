Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214895;
	b=x3RdFBHfry+myNtc6vf/s39GYqGOthnxGrHnU9vnigNlhuVCT76x26ZycoOH5uA3NL8s
	 +XCUOCuSe8fZE2uq8aBjJh6/p24YGQezE3VUNXam7A6N2pJnXJG+6vf4qz5fzMXgrZeIU
	 nqgI7BOJEGcuSDGZEU9r07Amvt+wEUD/tYm4tLaflIGxkDFZIW+yx2Jv0IpJ2uP5iUDR0
	 BqeDWRhwLnHcwQqBFyu3yz6hQW3sYGyWm7vgOfsTAOqxotmQwXqeNbyRtZdQvWksooZSg
	 63sj83NXrUicUj6LXAOwm2pcOaWWZSZ3ysYIm4RI8WQ4LCWfDgszr6OctCug387MNPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214895;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BV0dct4NYe+wKZfA1QJwubv/filALhLyWJi9A3Qs12Q=;
	b=Uz19H0a2Vuh5u8VIM7XtfY4fkDxGqMsjWEg+VWJ3PiQrzOPB1ixz3Roclk6uY/xdO+Fp
	 lULDR6F8QS5EfqXZ+mVLFoArIsZWBNHE7IjD3mYXdnsGYttOqFNotihocTI1xf9nzz3B7
	 MvPr8xw2o5VmCQYFxZsfQHsAowXI2t8UCwCnG5A8lpgAaqyIS8hiquNlk/Ic3gG8enZmO
	 gKJNdmlgeNIdfq895kdGRhFq/OYEYve/ifCOFpwt3DIhRrlFfObE/tXcu0cuIE9bs9GqE
	 c16HOYoRi+xs21BKoQjBNfmImhisp350EMMWfG8hJt8044c9Nu0JUsmA3TrVDd8S0dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YjeHS8ZV;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RvH3el3d;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250B606A337;
	Mon,  9 Nov 2026 09:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9250B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YjeHS8ZV;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RvH3el3d
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96Bu343169927;
	Mon, 9 Nov 2026 04:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=BV0dct4NYe+wKZfA1QJwubv/filALhLyWJi9A3Qs12Q=; b=YjeHS8Z
	Vvly0S+NH4IAwC+Qzk909Eg7vE9g6DzIt0rI15J3MsYb/tL/7BFZF0eV76ubuzOR
	leCwc5MmCUcmI2BIQFm56yBJcPcmZ4s7Jd1Ca2oN0uk+d+kJBzjAzXFRL9/dfx6B
	uHQ2cp4mE1vT9HG2mPz/SqH3h65U1J78fEEVUXxRH+6X/X1GTSlVkaTGXhxS77Nb
	VyXU5TOk7ICnfO7L36uOwEVuLQKlXUiwJhbLrTDpX4KEPshu3qgxefbylEQuU2UK
	5MWhUPsnIl0f2wb7CiulKbW+r1Z+2F/z0qSdEdmO65+Tyul08Xn07iH+xnp8rXMx
	DcNszu9PIJFGsxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BV0dc
	t4NYe+wKZfA1QJwubv/filALhLyWJi9A3Qs12Q=; b=RvH3el3dsmUqF4iyPTflV
	ctrVz9ZdnbkP0SQpPvrQHhBrGt8Qp3dxqvjDg0Swa1DH7O/OItkFMqACA9ecmnJ5
	oO4nrPHpv4U9BiveIZ6TsWfEHEREg12ylLvhtj3yEIvRQvPnzKX6InlOd6J6g9en
	3lxO+NZ+Er6xywC4UpAznTTcv95bZ+axYbduziOpdutVdFRcVrG8B8plwBMa/8TP
	TzcddeSdR+aKr0ZA8QSS4MVaOaCfZ3PoEQOSvlifK2EGH+i2yQ8eA2Fo89kvWIS7
	G1L6A39N3VdkRXDS3fR46hDV2PJaEHEBwE+7ypvMCdd8ZDF5ZL5buDXXhogqW1dg
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ht1s7a90q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:01:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A991N9p045773
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:01:23 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 04:01:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:01:23 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreJ024796;
	Mon, 9 Nov 2026 04:01:16 -0500
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
Subject: [PATCH net-next v2 4/7] net: phy: adin1100: Add separate driver entries for ADIN1110/ADIN2111
Date: Mon, 9 Nov 2026 10:59:49 +0200
Message-ID: <20261109085952.105331-5-iustin.stolniceanu@analog.com>
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
X-Authority-Analysis: v=2.4 cv=c4A+0h9l c=1 sm=1 tr=0 ts=6af18be4 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=0NDrZgIfIxmKIwutybgA:9
X-Proofpoint-GUID: 3yFDHbzs32CxsSEZgndqQCsxOvk2rCnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX06+GrRCXnJdH
 +PRjTk8cBpOzDIaVPv0gdSyE4lghyrdeXWPeDIk5mP88z4283pWKzQc5RVJUumv8z8H9zbGwSEN
 1YhpOZ0Ztgf66PSeRfh5ustBbGxRnKlxV19rh6iKCbq0uVTOUrUSad5cuDUP2h6SkyMtHfb+J6U
 ZjijB4f9znEuNc8G0ModYL1X2VS7W+6E4D6C0g2c2QGG2p97DmxqP4fURH0GUZSEJ0VKQ4WbAkl
 m0YuI49YCVQTXqDqUEM8SAgKjM7DpH8TVS+WHzPBqJPMdBCaQV/Lm5KnFCnSQbKKP6MD2yE71Tu
 p4nxxwd5C//NSpzpsvMGMbaqbjmiI5uNMur0CpeB5lQt64kLJ0yNr6z/4I2q/frwSZL50vxPxv8
 zTI6094/GoH8Wa0vUN2CDzoe7JBPOpxrSSU2I4AHnzAtWCL3R6oupd8Fdyk4WAJbd63kMysQo8b
 2TaYXXE0X6hY4klFQPw==
X-Proofpoint-ORIG-GUID: 3yFDHbzs32CxsSEZgndqQCsxOvk2rCnU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX1fF8lotG61Oa
 O97bVlftw8PbYYn2G8N04kVlUHOVDkpN34rfxefSzaghJ5iuOZoKCWQtUEVJG0JZQ3P1O+84Ec1
 GG6x1gKcooYYpKS3hcStKbP9gaz0kZQVGmrbhw6YCECSuEhsYTsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035

The ADIN1100, ADIN1110 and ADIN2111 report different model numbers in
bits [9:4] of PHY_ID2 (0x8, 0x9 and 0xa), with the silicon revision in
bits [3:0]. A single phy_driver entry with the 0xffffffcf mask currently
binds all three by ignoring bits [5:4] of the model number.

Use one phy_driver entry per device, matched with PHY_ID_MATCH_MODEL(),
as is already done in the mdio_device_id table. This allows device
specific callbacks to be set in a following patch. The callbacks are
unchanged, so this is not a functional change apart from the reported
driver name.

Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/phy/adin1100.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 8f9753d4318c..b946cb86b6c4 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -322,8 +322,7 @@ static int adin_probe(struct phy_device *phydev)
 
 static struct phy_driver adin_driver[] = {
 	{
-		.phy_id			= PHY_ID_ADIN1100,
-		.phy_id_mask		= 0xffffffcf,
+		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1100),
 		.name			= "ADIN1100",
 		.get_features		= adin_get_features,
 		.soft_reset		= adin_soft_reset,
@@ -338,6 +337,38 @@ static struct phy_driver adin_driver[] = {
 		.get_sqi		= adin_get_sqi,
 		.get_sqi_max		= adin_get_sqi_max,
 	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1110),
+		.name			= "ADIN1110",
+		.get_features		= adin_get_features,
+		.soft_reset		= adin_soft_reset,
+		.probe			= adin_probe,
+		.config_aneg		= adin_config_aneg,
+		.read_status		= adin_read_status,
+		.config_intr		= adin_config_intr,
+		.handle_interrupt	= adin_phy_handle_interrupt,
+		.set_loopback		= adin_set_loopback,
+		.suspend		= adin_suspend,
+		.resume			= adin_resume,
+		.get_sqi		= adin_get_sqi,
+		.get_sqi_max		= adin_get_sqi_max,
+	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_ADIN2111),
+		.name			= "ADIN2111",
+		.get_features		= adin_get_features,
+		.soft_reset		= adin_soft_reset,
+		.probe			= adin_probe,
+		.config_aneg		= adin_config_aneg,
+		.read_status		= adin_read_status,
+		.config_intr		= adin_config_intr,
+		.handle_interrupt	= adin_phy_handle_interrupt,
+		.set_loopback		= adin_set_loopback,
+		.suspend		= adin_suspend,
+		.resume			= adin_resume,
+		.get_sqi		= adin_get_sqi,
+		.get_sqi_max		= adin_get_sqi_max,
+	},
 };
 
 module_phy_driver(adin_driver);
-- 
2.43.0

