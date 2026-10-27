Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793106954;
	b=L/ZNb+/L0QDIjeLAPxpqZUayoDvbIuJtJNc9kaokGIsg35dMdbPhZrJ+ZnA7QRRBD23S
	 P2rMCC6cERkWvlfMDGACbgm9RiuK2Z69PP3mcYSKjaLlJYKtCCavaN2JGdSNzINl2cO8W
	 bL3xZsqxSBYqu9TCwbGUvudPSB7VGSVhjlTkB9gHIX1H9IG2pmLS6Eqc6r8ftSK6S1erJ
	 WLXe4af8m3IBT05QtYmU7D6/ZphYouDf5mydq7qE1Lvww1f00AuaDeRKQ+2S2mrj+s8Er
	 b8YCviwdkglMBuhfrRGjYU4N/AVm9OxDkqV6UYQUq34XAxruQqQlq4jGkNN1Ns/BBSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106954;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=c+JKPGicZ9gqnwbkpriG8tCQLCGusGO1g6ksILnLDLM=;
	b=nIqQT6NkJ5Z618xVV9qu8yKhG4ll1cZ7IOfskS9/wGO5zWd84PPc3JJsxj0i5a1dseYi
	 eLeJLu2CERYlH0GniMLgApYcxehzwswGhKWjCYyUxYQ7uTSNxC7y5crdfjjYWOZ2V79aM
	 KhiCI0/AZBGeSuRwDCGKTmenz9YQtssWtPsT2utY1Xdi9AqR0783yEhwFrmNYuub5HFR/
	 5Oo1MY+cXswgrW59Z97B9bD9OhuzibIQbisjYXcgGMKPG/GDICl0AJges5VOPWTJ4eauR
	 vKoiCW2i4EiKg3N28ctNXcENTJhDG1rxfZrCKsxbK2UucQs1mL8EsS8EhTfnOtRKGwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=drUgBzaV;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229A606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4229A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=drUgBzaV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793106954; x=1824642954;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7Y0CoEpVurci3lroxnB9wDQqql0/c/vTeLjY0/87cBI=;
  b=drUgBzaVUn5zH4uhvziUCNOQZ9+IHDDyM07Smc3BK1UPVV2PMJJyPfp/
   AT1eU+b4xnU6nLWxKQPo4qeoOkNr572pPUk/x2GWw2w6aoh1AezgdwFRx
   QK5FEJeTKkBArI6xePpqSWTA4yrbWvEijASIwQsOvddCz/9uyiat6A0ou
   UcO66399en9e4VB6n0lGxbc9na7+dwWxnFXvG8oGFtyuwK9KS8pEjfd70
   IJSGRw7r8jJHu6ow9dsc1sfTa6wTm4AaE2xjsvcYCDvTOYA0OnTeh5oBs
   tyR4gkEIpEGas08HtBGY0A5clLFhTk0+aF5uEIIyxrSVZDZiL/tvtHK5N
   A==;
