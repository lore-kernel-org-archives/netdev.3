Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88641A504;
	Wed, 14 Oct 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982837; cv=fail; b=ZbxQA4hF4/QNOp/KHNvXW1i91V/CcFzKosGkuXPqNo79d3KW2GChXwaN5vL+40Skv8jBrZr5m9t58y4r+DT2sQG9nSRCxdUhXtYCKwtbrAjoaznEDbOXmiJ3sMvIVrP/dYSq7XNr7ssQN/AJQp55bVmLk+qN25BVrrINHNYf/sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982837; c=relaxed/simple;
	bh=PT5GGc9lWcr7D9DF+KJWGY+mSDywSUpTkVnVdnSJWio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDKp0fOPhSGkPhOlQwBDdS4PVtqWRkzuqcjSgfrHThN1cwjwYZBprdXrAhtbdUkmPtsWVxVU17DffPAv2WvIkVvkCCLh7ussi2UaRGAAvhEzIXaqnj10ZwokVvOBDjqvToSMj7xJU676ToNwzaW/Q/yUJguM5W5zfLZBUvrJ7ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=blBIgL3/; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=rVZE00Xi; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="blBIgL3/";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="rVZE00Xi"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69E9ESKb3082451;
	Wed, 14 Oct 2026 08:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=qJbAHCKu9hv44MCMU0n25cnba1hWf1/Vr3XGWqPo9
	2k=; b=blBIgL3/78osnRn3JUKEgDJ4SWfXlzxXu4R8Fx/KEoShbpBaW3v62srBn
	Fv5oo0H0kbnXTvmKxwwEEyMVzJnWqhFl1yTehBHA9qieZ7G1woOHzok3reBVieHe
	QUcG/FaHKNFV1/5nq4WNM3O8+OfmaJj14YDJXNoA7MlcEJFoaPcdZhhMBgh7HX/2
	by9s7XvoRYa+vnpmrF1XJgLNx5QLmvQB/oFsfUc2DT65pmuQ5nGmYvG7fNCsky5F
	7+WcZaWdxYWfpDJYY6nI1h0K2NN4/aEfl5Y+8smYZ1hjyrCCoGEo1t8rR01WzFaG
	gf2t3Z24G3w0Eg3l6TmH+7jrEmjeA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ha6xch3d1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 08:00:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgdREOPN2i3WKiH9v16GI4DQSVs5J9EIj+WCJg/ZvohvjyO3EnKIMDukNzXTUvbkE+dxTy0nos/i/S5MDqSamMS8kHUWqG1AFJL4XtGMLZzaP7mqeqMz7FBEkefvTZLNGmpkuq4FlUBePfdfWhDF6/1pBm7mMaOF0EoqYfK1ZycJrREKtubWqmOVLgdfXQUzJ/BpLlH494uu1gKIfggpoZcyrtmO/EDYVvau0r8UdfPgJEfeaXemncpmxthpNO41Zs/unQS1sKnZPllitlgcH+5xlpbcDe9HfT5lcH8yg/h1h0OrU9AqeRVbukEbLiiziOnabcM72jqovHRR200N2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJbAHCKu9hv44MCMU0n25cnba1hWf1/Vr3XGWqPo92k=;
 b=M7j6R/6AUAmBFMbQ/k/l+n1trDQ+VUPE/9oqMw8FunHN2C4aYm0M+iSj/ceZqtJeFSVq6IWKWBB8E8EyIhKTwhc+Dvq4Af0fQRHsKA13tfUG4xNi2vetOlQDKuuoaPCOig/28lnI4iAbaOUe99+QccPhYbXbecgbx/5XyCi5p3UDjljmbNv/tQBPb2rQFw5bs85lO1HLvRwKgJRKD22cdXZL49hQm8hGgMBjvS08CeidDoYTz5Et6XQSx3KailYQwwNXe7ZNbhNmE02EGh8e77gwiVlEby+FSO00h+36avmykAO1oSHQyIhlz/WCxDMZyRsTSUrwLuPiCNOzmDpZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJbAHCKu9hv44MCMU0n25cnba1hWf1/Vr3XGWqPo92k=;
 b=rVZE00XikDoBLAOIDPZKceX1KDls/YRldcZUGFJtAn8uxYbw43iVfRaWDRqy5Ksk0k8vqkm9tXOggyeJ+giXICQBsdeiVC3lOUnX+QAG5gdDa7jAr7eLtBd80wLMcZvzAbo56TH16xnFoAdORPPOyR0uTBGRnguRMgi3PyA/1Zo=
