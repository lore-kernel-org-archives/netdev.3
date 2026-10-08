Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B2459AE0
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494650; cv=fail; b=jHkW3LnlDn2ipT4iwi4Zn5BjINL2+u2HgxdMIJx/vNw6SObiKMwa+wsNO8aasg3P8h3GsdK4oi8MUWMgb2o8p4SqQOHjetNRUSNH+96F/syPhM3JLXupouTZDI1/XsbVDa6r3IaVFQ1iEH+vWrQrPv2y0mW+e04mee2CJArGbLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494650; c=relaxed/simple;
	bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=efBJsLRD+hhneD8MaQmPFLkuZqfos7RnBcMvmTmtU0BAWEvlC5svycgfZUPNKcBWemqOAb4sS4cyRDlJfGlnQ5WnQfVqanlvBQs2AgECUaCe6uY0LslBqyjYzBA9VJwaQYDNoKnKHZVYMbR2o5aSKoIBCfvtYnJopJ7et1krgQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ru+O3wnG; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ru+O3wnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791494647; x=1823030647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
  b=Ru+O3wnGsE7p7Y3AePARW4ZcNIb5Urvcy6wHh4UJQ/NmSE9AhdlOSMU0
   KNyUFpzHJewV6Kjws2z+0+w53dWbkRYLA2RkPab4uSMiTvE0VH4z5V1xV
   dfq9BMOb1Jg3dRzxnYPuzxpju89wpdp2hqMvPy5vAtDG7VCzRPBenelZM
   v2lyjCLVaWr0N2bOgRzp7BujmGelI7KS7luAGTep0nqkRNa+/OP49DQC+
   ptt56Gzg9QfnIkcJ9+mzRr2Pq0Y1TsFuWLsgjhrvV03BhxfchwN0+Xzw8
   b8HDFLAww5P3+FcH8n/7yeVDm9PEdZhyZua787kKHyG3sodTbMef17EYl
   w==;
X-CSE-ConnectionGUID: mi9MvNWsR1O3ZepmA+PONw==
X-CSE-MsgGUID: 3mO/FBMUT/GgOdxz0VVVyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="286569"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="286569"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:24:06 -0700
X-CSE-ConnectionGUID: M4kOd/nORcSdKJb+jOGA6w==
X-CSE-MsgGUID: P/wGSFH5SHyRC7G4qie3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="511935"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:24:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:24:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:24:01 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.25)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs7hxAuYA87Jh8yRirME0NBKmjrgl822DV1Li9CNjZtckb2CamrQQTxGk2BsoSKfpi0ZVPewhz4viRWW8ZsgdLeRXMl3vflBFiLbnKUWcCYv6WKi6HlqXQYB2Ux4xqA2/C+qgebdYQrFqaoeunYfvUBPy3e+RHqlQt27BlIxpqiTS/zvZZcVsB789TG/nDJicMEFTMzdJZIaCYMsxP+Y9J5mcsNTxG0F2imUbzFPYlLVypngp8AaHWhG+faqIoCSTxEXqTgsYogg4cRtj8w4FpwESY/nZNR4IFXEkLOjP6WoteBlT5nUDDwmJIHnpcLCXtIgQnSB0cK5mGv+HSLldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hco2uPPYK/8FsPBuRM/RcPiWMGQURJFBghh2F95iTfw=;
 b=tOBeOS0O9/8B0azBQxTpb6J2hQBIf+TWVwYLPcf9IzqxHiAk8vtxbgybAjvuvFCIAshF8Xyhjy99ZUwpLlYnQVokOObx4OM4YSzK03pKa7bEqa6kiylORl+WoX8+6iu0BPw0YpwL2dWfGoSUlqsX1taAET41FAX92GxApHjy/AaM0rhQxEXEyC5aseEiFsa3LAfemjOq9TcgNX5njbiHByxHYZnnZDuml1Tc1ikgI+wf3M8b6IMAyVVKl+XywkaWvGM5728g4ay4CB6yQ+Ru8QYMt8vsQiAVQGTiOjLnqIlqwZXm/nqAkIQs8vwmVcUV6w9+0qMKwEiGI6iO3V6ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Thu, 8 Oct 2026 21:23:58 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:23:57 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 01/10] idpf: store HW vectors information
