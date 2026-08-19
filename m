Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2E3E832B;
	Wed, 19 Aug 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136786; cv=fail; b=NpKoMAC+WMkBSPSs7ale5J/9rtdmy4DXFgrfyLwT/xT5EERgEuZpw/4DZ4tQN04XF4kEQbG07k7ZcamZ5syqY5i6V5bmTQLiPshJY3imhozeDDSjYW9SG0TtrHIOCKgnZKJzgNE9kjj6BNPIK5UHrB/vAepaVms4mYpMTTTLaT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136786; c=relaxed/simple;
	bh=XF318ruA3t3KMNWJWWhPMSmwAw/cZ2133D1UrKNgPKA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cIl02LyvHmkR9XKkweP/AWxXZDBNzwko/dzlhE4U/oHwumket0jtKWi5Tm1d0d2G2c1mpyXjjs/AgLz1m9daO0keHEYKG96uDrM6sAGdwfTIYKQO2GBph2WgbL67Ub4O+InJcH5A6pn9BgLldkwc7xoIR56UBS2mQcWOyUKmU8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJzr/yFl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJzr/yFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787136785; x=1818672785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XF318ruA3t3KMNWJWWhPMSmwAw/cZ2133D1UrKNgPKA=;
  b=bJzr/yFlb2vNB+/A6+BN/NpDd3IhM0nZczZFP4U2yPKYjIXkPoadZgT0
   d/ajN+ieya+AX8oVGzcB6sh/DyuGpjZI7/J2j5tY3DJy4DvDIDe59G1PA
   CXAWnyHiJlnWoF0lx/imsXvSVA+uBRFJ4Rp+vbN2udZY2LEk1YoTWqFfb
   felYB4NCTs596sGlfaibZd/TuMZBAS1q8awNTb0niNyVu4S24cDNhm6Lj
   4dy3UUw42Nuh5OGQ1R9d+7g0lT1l8l1t1JtaLdZFSylGoOObB9yS8GGSM
   E0Iqsju1nBz6YPXpAO01KvqnWmW7xhFEwySTlCDgsr3qgmPRIBZexHLqL
   w==;
