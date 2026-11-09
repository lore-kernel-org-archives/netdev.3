Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214861;
	b=ygjpZEhFPi6WfSfsKu0UkFkuxdoGzN9y3hvspckxMyxwBXZ6bQB6F221eQXD8PNfko/m
	 MxtrUc/NJLwRdKFkJW4ayXz4+zdE9w5a4BA6AC90ZB46I3sbGj5D64lkJsFYcCMxUFq8Y
	 swD5vwUf6bGOlBIJ7hvXPwA5Om6kuC7TPePB+tX984K6Vk5GiFyXkTlta3tI4HqHi5tbM
	 4HDoYhnhDUPRyMqgFIi6slV9VG3WCsKwgjuEoQQaXEnXFCV6CsPlv4HBH3ZN39ktCWSEJ
	 9rL4gVMkg1a28B4Cge2VPyFeUgjRMR1K0WOEhL3tqP51GTZwYGSJMbGfIZNRMCJSQRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214861;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wYgaf33YCSGvd1+TKBHqYk51SOLt5H37zybAWrE9mJY=;
	b=ejzWGoyQK6W0AcRL5KVfYrht6pGS2sx1XJnsFmXoAL+Br/ZxBF5VkqV6GH2bE3U0sHK5
	 uEDcCa2nE9A8Blk0ZMAFPYNr4+wQndJBQ9JQSsmE5ClbyBZT1JihNFhAYuRwdrEDhscL+
	 NxwX/KOFm3dPZaSxWI5VFf+gSpwaXloyLaj+MRsUccaehqQN10k6LmC6n3Hs4rer55Hsw
	 PlHDYKnDdHJIgKz0nzPpXt5Rblrf43/hGz6dJvtbVo14m71ND5gsKwhZoCuLkrKozU4go
	 0E8VMkBLD5rGQX6x5HrXFbwFboRjoY2gIgB0/OvGw3937BjvOeBe70NHQJsbrloZabA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UuW+vfNw;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=LlqlYNVO;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684F606D805;
	Mon,  9 Nov 2026 09:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4684F606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UuW+vfNw;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=LlqlYNVO
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96BtQ73169892;
	Mon, 9 Nov 2026 04:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=wYgaf33YCSGvd1+TKBHqYk51SOLt5H37zybAWrE9mJY=; b=UuW+vfN
	wEl02o+F2tDgvlWIry9wl2BUOlw7CaGTpVfZA4yeTItVk8sbmDZ7605WwtgECIUK
	gez6ggGrW6kMXUe7byQCpPXTPJmIEFTWVQYs/hb63WuyAOuj+4VrdmjrGFDKohaA
	fDjaRbCL3jtgboDvphxYeI/liAR7m0pYwNeNiFKovdvJagB+wBfhai+V+xzmjsY/
	0zRQziyhSCbf+threDo28z9Hpb8S5w4eQQpTkNfpIjq8GDleK7qvnGdM2uoZ6OIV
	4IPxz/6Adrbur6kpSfOL9643Ak5JQWjbdXkUG4CCsA8/NyYnCbj62PMxns87epEM
	HqgkUSlZ4lGZ59A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wYgaf
	33YCSGvd1+TKBHqYk51SOLt5H37zybAWrE9mJY=; b=LlqlYNVO7hPsaffkgtvmy
	aHr3RGnfPTnnbQPAjDa7koyvp3SsiPiKVHWD9X98DeiYfG3Ei6fHNOjEa/2/ol5O
	gdCnOt7wI2NUVhnMwEl+RgjHk83C3HGn50fjWDlyPTdW2Uc4rQwH3eBw4HGOAoWz
	1eEWJO5EZfuivGUy93mtco6zo3Y1G1UBPTLtTvG1nUTZtwmEj7aQMntyLjoZL90u
	oVDWpKaX0RJoUtFfSTPecFAsos+mAKExgDt5BuIheytkjRKUfVw9dCYA+MqqHbIm
	OjZBSLffHt+mD8hsTgc9V9qNSd9V2mr9IpEyk2M8n76SJ45YTkYEtcb9ogJSU4ZO
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ht1s7a8tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:00:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A990iVm032015
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:00:44 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 04:00:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:00:44 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreH024796;
	Mon, 9 Nov 2026 04:00:37 -0500
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
Subject: [PATCH net-next v2 2/7] net: ethernet: oa_tc6: Allow custom reset settle time values
Date: Mon, 9 Nov 2026 10:59:47 +0200
Message-ID: <20261109085952.105331-3-iustin.stolniceanu@analog.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=c4A+0h9l c=1 sm=1 tr=0 ts=6af18bbe cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=jwvB6ghkBqQFQwKxTisA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s_TRPih00Oq4jRVCSu5Jr5rVfwuPshUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX1a5JzFQQYJ4a
 GuBOytPnLvJNvY8hdchexijUjqlEL6M5Xai5Eyi3TzV7n/9Bw2dzo39xIZWWpL+iJXX1UiNsDOz
 RrNbWYdpk+qS12fe4AfYImlcoQlUNLK1zo/8HT0A2PS+Yilnh3vxCVPYuhYxWX0jD3wZLDWz/jO
 NRiZhkKjFdSnx1FGoT6xmHOznRQJhcM/Jg6zFKsj7b9TGjl+7/w2AXhDnyelgBYbZ6UPULP61ai
 J9N8/fYSHq381YGFD/njqC6YNdZpntrtlDHbGOCtlWhayEpKqDhuV0KCBfdFfT0+g4iCm5H+wD7
 DlyugoGRxxhIiKoSMmXLcAQIZSu8h7CPgpGO3cLa+TPgRE2rJBHHedKY71K90p2FODcoGULjVeK
 M5HBIsD1TZq1igveJZe0rlcuCANxFupEwZIyHcT0jTASqqSxAyLS7w4exDJMVSYT2A9qW/hFkES
 4RAiS+fS2997GqOSyag==
