Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.156.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482243;
	b=PvykFhNuRJCYBPQCdXMczp1UbhN54k25GvQTgGybAXHOBfr1lIhaI7hjsDUCkq615ci+
	 1FEgAZ8boIJzlmJNmZKOjceHaGEdZCXhJVaYaebV8GfiohoH6jxwMZULIe7wBQzMc8D1H
	 etf2+x6jFN46WpYWAdsByHdxIR0XYoqRPx6BB/2r9WYNwmp+MJnTZxLxO37AazcWefIPp
	 d6PapaTjiYa3VlDAILvAd8ul0Fo7BU1nzS3LfYxcmEb527IRrxEYUsgxmvpBZtqbxuCRJ
	 FJT95kF4nB+0S6f30Vj4Ey1Thx0NV55FoDB8UI02oEgVRjNDHuhWcuisZYVBawRvn2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482243;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=fEAZwCOqLvZ1w5znYDIkGx6jC2UyEHuc502UML4m4lM=;
	b=Egk4xvFBA/QM2YWZVFQOaNh0A4n+zSb4TzvFQhoWcu9J4FDNy+zMAOdSclGN7k9jjHEV
	 5fxdolkDRMEVm3Co269fyRZBDb/wPHrAlO8+fWrMb+tz1aJqusltgjdJxCDonUhhjov/V
	 q3crEym2YSqcB/FSdndBfbB7VmsX9Z9LqxLeFc+R25XPgytPL1goI9pZLTCamkD8r86k5
	 0+ZTSUOm/k0KvjErFVyxeEz4dbejzQMCj1EqCBXOnhlynjDtmsEkzN8AgZQZkGrZeemc0
	 v6KgFzT6drnV0zK+vxyuXMewlbK6nwFvWFbbWn5ez4SLvPu8QbOaZ0alJsEcq0Y5fsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=UIAW6T1J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B6606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A16B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=UIAW6T1J
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7PaHm1847989;
	Thu, 12 Nov 2026 03:17:18 -0800
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021094.outbound.protection.outlook.com [52.101.62.94])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hw15uuc6a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 03:17:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5y4Z++3Btm6pyQXrkiXE7rC+KEv+fiIEVBATS/CUBRYoHe6K2vh3+F2mRsCShud4zqsMkFsyILV2zyZ7TkOgJKA4JswdIVHfjMIpt1DbA3WX8eoDNKjyv8aO7r76EvsD/ppiu9uGjfPvuHByp79c81Uw6+nifepX/xnKdWgN4uAZOZKO/7Y8heLZCL8bXen+p5/Rb5isNQhRnmjsyA5eel3AE7nHhXT196tKR9y8Xbi4PEX809Tph4yI7NkMRBgv0XGs8MOJNOJ+kdK22vcxXqbXEIFJ5ZfGPQT2j8GdkjQzXO8iDp+df8SC4fKtW7H0aJqmTJZ7hJmnN3Qmi6bIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEAZwCOqLvZ1w5znYDIkGx6jC2UyEHuc502UML4m4lM=;
 b=lJ0xfnJlHRLppu7VsC01OCUGU+4411m9yoAozgBqKN5YIfkAkbsZemjqkVfeLh0Q6APRk7eoV7AHRtnQzzZwpOXpnnN3M9dFtL6c8afcKCG1iKJOnIjn/+F74jBZ6BPfH/02n0wgDUqfOmsM7Ai+zZF7/3mRUpI8gaDnm268XIr8qP0EctS90FywwkNVNmI9/brDM7m7mH4INDFbyMiDR50j1tdR1+rjx4Xs+TGb50L5RsQoSP9v0h41op1ClT9hIXtX/y2r+BoUexuATNtVqlQcLGmhmxncnm24KzT4EsIxnaAzjOwPXHWODp/owKOdQlnrngor+7vRdbZmJ3Dp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEAZwCOqLvZ1w5znYDIkGx6jC2UyEHuc502UML4m4lM=;
 b=UIAW6T1JVSfyb6X4mC5H656yKPy8aR0T9oc9LEghEq52M4ellkMC6+0eKTJ8PZ6MBasx2ngfAzGCrUt2ZbJ9XVd72phxLGqg8gQQKG3TndCooBgJpzt9paPReZNvk+d3q7pM/Y/w8EcxhZ5tzMw+if29T6wE3rPjET02/5NygfE=
