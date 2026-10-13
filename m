Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2E568555;
	Tue, 13 Oct 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931316; cv=fail; b=qVCrmlIAGo8JEaKk0W0TSXMn6UJyG9//xwnmOGx3GNfrqROqr1zTBuIX3Jgyk1Bg/40YsjEMNWoHEhekyQnDMDnK/AObNIbmu5c22PvkIuxfZudU4rj2/ydguGeir4pL1VYH/PtQA6RoTmqJ1QwP7HfH9Jo72mbwyaTMUI2/S5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931316; c=relaxed/simple;
	bh=+y6h0ZeGqYMogLj5cM50Urg8VDV4uuyEZgPahNFLAJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+Phnk/ug9WfedZW36BCppwIl4jeVfPCNW2SXBN+L9SBIbw3Q+qggxU89pGEvb2UdopP3flOngoaV8p7IwiHkvZ1IZRuBfiCSWVaEttW1SZiZof9AIsn/sZSaYJZlU4MTu2FxDeeDBXdVl7JYyGf21eMcTglkNRfZ1e26slGfFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=aC0qh6c9; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=AkJXWfjM; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="aC0qh6c9";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="AkJXWfjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=8CHBS/+mZiqU9d8WqFvylu+rMO3K+IcN81El9YQQauI=;
 b=aC0qh6c9HEJcFrDCogIswHbE3SqUOF8Nzjp3eL8eJA7GTOd9kUhjYDyEQsViu7KOKruiaqVPJct9jrRTULWrWgPCDYGjgjNshq6mK397PEVlksCRdQ62ficAP4WX9w2LoACfGMG08NNjmcD0DryWR6mf6dNRFqYRkXwn8KJLfAW++pmqzd7qTwDXJxjQvnK6696+6/rlBb4NoPn0w/BDUvQSFHEvbHPJ+vuddepBulsgwzhQ0vYEtSz0HELvwEh3LXC6Ix/i4ZVR+cPHvYd5ABONYxHCzQ56c7mw1NJ76zFdOu/n25cg6dtgklO9AJPNwgDb26OyTfMEYrzLW8DJSg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020125.outbound.protection.outlook.com [52.101.61.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4229E80086;
	Tue, 13 Oct 2026 22:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSKMtuvxP3hrmPmLd9bIlUtXWc7tR1srLOoPzrQs7utfcauU4IVcumISebGZNe6NW6S2UXbHoZ8DEgHYvfqxw65wV8FRAwS3RkRE1oczzHkj9BBhxDr2kuIHbALqbUevqlemZkHs3/bM6a3iYOfckCCuQYRZDYW4SGt86/EsKL9hO4swbOdB93X3bbYPrq4U03qyK1d5ofOFs8qkM1rjFlX8bhoeA78ZP/iDLHzqVJ+GAs/s9CYrfwMUi4l48xgMrW7w4wBPz+ESbz5hAtswFl7sHqnfdUQXvTKdwmYo8NPHtWTgey4fRs3tbhozKobqHTxiejL+gtBo+Jn9nv3jYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CHBS/+mZiqU9d8WqFvylu+rMO3K+IcN81El9YQQauI=;
 b=h6tISU490K9hxyk+pGYI3u/ZNNRk4C5YjkEox/fDn+vScQxZseeHTpjZmIhnudYCIqiiHLl/KKY71fGyLt4NwhN5JlYa+aJtAdxS2YXIqRZ0WVYUz/FVL3V9tXVPNOSzEThxrcTB7XvhrV0c/xvhoNbO9s1W680pr6hDADYrB8sOf4+msaGvDCIarJ93673N5whgiK+QB2GGP090Ax3OcQwlBePKlf1BJW+1N5royxJXVIetPBKo8VcXI/pvloB6YPsepcKCRi1hIL7syO8JaotjT6psYlAsU6RxWNNbprQ274O0GgA/66PAUYsdSqa1g6i9sUT9if/Rptc6CSVRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CHBS/+mZiqU9d8WqFvylu+rMO3K+IcN81El9YQQauI=;
 b=AkJXWfjM5AJuqMm9Sknbn6Y9JU2CBDKVwjbB4zbVf82I0zSUFE4yA4Ph4LLcIlsZ5WzAmDJAy5QODOoKuliFoWG7W+ezC4Jnrc1mLydsuB/dxHmLCGMcM+IunpxL9QZOZ9kgnBa90PgPg01JIy8wT4bwTrO8+k/okFfTNIXNWe5zZ7p6oi39ol5Ik9QgBxfqiXq6oRNoGtP+Tc0hwuY2WuuaEwKzT47VYFCG35RBeeD5Zsi/wibUZ9xAW0NR2cfwEBlGsEQY6E8MxY8OJRt+WWuLfRtuB0ZebGutDWbIXbzt9FR+YCHkI5CwbAOM92sWFYQQjNci3V2oWbq50v9Wgw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA0PR20MB6676.namprd20.prod.outlook.com
 (2603:10b6:208:480::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:39 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:39 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 12/12] dpll: sit9531x: model the inter-PLL sync
 net as a pair of pins
Thread-Topic: [PATCH net-next v13 12/12] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdW2QC5cGg2ZHRfE6zmmz5BnQjdw==
Date: Tue, 13 Oct 2026 22:41:38 +0000
Message-ID: <20261013224131.27149-13-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|IA0PR20MB6676:EE_
x-ms-office365-filtering-correlation-id: b5547547-0706-4613-d66a-08df297b2535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|5023799004|261009223027099003|260925021911599003|10067099003|260925021311599003|260925022911599003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 Vio5MZ7Ke93kPES5QoDVVPmBbgYSbi5MpJU/JVwwbcexbbVz6dwPiUXlF+LWNH9j0OjRcUDxSpm2esygAMiJOAGqfmHz7dM7xCzPZOZN9Mjyu/shPFyKoOCYWCCnkj4RVIEzgs3fdNxawubrWBD5uQJaRwMvprHo78zFBcW3Ma0vDPspljrQKWI2F7EUsudvWFiYE/Fp8FECROlq/Po9i6PLQOg4pBYuGpjE8tOtiFjIPokyStOBLvl0pivZqXX2ysI6Ojx0MTWKmyR8vsJVQcAxc9v5TF6IMV6xz0y/mTjSx2gLakakzAc6QmYolforTlbuMk3dzQHS9JFZdI1+iqKYsae3OzpENQFpQzkBXLspwhNhstkuUu1LIrDLBmuSkiJJRoppIB13zp13ehK6v2ZsN8txBM8p0/Klu3v0/3UcSjmroSowjT0pfi+Gtx02tdn8IP4xGVHEnPvxqOj8z4fdMSsPxbwxYFTtM/H7iL6oijqZpOcvEPHaXmgXW1pJjj6mLZlTIcaOLFuQZRaPHYCnVaN7yVksN0A1hPoN/KGBTD1+9jvruElxnA7nXJetzlkimsA5iY0Ym/Yz205owbCIWg9LtVhqP4ItBRy4dgkVgGbiHNItjUwLw65sToQwuD5s7lNAddizrJEQVSnbJtbUc8htYx03iogjo8/9Ll2HDYZy4GSWuwWj/glani4ahZzDRihJp7RoCNg9ApIHrcV59HNqmdi1oKtCiv8YgoU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(5023799004)(261009223027099003)(260925021911599003)(10067099003)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?te/IF7INt6Ez5t1yeQXhjiHG08Gac/WNYLCYXRkYPGCAqg7ClgFB+fFVZ1?=
 =?iso-8859-1?Q?FabqFQBI0yTlUwpjnd2HxDHAKEvoKLgaSWU8apSGKeoiiiFEz3A0GN7gyF?=
 =?iso-8859-1?Q?52NBSHlS+7b+vCmuTAskhIGzc+Ni1Bw6sN3usPCj5rXtEiuWOWe5eMUs9Z?=
 =?iso-8859-1?Q?YLltzmpsJw7z8qvf8GDXwznAB6X0S+pjC5DXWTavyU85QWFxwJOXCmZkky?=
 =?iso-8859-1?Q?QYMkHP6KKke3VUyolx6HHc0cdVvsZ7ywNHeXGasRob3P3e1F2CUuFUMjPh?=
 =?iso-8859-1?Q?+QIiLsLzoZyeIYI1pwrjlauxRv3FBIWBXQIXjOL9Tff2wSrZ+VK+/WXSQU?=
 =?iso-8859-1?Q?tZkiyWJngtUQpM9OJ3hs+iaCR1FGenF45PmlI+BfkWEcx6UQX/k8g4IBAY?=
 =?iso-8859-1?Q?SGTIQVlU30e4n2EDSrcJHlHwola3l9iD29gISzWDvrTq8ZI0wQYcSAHLz1?=
 =?iso-8859-1?Q?ai89pEiMomEkb76BD5iNIQK2nQnUGFpUl9DZcfH4wO1R3+1XEtK5eVstDU?=
 =?iso-8859-1?Q?6fC32zwHHD5VkKhinQmDTX2LWBb+ppAKj1l91bWu+cUclEGPw4i7xjX3Ov?=
 =?iso-8859-1?Q?ZM7PVBq/EcfjPa7TY5rUV86WrTAMD40yLCG8Wr/eieFAwEZMuk0dbn7oba?=
 =?iso-8859-1?Q?J8EGP2EAvDDk+Vq1SjBTTI3Y5opJ+Gat7ftDuosxPOFY4QqjLgUhlv0yNE?=
 =?iso-8859-1?Q?saoFOjGiJVVvvKYhN6Vk3guAUuV0kPQrNtVbJFthxs6UXLt4fr7KVEhGGv?=
 =?iso-8859-1?Q?+qQQnoY5IsNq3FswBTwfhG2xiEuDHrB0cYlsqjdGx2wLPBH80tR8qttnzF?=
 =?iso-8859-1?Q?W6Mzfc33k4EN8GGCXf5bscS4VzGgg4B6xxD3sD1dcEEKjPCcIO+CGcnpch?=
 =?iso-8859-1?Q?anadUxuvMVqRbWsn7bu787w6BRW3UFsCyoWdBR18NWeRsheS0lvUaek1W3?=
 =?iso-8859-1?Q?bBrEgcIJvJ292NcBpUA/RwugTIE7nt4gBHiam7J1pceLFCiOPRhrb+TUNQ?=
 =?iso-8859-1?Q?H1QKlVkF19HBoix3poVg6FPvoe5Ck/WX2UVroTfXUg2x4T67ZYFfJYmEFV?=
 =?iso-8859-1?Q?KJ1VobTIlza1QDC32VW6I22F0VMuUu4BWpgjlTGJYi3jNz1J9Hn+J67hvM?=
 =?iso-8859-1?Q?vPK4zIdAZWk+DGaO/hUgTAF9Xj0i0UZEPjt9YuJ6q6CppC/Ue+x/7rc+tX?=
 =?iso-8859-1?Q?EYgjFaS3wJgitEK8c7mmTxuNcm2EGLKuKBAjHDp/T3Mvj4y8HTUr/Vmt02?=
 =?iso-8859-1?Q?652rB+VaaJHmQskZ8o3YCbyXvpOSO8waBZmSpuvzWAYzWRagyA0gW+6tvg?=
 =?iso-8859-1?Q?br3fMfm/D7lev0Sui2lE/AheonMiqCTvGE+GtJCyaXfIqBazliXTwxp+Uq?=
 =?iso-8859-1?Q?t04O84/1q5mQZ6i4yEyzEtuepZAqPhQGun0zMBe1losLzxHq84+IpjPclP?=
 =?iso-8859-1?Q?G/vlKNmSsWFSC3n6esL91WtABAeGar6CaxGzDngdh27upFM9x5H8/143go?=
 =?iso-8859-1?Q?cbE78bXLTneTjUR+/9r5NNKbllqia7UEil0olJpTtDJ/4MmGjgQfbKSDPM?=
 =?iso-8859-1?Q?OS6oV3CCCK8bE9ZwUl/4qNbalRg6kGsKdlIt6MCXBbHpxWb/wCCqc/cTzU?=
 =?iso-8859-1?Q?KG52iAXxnPB7ppSVWO/AXF3iRFYEt2DHcyKMM7Pxz6eYbX4hP62AYV6VSJ?=
 =?iso-8859-1?Q?kldVYhJToaYxJNwtj22PdziXU2RO75N1CccBw8lTW3hCrqu8efEXUUBMW6?=
 =?iso-8859-1?Q?aGhJhTnx2RhNgoNma3G0+RRycU8YhYpUrgHh8cIoseohpL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0OkNFkRCipERUzj9/z/BWZAk2ptjmJPHimfRKTs2x00FHxD8Obf2KRdFzO8HNWNqhpspBI+KFzutrXWhnHcUXX/yrBz/vah1R/GlcsRynxP7y068V9XvlSf/rcc7wqnDMknZA13kcOKMaESAGvLAXxWYIWfkXNWqIjgeNbOs0gri4lRhNWsvbvw9ljmsobMwd8Yf69y6Z/QCoXRn9ecqFu3fdHz2VxZVEahBh65P5Vq5K+FgueAqE+fFc0lpxMna4qSvluM8w8MhagV6jHGYJJWfT77k3e+Ot0wOIHseL9rXRRrK5/5IF3DQnfE0mfdBa+fkIVNLqneBH1CGNiBlIw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5547547-0706-4613-d66a-08df297b2535
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:38.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeqnizzRdeRd5jKsrWyQ2eNUW/zVPRiBJW3eJ/Kwo9LIV9WyzxtUmF3qT8y5MFv6nSuuK3o82gTlgNhj55nnMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6676
X-MDID: 1791931302-QSeIfSB7g5Id
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931302;QSeIfSB7g5Id;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The device has an internal net by which one PLL can drive the others: the=
=0A=
source PLL puts its output on it, and any other PLL can select it as a=0A=
reference instead of an external input.  The two ends are nothing alike --=
=0A=
one is driven, the other is selected -- so they are two pins rather than=0A=
one: an output pin on the source and an input pin on each destination.=0A=
=0A=
That keeps each pin honest about what its state means.  The source pin=0A=
reports whether this PLL is the one driving the net, and setting it takes=
=0A=
the net over or gives it up; a destination pin reports whether its PLL has=
=0A=
selected the net, and behaves like any other selectable input.  A single=0A=
pin would have had to answer both questions at once and could only have=0A=
been right about one of them.=0A=
=0A=
A destination pin whose net no PLL drives reports no signal, as an=0A=
external input that lost its clock does.  A source that failed to take=0A=
the net over, or whose configuration the scan found only partly in=0A=
place, is recorded as a partial owner, so a retry re-runs the enable=0A=
instead of being refused as busy; giving the net up restores the global=0A=
enable only while the net is still configured, and the restore is=0A=
latched as every other write to that register is.  A failed request=0A=
that moved the owner is announced.  Ownership and the output mutes are=0A=
read back from the part on resume.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 414 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c | 409 +++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   3 +=0A=
 4 files changed, 823 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index a744de2c7585..a7b0b2d35cb7 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -3042,6 +3042,381 @@ static int sit9531x_clear_notifications(struct sit9=
531x_dev *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Close the debug window on a PLL's EXT page.  The key register opens=0A=
+ * every debug register on that page while it holds the unlock value.=0A=
+ */=0A=
+static int sit9531x_intsync_debug_lock(struct sit9531x_dev *sitdev, u8 ext=
_page)=0A=
+{=0A=
+	return sit9531x_write_u8(sitdev,=0A=
+				 SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),=0A=
+				 SIT9531X_PLL_DEBUG_LOCK);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * INTSYNC configuration register values.=0A=
+ * These are written to the source PLL's EXT page to enable/disable=0A=
+ * inter-PLL synchronization (lock frequency PLL to phase PLL).=0A=
+ */=0A=
+struct sit9531x_intsync_reg {=0A=
+	u8 offset;=0A=
+	u8 en_val;=0A=
+	u8 dis_val;=0A=
+};=0A=
+=0A=
+static const struct sit9531x_intsync_reg intsync_config[] =3D {=0A=
+	{ 0x2D, 0x02, 0x00 },=0A=
+	{ 0x50, 0x08, 0x00 },=0A=
+	{ 0x51, 0x04, 0x00 },=0A=
+	{ 0x54, 0x02, 0x00 },=0A=
+	{ 0x55, 0x28, 0x20 },=0A=
+	{ 0x5C, 0x0F, 0x00 },=0A=
+	{ 0x5D, 0xFF, 0x00 },=0A=
+	{ 0x6C, 0xDD, 0x00 },=0A=
+};=0A=
+=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	s8 src =3D -1, partial =3D -1;=0A=
+	int rc, ret, n_en, n_dis;=0A=
+	u8 pll, ext_page;=0A=
+	unsigned int i;=0A=
+	u8 global;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &global);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {=0A=
+		sitdev->intsync_src =3D -1;=0A=
+		sitdev->intsync_partial =3D false;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		ext_page =3D SIT9531X_PLL_EXT_PAGE(pll);=0A=
+=0A=
+		/*=0A=
+		 * These are debug registers, which the enable and disable=0A=
+		 * sequences only touch with the EXT page's debug window=0A=
+		 * open; read them the same way.=0A=
+		 */=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    SIT9531X_PLL_REG_DEBUG),=0A=
+				       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		n_en =3D 0;=0A=
+		n_dis =3D 0;=0A=
+		for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+			u16 reg;=0A=
+			u8 val;=0A=
+=0A=
+			reg =3D SIT9531X_REG(ext_page, intsync_config[i].offset);=0A=
+=0A=
+			rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+			if (rc)=0A=
+				break;=0A=
+			if (val =3D=3D intsync_config[i].en_val)=0A=
+				n_en++;=0A=
+			else if (val =3D=3D intsync_config[i].dis_val)=0A=
+				n_dis++;=0A=
+		}=0A=
+=0A=
+		ret =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+		if (!rc)=0A=
+			rc =3D ret;=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		if (n_en =3D=3D ARRAY_SIZE(intsync_config)) {=0A=
+			/*=0A=
+			 * Only one PLL can drive the net.  If a second=0A=
+			 * one matches, the registers are not describing=0A=
+			 * a state this driver put the device in, so say=0A=
+			 * so rather than pick silently.=0A=
+			 */=0A=
+			if (src < 0)=0A=
+				src =3D pll;=0A=
+			else=0A=
+				dev_warn(sitdev->dev,=0A=
+					 "PLL%c also matches the INTSYNC source pattern; keeping PLL%c\n",=0A=
+					 'A' + pll, 'A' + src);=0A=
+		} else if (n_en && n_dis &&=0A=
+			   n_en + n_dis =3D=3D ARRAY_SIZE(intsync_config) &&=0A=
+			   partial < 0) {=0A=
+			/*=0A=
+			 * Every register holds one of the two patterns and both=0A=
+			 * occur: the residue of an enable or a disable that=0A=
+			 * stopped part way, and nothing a profile writes.=0A=
+			 */=0A=
+			partial =3D pll;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * An enable or a disable that stopped part way leaves a PLL holding=0A=
+	 * a mix of the two patterns.  Treat it as the owner, so that another=0A=
+	 * PLL cannot be enabled on top of the leftover configuration, but=0A=
+	 * record that it is partial: a repeated connect on that PLL must run=0A=
+	 * the enable again rather than take the PLL for configured, and a=0A=
+	 * repeated disconnect runs the disable again.=0A=
+	 */=0A=
+	sitdev->intsync_partial =3D src < 0 && partial >=3D 0;=0A=
+	if (sitdev->intsync_partial) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c holds a partial INTSYNC source configuration\n",=0A=
+			 'A' + partial);=0A=
+		src =3D partial;=0A=
+	}=0A=
+=0A=
+	sitdev->intsync_src =3D src;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int __sit9531x_intsync_disable(struct sit9531x_dev *sitdev,=0A=
+				      u8 src_pll_idx, bool restore);=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_enable - enable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Enables INTSYNC global bit, unlocks the source PLL's EXT page=0A=
+ * debug registers, writes configuration, and triggers a small=0A=
+ * update on the source PLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].en_val);=0A=
+		if (rc)=0A=
+			goto relock_err;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	rc =3D 0;=0A=
+	goto relock;=0A=
+=0A=
+relock_err:=0A=
+	sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	goto err_disable;=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the EXT page debug window the sequence opened.  Nothing=0A=
+	 * else writes the key back, so leaving it open would keep the block=0A=
+	 * unlocked for as long as the device runs.  The net is driven by=0A=
+	 * now, though, so a failure here must not read as a failed enable:=0A=
+	 * the caller would then not record the owner of a net that is=0A=
+	 * driven.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c: INTSYNC enabled but the debug window was left open: %d\n",=0A=
+			 'A' + src_pll_idx, lock_rc);=0A=
+=0A=
+	return rc;=0A=
+=0A=
+err_disable:=0A=
+	/*=0A=
+	 * The global enable is already set at this point.  The caller only=0A=
+	 * records the source PLL when this function succeeds, so nothing=0A=
+	 * else will ever clear the bit: undo it here rather than leave the=0A=
+	 * net asserted with a half-written EXT page.  The disable must not=0A=
+	 * put the bit back when it fails part way, as it does for a=0A=
+	 * disconnect: here the bit is what the rollback set out to clear,=0A=
+	 * and restoring it would leave the net asserted with no PLL=0A=
+	 * matching the source pattern, which no owner on record would ever=0A=
+	 * clear.=0A=
+	 */=0A=
+	{=0A=
+		int rollback_rc;=0A=
+=0A=
+		rollback_rc =3D __sit9531x_intsync_disable(sitdev, src_pll_idx,=0A=
+							 false);=0A=
+		if (rollback_rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "INTSYNC rollback failed after enable error: %d (original %d)\n",=0A=
+				 rollback_rc, rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The disable sequence.  @restore says whether a failure before the EXT=
=0A=
+ * page holds the disable pattern puts the global enable back, which a=0A=
+ * disconnect wants (see restore_global below) and the rollback of a=0A=
+ * failed enable does not.=0A=
+ */=0A=
+static int __sit9531x_intsync_disable(struct sit9531x_dev *sitdev,=0A=
+				      u8 src_pll_idx, bool restore)=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].dis_val);=0A=
+		if (rc)=0A=
+			goto restore_global;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Small update on source PLL.  The global enable is latched off and=0A=
+	 * every register holds the disable value by now, so the net is not=0A=
+	 * driven whether or not this latch went through.  Putting the bit=0A=
+	 * back for a failure here would describe the net as driven with no=0A=
+	 * PLL matching the source pattern: the detector would record no=0A=
+	 * owner, and nothing would ever clear the bit.=0A=
+	 */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+=0A=
+	goto relock;=0A=
+=0A=
+restore_global:=0A=
+	/*=0A=
+	 * The global enable was cleared first, so a failure here leaves the=0A=
+	 * EXT page still holding the enable pattern with nothing pointing=0A=
+	 * at it: the source detector keys on the global bit, would report=0A=
+	 * the net as unowned, and a retry of the disable would then=0A=
+	 * short-circuit.  Put the bit back so the state stays one the=0A=
+	 * driver can describe and the request can be repeated.=0A=
+	 */=0A=
+	if (restore &&=0A=
+	    !sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val) &&=0A=
+	    !sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT))) {=0A=
+		/*=0A=
+		 * Every write of the global enable, here and in SiTime's=0A=
+		 * sequences, is followed by the page-0 small update that=0A=
+		 * applies it.  Without it the bit would sit pending until=0A=
+		 * an unrelated commit through the same update register=0A=
+		 * applied it, re-asserting the net over a half-written=0A=
+		 * EXT page with nobody having asked.=0A=
+		 */=0A=
+		sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+				  SIT9531X_SMALL_UPDATE_CMD);=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the EXT page debug window the sequence opened.  After a=0A=
+	 * disable that took effect, a failure here is a warning, for the=0A=
+	 * same reason as in sit9531x_intsync_enable().=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc) {=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: debug window left open: %d\n",=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: INTSYNC disabled but the debug window was left open: %d\n",=
=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_disable - disable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Clears INTSYNC global bit, writes disable values to the source=0A=
+ * PLL's EXT page, and triggers a small update.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	return __sit9531x_intsync_disable(sitdev, src_pll_idx, true);=0A=
+}=0A=
+=0A=
 /**=0A=
  * sit9531x_phase_offset_read - read phase difference via TDC=0A=
  * @sitdev:	device pointer=0A=
@@ -3693,6 +4068,15 @@ static int sit9531x_dev_state_fetch(struct sit9531x_=
dev *sitdev)=0A=
 		return rc;=0A=
 	}=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to detect INTSYNC source: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
 		bool clamped;=0A=
 		s32 phase_ps;=0A=
@@ -4440,13 +4824,13 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
 			return true;=0A=
 		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
-			return false;=0A=
+			return true;=0A=
 =0A=
 		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 	}=0A=
 =0A=
 	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
-		return false;=0A=
+		return true;=0A=
 =0A=
 	if (index >=3D sitdev->info->num_outputs)=0A=
 		return false;=0A=
@@ -4882,8 +5266,34 @@ static int sit9531x_suspend(struct device *dev)=0A=
 static int sit9531x_resume(struct device *dev)=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D dev_get_drvdata(dev);=0A=
+	int rc;=0A=
+	u8 i;=0A=
 =0A=
 	sit9531x_page_cache_drop(sitdev);=0A=
+=0A=
+	/*=0A=
+	 * A part that lost power across suspend comes back with its=0A=
+	 * profile's INTSYNC routing and output mutes, not with what the=0A=
+	 * caches say, and the poll watches neither.  Read them back here;=0A=
+	 * a cache that cannot be read is left for the getter's read-through.=0A=
+	 * Nothing races this: the poll is parked and the IRQ disabled.=0A=
+	 */=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	if (rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source not re-detected on resume: %d\n", rc);=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, i);=0A=
+		if (rc) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Output %u mute state not read on resume: %d\n",=0A=
+				 i, rc);=0A=
+			sitdev->out[i].state_stale =3D true;=0A=
+		}=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
 	if (sitdev->irq > 0)=0A=
 		enable_irq(sitdev->irq);=0A=
 	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index b440e2d6011d..90f79fbdccde 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -211,6 +211,9 @@ struct sit9531x_chan {=0A=
  *			I2C client), 0 if no IRQ is wired=0A=
  * @intsync_src:	PLL index currently sourcing inter-PLL=0A=
  *			synchronization (INTSYNC), or -1 when disabled=0A=
