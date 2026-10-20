Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792461202;
	b=z+TTfPHHE7UxfBcNbT2XrTUTCHzFjeEPQwufOE/JQv8mO619G1xoivyFb1PpeC0BB+PA
	 b1UiNF/zDHWJb9Sru4b8GucD0L0eg402D5W/j5qXTRSaUPPzbxX8/+lEDlgNT2JSDLego
	 p0//86V0bvfzGpd9Wo62rBqthDwNDdxvHK+Qnn3Baa16Iqdvp6y4NzLr9Mn9blpM/Ojka
	 zdx4Dq5tp4W8vqU/u5CnYdnTIC5wLTOeJ8VKu8uOgVJgBvSigpQxHcNrACOiwwG+zf9Fy
	 Ts0M2ZzIEDWP130hjh95S+dmW3plw9YFGb9SmTWsIr2xmAgaeE6diMAOC0+Ae7w1F/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461202;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:From:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=s1+4staOzkt+IIpM4lz/jgbMP+f6cK4rT5FctmXnkJk=;
	b=RQFTo4kFML6LgzMd+Jl91XaCSVoKWMV2sLfzVPlItKYTS3XFdNACX4lDmHn4UMAYg5rr
	 ioDlUDGQK7dqRMO3pE11ktvNs5Ao0fpHAXwL1xW7CB3mXszzAqg1gKkYgNLgchCFJE36C
	 oIAVgddMHzl7FJ6F9nBE9DNicIo8wSPx6+eqfOqF0Tn/yIeZSoTM1ShNtUi1A1fl038Qq
	 OA+qjkX5kkK8kJpC2mIgaiAJVWimhPh6fUaV5jyPI4O+TRvVb+lfmjPRh0g0V4hRN+k7l
	 tbuPwuKRxCf9DtpK5Ucub9doPL3ZxePWJZ/GnDSSsiRhJJhwtLum/uLbFEj4juqUInA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8pEprxP;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348A606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8348A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8pEprxP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792461201; x=1823997201;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pM2hzUTwITYWIuCL8KlxWA0Gxc1pSATrL6cFvDV4hls=;
  b=C8pEprxPrYdpV03QevcHN7WTlnCmJ44T9G4Q9fMu5ECfBgQu6KMjpVDs
   e8mf1C1mlLR6XIGOVTY520qCDre4zrH4ZiCHSZv+7+JZj9gO3QoA6Gxro
   idNAZuWgL7IfjsYvSZzf5tw8lKtshCD9CpjHETBxp5NWBwNUBKevEFvUl
   uvtl3td3bT/yPD0FxcYjSuuuI4nJI+Xf2keNIo/xgoLx8KBfclVuq6W+o
   vhnztcY5QWZAs1XXQeu2AhZ+VMhAN+zvQtnP5UfXkrBDDfL/jAWMx+AGz
   bchMET/iNRjC3LsApG4VBX+Pw8OiapHjlzaQTDwQlqFa1yHj4v+8dCKI3
   Q==;
