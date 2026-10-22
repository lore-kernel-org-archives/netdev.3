Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=18.208.22.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792695076;
	b=g+w6CAQUd6/2TpdkDIHphs/ijWy61pkb7RQuUdFUxpvRJeMnB4J8lY8jrTOnRxE9yI6x
	 dGnAqtGLo/9wpUN8ck7ZoeYQXcaPhQaRPIwZwsTG+lxHHSJt++Xte515nQA7rOp86sYSJ
	 Ksj4QEbZwqByOCSKoQV9wABrdnfelO1OKf7edkZJoPSoZsSHfau0v9xxlM49wFKRLFRa4
	 vqkpdNVaTQdrdGTVEhBpEqt711Xe1Z+Fq7Pl61hfALxP+KK7qGH/7EhHjIZY7jQZPoUzR
	 6WedCj2mearw/v1f2rfNg0UcE1++zCSpkbjs4y6HFWVJi/HqpesoNN1/gcUMwb9QuWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695076;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Content-Class:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-TM-AS-ERS:
	 X-TMASE-Version:X-TMASE-Result:X-TMASE-MatchedRID:X-TMASE-XGENCLOUD:
	 X-TM-Deliver-Signature:X-TM-Addin-Auth:X-TM-Addin-ProductCode:
	 DKIM-Signature;
	bh=VfpoWI5gO0BmR1VZRnPWH9CvRA9jKKy70nfRztYnhJk=;
	b=Z43f/f2IxNIsS8HzYPjkHomOs3nSF6LRAxoO7+kyYGbDJHMPJ5W9QA7jaSmeX3X1CeMi
	 Wai7T5bQMGk6+rOhD4ku7ah45K4t4cs2wbDfRavlxFTIWu4jMhD6g8xnuR4Jfvn9PyRrn
	 ZDzgF4od5d6YtBL7nmzSNouihwkBDVjO6Aq44cj63oLnrBy4GbYuGtZ8l7DjWvMyv+zvf
	 hPqKqBAiMAQ6h0xZ2LJPldJy1Jwn0h/O5U6mjaUsv2RPeKY/hAEkHkyPsqFkC0iGL14Jg
	 vBNulnAypM7Mi29eK/IJfVyZF5hiimWXPbN1fvrIotVUZGV7acqh8AvRJ3I1O2T/YGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trendmicro.com;
	spf=pass smtp.mailfrom=trendmicro.com;
	dkim=pass header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=fHjT8+mH;
	arc=fail smtp.remote-ip=18.208.22.128
