Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793050215;
	b=ZDG2Ay7oQNHmubCAedzvZwHmjS1/IiZTfxtjV3UmDB3TnamTonMN5pM+3DmGQPc8WTpz
	 16ktc8NtE0m0WS/Xpo5qamQnYCZy5lIqnmMsDDU7S34sn5USc11ezPv4obtN4YCPzCJxB
	 j1QUH+AZ/kmXqNO6lXf8GFu4QJ67qYRwnXqZZT/MSl4/G+AOkkbczsqOr3ngNLPaVTk6v
	 ijFyXcvCDl4KFiA4RxFqNpV5DKBJV50XhPflexzQSy5yx1S8rC1pAQ7mg4jJR/2Qlv7bW
	 qjKA/rizQC+YESRP3w+Tg144GnyjYqi2yYU5nVCkj3JfNEleC8ye+pPUNZXPczCs+mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050215;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=+AednM5NerATvO4iJo7yYMSzlsSGhwD5kTT+yfIr0+g=;
	b=mXKYQCTI3/61YqgwGNoJ7aZdD4uv8BKWFvzgova4Niv3Y3gwWm3CSQ9oBcimFR1UrOnU
	 BVzM7bZwoainvyttkKDJMeT5/ml1skKe/Hgb9ZA14IEZHeiWcBPs8ygbqrdzqcelPEYMj
	 vKUn1iWZbY/8BQ88KU9X8I0czOynmG/3B7j8poYbEGD9p7RbppY3bVCFEHgBdEUNuEqmU
	 FexRYOwtp8PJCdwTWnRh3s4czYynwcbiMHFBJtJEw4yh1gyZj/M0IjbWbSAxTvP/0+NHh
	 t8BlOdO0+rDoCu6Dew/JD4B4jKAaMWi80vxRwAJ5WSMF5uW3MKCRjW9W3EdKbD9HljQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NrOpugDS;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE3606A321
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFE3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NrOpugDS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793050214; x=1824586214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+xR7ldkjMzEas3sk1JXa0HvNCLTGzzrXs3Dc9/9Vhc4=;
  b=NrOpugDSgyhDX3ZAuLeIERNKJgyjdnwc34Mulyil49jkJ3fnT7+X2Oii
   Fuk1XAyRkZIfGjSx0pNOwwpIxIWvRGOZmUZFcNDT7cPvfdIdWtMH4CnQ0
   GVS9XXVShTcVCFM9xpMiS2RZHKCR1jnriy1R2tNbxKyBgG3nI3+WWpQtQ
   AjoixGd8Dyg9OqfK+ip7gvoCFPnzaMwkgkul9LjEup9x8mEpOToS//3/H
   WrARds8ZbFKQgzIp8OEnWWop91q/wB8402h7dWRWTQhPdrxT45HysNUS6
   Revj4RNGklHy+lpmcY0Pk5Lh8PD1FZfYu+emGBspveZmELFVIypcivcCm
   Q==;
X-CSE-ConnectionGUID: z2JFjwwvRsmV8rE0rZ5JNg==
X-CSE-MsgGUID: apyhQaKyR/WH49sgi0LqHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1841649"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1841649"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:30:14 -0700
X-CSE-ConnectionGUID: cUzBjaZaQmOK0gHQnOZflg==
X-CSE-MsgGUID: Qj19DnGsQdmPkJRD8GFC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4757614"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:30:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:30:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:30:13 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:30:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tiy72OvcYVcdBg5rZB+bD3BQ1W7EdmrYNbbk+XLW4hsIgeIAcaGMcbfEUEJ/tHvuIHfHjjBxdway5cSxhy+thVtQ4iRfb+WgO2ydt8h4cdsqynA3JF5iO8YnggZTpX7PtntONwl+l0rsN7ob/dz8AOuX3sG6mZt7F98sIM+QOAFY+27sjweYaMh4wrWIyrqS4e4bK3+Ct/NIyoR3GNpDSP03Q9+7GLHA9meooQDRAnXE+keluHeKCixNdBAGBd+P0T8IrDJxXgs0rmmNsaRxTP2MbtPVj5+8hi1BfO8dq1G6uy3behnpR8kLwWqPsSZuThvSsUteL8k3UKvFmFeV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AednM5NerATvO4iJo7yYMSzlsSGhwD5kTT+yfIr0+g=;
 b=g7kOnD9YEqL/9DdoWdUCFUMXLFSAgAwxroUQG4KEg+CJ9CryYub02EQqmMxCUzmWQasQMmWMivNvH1XocoT316fEbflt9mkXcrWqlo8IH0v+dsXdKEvfV/W8QtGVDwgnsga9jthmLiF1ujTZEnDraHM/xQfkPVs/jBqTQloff37Ve0kEHKUaHo3zJw4Whco3LEaaDAi6IirzCgGtqf3i2yr2Zzj8EhHIK5hzh4llsOAa2DtQFdiuhlKATL2H128uLITQbrdStGMwz9nyb6o3VGdz2AGLW5MPur2oybXkSY9NtJQ9dlJUEVxfdi0OK3oJ38nvBjhaziPNV5vTbr4g2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:30:09 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:30:09 +0000
