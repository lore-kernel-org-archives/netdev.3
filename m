Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793805792;
	b=cANQes78FmrN+5h9555MtekpYIoUKLfBH32eqsLBwlBRCxsNk7aVakSuBmRIVpqi8Mu0
	 rUR78MiVsHpX6bx29dqio16AynSFx7voEn7eespcm91eEntBxic/HE2t2xp9NzMp83cVx
	 XkHBLRLQtJewCSgGpPgDYlmx4FUXV3JRwYx0ZyeqB5yX05HJULSL0jpo5eEjxgdtwv0US
	 DOpt+V7zg6Wg4L9otHfm9+rYsOgohTV5iND2r/yCH8dX+f86m795G0tDd8u7jBaKlGJyb
	 o+X5lo0oVI3CFI0gtB/u7SwbO0udW/Thm+lNiVwh1wzbflmGXPUkqOhJL53jprch/iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805792;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7/1PfPoV2CcmE1QOh4bHjlkRJxBoDGLNiyOa0hKp38U=;
	b=CWLSi5g6CObYDEDRW97ids5CsazLIghPP96i5IpT3Ivba4V8Hlwh54l+RjhyQSP4YpYn
	 Ksq3sgp84L6OmMUEGNf03aDoyfsB/Cz5oU/u/wTTgBqZ5Qd7R+zEPqouwLv3hpnKxGjTv
	 AjfNMh78MBcWxt42N60v7Gyk0b77oGkDP0jB/93A5QtxYpypOzRPE6Ybtl22ephfHu4VX
	 KEj0lJUJ/Kz630WDi2FXbV8rGv2pI+7mty0s+mItdy7ChdrQ0LQ2Yhnp1iAnxzVX9u+tZ
	 UjiQVkZ2g79z5e8NtKbk1ROsplGP90cb63Y7SJonJ1vFieWuJedbbnqc5RvN02t8ruQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="QG/sRs12";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=bsJw7WUg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BB606A331;
	Wed,  4 Nov 2026 15:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47BB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QG/sRs12;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=bsJw7WUg
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4EMa0t3324787;
	Wed, 4 Nov 2026 10:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=7/1PfPoV2CcmE1QOh4bHjlkRJxBoDGLNiyOa0hKp38U=; b=QG/sRs1
	2GzvNDUeJcwX0CNBwLvAtuhTOVXCbBzXQQTRP69UUAerRGAU87//aUwXPggQPa4j
	Pc2u0kmv+8muM991+bXeFhT+Re4caBmEY6KSm1ry/nxEakOGxcvaUQsJEMRWbaoy
	dihHL1rIQbGgz/iDO7jrM10MYU55852jO0Ly+18zgZHLPkosGsEFUlwCphtRb+2G
	Aqo0g9jAcm2MEeKDAqMbdEnpDxY1DwLLAoODchsHg1MZL/pSMh4rYzBpdYC+6OJQ
	dhmIOShnDe7jpe2Dl+/8UQtAIcDdwLEoigmFzc219pVFGFO8ShI/z42APhH26SlQ
	5mFfr4lJlN2x9BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7/1Pf
	PoV2CcmE1QOh4bHjlkRJxBoDGLNiyOa0hKp38U=; b=bsJw7WUgsufa0u89o8sLC
	nVxTKMxZkiWSSIku+zHMBpJvksx7hHVVSYD3EnP/IacbRy5WunjpR2+XO2PUw9Rg
	ErXoDuWz/q07hTM7Mb/qX6Y28xKVeaTD6i4wi9StSkSFCDAxKRgHpCjIh/QU30m6
	FUl++A9blqUBJnTkLRAM+xcztht3BWLQ0vhc0sIMATW2UTMiVhwTkUotAqnMAp3W
	KMLWy1j6wuo3STMexmKNS3gmTDAMijdfeufClvOVBfEVCaGjdUHTrUECh+86/M1n
	j5P0bVk7xjBMz21QjQLYQkujDZAnTAlJ6wi6B3PlojxxCjcIn/JovqDESNp3ffXi
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqh167mu4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 10:23:03 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYB+RbpTvMuZwidsK8dg0dqBPBhWcOuCuanrnxpmjbTcw7IiHPP9Nt8IMDgQf2f/fVUHckK+Mj94dOzJOZIn8lITpMYmpNkkQ7sWl2ahVynciVI8A2iosrcjXmFzGqv/OBueKp7h4ABKKLS7P4SR/xLmnuHkbSxgaGBE46ahmRcp45si+nUZp6ayYa4qwGpKD3h1jUfFPzYszilM2OI4FRUkJXJBsJWXYH55D2YFJyS+kLUxLiyQciXEINYF/r5JgphFTuWEvVydkKW6Y3qUORtbQrj5rCS+SLbsfVOgPOVM0rpQY1UQyILAjT9G33qaVuAn1HCXERUzATSU94Un5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/1PfPoV2CcmE1QOh4bHjlkRJxBoDGLNiyOa0hKp38U=;
 b=ST8KXvT3a/VyhWc+AB4XQVoaaD6Dy2aZ+luD+aIWJbjwB5Rsa4bNdTlqkdjyKl/X58HXG7UcueFKukQ0N/6QNQol9RI4BBcZBNfYG2cdqg8ntexs9zFVdQUWAkM9gWWQPfEhQpkoMcbp0a6FEjuYcUcq444n5iZIrVAqp1Zaj82a4oyES1J8QYhb4y3sQOH1HthtquAtttuhsstToxRgBVcfUcQqcrZKUorvDmpC21ZTOPpdbx07d9577plggb9zCsrFDezkQPfRf62cOL8IH67RttN4r1Nu8UFO6j3TWiq5pjCcfn52U/egpPDpUnXUv809TJJvr1BL/J1qlgAr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by LV4PR03MB8353.namprd03.prod.outlook.com (2603:10b6:408:2d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:23:01 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:23:01 +0000
Date: Wed, 4 Nov 2026 16:22:58 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Stijn Cleynhens <stijncleynhens@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mieczyslaw Nalewaj <namiltd@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
Message-ID: <autLlP81HFeMyICc@analog.com>
References: <20261104082514.2139278-1-stijncleynhens@gmail.com>
 <20261104082514.2139278-2-stijncleynhens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104082514.2139278-2-stijncleynhens@gmail.com>
X-ClientProxiedBy: CPBP307CA0012.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::7)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|LV4PR03MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 668d00e6-1b30-4855-163d-08df3a878397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|56012099006|5023799004|11063799006|261102123227099003|261021121427099003|261021135927099003|261009223027099003|261026121527099003|261022105027099003|261028144727099003|261026140227099003|261022113327099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ncVLsSzFpRWg0A4e5PLmtXI1zH1ToowT3/DgTOfAp1NVFuxwXnticA6yYTofF9vcKewShniQvkC3hLmBy0VBTzwJsU0fJbWU8T6X2b76o1h3UXZcpAchUAM4NafVab6YhwNzjTmgW7EAtpWpCvjnFM7zMlq3b8Lr+mUPLcebnenHHeTdVWzdFT2eWxaT3BeKCaQz1HFXhTKiD58/N9UlxB7q/qxO9oUI0z8Kd2ln44Lb8dKzTqMH8HnYc2JKT25uddg//DmSlMMf3zVfhrm+Jqyibzj+m5U7qjmPmqnnyxIu/7Xpi0gCFEnkzju5Fwyp/FEXt763Ngj6FXizAknpYpqDpC9GM0UTBsCvltmc2YJSb2TWlEEXId+9RtNwHobbt+LUmDZFr3OtNdFDT9AA2xzracd5z3G0hD2OwvsoKaz+tDqq3grd+tdtqlOkTJuDE77Mr3gZ1XmL/U7GyWy6JQ8y3SRHMbilZXuGAdjoFaB4yLmvsjMgQsW6cyPwzMV3hsXaS6x3PM4DR/XYt4hR4Uy6wGmPIuRvcOm8hJSHhWv2R10WCYkNGivx7jLhqJHcdOioLJ5nxNRt3OyLzyDh40rJbS3Jc/uSV8RnqYFAhXsRazhsyCDgj0T9+/4rkZYBM3ZuQz/csKunFF8cG2/altaUhWBkyrS4B9kooIISsiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099006)(5023799004)(11063799006)(261102123227099003)(261021121427099003)(261021135927099003)(261009223027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(261022113327099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEREN3pyc1pFTzVZaUwwa0xSTnZzKzYvNkU3Syt1bVZiME1pcXZJbXQvZjRD?=
 =?utf-8?B?WGo3TGhxVGNlWkJDUm9XV3hiOHlBSHFidGx0RCt1N3dVQi81R202L2hEWjJp?=
 =?utf-8?B?d1FqeWhCcFBzQVpqbEVRNFpvUmxjYWxGWDBWMURyODRKTVgzVEtuN2pXTkhx?=
 =?utf-8?B?UjRGc0FDYnRzY0VtY25rWjNzUVM2Q3NqVFBLa2psdGJYUUdSUE1mM0E5anVW?=
 =?utf-8?B?OEVPTm4xVnR3b1c4NlZCWEVGQy90Q3FBVnVCWG9DNEloL2NxcVU0b3F1cTFX?=
 =?utf-8?B?OWFGYS9QbXhLRFR2Yi94ZTRHeis1VnNhZ1d1VTJuOUJXL1ZBbEwxSSs5S3NZ?=
 =?utf-8?B?eFhGUUNwTVVKdkdHUHB4eXZMQVVDSjEvVndNb0lwNFdVNG1vc21GTUFORmI4?=
 =?utf-8?B?MWRrN2IyR0IrNmE0NmNEK2swbUY5V0s5dzdnMlYvc3E1OFZhWDBySG1sNEpJ?=
 =?utf-8?B?S0ZyZ0huak8zSzhUWm05Mnd6UUZYSWlzZEhXU2Z1c3pTanNNYkRhV2psYkQ3?=
 =?utf-8?B?K2hTK09EZUIrUHhuTlRKKzMzK21HblRIUVNiN3Yra1VHS3g3VnNMRGhlenlk?=
 =?utf-8?B?MVVhN0Z4U2Z4dGZOV0tSTWM1ZUYwZ1h6bDIyOGJXbTMrUk41ZFQ0UGxhUDZk?=
 =?utf-8?B?dG1ZY1hGQmtsUGRweXVsTkV3aVcyckRJcG16TCtUb2V6UUZna1gwVTZpT1Jn?=
 =?utf-8?B?WTlDMThMNEZhc1VVdDJxaWtRNXVheFNyOCtFYkRwM1FkVzVkMTRSSURnVEg2?=
 =?utf-8?B?M25KUkYrbEpud1RISnI5WVdFeUVnWWdIcnltNW9LUSsyZUtmcm9ZR1NYTjlO?=
 =?utf-8?B?VVk4QTRxNGQzYlVDa0ZydldiTkNSZzN1ODEwR2RpSzJ3WjFDWU11ZEhYV2Ru?=
 =?utf-8?B?VDhyUDZDRGJMZlg4ZzVMbTdjakJoRHdhdTJkZTJEWVlrWEVBREpjUFowUXJi?=
 =?utf-8?B?SWdSWm1sUndOZ0NIS2pQWGN6SGVOSDlsV2x3R2tMc2NMMTlpUmhveDd0QnU1?=
 =?utf-8?B?WEZEU2d5dm1JZElFQUdjNDZkR2NGSWUxYk13R2owQW5SNnhSWGRMRk5QKzdX?=
 =?utf-8?B?Q05aeURZbEJmb3NZZDRnVU9uTWN2R0RuSnZzcUEyclFzb1JIOGpQVDdzUGJM?=
 =?utf-8?B?citzalBPOE9yT1cwdUZnM3RWdk05QWdHTG1TOWlqOXVHQU1DV1hzci9GSkxH?=
 =?utf-8?B?dFB3WHVWRExwNGVCWFdKeHdXQVpjTHN4NHVvSzIrN0d4REdMd1I0RzZTcjZZ?=
 =?utf-8?B?UG52MGQyN295V0ZLZ2RTSXFUUVZyMVdLNG85STJCVGZua0Q3UGhVaTltSlFp?=
 =?utf-8?B?TVZYSDlDSFA4ek43U25YUExtbi9UazNYVWZ1cGpMdDJBTUUzRStjcG5Wc3JG?=
 =?utf-8?B?RGhScnlCVVdwbnVNR0h4Q0w4b21BMUVnOUFsSlQ0cGhqSXdGNkRXOHJZSm45?=
 =?utf-8?B?S0pBNkpmWWMrTU1JaUtleVp1QkUvOUltaWUzeXB6WGtWUnV5VzRUUVpZc29D?=
 =?utf-8?B?RjRtL2NJeHdSRTU2aG5YWndlTmhpVWxZVEJBQ0JXZzh5VEFTWTlkQ3h5QnRZ?=
 =?utf-8?B?TU5WTk9nY1Uxd21tNUJtazdsdU85MjNEUVlXMVlDalpuZExPNjFYdGFDa3VU?=
 =?utf-8?B?cy9zbjBadVQvYmRJWGNadnhZNW1YVFEvWUlZN2MwUjRPQ0lUMnVwV0Yyck1v?=
 =?utf-8?B?ZW1KTWF0Ti9TSUl6T3JBSjhKWkw4bWlnaXFQY1B6d1p4TTB6WkhROXltY2Ra?=
 =?utf-8?B?VXVUZ3NYYWlaLzhzaUdNL1Ivbk55bGFXT0w5VE9pMlc1YnNLMkxCaXJuUEk0?=
 =?utf-8?B?MG5sNlNiWlNKTTFNclpNT1paSTdJN2hJaDdBeVUwM0N0NzRBTHp0bnA4QVJu?=
 =?utf-8?B?aW9pTmJLQ0JzdDU3MlFaOGMrZjhOeGZrNFFvQTRuekVNS0t3RkJoR1hwaWo1?=
 =?utf-8?B?cVdkRWhlUzhoT05hL1FRa3dmeFY2Q09aTkN2RWwvcjJzdWdxNGtoemY1NW1S?=
 =?utf-8?B?N2Y0QTlmMG9WbEI3NWY1ckwzbnlDS2RpQnhzVWhlSnRxRHpsWUZES0NiK1J2?=
 =?utf-8?B?UzJlU2JBQXBEMEZGNW5aUzJnVmhGNnZPckRveEhrNjZlNlJUSUI0Q3REeFBQ?=
 =?utf-8?B?ZlRESDVScGhUSFpOVlV4OTVZd3JSN1BpekFUQzdJaXNFSFBDV1B1NlN2aVpK?=
 =?utf-8?B?QTg4RG5wY0pabWhSMVpMU211VGNjOWx4L3hkTllIK0V2bXBhcWpMWTY1MUVD?=
 =?utf-8?B?U3V1WG5OSWNBUWxqdFZ0dnhYUCtWQitGUVI4eUx3dUVmQ253TFFYRDZqTmFj?=
 =?utf-8?B?TjRPL1lhNFkyQnBSWm9Da3k0RWdlbDZzd0sxWll4Z0pPQkNKcEkvZz09?=
