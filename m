Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1D1E1024;
	Wed, 26 Aug 2026 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758602; cv=fail; b=MOdGoKkHAUqqq4AmMAauhLoTClXMtjASkrnOsJNN7LNCx7UHPU4nWJ5xEkostcHuni+MrpA9MgtQujwZ2XxBna5o9E/N8IhWNom08wAm+GkqNWh/7sQLPAS5NUv65vqQ0NHyHkp0SJiJkn/2/yabx1sQIRn0X69qyiK/RqGXZWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758602; c=relaxed/simple;
	bh=7abUyT1rDfs539GT1KlXu08VIH+iWDL0e7hcYQ+XTAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3jy+++ej3HZ0yW3m5j8YNTW6Z8Vr+oVnKYUpehOxrPMXGNv3dzRM8DRGffsuHxkym+1IgsZoHxDBcQPtNjPitc3MVPGEMw0o0xow2VG+hDZ4aFtU/Jh12Tqac5N8lQq+ZZhiK9Ql+s9+Y1VNzO28gq+T8uKG7fBMk8ilRHHO8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P1aOhFFm; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P1aOhFFm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koAM1nhFCfopoYIG0rpsRtld+oU79wZmRayV7qNNzSt/662aLCEztzjwtEgdHaeTKd9kVupT7GP/fvVrzpEyq4EL6IxKkdzYyDRWdds0qNkIwpF+edjn58MHnzOfElehVYglbCB5EelJsgft/8erl+L1C39/Pe+F4Tw2c/CYjXtjE0X+eecg7BihuXo3weLA/SqDftZwe6flVIRj6A8SAxSu7iI28KoEwtSsZjNuUAwqFQDRvXDSLmvCukkZ+jZfJIc2D2e4TX0q+RcPMx8lK6UKkZDm8i1uQQS3Mh3YUeMMWFOEWt1Pwz7FuQqbn14S+i9K8lgZhfgj3CKbVyl66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX6t+gg3XjE5Mx+xQO4mqcoJGfJOCEOsXTqp6DS6j/c=;
 b=O0RYdPMI19GVDHwTkOq/pPX3wDsdf4nSimmlflU9QqsZAFv6RxzjiJT6YFa+ZF+TyPraFDShL+RVouccSa64mkmi4u5p5Ys0wS0NkWKBg5syaVM/NW9Sw/7FPEfhEO6+9e9nVPA2m2djUvzWfePptX3Ldnsm17gPMDo0YkRxC6Shq2E4UXwknqaUsmaP5oK9vPV2D/pSieoLB/H+hGL6rcWvvGT+bbmjiykRUAmIyGkr9N1pwmeTiqub2QHoGqO4PDAtgiZ8yePr56oRFAfpvQAA+Lp2RTtdTokOTOQL9YalHeGBLf8LOMzWS0qTSgwUoKDg2r8n22L+mqzaP3Ql2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX6t+gg3XjE5Mx+xQO4mqcoJGfJOCEOsXTqp6DS6j/c=;
 b=P1aOhFFmjc6cp23Q1nvAjwkZ2fV/LZzmvicH80qauFxPOu/64X2gCaiCd6yMIjW63bl8htlZJlNcWfCLe3ieph+Ax7u2BrG8Z09/XNyydudLOqbD96irPIyRPTJUBfItnEmqIVxTn9reQPDqnuu4L81mvhBJuANhyAWA/NkHxgNWl1uyqFznrya7998RWEdyQgL4EwQyoQgD5aPwRLlr8Tcux2KrReEr6Q2JEQ2ax+ul+X8bEaV6BpEmkyN4exQnJ1e1pJ1v9WwbHuqlc5tHmxsHQoFCRvl/F0xnP0wxTl/6JtOkuNNl4MXJV0Azu4NWMcKQDg4PRdxNWHdgU7KXEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AMBPR04MB11761.eurprd04.prod.outlook.com (2603:10a6:20b:6f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 15:36:37 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 15:36:37 +0000
Date: Wed, 26 Aug 2026 18:36:34 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
Message-ID: <20260826153634.ygcvnsbtc4ibpp7f@skbuf>
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
 <20260825214928.rz52tysloa5yxq2y@skbuf>
 <CA+DkFDaHQVE8g2iDUrSbRcY6-xihJQpRNommh57B8wRnePZa1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+DkFDaHQVE8g2iDUrSbRcY6-xihJQpRNommh57B8wRnePZa1A@mail.gmail.com>
X-ClientProxiedBy: VIUP296CA0049.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AMBPR04MB11761:EE_
X-MS-Office365-Filtering-Correlation-Id: c121aa70-2c9b-42a8-62e8-08df0387d0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|19092799006|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LFGihmGxWGSzdaEaq8zH72b9tkPRwIhO/FpWmw3uyMyu6/Cqml87R75By5Wss1PaYZbuyggRcosfP1OycDQKpqvAdJANweBdVJI6depvs0XAFVNBi0JkFfaWp4l3lDlc0Ue5KKAqJxpJBGzBtABvhzB51udvYUpCQWdO93ETTrUdnxBHE1aPyK1/4c38XnjX6r5AgrbQeO7Q6ckS79KAz+SfN+3g/sDBnc/SgMipZGfo1HeWQ4czch+iE0ZJ4sPkl8gWjXcq0qb+gJw9MFKIKs7Xn/Wv+xUxeKxr/rSfUKBpwcjKqzVK6ozLW3/L3SBWYc2w79el3HeeilDnwXxH1unmMfYUSPzmkeEV+HOqB9dbcSibVtmME4D8AsqC4auy8fTV+RQ4n3rqB+TyMSOjXa4eojICj3wsQ6FzKCZTHiRV63duvOzX1TiR36QLQGZFS236pX+lGtrZJbxxlhuBH0QljGe+QAEBgPcD0L8cqRcOQotSdGomXSzlL3aNjF7qEF3z5b7LZz9kqNrKXCXCg1LxmzpLn5+TAe4V/g2YZFRFZDGZWz7D1vO2rlUUdW7xor09WdfwuBo/VwmQHpd1O07/mF56hwkKEELePCExvYmex3/RmsgsOKqkwBDA9HbFOSHKWuv6BBjy8SLHWoHjsfYVLYikTK4/NmJiboQ8/pI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(19092799006)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlFHY002VElvemloM1lxTlN6dUtzZlo3NlNXUUVVcnRweENmT1FGTUd2eHIx?=
 =?utf-8?B?YjZlclVETjBnVUJjNzcxOFcxakFiNEhnR1pFR01KYmVYMVZmYnpkUTRHTDB2?=
 =?utf-8?B?N05raHRBR2luRW5jSDY4ZjB5UFhVM2VIQ2w2MW0vSVJDWDBSdGo3cjhBL3Rv?=
 =?utf-8?B?SWFsMmZ3TGdOOFAxenlVbnNwWmNhdjZoY0ZlY0Y2S0ZkTlk3eHl5ZHpSKyta?=
 =?utf-8?B?akdkVllOTlFYbGpCMk4zYTExSUNLMU9sR0Q3ckJ2NmhVUVl0TUNmeGNwZFVU?=
 =?utf-8?B?ZGo4TnlwaDVQUHpUMHM2b3d5ZHZBbDFJRTVmdXdIbERvMjNPTnBTN3VGQWFJ?=
 =?utf-8?B?R1hhNFg2QmZ2aFc1RkFzSkg0dTBrbXRzS2FxT3BndFVmUHZrdUpmN3AxSFhR?=
 =?utf-8?B?ZnRQMVlXcGxmU2RDMUtjS1lUdVI0RThvcHFmbnh6dWVGQ2h1VTlHZmxxZnNF?=
 =?utf-8?B?dzBMd3pHaVV5cXQ1VkU1QkZVbkUzNW9IMUpZWFRQVHpJNEtQaStVWjREUzQx?=
 =?utf-8?B?bUphcy81RmNrNWFvM0hkNmRYZDVWUTI2U001aWsvSUh1VW4xUlRWb1lDaXFp?=
 =?utf-8?B?RkJybmNRVVdCY1I5NkNpV3JCaWg3clVjWTNSemtHbVNrZEVNT05xb2ordlh4?=
 =?utf-8?B?UUN3bGdkSHA1MWtwOE1rNUI4TkRSZGNhY3QydVM2aUxYa1ByOCs4V2FjM05G?=
 =?utf-8?B?bk1reTFOMjZPUEZKRFh2emxjMk83a2cvWFZFSTlUMVdlVHQ2ZzNpbC9LRnp6?=
 =?utf-8?B?TllvWWRnaEl0aFh2dVJKU3l1UEJLNWVHM2tRd1ppbDkyZTFVbUJwdmlUL3RG?=
 =?utf-8?B?R21UMmZ2MEY3alhmUXJMcHVyZ1hOU1k0TFg3aTRBZUZGUlg2L1ozU1VQbjBB?=
 =?utf-8?B?emRPWEsyRUwyVStTdEYrQmxTL1hneGQ0YUVBSlNRSEdzR3ZtSFdtSXltZlgx?=
 =?utf-8?B?cE1yb2M5Rk9DZjZUVm4raFBpaVpGbkxHKzJUMnN5aENMZUFHQVoxWnRmNjVR?=
 =?utf-8?B?ZUxGamRTRVJVMXpLV24zd0orT0UySUhxSmdHeG9OSXVUOTA3cjJBMythMFhL?=
 =?utf-8?B?cWYyU0pkUklFdG95SEhaZ3N3V1J2MWt3clFwcjRVcnJTVGRWaVFwRjBGNFdr?=
 =?utf-8?B?WGIveXUrZWRrQmRYWGliOGsxNlFheDlZQllFb2FMbG1kOFExa3hCZ0Q2K3Vh?=
 =?utf-8?B?d1dxaVpQMFlRV3N1UkxaaTFRRC83dzUyRkNzR241WFYxRHlEWjRCUlExSG9C?=
 =?utf-8?B?TmhqUnVkbXJ0SHFKeUdxWHNQMGhpN3lOamVhWmlGUXU3VjFsenIvR0FIQko5?=
 =?utf-8?B?MGRqNkFZc0JOMTdBOWUrMUora1UzSVA2cUpBUktlVG5NTWppN2tDUU5lL2I3?=
 =?utf-8?B?NlU3eEZMMURRNVBhbmRhWlBnQzg5RDhpbTJ4SnU4eDgzVG9KUW5UdWo2U2Yw?=
 =?utf-8?B?SXJia3Z3cUJ0d3EvSFNGQisyYWZXZCtEaURaR0ZLbHJrMDA2ZVZRUWVxZ2x6?=
 =?utf-8?B?U1UzT1gwZ3FYcDB2dEdqWEgra0VwS09kNU4ydzRsRWdzdDNTK3lLM3o4OUdT?=
 =?utf-8?B?U0tFOWV4SU5OK2QyMXBhTU0rZUxUMHVMajhvNit4WnI1eFduUmFLV0prNXZQ?=
 =?utf-8?B?NC9wTzhPSE9UMmRZeEY4NTVpRXRXODRZU09mNG9IM2JTRHRvSUZZYUtQSkRa?=
 =?utf-8?B?MWMzemxxcE9pVGpEUlkxZ2Z0cG9Ndko1bm5iUU9sWkVaWnhUK295dmU1M3cy?=
 =?utf-8?B?RFBCbEMvZEJQQk14dTIySVg0S09GaVBjd2RFT1lNNzhvTmljbStiU1ZFTDAr?=
 =?utf-8?B?bU5GN2lwdkRCNU15TzNCVzBHRDZPVFJhY0d4S0U2dmhsLzRuWExaM3pURkd5?=
 =?utf-8?B?N0YyOGF0SFNxcVMwaEY0cVQyL1E1amlvbTUzbktuQUZGUUg2SVJYWk5pSXZx?=
 =?utf-8?B?SHYvT1ExUldmcDhzbVR4N1NESitMOWI5VjhMN1BFVjVsbktPRDBOdXFwZHdN?=
 =?utf-8?B?UkJ1Y3c3TGhMT0w2dG5kVHF3czdKY2hQSVBhTjUveHhTbnpDNFJxclZCNVdh?=
 =?utf-8?B?TWo5cVNKcWJIR09PRWxuZUE1Wmh5TG43L2tRMFdaSmtuYm0zU1RzKzVEa25m?=
 =?utf-8?B?Nng2UjcySG5MRGhneHFQbGtJb0w2aWdIUHVXcDExR3FwMFl2V3NvZXNEanlG?=
 =?utf-8?B?ODBUR1FnUHVUU1Z3RjdvRHh0MG9TdjhJVWx0ZU4raEd1czRBbzdzZWgreVVN?=
 =?utf-8?B?dEptS01VTlIvbjJ5M0JMWEZWcEJ2T0dwUlBjVnBHK0s4NDI3MlNSTUNad2hq?=
 =?utf-8?B?RTEwTXVzMGJkZ1c3UkpmbTB1NFZWN1RwV3RQL3ZNc3ZUOFlYUmVYSWxTMjM0?=
 =?utf-8?Q?nrJyfMEfuTPcvedWscDdKHixEFu3M2zE7wWP0nyavdSOS?=
X-MS-Exchange-AntiSpam-MessageData-1: xEkws8/Ctmwp8g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c121aa70-2c9b-42a8-62e8-08df0387d0e1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 15:36:37.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUX13AKW8TqkpfXhJLpDiCoZIv8hv7F+o+kssPhOhlXM8Xei8lrDLZ10Wu3RNdNP/DCDVs3rCoCVVsNbE4T8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11761

On Wed, Aug 26, 2026 at 09:37:45AM +0200, Patryk Biel wrote:
> Hi Vladimir,
> 
> On Tue, Aug 25, 2026 at 11:49â€¯PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > There are multiple differences compared to U-Boot does. I haven't yet
> > been able to definitively determine the cause for regression. I'll debug
> > more tomorrow. Preliminary testing shows that any link timer values > 0.84 ms
> > will cause in-band autoneg to not complete with this combination.
> >
> > To be clear, does your board work with this patch?
> 
> Yes I tested it, I can provide you any logs you would find useful.
> Below is just a short log from interface bring up and simple iperf3
> test:
> 
> root@tru-:~# ip link set up swp0
> [   60.159618] mscc_felix 0000:00:00.5 swp0: configuring for
> inband/10g-qxgmii link mode
> [   63.308354] mscc_felix 0000:00:00.5 swp0: Link is Up - 1Gbps/Full -
> flow control off
> root@tru-:~# ip addr add 192.168.10.2/24 dev swp0
> root@tru-:~# iperf3 -s 192.168.10.2
> -----------------------------------------------------------
> Server listening on 5201 (test #1)
> -----------------------------------------------------------
> Accepted connection from 192.168.10.1, port 44470
> [  5] local 192.168.10.2 port 5201 connected to 192.168.10.1 port 44484
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec   111 MBytes   933 Mbits/sec
> [  5]   1.00-2.00   sec   111 MBytes   934 Mbits/sec
> [  5]   2.00-3.00   sec   112 MBytes   935 Mbits/sec
> [  5]   3.00-4.00   sec   111 MBytes   934 Mbits/sec
> [  5]   4.00-5.00   sec   111 MBytes   934 Mbits/sec
> [  5]   5.00-6.00   sec   111 MBytes   934 Mbits/sec
> [  5]   6.00-7.00   sec   111 MBytes   934 Mbits/sec
> [  5]   7.00-8.00   sec   111 MBytes   934 Mbits/sec
> [  5]   8.00-9.00   sec   111 MBytes   934 Mbits/sec
> [  5]   9.00-10.00  sec   111 MBytes   934 Mbits/sec
> [  5]  10.00-10.24  sec  2.25 MBytes  77.7 Mbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.24  sec  1.09 GBytes   914 Mbits/sec                  receiver
> 
> Will also try to find out what could possibly go wrong.
> 
> Best regards
> Patryk

Thanks for confirming.

I suspect our documentation is wrong, in that both for USXGMII and for
10G-QXGMII, we have the same text:

  Set the Link Timer value from 0 to 6.4ms in 3.2ns steps (312.5MHz clock
  periods or 312.5 million XGMII columns per second). The reset value sets
  the Link Timer to 1ms (312500).

But when you think about it, 10G-QXGMII multiplexes 4 ports over the
same lane. So each XGMII receives one block at 1/4 the rate of the lane,
because of the time slicing. Consequently, by my logic, the PCS link
timer, which uses the rate of those columns to keep track of time,
*can't* have the same link timer tick for both the single-port as for
the multi-port mode.

I was suspicious of the link timer limit I obtained (263050 ticks,
corresponding to the ~0.84 ms I was talking about yesterday). Higher
than that, and the AQR412C system side autoneg would restart (and a PHY
counter would continuously increase, indicating this). Furthermore, the
AQR412C system side PCS would never lose block lock.

So I wanted to see whether an ENETC, using the single-port USXGMII mode,
could also make its AQR112 PHY to fail in-band autoneg in the same way.
And surprise, I could, by increasing the link timer to 1037500 ticks.
Surprisingly (or not), the maximum # of link timer ticks for USXGMII is
3.94x the maximum # of link timer ticks for 10G-QXGMII.

So actually, I suspect that when we program a link_timer of
LINK_TIMER_VAL(1600000 ns) on 10G-QXGMII, in reality this results in a
link timer of 6.4 ms. And my AQR412C doesn't like a value this large.

The above is pure speculation/intuition, but it's the only thing that
seems to be consistent with all data so far. The only unknown is - why
does your PHY tolerate a link timer value that the AQR412C doesn't, and
will it work when we set the link timer to 1/4 that value?

Could you please test the diff below, which should give us the info to
the second question?

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 305740b577fc..735ef4069a7f 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -24,8 +24,11 @@
 #define IF_MODE_SPEED_MSK		GENMASK(3, 2)
 #define IF_MODE_HALF_DUPLEX		BIT(4)

-/* USXGMII replicator link timer step is 3.2 ns (312.5 MHz clock) */
-#define USXGMII_LINK_TIMER_VAL(ns)	((u32)((ns) * 10 / 32))
+/* USXGMII replicator link timer step is 3.2 ns (312.5M XGMII columns per sec)
+ * for single port mode. For quad port mode, it is 1/4 of that.
+ */
+#define LINK_TIMER_VAL_USXGMII(ns)	((u32)((ns) * 10 / 32))
+#define LINK_TIMER_VAL_10G_QXGMII(ns)	((u32)((ns) * 10 / 128))

 struct lynx_pcs {
 	struct phylink_pcs pcs;
@@ -187,7 +190,10 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,

 	link_timer_ns = phylink_get_link_timer_ns(interface);
 	if (link_timer_ns > 0) {
-		link_timer = USXGMII_LINK_TIMER_VAL(link_timer_ns);
+		if (interface == PHY_INTERFACE_MODE_10G_QXGMII)
+			link_timer = LINK_TIMER_VAL_10G_QXGMII(link_timer_ns);
+		else
+			link_timer = LINK_TIMER_VAL_USXGMII(link_timer_ns);

 		ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
 					LINK_TIMER_LO, link_timer & 0xffff);

