Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221238E8D8
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791385850; cv=fail; b=E+g8f4Cu1UOCNb3iI6Zk5bAyITY1KWGOYWLKPSehoc8llWBLcXAzeQuJhMxjrifLMtSEuykX1GN2xrMK7JpG0lxLY4+1yElT4b2tyz6KSIoCfNKUx2H9+RoO4hQPstUqOx6z7oCxA08UA1us8n8/G9OT0w4/zsGNFJyUN24yT5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791385850; c=relaxed/simple;
	bh=NddDBEFxi0k17J+zUMDLkryKxdH0kKmnpCC172iRM8A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MCO0O0vMZK3CnoydLm4l2YY/HpYNk9lNmGkyOAaHwVAOmIqEgD4Nc0eAzuPRusB/cwhRBcqwks3Kngr1uJ2G24Z2XanUiYrk+zLaRipOYPbiiiHIfGcdygXQCd38NhHSgebLv6CAYOvDxnUfxE94gXXn4fm60gaRBIWJnOSW9TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGxtb/Nz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGxtb/Nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791385844; x=1822921844;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NddDBEFxi0k17J+zUMDLkryKxdH0kKmnpCC172iRM8A=;
  b=kGxtb/Nz8R7v039QomT7Ny3+r6+CFzFcWxCQ5rjuc71Yr/KckOmzQw0l
   eAjaxIRhYg7Wo6iq9VzCTFUSxbUq+2I2FdcnnQ3JdSALUfIA1BxjfRRA4
   niqW0lHZZESixzkvKuLzXjAggFJSIPBLnCPyBtWOdW3gVBoatqek7IGyQ
   oAYlGGwIvKF160PXP/ynOeAEW0ppOhyBdYdDnkloZc7pmIN+My5peaBSf
   o/Cf6vHu8Yuv1aNX9hko+gZiSBoNGiFTYoy0jF8HZUs58ps3r0jutUa8i
   8nkhU6gmS8UYdUtM9cEDYsbmqHkB6hsiWNDQlLUHOS5bRmG9W8a7II38V
   g==;
