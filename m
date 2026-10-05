Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174854707B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173454; cv=fail; b=WtRIMkBDl/ApZqFj7WSVVNjdw2rTfpTXsQx1jlh5Fvj//T6bkmD87R9DhVxBKrMduTqyOXCeexaWv3bAO6YvdjjYhZeIuBSY6lvFgUzcX6nJcy41L/1LudgMSIqlMWZJzXho4s5yGXfRBrvW/thV/tei8IEb2R9eExi7nxQ5h10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173454; c=relaxed/simple;
	bh=6JNfSP0XrgkOuIeYrM+2WhkRYf6mNs6yr+COZjmiWGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dZdCWs6hr5g/Ba2ZTCHGwnlOM2psHDDTbhLxnks049Z7krSsLPXLYlmVOvx6I5h4k2bTkX7tLVoI9Wh1o+3XiYOv3ZumC2TzdZgNFlv6YnPMpNm5izI1KamGpCRG7sExEUJ+uy0Praf/KRavx9De5vIu7KW0+jshfuQMvHjuRx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts7p4SoM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts7p4SoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791173452; x=1822709452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6JNfSP0XrgkOuIeYrM+2WhkRYf6mNs6yr+COZjmiWGk=;
  b=Ts7p4SoMkdNPZ7DWw5wFMo3wUIlPntBX1Zt18dlMiiI54AXZd0TDHZf1
   TsjSgJqjtKqFZdroYVCfoBTrR0WXuQhKfowUkxFeP6+KpCcbR2yDJ54ff
   F44cPRqGO+ie8Fq/Ivs3+ZDhv+6Vn6A05Mh9fdChYMOcND0W24BNv0WUc
   GxFucyPh9vnvz1kI73EJehspqN26h/Btu9LYhiZGBVgL2BuPfstOf2PJ4
   nZHHXMiCJMA6ZBJf+Hz3apYg8TbKdEFuo0+3G8S5WYendnQGz+oWHAQWS
   qQx6LkA0BtJTSVAXVBVXeIZxGBRUJ+sJ5EElZNha7r8S2IhY5RMvRLXvO
   A==;
