Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793835902;
	b=F1B7Kf6NQX1jtiAY66qZPV3X+kkLaaXv9ac9s0sEKuTzvM3nIrFgoYn6JifZUV6JT8hQ
	 xEiRsGiealtissipaamLSlqev5FxDz3wdpNGUPpjj82R/e1tVhWIm38n1ZPtPcXLU3C6K
	 EJ4I5cHe5XUA1/tFYYH+TC/3zRgU6YWwn7Lq1d9ofCSkh7M0/j6j9bD0NPh3phNPf2Uab
	 Z9K+EmOiR/Flk9iXIiNkdKV9kY2gaTpMlhi4J5M/dOjd+CqWupzZ5x7v78KuGQa+ftgpe
	 1X+hG1Z2zRpI4Hfme0aJPf+cMExKDHgAOjFMk7cocMUgBdLX1yAMElFiMAuMDbMCzng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835902;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=1zgV6KPhyiBn2IVk+0hjPXqAGXNfSnVZnDnqWstVWho=;
	b=QHx61xDlzSkkwNfCYMGhoa6lmUos6y5ZyV1lQzBlZKX/OdQ1i9VRLTSnQ1BvPMUY8zh0
	 tAFYTBmWPk82AGlflZUtj/2ob8fQC1leQBjYqxwwGqR4JJpyeBUVFmPvwGZ9e/D2dY+36
	 zqW/RsomrCEpg10zacFkgF/nR+lPpzdu83VKrzjNzkHOHzGT3lDl6kherFDoZTU4NL8uf
	 vAOvLd1Oc535R7+O3GpcWWWUfYzM5ltVryU2ddDKzUF+AWK9XIeaMUUTiSbkBM5aF4cnc
	 i4YvDk1qLL0ymGfexhxX56h1zSq9mM+fKN2pY+l0A6ZyrHNZtxT3Lcg+1z4vp3xkEIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aXRJeP+f;
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072D606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 23:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B072D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aXRJeP+f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793835890; x=1825371890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5vsUsMhUI/ct+Bjj9VbBP8AVyxK7QiXXGUfZ4dgxYtM=;
  b=aXRJeP+fA1y1q1Uyy82Fp2lihOnClWbw8jIwZg/iyU5OkKeweZ5QA0iK
   M2ai1eIKxwp5vzZESbljEKelndKdVPeoH30Lg1YwSkzVRFiOCboU/ggBd
   9e1cxVT84l1Db0QZ+c744tYtRj/1m1Le5H4aMZxbllrmtm/xDoPahOcgF
   meVJv61Qe03a7N3RCKar6kUwwFLKsc7x2YSWAopl2q4aPrhRbwGdeHEmf
   nHy4m/58FABCHqsjaUsbqAE09GQw/HJhFuDh5rqc4DzcRctIDigWSycTH
   XGN5fPbG3Z6ePlFJaYmMP3ufThFyWOye3nrFbjBPS+KIy2AGIKHz1Rv9V
   g==;
