Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792693351;
	b=yNC4+FnKbkk2V0JvD95Y6tgrGlBNJjUuk027CZJbUO7sGU13Ej7ges1GOH7iEDytle6Q
	 2MClD3GZ4dRs1fvxInyw4n9oCMA1l/gcYNtL24kfNttnYyd7sTWprLbwkXSa8VAuIvHm/
	 lxZb0SV3xUEds7b5HQqhIWBq5b2RSE4V3S14EIdnm6cqaSSZ7rh6qhHmQxZAO0vyqYo12
	 qKW1ikBSbMN6KSzK7NJC2RHVDpgFVx2eNAappUyWen5sTplGVGDxM6yP+DdNCMXCADDYn
	 rhqBz153P7auMg+fI8dHBSsO1H/sx+urvUzZe6g/CtqDrjlg8eZuQP6Q+6OtvyZe0ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693351;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=YV55RYss7vg6RCVkBBRHIz5NMaecvfZK0uWVXFn7no8=;
	b=S/9ioRTuJxKEGHN1bjJ8lLr9f4Sp4q0et7uzsdGk4Zxlln+dRdzNbMv7IkBQGntWVcps
	 TUgL9IjS7MI6EYBFf8aYbNW73Xe7wY8r5/FmFJhaJpU04HZprgH6gko5dKq6ThVejeUZX
	 dKNumA5q18TTGitTYPVXoZ1dUZtCTegSRqBrttC/ciuU3Ym7XSf0xANEJyVf5dQPCebgA
	 cXY20PcCKZ1G94d18x3/3eWaE8eO273EKf6XlAuDe2HfgEbzvGABve2/UqLmW102pUWtK
	 lkLWAbWM6YviGN1c7zyQEj99TgOk0RqerPSa8SRGj/2FtgpI8GgJyFEIuXXMtO2TGBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UHRkvGAD;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D7606A319;
	Thu, 22 Oct 2026 18:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 397D7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UHRkvGAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792693350; x=1824229350;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1CLrz3UjJKBr4cWpJ06lZ1jG7lbEqSXhDamwGO99aCQ=;
  b=UHRkvGAD6Q0bxNNClFi7x/Ff7awXNqBysf3gJx0ZXz/TksBOsclLqfv4
   +DOJaSXZy/ehkRgcde2MpClNxe44nH+I9pN/xzOB/uB1OgX+LP138+8JU
   7YTJJ6EbJGsaLvuEK9QtFaLkcIUv2INiJM8mv+rnB88hmRM8V+o5mBltT
   9ab/GHMhi96lnumeHjjSPV9qwYxUGZECGqeDbKoAo54OCk2svFQO1iNVx
   TegvNPLv3czges7ai6mlC6Pv+Iy3Nu+BODciyVKH6+D0g2bNQnMyKesIN
   FjezVOK2QS5k3px0eQDvYShjAwPepjASBJULKEd6Ac0czmYpTicckK3pl
   g==;
X-CSE-ConnectionGUID: ynWJva5qTX2gd+ngHRyKQQ==
X-CSE-MsgGUID: mPBefF9VQjm76GTeN1ytsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1459563"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1459563"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:22:29 -0700
X-CSE-ConnectionGUID: SMRR1lMgRWODHrmUUiE2Vw==
X-CSE-MsgGUID: EdxExPa5RhyV84VmUw7d1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="5253537"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:22:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:22:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 11:22:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0sxT1v1jK33/dYrY+byOP0BS8o8tGSMsi5LGh6nCh358ekeAJGdSOaIgfj0mXxzkHfrROlTnB8NmnHjtghuwqyzBtrrqvocn9q5ROv/z8bEm1TSZyfRomD6Fsofx71pvfr509HNhR8924njwBd6HKXXGIBYH69zFBEVaWzfby5spHQXwNGSkoBcJAQD1J73qBMe5FDa/qrcAbR2qaF81nSPfFGGbuvGaHGTkwP5U0whTVifWcu7i/nwq7UeC9tA6LLS0gI7KzzU43WahmYiT3PwQCm8hNA/j1ZYv7XvcDQA+DdsyTs2rJ1XfxaEJBbZqGUy3kWtKIqZLl0MlEX+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV55RYss7vg6RCVkBBRHIz5NMaecvfZK0uWVXFn7no8=;
 b=Id9bAEgwzt/bOieLB9lJUIhZITQieUKRwNCmO/Jsspu10mmHrh7Q9zKR4O0yWkN98fQ2dAD0qhRGjarZ/vmQmGbc4u+Vd31DsUH5JhcirtfjETQQJJ9y1olHaBTnvaaaMZUdn7gXxN9mmI/fs1Mjgi1ZjDq6G7ZJ8ChAEzsJrCDax1RcfVM4IhjaeW1Kt3Yyg/gm6fFqehwgGFC0wXVsbMkf0aRhuzy6UHc/wmEjpsOjs3fvfoIaGiN3PBWer8HBbBRsl68IeyBpDZCjgoIFaKzao0o/ZyJVne9anvN4vL7qJCa/HnUci/gPFnf9XKtvObx3jJ7H55vVtW9XTUEISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 18:22:27 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:22:27 +0000
