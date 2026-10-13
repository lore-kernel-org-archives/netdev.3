Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482E558202
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931159; cv=fail; b=no6H+I9DcahklVtx9yEJNt0oZpYFHUSJOLZmWdvf6t/sviaEenhxz5aVcuYW4UlDQ8Ajy/rooyvVwTCEa//jssyQa0yVpJhAlSMplB0dqsNGHRsD3YfVJxsb0lv1wmnq5t6//F8fdiMoY0EK+f2rkcGjRaH6IzKHwQzfyOyCuzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931159; c=relaxed/simple;
	bh=WyCLLk6HVX7trDiVH0+BhTUfkIq8TxUjFqiADG+zRrs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFWqWHpSKeMYO1il70oeKB5hIksXl0nhmZmBtwvKeukY3QlxCL2fRfHdh+AOANvfEZUlYweqlaN4vEjp6DfWEHXhfa8gRdJMDXKVLj8kFbUG/EoMftKii/9MJf4+h53wFJEcnK3ch/OsVGNVk11kH1JuByay+9VMA6cZWgHq128=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=equhZ7mm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="equhZ7mm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791931157; x=1823467157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WyCLLk6HVX7trDiVH0+BhTUfkIq8TxUjFqiADG+zRrs=;
  b=equhZ7mm0EpiHlkEjfvn+TlcDpj1Ck5TQcTgKQpR44dxZT5ieScqe4Xd
   qpdzYI9RWulM858Pv1OyEWaXVUsRokbTu0j1IiHhx3awibBZtFtF76RsC
   4AfHwiwTK4dneIEDZFs5NQNzB6Ax0E+uY5zfyJK9jYwybrbAjyThIUg95
   QjgOVezoL5rluIUrjY8psLVpJvEpOvGO/fP73jZT/3yaDMOyvG9PRaVTo
   AfqV7FOR/hdQvMKFUu4IzOaZthf6+0reIZcTA5yAeuX1ykwPaRqrT4NrE
   P3t9VD8WDK2LbT28ccL65WAIzE2e4J/0xP6qWGQcolHvfngvtuMfwnJl8
   w==;
X-CSE-ConnectionGUID: sOqjQ72nReaXJgfitY8QxA==
X-CSE-MsgGUID: bsOVAiHcQh+fTeb9NyZxNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="678785"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="678785"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:39:15 -0700
X-CSE-ConnectionGUID: maqpR32zSgCNSRbSxGDMow==
X-CSE-MsgGUID: 0/hAkvdvT8yZTlhv9PJXFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1200560"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:39:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:39:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 15:39:14 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:39:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khNk+b8wd5wFC6hIxE5UI/MrhIKaTTSJEWCB9sqd8bWRWk9jc7o7/62P3z8wUa7yJ5idDs8rCfogEYFsJuL0A0/amHSaSU78TjuwenlGBqgHjYBaw4piY5oeUk1GmlfdZwMpDOFEInCjmqq2f+4tW9mTZdZsOCuaiWUwfa3F1v26JJZVC3etQUv4RJrkrLKgcfa6s65TtBeWKaON/NS/UOBZyX6/WTUiHfQCLDjTeLIQcQlNUcde1Lmmk7cEFTZiejkhJGE4BJQeT9kI1EPwHUFzmTM3riLG3oc0YIMnM6KjguKkppnfxNDJfiW9SvL77cLigKroQ7j3S6ZF4WoiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2KGz2Osc0JzXYsLfTS5OU0acqGpG/M6+0Yhv6gCrM8=;
 b=msVIZK1nbYG4TFgauJsxhyWRT3pRTzKt2UcqR2MHKJNavUlNM4HqsOklLwoCoHuadySxADJOy32wtyCgE7ADoU+/VAPrk714h3F4KqCm1kcBBSh3Kk5sVqODM22d+XZ++1WuAp4/43J8jKp8wdi6mRMRok3fIA/ofnDHeoctgdOjV1k2twwxqAgshI6WhUKoMdQszooYgzSU4pgYIbVz3d46AmYqYyFjZ1wmtu608JOPbN7oJn3GqsTFf+r4/58XUAbe0Jk72sQKNvXEifQvL6W0ibCxdOfkToYFnLyuHVbIcr+ZNcn5I/kvg2w2VIkdkg+TmA3kEBIi63WHa93QCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by CH3PR11MB601806.namprd11.prod.outlook.com (2603:10b6:610:365::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 22:39:05 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 22:39:05 +0000
Message-ID: <bbca7a97-bf8d-4039-aee8-4bb95f102340@intel.com>
Date: Tue, 13 Oct 2026 15:39:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 11/15] ice: wait for in-flight Tx timestamps before
 flushing the tracker
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-12-anthony.l.nguyen@intel.com>
 <179184693018.434549.11776352686949111433@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184693018.434549.11776352686949111433@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|CH3PR11MB601806:EE_