Received: from CH0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:610:e5::20)
 by CYYPR10MB7607.namprd10.prod.outlook.com (2603:10b6:930:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 13:00:01 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::7d) by CH0PR03CA0255.outlook.office365.com
 (2603:10b6:610:e5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 13:00:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 13:00:00 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 07:59:54 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 07:59:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 14 Oct 2026 07:59:54 -0500
Received: from localhost (akira.dhcp.ti.com [10.24.72.253])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69ECxrqv1395184;
	Wed, 14 Oct 2026 07:59:54 -0500
From: Rishi Kumar <r-kumar12@ti.com>
To: <netdev@vger.kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Meghana Malladi <m-malladi@ti.com>,
        "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>,
        Kevin Hao <haokexin@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-rameshbabu@ti.com>,
        <aaron.richard@ti.com>, <l-chinnannavar@ti.com>,
        <m-santhoshkadavan@ti.com>, <k-tiwari1@ti.com>, <a-dev@ti.com>,
        <r-kumar12@ti.com>, <pratheesh@ti.com>
Subject: [PATCH net 2/2] net: ti: icssg-prueth: re-apply rx_mode state after firmware reboot
Date: Wed, 14 Oct 2026 18:29:48 +0530
Message-ID: <20261014125948.230571-3-r-kumar12@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014125948.230571-1-r-kumar12@ti.com>
References: <20261014125948.230571-1-r-kumar12@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CYYPR10MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 58680e23-d7c6-467f-3df8-08df29f30ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|18002099003|22082099003|10067099003|13003099007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	n0MzUpFIlrVXzpQKWu+ON9Nz+m/PmFS9+jXgDPR5D7ax2A3o4KTDSLuLPfwoK2kqNysG6Sy9GS0jH96PkgGXV75kCacZl2WgffHzML4nh2ntPlQNCN0bMlaTUy2wBA7tcNZOZrLaOXf3Demfqr3361DqjtCyIe0ZI0oHo/9V3c2z35zjWfwaGs9z2+7AGReSsO41U2gNI30ilSCeNfJ2GHThamtQ7nCl3WsP9T9ZNw9oGXMy37G64sawxLo0WCalwAXzSy4j5VI5RHJK+CJU0EcfEGp73Oklg4tu4Lbc3jKDf83MzYyY/FxPoDMbAKtY8PpugTpYolxb5soSfqllBJs2JMZqy9KcGAjstgKwPxe2x6WlCYrDtPujil36Jkcq5vic9WBbobSW30Fi+tBLmzdFZ/7hRVDU0WIRcwSnE/C9HgrrkLWo7wgBcKZ6k/wv8etabydZA7fLfzFUXlja0FjOX1wlWHWTAMNF+9hPmLeWpymURi1LKxGhIvmdtm8vf5mQTKBE88Vgw4+Czw9T360z4BYKIHFIqKJaJrbc0vlXXSJxu59y9IHj0rvu57pkK99HOAPQCBWfX13s0LEPw9K7rqXnfaP4m4AbW36OFkLM8OM78InhYrQhhgUrS1CQt7+JvESAoBTKceLiX3ZelqCEdiynANUbCju1wSqePJlUSB0qJEZQYjGdChtyyHqYwMD2Ah45hjrd7s6RXjzO7A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(10067099003)(13003099007)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sm766TEwmFqLzLWVjWftjsPqperMGaJ0gFKE8lLgXhfO/Z6gG/DgwYcy1IzipKcmc6py/hhWlNEGy41gBHTpgT+b1TW6Idv7jCEc3jRtbxaFuK65gEJBW+9fz0ug79s1WEYgJKasIRCsNBVvspF3cIJkwDzVmFcyZgYUJ6os3MLtPuGhmuGfz3cOj20mbhdrjttL/Oo/DG9bHYL3IQcwjdcwgPoHSC0ZPIRc5lQpnayTjiFbHM5MLitUWqLARHnJqeBd7LnTI/iwnaYU5dS/TqOz0w+C+bE7jgJ74FlF0RbSE8rwvWxj/ov2eMcKyCc3UAf/ROVZlqdgkKZhwIIGxgD6lM7uCOVjoDIg1i1fjtqdqHVHZflaK4W/z7OSzc8YEIUUzEhGO890+uawBInGMmOAskCurhEqfHCT9OnLV7jPYtQ4Oa8vsSLEX2CxNYZ6
X-Exchange-RoutingPolicyChecked:
	o51NnzJ1Lq8oCawwZdbXzOXxgoa4At1rwwTEwhuw+/xmxgdOUEZ4PB8qybna3czqBRvKQSm8LnQHUoQ5TZ6lJGQy690twSwrMFJv0X9+HZZJgAZWJYqIr7GU/onwVj98QivTGi90RDzjrfFuk/nmL/c6d4FcF+xhVzmXXw8ySnHPeg2B7xDYs2c1TUTy2V++1v/Fd9A3YYpgr+vuzKVLmqKFY3IauZtyy7BuvYWDKNQW0JoXyL50XToYDPv+V0z6iU1u2HpZmpyEdkau6eiNv09TTYDCHD46sxSqfJT0vsjS/fsdd2dkr4fCdMZVb4Pw8Osw5p5n6CouYYBC9mJuFA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:00:00.9997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58680e23-d7c6-467f-3df8-08df29f30ec1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7607
X-Authority-Analysis: v=2.4 cv=fMysTpae c=1 sm=1 tr=0 ts=6acf7cd5 cx=c_pps
 a=CgODY3tvNtn0KPtxrBvszw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8
 a=qV52rf1l9grw7hYQ-DgA:9
X-Proofpoint-ORIG-GUID: ZeFFFGZMiIinHXJdYWkVsWsJ_wu-C3--
X-Proofpoint-GUID: ZeFFFGZMiIinHXJdYWkVsWsJ_wu-C3--
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX1mlZXim2sxwT
 pdiBKrrD4RPHsYyczN9mzCoipPWkqEOHFQgn/fovW9Wa2QpyUA93DV8vvSonXCMSB8ISPjQOxA0
 amwcSLCuolLG4zaHtZrP3j0QHY0DUE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX4ICFdgklr7Lb
 1JnESXX2B5oXLyTf/lVOXrUfS8GDXWEL9WEuCUZm8W/f0SHUw72zLU5V+PoazjX/rzfAtAaXsc3
 XR+KI6XWqYwiAPkfDnIGmoZf5I5YHoNIUErgwDf7JmbjdftNp4Ie4IasvQNvroQwB0Tncxv+lvT
 lVqDoRuV+i8oBPamkPhb5D+7eAiKT37Yg/sBZHJij/zNQRFNvFQrRvyfpBRnrU+NAKwZc6rZr0F
 PFpfM4BTnXXmik2OO2gM/UZnekoybMej2IQtQDmC5u+i6MaANYghJ/amU69biy/g8nGSVgxvXed
 F/LSEI0cGp3MYzPx4gQ2YZ5TDfXQTQDK/nbnIc/hP0rdf4hkXYZis9wJ/k9dcLiQV/nInd8Rfyr
 BAEJOyhz0R8a5aG0u1zTvc+ZGbshUFL8zwszXgKh1ZNWJydAyYHnh0SsxtLcQ7ezvvnqeW07reC
 4n9oub417q0aoya69qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140051

prueth_emac_common_start() reboots the PRU/RTU/txPRU cores whenever
the first port opens, or on a full mode change via
icssg_change_mode(). Any icssg_set_port_state() command sent while a
core is stopped or still booting times out waiting for firmware to
ack it ("timeout waiting for command done"), and the write is lost
with no retry.

emac_ndo_set_rx_mode_work() sends exactly this kind of command to
enable/disable UC/MC flooding based on IFF_PROMISC/IFF_ALLMULTI. If
a port's rx_mode_work runs while firmware is being rebooted, the
flood-enable command can be dropped, leaving that port without
multicast flooding.

Re-queue rx_mode_work for every running port at the end of the
firmware start sequence in prueth_emac_common_start(), so the current
IFF_PROMISC/IFF_ALLMULTI state is re-applied after a reboot. Also
cancel the pending work in the stop_pruss error path so it cannot run
after the cores are stopped again.

prefix logs: https://gist.github.com/r-kumar12/91ee6fecd40ea3f22dcc65aba42705e1
postfix logs: https://gist.github.com/r-kumar12/4d5ade22d783020552b8a1e0c6d7102f

Fixes: 9facce84f406 ("net: ti: icssg-prueth: Fix firmware load sequence.")
Signed-off-by: Rishi Kumar <r-kumar12@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 745178fe7cf3..96ad6227f405 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -311,6 +311,18 @@ static int prueth_emac_common_start(struct prueth *prueth)
 	if (ret)
 		goto disable_class;
 
+	/* PRU/RTU/txPRU are up now: re-sync any port
+	 * config (e.g. flood/promisc flags) that may have been
+	 * dropped while firmware was still rebooting above.
+	 */
+	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
+		emac = prueth->emac[slice];
+		if (!emac)
+			continue;
+		if (netif_running(emac->ndev))
+			schedule_work(&emac->rx_mode_work);
+	}
+
 	emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
 	       prueth->emac[ICSS_SLICE1];
 	ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
@@ -323,6 +335,11 @@ static int prueth_emac_common_start(struct prueth *prueth)
 	return 0;
 
 stop_pruss:
+	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
+		emac = prueth->emac[slice];
+		if (emac)
+			cancel_work_sync(&emac->rx_mode_work);
+	}
 	prueth_emac_stop(prueth);
 
 disable_class:
-- 
2.53.0

