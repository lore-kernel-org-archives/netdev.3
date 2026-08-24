Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32196423E9D
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577498; cv=fail; b=VxQZPIDWn9skUaG7R3P+oTJMJrzGEjJV6An+4WpoOSb/u8g6k1gJbgJjvjF4YHiko4XQOdbwuQzaSt2kCp08rkIlgcCrQRKyRZ18w7KRDsBhOgqodoXUD6rSTLm67qsDnwQDUcA9/PGK/o79OHXvq8vBPNfoPePUnTUwM+jJAeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577498; c=relaxed/simple;
	bh=TW0qQ4SXx2v78bnQXvCMeAIb37d+iybngS1Oij3rRLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHuSCf413zKG0fOrxWgwDba+L5BejrkveSJMLoYrkIqAq6l7zgkrHnprUJltewun391v6UcFkfybHkNxh3v6bRGYSXl9PG9RRf1oYp9fl+baqP4vWnT5XP3IINA9JiIC32Rdc4kZzanx9rphxa6TVPTlWJOatGIEA5sRSGW2sCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvUdrPT2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvUdrPT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787577496; x=1819113496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TW0qQ4SXx2v78bnQXvCMeAIb37d+iybngS1Oij3rRLM=;
  b=NvUdrPT2ROihdEdoF5gHbeDgRAMdHX8rFXwtkwaUWvlvCmXeLAQq6PE1
   ZVtQ2DPMPbEtPGFN8Y76jhwiU+wS+4qip0WYdVhdwUe47pZqEZ747MXtX
   VVSUP3Ujon8kSFQIYffm/cDeeiGVlrGLdrRZVoBsZ+f5Hk5LPDhKWsRad
   XPEHVj7w15h4C3kmt8oKsJLCFpa9km3sNiSz4coHI9noPoDVKy7IP+siL
   VdXfXDqzBAKODWYlI5+xxpNkl2rwPhHMd4VDQNb2anvuYa6R839RM7dYI
   GSiYZq5Rj2jN3XBLNULMhPa1jppJ8TZZCNeRJWwDNqE4Cz1RG6fceYDQO
   A==;
X-CSE-ConnectionGUID: PLeXdyByS4uibwGQBbwPHg==
X-CSE-MsgGUID: XReHWK+HSOm0VkupZejhIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="86978181"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="86978181"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 06:18:16 -0700
X-CSE-ConnectionGUID: 7CIQRa67T8OeOjbM8foAiQ==
X-CSE-MsgGUID: vOvAeHc8TOeAXR6MXDF+7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="272221759"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 06:18:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 06:18:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 06:18:14 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 06:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3l3cG8s4DPK3jTtkC2Q81tPcOpS3FAhnZj9zjPrjmbev65Tzv6npcXjAFFgU09Mmy6rlFE8E8lDRyT6/G54tsO8FIKvHB04y4JYKFsVDRJj1zBf6SLEz9S8jXfeoZsM49N+6vPBUTEigHEotP6PbRg1o2M+oO+yh3wEETdA46nQLjAxJENKsuUvmtFDdMoJv9pU61yrHLd+sR6zEr4wV2+BQr1zetHm/eNDvussPmExj1YFx6aoSMn36suUPK28ftxTboTDsml8MJfQIUCSUVOYPuKPDZHYgLodx8WhdQHVrsfdQM/PeVNrxE2wyco6PZZf/DJ0KYJlWjq+U+sabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnD8vjPtlWIlxCfer3VGizdSuTxUleHJFGBPvMz5+nk=;
 b=xHfbDvNhWjgHzygfH0MTf1x4PkeeSyRgZvcaFdbbjJUHHGv6RFlnFvvY+ieuCyx9spcYAEXsDE0Svvqe/ln/yEIvggc4jSvt0AxrWT9lKgwsRs/OZp+LBuvvx+Pkt5cPmzMXUm4kLDzjnlVHFwYiHdp+gIfwyFTMm3aYBafCEVGRl5RiWBfBiscnE91hXVMIaHN1HWzhxSJpcWhv+5Q54yFLMGKuL86ltmvRB/ucwHsH+jBCPjkPYhQIHqS0FPQ1V+H3LwIaODJX/X+TQtYgSrgEUY2YRjxlJsu1/pGe8WyMeV8GVC3R+sQeXWuRk4rGXjC3zyhtSmNlXi03F64bHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH8PR11MB9854.namprd11.prod.outlook.com (2603:10b6:510:3c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:18:10 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:18:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net] ice: fix bound parser hash offset before reading
 packet data
