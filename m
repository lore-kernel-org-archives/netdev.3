Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023111.outbound.protection.outlook.com [52.101.72.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111330EF7E
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857561; cv=fail; b=ST5j185Rl2xWGFGq1D5G7gS851hfqRVxVcgCG6O4ev/8pziXcYpvXjjMqH3eppJyiJuzRuCAMWz4sfD6M0CqkPyDQBfytQ+0hszRj/D2kmD24v/t4EPFbOD4QLr8f4Ha/LKrlyGfrffEPgI9ou6fqg5Bq0a4Sdh9dUK5xQMwsYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857561; c=relaxed/simple;
	bh=r8q+G9UaixJYVxmqbgUqKRC9wePdWXsAaAsRUK5J08M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWvEJ7hpn6H5XrwA9en2J1BPnaiKDA6jFbph/u7Tda/dRT+YOuEMsOIHen6JJhMyXAEwsRHGlpS8bDEZT+4jqw5jGnJLYgNeOoPCXtCAVbMb7ztEOsQVIl7dgFrETY9pYL7Ub8RNPdlQynBELDb1z3uaPR5BBq7xRKDkEwVNj84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=OkMXvcxb; arc=fail smtp.client-ip=52.101.72.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="OkMXvcxb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s12It+2drBeNaaRLfQvVMSIBu5eXBaSp3OG/1ku40DzgNmvXnVZBUMQZG85IYIxBpnGuLBsLvITnHmhRkWKfPfFtSSy5p9NwJHPS7nmaghuQDH8GzBOHiv8Jlk7h7ffilYhVgqP9OYTWs/Z/IB3VbhPPS8lSGOnTNRGJXw8hBCL9AGN2001PjyXYfz1C4yzOaK9HcklFY167TYT1KIMexD5qYicYlI1VHI+0hkhwhp0pi3WCutqssXv/BMBeiFtl054FLeJyrhzQ42/WM6LM5lDB+s77t2WpCi73yzFrM/Oobyv21xEXOFRROaT3fIW+tD7Hhn3n4vRrbDZertFmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRZYduhx6RoRVsadNw3JIAWkys6FfdZfhILNmLukyVw=;
 b=i9VsaFD7ufar+ngnvFQmjBcgaWn7JvQY0v0H7IynIt1NlW1FkN9fl5X+QN0rjnLDijaDPlcU5yVDon08wDfvNd8usT/4bnd1rvnN8DkEDFPdZuuATvo4nNji3r+sTljvvfYE3CaSfReY8KEVBUmUHk8XuU5TttaGs7Rcf8H6ksx/z2jBfzEe5oZ8a1No8bTXvAQw8a/h8ukvM3YKO6sgK8JleRlukWc2q/5z7prWUSYeCEEs0twvI77GcLWBNjn/WEeISGwLyoUGzrOMWQT0yRaavI9kvciiIk9+D1B//toSE8O7l8fx6MgAeGKUPSJyicrawiju1sOBy1ldWKhKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRZYduhx6RoRVsadNw3JIAWkys6FfdZfhILNmLukyVw=;
 b=OkMXvcxbUzk+EHlD+cyQYqBf/wRbkiJXDdfs1PGsgrAU3St8TGAZGb76ZBVx6lgwUFXbTxcu82AEsqEQbUoE2Ighi3bhmyYwBeaJPhnZJnOYi1xEY6xU9wWyvGdu/UulVYckUc5BokBLnep0GzRmrkALrBtor6xOvJa840Ljzsqut7bQ40+x+0h5TTF/bzBkYmHBdeUF6Vcyz1ZO+nP0azU/UeTRQfSIHNGiNwKF5xmu6JTz5+tl7CJ5+4sgEYhrqQ20RjEmMkfNtm+r8Hm36sMM3eO95Oxq3QV1ESskNsEa/metb/zVcXvk6iCRHXetxRPf48qeMugg9pPiWhRqLA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from PAXPR08MB6703.eurprd08.prod.outlook.com (2603:10a6:102:138::5)
 by AS2PR08MB10296.eurprd08.prod.outlook.com (2603:10a6:20b:648::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Thu, 1 Oct
 2026 12:25:53 +0000
Received: from PAXPR08MB6703.eurprd08.prod.outlook.com
 ([fe80::9b47:d8da:d257:dacc]) by PAXPR08MB6703.eurprd08.prod.outlook.com
 ([fe80::9b47:d8da:d257:dacc%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 12:25:53 +0000
Message-ID: <904b556b-a73a-49e1-bb5e-36fa28b1a3be@genexis.eu>
Date: Thu, 1 Oct 2026 14:25:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Andrew Lunn <andrew@lunn.ch>
Cc: John Crispin <john@phrozen.org>, Ziyou Xu <xuziyougm@gmail.com>,
 netdev@vger.kernel.org, Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Gaoyang Wei <yhyxwgy@gmail.com>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
 <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
 <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
 <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
 <747749a2-b168-4ba4-98d1-12991e8694bc@genexis.eu>
 <e3dfe67b-6d29-4bfb-9642-8c9e86a9a7b1@lunn.ch>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <e3dfe67b-6d29-4bfb-9642-8c9e86a9a7b1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::18) To PAXPR08MB6703.eurprd08.prod.outlook.com
 (2603:10a6:102:138::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6703:EE_|AS2PR08MB10296:EE_
X-MS-Office365-Filtering-Correlation-Id: b63d1efb-383a-4888-5f5f-08df1fb721c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PPzOjozjeqdr6KAFtRRzCGcLoyQNIw87DFah4Ysleni6uhy0V7U1vBGcmj9VsOSct4pdmjweCHNe8PQiou2seWZmyGUmNNPw11lFEelk1RgFDISsxgt2z2J/JlNTlSk3Z0W6s4ynN1T11cb6Qk6Sjwzepem57EKNqKZmpg7rO+IYLfM5FNhcIAtt2QgUJL9NWny7R3azXQ0fh92CG/MkztmuoiOfOaUZT7wALJ7M7Uc8k6GV7DH3SP+XMD5n9jXQB7dhAXA5hwzWv2XLRQABilss9DExib4EEO104v1q7U3y5x6VrgjgO5hCyEpCRbi6PD70iMsGf/VegpP0S9iIXo9v5IhAdPfrC5Q4Gz5b9CoJCSZqpAEBP0geDnshcjwdX7SZznc2/N+xrFiTlEWxgOCFzFj9QN2clYmcZ/CQS3mER5c74+HEauzcGo066dVc5hEXOgkSiXsewNi9mKKHHW3Sp1ZhHL53QC8b5/purHvTfqrM3cte16xr+v6EpIcHd+8RhKA1IBp+VE8N3n4xJq+dh6vmtb2KBr92OOgDgRXVaGhA+AyabcxpJ4Uxk73u2cRLCOVNJKyLjd4UiSWVG+PMJyebwSKsbm4U4PjwFQor/dU9GVzcz3sHAwbThvs77/6R2sxzZct4oR6aGLS7a6H2et1qwnepQY38h+oQhAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6703.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkF2RGI0eXJJRGc5Ty9QdGVFV3paVFprdko2a3JidVE0dUlDMy9CUHdOV0FX?=
 =?utf-8?B?SUZ3Mmd4YUhJRndJWVhVQzRXTStIK0tURjVCVXRoTWMrSUt6RllHZlJJZmt2?=
 =?utf-8?B?S2hhc0xKUlFYc2M4V1ZBK2VTSGtuR25OdVBtdkhCdzRTNWRNV3ZuZEhQeUY4?=
 =?utf-8?B?UWFWbDJ2RHVJemJUR3BkcW9XU09kcTZDNmZoSDBxZ1drVzN5Nkh1bG5TRzlk?=
 =?utf-8?B?RDRqNnJLSW9DZUNGODFLUGIrUDhhcS9yUXpuT242Y2ZROVRCaWtzQ0x2NkVw?=
 =?utf-8?B?dGcza0cxMTlaOEQ5b3lyYWFWZ0xjZnBrZG9XL2xMSHlta1U1Q05XQTJ5REw4?=
 =?utf-8?B?Y2lSclNLL3FHQldoRWJ6ajcwcWl3WHNCVmdocm1pR0lSdDFjMU9YZ3RmVDFL?=
 =?utf-8?B?N1d6dTJuOUhwRFdiZXZZTlMzMFZHZk1JeEt6Tk5YU0lhZ2FMRy8wWjg0cVBE?=
 =?utf-8?B?YW52bXJHV1FUSkdvbjZuWnNoZDIyZ1hFVzFBdUpkUmMvT2ppaHdyaXp1cnRo?=
 =?utf-8?B?eDV3WXBRd0dsY3RrR0JBVm43ZkhNTEtvSGE2Y2l5eEpUWDdDczAvdnZHMWlp?=
 =?utf-8?B?RWdnKzd4RWJLVHh5dEU2YUxGOGxEcGx4ZzJ0azNwblJIZHh2cDlVQlh6VUMy?=
 =?utf-8?B?VW4rUG9sekJtYzJHWGVxQnZDWTZvT3Y1Tll6amZGUXVmQXZHMXMzb0FvUWl1?=
 =?utf-8?B?QUpZbTIxSHRvTXFUWHMrT1JjSjZlYmM2QVFXT1hPcENEQUt5YWFGR2Q3QTZj?=
 =?utf-8?B?VHhET05uZ0tMQ203N1Y3d3ZCS3JlbGpQdlNsdDd4cjV6VnJjY2d0OTRFRkpC?=
 =?utf-8?B?QnRnZGRLcFl5UGYwQzdOR2F5bDVqemR5bFFzTW12Z3lzUGszVkhhOFEwMGtm?=
 =?utf-8?B?c0FLako2U2JnSlk3QWJkTU4xY25LQWFRN010WUZpRDBOb3VaNy9ySE82bmY4?=
 =?utf-8?B?czlsMWJHb0MzY0daTFZ5azZ6NjJ0eklsUUV0YnlyZzNjQXgxckRWbUtvWkIz?=
 =?utf-8?B?YkFMU0dDY3lsNEd3QjR2bU80SlU3Qkwrc3d4VUh5OG1NT25ZMVVqNjdwZ2ww?=
 =?utf-8?B?b2hkK093cHJoc1NUdzkrL255MGhsKytlZjd2MmVzRWw5V2x1VHZpNkJ4cS9v?=
 =?utf-8?B?aUNENDM2QmJmYWVMQlVaVFFFQkFBeUNUQUs1ZU9xVDNpTG1KamQ0MitZY2Rv?=
 =?utf-8?B?K1BFbkRzL2k0U1hQQnRPV1BPczgxc2grQ0RWdVBpdzVuZDZRemZza0ozV3NY?=
 =?utf-8?B?Und1RVA1a3owM05SaDFWcjJNc1Y3citEMDgveks2UlI4UDNES1VvdlRabVBw?=
 =?utf-8?B?QytYK2tvVkR6aVJtTlZyRXJidG5kWGJLYitpaHkza0JuK2tRWGsyVlh0Z2xz?=
 =?utf-8?B?L3ZtNHgwOEp2dThJUTE5aEJGVUNnL3VNMnFtazF2OGprNnZPZUpZdmIwK0Jr?=
 =?utf-8?B?YXVpVjJsN2Jld21xS0NWQzN0VWQ1Y3ZZNjdQNXdPOWlzRnc0ZlgrVTkxb2lW?=
 =?utf-8?B?ZDBCbXJFc0F2ckM1VnpHMUNkZ1FtSjZHYXh1cExmdWxnY1JvYmpnandoYzlo?=
 =?utf-8?B?SjlXWElyeTNtbEpqYlcveFN5VEN4LzFaeVZYa2xmZDQrNytCazUvTTB3V3ls?=
 =?utf-8?B?ZFMvUGdPdU5OR3RSM0JoT1R5Q3dNUkk2N1dValJlcFArUWpmOXYrQy9FWHla?=
 =?utf-8?B?dVhhL1Rsd0NMNlBybjlkeDdmR2pBVEFDKzhUK2NsT1pQZDhaYXdnNlFFeTZ0?=
 =?utf-8?B?bmNKSitkQlBuNkZ5TFdFcjRWWDJkVk5nUGQydHd1MUdiVTFUWGhQckpiTkVz?=
 =?utf-8?B?NkpaaUVYeFBTSlBQUCtSVWVkaXRubE5SMU8rZk4yR2QzWEFFUWgxN05qTUV1?=
 =?utf-8?B?dUtaUDJEYi9rSUNOZ0kzZnRvVTdQQW94b2NhbVo2ZnFMOVBVMVVUVzBkZ0wx?=
 =?utf-8?B?ckVNWVNLYkE5V1JWeUpoVUV4NXUwbDVFTFFhM2hWNXVpNk4yZW5kUTlaYmhX?=
 =?utf-8?B?cUxXWXR3Tk53c1NkQnlleWEydm01WVhCWFR6a0l5dSs4c21ONFNQQWUzYzA5?=
 =?utf-8?B?UFcrcm1GUERXNyt0UFZnQ0tXT0JDWU52L1JFdStPeGgyYXBkc1Z3djVQemR1?=
 =?utf-8?B?Y0ZmODRGSDk1NlRXaGFvMFdMNE1KRVp2ZGdsNTNVQTRkNUNRdkJWQkVicWJG?=
 =?utf-8?B?cElScDZSYUtveEdHMXVQVHZrUCtFWGJUaUg2ajBTREU1TCtpbGJML254amFt?=
 =?utf-8?B?U0h5Z2NoLzZXQ2JlWFV3bVE3ZHhDbHQ1U2xFb1ErSVVteW5LV0ZuaXN0U3gy?=
 =?utf-8?B?TDBZNE9pTDdtVkN3NkdGVVVHelNpU3cyaVlSVThhWlo3NEVoNVlDbGRwM05Y?=
 =?utf-8?Q?DZkJz0VfOHviFZYpy59ImaW/SdQ/TB9lAZ2ZrKHekDAg+?=
X-MS-Exchange-AntiSpam-MessageData-1: gNGmdl+aLE00JdDDUqLQdNb75QbMHzc7ZQ8=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d1efb-383a-4888-5f5f-08df1fb721c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6703.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:25:53.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJguq2EMSeQvzBMuZy3Eb2Q5p55fpg8C3s1C/Oct7F5FfbDSQuQyyZTCIPtX9pHIHIoaklAE+hfOpe9OYj3+DpHVlXmMIBoYIoQ/YkGrxfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10296

Hi.

On 9/28/26 16:10, Andrew Lunn wrote:
>> In the case of ANI-G 263 I looked at hwmon a while ago and IIRC there was no
>> nice way to consume hwmon information from inside the kernel
> Not my subsystem, but that surprises me. How is temperature management
> performed, where you need to reduce clocks speeds if the system is
> getting too warm. Fan control is a similar problem. Both need access
> to temperature sensor values.
>
> 	Andrew

I only looked at this api briefly. From the api function names and 
documentation it looked like the main direction was towards user space. 
I still postulate that for in-kernel omci ME handling some kernel work 
would be needed to get access to some data, data that might be more easy 
to get access to from user space.

But as I have written 0 omci stacks this is just my general feeling. And 
there is lots of insanity in the standards covering omci, you dont need 
to implement everything just because its in the standard.

Anyway, I'll focus all my efforts into reviewing/testing the RFC coming 
from John and Christian.

MvH

Benjamin Larsson

