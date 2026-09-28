Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588B3815DF;
	Mon, 28 Sep 2026 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790637884; cv=fail; b=MsEYZyeAxPOoxlxcDTbk3zlk3yKFNT82mhkyVPCUyrJlel9fejjMY3mexUvKVwaBOZaDYeHkEb/BZ83nJND8SgwDAD2UdXSMlFiY1ukEW0GARTKpyB3JgXLHfoXo5I27hnZezeDs+x6N7dLe6EtXUjBRMOAmWt8fzcE9RNHLu9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790637884; c=relaxed/simple;
	bh=9jZrFaw301dIXIxB/n4ee8g3yqbvkGlqcsWoYuNovd8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DloszTYJjgANg+QLZQmupy4K8qGSIrKk5s7anfAFFZVhZpqGYbhnl1/8O+ri2BiGpfYcABKl3vhrMNLgbHrujcY2IJsygmaHydAD2Vqa+3fFxnrw2Ims5HmfYbUmeaM3W+NbCl7u83jaYTNZMLrT3ZGpfde6F04npMIohgvDzLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmIlyWSK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmIlyWSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790637881; x=1822173881;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9jZrFaw301dIXIxB/n4ee8g3yqbvkGlqcsWoYuNovd8=;
  b=VmIlyWSKyUalJdUVvCHpSAievey8/UN6DibniPYEfIXKQXRp1S9wg5VR
   EuvXTWo6dxDE0E7uW6gnvBXJfta1tXQ7VaXI0f8uPX7E9xOAOrRM8PJ+1
   HRHTBd3gkqv65IjzNz096Y1foaM1qrcITlM/AWswrTwFAVezhL9gPVshA
   bSc4KkCRuTaRWI82slvZGmXV2vArVjv5DapaopDChtknGW8QNGz5DsTi0
   ody233SuO1j34pbTaoM1hLrsNyTHGcxcN0ADo22++ZvVws/sgxf8R5BH+
   Y1TpHXkFV/9w/u6kqOPdHoKm5GjOMjl392AaZQ+X6/o59VROb9RLfPXGT
   Q==;
