Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342F37266E;
	Mon, 17 Aug 2026 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944281; cv=fail; b=nLy19KgGJFiGLUy8spIlM/PfnUboe5zHqffx9ceb041dmd3jTMxFvN01/CLihdOiPi0uYdl88ldvTp4Q8rrGfh11VY03TpdNXS2zpJ54QX4hfTlKMhcqo8y+4z2ysFI53BMMe9iBl8h7MEm/qyI2jVVtcqtQO5uwvT0nHOiX4eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944281; c=relaxed/simple;
	bh=cIXr8ASMHgNu/KpY8cgBol+tXQ2U11N/crrrOItP9Qw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X9UVmonTD3iUJmuooYyXRmiGBEpGMwquhhFdNmfttA3jKjMHeFWLVvgiEPKViOThWQ5QeEx+/OTv+oHfe98CnekzSBfBMzqS/nWh2hq4DRDdXRA9zxdZFM8eyHQ1bJbquz6oo6MxcwmfXHy/8MZJO9Y9uB8U1KdXQwqAX8oJF3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2eW9C/Q; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2eW9C/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786944280; x=1818480280;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cIXr8ASMHgNu/KpY8cgBol+tXQ2U11N/crrrOItP9Qw=;
  b=i2eW9C/QMykoDEWR1g2NryEW9dnQfwAplXfFj51k3ztq3bk5nbv9+9H1
   72dLnjnxsFXsk5EXrRAFkEusBLdQo0jeUUnP66dUjev2kWi8EXxoUH6Lf
   CBLrs4pWKyYccRHMu083+yjWsQMAzkDL5yytNYVYhxWeigF8omhYrTfNu
   9/jPc9fjC1k2fyHXenYCrarCS3jukXB4OuvIpfpmbO9t2fpOzZW2OTrt9
   mL2sHKiNi1h3if0f3jTB+xZHBmKvB6zOK7NFyQefGmPxG6u3PR8ixZ/1a
   KlSd7e8uL5keznAPiozn5dJ2oe+1bHF+QGnxU9WHPbAoPin61OUEt1JfB
   w==;
X-CSE-ConnectionGUID: VSANpEI5RcKXTUVz2ZHByA==
X-CSE-MsgGUID: KtNDt3mAQECqx48XKBvC9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="112955871"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="112955871"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 22:24:37 -0700
X-CSE-ConnectionGUID: EuQ92EqNQ3Wz99whPEPlmg==
X-CSE-MsgGUID: X/wRCyANQhKbD2SLiCbQVw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 22:24:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 22:24:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 16 Aug 2026 22:24:36 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 22:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGs5KU/W3VmcMwv6QNuFuwHBi57eqzf2HBViYCGY2ANo96qZ9n296D0DgoGiTeg07mUNchrvbGVQdFigOGBWGc1NxNygFNfOlzjTMUzbcCVxQT15rECIhOjB4k0PPU+2K+QzafoWtOlAxdYSfiGSmEz+2r7r8vV70mMesTFXGQILYdoLjKdU+1faKFxKKa8ICoSxX8HdsYcVM+I6Cn1MaT4ap/JKOgtT21xbylKvxcfacP2/EK5IfSzSgFQW1gDRjleUcekFtnhUij2DRn7U5QCvKKL/npT28m4BvrXAYvK1syHIVsxOPVNQHjUqxutBDL82ZnpuPOYllgwz0Kc2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEw8hQd+qnmsJ8AysVK0StHnp4As4cK7ClHf9hkpVsI=;
 b=D7wI3MF6beQWqv098Rkr5fsEXQlqIX7rMR8cftMX0qLfe8TsEp2wvHvSJ/eO5n6wEBMuwl9oGcaHbEDiV24+VP61I7+aTTkUVUY583sBDQ4ki5LmOIIV0SwYZ90rghnBU7j/RVzgPFG2J0kRZvnpZWrqMmHbNuBwuuiL5cF7byg1F+oaQ9CcCJUypTVGmbFWiqOaHQ46DC30SgXmbke32teL/dTUpvOOVNKLrryHChq00OfoZXfp4NZl9F3AUbSwUw99qXmU9787NI3pYBEatq7JR0MSCi/T1968F7yNJWkxqIuemKLtdRI5v4ue3A/94GjKZHY5l76duS3hJ/761w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:24:28 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:24:28 +0000
Date: Mon, 17 Aug 2026 13:24:18 +0800
From: Philip Li <philip.li@intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
CC: kernel test robot <lkp@intel.com>, <jonathan.lemon@gmail.com>,
	<vadim.fedorenko@linux.dev>, <richardcochran@gmail.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Message-ID: <aoKbAv8I8Ld6DhoN@rli9-mobl>
