Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFFF48A8B6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863795; cv=fail; b=GFLwzznOkDTZ8YsJvtjVOiiBFXvlfmvJ40F3td0KJuedLHSZzhQmbNGAi0VW2yOlqNHnY3jDGOcEwX/H+Z36PVYRnlJiuEcKuq9RJkXb6k4KaFlh+BHuXu29ejbmdNd56PfNjeIQQYmuntLljc2nUgkqY0njtLlkLhCK4X1ZU78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863795; c=relaxed/simple;
	bh=rkxI8DV1GmCwVuxCz0UMaTriOjAJMt2PqZCRMWD1XLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmXyBwTQ3mGKt0CH7GVO/Bn+vGuwPkWqnhS3matw8IuFJvGUhmVMjuKWeqKi8zSU6we+tEILa6L6YYbrEkYU7DEUuPYwc+lpLSSlotnMkVA/lpIm3FeOPdlPBOCjYUVa7SoPivgy5d0xX9Uo1GAGbwrd++mAFWTIYAQindby2bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c87zgwXf; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c87zgwXf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z38wtqNGkbu6LbD7vEeAaco38qwDEk9DONFWHSu3afaiBTd7i97eu9HPPNF1P8x9UdpsnwxOql+YM9sz4FpUZIbISGdcXyzl2a04Lg4gjnnHovUNFW2dJ0F4dDwP5DXOLH/9GhuJ/zlOmcjzr1AGbWsDw6vZr/+1WQIx/kGu1LPWde3HwAO+ybSNPjMVZAKXLf8Ht/DqtCKYuDHRFJm5WAetTYY8VkWutCarQrw6n9hTWrgdyobGtsqWYlPKgtBOSZpXGvTFqyCXfpBZyx1ro8XQDZBQS8IFdIwFLApYerSxxFmeN2IrxBaRwZnwoaMf57Una+ylnRWjnb3pzhclFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtgLPFZHvbCJy04Z9f/N0Je/1kJC4sWDM5ENonNKYvI=;
 b=udWw377Y3eioFdCh0CVLrORHHWA0lE1RgenECfYVwxJYBk/Ithj20/o8uxVV0uD4gl4fPoJkGD89ikMEugJXPB2EyUN/S/R6U0neKbAvL8MGbXw5mW09vXLZMlaCvybKDizlavbFnbDBKIxSUtySLFdr1xFccoz4/VSPF415cnKkvnRytFTIpp2IQWqWb0OPaaL7AgGVEWpl3foH2pf+cUeouJCXHIzHXwQ4qgE3zQFlkjWnlf0mYkLqAuP6barwjclQ84KuD10fyXe+xCufvUSH8eCqzt6tp3t/dRT7CHYnzs1cV8PdytJQz9C214V5IH8iKyGJBFoFGk8vnyRK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtgLPFZHvbCJy04Z9f/N0Je/1kJC4sWDM5ENonNKYvI=;
 b=c87zgwXfTsdD32TZhT3C2C10IlOKQVJfQBqCzasl6Kl9Vf9pK4+w+Y7rJQYH1rYrsRKXq1jPhXU7GKQik3EFae4Ah9acyJhsDNPDPdCigsNDnKT2GqAlQJ/ENvD+ioA+FT7RJzCgHZX2C7xRBzfwkOCzeZjc5uH2G+GNfdtIQokmsAW8IVgc6RIOVnoskvxS6CHIZpLbyMOCTSJjHR2R98/PQYQ5R3yfDCJGuHeNyXHp1ygis3OB3lpkI29LqW72bCdhR1cwDm8gUdI6iPJHrOCUEJhaJWbux8saeEfGzB9Rh4abe+W8EZHVwlahocLq1wpKnLcXjSN2mjGiEaVMxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 17:16:22 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 17:16:22 +0000
