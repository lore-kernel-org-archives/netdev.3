Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=35.155.198.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794447046;
	b=RDvhjUJ1JvNMFFtbdwH42Jj0KY6zWiCZABVAD5HU6U/mOIIZ/fCDzcTeDPwco6qyqCo3
	 LYvD+cuB2qbk/1C17S8T1O9wEvZVlZI3/bScpj6YCDOdTQVwSYC9sI7FRYG4MmrL5tkT9
	 Axv6hMejBjtaIdembrrLh1kB0ve2jDQ44NOGyR9qL2Oe2EwGxxAV62rn13MeVIqZF34C0
	 w+x7aGBTg1PsbTDjhRHB+lq/fa13GDqdRXhrGv3u+pnskGBG+SJha+ogCK6O9fwaFx+v9
	 pZ3XMqr2g6yRTSVrl8O2ZP+mDqC+JhbXBg2ucvXMtRQakemIxLdWAOsl8/6TH8yV9Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447046;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Subject:Thread-Topic:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:Received:Received:From:To:CC:
	 Thread-Index:Date:Deferred-Delivery:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ynFa6BTli1lYLEdhEoiUN973/zShdCqfMmpNyL4dTMA=;
	b=zjhiTYR269slJqMmJdT7P0k5RJgo7LccfLoLlGtCZ3Cs4+J7lwHAovXJejg+P/2X7pVQ
	 D4Tq08B7TqPfXl/wtjE+WWwhnQF81fStg1e7Q6mG/rssuxQ3aqu/bQtJnjiUzNb+ZYxAe
	 bJD8DP4HB4U8bj2nLCxtkAh39FlsoVrffKIUCYo0UMrZLEUNB3+zr+r4nb6E/XfP3MsP5
	 A/+MxdBhMAQ/jc030sNTfg/NUq5BIZughAT+U/V6mYqFWwPG6zlMWzAQLJdWTKHl+bQxP
	 7h/EhB7z8RQqp9ET55PLB6BTqvyEFyBztb68wNj4+Y6q7rj/tXjhINTMu0J/yKHSg3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HKeeSypp;
	arc=fail smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5F606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC5F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=HKeeSypp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794447046; x=1825983046;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=ynFa6BTli1lYLEdhEoiUN973/zShdCqfMmpNyL4dTMA=;
  b=HKeeSyppB/ytIRTomPFITFU2qVFr5P2Egx7Z1ugVNLV/NQXHk7v66l2j
   AeRlpkNvdHqyOUDwaynGFUOidtVMuNZadyCTFZhB3+U9C/4dokiirNXGd
   kT5RhkRMeV77Ntv80+qsR3Gbj2Ftp6CnSCbdWC43S09/JhCC+aEQ6z04C
   lNn4VfDKYJCs2cRBLJX2oUX/Ip9bvQP6vW+XrQAPtqw1LvKdAwGxkUod1
   7anCqxp6ZUFIiBOi3W9ff0cuo0YQA05wt5k5uGEMNvyCmL3AqD8qlbNje
   aVv+bJfzJJKNLZK2gqABTYxh33X13jj2Xl8CUStGm82hUFvdAyCTi04hN
   w==;
