Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E94175A99;
	Tue,  4 Aug 2026 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785819504; cv=fail; b=ncm4D6RVpXcqQlajPd10tQNk1SwD+Lxa2gokPY90CJ2h8QQQKdd6KJxTdFisH3MnyXhWp6YKL6+exRiRpGNF4JcZYgZ0rvC3SF8ynIaZkkmLs1qgW4XTdQ7dpTN+8swwRrD1ZDsOkaaLPJqn/V01h2Dc/IKwYAlE5B1RM+RLSkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785819504; c=relaxed/simple;
	bh=wVC2l72RhhVAps+PiLlMhW7RL/aLBqvJ6m6LdocbY5E=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=KZpvOsBgfIO6fXWSJROqFODg0hTQOKThey7R+gvZtBTkTXlkHQ9WW28yu8Y0kgVLBap2TBs/JRKstOJEtJIYfKehTmqiMVs6SMbmCkiGRLhQR27Et1POThVuQhT5tpGeFDUuFuW8xb+ZG0WpicaxS0ywlYsMgl/hJDoopFdSeXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JCOoMY9r; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oGdyJtB8; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JCOoMY9r";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oGdyJtB8"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67418peC1418210;
	Mon, 3 Aug 2026 23:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=XoQjSLSIMOUeaDh6HDReplQlapwewnYey0/f/k/k0
	k8=; b=JCOoMY9rKPHrD5MOP1/GMAh3BEv2iM2nN7/T1p3Fe3lLvo12gUo67o1+C
	pkrfc7yi4BBYB1C0sE0op5MnUHkliI+uFQMfxsnXQQ4bmCJfka5kOn+y0LbC1Wxb
	q9UkwdIEV5NkAk9euidTP3frTVQBX4rLgPc8BNZU3lXhCH7atkL2cQPB8U7VxQQY
	SZ9TdirQBRVNZzcarMuOl/SmduVT/vPVoPJOmduVkawwd0amdgyjm4Ugy8MFrKoI
	DMC2VpPj9W8XleH4tQXTK1epw3jV11nuE7bA7uMITGIS4nnAkCIZvXEG2/6hENhl
	CvwvIRxBU2wgxopoch6CViSu6rLHQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0apx89-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 23:58:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD2+LsChRsUgzMLpLv/8O96PMYyyzEgWHuLwcCSYqmSySxR/FTvp6L8DwnDZpxa+OxzlOtbTsUtxi+QsFgfWKTMzq2rCg5r2hFH2nz5BnggljNoeTXE3pRMgxVv0i2PuJtDLRS7t5IB6e/MP87fnNAj9THpJIguoCeKSBOz3bZ5FWNMQzLNv6iAVZrKaIorWh9fzoNideDPbE+D1utkITUNkWalr+gtAy3O8WwCiHZbooBjoJJgW4yVVeYrEQV06AkSF987aX+P7ssxT+D++86x8m8BGqAEKbGHOzxOC8m9Oh3qlx6b1KuPuOgkaIZdBC3ZXy1CDCqnwSvJmutpKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoQjSLSIMOUeaDh6HDReplQlapwewnYey0/f/k/k0k8=;
 b=kU6H+moHdhuEbveK8i06lp9dp7SATYTKT8T8gLlFBySuhA1u6fU9wV0EE3WsndpIPw/DIke9nmzJ7ln+yRJHEbNSWM9rYy8owWIx26Ab2uImFE4Jf3M3b6oDl4asdL/CYS2IIxEolBQyO2Ms/DJBP+egUe/GFyJlfAMQO251st6WFYJUfSY6mN4M6hZd0R3MF75gr4RFseVE1MDHqmm5S731+fGxkYxO4gfAMDSvFR2EJ7MpNf2bn1AZsZjGvh1jGxya8eREfXJ2euuJfYooq7Um971e3TKYuoAYnOhcKtzXCEsPNqCJ6DN9nPqIbQ0wx68TQBdA6EtbmUlKHdNKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoQjSLSIMOUeaDh6HDReplQlapwewnYey0/f/k/k0k8=;
 b=oGdyJtB8FK7ismhLJpojW3EuMIV8oAl81+g/p9NIZ6HoeSTke6BA/eykhjrflfu6GqFirLMwEn0CLXPFl8XJzGwHG+vs4ZdGhxZT3nchVj5qkn/wAiy8NeqhVAHugn+BLfbtkHumBW/otHaav1TiTpZ3BCWEOiDaVQrBss3BgBE=
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by CH0PR10MB5129.namprd10.prod.outlook.com (2603:10b6:610:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 04:58:13 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7f) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 04:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 04:58:13 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 23:58:10 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 23:58:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 23:58:10 -0500
Received: from [127.0.1.1] (uda0132425.dhcp.ti.com [10.24.50.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6744w69u3766543;
	Mon, 3 Aug 2026 23:58:06 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Meghana Malladi <m-malladi@ti.com>
CC: <s-anna@ti.com>, <grygorii.strashko@ti.com>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        <danishanwar@ti.com>
In-Reply-To: <20260706092229.82674-1-m-malladi@ti.com>
References: <20260706092229.82674-1-m-malladi@ti.com>
Subject: Re: [PATCH net] arm64: dts: ti: k3-am64: Fix MDIO clock reference
 for ICSSG0 node
Message-ID: <178581947933.886571.4153072563060252898.b4-ty@b4>
Date: Tue, 4 Aug 2026 10:27:59 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CH0PR10MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c213716-9dfe-46f1-7bea-08def1e4fd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|13003099007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8A3ikRsu61fQuV/Rz2ARCzGznT57e95My28r2Kyh3AyugrYlc16eAf563hBi8iChvnnXuYSMvqa32TEI3nerJ/giSS1pUimwL6juadCYjnLtFTqTkvYa05cPJwwUNiAsQ83dxVd5Lp+gwjvX/BEUHSsl9BxY5itTboGsarCi31jjEpwo8SgtCX8p9FDKvXEEomsX+pZg1mHO74IcHAN/UekJyOfPqcSEMCeTwN8i2GPa0BMr6wlwghm5xSRN0yoOE4lhoavsEFDTYJy7Fbc35aOa8H0J+iccFrV05cm5nzpqZCvlP21BP+Rz52tmK25I8uXeX02psQ57V74EJ0lQ4F8NMO/cOtaDcYPkaMkWO9Hyh8YK2f5ZVSe3HhYa2BTZvkEFHJ+XmpEKFMF0mgefT+5DMbcHDBIuB63jM2jc5UBTdxbAv32KFevjfrJi94Yum8+ghDvZ6G7B8eqtE8Ws/8rZ95nUPn+El729VrTbNMLm/RzC54WzSp9joS4U6dccQ/5iNMV5PbXN+wIT+9QXRKcV0DtlCKt4GKkHQaBrLmAs4bj0gKjojdyjTC2Rs7Kw0bTZZVmOEMquvXW2cbb7jXM7FWFPOGaJoIbTfVb6MJo+6yvJ8Bg3Lep5HFiln6VFfWSh44cQW5UsTxAnlZI6hfyDlCNWxDvmeJ5nlJ7tT3c4ExS6geV4hQusUoAUGwSZKcl4yPQLOFhqwxUMhu6P4w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D/B8xpLm4duGEbEAAVRdwnGpALsiwxMBWAsfnVmf2rg9zks80W5joYoMppsO5AUQXIyiGSmUPAUGUIVVi2bi9kU/54mrXE0eNM+uSDJYyyuc+xSYj/C4hY3Dd/vPa2NhNN1IOUNk/TrhxM4+eJmMFd0/Rdwi43wEbAqILlih5JZE5RsyIHGBE84tx5BB4gAttEf0E+dhq8yBGPAyeAOYEwJbvSWla9I4SolUD+ioDGQpw3qeenYBxZxV6EeGwScY1xfZIytuP25eJh56ElccNP5WoSRrjHILOSiAEqExiZAm0p4li/4mRw66C/Emyk1ByeBmWO5sKVONnH0cmmQDMtHLXQ5pTtqjguPoVQKhhKMD9R5e6cuNpV9zaFwbug4BMdlQy6gRj4jbNSn1ZG18rAsNay6UIUYcQ+s2Yb7cfJ+7gBu/rF9f+uzyB35QHHMN
X-Exchange-RoutingPolicyChecked:
	YoER29pTcgoWU4OTLVAtikWjUT8yx9KULeVq5S1hEj+QFamkre6F7JkQZFrFSr9fX+tkBMiuseS4Xw6ratDVKoqx+Joj/VxYhX2jmRZ9GoDUSo373NjXFZKmoUiECARtyOFj7oyh2+HliOSUHnM/LRSmPILob+0TEDqSSFwn/IFFzNgm0x2deGLpZoYFegKUF+9TPs0JKMIAAsEy0iyoZl53GJLVMcriMjE8d4r8GcQIZuEBHcCukKtq6jhYLBPWe58qoCZtJE28920H+FpdvxoZMexgiYB/B6AVZ7wVI/F1LA8H2DEgi6kq/X4Q0D+ubzxGnZ4pue0676/0u9BReQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 04:58:13.2716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c213716-9dfe-46f1-7bea-08def1e4fd14
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5129
X-Proofpoint-GUID: 0pIlmg2bjflfy18_xDWfQFS6Ad0s4xK2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAzNiBTYWx0ZWRfXwDNetoVzc72t
 FoqOAqHLYY8p/uULaWhrGr4mklLTUy6kLFKwRlQrFW1Q+mgnq0wSfDq8W+OM1M9jkzgiXqUf4CC
 2NJT78YIw0z6R6Xl6HuwXV6kwJ8GPow=
X-Authority-Analysis: v=2.4 cv=EpniaycA c=1 sm=1 tr=0 ts=6a717167 cx=c_pps
 a=ZSUkm9skZvR9PgEjA8jAeg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8
 a=o1kACPpZKAZCWsj7fAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0pIlmg2bjflfy18_xDWfQFS6Ad0s4xK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAzNiBTYWx0ZWRfX1OkW2SVcEApP
 rv7ABwHhkx7BKdPtrBGM0FmaO4+JqyiwyZuC6TZewY/hqC0hMYron7GIWqbCuOUu7I8kA0g/ULw
 hzIA0+jijbcRE/SDkhpHnal9Ruq30UZDrfpdzKwj7eqTRcy0g09mBwyISLQN5QxpYMx5qIdEMyG
 J2NNhgCSE5/rJ0FphMU8iH27SIUpcfzrsnqiphfnfsrrDXxaHWG7FzGNR8BJWvb9gtFBssoa06X
 8xLh17/8rPjul3JfMjF+9uFP4Y9yOUhbYEnca+4o3IkwlCa+KINBUt2XyFfS24Sca8IjVlH6kbl
 RC81Xq4nEhf/ziIgLXqpO+WFhvRFlXdhQWBtU5AGQqNzs3TWkR/oQfkwwUU2dE3z0SNt6wsVcQR
 VCASTnqVjUff6jNEkSu1F2XTxzcnZM2fak4TArBPtwucD/xzBMDhuKOk5E7PKamxP3NNafJ38Yp
 06LVKFHL5dO3TqT8JZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040036

Hi Meghana Malladi,

On Mon, 06 Jul 2026 14:52:29 +0530, Meghana Malladi wrote:
> arm64: dts: ti: k3-am64: Fix MDIO clock reference for ICSSG0 node

I have applied the following to branch ti-k3-dts-fixes on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am64: Fix MDIO clock reference for ICSSG0 node
      commit: b45d8371f9eb651bf936531120f70ed7f1fa6f68

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


