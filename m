Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793801577;
	b=0bDSU9yFhJe7dry48qXPKR16slixcatxjYoAUloqr4vptZ/4rtPAmksbOznOvMaQezDP
	 3WI52pCzP/7eBUoucwQ98TKRGIlQTSRZ25qLEecu5O2KMgMaYzsCZ12VFrsjruqtZJxuN
	 GvhQsvdAsa3vJdtapiWmWFgjt7QaGJ+kHrtrnIQ5JbfNMDgjvpk2POFBxLODkUt/nb7CR
	 rZUJmoZF0C5wKtBOQDx778OiwxHaxR3TnbYrTtWDOW8wbxVzNfGMDFRKKqybdiZyR12L9
	 gCGVSAqFJYnLWpTyf8TCt/T/0dfONYi+dXv60VoPBxF2N3TTQvTTzBSWyNwb2DEd0bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801577;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vPKphMntFlRbCoJiNva+NPTVzD04hwQp6nw8rRPM9P0=;
	b=pgcmkxLAE8VQfYvtpWzlarDg7WSaVrnr16bzfqApJm40qEot1wfOh7dPNRZz51d6aiop
	 eEqF1jJooLnPOlQGYcd7TmZm45028IR0bHRr9s2l+y0d05tLl6UpnoIWstiMoZD/PK8XE
	 1oE30GSEicq3rnh3c3zN4Y7NPffV7Z1bQCXprG+TSKSnnONm5+yp46fByJ7NQG6y9be07
	 VbjJaQSgpmUEYQnhabl84gMKlJepjmjfv24boBOTmwT5Li4STpg7F+AqjHHXNIwBU32To
	 k6nNXV02ZS7kkSY8yaG6Sdk/URcYEYykgpzSXm5yWhNNJE4QBoHCXB9BAk9sZCEcveQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=K+j2VoZI;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k06FRZwc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7F606D80A;
	Wed,  4 Nov 2026 14:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD7F606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=K+j2VoZI;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k06FRZwc
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4E2fbX1243214;
	Wed, 4 Nov 2026 09:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=vPKphMntFlRbCoJiNva+NPTVzD04h
	wQp6nw8rRPM9P0=; b=K+j2VoZIfOAWKzHnoBaJWM3wgAQbAFdSoIAQVsBg1yxGm
	841hdjJCshNG7M3sX9T4NkbzYAJNymRJD3B7AoPHFZCOo0DaRqEXMLLU7yn/nyxv
	/4gznUNRZ4Rl8wdrBgxuy1cjqus9NcGQ9aQi1OyO/0lC0rNfa9L9fJrO7Izm6TFN
	P0ErVP3+AdMyMnM6gvBQNv+p7LPOx14YY4K6HgGkux8L4zINHmDWKdmW8d/CGOJ4
	0LJZGGBvqlrf+AEHpygBDh9fBdO8xSVTl8xKZDfGs01TY1KBcV4vZwcnsiQw3BiZ
	8eNihh82NSLs/lu3Ogj+ZQqpi87omkT7HrB2ybxiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=vPKphMntFlRbCoJiNva+NPTVzD04h
	wQp6nw8rRPM9P0=; b=k06FRZwcyIbcQhp9vbqo1e/d257QgkDtUA1sD89q1sUJo
	VvFSNe/lnM27abHUHOUhtxr5qNIh9zk3pPrf2RNG2TbfjPSBqBMYiTf95yNNznlN
	r7Pr7G8c3nBn1nRvp4c3hZ83eHA+4VqVvCLnEb+gNWpEP89sXtfs1F/WBUOtqVSO
	35wY02A9wuS9f6Yq8z+9TGHJtvqyV5oFWFssOjbqmHZvcFu1KE4aoxKTcNfdYGdD
	dZtV0NaHOZcZ9S5ixW3PUn48AqQm4ZYpvl3ki8GxYWiuZRSeUWUQcUVXQ08MijxJ
	Bj9USfjfxh9cQQE4AZMFBci+BpW2ZXY3JozLidILQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqnfhngad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:12:46 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBu7JdDRtthwwYGg2KQj/lugI22yyumlMQPak0/mYwNpPRM7hKdnqLWZICmGnFjxz0MlkJUJJ8TnUPd+H3uNQNQ8tdq/worPL8sWYavZZuHSB6gxbVd3j1oPOHqQQkJLpVCgy8mafT6WKr6TNAI9tddLLiypsqLozTR18d8P2dHyaS7UdMYU1ZLxbC5tXiQMTIV9r79E0fbqBRDHlntdJpNNBvO/XV/DMSH54SGpTrrOpwdlZV4LhXhUpooII4miSeKqRiCY+l5q6Ug+8H6poJXO8JYIixeRfDLPhoAxXdmGaqM5jfm+kCd/O+OwI1qOqBX/GtK5Bi9RbPYD6aLd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPKphMntFlRbCoJiNva+NPTVzD04hwQp6nw8rRPM9P0=;
 b=anCeKKzdCU/HSApvmDiHgNYAQmvxnHf/GKjpvpvOAyrejt/WrlRolJmH63xTcqvBzX79UXWHgXbDxR8dl8TcC3NrxgIRRr5PI+2HtQs9mdwAq0AZRvmV/3MEfQi9LsOpvkWCZc+q0BFQcLrXuzSboRulYEeocxMZWg4KoQB1879qhBPhFXTI9KnU77nUTC79cihY9SsRzM/x/pvOSY1eegAA87yJo0pbXD3b+FjBDvioWa8upFncu5YbOIVzy+E1dnV/nuYjMSkd+N7Fbwp4uVF9n6NhvNxb57v04JcdQ4u1JXsbAa6JeaKsDKL4Hi6Q7ghFYxAQXjQ1RbHv2vxcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DSVPR03MB485361.namprd03.prod.outlook.com (2603:10b6:8:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:12:44 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:12:44 +0000
Date: Wed, 4 Nov 2026 15:12:41 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 3/5] dt-bindings: net: adi,adin1110: Add
 adi,spi-oa-tc6
