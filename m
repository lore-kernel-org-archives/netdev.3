Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE08385D8F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082312; cv=fail; b=LdzFNa8Hh3vD4OT+SBm/a7DR3YgEdrZrK79v93/u5b0qQl9PTtuBeMY5cPZygCqhPKO5dzfGIUqTX97UyUiBd7GV07idSpJ43Tfxb7STMLWvFO+JDMkLxmwU36C0FUW8is+Czngze9QRvQcIbUJmL6gi7IAwS0xrpVWM1kULSkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082312; c=relaxed/simple;
	bh=GDLsF+4cMk9VbHaKmqdQMoPBKl9I+QvHr/8wOwkgdx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f/oKwlO/a+zxA4f/jQnOpioaoQh6k73uU24D+llSJ47ADzmNYkUkoYA+3VkTYmmXjg06lu0eRUMY3k2fjAUJrxMPOWZlL5qC4HfnlRtaRtfQIuxfN9DqJdUs2ASg/saWCl9owkCGPC7BVk2kg5VtNDDMcraf6N+fliar+Jr+nnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoKrKIGm; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoKrKIGm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786082311; x=1817618311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDLsF+4cMk9VbHaKmqdQMoPBKl9I+QvHr/8wOwkgdx0=;
  b=hoKrKIGm6bxwCBVhCU0qmpzkINTIek59UWNzBWuB8YHMqulbWwLX4CVT
   f9syyOU6wMMSe6MMSA2wJoH91UZ8NuTLe9SnjRLbyW1wABv/Wz81cPwyW
   XvxNsfVK4tFQ6C6dKlfqvAjIp9x1gQSYV8wnZJIOjAq6c6URwF9/gAkop
   74R0xpINxV6q19krH9Ghoc4fhgwjIOXDfkegkdXC8xj5vDOi/Gq3SIc3r
   fbO77MDA5byxRAQ/A41s/3hf78mNCGVHtIZiInCISm0JEGvxfRY7hSPoq
   t0UL4S66uGpScQJJSm62wK+PImYysUrqY8wCfa1qDl8bO3yb+Wvzx1fVU
   w==;
X-CSE-ConnectionGUID: JGeIFg4uSdOf9Axmpv6Cjw==
X-CSE-MsgGUID: EGRcuClCQwy/5QPwAfNYVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97037672"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97037672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 22:58:31 -0700
X-CSE-ConnectionGUID: j9FTX0iaQXakDysQiZTbIA==
X-CSE-MsgGUID: 788XZjqYTjm5Bd34GwJbdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="300522437"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 22:58:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 22:58:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 22:58:29 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 22:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehDZA0hAPb9qkLcE1XmbdXuumuxOjxcJSvMMOogzXlGHDdrQEtmhqFgXcumHMXhFpLfkBqTeBpfCWzwoUkI0aZ7oY6yefRbVQUwGdtlmLKFTzvNWoobRTmmyWBKCBGVd0wkzibkdAe3JX6uMcDgkZtmHhww/ZMNlDPCe6bJ2tAw+oM6na6Da/uR0TVaNV+0m+TvRLmQkieyK+JGHlxc9SsixSKGxQ7U5hzhNz2qxieDq4+ban35ti+NsTJi+4RWrWEQ2eAEEhpcuwjLx6HsBTQz2ZQAjHLYC1o9LS+lRNBQG84GoIfpfqIijNjjgLzPwc9naMpoijkxER5lw5H2KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRWocrSlIw6eKvusvFagfqVDJ+0QPauvzf+nJVwovPE=;
 b=yzbcsSey/AlJPxRkN0zCl2ca6+w1ROJtO3+s+LH9TiQsCb+kltRH9x7seQTsEiL01B1UAND2ILiwztD9kZVIwEUD2jTdx0/+hQb9kSU4N1ZmZD73nIEyonhMkiu4VBA/Q7oAM1X02Z+Z1ib8OPAAIJlwjvUlyoZYGNEwhY6311NlqEgkM9Hk6HkvmkJF5Dlr30u7mnxKrTJCRuBP7hv74+NLxdSDmrcq7EK2DfxAXIIOwsOaJCwUXHeosX5kTNTWO0zwuM1ckkKUOiDfQPa+pSzTXr18l238+3qlottfMZE2ok1HMnkb0uazdpF7aelws8606QUnkBXADE8qkjwoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.16; Fri, 7 Aug 2026 05:58:22 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 05:58:21 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Vecera, Ivan"
	<ivecera@redhat.com>
