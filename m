Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793877594;
	b=j481qq/khofgdnsRzH70B2+Ah0BKbx4F/of5ziILudjbnUDtEiBEXziNgPlETYehYxgF
	 Oz5695nj0vBO9s86sSMMg3AHqZg7Edm7u6J9SNo0oqsQBpLgf843bssVId7YY71n2KF6M
	 PD0Zo1Eu9abqTpN0pwzXWolsP4G3E6L+8zl54vWnyPJ9I/y+HwOOOv/ZIrblg93+kGGTz
	 cZbJ2ykT5umgaGtWrFJQ7j0BG+v3BPOztt4ZGIuqHlPEF8D9dlXtVgxgWl/syiT+SBjOE
	 LmKnkWfUh3iF+LFpf3MtbLm0D4jtR9zvdjpIKqOmK5Uw5izZMnwT7e02jIyYyWX5ZgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877594;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=eFIFkrkJxNZPRHT1uu4SBh+H6ODB5Ufeynq3luJ5iR0=;
	b=GzRzKCuSrFA3Mvb90qgjLQqYb46+8CKHHefIGyk7kq/1u9zygMshOkb7TYb1wPZB5l2T
	 QeaRF6j1xbV/7CiQLNL0jI1xDlRs1OVgPTD/QySIxI3uLAqG8+jptzFIObmYnKxbf49cr
	 qEXSsA5JpzH2etzyLBV00LMTJHuhPryHqXVQhAomy3coqbvTGGkKStvqNXF1uVCVI1Ij4
	 3VL1fA4FCLC6aWntsdxDFVWaE3UcDsGHTV6QGOArQV1SKBiyHQwjuqcbcvPXsbJ+0tHPS
	 9PjB3CcfkSnTU4aS3ATFVvH0NFW4LKK9pvulrcwe7zdtd1K8xosH9GY1q6+tU/7dQ4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="EZki/3Oq";
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF1606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECEF1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EZki/3Oq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793877592; x=1825413592;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rR/mmnHo9EtwHquJQkMBALjfQi/wGGUZnMNzSyTqM6k=;
  b=EZki/3Oqffs3oXVGFarlrLYiI6itc+hi5f4oDxIOoIKxyGBEXKPMdNF1
   MSONJxKC41xqUDe0LB7AX1PIt3yvkVE0V1NUoIU/uvSzHvWw7CuirjqsU
   DeA8S7UJSkm66Xwnq8Yj99ramDM/8AWnz6UCgsVnwX5OPjWNV33VHd74N
   mpS1T/xFSxZ/iyg22RrV4fInY3SSyWMYmXwDqOuy0DUeI7+MWMh5Lw3At
   q74nXafO8P6qKAypIZmVrh2L8IbRF449DqEEeLTpiXbg1X9ywsvHNQISf
   HIjTp4F9n3XqxGYlDPT1lbNf+7HTDIhx6pmy+onLOyvDLplq4HGVjqYBF
   g==;