Received: from repost01.tmes.trendmicro.com (repost01.tmes.trendmicro.com [18.208.22.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F207606A319;
	Thu, 22 Oct 2026 18:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F207606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=fHjT8+mH
Received: from 40.107.208.69_.trendmicro.com (unknown [192.168.207.199])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id 3864DC000A0C;
	Thu, 22 Oct 2026 18:51:15 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1792695072.316000
X-TM-MAIL-UUID: 6701c291-6ab4-4faf-a0b2-66dbeceac0de
Received: from PH0PR06CU001.outbound.protection.outlook.com (unknown [40.107.208.69])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id 4D667C000416;
	Thu, 22 Oct 2026 18:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgbjN8ls71xWPrSW4yojfSlc7LGj+mfaTDPEd52qzGdlazmTI+Yq/pHl5UE9hJq/ID77zfJ9KHQcnBjmsUr52I/FFdX6hupd6vh4h1YPx4QbFIZ2CXzpP6Rw8wkqFXPRATyz2Nnkav3Rxk+p/DZGdY8eR0G6opEX+R8vrY0EoG5orBVfllZ1RqclmYEFeI17ZanCjGkh/WjEJODbZMQiF0O0xE/7YaygGreYbNDX5xSHAmHX4ZJAJGYLMUSViKxIKrcDlXc2e4AxMyFZkdBy/LF3jOAOT0NO5NZ0dSSDcqHdDrkSiv0R+ZszvWuzIR+2iDH8kqtCa9QcZsQu2VKKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9L9UShH+4kee4QA/2zr6D7jJ8vugSjwPulRbm/j1eg=;
 b=npYs8HeeUBh1zDW/uwSBbird+wBMYkEEamTYV2OsNRwn6zQycud2c2IhXY3a6k6cAFgXuV0TVx+/FrZKAcdyKamQuhYqqFWOAj3NBUH0GzXip3tQphAuv9h/oEPfYCLSgdPOyrI/m4sETjZ80ZFcM3SaGJ8J7rrxnKk9sv5iYtjEBSOsqtQu+Cjnd2u8s9/9Sd5mZxWasSvrVjV1v85mEz9nT2Jp/h5iGuMXRZd6i+eRAyoCeHuvT3YyWdzDlfoUyyb1BBpD1hYnURtfLN+VrzUXUnJ5BDfiFw+i4Um1ZaifnfCWwjXTXVNxp/BSVo6khoeoEnNDoWb0V/O9cI+/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 IA3PR01MB635414.prod.exchangelabs.com (2603:10b6:208:704::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.2; Thu, 22 Oct 2026 18:51:09 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf%5]) with mapi id 15.21.0569.000; Thu, 22 Oct 2026
 18:51:09 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: Peter Zijlstra <peterz@infradead.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: Eric Dumazet <edumazet@kernel.org>, "security@kernel.org"
	<security@kernel.org>, "maintainer:NETWORKING [GENERAL"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "open list:NETWORKING
 [GENERAL" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: ZDI-CAN-33367: New Vulnerability Report
Thread-Topic: ZDI-CAN-33367: New Vulnerability Report
Thread-Index: AQHdYj7XQ8689U8cv0S8C9Hz4FB/0rcJzKig
Content-Class:
Date: Thu, 22 Oct 2026 18:51:09 +0000
Message-ID:
 <BYAPR01MB383065E105701C81A3D0472D80652@BYAPR01MB3830.prod.exchangelabs.com>
References:
 <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
 <CAL4WiipTihtytPEPj5cSY+=t9NwRwRTfUQ_efCSWPT7nQ=0K0Q@mail.gmail.com>
 <willemdebruijn.kernel.178cac71d218b@gmail.com>
 <20261022160251.GW2009045@noisy.programming.kicks-ass.net>
In-Reply-To: <20261022160251.GW2009045@noisy.programming.kicks-ass.net>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=7f757664-9fb0-4682-912d-f5b1ac532873;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2026-10-22T17:14:13Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|IA3PR01MB635414:EE_
x-ms-office365-filtering-correlation-id: 09c64561-580c-4f68-61a9-08df306d6fdd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|55112099003|261021123027099003|22082099003|10067099003|4133799003|261022105027099003|3023799007|261022075727099003|261021133027099003|18002099003|261021130227099003|4143699003|261021135927099003|11063799006|261009223027099003|261021121427099003|261022113327099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 qaILLK1nvRVBYpg1Hs+BWPN29mrVSCslk+xpirjMlNkTCJwhsfuDP+s+Vp58R49pHkI5C/1OnUje5jhwlt0sljoIjQHMqP9tlTU1ZzdtVx2ykKLQZL26sQiXSLcRVdzg0ZJqJVPJEYR7uPUhqIGfeDR/mYPMrIiVgMiGIuI51s2Y1H7moSMJfXQB8tzpage4NSt9VRUFSwl3SKIq1WA87FkJz5yu5sz4M+EXwDWyxERBCrTFM7cQkqvPYAhNwgVn3tqihNLsG+gyVtvLg/gjbcdZ4SWJFS5QWgEDf9PxfOHltlLVbA56MEsfgUze6pmB9EWwFElm7QuUKDf9ExDxhCNvIxVfXCGyMitvwhkYloH9/sw795GFAuVR1zCBStvIL+f1pT73phptIfK47Ti3FtJIC5SKEal6+JzMi/55NL9ySaVHaT4LRiYQqsR8dflfAUO5cBp3GZSXEl6xx3/Vd2pMRd3ZIN+fKsmXghCpHjICZruKJ5WUsvsCRkteNflYs3Xv0ZaGP9rZJe2RSeKP3iBWniBncbejXpdVI++F9YJnrt+mKVmmTw28LWqs7UENMLfmiQZVJ6TIjOI92CMZL6rioTOz9qTyw13WW3ovloV0oR/zprH+WArKE4W4HiKvwugFtlRPPfE2l6dRDJvI6wCEVQChCktLIAhauqWryBffhpeJi7RkPGyNzzQnc3f9JdvGHluC2F4RrT24OHtTZPJN/xiBDcC9/W4c3cbe1F0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3830.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(55112099003)(261021123027099003)(22082099003)(10067099003)(4133799003)(261022105027099003)(3023799007)(261022075727099003)(261021133027099003)(18002099003)(261021130227099003)(4143699003)(261021135927099003)(11063799006)(261009223027099003)(261021121427099003)(261022113327099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xeyCEoNP01/adHWDHIs9XiKzqzJcYyb+lXjNYelc0CnxR+bnFOA0jbjE97?=
 =?iso-8859-1?Q?J0UMgAhRhROX0ZLPRy8EH97LdWGkY00ed3wDXyA/g93Zb5CejBT/yDt2eO?=
 =?iso-8859-1?Q?9+eRi3LOXi5rsckmHT1DN97VJ5QDHO+AOUy3eotk+PwZYabS/K41MMrKQ6?=
 =?iso-8859-1?Q?0cO5OPniHN2Cl2ZfvBdu/DGbYCBweRGlp6eocR0/KnvsXe949jg+FXqXq4?=
 =?iso-8859-1?Q?qf3nlscD7Y1GMpkg/8gkkm6J91p9pWuou1Bv4t2u9BhF64Iuw8S4h3HZZ4?=
 =?iso-8859-1?Q?GYDpH8OJFGS8a2tmGHyZo1wclUpqRIU8bIqyd7pa0OnYAFifdA8PnUNcHm?=
 =?iso-8859-1?Q?bd+tyjdylUM5qTPOgUdAC4bI3CT1H8izU29Ok9CknIV3azcS4PHfRfhV/6?=
 =?iso-8859-1?Q?D2AJ3Jn2ppyAn/jA95wYvn8n37UOT2fhdICdRWnmXhpO/ZpMVxHgZvAzq9?=
 =?iso-8859-1?Q?XX85iImjosEYBvZvTVdtBvKenrq0YaC9PlnE49SfQpXsmJKj1s3xQ+aVEE?=
 =?iso-8859-1?Q?92j58rb+2G1CUtd4Pu4/WAABocsQpM/e4L0w/AOoEaOQEWeuGLh+5aAfCW?=
 =?iso-8859-1?Q?+t8JUp5epvzyl4sTpwVEl+HsHqyn+SkV+BIRFaQHCoo1etGt4RTlBLMgfd?=
 =?iso-8859-1?Q?k9f2vbYZJrodDG0LSMABtiMfmehBzWTWWfd+fkjH1QtaKPEWS6tJANbJNH?=
 =?iso-8859-1?Q?YJXyWZSZtbSz7xNmL9UT9DXtSeameFbP1xltRVOrshq7ULT4W8w8umZcbW?=
 =?iso-8859-1?Q?Mn0wQ59WWR0LPLYKP2vgdajSx5JC8mR9x2BtQUO2BjcCAsPuRWB5UfTGGx?=
 =?iso-8859-1?Q?0D3wKaSa0j06y4So4nzXgh08s+2ZgBpoctgcRFmp6R6Flx+Clv1L3oSKVk?=
 =?iso-8859-1?Q?nndUht5Udra71Zmst4gel1OiLxsgjdjGXuLC2OYLbhq0IjpQGlrkuM/7Bn?=
 =?iso-8859-1?Q?2jPAA+/r+aVVUvvl+TRr/J4a/WPIDuUvFhiCSSyYwb2DuobqTRK8mNkKyP?=
 =?iso-8859-1?Q?CNt26Jn9cLZ2kmI73oT5QfvmLVa77JmM42vg2KRFauWAo/kc1+xF7YIKA1?=
 =?iso-8859-1?Q?zyUB/dxTvU55ctRjhV4uFWyTeRn+rUU7j8kMZGU9LfQdiKVODCaUl7wYB9?=
 =?iso-8859-1?Q?aN4JoKlmRYuZ6HitZQdutihnJ6gSjRdt0xz8wlWGu8I8VHTTLQdCd5FL4f?=
 =?iso-8859-1?Q?mIGULG/jWT/VurQvzCb8aLy6ai1Pt7T3g/tnuHo2jREDg2d9ZHKbTtgOhb?=
 =?iso-8859-1?Q?NhkyuFzEOireKWIxyf2ggksqAldcKH2gfiId/HOkfKGeXsWHcJNc8xVVmj?=
 =?iso-8859-1?Q?rXWm+62tcuOEnthtdGXxPXlCKJ7Pn6wH//kZ76uynL49/Ivd11YmqFySZr?=
 =?iso-8859-1?Q?T0TXfHG1qp41mgLX4YxZ0x63WsLC1WNFn3OoguA5tPDZLyXjFB3p1dHTGp?=
 =?iso-8859-1?Q?ziEv+74r91YQHpOOWX/bXiK1eeZyI4TmgKqDqX83JQ5EE8tvpnyTu/Xl0f?=
 =?iso-8859-1?Q?grCiBEePlx2iG7lgmmmPeAq19AyHW6lF5qtghypGgLOMv2JKR5w40wmJ5w?=
 =?iso-8859-1?Q?BeHSzWRC/dlIxND4/DF3GWPOQrwscYGEAkUXYzdhWpcfxlNdF1W+1zX4hr?=
 =?iso-8859-1?Q?ylfovm1M8SpV6BdJU78GVQofhcdcB1UML6p4Z2rEovnK90BI+hO3UqxfmI?=
 =?iso-8859-1?Q?dcL8lZUnfLhMye6XA9bhbF96MlXiG80kg0QBdaitjnfOmYaehrq4NeCiDY?=
 =?iso-8859-1?Q?vemUM/K/7hR+7m1iswcUjhlaxM8+ja+Tc0C0Yr12R2Ath4HSoXNFyTHdbO?=
 =?iso-8859-1?Q?7TtR1N+ZIpy9Kcg1Mk8+7o6Ayw7crxo=3D?=
Content-Type: text/plain;
	charset="iso-8859-1"
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
	y7EwRWBYZXXfBlxkjMZupJa7kX2XfJcW8H6jRqtYa/2Ux8WGvojNJcok86IwNIMn1pURB/HewFOO7+6SImdVQCScIGGr6Kghxvo5463SL13HW23tQbMYzyQDNGaEen6lBz5dADfpK4ko5VT2r5udajDXwM0gyj+GdbprbJdoD8uyeY8PXpWgBk1L/tX3MQNK7SjyKVxfix0aoNUeEzQS1j1g6Uvpvy3xOGalLERjcZ23nci5MsAajUGjknmkDrz2mUxAw9HTtk7yKRCt5ToKuvslUTQ53hJ9TcGE6VUzD0qzoURs3eDKpbQdOgAEj4eAjWelQE8IyXghTDVnURNseg==
X-OriginatorOrg: trendmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3830.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c64561-580c-4f68-61a9-08df306d6fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 18:51:09.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vt25wjUTDzrSlxTV+jObVvkEBv6GWzckemNcz0TcULjaDBSx48JYhAN3+eSy+a/AduYkPGyXLoKey/+jUVd1MzBcn+gOGVtYIsptMhGnUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB635414
X-TM-AS-ERS: 40.107.208.69-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30274.001
X-TMASE-Result: 10--35.349400-4.000000
X-TMASE-MatchedRID: wBc3mSF74/w9AUcVR4lIKSyIz3xZbkbDW+YYYmDUZuArwvLze83KAg2J
	SRqdWmN4T0cEF2VFVOfGoYUDG9SMLwHj756od7daW2WdbeDqVefDp2hpR8trdS6mliaO92Zpmjd
	mGhl8wJwZAkBfL6WKg5F0NmNURyY3wui2PufQomvHfwwbjh/dNwoSarYdbAHqyGqSYFQOYMUS2F
	/SzlmgItomsIBbwAWUnC4YJYGJnWbOROzKxx5f0XdhnqKHf982byUMAclB+jh+Z55KTeg3iUXOd
	CZ4VKyUvSGmuqUrP5a+KlbpCGW9I83IMeNw8E7cYSeYCPz02mk5NrjESsdl9/pmoO1x9E9p1ptD
	JNM03SQ5OUis0hWb7k1I5kXsVVx7bsT0kBZNrmUAIpWVOru8i3ADCJNicMiESRTwXIGJhSInmaz
	bPtwhmCJXmhrn4XKZ91Ppe+kFCID/ycTV8hh5NCTufEFUWmNngO3EWePJAhxbxA259gAXTN4usr
	JIeOJBgEHpYbknmj4VspBGKQBEwoZU9/PuRKPdpJgUXPcinGTJ+MXwxLqnFUFGZQj4DiD813jor
	cAcgVPYeXOEzfM22RJvRZeTk0APL2Hq16NTtQPG1vwbihZ6e3GDuy8y1qkuthRFAcCnfMqUTGVA
	hB5EbQ==
X-TMASE-XGENCLOUD: 9633c140-f825-438e-b84e-c81e72657fb2-0-0-200-0
X-TM-Deliver-Signature: 61709EAC13819E8F497FFDCB7404A3F2
X-TM-Addin-Auth: BacppEYetuvrIRrCv1y+Rzw/CV9nII1ryBGIvP5QLqdGD4YqGVKCztXBsSe
	BSZt2H4RmjSciGhEZ70dlImfKNlzGmMa9Tf7k6U/F22uMvgwjA6dr18SWylP4iV2m/C7cnHIglh
	K7+6dIPE3waFnGe9YQUTFakzChMUTX91bIW5/bZGQTJ9LUIZcg+KhsrzkFnmsjPhXcmQNqgnpal
	F/eGtyKPNPMbVCExRAj55T5y1EE3Q99X9grAPv2s0x+oVBd/Fbt1+0AWEZfv0CDf9egFnIeBBqP
	gvmszWAEDkRwqFkgUp5U0rUySKdEpsLSUglHEA2opZyq4BiupDKe4dQ99A==.WswcRtChsU5DAD
	p5MYu/g9F4LAD+FsRBRKmTJUzEKLhsU8ihgdnG5tH5hrLF9SQ3RiV019OCAdAy6t4r3omjmzSMy
	bxYEntBshStwx0ZpiwZ1e/iyzpx5k/G5QpxsbgGNQ+sPzC92fKWej1EjpMLudVv9Rztx+WBxcix
	gsSdOj0ZgJWYep8KhYIBE78BIQSQs/nI+F8TrndQFgT0zUf7sKagrLP82i/7Mwba+K9imvIpyCM
	cBLqzWSlF4q6IboncpeEq3C1ViATRf6uwhzyPvqXTXo4LV7Y4wY/gjGZvCjEKc3Y2j4WYj1twRM
	KC7IJizADFgAa8YI3dbwfmovQKXg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=TM-DKIM-20260724121021; t=1792695075; x=1792867875;
	bh=JRuKyt9U++tzjemHIRRf48JrLxQ5fgF168hQ6u+uhog=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From:To:
	 Date:Message-ID:Subject:Content-Type:Reply-To:MIME-Version;
	b=fHjT8+mHENvfrduWUCHcM2qzkCi3cOGpSTnrShCc4J+SF29Grg40Yy7p/zzhZMcGo
	 0sxy7LG75xvsNteGkQGGEv2nXXmIy9uD2/8t8XnW+eX0tVZxY1feUMLJNV7E3ztiFO
	 EKtqS/OcMlAWhcx25fwRNoWNm98nQEhjmh8Ho972icj0ED3EF8Oi+pX5zWwDOMnaiL
	 c9EWEEBY9k/jBthu7ZocFuHUbiLzqDJM6OkwkG43S60c1XKEdUHiZnm90eggIXQBV4
	 rGA7jQwVq1zcIdLKNsyS7ShrYJkftniQZoYztZdo5nAvvLA5RCX5Bg1gdl5uHD0Ddr
	 braJvNxBEh5kg==

On Thu, Oct 22, 2026 at 11:28:49AM -0400, Willem de Bruijn wrote:
> Eric Dumazet wrote:
> > Le mer. 21 oct. 2026 =E0 23:47, zdi-disclosures@trendmicro.com
> > <zdi-disclosures@trendmicro.com> a =E9crit :
> > >
> > > ZDI-CAN-33367: Linux Kernel skbuff skb_zerocopy Improper Ownership =
Management Local Privilege Escalation Vulnerability
> > >
> > > -- CVSS -----------------------------------------
> > >
> > > 7.8: AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H
> > >
> > > -- ABSTRACT -------------------------------------
> > >
> > > Trend Micro's Zero Day Initiative has identified a vulnerability af=
fecting the following products:
> > > Linux - Kernel
> > >
> > > -- VULNERABILITY DETAILS ------------------------
> > > * Version Tested:7.3-rc1
> > > * Platform Tested:debian trixie
> > >
> >
> > I had to cut this report. Way too long, I could not see a patch in it=
.
>
> Right. For future reports: please review the documentation on how to
> share such findings:
>
> https://docs.kernel.org/process/security-bugs.html

We've probably submitted nearly 1000 cases to kernel over the last ten ye=
ars.

How those cases are formatted today is essentially the same as the way th=
ey were
formatted 10+ years ago aside from the changes you asked for in the past,=
 but
for the most part you've never had a problem with the way they were forma=
tted until recently.

I may be mistaken here, but I searched our mailbox and this is the first =
time
I'm seeing the references to documentation on submitting findings to you.

We will have some discussions internally, but in the meantime, we will se=
nd the cases to you as we always have.
If you don't want to do anything with it, that's fine too. We will releas=
e the findings at rejection, or 120 days.
Whichever comes first.

Weird that Red Hat is on this email... Greg once told me he had no idea w=
ho those people
were and asked that they be removed from security reports. I will probabl=
y get in touch with
them again to discuss reporting.

We understand that your workflow has increased because of AI... and we ar=
e in the same boat.
The snide remarks and hostilities aren't new from your side, but we are d=
oing our best with the people we have.

I get the feeling that even if we were to update our report formatting to=
 match your documentation
It still wouldn't be enough because we aren't going to provide you with p=
atches. That's just the way it is.
It's not my call, and it's overhead we cannot support. In the same token,=
 I know that you rely on a lot of contributors
to get these bugs fixed... that's not lost on us.

We do know that you'd rather us not send you anything at all in that case=
,
which is why we will more than likely have to entertain other options.


>These ZDI monkeys are clue resistent. We've pointed them at this file a
>gazillion of times; they do whatever they want and ignore all feedback.



I would like to say that resorting to racially insensitive pejoratives is=
 quite unbecoming, and you should be more mindful of who you're calling "=
monkeys".

That may be okay where you're from, but there is no excuse to speak to pe=
ople this way, and there is no justification in doing so.  Even if you do=
n't like our reports.

-The ZDI


TREND MICRO EMAIL NOTICE
The information contained in this email and any attachments is confidenti=
al
and may be subject to copyright or other intellectual property protection=
.
If you are not the intended recipient, you are not authorized to use or
disclose this information, and we request that you notify us by reply mai=
l or
telephone and delete the original message from your mail system.
For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: [ https://www.trendmicro.com/priv=
acy]

