Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5937756A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505280; cv=fail; b=J5uvFyeJt5iuWguhLOANl2DuVACviq6es15Z2H0xDSXbv3ZWdrRoQWiauOiutvH+Qo5ATzu8jh41hGyLNCYURvXCDP109i6jBPrMoGOB7Z8jNCz+djnRUnkmOm1MUQqe6HtJEJTg4MNIT6OEXRqSC9MI8DLfAkg0h/DE6POVwKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505280; c=relaxed/simple;
	bh=3K+3xKELdu92Te+HKa5fHEoqNwsmdOcZhbqHsK3n1k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DytP6E1RNVbqNRALxq0hP+7y3Y+SZbtTzRND/laHW2bvnASzhyJKmePl2c17WNgm4U+WvEb0UkJIcF5MDWKX5JLNxEjipuKDetCHMii4KmURl/yIayvutrrR3oGhcUtOxYtLWaVTzf75gp2WCJ9zpufkyWCDHNdZiMb0IpA2aiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyLVa5m7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyLVa5m7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505279; x=1820041279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3K+3xKELdu92Te+HKa5fHEoqNwsmdOcZhbqHsK3n1k0=;
  b=lyLVa5m7iAbYL4I1xtQBwzhk4zHOPwkZESvYFNTrqnGdU6ssznVBqsSB
   zTQaoDeEZpR9h3ry0Dz/V5sE0hRPlW85bEh9EE2VmNVIJevxs6eBA61M7
   gUMel9WqbPV3JXbIEuVRn8FheOKbebrdX3NG7dfjGvfFM+/xQEF4vdwSP
   N5OUTJEhVC4cpxedusK0RQ2TT1qEM9MGP3BQxxisfLRyNQ1hxmpT/Uo39
   qQ9bZ5z60OQNuloIaJyXtVUy2grr4RVGxWpL5VLIFKCAWer9q+vzuG044
   xlzKYb3CpEzJjzZWPhtu/bR9uZyl7n4JkE8cI6YUZx986GBGlUrI3jlHD
   g==;
X-CSE-ConnectionGUID: oI/xI6lPTqK+kqr+BzHXBQ==
X-CSE-MsgGUID: WlyW1kq9SK6yrfi6TVvYIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92699551"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92699551"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:05 -0700
X-CSE-ConnectionGUID: njrGRnSIQyWt3qHcHU2wLw==
X-CSE-MsgGUID: q65cM3hZQDi5CBuFu+788A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="299826672"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:01:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUlMBsw7ObS2TtI9bnmHTvuFB+pPawyoPLxOFsmI1DbtD5o50LD8u6N4MzouILpUjpYjLbDH1C6hZt10XDorwRw5rAqXRQ16XiSvd0KrL8JWjLL+5xRoSQOE3n5hzLqsnN2AYwDzlt2ctgcQovnYRll61fRtASl7VOz4syxakKpliOICKjhsvHmn/VApYzxXSDvj24VKXQcBrglolzppVfXVZCeTPGUyNxZtbsh7wS99SQNvSp1eJcz1gLzMtztsyTMHfR/+AaCygjfC4tcVV/iYIuyzE/gS90k2JgJoo9fFiPAEREorKzLvV+EUHuKD1ocjjA54ocpsRyqXCV4XTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW0pL46r1jumeBuc06vjoCd0oN4F0n7n4EO3HQIIN+4=;
 b=fVRbedYfIhfSJ2UScpLo6l6vZA7QoI7IVfAtGmlrNNPJCuuw9na30AAsmiSliNafjU2O4Wsry7mkwrSbkAJfiUAbAcWKonY5IORxtpyYJHxFmzFOJseluGbQB3K4WEUimcTxmXsZzE+uNIWC4EgE55cDrNc1mA2u8S2cSGD70USvj0By9o/Q/gTG7vnemK9OxdEtU8SHo3bQPD0N+dE1C3kUxK45Z9QfhQ4zM+BEtBiRqPuJ5m4C4KcVmQDY3OAfvA5ZeyiVwICn2FGpS5vkp+tsGsTFah9w9c9xP56W3BMLK2L6wJglGhn19nzkTo0I6ETqHhPMkj878nzNL3Pq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:01:01 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:01:01 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 10/12] ice: add ACL reset
 recovery and NTUPLE feature toggle
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 10/12] ice: add ACL reset
 recovery and NTUPLE feature toggle
