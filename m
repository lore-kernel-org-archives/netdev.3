Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8C497B68
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164679; cv=fail; b=qbmKOBuckG2N+9Ok0kGh+eBl8rNq3bsE7mYN/aWz6FhIBIbAZ/3/4eJ2HobYzg2DBn7zZRHpIKbKf7MWNAlJ7ZOcLK0WLLpLevSKc91rWgGq1Glcsg2P3vTn4JlWqMjF/rUuBdzaHJAWPV2AZWYnj24Ocak5UDMUWYlVWh58P88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164679; c=relaxed/simple;
	bh=F2RwRAx+drjoS58RSIrwJi1m0OwHDakRgrvuBENBPeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WU/apGlzz1EiY0HdUdN8rgYO8hBdqsNTUBRoCuH5d0rzey381do8Nvzklof+URBZOVblXq+iCD77OAJupXNql+i6V/jNy206KHZOAaz6zuyUbOlI6EnenbLbSvP6h37WSlOEYC/xzIY8Iz+WbzzqA/ekjoVnkzwk0f+EMf77cIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDMajBSr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDMajBSr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789164677; x=1820700677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F2RwRAx+drjoS58RSIrwJi1m0OwHDakRgrvuBENBPeo=;
  b=GDMajBSrMVWOa5DR4ns8rWhTqhFo8GoO8cBVFFcLzBr6Yt0pH+GgnxaL
   +qdAkBhCSMJRYWfmPnmhsYBd7Qsi2NwDXVhTJJU0oU3la9SNohig2uBg7
   rrpKXm5A8zOrxp73CYRjYmX41JtSLbrSVQxRtEhWXvAhDSyl4LZzoQVat
   ThyF/+ae/MXW5nuCKpOZiTao0AKfy64Xwy43f2u/rPTqwet0dUEJhnPAZ
   Rc5yr9Pvbc2ZzGkuJkcWLW9fRfU8bpQa8gmY02KkgRlZ9R5oeaE49msNs
   ZTujgDSAU07nFhA2+oBS+o3MFMRh/zrMseGjj6E2dXb+OCb1dnvwLC1U4
   A==;
X-CSE-ConnectionGUID: 9PGAQhQ1TX6hcs9jegZBZg==
X-CSE-MsgGUID: ZfgghuWJQ521lSk64x1HFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="100294051"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="100294051"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:17 -0700
X-CSE-ConnectionGUID: T8Yhev2eRlCKYSoae6TC5w==
X-CSE-MsgGUID: J5nigoJyTTSODHr8CMRauQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="268354909"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:15 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je9En/SjDrBWuZrbLPN0cG8Qbyrl5VF46fF0LOG8h31B7KelYcakogmvOq4N6xZ0+yJwqKcsx5UyJgAMh5oAiDt+lE4zTGM8pKwkG58WgjzhMNVi4+Pa+adUtO4NVyt9PowTgp4opM1bsEdNkgFmjSgZMoxgQ/7X8xluqyVHnF6sxYBRVI4EuqwHFSF6PnJxollavOW9InvauuvQr9P2CLPqy1wcRu+KQM3UoYErCS8oUUvTDKbJfeQ7M2KxAT2eL+8dEeXcT6D5RKuyivo/zoWIwzRTsYLBTmTySWyu+E4X1Zy4LJX/IqZKEZrouqiHuq2RVLAbe3sFQhN70TDSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syk4HkXygVAQ7kXf175TtSMZVigmllN4Mn85GWerQsw=;
 b=pIUqCoF6GeHAVkYsCZrXnai+iZp2rZ+vQQloYs1QsCZ/FjIxkgLmhgKQ45UfGQQSj91TpmTVFpKV+1OiGPAJ66YpDROW2iViMK6dUA9OfYdTiqGaQs+QSyoGIj1wY2xDOr0FFsirrSEt9vd25C0ZNeoc8fTxVPtky7X+ij0WcBSBemu+hQYtLr2ntkexM8ZX1DeRHUou28brCJVyBetjh9T8aVmhE8Z81um2rPZPNb7/bXFOWogE92bsMyNnjQA/gwI9KGjPaqCjO1NcZ1brHa8uWRf2sOfJnJ7Og2c9KaxW7xHHNYrFzU2ThWRc2piD1qI2a3wUN2dDiStCvUVY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:11:13 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:11:13 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 5/6] ice: dpll: Rework U.FL muxed pin (SMA)
 control
