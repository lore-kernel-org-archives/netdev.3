Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1647FB18;
	Wed,  9 Sep 2026 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988058; cv=fail; b=l/xr2rAsq2u7zrHu5Y/0JKGopD2M0LdfkmvUsuWAjWhCrpmn+QO19aHqn0O4oTCypDl45/jklmQeqe/MfXjxcXOaYe70++noaW8dpLmqtQXO0+GrUrsCI36wak16zC4OGudydTup0+gSPL4Jbh2ps5GZ0JLaGrWL3y8L4gDtp64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988058; c=relaxed/simple;
	bh=WP6MudzK5A7zUe4pkERwImbLE/glDURH1XV0HxrMj3w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jWjbJBoNbps2p0Zbo6WDV+v1QIb88is8YLJYSh7V7XhLhaqmYyZcNYMD25f/MNamlQNaZpXVFUGSdUerghjlaQ/W0BdoC1RwJ7Hra8vfUNYalSsjGihTplXs9hATo3XAOLXF/irjoQbqXz8PriuWsvQMt6xlXEbc9ieF299n7o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtXdkaAw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtXdkaAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788988056; x=1820524056;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WP6MudzK5A7zUe4pkERwImbLE/glDURH1XV0HxrMj3w=;
  b=LtXdkaAwgt9modGDgOCVhYG2RLjS5ZhlsHSeSuyVxKPxIhVtOO5L3sXu
   CSKZdyi6aLti2HgXfZzXszANROWTms55WqFlfWv/VdzhYR9LmPslqy/Q3
   RB4ea8WOA8xxU4wfmO4SgeumPDMUM+wodt1Q5O0awOGCqEretQp6EMfQt
   vFvXqavgK6nsAg8Sz1DBHVELgSIy+H2zIzWmaY52u0g1xE04x4iAKAke3
   bSqPcKmEmAkOovHz7uisJ2FdcVADjNX2iYASYwnDL714fqtAi6LFn0stE
   hpQVpLk9e7Gt+X97l7CIg1ViBXrT5H6YNLHpsc5Tjb/saP1XPBKBtMswq
   g==;
X-CSE-ConnectionGUID: GZY2rP2lQsqdwVmX2fB45g==
X-CSE-MsgGUID: tB8aYsqLSxCainhncx8cXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93253061"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="93253061"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 14:07:35 -0700
X-CSE-ConnectionGUID: jpqHCJk9T327TdWMGIvCTQ==
X-CSE-MsgGUID: UZdfs4kTR/6YWeOE1vv2lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="265229536"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 14:07:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 14:07:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 14:07:34 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 14:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh16Sr/sOSqy79iBIR5YNVQe3MRkoKV1ZOZI5ig2g/3hzK/eN5GLzEX6PrxQEmMpG9IzuttxIKHtbQMXhGmhZa2zmEB72Z3K/Mlj2wz53Upjbl+SwT0AioYhONFCHb7BCYK72ILFBzxdBNiJhwQ34oJZm7+xE1eeuGvDYgrCpaAnNJfaUOsXFhnUc6EWSMI+fRujdPMIoyJ5oPd3FwDzuQo22lSaiy8uiZLDron7DSp2CdrLBiAp9+/9xbdjQ9ZXZ/7Y8xwvvJUXwlekpflgBd3GFMd9CrDb6ItwO8g6AOYdGrD84bBixfbyHKB+Why7+vVbPrkYEbpxaWDKikI39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLyimXp8JTxnbPZz19jW3P520bgTGkKnLBYzikm4h+4=;
 b=ElWMnImSQ7cbIG62R3aWZloB/Aob7pez9YPJfNWPcMia0fNqIVUu2YgPE1uccXmY+e5y9nsG1uVLVOrg3nTRpmyTaZ3tq4pC8A4x/EEpdRN+R4lyeb8lFl+kETfscbXVp0Fqv9Bi3Py7Gm8Kz22sfHxc1GTG0j3KnEKgigM6NKOsCPhQ6TKpoJSZLaNu8wNuUiUphBuWz7csatyuxUjfSFiDEt/KNhFoGrKg7Q4nXUN/CafyHln2qiR4Svb+L4Zb1SD8y07oKEZT9s+vBOj5TgJLT1Kk0KZwUnbMaOZJBupMhVxzcrJoSIN/m9SN5kWRtXJN/0wI3Thmi21uxdckxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 21:07:29 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 21:07:28 +0000
