Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125F3DDB02
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039341; cv=fail; b=dTo8PyIMSH0mWwI+yrcZWIjWpjbqKdHw0nnsGShIlsB+/Z79OGN7QYlO9LX+5Q5M6KErsxPTCDycxwOUk/K8nrMCYVEXtD3kX0PVQ2iPp3/c+JGatd/4UUmbmnijRxhAF1AT57XE4WknG4gWgNEkCX7yZ8c6ZP+lqtAnK9RMk8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039341; c=relaxed/simple;
	bh=mMbKLZ8gc6PC9wvgsgbzc2G9MtvwGZ3X7jUA2Bhoptw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d4SGaMRiF9IBLOJ1M+qRAlvE9ZNnD3S+gI4bjjApbvVAwlcyZL4sRUEW6fTg6P9zM+bla0vGSJYoEJ9+DT5QVsrY0DLy5WUQ66fr8Yr5dSQbAjbptXRKnMnCPfuP8uBpN0BqjMYFRfvouAevo3EivV0O8vqykm7VZ04krsdqpXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIsq6kdk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIsq6kdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787039340; x=1818575340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mMbKLZ8gc6PC9wvgsgbzc2G9MtvwGZ3X7jUA2Bhoptw=;
  b=DIsq6kdkIVT/kmHEPPfBWbU0CIarl9v9H2XaYUS0PzH+jN/twSXbcMy+
   IUdB/XtWnJejXnL2cDM2yggu4/RhJB8PUiq4S29hjYzwjhsQiz6qNr04d
   gaNtXy0RtBqWt+myNTkEjdKrhjFtwI3AxPcssb9tgGkswPu2meByaeNgc
   cR8AlRq4F7MPzQJhB3KAnUj2TTPgNvbjM5oFGQIIcNm9qnXWQU6iS9w9m
   Yz1OMq7LxYl1jOp1d5XlSuvuSl7SRXotzzhDCJ4+2yXxPfvhdyf+Ea4I/
   MDiDO21cWV825bzMTF/i9+7bb/Vu0oo3UIssEuGuWOFVk6bLU4vgMxIx9
   A==;
X-CSE-ConnectionGUID: USMlBHhpSCu5+77AdMJgDg==
X-CSE-MsgGUID: qrHFmMbRSoingG4CWvhY7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98886856"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98886856"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:48:54 -0700
X-CSE-ConnectionGUID: kqipp7saRaW484qfbZojuw==
X-CSE-MsgGUID: q2a8aJTgQnmGCzDKN0fm/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264713445"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:48:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 00:48:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 00:48:54 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 00:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mbo++tHyTtMSHJvEFxatoNEZKA57Le3+4wCtxcp0ByOW8+4gQeJXnoczhnXI+ybfd9zePv+EWaO73j+RD6O4zRSZopUUwgMnCNA0ys000PsGjYYLyyrufmhE1c9DUMMqCQxAtq+sJVLxPrtTwGDCpKPKZAfuPuE3aRGM0MRdpOReHdF0/1rkYd+BT3QoXpPZanXfx1sP3PZsj3kAQRkvaxwipt6qEQhzVlXhsSKNYagb6A7WtH6VGINHQS/30WzpICBfUJByD1dlFCMOSjU691/aFi2zFZmYgPKwd7M0onWMjqiwS8/7kQU/UpuxaQmRTlhRmNgRgd+VfiA3g9m17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMbKLZ8gc6PC9wvgsgbzc2G9MtvwGZ3X7jUA2Bhoptw=;
 b=lpvEFSNeoqlzVI9GC9goknbizby1NKBnip1TXz9iAQnqEwJU3o6UkQ4IMVQ5jLkiWbCRrOFrVC3uyPIa6t+jFbTwRMIh3w0XpHVZiC+oUxxTS858fUVXfObGJH/VfTfywmWMSYW4YkARXpeWM08+tdWxpqJNMc2NQ4X/p/dlbsMWVAokS431Bb3BTXDK2Qq0TJvLfuxZR/QOOhFJhkNzma2tcKr7t0V4EaOb2yyjXD98yw1g23bWrCVon1JHsEavSbV/7elSpGyoBrEcGWzdiN3eN/BGWUfrxk64sd9Pf724EtIpy+mfrmVzlgKg5rPmVX9yKD4XIpA678ZyoZZtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH7PR11MB6833.namprd11.prod.outlook.com (2603:10b6:510:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:48:50 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 07:48:50 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "Hadi Salim, Jamal" <jhs@mojatatu.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH net v2 0/3] net/sched: u32_change() fixes
