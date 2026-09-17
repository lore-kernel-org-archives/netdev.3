Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314B49D599
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661964; cv=fail; b=gnkWP8mu2hsP7/BdiPr5QowtBnUeU+pGJbcGKs2fvBRZa/vdjSmDkLanS9dTFf3qqnqYWuvqQBsj8UWFCeOCFL79Mu4VjH2/pnEr7TfJckojR+Smk4/Vq8kgo7/dZ1KjRKXShvW+qFmr8hZZAsYnkgn/n+ZgPmt9QzUY6+mjfb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661964; c=relaxed/simple;
	bh=3cQvhZKf6d/08IFDoVM8ZurvTTW8V9vA4nz7Hh8QPPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hybRePf21mzyhcz5mQSFxaQozmB3GQ3g70wnS7ZdcwRVzZ35RZ/vCwzbS7RaaxEax097nCxpivIm6HgT+4iwEwOL5VWl8xhqhdBsMxOpal0RK1M604lfs3aG/wgUzrIPdzlA5MD/a1RbU1F+UOVzrkmYN1mIxe9HaZ6uHnkCiu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDXxLRvc; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDXxLRvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789661962; x=1821197962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3cQvhZKf6d/08IFDoVM8ZurvTTW8V9vA4nz7Hh8QPPA=;
  b=kDXxLRvcuz1dE8sZjMCm3vHeCeZShRKgpO8QJ8itwCE5DvLiOuB4gxqT
   mcDkCCiVj25nsfGehM8Z6Mc/K/TTGnpH2D781DkQqNenukNhoaJJl/u4O
   Rccj5wCsu9QEZLkMOnlBtwEQh9ZDLdBL5OplpEQ30mZBGZtLrn1bLdrDG
   71EiAAUOdpGLhSoBGr9QrgHDoxhKDggvYDlOwigQA2o+Ypp/I02my+Mio
   RSFLIesKNIOyXxct21pm3Be57cKOWo7ve4Xy1B2G9zGBvDkvvD9yO3/HF
   CF64rzFLPGYsU0x9TEP++xUvJSzMg46DMfFDRL3WRPv01g0X3Yu4o+NBY
   Q==;
