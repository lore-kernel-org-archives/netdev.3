Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EE339B41
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582521; cv=fail; b=Bvze380JEoEZUBRRm5B252ss6/M76yTlZN+XV6oSRMLHgemqr9M4L1//g2GLq3red2iXqwCyuC7FgReBCdHsjFdhWFazMMHBKklHoI6TFJbJoWTAWsGq3Tclr6S0QA8KI34YMyI3tzAI4zvePYRmm0wB/m/N0nUz7sTR/gdjfIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582521; c=relaxed/simple;
	bh=tVWdtKtbVtcL8MACTaJLC3i2Yy+wHysqnLig0h2mUe0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fpDUQ/VX9QHIwEJHFITlbUnWr3UAqqu8KHujvFLdfqKR0zwwcaWAIfDSJUFyaQx+3BjrrFC74ps841B88//ciz+fChpT84imYiWLwd+zE7pKZdLlzUGXwytdn7/UeUPTqIBTked6kJjiIRXOP85MCOQpl3pm+qdlya2mcAcEZHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLgKkH/z; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLgKkH/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791582520; x=1823118520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tVWdtKtbVtcL8MACTaJLC3i2Yy+wHysqnLig0h2mUe0=;
  b=nLgKkH/zXrIXN3XHTLPfXm//sYzHXNLkc86djH5d/Iexz5rDAwINEMr3
   xYn+cNrM6V6CTffv8/AwOH19weiAiNzgML+3u9vqRpon/IbtXl+70x4FE
   pUuXVrJuWwH2GPwbE9pi5hTGYq6iLsjB1lFoI/93F4ZU43ftOUBQrowJz
   EJXcJ/6OLDnl+6g1ahHmuA66q/2vjFavrl+BxmCzCI8nGJI/xhzv+xpt3
   h1cV7K2hFAnpanEPWPOSNBLwJFbZSj9MrHfvk5iFkFEkYZnddZ/ZfLeSR
   YgNTXCuT1JdV4DZV0fNA77BEjf5/kxWpuw6MwwEDhXH8Ze/Ck8xnB5fao
   g==;
