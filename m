Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AEF3B47F0
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322355; cv=fail; b=CvDBChDNEiOd50eFXDPwGQrz1rLxNDrX+jKdQCP+KrxNqJy/D6XtLMCg9Huj32Ke+1MtU9K062rUJAdU2VFonSKuLhC0ge9UEqIpA4N/QTLYplwg5GQXHT/Ci3TaLpc2C5nclRbGeNwD8fbbohPY5/w37p1ppk7SkdSvtMLAevY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322355; c=relaxed/simple;
	bh=5wY3mS5mCsp4qRCFTwKcdC0lAjTIdn9XcaKr2cF4j7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I1CtTkva7Td1phW3EJ9NLHGBpzj3viR2TPFhCqd6sL6d4EzLx8eptUyEiDqNm4bYqZ0Qfu6g9kfqv08rZG7TomxrGQV9yB9K5tx0s24snEgDntxI9R5UceOQ2jJ6apyVKgxI7KDfmfw6aaFI3qUW4WH8gBh0RgfMdsLrwzJfyOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9E9JxKu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9E9JxKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791322353; x=1822858353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5wY3mS5mCsp4qRCFTwKcdC0lAjTIdn9XcaKr2cF4j7c=;
  b=Z9E9JxKuJFsKRSDDAJhoYhlxf62BN5ur6i2YN9GB92+KNnmxxmbj+vmo
   0m0ufet3G1ARG+YYW8Rblm9bYAafeS3r6jeygB/uzV9Ul6oyzqrl36wse
   JkR7bdaaY1x8gKbJV6nosg9560c4NwiDfAM7i6cxW5d53XMPiD+Jpk6Q+
   WPM/uDQ2kQO7yk1TICd2NYWtUOcBHRR3eeOvnGuZ+qjBgEjoRbpXM4JJn
   SaBf+EWqIMIEiU1rkzGTrvOBCJXuM4VF4IvIdXC2NaKzW7iaTYLCZ1vyL
   /jeodLUFp5+xBesy59hY0Ndv+8Xaa+ux8MEU5xKYywONS7xK4n91CoRrT
   g==;