X-CSE-ConnectionGUID: JbINim/CT1KBWSogKIC9rw==
X-CSE-MsgGUID: h727/JrvQaCWPnsa4EfNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="610021"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="610021"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:19:21 -0700
X-CSE-ConnectionGUID: OLPEb3YRT+uQs2OQD5S52Q==
X-CSE-MsgGUID: 84CB8vCeSF2rPw0ef4zajQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297380482"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:19:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:19:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:19:20 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3XVun6BAJuAbcmfUn8T5N6h2keMSwNDS0oJwYNeN0PoZ1+mVNp7aEwBD2R0twXEbj94KvcVV9S/30hTEHwYEWNf6ynFW3ztrlEarZqDhg+KfGYrhl0R2Pa31owREG9SC0gA3yVXV9hq48Qrx95AWzj6KoyrjVDjtNwREOo40ONUftwFGmxCk1DWuoOky3M4CWnT/V4Y619vwEV6Abx/2ZC5gs3S9P+a8bJaCC25gQd1N1DmZPN15MGYWAVaTZv+1I/Pqvv5Q8NaR5zEtTy1wynwSi1/6UA0ffsLBIDTi9AVWfJ0BISv9y33OfxrguNHwHBfmuBiy0R66KQjR1AHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8p49QCcV2QYVGUHQcpzXIakyzFe1D759tEqik+cx88=;
 b=QUbe610kzNu6wcDRdXcXOE5+Q0iaJY0svJEdS6SCbignqFFFUUnK0x27m2CPZkkLd42N49FM5VcjdKXMkysEloPJjcdKeoAv1Ikizdf5sZcao3iqd38a1UPNvu8YF82C9BnmtDRAq8WaSibaOhGUMjrd89usNppFAdyvkqwYdteV2Mxprngl7/fh68CBHnUBTSmecbUpm/c183I1fQviLjOPNRJ2xwYXexU6OkBb2qodRsAh58i68FeX+3U3UYJ/y/iwOxnHhPD7O66zlU9bySov4jTmyfG1N71UWDdscrnL40h65LP+0vKRbhBWfZ4fK+bPPRKyLdyDkt4Vk9n9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB4856.namprd11.prod.outlook.com (2603:10b6:510:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:19:18 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:19:18 +0000
Message-ID: <c12c607e-63fe-4967-bcde-a97bdd3fe4ba@intel.com>
Date: Thu, 17 Sep 2026 09:19:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 02/15] ice: fix removal of PTP timestamp tracker
 during reset
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-3-anthony.l.nguyen@intel.com>
 <20260916011213.1632286-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011213.1632286-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: efb2e6a8-c4b2-48d0-1b88-08df14d76c65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info: 9M2SlJpyisf0BNf20xwA0UwUHkyuWhc0Bjh3LqYWoM6BiYq5ODpXYiAXCfJGjior+yUOVJigueW0Zd8esEdA5kka4syTRJIA6ymQU3/NbRxIZma4ncy6YHsajit0mZG1SlsKq1B6cIeIx0yXMslL9/pZsKQxbQ3IP6VQ5fWRF9c3Oiw/GEkAiQ7Raxox2JRFe4FAMp42PZ+J8fC34fsGi7rYuweUSU02mB3BQHpmMfdi9sFkHkKtgl7NYAPvSyAl2s7wzzIRjRbCfqA2mnuviHKXgBXy8s72Kf0AhcI5jnZx5bRiR+x0fn+Ult7mxy/+vHsYQrQz8APQF8gPESui/+vJEB4028qT2+vsuGE+nlqL1JRje0VIv+jL7POTupGBK+s5XhGqwDBEKHGFgGDy8a3z0zo/oBORk3WbVuDyy1g4vY5UwkFiNTUjYDDykmlNvW3Jyj+y8zt87UGoefhVJoXHvI1Z3GhHeRTZmv2G/Wx5mYfTE8z0Jt4FvqnDjoJh9eYLrW+XiyC2mqR+Yzslq0m846MVaqMHkKEFNPkoza8e2tHUQudPguI7YnU7W9rWYoV4GtMr57Z/oegBIbi0q72jCRnafOYQ8BZs6sXLl10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXpXTm94NXBraVU2Y2xreHFpWjFWK2wvZldhdzRNQUdRYk9MUjVYQkhSZncx?=
 =?utf-8?B?K2VKN1FsQUl4VjVVbnd2cC9ucUNRWG84a3lsMEdpajhqbUErNGRacWMyUHQx?=
 =?utf-8?B?TVRFMWVabHROeXl4aE1zV3Y3Y3JYVmJGOGpadU5ady9vSTY3ZmEwb2V3Yjc3?=
 =?utf-8?B?NlQ1ZURUWnBoODVndUFkWUpiKzVSMnJZbHEyZmF6bXk1QW9VTEROMTlZSDI3?=
 =?utf-8?B?cWNmRWVoM0VOL01JUFVQVkY5ZzhXNmNUVnBjeE41VksycVRiRkFwNlpvemdS?=
 =?utf-8?B?UnNjTWFqSitZK0tPQ3lNd2NjY2luejdvTGUxY2ZrbWN1dmZqQlh2MnJUU1hF?=
 =?utf-8?B?d1dVa29OSGVWNW50LzNhd0k2UUNwVmF3QzkwZ1FUdmNoY0lMNFhXUW5pTlFE?=
 =?utf-8?B?MEw4L25nUFFmQlFIdXR5SzdmYmFQL1J4ekpEZGRESkNHUWtUdERCa1U4b0o5?=
 =?utf-8?B?NS81TUswOFhwaElpRktraWs4WkIvKzlZS2Z4TTdva0Y2RkhBNnJMYUdERFNv?=
 =?utf-8?B?bllybGExUHhqRUtFSng1dGJLTmdJMVV6K3lDcmk4eHB2blA2V3czSWdPQVow?=
 =?utf-8?B?QlNDdEhLRjE0MDZQblhSU2xsaXMwSkl3eG1EV0J3K0phSEVXU1F5a2dheXFr?=
 =?utf-8?B?SnJzUWgxZmZ1bFRBVnIzOXo1RFdCejErZlJCT0NUdE1jeFM3MVZZanc2azU4?=
 =?utf-8?B?ajk1dVlESTl5RGt2V2pMSzBHWGU4SStIVjZtQ0hEL0hiTDh0MXFNUWx2SFA3?=
 =?utf-8?B?dHpOck9rUStlVlJ3QjFMOWpKN3IzeWsrN0RVenh6NXphVXlVZCs1NlJOZjV4?=
 =?utf-8?B?Q0lkb1A3TlpGa1FxTWZFYkNLOFdTeDVzaVJ1a2orZkdUU1NobFFPQTEzcE9O?=
 =?utf-8?B?ZEpUdEdYOFA0cjJMZjk2RmRaNkU5MkQ3RHZSUFhIRWZrZFpZejB2QnZaeFlw?=
 =?utf-8?B?NFBaTjdUeGJadE5QRzJLODhlVVl2Wlg3UDFXZjlWM1hKMHhmNzJOZk1DUzB3?=
 =?utf-8?B?RkdhVGFxU3RpYllzZFBwVytld082dXNJc0R1dnVOcHh5eThBVk5aVUJ0czlC?=
 =?utf-8?B?eFVLOSsvZzhIdXVVdEc2MzhxQkJyS2d1UG5uUWZ1T093RWxTeXZYUkxGdCtr?=
 =?utf-8?B?NW1hd0JRRThCQVh6Z3o5UkJDbWNwQTJQYk5iMHNyV3FFZmduVWdiYk8vak9m?=
 =?utf-8?B?ZGx3aDVSVzFXT1gyaEozNUxZWCtGM0pXZDZVaTJDTTZmdG96amgxUU9lZk1H?=
 =?utf-8?B?MkxuNUJucXFIM0tKZjBaSk94MCtTQklNVGpCRzN0b1FUbW1pNmZocDVLVi9U?=
 =?utf-8?B?UGtZSlB0YVJ5cWhhaEYxa3liNEdrRld5OTNIemMyanFHQmJBSlBkUzRQcjVs?=
 =?utf-8?B?N3J6cE1JNUtsMnBJZVUvMnBIWkkrVnRFRlF3Mnh2K3Y5Z3ZLZzZZR2NnT1dG?=
 =?utf-8?B?QUkxQm4vK0w0M21DK09qdkR1ajQwNjRxK2dodC90YWV4NGs0VUE1UmJrcHY3?=
 =?utf-8?B?d29tcnlwbWQvcUFlbStCZUExdVcrakdKM2tQWmVtaHQ0L040YjhJOUNaMVgv?=
 =?utf-8?B?OERGZThaZ3kwZkM3amw0RTNFeHhyVStMUnJERGFpcDZ3TVhDRHZCcmtaL0ZI?=
 =?utf-8?B?VlNJNGtlcUUzL09WZVhjcGpoRzNtZzViS2FqMXpYM29OWitENk92bWNMWHp0?=
 =?utf-8?B?Wks4OEM5c3pxSnVKY055Mk5uL0s2UUtaTFZUNUwyU0NKdDRxTEVRMFk4Uzd0?=
 =?utf-8?B?NlkyN2JnSWVvMkpvdlNOc281UU94RkkrcXhvSVk2MlVYSE5pdXVtb1hnb2Vo?=
 =?utf-8?B?WXNGZjFic2lkY1BiWmMraVpqd3NtOE84NGVqSHFBMXFRMWVHZkNaSTVHbFBC?=
 =?utf-8?B?TGl5RHRJRE1lcndRMUVWdUVOMkt2c0RrdXlaR1BSb2ZSKzY3YmYvSVM4VzZo?=
 =?utf-8?B?anVjbGxnem16SjZ2YnRGa0Q4U3hWYmNkeVNCSFF4WmJtNWljSnYvMHhVenZl?=
 =?utf-8?B?ZGxyc01iNXlUemVoc1NwWTEyQ08zcDNyVXhndSswbThsR0hWUHl6U1MrcVY4?=
 =?utf-8?B?WkpiUzEzK0ZMcEp4ZG5BN3FMNC9oUk11K2xxYXRSWE9wcDdjV2tpU1pBTk4x?=
 =?utf-8?B?WlJNVFlPQXZkYTY4c1VZSmVhdytlUlBla0cyeWg5UFArb2E3MjNpbmxVOEZt?=
 =?utf-8?B?YjFSdkRWWVlwYm9SQm5HSU5DUjhGbUZhS1dSZVRYR2pZQzBBa1VpK0phRXVB?=
 =?utf-8?B?TWNlZnVDRVptb3ZQVy9COWNVaUZmYzFEMzFzUFU5alJXKzN3RTUzK3ArYzJZ?=
 =?utf-8?B?di9sSmR1bkNqTnhKR2tNaVBzM3V1T0d5WkxLVEpQL0Q4MXEyck5XM04vUmFi?=
 =?utf-8?Q?FCotDB9hzZ5GrRB4=3D?=
