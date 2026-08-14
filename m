Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4A3D5C1E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738909; cv=fail; b=fcBf5YlTxrj58fIdt7pB3gwgLMNCp0YRE6Ebv9XR+B9lrKubge8Dql+kUEhsBXZhTaikjscW6r1G2drPp706IuNG0C+Zpa4qHS6H5Cy5q4TVSh9SIAD4RZAyFHCcd5AbKnBOPQkvUTVwnziKPYFMlA4TEu7E6vU3toCpXQTMba0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738909; c=relaxed/simple;
	bh=lbRMpq2IKJztLCcr1/4P+a261uapP+XQmWYInUKkGro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6JczYUm7uRpiDWNudPKsqz40k6b02IHVMIsfdnDuRLc4JpEgBaS3qyCNzCNCkXVZ18r0BGh3664sJj5CQEnwMvWkb7LUSoornIGmwThvcEA0jMfFpi+fn8miJOPupWBz1Y7KlQAnU0WPHb+x/u3WTgIs4afgr62g3C3BXyHUKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PlSmhbJn; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PlSmhbJn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3QtY9V/vlHsTuoDNGUZHtxzXA5zPfvTuUlxZG8HRHVQ0Uxd1SuiTRUBKjsjF03WClszhHzUJ8jFeROcM+dsp5LZk6CtnqKF9FcRH2dNe3zkLoK9l6T8TNoARVFcaFOaJhuWyNXzu+xQwIfXDa8yMAM7PDEBh/csqhtLU8Sv1sSvwipxKREJluSWyFA9mXJAnDtZ5eS5bynkOPSRu658rbkN8GmvElrsG02ey/r23F9L32bwpXBEERVfTxUxYgjttCP0Fi561F4GVhUqfytjrFsnjwSUEJ+VztOsFBo4f1QFUDR2uUqqGOS1tp3eJF6eCqUFlHv75ay/7FSTOrHa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5iFRQ9bA0SqoRzHAd1K9XgGQTXS4s7JCmFCjJP0NAw=;
 b=cMrIsz2SUI37HyHBAUnZu34x9ew5s7xNIsbegdSBsR20k10mzUzSFnwttol9DVBSQmg/fXvXvTLdhIe3RDj8v4vDDq2qGyuMHZnh9ZDCyd2O72JU+gGgqAun9WpReeO+RC6qO3YNA9uK6MjYEWxoos/AQmCwMZXbfnzj9oqTwpHA/d5j5hvdQVi3sOAM/Ab44n4bNlUzuuLAhc93sWNX7KSthu54RIqUD/G3OJ0+WgPkfKfQoay2+0QtuSkS/BibpfehPecj9ZVrgsISBUfK7XI9W1r9f5+rMVUDVJ9uf8mhkmVUx290ijgIMyNJW4DWv7M24WbWwB0zTnshY+l7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5iFRQ9bA0SqoRzHAd1K9XgGQTXS4s7JCmFCjJP0NAw=;
 b=PlSmhbJnceOsxn3kgnaZF/OtKUth0rXSzx8ZFlHemqbVhqt/66Jm60b0iPFDHROnt+4rqYXoveOuSrv6ty9Pn9K/S1fiT+J8gey/PUg6H5ftjLNlb0XwMoL0TdZcBI6Bw3cfVAythGty921IPpWrLKG5cAHsOqBcglYSf7g1X6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 20:21:44 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 20:21:44 +0000
