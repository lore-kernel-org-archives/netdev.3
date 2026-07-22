Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49D41CB5F
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750632; cv=fail; b=q/SD7dMxU8PpCsUO4qFGs+4hAJEMoLqPLtPF8Hovd2UjtA74jSZf8tGbBnAX+SjXqWCjO1WNpaXDNbqYJcV69qXUp8xO/28kEXHp/Ub3+aINzJwarKEq/DJ9Ft0j5ozXoaCjHSwR9ukneiG27eZIClo7rMsY+uDMl6KeLor7a7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750632; c=relaxed/simple;
	bh=Ge8QdE4IvRXAgvjfEOmt3K7zGfcYm9xC4GCMnn2joFk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vs/qyJwry8JQBw4oNZdNKUZJlLFhT7tByMWTiqJWNYpfeQtLOU6ZDfTx34vL17JCfGmNgveQn7eO21uqRM6AfK/br5MHzVdX0/XuAH7MGytQIBuBrbJVO5bylDHm3xYZj+HTsdUrh7wzZYmo6LAW9pmu1uyy3KE9hXYU2LPCkYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rln70013; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rln70013"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784750632; x=1816286632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ge8QdE4IvRXAgvjfEOmt3K7zGfcYm9xC4GCMnn2joFk=;
  b=Rln70013Vk+p26b6K29IU9B9pOlplH6i7+qOE8Q5SA8JfcFLN89HLhLk
   gyqJCILLxdgk6rgmX0GIIwjW3KRNGEXHVatBA2Ke01LOQMAePRnWO5QVp
   APCtQhIOXCuV8ylr6r+NPTvB6jF++pvVZuxGtkwugWJCoKJoFY85Rn1mS
   qHk2xU3tEjbZXPmMbt+new48DifRaB8NzWdk8P0z7qSRA+eULcTKFAAvG
   bhkL66lWasEq2auf4nMOfY+VLR+i4YOyWBxc4FqH/MVWkd9fguUks5t4F
   0Q3SAphHd5TiT9HUOw5rRSgNqxtBrzQtHQdz2PNaPtdw0NTQHDz/AQD9L
   Q==;
X-CSE-ConnectionGUID: JARO139qSV2AUitDRI/glg==
X-CSE-MsgGUID: v3nD3ue3RgGowBYloz7WhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85444273"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85444273"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 13:03:51 -0700
X-CSE-ConnectionGUID: cI41EqR0R8ibkK8+QqHdKQ==
X-CSE-MsgGUID: fXXvkK2CR3iMveA7onHE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="263140119"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 13:03:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 13:03:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 13:03:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 13:03:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwJ4h1StnYTL5WDC+S+ALjNo53H5nYizpMh8H2vdwY8AmuI9aAba0YqOJOnYr6PbjJEdv2jtZv9vG6FN5t2oC39q6g4vD2UGfNqfwHpYZY3byelMWTCDMIDOFiuNPFCd7VhW7oB4wR3nTK07ozxav50ySexreJp8ofDQp0BlgtPtkneoBI6E7kGTEc2aPRSOdgCziimrXQnbHRuN3xGIP0Xjom4H6O+6Haz8PgL6Hi1jqUHHc1R4xckhVA2iLOg0oZg9a2Sr4/sBNvBLxG+x9I7VmMvjQEHIuuTXgIyADInYKPIlO1HdWUUDSlWwnASshujRhI0ffloe7l3mYZ1GnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnnz+dw2Q1evUiwN+Fc7eplT8wvXhQ6LNBYNSD6laPU=;
 b=mFMyanFdFQWHl7uznWMQ76MgjiuS/exEeXB5jZ6AtpqPr0h/L55r+eLvt4rABQN08mr1GOkjsMLLJ/iXw7R/3VJrU3T/jr9ZemZHZEMZOrnPzYhkss4YMlspfjXempOShNouc3S4ezC4n1hZBI3f571twaqjrWfIWm6OzJpVS7z0acfxhgC8Q0tTSMb47R1olRGMq6gCsuOAY+yCzkxpW8/yJkmL3EMM9xWZnbQEf83ogC7mwBvvxzrTuyJKM7KdxmaeZ8551m6ncibVKJ1u/1PesMaftcAqj2P0102yr8K9JYnTehOlBmZmc+gJ4N34nwX02+QtSTiAJ+yfjEa/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 20:03:41 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 20:03:41 +0000
