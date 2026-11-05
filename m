Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793868802;
	b=N3jJlfM8NWHF5g8vPXCHSGXJ35sB51kOdANovlJEZsbmiHVO2stWU5uGi3yKXsVtct2/
	 VQO4lAUJunmhtUk5xcWrrDf9zkSqsP1dWLFNSoHbJ4j1rGz0/mknJFNEYdg7AY52IKUTN
	 zzQu9unvrLqPciQ+G0PQBiLAVko2DynAHI/o9jrQveOAxtu1wETsMWEaaGuiNNd1Z25D/
	 dn+X2+wZ28O0y7myEdbUnuR+q5S4XlIviWYO+P++LgrGZGvYLOBiHgrTASlLU+Sh5M9GO
	 NfzHoQdrO9s+tTESQ6ErJz2mPCfrwPu6LoJhifHt7wA/Geggcp8L+xVUSB8fgDuP9Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868802;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Gh4LuFGTBrGYakrv6foe2+V2ctR+B0v+7t7YY68rqv8=;
	b=y4cUc8jpOZbN+KpH9jWoo361mHehoKZQYZjkz8dfHQ3OPeztjZd7KzR0t6AyCetMp9uo
	 9RteU+6BVr+mqiXqBPx2TaiEUYdL2KbCwD2HpkxOMFczJmkNp7qMDwVUaqeTB+5MRzWP1
	 8AzrJ92C7dRIb1gsxWihOyp7KLv7UkyPjNcE+txpt9hulZC+ct5rFBn0C4zTEc9zwLRzU
	 f8wNVIH9SN34gqyZHLzhu5lv5PXhFHzdHVfyYTJyE091RPeMugOIiToraRwGl4ZfKmCTJ
	 MosFhXk7Bq+z6FH0z3zhk/+pPmkcYxJcwZyCbyMG+fV9EL2I+KhH/cO49XVqIZzP2tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=AmfkXfhq;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ahDrSNft;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEAC606A331;
	Thu,  5 Nov 2026 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EEAC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=AmfkXfhq;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ahDrSNft
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56WWKM1458480;
	Thu, 5 Nov 2026 03:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Gh4LuFGTBrGYakrv6foe2+V2ctR+B0v+7t7YY68rqv8=; b=AmfkXfh
	qrECTuRPW7sh+iMnOLdmZRAjb/OVJb1Ojf6BqPowI0E09hO1B1oNJaGxVZvPVPEc
	6fbQuBkhWX6V27Rw3M4dgY2RTVcMOEl5valZPVTQlaC1otqySj8xZ0UcX+v8bQd/
	Hd4p45PM2rDXbXTBnsa1E1sY0yowJH4vXx3VbcANNz/CBhAq9gqMmC4uS51o9+IF
	aY8DWGRtS3SPFKoKCirvveLilu4NfHFnggYSx72m371J1TFEp67LGy2IOHWkx5Ds
	0OIRPelkah6X6A45wWdfupYMWK/TOg6KdLCplt7twyozj6xniQe1eANo01W7AFmP
	EjlJoRk006AEmxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Gh4Lu
	FGTBrGYakrv6foe2+V2ctR+B0v+7t7YY68rqv8=; b=ahDrSNftAFxpJD8ZbyvI6
	Wtxwpo81knCyIGtWxOaD0lJP6lwCDtnbcxWpHWu3o1LlcPQ/2kZb75E+D9I4yWK6
	5NtGiIuq+dSPXO+FnSQiKHrVZcJDukhH3dZAWy4ywst0U7t0MUYeVfTqPqIwqxu8
	KOjHKOkW7ny+ZUsNV+sGht8uWwTzjd8C6gWjgdnnEjALua7OEHGrSC3pdX93LLXm
	yG6h55OqjMcclpJXvYKPtAiqbdvX3MHVHynRs7u/8fVJz5+p52xMuH7dPdMYz9EI
	0tTmdr4iTeUoLVs62ZKCQxDS5bFJkIydC68NjrEyIdKMHXbAtmNmMQwl+QLmjQNS
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hr873cx2w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 03:53:00 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6jDdQKE1z1K2MTUtBgG9PXrwklaO5IOvF3S3YqinNHmaXW8Mpb09br5k6FkFrgU9/BYiJE0KtuB40dzk6Od23ZZ3nFosSDoo3KVuePfddZTN9Gyvq9XPvnQnZO70OcpXjAWKi/+ykppnzgbg/VUSphkHjnk5yg8LpHdLXPthrWbi4tovfT6CrHqSd9Jtjzw2HSc07v10ntYoPT4MzYGobEuCBb3b25VSHNu78uUFpLz/YuXRBIqZN6o0aT3NDUPVecWxgxTvDsdTVTwDBbmtifGMFtsPMGeAXIMOtSymGqec+b8SrkTTSqFIy92dFieyJz+XN9+H4XxAZQMuhNrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh4LuFGTBrGYakrv6foe2+V2ctR+B0v+7t7YY68rqv8=;
 b=CYiUwJLQEXQH1aFlVNaCYqZlVLqohqD/bzKuIGF6M0jH50HNddCEBXje2G8m2v6dH5fXS0UzuFNiFHo2gdmkfVTf9rnoehudnPuQXNECxvDu3MCjuPJJlMkDbQUNj+dvsKHBVjpG/0mZy6vACBhOwkPFKqi5/ZbwxSImNU4+Jose/2vv++iXolVYB9cYQm7zpxsvlKdJ6wozSy8TjMtKNTY7Nut8/rWZ1vv7Pspgq9vo0iMmHQEXAWm3+OsTRBYYB/Dyd1Pj/UO9E87Ljh1GGFK/PxrYazNcDTtAVNa/B8U0TcUB8Sm3KD5+DPfpCguDBOinkPxMk1fF70Fbg8ATfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by LV0PR03MB989320.namprd03.prod.outlook.com (2603:10b6:408:395::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 08:52:57 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 08:52:57 +0000
Date: Thu, 5 Nov 2026 09:52:53 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
Message-ID: <auxDYMASk8J0SZRW@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
 <ausrVrtHQHvac9bV@analog.com>
 <e3036c42-8c31-49e2-8ab5-cbc5b8771e51@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3036c42-8c31-49e2-8ab5-cbc5b8771e51@yahoo.com>
X-ClientProxiedBy: AM8P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::26) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|LV0PR03MB989320:EE_
X-MS-Office365-Filtering-Correlation-Id: bf69a97a-29db-455c-9d13-08df3b1a300c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|4143699003|56012099006|261022075727099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4JvJi4ufTNoHUtvlwYou/1H5c1zlA3cNMQWuMVT9OghQWk9m6hCNEbFp+uaMrIpLwDXofUvqEzHX5VQgYQqk9JeJt+hB5lbZl78ZMEFROtyuftus2tXFpdZl1R0IZqx55+vnsgkWHi2tN2zATA2LiQ1uYSbEad4F/0sN4OInmG/W7yWvdoROuLpeIHlhsPdHzjbKv1SUIPfNNeG+HidCKmjxRMXl6iOsVr8Q4JJzG5foVTKsB5avDyjbURJQalTm4AjTqL37pYmiGb3oBPqcxJBxpuNLDxFbwfK4czkdS77acDGdbF4te2hKNddQY4G6C8667t+oH5LIgmrrAZEVRzv0xI8ed89F3Vkyz8LQZ+4hGIgJ7jupjlXWQxV0WPfSzxrt/qhvhF7hvgrPnDa7k9IjzFdzY5N+bKQ3Kzy5No9Dnrpohevpt1EiGMElRbVWlcnQB2NC3Q7yQn+HBZRIzsqShGZe2LqUVo8iFDH0Y/6OwSRMbnVPKOtIWrWdxHXhXPL1hqmT3C5noKPd9lUTTzW9Z95OwgGzj8OHu0AS1ECL2ssQd2QvKEM8IYLy6CDHzIvbq+9Pg5KUO++Y2OQl9WM+h+Ji0xMUc6WMw7VG8JqwYEKv3DWDJKw2PNd/JCua
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE5YYzdvVHh6M0dFY3o0bkFMQjRwYmk1bWNFK0h5bFZzbEIwa3oxcjE5VTUr?=
 =?utf-8?B?Q2JhZ00va0QyWjgrSysxK0ttdlpCRUFHYzh5YVhyWUlQQ1FXR001cWxZTDVY?=
 =?utf-8?B?S0ZhZGM3dzEwMi9WeVBEajU0bnNER2kvcHI1R2ExYS84d3RSYkk4Ukc3OERV?=
 =?utf-8?B?ZndqWUV0Rk5PeEhIeCtJRWdqTmNNckxWaTduUHNuUDZ5eE40eEk3K0RMQTVQ?=
 =?utf-8?B?ZHhPTHRET1l5b0x1bEtXUWFuUVBSOTZPcDlvNUl1SU03a3NJS1NSa3pSakxO?=
 =?utf-8?B?VmJyblRhSFlOcmdaRGVYQVJaTUhqdGZXdGNQRkV2ZmRjcU1PbUx1Y0Jmckxs?=
 =?utf-8?B?dStGekJLaXpwc2xzWlFhN1pIRGRzVVlkK0lnYzlZSktzT0djdkhVRHFJdEhl?=
 =?utf-8?B?a3k4RWRtdERWckN1YjRUM3FoWFdKakJ1RDhWRS9vTjAyeU53QWR5Z0tESG9L?=
 =?utf-8?B?UWJTSXNXcE5zWm5rMjhWSDZWQmRpRkVrcFRsLzJvUkpkL2pCWWkzK1JTQkJK?=
 =?utf-8?B?ZVp3Nllta2RSZ3pMM2lVNGJ6WlBWS08rOHFMRmI0UEdaR1ZudTVSZXUyVnI0?=
 =?utf-8?B?Q2NHMEZ3VWFJY2V2ZW9GaFpXaDBSdWswTTZQcUtnUkZFMFNZYzVRaFJ3Wmgr?=
 =?utf-8?B?dElRL2dMaWpuaDRPaTREai9wSW16ZVh5QW4rVmpDYTBvYkd6d1ZLTkdCMkdP?=
 =?utf-8?B?NkkvTXdiOHlCY0pUblliNkhDQ2JMWnoyVU1MTWlFZnoraVg5ZksyVE5HazIv?=
 =?utf-8?B?V0F2R2ZCNE5pQk1ZSjNSZWZtekEvUmpTMWt5T1Y1a0FCSEZxazVDaW1SWDhW?=
 =?utf-8?B?ZWJBOU4yOVFKZjlSWjlYYnhVYTg3WGhBR2RaOTBUU2haM01EN0IyT3o5V2JE?=
 =?utf-8?B?cm5Rcjlzc3N5Y2JKMUtpUHc4WHIwNEtZM1VRbkRNTVgyWUliYktMZHZOcllr?=
 =?utf-8?B?NG9SY08wc0RwS2cxN2NoVGdCdVNBYTdiVXhiM2s4SHQvazBod3VOKzNac29Q?=
 =?utf-8?B?ZGpBQk9OQTZXelZ3YkR3QVRYWXdOK01MS1lGTE9DK3BsTkd0MlJuYitUdGI0?=
 =?utf-8?B?OWU4NGZCWHJlK0hBMkFvSXA0Z0RGR3poMmxFTUUzejJFdndRNXlLMnBSTmlj?=
 =?utf-8?B?bTFqcXk5bnJFQXliVms2ZnFSRE5aUjVRdEIwbWExQ25Va3NhUnViQ0RjYWQr?=
 =?utf-8?B?L0pZeGRvZHN6cXJud2xaUlBtaXBOSUducTRWNXJJR0FzVk8xSHBxN2VDSklJ?=
 =?utf-8?B?akowWUdxYWNxUkQ5VHJyZGNRN0lwazNGbzdkYnc2c3BmMEdnby91elNTeWtw?=
 =?utf-8?B?cXBxVnRxWUQyVXRkSi84U2VSQ1FoSFVjNDhDdVJGTXhNSzd0cDlwK2NiRUlP?=
 =?utf-8?B?Wk1ENjJHVldXdTREVCt6Qkc0cVk0R1ZtbTlHUTdsOGNLdG9XUEtJVnpGSVlY?=
 =?utf-8?B?Zk9ZWk5iOExpemwyampsM0RMazdpbkNuSU1FdE0zd1NJZVh6V1FOSi9uRTNR?=
 =?utf-8?B?cHdNRUowb3dDMTVKRWgvalBudlJReXRHOURsNTVGeTlCRkVJQS9aRGlMNnJq?=
 =?utf-8?B?eVJIOWdZMTA1ZFZiS0NZV2pBWDAvWDVWYnVGM1FqbGtPc0d5cjRSK296TVMv?=
 =?utf-8?B?NzEveldoRjREckdmdDZCRlRTU2wxZEt3Wm5VMExyNUtXWUpTL3k3MjUyOTZG?=
 =?utf-8?B?U2xTRk1hMzBaUllRTVRKcllSSmI3d1hROFBTbC8zT3NVNVpwc1ovaFNQMXkw?=
 =?utf-8?B?Vjd3VzFscThHNGpVS1oyeDliUitjTjUzQk9ueGZLanlXVG90U1p2R1JERFVS?=
 =?utf-8?B?STdVSWVjdVAyK1FkZEZLZHlyNUlwV2xsT0RVUXBGbWZPUVVnOXZIWkZsUmcw?=
 =?utf-8?B?cmlkQktRTFMrUXhRZmRxMDBoR3VwVDhuNTVENGdPc1IxT0M5UllZMGlkNG8r?=
 =?utf-8?B?NkhpUUpYQ2JKSGZ5bHpxZ3hPS1E4azlHOVpxUVFkY24vNzVyRlJKNUZYV00z?=
 =?utf-8?B?azRoSFhoUy9adkpjZGYxTU85YURIZ3FqNTNueVg2QWpoOU1yTFEyV3dHMWFt?=
 =?utf-8?B?LzRGOURCeXc2Zjk1bEttd1ZUc0dFUThGWXBwR0VYZC9UblB4OWVMbFhmNUg0?=
 =?utf-8?B?c2ZvYVBxUTBNcUE5enVvRFZSamtwcS80VFBjQm5tTWNpcU5mbXd5SzJDMmpO?=
 =?utf-8?B?OTlHUWVMNzh6VHJkd0s4dGxrYXhVdlBZRlBJSFh1SVdINTExN21IRm93aWlZ?=
 =?utf-8?B?KzBOTTZxeG1UMlY2dDNheUN5eVdjU00zV3oybWtTOVI1d3h3UXBOdG9iOUMx?=
 =?utf-8?B?VE1NZDJkYlNIZ29Zb2hVSS9TSndpMGVBNnJXWHg5Ym9YQU5Qa1N6UT09?=