References: <20260723143908.4019-1-maimon.sagi@gmail.com>
 <202608160048.0KcqzO98-lkp@intel.com>
 <CAMuE1bE-a2EM70nx_6u-Tm5WskK8=afSdKbG9oH+csYpRzPdPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuE1bE-a2EM70nx_6u-Tm5WskK8=afSdKbG9oH+csYpRzPdPA@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|SN7PR11MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f47bd54-cfdb-4d0b-3aa8-08defc1fcf31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aY8xKxbDBtC/+iygpJYQcOgyEAEL2kL4fnn1dcucIeGu3OrOto60pYb7JIRhKQF57plUDQRe/KxbclcN7jwildJ5Cn4gA2i8D6zjSHKP7ToKUGvUngqpt7pC2tmwKCjOVCXtxd0D4AArepD3m7G3mIwBOGTf3zBriYzk1shR6epgg1Qu6LR4Yd6LYGyMV25USrd30qXMCHa/TmqGSc6cmkGk9M9P7W1to/zoY+FWHE4TchrKxBrnan8PYc2Vagk46Fb/HxCGHzG0CyTKtbBMAOOfQqy009pv/bGNo5XpRv/lL/8dq+7TourPzL1zjFehK1I/+RftHfT9pC+lUz5kweJ8pGFak4T4OjJpPGklMDH1+PzNOuGcfuz9IYRXsCIeHriVEfoxLMAq/GJwvroElY4oi3ZNwtP8Ihdntqnd6yZ/3+KbIt9iSuMjl18rPV+QyJb6B8QdM/JiETm6uL0cwRWfnVrkHw/UxxrIM11QWl8GnLM3T33/w9m0pMj0AoxcQns2ucZkad4T28LWmSKjdXEJrfhqpImwzz/+5ZRf8imj3g/LM40IG+R+OBajp+lAt/SCC0CQKDDKKnL/RBfLcySWs78K8z6irBR8u51G4qos0HiX5qN9km4WB0CN3tin
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHdudDhINXdWNnNPMFFPckE3NUlXM0R4Rnk4eWR0TWNnSWVyS3VOMzk1TlZ6?=
 =?utf-8?B?TERFendVM0ZYUHkyb3g5TVNDeW9xUWNzaXY4Q0dLOG9qQTRsRXZuNlNsV2Jj?=
 =?utf-8?B?UzdtSXBBdlhiTmxkWnlRTmZLQ0FtOVBCWHVNenhxeFhFQjFqK1VYT2M0bWgz?=
 =?utf-8?B?Q1doMjlUQ1d0SlJVcUZZb3VYeU9qU3hYRUdtM0UxTmRiNWkrZVJWb1g1UFpk?=
 =?utf-8?B?MTBPeG1IQ0FnVXZxMlFaY3RHQ3lFdHZGNzFHU3lZTldRMytadmQxa25tcnpF?=
 =?utf-8?B?emZla2VnMWRqMVgyK0RyczBUVFZKUlpxd3NQb0lkakR4YUJiR213QWI0dEpC?=
 =?utf-8?B?bkZYSTBTekVSZ2dUbi9QeEdpVm9VUnlqYjNmcEIzRzJ6MUFremtjS1lXTStS?=
 =?utf-8?B?djg3TlJnZDdWa2plSXY5K3N1RXJlMEc1Q29nRDAwSFN5R3dMeUNvMDhQRmIr?=
 =?utf-8?B?bUNQOGtLbjVycXpmMkxkZm1TU0FYZ05TbERCZjZHTnFGQ0V5c1NsNWxTQk45?=
 =?utf-8?B?VHBMWWw2UG1HalZkRm80K0lKQWtvWE1ZZzlzdHI5UnBkbTJ4WmxGdzE1ckEv?=
 =?utf-8?B?YTZYMU85YkRiME03Wm5KT1ZzbHFUcEE3SUc2ZDlwQWdyMFlHMDRHSjdjU1E3?=
 =?utf-8?B?QVdYTUtVMXAzdUczUlBROThMQ0d5MFYvWkhjMW1MaWJ6SUdISlNhbTBSeUxj?=
 =?utf-8?B?L3dnVytKY0hhZ3N6YXZycE9mUDVxa1IxRzVnMFQvTTlWaDVUVUJqQ1hoTlJr?=
 =?utf-8?B?dUNzV3BETzN6aVFPTGFZZ1lUQ0hIZ0pic2VraE5SbFk0OTE1RXZzUDlvbytQ?=
 =?utf-8?B?bU95RWlUNmdyemNpK3pZQldJODByR3RrNmNIMDBtdDgxcTNhYnYxS0o4dkVn?=
 =?utf-8?B?eHl6SEQ3eEFnaVQvN1ZyYldLdWlMK0kvWlcva2FVTGNVeWtxKzRlZHJYUlpx?=
 =?utf-8?B?TWFISXhUTzdWRXVaaFdHbzZmT2JscVA1cHd6TTluL0hjWlpKMFI4NHN0Nmth?=
 =?utf-8?B?aDVZY01hek1FdU1mT0FNakhaTGxXYVQvSEFVY2syMGZxcW13c2xSV1VkM0RX?=
 =?utf-8?B?K1V0MER4VlFJdC9DMDBwQkNrVHVkd0d2T2ZPeVhtUHJNN1ZYTTBEYnd6VUFn?=
 =?utf-8?B?eHpody9UQVFXSTZTQWs4TkJ5UWdFaURtcHpMZExMNnhyTWpSaGJwUUo4eGZm?=
 =?utf-8?B?MGNNNU5vaklTc0QvMVdPZUFTRlJQOVE5clAxZUxxZnNVczYvdFJGdXJ0ZVh4?=
 =?utf-8?B?QVZOcnY4NytXNk1iZkNlbnZlYXRZVGdxamFIVUM4NncyNUIrYlkvaFR2Tlpq?=
 =?utf-8?B?UFlyODg2QTVaZWZONncwWjQySVVmeHdhU0k1Wjl6OWJQb2FrSU5ycDNQekYv?=
 =?utf-8?B?ZGsxamM2VWV5ZElCcnZvMEhKTFBEWm16dVBZNmV1NlBqM3RtbWJvYmFGVVBQ?=
 =?utf-8?B?aGdmZkVJS21zSkNXSzRYYk1hT0hVKzgvamdISFJqYlZOTDJlak5NWEk3VGIy?=
 =?utf-8?B?c1RHeFRlbGEveW0yOVQrN0d0TEp3ZmpjWG1mSUVKQ3gyMVVWZVptRDRBRm53?=
 =?utf-8?B?MWpsVHRPczZNb01yL3FhRXBDTDllenlIZWNSeXZMRk0rMlJud2tYRS9lYy9x?=
 =?utf-8?B?RDIvajZBazJ6SlpTNGZIamkwWHR3S1hRZjExT3B3MkpERnRDODU2cE9yMWkx?=
 =?utf-8?B?cHF2NUZWRklsK2ROSlZabk5UelZiU0FHWjVtYzhNeVQ3MWpVbFpOSGVVUkNR?=
 =?utf-8?B?UmxNVFNCRFE2clEyVjVHZmE3aEVzVTJNMkJWQyswMjU2QmZjTXY4KzRxYmdk?=
 =?utf-8?B?WEFWYkk3US96QVZRZGZsVk41ZmNwV1lTR2I3bFFWWFNJREREanM4WVFYOUtP?=
 =?utf-8?B?M09VQ0lTZTdwTFYzanVrM3pyVU1VYklBL0xRTjNvOTJvQnZlUERwYTJuMWVJ?=
 =?utf-8?B?ZmNMK2RUUjRSSEdJTk82Q3R4eDlYTDh2Z1BYeFpMMmtldmpYS1JwZFY3b2p1?=
 =?utf-8?B?SFFVSE44ZmRGd1pFRFNaSUNSanF4WlpBOUI3cXhWcXhGbXlHY1h1bFlna1c0?=
 =?utf-8?B?ZHM3R0RkZU9wZnp3YWNJYVZ4bmxZRW11SnpIV3Zqd2VMeU5wejI0VDJ3SURG?=
 =?utf-8?B?NzFZV0FIQ2RSWlYrYzBqd0RaVGx2bVp6eU5MRFlEYXlQMGNYSWhqK2tnL2RZ?=
 =?utf-8?B?L1Y0Z28wekE0NkptL3JlTkkyMDRVbUQ1bUpWc1VqZ3B6TGpHNDJKa0JzbGR3?=
 =?utf-8?B?ellnNE1JbGFPNjZITllTQlNaTFF5QUVqVEFqVzlVQVVWQnFaMVlsMGFiaEJC?=
 =?utf-8?B?TDhLSDlHZ3FPOGNxWHNDSEErQ2ViOFA3TGl0a0wyQ21MTDVQRklpdz09?=
