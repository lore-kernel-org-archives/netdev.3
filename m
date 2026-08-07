Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B238AC8C;
	Fri,  7 Aug 2026 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092555; cv=fail; b=TrnP6cq685Iqbl5lAEcRhy47rYzbi3Q3z82Iw9fARtSmySCgOsNT/HmlWiL482bF0EOXhS/B7Ar49Od7+Y2JjpdpHGbLXtzJ4lSC5TVE2tN/5+II9YdZm+0CsyGGG6PmsiVlDrmCMGC8X/VR0uJVNQWmYcAUgsrjMLM9IBKTUAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092555; c=relaxed/simple;
	bh=fFai4i2pw6EoHnsf8qOZ1e/dgxEhNoiT3WVpBrK/E6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JA6g4Q/6ZD6V5/jN5n4Qlzd8T9GhgFsqjyuHUnEbooi9zwrrxOp+OZTZckm0fS05drfC23S8B7dpjBryhC0ATQZZS8OObLSXSSe1XrCOjz29VTq2n+ZAhJaPGMJ57Wrxx0Gwp68MJxwPvAPh2CUlulC6WZAGD0y/dmNzuanoO20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=BaoqBzPM; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="BaoqBzPM"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777buFk755927;
	Fri, 7 Aug 2026 01:48:53 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020117.outbound.protection.outlook.com [52.101.46.117])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fvy5vtu7g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 01:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgPuXLzKt+hNDGFJExKGArTOLpHM4vReFJNgwFW+iRglLXf0ZILs/1wPTvd3vBP37l5bWdDD4WwswDp4YaIWs0guy3d/Q058kLAjxs9ETq9crNIggh1uvGaDPcezHymu+7ZHz2Jk/N7dpwBWgbQA/PaRfv5kBtXErWhtAhruOoMT616FDv4xPK7ZyRIt/p4uHJioLyVEIbH++RkF5o9QN6pLBwcFe3bCuuPK9iSMBUGQNCX6OPc4INDi7k/qBLIRtRJ1gYn/uJarFwr0BlCETFJpVspmoG2x6CG9bOmxbU4JPkCV61UjEtU2gi+WEUohJERe0tNrut5861QP28nI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFai4i2pw6EoHnsf8qOZ1e/dgxEhNoiT3WVpBrK/E6k=;
 b=xYohiBy4HUpOiVyVGE92jyTN5aiOf1x5VIa5vkf7U6z6oZDHglgzbJ3EU0439jRP2qI4Nw19hyotffcRenwXzn5hgJZF12hwikcJRTC5Z2DmhWeF4YGEznEqJ24sRKzHIuHTagsOzZaQDiJnLxaRqM3tSHlr/6v/gs4N2R4x1IbRkO2VVONxYF7MOAwQrMOtTfvqq4NWK8bxREWttI039ZG7y63bj4zwn+ICc8Q2NW0PPTXT+jWUSqD4UNdCCAPJnr4VknYgKAkqWNgtyRuoao9xookgKslWSAu/N2rYS3xi1JpHdGq2/K0DF8Fl5D2CCDbG/jaVEvYWX7CY/Ilw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFai4i2pw6EoHnsf8qOZ1e/dgxEhNoiT3WVpBrK/E6k=;
 b=BaoqBzPMmYvEeZ6bpoOQIg7gipdg5t0lw2pcF/BKkhpg3xM4RePrqOJeEENFsLZez0/cYstuUT8OYNCNC45F/1bOs155GEo/ZWyhpUqX+YibAZreysLGfXmxS2wAENz3hZyT+vexmHNRlEsznKA8EwdD2xkk9ymA5WMvvOmAFYc=
Received: from DM4PR18MB4384.namprd18.prod.outlook.com (2603:10b6:5:39d::13)
 by SJ4PPFFD4045EA4.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 08:48:49 +0000