Message-ID: <e798b454-1f26-4502-a705-9e32dedcdcb6@intel.com>
Date: Wed, 9 Sep 2026 14:07:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9898ca1f-ecf3-4a26-e194-08df0eb65af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pARq5/PIwNeINLhhSbKa0BapfoOA76CfVEm4qyL7zhZbSaqCMXd5PYWNNzJ0A+rJLwm1BCKiBvoN/fH8RZe2Y3lUdJceBzE+/Yr1wMzdGMfNi61bGtor6mLPjVlSAxdqquDOOEG0VqKgnZfV+24B2/45IjCG6IPHXChXV75Ow51z+T2h/ef1JD+nvnj+0xCJCBQl8W2f99mO5FV6mtnDbpmeSaMmMbwfWMvGCDuQ0/OpBldAHYyzv6c1rESMuovmKvw4mj7r+lBfItqp2w86kOVNg+BLL7hgm2qTyxhWXM6/E/lj8SFOUSID+0PnkTX7/rovJHDMydgoEp3hNU17a45obiaRYnDhRtGuZJotq8NqAGh7ZSxpQS3Xib2UFPS5Q0KzZCMVE7kzZRLoefh6b2HVaw0VwbX7NYF1mjvHwwYKkbOrGmGaESiGSfjZ+YXdxk18UisFC3sUvO9B66I6azdEH3sJoBFPHEPmwqQ3ol5m6h+05cRdqIba9T/v7Qo9bFzfP7jtYZytdixoGEuNGos10JqnNk0fnBTx3uZtbFBfJ20BOuZvO3V8FqqbQecnig/hi3eDn7+2dcV1j7p/oeHDp5TsjKkMl9w51supCHUYPvwAwlq0VDQdnoZeD8GIM875/4ABbHe2gtMvuRDJF+SB15Y4KdKOnsAB7Kl8FcfnvuizPp/UYcU8buvhqaLmqRopNswuHPXwrFQNNNDdyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5oM1dkN01JRGNwU3NHMklsOWdHeTJ4bU5JbHNJNmRFa1Z4YTVhdEZwbXJC?=
 =?utf-8?B?cGlkeC9iOXg1T3ZyUE5QWUlyTFVWRk1rcWpCYzB3VkJMeUUzdWdBZkY0SHBR?=
 =?utf-8?B?VXFSTVlucDlISWVFdE42emRvajQrM0VaaUIwNVQ4bVdGVG9PT1h6clhDdDNP?=
 =?utf-8?B?K2RFRklQaEdyVkMyTTE4KzZzdE5rdkdIS2ViSVUxQW5mRjcvK3cyUTN3Y2RG?=
 =?utf-8?B?cEZDRS8wWGd5U1VsS3lQRWtWbW91MEk4cXQzRk12MkFmemdvd3hrV0tCQmpI?=
 =?utf-8?B?TGU2VmU5ZXpSMzF2M2RSd0Nnb3dTdTR3K05kY3cwYkIySlBSNDc5UnhsVnhh?=
 =?utf-8?B?L0hmOGFoQ3FYaHVQeEtlb0dXL1M3Z3g5a2V6YUFLaHJMS21nVmNmdlBpMEhw?=
 =?utf-8?B?L3dYbmw0WHA4UUJ1ODVOL2ZwRkpXUEVMUmJsRzI4NWtpdXFPQ0NHbU1DRGVn?=
 =?utf-8?B?MC9YaHdaZ2pwMmUraGN4YjZUaTE4eUg2a3g4L1NlUjl6cTV3MU9OWHFENk4v?=
 =?utf-8?B?L0E5SUV2cTdLN1JUZlpvbGRUZWtjZHZuWHVuRXhZeC9UWkw2U1ZPSHIwNzNE?=
 =?utf-8?B?M0phZ0xBS1BBMmpaNU9EUDdRUjBVQktMUGhIa0NDdHVQckt1T245ME9CVXR4?=
 =?utf-8?B?T3dJN1ozSS9XWnA1QkJtcnh0WW5ZdjJJYUpJcEcyUXh0YlcrdHIvOEhZdXlq?=
 =?utf-8?B?OElHeFFuSlczM0FmR2hKa09wTHpTTXl3YlN6aER2azRnVlFkbkc0UG9BRU1H?=
 =?utf-8?B?RkcrTFB4OUNPU09LUzk5TUhyV0ZaQnlOQWRyZFZlRjE2N2FlNXhIV0pUYnY5?=
 =?utf-8?B?MEJmek0vb2l1a2NNbmM3bFpVVm1TazRFbWthNm03cTkwd2MwMnFuckgrUSt2?=
 =?utf-8?B?b0pIWVVJTGplOVVOMkl6NVpZVm0rYlN1QXVlZER4UEE1bzk1VTJZamEwQTdw?=
 =?utf-8?B?SnlWbFRhT2VnRzF2V2JYdVB2VysrR2owUk03d3RvcTlQbXlQcTZWdmRwbEhm?=
 =?utf-8?B?M2Q4MXJJTUtSeW5CK2NsV2hCUjdkMHpuRnllVzErbks4SU5PU0lyS3NJNDJM?=
 =?utf-8?B?ekdIYmJJZGxucVAramdmSHdFSW5Nc3ZtY0xoV2FpbmFmeXU1aEw4OS9ZeFVh?=
 =?utf-8?B?WktSQ0pibGxGMlBsQldaSlkyVHhncmVkYXVpMXJqN1Q3MElUMUduOWlnRFNC?=
 =?utf-8?B?QitOTzVkL0NSQytTc3k0cHJIRTF1RnJrTjJ0ejVQQmxzTHFXNTVmbzU0SlMw?=
 =?utf-8?B?UVBaeUpRcjFLQzBuUDMvK2xGM0YxL214TjBPakNGaEwxNXNXeVRqQlRzZjNO?=
 =?utf-8?B?K3hQYWZVYXY1RFQ0Yk1ERFNNOHQ2RmR4OXh4Q0pKYkpwY0RBb3NyYmFWclN4?=
 =?utf-8?B?M3RPZmlMSkI1R0FKd0hnY1JmS3c2NlV4K09tVC9PTFFqK1k3ZzNqeHhlenZk?=
 =?utf-8?B?ZmRZdVhOamY2ZzNOUmFjQ1JVdlQ2Nm4rOXRMdi83dEtCUkgyTlREb1k4eG1V?=
 =?utf-8?B?NWxHbGkwbXhKWFhmMGx2SDVsRXJnMHUzREpIeGdxR0RoVXZMOHZNN2N3K0FP?=
 =?utf-8?B?YmM3bEhQL1JVVnNSWHI4L21aMGsxSFFncEY4SmJVTDlxWVQ2V1JmazVWNFU2?=
 =?utf-8?B?azJrSE9xT2hSWlVheVpibEllMGs5bjZhTUpvKy9QREh4emlIcnB3ak4vZldZ?=
 =?utf-8?B?Y0RaSFdSTnNJRUYwVWtjeXFlbi9EQlBhMWVXVTA3TUg5YmRsczJKTE1wa1JZ?=
 =?utf-8?B?bk5wQVZhWkw5RHc4dUtoSWVuaTBVNXhzVU9Pb2Q4ZFFIMUE4VmUwN2VhV3ZW?=
 =?utf-8?B?VFVGeTdBZkY2ZVd6MlpBbWMvNEJyQlVaQzRwZ2RlUzh6Y3Nadndkc3FQR2tt?=
 =?utf-8?B?Y0o0SWIwdnUzYmhWcVFVa2VOTXlMRzhlR2tsTFJ3UTRPa1hkTHdDY2pIdHha?=
 =?utf-8?B?YWNsaTlwTGIrLzRmTDVhNytkeVRaanF6ZVBTSC83eFBDQ0JDVU8rczdLcTFS?=
 =?utf-8?B?VHZ5VWlPRUlpa3J2aEhJR0VCdjVheVVET0k0SFkyK3NZT3RBWjlGbm1hWlZo?=
 =?utf-8?B?N3NEbnkrUCtEY1BDT0R0eDlMdkJvdTdhK1p2K29waklDQldoU1FxNFNFU2xY?=
 =?utf-8?B?dEkrWUZXZmlsSVBES1NaYzRTVEZoMlVEaERDNTI4dTNlejFzN3lmM1A4Tnpk?=
 =?utf-8?B?R01iRVNSK2NRWS9qanFzdzV3L0dOeXR6N0RBSUh2Tjc2Q2c4dUVHbHAzN3M0?=
 =?utf-8?B?b1pENUI3elllWFZBb3RkUWZkWEJ0U0c5YzZzdHV6TGlxT3lBbkc0bmtKaURv?=
 =?utf-8?B?cHpvL1dXZ0J6M0UycTZzdEErQXpVbEwvb3UrRkg5WjBIV2VtTnAwRmM2Q1Az?=
 =?utf-8?Q?L82ZeilQYJDZEHLM=3D?=
