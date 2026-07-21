Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A9357CEB
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669722; cv=fail; b=W5xPb/ORNS0r9KSSj9tTGqg7qj9IiuVcOWxgX0ppF/irIGD1CsdJHebpK2aLHovERvVQcutQyb/cnYrhDo88bhIkbuJdcffdp4qpZml9bVxX5AigMBXEqNRcqMfSg/9ai1x58AaWkm/tQhWaYYfOAfc0movaWTBvRhjbtjp6gIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669722; c=relaxed/simple;
	bh=BBpji78UjI40YIYHcLwLqfvXNS5PdoFuG6TZKUQmP4s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XylYuoivvP+To3XTBih9RL8tjTJM/3XjkEbhiaT6OAwfGbD9Tf1aIUzaW8+V5k0os6b8A7Zi7GI3Ff3aKlx6AXBw8G3jRg2kgw2U+kSNEJGgtLzw+fF5qkn5zWQdlEsinmSpbYbm3q4SSJVx/sz8bQmv4l1ZaXXUgqNltRw6X0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwHNd5xo; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwHNd5xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784669720; x=1816205720;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BBpji78UjI40YIYHcLwLqfvXNS5PdoFuG6TZKUQmP4s=;
  b=QwHNd5xoCQH76hX+vNX96541JFBJGSkmZwONHMjo5ZxPjzH9/eJqGJXo
   DvZKxXenq1QIh67bPFcyLCOUCQMoSEc4b7hr9bVb6Y92Q16fgVFaHMqmU
   eF0DfAIQEM2T7rMg/XUQbBmZRo2gbDz/hVUDXWOucIlFlOgwc/8qFbXUA
   /CihnGtqw2J2ZaJahbJ+3RAicxWUgVNoFlgdINoeZmL0ZbfQUMlqbc0Zo
   SdkJ/iYPiZ7GOa8kOzy1cWrzt383w1VXdK6rcsWJSs/p1zfp8CjZ96Zrg
   38TdHlto9cndj18d+nlHoUvh89MaZ7jGyuiJAqjCPCPj3uJjwi0Wj9VkH
   g==;
X-CSE-ConnectionGUID: hIhBJiLnRl+RGt5fW+qQFg==
X-CSE-MsgGUID: ca+AQMP2QYa6wJn5RCHgug==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85234425"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85234425"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 14:34:16 -0700
X-CSE-ConnectionGUID: fogJkvNMQO6b4ZfecKOJkg==
X-CSE-MsgGUID: Dkqr7kopQVurd1dYy0VPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="287912719"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 14:34:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 14:34:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 14:34:14 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 14:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiMJYxOBKOslY4ngBo90aC5fgv5dgFgQSxyobCUFF7ofuxEgGExB4hh7JaPdG5s/0LmjqpdfltbN/dTfNm/gX5E6HPvuVLRYxUXXlspwnBBdcOEcAALZcjMOz4i3euWLZk/x9dl05Z860smBiLH4w7Pl/orYkbtRmvH9h3CmV8Rn3Rkz1Zt3yvcN9nhFaLmTZyTTa3j2uBnBG3i5MsN7+fuTeC60/ryoOtGSJHgAfQL2HKOt7PQdSATbPGMnuogkq3g27JaQJ+yNOpgCuqh+FlOKeJbtGS4NEmx4ByCNvgUnBUGw2WRsoi7g1PFddMKo7JkbUsGVtmwqxFUP4EKpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42k007VGNH4dfDaWZ3V9R5NtCKyON+kDoSCnZxWlqoU=;
 b=vo+/VF3zwZv6Th0DOf5UGGCW2HVoYpbOYFnURIvCS6knp2YCyyo/gu1Vqanl81L0a8pIANQdoPUcu5jnV5lC+rDKtbTOAZekAKurouiK7zFrTnkNvFevGq1h1jDBzyfx1d/8kxG36WiurImrD3rd9GdS7ngeAOhvgmYio27AUP1g9WzGBkvG+8XxXWzb8nGjtk0khokgGeQV8FAadtFtPNR+K2DfMZUbjbkxqZxJBLXU0dN/dY9mTFata3AS5eIOKWaQ3uofA0aTVSRiuzx04jvaDPRtlScEx39j38q1aM5vFAlJjQMRXZPJYz6YqGJm/8PfSWvMcUuzyROZWtxIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 21:34:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:34:12 +0000
