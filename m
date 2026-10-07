Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA23F2109
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398766; cv=fail; b=Rt6ezSUW5vpQUEC7R5vjDprRV65vwjDdSThiW+KagSI68TM0hITnbvP0RdohHSXQ+XQpOVsv7oOlPiiOueV+cNnV4NCS6zPdLgtVvC7xV+3HNIvkvFMI6TwuIL6l5+7iJG2/L8iDeuUsUtiiEHMgSgzICJNN0xxk4gEAMg9zB10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398766; c=relaxed/simple;
	bh=chsVB5qTy+4rpFIRWYNhTUkL7I+kISpIfeMcBkWpe5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aoj3Rqe6zYZgGtcvNyYP0g7Vn08q1eaR1QNO9LYstxXpa3bMlQgw5qMn6Ci9d/C8UoNXhv7YzF2molWkaQy4vDx8PZWhW5rUst5uw/F5epxTsf5y8M7muQrJ4WMQwurS+453XVmJZAmbtzNEinF1HBnC+rJmOVBKY+My8IWOibI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/GpawbL; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/GpawbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791398765; x=1822934765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=chsVB5qTy+4rpFIRWYNhTUkL7I+kISpIfeMcBkWpe5U=;
  b=T/GpawbL9BbMmmmP+BihkAHjqoodQgbWnHCSZfXV5kKk0y0vrY2YiEOC
   Lml3CLnEPGiZzQi/SC8A8d0TYLdIhjGRchJPv9npG7kIzTu8E6rcAModK
   HsAd/TkdJfLOXxKrWR/pKJV8NDXq6cVlAvdKoU3gIXuIfuuGj4BAb0SvB
   QD/W9n70q14cuRC2ijz9uP/uIRpaWWL6lD/0peSBANOoR2nqNarnOk7aq
   VC56SobzRYeEhsH2Id0atuORGwfRA7j1LJWvIoKEFxKh7XTlm9hzR2kMD
   WRs3s0edlETwRdtXUSASZs2r1pEdWz+MrGHlTA+DZ4a2R+1EE7rVJeJGt
   A==;
X-CSE-ConnectionGUID: 7nk3hUnlTm2Z3XBq8uVF4w==
X-CSE-MsgGUID: 77swj//HQBKNRFDHG/af1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="72370"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="72370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 11:46:04 -0700
X-CSE-ConnectionGUID: GC3ePHcjQNeZtGbZTgrBfw==
X-CSE-MsgGUID: ltLnuuywTBqHX707NQkiLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="275304762"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 11:46:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 11:46:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 11:46:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.17)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 11:46:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/i3MQsnD1grJM8D8tqRhcQj9XDzIbw2hKrkNfxGVDHDPgB7k5fKTzIlQZ6uXZljFZb26lQYHPxXzqqx91wrXCucrbxUixd2a9ckV0ZhbvP4TJiwp8g9o3YdDXu9iD+gdxnXqCjiRFDjC3ckU3Dd5qTcAgcA0UB8VctE7M36oXJxDg1SS8eeD3tZTME7/nrDfg++Mr/Bnz/TirQ5gGDp782Htr4nGWxdoWpCEANDBCnWDrPKsuKknl+QpgqOK3e8UHt4UdLmXfVHjKTm12AHr5a41ZuNtoj2Z6DMZY7OYZc8TJsG73+b2kcvtjfK20ou1Id6D/5Ro3+tZjnzfSkA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WO+JbC0skIANvIIH7Ud6phOYsu5c7PvBkAWyAGJZPI=;
 b=ErUE5UYJyBANE/QHo1W48C6uVFP7PcWTyAQFDxHhv1MCD4/eDvvY3/nsummhH2/76XHSPsP4r5hcGp49bDmxwKnf8PifV+tzHT/jFzA+83fhOIez+FgfYhJ1vWz0fqEwETt8Qay75ZiYA5XYaDpts+pN+UbV2xRPDW++cvtrCjw1G/gHU3sPGtXr4UguYN/RGSrcKcJpXK+tDjDNJ1/dS05hCxpSYKiUOG8I0yJO73lrXRS/EnrAYA4RAImn5Zmzsr/50DTICQIUgueWKsW31Q82Tz9OPamoS0qDmbZi1XuJsTz4GeJj2Z5mtDQVaDX39ODXdIG5MMp9B1/HCmX2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 18:45:58 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Wed, 7 Oct 2026
 18:45:56 +0000
