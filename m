Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DD42B316
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392973; cv=fail; b=L98uy56xAQKIp1oupyLaYaZ6JCGDKXBLkfAVF+lzclsLlJlfYLziYQAF1xWN83ETK/vLu5yL6Cg3bqqbfi0k4z6LFgDavwyj6AhRO9S5mrguBdVYq2/wS+QwZy4fMEfMfL8JXLZAqkL4Lgm1JkplLGbSpNZVp+ov9z3AkSHIiRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392973; c=relaxed/simple;
	bh=YphwSgpeyPTYPWsAyhYluEUhtzyRjssA/H7UOa0fmmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QyQ313Zjt3JPAHToC7LuexpaMA55xw0sHzPhGL+As8BB8ZuSd7PYbZHgpd/4KfzYkzIpjnaBqUguyvk1ARLhs4SLWg0MPD3+vAyuXt/RVJN3zGZvTLum9OqZzGCSPVsJuNGeBXXk9u/dsrjRTOJcq9Epfc+VJ0WnrGqzPVBmkDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bD8/+A0F; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bD8/+A0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788392971; x=1819928971;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YphwSgpeyPTYPWsAyhYluEUhtzyRjssA/H7UOa0fmmo=;
  b=bD8/+A0FfRR6mFmryNQum0KBaGj++SM/B+68bvZ0lCFhEw0AcsjSKnDz
   9X9RV11BB/iOWRiljPlksySpHlek/ERyfBUSb7YbDY06WkzZHcfIyNeFo
   ssUerhg2zvdj2XTY+QQegrua1ZhMO/6RToqEPrJg+SW9nBk8fK35pFZhj
   f5mpaNiJj3gaWPMsWA7gKGTOEWc8re4mxbv5/tHbeOTczaZhoYg/Ij8me
   OPGmn/GmJAgEnFpslov+mqYtrnnP/MJmDuz3nrG/WMwdV+RCa2nqGx5L6
   vUpm/8sTXfmXJg20sjaq72vL08ETImYWt/Kh8KuDTM6U9FU9OOOzf6SLS
   A==;
