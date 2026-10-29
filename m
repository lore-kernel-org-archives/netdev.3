Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=80.78.11.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793261111;
	b=Eyx0krkdwzt5jrJeEW7J+HE2KxUre97LxWe9GvPQAu/yZHT3ii7rLwpAvAste2jtud+C
	 Dq5kG75SHbAdm/WnxmQh5UdeAaLi7/oyyP//W/F9h3o9J9ZN6fyzFHxiK1YVt/6OygyO4
	 W9uetimqDYHAddpRVAogz2B7rb+d41e7VWvXt7MPzKodGYUrd23iwdhP6Wma4Bpu0pbqD
	 HEmdi0xBbR+ReJe6ghbYwPXdLouvledrqWmyD1fC65cj9V4OouIM1JcvOILyjbOCnswCX
	 7cVjd2ptD5nlmkR/NQZhUDaeQerAmc4JidU6fbO04SUBTsM4R95yh5j5u1kEKogHOIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261111;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 IronPort-SDR:X-IronPort-AV:X-MGA-submission:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DrddWV32yfL2AgKsC073Wqzzv3lxxdhrbiFn/vGRnuY=;
	b=pwiFnVzy74SQXhEauGmK8y6M4GwhOfsh1mb8oVVeaD5wjKr3jVK0wOe02yWkBO/ormBR
	 9ut0CiJhkC+IUKdq1MhhI1/+0ocNOub+j8dXZ7WjAWJ12BIPK2GfmufCHD9BW9siMhvpm
	 QdLh9W+SWcvYunrE91YG4+PtbLZ1NlD9eb0Wu4N876XY9A7673O8s81IDK+k9uSYiGW8z
	 yOuIcHkIFtmImcZmBI790xfB1axcN/lhbdptCmDOUKPWVdm5S6VX/zUeYI+snSx63QiJL
	 xEMmk5stuTCm0Ou8MoSE6Pw/wmqhaFxMu6KZQyN5MQdzVp/ob7zpjENHTb6zwGGiglQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bull.com;
	spf=pass smtp.mailfrom=bull.com;
	dkim=pass header.d=bull.com header.i=@bull.com header.a=rsa-sha256 header.s=mail header.b=SlR9LOgS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=80.78.11.82
