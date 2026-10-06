Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4C1DFFB
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323442; cv=fail; b=QdGxPN+yS/CB9XW4oKvRsmzINnKem15GsmZVSn4Sud9vQQP2Yuc065vPDGdzICty74Rpbxtz2sgQMzeOLYchkzOXd2Kk+SJL0qATWP8Lng46h+t8udJncOBWXY5tsnavbFR6Sq/m3cGA6rUT/4AfCZDOogqjy21N4+co7AspFYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323442; c=relaxed/simple;
	bh=pAcBaDEHtRMNue8tbzExfHZurQ7RDVr60yHPEZM0Gis=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C+XBdrUSmzNwy2O8reAxbicCIZWG6qnsiehz+hD8wEZSUGQK+yDw/ofHM1a2BDw5qaE8SUcNqVat5iAQ4jX+vJDPLdhiT8VzcG1mBMB6dvVyOoqzpBMTNUrkqvy4D4x8iBTTWzxV6c9yYF0HyrMHCGkEF0W5cLyVr2mIf2DN6rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjK+uZQJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjK+uZQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791323440; x=1822859440;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pAcBaDEHtRMNue8tbzExfHZurQ7RDVr60yHPEZM0Gis=;
  b=bjK+uZQJHTDw3paOspIFHE5YUA3WwSOW42153Ax9ZBC2b0G3DZb6ZgC/
   oDNH70RGqgHh9TpK33LA+wKdbxDsKfomCYK15qTbV0SEmQ4eVmVyCaSZe
   tmlMr2JA9F/OBL4msqiqRIM0fqagIT3z8GqAXsjtS5FQO0y7kqo6QFo8Y
   9K5tQ2hH9IvJI3+lAq/+Wd3K+U0pe6WlQ/lZOcsCDOZS2UGE3fXuSFGVF
   4uZ0GvQglvl8Liq9q8LOad2u70XqARbpSjzCSyyZ0fp6Yxkzkhcg7YLt3
   IE67pDq8J/OB3u4AYfALsPetPYkrWGAlg2to4H55u8Ptx6uzUU1le2uw+
   Q==;
X-CSE-ConnectionGUID: /aHnXj5cTIm7T70G2KCxBQ==
X-CSE-MsgGUID: dnzBUPzXRi28cP5G10VUXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="69929"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="69929"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:50:39 -0700
X-CSE-ConnectionGUID: Z0AAEvHdQUmpOGk0WBq97A==
X-CSE-MsgGUID: fulZIzQ5R5m4IzBUVu9Mfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280502815"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:50:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:50:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 14:50:39 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:50:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDiL7G9gegbYk2aVXvE87R5BcYOWJ5Cf3UahevpKfhyJ4SnH6fz3iCaKGmjCnmAxFZ2Uw8Gqb5clRUGquA2t8yBZoJEWwfula+SJJLNC1wZl3pS0tSFsHDrLZV3kRd1CSN/n1m/f4efATJvuIXfcURnxts7LJF2jkVmTe1WW2MEhPdeG9dme+un1+bUujv07XsPB41eoMQdX+sT2Rpak5BGcaUcAXImFByhFyIl+BX0Kwspb+fMWL+bymqD4gkFFR9scfSOmNwvpexIr+c6F5RG2BfvDNTkQfwZiydDnv3N/qcDF9HBZ6JzKzTapNr7H9wzMKLn4Pk8uGKWdLo2ytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YkP2Kvf04Bi7DMdHzO/7QB/JZDmcJubAx+xjCtvotM=;
 b=Za30/9t0N0TWCQxGs9vW+8GUQwcfcCIp8xpkjE+ElPKrK1ykjYn4KFqJ6Zq10F0DZw3YiKpvE+u0fSCzenbJg8XFOHdI4MJqs6rkFkZ7jCqlrzd+pPbNfkyWR9yjLJff/4PBK2F/tWzztM2PFbN28RbxLGsHfRbsMutcp7cT/lXyBpl7M6KT84D6gkjNlDFOUo9f0dT5psovBOQVgvntV0ecS+TNalmYiwhBMm6dTFgTfqWp/wCSoAzrTO9y72W7OUY4S/xXTW/w16JWGrdIGoL3Vq5DUHUVy8eJIA1fqOKF7tNrANJoCZu31Rbw6JzOISHk4FL81m5zU3hk+h8JIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 6 Oct
 2026 21:50:37 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 21:50:36 +0000
