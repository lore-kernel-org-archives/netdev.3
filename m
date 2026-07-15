Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9F38423D
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099563; cv=fail; b=ts0tghq7Hcw8cmiB6Myf0sKT7IVl+voM2W24S+gwck8L5Oa/pGgAUKjr0NszS6R9/6wF4CbYVN0MvOHED+CL7X3nBOGo6jq6ItWjHfuFjxWeMhkDNdi4LoQZK7b2tY++kKm80zr7gNpkEyAH42kWylYUn/CvGzEezf03cw7VZeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099563; c=relaxed/simple;
	bh=T9G7orszMRD4SpT2R/TGgUunOKzoStCvoGcLOHyRLlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FLVnrH1u7cJjvpqWNIzJ2fwu8eLhnhm8erJV6IjgJH+i3GjY/bSkDZLt8CI8EjD37KD5uoKdA7tCHi2uvzctmQ15gjCJ/v+Y+cY/WQjFs2Ddzj3sRFhOhP/rT3+QkDbWWjtjYwHX+zpKRb0IQGm3lmUBvwby8W1jCNxM7v9KqLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qqn7SE1B; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qqn7SE1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784099557; x=1815635557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T9G7orszMRD4SpT2R/TGgUunOKzoStCvoGcLOHyRLlc=;
  b=Qqn7SE1B09+jBzvrJuLFqGaMEdMSC0VhonkdwXOYHobx37nZ53vmKhvV
   Rn550UVPZifMND5i+TPnPSDLu0lsntwAbKpP87Fn2PKbnR83rkZSVEbw7
   LQ36MYlLlMokV0D7xff583LaDVhEO1Th4hCM2Sr+uwSQbtTaP83nupuQA
   4leWZWVtRN/Y+NlxB6d0T0bJl5H0XEiAUiNmd/4iLGbqQBKeuDg4c9KY3
   5UEve+omvSSnnMwyTkRaNhBSa9mhIl+jKme/M8tPWatpE5thU7zjq5bEv
   CB8QqGqCoE0aCCC8kd0qtbksNazlVUDic2UHl72q7/znbPXOwx+j6/v4n
   g==;
X-CSE-ConnectionGUID: n+Jxsfj1R/6g1t60viLXSA==
X-CSE-MsgGUID: s8LTkHVgSymIJCKNH1FZ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="87272396"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="87272396"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:12:33 -0700
X-CSE-ConnectionGUID: K5jQ46a5RCSoNAZttFEcBw==
X-CSE-MsgGUID: g5tq/lOSQZK3nm5qenWcUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255590159"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:12:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:12:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 00:12:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDOJyTsybvWVsNkpm/WVgjz2E1cxX8PdElWMiJKFRlHuLwvVif3Tqn2AIhgaekx7Hwa/n8O5cnr+RiM0mI+oOA7yip9wYGHNV9Je9R0jzPRCGxizIRxlqOn8k6CuVfQFG9bVgv5IBFOzhi7yZ08mtOrD1GV1ATkDLvuiYAL3FSwmYvxzQSUvsHAQ9nFfSkAqbFFDIQE+vNHgIxmX4qegAd61quwyJq8qtTZtfjphO/haSDYgAonGCXrox7lUEAvx8gSMyz/lKMaij5QkUXuvyGbtNYZ+xquuCKw1ijP9XmAlzAIfRBiaALjS5N7oioQvrmTMhy+TV9cvydFouQ49Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9G7orszMRD4SpT2R/TGgUunOKzoStCvoGcLOHyRLlc=;
 b=eDGUAMnDwzFB466qqN8ACWG7nNeajuVb/9AGYE4QNg7ePDV2ZXNDyw59X8VcEZa2iMwDX+a6k7z7yC0wqtc+okK50DNLUfmFhuMImP7y4Ztb/+qDRPD4U6iz29uePfzvf0TrUoNV8ZEaozRhSRTXjSib9VUo61edt8KRwKgafjvdSeRwRlHhHQs5XxuxJiFmTb4hQ+GJQUG4yEzfDNLoDQuK7smFTV3zlbjm9FCfY4w41loKMQmdPd0jpThtilmUlUy5Yox4Uu8SroSXZv/Op3IhItEaalPHaSDDxYawIwRrWAsQPnaRkyCYuHwMKYrsr01QYC/9zbO2iEBfJW55Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 07:12:28 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:12:27 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Ertman, David M" <david.m.ertman@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix LAG recipe to profile
 association
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix LAG recipe to profile
 association
