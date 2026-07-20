Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50943DA35;
	Mon, 20 Jul 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564684; cv=fail; b=aSRP3G2dsYmjmHEtCgrqUU/FwNonyvn57Y2CIFSIgGP55zm6wXzLm/rk7R0WjfRy/duJfaQMRGw9QzF/gi5cTFO5YTcLQxdNbnqZ085kOXUdarLjVWXuG8dOH1Bxu1UBlZULndcYljoLxi78sbnS3mPb2JUGNmJKi5r3FUn3Dyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564684; c=relaxed/simple;
	bh=imGRy7Pmt94Ych/2Jho1mJlCPSeGvGsQS659fJuMzas=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1T/pnx+x+HZKAz6gHzSl1YzSEdJ5QfcIqftyOn/8LYX9juDvcXyUa648gc9VMcnSth2Nx89RqdG79bkUB1fMYj+jveiWn1gFchISTDMD/SA90TJT+bu9UNFmtcn+w0edQ0pCMJJq9bkrJOvVOpZki+EZvdwX7e9pgQswl70SoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ne7ZuqiJ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ne7ZuqiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564677; x=1816100677;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=imGRy7Pmt94Ych/2Jho1mJlCPSeGvGsQS659fJuMzas=;
  b=Ne7ZuqiJIRJDKe90ThZiOjCoR0rJ6JCbpG2YFgQY+l6YwCu3qMffoQUz
   jtZ3D0pI0JwlUJX3YV6ISO1JSRrLz1RaO3LUlQ7Eq0TqlPUh9i49kvxuP
   uastA7L/fNqf5GVLmh8KqJpBkxjulRlLKjJHQ6WmH4yTWj7byMWsWP6S1
   xWOFsgtk6qxTpYCPUuiiLwUeBgQHV+IXCFFlIPTa1MCRRHbMF5RaZmkKl
   VahRUBawb+lRcN7aNEFCorfb0KSx8eUeM0oqcO3vbW+csg22gejicv6qJ
   QTmADtaLqlUY1emKOJKCFoF8pV7x5gHo0K6HfvlgU4i8+MRDnI00kaCSR
   A==;
X-CSE-ConnectionGUID: QD6nCXHAQW2T6lldbEMVVQ==
X-CSE-MsgGUID: bt6nDUs6TLW4yEnK8wbLnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87689612"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87689612"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:31 -0700
X-CSE-ConnectionGUID: IBAXl8JdRPGJq3khicLBUw==
X-CSE-MsgGUID: 6Y/Y9UO/T9aYBl7j1txVQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257560647"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:24:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:24:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.21)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:24:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6v4SSC9q+7No4xAykziOswz9s92KzD+yz3rYaf7Xt382V2pt7S34q7+BVntbiApZaCDyxH82aN5kyaHu9hu2uLc/2+DudNRLRmPYLQzLUHpXhVEws8l+BfmC0fsK0EAI0JAwd4FXhZyvqUQi9ZSrq40aVurWUdWVgezJyRPn8if+yJ2ypeBuycShUv3i6lq6DWMf++szIehRCFdzOtRyMb3VSgo80QW1BUBnQEare7aUqJsB5N8wpJvAh/SNfaIxowAL7iLRM1IV+NmsRYaVCzjfWS3mWUWUuFWja1Y1Sebzf2TRqPR8s5JCpPHrBqgE57A4tWrhFiEnUZJFDCKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+2GD5LECNaJtb5l8N5l3J2Tx12bWZnIJYK5EAdsTHI=;
 b=QfVDXcNOmIRF9w6jbfItai5Gxe9ka72hXUHLTFCeb1Bz+84cAwM/j6dS+BQyWx1w3G8HPF1M3jsP4RG9+vPgIjupaZ+mGvx90upNBkLXfaPC6+nzkKwm5kdxVNYWEJH7z4kOf11p39QoygCHDR/bP0LyDSUMSFY4tNp8210jgMSI5ThhRowZCjNwLnVHFLuY4m3fRi19VJ3Aj9F6aF7R78pg49GgAv8el10PWx0dRgreBXWhWAnkzF6dH/lsHNRVVlABuPBnh4gKp8YSjCHscqwr1Znot0JbUDE2oy3fwRsIgsiXxRxAAk7Rn2LlQenlFPFpmcN/7TJbx7XZfnBSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:24:24 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 16:24:24 +0000