Message-ID: <20d04737-6080-42e4-9a1c-c1a8673dddf8@intel.com>
Date: Tue, 6 Oct 2026 14:50:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: mlxsw: Test port range occupancy on
 template create
To: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Wentao Liang <vulab@iscas.ac.cn>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <cover.1791294384.git.petrm@nvidia.com>
 <e7b37b80adb7ac8b0ef20a22d7654a6656c1c545.1791294384.git.petrm@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <e7b37b80adb7ac8b0ef20a22d7654a6656c1c545.1791294384.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 000024f7-9fc4-4b2b-11f2-08df23f3dae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|18002099003|6133799003|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: +UB6RN/DE2H5klJo+Rf5JkgMbUN5YNAoPwaz7/SGe49fjYm+y/g8zUIqF73yvukiwLTkag2umZ5IW3Z0y/teLZz2IOaTVArEpKCwkLgjFSlLCtWuedHTjNOif4hZaSEmEaNTD/1kLjAaGlplSpMtMDin2ANM1WBbxshAZTAZiZB47132P4O/2JFbufiN2v2zmhPy37JFHECJYL43tqElHC/KiHAeRsiVbyQ/TFHhpd8SINBLH/NxXTKuh+YPDkPdPEfu4JkzS9Pa8agFFRVvs7p9MUiX+I4L5CuX7ChKc59Bu1hSomuN6Fzn+WNDUJllXYu78AkiTbFTVWHI/RWBuO6yjQA4H8A+RtCtziOKPgOCo2BxOroXXCMzgRTkWdzmi4bwTMTtOcpxyrobTmvLo0SNtBghhCBokLTdDtDc4ySJtoBAd3ODH51Q4AN8YX/wVzn/gEXpNX9wsmnYuvmhLCI2X4TcB/rcQzUMBf+YiLwl3l7xa0VLHWojds6DWOtLWFave5kcNDa38BKw1EhxL6zO++tCo+S88JMOSsyO+KeLkU/VcmgsqI+bmjmRrjktJqz1pDSey+g/mWhkoU4qlHvz63Ajb5hWd3k45WwcCJM1XiHnp9jzE6UIW3K82xJGu/vwjuFMId6Y+DumAbda+lgMLWL/6XuTVY/Ag5emcgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(18002099003)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGFVcFZFZ2xsbERZeXpQQUxZQlVnd2ZpT2IzMEdMbStxaFIzZ1NXa01RK0Rm?=
 =?utf-8?B?MkEzMzRRNWVJcnk3Um53SUVSckU0eFY5b20yNHN5ZEtpbUVUVHQ0dXorcGpv?=
 =?utf-8?B?STJ6UEQ5ZFhwRHd3ZlBNVncrQkFkQjYvbjFPMWNpT0xONDlsOC9handVdXZH?=
 =?utf-8?B?WEVYSy9uY2ZmSGVRTDZLSHdXQWtqU2UyMW9SSmxoV2dlbUsrcFFaQTZjU3py?=
 =?utf-8?B?eGd2RDVRNEovRU9qM3Vpd2pEd21LZzdRRGxlOVVSamw3elRGczlmdDhCbWVF?=
 =?utf-8?B?VW40RzVhaUE3ZkRhNUZqdWU4OUNxWVF0NUlkMWFIU2lLaExMY2taZVlnNGJ1?=
 =?utf-8?B?ZWMzSEQ5NlhXeTB2ejNBSGdCTzVhc3g0ODBVd0hVci9admsxMFNsbEZiekhs?=
 =?utf-8?B?dWNEOXhDbUU2Tlo4dUZsN1VISkhYcmU0bndoN0FlMkphNzJJeGZJSElFRlJ6?=
 =?utf-8?B?TTQ4L0Z0b1hHbnlXQjNMbGoza2hTalRnTUtmYm1tdVk3Z0tZMDN6bndGU3NG?=
 =?utf-8?B?Slh1ajRCRmYwdk5uSUFUdDBsN0dxamwyUXFRbExhTVVvNFdVVUpQYVdMQmll?=
 =?utf-8?B?OVdsRW15bmNtS0tZcHFPSDNySGlObENrSGZpbWM1bWgxQ2JkU2pCckw3M0RQ?=
 =?utf-8?B?QUJWYmxGTWN2eU9BVDBYKy9BSUlxT3RhWlRjeFI3RlQ4Q3pJUTBxelB2SWJQ?=
 =?utf-8?B?SFZJc25OMHJlZHBCZWtoRnNtK29rNnNmTldrNmJyRFJtNDNXQmFiTllXTUd2?=
 =?utf-8?B?UmMycUNET1FpMTIzUVVXV3l4QjFXZUN3b1VRdlB2TitjU3pJMHFFU2RWWjBv?=
 =?utf-8?B?UTlhN2xDTGhmZEVDbzBDMTJjcUgxbDVYdkgvT1J0eUw0OUt1S0U5elA2cHc5?=
 =?utf-8?B?VERSaDlTR3U4Nm9BdFltaG45MWExQ1VTSkJTaVR5MTFPWThvYWJHN3NleDFN?=
 =?utf-8?B?RVNjci9oMURzb0sxOE42SUZqbFFGdUtwSHh4UGhVbTZBY0ZLQk9kK3lHSFo5?=
 =?utf-8?B?eW5UeFBFUjJPVWI2aHdTdU1pWlQ3bjlrQThGNVJLRWg2NFRBZTRGeVNVYzY0?=
 =?utf-8?B?QktSVzFpNTlGcm1mdWpoSm9BbVI5SzFzVS9SVWhVRi92dy9TSHBVYW5jRkdO?=
 =?utf-8?B?S0NubXkzUW5uSS9VUXhWb3ZtazhheWNBbXJqZHNwb2haZ1FKMHFLdHFHOE9y?=
 =?utf-8?B?ZzV5cFBaOEwvaEY0dDFBUUFtZXJ6SUZYUmxxKzVCN3VURnpIOXByWi9uVzBW?=
 =?utf-8?B?eDJBaGF4WCtRK1NhY0VUcVBuZU5hL05jWEVDVmZyY3hURWlOUGcrUUM2VXBt?=
 =?utf-8?B?N0pqSFErWWpFa0l1K293aFZmS3lyQTBIL0tZK1c4VUo4Tmd2TEFiSW1YWXht?=
 =?utf-8?B?MkU2VXlzZU5MN2JyeEtVUVA5Qm8vQ0MvYjRBL2Jnd0RlcWw0WlNWSkVuMFB0?=
 =?utf-8?B?K3NKTG9LRVJFRXlSQzUrQnNSdG03dm0xQ1RPOUtxdzNZWTVRUVdEajhSekJS?=
 =?utf-8?B?VmUzTWorNzlzN1hVNlNDRmlERzZxNGtmSFpOSmZtK3laWHVYa0hLYW9BbVk0?=
 =?utf-8?B?c0QxTGJjblhjd3lyTDRIcWd1TmoxWUJCMzZyUVpmY1NSY1Y2ZnpobjViSjdp?=
 =?utf-8?B?RFdLdjB0THRhc0IwQXhjaFh3Rld4Y3UrMFVwNnVEYjdHeGdOdlpKcDlmVE4x?=
 =?utf-8?B?TXVBSEQvcFQxWGE4WVZPOTJSQzBmaHhyVU5QMzdlakx5K3RNdk1BdlUwTy9Y?=
 =?utf-8?B?SVcxYlkrQkRwb0o1WlZBVWlpdWdXOHRSM1pieGRGRUoraENVNWEwRTdhcGpr?=
 =?utf-8?B?RUc0Y0IvWmN2THR4MlViVHpGNjVUSStoaW9iRHJxZlJYdkJJZzJXSVprSjho?=
 =?utf-8?B?SkttR1VBeG1mUmlrZDBOcG9mVzhOUTk5QzVBb1kwVTRvZ09oRFR6TGVIbDFL?=
 =?utf-8?B?ckhPeUx4cG1iUlRoV3lVdUxneEdvbng5WjA1WXNEMElTUmJTU010aEpnYnNT?=
 =?utf-8?B?cnhzUFd1eHg2cHBsSUhvWUZ0NmZOMkR5TTlWbkxOREtSblFldm9ldkRic3RS?=
 =?utf-8?B?TDZMdlpKcmFBM3BHZ2ROdEtma0QyQjg3c2dEMjVzWUJHRzByVWQ5by9XUWhi?=
 =?utf-8?B?T0h4aVh3cG04emV6c2xheXQ2RDR6N1RuTUdIdXRNL0lHbFdvTTE3VHRqMlp2?=
 =?utf-8?B?Z1JOcERKbHEyeXB3ZkVKTjM2VmN1ZEhqYW4vVklKRnNudkZZSUlBYSt5LzA3?=
 =?utf-8?B?NWpLZWhZSnZPeUQ4R0dmWlU1VzlJbVgyLys3M1puZXIvVk1Qb0xUdHl1cEZO?=
 =?utf-8?B?YnRXOUZWeVROcUNTZkhiVGs4aVZtSzNNbnlEcGVoNU1aMVV3Q2EveDZQVWlt?=
 =?utf-8?Q?BWTLZXqydsrBIoUQ=3D?=