Message-ID: <992d2570-1d99-4916-a570-7147d6e2d59b@intel.com>
Date: Tue, 21 Jul 2026 14:34:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
 <20260721-airoha-ethtool-priv_flags-v9-2-9c15d8b71a56@kernel.org>
 <4f875005-e07c-4366-af8d-b7173d2d3b77@intel.com> <al87am5-OScErxLn@lore-desk>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <al87am5-OScErxLn@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW3PR11MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 8542afce-ef8c-48d1-af0c-08dee76fce3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xDHeQ/I77LQLSHmfnKdhk7P36TsHpWDzagOREVz3t7y+bUiOuU//oHgHI0vovRpo4Rg8Gglxf080l+W7rjpCg33We2Xt0m+ep5UUY3xbzom9rWw8GEnRg31UfZMh/+z9SttUE+QuEfQ2zmUJnhTW2AYkArN+cGaKY3hbZpjmq+y+NlD1pzDNIYwivqYZ0yiT0e+LLagzYj3NnVQNgFoi5SKyhG2AamNIdKA8CBse4XfQS+Hjc2KRzMOtshEsK2HeKDcqX92icLb9Raa+FTE5FWHJQhPLMChH2rZOzoUnvb6nX68d3J+CFEFMVoV70AxOU4S/KU7SSXA/gZ3GIDJZ3TMuDGlOt67d729faFBdPIMOViWm2Xjs6gviRLX2SlJelxr6j9bLq5GfxDPxH2JgMUxgsX8kRWho7q+Apqwg39F6GSQDZyuhOXHQRPR4etmnoPzRLPwMJOQr1JwI7V3OdytbRlH69hOKrB2ctE8bPYNUN7D4baL63StYgHK+scdFgf/I9EbFfln94RCb//gBzma85k18yiGVVzaU1VblBPOYG0RLrsldoIZ6ZbbmGlAU+BtuioteRTMfp6yaCSee32GPKT0T5zOGUbfmBL8fmkwK83NvUBy69fNsA0fqmicgOrVDDUT2ewHeWbX/SlOSwdTdbwVUCqs2yVjoJ43LXL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWl0cGdTcjlMeWk1dWVtdTlGeDVpNkRmbWpJZTZxZ3Z3T0IzeEwvaFFYaWRG?=
 =?utf-8?B?bHQ3VzV1VHNRdjlTYlZRdjlZMVFFZzBIKzZEbnB3bWowcDBzTlRRUVloWlds?=
 =?utf-8?B?Mk01WEdqTVpDdUUxQWplSkJtMGwrOHhYM1FqVnNTWkdWVjhxVllsSmxQVlBS?=
 =?utf-8?B?WjhjK3QxZ3Zpdll4ZStRc29kcXhDWUcvYVkyYm9jZzZmRVF2SzR4ZGkzQ0VW?=
 =?utf-8?B?T2FVR0M5VHdWb1p6eXVXTDNjdWkvMHJtOUUvUUhTL3NaQjYrUDNVU0s0S1d6?=
 =?utf-8?B?WjlXQyt6ZmdqRjFyWmt5RlNEcWR6V01CWCt3SW5GSDdxTmUxVFp0ZXYwMkMx?=
 =?utf-8?B?WlhwNnNjNWZJY0FFK3ZNN2o1OWpvNDBDeUx1aXNPeVJ0dkQ1bXNJaHRTbXdY?=
 =?utf-8?B?Y0NuVW9ZeTUrWTlmaWFFT3lXbTVJblJVT0orb3NjenJ6NWNud3VJc1htdWtH?=
 =?utf-8?B?U0VKcnhoVFcvaURIbk11cUJWQkRINmE2a0xBYWwvMHEwUDRQM09pL0hHeXdM?=
 =?utf-8?B?Zk05S01mYU05VWYydksxM1dmQmlmTFZWd1ppY2kveGo2a2xNZkdHMDdTV2Nw?=
 =?utf-8?B?N3lZRC9iNG15UFZBQ3ZDMVladzhjL2IrWXZMZmdOLzJ6dmh2Y2t6SUQ4d3Ri?=
 =?utf-8?B?T0tPRVAvVnJ1WFdTSUZFRnFxWWZNYW9veWtsV0FhU2NBV0dVZ2YzTmJWL2RL?=
 =?utf-8?B?OWhteTNGUmJwdC9nallrWTI3VDRyM0tic1g4cm5Xc2tBNitKeEJpQmxreGVZ?=
 =?utf-8?B?WnpHbHd3SFp5SDV5clJpdW5Ebzg4ZGRIYkpZSFAvWmlTTGwyczhXUXdiUnFW?=
 =?utf-8?B?SFJDdGI0QTdjWnJPS1dmZUVCb2JpbnlCT3pUR2VJN3lIRFNydk5pbjFJMzAv?=
 =?utf-8?B?b0NoZ0pMdmxleE9BcUFnU3kvTEtvbHBHS1diUnplc0tDeHRwemR2US9Da3Yy?=
 =?utf-8?B?MkRvNHR4UG9XRTQ2ZFh6OTM2TFp1cTQyamppS3NRK1czME8zeGZLeUtZRHRT?=
 =?utf-8?B?ckQvTEVPNis3WVVZVmVtWTkxcW1pYU02Q2NBT0dMbytMLzU3YzZIZlJpNi9B?=
 =?utf-8?B?eW82VGJXTjlqWCtML1B3Rk5Qck83UnhOSUE2U09vNDcxVEluTGNZVXRUZXlX?=
 =?utf-8?B?OWliOUVBK3FWVXlDQ3NVbUpIUjAwUnI5L25nZmMyQUkvWjZ6MWttRVdtVUlj?=
 =?utf-8?B?TDF1UW84S1RSRzdaZXJycWd5d0NQaFF4VWdCaTVReGFaNnBUL3hXNlViWWdp?=
 =?utf-8?B?c1ZBM1cxZEN0b2Q1Mkd4bjExY2oxQko3cTFzcnR6UGFHTUtSa3hGTVFtVjJQ?=
 =?utf-8?B?ZkJmd2dSSnp6aytwV2d3YXgzTWtHbEdnN05teFgrNS9QQ0Irc3Z6a1llWVNo?=
 =?utf-8?B?aGlvQzZlS1U4RE4vZWMrQUlHTkNCQlpwWlFHSkUzSGllcXE4WHl6NmRnbmdL?=
 =?utf-8?B?ZkZqVWtZQlNlMjdBTXBkOWtiK2RjL3piM0daVkxmM0RLQ1RwT2NNNVZaMGtp?=
 =?utf-8?B?eGRiQUhvdC8xczNKdGVEbzY0QWIwWUxQNVdiT3kzTWtQNGt1QTNPQ0NiMlY0?=
 =?utf-8?B?cmVqUTM5UmpUMkdxVDUvNndKajRRaCtLUndSaDlEWE5aTllmbTBnTEM4azlr?=
 =?utf-8?B?UmpyS3JOOHBkZjJoc1UxUGR1TDJIZzNTMVFCY0R0dWpxQVNyOG84c1dUVElW?=
 =?utf-8?B?VjlwYmRib013bWNBRDZEMFlmbFJydy8ra1dGd2hYZlYzbHNRN0U1VVliMFZC?=
 =?utf-8?B?QmhEOFZ2RWxaNUlBS2FnS005L0oxNHVtNmpaeWFpSGkvdXVDelZRR1ExYVVX?=
 =?utf-8?B?Q0JDQythRmRxei80MTNDMzFoUE13UFlvdWdxWStHYStnaUVad2lxRDBLcWdr?=
 =?utf-8?B?eTI2V2RNdklYR1RVTUlocUtqZHVWUURMTXcybUlJdlhXNnhBaCt6VkVseWtN?=
 =?utf-8?B?MGIzeWVjcGY3b1VtNTNOdFVlcXZTdk5naFluakxQRGRIQWc2dlAvMVBsSDlV?=
 =?utf-8?B?d0xQU3E4a1B4eFdhK0J1NUxRa3Vla0Z4U1o4c1U3VHdJWUZVQjY4UEJ2YnlO?=
 =?utf-8?B?L2VaL2M1S1UvaWx2eVNkd3NrVTFEbkUvY2JkWEdhc0FJSXNvaWVxbHN3RmVm?=
 =?utf-8?B?bHE3bVhYdTVRWGxyYmJTNm85NXM4aXdIUE9lWU83QWdPN2h1TFhBT21QLzNi?=
 =?utf-8?B?cEdJcFpzaXQ1QmM0V0tZcGZHL0xYbEVaRnBTREhkS3l6ZE1OUnIwWFNvVnhr?=
 =?utf-8?B?NkxKendrWTRDQUtvZW9pQVV0UjZ0TVlKUWhtRHpVYk56MDhxbDRub0QzQ2xn?=
 =?utf-8?B?UThGSjZEdjZiNTVERVNwQ09Gb1QxSVJrNUM1ODZ2RjV6WHVVU2ZxZz09?=
