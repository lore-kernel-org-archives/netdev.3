Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FCA3F6C2A;
	Mon, 19 Oct 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414925; cv=fail; b=I7we0FhwwMorI6vLQv7N9ecdAX8wFpK3gTd6kZgZv91xSu5b8RdGA8XQpD5ot39PwdJO07ua75fTZvmiq6oQJmWVG5KDhUktdIU3D5ME+xtez99cABeWQ8K1OFmQ9HNJagh/t8ic8ANYKyUNWaJ057DpowA5B7JCU7CwDjcp67w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414925; c=relaxed/simple;
	bh=m2sLGAXdaj/vV/SN4DjMVwON+PwBWNYxJ/2cTmFFWT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bThElgH/pZoH8D5TvC5OeCNxIIb/468c1JKpFa5rCgk2Vu4VM1p+W2AbMR5Ku9RBfesiwfcLts5G+ZMJRw3GuiesjfGYhtisDq6Azd1GVT4zBqOqyziO4mavbjLUj3Q1vNymqb61NLoKH9htQpOaDBjKzxsS/d7o6+Njbv4mi8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=P7HRIlt1; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aUdnHvt8; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="P7HRIlt1";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aUdnHvt8"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JCElbV349846;
	Mon, 19 Oct 2026 09:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Y8Qq8+dFYs1rXmIzSGxE+MnbKRkTj+KJ3EeFz2h9fy0=; b=P7HRIlt
	1jNtzOjfyndSkti2cVTZ5x4nDFvaynkzqBtbVL7hjSQkC0DGzurqME2uHtJ5ZKnk
	ZHBEsmAFhGOWT/va8L7MW01elXTbGcxgOHjtJE3aepcfG7kyteVGpDLVt/9iFauB
	ri35lvIyF51pejGvMoK0RoKFhEuEv/u9EXcptzjihDlA8iBHOsbOC8kARi7z2qtR
	TqrRI67Jx2yIC4zn9wIKdhskWEtcdyeLCsx390oRySqydbWbgzjt17c7fEgu3aT4
	SvGTsx6cdX5toUlfY4VCL034tjUwYdVq8SdRUArYmJhz2pO+AJwl1T+gfLwWqiXO
	P9kzo1RyWQIaZyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y8Qq8
	+dFYs1rXmIzSGxE+MnbKRkTj+KJ3EeFz2h9fy0=; b=aUdnHvt8LESCCfGK8j+Gt
	KWA2INm654pRZsNm0ExKf5B9BvQAYBbppHlYWWTPJksW+gjymT4HV5zXe4RltVv6
	shRBbvDqAnrM9fxDxKUKNMU5XXXTqUCCNJ1q/IwWY3gDw4BwuS22edfCfk+mae+z
	i9cy1mrnw0Q/PDZGNT+N9gsDVVsY1RFgtHsLZ7JVmVIhPcGIGdSqjNon4uq4DpaL
	YzB0DYXy/nhZWMI1siL/V/S0Zl/sqzy52DOMGysZXtWOwxXT5yExePkuiwDXn0dM
	6AmRGKuVe/3EGOx2tLM6RqShEykkfUZDgzuoFeQMAsElTBkif5jGVd1FUIzwKtmK
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hcqbdppy5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 09:01:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTKgdE1Uk8Ms/7MsyHTBdIYuAAGvVAuGdZBl4FW7B02ri/HKu1zC9iSw4CPNCs5Czv7UXEPXPnMmx12J6sudTRG49WWhrw4nssbZo43RDVDEGzCMkiOK3ulT1Riz+E4gU9+++UylZSbRzfYmqX8tFlTOVAl+ihw2/sQD1PDlu3Q1Mb5RLyl11O0Cs0QaMO0VRO6vbRFFQpAaeZRX8Vgb0RTfHpBAY/bxLHQI9xoVAD6M7yHe9AB28uYIi3f5Q1Z4jC+cUCrL04NY47lNLsMV62ZPUM9NTZo0QcARQ9vGT6D/XpOjCWfAHAQ9J1XPlUh6gZxAzExFG14/NBuitihFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8Qq8+dFYs1rXmIzSGxE+MnbKRkTj+KJ3EeFz2h9fy0=;
 b=GQv9ZC1R0FGMW7FgTw9LFClXX8LqtRF7dH1pM38GalIrP9M8IP0Gm1pGqvqfNchMlXTGK6jR7Q9qx5qEunJT7wfCPSJacckTjgKxkqvmG7pQBhd54JO9Hc41Q41szveoHzE+h33NGaqlAg71dYrfkYSTgXrayf6MX5CplMcofhzIWooHYAdHA/P0y3NK2hHS5KoMH2qH2r+M08n7arMXikU+O7gUqLXoZnJgUb56BAxNOGxEw7IAjjEkeUyiR3uY5YMsRqFfWcMlliOsr14IHXM0dtvc2SV45SIreJ5MjiQaGSlgu/5kSZP1C5zTipnJUy0r/5qD3C1h4znqxUmLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by SJ2PR03MB7110.namprd03.prod.outlook.com (2603:10b6:a03:4fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 13:01:02 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:01:02 +0000
Date: Mon, 19 Oct 2026 15:00:59 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: realtek: use <module>-y in Makefile
Message-ID: <atYUg6WwuxF32LJc@analog.com>
References: <20261019-realtek_mkf-v1-1-3246a77d5782@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019-realtek_mkf-v1-1-3246a77d5782@gmail.com>
X-ClientProxiedBy: MM0P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::22) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|SJ2PR03MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: d78755d1-dd3e-4ebd-b99e-08df2de1071d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	goa1VcborDL95kyxx+/1jVQwYtDbRlDp8/a7z/qITvkw7gYILsrAHeMsFHC+tMKFbIb0NI5AE+T9TYaDsJu22vvuGC6U+Nc4NlZoU6x53ruE1dkfFNZPn3/P1dfA3A/0gibF27h1QW1I7SOtEzpHcdwxLKadrA3I4up7hBp9v/xJQKj2RfSnqULiltcww23hOJOoNYrYzJ80WmJw/c5SEY/dKVPyqOoa49yvNuhM988KL4/XbK+W/7hbIlmFIof7Cen/MC29ThxiZfVav7ZCfjpG7Vul6A+n1f3aNQG2ZOBqddmI21s8sSQf09nbwL4ELX3Kcjf9bLDNv09jyx7/biOGENCY/gK/T5Xea5FDJiK34lSYkG3NLVCtShd1bg4/EtNafPwd1vT+V17VussAeYXq3wgzhXdl7FiSU2+zoC47nqEP/4przWBmcVRAQjRVawmycmZBaHLvAOcFJpJMcmaJ4hHw03LIp/DtH+lADtUBVVDzsH33cKT/tozu2d9xMMrPGg5UoDW+CjwwIkYTWunCOq9PfYPWKXQkBfsPYGROBTMVrY0kD4SJS68/YsPmdBuWKxBwFXM8v4nvcB1usJnb4xuKAyO89IF5v4/ii+1aBTo7mn7pH7K0QH9sh70nyYpSXsTpYD6m/TDHJ1MWnIlnckx5WhMGWLk+2I54nEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2p5U0RQNGFLdVpvSXgvcEZBSXdIU3d3QndUM200VlhoL3BUWXJzRGdmZXBs?=
 =?utf-8?B?ZHpTY2szUzQwZUk4VU56T1JlWXJRZnhIN1kycXl4M1FteGpEdlVSZWw5RkRq?=
 =?utf-8?B?RVl5VmhNcGFieVMyUm5EYlM3UFFKMlM5YnlwZ2JnSXhxVGlyT0luUHExeHNm?=
 =?utf-8?B?eWFkbDBjNEJXaVViN1pyVnJmZytOdHF6K0QyYUhZSTRRRlE3cUVBazgyaHpa?=
 =?utf-8?B?REY1Z211Ym51NVM0V3dBaUVacTZ2UUJWNWNkOHliZHYzWDdiYnRIMENoUFhJ?=
 =?utf-8?B?dWc5ejZNYTBLWE9nQ3pHRVI3ZkI4aUl5UFV1NU45SVNTMkZ1RGljaExxYlpJ?=
 =?utf-8?B?YUdDRG9KMmFNbXg2LzZWMVR2RXVvSHZNdXJ0dFNNZUk1ZGtkV3lIa1ZPcnhZ?=
 =?utf-8?B?U3E4ZEUwVnIzMWx1Z0RrRlBLVkpYZ2tKMWtvN3dSbk1TcUk1ckx0cVJIUjVP?=
 =?utf-8?B?ZVRpdzY0VVQyanBwcm1rVzV1TkhTMmVxM0xHSGVqUStlcU52TXR5OGFmYndT?=
 =?utf-8?B?WDdjV2ZDSGFwb3VYTVF2Ny9wQXU2UllHU2lwRzc3MWNNbHJJcW5ZNisxakVQ?=
 =?utf-8?B?cjQvZ1lQR25GaTZtUVZVbWhWSFJGQjBySldnam5Eck1nUTdyMERRYTErbkND?=
 =?utf-8?B?WXVQaThPMUlDMUI2a05nMC9tWWdJOFBsUHdyRy9TbVMwUFk5Y0Ywc2RiT2Fx?=
 =?utf-8?B?bklYVCtrMFJUYWhIR3JtS1NjdHIveFZYc0Z0Zy85dzNKT0JHdUdOOFkwSGE5?=
 =?utf-8?B?eS9MdTRjd0hUZDNJVWF0eEFqRE53VXoxc1ozeFBueGhaeXQxakhSUFliVjdt?=
 =?utf-8?B?Y2RtMmhpRE1uMlU5eVZESmdTdENNV3ArYWhhNk55QnhqTmlYamxIT2RiZlRy?=
 =?utf-8?B?QU82QTA0ZERGTTNFc25jdVY5bDZZM0tKTG1uTEhQS2p4ZENEMzdqMmphVlNm?=
 =?utf-8?B?RWdSV0J2TWJlNzhyNFV4aEMvaS9RS2dQdmhLNk5aclhjRU1DZkhTaE9kajRW?=
 =?utf-8?B?MGpOcjFKM0FYeWZ6bE5memQ5NmhIdnU0U3ZGYXVaTFRVWnRSdDdyeVRvQ2dY?=
 =?utf-8?B?b3lHdGpCLzVoeFRVT3pVMVhwcTY2Z2w4cFppdnlKV3NnUUxtbzhUVmdReWtr?=
 =?utf-8?B?STlNcUowdTJsVGU0cWZvK1RPbHQ1WlpSYmRILzg5ZTA1SGt0dVRJU0E0VjFq?=
 =?utf-8?B?STRxdndHNkRHWC9VVkc4UHZzMTEwMGR3MnNDbHJlL0xTU0JHcUpQVnJ1TTBL?=
 =?utf-8?B?bmZrd3M4M2dSUEtCR3Fnd0p5NGN4VXRFYVZ5c1NJdVNJRGJaSnlmZzlIQ2dP?=
 =?utf-8?B?c3NDV2ZsTjI1UlovOE92STJ6bldqc1h3OWpoVk1ucUNhSk56ei9meGRYMFg2?=
 =?utf-8?B?RjdYK2FhTGk4NEVjOEFXU2dTbVVmZHg3TVpXQUxGQ1NTWGNGQVBLamFTN0dl?=
 =?utf-8?B?d0RGRGV1Mjc2VlhDWXFEVEQyZnJBWGE1TE1yMXRYR3dvL2dOZWRQTlhxV2cx?=
 =?utf-8?B?eGI4WjlPVllDcUZCRUNUbnVtakFyTTRycDhXNDZNVXEwOGxaeTQybDVjU0dt?=
 =?utf-8?B?L2JmT3JsZXIvQTRWbG13Zi9qbmd5aUpYTDRydytRT3pHaGlBYm0wOHZCclc1?=
 =?utf-8?B?ZmJWL2tsb3JVTFhKdHhLMGZYWmtmY0JpMmk3MlNLNyttcFppSVhNTEJ6TGhH?=
 =?utf-8?B?Sml5QVkvWlorL3FkVFFCcFp4b3N3M3NCOU5uc2E4TTd6MGhFa0p4MHd4LzUz?=
 =?utf-8?B?a1hNWnB2aEhwMnZSalJWZ0ZsR0t6Uy9ybXhUWGF5ZzVPd0dHQVJ3WUV3V0Ry?=
 =?utf-8?B?eURLb1EyRTV0YS84dzFya1h3TkNibEwySnBXekdvcnliWHk3TWQxV1JWamtE?=
 =?utf-8?B?blBkclNxSzZLc2hrV2dkVW5zUVp1VUV3STUrUWJIWXBGM0o3VGtTUWNjRlc0?=
 =?utf-8?B?VFFOQVA1V1BmUkxaR1ZzT2tVcWJ2cjY3dHVEYm0wcFNpbU95ZU9VWmRrUmFG?=
 =?utf-8?B?MGxOMms1bVpQdmVvSG8xd3hua1M0azlLdWlUNEcrTGFnU205Q2Y2cFpyNnIz?=
 =?utf-8?B?UWRBMnNtbzJYQTNiclBTVE1TZWV2Sm9icEp1aEFIUmNNSy9CeXlCR0JZVkV4?=
 =?utf-8?B?YmZRR3VkVmpkc0V5NjlIamIvZVZaQk5JcWZpbk9qWlBsSFd0V3NjazBlMHFm?=
 =?utf-8?B?NWpWN1V6dEh5NXFPdjFSalhZYzYvZkYyVFQ4eUozVThZUytlaHRDMmV2Wkxh?=
 =?utf-8?B?MkFnbzl1amRjWEFnaWJzYzdLRHEyU3VWZi9OSzNhTG95Y1FyczNjSHBFaUhE?=
 =?utf-8?B?SlZCbWM3Wm00d3BaNnlpbFR3SW12R09Zc0xHdE5TTUdEd3M1MGM1QT09?=