X-CSE-ConnectionGUID: 8W/o8KdiQl+DWra+kOc8lA==
X-CSE-MsgGUID: i3ebFR6KRZqNR66ffTBoaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91861294"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="91861294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 21:10:51 -0700
X-CSE-ConnectionGUID: H9jEADzZQAOh+NZ2WKWFWg==
X-CSE-MsgGUID: ZY43ub7QRh+E16wz3VDVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="314730698"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 21:10:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 4 Oct 2026 21:10:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 4 Oct 2026 21:10:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 4 Oct 2026 21:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQG38YKOc2v5/Ok2/9lpEOBJpXweRz3q6WZZEyWzjZKKPL74hUx1pY2uC/aODpY+ZqbfXuPlPXNG8PYgoUMoS9Snyh3m/YnORN4pL4L+ioxgfZFdg+fV42WrzRgSvWyUcLVhvIe689Hxv0OJa1m4n3WPdXGNnIxdyKe7PDe1LtagX359M79T/NncqyZl3c42PRsiGpTFn91KgVb5sWPUX1NeY5xP3QNTfkV0LziXkzo7LddYf3xha0m7hosAfTnGiIG7jwxWB946HtfeI0f0mIy6OM2RbLG5IUTozoFo/FPr0bCCOfc91ut6kNRoTlbYJFPXkvNzEZ5pynSG5v9SWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gcr20nGRHPD5nxM6TwleerOEBfyMM+xh9uAx814ewg=;
 b=bjE5p79yNlDeIfQZSnWG0d7yobVukk/XfRxhXmboBDuDqA7VppGD1QThWYuG1b4ye526UdYlMpdGybo+WB/Rw0JHB+HpHzpNU5bj8gUcwahtWyQJrP7AljaJFPIHWAvy2gXof8oCMDxxDxkOueY6imwjFBwTRa4k0o0yjzmIcmBrnUsm7XZ9y2WCk8isGyEdIfwkxFNIFR7uZWhx/rxf+8My61zjsCmVQ+F/n4QgWZetSgdqvJpNfhnyUm9jsBsyT0B3d1c9DNtyxl9L/2HwL99yvag6sK+zWbjToDcN24WODL/MziJ6vnAP1Ngx8o390nJxyq9CeS4GCiHcADWxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by SA3PR11MB8002.namprd11.prod.outlook.com (2603:10b6:806:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 04:10:33 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0451.022; Mon, 5 Oct 2026
 04:10:33 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "lee@trager.us"
	<lee@trager.us>, "D H, Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle,
 Balaji" <balaji.chintalapalle@intel.com>, "dasshubhamk@gmail.com"
	<dasshubhamk@gmail.com>, "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: RE: [RFC net-next 1/2] ethtool: add interface capabilities query
 (intf-caps-get)
Thread-Topic: [RFC net-next 1/2] ethtool: add interface capabilities query
 (intf-caps-get)
Thread-Index: AQHdUN6+lU/N3U1doU6Ok+O8SgWnnrbnJEiAgAc4xTA=
Date: Mon, 5 Oct 2026 04:10:33 +0000
Message-ID: <SN7PR11MB81091B45B28D2D1DAB9D5D9CFF962@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <20260930132151.932792-1-shubham.das@intel.com>
 <20260930132151.932792-2-shubham.das@intel.com>
 <8d44e2b3-532a-4c82-9458-40ddae333593@lunn.ch>
In-Reply-To: <8d44e2b3-532a-4c82-9458-40ddae333593@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|SA3PR11MB8002:EE_
x-ms-office365-filtering-correlation-id: a37c59c6-2698-4f92-77ab-08df22969a08
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YKxjk1mkbUf3vYC0DWz5wD2nR2SLq5XED7O8m7Dt1muodmMhL3lp+vlYotMMGpcCNRjzm4odkBXwzHXicdYPKiW0pA3i187V2DkxqD7PCuk23wHbTrE3Zr/DJ4yQ4AWaYTtL0ZA4weyBC0/TQtPXevlh0KHKSlycIyrUgwTwfGAEI9k8I8LvcW5ZRC8A+L5zxsDR6wBSdy3ebHNeOd0xsgDtcHbfhOj9/gG47vQt1gEuPlOt3k1uXbjKj5PRyevLrrgYNjRjU4B5ne4KcQYWtPfcjE+ujR5hREDk9zo6Mau9AiJDi7uR5HZzHL6Aj/+veTPJ8Kxv8JTmnNOzLY6KDB6z8wgQl3BE0hvd2thM0DPxiWzr2KiZeRbve9V13iqJ9H3czzQSknkjo1LQWO9gzn9TgvqLliZ/x8nlSgcCtUMMVkU+0eC7OXRUH+JFvWOK1ed3/fth3wmk+s5EHwRgHpQlbCNIwfdeA1ifPb5Pj5LsIHSUkqGZ6P2NGdvdsN54NUwQJohhnvXUtlY7YFt+lBlF6d2+4hqK9TVIvWILifsjQbrYWiZ4g5jYEmRLCtI+H2qfy7KGzRYo7Bt4TTFOSvpCjjd2BbG1HJ3etMqet/PKnTKZ23MFWn107iyZ5Wkb0SJ/zjOatAnk3nP3badJWze5TbIHzwVtS+ov6ICHK9JJRwx4xToKKIwLbIQt++kO7yFoblXPFwKK+jFah+uVfzatZM5aPsBhSThy4pySjDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2KAg4EUuLdW2Jaz1/tbw5LWZlbOjWaxovijRhP9gJWJwKS9kMFuYaH23QHKu?=
 =?us-ascii?Q?fDhq4biK5GLT5KTGMGT01I7xBO3JSCkSChp/wuJY7pB3n0bwEYj39e70M10f?=
 =?us-ascii?Q?hx8dUtjE4DfJPxFbMFPf4eRUfUf/hYmjWK9hmV0U9pXpadL6ylscusLLAMk8?=
 =?us-ascii?Q?LYtAAXSn9MkB7YCeEIWKpJJHs8puUHfAQgImOoYThgYf4OwQ5IB6DoIaqrMO?=
 =?us-ascii?Q?QhDpsEtkXJiStHZde3P29Hmo3r+W7hgahEeFXXZ6mMfIfzp+AqU7ULdbceix?=
 =?us-ascii?Q?QU/VL6LUenUyKkBOHJF5sfU5R3roWMgBnFy3SJ5DwDDLy6zhFonx0JbbOii2?=
 =?us-ascii?Q?Ox33bimQspvvTxuhiv1KR+ugk2QwMM4uAXzE6Jr+cPOk/hQn3Ctxd/gyu+Is?=
 =?us-ascii?Q?2laL+AmXNGvp9+q8T3oq6In+n5idldTTve2u97aCZB8Lciuet8nc08F4bH3y?=
 =?us-ascii?Q?J6tZllGU0V3sb9WRDQLzxiucPo8d0TsD6NdGQ+j1t973ASb1/s/k7VTpKXhY?=
 =?us-ascii?Q?c69fpId/+2GAxwhxyll9Per4p4LGnGZjzt7OjqJC/NZ05icQJuM3/533zdgr?=
 =?us-ascii?Q?ZxBwTtFCimOXWh+xEp7GDIh6bFlCYu3NxUWbcLNzFaSEOl1pH/DIUzMfsaix?=
 =?us-ascii?Q?rCMoywb4y6pX7fy0UnjJb+/Pucpoc30kjdtsoQQAr/04E8UbL/1mZDv132CI?=
 =?us-ascii?Q?4I9rqtV00Ij8bM4UDvnxlf/EhBuDV/bRPCU226gXGPIw9TOtfqAvOLbVb3+N?=
 =?us-ascii?Q?1yQ3aHqlpH2F7AwMas6ZAMBaFFT8yRKBcA7rnv3BTmYsUbF9zRUi7ZIuHSWa?=
 =?us-ascii?Q?sBg9AwkVUMVc4qSoFWg16iBq3CIbLOTmJQ/S1qS9n4wsyc4byHn2+T9dWqQY?=
 =?us-ascii?Q?n4Dq8EaPuwfHCtNmrqX9izy/7oL6w7o/mvn3BJerzKKrAV5t0mPK76e7uJq1?=
 =?us-ascii?Q?9ZuRZZW4XGkTyeixj5S/rQk/fqUroefEcYb5oEZhVLvonsOFNxPNVVxIPg3T?=
 =?us-ascii?Q?UBij/hFGpT9LLVoXSMRd6LLB7SRA9SeRWU0wqXUadl8Ek+WIkKvUbmx2kF8p?=
 =?us-ascii?Q?Lw4bxhdKrJq96lAQwIEuKiLRkfXMQB0i7gBnxCaC5tq/+SAubskvgfOciery?=
 =?us-ascii?Q?1iAcje4nzu9kK5Ce4d2nSj1MDvXxnXJ/UDyzOuvOty5o5gvzEQil2Jl4devh?=
 =?us-ascii?Q?aQYi4ztLNtzf2LLhMOFbtcQ1NVUgX64f/lQKuDW7Y/e7Bc6CKQpPe6tsuKaQ?=
 =?us-ascii?Q?sasaIhqcv1O83U2pJF7PTYuRiksSe1qhDLxCKTZ/LgWYxIn+6ivDMkHiBTaP?=
 =?us-ascii?Q?AGpQA4mUMoAEZQTXSNCtijgFcaun9LMIq60XoCs2ulJyTZ5yQMZO7pt0LwIp?=
 =?us-ascii?Q?1YsMc53Yp5CpgDQbhxImEGDQC64lrSLVYuIQ0RsxfX5YcZdL3boNkgpCFu4A?=
 =?us-ascii?Q?nZeIXdZVtPrcex5O7pZhrzabGaBA4a4c75KaupZ0dPyqDq5xUuUFjO4OeJ80?=
 =?us-ascii?Q?4UIjtC4Lbhm8vAbJb5efv8li7Lg0iYc1KCxTZgRUDrLuy/eKHu9pq04QHoL4?=
 =?us-ascii?Q?+b3V96lw5IKEChViQamryBelofSZbmNhlfOTFDXXlNifaquOPy/f74JcZfG7?=
 =?us-ascii?Q?dhAL3BK/+3x4IvIUICOuPsjWrwpk+RYcgZ2i/D41EBnV2dkE53gX/ZW2uwHf?=
 =?us-ascii?Q?QWE8jSjwBAXdd4UdedmUqYcYF5QEZqiQ7okJd+OjfOJbdr38G7lCAJAxZaMs?=
 =?us-ascii?Q?qeTndgP0kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VSGqCieegQcYsR0H7CSshgh3ZyuKqNIJ6foqmyf4NKKyziiZzOsnhrBmdBaWb77f1Vg8cdObUhAivJA6ppv6994Sir8QM9IuY3zOvDBUZpqK+YpFia5UznSmaThPjU28acG1MrnS3Nx9hWL77Yi6/Qq+p9SW0xTYfUTMj5wbMLHtPUIN1gNMFq+PJ2AAinFQ7qtQinFEsnJqwD5yEEGxlk/4YE0UVjn/Mnvzs4CUpVs/pPO1xdtUma0K7jWSPGZFowSNkYLuhkBDb1VdtMwDgLiZC1/4zHRL3CO1BGSzMw7IcGeuKLANBLcak+o8fhpdbJJ7iCYrCbFGAugcGxPdBw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37c59c6-2698-4f92-77ab-08df22969a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 04:10:33.4053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjQHkdfbx+ayQY0nGVWCAAIRucanSZ7r95y9W1xcRD9rM1kzn11GMCZt7Im9ZnyEXSEd4Z07ZaNV5JwLNxfZbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8002
X-OriginatorOrg: intel.com

> >  extern const struct nla_policy
> > ethnl_mse_get_policy[ETHTOOL_A_MSE_HEADER + 1];
> > +extern const struct nla_policy
> > +ethnl_intf_caps_get_policy[ETHTOOL_A_INTF_CAPS_HEADER + 1];
>=20
> That is odd wrapping. As far as i can see, no other declaration is wrappe=
d like this.
> Is this because of the 80 character rules? It is better to keep with the =
existing
> coding style.

Thanks for the review. Agreed, that wrapping is unnecessary and inconsisten=
t
with the existing declarations. I've corrected it and will include the chan=
ge in v2.

>     Andrew
>=20
> ---
> pw-bot: cr