X-CSE-ConnectionGUID: Mi/VBPjoRQqfEv6P/b5giQ==
X-CSE-MsgGUID: Cc0J1Oq+SJ+tMHx1AARw7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="179146"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="179146"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:32:33 -0700
X-CSE-ConnectionGUID: O88+9qtMTWedahbC3+Qi+w==
X-CSE-MsgGUID: vjnKGy0nQP2LESlNZYjTcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1288695"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:32:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:32:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 14:32:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjgNkAZdueEacbXP2hHKzzFZcNjf2qk2g7walvWPykW8DXfGQb3ATEMuCeJ6XCHiF+D9EgV59j9Dgjjtb4lu6pkeMaGGCBFFbfQQjlXY5G377HwlNCB/P+Q811ykRFU8XfFGf6G9LItg2XvOg/ybL9D+vH4JFOzjgMw9dSy86am4FSerz8MirONj4u3POKNwmSoSXurQYS0YAbgNyuFLp0Vm1bUqw7Y7PnhI9FLGm25iwdOsngXHdqGEgddJWSlHop3HFb9bWDq6ADZFr8qTqOSBoAT2iaPqMU8RiBuZUZ5EBsSC6LNEz1C+UoJ5jYLfyYk96EPnmiqLoT1NTcBwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhugeKS8oAajeZDg19lvolNnYrpCBHL6PBnV4BvUq0E=;
 b=R6VTG35clHxlmm/W97EFne4tlCSvwoEGCO5lN4UJ7S+pBTbIqKP1lBqDI/Tlbtl5jZlZ7JulO6esbvdr9D78a6yOkXIXpkcIaltdorBYemG1EdV7ZvOV5iroSrvR/JNYYUS+G9Tl9lKxeJEUEtXr58Fe6mW/dFI+KRPcUd4ZxHWc+OpIG0b+c8xsaxtQWgWl992ziLKy+grd7iKOG31/0oDqXOY6AnbNqkS34B50+2oxtl1EXnJlcxJclaTJosn3JTOuL8dScQ/EnvDnl7wJ7BLU2wvtmbUVxDUuSNoeqb2S0p825jePeFEzVzqVCXBZc0IieV4JXtFdB78o1u9MDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA3PR11MB186312.namprd11.prod.outlook.com (2603:10b6:806:595::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 21:32:31 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 21:32:31 +0000
Message-ID: <56ce594b-bb5a-49f7-a55f-e0c14bf8a2e0@intel.com>
Date: Tue, 6 Oct 2026 14:32:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/3] bnxt_en: PCIe FLR/AER fixes
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <joe@dama.to>
References: <20261005204246.3822563-1-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261005204246.3822563-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:303:83::24) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA3PR11MB186312:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4001c1-3d63-45d8-d52a-08df23f153d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Q6WsQszfnNucT+afAQ/ARSeEvUxICNhs3r/gEzHn+H1NJh4Kwc3JsFVb+ygDk4lDV7/T0y4LgYcc9wYj54/RfZXqWSx+4fkfZjlNGI1AGzbuGuAkaE3C2eYNzJDFeGHsirSRmt1EWT2etn6PatO5lUK/z2KxqT2/0pPRXaUACa+GR4YsRuamArkZnicTK+FsatdIlD2LcoFcnLjkJScGtnQEoJw84qR6D6rOB/s4ZVJdqsIJH7bEi2x4ycs1Z6hKSB6Nx/24nv2Oluw/RGYpgIvxn4/V2LBmtqTCHiGJZvCLAO/GsbdJ2j1pR3eHO5dCpMh1KdJl7LAekQbQoPsl1NB8dgxpTR/wrRGnO9eBNm/ucvG9HOGkRIWAjB67erjnUcRWLD+9la//Oc5EW9gAKOP1SmTBlcagf63GUHOJbGZOkeZ1AoScy9699S96Og+UrfMyZuKwWyhSwU0j6QTifGf1dBvZgSuNLTYI3zDk2vQeyPLtsy7QdcaDJDGkB82+SYZb3Jeu/Ar0CfqNVpN6ftKuMJUafs0UDT58DT1E6LSb3IQMfmJ1e47jtw5kGbm0I6OGKq5YDs9CkZs5GOsE//CMr7AMNAjL8zChZIbwylkNA9QHF2ZKUo1hFvGPqY0PFr6JGtbxLCx1fzWrW1h4B7IPJUoHj2v3+aSLnEMEnZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklhZEY1eVdBS09sMi9waUVJY05sZTlQQnJWYisyVllNZFRUajZPdFl1eU10?=
 =?utf-8?B?cWdNL1g1djNRcU91dFNYbEY5VUJuZm1hdGN6NjFDK0E5YVdXS2wzbkxtOFN5?=
 =?utf-8?B?QmFkQUNuTGdGZXlLcmQ5ZXJ1d01kK1IvVmp2U0hFMkJWU2dndWQvSkJlMnpO?=
 =?utf-8?B?NG0vUXZObTBoMUQwNkg4M2x5U3VJSm9uQ25ySDNaZlpoWlVwSUp5Mzh3aFE5?=
 =?utf-8?B?a3E5L3F4cEpndmxoSWkyVis1S2x6Q050SVliQXp6L1FBNUlTZkJURnZOMVBI?=
 =?utf-8?B?TmxHUngwM25CQTZSalJtQWxQcmErQ05DTlg3dGxDUTU2YkZ3RXAyR2t1bzZy?=
 =?utf-8?B?MHZ2RXk0eGFHRzkvOUozb1p6TlRHdm1uVmlTcnJWQ1dRTnZpNUtxaUFla0o4?=
 =?utf-8?B?YiszbWVPVVozUzlPM2prdFBZbmNJdWJpcEp4dE9kcFo4d0JQV1N6QVBjNlNN?=
 =?utf-8?B?ckdPUWpTK3lDSEgyOGdycGkyWnQ5NWZkenVTLzNtRTNnaWRWTEM4a0V2NDFF?=
 =?utf-8?B?d3dWS05vYUlyUGErSXRTVlRXeXZJcEdmSk5Ja1cvSHhIUm5CenU2Rm92bDBW?=
 =?utf-8?B?S0h0eHB1bjBkNmxCUlBEemJRdWxZZVMvMDJ2OGZQVUlNM09VTTdpbDNPdXVr?=
 =?utf-8?B?STg2TFgyeWR3a05Fd0ZqbmlXdk5LY21ZQmRPNWV0bVpCWUZoNWt0OEdXWFgv?=
 =?utf-8?B?QzJ6V29xQnU3citteFo3dyt3YU5Yd05PdE5YWGNGZklMWC9GQmdldmllTk5k?=
 =?utf-8?B?MlBKWkFjUG1qUWdHVlBtU01KZGxnRmJlRStPbFZSMktoSXlWZzZRcVoxV2RZ?=
 =?utf-8?B?Zm1NM3poZ0VtZVppMUR0akNuY0M0bUtpb0NKVTJjd0pTNUxiTWxaYW1Cdzhl?=
 =?utf-8?B?WWlBN3FFbGoyREhibUVzaDgrNkN0L3I1NUlHS3hzSFBhNUlQdnAvRmRuaFp3?=
 =?utf-8?B?ZE1tMWVnUzVianBmT3NreFBBM05FQVNJcVBnSnl2VjlzaDZUWERCUE5oVXRo?=
 =?utf-8?B?M3Q0WUtYNFArT0JkKzg4TXpLOExOUnlyaG1oZzM1RW8yaFFrYUFOTWJSbzZz?=
 =?utf-8?B?Ym1uMFIrMTNsK1NpSXlMa0xtY2o2TXdYNndUNXFaTndTVis1TXNZMlFVWi9B?=
 =?utf-8?B?N0U1V0pyeFdiWk90RzhBd2Y5dlVKYXpjYko2U0c1dFpPTFJIS3hpbS9zNDV4?=
 =?utf-8?B?K3Nxd0hPQndpbXQrQU9xM20rQm5CZUtwWHNaYTM5VmtqUTZXNHByRzhIN3BU?=
 =?utf-8?B?UTE1bmxJREdFU3liTW5ackY3SEowK200QXMyWHlXb1c0SmJ5L25TL2EraGJp?=
 =?utf-8?B?ZjJrUUE3bVp1LzJTdjY4eFhqbzdkOHdRS3JlTHNTNDVoTGhWZjhnejZKeTQ5?=
 =?utf-8?B?UmJWaEdubEJraFhIT3E5Q3BNWUxpV3Q3UGpudnU1Z0JRR3VQbFk4NGlPUzhz?=
 =?utf-8?B?dHBHb041TGIxYnVPNTRJM24zTzhITVF6cVQ0eHdFNkNPVWhGQ1dJb3krTE53?=
 =?utf-8?B?V29XZVY5b2l1L2FmdXVFYnhZb0Q2UDVCeDlmbzJMcUJFWGg3ZmFFakUxN3Ex?=
 =?utf-8?B?ZFBCSm1oSmxMUHIwN2IrUGNucXVMQ0RLZWtYZGU4UDhTN0ZwbDduTVNlby84?=
 =?utf-8?B?NGt2WTJjM0E0OEI5THFNMXA1cm5SaHk5R2tKdnpjZms0aHM1Ym9DSzVlYnds?=
 =?utf-8?B?L0ZCSms0eHp5Y2lwblg4K1Z2dFNjNEdMOXR1eTFaUHVVbm82KzZOZjl1ODFz?=
 =?utf-8?B?TlRvZ1hjL3FvbnlaN0k2Y3ByME0rL1F2eWs1SUhzUkI2Ym9RazAyNzV3cUl0?=
 =?utf-8?B?SnVEZHZ2YkNvcHdPM0dldW0vV3pCVGZOeldYMkpJSUpWaVRnZ2tSeTRBVnRv?=
 =?utf-8?B?amtKMVpsczgvaENud05VSFNaSGphRmMwTEx2TVRjaWYwVzJSZXpIUUx1NDhY?=
 =?utf-8?B?eVA4SURGUEVsN3JiUFZxT0hsamM3bnBnN3FBZlhvRWoySFJOZzh2WVFyYnE3?=
 =?utf-8?B?RHFwZHVSWmtGczh3YlZnR3VBaGVwK1plV1ZqK2VMYWErN21IWHFjVnBLbHBM?=
 =?utf-8?B?QWpkWHIweE1NMldiWkVTZmJhTThxbVpQZkxVVDJySVJiYU5SWDFsOUpSek05?=
 =?utf-8?B?dlpRVWt5d2htKzBzaTQ0UkJFWjBCTCtPbEd6S1dERS9TMVZvTDZlTUk4Z2hv?=
 =?utf-8?B?NTdUL3l3V0kyQXRnY3lnbjk2R2I3amdYUXBxaUwvZ0ozRmR5NUZienB6MnJk?=
 =?utf-8?B?QnZWbFpTVkZORnZrbFNhaXNVZUgvTXQ4WFFRRlg2NHBWc2FkWnI0a0o2Mm1G?=
 =?utf-8?B?dG9vNlpXT2g3RXpnakx2R210OVRGYUNzbjYzNmU4ZElYdlFEZFE5NFpsbTA4?=
 =?utf-8?Q?XfnL8A+q9ZAxhxno=3D?=
