Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793688501;
	b=gJwUm2oaAox7FASDU4jpCovVVIozDUiytFxWbElxBVxOPGHMQKsb4/7FgNvdTz+sKNYj
	 rSew53WqA6ZHGvMJYsPUmx5RtO8zbkqa2p3Ryb9UE5cTN0v49AWFYMd06gNJJ3ScypukU
	 sV661hkTLlDMgos3s6cYsq4oIyMeu0lFVbKQGWAp/N6cp5os/r5twTt1e9C1vEf2yWrHk
	 6b98/P4abSkrQuppkR5cR5NGK5e1yfqOrCVUwAKCbJAD2hFGZeS+Elfu2MSTl3GKy6JQ8
	 7Syj2eyK9dcYmADBg+2XRG2elO04K6/1+MHOjcfNHxRsEZxTatgzv2rJG+9mDVljKFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688501;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ekd2zcgnVsIQYhVYpiOa1GQSQ2K3pAbw4oQxFy2SUUA=;
	b=C3OisQ4fYu35vDD9VnV1IiZFXhtZ1jb1lVTJs28xaMsdGFgpjczRQcsFA1ps0j5+Xyzw
	 OnWsHddfNO4qiN3EL9f6lTyn0kZKwBaWfBOeK++hS51cAGpBn5BN2rtzPkZX0yC/e+/MA
	 rCb0atWnUp7L9ByqnOkNrMiP58YA7/brBIvxhXaepJHPKt/s1Jjwk6qM85QcHWLHh7GqE
	 bJwMw7vyhsCrBTPqJNRAODwarijrt5ag6aDURM56DCtw/bN5DvuINfLEfAK66PdcaDo6P
	 ipK9nRi7ij3ksec5R1bruj+ZgAd6qKny6Baqc8NRaOP+2qyNfy5LswKlO31Lzl2cYrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dt8GNmXc;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=QfJ6R1Do;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE75606A329;
	Tue,  3 Nov 2026 06:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE75606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dt8GNmXc;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=QfJ6R1Do
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A35xr1T2263777;
	Tue, 3 Nov 2026 00:47:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ekd2zcgnVsIQYhVYpiOa1GQSQ2K3pAbw4oQxFy2SU
	UA=; b=dt8GNmXcfGcJ4rFN7Sb8PBMHE1/nLnKa7zUUfub9bw9N2MslvvsBzdhSr
	mZfLFu/IgZ2qNP/V/HZ8hWFyv0Zp/vAINeJ67qdAkToi56Y6WLppa0QvXTjR2TQ7
	OYUhN5ezm1sFZjOHKK6g9iy9g8EMm29+CnZAXgTV01y28whjeI8rPqp8t+Woqarr
	fvigJN2Tmm3w45wWVtseaFUlZxf0NrsJH0kY7f2b10mUflHI4xBUSmyutPcEdF50
	ukQlkNGCwn5mc9EhiiYb2sR8zmToDQ6rzOzcR9ZhBMWokTO30Xytwj/34G/F8RYA
	mA5utHozXZ5LC798R2qBweiiInBRw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hprvb5ubs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 00:47:33 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQNGhV+Xqt39BCM+asjUJZrytr7rYlojpXI3iIZGU5QZUU5ES1GgX6QwDqQuy58zPR4UN0oeVXA+0W/dgIhmn3uCIS3V13rP9IrM1X/lNR8aalXa01GTNjC5b0ln17QEgFxBYH93nPRYZW5jdBWuuVNZW/opjRQ2dbA75wVUXE82dMusWcyOgkEmmL4lqEjmnRldUh5CTCovl6daXVjr6Bkxiqrk35ME2YzwUsH69p4Tsn0k7R+NmG1g9L+m+nJwi1+eqYWc0PaWOdMVK8YNQ9VW0rMIVmBkn4dwthf0iRqVhSLuz0bC5ur3OcGnGZGysRWh73fFyC7vAB2qC+cjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekd2zcgnVsIQYhVYpiOa1GQSQ2K3pAbw4oQxFy2SUUA=;
 b=NRL585BWz1SOAxbsQXEmuxCG5fiSAKGHFYWoqHMVCZ822F9iMRJ2RPt/aTYjeKdyELmSsjNecYIWjltM3nJSW4KQiQG5tkc39RdDQ0W1KqbEEk4yJ1u7dfu3LzLN8nmeADxuKKP703/ZiAWl5jgIb2pxfPn9MIolGKcuH7jS+3XKtyFnvM3Ovg6HSb5QW5qA5HzmTilpuLczsOEVfsDa95FGSDaGecdTU/At+1iCdgKOTPdB/twPZQwk/adQruqad1VxMJgsNQBRIWSFs0gHNKpcaxGZIYH++Ii7/n8IRH9JN6vJ0dnL5KDkaBK77n9+LEW8a4w/M2jd22gwAF+Stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekd2zcgnVsIQYhVYpiOa1GQSQ2K3pAbw4oQxFy2SUUA=;
 b=QfJ6R1Do9w8ShWHU5ZTXURJ0+DGj2bvJf+JWgwmEypkm4eUOlcH7GX9hZUE3UepL4vYGg1qBruJvkGLbpLBUyGlEfnzvwkTk1HLj4/r4Uf6PEoS8mUB6FH8M58BHDM4c3l5Qfa1VWkB15xF8XHoSleoU0ifCm4/UvjBYHrBJeEw=