X-CSE-ConnectionGUID: Aa5U4KgmSeG8VQU/KsN6Mw==
X-CSE-MsgGUID: oKWeKnWOQR+1lBTHPSdsRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1048661"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1048661"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 18:53:18 -0700
X-CSE-ConnectionGUID: qc+LhorhQWq5rf7mAi0BuQ==
X-CSE-MsgGUID: BqRNqnEAToO0JSs+cBllcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2651284"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 18:53:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 18:53:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 18:53:17 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 18:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKGArOvigJb1pwR8T/a4ckcgFzDK4g9GF7IFLRcru/6xvqHnTeJOI20e4UQeDrVxEDjAbcRdvl2bY/dIF/L4jmJq5rbYGGoMk9+0xhUM36CUqysJjXzcMTvbgR4zbiu/cqUyLATZM0IupxpCsRe6JuEAAMDYQYM8msFynXEZdkaBDksBGa8ZYCUvj/K/SRuHNvqDnu0Ld9OL5sZTa0uHWwSknJBwMDR7e633vQhlLDpDL4HxUzeMZSt0AulZZyhAR+B8T5Sy04OgxqTstpPIQLKqEHX08ZtQ++fcjxqRVklVd1mta7N9QMnAxX4o4tpqCCX4b1sxz6bFLnsrA59SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+4staOzkt+IIpM4lz/jgbMP+f6cK4rT5FctmXnkJk=;
 b=M58rTJbjk+lUGrzmBe/JEnq0N3OXPQ9Okw9cfn/YsPaPPUaO99kGIRtaJgnNiZGykM4YMYkOcp7p8KnOpcXJdYtEqqvZTqjOq1GXTQQAXJd6shazbXwywkJBUsZKhIX5HAjU6wg7KLturucIvDAMyJPbOOXFpbLZxDN9KwMdWZ/6vB6nxHwBnsEjkqS7ptrRlJAHUTbZ1A2B7bxRTZdqV3SfyvArsW3B58wZWMhCxTKihzVn4xbibzYGjfV2dnMDfjz/TqE5tVTwWuJmXXwqiEwzm/KTyhK1lDIGpF7uM34XzXs1fnxrdY5f4vQ1Q0Yh+IfENRpFqsyqDx0BMDWhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by SA2PR11MB4812.namprd11.prod.outlook.com (2603:10b6:806:f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 01:53:09 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 01:53:08 +0000
Message-ID: <fdb5369d-30b8-46c5-9b44-576ae5f26a31@intel.com>
Date: Mon, 19 Oct 2026 18:53:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 08/14] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
From: Jacob Keller <jacob.e.keller@intel.com>
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-9-anthony.l.nguyen@intel.com>
 <179244085024.3135.15051854897545383662@kernel.org>
 <caea17a6-9a07-4aea-933e-afa9754fbee4@intel.com>