X-Proofpoint-ORIG-GUID: s_TRPih00Oq4jRVCSu5Jr5rVfwuPshUN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX0y2VaFaB3mfG
 ybIRKw2IdAAxNluMDXMkQVQeNCuEQf1A1eNsBu5i4r81l/yB2wQSe77jBbB+W2THo+8rgW2CaZV
 KNwIwOdf/ZU2p16TQIVT3lBsZ9/T1UKlbiCuNEF/Xi99vG29aFcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035

From: Ciprian Regus <ciprian.regus@analog.com>

oa_tc6_init() waits a fixed 1 ms after deasserting the reset GPIO
before accessing the MAC-PHY, and polls STATUS0 for RESETC right after
the software reset. The reset timing parameters of a MAC-PHY device are
outside of the OA TC6 scope. For example, the ADIN1110 needs up to 50 ms
after RESET is deasserted and up to 10 ms after a software reset before
its registers can be accessed, and it tristates its SDO pin during the
reset.

Add hwreset_settle_us and softreset_settle_us fields to struct
oa_tc6_quirks so drivers can set these times. If hwreset_settle_us is
not set, the GPIO reset keeps the existing 1 ms wait. If
softreset_settle_us is not set, there is no wait after the software
reset, as before.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Co-developed-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>
---
 drivers/net/ethernet/oa_tc6.c | 17 +++++++++++++----
 include/linux/oa_tc6.h        |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 364027c39fa4..549997ba363a 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -89,6 +89,8 @@ struct oa_tc6 {
 	bool int_flag;
 	bool disable_traffic;
 	bool prot_ctrl;
+	u32 hwreset_settle_us;
+	u32 softreset_settle_us;
 	enum oa_tc6_quirk_flag quirk_flags;
 	struct gpio_desc *reset_gpio;
 };
@@ -652,6 +654,8 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
 	if (ret)
 		return ret;
 
+	fsleep(tc6->softreset_settle_us);
+
 	/* Poll for soft reset complete for every 1ms until 1s timeout */
 	ret = readx_poll_timeout(oa_tc6_read_status0, tc6, regval,
 				 regval & OA_TC6_STATUS0_RESETC,
@@ -1474,8 +1478,13 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
 
-	if (quirks)
+	tc6->hwreset_settle_us = 1000;
+	if (quirks) {
 		tc6->quirk_flags = quirks->quirk_flags;
+		if (quirks->hwreset_settle_us)
+			tc6->hwreset_settle_us = quirks->hwreset_settle_us;
+		tc6->softreset_settle_us = quirks->softreset_settle_us;
+	}
 
 	/* Set the SPI controller to pump at realtime priority */
 	tc6->spi->rt = true;
@@ -1515,12 +1524,12 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 					     "failed to get reset gpio\n"));
 
 	if (tc6->reset_gpio) {
-		/* Keep the reset asserted for 10 us and then allow 1 ms of
-		 * settle time for the crystal oscillator startup.
+		/* Keep the reset asserted for 10 us and then allow the reset
+		 * settle time (1 ms by default).
 		 */
 		fsleep(10);
 		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
-		fsleep(1000);
+		fsleep(tc6->hwreset_settle_us);
 	}
 
 	/* Check the PROTE bit status so that we can reset the device */
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 6eac6b842156..f676e712e75d 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -73,6 +73,10 @@ enum oa_tc6_quirk_flag {
 
 struct oa_tc6_quirks {
 	enum oa_tc6_quirk_flag quirk_flags;
+	/* Wait after deasserting the reset GPIO, 1 ms if not set */
+	u32 hwreset_settle_us;
+	/* Wait after the software reset, before polling for RESETC */
+	u32 softreset_settle_us;
 };
 
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
-- 
2.43.0

