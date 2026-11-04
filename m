Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793785180;
	b=FMUtexGyZ7Hgpg1naap7B/DvnOQBiRR2R/k5aGF8QhD+jhRsa3PD/v/BYQMIDjB4dP82
	 2yK8Zomm/5EFjy1h8izMtwU93cMzQCIfqvJDNreHQEs0HojOAvdt1mR4btZjZ0P1LfE+K
	 FnJ4xaGw5tTZaTTGIx9EK0GH6EhVKcoLZGeVYYV4t5g8cVt3LnPRCjiWvsv7fczSJQ0Fc
	 T2UMPxBTXC3DWCsk2fEJyk0LT+qEgNEL3zoze2vH7uW9/cH0mxqDnxEbBDZ8bbJ1zndqN
	 QIQpqkBgSAcrsviJvBZyI/ak6zaF5flZMNljf1OqcQUaDBQqJbuiDWvEEBNKoD8aLcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785180;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Q9gWlkU9iD+sPfwuubzYbaViWyjwKjPDBkj2h9KdhN4=;
	b=pCi3PdWbsPmbUNZurLUpyCtPPwy2z3Xzqm5Zst9OfbA9fOGVY7aHKCzR8QWWXU/Y8ZsI
	 gVyI17+vKw/Ufq0p6HB0/pqx6KO//i87YqZ0h25eU2oTi3Ry3fU4ChldAc5HB6eNbmV5q
	 OXbK+9IQoK27pB6G/MyIoaXi56MV7dAjtdRrZjzRpiUidq5rEp8k2iPGXR7Jk+7JHl7E0
	 /9b0XICwzRMmgGPq24xj+4gRuSBiNvr2SbI/mIC40zXt4qdUvotk8e1VmFEkKB+XtndGN
	 hXbq7+kK82gzw402bqU4sup3TMPXPH5G4X0NiB2ToJrbG5WoL6FVHd3nhoxMpKf9FxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wUClb9eA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.56
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A2606A32E;
	Wed,  4 Nov 2026 09:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75A2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wUClb9eA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRECCq5b8YvQ+elPjwc8Xej/+r4iNFwJhvT5E35D/hteHGrk7ZPiszNsWCiPrzGAhkiOennrJwZP7Eo/gBceq01/ViiKWPdc5vWC10B5M2gFI9c/JqDDHEeY947hIhcSweCRcH9HkBBk22vkach3291h9l3tqTuRkkpbasAA+//1XJFLxE7aS4uxBThlJq8WvtXEDjKz74aaYlOhVd4qbsfouZobnjbGaVn4S9ZO2DjpPlz5gVmu0saKirrcyUt7HfrBc+cVj73vXn9PE7hFCDUy10wYJDDkqjiMa++kYvHCQrQDmr9lZz40xTUMdj1K8MxCR6eYzVqIpEZiPvQptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9gWlkU9iD+sPfwuubzYbaViWyjwKjPDBkj2h9KdhN4=;
 b=ZP4HnFh4gXfErwePxibEuHORGhu9PpWI4qyyuoedPpmNevslhgBvrjCnVCZ6iRqsqBpOaQwS7qI1PMls2bc5SP2zbTd6FbNrfYSaOj8uzXtzBgc64OZ3d6jXMTncms2alSaR4spcal4ABqm+Fov0MhHX6kF7Yr5fEXzjmIx3Ne19L/VSJlVTcwYpVO/MyyzNEQ+Cm0QztHuBcrmrOEUk1wuM8dOXlKjQt8d+xm7cQDqHNEoDzlhyKNkpoSLohKi02i43nJ7fBxk7wwwcO5qTiHHevuV3vecBM9HRw/vgzNe0ctpLlDw79ec8ktbojeYLsK7meepIfMCu/25MuzJw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9gWlkU9iD+sPfwuubzYbaViWyjwKjPDBkj2h9KdhN4=;
 b=wUClb9eA6JgmOnyiSyJSc7cNrBVKTBRm/IGhIjI2/SkAE2gT3zSpVj4YXuJpxUaEQS82tsoapeNcx206Z144rdj028ARODzHVfAQ5hd5cDZf87YwNzpwI8fszRrp3Hhl0065IhohVMUtF2wkyesKgs+MYM+/vdSijRKEkmMCpY2m4R3grpzRJ6q/x2thCPRsJIxAZhyjDdprEPlRmgzzSbOS5y41bEY1a6ui8CpCY/r0vIFB3oyUuhyPmnCt5CV864p+qW72tYTQ5XHZpPRLAVT4BjBUr1u+NWC+6VSYllpvyjDgKIfXP8bQbrK3FNqAHbkRs14c+Ocrlz5E4jeYFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 4 Nov
 2026 09:39:32 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 09:39:32 +0000
Message-ID: <80a22fef-2ed7-405d-b48b-75ec4316f6fe@oss.nxp.com>
Date: Wed, 4 Nov 2026 11:43:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] ptp: netc: use 133MHz as the default
 reference clock rate for i.MX952