Thread-Topic: [PATCH iwl-net] ice: fix bound parser hash offset before reading
 packet data
Thread-Index: AQHdMJkdFdjrvzNm5UOoBwl1b7eNgbatEKEAgAAjJdA=
Date: Mon, 24 Aug 2026 13:18:10 +0000
Message-ID: <IA3PR11MB89864B9D29B763A29C25B823E5A02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260820114314.646344-1-aleksandr.loktionov@intel.com>
 <20260824110838.GP265046@horms.kernel.org>
In-Reply-To: <20260824110838.GP265046@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH8PR11MB9854:EE_
x-ms-office365-filtering-correlation-id: 754ffdab-4b48-4729-0ff2-08df01e224e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|5023799004|10067099003;
x-microsoft-antispam-message-info: uFTV+ID4zJ+8OJCTxJx5+mOx4eIZDwhk+ym5TiwKg3LPiX+r7A5Ji97ST01LhEBvD4UznCC5f9curW/pZMKg5SmahDgnTmtwbB1s55RKGm8RZLglZo7Yvc+1RxtEl5tGgz0EFw44wFmqrMNaaGjREy8ttHZlVD6Sm5ca/6UeH111UlirHE06rd1QhmKgEKwNBc9MGF/dPLdV8t2TTtwCCBO6IFZIFpsGPY0pUR5Nf6TMhXGJf/O9Nn1WEFFQ1stbRphOnAtleoyX2F3yHeTrkJEGn3Nrww9PoBdIIz9U022lyPlklbQqW900i2ZULhPIU8z8L64fXyCaskIawgFVnWdfmnDUqZVTfdTsxqM8+7AwFkFfIacMs+vMnw8/q+bUJsfBnQE99IYjZmeWrGmY5jWQZrMHs6JbnV5Va8p8Fn3Dq9g1XnTT90fkJQfAr9FQ848XvMmqL9t4b9LgFM4X25P35dnfiwHaga07zkwXokPcvuNuAGs6mHJZxedClqag/+tOkakqMqb2dRwIPtjWe1erbnxqPIL3qFwOm4fDe+NwFVzdUp1tJHgw9apmFIBtAfTHuxZv2ntSp3E4MV5y/Ek4+ryyJD1kUCERbYdop5L+5PigkLZA1Bc6lKZlqBSRk9LD3n5oTX/kaDU0pFQ8CH8t24JbCkKI0s2HvLaqDwk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?13CF+LdFLP75o80d1IKAibUyqLRycbNKmCLWBzO6BWOKrgCKnRendcAUyGLd?=
 =?us-ascii?Q?eY21HXp3B2RUXDHeq7YJeD5fRmPRFB9sgY1zPodyWW4thCsyF9pFlYDvU//H?=
 =?us-ascii?Q?zQ2HpH8Ti5wp7OVJDDJ00KrfbW/9FcfIvGz/bjmkv5PZaaLDVSMiaaF7Jpa+?=
 =?us-ascii?Q?mKHIw3Cjx3no6FY1DGWaaInnZIYl+5oO1RW3wBHTKIWZNy4MFcBu2AdIDb5q?=
 =?us-ascii?Q?r2/18gKBWhoI+1u2fyj6MqM0Vjw9v+DIf+/SLZNqrx/hzjQ/WAeh0GfqxMm1?=
 =?us-ascii?Q?ASGSrx1x8bkou/EsTZy/MMs+6i7M9dRcCycGy9yCt8UWxFJDzwbTjp34pzJW?=
 =?us-ascii?Q?62qiGaqVRz/K+VOBf/fn5f4tbTG2EPvUsVTTp6KgIwZIaYvZXlcGDftaMRnM?=
 =?us-ascii?Q?t1g8iwGtM9tKnvYenWQw7t7HFd25txUzaXsO5JbgPAfn/fq1KiH41doLTRba?=
 =?us-ascii?Q?d+CEXuHWHV2K1kDx4rFaACmAYSOMYw1mmlw4pJCdrpkv3DIRqkMHvSBQlMBf?=
 =?us-ascii?Q?rNzMwIA2ilb2ygviCw7mXong9HvSLlvuTdK1Mrq8VLINepqV8Vc0nhjGtJ/k?=
 =?us-ascii?Q?vEuhKConBUQPynFPDE+/1FegdzVDoNEkOI7orRzBPhq/HjNHSDnbfex9eQCO?=
 =?us-ascii?Q?mNRWDgkg+7ZsPYnh7LMNZtBq1zJsYL7XD4aj4Fj86x/w8M3IDluzuj5I5vF0?=
 =?us-ascii?Q?m6O1vEqGEJqIHoMWgSHjKitp1CmviMFqk3SrrFWeE9X4LvI4aJXwh+NNImbr?=
 =?us-ascii?Q?ZMnm1uVOIv7YHllE99t2PwxWhESDSdQhYOni6nC761hA6PcctKDgSnlRvLv6?=
 =?us-ascii?Q?mgKZAubuRYzU292gXtJ4cUZynLMoglXOtHZGcDXkT1V+Q3MJ2GKMf27lOrHQ?=
 =?us-ascii?Q?bN0ouVmhWGE6F+MMLFlyJL0ziKQo1Epv22hYuCW0MxkKknzypGRJVS7Ctnrs?=
 =?us-ascii?Q?VtnMBKDB99+/bvPQgdDswwx/W6TuO05wUFfWrPpLFlwSCZ0emrHD6j5wGtSb?=
 =?us-ascii?Q?UaUlebMzWmhMihA2KCIv6eMLPVjROVhwXx6kgsPynhoZaI7DpYtf/t/23tlD?=
 =?us-ascii?Q?tk49LNRVE9eKUtKgf+eSkMKXBQ9jpo21LFJhZZ+NAAqWrsZnV/ccId4Oq30t?=
 =?us-ascii?Q?akrlD0WCz/ro56fTHNgDW4YVHasqBDQgwkB835iv0Te3h93smw9gBRnbZa0I?=
 =?us-ascii?Q?8ReKeaui58ZJbbiYX5rgRWxRQDMcnwtFAeFhak3OZVHr5uUUsjvTuLCc1NX3?=
 =?us-ascii?Q?vpe3HtUsuSNtd2G6iMRrVviXhMyk31T9CicwinYdslNyWO2L98pfTHAGeS8v?=
 =?us-ascii?Q?mpiFN26Ah3Ruq//DspGwVeYhWheocnrgA6FZjw2ygXHoixarWlzQoz5LJL8R?=
 =?us-ascii?Q?5WTPWSGS05sFhRcTrnjDRBZ29ZBcrcFhRJ9Lo/wjOanf+q+WsYReeAel5yeH?=
 =?us-ascii?Q?6O3HpI8axKuhC/ZS2VNU+gQYuu3Mq836FVIZdSyzD5yqfUtzg1vHUoqLRW2C?=
 =?us-ascii?Q?zzg+3S0zY54JfND6Tgq7Vo2hpP8ocgwV35ugS5jzt3QQdRZ2d0TsCC2OQ6bU?=
 =?us-ascii?Q?32/1/jnvOHH6Bs1a8frOoOg0cvNF8TbxAYfFjfG806HudfOdk/okqNFOXvM3?=
 =?us-ascii?Q?HhtvR/VLxqPUsc93MzSYOXv4/Lrf7ToU0L6mSZt1dKd2i/2wymUsMJIfwNKq?=
 =?us-ascii?Q?kzoBTQ3T4fPrk06/c9ERryrxgoJcpNGj1HvRP4+fxOLq5z9rDVGrbEqQGtsY?=
 =?us-ascii?Q?VLNmyGmI9Ba9w7yO+EXN0wjkOSlRJEU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zpjVm1vhiCzQeh4g666vDAR+3Wzx4/l5u9EMa+lzVejUJDEYSRRq7vu/NIXC75+PyjfMPtRlDYJ1yDINAy/m/ovXe029HsXO8FDoQCC9DmF+LcNPgcyjOyl3OnJwNX3DFTp9LVxKU/zFOQutDLiVHp9nSu0ZUOyxp7el9+tFUnzW88bwpAp43A3AF7TMLLAmurrlWDkJPEdLYpT03sDqbPQJ+imfjBkLK2whzi1l4o8JdrDkP8kf/XJRh21FQNBaFuGYMAWykyi5/Npgq0g2fLqYHC3RwEXQ0YiX1ZgVCDSXERC0f7bMObnlE3ztMVz22z0cDxW52VzZmZ354w7S+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754ffdab-4b48-4729-0ff2-08df01e224e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 13:18:10.2984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MU9iHUFBvtjJDIxVVlRre21N3Ah69RrklrCejaYKDJM/9tJBvy579Q9OYSZye96Kn7cGsZW4ENuZr2vqDJ6PjFOT5yvTgQ/E5oRi8pTWli8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9854
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, August 24, 2026 1:09 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: Re: [PATCH iwl-net] ice: fix bound parser hash offset before
> reading packet data
>=20
> On Thu, Aug 20, 2026 at 01:43:14PM +0200, Aleksandr Loktionov wrote:
> > ice_rt_ho_set() uses the HO register as the starting offset of an
> > ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
> > be advanced by user-controlled data reachable through
> > ice_parse_raw_rss_pattern() -> ice_parser_run() ->
> > ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e.
> a
> > VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
> > size of pkt_buf.
> >
> > Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can
> still
> > be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
> so
> > it stays correct if the packet buffer layout changes.
> >
> > Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_parser_rt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> > b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> > index 3995d66..bfdb50b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> > @@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt
> *rt,
> > u16 tsr)
> >
> >  static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)  {
> > +	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
> > +	ho =3D min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
> >  	rt->gpr[ICE_GPR_HO_IDX] =3D ho;
> >  	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho],
> ICE_GPR_HV_SIZE);
> > }
>=20
> Hi,
>=20
> There is an AI-generated review of this patch available at
> https://sashiko.dev/#/patchset/20260820114314.646344-1-
> aleksandr.loktionov%40intel.com
>=20
> The first item flagged there seems of concern and I am wondering if
> you could respond to it.
>=20
>   Does this new clamp introduce an infinite loop?
>=20
>   In ice_parser_rt_execute(), the loop termination condition is:
>=20
>       if (rt->gpr[ICE_GPR_HO_IDX] >=3D rt->pkt_len) {
>           break;
>       }
>=20
>   If a guest VM VF submits a raw RSS pattern with a pkt_len greater
> than 504
>   bytes, ice_parser_rt_pktbuf_set() saves that unclamped length
> directly into
>   rt->pkt_len (e.g., 1024).
>=20
>   With this patch, the HO register is capped at 488 (sizeof(rt-
> >pkt_buf) -
>   ICE_GPR_HV_SIZE). Since 488 will never be greater than or equal to
> 1024,
>   can this cause the parser to loop indefinitely if the state machine
>   processes a repetitive sequence?

Good day, Simon

The clamp math is off, for the record: pkt_buf is ICE_PARSER_MAX_PKT_LEN + =
ICE_PARSER_PKT_REV =3D 536 bytes, so sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE =
is 504, not 488.

That said, the actual point stands: ice_parser_rt_pktbuf_set() stores the u=
nclamped caller pkt_len into rt->pkt_len, and both raw RSS and raw FDIR VF =
paths can pass up to VIRTCHNL_MAX_SIZE_RAW_PACKET (1024) > ICE_PARSER_MAX_P=
KT_LEN (504). After this fix HO can't exceed 504 either, so HO >=3D pkt_len=
 stops being a reliable exit for those inputs. Doesn't look like a guarante=
ed infinite loop to me - the graph's is_last_round action still ends parsin=
g independent of HO - but there's no reason to leave a dangling bound in a =
bounds-fix patch. I'll send v2 that also stores the clamped length in rt->p=
kt_len, same Fixes: tag.

The DDP-table-index and FDIR IRQ-context points from Sashiko are unrelated =
to this patch - different code, different trust boundary (signed firmware p=
ackage vs. VF input).=20
I think it should not block this fix.

With the best regards
Alex