X-Exchange-RoutingPolicyChecked:
	cHmYl8v3IPxuI/4ZhlGkhpcJXaRlv36pp/JBvcv9/6leKWSMkCa4/4hNiSCEte8a3c+wvA0KW964gPQXNKNap07hqGkQscCDv+cTS1rNPqhuIl/Btd/1NNoeX+veUvvy0+IzJvN6vLBnBhK+2oc/9agRors0piOk7si04p+rHxokqSpPF3thsOF2Elo2WjWj/fUg71debBUe7S6FVZyYGvy08JUcH6HTX5/HdsDTyGSqUhXgvLWzKoOUSnxBZwHBoEheP/UV5ke6xa4TRcY2zuCrUOdMVGX14HYvzJN8I/LhXNSizRNMuWcY9hBoXoGrU5Ff0B7buu+WigefUlQn2A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668d00e6-1b30-4855-163d-08df3a878397
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:23:01.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: su4qwK5cTeXafU453rXEemwTSdY6LOELDPD/9Werf55okQGDurnQ/FNlgPvC7+N9ducdDm6KDjY2KvtOJKmfVgxgNO+r+pFbVPAE1PQZn34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8353
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfX5G2w/5k/FsHn
 oZisVRKHnFgw81ZJ6Gx2Fr79v85nS6PpNrIo0WIGvQB0lIUyoCKZ3VaggFM+lh5fGojf3u42ZGB
 ZqCFu/tB2YBChgeFozFszNLJ/YX3lzV/e8KlKQJ9z0AuCRDquhJ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MSBTYWx0ZWRfXzZ1zGdcXp0+5
 WVC2ZbrkxR4qGBeBMjRD1L6oFkWXOuP+HC0yi2cx6Kng2YRjuwJAn/7JIEKZilT4NuimV30E2Cs
 WZGZ+b6kR4JeCtfQSvbNG0ZQLIzV8ka5/4mxFFDZx5jxCIX7leuisV9qy++9vi/x+IlenjbL2JP
 XKNioph8eJaDoO4iv9GKA49T1mU1kRZbZaTZMIfdArPo64vklUKe5dPTKRHoZcoRunOy9RRAttq
 7y4/Pfs/GfkOOSMG8zGtdQwQvbOMPlzTcdrVjsJeUauwwkKh409nKnlufRP6yIsQtDNcNVDwNHz
 Cy5HVPPBW13Csv21sgmmJhGPXRkmGnbAk0PnN6nBDt3NRLBNYsRK8WOV51u0hgk8DiTDSuKmpBx
 VSoaawK3KlYKG8oxzs+CO9jZUbx7LsbmMQoWVNTUcbkLLirYJMC+YuYapSCv3LxUmk4aerYPOlq
 Ouk8VzflBYP4xoGnXjg==