X-CSE-ConnectionGUID: 2BYQPbFQSWKMGz9K9ClW5w==
X-CSE-MsgGUID: k0cwPLPSQoeIX7syJJKQ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98807274"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98807274"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:53:02 -0700
X-CSE-ConnectionGUID: 7ulKBWKQQkOfo+PrfqVGcQ==
X-CSE-MsgGUID: KA3VSa9wSzWczjhTXjIkkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="262886281"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:52:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:52:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 03:52:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W84dfPlaL+5NfLZ6FIBUw2GJ6TONSfNUipV5KqMbCSbdFkIWDgdHIU1J776jExkvTXkYySZXXCwLe7g7uNNrdhZELemrNg9WjTOJPg2UdI7sE5Tvphb0wpzjQK37lcDiLtmoTGK9blwKhZSLAvjigCLowhVbHQqIdicoxaHm1XB2kjse6Gnb4vSUt560k3p5ehH9BHnKIzTBRpfqvVLHvcZN4j0I8wcWfV24qZ8QLMU7FvFwQ8uthyzXnPy8kf2/CAviuW4Eo/sIwSgyu5vbchDBJiEptxe4eIPrcBJ/MehgGlhE1/V8k/Rut9nYkZSxvktr59hiTD3GpNnyNnoRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXCknDNcacl0u4h/kh3WMb0T15INhuNgpNwS29p9ggY=;
 b=cJc9XTJCnBCsYhytjs3dGbLYUCQFhEEdAgguOHoNk8YfmMwZl8NtBM/MYEL58XNlq7pctpjD3IwpKadv0I11Shsb50jSxTvHBqZKgXWswgDlWP0xtUQ2EdZg1y5EmWTR+BDCjuRNCmgiFHC0KkwbgG9ZQk8lo21GLPQ/1qwnxY5ADqh/ZYIZVSbHY4gZUbH7qdIOBTCTT7r/55WbYbtyFqfHiLmUNLPEMezFfXy8COZz/iL99fxhEp0li1ihVGEcM5+0ueQMdlGXTlK5iUAe/pcMkSITuEmcWj8C2ul0YlOEaGbSxOrM/yjngKrSvX4mZMePzlSEBtJGYUTwP+xyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW5PR11MB5788.namprd11.prod.outlook.com (2603:10b6:303:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 10:52:46 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:52:46 +0000
Message-ID: <98034c58-cb45-4367-a074-bc654af1ce77@intel.com>
Date: Wed, 19 Aug 2026 12:54:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: allow reading the last byte of the NVM and
 Shadow RAM regions
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>, Robert Malz <robert.malz@canonical.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>
References: <20260819082458.665947-1-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260819082458.665947-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW5PR11MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2759e0-ca81-40da-39ce-08defde0008c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bu4BWsyP1SY4tIale9otO1wY8Z2GSMnvOi5dCUxxYuIyaU0zjmZAriYUeL1BAkCqk8Xq2Pp9UXJ0CtRM92eOJcp1pub61ab4zmLe9It5UE4Zs5wjFtyHPgxZdvdhx0oQhrv5US2tk33bqhe8Z6psEAj2VT0lkHFwZMxkbinXcmbGEPkNPTo7SE0GSptUhcrW006VKNM3OR6qLNwQvBppMEwxA/EFb5bHf4AEJlte9DOmO48EE98b73fQrI8CSPkaRY7UBi8XedumqIjBVo8VrSTOQST16MHEkcsZupZMIAfHCRwqwCLEw9G89V0U0+hvHqn1aQra+KaTa/rcdsR2cZJwrbe+EfjFFsFeJUDkE89td6whLVBNT4wt+blcuzW4HbJxfTW3mJ4v5HU82jdiDBdtU5bAYHZNV3lm8n/OW8R4H4D0KK5/tKL7g/pSlsPfcNSv+Y2Y04uzgDVjfV4EP40NBPHRgiAHAgAvBW2rIqLT+qcl7efPorfiARpfacDsiZ39QJKedlCfKbYrjMyxVDIv/rDaEzk3KD4hldr3iM4qS/XRrpyI3dxsHKPc09C9eJINCC/hDO3yqPk3B/S+zr/04mIzOxV1Gr2+xQMu5k3I2RmmlfWSYQ3zs291iR27wm4ZL4yNObCsV75NX1NMYw6OXOoo8yP4lBW0K6rRsHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWtpY0I4KzU3UVFLTUpJM2l4ckk2K3N4S2JnWnQ1VU53c2FNZHlkOC9PWSs5?=
 =?utf-8?B?dGR5ZndqckpIbzh5SlZwMEd0VE1EZzFBUmdrOVRQc01iQkhTNDdhWnZCcFB1?=
 =?utf-8?B?T09PY0RGL2hqcmR5RXlTSEdlWll3RVY3NUdQajNUWm1RRGl1d0tiVDQ3bVRt?=
 =?utf-8?B?VnpKZEpCOGNEL09mTloyYzdQcldvbU9GdjV3ZGRMdXlOL1hnS0s4OEhPMk8w?=
 =?utf-8?B?L1JVVnhvN3FrYlpOM3Z6WWRodEdjaUUrUHpWSW5TMFQvd1IweWNxV0ZSQ3pE?=
 =?utf-8?B?M1lYTVI1ZTU0Z0F2cmVvS2tEcWJybXRVbnRZTDRWSlI0UmgrTkd1czVMYU9O?=
 =?utf-8?B?aHVpVHpXUERvZXJIR2FoZHFGNmF6WFhqSXk1Ykt6bTJMQVVCSklyUFNHUm42?=
 =?utf-8?B?cFZCZDFUcnlhYkVYVFBMY2IranRHSTV2cWdHMlJzNE1qSCsxUnYyMzV3WXFQ?=
 =?utf-8?B?cEh2cHFNK21YbS85ZXdlQTJWQU1XV1IwMC9tWEZZRkR6eFVSUDBZWUx2ZkRh?=
 =?utf-8?B?VG5lNUI1L001V3NjZFpRMW10WU05ZVlDWnNFNEpGZllLa25yeXNlZU9MOUha?=
 =?utf-8?B?QnBlaFFacFZheUZ6aW9lUkhHSVBwa055YitKaXBWL1BaekRWa3NZdHJKbkl4?=
 =?utf-8?B?ZGQvNlhmT01tWWp3VFhZRkt6aGZNdG55SDNaQ29UQWlpQ3VPS3Y0bVdwbXdL?=
 =?utf-8?B?UGpxb1dVUjVDRGNoN1E1eFhkSE9jMU9CeEh4RVFIUncwVmZaaGFMd2p2M3F1?=
 =?utf-8?B?T3NuMnkyTlpjb0pXbmNjSUE2Y1l5L2I5NW1QV0pPU2pFWFNUdHVDbU1Cdk9h?=
 =?utf-8?B?RndoZERCaVNBYzFkOEk2MWJPNFlaYVU3UFJSdWkzempoYmhWcUJXV1VrcGlx?=
 =?utf-8?B?TmsvTWVvblp0MG5rRTdydW1uTkpOR3A3N04yOTV1TUZSV3dtOGtLaVI4amRk?=
 =?utf-8?B?REU0amdPTlUzVFUxem9Ldi9NWHU5Snp0OWUrRm8zcGRhc09teC9sQ3dYWVRK?=
 =?utf-8?B?ZStrZjI0NHltZDdkczg5eEZVQTBTSzJHSlJPMWVlSW5WdndCTGhmRzVzNHM5?=
 =?utf-8?B?UHNaNmowa3JZdjhVWk4xS2RJeHMzTzE3TkZaRWsvTUZ2Y2M0bFExNmNoWGQw?=
 =?utf-8?B?Y2tQaW5zMVFySTRxaGFMRm1jb3czR0c3K2FTcm5TUUM1S1hjQXZYamFSMW9s?=
 =?utf-8?B?RThqY09Ra3FKckJRUHdPZWRwdCt3S1gxYnZXNFJYZ1ppcy9tWnh2T0ZnWEhx?=
 =?utf-8?B?L2VVQkdxZXpKSGtxUzhSbHN3VjJmd2xmcDYwKzNjUHRobUhsaXVOZTcyK1hm?=
 =?utf-8?B?T3ovV2VNM1JsenR2a2dXY1AwckZ1ZzBQQkRhYnQ4MW5yWUU0cW1zWWVKK05o?=
 =?utf-8?B?TlJkdUJwdWVZTy9GclZUUExlS2ViOVVXQjgvZzV2OG1JeGl0UnNJbFlVdG5l?=
 =?utf-8?B?RnZMaVZsb1kzMkJnQ0dCcWw4Z3o1dFoxeEs2cVNISE1uYkFWaGJYQUVzNFJ6?=
 =?utf-8?B?TGtGaFZNQzhPNGIvMFRSMS9STHgzN1RTOUlOTHF2d3ZmbW5zMTlFOWhDc01s?=
 =?utf-8?B?VExXMTk5bG9VbGNvZkoxVUNXb0YyY1B2TjcxdUcrakcxL0k2T2tCRVhJMllW?=
 =?utf-8?B?MkNrWUVyVWlhMW5yanljYVNFR3ZmdXVhdHZ6a2JIL0ZHekJ0NVJjcm1vTGhM?=
 =?utf-8?B?ZzYzcHp5NXU3ZCswRWRVWEZnU3Z3dkpuSTN4VEJ6OU5lMEhIdjQwbUNSVjE2?=
 =?utf-8?B?ajlNbXBabzNKaUhFMUp2UnlVbnJ4U2IwYy95WHhZWWs5N1BLZFhKSVFoMWdx?=
 =?utf-8?B?QXF1YzU1ZFNPL0cxYmdSeXNXZWZSVTl0NmdyUy9WTnNsanIvQUFPb0Z0L2Qv?=
 =?utf-8?B?ZTVrZEFNZHh0YzN5ckZ3MVJyeGdSVWZJb3lVRVpsbkhYMCtRTkxjZDJSbU4z?=
 =?utf-8?B?MjA2UnRxT0JHS2tNdzJhYWRqUXpXbm5TUUtqS2JKbCtMTTdhQ0RoTTFPMCtl?=
 =?utf-8?B?T2hzcWMwVENlMkRtUFpFSFZob3Y2ZEdjTWplRW1kL1BhMGxvY3c3YU9xNXhO?=
 =?utf-8?B?b0ZUQWdhaXgzT3BoS2NZd1p1UmF2YlZVdW0xUTQzcmR3T0NiY210eVhacmw0?=
 =?utf-8?B?Z3ErdmhYa1BiSFNtR2R3ekJGN2cwTkVGT1F4TkkxdTBRanVXRm5LdzI0VWoz?=
 =?utf-8?B?Q2xoL2YyWExaUDdTc2w3OFc0UEhKL041aC81Q0pWRmxCRU9vNEx2YkEzUHdI?=
 =?utf-8?B?NXpnVnVlUXRONXNHbmZPZlVqM2FNNWkwZjVscDV2OGp3MDJkUWxhcXNHWGNw?=
 =?utf-8?B?U3pCWUR0bHVlTi9Wak1wSVhjbmViNHlaczEwMkFCdlQ2cmp3Y1VLMjROMUJv?=
 =?utf-8?Q?sTdT3UCm8SknLe7c=3D?=
X-Exchange-RoutingPolicyChecked: tPCtzEkKnTO/jmJHclD+X+ERvW4Yt0Hxe4vaZUg2BRnR2tBYWQ3eoBaASZV8WtoWsXLqPT6NvYaAYRSOjJcgQHxrnWue8qGNP5U68um+sEmRO4l9uOrTsI8WRafoHPDNUzaRfuZ/JTDxCTYcoPFeCjifjG0nfaBATrQ3evv0IaSYxHY3qveRzlia4BnBdc1iNxiWcp5YvEhqwbZMmms/EUAkwSTpWtvtQjR8ULlieMDyu4mE+w/UccFopQGUgPbx/RZg+BZF4KIzEn/TjvKpktq1Vi6n8AZgNoJ7kz66SIcyla5yKrJRRhjEhcly199iVfG+osFS7BfABYQJOa37hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2759e0-ca81-40da-39ce-08defde0008c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:52:45.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q+QY3GP/zQeh4X2zMF8vK3fUIkRgIlXKnNIIUAva1f8cVMQhDtLAqOFKNI3WfPf7VnW2EtWHthhsOA5xG01h0lCYl2p++ihk/QTh1IRk9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5788
X-OriginatorOrg: intel.com

On 8/19/26 10:24, Petr Oros wrote:
> ice_devlink_nvm_read() rejects a read whose end lands exactly on the
> region size, so feeding back the size devlink itself reports fails:
> 
>    devlink region show pci/0000:04:00.0/nvm-flash
>    pci/0000:04:00.0/nvm-flash: size 10485760 snapshot [] max 1
> 
>    devlink region read pci/0000:04:00.0/nvm-flash address 0 length 10485760
>    Error: ice: Cannot read beyond the region size.
> 
> shadow-ram behaves the same. The regions are created with those sizes, so
> a read ending on the size is the whole region and has to be allowed.
> ice_read_flat_nvm() uses > for its own Shadow RAM check, and so does
> ixgbe, which grew its region support from this code.
> 
> Fixes: 3af4b40b0f2f ("ice: implement direct read for NVM and Shadow RAM regions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 8c2b63eef82bd5..a52b6044288975 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1953,7 +1953,7 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (offset + size >= nvm_size) {
> +	if (offset + size > nvm_size) {
>   		NL_SET_ERR_MSG_MOD(extack, "Cannot read beyond the region size");
>   		return -ERANGE;
>   	}

Thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