+ * @intsync_partial:	@intsync_src holds only part of the source=0A=
+ *			configuration, left by an enable or a disable=0A=
+ *			that stopped part way=0A=
  * @irq_ack_fails:	consecutive failures to acknowledge the=0A=
  *			notification latches from the interrupt handler=0A=
  * @fvco_band_warned:	bit per PLL whose Fref * DIVN has been reported as=
=0A=
@@ -248,6 +251,7 @@ struct sit9531x_dev {=0A=
 =0A=
 	/* Inter-PLL synchronization state */=0A=
 	s8			intsync_src;=0A=
+	bool			intsync_partial;=0A=
 =0A=
 };=0A=
 =0A=
@@ -298,6 +302,9 @@ int sit9531x_output_phase_adjust_set(struct sit9531x_de=
v *sitdev,=0A=
 				     u8 out_idx, s32 phase_ps);=0A=
 =0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
 int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index dc8d84133b72..5f530c4a8271 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -27,6 +27,20 @@ static bool sit9531x_dpll_is_input_pin(const struct sit9=
531x_dpll_pin *pin)=0A=
 	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
 }=0A=
 =0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_PIN_ID;=0A=
+}=0A=
+=0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_src_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return !sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;=0A=
+}=0A=
+=0A=
 static bool=0A=
 sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
