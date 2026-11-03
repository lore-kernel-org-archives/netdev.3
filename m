Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793746368;
	b=kSuvhXtGTk2lOYZQ9zaNy1nIvU31f1cu1v83t0oQ3DOxUU8u8Zq5k18GyFImv6tYc3hC
	 myME34/TSgsnj3gogkIdGBULZGeWnV+PjS+b/oJ35bhrKKO+MtKS2oVoLVctuW4mkXgQG
	 S432RIYY1KU3oP6ptt+qtkBK7wcby2frIA5m97X+CzhQzfuq6UULxC0AuABdKnMR18K1c
	 ntS5Kb0mrXSJLu/SrOsp+hV3jJ6OpRmtLmeTxyArZrIeRhp/u1KnpZFYePKFHmTEIaIMO
	 zeMynAmPhR5q571eJ7uPMMhG3YlwXjedHHu8t5Z+Bm6eG+vKeFP3KarPLi5O4C3CIXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746368;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Kvw2CHq4iCD6iHilOxfhE/+jG8RYAurgBUyc04efE2w=;
	b=J2KLq1s4ROeajQszqN0uFXRoqlr998INYNdLT75QB5dfbKW+TTJpiva/YEB2VQ+6s4nO
	 wqdWshWG9Xa0AyRirfGm341MLtqnIP7AQIefaKZz7M7iolLw+uKfiyZuMmQjSrWf03cfX
	 Oo3/jYNypH10L/lXFJe6yNEAgm4x0BhOLhCjs1O7lle2zwRDoO/I90/1zEY6Uf5lte487
	 ZMgyBNqteNx/VjBsOhzELxtiK88OlmMglLa51JHM9elRxcHwk9c8fS0FOsuK208Z1PjrT
	 U0Cd40NsUIsxnulSL7MB/4XmAEvyf2ZR2w+oBGub9Pg9eY1/d5fn7fg+8Lx3fQJG6Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VNuRvKxj;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QnHQWJAg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F04606A337;
	Tue,  3 Nov 2026 22:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5F04606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VNuRvKxj;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=QnHQWJAg
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3McFHq1275176;
	Tue, 3 Nov 2026 17:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=Kvw2CHq4iCD6iHilOxfhE/+jG8RYA
	urgBUyc04efE2w=; b=VNuRvKxjmzBclabTQxuIlDFhmtXU576Al1UufmSBVgxdz
	siiuCg51m92XvSX1+2XN1pSf6ITMRD+3RBBeA0zJAI63h2CUld4F0H6Acna38Dnv
	lTfNbmUIKLGS99eVc43VW7erq1tBZV529hEudK1mOmLHYkQmmt6N66rJjGWI9APJ
	lMo+ZJUXg8qPm9cvJwTc0rVk+NDexd4p6/CYX7h8Xk/epdHp1Mxgqn5AxF/MvBHC
	GzV762hiF9Y3OB8y+MmDWVxRNuSleVj2D86gdZlW51IB+ZW8AM/VG68LMfs6SGic
	BehV+hIeYxUhn2wzK6lyp2ZTyqBRMZhDoIPcY35ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=Kvw2CHq4iCD6iHilOxfhE/+jG8RYA
	urgBUyc04efE2w=; b=QnHQWJAgHZd4M/z/2NlFjQeLwcHPRnKjG/xj0R4rMvh4K
	+j6VhvgcG+aFOuQi0qJNkjHeCaelgAtgwMjOLvLJKo4ZVRDsJyMwoxAsFkkRcNgh
	IQGqKr7nK1jzxEtS1aquOTXHtn7n4nEzrDIrpuIb/3ISF2CiPozlIS+4sO281ksh
	zEVfHL2LsCOBp4xGWINlc6iXZ9C1qXf94v2pmhrkqS+vBVzng8Lq3DG5Q4f1kYL+
	6P0frbQkLryL5WdS9hORD6iCJKMA5V+IMszJH+oTXLKXqxev8kuSMI9WyXySmyYL
	uiIS5+Wn57xam71YZHhcwfszZJyTOMTgfsGAsioqg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqrk4r1rc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:52:29 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1RY1Ic8MLm6gXP6ieBd0dsmUjQf1V46waAMl3rbXh/F7jpiWEUNjFeZMIg4iCCikl7Enb9s09S7UljAWSnq4nvqMDBJ9pqaGEHfeSQMdK2ottzOFga3Ay/OxcjMJpm99WZ9ek8PyDthz8cVqykPc/ixrNdsoIFg2YCFbBS0xG1xOoW8NvkUQIPYpOKIoZGXMUzbFGl9O+h0sTiwRKDky7v4g1dr/83v+Os/bwsqP2Aia7v8uWZYWlWgMkzMzpStZ6plz4fgj9YMwYcaFOwHHtIRoqYqAl2BZPQJsxk9u3xkSJl7ANN/ktE5YcZcnZNk7f8D93BkVyH/BrAXl/vTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvw2CHq4iCD6iHilOxfhE/+jG8RYAurgBUyc04efE2w=;
 b=EOwsL5yTSIfajavDpYWfjDh/gJJgo7i1aDBc0LACH3CeSQRk3Rm8xN2C1GuxV3akpHiCjaqDwuju5GGJ2T3FySPNjddm59kXaVd0M8FOAdXlPwse5P3FiShZe6SndDMkEFCwOrPEZPO9u9UTawIeGmX8yT+45+GJfEQg1Vw2QHZ6Lf1c4UqQeJGsY9XEnSuYyjEqrxXHfOQomPqH7hZmyIs3yeUfTxn/AxWtBV658i+XHub1v3b/UrZ0IR2ZdI6r4qPVWtNlaajBp4nCSejHKy4b/g33rwMKod1W+Xcxwqd4ptkP/ItaVcB7Z8z0isv6ZqZSprPhBgQzDVEOBLGE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by DM4PR03MB6095.namprd03.prod.outlook.com (2603:10b6:5:396::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 22:52:27 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 22:52:27 +0000
Date: Tue, 3 Nov 2026 23:52:24 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 10/10] net: dsa: realtek: rtl8365mb: add
 support for RTL8367S-VB
