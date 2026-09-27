Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022087.outbound.protection.outlook.com [52.101.66.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CF3BB12D
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542042; cv=fail; b=C77mtGbAoZaXy4eaiXKh/3RE0X8jTq4aSYNR9B0tmJ6rnJfyxqdDGrcFkZo1JYog1fhslvzxAW0ANPRpriGYc/fudpGXQO5TthvHAzf/aAIoGJ8nLTX7fTqFnyIxOEj66sUqL5HTUHwlgHA9TsskTPd8Xo7j1a6aJQpoD1qrsYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542042; c=relaxed/simple;
	bh=BtmL6LHpI0nmWQNTaKLPwcpO4DL3umscuIraPj2Kh94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtqjlC+2qmm50zRiHEdtzZDlawEqzlqmWy6fWN/XFliEZTOfstqXnPl7CIdEi3ytdPxw/3Kx7X2JMOzP2bIEYjckwZuhN9t47toFgKdsLPw+Y61/nylAyHd7JoL3eRKrqihgJ2a0yYj37+OQT/k8B/ULJrAze7y4JH8i5fqJJKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=ujVqtFIr; arc=fail smtp.client-ip=52.101.66.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="ujVqtFIr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlgD4zQ4AO968B5D4PwU5EbfIB9p2HHbsE1zA50PcqRSzmRpsFmeAbuOT4y9KBCDwWy49G6wqq7nvtEYTIhm5KvndV9cllI+9z2IpVSbSrIzMU8JqADyw70/ofhV6KXkA9U8Tw6VnBLDBtyp+rlp0QHDPECntKkK7VkPg9qJhLejZdnEjeS86+QGtXv6UHKtH//RTfeUHDIp4P3+TJk4pCjy+VhK5O/MDnpgTVvB8t6jsQ1AbdvS4RwltzVSd4ECqCm5TgxC4/6YXgBhtL547q5ExXrZ3WewN+dqp6BZ1egbd1a/nUZwXQl4lIUryzx58L9vucHalyr+7Zs0CEhSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6a8qdiHeYUfwDJdk7FwVZkTgICILNrpBI1IF9ahnrY=;
 b=BoAR8RMW8LLs/yYx2nCK2NfJECx3ruW0mhlxfcDtj4kECYDFCBSgtWUyKHT+tvOuz0ICCPdAgeqZB5Lws623Cp1E3VbLDm92MLRqrm+Q8iOunKWFRrRn4eWFfk+FgMv92bLpBuz/QaHu7L+lCXTq2iJFB5EHdFTCaRgvafi6r2LvwEx22dJzbYFhzJXgUntdI2t2EQLBHEkbasJK59CzghM2COO+PRQqmuThldvHkTkxNZVo7Wn8Kl37OitoSLp+g4FtiyiK4w3oxy94C2VijaBLnBvoWsDJNKaniSrdsbO8PnSX/tNAV+1xBCUwD3BbsVASU+QEuWry9fmyJTz4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6a8qdiHeYUfwDJdk7FwVZkTgICILNrpBI1IF9ahnrY=;
 b=ujVqtFIrtqCV+4bZiNpFqSDPwsjhS13+krhtawyr4hbMl8O6zGpuqaaGYbTyrNYeoxH24DpqJoJctX5VspRuNL/kzRicXh44NWIkQtMFSHR88BOE13BE3PHq4Wx6lFy5V6Q2h4XYHlKwxJgLYMMJwf3zKMd9FY+QTevCHSfyHtgPMsZO3JjnZCHfZrEf28LDurCsgty5nm1EwUtZ7is55ZmLMYx6NkNDQHmLD12VMnVWtAJuna5xiltlC3kSXRSCjbTt/7V+C13vnfnqF3nVtqtZxuMf4XNZD0gwwJ4c8WH5N0uPK+BATpPt5XkQOWq+WdxVrCOTL8lmk/u4SzXKrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by MI3PR08MB726700.eurprd08.prod.outlook.com (2603:10a6:290:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 20:47:14 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0472.005; Sun, 27 Sep 2026
 20:47:14 +0000
Message-ID: <9135f26a-a692-4b7f-a7f4-3c243f1cb0e4@genexis.eu>
Date: Sun, 27 Sep 2026 22:47:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Gaoyang Wei <yhyxwgy@gmail.com>, netdev@vger.kernel.org
Cc: pbs05 <xuziyougm@gmail.com>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260926174601.1675-1-yhyxwgy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC39.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2f7) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|MI3PR08MB726700:EE_
X-MS-Office365-Filtering-Correlation-Id: b04cba8d-3379-4c81-a5e0-08df1cd882b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|5023799004|3023799007|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OOU8o6YeupKXEIu2OQCPFGyC92ckF0BgDouUVuC2gP2pKDt9kzufIt2R7kgmxMnUpvNMZhSS3n9WOLmErLMAulK8yqnFeAsQVvVXwrgwQs20sc9fTlURobM7I/+Ux0OmtflA7ThLvd+bxvyDiwSW3vfQhntI76W9uYkQUQeDfMDF5Yt8NGwUnwYP9EF4MqPehuxmd9grm4dksMOFdjkp2H7MxsZrTzw3dTDzEqeHz0/CvTZFwJDQvOelpQuJ5fa8xM9e7OpDKW4OkG6iTLLaxlCAFr65GBMGKInPyFrggiNOLiuY94BwhUd4jdGy/Fk5SbaxIBaAPYXwZQ/d2tC9gW+Tq6dWIHiJTgN1M0Ql1k+FWIkav33MIa6MRmF+6Gs8paAOtyyayiUSrk2FU0eDZkeslpMiKk+mSKxo0E7vocgyZhRuAAwze7PoRl0dZD8ZSibz/1H639enPMtSvX8JI6aAa4D7RS3N87afluEc49jzZIbvIhbVHPC+zetvkNWta8Hec/eAvhUTQ7+hQJL1clXJqTrt177sowYZ73d1C/nqgSHZhok//E3mbCPK7LOaebF3sah6Nk/b+MJ1SmEXuWT6p38wNOn7a7TL4WMcgsR0adYCNcz5Vo1Ag9xX85nL6bURh7/H3t8261OzZKcWxXRqwc0zAlsa9uLNZNPX88g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(5023799004)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5UT29NQXZxOVhjVU9uQnFyeE1vcFlLRXlCZTZGYmhDSWZHdFh2cm9ON0Q3?=
 =?utf-8?B?WDh3M0taK1gwOGF4THN3bEVZTGRpNlpienpPUlhRck8yTmd0QmtrZzVGT3hK?=
 =?utf-8?B?VEtVVzIzU21lTjdHUlpsL1lOelhTKzlwUzg4VWhiMCtOTTdUdUxyZjR0L3lq?=
 =?utf-8?B?enYwQzRxbTVsanpSekgwTTVSWHo4RnFhMHlzVGU0Q1owajVVL0ZSS05sQ0VU?=
 =?utf-8?B?cjU3a200RXRJWTA1RGpOTm5jVHEvMVRFdDhYWEplR1lubkt3UmJwQTJjZHlC?=
 =?utf-8?B?QzRKMDl4enRnU3lNK0owZXFIa1E1SW9Dbk45NjhVOUFvc2FiQWlaWEVMNXBl?=
 =?utf-8?B?UDFIQmFRWGlreWF5TE5wWmFvZldQYVNEV1ZBZFJFOG5xYlhSc1RTWXcvNDRN?=
 =?utf-8?B?RlJDS3RLalYxR243MWJtQVhwYnlnREo3bVQzUGgzT00xUHF0Z0F5UExoZWxB?=
 =?utf-8?B?aXhzZEdVL1lDYnFBMmJOc0ZXdDlVSWRaejJCeG85N1VjMnJ4VHphZFlEU3d6?=
 =?utf-8?B?cWdNdG12RklhL05ZK2luWldPYVJJZDdUU3RZRnRBcmZ4bElqN1VHalJMcndn?=
 =?utf-8?B?MFpYUDlzSGdjaGNTUXNrblQ0NlNtd1N5WmQrT1NMY0Y0TnV6emYveEJOWVg4?=
 =?utf-8?B?aXZYdmRBdjkyZ2dvMGdIbUxSMVFUbjBOQko0cSsyMW0veUV3M3V6Rk1vWnRa?=
 =?utf-8?B?d1lBRjN3cWFZRHJEZzB1aEtDQlBFdmJuQUEzVnM3RmptYWlPVU51QTlFcVF2?=
 =?utf-8?B?UnUwVDh6OWh6NVJHdmUyWUtYUWtySHNZdGNiVE1pemlDQnYxVGR0VjR4QTdZ?=
 =?utf-8?B?SXlDcVYzSXhkMVptTHF5cE5ZbEFGNFozMG1Tck1xY1pac2tueDZtaDJMOVo2?=
 =?utf-8?B?QlMrdzZrVS9UeE5CWk5aQWdLN0tHcHloY2d6aHBKWEcyNm9RenNKM2FTaDU4?=
 =?utf-8?B?UExxT1FOU0p6K1ZxSnFtYkR6SEtyak1Wc2JDMlg1b1dnSjZHajROU1F1VWp6?=
 =?utf-8?B?ZHFCOHhHdDgwNHJKSmJ1cWdiUFdBd3VCZE1TL0NwbEdoNlhjcmZaQytQbEIr?=
 =?utf-8?B?TFIwWjdUTnpIZWVBOEM2SHQxRlhvMVVLbEJaOVZ6aXIrRG9SU2tXaElidWxl?=
 =?utf-8?B?dGJIZ3dCWHdxZ3cwK2NVbDJhWGw4MmdjM2J0TUswcDFENVc3QVJ0a3E3NzZY?=
 =?utf-8?B?dXVNbEl4dGQxZ2oyNHp6NGJSMUFEZnM1QjdvNVp6Uk01ZlBpdWdWcU5oSVFX?=
 =?utf-8?B?UFozQUNaSnpCMElQM3E0U1BJNlJtanI0NG9FbGJZVnhuTjNra2xrY2VNc2hY?=
 =?utf-8?B?L3FqZitUMjhuMDZlSjVUWWpwL0RiYlAzdE9zUlVhcDVQcUtFVCtReXpOUFpP?=
 =?utf-8?B?dTVOaTRPczUxZnhrRUxJdzRIUzhuZzVKcWhiQ3BKNE9vV0pRZUcydExhOUds?=
 =?utf-8?B?K0JZN2NOU0xHMk1HRk0wN0JkQ3d0N2NoN0lORE41S3JDbU9aM3FqMy93NXJk?=
 =?utf-8?B?MjhWd2FKcFdLMm1zdXoyT2JwWW9mUnptUW16MFUzeCtqT2gzWmdsbzU0azRq?=
 =?utf-8?B?b01pL0JkZm5WczNObWR0OVA3aGU1WWMrRzA3eFcxOEdmOVB4WVpaK0p0aExB?=
 =?utf-8?B?dWxvcDByWFFBT2Ixbk0rWVdiK0QvWnVYYjY1QkdyUXdTZWhicDkzMkxVQ0Nu?=
 =?utf-8?B?ejIxTTd4TFBFWDE0MWdyMEx5aHJoRzliMEl4TWk5TGpYdURndTA4SVZCRCsx?=
 =?utf-8?B?Ym15OXN3bFY2cHhJRVBneXMwRnlYeHlpTHl6TmxmVUtEY3p1ZklUWndkQkJN?=
 =?utf-8?B?OU5uVzJNaEJ2M0xkMlBadjBiQzc2Yks2b2NYcHNQR1d5OC9DSGZzZWQzbVVu?=
 =?utf-8?B?QzVISVNaUVRqemY4cjg5SU14aldrN3VxZSt2dmt3bGNtSGxXK0pwM3A5WXBz?=
 =?utf-8?B?QitwWXozeGw5NzJ2SW1NdkowMWFYN29PZWE4Vzh0cjhkMzh6K2M2SHFaWXYx?=
 =?utf-8?B?YjRyTmFlQjJ6ZnZHMDdrYWpRK2JHcGlNNEF0cUpSSmNVR3JKRVFFZXM0dzVH?=
 =?utf-8?B?cEw3cmRJYmZOWTBPNE8ybUxiLzlEa0ZEdDJQRXF6RytjWVYyMUM2aDFyT0x3?=
 =?utf-8?B?VGpvKzdueVczWW91b2FMc0JobTlZM3VxYmREUVRXR2NhSGNTUWc4ZVUrWDE1?=
 =?utf-8?B?dzFUWVFTek1ZQVlSWDE3bHM5TG5uVkFnMDV3R0hNeGdNbUJqTTB6VjBpWnda?=
 =?utf-8?B?VXlxR0U2cXJiWUF4T0drVnVwN2YyeEs2eml2MnBSbndzS2hNWHFvaXdycnVs?=
 =?utf-8?B?UnU0a2NIVG40ZkRGYk1NK2h2OU1JaDdySCt1UDR3K0JBZFU0bm51NXkwOHRY?=
 =?utf-8?Q?nHAhrlRCuokSrhdg=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b04cba8d-3379-4c81-a5e0-08df1cd882b6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 20:47:14.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11dstk7F5nNQmmyIpRLZY8KqSXD5olLTkHa9N7eB48PIy29D8PLgsihvJw5Boau3GsQieSNJ3xpKJ/xhfFRFO2JwZIQn7MX0g5SsTvsKDsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB726700

Hi.

On 26/09/2026 19:46, Gaoyang Wei wrote:
> [You don't often get email from yhyxwgy@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi all,
> 

[...]

Most things should reuse already existing kernel infrastructure with 
modifications where needed.

What is completely new is the omci part. And here I have come to the 
opinion that some parts (MIBs) should be handled internally by the 
kernel and some should/can only be handled by user space. Because of 
that there needs to be some kind of api where you can connect the user 
space version of the omci stack to the kernel level ploam transport 
(gpon inband side channel).

Doing it this way gives the advantage of not needing an external omci 
stack for some OLTs which is nice for development and testing purposes 
amongst other things. But interoperability amongst OLTs is really bad so 
there also needs to be a flexible way to just update the omci part in 
case you really need to amend the omci logic. (Omci is used to negotiate 
the data path).

The api also needs a way to monitor the messages sent back and forth to 
be able to triage issues. This is a common issue in pon deployments.


> 
> Questions
> =========
> 
> I would particularly appreciate feedback on the following points:
> 
> 1. Does Linux need a struct pon_device or equivalent at all, or can
>     the required concepts be represented by existing networking
>     objects?

The gpon mac data transport should expose an ethernet networking 
interface but the model for the ploam transport does not need to be one.

> 
> 2. If there is a generic PON object model, how much should it expose?
>     Are T-CONT, GEM, and LLID appropriate generic objects, or are they
>     too close to individual protocols or hardware implementations?

Does the kernel really need to handle all this? Is it not enough to just 
handle the omci interface and data pass through? At least this is the 
model we should have in an initial implementation.

> 
> 3. Should OMCI management PDUs be represented by a packet-oriented
>     interface?  If so, is a dedicated net_device appropriate?

-

> 
> 4. Should PLOAM/MPCP activation remain driver-specific, with only
>     common line state exposed by a generic layer?

Ploam is realtime and need fast handling of ploam messages, I have 
observed link failures because of debug output printing to console, 
handling it in generic code would risk exposing timing issues, it 
belongs in the hardware mac driver that then should expose the omci 
interface. That part should be common code.

> 
> 5. What should the interface between a PON MAC and fixed optical
>     frontends look like, and how much should be shared with SFP,
>     phylink, PHY, hwmon, and thermal infrastructure?
> 

Unfortunately the Econet/Airoha LDDLAs deviates from SFF-8472. So 
regarding those one option could be to create a wrapper that makes them 
look like a sfp module that you then could virtually plug into a port. 
But later on I started to change my mind and that we should model them 
what they really are. And that is as a BoB (Bi-Directional Optical 
Sub-Assembly on Board). Something very related to the sfp module but 
maybe called bob instead because that is what it is.

> 6. How should classification into GEM/LLID bearers interact with TC
>     and existing hardware-offload APIs?

As I see it we should keep everything in the ethernet domain and adapt 
the PON configuration around it, at least to start with.

> 
> 7. How much should the ITU-T PON family and IEEE EPON family share in
>     one object model?  It would be useful to avoid both
>     protocol-specific private APIs and an abstraction so generic that
>     it no longer represents the hardware usefully.

-

> 
> 8. Which configuration belongs in a networking control API
>     (rtnetlink, Generic Netlink, etc.), and which state should only be
>     observable through existing kernel subsystems?
> 

-

> Next steps
> ==========
> 
> I am intentionally not proposing a UAPI or struct definitions in this
> mail.
> 
> There is working code which can be used as a reference implementation,
> but I would prefer to get agreement on the subsystem boundary before
> turning one vendor implementation into an API which other PON drivers
> would later have to follow.
> 
> If the overall direction makes sense, the next step could be a small
> RFC patch series containing only the minimum generic model together
> with one real hardware consumer, rather than attempting to upstream a
> complete PON stack at once.
> 
> I would also be very interested in hearing from developers working on
> non-Airoha PON hardware.  A second independent hardware family would
> be particularly useful for determining whether any proposed
> abstraction is genuinely generic rather than an Airoha interface with
> generic names.
> 
I think a good way to start is with the dts and see how things end up 
and then create a RFC around that.

MvH
Benjamin Larsson