Message-ID: <d88c476e-d1cf-4769-81ba-f0e1bd2413d0@intel.com>
Date: Thu, 22 Oct 2026 11:22:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ice: quiesce PTP periodic work before system suspend
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Dan Nowlin <dan.nowlin@intel.com>, Brett Creeley
	<brett.creeley@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-6-aaron.ma@canonical.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261019105155.3793063-6-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 428bef2e-9b59-4920-599c-08df30696cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|261022105027099003|261022075727099003|56012099006|11063799006|4143699003|261021121427099003|261009223027099003|261021135927099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Swiq5zJ1+Ja6ypMzGsvXVp0iD8RHLNeZzeXkoEs6UYc05spyEs/LiCp63+rVZvSkBHWPrMSB3v/OgnMHlRuC5xLG842QKKpcR84UVgRlkR/62KPPTCumJql8/VyS3/hZ7/L/RSNt4ySe/1RN0EoWcFU4qdl5ZZ5w2hhejxgmiMjedbALxH1Gqe65N/PQHP4YJga1d9xFoQFGjE+RkuA+wgNjTVIKFSxmC67z5FZuwqaZXK8/Q2eyyW777PXrD38SLUIxiS0LKMWscKlwz69AA37P9kLhqzkbcH4iOGnCurlqty0TIxafKYMt7ndemF8ltLJal10T9vuxfNn5ZTbxhfome8KToy38eo3HBXNGk1cJ5Ruvoq8i/0wkzSCEDEO9XN29PgjYYkGMfwIqwC9ex1TSLzx9ykoAxD90e17KfTiGq65OqLEs560GRSAf0Xu4f6cyv4o7pnzBp8nFUW1ZGllMSlHQoJIIKKPE78vgkKqR8rXDjmGS0qpn3ke7aj1jw7V3O+VXrg1+AxUTGzEgELfwn9hoOMSaZhljoGjzfn/jqa8xSz3sxpxjvONkhCGq8G3phEQbqwhNNZ1Ienzf7if/FVpVs+tX3z1h+iJWRXg3AlY6Y6E2wEnppJdJbo/K5lBAtj6GZGuehkg+QCySkLqJCbSw20zMeWWbuo+1AHQvpuwWruqlZtEigpcrWegQgXrys18Khdth0GuxWLE03g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261009223027099003)(261021135927099003)(261021123027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdPMFV6Zkdoa2FQdW9VdkJMbXAyRnFnSjNyL0hBZ3FseENPMVV4eER5VFVU?=
 =?utf-8?B?aUE4SW5KQ1M2bDJialVZUXhudDF5WjJTTDNVcVFqS1dnc2FFdGdmeENaQ2Ro?=
 =?utf-8?B?YVlOaVQ5UHlXSDJvdG53cGxuUU9FaVB4R0dpWHBmNTRxMm1aL00vTTRKRWNr?=
 =?utf-8?B?SXNFZHUvcVdEd1ljQ3ljMS94Y2NaTXJISWNRWXpDRGxCV1ZZREN2QzlzclFl?=
 =?utf-8?B?SnNrNnIxdUxBbTRuQkZ1a3dZblJEV2tsdU12SHp2TCswZ2tiQm05UEVHcUNG?=
 =?utf-8?B?anU1dkEyaGtpbEcwc0ZIRk5PMlpZV3dXSzRscyt6SndoZWE3ZTNtWGlobk9H?=
 =?utf-8?B?dUVXTXk0T1lYenFDOGUwMVAwWmwzb2M0bEMxNGE4eGo4SUhWM1VmNllDT2cr?=
 =?utf-8?B?aTkxSzNsL29KT1JycTR5VlIrakpGNHZjaW1mMlRBQnFON3BGbi9MQ0VUZlNm?=
 =?utf-8?B?aGdIYTFPaEsvM3ZhdXlZMTI4aE1mTFd4N2pRWGlHTk5HajRZRDhQVlFTd1M5?=
 =?utf-8?B?RnR0Z0crejVKUDhDcWZJemNpYUx3UXhtQ1VPL0IvclpaSjhmampBZjFza1VG?=
 =?utf-8?B?c3ZYMVVWaEtNY1grNHFmMU9EOCt0M3RsZVJvMnJBVE5qaTl2aVlpQXU1Nmt5?=
 =?utf-8?B?Zk8vMzBjUjArdk0yN092QkkyM3ZaYTVrU3Y2UXRSblB6VDJoZ29zWUFhbDVS?=
 =?utf-8?B?OEpRU2pBV2p2SEw4UjVaWm5HUklQSVpCWkcvSmo1T0RMdmRYeENzaWFSOGFR?=
 =?utf-8?B?QW1TODFQNVJMcXZML0tqWUxZaThYZ1pScVBRK29tQXVtSmhmYVNGWitwV2JO?=
 =?utf-8?B?UjF6NU02bHpsVWZIQVAxeW0yZjZLbGE2Rk1qUi93YkNuMmRJeXc2ejlWTktt?=
 =?utf-8?B?Y2Iyd29aNTNkSVZFc3U2WHBGdXRWaDZNUEtjem1PQ3ZBdjZXQndITkxuTTNv?=
 =?utf-8?B?SXBxTWxZL0pWUnVWdGpzNWZieXQ1QUpKWVJWaUpleHRsY3Y3LzRSNnErNkVa?=
 =?utf-8?B?c2FFY0ZjYmY1UStvUVF5elFReHNFeGFxVHVKdVlqdENjclZhTVhrL2dNQzNt?=
 =?utf-8?B?S21sUFhoQUM5T2VMNFJ5dFZ0RjA5VUR1bWFvMEtwa0pwTFFuaGcrL3Q2c040?=
 =?utf-8?B?TFRtR3lEOWd3cUFtdXRTOHFMdXU0eWw1T3FDYnpmZFl5Z1BvVnF5V0ppTCtD?=
 =?utf-8?B?bjdPb0h5bzExSmxjL1BBNzl1TSt0VXd5OFJTb1dRY2s3SDJhNmZRL0lMZkt0?=
 =?utf-8?B?bzNLbUZVS0ZNbnc1RkN3Q25EL2xQMGZKVmRNbkhLMnZFdDc3c21qOG8xNWZv?=
 =?utf-8?B?YW16dGpaSWhGcGZCYTdGZ3RGek01dVRraWtuMWxIUnJ1b2FEdW90anJxRS9V?=
 =?utf-8?B?RXd6bGZRZk9yY0tsb1NnenF3WHBpUXB2dG5SOGh6MDE0N0RUczJHMjBhTi9Y?=
 =?utf-8?B?ZUFsYXJpZXJlbUkyQ1RFUmFLd3dxdTI0dXU4OXVoSVFlTVN1WlQrQ1N3Ylpo?=
 =?utf-8?B?TFBOejFJcXBzSG1VVVVDaFNtd1Y3dDRTRlh4a2lzZEI0QUFiS010VUVSVHVw?=
 =?utf-8?B?ODZOdFhSbm93U1ZJN2F0SFFYVEFJMVlHTStzTE9tQjE2b1lUaDFUZGRDbWZ6?=
 =?utf-8?B?dmpHTy9SMHNETHNyUzFkancySUk4L01MTzJKLzZjYkZ3cUp1b2ZXN3FKbFky?=
 =?utf-8?B?RmRHWndsaXo2c3J0WnBiTUZ3K0tRV0lFTHAxaWgxRk5YcnhabkY2czgrcGVH?=
 =?utf-8?B?NDg3Q1JSQkdOUGJKVmFXN2padG96ZEg4ejV6Wjh1OTJRdUd5SUs1cEtjTUxB?=
 =?utf-8?B?MWxzVENwMTZOTFhUcUhQZkZvTXBjRlFZUERGWjV2KzVFUmE1enpIUStFQ2xi?=
 =?utf-8?B?ZklTUFpXSjJ5MzNZSjc0dnV5cmMwYlY4bndtSmtPQjN6OWZnOU80N2lHNGRt?=
 =?utf-8?B?OVhRZHB5a1dCS1ZCMDFyOWVmZk1JU2FUdW1LUVc1MHRDYmtmemg1eHd6NDJC?=
 =?utf-8?B?R1pUNiszK0dJNHFIbGJ5RERTQVFkTWlSZ25GenhnRWM2cys0aEU3VHliY2hC?=
 =?utf-8?B?OThYazhMa0E0WXF6YmUrbHJFQXFwdDdCRnBSNEZnMXlVVU5DSUF3VjZnV2NY?=
 =?utf-8?B?cy9BMkorNGU3ZDhDR004elNxMnIzbFByS1BadTdSSGFja0EyZ1hERmdSRFBS?=
 =?utf-8?B?YXpVWXVKT3Vva0VIYjAweFd1djNHUjRSWVYyM25zTUxrQ1lhcHlNNmc0aXlP?=
 =?utf-8?B?bGxRNUdJMytwN2pHeVRFbndOblBTdy9YSjZ1QjBPSmgvMFhsWFljeVZaN3Z0?=
 =?utf-8?B?MlIrZVJ6NXJiaTgzWklOTjg3bWtkTVRUQmRJbU1nWEFyQkFtUENtYi9JTXh4?=
 =?utf-8?Q?OwFjWNWR0RkzJjgU=3D?=
X-Exchange-RoutingPolicyChecked: XtemhFi2sJFIoZb8peIIY8z+NdH+pEI6pCHLCiZnQH5xVOF8BmC8cqoXQYXxbTW+fd1LK5JgQQc4ermGKmS+YuBDcm89lHNT0RukdFgXgTvxlX0UI3mzPMABsy8J9RHScDUcdcLZTRE77yZC1FCXKGuAiz8l/autyNHbI0P05Kt4CASoxC6MiyjFDwn1xN833DH4oM7ogLUxcvSvFOTkeHH4tHWapRgYwuZgZg0DEmN+uinnfz+XYnfojFCKmdRHDwPaaTu3FqEQ9KMAWBn5V6PHAxuPIGEU1ZEDOxbuIUNkZKQD2Ma67n9IOdjcOLy/ySq6C1IHvzIOd1yrMDq1EA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 428bef2e-9b59-4920-599c-08df30696cee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:22:26.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csfLAB3+1qtzux7MfHJ99LT88vb2BtMJAhTFG/FHjOMgpuaBUh/OunGYQtD6WUOoKKGhzdsL8ratBokARy19d9Hpev94SYw8T7KdSoW+ZNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-OriginatorOrg: intel.com

On 10/19/2026 3:51 AM, Aaron Ma wrote:
> ice_suspend() stops the main service task but leaves PTP work active.
> The PTP kworker is not freezable, so it can continue issuing MMIO
> accesses after the PCI function has entered D3hot. Both the periodic
> work updating the cached PHC time and the E822 offset calibration work,
> which reschedules itself while calibration is pending, are affected.
> 
> Synchronously cancel both works when PTP is ready, after disabling the
> VSIs and before shutting down the control queues.
> 
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Fixes: a69f1cb62aec ("ice: exit bypass mode once hardware finishes timestamp calibration")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index ddebb28b2454f..3962910759067 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5450,6 +5450,12 @@ static void ice_prepare_for_shutdown(struct ice_pf *pf)
>  	/* disable the VSIs and their queues that are not already DOWN */
>  	ice_pf_dis_all_vsi(pf, false);
>  
> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
> +	    pf->ptp.state == ICE_PTP_READY) {
> +		kthread_cancel_delayed_work_sync(&pf->ptp.work);
> +		kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
> +	}
> +
>  	ice_for_each_vsi(pf, v)
>  		if (pf->vsi[v])
>  			pf->vsi[v]->vsi_num = 0;

I don't think kthread has the same API as workers to fully disable
re-queueing, but at least the periodic work is only requeueud within its
own run or by rebuild flows. ov_work I am not fully sure about, I guess
it depends on if this can race with another thread that would
re-schedule. I believe the PTP teardown also cancel the tasks but may
happen later than needed? But maybe we lack a PTP flow for
prepare_for_shutdown. Hmm.

This is at least better than what we do now so:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