X-Exchange-RoutingPolicyChecked: SIGTKPCqx4pMrHlK1r3aLefrNCXgL/q6/D21lLWA376DkcxBu+xldIwmU6xXxBEA3OgJR1l0hjfr+fe4m1u9i3q4qkL+yVfL3TF6yNU2Ll9yDUCIg2DftwfqzxXefKdeCwMzsmQ+z+qQWDLdtbPDu9logXbmY6vMEc/sk7wRBDDxNhwnSBpI+A1iX9qvlHZ0967CQ742OMjd8LdKBu9m3b+GB/phV7QrZhhxny9gtEQ9cGjLNf5Twid7e/gD9NwkeeW1BrqozHP+mO9I2cdyoo4xkTiEEvj6+14p3GmizOZcYaVgSedzXrhHB2G+q43RcChlUIzuHEzSJ9spdqc+Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9898ca1f-ecf3-4a26-e194-08df0eb65af8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 21:07:28.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6NFrrm8h3m6ltzFqM/hRY+fcAW7vwIj2+RH3wsFhUyyNHzYBcNJglyoozjSGc9mw3sUShxb3Uw2wOuUzPjI2VG3H8QzUjj7Qq3z3QX9AQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com



On 9/7/2026 2:54 AM, Hemanth Selam wrote:
> Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Comments only, no code
> changes.
> 
> v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> each subject now names the component it touches instead of "net:".  The
> series is rebased onto that tree; the diff is unchanged.

Thanks for the changes; looks good. However...

netdev maintainers: Everything looks good to me and since there's no 
testing to be done. Did you want to take this directly?

If so,

Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/
> 
> 
> Hemanth Selam (4):
>    i40e: fix typos in comments
>    ice: fix typos in comments
>    ixgbevf: fix typo "enble" in comment
>    Documentation/eth/intel: fix repeated words in comments
> 
>   Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
>   Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
>   drivers/net/ethernet/intel/i40e/i40e_common.c                   | 2 +-
>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  | 2 +-
>   drivers/net/ethernet/intel/ice/ice.h                            | 2 +-
>   drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
>   drivers/net/ethernet/intel/ice/ice_sriov.c                      | 2 +-
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c               | 2 +-
>   8 files changed, 8 insertions(+), 8 deletions(-)

