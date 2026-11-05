Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882416;
	b=e0U+TwHNCh7ZxBT/vVYHkPEe0i6HapmRXnsfaET5+PdWtg75Er5HD1ItcTItrZ7wmIoT
	 Va3UGauI3qdFZ7/LhWB/KC64nO7h36JJjhpvEXLtZNwyE+7+B3taKMbn/CjGiu25GN80t
	 yi8+Gts7pQuNe04NjsrfvViLjt6/cOPdBQwHLNseQBJO8mRuiWVKhsk74HsqGNF2k8g2g
	 uWYHDeXDKBk2ckWf4SoF5/RNdUXuclrsU0EX+wKko/dtHOSkMlcBEj8eRcfgXmG4AapyK
	 2eV/bikxUOscTefEEZWBlENYsZB92GpezOKtTK8d/NrH1agOnawO9l6UyVa81io/x3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882416;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bTifQbuiWwy2Jn1Noi3KqrIWtkQI/ZpjnNMowoXYMlI=;
	b=YRu99po0IRfwrR/CoYHl67p7fWjws46gNp2RYG6JEu/y6kEgeFWYRMIJBScb0nV3PbAV
	 Wx5euBnTajvONgZ+LbpKs2oCybNZfwBPAHc5/op0D+juHZGBf7fdOBA0YQwflYKDGQEmF
	 PUgH3Z4XQNhax5aW7k9n6XOVr+Lr0K5KxXko8H0SCWPrlKb2jXshnylIO18qvSADnJsyB
	 jzmR+ExHsAnh8D7zGzqb8gW8S458gg3u4nz09Z3Pu4gQqWLAEjfidslDEsoayZitv2h4y
	 pWZJrEgnTGhLUc/ZXlsp2S087/aE1+n+jofLjGz9b3JpYt1kE1mJ1joAcsJrA1wOXdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=KxO+9gZP;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=WDaK5ifk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D8606A334;
	Thu,  5 Nov 2026 12:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B42D8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=KxO+9gZP;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=WDaK5ifk
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59vg6c1424282;
	Thu, 5 Nov 2026 07:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=bTifQbuiWwy2Jn1Noi3KqrIWtkQI/ZpjnNMowoXYMlI=; b=KxO+9gZ
	PDjLCoxLuONyGVb2x/lRdBDi8F1AwS9FzLvohzhzy3YxqJqsz29kU31/Sv9U2o/Y
	l7YP64iHyvHeh/wezsLkX0f/EKZPjN2piQZL+qXoEQaF5nZP3/MewmLQLYnsSugZ
	h66floMYdrgjj/PQ3pbgNZzDvZRW0A1A6U5XxE/BppuCwam6tChlMqiByrt3y4yS
	sTuqzPk5BR8YE8syzRgtH8S24EBlGZjHgUHpu06p/NIH/e8M1SQgPNcL3m/UllIS
	MA3gyvN4TL6pWAz4zp65D7DUx4I1T+Q0uY7fBz18HYpx1uGO3tk7hRQbU5LbVnTa
	tlfM6S7MMwakoMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bTifQ
	buiWwy2Jn1Noi3KqrIWtkQI/ZpjnNMowoXYMlI=; b=WDaK5ifk+h+Bqcq3X8fWZ
	W51mvLeR0YJ1Oxwzuj1nHqR5fdCOr42I3tioGheBAfwy5KT+8Ci6SPraILE4gZFV
	HfQLcaLo4kKND1AbfOrDL5Q5pQVZV2XQQV0BZYZNfcvl19zD/0MljZc3DsU+SKPL
	VAWjZk713sktGQTIfPYaV3FSgLFkExK2EzrjA96gH6MPF0GKk2Y72Of/GRTbsxyx
	v2Z52s+CsNansFBy8jIaS8fD6y1EIVV53GF9Ue17wGHjzgtTTebGZL+uA8OtCQBN
	dao3qabMhMOTYM3EQYUPSWlA9UCT1i8uM3ytNSzOlk2fjqgKnMMCfWvbsC0id0KN
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hre3mm512-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 07:39:58 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx6tevjfNhZAp1xxAnG9wPTHzGgE6oomKq9VpOb04APQnmMyqQ+CmMv8aGZ6sYLPrj99xEQZMFPfrtuJbrJdWfe5h2mk0UrpKYcyebQ7ZikQMVDAY5emmnxQCv08pDsCorIZNaOaglnjVAlA7GDVzhyrK2Y9MscAjUyfw4++JfeNA4a5E+4WXFKcsiOa2DpiSzI5yZyqDZMcZ5rB4Rx7pzaOvcGHDZjhzhoZ9a/gJ6wP5JVD69td1SxOCcqTedLxqUTnl/yC4TRctVUkHip4WgZZOE8GPq49hOAHjqEPavRzsPfAm+84A+rPjONEi6O8qHUnVw8IHRTCCwtzTJj7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTifQbuiWwy2Jn1Noi3KqrIWtkQI/ZpjnNMowoXYMlI=;
 b=boDERIzJ15vA75EtSqzbkKdoWn6U/qahNc4D69zKXKlRMN5l6XlQzGfWrW5DZsxpWWuF7Ds+6AXBylgf97BRh8HFx8zWkr8oJd7WtLjZenWNhr8h0bVfTiK10jq0jyHxHnDXMivgoox85iWWP7e4trlL3y9mokUWk9tXwT30usBNIIggkrlfc04u7EEFtg7n4DyNVZnkT40MNQmkRmBulNDyxIAvENB2X6zOp3vlWmsVAGYE1t4Gpwq7PAY6cpwnBeEtJhwtfay1XPCK1b0Gly6p5IfAHfAa3cX/k2tZBt/Y0SqhiwFPiUMKpfC6BktVAl1xTSJkxveFhpEMUBunFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by SA1PR03MB989247.namprd03.prod.outlook.com (2603:10b6:806:4fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 12:39:56 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:39:56 +0000
Date: Thu, 5 Nov 2026 13:39:53 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set
 RGMII mode for family D
Message-ID: <aux1v3R-efbWF2GD@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
 <auskP2mSY4sCRa6x@analog.com>
 <82c96971-be5b-4c11-b20f-c4b074181515@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82c96971-be5b-4c11-b20f-c4b074181515@yahoo.com>
X-ClientProxiedBy: CPCP307CA0008.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::10)
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|SA1PR03MB989247:EE_
X-MS-Office365-Filtering-Correlation-Id: 88635437-56ef-4523-dcc3-08df3b39e59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|22082099003|6133799003|18002099003|3023799007|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	MC536B81QXyiBZMO0Fk0LRAApYBtku0V9nubWf/99JysNHGzTrct+SoA8Py+DVS2vnT7c4sAKWEKOf06UWQzcqHshdYxrjx/11BMJSbjjhizJtuIcbajvB6B6Yc6W1MkXYPqkqIQmALm6h1s/xfOn2MYf85lzkWcYBWB7hEvgsgV98v2XnsJmBg/4tgHm02ObGN+nXa1Xp3qlU2dMHz/aqZIYQjF24Qh9uV1nFjjw1N6atK0zCNXsuX5Ys/XZ/mmPy9b6L1B/eDQMu7mI24WBPRvAi7If5mpoTHV4tSVkdrPWCeqR7vyC2LBCI/hn4Zn6493pkyZrU8wJ0lNIsOBenErJcsBzp+M5wMyDAfL+Wp1mGm+LJ3bHQCQehedjuIeTPVgMdp8SI+BYNFExadty+dZ8BGMAjbDc4gZHN/nP5uRth5U2DSo4nVP5sRE+kZgARt+1UMjHBwIhKrC1u92hh/NYoCFw6T4EKSzy+2nPXE0oR6ySMxbYTFnu/hn8/F9e6Fm4L7RmYp+RmQhZYzT8aWPe+TXcEz6t71+5mGPjuTyqZ16bJpXkxPStC9V5uU0FyiPJ7uSo+rp7KX+eCMcdi4nV7itV2vd6Hum6ANGEjjlbFk53ZCBZ85WEv8AI1Sc1I3kQTBPv7bBYMfy2h2u7K1/D8Yt1dPZUdv1UV1+7To=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K05LemcvczhmQUY5eVZOWnJBZjR2bEJSS0hLRkVRd1ZIcEcxakhLMEFIVGJF?=
 =?utf-8?B?VW94djVoZVR0WFNMZHl3WDg4U0JxVmV3TTJDVU1Bc0VMazhmaDVYNnJXSUQ1?=
 =?utf-8?B?elpadHowcVZNUFFiNUxmeHZKaUc3S0ZKR2Q3YUxWOWZkNTlaQ1hmRU1HYVpk?=
 =?utf-8?B?eW14a3hZYjNyMU1lbTRiYXlSRks5ZjY0UGJibGFYV0lISWoyaHQ5M2JZWjhH?=
 =?utf-8?B?YUhKZXFxSjVhTUg4eTExSldsSkR2V3k1MEpSamVNQzlzVXJ4RVhQaUxqTXJN?=
 =?utf-8?B?LzFYWVB3U1VVeFR4L2xtTElxdVltSmwwUEZiajdBdlJCVzNmYnZkSnlKdGM2?=
 =?utf-8?B?MXgybHJGNHYxaVZYc2hvV3g2dDZaVlVJN3YrQmdlaWdFaHpCd0wxL3U1Tytk?=
 =?utf-8?B?VE04a0tXaHZsUUQrNXkvWlhkODVWVFh0Q1VsZlRJTnJLTktUOUdFNEZUWkxu?=
 =?utf-8?B?MTlIeDg5aUFjTjlvVHdPSFdvOWhBR2YxNldQWFAwRks1Rkt4c1UwSHJzaFo3?=
 =?utf-8?B?V2dnN2dwZUFHd0VmQ1FyeXh5T2lTYzM4S21FUlZwUEZXblJRRFBReU1MVnNZ?=
 =?utf-8?B?Kzh1Zzdqam41cTNQUXMxanNrdC9EUWVXam5HNm1BSlVrNmd0ZE5BbDVocjFk?=
 =?utf-8?B?YW1kQU5NM0xGdnpsSWVnSnZaa1dTdEZXZWYyTlhvcU1sQkFoSkJOR1pEYjY2?=
 =?utf-8?B?Y0haRG1jLzNxV3FCNFdRMmtGMkUwdjZZVHoyYjAwaUhJR1lpUlBsQzJRaXNu?=
 =?utf-8?B?aFUyMUJ5bEtyRlZyZldwVnNrV1RQQTNqbXU1bDVRaUlKaTltY0h2cmY4ZUMr?=
 =?utf-8?B?ZTUzMUxsc2lvRnUwOGFDMVdaWDVuYitFZTg5MFk3ckM2NStCSGNCd013Rmc4?=
 =?utf-8?B?YmJ0eWlsNXR1L25wMDVRYzZYQXJ2bDE1bmtSWVJMV2l0ZXgvRVhzc1JpT3dU?=
 =?utf-8?B?UUlBM3JXc09pSkxGdnNleDZnVWlxUFl4dUozWEdKUEptSytCb3pyVGE3aWVH?=
 =?utf-8?B?VTNkcTZSVzFJVVNPdWdVckdreno3Y05qdlNBdTMzd1hpN1lrRk9tclFBS3Ru?=
 =?utf-8?B?K08zelNpa2FycFMrdldBOU9UTjFGVkdobEwvbkJQL2JnNnEvaXliQkcvNEJK?=
 =?utf-8?B?VFQ2NEM0c2ZKRGZQc1ZSTXBiU2Ntd3hzeitOdWJSQm9yVlVMQVpSMnRRZWpt?=
 =?utf-8?B?YUZ6ZmlrUzZjSUEzdVNuYWdOOTdCWXkrZlQ4SDQ2TC9ZenBYUzVpeUN4QnBz?=
 =?utf-8?B?SnlnY1IvSVlLQ0czaUN2Y2ZPSFNhL1Y5YUpweWtPMjZlbEhSNitSb3BTQXlP?=
 =?utf-8?B?eWxnb0dtbTNkdXBDeG12VCsrWU9Ray9YeEV4NGFiL2E2WmxYS2lreUFiVWJt?=
 =?utf-8?B?VFJRUWRVL3lhVy9XK0ZPaEFHRzlPTVh6NEp6Vng1NlhCcHFrMGE3dUJkVkRz?=
 =?utf-8?B?NmxPTUp3aS9DVnhmQ2ladXRreFl5YmxpRUdBamh2emJDTExYYWhjN0Jza1Bi?=
 =?utf-8?B?M3NKQUpSZ1Z3Ky9vKzc5RU96Z0FHVTBDZzNwYVpGUVhZK1hRVjE4L24vb1Q1?=
 =?utf-8?B?OGEzL3lVS2pGNStYRERzVnFNOWZIbFF6czBLODFub3lIenZITnA4eUhYVGJ5?=
 =?utf-8?B?ZEc2LzZ0ZmlhdFdQK1hoRmFtaktpcHZjWER0VU1MZnV2M05TRGVKYnZvMDMy?=
 =?utf-8?B?U1ZjdHNqNzNMaHZUck1lMGxwN3BySEUyblNCT1Z4TTBLQzB4UVpuWnVPRjZF?=
 =?utf-8?B?c3d5RUx0NG1PR240OHRsOERjMXYrbFIrL1ZUb0hlTnp4Z3ZTSUwzNnhSOVJT?=
 =?utf-8?B?bGN6VmYzdGZDUDl3d0FpekJTdHNHcVJvUWFwSkNFN2I4U2V0dUpobWVTSWt6?=
 =?utf-8?B?Y0tsbFRUTitCYmxFeUNBVFBPbW5BSHNFQVVoZGRaQVJGTUhtVDhBZ3paVmNo?=
 =?utf-8?B?dWpmelRQQldPVjFndmppSDZTdm9zYUNlbWZSK0VBZUttb3dORE5LRlpESzM0?=
 =?utf-8?B?cVdoVDRoT3B0QThQME9ucjNYZHJPcFhFOXdIUDl0YXI4ZXNqbkF2ZHd4U3M4?=
 =?utf-8?B?RHRWT2hVUFdla0hISWQwRXVSRzI5TzhWcnNtbHd2R3pJOUxiM2h5VTJ3MzBH?=
 =?utf-8?B?YUNZT2orYjVRNmoweERjUHEybFVMSXYyRmtYaWNjb3ZranJnNzdYSkJvVFh3?=
 =?utf-8?B?RmxWWFBEOGUxYmZsTTJ3azBtaGxLMEcrVm1EZWdDVG9uc1c0aVQzeTFQQSs4?=
 =?utf-8?B?cVh2MDExVWx2d0ZlUXZwVmd1bTE0N2FLZ0I0aXBJR3d4dUg3NVhPRGlsb2lS?=
 =?utf-8?B?cWdQOFRNdGphdWd1QWpmdGZNTHBKK3N2UlgzNWJrSmd6b2tDUXY5QT09?=