X-CSE-ConnectionGUID: TMnxEvMLTE6mXHoMIc39Pw==
X-CSE-MsgGUID: Gh4+WryRSfaqN6/JAuqaVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2484670"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2484670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 15:44:49 -0800
X-CSE-ConnectionGUID: J+snlLo8Qy+p5KzHXoRvpA==
X-CSE-MsgGUID: yQi/GaU1QZqdqKcgeRB6xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7181978"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 15:44:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 15:44:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 15:44:48 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 15:44:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5vmPkLTEzeO26YlxnAzog5NC3xhAfxdIpheYMsGNijPAGLKY8Wo2CpAdAyjAA4fu4NboYWvZMajHpBLMXAETsP5p84QwccPNxYmd/3sg0mqQJ08ggP3+H01pg+eJYXCglX55j4Vfw2gOdg9ihtwlCr02TRRrsn6Ls9fFi8o6AcRolxvcqtWklLdwPsQs/bkyYa2t7QRYbA1nl5OTAKbdqv2I9MJpvRt5zrok3W2aAi9WJHrt9JHDs0H4fENzJTK2zBQV0AwvM5QMHZ7dex2Ku7FTmuGc7eLAPCkRi5SDASMw8WJZVk6SsaWjXlDDaIbUCDqJX8vvCz8XWrb+d+SLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zgV6KPhyiBn2IVk+0hjPXqAGXNfSnVZnDnqWstVWho=;
 b=Wg+nxliK+OvlPQwH+yXqqc0/Ran9NyeW+wKsF46R1W/22SdxFhqjB6EI/SOfjbxapLHUEdmpnfj5Pht2k9bGm+i3+Tkf+cNuiM4H9J7k3vT5CrAnnFgoqPlgMujEB9/O/VptNoy330Dt3jOlcaLx4typ3nB8TP66M879C4u3g4cZZTb3kDLi9MV4fkT8K1FwcIATgEmKVC7v31pr/EE8m8O/xRA9wA2/zhYz7Fj5rYntsG1mrWxbSZ6DSTCtETluevCYDz19az6r0VNYE/av4TVO4Hjw1BKakMzmXrNJQzllO0Lq4Vyy2H7tPzKa0+KGRxi2ZxxPlxJSk1DymqHV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA3PR11MB445477.namprd11.prod.outlook.com (2603:10b6:806:533::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 23:44:41 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 23:44:41 +0000
Message-ID: <c4535137-2af2-43ad-95c3-21ed7740bc28@intel.com>
Date: Wed, 4 Nov 2026 15:44:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>
CC: Eric Dumazet <edumazet@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
 <20261027121442.907414-3-magnus.karlsson@intel.com>
 <CAL4WiiqJ8K5wXutDRk_XR8KfpWMxhYF_K1eNUVqq7HuyahO87A@mail.gmail.com>
 <CAJ8uoz2J5EbN++dts69BVJoAW8+T3bEtgHC-t3EtVtURQH-QWg@mail.gmail.com>
 <auCjwM+9Y0v+kg6v@boxer> <auCj/vK5BjeRbJw1@boxer>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <auCj/vK5BjeRbJw1@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA3PR11MB445477:EE_
X-MS-Office365-Filtering-Correlation-Id: edbcc94f-1c01-4a19-edbe-08df3acd9880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|261022105027099003|261022075727099003|261026121527099003|261022115727099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ltUzYSiF9robMLVrM/w4U3JI+NwdXKajzqPUFDq8XBG/eIDnnvnehs8/vOUKMD1VcqlkdSXE+S2wnZxzkJ4j26MzffLeempkM0IDzyoTgh4ACkFai7AkD6JjQHYnZhkOP/Gb8YxfRER2fICc1wUW1zxfk8bqfLUI+yp1XAGM1s9tihlng6j7+JwtLGCOoJC+WTIfeEwW5yNVgn1ndGO3dq9TMkYAQALM2/FcxOoI83LhrX6dH5EZ/KgAwQXi1byp9wtsOAMi1dbqBR1dqiTqbjKNNPioS79u9mkO706FJZdxsTZuFtBuFjZHNXLPYkVWNHOZ6tJSHxxPB6qqWQ1WmFfQbTmrXzPkdY0iI3UGaAc1A55rtL7+6z/HfQufYYUzsDmLQrlYUEah9QT5vX46Z2ENlkbPVx5aDH6+FCRdBlqL8amD0n/cmVfw/XJBbMAlwtV/i0wBBYGuMMeKqL4JtGgVhkRX8LFaGIEQIrmO8+GuQUc+eJlPrJO5IHfjpCGxOQ8OCoJzSKK4J1RoQ+60zlLR4fLQBdtOEXm/d0CS5+LFE2bs+sAy2RyWwMIQiTsS/MtA2F6RRdnN+uD+q/X6uaRoomu5wqb/pEpu7neQ4DLaQSl2pOMhURCGmaN6Yr0TtVblWi/9GMns7sQLOA3yJ9uCuvkidqgt50io8lWQQbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(261026121527099003)(261022115727099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSs1SjRaMEJrM252Yk5sL0dzcXd4MGlPcmQ1a0hWWTNSblhGNkZtMDdEUzEx?=
 =?utf-8?B?Y1poYnlrTTVHQjNBV1Ftb0JrZTc0SFAxUURXYUxZeXlNN0JPQlhLUk55RTdM?=
 =?utf-8?B?bHhNMTRkOTlRcE1rVGRBU0N5M3JmR0VPNlFCeDFSc3BjdVFJeFA3cVlFdDNU?=
 =?utf-8?B?QmhGSEl6dVhNYldBd010aHEzbFhKd09HRmZLa3NEejdtVWNoaUpFOFRvbUFU?=
 =?utf-8?B?dGV3N1NoWE4vQjkrb2ptNmpuYnB4SUdna3hWNDY1eWkrM2htQ3pscVZQVmRM?=
 =?utf-8?B?WW1HeVNWNkU1WmJXS0RUME0rbjg5YzV2cU5rTmpMWEo1NDBCa1g3d2luU045?=
 =?utf-8?B?UXpTMk5GUzBYUHRvSHZJZG9RUDN6d1Bvd1I0eGlHVG1MK0UyaEFMUnQyNHZv?=
 =?utf-8?B?MFl3K3JOajdiM25Rb2o1MDcxS1J6WkdLQzgyQkE2VXlMYUUyNStyK21SK1VS?=
 =?utf-8?B?NmxEbXJ5cFF5N1BsempMR1dEWCsvNVFQTWUrUS9lRUt3YjY0akM5SXlKQTVw?=
 =?utf-8?B?Q1gyQ0ZyeWpyTkg3NmlaZFAxdjFRMXVEdFl6Vi9NZWxxME0yY0pETm1PS01D?=
 =?utf-8?B?K24wM3o1YUwzZlpKbVl4Z1F6ZC9oSS9lUStZeGFzV2E2bC9YWEV4ejl1Misx?=
 =?utf-8?B?QVBWelNWaUFDRWpzZ3lGOGU2MXpNRWhPRnFmbkhSZWIwcUhYSHVGV2I2aW42?=
 =?utf-8?B?NU94bzhvejYzZXZVQ2NyamMvdlRza25MMjNQSjdBSFF0c2tNd0hVWFlpQ25Z?=
 =?utf-8?B?cWcxRGIzNDJaelpPMjRDZ1A2OC90UUpWclMrMUNtVE9LcXRsWHhtRWNpWUcx?=
 =?utf-8?B?cTRRUzFYUmx0T0ZVR3RaSU1IL0t6SlZhblhpZWEwU1pUdVFsWmVHd1kzeThR?=
 =?utf-8?B?YTJlNjE1cDdaUjFZVnNmQVFOdmh2WkxCcVZKazRKR0REOHROSUxxUUVreFdo?=
 =?utf-8?B?WFp1N2tJZVBYaXVXck5yZkM4dExPZzNHUFE4bUpaTE1rMVA4cFBXcE5pR2t1?=
 =?utf-8?B?bnMvOElpNnZBZFlYcGpvU1dpeG5aQkVadlpOUTJ2RzNzWmF2dk9TeGNONWRQ?=
 =?utf-8?B?UVRPRnF0Zjk2WjQ1RHFCR3dyWVdwUk1qcjBOeTFidnNtMTd5cmx2L0UydHdx?=
 =?utf-8?B?VnltODRUVmQvTnNIYThTMmRrTkI4UjVDTE1jTk1HK1piK00xNFZmNUpnSXNR?=
 =?utf-8?B?S0RHQUJ3dTRldkF2bFlpek5ud3R1a3RFcGRFMTZNRTR1eTFiazAxQVI5N1VW?=
 =?utf-8?B?QUdSU3JGdTdxUTRCTS9zdHVhelVKTTBXT29ESnMzQjVvY1orK09SelFMeC9m?=
 =?utf-8?B?bUVPMzVjdWc0ZlNCV0ZuTVdlMS9OTm5POTVuNk9TZCs2SGxjbk16SklWY0Jl?=
 =?utf-8?B?aGtIelduaTJDRDZLZGZvcUNBOEJiTEdQUUpaUkNSWGk1ZnNyTmphb1NWU0li?=
 =?utf-8?B?b1JPZkZsQk5uZVVFNEEzUmdPUkRVQ3dTb2VTK1YrSFE0ME5HakxOQ2N6ZmtW?=
 =?utf-8?B?cTJ5ZEdWZitjL015a2dXZnlkU3RHY0xRaEk4MG9EanhlR0tuODlKcHpaY1Vl?=
 =?utf-8?B?QXNNMlcyOFRvdFY3Um5ob01HR2x2N01XbzdZWkZWeENsa0Z0S01ZWTZxTi9i?=
 =?utf-8?B?cEdVcmVld2t3elJkQmRyOVp5d0phZVNGeDhRK2hweXljTW5zUEEvdmtYaytN?=
 =?utf-8?B?T1RrcVlWakZDamZPM25TQllTR0ZtRlZKOFdSaUJsTEZKMlpXWnBJV1BGOFdu?=
 =?utf-8?B?a0dEMGdEZEdKeDRRMlduU0VPQ2VJRFVUNytJS2p6Q0VyTjdvdVhjazJWckl2?=
 =?utf-8?B?YTJTbVpJNjNKT3FhcThQMHNtbmtWa0tYT1pTYi93MHo1cXIralBmY2FxTFRO?=
 =?utf-8?B?QkNLc2NEUWZwR2pydzJXUGUyQ0xZV3FCNHdLZllra3g1Mk82azIrd0RYYldC?=
 =?utf-8?B?RWN3MGQ5UW1VanF2L1BCbEFaK2tHblU5VGxmbHpKL3dXM0F2bURyaVQyVmFM?=
 =?utf-8?B?bDhlREorV3hKbXdHUDRySlFaTEpGV0sreFRoNzhHUjBJNzA4OHRDZWtiZStF?=
 =?utf-8?B?dlNGWWFsdmFCenFmSGNaSkZhdDJBYTNrRXB2NU1EQnZXeE1VR1Nsc21FWWpi?=
 =?utf-8?B?THZuYmQzQUdHTWtnMzRQeDB6b1NnTXcvRHc2ek8zZEdubFVrYktZYlZ1TlZ2?=
 =?utf-8?B?QU1wckUxb0Q5MHROZVJlaDZTdmdxTjNoWTB0YldhYXBLVTNEMnpiWTVMR2ls?=
 =?utf-8?B?cDVPTVZOdkxzdlFUeHF0eHFmZ014TnNhb0dBSmgyUDBiMmtVM052TDRDWEFq?=
 =?utf-8?B?SmJWa2hBRUtTVTRScGtKQzk5eUJuRG1JZzJqZVRzK1YrUXEzUExCOUJDV0Ey?=
 =?utf-8?Q?rwy0yASTXCT5s+wo=3D?=
X-Exchange-RoutingPolicyChecked: xAbipNvl7soGtb9OCsNtbB8QafzdGR8xzR8+fNJ8jUI7OsnStzPZF7J4SE8d8aYerYbLl2+Rb06Id44S7cof1JFqC/y0UeGhQyWXhV8FPez6sBdBxC+93ngc7XHUxyIdt7Qs7T8RLIwZeBuKzX5Gf8D+z7lkLQqpCf7fVt2IrcTb11po5h7oZutZczxMJIsM04RCL/L1cGHJ9web9C5s5rgd11kgX73AAroCkOflEFEIb4ev8MbbYqi6/cPXPZVD4BJxEPmYm4ydPno9DaxPMvexxU80ngT+aIJUJmqqk1dFfjSuaLvOm2h/xK9iTpJGded9BtLhWenJjRs5A2rKHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: edbcc94f-1c01-4a19-edbe-08df3acd9880
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 23:44:41.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWbp0etQFIxcQy/iFTs5D4nnxPc3CpsmMqnY+WtVGTUvX765l6d1aVY0zH05RnRw9C5nLQYumz8rGS8HQBicNzGDtW2VHwJJm6MZl0gaKk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB445477
X-OriginatorOrg: intel.com

On 10/27/2026 6:15 AM, Maciej Fijalkowski wrote:
> On Tue, Oct 27, 2026 at 02:14:40PM +0100, Maciej Fijalkowski wrote:
>> On Tue, Oct 27, 2026 at 02:56:07PM +0200, Magnus Karlsson wrote:
>>> On Tue, 27 Oct 2026 at 14:43, Eric Dumazet <edumazet@kernel.org> wrote:
>>>>
>>>> Le mar. 27 oct. 2026 à 13:15, Magnus Karlsson
>>>> <magnus.karlsson@intel.com> a écrit :
>>>>>
>>>>> That USO works for 64-bit systems is just pure luck. Currently, the
>>>>> computation of the UDP segmentation header is performed using sizeof()
>>>>> a pointer instead of the sizeof() the UDP header that the pointer
>>>>> points to. Since the UDP header happens to be 8 bytes long and a
>>>>> pointer is 8 bytes long on a 64-bit system, this works on all those
>>>>> systems. But no such luck for anyone using a 32-bit system as 8 bytes
>>>>> != 4 bytes. So fix this by using sizeof() the UDP header that the
>>>>> pointer points to instead.
>>>>>
>>>>> This was found by an LLM while implementing something else that used USO.
>>>>>
>>>>> Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
>>>>
>>>> Missing prefix? This was really:
>>>>
>>>> Fixes: c91a4f9feb67 ("iavf: add support for UDP Segmentation Offload")
>>>
>>> You are correct on both accounts/patches. Do not know why I missed this, sorry.
>>>
>>> Do you want a v2 with this added?
>>
>> Current policy is that you need to wait 24h with posting next revisions.
>> Eric marked it as 'changes requested' so yes, you need a v2.
>>
>> You can add my review tag as well, thanks for auditing intel drivers
>> against this bug.
> 
> Also I believe currently we should not CC netdev on iwl submissions.
> Przemek, Tony, correct me if I'm wrong.
> 
Yes. We historically were cross-posting Intel Wired LAN to netdev, but
as of recently we agreed with Jakub to stop doing that since the list
was being overloaded, and it wasn't promoting review from folks outside
Intel anyways.

Please submit a v2 with these fixes to the Intel Wired LAN list. No need
to include netdev.
