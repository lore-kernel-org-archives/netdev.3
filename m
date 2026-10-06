Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D592BE051;
	Tue,  6 Oct 2026 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322488; cv=fail; b=Ajc/2B9rozXwxuTGTyU+BF1BjILZ4in9mXQkOI3K0Rw4/dnsXpqXva4z4xnhLdiOX0Snh/rJ23lP/NOYkQ/WEka33KRcCiKBuJuSaS/TvyvyGLpOsy0Empq9i+a0OS2f7dZsteppkqIqDpGczhwJn39Cvwdu7NLkd81P6qCl9mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322488; c=relaxed/simple;
	bh=cOaMo4mSEcl2kQpoEdeIsQ29Qhm/qX2A+uocmfS2P0Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFqBMcVq0zgmbkQpHVmPmow1uU975w2jWYgSd7nTk5s3AHAFuBUkOMGDBpjO510EQCwhHjHU5ydi9d8PaOxgCJiI/YTskf9/ktX9q2LSjH8dp7rHyp0/pp2tGersluw+n1rJfOT+uFBuJg7AHkWRcamlvL5sHCWKvLUlbMlXuRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KICL3oz/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KICL3oz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791322487; x=1822858487;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cOaMo4mSEcl2kQpoEdeIsQ29Qhm/qX2A+uocmfS2P0Q=;
  b=KICL3oz/nxP8tvsnuEk58anpJTC+jbgoLSU+ZzcNWfkQfqhoAnhfve/B
   7MM6ylbIKjpFHyRN9SSskrtCkp3Q2k3h/SaznpN9v7U7Vm0GJiHGD72rP
   oIhccnat7o75+BHIFpX2bBzao7nJ8YDBJMN+IV+namcKqkxj55lBWGYET
   uLoYXa3TlcS8KzZMiHkiVTbmMgLOhMPfeNqUBSRbq6zaCwPhK2Pv3/ICF
   3xMR3FEX37tORuxMnHAOOZGUF8b3v73sUhNhP5GVaUDMg/hRs6+cJ92a1
   S/6ybGDi+aLs1bddNfx3Rzi2fj/au+cCGnIRtfRVsUH0rvMbTLx1FJg/u
   A==;
X-CSE-ConnectionGUID: J12StmKPTySrfh8Rvd/dMQ==
X-CSE-MsgGUID: UKHrWs86R7ClRPGflw0Btg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="65331"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="65331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:34:46 -0700
X-CSE-ConnectionGUID: +agE2GRJTsqOY3W6ggXMOg==
X-CSE-MsgGUID: cwFR+lIYQpadCSm/LDUojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="303544784"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:34:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:34:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 14:34:45 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNGBCat4GNBUCF6/gS39i1y52Rg7tv9J4QEKtR3E/TyQ6tDxu+7x/JZ4tmc7td/c8xfhHhwjMt9GGHlSaZGnX4QiO+0VLVoQ1U36LSnWRcM8SN+xtpK397mERrjCEfst39ZSgm+St4LRx1ANNDbJgaNbONkIboKGmqDpBprwrn3tpA9GD6E8zWCZdRN6YtbsCtamUTgAfwdZKqjVcMZ25sVIDIvnOHy2Cj39g4Ws0PLd/KgUuDrMvcstdLI/v7isteoiEY7/KF4qHLEPQXYGXIwDUYbnPWgvbLYwg2eDTR+rHRWcRVkn8zJtskYMK+U9UdyG1MqC5N1Og4gWFB7ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h225xOoe0+etiJvY5TxcH0zYTPtsBd+PzB9bD5cG6TE=;
 b=kQLIykS1Qz1MHi7KlMDzzpztty5lyY/GQ5QOp95UkdZlBjX1sbBU0kBNOsLs2rtbev2xYpPHkIGklqjfwQQzFWcVM4iRy28QOqo7IweL254UYouWKMPt0HGehaT/cqaML7lCtLbPGp7vDYQyrRgdRY9B1LRIlLxSK4o/38cAFsGuID5k/2b87XmDORHjkXNAnz0EoJbkr/AuJxfEoi463Uj2T6ywwMA3Mik3uukBrWvSPO7ArfQRmxnSk/gNLX2t4c8MatZf4d/aessLC8QQ+XOZdbdBNWgO/i5iZuJu4JW/uapYyN4R5rH/51OiBw2q/Qu6qlavm48DF7j9U8raPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA3PR11MB186312.namprd11.prod.outlook.com (2603:10b6:806:595::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 21:34:42 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 21:34:42 +0000
Message-ID: <731504ae-0091-42b8-ba17-13779c14bccf@intel.com>
Date: Tue, 6 Oct 2026 14:34:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net RESEND v2] net: macb: configure ENST registers for all
 queues
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>, <git@amd.com>,
	=?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Conor Dooley
	<conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261005110855.1669249-1-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261005110855.1669249-1-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA3PR11MB186312:EE_