X-Exchange-RoutingPolicyChecked: g/cVFyi2ogs1YtKXKycshU3votob/B/CGXgonfwWdGe/1jRxIvhFYwyHzwM3Hd0rKx9AuxmSd7t0EThFFsU5j7e5w2IU3Nh+yYmUiszsD6etYsARlCATpBl9Yk3n3knO4EeJzdD22Wni6c0wHbJryBmHgTtK+Qmzn3EIPUvzOaOnBolkAuxmNfFB8hcLcjKgFPo7rgpNPAh2qnmbC5mBqifFXOlBICJghxki68ql1F824TRY8AVUW87tFpVPTJvY/57rdlytmSyHteIp4koCBH0QSzD3d4ZfdVAz1/N5syZER3xizpSbUzaBwhqH0om21D95rghOlG8Ax1H9+jIadw==
X-MS-Exchange-CrossTenant-Network-Message-Id: efb2e6a8-c4b2-48d0-1b88-08df14d76c65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:19:18.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6u0XBa150KCcQE35u5i5ChYNTxo0YOzYkdX84Vsr794DWZaMZrKbUKD5UEsHd84iO+hB8s7PxXLgAiRTv0HI5H8OhsbSjmatc0A59jCPXYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4856
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: fix removal of PTP timestamp tracker during reset
> 
> This drops the ice_ptp_release_tx_tracker() call from
> ice_ptp_prepare_for_reset(), completing the intent of 7a25fe5cd5fb so the
> Tx timestamp tracker is no longer destroyed (and never re-created) across a
> CORE or GLOBAL reset.
> 
> Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
> 
>>     Unfortunately, the commit only removed the calls to ice_ptp_init_tx_*().
>>     This fixed a memory leak in PF reset. However, now a CORE or GLOBAL reset
>>     will leave the device unable to initiate Tx timestamp requests
>>     indefinitely.
> 
> [Severity: Low]
> Is the list of affected reset types complete here?  ice_ptp_prepare_for_reset()
> returns early only for PFR:
> 
> 	if (reset_type == ICE_RESET_PFR)
> 		return;
> 
> 	...
> 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> 
> so the deleted call also ran for ICE_RESET_EMPR.  ice_reset_subtask() maps
> ICE_EMPR_RECV to ICE_RESET_EMPR and then calls ice_prepare_for_reset(), and
> the matching ice_rebuild() -> ice_ptp_rebuild() has no ice_ptp_init_tx_*()
> call either.  Should the commit message mention EMP resets as well, since
> that affects stable triage?
> 