X-Exchange-RoutingPolicyChecked: TShbOT/DCPeaWmq0T9jH74U/F9zxXfnEu2LheRXb6Z7SPLXY/5lLV4AxeWXAPlBeF0b7HF50+GGLrf0UvonwaGI/SgFK0QAXQKIdAjwwp0tAS+96BeUH0fXQIqBBGHZes8OwLO4vsqTvFDLhQ/u9X3SzdzE8WNjrJh6VhFsvpjZSm+1551coJe2OoyEatok88pJHAdDS9ot6l1WoJlCD7WZWYmxCpOBfvxSEpMIe4RdZ85hF0SqIdSMIcWN0mnBphNiRWIE4wZdBTZns0He0XJMXXxMghMUNsGvCiLEXqAifKDBFgArgkKMHvNLvJoJ8MCRRvElRiPGw+3YmfdDuug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8542afce-ef8c-48d1-af0c-08dee76fce3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:34:12.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RfakHqFzMVAup/SpLL5aT/kgKqwROzNvOo39paQe8aG7KMAj+yuXlq2cK3cCy94bdtgv5owKx7eKixhm/S1MaCeix/41t7ddUVLzoIvJFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
X-OriginatorOrg: intel.com

On 7/21/2026 2:27 AM, Lorenzo Bianconi wrote:
>> On 7/20/2026 3:03 PM, Lorenzo Bianconi wrote:
>>> airoha_qdma_get_tx_ets_stats() has two bugs:
>>> - The hardware counters read via airoha_qdma_rr() are 32-bit values
>>>   but are stored in u64 locals and subtracted from u64 baselines. When
>>>   a 32-bit hardware counter wraps around, the subtraction produces a
>>>   large underflow value passed to _bstats_update().
>>
>> This issue would only be a problem during rollover, which depending on
>> how fast the counts increment may not be a big problem. I could see this
>> not being worth going to net since it could be rare enough that it isn't
>> considered a widespread issue...
>>
>>> - The baseline counters (cpu_tx_packets, fwd_tx_packets) are stored as
>>>   single per-device fields, but airoha_qdma_get_tx_ets_stats() is
>>>   called with different channel values (0-3). Each call reads a
>>>   different channel's hardware counter but overwrites the same
>>>   baseline, corrupting the delta computation for other channels.
>>>
>>
>> However, this issue seems like its going to cause a problem every time
>> you read because any time you use a mix of channels you will get
>> corrupted values?
> 
> Hi Jacob,
> 
> I agree this is a real bug (and it needs to be fixed). However, the real
> use-case is having a single channel per net_device (a single HTB offloaded
> qdisc) and multiple hw queues (connected to the ETS offloaded classes).
> In this scenario we do not trigger this issue.
> 

>> This targets a commit which merged in v6.14, but the patch is part of a
>> series aimed at net-next. Could you explain why this shouldn't be
>> separated out and put as a fix in net? It seems pretty obvious that
>> users can easily reproduce problems by requesting stats from each
>> channel? Or is this not really possible to trigger from userspace until
>> patch 3/3?
> 
> For the reason described above and to avoid any possible conflicts with patch
> 3/3 I decided to add this patch here (adding the proper Fixes tag for the
> backport) but if you prefer I can remove patch 2/3 from this series and send
> it to net. What do you prefer?
> 

If users can't trigger the issue easily in the normal use cases, and the
result is only bad stat values (and not actually corrupt memory etc), I
have no objections to waiting. The scope of the fix is fairly minor and
avoiding the conflicts seems like a reasonable goal.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Regards,
> Lorenzo
> 
