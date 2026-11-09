Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214883;
	b=exNQToPJQmo2gTbHpX98FlBT1FqHC6lW0ew8OK0onOMHIPNBN/9SuRlUf/KwdXApI6dK
	 etU/YjzD9mT/YdeFPab5X8591+r+1YxkCAxJ3SOPQ7dBJd+YQGx03C1+s8EhHFXOAPQ/c
	 ehkmXuG4XaGpp05fIPjpHcbvaZEokfduyKHSQqK3d8aCLbh7qsnw73P5SXD2dpvSjQXhD
	 98qteQ6HB5JNP1NIPDg4j0s4Exnkdw0tIJMdEvAT48oOBbmZB61ZA3Oo1uR63TM0y3eJF
	 27DgxONJK51FC1JYrdbnDIBmHvmbUVypJBu/FdhRCsJinOSpyH2ni2FxJuzRM4wT4dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214883;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jRSxakWFobOjaN7tHnTo1HI5v5IJJwgk4Ao9wBMszZw=;
	b=2Xn2JSHWZxoHXZr6F9wdpXArQMKHugZWnvVDcbH9+mTE1AFhblBLnSqneGSGtOoQ7VXH
	 skVLbo1H4nLuNy6qgbV2iQ8kQ8zHS4odcbgWQ3AGRTyO3CACsl8mwIPdkT3qPfTldu65c
	 OTSN94ptf0L66ey3BwhTr3glO+koQ+ble8zR2SDtv3aZ8AiA8ZHTWL1b1WpMqy9Q35jrb
	 kodNygsBr1OwtTOxKSUAsdjFSQrI/YRPeqJEry1LimYn1tZ36Vb9yIyWK95lalEMj84/1
	 rutboE8Fnuv7Yvj0/repZm44g5RSnhzXsLIX2oZHBiT7gHWaMMNIC1KwXahmHEXH5rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RIRDacO0;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xMdwR3iw;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827DE606A31C;
	Mon,  9 Nov 2026 09:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RIRDacO0;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xMdwR3iw
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96BuNN3169932;
	Mon, 9 Nov 2026 04:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=jRSxakWFobOjaN7tHnTo1HI5v5IJJwgk4Ao9wBMszZw=; b=RIRDacO
	08nUXKnS1TEYB8EXZ7USy6rkvlCO2rr9doiCqz4utfHYDuBQwPgJ5CMN/0OzhxO2
	GXP4VrZOKyx1Ek6DW/SxKPdsbpGeNar02RkM/nOdXfkWs0vQdMwdpuAUTstPeEwB
	YhWBF3vWd6HCZ10Q6QCzeYApstDZwTtR3aEUxjKTo/SjAH3hazIVaWWW+hCoL2Cc
	HwzC0B05ZsPLe4yCSMMuJyN+GRVyT7Luf1QdVSIrq6dyZAbgciZizBt3xnT4iqVX
	XkH+A5n8tt85uRQGwI2neZ3b1BE0HmAvmQYkWlYUsvmmKmjEnpQnPoM4YJkfe0+1
	NGkGPOpAi21WAiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jRSxa
	kWFobOjaN7tHnTo1HI5v5IJJwgk4Ao9wBMszZw=; b=xMdwR3iwL7SJRiODIc+zf
	AwMAOVSA1xQEV74nIAAWCi7WvIqN97/hGLralF+dn9qHxGg4yESTiIVYFfp7n7Iy
	Qyusc5pCYp3+PhsU66DK5GPjkzNm5GwIKSLbK5gGYlc1GwpgCTvMG7SPnh6smtWy
	+w/dPAabOudz0RJbGw5QLFsYgWJjlie6TBkZgUkGz1xLXk8QqQiluRqgWt/i8ObL
	ACVOuJbcyHPWBok8OIwwZ0p0nd/iDBpY4X3XMwxAxymywCp+RtPDHkRiUR5yBGWA
	fQpdFHy8WRFzt29hheyfvvEvMAx2fwVQR1qcTpfvpDfZ/8Xx63QQYj+mAcQZEb15
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ht1s7a8y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:01:12 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A991Al4045741
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:01:11 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 04:01:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:01:10 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreI024796;
	Mon, 9 Nov 2026 04:01:03 -0500
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
Subject: [PATCH net-next v2 3/7] net: ethernet: oa_tc6: Add support for MDIO indirect access
Date: Mon, 9 Nov 2026 10:59:48 +0200
Message-ID: <20261109085952.105331-4-iustin.stolniceanu@analog.com>
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
X-Authority-Analysis: v=2.4 cv=c4A+0h9l c=1 sm=1 tr=0 ts=6af18bd8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=U-HMAtdv00Up3EeIBasA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eQ2YZINO3Y5lBRE9Djl9kAyslu7kOXUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX6HLRy6730soB
 tj1Dp9orZrnaqUJfG8AVxFgWhNZnO1a+5nprPRNMH0ZeGwFtrYvX51t+Mxoc9Xbc/fcyU8++5S3
 3oQCMDMJUyuVqHDvUEucTph7wxi/+77lDaF7jmpoIij3QwjfvbkSU8BkRSjQy2Z5+2iSbZxZymj
 Di48pST92kcCWz0Md17z/LM3X05ZnCK7CSNmS9Qu4Cc4YndnpxacuPTKTUWGxY/KWX2HVh5cgg/
 dZAu3j9eBMWNtScNw9W/z113TX384Hjk69/HMPib8J/yqc0gy2tzbzCE15mGa+r+F0qtmYDhfl9
 7x8bEKrGe3JYWx6TAHu8iJIt0bhrqL8ntgS2TXGuLUsb3Tvpn4Wd5kPbJKa2Q6HuVTDVaDU+IcI
 uh/6lBOr1jB3EBu84hINQSTAVhEmSOf7ggY5JFHEngwwxb9NIKd0Q6DZ7yESN3rk2SzloOvaIJp
 /qcECxqzJAl8F9mBkPw==
