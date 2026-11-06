Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793980027;
	b=TyYlWiJCgnEUQX94fJvmB4oPdd5hXkFL+GHGWzB6N7EeVo4Yb4UIg1TJnEkp/jtRqbpW
	 0wnMZAzovPXIUO4NKdV64rUODxao1g/nxYzajpz161EEmeTMGi94jhb189Nb6rWWOBBM6
	 g10Yvwdc1P4GIEceMMt3ghtxUPdbkViLJTT5Kdgkm6adgX7l5JPzPtFmBqfZypKB/Rx98
	 BIPEMlMKJk0SIyCc4qBcRllBLE6XXIONzzPXiixrv7JaHXr8whJnIHAlE+IFmlIOGi2uB
	 7yZjeknSu3Ehq9g0akqftlvwuHmgIeW+T9lPwYkO4JSSwIDESmUVV6DvFGZNTqNqVMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980027;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BXQhYIcPP2THrC6QgjdaR6sd6eu6CL4nUHoWO8s+GxQ=;
	b=cazgkhBvx0ejW6vJq0CSRqwBvL4eX4Fi7VDU6yxHI5gptQNYu/ZeDxT0MT8wJFyBJzm4
	 vKnUztNjaNRoc9/qu6zFdA6eP0UUzvUWO6ODs31N4CODrN5x0Cc6mRFaDtlJeCJ2nAgC1
	 RP5Wzx1tmtPx+K8Ls9YkRYjN4adv6t4BCFijCQVFcxTrcuihVDLq6lCFOebjG3QB+8t0e
	 BnsIICsFVq2NPfFSgChdMadKYbC/+VRVbLweIJ7FvtpRkgWmQ4jx6vOaOuFQWMzn1/fWu
	 eNTgR2yscScV/zj9hfnE4H3CNPNEfgvZu7EM6YMzAEJrnEtR7VdRQdSxr/N3qpx1aQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Mkke+C5t;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=OenhdG8n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD158606A32F;
	Fri,  6 Nov 2026 15:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD158606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Mkke+C5t;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=OenhdG8n
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F49i6833046;
	Fri, 6 Nov 2026 10:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=BXQhYIcPP2THrC6QgjdaR6sd6eu6CL4nUHoWO8s+GxQ=; b=Mkke+C5
	teztQGPYiV1R246GUtKK/SQtGxLb6HXqZu7rDL+t3kJHIVIx4q41GBl0JhE2vOO0
	Fk7OMQdSlVMQ0o3O7qy5Ey4sujhTvsNGpMKFsCIVbHkye0ZNyFyhuu1v6XJNGeEr
	TUuHGudxxWue1NvFlkXLOoJGwuUXifeSWo9I0FxyqpLCa3ferA/c9lz9zWOeJwr7
	KmCROX8tSQNmCzRZ4iXhL/9aiSgsOh5yOjkb37R7x8gw60D4BjT19siprDB66r2O
	p1amQ1ed08KCTHAsPirCW26XZMrTKzwAQQFY4TZFt8pMsbJ+v65SlttZrc51B96a
	1ryBlzyo3P9kUWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BXQhY
	IcPP2THrC6QgjdaR6sd6eu6CL4nUHoWO8s+GxQ=; b=OenhdG8n2lt/naU+Ugqy/
	YA9XkNxjsjCe2mEDeLn77W0iggMohy/tn+yw8k1Vz7WR+tAO17PLCDgynSSmxgee
	0TkGj7tHiV5VmgfhK8a4PazpzQVO8xihr+JjmBNeKqHR5oaz3EutYQGW+1Zp5brC
	3AWDfDY8Esl8shBV+zZUk4YdEr9QSQLpDXnifqmi/fZY+WTZZZe2p9y47H1Totc8
	+gd9D4y90G0OJjM9XiMoKKJtNQvckczepyexVBRH1ADfDST/h38BT8yLyFHR9kGp
	iO2r7ExS3m5cBnLNlaxX0ddji1c2j22TbUDZ//95jp5i/qTiAYBwd+uVLDYYsHzW
	w==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q04ym9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 10:46:36 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2OZ60FBA6NssZZyqbUT4jQIe2y9mGEUyEiSKMX2tCPTovKd1DS3xk/DNfQ1IvO7ti1QMxfU09XZYYJxl5FFsX11H8MZ0hs+s55xU5T4gRPo3O833N0geMkDIR4PZoxbYT5xaV3AmyXuFfJJJm0QeQe+GIkH4cA1l04im9MM5gZLhC71b42xw+X1ovzp0PbaWTJrOcj2ew2DMuddwiHeqlpR5eETYXxGtaYfnY8vw2Dmh6gD9I4fdQtu6Ec4Pg35Na5aJSYBLBM1qRd+dgS0mZryyCSDrbW97YJuhS0e0rmUC3ePGFn8BVXHXkY6IKmqoNnvxAd6d0eKM8h3kMPWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXQhYIcPP2THrC6QgjdaR6sd6eu6CL4nUHoWO8s+GxQ=;
 b=IUAeKEtkpmzgc2L2Ru9DUEdDDrJp1l0WPSVC2zfF3PVbKr9iGd/415J0RV+1e2pttf5ZXdBTWcZVefhQqaMgkZSS3jny/I9z3ez0kum/wSw/MI110x7AEtsoMZh1azY+v2H18R9BDBRQsKLnP19Nup4YB5dqUcC2gLU7CfrLjPuZviGVaodO7QdOpRCC/1EEDhUukCvZDBakMjDaXfEu2pulpwuXbEzhL4POsFYvmQffiO3j9xJ2DE40GMf/XOI2KfK32tQ75KQJSfPvgbo80BU7BqtJ7VPN6BAGAB93KFH32GqWEYts5f65iobyCHyCKGvFnvts1n6p+d9606FwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by CH4PR03MB791049.namprd03.prod.outlook.com (2603:10b6:610:51a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:46:34 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 15:46:34 +0000
Date: Fri, 6 Nov 2026 16:46:31 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>, Johan Alvarado <contact@c127.dev>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
Message-ID: <au3xgDo0y17pbvEA@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
 <au3hdMxLSilNxhnK@analog.com>
 <b9778e4c-fe81-4305-b764-8ebf4ff8add6@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9778e4c-fe81-4305-b764-8ebf4ff8add6@yahoo.com>
X-ClientProxiedBy: CPBP307CA0011.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::6)
 To BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|CH4PR03MB791049:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7d1e70-a003-4e7d-8066-08df3c1d2260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|5023799004|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3+RZwjmi8WsekHE3gXL6uFannwFMQhCNwI1+uDFvrzZy7yZR+TxSJDHUGNRQotm6LaWtdDgn9yyU9xFfX7+wjMzWRacwAmkDevKQt6Q6dzZdI/IlDpmn56InFAV0gyyjlgw+S4LLbGm6V0ktAsgwKQw4zSHjwZq8XkFPO6AeapvQerRX311tVoNxGB0b+FrFA+VWtF8RRVC3wUespQqm89NoUiVB39OMHXkOPM75SufHMUqDjEaMIIyhMczTD/t0Qm8CfIlYS6IZ5jYbS3FJyBlrTG+oeEVmN9YE8+6FkEHmBn1f2LpeNztFL5yF5zW84IG6s2EdIqSg3Tso+bhhZ07/7cgA/qJ8/Wog91dxKCoBPGe3LqSGna9Qa5iZeQEO9qSRDfQmqIJ2t1TnLQBkeakuwEgODcBWHk/n3jLwljeHvpPBBHbdqHrnTYXut4390Dxd/kwfEgqo/q4eNi7t5Zbpns8U51OpuLJM6AXvltcScRC8e17/0sErQfHld1E81Z3z/e6D64KHfvzod3ARgs7rSbPLalvYixLfAPzxXsCmzPkXp/N0S9zeAv3WLX/ioS86bCny/Jjd7xOkCLnNKV7MOn7orpJp6PMwQab+ywwQaazhY7cli51FEdv2UY6BmaxIMiJV3xC/f/EA+ROq0z75eFlNbMCQyKSsNUi7YG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWZLTXQ4LzZ6WGJLRlVuNm9Ebi9aQnZLUVdDYy9YSUt4MXhFdkk3SzVTdC9R?=
 =?utf-8?B?YVJIaWVjNXowTFNTQVRramplRFZVU3VqS2k2L0tOQUpIclkyVTMvQ1J5NWsr?=
 =?utf-8?B?aDFQK1dsNDBFNUVEYUtUamp4RW5leFJDQy9MMHN2bDI0Z1lXcEJmYjFCTTJr?=
 =?utf-8?B?UUs0cDFKRWJFZzNydHlzQnJTL2M5WlRCYXRmOUVLZ24xMzlDV3ZnYUNWSTVa?=
 =?utf-8?B?SmNVRGtua1lCMHYzREJDQ3ZlUXJPQ0tzcFFMWTBEMUN5TWVyRy9jazRwaHJv?=
 =?utf-8?B?WTJ5SytCczRFZmpVR3ZjR0h1bUpwc1F2OGRFVFAvYWVuYWpaRXBUN0tuZmho?=
 =?utf-8?B?UEFuVHdPZkFSQWQ0R295MDhqME91YXpwMnN6UGtSTDM4TDd1Mmxha2orZjBF?=
 =?utf-8?B?S3kzcS9BQi9IYTVQWHFFWm9EYjJDdHZ0VTFRY3htWm5ZUXFJUHBOb2wwM0sr?=
 =?utf-8?B?NjFoN0NiSkpyWkVxNit3bFVSTVFxVkMwR2MwMkRDOW9kOCtNZk5IU2ZmSW51?=
 =?utf-8?B?T3RZQ016VFJxdEl4eFczZkZ0dEpFekJBNldDb0F0LzFFK3VBWmZTMlZKWTFO?=
 =?utf-8?B?YnRrVWJmQ2RHQjVpb1RxMGFPY1RtUWhmNC9zdnczdWdlVURnZDZVbnp5WUtN?=
 =?utf-8?B?Y2NzWGxrYnJzNk1wa0tvQzhlRDhoS2pOOWtoQllKVW1RaTZQYWtDUHNZRFcz?=
 =?utf-8?B?WGJrTmVpRnB0ak1MQVFSUmpyTlU2NVh0QmE2WlBldjRrcjBKS3pEdVlFMm9L?=
 =?utf-8?B?WWJYc0UvRXVHQmY5bzVpWEUzeDRQWWthSVoxNys1NEtCN0t6c3EwRGt6MEM5?=
 =?utf-8?B?Zm1veDFKNXdqSENkdzl3ZWhFT3B3NmJyaGhpQkxBZWExWEl4NlhJSzJoS3o3?=
 =?utf-8?B?ZU9Fc1MzTnBoVWVJSXMvZFFMcGJwV080bk1acnA4MWQ5YStkMmhPMjIvMTBt?=
 =?utf-8?B?cVM4T0l5Y3JFbFpoVVJBODlzdDVjQTVldlZDemxYY3BVVGlTQ0Q2alUyTTdW?=
 =?utf-8?B?Y2tiQ1RKcWh3UlBVNVVwQ0g1UVVuT1MwMzdCTDAzR2xtUEN5ZFhuVXA1bEIr?=
 =?utf-8?B?am1TMUNhdURsUnorRXNFbmVEaUl0aXlvSmlnVFJPeFdUU0VZNHcvamRld3dL?=
 =?utf-8?B?djA0eUU4WnBORTlocjJqRkZsSlFKRHRLYmcwRkNXaWd4Z3k0RVJqYWpOTVdW?=
 =?utf-8?B?cm9zTk1GTEdIVGJ5ZnR0RS9xeXJFSHN5WWl0R0F1ZjZMeWRMZmdFWERyVmha?=
 =?utf-8?B?MmZaMDdIeHZ4bFdjYkptaDErcWptTGY4cnIwUUV4L2xQblZnSmNrU3VWUHNQ?=
 =?utf-8?B?VnJTQkk5WGZVOFIxQU1FTGZHZkc5LzJuakoySzZ5NFZCMWJkNE5ITnNMdmRP?=
 =?utf-8?B?SmpkY0RFdlIyWUNrUWlqU2p6eTJab0ZlYURyQVBaZVIyUzcyR2lnM1N6M2hm?=
 =?utf-8?B?N0J6emJJUTFLUGlQTjc5QW1ELzdwelMyUForTDE4c1NOd1FBd0J6V2daT0pw?=
 =?utf-8?B?MHVKMk9Kalp0UURhU0plS092ZlRqUEI0ZGxoUHgrRlJFT0t0NjJaU1VheC81?=
 =?utf-8?B?MThyemtxTVZYWmVyV0UwNXhRcVp4czE5dUs4NFRjc1pyTUR2ZHMrTXRvRThm?=
 =?utf-8?B?QlVhdGVXUVpBay9KS2JadFJ4RTBVNXNqSDUrTHcrTk5HbWk3V3p0ZTI0TnJK?=
 =?utf-8?B?L1NNb0xHZHpjOGtrVFBzSnFvWWthT1MxcTFvbTJnZDZXK05pR2xGWGdlZFNR?=
 =?utf-8?B?bHdUSEM5TjdkNkprZUdpbzYxR3k5RHZ3dDgvQXF3YU5wTVhUdkI0OUlMeFcz?=
 =?utf-8?B?TXpEK2pqOG5ndDNFTVcwSEZaNkNtdXJmMHFBamRlbmVKc0N5ZVB0NjhLWXBt?=
 =?utf-8?B?UUI0TVZOa0ZGSGFQRHFqUVZSOXBjMnhZQURSeGZmTUJPRFFQbkpYSUtoV01W?=
 =?utf-8?B?RjFmdVAvS1dhUjMwZlp6aUVXaG9sSUNIbUpPUHNEZFRESUtPNzlFVXhYbTJl?=
 =?utf-8?B?MmRmU0hXbWR4cDhodTdHYXY5TzlNYm5BZGt1QmZFWkxQUDlsUmNGcVFiTGJQ?=
 =?utf-8?B?SjlMdzJCeXpDbkgvNjRYNWJCYkFoSXMyZVNNa0gycXBLNCtMckl3d1lxWGtH?=
 =?utf-8?B?REFtQTdQdldTS0twcDVRb1ZZK2JCSkJyYmd0ajk5enExVURZY3o1MjE4N1d2?=
 =?utf-8?B?WWZmbno0YVFiSU5XRUxCUGRKOGdSQXEzaHdTZUoyS3AzN2JQWFlBRHhrc3Nz?=
 =?utf-8?B?Ykl2YXVWaVZiNkxYVGxZZEJSbEl1WWdnSFVLZHFhZXhFbjAxbmRQL1RsNU03?=
 =?utf-8?B?TUZGZ0ZaRXNudXRyWmhyMVUxWnAwbHlzRTVoTTV0T2t2eWxBR3krdz09?=
