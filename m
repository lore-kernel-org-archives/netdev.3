Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722215;
	b=gGzWpFhD5z8tzl5IlDBWauZT3KhPLhdwJBbf8DwxhldWiqtEZh6aWDKeO6lPzMjFDiL5
	 fiSdF2oqn08F0xs91JXv6dLhUuReIsFJ/Az7I6UVh6Yk1Xn0dnaTCrRrV1AYsba4zocbj
	 sM9xicTwuKDJ6iTzZ/d5hXQ/mDXacu1wbqYSYC30jIWjIIOxHqWhsvN8tpAYRhqTtuUHQ
	 xvnqye8RKYlZCf8vcnaWfsUKQFllQ428BNxq412l3pfKO6EL57iaJ5pRZdLbUqbwWoXi1
	 fcBBAj8rV1PIdEspjlj9HaplUK4LVkHTOmTUT5MkZDJ7KP32Ae9urkbUWqN3BZCMZFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722215;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=P1bSBjD4HaCmboNg/mxabqOFTS/BVJsK1hCF76/NDUs=;
	b=I2ksaYeLyqcQIoK7PetpWL3WhIu+gFdguBeNa/avgA21deeyoIyTvlB0vGi7nfgTDVD7
	 Vz/a0rhOjgoCTVZLw6eJBkrNpjdW3vEMzDJM/NjpXL3d4ee3FNfJE7o3Ad8m9cnQ24UGw
	 nRq/DeWTXkLc6ITCmohddBDEAd0Vka3bi4chz+IG3mMHpAgXX1mVDZl5fduxq47c8Vt8p
	 /pJq3XM40QOGxH1vPRtLGamgH3xfXv1I8zgvvG7lhO+qR5yW3AeWbJo8ScrGEZ3Y2X0mU
	 HdGetSzE7x3x7LckxldQjDH3lmFBhkRYzPBrjKmMa2q2VSls1lhtwPAGDTDk52Zuylg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OR9F7Bun;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=kszu14Xz;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78523606A324;
	Tue,  3 Nov 2026 16:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78523606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OR9F7Bun;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=kszu14Xz
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E83cb3533134;
	Tue, 3 Nov 2026 11:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=P1bSBjD4HaCmboNg/mxabqOFTS/BVJsK1hCF76/NDUs=; b=OR9F7Bu
	nnDuQXAccyhg+H2Kml9LuJQDzQsy83TFUIwl5Bf+ew6OKuICemUcaZG/BI47gDN6
	LWFl5FbVrqhw71y13ay0Eta6dqSGEUz4S5jarPqnlakwjAHEqyg8QEF55ZV/oLbv
	/SsspL1v8vVufd5ZA5a4CnH5X1U+Fy+Rin1BwDbquAgCy8vKmUQwvRe5A9qv2fVr
	92Q0kgYsrS3o/uournIi8weF7jTnhJqm1EuoLFYK6V2jFo935LjJdOv5T4WILH5+
	qjZNGV+pGXCB4kpYHvuPnZeBvgPKW7IpdHduH50aqEdBb7ntfOjhF7iJvOcoU048
	fBir0HN8I9Pchtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P1bSB
	jD4HaCmboNg/mxabqOFTS/BVJsK1hCF76/NDUs=; b=kszu14XzVSMIrrqMjRIDe
	sT1KgGweZGTsAXYMtHgP54Q9nBH/uc7ZoI8HMi8dNrA4ZuDXPEPBO0uJg1svO0/E
	G+jWNJWh5BIJ40m9LpKq9Jj3pmAsfyv54BKSaRlVfp7LTzTswdNYhqcbVtJuCGbM
	NKUhPq6mSjbb+YBGP+a8oD2UFINKIliIm5sFVVUiWyU99E986Uj9BbQYnvLWxxU9
	KytWWD7SGrM5U0KChD1Fq9WCGPBbJKY0GoOIqlP43z+73PUhhaaWu5bSsF/W2pTD
	l4iuEZ4IIK1sDNw6UIU1NjfvguyY40GLfejSbKrAiT55Tpj8/Fo7pBRLjSwWWF9j
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hpjhb2dt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:10:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A3GA26H029879
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:10:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 3 Nov 2026 11:10:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 3 Nov 2026 11:10:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 3 Nov 2026 11:10:01 -0500
Received: from HYB-6AVb5If9qTU.tail230d3d.ts.net (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A3G9KcO032393;
	Tue, 3 Nov 2026 11:09:54 -0500
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
Subject: [PATCH net-next 2/5] net: ethernet: oa_tc6: Add support for MDIO indirect access
Date: Tue, 3 Nov 2026 18:09:15 +0200
Message-ID: <20261103160918.409701-3-iustin.stolniceanu@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXwH/pm7bueJ4l
 C1NO4VDZoVdUdaCcSY+uFtgYyHlDqy53I6yuUm6IRfQ9chJ1741dwo2my1lfXacVf2hewidMzPV
 1YnDXIxZkkRULzO2zq7bKj5KO2LVde7mFV+AXWoFMQRni6UWuza1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX5PZ3wlaZ/jpW
 pie9tpKsLQDjnz+5+BCzezVH1+/lRPnLem93f8HSlxXOQf+OIC4dcQit+jIOdfRFjZ/cy17E8Lh
 zXEYz2vqYgZ9LzILFC90c69hkQqrBk93fC1pwiTRUanTD0E/Ag+hNQNSQKxseL7AxoSGfhjAjO/
 7LR9sy3rsYcfh21fFIleHXs2eAf01fGdDL//XaA8T2mYhE8AfSC/jmiYC19z0qd3k56JCNkkyyp
 qZK3VsI3rjp5/dHCPIEW24NA7BrR3p+v+437sUdr9Yx/IXzdsZLYJMMaOSz83nboV0VL1qHyhkf
 mBG9OwGEIkjxzz8SvrqZ3QYf7CxulpM0nzaF7xaWLVRo+rdVIOC2noMrlMuxJmRsySa/IoaaojP
 F/AJvrmuwq+QdtEDH5m3RuTqhdgj648VFmZBak0AZyWsvYWEs1qin4uPj/pnYMcLgQJlPpjMEWl
 JyrrPMBK1wTvPrKjKXw==
X-Proofpoint-GUID: ot2pKy-Zyb6c9XCknoF-1cIj_QawcRmx
X-Proofpoint-ORIG-GUID: ot2pKy-Zyb6c9XCknoF-1cIj_QawcRmx
X-Authority-Analysis: v=2.4 cv=cbtHPXDM c=1 sm=1 tr=0 ts=6aea075b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=U-HMAtdv00Up3EeIBasA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

From: Ciprian Regus <ciprian.regus@analog.com>

The OPEN Alliance TC6 specification defines two ways for the SPI host
to access the registers of the PHY integrated in a MAC-PHY: direct
access, where the PHY registers are mapped into the MAC-PHY register
space, and indirect access, through the MDIOACC registers. A MAC-PHY
reports support for direct access through the DPRAC bit in the STDCAP
register.

The framework currently supports only direct access and fails to
register the MDIO bus when DPRAC is not set.

Read STDCAP when registering the MDIO bus and, if direct access is not
supported, implement the Clause 22 and Clause 45 MDIO operations as
indirect transactions through MDIOACC: for Clause 45, write the
address command to MDIOACC0 and the read or write command to
MDIOACC1; for Clause 22, write the command to MDIOACC1. Then poll
for TRDONE.

If TAERR (turnaround error) is set, no PHY answered at that address
and the DATA field must be ignored. Return 0xffff in that case, as
for an empty address on an MDIO bus, so that the PHY bus scan skips
the address instead of failing. Return -EIO for a write.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/ethernet/oa_tc6.c | 171 +++++++++++++++++++++++++++++++---
 include/linux/oa_tc6.h        |  15 +++
 2 files changed, 171 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 68437b226528..1c67ea0ff22b 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -89,6 +89,7 @@ struct oa_tc6 {
 	bool int_flag;
 	bool disable_traffic;
 	bool prot_ctrl;
+	bool mdio_indirect_mode;
 	u32 reset_settle_us;
 	enum oa_tc6_quirk_flag quirk_flags;
 	struct gpio_desc *reset_gpio;
@@ -435,24 +436,149 @@ int oa_tc6_write_register_mms(struct oa_tc6 *tc6, u8 mms, u16 address,
 }
 EXPORT_SYMBOL_GPL(oa_tc6_write_register_mms);
 
-static int oa_tc6_check_phy_reg_direct_access_capability(struct oa_tc6 *tc6)
+static void oa_tc6_handle_link_change(struct net_device *netdev)
 {
-	u32 regval;
+	phy_print_status(netdev->phydev);
+}
+
+static int oa_tc6_mdioacc_wait_done(struct oa_tc6 *tc6, u32 *regval)
+{
+	int ret, err;
+
+	ret = read_poll_timeout(oa_tc6_read_register, err,
+				err || (*regval & OA_TC6_MDIOACC_TRDONE),
+				100, 30000, false, tc6, OA_TC6_REG_MDIOACC(1),
+				regval);
+	if (ret)
+		return ret;
+
+	return err;
+}
+
+/* On a turnaround error no PHY answered and the DATA field must be ignored.
+ * Return all ones, like an MDIO bus with no PHY at that address, so that
+ * bus scanning skips the address instead of failing.
+ */
+static int oa_tc6_mdioacc_read_data(u32 reg_val)
+{
+	if (reg_val & OA_TC6_MDIOACC_TAERR)
+		return 0xffff;
+
+	return FIELD_GET(OA_TC6_MDIOACC_DATA, reg_val);
+}
+
+static int oa_tc6_mdioacc_write_done(struct oa_tc6 *tc6)
+{
+	u32 reg_val;
 	int ret;
 
-	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STDCAP, &regval);
+	ret = oa_tc6_mdioacc_wait_done(tc6, &reg_val);
 	if (ret)
 		return ret;
 
-	if (!(regval & OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS))
-		return -ENODEV;
+	return reg_val & OA_TC6_MDIOACC_TAERR ? -EIO : 0;
+}
 
-	return 0;
+static int oa_tc6_indirect_mdiobus_read_c45(struct oa_tc6 *tc6, int addr,
+					    int devnum, int regnum)
+{
+	u32 reg_val;
+	int ret;
+
+	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_ADDR);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C45);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, devnum);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DATA, regnum);
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(0), reg_val);
+	if (ret)
+		return ret;
+
+	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_RD);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C45);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, devnum);
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(1), reg_val);
+	if (ret)
+		return ret;
+
+	ret = oa_tc6_mdioacc_wait_done(tc6, &reg_val);
+	if (ret)
+		return ret;
+
+	return oa_tc6_mdioacc_read_data(reg_val);
 }
 
