Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5654C8FE6
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646776; cv=fail; b=bku6yUQlsKBrK3/8CYd617zcY8QaMAPvyb5HHrjWrUYe+rNTjcYWjaouFSereWg6+NffhDn8iq37269z0sgOFzbde0dEMRE6xdnr2TQaWGd3t407PyDCoFXjUtfO9qBuSlqbtq5H+ialIRL2uAXLTBu1zCR42mi+FQKKMRqDKTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646776; c=relaxed/simple;
	bh=5YGbtONBeY80SKak8p7KZGLoqRXrRxvjne8i4QEEUCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bSu38catfCU6AjBXvP5AN3Yc3eyUUzceK3twHorUFJxLJBfAVNJR+HtmHkFMu8xmKR7OpfsEQh1Tjhf2meOfFFQ6LzdmrDasvNS9hxyVWxMXPV+Q2lRcyvggB30MEoysv5M0GG7kROtkwiYqJr3lwbNhASkwGNC/Rj4WHwfgSsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkU6TOE5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkU6TOE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784646775; x=1816182775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5YGbtONBeY80SKak8p7KZGLoqRXrRxvjne8i4QEEUCw=;
  b=MkU6TOE5/L2U69ZoiTgCEoGrL5dJS7FahuJWldO8lkOUx2EH4wgyB8Ts
   60W/9qP6yA2S+fNNtOE6uIcXdyY60FpmHv13H2NsDS35O4QMqDYiZRBD4
   4hPtYJ5NhEiH1bHrpaB8evf8FY8lSxXHPnSI/PZ6l5N/E/iannXS9CM2S
   qVaNfBEm6SpGyyxTV1SLLmgHXLOJ7cP3G2L7QwWxHQ0LihzOJE4sOzRmP
   aJpoxHJimxHF9fFm/n4nezUEkWwRI6jrsc3bEXP596r6050zlTmC9mM6J
   diIZ4XfYgv0BUj39DtnnhddCihEQgrxi/W05hBnRgnOL/QJjzUBz8j4u7
   w==;
