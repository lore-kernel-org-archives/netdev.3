Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793831945;
	b=sstIZ/gJHTrDo/JrH2lYiXCSznDDCPg0+MPJsrlLTkrbT/1NvbF3WxRoKmubWhRw3oHR
	 E//Xy4hKPg1kq0l8TgmbzIHY0jFk1wjwBL5p5XWThbNEp7Szq69HC8FB5eW8NAFEPvoh4
	 Y4VOYiLW2YHr8oJ9su5CSUAE9QjWKheE2ciulrRurcaDd0LsOZ4MJfXPhgZSbTrUfDiJP
	 1SlhdjQUkeCCa96x+XhPpXDKYA0xElmbv04QmrS7IZLmrE1tSLLYarGI0Zvkf2Z2IdY6d
	 SYOQQyYxDFMjii3xWo2zuRSwsgu4IRPPulhZbJm5F+/Rw43nsX4JwS09KYbvbVGF6lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831945;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=Rj9s+TBgsab25DvEPFmQjdXovjmxGdDadWzddpYIewc=;
	b=B5854nNtFxfb77lYfkfMPrIBXrVer4QDAq7+JSAXWUgjUKK2bieGWPfFq1NkUts2eIKg
	 jVrOV4CfXWSKzxsLCsD7aTLrSSyVrF59hZC9IlSfBFtvKdTqm0jjZhbC+UUa9uUO4FRhs
	 az/RT23BMFgFepXnYxw/6kjgCCn9VA+7hpzdveto6DdWLxR0sS+u06XVXUEO7cdBc8bkz
	 X+KzTS5CLoBi7p8yM0WctXpqC1e+OxFLo9HYy+eFAF2yDxSldS27JJZaC7tQMhzmobFyF
	 INFVeCciBLIA2hQFkf9fHQti3AmLuyJDi7Mk4K88sAMm6bbnuKb98gruxy7RiU3jyWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=genexis.eu;
	spf=pass smtp.mailfrom=genexis.eu;
	dkim=pass header.d=genexis.eu header.i=@genexis.eu header.a=rsa-sha256 header.s=selector1 header.b=zfxbdvqa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.134
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023134.outbound.protection.outlook.com [40.107.162.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41141606A331;
	Wed,  4 Nov 2026 22:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41141606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=genexis.eu header.i=@genexis.eu header.a=rsa-sha256 header.s=selector1 header.b=zfxbdvqa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2KHrxejEsMykwbMazTjXa9AkNbxKShubXFASouPq2pVkLmyP/x37rCalbOxT6cQbTEX0SVkO2mAxzJHMK39P0OlVKzjFlJxzfjHfh2l6xE+gKY7L6E9rL6zSlHXTQfJDT8qx85hwHgVCOCg1u2nl5ByWPOg803X91niSVs1f2/PUiFe3V9GxzkQpejjNtRcwpJWW/jT0GBavDcBVrRbZb1uu8PAaIqLRCdnvRVkSw0uTC7vTYcVkOcYc0Qk0UOg2YILVDM+YOpQpSP57XwU8DFk2QhQAbryE21GFFC46zjqULIq0mdV4IB6lt3Ux4UAEIEso9PljKSXZm6P+cwpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj9s+TBgsab25DvEPFmQjdXovjmxGdDadWzddpYIewc=;
 b=dboKrZ5zZ/d17G9ZSwG9rjslcL0zpOhQ9u886CciP5YccZ4aM6tiKXazmwlr6MPl/M1wusPLtYPTbr7az1M0ov6g/NJVo6NV/iePj4y2h3quu27AwhDsoebn7SPanICb+BSQy2gKHA0DFilTcRvc0ZBi6GkqR4zsFC4A1CrI7ZYQ/lbxzzW3JbQhJK/0hfocfIY+jckkMpgAoOpaaacCGrE7kNLIbv0rNGMmToYzj0qtsy+KKhPdFbrTGEK95kRUOxu+GUT7zRkfUNMhbUbTfhqwbCI/yZfG1jAM34gms0EPRiUR3EdEUE8mSgCRLvFnMSamvPPjfMReKc0VWjXDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj9s+TBgsab25DvEPFmQjdXovjmxGdDadWzddpYIewc=;
 b=zfxbdvqaZ8hn5R7xOYl1h5YuOzz3y5T8Js6aMN3RfZu5NdfnG6QODKH86P/Pef7heRZdIJ3Jvf3j93CiPoSmABe0vVToMHZiqi3etAXvLc4Hr5yOdh0H8f25POtYy79w0JUDkgpB0EfG89SeonCP9EGt3zWvgymhJgGPxUErXwdRSOWj7WIv1kFBhb58ov/IkLcUm/YGQMFxe5etGPRSum0JbfV39oslwXXnXCMiGCqltVJALHcmNEB61T4JEfoXvThZiK/ZYUN1ScTLIDP/pbHYwWiDRO2tPiLlnCar1RG4jlgZRnVD7J2CfA2VYpp1PmFk5NzHoN4dvYRr/NGxGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by DB9PR08MB6443.eurprd08.prod.outlook.com (2603:10a6:10:261::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 22:39:01 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 22:39:01 +0000
Message-ID: <bde6c991-e0a6-4c25-a5c7-9dbe79aca604@genexis.eu>
Date: Wed, 4 Nov 2026 23:38:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/6] net: phy: mediatek: add calibration logic
 for AN7581
To: Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Joris Vaisvila <joey@tinyisr.com>, Ahmed Naseef <naseefkm@gmail.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-6-ansuelsmth@gmail.com>
 <2b744929-609b-4529-8b6b-30feb3ebbbde@lunn.ch>
 <6aeb7861.6171b307.11ae12.6b94@mx.google.com>
 <68eecc53-ed61-463d-bb5f-c68b507be82a@lunn.ch>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <68eecc53-ed61-463d-bb5f-c68b507be82a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBAA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6ea) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
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
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|DB9PR08MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aff04a8-f01b-41e9-f010-08df3ac46be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	lq8IXFKkxP2h/2U1vsbNc43wD9CQFw792isDMEF5jRT/v7PU4Y5gJvjgHR86zeu/63Z84c7Jk7+BJb3bt4wxuQgV9vp1n3iOYMydnf+Qt+ZcmMGxcnlB5NflumA2iFBSD1U9TBbTyp6yHqD/0WRyOhjh/LFoJ/VC98vwsA7tm6YTu6CxbVnL6nERpwHeuEW21Y6z/AsWBj44DEQXTBSglsJoHL+qhiTTsXA4LZrQig69H+pg8+DBqYLjW7MXWBHPrqzxCFlBbX5UPQGV5RpJOnLsVHmSs8aYusD8wJlzAm7oGJtNwBKyZPgiNsI1nUUAcJ4aQCMx/bfvIYMROUAFaF9fI4ry8wCwQyMmSvOeV8QrRBOO2iOLXOqacScpf99VQdPN6TA2NfObn5ztWlFUo61B72rLqg4kFdhm27Eqd1THiS07whHnVzcsCfkHySwvWGusPXBrKPrXTjPcnh/A1i5p2HnB/wN5YbNypFA1nZbxnbloniR0U/jtMiLrHZq/IXnDfkIqQgF/w1bUz0+p6qJSsyd3hxq6jLXRVYY0WsT6BrsyhLd5tpOitmxj4M5m4Go4AO6OU3rAg+o9sW4EGAFAkjmzwJ8jbV6Z5LKUICuipnwm+h/aK3zgsBRdKcQ1Ttp/y11Z0XGxdHklSEk5m+B+LztGDT2CQNKnxOIOTKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjQrWlJmUnpBVDcxa0pab1RaNjZrSUVPd28rQkVHdE1ONDQ0TjVPY052V1Ez?=
 =?utf-8?B?cW5EdGxNRDNmYVhOQkRydGNrTEpZdU5HKzdWcUNqQUdEMzlaNEswUmVIUzNC?=
 =?utf-8?B?eWpHMVZwaDBtOTRhWEM2WXdEQVJZc3pyVWZRcUhtcURKYmJmZ3U5TnlIZDJ3?=
 =?utf-8?B?MHVOdG85WnA2MTNDd1J2b1kraUcrNHRySEI0Qzl6b0xLNWJUdHM4aG9uV0NK?=
 =?utf-8?B?MTA2WGhPYkJIejYvMEUwbW81Z1pXdzNFdTMwd2dZak9uV0pIcWVpd1FqZzVi?=
 =?utf-8?B?d2JpRytQUCswQTJJemdqL09zWTBzN1ZpQ05OMHp3dkR2bHNrZkJ0VEZla2Ur?=
 =?utf-8?B?Zy9mR1dVWE5vdmhkZXFIN1dCYkZFZnBNaWlnTjQxUVg0WVhxaEhqbXJHWTNH?=
 =?utf-8?B?YnJaWVlzcmMySFJZbUcwdEJIeCtzTjBYa1BKczVHUFJaM0d2NnU5VUdpUnZo?=
 =?utf-8?B?c2o4TnVFSWx1ZHN6NWZncHRQZlNNWDZwc2MxSDRHZDhNb1ZJOWtoNHNUVU9p?=
 =?utf-8?B?aXFyZGYrdldFRTJYRDNVaG5ubm1GaDBMYTBpRFNBcE5zQnhQOC9FMGtsT0lW?=
 =?utf-8?B?T0tJWkkrTnJUcmVEZ1Bpbm5Ea2F2SjVMb2lHT1VGRXFzeSthWHhLT00yQjJO?=
 =?utf-8?B?OGthdUZMOGpqSGcvVDA4UUpEa3E3bi9lUUJTbTVDZTcrUXE2SWNWRXZPblA4?=
 =?utf-8?B?U1dYUTZSemJuYzlWWlE4K1ppbDB6QTk1TlppNFRqMUhHanE1N3hLcWpDSnE4?=
 =?utf-8?B?OE9mdDlNNUNjVURhRE5Zd29PZEdQeHRwUGovS3oyazJPRXMxb1RWZ3JYZXNO?=
 =?utf-8?B?UklwdXB3WG53aVRyZzlLMGpyNWNMemZFZDZ5bjY2T28zT2NnRTJZUFJxcVpV?=
 =?utf-8?B?U3BEUmpkS2hxN3h6SXBOYTdBWFA0K3FrTFVSK3ErSXc1WksxMzBCcnJHd3BL?=
 =?utf-8?B?MHpIMUZ1TlJyUFNUaCt0KytFQXJWSFBDb2hjbThwN0JjOEd0OExNVmxhUytj?=
 =?utf-8?B?MWl2OW9HMmFFWm9nVFp5T2RvOFlCSWMxSjROTmV3TnJ3TFdHNC83aWNzQ01K?=
 =?utf-8?B?UFZiM2trSlpQTTkwUStWQXhXTVd5cUtXTnp2akgyVXZETmRRVnp3TUFJeTds?=
 =?utf-8?B?NzRCUGpvNDNQejlPMUJ1NUFDejl0M1RLWWlkc0JEdHZDZDVhRmhreTl4RXZ3?=
 =?utf-8?B?d0pjZ01VRFppcm1hdHZNL2g4WklzN1J3Y1VkYmF0cVVUekV2ajNkeGpMdmp2?=
 =?utf-8?B?ZDZIdjg3anhWbmdUN2JLbFZMV3Q2U1EvQWIxTmVpZFNTa1RwUndHNXdwZWpn?=
 =?utf-8?B?STM1SkdMTDBBNDVIMFEwRU44QlloRWNFMDRtWWFvcXJtZTNkUGV6cjhKcjkx?=
 =?utf-8?B?dS96WExCS3JKczQ1ZVVHTk1nWkt3TVhuVFA4dyt5anEvSk5XSXlTOWJWckc3?=
 =?utf-8?B?d01rY1E2TFMyREFJWGYvTTYwWkFwKzNrWVhHNlg3SUJ5SGd1TTdEQUYyWC91?=
 =?utf-8?B?blRqUnY2OC9sRWJYZ0xHUVBKL0ZJZWpEODk4RHY1REVTMXZWa3h1NndmR0Ji?=
 =?utf-8?B?Q2ZQMGtNSlJlYUhFa2FKZjBGSE82ZkxmNEUvSnNIdnRZV0p6d3FCTFFOMmNt?=
 =?utf-8?B?ZWg2N21TOEdjdThQUElEOGtrM0c1TGlOT2VKZEJnYWJaVlVUTlhCeXRseTNK?=
 =?utf-8?B?SEEyYzdBdUozdDVEVmo5WUQzT1VoNVFTZDRlQmU4Q0RCaEQ4NDF1Rm9tS29F?=
 =?utf-8?B?VHdrVkdWT0dvM2kxYy94WGFmTVNxVVI4d2ZxbGhFV2RVOUJwS3RrVmxzOW9I?=
 =?utf-8?B?TVl2RnA3U1J3ZEZGQytzY0lRWWZZRlEvQVpOZXBwSDZyRm1VNmFWbnQyWnJm?=
 =?utf-8?B?aXByQmlYNXUwZHJHOTBLTE5kSkRYZk9oemV6M1p6Z09JeUdoVTVQUThDVWR3?=
 =?utf-8?B?c0p0NmZBNnVkTFRZYzhGcGNWajJPRmJiamsxUURpbVAxcXpzVU9TdGlOQzVI?=
 =?utf-8?B?ZTB1OFl6MC9xbFYwb2tQV0FqWkxpaDFrb3JUbjgxUHJCblFJRXBLUnh3Uk9w?=
 =?utf-8?B?b2tLaHJhNmFYT1pLeVNjSzU3UGFjS1RpT0Fmd1M0MituVWk3amxZTnJtUFlQ?=
 =?utf-8?B?RVRwSytVczdDTnlkMWxHTHZBd09ZU1htaks3ZXJobms3NUdCVWlWWHd4Wjhy?=
 =?utf-8?B?UlcrRHBxT2N6OStSeGNQQ3UzdEVJV1Y1YTRUV0RBQ1BYQWJ0emd3aXhjMUsw?=
 =?utf-8?B?Umo1aUtQa0VqVFlpWm5VbFdsRjdmM0Q1eDZQMDVnM0ZmR0I1V1pJUzBkVE9G?=
 =?utf-8?B?Y0N1ckRYSW81T3U4Qi9GRVRxNWdEdGJtUTg3QkZya1UvQnJkU0p1WUR2VCtD?=
 =?utf-8?Q?DUHvgNst4H15IGPI=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aff04a8-f01b-41e9-f010-08df3ac46be1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:39:00.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgaiwCsmCkqjD8G84gq+4hMyJXt+IpHelGq/HnabuCOcXdUuCP70br6ofuhdVKpCVL5NJbpvN/EUp1Q0pTX2WzsW0j2whh+S69efiJL/1eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6443

Hi.

On 04/11/2026 21:51, Andrew Lunn wrote:
>> It's safe in the measure that the worst is that link goes down during the
>> calibration... I will rework the function to assign the base address to the
>> default address for port 0 (it's hardcoded by the SoC) and use the lock and
>> read/write helper instead.
> 
> Are there multiple PHYs in the package? What happens if both are doing
> calibration at the same time?
> 
> PHY #0                            PHY #1
> 
> 
> phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
> 
> 		       	      	  phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
> 				  ret = mtk_cal_cycle_wait(phydev_p0);
> 
> ret = mtk_cal_cycle_wait(phydev_p0);
> 
>      Andrew

There are 4 phys in total, only the phy with mdio address 9 has the 
calibration capability. Thus only one phy at the time can perform the 
calibration sequence.

MvH
Benjamin Larsson
