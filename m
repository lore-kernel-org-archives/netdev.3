Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023082.outbound.protection.outlook.com [40.93.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB23416864;
	Mon, 27 Jul 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169244; cv=fail; b=hekY3JgVPdWW3i1vsBIeBoZoSrWfMdmVEy3B4gYpnRF5g1pyhg7PqbhJ5qKdvLrTchBu6WyldhoNnp2+Kkp76mZ7au8cDMZBuEmsbfrsTe71uMHGcz/9BEsMmfBbecan+uwbXr7hU+H1bumLoxTwrXHvLL4NQijPct75jQi8fIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169244; c=relaxed/simple;
	bh=XCEZ9Wgji7RrxcPjn3d5NR25awbNDje1rcJG+HTaiTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHEgaaree38fS67QGnVJZxIq5XUc6bJcrnwQ+TreIOcTMqvCnktAb+V7ZbCL8vzWTFBVJ/brac83wmLlaKn1lLaO9HfAj87iDbcq+RyPaFP/jqAUi839KPGcc6EPj4sLEyw3mJ+ice2iLMsl0HDEa7C7BEPrIS/VLeqvUaY9n/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Czhp6G// reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Czhp6G//"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAGijCj5/fSXJLegzoPwbOw+cZzS8uSfdB3/fZHGf1jDyvYNSVxJUyVl5sYcOCqss9xeVtuNRG6pRS74TFzc0sLrXbgoqqAzl5l1LG4roQA6ibD57Q2jqnhdD3i2R/e+TIsEBmjbp48ag0eP3+upCwBt3AGmFU9SOOv0BxjkvZP90LLq+MTsTldy9M86nw8v6TYchDjgc8c8B4xx6aJiCb4Prwx8v6Abty2GuG6UVPj0/dmG1YgCykrIUJyIh0oeU5rh2l1Uk5noCnFoXCJ1y8NrJF4nTOlMGryZpTTBFzVBZ0IkwMnTrIEi6n7LbN+06Pcho8KugxuvBKUetGy+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXYCJ+O6VfypSf2u9qxhoOuTDlKaWvoQVa5a/IUcbcY=;
 b=jeRQiXOuxxFEeAizPvnxSxbOSwDep9BSUrizTdlb00E1TP9mK9MjvN1TSccpI5hqdmrf1xthOnOl6dgyuDutRkuO1PqF1kSxUaKW3IfazfZShPBWifkI91slaXensOsyeSQDftZtXKpn3uS8txsS+3WFE0RZRhvKEe/sd7KIL3j6V6S2wU/77nMfvPN8x6mWSWmjEmC7DzpqWSfIsbPX4atUNIwsqkPXzNaBtg/c5PVACTbk6AExpPEjwfNFhf1OMptBvKmdrIDoONBvU5JvXRx2aRMBYtRCmQcut6hS1bNHVzIUEUoj0FMPS472BifpqaVxfQa5T101WT1NC9/hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXYCJ+O6VfypSf2u9qxhoOuTDlKaWvoQVa5a/IUcbcY=;
 b=Czhp6G//Ook+Kb9J+S5RSln7x94rPOLpPMh5YkEE7GyL+YXrn7sHkcHbExSEG7vQMKxuVD7M6k3YkkT/QQJXmBURUAPFZz6J74RVag1OF92NBOgJIXvKSGrts+OpexgPCSg5RwZtgZk3tAt8ZAfSi30vG4r4fD5knePY9X62Umw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV0PR01MB994055.prod.exchangelabs.com (2603:10b6:408:337::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Mon, 27 Jul 2026 16:20:38 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 16:20:38 +0000
Message-ID: <1957e9cc-dbbf-4bad-b0ce-20ce69ae2c01@amperemail.onmicrosoft.com>
Date: Mon, 27 Jul 2026 12:20:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v45 0/7] MCTP over PCC
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>, linux-arm-kernel@lists.infradead.org
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0158.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:6a::11) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV0PR01MB994055:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2e7d7e-74bd-4a39-3054-08deebfafedb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|23010399003|56012099006|11063799006|10067099003|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xHMjSIltBsfD1D3Cw2D6s1qxw8qnm700MKoo8OrchnwMAs5w2EhejqyejTC24NmFEIhOMLaCXMaKvktvHxqLrn7NM2fci9XMtbU/Ax6FFfkmOhAKfTP0yBGpccIX77S+oU+6lzGWws+Ky9gc1L1YRMsm/SF5QRUZ+BheSnMo2cOXiADA4CLfLUsrbAjPAzKkw4ffsOp+GKwMaXe9+rHVt/vHTAE/nAl6fBSCvCSNbvekHBBjD5k/pR2hTFX4e11yfQ5nE2ctqtIIpR370FAKOmQCZVnWXwv5F9lzdul5vegONl2w1vh7OyjvVVASrZ4JNaeCKUzDIfiHh/y0tKmE5uc2BoYJkVTC17K+ijmazeLyzhS7UzwET3h1Cy0dZGhJxQ22ZpupxQtlBPYQCiX+t+LHcJFHKPbqPEGzSAx84pDuCZuMNCGKii7ehwrMih07ucBVPGXU5NEkKpNudSiJPKzn9q4bw9khXZGZzIesJqBeBLyiuuqCBBdCz1mP9rve3hL2JaLp78lEwpLm3GhVRtCS6YOHoe78LXaNZT4vX+4q1mOe/MQJAwYTyQgl19MYdOxk567LPCRp7tL3AIQWja21+B9sIZS/2cgSmgy5PIJEUeCbIPfZD4zBGvt6LfPAaeu0a6fr/EEdxjhuxOJOMoajHY6S9+ofSOzRt96e518=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1hQWDZqckdBNENHcTBiYkdkK0wwQSt3WVhuUjNCb04xZFlJdjhIQ0ZlZXpr?=
 =?utf-8?B?NlRTcWw4ZHBMWnRTT3RxZUVjMER1ZWtIZFVXekhpdit5ZFNsSlV4UjRva21Z?=
 =?utf-8?B?dncwWGwyQVpkaWluemRuc0d1Q0puZExEbnFkZFJJV0FJMi9MU0lVU3dqQnRH?=
 =?utf-8?B?NlViSkx5RDQ5Mk9VNElScGdCc1R3SnNzVlI2amJ4UTlZQ25OSm94b1JqbTZL?=
 =?utf-8?B?dTlNSkpGbGFhZWRhWFdGVEpzRDNKZU9KMFpTNkVtRlhJWTM1cldzNlJ5QWd5?=
 =?utf-8?B?N0RScVV0VXRvWTFpY3IwQTZWbnl0REJ3TGJPU2VFUkh6SjZLdURFOUdrQ01n?=
 =?utf-8?B?R0NnN2xsck1wSFR5MlQwZTg2QXkvVEUzSDZmN1ZpNGkzR2lLb2IzZGlPOW52?=
 =?utf-8?B?S2NHZW1RZGJuaVE3eTQzSk1RMFZqUCtLMFpOQ3NGMzkvVDFKZmFTSUNXVTcy?=
 =?utf-8?B?QUczMDRTTy9qZXJESGIyQlpHV0t0cXk5QUd6c0lBSVVibVg2cng2TUtDdGlZ?=
 =?utf-8?B?eld5b29KSGdXTEEyK2tvWm9xK3BwSEdzOExwelY0S2FrL3lZN2s5NE1paHpk?=
 =?utf-8?B?dmQwOG9zd0FTVGJCVitSQ3plRkttam9UTFdRUHpBVWJOMDRpSElucUlvZVJR?=
 =?utf-8?B?V25RZ0hpV1FhQW1lUFlLSGdCaHJEWVlSTWxSQlllMnQ5QTU2WkhocDhsR0Z6?=
 =?utf-8?B?clAyMnVPTU1Jb3JNZTU1ajBuNE5LRnpQTmFjMWVWRkM5cXd3cWtzK1FEWDAz?=
 =?utf-8?B?VlhvSkpTQVp3L1RoMHIwa01PRW9SQ1VRVXRzaVNJYWNucURKTkQxaUdOblJS?=
 =?utf-8?B?Y0pLZkpyMzcrdlNQdjAxeDNrVVg4ZFR1aUVWR2ZZUzcrMGZUNmJIVDRWR1dO?=
 =?utf-8?B?dnVVa205L1lNTnZFZnBWK29FL1M4VzYxYmNCeTc4QmFyL0NvalZ6Z3RiRmFr?=
 =?utf-8?B?ZmN4RERRTUtkQ2NtOVM2ZlhhZktQcmgrL2lHZk1sK0tYbnFpZExTSENCQnIw?=
 =?utf-8?B?RTJ0S2F6YkFUblhPT1ROWXRlTUZpd3QvR0Iwbk1mdCtoRFU4MFRHNEtqZFRx?=
 =?utf-8?B?VlJpUVhIM3RRQTlGM2dIUkRYY0VPaDUvZ0tQU25hUWJYWjlpbjhiMkQ4NEVY?=
 =?utf-8?B?Y0lyR09pUnl0OW5xVDlKejlaaFJZQ0JIMFRlQmxIR1dEMkJlRnQ0RUJzTk1V?=
 =?utf-8?B?Q05QL05OUzlSYm41SVhzTEpjcnFFK3dMZHp2S1ZTSW5LZEdtM3dTNEpQMVF0?=
 =?utf-8?B?Zi8wQmtSUEgwSTRkdVFVVHJSSEVvOGFtY2UycG9MUHdGdVNMT1VacDZ3Rm8y?=
 =?utf-8?B?cVIzdXNWZkxUa2JTNEY0NDVtblRGM3dXVHVDRFJXSFMraDRFRjBvN01UL1pP?=
 =?utf-8?B?c0p5ME95dU9Hclo1Mmw3VnM4WTZlM094b20yTVNTWGNqNWM4Y3hpRW03bTVs?=
 =?utf-8?B?RzRMcWV1eHd3ajZuTm1oMHN0MG9LNzU4UWJzaXNkME15bWp4WGYxSC9lTzlV?=
 =?utf-8?B?Rjl5c1VRdmVuT2ZHQjJGYmJSQkFUbmlPbGZxY2pVL1Q0Uy9IK1Q3TlJqbjRD?=
 =?utf-8?B?Q2l6S3hqS0hPczIwTW5SeHNPaW5FUkFsNlNaa0xwRmdKQWt3RjNCSTluUDNO?=
 =?utf-8?B?NjFSWkRDL01VNWJKaXZGNEt1dHNnenNlRkZLZmxMaVF0a29iWklQU2dqTjAx?=
 =?utf-8?B?akMzcStvUm81UHBFSzlhRmh6OHo1dml1cEF1RU81ZEp6RGk2djJsTWhYR3Nt?=
 =?utf-8?B?S1EvOCtZaG44M0JtbzlhWnFQbUF0QUNiYnBlVW5kZVJtZDdMVnVRTjcwb0pM?=
 =?utf-8?B?Wk9uVFdLQkRFOUdsdmJwaHR6VUFQTWJCYnorT0FidDZyTEcvaTV0dlVFVFoy?=
 =?utf-8?B?Zm1tZDZ0bjlBcnN4bmVzSkY0TWpsdWVYQTlobFJxU3Q4WUsvbjVaRmZnaWtD?=
 =?utf-8?B?eVBaM0xnVEJGTUlDZDBsNHkxb3dVNHB5VkRrT1RJOHo0SzY3ZjVDbmdXZ0dV?=
 =?utf-8?B?Um1UTXhYSjVwQ1pUbFZQMFRlSE84MUVXdjBieWRUK2xlVElZZExiRDBGbHhN?=
 =?utf-8?B?MVlmQ0wzZ0hSWUVtRmdEWGtOWkN3NFRKaUc2akFhVnNMaVB5Q3loVEFVZHpu?=
 =?utf-8?B?cXEwMDNVTlowcDF5Rm5zOEpYcUFVNlVLU0hwcTRLUU5WN2lZQTNHSlk5UEZ2?=
 =?utf-8?B?dXJzZU5HTm1TSnlyd0dBVU9uMzhMUmpsK28yaG9MSmxNYjJVVVRLZXp0emMv?=
 =?utf-8?B?eGJLTlBrT1hrRkhxcmtQUVVOSzA1bGhjWXcyNEV0OU5VQ1hWMW5ydVZIYTZ1?=
 =?utf-8?B?MVRhTEszWDliZ0J5Qy9FZ3F5UzlZdkhKQ1hrSjZrcUJnbkJ0THkya3RHQWlv?=
 =?utf-8?Q?GX7DZiYBWub4c4PEZ+8pH1sCVvwCqeJ2y/2VjtRZeAHKZ?=
