Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7E39989B;
	Thu, 23 Jul 2026 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798475; cv=fail; b=sEFMn/RMj4ayWV5Apy52lPnus/6V3RM6NFyHT2Vv9HsOh5fmVY70iJ1DExQjUO1wZj9XA8jVU1xOtfQs9X2qWdXozMMvVUctsDI0ffxUY/YkecZ6Y6OonbIxcRtXOQksRzDl22PABd+abmJuTQQPEP2utBdqeU9W8boTKnti8XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798475; c=relaxed/simple;
	bh=UwhZOHv1TMXwZpSc3XtvYXL+OIn/rh6fw8S8y3zB4No=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4pboCzD+4Kb9uKKd2yWXEHmC4YD9YU/PNt5X9qyspCHHvvczxxgyR2qxPzn+C4KHaCL1ZwgyWH3xZvC+YHeVW5P5T4hqlb5tmY3g1hfk3Qf0FVF7srH12UhOMOrg6YaN5+eGFckksla2fnDEQjxtDKis1ScjrNPNWEHLKNWSPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHFoUSaS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHFoUSaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798472; x=1816334472;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UwhZOHv1TMXwZpSc3XtvYXL+OIn/rh6fw8S8y3zB4No=;
  b=VHFoUSaS+L6dwUZvpVM2ySbsEaoDVN5lJicpkMPSsdzUQGC4G8Bfsbdz
   V0D21dh1lLBhrFuXaB6vCwpMJ++BYDuerzRneOarGHiGO5ChFCxwfAhJ2
   YQFNDzuU7jIMOKVoYuhezBPeNn2ePoGQpFUpyjZkDSxp7Nb+Jcm1eb2Px
   CBTXpzDw+U+GRfVxNmL9vA7mFcmUyBOZV67682huvOnYs1rS0zNbHIkYY
   5ksYGQAMJ+o+TqOIHWReTSXLONMm3J7T9oGm6CUo/gkL7wsFKOoK/Stm8
   noq82uYvWDz+oS0ocWJmp5TmUNpALVfv3WEy62+ETrHsKslpKa+4h8Wex
   Q==;
X-CSE-ConnectionGUID: pWYoisb0QyWaE8CZMiGWOw==
X-CSE-MsgGUID: guyqn4kwTKq1vCpXpQ11lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84575791"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="84575791"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:21:10 -0700
X-CSE-ConnectionGUID: GR8pG/+iSA6XBboxqb3MNg==
X-CSE-MsgGUID: Kwru3xN7TEKu0Pm6HZos+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="256558676"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:21:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:21:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:21:09 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmIhDppwvrDAtSQStQTOCtEPDV6pnDYWs6G9qeFRLcwR2qSiUWgK+xhSptFsHsp/8yT7ihkd8+v3lG4ue9paFF2tQ9NUBq9c0OtDP7HdKRnfJd8fKNzKoV/gd8vEmVO+U5eEPRUzC105+Yv63JWrCnQdMDJnAZGyIXx40ux633uQ7DwBucM4FrrZMBgOlHxzm08mNY64MRtpnSP3LffsNgBDiHB5t3nB1MFq5U9XY5qOkig7RBxTunOUDdt7mPo2bMtfbkNpnM16eb7nIKYk0jlKxJsWp4dR9dVILt9l0+Sz+QyKAghiXyPN4plyubMEKtGIko/unl0sVJRN05QuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwgtSXaAt7PpVPPEU73ElKT1WjSG5DaIyLNnqWiqK2k=;
 b=GNup79k/4c8wpaZoTgOAEn/OVKapDY/JQ+uR/jCHtEFr46VhF4S/I/a0Dd870WrwEybm+mNyQ6oayTmthbZjTFrhsLqBl32rrNMSKRPT1LbVBj/YOCnsq8BsiODYI9OWPaqMz7tILxEH+4chilSh5oNjkXTT21G9OywfLdU7LwUaPDJivcWPEzB1QNP+J5mz82xh0Mpq7fq/oailD5ZKFQDGyZwV5b3MYtqRBbfDrJEqrM4zg34MJXkkGTOqq/ea22++ivy8VpfFEm+/DznTfDPQgWdvK/86uqOH7xTMh13BXMackm+e2DBQjOCuigOKvujSa6TN3QTd7OEEOF/uzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:21:07 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:21:07 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
 fallback message
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
 fallback message