Thread-Topic: [PATCH net v2 0/3] net/sched: u32_change() fixes
Thread-Index: AQHdKyFDbaeq7rmC8UuThcGOX+Yni7aiNXkAgAE/OkA=
Date: Tue, 18 Aug 2026 07:46:41 +0000
Message-ID: <PH0PR11MB5902885C0E23D5DEED9011C6F0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
 <ccba8112-ff9a-47ea-8b91-a732e28b555d@intel.com>
In-Reply-To: <ccba8112-ff9a-47ea-8b91-a732e28b555d@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH7PR11MB6833:EE_
x-ms-office365-filtering-correlation-id: cc9906f2-03a4-43cf-61c3-08defcfd2457
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|56012099006|22082099003|38070700021|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: aSqbSKleiHcUyPuoFYieUEvDNRdM1Q4BW13NR0gT5cTMhVL7n7TFjM6TkOaPIBB5/2p1Nb8tYfk6dBfxw0uxIDzypg1icRe9fT3pvT4EeA4AJcAquk+XPblAAW9QSWaF+pE6dvL9oEs//KEP+InX26um5nHzVN+QRweWxVUhYvCJKChxdVh0R0Qovs7IwL9kToPoIYiqluSqNKhDSAkVGcJcMhd61RefVqjpFSlA/LeeeKR6F1Aqdi3hAEt91XcKNPKpOOfSN9x5PgIPoit3B2tmfbGlfDoixFZESG17kTjFesjUCjuy3jNuCuP4R7nbiMOJkxLD7JxmFYFg9MT8XNK0ajq0f8pWfIc8SmAX8DFOuhAIPWmKTQ2KYL+n6byFL+yioWn/XJZvHWiNothj5IsqFeQZ8r/7/mxz6Rr3lxYI45YW0Mb66parQQtf84HKHnCKqoApb/KgyOASk/LmJZ6JCSSWt3gKBPBQbaCcNhDHHKg/oJSgf7u8HuNWbYf4C4jLax2ELgZ9HBaCckSjyJ0QyYokx2ak6cr/bJoW8bnh36SmxMep93T5gX2KmSXI8SCgv5VZXXal6fa49MukL6v2eO+0vSY/ownTa4EdPiTQpY70ZJSU4b4HQc2MjL6+sZGvp2SEAEfZLbpo991/bY3Ip/yWRU/69RtWc/8Fulg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(56012099006)(22082099003)(38070700021)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU9JY0xsN284RDNCVFl6YXk1Tnp5TUV6aUFCTUFja2Z2WFp6aGFQaWN0UGVn?=
 =?utf-8?B?YzhaSzRGLzFBNFRQelIydk9NK25aNTFGaWphdjlsRGh0Mk10UW4vS3Nydlhi?=
 =?utf-8?B?NnpoVDFCd2J3VjhKMTU0YS9PcDNBMDVWTHREQW9xUHNuQ2IvWC9ubDlURUFo?=
 =?utf-8?B?eWhCaGZUVVFGVk5QbTNGZUlqOGNBZEo5RW00SFlZbVZHc0haeXV4enZ6UGFq?=
 =?utf-8?B?OWIrQzBPTG9sV3NBTFEvZUtrYmx5VDBremtaS2ZEai9QeG40ZUJNd0I3RHgx?=
 =?utf-8?B?Z2gybEplZTJFYVFiQi9RR0lhL0p4OG5RbW8vSklybHRLcUdxUzVmb2VmbGo1?=
 =?utf-8?B?WUtFWXh3QjdVdGMyVE1zVG5pTzdybUtLaWEwY04wa3hyUzVsa0pZVWNSZTBa?=
 =?utf-8?B?WHRaZCsrWnlzWmpzZVRobzZoYXYrTCs3dVZPK3A3ZHl6YkMxNUxGNGpRNDBQ?=
 =?utf-8?B?SHQzTE1tRG1VQnljcW1lT3RLbVpGQ2xnaWVTUXprVHZsakV1NyszdElrNjR2?=
 =?utf-8?B?b1pSeHc4VHRPY1ZEd2hnRzVJcktvSEhnd05XeHhMR3pSeTRNQkQ0NHprTWgr?=
 =?utf-8?B?cmVyZDloUThvSmVYQzdxZVpXYXVXbUl6Z01oaHVCZ1hvUkJhZ0ZOZW0zUGxL?=
 =?utf-8?B?N2JuRWdqUklvaGt4UmNSZ1Naa283RjJjdlZnTEErYUhEbTA1VGVxeHlGbDhL?=
 =?utf-8?B?VndiNGswVGVrK0g4alhGV2RMTVBpUzhsbGtCcFFhUXRmTEQ4LzZPVW1Rbld1?=
 =?utf-8?B?MHZBYnZwd1crL3JqYkVQNnpMNUJIb1dKRWhYeHNBYXdUcUpWWWFrRjN5Zkh2?=
 =?utf-8?B?SUJIakVBWVFRUDEvL1Z1OFA3N2YyelNRS2pYQmM0MTlQaktVVjZWdzJPMnJB?=
 =?utf-8?B?eUl6NzZsMHFUTUw1Qm1iTmFRTVJsNkFUU2ZRUkJkZFIwM0NKUy8rZEhEQXpt?=
 =?utf-8?B?d09ZemVrMENuZFFJVEZacGVUaWlOUnZVZWQ3aEVBclNkZDFpRFBmZ1BvTnNp?=
 =?utf-8?B?QUFKeUV5QlZUL0VsbzdJVGhmRytoU2VsbVVCaTYzT0NwbEFWN2tXejZKc3g3?=
 =?utf-8?B?YmdBSStoVVhvOTFZNFNlSHlGVld4enlodDJwQ0xSTVdHdWZmamRYWXlpMklw?=
 =?utf-8?B?by81V0hZb0FNU3VNV1B6OFkvZHlMOGdIQndONW5UTTBCbzJXYmQzYjdEd3lw?=
 =?utf-8?B?ckdYR0FLUzZLOXU3K0dwOFR4Yzd2WE9FcjJaSC9QQWhieGo3dHZmT0VOazhQ?=
 =?utf-8?B?RlRFT0RKYy94M29SQklNczlxNW5WU0FtK29FTlJ5eXkzZUF4YVp6RDdEeGVv?=
 =?utf-8?B?MjJzbXJkc0kxazlxL0wwYjF0OHVUQ0o1SVRrZXVxamIxUnhLdXFEYnpkbW02?=
 =?utf-8?B?bERralNmZjBKSkVNZWdCR3dON2t1VmhWSHFXdXZsOFRyTFRCMjMyMEh1dmls?=
 =?utf-8?B?b3FQKzBoOE5ZaEFWR0FST0xHUmEydWViUzc1b3B4bnNybzQyQndjRzNoL05C?=
 =?utf-8?B?c0JCSzVCYm01aXlTdS84VTdJQWg4SlhRUHNUM1lTYVMwbkM3RFJNMXRQcHNy?=
 =?utf-8?B?a2RJU3AwZktzOXRESzRmUjE1UEdHQldjQWw4dDhMdWw5bmRsWlRlYisxSVFv?=
 =?utf-8?B?NXpzdWlDVkkwWTFxWHR5WktBL1gxaUNlbFVXMGluWlJyZ1ZzTkRGbFdDN0F2?=
 =?utf-8?B?QW5NV25XZjlpNGhkbTVVTUpyMlNKT3lQV2lvQmVla3VsOUZOQ3NkM0RLYjRI?=
 =?utf-8?B?Q2VhdzRvcmNnY1hocU5ZTGpCbkNNZ2l6aW9hRm81Rm5PRG5YdTBMRFZoMEJm?=
 =?utf-8?B?anR1YWppQXBvL0JaRXNGY2FacThIVUxmOUhMWkdnTEljQzE4ay9DMkR4Zmh0?=
 =?utf-8?B?aytiUmRZMlowc2ZKdDdublNRWXRVVVVyaDRxMlFyMThWeDByeDFHUUdZQXRv?=
 =?utf-8?B?MWF4ZitVK0d1aG9BMDl3RkpDaTJkNGhHVFpEcXg0VHRxeDMybDVDSlhEUlFR?=
 =?utf-8?B?S0hFQnhwNElubFduS3diUHRPMkhERTFSTVJqU3lzNnloSGhoUmthdnpiTTZj?=
 =?utf-8?B?OEV2ZHdScVBIckpMRkdLQkFsTUplMTRjYTRyd3M4UW5zRklFRVB6WEtLdjBL?=
 =?utf-8?B?ekJ3S3pGaElxMzFUd2NnaGtpYVhXQVRjNmNRVG85TEgzNHJVczh4SzJKVlBu?=
 =?utf-8?B?ZnZ3T1psTGpxWVBUaWt0OHNEV2xkRFhSTnpSaVJKN2NyMDNFQmRTZE93N0JK?=
 =?utf-8?B?NE0wUVVqZ2NMcERUQzBUY3g0UnpBMmRDYVdvZzNlNEtub29vQUdzQlJRWFFy?=
 =?utf-8?B?amprVDNRejNCRlRvbm1uSURXNkJhUzlGTDdwUHVFdmRISnFxRjlEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XcDvtQdh8wljlEjWvwUs1eGvDZ+Z3Cyj1cIQFGSnSmctpVoQzGbZWfBOLAviBx6qo7k2ur5iCu209W15dKSHisTFf+nc2xOY59IjVPFtnZMSmYPCVRfrs9Tr+bdKILKhAHbl6wNJaozThZ5Ee3VV0hlp9W09J6vaT59TiuNPUFrGtHqpa/dJpT658qRUCyCLrV/zL/4tdVVK6ROWVwgpdsYupwzuUYmaIJ3XmwxhwSn9JZRTslQJn9jXPUXsARHgAX/Qhz9Gm2qINEtBXaroidJxoBJpD17xvcHSnw8yamCIPrmT/AQl58DkOhgn5HjLRkX06nD8pnMxebBU9nbp0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9906f2-03a4-43cf-61c3-08defcfd2457
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 07:48:49.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlYjBJNXK1YdSGISn2DDLWSdVSjzXex82K3R7hP+rqpTkKXTyffY9hrfAGbPBGG2gBky+mS/ieojjeFgzgpV1mRdJxwQiykLwjnil/b8PdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6833
X-OriginatorOrg: intel.com