Received: from smarthost1.eviden.com (smarthost1.eviden.com [80.78.11.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E749606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E749606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bull.com header.i=@bull.com header.a=rsa-sha256 header.s=mail header.b=SlR9LOgS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1793261110; x=1824797110;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=DrddWV32yfL2AgKsC073Wqzzv3lxxdhrbiFn/vGRnuY=;
  b=SlR9LOgSIt7IrRFDM5SHpuMVkcm3TlgJ7ZEtN6FM3eLRLQK+nBvQLU80
   ixnjDZOXHZjrGsFw3rIi3tZlWnIIP+mLx2qosO+Sv+1PACekx300btZju
   BBU/e7mewpGsZx5eHYK93H3FkQrvBx9vnlVHgKmtA9iqu889R9b2vffiO
   i2dmgqBAPkUq2KaC3xUbAC4OQGzpSMmoPAM+fI88oNaz9NXjOEELEl1DD
   36N2ppYZHL4bEpWd3AhhS+Dld+dHfL4EiNx6nnHcEmhSChOqwwIliY2im
   MiHUhm+Xt+6CgaXfAYf0uOW8prz+heyr4QhmK7xDFtWC0K5t/uXHGZTmK
   A==;
X-CSE-ConnectionGUID: raGb6Yo1QqGl7yFjhMuZ8w==
X-CSE-MsgGUID: HUdKZBg7RoS5jm1iVDy1bg==
IronPort-SDR: 6ae2fe32_kIcbKuJEyxFGnKuCVtPMs/5L0uSIun3wJYYFDh7Ht5NBggw
 m4aUaaN9VgNrA7pa+oiWH6/ikimLKIJ0Rq0X6Vw==
X-IronPort-AV: E=Sophos;i="6.27,184,1787004000"; 
   d="scan'208";a="49055294"
X-MGA-submission: =?us-ascii?q?MDE1yBRlVVEToMCje+N8o+peGeVrkvw+XGC3Sx?=
 =?us-ascii?q?23zvTVKqlrDIRehSJL2M5eWJtI0zvQHZFdWOfRI21UqhVf79fKScGTZx?=
 =?us-ascii?q?9NeiIW8w6UhOIxIYXKP/5LYjJ/+qyO2j1G5FMUVcyfmQA269a740UjM3?=
 =?us-ascii?q?nLzRE1AmJacz+vieKG/R4VoQ=3D=3D?=
Received: from mail-francecentralazon11013002.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.2])
  by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Oct 2026 09:05:06 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKWOobmfBkMB0ycz8AMC4hPuvVnqPMQQn285v29MAyafW/dnFMeUBcz8YXH1psSDdd8vs1vG4tuzjftTBYr/5lGnmISLz6SeJ3RlcxLYprBCyBnTgTsQjL6ENYtXK0Mh7eAIro65YB+wNuFhW2Dpjlo7oQA+Ib2O589YRplhQzgDDMaQIZQJg9ua7ft6pcM5UdXeqmnd2kegwKvwKKqcbpThLGrat93YJVAOc4Kc5IWwekIw4Xxz/z+cz/skxiaez+0y2FkcLPFMVZfEhuNpdUEaxUfoEzomR4pJtgHlBhH5a5IHedibGuMjSi6hbY2b4q9BqAjoAY+wLn+87OMRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrddWV32yfL2AgKsC073Wqzzv3lxxdhrbiFn/vGRnuY=;
 b=bgYAnUnjgDX0ghQtDyo3Ipy2CZIHSAa454RmxrniMQNszypt0izdyRlUYWnogsuNCVDumfUFXbgUKn7yeLANGlxNkyvNJ27f4zZuUUJJ3HkoIju/UEHZ/+JAX/umKC1zGebgjecF5u7eDrstgXEjzc2IVURGiW8o4UCVz97ID5KTn5IFJv3XVHNS+sdpnkO1+7MDwZG26FJTlza9DmXqQFSVbbc091h8WnYWoFSP9TFMTz5ysblqrsNSfcQGeqRvgTKdZO39yfYUXabfNtmI9fn78WpbU9BBL6KV2mxa81KyHroLjFHQ7FbYbLwGZ2h5iZnqz0/XCeKkV2AtecvZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from DBBPR07MB7388.eurprd07.prod.outlook.com (2603:10a6:10:1e0::17)
 by VI0PR07MB10221.eurprd07.prod.outlook.com (2603:10a6:800:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 08:05:04 +0000
Received: from DBBPR07MB7388.eurprd07.prod.outlook.com
 ([fe80::480a:9ee2:1f18:1dbf]) by DBBPR07MB7388.eurprd07.prod.outlook.com
 ([fe80::480a:9ee2:1f18:1dbf%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 08:05:04 +0000
From: =?iso-8859-1?Q?Fr=E9d=E9ric_TEMPORELLI?= <frederic.temporelli@bull.com>
To: "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: bnxt_en - ambiguous timeout warning 
Thread-Topic: bnxt_en - ambiguous timeout warning 
Thread-Index: Ad1nfB+zPxRkufOOS2mQDMXwhPer/g==
Date: Thu, 29 Oct 2026 08:05:04 +0000
Message-ID:
 <DBBPR07MB73884DEF3976DAB7FB0713B1996E2@DBBPR07MB7388.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ActionId=59738401-84bb-4330-806a-899e2de9fec3;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=0;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=true;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-10-29T08:02:33Z;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR07MB7388:EE_|VI0PR07MB10221:EE_
x-ms-office365-filtering-correlation-id: c41b6071-83f2-4732-5680-08df359356c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|42112799006|366016|38070700021|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|261022105027099003|261022075727099003|261021135927099003|261021121427099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 g1jlPmdFUZO4Tjn+LkzG/X4VaBju5rZ+l7mUjrxlmRCaAhzPSq2iqsTVLlcCKmEq5ay4x5MJgefszKtdlSznRcTNwSlbdDAria8STLXkswuEN7s21xkL8DEhrcrfueE3T/uHBVpBywGJ12qigBUMoxNmXzlWd5Vy21q62o6oMUOzL1RX9ekgAFLWhgaRl8PqqHO9D1QNzQeiY2Ze5tDzVNgxSw8f93LRHHmuUtWSDybqpAGugyEywRpAkXRwmniDeeInOmQOSFswy/rsJ4k1xgOyMAWh5Xzvsm3EtKi1LKnzt0IeO8SIT6E4/wQ9bjbUz9LqpN/2D52AT9GGSeir8nO+nPHbjnG6Q6c/YBFazmDRqiODZkAsHvJ8lM/tS+dW7OIfh0zpgDsPLY4DHxiHznOij/QTXAm6VhumZwN9xhTpK8g94pEKxrisV+lUE+AtjQm5KGFVUODVQdDvOkNHsLRpgFmuK2t+6TRcrpV90SzOn2p5duiaPCofuJFaaOAV+6d5GUuB/yGjhB3qZ0pbElYF4/TNpgJkkhTcj5hsJyN26l0nv/9ZjTfBo//AfQ8EXsZ8tbVgVqX73SGXJ7ZSiIex5AWQGiWADGagOVubyFg5a35atZ/UPV8LzQ4yvENN2AfKXja62tfp6bfyCG57IUx8HZrucbgKVjj9NbTC/PRfAvz1ELL6gsJQ5Ar/euW/5fLxeRZpQBEUk/yu9EPj2hPZIa0NbhFSkuJsND0Vm6I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR07MB7388.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(42112799006)(366016)(38070700021)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VuD2g9UdUtlS7XOelzQJ1mqv8eRpkqwOBomXYIavzUMyKU/olkIkid3k6+?=
 =?iso-8859-1?Q?F1TDZJWgfhxeg8AH3F1dCd2+vdKAlRGMBlyo3InibXAql1uy4BthazBBQZ?=
 =?iso-8859-1?Q?gEy0zzkVi7ua3qnTzKGGBUGmMuTAWCPZLf7FcrXF1k6suxjSRFvWyPe7uP?=
 =?iso-8859-1?Q?+8nMW++aFctzN5r1wm7yGT3PVhEOLJM89LzETBYWkfV9tbeoyO6Nq3zgbA?=
 =?iso-8859-1?Q?i90Rx6ZgKwPZhFA2k2pbwCGB6cGAx9+txuBCU45BYOcjW9gFRTU+VL7/lh?=
 =?iso-8859-1?Q?h8fOeziIU4hFkDb1e5ymeXV467wf5zYU2hgg/y5mM3zPvgOC9IkhaSgssP?=
 =?iso-8859-1?Q?BiOuiMoVPhTbhqOYiP7Fb0bZGqLJ2uMsZdRTwgkoTG/uuF4b5U53ZKfQsY?=
 =?iso-8859-1?Q?/e/LSB06ffDHFkThpxGDzVHYzjUV6R5r82Wddg9W13eHSViaZDQ/ZADf2T?=
 =?iso-8859-1?Q?WGZOZhUMKZh5A57Lx8T+H2ibnJWnpxBE0xBtdIA1l48SFUswgs3mKs4Ot4?=
 =?iso-8859-1?Q?YG815GvQcig+R/07CfvhH3ikXs8696dEU23vudcBAGR6tcBa+AVZUHlbbf?=
 =?iso-8859-1?Q?nU9qgV6OXsC1bqYjpjBhJJ95ZLP1ObNkIqYFU8xiApdzeU2T56zQUH0Jkr?=
 =?iso-8859-1?Q?WKglnQVutQusrCgobCYE6yevj8dS4wMBQvmNvrYQyqoWkdpL7JvzGfdTO8?=
 =?iso-8859-1?Q?JbzhA765h6AnJgXmQ9SkDRyyAMDnnvYXW0zvsLxaf1h9Z+M4BtIl30L/ju?=
 =?iso-8859-1?Q?palygJYs9BLuWhSFpCN5Wf2tBbGCUgKSsZ90GH/XLXoTrWKjOU+EZl7O+1?=
 =?iso-8859-1?Q?UI19SrksVUN6SpzDpKR64kGJj5yjEgtMHdPFRZDHjnKOjR2Dr0/n9dpqVn?=
 =?iso-8859-1?Q?T2GkAU4hl3orRBwOL9bUbN4obsMK3AHXd5EwocttTTyB99dRsW1m+nh9aR?=
 =?iso-8859-1?Q?CJjixOCrledMD+v64OG1Quo7Pp2yczMSs0fmIPcjOd7nXPLX2Cmela1ZRE?=
 =?iso-8859-1?Q?mH9Ml6LWOYKXE3UT9d+krUCsDNO8n3INlK7uO2l0ekyK05huyjfFHNFh36?=
 =?iso-8859-1?Q?0opTm2VJ2VyyU91kcJ5YG5ThQ+CK/gSNfgnLNq5qDAnTouE7wcQ6hahVCW?=
 =?iso-8859-1?Q?xVLfhgAIGUChxt7yDSoM2/tbfGCVUtUEUaegWY+Bdc/1cepKxzQlsDErTV?=
 =?iso-8859-1?Q?Bx2r9dzC65c8YDsOi/5ZVcK4JNaVDVOclPDKsfZ775EYls0KLBxrwNmDhm?=
 =?iso-8859-1?Q?ZmPpZ5uxkrqDOrzqDRPLR4eOC7qabrDZNTCmu3q1w/RyypCUeWgeRm0ndi?=
 =?iso-8859-1?Q?dWOo44mvvF8mcy9ZPny+d9lPwLgnxnfm2zQLCGWBEwfX27ujb9F8+QGDMb?=
 =?iso-8859-1?Q?vPqAVL2mutziA7GbgvV1Hm94Qqc3ecsYU6XbSFN339LTZkkWStB6n/eglc?=
 =?iso-8859-1?Q?+SvGT/2J5PLaMPS/iQfww4kq0FFo6EPCIU2Pc7R65xCjDTJjsEqqG36Zt8?=
 =?iso-8859-1?Q?u7El0WnFpYiHrdH0+Cu6HhXwMrxuODckIcHJ0VRdS8uBE3xrAh0sOyecNm?=
 =?iso-8859-1?Q?u7ajSz9UI3//+Cb2jrpBJHqPgricDsYVLmPfnOnd/lQPtbVFZohLAOd5mU?=
 =?iso-8859-1?Q?6elq+xBlPpV8uXRBQ5ijInoYzjYDhSnTAdSj3rXT0TxA8V7rXEbDLwo08g?=
 =?iso-8859-1?Q?e2urJlsrdp9/CjK7ilXZ76Fb32evVnPWO91lYtJXLC2ZY5ItNswOGqzYhR?=
 =?iso-8859-1?Q?fXLRBwLSbvHJ5uee3lEaPIBCx7/mzRkMZZdEjLUTMvnukLHikVJFlRg1Wt?=
 =?iso-8859-1?Q?wVTpZ/AcAeeFHus5gBoSxZJhI2LK9/c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-Exchange-RoutingPolicyChecked:
	mQ9FLNWxMHhkvyFgoBZVpTLFAz/eju6oEnuuQyN1lssDOHaV3zM6cWnbBDyINbJ0u0WaCcGdLDBWVZKOU943UL8JP8a312UFabWyB9z+cKvaRIdRXPjdR/VVD6ACcLxpUkIBfmcHgoI8EWwVV2I4hrtNAReEgZvfNnpYtimOb5w8XykfMcj3wHuFLXyLI6bqS2okLRVwLs4fGP5pfe5LOLZaBEWCmnZSFE9/htsnNmEvlyReQhnS5uxbZpv41QL32xuOjadPsIcDIkccwqla5VJUIyXNkSrfGUlbh4Kgrb3J+mjY/oziHzhkLsbxu3XKHzu/YSI9EBaoE9Zchfyxyw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR07MB7388.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41b6071-83f2-4732-5680-08df359356c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 08:05:04.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F41mSxjlmkoqxXrjh0THXvIdIzJFuCiuTUgwZZhvPsS4mV62Y49fvhcFec2WQQeWSQ4gbAWrEH1GIKUJusGE4SgVPbRya+QTs51wm5/g/go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10221

Hello Michael, Pavan,

Using Debian Trixie, I can see the following ambiguous message when the bnx=
t_en driver is loaded
(NIC is a P225 with latest 239.1.168.0 FW)

[ 1381.294010] Broadcom NetXtreme-C/E/S driver bnxt_en v1.10.3-236.1.155.0
[ 1381.310464] bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): D=
evice requests max timeout of 100 seconds, may trigger hung task watchdog (=
kernel default 120s)

This warning is shown even if the FW requested timeout is lower than the ke=
rnel watchdog.

So, locking at bnxt.c (kernel 6.12.114) :

#ifdef CONFIG_DETECT_HUNG_TASK
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (bp->hwrm_cmd_max_timeout > H=
WRM_CMD_MAX_TIMEOUT ||
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 max_tmo_secs > CONFIG_=
DEFAULT_HUNG_TASK_TIMEOUT) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 netdev_warn(bp->dev, "Device requests max timeout of %d second=
s, may trigger hung task watchdog (kernel default %ds)\n",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 max_tmo=
_secs, CONFIG_DEFAULT_HUNG_TASK_TIMEOUT);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
#endif

The warning can be shown in 2 cases

1st case:=20
when the FW timeout is greater than CONFIG_DEFAULT_HUNG_TASK_TIMEOUT
However, CONFIG_DEFAULT_HUNG_TASK_TIMEOUT is a kernel configuration paramet=
er.
The kernel watchdog can be modified at run time by using sysctl kernel.hung=
_task_timeout_secs
Shouldn't the FW timeout be compared to this sysctl value ?
In the same way, should be more relevant to display kernel.hung_task_timeou=
t_secs in the warning than the default value.

2nd case:=20
when the FW timeout is greater than HWRM_CMD_MAX_TIMEOUT.=20
There is not detail about this test in the warning message (so the message =
related to watchdog issue is shown event if there is no watchdog concern)
HWRM_CMD_MAX_TIMEOUT is set to 60000U (60 seconds) in bnxt_hwrm.h

In my opinion, it should be more clear to have 2 distincts tests, with rela=
ted messages:
- One for the watchdog
- One for the driver internal HWRM CMD timeout

A last point:
Why the Internal HWRM cmd timeout is not set with the FW required timeout ?
(in a dedicated variable, with initial value =3D 60000U, then modified if t=
he FW is requiring a longer timeout)

Best regards

--
Fred