Message-ID: <b4fdd9b2-9f5e-4999-aa4e-1496043b6d2b@intel.com>
Date: Wed, 22 Jul 2026 13:03:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] pds_core: keep the health thread stopped during
 reset
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <20260722001621.22527-1-nikhil.rao@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260722001621.22527-1-nikhil.rao@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:303:b5::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA0PR11MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: aabd3097-e973-4c07-95a2-08dee82c5392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tF9ENIkb5UNAFpAL1AbXbLZf80u+gejwrcWmb1sm88pP0zT6x963Ru0we8gcK1XFxzFHtHKU8StKBlyWULTBzfTilvlwUKFxtcHrNq26ClLBk+SzvRFd91GO5QYL8EXCrUG66Rok+TobxtoYNVGiJzRQsBSGNoL1qBzH8/O7vT5MGdq0RAiJuguN7Lpi/Pou6ilIkEz9k6kNJ9w4irmKm+TEt4Je/xAWoVtr/+HbQLC9w3vki3Eyfg2ea0PWc2aHk5U/lBKiBMAZQzKt4v6qEvPY67qPzmhwlJWpoEzO3uizn6REcjCqbRn+ZHvWwAlTPeDM0V+PwIfIuk1H+1N2Ass36DvYLHnUEDBC873iuZHBlI+qKV3sT/HGc/RGKyasWc+9KREMnhIFyzXRCh4qtmUxz05wHRrOL6xJbYtC5vNqpNEoswrhoaFAtxbWaowr708Y5ieM5XfoSqmV+vvlwQQfyaqRMLgNRrcrkATKz4hMMy01XLYcv6sj2eVOJoX+nCfTo0isY9uyfSoXqOhNU90hUx0mMscCuk6jOpYyQeBvhPzhjY7yToFOuKYceJpNNZVy2YgDKXjJvcQatv10xQHRqUGPCU81nCmiTymrbQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFpWSTVEczBFUWp2dXJQTWYvdTlNb3VBVEs1M0NlRjJBbEh2dnVjanJxUGJD?=
 =?utf-8?B?ck1SNW1XZDZaQTB0dTdjd0pFR3hXTUEwbUw3aCtPeEV4R3RsSi9Lb2JTSmxR?=
 =?utf-8?B?bHBUVVoyQ29PSjZiOGJ4dnJXSFhRT01UN3E0TGdkb014QlFvNlcyWTJsejk3?=
 =?utf-8?B?dnlySmFmUmhyMnRJeklHRzdKd0xtZGRlc0phTzZOeGNhRk93eWpnaUNiQmM1?=
 =?utf-8?B?Y3ZPVnp5NlpINjduYlN6ZUhzaW00K2FYczJRV1lCY2l3UTNqVWxqUE5KWnow?=
 =?utf-8?B?a0VORm4veVQ4VFp3cWJwWDVGcHcxZkNpdDkrTVlDQjJOb0c5aVVvS3pwWDdN?=
 =?utf-8?B?SitqK0EyK0NYOU5IclVReUJsRmc3SkJKUUMrK0RDSERqbVdneGJoekhtaGd4?=
 =?utf-8?B?czZCd25kaHFyNTA2MTVoQnlHdURLZ0VOaEhZZmxYVHRNblIrZERxU3ZtNkkz?=
 =?utf-8?B?Z0VLaXVQOTVPa05LTm0zY2tzVjVCbHNKZ081OGZrQjEydmZzanlrRjBaYmwz?=
 =?utf-8?B?cEgvMFA5MjdUT1piZ0lrWXBFeStlQVN0TTY4eXIxS3FqVmhCVHl1ZmxiWFFr?=
 =?utf-8?B?WmRuaUgxMjVsZnJYUFJqNnZnSEtEUHlnUUs0MHJCUGxzRzdLSHNjQ3NQbExj?=
 =?utf-8?B?cmRmbjQ3Zk5id2FxNjJWNmhScFZ1RFBQRW84TzZwczhrSzk4dDZlelJmUnlo?=
 =?utf-8?B?M3V6MkkwanBHTWRCRlZFRlg3TzZWTlptTjEzYkIvMEVidXhYK2lTUzAzYXo5?=
 =?utf-8?B?TzgzYmRlVkIvVjVzZG1ZdnJCOVkrYWlyc0tOWUZLNy9SY1FheG5wcDRCa3VG?=
 =?utf-8?B?TktUOXo0QlNJaWVIZXNkblhFSzF4TVA2WXNudjlGb05hSFhXZXh3VUVPYW40?=
 =?utf-8?B?S25rbTNRejZ5djFPNGVqK2Z0QXdiTWdDdWU4VitUdnpTdEl0bWw2b0M4aFcr?=
 =?utf-8?B?cFRzSER3NGs0QkFUZ0RvUWRFb3laL2F6NlNXNVZtcmJ3NWZLaUIydjNBa2Vz?=
 =?utf-8?B?SGlZcGIraDljTmkzRlBVSTVCTUdYM0crb0RhWXhZcDZzSmpBY20zdnEzeUhS?=
 =?utf-8?B?bSt6Z0t4OUx4TDVPeUtHS3FKL0tRTjg4UHc5VG5xR3JzWWZWNUlBN1FYNkdC?=
 =?utf-8?B?RXlNZFVkSnV4MUNtYUZkcUNoeEhMMW5QK2ZGRk8yczV1WENQSzZ4Zm4rUjFJ?=
 =?utf-8?B?M0hmVjYzUHhoTFJKN2wrc2ZGeTNYVVN4eUhwVUpnWXdWWDVYYUpqc0FtMklU?=
 =?utf-8?B?bzRpTW1xYkl1bGFnVDFhb2phQzZYMGI3TXRWVWJzN0R2L1FuNElwcmE0Zklz?=
 =?utf-8?B?VGtSd1JWVUNmdjM2aXltVmVlSk9YamJPUUFYZndzTmphejBuVURmdDZHR0dD?=
 =?utf-8?B?VUFnNHBQSlpaYXRPU21zYTZTODIxbUl2bFFkd2dqSU1RdDFlWU9WalJmK2sv?=
 =?utf-8?B?UWN6S1pQcDlMT3VZdmN2NmxXWWg3emgxQ1ZTOU9nZE1naGJjUWEwRUU4Q3k3?=
 =?utf-8?B?R1paVW5uVXNYak9zV2tCQ2hnSkIybUIzVDU0OWVxejJpNStGTVB6eFI3TExR?=
 =?utf-8?B?NytocWRIM3JsUVZWRm5oN0tWbE50ZEl3OU9XcmhOVVJ1UStaV3lqNzZPVmxC?=
 =?utf-8?B?RUNneEE0MzM2MmJsSXRkVUMzMms5dEFyTnJsdlIyYlRVaHhLdFA3MWoyWExM?=
 =?utf-8?B?TXcrYWdTRjlhaTUwMndPM085RzBxL0x0RlFEaklGdHNKS1RkSlNwdVR4bGp4?=
 =?utf-8?B?N0lrNEN5d0NxNjk4M2N1Y2J2Zkt2VWpkV0ZrZDRXVmJHOCtPUFhaa1VsTzFN?=
 =?utf-8?B?OWVGQWUvL3Bmb3ZuZ2d4Szd3VTVZaUpzQ1d3dEFCdEppbk9ybzloQ2JoalUv?=
 =?utf-8?B?M2cwQVdhOGc1VzVXN2U0UGR0WE16amtQVHRUVllGMncraUNxNFBtUVZTa21O?=
 =?utf-8?B?U21NWEpNWlNyT1hVMHdyczgwcFlLRjh4WDl0Q1VPUFJVWnZYWERKNDd5OVFk?=
 =?utf-8?B?bytJME5aOFkva3BXT29vNEovMmRlV01WR3dycWRkVFh2SHF1SVNlOSsyODZi?=
 =?utf-8?B?bU5HWm9TM1h1bDB5Q1dqWjRPQXg4elUrK2Jmdyt5cHgvYkM2N2FBZ1hlNGlV?=
 =?utf-8?B?WTRLQWZCZG5FRXZCUXF0UE1pTXhBOEtzQXFJSnh3SGdrTVRuV250Sk1YZ2ZJ?=
 =?utf-8?B?dWRBZE42cFBUUThNVFl2RlRPREpLb3dCQVZxbkhTNyt2cTcrdDRFVjhRSDNh?=
 =?utf-8?B?QU5xUXJMTHJESXNsejE5Nmp2VFVyRDhuNDhqbE1ZK3JoZmljYk1SMGlnTHBV?=
 =?utf-8?B?ZWhSRGJSVDRZbmFhcGlHQ0RrWlpUMFBieTRUY0ZUa2VIOW5KWGpHbUErcDk4?=
 =?utf-8?Q?QpX4W9jE1Kslbew4=3D?=