To: xiaoning.wang@oss.nxp.com, netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Clark Wang <xiaoning.wang@nxp.com>
References: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
 <20261104092217.1730351-5-xiaoning.wang@oss.nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261104092217.1730351-5-xiaoning.wang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0135.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::32) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cdac61-57a4-4ee8-a9fa-08df3a57877b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|7416014|376014|4143699003|22082099003|11063799006|56012099006|18002099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	jv+5Zsi3a9Nb6gFya5zXwWfueUHaM3rkOZ9og+sg8Go+had7T7G3RZ4rGY0h/dXrJog88L8zEJ27k7oe1vcOTktVrYR+duLh/K6PfJ2XO5lLm3ikixO6M2nvtVxru2Z0yacaRWsVTVgAFvQgztQQ6bHFsp9ocXSATcna9bmyd9kgED7Q3P6/rOe5EX7JfGIJah7rZVDXhQwOCRoPth5I7rKoOc6kqjzW6RbasPM8T9tBjcKj8FULzR5RNJY5v/XVwKVpOhosb8XEVNecC61rD9tVh/JH5ICgbdTsj459bB623Ev3ZG5kXw2ptVKOWBiRh3blAe8gybIbotz1zAj5ITVF3x2lUNLEK40dmxrRefIqPj1AjTKmUN8tiA3cRK7acQnLzBQ9B4W9Dx9YeC3RvBHWWBWBO4S+xlwStR99AUduwW9URCRle1mWhsfU+SO1cO2CQ8MVJM1FTpPKuEWDExbVUVXO+7PqkoD/rvrdDUSNOcBpVmWl+WJO3rgxtkdAO6Rzh1tU2C+47IFlxfLWiGZwkz/E0ZZl4ceY5wpIUC2UHm5wvSq5q1tAE+6dhzR84I5ISJzUKhwnMZMWTp0oI+Qjtbc1KU81VXteKmk2uPxvVy4WmwPU/70WW9hAxp3/Ni/LQmacYEAfkXz5e2UTwpPrF2b45j2oUSdDQw6zot0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(7416014)(376014)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGRuRndQdjRtQ04waGg0M0pQRzh6bWp3T1g1YkZiU216MjhTU0s1ZFdaN045?=
 =?utf-8?B?RkR6eDkyVHNBRVZiRVljZVpqVzJwYjFMNEFpY3VBRFQyV0IycENGS0JNRnlV?=
 =?utf-8?B?QkNOYXJJYkdDakp5NytaeEFsN2JtNVk5VHNsMDBxa2RSdUREaGJUWThzNUw3?=
 =?utf-8?B?c1cwQXJrM2hHMURWYlJRU1ZlaGtIczd1TzhzaE05RkpWcDdqbm8zUnFFdG9S?=
 =?utf-8?B?Q0phSjBiK0hpNmIxU0tLR2xUeEx0eGNUemltWXBXQVRSSkEzakhoVmdQaW1O?=
 =?utf-8?B?SWh2ZjZnMUNHNVhtOUNqOGtqNzczU1g4WVpWNmZQTmxibmZrYUR2OGc3Z0pQ?=
 =?utf-8?B?QjlOT0t6YlVCbURDMVVvN0F0bGl2OHlUNGZzejQrVE9zTUZmK0VJakxDS3oy?=
 =?utf-8?B?WHpmWmJnQSt4aFd2M1gzeVBDTkNkQlcySVBUODduYjJWWWRoTWpyWFp4cGw5?=
 =?utf-8?B?M2ZzRE9VNmkrNTBFQThuZDh0TUF2ajhwYXdRV0drMCtVekQxMXFNdkI4ZHJL?=
 =?utf-8?B?VzJkWEtKMGFlMGV0NGJsUGdRUFI3ZTR1c3FzcnJQMU5hakZYYXNvWjI1Kzd0?=
 =?utf-8?B?UkJDY1R2aG91eituSUs1dXYwNFNSTFhRVUN6a29aVE4xaGFiUEtraXI3Ymho?=
 =?utf-8?B?eTQzTUU5S1I3d0NPUUxGUkJLekF2eGpFeWpmNlZQVlV1NWlSckVobURTL1BW?=
 =?utf-8?B?OXN6b3NPcUE2aWR5d0VWNVMvcEtTKzgxYUUrMTNseW56MHVFcTBuSUtaRGQw?=
 =?utf-8?B?K2RidEl0aVptTzNVMXpBTXh4b3o3Z0QxRmtiQ1JCNzJPQkZCa3JrRHpFdVQw?=
 =?utf-8?B?dVQzNFBkd254NWxDQ05GR2lZOEErUnpsZUVlLy9qQlhzQ1lyeW5GYXFrdnc0?=
 =?utf-8?B?Vzcrdm90Tk5vRUh4TnpubGxVQlZMVlV4cno2RGh1RHBHYVFiWWo3V2tJdEFp?=
 =?utf-8?B?YitNWktCeUdZdDI1aGlaYXNacExJTk14YWdUVUNIK0w5OVk3WWhRUVRBMHh2?=
 =?utf-8?B?WUFGeW0yNGxJbjBUL1IrdmhUTUxqVlR3bk9TVVd4c0hERURld01nVFFJMC9j?=
 =?utf-8?B?MzBtRlQzbDJjWDY3YTcvYTliM2x6RXduQWUzQ1V0NEg1OTd2Y3lDcGxrWGF6?=
 =?utf-8?B?cHpNQW1zVElXdTQ1UzRNNnV3VnZPZmZObS9ZMm1nSFJJQm1qNE92OVVXVTZV?=
 =?utf-8?B?aktXYnBqS21QOVM0QXV3SmdBKzluYkJ5ank0RmVoN05WNXRZVEJLSVhWNnRQ?=
 =?utf-8?B?Ulo4cWU1VlFRRzhHbW1wN0Noc1FTcGxPc3B0Q0luRUlud1BOSG9UWmFMVWVU?=
 =?utf-8?B?b0laUHk0aU43Q1ZDMzFVdXJrZFkxZjc1TERZYXcwNElJZG5mcWYxWVJXWTVL?=
 =?utf-8?B?ejBMSUo0MjdqTFMxbEVpdGMxUWt5ZHRMTDNuUkJiR1R1R2k3K3V2cDBpVFZM?=
 =?utf-8?B?ZVFKNFJLR3IvdUZQM0tzZHc0c051SStnYUhBV29NdjI1eDdhclhXUk5zN2k2?=
 =?utf-8?B?aCtHYlJhZEJTRkdwSUVNaWhaeHhVVkRtb2hGbldGSVcwQXlZR1RadXNrSE5k?=
 =?utf-8?B?b0IrWjQwU0U2ZDc1Q3BFNytSeWN4QkN3T1YzWlFFMXYrVkhsWE1kWDZqUmRD?=
 =?utf-8?B?bk45TzBTNkNWMmtzZzBNVUhJOTlnQzU3RWlwQjBucVoycERMUEVSVklzTmNk?=
 =?utf-8?B?NitJdGkzamxQUUhhSUloNzV6bG5PWmhPTHBrUkZBQ3hzd3VoU0ZDK09ROER6?=
 =?utf-8?B?bVV4R1JKRkxmYnlZMTBkVTVERGxORHk2bFJEUFJFSHZVTlRMQmdBa3NjZDVv?=
 =?utf-8?B?NzM3UGpRREpRQ3JVUUYrTnVGU2pMWEI3L2x3dGREWWpsODh0TDhIcytsL0NE?=
 =?utf-8?B?S0wwbUFWNmpDRkpNQTdZelRMVFZpMVpQV01aS0dnQlM5MDhORjU2NWVIWWox?=
 =?utf-8?B?V05JOGRLUHhONmNMT0FGaUtza2JiS29PQVgvSEZZQWwwOWIvaVJ3dGFnOTVU?=
 =?utf-8?B?VkJCekxKVXlDK3Z6ZkdhaE0wblR5aktDSktpKzhLN1VSVXZ3NTBvSDlUU3Vm?=
 =?utf-8?B?cnlvYzFrS01VeWg5VDg1Vlc5RnJTMllYUVBlaFpqdkhKb2s4MlozMUtqN3h5?=
 =?utf-8?B?NWJqN2RzaVQzQWFXOUZkdkt3ZkRwajRzTjJyWWEyd3E4VkdYS2xhRVVHZzBq?=
 =?utf-8?B?cFNQT2sxaHc4SkpOUlMzMitsQ1NaMUF2Wms2ZzZhbkl0SWc3aU9FN3E1bVlr?=
 =?utf-8?B?dHVYNWs4M2crb25QSWlLYzhxVldFWGJ3WGNSTTAwblRteEs5QXhtdUFxNFJR?=
 =?utf-8?B?MDNLcnBhajlZUGJoaTdOenRQeUd4T0pvR1dMWHBhc1F6REM2cFhqQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cdac61-57a4-4ee8-a9fa-08df3a57877b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:39:32.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fS2vBrx0VdE3j/NPgV45V29wEecJRhZh+SCUz+ZEPeh1wrS0tysoAQiSmaS0lZY+s4nMvrXKOZeffXbMZ1pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

On 11/4/26 11:22, xiaoning.wang@oss.nxp.com wrote:
> +#define NETC_REV_4_6			0x0406
>  
>  #define NETC_TMR_FIPER_NUM		3
>  #define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
> @@ -88,6 +89,7 @@
>  #define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
>  
>  #define NETC_TMR_SYSCLK_333M		333333333U
> +#define NETC_TMR_SYSCLK_133M		133333333U
>  

I wonder if you want to keep this sorted so that you add NETC_TMR_SYSCLK_133M
before NETC_TMR_SYSCLK_333M
