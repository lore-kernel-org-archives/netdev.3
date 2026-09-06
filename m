Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7D360ED6;
	Sun,  6 Sep 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788691301; cv=fail; b=CuUFLxv7n5o5v2OxaSwKNcenmx2lTXXYONZN3uSQtmIliH+QgA14oLcbJIsbjgL2689AP3gov0w3zB23FETjO+s3mXWTl0RkEeu3okcTGJE1XjW/a01BoBL03EZxkCjQZdNlMjBwk450mbwuK7GrruFgjplhuBK6Y+aeMsGOk90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788691301; c=relaxed/simple;
	bh=04lUJmOSVqxLErSy1FqJ/Vnx4TjbhI0Xuz9mS5L2WFU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wqny2U8llrFWDrl/cJ4ir1Ow445kO8RX/YUQq/2WnTeQsunrOyJoBTzV/H3nInGxWvxub2LZs4Hx/39dJSZfwzuraP0YTyQCiDdU/j/ziP/rLUXdN/TC5DZ4HhZ3UHcCdIrJn/FrFwulvEj+NqqNDpYqm8zdP1i/mhaQSr2uoyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHQ7aAUk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHQ7aAUk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788691299; x=1820227299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=04lUJmOSVqxLErSy1FqJ/Vnx4TjbhI0Xuz9mS5L2WFU=;
  b=aHQ7aAUkcjbfmGfnzQbQrqxXcafuFZvq1up++c44/RcGZBTs2HkXoFw3
   HVL2ncibuwn4cBCI1xF6grAcC+7MsxAr1yBD0c50Xgp9thmdfbsuNgqeM
   st5a8boMuAnrUBEPVibO+bLGDirB/0ukUKDTU1IgppSMQtWRcG8we9Tr7
   FnDymioCvqV6TgOEn5KN4tpbiDaSShlRldPHv3BGv8cU9ShiEJcQjg8XM
   Y0QBj26k7Ly3gxPE3/GlnXsmXXzStn9QGGph/RdZWthjcqjD15dzIXDFV
   yvTmy9WUIHrxhFVNaqsTRwX2R+WHwGfBxHCx1rlmaNx4DF/u5JuvkBpzy
   w==;
X-CSE-ConnectionGUID: 3Js82bNGQdiFIhRp7a8jcA==
X-CSE-MsgGUID: ml6oDrK6TtiMNYhDl01ONA==
X-IronPort-AV: E=McAfee;i="6800,10657,11897"; a="89046872"
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="89046872"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 03:41:39 -0700
X-CSE-ConnectionGUID: YjdIlPgPQ/y8God2G4W+Ng==
X-CSE-MsgGUID: 2YoGioguQguUgiSbKo8mnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,265,1779174000"; 
   d="scan'208";a="269942724"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 03:41:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 6 Sep 2026 03:41:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 6 Sep 2026 03:41:38 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 6 Sep 2026 03:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNclxbBHHqLcqy1RwLTA3s/9jYjDtnbgHstKarSxl1k+WRugHW8IeqLXbT7yk5l1lKDOuURbQjw81qfIUKnd9nZzhJDhgCfhQkJz17syomwLu/ue/TrJOW0BifNKvJcoiPTCDLesW2lHJJNcJbC7vI6fA1Mwe7TnnOAKwZnGwdNyaetCSX7nzzFIW2RTtsd/S0iUgy0qui+J3w2F0QprlqhgQGJPh7kNSxUXPK6lbQiV+lzEwyw9gZWPAT1Z/It+UK0OU+vdXqqF+Cx0+2nZBIcAhWXaGXwdd9CzaJB0CKWfyCYrKuNm47A4QMS5/Dbm1hRMZdlLOzC6Sfw4+cug2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH5he0/t1wUpcTpJrkFuKTpPoHenXUo73jGQJGnPHb0=;
 b=R1smQlRlrXqL3QJgkmEY4KDOS5cxY3Jv4h7EQvwzuR3hLgrf2b1ts5o+K6kw1EeuuFm7vEUCg8QR7p17ZGqP3CHoRvaQZCWz4Z8tN2ehEi33kwyd2VKgQ6Bk+TdG/Ilufn1r1Z89clEJqfNADxXBYXEKkNOkYG1fcLvynkoN73tgM+5G96TUX1CSA0czcevcfAPB8Zsr136tKmCnuLbKj7mVxHysKpuxJpkj/gxZ02gxIJwFF5GjctaIJ/cfEh2NYTiyNbG5a3MivTNKCyFOMAkxlzlJFUEecB59nV+nO+znT4hVfuBcz4qB0kIqfy1UmkvRhZx88I4dAkbjKzvwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10)
 by LV3PR11MB8460.namprd11.prod.outlook.com (2603:10b6:408:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sun, 6 Sep
 2026 10:41:36 +0000
Received: from LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa]) by LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa%5]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 10:41:36 +0000
Message-ID: <77b21bba-9dc8-4fd6-a703-d6e32447e2e4@intel.com>
Date: Sun, 6 Sep 2026 13:41:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: set fixed clock frequency indication for Alder
 Point