X-CSE-ConnectionGUID: 2YFJXzw1QbucoUv2qTbM7A==
X-CSE-MsgGUID: KE68Jqw3S5+Cxwvge3OzSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2530086"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2530086"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 03:19:52 -0800
X-CSE-ConnectionGUID: Ekbe24BBS36jhrq2cTaqLA==
X-CSE-MsgGUID: zp8Rx6J+RS+RQb/69983UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7392112"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 03:19:51 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 03:19:50 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 03:19:50 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 03:19:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnEBPUyb94IC2qfK2fCaQAB5JuYrk1oFk0jJJmwLuSXDULtq/HiLlsZBwXjj9YIplrRAFUWwVD2qTRroax3ur4KW4BGURsKP5MDkshOt3k9zExf9jSw6K2Lpv0etA386GjAifPVKG69rqT/FKkIhmLiBBPFEfnvyz3hUiTceapJCEcvqnrQOG1/WJsfoj3ygyhC0NMc+wDhZwDlQ0R9U53fWeLbhNqWIV3XOeCAcuQM20I0ZGBbBuHVgne/SfHAQd03z52AgX30jQRofGCHJvIJx4PZUlfZBqnDVpUZwvZW2VuR2q/XGDzOo6VnuLgr3UU6EVcMtDbqJKOrrJuGKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFIFkrkJxNZPRHT1uu4SBh+H6ODB5Ufeynq3luJ5iR0=;
 b=ElOPQdxpDm20aXCztiBcLu8VjNsMxGd4X0AEvMPltkvuTqI3QXxh4gY5/pQ1iB7GjJWHaMm1TqG6Jh+38hYsOVeolH+kGIwEfObThIlhkKadlNBYQa5vc7xV4ut/IxWpNw9w8PhRQ2HrmM75+tUA1JkyTNQK/wGQtox+WB0cWOEyJsEp8PQR7MctkWGm44TBCs9MPue9rt3f1Wn4wQmOEcvGVE8nt/aZfGHyvqSi+8Jd4oStepZ1oLGLY3kziAIUDDN/MewZ6zRamoJ7uZ0MMviMXx+Yaf4gKgB3njDv1+Wdkm0GIRBt7j350gEo5m6X1OFj4HAf+AW6vmnlXKfDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by MW4PR11MB7080.namprd11.prod.outlook.com
 (2603:10b6:303:21a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 11:19:48 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 11:19:48 +0000
Date: Thu, 5 Nov 2026 12:19:41 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Dominik =?utf-8?B?RHZvxZnDoWs=?= <241000@muni.cz>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [BUG] ice: rx_bytes inflated by up to 4 GiB per XDP_DROP (buffer
 length read after libeth_xdp_return_buff())
Message-ID: <auxmTcwi4J/k9Xb6@boxer>
References: <DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com>
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To LV2PR11MB868673.namprd11.prod.outlook.com (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|MW4PR11MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 6602f4e8-0753-4d50-b171-08df3b2eb3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|261022075727099003|56012099006|11063799006|261028144727099003|261022105027099003|261026121527099003|261021135927099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: fX3ys1b3GqPQWNOu1e7NQgzNvzVcMj0iX1IaiPWol03KnKYASP43FTXGMLnYfYfqxLY9W3yhECYNtYcITwf7r+pUUXqffEGCMuSwcXXOf2z+wid5TmDWa9q33/CoKLzjlWZCqNSyY/Rwve/8aA3RFE/25PBF+RUKZG7ehiX5Z497A2dbccMgFTPHD65gefZ+mXzZVRYupUGjxw7mzWbcWijGWb3SIW2uFxYKxAWAueyKtBiqKU8bd6z2ea1flSOAUmYnyLxvPnicQ37dJ2duXXQRG8ZuJdu/FFk3yFtt/LaRBjTNfUWMH36E2WII6Ow8MrEZAP8MbIun4DjEz/nDKJZ5ZcoZkhPBiJgdIX0pIAGDmpyBSuWa68QGZfb9pNycb9VfvAcAihe6eAPZwItQC+1Pl+kHKoSWRHBl3r2P6btNXwIYUQNK0G+ZrZ/E0KGjAW6fuZ7SuMpSSkq/PMKlSodqLdWqVtMVQnLpuuj2BD1okUdm4NU2nlmUd52yf2phSzD1wUqSA3+15MWg1MlzG3kXW2er1r8hL3YlnydAXfH5OeujLhTZpIXJrlsj2pJyBTPXXcHdQEQvrp+87kjwxFgcfLt7XmmorqLjoYnBKVQHCPo/0e0bwdV9L0VLI5wBcHioHzV9+GDcqhWkKmr6yIoaLfHZ6r7a57OV53VjJ+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(261022075727099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261026121527099003)(261021135927099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZJRDYwSnhqR0pZNWhTSVk4cTVrY3EyQ0ZnZm8ySGFhSGM2bWhlMmoxcGx0?=
 =?utf-8?B?R2YwVzlnL21FSEdzV3JLc1lsM3lRaDJxdnNnT042aHJDSG5OTER0endOQ21v?=
 =?utf-8?B?U2dQeWcveW5Sd0RVeDM3QlB3YitDdEJuZ0J0UWFCTEsyYkNzcFgrVFlJV3Zu?=
 =?utf-8?B?ZUhXcWRYWndrREpWYk5SWHdMclB1d3NjY3BmNWQ3NDU3KysrVnpuS0pSVHF0?=
 =?utf-8?B?TlFlWHNwbGQzblQwMnR5d0haU1UxZ1FoTFRwOTBPWVhQRysvc1VqcHpDelQy?=
 =?utf-8?B?RkJ5T0hQSGlUNE9xaEtITGc0RGljSUFKeVd5WFd2V0ZJOUFNcFJEcXo4Y0R5?=
 =?utf-8?B?bXVzL0tjcWwweHRmTDZ5OVhGbWRXRE9FbEh5NG1peXJHLzh6VHgrREF2S0VE?=
 =?utf-8?B?Sjd2dlJIbUg1RkY4b3VtZE9nd25xQnA1b1V4MVBUT2ZNR2MyeW5VRDJlN1I1?=
 =?utf-8?B?eDdZS3JTWElKQlFodE5sQXM0SnpPYXJOQ2wxTGNMbVRWNW9qTTQxMlF2Y1dO?=
 =?utf-8?B?eGRFRVZGeGo1eGs0LzBITXphc0orRE1RVkVTcmFmRTZTRE8weW9UUmdGK2s1?=
 =?utf-8?B?c2FYMUN5VTR5MUIvenl1OFgwMmp1T25Bc2RoYmVJc2VQQ1M3TDhyZU8wMHhZ?=
 =?utf-8?B?Rkg5UENNYTlYQ3NqVXNDZmphR0VLaDAwQ3E0U0xKNmVSd3UzU2tSZHVwdExj?=
 =?utf-8?B?TSt0cVpJQm9vaGd2akVtdUF5M1RwSHlkRnBPQ2s0QjkxTjBqQStiMWF0dWJw?=
 =?utf-8?B?dTFlcllwK3haRnMyNGR6OTNMd203M2JYTFZlZHZLd0NBdkxjcSttUTFjdDZN?=
 =?utf-8?B?cUt1ZWJ3VkRRTjRGcmFWSjdVOUVXNitMZUVXMXE5SGt1MmFIc0xkQ3JOQUxC?=
 =?utf-8?B?T1JySFlFeVJMeGVHWDdrMjhjL1lqc0tiait5VExuVkl5Q0dGV1VBU1JBaTZq?=
 =?utf-8?B?L2tZUU5uQUlGVDhKUStjeER2YXdESHpiN0ttV2hlb1UxTGt1aUNaTS96ZDZ4?=
 =?utf-8?B?VCtzTVBZYllnbTVVeUpHaFY3YllLWnVpSlRwaXJ0YjNkbTVsWnVpTU81TUVi?=
 =?utf-8?B?R3dBUUp5Rjc2U3M1dkRmRWpRMldBSzJhT095RjFYNFhaVE1qMkJqNk1JWEkr?=
 =?utf-8?B?R1lkWUxXc0tGUzgrWmVQYnc4K1FhYmZaUEJTc2tqSWt5VjZOeFYvNjZ0aWxs?=
 =?utf-8?B?dGxkSnRHdUtPL2J4NUFHZzN5ZTlCREt1dW0ramlFMEp0WjEycEVORXFWM2lR?=
 =?utf-8?B?M2E5M0RlZjd1U09JMktVbWR6QTB2OFFqZmpaWnlQTTBuS2xpcHh5YWZLclha?=
 =?utf-8?B?Zmx1YktvWnd0azRTbU1zckpiQW9IU3JUM2VqL3lCYm9wcXVwZXdNQ1J1WXB0?=
 =?utf-8?B?NTc3YnBpSGhSNDRkUnVHTEZjNHNTWFpOWXlxMjVieG1zazd1MkxuZFozczJi?=
 =?utf-8?B?NnppM1lVYmFLVDBkaDdORjg5elhTaE4vSmFWT1ZOcW1MT0xqL1R2Q0dJcDla?=
 =?utf-8?B?YWJlcDJaYkREeC9BdUp4T2cxQS9LdENpTFZBUjNqNCtqSFVQanYzaCtKL3ND?=
 =?utf-8?B?TWFTenFwUEtxS1p0bTBoRE5MVmZFTE56WkNrMHFTNmNPd2ZkUzRKS1ZjaGJm?=
 =?utf-8?B?R1R0UXZOMnVvcVFQZGFFWFhrOEdjVmVlUzFmK3BtazdVL0VhaUxYU1RhRzJp?=
 =?utf-8?B?NklsMTAxcjBubjFuVXkvbENiNW9QRVd5VmxHOFhyQjg1Skh0cTRXY3VWZ0hH?=
 =?utf-8?B?ZDJieHBaaDFNNytLMk1ud3dnRUhNSm50SGlpZzlCTm5xSEkycHR0bE93cG1E?=
 =?utf-8?B?akFzQ3FtcGZVc2FwUGQ4b1RQK3gycjFZemZoQjhxK2dpM0hZNGhBakEydm9x?=
 =?utf-8?B?RENJRXJVb3QyVzFnTFBoYkdxbUZSWTBCSGUyMVkyUXJMZmV3WkkwQmIzbkVP?=
 =?utf-8?B?dnpKbU5BU2xldGNmTUJzNW9sN3BJMEl2VEJhenF1TC8yTjk2b0RuZjI2NjEy?=
 =?utf-8?B?ZVFwK2prcGh1TlRKdVd6S1VQcm1KREM0YW53cWVsYjQ5Q3B0YVFEUHg3a1FF?=
 =?utf-8?B?UHhoQUVYVmlVVzlVOFRKd09TSEtEZktGd2JpNUQzWE95UVFweU9jSUV1ZFRx?=
 =?utf-8?B?eWJVYVBPNTlkSmJ0MS9ZTytmd2tUUGQ4OEZKalA0dUFtNlhUeTUwNXNiVExW?=
 =?utf-8?B?eExOWk1mWVB0KzJQS29ReFJwVU5nUkpvcXdRb2RBV0tITnlMWVVMdHNuVkgz?=
 =?utf-8?B?TTlkVmd4UmdmUjY2QUlVRGd1QVZzZm8vWnJwVXlOTzY3YUtxa0JwL2lpWG5O?=
 =?utf-8?B?S0pJNHc1U1lOQ3dnaVBFNzdSLzVTeGROWGhhK0hwRHJFQ1VqOTEvRjlSUGJJ?=
 =?utf-8?Q?dDeTkEgvyLCPFA8Y=3D?=
X-Exchange-RoutingPolicyChecked: 49ODD/mAOHHlrU2zAgvf3k3aVMkN6ZHjdIsbrMSxKcvs+X24ZP27wGAdC1h9yavycRlYpS4faOrWCmYMzimjoS9N5vwShUFkYWhjoSD4b9aThkFotms3sX3AvdqF8I0T7zCyHlAZpt4zMBYxBn5lAYhFCCT5P2LsksmllYFrC32E+kizLa8Jrl7VHSlPj1tjar51yh8ZW+htHKFO29JPA79fwDmoQOXwA0r/wXjYNR8w++44I2U5WFNrgJc7ku5Zn5u6GFB1ypRnpx+GcYOHgHdiq7/oUSyZVOdhl3olmIxKjOijMycM1hR2HYh1G3dK0Y/H9lxz+XmEfcVb8rcUoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6602f4e8-0753-4d50-b171-08df3b2eb3d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:19:48.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5QdWGeA/ffjFUXb4FRVfCKdmuUHAYkKN5pCKmID/9tYqwoQjGv84dCN3C/UPKvlVWS1iN7pbwYiawCdPGWO74s7cDSd8ux5eBlXGnelfKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com

On Thu, Nov 05, 2026 at 09:05:19AM +0000, Dominik Dvořák wrote:
> Hello,
> 
> after upgrading the kernel from 6.8 to 7.0 (Proxmox kernels
> 6.8.12-34-pve -> 7.0.14-26-pve), the software Rx byte counters of an E810
> started showing phantom jumps of hundreds of MB to several GB. Each jump
> is exactly one packet. The cause is a length read after the buffer has
> already been freed on the XDP_DROP path. The bug is still present in
> current master.
> 
> Setup
> -----
> - Intel E810-XXV for SFP (rev 02), FW 4.30 0x8001b891,
>   DDP ICE OS Default Package 1.3.43.0
> - in-tree ice, kernel 7.0.14 (Proxmox build 7.0.14-26-pve)
> - 2 ports in an 802.3ad bond, native XDP program attached to the bond.
>   The program returns XDP_DROP for blocklisted source IPs and XDP_PASS
>   for everything else.
> - 6.8 kernel with the same HW/FW and the same XDP program: not affected
> 
> What we see
> -----------
> One sample, 1 s interval, ethtool -S plus netdev stats:
> 
>   rx_queue_4_packets: 76843 -> 76844        (+1)
>   rx_queue_4_bytes:   32920496416 -> 33701427810  (+780931394)
>   rx_bytes.nic (HW) on the same port grew by 2222 bytes in that second
> 
> Only the queues that receive the blocklisted flows are affected (3 of 16
> here). All other queues show normal bytes per packet. Every jump is
> smaller than 4 GiB. 780931394 is 0x2E8C1142, which looks like the low
> 32 bits of a kernel address.
> 
> Root cause
> ----------
> In ice_clean_rx_irq() (drivers/net/ethernet/intel/ice/ice_txrx.c):
> 
>     xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
>     if (xdp_verdict == ICE_XDP_PASS)
>             goto construct_skb;
> 
>     if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
>             xdp_xmit |= xdp_verdict;
>     total_rx_bytes += xdp_get_buff_len(&xdp->base);
> 
> On XDP_DROP, XDP_ABORTED and a failed XDP_TX/XDP_REDIRECT, ice_run_xdp()
> has already called libeth_xdp_return_buff(xdp). That function frees the
> buffer and sets xdp->data = NULL. xdp_get_buff_len() then computes
> xdp->data_end - NULL, so the low 32 bits of a pointer get added to
> rx_bytes. For multi-buffer frames, xdp_get_shared_info_from_buff() would
> additionally read skb_shared_info from a page that has already been
> recycled.
> 
> This looks to have come in with "ice: switch to Page Pool"
> (93f53db9f9dc). The old Rx path did not clear xdp->data on drop.
> 
> Proposed fix (untested)
> -----------------------
> Take the length before running the program:
> 
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> -		unsigned int size;
> +		unsigned int size, len;
> @@
>  		if (ice_is_non_eop(rx_ring, rx_desc) ||
> unlikely(!xdp->data))
>  			continue;
>  
> +		/* ice_run_xdp() may free the buffer and clear xdp->data */
> +		len = xdp_get_buff_len(&xdp->base);
>  		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring,
> rx_desc);
>  		if (xdp_verdict == ICE_XDP_PASS)
>  			goto construct_skb;
>  
>  		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
>  			xdp_xmit |= xdp_verdict;
> -		total_rx_bytes += xdp_get_buff_len(&xdp->base);
> +		total_rx_bytes += len;
>  		total_rx_pkts++;
> 
> With this change TX/REDIRECT count the length before any
> bpf_xdp_adjust_head/tail. If you would rather keep counting the
> post-program length, the same thing can be done inside ice_run_xdp(),
> before the buffer is returned.
> 
> The root cause analysis and the proposed fix were done with the help of
> Claude Opus 5.5 (Anthropic). The symptoms and measurements come from our
> production firewall. I have checked the code paths described above
> against the v7.0 source.
> 
> I can test a patch on the affected box. The issue reproduces reliably:
> each XDP_DROP produces one phantom jump.

Please test and send a fix. You've done the root cause analysis so would
be nice if you get a credit for providing a fix to this issue.

I can then test this on my setup and give you an ACK.

Thanks!

> 
> Thanks,
> Dominik Dvořák
> Head of IT Services 
> 
> Masaryk University | Faculty of Economics and Administration
> IT Services
> A: Lipová 507/41a | 602 00 Brno 
> T: +420 549 493 183 | M: +420 739 487 807
> E: Dominik.Dvorak@econ.muni.cz
> 
> 


