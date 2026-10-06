Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75623CC32E;
	Tue,  6 Oct 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319300; cv=fail; b=VCCKxkdh2jTCy1pXG2WwzSydGi6qBEFQWox7kzV0q3sy2Avbo1TjMdsSV7plHU6Mjrc6ddXhlH07VFb856037t/45pA4/hVoPKS9OKt0Gji3CV58q1fB9zrkH3HYlt69DZv/pI/AC/PLtB1g5NmAhU/kiqYOpVVF2laIcRSSWH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319300; c=relaxed/simple;
	bh=t/LEkTeO2n1Uic4N3jydpKqlJYENq0ltENAdnC33o9g=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c0esHrH7EuWChKMijHWkd5qOgVqO363R65aEzfd9l7TI4hk0aoczaS2coITqsjAiioYowqoFEwx69175lIqMMPUktRmMbl5BmEzGhnCUjApiednO//71sHTjHQsqn+6EfsuG67m00O/bUVT8g4pCUJrrD9duIUlZB/5O8J8yDXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=lzf3hldI; arc=fail smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="lzf3hldI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3722; q=dns/txt;
  s=iport01; t=1791319299; x=1792528899;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qpfHyM7JbIyFbzOmFwhyZaJiq928Br+Fs8XJ7sud/A8=;
  b=lzf3hldIXr846IF8+vadE8Wv9YWPQursxjLzgmgx8GhzLTCMRR7RI0VK
   JWYCAWVCGSvQonkNYi9sZ56pWuilgoaDgLhvQcHBgGVBJal2DYTs5lN/M
   SoIVeI29Bsp3Dv8zxCKuk/6GH5LZN3Hax+ROf/+t37SeMDIylI8Wunoqo
   EEjK9M/Vd8sJQUSMt0a0rvkLCu3qRMgcrxPSao4ZhfsHinCX5C9KXVarB
   Lt/p/Rmsegy0ELix4yXU2ESKxMZFWp/wpB/zGSmgH2n7Cl3ZRvKfXxz1Y
   CnceLuch9x+txEG+YVDabqvM2ltKJ/jLqaAXoVGyw0qF+5pPh6PP8bNEU
   w==;
X-CSE-ConnectionGUID: hWPta2pDRBS1Hiqsl+ytZQ==
X-CSE-MsgGUID: Ocog6AmiSHqaSZ3EKDgNfA==
X-IPAS-Result: =?us-ascii?q?A0AoAACHXMVq/4z/Ja1aHAEBAQEBAQcBARIBAQQEAQFlg?=
 =?us-ascii?q?RcHAQELAYFtU4IuSYRXg00BAYRMX4ZYgiEDnhoUgWoPAQEBDQEBUQQBAYUFA?=
 =?us-ascii?q?o4JAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZckBMBA?=
 =?us-ascii?q?QEDIw8BBS8JCRALDgoCAiYCAjElBhMCAQGCfoJ1AwECrHkCih16gTKBAYR/2?=
 =?us-ascii?q?UmBdBWBCi4BhXGCbQGFeRuEYScbgUlEgTwLgkgxPoQfC4N0gmoEgiKBDJVJU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcRHlgbBgUSICpBQ12BWjwjG?=
 =?us-ascii?q?TZ6gQlegSspYAECDhdGLhWCBwKCVIEjAlsCAUlBDgdFUwklQxJHJiIIEgkBE?=
 =?us-ascii?q?xowC4EbODwJKEEXDCBtPTcKCxkEPZFKHoFvD2FbIV8CJmwYHBoBEAE6kwyDN?=
 =?us-ascii?q?Y8TgTWfWoQogWafewYPBC+EBI0UmVeZCKQLhQ0CBAIEBQIQAQEGgWg8gVkzG?=
 =?us-ascii?q?ggbFYMiUxkPjmDPfVk+AQcCBw8CgXOQEYFtAQE?=