Date: Mon, 20 Jul 2026 18:24:15 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v5 00/15][pull request] Introduce iXD driver
Message-ID: <al5Lr2Qm5pDa-yOF@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS9PR06CA0058.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::32) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|IA0PR11MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 5830768b-944c-4c63-b3d0-08dee67b5ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: qJn+0cXV7suBoarcUuuPP/fmarPG/uKUm+J89TVoI38GKf2aP/V/EUPDI9h9XcTPMU6BA0Q/xDBYlU9BcEuPM8pVwTRXn5qpd+/X1BkYxA99OxImmes+uENEZCZUq2pVi2iihpJ0iQuOxtoSxjyNoBPjlvoUyWusvd44iscdL4RiylCdPQ3/CIBlV7MsO6mT1IyirztjEnln/QIafohLex0dTAm0nGEruQ68vq08YkY2gkVceD7wTwlgBJaJbVzRQxLLKq0GE5l5AeMa7+f6OJsHrMhSSeI5LLVjZf299mqok0bsd6i9etvIb56NDBg0sWP6G204sexDXjATQtFhIUtr2KoEaNC/zl/FiBQ2eQnUOhOW94QhJHjJWtBPyKXSvd7MMK63h739z6MjxIXIRw5ZLc/t+QdrmT2K2a8BwWMJuAb7mDWp3zAN6SGEzymwVAkTX4NpYz9Sa9ZAR/rFHtO8d2VHYO7EZYP8uKzsu/gdfAGeltfClyADub0fR8XCH/VmeLcrkqMXPfh/iz/m11uyEmwFlOPwYJM/1F4QmR1OGlT/xsq8n3Oed6BSOnfGhMDGtSAakdbiTYWcBA+7uVO5i+H8so/rxLVrQq+zs2/O7WIHatKnA0Q6S/WY/shzwdNuMrq/2cBNwKDZY3o0LkZZv5L/ser2b/FVl/m0UU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0HtqifWuTJdNWGIN6DJhlg5wkJCwGrkBaqA95nqnqyI289QZoqSpj80ULq6s?=
 =?us-ascii?Q?77BBqebB/EY3CclOidb9SEMCiAfAhjVfj0EB2A4ErVIR3oYSIegxWF6Yj0zV?=
 =?us-ascii?Q?bKKWE09dTlGmK6fV6eJgkxIZ6gzwXJUNOaEG9Km7SUIX7Yy2WcDfS7QZIMgW?=
 =?us-ascii?Q?l5bNeOKEnjat8+akqQ1kEv8DSw/LGzUbYZKqUyjHc4oscBsk8b2jkb9aB3C2?=
 =?us-ascii?Q?8q4E0/TkL5thYOhvhh7uQbi1XfmyFTnrNRnFvC7I71hmWOyI+T/MZzDuDySY?=
 =?us-ascii?Q?p/PaZVoehMEBDfDBoSX66DwQjkO9+kWVcUiFZ3Pyb+2KtvH9plcjphQFlWTu?=
 =?us-ascii?Q?+epIM/0rriNv48HdAehyetqiQbnBCfjupw5mFrhs0xiYLYNoiK9HZjZCV7mj?=
 =?us-ascii?Q?Q6u00P5MGiECLnsvkBNMS8wzFgYatfpRpcznDdWEkBEnI3H2Ta04PhNG7UlN?=
 =?us-ascii?Q?jxSlHfOn1SP0EQLznlbVxzVsOXWvooRm2qR/aaaXzqrkFZEouM4xgJ0w+1+p?=
 =?us-ascii?Q?NBlzBSaC75WLQF2WYTbxG5TrJoJtNHBhuN5EK9gGdYNRQMiL5OTRoJLJRkIo?=
 =?us-ascii?Q?riqcoAnl7D5MY59o9w81YzfECiG/NMIXCQZzQf0j2S9pDN+AqBQTQIY23ej6?=
 =?us-ascii?Q?zqHnA62iY6JbnlqXQFqbwi8I7RJKt1dnxgn0SGtPdn1o/ww9KFBdbjed0ANW?=
 =?us-ascii?Q?dYK+V5Qdbc7//C4a6x31FGwJKWzXQtJWgcwoF8w45nTADq0EspQoE33vxR2R?=
 =?us-ascii?Q?GKD/UYF1qZrIfcefqkupjqsAB13NuEupoJRAwlKVAJYqUz5Be2KvtqBSKi4Z?=
 =?us-ascii?Q?prHxASS5OBKJQMjCFEyiX/GNH4VK5hM3cedhEX1AnrsXVSAqHBZFeTJhvC59?=
 =?us-ascii?Q?ih3Kr/BBIvBNetqEf1h3ZDDv5kQldNajO1dMvQz0HU3ihaSA3RjT+WDSadgq?=
 =?us-ascii?Q?JomwdtsdRS6WPTn5I3FtnDUsqZ01KOcjn2vXxEL408b5avtoa7gj1PkAl2q9?=
 =?us-ascii?Q?S3K89tOdZ7HPTwSSIMAcab4i19SjTEocnvg7DN09R8Rvij10cKXJb/b9drnM?=
 =?us-ascii?Q?uL0PXLK4FgAPPpvMYLWLRwUx9NE842seY8swqeCY8Yzt5tiBOOHf/TUBN0ch?=
 =?us-ascii?Q?Stcw4FPzLJ2c+8Kngr2b8TR8ybZpvyk2ubuEwjbENIt6/mdrMyTH5pKJGtOW?=
 =?us-ascii?Q?OwjJnw0wf0ZWC7aeK8Yh0WTKN44mLDJnTiVNP/yuWoVwuzYlL/zWPbwfmWjQ?=
 =?us-ascii?Q?90KIoFBoX6i/xkA/lN5a+FgBn5WVhbK1LMeKptlq1faRMdungM33FIIPitsl?=
 =?us-ascii?Q?Ne1e3XTSg7Aulif2gKS/GawgiEtbxCugyXICMiq/4ztbYPOxBIWfWppf4xgT?=
 =?us-ascii?Q?5lzugX47+dvGK8gERR2WYe8Ve6Y79uH5f67mANe3JjQAzNBn05z+xIdarQLS?=
 =?us-ascii?Q?YHiPGPQqeAGra5A8PEj9w6qWn2m1dEBnfb/dBCyiC0s6nr7aN02zTPG7yqOe?=
 =?us-ascii?Q?Bz8Vm6U+tNIQD8x7t8fqg8S125/xYh43BTkWAj/Nxu99f1stv4JDs8IS3IST?=
 =?us-ascii?Q?0uunIZrMKzROGcGtGvWXe0nuPrzU7Sr5toYtcx/dmzdGTJyfRsjtKGiL3k/N?=
 =?us-ascii?Q?wUAhxAU2YN4BKHv7aY1LVazQyTvlYA61ikSWqNRHTqoHRo5rIgUK99c7JWlY?=
 =?us-ascii?Q?Qfyimt3qFbbbNddXvsQe5f02Lxkd+2lJmPszYt6dvNIubnb8yf1IKaSj7cum?=
 =?us-ascii?Q?mAbn+0S8R3J0/wnH3Aw94DmRwoBSzRTNN/0Sjf489ib/MB5TDL1tYxcneGjn?=
