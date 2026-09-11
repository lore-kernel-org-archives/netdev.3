Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455464BEE29
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164673; cv=fail; b=Zon0/dM40rl/4iGMjffJ/1ck9b++/DdFXwdiXHF7bWoAnvSms7FC//9+77XSIamegL1lpkIIDKIBCQYS8b+fYxPBXdMSjDTBWNXTXLdUawSSOELMB3XORWtzKFxURZRXtU35x9apDdfBR/snOZu/YIO5S6glJWyySZ7Dgd0JDUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164673; c=relaxed/simple;
	bh=R5DfsaLyCgisiPUCpjhXIfBYV84aqI45x32ovWvREyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKuB9TLAjzidxV6Pe9pGO2K7RsSFh8uL7LPeAmeiLeTjoJv1ysMK4WKJUMXSWPtodGiUXkzUVXVL8Z9Ka0LMHVPS7WLqw8w/8ekuMOqPn1jhoFyJGKwHQsK+KS1Gg86oex8SKR9FbKfSqKyDKPAuaJ+8byKoBX833PvCmTLuPv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJ4xx2yk; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJ4xx2yk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789164668; x=1820700668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R5DfsaLyCgisiPUCpjhXIfBYV84aqI45x32ovWvREyc=;
  b=VJ4xx2ykySmDU9KCNEJW9KL6frC8ZGjpEMffIODXGC44BPnifIdt795Q
   rp3S7sAEkLlC18xAXU6KRi8HyEa5POisYCbiziAemS1hroFVdG4J3iNKt
   e4I8tAYl7nNU5+NPIVjKKfeXESPRaayt7q3lnCML5JfF/rggKMxHCdGsL
   9xrrs8bmqp4cUSfJ105TwuaX63jIDGWoNt+EnoXdnqval4p3D9PG5hGpV
   C2Xq1L1PDVw02aCYeVMBNCoqx51gi1A4PJBHYbYya6/JCfkViwWw5DhqE
   Ud3BghBfArkyLntbA2DMGKx55qtwUGGB7Kc7VieYWKJNy3xR/KXvuLB7G
   w==;
X-CSE-ConnectionGUID: wjfVKu5ISJyDZ2H2vTLQHA==
X-CSE-MsgGUID: sLYAqtdTSEqW0DSBCrXZPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="142333"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="142333"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:07 -0700
X-CSE-ConnectionGUID: EUmwKGGHRK6xg8Xa8IkbKQ==
X-CSE-MsgGUID: pibnvV3zTvObQNT2hAvlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272546807"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 15:11:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 15:11:07 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 15:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLAW6NpBXetyC0dkXMmPTBoxC/c3ibY+tWg6S6r6Ku8OU0IpnLJtPBx+COz8rlj6qdVikjUNhrfiJTCV8N4R9kkzJtPxVlCW//nHVRxl/EIvi0Ust4q0f9yXbq1wha8EbwRmiYhP+Zc9uBruB0xiNQv1gRs7dkb5ADtOlSbhH9pdUB+ageyiGSzKl68XSo6QMNDQyGh0XZHFqKtv1eJ08Ba5HvU8PS7wYAtVI5MoxO/lUaQaFJCGxeo/YXAWs65vB+fxDKrqZIMmhjC5hzanTyE5oJectaAQRDU70aXhNr4Y9WzGwadMajNjyD7QtHaNHtMG2jaeCjYcyN12pUUtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vkl0mfmLeIgYqiRDRTPSVcTZOZTAsMXPYxKQF0RsgY=;
 b=kgK4IdhBqWIx7PsZPLsx3iSHcjM8RsxKpzQlbbGcpi6WeogSjCeFucN2q6/Q0RivD04IsDcP77ZSuWOFYKSkKzxq0/6VyVP6Fly/Fyr3p2jrcIz8Kykz9/mKJzTmMcKP2h2vagJB8JdFNeuKaUZ1K5H7rb1rG62zrwMJHMujG0YgNvnZRfpPW8S8NOO+kkb/Z+mQaT7mlN9Uaz4xMXEuiuVheJHD4JK1ysH06C3cm51Y7ErlD1P0J43a7lm7F6nNIt3GSe+cRjJMiTWT7cgQMFzScIkGGXD8AMKHgffKobO/BSHTUo23ac2gmIJiAtdCHz/Gl/1IfEB7qKvjNarO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:10:57 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 22:10:57 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 2/6] ice: dpll: Rework multiplexed pin
 notifications
Thread-Topic: [PATCH iwl-next v5 2/6] ice: dpll: Rework multiplexed pin
 notifications
