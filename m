Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B023EA8B;
	Sun,  9 Aug 2026 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307290; cv=fail; b=p+7hn9ZFB11mYrRC6h4+EGbuivW0xfgRfenU/K83WI5iCNlrC9B7a8TTba90QPPJvNFtIzJ/ask9rFL4iDQLw1v6vRoXSPGqLBbDavZBuOH/IZ+pAv1x4AACqAj2NFAImoWlM8n6+mP4C5jHuYb6Ak5CX34bKX/Wz58Aljj2atQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307290; c=relaxed/simple;
	bh=QB+rnQ6DF9saFHwiGzdLCd9opYqmDT97D1OQHCRa0MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JO0ERi8lu/dTbBr+fm2Jvm64UPHbXSJm2OdZjoZwWEOvCZEhFo1DVpSi1shfXj6TZhzbvP+NG42w8R9ds7H5y9xmWWeoGHogW/l2RvwY1XJVZmslCSBSIkT5faXvn04lYHeXKSdmBcLfFp2I7lUgpvqLFWF4bWWMeURd3GpY/Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=UWJdPdwi; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rM2VHEaR; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="UWJdPdwi";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rM2VHEaR"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 679I9wpP647437;
	Sun, 9 Aug 2026 15:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=EneIel0hi3yzdvnGmC8ZhH7vqzouCuDEqESnqQYsM
	3k=; b=UWJdPdwiYrXE/B9RCx+S2p7AMOLahWKhuy35dEBWxFkVntX9+ZiaXMg71
	CISCDr2PuDYAyUPm2cVBXx/mGwjdWogvYr/Nu0EhOvqH8Evdw/8ooIH0Z45TlQZb
	8rXIr7rfGXeq3QivIpIW2cWSVxr2XFPd3uosTvh2qTAWjaMfeyTHIbXTFQTilSij
	MRy3OZ1Y1ZyfxL+30fp6hSf528BJ9tRB+XKi1Pgf+md7Pt1k79p0SLGqJSulU8um
	jhEk1hAXR1rBcv7oUfHQ4ifqs7onPkC+cuwEwzocP1j47ifRvb/XUg3lIHUUIo1W
	704LJaSL5s++I23WuOH0LUHmlQyFQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fxnfna6d0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 15:27:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2rOgbS9NDrFx9tSntjyRcGWJMMQpp0OqSAgM5PP3RWyl6Sff94slyw/kVj9ZOeR8oqc4J2twFQmZ5/VpO73FRFLxsbCsRbLWGhkyI3IX8aZ4ote2oIwDklkpWyA3UwUxtTOEi3sS9caQye3odQC470njclycHV5IjiCWPm1CmdfbuNSX4fD2WeWvZgJKh/s7oYaADqE5m6m2T8qFKdeyrgBYr5ctpgMcYsXar/mnti1VkSd6Ivk1M+wjNAt7QVfmJZs/9zJOHwko7S2BT0hj2aI6XX1Uo3ZNKqg7Q1NG67VnI5ZEwExG03AY16LdvgcoH2zmfWMZ6O/g3+CGLlfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EneIel0hi3yzdvnGmC8ZhH7vqzouCuDEqESnqQYsM3k=;
 b=VJAQJ3+iUfDdhxJ4dsXJDm31NqoPmsT+37MJxmfhQJR9sT5zUVZ0BnuNMPI8uNtEwDP1sUWurRV52FWuIbcjELRgb4ibpC2bYKrvWVtuzjFpcWgN5+PD5GwOeWU1oqSpMnnquhOkIffgYOxqFpoB+Bssif6pPTleP/dLyIE3hHGQLT82xATISzLMO1tzSvproAP1VLf0atJgi+L7LoproA0qY9v6BWhSpTJp1294mjCa7m3mkTnj5pX9vbIOh4Oqn5na4o3ge2j0KUvp8azhs2SGW6f0W2VbkC47gKP5EnbiKWpGzOMEFRfkX9APOh1VLAsMpWo2iXjuYnGVKRaCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EneIel0hi3yzdvnGmC8ZhH7vqzouCuDEqESnqQYsM3k=;
 b=rM2VHEaRZERR6ltPdRL0SwXFvHwRvTj5zwwmaUjAy39LoxaUyBjSh3BwEfP3IULRsC8mRbcCFSLa106aHhPV1TjYtj8QoG6IpjSeRErA+q2+HrdgmcW+fYG6F8BnufMfRVBLdxXQQ7VlCiVg+YOsHnHVXK1QOBk5NO/Ejx5dFuU=