Message-ID: <20493acf-b267-45f6-bb67-e56b69301c55@intel.com>
Date: Wed, 7 Oct 2026 11:45:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] i40e: skip unnecessary VF reset when setting
 trust
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <netdev-bot+sashiko@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <rafal.romanowski@intel.com>,
	<sdf@fomichev.me>
References: <e1d160d5-7f70-4e41-8632-8a749e356e9b@intel.com>
 <20261007053351.17571-1-jtornosm@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261007053351.17571-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV3PR11MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 761f3627-934b-4d6a-7404-08df24a33901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bcpChDew9qK/3N5bAKCp2uinUP2h138o8ig5aAHxV6brn0Y2C8EfI7lIRmFEObq/so0fWNMrQxCr/CPZ4hzkEZxg2f4n1YacF6eNAPrrDdVTyynKSpbX79AsJLZJnChhlXzyNqYnXAdRGQAc2tAHYc3ZXv2QVGP8bNa1RsBl77S9sIrtizPIbNH4q/b4O3awafcsCjNTTcEqO7rs2DhDjcCEfykDAme/67etjbghFXT76El6nn99FWcBF3KqjJ/RltBokLKBbpPgdfOJebiofXlBF6u00Uja2wOPKug23SnSxrRt4o29szj4r+u38kmlLE8un+s7sFy5pTO4qYnb9ExhWTdvFmL28wga+Ja2qy4QIiF4lk54ZYWQ0Deh45yDZE/ko4Q1mwP26vP24P8JR/bqoqCSRsG+0N7JLRSNIPW9Y2nKiShoKUW7sWT9PEmplcEdxnuA0AxTaxc0kONFZ8YzfWkQ/RINChCCGyZ/53AjC0dz5OxhEeDA+kBSgeVunJNBXGIjF9aRsbQfVTJTwIM3QQxKsVfh94naA/JDeJBM5o0LJ7K00r8KXe0t0YUpRTgBaxuYHmB4h6uB+Hpw49ZToYrlmrpVjAkRnxqeq2td7mWdO9BvtEHiY5GEN/vqjDQhg7ApaA7VqmXW8ZgUVQ3c7bGpJKM2NHxLw6KjUWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlNcEJnTUJ6dVZBTUYyN1cxQjN0UFRRekhWaU5yUm1FMXZlUkY4eVZGYXZY?=
 =?utf-8?B?UWFzeDZ1dGZEOTJxcnhOK2oxWlhFRDNUdzRYc2xES2lRa0xHRlZMcGUreFVX?=
 =?utf-8?B?d21xdTJXVk5QbG5wRGNIVHdxdCtjYlpRUm5nRDJuV2daZ3dUVVVYTU5hMFNX?=
 =?utf-8?B?V0xCRHROY1pwYzlUcjR0RnZFbUlEbko2SnloMS9XelNOU0tvMU9NcXVKZ0l6?=
 =?utf-8?B?TEtBMkNMMWZSMmdISml3N0tjTTllYk1vcWordzR1c0t3ZEIrNDloY1FMQWV2?=
 =?utf-8?B?akVReW16K0J5bDJLdlJxaUZPSHVLSjg5OWRpcEhXb2NpdU9DVDZYTlg3Z0k2?=
 =?utf-8?B?VEs4ckQ3RnlndXFZUWRzZ3dqMHR6WUtETUt2WmQ4N3ZBem9FdGdNeWduTnRt?=
 =?utf-8?B?OWdNR1BMQkw5dlh0TGgreVJESjBqeUgwYlVwQTJ0UFlwaVZjYXZpY3VES24v?=
 =?utf-8?B?bXpFSy81NFZxVDRVb0RjOUsrQ29VNmFCcDdoVHRnbzVSOWpKU2tBSkJLNkNa?=
 =?utf-8?B?Zk9NNU9yYytWT2NJU25hZDB3dEtKNEYydFdrNlZwN0dlUDc2MDVGRUVvNkV5?=
 =?utf-8?B?ejMrVm9UTG53MmtsMk9QVXY3Vy9ISDRtTFo2Y05wSTlMQi9oVUhjNU55RFlI?=
 =?utf-8?B?OGdCam5URVo1ZFBKeUo2dEtuYlZxODgzQmJnRnhWL2hzZG52ZjRyTDJZL3R5?=
 =?utf-8?B?cXJNSTZBbitFT1VSZTEwcG5sVjMrNVIwaDJxRUFEeThJa1o3WjlkOGlmSW9l?=
 =?utf-8?B?M1VpUTBzZlhhZFIrQWZQR1RPcVBOeDN6eCtHWWNjd2pMWFczN0dtS2lEemNH?=
 =?utf-8?B?U0JCcW95ZGtWTlZ3L2s1YXhnand3cXdCTDlYb0RmQ2RXUWtYZ1FQVDJLL1R1?=
 =?utf-8?B?SVNyMXUwaysyM2hTQmJYcksxNUF0Sm8xeUNlcFFja3IvNmhHWmdJWnY3Zmo5?=
 =?utf-8?B?K0hDbURiUis5NXNjeTFPeEtPRHNxcVVEMldDTnBBWGlyTEtsNEE3MXZYaWs1?=
 =?utf-8?B?eDVXUStrODlCaktQOHluNkdJOUlhb2xPNW1tWFUzWFFLWU1Jck5uMVNoOThE?=
 =?utf-8?B?NmJWbzJkVEdpUzBla3M2V092Z3FWbyt0RGgvNFJ3cXhoUXl6eTZub2FPN2ow?=
 =?utf-8?B?eWErTDBoK3ExY1JUN0txNEFRZmZtMGFjM01MTGZPaGlSR1REUGNyOG9QdW9N?=
 =?utf-8?B?RHc2SU43VEdUSFN4T3pDOFBhTjlIVFJTYWlZbFVyOHVRUjBDR29haWVwUnAy?=
 =?utf-8?B?dThoU2JzdllVaE9jL213V3EvT2lUTFRMZDVkVGRHSkVuRjd6RWdtcjVQTlJJ?=
 =?utf-8?B?d20vVVVsa21vZjdEaTVCTjQySGt4dXlnMU95M0lac1JTWEpqUkxaUEtCNnFt?=
 =?utf-8?B?WWlhVnI4c1VzQ2pYaW41RGVvZ2ZETnRGZkdBbDNCVUNFUGUzUXpmNGRib2hy?=
 =?utf-8?B?WjB3Z2VKK3YvUGdLMDRhREtwdnZ6OFIvaVpESnpJN2RpOEZMV2g0d3R1TG9m?=
 =?utf-8?B?T3Q0Y2RITlErcDZCb1Z1K25UUGpFbTNJTXdWTVdIMWEzQS9wTXFRZHI5Umgr?=
 =?utf-8?B?bnpoS0Z4MXQra0RHRjN1Sys2dUMzZklwTmZUeUgxOU82UlRrVWxlemU2OXFr?=
 =?utf-8?B?eWNmQUo3SEJXaGcvclFZUFNETGI3aVV5a09aYmlkM2hVVkF6V0VPN1puN2lN?=
 =?utf-8?B?dXBYc3dWcmlNaWV5V0h5eDdNNmhoVTQrRUp3K252RUVBTUovdm5zaHZmVXZ4?=
 =?utf-8?B?Y3pVUUFpTy9LNUhlMUY5NUpDK1pMay81T0ZneERMdGNmTk11LzR3czhFZ3ha?=
 =?utf-8?B?UlY0dUg1SmI0TEZweWhpU1g3VUFjRVFBSmZPZFA1bCtYdnBsTHVFd1R0RzVV?=
 =?utf-8?B?U2J2MHBxdFFFeEFwbGluMUtpcCs5S1RTUzFnaFdwVkprL0RpVDBIeVcwbmxS?=
 =?utf-8?B?KzZPd1Q0ZkJGTE1HYzBieGhTVDl2a282WjJINUpkalpsSXhJbTIzQ2hlQzYy?=
 =?utf-8?B?NzJ5d2E5dnA1Zy9pd1VqYWg4d0dsTWhjZ2JiRm9aaDVHVk9Vdm1yamIwU0tW?=
 =?utf-8?B?bk1PQUREUmZBL2JLTkJsc29BclBHWFVGWlVMd2dPaVd2ZUJzSzcyMnVGYmZ1?=
 =?utf-8?B?c1VsQUZ6UUdKZ2gvT2Z6QXpnbGwwMnBvcEZ5VHA1Y1BSdVBQb3BWNmtuUTY1?=
 =?utf-8?B?Qk1QMkhNSm5GMk5vdGN6Y2JHa0N5dW1tVlZmSjNramtjcVdZdk1aUFRSVmVK?=
 =?utf-8?B?QklqSDF3Ylc3V0RYNkwxWFNXZTNrSU5NSTBOaEhydVNuRWE4T00vOEhoS0R2?=
 =?utf-8?B?cTR4YXN2akw3WGR2dXRhdWxPcWFOTmJGVVJXZkhIb2JDcDNkWGExYnowdlgz?=
 =?utf-8?Q?nYnGGfIh8yEanXVk=3D?=