X-CSE-ConnectionGUID: aeHwfWn1Q/i+smsrll/MRg==
X-CSE-MsgGUID: dHePLrnlRPq3XB8cnb++rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="36739"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="36739"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:10:43 -0700
X-CSE-ConnectionGUID: RNI338y6R06IVjKFCRc/zw==
X-CSE-MsgGUID: 1ZSdcoXiRnakYEcCwG3gBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="202665"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 08:10:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 08:10:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 08:10:41 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 08:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsPWYj4bIwMximTYtrBq1EQV3CYsAusRJEHyVfKjsIQEYbF+iM9q325Gx1DLUDIz82L58s6f1NBt+kAigUkK9a0Al4gRZ/TNhk2IsrRlYW69sQnVOvWKxMjCjlUAy9snIVlHsgK4bCaDj90xbZdbOXbjdq9v8zp2MTSBitY16AU4B+M8RrySOFrRJivj/Mqe4YnCesE+K8jopdKehI/tF7HJCpsqUb9tM0AAFIkZiK7KFdCIcFPCmlbhtyw3K4ZMXWjTJnde4cACx+7qQJWTdMomfSE5f+/pUMGHftnOwQp1JXer/lIrwfgMAJMRDEQsmXLr7j6gLZtbFJIitKyIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoIrrYvE2G8Z29lwbLKjiUJ38s5Qgp73CoEQXFHG4hA=;
 b=txvY6xRNdfFEKnhi0Bcu4FW4mwwvxyETmy2yaxsgnCTKlbfmadbjf0/ToYqKya0UzX8Kh/dHrey9T2oFmZuMMR05HCbnHHdsGvkUjUP4DmQopG1fni58v/qrYoPVE49ZujAtMhoJ8LUeCbhJSl+5ooHDXYMTYHzYeFcv0OdHc1j64l+TfFeJ47K8gxXbL7dRsx0gvx636iH+GNZBgbJ/PrKh/CJ9fPcgiHTgkP+CfIbt3YImvx4L9CgchSg4/KXwje6vhB+vTQojRWjCh/KqV3jvg0qS2TWJ80lIDrrB2ApZzU9fYpVPfFIMenzoEo0D/tUn8BVfLympGgjvQqxmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6650.namprd11.prod.outlook.com (2603:10b6:510:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 15:10:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 15:10:38 +0000
Message-ID: <0d4ec844-4f17-4c97-9584-e3232eb60202@intel.com>
Date: Wed, 7 Oct 2026 17:10:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
To: <netdev-bot+sashiko@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@kernel.org>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <boolli@google.com>, <sridhar.samudrala@intel.com>,
	<emil.s.tantilov@intel.com>, <decot@google.com>, <brianvv@google.com>,
	<aleksandr.loktionov@intel.com>, <Samuel.salin@intel.com>
References: <20260929231305.1515873-2-anthony.l.nguyen@intel.com>
 <179107051461.434549.11114177164296812377@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <179107051461.434549.11114177164296812377@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2fbd0f-3575-4a23-f80e-08df24852533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|11063799006|4143699003|56012099006|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: jAYfvy97/ow53iP6GHv7YLYYKhaabJ2V4R/1cdmS32yexsQTbDL0M6+87DEtWPVfGx4kn3XH12KTOD9B9iaps7IO+W1kRFgfPvYA7rHUP6QI4PshuQsg8T6AIixP1SaWPet+gsYorayqqRnOrzGJFQbXARNKPtNpOirr4OWssgTPQyqgpcAeIeXzHPKc4JgUiFi1ACXg8VKClYOjfjLD01itvv7HToX6I1z94XDLvC6HFG2Vxz13t8Zpxysfs4uC4qYS/cCxV05WfJPr2CnnbwSEsY3OH9K5u+f8puVMwt9ssg3+KUnOLHMuD8DEurh5bHxWbhNzr6B/o8BjsYjOIMoAZU41bzgnTj6EFMZ2L1wODA8kL3ZxITL7wPLYLxkhH0F9wlcarSh6hT/M9K6Dxc7cH2HE3zWQucr3yQ1R0Lj1j+p9VMjRKxQ7DXIgzdJl8AVCCXFTBf281iaiGD3VsiyIN1RfRigNRpNBdS3iw87ZyWkCnGU4bG+pt34dKcOIXHEuchJHOLAXVovvZ6JDPtSAQTHVaRqsAuoqu7h7+NGCCmc5Dh7MTlNdp2WiJduKX3Z/aRdkZfr1ZDbkBqJJsyjg+1FMBD7zFIQAWwUdRsq3v8zgPeJyUTyD1k/5GCF8xal0xVJKUlrp879JtXrpHjxzQl+x5hrXWIdH7hRsAIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE1qN0NnMnVnNFlQT1k2UzZ2NG82bVUrc1dFeFF4d09DNEsyWVhIdlBMOEpC?=
 =?utf-8?B?Z1FGdUphcjcyRHp6REYrZ2FnM3pnSndxdXF6ejhDOXp3QWhndXp0djdJa1Y0?=
 =?utf-8?B?RHVBVUVlOVY4TW56WEdweDd1YjZzR2RmS0JsbUZVSlJyaTFxNmFvT0hIRG1z?=
 =?utf-8?B?TlZ6aWVxWTBKQUw4WmhBd25kS3p4U1lvZVFHRlFMUEswOUY1a3lUSEFnU1do?=
 =?utf-8?B?QzNaWG5kdFRUS0U5Rk1HSEV2WGF2ZUxtN0JGM0JJR0poR1FveXB6MG4veWlm?=
 =?utf-8?B?TjZ4SmxCNzVDYnJXaTJ6WWxuRHgrVGZGVHBkZW5oQVNPODZiQ0NZdGg5V01X?=
 =?utf-8?B?cnNFdVo3WnU0VVRGZzlBaldvTzNFRml2R3daR2Q5YmNHRklNT0RlMmR4OWFH?=
 =?utf-8?B?Q1NtbU5PdlBaRHhpblNtUlZIZ0VEem8wbHdYOXErbEYwTHdOeWZ6dDl2OWpR?=
 =?utf-8?B?d1hhaVR1UlVzSjBlTFNoWWpwY0FvOVNpSlVqQTFvbmU0Y0JRV0g3TWdxM1g3?=
 =?utf-8?B?L3g1VHBNWGF2b05WajFVYzkrQzdQNGN0bndKTzduaXlqcTdXSHZkaGJGRVFZ?=
 =?utf-8?B?OHhMbFg2LzhXanlJemhDcUI4Wk1ibUNXVEpEUjZwRVpPT29odWY5eTNYVVdp?=
 =?utf-8?B?ekU3NkZGMElzSG5KZVY5SFQ4OUVVRmRVdE9CZFBtTUV4QXd4WTA2cTJuQ3lL?=
 =?utf-8?B?eHhjZjZlanFXblQ3TFR6UDlhdXR3T3p1OVJnM0htSGRneHRvd1YzWmgwWkRU?=
 =?utf-8?B?dlMyWEFBOUtVcm1pK3BUZjc1YXRicUtEMmR2OGlvV0FkUWI4MkdoYkJxYVBn?=
 =?utf-8?B?Rzg3ZTFvdjd2THpqcWswZHUrSnY0MUtVS0hEQ2M3ZVVIVWYwamNLbFV2SlQv?=
 =?utf-8?B?bGtMWjd5VE1hbnp1YmI5dWpvWnBrM1laSkRrV0xNMktlRTFWN2txREsrOW94?=
 =?utf-8?B?cG8wUHFwUnBCYnRqTVBVcEh2R1NuL1NVVFdNa1g3Y2lPM1dTVXA4T2Z5OXN1?=
 =?utf-8?B?M1JQUjArVVBybjBZZ0dWcXcxcVJwOWpTYVFiSFkyOUJZSWNZSE5seHgyck0z?=
 =?utf-8?B?aXA1UnZqVktZNEVxdElta1NYYk8yV29KeUdFVi9HODg5TzdvUmFPeCt5UzZ3?=
 =?utf-8?B?cjFWd2REdkdxWFNlVnZlaW5pVm5Tcmc5eXh4SDMxMUU0WU4rZFVnaXNTQ2sv?=
 =?utf-8?B?MW9VN0dNZmM5NDBveVJVZHBPZFhGTE9NVGtJQzhkb05HQmlPRVJZSU9EbHdQ?=
 =?utf-8?B?cFpGdzBFTmJvTXEzcEkyTDdUbVhqdmJsbjRONGJpMDRKcHZBcWpIUFFUWVFO?=
 =?utf-8?B?SlRJa2N3anpTVHY4S3k0SjJ2Z1d6WkNBU0RzcWNmU3FqenZlRitQWjcyTFYx?=
 =?utf-8?B?NUo2eVY3Ryt0bEtaN1hiZUMyUFNQUWVEMFhkMGNESStBQk1ZeEVZcXAwSnc0?=
 =?utf-8?B?bmRMSk44ckxPdzFlY1Q2bFRrbmhlZU8rYWFKbndwZjg0a05acGJ4RFdQV1JZ?=
 =?utf-8?B?dDJzV00zQVBGOUpYcVhjbWRIS2o0RGUyeUwrWk9WZ3BnTXVnSEpncFp6b0gr?=
 =?utf-8?B?RDU1MVFOQkJQNXpyWUxoRTRhSmNUQXU4ejdWdkJZeUFic0p3ZFl5U1FnK3JK?=
 =?utf-8?B?bG92UWN6UDlRUDgzYXJlNnhjSFdBd1N4M21DRDhEa044ekh1RVk3R2tsUzdm?=
 =?utf-8?B?UFA0NE1sNm5pYTZ1ZGtKd3cyYUJoV1ZteURHRmdmZGg2blU3T2xyTGRhVXRw?=
 =?utf-8?B?R0ZwSXpPNEN5amdBbXdkNUs5UmgvNjNmbmNZL3BnNngwSWFjNTJLWGNEUXJC?=
 =?utf-8?B?elA3WHlORHNScHVzbTBWY0VRcXEweXBrMGFXbGY0Z2k5Rnp0bWlNOEdTS3RJ?=
 =?utf-8?B?Q1FmMFR4N0RHZktYQXRJdHlIaVdVd0tJWmM0OG9vb0psYnR1YXNtRGVDeW9T?=
 =?utf-8?B?ZWcrYXk4WU15cnB6d1VIMVdDNjRUQzZDSCtGNWpJMXFEZVJ2YVFJbWFOci9x?=
 =?utf-8?B?cHlXOHI4UU9YMERSRHl5aUlmSmZJak5DYjh4WnIxQ2wzcllJRDNUREFMZmkx?=
 =?utf-8?B?ZFhHenFqajVTMjRmd2ZaTitWOUhzeU9LcjJIWkFYQTFrSGc5ZGFPazdrMjhz?=
 =?utf-8?B?bzF6VmFaOUs4MkI0TGZkQUdaSU5FZFU3NHVtUXRNTDJTR0JOVkUxbnR0eFM5?=
 =?utf-8?B?akFUakJTem9LMlpCbE1saExTSXpBZlNqMzJtOStubzV6N3FPNlJoL0hSVTFz?=
 =?utf-8?B?UTRiTlN3b0Y3a2dhbmI1TTU2STh6SnVwTU5odHlUYmlwYllzWDlwV1Z2Q0J3?=
 =?utf-8?B?VnFVL0JzY1VBUXVrWW9QRXJaR2h0S1BxMGJXTEFZaTIwcmo2U2lxSjF4VURJ?=
 =?utf-8?Q?IlR15VJ95tQODfRs=3D?=
X-Exchange-RoutingPolicyChecked: LMxq6yWAeNFqCfDYehioxD78VVhF+YwVqMiLv/VNUi3LVL5w6apon9QL0f5OubgKK7E34NqPwWJpOwkYTkZVVStKAvj0ze87vFO+ZFZmWRZUp80MY2BdgQKzRxYUhpS82vvfTZ+sNtFneeLQlrN2tVPgrH5EIC0gsR0O6roXQKDovzhfjHz9qJdEtW4Il3wM3BG1XF08sCEEe5BrkqUCzpleNyzpd4k63YpOWURbyzOWnAgVcB31yozB6MqmNmY5DkMUfY2TG2V8pCNN4kk1azpYX86vQlCpbwgreOQW1/u1x0mVXxvuERAXvwtuudxzPbWRIrlAqdOZW6VMEr6j+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2fbd0f-3575-4a23-f80e-08df24852533
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 15:10:38.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wR3s3zSDe1Jw4BktW0cQraSUtoaw31eYn4gbOAjKevYrZIBLjB5evOepEZBO28ApNtouHA64wP+IZXccFDxyvhCu5pRKmTj3MRL4kil/Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6650
X-OriginatorOrg: intel.com

From: Netdev-Bot+sashiko <netdev-bot+sashiko@kernel.org>
Date: Sat, 03 Oct 2026 23:35:14 +0000

> Thank you for your contribution! Sashiko AI review found 11 potential
> issue(s) to consider.
> 
> Critical: 1 · High: 2 · Medium: 3 · Low: 5
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).

[...]

Most makes sense, thanks. Dunno about the second patch in the series as
I'm not the author, but in this patch, I actually need to address stuff.

I was skeptic about AI reviews until I wired up CodeRabbit and Greptile
to my home project :D

Also, the review from sashiko.dev is the same as our internal Sashiko
gave. But this one is a lot more complete and complex. We might need
to take a look at our internal configuration.

pw-bot: cr

Thanks,
Olek