X-Exchange-RoutingPolicyChecked:
	xT2iSTpH3QvAxXX4Njyh2CHNTYCvP5nEypBPxThf006xqsMAUraQoAwO7uoxCDYiDG/zktOLlxFrA41Cpy7xuqdjCyKdy+UKxxM8IYGcW2wLzomt6GvIySIAy5mqTdqvLdFop83/4QmVk/7f0VBX1RNXAWtaUBYKywHgxfrCrthPDYp3VUuopWwVUfoLzVnxlEuFFE910Zvylx0AqSu1Fv3pOhHBfB3JHs4X9Agl61LQyG8OS1YxLbH/SsKYnuz+LeufmhK2o7V5k13bqXqsSYGRBklL+CLPEFEgeXZnHmUNXHq+lT5BalnBT1jvy7ja9ymy/ZlKiDmMCSdMf1jrGg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf69a97a-29db-455c-9d13-08df3b1a300c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 08:52:57.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spsaI2s36+cbBXJ0bIEJO/Ft2ztOdeUYsfvCP3NgrZmSPDBa5je7Q3nugKn32To0wCXXQqRND6iVrKWulsp4zCm8b+e/V7Uk4jzGQPf7zT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR03MB989320
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX27QvxtC0XaPk
 dLUegZvdTuThAnfHyTkh/Hw86mz8yU/vzJBKUWn6zzNr+Tm2Vnif1YWibsgWt9b4RC030BaSdBW
 NC3Mg/nxRSc+2+nfn/zrlY41W/OOzEmWc0+ijKyGb2aHHukg1HUJ
