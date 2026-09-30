Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035624F68B0;
	Wed, 30 Sep 2026 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772298; cv=fail; b=Al8doFbWHEj4Mq/Ot5rHKkEsmhqXeRE+3uX6N7EDfKe/x1YWd+I4Q34nLzdcvY3gMVCHo8GTsAdbsZcHT+fjBgpyHnJpNsSMtxokIeHBTNA5OFVGugojhP5Hr0rWwBMFrWnkU/qsYawq0vVtGX2mHlXEXw4gwiSgXIEb1QexQHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772298; c=relaxed/simple;
	bh=FWtNbmq/sKu3RY2PzG9OAYzPydJMksJRKm6JYqh6hNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i0PVp+vtesYuJ1UTjiOHO5Ml4PQTC87cL0CGSHNhOmS3G9DpTEduEUWQHp0DiVLdnkFLVsIEGP/kK5aARmLV5fEDEL05ANLgIEWYiQpW55/kDko31sxXh6lfIJcC6TAQfKnzLSqi5J7hPPrHqQEFoveX5+T13rjzZjyAHCt3u4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oyJkBd5B; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=cMmkXsj+; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oyJkBd5B";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="cMmkXsj+"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB68hw3214248;
	Wed, 30 Sep 2026 07:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=y4vh5NwD1SDUM
	yzXSarRRyzLWGyU5WjmHhD7GI6i7Fs=; b=oyJkBd5BroWBxq1O1YdxLa6flPnis
	pxobwZF/uY7LGFNQ0GrCLUDHXNqxkHW3KffiJOig6rt7CY7NjbVll6CY1hlSH1wq
	VGkm6wMIsyFMyyDGzyv0vwCl+AhR37ruPNEFGI9i0aZM+fTO2vePrYowlrBcrJzS
	pp2MQDSk2aYHauVCnHvCUp7iUIVZeOitGHKONYkv2dv/ZRZQlAqub01yw3JVFbD2
	LK3RNa9mVTOVvmF06hYD7ZoigUjlfOEzU4cIZlLJiqa8i42mwvoUJbYJDQDSlNZC
	szCSzY8yM5jDCm0JxdIFDpAPN/yLmk7tjUov6GmbV63WZfj7U+OQ2vxMQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h0ydv934m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:44:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waZx/uxqSHbtwofUS2p4vUlbvB/ySljEyRnMNjsG+I3rlBBqx3cqwLTPcvU7q8JEwggthaddD5eBTMUaG4hoQ8lpkmpYw7EYDaxdV4w0KpWE7NvMK8ihfAg/envFAHer2Pb8CVTqmEuLufPOnqQVyRAxPEPyg99fUQUlr59GwCBv+y6Gdb1Tz4aPaYuZ79XC7zRURbeENLTsCqSYi1Wqk5nst2skhYy/+KX67zYN+8fOTaja2hHNSs8QFqsz69jZrB/PHJH9FFHq/K1RTs5bZ0bFpK2AqC66Zt9lOVeqizfQKfMDZ022Cih/TobAYagNqstSUTq1WpzXHobbbOB2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4vh5NwD1SDUMyzXSarRRyzLWGyU5WjmHhD7GI6i7Fs=;
 b=flimybr1ykIDLLrEGIfwGqH8Lq7xIKJjjuR4d3u1offCM/79se/nYb3gQ8t1C8PJmbpACYulBE0pubzNHEnI8Rh7EbXwwtUtVBO2EBprFJjxQF46zhQ8I+iZHr+x/plcGCeVw0C8Ep2OFKcvGsVCiKuysvzYOFMndnEtRxqPPDayLadm7fXMlKRpFITWsbx9OTLqIR5IesfcVbSekjj1wuHfF5ef9YrD9n67yXvbKjIoYD0877ChRZUhVQ9kEE4K56SgUP5TBotzzpvxsQ2DJJLH8IGDwVAqKeFpuxt3p7nIcXebLPuTRES5S/FPawMKenlX7s2bQ/2TryVHPUhgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4vh5NwD1SDUMyzXSarRRyzLWGyU5WjmHhD7GI6i7Fs=;
 b=cMmkXsj+hN2+g6X2RrbW24M9oTaeFW84WvaI3kN75d8vOF7Qj+TVIC0AkoN776V0fdEW9sfEEGFWhKhab17tQAiiH1MGAX9y4kF1ndxzup0otQG3RWOlLNZVeJmL3Tr3UgnwhmZuOg5jtFU9HGUdgAJxvNS7fuhVEh6QV+xmFZ4=
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by MN2PR10MB4365.namprd10.prod.outlook.com (2603:10b6:208:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.13; Wed, 30 Sep
 2026 12:44:17 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::12) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 12:44:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 12:44:17 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 07:44:00 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 07:44:00 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 07:44:00 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UCi0M62585341;
	Wed, 30 Sep 2026 07:44:00 -0500
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 68UChx8Z009475;
	Wed, 30 Sep 2026 07:43:59 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
        <vadim.fedorenko@linux.dev>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix switch mode for offload and non-offload cases