X-MS-Office365-Filtering-Correlation-Id: eef45a13-55bd-4982-cdca-08df297ac978
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|5023799004|11063799006|4143699003|261009223027099003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: tMXReikDtLxYb/zrKWmkS6scJmZIXz2Vb1pyLLaGaQXqG/8RGoBz1W3bcTOZWVlxnjjwCtqHDkI7urNchxlZ4hJRrPQxIdUpqNX9McpK14XZ9WwL1s7pz8HkSfwqELPQLrdYHym/5f7FnQTo6KeZggbyqJVU8RlHNcOW+7KB2V8ovMIJ2EPNjWM2rJRyK7cAL0xv8NcjeJsH9ANV99iFb4o9qA9/aUx8OZEZbpKKNt9/DLDpi4qUajO8MJMPDjZRE4AYcGMC/XCgPXyLQ7OJuXVcZZ5w7ogCBB9B/48Wa3ftbbLifBL+g2It3FRGmEyZKX73xaTtuCo2Cp7slJ/CpUirSBR/i38/SMg8XIjrKvW2V0gJnT6+By9WgLVBowyVvkSNi24cNSGAkPqxmu+eEmzm5giZElOjlDJRt7rIq6NcYNVl1HwMMdfxnyAd8WO1LoXWvcftQG/BPVmsg6RapMlhHkJf7NgvH4DRdDczHcy8Pen+OpVVzOX1S23mI+ZeqPA2uj3KrsHYSGNT1DMWR+1RiDLQ9epGzFwvTS6c5jZkqXd5CBYYVuhFfNHk2McZ+Cz6A5PgQD/hDETbX+MYyRuYt8FysWGEkoWEX854IeKshS3ZiKLwfVCEIVHnZOSMqGX7djSAjznbo7CoffO4dubE2zrK48Jj9uDe0vg1U+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkw1RU5SZklDZDArZ1k4SllsOFh1MDZ3bExLcE5iZXJqSS92eUpjR2NaYlMz?=
 =?utf-8?B?bTZyMFpraWowaFZCbFJaa01mekhsNTNOWVR4cVZEOUZqbm1taldkZXJaQ1dm?=
 =?utf-8?B?amJHZjE2enNMTmsremI4V2RhSWlqYVpXaHV2T3A5RUJsakZLOCs4NGtOZDdu?=
 =?utf-8?B?OTVqOTFSWnBsbUkrU2Z2aSs0WkxqZ09Gd0czcEhSaHZZMHUvVFVrOTJzMXhs?=
 =?utf-8?B?OUh4a1hyWit2d2h4aFR1T01rV3hmdWdvNjJTOHkvVWtCVVpGK3oySTh0azYv?=
 =?utf-8?B?enBIcWhrb2JLQlV5UGhMeVJMTHdTdVplalczaC9HMHFWcmpmOHBjTDA2ZFFz?=
 =?utf-8?B?V0VZWW5ia2s0djNUbTVIMkdxMmJZc0tYNXpjZGFjbm5oWXNjWW5BTEtuNlNT?=
 =?utf-8?B?NVN4TGV1YWI4US8zSHkzQWpYTWpRYmtUdmhKbERpYkUrOFMzYTM0eXhQdS9q?=
 =?utf-8?B?aCtGSm9LQkwzQnRTaDZSc2VNL3J0TVRSTWxSVnJiS0xObmc2RUVablRzYlUz?=
 =?utf-8?B?eDlPWG8xSlppU3dwa081bmJEYkZWUU9rTnpBbnhDUWVzcWtPRVM3M0VWUGha?=
 =?utf-8?B?L3BwcU1vY2hDM0ZFaC9qeGZESW5JWWZoeHhaU00ycTNwRjk3Z2VCSXJkQUZZ?=
 =?utf-8?B?QWZUTU5wdlFDcWhoc3RhWk5oSUYrRzBKY0JjR3F4UDJBalo0VklZTndQSlMw?=
 =?utf-8?B?V010MFdWYVNBai9ONDZocVpqMnRsb0o5VEw2MFQwUGlPMXpMcTkyU0NaWndU?=
 =?utf-8?B?VEFQejQ2QnZlR0MyUGQ2ZjVVWlN0c0o1UGdNbVZXWUcrVWIzdVRTY2R0TjhZ?=
 =?utf-8?B?TVU3a0RqczFPeWlZa3dWbEN4dTdyUVFsdWJwU2dpYWZNRVByT0JrYm4wbnNH?=
 =?utf-8?B?ejE2Rmx2U042RGE0TEwzYlFLeEhSY29KSzJveE9jeDVIVE80aEtqeE5aRWNS?=
 =?utf-8?B?SkNiUmVNL2l4Y1FwdFovSURTeDVmSVFJRmhXRG52U3hZQS9iOGMzaXZma24y?=
 =?utf-8?B?N0QxZVBtSWZMM2t0WllhMFlvL1NtYjIyVzg3djlxZkJOY0w1bG1VaE9tcmFJ?=
 =?utf-8?B?bDFhNzM4SjQvcmRGaE9HQ2VicC9wdW9YbEU3WnlMVGI0eGJDNy9EVlA1TTMv?=
 =?utf-8?B?YnFxRzdXZnBlQlpkSktaeTJHVm5XYStQTVNQMzVmbnVuelJmaWdudTdBY01L?=
 =?utf-8?B?UTRqS1BKOFZPbGFmTndvMExBMVczYVJ1VklKZThBeUZuL295b1hnUjZJRXVo?=
 =?utf-8?B?M21xOG4zNFRhWGRJOWw5d3VYNmhmZ0o1aUxxZ1hQVVN3VkppU1lWc0Uvbkh4?=
 =?utf-8?B?VXVWZGkyOWs2ZWw1bWZBTXFNdzBRdWJSZmN1bS9oSUVIek5PbkUyVlRDYzZv?=
 =?utf-8?B?NFlzcEFRNjVVd28xZG5mMU0wODB4cG1nVlZ4VTcyZGJFVHJMdXI1eUdQYloz?=
 =?utf-8?B?MEU5YjJHd1RJZXdEUkpFME5ibDMyRE8wSG5pR0JyamJ3WXhJWTI0eFp2eS9E?=
 =?utf-8?B?ejMzRW5EVUtuQkI4bHdwOHlJNlVSN0c0SmZTK0ljZHk0SEgvdXVjRXUybEVQ?=
 =?utf-8?B?RWQ2MlFURGIxVDh3YTZTdlVvMnVwdjBVNFFUd3QxMEpvYVdlZVNBL2k4QlZn?=
 =?utf-8?B?N3BiQ0wyb2JObE9hK0wrU1FHWlh3ZmZYM1A3TG1XVFBuWmNLNEI1T3Y2Rzlx?=
 =?utf-8?B?aVRJTjZCYnVvMkhidWxPYVcrdWdBWDlRY3pRNW1VMzV1WUxoQXlSL2F3TkEw?=
 =?utf-8?B?d2VyZUxxcGVNUS8rS2dUVm5GUzB4dVRRYWxsT1BCR2hlWHRvNWNabEhLRjUr?=
 =?utf-8?B?NHBMVGJNRG5UcnJQWDNhdjIwamlJbUhXM1ppQlFwVy9QcnJYUHh6d2E2allK?=
 =?utf-8?B?bU4vUytxVnlwRXZ6ZmwzQnBDUzR1V0JMSTVKa25TS1B1ZmlkZGhDUGVmblJT?=
 =?utf-8?B?dHpSMVJhQlFIUTVBWlRFbC9mVVh5aHpVK25FRDMzT0NMa3RtR0FmdTJ2RFF1?=
 =?utf-8?B?WTd3cEVlZXZ4QzVtTVJPLzQ1ZnpjVkI4NFlTSXpsYXlMeFZwVTJSZjNhY09M?=
 =?utf-8?B?NCsvdTNVM3Fyb3oxNDN4dmpzaXFQcElHcFh5M0IwM0k1aW9PR2RycVZPeFZB?=
 =?utf-8?B?ZTFpU0NjRmRKcm5FUUt3anBNQmZ3OG5UZiszREZRSUpPbjBYcmxSOGVKeUdV?=
 =?utf-8?B?ckdpZmMvbU5Ud3dCRXNRa3d2TXhKbThxemlHWmVMMHVtYlZ6anJLZU43cXJX?=
 =?utf-8?B?VytjN0pSVTN5RXVoWkt1SktPSmlhbUtiWlI1Nkp1R0hMZkRra3AzTlVGTkFH?=
 =?utf-8?B?VG15aHM2TWgyM3ExZ3dLZlZMck1IOWNGcEFQa3N5Y0dNUHBkNUQ5SEVrNURw?=
 =?utf-8?Q?x2BN/PXc7kg7hDAc=3D?=