X-Proofpoint-GUID: GRfwp-a8h8AFn7L4OeWXKzXWbb1_jgp0
X-Authority-Analysis: v=2.4 cv=S4tMU4sP c=1 sm=1 tr=0 ts=6aec43ec cx=c_pps
 a=PQms4psfS+nBHIg3Mxsk7g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=VwQbUJbxAAAA:8 a=tuS4EXqFmasBpeHMobwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GRfwp-a8h8AFn7L4OeWXKzXWbb1_jgp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX15enxNAbts+G
 D7kVHv3qjn6ytwkudsOb4D4EkvLlMiS9DNu4bgFgcsztotYVShbYjPBGwjhotW+YK72ygCDOiVf
 ITSFklf5NJXIIKsb9gfTzayYAnonPkjwpFQh+I67Bhdkhwop+khp2BjdFGl20/8xHfkwKSw+Szz
 6Ou1NIEb/nnZuupInfgCasfTuxx0TEOWB24wd78K/fcB7SbBLZYhdXYn8bmUreqzcPOvYt5Wqs9
 jqXHeBIrwpMqW6tkAD5QscIF1qpLmnGuWXq0Ho03U4WWtOClwU7sMJet0pk1RAkArq2s1tFYacJ
 vgNqx2scIXE2lRAhbRVFk/xrXr+VLYCuSFA0hi8Fe2n7fuHBh4nrxMRv5MST8z8/5KA52CE4YWE
 qlNQhxr8gfiAtVcsHXNwZCQbgfFZGygeqCjrbIuxg5G0uaiUsEjPOiGma2c2eenKTBg9f46QYVy
 VKi8HVlkv3U/Lxum00w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050035