Thread-Index: AQHc54oT5xO4n/evFEiaiEHGZX4LZ7ZugXeQ
Date: Wed, 15 Jul 2026 07:12:27 +0000
Message-ID: <IA1PR11MB6241995BF3969D53A1BA4FF78BF82@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260519112041.125907-1-marcin.szycik@linux.intel.com>
In-Reply-To: <20260519112041.125907-1-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MN0PR11MB6207:EE_
x-ms-office365-filtering-correlation-id: 4476cbcf-4519-4feb-ab30-08dee2406d47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: wBU+W26TYP4RgetO9IiKVg8dTRZwBHlmpRL5pDgfllnufR8bMPUavKG4vWiE3tyPXbycggH8oZMzoxBmk5hAEh8UoMoO++0XTPpg9roR1dYFiMjbeIhhg4vJu/y9o+Id213kek7D6DSDf1ssLxqB1789cAQ3TjaPKtWy7cF4UycrMDO4GLfF9REXFpnjJCmeqaXzHlPNYTJAcgOe0hJIc9kk/wj7A0SHuV6hkMsveM8RaRO1PfVlBXinixc/hA1o+HzTsz8cB/t3ZaTQdeBBG5dc5XRBnvABVMNiMfBuLdl0EYmmiZbaCdDhuEW110ly7J9hfqhoZ9hXUY56/8IlqMR7fVjByv3DlwxFCkBxDnbUoXQHFmVD6CR48P2HFjbP40k5ak1ospAkKgvMe5PNejBzNlFfcVEfTsYx5YMiJ4cJg4sUZK5ep4SxkHfbJ4uSJFI1AhhD6ywkFVJSYEvWbCIAN/IrS7AOiVNHee4vX+TSY6ugNyeIu9PM5Eo5/sLe3S447OpTY09H5oHi4HmuTjyMaabD4fADyYoA+sRgRPUAeTA6I393jXBuxF6TyS5CKGMmnidl20Z3745b/tKmc90uMMbpGRzhI1yrl1YELWKR9fqtTCXcJpCSl4PDOXjbqRmVSslK+4WSs8EQfmu1PzlGYNGU5fp8goRCX9SsTbUXQgxTMYg7sEzdiRuv1NM2QEH6PJnBPj7tQvonV6Gc2VusSsL6rX7Kf0AqtFyChm8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mQ7os9FR+Nxs0voniVrxRulfdoR6Ig4xmZaqu+Sx3v1jmOkipSr3ZN8KmjRq?=
 =?us-ascii?Q?VNRzrwZU9IH43oF+3WLDrdmoR+2gextr1sr4EJVGag+2tuZI5zz2HBb2zP+y?=
 =?us-ascii?Q?5HenZCoJyPffuV3idsEGlsM5AluMUyiwktv6kpPv/AMzQDzCej2xriwPYSyQ?=
 =?us-ascii?Q?TZd5wWqIq7fNivcbFoEqKVcbLLjkcVrsfCk6/IV/vBGd0Jq01DQnN6klnRkq?=
 =?us-ascii?Q?GJoMh1g2QFOxcUmzZol5JYleH0tJl2JXGC5HdayQqEGvxE1ZkOUwuBZCPER6?=
 =?us-ascii?Q?8yx+0MjN9nGShSyugq+3rwNTsZ9GnUpfgAdPuHVp22jpjUEMYDublE5E11qx?=
 =?us-ascii?Q?OqQHjXlzfnF2FJgOTxZsWwoEN4L8RtlFYmafSsV9bPYwECZwZpPd8sk1yIq9?=
 =?us-ascii?Q?phEDDZ4O1lLLK8IGXRv0gBmf7xbJZELIoUoYAQR3f8m8Gzu+Z7lsmSL/shmj?=
 =?us-ascii?Q?A61LnF6ql4twElFG6yZAD1T0v9vUXO99K6VMBv0KA8sYckZsKWTZLWOvuDBR?=
 =?us-ascii?Q?XU6U4LKRzDDJI5+qR76fHWgZCk0xgJadlqHqegs9mfsZXnySX8G/jX7GtY2s?=
 =?us-ascii?Q?BsOgZSzolH3J/VVaQ4mFkXjFMdBkgeH+s17ZLWqPx9D7/sWhakBqvCn9CO/q?=
 =?us-ascii?Q?E8t/egs/nkN32TVlqFeNyyJilHx7BLA8c0t3zb1lMeL2OtowJxgj9lCGyVbF?=
 =?us-ascii?Q?db6kBAOHgmJWkB9gxOplBaIdQDtvZtu7Kejb6pxoRXhLf8FHTE1Ru7CGX9Gx?=
 =?us-ascii?Q?xVPH/+AudX8sSv8Xf7wHQu4+5lI4NXABApBUuoT6uIfE3MQtU2oTUFZc8NIW?=
 =?us-ascii?Q?kmJt39t5dC1RRVL6g6/cTxY5dc3pJvcZHpWpTKRR0XJHEEEGSkwLcqiBUJiq?=
 =?us-ascii?Q?gn5cJRWDVHO1j4O0WvcW85feAlTz9zSFuLQ6NsJM3xcg/AMt78i9MgAHdRLO?=
 =?us-ascii?Q?mvSpRsHx2047o/w1/npSMAJ2XvgNdJ/nqjNC6713mg/MlX6prxzgwZEYLp1h?=
 =?us-ascii?Q?L04sG7gNBhg2qmoTHBRh3U2aWXvlELCfyNe+UBrsVggPUVSC/cKJ0bCW/CDC?=
 =?us-ascii?Q?MHbY0mFHOpicHTqxARHrchebwA1XkJDFHSuSUxdAGV+6Psz5lciT8xGpXTtI?=
 =?us-ascii?Q?bHcvfB9qOL7RvTUv+BGWqXLJelaMmYYzxjCyv1B0MV5mNf7EWVIwsrTwiSWf?=
 =?us-ascii?Q?712iLqVikdgzQIjhNvrgKgjb01eVrFp5SNSeyrK9OO8EOOzfd4Qw7bDozLsC?=
 =?us-ascii?Q?API/OVi6FbqJFaJSmlbHyD0cZuYxriDZm1fL5OBixzEagL0JTOsz4pqCJbtY?=
 =?us-ascii?Q?DvkPZKfRNPhAOm8RR3jVwCjYgQBDziBZgMlxAlTyvm/QV0rBSsqoiIvZcB/x?=
 =?us-ascii?Q?R5Qbz7r37iz+1sYYNMqIv8BUq4RT+bum91/7a8yb8UWsi0hQ0wBnxU2rpx4E?=
 =?us-ascii?Q?w7SmvkoF4OoCCX+Hva374VndkJyJPoAraycuEWwDiSc0n1C7XpuMQDVSZCIr?=
 =?us-ascii?Q?n1TjWe/LFKYNBXGCXRHzpxsLtawHfBrZux1WUNwqCETXEy4gMD+8pay8/BIK?=
 =?us-ascii?Q?2gYX/UYYUDQsrk+RiY50cyDee1mBaltwrQcHEEnhqTy0IaMxitg6v/mlHFmw?=
 =?us-ascii?Q?iiG0VklZIJYFQbh9pcJCG9THntwIQI5uLqEbsvv9dN3OivURm7ITqZ02kXnQ?=
 =?us-ascii?Q?f3kd6LqVSbq32vEY9E1Pf/QaTGeiNziyPrnZV5j4zvlSyZ+p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M0ZwBsMP6V6zSLbP6hW8wf/IJFkZpbUeDgbUjesZ1W/dLvAUk7oQNI3TG56m86uC2r027DDC+ptEozOJzkNQ5HbkvtdsJsohIHp86Sz1duhCkv1w2UhTz5z/MSM/hcULuQjbKnd0dJM+MpBuXDzyahjciEoSh5XGJfSTdJL4xCj+Cv2e0iutzySmyVLh31ePajETgtWVt+zTW3zoEusUJIhUd2/eZNN1d2aChq6kt5fPjIAmyO2QR7ILRvWOeHxyzgLt2/EqUEWHSg/PdJe16lcjPlX7m1h0kGz/v6UpZY628XhyAKhbIa3ItXsjxz7Vnc+3tUc3bRZOumQwv0r2qA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4476cbcf-4519-4feb-ab30-08dee2406d47
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 07:12:27.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqZK5yhZuDifX70uAfVWnqRzJvXMbYIwRd+9+F0wlWN/DgXNKFKW+BUvUNuF/VJrxPRq/hQPTfN3p1FUMolGTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 19 May 2026 16:51
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>=
; Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Loktionov, Aleks=
andr <aleksandr.loktionov@intel.com>; Ertman, David M <david.m.ertman@intel=
.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix LAG recipe to profile=
 association
>
> ice_init_lag() associates recipes to profiles, assuming that Link Aggrega=
tion-related profiles will always have profile ID lower than 70 (ICE_PROFID=
_IPV6_GTPU_IPV6_TCP_INNER). This value seems arbitrary and might not always=
 be valid for some versions of DDP package, i.e. LAG profiles may have prof=
ile ID greater than 70. This would lead to misconfigured switch and LAG not=
 working properly.
>
> Fix it by checking up to maximum profile ID.
>
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV =
on bonded interface")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Dave Ertman <david.m.ertman@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
