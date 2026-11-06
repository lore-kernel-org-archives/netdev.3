Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793973173;
	b=37Qq7xlq3Is/Pm3Ahvnx/Efe+QybJWGTdh9Bnu8ZgzgDLEP7+IQV49/HSvznsU362WcJ
	 3+B8oNfxv34FLbp+bSrzGiErzniacM4fW+vQtvqeC/xnarW0qi4lebFsHtthInKRlQuni
	 fSR8cxYMVcBFMjmqpuIXKayQIBcGl/2+DiXNjWdiSZPc8JI/hTdVAt/u3Lww/G4G+XsQ7
	 b7Tr+bQUlhYz75Cfp5Yt7MZkF8QLCbcq7fXTVcP3HdwHFp1LUUVWVOIszRg8yYmSCf16f
	 IH/fegn4yby09WfSXFqaMDNxBacHVVHpkMWzA9+xhy5a5rQ6uC1kwmTlm3Et9AmNJog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973173;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jFouLOM/3DKdVzaMrp+F8KYmOp66Hv2tM4FjpTG/+ao=;
	b=ToVpNga94xDnKXCFbRebHNDGWVpMzqzEqz2zkZfK8i0jxmEhjMFqKDgb2FQcheiio9CW
	 hI1zmTFD0XrwWn2dizUc/siSdfS25m59j8+YOwMdr0ZbyJFK3AcIaFqleBPQjqF4jLEBI
	 NPbwGqxWuU+uAHugMdbHfvP15+PhqBn9bWnm+s3CS++9PfHbVtwaEuLMlgAclOjHNCECk
	 wfTcBRyu7C3neYoXlAc6C8QKp4d72RV0JxQNPKsTWW+kkrd63iBE1FStHeIQAgR6zJNhd
	 26NZ4TBo+mxqsIcdg1TNgRYqguM2IoXwvkC0pPdMwaQv5LCIp2QhBEfY9OiSg5VUsfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NAYVEf9D;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="I6wjf85/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8A606A330;
	Fri,  6 Nov 2026 13:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA8A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=NAYVEf9D;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=I6wjf85/
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DpRBM2890285;
	Fri, 6 Nov 2026 08:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=jFouLOM/3DKdVzaMrp+F8KYmOp66Hv2tM4FjpTG/+ao=; b=NAYVEf9
	DfwfLfrGmVx5rQqlAJX7HL8RXi57rsLPkY78VE3sO9AmCpwUbpbTt6jcNqQ9k1SD
	yreLrRpDkJxPbsqtli56HQWX/JJdcQmVsPg4/A0J7mlYzSIUMDfXbVVaeTaoNL0D
	gwkrqilgCLuAKGfletQX2pi3anvtoGB1sSliUIk1OOQ9a57JB+RMuzv2jOOA7AC1
	hQKNxTVmN6KGUqQ65gwkpihhzsTU+sbfvux/RsbNjrX8LpBKYN6fyZ4YFz2RuwaQ
	oqFcxoMDZqDg4P/itVpa1hbSwVVOBCbg+8/xseR4wcR7NBXB63VQ7oJPjQ8YnViq
	vRhgruGRxlUol1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jFouL
	OM/3DKdVzaMrp+F8KYmOp66Hv2tM4FjpTG/+ao=; b=I6wjf85/lyWV7w3nfR12X
	oc6KrhYrtG7x63kCAB24xDEfatrtSlim1Zdx5kElCinOmvhazDAQ0XRgX60BpqFB
	UKhu5l7dXtenOLk1PpqHMaKSeogtRPy+w3bET5Y+LfZAua1d2RnF6f79z3xYnaqu
	xhnXZuArMf1+b5i8kw0iEp4Ks+1GaOunopR/RNsDc7siMhg4w/Si+fe6dQz/jtIX
	LvxfTHOnrV7xGCSrG/ZxHR04bhVOcMgByZYcQFlBORgxCPiHzdoDldNXJ7kGqor7
	QLXKSVEWPZi60HkBhIxnO0NhgbUx3cHipCbRyv12a7nHA5yjUHCcpE1xUSejcnE+
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pwv1dh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 08:52:32 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbX4iir9R+KV7tes6kQsyoEEy6tnaOYwCn6xGGhe7YtZZ/uzTnWsUirV1m/os/sW7PdUrkzAwcqyavvxOXMOl5sJ0RlZhV+qF6MwL2XBCp2OCrMgV9K4+hALjMlfZn1zC/+40MpTkmiXoRYp0OwTFlVgJNz2Gl1Dne9Od7DGOQUL2pyVq8fcmFUdIYvQuA7A9Vt5hwOFbDvpWbwBeEDkh30b/LN0MD4Rr69sELu5StsLb5cene6EeguxiPYB+FQ1s81Px7v8xzx+aaM3qh1tHwLbdSqPFmzqx5OyjtObmhaQiE/7aVyhZJjsV5w9Gyle1wRDRqX8j3Qk4lfajiCVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFouLOM/3DKdVzaMrp+F8KYmOp66Hv2tM4FjpTG/+ao=;
 b=Hu8JVV0kr4cpgGWiJj9a4cBlvbrOOXz6glhxM9Ca+0Eg1slC4PyDeTEaBu87a926KPWmqfPVXdnznGagQTMbzhheM5CdDiD2JEpa8vCxPvRR+v0pdJjESaNc7Dfp1f/YwnBNxgF7jnPUW/nFFKGLUwoyqEWGEUCN1dQIIWQJvHHkyn/OokkQZt4Faz3xf8Qsg+0scmss+6+JO/KuJJU0seG1KTyJoe1w+4AXZ2RbPV2Az1GuuuaXVnQNO1RuFvwYh9kDqZR97AlCM1yOGcwe3PnF2ECjpi1BnR44Wndeii7jQEkBPbxTj0LYyPythe1xNpQMqR/w08XmzY6hD6CihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by CH2PR03MB8087.namprd03.prod.outlook.com (2603:10b6:610:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 13:50:49 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 13:50:49 +0000
Date: Fri, 6 Nov 2026 14:50:46 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set
 RGMII mode for family D
Message-ID: <au3WTtBo3qk4nQvf@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
 <auskP2mSY4sCRa6x@analog.com>
 <82c96971-be5b-4c11-b20f-c4b074181515@yahoo.com>
 <aux1v3R-efbWF2GD@analog.com>
 <e66204e5-ac33-4a35-8d36-6f37372da97f@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e66204e5-ac33-4a35-8d36-6f37372da97f@yahoo.com>
X-ClientProxiedBy: CPBP307CA0003.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::15) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|CH2PR03MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 3071c36f-b321-4f2f-2c8d-08df3c0cf703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|10067099003|4143699003|11063799006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261022113327099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	yPEwLR+ZUaGaEHKvP5i24nKmA0e2gCE4v9Qx2m8wCKYHs62ek1lAzHXaG/hJ8jPK4kw/Rrj29c4GctpcSxroqH0yufoXF3J026Hw5JKpuHREDD/nliZ0G8HW8ASbPQyDioFIbQWOHg2BUEz2Q2KPunCVVWhwxN+kGsYrPtK8D22rv6MUo6QqWeR96thbW+PXS1D5XwfrBlCpPkUTbSat9XNddHQIsAA3VfaB4z8sWVUEBOrh1iBealmYkfSnYZq4jT6/2I0VSrUdxJbmW7O48x036tm17ObgCZPsLPI/QNAYDJ0oayKGg/Dp6+b3CUN4T0oUn3Q88E7HDQRbUIeXWJY1Hwac9IzLNg4yDOejJrHxkCdg3uXpow6C95vsDjlSmFhWtLGSepdYMYtq6qy+bPs/nVRNWhffPW0CW8A+FDutbk4uE46HqqO0dKV6f3SEL9VAC43/xqBCA+ZErbumFxxxbG4TCwSO1jxMWQ7yUYQpCl1jfaPDuh7DMg9FZd8XZU5ZXTIRelQN2jgbFAmRv934eP/ecphMBh9w8dsjZlbJYEt/9/JBAy/mFT/fFgVNjtBLo8ZkDNWOhkByrNpDN8TxVm1mMCPEQhfIc9msa+X3ubhUs3tmyeJn0OrA0H0/uS6V0f+2SdYDzu/WkbnRceghD3FcL9JoW4Zv9PjKlQ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261022113327099003)(261021123027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzhYRVBjNWV5bjZKUlBEZlk0NFVvaDdwdWpKdFB2YXZLZk84cnh6VDNrNlYw?=
 =?utf-8?B?L3R0VTJLNjRKYWZiNnJjb0dFM2RqU01jOU53d0piTzBqWnN2RExkWHZYZXN4?=
 =?utf-8?B?VVRnR3dIODdGT3VMMnRQcDBnRSt1SDNVNmZRNjBvQmlrOU5WRmUrbUZENUdp?=
 =?utf-8?B?RTRxUUllUlNzZHhlRERPOC9KKzhBY2U0MzlqcWFqZUJWK0NMK2tjbGxFUW9q?=
 =?utf-8?B?eFJrdVlueVpaK1U0OXJkWVBuckQzRzJWWlRieE9VTS9CUEsyV09PNW5pQjhX?=
 =?utf-8?B?cWxXaWUzRUxWd1dLK1BwaXdqclRqVmxndmlKRGZuVmo0YThwTFVBajdhNkwy?=
 =?utf-8?B?UlRVRFBJYXhFQmtScUhlbWp1eDJsY0lIaVowTUxnOEFCN2ZpUXFoeUV6RERj?=
 =?utf-8?B?NGd2bzdubm9HMmtsRGNjZkNkeVQ4ZXRpZzFLNDRJZC96b2xhTURtamdTWlhp?=
 =?utf-8?B?WVloWDBQd2YwbjNodWNHVFJZTXkzWTVkaUhnKzJoYmRsMEFoSWdEQ25UYlBx?=
 =?utf-8?B?TjkxYXBxT0FvbHFGRkFJTkd6TTZpdW9kNGZkQUprMGdCbWl0ZmFhZk9pY1dP?=
 =?utf-8?B?d2VPaDQ1SndtYzhHVnAzR2xDTTM1aHcydE5FTDR0NWI0NDFkL3VYSE9jc3NT?=
 =?utf-8?B?c1E4TUVMZVprNThWcG83eDlzRHNMYjNpVnVJS1ZDSEhiMEtybWN3cklVL0Rq?=
 =?utf-8?B?VW00ek9pK0VYZTVUTDJ1Q0pIaUxrKzZ0bjZORUtnNjV1N3J0VXhJY3lsNGNC?=
 =?utf-8?B?LzFsUXhlWmpScHpKSXJnbUdsUEs2WjRWM1hNNXV3azVCM0pxekJrUEJPaHBa?=
 =?utf-8?B?c3llWUM0dVZaMmhOL0JTd2hiM1pDaUJrQ2Q4T3ovSFltMG5JcWJRR015Szd3?=
 =?utf-8?B?MEFOcnFlZXVGcENlMEJxbjZ1ZFJ6VHI2VlhRQlRpc3haS0xjRFFSckwvTWNW?=
 =?utf-8?B?cWlENTFZWTNIL1kwZm1obitJN3BnWU9qZjhYSkRpbEZ5b0VaRytJUng0bElq?=
 =?utf-8?B?amdFaDZ1VVJWcnM5bi8rRzlFOUsrTmIzbDQzdHo4UzNSVWltMkYwWERvSUQy?=
 =?utf-8?B?SmhaM0RkdSszWkJqUGFxRER2R0l0dERRbDVtc0pteUEzQ2hnYTZkN3dMemhH?=
 =?utf-8?B?R2ZnQmMwc29iSXM3ZU1RQzZWUFllUUZMZ05NcitsNkVNTGc5NzhKa0JaL0dM?=
 =?utf-8?B?dWgrUTNyN2luNVIyMit5bDZKQ21KUCsyUUhXblBLMjlMN0IrUDc1Y3BuRGtx?=
 =?utf-8?B?WGQwaGhzbWkvV3J5NkxzNVBXMGtlOEM4WFQrT1ZJeHNCTXk3NEtXWW92L0oz?=
 =?utf-8?B?WnN6cGdwWGVQaVBvUU9oSGdmejU3ZzMzb1RxVXFDUEdueG1TU2xKNjZCLzY5?=
 =?utf-8?B?dHJVcVBQcjcvZzYxeGV2a0YrMjRiTm16c0t4aTVPUFEycWJpcktDSTcvV3R6?=
 =?utf-8?B?a0w2OTV3dG52WmxNN2V2ekRoQVhSVURINkJmemRMZno1Rlp4QS81T3hxa0l6?=
 =?utf-8?B?ZHg5U245VnZvL1hTNE5KU211RGVxRDM0SExNdkpXWWZkQk5UdndWdVhGa0ZM?=
 =?utf-8?B?QjVUZGZkVDI1UStaYm9SeW9PSW9HQk83VUhoT0V2RlVIYitGcE9HMDAyeHhH?=
 =?utf-8?B?a1lxVXRZVE0vREgyK3Q5WWp1OGlEZlRCQzB6VXF0aVJicUorRDVGMDdITVFR?=
 =?utf-8?B?bkJBU3B1K2dBNUFGbWFwYVVCU3RuNFFKZEFPK25pTmRQWHkxYlhGV3ZGRWhj?=
 =?utf-8?B?NFhHckRleTkwc01oVDZJTUorWGhVY25EUkF5YlZDL3c1TEMzdks3VE1UWEJT?=
 =?utf-8?B?V0wrbkRTdTNuOERSK2k3bXRucWJPNTVJemd4ME90aWUyMEF5em5oUFdCTlA2?=
 =?utf-8?B?M2VPZkJVa2VhNHNneGpFdXYvMmRHTTZBWlc5ejFxS3lhVlg4TUZXd2FKQW5x?=
 =?utf-8?B?UE1KVjJsWFBtVXVkOE5kbno4eUFMNHg3M2FRc09KSkptS09RQjdiSXhiRHNj?=
 =?utf-8?B?ZFlJcEVIOSt5eTBmRGlhS3A5bFBHQ2tieWNqOW1yVndBbk9HeVdnRHdTMlAr?=
 =?utf-8?B?VmY1LzdnMFA1ZzZQY3hUN2F4aHRzcXZFYTRsaTluWnZTS1RUN1dtQUlTZzlV?=
 =?utf-8?B?eHprU0k2bUtKVlR6c25rK3M0V0VVb0drNEk5SldYdU9IRmVQOEpidXVQdHJ0?=
 =?utf-8?B?M2I2bkZPUTNzWjZTTU1WMndJcklVRlRTcDV0M3ZiN2wyc3N0REJGVmhCUWRh?=
 =?utf-8?B?SVNNUUtONXRLd1lOaUlWWitOUVRCbHV0VC9PWXZjdFloR0FlNzlDVHd1NS9T?=
 =?utf-8?B?Z24wSm92dncxclg4TUt6Q0dnR2g0bnk1VU1pZC9zRU8yUGU3RHdqZz09?=
X-Exchange-RoutingPolicyChecked:
	Ll4yyA8mvmC55d3hWWd24nUEAOKGTVRpa+SrrRZbiZhSMc8fcPSH6MrkdZN9JNpcl8zm79kt7O8tPF+ErdBnk4MasuPuvQvEAax1ftmUrwGCrByEImy9KkfT7n27Q7NeuWqmQkqRBOo9nv5myfLKx3uZq4YEXXihH0wFrmFjO3dwbUYLIKRuoIEOdLsoNYPHx/xwJ5LTpNzApBjyQ8Brfff9Q5ORcmov/litYgHRCne7Ll2Ts7SntFrK63V06mPLM2mTxB6xdZ4GCrC/zERB3c5rWOKpOLi+Ut9qtHydyuIFOF+OmOmNwro/Aww0JFOFPigaZaTkMJVpP7QrrxmLJQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3071c36f-b321-4f2f-2c8d-08df3c0cf703
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 13:50:49.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AH1NzPt+aW5lgdeHIAciApoSwzuFV9RW2UZsBo9b4O30QTOiZC0s1cg9qn3ybunGEjQJOgwlbD8rb5MDzV4Viugh0Vr1yU7d0sHGgalVlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8087
X-Authority-Analysis: v=2.4 cv=UYnE26SN c=1 sm=1 tr=0 ts=6aeddba0 cx=c_pps
 a=0llFe6yxug+qBfU07gGDXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=mmd3tbn8qiCCd1lB_-4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fX5-mB-3dwXISYE8d1m25BH47DeTYzEj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX6ACvbo/v7pv0
 wgc2b+RTOvsW8ruvqK62twJiCibYczta9OKwWferh262AdcuOZQAR3ZsnkRZdplXofPP59p58c5
 Bcek3b/yxlZgEx7WyDsD/fcpeA+Xe3MFNthsUwDPnnJyJykXSAkx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX7Mh3UM3irrzm
 I7UZgUUt7ibjEnVWYfsfjGopuOlf4s4YxYt0ho7xwjzIAhMJxNbOzqkBVlk5sc1Cfg/XOf1vfzp
 bUIV9X18e2o/ZeIUsclll+RGdokecU/vkCOSI1X7k4F52Bo05ZT86rJ6rvd1Rdu0QpLj+2pt0zC
 QZnXRpR2S+6UqE+e3xJcbLuVUo6LmItLuET6qSpzvgnRv/rWru0LcZMfp7/uQpCjkCfYxRNbV1F
 Cq0pHokHo14qVjUhl+uGRgLzUAo3wHd7rZpxXwY7pVTauS/9oSTLGvwdFQmATC5FKWDrD4IiKTb
 L/znNVJUBofkMbKfo8B236siUkjpslWmAwoBdtwQZQHNFe5o7OwmwqLRRTQGiDPYDjLcE7GIo/F
 zIPURlHR8l+81kJibq+RuQ+gloUfSdYTdlqALN6iEgbdgRAOc00D2I86Ul8DpDPhVTwpfhmThPX
 H0bUCeTh+bOhAtJWJ7A==
X-Proofpoint-ORIG-GUID: fX5-mB-3dwXISYE8d1m25BH47DeTYzEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

On Thu, Nov 05, 2026 at 04:27:22PM +0100, Mieczyslaw Nalewaj wrote:
> On Thu, Nov 05, 2026 at 01:39:53PM +0100, Alvin Šipraga wrote:
> > During your work on the D family, did you find that the vendor driver
> > is programming the same values?
> >
> > One thing I'm wondering is: for the other C family chips, is some extra
> > RGMII TX delay being silently added by the jam table we already have?
> > [...]
> 
> I did not diff the vendor family D init table against the family C one,
> so I cannot say they are identical. I only know this register: our table
> writes 0x0090 to 0x13f9, which leaves the EXT1 RGMII TX delay field at
> 2, and the vendor RGMII setup for EXT1 on family D clears that field. I
> do not know what the field does on family C.
> 
> > Anyway, if the jam table the vendor driver uses is indeed the same for
> > both families, maybe it's best to keep it explicit like you have
> > done.
> 
> OK, I will keep it as it is.
> 
> > Do you have a datasheet I can look at? I couldn't find one.
> 
> No, I do not have one either. Everything about family D comes from the
> vendor RTL8367D API.
> 
> > I'm also a bit confused by what it means for MAC4 to "own" EXT1. Are we
> > talking about physical pin muxing [...] or is this internal muxing? And
> > since you say MAC4 is a UTP port, I don't understand how it can also be
> > associated with EXT1 [...].
> 
> I cannot answer that. "Owns" was my shorthand for the bit. All I have is
> this check in the vendor RGMII setup for port 7:
> 
>     /* Configure RGMII/MII mux to port 7 if UTP_PORT4 is not RGMII mode */
>     if ((retVal = rtl8367d_getAsicRegBit(RTL8367D_REG_TOP_CON0,
>             RTL8367D_MAC4_SEL_EXT1_OFFSET, &mux)) != RT_ERR_OK)
>         return retVal;
> 
> I did not verify anything beyond it, so I do not know whether this is a
> physical or an internal mux.

Looking at the vendor driver, it seems you can mux what they call MAC4,
to either a copper PHY, a SerDes, or an RGMII interface (EXT1). They
call port it a "combo port" (see RTK_CHK_PORT_IS_COMBO()). The other
port, MAC7, can also use EXT1. Or it can use a SerDes. But not copper.

The vendor driver is predictably quite confusing in its terminology,
calling port 4 a UTP port while also allowing RGMII etc. But whatever.

So if I understood correctly it looks something like this:

     UTP        EXT1 (RMII/RGMII)   SerDes(1?)
      |             ___|___         ___|___
      |            /       \       /       \
      |            |_______|       |_______|
      |              |   |           |   |
      |  .-----------'   |           |   |
      |  |  .------------------------'   |
   ___|__|__|___         |     .---------'
  |             |     ___|_____|___
  \_____________/    |             |
         |           \_____________/
       MAC4                 |
                          MAC7

> 
> > Since MAC7_SEL_EXT1 is writable, I would guess that so is
> > MAC4_SEL_EXT1. Could we not instead keep it configurable, and do some
> > bookkeeping in the driver to see who has requested these pins? [...]
> 
> The vendor code only reads MAC4_SEL_EXT1 in this path, and I have not
> verified that writing it is safe or what it does to UTP port 4. The
> driver has no code path that selects MAC4 for EXT1, so port 7 would be
> the only requester.

If you look at dal_rtl8367d_port_phyComboPortMedia_set(), it actually
writes MAC4_SEL_EXT1 = 1. So this is configurable.

But for the sake of the Linux driver, we don't care about MAC4 being
anything other than connected to the UTP (internal PHY), right?

So maybe just check in the switch registers, when it comes out of reset,
whether the default state of MAC4_SEL_EXT1 is 0. If yes then I think we
can just ignore this problem altogether, advertise RGMII capability on
port 7 (i.e. use EXT1), and be done with it. Maybe add a comment where
you write 1 to MAC7_SEL_EXT1 that a mux is being configured which is
also shared with MAC4 somehow, but that this feature is unsupported.

Does that make sense?

> 
> I can implement the bookkeeping in v9, but I would need to know how you
> want the MAC4 side handled. Alternatively, I can read the bit once in
> rtl8365mb_setup() and refuse RGMII on port 7 when it is set.

Bookkeeping is overkill. Let's just not support MAC4 as anything other
than UTP. If someone wants to add that support later, then it would make
sense to add bookkeeping.

Kind regards,
Alvin