X-MS-Office365-Filtering-Correlation-Id: 7715f472-cc16-491b-eaf1-08df23f1a205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|22082099003|921020|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mRQwFigzJvKy0CR7DdgWuZh+haRX30lV4Z7TWQdSDJXkswPVvlWBYSQ3g8Xp22UxW3JFEgD23TVx2TZTREC7o7Td3244qO9IPz8denkk1lXn9BaJ1fRJoRY57O7RovBdo2srM7bm1aBfQMleWgtggVoNobiEx8pDf6mGQfBZLRdMlqtkthrXvPzsHp/XyM/0dGwq1PpXcjTC2V7hPJeTIAMPh/XlNiFKy2fc7GJkHclsu2aOGImJo3Q7OlV1b3X7KoySzbi9ejmLqw8bqNd0S3HABghm51uZotzSJu6wJtr7/ObrReRXTlnA85mcPJFFAjFMV5G66RTy14A66w3SeRbNVS8l+Irym+yUIMD8IEMSGLrfxbOzzgzZJfDzoA/7EJ/iE+HBoV8/kWJgMgTZ3wxllJjh6c6eu1ElJb+E+W55lS72U4A9Wj8A7xShJvFGIym35ioifz+G05KoS9bqpdKVNuhsQaKSe3M710jTnMOgW9RxN6QfH7+J3M9BjlU2L9CfFW8vfMoYiPAXmXEwqF7iyBdG+uQwTGGEMQxDBe/fiuwB++WaTa9Y5eGAwfw0OSMwN9+sTn6iwBlr6hA3WJ+wB8bgru8OSESxobUBO0fOqqMc7LcjnvIDFxEc4r4F/5FQppGCloMmykfNa8amJIrCVGLTyLA3QPcJ3inkTSD9VJ2C7Z0324rg/O/7Mznt31jHrj8mqNEpUBIPfqjgew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(22082099003)(921020)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZ0d3dYUVZ2eVo4dGJ3cm5Vek94dTluclVPZ2lwTVlqQVJlY3ZhRkgzNGFx?=
 =?utf-8?B?UUxGZVBBcm9aYWVjb2xoem03TnVJVlhNN3N5Q2REcTVZUDZhMVljdkdXMWJj?=
 =?utf-8?B?WFU4dXF4a1Z1MEZ6K0p3eTdXQS9DTDNxNXlDanFHNEpBZStIMUkvRm5KUnJm?=
 =?utf-8?B?ZGdFS2JmMmh1czhEbHJIMjArNzl2QlVER1JtZ2VtdE15RHBhN1NkSlZuL1l4?=
 =?utf-8?B?K0pwdllNLzM4cTFhM05NNWFBeG5idGJsdVRURnNVaG5RQmdHSHV6NDBxZi9P?=
 =?utf-8?B?b1pDdWZEOVFOa3hjdmd2RTVnckhnK0lteG8wS0M0TG9GaHJYS25RRzVWWGRT?=
 =?utf-8?B?cEY0a2NVQnI4di8wQ2llSzkzREwvTTkzL0VBaTVBUVpQTTB4ODFqZFFhc2sr?=
 =?utf-8?B?VFZYaHdiOUorTVRXRi9pR3RIZDk1Y1R1Q1VXN0dRdzVramIzd0grVTVmczJW?=
 =?utf-8?B?bkJpMW1aSkhYUEp3eFFubWxSNVVqK1pQck5MVmtvdDBxNDRPcGE5M2c3S1pE?=
 =?utf-8?B?VDZxNW51OUVmZWVub1pUNTNIOEExZjUrMzBYb0lERWJwZ1dFR0JXR1F2YUg2?=
 =?utf-8?B?dlRPd2cyL0syMmpVcWJIN3M1d21PMlRCS1Ryd1Z2bGI4RWJPOW1ZdHVMY1hi?=
 =?utf-8?B?MDNMQWMzNnZuTUVtTXRtR29OZUJWQ3UyLzM2di9yNTJTa3dMMjMyeWZyaFJ5?=
 =?utf-8?B?UGpWYVlxNzJTTFFBOGxkZ1NISjlzK2VsTm5LWi9zTmlzeUlpMG5wc2JTUDJM?=
 =?utf-8?B?MGdwU0pCbjJZbUFxRWhMekdpRjlTMXFaLzRmK1BtZkpuV3ByYjA1MkIwKy92?=
 =?utf-8?B?WER5a3FzY0lJdkNVZTRHZWJQWkdqVllyMXVadTRxaUMzK3pINmJUK0FWdUhi?=
 =?utf-8?B?Z3VoZ00vcEFraXVjcDZUN3FXYytOTG00Z29Rc1RPb29NcFZoUEZFSFRTM1VF?=
 =?utf-8?B?ZzU0UnlBU1J5M1F5V0hReC9sSEJTRmFXbk5DMk54WHZEQUV3a0hEUG5ESkNW?=
 =?utf-8?B?WVhoMlkwNkJ6UW13b0JIbW1RbkVBMk1TRFVMbnJGNlFEdG1Wem1OaW9YL1JM?=
 =?utf-8?B?bnBuTGZkcklHRWlERnhoRDNlbSs2UW9ITTdCRHFKd1FUOHRXcDBOcjQwbm1k?=
 =?utf-8?B?VlBRR28zUGI2S1JJSVUwMHZZQzExcWxycGlZQ3FYOEhQd2lETitlclRaUVNE?=
 =?utf-8?B?aWV6clM1UXNDcDdWQktRbzZNMitLZFRNNmE4Q3dGczhHeVZKVi9NV3dHaFZr?=
 =?utf-8?B?YllNS2xBUXFRNEltVUR5NVBqNTV5L0JSZ2hpZFZSQjA2UmtCMVkvQVBJM2Yw?=
 =?utf-8?B?cmVsVnVwWDB0UVQya0JRb3BjcmRnTXEveDVIZks3RW5vVlY5aVpqelpmcVho?=
 =?utf-8?B?ZjAvVS9aOFFvcnN5enhMTkRHOG5EM2EyRzVHRjErd2ljNDB3bE5NdWlYeVgw?=
 =?utf-8?B?OHBYd1NIM2RsOE1rY1dOa0JuWjhKMi9QbHJ4dGwwRFBOSHJHZUUvSUUramhq?=
 =?utf-8?B?ZHBZcGdsOU9vYzB6SUh2REN5MW5WZE1qVFlnTHRKLzV0WnJ4WExTcFIxbEw1?=
 =?utf-8?B?WEJGMm04a2F1S2VJMlRBS3BFRTZlYTdVZXRDcld1S2orZUkyQ1NUTkU3cEp1?=
 =?utf-8?B?QmZZOVV5TE9WOHdyT1dBZlkwTlBaZWVEdTIwRHJMTlpydmxFVmdLZ2JrNk8z?=
 =?utf-8?B?TmpiTndHajdmT0JNb1pIc3B4STRDVFVXcklOdjNPbEtPYjNsVkJxUHdXUldM?=
 =?utf-8?B?VTFSMzJ5WG5aUWl2TFlsMlE4UHF2RmcxcldieEJGT0VRVDJlRFJzdEhCV0J6?=
 =?utf-8?B?L1lJQWg0QXFYMmhjaWFnVUkwb1lhNDJyYTBlcGM5Nk1Nd2JJVHFtUDlDUDgy?=
 =?utf-8?B?Z0dPdnN3cjNQbWFnSmVLdGR2ZXhQRlJINWo3K01lOUtGNkVQazdaSFBrekYy?=
 =?utf-8?B?WGc1ZmlUWk9jeS8yMk5wQXNvWExlUlJkbGJMcFJucmkxbnQyemlKZnNSdlZh?=
 =?utf-8?B?OTdhaGQvclZPVFhkNkxpWjUxa1NYRlFCbnkxT2hFVTJaR2RtK1daQW44UERu?=
 =?utf-8?B?eDhVbEVPK0ora1U1OFpVcHUxQnErVDF6L2ppaUVwY2cvZk9JK0R6Y3d3UlJs?=
 =?utf-8?B?ZEpYYWg1NU40NG9wSEc0Y2FjZ3NZemJHMUVqS2hJYm1rRDF2cEhteGJwN2Y1?=
 =?utf-8?B?cmJnUFhuZzV3RGhacEVaRUZocjA0anlPT1pWOE5wZW9DYlR1Ym9EeHl5RDVQ?=
 =?utf-8?B?cURiYkh3RDIzdHdBSmFTdlV0ZFV1RnhBTWRTSEpkVnRxaUNTYnJZSkd0UEFy?=
 =?utf-8?B?VHZZeUNnTGtjRjdxNEQwaTI4NjBaSjFOYUROM2cyRnV2ZHJZK29RY29wdzRa?=
 =?utf-8?Q?h526FwZBv2l77wnY=3D?=
