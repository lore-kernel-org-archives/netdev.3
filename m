Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF1137750
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787372075; cv=fail; b=MJ8mAI7DGzi4NOJavllJJlHW6Imuaa5uzuQNyIfxMrmUcPbtyzZMq+nz4wmfUVDu3N0uGNwDW0FsJ4fy1HaYYAreiQq8RLLEpk48j8xpmIavPpPhihWylXTijz9vzB/A7h93fcCM+LDDc/CQ/X73p+dMyYvz3FfnmhmGCG1GDtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787372075; c=relaxed/simple;
	bh=X1uMch0rc2G5dVnCSVO4YoGJmBJ2PJPIXku7JonAP04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SG3s1Rhkdt3G9RcQPglmwRtYh1TEJ/8sMhQL9zi6pgaE4vEFxsc5slgpkmASqRtClyvi/RDcJXI0j2Xqhldw0tnTyubVdaIq1aUwVAq2t4+slBpm1M/uYTSNrZiOyvnClrej/ynnc02tyS6n2HSDQtrN6HdmDO6/7B/jamnAnBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0odfZGC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0odfZGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787372073; x=1818908073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X1uMch0rc2G5dVnCSVO4YoGJmBJ2PJPIXku7JonAP04=;
  b=U0odfZGCohGN4akKOhqdhmJYsKKJ+lyvbUzrzK+cIQn33/myFpwSpJfX
   1ure/8RgBv14xB+4jZsqdyW7Q6g/0zSBNMqs/fO4jwa7TGbEl3HAcby/v
   XPxS04Zrg3ChjG3RaE1tnJ+hVvyH2v9fMqHTMmRJDqLgSU5k5Gw3oy4D9
   yzqP9sHvs2jCEaKlZM1ZnpLn9aNxJuX82+H2U6tbJDCfCbOYBjUdotrNw
   GQpS1GosTwZqtFwe6kIO0x0lJKrsKY8BBYyeVndyhdfGFQrmkJE8Wk027
   Y58UoUcRVDxh4Y4IGfdtGEFXnjEcDQad1v/QaETLS/eyIaH0hZWVYOuKG
   g==;
X-CSE-ConnectionGUID: /svFPJlTShSCHjNJzxjX4g==
X-CSE-MsgGUID: z79zUiDdSZm6myXOtGxJUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99074490"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="99074490"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 21:14:33 -0700
X-CSE-ConnectionGUID: 6MwKUpyLSjWkOB71M4CL8Q==
X-CSE-MsgGUID: vQgjRNGCSlGp+nyLeBYdkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="296422791"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 21:14:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:14:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 21:14:32 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 21:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS5qnO5/a6N8/wMllSu8thFVrIvdzweumiUNr9i0OMmqux/+VMNI0nJ6hnXz6Ue47oL+0G99wjMJc/SIpGlmq6z+xKvqpN1rfI5v0HPFiPzKkGhk42mpqfzxxPAusPq/k9lqaYwNWa4F425uqnMew3+/B9EYosiEy3e1Q0StCbgC1pwuSxDMidt+jy4vxxcj85ZtxY0ALK2MzrJB242RAeiREZ4W3gzf+/WB5BgGCQWMKaCIb9PLHpmBtzBZSedGG6uHU6k4cjHaTNwyiQKhYuz5jVHIoKIA/5+nvahqJReT+L78Hgnlhq6qA5l5NmTslV0Qh3spPu7vl/lEKdJUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1uMch0rc2G5dVnCSVO4YoGJmBJ2PJPIXku7JonAP04=;
 b=VHGI/fXviCLNe0g1xd0cQOcNsperMn56QLVgIAedd7IWLSlPuY6aJqahtpAFaggtO4vTi7bBq4RbgjRTXP0oqvSSAGReAf7WnrvSCSqqZ1T9MRStjPhT0SyarCS+nMvMGaqsVNTku0kHy8v3Z9jvYNc74z/JtboJnshWJYLrorfSE2UUuV8D1uXng1/xwBaRFFhWjiKRQaPMhmW5oVd9Zonm2FrSiHAc6QhdklrTG8AFdnHiTzIZK8NkLrYVGGDHmGxPhmQbIDf7cPB4EWvVczcccWy2wM5TPJWB3l0e+5KnH8iKrsm8oB48tfJqKmvfTAdfCGoVWQ5tw6i7tZuQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB992400.namprd11.prod.outlook.com (2603:10b6:208:61e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 04:14:25 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0315.014; Sat, 22 Aug 2026
 04:14:24 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
	"Cavatur, Ranjit" <ranjit.cavatur@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net 03/12] ice: E822: cancel offset verification work
 during reset preparation
