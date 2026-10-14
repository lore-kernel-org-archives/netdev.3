Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869E52ED2B;
	Wed, 14 Oct 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985191; cv=fail; b=PXZbTJTzf2Gt4i681AGkoTVzqdaH0oFu/zq0zWuUzFqa2nb0C+pZ7xghHlL8JJDCyteoJLQh3FriZApq4dt49KOkMRfCR3B2Ijn25DJhtlE6ZZexuvUmkTS+6RrEgvlST5XpQtlKizL79hISoiYEimXeWDhgtTjVgmGaTobTDyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985191; c=relaxed/simple;
	bh=hUuJCnremze8Nj1BDqUvniDsz4o6bO8QBWCkQBXuWtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SkjxkHXOBhKBlQTwwvgg0UIHNM1ElujEYGCQzU693+3BBSaJH54L6jCEbGJq2/mG2w9BjjwnIz7KwiinmtYr6dYvFvC8TamMvzaHYKstJUagLGsN3o80845qPbGLc0+ppcG8uC7WlGF868vaFLALrlZnAcwcRabZSiXcdojw/Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=We5ap+B7; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=fqD0d+i7; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="We5ap+B7";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="fqD0d+i7"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EB5n9G2293614;
	Wed, 14 Oct 2026 08:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=9XtVUl64Wn9VuZSqVaCrH0E8Bzn9BWBMv4s/2XC2m
	5U=; b=We5ap+B79HZ3knLCM5/x2a3Z2j2yOWBzA0b/r+4YpBklii/AfVdr5NZfy
	ynXokD0U5irlAwjvZIcS1CiH7G+R1fJOKA9l+NrJ0Jk1pWHbzLa+7+2jytbs17Ke
	Yl14HUPX4d3/TGB4Bb9sH3UJ20w3ovEYQBU6kh0D8bQxI++KhxvYO9w1lCjR7hPH
	suSryEM+M/2WYy6mTSfRHwa26E90Rahxgd+UiW8FyL8XglGVrIHCS/wDj834u6iU
	nB3OwNIAU7ZXOuIa9Nb7GWrP3GLI3W+HMpPo8BXq7Yg4W1ohhv4wmL+LkrCb1lyI
	k0C6PHMTM4k5ipXUoXWw7o77tTkBQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012000.outbound.protection.outlook.com [40.107.200.0])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h9ys53txp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 08:39:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngWVH+ww7OLb4fQuByaKMl1ESeD1capA9i+biZ0PEvRha/A3vrLkpMnzhRvhkZ7Azym+uE+ZyRwdqOjmmQldShg55DbQZSxZOzAsO++NfD6lv8YYwe0LyoMOuFxBsAKgF+DHKBvcAi7TOObxatuh2X0eEyAiE8N8IFNvb3NzV7K32oyBowXipWKHV++1ekl40XillKQffB023qbbrhvxSagLpauWhx3KRQz7Q2qhFy9PdER0S5pAiE+KGnjiLCEx8iGBKqNdfzkPccK1gKEKSYKNi68LHbnAwjx64JsPatBw0vAnQEil5xFNT7tRhZz2ZRHEJ+oI9DH06ER8vm9QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XtVUl64Wn9VuZSqVaCrH0E8Bzn9BWBMv4s/2XC2m5U=;
 b=KGsbdCdIZbUgGAmcyJReHUPRresGRwfvpZzFaVRQbx0gBDYOQQ9cSok1ObLjiaDtPG17jvstBK59f7yCwKhmlaVnuzfXe/C+eIenNKs/OhCah3mC7kjCm7z97lP0jznmXU9VNlmDg0Kad6S2CydUrQddy5S7srIM4jO7rIq39GHnvVy7cZFvdYrvJcZes8PgjmaKRoan3rZFtthlYvJ0XpqsnZ5WMpJWRKz88fnUwwE3gEVAaGlfPUU3FH4ELJdF872+3kR575xp6YukTHoYQRvAgl/WBQpVISFWILIBvGlh58nxx5XxaEnxOxHfCl7yRH387sxuBSE+3G1Ay7w7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XtVUl64Wn9VuZSqVaCrH0E8Bzn9BWBMv4s/2XC2m5U=;
 b=fqD0d+i7wL7mz+bpv4ydgj9F5xgZXv2GFceAAVY4r7YyWqaW3Ix4dvExpzqlqqola2drLga55bGSqBC/+1RySJAhge9v/teiWsD4lubBe0pAp7MVHlFe6WBHZYVPhx3A3SYTmjsKuhY7Uk0yn0CJtY0gFN9UKAAs8KwOqwRlfUU=