Thread-Index: AQHdChZO6iSMKIgjIEy9y6nMHumm6ba+V6cA
Date: Fri, 4 Sep 2026 07:01:01 +0000
Message-ID: <IA1PR11MB624173583898AB9E343DA0E88BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-11-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-11-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: dd164554-2edf-447e-98ec-08df0a52477a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Vorhytj2KP/flRojBZmHYKCAam6CZCFJwRbOA0ogs0G9rvT+PvMlTX/FpObu/sqG21QXhMn0HixebImSIuHbo64YcFh1PAEj2JqLtwQ7MKANH+W/byOd7hiYwUYCF0OZR9QVVwEH23l22YYE/gh9b/GLucT1UtXsvA+U/kkm3LTe7yFPM5mIKM2sXJvSqzHJTzh55/LSi1pDKewa4QO1W8YMLNgENZxmLlozmHCzReXnJxQxe57hxWPbjTmRJ9jAqnLUonQ2yRy7dhb2xzINymhtQf5qJW5+gYwfKqZtqNHeCzQziguIAxFaSF68jOe88GzAISwKWguLOyWiUXOTrIDKldkUWoPa341kxlBPmsHyF+P7vimLZtu/fdZT++SZqifnRgxYqEE3pdJZvzSB8Lku4lhoVdWcUMDYwMUNfMGFXL8dujHO3MCmtLPxzk0SOs6tsXSu8DCocgU3SqU8oYeHDkuuRsTviQtHXsQSko4/cmQFE4ZqDi6pLcjieT2YN38QavfmfwuYrP8HSlE4yFPys4oEG10iym5stT/EcMkwJm6MxAiS/Ajh2PIS9vjoa9nJdyB3a/VDWsnyBNtveP6zitryXPjqD5vRziNiGDN5FvkKj1yu0KTYuf3BgFoArGZnQsJas9DaYt/2EMiIkCK1EESNBqGNaTRiTAZhsvoqnCrAa1/FQmleJ1OW273gMSkzWJpVz18ZXmOm+OpTpZ78sSj5JGqH5xkbiF3AdN8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y8DAx9wCGP3BM3801CtLl/ZBu1YpsdOR8zZxwMR9Ag+n8/b/zTbH5l+TaJM1?=
 =?us-ascii?Q?gmNNUVAQJMlv8FKtXaOcco9pnMgePDpV6QsRT1wSw27iiHLdWtajVATC+y5G?=
 =?us-ascii?Q?DvvUHvpsuEXAwLpsyV9fmY+s4y6KVJqDWYQWZ5SuvRBpdQ2b+i5qP0jiCEwg?=
 =?us-ascii?Q?PJ099u6qP3mdVPFt9hXCwP0WQ6XiySbAKeI9ZQB92IY03oOUVvtj7AsSRIwz?=
 =?us-ascii?Q?nVvGBrrXG8IToF15W8ZoZrROS3VCAC24nVL+0ZeReSUhPLb4ST2kUnAy57ys?=
 =?us-ascii?Q?f898/Q7lCb2rjIvhwoNvxlkW1FEJSbTVbHnqeIMllWMPC9qS6hZ/YCvkQPSC?=
 =?us-ascii?Q?XzQHEaHbhs6N67TqajiUH0ObGnNjCFLhBcu3c67EdHrrYVBZ+TmWXArHvLIN?=
 =?us-ascii?Q?0IhfQCUpwfpwGbofZHJS6mFJouhlU23+E/3rvFKuLBNh39dyoAubX/0Nicq/?=
 =?us-ascii?Q?bV/IQKTQWKDR1/bs54sRncbpKaVf1x2SqK1mQTGYcTI1N/maV4hQ2ZgIrraT?=
 =?us-ascii?Q?tV/LhNAzqGjlopIpP4PY+gPaTmqHMB2oAzW89YAurINKNEUYg3lJ8Zhp54xI?=
 =?us-ascii?Q?EN5XH/Q/FJOvfG2M84fJH/m+LykkJ8LMsqCp7bYOfrMzdg15AZ3Qr2DspVRm?=
 =?us-ascii?Q?HK04Ua76f/Axo3D2CKpHHNDqKuSa1cx+beqLCF6BLRlOVM9gYG5bTHadmlso?=
 =?us-ascii?Q?IchqX2XohmAL9w2/ur9GAojTsMGhzFN3QbCIOSV+7e36MWIcytZ0RCz//wIT?=
 =?us-ascii?Q?05bqUjoITHSajRMrFItmqBnXGiF10Q3un1CQFbsfIKsivo00NhWqP8MjnzJ6?=
 =?us-ascii?Q?baX3xOTS1W2xzUf0GmypC+P2PM3N++CWJBPfiHGOkBNEMEtHweWGngfLhQ4O?=
 =?us-ascii?Q?NolxyULGFhN6SHSOlY9ndMM0vAA3xqJjKx2Q6vQ+TmhGvvJrI02KCLmyOnun?=
 =?us-ascii?Q?orXKNp/+aA6WWDWFMAhJjJrEKMeitTmk93Q0IePQFabEdRVIRALAL5/2bFMt?=
 =?us-ascii?Q?YJCLMpMoWVDC4TU01zAsumBt4v5/jpepIJx+LbWfbxE2GO9RanEm4aaJTkwL?=
 =?us-ascii?Q?lI7c1vQMxksE2aNhSmgPj4VbGikVuJodOQDBNC+rXT7jUoqvf8iiOFt7NMHQ?=
 =?us-ascii?Q?wih7mPYEF9dHT+siQPVcxu4gPXyVSEfJ22R0siH7ks8cTUw/6kpAzcBem6hE?=
 =?us-ascii?Q?YQzHxcEYhxbo8mfr7VLQpoakNYtwqRFrrWitOBHYgxOz73eCVTtC7/U8+vUa?=
 =?us-ascii?Q?3XxECSIbsGES1p60T/D/pjgHU0qA6EOzi2BRWSQIajQUjPtqlUoK6v7GT92L?=
 =?us-ascii?Q?7e6MlZvwpmwbHXYdG/UL4YevWt7WSz2DGgV5Axku3f6KlKQhBojH5FfyMUP+?=
 =?us-ascii?Q?4kJrKlqmoIeW9HeBVG8hlxN9YwHCndJ3wFKb8Mm6IwEF4/YuwExhFlHDwbae?=
 =?us-ascii?Q?zgy6lA9DT0FzEO7tYK7ptj947HtVmLfdoDcf7oeXe5/zmrv73RwFaxks1NFQ?=
 =?us-ascii?Q?otGv2Kit/Isinc7H+MAWAVfXUtk0AqSedV+fDqsPD4MUoUoyy5As/jlTX8Kl?=
 =?us-ascii?Q?2g4MVr95HHvpoRA30pq4cGKz2fCm4L6ShzcWGF06ZuTVkJGqXGwKw8dv2w6j?=
 =?us-ascii?Q?JPZXD3+3HUsXZc+wGSQNPM/Lo6GFNLNcrjVoGnbd+W93zGtG9yoUxacAxmj/?=
 =?us-ascii?Q?Xu3+npyjCCbD775qtC/QysAqrSfFZMzue+3ITRd+81zdkuMh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q1HN6rzg6l/8opGoYbxnFSCV1lYm15LUrt43VPky+cE9ixpjVvIXHOkzb/naNT6BeRlVbel6trKB9oa67R2tndeRWpn+NMZmHA47n1eEKyzgxXdZrVmF/TdpQGi+4I83r6CIaPn31vq+9x6YiLJJhIPxyn03ovUcAUyZklk1VgAyLM4zXHKB7ESS9c+neECUq795Xzizr4NkgeC4kVYJYjt+4xuaMh9yv1ue17mPgQAVsUtEd2LHWhtxDHkTea1EsvpYdDCtF8BLuj/zoniN/NjTLxBnkT6k4eXRrcqk6YNMvEYyz+mRJ+mVjZ3S4GNoDLwEH0bocDNYyg2aem/8Uw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd164554-2edf-447e-98ec-08df0a52477a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:01:01.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaEoVetGEuiESmQRc+g2a7HkTfxGFVcGmSsTiYFbc4Lt8SlAPBfr+3Pju9Yudb6l6DBimp1WkmR/CwjLnsoeRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 10/12] ice: add ACL reset r=
