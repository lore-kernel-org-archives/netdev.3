Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794572703;
	b=XWVL2cxyqfUtdYX/yUGw3bBLugva9mgSWDO4kJRslortRxwvSFjfyGfazBawvIyDqodU
	 +tHFlmd9oj4FQ0AzvU0LvqyMIoJU14FGK2xjBIo8fSmegJl3NuoY0ifXL8GttgORAkzMY
	 i9XIynpr9YBSbIlr+tNlccEIpcgUm9VOMP90Ap5swPnxVz4TmqG2PQxDLc97eq3FhjoPw
	 9FnxIHddRjokuRvUQxCD3Irh0CKmywtV1gadl8sdDoAf3I05NY7vkVbNXN6vDY6anORj5
	 JlSFW4hALobmqaAf6hQ4VLU5b0bcazTqBAvKby+tzgfUBfleeQQHZtFOJEfc9qcK0ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572703;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FfSWasfeQrBBHrIaETsamGQsiwzwfJHJiyzNT+9Idcg=;
	b=3UBHx8b35/qGDf9AIw9ZzYnVpLdIy1WqykAq5LUKYdPJRhSybDkuWc85L9KJeeIzN67z
	 sVwanWOjTmhZKFjvHWHgTFtUiwz1Qu0v0FyG/oVvjP+8V/w0meTg8FOPvqnn2d0mIsBSA
	 BwQSgWAHgNicdYtDZsbuGBkuH2qs2HSqVpMvx0m4O9zPPHUqleyeCEOjYVaQKAs6et4N3
	 9II/G3r6xZ9MswlU5qo6ucZakiSBMHgWXQeAADNCN/0FjtqgSAsx6bFTKWYnwo14WeX6t
	 MbdG7jh7TQdO28N3sPWIJlX8FPBnAaAkTmjy+/9cSd+1ulOgm5t1TUbNXlV1aFF7sGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=l8N5wXMl;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=EBjzEhyc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9488606A323;
	Fri, 13 Nov 2026 12:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9488606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=l8N5wXMl;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=EBjzEhyc
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC1bvY1495938;
	Fri, 13 Nov 2026 07:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=FfSWasfeQrBBHrIaETsamGQsiwzwfJHJiyzNT+9Idcg=; b=l8N5wXM
	l1WbVbUBIGJJf5rZolYQMXMGqvqekk6ODr3MqueoH1496YJxgnbxvo3Rh66CtfI8
	+ZXhSuoKA39BvA/fAAJifB83mXbc9CMHQTBkp6MQCbP66mzaa6AykYpDm4AwvYVx
	zlHDggJaw9j3yYWe+Iz94F1geuDXZrGu/577OwCmwJb9wJj11L28PzEb/dxmGa5F
	IR1eWZdNCmTyvhoHSovApwuNfvbB+K2CEt+G+eaytXRVfCKHUowBw4tpLxqxEFgY
	3hLr4IcBJC+CO4221UaGYul4/4yvAtFTIZB5kABvzRAxv1PL5a0lDg+pXcO1jN5r
	nLB/fYTd1BEHASQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FfSWa
	sfeQrBBHrIaETsamGQsiwzwfJHJiyzNT+9Idcg=; b=EBjzEhyckuAA494kI+Kfw
	eBFqXP8Q+49Y3B4rxKmvoBigm2jEQPNDKIv92neYbTajGR1rNK/iWuWO3DMpzoNx
	E1fjLPaUOOeWJazrYoyCkgAILqXC77ZbAGFF2Pn/oVzhC+aXnH0lonebOK7JZKZi
	C4mcaCKJNcS6wb60olfBcCkiLrg+goRifMcQaipRUSzJDwOYUnKOoEwASZaaDBqU
	1FCVwlIEMVzo1Dyxv5YxoRyKn3vyLob9i5tIix3klQSx4Fd9tUEl2Kdwr8C9h2aN
	H/PGXWrULumpQ1cEGIQ0d7J9Ce+qzTH5soSRRhXI4noACRCEBX/eNmd0A1VE1bZ3
	g==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hwme2ts4w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 07:24:45 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOgSwlLnzUDWEG4Fw7yqAAhIm5+xiI995aQ6TSDWUw66WjI+/4orTxQzqSFuhR0Wk7AdxqH+wt+LZpAbjuHqc8MJjNdalKCkM6esShUdOMHQzgm6qeW5wTsYqK875n3ilRKclTQwpQWb0G6Cm9537tmsAZJwGZrdRh5DVcal1QYhyOjmP5hELCGnIzwxovsATEhdBEXG51UbC4yV/o+K3cqz07Jz6IhKuDfI5nD2wbPOTXgN8X7OymXfrjZ889S7Ql3p42Tw1FVsHY+vBX2wo+Ithg78gX1iL5zkMQFO7RID3+gKrQd/41PHikk+2FpPfiszHuxRMOxalY4dq+m9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfSWasfeQrBBHrIaETsamGQsiwzwfJHJiyzNT+9Idcg=;
 b=wGorGawwupWWe3vcPnEQKhs3P0CZ9ebxAMSrHH7Ds+catIFyOGqJZ1xWp0leWLG8LgELMDeLVWdxObEwzVm1g2yHum78byEC3z1XYLpMH1FUhwxKrAI6UFzb+49544X9ZY5/ookvCY7k3YlmaG6WLg6uzTAXTeG646n2Il6zikwmkzL84HFwxkzSm38UfZEJho6MRQ1deNG/aaOhyYtlN+Tt/aALrDGFnXJX/1K4GF/kmUBS4Olabz0UCJotz0pjEg7oX5soNcban1sAKcGEkYxmGY0FIMpxIyDt61bj+OSpO37+9K+EH+9bRqwxGLSdMw5cJOZJdgPeakE+LXPaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by DS0PR03MB7204.namprd03.prod.outlook.com (2603:10b6:8:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:24:32 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:24:31 +0000
Date: Fri, 13 Nov 2026 13:24:28 +0100
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
Subject: Re: [PATCH net-next v2 00/10] net: dsa: realtek: rtl8365mb: DCB
 ingress QoS offload
Message-ID: <avbP8aF77eg1iCPR@analog.com>
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de>
X-ClientProxiedBy: CPAP307CA0012.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::11) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|DS0PR03MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: c30740a2-6d53-4fc4-5a65-08df418111c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	APOPoGXnxdt2LRrhj7I435Hh/OJWMxzPKzrQ9gQZtQbv5lzG0dvBfpIAs6mInAy0YjZepIXDJ+koniaDe1DEEhUoku+wyhk4yoLPT1ygUc+7tlVWsQY/12eqqFi4hZV1lykaWB5DcYXBFThvCbZCiVPa01O7tSfbRpLkAhQAgYphU2n8vaYOdDkTaIzz5/NN8n7JHuk/gQ/2T5NQnBKia9Hl7EEahQws+uvnWrVJyp/Jzn812kacomajWVJe5gxLUdfA/24OrqJzUBuW9lbybOi/N4PJ1klu+7nRhfpfiO8TqQnRpq7qDo/z6Xr+jCYaQ5M3Dy8Fg/rXYXhQzGqkym/olUbnRcrB8ZZN0OW5QGJR7CiHLOlEBRyIVd3PN1VR8nYh8l3whWp1pbMkCXE2Ctjlx43OWNknHuAkmUNPalHdK+UcakYfKaJQsGLd8VUMHE5wI3TIARaEjh5QRyflwvc34Wy4lpbk4dapR8MWmqhS1xyKKm8L2THSXvsSOAl3R+SNM8wvo2gHDRWpHF3jMHPGGcAuDp79EFRmTGJ6gAcoKv0yaNHhMXTmekpaw+fjk1xo9U+890AVYxL3I/ALgg0q1UZCP/IA6iBfGaMRnKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWhxcUxtRy9sRVNPazdrMjJpOFdtR0gvYmNsV3ZSQWlBcCtzSUhXa1hYaldx?=
 =?utf-8?B?YUxjOVJlMStqc1pwbnlGMVljcHpyY05rRHR6S3ZLcW0xTGl1Zi9yVEhlaFdW?=
 =?utf-8?B?aVN1MEFuTHIzRzFMTHB2VmtFS0toeDdPT05pV2s0alpVOHRHcXl2Zzd4KzRF?=
 =?utf-8?B?QVNOeVI2dkhDMFNJaTJaNG8xM2NnU2ZlZVh1QW81YXB1T1k3SHY4cE9IcnZE?=
 =?utf-8?B?VTJXNTJRZWlSbG4vdDhBVjNFbGhCRzN1cit5d0x5cERranM5VFJidEsrZXdO?=
 =?utf-8?B?STRRSFZZcGFyUFVzMTdaSk5sdzY0YWhaWUtTb2ptU1FiK1k5S0tqOVJ6aVdK?=
 =?utf-8?B?cU9tQVZ2UyswZ2pORE56cGpXZm51NStkN1F5eUd2ZnluclVOZmdZRGRpUm9h?=
 =?utf-8?B?Vno4ek1GUWR5VXdlM3dXZVplV1BNcTBUUTJMNGh1WDZvQi9DNlN2VkxDY3pP?=
 =?utf-8?B?aUZpbFNkK2NYZS94aXpxSTRZa292TXZCamVDUU9pMzhqVFRWRG96eDhiZytz?=
 =?utf-8?B?enBScEJqZVAzUEhRU1pUUXNHeGlSTzhhdEZMbXNGSVJVSFhSV0M0TDVyNWhw?=
 =?utf-8?B?WlFWVEFSMkFqZTU2VUoxdlYybDFYR3lLZFZIVThaRUdRWmIrTmlMRVlGK0NU?=
 =?utf-8?B?UDJiNzZGSUEyc1ArbXViblNtV2QwMWJMMmN3RFVjekxPVTFlT2JtUFdrWlRI?=
 =?utf-8?B?VHlydTg5ZUFka0FJbk90Wlh5Y1JxbWpLanBXdnRVQitoN1R0cWh5bzFVK2lE?=
 =?utf-8?B?K1FSczRvbDgzSklHemNTclRLZTlud0xUdkZTWUpkWnFvZWNQOGliSlpEUXph?=
 =?utf-8?B?QnpORkxmNXV4VnF6VU9Vb0F0aUlMcTkvSFllWGlmYUdMdmZNaVJ3dEZ3YzU2?=
 =?utf-8?B?bURZeDZaRzZ1QVNKL0dLaVRuSHhMMThDMUhaN0NFWit5MlN1aC83bllIMDBQ?=
 =?utf-8?B?cWNJVnI2eU9nTWlnMGtGOVEzbEpUTHBPdGJsVTdMaStNTXg3b2JmN3lWR0d5?=
 =?utf-8?B?T25RMERUdmRjNzJPTG05bW8vQWJDbWJadUlaRm9RZDVrTEx0ZnMrNTV4a0tV?=
 =?utf-8?B?dVozMVFGby81dnZWYXpYM1lVMHRmWklHMUNsNjZvSzgrODdzY0toUGc0dHN1?=
 =?utf-8?B?b3h2VU9jbUpkck9nWGpEenBETWZFSjh3UFBSeGJya1FKa01MNHhOVUxjQzFp?=
 =?utf-8?B?eWtzbjhXUnNXMDBGQ2Y5TnBpdGt0emtWWHZ6NXVwQlVZV3lTamZ6amtVeG94?=
 =?utf-8?B?eU1jVzBuUkIreWxJTVhDb2o2QVpzYk9mM3Q5N0Vvd2RqaTNERXlSNTV1YU1D?=
 =?utf-8?B?WDJqV2xpSmVuZC8xeHJJNmhjWTdhOTdTSU52Tjg5RENWOVNEQ2t1UXl5M1o4?=
 =?utf-8?B?Y3BlRVlDZlNUdUtrSHMwM1duRlBWSjByM0pWUUdVNloyOVYvWmx4Mlh0RWJD?=
 =?utf-8?B?K0xveEV3MGk1TEEzdENmVW5rdHo4aXJsQU5IWU9vd3ZNZFZ4ZHpaSjBKMkd0?=
 =?utf-8?B?TmNYcGJpL3R5NnBqNGNrMjRlQ2dqR0dPMEhaeWVrektZUkxpY2NUdmM0SVlh?=
 =?utf-8?B?SnFPZUhleEtJOUl6WVJuM3ZodVF3Q3JSMXhDVS9Fa2FpeXErVWRWU0luMlRM?=
 =?utf-8?B?dmFSU2c4eDdCK05DU29EZ2hWUVRqU0RrQzlGMWlDamI1QmdpR0t1djZKblhT?=
 =?utf-8?B?MGIzOURRUGxtU2poRU81VE10b3ZqKy94c3RWWFFzeEhlSzN2UjFqRFN6c2ZT?=
 =?utf-8?B?S2w5VTBMQnpTZnFOcGNvTmVqenc1a01lVVVmYnZNZmo2czVURlZhQ3ZtUkhr?=
 =?utf-8?B?dGdOSkFOY0VuOHF6YllXNzJtUlNLUDB6dHNuODBUM242cndjOFprOTNKQTAr?=
 =?utf-8?B?ZU02bG9pdys4OUd5RmQyZzhQYk9TQlpCSkJMbzN3VklJa1A4dVdXeGhmOEN1?=
 =?utf-8?B?ZVFTUUFCSlErdkc3cUUrc2FWOW1jc0M1L0l3c3FTZ1lUZGMxc2lFclRJU09n?=
 =?utf-8?B?YjRQYXNPN2Fpc3B1SGcvOWhWdHlzc21zUVF3YlFtK2dSbndpSHpjcnR2TE8x?=
 =?utf-8?B?bWNFZDRKVTBCRU5ZRkl1V05MbHhFeCtZYTNoUGRCOVdWbm9CcEhXWm9DTEpj?=
 =?utf-8?B?MXNSUVRxZE9oZExKRVNyRjZhdGtRbFlBRTFVencyY3VNc2JZN2RQOXRkUmVq?=
 =?utf-8?B?bkg0TDVGSHFLQjkwVHVOTC9EbVVuaFdtMld1UEdiTk9zZm9Ed21hc0tibG9s?=
 =?utf-8?B?ZHdhRzFJR3pER2IzUFg3dG9iTCtyMDl1ejVuVFh1WTlsNHY5ckRkaU5qdWRZ?=
 =?utf-8?B?L0lSVkZFeUNhaTNIcFRRcmduUGFoQ1NxRW5RRW9QSnNIOGo1WSt0QT09?=