X-Exchange-RoutingPolicyChecked:
	iMzFgwdUMF4CTfdtrK5W2l+C5WJV+U3ArSZK2U4Il+IuUt6hjHxNBYwVTB/UFewclmfjvmF4jCilKZ2LIiMNY9KgAtiruYrA6h6Q8q19keJ7oFZrJULxedXjyUsyEdMmlElou3pHt6zvtBYAVzmT7qRWnomvcewlpX2hqrXMrhszYpDgtBxGAD5QlEOh+8Jkm/NEOkS3cfJS/iLuv7+xjIdnf70/pyf0nT5s4qspiv1jURfo0v3Y8pN4juzDWxysuOPdayK4AUs8r5YMM/fn02JKJJjcYvQyPAbE4t+7h1I1aqYYODHF1meAm7cUjdr5Xn/5Q5xMsfUFTq7fPnc7Lg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78755d1-dd3e-4ebd-b99e-08df2de1071d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:01:02.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlP6CkyNwsozZOrzEuUDzOMYFV72GfVVOh2xcQByRzagIi7GxfzL2KmHrt6mjAnL0raDGjjzEXuGB7sFJ5dU+muWzpu2OgzXSvTlOUf347A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7110
X-Proofpoint-ORIG-GUID: 8gPYbPlTqpUuO3IAxXVlHGoKdle1jN3a
X-Proofpoint-GUID: 8gPYbPlTqpUuO3IAxXVlHGoKdle1jN3a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MSBTYWx0ZWRfX91A7jzkPoliG
 36Y1xgHZ4qkdE9kQpcUfMGQFQ+07YqXDlc2HspD2lxSaFuJJ4n1nr/aZQsKs04+qbsIW/wCvJPV
 nUAWYYqfdmt4CtwYJzFwHAyPg+gxANmkCtHornhSrXHmUU57JuZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MSBTYWx0ZWRfX93dUqwg62Axs
 COadSaokGXApAiFxBIiztUCa3+0KKePbqnPNgtYb4Lr0veyXPBP7QGTKxU0kZ1o1iIVxfkp2ERo
 Jgoi0XOLvwsv8wToRC6l2b7KB5LJxELBZhUPInWq8YYBYD8GkfrjZrLX+34i8p/fabKlfiY+OOg
 9IYYqpt8OzEg2sEeTVCdlCFi+tti54oI+yYSC2w6PcBh4R8vkw7Jk1EpyLcFpGaVqK7J2iWq6+j
 +WTidrlJK+0BqP8YOi4prq4XP58iIbjwNR6UZDjShz0le/ttTGiK4tBNkafpdPKORfq/We0I4iX
 G8iF+kFkXdz3s5prDAXAO6TvoL7CxcaPJVqSFjVaA+Vm/pwbvqNYO4YkO+oY7FZB7Ayjo+ll5gn
 ACywZWTFHUSvtq3BGbGlMY1JW3v9Qg==
