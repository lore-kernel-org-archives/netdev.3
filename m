Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792518170;
	b=dSGT+uYe9ANC8mcdcJarsqbt49hA3IbhHwUhERQTxxXNXBfsLtY0OhCD9oS4TIvORaOO
	 ai9y1cGTUhjEEISGZTRvaPkIGm05SWGQju4obM7Jo1ckQY2yjGxYiicriZ4X5Yv8pk+97
	 BDISuBLJipJ63n23OLnAAq4/eRMcw+QQ5NPcf1z/Kekjz8KOWmXM0aUpJMxCWBMaIHlAW
	 wodYSFWqVyuQSI8bIB+/VlACXtr3kY4eE4736ed679FKORE29LQodxbUDEVP1eA31UGup
	 e09F4QRdBxsrV/904OCT3hY6s1wooF46OnsHx778lrypqKKcvS6mtDwkZEUEOcyev7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518170;
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
	bh=ajqzsSTEWOcOGniVTLc8ADnkBtt2QNFtU8oJaSChRzw=;
	b=ojX3XXjjmyAAT/SHzX7hypA0QSyzmWMokfMeAFpPUiemwv3928VTG5A2rSzW4Gn3m4py
	 hIsElrtp3GXPVnzditoSilt65Y4LBGuDHYfQ6Pb9hFmLNLIJHukGmvWes2lx4jBpa66EK
	 0cJ53OOOYrheADI+h3QSnqzTk7Evr2CUcb7hl261zzx6gq3xxg055Ry/o+Q30r1ljEPyh
	 Geb10QL2xs+qWxuJaKRPro7JBiXl4WHkDMZgkf1qXnhQEsIfiakxa5yK2mV89qeCIyURF
	 7EWu2Kg9XAOK0ej04//4RhRGEdI89DB4BSuf6ltQZBRh2QBcyV5lkHPoC69PYE1eKKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hkjWU6S0;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2F606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EF2F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hkjWU6S0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792518169; x=1824054169;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8gvndSyVfsX76LD8DgQcav10lpsvSUgav35SMiohW9M=;
  b=hkjWU6S01BTbXXarXqSHQLggWaTYravNc0tQIWbTrPBNWEmuCztvWW6q
   O6GhJcny7BU1axX0jcWGkwDZgwyfLQhhQek4ZKMAUofh3KjGyveRXGEns
   P1mjvUZjpZE43dFyIZErNvj09cxkK/fb0FA9pMQ7U2pDgSSE9+EB5nBN/
   w9VZ5CY7Pkg+aZ3HLok25ly8SFuheCaCU7DAfmG8eBmdsxmr/jMSJtYNK
   T/WDVqe3fV7mobxtyaEbqv2G/oyYB2wP5IUGlXrFqrA/hRDXZV8k9Y7WS
   aaTzOYTkpcfPy9Jp3ZX1GtU/dQLHP20a16w0qADVVgMWAdL0pM6NGggv7
   g==;