X-Exchange-RoutingPolicyChecked:
	mwGdyDncPalrcq5YBcNSUIXTpELJmKALQPPgjdlPvHtsguuIkDoszqW9b/PQWorLV+GVI1hVDNcc6igmi4jL3aMocPjUaoSC2dKoH2OGP2QBnbPZB43avCf+dju6MnAO3SCjO0OAaeJI6us4uarabSvozaEuKGYinVd397BbhURilO7dxA4DgaMrMHfvCkzoT8Q2pxxZsVFUKSHlDOMS527ewRjesQVaim06KuRnlGecWmB9yOkZFb5pH0Ig1aGA7x9mJmdW/HUuMiGYN1cZ3TshAXHFlsAq6kFFvQBtNusyDi96Wv4h9YfLG+orSQ+NxslzIFfVUIS9oQYAOoCoSw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7d1e70-a003-4e7d-8066-08df3c1d2260
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:46:34.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MCizC+5Chgvxg0c0MXV3aqB4gZiiY+U8yDq537XDz7n2Iui2iWmeOyPlMQ3zRBOf0+eM8rXHcY86mSxutw02jKrv/0okCKm22x50hZH3iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB791049
X-Proofpoint-ORIG-GUID: w5hWM6EtYAI9mPUYNYB4ETMC827z5nra
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX7d4xTjXIZu9/
 upctk8KqDSmckTsDRYRr68Dhx6wJ5qXT8XYCxIHWMFT50qKigEku6JgbpF/RN7Tma6uupE2TD9H
 8tU16LyAjzKXZFzAQ7P5xuQBaGZuX3t34dCEgSzkNHBUZpt+APxg
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aedf65c cx=c_pps
 a=jqKUOoIthQ4VgEFDxjm20g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=Dzg8obJB_qxTqkk7jjsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w5hWM6EtYAI9mPUYNYB4ETMC827z5nra
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXwZSZpQ9aGP7J
 06Hfvy7k9okzDCW5yJBkwzcasCQ+XVzFCuP6RZgCOywli0F3DbHTjeCGnBCBGz1x+8mbJm4FMbB
 6p17Jr61eH1cV7rxGLV+lGYTlnNlF56jjOniTBphGX/zhIKDua3v0sxmDh2Q9o6fWuihg4NMYEq
 T64rwYzLMOa5BtMf0aZ6lQtiSNfTaxRIng0TJ/jQbSdKUM1P+a3x+EkSG9IEldnwvKzUAk9cY87
 TQhmqWNr30Lckc2mpeBLyXjiG3pq23YLwyQ+0YT6szXDy+dNtqURM1tLbLXHgS8E0Qa+7SW/DMN
 VKNeNaMG51wo37NQC4NMxeUlj9XlzqjVr0zhcKZKyYmM2fMUgrL4Md7V/ANOmBNutfq/AWBoz8N
 YgQGcKiynvCBqYK5G67tVYvPn0V8sEFf0mKXlSIekFVxiT/3XxpFU0DY3CohckNj8raS3wmwaF/
 X7ngRnZThvNzS/NA2Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060062