To: Simon Horman <horms@kernel.org>, "Rawda, Tony" <Tony.Rawda@disney.com>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
	"sasha.neftin@intel.com" <sasha.neftin@intel.com>
References: <DM6PR03MB383684B3604D2B332361B810FAB62@DM6PR03MB3836.namprd03.prod.outlook.com>
 <20260906085042.GF40544@horms.kernel.org>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20260906085042.GF40544@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To LV4PR11MB9514.namprd11.prod.outlook.com
 (2603:10b6:408:2e0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV4PR11MB9514:EE_|LV3PR11MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: f9997e11-9b12-4d40-137d-08df0c036cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: RtqMSVUZN21AsHgbrkJb5zxBea063IpcVC3mtFlD4Dj7PqNBVlucDddzLcTlKJGhoQW6q5DlSQYOGLoWAB/9xuPYyp1mp9n3wxceEVk7u2l/tg7to+J95vBNiBaLwCghCKjKVmfXryf0PB68BdISciZGGWBR9Bkm0mlu/XybW8E2p6f1prKPdRsV5OUeN/eAQlE/+b3Yr5/ig64qBxIfYsL+1sY9uXMBxHe8g86SImGpU02QuwsUHG0TlafiMk4PeIsmAAjo6gz5DUTw4IvjlQWlGa1W7ZKFOV20325WIMC4aaVKtgCbw0bztgPeU/Ypsds9rE+l/9Q5YDSHsBfkYn914zB/K7aKMR5Q1D7cKXy5gcgJrdNKd7CF2JCxeRH+5yFV25tKWCG6eKJaEMf86cg4TSTRAeAWqmYFcGNCZanK+Q0nxAR9Q1nH7+xqPhnfWCLupa/xuENiPfZTjewAMCUeklJEkyQSgrt7XPWGWdOjPJskKL5FN2aZqmO/ITsgVu47pUchioFZAxSHt0WjrpuS8LnFMPCJKUPm2FhafX1ZSjJeBu2jBK0H0ENCIImzU40nmphSPn+dIfaqX1V7lH9H6jrUJqjzp+yFIUbqMeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdhSGhjRG5kS09EbU9oM1kyY2J6RHJkelM3bGZ1WHd3YlhmRExmYWxpU1pL?=
 =?utf-8?B?VTM2b2xVNDJYUjdBa243SGR2UFB3MWJSeHNMUVBMTmxQMUJwenVqaElFcHJu?=
 =?utf-8?B?aGpPK2RYMkZyT0h3RStuMDhrVE1WeTNWVzdvMmRJRGZaMVdIYTVQWCs1SHc2?=
 =?utf-8?B?b1VRMUN2dzJTVjg5bHZZUmFza3dCVm83Zm0vOUVqNkp4NU5wMnVEOGN4aFpk?=
 =?utf-8?B?OUZscEwzVWkrN0N1SGtzNXhSMEQ3bGRFTUxQSWJOY1lBdDZBbWNzVG93T3Jp?=
 =?utf-8?B?V0orT0dyNmR5blhaNWN5Y2IzdVFBVk11eVc2NTZkMkRFNzVjMEYzVDhKRUlo?=
 =?utf-8?B?bUI3bWorRHBTQzFhck5IeEZLTHZwS2Z4cXA3SlBoSDFjajBnMzNtb1p5R1Z1?=
 =?utf-8?B?bmhxOGdEMHRGTmdXTGZVUWxmUk5nTkNrMmR2TS8xaEZHUUk4ZjgwTHBEQ0Vi?=
 =?utf-8?B?WTdsTm1SR0VCUUFjQmlGT3ZtM09TSkNDcjN4UDg0QldzdFZWZEhwZGtZNmt0?=
 =?utf-8?B?azVtQm5PQjJnaVdrd0xrL2lZc0NqZGRPYkdnR21SSjJXV1o3TGZSNmRqc216?=
 =?utf-8?B?L2xvNGtPdUN6RjFMTk1TVkpkT0orRDlNbW1ZSE54MWs3NXBxVzE4eWgyRHRa?=
 =?utf-8?B?ZzVlVWV0UmpjeWQ0UUJWaEVDeTNsODJpQ1YxdmNhbHZQYmpvY0x1SllFSksr?=
 =?utf-8?B?bzVvSTA0TDN6REtvYlBGYjZxajc1RDJpVDcrblJaUnJXUG4yNHU3dXluUWM1?=
 =?utf-8?B?QUhybUc3ZEd1ZHFQdUVaV2RsVXBzVGlzQ252dFJlY21QeXh6M2pDOXdNd1ZP?=
 =?utf-8?B?d2wrVTk2czI5WWhCL0ZwWmhobm9JM0dmS01keDljNkxjd2d3Yjh3cTF3aHRB?=
 =?utf-8?B?TjdBUVRzUldwMUdyeVJrR0RqNUxvRnFWT3lKTzZVODZBSEhnVHRRMnRQbkhG?=
 =?utf-8?B?NnhQb1NKUE9WLy9relV5SForNTU5aDdGSGVEalU2RXRJdDZJbTRkZDVNZWYv?=
 =?utf-8?B?ZlJyb2pGK0V4dUYvN0lLYTVxS28vcUVhZVJqYnVibzdCQzhhYXJRWW5FQWxi?=
 =?utf-8?B?bDAvZGJsRVZNNk4wMzFZaW5oSjRwbDlFUVBlSUo1dEFCT3VRQ2labUVGb2Rv?=
 =?utf-8?B?UGZ6QmM2RmZZUUQ3aHIzU3BkRVgwNUR4UzVqSE84VGJmVm9SY2FtSWplYlU5?=
 =?utf-8?B?Umx4d1N0V1NEbHV6eHA0Um9yV0JhMXdnY3ZGTVB6YUt2YklRSkJwOVZRSVRY?=
 =?utf-8?B?Q3NMM2JkUFBwRjg2UFNwb1RTcmRvNVJDL1lhT1plOVZTbDRNOGtrUzdyVU43?=
 =?utf-8?B?aXZjSGsrcVYvQStmUVA2NmE0djJrN2MyZ1NQSFl1bUlNdEsrcDVPM1hTUk5H?=
 =?utf-8?B?TGpueklyWGlKdExSTlFUQmxXY3hkRTRFeC9hNFo0NUhkcnNFNUxSdGhTV2V2?=
 =?utf-8?B?dm5ZT1UxdVF3U3phcDZSakh3ZUFwNlFSSmRiYUc5a2hSQzUyL3cxdHJXVmwx?=
 =?utf-8?B?Ni9UeklOZ1NWUzZacHJURkdkTnBpdVJ1eTBzUUVJS3JCVWw0a0VLK1VPYUJv?=
 =?utf-8?B?QjFvczdQQTZiUXROV25kTzhZSklXbEVQc2hVVlduYytjdUhJN21wWFhuTnRJ?=
 =?utf-8?B?WXgxNVgyVTJwRytOdG9HNC9YVjlrSGJDNW5NbTNRYU9XT2tyV1AzSkVsOG40?=
 =?utf-8?B?YjN1dHhZSFRRZkYvL0hTdFU1eDRRdzloTWVYNzJveUd4V3ZFeGt6RUtGenhN?=
 =?utf-8?B?di9xRWs4VG03KytGVCswb0tVNXQyOVBXTkQ0aTY5SGluc3c0WXE0V3N6Vkwx?=
 =?utf-8?B?VTc4MGRMWm0zTTF1aXh4RFJ6enZlWWhiMHhmQm5abmFHTndmajlDVU9OaGZz?=
 =?utf-8?B?VVRQR3FwVHZDUzhDRGJXOVptZTVBalJxc0FDTDJJb0dwOEllT25wR2EzMVJu?=
 =?utf-8?B?bEkyV1NPOExyVkxsRHJSMjhMZitJUG9GRnFpdTY4VCsvSE80V0ZHZm5NT1g1?=
 =?utf-8?B?RjFYRmZuZm5wT0Z0TkVBUXhrTGZKb0FJai9kVFZGd2ZyQVluTXVoQlY1K3pz?=
 =?utf-8?B?b1ZaZ0lUTzFtUTJWUEJucHhucW02b3hBa0lJYklJTkNVVnBIeDhiRkN1K3Yr?=
 =?utf-8?B?dDBnZHZKQUNwUnA2bzFtNS9oS2UzUG8vekNnVG1rV1puWXR1MWozQ1NjeENP?=
 =?utf-8?B?YVNlVGREV3AzdGdwR0NmN3dObng2amJWY2YxL2liL3d2Tkd5VjNObTI4QnVC?=
 =?utf-8?B?WVlzeU1pMHBmbWdndjJDY0orTjlERFREZGx4cUNIbEtYcXB3MmVJdUoxeGJu?=
 =?utf-8?B?K0FJRjRGWTdaTlR6eURmcm9KcG9OdmpteTJVcXRuamhad0N4UnI3RjNzRXp6?=
 =?utf-8?Q?9G+0X6iYkdQkO10c=3D?=
X-Exchange-RoutingPolicyChecked: 3HpxbRfiKZruQDpgHpD6OfIBBbpLG0akwg+VERb5YlaQ6WYPfRt9pIRfaeG+PEXGuNdrYBLBxl0q381vCySeLkoGQNxDT2vmMBAvMxgyhmPDZn3ts4Walhyy+fkEisdsTQ0FqYybNKHbt3r+Gmcx/qyjWOAz1tEUd9UY3DJvTgHzz0+B3RwmFqU/Aa6b0Ukx+7DkVt/DbygCFL4ia1oi15LTSpX75mrToB8jXhKsZgTaNMbyQZ4F9ZxCdOkcJBX0ikr45k0SMzQ91dVFzDEvq6uUrP0XJeJdwIXfhiBkLI1je6JFQsh6JmlIWJ4zRI1PixhFyVtJdn2G8y51YMDlfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9997e11-9b12-4d40-137d-08df0c036cae
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 10:41:35.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUZkjCIxV/CP3aWezRnr+SQq3s8HMjpxtESruUyGcLxAmV4APuZNU3vV7KHROkb0zeqE4xksaAcrd8hVLCQ+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8460
X-OriginatorOrg: intel.com

On 06/09/2026 11:50, Simon Horman wrote:
> On Thu, Sep 03, 2026 at 06:06:33PM +0000, Rawda, Tony wrote:
>> On some Alder Point (e1000_pch_adp) platforms the XTAL value reported in
>> the software STRAP is incorrect, so the SYSCFI bit in TSYNCRXCTL selects
>> a 24 MHz base frequency while the SYSTIM counter actually advances at
>> 38.4 MHz. As a result the PTP hardware clock runs ~1.6x too fast
>> (38.4/24), which prevents ptp4l and other PTP-based time sync from
>> disciplining the clock.
>>
>> Commit 688a0d61b2d7 ("e1000e: set fixed clock frequency indication for
>> Nahum 11 and Nahum 13") fixed the same problem for e1000_pch_mtp,
>> e1000_pch_lnp and e1000_pch_ptp. Alder Point silicon likewise always
>> runs at 38.4 MHz, so give it the same fixed-frequency override in both
>> e1000e_get_base_timinca() and e1000e_ptp_init().
>>
>> Observed on an HP Z2 Mini G9 with I219-LM (17) [8086:1a1c]: before the
>> change the PHC advanced 16.0 s per 10.0 s of wall-clock time and
>> /sys/class/ptp/ptpN/max_adjustment read 999999999 (MAX_PPB_24MHZ);
>> afterwards it advances ~10.0 s and max_adjustment reads 230769100
>> (MAX_PPB_38400KHZ).
>>
>> Fixes: 59e466888038 ("e1000e: Add support for Alder Lake")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Tony Rawda <Tony.Rawda@disney.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
Hi Tony,
Thank you for this patch.

Unfortunately, what we found out is that on Alder Lake platforms (and 
also some Tiger Lake), the clock does not _always_ run at 38.4MHz. 
Depending on platform, it can be 24 or 38.4, but some systems in the 
field have the wrong strap value reflected in the SYSCFI bit, so there 
really is no way to know in advance what the correct clock rate is.

We have been working on a patch that runs a quick check during 
initialization and adjusts the clock rate automatically if it detects a 
drift. The patch is here:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260414065809.3021177-1-dima.ruinskiy@intel.com/
(
also here:
https://sashiko.dev/#/message/20260515182419.1597859-11-anthony.l.nguyen%40intel.com
)

Unfortunately, Sashiko pointed out correctly that the patch is not 
robust enough, because the fix most likely will not survive subsequent 
adjustments from userspace. Here is the review:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260515182419.1597859-1-anthony.l.nguyen%40intel.com?part=10

Could you check whether the current state of the auto-adjust patch works 
on your setup? I expect you will see correct clock, at least immediately 
upon driver load.

If it works for you, we will rework the patch to address the 
aforementioned shortcomings.

I'm afraid that your current patch will simply fix it on some TGL/ADL 
systems, while breaking it on others.

--Dima