Thread-Index: AQHdFclwAwFU7GpxXEqgiBWWeRmU5bZ63Y/Q
Date: Thu, 23 Jul 2026 09:21:07 +0000
Message-ID: <IA3PR11MB8986E19198FCD1756A9B90D5E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260717084453.9521-1-tbogendoerfer@suse.de>
In-Reply-To: <20260717084453.9521-1-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: 3e13d22d-0d56-41ed-0094-08dee89bba31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: Gqdy2JP99fODQFnCiRYla5Oi8q/JKlqtYNqWI+fZNfcccT9pqv9Tz9s55GpdTY230oh+jem43wRRNNQfhzUoA3618vTp7MeeRgzpFeCWBO2baj94elXTzNsS2zt55k5Svj1AMieqaUHynWdUWHRuViGPvoz6pZdRDu93bnflAs9NKqNSZz6/n/t+atg5BTJpv8Yt1o6YiAtUwmzXb++iW8DvNQxZ+84PGtE4ZQqMNc8Xs7AH3QazsxY7oQrtcDh6177N8bLkAJqyd9ceD1RJkYAirfbl9U42XlCm5VRpSgh7U2oUcngl49Quf38+j0Bsl/qfjDhp6uTvA3ed47ZaFte16GY1b/xT5VSrGEHNcbTdOKAhZVUxdHoqyVIFujniHfbCriLF0pcDAJ5xjli46AnAhRnryKmyAlaYL2rKAV1LFUC4D4tuht3EOM/YJarc63cFS7AaCjKHZQ6UJzxKZMCQjlig6+MWAA+VockDr72zgQOxbn7FzefpynluLMAfUN3Dab5mXL02K8tLTbCJ2AFPDZ/cPmPnBhrHgxiOoMArW1Rs8prTcdrGkJY66rnq1Flp4M2NBE+Jn3ZUWp2iYfjB+O7vx9LIvzK889SVyYlQsV/EaIODYpdP56xpxtpNhUF49l7eOIKqwSq/IHQAVGjBjkAIw3qdAbQJ97nyWYmndbPl8Xzxm5+DI2cpMeV4Z6UPsvmmja+9d5m+QcGZwIYS9xk3Rp/KwuaVBmaNcxx7DhhBRoybvVxaoFDynh0C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BOhJuR0xSjAIy3UWrBELneGBb+bbBxqBgEepHn0YIqW6gN22FuLSYPjlzOok?=
 =?us-ascii?Q?TBNIl7rSVXEZh6jhrduR3nbwFhdQ5s1jzqNzcQ+CtOg/oQG0McNVAA2B74ot?=
 =?us-ascii?Q?j5IRrmjKbcGZ5qSSj+Uw+f8abbA0WykYIoSImM3PQfF4P0XwZ2FJ2ZBOTlmD?=
 =?us-ascii?Q?9r7I3RzFwwA+pS1z98gPSLtk9CXgziPB3qUg5JMolbjivf8POp1kGC5mZLN2?=
 =?us-ascii?Q?WO49xl26j35D8wYfvhGEbNhgqgX4cqBV5sI4GcXVx86LqkJzZzA6/pZc755p?=
 =?us-ascii?Q?wiZev8Y10Vx2YJ0JZuz93nvRQabIEd8pg0D3BEbIrSmKyEndlt52nlpzBviD?=
 =?us-ascii?Q?yo7IuPaITmCRCg8DqAxQPlLsdbtATgUcvPidbXjT+KUXFMNVzwdF/MpIPOQ/?=
 =?us-ascii?Q?PjG2x0Tmt4LHGs+dNBJ9fnFOopSDWsLTLFm3XkzeNau86TVPRjw2tMAQPpLz?=
 =?us-ascii?Q?8tRnNp7FV9mo+Nz63FbEHZrBoFB/rIevIFLB4bOGAEUA4tXIY/Aaa/pZ9Wji?=
 =?us-ascii?Q?E0SPpKT6TpLOrNJfQod2zqbA3APY5jhR8HzYiU0SgMeo4xXNuN/EKnC2/QMO?=
 =?us-ascii?Q?FTupY+KD4hjY/BwGWz6mObGMm7YgU4xsnsbJMAKWHATyXLl86coR+gvtdJwe?=
 =?us-ascii?Q?WYgEvq/Qa2Msp9hPNjJUlYgvUdDhdFC7ScjsMjtwDCB8E5U4NrVhEzDLCCwi?=
 =?us-ascii?Q?7TUrnBwTD1956YGGzsMSs0gMoULbhbUMlua1jzVpK9a0Vnq0T9mHngQv01QB?=
 =?us-ascii?Q?QcOXBwqQb1lkwecV4bj2cWaLy4RPJj+zj4XvVbmeM8WSSaR/mPNtARpF05Xk?=
 =?us-ascii?Q?Rek3gTT3xj8iVge/pbKUTpXILqtYNe4NzQ378UDblOZTCZparx+x5xKUz1su?=
 =?us-ascii?Q?zYFs1xT4HKB3Fy74zpAg42b1Iub3qWl2D0tPK2/Y2ImgA/WCO/XtvTFdx07F?=
 =?us-ascii?Q?n85UivwLhQaXvj7oeXQJixMVPV0yHvZMNLpRvDY9yjEcV/5b51iGgKc6VmxS?=
 =?us-ascii?Q?2tY1/uWJP85aZNkgIMXKGkke0o3qfF9IMQfnvjt4QzjmGLnloLiAUn1Z8YfC?=
 =?us-ascii?Q?UFpayYi8qTb3pcyhV75gk3yV5t3yun0m6HSaoyFKe4f0UxSWT9eiihPiqM+c?=
 =?us-ascii?Q?ubYzEEDHNhuPsb1dIlI4mda8jtNvz4hItgxTcIiQs0LwXNaqJ78juF+6Y+04?=
 =?us-ascii?Q?22sV53qYwCrs4kHfnTAwdxYfgUcBvDGT5qV4i1a/VYjplUXDsY1ibvDdeV15?=
 =?us-ascii?Q?MbiYBf5aZUUz+mQ0Nh0xR56UTJZgLaAGWyoOs10Og0fb2RNrNeGCEMrC6XNG?=
 =?us-ascii?Q?zXOH4R3uv9KNZpHV2AUJPMVaBXe9r8jergMBFNBYNh3Fyf5PXJJxtPJqtxIz?=
 =?us-ascii?Q?3rQrm6H+Zbexv8sR1pV6tNq1rYI0sQhxZq+GZ7RsldmHgOzoDq4ZgBr4zuNZ?=
 =?us-ascii?Q?mUxQvBuA9JgAG8Ge6b8NKBKekZAec0Cuq4WoTMCx1z7kcfU97+Io0MxG5Pl1?=
 =?us-ascii?Q?nfkSTVZ5IhPnUUUK01+5gXxTB2/0bwZ88tbtKcUipmz6nrwU/ZbBwsfloJ5H?=
 =?us-ascii?Q?DqL51fEmwpOks85RxPs1i1PL8YoAJahvOQhenHop6UID/ZkeJigCJ6x+CPXx?=
 =?us-ascii?Q?mT6YziFm5qtjlbqV7632qrMFUEHkUSQnjKb8o2uV8cmRf8tgr1JaRAf6EjEy?=
 =?us-ascii?Q?aN6DWhh2JQFHt2ol447RPyReHFbEEMLGdgnTw5xpP12oP0eLoIdPyDh7xy74?=
 =?us-ascii?Q?BBsxHFqouk1HZJcIMMl0vr8WWShRwKo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pHzuSpncpOGRdpKvBtiH1TyUOkJeRbTwfOBwiVXTCN1taJ/IgkHQNAN9t21PYGlVgGqNJScYd6XPs6lO4e7gaO6+sCLOS9dSsEjLN+XqzZZ8fwyvkFnAobOo10rA4PL5nJwfHbTH3dJG5SI4vR0qnzlt7FIjwA2JOBdmcYthaLuhbaVvWAxyTh3jXjOtOWe6rbji+Dtngrfnq2UD8EmTzFJ0ysQke0rCaImSgAhw5QPVkp6xe1lpGhCMdM+cekOSfcCiD/5Lk6YLlE/15MW29bwVwVNrmuAQ3KLimFNF25d1N/VGcJzenCG6P1f095f4y3QDTpj/+qrGruXlAGRjHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e13d22d-0d56-41ed-0094-08dee89bba31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:21:07.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flzS9FqErW93Ie9NQXpxP4bXr0Z2MkJXugSPXzBIomfSs2X8i+nWKRnaKwcSUds+YCQoysCjN/90tbdtr4fdUrf6xp+YYhovoBDehfQU6K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Thomas Bogendoerfer
> Sent: Friday, July 17, 2026 10:45 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: rephrase LLDP filter
> fallback message
>=20
> Seeing an error message in a logfile triggers scripts/admins thinking
> of problems. The LLDP fallback message itself is not an error, it just
> indicates it's using a different filter mechanism. So rephrase to a
> less "scary" message.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdc4fda89e9..59341b5a0c05 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2097,7 +2097,7 @@ void ice_vsi_cfg_sw_lldp(struct ice_vsi *vsi,
> bool tx, bool create)
>  				goto report;
>=20
>  			dev_info(dev,
> -				 "Failed to add generic LLDP Rx filter on
> VSI %i error: %d, falling back to specialized AQ control\n",
> +				 "Using generic LLDP Rx filter on VSI %i is
> not possible (%d),
> +falling back to specialized AQ control\n",
>  				 vsi->vsi_num, status);
>  		}
>=20
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
