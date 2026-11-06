Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793951011;
	b=mMw/XpNuAc8a2tbMrH6CpMp6sVt3Fzmma8yrYc9usFHE58RKhQvD6e7DXtob8GSY9hzH
	 O1AeZ1jv1s8ikyEi5rSa8lFCOjH9mPOV/ePWJdolxRTEeMPGA1PfHTDvpuqWeXaQCA/XA
	 1VMKvspXSgEv9N3Lzf8nj+0iwSghnv3Ifrl0+mCyfFa1pxOf+VvKL6mY8kn4kcWEWyfeX
	 /yVst0bDMdyxDRzm3QTic5TNZ2fXOgF6yauMtRPj8m7c8fYv6iTE3M9yHvWRar34z9h0e
	 aIQGQmZSgLl3Watx+xCsZInzA6Q82ddTNH8Kc+adeFr2ScAHeXzzZRV8v39IhRcXDgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951011;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zl9OfotYVvTtzQan1W1xiqny0M9mMMO0jb1czs/FIjE=;
	b=G6E9LARkQpS7mCiLrqAx4RvrUlgTOKKPETSXjSq4P5tELAjPOfhHm9fMVf6uOly3pk7u
	 meJMMns+P1vNt2WhigMVS60XqZHBS3XKwGStfGMvq0JeUKfNUidR1Fzm3zs+EuMt+PiTy
	 q7PAvZY+dl7nRpbf6tNmRErr4zSQ1Bgtg637XECnaCvLQQbxjNb4TVX3xSZK/lFBF3mXI
	 w5q2TFa8AXtGXftVREW0Jh1gK5dUHXMvskhkdLJAn0KKtrr17E7nXj0Bdu8KRfAz9BnbX
	 Xn6AFp75kgyiRB0mIUJmZpg/K59wRfTvQZg8iTMk/Mcz+70qYUDf0cr+OKbOOuozNEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Sql1yMTK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.29
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD3606A326;
	Fri,  6 Nov 2026 07:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EDD3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Sql1yMTK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw5CqWBt+ithoJPcrhX6mQpHErsaW8vK+RmCL6D1WZMgBaCTkcGe6Ex79KKefe1Z/AzI3qvr5C3TzxbVEUvI6noR1fZ2mkapnpxMHbfswCVNZVXRLM6CsaoAaJtaVFNx13HtIjQR8ZRuKWNwU4B4RFRzHBoCsUe2YAN2T6ZgxifmifNw/7GFJUo4TWWBQH1cNxifaPZzN7+8nBXVHS0LTRJb+ZKwpkgDAdCLuK+u7wcp+lnMrKN7kdjSfn+GIL1rwYkTc0fCNQQUqW0tFSiQIuR6FgDAZIdFBtImSzvHCTMsG3ut4sZHvc7SbCnXMI4xGBlrPDnM/q2nGGare2/yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl9OfotYVvTtzQan1W1xiqny0M9mMMO0jb1czs/FIjE=;
 b=F0lRyvbbR2odDVG2Jl9bzPyUBxJltB915//vsBFqq29Inz22S3KjPOSO8jAsH801X0YBdouk/oLAm2aiEoGzCehjEZL/661ijdItJ+0pPu1uIkyjcPRnF0qEu2ZKv/CMRl8EwXjeCB0OI2uAVOF+WocFWCJfMflxP8An7ZCo0Fszop2EBT4+bErB/y/cYyEuH7XiuK7HvPiyy07raWSLPM6MET0Yw1ywlKYYQ7rdF+9A3KlZ1/BF08KHWgsiPpf8ZCgZkPcv8Vz2RD3W0Smtf55gvLrIqZ/L0pRHO4nY4QxKzqdNgHe6d7jRTYKIeAvn/yyXRQkoMR1UbGsfDK0wvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl9OfotYVvTtzQan1W1xiqny0M9mMMO0jb1czs/FIjE=;
 b=Sql1yMTKsPB19fvQH8cZIZvGZq68BgiNP0cBYWCtpmSeWnG+tKMpEMF6ZKWKJm7SXpwaxHvtu9HMUG2ouw05mC9nJkFIoJqSgC7gpByyOY7H7xAWghAfgyawZsiKANqxVq6o3Z+Wm3OespFOPtUZdSkVq9x3TxCfPHnWTEoc06IX89USJKkri3tE7clUh3+ACJc1VI6cKdtJHsDOI1xRxpSpqKU1CfqYIJWs6akgGQziE9YZX27POmZXwSopof3tZTJbJJ2RkjjWkdJurmGiuxCGz2AzcIsqXKzomDKZ0++VUMuT7Lr8+ahBJ26ZlDI6x4kEYBYYnWE+yfNbZWf/rQ==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by VI0P189MB3286.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 07:43:26 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 07:43:26 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Tristan Madani <tristmd@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Tristan Madani <tristan@talencesecurity.com>,
	Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net] tipc: fix division by zero in perc()
