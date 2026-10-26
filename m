Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793052496;
	b=iLwZYowmJlrB0h/nDmvw/tYw8+iKPjMtCFnA6kB2xTeoCsdsX3ivbjSUJZHZQPZWAdHM
	 5GUSjffXoCHr4KllcvqmTVgGMLAu3HG6sQUXqAhoWL9p0/2+9NZVzetE59LTscVM0uWCh
	 XibcwACU0oUBp28dfbt8WGx/8zBHyVMaNr7MKGJmgyqdkpGFPSpwLgNc6JsHTE0KCL/0e
	 vvYlSrI1P5Q0f5Jc3TBpjWC0lILtfTvJTcqlJn2NqjTR9H8zF+mUVTTMUgiShT83SaB1G
	 cn/3V/Qkuh114v/YUesOpR3VQKhhecFjRyVpiDNxhLuvum+M4xkycCFysbGRAyTlCZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052496;
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
	bh=qAZ+vPcTIM1Z0oSOYxQ2wIsSNs0U7ceBxxqdA5cQqy4=;
	b=a6vvAV+BQ9XIXGy602VMEj6i/NwBnM6qtkMblxIhk9119GdJ/WegY4JnggeKtwLyVzIE
	 0eV64SGEkNcJqJT2w7sjKSwui2K/jDHD7YEtzksoir0MjW8hLn5B1NXHIKKCaBBJ6fg+o
	 qXcM9gQovIsES1DuXCwfIcp/qihKJ3RXBMU7z17DDPJWGoJXBIx8hcPyl5KEr6xkPistD
	 G0LEIkmKuhfiNiiAspaYKL82yM0jBGnPk86t0nzEk51FGRykoG+pv9oKbOk5S0Fe5vGru
	 p6ppFaJURYkM4I8BfXJG7OM+HsRXMu1Bg9C5A53kbLfVj5NB26BuHsnC1M4PMxfHVOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VBzrlAbs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93B606A32C
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC93B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VBzrlAbs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793052495; x=1824588495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Az8HBUTqpIX2rXCOoHgepzdQ3gENdxMeawetfPec+U=;
  b=VBzrlAbs5OuO6uBpkZPzVpSDafmhJMIb1PIGDIZdCPykiCEoM9cuS1rR
   r+Oe51tcP8N+ZCK2VUfxmizmj9dGafHw9nHAthveGnyUt+CqDggW30w7M
   qy46OrBA3KRFCrifM+CBauLvsEyS5YGExdeAlKVHmm3AVx9BbIRqnnloz
   axHLzsaCNmkn5XU4DWYSHO5Btu/jOkE3TtVzKm040tVYIFaUzlNeh6+d6
   19p8/cOZQ0i0hM4JX2Bx6VgtfRgowcTHgKYqIgQW4KhDN3guTfQhTmqd3
   xdINYCdbNj3tF9jMbmD6IQDXtBd5NQ4t/mqvO5eqwtym07F/N645vHSkE
   Q==;