X-Exchange-RoutingPolicyChecked: srjjeD2+fTTF9ZFtUBpoStkF2oCkuMnIPS6s3zwhuiUhimluGaJDmT2Rv/PNo5ZQ7ipM8eP5V42c8NduJfFKtrUj75Rt0lrnyGiwPpD6YE96+6rv892MkSydAdYg96bh7zewJ2FVmnlh963hmB7NTaapSofAFHSN/Cr8ErwD60LnIvq7K62tG/PiLTb27IxagBkNmN7APUhvSYHD/ZuAGS9i/eW6EAjML5nwMLiC3sELi029pR8gHyp1x+UcOUETo7iSu9i4BkjPOqg5L8udSliP6bCy7e4S/ymHoJcaH3X2ETI1Ro4/rk9TMHLPxYYSCtjoNGK1PIKs9iUMaLXCig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7715f472-cc16-491b-eaf1-08df23f1a205
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:34:42.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySXrl1qCTKi6TTZFqEYukMhk9I1ghREGz1W2V4ZDgU1/XLL9IldUhY7YfZqQbVad7ZFlXxZZx/aut6QrX0AMEMxnf/rbgjjHP7QP+8s6qRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB186312
X-OriginatorOrg: intel.com

On 10/5/2026 4:08 AM, Vineeth Karumanchi wrote:
> When a taprio config only covered a subset of queues, the driver
> programmed the ENST registers only for the queues named in the config
> and left the remaining queues holding stale register values. This
> produced an inconsistent hardware setup that affected the scheduling
> of the configured queues.
> 
> This was observed on a GEM instance with four hardware queues, all
> enabled:
> 
> Initial configuration:
> - All four queues are enabled.
> - enst_on_time_qX registers are left at their reset value (0x0001FFFF).
> - Only q0 and q1 are configured with valid, non-overlapping ENST
>   schedules (T0 and T1 respectively).
> - Traffic streams p0 and p1 are bound to q0 and q1.
> - ENST is enabled only on q0 and q1.
> 
> Observed behavior:
> - During T0 on-time, both p0 and p1 packets are transmitted.
> - During T1 on-time, both p0 and p1 packets are transmitted.
> 
> With the unused queues (q2 and q3) explicitly programmed with
> enst_on_time = 0x0:
> - During T0 on-time, only p0 packets are transmitted.
> - During T1 on-time, only p1 packets are transmitted.
> 
> Leaving the ENST on-time registers of unused queues at their reset
> value (0x0001FFFF) disrupts the scheduling of the configured queues,
> whereas programming them with 0x0 yields the expected ENST operation.
> 
> Program the ENST registers for every queue unconditionally. The
> per-queue configuration array is now allocated for bp->num_queues and
> indexed directly by queue_id; unconfigured queues are left
> zero-initialized by kzalloc_objs(), so their registers are cleared.
> Indexing the array by queue_id also makes the queue_id field in
> struct macb_queue_enst_config redundant, so drop it.
> 
> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
