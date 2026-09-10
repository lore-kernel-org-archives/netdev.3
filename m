Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AF4718CA
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076272; cv=fail; b=tkqHqhkCT34TWcFf1+NTFOSJhnfOc70ZW+FI4yg8c3UD6ZdkVi9JswNy6UXzC/nlDgCJvZrxxZq9cgqcA3MgrmuWudrq/YupHAb64JkP8uq0h+b4LplHnDYYGfh1lzZOEwKnGwoi15Oe1OvPm/n9n85BWBejgmc1D3IpEn0AqM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076272; c=relaxed/simple;
	bh=/+WXggZpKi2x7iomr8vGlevLIIlGwBDgGStrx2JqRM8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NB+MPYSmwPvgvb48ks6IvmU4FInW5k+3pe2w2Cl76bZ5tXNiB0D/vG7qVLF5JvI732oPLZSH1L7aQ3tBJKqTmwqa1ckFUK6aELQRwPoLmleESBqUFnhKQPQ1D5m+ybvmvhSy6ZFnVoOL6xz/wVCT/0OMcrHfNen21eOO3ge8dAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giIAfllz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giIAfllz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789076265; x=1820612265;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/+WXggZpKi2x7iomr8vGlevLIIlGwBDgGStrx2JqRM8=;
  b=giIAfllzm1rPsCl3BeUeMFjjeK9G7uE3+PGjbf+imAqJ2Puh9okyei2A
   X/ooBi6SyR8fi7omPvG1Lu6wiCiCCnSLnoikJiiZNn+QRGBDLs9Iqtnz2
   3TG3Z7yqO/7UYad4FK9UiBx8O8nxcx+HoYHwcUpaU6WgJMF72YfyiGezF
   wnSJ0TXgkLQIqWNszpXLcG9PjRceXklGTe88Z4mE5qka0+zPzRnB85X1J
   N8YNvroMw300WwJF5k/mk16ohIbA0f+CejCuKWng6libNJJolXSGjV70r
   9L/kbapoeMGc0KKU/7tQeo4z+zSZVlO//96Lwd2mY4GOJu/PV9DGdmX3I
   Q==;