-static void oa_tc6_handle_link_change(struct net_device *netdev)
+static int oa_tc6_indirect_mdiobus_write_c45(struct oa_tc6 *tc6, int addr,
+					     int devnum, int regnum, u16 val)
 {
-	phy_print_status(netdev->phydev);
+	u32 reg_val;
+	int ret;
+
+	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_ADDR);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C45);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, devnum);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DATA, regnum);
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(0), reg_val);
+	if (ret)
+		return ret;
+
+	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_WR);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C45);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, devnum);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DATA, val);
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(1), reg_val);
+	if (ret)
+		return ret;
+
+	return oa_tc6_mdioacc_write_done(tc6);
+}
+
+static int oa_tc6_indirect_mdiobus_read(struct oa_tc6 *tc6, int addr,
+					int regnum)
+{
+	u32 reg_val;
+	int ret;
+
+	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_RD);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C22);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, regnum);
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(1), reg_val);
+	if (ret)
+		return ret;
+
+	ret = oa_tc6_mdioacc_wait_done(tc6, &reg_val);
+	if (ret)
+		return ret;
+
+	return oa_tc6_mdioacc_read_data(reg_val);
+}
+
+static int oa_tc6_indirect_mdiobus_write(struct oa_tc6 *tc6, int addr,
+					 int regnum, u16 val)
+{
+	u32 reg_val;
+	int ret;
+
+	reg_val = FIELD_PREP(OA_TC6_MDIOACC_OP, OA_TC6_MDIOACC_OP_WR);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_ST, OA_TC6_MDIOACC_ST_C22);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_PRTAD, addr);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DEVAD, regnum);
+	reg_val |= FIELD_PREP(OA_TC6_MDIOACC_DATA, val);
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_REG_MDIOACC(1), reg_val);
+	if (ret)
+		return ret;
+
+	return oa_tc6_mdioacc_write_done(tc6);
 }
 
 static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
