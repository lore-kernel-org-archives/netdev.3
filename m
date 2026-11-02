Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614871;
	b=1SqrDeab1SCsYy0N/Ds79CviLgHoo2pQwqWFY0YsSfM6mPKbGLaatDK5z8ELKOJmlD7G
	 PGRSDM6l0WPtTjWWobGB3YS6dM/n8D+WBUUOnl11bTK+xpS3RIUeuvWQ5cI8NweAr0tN+
	 cdgFPl2AxfOgPlspTWHuEwDeKWYrkSfkr9mV8LF8zQKU7RIs2KtFr1vSijSErPrE+tA56
	 AyErzC5puAs1do5Ts97OSiJJyRklWc4TejGTPCyuK+ZrCatLjwWViotJ6j7pzCMWZ59Dg
	 zAdLa2GGOlfgzN5bNgMP8F6kw5mwORJIPnu1HfDJf/zu9MMAe48/nYa0YsF0Bq7sLKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614871;
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
	bh=6KEDT6TRDycGzYmSMzbZWcytOawyauqZwUu7yvRoW9U=;
	b=VzvoH4lqffnxlWkH9CasFCkGNFpu4yFWrJd/LwAJ8AoEU4cQrlq61lYcfzpD2O/4F6rB
	 PA2R1+d9AbIPzYKUIKitTJkM7lSEBP9rnSFfETjIe+gkIZl2FE0Nwy6E5Lf3cgZKxgro1
	 h0mLJrT5S1vsQ3peV8Gdzk7nz0pUd39/+1W85Pys5Icjfd54HsK9ZAoED3Xw6SdeA2huj
	 l6h/UrAnKTApBrvY9eeZj7pjVeesWYBV8VQWAgh8DusvMwAo+0RbUa61rw5n/hh1K0ggt
	 ++OHv1/GBHKYkNJ9+zsD4mFGo4HSUFerCIsYZphTBZZ7Y8kgXH1UFY5CeHyt41JzqZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="bK9hA/Zh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C94606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C94606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bK9hA/Zh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793614866; x=1825150866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pZJeuX//qRNy/v7snjuqrHeqJexk8aczLBnyqEALhps=;
  b=bK9hA/ZhTKuS8LiSAYnuD3PNVsKxANDq3EzCREYa1clbJRDmjX3UYU64
   SO4014O45hVXMUt17LnsixLscdv053r6yCqFnzOKDMBw7B9wn8pawtE5D
   kN0IuxKRjtLD06VJJnH277RFMsoNKhIFhZFxt7+KdV6IJRIeJtK+l1fZF
   katzLAUwlDs6iamUFiZ2UjBfZlacKXAImeTTWofogRtsiPWudySoDIagm
   PyJllo8JqV0q+eTvmkSXl82JyE540nfCop/4veCKX1vYpe0xWAe9SsrXV
   7JWJrTlyUGMJQntlABS01CRXNPoFO7d18Sfq5CBp54c0mD/EVYnQF/xM2
   g==;
X-CSE-ConnectionGUID: wQDw9FMIR6ewbXJeKTce+g==
X-CSE-MsgGUID: KPXIfWu8STK8Q228kHEBDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2182398"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2182398"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:21:05 -0800
X-CSE-ConnectionGUID: lhthASbMQqeTNWRlMQe80Q==
X-CSE-MsgGUID: D1lFyYUwT36OeKKJ7HEm5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7854241"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:21:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:21:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:21:04 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.55)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:21:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXGVuP5om9GBKgD9FoVz3eJWTK1a+GYGHBvQk0G7la0ytp+9OfnZO/5oVJYHhc2JjyfuE6HOZUHn21f6hnN2bCPsWlu11ndPKkt+W+jrl3ST5Z4zKoO74QIxwGMQPy6sCetL6h7r8cwgJ2dzO1zhXMTxMbg7JQADHc+ucqOsNsQLNULURT9P2oRNCyX0eU8iqtJpuaPGOYj00nPWZZ2NGpoKI+GT55L6OOJxbl+SarUiDISE8wqadtKCpso4zG9Rg6BrRw12uYsZVyqRF5EdmPleoeyvUeZi5WEPfPBKaktrvcakPpbJr/6BmZnuRkxUPlqRJ0s532WxBGpg6bKSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KEDT6TRDycGzYmSMzbZWcytOawyauqZwUu7yvRoW9U=;
 b=ywOeYIaARxAqVlIijNH8Y4MMwz/1YeNxQXb+jX3ub3std3rpGRMUZy8aIsCLBcnEtAu3ht/S6Hzavi2KLkMn6GFRIIxWCnN/UAYSmg3cjxm+M6QyV3PljwMiYZWP+j54PMC3jr1lpl84kVhcxsVuXGf6bvF3+JmufeHUVRjJdYJOZbXYwRAi7V/kPcePk1RQEgZINsaUqkPEBkoX5UToP3HW2lO//4FFlTNIs6hu4wglN+CUOWGpLEJsFKusP8mMdWrw7X0mtpTSwVGufSxd54e+IDgYo6gOu+DgpCxiV5LZ5EsaJ1g97X8o1vgVoHh3XELTEeDaEaaARWHOWiLClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:21:02 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:21:02 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, Don Skidmore <donald.c.skidmore@intel.com>,
	Radoslaw Tyl <radoslawx.tyl@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Viacheslav Tyryshkin <s@tyryshkin.me>, Melissa Romanus
	<melissa.romanus@proton.me>