IronPort-PHdr: A9a23:acME1BMe1eh959VqLZYl6nc2WUAX0o4cdiYP4ZYhzrVWfbvmo9LpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:FPojrqA7ArsWABVW/0biw5YqxClBgxIJ4kV8jS/XYbTApD8nhjUDz
 2UdDTyCbPyCNDP9eIpwYIzg9kIHu8XTxoVrOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGcYZsCCCM/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXGthh
 fuo+5eBYQf9hWYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEw8pWEEhsJaEi0N0uIWBX7
 vhbOSw/V0XW7w626OrTpuhEnM8vKozveYgYoHwllWqfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY3BPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FEqiua9aIGLJbRmQ+1ylUGX+
 EvD/l/ZGxghBoey6haK1HyF07qncSTTHdh6+KeD3vprhkCDg28eEhsbUXOlrvSjzE2zQdRSL
 woT4CVGha4/6ECmUPHjUBCi5n2JpBgRX5xXCeJS1e2W4rDf7wDcAi0PSSRMLYR98sQ3Xjctk
 FSOmrsFGABSjVFcclrEnp+8pjKpMi9TJmgHDRLohyNfizU/iOnfVi7yc+s=
IronPort-HdrOrdr: A9a23:HuPSFaqBHuk5cgh1UlmqL7waV5teLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJhBo7y90We7MAnhHO1OkPUs1NCZLXjbUQqTXf9fBOTZslrd8kHFh5dgPO
 JbAtdD4b7LfCtHZKTBkW2F+r8bqbHtntHL9ILjJjVWPHxXgspbnn9E42igYzZLrUV9dPwEPa
 vZzPBq4xCnfnMaZNm6AH4qY8jvzuegqLvWJTQ9K1oC8gehsROEgYSWL/DOtS1uIw9n8PMP4G
 LFmwv26uGZte2nyhjT7mnX755HstrswNlOCaW3+4Qow3jX+02VjYJaNIGqjXQQmqWC+VwqmN
 7Dr1MJONly0WrYeiWQrQH20wft/T4y4zu6oGXozEfLkIjcfnYXGsBBjYVWfl/w7Fchhsh11O
 Zu03iCv5RaIBvclGDW5sTOVTttik2oyEBS29I7vjh6a88zebVRpYsQ8Ad8F4oBJjvz7MQdHO
 xnHKjnlYBrWGLfS0qcknhkwdSqUHh2NAyBWFI+tsuc1CUTtGxlzmMDrfZv3ksoxdYYcd1p9u
 7EOqNnmPVlVckNd59wA+8HXI+eFnHNexTRK2ifSG6XVZ3vA0i96aIf3Y9Fod1DIPczvd8Pcd
 X6IR1lXFcJCgHT4Zbk5uwNzvjPKF/NKggFhPsuoaSRgYeMMIYDARfzOmzGrPHQ1sn3IverEs
 pba6gmS8MLa1GeVrph7knZR4RYL2UYXYk+v9Y2XE/Ln+fwQ7ea79AytJ3oVeHQ+fFOYBKmPk
 c+
X-Talos-CUID: 9a23:bDj10G4cdrpmTzv4Etss9HEsBsl/alHn5kyJA06hEmIqWaGncArF
X-Talos-MUID: 9a23:KMenawbXgZpfruBTkDTri29LMcZTw72nM3JWvLYqtO+KHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Oct 2026 20:41:31 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id BC200180005AB;
	Tue,  6 Oct 2026 20:41:31 +0000 (GMT)
X-CSE-ConnectionGUID: Jg7O3qqdRGqHkXIRAZuwEw==
X-CSE-MsgGUID: ef9+by+hQk+Aa0YUgARpAg==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.27,143,1787011200"; 
   d="scan'208";a="95158735"
