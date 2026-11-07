Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794022378;
	b=3kl1ocR+dgmW+pyOK6p4TV9vCGCZQKdlw1prL7LfE8p1AgDMyf/oN7J6rVKRxXylACTg
	 weLAND1Ddm2RNQ6t/INFcHiHD5ZVdObZ7esnVqsStAcWEFSWXKtfSge1jQXIPGM0g7P4O
	 7lAhUZzTvKd4LRYfbZSR2YvxmrLfztrciC5Lzznr9gKsedecMfXRuDgz2Z1QbOQ4H4sao
	 15xbixEC/uIjDOalAFqcKNBQ27/wxqBgNQxb+RMDkmDzhoXHhq7c1EoZQ5jdC678dHetI
	 Pzdm/QdBBzasEyE0ECthdoxYr6LIQ1yJ4bwyHqJoi7pVmO5AGMzVx7S4duxpE+D+yDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022378;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=W3cArQinU2DOOhL5HHjf7OIhJWGRMnxeh9Cs0n3igcI=;
	b=iCxB/ESohmQlYfxf/Mm0R9tXOnkekibGhnI539QmObZdOI7n9eEcAMfN0EMdJF6h6k0g
	 HGBg0vlK2yv539d60qloShD6BdF94mvDPrKCKFZEZg0xSJ2NhVWy3N0Z17RhjQX7xFQyX
	 i5QoY5HBlmPqvBFHFHyLDh4wkRVxCdN9LBUieETkJjChSZaoOMeT976WNoNIXnZEAvm6u
	 JRK2iRXgx06pg7DtouYXkFhyOYFJiYnd9QbwKjv28QN9Xlpq5X4ezhx+2wsxp/zgVGUrV
	 ddiJUASMukREgzWtrPOQri07tP2eS3n82QAg3xbo951IBNuoTwuo/MEektGmaMzXypA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dyLUH5Qo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D844606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D844606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dyLUH5Qo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794022375; x=1825558375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y8rpzHgrRcUixekChLxVburJblsXpppfgqOeAoKOeBw=;
  b=dyLUH5Qoo0FOq1xqmay7gmbdIga17Ce/npUV8ZLRxdhTG5VsacQxwlHR
   QKhnZrM4fMiX5hdOmWdPMhlfsy+VFz4v7h5+vclmqC0+0eNpy2/qJ+gDl
   7crwIMfrBEpuoSDFz4grYFqBQchlP4REyJJvQhMIJIUIJyIIyexXp4jbp
   wD8V4H+3L9E0vXXrxvVYlvl8H5w+OUh9Jy94ldm7myVrV341sE1nUlJQi
   ZpTcRu48VATLxMHuIHTOQxhiEU28GHRFOy34pMwaFP13+L5z6PtPdVuTL
   qlNX4r/Ddw5ToAhvlbQZdClXlYM6B1KvpGTBmME0s+yzZmGe/F5UXKzkw
   Q==;
