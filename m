Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793374628;
	b=bRlXQ9W6j1ZFGOV3uYJhWSbyhvC86agkO6fvYiQRcwgHdA72taHKSzHu+sCMCMs3CwVA
	 uFTrnYNpxMK2+Bp6VngNh2LQLzxiddZbRdVeM6W3ywbhDW0o+qb/ZPW+qH9bnJ5L12Rg9
	 Sf3GsWgB4KU2S8EbkmE129d2bk22xk+lnfS/6njAdOpqlnZNH0VsV+GOxt8s4JU9m91pm
	 8Mur2qgFbn/v9Qh5ifOVIBhPmRZsGZ9C23jt69gJlTP3QR9g50wF7l4PpMuozOtyW0Ask
	 kc/a/VJtRuOME6p+tPRb6nOpB93SaEifHi4GsvCL7DjkfdOTW7tjBbGY2JoAOTKs1gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374628;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:From:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=z1tw2Omdd5lo5gzZyBmGSQsZOHghzy5eVXJXO6+LE3Q=;
	b=LcPZ6EOXe7rtdtcajW0iG2tzuKKy5poAPwkF3jhKWRRBbmHNvoppBpCZyzheQa1N/5Oy
	 6bCaP4NqjhLtsyRStwVjxoxhnMwSUANS9Ih0y7m6NqVNQoHDSuAqRakPmCFj47TgKWpRo
	 hrKxgTO1E63Q4RYm7si2C3qnUKdReLOkqe87JZ1plKW2aWo30swOojoZAexI8h2O4jmrZ
	 1w1DtisDH8AssryASaVq5xfcizBAU2OHSSYryoPQm//uJq6bhqclNsaXwI3/4vvE3iSrf
	 GYmo+Gz7lXUdo/8wPObALZQFbMeb/tkD20YijHt685LGjplwgAazadIVwIfeLIEoZDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C+xdWPk0;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82171606A31A;
	Fri, 30 Oct 2026 15:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82171606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C+xdWPk0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793374627; x=1824910627;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e9sq/ZSS85x3dMhmwmfI9eIHeoZ0IWMSNfVp8KDLN04=;
  b=C+xdWPk0VR75a25Bgt9bpkgv1upPSjHjC6dAXHtN/nUHWERGk4Vl7EM8
   qnfYAS2ezaLDEo85qmteT7J60gNHAus33hw1KnyY9NnkNko3qlIiMX1lM
   8gwV2fYMoNYEP9ZucyDvxMCMV75gqFS7pSFqf6ooQ6pJaRv2x081a0U6H
   SBrJGpf2ZXsEN68rewOkGSCo/L5Scia3sgAzY60RNAEqEoUUSHpPKl5Ej
   7IyBVLoHXWPZbhcjHPD9AprLQ9Rn4OP1W0ERII78Z4uAruWieaHEHkWDz
   P3AWMT6OrbliPdTHt3v5svgOx27TdfWSMJkklfjFdxJEkPR1hemHzF7Z5
   Q==;