X-CSE-ConnectionGUID: v1S79y4PQcecWZubEeEl/w==
X-CSE-MsgGUID: merrz0wuRxefFgjQFColew==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1826956"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1826956"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:15:54 -0700
X-CSE-ConnectionGUID: BPqM/KXrSLO+pBU8TPfYiQ==
X-CSE-MsgGUID: 7iHsZckSQSKkWaQPWGEFfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4878642"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:15:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:15:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 06:15:53 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEOZYCz4s5oSDXBkjiv6pNlOG3LNh3keX4jFKWaj/KPTiX22vWjxJNZmlzw1iweJ7KGQGPUHAGAnBAaH7SIduFPfqPMW9rkbVCG6OITBxMiVJo8F9BkHtcSUbReIn5+1KWRtISkCUxtvCxXEGt6W9N28en7Za2vEcHssZSqqnN8gEoNTzM18E65XPlCwIM1+crNPfx9/FW4w2GPyxdKt3EH4eNifDRTBflMw/Y4cfdtZ0D+SpJXRWTx16BzBYg5/jJF5/FtHy5MLy5fu7J0xMpVQ5Fo1lGheMqvOz8scmH78icSec2/Iun0nY/+RELe+NdQEQCY3e4XPgkPI02/J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7M0sihg3j1jKotu1wgWW0mRLeqDR4B2JG9cIe0EHFc=;
 b=gsXN0IKOmBxAc35LfM7dRdH1wkBF81PVP1e8RgAyWQV6NVcZ6yqJKE/0kQOU5hHurxE7V1Lm7N9XlIL1RxUe5MM3ZGO6lktiAJMZIRX7pArqIiAf99kQVOt/RlYLsleJ2iSakcnuotc69aBDF2NzlVXJ5RNjxHN+lz04ePYhmuUXIXBlDQI4ZI7G9VOVZ18qfpfZH0Sq3MQAl+zOVy5U4Zwh9jTC/KDnhbkdH1y2BD8jc27kaGjLWjuNnLVHIlkqIbi1bhlhqfFYhxaP8jz12r/nbdbpXOknOSci+2hm4XpGG+RdLqtTVn6q0FQDv7sUe5JHTtEA9gka7OCG0H9ZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA3PR11MB9463.namprd11.prod.outlook.com
 (2603:10b6:806:45e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:15:48 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:15:48 +0000
Date: Tue, 27 Oct 2026 14:15:42 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Eric Dumazet <edumazet@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
Message-ID: <auCj/vK5BjeRbJw1@boxer>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-3-magnus.karlsson@intel.com>
 <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
 <CAJ8uoz2J5EbN++dts69BVJoAW8+T3bEtgHC-t3EtVtURQH-QWg@mail.gmail.com>
 <auCjwM+9Y0v+kg6v@boxer>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auCjwM+9Y0v+kg6v@boxer>
X-ClientProxiedBy: DU2PR04CA0243.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::8) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA3PR11MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 89113a9f-017a-45cf-540c-08df342c6a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|261026140227099003|4143699003|11063799006|56012099006|261026121527099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261009223027099003|261022115727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fgRn3SjWDtrou460zyxajEaSM2QEpJfNSmWzoYo1N0OyHFLUTIb32TBRDv4Zby1RKIXViiW+An1Owcv5CeEAK4xKh5y0LgnfE86Yh1J+hCYFIlOFnxylJksTD7DDQ2mVisEptmSh6KAZahlOElrMNsEbFtaSv4zV8V+srzAY1SIfeM1S+++dbv9XXVjIulGE8j7sinpVY28AWGxP+/MN1KG/X8IapVpbSjEFdfgU2h1KSPE82+9l9LGSsIUeZTRST0aVPA2xFCKxsGg+EMVr4N1NsuhHbs8i8pRshPw45USDrtz7iQanfgvufuIgulmxqFoEp1uKLEXU+NO/Vd+TvE2E2DbehREHsJM/A6MSyV/yOEhJuOpn3Mu0Eo0KFmtD2P5FfJW12BkR6WU3LqacxIEbPatn6IInXo+d+jM+nFl/f4C+Ee4F1DfuVWlcvNsHIftYZ39rAAZQZOoYBml7fejALQNag+b/O7zEBPswLtHZ3Uo3YXSE1+3udQPPFQ2dveDP8Zapl/2hCFnnqCyuaGILjMfHZ6I3OgjFzGEAKq8W+f/qJl35obu+AC1IM98dDFQHxm5BEcXnDjb5RpE/eKy3s9x37YXVZX2FCkpo6yUMAJEe40haJgS0WdrWgxT/KK+o1cNsO1gpDHf2PbU0/WF8BlHQbL3GFlIQx76BHZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261009223027099003)(261022115727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8In5fBkZIxD383WZG0EsjUAh6tRWx/Tm+N1GShlNURGPR0lpJro4YGPBNO?=
 =?iso-8859-1?Q?2vqKCzZTNN8ssn8lTLMTciD1mIGdqsjpgFp+q+r4DQwVgqBSC1YPdPtHip?=
 =?iso-8859-1?Q?l5zN8XnBgCJZao6RYOQgfTEhmTmLeypF9NuSGRtDusXZ0OiNoYfCpD1B2a?=
 =?iso-8859-1?Q?6naecI3KoK7IUTus4lJsDsucZRTADkBCeC/duXP0fDcTckfFrdjYirhTcL?=
 =?iso-8859-1?Q?q4eqJPgMahr4KIQVUzy4wdJz8o4PsNc0YbSBzO7wN82gW+hS1AU0ibZ0wB?=
 =?iso-8859-1?Q?DPJ94Z2wLZKzLE4p91Nhi8KiyrsI3+QQCVK7wz7tL74mTo4ju4oQCgWAF9?=
 =?iso-8859-1?Q?7JP8+T/2poxh7eO7PrJ+60+JBs+dyKUAMhjWlqhFw5EvMwoMYKNOQgYJSO?=
 =?iso-8859-1?Q?oyi1P1zkDICFhx+xK8yZDWIDdhKerGqz0uyM8STEa9AYEroI4pBOVvVzKR?=
 =?iso-8859-1?Q?4v/BOtenugbQhByx3/YVTy+E4rByTAKM32psdzANXMLqpcNpj5WAuTDFFp?=
 =?iso-8859-1?Q?W6WI0Sd2pdEwz4n3Jgj7xGROhBThOrnef4XaAoTtrvphFGvhg0JIi3o3Xz?=
 =?iso-8859-1?Q?JGB/2zIK2Jb6bJ9wUJ1A0kznTl3CONX3L4/Piph2J2SX2yJ23+kdIpI5k3?=
 =?iso-8859-1?Q?nM5d9uQQn1AU42qlVuT4EL6lBQDgQ+Lt2JBXjSy2tFqDKQcoq+Wq1Lwzev?=
 =?iso-8859-1?Q?JNL2lPtILqTi9sIZn3knncq6dJl0syjmi5Vr5hDv4vjiaROQECw0KLznsW?=
 =?iso-8859-1?Q?Ha73ys6RuWJOWVyWh+FgGTLvETw+gxJI2ZYDcLLnV1CPdtsr0VyTlogZ29?=
 =?iso-8859-1?Q?M79bArJIffWT7h/loRhEgFzm6PEbVJhpcM22ZEp87Sa7sP8XZ85ogOYpzz?=
 =?iso-8859-1?Q?GKNfz1dUjDSJO+CGWOs1RtobncqpB+T4u5y/kFam9w8Ns5hhkiD18lMrfV?=
 =?iso-8859-1?Q?jKpmx1a9siiON2aGxWcSrNQ+rDHmaxLHm3hAczsG1p8wJn1PbIs0fDs7At?=
 =?iso-8859-1?Q?gML/IolB1dBB/EDKHRSHY+yxWqiOfJeJ+wPXK1JjQj0zq5cuM3qR/5ui8O?=
 =?iso-8859-1?Q?cvfnz67blWSuCib/xAwQ28HGPMiNAYkN8lGXt/6dx5K9z7xBtcncbuLMZ5?=
 =?iso-8859-1?Q?y7H7q7LWPfmAxBX80dSuRqLLWTRZaJaiOUt+NADd1G2h0wd5+jL2C6NN/U?=
 =?iso-8859-1?Q?ReewR/95UDIvlWg4GITIFYGW5GfRH5NA/RvGnQLlNfAwbOE2WYmyrvSrHj?=
 =?iso-8859-1?Q?ZknR6vuoMRO4ptH99Wy9SLKtxhxsZO0aP8BHagbcigWWoc3VQT1RROzcaU?=
 =?iso-8859-1?Q?pFgfSzgNyg+Olro2qRaqCcLGB6pLCAxSdL5MbDBzgK9N+Rke46dfrT8wPB?=
 =?iso-8859-1?Q?MrR5HcElcotMiJt5FlZybHLx9BDy3kKzpJmSUy9/c2C8pddO5wtMZo7utD?=
 =?iso-8859-1?Q?1RaT4aECIdR8DIknMgd2VfrxRjnsPgdY0NgUFT1sgc0KM+FjIC1brPpWz4?=
 =?iso-8859-1?Q?RDfctjynM+1ACXkusaFqD03RvQvw5WGjUsr+TQtwecZjw2HLcuyot77Fbo?=
 =?iso-8859-1?Q?V2s3+996uY41sip/dshgmNr7G9lG+InGUFiuGelyIeQuJbJaDk5u7tZkX1?=
 =?iso-8859-1?Q?mmw6JTU3CoSrXAJt1T/hhZ1ueYpf+l4XePcUWJB6KLjVbDGRmbkpq+8JbW?=
 =?iso-8859-1?Q?5q9wVoE4LHkeC2vkzdtx11tET7p+DkQKXHAT38yyOHcS7G5v4xGZbl5SJ4?=
 =?iso-8859-1?Q?ySB8mBys8LcG5yi8McP5Z2DTkQnUjjUzLYAo1FbdwRGZlKq6mza+u2wdAY?=
 =?iso-8859-1?Q?TAUUXzk2GkIFojfT/nwtYe8kT80b0o4=3D?=
X-Exchange-RoutingPolicyChecked: ACybhmQP9Q16rJlPUT0oGPqsI5sjoQ7PMATflf3nLSE7fKmlsYN6lIBSq6rLq5oFT7vhnqqx+50GErzrORBIEDwHT7CuIGhKSCW7oGLKqyrp7XqBJog9SQePwaOfBZ2krD/RlTmcnC0v4Mc7zv/IAec8CO48oriwj5ZyektCq9MrNB6FKksORWGnzrZ+FZkQOte7moGaXo1ecCG9JAgkhbiiwqnjqPnZj0F8Kv6+i7OQAhIo/1qEbkARRPtBKXTaqzEhMr4CGI0vdnmmFJkCOQ3HUZnsCXqgxNkQd0zK0NL6CN6nW21qzWeRR0M8uUNQtKIarhiFsXOnAR+4LNcO0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89113a9f-017a-45cf-540c-08df342c6a92
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:15:48.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH5f8JmdoCoAYyVeLhdLUY38GMjWXN6w7LK7uvJLHFFlEAjjUfZe2VQ0FEHCjaSjqFniXpgH8cW/GpxsnzSYmfnzZqQ2zRWzGutUfKAzw94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9463
X-OriginatorOrg: intel.com

On Tue, Oct 27, 2026 at 02:14:40PM +0100, Maciej Fijalkowski wrote:
> On Tue, Oct 27, 2026 at 02:56:07PM +0200, Magnus Karlsson wrote:
> > On Tue, 27 Oct 2026 at 14:43, Eric Dumazet <edumazet@kernel.org> wrote:
> > >
> > > Le mar. 27 oct. 2026 à 13:15, Magnus Karlsson
> > > <magnus.karlsson@intel.com> a écrit :
> > > >
> > > > That USO works for 64-bit systems is just pure luck. Currently, the
> > > > computation of the UDP segmentation header is performed using sizeof()
> > > > a pointer instead of the sizeof() the UDP header that the pointer
> > > > points to. Since the UDP header happens to be 8 bytes long and a
> > > > pointer is 8 bytes long on a 64-bit system, this works on all those
> > > > systems. But no such luck for anyone using a 32-bit system as 8 bytes
> > > > != 4 bytes. So fix this by using sizeof() the UDP header that the
> > > > pointer points to instead.
> > > >
> > > > This was found by an LLM while implementing something else that used USO.
> > > >
> > > > Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
> > >
> > > Missing prefix? This was really:
> > >
> > > Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")
> > 
> > You are correct on both accounts/patches. Do not know why I missed this, sorry.
> > 
> > Do you want a v2 with this added?
> 
> Current policy is that you need to wait 24h with posting next revisions.
> Eric marked it as 'changes requested' so yes, you need a v2.
> 
> You can add my review tag as well, thanks for auditing intel drivers
> against this bug.

Also I believe currently we should not CC netdev on iwl submissions.
Przemek, Tony, correct me if I'm wrong.

> 
> MF
> 
> > 
> > > Other than this,
> > > Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> > >
> > > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > > > index 8982cf75466f..2c290d7788d2 100644
> > > > --- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > > > +++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
> > > > @@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u8 *hdr_len,
> > > >                 csum_replace_by_diff(&l4.udp->check,
> > > >                                      (__force __wsum)htonl(paylen));
> > > >                 /* compute length of UDP segmentation header */
> > > > -               *hdr_len = (u8)sizeof(l4.udp) + l4_offset;
> > > > +               *hdr_len = sizeof(*l4.udp) + l4_offset;
> > > >         } else {
> > > >                 csum_replace_by_diff(&l4.tcp->check,
> > > >                                      (__force __wsum)htonl(paylen));
> > > > --
> > > > 2.38.1
> > > >