Thread-Index: AQHdOVgcUZRij+YXREGXe77sxantsbbJ/78Q
Date: Fri, 11 Sep 2026 22:10:56 +0000
Message-ID: <PH0PR11MB7522487C131F283BE2F2B4BEA0BE2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
 <20260831145005.191040-3-sergey.temerkhanov@intel.com>
In-Reply-To: <20260831145005.191040-3-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CY8PR11MB7800:EE_
x-ms-office365-filtering-correlation-id: 3b7b8121-04a2-46d5-9ec4-08df10518dfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|11063799006|22082099003|56012099006|18002099003;
x-microsoft-antispam-message-info: OqZ7G4zANg0NsHXxj6LCwJ9ll2LkoJi9Ex3Qh5NaGWJ6tezy4KfIeJo95EsvZbpVU25YmycwnvYTaG+CS2qJ0JdGkLTBBLpIEpVpbApqJNJ/P5i7k/Cb2I0jgafcTcYHeZFTy+z4zPYCaznBImvLfou3LAyNlsVMl+6NPLlryyihDg9RvIRdVuynMlWtGn6NEeWHDbtLRQwZ9x1h61eYebilKv94NJLu2LOeS0Mbg769yF0CBDaM7B9T31aoO2dbX/D2cYbCXHzyrW/nMlerFSnIoxpXQvUiudA0PIYqme+5v21B1/0/+4D9wIBZvhyvk2yf6zRys7k48ZATYY2odw7mhe0ppBOYVW7bJaD1QtzGaHr520edU3f5QgKvZUKDWMSjZYqcKEWkx4GNF03z1I7Cywn4ZShlvo+Y92poQixT37N7O5FRea4xfWwQMY2GoZUnvIkEv9b3uqcGqu6uomnNHfx4G6UzBL+MGI+s+JBzxVugwV4mtIVHBe/7rxQIPmnRbA5MO4JiIrvbBhXpJ02RzgBPgbFfTqqqU/cLICMUTlwkJhB3LErMK/vxfH3ccoAkydNDcbenjUY+VrSrKjmmkrv7rcImrI66Fv5YnIg18CcfAy/I1AdGlPN1ofEWpmSx9xPrEDSI6Dz/65MTYonA3ot966jsC9iSQqRot1EpyvRv/EteWyeOS2yl+Ak+3+ocnFmYSstF5dKnV8xurwR30wc3VATjWpVXuWdXjmY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tLKXDJFvBZL+U03v4HaGbWp5jQlFd9VY5733jnDYKY79OkHbAyeakbk+yaaR?=
 =?us-ascii?Q?ni+WqY04DIJ414BTrwaE5IcplyQWOMwyNMNrMswGEhyt5HF6XQxO5TCFog2h?=
 =?us-ascii?Q?BI8xGIIJCPMtVpzOH37NZX/XcuWzrVz0c66gqlv3czkCE4pJovNpoUBU9sit?=
 =?us-ascii?Q?lf3Pvm+dpB9pwtbeEmQJAjeDpubm4aNCiEnWANwHnblog3d+TlKXnFKMJqvb?=
 =?us-ascii?Q?eLkxbG1yxX1J6KYgw+3Ea2RHghc2pKMEq4N6Vn/DnGppzS0s3HjGu1DsQ2Go?=
 =?us-ascii?Q?ptvvTm1RUE1PL33neMXi/zdZVksy4GZfuRif0dAiE4nh2lGGEKA3xRtC4EoZ?=
 =?us-ascii?Q?68gzp50s5JsyzhXVAh7u/IkVQLohGvMIV/c6gmWMTmAFB3yGPQSQ+da5iYr7?=
 =?us-ascii?Q?WyazcAzXUev5JRAdKWARPG/8Gc3DHKd8yhGmu4DK/WHFcljxBxy6pKdvNMTP?=
 =?us-ascii?Q?+dnm6WB4/cGJExzK813kci7TiXAm+UNbkXggpKYqwiCj9qUS1s9wfZ6U7jU+?=
 =?us-ascii?Q?oYa5Py7RStWXiZP2W7vnphvC/GsK4cNajBXhzPSexgCYOkocAIRW7WSIvrIC?=
 =?us-ascii?Q?29us4Hl3TKxpdgTTryXCnEx4G+8uFsAM0PHlXe6MpECfdzE8PDQoLTXVyHZD?=
 =?us-ascii?Q?biVvDVR2+K6wWJ+Crp5glCUjYxWR3gI5cvPKm/o0vlW5Dgpwq95d2aRR5V2R?=
 =?us-ascii?Q?8wXL0EsTuvhE6rQ+2iE6TqMQcv0HvH6rKanU8xGmGwTbx8o86BNX3HawhMJc?=
 =?us-ascii?Q?KwR/i27sr5dIxBuf4ks/f7q2pXW2uD3UA/zdmn4hvYyCuqboANbx+u5pCrbf?=
 =?us-ascii?Q?7si+fDtP89vSG983x63nQJ6kg/qnA0qCwLD3t0I9X5TLgoFxvOeqfiNmGJ/U?=
 =?us-ascii?Q?SARJshz1gvMlQ2mHrC7ONtmhhZLAxPmbKRJQGgQR9fCYJbgzn4AkfWRA24Jo?=
 =?us-ascii?Q?Ic1aIscqBgzcMDHxky4OGDLJ/HOCt2ftAz0WEr5C+NjecONM5O8A9Bnqos75?=
 =?us-ascii?Q?6xS7ySlszWjd396ELUQny71Z3GXzi7tEFj9kY5s9RlIelgWYFiZYwDrQjnC3?=
 =?us-ascii?Q?8Z7/y7y7zwzQTCOXI1VMz4FNtbYopEA1sFn8FKsbGsOZraliqyijTbu4gS6y?=
 =?us-ascii?Q?KYb6Mg9fR+d/Say7sz+ZBiimlCk6YbB1BRJH2ucZkh+LQgCi5AGi/NxXhGLF?=
 =?us-ascii?Q?1+zW2Rx5jEOTr6w7Xw4Fh1wTdo0ZTwvdp6kqSckgXH7f780RshRI0H3muNI8?=
 =?us-ascii?Q?NML6TjV38Y4rl2bFrIV35ul23F8x+PJyQ0r5bPDN7E71ajyLnmye2hW94zMs?=
 =?us-ascii?Q?tEI+mCyW7e6Jdqhb3zG9sZCXadLv6aS1na303Kmxwgk0Ih3FesXfa7mUsxgz?=
 =?us-ascii?Q?a8goYddRQO3TMXzbiEMUHE6TlTCwCDFlMHjhSJmRI1Z+/29L2EvK2Y/6Dkbg?=
 =?us-ascii?Q?PbLxh2wz5/Z7cZg4zxEI/AGL4y1vxeqyVKTnIDijXkGb153jPwUsgF1hC2AW?=
 =?us-ascii?Q?xv+6lneEeivaM6FmTwfFSAJBCmwNARiXH+xjiNQUfHMsP0JMPtOqJ3+0MPYr?=
 =?us-ascii?Q?wH/xDFYFXw2k8t94WzbEy5N749dRMtUv0chVWl0u3NjolV+tV4R0Z3bUwGi6?=
 =?us-ascii?Q?kmE8dc6DX5gtMngsAuLgsGrbxw7fWpER4btM5exsAE4TfdC1+ogZlAWQFjqH?=
 =?us-ascii?Q?BFmoGvLaxolz2JFQWpddHm5FM/+Yq4789Xq/ArmEK/P62t2JnEYaUEnLm3en?=
 =?us-ascii?Q?1bPyLGFkNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L0j2uxVkg1Z5sOiufBeUhtRQMsDUaGuUNYReRkI/1OaLosuIWPe+XHbBlQN/+ojVsl/mK6x0U74/o+3zkkv67pExd3+YQeF0D8juzN+TH7TTECBIqgByd4z/+ZGgtX8uDt9RQVktI+I7wM25W1M7U0cEZVZMwafnNc5rQHaIlHF4eI2KqZNzF8T1jttK14pZAZ/ZftbHpsL/ZLhWnm104g1EFoOET4JxAin8d3YvBpJhKfy8wnkwh+/i9SRHTEGyHU2SziyQA2eLYmz07qYeB5xVOn9AuDmnXJa4WF7vAbyL8b0e9eCuVCgNrKstm/glHyR/HE6oojd27NfF9+ladA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7b8121-04a2-46d5-9ec4-08df10518dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 22:10:57.0308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3aMNyViRy3t697J5pYOCG6q6+k8q6asykdJc3+aQS98siYevR98XhwXLZk4njzGr4Zi40UpdMdt4uCZrg/ZA9fnqnwyU8e84lEVA14XihE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>=20
> Sent: Monday, August 31, 2026 7:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [PATCH iwl-next v5 2/6] ice: dpll: Rework multiplexed pin notifi=
cations
>
> Use a pointer to the struct ice_dpll_pin to link multiplexed
> pins. This allows to simplify the selection logic.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 60 +++++++++++------------
>  drivers/net/ethernet/intel/ice/ice_dpll.h |  1 +
>  2 files changed, 31 insertions(+), 30 deletions(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