X-CSE-ConnectionGUID: w+9lk00zR8GDUCd0RK60PQ==
X-CSE-MsgGUID: QtCG4qQERmCmJn0UFTlVqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2024044"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2024044"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:37:07 -0700
X-CSE-ConnectionGUID: IDkBTcy/Si+KiaCkJPbm8g==
X-CSE-MsgGUID: MgpnvTWNQqCkbOQPYzFAGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5356360"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:37:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 08:37:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 08:37:06 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 08:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7g6bQt/fWbiP8xWA2PCjoOH4uKcN1P+eSVSVVxE6Nrv4xnw5MuB+bXmNdC9vSOvW7ZE3XUM7dSj6TQzZ0HqTzxRWLZv1IkLB6PcCiEoHH5Aaux6Yi4R+fUNzQgnQTMYXqLMVwzTS0syw49fsfE8JSGXpwIOyz2ZQ6Dm7+7WMSUyqAZZvrV+HkUxZxFCS/GlpbnsE5C7Gjz0CDkm0S+Cx71oTqIxXVCBWZZ4R4zrEWtO5SQl2QuV7Mlqh7fuW2/1d47g5/ZWwY4OaZf9wS0YjtDxeF1xFlAraya1Hot9vfadci/TcGOTHEad8GAxfUeK2l4Z8TvJK0J8tATgdQ6ZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1tw2Omdd5lo5gzZyBmGSQsZOHghzy5eVXJXO6+LE3Q=;
 b=AKSdV63jAPINsXGW+vpq05i7RCJtUNjH3sVOnhWLDTYTzj47ujee+I3HaLIxfRFZFKJXDox+UKfLVijZ12plbza85wUxxiNoUn0ysjPddANGDmnx8Bx/8zaCDF7GBPI2wuNDTya13Zrck4qj0P+3YmUF8D8TNp9ja3ud5SnykcoLTJKl6o5bOWPQ4XJkJ4Gm4LUNeNzZFOfdZZmJ/HWjYeBlpMoEHd3hA+yKGta538rTt1LqTntDN1VN003Sy5ZrQbxJEm3PtxJsky7e1hwS9A15HF+7QpLN7TYQVtPzgqu63UvIaYBe/AF/8Fn4DnjRL6Oq26DZbwGriJlHYOw6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by FT1PR11MB129532.namprd11.prod.outlook.com (2603:10b6:170:3b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:36:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:36:57 +0000
Message-ID: <546ce7e1-32fa-4d7e-a7d4-d6f0d5826afc@intel.com>
Date: Fri, 30 Oct 2026 16:36:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: free the skb on TX DMA mapping errors
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Mina Almasry <almasrymina@google.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Naman Gulati <namangulati@google.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261024030401.852598-1-almasrymina@google.com>
 <03c17d6b-452a-463d-8b33-2a2aa1819ef4@intel.com>
Content-Language: en-US
In-Reply-To: <03c17d6b-452a-463d-8b33-2a2aa1819ef4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|FT1PR11MB129532:EE_
X-MS-Office365-Filtering-Correlation-Id: 583bec6f-dbac-43a5-8e7a-08df369ba18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|4143699003|261026121527099003|261028144727099003|261026140227099003|10067099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 79UCen+zBXgt6ol/biQV992VjKbArwXs39dYeDAGUcUTJgT2PjCy1ut6fKibycgwW/+NPVSehJ1zFls5A7bawjt06YSb8d9syjpwF/skfoLoSgW2HJGTzP82gTFzciEIS4RWbs4z/LXw489wGcktBof2/Ty8l5g9f4YK5Ymw2bICf+azk09xRVEsHhCCuZdfQ/E4KWGZ4H6GSvkSnPaA+TMXgqA5/zbN/eXmx2xZakHBIfVRi8nlO0hj0PWUWVrh2d9aMQVxcCjNiMxatqsMiXG+LLnVUQIKdESznHyX9XrsRTAzxn4VWBj2r28zQ+oOSZaQ9LaqOWd0foAfogxAjRM1gxJ7MovrUXib+Fu926NylOab2SijqVweY4ptN+RJ186qJpmlsTkAzzOc1umrplOtwDH0BffVIT2ZTI8gJPk1Svz+NoCDcZsiubqAf+tUtOfaziVJPJHk9XuHSYuOAhkTvRJsLeZ6fabVvB09Vwruo7EojkDnpcCptwRfJaqnG5WGDY16vuMjxyrTjQd4VklNc3ifTcoZcFCjkWSiid2phMWgS+UW1HXlfWQWsvUnIuohFq/xcYHwYBhKtxZlbj1yf0j/mt1ivpYLGApqm3qCMi9eA2ciV/ksFe5UifVNp4eGLUaw9E2Z3QiyyyDRovCdod7BDCoR+VJ8tY+h20o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXl1ZzVQTzJseERsQ1Y3SFh2OHVpbUpnTE1Md1N1d3AwYzB5eE1uNStqREhz?=
 =?utf-8?B?aS8wTHQvVHNmcHJPWHF1dFJiallpUDlzSTV4QTRndWJvNWhPMDdNRm9WUFhn?=
 =?utf-8?B?d2pmVzJ5RTRYMlIzSmJvUS9ORGpUVURBSFF5dm43NWhMYjRaN3pwQldlWWhp?=
 =?utf-8?B?ck9NQWQ2WDhjUzlYUUtmYUlpMllMVHU5Ti9WcHNXMXRMY0tuMG81dnRGbzFG?=
 =?utf-8?B?MDBsR1lRRjIrendFTFN4YmVudVNTd1FpNkFrYTNPaEt3R0VzS3hVQzErbkRR?=
 =?utf-8?B?aDBnTXdoc3hBdm5OMGNaRDcySitTemJ4UlV3YUZCTldvcHpOYUtuNUNmQmRU?=
 =?utf-8?B?d3RrZmw5RytYcFowK3Nla0NNb1lWK0Y5Y2Y2SjNodXJBcENDd25zSFBsOTU0?=
 =?utf-8?B?ckdGMEtnUnJOOTFVOGtaOS90M0pRUW0rVDFDQitIK2hKTEExN1U3SS9NdVFv?=
 =?utf-8?B?RExndk1rTzBjSk5NYUdIV1NtOWszdlhDUTBwR2JlVmJDN1p2OHVzdXhHZ1hv?=
 =?utf-8?B?RWQxUWtJKzdCRHo1eFBhMndOUXUwb1ZvWS9zbjFOMkFqVUlzYkhzQzgybkMz?=
 =?utf-8?B?OGhKaEd3L050eUpDQlhXUHJzYlZaOUZBTGFkOHNscDRJYjI1WUpDZW9MS08v?=
 =?utf-8?B?K2VHbUhuaXRybzMzRzFhVElyK0hZTW9iV0M2bTdrdG82d25zdUFXZ1Bwb2V6?=
 =?utf-8?B?VHZyWS9WVStGL0Q1QjFVaEQxYXBkYUxWc0ZxQUZlUmlISHNjZlZ4L0FBYjBO?=
 =?utf-8?B?NGhKNGdvTDJSQkpwYkxSQ3UxUkY0L3djRkpVSzBEWjF4NnlCb0JHS00zY1By?=
 =?utf-8?B?R2ZuRjZNeEllTTFSSnA0UEs5VDB0T1lJZzFuUFVTOEh6VmMreGpDTHgzdTMr?=
 =?utf-8?B?YVJNaDdiV3RXVkc2TVhuZHRXVDFUSjFxdGFjTjNWZVpSSjhQa2cxSVNnejI0?=
 =?utf-8?B?bGQ3aWc3ZlE2RnN5L1dwVzVPbXRtRnZsU2JCOHcwZkJ3K2h4NWEzYjNnM3J0?=
 =?utf-8?B?MW5tMlJlcEtCTTFKZCt5Ymk5SEFaSkxNZzZrYjBNN2txRTE2SHcvSFUxVXFk?=
 =?utf-8?B?a0ZCaHlFNGdCeVVJV2FBLzJ2SDNVQVZ4ZlZGSUlETGhuVmxnd3FESGxubmd0?=
 =?utf-8?B?Zit1aENGKzVhUDByYU9ENTU3M0o2WW9obHNWVDdXZ0xKTXc5TkYyWTI4QTNr?=
 =?utf-8?B?N2pTY3J6czFZU2RCSlowbWx1QVJXSER6M1lNL2VDMmlyQXowK0hFRmJNL0RX?=
 =?utf-8?B?cDRzc3RKNHZHTU1DVWVZK0ErZHlFVjRpVTFQRzdiT0tJY0NMcXNvRmpHWVVC?=
 =?utf-8?B?Q0J0TXBva0V5V3R5STNCb3Zzdjh6R0o1eUNMQnFXYnUyZWtBMEs2U2xJMC9K?=
 =?utf-8?B?eTJlZjVpT1RIa1lEL1RCMGQ1T2JhTXk2V01lMWpoRURvMjB5Z3piTUM4cEtZ?=
 =?utf-8?B?RHgvQms2RitNUExvRHg3b0xWK0hCanpQaGErY2NpVlZucm5PVE9qRWo4YWI0?=
 =?utf-8?B?Y08ydmpqN25oUjlwbVJ1SHpXdzVFbVNwL09SNWVtaVNldG1Dd0hSNndpWlp1?=
 =?utf-8?B?RDR0cXRySUFxY29MdlFxNUZ3d2tqSGNreGFmUkVUVGVzWm92cG85VDBqandS?=
 =?utf-8?B?dk9WQkdVeXhRcW1iSzg4V3BSaGtPdng2S2hLMWM1d0dmSW1rcTd5N3VCZ0dq?=
 =?utf-8?B?bjZuU0lyYkM5SFBHRDh1SEhYbllGcis5bDhJUmVKTUxOOWhwaUhKSXZQcWlt?=
 =?utf-8?B?UjE2Nncwd3RsLy9SUEtyQ0EydHQzbHBtWXVlWDRJeTUxRVRwelZTNEFodGJY?=
 =?utf-8?B?bXhMN0tQRmJsMzg2S2VxVWx2SWxUSWRGWkZ1d0JpN2lzYWVMamVuUWJKaUFp?=
 =?utf-8?B?THg1ZGg0VWY2Z2liQ21SS1NmWEtGWEpVSGdCdmp0QWZWQ3dTUnpEOUJmVk9O?=
 =?utf-8?B?S1phcHZaYk0zdUNoSTJ6Z1g3MWxQN1ZpUVZtTVBZQVBtZHE2L3R3Z2llQXJk?=
 =?utf-8?B?OUErRVNYamMwMGY2RVRBamkrZkMzNU10eVBlcmVKUWZSdXVBY3d4YkZ4S25u?=
 =?utf-8?B?YysxRlladlNVWWZiMlZuQm5XZVRSaDB3NFFKWUpHUTVvSXl4dnNrLzFYQW9W?=
 =?utf-8?B?dWRmcE96YXFqWUZoNngxOWhpVUlINkwxT1czelpxeUY3ekJRMWtpVEx3NFY0?=
 =?utf-8?B?TmJrSTJxYUV3TEx1eHJ4RW9abEpGQ3Zuc0MraFFmNGh1RE03M2ZIZys1MmF4?=
 =?utf-8?B?UTJaN0FzQ1BCSTNoUm91U1EycFMwZVU5MXRkamVRV1hja20wak5UTmFBcjgz?=
 =?utf-8?B?QytpZ2RORmtxcFlGQ1pZNWNJOEJ0eThMMEhPZ3pTazRKUEFEcFRqU1cvYk1n?=
 =?utf-8?Q?/hule8aLq1hFleQM=3D?=
X-Exchange-RoutingPolicyChecked: I7Kugf8CApc9mFAEWCcXvSKCOG5GDenlVBTnMAlIIEU4p793dck+fiAw0hnn3+Og5fglGzqh6l3RbR10k1+HxJ+HQpGMcQliEXG/ghGp0WC1DUwnt5HJ2E+1PaVzl5kyY1YZRNia8SEFdOhzLE+3AgTHNO1C2da0g7vvcXK62H+GftXJxw2yIsCijuqV204bgMI1jm5jXOSht87fup6T3C7Fb/+bHBjucnqE7kcdbgqIztsB5ueWXtaMhhsbROptP9IK8M+YLOM5/4ElVXrKgrc9XNXsPDhFN9UrJjrmQbHO9NZJWOID8xVbw9rsZW1zGG+OmMS0cf7O/GK0CGj4Dg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 583bec6f-dbac-43a5-8e7a-08df369ba18c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:36:57.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVApR5vw5C9BV4TjouCWgXq17f8q6XJPSHsB6vQ/xJb0o+HOeYHS9OwBUoA/82EICglIqfV9ZZ4mYUD5u4JRbHKsss5V7oOEdypdU7DWwdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB129532
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 30 Oct 2026 16:35:21 +0100

> From: Mina Almasry <almasrymina@google.com>
> Date: Sat, 24 Oct 2026 03:04:01 +0000
> 
>> From: Naman Gulati <namangulati@google.com>
>>
>> When a DMA mapping fails in idpf_tx_splitq_map() or
>> idpf_tx_singleq_map(), the unwind walks the buffers with
>> libeth_tx_complete(). The first buffer is still typed LIBETH_SQE_FRAG
>> (or LIBETH_SQE_EMPTY if the linear data mapping itself failed) at that
>> point, so it is only unmapped and the skb is never freed. The callers
>> return NETDEV_TX_OK and do not touch the skb either, so it leaks.
>>
>> Free the skb at the end of the unwind.
>>
>> Fixes: d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
>> Signed-off-by: Naman Gulati <namangulati@google.com>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>> ---
>>  drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 2 ++
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
>> index e3ddf18dcbf51..010903260ff6f 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
>> @@ -228,6 +228,8 @@ static void idpf_tx_singleq_dma_map_error(struct idpf_tx_queue *txq,
>>  
>>  	/* Update tail in case netdev_xmit_more was previously true */
>>  	idpf_tx_buf_hw_update(txq, idx, false);
>> +
>> +	dev_kfree_skb_any(skb);
>>  }
>>  
>>  /**
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> index 885df6294ad94..a92e2457781e6 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> @@ -2606,6 +2606,7 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
>>  	struct idpf_sw_queue *refillq = txq->refillq;
>>  	struct libeth_sq_napi_stats ss = { };
>>  	struct idpf_tx_buf *tx_buf = first;
>> +	struct sk_buff *skb = first->skb;
>>  	struct libeth_cq_pp cp = {
>>  		.dev    = txq->dev,
>>  		.ss     = &ss,
>> @@ -2621,6 +2622,8 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
>>  		libeth_tx_complete(tx_buf, &cp);
>>  	}
>>  
>> +	dev_kfree_skb_any(skb);
> 
> libeth_tx_complete() frees the skb.
> Before this loop, it's called on @first.

Sorry, me not reading the commit messages.
If at this point, the SQE is still not `_SKB`, then

Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks!
> 
>> +
>>  	/* Update tail in case netdev_xmit_more was previously true. */
>>  	idpf_tx_buf_hw_update(txq, params->prev_ntu, false);
>>  
>>
>> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
Olek