X-Proofpoint-ORIG-GUID: eQ2YZINO3Y5lBRE9Djl9kAyslu7kOXUS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX2KdpFoRiiVRN
 fAKEMBbx5ebH/j4CK9bPObdH7r0VCtaLxCZPXkI7ADRdfYxK41jXwQv95Z5X5tP4dRpLdHYxOuT
 TIVqk8+e6Yudliy62+RrsAibwLXVQuZRmZzR1dVmSSBO6GcJ1Op4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035

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
Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>
---
 drivers/net/ethernet/oa_tc6.c | 171 +++++++++++++++++++++++++++++++---
 include/linux/oa_tc6.h        |  15 +++
 2 files changed, 171 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 549997ba363a..be1833c232e3 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -89,6 +89,7 @@ struct oa_tc6 {
 	bool int_flag;
 	bool disable_traffic;
 	bool prot_ctrl;
+	bool mdio_indirect_mode;
 	u32 hwreset_settle_us;
 	u32 softreset_settle_us;
 	enum oa_tc6_quirk_flag quirk_flags;
@@ -436,24 +437,149 @@ int oa_tc6_write_register_mms(struct oa_tc6 *tc6, u8 mms, u16 address,
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
@@ -462,6 +588,9 @@ static int oa_tc6_mdiobus_read(struct mii_bus *bus, int addr, int regnum)
 	u32 regval;
 	int ret;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_read(tc6, addr, regnum);
+
 	ret = oa_tc6_read_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
 				   (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
 				   &regval);
@@ -476,6 +605,9 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
 {
 	struct oa_tc6 *tc6 = bus->priv;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_write(tc6, addr, regnum, val);
+
 	return oa_tc6_write_register(tc6, OA_TC6_PHY_STD_REG_ADDR_BASE |
 				     (regnum & OA_TC6_PHY_STD_REG_ADDR_MASK),
 				     val);
@@ -507,6 +639,10 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 	int mms;
 	int ret;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_read_c45(tc6, addr, devnum,
+							regnum);
+
 	mms = oa_tc6_get_phy_c45_mms(devnum);
 	if (mms < 0)
 		return mms;
@@ -525,6 +661,10 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	struct oa_tc6 *tc6 = bus->priv;
 	int mms;
 
+	if (tc6->mdio_indirect_mode)
+		return oa_tc6_indirect_mdiobus_write_c45(tc6, addr, devnum,
+							 regnum, val);
+
 	mms = oa_tc6_get_phy_c45_mms(devnum);
 	if (mms < 0)
 		return mms;
@@ -535,8 +675,16 @@ EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
 
 static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 {
+	u32 regval;
 	int ret;
 
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STDCAP, &regval);
+	if (ret)
+		return ret;
+
+	if (!(regval & OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS))
+		tc6->mdio_indirect_mode = true;
+
 	tc6->mdiobus = mdiobus_alloc();
 	if (!tc6->mdiobus) {
 		netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
@@ -587,13 +735,6 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
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
index f676e712e75d..d4fce06ed93b 100644
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

