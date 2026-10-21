Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792571328;
	b=NA2L9A/fZ8wrXjG0uMr3npKVvUOzYHReKyVXV1fqutW8yDv4zZxLBbLUyLTvzfOPrFSS
	 BWUXUn03mBCi1L0jX9bUiqlCK33H+65k2xqIoZGuvLATTsGH8diOziSQYgV1dABShc2FH
	 B35K3YwG9BVwC2rUTrp1NoHxuYCFosAl/cXBrW/FsKHR4FJwL/5PQkxEZ+rVXthdZ2mQL
	 PeZc15bDoQSK5+QaeoPUNFgGd2Ic2234weX5pG6K91N7Mee0Xh/YNrm1Ln3aPAcGOZswL
	 pM8iZTqBhGEB3+v3ViU81Mcy6YXOH7p3jk61Te8kq7BkIVRgGNrQjWCUVHxgPKMYpAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571328;
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
	bh=/d/PaExSBz+KuQJSdGOTExs5djgalmHcjpxgX77j6IY=;
	b=uXSdKdhp5RNJsjsrEY8VaPBz+E3B0VDNJ9ltCA3mswUf1MEsT9WmOO5rTn9XHzOdvqJE
	 S4LDjPAD1t9pN0ghi6bR8ywetjP0uTEctipVedYF3o50Kw5z/eXWpEp5ToaVkfraZ1V+Y
	 3wVsu5JCiBJaYdYamrK/4+HJ13DA7cMYMshYY8go4bhdFXzlEw4P/RV18jkmrZ5w0y3oC
	 BlC+q+M/mBTKvlF4W74iS6uCe5xZlUS2VKGRAIoZ0cbM2ZTGcqn/shM6c3O/OcoDAtTlW
	 y0vOZBi9pW9CRmArD4Mbg7DeDoovbBCFgd2pgkKd4GIspoyJuP0/DVWT9f2/ExwPsIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VayDRoX9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A59606A319;
	Wed, 21 Oct 2026 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A59606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VayDRoX9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792571327; x=1824107327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2VfRhkvvlt7FzYnbPgJM8/W8GWhmxCQTiouJ/nRPK0M=;
  b=VayDRoX9Xdlis0xXiGHg0LJ/MF6igyrk/QEwS1OlVv+mc6xyt//6laFN
   1PYOjq4DJszHfwEkwRSLMukliliO2kluBWL/3wrfxU6K3BkMjBGVIQy0Y
   qzW8UIlB+Sp5gWs5Z5hMbxY7wk9Zea5zBPSjRf9Y/lywkKbTp6pdPvk9+
   jRLef5wjNfxCQFdcEiplGN123xRe+yofi+LLYD8JmZ1FskAtFvDrLdo6t
   He2Ryw9BUPla/DJdpKQHgyyQrOWM6x8ST+Sob8Eff5DkXiKeYBc8n04z2
   CE7aDKIi706oihSUbCd7JSd9AzMUQa9B4VdhSdr923THuK3lXobQtH8k6
   A==;