X-Exchange-RoutingPolicyChecked: W4gss0Amwp9i5ZcOEmOjvykVGrXIMel5KrIGQ2dV0R6sddi1IZHanRHzR+kmblhaCa7LsshR8DMeBBT8t+du7Lfcn+JhD1zHXjyqdFVuuszsWV3HnCJOxoJIxO9iJEBxB5bFZt32Nxs2CKOEuZ7TMx4neIFVa99CT6/g1YaWacNZG1FYwTkRynYSn4p6BQKapMAXP8zr5cICvMQIqc0Wjbq0qC1xoGD+U3hp68rlBC3tIpiuJYyujM94gv9RDZjey8FGbshaPCiGR2JutHfV5lQSS4fFkRRUVTdMAQhvRbnAc/kWX4fBVrTc2wRf3DQEcPvreGBks2BcCKRTgFfqIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f47bd54-cfdb-4d0b-3aa8-08defc1fcf31
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:24:28.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DnfH8d7z+CIW0y8ZCw2ipoLHQRfS732FiSucrirQcHlQHfnqWTLcDzKdYjMI+ie4XiCxE09tzeR77y3vac5Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com

On Sun, Aug 16, 2026 at 09:02:37AM +0300, Sagi Maimon wrote:
> On Sun, Aug 16, 2026 at 1:54 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Sagi,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on net-next/main]
> > [also build test WARNING on net/main linus/master v7.2-rc7 next-20260814]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/ptp-ocp-add-CPLD-ISP-support-for-ADVA-TimeCard-X1/20260813-075719
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20260723143908.4019-1-maimon.sagi%40gmail.com
> > patch subject: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
> > compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
> > docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
> > reproduce: (https://download.01.org/0day-ci/archive/20260816/202608160048.0KcqzO98-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202608160048.0KcqzO98-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
> >    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
> >    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
> >    WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
> >    Documentation/ABI/testing/sysfs-timecard:14: ERROR: Unexpected indentation. [docutils]
> > >> Documentation/ABI/testing/sysfs-timecard:14: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> >    Documentation/ABI/testing/sysfs-timecard:14: ERROR: Unexpected indentation. [docutils]
> >    WARNING: ./block/blk-map.c:366 Excess function parameter 'op' description in 'bio_copy_kern'
> >    Documentation/driver-api/basics:42: ./kernel/time/time.c:370: WARNING: Duplicate C declaration, also defined at driver-api/basics:436.
> >    Declaration is '.. c:function:: unsigned int jiffies_to_msecs (const unsigned long j)'. [duplicate_declaration.c]
> >    Documentation/driver-api/basics:42: ./kernel/time/time.c:393: WARNING: Duplicate C declaration, also defined at driver-api/basics:453.
> >
> >
> > vim +14 Documentation/ABI/testing/sysfs-timecard
> >
> >   > 14  What:           /sys/class/timecard/ocpN/cpld_i2c_xfer
> >     15  Date:           July 2026
> >     16  Contact:        Sagi Maimon <sagi.maimon@adva.com>
> >     17  Description:    (RW) Binary sysfs attribute providing a raw I2C passthrough to
> >     18                  the CPLD and I2C mux on ADVA x1 TAP boards.  Only present on
> >     19                  that board variant.
> >     20
> >     21                  Each write initiates one I2C transaction.  The write payload
> >     22                  must be exactly four header bytes followed by the write data:
> >     23
> >     24                    Byte 0: slave address (only 0x40 and 0x74 are permitted)
> >     25                    Byte 1: number of bytes to write (0..67)
> >     26                    Byte 2: number of bytes to read back (0..20)
> >     27                    Byte 3: flags
> >     28                              bit 0 - suppress the repeated START before the
> >     29                                      read segment (I2C_M_NOSTART); only valid
> >     30                                      when both write and read lengths are
> >     31                                      non-zero
> >     32                    Bytes 4..: write data (write_len bytes)
> >     33
> >     34                  A subsequent read() returns:
> >     35
> >     36                    Byte 0: status (0 = success, positive errno on error)
> >     37                    Bytes 1..: read data (read_len bytes), present only when
> >     38                               status is 0 and read_len > 0
> >     39
> >     40                  The write and read portions of the sysfs file share a single
> >     41                  per-device response buffer protected by a mutex; a single
> >     42                  open() / write() / read() sequence must be used to avoid
> >     43                  data races between concurrent users.
> >     44
> >     45                  Only slave addresses 0x40 (Lattice CPLD) and 0x74 (PCA9548
> >     46                  I2C mux) are accepted; all others return EPERM.
> >     47
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> This report is against v6 (20260723143908.4019-1-maimon.sagi@gmail.com).
> The cpld_i2c_xfer attribute it flags was dropped after that revision; the
> current posting is v11:
> 
>   https://lore.kernel.org/netdev/20260811135720.109580-1-maimon.sagi@gmail.com/
> 
> I checked v11's sysfs-timecard through the ABI parser and docutils - no
> indentation warnings.

Thanks for the info and sorry for this meaningless report. I will fix the
bot logic to avoid such report.

> 