X-MS-Exchange-AntiSpam-MessageData-1: IdBXmVldq/I6BaTBXSXnbIdK7AOYgkkGjSo=
X-Exchange-RoutingPolicyChecked: ik/ds1FNTuZaJlCcPjb70W8StU79WobfEVcWhHbB2vAWXlGJuBOktp4ko6t2PhpvK1DsbJGNVEo02wO5W3MboTglydsooy2qLZv38XSE9XW2/nnlK+vJ2g73a8IgKEE1cNJPw8iDuBeJkNIs72gfQ9H0GrCYsXCmm3FzXQd8K3PZq/B+DI7wwcXOWNDbzzqHAAvNgSe8MgJO963g/LXVHuw8OmfGZ+tc9pVy2ggKBEDkxOYoKtmOsqY7we2F1GMEsdrh0K4yURPkTtNswX9/1gwyvgTL/K22pafoM7LzwXu4v8A61YG5ldq/clzdSg1ZM5240mjv0MTtvGavh9xLHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5830768b-944c-4c63-b3d0-08dee67b5ca3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:24:24.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PpbHzwjhjJ9NnPUefUWVKN6gOdIjXgfd3Ot6noyeeh1MeacH2r5ZgIXZeQTsLp6Jaq4tgY8Sxsom68ImExQIbHzEYYEt/jIOCSKk5VCEQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8336
X-OriginatorOrg: intel.com

I have looked though Sashiko feedback for this version. A lot medium+ comments 
were things that I have addressed as false-positives in v4, so those are left 
out, same as many of low-severity subjective issues. Unfortunately, patch 4 does 
need a fixup (see Re: for the patch itself), but hopefully this does not warrant 
another PR.