Message-ID: <37c7d934-b356-4920-a332-9416b1f7fce8@nvidia.com>
Date: Tue, 4 Aug 2026 19:16:19 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
To: Jakub Kicinski <kuba@kernel.org>, Nimrod Oren <noren@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260804094518.53b56d24@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260804094518.53b56d24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: f03cbbda-9f93-4c2d-b632-08def24c1b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|3023799007|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SumnFMql06p86QxUVt/czu/lvyuGA1i54rWtY6CoU9U1CnjJdNiQxR4BqM1RQMguD6+WJPUZnJ71TD7e27K3ZroVy8ZdGaCooHR+vZBGDhIN99cosvcr2AyK/Wvav+0gifaw8S3pJ37DTWhjh4sDTe9EJ7MG+S4i0Eh3gYWSvY7N1ZIiACvCiwNYwjddQXSO7xPgNNiAes9MCmNq28357eRdt/7cloVIgHm9ccJbPu6x91fK3ZLUtoeemzUTNCxU+8q+12zq714BAxMngHmMajbn5BxobbikYdUjBh4mLCjyb+H70FyGf4DscY6A+GpKGNXtytctJqlgaB4fxxp3Wv+SP1jB+iBdgoh6hn465OTAi1jP6wLuFJpWJflnPhcZJ/ZjMYql/Q/ohZUV5OkeVFiR8xgkmSEFNgOfXuM9NiwcGq8uITFVuMj0esKG2ecwQ9WW3SU4RtQ6sqsMJ4CpvL7E7v90lSlVnfl6iTPEFTYa253jXVS4jPqulYvt/XA0pEY9OvYcZOP8TNM36M3Od7fMvYlajdYgXIuxcN6nbmtJ6mvgYB88bwpA6swXzzrCSF/cBM9V0hKgrkQEM/IQBB6LMrBLqbaeeWn/u/cm+aWwTAJET2P8plc3j7ilt/08T5wB2JDhfuhKHeW8vccsDD+V6g8UATJvZzRvWz884Is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWpHMituY0xFRE96ZEkybU12N0JVVnVqRlhyS2cwNTJ0RHh3cGJFSitiOW53?=
 =?utf-8?B?bEU3bUQ1L2F0dEFObDk0eHN0UlF0cUJhWDBqdWtOWEFGWWxoQTVCdm9IUVpG?=
 =?utf-8?B?U045Kzh2ZnloT3B5V3ByMFFZUkpVNVU0YnZ1VFFrZzJVMWtqbWpvSjNZQ0VG?=
 =?utf-8?B?WldDdktIQmVLYVJraHloWjJlcktjL1lpVm9FWldrVXFURUJDUDIrMmM3MnZU?=
 =?utf-8?B?U2wxWktUcWw1cVRCMzNFaVZ6ejJ1M2pxa0NmSlVzQ0tJdGM3RFoyVnR0T1Q0?=
 =?utf-8?B?V0x5aEVOWWxqVDIzT1RaY1NtbVpJY3NOUlc0TjVkdFdEOTRUd0Q5czBFMlFi?=
 =?utf-8?B?cFcxeG5uMFdWOVhlQzhrM284eTdSTGNjK1BlekZ5YTRDeWRYSWp1QUxtczcw?=
 =?utf-8?B?Tktnem40bmhmQVFpZ2FBUy90V0pKbmJVK0lSZFE0TVpaYWFwSFQyb2hjNXpZ?=
 =?utf-8?B?Nk85NVJYQ3BuYVgxdVdZQlJRcnFUMjhicmFpQzJtbVM4TUNLTkpjY2RhMm5Q?=
 =?utf-8?B?K1Fia3l0Ti9zWmVOWlVOa3NPblBxbWh5RlBjTGFXNDN2Q0R0NWhBVjFXbFBo?=
 =?utf-8?B?L3BOOEJuR2tUSXdCQ0pCa25zVVhTVmhjdytoR3NrcTN0UWdaZ1RVUm92aW45?=
 =?utf-8?B?a0dzS3NiTEUya2lNMktnb1ZPbW1zMkY1NEx4bnJFU1c2aFNySjRrZzdGTjJW?=
 =?utf-8?B?cy9XemhmYlllaHJzdzdWUTNybnhPZjVlTllWY0FaaDBqVUdJWitEeU51cGhq?=
 =?utf-8?B?aVZrTFNCbFVveUhGajYrZGdzTXg1b3NRWjB3SWFXcGlGbFEwSzJUcHptYlY4?=
 =?utf-8?B?NnVGc0lHc1JiNURhZ3FXMExYeEZkNmhtcnBFVDlIdkZJQm5sNm9iZWZ3OEJM?=
 =?utf-8?B?eXdsV1FpbkNTem5ucDBFT1FFcXhqU0tGa1RWb1ZqbkxvUld5YVJZa1h1N1ZG?=
 =?utf-8?B?aXo0UytvUWptV3B0NUMvOG5wcURKV21INkJZdWIwelRlTTZiQzd0bk1Uc01M?=
 =?utf-8?B?K0VWZWMxR0RnU2pCRDVOSW9JOU01Y3J6QURKK3RIcS90UHgxNytoLzhMTWQv?=
 =?utf-8?B?SzhCaU1IRVYzbmRXejBNVUgzZWhTVlRDcjl3Q3RqY2JUNGE3OUEwS2V4NEJQ?=
 =?utf-8?B?SE9ZUjdDQnRXTU9xNUtPTnJoUlJYRURiM2J3a3c0cnVkd243MWo5NE9iLzB4?=
 =?utf-8?B?V3JXT3RTSzFldWZVRXdQRG8rYWhBRG5hZmx2MzdaOGlpSmM0bGdyT0RMbTFj?=
 =?utf-8?B?bm85VGNXRnpEUHRBUXd3U0FYZVVEQjlzQXBjSmpmQkNDUHJJTDF6b251TnRq?=
 =?utf-8?B?VVduUW1kZk84R0ZaeThqYTBFZmkyYUs5bFVkdVN3WS93elRxd0U4ZGxNbGUv?=
 =?utf-8?B?b3N4ZFdVRGs5RnFSZW1JS05WYlNKTElmRTZtZFpDUGwzTE1qdTN0bHBxMDVi?=
 =?utf-8?B?cGM3UzdFV2lydGlod0NVVWpUMmRkcEYzcUF2UWJCVTRUTnN6SlZRbm1PMlI0?=
 =?utf-8?B?dVR0bDVTZi9OQjZTV2RpZE9ET20yOG1DM096cmJhaTkwMVRFK1NHRGRPWk8w?=
 =?utf-8?B?V0VCbDNyOGgrSU5nakdINlpJWFpKMitZOVVxLzJBKzNYVTRBdWZKKytHSmhk?=
 =?utf-8?B?WGk2K05HcmdoaEQ1NFkraUJDcTFPd2gwbldQUUhBaEdIN0lZK2dwM2dLRHdx?=
 =?utf-8?B?dGdRNnRqUWw3aStOVFRqSkZHdXRqTlB6YVFTMFlwUS9vdFJ5WDhYbHFBaVFm?=
 =?utf-8?B?Tmdyb1R4U3VOU1dkUlZPSmJvL0UrQ2JPNWxGenRCNytUS1IrbmJENnBJRjUr?=
 =?utf-8?B?QUZiM2hCZWNxMWEvV0pwMHVydE9xV29ySjU3aHptVVduclB2cStQSXNFaEhM?=
 =?utf-8?B?L3N4WHViaHF5UnB0NFVYRXBPQVVQajI0TTBLaXkyU3NPNEpZNHZ2K2V0N1gr?=
 =?utf-8?B?S2drT2JUQUpUWS9odWw3WFhRbDdyNkM3OTlOQWVTTHdoQ0FzNHpydkJnbUVp?=
 =?utf-8?B?cldTTktlV0c1cmNid09ZVXk4dks1MHZCYlJjVjNmZFBVc3YwZXE0Ym5tVzZR?=
 =?utf-8?B?MERDME91UWZIWERBQlZ0azJvMWpCaFluZ1c5TFVzZmdjdExIR1diWnVjMWR1?=
 =?utf-8?B?ZEVKL1hzdkFWcGpDSzZUSFJJeW1OY28yL0MvekJuWHpBNEN5RjdlMmNhNStz?=
 =?utf-8?B?bDVmQVR3eXJtRTBzSjRlenNlM0ZoNFFLdXhBcjJZaU5sdld4dFhNMnhlZk5a?=
 =?utf-8?B?ajJaczJYS3pKc2JIU3Y5aFBSanp0bXBRTG05Mk1LazV1OEtTSkFDN2VMbU91?=
 =?utf-8?B?S1BrUiszbFhvRlZKWGYyR3RwQ0xYdEVIaTZydHo0dGRYTUlCWEJIQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03cbbda-9f93-4c2d-b632-08def24c1b49
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 17:16:22.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEIh/YTCDlamQ6Llv+7/SELSjFMOI5+jPM/lQKQXbDP7zK/P080OCAVrHg7SbjLri8d3yf+tuYGp5bj84OFhWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116