Content-Language: en-US
In-Reply-To: <caea17a6-9a07-4aea-933e-afa9754fbee4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|SA2PR11MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d3fee0-2d42-4366-9f16-08df2e4ce3c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l7CK8LBEydmU9kZJCoMadSwfEmBbXWjgA/OWuXEvlX2tuok/m20wdDudsVAhWg7NPaNKolv0sC2q+DUehotKje5tx0ylZ2X0ceHVbP/rUbwD8d7XK1/6eRLCB1d1gEXlM8QCHd+t6aRqhgGqaGIk1TfkxOduZAufTKLik1bYKX4lsaRT5QLjsLxe4BiEs01YmlglGMC02IkGzDA0WXy0GvQMGMI3xurg0h2v6orS9k1dXZp05iUJuA6OrhVzhSMZKPC88jdjB5Tod97UKI3F8p9GxYByIc8NA616C225TUxMS/oV2jqy9c9DEzjxJlnAywTgmaZcwvWtWckPsxJOoILRcoVpBLm2odUIXl8imrevGzZkHhERIfaFhdeDyCsG1hIbA7A8tNad1Dwwxjtt9oy2b3eOTwNHmp+Kvjk6QwexYzd1tiVlW9E/24tjzd/6/unKJoeNFOG9GYd3Io8NuUpohVYDXiDWeu2VzEFaOiOM2ahMxhNeViCbMmqyEQSb+Cr+BdfARuxcLqVadfhVhn+tCA6oUtBo3hSrnIMZw9otPHSHOjP1s1v13YQsCtxeaOhWQzVAgbPiWTfC9g3Qd15fB/UMiAGUfzVBzJSvxW3GzlpDAjK0bjd/aW0M8R6QyiIINtzTAfzAlT9gsAVIfs5N+PqM84hkfuqbTWs4xK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UENMRWVXa0ZuaGU0b2U4VFBIR2w2Q1BwUUZ4RXgweWU1U3RENzAwMzYveGpM?=
 =?utf-8?B?ZnVnMm5iWDlzdFNIZjIyV2RWR0NobXRSRGxMcFFYMmhWNWE4dDJXV1hramxE?=
 =?utf-8?B?SUtUT2lCb04vcWgyc3RnUWJyRVlFMFFZU2RJVUZuZVRuM09wVVV4UkQveFVa?=
 =?utf-8?B?aFBVdG5UYjk4UElEcWdTZ0FRazVrTVhuNzU4SytGNzFmTU9ualM5c3dvUjhY?=
 =?utf-8?B?dW9HU3ZsUXQxMHh1Slp3YW9jYnNqYXdPNzhPQUFuZFhUNlg5bG5xbjdJNWtj?=
 =?utf-8?B?SHRLTWZXZjhNNng5c3VOUk5vVGtvdVR6b3FoVUJQZGZZSFJ4VG90WlZacnhm?=
 =?utf-8?B?TC9Uak9EQkNUTjM5eXNqSVoyOGRUUjY1UW5ScjZtUmRTSGJWT1FrUTBjQlJj?=
 =?utf-8?B?eE1oK3ovV05pdFN6eVMwL3lZdG9udGYwZXZweXQyY3NTY1lPYVdxeE0wVVM5?=
 =?utf-8?B?TVowdlg4UStOcWZrYzNUOTJmT1l2dzVaMmdOVng4WndRTkRmWi9LdVRKY2Ri?=
 =?utf-8?B?RElPZ01wU3BocVRaeEIwTE9mYnh4ZWMwVUQ0SUlUdE40ZjdaSkhjM09NRFRJ?=
 =?utf-8?B?YWNDUGhuSnk4MWVHY3lIcktXdWJ2K1VzOUhPZ2c0ZmhhVUZMRGxYV2F2OVQ0?=
 =?utf-8?B?bFZ1TGdVY01oVFk5SndtbG1UWGIyY3VqR2Fjb1ViVGdBL21tcWR2VDZMUmhm?=
 =?utf-8?B?bGxBQ2txeEFNQnZleHpXbGQ0VXMyVGc0TXNMek5yT2kwOW1QSHlHZHQ4dHBo?=
 =?utf-8?B?ZUJjdGVkNHpZVHlHSzEwRy9sYk1pVlB3VWpMYTNjb3F4S0MrbGx4dnA4Mjhn?=
 =?utf-8?B?OE1ZdWkza0xHSFB4SVFZYXplUUVtTGxld0ZzQzZlYjlOMy9xejFsTHdWcTd0?=
 =?utf-8?B?MVd0WDJVdkc0WUNPSEhod2VZY0ZtZWtqRTY3OC9lL0ZDR1FJMDk3U3F4YzJC?=
 =?utf-8?B?VFd4OFFMMHd3WFpLUWNwVTFJSERFUHNDcFNXcS9yVzZ2aHZ1YjE4OXlXS3FL?=
 =?utf-8?B?aXN1SENNbEloTnlWLzE3ZkhBZGxZdVpNOVEyQnVMSXJoZjk2WFBzZHpjek83?=
 =?utf-8?B?Lzl5bm9aeFM3YkxvQm13S0pCQVpaemt5TUR0NEtOS1JiaWlJSS9PL2xjWUYz?=
 =?utf-8?B?L0N2UVdNL2NRZlZhdit2WHJTdU80L2N3bDkxRDkzSWtVNStLdTV5eXVLMjR1?=
 =?utf-8?B?a2hRYkY0a1JZTkJzcE5JQ3ljVHJTY3UrWWdrUnRDbFJ6dEpTZExYeWlOeWEv?=
 =?utf-8?B?ZVE0d2RIWVNQZkNITlhhcUt0YkxjWXRqWWtuNVFVNjJXVXJOS0RmZkVjSjFU?=
 =?utf-8?B?RDVHNmxYWFp0TmFCQjU5bEpZcGdibzdwSVlFMTJVcGJwajZRKzN3eitsb0hY?=
 =?utf-8?B?RDBRTHJqT214SGNNdUMwL01wUm5ZVktVWk1wbXJKMmRFd05BWjlMMVYrbytl?=
 =?utf-8?B?QVgvdVFiOEUrdk9wR3NidzVCdjlKajFKRkY4MmlCYXA2dTZoRTdSY0kxQ3hO?=
 =?utf-8?B?NXdvQzI4OFpEN3F5bGM0dSthRk5DWWdqNDJkekJNVFlDcXlrREs5am9odEQr?=
 =?utf-8?B?UWhXYlhBZGgwdjR4aEh5Z2d0cjYyOExFSnNEWXc3SFBmT2pmMHZaRVpYWHFE?=
 =?utf-8?B?RGhaOFRKdUFESG85V21haTlHcSthQjV6bGRURVNLRW4yUHl4Vkc2dVhXbFlx?=
 =?utf-8?B?V096SVpvU1BwcTIxaDR2d1lrQ0trQUwxWFZZMW4yY3RiQjZjeXQrQmR1Mkls?=
 =?utf-8?B?NEV2MDg4blBYSUVhbjFOLzBnSC93MlhzTkdGa0cvZFpMMW5HZm5Gd0Z2R3Ba?=
 =?utf-8?B?Vm9oZmxNdDFBUWJzTXJVcFd0UC9nRnJGWjZsVEsvQUVJNjVzM3IrcW1JMkpP?=
 =?utf-8?B?Rjg1ZkxmZmhqSno2VEJCQ1Q0MDh0dDhMY3h5Sy9HakZoamhaS29RMUVEQXlY?=
 =?utf-8?B?UlAvY0t1SlJCR1hvNDM4RnJrcnFwUy84TlhGUWpDQUFuTDhwaUVzdEhNbjdV?=
 =?utf-8?B?QUhZOG93NVJYYmx4LzQ1a3QxdnpJRTVNS0QwYVlkeFIwRlVxdS8vc0dIck9S?=
 =?utf-8?B?d1JJTUtVVE9EdW04UzY2R1A4MUtKS2J4L0NXc0JEcFl0a2RXcER2dzdJWXFC?=
 =?utf-8?B?M2hRRnBLQmJiYktKWUxMYlVTVWVrdlFpYUxvVC9JL0V0c1RGTDdlZXJIUW9t?=
 =?utf-8?B?OW9CekVPMmZTeEM0ODdMZWYvSXdVSXkvN09NSUFaZzQ1VHpiK1FtSlZCbmY1?=
 =?utf-8?B?U2dkZjFxeW15ZEdjZUxFNElibjZrRUxxaUQ1NVN4TDJZNzFLaEl1a1ZORkNJ?=
 =?utf-8?B?MFR3R05VbStwRGFDb3l1eHNkR2ZjS2FxQzUxa1YxaGhRbGZUSzBhdz09?=