X-MS-Exchange-AntiSpam-MessageData-1:
	9A2z0EDZez5sG4wWupBU5w88u7YyRh2v5iM8s2RO4YPca99h3DrUA6tU
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2e7d7e-74bd-4a39-3054-08deebfafedb
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 16:20:38.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZTANDdfglFz1pwiluBjPujkMQ+3WDY6RBNy1NnavvtxblUrBg3G05eV5szQQIgTAz6KyiqQ0BRme/zU+VjawRt6F2QADNdSD5oEx56WGrPLgVTeBtAaq/D8WCmmzjH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR01MB994055


On 7/21/26 13:52, Adam Young wrote:
> From: Linux Bot <linuxbot@amperecomputing.com>
>
> THis patch sereis is long lived, and the main
> changelog will saty with the MCTP over PCC patch.
> Recent changes in AI code review haved shown required
> fixes in the PC mailbox layer. The main changes to this
> patch series are the addition of those patches.
>
> Adam Young (7):
>    mailbox/pcc.c: shmem map/unmap startup/teardown
>    mailbox/pcc.c: ignore errors on type 4 channels.
>    mailbox/pcc.c: report errors for PCC clients
>    mailbox/pcc.c:  add query channel function
>    mctp pcc: Implement MCTP over PCC Transport
>    synchronize IRQ before releasing shared memory
>    wrap pchan->chan_in_use  in READ/WRITE_ONCE
>
>   MAINTAINERS                 |   5 +
>   drivers/mailbox/pcc.c       | 112 ++++++---
>   drivers/net/mctp/Kconfig    |  15 ++
>   drivers/net/mctp/Makefile   |   1 +
>   drivers/net/mctp/mctp-pcc.c | 466 ++++++++++++++++++++++++++++++++++++
>   include/acpi/pcc.h          |   9 +
>   6 files changed, 576 insertions(+), 32 deletions(-)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>

I am seeking feedback from both the PCC and the Networking teams on how 
to make progress here.  The MCTP Driver can be made functional with no 
changes to the PCC layer,  but it will have potential race conditions.  
Those will not be triggerable on the known hardware.  Can this driver go 
in as is, and we pursue the PCC fixes afterwards?

If not, the PCC fixes are blocking a driver that has been through a 
couple years worth of  code review, and should be prioritized. I put 
them all into this one patch series to simplify my own organization, and 
to provide a unified narrative for the networking reviewers.  However, 
the PCC code tends to be reviewed in linux-arm, and this organization is 
making it harder for people on that team.  I have been missing messages 
between reviewers.

At this point, I know that at least one of the patches in the PCC 
portion of this series needs to be rebased upon work by Sudeep Holla and 
Huisong Li.  I am reluctant to resubmit them right now for feat of 
generating unnecessary churn.  There code also obviates another patch in 
this series, which shows that we are addressing similar issues.



