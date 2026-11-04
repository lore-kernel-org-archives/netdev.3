Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793798089;
	b=vji4/xBTJ3YffEIU+do6VC/iGnMJPag8kADm7x7f3GdNJiT/2WhR42dqXqjEq5pJHZga
	 KwG6q56H/VVgpQz4i4gjl+9jUTj/ciAbvdPE5fsGurnu1WTnt1k2aB5h9hKJ0Q1o1eMUb
	 MlIXxvtNno3xMkI1CqjAT9qTn3tQr9RJDGYF/Nc8V/vQXmnPj5WVFFx3itbVrSe9g5Im2
	 s2Jhfrjkt3UvoORMmlFvXJrmhnkyLxgD6NJ730wkiPBsvF8sM0XBodHAd/4YMMz71hc9J
	 w9y/S30bvRFDhevTyLS2o71IJij0U4sQ18+W31Z80WtdQPSgzF55E5iu0+JNexYCc6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798089;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LJvUBa9DTWKh2KLe3Q6b4+e9xmvCB18cwzzu3YIYpA0=;
	b=CZJvYyb5WIUm2ySTE+NYlRYhTswewX3m/9TWsxgWB8q5bDstAL/HY13a5SUtYCHOQSnc
	 CtLNQox5ibVoWIvu7SX0LY+OJGYNZ6GTbnJ7U9lwJnTN7iBjyJfJOzl6ymTyNriRPvtZ8
	 FpeZw+hMfpoSpm2yeyEEkYM3TKHGY8Nmj/DU4zANUB3JVPU+pNtfa43xCjOOjkn7D7myy
	 +CmXSMCL/L8aDFHcisjPkuoGT2vRZJF4RtZtDEwKbYa4MQwVDJh5RQ+VMuMUPFxJ6/Lvm
	 GLN5QETOIYsNhRHYRTvp6tV2jllI/BydexrszObMbVXNFRCX54BvJeeTEz3CadpIufA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rrKTsn7u;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ns3Frpu7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339C606A31B;
	Wed,  4 Nov 2026 13:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7339C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rrKTsn7u;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ns3Frpu7
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bd7gj1972344;
	Wed, 4 Nov 2026 08:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=LJvUBa9DTWKh2KLe3Q6b4+e9xmvCB18cwzzu3YIYpA0=; b=rrKTsn7
	uLYF0R4nL8/o5CJLQTc4MgBA7WUcpx0VdUkg2EGVzU7e3nx1N2upQ4DNA1/rRQkH
	zuJ12iK4CW1EdD+kSXFIufBlm49buY0Is/e98TUlP5XlLlzov5+0pNZigTdcskSY
	/7DHe0X8+Y7jn1JRHUryegCDJgrlAX7q4lDsV5c8ERgnScAqPK6nP2lL7b8xfPYi
	MYO/aTwp1xaBcCBw5TDosuPOHvCcaw6NVsItKjzf+A48gE+OwIbo58coOLjJAbdM
	Ex80iIsaHaWqbl5qFWj8Pi2sUhSm1wmcvy2RMpN281TyzX5hXArnMzigAQ46P2Vm
	6QjWNlukgQwCZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LJvUB
	a9DTWKh2KLe3Q6b4+e9xmvCB18cwzzu3YIYpA0=; b=ns3Frpu7ZUzwg3SEMaV+O
	EQrzLE8sMNqaxJei8Mjv0Y0njdDGDm0R9HN7YeF4XjIx3jVPM+di+VX1/sqc18cM
	3PVX4HfpoFCsucnPtpR4oTvftnLsMbRSGHDAHIbri+tYyBEB2OZg5rBHxB+U+KBx
	B1d5X3RqVzeS+Jz83B5jCXpNwM73v19oTQ5MZxuq8cfx3V+5CDN5z2AtNhjLD22s
	p8DyN4DirX5Yih4+hbNDL/nqaNUB+68zvHrmk2CYYlQjr9uf845NtJn6OGWnoQax
	dO8zwCFv4wlA3ImNa1CeK1MgwrNcWpRVc5mxy1Ry2Y2Wt1ODzm9JVMHiB9IOnLr8
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqk2pww1g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:14:31 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gewGP3VGXWjsWTgLUBFD0dzEDjYiEhPVppEiuGv4rUHs/C9c87WZGRPzn59rus2mEoYj6RTgAxwJTmWEtBBOmgrrQMpqWgPlfxagfbgJq/cy2BN69GEx6m9LQVkVYLoNbqmEstPFeGwDsKScGR5T8X0hEoShAoAKHy4wItDmpQNi5UzS+z13Yb+141nB5CPoL4RX90zQdviqEaielbobxIOElMVhnDgkmLiAdrQ34mX2QJd/VJoi1oY7YJ+uNcXcAq1m5RtpQRHe6cj/3hKIssciBZdvbPLo3RGtNcPZ9KMv0jcbuaX9AfTX77fRPTJlJaBKQtxVU0lkp68Gb0AnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJvUBa9DTWKh2KLe3Q6b4+e9xmvCB18cwzzu3YIYpA0=;
 b=qxrNskVuAd2oLZIeiqSd98Hj1I+XpTq1f+DEfjEtd8v+UFJn+ViSgtDzoClujOfjl8RoC33VFdXcX5mpW3RMHGeCnPPGJi/p93PwBr0VEY9tXwRyAU2hd38Ecfde0XSmeTypZn38Wca2jg7EZiOz8FvEDOBLLhpay6rcbmptikU4sFHPOkUCgC/StRkdu6vK88eLR2H+A7aQW2O7u8AS9b5P6y7ZF0X7yRkuGdTHHTYtqmtP0aUDD6j4mUFsF5ksyx+uQmdCQFasanOLjiur2U8j4KSgIbbyLGrsiK1jIkLemN6JdT1M+4Y9nNZwFYEvWwq+94G+8cPy/tocumIWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DSSPR03MB989215.namprd03.prod.outlook.com (2603:10b6:8:374::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 13:14:29 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 13:14:29 +0000
Date: Wed, 4 Nov 2026 14:14:26 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 10/10] net: dsa: realtek: rtl8365mb: add
 support for RTL8367S-VB