X-Authority-Analysis: v=2.4 cv=M4zYuCws c=1 sm=1 tr=0 ts=6ad61491 cx=c_pps
 a=2LRq3VT+JIpsXvqoN2bfxg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=y0dbC_-9pVKYBnBKI4AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610080000 definitions=main-2610190051

On Mon, Oct 19, 2026 at 01:26:27AM -0300, Luiz Angelo Daros de Luca wrote:
> Switch from <module>-objs to <module>-y to eliminate ifdefs and simplify
> conditional object list construction. Drop the obsolete trailing
> comment.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> ---
>  drivers/net/dsa/realtek/Makefile | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
> index 72bb42e80c95..0a94a619b2c1 100644
> --- a/drivers/net/dsa/realtek/Makefile
> +++ b/drivers/net/dsa/realtek/Makefile
> @@ -1,23 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek_dsa.o
> -realtek_dsa-objs			:= rtl83xx.o
> -
> -ifdef CONFIG_NET_DSA_REALTEK_MDIO
> -realtek_dsa-objs += realtek-mdio.o
> -endif
> -
> -ifdef CONFIG_NET_DSA_REALTEK_SMI
> -realtek_dsa-objs += realtek-smi.o
> -endif
> +realtek_dsa-y				:= rtl83xx.o
> +realtek_dsa-$(CONFIG_NET_DSA_REALTEK_MDIO)	+= realtek-mdio.o
> +realtek_dsa-$(CONFIG_NET_DSA_REALTEK_SMI)	+= realtek-smi.o
>  
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
> -rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
> -ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
> -rtl8366-objs 				+= rtl8366rb-leds.o
> -endif
> +rtl8366-y				:= rtl8366-core.o rtl8366rb.o
> +rtl8366-$(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS) += rtl8366rb-leds.o
> +
>  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
> -rtl8365mb-objs := rtl8365mb_main.o \
> -		  rtl8365mb_table.o \
> -		  rtl8365mb_vlan.o \
> -		  rtl8365mb_l2.o \
> -# end of rtl8365mb-objs
> +rtl8365mb-y				:= rtl8365mb_main.o \
> +					   rtl8365mb_table.o \
> +					   rtl8365mb_vlan.o \
> +					   rtl8365mb_l2.o
> 
> ---
> base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
> change-id: 20261019-realtek_mkf-380d67738b1d
> 
> Best regards,
> --  
> Luiz Angelo Daros de Luca <luizluca@gmail.com>
> 