Message-ID: <auph2uJLrJ6Nj0dh@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <c7f88f0e-b174-4715-b148-5f9a2648bc2f@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7f88f0e-b174-4715-b148-5f9a2648bc2f@yahoo.com>
X-ClientProxiedBy: AS4P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::9) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|DM4PR03MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: b17d049a-4dd3-435f-8f93-08df39fd21af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261026121527099003|261028144727099003|261026140227099003|261009223027099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|11063799006|4143699003|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A9e/aKTb3tnj5Aq+ZjZ42malAWlOHqmUYDqtpwlM95cbH3QIFcNqtI42sBUECNPrP9S5DuSQANoset8nvZ8e36YyJB7NiG9V7Xs7om5cDFqCuKM/ysHFIEPCJAY0oAmHkAOvUWR2/Hfm39P0czGVvTD5XG8z79W+xDrPjHpk/pVLePxlzQe8pPi8/9iqqUy/hAnJntzl6fr7C79CTf096IDMYXm91hxA4V8ms+SMEpBV2FHaC3TjFlrRiqjx6asHRxDkoKL/tsp+XNw/UvnXMc0Errtzg9Qxk0konFZcQnG+1tS4ilZZNDXkbUlNfmeVQve55DcFGVr/f0qyvBP8ws13MnPbm72nVn+ltjpWBCCNCp6k9kumK8/jGnbL7Rn95nGR10ITGrURvrWS9o4JzZkWJwkxIc5gjoL4RT3d6R8YJJAv7uQmldyF3aDg4YyA0unp3LtIVZn3hDzMcA/NRRWEqxOydJhwGF8L8JeCnejbAUmojFbrOifr33Fc4M2T2y9dq9tDfuJkheLdAyxENNw3u02ofWAx5shXngtlhOF61dnlDT3cHXxnvWywZRJoeZzEOP41qAICvKLMFdC0sA9hwOBRXITGjZ0TK3+WA2TtQeLtPEl9JSSYcgAGf222ZI9mi62O1SLxR9qVRm6PBbatdxKv4Wb1sd90HdEfnXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDVsdXRMbGlLbEFYWlVrVWJPQ1JXdi93Mm1jWk80QmliNEkxYU5jWEJKcWpP?=
 =?utf-8?B?dmVmcm91QlJCK1VJWFhXVThqOXNJWThsWkxUek9IR3VsMG0wcm13eStOckJj?=
 =?utf-8?B?M2VJZnBtM3ZONXM1aG05cm4yWGY3V09zMFVLTFVPcEU5d2tvMlJDUURxK1pp?=
 =?utf-8?B?YU9tOFlnSEdWdFArUlNMK09nQUZSYzM5cDNEYlZQdnRmbHJTaWZ2dnBmbzZR?=
 =?utf-8?B?dngvUWhremNscmxFR3hCa2NsWWYrZVJKazZpVGNEcEQ2S2pNS3M1SWJjbnVz?=
 =?utf-8?B?djFadEVFbjBGczlUOTNrdWlIZlh5QWY1UWNncEhxM0JiZWpBYXN6NUcxYm9D?=
 =?utf-8?B?VWNCek14MmhmUkpYZ0lndS9SblZFcWJVSHJqTk81ZnpzWG01T3VySUdabXRm?=
 =?utf-8?B?clVLaFFuRFlCT21vbEdmSkR1V1JIdDFqdXhPQlNyVUxPOCtTeERiZUhYZDRk?=
 =?utf-8?B?eU0zRm90cDJvL0pWaEkrNDhoWXorL3gyZFc1YytYUFNLVnNZaGR1QnNsN3pl?=
 =?utf-8?B?T2FVamlITm9zUzV0RU9IeXdzS2Z3NXJwOVk0a1pUenpsQ0RvOW1sam45b2pk?=
 =?utf-8?B?RjlQMi85aFJqN1RaRkIvS25xZy9Na3VuamFsajc3YzJ3SVdtZ0JFaUo1d3gx?=
 =?utf-8?B?SnJyRzhCUGdkbkpSVnExdE0vN1Z1cnpibmdaS0FxeHhYakhhcEFzQzBUM3lI?=
 =?utf-8?B?TXo0TFhmd2xwSENtdlFjalRDa0M2ZnpUaU9tcmZUdnJmOEtHcEV4TXRUMWVP?=
 =?utf-8?B?dnNqUm5sblVzUGp4UXFwTzJBcFFlVDZiYzhSeUk0bDROVWovM1dqVkJKZEhx?=
 =?utf-8?B?MGd5M3YvbGhUY1pKSFV3RzFzanI1VnAzQWtSSGJqekhBS2ZsRktlYjNnR0ZX?=
 =?utf-8?B?czVRbFQ5RVdWOXVVeGN2dnMyaTkwMmVUdnF1UDI1Sk15MzlYU1VMcEcxcU9o?=
 =?utf-8?B?enJHb3RTR2VaWnRtdjRXNW5SSXNvSTNiU2ZNMVovOXJZSWM0T2VsNVNVVjk0?=
 =?utf-8?B?Nk95V1RxU05XdUk0c2N5UGxLZFRxWTd0SG5WRXdlSUFjYWdhcktvS0dQRy9o?=
 =?utf-8?B?Mitoek1vc3FUTjMrMWtZY1FBY3lCZnZDVEE0MVNueUUwb0R5Y2ZqVk5GVXZp?=
 =?utf-8?B?ZUljb2xmN0liTDh2cVpNV09xakd2MmZmVmRjblJPNzA1UzUrREY1cEE1VWFn?=
 =?utf-8?B?TGQ5WGR6UFRyTjJGU2NPamhPSVJmT3ZXaVBlZUJ6bUhQdE1YaWtxeVFaYWxD?=
 =?utf-8?B?bXRhTzNYdFo3VHFzcDhNOGNLYjBHNFY3aFMyaVhTVkdmQlp6TklyVXNGQTBl?=
 =?utf-8?B?c0YzaSswb3hLajNtOVRKTEFEc2JHQmNCU0I3bWV0WTdZWGlHMURqa3ZQOUNX?=
 =?utf-8?B?Y3poY1BKSENKNGhKUk1KenJzMkVVdGsyL1h6Q3ZhY295SDNwYjgrK1pGRGo2?=
 =?utf-8?B?cWR0aWxIQ1k1bTc3L1R2L1FJY1NFRmRuMUtndXV5UEw0b3lOWkY0THZwVlhi?=
 =?utf-8?B?N0crUlBTR3dENmQrd04rVXBMcW5ZMnlXUlpHa2JUdWxYYkJSTWdHbkYrOTM4?=
 =?utf-8?B?SUhIN0ZJREE3ek9SQXUvVVo4WXhZL0oyYUdnTzdQT1FSN3RXa1J6aGJ3VDE3?=
 =?utf-8?B?eTlMVXBGUHhSVmNwZnJHZHNaSkZDcmx1TnMwWjNYYjNoUHp0VkJkK1JjWllF?=
 =?utf-8?B?WStEdGtDZ0NEUUI1Q1FFc3VnWk1YWTk2YUs1aDZMeHdRNG5iRkpvakxDamdT?=
 =?utf-8?B?YnBjUmJlbW5HYXBCZGlvQTFSYzNscE91MHQwd3huazlNS05RR1NIMGJDdm9O?=
 =?utf-8?B?YTZpUXR1bG9hcEVpalZqbXIrOEZJOG13Q0Y1Qnppb1U5d2N1bGI4a1ZkNlMy?=
 =?utf-8?B?U2hNY04rcmVUeVVaR1JNSTUvOWx6VGxYT1B2dVMzMmc1aDBiWDNGb2IxbFpn?=
 =?utf-8?B?NS8zcFQyQzdmbzMzMjZRUzhQY2hMc2lSTlcyck1wTnBZNzNnMVZzVE9XcnJW?=
 =?utf-8?B?cVpFSlpFNHhWSXZvQU1wcXM1dVpRdGJ4L1Z6UG1FYWIycWo3SHhWZ25pWjB0?=
 =?utf-8?B?SVNZaG5keU81cjdzMzh0YU9LSGd0b0NmN0hVdDcwZU9GcTdJSUtIdUJoeCto?=
 =?utf-8?B?bXpzc3BnK3FINEIrV2U3a08wd2Yra2N4clhSWURZcmFOcndvVi8vbG82L0ty?=
 =?utf-8?B?bzNHRm5KR1pud1JNUEFvN05QUFowT2pRWnJ1MnBxQXZ4bVpXQkdFWEVRMlVq?=
 =?utf-8?B?UDloeUo4cUdobEJIT3hhbVZzVjVIMUlUTzYyRjJoZGNyMm8vTDlTRThtL1JX?=
 =?utf-8?B?Q3BndXF0RFdtSWtiMU44SU1sdTc5VjJCZU54U0FsdmZMdFVzNm42Zz09?=
