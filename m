Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794496152;
	b=MJqPX4//w18jSnKrUuZ+CdbE5AspvkWX6fYZkHnBbPrjtzDVllKBYVMDUJVRTxGY8s7G
	 WDVjUcQnEKbSsXypTJ/xBgsZIVX6GMh9U9oAhHz771rLJ3NMYacCqTMTosB9w1LE7OMXd
	 g/QYX3706UAVR1XFEE1eCIbH6vwwtMvrAUeaoQEFQURrS12mzOGvjXFBpTb0xmAnc78YR
	 vqNloHr/RFk3qdQilmX9ice7BduZMuO73+QfgsskSW3WqlsW9muJoF9gpc4lbat22bkY0
	 8wqe3YmbmHfqdQMEjZeRRVvDw7NxYhzQJkfQKTUobbhOIuQiGuTxtl5jONa9yK3hT4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496152;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/UIaxlR8gRIEubV3kGCUxcjWTNA8ZaQ2m7EviJm3G9U=;
	b=Kky0fcKFoNJyS7HIdiAfOr3ivTIeCgLaFSrFyFQ2Rew1PrIvvMM7EymrcFUlOlDbo3/7
	 Ks9sP66mb3oq05BtI6pq0t7mFyyFCO0sg/VXHr9UqIqu8EyQ/y09Yli+NtwXoxMp7aveE
	 ZmbqsWXZpWimraeAHpL128b/YhEB2csLaHf1HCNkB/FSifEI7Ygq2SVjHXbpCVRD8xlzt
	 GGl57YjJO1ljLTFSnRkRZJGVGpq/tahBWw+FgEHf7/l3aG3PFR3qctcjDNUAYa2hP/JZm
	 ZvzBYLVlBk8IjKA4qwUPc9960jsxMPVbBbWLy1+x1if0kV74n4rCC7MbKHsbBKcbhQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=qbKYMzTU;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ivu3rUJ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E305606A339;
	Thu, 12 Nov 2026 15:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E305606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=qbKYMzTU;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ivu3rUJ5
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACE9occ4128493;
	Thu, 12 Nov 2026 10:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=/UIaxlR8gRIEubV3kGCUxcjWTNA8Z
	aQ2m7EviJm3G9U=; b=qbKYMzTUkCEC3rwhajXyDJ9M+F0ZECWOVjKyTnSvSdlGe
	CT+hts+7ZLOolY1sFOJUPSaBxPScUqXKVOjOMpX78W9rbEGR4LaF3DZN5L4JDh98
	q9eXh4N7GrNulvITaqB1sFVQiEArg+bQBRn18UmqgFAfGe6+OAIG5UgljTD2SFpP
	yPSVQ99gjBXNYtXI/lMNDAdotwlAy8CrDJVX37HlTOCfzw4MVZSkZ0reU8zRSWyR
	pe8chDpMDHdmKZTjBt6tiaivmsh3hRogl5gC59nTArMhegaQlqHfH/WkMTYu+lnX
	Na3ooY0CvcB778ffR2N/Q9Z10QLA9Ro+sfeibWIRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=/UIaxlR8gRIEubV3kGCUxcjWTNA8Z
	aQ2m7EviJm3G9U=; b=ivu3rUJ5Kro/OzZs6Xg7zyoQ0pdfgoT/VjrxypFWHLhul
	kT7BAPHHNjBy0gyNICu1IGWvELdeQvLO4+MSP6EfiR5q2shqb9YJTIBjaSUKSFa6
	WzT6yblALWH83hRwv/IguvVmaedabzSCKfRCSuJNMbZRHdKQoPw6alua/tqdz8lz
	xPINsfgUGISk/C8sEsRpcKhNJJNtAS2vUDmdFil8++JMWrbfljI1/9mIUwYRKVu2
	vEFGgtCJ/OJXNeBdNDGIwywkCe3SIlOcWpFFxGPB87QNYSfc1Y+HXpcrAljIaTky
	yDDtbvXPu8YAEbRPdyLM3d4Z4p2JLNoWEYu5u8pwA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hweyu0bpf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 10:08:54 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3ScXo6qhjcobNN10YxIMp6w0RUiEUOyM50Eo8zYoEeqrQ7p1V28TLnycn67Jubgbb3jsTUotOX6DHZFyY6QNXwXIv96DHruKnutcpumdwtHHAyvE/eIgrdvZGXEJ/Gl2XYB/a+XAz6Gb4l8aBmRKarn9Z3ESdDAweUdZ48FhCR+i36VfTcsnSSYPKHlHAOD/0d2xpIkVTaZuCgPvlsEyBxYTaiTrlWQTBKC7WePgAB8NnbM8V15CN92w3XgsJ4InFfXOzxIugdM2tWXceI1WEtgMoI+hcAzlToqooPdwaTX7GhDKoeS5phN2CCIl6rEKJ9y62P+qO1YLgzsCSGu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UIaxlR8gRIEubV3kGCUxcjWTNA8ZaQ2m7EviJm3G9U=;
 b=pvEeAH13uufKQSidXyMOrbfmlgL9EuuMcqAxnTdlBIWu9TW5oRZs6ow/J3Y2p4mEVEGkap+QhVBSSLJSUDpRMVRY0cpBt5tAVByGvtbuGp9GBV7WfXi7Uyc9rmH2oM0cRBMWdroFhA+SaQJM/Su+ca6qW0kcNXAwWuuK44vzzdG3qyjUag7sXY3+f8R6OZCV8k2GvoGLT6KATd1tRGv6lP2jv5Vd50JhYCe29nMe36r/OLdvATuBH+VxMMpUlPg1XnFZhcngxO30xlL3mE3JRm7bW7PsMIhdm3gKO9MvMohGUw7Yw/XyGxlUa/7BEFQTy8Tmhsj48FbnCtsxrj/R/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by CO1PR03MB7986.namprd03.prod.outlook.com (2603:10b6:303:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 15:08:50 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:08:50 +0000
Date: Thu, 12 Nov 2026 16:08:47 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 05/10] net: dsa: realtek: rtl8365mb: describe
 the ports of each chip