X-CSE-ConnectionGUID: mdVConQ3TKut8li65lhG/w==
X-CSE-MsgGUID: 4jPzIF2STje/Jo+w04Bv7Q==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33671353"
Subject: RE: [PATCH net] net: ena: avoid double-counting TX DMA mappings on failure
Thread-Topic: [PATCH net] net: ena: avoid double-counting TX DMA mappings on failure
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 01:30:43 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:15818]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id dcc491c3-915d-4489-9c4b-e6695992fa5e; Thu, 12 Nov 2026 01:30:43 +0000 (UTC)
X-Farcaster-Flow-ID: dcc491c3-915d-4489-9c4b-e6695992fa5e
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 12 Nov 2026 01:30:43 +0000
Received: from CO1PR08CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Thu, 12 Nov 2026 01:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNfTRgABfFVkDd1hWj9+TnddCY/VOnq+dlIXaeGZFHlJ8+4ek+kKv6Rl/b7IURaEyoeisb1jphOAJX2pm1rZP2IV1mL51HMm+dOwTnMyUWNEATC/gr6mseBmJO/1MkgcB0xu7JYGLRYGS4tVpN7Ekz+i7SpLjup4yKhdLxkRiOyKuYF2mPM1mVVFMs1iuXWGkvEwk0Ibdh9njF4nZsvHusVYRPr/Uehx3nIZROOA0X1n4iszXwqrsifJJE7/LMvCSq6Dvwnqn75pb2YVGowqWlXtabpfMbs+BnOBnmYs5AY6+4x6N9pZPQ0PXN7uIHF0pM1evZomE0ILp+Sj48L9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynFa6BTli1lYLEdhEoiUN973/zShdCqfMmpNyL4dTMA=;
 b=aGrFZ6oOzQxuKQIEakKTNaSxyjLr43p2AAr6rjPpidqex0iF6SP8vFTgx2qTgnYN8EqICZ9xeGrqMGu/6vUtCaezMHfCQx9VZVyjC6IauXxQOS9LUYIzPsFNKOflJdrn+ZOY8R/cnnR+D8eSgZ7nQgf7i9zrT2mU2LrJz3OuK9BLo4fznoAvFePyq5xKO1fnD9HcJakGZ70DXJcs5XP+HFCWFzByPSMHuNKOysZF6QqX/yWuCm+Bo+BNxIyFAJenJs4DWqx8607yFKz9t8yO8ree6hDbrPVHicaiQ6YUJDebXs5UG7TMDmPJFMpxjSTDjYYN7tyzHXu83NO9H68Z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from BYAPR18MB2600.namprd18.prod.outlook.com (2603:10b6:a03:13a::13)
 by SA0PR18MB3631.namprd18.prod.outlook.com (2603:10b6:806:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 01:30:41 +0000
Received: from BYAPR18MB2600.namprd18.prod.outlook.com
 ([fe80::bb21:2c9e:69f:5ebb]) by BYAPR18MB2600.namprd18.prod.outlook.com
 ([fe80::bb21:2c9e:69f:5ebb%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 01:30:40 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Avi Weiss <thnkslprpt@gmail.com>, "Arinzon, David" <darinzon@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Brandes,
 Shai" <shaibran@amazon.com>
Thread-Index: AQHdcjX+CIZpNsYFoU6dLTvw8qs8KLcpoQ+AgAADeWA=
Date: Thu, 12 Nov 2026 01:30:29 +0000
Deferred-Delivery: Thu, 12 Nov 2026 01:29:10 +0000
Message-ID: <BYAPR18MB26005ED8BFAB5DEBB6D02B63D9702@BYAPR18MB2600.namprd18.prod.outlook.com>
References: <20261109123934.824610-2-thnkslprpt@gmail.com>
	<179444039825.7144.5680478965949082764.b4-review@b4>
 <20261111171127.7ce982b5@kernel.org>
In-Reply-To: <20261111171127.7ce982b5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB2600:EE_|SA0PR18MB3631:EE_
x-ms-office365-filtering-correlation-id: 636ddea4-ac8b-44ea-583a-08df405c8fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: xfJn3+PIGFih5nIJQXsXn+g889tb02ZWTAvLJ6UmOKGyS949qP9wpZ/HOJxzJ9u31Q7DEJqz4hct3cVVbCNLnauQFdI8sQfCCXqqa3q7Fr2lQWL1l47Nt+G972QdEO67s39znnRkrIo0UhhhMvbXtwKjE725/CyaFeDJIp5+kO0rCr2QTGGmdXi6RGwM2BKtEBPaVCiW9nThOXvNEHTBxRcIdCvZaD22BtnlxEGdn1i6297x99cphgUoS84WCiJytCs18w0n2JX+B07H+pfKeg+NhymfkOyQCKYzU19ssuQCLNIBIYllWNl4PUw+SZl2eYmFCteIomq1BiMLRU8jVwxHTHJeD0M/vT7nT0wtNBxnUjxmHqn75ayo+eElBw+W8CaXIcJtbSrCJVQOWaLIE9Dt5zEeGDmAwj0Oph3xoqBgIW4z8kdOrwRwYwP431xZstLnrlfwFBfrNW2Muz69ppPUJGdBPcPfTQ0T6jLJZx86RZMftWf1A4eNjNoZug9s4iatNtUcNqDNDw8zyxUSwFEB5uToshradfK8Pm+7VwVEjTPWmNmb1faYlI1UEjRwZsP9MzsuhKZ2AICcB2i4G4Q3HvNtCAccIG3s1Rg7IPA5Q/H+8YjxGdr/pAt3ik5my8gbPbstyF94wGWNG6SaSz+FNAyoP5750GMweNobvVSTWQDE2PCsGsj/m7rusAPOhngR2Vdi4pKaNS4h2RW0adbVxZDGrRvyVjnEq91pAnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syivzevNo+l3XRreXwl8CiwHqDPcz5PhnGMxmFcZHTjLp0xGFjrKzgZobycm?=
 =?us-ascii?Q?6618uhFmMJElcTIGYPUw6qqidHhsPgLFyq+OvHfKKMnZrnbQwE4cwrGygsCE?=
 =?us-ascii?Q?erjou6EWy0xoA2EmcBbUuwnOUBRDyjpJyId3Gziz3RlVw2c5YS4riUQ0Twlo?=
 =?us-ascii?Q?/yBaRH0/snTRd0SaMJGdQpxYiTHRJVZ5yw6NOGa10Kv6pMfaI4jbO47xJkDz?=
 =?us-ascii?Q?+AEwaaFM6qoaKh6u7NW6V2MDExe7pg8w2+PBi9WkCPtMJO+3nVJBBULeZ2Dd?=
 =?us-ascii?Q?s6XqYrjZ9zaIhOOaixl+VAF5l8dgM5xUWa9fWRlME7V5hBqKzy9DoerP6cY1?=
 =?us-ascii?Q?upvCTvS+zJzY7KxxgZKMu/l/7pdD68fsCnb6uZhPtQk6hvRMNSspgg2iuRWf?=
 =?us-ascii?Q?t7La4VB2nisR1n3Dd7Du6CN4xC9hQjD3MEB++qYgzN1bMCrQKKDLxbBrkEr1?=
 =?us-ascii?Q?FHa9GlNwy6QRw0RqgZ5V4X24FHYY1wuKzSd1fwSHvIOwzWQHjH3oR75rhIDi?=
 =?us-ascii?Q?XhdlNn2q4nIUbvQfogbJGRIEFbJX9jbHS2Sdn1/RVkrHqzZQuvYj2Mqu2gSq?=
 =?us-ascii?Q?442UfCWEaI7nqnbViKc+eZcRXmeTzWYVq35hSspRmdfIpqqDx6srRSA1lJxW?=
 =?us-ascii?Q?q5gfvGVVEMvQl3oogUH+jgfzw+jHCPiOlcXMgO9fg/VZRunU3oujneq+F/ce?=
 =?us-ascii?Q?KrnfMb7JTXMu8X1sZwxmzUP31JdPsgnRff+b5dE+Ujk6N/TNZS03IUwTzldf?=
 =?us-ascii?Q?72J46VKLzSwclyrtiHorLEhiuMnOmJlb9oEYIUaS4PHeWYic9q98BSz1WCuI?=
 =?us-ascii?Q?uNZq5OHD/h9+G8Inr+6GjH5KQ9F8HltivNKhEaz2+B0w86zjSWAhHaUnzmZ3?=
 =?us-ascii?Q?nsFYzeHaGwWT48ACiZHU7Ha5OWvC0mhHskuTceGlu1SsMAHOvg801Sf9iE7x?=
 =?us-ascii?Q?JTrZd9lQAgoS5Yct3OSrEb/cZW3HQLgd/3jhI8F7jXR5zrY2/4EtHdsqaVMa?=
 =?us-ascii?Q?YZgUpqIwNZmvVGt8GLndo1fZ01U9SVMn6LnAX/7OazFtv0dH9YV81TwfuqLH?=
 =?us-ascii?Q?t40ZwJSdjLlTODYb0hJz4fBJZEm3KCmGkvGOx/L23LoKV28DAkIU3XozKxNs?=
 =?us-ascii?Q?Q6YTVaQStThqyLiKxLW0yhxJmCVUFd39VFTKgxD9PfkJbj6cAItQ587MkXWZ?=
 =?us-ascii?Q?mY0Evj6k2vd2JLzAWOFfDG7+yx9BWYif1y35ZmGe6Xy9BWwMcKUHpK2Fnr46?=
 =?us-ascii?Q?ZBzwYkqQ2ZZ/d/ywmpqsxYxwmyPpTMCsetnssRWE4XQu1iTnZTDQwezcc1FB?=
 =?us-ascii?Q?0MyBAC9080kDGT/DsW6HpAa/Cs2xoad+vYucxLsT28D/G3g5AzI5MoN3+pqb?=
 =?us-ascii?Q?frFgurY3VX41GTGFL5VGfkILeHR8x11xTxl+5B6VC86CuX9T4i9KGpUjGID8?=
 =?us-ascii?Q?DILpcWxCb+faNS6zykWzgtrlU3la1Pe+IlsGCUfrSfaDGvSnb53PptinLl/Q?=
 =?us-ascii?Q?Vj3W/BMlqegkeiHPta28jilNx99rv8PuAKdpmFEh0BiJMiarQjZFkaTuAsX/?=
 =?us-ascii?Q?2MSfInzUgmr8RSdV2O72bqIipTY+duZpOBuhV+RZMsss5rxOlr9ksuPABuuE?=
 =?us-ascii?Q?Kb5g6QcClhLmvGjatg4Xyfecs//GOkq3SbbD+/PCj8h0yL8XtP4TNh/5Fc76?=
 =?us-ascii?Q?p2KAREhrWhPf04x7oG7kQoh0IXCjo8VDuS4A1R0IiqoYc+pts3qfbyunSxUf?=
 =?us-ascii?Q?ySn6Wnu+SYn1CLzWj3p2/azj8mEIiYkGhNdaWlkexChK9RCSOJH/fgS5CSt/?=
x-ms-exchange-antispam-messagedata-1: apZhOldbYEpXJA==
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
X-Exchange-RoutingPolicyChecked: qoekKmeeo8ladgjTpSkU08GDpC0kcbo5BtjEpu1/42NDuOXkUfblWU5BvwQ9p315sErxTVdXJWSUnRc6T0BcK5Da52SFdCJWM0NQpu86ROR0mR1DJcm0nQFVe7Ira57+6bQxE/ImXVqZe7eas4oF+XeMm8uxfSSk/+uSHkafdxNPNucIFCIH5PjAyIB4zIlNiF8et76w7JHOO1PkugsNLhgeDrefdNF9deRsTLh3WyeCsC3AMHBhIQrXGflk4fkywYzfYtP9UhV91OeUt7MNmGnDZK8i6+IfCU0xjLQodgcsOZepLjE25S8ypTT5dz/cR4obQm9QeNdG6e+gFYL8sQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636ddea4-ac8b-44ea-583a-08df405c8fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 01:30:40.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XExPREGUA0hWrdzlsQ+1mjyBh51/bWLI/vsst7zTnxNPa6eOZTyCgqqv8shTdxXidP8RCpIrbdH7C/0LJmODbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3631
X-OriginatorOrg: amazon.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, November 11, 2026 5:11 PM
> To: Kiyanovski, Arthur <akiyano@amazon.com>
> Cc: Avi Weiss <thnkslprpt@gmail.com>; Arinzon, David
> <darinzon@amazon.com>; netdev@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Subject: RE: [EXTERNAL] [PATCH net] net: ena: avoid double-counting TX DM=
A
> mappings on failure
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you can confirm the sender and know the
> content is safe.
>=20
>=20
>=20
> On Wed, 11 Nov 2026 23:39:58 +0000 Arthur Kiyanovski wrote:
> > Therefore please do the following:
> >
> > 1. Add a From: tag to give credit to Evgeny Ostrovsky, who wrote this f=
ix
> >    (without leading "-"):
> >
> > - From: Evgeny Ostrovsky <evostrov@amazon.com>
>=20
> Unclear whether that's warranted TBH.
> Avi is making the effort to upstream the fix, they deserve the credit.
>=20
> > This should be first line before "ena_tx_map_skb() increme..."
> >
> > 2. Evgeny has agreed, please also add (without leading "-"):
> >
> > - Signed-off-by: Evgeny Ostrovsky <evostrov@amazon.com>
>=20
> SoB indeed seems appropriate if the patch is based on prior work.

Jakub,

The commit code (as well as the other 2 that were already merged)
Are copies of fixes that we already published in our github driver.=20

This is the first time I encountered such a case so I searched
how to give credit to the person who originally implemented the fixes.

If you feel like SOB is enough I'm OK with it.

Thanks,
Arthur
