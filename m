Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793802568;
	b=OveD66Ljzn7d5qb4hyGa45S3J1ulT4UFZ0GC+B7f9xiSE03q0MoKP9cdeBAdUlfPesZz
	 MfZSVfLmT4DPCjB058QATQwXVQKKmZQhGvtwCN991tfvZgUKGHbL04/XnPbABB0aJHzTD
	 5IxhPQbVPpEiYUoS4wUW2lDyv1DZVEskrBn5mTSgqOnIuq8K3IIjURblizhCANCpRqiPF
	 z8wS2QDZ0puAneD3rtUHdUWbzrpT+ByzHEaygRiqwu5mcdNAuMNvEBL3oM6iyj+J9aXT2
	 HKSnOPV1xEuuDkvrYZvPKYwVyMjOY/pS9cRxe4O3Hx6LFE3u77/X928vzl7Ik3xAZWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802568;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SfrTWaLN1myPi8fPUY5Xc3BW4SUyJ78N9h7j6XnHsOo=;
	b=zsaUJTu+xBk9F1zGBqJ72YtSBxXdOSZnmBj8HvhYEdeTGeMXpBQ376rhXcLBICWyULgL
	 tSnWzd95B7YHZJYNEAAlgxl63Msk5bLA5d9cl6m9b075lKe1hNAaTaLg37t0SsRYULMX/
	 x6q4XY8t2r/hZWoKMhcY/iz5+Kvw33OC99cOy365E0Bkdh0gIGvZ6VN1ILKZ4oDyblEKF
	 aEPjw0cKKqR+p8JsjcY4Th9BWAH+nAQUfSABzy9R6easf6d+f364JmOQxDOgkmpNabNXr
	 mbdcYNZTt7SJ+VKcFMUL9TmaiBw2cbXCFM6tyX2a1Us+CBSD88kAgvIE57EXbX9Nguw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=cPvCj3eE;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZThk5Dy7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C59606A328;
	Wed,  4 Nov 2026 14:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C59606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=cPvCj3eE;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZThk5Dy7
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4EJLX2983082;
	Wed, 4 Nov 2026 09:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=SfrTWaLN1myPi8fPUY5Xc3BW4SUyJ
	78N9h7j6XnHsOo=; b=cPvCj3eEz/SQF0/zFlLzXdglYRDsPGb0TJpljxhI7zXRK
	kgx2lfoyrI0S2LeRPtM/GG1NUCVTfjSn7irNXG/SNLTEg4XRiLMv7OpgAhsaMAoi
	Shwy5RQQVgBPT7Hz6PPd2I11TlrwjilFVTBR2meb3Txm8JmjDChzZwRdMT9fRfW9
	wpcAk24M4Qio9gcEKY61rpixtYYIEfdIq8XWHfMoF2JWO/weU02qDyvmZPtc/+bg
	N2+L8NZHPNzLdtysP/ahq9m+QZBUlq7lZczVyhLmHEJR8H/+bo6emaIypuygkDkF
	m3Y1NkwlSfjpzURDl/5CQqX9Dbmu+MXuYWM4Qi9Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=SfrTWaLN1myPi8fPUY5Xc3BW4SUyJ
	78N9h7j6XnHsOo=; b=ZThk5Dy7vfPZEANE+5sWCTcNOvkyepkRDCGfbO/5iWY+o
	felHRm5UAMgRgGI2zzMPrisQdzfbRz0itDGwqS1pk1ctKHSmLDoQu7YXydGYvSg8
	IX5nMipc+1ag8ULV/eSqjFddyHgJU2yE2TB1XKBfPQVrvIdtNBJT+2XIBEG71gN8
	sWJTidSUZ40t3bfMMOFxOZBlyx8okKvRSfE1UrKT/Ktf959M6qD2KlMLyEZ3rHvO
	kne+FKLEGfr34Qyn67Gs0sYQjpZLuVVveWtRf8+oQsqXVXeqU7NzA+KiWeTTlm6Q
	UXama07fCySRWF3wj6OH75nluDu6Iwln62tXSgNmg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqkb25vaf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:29:15 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWBIJvBUeY4oBBW7NJrGHMG+peN1lusbfCVguiEy3N2nE0YgLdYQL3fmmW+p1QTfanaLRIFk5pWacFzJ7KK0cfQnc9+0jxJz0xtamNEPLbDcEAKJ00LDmf44SDj1R3akuVv6ezymqs489AXMnzd7QS7GFmhbJkMAhX1qPJFeILPbgRBfXEIErwKLlDUgF0j0ikBYlzq4Va3p/vjpuAtDyJHS5GUXrlyijkai7TJ1AhcHUBuS5c3k6k+KMDsn94PI8WHxzndJjmB0CtFZRt1LQuhvk6K4NJdljSGxtElBI54FLv6QKjwA1nBRfTccsP5rM/FK3vrqV4+XCkVW3r1O5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfrTWaLN1myPi8fPUY5Xc3BW4SUyJ78N9h7j6XnHsOo=;
 b=iOy18xVb4+d+z/6FNHzuTTUXiJ9ZUkDcCVi18cPqhsLRImoH0uhzByLnmRhwb6Dd6yCL8gKY67qg8879hmKW2BnOKpDhiZi91PT3EvA/B/zKKmBi8Hpx5ojHhGIJQ/ICDMBFQz7LDVlfVb4ydNBmk1LC8All94odcpwyvYYCjvjs9/PNLwRQ02ZaL11+zXeJrprv9Lt214RP38MALs2YJwKGHMlZrqtQp5FL4I5sHfsX6Yu/Nm8gxCwaFSY+9zrb0v6cTmZDlhUzo7YPic4bfAj0mez6AboBKQMDBX2W0Cnc05+YXmNAAjuJeDafW8X/OlWn4GhPTbz4WhLfBrmtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DS7PR03MB8195.namprd03.prod.outlook.com (2603:10b6:8:261::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 14:29:13 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:29:13 +0000
Date: Wed, 4 Nov 2026 15:29:09 +0100
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
Subject: Re: [PATCH net-next 5/5] net: phy: adin1100: Skip the soft reset on
 ADIN1110/ADIN2111
Message-ID: <autAidTgykOObtzp@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-6-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103160918.409701-6-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPBP307CA0005.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::8)
 To DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|DS7PR03MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 21261d4c-38ba-4be3-0704-08df3a7fff3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261022075727099003|261026121527099003|261021121427099003|261021135927099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	VEvgdBt1zyuPUY7PZg9M96Hsc3Q6dd2qhTywKudYHq+9rZ/rKNcWiYYA+lmTjrBoGChh4OWqkPUK3gcNoj1ivslXj+MMoMZbz1uIDxXCLZGHoDiyJeijwn+mFeqCPvaumxQQfQCUysO4hJpo4VJJ94UJ4cF03a+wDZc/rMhxygglfmZvONI5LVaAFjYwskcXmxfIpspV9AwbppOqMIw5sfVQ4n9JUFdsIjjuQy0UD8xrEOAQZjhutk2IDwdvLice91eEyVVv3T34kaCabJ6n1KfRMHQN7BK4KypEN6EEOVhI5ImTznBonYNyedHLiChK3NBybWJ4c+S5Zqa10CeMXK+KA956YGVrsT8F6IkGKMo0wpnxld50bL03Nj/UENge5s0U53CWtuPboLrDVEGATHcHXmw+Oo7Hw9AYz08A9bJHFH3G5F3gdduLKkc938IlJ4npMHYcsL4F/U9+GvlBWJIlDJoGuoAxL06wd3MWnxjITQyV60iGlO9uLe+yaGmVhTTXDLIBBbBTQMxJ9cxcVeoPl3Qm1+ozhSEArHOjt+dME04Q2s0oor88oD9wZ2nzsoSupFGkwoo5R0F7IRCmMufe8seb+720R+jeWtXfSz9jszd3LAj6QhEyTUmUppPUKWPQvRjvLvUr1ch9E3NOOFcpcjEw/MMPSBM0dWRxNGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(261026121527099003)(261021121427099003)(261021135927099003)(261021123027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1c1WmpwendKK2pWeS9PQlFUT3VQUTJnbGtsblRFd2dxSTVqenZxSEd0RGRB?=
 =?utf-8?B?a3F1ZXdaVWNodTNyeS9qOXVUY1J3ZTJBcjE2aDlNMEZBcVpCaThVNkxRTGI3?=
 =?utf-8?B?cjR6QmFyNG5xR1grN3VFKzU2TlVUWjBmbDFJTmdmR3g0NWR3Zm9OczVTa2FN?=
 =?utf-8?B?OTNkd2tOcUxTVngrVURxelYwK2FNaXdGdmdJZmV6dXlnS3hJS3JPaU4rS0Na?=
 =?utf-8?B?SkxDczhmUWpXS3lrT3BTM05Rb045S0lXMFZzVjBFM0p4U1BBd3o0MFUwemdi?=
 =?utf-8?B?b0xpTWxxcWhRZmJhSjNFcTkvV0RWQnRDUUVvdlY0aHJpZVpDQy9iRk0vYnhM?=
 =?utf-8?B?M3N1NCtEb0NNYWhMVEEzc2J1dkpCQ3dHcjlYL2ZMQnNGOWEybmk2aWJOVFA5?=
 =?utf-8?B?ZUx0ZktSZVpEbVhhQWZLTWhrTEZGa3l2UHJDOTVaakJPcU0ySndKcmx0UzI0?=
 =?utf-8?B?RjJ5SXkvbElBK00rU3FwcjVQdnV4bkxSTWtTYno2OEh6dmJPSnhkUDRzQTRX?=
 =?utf-8?B?c0dmNVJIVHY0T2xsdXd4YktMZGRNNjJWS0Y4SVJ6c1ZTbnM1Sy9LakszMDQx?=
 =?utf-8?B?OUNRbXJzRlNybWJmTjNRTVNsQUp6NWd1WlZEMy9uR0FSaTZzbUk3UCtvRndU?=
 =?utf-8?B?cHhVdDRNWURQeWhacEdySTJmNjBaVnBWb0ZOQSs5ZGlTTENjVFpGSXJBbUZY?=
 =?utf-8?B?Skt0bERQRG9BOEoyUENENW4zVkdDLzVIS1I4emZVenIrTGZWbDdVN3NsNmJk?=
 =?utf-8?B?U2hVTTZLU1hSOWpKV0lGTEp3RXUvYmtUU2lJTVZ2am8rcEhIR0FpVU01RWdC?=
 =?utf-8?B?V2ZoNlF0bXR6emhROWwxcVIwOHU4dWpxRCtWUC84K1BQRWtRRFl3QXNPQXBU?=
 =?utf-8?B?b3dCUlo2Y2RpZCtWMnRCTmE5SzdXMWtDQ3JxMWU5UHErSDJ6a1ZWYlI4VHRu?=
 =?utf-8?B?WWR2WUkwalpXbmkwTTJRSERsM1VjTFprVHNkNWtzV3l3bVZVYnBIR1JWeTBC?=
 =?utf-8?B?TjdscTNPd05Ld3BFc1MzTy82eThVblNjRVNUM3BsSi9lZWx6NjV4R2N4TVJj?=
 =?utf-8?B?ZUVrc3FtZmMzSjltdVhsbWRoZjlaMnVuM0VtUUVFSlpnUU9RTUhQQ09vZnAv?=
 =?utf-8?B?OFJYcGFGTlQxdjNpZDdtTE05LzhQWTlaWVBkMG1zM2hMRUE5WFlMQ2lwYkg0?=
 =?utf-8?B?bllxZno3R1FBcGh5V3hENjdxdkdZcGsxZ3A0SmtySEFOSVp5bXRUajErYVp6?=
 =?utf-8?B?dzJobTFXMFpFTmw1UnlaK20vK2tkTXl4SElQcm1BbDQ3WkFRbWlpRjFYcTE0?=
 =?utf-8?B?cTU4VmlPd0RhelhaR0dCa3B1OFpER0tKVXhwWEhrbVZIUmgyRm94dUxmaE9j?=
 =?utf-8?B?cm1VOTZXd3lhRDlDZVBKTDk2Z3JoL0krVGtCQ0JqK1poSkEwU2RVT3c5TERF?=
 =?utf-8?B?blhYNlFGMEVxZzJyR09RUkx1WlpBQXZCTEx4ZktOUVRISm5Uak1rWlFRRDVi?=
 =?utf-8?B?a0M0dG0zcUhHY1B6NExaUm9lT0d5blA0SFFURldDVjZ2YU9SQ3ExcHZKWVRL?=
 =?utf-8?B?L3VTRnQxRm1sLytveHl2Q1piOGd3bUtYV254a2RSNjZhY3ZiZkgwN0VFWC9G?=
 =?utf-8?B?MG8zeHlzNXRkcGE2YXJ0Vm16TE42YzZCcXA5TTZaNWVnWUNBWFVhK1k3am10?=
 =?utf-8?B?ZGlUL2RpSDJmejhkZzNJeUo3Rkc5MDhQbVpjdWU4WHk3MHM1d2FsSFhDUzVV?=
 =?utf-8?B?b2NhcUJBUzg3S09ObnNXbGZCZHdWNk91cVpQaFdXZjhvVjBKRFcwVjdXY2ov?=
 =?utf-8?B?M3hPYnFUaVFMT2x2MHBuY0d1bFMrSDBCOTBPNGZSK0dQbm5iWFh2aXJFeHRn?=
 =?utf-8?B?a2tIeFAzbjU3dmFZUk4vTHFhVzVRRnZGV3g2R2l6MXlYQVBWditPVDlPYTZl?=
 =?utf-8?B?aWFZUXhOb25ZeHNmRXd1R0NvaXc1dUdOZlB4Y3ZpbVBXRGszMGJQUVlsREU0?=
 =?utf-8?B?MTVTMGdlRGgxOCt2d0o0dFBKR2VGZ0Y2SnNWWi9pdEdwTmZNeWQ5UmFnRUNh?=
 =?utf-8?B?VXlMQ1N1YXZUdFpUWlkxSWVrSFNkU1VOcUZRdC8zYjJqU082Qm5rZ3piS2Zl?=
 =?utf-8?B?WE1NZlduNytsK1gyZTYxbmF5dnhENFpiZHFsazZhSG1JKzlhdTZtMkZ1QkRK?=
 =?utf-8?B?TzIwdzFzRHJIbmZLTnoxZmdJL3V5NTIvdStYMGM5Qk10eXdoMkMxVzA3M25X?=
 =?utf-8?B?TVhqa3JPLy9vdWhES2dVQ0MyWHpxbUtQQU1FV2RjT29oWHBDRVNaNFVITC9O?=
 =?utf-8?B?OFVLQi8yaWRYSmY0a2owMVdaVzB3UE85Q2Q3VFN0d2IwSWl6bHA0dz09?=
X-Exchange-RoutingPolicyChecked:
	tLluWL06I43oGUPsex4dXdt1O/mnEQMiTqKhjbUjZaoOG8cvep7t20s4q/cKuL8D3wrqmpaAjDq3JC+AMa5bYV5Ygtf/PGvvsPxYQ1w1Ql0zFMtjF7pS6KoJeNw16RSeBhGY/iQreHjGTTS/BEj4lV3zemvk23+W9IM+bC2x996l1dyKf4ApchuCMsNjvfLwo8cZsX6kM8IMEBphEBmC3AZ6GLbCZrmwR+/3HS2I8C5pA/YV4mjN+NjP+4muUlkivpz347Z9sZZ4XnDVEJizeaYs2TtJSCa/UhKzEG88QBKO3rIvYvcjuMbPPXGvS9ZqX0AFa/YnzTIO5ky76YtGtQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21261d4c-38ba-4be3-0704-08df3a7fff3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:29:12.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Llb1GYCaM/err4s7YXDLYbOOPzkQhRJtxJg9m4fjOuQPQjWXLL4+mHQRNQDbv4F9hKRZvnh1+vxo6/JaasMZSpBmX5oXwu52BFgF76NqaTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8195
X-Proofpoint-GUID: gFl626Q-ZjefVQ5tGf0UOK6MtIlEoSoN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NyBTYWx0ZWRfXyiybEZ3ntniy
 jYEmJxRjucM9g5TQqrKIX3EFwLMeu9Tk4OrEx8YwpG3oZsJQiSCROCa20VYSJSDTesYvo0RymHc
 EOrillq02bVSxRrZRzSHAA7h10VMTFNggHvy3M3s5+eNM13M3ZjV
X-Authority-Analysis: v=2.4 cv=EOOTQFZC c=1 sm=1 tr=0 ts=6aeb413b cx=c_pps
 a=m4QPU8/Yf0DQKtM+qTkXOQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=GfOx-84Qext_mdjycDwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gFl626Q-ZjefVQ5tGf0UOK6MtIlEoSoN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NyBTYWx0ZWRfX5OygvvnuZ+BS
 mZYuejUz8NMpsnRMrMdacUYC8eNrQX0W91487Xv4/3+0qdNV2xapyFnAVEfb09E7AWBsWrJFU3j
 ZZ89BQpcDQd6ISeZ6QFbyjK/WWxgrAtc+cJeGneb1Npw62dSbhh3TEKJ/fjk8CFGm8EiUpiKmDj
 12VPSlIEU0FuuL80t9YgYyCJ6x5iCr86JjRPQG55EU1BhfwuQ6yKFZHT7Sw+b2k7txktnxgXxLA
 cAKRoVl11/Hc9CPukr3B7v+YxQxJCCpGYjae5YRabFdJJqed7jO7uMCl3CzucTnEIbZGASVGD2a
 SvoyLQesQZVLnmw8ejjeZCz4IJctTWTZNwDTdsMUq19YPmYJcJvLIq9n90VGu+TPyQjAt/QCFcV
 xnPirjCbRrWtEzEBtXoJAvB2AkTs+u8TKTZr+ZJ9frnx00Tc/p5pTOBakStyajgwdCEfKO0j0QC
 RkiSavQhT66Vcy3jrVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040057

On Tue, Nov 03, 2026 at 06:09:18PM +0200, Iustin Stolniceanu wrote:
> The ADIN1110 and ADIN2111 MAC-PHYs integrate the ADIN1100 PHY and use
> this driver. On these devices, CRSM_SFT_RST resets the whole chip, not
> only the PHY, undoing the configuration done by the MAC driver before
> the PHY is attached. MDIO reads also return stale data until the reset
> completes.
> 
> The MAC driver already resets the chip before attaching the PHY, so
> skip the soft reset on these devices.

Is this a bugfix?

> 
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
> ---
>  drivers/net/phy/adin1100.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
> index 8f9753d4318c..7b4e68285a9d 100644
> --- a/drivers/net/phy/adin1100.c
> +++ b/drivers/net/phy/adin1100.c
> @@ -232,6 +232,15 @@ static int adin_soft_reset(struct phy_device *phydev)
>  {
>  	int ret;
>  
> +	/* On the ADIN1110/ADIN2111 MAC-PHYs, CRSM_SFT_RST resets the whole
> +	 * chip, undoing the MAC driver's setup, and MDIO reads return stale
> +	 * data until it completes. The MAC driver has already reset the
> +	 * chip, so skip it here.
> +	 */
> +	if (phy_id_compare_model(phydev->phy_id, PHY_ID_ADIN1110) ||
> +	    phy_id_compare_model(phydev->phy_id, PHY_ID_ADIN2111))
> +		return 0;

It seems more common to have a separate struct phy_driver entry in the
array passed to module_phy_driver() with a more precise
phy_id/mask. Then for ADIN1110/ADIN2111 you'd omit the
.soft_reset. Maybe Andrew knows what is preferred here?

> +
>  	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, ADIN_CRSM_SFT_RST, ADIN_CRSM_SFT_RST_EN);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.43.0
> 
