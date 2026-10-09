Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB24EF143
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563321; cv=fail; b=kWPTaDWzGl5RdAhe6xj1Ohh50jwUjAMLfsIbn0DW284FwWSFTEHz5J+iQIwGYoIc/G72aZGZvBAigT6tEafzqoUUnMOysFZW2isIGDUP1sRXH1mVO/wXGyS84GtcOBxVNNXjvLszmahT4KHtnVIsckKgRRHg9MQOGE9W4OfZXOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563321; c=relaxed/simple;
	bh=JQN6agKWFrd6rxxfdks/MnbYtTCmO7qX7ow3toV/e3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXLwaTUiLT/cQ7y03T1I8+YSr3nX1LpOFJ/bwXCwJQV2n4v7NLRqQMC1jwxvHPLtWXogHEoJ6gFXhflM3xbzxoo4Wa2r3QwySaj/6nRVYxSZTb0WzGYOXpPV8uGBKMJn4OoOptrMChbSMHkgTnkiQgojeFcRfgu3cDzw+kYy8lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWSYily7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWSYily7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791563321; x=1823099321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JQN6agKWFrd6rxxfdks/MnbYtTCmO7qX7ow3toV/e3U=;
  b=WWSYily7d7q+KJPtUgthf3ASK9NLCCjxrIhUb5a17J4EftzwuVjTatTp
   Em/FKB/mDAnOywUCj2R3AsY4iXvZrTGkkGlr1Xj6PjoK5sJEsocqiNmtZ
   9hu8n1l8Q4BqB6P9RvfjxIRWX+LVZ6TFg4XL3YEc4+5vp8J6Sk0Bas49z
   z4LVChsTK+GbWxlGLtDZn+SdSIn0pg5z1xJJsGJ50zhbQJeKIjdHOm9Rv
   qrSNCiAYezu7pxEduTBhB4+OIEWyn84Wd94WCVY+aAo8YAHxjdopOP93J
   PvKXOfWA7yADzyIh825WCp2RAUHgeOza5TrvkUkuzP4smyMQdmeP1gPTp
   g==;
X-CSE-ConnectionGUID: Chc94rLJTP6EaSoyKoaS3g==
X-CSE-MsgGUID: Xsl/gtrHShuGde0yvZqgOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="392709"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="392709"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:28:40 -0700
X-CSE-ConnectionGUID: /rwEf7U8Q6uHSyaWAzYwvg==
X-CSE-MsgGUID: srft0m/9SX+U+996TmUJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="467897"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:28:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:28:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:28:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utNm/prlzhHQVdDUi56cGZ632e7jbSEVrabPYlzQwIk3XZETuOD38Z0OX4TdVBI/AKJqQsIyBMdlpfJUkpRLEL0VOF1QiVmYpD+ixrZ+R3vzDIHFXTbFp+FMsZ8Ekg3EfYTemNClXkwIHcACovUrZ6iEVHlRZ7B3pBP+bgL5hT4kQUzqSCroXpuPl0sSC5AJyntQch9o+zM5D6Pg+8ezY8lZKIhpWliWyG7hJg7Sd6SLCrd9keRKIPr9nagHaFBWiiPxcaO2peRa808e2qw/+StlZh/2khuNrIcHn5zRY5SRcwiCl//wjP9tJfK0ylJY243JY9l5V4dzL35NAkGSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEtwPm2+x67/iov5sS+668nvt0bQBRIm5UifWmRfddg=;
 b=HOlO6IWVY/LT0XClEzDfmQosmbEqwXQgf1K7r/ysineI8w43OgnQ6NjDSAL5nCYa8w3ToyAqW4ilfuhNL6l85Cvq+5XfP7neaPZWI+OTtX9v4ZC+NzqdQErYIruEPQJzEZtOsyRqalt4hKcJRVmMRxLkDZ2MMnnVxH3jGzF1nvCduvOdXTCtn1xt34QyHEU+n/YRBgCiLHEYDnxVSHjBco6snugkAnwOIBQcDkSMowJuXOiWtMbAahaXe70uTzim/sp6cxPawBW4e04jtuAmjlmfn7qaYM/NwZfYKwa7YtEscZmXMyyMRUbfgCBOZv9v84JECPp5tGDzus0Lg3MujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 16:28:36 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:28:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Sylwester Dziedziuch
	<sylwesterx.dziedziuch@intel.com>