Received: from DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3]) by DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3%4]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 08:48:49 +0000
From: Subrat Pandey <subratp@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/2] octeontx2-pf: Fix aura BPID
 assignment when CONFIG_DCB is enabled
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 1/2] octeontx2-pf: Fix aura BPID
 assignment when CONFIG_DCB is enabled
Thread-Index: AQHdILDn1Z1/5OyuikqlxoZ5ilSgc7aRLp4AgAAA+wCAAPTI5g==
Date: Fri, 7 Aug 2026 08:48:48 +0000
Message-ID:
 <DM4PR18MB4384129AAD6E2A3DF0494C36ABD12@DM4PR18MB4384.namprd18.prod.outlook.com>
References: <20260731055310.1229213-2-subratp@marvell.com>
	<20260806152650.2562245-1-kuba@kernel.org>
 <20260806083020.3b747817@kernel.org>
In-Reply-To: <20260806083020.3b747817@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4384:EE_|SJ4PPFFD4045EA4:EE_
x-ms-office365-filtering-correlation-id: 5da1fd01-b3a9-442f-5442-08def460b2f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 wdDM5NJlKHEEbeUueXuDS2CAe/FDw0msqQqx4hFnLfPZaIALXfiG/cMcPCNxek9gCc5LC2u8MMatmbCReEHqaGRrnigfbrW3RMvto0Yf4ot4zyAjPRO6ItdzsndgK5+CaBzB8OO0sa3uGAYnJ6e0wpTcGxGs0Azqtg+vscw3/2GtgB6bPt80DHjKPVpKqkCMCsPGxQNf8pDJeyAKP6BfXCNLFMsnG4nrAc9E8tqiPjhOULl+1QvoqzNo4wOEx6M0iGal01ehNkxxDXYw/9yWNlKYO7UraV9IUKvu+hmziYH6tn0Tu//wkdbCZzKc1aMizqBJaFuTCMdkGnpYHKvketHCL/EXmEQsBHzT63rQtP0IuW9m6N5m/AlDtHyYy1v5bG+bGcRLocPdy8R05YI2jXrPmoMm43zcGyyKkQZpbECUnwMcMXALf/tIFFKPgmeNH3apVsLg2giwWA7EHT470R9o/vE85sIWyxnIJp+5Oc4Kku7tBnf7rbmaVNuiSnj+UmZXOY7qIuoF7lth8Lu/hgIylMCW2COW9m9ByosS4FK9lK2FhzI7a4X+SHyArwht8X1QAr+eXiK7YCVd3EuHMHwMfzutoKbY4w7syHf8JXPOZ74oA8zPnDsdd5/gwN8hQuBD0rHfhBbf+5jtRuft0+uMTJIV28vmiHeIYC+Vb8Efl8mET7WpMaK+Zo1VHDm9D9LaKQiAJ6g/XVkhKW5XIHdVz0qYkO9IY7F8uQK0YNw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4384.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkZRTjlCbXQyWjd3eGRIbkorTWpKZys0MklMK2pXOUc3YnlveFdtb29tK1NP?=
 =?utf-8?B?M1lMc1JMZ05aWC9PUGNMcHZBSjNCeWpMZTNsOTVGZDVvVjhzbEtFZ3NsZEk0?=
 =?utf-8?B?QTkxMndYb09QdkdObzllSlR1U055NTZGYVIvcXdwWUZNVFZHemtuazBmbDg0?=
 =?utf-8?B?RCtsUTJsSHFiTmJid01icm5hMjZRNmYzd0JvZElyNk9Lc0d3RWhnRjI1ZVgv?=
 =?utf-8?B?LzEwM3lFcWNlZThsN2tDUlJRL1B0T1ZTQ3R0MEUrN0RVS3VxcFF3amFpL0JP?=
 =?utf-8?B?dFh3YjlYMmVkdGE3elhNRm5qT3JnbUQ1d2g0dGl5NEN2WWVvN2ZwNzRrMGdC?=
 =?utf-8?B?cWV5a0ZPWTlLa0NPUUl4aUpDWld4aU4xblQrL1plQUc4dlBHamE2N3RuNnlL?=
 =?utf-8?B?dG5xdm9BYUIzNXdVVTBKZ0VUaEZKTTE0RXpFckVhRzNIRTRSL1hFOWQyc2VC?=
 =?utf-8?B?cnZhTVFRN3ZmVEZPdmpvWWZtZ3VTdk1HQUxCZmtMMzJoZFNnQTZBS05ZMWUy?=
 =?utf-8?B?K3VvYWwyOSszZm5MZllQTVI2VmV6UHZjZ2J1MlFydmRpT085Tlp4cFRLbEpT?=
 =?utf-8?B?SXF2ZEVvalNxU3hTUXFBcGthTElCWmRoZkFreWpnOUlHaE5FaVFaR0JDNWti?=
 =?utf-8?B?K1AwQ2t5bERCZGVIUWZaOHdYQ3J0N0thR0o3ZTdzbGduQ1JmNVBVZDZleHpQ?=
 =?utf-8?B?cnVBMlRxR2ZMdjIwanRHSThCSHNIeTJtR0Z3ZkFBSGh4OEVrbHdnNmxBR3ky?=
 =?utf-8?B?Q2ljYU1ITUE4NDBDMHY4bnBQQThEbHBxOEVpWmpBMVY1aDJFWDlHOGxkZ3dr?=
 =?utf-8?B?cERqSDVLV3lBZTkvMFZKNStpb2JCOFA5d2dYTEFJSUZsZUsxNk0xSWVnYnlk?=
 =?utf-8?B?YTFpeEY3UXh2REVHazlhaW1OanlsdGFhdzRIM1RIKzJUUWlQMmxPamJiYVdT?=
 =?utf-8?B?T2xKa3k2LzdPdzJOeGJ6Z2tZQTEvRFRpV2NtUklWeWpPSG1OV2ZGMUZFeU9F?=
 =?utf-8?B?dWFyUGx0VWlsSWFZOHI1cnh5NWJ6b1pNSWU3bHFGcHg0dTRHNWJUMGFqNTZu?=
 =?utf-8?B?Y2NOM2IvaFE2REE0U3RQcVk5VUs4NjAxa2Q4Yk9SbGNWSk9MS0FYUEFsdVhi?=
 =?utf-8?B?eWN4YUtCdW1oYS9sZEJDZm1WSHo3bTR3Z2ZPZy9VaW5NeGd6MW4ydmdjZWpw?=
 =?utf-8?B?RVpSWC9ZcFBnQXFIU2o4UWU2cjRLaDVVdUhxcDN6dmY4TTlGWnhEUnJuWkN4?=
 =?utf-8?B?clBxcmY2VmVWclpPSVFpL3FGRVVadjhJT0xjK0MrY2NyL2ZERVdSZjZ1MnVY?=
 =?utf-8?B?b0l6TkZ2R3ZuNCtRdUI3eitQUWpsekNHWjVMenFjSFNjUTBoYmxrencwbmw3?=
 =?utf-8?B?WWNITWFOTFFJTllqMnVjQ3Q2cDdLdCtQaG8vKzB4YWJRcWF4U0dJQlZyQTFh?=
 =?utf-8?B?ZkxMYTdtNnNRemdadUt4a2JMR3d1cTFRK1JaOVlxd1RuSUdCc0pwOGt0cUdQ?=
 =?utf-8?B?ck40SGEyaTZYeUpmRld5SDB4SUxBQ09QMXFCemtVTitZVEJnSjVMYlZSSFIr?=
 =?utf-8?B?WDhpUXBZZlhJVkoya2MwaXZSTGpLNjN4ZlF5ZXFXWmUybzJ0R2REY2RZa3dN?=
 =?utf-8?B?c0ZNUXdjMkQrUFp1T0pkTGhybmt0RWRMQjgvQWJ3U293NldhWUhEM0lFcFVh?=
 =?utf-8?B?amFnQ2hBSWIvUFZDMk80cnJKQjRxeHZwWmF5eXh2SXpyRlFZbEN4OEVnTlFC?=
 =?utf-8?B?RldOVVNGK3lISGtudkJ6YVJ0RXNnZVcyTUxBa3lMYnpQRTBnUjQwNmdzWld2?=
 =?utf-8?B?K1d4WldBNXVwUXFFN3VyYTA4aWxWVkYwUjlTQm1WRFRUallYSzI2MUZXWFIx?=
 =?utf-8?B?WjY3ZVNzTVRqdlYrYTR3Uy9uV2hoVnl3OFBsTDRoSDYxUDBHT25OQjk0NmFi?=
 =?utf-8?B?dlNFemRIOUNtK0J2V1lIWk9mb0d6UlhldUM1c2RpeTdpaDR3a3QwUndnakVJ?=
 =?utf-8?B?emMxa3U4dXlmUGFlQUNGMTg4NU5lZmgzcFRUZXhnT2R0b0VDM0RzbUIrR1lM?=
 =?utf-8?B?Z3BnN0VKNWdydVpCQnBjZlNvd29iVXVQcXpRS2VRS0ZxZzhjVUJ6UjFscEpV?=
 =?utf-8?B?SS9wUGo5bXE0M2pkM204aDJqNndBZVBacnZHVW9jVmswSGJRbEJBSHpIWUF5?=
 =?utf-8?B?aTB4Z2R2WWJiVkJSTG53bWQreC9OdVdwcVU5NmpBYzJ0RlVwWklNWEt3dDRm?=
 =?utf-8?B?SGlFSTdxNE1HeGZBdzJkWWlnMGtRcHQzd0xlYkFaQTltOWFEOWMwdzhPc3NP?=
 =?utf-8?Q?UgorckFtmD+PoOANKE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Yi+ss5HBaun3BViw3z+dIjbUdVd+gLGzJUYFCzqCsd9vzSiyBVS5egxiHJbjjewI8GUzFZ8z5UfXbWKsHAtdDU+SRJg07nFqBRhBPgbwtiPsUuGjrC0osINLZBLzUn3EuoUhEWDxqhsrGuRvaoxzRiJE2ObqEQ+QKIbtR/BVIPgotiaB+uzlzZyeTraj/ZnlvPjn8Mj27JbX7zHcnPr2Or2mffmuqf6InwVM0j5XC3J0yVI72Qh+7ssEd5pXYhO7aprcX+S7TgnBUL6TonpMdmJq4lEqmFZfT4rCG3dJLXBvpeefePC8MnG9iRUb62dB9YMnHmCrBgu4MevwaZ8RmA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4384.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da1fd01-b3a9-442f-5442-08def460b2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:48:48.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPQn2qNCREsdfW0+/4txzK1hZ21IKAbtsmglMeo2RBJwpDjt8ACOQ7NW2Fr/U0Xr0WowugTJYaG/yvf2wfJtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFFD4045EA4