Received: from CO6PR18MB3859.namprd18.prod.outlook.com (2603:10b6:5:349::7) by
 MN0PR18MB5941.namprd18.prod.outlook.com (2603:10b6:208:4bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 11:16:08 +0000
Received: from CO6PR18MB3859.namprd18.prod.outlook.com
 ([fe80::ccdf:d2d5:bd22:df6d]) by CO6PR18MB3859.namprd18.prod.outlook.com
 ([fe80::ccdf:d2d5:bd22:df6d%3]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 11:16:07 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Yicheng Zhong <zhongyicheng241@mails.ucas.ac.cn>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [RFC net-next 2/2] octeontx2-af: cn20k: do not phys_to_virt() the
 mailbox base
Thread-Topic: [RFC net-next 2/2] octeontx2-af: cn20k: do not phys_to_virt()
 the mailbox base
Thread-Index: AQHdcpc2o0ndIdK0CEiQcfbOj5mjQw==
Date: Thu, 12 Nov 2026 11:16:07 +0000
Message-ID:
 <CO6PR18MB385937CF769CC37612732B02A0702@CO6PR18MB3859.namprd18.prod.outlook.com>
References: <179438966513.1752948.1646241391383361825@mails.ucas.ac.cn>
 <179438966513.1752948.11370387748541356912@mails.ucas.ac.cn>
In-Reply-To: <179438966513.1752948.11370387748541356912@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3859:EE_|MN0PR18MB5941:EE_
x-ms-office365-filtering-correlation-id: e3e7a9a9-919f-4aab-83be-08df40ae5936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|261009223027099003|4143699003|11063799006|56012099006|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 kEH6FEaMd2J51mHSGl1JgXvJ6FURc47/c/NIef1CkjQL88YwqinTPmaYyoV6JAG9yI6GeaEFQcCf4/o9u2beG+BFdwQXG6fDQ0Ssq1L/CniscdUGqcXMd+zcfearsZardbh7y9Onpl2UyLGDsw9kzNVFT5L9ZZydJlzPG3d90iPK5/bq+E/J673HA+SOXGKfzYUYCdkaB3kg1twClrlIbXMP326C0/ghtjcLkoxQMi1LFcfSsm0lmonMPHdX2bmoA9FqpJopc6XFnEOGdsTMfD4OMimhdrxKxf7NY0MKmMmDSnZwlm8/DjXS/UD3CcmHQHOlcC95T86idbXa4C+vCDfddkhU/HFyqBiQO4d8NIKC91tYp3fsp/xgfca+rZ8Xhk8dyDKjHlLH8FrWKQntaGGLWBTwQuU8z6Z74U8gvHoxxc4pLXTQIyCwaYLrjbucBgQR8Aavq4yC1Y3Nl179Q3280rfda/8Fchn/a33TQEb3A/SeDRoZTWmclEeyNSKIMALBGMWP6ZFrKjNMEDoF2l/qRTcU/aCfKCJ+7dCEU9nEqwjfU/P1t8s9zdLO8jAX6vLmzRs6SwPevtZY4G+WVHRJMNWQxs6dDaW2JVr7G/es7og2DfTJsGVBeMhF7Rgq1BdAQ1T/4SYkPfvSHxAqoVqs4q6v0v9uIjy0Sqy700TmmIY9q5zGyZPIN4pl/gbqcdO2CdJ1fVOzTR8CeftCucfbMgiTn2M1DwqXN3CA0GY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB3859.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021123027099003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1ZGOU5MQmxKaWlmdmEvWW1vdEhmUWpxYnhGTUVobjBzeTNoS3ZpUHM3djhB?=
 =?utf-8?B?SWZKNlZxeVVUWEdIcTQ0blZqSzFlQ05Ba1hVMDhiSVZWc3VPTDZOejlpZ3NP?=
 =?utf-8?B?UE5aeGk4Nk5OaFdzK3FDVWZCRVV5MWlkYVdBNjM4SkVYNDl2d0xPdE9oaURI?=
 =?utf-8?B?WnlOcEN6TlgyR0xZNFV5bkdvZU5LWm9ZYkxRWEFkS1hRU25UOVRXY0t5ZFZh?=
 =?utf-8?B?VDlabTN2UjJjZ3FJLzN5SUVtRkVoS3hmbGlLaEJXOUxuZmRZSks2Vy83U2lv?=
 =?utf-8?B?aFJ0Mk5Ua3RBcmhlREo0Tnoyemo5d2V5ZGk2aThCRGVHblkyTkdJTXN4YUFm?=
 =?utf-8?B?SlNlUTBlOHBHcDJQa1Zvazc2dmJEZ1pGNlNTWWMwUlNVUUpJSUVYNU5reVRJ?=
 =?utf-8?B?Rk9tMWtKUzJpdWVzWjNxNWgxUWdwTUN0cTZMbDQ1MlJMVnl0RTlFVWZWYUhW?=
 =?utf-8?B?MlF3a250OWZJRUJsWUk2RDZxa0syMWMzbmphUGdNMXVIOVpub3N3VXhxdlJi?=
 =?utf-8?B?emxUdEhTMlRxb2VRS3I2VnRUNDUyOWw4d1lrcjc1WmFvaFBmWXdXaFNQT0U1?=
 =?utf-8?B?NlJZODlLdllwYkpERllRTDNvUTRkWFlYeGx2NHBLZ0NLWHhva1JBWi9DVmtX?=
 =?utf-8?B?WnljZWorc2VpUCtHS2dseUdOYmRQWEJlSnlZQUl1Q0dnRDFqRnlaem1WelFs?=
 =?utf-8?B?dDJMUHRCOXprenU3eTNXQUVwTEhmK3F0dEdPNWU2Wm1XdXlNa3hyWkY4eHpT?=
 =?utf-8?B?bWVQNW0vYkJvMDNMOEVjc3BKRGdFKzZSNnZyUUF3TUM3bEhMQVdwa2NwSTM3?=
 =?utf-8?B?d2VZNHVGNGp5QXpPajlOdGVYVHlBQ0hXVkV5dGNxT0ZBV2dFL2VXMXZDdldI?=
 =?utf-8?B?QW9vd0JOK3FPWDFqY2FVeXNLWVI3ZkFKRENWY1lxcDJDUC9RMzhRemZzRE9w?=
 =?utf-8?B?bzdaQitSY0FBY1FnQnF0Y3lJU0RJYWs1T2tkYm5LQ0dOUUxCOXk4R28zVlhl?=
 =?utf-8?B?K0I3ZEtydHAwaVhDcnVVS2xsQmxrRnE1K0FobnNvQUhpbjJqZGc5dzEwT2Zo?=
 =?utf-8?B?UVNBenozTGdiYjduclJZdWh2VXNRT3NRSWs2RUpuamRWVFNRd2VPVUdxOVBa?=
 =?utf-8?B?bnFnbUpBMU5vUFlFTG1CWTQ4VUJ2cmxCRzBMZ3JvWU9LL3I2b25TZUQ3OENO?=
 =?utf-8?B?cklTN3FYaVFRK3BZcWxXV1g1SVlxak85c3pZMXp1Yjc1Mjc2U2RNK05uMkdK?=
 =?utf-8?B?SFFCazJ1RUpiMXI2VHdSRWhGeDRDMWd4QVJyV05mQS9VWmx6T05JOFVCaEFF?=
 =?utf-8?B?aTZ3T1RWK1RyeVBNVWt4SXN3VWNlekdRR0VEQlFGdXhjRzExdUxTMzJuMmZj?=
 =?utf-8?B?aE42SWJJZE95amJLSjV2WlpRSDUvRThjWUVQQWErcnBTQXRGV280OUcreGh5?=
 =?utf-8?B?K2MyOFpNWjl1Nk1xUEZWZENQT294ODFlNzBYM1dtaklqbW1saGpMQ3JKN0M5?=
 =?utf-8?B?cGhWdjRraWlFWjViWjFmQlJqV1dhcGlGVWtkSXFyNlBrWnlSTUxwVGxLdmhO?=
 =?utf-8?B?SGJ0NXhxZ29wRWxCdlltei8vYUczWXA2aGpYYnNkN1poL0EzejY3K1p1TGph?=
 =?utf-8?B?RGR3bVNxbEx2ODJMYlY1UUxHajlQYzZwM2FsRXdjNHRVRUxHTVVoNlg5OEh1?=
 =?utf-8?B?SFJYb3VQcVNtZTBwWGZGZ1IzZWFPOUU3MzlxWVdYUitTWlRwNFJWTG9mbklz?=
 =?utf-8?B?MEQva3c1WFdrRjdJNGVqNlFuUEpPeFdUdmFOSGhqMFk0L1BBQUkxZU43cWlP?=
 =?utf-8?B?aUs4Z1FOV2VnKzJaV2JZMHpqMmVYZGk1U2Y3Z1NYWEM3UERjc0dlQ0FCMklY?=
 =?utf-8?B?eUNVWXcyTGZ0dHJ2MGMwVDZRRzFwNklQTWVoODQvQkRhZDF5RzNsa1pzTDlV?=
 =?utf-8?B?RzhRV0FSQlJQT010UjBuOEJMZDlsSUJINmtCd1RLMVVLUDE0eTVCL29FdWRo?=
 =?utf-8?B?SEE4UDl5ZWlrRFNHaE0wSjhDMTUyOUpZVHNBbHpNcWRJS3FlZkZYc1g2Tkt1?=
 =?utf-8?B?alNpMG1sQVdTRmxVbXBMRHcwRHI1OVZnQUhiOW02THhDUUgzMzlWSW13OUxr?=
 =?utf-8?B?TFoxNzl5ZVRvNnV2WTJUVW1DY3llbm00dG1vaUZjS0UzUDVTN0E2dkdhY2ln?=
 =?utf-8?B?NlNheEtMOXVza01sSDI4RHlPNnA3cW9IME1HL3FTc1djTnZVTml0NGU0cm1E?=
 =?utf-8?B?TXBtNWpHeUE2Rk40Y0dUR1Jsam1pTk5XZXBMMEdYRU5hTzI5TThJS0I3K2pO?=
 =?utf-8?B?bTNZOSsyVmFSWmhPTEk5U211aktwQmhkVCs5MjVpZGplZjc1eS93QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0MoEc/s1ttGuoLtGqht1FP8834s591+EbA89OhrRmIGZeLqmsfRANExTUVy+gGIf02gsDQfxx9gz/phdUULjwvR85ZGMnUDIICBYEsJs8aA3GNXCXeRTcsaogLZc0t129Nv7ChqwQxrL296NaWDw+L2MPSiJ5nUfsddsSzHw1hK1xOCuWUkjeJLpnp0MDBdmoFs6KB2efcHKngAd+YTXPkv4ccV+kSBiiRGOKEa4+SLJnR2J1HSKCrau8uaVOjKbM9lVNUORbG6w1pyRhQmuQ0bDOO4snprRXFJolPqyBBJshu0J1PJVI1c5ak3aHJjKcZPM72eq7eqKWtoo3pzoDA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3859.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e7a9a9-919f-4aab-83be-08df40ae5936
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 11:16:07.4729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DA4mFWoETjyl/A+X0Ng+BgwC4V+zr1u8mJCz2yT9mEV4A4PZKWukGtYKyARqWP6m4ByCgyAqsZCy+TJZjBMJgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5941
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXw8ZfAmced9CP
 /xeYlpFQyj2henOEh38ioKU33emGCSuGh6xJPzYbLOPdMivXv9dcoWzkFOC+ZW1U0FyX5smA2iW
 Ejv0QRVcJkeNW/cpda+soGWpKc8qLuo=
X-Authority-Analysis: v=2.4 cv=Mev5KJ/f c=1 sm=1 tr=0 ts=6af5a03e cx=c_pps
 a=QffN0g5EZ+Wxgj/Qwxz7mA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=VwQbUJbxAAAA:8 a=1fopSG9ek0Yzf3PmuycA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Tt07COPS-yxvt70Wnia90RJxha4BbKN7
X-Proofpoint-ORIG-GUID: Tt07COPS-yxvt70Wnia90RJxha4BbKN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX0nm5XQ4NX+lG
 0nKur5D0wAYOVZxWA+dsBC/6z8BbQTQAxaVX67OidqjD1ukKSMNFC1HL5iVeHl4he3JwxLTwsus
 bCnG+Ljfeef/O8QpHBctRxLXeu1l3wlf3IGr71qDhV51Q501lc+DS39HHErJVC+pejKjQECEtDL
 0SkV9yCylQRgthxT1+TJnO5iUqByX2qZNKtN27QNOamh5xL81O+1kydHpUTsIVbB95ABA+W6h+6
 qNUQPTcjjHunhTB+Z9y91QeYfuwr2I8b+D4J1hFJIGBiy3A/CxJY0qStzc/W75GsZYLPHKDjXq4
 f2MvXWwNB4llWnMOvIf7aTSGf6UeM3iCDyzqvELZOvclbVz28sE/sxGg9A+xNK1JXS0isKZUiVU
 UrxS4DQeVs/44T/O5uYSJCP0q4Rrw0VHVOAmJ0p6f/uNrpE1z7/2kNQT7J9yzrk8GjYFa/XLeCY
 sm1mEZG9PEgewZ39XsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlpY2hlbmcgWmhvbmcgPHpo
b25neWljaGVuZzI0MUBtYWlscy51Y2FzLmFjLmNuPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVt
YmVyIDExLCAyMDI2IDM6MDQgUE0NCj4gVG86IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRo
YW1AbWFydmVsbC5jb20+OyBSYXRoZWVzaCBLYW5ub3RoDQo+IDxya2Fubm90aEBtYXJ2ZWxsLmNv
bT47IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+Ow0KPiBTdWJiYXJh
eWEgU3VuZGVlcCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+DQo+IENjOiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtSRkMgbmV0LW5leHQgMi8yXSBvY3Rlb250eDItYWY6
IGNuMjBrOiBkbyBub3QNCj4gcGh5c190b192aXJ0KCkgdGhlIG1haWxib3ggYmFzZQ0KPiANCj4g
cW1lbV9hbGxvYygpIHN0b3JlcyB0aGUga2VybmVsIHZpcnR1YWwgYWRkcmVzcyByZXR1cm5lZCBi
eQ0KPiBvdHgyX2RtYV9hbGxvY19jb2hlcmVudCgpIGluIC0+YmFzZSBhbmQgdGhlIERNQSBhZGRy
ZXNzIGluIC0+aW92YSwgc28gLT5iYXNlDQo+IGlzIGFscmVhZHkgYWRkcmVzc2FibGUuIGNuMjBr
X3J2dV9nZXRfbWJveF9yZWdpb25zKCkgcGFzc2VzIGl0IHRocm91Z2gNCj4gcGh5c190b192aXJ0
KCkgYmVmb3JlIGhhbmRpbmcgDQo+IHFtZW1fYWxsb2MoKSBzdG9yZXMgdGhlIGtlcm5lbCB2aXJ0
dWFsIGFkZHJlc3MgcmV0dXJuZWQgYnkNCj4gb3R4Ml9kbWFfYWxsb2NfY29oZXJlbnQoKSBpbiAt
PmJhc2UgYW5kIHRoZSBETUEgYWRkcmVzcyBpbiAtPmlvdmEsIHNvIC0+YmFzZQ0KPiBpcyBhbHJl
YWR5IGFkZHJlc3NhYmxlLiAgY24yMGtfcnZ1X2dldF9tYm94X3JlZ2lvbnMoKSBwYXNzZXMgaXQg
dGhyb3VnaA0KPiBwaHlzX3RvX3ZpcnQoKSBiZWZvcmUgaGFuZGluZyBpdCB0byBvdHgyX21ib3hf
cmVnaW9uc19pbml0KCksIHdoaWNoIHRoZW4NCj4gZGVyZWZlcmVuY2VzIHRoZSByZXN1bHQgYXMg
YSBwb2ludGVyLCBhbmQgb24gYXJtNjQgcGh5c190b192aXJ0KCkgc3VidHJhY3RzDQo+IFBIWVNf
T0ZGU0VUIGFuZCBhZGRzIFBBR0VfT0ZGU0VULCBzbyBhIHZpcnR1YWwgYWRkcmVzcyBnb2VzIGlu
IGFuZA0KPiBzb21ldGhpbmcgb3V0c2lkZSB0aGUgbGluZWFyIG1hcCBjb21lcyBvdXQuDQo+IA0K
PiBVc2UgLT5iYXNlIGRpcmVjdGx5LCBzaW5jZSB0aGUgbWVtb3J5IHRoZSBBRiB3YW50cyBpcyB0
aGUgUkFNIGl0IGFsbG9jYXRlZC4NCj4gSWYgLT5iYXNlIGlzIG1lYW50IHRvIGhvbGQgYSBwaHlz
aWNhbCBhZGRyZXNzIG9uIHRoaXMgcGF0aCB0aGVuIHRoZSBhc3NpZ25tZW50IGluDQo+IHFtZW1f
YWxsb2MoKSBpcyB3aGF0IHNob3VsZCBjaGFuZ2UgaW5zdGVhZCwgYW5kIHdlIHdvdWxkIGxpa2Ug
dG8ga25vdyB3aGljaA0KPiBvZiB0aGUgdHdvIGlzIGludGVuZGVkLg0KPiANCj4gRml4ZXM6IGY4
OTA5ZDNkZDU1NCAoIm9jdGVvbnR4Mi1hZjogQ04yMEsgbWJveCBpbXBsZW1lbnRhdGlvbiBmb3Ig
QUYncyBWRiIpDQo+IFNpZ25lZC1vZmYtYnk6IFlpY2hlbmcgWmhvbmcgPHpob25neWljaGVuZzIw
MjVAaXNjYXMuYWMuY24+DQo+IFNpZ25lZC1vZmYtYnk6IFlpY2hlbmcgWmhvbmcgPHpob25neWlj
aGVuZzI0MUBtYWlscy51Y2FzLmFjLmNuPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL21ib3hfaW5pdC5jIHwgNCArKy0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL2NuMjBrL21i
b3hfaW5pdC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYv
Y24yMGsvbWJveF9pbml0LmMNCj4gaW5kZXggMDFmMzJhZGFjNTkuLjY5MDhkN2ZmN2ZiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9hZi9jbjIw
ay9tYm94X2luaXQuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi9hZi9jbjIway9tYm94X2luaXQuYw0KPiBAQCAtMjQwLDcgKzI0MCw3IEBAIGludCBjbjIw
a19ydnVfZ2V0X21ib3hfcmVnaW9ucyhzdHJ1Y3QgcnZ1ICpydnUsIHZvaWQNCj4gKiptYm94X2Fk
ZHIsDQo+ICAJCQlpZiAoIXRlc3RfYml0KHJlZ2lvbiwgcGZfYm1hcCkpDQo+ICAJCQkJY29udGlu
dWU7DQo+IA0KPiAtCQkJYmFyID0gKHU2NClwaHlzX3RvX3ZpcnQoKHU2NClydnUtPm5nX3J2dS0N
Cj4gPnZmX21ib3hfYWRkci0+YmFzZSk7DQo+ICsJCQliYXIgPSAodTY0KXJ2dS0+bmdfcnZ1LT52
Zl9tYm94X2FkZHItPmJhc2U7DQpbU2FpXSAgQWdyZWUgd2l0aCB5b3VyIHN1Z2dlc3Rpb24sIHdl
IGhhdmUgYWxyZWFkeSB0YWtlbiBjYXJlIHRoaXMgY2hhbmdlIGluIGludGVybmFsIHJlcG8uIFRo
YW5rcy4NCj4gIAkJCWJhciArPSByZWdpb24gKiBNQk9YX1NJWkU7DQo+ICAJCQltYm94X2FkZHJb
cmVnaW9uXSA9ICh2b2lkICopYmFyOw0KPiANCj4gQEAgLTI1NCw3ICsyNTQsNyBAQCBpbnQgY24y
MGtfcnZ1X2dldF9tYm94X3JlZ2lvbnMoc3RydWN0IHJ2dSAqcnZ1LCB2b2lkDQo+ICoqbWJveF9h
ZGRyLA0KPiAgCQlpZiAoIXRlc3RfYml0KHJlZ2lvbiwgcGZfYm1hcCkpDQo+ICAJCQljb250aW51
ZTsNCj4gDQo+IC0JCWJhciA9ICh1NjQpcGh5c190b192aXJ0KCh1NjQpcnZ1LT5uZ19ydnUtPnBm
X21ib3hfYWRkci0NCj4gPmJhc2UpOw0KPiArCQliYXIgPSAodTY0KXJ2dS0+bmdfcnZ1LT5wZl9t
Ym94X2FkZHItPmJhc2U7DQo+ICAJCWJhciArPSByZWdpb24gKiBNQk9YX1NJWkU7DQo+IA0KPiAg
CQltYm94X2FkZHJbcmVnaW9uXSA9ICh2b2lkICopYmFyOw0KPiAtLQ0KPiAyLjQzLjANCj4gDQpS
ZXZpZXdlZC1ieTogU2FpIEtyaXNobmEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPg0K