Thread-Topic: [PATCH iwl-next v2 01/10] idpf: store HW vectors information
Thread-Index: AQHdQfHZSqocsuXbt0KzravpLk5fh7b0UoIA
Date: Thu, 8 Oct 2026 21:23:57 +0000
Message-ID: <DS0PR11MB64228770313658AAB57D3B749B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-2-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-2-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|PH0PR11MB4982:EE_
x-ms-office365-filtering-correlation-id: 249fa496-bd3e-45ac-a62a-08df25827694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|38070700021|4143699003|6133799003|56012099006|10067099003|11063799006;
x-microsoft-antispam-message-info: EZazb5smhd40Pzsa8cffU1WrmVDFcR22gY0n4ZGlKjN9XBw2G7csF+JMVTwCj6GMgOQQDU7ppoxEcUaQPNbXl2hMz0x5A9glR3CkXQKQDZc4Ng9qyFvlGJzvDQ1W52vidXuoBTzTgyR6PhepNGmBd6JbXtB3TCy8ZZk5alJlkHLeaxqWK85UdeSHRUsqF2R7IAOEP+7MXLvOQZGOZFbuV7vlnjYGZhvNk+XQwPhsY0+siZrNvu5I9vP7VCXykrh6LV3P2lgvjI5z4tQsbQa90xKbQRBiWEsyXb+gBBk6rDo9D9Iuwjia1dg8o/ra0OBhBywHpkkPn6AEG/9elrotATA+evtmTyizZxV0BYKOHt2hd3x8CW8iWzWoevqh6GEygfJ63A+PQy2a1hG1scm0RvKsHxnMaeGokNisUIhJH23Ch1Nvb9yYkr9v7NA2qtv1FM9qyZEHrVKKYeqwi2szEvxpYgW7HcPt8QEk8t9ugibs6zhtB+N5sEhwlLrkvFOS+b/xYJZdRJO6I3CyRNCawwDpuT3PrNFfUruCfrf3hYjt96sCqs5SSrc8CkfYlNG0A6HZPTZRuOn0+TMF/KJDzK1E2rtQPH9a/1jWV+MbwCJZB+PJtf6Qdo0yAVFLeDeyqRV0twyy/5IjAY17o6McpOmC8sapf8iKX8NIBIGhMiEgS4HGxUjw7OueswFhvSyXS4q36wGxsz3WIXGVl+Wv9q8iAhvuRHx+9Ts07vCwtaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6422.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(6133799003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a94Ce+CUR1ff+3VsyV8K24Vo/oyBdE5Dun0uzxFsLc9T2Uqza6GU4Fr5ac4J?=
 =?us-ascii?Q?PJ+nQsqPYsfjB3JTwmgww3civwk0IjDTEipMtViDQlwS28YdPZHGAfudp3v4?=
 =?us-ascii?Q?/ST4gGcbMQ0YMhRJoEaDf3W6czn/CiJ77DQ5garhyC/NUp2ECq7JauC531mb?=
 =?us-ascii?Q?5FKe0DE0RDxjjxiwAV1GShyJzbRS2A4Ecq9ixBsXFksltmj2pPa7bH/uD2dE?=
 =?us-ascii?Q?Zemcj6bjcrt9l+g/+qqz3dx85VptRTMFPMlw+q42LxjOdWP2CSrQbbaOvumt?=
 =?us-ascii?Q?iSkn8KKUeXgAsDRI743loQ9tWh8s2+HPgjypfPz2e5XIj03b9VnkoZi2OmwR?=
 =?us-ascii?Q?whu7X2cwUlptSKk7kFhm7UTJr0o5XkiXRVSXIiBlAfa8Fo7INU/rLYPymkCo?=
 =?us-ascii?Q?JAFWryx4z/Mz40cNF0PujKr5MZtI8PadZ8yVtl1Of4aBAeCxaNC1yjxK3y88?=
 =?us-ascii?Q?gB5Ur2tIXd8zEfWpVYDqZ9SU22xGkem0lKZ0d/+IA+Zl0jV1VV/XevF4szIF?=
 =?us-ascii?Q?4YPsLur41/6gLMdZurl23htkiiY7qqeEKAR697C4Jzm+CJL3YV3f6BXES7SQ?=
 =?us-ascii?Q?5JwwMNeals7PVnq6ZgI9wO5s6hP/8lB/xPPLaL6NDWZzPRmKQZ9BqpeidgqY?=
 =?us-ascii?Q?mse05wASSA3QvLI/I2mxFj37GxG8u2k56u27oaiUtfxefrcW4WZoRd5xE9jc?=
 =?us-ascii?Q?0ztZa8Y+91suJNB3HQgzP3Ae4ipBzseD3lzuW3rrwwnghTPnqIyd6hGKmj3s?=
 =?us-ascii?Q?K2KmuU/b9qlDPTJj8nM1qNjKWwyYq1ikxdyTG/qN/jPY464LBTr3fCv5dPA2?=
 =?us-ascii?Q?53nn3cHpPiFTUPzawwvdeX5lQ5dnghThpl1ZhOWsqXIcmvW2iTKZffrt7jsP?=
 =?us-ascii?Q?ylxzeqScXVgdEjmBSgBrK2/yagFjRm2LcGH0DOuVKzXmtVSDu5hkoMMUXEhS?=
 =?us-ascii?Q?zF7aaqHK/qTyMzI1sTwuE+DYA5VblfvjImwisjKP8T5J06YjTJJ1xkqZie8i?=
 =?us-ascii?Q?uqkcrBR9fWrsoZJup9MonQQeQ11CCrKFk0ayV4MqLeim++8evw5K3E8OLpe/?=
 =?us-ascii?Q?zKHCCqY8vwcO/YS2IQ3CLJogdEzhn27tXWvNKOg7JNpPgaM7hffAyTaj7InF?=
 =?us-ascii?Q?qxn/uKgSb0yjDKs2UYnBaCbBuGZZ0NgrBr8SbQDM1nlTB2RzkoKCftXVY1wn?=
 =?us-ascii?Q?OhU+bNcYg90kstqT1lzRGR7t1CzOGzhWPcM4j08Wf2rGRCNEhHaLuDLUah0c?=
 =?us-ascii?Q?Ke0kJaHNO5KXYJGKkSy8zgOhF/12gIHVTfP5U3ct9eSHHGmAC+YKbJvwWXcs?=
 =?us-ascii?Q?/HgJ0xK2lmkJPQT4mj3rS4H4m82Qg5DZu86CMXe4Hsi4qnElSH2fPPKs8fvn?=
 =?us-ascii?Q?ZYFMytyUQGfYEloVVUqeY5rwjPko0lCBQX4o3Pwp+q/+30Iebz3bxEC6Jq/M?=
 =?us-ascii?Q?CRTiS9lk6H/zLyzWcYiMp1XSEn+1zDlfnIDcuxbmJ/NFNBxfYWnHAFeaSkmH?=
 =?us-ascii?Q?GPgBSlGz+guEiY+xCJYXtAi7gueCIr/fP7BOtNLUDdxC69WQyS/IRHtXjdiO?=
 =?us-ascii?Q?tg+S3w290NjuW/aH4n5g28nc5YtxKyPVdapjIvvM+g8QZLKUO3ymMG3A6xri?=
 =?us-ascii?Q?OgZMYEGMvp7hLuqB2Co/ieYQaX3LkiDGrdDVBFKbP42AmbOdjj9k2LBf5z69?=
 =?us-ascii?Q?rDcsnuJR6K7GxKctA4S3+xgW1MTTITxGveRSWBTEbvteZBvFtKzV0nK8HPTA?=
 =?us-ascii?Q?RJDxbJu7mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sEaGQsCdtVBMFDq6oEC8270sxg2eMkoIz5krI/xnajmpMW71a/sHNoOx4EyOKvX+/Bep3ZvlP5vC4csWWbQDpkVKfCLY2sAs3hbqF6xdWZmYZbR5RyL1P49VonuEE+/Q1++iS2+OVgryJc5BMFuxarPnnnWCRhk8NANu2iJTk+sCkyHCr9eUg0PKNrePXNsWgTKYKekT0OSlHFvSzNJI0fGv2Z5Xdb8gT2llDlduLTaB9i66RuE9NOWdcSYD3uB99ta1fzYUjIUn6MsSjELETIySb8sUfTQCMDDGMFoydb0OK3MFKgMPZpWEqUt67Gs9zmSsuMoWEVJIc9IJZpJUFg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249fa496-bd3e-45ac-a62a-08df25827694
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:23:57.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENLKK40PkGdCMHjRAvu6rbOzMouJJyBHyfDUUcoBnDQ/EDW7FNs2fB+aLm8FyPJ+HCk4a0VEPx02Afi5h4oD3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 01/10] idpf: store HW vectors information
>=20
> Currently hardware vectors information (registers address and HW indexes)=
 is
> stored in virtchnl command. When this information is needed they are pars=
ed
> and returned. There is a need for alloc/free array for this information e=
ach time
> it is called.
>=20
> Information about indexes and registers are parsed in two similar functio=
ns.
> Create one parse function for both and store it in irq_info structure to =
use
> whenever it is needed.
>=20
> Stored virtchnl command still has to exist, because it is used when sendi=
ng
> dealloc message.
>=20
> Make intr_reg_init() functions (for VF and PF) return void to simplify co=
de.
> With stored irq information there is no need to alloc an array for it, so=
 these
> functions can't fail.
>=20
> Previously mailbox vector wasn't filled in idpf_intr_reg_init() function.=
 Store
> the mailbox information in irq_info.vectors to have everything in one pla=
ce.
> Because of that tweak index in few places by adding IDPF_MBX_Q_VEC (when
> allocatig or iterrating) or not substracting IDPF_MBX_Q_VEC from
> q_vector_idxs, because it is no needed now.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---

Tested-by: Samuel Salin <Samuel.salin@intel.com>