Date: Wed, 30 Sep 2026 18:13:56 +0530
Message-ID: <20260930124356.3083743-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|MN2PR10MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e689e4-79f8-46bd-9879-08df1ef08a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|7416014|1800799024|10067099003|6133799003|3023799007|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	eGRSUZ+w6geUR6pT7mUB3hY4EtAny4VUXKolDS6QVPMZtAtkclcwqpGWDU9b6HO/j/bhumBtCehXckaQ568XG0HUS1u35jWo4BbtTrWkR9dLjFprl1LeO8Y5lt3PJd80Y/AwPKtzoiiCHJzsvMTI/vcIiGua5oUbHYmT8RLMtr1rmHZmgGwTM9harVdKpTjA1KWX0ESM3mtWvhuPWVyvsQlpMCyCoIB6TQRSYgaIsbq1RtQawL11Tdvd5Y/jdMdYAjt7i3X1ge7NtlLTaRi8PPdsU5y+0vdF6Nhluljp/mqwnYv1oqqAUKGzOibvWr77hJKcbRmFA7TeEZ9CxetzOzxCPvihJNNoqu3RP/bBbICKJ5W/398G/95wJtGpEyYpSIY58eAm4C7m+81ONgEQy56+uQojnN8BGSBQYk1zaCt9+I5cNNhf7oWEpKvcywsbbjPSa0L6DvfzWQcS28GpIbgeoKZnoiVlXbt+/6/Dz6dmz94Q6pe29uul+BD4qfftczunLfy7HjtIwMgUXsddW5EsARXjFz+StJre2gQxLIwFMiq7cqRjKY800jjtYPosT222oj/48RVPxlWV7e4Fsxo2HqUn7wtaYlqyM4iRaZ+6ElZdVT3MO/fm1zDRkgM8narRfhSJM98pozMbflpnzO+/O7cJryqE+NH4jQLm6Bi/k5qBidn8O1HlRyHsbIFyUzIXVXEDnftHTiZsxZsdJLpL97YIGFDODzO0TgsTP7M3Vv4sE4ZNiGECa02h1TuQ
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(7416014)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yNHEJQR8C5fH66zus3N9NRNBJULhGPRWsMLGUtXN1/Z6qGK6JOdBWWVLJlWHHvW2w5SW0yrR76KLcZnMo60ABBW7p6qPdjbXrU8pbaAdLznYE9P0STFi/IbrJUZeDSiitnaTHbf+CeiRpyjNbQ9SZH2t3kYW7lofL11iUk8bLsrWRSIiTgUa3fOOrZoZTBYYJ0CsyIEmlG912T8m8MZrCdeparP2KF5g9pXdQ0h4dGTgw1uw5IkrZmRBahycZaeoOdS8HAB4elgEP7BZhTe719QssxfFD2T71BDI9aFCSxtYM9nsDb2B7A8d5BbLJzY3W5NFOO+AIF+32XTWrs47fEMVbnxjf5UPLKddKW01hUxEPXE8LmCkBj4kOzuWE21BWgUHTCFiILctERTLrXP1iu4pkwfwk8E463y0UMH042RqSNB58m4enPj/4QgniLcX
X-Exchange-RoutingPolicyChecked:
	DU7y1/zMYmqM198O5pqqRzcn5KJntD2d2ycAvUg7GA7wO6KlPUh+r0hEnM25ydqyTivOEZ0KR46oEVQgegfoJYvLg32N82Kq2wRMTY67NhjnIBgJbnAuiX2ywWtWg1MXfj8WUgv3vre7z/6fY+IIw9Bp4oOBgIY594FGALzWZzl7OQGnmyufH6nSL34VdPmaR7neQMyKUe7ZlLYhc3zq9vtreyGSB6r4gB8PoKvhbeBER7iwwhgLis1n+gjlNFdsil+yCvQ6jmU/HQFfA4ZqRD9GCFeLEVnAhgDVv8Pu8FcDc3GySyweIbbFxCwXuW3jMSyQsmnHeWBZZWQDNoSQNw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:44:17.2302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e689e4-79f8-46bd-9879-08df1ef08a71
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MCBTYWx0ZWRfX2rVy6DJpiYTD
 sw6gsioqO80sSOt25o7/zjwLsdkMB4vdC6JEAAD9g+WiqU+U+ennGG/JJt4mx8Kx9qTWOJ+glud
 x8G5gLOm/YCoJxMrMMyKQ/hyptbeCt0=