Sure we can update the message.

>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index b12181b8c8434..142d39ee5cc52 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -2979,8 +2979,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>>  
>> -	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
>> -
> 
> [Severity: High]
> This call was also the only thing that cleared tx->init under tx->lock and
> ran synchronize_irq() for the low latency Tx timestamp path.  With the
> tracker left armed, can ice_ll_ts_intr() still run against live tracker
> state in the middle of a CORE or GLOBAL reset?
> 
> The handler is gated only on tx->init:
> 
> drivers/net/ethernet/intel/ice/ice_main.c:ice_ll_ts_intr() {
> 	spin_lock_irqsave(&tx->lock, flags);
> 	if (tx->init) {
> 		ice_ptp_complete_tx_single_tstamp(tx);
> 
> 		idx = find_next_bit_wrap(tx->in_use, tx->len,
> 					 tx->last_ll_ts_idx_read + 1);
> 		if (idx != tx->len)
> 			ice_ptp_req_tx_single_tstamp(tx, idx);
> 	}
> 	...
> }
> 
> The LL cause lives in PFINT_SB_CTL, so ice_ptp_disable_timestamp_mode() does
> not mask it (it only clears PFINT_OICR_ENA TSYN_TX), and
> ice_prepare_for_reset() only does synchronize_irq(pf->oicr_irq.virq), not
> pf->ll_ts_irq.
> 
> Two consequences worth checking:
> 
> ice_ptp_complete_tx_single_tstamp() reads REG_LL_PROXY_L/H of a resetting
> device, so can a garbage timestamp be reported through skb_tstamp_tx() for a
> still-set in_use slot?
> 
> The handler sees the pre-reset in_use bits and issues a new firmware request
> via ice_ptp_req_tx_single_tstamp(), which sets:
> 
> 	params->atqbal_flags |= ATQBAL_FLAGS_INTR_IN_PROGRESS;
> 
> That flag is cleared only by ice_ptp_complete_tx_single_tstamp(), i.e. by a
> later LL interrupt, and nothing re-initializes it on rebuild.  If the reset
> swallows the request, does every subsequent user of the LL interface block
> forever in the untimed wait in ice_ptp_prep_phy_incval_ll_e810() /
> ice_ptp_prep_phy_adj_ll_e810():
> 
> 	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
> 						  !(params->atqbal_flags &
> 						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
> 
> These are reached from ice_ptp_rebuild_owner() through
> ice_ptp_write_incval()/ice_ptp_write_init(), which run in the PF service task
> workqueue where no signal can break the wait.
> 
> Note ice_ptp_ts_irq() checks ice_pf_state_is_nominal() and
> ice_misc_intr_thread_fn() checks ice_is_reset_in_progress(), while
> ice_ll_ts_intr() has no reset-state check.  Would keeping the tracker across
> reset need an explicit disarm here (a state check honored by
> ice_ll_ts_intr() plus synchronize_irq(pf->ll_ts_irq.virq)) rather than just
> dropping the release?
> 

Hm. Will investigate.

> [Severity: Medium]
> Can the tracker allocations now leak at unload when the PTP state is not
> ICE_PTP_READY?
> 
> tx->tstamps, tx->in_use and tx->stale are allocated in
> ice_ptp_alloc_tx_tracker(), and after this change the only remaining free is
> in the READY branch of ice_ptp_release():
> 
> 	if (pf->ptp.state != ICE_PTP_READY) {
> 		mutex_destroy(&pf->ptp.port.ps_lock);
> 		ice_ptp_cleanup_pf(pf);
> 		if (pf->ptp.clock) {
> 			ptp_clock_unregister(pf->ptp.clock);
> 			pf->ptp.clock = NULL;
> 		}
> 		return;
> 	}
> 	...
> 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> 
> ice_ptp_cleanup_pf() only unlinks the port from the adapter list and drops
> the kref, so it does not touch the tracker.
> 
> If ice_ptp_rebuild_owner() fails, ice_ptp_rebuild() leaves the state at
> ICE_PTP_ERROR:
> 
> err:
> 	ptp->state = ICE_PTP_ERROR;
> 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
> 
> and a failed ice_check_reset() leaves it at ICE_PTP_RESETTING.  A later
> rmmod or unbind then takes the early-return branch above.  Does that leak the
> timestamp array, both bitmaps, and any SKBs still pinned in tx->tstamps[]
> along with their socket references?
> 
> [Severity: Medium]
> With this call gone, the only reset-time flush left is
> ice_ptp_flush_all_tx_tracker() inside ice_ptp_rebuild_owner().  What reclaims
> the tracker if the reset never reaches ice_rebuild()?
> 
> drivers/net/ethernet/intel/ice/ice_main.c:ice_reset_subtask() {
> 		if (ice_check_reset(&pf->hw)) {
> 			set_bit(ICE_RESET_FAILED, pf->state);
> 		} else {
> 			...
> 			ice_rebuild(pf, reset_type);
> 	...
> }
> 
> In that path ice_ptp_prepare_for_reset() has already run, so the pre-reset
> tx->in_use bits stay set with skb_get() references pinned in tx->tstamps[]
> and SKBTX_IN_PROGRESS still set, while the PHY timestamps were destroyed by
> the reset.
> 
> The 2 second timeout drain cannot run either:
> 
> 	if (pf->ptp.state != ICE_PTP_READY)
> 		return;
> 
> in ice_ptp_periodic_work(), and the work was cancelled in
> ice_ptp_prepare_for_reset().  The OICR TSYN_TX cause was masked by
> ice_ptp_disable_timestamp_mode() and is only re-enabled by
> ice_ptp_restore_timestamp_mode() at the end of a completed ice_rebuild().
> Combined with the non-READY branch of ice_ptp_release() above, are those SKBs
> and their socket references then held for the remaining lifetime of the
> driver instance?
> 
> For contrast, the narrower case of a *PTP* rebuild failure does still drain:
> ice_ptp_rebuild() returns void, ice_rebuild() continues and calls
> ice_ptp_restore_timestamp_mode(), so the stale entries age out via the 2 s
> timeout.
> 
> [Severity: Medium]
> After a failed CORE or GLOBAL PTP rebuild, does the retained tracker keep
> accepting requests that can never complete?
> 
> tx->init now stays 1, and admission in ice_ptp_request_ts() consults only the
> tracker:
> 
> 	if (!ice_ptp_is_tx_tracker_up(tx)) {
> 		spin_unlock_irqrestore(&tx->lock, flags);
> 		return -1;
> 	}
> 
> ice_ptp_is_tx_tracker_up() tests tx->init && !tx->calibrating and never looks
> at pf->ptp.state.  Meanwhile ice_ptp_rebuild() has set ICE_PTP_ERROR and
> returned void, so ice_rebuild() reattaches the netdev and calls
> ice_ptp_restore_timestamp_mode(), re-enabling the Tx timestamp cause, while
> the PHY was never restarted (ice_ptp_restart_all_phy() sits after the failure
> point) and:
> 
> 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
> 	    pf->ptp.state == ICE_PTP_READY)
> 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work, 0);
> 
> in ice_ptp_queue_work() refuses to restart periodic processing.  Before this
> patch tx->init had been cleared, so this error path rejected requests.  Would
> each timestamp-requesting SKB now be held until the 2 second timeout drops it
> and bumps tx_hwtstamp_timeouts?
> 