X-Exchange-RoutingPolicyChecked: V/L8HuDuLvJm/P0BUDr2G/gsFpJUUhCLZgKcdFtFgp4S9YoMhqe8tV7qU8xmU90/Gxj5M0Ua370X0UVuzMxfHOs/qHTSBAkBPiXC4JUSxK6Y6AD3LNgtO53jTVFpRYvFMfToYhYk+Rk3prd/A+om6ORi3KD+7xrlSqiygck32Z2+yoD0F475rjzmOVqYyIHRrzKYKOjahat7jA/P+G0yLF6JudeIa33a/GcY5HhWaHEFX65kqWVr9MhQj3Lcr+s8dajtvGQLQ7576tffNHq6rdbaMOkR76g6t5lq2eukBSNELac7ekTP7Q9QACPH2cnFX0Yfi2YnGfSwtxReyQ0XfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eef45a13-55bd-4982-cdca-08df297ac978
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:39:05.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIvtGYWHKRsaracTFrQDIpPvl2NwRr0SCE05wMdhGPCsGpr9hG9klyypTpuW5lkQMVB/BYqZFCNTznBXCughnAraCL+3qgzvjQBKtGOOfAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB601806
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] On E830 the flush still leaves hardware-ready entries
>   unacknowledged, so the drain does nothing for a device the commit…
> - [Low] ice_ptp_rebuild_owner() calls ice_ptp_flush_all_tx_tracker(),
>   which now runs ice_ptp_wait_for_tracker_drain() on every port of the…
> 
> Pre-existing issues:
> - [Low] At this commit, ice_ptp_process_tx_tstamp() sets drop_ts =
>   !link_up (line 592).
> 
> --
> 
> ice: wait for in-flight Tx timestamps before flushing the tracker
> 
> This patch adds a poll to ice_ptp_flush_tx_tracker(). For up to 10 ms per
> port, it waits for the PHY to publish ready bits for all in-use Tx
> timestamp slots, and only then flushes the tracker. E810 has no ready
> bitmap, so it skips the wait.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 818e2e265a7e5..5220de274819a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -744,6 +744,68 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
> 
> [ ... ]
> 
>> +static void
>> +ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
>> +{
>> +	bool drained;
>> +	int err;
>> +
>> +	if (!tx->has_ready_bitmap)
>> +		return;
> 
> [Severity: Medium]
> Does the drain actually help on E830? E830 has has_ready_bitmap set, so it
> enters this wait. The commit message also lists it among the devices that
> benefit:
> 
>   "Only later devices (E822, E825, E830) have the bitmap ... Thus, skip
>   the wait for E810"
> 
> However, ice_clear_phy_tstamp() in ice_ptp_hw.c has no E830 case:
> 
> ice_clear_phy_tstamp() {
> 	switch (hw->mac_type) {
> 	case ICE_MAC_E810:
> 		return ice_clear_phy_tstamp_e810(hw, block, idx);
> 	case ICE_MAC_GENERIC:
> 		return ice_clear_phy_tstamp_e82x(hw, block, idx);
> 	case ICE_MAC_GENERIC_3K_E825:
> 		return ice_clear_ptp_tstamp_eth56g(hw, block, idx);
> 	default:
> 		return -EOPNOTSUPP;
> 	}
> }
> 
> ice_ptp_flush_tx_tracker() ignores that return value, then clears in_use
> and frees the skb anyway:
> 
> 	if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
> 		ice_clear_phy_tstamp(hw, tx->block, phy_idx);
> 
> ice_ptp_reset_ts_memory(), ice_ptp_port_phy_stop() and
> ice_ptp_port_phy_restart() also do nothing for E830.
> 
> So on E830, wouldn't an entry that becomes ready during the wait stay set
> in E830_PRTMAC_TS_TX_MEM_VALID with no owner? That is the orphaned ready
> bit state this patch is trying to prevent.

Will need to check what if anything the E830 hardware can do. Maybe it
should just do the same as the other paths by reading the timestamp.

> 
> On the rebuild path the tracker stays initialized. For E830,
> ice_ptp_ts_irq() re-arms PFINT_OICR whenever ice_ptp_tx_tstamps_pending()
> sees a hardware ready bit.
> 
> Could such an orphan keep re-triggering the interrupt, or be picked up as
> a stale timestamp by a later request that reuses the index?
> 
> The actual effect depends on two hardware details: whether E830 valid bits
> clear only when the timestamp is read, and whether CORER resets the PRTMAC
> timestamp memory. The E830 case is still missing from
> ice_clear_phy_tstamp() at the end of the series.
> 
>> +
>> +	err = read_poll_timeout(ice_ptp_is_tracker_drained,
>> +				drained, drained, 500, 10 * USEC_PER_MSEC, false,
>> +				pf, tx);
> 
> [Severity: Low]
> Will this poll always run until its full 10 ms timeout on the post-reset
> rebuild path?
> 
> This call chain reaches the poll for every port on the adapter, one port
> after another:
> 
> ice_rebuild()->ice_ptp_rebuild()->ice_ptp_rebuild_owner()->
> ice_ptp_flush_all_tx_tracker()->ice_ptp_flush_tx_tracker()
> 
> ice_reset_subtask() clears reset_ongoing before the rebuild:
> 
> 		} else {
> 			/* done with reset. start rebuild */
> 			pf->hw.reset_ongoing = false;
> 			ice_rebuild(pf, reset_type);
> 
> So the reset_ongoing early return in ice_ptp_is_tracker_drained() does not
> skip the poll.
> 
> A CORER/GLOBR/EMPR reset drops the Tx rings. A request whose packet was
> dropped that way will never get a ready bit, so
> ice_ptp_is_tracker_drained() keeps returning false. That costs about 20
> rounds of SBQ ready-bitmap reads per port. On an 8-port adapter it adds
> roughly 80 ms to reset recovery.
> 
> A Tx hang is a common reason for the reset, and it is also the case most
> likely to leave such entries behind.
> 
> The wait also seems unnecessary there. Right after the flush,
> ice_ptp_rebuild_owner() does:
> 
> 	ice_ptp_flush_all_tx_tracker(pf);
> 
> 	/* Enable quad interrupts */
> 	err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
> 
> ice_ptp_cfg_phy_interrupt() calls ice_ptp_reset_ts_memory(), which resets
> the E82x timestamp memory. On E825 ports with link up,
> ice_ptp_restart_all_phy() then does a PHY soft reset.
> 
> Would it make sense to wait only on the release path? That is where new
> requests are blocked and captures can still be in flight.
> 

If we call ice_ptp_flush_all_tx_tracker() in other places we may or may
not want to wait. For the cases which soft reset I am not sure the wait
is necessary, since the soft reset will fix any orphaned cases. I think
moving this to only happen in the case where we're not about to soft
reset the PHY (i.e. teardown). Or we could just drop the patch entirely
since I think the soft reset path may fix any issues this is intending
to prevent.

I'll do one of those two things in v3.

>> +	if (err) {
>> +		dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
>> +			tx->block);
>> +	}
>> +}
>> +
> 
> [ ... ]
> 
>> @@ -760,6 +822,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>>  	int err;
>>  	u8 idx;
>>  
>> +	ice_ptp_wait_for_tracker_drain(pf, tx);
>> +
> 
> [Severity: Low]
> This is a pre-existing issue and was not introduced by this patch. The new
> drain only covers ice_ptp_flush_tx_tracker(). At this commit,
> ice_ptp_process_tx_tstamp() can still create the same orphan when the link
> goes down:
> 
> 	bool drop_ts = !link_up;
> 	...
> 			if (drop_ts)
> 				goto skip_ts_read;
> 
> When a slot is not ready yet, this path clears in_use and frees the skb
> without touching the PHY entry. If the capture finishes later, its ready
> bit has no owner. That is the case the commit message describes.
> 
> The next patch in the series, "ice: keep Tx timestamp slots tracked until
> completion or timeout", removes the link-down drop. After that patch, only
> the 2 second timeout frees a slot that is not ready. That timeout is
> intentional and is documented both in the ice_ptp_process_tx_tstamp()
> kernel-doc and in that patch's commit message. So by the end of the series
> this no longer applies.
> 