On Thu, Nov 05, 2026 at 08:18:49AM +0100, Mieczyslaw Nalewaj wrote:
> Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb:
> re-latch the family D SerDes
> 
> On Wed, Nov 04, 2026 at 01:57:24PM +0100, Alvin Šipraga wrote:
> > On Mon, Nov 02, 2026 at 03:43:45PM +0100, Mieczyslaw Nalewaj wrote:
> > > +    struct rtl8365mb *mb = priv->chip_data;
> > >      int ret;
> > >
> > > +    mutex_lock(&mb->sds_lock);
> >
> > OK, I don't think I can give a particularly good review of this patch
> > since I didn't follow the previous work for SerDes support... But at
> > least, can you use guard(mutex)() here? ;-) And elsewhere it might
> > apply.
> 
> Sure, done. rtl8365mb_sds_write() and rtl8365mb_sds_read() now take
> sds_lock with guard(mutex)(&mb->sds_lock), so the goto out_unlock paths
> and the explicit mutex_unlock() are gone and every error path is a plain
> return.

I've spent too much time out of netdev recently:

https://lore.kernel.org/all/5ef1e25b-2d6d-4cb1-8030-756d60c37c47@lunn.ch/

Andrew here gives some input on netdev maintainters' view of guard().

So perhaps you can ignore my comment to this patch after all.

> 
> > > +    mutex_lock(&mb->sds_lock);
> >
> > Like here, etc.
> 
> These two are the only users of sds_lock. The other locking in the patch
> (sds_cfg_lock in pcs_config(), pcs_disable(), conduit_state_change() and
> teardown()) already uses guard(mutex)().
> 
> As you suggested, I will not post v9 yet and will wait until we have
> settled the remaining points in this thread.
> 
> Best regards,
> Mieczyslaw
