Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A424DA9DB
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563394; cv=fail; b=EzegiBJPZI9k6ClzOR0AO6ISGrZ6WYdcrQlUEzrpvb3fREgddWrmZrnDSrG8za/Px5zhjE1C/WewYONk25mklJ1EYSCGyzTnTmHKfQiKStIL95G6gfiGRfs1ZhLkSt/FM3MJ/fMQg4LU6wvzqSkGkXkbtJGz4+YqP8Ra315Q7SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563394; c=relaxed/simple;
	bh=AbHKi0RSHz5VUbfirgtyfncjavNg0NPLNI/VdmMR29U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kJ63+8Sq6yKHlzRIfcs4dLL0VHuLjvTc+/VWoIN64kYH7XjxUa1QgM7S0qC9pnLyjZBCU7cU28687IoXlULD0A/Z2m+/vJKK3QlPl5QxVcSvZ11JFYq7beHcDvqfLxsV/kM/FpQNS4VqyrSsmSjgfILZRuxIZ/CkxsEDKUhD1b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzWc2EA+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzWc2EA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791563392; x=1823099392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbHKi0RSHz5VUbfirgtyfncjavNg0NPLNI/VdmMR29U=;
  b=YzWc2EA+QWwozkwVnbiKv1zLoXmf4wk7G3CshFQ6NT5+wF5wuXXqwEuU
   j0zsKXB1YVRkimIigD19DlhKX5Gik3mJlFf6rOP1y0+gCYJybrCMnErI0
   QHYf/3qwheXdQ0xri7l1w3JS3tigUxLKgmBugm2ptUZBiD6rZRLWZPTwf
   xQfnyoRvohE+OkeZG3m1czQ8dbLtxj+ayQU3TRYVJmL6uWEeDNTJAjSNB
   bLJZ93dsfNFpG9ew/45yWsa2xqrStC4N3zrLQq1oPSCxJk0dtG28GbNt3
   Amctk0KLU0iUsqR15RbeeUBVYP5ysVjSLeianM+o1Fs67JR7u/nIm45VO
   Q==;
X-CSE-ConnectionGUID: yXf58gXtSAqhlCJKMffoig==
X-CSE-MsgGUID: 1DofnWT2Qhq0tEStNaX6WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="253857"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="253857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:29:51 -0700
X-CSE-ConnectionGUID: 8g32LN3FT5uT04VCLWh25w==
X-CSE-MsgGUID: ut+bDdVLRPytK1RPLoVy1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="348803"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:29:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:29:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 09:29:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 09:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogGH9J4zlIrNPoXAxOi3k3sXO48o32EiOAcUZXnrxBizF8OB/Ky2E16C4h6cl9FO70bxVExpFJMlXG/f3G6eSXtPfmaw2XbUK7mn+k8/mbYqQU3TvVBtD0yMoAHTfjfe/Rlp/oCuaPER1AoQyYy6bKuLcd6YlEmf8eOJJPMSlrN8mEUrJ9NJjtSwXPNVUp2e1umSRI06tWmi6oBg8dE9zdXJ9EQnQ1on/pb+7zAUjEIx7wsmLhGDKcwANEKnWkk7jBUV2FnaIWUa6yoJgRsGu6osaKcyqqn6iW3UHL/ISbC6xCdfdoOBmousNflGQQWfxe0Mup5m7bGir2L8iGalCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQUXiFdO+lqMNM8HEdidX19GvsXl5MwlafIx1yeIoF8=;
 b=BmNeEL68g46DbpRb6eWAUmmjtJ+CwHpy6e6OJjzHV8AWkfhYFTTasae0x/1Rc7GmS7wvPa8qTONYISpj37h/Yq5ERoafZsEMh/9bzt51VlTllXIp6g7MoUaiEQsLLQ5/5jsyX+AWpx42vvuh9taVd5U7WdmWqqDYpGElIqu+wrviaYRS+TWunHkOdq68fEMu0Tr/TfhSwBqzNrPmMzbH8X4NF2lBLWinF9fiiJ+rUbp25IedDC4ZDAvnrfvULD9bEkfZYw+WwyGeD8MlLc9Lj3deNVzEJxS/at6jtm2+nN+xwmiT6+V+pXB/11DlPn0ubWcgl3JxBZ8yFFTWmji/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 16:29:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 16:29:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Kiran Patil <kiran.patil@intel.com>
