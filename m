Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0954CF5A;
	Tue,  8 Sep 2026 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873179; cv=fail; b=ZW91gfP40mO1vRFifH85Fju+nAGq/ob4BMRa9OFoKLI7rnWfuZ0tDqDDKJJ6qJpsCR1U7SEPIHpm724utCeBvmEtEHE7GE6ADlOWXpYd0/qDGqXk7EeTZHs4uuLQL+Z/xtfIrn7nDjCZt60pLQJlcyLLxZ2EEFb3URXouHPL8/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873179; c=relaxed/simple;
	bh=ToTb+YFwFWAyYAPNX1W7zBLVY0yCGv9VNmSki1o3Tps=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krG/Gts3dceC08ALRvF8uSmUElont11LuOYk+A1eIeFrbMki134VnSt1aXd7Wz2g2hhZKINqLEMsQCGcvw8EmWPSaKOcmEurHUVZ+AjS3qZIGDPiWeUYvuThIXeEeQ4hskoaoFuseADKQWG/5Tu4XbKZx6ExvRW2BWk4T5qJg/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhlvhJfl; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhlvhJfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788873171; x=1820409171;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ToTb+YFwFWAyYAPNX1W7zBLVY0yCGv9VNmSki1o3Tps=;
  b=lhlvhJflw2APO942PpG4X8+Oz1iSTKf35kIWY+W2nNPQp7/ROi5Pi+Kw
   B18o7C38pGllRiiQknoij1bbrxeKsWfyTAMPU7tswdSFfQp27estB4LDf
   oIvk9mDVAdu3x76QM3H2C727WpT2cTDGdctEs/ZRTkHEJ5YXEwe/X7tHq
   72cvoJxzqWSoTOe4wOfp8SjHuPZJ7za61qPWWtcmx1jAdMkjQwKcMmhUy
   U0obJADJvZAez4LTE1W4nXrlMm4c0g9F7IjJzFuw7uwusnJHdD/ubPAdb
   AmcwaAPg2YtF+Ukoo3BVNSLy8OGv5w4mbTHHiAt8EmYZvOtjmTX6NGo19
   w==;
X-CSE-ConnectionGUID: QjrucTJ3TniajIJhtf9w0g==
X-CSE-MsgGUID: fmiHsFgeTRKR+eg0nJofPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99934437"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99934437"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:12:49 -0700
X-CSE-ConnectionGUID: Z3E+flqlTyK1I1plJ3IozA==
X-CSE-MsgGUID: L/m1Lo6qTW+O8qAshikXNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274795370"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:12:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:12:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:12:47 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:12:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaeQzeXuxE1L0a8+E8yFUi8tjygHLpglPlB+nkqH0bmXnaNawBJwf1tT9ROkZSpwTITRaRCOCnEuNU9w35uo8IVjok6Ky3NFGIJqxf/4r92AvWCoXG9pv3tNHnyAG7zhx4y0QFK/OLZmDGU+cY0fQ602hy8EN4eSAWWVd0mSGxTcbVUSu26OwwH3VFp1lO0iyz++A3YisgeS8JUAj3RbJdfZV6WmdCfNw6DU71w0WQ8IZaNVXpDc0tSEVHw+p6l/Nq2oRzR6R0jwRgluM8VwKhAhk5sUkxF7CQDBkSI2cyKq6iNhniyoLvKLyc41I5Mm3Ll3PS2BuxIODQ8yL44gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KrQak25Qk5uVN593iR5fQKK+aOBijvD22c2E1uwSzE=;
 b=vEwKx0nzIV1hGEdq71SujRDOOnYDjikQvL1tnJzXM+XPlw6VHkm9C+J3DlUOLyAGvEsvqvCa4RHMZxinoR1HOz6dRYBOdkwMF8ZMS03sN1xwhjEneWj5tfnCbkTwT/T8qts8sjIGJtyLFs18EjO+EQTDIdJJb2u3M5pCPioN10DBX1XQJWclZiVxwsYHqvaq7KG5IA8JShwqK7Z4UYWwvVDqc0aI9V3CNcMMklcIql7HESJX6nYTYwL2SmNORh8S2SWHKiE5MZfL5CxDrKup2CWHgGVCh3akZGxOTvXFVmCDgpspdoDGSJzISODIMaMQ8y/BWO7riMZSp16iYxj7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:12:41 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:12:41 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Thread-Topic: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Thread-Index: AQHdO6ct+TVKM7Oug0usShLT1GzQI7bEsBjw
