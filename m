Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793801474;
	b=c8w/lZrQ5DsYoig38Q/zZIABuiEJCcRFbPQXp1svqshwkahwMEqU77lW7GCpVoYctr7f
	 7bIOR5Ip5KYtN7Y6qPJkv05OPoIJ1s6bc5RqU6Vb8EGb5svn7GRN6mkkIW3BOxf2HHeyB
	 O1lJnsqIGiqOnR4rB3MfJJlvIUkjJPL7OFlpsL6ZBMM9ebz6asSy+nJGeBSMlm27Pn31S
	 TEN1xfep65L6T4vb0EvIa79CgLe+Ohy20ceciZ4iHRmmRkxjNTj3CTtxjvHpnR7ZAfmGW
	 SeqXyrqc3t7Rg0cHlzmHYrTrv+fk0QpLDLvO205/G/+lgeWcrHKHsh6MTftRYkPRSxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801474;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jmSGuOnNQrIwv5A39A7h7z7261Av/MHAZKbxZ/L9+X8=;
	b=eckE3QD7pdAKHb1OpbJ1pVuP+5OqimPC0LO039XlDhtsz2UCYD4hmfYKWkqG+wWx+C/h
	 a5FpuCU/eY/RyPUC7bZTfekQSwJgLUscZBu0M0c77jeK6boJnv/6GDs0MDqutM6tXSoAq
	 8V35YBRO/QQ2Ti7hEodazVJSsXphON/N0A3to3gV3zClq4JOIDMIokyrA4soi6s4/ACK4
	 fuSKCzUstmd4BIDz1fM4MMgZkmCryVlgLxYRI2uv3lGA20aiwjDyFs3WnSWoZzY+cvLHn
	 aH6GrlZSqPoJ4FUNxBzMdNpqqhcJi0W/+yfXPaMRFyVnJLvaOw3Xru/PenZ0bCJyinQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YAerj6iA;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UcptCDfe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6A606A337;
	Wed,  4 Nov 2026 14:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA6A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YAerj6iA;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UcptCDfe
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bd0Oc2876146;
	Wed, 4 Nov 2026 09:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=jmSGuOnNQrIwv5A39A7h7z7261Av/MHAZKbxZ/L9+X8=; b=YAerj6i
	AL9uMij2DeBtT70+EDZcrK6rP+nE5KrhvC0L0Wp/TVLzV2tuhJFMGGwsgVSxKmm3
	FOxhoT/rOuc116QmmkdPOBggkXj6jjPQl5ukbnjOS0Q3rCkwa+mEVoPpZGFznX61
	O8LRmV5VTVOPnd7p5IXKYfjDfdAAB/BHQKonpgIsst3FjL/Cs0jEl3FiJSwrdPnl
	EDzeDXcuhTOUKei9deMRIYLEMxUfzY5cXOEvwqG3lKjJuLeZ0MFAYHnN16oT64mo
	OpWfwWLkwOIUDr9gcg1AKdTxeCfYcVzycp9KaooPs9+f4y7j7y7WH1W6pVLSqAJ2
	QWnDxC6NbmD7fDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jmSGu
	OnNQrIwv5A39A7h7z7261Av/MHAZKbxZ/L9+X8=; b=UcptCDfe+22ov/GgOwYed
	G4OIaFQvML/u4FW5OvQK3HjJpfCHME/puHHwcpAvuN7EJVPOiSDLNrxKNSx6gnda
	w1UHSPaMO2yw00Av66L1+iCxm4XAEm+lepBcsZYQ9eJPsACy4C2DxHEpTStNcJxJ
	EqX1lUkGMSsLcRPNw6zrhJcJxHcO8BbYVNANCjXARZU1XHH3VhB4aOiE0KSvNupc
	/7f30ARojLd8wVluayjBvfTWceDUou/3hbGxl7ME3bVHXxCENxBBe7Hv8fWLSG4s
	xIefj1KPtEE1midh8ULo9XOLCcnmpL1BCVegd+/vRt+uJDC+srN684O+b9FQFDrp
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqrk4vkw3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:11:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5CC6fTod7lH4wbZgk/m1EeJBWW+Z2YDcfJoE63Y7UH74Vp5yNrBDDjgv8KVkUH5TVAYrzi9FVV5Wo3rEgDhTQBgj/b7xZytNo8Ln9HWB1YUJJJdo4r82E1ZE0sTIxfMe/4zC6El8QUvXWGDGc5jdUh/11SkcGbwYC/I+wihmcoZV9FxsfGGJKsK8w6ePbvtKeHsc8CJN6ZC0Em09dnKdugBEkwEMhTPCZTBvmbbKBEvUoUu82dUxn03MO0xQQMWIA2msnXwicCV6r2cuqa3Jh3BwllUSAR2V3oqU23U4+Fh7IKDHdkJDVAo+/NWz6u7seUCeHqOe2ohxRfhR/DRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmSGuOnNQrIwv5A39A7h7z7261Av/MHAZKbxZ/L9+X8=;
 b=kIUj0jFRaMLK5DjkJmK1VikbfElmip6I4uOaAlqn4ymMJKE5HQCEf0xOL2MnFe2MXxaaovWe3blKROWVTylm/tWtf7bZAjNW+irUkeScCOwG1u891AKG0wkG/Runn+HqhiZ0E4CFhx0RLlrlWct64TVn4ctYcLdmS72L2Y413+9n+8NmBJaeZqPMxshmybS4Sk2AJ1ZXXq7AIEdFLlU3gWjHpkO9smwGSuEEGS6PAPoVskhhYcsSbCYKuevu89PfQyFsrum6rRGDU50m51P0m0gOQKpyQUwsLHwY7h4cC6SBiW3ixWdxmI0q5D12STSdbeG5ik2HuNUMoSjMn0TD6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DSVPR03MB485361.namprd03.prod.outlook.com (2603:10b6:8:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:11:00 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:10:59 +0000
Date: Wed, 4 Nov 2026 15:10:56 +0100
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
Subject: Re: [PATCH net-next 1/5] net: ethernet: oa_tc6: Allow custom reset
 settle time values
Message-ID: <aus8XiLynJmSXaXc@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-2-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103160918.409701-2-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPAP307CA0001.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::10) To DM4PR03MB5981.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 79d597e5-99e3-46d8-621a-08df3a7d7373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261021121427099003|261021135927099003|261022075727099003|261102123227099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	VE8y+7b5vsClHfhw62gyiI2HbXhI6cmnI7mE9v/7UAdCtdFLcQgFX4QVHh4C6Xwsr5I/aMEp+GIe4/UXPEMSKRBQccYzjZu5Qk6qb2ti0UNzrmZ6vyRF9rxV1oocqXKOep9T9BZDwptAfML5g0FOlcy4e6LeGOoV1RSlBK5V+1fNCceZe/bHIM35HoUqDVN6Ah1Lxyb5SHw1jO8ZFT5Y4C/H/Rotp/lJKEJl3xbNWXPNROP+lNJ4fLV/urHscUPHdWk0GLz1DD6ldwQ/gbhYXjBSXeT/W9pmY2Thuy1Bg60d9aZGGeEFuIpG/wLLs0rqZbZrxmjzkqXoylzW9sYLjyBhATiHOz0wGd4/VMXmy6v8bPD5pLY0k8IZQMMLkI6pnD829yIuZJST0qj88WB1C5VHVgJDLMJlIZlqcAx1GTm1l9l+ug/K4iZMs+nXtvYjFi0pSvxVguwyiTtP0stTGz/h5x2Lb55H7ZGusBOlbQyCSg395XVJYUj4rVtNm7Czm59VquNGRdKvAaUGpJWSF95caVl3CfgnfIiSl92FSaiW1LOkfohJ3xCLw9FX0CsJFEnDBhzAEk16B+WcTGiEVWeGZoA7qAC/ztJani+mu7egjhp16+CZFvlW0qkjH/Z1dLvDZ+ZVQCXWJcw3daZaCfa8JGNMe5iUmhNdbDuvyds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021135927099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2ZDQU16SlJ1S3RWYXlJR05TQ21tVmhWWVgwYS9pSy9MVFUvUFRWTGh6VzVM?=
 =?utf-8?B?MmVQMVpCMjZycVlaV3oxT3RZVTllS3M3M2swTjc2UE5QdDZZaW5iMDduTitY?=
 =?utf-8?B?cE1EK1kxUERPaWplL2RldHdaQThib1o0bWhDRXRGb1FGdUwrYm85bGIzK3B6?=
 =?utf-8?B?ZWpnbkxmNVh6UWZ6cytjSjZUWTNBaEdhZkRabkViL2hXN3pGakMrTVh5aVBJ?=
 =?utf-8?B?aDJjZ1FaVTRUVVp3N2hwR0lCTWJNN2hnaS9uVTFQZ0kwMFp4UktnSEJwSDJF?=
 =?utf-8?B?Q1AzNlpmNUVoelUwWUtjZ2VQaHpHaDBpc0ZTUCtmTnpiRUg3ZUxwdk1QdVRm?=
 =?utf-8?B?dW1UOG5nQkEzK25OeGIzTWg0WkZNL1cxQkZpa2JsQVQvdmlCTTh4aWJRcDk4?=
 =?utf-8?B?MVd4ZnZLQWd6dVZoMHNtZEVUckFVSnVxMWd0djZFTnFTZHJmRDdMUVpPZ3hT?=
 =?utf-8?B?SWkzcWpXejZvZUhsYXBEWnMycFp3RWFRR09ybGsvOWp3Uy90WU92ZHF1VllH?=
 =?utf-8?B?c3JzdWxqY2ZkNTBQMVZQRDB4UVVyak91OVFzbHZFV1VIdTErYXl6STEyZXNu?=
 =?utf-8?B?NlBtQThBbGxEdW5wNU9sbjhUV0dwQk9xS1YvZ0pLRFluaWhJY21SdlU0TnI2?=
 =?utf-8?B?dnlvWFh1YVNHcW92cmszZGNpSWk1ZFI3TkpVUFJYWC9GTk5hOTR0WmxBT3hQ?=
 =?utf-8?B?VFNGeWpjVm9ITjZlQXZEdWNhbUtyTTQzajdsWVJUcmExTzJIc3Y5bTVlQnZG?=
 =?utf-8?B?RFBqWEtsNTRIRUVKL1pGTFZ4WHVnb2pQa0tRUThaN3pkdW5DanlLUEd3VTBV?=
 =?utf-8?B?QlpLUzdMdS9zZmdJc084REFnU1kxWjVIQ0JneC9nT3NPY2pXdlNSRGtDazFX?=
 =?utf-8?B?T09oeEpnSXRqc3FKTjBlOVVna1I1RnZaM3RUQkxwUzFUcllZWm5LdXlLRmJC?=
 =?utf-8?B?R1lURmZUV1l5Tlg5Z3BGQW4zeU5FOEVvT21MV3FOYnc5SDdVUkw4YU5rMjBy?=
 =?utf-8?B?QTdNOXN6YkYzZms4QnZoL2FVRW9MZGU0R3I1NGxBSlB1RUFmbm5iZEZYWDds?=
 =?utf-8?B?VzY0WEhSNmh4b1ZYaDBKNkk5YUJqa1hGRkc5UkNlMFRIYktQQUZSaktQcTFZ?=
 =?utf-8?B?ZmZHMStSVHo3dlBNL25XYlhudFowbGsybysyZ251RDhyenovRmg1Tm54Vzg1?=
 =?utf-8?B?THRZMjZMMFNiVm1qRTBsUC8wbHQzNWlQeEdpZ2pZZHc1UjM0T3k0bzRDL3dB?=
 =?utf-8?B?Y0RsSFh4S250eHlTaFIxOGVxVGw0b0Q3T3VDNzhNUS9RU3dUZDU5SUwrNUpz?=
 =?utf-8?B?Mjh1QVdUSGMyT3VaVFhwYllOc2dnZ3RvcTVuVnRxSU4ycktkYnhTbW9oQUZO?=
 =?utf-8?B?b3pLZWxZelZnZEs5UHhFK0tpYTFQRVlyZnZRYm1mUU1ZUzl0N2Q2b3pTV2dQ?=
 =?utf-8?B?WGo1RzIyTDZYRnRkQWc2WEo5SDFSSkNQcEc4RXB4aUhudDE3LzVuandsVlN3?=
 =?utf-8?B?dDhlcTNZZFNxRFF2Z3Fnc3h1b0VhYzV3bHV1YXZCQUwzbmhIamxMbVVTSlpt?=
 =?utf-8?B?aFlOV084L3phenBCU1NnK0RCOVM0REtLU21RanZFQTdxSG53QTlhM1E3WSsv?=
 =?utf-8?B?VDJxYkZJSDNkRERpbWw2bUNCU2tDUks5bzdLSnhaU3AvaittMHVoR2lWa29z?=
 =?utf-8?B?MFdnd2cySTRieTBwT1FIRU9EelBUYTY3dHF0OU9oY0NBT2JYSHNwTEFpMWpR?=
 =?utf-8?B?UWpxSjVWSktoN1B4bS9DMEIzM1ZpbTUwbGhMQ20reGlkaU4wS0pJWkdFODJh?=
 =?utf-8?B?V2ZwcENZZWVtMmYxdEVxSWxtL3hWajBPamU1b1RjRnhGWGdnSytYbnlWVkxH?=
 =?utf-8?B?eXJSWWxFT1VsQng0M1FkNEZQdWxUNU90REFGWHVjQ2xUNnB3TkNpMllleUx1?=
 =?utf-8?B?ZzVtZjEzOFloeFo1enBteW0zUHpRN2lpaXNUb2RzWGdpMmx4aDNOektnNUJX?=
 =?utf-8?B?dDBMYzhaVGdtRndYdlQ4d3dsV3puOEpFZVlGNWliK3FuRndKMkx2L0xHWFY2?=
 =?utf-8?B?enYyaHN5YXNOTHBoYndRTVNtWFN4L25va1dEQzR4YnFLMkJWeTRHcmhyNjZl?=
 =?utf-8?B?b1poV3dLWmcwbTQ4R0s1OUlvejB4bDdZbFBEbkJHZEd1b0JXQ2NiaEVDVGZJ?=
 =?utf-8?B?NzZCK1J6amhWakpSamhvdWNGbDZQdTNkcXczY1hCdms1YVFza25mbVltai9Y?=
 =?utf-8?B?SU5ubXhtUnhCTGVkd1dlUE5sdWV0WDBLcWpTcnRaZXI2SU9OME0zS05UbUEw?=
 =?utf-8?B?TXBjS1V1bGc0N0NLclR4RkNnZWIwL1Z3bXFIUXlHOXRXWEN6VS9vZz09?=