We should probably check the state and reject requests when we're not ready.

> [Severity: Medium]
> Since peer PFs' trackers now survive CORER/GLOBR, can the clock owner's
> rebuild flush race the peers?
> 
> ice_ptp_rebuild_owner() -> ice_ptp_flush_all_tx_tracker() walks every port of
> the adapter:
> 
> 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
> 
> and ice_ptp_flush_tx_tracker() does its PHY register work outside tx->lock:
> 
> 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> 	...
> 		if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
> 			ice_clear_phy_tstamp(hw, tx->block, phy_idx);
> 
> On E810/E830 each PF uses ICE_PTP_TX_INTERRUPT_SELF, so a peer PF that has
> already finished its own ice_rebuild() (and therefore
> ice_ptp_restore_timestamp_mode()) can be inside ice_ptp_process_tx_tstamp()
> reading the same block:
> 
> 	if (tx->has_ready_bitmap) {
> 		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> 	...
> 		err = ice_read_phy_tstamp(hw, tx->block, phy_idx, &raw_tstamp);
> 
> Before this patch the peers' trackers had been released (tx->len = 0, in_use
> NULL, tx->init = 0), so the owner's flush iterated nothing and the peers could
> not process.  Can a timestamp be cleared between the peer's ready-bitmap read
> and its register read here, which the comment in ice_ptp_process_tx_tstamp()
> warns can wedge the interrupt generation logic?  Note the teardown path
> (ice_ptp_release_tx_tracker()) clears tx->init and calls synchronize_irq()
> before flushing, but the rebuild flush has no equivalent quiesce for peer
> PFs.

Similar comment from above, we should probably do this same quie
