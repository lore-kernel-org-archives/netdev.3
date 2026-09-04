Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313019CCF7
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494880; cv=fail; b=F7z8QjCfAy3TU2kkgCT2AK0SVh1z9w5FLIHZs/VtFfkKS36hE5i4lRnS1LMA6x5HsI36NLuNmqvlmBvunWxHpASGqWOosgxStv98irv1oE4xRtP5Twbpgnu3ZiVSUlAIVHuKNh8dcw4GBv6ycqOSR9B/aw+BvT+49J7dF4cOJfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494880; c=relaxed/simple;
	bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVx+xWmhEDoc3HmMBV0LaG7hkGzH3U9oDWtFd0BT/cz7a3A5c0xWjeZWaX6/Hr56Ifr99qxlA7pqU5yEdameTENtvmTWXA/iprUBgk9iMxuMwvQeOmP1QtI0S7A6SMI+oZlWHKnL9krIFdvjbP7fkAN4FlsnMU3tPL2KbjdZlII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/3YO13s; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/3YO13s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788494878; x=1820030878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
  b=i/3YO13sbfVy1dXJTrE+cCewJPJYnFsK4CXuXjyfz0FiN870Xe0d2ZvG
   7ZJjPVHJTd2vGoec8GHBpwVpDfKkZKHZ+JALJ0YQc9br2eawzAMjlZE0f
   RNDYouxDtmru0qGZnsYJEJeSV2p0csKU7TGflgnFfjKZo6fEmti7gErVH
   wREuoP1OFUXVzGcObgkZZDRm3CzNAawhrRvxXKors6gRuTwFxENh3iEGW
   1LpGsmjfa87lsmurbvpImuBTEhlipS+JH9VX9JlQIiezU792zx38AoChK
   8yKASxg/eqVSZ2X62Y2T4w+3SZEoQIHoQjYzDmwul7kru+ehts94lluhg
   A==;
X-CSE-ConnectionGUID: Y9bR3+V1QQWJGN7VS5M96Q==
X-CSE-MsgGUID: c5HCEL2fR7ea1O6q+MjSxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92810594"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92810594"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 21:07:57 -0700
X-CSE-ConnectionGUID: IGous+3vStaBOCawgfMxiw==
X-CSE-MsgGUID: OKwUumyYSK66+NeHgI9oZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="267353109"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 21:07:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 21:07:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 21:07:56 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 21:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnMIHA6nCoCCXRAXxtyJ1btXoL8EZnj9XrV334dnkSRZM+XQvSNFkZeif6Aky8pOBANDQ7Rag7AyPM+7lzxw/5ouwWG6K2Y6K7Q1SrWUIxEAQnVWanvarbjJkn2spWlDapgsHhMLBXTH0hpHOSTvdRbKkUz0m1VBykAueFnt3icgQkh7+9xVe8jif49Y4NjBvjALTEDNWLKd8hbXQ/b0MR3BHEf3juGMMkq4KMYpviEwywRoHnD1Cggl+1KugSozXx/aX5PSpCjX5TtCQ8UcOdwEzplX2RASy7stdfGwkt5cVeXGwaeZ8Hajot4WCSn99UxOMx4mFcLozJki7LtnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH66Kw97LkSc/JhHo7hsKSK/O/fbbHfK8chaemmOLHM=;
 b=cRxKXHTyODQN8lSoDHy5aYxhD12P+QOqBw2GtFGIuQuPK9R+xZ+mtyZuF6eQPtpbwgCjv/8J+PaAghx+BhnbkhdnYJ7NnNgqp8YosupTOoZplIZEqNToFsJ+92KHDV0VmbQbQXxU7bvBrxataw5Jg8bjxeG74WLOmUwhgWq+66VNq7fAGCyJWKJEDMU6QArLJxKJPYeIvdeGJzjTWuitYUNLx+jWJzOTTac+CBS6DqahmqQ3h6Ssen5eN5323duq4H/kbut3y8LeEaBfDv0cNhio0PRL8JGHFS0voF0R1ju80nS3VoT5ri4+P4T6m6UV/PJD1c7yBv17dhpKpWpQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SJ5PPF44E8B88DF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::825) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 04:07:53 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 04:07:53 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: add missing xa_destroy
 for sched_node_ids
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: add missing xa_destroy
 for sched_node_ids