X-Exchange-RoutingPolicyChecked:
	UgQ0VaLZxmPgkrFQrXiVJKFWPx1emVGFLQnG3a2fQM09p8zi1ySC2bd8g74usWOE2pSDl9LOiYmyhtuMdIoSEMfEA600GHx0MFBwgi1+pZjZxiONjpAAQ/EB1nJNWRxcwEf+V3Z2hbpkRdFSbYb8gh+FtrB3FZ2q1BgbSDVywpJejXvDUwDoSRqei9CDKbKDL7jAtDm5g0dOQERZ+EDNlxuUbU3+DzXHFdQ8nwoogG018rgXN7OioF0zI4bbTLcC9YMUU7QSVQsQGj2b2JQrHizz4PjHh29lyQ9E5S/AMhj6Ewles9KqOSNdHBsfKo2qIN+RJkpdvjWi5fwQc+6A4Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d597e5-99e3-46d8-621a-08df3a7d7373
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:10:59.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18f1YJdaB1FB4vWoVGvJqwgcmveJe5n0xc6x90VzKZPlTTWwyCFkWzCLcehD+xbdMNuf7HfmGIAh127IDU+HaC7m+eyOSB/lEzBMVSeOsvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB485361
X-Proofpoint-ORIG-GUID: jNecHAJzSAA7_hAGlidhKkjNhFUIORoB
X-Proofpoint-GUID: jNecHAJzSAA7_hAGlidhKkjNhFUIORoB
X-Authority-Analysis: v=2.4 cv=Y7RtIReN c=1 sm=1 tr=0 ts=6aeb3cf6 cx=c_pps
 a=/qs4bcqls8FpsUBDM29/qQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=yGNFWJL3veEjvfIGQkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX45oAtRV9OQEx
 ZgqSi07XmhQ2opAF3Q5Gyp7iXB26A1drajPst11zydpyb0ELZTfuJhOZvOlpAcNg2j5n5h1bxvv
 +Cuei0UlP1Zg53lbXyGhDZc+N+rNzCaXT3RkaQf0t8dWfUra5zrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX2O/ahkyflls8
 DhK7bMW7YfOK64KmvCO7vZmzw5MzXhjKcauJxPQoxaQkJPB+khG498TEe8h5wMkf67zrBpDmt+W
 RYg8W2/STJWnuvoY6XL8Vi20a9o+4MpybTVxuww24VhVOV4iRJ7b+kkXPtLvfyLBFBSMwRxKP7S
 mM3Rh35Rsfhe6sohtN8cNs98Hz7azNrIf9+n8lU56IBbTdGCI5NQrwJwqNu1jzaUOjXDFRYWWeh
 DGaePMIdWB1usIMwMNwUqJQNzSgOGvbPBitv00SIeUep3L/wYzQYnQ5oef9DMekwwnPzm3tsJYi
 ZMxGrnmkkoeTMY7t3o9GRYOkOO/nJlpDF4UbWNoj3uu1UpjPc+Ecjdd3j/LyHa+eTe/8FbwzWA3
 NJiAgEqH31JXgyUPzmrgbDAXn/YrS3CPUSdpH4vT+BpdXeJJh6BF1wiE/PGItdaC4N1XAbR+huf
 CCrf5Pqk+/cI3E+bQBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040056

