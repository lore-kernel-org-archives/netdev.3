Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD2371D15;
	Sun, 11 Oct 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728100; cv=fail; b=c0RFUusibi4l11VdjpA1eROAetfQVriW7B/QlxM/sjvzQxioUEoYi2dfi+EY7d5fRlT9yu8E77y1OEWR42V+Yvbl8lGWZrWfzdM2xcmfu2I+hvLfD0Yl0mvZTfzavPkfkWqzO7WIanjkmUm0jR6mcvH7lv56LiOFoUOYL9xJt0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728100; c=relaxed/simple;
	bh=aXVr7PIG1B7opnfjV1kJbcajSulC0TxC6KNJSmV2qEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/L5vZ2oIiipqrTbghhaOCJSLGVggEI/eZywwdJmwGvOJ/EgfJIPOq2sa+N0d91bkqCCu20XIE5jD5/Rxui4P2a9BRKe4sBgWFZABhbgGPpcH9SRoFzzWxLSPJwL2W8DlNAq+yBzSUk8iigYpdVe5ENp27oT23xI9ThgJ/+UKCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Egufq2v7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Egufq2v7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791728099; x=1823264099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aXVr7PIG1B7opnfjV1kJbcajSulC0TxC6KNJSmV2qEo=;
  b=Egufq2v7WAaHV8ZEP35ihCIeP52KEHlVReMDVtRe6cvYuGfgcg1cx44y
   GdiYGOGHh/rLoUknyixzbJoejjwcnSvu7AzbGzhgRRS8cXFbe4C22/AiP
   l9wlY6oaJG4xMwB0PYatIGkYhmYMrnE2kGMLYNzutIkLRBtUTSyzMjw1O
   Pe7xyRhVg1AoaqScSt//xvlVm3pnGquNRNat42yCdWFaRAJjpBf7MtS31
   cC8Xquxi764xNYia5km0QmZ5gCqhWjwWUThhNS7FlYEp36MmG/mkb5iGy
   Am8zbl8n4aN0sXW41I04zSLO6nPwFUumdDiL/TDHXRDaxCFQeiEVdKNY7
   A==;
X-CSE-ConnectionGUID: YIiU3npETrSE9GY7ZNoqlA==
X-CSE-MsgGUID: 1KbI+LFHQGSWGTbKv+GNnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="354477"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="354477"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 07:14:58 -0700
X-CSE-ConnectionGUID: 2zE/T+tPTGOC8R2CKf0mog==
X-CSE-MsgGUID: a8uDZJcfTW2LkUkN0ifu3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="788829"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 07:14:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:14:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 07:14:57 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofafcbWDmyhDIkFq4Rqgisy75yWh2YzyPBQSMZnUOAjKdiNiYpdRevao/4erR87BfSr633r/eDsRc7HkKkSKNXjC/9MOt9VzI7ZASXkCngwgjpsfWpQZ8uBhKa+qF58ZWGuDMLfaX1DEyHBYSSuX0yCufHZs0eYr2Cr2XVfSvHf12FXdohe2nXpYQvUUQnMG9Va+3OBq+KlPYtLXvrlynjCm2SS0oxIwlP9NzmfR8maOxe7Cb4sfCjNk/HjQvXJSTlPftzAvCLLj2dZ+dfVYhKdGvaIv7eEpk234sDmXpZ2qgBHsPUtAluSIHO1LMc+j8qJzVKCfQH/Lt70GyqGu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyYSuWXaM7hm7mer0AS2ML6E6uWkIjog1kUuBn5vZLs=;
 b=NFO2A1veZAtJesakkLfj9EG+VbgB9q+9tRSSKXhWdwO0mUbpoELmjw1H1IbpS7NwEOzXNbBPPWobn+sPRgpsw9D1vEIB28vLxoGAh/l5nG7YUn+syeH6MXJDUVSf9vgnBMcYW2TiCs5kTNXKyFNpLrL3EGAAS5R+EnJbotdk5x1Xi6YhPP6c1R/OGEAx7gP8Ye4psMZIPHdYmGU2WCnlN9ioRiav7SqYCyozesKwiecIwcehiYcEZYUG4R+q+qQidjl+KEH9mO9m9orFz4hfiYA/+ZClPCc8AELIA2zZ0IRBtz6MkgPhjOnFVBM3Bz7Bysy415temTvniDjhTTfVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 14:14:29 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0496.015; Sun, 11 Oct 2026
 14:14:28 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI
 command buffer backup on retry
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI
 command buffer backup on retry
