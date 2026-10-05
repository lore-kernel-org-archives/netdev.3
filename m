Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02EDF6C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173648; cv=fail; b=tHTNjPPjVZZFekJcViUVXWPC7uKp7XAPZcroV7n+ILrNeaO50vNrjsA3S++3ihAZ7INF6l9+uwgIpVye5fmtarwgxRvCxeXGJD0JpEsiyfUDUgc2j8L1et6/wFVihKEveDd3kr21i7xpXVfA0bglejH6EvqpYHs2A6TmG9Q95D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173648; c=relaxed/simple;
	bh=whA5S/LTZ4yP73WA1R5KTm/4x6+4aR+Gv0mY1exy7o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gm2wd+G3jJ0Bb5+OQ5bcUrzS8jv19fbvtMY06OMhn8uh+N7MukHcizHlfWHSkz/vpsiCcBMHjCZS0YWzUmN0QKeUkK2Ncr+zMLW878A6e+8YFYxrBTh8O5QwqAYRYXx1/ugzF5T32h/wbUDHRlGbLkpSfmHYkJSUlMU+RMWiqpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XptQa622; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XptQa622"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791173648; x=1822709648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=whA5S/LTZ4yP73WA1R5KTm/4x6+4aR+Gv0mY1exy7o8=;
  b=XptQa622HGURLOz1pBMJpfrDXuUr7hIQHqCWv856ZM68fWHwrRskWvj7
   9fyIx4Yc0tQMKlURcjXbBymnQYGBW6pZngx5qF4u48/Gnq8hHm4YSM85b
   WRcJq7NyQXfoWk/xdlGgqm+Ld03eUxW8OTWZb06I5dOirg8TVE6x/jJNj
   DTerSbElbd6TQlnPPy4zQsf0hucmtvsk7Up1gpi7x6p/VF0nvMWHw64pK
   +8Crbcub1o0W9McHx+MzE59ssvNTC5gegY2pbUJxoe7MMOJlCxMeFaW4K
   zfZbEH6Gswv+Y3SInFNr4glwfPWDYgqYaNIm1a/gzTKJ+4c3Sw3ii+f79
   g==;
X-CSE-ConnectionGUID: vUaQyS0fQxeY7RZh48zQgQ==
X-CSE-MsgGUID: nFyaIxXgTaiEMya4bQsETQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102417761"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="102417761"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 21:14:07 -0700
X-CSE-ConnectionGUID: G56u/sS+TYq/whPgRcFNuA==
X-CSE-MsgGUID: LB7UHaMGSxOr5q1js4uTAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="275889681"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 21:14:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 4 Oct 2026 21:14:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 4 Oct 2026 21:14:02 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 4 Oct 2026 21:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOT2ql2sBWKGuMK1u7Ecdp/dq/U0Qp8f6DnzKvHmJp58oiAMyfU4eeF2QyKxtPwwkZcCjAisaQEGwmtOulS8wx/7XM7ROTzo4p4rZGgWjS0bLWf1PnQzpzJivoH3OpJE5mDutSi0o63ONpMpfbVx5TPdYJrksRtpP6QAzRqe6MDBg3Kje7KAe9QfLQDcDhuxS0a3SvQ4x6kruIhjgP1Nh//srY7+JGvcQS1kEmGJ9d/4HSjCfOhFQc4akN0Rjlf2rQK5H0zzrXUqlvJlNAP6WUav7eKQle85Lk7rF8jSQ57reEQKfI9WvArEkwib0vJ8OVhuEPMH9/YLU3UmKyD7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlBMMCXSZn/P3IzY9yAeSQWI3WqGfz7pnFwJUc9sjEA=;
 b=hp6DiskYb1xsjpVa90jEcpRkmI7gzUHmQqAxaNd/r3JpR7dCQDPGpE5gi5lNGC3/v1Rwq41mTtKrbu0Z+yuWWg8mnixh+nFPhioBNmiqcUvG73/U5Xi1EzmJAmPO0m1oiSqXZQRHCpMj1uLqV21n0jgmbnTRCGAz9y4mVwbPwoSB55ByFwTRWJb+zgn94KyRIg6LaWmt9BqnihxegeHd6T5rb8+mnhs6Ei67D1UC6QNGSt10MCaB01QB1RfsBsKoF9LsMzFudp37INGsoXVfbQvLaJ8fMX3LdWZlDpHtRQqZrnmTMXeyfVhyYZOo/XQTaIu+63tLplPMMNIT83q3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 04:13:59 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0451.022; Mon, 5 Oct 2026
 04:13:59 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "lee@trager.us"
	<lee@trager.us>, "D H, Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle,
 Balaji" <balaji.chintalapalle@intel.com>, "dasshubhamk@gmail.com"
	<dasshubhamk@gmail.com>, "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: RE: [RFC net-next 0/2] ethtool: add interface caps and PHY tests
