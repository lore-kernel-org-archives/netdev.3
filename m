Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B13911A9
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494851; cv=fail; b=YxfI10G4XtflZ2HP8uEVUS75C+LRkOchb5Sfq8B5ItuDmLdWI9lJGpuSSP+xv84O/ghcuJV9u83qOfKJcgH7vnoyGXRCl0u6+q5cp6eRa3CzM37W2ZIRv9k0ARlVo3C9zWs/PwY98JzConfAGfAMreRjMX/vr2w7Rz/63oQf158=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494851; c=relaxed/simple;
	bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQ4HmrMO9TAVIHRy+OorthQ8+TARsGMPuU1P+WDVCfJVOqgJBn3JEU/UZSb88q7NlsWB/2cWulVuAvbpux++DuuFv9jsU1fgnLVDAZDbdDdxUTjamERsle2ohHryhh8QIPffN++aBWC4Xh+ee+m0u5LDDRgj9Nlc1vaPC9HMbUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7MrXn0b; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7MrXn0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791494851; x=1823030851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
  b=I7MrXn0b2agPIDardyyDsrWoM01x2Vh3IqcAMDMjZE+xFmQwgsjq6J+k
   ZIrf7Sj3TUANnOQPgVUR05k+aWX5yYk5aOf+bngsSqMU90w6160EjV9lh
   gkigVhEr+WCSVnPA0VBNCsJJqVUvIDyRl5vSGX151M2YtrIZDUhmWS0be
   QXJfgFmG+Ut1+uo9qThRbgiXkdWl6OprkL2liGziuj7uhr6sq6qMR2WB+
   QAf9GPF0yfYoPuE1RAqzP4GKfbWEwW/7u5zsHOqterbWcCjPEweUYSPrv
   0ilDKtHJOJs+nE9S1j6mFafHfBtCup0NbZJvmK5xLe4/f21ys1xiw4ayh
   w==;
X-CSE-ConnectionGUID: xfPde6nKQdG01TpzpDHNLg==
X-CSE-MsgGUID: 2ibpJ9uhRny7IC6DJeSaeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="185150"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="185150"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:27:30 -0700
X-CSE-ConnectionGUID: TRQTyy09RNaz+qrnu7D+Wg==
X-CSE-MsgGUID: m6QQK5OMSGyT0QBZOFfovQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="146339"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:27:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:27:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:27:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPmg+U1LqRj4+pm4a/C6UF3U+8bk9UOpzADLjdHP0jsTXtZhZ5XK5FtB2kOceSdtV8kzk2/DzWc98nXC/sKWgOMdCLjqnyXH6XXQGYJN0YRl01ofi/KWbLHET/fv2Wjrbsup1LdLDM1hs1VyAk0Od8FfCqeMihbpMiLqZ1ID8tQv3Z46ONiZoRH+0cd8zMG8oTDTwCTTftD5nQJp1+9Px0bXBoNSNe6I2bTVLaK4JGphWB0+2522ntW0d5pO0pqZLyc9t0oEhXqaNOFEJFEp+F795+QpGw/ruhnPtdNFOf4AsSTBhc8xhIaND26U2JCnmD9lSG3U05rZpSA6SWuW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLMXFLmb62Z7MUmdOsnP7VtxRZmUQeEouEf8odFcWVs=;
 b=Qm5JanB3uesTlqS2To2oimt0tuEPXegYZM1gPVkTfd4ljOetq/gWh+V0ka7acXI1J8tJeHBQ1iJX9Xh2pWLnHM2GNAFqZ0uQW0R6Rysn0TgTPRDmXPg/vHDHDzk3+wnOaeCCeQiqkeDCzmylJRrHqQa0cfnafzQkovHfD+nIx1ntMcpMV0UK1ZxAVKJInKMaSUlZo70NwYzpMemIvr89w+aR7zAt9pNTK8epovj7jsEcSbktaq6brjzaQyvGgvr1crw7g5dQrtxu1tUdBBPpcVlDyVUNniDDv49/5EULG+XqJYFy/r0E7mLlxBRiFmNBtP8KEeREsK79xrOLwLq52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:27:26 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:27:26 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 07/10] libie, idpf: move parsing alloc vectors
 command to libie
Thread-Topic: [PATCH iwl-next v2 07/10] libie, idpf: move parsing alloc
 vectors command to libie