X-Exchange-RoutingPolicyChecked: m14qgGCopKiTq8DBn/vIcovvYmh1szTnD17p8jLF45MpRiU6OaZnr7QqZvAojxkyAxIK00iGKjQS5sXOHtwkYjTz2nHzWZdgUcwMmJe5qNBNFFgOs/HmD48Wa5kzxsPY5AA7owxzyoYApsGNW3KCYPKCL1k8waFbg1QK0+KdRTK21gRu/HpPsRWA2N/VdE6zuDhPyO1YyYi9wpw1xwgcYyl8H36py+feDSYSj3uu6JrVkWZXW2wkNJufbihbomnOaDu8gUxToH6+czyX/VbMu1l3oIboGwWxhe6wCjV1F5aXcibSMuY+vWvFGABRlLXvRCAgvGjyF4FL/1paBh46zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 000024f7-9fc4-4b2b-11f2-08df23f3dae8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:50:36.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtPm592HY0Ic67p3OIitFRgs2UYnGbyO1Ac5Dc+26butyV1ARcOFSkLxKfh1mL6JMgx6yy1ZMof2xzIB8byAM7rnrccLeJF2VrPv/IJMeuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com

On 10/6/2026 7:21 AM, Petr Machata wrote:
> Add a test that creates a tc chain template matching on both source and
> destination port ranges and verifies via devlink-resource occupancy that
> this does not leak port range registers, neither while the template
> exists nor after it is deleted.
> 