X-CSE-ConnectionGUID: 94gJrhSiQ9ulYri789lvNQ==
X-CSE-MsgGUID: nndxZJ9PQguyjnvc7im5Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107598"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85107598"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:12:55 -0700
X-CSE-ConnectionGUID: OaBxDdG5QaS50yX1YWmA+g==
X-CSE-MsgGUID: 4gmHn39lRGObE7WDNta16g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="251466017"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:12:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 08:12:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 08:12:54 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 08:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKzcGUfKgH4jeYr1+JUsRoDUQ+dmC544y+frJMt4X4nZSxRQzO3shbUCbUks1vFxUnO7K0ppI7kukAnMmih7kg1Cnj3Hhre8O0wlBifxVzTSKO6rUfsJnUHkigmNxjYN0wbpQGTTc/W+aN7VldVE99+2hZDDg18XPMufSqPfU2P8unnOa7VTVblM8YwXDv42+D7Jb5MUQeT1bgQZJpo2qclyIfTfd6q7a9y/rogsjqWbut78F3C9qzTegIEo977B+qJpeyBfqYFYXeorsjUpL+vmfRs0kc3ORGvTYvulFJXqudawjSwzFKPn2a56WyaiR2jM0C/JLxgBpPuxF0Ssgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YGbtONBeY80SKak8p7KZGLoqRXrRxvjne8i4QEEUCw=;
 b=muwioR+pqm+XV+JGIXtvxEOUrXf302+B7OadIbMDCJQ5GcZF0B+qB5dGgadFIRsFojIqPEij9MA4DXOao+XFA4eC+mY12bCzCkypUQHFFkm7SFUaRrvy/Zyspn3P1qvba01lW+wFZUfkWD5BqzX8/OUwK5yNmj3p0atwJI9YPK0a6Oz2nmO1VDk3ly1RUvA7nhY3aPMaLP1FYpCtHrxdIjmM5FHe2usnedf21VHF6rpwEAJ9cDkohyBvQ8Xa3QoNcSSPUdLBR7lvUVLn7uQ8Rv5PD5p1ViQIYpEhHeVXRZ8pCNFMF/oiXCrx+487QZWlEcvNHfVHwjYk6h0YXG6k4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by DS7PR11MB7737.namprd11.prod.outlook.com (2603:10b6:8:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:12:44 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 15:12:43 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
	<hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Alexander H Duyck
	<alexander.duyck@gmail.com>, "lee@trager.us" <lee@trager.us>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
	Susheela Doddagoudar <susheelavin@gmail.com>, Naveen Mamindlapalli
	<naveenm@marvell.com>
CC: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: RE: Loopback, PRBS and link topo enumeration
Thread-Topic: Loopback, PRBS and link topo enumeration
Thread-Index: AQHdFPpAYoxV4V3sWEC7Pd58CGIO4bZ4Gihg
Date: Tue, 21 Jul 2026 15:12:43 +0000
Message-ID: <SN7PR11MB810932EDCB8207383681DCAFFFC22@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <ef8fe714-5ad9-4f98-96fa-d8468beecd38@bootlin.com>
In-Reply-To: <ef8fe714-5ad9-4f98-96fa-d8468beecd38@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|DS7PR11MB7737:EE_
x-ms-office365-filtering-correlation-id: 153abef5-39ef-4d93-b6ec-08dee73a83cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|3023799007|6133799003|11063799006|10067099003|56012099006|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Y+ZKMy9arb8iMHMS4Pak0aBKjQbENz7YOjuhY2EL9sE6z9iIMdyODosO0HSgc/wQ93SRGL4o1KXh/+0IzU2jshc6YXSgVMRPgLRKClvQNLTnaE7TXGHE8OeE+jtJ3MMBghf+OQmbk0o3hfanqbkl/AtUx/ESMDGHP5gSyUeXdQ4f13peIntWlC3Fh6zTmzkLWMx295ODNTMDD9Qb8NPlZ6XYWVIbo4HeE37W3Vllad2kmDCcw7nRFpdA1xGGMuNZ4uwTunxXUFKwqR0SGXgU7RcpHNBLvQYo1FaMOLYVx3tZkhnzv5p4r9Na5U0+YoHsT78kNaw3/rTX1kQrIEmkd919SSbvXsNVMaomVmA0QVjYXmM3SBFvOFB3yN5MKUpp14MzmDws5O5yYshgq6+dXzYQOOzR/Q0a3zUfJSZpcDZolcYj3GjaUtMfF/7Gy/T5AYI45m/P08HoPxJrgqIH0NyqV8kit38+vWGs2h35/VHmwhx8KJg1TFBcvD71E0NbZRFND61zz5TrgoA3S12jtzpEhY/pBkcXS6xknMaNRfxErlUHsRLLUYdUrgFL5KUcQ8FVFm7aL2aUH+jghW9DWSh2M5TdwcyekkBIr+mHmAnerZwQl1Q/VPUCEAasdiTufBl+ocOkUDCugrPgq4vsvb9hNbNjKwbTtx137V00OQOADuSTLsfQZD4SEzC8HQcrUvXDUKuTp9WIYbJdCYWD6Lr1twhT+EL3gfE3i3QA+7bGMBhkQTSpRyBnjqYcQSR7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(10067099003)(56012099006)(921020)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWE0TnU0SWVtZS9NdTJtSWhKejhsRFlNSWpzVGNNc3QzbmtYUmNCME5xbitN?=
 =?utf-8?B?aisxYUdXTEpEZ1ZLai9jV1U3a0txazRCRE1iNzFBdkFHdGhQWkE0c2lLclMx?=
 =?utf-8?B?VFZSbHQyNHVNTzNPdThLZU9UU0JmQWpYK2lCc084QkdsZFczZWsrQlI1NktG?=
 =?utf-8?B?WjVHUDhNS3J0ZjAycjhwODkzK3ZFVSs0dzVLS3RSVEM3WFNzNEI5UVUrOVdV?=
 =?utf-8?B?U2F4UlBGdkRXSDI2ZTNqbEd2aHBERDZGNHNBem8wYXBIYUh1OHVLaEFFZTZH?=
 =?utf-8?B?ZEF0TGFqVTY2QldsNFk0T0FEMzBpMUpadTJrWE9KYjkva3c0ZjBTWm5kU2JY?=
 =?utf-8?B?SjZDZk5reVp4R3dhRU5iQjFWS0xDUU5pc2RERThtQWFVNFlEdXBVNEZrZW8r?=
 =?utf-8?B?OXc4UkwvdkFSR3VGQTc2N2JjZXMyN20wL21iL0pzcHE5YjRDUU81dDBRcnk0?=
 =?utf-8?B?WE01clJueVpxV29NaG9ETHBmZUpZenFxZWRlSkcxYnN0eXpyaUF5UEw4aGhu?=
 =?utf-8?B?Y3V6T3pWR2M5ODZoTHVXOUMxbzFib2syd01CMjJyNlljVmVBOGhLUHNTYUVY?=
 =?utf-8?B?Tld2NjRlbHdEVUxYNU10RDFheTgySjloNE0xcG1xRGJydFBmSHdEN2U0eEJY?=
 =?utf-8?B?NTNzUTdYQkxpVkNUbDdyYVBkZmErZUo4dVExUnc3TGY1UGt6KzJUTjErcmNw?=
 =?utf-8?B?SS9peWRuNVFNNCtPTEcwd0dndlc1VHJiK2xtUXZwckZMclFUZzdoUStDT2t0?=
 =?utf-8?B?UEFxamcrR3JDSFZGWmpGK0lSVVlURXpPR3hHbmp5L0VOanJoUVBMc0NnK1hp?=
 =?utf-8?B?a0V6Q1RRVEp2amQ4d1hMS280L0NJcGdUMUR3UHNZd0VQeGJJUDI1YUwvUHFC?=
 =?utf-8?B?V3lLdmxURXYxVWZLdnJJSG5oNDBNUm1pTUhDYS9udWFwQzNTQ1o1czFjV3NO?=
 =?utf-8?B?ai8xTU9aSm14akkxVU1paTQ3eC9vNnQyV2ErMFcydDUvMVVvQjNMSHp6Q0wy?=
 =?utf-8?B?YStOaFNrSUhGQ2MycXBxOWtXR3VlQkdZODVCRXVOU3ZMRGI1cFNIQjl0WW54?=
 =?utf-8?B?Wm9wQlZyTHkrczMwTUJiOXh0aGdhS2lMVnpYVTV0SUp2TEpPSTNTcE52R00r?=
 =?utf-8?B?WlNldklDdndYVW9KeGtiVWxTSFpXdUdrSDlvYVhHMitxbng2VFMyK0tteVAx?=
 =?utf-8?B?Z0ljaWVDRjNyNVpGbXdRUzIxdEZId0tHOVdqT0FJTTQ4bnJ4QURwYWt1eERo?=
 =?utf-8?B?RlhMZDRsUDlyekxXVXJIV0FzZy9lUUQvdERDM0tFT0NkYlVlOUlFaklRclNk?=
 =?utf-8?B?V20rSDNtSGVYTENUaERmUTVnMllZVzlUT1hXSzJtRU5iM3FFZHpLTkwydG5U?=
 =?utf-8?B?c21HU3ZTVUtZMm1FRlpob01uUG5ZUWo0RGF1S2RxMjlhMWpMN1dMcUJjRE1a?=
 =?utf-8?B?azdVRW5MUCtVK00yeEJ2OVltcWZ1bGZXRElkNlFjS1dBWU1FazRyd0hUTUMy?=
 =?utf-8?B?MFpwYTZFMkFYZWJ2UllzWUZyMjF3K1pPcVZNOGU5RkQvZlNGT3dYQ3VRVW9F?=
 =?utf-8?B?bXdjQWd3bzJ6VUhuaUwyVk9GSEhMSUdaZGZNOHBSbEZFYTN4QndqSE1GU2c5?=
 =?utf-8?B?TWo4d1hvSnNUUTAyejMxaGFDcWEyRStPU1U1WldSTHN3T2VwcWMxd1J6bWh2?=
 =?utf-8?B?Y21pa0krUUVVMFp5SUg5ZzhFQlFONWZrKzA4YTlDUExkUEtNTXFZekRkRFh4?=
 =?utf-8?B?QVpscS9Gd1FITVdGUnppOVdVZXYyQVBXVjI0bFg0MmNiV2VUSjVEb3prdmV5?=
 =?utf-8?B?SlVmbWpJd2hBaWhNR0t0VHpIOEhaQzJzT0dkVFp3bHFnYWxXL3VIS2RqTks0?=
 =?utf-8?B?UkxzUTJXcHI0TFBENzdaV2dxazVhNTVIUlFseVdXN3R4bkl1VmVsTDZHb251?=
 =?utf-8?B?cXhWUDFBa2UwWENsbzdvWDlZMUR2b0tBa3BGcHBiL3R2NGQySzd2OWg5UHhI?=
 =?utf-8?B?WGpHZUJheDdnejNVYi9jVHdOOXNEM254QWV1UVllZFB1ZExkSDd1RmtSQlhZ?=
 =?utf-8?B?bEU5WVNTcmNVNGJWOGRpeWlvL2hlMms0bE1mczc2enNDNkJRVEpDNHI5Wm01?=
 =?utf-8?B?KzQ1ZDI2YXRWa1RPbVNQWVJDcEZhbzlzS3dTQURrM21IbDNQUXRPNFpsV1hj?=
 =?utf-8?B?eUtaaDBzbFNNYUNBMUtUaXRtNVYySUVES3lnOGU5UlZmK3RvOHh3MlpsbzY0?=
 =?utf-8?B?VUdzdjFtZHYvRUNXeWp3VndydHdiMmtEamY2QkVqcEg1dlAxaDJoQjUyZDJi?=
 =?utf-8?Q?5+d68dSHCtTBlPWPST?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BuT7MmeFVnKOb2GEFsV8ou0Erl/0jdmWh1zlWEDNC7YexozvSYaVB8Vvyl6YR8PlX214bpgkeTaDDZv26++3kfEXFXVb/aN43YR1u8GwV5F/eCWIeeNeVxDugJz8ZK64znXH8Pshfug9tP4TnJmkRhTeSgGK16pYHgTIGOjTkIpnfs13lJMdwsEnAeUzAekf72IoZ3oh0u4uMbNcqw0cViUXyxixK8Co/5TxNTTF0ODQmUKOd+y98OsG4fILqwbOfsNeZXK2WDa7IhPjrhK3QdXvwqdfBN7L6o9Cl9ETjH0/c0B1s5COCiHuHfLQnkuHxtuba0dW2yNI4eJlH+yPng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153abef5-39ef-4d93-b6ec-08dee73a83cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 15:12:43.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cl1efbK2H9qVYijUCYOlIdJuiPa6eO7nT/bxvMNjiBZyOS9x9BXz2A3xrNoxp8Vvil3HKqLisvTjp90xboGyRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
X-OriginatorOrg: intel.com

PiBBIHByb3Bvc2VkIGFwcHJvYWNoIHdvdWxkIGJlIHRvIGRlY29tcG9zZSB0aGlzIGludG8gc2Vw
YXJhdGUgZXRobmwgY29tbWFuZHMNCj4gOg0KPiANCj4gIC0gQSBzZXQgb2YgY29tbWFuZHMgdG8g
cmVwb3J0IHRoZSBIVyBsYXlvdXQgdG8gdGhlIHVzZXIgOg0KPiAgIGV0aHRvb2wgLS1pbnRlcmZh
Y2UtY2FwYWJpbGl0aWVzID8NCj4gDQo+ICAgaXQgd291bGQgcmV0dXJuIGEgbGlzdCBvZiB0aGUg
YWJvdmUgbWVudGlvbm5lZCBibG9ja3MsIHBhY2thZ2VzLCBhcyB3ZWxsDQo+ICAgYXMgYW4gaWRl
bnRpZmllciBmb3IgZWFjaCBibG9jaywgc29tZXRoaW5nIGxpa2Ugd2hhdCBCasO2cm4gaGFzIHBy
b3Bvc2VkIGZvcg0KPiAgIGxvb3BiYWNrIFsyXSA6DQo+IA0KPiBbMl0gOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9uZXRkZXYvMjAyNjAzMjUxNDUwMjIuMjYwNzU0NS00LQ0KPiBiam9ybkBrZXJu
ZWwub3JnLw0KPiANCj4gIg0KPiBFYWNoIGxvb3BiYWNrIHBvaW50IGlzIGRlc2NyaWJlZCBieSBh
IG5lc3RlZCBlbnRyeSBhdHRyaWJ1dGUNCj4gY29udGFpbmluZzoNCj4gDQo+ICAtIGNvbXBvbmVu
dCAgd2hlcmUgaW4gdGhlIHBhdGggKE1BQywgUEhZLCBNT0RVTEUpDQo+ICAtIG5hbWUgICAgICAg
c3Vic3lzdGVtIGxhYmVsLCBlLmcuICJjbWlzLWhvc3QiIG9yICJjbWlzLW1lZGlhIg0KPiAgLSBp
ZCAgICAgICAgIG9wdGlvbmFsIGluc3RhbmNlIHNlbGVjdG9yIChlLmcuIFBIWSBpZCwgcG9ydCBp
ZCkNCj4gIC0gZGVwdGggICAgICBvcmRlcmluZyBpbmRleCB3aXRoaW4gYSBjb21wb25lbnQgKDAg
PSBmaXJzdC9vbmx5KQ0KPiAgLSBzdXBwb3J0ZWQgIGJpdG1hc2sgb2Ygc3VwcG9ydGVkIGRpcmVj
dGlvbnMNCj4gIC0gZGlyZWN0aW9uICBMT0NBTCwgUkVNT1RFLCBvciAwIChkaXNhYmxlZCkgIg0K
PiANCj4gV2UnZCByZW1vdmUgdGhlICJkaXJlY3Rpb24iIHBhcnQsIGJ1dCAiY29tcG9uZW50IiBp
cyBzYW1lIGFzICJkb21haW4iLCBuYW1lDQo+IGNvdWxkIGJlIGFuIGVudW0gaW5zdGVhZCAoUE1B
IC8gUE1EIC8gUlMgLyBGRUMgLyBQQ1MgPykgb3Igd2Uga2VlcCBpdCBhcyBhDQo+IHN0cmluZywg
aWQgc2hvdWxkIGJlIHJlbmFtZWQgImNvbXBvbmVudF9pZCIsIGFuZCB3ZSB3b3VsZCByZXR1cm4g
YW4gZXh0cmEgJ2lkJywNCj4gdW5pcXVlIHBlciBlbnRyeSwgdGhhdCB3ZSB3b3VsZCB1c2UgZm9y
IHRoZSBhY3R1YWwgUFJCUy9Mb29wYmFjayBjb21tYW5kLA0KPiBoZXJlIGFzIHRoZSAnYmxvY2sn
IHBhcmFtZXRlci4NCj4gDQo+IA0KPiAgICBldGh0b29sIC0tc2V0LWxvb3BiYWNrIGV0aDAgYmxv
Y2sgPFhYWD4gdHlwZSBsb2NhbA0KPiANCj4gICAgZXRodG9vbCAtLXBoeS10ZXN0IGV0aDAgYmxv
Y2sgPFhYWD4gbGFuZSAwIHR4LXBhdHRlcm4gcHJiczcNCg0KVGhhbmtzLCBNYXhpbWUsIGFuZCBl
dmVyeW9uZSwgZm9yIHRoZSBmZWVkYmFjay4NCg0KSSB3aWxsIHJlc3BvbmQgdG8gdGhlIFBSQlMg
ZGlzY3Vzc2lvbiB3aXRoIGEgcHJvcG9zYWwgZm9yIGEgbmV3DQpldGh0b29sIC0taW50ZXJmYWNl
LWNhcGFiaWxpdGllcyBjb21tYW5kIHRvIG9idGFpbiB0aGUgYmxvY2sgSUQgcGFyYW1ldGVyLg0K
DQotIFNodWJoYW0NCg==