Date: Tue, 8 Sep 2026 13:12:41 +0000
Message-ID: <IA3PR11MB89860250A5F8F264E7BCE26CE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-2-ynorov@nvidia.com>
In-Reply-To: <20260903132037.81346-2-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: 7f4c1f51-f46c-4254-cc92-08df0daadd23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|921020|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: NbqbUseJvCYlTixKGO2/FEI5g0Eb5XMm/TLQICGtQqyYsrqRU0Trt41skWTIXkEAWeq6uX0mFSleNrIInlNPLEEjfNNVrSRzTEOEjZonXGTvLyugegeIVsw5kBpnGY5CMUIEaIbInqDr4yrLavnKui0319PtZ9AauwxuFH5oCDSDmG38Vb73bADRcwgOW1lyElgn6bDKYlksnBu4dOgt0oAb7sbvrtIUWKpJrZWQGQVg5kfaCGrha8C/LmjJ74xyKL8XVJf6xazz932cnbRZxfVYhH6J7zi6PrJ/ishNJf2TMiKf8/1dUJ9lCEaZQSTfilDeDUTRiEZ3+hcU3gWjD6NcgXkmi7GuV1KsgMJ1K5eHsyKA0zhCEctdZQiK3ibdaHYFx9UxuKm73CxUetpa0uUvFo6LspAcOlErBrJu0w48QSF7AX958GwuzwaA6vlYzzyPJikzm5ck7NI3qZqwTn7vNPObLydDHAFUIxGSlkhlYoc1EIaHb+fVTnJVGdeTjwO4y46lcZkstg6PaEtOBoo4LGivhKOA7U/+yyjOe83iqnMwUGzldq+2/vYEpauseVXuQDfHuYGUdMa56WpHt01DFAVdD6SYFmxEFJH/YBAiycsDgFypkQmL+ToFPqA/dSpGEbjviKTdvoiUnvQp9+LkrWCkmEqgS7NGamfoIC1ZUSCVGb2HA0G7FJG9c0ujuA7VM/X7TFGgl02n3Ujp5PoY/UIhiIMEorf9X4+WQBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddPMwvTs9FdD5QoGlxaNbZYV4yR8f1k9LAMgtguTeMgG4CSWrVFCUvhVxKFD?=
 =?us-ascii?Q?YIBpHNYIJQIdijBEMEOsWPcpvT95in/4G/t1nX2dGx1WBe2M1VpYsVomSwsZ?=
 =?us-ascii?Q?WRJVoiPxKa5DDtdAXC4djuRyt3r89OxeXqD81YCk7M7WHQc6M8kJhNphZVW3?=
 =?us-ascii?Q?C8beEZsyZqM1uvX4gvfbxECLl31JZQIkGXuP8uGrLdDnKBkEzab6zuIisUEz?=
 =?us-ascii?Q?zuLdklJizgYddqh3IGY83883LxXifwD8Wgn8byTRBE7mn9vkhJ9/bCxzI5X+?=
 =?us-ascii?Q?ecgl+abSS6k5H7HmrYMoi81z6q7UYEWUqUKKXyZcG4d0qUT1RB9Ohw+V1Gnf?=
 =?us-ascii?Q?KLIOWJku14tQGFScmbam7RbTcunfoL90O1QQ8GU7WBgVppyidDR27894IfTE?=
 =?us-ascii?Q?EFsutaFMiXpiPz4MXuQr1IZkoaCD6QifI6G04RhanJ8m0rxzeox6FnRpDa+3?=
 =?us-ascii?Q?xH3og9n+yDJf6DPaXO0deM8ulKNIdL/DHVhpHHKHZwi1d2s/r5L/oXK94b4Q?=
 =?us-ascii?Q?Vjl0vSwuUCkhL8zLnTkgSJpujQfBixhbI50M0OWh4T36/8x9OEJxRhVzymb7?=
 =?us-ascii?Q?dBEnJ7uE/S9WxhzmRYYncHw6LZfCQ+wMIVYpC3J2F41xws0hpjuKrANE0c69?=
 =?us-ascii?Q?39BPqISlPRleQBoVLH1JM08lKSpQYmSachHBogzagEt01oJ57tACHgMe0eO7?=
 =?us-ascii?Q?YbXQZDtEK/BdmRoFT/wyOHCpICitBj5JwicIqaNjlQvMMpFqZBaHzys8HAYk?=
 =?us-ascii?Q?t6D2XtcUrZ+KePP2CR1g84QMYcQ7UYyxf7cHnQG39IU76fHax+ydXFvo+7fD?=
 =?us-ascii?Q?xQ9u2gz4MJXkWsuyuLDxJVbN25EDhIq2z7V+hxsJDZqoA5LpGedsJBx8WwQi?=
 =?us-ascii?Q?oZ3PT3c2/8Z1/BCNoY6+7ROUm7sUax3wzBSO677j/rAhAznZexbO3mLV+l5i?=
 =?us-ascii?Q?TuJ6izFUAuZgzzx2bjJgCNbPebm/gdW0HnXP7QE1ByKLkRUmkjrFwPAaUZmL?=
 =?us-ascii?Q?o5MGhH36PSFShznKjJ9y5kDzQ+gHWvT2jIeqEJq/yDObl79NcsEBrTBi5fqZ?=
 =?us-ascii?Q?XT3d3RXOuhI2gUWO849vgrrlbp+m4spDI1vs2fma8UmTO/xb0kxV9pf4f0lg?=
 =?us-ascii?Q?4NxkmLXhbLneTiwyKZ7iiejqZPmP9vDn1UN3MKu07E3WFLm/a7NLo4ujiPpz?=
 =?us-ascii?Q?opw2flr4QIneca6HNPwC1eieCl31ytT+ruKVsTSYCugbWnsXbDQxRoK8OXYo?=
 =?us-ascii?Q?WH4dLzNNht0ST1COR8k8i9Weosu/aM4FCOs9EFFd/ZF0ph3XLUTDA+FLccxa?=
 =?us-ascii?Q?/77c9A+K80EOu21/AnmAjvLHhRAKXQ0pLXGQpFtC9T4zzO2ZpfFKlsRZpAyB?=
 =?us-ascii?Q?3D5TYm6UwvvmkmdfRN5ONJSWMqQEfzfls4EzSEuXXQbA0z7eCRbV9njNW3x3?=
 =?us-ascii?Q?oqsPMBnRrFINtMGgNdGxe8ewW7Ubf8ZzQEaxf4A5ojtXIfVfp7J2gyGziKFD?=
 =?us-ascii?Q?O7BMIxVnPCyYdvSpJXbg275VqLbU/dH/pHLBFm7WJCG+HKEn++jFJ8IWO0jS?=
 =?us-ascii?Q?E71WAcjmciOdeUs/miqKnIu7AICgBF5gPcKA+judqwXXVYVP+ZWACx4kh94B?=
 =?us-ascii?Q?W/Pmj0JnXdjPtdloPrMus/3bDkxD43Sv4hwzAzY7Q53+F+QMkJGMARzQRVLC?=
 =?us-ascii?Q?DmI/k5vX28e88a73ox4rDwJ0A8lKs/bqgafbRgou+OiOuJivHHZ2g7G1pmME?=
 =?us-ascii?Q?Gl2nll28j/r+MlAoVqL7NKgHfTPNysk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FlXJZFBYfU8lItz23qK8vtU2g1wWcG+ZlRrwv/1XihZZMCpZV/3awh5RImUtTzW1B6SG9DFQrDwuIZgrCJ71gnOx3B+CNqhKLgjZqBSvbKlUrrDMbC8PPLwwbKoFGj5yTURXYEZorm1usoDuzhU6kfeuVXy1UWjsGX/X89fahESoNZHu1T1vn0kb9zyS6sC6iraGEEB+n8rHu9+SHbDlWfwZrwQfqmfSsTjlrLUXKX7tF/COwU6Beu3rrDmWzrWVvQa+eaZw9W6xr2oXAsKl/p7DAJlFRFAqy4mGlyknTZvxxOnqzPM3R/HVPqrk6OfKGZ7qRCdotCSrHryoH7991Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4c1f51-f46c-4254-cc92-08df0daadd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:12:41.5277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAL1lysOHS8iMua+iSqgG5T+WJYthZtx+/rzZXlPM86T5UgHqId3fnpnTOj3VRo/Gos9O1hGLkuUG+KO1YRgrLdFUlpQpbItOJBe39Ks0ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Yury Norov <ynorov@nvidia.com>
> Sent: Thursday, September 3, 2026 3:21 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; open list <linux-kernel@vger.kernel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
>=20
> The function creates a temporary mask on stack just to check that
> first ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using the
> ice_pf_state_is_nominal().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d..73996e3022ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,16 +1705,10 @@ static void ice_vsi_set_rss_flow_fld(struct
> ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)  {
> -	DECLARE_BITMAP(check_bits, ICE_STATE_NBITS) =3D { 0 };
> -
>  	if (!pf)
>  		return false;
>=20
> -	bitmap_set(check_bits, 0, ICE_STATE_NOMINAL_CHECK_BITS);
> -	if (bitmap_intersects(pf->state, check_bits, ICE_STATE_NBITS))
> -		return false;
> -
> -	return true;
> +	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
>  }
>=20
>  #define ICE_FW_MODE_REC_M BIT(1)
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
