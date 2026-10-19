Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792453253;
	b=qRGnTLtXFY8FHPbsJnDoZpCE8rfC9/l1RBrUIYRj//Hl+vJVf865etQImyMKNtd9d0RJ
	 SZYc2EIgfHDIALaIsSjGQp3dt+ohIpWAvDoe0V0vX3sGxOMBXC/uy8grbSorkZeH0OieF
	 MUdp/CE0vM4m27nVxCGAngYkXozN62Mqo+hw4AcBqU0wr5uBu10T5IiGDF17LDhb55bsD
	 38M3y34wHHps9xvRA/SGqFzCsPHORD3Z42G1fKYUqhX2UeBk0m6UvZcmOfbEAQGbNPQQU
	 pETE8+Wk53i6N42CnW+dz3KZBcWZb4d50P+9XEXW6qEAVPa+0pQIj7TjXRlMty74rug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453253;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=qmDuquh4PCKbJrmU0Cv15oJQ3ktaEPqVsOOBrrRXWY8=;
	b=lNiFdXD9RIwoC1OfmnHsR2b8kN8Q14VhZIn3Bbi6ztWMoaeyod6uMls+vEJcC0ywmEHH
	 fEfygBtIKMnoLoqsd+A4C/D+2A6MZYZHg23F84qaVWHh1Q1s4oHN/D56+I68L/ydECO+X
	 NQeEBFBl+f4qDDC27X5NeqsqyY/684Xr8+Pnj4wyHlIn30R3VTaYonhpiYtVR0MoFbO05
	 XOBUan9FoTTk0Zy8D3SbZ1YETGuTjiZyNJy+/Ii3+U2WKwH50p8gQGvGL70mA5pOjJMXA
	 jAF8+AIhf3/Gyce6jwfazVFTmnJikaA8qknfgLF0vwLf3bT/e9eyXIzPlqbSOpgNIjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ivWMoa03;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C11606A31C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ivWMoa03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792453251; x=1823989251;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IIp799FtoUFSxlSEs+l0sbVsfjadXZ+12FvtsRXXvEs=;
  b=ivWMoa03tZl918Y0HayJz0O21pqLazYgSy2YF3s5COztFxDwI43oeWhw
   iVXoywiy0hLP2+6nJwqownDLSSTNdUDjq2eeRlU+XX9+/FTrp3hLWI07N
   YYOScDZ0JBsOwXH/YC6iHmQdAboX4oCgHB+MDO9W+yOHQsqELmXXUS2+Z
   nh/Egs0Kr2vqUJhS3Qv31y5ZDHIpRBjIB6uC9hlwi19s7DTj0lOX/CYPh
   24GPV613eCecDZaGldCFJ3/RSCaw9nV5HB87MNQBweV4Vpf55VkTIXIrK
   +fsy0Kh8sCyNOgN91C1wMOrtXjVPeN4CqJiHKZFtbbyB2iOI7hVnoaFru
   Q==;
X-CSE-ConnectionGUID: tqw6PME5RE6Hcd3qdu/vSA==
X-CSE-MsgGUID: uyKivNyTSBu8+Nxyqwmdiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1052507"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1052507"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:40:50 -0700
X-CSE-ConnectionGUID: +o9kwItZStSo5BJM2Cdhaw==
X-CSE-MsgGUID: 6da0Zgd6QqqeMAOUq7MhvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3070115"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:40:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:40:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:40:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdZS182olSNTdyZlInPFzaRWDP40OwrI7A/O4PT3CVRcwcJjRIY5RYOzT2zSr+cnuoB4Ux1c4DbTiAthdZ/jHHljhquiJ6+OjdrbJOKH2gzmxIee2WzdTfV3W6ZFKRU/a2+di8k1pnNP4PMjktF/LvxHgutLirkv0TTg/bVeKy/IvzoPgg0zuDVIJYOIvOZWR2kuNJu+upomqHHP0dADg63Et7DuE+yiqDmZLUBWYSAVqNv8Aqi+TzTrQJSe4xuU1Yv/wY9O2QrejHgekznbTHwyGstHg0y7gCSh7kLgrVLRtKPPHzHJq6tPCiJVWviaL529lG4AMjL0VE0X7y3kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmDuquh4PCKbJrmU0Cv15oJQ3ktaEPqVsOOBrrRXWY8=;
 b=kdqmdV+unZhfLoLJGVOMG53AQMOn+QHMjcey+HdSCyzuvHcqhIUDagrQiyk9Zs1wKn1mVUkVMnMNkLuLpz1YQ46Xc3kSv3fuNbkOG6m2wa/i+bl/Cu2Ikr/epdtUr82LMLbThEZk1w59Ir5ETTTGfZhU0nMfuCd1/7OplabMJi7nKIGWMK1+2wo9j0VVLh+b6NswiClQkv/a4tJ/bU1TYrWW8JEqOKMv+O8u2jz68tLQjXQCKitoGg+ctytVEFqYy4Mn+5qg3nsMhIz2NekhnccZoJn9B0ImC8SsJ5YlsIYeLBeIrFJHMExghLqBUxlr4Az3PNCvPRfHDmJE7+wO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:40:41 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:40:41 +0000