@@ -461,6 +587,9 @@ static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
 	u32 regval;
 	int ret;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_read(tc6, addr, regnum);
+
 	ret = oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
 				   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
 				   &regval);
@@ -475,6 +604,9 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
 {
 	struct oa_tc6 *tc6 = bus->priv;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_write(tc6, addr, regnum, val);
+
 	return oa_tc6_write_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
 				     (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
 				     val);
@@ -506,6 +638,10 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 	int mms;
 	int ret;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_read_c45(tc6, addr, devnum,
+							regnum);
+
 	mms = oa_tc6_get_phy_c45_mms(devnum);
 	if (mms < 0)
 		return mms;
@@ -524,6 +660,10 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	struct oa_tc6 *tc6 = bus->priv;
 	int mms;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_write_c45(tc6, addr, devnum,
+							 regnum, val);
+
 	mms = oa_tc6_get_phy_c45_mms(devnum);
 	if (mms < 0)
 		return mms;
@@ -534,8 +674,16 @@ EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
 static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 {
+	u32 regval;
 	int ret;
 
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STDCAP, &regval);
+	if (ret)
+		return ret;
+
+	tc6->mdio_indirect_mode = !(OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS &
+				    regval);
+
 	tc6->mdiobus = mdiobus_alloc();
 	if (!tc6->mdiobus) {
 		netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
@@ -586,13 +734,6 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 	if (tc6->quirk_flags & OA_TC6_BROKEN_PHY)
 		return 0;
 
-	ret = oa_tc6_check_phy_reg_direct_access_capability(tc6);
-	if (ret) {
-		netdev_err(tc6->netdev,
-			   "Direct PHY register access is not supported by the MAC-PHY\n");
-		return ret;
-	}
-
 	ret = oa_tc6_mdiobus_register(tc6);
 	if (ret)
 		return ret;
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 139dd4c33950..e0627b99e569 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -50,6 +50,21 @@
 #define OA_TC6_INT_MASK0_ALL_INTERRUPTS                 (GENMASK(5, 0) | \
 							 GENMASK(12, 7))
 
+#define OA_TC6_REG_MDIOACC(x)	(0x20 + (x))
+#define OA_TC6_MDIOACC_TRDONE	BIT(31)
+#define OA_TC6_MDIOACC_TAERR	BIT(30)
+#define OA_TC6_MDIOACC_ST	GENMASK(29, 28)
+#define OA_TC6_MDIOACC_OP	GENMASK(27, 26)
+#define OA_TC6_MDIOACC_PRTAD	GENMASK(25, 21)
+#define OA_TC6_MDIOACC_DEVAD	GENMASK(20, 16)
+#define OA_TC6_MDIOACC_DATA	GENMASK(15, 0)
+
+#define OA_TC6_MDIOACC_ST_C45		0x0
+#define OA_TC6_MDIOACC_ST_C22		0x1
+#define OA_TC6_MDIOACC_OP_ADDR		0x0
+#define OA_TC6_MDIOACC_OP_WR		0x1
+#define OA_TC6_MDIOACC_OP_RD		0x3
+
 /* PHY Clause 22 registers base address and mask */
 #define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
 #define OA_TC6_PHY_STD_REG_ADDR_MASK		0x1F
-- 
2.43.0