Subject: RE: [PATCH net-next] MAINTAINERS: add Ivan Vecera as DPLL reviewer
Thread-Topic: [PATCH net-next] MAINTAINERS: add Ivan Vecera as DPLL reviewer
Thread-Index: AQHdJYg9G9ThvEoGK0u885Gu29/V17aSF/BA
Date: Fri, 7 Aug 2026 05:58:21 +0000
Message-ID: <DM3PR11MB87354481DBBEC61B6F3770369BD12@DM3PR11MB8735.namprd11.prod.outlook.com>
References: <20260806094432.163833-1-jiri@resnulli.us>
In-Reply-To: <20260806094432.163833-1-jiri@resnulli.us>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8735:EE_|CY8PR11MB7731:EE_
x-ms-office365-filtering-correlation-id: 8f48ffd1-e0b3-4941-fd22-08def448e315
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: Npo8eq842kkzdBkO+9gAo3ZU6CGDgZuC3nDYP4xKHBUOeQK4g0CcYg/07ZoZ6wEFRMu3zgdlWrCbEN526HjASbklR9VtKQyp3iMjsROhuDAzpiTHMHnZScSL3f4uCcgKGqv9Zwmp1R3JaDBpYT22a7+3gmSi/MsMNXgQCoYowNMc7ZVRV9/8KpTiQtFVO1rFN9FvYCyhKyymIdxxwTr5hYDPnbLkPxZAZvwDrb6f4IipDzwUulZM5Kg3D7j1zQZM0JxrQYuN1BTw1Q14C55BCOuRkE9osjjp08Ce510gOd6mmFAMN7xXsMJXjlM8mexJj3GNKL35O6eRJddL5E9ivWTreXyfGX5r1Nhyqf8PsJ1fpLClouadRSrH9+998PUDEEUI9i2a23Ai8QmrKkk7AQdZ5x7h0avxhBrG8BbYco2RdArkQQluMUOfgzIvcWLwXduGkFbR12G8PJaH1ujVKCFmAqidhC0VQKgSMmA+ZUJ+k8TiO9EhM3dyhku3azMD6hNjkvhayPGqjURcnvRJ5/aBu+qmyKau9VbM8tStscfKZqtrR/FJo3mBMe6G+Faoe8xLycdqujNAjCOliUL1xj2MsrKwoIIz1RmelcDx1k9XDoSgouPLU9AS4fSjYZFL6hT5a+SQf705ceWWYR1EWO4QuuB2xNLoqudbQcZxlE+JxJpMkx4xTS/BMuYY28EkWJuWBl3lkU2EXkkR3zwGQok7J118kYzm3e4TlNH8dEw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tz62RRfEYbWl8QRyGM2xqNomtv9cQ1xTMADJrkYip34Yc61lftVWGFyT5iph?=
 =?us-ascii?Q?7dwCLa4OshoJLo6u+RfMj0nEws5XeEcETY0moa+oV803ttUx3fOSjtWw32GI?=
 =?us-ascii?Q?VwqfnFZntVUEtYMJST8jHKs9ouFuYkX5fnUlVDTfvDarC33buSjEwIKNbfUB?=
 =?us-ascii?Q?83qucAMDtjpeY1JRcAzbtp1mKdr9TTomJ9Hy540pQ0H3/h/4lvzCDDjhxOWe?=
 =?us-ascii?Q?V+P8IprhCCBn+IfPyAEh1TxpB6zZ8UCytAOJZmW0k8D6U7+s6xdcETGt71aw?=
 =?us-ascii?Q?hIxyTgp9iG2NBM5N0C//B9lBREHolQN8j7vHV9Bql6MD3x/XmwujpJ8Lmtkg?=
 =?us-ascii?Q?zV9pK+J7rtc2PFNSDE4ndt4CTWk6WdNY92mU5KBdGtXIco7QDNx/+TTmE7Bz?=
 =?us-ascii?Q?4bnYQmmqRlbpOxHHCclTEMdmJp+c0nL9pZ2xqt7bq85lRTaFRTluJZRFUz1X?=
 =?us-ascii?Q?hNMvMpzF3AINN9m7b7ilKJ3pVtnVKf1sWCsrYyZI6A3OMCfbIeh2quZFkHUg?=
 =?us-ascii?Q?dhlI9G3YTpg67oqOCXshLNssr4atqf2qZHn2JvlppMgefraHWOQIvfOkWGfW?=
 =?us-ascii?Q?jM1Wex4PqvWd05vSo9sNhrmcxAa1qp8aNMwTK13yVubZjcvT09cuKa2jX/wy?=
 =?us-ascii?Q?Gb3HslHdJ2CvySiVr+4WzScq2WbsrgJIKKkLZMQ0tSQiAGkzpp869LAF7G9w?=
 =?us-ascii?Q?Cqf7dsoPCD31JHwHGc8+9HB0WndnOYSGxpqv2CwLOI9oZPi1uqaY3pfMPDea?=
 =?us-ascii?Q?wP6rbcc7iQYVyoD0QIuyQSznvMvgrB3o8IFRi9MNzMzrJ/uryfRON5/4+KSG?=
 =?us-ascii?Q?AnQQfXNGcKfW+8BK3N53pl2sZ2XOfJx1Og+XC080uu6Z86nJ4BgmwICDNX3y?=
 =?us-ascii?Q?0H3Dnm2dhE4Q50IQEsNI1ZwMNQIM4ddRkjaiUT+zQaoNOHWdntEMQnKZBO5i?=
 =?us-ascii?Q?zD9gU7cucf0rVH7oplsfU5qUsev1U+6JJfWWrzoVTCLMucwuxCWpR7GzW0cl?=
 =?us-ascii?Q?xC6im7g3tQ23Zluxmtor4YX5zuUB/u7vY3iFR2/hft1H4mtSWs/25/8GOg4P?=
 =?us-ascii?Q?DRKuwXUuYHZCBY1tjGXaZnRqODPRnRcjCaYRlBxQo1BCv7CAfVIJSwxKOqjF?=
 =?us-ascii?Q?5aXfnRMR9qLYfo9edYFI/RaLsGL2rBgs+tkzccb+m7FxmrdM+uYrM8hPT8Z4?=
 =?us-ascii?Q?TxSaTPrN9bcwbqqNLYjXOA1h9m0zjLXGns+rUNxHPfgMyfErCCYXj7Mq0ogx?=
 =?us-ascii?Q?LS77DBraSOittx8XU5fZaMNkTSQ+HGNbHWYRvySUQH8jVpqNMhQsKPjXDiPL?=
 =?us-ascii?Q?0MtSJK3lwndv0oJn8d82nf9QlqndFvf3eOykfHgm51ASpUGDw/v2XilWjKuH?=
 =?us-ascii?Q?RcwjqFKzlx5Dz77BJmwj7kUqFxTRA5ZHvYunwoPwMf50BlOlOeAA01leN+Rl?=
 =?us-ascii?Q?G+tpCwQpC3VLPVIDACkDSPEQDijTAelfQloGskj/TgOVJ7uuC+EQ8tfy13UK?=
 =?us-ascii?Q?ASTbOmXjB8s8OboEXega80y8YbiP6cYToOB6ALnNRTRJnc3YSBPIH+ifOU/u?=
 =?us-ascii?Q?BVY3WU3cwn0y1xzj3h2de0+7Y+Q2CBeXlxSvpA96kXmJmJ2D1MuLHqmr221v?=
 =?us-ascii?Q?wOIq2uaBvm1MA/ZVEF8evhQNK1cgSIBAms5iks+pOxinJ8hC/olhlNeFXUJL?=
 =?us-ascii?Q?jhnNhtSFTra8HMCqDCesK+WTtogL0e1/OOk7Uq0M3sxRN5e0Z12iBf+TjQvi?=
 =?us-ascii?Q?Wla8VRF1QWMitpCHBv20fxp9R4XUyU0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QqT7kdDR2GtVs/gSQ1XSBgyXN9kVHcw+F05yYDyarIPJndUYXP7xGCobHq2ZDLukfESjoTA39lO6HNlbE/N8dEgnR5UCs/N6hL9007WfwGeOMou8Fv0tAmRbgS0tipl21zJXsD36irf3hmcipA1+wlvo5GOZauuKiCXdPAQMmySua0T/BPYezUc5SiVNix3uDFRnvRtUkZrqj6mPsNwa6v4ob0d/JeH/Ob/p8khHM5dp6dwruXqI/LusjIuwZPftXfF1ohAAI1XGwzEUsE7ZO9JlItOsARdbpu9rJqgXdmDojjQkwVracP6CHToo/MOTdUoiV0oWmFc0Yj+0aGMD1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f48ffd1-e0b3-4941-fd22-08def448e315
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 05:58:21.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fyBTzUUNheWEfg1QvLcoArX/tFHIFSKgZcdXn8fmDSo0whx9Pm06YZw21AcM9he9lioHiLFqP7molIl+JyUDt8fgLaK4p+30/u837raeEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, August 6, 2026 11:45 AM
>
>Ivan has been continuously active in DPLL development and discussion
>since April 2025. His contributions cover the DPLL core and API,
>netlink, bindings, ICE/SyncE integration, and the ZL3073x driver.
>
>He also regularly reviews and tests DPLL patches from other contributors
>and already maintains the Microchip ZL3073x driver. Add him as a reviewer
>to reflect his ongoing involvement across the subsystem.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 03bfb79fca2a..ea683dfda21f 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -7870,6 +7870,7 @@ DPLL SUBSYSTEM
> M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
> M:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> M:	Jiri Pirko <jiri@resnulli.us>
>+R:	Ivan Vecera <ivecera@redhat.com>
> L:	netdev@vger.kernel.org
> S:	Supported
> F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
>--
>2.54.0

Acked-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