X-CSE-ConnectionGUID: IzN/nq5WSbONEARsn1aICw==
X-CSE-MsgGUID: ZseLg02oTZmPqPMlCAfXZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116876458"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="116876458"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:24:40 -0700
X-CSE-ConnectionGUID: CHLmBd52Qeed4g0Vg+gW6w==
X-CSE-MsgGUID: rzMt5wEuTwyzImgOo+MO2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="279000870"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:24:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:24:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 16:24:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqFhtI/pOp+6HILkYmvW9uNKmNnc8FoZTKb4w+H/RFde+CIxZkD2jH3TE53Ro5kf5Otv+8s3DKYQ/jYHiYEZ/DHmFAk3pHqJ0FmPF+mEAwa015uJHBYiawahVOKUx7OThITNX13s0IAkwg9IdmL5oeTfdS6/uJgc3jG3Tp/hGGugFe1EFw2CE+/uhfR0pVgXJ7FQ2CMdyG1b359zoxO1zdPRhuB+Wxe1WexMT6PhsWYCqaTcm6dCJ1T9OsZLQ2owrBKSi0Ry9qKZP/S1xsD8dLCgvLyFNmoXaFAVDZeUQbBhD8eInV/6jQ6CdX3M35t0qpLHsRUjF1AUSCi3+ZOFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASpyYirUntB1kq6jyKPSkBcHLAd401g7QPva+MZOJlA=;
 b=b2EDpsA5ds6bPAlBhQykBRgQ8hZUFax08Aa55GXR1ky2hmC0wfpZkkqszsSwFrGCJYZIAXABa9kAw/gfpflUw7gR9zKhDGolKOICBFEnHe1Jo2XkS5yK2zsN1X8pgh+RkRmPu0HIchytFpGc2zEoitdJ/jGegsGNUNrh6+jYhus/m3iNZCg46tZOqM2Je0QsFyWyDck/TUseSfN3LHOas7zEQXt5lypWr10o6e/1QJRZkDhhpD7PN5EIu1l/wWmP5ZIckmcS52cpt+zTu/bZXXBTqnUP9NFxzI/6r/9ia3HQrkgj9eB/z0O7v3An/QDI5rFhYQE9Ey56+bb1GnS8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB8258.namprd11.prod.outlook.com (2603:10b6:510:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 23:24:34 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 23:24:34 +0000
Message-ID: <9fba1949-d67f-46b6-a13b-09e8087b9be7@intel.com>
Date: Mon, 28 Sep 2026 16:24:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
To: Sagi Maimon <maimon.sagi@gmail.com>, <netdev@vger.kernel.org>
CC: <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<daniel@iogearbox.net>
References: <20260927081034.350422-1-maimon.sagi@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260927081034.350422-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8171d1ec-1303-4484-f7ea-08df1db7a794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SGH5UpUd1CeQXsK5PppXly7rBflpHwnAbjC2N6h/up1eEm2DCPMfZkNAex5ZwoqDiSbkFvbaEIGNr6J2QDDQpXkXm7bmicJQ7E76HJeWUY/wltqh4dMJ5VUKvjAmKM1Zr2G9iCAvduQdI8UEoU3cRFQJCR47l3AuI2cx9J/j/8aOG55lf4Y5iboEyMtGfAuJMYYlJXQSwD4C3VLogn8Ih5/4uDFgUAce0OIkInfxMICZ0AQhmonuT4dEIKOyc6E0D0py8AAZDgbYHxGzwS8+McWnTYHDbQlEKkjIWk4QSN63QhVNnYO12xv7zkPXTmw27ij8u28iFE/A14Sz1uxe1mE4DW1QwG2er8sI2UiyF+VC0oLn2TCfdneWqZSsFAQhfpmynPUP/H6oq4qrf9hGx2LLFkp3sz7HHRMH7fkxUf80kr/ETF960zB5azoTYRs/+6Izl6+sq3tOxEGO/PokYiGtvvyMeQ101uzslyA3+pu5lFJF31XT/hjSo/bxhcQwGD3SOmVPDNlt8N3NQxZFtnsfN0pqkkvGhKGDpNvguwmXWAJRp8N+QcmN1RS/0s/CSDeBy5Q3GnsZvUbyb4DW9XeuRNVs+elmisi9YNYAjx8oaDwOsS89+DPftJDxnb6kmj4Put1u7o4JlpIZZdcV9xmS2sWVsAnqTOzbersEsg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFoSjdRNGZ1L01LTjRvZVZTYnh5MEFXaHZhQTdxWjAyR3VHVXRaT3JYSmZ1?=
 =?utf-8?B?K2Y3MEJaL2RIdU9GL3pGazhDLzhpWCtBc2pldW95Y0Y2LzA2a0tOKy94RkJq?=
 =?utf-8?B?ZUMzR3l5OXFmVjhFVEdMNFhpYUx2Wko0S0Q5WlBTcTZ4T3BqOFkrZ1pQK0E5?=
 =?utf-8?B?RnNoMnhXdk4ybWd6YXdSQXJjblRoMGhWbFZrcmY0cnZWMlU3TzVvYkhPcGFI?=
 =?utf-8?B?SWtHc1NWckhSVHAwcjE5RmF5RHFnRjErVGZuNmJOQ21XUzFSOWQ2SDNXSDBr?=
 =?utf-8?B?U1lIT3FtRjQ4RU52RE9FMktoeSsva3pXWTQxWTRrdU0zMFhtcU92MmpGOHkv?=
 =?utf-8?B?Z0psVHlHWVpxY1J2LzZNbk4yZTVLdEQ3Umw5L2doY0FkUlArdDZBMEpudVIv?=
 =?utf-8?B?SEwzSk4yL1JBaXAyTHVkMk93WndKN1ljRDRsUnZFOHJkajM4UWIrRTRsY05W?=
 =?utf-8?B?L2R2VVk0a2RFRkV2WW11L0lEb2FjUWdMRTUyaTl2R1pZd2h3UkxFcmZvZEsv?=
 =?utf-8?B?VUUyd1FVTXQ4QkxwTU15R1p6bkpGOFg5YTlFN1pvSisxZWtJdWRxVWFsbXpp?=
 =?utf-8?B?alBERWZzcm9xbGpPZkxSVDJPem9wZ0dQSGdTVGpMYjRELzk2dE1URTg5aEJN?=
 =?utf-8?B?RldTRjBJU0Z5Ny8yNnN6bjBRZGw0Q0xLTmlkeVFjNnFuRmh3VnI2eEdmS0VR?=
 =?utf-8?B?dDJ5K2k1QzN0OFB3dUNGQmhTNlY0UlQ1WDV0cWtscS9uaXB4RzFwNFFuS0t1?=
 =?utf-8?B?T3NhUTZrcjQ4QlVieVJoQ29sOU11TzJmanF2WG1Ba3ZkS013OVordlZZWGFO?=
 =?utf-8?B?UG5UdVRUUm1WTkRUNUVJN1dPdDRVWUtVZFpCU0toMmZNbmVFeStneTdhbTRq?=
 =?utf-8?B?TFE2Nms2aUdiaUNpYTRnWXhxMGN3ZXdOaVNsR042Q2ZjeFB0UFJSNmlXSnhi?=
 =?utf-8?B?VkIzc3lIMWk1YzJySVNCcFhvNFRtdW9adEJXOTc0VnBCMnhWWmN1M2NCUFVY?=
 =?utf-8?B?TGVIVUxtZXZaZ1Vna3dIWDB2ZHRTOW5sOHFGSnVaMVROUm1zTVFEaVFHbjZh?=
 =?utf-8?B?WE02NHQwRzYrV3A2SWdtZVYrQ3ZjOGdtQ2duTFFvQllKcnRGRG1LZnlOZjBi?=
 =?utf-8?B?UFR1dU9pbEJTZzVXOEVpakNDS1dla1hHRVVibVR6STNWSzh6MGx6cWF2bUJo?=
 =?utf-8?B?OU9UMGdTS2krUFFRSEdIaFNYQVlPenpMRUJXK09TOE5zbDhTUE9jaFk0ZklK?=
 =?utf-8?B?MHB3bXNVaFhTb29UaXR1UCt1SUV2SG9hQW5BV2kyZTB1S2pVME5YcTlLNi9U?=
 =?utf-8?B?d0dUcUZ1dU0xKzlZRHYzMU42cHVHL3hTRW1jRjRrNFM0VWVqb1pUQ2pSR24w?=
 =?utf-8?B?Vkp2V1ptanlZZkdqRDFSYUUxeDVNMGpCNXZzME0rSlNlVHB6d1Z3a3Ztbk5t?=
 =?utf-8?B?Wlg4YmszWkZkU2tJSmhMRTZINWhQTys1ZVI0Zk5nalJDZ0RoL0dPWTR4eUQx?=
 =?utf-8?B?dno4OUlUTlhyKzJmS3ZBV3pZZi9MN0ZxRUYxaHVqTndHbWd4ZW1NWnFxVlh4?=
 =?utf-8?B?SGg3V3p5Tzc2bWZTZFRzeldwSUxLRWpRSm9tdTU0cGhzeXpTekFpa1djZkVo?=
 =?utf-8?B?RGJEQ0ZPVGFyeXM4ek01bTJ6UE1KajRkTERMZnlqcUprYmRwa1dTckhGM2VW?=
 =?utf-8?B?RmFsMXByeXN4WGFzQ1pVbGh0ZGJ1STczem9Ndkc3R3kxcUR3SEhpaXdWSGdK?=
 =?utf-8?B?YlJrWEFPaWYwWDJqYWdHTnoya2cwUkRLNVJnc2VITXJlVHcvcHZJOHFrcUdt?=
 =?utf-8?B?R3ZCSFRrNDJtWWE2TEtudWlxUDM0ZndPb3gxTnZZMktBQ0tJeGp1NVh3KzZ5?=
 =?utf-8?B?aGFVOEVUZ0U0clZqWWRiQm9FcE80TVdONjRreXkzSlFBTWxtellYZHMrOFZ5?=
 =?utf-8?B?SXNGV0JRdDl1S0dabHlyUi9ReU1aUHlQem82TjVJRWw0Uk9jSk1yYlRNMUlW?=
 =?utf-8?B?ZXh4VENJd2JuN1gvaFZYdGFqY0dzd2tsaUlEZVhuaVlPQWJlVVdZZkZZd2dh?=
 =?utf-8?B?VnFuOFdrVFlONUMwejlBM1d2MGpMZ0NYOWg0SFFwU1pOQWVaemxpclBrTm5q?=
 =?utf-8?B?ZVRaZmMrc0xJMnhNalkvK1RVZlowNDRpL0dBZWE1bFFrdkUzb1pIL2tEalZG?=
 =?utf-8?B?eXJHaDJSek03ait2QThKalZVTjhhTjMrK0FsTmtJVlVMc2ZGQXh2eFJpNk03?=
 =?utf-8?B?cjg3cXdyK1N1UTZIdnM3eitwSlhMblBzbW00TlR1eDR5d3BPbm9PdGhDWjNF?=
 =?utf-8?B?ZkE3dXlDUHFFazdya1dDTllJZXc0Y1FqNFNYYWdtZGJLYlpybnBoUT09?=
X-Exchange-RoutingPolicyChecked: 0JoMz7Ub0MCljzbgCq4ucT4rNA6+z/hecUu2YNV0XjUjv5PFfe+RWc8MiHUyhEaHl1PSyTj8ySoqmiIXfDjWvpDQdPyS66G+KdQoiYDEwRx/7BlePF4SI3te9wx6TDI+nIcggJlQMmPnC7fIT+7AQsYNgUm7kVqDf9vFH3YrUZZwQjgBbjPFh8UX86VOG7ftILJVrfs9CDBA067g2DkdiE/C74kHZ+rkHEkIg9o4yCeVMqffPWSiSFUfUP+TvBdWS700yJPhnpajOgp11Gfw9U9McPRLm+Z3rK+cDIsxv2bEmB2IVr6NjRZJ1axnJiYVq2jhJGXhB7X+9Uik8lQHSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8171d1ec-1303-4484-f7ea-08df1db7a794
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 23:24:34.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIDUuSzazVkWJZVwM6HRM54jGv15sCwcLSG3ezNa8MnT1Xnn78wID3+ctN6ub0TJ0vz6dARtazeMPUfqs91qKzKp90XcDIjnfanq3gwUFCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8258
X-OriginatorOrg: intel.com

On 9/27/2026 1:10 AM, Sagi Maimon wrote:
> axienet_dma_bd_release() walks the RX ring to unmap and free every
> receive buffer before releasing it, but frees the TX descriptor ring
> with dma_free_coherent() alone.  Any descriptor that
> axienet_free_tx_chain() had not yet reclaimed still holds its skb and
> its streaming DMA mapping, and both are lost.
> 
> axienet_stop() disables TX NAPI and stops the DMA engine before calling
> it, so nothing reclaims those descriptors afterwards.  Bringing the
> interface down while frames are in flight therefore leaks up to
> lp->tx_bd_num skbs and mappings each time.
> 
> Walk the TX ring the way axienet_dma_err_handler() already does: unmap
> every descriptor whose cntrl is still set - axienet_free_tx_chain()
> clears it on reclaim - and free any skb still attached.  The DMA engine
> has been stopped by then, so the hardware no longer references the
> buffers.  On the axienet_dma_bd_init() error path the TX ring has just
> been allocated zeroed, so the walk does nothing.
> 
> This was reported by the Sashiko AI review bot.
> 
> Tested on an AXI Ethernet MAC behind a PCIe endpoint: traffic passes,
> and after each of ten down/up cycles and five module reloads, all made
> with traffic running and each running axienet_dma_bd_release(), traffic
> resumes and nothing is logged.  The leak itself was not measured.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Assisted-by: LLM sparse
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> 
> Notes:
>     Found by the Sashiko review of v2 of "net: axienet: bound TX completion
>     cleanup by the NAPI budget":
>     https://lore.kernel.org/netdev/20260917115657.20697-1-maimon.sagi@gmail.com/
>     It is independent of that patch and applies on its own.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/xilinx/xilinx_axienet_main.c  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f34..02bcb89d1bbe 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -187,6 +187,24 @@ static void axienet_dma_bd_release(struct net_device *ndev)
>  	struct axienet_local *lp = netdev_priv(ndev);
>  
>  	/* If we end up here, tx_bd_v must have been DMA allocated. */
> +	for (i = 0; i < lp->tx_bd_num; i++) {
> +		struct axidma_bd *cur_p = &lp->tx_bd_v[i];
> +
> +		/* axienet_free_tx_chain() clears cntrl when it reclaims a
> +		 * descriptor, so a non-zero value means the mapping is live.
> +		 */
> +		if (cur_p->cntrl) {
> +			dma_addr_t addr = desc_get_phys_addr(lp, cur_p);
> +
> +			dma_unmap_single(lp->dev, addr,
> +					 (cur_p->cntrl &
> +					  XAXIDMA_BD_CTRL_LENGTH_MASK),
> +					 DMA_TO_DEVICE);
> +		}
> +		if (cur_p->skb)
> +			dev_kfree_skb(cur_p->skb);
> +	}
> +
>  	dma_free_coherent(lp->dev,
>  			  sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
>  			  lp->tx_bd_v,
> 
> base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7