X-Exchange-RoutingPolicyChecked:
	x6t92Rp1+JjYDGwGHI3zHraUuBywM5DQKOYsfpGHNHeOSvPQBlhAMSYyrMQRGQmVH6bxDJ4bX5H0e96sWs6TqpSE0hyD6YIG0e85pyCZJsENJ2/81H44t3Zh2zq2KZ6+MOVIDPvhAjY/epJIuu5F93xf/Dm0WvdC7H4N+kQUJ6CcoSzxoOll9IQrbc9r0XCGZ1sPCDmGDDl9HrN26LKPAOIdo3w/+ox3510+h1bCJwiYRaUvPaRmmXL+VfdmQ9pmQIl6QwWZY7mCoY0NTyZsFtwGBhN9hey9mOYOKfAE7ddcddSIoRX6BBEyjtT9JwPyIud+yje8fwujZ958NtDrCg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88635437-56ef-4523-dcc3-08df3b39e59e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 12:39:56.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdyV3uG6yu+hXO7aPEtEAHjiIjmcDrOCCWscwY9d5MEg7hEK0vdOZRS43IL4NAq1JeBZVH+bfuz69Y67NjxcSNhjqxKjQwcuPL7pd3KL+v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB989247
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX5VHeZ4xGwMrm
 xTSmQcUPlo/AYglHAQ40w0gEFwbBwfWwiBw6e1nXGr7KZwToPf4ipdV4W2PM90kcINKfeR0KitK
 1bcSPbL4soRl5Gf0Aai8/9u6bpJpx7/1hVs4fdMeXEalzIhZKEzc7q6x/OiunXo4lzKaBjwRWdl
 xE7LE5IucxsKtrd9yC8ubE6bp4D8iwsuKV9yBtzvKxGVQEp6xv5EmdXPt1mq7hmcnlE5+AtBPWy
 iOv5fgs4mgXMD05LHiiHVuBmbSCaV5mUwSKEykS4B8IAY5oLt7XngVmy7o3TVyc6XYC8Nox2GBo
 nELtfTJZy8HSUvfWLEUFUp/5HYYTnm9nwnnANdrkV+qTszsEjiKKWryV3R+C1gZY9hPT0dEOTJT
 7smg54tqdL/8KzROUlF7vh4p0ZrSmbiAq63F6y49cN95tFaxZXj/v02d/h5V0GmZvBJiWOJEPR3
 izMgFHavM/wnJHUEO+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX7sDIS3cjXZCx
 HfF1rKoNMQxBWoALKsQuHR8B17Ojdte1XZt5Jbrj4mDEYbkDWmzvoHv9c7H72IS92qPy9TZlSMe
 573dl+15AikL0yA4z+ewpcQhE5iAZXVen3soI4MSwIu+JsGNGL+9