Thread-Index: AQHdDZ/NiHO8ub9xIkC7qDePsCqj+ba+J+dg
Date: Fri, 4 Sep 2026 04:07:52 +0000
Message-ID: <IA1PR11MB6241B517D4B56D94932C3FFF8BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260706-jk-fix-missing-xa-destroy-v2-1-b83b0f02beef@intel.com>
In-Reply-To: <20260706-jk-fix-missing-xa-destroy-v2-1-b83b0f02beef@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SJ5PPF44E8B88DF:EE_
x-ms-office365-filtering-correlation-id: bb1e46fc-93d2-452f-dac5-08df0a3a179a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|3023799007|6133799003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: hFk3uQ7SVz33u17Wc2KPJxn/kzeyWIDm7Os3YGYWAkZZpy7wx1bf5n3OWxMxhL9ypxI/ilSRVi/F55e6rb8dXxTMskzVCmULbEuZxHTINkc7wPjHa7BrcFW5oyG6YRpLGt3II3NRx0oZ228iaNTU+GXjq2n0Asvfj0sy+bZmg4alWS26DuiQEs2opv/zgngcCyukX6aHHHFUqmtfk0SiavfHzmzQvYWfAa/mGcd3SEMCJnK4wR/KqBKMjCuXIMwN7Zt+RFUIPoEgiU7ekixzuA1djWAMnEzZ81h87BAarEK1dVUEBU71uRQNnNlbgMSyGNUEwl9FdYdepGgBfHibYdUg7Jw03CwgpqQ7Fj0biVdmn7Mf0u4i/mevMzzAKLk4Y7lM2jgYHTRTMW4e4oxO7mN4yyYx1yxL6nKseBH+jtmz9OqZ3FQOyYBnII93azrMlEY7Cv2RnC8sZVUOCdRlicKMoow5tznIqAWTths6AVDuKXxmjRXkQnEVix+xyuT9evjkds2WRBdiwSi9r8ih5nmda631tv2hoBCdChIEN4ONNNrJH7ARKIkct/LSxDA1cj6RpsEsVTdg1p/OTvs7/jxbe972jzTLfAA9Dvi0roxvNqWcTnntAOrHwhwsznoMaPGoFyVEoIEo6vXMRhh5pqxsu4jOD80LIhJrfqmoxs8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUx3Vmw4NzJhTm1senlCc3JLQlFydWE5RzNFVjlma2NSWEh5MEoyQSt0WXRZ?=
 =?utf-8?B?NWdFRjdiSEk5a0JBZ3Mvd3dobm16a2tITlBTMmlLMlpCMld2Y2tJbVduSlM1?=
 =?utf-8?B?czl4T3BvUThQcVhTekNSNVBHNGVka0tTWVA2TExqUmp4cXEwVVV1aGE3dWpw?=
 =?utf-8?B?MHY1dHltTFJQRklIdVlERktFQ1lNNStZNCtGS1RQakJPY1dHeElldVl6cVQ0?=
 =?utf-8?B?L3R3Z2JjRFJtTU1UVjFURFNUTHJ3WjZzRnF6bzExRXlDQTlRMlQ5anhhTm5I?=
 =?utf-8?B?VmlLU3Y5R3VIYzIrajF3TTgycXNzY0FDZlZnL1VqZ0FFQTdWZ0pMRnBVZUlB?=
 =?utf-8?B?S2dQY1NMWEMzSmFKSWxtYm1wWHEza0FVNEpLN3hNWlVINEg1UTA0dlA4WTU4?=
 =?utf-8?B?eVk1Qk5SN01EVFcxdUxLZTRkMjhKbERjVFF2b0pGenk3TTRnL2o2L0c3TXo5?=
 =?utf-8?B?ZXRrNlM1cm1NZzhETERuZmoxaXRKU3JxOEJnSXZvcnF5V1FPN3pzNE9EN25u?=
 =?utf-8?B?YjhHTTZtQ01mZ1hab1V0YWE1SG52b2QyMUZOUEpyaTdZc0VtZlVaSk9WYm5x?=
 =?utf-8?B?SDg5d3U3Mi9SUUw1bW1IeVRTMFlickxmWTZjNE9hNno3Qi9QVGlBY0RyTDhZ?=
 =?utf-8?B?bVFMdUVZZ1FGU0RJT2daN0JhU0ZsaGxLMUF1TkxML0JxOStyc2dkenJJV1NC?=
 =?utf-8?B?K1I1T1p2K3czM2Z5MnB2VW1RTXdCUkFtdXFJd2JCMTYxUy9seENHSXpmNU9I?=
 =?utf-8?B?MTBkUDNsZG51UENVYkJ5NWNFRS9XYmpxVkFRU3FTQ2ZEL0s5U25wRG9wNnhh?=
 =?utf-8?B?Y2I5NENIYWtrdzlWeFUyMzZVZkEvR1FlTWNieURLVm9ZMVZ6NmJxRWdldzFa?=
 =?utf-8?B?eW1lSko5YTVpMWIrWHUwQ2pmdDVpSnVsUVQ1VjFieFRvL2hSLzlBVFVGd1BT?=
 =?utf-8?B?U0tGTDd4SVRucWREbnBwbnkrZ3l3cjVNcHdGeUxUTEJuVXhEd0lHYTN2QWUx?=
 =?utf-8?B?SnhaNVpnY2RubkpvZDN5OUpnRVRScnNVb2hsWDB2OWQrV2ZWQXl3WTU3OHNR?=
 =?utf-8?B?dXJ6eFJITlIxYlFzU3RSWWJ0S1lYSWNocWhOOEYyVzJCYnZZK21jMHVZdTZC?=
 =?utf-8?B?UFJJTDFIRXdFdFlaelRFRzU1dGZXVVA2MWUxd1N0ekROZ041Q3V1cVRJQ2Iz?=
 =?utf-8?B?ZU00aWdsNlQ4dDNseVovQjJDMjA1dy9DeW94eUZyMG9zWGJzRmV0RmgzellQ?=
 =?utf-8?B?RDFGY25QMlF4MkF1TkU3c3A0NFMra3FiUFloaWhpYXpxREdKUys0NE9VbTZB?=
 =?utf-8?B?R1d5cWtUV01FRE1kRDlpTXJjSFhVMmdoNHB4blFGYlBVaFJEWWdkY0dQdVYx?=
 =?utf-8?B?R3FBODJmbE9idnM5aWV4MmN5NFU3ZEVvWWdpL1c1YlZPcXBsNmRlSXZ3dC8x?=
 =?utf-8?B?WnZUdEFLUEZEK1NhMHFQN1BXUEowQS84UElKeTNKK0t0RVUyQ29HeWtlZWxQ?=
 =?utf-8?B?VWE1YkowazA3K21mc0d6S0RPN3hhZ2JBbVBtb3BIMk9FbkQ1Rk1GUHkvbUZn?=
 =?utf-8?B?S1ZKajJIQjJ4U0gvVmhvZDBtVkFsbVhBRmJFdTRSTUM1MW5DWENxdVhycjB6?=
 =?utf-8?B?WTVpTnpON0d4WERYbzZ0WnVpUURWN2NHTE0rNU9tcUcrenNKbmlXemh1aU1i?=
 =?utf-8?B?ei9PZFJrcE1DR3ovenNIVS84R2tMbmMzYzZnQ2hRNmdOb3h4ZllULy9aNlZS?=
 =?utf-8?B?YzFwZkZHeVoxS0pwcXZveWVPMFh1L0xYK2dBb0dlc295V1VNQWNZNGo4N05y?=
 =?utf-8?B?UkFhcE5VemQ2OW5Ea05WaS93RHdNOUUyRk44aCtaOXFGTDFhcE15V0ZMTEpy?=
 =?utf-8?B?QVZlNHZBbUd1Qis3bExiTDFlb0NjcVNMdEZ5UXpacnAyZDVQOVpuMEI3QkRQ?=
 =?utf-8?B?aHVMeWh4Y0hWbFZDRkoyK2s2L1JvSTltbmxFaVFKeFFvSU5oUGtiSkF6VG9Q?=
 =?utf-8?B?Q013SElsUXhSOWFuenppRjRJTWFHR2g3V3JSaldnT1lLN2RWSWVDbUxjL2Zx?=
 =?utf-8?B?MGM1OUNUREdkMlZoZmx3L2l1ZEpOVFZFWkpFenlXcDhlemh5VmpsZ2F3TGlE?=
 =?utf-8?B?bmljVHRkSkg3cGRzOVRsTWlCYkFqNVlIa1EvRHFVQU9Yc2FaZXRJa0xWZUVW?=
 =?utf-8?B?RXZlMlQraW94QjFiSlVjYXNkQkxVTSt2Um9MNUQzMkp5UUZULzlJSW9HUDho?=
 =?utf-8?B?OVhVdFBqWnJYbFV4MWhRelVMTm1qejM1cmdxVWJwR1pwS0UzN1FOVnVVUGpN?=
 =?utf-8?Q?cPo/dJ7PXeRCpL5CUk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0kN6BMGaw3PADqVI2uba/2uEFQ0VHWQ4xkFerYgstWKHNmO/qx0EqXOdZlHNC7tjVzqma+unqAWlZBGmpVDxrZt+TkFn0pSJhGGeBJ1dzOVWchaqD0S2DDQkMQw5HNsmZ5ZxXQlJ7pW6+tQDceBKGw1eYdT460RaiGbesTKfz6b19afA2cgYQRMDYz+8Vrkht8vyXxjJ7qpPszLOWv83WiRVoq6j2U03Sf2tCXe/z/mjZVmEGiLZp7aUlOIqThx3pIKXK2Ym3uSlQkDB0VTr4/5gHDlCS231bGLs0Nvc2+n9WAVm4Y7rYfxFZt66Fz0CNTFTMpB4PF76ANZ6YBGxDQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1e46fc-93d2-452f-dac5-08df0a3a179a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 04:07:52.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwjuoNBdq2S2sKWp9kJTtDVdyglbCRUlJmlUBKsJmtadr1U3xSTcbNHIwR6yea9qt+QLToAL2VpYHq3KKwH10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWNvYiBLZWxs
ZXINCj4gU2VudDogMDcgSnVseSAyMDI2IDA1OjAxDQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9z
bC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5r
ZWxsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXds
LW5ldCB2Ml0gaWNlOiBhZGQgbWlzc2luZyB4YV9kZXN0cm95IGZvciBzY2hlZF9ub2RlX2lkcw0K
Pg0KPiBDb21taXQgMTZkZmE0OTQwNmJjICgiaWNlOiBJbnRyb2R1Y2UgbmV3IHBhcmFtZXRlcnMg
aW4gaWNlX3NjaGVkX25vZGUiKSBhZGRlZCBhIHNjaGVkX25vZGVfaWRzIHhhcnJheSB0byB0aGUg
cG9ydCBpbmZvIHN0cnVjdHVyZSwgYnV0IG5ldmVyIGNhbGxlZCB4YV9kZXN0cm95IG9uIGl0Lg0K
Pg0KPiBTaW5jZSB4YXJyYXlzIGNhbiBhbGxvY2F0ZSBpbnRlcm5hbCBtZW1vcnksIHRoaXMgY2Fu
IHJlc3VsdCBpbiBhIG1lbW9yeSBsZWFrIGV2ZW4gaWYgZXZlcnkgZWxlbWVudCBpbiB0aGUgeGFy
cmF5IGhhcyBiZWVuIHJlbW92ZWQuDQo+DQo+IFRoZSB4YXJyYXkgaXMgY3VycmVudGx5IGVtYmVk
ZGVkIGluIHRoZSBwb3J0X2luZm8gc3RydWN0dXJlLiBUaGlzIGFwcGVhcnMgdG8gaGF2ZSBiZWVu
IGRvbmUgYmVjYXVzZSBpdHMgdXNlIGlzIHdpdGhpbiBmdW5jdGlvbnMgdGhhdCB0YWtlIHRoZSBw
b3J0X2luZm8gYXMgYSBwcmltYXJ5IGFyZ3VtZW50Lg0KPg0KPiBIb3dldmVyLCB0aGlzIGNvbXBs
aWNhdGVzIG1hbmFnaW5nIHRoZSBsaWZlY3ljbGUgb2YgdGhlIGZpZWxkLiBUaGUgcG9ydF9pbmZv
IHN0cnVjdHVyZSBpcyBhbGxvY2F0ZWQgaW4gaWNlX2luaXRfaHcoKSB1c2luZyBkZXZtLCBhbmQg
aXQgaXMgbm90IHJlbGVhc2VkIHVudGlsIHRoZSBkZXZtIGNsZWFudXAgd2hlbiB0aGUgZHJpdmVy
IGlzIHVubG9hZGVkLg0KPg0KPiBUaGUgaWNlX2luaXRfaHcoKSBmdW5jdGlvbiBpcyBjYWxsZWQg
aW4gbWFueSBwbGFjZXMsIGluY2x1ZGluZyBkZXZsaW5rIHJlbG9hZCwgYW5kIHBvc3NpYmx5IGR1
cmluZyBERFAgbG9hZCBhZnRlciB1cGRhdGluZyB0aGUgVHggc2NoZWR1bGVyIGxheW91dC4NCj4N
Cj4gQWRkaW5nIGEgY2FsbCBvZiB4YV9kZXN0cm95IHRvIHRoZSBpY2VfZGVpbml0X2h3KCkgY2F1
c2VzIFNhc2hpa28gdG8gcmFpc2UgbXVsdGlwbGUgY29uY2VybnMgZHVlIHRvIHBvdGVudGlhbCBv
cmRlcmluZyBpc3N1ZXMgYW5kIHBvc3NpYmxlIHdheXMgdGhhdCBwb3J0X2luZm8gY291bGQgYmUg
YSBkYW5nbGluZyByZWZlcmVuY2UuDQo+DQo+IFRvIGhhbmRsZSB0aGlzLCBtb3ZlIHRoZSBzY2hl
ZF9ub2RlX2lkcyBvdXQgb2YgcG9ydF9pbmZvIGFuZCBpbnRvIHRoZSBodyBzdHJ1Y3R1cmUuIEFs
bCB1c2VycyBvZiB0aGUgYXJyYXkgYWxyZWFkeSBoYXZlIGEgcG9pbnRlciB0byBodyBhbnl3YXlz
LCBhbmQgdGhlcmUgaXMgb25seSBvbmUgc2NoZWRfbm9kZV9pZHMgcGVyIGFkYXB0ZXIuIFdoaWxl
IGhlcmUsIHJlbW92ZSB0aGUgb3Zlcmx5IHZlcmJvc2UgY29tbWVudCBleHBsYWluaW5nIHRoZSBu
YXR1cmUgb2YgdGhlIHNjaGVkX25vZGVfaWRzIHhhcnJheS4NCj4NCj4gQWRkIHRoZSBtaXNzaW5n
IHhhX2Rlc3Ryb3kgdG8gdGhlIGNsZWFudXAgcGF0aCBhbmQgdG8gaWNlX2RlaW5pdF9odygpLCBl
bnN1cmluZyB0aGF0IHdlIHByb3Blcmx5IHJlbGVhc2UgdGhlIHhhcnJheSBtZW1vcnkuDQo+DQo+
IFRoaXMgd2FzIGNhdWdodCBieSBTYXNoaWtvIGR1cmluZyBkZXZlbG9wbWVudCBvZiB1bnJlbGF0
ZWQgY29kZS4NCj4NCj4gRml4ZXM6IDE2ZGZhNDk0MDZiYyAoImljZTogSW50cm9kdWNlIG5ldyBw
YXJhbWV0ZXJzIGluIGljZV9zY2hlZF9ub2RlIikNCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2Vs
bGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIE1vdmUgc2NoZWRfbm9kZV9pZHMgb3V0IG9mIHBvcnRfaW50byBpbnRvIGh3Lg0KPiAtIExp
bmsgdG8gdjE6IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDUxNC1qay1maXgtbWlzc2lu
Zy14YS1kZXN0cm95LXYxLTEtZGU0MzdiZjUyMzQ3QGludGVsLmNvbQ0KPiAtLS0NCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV90eXBlLmggICB8IDIgKy0NCj4gZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb21tb24uYyB8IDkgKysrKysrLS0tICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3NjaGVkLmMgIHwgNCArKy0tDQo+IDMgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPg0KDQpUZXN0ZWQtYnk6
IFJpbml0aGEgUyA8c3gucmluaXRoYUBpbnRlbC5jb20+IChBIENvbnRpbmdlbnQgd29ya2VyIGF0
IEludGVsKQ0K