X-Exchange-RoutingPolicyChecked: GPDjHGi49Ib3dNZ170bub6AeHQP0ehqPpyV2lmyBJQkrkYGDyyYUDVXQWcgv8aBzgMAgyv8koNoRIr16TRizp2GySuGQDf1OULsNJ44dzL8gcgCxsJM61J/j5aAWwWyTwBCACs26fJNOHulhKru0p9vN+N1n7ZuyCwZG8y7acpBIU+wU3dKh3DaDzcZIiE65jS2/eR+jOTmr+ZQ/MhCSflYt9615bxk0UVMlDg+iskFjWd2XSEgjakvxPbJb+l3DEauvWe4ABFHW35tM5JuzL41bZCc3fhXIrc7ZrhfDuY4oRhQpfn4AiJZrwonWD/qedtassxvKBkRULv8UjhdK9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 761f3627-934b-4d6a-7404-08df24a33901
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:45:56.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odHbqxUz18APVTd4LSU0PeyMYaX46lhWBjJjzNbMbSW99ZfcgAJGRh77CFTF3axh541PmhVlndoLf8Q56/RZi+0EL6iPV0Fege64yLFvKRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741
X-OriginatorOrg: intel.com

On 10/6/2026 10:33 PM, Jose Ignacio Tornos Martinez wrote:
> Hi Jacob,
> 
>> Since the usual case is going to be a situation where we don't expect
>> to exceed these limits, couldn't this check be expanded so we would
>> still reset in the case where the filters need to be removed? I guess
>> its overkill and maybe we accept the extra filters.
> 
> I think accepting the extra filters in this rare case is a reasonable
> trade-off. In the usual case the VF will be well within the untrusted
> limits (bonding setup typically adds 1-2 MAC filters). The reset adds
> ~10 second delay, so we only want it when truly necessary.
> 

