Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DB3A9618;
	Tue,  8 Sep 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879791; cv=fail; b=j0XrE6ePPjfRbWOErxkNbZwxubTlPn3hlFEehE66+goRFXLjSEbGTg31Ja7RnThDVfgJ/XKVnGOA3RHcEWEJht78nabQKRo9RWasuKHEvy+RZevj8Lke8Nudsblfp+EeZ1eG4hWOw/0rvO95cZ9vLxglMhgfafW20QfQw1YfP3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879791; c=relaxed/simple;
	bh=rKsppWxheYrcA8uV2Bjx2m2e+4tQ3YFQzYHCIOaZatU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QnOqRA6CwOpms9VQ030En4a3qrBB7g7M2xi6DenEKdlF/Md6uqDZL8Ye5BpalL5MIdei6P87U28FKJd8xeevPw8fKR9YB7GT79CUttu/kWu3ec83ZPiCUtJSKpUoA8uMLUZPXELdu/745pNH5kCwqPg47EhpWtac8eDBKy+i3bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=WviY8D6C; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n+AGKRS2; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="WviY8D6C";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n+AGKRS2"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688ElRE81845025;
	Tue, 8 Sep 2026 10:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=aKEDJbqKw2mkdJN1kzZaLR0tX/9VayQsnKxG7ofcJ
	7w=; b=WviY8D6CZuFmEPFyE/h14fCG+wCXA2+D/v4qCBN3qq7ab8i4rCY0rKMAR
	IMYTTqjfe7Ybv3WzhrSBwiFLwbZtq+z46p9zJVpLjGVmtpPvC4Enhm9P+O2Vk+jF
	Wd2o23y6+Lc4Zes/YFUuSopFED8jfkSuFVo9U+GkKZWYelsywyVwH3nnccnFLrRv
	xyhXaYFTfiT3nf+HSs+tqwObSU87acOZf0VY+xNrGpp30rkbqxvoySmaWj/xqfPk
	B/wM66eku3XkO0IEiFxQKQRwE7kaNSyUJ0HsM0s0QA9CttEUFuz/LEgz5dwgaP42
	2CUJus6KOAIOwFSeGOUeAXPEwpZsg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940mc3y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:02:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaoScmQ8Fm5udCYgcWeBnC3ZdS+9vGC4RnsEgH4O2X9OokfP7LMcv/5PbjnecB72T/qQxmeUqNGPf59krUupFMLOERkTHCvRKzZd7ldqCSdHQPBOWACIJ6RXYBHW7c+uqVdZkR6AxloyrJYJLOkPIvlhIxwE4i3PTyFcTe1m/agwI0m1yO30aY/h59andPmLcmE/eciXnP3BEFR6TevKchCS4U8iWAD7pRzlu+g8ZoXTrgqVQ+GkN3PNK85YeTKNui6Q6KWDsfXUbMca5RYnhGgdtDuyGaXY8HoVMtecYl4nJclRSl4DJlbEK0ld5H0Idsii4W3SfTSnkKkIB+U6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKEDJbqKw2mkdJN1kzZaLR0tX/9VayQsnKxG7ofcJ7w=;
 b=nCY81W3dFtWLhqUImJio/QTnUs7jtf+M/jJho00WbQizssncu4lDco1UShbNrGYFRGK0vIfXOcmBowIPhtN8PGNbILqxuq47NkbMibJE1epz85+op+0MhaaIciwqJwBh0XkLL58/dkOZtmaAXMZ6yZx9pQwttQ18ji6GMGkty6JlE4tLHa4AnGOk7fF72CJznmS8T7smVgIbubGlOdIyNpsUX72B7HsN/ywKbCwYnsiY7xr3DMf0PZ2LgNz05ryxgHOnpnhK3XuM0yLCTrUV7FNbBK89Tfw2URqCTD8BN6t+5bSSy6o8SMlm3olVPZgFcaWDnZ7qRREgI8SLNB6XvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKEDJbqKw2mkdJN1kzZaLR0tX/9VayQsnKxG7ofcJ7w=;
 b=n+AGKRS2Beno6PO2nFCisi4nnzhoHUl6KcxDSR6JWstxKmhgHA/pNlVIEMPKdonp40Soes4zhfWTeWk4g76NgyE34QG+UuteU2Bd2DWql1DwZGyn/mwdLfBHSg0VMSpvi9zisyUIKi/AkQaoEaJyHt2sKmyXlmL2ht0B+qezh7Y=