Message-ID: <ausr461gzl1pxF29@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <c7f88f0e-b174-4715-b148-5f9a2648bc2f@yahoo.com>
 <auph2uJLrJ6Nj0dh@analog.com>
 <6c6155f0-0431-4ef9-8067-dbc104af710e@yahoo.com>
 <c353d13b-048d-43da-987c-3b83ae6e19e9@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c353d13b-048d-43da-987c-3b83ae6e19e9@yahoo.com>
X-ClientProxiedBy: CPCP307CA0001.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::11)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|DSSPR03MB989215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9a0d43-b2c7-4952-41d6-08df3a758ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|4143699003|261021121427099003|56012099006|261021135927099003|261021123027099003|261021130227099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261026121527099003|261026130827099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VpUgxHQTvmdVHlwY94eY5XDqU6/T2MllmLBhHA1b57Rp5Mvfr59KWbeQSwNlN+mPZQxs+cKmnxUh7MKvedxFScc/meyMgh2NgYo24tqhqEa7BB1kic6uJano9uaaLJmeO/rlC/00OVCujxwenjYZu+KwuC8r3ghmTahNjj2RCum0SkRAA6bwdOHx1PTQyOV5NlWppazdvHeIbdzNh9nbiAQS5/tGzxduxzQi24lCZn6e5CcN5meWLlONw76mRLLOVA7Cp5woZsTPSIZBL+5mlw5QL+SpFb98ueOevD17QxWLhRR3C2vQsBv5zphDGobrAZ6gs4DJgVeYJ7Z7kJGjQCe2bzeGBaueKejSwfciuQ2zr9qsEQL+fgOcWz9pT2TxU8Z8yc+XrLYg1QHwCLzUfBlsbI7xMXxKPaHmptcEtTwg3v6Idf3Ublbni3XHHIzRVquJDI4zPWathN6XDrjY3joKdBr71ZfHbPEP/2rlHRIDYqHsrzlCvw9GeGpeOUVqdEIfwNkxT53mIiPnBgQnVLlqgc2mqqW0TyXR0O0IyQfYVXNbiUEvcCMQPaRWi098ilY5raWwkaE/wnGDfbFLQtpU57ZwZuow/G9v8zYhDm0nHhEEQoQ8TTGp99hDr4dmf1JIj09ZOa5xteGCP0M21a4IrV3Kbx2KM5H30rta7co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(261021121427099003)(56012099006)(261021135927099003)(261021123027099003)(261021130227099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261026121527099003)(261026130827099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjBPcHJnQWpQT1BBSkUvUldVOXBoaWsyRkowMjBqZDhsb0dFakdyc3UxeWpi?=
 =?utf-8?B?endlMUhiRXBPcm9hTDhwYVZtOUxSODR0Um5iR2VDYloyRnRIdDJOVyt1SVRD?=
 =?utf-8?B?Q25UdnFrdExLQ1FVV1l2QWNlbkgrMzNta2RDcHdybGMwckFZMFpkSFpkRWFI?=
 =?utf-8?B?UzJUczVuT09HYTA4QlhPZ0gzWW9jcnhaYVFLVkxPVnlESWdNNWhCM1ZUMHlD?=
 =?utf-8?B?czN6dWpSL2EwMVFhdFVOM2FpU3hPSTFUQW91U3hqQS9hbnp5cERrN0gwdlVU?=
 =?utf-8?B?Zjhkd1FwWWE2ZVJGZ3dSZ2lINm1RUFVleVF2WkxkcDZYd3VUUGoyZU1aQzVy?=
 =?utf-8?B?VE5rc2ZNc1RmZjRiRVBtNGZnazFtNmVvMkZ4Ym9jY1pPU3pBS0lJQmR2YUNr?=
 =?utf-8?B?cG9WNHFJMzFzaWl5UFpEcWRyaW4rVFRiMmcrZjRyUm52c2h2dEs0WnJMV0ds?=
 =?utf-8?B?OThqb0VjUWp6LzR3Q3NYVG1vdWVpaTNqYzlzM0ZtdHNuaVRqOU5hdXNZM3ls?=
 =?utf-8?B?N3Rhai9reUo2RDROVm4zVVNQVmRFWTQrSUhydEJYRXAvU2hPOVMycmo0bWs2?=
 =?utf-8?B?WXVuQ2lSdkY1YVVWT01GTm1ER0cxWjBBRnpWNWNSUzNBcFY0UnA0Yi8ybE0r?=
 =?utf-8?B?eUtoSkh5eW5Pa0R1eGpxckdpVGFKRWhoT3hqMTlVbHZkYW40TFgrSXM0WEcy?=
 =?utf-8?B?OGhDc0xSaWFKV3VtQ3EzRjNoek41T1U2bDVDemVIb3lGUmtRWTl2a3llYU5B?=
 =?utf-8?B?d3dFNExYcktneHhTa3I4YzF6T0ovbDFZSmtjemw5WElRSkZ0Y3lKRjJMYjFi?=
 =?utf-8?B?T0h2U3h6YWI2NWd5a1FTcXdvd2dyOUtvTEVhb2JoQmt3ZWpDSmJIR215WDc3?=
 =?utf-8?B?VkM0WHduRjh2bTJiRElaeUZlVW10YW1WNCtLLy9GZnZkbENhNWt1WGNseTBr?=
 =?utf-8?B?NFd3Q09QK2lHQ0M5OHBpNXpCL0FweUpaaW1HMmFuNnhyTlhFWlhUdGtaWldZ?=
 =?utf-8?B?bFA1dENjcURiSjBIcHJxR3c2ejVsUUx3WkJycTQyRkUzdnZZOVprNUpLSC8w?=
 =?utf-8?B?di9BUzlnVy9nb05iSzl4dFlUQURhbFBXdDdlbzRjWCt1ZGpTNXVXcDJiUGUx?=
 =?utf-8?B?RXhJTWRFS1Vmb0xPVDlKNm00ZVVheStSdUIzQUNTNlZkT0JMVGdHU0cyYmt5?=
 =?utf-8?B?enE4UExrVEIwaGl4aktLaWZlQjZFNjNrK3dPSzhhV2w5bDRGbkhxbm8xWDky?=
 =?utf-8?B?OWF3L2JuT3dJM0plbGVXTjZNTVQ5WlQrSktlaG9Mb080QjR0UVF1a1FyZDh4?=
 =?utf-8?B?ejIwdkd4QkF1SE1XWEEvVGh1b3BWOFVQSUdJcUJlcGZvUW4vUUdSNlAzVGtH?=
 =?utf-8?B?SEx5YXNGeU5FTUJIbWlMeXFSREwvTFJBWmhNdzlkRUM4andWVXdCWTNFN2hT?=
 =?utf-8?B?U1NDYWZ3ZkVBU2QvNFFUVUJwckgybTZFQWNTWGJSdTFISTJWSzIwT1ZpTU0y?=
 =?utf-8?B?cnNrdE0yeUJPM0RZeCt3Mk81MmZrRVFNRDBqZm5GRFVsWm9zcnA4Z0RxVEpK?=
 =?utf-8?B?WDlzaXF3Q01Gb1JXTldEVk9ZYkY3VzkzenNHcmRjMFNQNFErY0VPNW1JcGVZ?=
 =?utf-8?B?S2sxak1Yelp2Mk9mTFZwU3JhSXZJSHJSMEZMMjlHK0NIbnVpdXFwNy90NjQ0?=
 =?utf-8?B?UjdsQ3ZVUFBGL1cxQVVSNFc3a1Btc1NzMkN0WVJxWU5lK3NXWHBoT2NPSmJt?=
 =?utf-8?B?Y2NFQzRnYVVna1NpOC9rSVZxbFEreXhxRCtNRVBlZ3U5bjNIdzVVSHc1V2NM?=
 =?utf-8?B?amloNU01eGV5dXIwcFhnZW1TazkxUU12V2IwRG5lY2dsaUVQMVVhUzE5NGdX?=
 =?utf-8?B?TnFrVzRtSWJoQ2RFUE00TVBMN0xMaVkvbk1WVGZZSU9hRStyRzljb2xZRzZu?=
 =?utf-8?B?ZWdYdzJnR1AwSm84aVdINW9LTEU3eithOU5BbHRkSHhiQkd6TDdvcFMvOTZh?=
 =?utf-8?B?MDdaakNkdEZnZXFPVHhGeGZra0x2ek9uSjFjazVaMUI5TTZXOGFaVG5jOTBG?=
 =?utf-8?B?RERrSitHNXlEVDdCbjluVUlJbG5CNUR1aVhTK09vSjU1akhoUTdaYTdURWZl?=
 =?utf-8?B?WnZPY3BNSlQ4bExzd0NFRnI3ZE9xWEpONjlSMDB0ZkVDdzBCd2dKcnc5djhB?=
 =?utf-8?B?ZTZlNXRidUV1ZkxxNDlLWFdkWUtoNkJMVnBveXEwbVY1ZFhVZzAzQ0FDaDZT?=
 =?utf-8?B?SDVXSEdGNllvd0xkU1JXcWZ2ZElnenpGeHFGSUFOclFPWEJSMmlYUmxabEtp?=
 =?utf-8?B?Rm9PQ1lIYnZkUHdqMXNOaDN5eUp6SVlXQmUwbTJVYXMzUFpLOUdIdz09?=
X-Exchange-RoutingPolicyChecked:
	pxoujXQapVIM+Kovau9tpOXV4PzLBnFlLFsyo/hr56I6RGBCyw/N4XAzFVXElijQwC5UzMBtqqmz2wZduhJjUairsU7TYIlF9pvslPsUg9LBvTPjG1G5FZdl9gH//2ZOgeDYZNczRgPtvWP5KFCqUIxt1zcUC6tvHhmrjUcMNNrlGt5Bbtnw4D7G5r2o0iRi3kRrXx11t68+s12LOpY0qvZldJz7oy55K2iOPEOh+OZqf+AiWDq0+lmuSq41rtHlAxx3RvJ+J3/QEcK6ZvqIu9inzQcq41XBwFiuRKFouiAYSJ4vsKc94+oYb5gl71SHpdn5SQSo/iMmAKxkhT440g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9a0d43-b2c7-4952-41d6-08df3a758ed4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:14:29.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHfiv5j6LOrby+j4CGm0B1CexLf8VlMKB/tjeo+lwg8NcMtMIs3FYNCnNmBTaVuI7sG2mYFYXPqCINIW71EwZmoAG56ud/nVYRcEBeaFoDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR03MB989215
X-Proofpoint-GUID: qeTrQsNSWMNrnZ8N2cYwI5iPKQoVIY6X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfX9T1BThwlgiWp
 Cvbil38EIC3nJxRjPll0UTQx0IeiSO4GQa6sQV5+pk26QBGRGf1Os0TXPsYeddhxVaFL8czAjKX
 WZwb6WBaukOVDogfSOnTR6ayKHzg7CyP9pNN9/LSdL+CgsiOfr4T
X-Authority-Analysis: v=2.4 cv=NPlAaE6g c=1 sm=1 tr=0 ts=6aeb2fb7 cx=c_pps
 a=KwZW/a2w+sB+hZzDdQVeig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=7YZmlEbtGwC_rabjXEsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qeTrQsNSWMNrnZ8N2cYwI5iPKQoVIY6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfXxQkLQC79kqDH
 Lp+ynzjgxS00aN2v03ug6N6+N6AgnSscnnnrB+cers9aX4d49MjJRE14EfFfpib0DQLMabDnUKe
 dLphdsQduqS0sEZrKydQD8bqmQm28LNAyJ9pvLg59QlqGiy7JOgv83T5ZCqc0bMSUKoyvnqq3oj
 0uyxrzx9dgGpwzK2Lbzcf4gjVr6Lbzq6x72WjySVSqZ+/9cdMaQDCjyIvqMFwP/e3sswqMOfW4G
 rSiQXB2cs9NY8ymWvOh5bf9EucBibvL7nlpg5eAKyKxs0D5PL2F6pDQSMD72hG55tGUQ6ypuc2c
 oBY7GvQUNstymTJ+BRY6TmAr6nYgaEOOaHEpp4171kjHNQqd0ct/JN4meJ8e5s1A4TPArm5Pwvf
 xAQkh6h8VEkmW9Urj3HIqqpil1pO2mjCDRgJMk4fY9uME6oVOOACNxV6bsLfgjQ6c1SnmQoWcdV
 VUIZB87himgz+Vpx+Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040052

On Wed, Nov 04, 2026 at 10:40:11AM +0100, Mieczyslaw Nalewaj wrote:
> On Wed, Nov 04, 2026, Alvin Šipraga wrote:
> > I haven't yet had the time to look closely at all the patches [...].
> > But I'll try and take a closer look tomorrow and point out where else
> > we could improve in this direction. I hope it's possible to remove
> > most of the if (family is x) { do something } constructs and keep
> > things flat.
> 
> Hi Alvin,
> 
> While waiting for your comments I went through the series myself with
> that goal. Per-family constants and the L2 serializers are the cleanest
> case, so I'm taking them one step further than a num_ports member.
> Instead of adding more members to struct rtl8365mb_chip_info one by
> one, I'm grouping everything that depends only on the family into a
> single struct that chip_info points to:
> 
>   struct rtl8365mb_family_info {
>     enum rtl8365mb_family family;
>     unsigned int num_ports;
>     const struct rtl8365mb_jam_tbl_entry *jam_table;
>     size_t jam_size;
>     size_t l2_entry_size;
>     void (*l2_data_to_uc)(const u16 *data, struct rtl8365mb_l2_uc *uc);
>     void (*l2_uc_to_data)(const struct rtl8365mb_l2_uc *uc, u16 *data);
>     void (*l2_data_to_mc)(const u16 *data, struct rtl8365mb_l2_mc *mc);
>     void (*l2_mc_to_data)(const struct rtl8365mb_l2_mc *mc, u16 *data);
>   };
> 
> There is one instance for family C and one for family D, and the chip
> table entries only say:
> 
>     .family_info = &rtl8365mb_family_d,

Yes, sounds reasonable. Starts to resemble how mv88e6xxx does it.

> 
> > The reason I'm saying this is that I saw quite a few places where you
> > have a construct of the form:
> >
> > if (family is d)
> >   // use family d constant
> > else
> >   // use family c constant
> 
> For the L2 code this removes the construct entirely: the four
> rtl8365mb_l2_*() dispatchers and rtl8365mb_l2_entry_size() are gone,
> and the callers use fi->l2_uc_to_data(), fi->l2_entry_size and so on.
> The same goes for num_ports in detect() and the jam table in
> switch_init().
> 
> Some places differ in sequence and not only in constants, e.g. the
> SerDes configuration, the CVLAN entry packing and the PVID handling.
> I'd rather not hide those behind callbacks without a clear gain, but
> I'll go through them again and convert what reads better as
> per-family data or ops. If you see specific spots when you review the
> rest of the series, please point them out and I'll look at those
> first.

It seemed to me that VLAN would also benefit from being split
out somehow. I already tried to structure the VLAN/L2 APIs into somewhat
high- and low-level implementations, the former being accessed by
_main.c and the latter implemented in _{vlan,l2}.c. In the cases where
the binary format/address the chip expects is different, it seems
logical to then have different low-level implementations depending on
family. There might be some code duplication, but to the extent that
it's just incidental (e.g. 50% of the stuff is the same), it can still
improve the maintainability of the code IMO.

But if there's also extra steps in the sequence, then perhaps
it's better to avoid an if (family D) { do this extra thing }, and
instead implement a whole different operation with a little code
duplication. It's a matter of taste though.

I would encourage you not to send a v9 straight away but to discuss some
things on the list first. Otherwise it's easy to lose track of the
conversation.

Kind regards,
Alvin