X-Exchange-RoutingPolicyChecked:
	wmNp6C5sNWxp9Pn6Ge3KWmnzMMSksUxifBoprR4y1ybcMBvHhUDEdKAXwRGDGhU+5B7gAOWdi1QZrKsy4Fz/+NLM2aJJ1em2/GcNdVcGWUF0zyqxh5qFy9eEwofx4B03eJ1LsHJphBg5juITi9lKEET5Phv/xRHXrdVHQOq25iyVuSrPyIjY61VryFO80kSqW+AvcXwccBpX7JfOehGBdYA0X8Xd+yMf8yk7gHT2PpCzKGe0lyE0OjSilaj8l36JXK9V4Pv5nn5Zc6Z9+3XAMbJVvXYW3BRWOSznZH05ls5kcDGoOe6NKRyH2areoaj2K61E1Oz0DES8jcxOCjWQCw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30740a2-6d53-4fc4-5a65-08df418111c2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:24:31.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S66z3hlXBUHnKFfIzK9B+3R0HhY00zmeKlRpIs+LFzP4eE4VEInY4SyUCMdHLiL7QZYh+KDISBqX4AyaScqNRd/d2bh2JVt0NPkaEquFKoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7204
X-Authority-Analysis: v=2.4 cv=LvkHWXdc c=1 sm=1 tr=0 ts=6af7018d cx=c_pps
 a=aQYToRbhQZUme44wGBfxuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=0QBom4ZHEOXMRbJdT4cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0OSBTYWx0ZWRfX7lnJVoNDjdQM
 8/kpPxxG30wqbkUhaRJOBQJQqmbYVUQKMCiIZeOk2e7iOSYryrtoqEygEex2smXdjoEs8SZr+BD
 cD00v0hy1eMxdcJRQqk5RycSeD2qHfDqF5vSZ22M3wWkNukRBjdT3P8+1citHFc5gMV1uU0tE9X
 ut3kTUoyLQ/xrtkOiULR4OTf+Nu0rBb2xu8EYzgxrNbC9CR3rjDbaDt6seADjgFNUN62xQITYDA
 q+q9dum5KBskwHLm2E6L4rCcbPXinWHHO8iBFu+Yu0Q7GQoonfgqo7VzCB9hG6YpWLdTbrY/oNT
 4IO+KyWx1Z17HxSVGhSqOMcUJFF5iBbEConZlsZSHP5SXkHz2ZwpE0q9Ya7Yw96+VjndVEqbnVw
 lJekoAby6hnrxQ+g1Qn1p+KtSqD36Kp4G0TE4e1w8Co1yyB4pVOHRfym0m9Jr2UumJIJsbDSANK
 idOULPeRrRAtZLmRS4g==