X-Exchange-RoutingPolicyChecked: tEtqnKsFHC/3D3ATXLwku20emhckwjNkDIV4NGr1hvxXbyMt33AZpwYqyB+ID1eATiXlEBnedc9aYAhxdDdC2IukSKag2zv2uu1H6Qn2A88RCqNVP5+JwX+YX+7oeII5O3bN9LGDOIGckw8W28G7vieMk0fgQP7uNnDX91NE4K7OqQOwwXNMj+tTKFmeAIYUczO69uYTn0ahOp0D85EYUTHg2PuIc4bb/zs59Ay4L0hALGpvQmVvwU3lYJm28sm4rf5fYtPTJCVDFpxtiCm8Oc4lAdHaZ4sxjHGqxbDHpNIfKohO0nqIp5F2BBshSvXA6ut3G9A0NzeyLLh8egZ1Vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4001c1-3d63-45d8-d52a-08df23f153d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:32:31.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxFlruSjQ7tPmtKgsM7DBjfKPzQxW9lrj5qIVv2482n5jIApT4k+ydAyaVzRW8lh1dLWP2l31bVc/N2w/H5TyiHeggtgK3uuW9DqY2c6kEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB186312
X-OriginatorOrg: intel.com

On 10/5/2026 1:42 PM, Michael Chan wrote:
> This patchset is split from the earlier 9-patch series to limit the
> fixes to the PCIe FLR/AER issues only (patches 7 to 9).  The other
> fixes (patches 1 to 6) will be sent to net-next separately.
> 
> The 1st patch is unchanged since v1.  It refactors a bnxt_clear_bars()
> helper needed by patch 2 and 3.  Patch 2 fixes an issue during driver
> init.  in the kdump kernel on a Dell system with a smart PCIe switch
> upstream from the NIC.  Patch 3 fixes an issue in the AER code path for
> non-fatal errors found by a partner.
> 
> These patches have been regression tested on Broadcom 5750X and 5760X
> NICs running 237.x.x.x production FW.
> 
> v3:
> Only include the 3 PCIe FLR/AER fixes.
> Updated to address some more Sashiko comments.
> 

The unconditional sleeps are a bit annoying, but given what you
described (and that they preexist this series and are simply expanded to
cover more cases) it makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> v2:
> Updated to address some Sashiko comments.
> 
> https://lore.kernel.org/netdev/20260928041712.3467803-1-michael.chan@broadcom.com/
> 
> v1:
> https://lore.kernel.org/netdev/20260831024342.2161156-1-michael.chan@broadcom.com/
> 
> Michael Chan (2):
>   bnxt_en: Add bnxt_clear_bars() helper
>   bnxt_en: Fix driver init in kdump kernel
> 
> Pavan Chebbi (1):
>   bnxt_en: Re-write the BARs following any type of PCIe errors
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 164 ++++++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   1 -
>  2 files changed, 108 insertions(+), 57 deletions(-)
> 

