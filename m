Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616807;
	b=oQYesRtqqEadMkDAM5yzvZ8U2VgbhM0rH4uan+c0MtKuxdkPNOGmM1Vp8+8XevCx55Sr
	 uOKiGvPPmbZm13HABoxsG/mGDDXvFozfutEF6qNqFhNemstQLggj0UMWew4+pJTgEmndf
	 L6eSaeXwvGJ4ocGYyuo23+0zwxn+gsOjcoR0VpkTLoSUhTXnXAp/By2z9aHkP45tSoU/Q
	 nTGv4sb2yWb2px8Lq+3uDcsk6d1psj4jDOUAhzv/dilwgR5Sq78mNNmM43J0dk10XkHgU
	 v7wo8TZ+kUzvBFhho8hGS3vRZiUFq5Xeki7ZclFguqmSpW/+w744gzx5et+0xfg1unQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616807;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=jWRS0pJco3dFANtqA22jpOgt0dfPHAY8Ic9SmXFZa+A=;
	b=KOEZnjQP2jmvN9eVd1mmD7fLYfG7pGY7rOqyxKzed5/e+JYmqp3/bvE6DZexbopowwPt
	 gnT8QWFuzBZWhE76Ee9h2cQ7GxvXZQq6robkQaNl1ump4hmaF7QAqvyKYCM9t4X/9IPjh
	 52+816rfT+GF/kHfxtlauYsMz4KQMmql2qTbhwCXkJmRyOYqQgelGXaQEFCZ3Jg40CNCs
	 Vzk0TeLzoCINI4JNdP8S1YV+pK6ulTcnnoxr4QsxndcayAk0sBoZE5aUtl7x85fy50O5r
	 HZ1V8QhyW2uR3Ye5mFeu27+L08Uay/LpBBfX4GDblhe39zig+5YjS6aFc4F4teD5szg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f7ET6R3Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71293606A327;
	Mon,  2 Nov 2026 10:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71293606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f7ET6R3Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616807; x=1825152807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RdCIRaXnIRp3yYnEKzx5uw6xVZRutiwYtR9yIj7cx6k=;
  b=f7ET6R3YgAZksOOGHAlMxmTdYjW/EOxJxTrVAnLXXRGW9iC2EaZOIgKV
   zg0wQ/RAzGadGEvEgQfQQst/Lptejl6y3eaXij/nqyZLqu9eUeA5PEES2
   4Hx21HyifAeOGP++i/PpglynUwRxZ0VfDoaEwxi7OP52jsYbRSpsgWv6O
   rLae4ECBmq5YhHw5Z0OFtZc10Tska3W8M7qYZPWzPpJVRSv2UczeivBFE
   mLmxq/2Y+9u1APIq8dbbLZf766EIX+lV6GYGw6SpuMIlz+B6Z49qIPfEz
   h0u2zA4Ny3afos8RF8HmjepdgMe+5CO0a1gFY9p7f8g3xiaQm89NHh5Io
   A==;
X-CSE-ConnectionGUID: /QMyaaneQ6q6f6mKgk7jDA==
X-CSE-MsgGUID: fAPFAz+LSmK5wMEvE+XPBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2336387"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2336387"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:53:26 -0800
X-CSE-ConnectionGUID: BeN5v/z3Sn+k4hC8DyslUQ==
X-CSE-MsgGUID: +9W1vOgFR8O4bO0VN8t8Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7864298"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:53:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:53:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:53:25 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:53:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWbuF5TciNSaKhJCwY9exvN/H5IZaBvs0TrkYtMswD0k8MBWgeRtAe23dmcvzWKccAc7UgQ+RA3m6hApNy2pWBMbVBOp7KNJL1uZo9P+vi9CggukZRFH8Y2xrWX3+6gfTKHit0tNnjXl3mq4HzI25DXVE1viFT1Uam60nHDKasXySqD4XVJBwR8p9pbAkOdD95ng9DDmGaBEQ5HPJ3qGXf/e0MfAQT1v/WTZnA8rkmTbHYEj5+XlO6NRbkuP+qbZqSv7dbA30tMRkiwsKyFwZ3crpR5ur7aDfj4F4knjqrWzSJSuvr1rRv4gzti3hWw1Jee0QSeGyi2qWh1KTv+UrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWRS0pJco3dFANtqA22jpOgt0dfPHAY8Ic9SmXFZa+A=;
 b=Y4hF6Y+QKDSxD0nW4LeApcMLXo/chfw03qivNGDbBo6A72RulXftuJpdIxwyRrqStgRwJXuSF1X4BbzAczDJymQFx7Jp4UXmzTPaPHm2QWVo1Nz4X/FXPThwgS9RET8gP+XY+J7kRXlHuT3qrcSwNwzYibZeLL++60R7zZgQ5k11JNxQJHvhdp48ZlQzohA03J9xqbBa9F8mZLUO0L5jJyfnEGirK1JAwmGuuzdURhbysHDZTgl7f4+HSvP5I7zg8+zdP8Qlc3fcUWlmujXtFFpLlxvrp0GRGfCKFUnLwN8FFtm3QnzZxSHRyaOwBK2AeZPIHOJxHEJQvoAxOTaITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:53:23 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:53:23 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Yuho Choi
	<oss.patchbox@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Simon Horman <horms@kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	Alan Brady <alan.brady@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Burra, Phani R" <phani.r.burra@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Thread-Topic: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Thread-Index: AQHdVCuj1tNwRkH5u02F+ksIQdR5qbbuvmEAgCwJ9iA=