Received: from CH2PR14CA0039.namprd14.prod.outlook.com (2603:10b6:610:56::19)
 by PH5PR10MB997708.namprd10.prod.outlook.com (2603:10b6:510:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:02:19 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::36) by CH2PR14CA0039.outlook.office365.com
 (2603:10b6:610:56::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 15:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 15:02:17 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:01:33 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 10:01:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 10:01:32 -0500
Received: from [10.249.33.213] ([10.249.33.213])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688F1V1K2679453;
	Tue, 8 Sep 2026 10:01:32 -0500
Message-ID: <1185fd5a-864e-48e3-a0ef-f96e51502e40@ti.com>
Date: Tue, 8 Sep 2026 10:01:31 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/9] net: phy: dp83867: add regulator supply
 management
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro
	<peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
 <20260908-shikra_ethernet-v2-2-bbe3389d0652@oss.qualcomm.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260908-shikra_ethernet-v2-2-bbe3389d0652@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH5PR10MB997708:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df34c8c-89ad-4fc4-1824-08df0dba2c91
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|921020|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1koDmkv2jjnW8cZbrGMQOz33+8sA2sBDKBeRlr/MbHd/A/iJJ/iGiWUiC3jWsvyDcJrFffG5eCrl6TOaFgdfOVzwJMBLzmE3qsIOaMfDYkNYE4hUprps42PRCRxjCvGkdpz6DN5aIs4Wu4Q7+OYOEFmSwCgs0yWtlzZfbF0212vIo9Uy9fHM0qyTtBatGs8PTuW5aKGm6t/z2Zt/WwRLmHeY3cwSuRcNuUhNMjtZy7rYQFdZlLWx/LOCiKDYpHdi3wjs5IP3TOJCDuYkIf0W44GbsPTa6WGnpGiQEPMc6dJ3l+o/bhZ9iHzCtoNjP7c+Cl8cX3qVdCDdC6GdfF4lCPjOcf0lWPEeDpj5q1ft+YZmdLMUurK09JQxJpRJ0bpOiaVD3VBNLJ/Bl+fnkQ/4bfyOK8CYd3hhkgyTIpsApl9Mr3PHlJq6QCFv2Dj0RE2vATT63OF15x/Zf6uH90rVGgRSW0Bt0C9v4aYh3k59e7Q/c8IsO/1F3h9yEbAzyZcS8Jif0nGbAnB+qnXrvPuVSo29E61/uk+8LfJOTLr0ugroRpqFKGrqkx7kJtQBOgJHX95jdSUA1wQLr9E+P2gRjEtMJ64qLy1xnjByhvwYl0LzH8WQo7hGBpUrgfrxqWI4laWdTIuOBdi/x4PzPjlW0DT9RRLTscQC4ftBygoIC/WXj1S+0w3siA2uTJxDeFwtgKVy7ZhFPKHtisip+luk8IQ5Qfm8Bz12HlZmbuQzqNmLGwCXqZiA+IVMqDIRYjb7
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(921020)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XUskg4ByaoIGqPaIohTGWsVv6SPWSxLlEM4QUlhBJYDydRDPDl1FXHAE468Z/P1FEjmS5aFSAFAiaYVaZsIXRcn3kE7bsya47gGhrJMIT29Np/ZmUS/8dH5A+h4tAMdZCYGpyPqLL2aetJgJ1UQ3RhIlCSDIYjGPAUfU4/ZHsCneW56Pa033fzkEm8uJ4O37fCHnr+C4CTlc8OaqX6xeSwkT5Pcj4BYsbFqNU+s/4XQcU0QgxRYowAlbK3zlHfnV4aHFbbXsznD8R5k/IXb48k/MlrVuQYcDtRv+6Dqx4//s9lkt9uvwoIkKrMHHd1sgg4DTYxl2jmv+nByA1Fi50sI3vXUVq5S+1HaggDWQswP9CAebIVdQAfJbg5SAXpkfSKrVWxcK5WQpFjIAQFs0rRD847ofk70Z1UkcBdw9bhyytNrseiz3lNs19JZ/haVz
X-Exchange-RoutingPolicyChecked:
	AvtyFG4MxTFJutaP/oxdYJdn3wXSVB3F52MCgTNVvvnzA+WCgtSUJ/MSXHxCMy6EykgN8vbuEsz/dwOnaNZE53qliruPGZ3nQWHFMQoTePfm2a73+zf90Xn4op2elRORS7f427rbPdBXcmFnHQfAhRs/e2wcQ9sXxAPU08wa4IwYPyjLj6uDCyiv8z3afIV0iTMpRw2CycLdX0Bws0frVs1/Yges9CY08W3yrY0ISsn9zfg1obun/3xK5ESbF+j42E7d+DPkFe7s4oJpkxghl1UMkqDKbJ+oMUOc3KMvanjoeSElHAntFaNDuhvz4NzFVFMajvTi29+BxgpPZK7Udg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:02:17.1536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df34c8c-89ad-4fc4-1824-08df0dba2c91
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997708
X-Proofpoint-ORIG-GUID: XMG1I85HXWetDkM4E6OQ9FYzMstB0col
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MiBTYWx0ZWRfX94a2WVQYQrEh
 yELRTBmXbprMBFSJGs7+I1NBBwAIBTwtqzB+AJVFmyfbucttoVJcR3pheivjgGlTdoiy+ppjPTR
 vbFW39Y946q5K5uwZn2fUQEMKUZBS7LM+ZRu/8XwxPKtQiniNGAN2krj8l2TdBfF/yAPMdSgaep
 8af/yjj4QOoh5y3j+9OMDV5BsZfLUG/0ivM1j8Jsib8BKjGtBt+rP+i77rceiy6GU0lM82n9+Yi
 9eYEwjv4THhIhkx0sanAvLlSUHdcMN0Wsz16ysan8oQj9q+MuNH3q9zVzUmDrUqjJnKM60g5gp1
 meULWNtZOQ4qFOVsX4B5Aa4/jcTTCt8GjlzDs7e4kNxvopTENO6EfmWWurZMPd9Bpe5alwc61qw
 Ne3LvcIRB+zws9l3BGa2sUHHcaAOguKuCddVdT4r2BzuTonPu+iXYOyFcLhemA3+IPWcoX1ldWh
 M696eYS40/5WBFo3Zdw==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa0237d cx=c_pps
 a=dJs83p8YoJtII+u9Eez95A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=Tc_FYgHOodJxOJMde3UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XMG1I85HXWetDkM4E6OQ9FYzMstB0col
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MiBTYWx0ZWRfX3TJdiIpujT2G
 dbD22072JkbBpJj9O3eYabCo7jLd17DAiEO05A0Thsq8PQanvid7dHonILvtSreTbwKClFlCgbe
 6HxZj28+9zvzFYLs8eMRtOjhYKuCURA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080162