X-Exchange-RoutingPolicyChecked:
	bfcIEypsT9d8FmoLX6xRoNFBVHQcOHwcIdZCQa3hp0qIBNr3GI21FCl+E2vB1krqhFTq2qJYcAYVL5mdN62UzGTMoBkvjJab3WPPy9DtTX/NMmMdr3W8/ksFDu1U7aoH5Z7xpP1bgZVaJRUHDlTL6xy2QY+70wkHSS3J9NTzCVDvWMDQGNk2g1MlmX0oeaQ5A7gI3EmUHF25g4wdUuKVl+Ug3b7Uug6TFr+YqqgOyrPVjODhfFibCF8YIslnlF78dO2JOCBo+I4RttNl0zpqq5SRKWKWvxuWFzRDfNRbfLgOKtjuSqepVSrpGpYV26sMjFU+tUHZAKk23GxI+0nahg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17d049a-4dd3-435f-8f93-08df39fd21af
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:52:27.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6cWcLvsSB1J+C6A9Rk5ynYY1NkOnfBR3kF2tJu734k54A/vfB8imuZYltOtlmmfOusoUrxKNc9IMDght4NVYNrT39ZfODKEw1AtsGWcpt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6095
X-Proofpoint-ORIG-GUID: amlk11lwoZi0FnNgSuOTwFdtIrSb5GUD
X-Proofpoint-GUID: amlk11lwoZi0FnNgSuOTwFdtIrSb5GUD
X-Authority-Analysis: v=2.4 cv=Y7RtIReN c=1 sm=1 tr=0 ts=6aea65ad cx=c_pps
 a=jCxDXDPT0EaKR6BOOOS6sQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8 a=GGA8ojeL3cKRt9dOYxkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MSBTYWx0ZWRfXwQysqvoBH6ft
 jEnGaj9jhdRa7f9fZX6a3RUmAWRwr47rietDReTtslucnVxJvTDGZankcOeADCQxMu7HVylYD9h
 fz3EbhKM0EPZ2G9XgWb5qrlbVaWnm9dew5syO2agfTOq56zvdQbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MSBTYWx0ZWRfX1LYdvCQ+o9rp
 qbwd80Kz7SMYn6ZORLBhHGO8Jj2pr4rd4Ku1rDl5fkwBB77hgunRTSQhNp5LqVdOL9liVHaAt9S
 4DI2+Keene2dSE2zAJo+SdaKn8TRParwfJDlQTBFaoLaAz7FwqVyKOzQ/EG6tcgNMkQmC4AXYiY
 lZjwxXtwKjs9ESSBrQ6yn2nEte60YgIMCOhLxSDMFk5FKghKI+d4BvDtfqDbAxDpW33gFaDWZZv
 FREZDVITYozJdVKAGrwcYa9OluoRYB6i1vtMX2552b9Juc+I1nvE+lwq82fbRZzMf83gnKjipmn
 hqI5EKVUrrcchrerwzx0Ff8hruOXrqJf6m5ldbm2+9WbGHqt4pr+6AZKZldJFjIaJn3NWse8OBS
 AOHPyGNXvlHreLIEzGXzMfaIoO4viMjFTM1fJ0sTUp5Cv4WtriwQE4mZD5D2QkwlZIYaZ+5E3GV
 e/KFTOsol+6mpOwTHkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030091