X-Exchange-RoutingPolicyChecked: fH2GGUJIwmhNci1tJ/sjA9Fe1bZ+LbYDHzTKKshoA0Ns5YHZ4FvotznMsvoWHvn9FjvIAQLQWj+YmuyOTEy3Sy+11/V0fkq8doYKAbpCWUOGdz1Aqc00w0TsGIWZbWMfdWgIlAYGV1rBabE89JjJQdt8yV9+rGaxzAqUYj85miCWB48jRFHSp2yGIHTsWL0+0F7L87rGwxqiuQ+93EnlFFFe5NWCDVggbQgz4NMenxIThWiCp5v8HQ8+Z2sOZSCoaavaQZ/AtmJRJlxKHciJuBBv23EE6sdJZK59rszAQexuS69mhYoDS9WscT+qRcssZoufkpCOlRFH9qUM76UPkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d3fee0-2d42-4366-9f16-08df2e4ce3c6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 01:53:08.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOKdPW6JXgLNkqYKUuY0GeSUJXoa9HwuOM3f1CAOyFIUsFT44z7/KadoiPE/sZIjWpuTkWpS9vSEwO0QD2AOhDlU9La0b9+NqvxS17f9e8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4812
X-OriginatorOrg: intel.com

On 10/19/2026 4:42 PM, Jacob Keller wrote:
> On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
>> Suppose the first register write in ice_start_phy_timer_eth56g() fails:
>>
>> ice_start_phy_timer_eth56g()
>>     err = ice_stop_phy_timer_eth56g(hw, port);
>>     if (err)
>>         return err;
>>
>> PHY_REG_RX_OFFSET_READY then keeps its previous value, for example 1 from
>> an earlier successful start. The hardware may keep marking Rx descriptor
>> timestamps valid, even though ice_sync_phy_timer_eth56g() never ran.
>>
>> If any later step fails, RX_OFFSET_READY has already been cleared and the
>> message is accurate. The early return is not new; only the message's
>> absolute claim is.
>>
>> Could the message be more precise here, for example by saying that Tx
>> timestamping remains disabled?
>>
> 
> I can fix this.
> 

On a second re-read, I think this is overly pedantic. Strictly speaking
Rx offset might be valid but in practice the entire reset sequence
didn't occur and it is likely that timestamps are still broken. I think
leaving this as is is good enough for end users and system
administrators who need to be made aware that a link restart is
potentially required to fix the unexpected failure.