Date: Mon, 2 Nov 2026 10:53:22 +0000
Message-ID: <IA3PR11MB8985D32D84B8D01631E7BCE58F6A2@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20261004180954.163789-1-oss.patchbox@gmail.com>
 <IA3PR11MB89862E926E53936B2C669FCDE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89862E926E53936B2C669FCDE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CY5PR11MB6416:EE_
x-ms-office365-filtering-correlation-id: 8b9cc9d1-1291-4dbd-b3cb-08df38cf83c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261021121427099003|261022105027099003|261022075727099003|261009223027099003|38070700021|261026140227099003|261026121527099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: i51NAo6Ngq/g2IWQQ7Axelg1GElvA6O93b6WKgsa2WL7aDQmOuh9UyLzdT2/096gkF5/v3Cn5ersxv1Gv4y9iacUxvA3mnRoKJQpxflSVi0wXobTVU1yxUXRr83AxXAL3rP9TPL2bVomb3VE7gGN/1XizezFv7jLvV+YmsKeSrCJpLo45nhZv5QyYvaR2ouHn3xC9xYzHWXLfBQlpw40q9GUSPKj+5mws8vjSYUywnQvWt9MQdfaIxoaMRMQTHleebRIZCq6vSrbaZcxOy+xyLw4BwYY+0daxb4oeU6OXBt83nFHcMj+uJkvGmmb9Zoz1jSnHucVNYJFUyHpMBAA4jB+vcK7Xjh5hZMN3EN8sjFBfa5oCX+uWxouz90RcpNO97vb8yYuAf0/WR+PEWXg32mjmWtjZZ+GDFDkBOkKxS6avEe2RM8YG25vi8w9OpNTQQaYIZXs6RO5cPccHb9ZJ74QgRkuoaeEQZ2hnGcmEo6pTalTB+CkW/P/d41vH1pzJuHOlhnEgFjqAmIssa9X8jUDapXMssyfR+FBzQ1pXJbwr3yIzzdZIpzd4bwIGv+0TcZ/TA4xhX64NQRO5gvUqKbM6GlYLJQlNrOWGCPhBQa7/TU+1OlKIT/mHhP/DAKs34m3dJHbxjGUO+jjq7axqiALaAf8o3ncNzhSi9WmYQUCZqQUjmuuFy5eWX4lKWvT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(38070700021)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bnVan2nYAfMBYtrvq7AFufrikIKaMiTSPmCUva6Arxjiu6ZotI9u1/79PRFp?=
 =?us-ascii?Q?nfor2NH7QLC3apPuxOzWtAPDWilJSdk1mQIZUTUA1NOC/nHM5jMjh9mnGPPY?=
 =?us-ascii?Q?ZdHbeEce9tYt1ZKm0QClOJ0Tc/5vHPH6KPmZSpAF4GqruZLgwwrHu4oi1FyL?=
 =?us-ascii?Q?c2dnf1k820H0RLwiEgufCTqvD98+aOIE+JF5zIO5gt5R4nL8ZeSHURux7pkf?=
 =?us-ascii?Q?bHBU21qIDXb5AQox+xfX5RZPvRcglBj2XNATzor7xzYd+53BrZd7IKjIcUld?=
 =?us-ascii?Q?riRJZP0nU6ch3qX5Ll4ute8RWATL1GFgg5RRrmyrOYZACB7xANVHp4H85exh?=
 =?us-ascii?Q?cwY73DemHSRd6X2LrTyRHGMKwKmMCo0hzzNO5P0LxKFVw6Ufl9PWdrQoaOBe?=
 =?us-ascii?Q?j3MpDZGIcG4lZjmMJliEDSnsk6GK98L0OCJ6cSNFyvyl76WYvNl1Yk8W27yh?=
 =?us-ascii?Q?DvKTpAJodUQH123y8nRQ0jHfMYFasWXqA7WwbCNuh96bWVTPmjmI+1YJ5o3t?=
 =?us-ascii?Q?nuVj/0YOIlSPhuQ2Ui+cD2sBLW/lyLbDmxK+qIjElhdOxTyEfujIrY/24fPU?=
 =?us-ascii?Q?SY5xqz6THP8i4FbRoR8OGQ0VIUC4w5idMHHuPFmw+rb+IllRLD/JDK0h7qtD?=
 =?us-ascii?Q?AS5sb6FJ7rrsmG4gHyqNVmp7FWoF98MMajJkfglxIxxipB3bUDR/9IseXjFM?=
 =?us-ascii?Q?txnEdlXMoS0J2KbbokO6cFa5TRyUiv+DvXrV+AJCpmg1y3ayYZEj+7denh24?=
 =?us-ascii?Q?GBRF1HDu9A7iw4sYs2DehcC+xqtXtSEKlz1FfDmcQHfVM8MKt0Bzny1e5jTL?=
 =?us-ascii?Q?1CqHopJyZhaPcAHkFnjfZx2qvaReJSKoXD7I3Y/R+2y/6A99hoZu9rH/AgWd?=
 =?us-ascii?Q?NZBYLxIj/NBRTQY+GFhw0J0Lcjt5U9QqGLRVayo7e2yVXpkY8ifH0s98l0+E?=
 =?us-ascii?Q?XZYcn7g7Oyu+IdGIR49fy0Dpa25RkCFsEYn3r+jKFSQaJdzCzdShrE7lZDVQ?=
 =?us-ascii?Q?fQE3rBRR7KcOAH2KAhNgWZHFyvyKTLFlnBDYjSB19mXI1dYCVFaE2Y7ZsRf9?=
 =?us-ascii?Q?m5nKLaTjunbo37aUXViNSbr3SxLz411TNoRleQyxut9Ko47mrD1friEowPAJ?=
 =?us-ascii?Q?4gp2pjlT0ykwB/8pO84DmiNkznb8h6Q8bSV8jSJMj6B5CA6PSbBHjgjAbA82?=
 =?us-ascii?Q?LX9j67IkmO4UWMpizkBWmJFkVLSkaewbtbDr/VcPSYyLe83uOEMWvkj39Y90?=
 =?us-ascii?Q?335HJ47QvYwTRDEB1D44KI6FP5kgNK0bzSxWVv8EHBkLN/nCzksGf1f3UO0J?=
 =?us-ascii?Q?W8wITKhSCPHuslPvqD/y9NPoJHcm4MK4UF/ZIQyHdv5VQlmx54RGderwLdoV?=
 =?us-ascii?Q?mRpCwJXsaDj69GDHSnjb4h3WxbigiFnRws2lpKnJqEkfdTNgtFmxHWP/jRKr?=
 =?us-ascii?Q?O+muRVlQx5TjRIXF1i1XQvhutE+OtsNn5MBKV2NbXMJcP6gWXRyJzYJpF2Tf?=
 =?us-ascii?Q?kt7oMs+2QXWW+dovK0aRRDtMCT6CYdF4GT2xvUkA0/eNNJ1lYS7ArhPPJSr3?=
 =?us-ascii?Q?JECECJG9nNQBkips+C+iZW2r+yT4q/fPBjaaR2BNfvlVp7XP9HR6LWdGZRE2?=
 =?us-ascii?Q?nBeE2Jbs3PCR7lit8g2lHTAXhkK+DSROg8kTpFcl8Lt1uDLfwafNISy8pR5K?=
 =?us-ascii?Q?5uSTiqk3Hh23CvKNcGoPJEmTcfUAbtqI/xrSF+g8CkZURfpPMZElpmN7DGnT?=
 =?us-ascii?Q?ulzAjQOODQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: x3MEMELbj7Mb7DEFKfKwvz2RLrobf3Z4cZZEP00ctDzuHoCGhAxRPWEV+dqPO51rpkL4lEQw9t08LIbRts5ojb4rgktxfO4Jv0cYE6P+Ec5eKrrYbRpa6A8+49hRxQ61Y3LSKWr9BqM1V9SBZXfVrrJInFHvByfxLkSwDwTSq5vXubiO9a6cvuYbWUOm27tUnR3DwP9vXMVdn2o4L0blLY0TVMHSxg/ke73jUxfeBeQiEnbNGfW7yItnsmSu4z2YUd5Eap6x991KpsjUbkIclr5rx4VjgS8N3qvj23hFPwzdck3JP7Ef3PI43Cm2GiWzihBSv+H5kCQdtLMlLBIG6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9cc9d1-1291-4dbd-b3cb-08df38cf83c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:53:22.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoemvAfwODSCMmbFmhRbPsmOPcaLwjUo78VZZW+P2byrVuM0xty3B14U2PG9xRJhk71flrLX/BCBlgZ+qdxTwBgQpJgWUpqcXg4FW5mpv+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Monday, October 5, 2026 12:22 PM