Hi Mieczyslaw,

First of all, apologies for such a late review! I hope you appreciate
the feedback anyways.

On Mon, Nov 02, 2026 at 03:45:37PM +0100, Mieczyslaw Nalewaj wrote:
> Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
> It is the first chip of family D, whose handling was added in the
> preceding patches, so this is the patch that makes it reachable.
> 
> The SGMII/HSGMII SerDes of this chip sits on port 6 and the
> MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
> interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
> The chip reuses the existing initialization jam table.
> 
> The chip has 8 ports, not 11. Cap priv->num_ports at
> RTL8365MB_D_MAX_NUM_PORTS for family D. This is a functional change: it
> sets ds->num_ports, the IRQ domain size and the bound of every loop over
> priv->num_ports.

Something about this below...

> 
> The L2 learning limit is the same as on family C (2112 entries), as
> given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
> RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
> comment is updated.
> 
> Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
> to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
> also been seen working, but I no longer have the exact link partner and
> speed it was tested with, so treat it as lightly tested. RGMII mode has
> not yet been tested.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/realtek/Kconfig          |  3 ++-
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 32 +++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
> index d6eb671..98b1727 100644
> --- a/drivers/net/dsa/realtek/Kconfig
> +++ b/drivers/net/dsa/realtek/Kconfig
> @@ -34,7 +34,8 @@ config NET_DSA_REALTEK_RTL8365MB
>  	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
>  	select NET_DSA_TAG_RTL8_4
>  	help
> -	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
> +	  Select to enable support for Realtek RTL8365MB-VC, RTL8367S and
> +	  RTL8367S-VB.
>  
>  config NET_DSA_REALTEK_RTL8366RB
>  	tristate "Realtek RTL8366RB switch driver"
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 1c5f139..415468e 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -89,6 +89,12 @@
>   * things will work out-of-the-box for other chips, and a careful review of the
>   * vendor driver may be needed to expand support. The RTL8365MB-VC seems to be
>   * one of the simpler chips.
> + *
> + * The RTL8367S-VB (chip ID 0x6642) is not part of the family listed above. It
> + * belongs to a newer generation, which this driver calls family D. Its
> + * registers differ in the VLAN table, the external interface speed and RGMII
> + * configuration and the SerDes, so the code paths specific to it are selected
> + * with rtl8365mb_get_family().