@@ -311,6 +325,59 @@ sit9531x_dpll_selection_state_get(struct sit9531x_dev =
*sitdev,=0A=
 		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Does the device feed a locked PLL from the INTSYNC net?=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool sit9531x_dpll_intsync_tracked(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	u8 pll;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		chan =3D sit9531x_chan_state_get(sitdev, pll);=0A=
+		if (chan->routed_ref =3D=3D SIT9531X_INTSYNC_PIN_ID &&=0A=
+		    chan->locked && !chan->ho_freeze)=0A=
+			return true;=0A=
+	}=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Does a selection-role pin carry a signal?  A physical input has the=0A=
+ * device's LOS monitor; the INTSYNC net has no monitor, and what stands i=
n=0A=
+ * for one is the driver's record of a PLL driving it.  A partial source=
=0A=
+ * configuration does not count: the source pin reports it as no=0A=
+ * connection, and the net is not confirmed driven.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_selection_no_signal(struct sit9531x_dev *sitdev, u8 pin_id)=
=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pin_id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		/*=0A=
+		 * The driver knows the net is driven when it enabled the=0A=
+		 * source itself or found the configuration it would have=0A=
+		 * written.  A profile can drive the net with a configuration=0A=
+		 * of its own; then a PLL the device feeds from the net and=0A=
+		 * holds locked is the evidence that the net carries a signal.=0A=
+		 */=0A=
+		if (sitdev->intsync_src >=3D 0 && !sitdev->intsync_partial)=0A=
+			return false;=0A=
+		return !sit9531x_dpll_intsync_tracked(sitdev);=0A=
+	}=0A=
+=0A=
+	return pin_id < sitdev->info->num_inputs &&=0A=
+	       sit9531x_ref_state_get(sitdev, pin_id)->los;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Is this the reference the PLL is tracking now?  See the S && L && !N=0A=
  * predicate in the pin-state contract.  This is also what gates the=0A=