X-Authority-Analysis: v=2.4 cv=Ot5/DS/t c=1 sm=1 tr=0 ts=6a759bf5 cx=c_pps
 a=RrdOQlmmxp+bQeXV/0G7LQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=g3aC9Q_Dx_lfJSgXessA:9
 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NSBTYWx0ZWRfX3iwgeDAsmu63
 fzjfZthJzq0aMGFbhl4O74f9plxxxjrKnOsap5XMpzlbwNhwQShMM3nklHbRq3KT8J0Npqf/tIU
 S1ARjczQ/w0NJJHHblj/7Vse4OgQAYA5/Lcmh0KHbYJxopr3G+BUJIzs0rq8GwDw6SEEP6DbLa6
 yjRj+w0Q/c4U00PnLzF8yeD7k/y8svdaaagzQae0bT9zvDmMnLFOpMS5JyC6fe6OIhwpxaz5McS
 tddA3I25aZRETy7jLBWsurpk8B6RVxhpcBh7Ot43ZMyvjmxoYUdSQgAePcAVBr+8/wVNh91loYC
 ko79nZJAyqxJqqx3LiBD33KiiEkf0y621LxvQLrzGbxmmKvtQmbdwEY4Wh5zVQcJHDLM5h0VPaM
 EUNdAVYHu9EZ/ltz8HCmKrzs1BLGWaWU/+4JUPF+KdkHyj3VL1SDYgqe1lEtC20ZhyfNYurC2tx
 NeTPNaj5Z7RSBu1Ldyw==