X-Proofpoint-ORIG-GUID: iL8EUI0jjPnxUMMwQO_oo-9Xvq_TJXvK
X-Proofpoint-GUID: iL8EUI0jjPnxUMMwQO_oo-9Xvq_TJXvK
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6aeb4dd7 cx=c_pps
 a=+5nsKerQHvRPAoQt0ERV+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=FyHyx8kToqIKwgDxu-EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040061

On Wed, Nov 04, 2026 at 09:25:13AM +0100, Stijn Cleynhens wrote:
> DSA installs the FDB and MDB entries of standalone ports and of
> VLAN-unaware bridges with VID 0, and the driver writes them with
> Independent VLAN Learning. No bridge VLAN sets up the VLAN4k entry of
> VID 0 though, and it defaults to Shared VLAN Learning, so the switch
> looks up and learns frames classified to VID 0 by FID. Lookups never hit
> the IVL-keyed static entries, and a learned entry for the same MAC sits
> alongside the static one.
> 
> Set up VID 0 with IVL, like every other VLAN the driver programs.
> 
> On its own this has no visible effect: standalone ports do not learn and
> the driver does not control host flooding, so the unused static entries
> only meant that traffic was flooded to the CPU. The next patch, which
> moves VLAN-unaware bridges onto VID 0, depends on it.

