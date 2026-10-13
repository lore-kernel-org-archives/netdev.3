Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC5360EC9;
	Tue, 13 Oct 2026 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931016; cv=fail; b=Xexlu5ajtGD87T1Xx1pSLWDNyDuxHp69kXzwj9qcie6+crZ+kQVU8qiUG0GKKIs6V5H6KiRqvHOpA6HxhmZ4MVkXE3/swIcnaPOViTB4Xe4LJ79GG/dkPK+2cnWdgN6mKXlkS+loN6Yd/XS71HAipG9f23/HfNelxMG7AhH3sFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931016; c=relaxed/simple;
	bh=cjPwgjUNOfPyca5dHDQ63VtTPaGidn68sRW8atgxmPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XqPu8lsFqHh2pjrr5wbrdg+TmjznZflephEOpA7xrE7t6AfwOwTxDYij9rjiLTmGxbcwyfsMhW5hvJw1BCg0w93qhdKci3NBAHFRphT/pUFQzm2WwPRj2oQ3cH2LuFTDf0Zn83TSjb3hdoszGGXohQgxtrQ2gACvWUXSIiV3EIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=KMDFWuGu; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=N5C8fnBq; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="KMDFWuGu";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="N5C8fnBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=hEz7a+S+koVn/nAXh1mQEEgiBMx/h14yEgo2aGIFyG0=;
 b=KMDFWuGuSE6bVIGkr3sML+P7nAyxIOcsmGLSf28P3LWgn5tnG9rgk8AKeWhjEhWqvfHMYrQfJreJP+E6BiZAJHtauL7RFWiwdm6u20vWxlqC9enKeR/mqPTJwmTGZTivVSE+8TFSF4ZDFzqVhaeun+9lHJD+ff88P5eYrnJJUIB89zysajRvGwfui6owk3un2yuFRdLiK8saj7/PyLReGbu2aHCFnIG9cYBfZhS2wOX7Pw5t/JAkb5OHcfVY5gawXISmu1O47GY+tVKza86Fjjzm3ONRzJF+Tje1gl3NepX8q1GNTntePYGRzDgXV9p/NsFJtArFZ09YZY47bd/auw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020079.outbound.protection.outlook.com [52.101.56.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E0EA198006A;
	Tue, 13 Oct 2026 22:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTWWMRhG8Jcq0o/Ks5f+BXA9vGyogwbElIW4d1x8Dd51/SmJhk+Ckq1lgS3/6nSSVRE5BULWCcs/DUXaLtIUWM/WHsbaL5rI6BuOEJddY73zVEm3FluM+Stm79qPn7wELso1Kg9b8tm2agMLLUl/hco++XkWBKY5iLNZpUzAtY9pKsQAQo7l2bIoF2fll66AKS7l9DDw8Vl1Z1c9+Bqo3bzk914hJKMNN7yGin2VbGLXvA64mQ/Bcr02qPv2oDD4yz0o1j5YO+1gc3pnYiIMPsI1CPpM6wdQ7QxlBYL+39iLet/vs8XCt67CO3UWHGfraPccG0Q2QFCE6OfV2D0byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEz7a+S+koVn/nAXh1mQEEgiBMx/h14yEgo2aGIFyG0=;
 b=f1rXqROstFDWEIeRJ8huBkaCtk4UCyboCMuDe5fbfzqs72qWaz5+cyOpgxe0TYDxR53u6cWOA4Y762Fpfa0gB1nnYvdQOVC4mTgRV9WZp5S6oA7o0noycikOZTgvXygK+s8gVvVHT0cr0S9+Ow4YvspWS89+Pu+qogv1TSYfhaf/uM3yYMbnRwDiWHcwQ3NMk7YzuLpdTy/t4YdzmsTuQ25OWhYR1TXHohNgS/cxBC9q8s8ixrSlNjSI/NaW64sa6Xeeks8esSU+Qatd3IAF3z2DcQKXx3PUHU9BXV4qvIVnk6zvLwoAnqqKYxwvTRKni/lQeZvJ3RaJGt1q/kQ3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEz7a+S+koVn/nAXh1mQEEgiBMx/h14yEgo2aGIFyG0=;
 b=N5C8fnBqkSKwy5IvK2Dp/yts/f7zkWqjEVPZ6MdsrUAYSMRLf91kLtv0/ey5iZ3O7gjqDzYT+1xIMwVrbvHef9ZbyOP//n8/nHOsIseEvJoU0AkI6HHegLRXklCnpmlSTqatzpJDwIe4nOCTG2P3UE1GFVrwRkXwqZ1sJ6zhZDJhCm9MkSFlQV6HJD9tnHpCgzb8U3TXeFIJMHs5OCmxs1KiJrd5sVho7y5oS92COmWSquencXq8W/a1LzJmICaBQYucfaX8AzQykTdOv4yV2F0EojabbSb2L7Kr2i26ej4hUt56XPlgh2x7fxMDegsfkgAi9GNjSPBKcDJZ7/ji2w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB596672.namprd20.prod.outlook.com
 (2603:10b6:806:3be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:36:43 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:36:43 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v12 03/12] dpll: add basic SiTime SiT9531x
 support
Thread-Topic: [PATCH net-next v12 03/12] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdWBx115RL7jUfs0GLNNopB2dJ4rb7NX0AgADg6AA=
Date: Tue, 13 Oct 2026 22:36:43 +0000
Message-ID: <20261013223641.25560-1-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-4-arouhi@sitime.com>
 <d7737c9d-d4ea-4060-b82f-c7d6630ed407@redhat.com>
In-Reply-To: <d7737c9d-d4ea-4060-b82f-c7d6630ed407@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB596672:EE_
x-ms-office365-filtering-correlation-id: f16d33e3-2ed4-4de1-21d6-08df297a74c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|38070700021|56012099006|18002099003|22082099003|261009223027099003|10067099003;
x-microsoft-antispam-message-info:
 c8voXuH9pKEzM9RVNxlX1Sxl83DRG2b8hFsGIV87thPi6A6FsmF1ydAia7bwx2fyzu9pQ5tB2ON1xF4nTGDZXYVXSrpRdUHHn37sB2CX5dXcJj/HGZMgn66lgbQe0SpCtHO2xBDvoUTW4jiE0zUyNcf0w5RdVnlggBT/AAAjt7zr7/pbqTi3z5dworCBlxtLQwSxRVyLKAevWVAeDRmJ8J/cna6g26kd9V1zy5xdcMPW7IvswOiVZj/dB62D0oohSh84Qib5xQJjW7+nMUWdMppcpT42uayGYK2J5o9da+8trVZmzjnwejB6P66aqaWbcfXcJivPzIpxeq0kg7poldCrokm/+PwuBowMOrA19LuRVVVK+8+aK50YEfMM4x9pjnBltM30RzPV1T7DU3ArctV7IFtyvSG35fxRyLZe0naBGaZR+ti9bXNFr5a5o2j4t0yq6qF3h7S0DR43sjLHlua8SvB+8Q73n1KNaXmSYfrI8C1/l9sNENCLE8HfRaWjjjzcYJPR5G67o5+7E6ECXsBNVVpZPvMRrw3lB4ka+UVFI/8X2IbUgRyDCOHBELi5y73P9oa5QGVy7g6j5kkZnR+R7uRVC8txcsTDZmK7to4nJau/UqF6zov8vhATUU2cC3pzmUFv7f5lRT0YtOz3bGGOqZqn72fmMKZiv0g3PAT1KC+nk/3SeN794tbNNSxdShB+/4Ee+uMwu0X8LsZgE6jfebiMan+0I3y4pfd++NY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(38070700021)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uJQ5Mgu7h5Vz/FMAibKEs3yE/sGBVZcwqjzWQxbMhq2gYOoFF8/LkWD1SB?=
 =?iso-8859-1?Q?VLUcCBhYND0yfMwNIMpZI6YaZxjnlkbwqIqr4cptI1q7538NjwTnZ342t3?=
 =?iso-8859-1?Q?5MfTFgofPeV470BA30EpQEYGWMyzSqn3nrIj9T03mym2YF+ku1FNOA4hyo?=
 =?iso-8859-1?Q?zm2TvPoZFwz0m5Rz2F262BCsY6tnGYtcUOrkKvNj5py3e2HNP5YrNoUHWJ?=
 =?iso-8859-1?Q?B1fo6Nn9QLRX1h/cDbauFaTPFwGkt2jaMuUWea9avvB6ef18Ijdo0h5uot?=
 =?iso-8859-1?Q?O7/FIC2ic+3IL85CJvhmvSDyxLvEFbVuyvbONGc8UTFdmqXPWyFJ7Cs6pK?=
 =?iso-8859-1?Q?+ahiu2UCG8BllNqFE4FYajkXyciLUrHJT/qlTJ1M3aLpFS6CJgbLE7NFB1?=
 =?iso-8859-1?Q?0+m8nDXYCSl2fePae7fK4jrxhkjoU0wGFCZhicD1pYx4ydWBlGI363WWkC?=
 =?iso-8859-1?Q?rsthf4jSQkKZOIMrblEhDduO/whqQe/dwaewwLarPTKkMH4zGVxI74yBj7?=
 =?iso-8859-1?Q?EFaEssoNMA91NQsd+285Q3FxcBxQhDeg1Xd/cb0BgQ/OzDqxDrIPBjFjJu?=
 =?iso-8859-1?Q?dorL+tRfP34/vHE4r7SbuPx78pKa70f/yWZ1VKzdIdG6JIKL7GnkriwqHl?=
 =?iso-8859-1?Q?PLCITg/zIg2XlRnmaBS+3ziuqoa9pPgAPO7VL3mgdpoGfX0IWSCgYyg5Au?=
 =?iso-8859-1?Q?b9LUim89F7+sQbL2hMFlsIYO/0yplxB/cg0in3aj1J8bKNWx5LvrNBBvUF?=
 =?iso-8859-1?Q?Wh1ODPqyuB1nvV8bsHKPPXjfJ8AVKgU/PdbaNR4aurWVS++qvvQciAYIEW?=
 =?iso-8859-1?Q?pnon5/1gp/nKRJhtXUWh8rC8FJA8HGOjWsBZvoCJ1mXUraZRGXjvyNcolu?=
 =?iso-8859-1?Q?O3HQ3pXsAyUD0UgwrTSfEHi+TnDcRN+brwdhlV/dvBNshWR1+Jk4MPX1U3?=
 =?iso-8859-1?Q?xkZTqdvEf/NXwoLKByeYj3xHye5YjomV+FKRk9FFNxghuVL/Ylo12rYlzk?=
 =?iso-8859-1?Q?SqRfCVF6Es4JbL+xmD0FNrwI6rAxSIBRpberf6vCtMtymEvJbMRYfMa/ZR?=
 =?iso-8859-1?Q?pLjpNB1t/Y8oJ4+rwPpSPfrL4Di8EXuSuTEsioCIt+zFVmNWnKWPYZl78P?=
 =?iso-8859-1?Q?Qx+9o3MQXSsxuDQhUV8QN9nKRZQJurN/eu8f1+xTHfzQ4UnldmkxLstjjJ?=
 =?iso-8859-1?Q?ODM5mOSoko8LmOi+u87ryIgok5C9TXPQDyIzAQUXL2iBUe27kElWd7/olN?=
 =?iso-8859-1?Q?uklkis/Q0XuOnALiwJ5WSoeQ6FxhPV3x+QeppmUUHD6C9Tklaf+W5BGv1U?=
 =?iso-8859-1?Q?tRHZ10SAx2hnnqRTOO5cF9uXRP73kW+DnheVLMwY5Tych+MT9MG4AbhTEA?=
 =?iso-8859-1?Q?1RQOEZwDPTltWhQ1RbZmn4GFN5UDaQbCKrVDMyWgzG21aay5QdVxUGu246?=
 =?iso-8859-1?Q?5MEwqlJd3ClMoIhHzcpu3S9VF3PSNlvUSNJM8Kq12w0AXMuTKBNUq+ruBw?=
 =?iso-8859-1?Q?ays5XDYmfkbZ/oVLggDV3otg780/tXOo0uxsru4OmYHBbxSJ5uVmubN6ru?=
 =?iso-8859-1?Q?uN752JLKdEs/5a012VJCHlzwXvTKXh/TP8LtcaNlCj70C56qS0xCFF8/vS?=
 =?iso-8859-1?Q?UmR57fNcOb0i3T590Cjc96y2/2yjehEme6zBGzUBYHsLM5WSiQhl7b4S4C?=
 =?iso-8859-1?Q?xCLTBJrLiHhAnt5Fs53Hb32zeLfQkIFfbbLpsUqTsveEthDufw2WTucu+b?=
 =?iso-8859-1?Q?Cmx2wS7seIBTnKAamaeZyK+MYN0iWo89H4SXyCRNd7y1e8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KehFh5rWWshxDYz3llfqknYLrfd2Vwv4S6uBjWmmtcypgjibMA9qXI3kwmDjDTa5qmlncFc6c7BZdAXuw5BNOZnDBorlHY6ZMostmH5p7KHGrH70IF4wv2qQVEYg9f6VBIEyrjdQrhpA/bcn8i5LQ3Qs6vMEkKdQNmXnZsgfy3ClM6nw4+8qPBjVL2eRDeU2d3lULUzd1vWSaiJjnu7i/ovwwwWMpy+g1E6GGNcSTDJIKgh+zsrqPjywM1gGxxmzxBH/4ow/TehPfiTGGwgKckPtlx7xcAoOLTH9MzcCRG6FzAg/m37dlnAfKgsKd3k6Vz/9F2g7IVMC6hyy/Uq7QQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16d33e3-2ed4-4de1-21d6-08df297a74c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:36:43.1596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9q+zWWDNHnVqj/B5cQxXzHuliE0CMZ/9bqJpdvnavx9h1JgnKaJBIcm3v0wTSheom+GYHFq8Ey/KbC4wC5FmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB596672
X-MDID: 1791931008-bMmB1IioHnsu
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931008;bMmB1IioHnsu;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Tue, 13 Oct 2026, Ivan Vecera wrote:=0A=
=0A=
> > +const struct regmap_config sit9531x_regmap_config =3D {=0A=
> > +       .reg_bits       =3D 8,=0A=
> > +       .val_bits       =3D 8,=0A=
> > +       .max_register   =3D SIT9531X_RANGE_OFFSET +=0A=
> > +                         (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1=
,=0A=
> > +       .ranges         =3D &sit9531x_regmap_range,=0A=
> > +       .num_ranges     =3D 1,=0A=
> > +       .volatile_reg   =3D sit9531x_volatile_reg,=0A=
> > +       .cache_type     =3D REGCACHE_MAPLE,=0A=
> > +};=0A=
>=0A=
> This is only referenced from core.c. Could it be static, with the extern=
=0A=
> declarations dropped from core.h?=0A=
>=0A=
> The same for sit9531x_dev_probe().=0A=
=0A=
Both are static in v13 and the two declarations are gone from core.h,=0A=
with your Suggested-by on the patch.=0A=
=0A=
The same applies in patch 5 to sit9531x_dev_start(),=0A=
sit9531x_dev_stop() and sit9531x_clear_notifications(), which only=0A=
core.c calls. Their declarations are gone from core.h too.=0A=
=0A=
Thanks,=0A=
Ali=0A=