@@ -334,11 +401,10 @@ sit9531x_dpll_selection_active(struct sit9531x_dev *s=
itdev,=0A=
 =0A=
 	/*=0A=
 	 * Fed to the PLL is not locked to: the device names the source it=0A=
-	 * routes, and a lane that lost its signal is one the PLL is about=0A=
+	 * routes, and a source that lost its signal is one the PLL is about=0A=
 	 * to be moved off, whatever the lock bit still says.=0A=
 	 */=0A=
-	if (pin_id < sitdev->info->num_inputs &&=0A=
-	    sit9531x_ref_state_get(sitdev, pin_id)->los)=0A=
+	if (sit9531x_dpll_selection_no_signal(sitdev, pin_id))=0A=
 		return false;=0A=
 =0A=
 	return true;=0A=
@@ -364,12 +430,17 @@ sit9531x_dpll_selection_operstate_get(struct sit9531x=
_dev *sitdev,=0A=
 		return;=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * Standby is a qualified source the PLL is not using.  A net nobody=0A=
+	 * drives is no more that than a lane in LOS is.=0A=
+	 */=0A=
+	if (sit9531x_dpll_selection_no_signal(sitdev, pin_id)) {=0A=
+		*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	if (pin_id < sitdev->info->num_inputs) {=0A=
 		ref =3D sit9531x_ref_state_get(sitdev, pin_id);=0A=
-		if (ref->los) {=0A=
-			*operstate =3D DPLL_PIN_OPERSTATE_NO_SIGNAL;=0A=
-			return;=0A=
-		}=0A=
 		if (ref->qual_fail) {=0A=
 			*operstate =3D DPLL_PIN_OPERSTATE_QUAL_FAILED;=0A=
 			return;=0A=
@@ -869,8 +940,325 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
pll_pin *pin,=0A=
 				       enum dpll_pin_direction *direction,=0A=
 				       struct netlink_ext_ack *extack);=0A=
 =0A=
+/*=0A=
+ * Does this PLL drive the INTSYNC net with a complete configuration?=0A=
+ * What the source pin reports as CONNECTED.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_intsync_src_connected(const struct sit9531x_dev *sitdev,=0A=
+				    const struct sit9531x_dpll *sitdpll)=0A=
+{=0A=
+	return sitdev->intsync_src =3D=3D sitdpll->id && !sitdev->intsync_partial=
;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sit9531x_dpll_intsync_src_connected(sitdev, sitdpll))=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_src_state_on_dpll_set - drive INTSYNC from a PLL=
=0A=
+ *=0A=
+ *   CONNECTED    -> this PLL drives the INTSYNC net=0A=
+ *   DISCONNECTED -> stop driving INTSYNC if this PLL drives it=0A=
+ *=0A=
+ * SELECTABLE is rejected: driving the net is an explicit output routing,=
=0A=
+ * not an automatic-selection candidate, matching the regular output pin.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc =3D 0, detect_rc =3D 0;=0A=
+	bool was_connected, moved;=0A=
+	bool changed =3D false;=0A=
+	u8 hw_src;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	was_connected =3D sit9531x_dpll_intsync_src_connected(sitdev, sitdpll);=
=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		/*=0A=
+		 * A partial configuration on this PLL is not a connection:=0A=
+		 * run the enable again so a retry after a failed one repairs=0A=
+		 * the device instead of reporting success over it.=0A=
+		 */=0A=
+		if (was_connected)=0A=
+			break;=0A=
+		if (sitdev->intsync_src >=3D 0 &&=0A=
+		    sitdev->intsync_src !=3D sitdpll->id) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "INTSYNC is already sourced by another PLL");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * A PLL that already lists INTSYNC among its references must=0A=
+		 * not also drive it: the destination side refuses the mirror=0A=
+		 * of this, and without the check here the net could be routed=0A=
+		 * back into the PLL feeding it.=0A=
+		 */=0A=
+		hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+		if (sit9531x_input_prio_present(sitdev, sitdpll->id, hw_src)) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL selects INTSYNC as a reference; it cannot drive it");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id);=0A=
+		changed =3D true;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (sitdev->intsync_src !=3D sitdpll->id)=0A=
+			break;=0A=
+		rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id);=0A=
+		changed =3D true;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Record what was done before confirming it, and only when this PLL=0A=
+	 * actually changed: the core forwards a request for the state the=0A=
+	 * pin is already in, and a DISCONNECTED on a PLL that never drove the=0A=
+	 * net must not erase the owner.  The refresh below leaves the cache=0A=
+	 * untouched when a read fails, and a cache that wrongly says nobody=0A=
+	 * drives the net would let a second PLL be configured to drive it.=0A=
+	 */=0A=
+	if (changed && !rc) {=0A=
+		sitdev->intsync_src =3D state =3D=3D DPLL_PIN_STATE_CONNECTED ?=0A=
+				      sitdpll->id : -1;=0A=
+		sitdev->intsync_partial =3D false;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Re-scan hardware after a transition so the cache follows a=0A=
+	 * partially failed enable or disable as closely as possible.=0A=
+	 */=0A=
+	if (changed)=0A=
+		detect_rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	/*=0A=
+	 * A failed enable that the scan still finds on this PLL is partial=0A=
+	 * even when every register reads the enable pattern: the small=0A=
+	 * update that commits it may be the step that failed.  Mark it, so=0A=
+	 * a retried connect runs the enable again.=0A=
+	 *=0A=
+	 * When the scan itself failed, nothing says how far the enable and=0A=
+	 * its rollback got, and the net may be driven.  Record this PLL as=0A=
+	 * the partial owner rather than leave the cache saying nobody drives=0A=
+	 * the net, which would let a second PLL be configured on top of it.=0A=
+	 * A disconnect on this PLL runs the disable and a scan that settle=0A=
+	 * the record.=0A=
+	 */=0A=
+	if (changed && rc && state =3D=3D DPLL_PIN_STATE_CONNECTED &&=0A=
+	    (detect_rc || sitdev->intsync_src =3D=3D sitdpll->id)) {=0A=
+		sitdev->intsync_src =3D sitdpll->id;=0A=
+		sitdev->intsync_partial =3D true;=0A=
+	}=0A=
+	/*=0A=
+	 * The refresh only re-reads what the device now shows.  Failing=0A=
+	 * the request because that read hit a bus error would tell=0A=
+	 * userspace the enable did not happen when it did.=0A=
+	 */=0A=
+	if (detect_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source cache not refreshed: %d\n",=0A=
+			 detect_rc);=0A=
+=0A=
+	/*=0A=
+	 * What the pin reports may have moved although the request failed:=0A=
+	 * a disable that stopped at its last step leaves nothing driving=0A=
+	 * the net, a failed enable leaves a partial owner.  The core=0A=
+	 * notifies only a request that succeeded and the poll does not=0A=
+	 * watch this pin, so announce it here, as the output setter does.=0A=
+	 */=0A=
+	moved =3D sit9531x_dpll_intsync_src_connected(sitdev, sitdpll) !=3D=0A=
+		was_connected;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		struct dpll_pin *dpll_pin;=0A=
+=0A=
+		if (rc !=3D -EBUSY && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Failed to set INTSYNC source state");=0A=
+		/*=0A=
+		 * The core's lock is held here, as the helper requires.=0A=
+		 * Teardown clears the handle before it unregisters the pin;=0A=
+		 * see the output state setter.=0A=
+		 */=0A=
+		dpll_pin =3D READ_ONCE(dpin->dpll_pin);=0A=
+		if (moved && dpll_pin)=0A=
+			__dpll_pin_change_ntf(dpll_pin);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_src_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_src_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_src_state_on_dpll_set,=0A=
+};=0A=
+=0A=
 /* ---- INTSYNC destination (input) pin ---- */=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_get - INTSYNC reference state=
=0A=
+ *=0A=
+ * Selection role, so the contract above decides this exactly as it does=
=0A=
+ * for a physical input: the priority table is the eligibility record, and=
=0A=
+ * whether a source PLL happens to be driving the net right now is no more=
=0A=
+ * a state than a momentary LOS is on an external reference.  The one=0A=
+ * addition is that the PLL driving INTSYNC is never its own destination.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else=0A=
+		sit9531x_dpll_selection_state_get(sitdev, sitdpll,=0A=
+						  SIT9531X_INTSYNC_PIN_ID,=0A=
+						  state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_set - lock a PLL to INTSYNC=0A=
+ *=0A=
+ * Selection role, so this accepts and refuses what a physical input does,=
=0A=
+ * CONNECTED included: the device pins no reference on request whichever=
=0A=
+ * source is asked for.  INTSYNC is an internal net with no physical=0A=
+ * receiver, so only the per-PLL priority table is touched; the source pin=
=0A=
+ * controls generation.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL cannot lock to the INTSYNC it drives");=0A=
+			rc =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_operstate_on_dpll_get(const struct dpll_pin *pin=
,=0A=
+						void *pin_priv,=0A=
+						const struct dpll_device *dpll,=0A=
+						void *dpll_priv,=0A=
+						enum dpll_pin_operstate *state,=0A=
+						struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll,=0A=
+					      SIT9531X_INTSYNC_PIN_ID,=0A=
+					      state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Do not add .frequency_get / the generic input state getter here: the=0A=
+ * destination pin id is SIT9531X_INTSYNC_PIN_ID, one past the end of the=
=0A=
+ * ref[] array (INTSYNC is an internal net with no ref[] entry).  The ops=
=0A=
+ * below only ever key on chan[] and the priority table, never ref[id].=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_dst_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_dst_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D=0A=
+		sit9531x_dpll_intsync_dst_operstate_on_dpll_get,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
 /*=0A=
  * XO (crystal oscillator) pin ops=0A=
  *=0A=
@@ -1197,8 +1585,13 @@ static const struct dpll_pin_ops sit9531x_dpll_outpu=
t_pin_ops =3D {=0A=
 const struct dpll_pin_ops *=0A=
 sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
-	if (!sit9531x_dpll_is_input_pin(pin))=0A=
+	if (!sit9531x_dpll_is_input_pin(pin)) {=0A=
+		if (sit9531x_dpll_is_intsync_src_pin(pin))=0A=
+			return &sit9531x_dpll_intsync_src_pin_ops;=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
+	}=0A=
+	if (sit9531x_dpll_is_intsync_pin(pin))=0A=
+		return &sit9531x_dpll_intsync_dst_pin_ops;=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
 	/*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 1891679698e2..601dafbb2179 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -312,6 +312,9 @@=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
+/* PLL EXT page INTSYNC configuration registers */=0A=
+#define SIT9531X_PLL_EXT_PAGE(_idx)	(SIT9531X_PAGE_PLLA_EXT + (_idx))=0A=
+=0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
 =0A=
 /*=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