Yes, all this makes sense. I actually remember doing basically the same
thing back when I was working on this, but it seems not to have survived
the final work by Luiz. It would be good to get his input on why. I
think he asked me at some point, but I couldn't remember, and so he
rightfully dropped it. But I could be wrong.

> 
> Fixes: 336e3e4a1ab3 ("net: dsa: realtek: rtl8365mb: add FDB support")
> Signed-off-by: Stijn Cleynhens <stijncleynhens@gmail.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c |  8 ++++++
>  drivers/net/dsa/realtek/rtl8365mb_vlan.c | 31 ++++++++++++++++++++++++
>  drivers/net/dsa/realtek/rtl8365mb_vlan.h |  1 +
>  3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index da06f952a..b90e46c16 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -2232,6 +2232,14 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
>  		}
>  	}
>  
> +	mutex_lock(&priv->vlan_lock);
> +	ret = rtl8365mb_vlan_4k_setup_neutral(priv);
> +	mutex_unlock(&priv->vlan_lock);

So I'm not sure I like this function being added to the vlan.c
library. Semantically it makes more sense to me for the main.c driver to
actually call rtl8365mb_vlan4k_port_add() for each port, so as to
explicitly say: "all ports are, one way or another, members of this
neutral VLAN". Then you would get IVL automatically.