ecovery and NTUPLE feature toggle
>
> Extend ACL support to survive PF resets. Add ice_acl_replay_flows() to re=
build HW flow profiles from preserved SW state, and
> ice_acl_replay_fltrs() to reprogram TCAM entries from the SW filter list.=
 Wire both into ice_rebuild(). On failure, don't fail reset, rather delete =
all ACL filters from the SW list.
>
> Reset per-profile HW extraction sequences and range checkers for all prof=
iles inside ice_acl_create_hw(). This state is separate from the TCAM entri=
es and survives a PF reset. Explicitly clearing it ensures that the old con=
figuration is erased.
>
> Add the ICE_FLAG_ACL_ENA PF flag to track ACL status. ACL is always avail=
able, so set it unconditionally in driver initialization. Use the new flag =
to track the NTUPLE ethtool feature flag, alongside Flow Director, as both =
blocks are used to implement ethtool NTUPLE filters.
> Like with Flow Director, disabling the flag deletes all filters, but enab=
ling it does not reprogram filters.
>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * Add this patch
> ---
> drivers/net/ethernet/intel/ice/ice.h          |  4 +
> drivers/net/ethernet/intel/ice/ice_acl.h      |  5 +-
> drivers/net/ethernet/intel/ice/ice_acl_main.h |  1 +  drivers/net/etherne=
t/intel/ice/ice_acl_ctrl.c | 43 +++++-----  drivers/net/ethernet/intel/ice/=
ice_acl_main.c | 47 +++++++++++
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 79 +++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_main.c     | 47 +++++++++++
> 7 files changed, 201 insertions(+), 25 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