X-CSE-ConnectionGUID: Ij3ZMvukSTW+8bBDER2LWg==
X-CSE-MsgGUID: Y1YbQlO2Sj2tp0E5wTQxBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2851503"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2851503"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 19:32:55 -0800
X-CSE-ConnectionGUID: L3BbwEqLRDSR64Dx5oiHfQ==
X-CSE-MsgGUID: uTibMEROTj61+9IMymv6rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9176412"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 19:32:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:32:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 19:32:54 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 19:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZBR7VI79idhawxowuUOFkZfoXgp+dzD6hyYBbax+ZM6B4LV95Os+TgO1GyAUkW+l4dKwg41o5CyGyW1STa6gnRjiR0KSf/MI/1nUuq6niU7K9wSBVADvaMDJM3HXvTKbk3fZJ984NEKGeKs2gfrBWX6eBMqRKFv8Lj22T6aQtf2bcWLBRXoYXa33rT5sQmkjH8ZLqLxzHTcKuC1gK/pNcUmhTKU1tBj8C5/7C5iKuUj5W3ZuJibTOC7JHHPKMXxKU9imor8yIlgnMGZxb4xMnT23j4620ZU37CDmQ578FqJmu0NsHVBGvD7coGJt2EPA6QFbD7VxtogG7oV07JjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3cArQinU2DOOhL5HHjf7OIhJWGRMnxeh9Cs0n3igcI=;
 b=JLApSZigqgJPEO43eirCv3qRz34wChfQjLQ+wqMSifn8cbWN3zZBGVqzBAtk4dD/ahA85SCzHNhmhHomFGawg+77n12TC18sk3svnZ/WhGlXn6NqPQEXzC7X59u7YX+vSFL1aYmVditnJ2cwq/GM4MnpUEHCWtd5j7P0d3mqPtOZ5XePpCCW3WI3M+GQ06UUmfMv95QgrjVd3upYSEb3W9oa9/Qb13ftPfgZJt4N3c+VIQO6quAEUbfvEh6pi6NSPyxnUZrGEe23eSiRyFdXp/J4YRowZKVpxxh1GoTlQ4qWDzsuOVs/eRe3P7vsPYHYIoif7uRdikU9NTy3uhjxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sat, 7 Nov
 2026 03:32:51 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 03:32:51 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 08/10] ice: use libie_irq for interrupts
 managing
Thread-Topic: [PATCH iwl-next v2 08/10] ice: use libie_irq for interrupts
 managing