X-CSE-ConnectionGUID: 6aZjSGPbRDaEMVgXSKYqNg==
X-CSE-MsgGUID: 3ZIl4w4DQoW3fZf0BLsVXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88915601"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88915601"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 16:49:31 -0700
X-CSE-ConnectionGUID: FsD1FSWWRw+z9eUPD3yN1Q==
X-CSE-MsgGUID: JjYL8DfXSGCd1QSE1VOS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="274842514"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 16:49:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 16:49:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 16:49:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 16:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snLaBy5/TFy0YYSOOrIP+OtlSdhvKrDVvafHitu2gH+DtU3WicBLeDs+aZvy93zLoqSG1D+zOiJZergavE+0iu0AIB1utZX64ffsZL7hUpeaVc1mTYn3cqpnzM61YIHb2hvnymXOxFs6I6WOfBij1O1jaO1gWOAGr8goNojpHJZRCkVvVTCJzK13GjFmDOdH2nuI0AMz+VmEeibLh6PqOry325pDFKvoZ8cE6Q1zzerarkrwljzReAnQc3kEYy3gtro4lUO4wpuUWI8SXH+/hEONHpPBaD5wOzgb1Z1hoVSMB86xT62E7Ygvlo5MlSuwxrOUkXGVuPV1Hd1hFKMHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7q7Ei8VfFHVuVOomXbUeQDwXqBX2IPtut7/ePXrOKk=;
 b=YkYCsfjA5oiOZl9jAMPB6QPxD7gZtYCrovZfOga6u1934w4zXdWqRZzAYJxG1+NxTh81KTbar61zfLCbKwIB6nPsf7Fe+0u4D/l7jkkm4K+SEnl5MJkzL1IEiXK53YVeMgQwepR5PqY+J4y9xR9jDKLd2GCtz82oxr2ooUETzDDLUt91eZEmmGKMBBIJT8fRmeDgXXWij0aRpwvUSmF6k1w2kPzN4EZ4cB5VGFaBuw4DAaTKDuBhzBq4Ml1YfobyD2iXAUqiG03JfcFhXvl/asube/z8wE7v4aaieqbFAKsWf9+jFFpLBaqkwSU0pqcDxCiriYhHkqG7qfxant0NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA3PR11MB9302.namprd11.prod.outlook.com (2603:10b6:208:579::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 23:49:25 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 23:49:25 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "jbrandeb@kernel.org"
	<jbrandeb@kernel.org>, "Shelton, Benjamin H" <benjamin.h.shelton@intel.com>
Subject: RE: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk()
Thread-Topic: [PATCH iwl] eth: ice: don't dereference pointers from
 TP_printk()
Thread-Index: AQHdMREdE5/OKWcu4Eqymg5X34haHba8COfA
Date: Wed, 2 Sep 2026 23:49:25 +0000
Message-ID: <LV1PR11MB87908829F6BF6F7A687BA93690B72@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260821020201.1337338-1-kuba@kernel.org>
In-Reply-To: <20260821020201.1337338-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA3PR11MB9302:EE_
x-ms-office365-filtering-correlation-id: 26415c89-b86e-4996-ad74-08df094cd1f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: LQ8oncH2SEcFP1tvCPp/f20ZwIE8hcrc0sgOiy4zNRVj/kOA99MLJhnBy/lZDS9rrFkDg/13Pi/1d0Vr2a4tduSEGtnUGm+dv2lRNl3ANclcYI1FP+SLOv5H99knmvKjfUKeh07t+bGufDHDSyYCvM+Fx/Jnj0KC5Tl/m6fjdH/BOiyuWOwNNveXJRbI6sMRH0hfRIdnqiRbW/cH2xUbtw4uPNkt0s2QzZrdL9QDq8bvoQ6zcx3C7k4qMPhRlWJ5OnapPyZ/JxGO2ksRXs5RDBILnnYm8zv6elCdoA8pzDL5Ex2tOeKGhoI2R9IBsSCXx8omu/92FsT2H3450natPhFbqr53CaqvyPhgNX8tXNNysYkorEHKJwUqmsmXG6tDcv2P/qr+c3PvLFAMuO9ojNUUqyXea4bLr4ZZnP8l9OgOLsy6tpgzN6OUzq+QVc6ExalKr13Sfq1+uTti6LZfE7D/sDpBue/qkDPb6nxaqeRUFwVKwsQVS6Su6FrPkAYe2mYXR3o9dkTJY4r3Q67hnf28KTXy9M3JwO8beDjK9r30QFuPJ8Wbs6JB8eqsVcGlqID4FEWCMFSE1w+cuaVJuapPHmpER5bHAQ7JO/SIWcLOOFLiTrczYQTJdnmeVfwu80VYfrLjynjU9vxCZlL3XviZA2yVjiobwwpyoEhN//sx5v6BsEvrCOehLuUKx7BwILt8bwn0RPB1pQSPgwXKc3vEsH1JiCMX2M77ifd4Q/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lS7XhG3sFdxSjDAz10YTEw6qorOen4eyQTkykYecsXRB2wSTvjeCy5KS5njw?=
 =?us-ascii?Q?022HyoYFjSxMM2ouVJLhsGxP0shS8une57rzMjl2gx82NjXQqbiy/nIQvazo?=
 =?us-ascii?Q?/7i9IQVFdYKN26PQGV9bPuJ9xJmuKIoENGjdWDTbyHomjIWOYUP6Hk7kEu5m?=
 =?us-ascii?Q?b5UwXTr7CJ/xDzpGKPS7aRJWhYQY0abYDDHU+NljnVNhi6n664UpbmnKfOfQ?=
 =?us-ascii?Q?GMVdE/oRBZfJLvV5H/qNLp4sXp/pV3NoOD0e/cA+VxwJSr7jurJ0fIA68mRP?=
 =?us-ascii?Q?MmnQXy4bW/k1mZzVoDCMUfJw4teN9S5BhdbX94a8oj4rugafFWJVHNyUdim+?=
 =?us-ascii?Q?o1tXuVaYdE23sftXRi+t2KOJi8ZCvUBgBdFMBn2ftG+4kRtm8BPzyonC0wuf?=
 =?us-ascii?Q?1+yxgJxabRsnGVkRgXVobq0gMTFcv8y8x36WemCD0sg+LbhIypNDpwHnpKCX?=
 =?us-ascii?Q?jOImo9zLW9NwPpScAK32OLhKpCeh7EkNJ6c6505PfURAIevTfx9GJC0LTcpE?=
 =?us-ascii?Q?XiMPbOelIIrNSl6XNE2AP0ABn3gkFyNkiAsu/289SHk2kZko2mcaSAx6BkDn?=
 =?us-ascii?Q?GTZhlMAS9iuv9v/AbbBU8eD2eaMTaVZ+tg9alGRD3erxBg0uqe8uAmDeu99F?=
 =?us-ascii?Q?eKsfzvjsEgEa3ifahm1raq0+Eii8PIDU0/Ejt/hp/V7M4NM1m2aIWRat+b5L?=
 =?us-ascii?Q?fJdo1KThpi/pLTuD8nnGfuCDTumrB3KNsVMxX65ah9LJIdOYpt6Id7YRMa9o?=
 =?us-ascii?Q?x2kJfcjqa5NRejybDFFAU5vzYXzGtWpa74VHH3UI4DqzZ4qWRIvlRncDLS+j?=
 =?us-ascii?Q?JF4fERHrbP4VxcK2qQEFp7/wd8jeW8wAD3i8F1QyVLfy1qedhWBSg0yHK+e6?=
 =?us-ascii?Q?hyOVX/HOgfIxRe6mpX3xfKcn4QGCEq7OQw1xHfhsrmPfc1yd99zEEVxNXcUg?=
 =?us-ascii?Q?h9DcCO0tZcCMaKWm/+eU1BJySA8FcIyMeHGtudet3s2VPtpmyTfuXz4xSfBS?=
 =?us-ascii?Q?Zi8/q4fL+5sV+bVaGEBRZ/kYlycTlhOBS/4y3LKakOhi2Mj+sO8hBVxDhJXh?=
 =?us-ascii?Q?V0rU50YFCXrmSL52KzkSCTHFhZJ6DGiyZtDUbuaL8rJRDENlnKPNh36C3AMG?=
 =?us-ascii?Q?0KlsXFnL+uIO5UIrsUPANpHjwldXiAmPwso0Lun7tGj5ZbzSTvgz+7cQqK3l?=
 =?us-ascii?Q?XNDGLo9fyXhKBdj6V+mBdYxfAZXDeUhOh7wxgFaWMB2asq0XqbmeV3uwOtco?=
 =?us-ascii?Q?fysWsHWDG5fjGf0Xn5Rr+hXoKhkrQELH7FZvWvj73jz6o5JPXKDZ1hToxXeq?=
 =?us-ascii?Q?TdYOwBSMiuPyf90k/KGSiCaViPTCjokr5wkfxx0XGQNGJx0R+Ew4Bpc3SOyK?=
 =?us-ascii?Q?e50Dw3f8uhaPvb+bBVtT1B8gItDFMRK4KdcaL3E5cxaBTnc97ABVN8AawMMl?=
 =?us-ascii?Q?GzMoJMAbHojmSOFuQ9d7OvYMg+vbZkXaKVQxwHymJOv5XEnfUJ0JT1UPJ357?=
 =?us-ascii?Q?LVw5thkmY0ykL6Yq6vRxAT1s1yVF4F2NA7RvX7m86G+NyON61cBwvS3Z7KSv?=
 =?us-ascii?Q?NV/qnjwzKPx40LasQb/TfSGez9ZZzPAuMoPwdt4rfjhh+KRm6kkBGIxf75J+?=
 =?us-ascii?Q?rD+cjJvLQDsq1yZmQFa3t6GmqmDfjsQbeaAMW86kJwB0VMU9wUryr7tw3NBU?=
 =?us-ascii?Q?PwXZU63dBg+XY1g/OqlvyV1wRTjCA0dHSZZRB2yUWDvA4oMEW/ukGL6ICaum?=
 =?us-ascii?Q?nszyPCzXqA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: seisdDxDLdzbcfz7pOa2Dlwc1WC4gpTIrPy+KcL0TOaqcQQZDBxJSju8VX8AO4h0if8yqQi2RlbVzDH8PfKTYn0jSl5CSxqL/+cV1eJ/Kq0bX+Yvm4rS+3mvJCk19am5uJpXJYKK+edvQrnSkjp/OSqICV8RQ39MOHR604ttUY/WEOBT2tAku4C16w4YWWz5oI9a/bc6HX8HakK1LPUQcMIp8JXe05GlCy9X+4hBp0s2adRPMXQUIp2gpaadGDBol48OcJAFPTiLErSXSDVxXwaiaKF4RlokmrOz+7Po5V47SOIQs+3ys430jigaB0usehLDwhIhEHVrEBTyXDQ/NA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26415c89-b86e-4996-ad74-08df094cd1f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 23:49:25.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PqzdwvPo461bDBmQI3DStTCzYSdHS5oNDfEGl0NIxP/agZxbfnY58niTUCjFIwwV8RQdGG+VM2h862eO/O2B7ZIkYqbX90ktZDjxZ1LfAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9302
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Thursday, August 20, 2026 7:02 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; pab=
eni@redhat.com; andrew+netdev@lunn.ch; horms@kernel.org; intel-wired-lan@li=
sts.osuosl.org; Jakub Kicinski <kuba@kernel.org>; Kitszel, Przemyslaw <prze=
myslaw.kitszel@intel.com>; jbrandeb@kernel.org; Shelton, > Benjamin H <benj=
amin.h.shelton@intel.com>
> Subject: [PATCH iwl] eth: ice: don't dereference pointers from TP_printk(=
)
>=20
> After forwarding net-next during the v7.3 merge window we started
> seeing:
>=20
>   TRACE EVENT ERROR: Event ice_tx_dim_work has double dereference in TP_p=
rintk: REC->q_vector->tx.tx_ring->q_index
>   WARNING: kernel/trace/trace_events.c:420 at test_double_dereference.col=
d+0x39/0x4b
>=20
> this is due to extra checks added in tracing subsystem in commit b5cc230a=
f5e5 ("tracing: Warn when an > event dereferences a pointer in TP_printk()"=
).
>=20
> Printing happens long after the event was recorded, by which point the po=
inters may be invalid (the ring > or the dim instance).
> Copy the eight scalars into the event instead.
>=20
> Fixes: 3089cf6d3caa ("ice: add tracepoints")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: jbrandeb@kernel.org
> CC: benjamin.h.shelton@intel.com
> ---
>  drivers/net/ethernet/intel/ice/ice_trace.h | 64 ++++++++++++++--------
>  1 file changed, 42 insertions(+), 22 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