X-CSE-ConnectionGUID: CNAtbS6rTZOILrSdC3RY0w==
X-CSE-MsgGUID: 8CryG6s9SfujFzq/FkEsJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89305020"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89305020"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 14:37:41 -0700
X-CSE-ConnectionGUID: SqbAAG/XTreYKC50+W4O7Q==
X-CSE-MsgGUID: q+c26V3gQ9urogBgV+kbmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="275275014"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 14:37:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:37:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 14:37:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfFS/giQhPs6WkEOdHbncFcbU4Uj9zsDD0Hbfcuxgem0reY1ysXuWbGjQtvJHVN+Qi5GJRpx6G/xqBCfbltKYfnqXUzT9VLk4D6hYutBa9nf44ocvi76KUAzBDKUVHIUgLgWB32BfOnbnHKxb8o6IUanclk4GhDVexXSBS6v/Q8TbsC28avcoznEKoZlaTaHJpX/s+oJjmfna5jfzfP/a30MKKz3fNfrpWPPoqARS4GO7F4GdvVOZWwG4EVQZ8Y8xX5a8p9gQe5IQIUS/qBPbew1lJm5rxDlG67SlXODh/ByQCSgzKGPdbWn6ndZy1CpwaE+ppSmuqbzudDGVW74jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F50/OImruBCkjFdbmgPTflKTf++gEBNX42ZU3wFtKgA=;
 b=otdq+Xi+glE+43vjZ2rbECJcrtjnYUSee0QPNArdrHQZI1gvMTMX7upHd2OZblN2EaJYaPWwjldLVFtaA2PnQQ4Fh+t4psW/Rr5nKYZgx/XhAFdFNTP4HEXf9Xfv8vZrhy2/mfZV6IfV1zEUtF+SErXi64k2QBzI06EfedRKOb1kS5tTkMutcYs+tLbRWtX/oYWZEqx4LEf90bbFIO+hdM127DVvvLBamqvPPXib5Dk3RIZOi8w8FUho6vt/lOS+76PpwtfzS2qKrLCbv+kbIcQSqBocRyZuCiSVdn8rST++wazaVouueSv8Z3szNY5gcwg+6j00NJWqsnuDbj4Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by IA3PR11MB106965.namprd11.prod.outlook.com (2603:10b6:208:620::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 21:37:38 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 21:37:38 +0000
Message-ID: <5e55342a-9cbd-4a5f-84d9-56a80ac42664@intel.com>
Date: Thu, 10 Sep 2026 14:37:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: Fix "Unknown bps" during link events
To: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jakub Kaminski <jakub.kaminski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Tomasz Lichwala
	<tomasz.lichwala@intel.com>
References: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|IA3PR11MB106965:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1ded76-54ab-4b5b-28d8-08df0f83bc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|18002099003|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: BTwctJhTrg+CHXnZ21Lfj2JuIhyRhxbgo7LsdC9l3qmp84/ivqkDMhSRGXLw+F/ypry0hnV1XlewcCUFTvPJMuUvYNwuyP4+YAY9UTGfFoErOw5twjw8yFWSDWRPxLhwi5FCanamztjqwDp6R0zkIjygn8RY2/hn2Ti2S5NTIA0DwOCM5MjnGzHpD5eZzT0uWSU3R5AFjEsARyQDgYrkw+612jVMJbuASpAcurVwGy+aPewL5GuBZXIe2CR4URlTiLql3LAetFwW0CXpYzS6RG5zw85m/A7YIks/vj8IWiC3qKKszwbzuHV/X8r84KfwXdrCGZKv74/IUoG817j5WPpvbdiXkUBX85rVxqbEXEG8RkYjx7ejUk0IRqhMwudKZbpHpoNClMFHecpQ7fB++IPa3zncHcsyOHRFrFP8ZxkOx9ZZYnU1OjqW5dAmEWw0wK+ZLFeKZG3YMqW67YUIIL5DjQ6XWL2Z84kl4kPG0SvQ3QcUeuGk3DSx7P2xoswwcju1WGPvV0VYKgXatAO9L8ZWKuVrs4YCjcam/YG6gHPuKroFWSZirMvL1gBUNOPYrzIWkL3jLm2gq6zi8I98Grxv48QaRyPguAu7RgGdNBJdI8Y0FU0U2SFcRQvttMhxzbxpoOVRXFYe+fT+Lj97f+zIEUU+v6PUlWPbeyKLoU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(18002099003)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9sOFVkS2JCVE44aE51T3pJSFQ3MEk0clo4Tm9tZGhPK2JHQyt4azJZZDRv?=
 =?utf-8?B?amJweUNBenhtcEI2a1lYU0dIbi9NMlpnR2Y1MGJFbzB0eTRkaEFZVEEzb01l?=
 =?utf-8?B?K25JRWkxZ1pUcTdnYU9HcGdmdTZkWUZqb05Fb1pkUlNJZzBncHJzUWg0NGla?=
 =?utf-8?B?QnlRWmlWRmJiU1ZKZndiNFBvTXp0L3NNR0graCtPVjhadXd0UXI3eVJHaXp3?=
 =?utf-8?B?azA4VnVzSUJsWVYySDUxekhPSnp3QmJmSUJ2M29JQ3U4MlRiRE9mQ3FJbkNJ?=
 =?utf-8?B?N28yOVRFR1daVWJzZXdJbG9MdDFPU2dZbCtBZ0hET3I0V0dCU0VqakdTMjc4?=
 =?utf-8?B?ZVlOQ21iNTNtZkE5cEdLZ044TUVXNW5abzdYd1A3WjAwK3FrSGI3QXh1MU10?=
 =?utf-8?B?anA4RzM2ODNXekVQUUZEOUQyNVRDdFFLSnVvWWhSTmFSK3RFUFRrSDUvVmpL?=
 =?utf-8?B?VVVTRi9yWXJiWHd2eWFXNmdTNE9nY0dxeUhrdWxLamtQL1l0dzVZdDQzd1hq?=
 =?utf-8?B?SitJQzRSYVdTUmZRdmM0eDVkbXZSamlsRk8zMHhIYzRjYmZOZHF4R0ZpTnFa?=
 =?utf-8?B?blFtUUZyb3Z4bHFCRzBObzNMcWxsbnB6SThLcGNROTN0UllTU2ova3VQNlNG?=
 =?utf-8?B?eXJsZ2RMSEpwb25JKzI4bEQxN2oxK0ZxcXp6bnFyMGlCQVJlM3QrZmw0UUtt?=
 =?utf-8?B?cjlGQ1ljeVNHeFJoTUVQZFBFWUwwelRaVlVPclpXaEI3T3ZsT2VOdVhXN0Rh?=
 =?utf-8?B?U1hqT2dDUHo2TFBmNUIyS0FNMGhnS3Fzblo5TEI4U1pyTVUreFd5OCtHODNF?=
 =?utf-8?B?bnp1OXgrRnRhVDNMVDRJUlJNMEN0UVBYUTQ0ejlxeFROdHNCN0FVcWlWbWNQ?=
 =?utf-8?B?MHdYYlFUSnNIUGFkSmNVRFhNOWUrb2o1SWExejBnZ2FWTmYwTUpZamhSQnox?=
 =?utf-8?B?SGREaTZ6UHBPSlB0RXpvKzlTUVJrVjBqcHpEckpUaDFRT2JxbHJBTW15OUVM?=
 =?utf-8?B?d0htUDNXQlV1dGk3MTdDMDh5bjZIVWRReWhST2h3bUNmaWFOZG5HNnlmaGJK?=
 =?utf-8?B?NjdsTVRnMUY0cVd2NGlpd3F0dFZ6cWdHQjdWN0hDTE1FZ1ZKTlpzb3dVdzdW?=
 =?utf-8?B?TEtOK2VZTWExcSs5eW90Ym5wZ2sxN3BpVDFZS0l6T1J5SG1Pd3htN2lGQVh3?=
 =?utf-8?B?ZHBnMkFtNTJtNjRvaXVhT1Q4aUlNdy9qRnJmS1N6V1Fkb2tlUmJPZW5aTXFR?=
 =?utf-8?B?TGptaEJEOEs3cm9FYXNoNVNMVThZcFdlWUpOUDhReXRLK295WEVUai9pU0w1?=
 =?utf-8?B?Z3N0dFJWbTFsYXdaSDFzV2I4M3grKzZ6UFR3S1lqOFhiQUJKNWlCUUx6NkZG?=
 =?utf-8?B?dit1RzBhOUZYUUFVQ0RUeHdneUJhOStoZ2ZkcEJVemlpeFRoL29Uek5JYzZt?=
 =?utf-8?B?R2p6Tkl1NnR2TnpWaTFhWHNPcEtObjNUbFRVelJrRWhyOExXVEZmUThBV3pi?=
 =?utf-8?B?TjNmNk82MVE5VzYzMlJPRlJWYll1N0pVSlEvTmxCS0xiZnBPbHdHM3paWk4v?=
 =?utf-8?B?aU1aWEVsVHpiblVWODgvVnlxYmJNbmdpNFJtQmx2eW01ZUM2MFhINXFTNTA3?=
 =?utf-8?B?R1RIbFQyUFRKQjZ4aW1tN0NSWUw2RDFiR1pIaUFmNUM3ZytvdWtLSUM1eTM3?=
 =?utf-8?B?T2ZJN3R0RHRGaTNiQWd4bEFleTNZR3ZVWTVJbzVYaHlDYlZDbjBROEZWTytF?=
 =?utf-8?B?djNzNnV5cWdYb0c3OFFrbVhkdVQ3MjJmSmxNMXdnajAvZTR5U2IwSnVKRUll?=
 =?utf-8?B?UGZoZzh1ZlFLOTY5ZGg0eTVxVGJDUjErbTB2cWVmNGs2bHQ1Zk1nU1JpL1Uz?=
 =?utf-8?B?YjJBMzVmc0ZnN0d4cm1reXhtejVTQTlQRDVsTVlwUkU0ZWxCQnEwZGY3bkFU?=
 =?utf-8?B?TE1vdDl5UlZMbVF2ZVNiNzZrd3JOTmxNS3dXT0ExaEV0aDFyVmtBaTVoT1JP?=
 =?utf-8?B?T3hWRjBCMUdsNlJNSWoyTDBUSTd2YjdlZ1NxS2hKNm5TcllzZzN5MGF4eW42?=
 =?utf-8?B?QXFrcER5cVpQQSt6U3BIUWxFMnVvY1pWTWNaSkRLMHFyN21KbERaVkcyOEpm?=
 =?utf-8?B?QmZYN2ZYZk4zbWx4S2ROTWZLaUZRbTJZNHFqa2tiV29OSWdUTzBsVWNKZUc4?=
 =?utf-8?B?dUc3OHExK1QzYmxTbXFFWEVuUitaL1M4OXFFZ0Jmc28vRXl5OHdoMWxvQ3Fi?=
 =?utf-8?B?VjJWZ1pYRUFpanFSaXR2QjJNRWcwaWtQaEVpMTc0OFRoNDJtWko5M0VGWDNt?=
 =?utf-8?B?NGpUK2x5ZW0yTGkyb2NVa1FGdkVDUXFlZHZWY3pnRGNseHp3blNjNG5tMDlx?=
 =?utf-8?Q?+g5fwLcONiKMvEcY=3D?=
X-Exchange-RoutingPolicyChecked: TyQrjq8MNjHczhH1WHTc/MrevHHSi3KeTz4bd75jHvM+Dp0FxfjZ+Wg2ywKwvq/pH8ynqer0X+cowiBFtwu/n4zIEkCn6HCY9Db5k/4Z8qXki489CEi1ftozP/imABKjpKCdVKc6Rjsye4HsJoTrGSCNREgo2RuVfTs2atmV0NyOx48S/U5SOYmUU1Wzm0i/2b2oOD43xbk2+QP+WdwxWfnqc72YTrp0TS2I6hWWIJ9MPD2mhfCjSKcQO9jSp1ia/5/TFyr0dRSaWOt0jVJhyKTa81u4dFrANDbYtHQl0cnny1gWq5eyh3qWSxy8NLHEsvc3A/Ab3hCXPlAMb9GPng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1ded76-54ab-4b5b-28d8-08df0f83bc19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:37:38.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Oq6Bmn20BVxaubpPwO4QUoVh46lsIutn4C2W60fXFDtQ8mTl6DaNghjS6mw2l2uSR5lX6RduQ8rDEhfQU5dB3Um/MEY9IqQBhqNtmoy5ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB106965
X-OriginatorOrg: intel.com



On 8/6/2026 9:24 AM, Lukasz Czapnik wrote:
> From: Jakub Kaminski <jakub.kaminski@intel.com>

...

> @@ -1190,11 +1191,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>   
>   	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
>   
> -	/* Check if the link state is up after updating link info, and treat
> -	 * this event as an UP event since the link is actually UP now.
> -	 */
> -	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
> -		link_up = true;
> +	link_up = phy_info->link_info.link_info & ICE_AQ_LINK_UP;
> +	link_speed = phy_info->link_info.link_speed;

Sashiko says:
Does this unconditionally overwrite the ARQ-provided link_up and link_speed
arguments with the cached AQ state?
If the synchronous AQ query (ice_update_link_info()) called earlier in
ice_link_event() fails, for example due to an AQ timeout, the
phy_info->link_info structure is not updated.
By unconditionally reading from this potentially stale structure, link_up
and link_speed are guaranteed to match old_link and old_link_speed. This
would cause the following early return block to trigger erroneously:
drivers/net/ethernet/intel/ice/ice_main.c:ice_link_event() {
         ...
         if (link_up == old_link && link_speed == old_link_speed)
                 return 0;
         ...
}
Could this silently drop a valid hardware link state change, leaving the
OS and the hardware out of sync and causing network hangs?

Tony says:
I think the right/wrong combination could cause this to occur. I, also, 
think there's an issue with accounting for the link event and updated 
link info that could get lost if it changes.

Thanks,
Tony

>   	vsi = ice_get_main_vsi(pf);
>   	if (!vsi || !vsi->port_info)