Received: from mail-westcentralusazon11010062.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.62])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Oct 2026 20:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clP55W1sBexuiygHN6GamNT+fv7xRgT41lM8lh+d8YA21AY1uudGc+NsHk7hZXPuahyEhwwioajkM4PiBm48YqW4b6immfxVtl2thFw7dvob9n+l4HDTeYzMuN3e5I581cjgvhhdmZmZDOL5o//QnjoYD7M9qygyvyZowL2prhTwb+TogLuCzhJl4xAbqgxHiy9ejs2iIGi8U/MQUWJm4/RDxjDGsjHP5S9aMfXafmElIiSSFGdUzsXQOFPwoC9c0mw9e9uEPNc4ysmd7172WhE0oLIStW62Av1CLiSIgzOAPExKOFhd1k8wu0RuxqhZZWCqbLvCViqUK1xLMH+Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpfHyM7JbIyFbzOmFwhyZaJiq928Br+Fs8XJ7sud/A8=;
 b=XZ4fARpUef5njBN/URm4Tcrx/KXewpwMptxor+51rABxN5OYtNPV0CkGF54qEbq7FW0QahqZEfPIT+jGoaQtS5J3GQWhtCjTfooltnDE2nHiCZM8v3buQghX9plKfb1+85CtLjySJ6/7bEj+PK9B12EwBE0as9tQgdU44OyU9Bl5+hWBN+dPmTLS8cewX2IvPkh/GI5IuOyADAXtPOMuF4RkX9vYDIX6g9CE9XDP6fi2JuBuxO7HksyYEwPiMtJ+JNwzvel1MyMqz9roeSZ3oWGMkehGCWXu9ytMVvrNJ/TUmO8ZkmJHyZ985u6Y64zXHkDa553NSH1Wza8IqaTRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) by
 SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 20:41:28 +0000