Thread-Topic: [PATCH iwl-next v5 5/6] ice: dpll: Rework U.FL muxed pin (SMA)
 control
Thread-Index: AQHdOVgjAmykPREnFEevxS3TkLzOKrbJ/++w
Date: Fri, 11 Sep 2026 22:11:13 +0000
Message-ID: <PH0PR11MB752266BD8A126D10D834CB03A0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-6-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-6-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 18e9439b-e002-417a-d800-08df105197f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: +akVDbOKPA7bnZ++25Vccm/+NN4EsbXBuRXWRTrYbpjuGuER9j0dqekQ77pxIGqKWOPx6qmRuIFuDJ6Uz8GJvmoSML96f4ajtu0HEa4q4wZmp2vZfcneaHvEsPrK041rHGcV44/zoLe2V8VOMs9BBJn6U9OONiIJ5O/mmaRD1CQmpUIVHAaZP+26WYK2+sOWtV1AdyO006LKGH5buNOJ1M8Uomfdqc5owYq+E37/SIFBzPU8gnQbV0OYdIsPo+yj+A9WmxFVufQqGj4G7kMZkpmd6enjzZn3e+VQ1lkm4H6tMZzS0KwM+Ob81Q80N43oBn2jakIKkaP6diay4ynrhd7jDQ6oLq6chwsnvHDMhM+EGZOyjK20z4rCgXfyw0wKxeZ6IuYZiGtlqRJj7BOdzZ8usYbnt74eJapA3ZsARLAJui5JcB/wgsKlQmfRKMVd/GpcMQQ0LkTrZOkMug2F3Ev0NUo/UfraCyqVCLyxvzgyhDRTqTLkBxOVWqBYnGlRzZn82z1+vRM1a86120n1/0Q30dWe3bHTlef579I6Rloxbnm1COuNd81PXZku4wISAzdQtZ2BmGrhM6fuIGmwUNtr3tqwIOxZCv45372YRRBGAKkrbDBesWVmbhFlhKcPI3/sQm8XQPjD5ChzTBPS/jc1TN0xwUMOM1wfJAifmf9oi1Y9TMx/guosGgq2K3+upCSnFhwb5FS/q7v+lHyYloQ78aMiqEpXx/wZSs0Fpe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sr0f4w0c94KY3A8K9EuCCSHbxdk3UXDr/VzubLdbcefW6gQmvRY69GE7oNAc?=
 =?us-ascii?Q?kZscnBwVf/dcmOzruekYbK45RTqxRTRAGoBM93c7BrhxeBOZn7Bkku+fvgcY?=
 =?us-ascii?Q?JAz9KPEdzAVIhh7/87O8KDLe89NGLwDV0Y/B3rNP2YE+hUh3HX8QC8ZMcxID?=
 =?us-ascii?Q?2FaDX8Jg5MXLsVB9hfQB0YrU+40yPRI21dVEnaw+vx6t/eI4leYpkniybgnT?=
 =?us-ascii?Q?vs42G60oFGZ2vE6hUGxFkAeO1MOBiB5qE1iKSupvHUq25Kvz3AHl31Befhyb?=
 =?us-ascii?Q?pWK+Ka+EgHLuvQiG2X+DH8tlEOxFhNslVutGa+fZHzXSurMLaUhzgttzayfg?=
 =?us-ascii?Q?63VpNIW63dHa52RHqwr3Ek3D35cyAqgzp9xD3pkc9Jmsn1mJFv/BQIZSb2GF?=
 =?us-ascii?Q?PW70ZREZGkhT4zHoLPQvH1oMrZjfvxIIkds+OEhKY4SqOalcS9Po+Zfq3RRR?=
 =?us-ascii?Q?LLrcuScFPtiJGuERV6prdE1Pvwr9QHqqDWNUU+qtSQ78tmjxvLzz5vl84SIh?=
 =?us-ascii?Q?smJZT+fdRfgaDj/Trmjl8srHAkl+HXU+yVFMQCsIVNt2Y0ekNMC74fKJXVre?=
 =?us-ascii?Q?bRqTKHXOmR33v139sY8+bfK4ygL/AlVVv2FFocs+c7P9ZEdGU0zN7ieMLRCx?=
 =?us-ascii?Q?s39/OAQOJ/9qQRuuToy1Q2Objlpy51e+2MgujzdPoRc+rrSXROHPip15N2GW?=
 =?us-ascii?Q?5rtF012LRtE50oSsYSLMck/64t8aEa2Hi1aSEc3BEi8VRk/3e3E1eJVgr6zt?=
 =?us-ascii?Q?ROoQSPO9NQ0wUYDZTew0uEHvQSaXURSSGgncUR9OqLXyjQCT31JYzFjhLJ/X?=
 =?us-ascii?Q?xJuAn9+niwoxLk3Hc3Pt6OxLv2Aakgru9h4QC/N1R/0k+04sSEnMLtHwz8qn?=
 =?us-ascii?Q?9pxC8UFv1MQLirswwciO8v7QjsGvYfiIwzP9IFpEGLVqvhGhQ/tkd7yz0ywE?=
 =?us-ascii?Q?Vus3PhFlGfPE15j1XlrwM3cgy2Z9Cz6Oxx2Qe+euVNtHxZ8FGaMzwbudnxer?=
 =?us-ascii?Q?eAY1nQJsC0PcGVFo/XY6OiYK5RhwIBrBs75kk0iTW6cWRtbtjMTksG7N8+VT?=
 =?us-ascii?Q?Q1OXsH1oNwCOb8M9+HQpiIfC6G3Uw4SDNjOik9gBpLSTcQ5koaYW2r/yWXrz?=
 =?us-ascii?Q?g2SQB5YVxk9a5B/9MNqGLEUa7w4p/58ZnKdF0dUUYbHKP4T86kSJXU/GmSof?=
 =?us-ascii?Q?6bDmFRApSwXeMT+411kg0ceRoiqa7TW8h5RqXzQIi6hoKAxXneW2TMeUXTwW?=
 =?us-ascii?Q?40XTX9UIwBelC+3Z0E82KiAcQ7houNsXagTROB0cS/Mtze8c4JTKvNfevF7+?=
 =?us-ascii?Q?+89pkANJODCqTCn5sTLU8NXkDaRf6bvUyDbztltmNci3N37y6b/CWSoFf8AP?=
 =?us-ascii?Q?r/AxO71Ajs64h78VYXxDTLSTBK81U3pem2cgeZUnUEzw1+4RVHQR+NV6KIb8?=
 =?us-ascii?Q?obvjr2ejYZQg6rPOCTyKLTcgLA7vrZkOz64qBpEtWLgh7SIYTbIsfTpStNNU?=
 =?us-ascii?Q?wKwpSt4BK9D/9zexwQESxKBlMISxwbFp4naJWqDBhyQQ6fC848TcdFmaS7bV?=
 =?us-ascii?Q?UvevT3zi4jGrNSnWDsjOgM+VN5YBc5Uytj24CX+s8XmbqxvfIdnr5iaGhQqT?=
 =?us-ascii?Q?mGJmwal1PLuV1g5vC91rLhY9lwsaoXLeEzlaagxAq8jlg5DyHM3n2OecCMfc?=
 =?us-ascii?Q?iY3uLEmIxaEache0jkB6LdvXgs1waFrpbjGMcLH8NwCF488qdwccflPU/XuM?=
 =?us-ascii?Q?jXHAf/JsbQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tsPA0tkuC+YKOXNQ2Qi02Gt5TKUgtFxn41LXX1SuFRi0coqsPWS9jPdliZgDs4C3msnFu3YLHU/LApEv/dScJYc2zf85FykLGJExOFX0X4lFzmjdbJ27wRjA1Lr1IqRORxj3GanmO50oGanChbgJ4KZWxiO9vRNadV0RE1tHZl/v9vtDYwuak1jodWb3j9HhUkPaIBUoTZCVNfdn47TMBf3UMYeRHcPMGc8lRmogI8s4rBxD/Bbg/V08TQdNVhk/Bq7Z/aiH4FpkPI+XDr7RdvkQz3ofPALV6a5yw/FT/4FjDSTG94MUf9wbjWP7ooCL48M45yoIEkNibY80AXegvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e9439b-e002-417a-d800-08df105197f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:11:13.7176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIBblvlzWTGup7lagGUzQ1uK9wjNywfqa9OPUVVRzAf8gBGV1Ihuwq99PWPInMhicp0FNndgpN2ZReifz+gmbQO6qCUCoXbqT9STW0Crf5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 5/6] ice: dpll: Rework U.FL muxed pin (SMA) c=
ontrol
>
> Rework multiplexed pin control to match the state change listed in
> the design requirements.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 191 +++++++++++++++++++++-
>  1 file changed, 183 insertions(+), 8 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