Thread-Topic: [RFC net-next 0/2] ethtool: add interface caps and PHY tests
Thread-Index: AQHdUN6ylP9egeeoOUGkKxZvYz8g4bbnJeKAgAc3ZJA=
Date: Mon, 5 Oct 2026 04:13:59 +0000
Message-ID: <SN7PR11MB8109460641FC15211D8E7708FF962@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <20260930132151.932792-1-shubham.das@intel.com>
 <fdabe2a5-d198-423a-a9f6-1bb842b8d372@lunn.ch>
In-Reply-To: <fdabe2a5-d198-423a-a9f6-1bb842b8d372@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|MW3PR11MB4745:EE_
x-ms-office365-filtering-correlation-id: 35c42563-d8ec-4225-3ca4-08df229714e6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|38070700021|56012099006|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info: Pt2uxTHNG3OjDFXs4IPEncL2p2FDZwWiPxN5QNSGMDdlpLrS5DY+ZY2VjEY1hOlGi6Eb+ShyBUwIMHGQFRkNeq/d9zPrY0HIyRa/UTlx5ra4wcaBrWyqKfXCfld3QAafXkvJSNkWOy/L7KvrDhC2grS9weDTpInyq2gQN+LW0l+6gqqruLTqvqUPy95xTjzXUxYjdy+kTP7Qvr3ufHqb77J9LV4Vulz7cPrBQ//knjnDE3jXbWb+V19Thj4BUG0U1dlfpoy7YPprY0N2/oa2lDp02T+qsBX8PjNGsbdGTV7sKtWrhiDTL7TjYj3kpyeYN94ZN2mh2BL+W5FJlCJniz1i5HNlKjv23SozZJXrdf2ItXlWXup9WSPwgGmr/un2Niz106V9G9O0TLRUZJvI+1PhRMMI3NG9letI0BCUl+2Nd0mxAa45ssSfpdcxMa7obVAHCYDlgA9zJEJoCU7/+v7fwsJ6BHEP3DqdEc1Rxy7nlE7AlE9SXeAf9B67jhWuykuWvL1o1MgyHhXdFJZdoRHOGg+BRpbgj0wl7VcdF+/3SEjEKv+o1/GZZabdvIALnxZk+VDpZgqtKGVems04hHTv5GfzKzrrKMz+uGvROl/5/kQHC9hiuD1vyn9+gmrVAD8Zux5BVNADGJ/t70vfuH3V+nmn9nxe9qpNBx2+4TcI0SARs55DJg2k0r5OdEQhwfXjVJR3Sx9xoLgV4PkKugw56x2gvS9deC82uBl+g04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wr0IEOLH0FO1HZrye6YeGYYvJ1gXzCqP3rAuVachoCeyEt3nloQMMu8r9D/2?=
 =?us-ascii?Q?PbXviBEY1ExYp5qvErte2yZE54/5/6BzKgSOExvTwYu1r38ATIv33cpcMDDx?=
 =?us-ascii?Q?iJXtgUbZ9j+CZjI1wQj25nmTS48nVwMLFt+ior7mJT1HPoc1ynJqobQyZhTH?=
 =?us-ascii?Q?aI3HhHIQ5vOWfr6TrFziz2KInuXgRiQTPeImoMtFn8Oqak19ZEBr2j61PNlW?=
 =?us-ascii?Q?4/zI1B7hg4WmMdcjNuQqiN+tmlFBHct1YfX3oEpZN3yyTxkfWz5ZcJB/bMm5?=
 =?us-ascii?Q?mSnadNIsrvUdHqCGvQ+oiM14AZYaMvjncOb4qrWVvBAfdO5vmwu/V8sPN0h9?=
 =?us-ascii?Q?q57FEt6Oqbbfl83lhDnkFW2WLoJB9p/3AcN37OoJ3MM79df9LKUxY5R5aEh3?=
 =?us-ascii?Q?Q1BlKim+yz49FvXPhoVU+IoTnCc0dL5w2Fu8lbvBouLzBbvZl+fV3diwN3Va?=
 =?us-ascii?Q?1eAiGvBBzm7DUvl2a0Hf2S8Rwr+fLJaoWjqz1f88O8jK1UBN5fD9GKH4MWC0?=
 =?us-ascii?Q?PMEC0IXN3iia1BA8KLtmpRxUUwt1ieGUBf8P7CkDEbd1TGXCzPcQuWK+1qQI?=
 =?us-ascii?Q?TXvcnZBpe0PIaLJDTHr+fMf/xNIWpc5xzVvgKjrYxZYVRsgIw9K4ERFGpc0M?=
 =?us-ascii?Q?CT5X4Rw6S8B6cU3BtZl0KFlw7SSmU7fhIOa+8PZTTQq9kqzXxFKJa6tuCnvs?=
 =?us-ascii?Q?nw4j0mavhM33ZHwTSRWX3iQrnboHGhtxFHTKdqDOlJw4sA5aW184GvBc4Bzp?=
 =?us-ascii?Q?G5id46AN/r8IVLtjduXht0QY8tTJqthofg7006mz9as1GhrOaoi/A+rNKZNe?=
 =?us-ascii?Q?5VJDF5HGGIp3XSGXwRh6fH7t8ChGz/ejIp6Cs6AudrD3cf8Z9Vfl4qDUV4OY?=
 =?us-ascii?Q?U88KJ8HrJQh2361f1cy2iorzxVD0Ca00EIrFZrsEVnAQyUWgGmb93aG+c9g0?=
 =?us-ascii?Q?ohZB8BTIoBtcqk+JKLQlKaBm5Rstykdbs29BGND0/BZdzGzdl3iwoBkBc3ZF?=
 =?us-ascii?Q?jWYYWWMHrSAvTM1Luy7Cl7D0uh9gUDioU4RdA3H3HwEpHmGIr8+De/ru6wF8?=
 =?us-ascii?Q?Y2g4YgABGA4CIp81bOPqL5a4qQ/BvYq0dJZb9x56xS0NKI/J9uWPtiF74Nzh?=
 =?us-ascii?Q?lfhprdLU4TbMcHg5W6uz6hwo7KCbIhVMECmovN73NZGwZ7oQAwLoWSyIo844?=
 =?us-ascii?Q?R+mhqZ6H5EgJa7CI9Bn2p5LctNLLfsQk78aVGtWAeIG54xnh++KixOlwF3EM?=
 =?us-ascii?Q?kH2RKZ5I8VV1UjLwDtVplgQo0tAswO6vEpSuKsjlb3rVZo3rTjdjuv3gUV22?=
 =?us-ascii?Q?kkFj68HJHgkqeDaVCVwoX1sU7TMdmVboH2R0GLL9Ybu3To2yQ2jg99AYTKJm?=
 =?us-ascii?Q?AhulVBkA6VwtjUIPfNVJk/mL0Uz/fXrp+5CLrQCGxp5MrHl5sdxKNXPKvFhu?=
 =?us-ascii?Q?xshLOUExFTa/v+okGEbcIWLmsfzAJFdDaMZCo17fRcK//rW/F9PXD/xIWc+m?=
 =?us-ascii?Q?N3W9fV0GIvjzALJRjEh4j1pFFzp16C3ZbQxvK8oOg4zOMjRU+ZuSMOhTamwH?=
 =?us-ascii?Q?Z0QtZLuWxM1IC7HI6K9A1oVMIL/3ixYrnpGUJMl5EtS/+xpfSM8+kWnaCsVZ?=
 =?us-ascii?Q?HpGmVwBVK37nudD+LM/lU58nP640fBsRCbEEg71daZrpOk6rGOszYf7BZvl/?=
 =?us-ascii?Q?5eDVy/VMh20BxTcoCQyrNNjxzflEVwPBBCsGXeAsome6+LVu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JZVZwJvfYIK+aEDGDP3ViUUgqSNdIWGJuWBeDYMNJbZkAyphaoErOfhRKaVfjwNKSYpWA2k4YhHOFKgBm33v6P/3CJE5R+hvxnVQUa2TijRrNeisiZETSiCNFfoYbDpEAtSqvB0r0u6Sdk546Q8rN/SjTRYzQM10fJ7cXTg/kq1qRmNzH9TEc7zXRDu2bhRjPtrpzC5qYLhaRMPuEJMResedAKi5RUJ4l+4mOm9tNQ+xOSSxLa1hTKi2snchV8LQIO3cJn1eG4g5a4YklSHDLm5YAT2a8nWDuf0SOLcLYablWPcuu7cBJn93GcSSdaj1LkmwASB0yxUbPw/kfPOkIg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c42563-d8ec-4225-3ca4-08df229714e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 04:13:59.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6LCZugvQBNs/9TgRAWTFk35mkEeMw5AYBEVih0uIrNE35csUGN6gZfN7qTS91QSTNWKMWToW/clI2u58UsjTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

