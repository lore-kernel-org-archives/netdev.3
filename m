Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11439795E
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695098; cv=fail; b=cNsTOLWj7aFUdoXVGNGTtPPpOlHj0+n23LstMEtIlIJjqjq19fRIF63M2bIIS4NP7RirrMk2ygvvFINirtcLOnlhZWdcESwTdU274zO+jUDrLuGWrAiB29UQ4DBvGyMVCME+d3YcMKq5MLF/HE7RSJk1TJP0JmLq7N8Hmbq9UgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695098; c=relaxed/simple;
	bh=EaV+GnkXS2adS3h0AmEZBkozQQGQRKEXlEx9uOdHf2s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vEN+SnNGM1mM7Drcjldl76xi93A4mZGcUiuAXI8v56FNWlWmxfjjGp7WxbeRhYSJms0sFzmv8F/AdhYqU9J8btKwr50G3A04Dssh5snh2lfxwBL0N3aFJn2788EUsNIXIGMkZj9S8OdvgUUHt5OODi3BeHHFVs35jDzvcThP9JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjGaUO4+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjGaUO4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789695095; x=1821231095;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EaV+GnkXS2adS3h0AmEZBkozQQGQRKEXlEx9uOdHf2s=;
  b=AjGaUO4+x3czEukolF1sdfTmCk5JS8kd03CbCnW/ga2xT80HUSqw/by4
   GpaDB1ItWU5Y4dCwXVa4Vrh2rkjgZjjtfPe0O3FDdHRCpMcoIjiitqEFL
   k4QDCYxFI5ETNd1HBzDE6a5dCOxzh2kEo07AD44ZTfKsrC49fz6ycaBRL
   owL9cxXLIJ7O7wVVHSpDKkQ/Y30RTrzRFUdm6DLAfGXX32oEkw0i1p7Xc
   d69ARBKDybg9I1WLYo24TLU9cGYJJVdL8BQqjxtc054LGo8X3zQZ4TkmJ
   birTo0UnNyfnboGX1B0cTeV8BSLOjZvZb7UnWykDK7U6OtB11jDhB/6kk
   A==;
X-CSE-ConnectionGUID: 9DFHISjZRIqEt68wAtPTzA==
X-CSE-MsgGUID: lA/yQpFLR+mC5jmkBV6/Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77736519"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77736519"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 18:31:34 -0700
X-CSE-ConnectionGUID: 5RYmirFyTp+G2qZQKVDg9Q==
X-CSE-MsgGUID: GSc0x8hhQD2WvrH6fSJS7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276092601"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 18:31:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 18:31:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 18:31:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 18:31:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYAlWUgY7Q9EXYAZwN1iuWwEPA54ZsSRXrCZSPh4JwyD7SJgiAJTagxF0H8svGr6DOlPXLvqhQMK0lAZ3yqhYud9tETsEJyn5N1/ApmDfoyAnNG3LbpaclEcAdVYlpZNlWkSPL5qYcIQGFuJcs9IBEpeCuJvFdYjtFzI0Bk3GgyZ3K1tJVSixYif+WDa8xE1skQVX5krRtx0UzQ1lXOHDVPJ7BanFtyV8kaSrV6JtpdzY+KiNTQt5//RxfB0DyEMUoMoAiREfHLZ/ok3xJEvSbsnKhK6uk9zuqlxGbf2WMaY9FqpQwyd621PPJ8SGynMUi9NX/75f+QYaHazLy0NzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=conkgp8DR+VmePqo7pxC1R3OsCFeZTiKb53ej2jSwf4=;
 b=NNDRaK+GxbBmiaaJseZGUrQSUSPM8fdarBHOep+LFTAWdQhQGppq5jcPsCy4lt2yXTZW3H2YROX914WkazC8ZllNYA8STsY6EYQAeU2P74dPq7/y5zumi9d3TxriI/5kEzjPXxWHM8H+V5BWAeIUUkXA8xr1s7QwMkl+LIRKQ4zTgdSr+UzqZha2yBYvdKnoMX7HD8wku/2J7PGZ36Ja3CObqHASZ+mtD0SFI+zfWaE9iJY+RPRiONUxXBRKJBQNlPjhbTJwMHk6RTzQF5/oYA+WW5A+Fyj+s7p3LZYxY/qYf0lC2K6vNcgWICZs6Np5M6lC1rGdFNEqlyq3DdNebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 01:31:24 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 01:31:24 +0000