X-CSE-ConnectionGUID: Tpf8JBLNTueXtY62IJkt/Q==
X-CSE-MsgGUID: +Q3mC4gPTZ2TI49Lh8TU0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="274998"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="274998"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:48:39 -0700
X-CSE-ConnectionGUID: BNIRpSLdSWOBOuoC1HRyIA==
X-CSE-MsgGUID: WmyvUiS1S1WgmlXYfurX/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2244574"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:48:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 14:48:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 14:48:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 14:48:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJbmH41UOQuRz2dEwGPYKafRYfymr0KmOMwRN77VyPw7kw9Wf3T6aHfY8GpI1VqPhIT0uoswOlxGNIZH6a5Xxas77Sx64C9LCIOT34WnvLq2Ht8sxnt8BAwu6yZdxtXAN7I9fAwzv/Ldw0QjYi0vgf4OnXoFiLNppiqUSP3jkIO1TdpY3OTGNjUQ1ISY5OdmQSM8kMeYfRDIolImEimRULAJFrvBMZDYaxLMgwacLpwAyJugdePUsmT/CmZyR6de2PYS6hgodw9RNTZ4DBZ2E4JSayU07Sxiw6/ipCCRyh87F1jx4Qj4h4RW64auzGXB7N3i44Ll4uf3172vax/0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upU9DudV3Ms7lDLTExWkoI7FgC7hvFtJY5n8d7fpsLI=;
 b=vvRq3DIy3WRAz8StecG5n6mdGUxQqfz03mwbw3APMS8DcMAIcOwu582rfW1TBuosXyfnpvfgkttRPVSXlBRM0CjWY+e6u0/kM1dX6iqnbRHxNcYr/QGu0FgcAd5xihpsE2Le1J2rAfsnmCx7kh7QgLoBf64JeDJSzSjvRZOsDNRXmsR5UP7q2fOioG4zWTGWCf54Qg4vmNhxDi7FdlxqHL7X7hyYQCOEQKJBcJMN/OSGwH0ysnSyyraLBkHTSEDT/7iyBvi6dsSbXouOXjLhJYhKmFWUkueVAWSw4uMG79aunLEVHGXaysSHdQQkgU9InQ8Ycv5HOK9tl2P9p/Rktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by IA1PR11MB6369.namprd11.prod.outlook.com
 (2603:10b6:208:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 21:48:35 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 21:48:35 +0000
Message-ID: <103b5631-01fa-4dd0-8c11-e2bb20960850@intel.com>
Date: Fri, 9 Oct 2026 14:48:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<aleksandr.loktionov@intel.com>, <decot@google.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, Tian Xun Ng <tianxun.ng@bytedance.com>,
	"decot@google.com" <decot@google.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>
References: <20261009032706.94324-1-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261009032706.94324-1-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|IA1PR11MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: b5534905-196f-4b00-20c7-08df264f11b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|7416014|18002099003|6133799003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1DJ1PNonWphXODocjXY1btx6tq0j/LQrTHy+KeW4vjX89WmekvRlizTkhRwxW4pXIBwZRdK1mVrlwmOef3dZ8br7l7wxC+voqWNXJdZMFs462M98p5gzoRQLJG3z8DQgFjURFhgaUKBRcyjYobhVlXAdH3vNUayHu4Zk4OI0ge6scEE22gJapV0+t6R5TOYMUvwgW2R6B+UMP4eLa8I2dQvbWAFyjAMjOZZg2nR1Qd9Ns+j9i1+q0wL65ZcTB+eeQiUGFzAnjIlZUBisGCQBmUOLNRxUNgrLz5ehp+pICxy0vwGNZVQ7lTvNa/ycIYdlAKAaPCH7/DTFfJKpixBrW2UMa02RwOlPOau+IEKdaVunJaIuXg2pwuRN9nUyt8TBU1TSdzq5T90HPKbEIaULIbWCwVd9C1Z2rezIy7PS7oFTvg3q74L3KS8+1IMtGHc4cz8vpOIp1mqZ99az34N+NYmE5w07EbvqjiwYD63D4wVj6f6IkG9nnXJGa8Rhwo543RsqWOtpMJbKHrjNGSD0DDbds+TqlviV56o2a6XM/oEZARUXHUAMeLbN5ZH3E+G1qxRPN3HpFWLyLnBMAjpv5ERdshjvEsXGVdhnvxKtY70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(18002099003)(6133799003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui9ueDY2b295WFBRTURNTU0xY1VhakdNdjEvalVKYVRlQTM2WEx1Y012OTRM?=
 =?utf-8?B?c3JTLzJQVDJVTWN4SUY2bTZqTmZkU3liWm1IQS96UEMzY1pYTHdJazE2Y0t5?=
 =?utf-8?B?bWRQdTRDOVdjbzU5SWhWWDNjYlJtY1p0WkExTTA0Mm9ldFk5bGNoYzJZbkdz?=
 =?utf-8?B?SG1JenlRYTNiRVQ1T3FtTXVJMTkvVTl1d280TlFUYUhCdTVhRU00cmJLUTFP?=
 =?utf-8?B?Lzc1eUpDcDgzTDMzK0pQeW5RY3Y1TlRqK002emZDNzJvclQxeXVPdExzT2tv?=
 =?utf-8?B?RFJHSTRXTENBOWNNSlBxVlNWZi8zR2k2TFhBclBVTjVhN200T25RL25aeDVa?=
 =?utf-8?B?SndXbDJYZTI3MjFCSXY0VVBTckt2NmUwditjREtBd1NBYlFOUFlVOWh5cUVx?=
 =?utf-8?B?cEhXbTRYQ1J5S0VnYm80bEdEWkp3eUFPT0w1UHF6M2l6N3Z4SDBsUHlzODhz?=
 =?utf-8?B?RFM0OTMwUmJ4eWhrYTZjakp0Y25XNHJEb1I4UzdtQjhoYXpTWTkveVNjbWJG?=
 =?utf-8?B?M2liQVJZNjZqUllkQ0MwM1JrWWxDR0dWY3lnQnRaQlBJZkVNWVlrZFZGc0Rn?=
 =?utf-8?B?MTl2RVVVS1lKbUxBREdBOTMxb0doeGlWa0ZoajRTSVNaRTNXODhMNFJVeEVW?=
 =?utf-8?B?QTRkWVl6VXlRZmxTWnJEWVJWN0RXeTlSWDdYM2IvOWExMFN2RGxhb2hjcTVR?=
 =?utf-8?B?Y1YvcHJsRDVtQmdPVzZnU1ZZcUJIR3RlZGkwRFFoeHpRU2JNQnlTVFBJUFNS?=
 =?utf-8?B?R2M0bTBhcXJBdVl2eUcxemhsbzU3YzNuUVRINFN1MDNzT3A2REEzNTJyamVY?=
 =?utf-8?B?WC9tRmx6VU90NDY2WDVVT0FPYXNOcFU0TWsxcERUYkdTOTNHbitvdUZiZWdx?=
 =?utf-8?B?N0R3NWpZeGoyN1UxM0hpcTdueHRpN09KVGFvQ3pSTDBFTnkrVThWOWZXSHBD?=
 =?utf-8?B?M0ZvbGQrKzFvYkN5ODJ5M1ZYOFF2RTRnZG9lZ3Bmd3lWL0Zsbys3ZURuVjEr?=
 =?utf-8?B?ZC9tYVpvUHRLVGRBeThjbVFsbXIvWEtVbHY5cm0xbDRvcjlSQ08zLzdhaUVp?=
 =?utf-8?B?NldtZXRlWlBZN291aFJQVHlMZzBXakdEU0lQR1dqamoxUS9uUzdOU1pSbklx?=
 =?utf-8?B?eCt5dVpraFFwL2piWGN5TE5hK1dudExIVUJWSEUwYms2aTkyNGgrSWE1WElj?=
 =?utf-8?B?NE1zc2N4Q1RTa3BFUlVYMThJeVBzWjFpNEh4Z01HMGVibkd5dXIwWVJpdHkr?=
 =?utf-8?B?QjZvWnhjaFRISVZ0M1VEKzJFcC9XU3Fia3JtekIzK0U5WVoyYXRucW5tSGN1?=
 =?utf-8?B?aktnU09IdkFSR1ZldWVWSHQyaGM4WlcwRWpjQVFVekRzSUxWV3dYS2tWc24w?=
 =?utf-8?B?YklnbWlSQXd5TTE0d0VaYjBUd095aVVRZUcvL20yYVpBK3BqVnFjblBXMDJj?=
 =?utf-8?B?bjNWUmRDaVpGVTdZRUZFYUszY0o2RjdiZEFHS01Mekg4dHdKNU91RENOclFm?=
 =?utf-8?B?alFjUWJMS2E4aUJVUkFXYTZwYTgzNHhvaWdjU0VRaE1Tc29FTWMvUHlnSmVB?=
 =?utf-8?B?Zk0vNkVMNkVvVVorRTB0V0dOQVkvWC9jSjZwU2ZzK1ZyZTZDNXBuNUdvMHQv?=
 =?utf-8?B?eVh5S1FvME1hSHZyTTVJbTFFc0Q3MWRqY0pFWmFabk1kby9ETmZXVTFtMUJ1?=
 =?utf-8?B?REk2R1U4SSsyZklsNG81TytvQ3VDQUN5WlRzbjBQRGpIMzlPbVBGcEtDNE9m?=
 =?utf-8?B?dmt2RWRRMHJOTGYrVUNSYXFIMloyQ0haTDltdTlKZDdHVGhlQXhDK1dmMGRH?=
 =?utf-8?B?Nm5Mb0ZOOUtEaTZhUGJIcjRmejJmMnlDSkhmbTc2MEVEVm1IKzVFYW9EdzJ5?=
 =?utf-8?B?UHJWSDVEY1EyUE5wZEtGM0hxaWdrRG5oQXZJU3gzdlcydm5IVi9JQTlHSWly?=
 =?utf-8?B?QzkySnlUdkQ4OEdxdndoLzR0U2JEblZaR2tMRlp0aWR3em5VbExCa1ZjVU1l?=
 =?utf-8?B?VHk2RTZBYkhJUjVyVG56TVIxYzVHSUR2dmttbFAyb0JVTXFuRjRWY1VUd1V6?=
 =?utf-8?B?RmRYTU5jS0UxVU0yUmtMbDljYjhPZkprR3RIN0srMjFSb010WCtxeEx2UTJ3?=
 =?utf-8?B?VHJGaTYxSWlVMFY5dGgvMktIbk1yQlRiMjVEU2hBUnh5UjltSU85ZXJyUC9E?=
 =?utf-8?B?SkRIZTk2NW54eDJOTW41OHVLNDhSdGtsRUdTV0hLN0JXTFVKQlkvY0RaVW83?=
 =?utf-8?B?Y1V2S0UyVUpnUUh3ZTJ1TXVXcXNuM0grRzFQbHh4K0EyVTNRWnR1cC8wUHlG?=
 =?utf-8?B?ZTVqc09nN0dFRjFXYWlzTlpBazdXNEs2SWNQdVkwNWt0YTRkSzRRWm5nRTh6?=
 =?utf-8?Q?Qo965EHlu7CbSKIo=3D?=
X-Exchange-RoutingPolicyChecked: mGFKFfE15MgdhrlKJPPhSFvyubxxjWeQfj2vtTRZF2BsjaHyCCrr3bnLGj/dSFGHFfhDWG462lsWIZfrlt6t6j0GlFj/3FHcEdTpPLHvCUT/RPsRm1Gu3azXPvPnfJBTd2vC2YAGbBn6Zi58qhN50lNaLV9aD69EgIJsWARrxPB0XE9ADmcLHzfQ8YY7kK+zZ+BfoBZnBIzVVAj0HV+oBe2fvbyhdh7qMUC+tAb0Bh/Qldxgsud9FBl61zKgI+6YsjsVryAENgm7TG+8TI4MrSpu22Y3K7pF/bHZkeGX5JnHb8Ow8XH/OOoT3AURj+BQGOuR9Qjy1AIP4JPPLaWcPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5534905-196f-4b00-20c7-08df264f11b3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 21:48:35.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDQ5o9CepnJLt54WXeSpXHZNzCDlHUCLEqPW1VEfEv8c2AYvc+1Dn0fGxYb6N3XHzAERQwr+1MKoQVsAgX0x4VjOZ7RaQkTKYfCanUl/FCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369
X-OriginatorOrg: intel.com



On 10/8/2026 8:27 PM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
> on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
> of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
> idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
> transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
> before idpf_deinit_task() tears the vports down, so every message sent
> during that teardown (disable vport, disable queues, destroy vport)
> fails at once, and the device is never told that the vports are gone.
> 
> A reset should clear that state, but on the system where this was found
> the device kept the queues enabled across a warm reboot. The first queue
> reconfiguration in the next kernel (udev setting the MTU) sends
> VIRTCHNL2_OP_DEL_QUEUES, and the device then writes SW_MARKER TX

This case -> DEL_QUEUES/SW_MARKER_TX will also need to be addressed by 
this patch. A CP that acks DISABLE_QUEUES and doesn't post markers would 
end up timing out by 500ms per TxQ.

Something like the following can be folded into this patch:

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c 
b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3afd6e62e86f..7ffd512561ea 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -372,6 +372,39 @@ static int idpf_send_chunked_msg(struct 
idpf_adapter *adapter,
  	return 0;
  }

+/**
+ * idpf_wait_for_marker - wait for TxQ marker
+ * @adapter: driver specific private structure
+ * @txq: Tx queue to wait for
+ *
+ * Return: %true if the marker was received
+ */
+static bool idpf_wait_for_marker(struct idpf_adapter *adapter,
+				 struct idpf_tx_queue *txq)
+{
+	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
+
+	idpf_queue_set(SW_MARKER, txq);
+
+	if (!timeout_ms)
+		return false;
+
+	idpf_wait_for_sw_marker_completion(txq);
+	if (!idpf_queue_has(SW_MARKER, txq))
+		return true;
+
+	if (timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
+
+	return false;
+}
+
  /**
   * idpf_wait_for_marker_event_set - wait for software marker response for
   *				    selected Tx queues
@@ -392,9 +425,7 @@ static int idpf_wait_for_marker_event_set(const 
struct idpf_queue_set *qs)

  			netdev = txq->netdev;

-			idpf_queue_set(SW_MARKER, txq);
-			idpf_wait_for_sw_marker_completion(txq);
-			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
+			markers_rcvd &= idpf_wait_for_marker(qs->adapter, txq);
  			break;
  		default:
  			break;

In addition, adding a check for the REMOVE_IN_PROG inside the loop in 
idpf_statistics_task() should help, since your patch keeps the original 
timeout until stopping the tasks:

    if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
         return;

Rest looks good to me, although I would suggest waiting for the AI 
review before posting v4:
https://sashiko.dev/#/patchset/20261009032706.94324-1-luckilystar08%40gmail.com

Thanks,
Emil

> completions to the previous kernel's completion rings. With the IOMMU
> translating, those writes fault about 19 s into every such boot:
> 
>    arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0
> 
> In IOMMU pass-through mode they corrupt pages the new kernel has reused.
> 
> Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as idpf_remove()
> does, so that the event task cannot be requeued and the vports are
> destroyed while the mailbox is still up. So that an unresponsive control
> plane does not hold up a reboot for long, cap each transaction sent
> during the teardown at 500 ms instead of 60 s, through a new
> adapter->vc_xn_timeout_ms, and fail later ones at once after the first
> timeout. A transaction that is already waiting when shutdown starts
> keeps its own timeout; bounding that would need support in libie. If
> the function has already been reset, for instance a VF whose PF went
> down first, idpf_is_reset_detected() fails the messages without waiting.
> 
> Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
> this change backported to a 6.17 kernel and the IOMMU translating: 20
> warm reboots without a fault. Each PF's teardown took about 1.2 s for
> six mailbox transactions; the slowest, VIRTCHNL2_OP_DEALLOC_VECTORS,
> took about 300 ms, and the queue-related ones at most 240 ms. With the
> driver made to skip sending the teardown messages, the first transaction
> timed out after 500 ms, the rest failed at once, and every reboot
> faulted again.
> 
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
> v3:
> - No new flags (Emil): idpf_shutdown() lowers adapter->vc_xn_timeout_ms
>    (60 s from probe), and idpf_send_mb_msg() caps each transaction with
>    it and sets it to 0 once a shortened one times out, which fails the
>    rest at once.
> - Shutdown timeout 500 ms instead of 2 s (Emil).
> - Set IDPF_REMOVE_IN_PROG before cancelling the service and event tasks,
>    so the event task cannot be requeued (Emil). The timeout is lowered
>    after the tasks are cancelled, so a reset that was still running keeps
>    its normal timeouts.
> - The comment and commit message no longer state that a reset does not
>    clear the vports (Emil), and say that a transaction already waiting
>    when shutdown starts keeps its own timeout.
> - Retested as a 6.17 backport: 20 warm reboots without a fault; the
>    slowest teardown transaction took 306 ms.
> - Not addressed here: with the transaction manager shut down later, an
>    async PTP Tx timestamp reply can race idpf_ptp_release(). The same
>    window already exists on remove; left for a separate fix.
> 
> v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
> - Dropped patch 2 (function reset on shutdown): on a VF it queued
>    VIRTCHNL2_OP_RESET_VF and then freed the mailbox.
> - Bounded the shutdown teardown and failed the rest after the first
>    timeout; no VF special case, since a VF whose PF has been reset already
>    fails fast through idpf_is_reset_detected(). Not tested on a VF.
> 
> v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/
> 
>   drivers/net/ethernet/intel/idpf/idpf.h        |  3 +++
>   drivers/net/ethernet/intel/idpf/idpf_main.c   | 10 ++++++++
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 25 ++++++++++++++++---
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
>   4 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c8..0739861a1 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -625,6 +625,8 @@ struct idpf_vport_config {
>    * @asq: Send control queue info
>    * @arq: Receive control queue info
>    * @xnm: Xn transaction manager
> + * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
> + *		      on shutdown and set to 0 once a shortened one timed out
>    * @num_avail_msix: Available number of MSIX vectors
>    * @num_msix_entries: Number of entries in MSIX table
>    * @msix_entries: MSIX table
> @@ -684,6 +686,7 @@ struct idpf_adapter {
>   	struct libie_ctlq_info *asq;
>   	struct libie_ctlq_info *arq;
>   	struct libie_ctlq_xn_manager *xnm;
> +	u32 vc_xn_timeout_ms;
>   	u16 num_avail_msix;
>   	u16 num_msix_entries;
>   	struct msix_entry *msix_entries;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 129bccaa6..ec751f4a6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -194,8 +194,17 @@ static void idpf_shutdown(struct pci_dev *pdev)
>   {
>   	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
>   
> +	/* As in idpf_remove(): keep the event task from being requeued, and
> +	 * destroy the vports while the mailbox is still up.
> +	 */
> +	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
>   	cancel_delayed_work_sync(&adapter->serv_task);
>   	cancel_delayed_work_sync(&adapter->vc_event_task);
> +
> +	/* Bound each teardown transaction, so that an unresponsive control
> +	 * plane does not hold up a reboot for long.
> +	 */
> +	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
>   	idpf_vc_core_deinit(adapter);
>   	idpf_deinit_dflt_mbx(adapter);
>   
> @@ -267,6 +276,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	adapter->req_rx_splitq = true;
>   
>   	adapter->pdev = pdev;
> +	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
>   
>   	err = idpf_dev_init(adapter, ent);
>   	if (err) {
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..3afd6e62e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -190,20 +190,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
>    * Cleanup the mailbox queue entries of the previously sent message to
>    * unmap and release the buffer.
>    *
> + * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
> + * transaction with a shortened timeout times out, later ones fail at once
> + * instead of waiting again.
> + *
>    * Return: 0 if the request was successful, -%EBUSY if reset is detected
> - *	   or Tx control queue is full, other negative error code on failure.
> + *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
> + *	   already timed out, other negative error code on failure.
>    */
>   int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   		     struct libie_ctlq_xn_send_params *xn_params,
>   		     void *send_buf, size_t send_buf_size)
>   {
> +	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
>   	struct libie_ctlq_msg ctlq_msg = {};
> +	int err = 0;
>   
> -	if (idpf_is_reset_detected(adapter)) {
> +	if (idpf_is_reset_detected(adapter))
> +		err = -EBUSY;
> +	else if (!timeout_ms)
> +		err = -ETIMEDOUT;
> +
> +	if (err) {
>   		if (!libie_cp_can_send_onstack(send_buf_size))
>   			kfree(send_buf);
>   
> -		return -EBUSY;
> +		return err;
>   	}
>   
>   	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
> @@ -214,10 +226,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
>   	xn_params->xnm = adapter->xnm;
>   	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
>   	xn_params->rel_tx_buf = kfree;
> +	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
>   
>   	idpf_mb_clean(xn_params->ctlq, false);
>   
> -	return libie_ctlq_xn_send(xn_params);
> +	err = libie_ctlq_xn_send(xn_params);
> +	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
> +		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
> +
> +	return err;
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> index 5d27805ff..911a25ad9 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
> @@ -7,6 +7,7 @@
>   #include <linux/net/intel/virtchnl2.h>
>   
>   #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
> +#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	500
>   
>   struct idpf_adapter;
>   struct idpf_netdev_priv;