On Tue, Nov 03, 2026 at 06:09:14PM +0200, Iustin Stolniceanu wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> oa_tc6_init() waits a fixed 1 ms after deasserting the reset GPIO
> before accessing the MAC-PHY. The reset timing parameters of a MAC-PHY
> device are outside of the OA TC6 scope. For example, the ADIN1110 needs
> up to 50 ms after RESET is deasserted before its registers can be
> accessed.
> 
> Add a reset_settle_us field to struct oa_tc6_quirks so drivers can
> set this time. If it is not set, the GPIO reset keeps the existing
> 1 ms wait.
> 
> When set, also apply the wait after the software reset, before polling
> STATUS0 for RESETC. This is needed for devices that tristate their SDO
> pin during a reset. Drivers that don't set reset_settle_us keep the
> current behaviour.

Would it maybe make sense to split this into two quirk values? Something
like hwreset_settle_us and softreset_settle_us? The ADIN1110 datasheet
seems to have a slightly lower value for software reset.

Either way,

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> Co-developed-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
> ---
>  drivers/net/ethernet/oa_tc6.c | 18 ++++++++++++++----
>  include/linux/oa_tc6.h        |  2 ++
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 364027c39fa4..68437b226528 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -89,6 +89,7 @@ struct oa_tc6 {
>  	bool int_flag;
>  	bool disable_traffic;
>  	bool prot_ctrl;
> +	u32 reset_settle_us;
>  	enum oa_tc6_quirk_flag quirk_flags;
>  	struct gpio_desc *reset_gpio;
>  };
> @@ -652,6 +653,9 @@ static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
>  	if (ret)
>  		return ret;
>  
> +	if (tc6->reset_settle_us)
> +		fsleep(tc6->reset_settle_us);