Subject: RE: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in
 iavf_detect_recover_hung
Thread-Topic: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in
 iavf_detect_recover_hung
Thread-Index: AQHdRRGGgFoVqBgo7UmT8sgCTkbHlLbUdc6AgCEWpHA=
Date: Fri, 9 Oct 2026 16:29:48 +0000
Message-ID: <IA3PR11MB89863A91929BACC5F0B01BF9E5922@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-2-aleksandr.loktionov@intel.com>
 <20260918151125.GK51261@horms.kernel.org>
In-Reply-To: <20260918151125.GK51261@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5215:EE_
x-ms-office365-filtering-correlation-id: 0229ad3a-f783-4ed6-8631-08df26228978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|38070700021;
x-microsoft-antispam-message-info: tepU9eFL1DAaCC5DJjh537B4Y4NOJGqjjKoKkHV/zL9mZMoHYzG3RiWtFCrrpFwDZPiJzfipp87ZxduY0L5IDZdjgLk7hNb9KZwfS8S7xpf1I8/VWewtKr6Jmw/2KBGcT0Iw7ML92HBkQ8J3Mcjrld7rdiHIa2EMzXXaI1TBjGUGz8j+cfbebn3maetSo97qRF/BlObMuKxBiogBbNLjRM8N1VLyphJTsW2cnvkOodJk07q5zMFe647qqIgWag6cKE78zm3MWk1cjpsLXfRAbCkqqMNArcLN4YwdW9uoPtluLhaSteJmLt3LN0gyIIl4+u5aMShWYZzq3tMu2dC/bXnf9IGs8a+t0D7pYBWjyrQOjfaIH27wbyugGCK0dmmpwEc/CL6AikRDN9K/w6nUlf8GXOUf6HBjgzUGlctJtVgvw1qG1piCNwjA6uwrzXtnp3wMVaOGT6M8e3NE3TFh49pad8xeXDM1+H6prr2wT8AtBES23mL8ov10xxpF/F/MasbWHbSpvANDQpPSbuC39P2HshTXVsHXkf29SCdNPkRn4B2F27b35N48YoW7QyQmUyX3nx/Glfb9KkpSrcVqId1XOOKTaDNCmtasCh72qSiizS08LS5ZwUgFV+N2L1flYnYnjM6O8MvzJWjC5vBOExbXfTdi9g+I3i9x8IuMC7eZ0cEcJcXJVsZOI8Mt1lJuqZzsJaGSfmEYr4aqPdSo8cyjBnPbjfzvIdokzvT8XO8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fn/bpdqSUeYGXsQqQlMnvDR3bKpWjCZBf16714TnhaLL/BEOxOK/+zD3j0CV?=
 =?us-ascii?Q?QgaRUfykC20QNegyZVgIVfsUzuAWk+lrQMcb3c8tT71HLv7d9AHb98pBv1xu?=
 =?us-ascii?Q?2DPDjJ+4fOUbZ78YoeZsTcHvKirIiYiEz9MhUflZMDByloG/K21OawTnyYpj?=
 =?us-ascii?Q?5pTuhyEWqtWcTHiTpUjzjgTiEOxFD0+/DV700HCiD3ZzLnneuMlb/9jxFcFR?=
 =?us-ascii?Q?g0W7wgVlEG/Xv3D/m0+O02thOqa/XbuUEFCDvWnf0ThrufANAQt8/ChjiP6D?=
 =?us-ascii?Q?gF2jd3DfJVgdG06/h2EM5rCWklX+9rsGT61etkfm6cU+J5zgn47vc4zHD97v?=
 =?us-ascii?Q?9jOl0qCRwT6xt9TX7lCdczimNaN51vWtmJEv++bI5JrVOQPVJw2agS/sbnJt?=
 =?us-ascii?Q?gRpDlPV39Aakaza4AXX8a9JWh9yI63jMV9EdknlImUTa7D8vvV+1MwrFfvTz?=
 =?us-ascii?Q?pLicAy9PDm9nLDxGH8Wz5UyPbGqybTeNFSLjeIDaeOPh9HWEDvSOHCISvoXk?=
 =?us-ascii?Q?IHttk1u3Pnup0/fbROY2oY5Opb677GDT7kx00l1CqcbSx6xTMkVD6z8xDQYb?=
 =?us-ascii?Q?uct9TKrYWUJHyRvz2FPQyI9adbl3+jGZWiOE0U5iEA+Cyt6IUwXGeBCc/mH+?=
 =?us-ascii?Q?8Y8G7kkVAwAqnGIAAPxV7i0DzIkg0rkZx74lCzBX+u4hBjOGMlKat3ge7b7x?=
 =?us-ascii?Q?CRvSBiEMdMWbbCbowGipS05nwrH+Y75c6AQKMt68L/i9/NGEVbo544qJKz88?=
 =?us-ascii?Q?IN7p4UHJnysUkmPJiPsezwjwsQWBI7M2BJzELHdqdbf6KnX0C7PSp9swBNi3?=
 =?us-ascii?Q?20gEj59AjIID809s80cnfuajTaKf31nEHXsdKr2yCT47hj+EMgvFiBqw4moU?=
 =?us-ascii?Q?n7UhZqRbip0ArjkprWQ/+ZdvxcIYt2q+30p749opCo0GZcbwhtw7L7aqF9cC?=
 =?us-ascii?Q?17p2DwYROmIKILF3kVwYlmtHh0GJcBp89Z1KxegmJ76xii80+TfvCbP99m5k?=
 =?us-ascii?Q?8HQCLY30Bxxr+LjcSjSempFnKVFAh1ISSMRvWAae0V/2H+ssE9/JkN0EI6un?=
 =?us-ascii?Q?H5roH3MUywU3faPyfHBssi8shOlhq4hY5G9qWAGJ/GTWwkl9sIwiYB23HrnM?=
 =?us-ascii?Q?8dsDtTprO7yqgJJ5MYj+CGb/2qTbDkqkkTvYrf5U0X/vogAJsZgcQo7hfPaX?=
 =?us-ascii?Q?9ZSiZkTu/qLQNgt/WN6tzgm1da5diCZu9Dij6sDY55Mmtx9xNi83sPIfUtE5?=
 =?us-ascii?Q?3F12y/K1OvZahc1iHCpWtwa6kjPpisGu2Z8GIQrP8+6Ug5LWapgfrOAYsmj1?=
 =?us-ascii?Q?oqoG/1z1Obo/oYSJaeX8zeJmRlXDdCU+kBw5SPAk95X2GvaN8UC1HdX/LOhm?=
 =?us-ascii?Q?YLu/TeocyzcBNV7Ddu94FRNfUIfJuhNRPjYVRwPm4d9MCs+6fkyvDpb7rS/t?=
 =?us-ascii?Q?YeOlrXAobK1F9k9zz6y2ervAEqrO1eMH8elpcF3Df7YUL09uahqpdhKdKi6O?=
 =?us-ascii?Q?5vFoAKllUNWijY7zH2xAu2PxMyDax7uVEUxLvM/B06Prk+czdWfnh0TbxV1d?=
 =?us-ascii?Q?X5Gjqzk4oxNuxnhHi/4VXBsEv0GN9+ystxDOuLlZJWemKWQMV0fzqPs8RML8?=
 =?us-ascii?Q?Yal8Atl1wawq+5kJD9dqilvntt+F6ceWNwnzYgZp1memFRF63TYO0uUzpUJJ?=
 =?us-ascii?Q?CGni+BHnoloUukK+26GrdCpOfTLDU9QtS6+B2pW1nNLlBLvt6MquOAEiJmdx?=
 =?us-ascii?Q?apuoUoMw6+KoDv/yDp1pIgWKATmZUG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VdA33aUcy673Ad5v1p9mM3Vkv1TSRzm6jDoBGXiarYnrJd0np1np4PhES97l/H6c2BiGNFbTydavfx7NtlOC/QxD2GPl8Vqj6USHh+nymbJ/IoRIIT3yvU23A9mI4qmsUIma1PFuUf1R58fPp0zaL21rbffa6cuWsYoUNIs6JKGVLklnA+ByiSOJdYn9elqajzbvFu87VLJgJQnxqa3sLBeKJLZM4/F/bKN40WAAQPiA4mLW21AW3oRIa7qd3cBYT9XwVCPryMgv9W9/npA/jCr3OI7T48ZFiSk6kxER5zWijMR8oPZB0EOzV7i/oCG0C7poC6j/SyUjVzfrl1HUyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0229ad3a-f783-4ed6-8631-08df26228978
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 16:29:48.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rjtKGVQvyolCvzE4eif/z8D6nJ9T6Z0YKB4onCfTiCV2buPDus7+N7ycu+LUwhKPX1q8aZGQc4iVS0j8H7UD4nd9do8Bok0DKSOcfK60ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, September 18, 2026 5:11 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Kiran Patil
> <kiran.patil@intel.com>
> Subject: Re: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference
> in iavf_detect_recover_hung
>=20
> On Tue, Sep 15, 2026 at 02:55:47PM +0200, Aleksandr Loktionov wrote:
> > From: Kiran Patil <kiran.patil@intel.com>
> >
> > iavf_watchdog_task() and iavf_reset_task() both run as work items on
> > the same ordered adapter->wq, so they can't race with each other.
> > However,
> > iavf_set_ringparam() (and other ethtool ops) call iavf_reset_step()
> > directly from process context under the netdev instance lock, without
> > going through that workqueue at all. iavf_reset_step() can free and
> > reallocate adapter->tx_rings and the q_vectors array via
> > iavf_reinit_interrupt_scheme() while adapter->state still reads
> > __IAVF_RUNNING, so the watchdog task can concurrently call
> > iavf_detect_recover_hung() and dereference a NULL q_vector inside
> > iavf_force_wb(), or index into a NULL tx_rings array, causing a crash.
>=20
> I am concerned that iavf_reset_step() is also called from
> iavf_set_channels(). And in that case the netdev instance lock is not
> held.
>=20
> >
> > Guard against this by:
> > - returning early if vsi->back->tx_rings itself is NULL, since
> >   num_active_queues can still be nonzero while the array is being
> >   reallocated;
> > - skipping rings whose q_vector is NULL;
> > - reading tx_ring->q_vector once with READ_ONCE() into a local
> variable
> >   and reusing that same value for both the NULL check and the
> >   iavf_force_wb() call, instead of re-reading the field right before
> >   use, which would leave a window for the concurrent reset to swap it
> >   from underneath us in between.
> >
> > Also move the tx_ring declaration into the loop body and drop the
> > redundant outer NULL initialisation, which the compiler can never
> > observe since an array-element address is always non-NULL.
> >
> > Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
> > scenario")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> ...

Confirmed - same gap as 3/5. The READ_ONCE()/NULL-check guards here only
narrow the window where iavf_watchdog_task() can observe a half-torn-
down tx_rings/q_vector array; they don't hold a reference or lock that
keeps those allocations alive, so iavf_free_q_vectors() and
iavf_free_queues() can still free out from under the watchdog between
the check and the use, from set_channels or any other path that calls
iavf_reset_step() without the instance lock.

Dropping this patch rather than resend guards that don't actually close
the race. Once there's a real fix for the locking gap across iavf's
ethtool ops, I'll revisit whether any of these NULL checks are still
worth keeping on top of it.

Thanks,
Alex