X-Exchange-RoutingPolicyChecked: N3jQ+q7FI92k7ZhTGKpFkcMws1gRgxZju/aohrElGHBl5YUMHqEHE5pLry+cnn4dszrJza1vrmTWelm5lwXpOVLQlhKgDMyAWTXFy6uczZrEtvPGrmc+SSfIDm+GDYZdbC1f9mhOiF3PfxodTTHVoQmM/XaQ1rQoYU79IYhS5PIg2r2lt5D6cDVCAPD+omEuEjgMaV1o2XSkYRBK7EOjYbNhV1KucVy8IE+I+9GTAN9poK4jmCePvTjJU0gxVpFv3WGVU7TJkQlt2CnTDyVs33s8V9o6QFcjixlt39eZnHvvI6lcK+7NDUfTKj6tGpbVNYxwt2mh3StSTQnoMFEZDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd3097-e973-4c07-95a2-08dee82c5392
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 20:03:41.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrVOuBC/7NL9g0pi1o0rC5HBu+/JKwIR/ucd7uWwnqCSh3DI5AkszMvLguZWO3mei+HeeYIAHXIwfYY6FbHOwrR5hDHS3nAAum7EVm/leHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com

On 7/21/2026 5:16 PM, Nikhil P. Rao wrote:
> Commit d9407ff11809 ("pds_core: Prevent health thread from running
> during reset/remove") stops the health thread with cancel_work_sync()
> before a reset, but a devcmd timeout during pdsc_fw_down() re-queues
> health_work, so pdsc_health_thread() runs again mid-reset and double
> allocates the core DMA queues via pdsc_fw_up().
> 
> Only the reset path is affected. On remove, PDSC_S_STOPPING_DRIVER gates
> the health thread.
> 
> Use disable_work_sync() instead, it cancels the pending work and
> disables the item, so the pdsc_fw_down() re-queue becomes a no-op.
> pdsc_restart_health_thread() re-enables it with enable_work().
> 
> Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/amd/pds_core/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 22db78343eb0..3e34350b169b 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -465,7 +465,7 @@ static void pdsc_stop_health_thread(struct pdsc *pdsc)
>  
>  	timer_shutdown_sync(&pdsc->wdtimer);
>  	if (pdsc->health_work.func)
> -		cancel_work_sync(&pdsc->health_work);
> +		disable_work_sync(&pdsc->health_work);
>  }
>  
>  static void pdsc_restart_health_thread(struct pdsc *pdsc)
> @@ -473,6 +473,7 @@ static void pdsc_restart_health_thread(struct pdsc *pdsc)
>  	if (pdsc->pdev->is_virtfn)
>  		return;
>  
> +	enable_work(&pdsc->health_work);
>  	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
>  	mod_timer(&pdsc->wdtimer, jiffies + 1);
>  }