Thread-Index: AQHdRpuTP/+B0IOZjkazzcPRb5X6ZLb4h++Q
Date: Sun, 11 Oct 2026 14:14:28 +0000
Message-ID: <LV1PR11MB8790AEC3B8FB7CDEB67826F390902@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260917115439.1323766-1-xiaolinkui@126.com>
In-Reply-To: <20260917115439.1323766-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: 8274f93d-b1e1-43c2-2f9a-08df27a1f675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|3023799007|921020|38070700021|261009223027099003|11063799006|56012099006;
x-microsoft-antispam-message-info: CkWBW2lHRy99aVNh4s2CCe7KpSzD41kw6IAcC7wO77kjujD5BvJQ/9ZeWE0u4fzQuaefRyVcZk31BGGbvUL1IwpjnAHYuoMFCAMmg56Ybf5kyBX0ncTo0tjaMcwm8uIQWiffeqauCAxsiiNNOus8I4v8H+JbvROoH5j7C1JaAwJZecXhJfc2XHYuwOPxrlOsJsuIAYf+qS26W1LRKjaUajh0i8Gs5Q9xIEAmBFUHzHW1Z5A82LLolvHrZMikpc1rPYW5sb44dB2gI/tqNZ33n1IraQKQfK+pTgYR+Ko5VzQgOtIQE+T/XxXkYLgXDQlANEHrqyoYyy97M/4DgSeX1607U8jVT6p4ZPpTf10/VxVDkFYHPEH0O/5yaQ+Ci94iHV8UwBmyVO1tPaZ/ZZW2duoWuaA0YeW9/H3ikmS6R4/0y2hss39TdwrKvkxLK7CVQWZ4GDXw087IzMdk+RNMOK40rqBPrTbx2evtpMBttrmWXYmXUtDmrI9tp+flU+IIuAXK+VzoNEV1oGz3WNGU+lJ7ze1FrGZLaBLfY/Tnd4jfdB5580F4yU3PwZiChlZO4CVhBlwb6m1phU1YCrGiDtNOScpNA3HxuZBX3Ww7xv3XGp0GyVmha3IYnh2V3k8lKEZukhyb/c4bk9auOqLYtWRmRsX4hrpS/iQYVOIjVmXUiVNb18XRh56i9i/lDEi7tfKHL/PaoTVhQpigTTRNSJJn3qN7is09Xho2gGbA1rJbFCn5lJBB+bGv4szj5WvO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(921020)(38070700021)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OmHkBLzWiSMd4mYNHENQErl9pxhB6nCL0ilb6kCN70LVy3pet5mA262STwM0?=
 =?us-ascii?Q?pOLUfPQUy8nAH2R4RtBxr4o4scYqJFab6Hix3xCpP1VGa6ihYewuMnFxP0q/?=
 =?us-ascii?Q?rZlc+JMIBu8JN3DOuZctvsX5A2JDfeedrH8zt7r4fFvhJMP0MjxCDqd4cTWE?=
 =?us-ascii?Q?eta4OaswaTHiKBxiuNj/6m12R1awT/3y7QguTKpRx2OC319J495EghFD4Ofn?=
 =?us-ascii?Q?Kh8A8PAav3UbWbrGqllg/Cw+oRsKtXgKoz/uw8VcdNXWi6SU9SGRRdmuCNJN?=
 =?us-ascii?Q?ikmEfTrAngAQVBwdIEJ/BlfbCY2LgV33F5OsLJqYNfpnjx+C9aYhPQ7whLh6?=
 =?us-ascii?Q?IOGzAMPakPcWW61pvYW8Ak5M6d1dSvuftR6PKil6zSQKgddfj1cQ0V+SjurG?=
 =?us-ascii?Q?zL2TFN95eM6uLXEBYVtFa2oOh4s3hVAAx2vA+XzGOxftpOJ9eI3Hb4GqWQAs?=
 =?us-ascii?Q?ROi8lmvQ68sSXVq5htjcOWd2kIhF/rXpJ+2eBPiRQRml84ixAX9SI6uitI/t?=
 =?us-ascii?Q?uJCrqTlPcd6M5wIvZfIO2QQnPKfU/M2Fy+hDNUiDxmRKh7CQHU7jxLaqP2pm?=
 =?us-ascii?Q?MhtRTPLnopnkFvImrWTSK2HDpVJXKXuRiRQ+Ib8XqvCkD/E+zbKAg6UValfI?=
 =?us-ascii?Q?LLsGNoOEgMhlytUQpaXOAJ2Xx/pHYENX0nIInuJIE0zmPV8m7MJfEC1GkSgk?=
 =?us-ascii?Q?lJ4suQTzkZEc1blfRBf6SjfoQURKJJ9TsUphV4CtRBH8Pk1rD/UJdWL+7um9?=
 =?us-ascii?Q?fl3hAtM/K3GaZqrP/DI7NCsuGx1VdWq6+xUca/6ghSBzpP7fBL6v2ggcPYge?=
 =?us-ascii?Q?e6Gccwu4oKY2Th5h5zUpCZ/IbIQFhLnouQP1iVdwuEcXnBFdOn22O5SRhh/j?=
 =?us-ascii?Q?NiPSZHdO3nkMMVl138K1oV1DGqBx2Xsa+Ry9SLAWjfbmdIqmM+Q2zi5vIokk?=
 =?us-ascii?Q?2oKDIs7ixxQ94zcn7FWGORrCxjKYGlqy5Gy3121IrpKm90iEvYmplfKDKJ4G?=
 =?us-ascii?Q?u8zH8gX4oLgBWWs+zNCqXEhzeTw3wmnO/r/VSc7825QwSY61RV4B9NO0phY3?=
 =?us-ascii?Q?RvdElx757zVzVVtudN3faXUf83+Uf+iZJ7lpo5hVh8x8eANi8INjiMzp5sD4?=
 =?us-ascii?Q?HiwYRGyAi7APfUorjkft/HNPX4aLTbMPQR80/ElRLWAQnqWHEKRXBvQueKft?=
 =?us-ascii?Q?WwXjczs7uQwk7eRgKIgiajFxldRI9FiOrqpsIlCqmOTRMCCgvJ/MsJjIlD3Y?=
 =?us-ascii?Q?vacKK7EcyVj63oW6Jk+y/PrDyCJY9XlUiE8R1npwwXY9ZxhdAOCeyitjAGVy?=
 =?us-ascii?Q?YNH9BMEzoq5/tnJIdmYWsPUPZnTuajiv1/wAmBpAC8y9K8pCDYwg9OVCx3pl?=
 =?us-ascii?Q?ogplG6kVqmr9ANRPyUqTP3z1VzQ/5JBTsPLKo5MJ3xfZ5sEyAdJgmfPYLQRr?=
 =?us-ascii?Q?er1O4MwJzD8wQJDcqD4ztsRY0J0zrRSAiTpajf8HFw1koSQehwbizWcZ8l59?=
 =?us-ascii?Q?u8Ru2gRGM6s8seKSRSJBxjDB5cWlmcKKgPBUtABie6KS1ND80xOZbcOyzqbx?=
 =?us-ascii?Q?L4jG3ybH8v4fSg7Y1XWnFmYhbzb5fS9EL0uwr2kUi3Yl7JYMvE7Wb1TinWyP?=
 =?us-ascii?Q?f9JIy/U31JK98nsXx9phR0QgkXuvbm69GrEDpn5ytWySrADh2a04nAATt2Ua?=
 =?us-ascii?Q?QoRoscF6RHfdIqf7g477Pue4G8XmM8YBGSYHFBOEna2urv2rRV/2WgZnnpLE?=
 =?us-ascii?Q?ruYXGjPBaA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J5nxSpHm8flz0ojkMUUU2TJ6uirAMkYufbrrMSKvuP44q683on5sg2QDIKYB666aFb1MKpsFWbO04yKsq84dg2xtNJ2xcXnVTtZgKZjDlH1HsHjtGQv+zuYc/waclePJApCA1rAJA8apXrL0fma+4yHXEfzNM512KCbvmxvS8IVTzwMqA8k40U9f3CK4rFlUv+I4cJDjNJYsIYEjintWianuVSq/v8clEcLOfMIYPQpV27+QqL7xx4+w6vZlG00UUXrwRgYX1OHF6MU3dITZJ2b7fudfU0dA5JY8NIjZpUwyq/KB5sGZLy75PyxSdNQACRQFEXJswpnTeQt1Lh1xug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8274f93d-b1e1-43c2-2f9a-08df27a1f675
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 14:14:28.7462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n154CffOWcs0lpbK3yjsQ/CGW2yogBv0jQykBYYfXxF0Ocehb6PsJo4yPCEqEW8zvxIaBBrHSOZWe/he0Rkb9eEZGzzYzPMuE7qatXCjtXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>=20
> Sent: Thursday, September 17, 2026 4:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix incomplete ACI comma=
nd buffer backup on retry
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ixgbe_aci_send_cmd() saves only the first byte of the caller's buffer bef=
ore an EBUSY retry, using kmalloc() plus a single-byte store. When retries =
are exhausted, the caller's output buffer is filled with uninitialized > sl=
ab bytes, because only the first byte was saved before the retry. The firmw=
are itself does not see this data, since the retryable opcodes do not set L=
IBIE_AQ_FLAG_RD, but the caller still receives garbage in its output buffer=
.
>=20
> Replace the kmalloc() plus single-byte store with kmemdup() so the whole =
indirect command buffer is saved before an EBUSY retry, skip the backup whe=
n buf_size is 0, and key the restore off buf_cpy instead of > buf, exactly =
like ice_sq_send_cmd_retry() already does.
>=20
> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> V1: https://lore.kernel.org/all/20260912013403.2818191-1-xiaolinkui@126.c=
om/
>=20
> V2:
> - reword the impact description: the firmware does not see the
>   uninitialized slab bytes, only the caller's output buffer does, since
>   the retryable opcodes do not set LIBIE_AQ_FLAG_RD (Sashiko)
> - fix the ice function reference: the kmemdup()-based backup lives in
>   ice_sq_send_cmd_retry(), not ice_sq_send_cmd() (Sashiko)
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
