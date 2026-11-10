Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794310987;
	b=F3GiJ7ykJRYPChjKrUU6KXKz2lCqDITGq7QZeDtto+rQS55KEghD0aSm/PZISarZ2zT2
	 Q4zV/Brkx1VJkUMGQQ08rohWu1UhyCZoVmQKJf6SFwNASHtjKoRdqR+3l6s4YAYyxU3RX
	 c3wdCs9mXJEGkM2N3UaeXCGDPuB+Psq4Q3iStEw4rpy+746XO4bjEbcSgPv+6pIhs8Y4F
	 t4LsgYjRMyYtYYeUTHAGWlKHA7WwyxC6CK+Y0td50vLao/yV7yThFyBRToAwnumOvQ2wP
	 0PHznBfjieFj4+hdichwimdPv4dVpolQQCOSfkP0shnCuFODq37o470Qu+Qmy8ZYnew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310987;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CyRTBSd4eog+UQSbF3AGOcW7ej/XlHx0mO7UwzoYECY=;
	b=OeIt7DwprE0MgAWKu+IibTyRu0wHlxSpcyfgENHN590cEeK/V2XkxZ9rAtkKiC15P+QI
	 bK73B7yVNb7qOwbDFoAVIIVOYHwsr13/aEngSAJ85i2HXmvX5zaqw0G/5M6M06rv0VC2i
	 FgiiPejwZdglBYJbGrcMOAgvzmpfaHb7+yeOmV2onH42ockEE4SRQsTPDQ/qsqYrM9LI1
	 0SyTcWZXW314M4zHmbCat8YgaskhXF3kV0Yd8FT540+6YaGIh2fk57sbTHlMhS6cdvs0W
	 mHIriByv+bmfnA111TYaEMYLIeJr1+ExgnykiS6df38+/5rWfNnwBCerEOpUfeeO3jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=hQ7dvdCY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.74
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023074.outbound.protection.outlook.com [52.101.127.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D998606A331;
	Tue, 10 Nov 2026 11:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D998606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=hQ7dvdCY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unqZkoNpeem/VQHgRElIFlk0GOisZhzZy0MiJ6e52AI8SCOctYuY+54OE0lpvmhNp+La8ZJfwhsxij6LlWvD41TkMGRmpKtsM3wgmvk3bagCEVhWy7QdGvPDgWEBX3vTZ9hdxQ1NZEG0jPaJorA0U9c7xvT1uJa2wurg5AEA6QyrS9xsUL7S2quU9PlIns300Sr1VJT6s3HJmqpSMQENPmR28NdpNt6QcqJUHxRPnzdZB0ods/4Wl3hdyQ0NvzFYRDEmzS9ljXwWfOFD67kIHQhg4d3ZR6SUu2VN5q4bQadELv5nuO1xH+DkkurqUtckzGSz6AVsxs/BR3LNkF/OnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyRTBSd4eog+UQSbF3AGOcW7ej/XlHx0mO7UwzoYECY=;
 b=FY/GeYcXiu0fTLJFiVOYzhTFzMYY5jqWmTy1/ezJyL0gJ+GrVqg3JRy+0abZpE2XmzvuGMmDLQozA+ugcG/C0JiXL2CnYIrB5xnaBBsdDqU/dEyF25G9THvpmV2T1aoe1p1ENuEiTi3Cv33fD53E5vYVuSVhUUqB6ExaO0Y6PAXJ6Z/JXNyZy6VZeQK8RD+lJfbAQLqx4nVhex8yjdT9ckf3poekrTDtEiZMyjbOVoj4GlAsgfmYnNRoNlo2NGHW8raHBZbr8zb2cM1T5uxGdgYIYXq9UeCHWdJXKM+Hkrhh8Kv41+6SWDKeCVJlv9CVzlaZBCWaEHklRaHwY6UxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyRTBSd4eog+UQSbF3AGOcW7ej/XlHx0mO7UwzoYECY=;
 b=hQ7dvdCY33Jq1DDXJZ0OYbrGm+iekadDqKaZKBP6RU2HgyMIvFUwuE2I/naM/mtP70zjBdPJPqlZ/kpMYlv3eTXFWsR5/8+UyOrdMon+q3MZnxLS8rejPk1BvfKt20G3EoLiHvzyHeFJWg6qk7H8IC23lgJsWs/0KIeUD1nE6VJiMhrRODj/TrxZijAb57neloip22j0+UfAEegGmn1xj+Uhvha0MTzxmgOSjjnIMQPD5UkLWG8JoxPWVrHyr9DEbyi3Txgn2uJi7gAZBQXoo8Yb+DgwFNq+Kibq9j9O4pniWVus/sLpZycQiGNICzzbFiYTEgBPDGAUuffnW8qgFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by JH0PR03MB7853.apcprd03.prod.outlook.com (2603:1096:990:33::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 11:43:02 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 11:43:02 +0000
Message-ID: <bbe0dedf-4b02-4cc6-97be-accfc06baa10@amlogic.com>
Date: Tue, 10 Nov 2026 19:42:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
To: tanure@linux.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>, xianwei.zhao@amlogic.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261103163715.385394-1-tanure@linux.com>
 <20261103163715.385394-3-tanure@linux.com>
 <20261105-stoic-cricket-of-tolerance-cb3014@quoll>
 <35dc1ebf-5194-4ec8-adfb-dcc8ea717750@amlogic.com>
 <CAJX_Q+0QqBHGv-4nfmY8N_xr=KQgUFtwPQTVZBxTK1LHV0jGOQ@mail.gmail.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAJX_Q+0QqBHGv-4nfmY8N_xr=KQgUFtwPQTVZBxTK1LHV0jGOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
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
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|JH0PR03MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6351b656-5a9d-4269-52d5-08df3f1fc6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	+UevEOhqQfR/thcKvJmA5gT0pu7eoGYwNsQIaRRV16rnomwNhL606OLIp4rQEXKtQ58bOS4EcJYzxuiU1pVzQvUH2bfUIXDmYUoSZVCu2oV6+dm4JxyECp5rO0LqkIJLA07gxtOGm6/tLHu6rJL+YE0+DgG8ApGdV39t5j2xoHnCzNSZyeMlrq+Z1Hq7GXpiy6ChuUXSoS7LScRu3QlSjbc0Z5CKROv2ACHaM+czzgsyyAU2/NhWeaPs3o82Frt4WdUc+A/VqbSZi9/OGJls/N2JZSHXj9euj2gIkMDe/jzXF/kN0BkifSUQ4P3eXbrFUqwG05j2enBVSnRzRUtEJ9zIPtXcogqMtQN7dejwdYvstfjlsl8+Am8uT9oy8rfvnkPC8wcf8YjJ61p9mYg+HPWbx1AQXSzvgjFE0w4opy1HZ6f6hW2c47nuX6F0BriUW3R1wvHemLGacbznDdeTI1IRf6/eTv/thX76F3Ed6sQkR777QyWpaXSGE+z8S+NEwMwZQtSpyh0oyEu68qxRyZ943PVlvQjBmQ0U4FkodFjVatrHppVO9gtakCFtFrmgT9lrN44eN5wk6Rk6Q8c3BcjPbxdEoR3dXrTNx/8wksHSbbWm+YQiwCZrF0LEQtWS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmhDYk96c29VTXNTSUVNVllZRERiWU9lTGNxNkxWMFIrS25odUJjMDkwQks2?=
 =?utf-8?B?SitBc0ZmcHMvVSs1UjhCbTJwazBHb1FjcEdEZHo1ZTgzWUxSSTU4eGhaYzlp?=
 =?utf-8?B?UFQ2MjhobjBCcmVQMmpzT1RtRGpCa2l3T1ZWcnd5azRhZmpZbXFUSG1pTVdO?=
 =?utf-8?B?d284c3dRaXg0S2NZVDBRVGNOTzZnU0NTOWFNSkxWSVRYVFZFUTJWZUx5QUxE?=
 =?utf-8?B?ZUwrUi9iQlRMdmhQcTZaelU5OWZ6Z0pnUHpMbUhYUzhBYkFlVUszSnZRUkFl?=
 =?utf-8?B?emV4VDdnTlQ5UER0SXF3QmhJbEN2V1kvWlg5SlQxaUJ5b0dZOXBIc2d5ZTdq?=
 =?utf-8?B?SWJVNTlDa1ZpQnkySys3MUIwNFRiNmo0L1FyZTFUeVdXL1R0U2xFTjhBQlBY?=
 =?utf-8?B?bXo1bXNvS1RzdnpFOGFldTZhQ3Zxd2xZWVNFOE1BemhlZ2VFd2cxUFh2RTZL?=
 =?utf-8?B?RkNnUk1yTEVTUTg1QWRpYkwwUnlhRTdvc1ZVVy9xUDVzS3BnSmpvckxWL2ty?=
 =?utf-8?B?T1kyZTNIL0ozUUhESnVTYlYrQWRSYWswYzBXWENBVWRNMWhoZUU1Ti9WZ1lV?=
 =?utf-8?B?VkdyaVpKM0pmek5ibEw0YityNmlCdEJORldqV0NtYTI5OHQyQWdrbndtZFZ1?=
 =?utf-8?B?clFUV1E2YnZienNRS0s3V3F3dUs5QmFtcEkzMkRMaDlwbUlxcWJjY0RKVVF4?=
 =?utf-8?B?eFZ5TVpCdG9BZ3JicHk4aXBueGFqZDdJVVNjUEk2NHFLNXJjMDY2dUJKeEU1?=
 =?utf-8?B?UnI3cUhKU2pVVnhRUmp0M0lmSlFOck1mdTN6a2xIOEVIWEtDMFE2L0VuL2tW?=
 =?utf-8?B?MVUyeU5adnVEREdYcDBGd0tjU2piOFltMElYSFA3bHVVd01RT3RrcWJuSFlz?=
 =?utf-8?B?bGtwSy80ajlIZllqOUl3SFliaUFFZnNoTVJGaDdoWkFBZUgvZUlaTWZjQ3da?=
 =?utf-8?B?cndyTGtTcWd5ZDVOdGFHeVBiN3RWNHU0NzcwUTZhaWhsL01DS3VCMkw3dFln?=
 =?utf-8?B?dm5Nci9JcmUwZkFCL3dGR015MkZkZTFjVWVtWElmTDBuZWIvN3l4Z3N5bmNS?=
 =?utf-8?B?VjZ6Zk8xelVEdjg2aVlDdm05ZC92L2lWSVBIZHRaT2dGaW1JS05hY0pNaW1Q?=
 =?utf-8?B?Y0J2UDRxRldDaVFHaWJ2UjJ1MUFyTU9xVWh2QzhLLzZMcGVSUVREbjFOUmRx?=
 =?utf-8?B?VFo0ZWVZWUhieUtjekdLT1E3SlBHckVZK1FOUVBZUDZJM2lFSlZ5NHNLM2k3?=
 =?utf-8?B?OUswSTh3RDI5RkR0dmQ3ZmJwYmVVZFlBT0JyZUhYRitNRTVraXVKaUJsWmdZ?=
 =?utf-8?B?R3BtMCtNSDZUT3ZUOWpqZ1ZMelZ6U2pMdlVrNStwTFA0eXRuakVPWlZPOXNj?=
 =?utf-8?B?R3BrTnY5ZCswNjlVeS9Ua1FOVXRlL1VXL2JsYlR5cW1hSlp4b0MxTkh0djhV?=
 =?utf-8?B?ejJtYWVZdFRZV0Z0aHM0SHgrTkhPQTQ2VTI0VW1rUHA0RG96cSswaDFYYXlR?=
 =?utf-8?B?WGhkMkM3UkhCb3gzYW1ZYzR0WjlRRmVudlRqU2ZTYVQ4dkR4SmZTN1VraW41?=
 =?utf-8?B?NWFvc09lSzlpQnBWcWszRDRKcU56amtnK1F1cExFUE11RGhJMUh2UlJ1Y3Va?=
 =?utf-8?B?bUgyTmwzQmhkOWY2NytFejh6WUNLdEVOSDdtcFcwWWFrakg3VURWRUg1VDFV?=
 =?utf-8?B?Y1ZWSWlvT2VuT01iSEgzNTY3MWJrbEU2aUdWQjFZc3ZBeVVoWDNGcm1EQUFm?=
 =?utf-8?B?Njd3T3pFQUlyaHB6bDQxaldZSFFuRmo3ZGExSit5Rm84ODU1bTdvWHZTbGFj?=
 =?utf-8?B?RWROY1dEVk83c3dXcHMzZFZ3dWRsbmRvOWR0c25sZjQ4NXNTMmZmYWMxejBL?=
 =?utf-8?B?dHM2V0w5RGRPaThLYUFKRCtkYzlZcFY0VXZ3Q2UwWWxkMDl1U05Dc2hqOEtm?=
 =?utf-8?B?MmhGaFlLYmsvSzhJb2tWeERnbXFqUFFJcWliMlFYWnIzSkhDMmo4dVRoaGQz?=
 =?utf-8?B?T2N4MTFhZlV3U0tWQTA5TVVMK3Yyd3h3aEtzMEFIS29WbCtMbWczL2RORW5p?=
 =?utf-8?B?M3RBQ0dCeW9vdGNncmhON3B6QTRSYmxWdjFBOEpyUFFzaVFybndFWHorK0k1?=
 =?utf-8?B?ekFSeEFsREtDY1VRNDltWElHSkloZHVtdHQ5UWZ1WjZuZ1B5aHdIbmhhNnpk?=
 =?utf-8?B?NzBScE1la3NkSmJHalM2SGFXbjdyZisyd1pPWFd5dGZuN2VyWlVtTW9LRkdK?=
 =?utf-8?B?QTljV1Q2bFJ0anVubjFsM0swNkMvc25kNjdWYk44RUlIbVZxQms3THRPbGcy?=
 =?utf-8?B?YkpBTkIvTnBhZXdaSWJUZ2xPbm5OU1MrbDFhSjl0SG9pc1FESXZVdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6351b656-5a9d-4269-52d5-08df3f1fc6ba
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 11:43:02.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBu5W4ichdR5Y1ByL2JbCtVRXdKnh+YjL7kJwHAD9S0yW2cc4ZQimBH6HVaJJ9dTuz3xgSKymyVYs8fbfG8NIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7853

Hi Lucas,

On 11/9/2026 11:43 PM, Lucas Tanure wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Nov 6, 2026 at 3:16 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
>>
>> Hi Krzysztof, Lucas,
>>
>> On 11/5/2026 7:57 PM, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Tue, Nov 03, 2026 at 04:37:10PM +0000, Lucas Tanure wrote:
>>>>
>>>> Assisted-by: LLM
>>>
>>> Drop this one.
>>>
>>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>>> ---
>>>>    .../bindings/net/amlogic,meson-dwmac.yaml     | 59 +++++++++++++++++++
>>>>    1 file changed, 59 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>>>> index e769c9bb70d8..6de013e3e8f6 100644
>>>> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>>>> @@ -23,6 +23,7 @@ select:
>>>>              - amlogic,meson-gxbb-dwmac
>>>>              - amlogic,meson-axg-dwmac
>>>>              - amlogic,meson-g12a-dwmac
>>>> +          - amlogic,t7-dwmac
>>>>      required:
>>>>        - compatible
>>>>
>>>> @@ -57,6 +58,59 @@ allOf:
>>>>                - const: clkin1
>>>>                - const: timing-adjustment
>>>>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: amlogic,t7-dwmac
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          items:
>>>> +            - description: GMAC main clock
>>>> +            - description: First parent clock of the internal mux
>>>> +            - description: Second parent clock of the internal mux
>>>> +            - description:
>>>> +                clock of the pipeline stage inserted in the bus path between
>>>> +                the controller and the DRAM. Without it, the controller cannot
>>>> +                complete DMA transfers.
>>>> +            - description:
>>>> +                clock of the register block holding PRG_ETH0 and PRG_ETH1.
>>>> +                Without it, the block reads as zero and ignores writes.
>>>
>>> This sounds like you take clock from other block. That's wrong, that
>>> device should take its own clock.
>>
>> I see that the clock in the dts patch corresponds to <&clkc_periphs
>> CLKID_SYS_ETHPHY>. This clock provides the working clock for the APB Bus
>> of the ETH PHY controller, and this clock will affect the register
>> reading and writing of the ETH PHY (including the ETH_PLL). See section
>> 15.3.4.2 RegisterDescription in A311D2 Datasheet for details.
> 
> Thanks. That section is the PHY block at 0xfe028000, the region of the
> mdio multiplexer node. The registers in this description are PRG_ETH0
> and PRG_ETH1 in eth_top at 0xfe024000. On the VIM4 the same gate feeds
> them too: with it off they read as zero and ignore writes. My datasheet
> revisions do not say which clock feeds eth_top. Can you confirm it is
> this one?

The information I can confirm is:
   - The base address of eth_phy is 0xfe028000, and its corresponding 
APB clock is <&clkc_periphs CLKID_SYS_ETHPHY>.
   - The base address of eth_top is 0xfe024000, and the base address of 
eth_mac is 0xfdc00000; their corresponding APB clock is <&clkc_periphs 
CLKID_SYS_ETH>.

The CPU reads and writes the registers of these peripheral controllers 
(or Processing Units) via the APB. Consequently, the registers of these 
controllers cannot be read and written properly if the corresponding APB 
clock (sys_clk/clk81) is not enabled.

> 
> Thanks,
> Lucas
> 
>>
>>>
>>>
>>>> +
>>>> +        clock-names:
>>>> +          items:
>>>> +            - const: stmmaceth
>>>> +            - const: clkin0
>>>> +            - const: clkin1
>>>> +            - const: pipeline
>>>> +            - const: pclk
>>>> +
>>>> +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.yaml.
>>>> +        # The RX delay line of this glue is fine tuning in 200ps steps,
>>>> +        # added on top of what phy-mode describes. The TX side has no fine
>>>> +        # tuning: its only step is a quarter of the clock period, the full
>>>> +        # 2ns at 1Gbit/s, so the TX property is not accepted.
>>>> +        tx-internal-delay-ps: false
>>>> +
>>>> +        # Deprecated: new SoCs use the standard *-internal-delay-ps
>>>> +        # properties instead.
>>>> +        amlogic,tx-delay-ns: false
>>>> +        amlogic,rx-delay-ns: false
>>>> +
>>>> +  # Delay definitions for Meson8b and newer
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - amlogic,meson8b-dwmac
>>>> +              - amlogic,meson8m2-dwmac
>>>> +              - amlogic,meson-gxbb-dwmac
>>>> +              - amlogic,meson-axg-dwmac
>>>> +              - amlogic,meson-g12a-dwmac
>>>> +    then:
>>>> +      properties:
>>>>            amlogic,tx-delay-ns:
>>>>              enum: [0, 2, 4, 6]
>>>>              default: 2
>>>> @@ -106,6 +160,7 @@ allOf:
>>>>              contains:
>>>>                enum:
>>>>                  - amlogic,meson-g12a-dwmac
>>>> +              - amlogic,t7-dwmac
>>>>        then:
>>>>          properties:
>>>>            rx-internal-delay-ps:
>>>> @@ -142,6 +197,10 @@ properties:
>>>>          - items:
>>>>              - const: amlogic,meson6-dwmac
>>>>              - const: snps,dwmac
>>>> +      - items:
>>>> +          - const: amlogic,t7-dwmac
>>>> +          - const: snps,dwmac-5.10a
>>>> +          - const: snps,dwmac
>>>
>>> I see no such hunk in the code, so not sure how to review this.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>> _______________________________________________
>>> linux-amlogic mailing list
>>> linux-amlogic@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>
>> --
>> Best regards,
>> Chuan
>>

-- 
Best regards,
Chuan