Subject: RE: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD
 event without VFs
Thread-Topic: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD
 event without VFs
Thread-Index: AQHdVN36drhzjl4K2ky/j1K7AGXQw7cavemA
Date: Mon, 2 Nov 2026 10:21:02 +0000
Message-ID: <IA3PR11MB8985C5D424C51283247650B88F6A2@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20261004193704.2895700-1-t.lamprecht@proxmox.com>
 <20261004193704.2895700-2-t.lamprecht@proxmox.com>
In-Reply-To: <20261004193704.2895700-2-t.lamprecht@proxmox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SJ2PR11MB7574:EE_
x-ms-office365-filtering-correlation-id: 6b32309d-e485-4b82-c87c-08df38cafeee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|22082099003|18002099003|4133799003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: p9PxXC3Eup1+aDmyOBM+6SxuTwdpDnPduvn5JUDBKAJ7gATpP6/9OCGMqZIMBmRxdQ7cPDFmNtwLguRuAXJQXEw2I35uVUJUmPhm04C6RW0fW5M6XKEZ8jFTmYtOyiIXND5L2W2x/322HQalQ/xnLE7bKQaElsnbDtYF0CpSUliYlwQqCmhT54IffMFzttKnOG6ZrSFDMVt97z+1GEbvoChx8Tcn59SNWsudKxSvTu15jTiSEerFUJBE+8DG/xEA3iTBS/Wy/gIZL1Rgs70Oa5kFZb4jL7t+hqM/BaSdEleG87z7wjGgPCiDjLLm4+xcPHi7LqBxHUQ7a3JErtzosfJwNKUkWSlTZ5jy+srWJOkJEBB8dgv+siiBziE4qJO82d6wb75Lp4MIRnPIgyAm5g2ABv3Itqmeb7A+1jx38ab2DrHYuufIbFEnFwmytikHrapW5Z1KfBrHDFPgtj5U4vAvhWKzaRCoUYrdvNKqrCyQEahyBTH2gAjNoJO4mLUudfdWA5e8yg2tsMrKp2FA2SFywC7/EORVIWHbl761ziGJWoSb5v3cXARTZEZa5ikH4EDdMBwU3K2UWJSN7aILLug9bkzT1IiEZQ6uSAtQRtA0SmPSOGHRJocQ+THSNJl8trNSAl2dFuMfRJ2kAMNzYNjRyAQrYamwFKJ/q0Wrn2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(4133799003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aDx+oyT01XHofrkzrz20pskyyDjHPjA+/WZt/Og3xCTfEOJUuRChXWfQh9H+?=
 =?us-ascii?Q?uYQCxiQX9gL+yY3/fJ/Cj7otWL1YGuYPwynnXjvwELFchSuHh+a4NHYvL33K?=
 =?us-ascii?Q?Eblly0z/Jpe0Da5i7ZG4odUz/UDGp7jAbDGwiLLOR3+eZFzad6Uc8gUYR9gb?=
 =?us-ascii?Q?1m2YuRk08UESJRhMBpdToTOyEAnsBiLlGXDKZlByQ3ruO3tEjbuau5204yJm?=
 =?us-ascii?Q?T0fwgMCi+A4TPBTCxr4OmV6Y9CjO5J8BxrwiXaYhfuiMO1dqaXSb+7XhWH7X?=
 =?us-ascii?Q?RE2VqUpPbnsWDzPbIhb9CRc2TJ+z4iyzCO8prqC43chiPkFiAZTw7om0A87C?=
 =?us-ascii?Q?RLNVqLFlJuTHYa+4XUtc0kbt2Jbv2C6+P7EeQDh3NbNa7q4wjMKOrLPbs4Bc?=
 =?us-ascii?Q?nhc/+jcI8sobCTidt9nlTazO/n1aFxqkEY7EtZfykdDFDuzxFr5wc4n97/kH?=
 =?us-ascii?Q?iqcfIgeAD2SD7HsreWABZJZQInPEOFaw5vek3pxxp/BIVwBCacYdkDxfkrs7?=
 =?us-ascii?Q?unLoyf38RIcHXLhRNgISp1vcMLujwB3ZyVwz9MY8OcdrSEICOAWsjRXCTgIe?=
 =?us-ascii?Q?d4/GtSbbQKF4xWWReiqSNTGnpZ1fs0wQ/Pq/kNGrDv9X7XDaMBcKnrPnHxdq?=
 =?us-ascii?Q?hUfT5eTtg7lURbsuAzlTQb8Ew5Yx/o9IV2G4xElg1dM0X6JDONfcS2PFaRCU?=
 =?us-ascii?Q?adLRCC47Bkmka8fQtthDOGKzMVcm1lQg2oTlOIoV5Z4IE16IlE8jZq+S+I8I?=
 =?us-ascii?Q?9n/qLJRCHrN1a/hZiFZFWHpM5FIWuxAjcWAGaPHso8orkza5frIIqpd30DfI?=
 =?us-ascii?Q?/p0mQkbe0Jt6NgUPirYiByrM+9bR6PGpcS/G7aMMU0FUaEu+oL8S14WVT/jj?=
 =?us-ascii?Q?Z1mfVxlaXXmNwgJsv7YcQvOqhkFdcF++++/qe/C1h+XuQUQmhxdsUuve5cNe?=
 =?us-ascii?Q?rk+LzA2Ve5YnUEl4akJlTjQDMRWkPdc0cOferMmZlUd7Y6O5Pt0350aV8Ih6?=
 =?us-ascii?Q?F3JegDi+nHf7Sw6129yp5bY6lEchUfYaoS/3fO+1QiBgHsWMEx22984snLN1?=
 =?us-ascii?Q?3r0CDt0XK6EeOTt7gVHc9l6SJj+NfTxCTls0OZ7tgJoNWlkTyrwE/yYQJAff?=
 =?us-ascii?Q?1yQyF8mLjqV5ynygwoii4dZzr//SJ7tVzwrNTQwx1zzGHsJR/TED+6ItBDhx?=
 =?us-ascii?Q?++YqbGBRJRbFq8A4K5rhA4uxBVeBKUWcJol5ZJ9wWHCwrVE0DqLvlUeEJaNR?=
 =?us-ascii?Q?32Ek1LB6rXtFkuVnMRerhGKHjsq5l1LogzFURBWPlYpDrprtgjIAnioBEMlo?=
 =?us-ascii?Q?zo67nNCLFpvMy3Nrz6ZE5aawr7aKqdLDrBb44fpmpk3AKO1yQgmkIAREvbI4?=
 =?us-ascii?Q?HzrKFTZh1YLDD+4OimyWIz0nIwHXMWl0kx8XqT9B2wOZiFEqCKeZREJwFaas?=
 =?us-ascii?Q?K8pXtr1gxjMgnwE7TH4cQUyp60TWEwuSzA5oI5Gs5oFnmxrQi+h636BmnhJz?=
 =?us-ascii?Q?gNhx5dGE/jEFGqe1ndfhzvEFfpUtO+w8X8l9PVd3Jc5CCtO8WdthudwsGTs8?=
 =?us-ascii?Q?wS341tWlU/jdHp98N0v2zrofEGWSegPuA1Xf43x/YwXkyPzeE1qkvdvOHmPn?=
 =?us-ascii?Q?4ZXQYotOUSTh5gSePRyQArZMNKHCQolwpPjEfKS2FLYrPLVZYX6q9p00nG5A?=
 =?us-ascii?Q?s/sen+uYuxDxOm1E0Uprt4UXnVxSSsqRDM8nL5wNlmyr0WYbAGXn2dY1HWNz?=
 =?us-ascii?Q?EbeQsZbp6Q=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: PHciSN3MAfWxWPgholF++sHc1ooFdUYGM6HsyhmUvRQg+xtOafZ7JJxF8qdb/K6Yxf/49eNXotjLmAYB8KE/8ofXGJgvocjOLo61rEjjqPfoCtITqWCtccTejZUKUcdQ3YHyOG6hHiPEH6EjBX/AmKI4kObMIEcZhn4nPHwJ0x+N4EekyBohHmuuCsZpeSWPtkm+rZqu4bkTnqVG2GXcubLujbs7L5EsieXvNbAmRlnwBVs88znq/lKU5q6D1mGJzsZhRSk2s9qok0Tg9ob/9D+XYOXVhXKL8m71QU7bdpjh24KFW3R8sIEQdxiUrdwE7UGOR2qJcB0ZAQoUO+JLoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b32309d-e485-4b82-c87c-08df38cafeee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:21:02.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2SKSxzkvrtWmGuUA4cu1UbGRVnbj7nMFxG4Y7+G5v9L3lUPbQ34FcsncJGyJzPRIoEcg/N7lITQXSOFqnQhFcsotSw1/EOOVRYtIq+gK7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Thomas Lamprecht <t.lamprecht@proxmox.com>
> Sent: Sunday, October 4, 2026 9:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Kwapulinski, Piotr <piotr.kwapulinski@inte=
l.com>;
> Don Skidmore <donald.c.skidmore@intel.com>; Radoslaw Tyl
> <radoslawx.tyl@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Andrew Lunn <andrew+netdev@lunn.ch>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Eric Dumazet <edumazet@kernel.org>;
> David S. Miller <davem@davemloft.net>; Viacheslav Tyryshkin
> <s@tyryshkin.me>; Melissa Romanus <melissa.romanus@proton.me>
> Subject: [PATCH iwl-net 1/2] ixgbe: fix NULL pointer dereference on MDD e=
vent
> without VFs
>=20
> ixgbe_check_mdd_event() treats every flagged pool as a VF: it clears
> adapter->vfinfo[pool].clear_to_send and pings the pool's mailbox. But
> PF queues can be flagged too, and ixgbe_msg_task() calls it on every mail=
box
> interrupt, also with SR-IOV disabled, where vfinfo is NULL. An MDD event =
on a PF
> queue then crashes the host in interrupt context:
>=20
>   ixgbe 0000:01:00.0: Malicious event on VF 0 tx:80000 rx:1
>   BUG: kernel NULL pointer dereference, address: 000000000000004c
>   RIP: 0010:ixgbe_check_mdd_event+0x124/0x160 [ixgbe]
>=20
> With SR-IOV enabled, the PF pools follow the VF pools, so an event on one=
 of
> them writes past the end of vfinfo instead.
>=20
> Keep releasing the queues of every flagged pool, as PF queues would other=
wise
> stay blocked, but only notify VFs. Check num_vfs under vfs_lock, like
> ixgbe_msg_task() does, as SR-IOV disable frees vfinfo after clearing num_=
vfs
> under that lock.
>=20
> Fixes: da3ab95f9b06 ("ixgbe: check for MDD events")
> Reported-by: Melissa Romanus <melissa.romanus@proton.me>
> Closes: https://lore.kernel.org/netdev/bqzPMb-
> F5iRWe7S2DWkQDhsK8u9ZoIaK34sF2pHpAjP6WHFb70Weq3pc8ZIVUoIx2EbPHd6
> HLBzz1HHd3xb5rxRZ9F3w1L6TQAd87S18CPQ=3D@proton.me/
> Reported-by: Viacheslav Tyryshkin <s@tyryshkin.me>
> Closes: https://lore.kernel.org/all/abc23ed3-f194-4546-bf99-
> 7152464b93e2@intel.com/
> Link: https://bugzilla.proxmox.com/show_bug.cgi?id=3D7874
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index 431d77da15a5f..7edb84986a312 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -1444,6 +1444,7 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter
> *adapter)  {
>  	struct ixgbe_hw *hw =3D &adapter->hw;
>  	DECLARE_BITMAP(vf_bitmap, 64);
> +	unsigned long flags;
>  	bool ret =3D false;
>  	int i;
>=20
> @@ -1466,11 +1467,16 @@ bool ixgbe_check_mdd_event(struct ixgbe_adapter
> *adapter)
>=20
>  			hw->mac.ops.restore_mdd_vf(hw, i);
>=20
> -			/* get the VF to rebuild its queues */
> -			adapter->vfinfo[i].clear_to_send =3D 0;
> -			ping =3D IXGBE_PF_CONTROL_MSG |
> -			       IXGBE_VT_MSGTYPE_CTS;
> -			ixgbe_write_mbx(hw, &ping, 1, i);
> +			/* indexes >=3D num_vfs are PF queues, no VF to notify */
> +			spin_lock_irqsave(&adapter->vfs_lock, flags);
> +			if (i < adapter->num_vfs) {
> +				/* get the VF to rebuild its queues */
> +				adapter->vfinfo[i].clear_to_send =3D 0;
> +				ping =3D IXGBE_PF_CONTROL_MSG |
> +				       IXGBE_VT_MSGTYPE_CTS;
> +				ixgbe_write_mbx(hw, &ping, 1, i);
> +			}
> +			spin_unlock_irqrestore(&adapter->vfs_lock, flags);
>  		}
>=20
>  		ret =3D true;
> --
> 2.47.3
>=20

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