Received: from SA1PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:2ce::7)
 by BN0PR10MB5112.namprd10.prod.outlook.com (2603:10b6:408:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Sun, 9 Aug
 2026 20:27:14 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::43) by SA1PR04CA0003.outlook.office365.com
 (2603:10b6:806:2ce::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Sun, 9
 Aug 2026 20:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Sun, 9 Aug 2026 20:27:14 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 9 Aug
 2026 15:27:14 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 9 Aug
 2026 15:27:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 9 Aug 2026 15:27:13 -0500
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 679KR8ih1720399;
	Sun, 9 Aug 2026 15:27:09 -0500
Message-ID: <45dec3bc-eee9-4014-b519-d1cd78c3440b@ti.com>
Date: Mon, 10 Aug 2026 01:57:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix port_id
 extraction from SRC TAG
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
        <v-singh1@ti.com>, <nm@ti.com>, <daniel.zahka@gmail.com>,
        <nora.schiffer@ew.tq-group.com>, <oss@vassilevski.com>,
        <grygorii.strashko@ti.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20260807111738.2055900-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20260807111738.2055900-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|BN0PR10MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 13435390-5a31-4058-6cb8-08def654995a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|22082099003|10067099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	vdWr1eQ3g+m3oOBOd2Rd9vnEJACclP1yQUy0uk9o3v4R5OP56stIPH/K4RDqxtk2WxOtRL4WcWff1ZCjHSQjmjMQOHfo0d5JkcuQasd0juLzfWbNqJK+9LfwuLW+nxyOx8SOYXs7KG4yRxtpqwKyrWN/sJ6cnyf+uWnyrP8oXD2tcBz0OlFOpOo78Va2y2fVEAkYM6kY4GPreqMzHmB8P7yTalWB/34YX5pOsHtmYhqLX+MqMhHXTXmzjgDBR1CYFzRL7R98CutNWfSdARpfrHZW7xwiWwLRCAegqHAb6V7Ho5uCbTjNcP0k35kBbFlkj7TXqn07t61sDI1sWs+zE0rorng62L391yW18w/Ppk9woiZVDapgb3+0RE7TsjeC4PVZQ9snb94Nb7XAhY9PFfswBnje769Fp6uUmdRQzmKVM5It6UnKbtWCMtOLX7cuBlcBaEhY7lozRaIrIQdAtXWoeVlIZO/WPIYuX3L8URn4UtA0bufZspzZa32Uc3UjEqTReLi35CjqQLimrPdayNuHLGOWZQgQyDA6ySnZuQi4L7Qe656zowtjaUxDetLGxd+kqUEDMGS47Xq9eXqAm53+TjRlE6tUWJ0dw4A0XVcDINxgde56Cswj4Ar+pxZ625WF5XoEOBSVG13jsx8wkO9VQSkmYRDAlFmm9z3MqeRMwbkYfrO63ybfUetRejet1gBI9pYqLMCutWmuLNnNVFBAV1SgMDss4xqjOxp+PBZH6h7A5+1DbjS70XXLD4zZ
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(22082099003)(10067099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pi70H7cwGvAMmUku+1+VjWq5Bz7yz4Rg6l4ZRxkrdajz558gsj8H2bAhFUeuVzBYah9OrhxtHcR0iz45JNBUkDXYWXSmg1kfJUWnj/QkIFC4OYQ1Mf8l+R5Hr6EzwBbJxxXQ4gmb5KDlEL9ACDprtPVLEFEJc+QSy9F8D9VahtXZ/z5hdPZOHWhAKzgHUDkp+/lPdodLrDxoS+NRCmMRBOZ3laNlZMuYnv53bVufefq0BSDnpqbCdYhOBN5xLtK9H/l/Q/X2HBke0xVbnaFSxYn/m6c5iLF8NsKuaU6f8P1YvNJLvbLLSSL2U3/NeP4nSaJ+gnXYVVgJyew3mPzQbb4otKdICIqPMn/7ncL9zMOku7goCKeTFcyNCtsRN3lc0vEb5DFyTpTCFKQFR2sWFGaKrqjiban0qu9IvVC6gy/AmOo1lVyoTYSBs1aMZ4bz
X-Exchange-RoutingPolicyChecked:
	cBs+kX2TH99Ikvu8PK8z417qgELYMQJD9HuBU1m35thR3ZpbVasEce8r6mLr9lpjR62rYic8j+gf0ex5Y0yIdEQbK65vbjs8IyuioHZQUdWEPkgKbBZ6OCXvLqGaiaJ8xUWIXfOPrXbs/t6H2wLhDCVY4xYC8lPPJJlEtjkWcecEhUo6l43YjuzHwTs+W0y9uZrRwq7jb0rU+oOdFGGBmlDbpAnWYY+u0dSn4ptIj6FjwxRtMADHTsDoKlvY682WMYcKn/4fS1fos4yjtTdQZRfkF/A7zAUoLrdc9fECBmg2DBXSIzUcqoQ2qfQUl8s10VJFDN2aBGqTRyNjX2wQ2g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 20:27:14.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13435390-5a31-4058-6cb8-08def654995a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5112
X-Proofpoint-GUID: LPdAjXMDYTmMINhi8Ms9zjLgHYEdT8hU
X-Authority-Analysis: v=2.4 cv=QeRWeMbv c=1 sm=1 tr=0 ts=6a78e2a4 cx=c_pps
 a=2g0TT6LSTZPcbpz8VOOaeA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=uaIRmOerGBg_cDUUTbIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LPdAjXMDYTmMINhi8Ms9zjLgHYEdT8hU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4NSBTYWx0ZWRfXwNw1faMrsOT0
 BJlw8xN2kHEKCPaUl63ZEK2KE9Oe7xnVBq1ToOK4/lqTwVioSNBcpAGXvt8uFaydCtg4lYaUM1J
 FuIS3M+nXE7WjBPqNaD/TFRDxVq1TtZnuhKMLcieKUz03WZapul7G4z9V+tRJbWr5Y7G4dIX/vF
 bk1CnEnS1GAn0QWFyIXjbl9EriuCraldlkp31M6SRqbNRncaR0FxyxWgdTeWGAF8x8wACxtOhLp
 dqSnUyZya9b0gl1KNGMnov2eqYDwyz/HJ/eOhikWtpV7h5DtESEhzZShIaeaPfNMhnTa4G49ibo
 /cKzgOE3EdPw/LPvzfgXo/MGyKlgZXxPbrqDLPT1UNgRzsDUcS8QHfVNxn5y0mZLw5JE1IlXdQ6
 Qx8WxuQF83p8Vj+xh3NOjG4jzmolpVcOPRSbVRL8R6m5fVgxw+SmnpO9IOs3YGmgwFeDA0YDod3
 gIMP0Pp6niA7Xj88BzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4NSBTYWx0ZWRfX3629jfbx+Xr3
 wj3ZjfvkvARCEGLjioa7E/Ld7np41Zo9/+HdrUW8lNKyx0S1EspOWSQofrwYO/0XSXb+twhXkDd
 N/yclHZvRj21cRkMmnH4vSTCFwOoIfE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090185



On 07/08/26 16:47, Siddharth Vadapalli wrote:
> On the packet reception path, the ID of the MAC Port on which the packet
> was received, is embedded in the RX DMA Descriptor's metadata. The ID is
> extracted using the helper function cppi5_desc_get_tags_ids() which fills
> in the 16-bit Source Tag into the 'port_id' variable. However, it is only
> the lower 8-bits of the 16-bit Source Tag that represent the MAC Port ID,
> while the upper 8-bits are Hardware-Reserved and carry an arbitrary value.
> With the existing logic, sporadic kernel crash is observed due to the
> subsequent driver code accessing out-of-bound memory because of an invalid
> port_id.
> 
> Hence, fix the port_id extraction logic to use only the lower 8-bits of the
> Source Tag as the MAC Port ID.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-44' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> of Mainline Linux.
> 
> I have observed it in practice that the RESERVED field contains non-zero
> value (such as 0xFF on one instance) causing port_id to be set to an
> invalid value (such as 0xFF01 in that instance) resulting in the subsequent
> driver code accessing out-of-bound / incorrect memory and corrupting it and
> causing a kernel crash. To summarize, this patch is fixing a real issue and
> not a hypothetical one.
> 
> Regards,
> Siddharth.
> 
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 434a31080855..6330540979d7 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -1310,6 +1310,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
>   	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
>   	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
>   	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
> +	/* Port ID is contained in the lower 8-bits of the 16-bit Source Tag */
> +	port_id &= 0xFF;
>   	dev_dbg(dev, "%s rx port_id:%d\n", __func__, port_id);
>   	port = am65_common_get_port(common, port_id);
>   	ndev = port->ndev;


Reviewed-by: Chintan Vankar <c-vankar@ti.com>

Regards,
Chintan.