Message-ID: <cca9e600-5dc9-413e-9885-7320e31dcbd9@intel.com>
Date: Thu, 17 Sep 2026 18:31:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/15] ice: call PTP link change only from link events
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-7-anthony.l.nguyen@intel.com>
 <20260916011218.1632528-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011218.1632528-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA1PR11MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: f23a8860-1a0b-495a-9aa2-08df15248d0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: UzttqjluLUQ3KSeBWvN50jb8R3VoISs9Jc5//EIQ7buxwhIydCqoGnqMBvBB3Qh79EY5PEoDAg3+6Is/aWrEbHIV0QprjKuCg6dHDBFJuxMGVvr/xcXsgY1C6pVa1mgwT889aRFnNVIMSR290Uu+pQlZi5VtegfRQ8rqTktDcgdpmHlEZg722PXedPgWXXmIoNlxB6ZOsqFVwYfiPzzABeq2jeHbkf49tKWFx5WZ5Drv5IFbvIJpzwnofX4+2JogeY1vyo33Dd4CVCzORNrexUZknjqUIdFb2Rb/qscgipyioxkdAYnjLQ+plCw9DG06w0G0UQt9UEaPH5xE1OhpPmYmqmqp70JjnonmYCbdPIyIAsmQULulZ+rFLarzf+GG447dgxtJ2beV3nRH566cN9MovAFOXzNgbcf7qTC3PhjUJsmOf/psInyESZ7qYqalstLz8yycmupHuvw/3b+K5vSRAGi65RJKVjKf51KRe4xXqaMoN8bsZWOVIMUnCoWSqS1ZmVBUDjUiMvc/GC35uQ+ZHgqzt/6JbIDeex2Dgqd1Aq6zNwsCEHnnaUBrqX7bXL4o/aUfnmjZUzrn/hhopJYsemiipwxhml+/01FgyiHL/Le7Lv79raBL2fkj+FXaQbFfshSbwXDlfGx3ctE/vNcTWMjUWnieHWbQc48iZdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhWN2tDeldjcHFhRm1tYlBYbzkrcXNtQUFPOTUwbXdxNVJLcWwrMDNWTjhN?=
 =?utf-8?B?SVF6TEllQnNiYVVHdXlzd0wzSVJjUkF0MjE5b1pPc3I4TE8zRjBxRDRZOHZw?=
 =?utf-8?B?dEFWalgvU2o1MkU2UDZJbWtneHRrekRuWkhEWUFiSmgvOWFSSmZVcGZDL3BJ?=
 =?utf-8?B?ZkUvNVRyREtwdEV3RjdPUW45Q0xVd2ZERjhoSXZtamNOTUpFM2gzeTZaSmRV?=
 =?utf-8?B?NFBENkR0dXVuQWRpVlhQUEQ3KzBCYzUySXREd1R6b1lTbWp4Skthd3AxcmFY?=
 =?utf-8?B?bnM2UUtyTHRzTkFodDNiNDJibzQzMU9rSWx1TkNtTVdMZHU4dXhTTitHY0Zt?=
 =?utf-8?B?Q09lT29NZzBzQS9JMUZ3eVJiMTBKT0Z2bXI2M2xOZnYvZ3JTVDhESDJwUzZV?=
 =?utf-8?B?YWhWM0djSVBQYkoyOEU3VlhNUGU1MUhRck1oSTdmZXVyMm5LMThtSUNjQ1dN?=
 =?utf-8?B?ZHBQVDBnSWtWTGwxZ2VuR1NSSU9laFVIN1QxU0laWGd0U1BrenZVMVkrY0xi?=
 =?utf-8?B?eWNHN2psclNwN2FPRmRrOGpURWRPaklrUm1NM2dXbkViZnJqbXRpVStrdmF1?=
 =?utf-8?B?SXdFckpic2E5a1M2QlFyRU56SzR5Q1hQeGlvaS82cVJDSzhsTUdXYVk3aGtF?=
 =?utf-8?B?c2hxcG5hN3l6WUNjRVV3QTEyZGllNllnUXlLZTlDUi9DLzBDWFo4T0FYdUEv?=
 =?utf-8?B?K0tyYWRVVkZwcHZsRnBVTnBuQlFqd2hDWDFLdVZzaEJyY1hBNmE2TjhYWXZF?=
 =?utf-8?B?S3hWbDVUNTJ6WVZ1NW42WDNhbENNZ2psbm5leWNCM2ZXMXFDcmFmUzA5YTFS?=
 =?utf-8?B?U1djRDVuKzQrcWVLWTBEQ1lacEZnMUUrSzVRbGxVbVQ0YWFubHhEaWlldlRo?=
 =?utf-8?B?STVpdEhWTU5EYnhUb1lOY3pZOURQNXJYZmUrRzg0NTJGQUNlUUZrRXlkM1Y5?=
 =?utf-8?B?T2FnczVscndJNjA1MmZCSkZaSS83R3U0cVBKZTQwTCtXNUtTSElIZFg5OWhx?=
 =?utf-8?B?VlRWTHRZaVk1L0lnVVVIOTUya0M2eGZsMnhYdGJMbnp3S3NjcUE3Rk91WlU1?=
 =?utf-8?B?cy9XRzFzcG9teWJGS1pMTUxXZTdVemRvNjhseHRtVFhHQlhDYVloU3RVS2lw?=
 =?utf-8?B?V3BGZHFsTkJBTFVpSDBucW1FL0IycnJTWCs0VitzOGcySUFrWENqd1l2MDJx?=
 =?utf-8?B?a2d6R1k4QzI5dVdEMUw4cnVGNkNPd3VRY0pyTWQzeElkaklpdmM4L01CMnhW?=
 =?utf-8?B?bk4yblpERFhQb09QVFRJVDFscExLWXFxWHZrMDJTbTFSeHZtL3V2MUtkWlFP?=
 =?utf-8?B?Rmc3QjB4OUttSC9MOE14QnM4bERKUkE1T212OVFBYWxCMkpLZVB1SEhudTVY?=
 =?utf-8?B?dHhGYTArQkFmeEpJWFVINVhrM0F2Zm80NGVTd1hqSVpBdXNmL1FvVDlzMFI1?=
 =?utf-8?B?MFByUTk2Y0dsVC9MdjBYYWZLa0xTRXBxMGRaRnUwLzdyUCtSQjBnSE9tZ0Zi?=
 =?utf-8?B?M2QyZW5DL0hGdHlNZkgzRWZBN1YrSmFVVHZGeFIwMjBPanpiY3ZTVDc2SnRq?=
 =?utf-8?B?VE4vQlRkY3k5c1dZcHhmcmpkRjJrSGJFM2UvT3RmcXFXZStaUVowaEZvdHl5?=
 =?utf-8?B?bU9jbnkzMWU5cU4xNjZmRnhQRjc3OXhWamxyQ29YZnZvK1lwakRPYWwwNXpV?=
 =?utf-8?B?M1JUNUlkQ3ZDUEZKOEQyN2VlWEJKZ3c5TVlqQTBETk5CYS96VzJYWjVvQ2k5?=
 =?utf-8?B?dGJvZnJnSjlUQXdLWFFkVDdkNnozLzdtc0JLblEvOVhZM3NGS0FHUGFSU1RU?=
 =?utf-8?B?Q1MvWVBHZWlaRy9kYzlzNEpGMjJ3eUFXZ2VteGpwK09Zb3dXc0pyTkZQQTg0?=
 =?utf-8?B?ak5PSXdJOGFGUStrVndJNUtSM0x4VXlzbE52bFMyZTVyV1JrdnRhVUtwT3FB?=
 =?utf-8?B?ODhRYzV0MHJrakR6QmVnazdLZ3RxaXlPVmREVTcrbTE2TmdyRjZrY0QzeHRR?=
 =?utf-8?B?ZmxManF5L0lNaHV1eWdlQUVINExWaERNbzJzZS9xN1RaUTRYMHd5VzlPc092?=
 =?utf-8?B?MTlMcnhjVzhKeGp1WFVNSHl4akxZTmpPZHpheDVkV3ZEQXQyMHlqOVAxc2li?=
 =?utf-8?B?bjhHTGJ5K0RxcnNhUDJ6YldOMndyRHliQzBjNUFZZDNBS05Oenl3a0tJZG9N?=
 =?utf-8?B?TThzUUZFSXZmTzczcldGczM1UUJtTGpnS0gyMWNJWEdQRk9JY3JUc2dBWmVx?=
 =?utf-8?B?SDI4N09JQUtqMFVaVk13a2tVSDhWMnNCMDNiVGI1RkMvMnpVbmdKNDZaMW1q?=
 =?utf-8?B?VGxDcmNhaEVnR3NoalBTalNVd0lHa0dEMlpvMW45MWp0YVZDZlBqUT09?=
