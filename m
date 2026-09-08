Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1DE3346A8
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848393; cv=fail; b=BYd7wDpp+0OABsaMRYFZ+wjOqjs0AJm5sMXgIS2nXDXE0Mr9jkaDGv8uwqrLEY0Xvdmmd8NJbTsn+fG//fRNoJGIa4niKAt28i84wFKrDqs9MTW3nth4F14BndzNnivBzAKE2b0RrUGsoCnweKJuAU/wV1cKtPplzV3FT0iwZtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848393; c=relaxed/simple;
	bh=f5BVxWbZv52pd/QTIDQAX1ZiWfUSM40XLE51Ep1rcx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lE4Bl/locWCtNSeMmOaQq/92xlaZav+kb5AGzuZAJ9D2wf4ElG/O8aNplVhPQJxzwv7OasrY5N4mYw4a44w27Bwd39GS+pyIzy5CEjy9KmnWyo2LPDmNUQEoYL034GfliXiwue1hWOMCJ1MeP5ETU7Z2eJCIydS6Rulk6NJ0Lxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jt34rKh+; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jt34rKh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788848392; x=1820384392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5BVxWbZv52pd/QTIDQAX1ZiWfUSM40XLE51Ep1rcx4=;
  b=Jt34rKh+cNntBj/vOx5ZscchxC327KXVJm6lHqEgx9ZscokyD1D5ofdV
   LQJerMkoC7HjHoge2Fzq7yalR8NrbJo6xht1gNEcg1Qlzj4tmtADmRPdB
   PoDwhOkF1AXbrFJIj3GxZFBuHGTbn/OGPjJ7041leskcOP2b2Y0uhlDsN
   3YE8PjdRHFalf6VdP40oztX3twzx7L1JS21tBrIEGFKCkIEFMVWza+g/Q
   Qab19ffhQCOwkFMgTA0d7iCerndU6JDkKTek813zVOD/4KCYY2AGqqdSF
   OF8L0LKbsyA4FPkFrKzmdtgBnfSKqeWTVf8gEckntgngyn3GbfgRgbGW/
   A==;
X-CSE-ConnectionGUID: ZfF8ZcP6SlirmSPVAeePfw==
X-CSE-MsgGUID: /9QPyPX9TnGM8bZRoo0ZXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89085679"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89085679"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:19:52 -0700
X-CSE-ConnectionGUID: W7xz6Kd8TL+/KChEwknflg==
X-CSE-MsgGUID: xa6UCLJASdaPgoRD5NWjdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="294376071"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 23:19:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 23:19:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8VtnVK3vWJYPLkXFelemAzNRYXtYHPhze2lp9AmL316IEeZqVx+Ji3yyZ67SRCumNKUjNpXORp1I56ezWC3qiU/4+g55SH8zH7APmO4actPfwovLM8ZlBzaSCuwY4h0OOex2PTrOZhAFm6mhH+DNQQjjvcT0gpPGJqlfUZ7R9ZwYBHwqeIVRMTPMhfvVmIZmlOmRAzWci70UZpFTSEA/Oe/IqRkwVkcj+uZMYizOk5YKj3Xm2R4TND2us3KWKcdt9mjDt/u0MZlkVfH37V2BCIrZqXrYcUp60UEuckP+wknE4pSUiHXARiLe9ui1/mvyw4peAc5g4Wm7AMELKSj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm5GAMgyj1pLdtzIKNz7uE4ZzTRhhkUVJ3pxVdYXoPc=;
 b=BaXd8V0OC5bpYIrSBEnrR3FpaaBUROJROR98RZiwS+79yiLaZ4ksiUWxOrAJ+oBNzhupVd33NvVJCGB9LDEmmxdy1bwRfivZ1I7LBOL59sCfG90fmf6hqql2kFZkbgQ2tG8wiHAu7Xp1xkmP9MdVagCcjKp7aUvCgC8wfKpGNJBH4cIJS2lY8GMhoHoby66gFohXZ+od4Thx+i1xWAyXCEeUKYzcCDdBcGggUYa4MkeuG8IS3P5ec+lE023VvU1a8HSnYAIc2f8Yxgderuf9BA+yo0QctZtFnz/p1QsZxqDX92gBtfGi1P7npqpsQaNmhLAWUrXejFQ0qjoeump07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 06:19:48 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 06:19:48 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 6/7] i40e: do not expose netdev
 too early
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 6/7] i40e: do not expose netdev
 too early