PkZyb206IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
IA0KPlNlbnQ6IE1vbmRheSwgQXVndXN0IDE3LCAyMDI2IDI6NDMgUE0NCj4NCj5PbiA4LzEzLzI2
IDE0OjIyLCBKZWRyemVqIEphZ2llbHNraSB3cm90ZToNCj4+IHNvcnJ5IGZvciBzcGFtLCBwcmV2
aW91cyBzZXJpZXMgZ2V0IHRyZWF0ZWQgYXMgaW5jb21wbGV0ZSBzbyByZXNlbmRpbmcNCj4+IA0K
Pj4gQUxSRUFEWSBPTiBORVRERVYsIFNBU0hJS08gUlVODQo+DQo+aGVoZQ0KPm9mYywgdGhlIGFi
b3ZlIGRvZXMgbm8gaGFybSBoZXJlDQoNCjpEDQoNCj4NCj5mb3IgdGhlIHNlcmllczoNCj5SZXZp
ZXdlZC1ieTogUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0K
Pg0KPi0tDQo+DQo+U2FzaGlrbyBoYXMgZm91bmQgb25lIG1vcmUgKnByZWV4aXN0aW5nKiBidWcs
IHBlcmhhcHMgaXQgY291bGQgYmUNCj5oYW5kbGVkIGJ5IG9uZSBtb3JlIGZpeCBpbiBmdXR1cmUg
c2VyaWVzPzoNCj5odHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA4MTMxMjIyNDIu
MTY5MDAyNC0xLWplZHJ6ZWouamFnaWVsc2tpJTQwaW50ZWwuY29tDQoNCnllYWgsIGkgc2F3IHRo
YXQgYW5kIGkgdGhvdWdodCBhYm91dCBleHRlbmRpbmcgdGhlIHNlcmllcyANCg0KPg0KPiA+IEBA
IC05MzgsMTQgKzkzOCw2IEBAIHN0YXRpYyBpbnQgdTMyX2NoYW5nZShzdHJ1Y3QgbmV0ICpuZXQs
IHN0cnVjdCANCj5za19idWZmICppbl9za2IsDQo+ID4gIAkJZXJyID0gdTMyX3JlcGxhY2VfaHdf
a25vZGUodHAsIG5ldywgdXNlcmZsYWdzLCBleHRhY2spOw0KPiA+ICAJCWlmIChlcnIpIHsNCj4g
PiAgCQkJdTMyX3VuYmluZF9maWx0ZXIodHAsIG5ldywgdGIpOw0KPiA+IC0NCj4gPiAtCQkJaWYg
KHRiW1RDQV9VMzJfTElOS10pIHsNCj4gPiAtCQkJCXN0cnVjdCB0Y191X2hub2RlICpodF9vbGQ7
DQo+ID4gLQ0KPiA+IC0JCQkJaHRfb2xkID0gcnRubF9kZXJlZmVyZW5jZShuLT5odF9kb3duKTsN
Cj4gPiAtCQkJCWlmIChodF9vbGQpDQo+ID4gLQkJCQkJcmVmY291bnRfaW5jKCZodF9vbGQtPnJl
ZmNudCk7DQo+ID4gLQkJCX0NCj4gPiAgCQkJX191MzJfZGVzdHJveV9rZXkobmV3KTsNCj4gPiAg
CQkJcmV0dXJuIGVycjsNCj4gPiAgCQl9DQo+VGhpcyBpc24ndCBhIGJ1ZyBpbnRyb2R1Y2VkIGJ5
IHRoaXMgcGF0Y2gsIGJ1dCBsb29raW5nIGF0IHUzMl9jaGFuZ2UoKSwgDQo+dGhlcmUNCj5hcHBl
YXJzIHRvIGJlIGEgcHJlLWV4aXN0aW5nIGlzc3VlIHdpdGggaG93IG1hbnVhbCBoYXNoIHRhYmxl
IGhhbmRsZXMgYXJlDQo+dHJhY2tlZCBpbiB0aGUgSURSLg0KPldoZW4gYSB1c2VyIGNyZWF0ZXMg
YSB1MzIgaGFzaCB0YWJsZSB3aXRoIGEgbWFudWFsIGhhbmRsZSAoZm9yIGV4YW1wbGUsDQo+MHg4
MDEwMDAwMCksIHUzMl9jaGFuZ2UoKSBpbnNlcnRzIHRoZSBmdWxsIGhhbmRsZSBkaXJlY3RseSBp
bnRvDQo+dHBfYy0+aGFuZGxlX2lkcjoNCj5uZXQvc2NoZWQvY2xzX3UzMi5jOnUzMl9jaGFuZ2Uo
KSB7DQo+ICAgICAuLi4NCj4JCX0gZWxzZSB7DQo+CQkJZXJyID0gaWRyX2FsbG9jX3UzMigmdHBf
Yy0+aGFuZGxlX2lkciwgaHQsICZoYW5kbGUsDQo+CQkJCQkgICAgaGFuZGxlLCBHRlBfS0VSTkVM
KTsNCj4gICAgIC4uLg0KPn0NCj5Ib3dldmVyLCB3aGVuIGRlc3Ryb3lpbmcgdGhlIG5vZGUgbGF0
ZXIsIHUzMl9kZXN0cm95X2hub2RlKCkgcmVtb3ZlcyB0aGUNCj5tYXBwZWQgSUQgcmF0aGVyIHRo
YW4gdGhlIGZ1bGwgaGFuZGxlOg0KPm5ldC9zY2hlZC9jbHNfdTMyLmM6dTMyX2Rlc3Ryb3lfaG5v
ZGUoKSB7DQo+ICAgICAuLi4NCj4JCWlkcl9yZW1vdmUoJnRwX2MtPmhhbmRsZV9pZHIsIGhhbmRs
ZTJpZChodC0+aGFuZGxlKSk7DQo+ICAgICAuLi4NCj59DQo+Rm9yIGEgaGFuZGxlIGxpa2UgMHg4
MDEwMDAwMCwgaGFuZGxlMmlkKCkgcmV0dXJucyAxLiBEb2VzIHRoaXMgbWVhbiB0aGUgSURSDQo+
ZW50cnkgYXQgMHg4MDEwMDAwMCBpcyBwZXJtYW5lbnRseSBsZWFrZWQsIHdoaWxlIGluZGV4IDEg
aXMgZXJyb25lb3VzbHkgDQo+ZnJlZWQ/DQo+SWYgaW5kZXggMSBpcyBhbHJlYWR5IGluIHVzZSBi
eSBhbiBhY3RpdmUgYXV0by1nZW5lcmF0ZWQgaGFzaCB0YWJsZSwgY291bGQNCj5mcmVlaW5nIGl0
IGhlcmUgYWxsb3cgZ2VuX25ld19odGlkKCkgdG8gaXNzdWUgdGhlIHNhbWUgaGFuZGxlIGFnYWlu
IHRvIGEgbmV3DQo+aGFzaCB0YWJsZSwgY2F1c2luZyBjb2xsaXNpb25zPw0KDQo=