More below, but I hope we can sort of avoid too much branching of this
kind.

>   */
>  
>  #include <linux/bitfield.h>
> @@ -120,9 +126,10 @@
>  #define RTL8365MB_NUM_PHYREGS		32
>  #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
>  #define RTL8365MB_MAX_NUM_PORTS		11
> -/* Valid for the whole family except RTL8370B, which has 4160 entries.
> - * RTL8370B is mentioned in vendor code but it might not even belong
> - * to the same RTL8367C family.
> +#define RTL8365MB_D_MAX_NUM_PORTS	8

This is OK, but in the same spirit as my comment to your other patch, I
think we want to make the C and D families equal. So why not:

-#define RTL8365MB_MAX_NUM_PORTS	11
+#define RTL8365MB_C_MAX_NUM_PORTS	11
+#define RTL8365MB_D_MAX_NUM_PORTS	8

and add a num_ports member to struct rtl8365mb_chip_info. Then below:

[...]

>  enum rtl8365mb_stp_state {
> @@ -3996,7 +4016,11 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
>  
>  	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
>  
> -	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
> +		priv->num_ports = RTL8365MB_D_MAX_NUM_PORTS;
> +	else
> +		priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
> +

The above becomes something like

priv->num_ports = mb->chip_info->num_ports;

The reason I'm saying this is that I saw quite a few places where you
have a construct of the form:

if (family is d)
  // use family d constant
else
  // use family c constant

Which can become a bit hard to follow/maintain.

I haven't yet had the time to look closely at all the patches (I picked
the other one first because it was missing a Reviewed-by). But I'll try
and take a closer look tomorrow and point out where else we could
improve in this direction. I hope it's possible to remove most of the
if (family is x) { do something } constructs and keep things flat.

Another thing I noticed in the L2 patch was that you added a macro:

#define RTL8365MB_D_L2_MAX_PORT 7

followed by:

@@ -286,17 +428,23 @@ int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
        struct rtl8365mb_l2_uc uc;
        int ret;

+       if (rtl8365mb_l2_is_d(priv) && port > RTL8365MB_D_L2_MAX_PORT)
+               return -EINVAL;
+

Which I wonder, can you even get there if the num_ports is 8? We didn't
need that protection for family C. I think you can drop the macro and
this check.

Kind regards,
Alvin