> To: Yuho Choi <oss.patchbox@gmail.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: Simon Horman <horms@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Hay, Joshua A <joshua.a.hay@intel.com>; A=
lan
> Brady <alan.brady@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Burra, Phani R <phani.r.burra@intel.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.or=
g
> Subject: RE: [PATCH net v2] idpf: Fix vport IRQ name leak on request fail=
ure
>=20
>=20
>=20
> > -----Original Message-----
> > From: Yuho Choi <oss.patchbox@gmail.com>
> > Sent: Sunday, October 4, 2026 8:09 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: Simon Horman <horms@kernel.org>; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Hay, Joshua A
> > <joshua.a.hay@intel.com>; Alan Brady <alan.brady@intel.com>;
> > Samudrala, Sridhar <sridhar.samudrala@intel.com>; Burra, Phani R
> > <phani.r.burra@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David
> > S . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Yuho Choi <oss.patchbox@gmail.com>
> > Subject: [PATCH net v2] idpf: Fix vport IRQ name leak on request
> > failure
> >
> > idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
> > calling request_irq(). On success, the name is released later through
> > kfree(free_irq()), but when request_irq() fails, the error path only
> > unwinds the previous vectors and the name for the failed one is
> > leaked.
> >
> > Free the allocated name on the request_irq() failure path, as done for
> > the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name
> > leak on request failure"). While at it, fail with -ENOMEM when the
> > name cannot be allocated instead of requesting the IRQ without a name.
> >
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> > Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> > ---
> > Changes in v2:
> > - Correct the Fixes: tag (Simon Horman)
> > - Handle kasprintf() failure (Simon Horman)
> >
> > v1: https://lore.kernel.org/all/20260923234819.702327-1-
> > oss.patchbox@gmail.com/
> >
> > Compile-tested only (x86_64 defconfig + CONFIG_IDPF=3Dm, W=3D1).
> >
> >  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > index 4311ffa30bb1..af3213eae393 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -4067,12 +4067,17 @@ static int idpf_vport_intr_req_irq(struct
> > idpf_vport *vport,
> >
> >  		name =3D kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name,
> if_name,
> >  				 vec_name, vector);
> > +		if (!name) {
> > +			err =3D -ENOMEM;
> > +			goto free_q_irqs;
> > +		}
> >
> >  		err =3D request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
> >  				  name, q_vector);
> >  		if (err) {
> >  			netdev_err(vport->netdev,
> >  				   "Request_irq failed, error: %d\n", err);
> > +			kfree(name);
> >  			goto free_q_irqs;
> >  		}
> >
> >
> > base-commit: 551c722f40809618230001baccf219193e22fc5a
> > --
> > 2.43.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