X-Exchange-RoutingPolicyChecked: FEqCn3pxzjkz7ZHAjmv4/ZIdzCOH2Ig/ycXY1ZNiIx3e9odckFBtfzkKHEAYwePJKjWng5BByGG6sVKSTte4kphCQfQLBeBey+2eHHAKUVIfaLKF4Bhzob7E3o4A0P9YVjljkNynmlOd21FHum8atRV9R3Lpv7KFUyZCH2gTuWVBfeNzRkdKRTyzdhKd3uNNhvqHaAwgQu+lBsmC8GC0cAcYt+OWx9yEVB4JnnjRZFJiTWCDb/KAEkklj9qR1U0ssniVDNkIzk1PNzd/f01O6a8YXTYw3rdFrIVUjww6e6INJwQnZgjR2igt6l/55VSSjz+GKdDGN3R356HpPJJY+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f23a8860-1a0b-495a-9aa2-08df15248d0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 01:31:24.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB4UCihz0PixHQUhxWOn213wGyEfCwvAo9zfArUufoxfewq/kDXUGNFbKIDXjTMgy+XG268HgPV7hTvlJNY4G9adJXtqcq+8bcj2rlfq4Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8200
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: call PTP link change only from link events
> 
> The patch drops the ice_ptp_link_change() calls from ice_up_complete() and
> ice_down() so that only the admin queue link event handler drives PTP link
> state, seeds ptp_port->link_up during ice_ptp_init(), and re-checks the link
> state at the end of ice_rebuild(). The PTP kworker creation is also moved
> earlier in ice_ptp_init(), with the periodic work queued only once the state
> is ICE_PTP_READY.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index d88835482d3aa..f32041dd8b274 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> 
> [ ... ]
> 
>> @@ -7273,7 +7272,6 @@ int ice_down(struct ice_vsi *vsi)
>>  
>>  	if (vsi->netdev) {
>>  		vlan_err = ice_vsi_del_vlan_zero(vsi);
>> -		ice_ptp_link_change(vsi->back, false);
>>  		netif_carrier_off(vsi->netdev);
>>  		netif_tx_disable(vsi->netdev);
>>  	}
> 
> [ ... ]
> 
>> @@ -7794,6 +7792,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  
>>  	ice_update_pf_netdev_link(pf);
>>  
>> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
>> +		bool link_up;
>> +
>> +		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
>> +			     ICE_AQ_LINK_UP);
>> +		ice_ptp_link_change(pf, link_up);
>> +	}
>> +
> 
> [Severity: High]
> Does this re-create, in the reset path, the same double PHY
> re-initialization that the changelog describes as problem 1?
> 
> With the ice_ptp_link_change(vsi->back, false) call gone from ice_down(),
> nothing clears ptp_port->link_up during reset preparation.  The only
> remaining writers of that field are the store in ice_ptp_link_change() and
> the new seed in ice_ptp_init().
> 
> ice_prepare_for_reset() calls ice_pf_dis_all_vsi() -> ice_down() before
> ice_ptp_prepare_for_reset(), so previously link_up was cleared while the
> state was still ICE_PTP_READY and the local port was skipped here:
> 
> ice_ptp_restart_all_phy()
> 	if (port->link_up)
> 		ice_ptp_port_phy_restart(port);
> 
> Now link_up survives the reset, so ice_rebuild() -> ice_ptp_rebuild() ->
> ice_ptp_rebuild_owner() -> ice_ptp_restart_all_phy() does a real restart of
> the local port, and then the block added above calls
> ice_ptp_link_change(pf, true), which re-enters ice_ptp_port_phy_restart() a
> second time within the same ice_rebuild().
> 
> For ICE_MAC_GENERIC that second entry does:
> 
> ice_ptp_port_phy_restart()
> 	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 	...
> 	ptp_port->tx.calibrating = true;
> 	...
> 	err = ice_start_phy_timer_e82x(hw, port);
> 
> which cancels the offset verification work queued milliseconds earlier by
> the first restart, re-asserts calibrating and restarts the timer.  On
> ICE_MAC_GENERIC_3K_E825 it re-runs ice_start_phy_timer_eth56g(), i.e. a PHY
> soft reset, timer stop, incval reprogram, PHC resync and clearing/setting of
> the offset-ready bits.
> 
> Neither guard in ice_ptp_link_change() short-circuits this call:
> ice_reset_subtask() clears pf->hw.reset_ongoing right before ice_rebuild(),
> and ice_ptp_rebuild() has already set the state to ICE_PTP_READY earlier in
> ice_rebuild().
> 
> One more question on the same block: ice_ptp_link_change() discards the
> return value of ice_ptp_port_phy_restart(), and the E825 restart begins by
> stopping the timer.  If the redundant second attempt fails, can it leave a
> previously working PHY timer stopped, at a point where
> ice_update_pf_netdev_link() has already turned the carrier on and woken the
> Tx queues?
> 
> Would it be cleaner to have exactly one driver of the post-reset PHY
> restart, either ice_ptp_restart_all_phy() or this new block, rather than
> both?
> 
>>  	/* tell the firmware we are up */
>>  	err = ice_send_version(pf);
>>  	if (err) {
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 9bf3bac552f11..4dec728e219d8 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1323,9 +1323,6 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  	struct ice_ptp_port *ptp_port;
>>  	struct ice_hw *hw = &pf->hw;
>>  
>> -	if (pf->ptp.state != ICE_PTP_READY)
>> -		return;
>> -
>>  	ptp_port = &pf->ptp.port;
>>  
>>  	if (!kref_get_unless_zero(&ptp_port->ref))
>> @@ -1334,6 +1331,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  	/* Update cached link status for this port immediately */
>>  	ptp_port->link_up = linkup;
>>  
>> +	if (pf->ptp.state != ICE_PTP_READY)
>> +		goto exit_kref_put;
>> +
> 
> [Severity: High]
> Can moving the state check below the store make a half-initialized port
> visible to ice_ptp_restart_all_phy()?
> 
> ice_ptp_setup_pf() publishes the port before the rest of PTP init runs:
> 
> 	kref_init(&ptp->port.ref);
> 
> 	spin_lock(&pf->adapter->ports.lock);
> 	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
> 	spin_unlock(&pf->adapter->ports.lock);
> 
> After that, and while pf->ptp.state is still ICE_PTP_INITIALIZING, a link
> event reaching ice_ptp_link_change() now sets ptp_port->link_up = true
> before returning.  At that point ice_ptp_init_port() may not yet have run
> mutex_init(&ptp_port->ps_lock) or spin_lock_init(&tx->lock), and
> pf->ptp.kworker is still NULL.
> 
> ice_ptp_restart_all_phy() gates only on the kref and the cached flag:
> 
> 		if (!kref_get_unless_zero(&port->ref))
> 			continue;
> 		rcu_read_unlock();
> 
> 		if (port->link_up)
> 			ice_ptp_port_phy_restart(port);
> 
> and it is reachable from ice_ptp_settime64(), which does no ptp->state check
> and ends with:
> 
> 	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> 	if (hw->mac_type == ICE_MAC_GENERIC)
> 		ice_ptp_restart_all_phy(pf);
> 
> The PHC character device already exists at that point, because
> ice_ptp_init_owner() -> ice_ptp_create_clock() runs earlier in
> ice_ptp_init(), so a clock_settime() on the owner PF, or a reset of the
> owner PF concurrent with the probe of a peer PF, can reach it.
> 
> On ICE_MAC_GENERIC the restart then does:
> 
> 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
> 					   0);
> 
> with pf->ptp.kworker == NULL, and kthread_queue_delayed_work() starts with
> raw_spin_lock_irqsave(&worker->lock, flags).
> 
> Before this patch link_up stayed false for the whole of ice_ptp_init()
> because ice_ptp_link_change() returned before the store while the state was
> not READY, so the port->link_up guard skipped the initializing port.  Should
> link_up only be published after the kworker exists and after the port locks
> are initialized?
> 
>>  	/* Skip HW writes if reset is in progress */
>>  	if (pf->hw.reset_ongoing)
>>  		goto exit_kref_put;
> 
> [ ... ]
> 
>> @@ -3443,6 +3444,22 @@ void ice_ptp_init(struct ice_pf *pf)
>>  	if (err)
>>  		goto err_clean_pf;
>>  
>> +	/* Seed link_up from current PHY status, since link may already be up
>> +	 * (e.g. after PXE boot) with no link-change edge to catch it later.
>> +	 */
>> +	if (pf->hw.port_info)
>> +		ptp->port.link_up =
>> +			!!(pf->hw.port_info->phy.link_info.link_info &
>> +			ICE_AQ_LINK_UP);
> 
> [Severity: Medium]
> Is ptp_port->link_up now written from two contexts without any
> synchronization?
> 
> This seed runs on the probe thread, while ice_ptp_link_change() writes the
> same plain bool from the service task via the admin queue link event
> handler, and after this patch that store happens before the ICE_PTP_READY
> bail-out.  ice_init() clears ICE_SERVICE_DIS and arms pf->serv_tmr before
> ice_init_features() calls ice_ptp_init(), so both writers can run
> concurrently.
> 
> There is no lock, and no WRITE_ONCE/READ_ONCE pairing, between the probe
> thread's read of phy.link_info and its store to link_up, so a link
> transition processed inside that window is silently dropped.
> 
> Link events are edge triggered:
> 
> ice_link_event()
> 	if (link_up == old_link && link_speed == old_link_speed)
> 		return 0;
> 
> so if the surviving value is false while the link is physically up,
> ice_ptp_reset_phy_timestamping() -> ice_ptp_port_phy_restart() takes:
> 
> 	if (!ptp_port->link_up)
> 		return ice_ptp_port_phy_stop(ptp_port);
> 
> and nothing later corrects it.  On E82x the vernier timer would then never
> be started and timestamping would stay off until the link physically
> toggles.  Note also that ice_ptp_port_phy_restart() reads link_up before
> taking ptp_port->ps_lock, so ps_lock does not cover this field.
> 
>> +
>> +	/* Create the kworker before restarting the PHY, which queues work on
>> +	 * it in the E82x restart path. This prevents concurrent link events
>> +	 * from reaching ice_ptp_port_phy_restart() while kworker is still NULL
>> +	 */
>> +	err = ice_ptp_init_work(pf, ptp);
>> +	if (err)
>> +		goto err_clean_pf;
>> +
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but since the unwind path is
> being reshuffled here, should err_clean_pf also release the Tx timestamp
> tracker?
> 
> By the time this new goto err_clean_pf can be taken, ice_ptp_init_port() ->
> ice_ptp_init_tx()/ice_ptp_init_tx_e82x() -> ice_ptp_alloc_tx_tracker() has
> already allocated:
> 
> 	tstamps = kzalloc_objs(*tstamps, tx->len);
> 	in_use = bitmap_zalloc(tx->len, GFP_KERNEL);
> 	stale = bitmap_zalloc(tx->len, GFP_KERNEL);
> 
> but the unwind only does:
> 
> err_clean_pf:
> 	mutex_destroy(&ptp->port.ps_lock);
> 	ice_ptp_cleanup_pf(pf);
> 
> ice_ptp_cleanup_pf() only unlinks the port from the adapter list and drops
> the kref, and err_exit then sets ptp->state = ICE_PTP_UNINIT, which makes
> ice_ptp_release() return at its first check, so
> ice_ptp_release_tx_tracker() never runs.  The same leak existed on the old
> err_exit path when ice_ptp_init_work() failed, so this predates the patch;
> the trigger is a kthread_run_worker() failure in ice_ptp_init_work().
> 
>>  	/* Start the PHY timestamping block */
>>  	ice_ptp_reset_phy_timestamping(pf);
>>  
>> @@ -3451,9 +3468,10 @@ void ice_ptp_init(struct ice_pf *pf)
>>  
>>  	ptp->state = ICE_PTP_READY;
>>  
>> -	err = ice_ptp_init_work(pf, ptp);
>> -	if (err)
>> -		goto err_exit;
>> +	/* Start periodic work only after the state is READY; the worker
>> +	 * returns without rescheduling while the state is not READY.
>> +	 */
>> +	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
>>  
>>  	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
>>  	return;

Some of these link state changes may need deeper investigation to figure
out what the best solution is. We effectively had a situation where the
link state change could race with our initialization flow and we could
miss an event. I've tried to clean up what I can but it may not be
possible to easily resolve all of these issues in this series, and I
will likely end up with some compromise that is better than the existing
behavior while still requiring some follow-up investigations.