Nice to see this covered by a selftest :D

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

> Assisted-by: LLM
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../drivers/net/mlxsw/port_range_occ.sh       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh b/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
> index b1f0781f6b25..c7eba3f15066 100755
> --- a/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
> +++ b/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
> @@ -9,6 +9,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
>  
>  ALL_TESTS="
>  	port_range_occ_test
> +	port_range_occ_tmplt_test
>  "
>  NUM_NETIFS=2
>  source $lib_dir/lib.sh
> @@ -101,6 +102,31 @@ port_range_occ_test()
>  	log_test "port range occupancy"
>  }
>  
> +port_range_occ_tmplt_test()
> +{
> +	local occ
> +
> +	RET=0
> +	occ=$(port_range_occ_get)
> +
> +	# Addition of a chain template should not impact occupancy.
> +	tc chain add dev "$swp1" ingress chain 1 protocol ip \
> +		flower ip_proto udp src_port 501-600 dst_port 701-800
> +	check_err $? "Could not add chain template"
> +
> +	(( occ == $(port_range_occ_get) ))
> +	check_err $? "Got occupancy $(port_range_occ_get), expected $occ"
> +
> +	# And just for completeness sake, neither should deletion.
> +	tc chain del dev "$swp1" ingress chain 1
> +	check_err $? "Could not delete chain template"
> +
> +	(( occ == $(port_range_occ_get) ))
> +	check_err $? "Got occupancy $(port_range_occ_get), expected $occ"
> +
> +	log_test "port range occupancy after template create/destroy"
> +}
> +
>  trap cleanup EXIT
>  
>  setup_prepare