Thread-Index: AQHdQfHi7ondtzSh+E6KLXINseLLTbciTUGQ
Date: Sat, 7 Nov 2026 03:32:51 +0000
Message-ID: <LV1PR11MB87901429BC7B4FAA4983A28590752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-9-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-9-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DM3PPF5217261E0:EE_
x-ms-office365-filtering-correlation-id: d561c4fc-5802-4d51-947e-08df3c7fcd5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261021123027099003|11063799006|4143699003|56012099006|261026140227099003|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Ao6SlK3TrCN5dQwW/8Pai3TdiGWtdQG3X8p78WCCC9191IGCgbCtdhmAYZRaAgak/oXVd/6M80gvFEnBXlqqFVBdIqMftvOG1xx+f9IBzk5u8TOBqg8ACzUuZtB5YITwU5hZneLO67vw3rnCcxBUBJX/TMfqjFDYvrPG4FLLECkkanGsZSgm0a0HClYA38rM4nQQayncQ42XySR633CTSDq7JWt2k2kVfhwBqkkBn3kE4GmVwUwOD2hi5BWdbztktSRFcJTJYcronQZ22EVZ2APYcdGcdy/HImqDf21E5ffDj5w1OMsXeNj8aUg1vvtm8tL14Uqfw7k1zkTl6iMyDRR/27HIXgdRly093q5yocERUAyu2lpykojhWhlbp8UqtWCw0/UPHrByNVhw1Jw+DL32d9gQhQWvQv6Q93MnttVcur+dJp2kgWOJPID5x1d6pNJNXc8bv/DPS/JzlpYWpkqFQCzVuGSThaxSchKRSLpk6XP6UbP+JqqgDjj5wAcaP3twn/0hUUeKwljAYOxZ7X8osOYys9RDQ9kKnrZugnqXdH7qI1hHIQulb7su46kVQGUpwzgJJ/8q/sCBP3yFztuQifpZiwVK0LrLlRXJp3r/daoGMgq355pA+qvQ0belDL0EARrzbCH9O2k8/fuoUxNbm35L3PBjnQTkvZ1JDq7iTDy/D8HF1VbODTYFOZYWBNt/+AVs6+nEyN1n0IunDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261021123027099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IR6Zd80Pu3TnqVLfpTXLHRp6HOLm+LnkkqpuOCJlapCjXo+vTSyt5vX0sX4q?=
 =?us-ascii?Q?y8ToQ5Zwsmn60f3HVJAVi1mf80AsRrEHU8uD1ST/1ti7ou295+r0rgD0XNQY?=
 =?us-ascii?Q?mLQ3YHx2jiTKJS/fLbhg3l2BVugMaS2Rm8ZKHIImlps7iiWod48+VNu1vsSP?=
 =?us-ascii?Q?M7y7ZRpcunv4YD+kkrTF+RaiEXoTWeRS8ij7KIh4SM+Upjv/nVL0UnZIk/+8?=
 =?us-ascii?Q?qn+cITJ/2ai1cKXbvqBcjBYaG/QiSUtmffbqnCJv4CayxbyHznmVW7z1emkw?=
 =?us-ascii?Q?Fqw2Pd0+j+oG1Lq++RODupU/sM80hP2Cre0hqMYft8JvgYac96sfOoD0WgAX?=
 =?us-ascii?Q?m/T9CV56DO7OybpTML5UamdLiraY2hl+Khm4G1zFDUoemWaDmT1yTW6Zuw5C?=
 =?us-ascii?Q?11wdozhUBTQ6nAtw1ANEgoi1xxeAKOswgBpO6uAN5/Na3OyeWp7xgwEG/oRo?=
 =?us-ascii?Q?3nOpofI1D67YZW5xcJN+pFdEjo0wX/W520GWr6pOLTvaqy+wDRcAG/4HRaAZ?=
 =?us-ascii?Q?Ypic1j2O4upCKyMVWFAjXlzsF05/SnZC/6bgsYAV0asTUxOXEql1WeiGSxPv?=
 =?us-ascii?Q?RLO4EBYbgylPj+P7uQZgiYO0mJO6plzkb0FIMc3UXtWCBbA+FdLtjguhYFOZ?=
 =?us-ascii?Q?ogJaUkObQcGWuyINDis06x3EJIUxpSxVGJ8lxuzG1Ryg4nXBah/Kesk8BYD5?=
 =?us-ascii?Q?S1pjAE+KAAtp1aXkMmDbcsiuAIVT4wZCBC4bHYAD5m6aKMOucTjReGYeC7lF?=
 =?us-ascii?Q?V6hiY88f7Eb0dQUJoVjfHKtwlyJjxrLaweKY/a1270/4V+jfb96eul1crGh1?=
 =?us-ascii?Q?VLTSEo9e82VqtQACYStGCRpikXxiaf5vSh7t67XiWBTbIAskJI1uS3lEcHFV?=
 =?us-ascii?Q?q1CAREvgOeDYFwTyYm32DmlXnSlXFOrGTsgh02RUIJlmnAD0bAZPk6jkzWya?=
 =?us-ascii?Q?JCtFpcjJGQ9HzpJ7WM2sJS40sLnuUI0uR3oL8zEWGLz2TE2tD4vT/iVpLV4a?=
 =?us-ascii?Q?LoYOdtxXSlNjRp5ZXqWm0PR917epXsKi6uiMKdxnNZnH2yCOcyohS3cFtzDB?=
 =?us-ascii?Q?KdSsBAl2EU7VKaGkAS5WicJSi1eMu6TPIjvOCNojI/LPOcELg8ApDDTRDjS/?=
 =?us-ascii?Q?gZ2HNXkQL7c7UhZcGzwZZHxo8m1Yk4hNfZLNw2k6sOWmaxPNglNMJEZdsumN?=
 =?us-ascii?Q?NV81F6UNuPiPjmWzCy3od3+6XQeGCYFUjUmhGbFAnHPjdW8zwrbHlEMyt4km?=
 =?us-ascii?Q?mmDhMysQ7NtxGtTXNF0JBG5bmWN5JkXlFeiPd9Zbqk3cxC9Ds/dbthBuwNim?=
 =?us-ascii?Q?kenRNdWxIDC6tQSXn1sPNLWlB+UDlcp6HAAObCpCUkuSKkSXHSxBH+jZDOky?=
 =?us-ascii?Q?kkCaeSLu86/wKWv007c+bMDzE5elqBalOyiHPyPG6bVUCbJqIfIWV0DTMURI?=
 =?us-ascii?Q?09o4Hxev+eMwKPBTGZMfDDHMBZ5++wvtr8Gusmy8JtAc2sklVvbjqhzwLZ/+?=
 =?us-ascii?Q?9vNoraohIM5YyQhlMj4hMmpGRwA9oRwE9yU30IR/5LqW+hK6lhlEvxmsD46o?=
 =?us-ascii?Q?SdU+RSX72COy45RY9xffROrS61lSHfnjyY0HQ/MvVWihdBBkxDvwnIGGBDLJ?=
 =?us-ascii?Q?l/jaVNLn8FsTBgntdnsWAtBnzlUzXORHLrrDJkDd9vs66znlxgURMCjv3g8l?=
 =?us-ascii?Q?tpupvOu2apnrK0Pu4X/B75I8Jbb7JBeyzdHdcaJCk9XqylXR7U6XJeDzlwdT?=
 =?us-ascii?Q?qFkhpsjlgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uuYnj6IyF9dAOT01xEhoQOks++z5pbHKbINevq8EUMivBeLuQpwX+q4PhTGjpg9+TIRddek23H4MI+g7WRO7srqIDkXUQZYO6KWDrQ7Es/RLrQt38dcHiN1nTeYwN1WshlMxLDi2kAulfUu4tGmTpfDXSE1hP37QJ/MmLC1u8m1xGNU29+mF22x46ZYqu5pO2yU6NSDuocyrV+qH1tgoHANoTdk+RPDIO+BXbM3NKYA7MhaQEAxbqiLHh9f1mld/i1rWnmbpcJbDH4TxNT8qlp7PzYmhoF0nddXEty3byyNw9dNhExpDjGGi0tZbYM1XC576QrWIsgnEFcRDnuppxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d561c4fc-5802-4d51-947e-08df3c7fcd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 03:32:51.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXuKN72T42t6RYNu/hAoXoS9ULF7Hi7RIKQedRwSPbbWgrkKWD2GEPbDeUDOJGplCjejnHSEQIosRGmW6qss/2hyp943N0g2pEEAZAdLM3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>=20
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski <michal.swiatkowski@linux.=
intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 08/10] ice: use libie_irq for interrupts mana=
ging
>=20
> Change interrupts code to fit the libie_irq calls.
>=20
> There is not many difference. Bool for dynamic alloc in libie is changed =
to enum for static and dynamic. Rest code is the same. Instead of custom ic=
e_irq_tracker there is libie_irq that tracks the interrupts.
>=20
> Code fallback to static when there is not more dynamic. Previously it fir=
st used static part. Getting dynamic first better fit the lib code. It isn'=
t breaking current driver code.
>=20
> Dynamic alloc is always set to true if there is support. In libie_irq cod=
e check for dynamic support is done inside. LIBIE_IRQ_ANY can be always pas=
s in case of getting interrupts for VSI. If there is no platform support it=
 is changed to LIBIE_IRQ_STATIC inside libie code.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig        |   1 +
>  drivers/net/ethernet/intel/ice/ice.h      |   5 +-
>  drivers/net/ethernet/intel/ice/ice_base.c |   4 +-
>  drivers/net/ethernet/intel/ice/ice_idc.c  |   4 +-
>  drivers/net/ethernet/intel/ice/ice_irq.c  | 181 ++--------------------  =
drivers/net/ethernet/intel/ice/ice_irq.h  |  14 --
>  drivers/net/ethernet/intel/ice/ice_lib.c  |   3 -
>  drivers/net/ethernet/intel/ice/ice_main.c |  15 +-
>  drivers/net/ethernet/intel/libie/irq.c    |  30 +++-
>  include/linux/net/intel/libie/irq.h       |   2 +
>  10 files changed, 51 insertions(+), 208 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