On 9/7/26 3:23 PM, Mohd Ayaan Anwar wrote:
> Some embedded board designs use GPIO-controlled regulators for the
> DP83867 power rails. Add dp83867_power_on() to enable all four supply
> domains at probe time. Absent supplies are silently skipped, so boards
> that do not describe them are unaffected.
> 
> When any supply is newly enabled the driver sleeps for 200 ms before
> returning.  This satisfies the post power-up stabilisation requirement
> mentioned in section 6.6 of the DP83867E/IS/CS datasheet.
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---
>   drivers/net/phy/dp83867.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 88255e92b4cdbd6da2e2c1d10f9c72348d28dbc3..dbeee7cad6f0cbfeb127bfd28f43ee2a16c78879 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -15,6 +15,7 @@
>   #include <linux/etherdevice.h>
>   #include <linux/bitfield.h>
>   #include <linux/nvmem-consumer.h>
> +#include <linux/regulator/consumer.h>
>   
>   #include <dt-bindings/net/ti-dp83867.h>
>   
> @@ -719,9 +720,41 @@ static int dp83867_resume(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +static int dp83867_power_on(struct phy_device *phydev)
> +{
> +#ifdef CONFIG_OF
> +	static const char * const supply_names[] = {
> +		"vdda-2p5", "vdd-1p0", "vdda-1p8", "vddio",
> +	};
> +	struct device *dev = &phydev->mdio.dev;
> +	u32 count = 0;
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(supply_names); i++) {
> +		ret = devm_regulator_get_enable_optional(dev, supply_names[i]);

Would be nice to have an API for getting all regulators without needing to
manually list all of their names, since we don't really care about them
individually. The of_regulator_bulk_get_all() is close but it would need
a "get_enable" variant, plus _optional, then made into a devm_ version.. :)

Well until such a thing comes along this looks fine,

Acked-by: Andrew Davis <afd@ti.com>

> +		if (!ret)
> +			count++;
> +		else if (ret != -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable %s supply\n",
> +					     supply_names[i]);
> +	}
> +
> +	/* Datasheet section 6.6 suggests a 200ms post power-up stabilization */
> +	if (count)
> +		fsleep(200000);
> +#endif
> +	return 0;
> +}
> +
>   static int dp83867_probe(struct phy_device *phydev)
>   {
>   	struct dp83867_private *dp83867;
> +	int ret;
> +
> +	ret = dp83867_power_on(phydev);
> +	if (ret)
> +		return ret;
>   
>   	dp83867 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83867),
>   			       GFP_KERNEL);
> 