Thread-Index: AQHdCVeZSG9fNyr0PUOarM6hcgUMubbEnKhw
Date: Tue, 8 Sep 2026 06:19:48 +0000
Message-ID: <PH0PR11MB7522780A3B7655B7666F6281A0B12@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-7-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-7-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|LV2PR11MB5999:EE_
x-ms-office365-filtering-correlation-id: 3046117f-477a-4759-a655-08df0d712f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: gIPj3N2uwGgapqbIwDILWAYguvqpCDvuwuKDNRJkCDeit3j8l2UoqXP1sSy6CHh4kJmVJsT5co5cZRlSpRqoNQarT6ay6T3uOQsRwMzqQE4z0lq69HUgaYLOPO+UCDnn+rsWK7tu1rM++KEIe++9/UC9O90nuv+UhQtK/kTNMwk+o8g5RnBsgA6pmqzNNBhJImzlSLGbsddEqWcy+waVZbzMdS09HZf1JQnbRijNnC/F4tw6QhhHyMRxcangGVLJDKerZjJLy4VpjvdY6fkbugI9Zr8Fn0Qi6StW/ASMKLz71Cu7kPNMBXwljepE02WtvydUzX1exj1zBn3JvitNHLU86Dnk2otYUGBEm83RhHEMiCPPAcRAXPZP5i9mw9mc0xUCz0LLRrcvIo3PjH/+upnqkHhpBsT8xZhrDoHITRlw/sVYSfolOVsI6GTR4wn0Rt2MqjashwIEe84RTyuazwxdRSjALrproIn106bG0cDHQQc0mNOv8mRoVFiw1LuUs4Yd8nOqYMKbgvu+rY/AI/XUUdF0vtBSAQjJh7mil/ub1CUE/LmMO16UXtV9qrgCLzRX7Hsn3MPJugFMWBslWFGN2o67oCZPXl9szo7tdm97NxowCBYLQQJrZvjSQgztSULdmXdG2/F7n1t5s1Glk69av6EJ+5sCRCMLbp3wtASdhrGVPx9zOFJ8goz++p9NRn65DyWl36PbXqVQzqSeiXIkBoN5sCT5raV5UvuJCvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLXSG4ipP2HdvuCoKQVxHlDzjZHfCfHMPdQu0rrhgomlu+t/P8VBfzjw1mwd?=
 =?us-ascii?Q?Yfrqi2CGGSlB7xeH5HPXO5CM45a72SKJdagSIfXj/5Ljj2G2HRwl2gotByBW?=
 =?us-ascii?Q?f47DsqfB7Dqz1YfGmMHiHTtiD8UPs77L+W1jdKIQE99IDaPjrJjMSDmbT+s2?=
 =?us-ascii?Q?B7IHJbcMG3XlTRPfFymQxvK70Lco/jDcTcDJ/xuPEHRIbrFCxTzaattjAIqt?=
 =?us-ascii?Q?PIcGGrRvl9Ex51T+4J3pl8IJ/TbxWj35dbGmwMDtJrua8g3WoKAdYRiYqJJ1?=
 =?us-ascii?Q?O+dosKRbi3qtEuxmCNXComTMBDvAwQe81lmTI0GTQ1ivjDTPmPAu9Ufc15fv?=
 =?us-ascii?Q?vndiglLhs3BY50SmIpCUDyQ3rjci6/9KfHtmu/OGMPkITAhmrFa4cDfTh3jl?=
 =?us-ascii?Q?7j/pcVFmG+a24Fms5YUd2EvpRtZsyeSKSmxPx4/uDxhZe/EuGaFNrfcKMAJm?=
 =?us-ascii?Q?KHjG2z5rTh/qNyiYl62xLW/a4euQtWFLgzcRfCb0+DhOQXkT8pErNl/LU21u?=
 =?us-ascii?Q?T9fc7CZbKqH+9Vy1iBDnsI224bHJnv5+24xQ+k15CAaWwLV09aKODGcBVq6C?=
 =?us-ascii?Q?rf5hL3kAaDs1KmLAs1+bP7vIIv1lfGlf2AKnm4yu5UbXOp1KQ6SXNG7wdswo?=
 =?us-ascii?Q?1iH7iw7yw35QJujXTQqWIYdpBy54ESoH73roZypsIQHE3Mpr7Bipel2BNKmj?=
 =?us-ascii?Q?GCAJ0GXV/plXeZqWS/2kAbrayH18CUQIA6+ks1jIibzzhZ49anGpLLDZsSQV?=
 =?us-ascii?Q?DoPh3laG4xmHLdyMhCT4IGau4NpWZ6URFbvh4Lr93/Df0gTIkVpjsETfPV0O?=
 =?us-ascii?Q?FEoguRZFdedZSVd5+x2nsDfnH6TP3wTm8040iGIAGi0ih560O39um1xU38in?=
 =?us-ascii?Q?UCARcSOlP8Ahr3YOtGcXhaMs6gqhufpsLRTWwcpDxeTy/qbWK3EfkhHfv9el?=
 =?us-ascii?Q?J1DlPnJtM07/rUghBha7H1J6SeC5z5k1P8Uu/VZaCCdU4DS4nSb6LmGXcnCK?=
 =?us-ascii?Q?sp4M42BO18iXHMysKCG9E2vRbLcvCCW2MrtNHa1WnuIf+rc59ozjlHSF2bAC?=
 =?us-ascii?Q?OuHFx0tuXC6Uof9xyRQLAmChttpflyzOxbtkcwXiioYDQfQV7L5bOLWreOaT?=
 =?us-ascii?Q?QUTIWDEIiS0znMzccSM7luKouaxiNgVd5FcWWglGbAw0ofxZw0OpBFixyvkz?=
 =?us-ascii?Q?QtMlFaL424pzgyNJEUV9RZdjp6jEJYooq6RGOuHZQ819m+B1Sbx33w5V4FFu?=
 =?us-ascii?Q?Yr8wDbqH8EzUEyUr7QD8ymE7i0agB9+ao7oGS9CXQr+J7IvP4GIdR99/vxWV?=
 =?us-ascii?Q?6xT0ASDTLh3636MgRz+uD+pdPe3qq7wLotux0Lrl1E7Tzg03XLBQ9SR1QAVO?=
 =?us-ascii?Q?Q1ivpAZAC/dl0g1TdG+ymqade76Es++OBQEBRCWQ+CLiWScNVLk/CUAFl21C?=
 =?us-ascii?Q?B/8PBe3+BSGkx5RLbSA769uBIfI3iNBP0+q4L8PQ4Ga+Fn1mNsIPLHCKZmlZ?=
 =?us-ascii?Q?BEhGiz+OD3woyLjghVYq2CotLTHFFFNpnv+mG8AtkXQFDLlMhitIbo+5I1RY?=
 =?us-ascii?Q?3yQHB/kV9bPXpYg5DS3qTtrlwzKwh1WOTV0YxXWjnqe4+9xo+NuuIsBaI0ul?=
 =?us-ascii?Q?AABqcXBb2wLOEnGLVecbfxsCUOAAjl1YmoW81SyDY/GdpnHth5eEFWHnmB1f?=
 =?us-ascii?Q?2TxmwHxrMl+AEIx5/oUzx54QCvVMqVlkKh8lzkH3Byg5/3TyyB92MWXNGvu8?=
 =?us-ascii?Q?ZVtE6hXkgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bhPbyTH9n4FR0xMpzcDh4MLIzgoJkGE0iGX6I25ZCfLFkoUEmoiU8j+NbykNaQmTdBfDqfNWoO1iIyCKJG4fFo7H6hKI+F/tb3OhcTYKjIoAoEip0QADC09lwc6FlfsgJJAZ05PAV3XlioGjdzxATGXv3UfxpQxGNJ9j6ZwYI5iY0qsnMT3FCJZprGXshA4iSJHQap9wQaF2+KWEwwbI46lmzNptlRwfQFVpHXfWtCjCbZWL9+7oo0jgEvtWaLtTmq8m4vwDyFLhBOnHzUFtAroAZObv0/T5DL0g4dFAAivdGuguuQDe//iayxcDN07R9tZLtWR21Qp2CykDZeV9JQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3046117f-477a-4759-a655-08df0d712f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 06:19:48.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJCjBs790cs/FC9vFiJVPCM8RLKRk4u3MM3Yai99zgLDqNJVdAdz5rcIRHI6yfXn8WIXMwE19Sj+TG5h/7NIFTac+RJ/L/2+f/+XDNLMctM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
aciej Fijalkowski
> Sent: Wednesday, July 1, 2026 5:45 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>;=
 kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;=
 Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Sashiko AI Review >  <=
sashiko-bot@kernel.org>
> Subject: [Intel-wired-lan] [PATCH v5 net 6/7] i40e: do not expose netdev =
too early
>
> i40e_vsi_setup() registers the netdev before rings and q_vectors are full=
y
> allocated and mapped. Once register_netdev() returns, userspace can reach
> netdev callbacks such as ndo_open(), so the VSI backing state must alread=
y
> be ready.
>
> Move register_netdev() to the end of the setup path, after ring/q_vector
> allocation, ring mapping and RSS configuration. Keep freeing an allocated
> but not registered netdev on the error path.
>
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 29 ++++++++++++---------
>  1 file changed, 17 insertions(+), 12 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