X-CSE-ConnectionGUID: OyfQ/56USR2XJJuJPxQjyA==
X-CSE-MsgGUID: I/42Q/n2ScCz509ktKCoWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1118904"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1118904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:42:49 -0700
X-CSE-ConnectionGUID: hFrdHM9WS3+gJpkPCbJPnA==
X-CSE-MsgGUID: LghoOUGSReK7EGBE00jvlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3180927"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:42:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 10:42:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 10:42:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 10:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZEPG/R/hr5aPuQE58EQ5VfkSUtuFEE5gsebHcfg2EGGg0fHOjV7TDKl2u+6EzqtOG9R1s0zX+TNx04LblWF9tLio3SjlIRWP1OiMiXUskue0oM0Eza4lt42/akq1/9if2hqHvMNlANW6KNCfY+1gQyywQmLXVcmK8knMXZnGvHvvp4jnnX/iCVwsaHUyy7/rA2RCkwS/hpRqLPka9Le6lR0qynoZNEhJQBI6wYzungQTf24oOdOT+2Lom0p2TDFb0ZNVV6FQ7ix3mtj/m5X/LD0VoijpfmxtYQTrB+lZYEQVrUc+iTQNVsrFUH1pS8auE/CGddjwDsJhFzFWLbwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajqzsSTEWOcOGniVTLc8ADnkBtt2QNFtU8oJaSChRzw=;
 b=NxDqGx975zf4BxV+GSwtfrJgVkBhuN7zPSe7ufvEF6gkqb4RN/D23kQykmjsUgxomurTBE6VBASdvcvxl2Hh9x/YuKbgHiTWLevifIm6BmeU/ddBXuiGGgEuzscEB8LlLmRmxw/TT+tL+ZqaSBcHsr6TY5VDesdw2JEG6x5Wqty01sS23+XIJO6jhywYvbz3/7T0J3fQd2b5sgmaYxKPe1o1R2a8K21TjUXPo0IHVdn7PyxoCjPHFxsdMqGiPWVZVA2JvWN9iMVlvDOUaZNw6bu4lgxyp6GomB2JkSNRJ5oPMfDDtXCJkEN1zGjCUeOsU5CWIRh52xNU4O24yXcFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 20 Oct
 2026 17:42:45 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 17:42:45 +0000