On 04.08.26 18:45, Jakub Kicinski wrote:
> Hi!
> 
> The CX7 testing in NIPA is looking pretty good, one major source of
> noise, tho, is that the pp-alloc test sometimes locks rtnl for
> a minute.
> 
> Here's a failure in that test itself:
> 
> # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G', 'ens25f1np1', 'rx', '2048']' timed out after 20 seconds
> # # Exception| 
> # not ok 1 pp_alloc_fail.test_pp_alloc
> 
> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py/stdout
> 
> Then the next test that runs also times out during setup:
> 
> # subprocess.TimeoutExpired: Command '['ip', '--json', '-d', 'link', 'show', 'dev', 'ens25f1np1']' timed out after 20 seconds
> not ok 1 selftests: drivers/net/hw: rss_api.py # exit=1
> 
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/37-rss-api-py/stdout
> 
> pp_alloc test can fail, but spilling into the next test is a problem.
> 
> At the retry things clear up enough to return to happiness, tho:
> 
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/37-rss-api-py-retry/stdout
> 
> I haven't try to dig into where it is blocked but does this ring any
> bells?
Not to me. We can try an internal reproduction.

Randomly clicking around the flakes page, I found another instance of
pp_alloc_fail.py running and getting crashes in mlx5 during page
deallocation:
https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/762402/sol-machine-2

Is this also something new?

Thanks,
Dragos