Message-ID: <aus899mJ-XZg6ZgF@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-4-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103160918.409701-4-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPBP307CA0002.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::14) To DM4PR03MB5981.namprd03.prod.outlook.com
 (2603:10b6:5:388::24)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|DSVPR03MB485361:EE_
X-MS-Office365-Filtering-Correlation-Id: 32473bf5-492d-4edb-1ae3-08df3a7db1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261021121427099003|261021135927099003|261102123227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	tU0bDysoZRVPkWT86CFVEaKj+iL2HDLiqu9SM1jZoRhLnbEGJbkrsFsWonI8pxyRexNLzQ6Cbx8TPCsQ8+v7fUbP3LLSHtWOYr9hUGiEzqJncJm48eNa5pDNuSRoBb4s+jLFr9E8Pa79fGzggQdmWTtb5jvik4svcIHxpvgZV1HbH7hp3Y+S+2gv/0PJ9/cq+79a9BImL4TF/vtoeQKvpioR7I/G/QruNG5B6jP7VkhXey1PUwNkeW1aNFWzldwCcvXY8W+9y1OAdyNd7Ap54OJMxDMLYw/dltUieXR7A0BPt544hqDf7vEiMIkumQJHuWmRyJ26XrV0wINJZ4Y7TIc8RRNtvr4jIUWVAutgrAN0JptVkUWfuYdFEPxbY74zEV86QTpjlC29qy0chW3nd0varrbhhxxxqmlMUu8ajv9MYUToAGPfhKhDa9vF+dER5ntfmkqbSJTdOfvZXrl8m7DnpxrKGuHG2K2me+kVkeo5MAaW5yZsHhOpz2uE8tBruGmXgelIMKDYo+Ktx1psrvuUOLe9wTQoFk6FAFFx/iIInRfoZMd4osKo4ezRm8F4nfz+jBZT39YABELFqnQ0fnjCLCOv/LjuY49lVH8uiDeqoqS8WtZlbtja5bYBM8t+59o/hFcfUzC5Y/JJOsNyqTVYl3twhDgh1lZOuwm+Ubg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021135927099003)(261102123227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnRmcW0rdE10N1FLOHpvRUw3ejRyZHE4R29qRnBLK1FIZkdVdzR3TC9tUzFp?=
 =?utf-8?B?OUN5WTdXVWkrRGJEUVd0cTZmeDAwYkx1UjBvNTg5YlVLSmJ2N2JTQ2xQQmZD?=
 =?utf-8?B?cFpkcWN4UHpSdmlHV3FzN1dPZEZTUDhQaTRGQ01Fak5Yc3NGRFNwYW9DVzlQ?=
 =?utf-8?B?VFhNN0pKRWtDLzhoWkFUL1haenZodm5FTE9hUitkWXUrUG5GSGlqTzAvRVNC?=
 =?utf-8?B?RVR2MmhtYmh2V1FITCtoeDhna3pFbi9RRnc3Nmhmb1VVanNreU80ckRWRGlp?=
 =?utf-8?B?NXBBMTF3UWpObERsK3JvSm1MRUEzVlhEMkpOZWpGRjdKVURsS1gwSGgwQ0lX?=
 =?utf-8?B?Z3BiMk9FalRyN3JoNW4rZmV5ZER6TFZzcFJJdFB1WW8wS2p6WGJUK1ZjbUU5?=
 =?utf-8?B?dlp0T2xGdHpuQllWdGQ0cGQ3dHFMNjdzUDROZHNRU3ZBMzZua3NkbTVWNTN2?=
 =?utf-8?B?Q2NkNGxhbXN4SlVVVmpkNzh1Vkd0N3h5N052Q1FJSWVOcG51RUJmN2NidENI?=
 =?utf-8?B?MFFFSk5TalUzd1R1alM3RXVRY0trVFZyV21SdjlRZG1mVkx3NE9DbWVHTXdZ?=
 =?utf-8?B?WnZUdzR1UGZQN1VnakJEUm9TN1NqVXN2K0NhaS8wTGhBbFg3bkg3ODR1a3RT?=
 =?utf-8?B?bUo3SVNEMlo4WEJDcVVKUVVEa0gvblBidmFCS3RFdFFRWVEwNVpRSlBTOHlW?=
 =?utf-8?B?cG5PM0JVY1B0VmFGT0JOUVFOdlg3TWhvcE1tTHJNeEp5Qm5XWlVnN0F6cm1D?=
 =?utf-8?B?WmJFUjZQOGpUREMvcVhaLzhTamI0WElQZjBhT2E3bG1UNnlBRUhCMnd1aklL?=
 =?utf-8?B?Z2lmd25CQXJZdi9UMkVmNS8ydkZpVHV5blZsSUtIK1kzMXQyN3RTMmwwTUlo?=
 =?utf-8?B?Yk1YbDZyN2xLcWlvRUlmWm5xMjdDaXJyQjNFODFNMFlKOTBBYWxCUThFY2Zk?=
 =?utf-8?B?aE5RN3l5a3F1dEhRNDQ3UXVPaHFDZFlLdUxNbnlIako5anRoM2I2anppaEF5?=
 =?utf-8?B?TXpvclVNYU5qRnhyOVlaWWxVY282U1MzOHRnSElVMDBFWUNGbWtKOXdhQzVE?=
 =?utf-8?B?ZWhFU1BjcW50akZodHBVa0tIOVZYNnhDamlvMk9rZk80YlRpMTN1aWM3UmtU?=
 =?utf-8?B?QWxORnpaNUw4ZzhFUkZMdWFFRFhIeVk2c1ZYdFd1dUxWK2hiS1RMWFJ1Tms1?=
 =?utf-8?B?ZWdIcnIyK0NJNHRxQk1sTWZGMlBhN2N2Ly9hRkF1eVBkeXNDTnBpSWtCUmRx?=
 =?utf-8?B?L3YyUkJ2RzFUUk5ZQnpwVk1TMFBYc2JVZmhxK2pKOXRXSkRrUE92YzFJSVhV?=
 =?utf-8?B?VmlKc0UrYkZjSmFwMXFKa2E3WXZXbTh1NVNVWmYzODNZR3FNa1FmV3NySHov?=
 =?utf-8?B?ZW5xRzF0SGlaZUZ2L3ZUY0JPcER2VFdZM0ZrZ3ZiYzkvcTIzRC9OdU9Nd2tE?=
 =?utf-8?B?bFNzcjFKUXRyOGowSG1qbkVtdi8rSnY2dEJXYk9TU0taOW0yR0dNRnNQZ2pm?=
 =?utf-8?B?Vm41ZTF4TFpTSm1kNTRpK3RnUFBFOUFZTjVoZDhxMlZMS25UQjRxd3pveDhC?=
 =?utf-8?B?NXY4aXR2TXdUUE42WUxkbnVGZERqMVE5SXdXbkdSTVh5YkJweSs1eWpBZ3R3?=
 =?utf-8?B?bnZWWlVjZjNtN3BHWHN2VlEyM1R4ZFJmN0lrSzJRODBXQ0dzRFdPeDAwdWpi?=
 =?utf-8?B?RWwvdEJCZW0rYmRsSE0wN3lETW9DTit5dWpsOGJVU1crM0QwUVJMbzZ3K3Bv?=
 =?utf-8?B?NGpXdG51d2FWcjZCMmVGeWFLWlBGbGw1Uytya05qeUN4NWFjNm5RZWIzR2Yr?=
 =?utf-8?B?di9WcGlyZzdjL09EUWw3cjlDS3VXTlM2U2dMMm5GSmZpOWhEK2FFNzk0aEpE?=
 =?utf-8?B?RHJ3MDNCdXFlanM0NVFPeVJtY3krUVQ0c094ZlpXSEFVWGZpSzVENlZ2cFBP?=
 =?utf-8?B?WFIzT3Rrc2ZuK0VyQzdCYmR1dXRFQm5MMHBBTkQwL0w5dUc3K1dIdmNkV1hV?=
 =?utf-8?B?V2ZqaEFkSzk4S1RuK3JSTlkzWkF3Vll1SURaYVFqbENBQzVpYjk5QXVlb3Fr?=
 =?utf-8?B?QzNGeW1DTVVGZjh5eWVTTGViNHk1cmFBRit3azl3QktwK0FFMkE5ZXN1SXlw?=
 =?utf-8?B?T09LNzdEWWV1eTIwTDZzbVVjTHdNemtpcXpkaEhUYkRjSlRsSzBPY2p3cmp5?=
 =?utf-8?B?Y3VUeExRcEVIc2NCSUNaR0srajAxbXc1UGRUYll3SUFtcVptUEU5Z2cvSEdi?=
 =?utf-8?B?KzZpcHBETGJ0Y291akhyanFVaDV6ejRWZnR4cnFUck1GL0Fnd1gzVzJXTVVW?=
 =?utf-8?B?TkJvWXZVdUNUYXVTazhsZTU4ZnFQMVZRMGZhYkJSa3NqQ1ZuNVJsdz09?=
X-Exchange-RoutingPolicyChecked:
	V0Z0CywQ/2LR7A4/ta9AefPT4lt1MvOvFBMeA31R1MjNutJc8imnl3cE7qjbez9vn8JxH+akX1iwQxDXjYYG2WmZE40/xQUnq7uBnJWh57SeB2JJlYYxr2iu47Xf7zyhePw1krBGRGNn3kIUNYB7+qXV6O8CRwt0UfcwXGqZMIzDoUNqUYLfXEPOO3AG4DeDGZ1ZriauxR9AnhFY7pc96AkyvHOVR6K3IHVy6SKM6Ev2Dbk1CiVupzov3qpv24/zkufJiDM/amMHduAX0PUVPXz/YXvMYiutiuqaYPT7Ubb/Nh0vIHK0njug1McqtSZBCqNEJBJY7iG/Ykmr/oJS9w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32473bf5-492d-4edb-1ae3-08df3a7db1e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:12:44.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CinjTkEKUfy2E0vNGwhKG8yum/gnm7AOojLjHNdAHkXf0T+HukUeP9L9RquNMEmoaPro/YJORUMu4aCYvQXbAMp6lquhwoJMFQMuILU1ehE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB485361
X-Authority-Analysis: v=2.4 cv=I6Pw19gg c=1 sm=1 tr=0 ts=6aeb3d5e cx=c_pps
 a=vvCUPcqovLgrcFR9lHNvxw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=OCyn0DeAHqlee7AmNIMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yO2H8CS1flgi52P4lz9_zwDjivXcsLOc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfXyqFPAVS9Glb0
 h8Agzj1T31FuUNoaB7MRHFfAXaKyJX75mGRj3KO+UZvYmpAxdI9nYHELwQb5Ka/jel8mvnHFjxM
 RHr4/a38H+P/uAdmKMENtD3IaZ/CkkP2z/tC8UWKwZxt7JAyoQWOA6S8paOJQiYTYDrX4ne8TVh
 DBk4kFKKSNHbVIizkm0zwZINjvSu+la93Y/G54zhqxrHZQJ4cHB9TXLNnmuU7L5qvkOL4W5iWyk
 tUK+bK4ne0bAe/PTTvSa554KUAOUpUaHRtpesv+cP+oBvHxwyRLZr+GzUCcoX68K303/VsZ/i7d
 Dr3IID3jA40HmqsX3XtBQg6TkSnhn2QxVBMNGIJI3D2GdQPSdLprtorAarhMwjFqOMzpmDAbJ78
 QXQ0mjhIq5d1v8EFBQSc29xfPAJL2lnZe8oJqAuj9s3h+oz2iN5a9Yq55tsEIDX1HswKmUk24Z1
 ahHfGkvyFbGs8yvdcaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfXy+VdrkiUzL0f
 vjS4G8vR4+THKVVxxEli297VAGs7rqolKVkzsvWek7ocEqhPFGg7LTYv2/vTLNA1h87uUcfg+/m
 frBnLjAe8vhvX2mklJrY+lTcMZMyo4OV5M7W6o3Stz9w5B7dXnlM
X-Proofpoint-ORIG-GUID: yO2H8CS1flgi52P4lz9_zwDjivXcsLOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040056

On Tue, Nov 03, 2026 at 06:09:16PM +0200, Iustin Stolniceanu wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> The ADIN1110 and ADIN2111 support two SPI host interface protocols:
> the generic SPI protocol and the OPEN Alliance TC6 protocol. The
> protocol is selected by the state of the SPI_CFG1 pin, which the device
> latches when it comes out of reset, together with SPI_CFG0, which
> selects CRC (generic SPI) or protection (OPEN Alliance) mode.
> 
> The protocol is set by the board hardware, so the driver must know it
> in advance. Add a boolean property to describe a device configured for
> the OPEN Alliance TC6 protocol. Without it, the generic SPI protocol is
> assumed, as before.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
> ---
>  Documentation/devicetree/bindings/net/adi,adin1110.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> index 0a73e01d7f97..e19b6c94708d 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> @@ -43,6 +43,12 @@ properties:
>        Enable CRC8 checks on SPI read/writes.
>      type: boolean
>  
> +  adi,spi-oa-tc6:
> +    description: |
> +      The device is configured, through the SPI_CFG1 pin, for the
> +      Open Alliance TC6 protocol instead of the generic SPI one.
> +    type: boolean
> +

Should this disallow the adi,spi-crc property if set?

I also see that there's a similar protection concept in OA TC6, but that
seems not to be supported here? Is that intrinsically the same as adi,spi-crc?

>    interrupts:
>      maxItems: 1
>  
> -- 
> 2.43.0
> 