Message-ID: <9ea64678-991d-4bfa-89af-d97d56bb5895@intel.com>
Date: Mon, 19 Oct 2026 16:40:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 07/14] ice: E822: cancel offset verification work
 during reset preparation
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-8-anthony.l.nguyen@intel.com>
 <179244084873.3135.13916049377075971690@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244084873.3135.13916049377075971690@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a3875c-670c-4470-20fe-08df2e3a62b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|4143699003|11063799006|5023799004|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ehaeTkooMcFBmY9o1/in6UJ1rP+ZkHZROdTW3Q4gGuYJSwCR+igstChLDw7aXrSP9moFQam33ZL6nrT3ZAKA5n5rITmZyngmokLpgRfRHYFqO5ZC2nJmq6R6/7NvWNFDc6Q+RJLpN+ygkR/7r8xXMIuhtyPoMZRu/27Inh3Msd3qwWqs62aj1KDuilH4198OMY/XwjhPvm7MTEWm2h062L4iOHrUKa7TsJhapNWladNtT1giCpeT0drj1m2rbGaa9CDBr8TVOzHpZ4xKZBLLen5e3k4oTPLt2pVWbwQqv/W051tnId8RzstQkgg1URe72zc//qeR3H5bOb1qBWkNQUbuXZtm61kFrKzFVfPjaybFhrO1fkl7ijYOFrsB+H8zAlavXIoCB1g85ReyeKFfQOTib0k6Mq+O2KU9dOArm93dvBanzMHnKV7M8LFOBVP6B5ZfTAz3mFJGkTdXft5/H44MAhzUXWqD4VyxEzeY8fxZUGBE/L4YTL54L9A+y9vL0qI7sRqTdoPnC7gFcVI6ikpva8IB143mpaJY8OBcy9knFeMD92ubjxZASHG5x0zHvj7lc0i0a4aoJkAuXNkOSClKpM1nxqZ3a3vq9bttgLMBR3G+Wxig+HGAFkXqWhU4b5o5BYvCK8waL9iHo6rW5KxrbiGvavrKlhFNTWh3K+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3FxUkJiVmZlRWtROFFIVlRGdVFYZnEwMlR6UUJmUzJ1Y0EwR3ZVSDJpU3pk?=
 =?utf-8?B?UE4rcjArcVlUWFcwQ0RYYU5XazZ1dnJZNDU0dEYzcWg0cGUwOEVBbU4yUnBE?=
 =?utf-8?B?SitnTDlaL0w1d005Y3JEMmpkM1F0QkVNd2xCZDJ6Zk9XSHB3Yzl5bXc0T1A0?=
 =?utf-8?B?WHhYY040RjJWRWxuQnMxZ2pRQ0UwTlJjMzBaOCttYVJSY2k0YnM4aEJ2bEJi?=
 =?utf-8?B?bEdQMGVNa1FpRjhwZkQrR2dWQ1R3bHdwajJIOWw4VXJDMk0vM25KWFo5VXFr?=
 =?utf-8?B?cXowODBMWTFXR2lwaG1WT3EvQ0MxeFA0ZmVWME85ODN0TVRNMHk5TzI2TGt3?=
 =?utf-8?B?NVJESmdjSHpJUFpEanBHOGlhZklMWndPNGJQRy9XM2tvemxmT1BJeXRNMXVj?=
 =?utf-8?B?bkFEb1RTY0JXNjh1aWQyNGpKTmRtOW1TcFFZem5KVnNmVEg4cFNWVzJYV0h5?=
 =?utf-8?B?T2VwSTZwd29OVEgwUDhkeEd5dXc4aytjVitJbWYybXZHN25jWmw0S2tqcENV?=
 =?utf-8?B?alhDVkUxSitvcmFMUURGc3p1dFRrbXhLZ3l0WkhNUWUxWjdBNDZrTEFZbURm?=
 =?utf-8?B?YXQzSjlESzlkN2lIWWJBMmtPamRjNCtsNEVqV1BVNGI0eFF1MngyejZLSjVW?=
 =?utf-8?B?c1lDUm1NbHNEQWJLWkEycmJPWFhiWEJOaWs2UDAzbHhsSXdTYzdPb2FrREVG?=
 =?utf-8?B?djJCb3F6VXhzbEU1bFNxWVY5dnRoZUw5b2FEcmFhcnE1QXl2akR3Y3pWUytU?=
 =?utf-8?B?T3NDVWtZQTJKY04wWUNuRkdmSGh2MExaUjRBd3NNeHM5NFhmckQrUFE3MTlJ?=
 =?utf-8?B?eGt3bzl5TzZwUVhITHdzSnl2MWtpMHhZbGVqREwrdjJ2NEh3UlFDaWl2UTVH?=
 =?utf-8?B?QXQwUXZ6U1E3Y2dtT2FMNEhZTlJseExoanUyYk5xTUdsSFNpL3c4U0lmczE3?=
 =?utf-8?B?RlF6endqdklVb1RnMHdBUThLRDU0K0E2MWE2enVuTHNJZ3VBNnNuM1ZTR2t0?=
 =?utf-8?B?VHhqT2d6eXRyRXZIRUp0Yk52UEptSHJJZUZJV2hxRlYydWRXS2hYRkJpczNP?=
 =?utf-8?B?dUh0Mm02ZWIrV2Jzb3JxdXgvK3M5blZTMnd1VFhXcncvdXFXYSt4WUYzYnZH?=
 =?utf-8?B?UC9ja2VMa3h1V2d3dzBoOXFJYUFTOTJzeW43NXVCa3oyY2dkQWxSK3VOU05t?=
 =?utf-8?B?L1Q2d05PYzBnU0pvenNhbTlTRlZ4SDV6UWY5VzlPbGE3VlhyMHdzQVcwQXRX?=
 =?utf-8?B?MW9XNXVMWEROMXdXZXZNN1d3eWV3RjV5MkRHTUVXcXJoemNSbCtrQzBRLzN6?=
 =?utf-8?B?bk9SczVIME9pcmtwSjFmUUFsUVBRVGJPRTF1bmhyekF4cDZlcjRBK1RhTmhC?=
 =?utf-8?B?NXhKOC8vM3p6ZWpBb3Y5VFFJdE5ybnlsa01nSHNoK0pwdnBwWFMvVUJhQlNN?=
 =?utf-8?B?dk1WMTBFb3k3Y3I0UHlMRitubFZPZmN4TWd1Y1RhaC9sU1g2T0VSU2hKNVdr?=
 =?utf-8?B?ZzZ5RGdwOVFMVGlpNFArVlhxMVdsa0NmR3REVWJXVWt3YlJ1SzE3Ni9KcHJa?=
 =?utf-8?B?U2ZLM3U2SVVwN0VoYUR4RTRmejJ3emVLbDhpY1daZDg4UVRDaThFczhXNVpD?=
 =?utf-8?B?WHNFdXdLYmNjeWlHWEVqUWw0Q2k2MHpXMjBaUUhWRGFrMUpjcnZTb3NqQzJ2?=
 =?utf-8?B?MGZESVJIWm5sam1BUUdmdmdnSzJrTCs0UHpWN1dqemFNcmgzZzVNRDhLSmhq?=
 =?utf-8?B?K1ZIUWJ2QWZzNDI1WkhmeWhJWG5Dd0d0N1NlVXlySGROUlBnNzQ3QlRRN2lQ?=
 =?utf-8?B?TU0vejVjclhkdU5ZMkx2VmRXajY5anRIWUZoOHh4c1hDOVoxcWtxRTdEVFIy?=
 =?utf-8?B?US9QaTdzamExUXNzeHFYeE41and1R2xuTVVtc0tJMThZMHM1TWphbDVMenJD?=
 =?utf-8?B?ZDZmVVNtVUdEeVZBaEEreGNzSUhtK0VnY2oxd08rdWpRVCs3emllalB2aFdY?=
 =?utf-8?B?YTdCbzdyZ1JwbzJxbVpqbzRpUHRsZzMrdjFkbFdoZVZMR0o2SHd5MEhhVnh6?=
 =?utf-8?B?bUxjOG9jNU9NVm1ZZkROWUtvNGNuS0s3dU0xa1NPTmFkK3ZuMk5WS1BXNEZB?=
 =?utf-8?B?ZURkTTByQTZkMUpaOElyWlpvZGR6VUdYV3NzNnlJaFJBOTJsVTA1clcyTVBM?=
 =?utf-8?B?bmJOTTNUSUxxMktKemF2VjFSb2pYdDZ2RFdJcEEzOWdESGRMRC9wWmh2dWs3?=
 =?utf-8?B?RFR2QnE0SWM3WS9PWVJwMi94c1c2UW9zVHU1MDNzcjY1c0Rqc1kwR3RHNC9O?=
 =?utf-8?B?amY5V0FGbFpVWEk4QXhZTTNHQUdHMkloUGdjUWU5TG5tZmpqcjEwQT09?=