X-Proofpoint-ORIG-GUID: yStNgGT__6iy8lJm80oe8mndp5kD9ptk
X-Proofpoint-GUID: yStNgGT__6iy8lJm80oe8mndp5kD9ptk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NSBTYWx0ZWRfXxBbh/JaALz21
 b9H7RlqbJbH0P2pGfmIRLAKQj7GzyVTLh2lpDGuYe55VCbzAE/37B4g5TWugKp/wI9yJ34uIUUi
 XHww+NYCGL9Cv6zSUd253u1gT0WwO2Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01

CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpGcm9tOiBKYWt1YiBL
aWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPgpTZW50OiBUaHVyc2RheSwgQXVndXN0IDYsIDIwMjYg
OTowMCBQTQpUbzogU3VicmF0IFBhbmRleQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGVkdW1hemV0QGdv
b2dsZS5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsgU3Vi
YmFyYXlhIFN1bmRlZXAgQmhhdHRhOyBSYXRoZWVzaCBLYW5ub3RoOyBHZWV0aGFzb3dqYW55YSBB
a3VsYTsgU3VuaWwgS292dnVyaSBHb3V0aGFtClN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRD
SCBuZXQgdjIgMS8yXSBvY3Rlb250eDItcGY6IEZpeCBhdXJhIEJQSUQgYXNzaWdubWVudCB3aGVu
IENPTkZJR19EQ0IgaXMgZW5hYmxlZAoKT24gVGh1LCA2IEF1ZyAyMDI2IDA4OuKAijI2OuKAijUw
IC0wNzAwIEpha3ViIEtpY2luc2tpIHdyb3RlOiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi7igIpjIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLuKAimMgPiA+
IGluZGV4IDNkMjUzMTMyYTE3ZjAu4oCKLuKAimI0NjkxNDcyZDJhM2UgMTAwNjQ0Cgo+IE9uIFRo
dSwgIDYgQXVnIDIwMjYgMDg6MjY6NTAgLTA3MDAgSmFrdWIgS2ljaW5za2kgd3JvdGU6Cj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMv
b3R4Ml9jb21tb24uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25p
Yy9vdHgyX2NvbW1vbi5jCj4gPiA+IGluZGV4IDNkMjUzMTMyYTE3ZjAuLmI0NjkxNDcyZDJhM2Ug
MTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgy
L25pYy9vdHgyX2NvbW1vbi5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZl
bGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5jCj4gPiA+IEBAIC0xMTMyLDEwICsxMTMyLDEw
IEBAIGludCBvdHgyX2NxX2luaXQoc3RydWN0IG90eDJfbmljICpwZnZmLCB1MTYgcWlkeCkKPiA+
ID4gICAgICAgICAgICAgaWYgKCFpc19vdHgyX2xia3ZmKHBmdmYtPnBkZXYpKSB7Cj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgLyogRW5hYmxlIHJlY2VpdmUgQ1EgYmFja3ByZXNzdXJlICovCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgYXEtPmNxLmJwX2VuYSA9IDE7Cj4gPiA+IC0jaWZkZWYg
Q09ORklHX0RDQgo+ID4gPiAtICAgICAgICAgICAgICAgICAgIGFxLT5jcS5icGlkID0gcGZ2Zi0+
YnBpZFtwZnZmLT5xdWV1ZV90b19wZmNfbWFwW3FpZHhdXTsKPiA+ID4gLSNlbHNlCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgYXEtPmNxLmJwaWQgPSBwZnZmLT5icGlkWzBdOwo+ID4gPiArI2lm
ZGVmIENPTkZJR19EQ0IKPiA+ID4gKyAgICAgICAgICAgICAgICAgICBpZiAocGZ2Zi0+cXVldWVf
dG9fcGZjX21hcCkKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGFxLT5jcS5icGlk
ID0gcGZ2Zi0+YnBpZFtwZnZmLT5xdWV1ZV90b19wZmNfbWFwW3FpZHhdXTsKPiA+ID4gICNlbmRp
Zgo+ID4KPiA+IFtTZXZlcml0eTogTG93XQo+ID4gVGhpcyBpc24ndCBhIGJ1ZywgYnV0IHRoZSBz
YW1lICNpZmRlZiBDT05GSUdfRENCIHBsdXMgTlVMTCB0ZXN0IGlkaW9tIG5vdwo+ID4gYXBwZWFy
cyBpbiB0aHJlZSBwbGFjZXM6IGNuMjBrX2F1cmFfYnBpZF9pZHgoKSwgb3R4Ml9jcV9pbml0KCkg
YW5kCj4gPiBvdHgyX2F1cmFfYXFfaW5pdCgpLiAgY24yMGtfYXVyYV9icGlkX2lkeCgpIGFscmVh
ZHkgZW5jYXBzdWxhdGVzIGV4YWN0bHkgdGhpcwo+ID4gbG9naWMuICBXb3VsZCBpdCBiZSBjbGVh
bmVyIHRvIGdlbmVyYWxpemUgaXQgaW50byBhIHNpbmdsZSBhY2Nlc3Nvciwgc2F5Cj4gPiBvdHgy
X2dldF9icGlkX2lkeChwZnZmLCBxaWR4KSwgYW5kIHVzZSBpdCBmcm9tIGFsbCB0aHJlZSBzaXRl
cz8KPiA+Cj4gPiBBbHRlcm5hdGl2ZWx5LCBjb3VsZCBxdWV1ZV90b19wZmNfbWFwIHNpbXBseSBi
ZSBhbGxvY2F0ZWQgdW5jb25kaXRpb25hbGx5Cj4gPiAoaXQgaXMgb25seSBwZnZmLT5ody5yeF9x
dWV1ZXMgYnl0ZXMpIGluc3RlYWQgb2YgYmVpbmcgdGllZCB0byBkY2JubF9vcHMKPgo+IEFJIGlz
IGdldHRpbmcgYmV0dGVyIEkgZ3Vlc3MuIEkgd2FzIGdvaW5nIHRvIHN1Z2dlc3QgdGhpcyBhcyB3
ZWxsLgo+IFBsZWFzZSBhdm9pZCBoaWRpbmcgc3RydWN0IG1lbWJlcnMgdW5kZXIgaWZkZWZzIHVu
bGVzcyB0aGVyZSdzIGEgbWFqb3IKPiBzaXplIHdpbiBvbiB0aGUgc3RydWN0dXJlcy4gSWYgeW91
IGNhcmUgYWJvdXQgcnVudGltZSBjb3N0IHlvdSBjYW4gdXNlCj4gSVNfRU5BQkxFRCgpIGluc2lk
ZSB0aGUgaWYgKCkgY29uZGl0aW9uIGFuZCBjb21waWxlciB3aWxsIGVsaW1pbmF0ZSBpdC4KPiBO
byBpZmRlZnMgbmVlZGVkIGF0IHRoYXQgcG9pbnQuCj4KClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNr
LgpXZSB3aWxsIGZpeCBpdCBhbmQgc3VibWl0IG5leHQgdmVyc2lvbi4=