Thread-Topic: [PATCH net] tipc: fix division by zero in perc()
Thread-Index: AQHda+ZOND8yQ6lV8U2dPvbaxh8Lu7cgq4uA
Date: Fri, 6 Nov 2026 07:43:26 +0000
Message-ID:
 <AM7P189MB1137B9E090001C1A609C2E19C6762@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261103225433.2663943-1-tristmd@gmail.com>
In-Reply-To: <20261103225433.2663943-1-tristmd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|VI0P189MB3286:EE_
x-ms-office365-filtering-correlation-id: c6aacc42-7e5b-4714-f222-08df3bd9a4c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|6133799003|38070700021|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261022075727099003|261009223027099003;
x-microsoft-antispam-message-info:
 uKeMTqL0Tqb3l9tJk8pZngCFd1A9X0CjdLVmn6BNWZzP6oE3eVlVMDBz8ndkeCicfBIb2OdqcYA5CLWnKz5XOv808uq2ZPgXHLTG0aG2yi858zeKeUi/alRrA3v9Ja8baVi7vKSuefK1Dd4KFDAh/y7DcKLCpjCehBjtCCo1EHnY14iqbQw45kySRPgg3LGAt4hl5FavyAO/xDhaGkFecLyiCAjdhlu5MNYJcyvYwsBm3itYP+MJ3M4H/P2bt0SGiJm3qXotdxIcyVnoKEFAKSTVIY+Zblhc1dKVjQaWinhoYs8RE3BLoId/JZMeQhg1YGecDY5rYdIayvU7Ay94R31OKIeckDO8N13xBpaE3sKQyPh0oL5HxEDOpu0EH1brFfeiYQQCsndvrEgUnr3qvBfr2AOvQc+wvdnH//7cXnvQS5ZudHjOjc9zSIrfHUrQ70HdE/uhlotJHzhTG3emgV9421iWgmB4M0+Ctuewj6+xPumcR/U4oGRb9F0VHtdfSGdd20mmZG3yi9uUyrUY2Hk4RKp+pLGwJIv3qEeMzaZPUNm4Tfy+mAwe8CmWy/q6YthFypJYoxxcNqVFIKGqpfAMjJk0aMY5PIPjYjfYk9/RNmToiY2LaG8Yd2dW1y3TEuFvA83psVtHj9Jg37ZhBI8JkCn+9mgi12IvCpfs5aOVx6g5Ty2VtV26nWYZ+06F25hODti0K9rULY/3oVRly5NDF88hePexc0ugCiV96Ik=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(38070700021)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ovLn7groFUWb/PvT9lAb0JjZAI+QsC1OfRiYsnKK9f+K77+la6rj4cwlspdZ?=
 =?us-ascii?Q?DpmZ66YT+QXsr+wLx+9YKwMsToy43o2kCggJgJB+3QSIR6rz1smeBwe4OiYm?=
 =?us-ascii?Q?wEUEFmMDmRgpVlzrV+9nqXKkCDQx8/n5TnsJugDMig6uBwo6S99emhr/FOCw?=
 =?us-ascii?Q?r6xwX3og9LyPfJmXdYplzVbwW6oeHnd+JI5ufzo6+ZPDTSC3LCPH100aROFv?=
 =?us-ascii?Q?6Miax6yRilA20bac+YekvdXgEAS30HxMYoRUyxfSLygfuPs7zUct1IDgGRzQ?=
 =?us-ascii?Q?P+nGBVXrENqkqjgXfhSPluU7V7fNnVqATPdwktPLlJBtn6s4p54vIclZ9OEc?=
 =?us-ascii?Q?RuIChNVMMRyGrw21BQHucXAQGssg9zSqSzYbnHvObKVXDEQp6EL5UD5a4EHy?=
 =?us-ascii?Q?Le48ZUSxGWpFsuYrUp+/rgHHRC38a7UiOZ53bWcdQNRv/C56633/G+39ONlI?=
 =?us-ascii?Q?HZ70JwMgRaB9HUg4lReKVDHuTj5WfdQAHo6OUuWxYaaoYsNGn1/XFE9ZBUGb?=
 =?us-ascii?Q?Cvw4D8Yg28WQ5PE/KS+aB60Uqoy0GrLLIkgYVRQVd3AfGliuES86dFaQZQDh?=
 =?us-ascii?Q?6qriYUFgQ8Ogj214yIc8px+WxkVoOD7wX8LnjI0V1HuONfc5CQZ0rUWU5z7b?=
 =?us-ascii?Q?vaz53uF4JljhOSoiZDg26rXbbnW3gisbiOvw7dQbPBHyc+Lu83IncAEwj6in?=
 =?us-ascii?Q?TvkPX2W5gdAfbgo29VISaIY9gSAamHZCBYQJ8gKZOJEH0ihoEFfn0xkT+rQA?=
 =?us-ascii?Q?ReckQ0KE4SV8H9CGCwjzsQKcGgIWF2crB/YpMxjqBujm52gk2LCJXRdeU9Id?=
 =?us-ascii?Q?gEWObe6D3N+2YghQt1iadSQ6JTbg7saFbzjzCJEBn8YRtuPCJAk6MuUT4053?=
 =?us-ascii?Q?CtwefWiEIw/Ur2oY1xHa82zakSRVO/eNkT2zsugyO9r/vhiuwbCBCnGWInT1?=
 =?us-ascii?Q?Op0Tc6cMbBVoPSzRQZ4yIRG8xLLa2A5IHZKNXHdW/T+C8pTLqTOciIUjHjDr?=
 =?us-ascii?Q?TO3GLHkXOsMLZmFlmo5OcDSwNhZEUj6inM6f86FKCKnjf+vGJNWnlTUfiOyn?=
 =?us-ascii?Q?0AWWcOmUtnFX+nF0hjU0JzKkeY0c5cWZ6zZL2Gz/a5IV8yFtMbk3xtKusrrs?=
 =?us-ascii?Q?zs5M9wx96DWu6tfOYF39YYVbzRSFoeo7pPKpflArCIeronmAZ6r0b/8Fc1n4?=
 =?us-ascii?Q?XdiTGgNbbx1QmLYqfnRrX6IwgqqOWX00cHQukf7M9PNJNHBD6O+fLY/p98kc?=
 =?us-ascii?Q?PUaQ1t26VTaC5em/DKZotXtOzUnPOPXRhm6VpTCXN5Jb8QdpRxUu+T7s4DhP?=
 =?us-ascii?Q?WZ63pRA4DLHHnstX8RtHrlQ2NlqXGH+ZuudUrxqjOhKnctk8BoC4jBYZr1eH?=
 =?us-ascii?Q?c5mGGjQ0spKLifknPduFR+3k0/tNtdgigyKOwQlIyVFZDLT8eAn7ONb/CL5y?=
 =?us-ascii?Q?lH+nlXEgb95tThrieNvurEbrULDo37xPDVVK/XSABFW6ht6fqhNgHiVBx+J6?=
 =?us-ascii?Q?j3P6/rDyv9Ttt0jsgyrZBDZPstx7ui6dBwXV/PJ7WBkBT4c7QFDjxgNq7swQ?=
 =?us-ascii?Q?fVzVgutBcCXlncVOWLYyah1ijuWjPAGnA2EydtjKUujTGalhNWVFOsrOWGcj?=
 =?us-ascii?Q?hZRoci0bxc9CGMIRnInFVRUU26ds5VESyD/yTYJUF4SVthcC1BpjWw+FcgKT?=
 =?us-ascii?Q?cACChLezKBkbF9OgeObXYI4qbezpgnJNssydLnXRdi+pgENIDzCcDza87Mk1?=
 =?us-ascii?Q?LeLLeJ11RA=3D=3D?=
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
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aacc42-7e5b-4714-f222-08df3bd9a4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:43:26.7463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AY0z8peZb2pKzLvBB4c7h+QnkmF7tS7YoMG/PCFRK4ZPTcJIRdfX31QicP1CX/700maf3Pk2fhWV7yy2Ya7j5uhRo24c1BOWWro0AxmQsmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3286

>From: Tristan Madani <tristan@talencesecurity.com>
>
>The perc() function divides count by total without checking whether total =
is
>zero. When link statistics are queried on a freshly established link that =
has not
>yet exchanged messages, TIPC_NLA_STATS_MSG_PROF_TOT is zero, causing a
>division by zero in tipc_nl_compat_link_stat_dump().

As sashiko's feedback, this cannot occur because __tipc_nl_add_stats() clam=
ps the value to 1 (as minimum value).

---
pw-bot: rejected