Received: from DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::a457:7d37:d8f:7340]) by DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::a457:7d37:d8f:7340%5]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 20:41:28 +0000
Message-ID: <79a2a179-0786-4108-a588-97f6aa0a7b74@cisco.com>
Date: Tue, 6 Oct 2026 13:41:26 -0700
User-Agent: Mozilla Thunderbird
From: Satish Kharat <satishkh@cisco.com>
Subject: Re: [PATCH net-next v2 3/6] enic: recover V2 VF mailbox when PF state
 is unknown
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sesidhar Baddela <sebaddel@cisco.com>
References: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-3-5962c10061b2@cisco.com>
 <179105705474.434549.8884325756137736298@kernel.org>
 <20261006164810.GN83879@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20261006164810.GN83879@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To DM3PR11MB8758.namprd11.prod.outlook.com
 (2603:10b6:0:47::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8758:EE_|SA1PR11MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: b78bb146-5b69-4910-f362-08df23ea326c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|3023799007|6133799003|20046099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7JnpDYzSC72SUBCHV0DY3AbsjdZqwAsV14ImnkIMQ8BJIKGHqr++F5F3feFraZ7PuxqxlJg0jtH2HC+xaOVKjHIFK1pwsCHO9er9B5JbzkcH8fzp85PtcmX3ommHnsBcrvBcnaFknmlouWLPWUSEKf77Zc057zPXrjPKkTMmsSxDVwSCemSoIQJ6SGB+RaCW3/FK3q1EDOxx13olzbVaGeJ7CVYls4h4Tbn7hK6oxWrmXcgY7AiM2+Eoh5SxFA4qKqur44m5AzMymBQ0CRXRcVZKTjbXT+aJffWN6SGZOgPS4Ei2eW7M9zYT2sG9kzcYFVt/+kchYTguuIiOcwDpDMl+UgSs70vSJGgZXsrRAuCnj+40LO/xnfo4gIQhbEH5jlV//AO5z28PJz2znEy0J5EvEEvwvy4oRm5ebPy5wu8s6aFg3FM03UVb14xWi0BZMVi7+FiZCi4HOMciJrWbFCiicvdTANYy3GvE2TASF0t3+CiZ8iVvFzH18jDTh6iFk6dLANO3f3tjNUdnKbSfYD3wRSVPwxK48OOdti+UhMwb0ZgI2GpsQG4avkdQwP4MNYmf5I+75nS+FsvalGaLyo42h426r1azFpcydPIlYyfjbu1yuKsWuolHtKVarq9n8bs4ahtC8E+ErbFkSexE58tJow9xA7gbgAJDYWHI9p4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(20046099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q252YUtWVWpPM2h1RERWSnBuQXk3V2hmMUVoWkVxcU1kSFdOdHJoYlFIcGtZ?=
 =?utf-8?B?TzVtU2FvM1RZSDJsZW8yTnJsdVZDN3BQNEpHelRORE01Z1ZyTEdWbVZZMTJ2?=
 =?utf-8?B?bk1rZjNHMUVFcVV2WE5rWS9PV1J1TFd0NSszanNJNlVxLzhENmxBSWhCMTNy?=
 =?utf-8?B?bm56ZHNRN1ludjhvRFVaOEZiWXBhai9tcHBZeEcwb2YrVFhER0hxUTRlZ0pi?=
 =?utf-8?B?TjFDUVJyWmMwVFN4MUt6ckJ0TFdnek5EVHQwV21GenNTYnd2SWpaMVY2MkRr?=
 =?utf-8?B?MkdsNzBnY0xVaXNRM1dkWXloWkxHamVMUjBISWRFQzlNNmwyZ1ZDMElMNFJq?=
 =?utf-8?B?NGFKeXZ0WWtlbGlmalExMlRvZ1lKNlZjWTJXenRIbWZjc0FoS0pzeWIvVkFj?=
 =?utf-8?B?UXlXQWZTeXlHaTZRT1NxTDgrQWtsQXFlQjh1ZUV1SGNnQjZHTDdNTnpCN2sw?=
 =?utf-8?B?S1NMUVBhWitVVnFleExuUmdBZ1F5Y3BVUW5pRWFRVmNyV08rbGpud3lON2N5?=
 =?utf-8?B?c1lpR3Boc2haMTZVbnREWDNodjNGY2lKZ09TM1dxREdlc281M0tkUkJjdjFm?=
 =?utf-8?B?R3U4NGxXaHMrL3Y0N0dxYTZwVko3TjBUbis2eWNVcVFWNWNwYS9LTUNGcG5K?=
 =?utf-8?B?SlNvQlVIVElOOVNrdFhIYm1Tek8xNmtiNDFCMm9BYnF1TEdsdUJxNG0rOGpH?=
 =?utf-8?B?NFMyRnVDUDY5dGhxajZyczZPSGpOdit2U0NRV05jQUdNVW5GNHBsaWV1dllQ?=
 =?utf-8?B?bzJianR3cXQwZnhvVTJLd0NRUk9lMXBzOFAyNW43bXMyMThXQVdSOWlNQVFj?=
 =?utf-8?B?NDEwK0MzRVRGZFRnUzJLYVJPK1dJUStHV3ZtRTVWR1NhQVFYMlQyeWp2cW9U?=
 =?utf-8?B?RldYZlcraWF3bG55UDV5cG1hcGFEcWx3K2hxQ2dvQ1NSV3JPYVpUelVSSVd4?=
 =?utf-8?B?WmdwaHd0alNvR1RISVRjZTVna25KdVJ4Yy9GOXpzbmtvekVIc25ERUw3Z2p4?=
 =?utf-8?B?L3hHSWNacmFuWnEzbnFCRDh2RnJ4MVhsM2srT2lpR1lIMXp0RC92aWo2OEVQ?=
 =?utf-8?B?ZDc5Z0pkWDU3Y2VIaDVjK2pNdHg1R3NGVzZHRVdSdVF3Q2p0cWJxR3U5aEd4?=
 =?utf-8?B?ZGxMaDdvVzArc0xaQ25zQ3cwc2NCQlVZRzFNdWlRQ2NqZUxDM2NsT0JRQ1pt?=
 =?utf-8?B?TzE5emtTKy94THZFT3doVkFEZEczV00rSmIzOVNkWThEUjY3Y0dTMU9vVVNM?=
 =?utf-8?B?UEZjNmQveEduRjBHTFF6MVBGcG5xbm85WTZndWllMzBOeXQ3TkdScVFQVGNw?=
 =?utf-8?B?a3JVYm02MTFETmgwNU0rZitpOGZSUjJFWE1QZjNvRCs3N0FQWDZNQWF1ZXJ6?=
 =?utf-8?B?UnQrMXN6QVdBN3RNbnRUb0tmaEh1RUJZbjdvWWppRWVUS1Q1N1QzVDZFT3NR?=
 =?utf-8?B?VkU3ckV5alh4V3BuQXVheGkzbjBrbU9uZjAvQVlxUFZRVktsWVRDb0QxVC9X?=
 =?utf-8?B?b2FraW9EUlBMbVZSRW9hM3JoVkRKL3I5VVYxS1YvejdSU0FYZzR1a1JGeGlv?=
 =?utf-8?B?ZFBRd3VTR2hKZUxXQllabkVSQjB2VHp5U09GZzRtclpEaFdGUHVoaGNiWXdx?=
 =?utf-8?B?SWVINnYvK3hoZDFxckJmS3BPZS9yZ05GQndZMUdIYkErWHMzS1U1KzVuQ0x2?=
 =?utf-8?B?Wm9qdWNyOHBmanJlQ0xWVm9SWVhJL1FaS294RFFUMXVUalp0YVBoMW5OQ1FX?=
 =?utf-8?B?NUNXaVJneTYvT2lGc3N5VlFKYnNpeGs4RDJrd0gxbFNKLzZqK3FQV1RSWXgv?=
 =?utf-8?B?cEQxeTFTaDVHVkU0QzhQbnRaaVVqaHNqOVNneUlPZkdIVzl6RGVOejZXMVlj?=
 =?utf-8?B?RGs3eW1seFlwSXZablpiU1VpVWNwN2tST3ExR3ZxdWhnWWdVM3h3STNqYnRk?=
 =?utf-8?B?MUFsNnhiWnZFWGJpcDBOZm8rUlZRdTR0Tk53amZLc01hb3FMZnVSaUdldi9o?=
 =?utf-8?B?RVB3T1VlQzVRQXFSTXZFZFh3bHYvWlp4U25zZ0Zzc0w1MkZHVGphbGx3bk5J?=
 =?utf-8?B?L0NWTXcwRU9VR0pBQnpKNkVlNGtvNzM2QlRYTGh4L1pveHh5aVc2TmxHcGhX?=
 =?utf-8?B?MFBpNTYxSFVoVTcveWh6cGJCck9hVmlENk9kNUkzMGQwNUw5VFRDYVdXY3Ns?=
 =?utf-8?B?Mm9FdHFBZUYrM3JTRFdGU083TTQ5bDY4RDdCOWR1SmVNWW9icktHRTJFaFNU?=
 =?utf-8?B?dkdkZzR4MXFENTljOVJlTEs5ak1VRDBZSDUyR1JOek9lWm5nYnJCall2clZr?=
 =?utf-8?B?MytRMnB4UWRvU2g0NjJqUVgyYzRuUG0yblR4dVlTY09jcjNiSS9DUT09?=
X-Exchange-RoutingPolicyChecked:
	t7+hLjSe36HtHK/LfV8lb8N6PL8IquX+WPT6fiIEdwwxnccDGxyLdsI/AxzSg+rD8sammQ6PS8VkjlC7y62xUST5Q9V1mJ2uXRs2JlfaXCuHZhGnDDaj9guGo1jkFqAr3kGTmJGsrnfqxtqHscFVNRVF1daBBEBNpH9buNxmhilXfM8uv7cAm7OokvnwOlxPd0G8KfenWzCe2BMOQxntmdXxufLbkTIaWQKVW7hex0dakuVciAXa6jcS5WQk+OcoavmmcdWWO28zEF5eWkqy66QuN87TYbrwG8H70+Tnb44AsV+tCdYwS7c6YJFMs7xMd7ajUBzd/rfKJi1SKiqEgg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78bb146-5b69-4910-f362-08df23ea326c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 20:41:28.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4BmwMsffZebS52UZsrYCSgXqJoZcrk2Tx/n96MX0XaePRDV3TQP2Dl3Dc5vm5Nide9Pcxq2z9nAO6gEIJtv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-4.cisco.com [72.163.7.165];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com

Hi Simon,

Thanks for taking a look, and apologies for not responding to the 
Sashiko report sooner.

I agree that both High findings are valid. They are related consequences 
of the reset and error-unwind handling in this revision: the netdev can 
remain administratively running after the datapath has been partially 
stopped, and vf_datapath_open is not sufficient to represent and safely 
recover that state.

I have reviewed the remaining findings as well and am preparing a new
revision that addresses the valid, non-pre-existing issues. I will also 
reply to the Sashiko report with an issue-by-issue disposition for every 
Medium-or-higher finding, including concrete explanations for findings 
that do not require a code change.

Please consider v2 superseded. I will post v3 after the updated 
implementation has completed review and testing.

Thanks,
Satish

pw-bot: cr

On Tue, Oct 6, 2026 at 5:48 PM Simon Horman <horms@kernel.org> wrote:
> On Sat, Oct 03, 2026 at 07:50:54PM +0000,
> netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 11 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 2 · Medium: 6 · Low: 3
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [High] enic_reset() now has two new error exits, taken when
> >   enic_dev_soft_reset() fails or when the newly added vnic_dev_init()…
> > - [High] The patch adds vf_datapath_open so that "a failed internal reset
> >   cannot stop it twice".
>
> Hi Satish,
>
> There is an expectation that the author responds to these messages
> in order for the patch-set to proceed.
>
> In order to move things a long a bit I've taken a brief look at the two
> issues above (only) and they seem both related to each other and
> legitimate problems.
>
> Please also look over these and other issues reported by
> netdev-bot+sashiko@kernel.org for this patchset-set.
>
> For those that are non-issues, please indicate that,
> e.g. by responding to the bot on the ML.
>
> And please post an updated version that addresses the real,
> non-pre-existing, issues.
>
> Thanks!
>
> > - [Medium] The commit message says the timed-out DMA mapping is left "for
> >   admin-channel teardown to reclaim safely".
> > - [Medium] vf_mbox_recovery_active is a plain bool.
> > - [Medium] vf_mbox_recovery_active stays true for the whole run of the
> >   reset worker, including the time after enic_open() has committed…
> > - [Medium] The patch makes several admin-RQ drop paths trigger full VF
> >   recovery (RX quarantine, carrier off, sends disabled, a soft reset…
> > - [Medium] The new V2 VF error exit in enic_open() (`goto
> >   err_out_dev_disable`) runs after enic_dev_enable() has succeeded, when…
> > - [Medium] The new vnic_dev_init() call in enic_reset() issues CMD_INIT,
> >   or on older firmware CMD_INIT_v1 + CMD_GET_MAC_ADDR + CMD_ADDR_ADD,…
> > - [Low] Concern: the patch has no Fixes: tag even though it fixes V2
> >   mailbox behaviour introduced by commit 1f0c856b596337.
> > - [Low] Concern: the commit message and comments assume a VF MAC/receive-
> >   filter mailbox protocol and a station/filter replay that do not exist…
> > - [Low] Concern: the new enic_reset_addr_lists() calls in enic_open() and
> >   enic_admin_chan_reopen() run __dev_uc_unsync()/__dev_mc_unsync()…
>
> --
> pw-bot: changes-requested