Makes sense.

>> This doesn't address the case where filters have MAC addresses
>> different from the admin-set MAC? I am not sure if that still leaves
>> a security hole or not.
> 
> The PF enforces the admin-set MAC restriction on every new add request
> from an untrusted VF (i40e_check_vf_permission() rejects it). Existing
> filters with different MACs remain in hardware, but the VF cannot add
> new ones. I think this is not a security hole: the filters were
> legitimately installed while the VF was trusted, and the VF cannot
> escalate from this state.
> 

True.

>> This is an intentional change that I think should at least be called
>> out in the commit message. This *does* mean a VF which was previously
>> trusted could remain exceeding its untrusted limit in perpetuity
>> until it resets or self-removes the filters.
>>
>> That does mean the VF will technically violate the trusted boundary,
>> but it can't get worse, and it was previously accepted while under
>> trust. I think.
>>
>> I think this is acceptable, but we may want to clarify the
>> functionally changed behavior here so that it is clear.
> 
> Agreed, this is an intentional trade-off that was considered during
> development. As you say, the VF cannot make it worse, and the filters
> were accepted while trusted. And of course, a VF reset cleans
> everything up completely. If you think it would be helpful, I can send
> a follow-up adding a comment in the code documenting this trade-off.
> 

The patches already merged, and I think its ok as-is, the commit message
is pretty clear on what changed. I don't know if a code comment would
actually clarify for anyone that matters. If we had any documentation on
the behavior of the trusted flags that would be the best place for it..
but I don't think that is very well covered in any user manual.

Thanks,
Jake

> Thanks
> 
> Best regards
> José Ignacio
> 