> On Wed, Sep 30, 2026 at 08:21:46AM -0500, Shubham Das wrote:
> > This series adds two new ethtool netlink commands:
> >
> > 1. intf-caps-get: Discovers the functional block layout of a network
> >    interface. Each block represents a hardware point (MAC/PHY/MODULE) a=
t
> >    a specific 802.3 sublayer (RS/PCS/FEC/PMA/PMD) with its supported
> >    capabilities (loopback, test patterns, BERT, error injection).
> >
> > 2. Add ETHTOOL_MSG_PHY_TEST_GET and ETHTOOL_MSG_PHY_TEST_SET for
> per-block,
> >   per-lane PHY testing using test patterns, BERT (Bit Error Ratio Test)=
,
> >   and error injection. The block_id from intf-caps-get identifies which
> >   hardware point to test.
> >
> > The block model uses:
> >   - component: identifies the hardware entity (MAC, PHY, or module).
> >   - sublayer: identifies the 802.3 sublayer (RS, PCS, FEC, PMA, or PMD)=
.
> >   - instance: identifies multiple instances of the same component, such=
 as
> >     internal and external PHYs.
> >   - depth: identifies the host-side or line-side block within the same
> >     sublayer.
> >
> > Prior discussion on this proposal:
> >
> https://lore.kernel.org/netdev/SN7PR11MB810923BBDEC398E860099150FF1B2
>=20
> When adding new APIs you also need to include a user, so we can see the A=
PI in
> action.

Thanks for the feedback.

The intended users of this API are the IXD and IDPF drivers. The initial dr=
iver support
has already been merged, and the PHY test/capability functionality in this =
series
has been implemented and exercised in Intel's development tree.
=20
However, there are still a few prerequisite patches required for this funct=
ionality that
are not upstream yet. As a result, I am currently unable to post the corres=
ponding
IXD/IDPF changes that plug into these APIs as part of this series.
=20
I can share ethtool command output and test logs demonstrating the API in u=
se
(PHY capability reporting, PHY test execution, etc.) if that would help val=
idate the
interface until the remaining dependencies and driver changes are posted up=
stream.

>     Andrew
>=20
> ---
> pw-bot: cr