X-Proofpoint-GUID: LlJ8FXNJL5v_rSxMPSWfWsmbHSBEgSKw
X-Authority-Analysis: v=2.4 cv=TegDJhQh c=1 sm=1 tr=0 ts=6abd0424 cx=c_pps
 a=dctP2Ni10a9Sh7weZd+SyQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=Wfnt55jNprElWOjuz1oA:9
X-Proofpoint-ORIG-GUID: LlJ8FXNJL5v_rSxMPSWfWsmbHSBEgSKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MCBTYWx0ZWRfX9RHUh3RcQaxx
 a017e39eGYa01L/DWuV4fdFwFRfnDk7UfxtCQlt1p8yjEDVTVgtw86D6sIqGmd8sBTdMxPCAGt4
 5a7RT/VzAID/phQ41mRDhlpvq60GGEIBZQ/Fq608RMLlp4aC325EzcWk2Lji94rMpUojHz0x3rn
 j+FSH3QRRhznuRzKY5y/ATIVFuhgTiq0pHWekGiLv+GIJqc6VF82xuMZRx1PKkHUDMURktdQW90
 ii6LTp+UE2bbfPLEtyHKxZpx0uoKnP4tZ8hjdhYykjs1gPQA7W4GkX6JoO/s2Hr6DuapocGNDjp
 F1zAZ9fAGiiFSlT5p/gJgSbSWjxcl/xNJGyfisO4tQ4BRj8BF6iQUVl5HUIJqNcHyj0vt9oid+f
 hJNswWOO+Hv65xUdOWjBRW5KpZC2FJ15JrCbtylZQUDCynJ1giP377TTABwGp8ro+Ymn67XAfRK
 dQBhl+jxpNUy+fzUPmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300050

Non-offloaded switch mode is failing to forward packets. Following fixes
ensure smooth operation of switch mode in both offload and non-offload cases:

- Fix NULL dereference in icssg_enable_fw_offload() when second emac
  slot is uninitialized during first port open
- Set port_vlan on both emacs when bridge is formed; previously only
  the second port was set, causing TX stalls in switch offload mode
- Track UC/MC flooding state and restore it after firmware restart in
  non-offload bridge mode; restart cleared IFF_PROMISC-driven flooding,
  breaking unicast forwarding across bridge ports
