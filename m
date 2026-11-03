Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722198;
	b=u5WY50RtuztATGbXExZwoRnC/lDqAWkCMgdv7s0tVgOmtmiXcYqAmDp/1oIOhef/hUl+
	 UduhTUvOlkTTKzhR1m+pPdHrulIY5tdmE8AI28y5IokMOTiQ3VtjSjWSmKNzEHTDb3YKc
	 f3SS51nwk2Hzu0VxXgAnlJZAJ/iovyntpghRYcwEHQrYS7KVzVN2HmwagpsR51U9nVEKE
	 Qw4Jo+binFyhWXR+1MKsCF9bDVbWKoVTY56Q0X/o9gRa4kgfBsErLTdnIaOt03cJ7/l+p
	 cxauAgk1s1EboUZfNwyG5nKlRfGFnhmzTbq1FoWagiXgOQN4ajOFzCxIubr2UDHA0ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722198;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ndTQI45B89TJvxkAlBShdcf14KVD6930fvfy0Ca68ko=;
	b=btnW/zfoazW9iJtx0kQJqXUDs8U9jkvbH3FOqF88Ao6eqnx+LRR3Mm1tmrRO7EGvk772
	 OanUxihMVtGfQpK1b7li76d5uQGHu8Ed79UPqFf9gsPz9vRaEH1591lx3G8c8K04irOPQ
	 3JEW7v/ilVGjZ8Q9aQBBf33UUtpxD7QmgMB441i4ZYT8Iqk7gVRRvVolD5IWeyx4xzrOU
	 +2V6cxom3IK+nUO88PUhu+Un8MdARZCbfZy9Yd610gYC372/rvoGrN9RbRphmWBNYQKVH
	 mLpMLu9DaBppVxjQPtbsrufdYRecV3Hvo0KFCQkkrFRCei92dYdG2rnlAUoAUFsyXlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Y4T3jAo5;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RgBwAMxz;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A2606A32C;
	Tue,  3 Nov 2026 16:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 167A2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Y4T3jAo5;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=RgBwAMxz
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E7rdY3532676;
	Tue, 3 Nov 2026 11:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ndTQI45B89TJvxkAlBShdcf14KVD6930fvfy0Ca68ko=; b=Y4T3jAo
	5DYtilOiikbJDospdZbfAHgsj5g0dIZp2O8As1tLteLv2g1Ud6bmNcfRzLFRiAeq
	g/SgkdsArCAoQZZko2D7/1cHaGOebO9et5spT8EWvNLRU1MDGt3CKLlilvFGb7dm
	2tC6CGaOH+QUb06uC3qOx6kr6UY1OnXIZE3jCJPXJMvNo2cIBf5LH5nAjCa3I8oF
	QDeoO5QorUn1f8n3V66q1iRBwdZ5RboMBbNNVgO1TGMdOuIv3vCbntjfjUixj3J9
	9eEPiXy+FYMBt35L2Z5BeP9P7NFZAQcqdjfZujJCjAXTdHlgBTVqeCFvSdmHLghp
	katzMU6uqxtJnZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ndTQI
	45B89TJvxkAlBShdcf14KVD6930fvfy0Ca68ko=; b=RgBwAMxzcoARmdwKdQcg8
	wBq6xUXDgRG82iWFPsBzPUXr9xidpwIl+k5ObYpxarVzd3zsL8fsCQDr6wUX/oBk
	5g8q6rcPulJzSzfgBk4PBNU+V13MiLw1pj1Jx6n2QElmFp7cRysBsKR5GsRSLl3a
	AZxtPXsnsRbBMgVzGUl9u3jP7YfZTJBVoTtJBUZqHL1XFnnK6Glz+TvUyBZ8J0xN
	4oi13URptXRGHXQLYHVfUDfA3HmiglLqU8EmAaTDEfubOjOtMWl5+b10LubWtPLR
	9WWWPEPCVDmzaPvcJAw9umLfQneMwNtuqSj09r+aPHWgLsqQmtGjighcx/VUOcma
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hpjhb2ds2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:09:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A3G9ldB003118
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:09:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 3 Nov
 2026 11:09:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 3 Nov 2026 11:09:47 -0500