Message-ID: <1ea0dd7d-2a61-4029-8e03-4751d53126bb@amd.com>
Date: Fri, 14 Aug 2026 13:21:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ionic: Add .get_fec_stats ethtool handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>
References: <20260731214021.15279-1-eric.joyner@amd.com>
 <20260814120520.11e24409@kernel.org>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <20260814120520.11e24409@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd82cd0-fa1c-411f-7f3a-08defa41a878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sMFMywjnCiJ234NbiisayBiPdV9MPrj8pxEn+C0hPqClzPohw/WOnrDPmtyMut1yLXVXfo1gq+jRGxxO9S1ykCtaY7IANSUPNCVNEK8mexGhbSjEB2kzJnFSdY5f+6DckJg6E27iIBYubNcaIjhdUPBzRbDqfooHGdUM/Uk+WL4xs9E2YySt5NLh1L2QFxlaqJX24ZSy3aTAq0XuihgGMzlj8AY53IwP46ppxZVyjJGhgJfeLED+UHfY8RZJVsScjXp5kG0v2kMbZSC0n/2n99FxL0BUUa8GS0stRcPiTzBS3+qfI24DwmKbJPIySZ+0Gxxhlpzhnn/DPEapTm+tzyCdzn+2cKqkDA4U3vxc3FqnXx+dlnbS2L+QEpu7ZxVs8tp85Uo3wCIDGJUooftClSrGLL/Reor+A8ChkqkNgpED00paKIOAoGH1aCtgN9vcaDALt4hUNhZbDEpoATmpcdbuQcBu/kgZvV83Lk0GjPDmP5WsAEs8UE1jVS0++Qq4bCkFzUHtkemmD/2DPxyTx+dgh7NjJxTED2GpxUNUkJ/pMrXb0jHFGCYSxEl7EyKWUxC5KNReswuSEsJtuYg5GrCB4nvECl1FXCEYd/gAg2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0N0V2VOSDF3b0ZZZklpcXZPaG9RR1dGMFFjRU8zSVQwY0VUZVd0SnJGWVVN?=
 =?utf-8?B?VmRnWlcrZ2t5QVNCZGxOQXlQSjdlL2swL1lraVJTVFVlUUM0Q1E5Uk5FSHhk?=
 =?utf-8?B?ZFhqRmd5Y1I1VEtXbFQySlZNb1R4VHhRaFBLNTZFMGRDRjdnb3gzdTVYYStZ?=
 =?utf-8?B?cDN5aXJWaGl4RU9MY0dRdXNBdnB2VWdVeG1wUFh4cjdUVW0xMHFOOW9yY2ls?=
 =?utf-8?B?L2w5dWY1d0E4dU10NVFSWUpDQ0htM1B4cVBQa3crVXNQc0N2b0RoYnJZRlFU?=
 =?utf-8?B?OUpXMVk1N2NSaHhQWlJJUlFhNjlyYnFZR1dzMlFUZk1ydm9KV3BKRGZxOUNt?=
 =?utf-8?B?R3FpenBoSWN5VmtQeWYvOGt6Z0U3dXBMMldnRXBiaVdTeTd1V3pUSlN1U001?=
 =?utf-8?B?QnRTMnZBZ1FWdjNzbkFKK1ZYeHZtQlhnYVJkU20wUU1kRCtGSVZWVjQrRFhY?=
 =?utf-8?B?ayt2ZFlIVG9vaktHcFgwUXlRd1ViMy9XRTBId3p2R1VMcWlJVm1HTUkzeTZq?=
 =?utf-8?B?bkpQLzdmeldHUk5rNWh2MERDalJlWkh1NW95NzlCKzIxamhqODZtUi9kS1l6?=
 =?utf-8?B?TjhERUpDbjRvMi9ZRUVBdS9ZbWhzQjB4Njlka053aFJjNHJ4M1l5a281aUlC?=
 =?utf-8?B?cjZid0h3eDRSbnNQcUZuc1RmMk1nTGZ6V1lVd3VvTm8zZ1BKeW5YeDh5YlF3?=
 =?utf-8?B?eXhNZnJKSlhHeHVkQ0xjZWdVaTErZmtDSWZRMnNzaTU1QW1zZFI4bWRodmty?=
 =?utf-8?B?NG8ybm8wL0RndlFKaWYwU05SZkZJYU5OMVJnQzBWclZKT2QzYVhmbnZaTE9Y?=
 =?utf-8?B?aVY5Q0E3bDRXdFJaa3VGQ0FZd1JTZGMxNE1MdS9mOExYU2NZWDVRK3V3dUJV?=
 =?utf-8?B?VkVobEZyRVIxYTJWOEpyOVorNDZ4UXMwZm1xZDFabllCanpSTDdVVjVBVzND?=
 =?utf-8?B?Y1U2ekRZVGhydEpWK1NmWjQ5YW4vbFpXS2p2YXBzeWNYdm9lWWcyRGh0SnhF?=
 =?utf-8?B?UWZuWXQ0UjZMeUxrUWVXMm1leE5uQktqYk92V2RuYmFrajhUSWV0T3AzQjlY?=
 =?utf-8?B?OW9ubERyejdCdVQ4S0xBejVlY0dpcFZsdDQrMHZ0VGVrSXVzR0t1S1o5VHNY?=
 =?utf-8?B?ODJ1QWs5Z0YydkVLWEQvT2xjM2xQcVczV1NHNytWMmlPemdiZHV5RktnY1hy?=
 =?utf-8?B?QUlkVTA5WkthK3VTZkY0TmtNcEdWdnk3eUJrdFFSMHhoZTVjOFgzbTVPSFUr?=
 =?utf-8?B?M0duWEJRNUMyMGZ2TVFIazhvVmVDd3krVHpwcldUWWRHd3Rra2tLS3BZVDA1?=
 =?utf-8?B?ZzFzT2pJT1hpNGVxVHl4NU5kOFdVaEY2Mm8zMkR0Vit5SjdpSi94eTVGVVN5?=
 =?utf-8?B?OFJ6QVU2T0FsMGZ6QVAyUnNTU256K1FiMC94Rlk3NWo3Wkp5UzVRUE0yZGxq?=
 =?utf-8?B?RVZyOHkrTm9ZOFc4OXlCMy9PZjJxS1dILzYvMjRnTFplaUVXa2doZmdxSEg1?=
 =?utf-8?B?bDJVTDB3Ui9sekpOTXZUWlliYmltWk9nZmhaRmlhODJDL2lPQ08wVE5wWGEy?=
 =?utf-8?B?UkJGK290L1VEYS9NY0wwREpicW5tc1N0alo2alhQZEtKZS9EeEw4Qmx2ZGRh?=
 =?utf-8?B?aUg4M0RyWTYyWXBFbUs2cEUyVXUwRlhVMnY2ZFM1MjZ4dHVVYlY4VmxvcHQ1?=
 =?utf-8?B?aCt5L1d2TCtYNG53Tm9UYWZOekRFT0x0NDJoaW8yS1Frc0V5cmpwclB6cVJl?=
 =?utf-8?B?TE11dGRhTytrSGtwaG9qeTNQMnlFdTM5cEtaVlFrVEQ1T0hndE9GdThjMXFF?=
 =?utf-8?B?Nm1zN0xQNjRiNTlIUnVaeWswbEpJaFl6bm51cDNVMVF2L2U2Wm53YzhrYXRE?=
 =?utf-8?B?Z1VNNmNSY0Y1OUVmZkREQ2drY3VxN0ZzUTRFWktHTUJXdzdmbTBpdjk0OTdz?=
 =?utf-8?B?N2pVeDBhVmRwZTg0Q2RGdUQyRUpJSzY2WGpzcExYaWQ0MnZzdDgvVGQwajBQ?=
 =?utf-8?B?YjRINWh3dEVwWmRMQTRaRFlQY21lNThBeksvWXdaTUswRmxqSFZmeGpSMGMw?=
 =?utf-8?B?Sm16d0d5TnEya0tsRi9oTm1kWThJNmEySG1nemY4eCtZWHRLVWprbm1CR1ZT?=
 =?utf-8?B?d29wa2NKNGFONmpmRnNMQ0hiWWJxQ1FOU1lNQS9wdU5IYnIvM241c2hlOUtC?=
 =?utf-8?B?Q3B2SzRoQ051ZDloK01xejlIZW0vOGR4dlZhV0l1U3VweTVTN2ptUkRzUGxi?=
 =?utf-8?B?ZW96UkVVeFJzOUlzWEovM3ZxMVE3WnhOaUIyeGhnNHdOTXJMVUFRcjJwelZZ?=
 =?utf-8?B?K0ZvUHdTZzUwZU9EenJQNU5Fcnkzd2hqK1ZGZ2VITmtiNWJBMkZlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd82cd0-fa1c-411f-7f3a-08defa41a878
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:21:44.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9bgUJiNZ86ANsKLvzuJVu4HJLaJl9+pLZlkB2OHvFf6NzDOoq755rUaqYYMA6v7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542

On 8/14/2026 12:05 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Fri, 31 Jul 2026 14:40:21 -0700 Eric Joyner wrote:
>> Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane counts
>> currently aren't supported, and the only expected histogram format from
>> firmware is the one with 16 bins from RS(544,514) FEC.
> 
> To be clear this patch is now too old for us to process, you need to
> repost. Before you do - double check the 'shiko, it has things to say:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731214021.15279-1-eric.joyner@amd.com

Ok, I'll address the Sashiko review comments and resubmit.

But a couple questions: the Sashiko instance at this site looks like it's doing
more review than what the Sashiko bot at sashiko.dev does; should I be checking
this site for Sashiko reviews instead? As well, I don't think the upstream
Sashiko repository has support for cross-reviewing; is this site running on a
custom version or some early unreleased code?

- Eric