- Defer emac_adjust_link() to after prueth_emac_start() so R30 FORWARD
  commands don't time out with PRU not running, leaving stale R30 values
  that caused prueth_emac_restart() to fail in non-offload bridge mode

Fixes: 161087db66d6b ("net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN in HSR mode")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 47 +++++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  4 ++
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b..9afda5da3ca3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -213,6 +213,8 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
 
 	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
 		emac = prueth->emac[mac];
+		if (!emac)
+			continue;
 		if (prueth->is_hsr_offload_mode) {
 			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
 				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
@@ -241,6 +243,16 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
 					icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
 			}
 		}
+
+		/* Re-apply flooding state cleared by firmware restart.
+		 * Not needed in switch mode; FDB handles forwarding there.
+		 */
+		if (!prueth->is_switch_mode && netif_running(emac->ndev)) {
+			if (emac->uc_flooding_enabled)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
+			if (emac->mc_flooding_enabled)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		}
 	}
 }
 
@@ -278,13 +290,22 @@ static int prueth_emac_common_start(struct prueth *prueth)
 		ret = icssg_config(prueth, emac, slice);
 		if (ret)
 			goto disable_class;
+	}
+
+	ret = prueth_emac_start(prueth);
+	if (ret)
+		goto disable_class;
+
+	/* Reset link state and reconfigure after firmware is running.
+	 * Must be done after prueth_emac_start() so that R30 commands
+	 * (e.g. ICSSG_EMAC_PORT_FORWARD from emac_adjust_link) reach
+	 * the PRU firmware instead of timing out with stale R30 values.
+	 */
+	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
+		emac = prueth->emac[slice];
+		if (!emac)
+			continue;
 
-		/* Reset link state to force reconfiguration in
-		 * emac_adjust_link(). Without this, if the link was already up
-		 * before restart, emac_adjust_link() won't detect any state
-		 * change and will skip critical configuration like writing
-		 * speed to firmware.
-		 */
 		emac->link = 0;
 
 		mutex_lock(&emac->ndev->phydev->lock);
@@ -292,10 +313,6 @@ static int prueth_emac_common_start(struct prueth *prueth)
 		mutex_unlock(&emac->ndev->phydev->lock);
 	}
 
-	ret = prueth_emac_start(prueth);
-	if (ret)
-		goto disable_class;
-
 	emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
 	       prueth->emac[ICSS_SLICE1];
 	ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
@@ -1288,14 +1305,21 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 	if (promisc) {
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		emac->uc_flooding_enabled = true;
+		emac->mc_flooding_enabled = true;
 		return;
 	}
 
 	if (allmulti) {
 		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		emac->mc_flooding_enabled = true;
+		emac->uc_flooding_enabled = false;
 		return;
 	}
 
+	emac->uc_flooding_enabled = false;
+	emac->mc_flooding_enabled = false;
+
 	if (emac->prueth->is_hsr_offload_mode) {
 		/* Track basic add/delete via callbacks */
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
@@ -1919,7 +1943,8 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
 		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
 			prueth->is_switch_mode = true;
 			prueth->default_vlan = PRUETH_DFLT_VLAN_SW;
-			emac->port_vlan = prueth->default_vlan;
+			prueth->emac[PRUETH_MAC0]->port_vlan = prueth->default_vlan;
+			prueth->emac[PRUETH_MAC1]->port_vlan = prueth->default_vlan;
 			icssg_change_mode(prueth);
 		}
 	}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b78..832e654a102c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -242,6 +242,10 @@ struct prueth_emac {
 	bool offload_fwd_mark;
 	int port_vlan;
 
+	/* UC/MC flooding state - preserved across firmware restarts */
+	unsigned int uc_flooding_enabled : 1;
+	unsigned int mc_flooding_enabled : 1;
+
 	struct delayed_work stats_work;
 	u64 stats[ICSSG_NUM_MIIG_STATS];
 	u64 pa_stats[ICSSG_NUM_PA_STATS];

base-commit: 99b43ede9e355ba35244cc9470bf1819774ce39d
-- 
2.43.0