But that API uses a struct switchdev_obj, which would be a bit crude to
construct here... So I see why you did it like this.

If you could give it a second thought and see if there's a neater way,
that would be nice. But either way I think this is fine, so:

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> +	if (ret) {
> +		dev_err(priv->dev, "Failed to set up VLAN 0\n");
> +		return ret;
> +	}
> +
>  	/* VLAN is always enabled. */
>  	ret = regmap_update_bits(priv->map, RTL8365MB_VLAN_CTRL_REG,
>  				 RTL8365MB_VLAN_CTRL_EN_MASK,
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 8d49ffadc..58948e76f 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> @@ -322,6 +322,37 @@ rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +/*
> + * rtl8365mb_vlan_4k_setup_neutral() - Use IVL in the neutral VLAN
> + * @priv: realtek_priv pointer
> + *
> + * Untagged frames of standalone ports and of ports in a VLAN-unaware bridge
> + * are classified to VID 0, the VID of the neutral PVID. No bridge VLAN sets
> + * up its VLAN4k entry, which by default uses Shared VLAN Learning, so the
> + * switch would learn these frames by FID while the driver installs its FDB
> + * and MDB entries for VID 0 with Independent VLAN Learning. Use IVL in VID 0
> + * as in every other VLAN.
> + *
> + * Context: Can sleep. Must be called with &priv->vlan_lock held.
> + * Takes and releases &priv->map_lock.
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int rtl8365mb_vlan_4k_setup_neutral(struct realtek_priv *priv)
> +{
> +	struct rtl8365mb_vlan4k vlan4k = {0};
> +	int ret;
> +
> +	lockdep_assert_held(&priv->vlan_lock);
> +
> +	ret = rtl8365mb_vlan_4k_read(priv, 0, &vlan4k);
> +	if (ret)
> +		return ret;
> +
> +	vlan4k.ivl_en = true;
> +
> +	return rtl8365mb_vlan_4k_write(priv, &vlan4k);
> +}
> +
>  /*
>   * rtl8365mb_vlan_4k_port_add() - Add a port to a VLAN 4K table entry
>   * @ds: dsa switch instance
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
> index 27a526b61..809034009 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.h
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
> @@ -28,6 +28,7 @@ int
>  rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
>  				    int port,
>  				    enum rtl8365mb_frame_ingress frame_type);
> +int rtl8365mb_vlan_4k_setup_neutral(struct realtek_priv *priv);
>  int rtl8365mb_vlan_4k_port_add(struct dsa_switch *ds, int port,
>  			       const struct switchdev_obj_port_vlan *vlan,
>  			       struct netlink_ext_ack *extack);
> -- 
> 2.56.0
> 