Received: from BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17)
 by DM6PR10MB4316.namprd10.prod.outlook.com (2603:10b6:5:21d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.6; Wed, 14 Oct
 2026 13:39:21 +0000
Received: from EA8PEPF00000007.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::a7) by BY3PR03CA0012.outlook.office365.com
 (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 13:39:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 EA8PEPF00000007.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 13:39:18 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 08:38:29 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 08:38:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 14 Oct 2026 08:38:28 -0500
Received: from [10.249.141.252] ([10.249.141.252])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69EDcM5C1458485;
	Wed, 14 Oct 2026 08:38:22 -0500
Message-ID: <b4cab9a9-77bd-43eb-a0dc-cbe319847558@ti.com>
Date: Wed, 14 Oct 2026 19:08:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: ti: icssg-prueth: fix port config and
 rx_mode drops
To: <netdev-bot+sinfo@kernel.org>
CC: <netdev@vger.kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        "Roger
 Quadros" <rogerq@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Meghana Malladi <m-malladi@ti.com>,
        "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>,
        Kevin Hao <haokexin@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-rameshbabu@ti.com>,
        <aaron.richard@ti.com>, <l-chinnannavar@ti.com>,
        <m-santhoshkadavan@ti.com>, <k-tiwari1@ti.com>, <a-dev@ti.com>,
        <pratheesh@ti.com>
References: <20261014125948.230571-1-r-kumar12@ti.com>
 <179198314724.320699.12261216986083339257@kernel.org>
Content-Language: en-US
From: "KUMAR, RISHI" <r-kumar12@ti.com>
In-Reply-To: <179198314724.320699.12261216986083339257@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000007:EE_|DM6PR10MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f5f7cc-84d3-43c6-ebe9-08df29f88c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|7416014|10067099003|18002099003|22082099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	IlvKShr8BuKMvHhJrl2GUCJd0NGu92heQt3Pqc7+S21IEz5sZj7Dku1OaMBODxJ6vIzyiKP8mtuxSzAtWbEkWOUQ3CziYXvVB0zIYjJa1cdLmKEksNHNABPzzapcD8myxGBait358ChitGZ5Z1/uA2Y/saPVzxs+vPHRS+8DsDeVfdolrKLT/Ufz3YlCxeepZoHcS6EwGBBB8Gws0Pbei8SP0OdLY7I+KkWZcHwbfe7jrfWq9Wy8xhIxwVmOm+pG2H7gIJPNyr7QZOChoJVRHtBoZlM0Po7188zdOCcXt6HMMTmLBjOtAqmwZhndBZL5dv7bc4ZmgpKv26ww2UcIgqKQVLoY7afP4+xcBf6T1NtA+Ceufs628HSEVH2KbAYNYfqLp412kJTsFdIVe3wjXJQGPMoZeZxctBvHCVCUUBiFcI8z3J8vJ8HA9zN1hHS2CQrQAFoHmcx0BOsT62+8EXoU2wws3LbX+a5jJ4zqY8fMItYVAsHVa5TGdLwpuDWako0dIgJNJb6AZg6UplS3bnvux4WOS35jwo6yO1xzoFmtgmH0trosLo+dLrstt/VRopxTh1NOWWPKlqR2Wpyu+xC+a+33+qLBWUqEkBFuOeUQur4OHgWk54wCKtXa0NEn7mCGliMxhhfJMeeK3xJotnDllIjKyoqFWhxlYaL5iQ3M2SvFM5OHTrtkqc/KJov1d4wnWGHmES77S97s0w2jcQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zXu3qNY9wbHqwOYh6SXkNkGlgpTgO9VD+DCxxZHR4XBDW/84k5ZjPFGnR4KaWXuwhWdyWPBGGkR/DR0p+x2/uVy+DuyG97eK8+AZjK1g36Qcj1WKX1lgd21aRvzd4ofz6u+d15wwDdHu7qKhgKuSFJM1FZX9P596kRZ/L0E/5A9DYukC6ZuAOcVZxS+HpUooOpkFIOb+rla3qywdGvo3IvTpJI5gt9DIuPYdMA+uNiCvtVN3T81ZjSy5Ip3MjvSF3abPJ7ACbuHpBKfKWIDpuzoUZtnt4cqljxCzorMBzPXA9m1aNrdDWwXxWopZozWM79XyVSU6CYKoi5pnCuVF0soefBJSJLtR3Mc/WhUkgOm+Oj3F/UhgWhOeqnzzeFLwtR5tyxOwRGbXX0AdIshNs+ME3NSjmTGjP2ZqiFs6CyLcz9EmX5etlWBJIcH25ofq
X-Exchange-RoutingPolicyChecked:
	HTKurOUIYqmiBc9J0m3YyEI6O4TjGku2+PmCEzm2iceM4HU3lb7Rk5W9MElpxU8wVUd7LDXpnN1JGMQAsfT3y+Dcw58dsi44yxz2qc4iXtXv11jVJJ2F2UwXr8R076tge/Di59sXS32wkGE5u44VuQZZojCfyW29ujqsuO3rhA0WJEqQgGzhitQqLDU7rvYjKz+sMJWUF5Pz8iB0yVIEBR1X+AOonpJfUyYPHkd0cOZrwXRRIc5E5nnY5vGAF3vZNOlz+mGn+NEi/OXuu3T7oO5km4XGUGF/RXR7FYjt89COkP1znG7nWBFX1fqLATdzoSt3qLFCArdHTCNRuUoRHw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:39:18.9508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f5f7cc-84d3-43c6-ebe9-08df29f88c3c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000007.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4316
X-Authority-Analysis: v=2.4 cv=ANGCXYlm c=1 sm=1 tr=0 ts=6acf860c cx=c_pps
 a=XjJJ5mbNlFGUOIV2PhjyRA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=XoKBYagMS9FrnzcXrycA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bh6yp4qm7fxetn2erWkT-UX-pH_WoJ8z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX1YOM3766zjGd
 kd7VLNKwpuk+4gp98Gw+PEiCoOXR+8yqoX3NeLIwS/+l4z/7RpYRvEgff8EzTMWvP6SsfJMTN2s
 CiKJ/OtqV8KfUEPbx5lMr2mHbQ7Q02M=
X-Proofpoint-GUID: bh6yp4qm7fxetn2erWkT-UX-pH_WoJ8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NCBTYWx0ZWRfX1Nz2KiI05V8n
 iNkLVC1YQC8eUnWGghjyBEYFrjk8iMT4dlCVdnosxfUaEHvdzzPJICf70dQBhUogeMobIhS23SJ
 rvzX5T/4t5Z3sPliws/5N15yVWTRIOT2UTGI3d1Thd2MKUS/BZDr29s2j56NzWslJoPYSVqUaxw
 F10mwDsW+OyVdGaszF66x9UxB6CZROVLN50GdQGsmsoFiAWzLc9nN6g96FKLSPK82yKieOtciF/
 tiiFtvOoqE2l9f9KfmdGtiEszkzDBvcZ75PMt9CTDrL56CAirrsVmlN31LgQAPBZwUXCro3Y7nG
 vCcGtqBloq0YKSOAp7zO74Q5e5FNr2hRltWMqgo6iFN/nbeYGEjJn3JKwzOBTGGc6OzUcdFadHf
 IR/wu4I8Wy0tlti94WzplOaEYvtjAUlUjmPtqUSK+5kS7U8hGvUNyvokBlgoCIGSo+zNaU2JGyl
 7TonsWiA8gHWnKC8cdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140054

Hi All,

On 10/14/2026 6:35 PM, netdev-bot+sinfo@kernel.org wrote:
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 

Both patches were tested on real hardware.

Board:    AM64x EVM (AM6442)

ICSSG:    REL.PRU-ICSS-ETHERNET-SWITCH_02.02.16.01 firmware

Software: TI SDK 12.01.00.05.03 rt-am64xx-evm root filesystem, with
             a kernel built from net/main plus these two patches

Setup:    eth1 and eth2 bridged in br0 (switch offload)

Patch 1 (fix missing port config on second interface open):
Brought up br0 with eth1/eth2, then cycled the links (eth1 down,
eth2 down, eth1 up, eth2 up, and the reverse order). Sent 30
multicast frames to each port.

Before: after the cycle, fid_c1 of the default VLAN was 0x3 (or 0x5
for the reversed order), so only P0 and one slave port were members.
Multicast forwarded in one direction only.
After: each port is configured when it opens (fid_c1 = 0x7, P0 + P1
+ P2), and forwarding works in both directions after the cycle.

Patch 2 (re-apply rx_mode state after firmware reboot):
Brought up the offloaded switch interfaces and sent 30 multicast
frames to each port in turn.

Before: NRT_HOST_RX_PKT_COUNT did not increment for one port.
After: it increments for both ports, and forwarding works in both
directions.

HSR regression: brought up hsr0, sent 30 HSR-tagged frames in both
directions, cycled eth1/eth2 down and up, and sent again. Forwarding
works in both directions and NRT_HOST_RX_PKT_COUNT increments both
times.

Logs are in the gist links in the commit messages.

Thanks,
Rishi Kumar
ICSS India