Message-ID: <53dbe7c2-3027-4dcb-99da-ce13b4a22c11@intel.com>
Date: Tue, 20 Oct 2026 10:42:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v4 00/13] ice: E82x: timestamp processing logic
 fixes
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Grzegorz Nitka <grzegorz.nitka@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Nowlin
	<alexander.nowlin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261020-jk-e825c-timestamp-processing-logic-fixes-srcu-v4-0-3e30fc9adc73@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:303:dd::22) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: dadb7d19-6553-42a2-deb2-08df2ed18c58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: yIRZwL02A3Snrj5wD0vwKsVq8PnSA/M/YwDqoUqTb9TKrYNLTZ+JawbJhVgJO8g+3gNuPaY2cJaKa7r2WECNlvvulwgYWQsnPGhH3D/L/9B294usi/bwJ7lvbbav8b8AkttK2a5FgxqlTVYBcZB0YNT9B5oqL5yf7biVmYR9R5WhIZFquK2Zw7pV6KpZygCJ19ehtIMPGxVQqzBqdPktvZEkFkDyBZRgRyGsSr+Po7YSO4TF0F1eUu1aftyUe3KXhiC0Gr7SBsZcsSRt7DWjlbto8aQWsyrF2fgyKoSFO12iwKi+zUpQ/TtxMIFOD6xfUu8OvVkqNJysrRX2oxCW9nvvtY0AmYMndrkJYkKUkC+Kb2WECU5ZdkXsnVS1bS0q1imHxBll3iNdP0Lq8BTXaxMo3Cjl1enYy405lew1cwnVuhla7U2fiXtf9KSDwlDLI8BPNk/a2WmQHO/QjqifHtBoiDAO9rHjVKWQUAH1MXUquprk1l7tfKUT38G6dg2YMW2EpkEKnfYEANfBIMAs6SrCL1liE18llRwajATfqPDETR6GHFOdnfrK18+1KtKIBCNXw4BiGixRr2GBRrvUEFBWlvLPtSK1UKd0Y44RIiL/FqqMabjWTDVuGlDhRQ9yzhgoAKz3A9ixhwBfuQOlFduHL4fxTw2FR7paGojJeN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXUxRUFWOHBUQlFjWCsrZE4wNnY3dWdXK01Ea2wyTUVYZWp3eDlOZDBoVEU3?=
 =?utf-8?B?UTI4Vnd4TWJ5c3JWTFVjemZwNnc5b09rUVZYU2tlSVFadVRwYStoTzhOei9O?=
 =?utf-8?B?aVFyLy9hRWtxR0V1bnc1UzdlOTc0WjRaakpmajhHR3RjeGFRWU9uQ3M3d1h1?=
 =?utf-8?B?eXBEaGdOWjJBN256MFJQeXBhRVRnZWMwSGtrT1lSb2RHVE1ORFNGWTdhU3c2?=
 =?utf-8?B?SVQzazVha0tWSnd4ZmJKVXNYdVZRdWFncDhaeU56OUdzVnhtamRobVpQR3ZQ?=
 =?utf-8?B?bXNpbG9hMnVSQWlEU1FBMVJseE9wQkdKeHdOajJoRFR1TXpRdEJDZm5XRW9n?=
 =?utf-8?B?SVNiZWRVMmJmZWtnWGtndTZVZjAveHJnUXhVbFZ2eXpkMHRaaTd6VDBQcVBB?=
 =?utf-8?B?cmU3ZnQ2QXNlaVpsUGt0UlRrVHVha3JBcU14TjFJbGtYL0VHQlltUlhYMVNB?=
 =?utf-8?B?eXo0VXpoNWRIRlJ3bi9GYTRpS1I0ajNMUVYzN04yU2VtRjRKYlZVOHhxYVJL?=
 =?utf-8?B?UHlKYnUzZG16cDVJdGdkbnhHclJOcUhXSGs1eWphRGR0QkN0cGFuenlTNHVm?=
 =?utf-8?B?SWU0d3k5RnhqVTIybW16RnZmSHBGelBQeDk4dHZCQ1NoUlUzanU2R2dOR2F6?=
 =?utf-8?B?QWQwb3ZpU0daUG4vRFBGL21zU0hIcndVN0FNelUyd25JYSt0REJVUGlFSitJ?=
 =?utf-8?B?aUY3QzJEK1Q0NXpBN05CbWpQbmFvaGpKZ1V2azNOVzR5MTZtNy9oeEtBM3Mx?=
 =?utf-8?B?Z21hV2RzTllDZUVPTTZuMWFIS0dZSzlOVlZXSEIrYVBERzlCWHEzTWEvc3Z0?=
 =?utf-8?B?QUhGakZEMFE4RHY5U1pIbjBKaVpReWFFRzZXNitnSWdDZ2g1MExsOVRRSGpy?=
 =?utf-8?B?R3R6QkNCN2xzQ1BUQVB3WGxxYWVpd0ovL25ybFNUMHQyTVpocnhXc3lLSm1w?=
 =?utf-8?B?TnFhdFh1eE91UWFaM2NzTG1uUzVYUFFzTUd1R3hLVW45Z0tVUjJDMzlrRWxp?=
 =?utf-8?B?YmhZWlVTVmFmZ0lWRnpzL3d4VHlrdzByUGtuYlM0djBKdnpiZXVNUTI2ZUFQ?=
 =?utf-8?B?U2Jpa1ZLVE9OYjJBSzErMzZUNEk0M2hoUVl3UEJFajRtS3RJRmtvT2hJYldx?=
 =?utf-8?B?SUVDTVRlR3RmVVplTVJEUThud3JIZVV5cGpXblgzNW85RVl0RzY2N0o0MEd0?=
 =?utf-8?B?eE5Cdm9LMm5pb3FocWpVT2xyRndJdnBwUXBJYjlZQVBJY1V0c0YvVk80aUQ2?=
 =?utf-8?B?M1I3SmNIbFFrSWsxOXUwNFdOcU1icFNoUWhnWmNLMEpVeXFucXpSY1NORUk3?=
 =?utf-8?B?QmorR2tmYUlONitpZ1ZsUFBWMVdmWG9DY0VjMWQzK3hiTUd2MDdpNFhsN1cx?=
 =?utf-8?B?MGJhNEJuK0FkbEJiaFJ4V1lMaFdBRXpDMkNGV1BtUXJ1Q2UwNkpIRlJjM3Iw?=
 =?utf-8?B?NksvOW0xdnRHU2JrVHMxK05pMzdwakZPT3QzL3R4Z0F0Vnp6WExFNFBRbldy?=
 =?utf-8?B?M0ZvMGJjM2pwSE12ZFJONHdLVVdZUFV0L2lOcHN2U1JjOXduTHh0cllnNGlF?=
 =?utf-8?B?c3dxeDFGNWIvUHFwNlFyQ3ZsWnNLUWpUMWxDQmo1Vy84eGFlZVdtbStYRXh4?=
 =?utf-8?B?S2xXSFZIb0lMQStRZVFOcVlkT3lMODdUR244blZwNHlRNHVOTzkvYmYwN084?=
 =?utf-8?B?Rmg2N2ZLZ0xRbitLN2tHUnFWajFwNTRQc1RjdVhnWFMwcWduT3IrbktQWmNj?=
 =?utf-8?B?MmMxbWNjekF4MmJMVlk3VFh4cUZ4Q3VjUFVDVXJseFhRcFVqOUYyWE91cFQy?=
 =?utf-8?B?eWE1NFNTVkNZT1BZRXhlRXllTE1KeEdGZkxLWXNaY21mc1YvT1cwcjFvUFBa?=
 =?utf-8?B?eDBUbWFiV25yeXJaUW05Vzd6T2J5dloyb3VaNFpENWFKb1Q3SjloVlpEZHlY?=
 =?utf-8?B?bUQxa1lzMkoyUEp0aDVPZXlyQTZpWkpMN3pOTWxyZ1FPempOQXp5TWM4U3ZI?=
 =?utf-8?B?STBFNnFVZnhNSXBGOStodTFJYVJJMzlNSk9WZm8xNFlqanFmVnlIbUwxQ2NP?=
 =?utf-8?B?Q21QdWpXTXNsNlVucldTWHB2L3JUOHBFM0xydmtPWWdXZDJFRGtRV201akxZ?=
 =?utf-8?B?NGZKbnNtZmQzTDNqY2JxTzZuNlhaajVWR0doeGdwN2ZyQllTR1JtTTdiN3Yy?=
 =?utf-8?B?YXBibytrUXZMVThycU1SczYraEwxdUZxcVBWRWlDMlRwT1d5akJnSzlIVVEv?=
 =?utf-8?B?KzEveEZVWTU0RHNEOU1ZaUlCLzRSNjFhaVdRWm9oR1BVZnpVN1lyak5JZnRX?=
 =?utf-8?B?T045bTZPMDYxaHJ4aDJvcnRMVmpNUzRuZUsvMUdFUkhXa3VTR1g1ZjhNejhZ?=
 =?utf-8?Q?2+ebbOEsEx7Egq70=3D?=