Received: from HYB-6AVb5If9qTU.tail230d3d.ts.net (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A3G9KcN032393;
	Tue, 3 Nov 2026 11:09:42 -0500
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
Subject: [PATCH net-next 1/5] net: ethernet: oa_tc6: Allow custom reset settle time values
Date: Tue, 3 Nov 2026 18:09:14 +0200
Message-ID: <20261103160918.409701-2-iustin.stolniceanu@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX5RFtlUo/3B+9
 gFFgQrLU2yaJkzsyFRy2F1LUF6YxmjsKnO+cPUfD4ZG1EuqNqivgdeSl69ySDDC3iFkrILBVueX
 VopXknHWbscHWVyiB+ZlVfqQLixMdsH8Ayd2ciNrnwb3MGTRX7Kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXz5cbNoO49+US
 GYDs+50yfyMPSGq0vl4pbl7vITOfaiaDv+SnVwWfS9rNbfss5wmPRejgI9g7uB4JZS6d/U79UJu
 yK+PLInckF6nI6RbsfvPzjN3xDl41JmuEf9U5MqcraEsE3CDpT7TSGhycCsbKoJaiKrHfLXKQuf
 PJuP5bKWSLwSNNmTSnwcwxLg12si6gTzGbsWLGJyhGL1k4pvFjlZFK7MoNZtX9wAEoQT0CeJ+O8
 mwlGUl/0Ii2lFBHclp0GQAMbmV62sfatM90ErguYsQACG+ip1PQTmPq4wTQJZ4hFVtvtBkeubsQ
 LEd8w4UXY57oSRKBFzGs1CeLZ/ssyZL1DST9f7t7PijeVPEvM14d4xfKPKsofwZGsIymMJAwPst
 jHbf4F9I2fre44eo9awQ1zLrF5AuRXMoicGaZ5x981bt8GTf4SSiHKxgdfIno7frI8/3tNAx5S5
 thX/8pvzszyxc0D7tNw==
X-Proofpoint-GUID: kgofkngRpaTomDIFF9RLZhIHRiZxNDOV
X-Proofpoint-ORIG-GUID: kgofkngRpaTomDIFF9RLZhIHRiZxNDOV
X-Authority-Analysis: v=2.4 cv=cbtHPXDM c=1 sm=1 tr=0 ts=6aea074c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=mw5lWVp0h_6J4_CgEXoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

From: Ciprian Regus <ciprian.regus@analog.com>

oa_tc6_init() waits a fixed 1 ms after deasserting the reset GPIO
before accessing the MAC-PHY. The reset timing parameters of a MAC-PHY
device are outside of the OA TC6 scope. For example, the ADIN1110 needs
up to 50 ms after RESET is deasserted before its registers can be
accessed.

Add a reset_settle_us field to struct oa_tc6_quirks so drivers can
set this time. If it is not set, the GPIO reset keeps the existing
1 ms wait.

When set, also apply the wait after the software reset, before polling
STATUS0 for RESETC. This is needed for devices that tristate their SDO
pin during a reset. Drivers that don't set reset_settle_us keep the
current behaviour.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Co-developed-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/ethernet/oa_tc6.c | 18 ++++++++++++++----
 include/linux/oa_tc6.h        |  2 ++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 364027c39fa4..68437b226528 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -89,6 +89,7 @@ struct oa_tc6 {
 	bool int_flag;
 	bool disable_traffic;
 	bool prot_ctrl;
+	u32 reset_settle_us;
 	enum oa_tc6_quirk_flag quirk_flags;
 	struct gpio_desc *reset_gpio;
 };
@@ -652,6 +653,9 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
+	if (tc6->reset_settle_us)
+		fsleep(tc6->reset_settle_us);
+
 	/* Poll for soft reset complete for every 1ms until 1s timeout */
 	ret = readx_poll_timeout(oa_tc6_read_status0, tc6, regval,
 				 regval & OA_TC6_STATUS0_RESETC,
@@ -1474,8 +1478,10 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
 
-	if (quirks)
+	if (quirks) {
 		tc6->quirk_flags = quirks->quirk_flags;
+		tc6->reset_settle_us = quirks->reset_settle_us;
+	}
 
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
@@ -1515,12 +1521,16 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 					     "failed to get reset gpio\n"));
 
 	if (tc6->reset_gpio) {
-		/* Keep the reset asserted for 10 us and then allow 1 ms of
-		 * settle time for the crystal oscillator startup.
+		/* Keep the reset asserted for 10 us and then allow the reset
+		 * settle time (1 ms by default) for the crystal oscillator
+		 * startup.
 		 */
 		fsleep(10);
 		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
-		fsleep(1000);
+		if (tc6->reset_settle_us)
+			fsleep(tc6->reset_settle_us);
+		else
+			fsleep(1000);
 	}
 
 	/* Check the PROTE bit status so that we can reset the device */
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 27f652d4920b..139dd4c33950 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -72,6 +72,8 @@ enum oa_tc6_quirk_flag {
 
 struct oa_tc6_quirks {
 	enum oa_tc6_quirk_flag quirk_flags;
+	/* Wait after the GPIO reset (default 1 ms) and the software reset */
+	u32 reset_settle_us;
 };
 
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
-- 
2.43.0