Message-ID: <avXUEaiSnKsO705y@analog.com>
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
 <20261112-rtl8365mb-dcb-ingress-v2-5-f8e6fbdf8c99@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-5-f8e6fbdf8c99@pengutronix.de>
X-ClientProxiedBy: BE1P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::6) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|CO1PR03MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec5eade-9017-494c-516c-08df40cedb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|18002099003|22082099003|6133799003|10067099003|5023799004|11063799006|56012099006|261021123027099003|261028144727099003|261026121527099003|261021121427099003|261009223027099003|261022105027099003|261021135927099003|261026140227099003|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	wIKyQFjGzPMW6fZpce5QvGSJo2j5q52fIem2Zvu4nV2ybtOsvV22DXvFFMaVXaEuV2/Dv7oJ0dEU+NsN4b/s9zQ4447nk+dYm8qGQYpFyk7M5/Qxvov1VXSNhPBv9Ar/z2pMhoYXu/XcpxMmOl8Grg96CQxjrD0HbJbsSsvzVA8b49zGk/V42uV5KTww7lQgnSIMLQ2V4kYj0ZwZgPourJVVjSKrSFZzxt28Td+02aiWyiBg43Fixy43QLa2e7zthTz2r2F3uFYfF4DU4XBOdtBoWzFlz8c9GPKBCuJ1rPcluEE3KMu++UfK6d4a5BPciZb4+AGiMwxEvFif4zZcWd4VA9C5aPa/BwTnPAIS+c7lMBU/MxAqPg0AMLG8Qfk+B3hIEmvJewU417rvXSVrX2m/LyvjDPqy8GdWvFMgSkYIQtcx1EBaIeZQDsvcGil363yIeJj7zJ36xa5maVSfUjmbHH4arYHr0QPIUBESNp9dsr+8fzC4xtzBakMOq6hjoFBhEjM3lxwYUwXVUVPGGTXyLQF+oE36r5N8L9CZTOqOEEh8whZM5xY2Mov9I/EpdNjVMKZyCBQQVoIMo6vc4FCw8SRdKlKC53yNAOmW5uW5/FmcwC+n6Gu6kExPqONdNSsNh0N1ZiGpGtwIKtHx16U/FlTQxSRPSXX8hkfjv0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261009223027099003)(261022105027099003)(261021135927099003)(261026140227099003)(261102123227099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWs5SmtNNk5sdlFGOUFCL1Zxb3dDclFTaURMN3d2RjlVQlBabUtVb24xZTFH?=
 =?utf-8?B?bHRzQmFLS3U1SzhXd3hRQUJnR2w3WXFpNjJBUnJzWE1xeVRaVmJVTzFLYzd0?=
 =?utf-8?B?eDhEVDZseDNpdzk3WHp0L0xWUnBnZ09mSHo4WU1QaE9WSFpJMW03YkNScEZx?=
 =?utf-8?B?d2pJb2VzM3ZGNldWYXc4QWx1WWpEYVhVZE1UbTVVcC9TcFpHTXhsam5IN1N4?=
 =?utf-8?B?cU12a215alNINmhoNU5nNTBDR25Ob3JIUko3R2RLdXVUZ1psb3pFZWUySFZo?=
 =?utf-8?B?OXlXck9nN0Y5cGVhNUxWQzBMa1lkenROckdZUlNwbG8vRGk4R01iNG9MMlp4?=
 =?utf-8?B?VythUk9WUUdkOUtQTnp0akdqb1grVUx1S0NhMFRPd1J3a1AvL3ptRVh5SUpW?=
 =?utf-8?B?YnVVZDUrQzZQMHZlaGh4QjkwWUY5Q0xyV1c3U0Z1UEhlZWlrRDJ2SVp2NlRL?=
 =?utf-8?B?bWJNU2YvTXR3emZxOXNiT0FiaGEwYVdwR2JFNHJhejJla2g4NC9ITGlMNzdH?=
 =?utf-8?B?SFdtd2ROdXFQR05qTkpxc0k1ZUd3Y1FYbGlLOWhrZDR0RFJxTjZtT1BwYmx3?=
 =?utf-8?B?OVZKancxUTlnYWVUTzdrZXFNaWpzQk1Gd29HSmE1MDdhaWlrS0d5WnMyZjdV?=
 =?utf-8?B?V1NsUUgrTmowSFhkU0JVUTVUMnl2Q3M0VnllcDdQOTFDM09EakorMUM3SStz?=
 =?utf-8?B?VU91QUhzMXhURUZQOGJHbWJieUt1eGRWRmEwdnhuVUovbzF3dmdBZkN6N2I2?=
 =?utf-8?B?d3JzN3NBaG5oYXhXS3N5RXo2R28weUhud3pNcDNOQlBNMkl1Zmt1M3hDQ3Z1?=
 =?utf-8?B?aFVEcWJJUjJFblZwbUc4K2d4KzNvL0VXTXdVbjg4ZmFOd2Y2Y3VwaWdyNnJt?=
 =?utf-8?B?YWZqU0xZdUx4Vk02c2ZZMldsSDlqS0FGSjlLaUN3YUJIWWhnYWd1OVFOYkZz?=
 =?utf-8?B?TFpnM3g4bkxhZlBqY2FyMXpveVhDZ3licUNmRXZEQWpSWkFnL2VCSk8vZUhq?=
 =?utf-8?B?bUE5MnJUQVQzcmJiSTYrYmlsOW45U0w4Rmw2Y25JS1lsU2xQMjZRaW82elg5?=
 =?utf-8?B?MnRMcGlIaEo2d2FFdW01TGE3czcrYWxDVDhhNjlxaU5Nem8vcHhqdlJwZW1W?=
 =?utf-8?B?MlBDbUFkWHlLcTR5V09ZNDNaaVdmaEMxbC9rYldxbUpuU202S1M4eU1oenlJ?=
 =?utf-8?B?d0dPenRCTnRrcDl5dzkzMWRhRUU5RmhnTko0ODZwdy9VSzVCTTJTTU5NeWVs?=
 =?utf-8?B?T2dtKzZNNU9rU0VDSFp4QjdVWWJhL2x6c2ZiNEgwUjlPT1QyM0U3NHhGYlls?=
 =?utf-8?B?c2lTQjNmd2dvUDJxcnBTWlVGcmh0KzNkVHpKUEZ4VWg4MHFRRjRNMmNwL2tP?=
 =?utf-8?B?TUtZTmlDTkJqaGtwQ0tZenBQdEZ3dEdtQk9Gd3YzdjFUQlRIdGdUSDNvMFBa?=
 =?utf-8?B?cXZPNFJTNDh4RnRUQll3bDhYRTBEc04xaFNFVDhqN09kdTYyZTI0SE1VMzBM?=
 =?utf-8?B?alZRQ1ZSM2RENUVleWFQeEE0L0NBQnR6cTFrYzdjb1NOaERqUS9FamoxMC9i?=
 =?utf-8?B?WG1reWQwM2thSGVFU25UNHNFY2F2MHN5TkZpTkNQQ3hVRGdPZXBVWEk1MmVO?=
 =?utf-8?B?Tm1WOTNBc0FiM29mQkN4MGJnT1Y2V1lySlhBcTFxOEhyTTJkRXRTOG9ORTgw?=
 =?utf-8?B?cnNuVStmT3BjTkd0dDVQUzRwUS9LQy91YmtBNHVtY2UrM1lpalVEM1N0bUtB?=
 =?utf-8?B?NnRobVM4blEwRzZIRkVheG50TityZWRBZDVDYmVsbmhGWW5hdkxOWEpCeFd1?=
 =?utf-8?B?ek1VUFU0bnpSb1h6dlFQV0V5bDZYWWJlckd3cWtKMEZkVUg2aU9DVEV4RmMw?=
 =?utf-8?B?T2JxcVJsL2hXdjlKSUlKYW5WRjkzeTYzVjk3VmtmamZ2aUFMK05rVUU2UHA5?=
 =?utf-8?B?aFI1STFUOTV2d2hlSEZVTmpwU01NZHdKMnlGVWFTUDgrbFJMcXFQa3h5TXhs?=
 =?utf-8?B?SEQ5bk1zYSswQnp2QlRNZncraW1nZVVnOEpBanpQczJiMGY1YzhxZUtwakdT?=
 =?utf-8?B?cU1BYzJvUDRaZ3AyckVWK2NCd2FzZHl1N1owUTNjSTNxazV3WXpSSUFhVHdl?=
 =?utf-8?B?NHp1RkVNTUx2NjZKSUVOd3FETDE1cVdNUDBaNng1TWlvUTNQV1ZPelRVZFRU?=
 =?utf-8?B?RXkvNklHZXpXWFF6ZGlRVG5HMFhVSCtNOW9VeStMeENDMkcwS2g2cDhGampa?=
 =?utf-8?B?SjJmZ0d5bmJQN2V0eEIwaE1JMldtbTdFRVZWUzFsbEUxTVFocUw0V3hWNzVL?=
 =?utf-8?B?Y1VFaE5BblJqM3BJeVk4bWhGbm1HbTBQRFlxMmZVeWs3RkZFVEM4UT09?=
X-Exchange-RoutingPolicyChecked:
	Ob4oGAaYTAmOgeEi/s+u/cE9X+ALv3z5QfG2uLDFoOX9MvicXwFmvg8w6FTAzUGZmkPSLDIZ2j41uacB5mR9oo2do14ata3iKxlkTw8V0oHCXY4m+UlubJ/ZQfOxkyTKvgDq/ExyqFHPnfyh2l1sSkhB8Fp4pyVRcQkz6OeTh6qW462DZTvMo4YSBnLUwW0Q1H5BRyqknuy/HppQAJ6ad5JRV3iSg55pj8ApGZBo8oT3IjgX7oogcSJSuJD0OnXedu+GK3zUqqm0Sme4JUKMg9H9NBOmEWKnZv4Ym9l9y5SHK9o6vXC+n5G+09A2DcImngtrYIASknU15mswsrNNzQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec5eade-9017-494c-516c-08df40cedb96
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:08:50.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0pn2/9jcQCpoLj84CxNfLu3vkFIdObPTBKcpDdnTY8sAOF/MbaMa04mZjeb1nfhK1B+d1gKsIf9bXKUd0XwgXLZ4vVUa6Aoxd9u0Qj/tko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7986
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MCBTYWx0ZWRfXyuFWFNrkv7Zs
 pz2Uv+oBjYr/7CLxsmYdH08wMq54tn8R7Lqf7mihclDNFocyiKWRpS7CmZZhyfFiJnRQ+TvodPT
 nX6Vy5LyFK1QSB8YHkMH04GPvn9risxyY+Pgo0K2H+9VlbOuJCN/
X-Proofpoint-ORIG-GUID: zNAoZbJ2kgEOfSGitIvz0iO9xFfGrGOz
X-Authority-Analysis: v=2.4 cv=CN6/zhrD c=1 sm=1 tr=0 ts=6af5d686 cx=c_pps
 a=IzBZuH+2DL2Wyeknq0uBXA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=4F06shiMCxpNLlw34f0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zNAoZbJ2kgEOfSGitIvz0iO9xFfGrGOz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MCBTYWx0ZWRfX0ofEpIS/OM0W
 /w8QWRxyWVXpHnelbARBKwytKjQmKn5Qa4b0oFCQrZnj4tphD1LNmbf9HyiCZlRss+RZmntKgvJ
 8Fur548IHQPQnzOt3Y6AycadfBFU4o68oAduiDMaK8MJT5eyRtLaMSmziNomjS5YnWMG/PXA4lt
 YA9l72Cpx506sUvxjnmim9w2U7hcV4PRM2zdLKI67Jq0JhhaQkCvLxpbWW1BPoXBCW+phCoAo82
 gfPdSoGax163skfXwHU9QL1ItwQDmTYiTf2q+VGQmBsuViGtWjwH3VAI7kkssBEIWG82hIN2IE3
 36UyV+EhNp3ZoRy+Ywv/+mfOZjWeYoV2ZQb4iubvBd3ZdD71aBievr483BR9aglfQNI08J+9VU2
 FmMVmN82B61SfYz5q5lltsufp9yHxodzAhLJhIFyD5SAGIjRh44EWAyGpRx8Xxt2jCo6MdfThcX
 cXoG+0mwWGnuCsRy/vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120060

On Thu, Nov 12, 2026 at 09:37:48AM +0100, Oleksij Rempel wrote:
> Record which ports each chip has, report one more than its highest
> port to DSA as the port count, and reject a devicetree port the chip
> does not have. Lower the family maximum to 8 to match.
> 
> Commit ca5ecd4246d4 ("net: dsa: realtek: rtl8365mb: correct the max
> number of ports") raised the port count of all chips to 11, but no
> supported chip has a port above 7.
> 
> Since commit 51a4a22301b0 ("net: dsa: realtek: rtl8365mb: use dsa
> helpers for port iteration"), setup also programs unused ports, so
> every probe writes per-port registers of ports 8..10. Their learn-limit
> writes go to 0x0A28..0x0A2A, above the learn-limit registers of ports
> 0..7. We have not seen a visible effect from these writes.

I'm not quite sure what the point of the patch is (sorry, maybe it's
clear later in the series, but I didn't get that far yet). Was the setup
of nonexistent ports clobbering some other registers?

Of course in practice none of the supported chips are >8 so there's
nothing technically wrong with this patch, but just wondering.

Also in the blamed commit there was:

-/* RTL8370MB and RTL8310SR, possibly suportable by this driver, have 10 ports */
-#define RTL8365MB_MAX_NUM_PORTS                10
+#define RTL8365MB_MAX_NUM_PORTS                11

So maybe it needs bumping in the future if support is added for those
chips. That's why I'm wondering if you saw something off?

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> Changes in v2:
> - New in v2. The QoS patches after it handle ports 0..7 only.
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index da06f952a053d1497647a2c6f15a861fc21860f9..1e6cdc61f6bd3b3f74e422dbbcfdcb67cc0532a7 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -115,7 +115,7 @@
>  #define RTL8365MB_PHYADDRMAX		7
>  #define RTL8365MB_NUM_PHYREGS		32
>  #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
> -#define RTL8365MB_MAX_NUM_PORTS		11
> +#define RTL8365MB_MAX_NUM_PORTS		8
>  /* Valid for the whole family except RTL8370B, which has 4160 entries.
>   * RTL8370B is mentioned in vendor code but it might not even belong
>   * to the same RTL8367C family.
> @@ -707,6 +707,7 @@ struct rtl8365mb_extint {
>   * @name: human-readable chip name
>   * @chip_id: chip identifier
>   * @chip_ver: chip silicon revision
> + * @port_mask: ports the chip has
>   * @extints: available external interfaces
>   * @jam_table: chip-specific initialization jam table
>   * @jam_size: size of the chip's jam table
> @@ -719,6 +720,7 @@ struct rtl8365mb_chip_info {
>  	const char *name;
>  	u32 chip_id;
>  	u32 chip_ver;
> +	u32 port_mask;
>  	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
>  	const struct rtl8365mb_jam_tbl_entry *jam_table;
>  	size_t jam_size;
> @@ -726,11 +728,20 @@ struct rtl8365mb_chip_info {
>  
>  /* Chip info for each supported switch in the family */
>  #define PHY_INTF(_mode) (RTL8365MB_PHY_INTERFACE_MODE_ ## _mode)
> +#define PORT_MASK(_m) \
> +	((_m) + \
> +	 BUILD_BUG_ON_ZERO((_m) & ~GENMASK(RTL8365MB_MAX_NUM_PORTS - 1, 0)))
> +
> +/* Copper ports are 0..3 on the RTL8365MB-VC and 0..4 on the others. Extension
> + * interfaces are port 6 on the VC and ports 6 and 7 on the others, as the
> + * extints rows show.
> + */
>  static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  	{
>  		.name = "RTL8365MB-VC",
>  		.chip_id = 0x6367,
>  		.chip_ver = 0x0040,
> +		.port_mask = PORT_MASK(GENMASK(3, 0) | BIT(6)),
>  		.extints = {
>  			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
>  				PHY_INTF(RMII) | PHY_INTF(RGMII) },
> @@ -742,6 +753,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.name = "RTL8367S",
>  		.chip_id = 0x6367,
>  		.chip_ver = 0x00A0,
> +		.port_mask = PORT_MASK(GENMASK(4, 0) | BIT(6) | BIT(7)),
>  		.extints = {
>  			{ 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
>  			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
> @@ -754,6 +766,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.name = "RTL8367SB",
>  		.chip_id = 0x6367,
>  		.chip_ver = 0x0010,
> +		.port_mask = PORT_MASK(GENMASK(4, 0) | BIT(6) | BIT(7)),
>  		.extints = {
>  			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
>  				PHY_INTF(RMII) | PHY_INTF(RGMII) |
> @@ -768,6 +781,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.name = "RTL8367RB-VB",
>  		.chip_id = 0x6367,
>  		.chip_ver = 0x0020,
> +		.port_mask = PORT_MASK(GENMASK(4, 0) | BIT(6) | BIT(7)),
>  		.extints = {
>  			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
>  				PHY_INTF(RMII) | PHY_INTF(RGMII) },
> @@ -3140,6 +3154,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  		dev_info(priv->dev, "no interrupt support\n");
>  
>  	dsa_switch_for_each_port(dp, ds) {
> +		if (dsa_port_is_unused(dp))
> +			continue;

You can use dsa_switch_for_each_available_port() here.

> +
> +		if (!(mb->chip_info->port_mask & BIT(dp->index))) {
> +			dev_err(priv->dev, "port %d does not exist on %s\n",
> +				dp->index, mb->chip_info->name);
> +			ret = -EINVAL;
> +			goto out_teardown_irq;
> +		}
> +
>  		/* Cascading (DSA links) is not supported yet.
>  		 * Historically, the driver has always been broken
>  		 * without a dedicated CPU port because CPU tagging
> @@ -3349,7 +3373,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
>  
>  	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
>  
> -	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
> +	priv->num_ports = fls(mb->chip_info->port_mask);
>  	mb->priv = priv;
>  	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
>  	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;
> 
> -- 
> 2.47.3
> 