X-Proofpoint-GUID: miB_JE9UNydmSV05FF_VFm5WDmJUhf3n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0OSBTYWx0ZWRfXxy8D7jWzZpNR
 NXZPMEt7TaF6qeCBQQDibCykgPC1zFDIfFhTdUCoi/Kuhk6LzL/Hmb0tFnUJ1ILbnlgjJfq7DSl
 XiaqpGimJ4S+iDF7nj9AlaZKJNUZ82me3+2DKug/eaO1FsEQJOkb
X-Proofpoint-ORIG-GUID: miB_JE9UNydmSV05FF_VFm5WDmJUhf3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130049

On Thu, Nov 12, 2026 at 09:37:43AM +0100, Oleksij Rempel wrote:
> Add ingress QoS offload for the RTL8365MB switch through the dcbnl app
> interface: a per-port default priority, PCP trust and DSCP trust. The
> mapping helpers go to net/core/ieee8021q_helpers.c so other drivers
> can share them.
> 
> Two changes are visible to users. The driver now rejects a devicetree
> port that the chip does not have. With a default priority set, an
> untagged frame that leaves a VLAN-tagged port carries that priority as
> its PCP.
> 
> Tested on an RTL8365MB-VC with eight queues.
> 
> ETS scheduling and CPU-tag pre-classification will follow in separate
> series.
> 
> v1:
> https://lore.kernel.org/r/20261002115850.962676-1-o.rempel@pengutronix.de
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Notwithstanding my other comment, the whole thing looks good! So for the
series:

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> ---
> Oleksij Rempel (10):
>       net: ieee8021q: print traffic type and queue count with %u
>       net: ieee8021q: add pcp_to_tt()
>       net: ieee8021q: clarify the tt_to_tc() traffic-class mapping
>       net: ieee8021q: add tt_to_pcp()
>       net: dsa: realtek: rtl8365mb: describe the ports of each chip
>       net: dsa: realtek: rtl8365mb: store the egress queue count per chip
>       net: dsa: realtek: rtl8365mb: add QoS baseline and DCB default prio
>       net: dsa: realtek: rtl8365mb: program the PCP of untagged frames
>       net: dsa: realtek: rtl8365mb: offload DCB apptrust
>       net: dsa: realtek: rtl8365mb: report the DCB DSCP-to-priority map
> 
>  drivers/net/dsa/realtek/Kconfig          |   1 +
>  drivers/net/dsa/realtek/Makefile         |   5 +-
>  drivers/net/dsa/realtek/realtek.h        |  32 ++
>  drivers/net/dsa/realtek/rtl8365mb_main.c |  70 ++++-
>  drivers/net/dsa/realtek/rtl8365mb_qos.c  | 507 +++++++++++++++++++++++++++++++
>  drivers/net/dsa/realtek/rtl8365mb_qos.h  |  33 ++
>  drivers/net/dsa/realtek/rtl83xx-qos.c    | 209 +++++++++++++
>  drivers/net/dsa/realtek/rtl83xx-qos.h    |  20 ++
>  include/net/ieee8021q.h                  |  21 +-
>  net/core/ieee8021q_helpers.c             | 103 ++++++-
>  10 files changed, 979 insertions(+), 22 deletions(-)
> ---
> base-commit: fa5196392691051963726787944db872420dfa75
> change-id: 20261109-rtl8365mb-dcb-ingress-0dae31a02c0f
> 
> Best regards,
> -- 
> Oleksij Rempel <o.rempel@pengutronix.de>
> 