X-Exchange-RoutingPolicyChecked: QlpwHU3MRYw7TSIftUUabFOfUfHWL21NGkmzolDhRw69ngMsAbQrHKcfh+/V0pTFmyzbVh2eGFWMZ7TLhSEhbQ33WOeCWzCrsqXIFivel/NAkacmH0uGJXK31dmDphHAfcLJNK/jew9RFdqKEldEMaX8S9uku3EJ/21NV3BC/ipiCYs+hH/njURdt32srJ71eKlxWh/rjgxutQVhbwv0/CqPOkNYGqKoNTSQmzjciNFR7wLjpwrTiG/UVC8a3L54aq7g7IlKwCCjxcfAi3hSHrdqL/zQSd3Xq6ngapavq1jsCIbkNZXgu1LqYmuAa9gnWGShr6Nz/2eRSqkvWxnjSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dadb7d19-6553-42a2-deb2-08df2ed18c58
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:42:44.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PalyQyH6tNGKCpsLrf1POyZdSP/EtuWY/js7J4reVgfGOVnWzh6vt8+EPNUjGzoMP2APwPMAS6sK86cw4wNosveu+eDUQKn669oA9OKt7Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
X-OriginatorOrg: intel.com

On 10/20/2026 2:45 AM, Jacob Keller wrote:
> Jake Keller says:
> 

Ugh. I forgot to edit the subject prefix on my b4 series when I respun
for submitting to netdev while I am covering for Tony. I assume I should
still wait 24hrs before sending again to fix that?