X-Proofpoint-ORIG-GUID: SXMm1BSZCg3YLYllwowmJ4xILLXdgMVa
X-Authority-Analysis: v=2.4 cv=BvgIUoX5 c=1 sm=1 tr=0 ts=6aec791e cx=c_pps
 a=lG9UAvPfEC4VfFSIqus9xw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=NqigyDQyY8NW8jid-XcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SXMm1BSZCg3YLYllwowmJ4xILLXdgMVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050050

On Thu, Nov 05, 2026 at 08:56:04AM +0100, Mieczyslaw Nalewaj wrote:
> On Wed, Nov 04, 2026 at 01:39:59PM +0100, Alvin Šipraga wrote:
> > On Mon, Nov 02, 2026 at 03:39:47PM +0100, Mieczyslaw Nalewaj wrote:
> > > On family D, RGMII on extension interface 1 needs two things that the
> > > other families do not: the EXT1 RGMII TX clock delay field in
> > > EXT_TXC_DLY (0x13f9, bits [5:3]) must be cleared, and the pin mux in
> > > the top-level configuration register must be set up.
> > >
> > > The vendor RGMII setup for EXT1 clears the RGMII field of EXT_TXC_DLY
> > > (0x13f9, bits [5:3]) in addition to programming TXDELAY in RGMXF.
> > > Do the same. The init jam table writes 0x0090 to this register, which
> > > leaves the field at 2, so without the clear an extra TX delay would be
> > > applied on top of tx-internal-delay-ps. Clearing it makes
> > > tx-internal-delay-ps the only source of TX delay.
> >
> > Should we not just clear it with the jam table then? It would save some
> > code here, which is just undoing what the jam table did anyway. Or am I
> > missing something? If you deviate from the vendor driver's jam table
> > then a comment inline or in its own commit could be appropriate. But
> > either way it seems it would save some code here?
> 
> The jam table rtl8365mb_init_jam_8365mb_vc is shared between family C
> and D. Changing the 0x13f9 entry from 0x0090 to 0x0080 would also
> change family C behaviour, which I cannot test. Duplicating the whole
> table for a single word seemed worse than two lines of code. Also, the
> vendor code clears this field only when configuring RGMII on EXT1, not
> on every init, so doing it in ext_config_rgmii() matches that.
> 
> If you would still prefer a separate table for D, family_info->jam_table
> already allows it and I can do that in v10.