Message-ID: <67e69d49-6018-4981-8443-6a6860284c6a@intel.com>
Date: Mon, 26 Oct 2026 14:30:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 03/13] ice: fix PHY port restart serialization
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-3-72289a4ac8eb@intel.com>
 <179297183566.3134.6646066636705775074@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179297183566.3134.6646066636705775074@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:303:16d::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA1PR11MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 63971584-ea4f-4c41-5236-08df33a84f95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|261026140227099003|4143699003|56012099006|5023799004|11063799006|261009223027099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|18002099003|22082099003|261026121527099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: j4r9aaVMwhTCJwZyNgWfdiEU8Md/MQcGITe5QWX5cOwzbdp4GkKCik8LUE9Rv38tWmSTjhKmCVbCpE/1ADwdcS9j3QwzdXNVCNedSbuN7FcjIO8Lf8dupB890O+w+o2fDejzYRkTd4fs3HqgFaksZCX0vveLvmuxp0M7znEN+h3KxVOVdlJYQjRFPnBF/cyE4OZJNV8Zm9nMejPETK1tDZVk6jONqIkrSeasc4vzOcIHntGJbCKrIKYEYMs80+7iOUvwP9DOKizjtC3psV9ybrsDgvR4NmAIsC8uRRFm9B1PSY3uKcwuamJeMIgKR2dcZdKNrDrhpnuj2kH9WRJmWvsmyMlL7Pl+sTJAJfbLKnk/2RwKfhfrCawIb+Gre0A4XdjKuAIfNolcSOUtbYJx+5zqqcuKUrg24pm6v+ShbGFoLUofNNo/iFkLCZKZFeQwx1LMPOqWeFeFOoYel1FbCR/8hNDaDdCRWdKO4b/XmExUhPIM80L9JZXCWOJFyNvHDWxfpxbi3tyYNu4eXfs64FwoZiXoXCC/jrAAePoP3C6WNzOxVUt/y+OkUztlXvwjsjqmiba8wiYMhzCgaJgkH+c3S/qxj3Ni1pOCWMSi9/WO3Own+WHG/8a3qONgrI1S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(4143699003)(56012099006)(5023799004)(11063799006)(261009223027099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(18002099003)(22082099003)(261026121527099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpGbDdtMlFlcTNnUVRBeGtXdUx5OVA5ZlVHQ2F1M0FVUW9xUE8rVjBGUHRC?=
 =?utf-8?B?b2RINFRpMS9vSGsyRDV4ZVpMV281WWFSdEhkM2dKc2pFU25FQ0hmN3BUZWdj?=
 =?utf-8?B?UGhXcmtSUXQvS29YZVZEMjNGaUpZanAwd3JFb0hIeFVZdUcwTlJzaVdYVTVO?=
 =?utf-8?B?Z3Z3c2ZOOVZOeHZVQ25LSlBqNnZweHpiSFBkV0xlYXpYVGFuSFR6Y2Y0cGw4?=
 =?utf-8?B?M3BxWHNWNEdMTVVBYmg0UDFUUkVTQjUvREdpMEh1ZWRGanQwdDE4V251QXRr?=
 =?utf-8?B?RXVmNktabGxpbDBLamlLbmpCRE1LMzdXVytsdXdYSUkrVXV0Rjkzak0rV2Zw?=
 =?utf-8?B?RXc1TEtNV1FCN21WMjROdGp4Tk1LaGdZWWJYRk1Nc3BDak91UmRDRHplR3hX?=
 =?utf-8?B?TXp6NmpEcmVXYUtqZm9xUEp4ZktqekZjZFE5OTd6MllyNnh6SU8xSkpicmFB?=
 =?utf-8?B?cDV2WUtZUERsRitDYVhwZmFRZXJuTEJrMFJObGpBQ3FSSVJvbVpSYjkrdWFF?=
 =?utf-8?B?MHhJZGlIcUhpSlo1cDc5WFE0T2YzWS94anQ0YWhlbVhvd3VpODM5TjVLN3lN?=
 =?utf-8?B?VjZRQ3A0c1VRZk1aMGVLMUVNWGoyS0tHZk5yKzkrYWVveUZtM3c4aG5NUjQz?=
 =?utf-8?B?clJWQVd6RzR0WGlKbnFaZVNiUXpTM2Q0UXRxRkROY1pzTlVSbHpPR1V2K1k5?=
 =?utf-8?B?cnEwVXFNaG9qY0NnTkR3cTR2V1UwRzYyWHR4NHU1dDNkM2g3UU96UzhQMzlX?=
 =?utf-8?B?Z0FjVVJQYWJmZ1pXQk1Ia01vVWpsWXZSY1kzUm12YktHZGFJTUN5dklSeity?=
 =?utf-8?B?NVROMVlKaXZnMGwycHROTVd1TlQ0Y1h4cGlONXJ6SnF2QUZVQ1NkNUY4OFJH?=
 =?utf-8?B?UUlWbWErNldXNmNRMWJwNUVNWGsvbUFxeHJFOS9EeCtSbXpELzBHa1lMcWhU?=
 =?utf-8?B?WUZFNkozbTBzRHJrYjN3YmYvRUNpdTBYdU9RMDdCWDBHaFFGQVlGTk1VVlBi?=
 =?utf-8?B?dmZzeVhpckhtV0U5bEhEbGdhek9wUzcxeXY1aDBmclB5WlNoUTRLVlRwRnBL?=
 =?utf-8?B?STZEajZBbzdWTGRzUDNzZE9TMTZoSmxuaFhJUGllREsvcU82NS81U05vQjJQ?=
 =?utf-8?B?Wk9RSldlSVJ5d1QrdWowWDZPc0tDa2lHeXV3V2FWeS9qbEZYcXBSZjVhSWds?=
 =?utf-8?B?SWhQNkJRMFBnUVVUTEV2bnpwUUltZlRCVlZIaHVvWTYyRzlSd01YcGVqWENs?=
 =?utf-8?B?WkQ0QWNLM3R4VU13UENkZzJZL1hCRkJFVkVMZSs3aWJaam9NR0VsWkZzckRG?=
 =?utf-8?B?UlVMQy8wWjBnakFwQ0xETkhJSDdCaFhOUXRiMWdwdG85eDdVNjhSNFdLNSta?=
 =?utf-8?B?TlRTOGJQUXNZaTdkbWdNcTJPSEY3NHlpWEpoNmcrajNQYWNBR3FDeEs0TnZY?=
 =?utf-8?B?ZE1jYUttYTh0V1V4RVYvMWxybnc0amtNY1lGMlIxNFYraTl3cDFXYm5CYi9Q?=
 =?utf-8?B?WmNOYUFKdUVMWSszSXVWdjYwMm9pQ1lvSXFscHVWUE1SSTRLSnlsNkpzMnRB?=
 =?utf-8?B?VHZtblRGaDE0YjcrZmMxcXhKeU1tMXdXaHo1UVRoWU1uS3ozU1lWOFVxQmlj?=
 =?utf-8?B?NGdEM3lxWFdLK2ZkMGZDWmY5Ukw2Qk1tVWkzMEpMVERxeHlHSXVPYzZ4Qm1I?=
 =?utf-8?B?UmltTkV2bHBCZ0RFZkdYT2NHcDlMaDV4d3A1NFR2ZkVTSFp0cnZVZnFmWUFF?=
 =?utf-8?B?SDYrU3V3WUgrOTNmMnF3YTdzSTh2b2JqQjZPV0owSUlPRDd1TGdYSXBmdTYx?=
 =?utf-8?B?TTI5YVFMT3M5a3FoUHZ5cUtoTmtBZ1Ixc3BsT1N6bWhZbnQ4Y3F1R2NvTVVF?=
 =?utf-8?B?cHBmL0FISGVOQU43SVkzVVUxbjhzejhPaExnU0tiSlNHYnRnL1ZmR0RGb2Ji?=
 =?utf-8?B?bC9IMHprZm1nc21DYVgycTlZa0VtbWdpNURZa3JLVFczY3lWZm5KaGprYVRN?=
 =?utf-8?B?akg1Y0xyS2Vxb0UwVW1WUWcxbTk3czJOZWUvWDBIVVlUZmpnUmpCdndZWTRt?=
 =?utf-8?B?U09uaTVTdUN6MGZDZ1ZVVGplTTRrWEV2QWZrNWZtcGR3S3ZpcGVQRktnc1Vo?=
 =?utf-8?B?eUl6L1E1RlVPOWZPSExwSCtYdEw0RFVPeEl0WmVBYjBBd2FOam42eUxPcllS?=
 =?utf-8?B?YlcxSU4zaWFkY3NhamFPK1lKcHNTYnVxRTZraDJnNnNlWk12MnVkd25SR0lX?=
 =?utf-8?B?SlRPUmtDMmc1QlRNNkF6cG41c3MremhTU2VqeEc1RnROazlMMzdtR01jci9s?=
 =?utf-8?B?emVSZXpSb29JeHZWa2lxOXpPZ3hLSDhMdVE3blQ3WTNGZTJLU2RHZz09?=
X-Exchange-RoutingPolicyChecked: IqoXQMroc0JtS/3UxRS5Oi1aFz8iVatkSDgX6FYrIxyOWLks+CeSkz+9ZMeJdKFLlj3EBnJLpuqIOTjlPl+MRvC3YM2aZeKuvTkP/8v19ap5q+a7ZQaq0DPCQDTchHkwNNtVExPf5U2oR4QcPf8BfHGMv/pK+JSQ1/afFnxGgof+EIi2RNwL1+HvtTHmB7RxU0f38MWIkd5RD5QB6uPVV8gnlNWt0D0F/t8y6UHB16gVKvkHG1TtMN9PRsf/YDXJQ790Wqq3aV7ZXyVjnQfvUjovUaXF6GMX+KJk8DRDm8VOoTpwGEUKoZ+eq3hesAJ6+wPu4hh2zc6qnomSGrP+Qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63971584-ea4f-4c41-5236-08df33a84f95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:30:09.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu6PEPpmuHKOZmITT9/gUaCV69+zfcg79tj2eOk2V9/MI+nI2tsKDrHTUlwfW5G6NCFezonkZlLnVG/u23oawxDYPlUZtlZrqdE0kYYgcOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com

On 10/25/2026 4:43 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 4
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] ice_ptp_link_change() now calls
>   mutex_lock(&pf->adapter->ps_lock) on every invocation, before any PTP-…
> - [Low] The commit message describes the .settime64 race the wrong way
>   round.
> - [Low] adapter->ps_lock now also guards writes to ice_ptp_port::link_up
>   and the whole of ice_ptp_link_change(), including the SyncE/DPLL…
> - [Low] The patch's link-edge handling depends on ice_ptp_link_change()
>   reading pf->ptp.state inside the adapter ps_lock critical section.
> - [Low] To justify replacing the per-port ps_lock with a single adapter-
>   wide lock, the commit message says 'the PHY restart procedure already…
> 
> --
> 
> ice: fix PHY port restart serialization
> 
> This commit replaces the per-port ps_lock with a single adapter-wide
> ps_lock. The lock is taken in ice_ptp_link_change(),
> ice_ptp_restart_all_phy(), ice_ptp_init() and ice_ptp_release(), so link_up
> is updated in the same critical section as the PHY start/stop. It also
> moves the ICE_PTP_READY transition in ice_ptp_init() ahead of the initial
> PHY restart, so link edges during init are not lost.
> 
> Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/
> 
>> If a PHY restart occurs concurrently with a link transition, it is possible
>> that the link state read could be re-ordered such that the link transition
>> would start the PHY but a concurrent restart (such as from .settime64)
>> could see the old link state and decide it must stop the PHY.
> 
> [Severity: Low]
> Does the race go in this direction? Before this patch,
> ice_ptp_restart_all_phy() only called ice_ptp_port_phy_restart() after
> checking link_up:
> 
>     if (port->link_up)
>         ice_ptp_port_phy_restart(port);
> 
> A stale "down" value there only skips the port. It never issues a stop.
> 
> The inner !ptp_port->link_up check in ice_ptp_port_phy_restart() reads the
> same variable later in program order. While the link is going up, it
> can't see "down" after the outer check saw "up".
> 
> On the old code, the race that does look possible is the opposite one,
> on link down:
> 
> CPU0 (.settime64)                 CPU1 (link down)
> ice_ptp_restart_all_phy()
>   port->link_up == true
>   ice_ptp_port_phy_restart()
>     link_up check passes
>                                   ice_ptp_link_change()
>                                     ptp_port->link_up = false
>                                     ice_ptp_port_phy_restart()
>                                       ice_ptp_port_phy_stop()
>                                         lock/unlock ps_lock
>     mutex_lock(&ptp_port->ps_lock)
>     ice_start_phy_timer_e82x()
> 
> This leaves timestamping running on a down link.
> 
> The new adapter-wide ps_lock closes both directions, so the code change
> itself looks fine. Could the commit message describe the scenario that is
> actually being fixed?
> 

I can try to fix the commit message if we need a respin.

>> Additionally note that the PHY restart procedure already cannot run
>> concurrently across two ports. The procedure requires executing timer
>> commands which in turn require the PTP hardware semaphore.
> 
> [Severity: Low]
> Is this accurate for E822/E823? ice_start_phy_timer_e82x() issues its
> timer commands without holding ice_ptp_lock():
> 
> ice_start_phy_timer_e82x() {
>     ...
>     err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
>     ...
>     ice_ptp_src_cmd(hw, ICE_PTP_NOP);
> 
>     ice_ptp_exec_tmr_cmd(hw);
>     ...
>     err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
>     ...
>     ice_ptp_exec_tmr_cmd(hw);
>     ...
>     ice_ptp_exec_tmr_cmd(hw);
> 
>     err = ice_sync_phy_timer_e82x(hw, port);
>     ...
> }
> 

This is a pre-existing issue that I think are fixed by some patches we
have on Intel Wired LAN. The E822/E823 shouldn't be issuing timer
commands without the global semaphore.

> Only the final ice_sync_phy_timer_e82x() step takes the semaphore. On
> E825, ice_start_phy_timer_eth56g() does hold it around its port command.
> 
> The single adapter lock serializes more than the old per-port lock did,
> so the patch doesn't depend on this claim. Could the justification in the
> commit message be corrected, though?
> 

I can try to clean that up...

> A related point: ice_ptp_one_port_cmd() writes P_REG_TMR_CMD on every
> port (NOP on the non-target ports). The clock owner's ice_ptp_tmr_cmd()
> paths (adjfine/adjtime/settime) also program every port's TMR_CMD, and
> they hold only the semaphore, not ps_lock. This patch did not introduce
> that possible interleaving, and the old per-port lock didn't cover it
> either. Whether it matters depends on how the hardware handles the timer
> command sync across PFs.

The semaphore is cross-PF and is supposed to block other PFs.

> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> index c61bd645e460..5cefcd7af8b3 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> @@ -41,6 +41,7 @@ struct ice_port_list {
>>   * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
>>   * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
>>   *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
>> + * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
> 
> [Severity: Low]
> This isn't a bug, but should this description cover everything the lock
> now protects? After this patch, ps_lock also guards writes to
> ice_ptp_port::link_up and the whole of ice_ptp_link_change(). That
> includes the SyncE/DPLL reconfiguration and ice_txclk_update_and_notify().
> 
> The @link_up kernel-doc in ice_ptp.h still just says "indicates whether
> the link is up". It doesn't say that writers hold adapter->ps_lock, or
> that lockless readers such as ice_ptp_process_tx_tstamp() use READ_ONCE().
> 
> Also, ice_ptp_port_phy_stop(), ice_ptp_port_phy_restart() and
> ice_ptp_restart_all_phy() all gained a Context: line. ice_ptp_link_change()
> now takes ps_lock unconditionally, but its kernel-doc has no "Context:
> acquires the adapter ps_lock" line.
> 

I can try to clean those up...

> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 55241802d17a..7a1deb3ea212 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -1309,17 +1309,14 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  	struct ice_ptp_port *ptp_port;
>>  	struct ice_hw *hw = &pf->hw;
>>  
>> -	if (pf->ptp.state != ICE_PTP_READY)
>> -		return;
>> -
>>  	ptp_port = &pf->ptp.port;
>>  
>> -	/* Update cached link status for this port immediately */
>> -	ptp_port->link_up = linkup;
>> +	mutex_lock(&pf->adapter->ps_lock);
> 
> [Severity: Medium]
> Can this dereference a freed ice_adapter during device removal? Before
> this patch, ice_ptp_link_change() returned early once ice_ptp_release()
> had moved the state away from ICE_PTP_READY, and it never touched
> pf->adapter. Now the mutex is taken before any state check.
> 
> In ice_remove(), the adapter reference is dropped before the service task
> is synchronously stopped:
> 
> ice_remove()
>     ice_unload(pf);           <- PTP torn down via ice_ptp_release()
>     ice_deinit(pf);           <- only sets ICE_SERVICE_DIS
>     ice_vsi_release_all(pf);
>     ...
>     ice_adapter_put(pdev);    <- may kfree() the adapter
>     ice_deinit_hw(&pf->hw);
>     ice_deinit_dev(pf);       <- ice_service_task_stop()->cancel_work_sync()
> 
> The ice_probe() unroll path uses the same order:
> 
> unroll_adapter:
> 	ice_adapter_put(pdev);
> unroll_hw_init:
> 	ice_deinit_hw(hw);
> 	if (need_dev_deinit)
> 		ice_deinit_dev(pf);
> 
> Suppose a service task is already in ice_link_event() and has passed the
> ice_get_main_vsi() check when removal runs through ice_adapter_put(), and
> this PF held the last adapter reference. Wouldn't the task then reach:
> 
> ice_service_task()
>   ice_clean_adminq_subtask()
>     ...
>       ice_link_event()
>         ice_ptp_link_change()
>           mutex_lock(&pf->adapter->ps_lock);
> 
> on an adapter that ice_adapter_free() has already passed to mutex_destroy()
> and kfree()?
> 
> The teardown ordering predates this patch, but the patch adds a new
> unconditional adapter access on this path.
> 

This really should be considered a pre-existing issue that we don't have
a synchronize with the service task during teardown.

> [ ... ]
> 
>> @@ -3419,14 +3414,16 @@ void ice_ptp_init(struct ice_pf *pf)
>>  	if (err)
>>  		goto err_release_tx_tracker;
>>  
>> -	/* Start the PHY timestamping block */
>> -	ice_ptp_reset_phy_timestamping(pf);
>> -
>>  	/* Configure initial Tx interrupt settings */
>>  	ice_ptp_cfg_tx_interrupt(pf);
>>  
>>  	ptp->state = ICE_PTP_READY;
>>  
>> +	/* (Re)start the PHY timestamping block */
>> +	mutex_lock(&pf->adapter->ps_lock);
>> +	ice_ptp_port_phy_restart(&ptp->port);
>> +	mutex_unlock(&pf->adapter->ps_lock);
> 
> [Severity: Low]
> Should the ICE_PTP_READY store happen under ps_lock? The link-edge
> reasoning in the commit message relies on ice_ptp_link_change() reading
> pf->ptp.state inside the ps_lock critical section. Here, though, the
> store is a plain write made before mutex_lock().
> 
> If a link event already holds ps_lock when this store happens,
> ice_ptp_link_change() can see READY through a plain load:
> 
>     if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
>         goto out_unlock;
> 
> Nothing pairs that load (no release/acquire) with the earlier
> initialization writes (pf->ptp.kworker, ov_work, the Tx tracker). It then
> goes on into ice_ptp_port_phy_restart(), which on E822 calls
> kthread_queue_delayed_work(pf->ptp.kworker, ...).
> 
> In practice the window is very small, and both outcomes described in the
> commit message are handled correctly. It is still a plain-access data
> race that KCSAN could report.
> 
> Would it make the ordering explicit to set the state to READY inside the
> ps_lock section just before the initial restart, or to use
> smp_store_release()/smp_load_acquire()?
> 

I think this needs to be something like this:

1: set the PTP state
2: synchronize with the service task

But that likely requires more work to make sure everything is right and
I would rather not overload this already loaded series :\

> [ ... ]
> 