Subject: RE: [PATCH iwl-net v2 3/5] iavf: prevent VSI corruption when ring
 params changed during reset
Thread-Topic: [PATCH iwl-net v2 3/5] iavf: prevent VSI corruption when ring
 params changed during reset
Thread-Index: AQHdRRGSewswMlUh1U6euIsdThcB+7bUdiiAgCEVqWA=
Date: Fri, 9 Oct 2026 16:28:36 +0000
Message-ID: <IA3PR11MB89860927DE797BB5A0252E74E5922@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-4-aleksandr.loktionov@intel.com>
 <20260918151241.GM51261@horms.kernel.org>
In-Reply-To: <20260918151241.GM51261@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7152:EE_
x-ms-office365-filtering-correlation-id: c7bb0f57-9699-422e-9591-08df26225e5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|38070700021;
x-microsoft-antispam-message-info: +smPdlZgWeJPfm7+3jGgDghTq73Z0WZUMEzhmaGIycUQbzNHCsH6fbi62x1hNnS4z/J0y4RYdrFUyX19c4dL6uLP5RarQ6OWJlurY6YsgHRGIQh7+bVURIUUmLktdOBEBjMKoqOjIsl85z8Bh44vUsCe6kZ6VPP4dZ+AMZ2lqN+p6LoHeh053lsOiDSyPVqDyzi28fycByM4/ddqM4/i7pl1fWLTtu3DLABSXtkkQw/DGRA5cFtXyXL6r6UvJhXYQm/lCk8h8S5+/R4XAsgkQSl4y/KUo8X+gH1SEOxNktIFW3Zxc9eV3tfx55MTzQ6AFL71wnpmknPp/wyde2gx3bGTbJgR5MTlsqm/ScHhkaAH+cEWZufy5I0anBk4awuzTu4Fqz8Z7PgVBBT3zvIMa6Z2p7t4NGmf9H24XHAcDxCqMsN6y08Lnb6EuHZT+ftSSgKVemNEeSGIPTAuSGC2X61UP3mPvzwst1skAp9M0SjXwZqa0evbAKWPSXujAAPijwZXvrnyq1TQwii7v7+C3lRA+x886qfxr4pj2pK9Vvn6c7XORSLUPmze9k0HI/fpnjxk8xYmuLxA5dNdS+AVGXLaqProWtxEazBs336RSjCrwOWijDxIOQJ3pbwkX6n4d5RifmZbClI6QPeZDr0YSSKg7U3+PYdLUCpweJntEeA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EeNtHaEB4wdb3CVP52XT2l7Qe/fRVLGJzILtiuMF3pFgdm1PN4DbXz/wjvNP?=
 =?us-ascii?Q?RSoq+2DQfqx9EPNCD46PmWPfe748RDvuibX8Tl1M5y3jj6wwHHZFB6rRYwCF?=
 =?us-ascii?Q?CfoiL2bhdvHc31gyN8n2C58cp0/fz8itP1vVTs9UvtaHuemSVocaXh9lohE1?=
 =?us-ascii?Q?HRHWXPUH8sLjUCdeN3KPytAL1sXGo0/bpULD1vMJcU+cm+M0WYNa19ICpWRc?=
 =?us-ascii?Q?PgcXVvCOgc2YY6GrYDDLs5F7cyWeIYYhOSy1gYnOOs/opIdaHy6iBKJ40ZtD?=
 =?us-ascii?Q?BYkMEipyqnGHSkKhBAjZf/a+siSQ5g/6eRcxVZtlkIA30KIR3q0qTSDVVRH8?=
 =?us-ascii?Q?mUmPr1d9TQDBWRTJqZmNOCVGW4Q40yG1mb2E7eVwbwdjqgcP0DN+RQHmq3b6?=
 =?us-ascii?Q?fwY7r3+q6hUBLH5FSutkFsOZZXBDHKtM41ZYOuwPmQZWpV8Drqc8WYRMDu+T?=
 =?us-ascii?Q?U1IuCHn/HWUZj/ZKR9He5lt+ezofzKy/vdrLq5ScWJWlc7btNrBMDD+tIHeM?=
 =?us-ascii?Q?magORZ+ODGgqzjXfGCYvHuZs8HPjc4d2BU2R4KH9Y8rHrNh/CyDmDVeBR7mO?=
 =?us-ascii?Q?fen55gi3cpQU8M97b3ODqdDeyb78a8MAOajICUUERec5BRi1eE7g/tO0ahWn?=
 =?us-ascii?Q?+n3ta6nK39Z4u0tTv1mVW5vPFOumol9CCx8snDvF9o6AoOKwz8XMNMmI/nq/?=
 =?us-ascii?Q?3KsjS74XR9EvvE/w0136e6AYBQ2XCbjPn+f2KzG5TCyScbrimigMHhs99Ph/?=
 =?us-ascii?Q?kVfS1a/bMYy+cs39Wz2ZIsXUr5WO48VI9n+0wYTX/7yuXgLz2omcW9rJn+2o?=
 =?us-ascii?Q?sPFTQazG36FtfbmXeMrc3BHSTSWfEzpWVSjRxvcy8oUATKbUq4KSYg8N++v9?=
 =?us-ascii?Q?PskdCNJdfUvF8RN36VX0ziNHLvRzT/fCxx94qQ/AX0+Xm0laanLLloPQgQZI?=
 =?us-ascii?Q?BB9rBNF10irNWW8+nk9gEWyC8zuqvicaj511d66lPJqzSACSOxlOVO9dKy0a?=
 =?us-ascii?Q?suinUHq5qFa7s4mOst+rxSqa0nM9Ww+26v2NVPpgCt10ntOqbzB7KR1Il9B+?=
 =?us-ascii?Q?YHoPlIEwF2W+A/JARQ2LWCSKHQlRUDcdRT7PU4Mm1JPf4k189QFkZzUzoWFb?=
 =?us-ascii?Q?amzXXlY08iUVuK7pE9YuV/jbFWTYaDlDEyUi44BOKCLKdFNwbuZ+Z1TvDyip?=
 =?us-ascii?Q?A6aV8sZWQ9LYpmwm0WipHrHJzeoGsFlvhl/yit75oUV7LCnkTAumG8mjJyxk?=
 =?us-ascii?Q?LhnaDQdO0vSPZAJzDYrwCpa3L221Y385NOv5AeakLW6fl7SzauFP2WrWQk9w?=
 =?us-ascii?Q?HpUUdLJ+SGURViL8K90Pl0mGX3V6yVhC25W9N8S5KHoXfBoAdJon0+6Z7K43?=
 =?us-ascii?Q?0DuEKxz5x86pBF2OQZYGS0YKp/KvYEMjbzjTzxEphEk9obtx1l2PQTz9ssM1?=
 =?us-ascii?Q?0b8/9XQpXDEJIZSpne7T1HnB1XJCc8jABcufcn0NDEjjR8Ysuydv9KfDVDMn?=
 =?us-ascii?Q?+gRobMNmPuozlykva11HC+3k1d+nvKu/iD1fjfIGig7GBwVXxmDKdgXgypye?=
 =?us-ascii?Q?NuIEMSUAn4IBl4KT98+4DSE/di3zOoBzhvT0n7aHzRifJobs8OvOIuS078Y7?=
 =?us-ascii?Q?0mT05/aeUkh/wKIx6Ahn7YOdfrpKY9xvfHJOImUyFVid0bLSqH5rwqYFqYfh?=
 =?us-ascii?Q?3b83i753PcZ4hPYNLRDOgoZe4kR22xhZiZs4TBPi4DuV36Xw9/LrIU97c5ni?=
 =?us-ascii?Q?D9BcfiYr/saOqihsn1kojH4Tca6cUZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: him8Ef4zjtygzOpOSX2zGmybFwYfNALhFupyqJWMGqdX+lBAEdT8CPWgiXToGIZrXSajTmQlGIEACrU2XHstllb8Jo0WE72b7LRJ0b+gDLRVqociM/n2kFOIJ260HlwnsgBgfwTqzWsPLkopI4lsIK7nIePFQLXSrPw/NxOZTc2iAzIRIOl8OcrTJYyaD0EtuSg5o9XEjZTQ13DUmwoKPkLrISmUTgTPk6XMLweGQYIwVxK+x0TmB2zDkiPwmPwS4fmapCBm8cTdj76Ev/zR/uULiU+kEK1ZU56bmRFDn88AZ/rfjMl/Z9u1Ack757E+7rZDDKnfHLmxMMoO9WG/sQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bb0f57-9699-422e-9591-08df26225e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:28:36.3675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWfa8UmY1iIqyED5iEqu1P3YQco2GhgWpMrbermduej5jRB2Cv6U5GqgE2rhal7Ac4+eSQK/z2OanOAKrDy/y1dC5DH2xIbMtLBubjp+dGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, September 18, 2026 5:13 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Sylwester
> Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Subject: Re: [PATCH iwl-net v2 3/5] iavf: prevent VSI corruption when
> ring params changed during reset
>=20
> On Tue, Sep 15, 2026 at 02:55:49PM +0200, Aleksandr Loktionov wrote:
> > From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> >
> > Changing ring parameters via ethtool triggers a VF reset and queue
> > reconfiguration. If ethtool is called again before the first reset
> > completes, the second reset races with uninitialised queue state and
> > can corrupt the VSI resource tree on the PF side.
> >
> > Return -EAGAIN from iavf_set_ringparam() when the adapter is already
> > resetting or its queues are disabled.
> >
> > Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sylwester Dziedziuch
> <sylwesterx.dziedziuch@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > index 1cd1f3f..3909131 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > @@ -495,6 +495,11 @@ static int iavf_set_ringparam(struct net_device
> *netdev,
> >  	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
> >  		return -EINVAL;
> >
> > +	if (adapter->state =3D=3D __IAVF_RESETTING ||
> > +	    (adapter->state =3D=3D __IAVF_RUNNING &&
> > +	     adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
> > +		return -EAGAIN;
> > +
> >  	if (ring->tx_pending > IAVF_MAX_TXD ||
> >  	    ring->tx_pending < IAVF_MIN_TXD ||
> >  	    ring->rx_pending > IAVF_MAX_RXD ||
>=20
> I believe I reported this for v1 as well, but AI-generated review
> reports a TOCTOU issue here. And I believe a similar, pre-existing,
> problem also exists in iavf_set_channels.
>=20
> Text from
> https://sashiko.dev/#/patchset/20260915125551.3976068-1-
> aleksandr.loktionov%40intel.com
> follows:
>=20
> Could this state check introduce a time-of-check to time-of-use
> (TOCTOU) race against the background reset task?
>=20
> The background iavf_reset_task() relies on netdev_lock() to serialize,
> but ethtool callbacks for drivers like iavf (which do not set
> request_ops_lock =3D
> true) are executed under rtnl_lock() without holding netdev_lock().
>=20
> Because they do not share a common lock, the background task can
> acquire netdev_lock(), change the state to __IAVF_RESETTING, and tear
> down queues immediately after iavf_set_ringparam() evaluates this
> condition to false.
>=20
> Will this lock mismatch also cause a lockdep splat later in the same
> function?
>=20
> iavf_set_ringparam() proceeds to call iavf_reset_step() directly:
> drivers/net/ethernet/intel/iavf/iavf_ethtool.c:iavf_set_ringparam() {
> ...
> 	if (netif_running(netdev)) {
> 		adapter->flags |=3D IAVF_FLAG_RESET_NEEDED;
> 		iavf_reset_step(adapter);
> 	}
> ...
> }
>=20
> Looking at iavf_reset_step(), it asserts that netdev_lock() is held:
>=20
> drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() { ...
> 	netdev_assert_locked(netdev);
> ...
> }
>=20
> Executing iavf_reset_step() from the ethtool callback without holding
> netdev_lock() would trigger this lockdep assertion, and allow it to
> concurrently step on any executing reset task.

Good day, Simon

You're right, and it's still unresolved here. iavf's ethtool_ops
doesn't set request_ops_lock, so iavf_set_ringparam() runs under
rtnl_lock() only, with no netdev_lock() held - while iavf_reset_task()
and iavf_watchdog_task() take netdev_lock() from adapter->wq. The state
check and the iavf_reset_step() call right after it aren't serialized
against the background task at all, so the window this patch is meant
to close is still open.

Fixing this properly means closing that lock gap for every ethtool op
that can call iavf_reset_step() - at least set_ringparam and
set_channels, maybe more - not adding a state check to one call site.
That's bigger than this patch, so=20

I'm dropping it rather than resend the same check. I'll come back to it as =
a proper locking fix.

Sorry and, thanks for catching this twice now.

Alex