Thread-Topic: [PATCH iwl-net 03/12] ice: E822: cancel offset verification work
 during reset preparation
Thread-Index: AQHdMctLDLZ/L7NL6UKTPsHTvx6aorapdZSw
Date: Sat, 22 Aug 2026 04:14:24 +0000
Message-ID: <LV1PR11MB8790FBC249356A8F8EE5170890A22@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com>
 <20260821-jk-e825c-minimized-fixes-v1-3-9d0731eb4858@intel.com>
In-Reply-To: <20260821-jk-e825c-minimized-fixes-v1-3-9d0731eb4858@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB992400:EE_
x-ms-office365-filtering-correlation-id: 950df0c0-80ad-4771-f7a0-08df0003d9ca
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: uzKM2dpaG5PvEUgirHrfXzppFaILPJVj5+vbYXPAYQdMXea0m9r7TD42nPfhrvQcnqoKFfmqXpOL0c6I+3C7jxtXi8I8G5O+9k3mMrtnQzHtWgrWyx37Zm4F5xUcgGct9SzKY90JPRE12ni8+T7kE6uIz2gbFdUsU0ij2mWB4TnnGR7wSVam0WhdWCIe4ba71GdQSHQ9q9cQRefMOy6V8rRfnai83hMuOStls3c47ZgFcDV6K4RfuzaAAPkJHUJdNN/pbbgKFWo6j9BusdxRVAmJTap9KRlz2YOhkovfyL3LcCjgvpy1iesbbnl0ewTLoJAbJXKjKc2dwvkRhfTWGG4GEVhLLmy2nj8k/dosGKbfyjTgwH9E1SAIWD3ZnMV1/TV16wgeqXAdbvf6jqQu1Ets/9r5GLZv4NpAviY9PQpp5g0KQYUwNbVKARANEkShlRSb+qnn+9Y2J9Mk8Scl7Qqbf5MXPDHEXiHdW0r+72oVsTHk1Kpfwa0LPp/y8kJIuAjo0YwZUrieGcvhwDiBuhqK4DUucYAtwTwfTYm1mWgbcvKKhkCxStwF74W3ogh4PE7+iu/AOFWdXO3GWUqMoxvuuJU5G53SA5h7+zBcOW+SPAok6Edvlsa/f1j5TBmS3AtgGDv/3ZHllEHuS3HPcN62F0+bzfZ1pKGvOahckFIjuOxa92Zu+bvhmUUa9BAMVW61Kq7XqREMUYcC2JPpAlYlL6V/oXFH807W6jYvhEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlpkMVhwL0JHUTB2eGRnOGwvMGExOEZDSWtheGZBUnU4RCsxK0tQKy9MalB5?=
 =?utf-8?B?bXp2ZmRCL3dnM08vUVdpWGRIY3RRLzlWcDhSWGdIMTJJNVhGcGxUSGt4aVNJ?=
 =?utf-8?B?ejg5SVVXL0NKTXUrR2d6UkhrVnNDbGwrU1dId08yRFBQZWUwMjd4YU1sMzly?=
 =?utf-8?B?dlZYYXArQ1NPN0F6RUR2YllkeThtWTZBeTF5UHd1MTU2eGYrM0NuUnRReFE5?=
 =?utf-8?B?N0ZlSWFjd2krWVRjTWd4NTZTNVRzZk8xVGhNQTBuUHJuL1NkNVJuTFl2ekVB?=
 =?utf-8?B?Wkt5K0NBMDFBTEtDamRpcnZsdDFhNmgvNmpaajA4YTVBR3prSGxnVUhtbWl0?=
 =?utf-8?B?aFVkY0x0cFBCMEc1eC83UmZmMEhDTDNLZDdBNk03cG16Ly9PWWt6R3loZ21Z?=
 =?utf-8?B?NXp1Wjg5WkVUZkdDYUUxbzM0cGk1elk5RU5vb09BNU5PZXI0aGs3Mm44WGds?=
 =?utf-8?B?cmdmb2FwdGx2VURYMXZUc3NtWVN0V1FBclJtZFQ5MkZtWDl4aVdIeTNJSWt5?=
 =?utf-8?B?SzJoWmJCMHRMb0QvaEtXditjVlpPVU94Q3M1QnVJNlV5MlBlMEFhZTdDTkNo?=
 =?utf-8?B?bkpqaTN5NlFiUlI5WXBpdVh4Vm4wdG5PVS8yVnVWQzdwNnhaSDBhYlRlSkhF?=
 =?utf-8?B?bVFkbEJOcHRSNWdtL0FnbGZJN2prS2luU3BKNmJzbzJSZWVjODBlMzg4R0wv?=
 =?utf-8?B?Y3I0ZjdQNEpGL203RjJPSmNZMlFjWTBoeUFZWUtRdjdkK0xjcWR3RWI1U1VK?=
 =?utf-8?B?N2tKVEduN3RkWHhNRFh0eVdNRDg2bUxEL0xNUEhiaE1RV0p5bnMzSHk5Vjl5?=
 =?utf-8?B?VG5QSUdFV1lCMmlUTVJpMnJHS2pjdFY4eHdlc2t3bS9GVjZzSVM4bHlSRzRU?=
 =?utf-8?B?Y3M4R0FzNFphVUlQM2lKRXMxM1BkZzlXV2p0WnJvclVtUytacXltSzR0SUlW?=
 =?utf-8?B?cFVKUXpjQldnREx3TzlxaE91WkVoUXZBakJoUjhkUG5oTjRtSHNlVVZ4WXY1?=
 =?utf-8?B?bEwrU0hkaW0yOUxLMEZlMjV3c0YwZzJrcFpVZWlGajhIc2ZyUjduSTF1Und6?=
 =?utf-8?B?Y0loMTVTWUNGU1NrTFFEbkJha3h1VVdteVBIOWdQYk92MXQ0K1F5S1dHbFU0?=
 =?utf-8?B?UHQyUlJkZXlyM2J2bDhMZytLeUZvaGpPaHZSTVFra3RjMTZrYjJ2VDdYNmlh?=
 =?utf-8?B?ajZVcVpET3hqbFVGcW1tVnpoSHhaUHQxVHlXTVluL3VyYnVtOTF4Z0MyNnk3?=
 =?utf-8?B?TmJkS1JTTlZPUVlCZ2R4RWlvcmtJSTErZGVjeVNvV0Nrdmg1RitCdFlzOEZK?=
 =?utf-8?B?cWFzQlVjTUJqcGx5RVF5aXVKTFovZFcvbkpNdk93aUY2K0k2d2ZQWHFYSUgz?=
 =?utf-8?B?SGRXUWhVOWJVRE84aUxUMS81NkF1TURYNHNDQ21OU0VSd2s4RnNGWUlnRkh3?=
 =?utf-8?B?OHU0R2diTzdCS2FtaDVnZHZBNnFvcG5XQ0crMFlVUUw3S1FrSE5ub041Y1VQ?=
 =?utf-8?B?elBIYXo3ZkxRNzM4cEc4TE9WbENUcGJ2NmdpRE1udmgzdy8yTVM1cWRJZ29k?=
 =?utf-8?B?Nm5LeDhGb2xNRWZ4VVhDOGFOWGFhQXkxb256NXFYUnhDTHlKWkRjQ3cxWlJ1?=
 =?utf-8?B?QzlSNFU0aXArK1dxR1RncDAwREdGNmc4K2tBb2JVM3ZyVEU5aDVERXhkdEF2?=
 =?utf-8?B?OXdFUDJBOW1YcC9xM09vNmZYaDFGbndwSlJNNDM1WDRUV2VFVzRYNy9DcWQx?=
 =?utf-8?B?T2Nydm1IYkN6QVpYVG51Q0dlUUloZldRcGcvMHdYS0ZQS1Q5bngyU0huTUR5?=
 =?utf-8?B?TWhDQ2w2Tng3QlFsOTNsWnFabHdiRnkrNGpRamk1YXozTSthQ0paNko3RlRT?=
 =?utf-8?B?bkFWSTBqd3JRdU1oaHVxWjBYeXZqK2hCYkdmTU9leUcva3lUdWNjUTdYUWlL?=
 =?utf-8?B?WnZGT3U0Yy9uaS94dWNkMmNzUU1VODZreE9iRjJ2RlNPOTdGWmJGQ25NSVRY?=
 =?utf-8?B?bGI0cTltT3FFNVRTUXBUMlphTzdXWVkzVmNNa1dDVlZsdWlpWWFJbzJrMEhv?=
 =?utf-8?B?eWZuRXdvM2ozb0c5UWFhQnRSem4zMGxTYmFOYjlyZUNpeVVxWXBXQzFjRE9S?=
 =?utf-8?B?S3lLemVLdVByanJIRVZyWWFHa3RHS3ptdHkxcDV1cnVCUWxzY1ZYMFBjaTEz?=
 =?utf-8?B?b0Q4OGlhSUVTblZiaWY4eTVlNzc1Yk9zNjlSaExnZU5MUkttVmF4dThwbjF1?=
 =?utf-8?B?Rm5NN2pqbVlkb3NGVFlWZ2xIQnVVREhPOEl3Vkh2WHdPbzdMeG5SOTU5OURo?=
 =?utf-8?B?M2hNOU9zTEg0d0ZVcTFKaDlYalBYSm9sWE5mZ3lPMXlUZlpMS2ZwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KdXsokx/KsYTTnIMRzOpa3GChTGEGSbK6aPHlzW5iNliuyBBXHRLsb7mb11SyTdEqCH1q66LDNwF2fHs6qAfBLe84itTJNjNTX9NaMD1PP/TN3r1vH59iUeYWqO5zvg2AN/JTmPo1zDdBWGkCRGKm8wSDBjXwkQB1/o8qRyu/RxGC3Vqang5nAFbw7Gy1rKnh9Y/1TDATDeau3e6s91hQwPclLEL0egSxiOxNYM5kPMizdKQbuD0qN+QP7xRvt3iaq4yd7zqfgjgGTIfP5a7JSelquyd3ImcR+Tjo6zusfXMgigFaBmnA3Q5KfH2LvVdnrVItWGxCITYczBikB7E7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950df0c0-80ad-4771-f7a0-08df0003d9ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2026 04:14:24.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1Tws5Z+h7mG2hh3+9A+3X04HjmlNO8vDnBwa/rynNQYDCoSybdkJ1/Ei5YHyiTqQvony8cEwOGLSTtdw4acGN1VxslVy8JcLzIkRr+8C40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB992400
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDI2
IDU6MTMgUE0NCj4gVG86IEludGVsIFdpcmVkIExBTiA8aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9z
dW9zbC5vcmc+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBNYWNobmlrb3dza2ksIE1h
Y2llaiA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xh
dy5rb3JiYUBpbnRlbC5jb20+OyBOaXRrYSwgR3J6ZWdvcnogPGdyemVnb3J6Lm5pdGthQGludGVs
LmNvbT47IE9yb3MsIFBldHIgPHBvcm9zQHJlZGhhdC5jb20+OyBOb3dsaW4sIEFsZXhhbmRlciA8
YWxleGFuZGVyLm5vd2xpbkBpbnRlbC5jb20+OyBCcm9zcywgS2V2aW4gPGtldmluLmJyb3NzQGlu
dGVsLmNvbT47IENhdmF0dXIsIFJhbmppdCA8cmFuaml0LmNhdmF0dXJAaW50ZWwuY29tPjsgS2Vs
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBLYXJvbCBLb2xhY2luc2tp
IDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVr
c2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeiA8YXJrYWRp
dXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNsYXcu
a29yYmFAaW50ZWwuY29tPjsgTWFjaG5pa293c2tpLCBNYWNpZWogPG1hY2llai5tYWNobmlrb3dz
a2lAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggaXdsLW5ldCAwMy8xMl0gaWNlOiBFODIy
OiBjYW5jZWwgb2Zmc2V0IHZlcmlmaWNhdGlvbiB3b3JrIGR1cmluZyByZXNldCBwcmVwYXJhdGlv
bg0KPiANCj4gRnJvbTogS2Fyb2wgS29sYWNpbnNraSA8a2Fyb2wua29sYWNpbnNraUBpbnRlbC5j
b20+DQo+IA0KPiBDYW5jZWwgdGhlIG9mZnNldCB2ZXJpZmljYXRpb24gZGVsYXllZCB3b3JrIChv
dl93b3JrKSBkdXJpbmcgUFRQIHJlc2V0IHByZXBhcmF0aW9uIHRvIHByZXZlbnQgaXQgZnJvbSBy
dW5uaW5nIGNvbmN1cnJlbnRseSB3aXRoIHRoZSByZXNldCBzZXF1ZW5jZS4NCj4gDQo+IFdpdGhv
dXQgdGhpcywgaWNlX3B0cF93YWl0X2Zvcl9vZmZzZXRzKCkgY2FuIGV4ZWN1dGUgZHVyaW5nIGEg
cmVzZXQsIGZpbmQgdGhhdCBpY2VfaXNfcmVzZXRfaW5fcHJvZ3Jlc3MoKSBpcyB0cnVlLCBhbmQg
cmUtcXVldWUgaXRzZWxmIGluIGEgdGlnaHQgbG9vcC4gTWVhbndoaWxlLCB0aGUgcmVzZXQgcGF0
aCBpbiBpY2VfcHRwX3JlYnVpbGRfb3duZXIoKSBjYWxscyBpY2VfcHRwX3BvcnRfcGh5X3Jlc3Rh
cnQoKSwgd2hpY2ggc3RhcnRzIGEgbmV3IG92X3dvcmsuIFRoaXMgcmVzdWx0cyBpbiB0d28gb3Zf
d29yayBpbnN0YW5jZXMgcnVubmluZyBzaW11bHRhbmVvdXNseSwgcmFjaW5nIG92ZXIgdGhlIFBI
WSBvZmZzZXQgcmVnaXN0ZXJzIGFuZCB0aGUgY2FsaWJyYXRpbmcgZmxhZy4NCj4gDQo+IENhbmNl
bCBvdl93b3JrIGluIGljZV9wdHBfcHJlcGFyZV9mb3JfcmVzZXQoKSBhbG9uZ3NpZGUgdGhlIGV4
aXN0aW5nIGNhbmNlbGxhdGlvbiBvZiB0aGUgVHggdHJhY2tlci4gVGhlIGNvbW1lbnQgaW4gdGhl
IGV4aXN0aW5nIGNvZGUgYWxyZWFkeSBkb2N1bWVudHMgdGhhdCBvdl93b3JrIGludGVyZmVyZW5j
ZSBkdXJpbmcgcmVzZXQgaXMgYSBjb25jZXJuIGJ1dCA+IG9ubHkgY2FuY2VscyBpdCBkdXJpbmcg
aWNlX3B0cF9yZWxlYXNlKCkuDQo+IA0KPiBGaXhlczogNDgwOTY3MTAxNWExICgiaWNlOiBGaXgg
RTgxMCBQVFAgcmVzZXQgZmxvdyIpDQo+IFNpZ25lZC1vZmYtYnk6IEthcm9sIEtvbGFjaW5za2kg
PGthcm9sLmtvbGFjaW5za2lAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQWxla3NhbmRyIExv
a3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEFya2FkaXVzeiBLdWJhbGV3c2tpIDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFByemVteXNsYXcgS29yYmEgPHByemVteXNsYXcua29yYmFAaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogTWFjaWVrIE1hY2huaWtvd3NraSA8bWFjaWVqLm1hY2huaWtv
d3NraUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNl
L2ljZV9wdHAuYyB8IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KykNCg0KVGVzdGVkLWJ5OiBBbGV4YW5kZXIgTm93bGluIDxhbGV4YW5kZXIubm93bGluQGludGVs
LmNvbT4NCg==