X-Exchange-RoutingPolicyChecked: fjzKk5LOk77W72X4lqVZqej0GGy65G9dRV9Usz2IEGepqouCK2I7N2D5vcrqC1xBspEyHF3QMwBUc/69pS81L/r7xkf0pJG12R0UShAcdSRT23qQnGwrvZDzm44xlFjPljQ1fkaN2au9bCNR6Y1SK8zJMrrGqeTrH/9X3CSEnpHmywAFBvZqO/bKWKjPtxx/8oS0GvM5R8gzAoWKuxBD8zCBwgsjPcphYnEKyCf214sTfc+TS6XOU6bxzBTO8F2n3J4YpAQCyip3ygS0Dd7Gu15SWOZEQvs2g/reWNdZiBcVUddqae/1os3qOrQhQmaUoYTOeVJ393SnAe5VIVPEEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a3875c-670c-4470-20fe-08df2e3a62b2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:40:40.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMR1vAkikiQ5ZOwmY73DxY75PqRs+s91WtBaK0NbNY5ezaA5qJd/uMnQeu4mh9nqsFR6Bi9FD7ET192zIwLoey4Ux6/kiJ73T4m27bksjog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Possible requeue of ov_work after the new cancel (judged harmless
>   and by design).
> 
> --
> 
> ice: E822: cancel offset verification work during reset preparation
> 
> This patch cancels the E822 offset verification work (ov_work) in
> ice_ptp_prepare_for_reset(). Without the cancel, the work can keep running
> or rescheduling itself while a reset is in progress. The PHY gets
> reconfigured after the reset anyway, either by the clock owner or by
> ice_ptp_link_change() at the end of the rebuild.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 828d46a73f292..6297773806949 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -3006,6 +3006,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>
>>  	kthread_cancel_delayed_work_sync(&ptp->port.work);
>>
>> +	if (hw->mac_type == ICE_MAC_GENERIC)
>> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
>> +
> 
> [Severity: Low]
> This is a minor observation and it may well be intended. This cancel runs
> without adapter->ps_lock held, and nothing stops ov_work from being queued
> again afterwards. Can another PF queue a peer's ov_work again while that
> peer is still resetting?
> 
> On a multi-PF E822 adapter, the clock owner can reach this producer for
> every port that has link_up set:
> 
> ice_ptp_rebuild_owner() / ice_ptp_settime64()
>   ice_ptp_restart_all_phy()
>     ice_ptp_port_phy_restart(port)
>       kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0);
> 
> ice_ptp_restart_all_phy() checks only this before restarting the peer's PHY:
> 
> 	if (READ_ONCE(port->link_up))
> 		ice_ptp_port_phy_restart(port);
> 
> It does not look at the peer's ptp.state or its reset state.
> 
> The impact looks small. A requeued ice_ptp_wait_for_offsets() sees
> ice_is_reset_in_progress() and only reschedules, with no hardware access:
> 
> 	if (ice_is_reset_in_progress(pf->state)) {
> 		/* wait for device driver to complete reset */
> 		kthread_queue_delayed_work(pf->ptp.kworker,
> 					   &port->ov_work,
> 					   msecs_to_jiffies(100));
> 		return;
> 	}
> 
> Each PF's ice_rebuild() also calls ice_ptp_link_change(). That path goes
> through ice_ptp_port_phy_restart(), which cancels and requeues the work.
> 
> The commit message also says the PHY is reconfigured "as part of the clock
> owner resetting", so the requeue may be the intended recalibration path. If
> so, the only effect left is a few no-op 100 ms reschedules during a reset.
> 
> Is that the expected behaviour, or should the restart path skip ports whose
> PF is in reset?
> 

This is intended, in the sense that we don't really have a great method
of handling sequencing here. If the main PF resets it will be modifying
the clock so it must restart each PHY to account for that reset clock.
However, each port might be resetting too and will need to restart the
PHY in order to ensure the appropriate link state. We don't currently
have a good synchronization mechanism to ensure that we wait till
everything resets and then restart all PHY... This could use a better
design of the entire reset procedure but we don't have one since each PF
is (mostly) independent. At worst I believe this results in a duplicate
PHY reset which is annoying but overall ok as long as we reset after we
know the appropriate link state.

Cancelling the work is just done to avoid wasting unnecessary CPU doing
nothing useful.

>>  	if (reset_type == ICE_RESET_PFR)
>>  		return;
>>
> 