Received: from PH8P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::25)
 by SN4PR10MB5640.namprd10.prod.outlook.com (2603:10b6:806:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:47:31 +0000
Received: from PH7PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:510:2d7:cafe::33) by PH8P222CA0012.outlook.office365.com
 (2603:10b6:510:2d7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Tue, 3
 Nov 2026 06:47:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 PH7PEPF0000000A.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 06:47:30 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 00:46:53 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 00:46:53 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 3 Nov 2026 00:46:53 -0600
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A36kmda3649823;
	Tue, 3 Nov 2026 00:46:49 -0600
Message-ID: <01142ad6-a75b-4ead-b5b1-bcec8c3b9af5@ti.com>
Date: Tue, 3 Nov 2026 12:16:48 +0530
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: keep port and direction
 when matching PTPv1 TX timestamps
To: Jesper Lyager Nielsen <jln@pascal-audio.com>
References: <20261030-am65-cpts-ptpv1-v1-1-0bb4c370d970@pascal-audio.com>
 <810b7cc3-fa53-4be7-a519-bc289c94d9f3@ti.com>
 <AS8PR05MB9908A5534BB1DD88BDC4685C8A6A2@AS8PR05MB9908.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <AS8PR05MB9908A5534BB1DD88BDC4685C8A6A2@AS8PR05MB9908.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000A:EE_|SN4PR10MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb7db6d-4f4c-4f81-18e9-08df397654f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|4143699003|56012099006|261028144727099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lDKvD69j278rwjZF+sx2ZutOn10GYEOI1ESPlIngJGlocG7+E9l7HK4IfyE9eFRh+1FfxKO/tucDcwck7WnsY63LV8ZFojLQWE6Sa3SBC0qfJ2yEUVJio72NZSF6xqZPBoHiXj5EE61axpP0RxBZQArI9ptYei00vkTNkJjYaPQrbeVPBvelgcHWy9aYsoc4WzM42vR3B9Pqk4uY0+JTsHhIIvv6JuApbpFdupykcGLVfw7hPmWxYH+uonKFyc27aq6tSCmwwy8bRtFPsq4twEq1BcJ6ecWmVRQPxqEvFrON8/rm60qXNd1305p5KEQR9awDcuVKBI5lJ8bs6/4jxu7Cz6NQxfdIytBo8uFWaznjU7HHifUukaYn/tSZh+wI8+t0sEuMdj51HCd2cUd4iT8hCtcCRT2R6hkcCnKFPkZmdJXjdwfrMdEhro1pGct1NN+MquEZEseiUfeEL0MF90bvbrYmSCPLCkiMk8qvyyxcwIkjOZN+ok6TpDTKdvMVnO1nDijpZ5Xezn9tFjYl/VjIDjECd7zFgeGJxPktqzBlDT7QIALkVXG27rmynYa9EUdU9COEHusPGGwP0rMLGya+o1fGGzJcOuhPQ/CWWPyNYlOK3NYJbxzfAUiBkhN9x691s+nd4nyc2sZpFhiFJ1OSM0CfBq+DfvoLsnMWn3Q66dO/uJlGQVjE50St0lbvk0oaVaS7s7AZUwXkOu1muw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	21xu319ntM/POlpLbHPRrYfiiAfUjV3l8KcOg2z7Mhgn3MiKmgYarJvE+YEriuVzSOaiIKimnPFZGMs0IOxPustXNpeazbJb827HkyU4OjdKRsY80fZHzOLtCT2XTGJviUIwwBbkZ1NpClERE6EdG3Igg4T2FZshYzyyCL7TIH90SVsYem/8PCu58Wop+iu3iDRuqV0CSPt43rKgHog97MAvww6xBZEccfht1zbAA6qaMD576LdVnMfXPGxGVvKeOXSQAz8wTwAvGQoFsw9DOuQ1T76V/8QJ90jrtz6cpls9zEipfQrrpTNkQJbAQwH9lcj06FNrXWzWthFxD0SCdEh75a1TH2+a7HQoSMwwg/fh8dqgIQJSfSYrHTGx1NnLbaJZRH8HTyFRRzCNaGqX6Ke53zIvrBvHJUQCBj+l168lIXrOqQpqdLvqasjFOB+I
X-Exchange-RoutingPolicyChecked:
	1kHQxMIJCaj/XPIbWX07GKVEtfaDlwiHTZZrZVVMr4BdeSStmlzVh7bkNc+BxFyQz5+cPQqSof6yz+/rkU2QZFFr8TytrgC5iNGo5aWSJWS0v5G2XTsBywKcNYdRuRHPxlRDTWzziNgLYmkluG1JEqDf4ZG5rMmBZoP+xpy7WM/9t2NS+/FsHbTburokWJcFz0xMZBfGb/jXgdHDxAxRHN3BNn0y1ARo0LB8diSU7NoUCi5WR3/H/MLuYVBC82N421byxqHzVBF2fKeMFbcNDDay+MML6FEU6aNf9HIEqZbCgurt8p4Xo7Unr6Jf8GbDl4GND+7rzbhVQgg8/gNQww==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:47:30.2800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb7db6d-4f4c-4f81-18e9-08df397654f2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5640
X-Authority-Analysis: v=2.4 cv=BN8mP1QG c=1 sm=1 tr=0 ts=6ae98385 cx=c_pps
 a=YlG5uxA/pALHGIum7WOvew==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=QYM-SFhy795raivF91gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PTsr8qXD2VPUDPmU3tsP1J48iFXHS7y-
X-Proofpoint-GUID: PTsr8qXD2VPUDPmU3tsP1J48iFXHS7y-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyNiBTYWx0ZWRfX1xEumgzB+j1O
 APH0vaOJeihUKiAPomZknW6beM0Z9RGZZ3QX3IIOOLy+UyktnNNtpjde+4hfU8twhLHMoMW8vIR
 ujWaPyJppwB+ukSltXHXBKX+iFD+IYHZOZgwPq8fqP/nJnWZFX/BWBATNwcSRdxq+QcHKAvjEwk
 ISzYM1fLwRTtK7QLCIJqnuDjb8Va7bsn4h/s9npCaL7IGoJPZg3TvsbKHU8/LgVmB1FY7XxI9Kz
 PivMx6rPskSF1jTN3hrN3SsuXv/65wEmg5P59ccjjzYpniDNAmACXw6RSgtJKDeeIqge+ZX+D4J
 Yj1KpGNoHPbshbqyHx1WKpBXVk0vWQdihSida/q4aQCiJtZu9WRp9DtKx07jcJahz46s2iXE+l0
 p4wC9sbiIEC1BpaP/JZlsI8kHEdzoZUnEWuifir13drBq4R08WFSIWM2dxBziMdgmoRsKRdQ1OL
 blOLKpl0sl8pO4N5Yfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyNiBTYWx0ZWRfX2I/AIvrcBQ+a
 Webizpv7+xLSpi7BpdueN9M/3TYhofXorCuxiVkP3OZ3h3F6R/9Hzc+9yhPzUV7LRpAj+noXFNl
 rpvWDKROkKVi8ILlNm+EeiIHBaijEmg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030026

On 11/2/26 7:05 PM, Jesper Lyager Nielsen wrote:
> Hi Siddharth,
> 
> Thanks for looking at this.
> 
> On 10/30/26 ..., Siddharth Vadapalli wrote:
>>> For PTPv1 this defeats
>>> commit a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps").
>>
>> nitpick: This could be wrapped as done for the previous instance above.
> 
> Will do in v2.
> 
>>> With a PTPv1 master on both ports
>>> whose sequence ids run in step (e.g. a Dante device with primary and
>>
>> Does this mean there are two PTP grandmasters? Is CPSW configured in EMAC
>> mode or Switch mode? Is the PTP application bound to both network
>> interfaces?
> 
> CPSW is in multi-port MAC (EMAC) mode: eth0 and eth1 are separate
> interfaces with their own addresses on two physically separate networks,
> there is no bridge between them.
> 
> This is Dante network redundancy. The audio device is connected to a
> primary network (eth1) and a completely separate secondary network
> (eth0), and every Dante device sends the same audio on both. There is a
> single PTP application (Audinate's PTPv1 daemon), one process bound to
> both interfaces, using hardware timestamps on both.
> 
> So there is one clock, the CPTS, and one PTP instance. When that device
> is elected leader, it is the master on each of the two networks, with
> each port sending Sync/Follow_Up into its own network, both timestamped
> by the same CPTS. Each network has exactly one master; it is the same
> device and the same time base on both, much like a boundary clock or
> ptp4l with two ports sharing one PHC.
> 
> The daemon keeps a sequence counter per port. When both ports start at
> the same time, the counters run in step, so Sync N leaves on eth0 and
> eth1 within microseconds of each other. That is when the same-seqid
> event of the other port can be matched.

Thank you for explaining. The motivation for this patch and the problem it 
fixes is clear to me now.

> 
>> nitpick: Unlike other subsystems, comments in netdev do not have an empty
>> line at the start.
> 
> Will fix in v2. I'll wait for your review of the code before sending it.

The code looks good to me. With the nitpicks addressed,

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