On Fri, Nov 06, 2026 at 03:56:10PM +0100, Mieczyslaw Nalewaj wrote:
> Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch the family D SerDes
> 
> On Fri, Nov 06, 2026 at 03:28:30PM +0100, Alvin Šipraga wrote:
> > I don't understand this at all, should it be obvious what you mean by
> > "edge" and "latch" here? I would assume you are talking about interrupts
> > but it's not clear.
> 
> Sorry, the wording was unclear, and no interrupts are involved. "Edge"
> is the SDS_MISC mode field changing from DISABLE to HSGMII, and "latch"
> is the SerDes receiver locking onto the incoming signal. It locks on
> that change, not on the value, and only if the far end is already
> sending.
> 
> > Is the shortcoming/issue you are addressing one of DSA when a SerDes is
> > used in the CPU link? Or is it rather some hardware oddity?
> 
> As far as I can tell, a hardware oddity. If the change happens before
> the far-end MAC is up, the receiver does not lock and nothing retries.
> Both ends then report 2.5Gbps/Full while no frames pass.
> 
> > Can we use interrupts instead of polling?
> 
> I do not know. I have no datasheet, and the vendor API I have does not
> expose an interrupt for the SerDes state.
> 
> > I'm basically wondering here if this is not something that DSA or
> > phylink could help with?
> 
> pcs_config() and pcs_link_up() run seconds before the far-end MAC
> starts, and phylink never calls rtl8365mb_pcs_get_state() for this
> port: mb->pcs.poll only arms polling for in-band links, and the CPU
> port is a fixed link. The only event I found that tells the driver the
> far end is starting is the CPU conduit coming up, reported through
> ->conduit_state_change().

OK. Unfortunately I'm a bit out of my depth here, not having worked with
SerDes links before. My gut tells me this patch is overkill. I hope
somebody else with more experience can chip in. Adding Johan to the
mail, as he added SGMII support and might have some opinters.

Kind regards,
Alvin