Thread-Index: AQHdQfHWkceWDlGcHEObybLOtxAb9bb0U58w
Date: Thu, 8 Oct 2026 21:27:26 +0000
Message-ID: <DS0PR11MB642219AD185407D0B5FDFBBB9B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-8-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-8-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: 36ccfc21-c086-4a02-b644-08df2582f2f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: ANKtsaM9ZY/FeGtXZvaWjAWF/MTYI0lQxbJD0bQDY/KFtFwLhjppixPBsWzgvujp3M04PhKRqwvnLdBiNhoGscAXG4D2nyRScnTqNtwl6TuBTRKvG9jzZ2AxGROS3b9SIXpjmRyPu8YSy+8FLQjIa1WI7mBotiqPwkHDFfNowTwx1itT9dHYkg8GMpVbQZE8J9Szz5n2AQKByHO8YEAo6cL8zcLWpg4ZCqFbTYpXj6G9IsxJOCyczbKzmRghE6KRlgBGp982bJRYsSYSlPCQmJ1bvgXHf5BAxESUrfgdu3YcO9JG9PwYO6CxNwAzC5S8XlPkOjekVrMShO98eO8YRI8z3QMDCYxCoA9uB0O/OI5gqECkZ82qqI64sD4eGJ3dofJzYekgWt1W+ieIfpG9FiW9APzejjci6KKOC6J7U+KUci5nfC8lhMH9CfJ8Vet1dSfNq42w3ZenwjgzutoeZRlyfLJWq8G5RRK4bTiCcf5B5zrOhmv5B28hh0USdng+zWv9RaV4iFGEzgLNV1flUxejffKNiR9MZtDJt44mdvBVmTA+Ijvvyt/BJl/AbFrLHPmAIKhpjeCnpia1crfjtGWXXJDmpIFbVK7PhRpeAWHq4OIackijflve4FTFbmg6RHhMkH0/CgItzjex2nuz7qpIvhnlOESU/KjU2ocgNNn3TWcOP1XmI4eoinInPMuSQ4CZEi3KtG0BuEcOP87yf6Y7I6f1atnLuA2r2ZDBJvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6422.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EYPJd3YgJLxUs3VPPvNm+ApEGJAcSKyyc/Ej/cCRR4qshSZFA7w2P4FIGJaY?=
 =?us-ascii?Q?iHvPHmCBuA9ZhlE7TD/9vf9QsK4SMaGDTjgFa6n+PdMUQc7HvHqPNWrXe0Iz?=
 =?us-ascii?Q?0WcDDgSGxebvoKUA++BhzXoV8Uv/6+EmybXUv3ZJSlLvx7b5n0VRHA+x1SE1?=
 =?us-ascii?Q?+uPBN0jAxUBqk6mA+mwIQ4bFaeWGlw4ee+kFF1dHBcwHYdNgx9hBGUGKYq4m?=
 =?us-ascii?Q?Q0MZ0JGwvDJ7Qhu3twSfRGxPeo3tROqJsqoeXrSVE82QvDoIJaEua07XVrWB?=
 =?us-ascii?Q?z4o+qvZBFrU/M8ye+a71SJuGThEcsVUC3PZcXeCkuCA9juNVGifwzSwLh9Yb?=
 =?us-ascii?Q?q5CLrgR/Mdxty4k40jxSuxhhdtBAjLBBiw3oJsTybc5s1/LGeh1IU+g+yV3c?=
 =?us-ascii?Q?621X0F7hFoxKyKB0a8lhz+1AW20zdYxuP+HtZWyHjXa7Nfve9C9xh6d4FMRu?=
 =?us-ascii?Q?Ule4KwCGhew57k36mpUmmdIULV1t0+lH/j3jPs7+VRcDKsCzAf9Iv8HjfMv5?=
 =?us-ascii?Q?RFtWm7Rv/Ofgmr0fTcBwqESA8VCQURFFVim/TnRC4fwrkUXecSakO7FjBy3L?=
 =?us-ascii?Q?8Xxs2dltqydBHPXlvR0y7BVEOkMPXtAyonua982mm2cJ0YlE+cHPXXmEtiq7?=
 =?us-ascii?Q?+saAn7kcyi8aey4i+hKOR3iZlGe8yzmAnBWZ0NcmhABDCafQq74wIVlElrjj?=
 =?us-ascii?Q?zhc2ESKEoCybPINfU2u+o3308bsUmy1kRSIyfV6I3U/Kc17YceyShbBvA8JI?=
 =?us-ascii?Q?tZPDDDLXsKRR3KFx8vZ5a83eL/QtGFRGQnW9Okwqd8sk4xlu+VAsu6EJ1d8X?=
 =?us-ascii?Q?oOh83UImq+PQ+w7PwAyahYmPMeIwrZ6d+ZA+zc5bVgVBo5bFO/2+RVliEbtN?=
 =?us-ascii?Q?Rn5Lt4h6XXtHKvkNp+w8mn7K4Sh+KG4Oo9jKmPC9S+F1gEUFG1hd4pXp8TAE?=
 =?us-ascii?Q?1LyX9IUFs8IyHFpPOtoxGeYG+K/zQaIhozYRJkn5OczMQ1wvylDBNQ+UfvvW?=
 =?us-ascii?Q?tWwNwAHN/L4ElnvaUQhrFZxnmVZDJKST6lYe5ZSDdD2T2aPX1jsa90AOo3i6?=
 =?us-ascii?Q?DszaR2arNtcj1HIVjXMcYuECZOg8AmplZukdqrgr7BBii71DvZbvyj2YlTZZ?=
 =?us-ascii?Q?afq8sN+WasBlZST/lQ/2Fx71xN6IzrE1dwrW8QWiWOoai8/N1E6z7YGETU63?=
 =?us-ascii?Q?Oz+R8gxeS+xm91unGbM0rL0HuBDvRwnTC2YEq8ztjRM9AeZFgGNev62VxBaI?=
 =?us-ascii?Q?zNCUh1QYibRgxme0y/eEsT1QwltMg8czTRadd3iYD9zeAQc1ouA9Ajr1TRK7?=
 =?us-ascii?Q?sXcMLqBafRCNHczSRLGqXs4V6v+GOSD023Qw+8J4RauOtP+bXySBM0Y/FlD7?=
 =?us-ascii?Q?mvwBuAL+XYKkS8qA/Tr72W3mxHbPyC9/Q7Fq80QzW4JoSeZjoM3K81O7OzLe?=
 =?us-ascii?Q?QeVI2Kiw2UztSROw8BMN1xFL4V1MqBYKC3wSVr/6jlOdVA1lifAvPjL4ApWF?=
 =?us-ascii?Q?3+fITBOAKne63dNFZ/hHNP8gwGsH168mzXoMnID2Zvk/n8EYo7W+pE22pS3r?=
 =?us-ascii?Q?1NSojin74Rd7FkWU0aQVaoT/KM61ZqMfkpukYqVTO8q9JQ0bnvsVwMEHlKkg?=
 =?us-ascii?Q?+Yx86GIK4oAwbA9hu7lj4fXOKtITvLhqzNQc+2Cgyg5ARAXDtTcEBT9Z0/JR?=
 =?us-ascii?Q?8Dlpq4dZs34ac3ahmNEiRAXOAPwCjiBrgcN3TkBufJP7bPwY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gWBDu4r9vDM0xBn6Xoc+F+E8I211XgxXukAtd/rd6ihpCONUnk2MFOdGBOh/2ohiMtl06gYbu4Yq2ukup4FgpqyphVigYXme3lY9mmNCQK8YxjPJsx+5FW/jKdHu19tJeLGevHY7DRm/XIkqRsAtD8Q5eXH3AsCyz1ZvLyBkWOLnW4tR6Djey/zXXVGt5GgcTP6gabOaWlSLrCOHOIvrrWMpPB6C8Dwlxi3f8lK9ZNJubY2EoP5vmCzBJF/nwECVTHJmiyQU2l3HImZlK/QdRHkBkZF9Cj6hk4/jWj0jM3rc6iuV3ryuy6g+Jpy554/wZDrIjuw+ukSI/5Ymy/dn+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ccfc21-c086-4a02-b644-08df2582f2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:27:26.1733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbV0VvgdVPg7Kzb3eAd3m6heNwgM9cm7eFyIYvXWlxU+5nekbRa2m7UfVNEsTWtXtHM2HgtaWoIhlqoXVeDfJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 07/10] libie, idpf: move parsing alloc vector=
s
> command to libie
>=20
> No functional changes. Just moving to make it available from other ipu dr=
ivers.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