X-CSE-ConnectionGUID: K9OJgfS3RoWsKVuWBZK32w==
X-CSE-MsgGUID: /2M5SaEfTxm+QcuufCSgbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1614510"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1614510"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:08:14 -0700
X-CSE-ConnectionGUID: 4+pMLGCtTsy2Uu7VwZBPTg==
X-CSE-MsgGUID: +tw4pSgoS16dWmnmscSOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4459205"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:08:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:08:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:08:13 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUpJX60cBDWHXkagYRXZx9+0dmxR9guYwla3KQstnLJkNp0IH4w1Z8FlNpv4hyEkjkGLTO30zThoh2iFV9hmaSITHui4FiFLUnuiFttMe2kDe9LeBuZQXnZ+hbNV3pNf5YEUMtK9vtwfbxnF0nTPCls7IdFo9Ag2gut8IMgFPfgpb78+hvsU0mRJCxATNp7eB+iei+Qm4KfX0hU3pQa83PyOfwIMRkFhYBwbskEUJ7YIHmmXA1N3nyhxo8fO1ajpIlm6X3tr+kyHsJBcKZclXQmcIERmFl0IMNxJZRA8HjtF9BqHCpHr0xUTE4d6O4rgEOa0PpSrAbxMmIX9yIaEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAZ+vPcTIM1Z0oSOYxQ2wIsSNs0U7ceBxxqdA5cQqy4=;
 b=U09OTopn/iyTODAKsUAggGjxGWc1Qbt6MRJSLU1CRBKwNr1zHknMT03y3PoviEFlhIeWs0vKA2VlUVs7r79IiKuJLYalo8rKOcRbrAQshvWXo2rjBK9o2Q9Vyg7lgrjdYOVtvuPrYhzq4JXDmKxd26fOrefgPrhRuERufQe140/0vfsy96u05SXhM56yusBYs301l3j7qpImGFNC17+hF4zvSq9UbYrzqMa1BfVc8is47jCaZs0s3X95XzMyrGsxEQp2WbDHkvqlCbC2/EMfN6wZ2enT302F7OArncKCMq/ksxptv5MLAsb/4L+68nqEkRMxaFUW+AWntgbRu31SJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ2PR11MB8347.namprd11.prod.outlook.com
 (2603:10b6:a03:544::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 22:08:10 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:08:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Andre Brait <andrebrait@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "g.goller@proxmox.com"
	<g.goller@proxmox.com>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>
Subject: RE: [PATCH iwl-net v3] e1000e: work around TSO erratum that corrupts
 data and hangs Tx
Thread-Topic: [PATCH iwl-net v3] e1000e: work around TSO erratum that corrupts
 data and hangs Tx
Thread-Index: AQHdY1EyC4caZnoCrkKSARoV4Qv8GbcQZkpQ
Date: Mon, 26 Oct 2026 22:08:10 +0000
Message-ID: <CH3PR11MB566895692EE1994E1DB3ADD72AE5612@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261024004630.24579-1-andrebrait@gmail.com>
In-Reply-To: <20261024004630.24579-1-andrebrait@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ2PR11MB8347:EE_
x-ms-office365-filtering-correlation-id: d003ba89-38d8-48e7-1ebb-08df33ad9f68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|261026140227099003|261022113327099003|38070700021|261026121527099003|261022105027099003|11063799006|261009223027099003|5023799004|261021135927099003|10067099003|56012099006|261021121427099003|261022075727099003;
x-microsoft-antispam-message-info: WK1APft76tJ9hLQbm0HbHljE4p/VBfUaAJuUlzPBPuVwK24xfSmlusuPOtsnIplYhgT7+6gsHy6XsjEOQ6JkNIXxlMisrplz6eYXj6BhUX1Q2mQoEGwH/3gCfJKaqvXEiRJYh3FnNRMKmAiyHnbtFAJ/RmevSagSvJ9ar9ZAUMdKCVAO3CCC900iV2Ybk4QbUS9G/730z2qaqMRx+NrylLCROeKYEF+DEFY6zTQZtzHuoRPkje83VxlGucqK3d/JNHtGYkib/xLGj7xQmg68YEFeP3qN3t/AOvQOfF5y6GTBFXjarm1HVAAqieI4uju4cz22k6elufmPJW6C8PqWI176Aq+gRoX1h27lEfhofO43sbPzw5stBDBl9EsjDWo8k/PQj9Ylm1otMjefDYxOHdw76blIw0asUziyCJfm56JviedcZMrxl2hhENtL5oH8ekEHpbWNS5/y8KifteTwvaEJlv1EbX+7UM0arFwVbntavM/kQb6cMQ2XLztr9HhZYOoE5K3LBPQreB7eionKK9enhMl4PboW4sQGrMxCTvghh5AKRSmy6Yisu6XwMRdAxwXdN6L3iocL/A4B+Pok9FPIGW6ZYwdXKBL2JMhugbC633hGVwVxPk1bR5tQF88Pro6r10m3gTz6l1y64lch62ow9butPmYJm+JySDUdEX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(261026140227099003)(261022113327099003)(38070700021)(261026121527099003)(261022105027099003)(11063799006)(261009223027099003)(5023799004)(261021135927099003)(10067099003)(56012099006)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GQxDCzNm+YuMK+DVpowH0Otlo3cIvKcUfv7ICxJpweQkH64yj0vrnTCP3FGm?=
 =?us-ascii?Q?NzwDSsVMEkMwbbzeb8laMWeQTyP946cWdBsszQs0SOMzQnpO71YHrwzci08j?=
 =?us-ascii?Q?ddN4oN0/HhihNpwc+9PqzmswlknCxE6UYCXuTuC+7CNTvUNjjnFkL2UNvJ9B?=
 =?us-ascii?Q?59D5ABzOjH10odQVOn4ooFyseixkmiiaFf6OQ3Wk7LJ8ZouxF4DoeGdGwqla?=
 =?us-ascii?Q?xzEcWybGLM+tvsd/YtvmiAn8DyV4Fxvi5yjx3zK09wm0nqBPGaC7d9L4tqhx?=
 =?us-ascii?Q?JZbYBf6kUcTjFS5Ob5d+Qp/mzYEYlcvWttZdnzRUs69oVeI4zBTs9BmPrqjQ?=
 =?us-ascii?Q?SgpxIqA2iaeq8nRVbswI7vXy3qCOJZ6jC4+58wlGE5nd9qFKsEBTq+//AL8a?=
 =?us-ascii?Q?zMP6ZCsLf2F0A8DrT7sQMBfV84IWp3DMGHuZyFG0GRkE+pijvnVk0Z8pvVqI?=
 =?us-ascii?Q?NfHcZYzrXs3trcYqKZrv4R5Wo3yZ0aSYSyJm+U1ySWgL9KKiuTWlQtAv9nTF?=
 =?us-ascii?Q?l4BPwk4g7K1ZC0yuB6feSlL34GMwap73DXhlcnJHBfQ/5nL0z6bB0ydADzZN?=
 =?us-ascii?Q?dIUMO55vwWk2Kef8WgAvSTp4WApE+1b6P3ofvcVe1wgChE0lEtxGIgYg44zp?=
 =?us-ascii?Q?izA0wa0zJfRhlmCi3FFNr+aZSnA1vhGRk69TXCPJUcdstvyvIyovnHMmSTvG?=
 =?us-ascii?Q?yZgFgzbDNhnNibQRBWc+QxTRKNIeIV0o2DXhCJgI+G+drHTY75zRz8+VsBML?=
 =?us-ascii?Q?vjYtulc7cKLFNM7491uk1gOZjBI4t1hA/YXfkFgPhBev7xLjjhL64M3omiHw?=
 =?us-ascii?Q?PD1G1/6g4l3kMfxvZfz8Z5Bpxy1KdbOyvj+K4iZ69p3MqHNtRR2TFSa9s2pN?=
 =?us-ascii?Q?+eM+DeL5yfUt8AE5ZeHi+sij6YCe7gso7eNtBgWsrQOZRXMxMTy1qm4Um5GZ?=
 =?us-ascii?Q?KXIo4iWnhGJpvzEkBY/YrXLeMBTHDtrEyOGWbagYhXNNHf1lm0p3/iTOrzAM?=
 =?us-ascii?Q?ueOeHB25UBTojaY1fCmq576MYYmFwmvr/pm0HOjkCeUbWhFvjKyIIlDAhrwK?=
 =?us-ascii?Q?fhJ2q8ZPNiCu93kor4vOjEJ01dL0ZjnSXvJqdny5qfwaoh3Kx3LLqMqRj1Mp?=
 =?us-ascii?Q?d3BnFeKkpj2OpOUp/BEoEL4idg6I4m0rTJMMulvypC9HjAOZjDy/yCPExZfv?=
 =?us-ascii?Q?HQXefWwO4/LrJ6dswklgnXa8OtvYY00beiSA+iBjm9yLI5UkbXzr6JZIIyio?=
 =?us-ascii?Q?W0Hy1DAtMG1uxWq78fkyptZCwpvs6Zgv7EBYcDdu2W1DTZxIGYMPPoUs5Cz3?=
 =?us-ascii?Q?7ImH+P0bZTBphL/xHFuSQnDO678QLJVcf1WV/qkDGPqXeOb8/NkIhadgoAjU?=
 =?us-ascii?Q?JzPAwllFsvPl3kUWooP4mRrG9iNRmpHfOM6WjgcTEAeq/BRJO+uP3DPe11Y/?=
 =?us-ascii?Q?dY1CZV2hRP1FOaOZNxx9ZQxn6lpwwbqKOTIBWzvfbsX6R2gqzTl7TY8oVHXn?=
 =?us-ascii?Q?6821nlk0J8eRdI4AIETcIlms6V5t9Mbgzra9VFQfxh7NZ/fs1I9ULwDm7svY?=
 =?us-ascii?Q?4MuzhLZaIIckxkifUeQCCFoFzXsNLSNBWQivVee0e4H53uc7Nk5FWV9FWFW6?=
 =?us-ascii?Q?q+PYI06vVielFpmE/67ZkFXcd/+aigY3+G+Ps37xKoG1s42/EpcXjLPwa27/?=
 =?us-ascii?Q?Ll3C5N9FQF8OdfICUG/lS9WS31ElNiQ+ND+8irkFQZ9EDwUPPuaIiqORJBN3?=
 =?us-ascii?Q?iRu33YWsyFAVoqn4ZxnObuJY7+FlU1o=3D?=
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
X-Exchange-RoutingPolicyChecked: BwxLnGuVzj/F5OAig4qYOPMG4raJIpaffaV6ylkZyrEw1VSdfE/A9/qnf8UwKYYLcI8rAkkn2P45EEzLeyf+XpGndjgyLcSgz3bp7vOyXi0y1cUmNqD08mTdGyzq5XNcunbe0YyWkjsjrLA/O1NXco9xv1U0Bdnc2buM4GtX18qLicMfNNYKNNMOmomXF1+3xKfpS065ZDjzjGi52EDzDPoIve3bYOohz05AkKxSNDKoE24scx6oTNmyRxhh2Nl5ZXXvTcZTmF3uljy7WrVkBxvrTZRMdJe2pLOqVPi1TmkI+8kp3fWKPEZave7xxAUz0rDtzM9iJj8AjNQbStVQgQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d003ba89-38d8-48e7-1ebb-08df33ad9f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 22:08:10.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRYLtDebNosdPNyQswQ8JIwn1z8SLfhxwEhGAHs+rN0GNVcIRI+o6Mcdr7YgCmPv4jKdaJa+/55RspEk4dF2+WRR+jjecG0MmyI8vu+P2Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andre Brait <andrebrait@gmail.com>
> Sent: Saturday, October 24, 2026 2:47 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; g.goller@proxmox.com;
> david.laight.linux@gmail.com; Andre Brait <andrebrait@gmail.com>
> Subject: [PATCH iwl-net v3] e1000e: work around TSO erratum that
> corrupts data and hangs Tx
>=20
> On I219, a TSO packet whose first buffer is long and has a 4 KB boundary
> just after the TCP checksum field makes the NIC send corrupted data and
> then hang the Tx DMA. Forwarded VM traffic (tun/vhost-net) produces such
> packets, so hosts bridging guests onto an I219 hit it within minutes:
>=20
>   e1000e 0000:00:1f.6 eno1: Detected Hardware Unit Hang
>=20
> Right before the hang the receiver gets TCP segments carrying data from
> 128 bytes earlier in the stream, with a valid checksum.
>=20
> This is the erratum Intel documents for the 82571/82572 (#76), 82574
> (#17) and 82583V (#7): if the first buffer is larger than
> 3 * (max_read_request - 4) bytes and a 4 KB boundary falls just after
> the headers, a read is repeated, wrong data goes out with a correct
> checksum, and the Tx DMA hangs. e1000e never implemented the documented
> workaround.
>=20
> Apply it to all e1000e parts: limit the first data descriptor of a TSO
> packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
> pcie_get_readrq() returns 128). The rest of the linear part goes into
> the next descriptor, and the NIC still segments the packet.
>=20
> The split can take one descriptor more than before, which
> e1000_xmit_frame() already reserves: it counts one descriptor more than
> e1000_tx_map() uses, a leftover from e1000, which spends it on a 4-byte
> TSO sentinel that e1000e does not use. Comment that count.
>=20
> Tested on I219-LM (8086:15bb), v7.0.14, byte-verified traffic:
>=20
>                                         unpatched        patched
>   packets placed inside the window [1]  hang <12m        no hang
>   guest traffic, TCP timestamps on      hang <27m        60 min ok
>   guest traffic, TCP timestamps off     hang <7m         40 min ok
>   guest traffic, VLAN tag from stack    hang <20m        40 min ok
>=20
>   [1] 785-1013 packets at each of 10 offsets, 54- to 70-byte headers
>   "hang <Xm": every run hung, the slowest within X minutes
>=20
> Unpatched, data was corrupted at every hang. Patched, no corruption, no
> Tx timeouts or drops, and hardware TSO stayed in use (26.5M segments).
>=20
> Developed with an AI coding assistant (Claude); details below the cut.
>=20
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently
> for ICH9 devices only)")
> Assisted-by: LLM
> Signed-off-by: Andre Brait <andrebrait@gmail.com>
> ---
>=20
> Notes:
>     v3: incorporated the changes David Laight asked for in his review of
> v2:
>     a comment on the spare descriptor in e1000_xmit_frame() and a
> matching
>     paragraph in the commit message. The code itself does not change.
>=20
>     v2: https://lore.kernel.org/netdev/20261020230211.75665-1-
> andrebrait@gmail.com/
>     v1: https://lore.kernel.org/netdev/20261018203215.77371-1-
> andrebrait@gmail.com/
>=20
>     The investigation, the test results and how the AI assistant was
> used
>     are in the v2 notes and at
>     https://github.com/andrebrait/e1000e-i219-tso-hang/tree/3764faf44ab6
>=20
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
> drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h
> b/drivers/net/ethernet/intel/e1000e/e1000.h
> index 63ebe0037..704284188 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -219,6 +219,7 @@ struct e1000_adapter {
>  	/* Tx - one ring per active queue */
>  	struct e1000_ring *tx_ring ____cacheline_aligned_in_smp;
>  	u32 tx_fifo_limit;
> +	u32 tx_hdr_buf_max;
>=20
>  	struct napi_struct napi;
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 834a5b888..cb3b530d6 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4143,6 +4143,15 @@ void e1000e_reset(struct e1000_adapter *adapter)
>  	adapter->tx_fifo_limit =3D min_t(u32, ((er32(PBA) >> 16) << 10) -
> 96,
>  				       24 << 10);
>=20
> +	/* TSO erratum (82571/82572 #76, 82574 #17, 82583V #7, also seen
> on
> +	 * I219): when the first buffer of a TSO packet is larger than
> +	 * 3 * (max_read_request - 4) bytes and a 4 KB boundary lies just
> +	 * after its headers, the NIC repeats a read, sends wrong data
> with a
> +	 * correct checksum and then hangs. Keep the headers in a first
> buffer
> +	 * no larger than that.
> +	 */
> +	adapter->tx_hdr_buf_max =3D 3 * (pcie_get_readrq(adapter->pdev) -
> 4);
> +
>  	/* Disable Adaptive Interrupt Moderation if 2 full packets cannot
>  	 * fit in receive buffer.
>  	 */
> @@ -5632,6 +5641,8 @@ static int e1000_tx_map(struct e1000_ring
> *tx_ring, struct sk_buff *skb,
>  	while (len) {
>  		buffer_info =3D &tx_ring->buffer_info[i];
>  		size =3D min(len, max_per_txd);
> +		if (!offset && skb_is_gso(skb))
> +			size =3D min(size, adapter->tx_hdr_buf_max);
>=20
>  		buffer_info->length =3D size;
>  		buffer_info->time_stamp =3D jiffies;
> @@ -5905,6 +5916,9 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff
> *skb,
>  	/* reserve a descriptor for the offload context */
>  	if ((mss) || (skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
>  		count++;
> +	/* spare descriptor: e1000_tx_map() splits the linear part of a
> long
> +	 * TSO packet to keep its headers within tx_hdr_buf_max (TSO
> erratum)
> +	 */
>  	count++;
>=20
>  	count +=3D DIV_ROUND_UP(len, adapter->tx_fifo_limit);
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