I lifted the jam tables from the vendor driver mostly verbatim, and
without spending much time deciphering them. During your work on the D
family, did you find that the vendor driver is programming the same
values?

One thing I'm wondering is: for the other C family chips, is some extra
RGMII TX delay being silently added by the jam table we already have? Or
does it have some other meaning on the C family? I never got any
complaints from the hardware engineers about the RGMII timing so I am
kind of inclined to say that it might do something else. That was with
RTL8365MB-VC which uses EXT1.

Anyway, if the jam table the vendor driver uses is indeed the same for
both families, maybe it's best to keep it explicit like you have
done.

> 
> > > If the internal MAC4 block occupies extension 1, do not advertise RGMII
> > > for port 7 in phylink_get_caps(), so the configuration is refused before
> > > any EXT1 register is touched. [...]
> > >
> > > [...]
> > > +    if (extint->supported_interfaces &
> RTL8365MB_PHY_INTERFACE_MODE_RGMII) {
> > > +        /* On family D the EXT1 pins are shared with MAC4 (UTP port 4).
> > > +         * If MAC4 owns them, RGMII on this port cannot work.
> > > +         */
> > > +        if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> > > +            extint->id == 1) {
> > > +            ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0,
> &data);
> > > [...]
> >
> > I am a little confused about everything that's going on here, but it's
> > probably just me. Could you perhaps explain the two scenarios and the
> > order in which you expect things to happen? I'm sort of wondering when
> > this warning might be emitted. Part of me also wonders if you can't
> > avoid doing a regmap_read() here in phylink_get_caps.
> 
> On family D the EXT1 pins are shared between MAC7 (the port described
> in the DT) and the internal MAC4 (UTP port 4). TOP_CON0 bit 12 tells
> which of them owns the pins. This comes from the vendor RTL8367D API,
> which refuses RGMII on port 7 when UTP port 4 uses the RGMII interface.
> The driver never writes bit 12 and I do not know what sets its value
> at reset (strap, EEPROM or bootloader); I do not have a board where
> it is set, so I could not test that case. That is why get_caps() reads
> the bit instead of assuming a value.
> 
> 1) Bit 12 set (MAC4 owns EXT1):
>    - get_caps() does not advertise RGMII for port 7,
>    - phylink refuses an RGMII phy-mode for that port,
>    - ext_config_rgmii() is never reached, so no EXT1 register is
>      touched,
>    - the warning is printed from get_caps() when phylink is created
>      for the port.
> 
> 2) Bit 12 clear (MAC4 does not own EXT1):
>    - get_caps() advertises RGMII,
>    - ext_config_rgmii() clears the EXT1 TX delay field, binds the pins
>      to MAC7 (MAC7_SEL_EXT1 in TOP_CON0) and disables SerDes 1, all
>      before RGMII is selected, so the shared pins are never driven by
>      RGMII and SerDes 1 at the same time.

Do you have a datasheet I can look at? I couldn't find one.

I'm also a bit confused by what it means for MAC4 to "own" EXT1. Are we
talking about physical pin muxing (i.e. pins on the package can have
different function), or is this internal muxing? And since you say MAC4
is a UTP port, I don't understand how it can also be associated with
EXT1 (an MII/RGMII interface).

> 
> You are right that the regmap_read() in get_caps() is not nice. It also
> means the warning is printed whenever get_caps() runs for that port,
> even if the DT does not use RGMII there.
> 
> Since the driver never modifies the bit, reading it once in
> rtl8365mb_setup() should be sufficient. I could store it in
> struct rtl8365mb (e.g. bool ext1_owned_by_mac4) and have get_caps()
> only test that flag, so it no longer touches the regmap. The warning
> could then be moved to setup and printed only when the DT actually
> requests RGMII on port 7. Would you like me to do that in v10?

Since MAC7_SEL_EXT1 is writable, I would guess that so is
MAC4_SEL_EXT1. Could we not instead keep it configurable, and do some
bookkeeping in the driver to see who has requested these pins? Then,
whenever either is configured, you first check if it's already in use,
warn if so, or otherwise set it up and mark it as in-use.

Hope that makes sense.

Kind regards,
Alvin