If you have a separate softreset version, you can just set the value
if (quirks) and flseep() here unconditionally.

> +
>  	/* Poll for soft reset complete for every 1ms until 1s timeout */
>  	ret = readx_poll_timeout(oa_tc6_read_status0, tc6, regval,
>  				 regval & OA_TC6_STATUS0_RESETC,
> @@ -1474,8 +1478,10 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>  	mutex_init(&tc6->spi_ctrl_lock);
>  	spin_lock_init(&tc6->tx_skb_lock);
>  
> -	if (quirks)
> +	if (quirks) {
>  		tc6->quirk_flags = quirks->quirk_flags;
> +		tc6->reset_settle_us = quirks->reset_settle_us;
> +	}
>  
>  	/* Set the SPI controller to pump at realtime priority */
>  	tc6->spi->rt = true;
> @@ -1515,12 +1521,16 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>  					     "failed to get reset gpio\n"));
>  
>  	if (tc6->reset_gpio) {
> -		/* Keep the reset asserted for 10 us and then allow 1 ms of
> -		 * settle time for the crystal oscillator startup.
> +		/* Keep the reset asserted for 10 us and then allow the reset
> +		 * settle time (1 ms by default) for the crystal oscillator
> +		 * startup.
>  		 */
>  		fsleep(10);
>  		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
> -		fsleep(1000);
> +		if (tc6->reset_settle_us)
> +			fsleep(tc6->reset_settle_us);
> +		else
> +			fsleep(1000);
>  	}
>  
>  	/* Check the PROTE bit status so that we can reset the device */
> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index 27f652d4920b..139dd4c33950 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h
> @@ -72,6 +72,8 @@ enum oa_tc6_quirk_flag {
>  
>  struct oa_tc6_quirks {
>  	enum oa_tc6_quirk_flag quirk_flags;
> +	/* Wait after the GPIO reset (default 1 ms) and the software reset */
> +	u32 reset_settle_us;
>  };
>  
>  struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
> -- 
> 2.43.0
> 