X-CSE-ConnectionGUID: YD+YP8WvSeOI7pOuJq41Eg==
X-CSE-MsgGUID: fbhOcFZNQ9KiMNYtc+ndLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1389489"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1389489"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:28:47 -0700
X-CSE-ConnectionGUID: XRdkRAAITxKwtXOIUZrlhQ==
X-CSE-MsgGUID: OuGmg4qfQ7CFCIcotBOYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3349937"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:28:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:28:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 01:28:45 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meGzBcqlJGZlK0Xz9yegPTqdQ/N2TgIkkXVL39f+LPozKo9NbE+Zo1O0hJE0bua590HSjcpRqAWt4EKbdiGQDuZRHPmR8CdD+vXGsFx3Y5yHM1bcMQfaaLM0oIvKkKtqzItYXMH5T7GNZAGaepQy/yzQ/GWK+Rsv58556oHcU/AG2eTxbL55Hl+xn2aXRZpUxNUHfrawW4izQM+hSHdbplQKeYUqqqCuYJ90maFKwew7KGex89zhlMulwCRBffA2LtmZdAXAPybKot+fmGBAmDUIoMrn+GoJSu+b2UhInTu+qYrXQM/pZSQE5NTfvNN2ryignI1sWOVc/nq23pb9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d/PaExSBz+KuQJSdGOTExs5djgalmHcjpxgX77j6IY=;
 b=a6PbmDxlHJELQavOW6L1IAutjq3qS/c8Xdveztu07ObmVImqXFzhL9GxYX42tVVeopPsqDxsX3GNzyAxD49gkQK+ZY0k8M8RSYars/YkFHX6WObyh9qyY/4NIvgmDgrc5TegMS7ZP7C74k3LTrKdpfNA6wySIl84OfebN6QW9FfgrFhjM7YKY4wFBg79RdI2Qw7gt7RgCHCCwlbW7bVvTz4WOudJp5QM8QEma2HFVBSH03TnUvmbrCy8vZ57cnGlgeM4Ydr9AS5KKss1VIzzRmuievEqUyNiG41VuamCo9kURpi0dI4XtDD1H2ATzokuXafuYvC5kTEF7+uN8XNJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ2PR11MB7455.namprd11.prod.outlook.com
 (2603:10b6:a03:4cd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 21 Oct
 2026 08:28:41 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:28:40 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>
Subject: RE: [PATCH iwl-net v2] ice: do not report success for a VF setting
 that was not applied
Thread-Topic: [PATCH iwl-net v2] ice: do not report success for a VF setting
 that was not applied
Thread-Index: AQHdYTQgCtGQCjUcMk2K9iMmiqUzjLcHqbrg
Date: Wed, 21 Oct 2026 08:28:40 +0000
Message-ID: <CH3PR11MB566895F4CB40E7FD0003BC73B8E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261021081248.261762-1-xiaolinkui@126.com>
In-Reply-To: <20261021081248.261762-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: 4397ade1-4e4f-4e11-506d-08df2f4d4fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|921020|38070700021|11063799006|56012099006|261009223027099003|10067099003|5023799004;
x-microsoft-antispam-message-info: LIe/h1nkLPUqRGIGBygDhMnLOy9lT84OtROBQJIYOQCHNDJxn99g9wKqGV53TvrYxjLvnFxR6/oucI2dZbGVUkQkppFWfag96P1pKCLsYMLvdyMyKlr9PYfROX+ZtfC4SejBKv9Fms+khl7AXmBrTrHJPs+YuZH3oPFK9qPf1GCBB89/SBNN0AfQiKQvmXSS1UzNRNWkHO2oAOH41yVxbBpvcL+ybjjR7AuBD6kLdqTWV74o+PWclj7cM1ZfGDY/3VtbgUpriejvrZFr+htptDJfpCMg+xbIHiq7BpBLGgbS8wd8X0u6+EahaMU0lryyRQIEbAxgplnkvYvqY2nzUwazCfruVTMhsTmPO+orTNxA/ltpWBdHQ6jSWZxKry7Fl8sduuQa/UydH2x1mBb6eslrF1QLTx83k8mS0SA92PmCG8bhyCLvrnFaCPcdIze2yzLPWiEnfpkX/kZbbwm5YmsWV1Q2raM4cU1mZH1TiN51GU/zbVqH0JORaLm0O6jsqeBgcG3ZRc+MtrFNrQHXDFA2VDXphCGHAchJeq6fdizVYSJgP2CUs9DSUeUg82aQgaxkKwj3XmkhwU+wTtlKdxEuAxL4KGvViC46S6014WvD30P7aNzvI5Iz7eVmlUVgafe7jYzwOti9cLpebXASLisVeB4QjZWtwNBmSwcBa6UivX5FIfEoZTRueWM7ezma
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(921020)(38070700021)(11063799006)(56012099006)(261009223027099003)(10067099003)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7UZd56pYVadF8w69qLCNTpiiJZfcvIkHLY2jyH+RoiBmgFb7+1NNhSQtyozR?=
 =?us-ascii?Q?lUD+hQA9m2E8QVLP763cV8CaHyFPOmMqTHYJlv44M5W9tLqUtMkJ3g+NiVWr?=
 =?us-ascii?Q?OF1CYzyzDGjZXCFVvfCjco5DRvXSIXSamFVJ4iv7DiFNnwUh/KxMn44LKWaH?=
 =?us-ascii?Q?yYAat/dtEPPDtdU/919fuOkmh5cfvwLcBIy9FetjLJNMfTFcskABn0D0X2TU?=
 =?us-ascii?Q?3W2at3WZ4WPJ6qqcV+9TlxfPkyHhBqdZN2CkkuiXM2gazugCKz5USmiIDgek?=
 =?us-ascii?Q?QK9EmnKhDmBJP5250pIXfSDUychvkqpIC7rwganZz/3aqZKzkCVKzxys9AIQ?=
 =?us-ascii?Q?rj84f+1QZxUI6Gj0yRQX7xX69qVzqDfL/gxYLf5+9h/obEBBj5vX6U5tA2lM?=
 =?us-ascii?Q?9gWAbbiNPmdaw2apSTknGTSihjqI/9S4Llz98vTQ8ndQI6o+qi2krvfNcj/r?=
 =?us-ascii?Q?+Zi82GXQ/967Lfa24hww05IO1WOSft90OrpCRvXN3b6ByX/cxUb9hoi0v2kJ?=
 =?us-ascii?Q?krubScBwvxJ9VriUb+Zme9Tan1puUL1VWzOp7itibeU0JbLeyDfiYOWac55k?=
 =?us-ascii?Q?nyJ0PAeNOqkT5gejlU8kprJkKxYJ5CWte/envVcxolw9M2FVCLzLJGzJXQf9?=
 =?us-ascii?Q?xFcFWPQ3NzdNThYGaTbPJNjd7nTkTXUG6WA8EN/zSMYNebwPocmCk+tnc1WI?=
 =?us-ascii?Q?LqZzMLjsHUUHZx2pyO+nJO9LNX8btOjjigsaG8B0uhnyPM2qy4ZIDnhWcTQC?=
 =?us-ascii?Q?/6cr4yWX914lPIOcrzs2r3g97Zghe6JhFMhySbqk+DdDZjzvrto6ymxro8XB?=
 =?us-ascii?Q?UvPt5y+oZ8KSpy0HH1wjtRk9v+VbKhQvMfazmukedL2dXowIuOzSAC/u7tlf?=
 =?us-ascii?Q?dE85Byphu5/hgxPgXLzRUSkeQMiihGWLAv4QzHwrt7fRNCTjdSpGAofnPvsa?=
 =?us-ascii?Q?5RkCju7jnt/xRYRJgaQbC/HI5acLtHBBibgJ/7TIw5qlfWpOlRIb8of2g8WF?=
 =?us-ascii?Q?U4cVpJ4aqL08e6j3asTWgp/VRT2H8t2u5IMaADZKRin4gnikZwczOsIRATE7?=
 =?us-ascii?Q?osfxDUjNpR3BtsTGpP+wLuURFxunhSZQ//VViHgYw2XY/4p4I2wMTUh6MTrH?=
 =?us-ascii?Q?f/+buZYPQ0ac1z7l+3urmUeIiqD67Uj3kDjqtmWu5bCwVGLpO6gZ1UpTto0Y?=
 =?us-ascii?Q?kL/auoofjquDFuaO9B8Ho2s74uhwLu6m4YNHbV/n3jsZQ87TNgD0qMYa5gnk?=
 =?us-ascii?Q?qrW6OQ/RSr1njo+nR2E2kuW0QsMu5aWTOZ7Atd2ImsLU2WXN5la69+27glwh?=
 =?us-ascii?Q?EXvIeUVojZytp6RND7mLn0k35swNg30fLXW736mutZodfVKpqtxyFdcFmaGE?=
 =?us-ascii?Q?m5BeRgbOQ3yPPbJrMBNEk7l3r60Zgr7XCna9fNgZwKtwfzPpat1TggMlaSrL?=
 =?us-ascii?Q?TdMY9TNX6wsBl/TckoKGjQqJtutTYYBNSbgGaBH8Fue5/DHLiZwwBzcUnKYF?=
 =?us-ascii?Q?VD43B6vkBRyN+spxX5n9/VgjfFodUZA/+2lKGFU0fGShfrKxHZZ0sK2TOyv9?=
 =?us-ascii?Q?DyPu9vKFkvlKmSJVgVTUgED99aicpwKpBNqeRzblenX0wmJO5gEtOdvCe34d?=
 =?us-ascii?Q?F/obuiygkECqHHpBUNTAr4AqeQ3PlxLY71+EVPsVWOAXFwSVxGcV2hnG/uuJ?=
 =?us-ascii?Q?H4gQjJuYotlEFkGjomDlXUGsWpGQsnwY8OnsZPrWiVw4SSddD3hWN/k3cBgX?=
 =?us-ascii?Q?5PiAhNOPhBfIUx7+6K3AQ4ARRHRxoTQ=3D?=
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
X-Exchange-RoutingPolicyChecked: Rs48yNM1G8wi5G1nciW/v4lbpgSP8gbxJJsJpbh67GDpFboeuwWiCEXWWM6LRtyMamVtG2GHQrALfEqjojlpH9YnU90wO5cn7GBhf9QIx1pOJ2tDh7lpPerXPhW4QZ3vXMxMUjOhEmjNaa4wf/sRFn2DRBd6Koo2IUTthYi5fNdd7OKdYeeyq6S1W9fGeYGsXrnomdxpUWDCcEknQmAFDNUVAa5/oKh9os3d7mNlAKceHWlfZDSyRcF/cFeVstvewX9pehDmpsJvWs0IdGF2T7iXgE6RzqrpyLLao06EqYOPtzGOPRcw4hFYIQoUkq6Qdfe8ZUPwB5R27TfDylEgdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4397ade1-4e4f-4e11-506d-08df2f4d4fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 08:28:40.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sl6C6iUi8u2YtBMqJ3smPGmVhtwSY3kTI9WSiJGEB4dtWluntXOhI1hrz4uQFlTjVuCnF6nS0gK6Lffu4irO2/Kyy5Wlevoy+beVAg9FPlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Wednesday, October 21, 2026 10:13 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [PATCH iwl-net v2] ice: do not report success for a VF setting
> that was not applied
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> __ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() store
> the new setting in the VF structure and then call ice_reset_vf() to push
> it into hardware. The result of ice_reset_vf() is not looked at, and it
> could not be: it returns 0 both when the reset ran and when it bailed
> out because the VF is disabled.
>=20
> Whether the reset is skipped is decided by ice_is_vf_disabled(), while
> the readiness check that guards these handlers runs before cfg_lock is
> taken:
>=20
> 	ret =3D ice_check_vf_ready_for_cfg(vf);
> 	if (ret)
> 		goto out_put_vf;
>=20
> 	mutex_lock(&vf->cfg_lock);
>=20
> A PF-wide reset can therefore start in between. ice_reset_all_vfs()
> raises ICE_VF_DIS in pf->state, rebuilds every VF under its cfg_lock and
> only clears the bit again once the last one is done. A handler that
> passed the check just before that still gets cfg_lock, and two
> interleavings follow:
>=20
>  - It wins the lock before the rebuild loop reaches this VF. It stores
>    the setting, its own reset is skipped, and ice_reset_all_vfs() then
>    rebuilds the VF and replays the stored setting through
>    ice_vf_rebuild_host_cfg(). Nothing is lost.
>=20
>  - It gets the lock after this VF has already been rebuilt but before
>    ICE_VF_DIS is cleared. ice_vf_set_initialized() has run, so the VF
>    looks fully initialised and only the PF-wide bit betrays the reset
>    still in flight. The setting is stored, the reset is skipped, and
>    ice_reset_all_vfs() is done with this VF, so nothing replays it.
>=20
> For a MAC address that leaves the switch without a filter for the new
> vf->hw_lan_addr, while ip link and the devlink port function already
> report it, and vf->pf_set_mac makes ice_vc_can_add_mac() refuse the
> address the VF would otherwise choose for itself. The VF stays
> unreachable until something else resets it. vf->trusted and
> vf->port_vlan_info are stored the same way without being applied.
>=20
> Repeat the readiness check with cfg_lock held, so that the second
> interleaving fails with -EINVAL instead of reporting a setting that
> hardware never got. The caller can retry once the reset is over. Only
> the flag tests can move inside: ice_check_vf_ready_for_cfg() starts with
> ice_wait_on_vf_reset(), which sleeps up to 40 x 20 ms polling for
> ICE_VF_STATE_INIT, and the resets that clear that bit set it again from
> ice_vf_post_vsi_rebuild() with cfg_lock held. Waiting under cfg_lock
> could never observe that transition, it would only stall the reset and
> the VF mailbox, which ice_vc_process_vf_msg() serves under the same
> lock. The wait therefore stays outside and the flag tests are repeated
> inside.
>=20
> Changing what ice_reset_vf() returns on the skipped path is not an
> option, too many callers rely on 0 meaning "nothing to do".
>=20
> The race was found by code inspection of the ndo VF handlers, it was not
> reproduced at runtime and no error message was observed.
>=20
> The change has not been tested on real hardware, it was only build
> tested.
>=20
> Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl handling
> and VF ndo ops")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> v2:
>  - Rebased: ice_set_vf_trust() changed under the patch, see 0a01e1df137f
>    ("ice: skip unnecessary VF reset when setting trust").
>  - Move the readiness check inside the mutex as suggested. Only the flag
>    tests can move there: ice_check_vf_ready_for_cfg() starts with the
>    sleeping ice_wait_on_vf_reset(), which polls for ICE_VF_STATE_INIT, a
> bit
>    the reset paths set again with cfg_lock held. Under cfg_lock it would
>    always time out and stall the reset and the VF mailbox for the full
>    800 ms before failing with -EINVAL anyway. The wait stays outside the
>    lock and the flag tests are repeated inside it by the new
>    ice_check_vf_ready_for_cfg_locked(), which replaces the three ad-hoc
>    ice_is_vf_disabled() tests of v1.
>  - Extend the changelog with both interleavings, including the one where
>    ice_reset_all_vfs() replays the stored setting after the skipped
> reset.
>=20
> v1:
>  - Link: https://lore.kernel.org/netdev/20261012082910.283229-1-
> xiaolinkui@126.com/
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index f893dff39aac..6c5d5b332d09 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1289,6 +1289,30 @@ ice_get_vf_cfg(struct net_device *netdev, int
> vf_id, struct ifla_vf_info *ivi)
>  	return ret;
>  }
>=20
> +/**
> + * ice_check_vf_ready_for_cfg_locked - re-check VF readiness under
> +cfg_lock
> + * @vf: VF to check
> + *
> + * The flag tests of ice_check_vf_ready_for_cfg(), repeated with
> +vf->cfg_lock
> + * held. ice_wait_on_vf_reset() is left out on purpose: it sleeps while
> +it
> + * polls for ICE_VF_STATE_INIT, and the resets that clear that bit set
> +it
> + * again from ice_vf_post_vsi_rebuild() with cfg_lock held, so the wait
> +could
> + * never observe the transition and would only hold the lock for its
> +full
> + * timeout.
> + *
> + * Return: 0 if the VF can still be configured, -EINVAL if it is
> +disabled or
> + * -EBUSY if it is in reset.
> + */
> +static int ice_check_vf_ready_for_cfg_locked(struct ice_vf *vf) {
> +	lockdep_assert_held(&vf->cfg_lock);
> +
> +	if (ice_is_vf_disabled(vf))
> +		return -EINVAL;
> +
> +	return ice_check_vf_init(vf);
> +}
> +
>  /**
>   * __ice_set_vf_mac - program VF MAC address
>   * @pf: PF to be configure
> @@ -1327,6 +1351,10 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16
> vf_id, const u8 *mac)
>=20
>  	mutex_lock(&vf->cfg_lock);
>=20
> +	ret =3D ice_check_vf_ready_for_cfg_locked(vf);
> +	if (ret)
> +		goto out_unlock;
> +
>  	/* VF is notified of its new MAC via the PF's response to the
>  	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been
> reset
>  	 */
> @@ -1345,6 +1373,8 @@ int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id,
> const u8 *mac)
>  	}
>=20
>  	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +
> +out_unlock:
>  	mutex_unlock(&vf->cfg_lock);
>=20
>  out_put_vf:
> @@ -1415,6 +1445,10 @@ int ice_set_vf_trust(struct net_device *netdev,
> int vf_id, bool trusted)
>=20
>  	mutex_lock(&vf->cfg_lock);
>=20
> +	ret =3D ice_check_vf_ready_for_cfg_locked(vf);
> +	if (ret)
> +		goto out_unlock;
> +
>  	/* Reset only if revoking trust and VF has advanced features
> configured */
>  	if (!trusted &&
>  	    (vf->num_mac_lldp > 0 ||
> @@ -1431,6 +1465,7 @@ int ice_set_vf_trust(struct net_device *netdev,
> int vf_id, bool trusted)
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");
>=20
> +out_unlock:
>  	mutex_unlock(&vf->cfg_lock);
>=20
>  out_put_vf:
> @@ -1743,6 +1778,10 @@ ice_set_vf_port_vlan(struct net_device *netdev,
> int vf_id, u16 vlan_id, u8 qos,
>=20
>  	mutex_lock(&vf->cfg_lock);
>=20
> +	ret =3D ice_check_vf_ready_for_cfg_locked(vf);
> +	if (ret)
> +		goto out_unlock;
> +
>  	vf->port_vlan_info =3D ICE_VLAN(local_vlan_proto, vlan_id, qos);
>  	if (ice_vf_is_port_vlan_ena(vf))
>  		dev_info(dev, "Setting VLAN %u, QoS %u, TPID 0x%04x on VF
> %d\n", @@ -1751,6 +1790,8 @@ ice_set_vf_port_vlan(struct net_device
> *netdev, int vf_id, u16 vlan_id, u8 qos,
>  		dev_info(dev, "Clearing port VLAN on VF %d\n", vf_id);
>=20
>  	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +
> +out_unlock:
>  	mutex_unlock(&vf->cfg_lock);
>=20
>  out_put_vf:
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
