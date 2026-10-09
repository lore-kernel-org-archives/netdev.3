Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8E51C07D;
	Fri,  9 Oct 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570735; cv=fail; b=lmheCOupMhyO7gLt389rYnuxJRL9tI8/uoIPeKSoOL6cv8GRFQudxpHpnv01A+rIqmezQsYrCBzF+8NZJyPFvodo62LcBaK3YFKDKaAVknGygddaaB9R4l26VlKP6DvcQpXc+jeKoL779c46K6vyIr3ZsMTAJiSrPSdFiY8EEzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570735; c=relaxed/simple;
	bh=Y/J46Is1NJ1hMZYwOP2kmuCMG0hHpWGlil1OofoK2XI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c202TthxwfOgJJhcQteFOrh6z8UAXKDQJ6YyrtLhgM7vjXhux66XYfCFE8JHTUuowZES8fWSxnIRabGxFXDu6Npr1IsuLXlUvjMwrgRQb9aB/AGYSt1XlMfvLdImQMzUhbB3utUTzKU4EJ0KNX3JuJX97LUak4a0qFDspZ2c6+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=kW1eo4Ji; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=zTFUVwgI; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="kW1eo4Ji";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="zTFUVwgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=A4929icmNRznkaaGFXcA/aZdELj8gzU8lMSur5Ya4Ls=;
 b=kW1eo4JixxcYOilZOxLKKHyZK2tWvJ9eeEFWHpnTp3hJb569+PuLae8jDxKwJfqMLAJAgktBFPS4Cp0VaSUJMaj/nQVfirJrEHoMtDL9Qp5ybHBqYl087zUKANUELt43F2q2VMvAmZk6unQBWfTmE1dHIC9pikb4fR396W8MLC4ffQz4aQoFQfudr8phO3tJWASAsGNhrpwSLoQbhVfWOGJv5q1XxhPPFdP1/VSS1094Hi1SY+3tea2EV2lGgrwD0MNMCXvq/nUvyEHNyEpHWHhtrp6ACwIjC3FGLK1PkRvbFbzvWIB/th7A92EWsxeQ0+L7fymbyEzR8DnhofVwRg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023142.outbound.protection.outlook.com [40.93.201.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6FCFDA80076;
	Fri,  9 Oct 2026 18:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8XHKSKgF1ArLZITYXoEx0fKjlxKhrZX5hS0dUWwL9QJW7tjGax/Wzhn+9NsaYzysLWP11WtYI28Z6XvyO5duUv0MGfseWgxYTooGjEzoBjR+peReuUeqa26OYb9Pls6Vx03NJ2OyY9Q4KtBQ2mW2PcVPnm/PbGafLY8wN29YwWE9wr0+eRKnRuv8UH05Sz/V6RgFdrDNMr+eBwI8l1+W/fvpWThYZNuV3uxPj0lCA59wPUtaLEw8b+3E+5bMU2MnoA2wE35F2zrKUzHhl7pay2woQ8Bc4Nf/2u2VLNjBuk/qZgDoo8Sq1dUqNpakYVxXW7eogek18XAT3/TPVUBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4929icmNRznkaaGFXcA/aZdELj8gzU8lMSur5Ya4Ls=;
 b=FDZzrivPean8RrUdl8lCCU7xXO+tuW4SgolupCBZLqQ3yxDVpV9X1MNykHPIu23tnXj3QUL4EeTBHAAu0YS7q4+AoNxqcMdq04VDvKyQOO3GeJJ06lX7tVLS0banHZRJekCkS4zv2XuTYbrrBz0DbjUweRh1BDi7zpClSTytE4HZ3aEomh/T2g1nfX48yYg+KXvOHaFStmS9YQyUkHLHs0r/5HHk3Csz9nzEFc/wHhqNHFTJ6wLeD7WF8GdIluZhK+Qj3A9q0y0oyPTTx2WLjVxu++guVqFRnj4hXqInvlHSkZO0OMsYMtPTj2VN7fgJsVp01s+0WTs0iy65VOY64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4929icmNRznkaaGFXcA/aZdELj8gzU8lMSur5Ya4Ls=;
 b=zTFUVwgId7ZcdKgMgNunIbpm1jTK72iKz5sqUeVIJXBik3VxeGY4abGGNOBrhJ3uWQNc11Em7hoBNL14DtvcaK+Xq6X+SP1bHuhagGUjlSbJbWctBmJFCl4V+5FlEKQsXVU1/ZbPBLzxHFqBcz4eUOoAiRyx12i/413hL/b6OKlTdHXADmBTiEzEGfc5q1W5LMNSNBP+wEjmxAzV1yESeVAa2Os1P5qk9PcjNYlUx15646CzzbzgCBkRLE30J9uj4XWtS84L98OHdmt18tfiWm7YpAVksw9JWJExHrl/V1tTGmn9Wsp1PY8xpB2lBytQoS7uxxKR30eIUfPJfz7yHw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:59 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:59 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 10/12] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v12 10/12] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdWBx4eh1tRDHf9E+4XHHRd+Qvqw==
Date: Fri, 9 Oct 2026 18:31:58 +0000
Message-ID: <20261009183151.78497-11-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
In-Reply-To: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH8PR20MB995515:EE_
x-ms-office365-filtering-correlation-id: 9c8e9d31-68db-4d37-c28e-08df26339b36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|260925021311599003|260925021911599003|260925022911599003|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 wq8oR7Yy46VIpLJINaIUNp74xdLKytSeYzMxzHVua+zEzRiGnBCNu5KKvXc6xx15KK9DmbpETVTfbZTAdY3uBu0Kv2RbvLHWkG/TGjvP779m/f0RwN5f2XrxTR0VWEXN5bwy3KFEieVCpcSp2FKOgBQ3ejrih3jfStCfBaH21HE6RqPEVblKhw9SaHefXqHaVROGNRwS27t7UTVVTUd6SUeE8yLUyOLj32uJX5Rbk1NkDHhT5sb4K3l0qoKBCbyYqWi2z7TgaKr48Y0RhwhbZyh6EPQagFemCH5fPFDsCsK7Q/geICL5WTloU6LMny31xcSE13Vqs6yilTFYv5OPWx1qg/SvUaGk6HeyvipyPx+Fk/udAWXiTNxzropz4GPb8OT8PuH6D2yc4d02kFNtEzpATvvN9/Zb37wbkWnzkqZoz5fbw1KbGHplBTV+06baX/QMNFZy56MNb5Ct69HJ7CayuhAC5pjWmk3RKOwtEDVeqUMNhzsJMAMtsGtX/8j/N51YutXPgfEjADzMjJ7jY/edhtFsfarRuSCjn/yfr5t54IhlCYLgyEy8w8l6LqzQECTXwj+X0cv4fMKZiJTViTh7Puea2rZTz6QZtxIHzXsywaT6j2YVlIbFwGW8qry46DQSdeEu0+xGODWvBAPyDdd0bAsuuIdOxMg+oSozlWXYOOwn/yzrY13Z/zpCDZ0eBJJm4nJRicq15juY7/LWyphs1PAT1DKRAmIaF1/MPMQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5vHmc0AU6Fu7v0Bq/n4K1qatfXOc50FESoKAZDnh9shNXca8Gv9qu5DhjW?=
 =?iso-8859-1?Q?Sem5RiiMxWIVb8RPiPEURhLRj28sKYrU8b/H57woldMSrjsp3YkECGhrni?=
 =?iso-8859-1?Q?fb9/uChGUJDB7Ieq2Vf/su2rb+4r8hHSLduGUischp6yDm39mjfVvXCcYt?=
 =?iso-8859-1?Q?b+IvcB+dMj179GGTlUSWJALCU+aCG0F2mYbt3RMNFJEHPDwzBjrDBzY9EV?=
 =?iso-8859-1?Q?y9fmKDPWq3dEqAsVNo6E5gTDlc8gOYYanXPIUb694zANYxzeJQlYjgc30T?=
 =?iso-8859-1?Q?7qk+2OwG4iUgJKpM+2DLQdw7tHJmqNG3HOBJf6aFkYBq1qvjpAC9gV04Mh?=
 =?iso-8859-1?Q?2x4N67YmWSOb0hHnTRELBgXgQa5KnaUer2Yhjzz7h4Jsz+b4fZ+RVQvI2X?=
 =?iso-8859-1?Q?b0T4kVaMJbApJysVwHpzMfp+O8bJ+amTzslKtyg6FolCj7kq5BUbbnmude?=
 =?iso-8859-1?Q?TTClY9XJnNF/ZUph+BIWbcYrmKmc8YedLKvcb5RhttmPsnRI/GjO1OHaF+?=
 =?iso-8859-1?Q?NCmX8Cwe4KmI1d1O81U5X1xf6teOShheprEGlJHCBM/fGuF5q0zbQ+FV1z?=
 =?iso-8859-1?Q?XWA9E0pLupxU4wjVvbVPsZBl/5E3Ezhelb09FZTZGYz4E1SExFS0apcb7L?=
 =?iso-8859-1?Q?1YmZnf9FCy8UtvEMezJdKrB0EjsmETvVU3tCqmhvTcO0eL2McIK7aopqip?=
 =?iso-8859-1?Q?53A2Ygud7f8u1nNPjKTYHJOcYvUnu0/YQs87/PiLg19bc4tGEBFq5Mthlo?=
 =?iso-8859-1?Q?KdTbqYp1VLNcSJs+NTMEvTud5LqDwbu/TbIyQ5w28ZW0HAagilAmyGDkIr?=
 =?iso-8859-1?Q?P5vHiqnk7WGkDCpcXVHTNFINHZPNYaX75cJIR98zNo5g9mUJM85Cmb2bfS?=
 =?iso-8859-1?Q?RimUcGw8X1b06IrQM7IqWnUR9ll3WJVWLOyYVv0AXPcK7WpaOzi5h2jV6o?=
 =?iso-8859-1?Q?wMCmTy0F9wZYLbUc8yZPYekVIMRa2/I+f5+gPY8uUf9fLFbOPt8bu3PpN1?=
 =?iso-8859-1?Q?aTEa32btm4QKsDQhCBW21Uhg5Pl9YcKLXjvzvk6tVQiblMduuwq9p/ZmMW?=
 =?iso-8859-1?Q?mlUVFHGshh6PPy/KkvK49Ia7Fis6QYGgpFZRw1uzi/DSnnrN4/H92LfB+h?=
 =?iso-8859-1?Q?wHPE1BZgLzqjuZybGULGgMNEJ5vFt9kdonDMkBsPQDvMn29dQquY5wE0g0?=
 =?iso-8859-1?Q?Yrqj7x8fkgOpE+AvHYVq9UjOnXB8TwQ9TyHIMGQE832xvcBlBHk715A5c6?=
 =?iso-8859-1?Q?KxahvW9h+2QfzG57lt+/sJg3QHgSU3cEF2JqHlJlNtLTVt7mU6ZGMvTXKI?=
 =?iso-8859-1?Q?fG6EP19edyc9vW/fplz1K9812SG7DKGHev3EeonaJqvJ7HpwWm9S1YzaQJ?=
 =?iso-8859-1?Q?nF7iBjqeqKRJEJgpvLkc/xbVFD91Ynpwl/Wntf+TOr/9UjkXWzx/PxbA9E?=
 =?iso-8859-1?Q?NVFGDqJMkONEd/6S2L1ol0XG7z+j32kblfqaUdVlOCcN4lTt1Z0tFeX3p6?=
 =?iso-8859-1?Q?qFMzMx7KAMJgnhB+ho7kcfGMpOAOe9CyZ7S0Y6YaewL+8YvMiEu3+me57T?=
 =?iso-8859-1?Q?tYka3H9xplQa/oA99iGtGX/T4d6KeRTiRuPZ2SnyEZ77r1mR08WouaWXuV?=
 =?iso-8859-1?Q?h9ImbKMz6D88NI2NzLW5xD42AdpF32hkPKs099vzrN9eGd053VOHuRDDaZ?=
 =?iso-8859-1?Q?Z30GSboquT2NKOzC8XDL9RFbJ0aqP93pWNfk48Ilfn+nbNRW5Oys1z5P8Q?=
 =?iso-8859-1?Q?Ha42e3OT1YK58ihR50W3crW4A2jTc+0TaXzvgT3vGNUUK+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	zbSBK1vsRQ3UKzP9jhYbXlMrdiG6x6TjGO9SJYVLSyyFQI2HuRpAUXpmhLLB7VlAzwwTrQBepvlrxsvtjgsG59kxFOfwBWLNW5zRfow9fEsbBeQrqOXDknejMuKYqa8ouFBHw4KYZCvoM6eYAuhOGcUep8VTzsWj/NHaret2sk9JaPRaRNnBVrm4PsXCsibJXv1HQL8G2sbpQeEHZgI6HyhAz5HlrTxmxluKAJ2tbQffg44E3gRhjDqyPooAzZerYq1heKY9+e8nL762gn0vYENMeHgzKgqaVPheAyv4UEOxlPdqRDPoUMceDkerq7PC23kfcqDqg28I8PmecpVH4A==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8e9d31-68db-4d37-c28e-08df26339b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:58.9481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxCbxyXiXRftUvG7+b7o0/unqNWjleG1uUGzSot9si2xVzafk7UE5hsGvwloeE7Joc960lbsJN2RyqnpdlL45w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570722-B6ET_xzQxF_P
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570722;B6ET_xzQxF_P;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Shift an output in time against the others driven by the same PLL.  The=0A=
device has a coarse delay counted in VCO cycles and a three-bit fine field=
=0A=
in fixed thirty-picosecond steps, so a requested offset is split between=0A=
the two and what the core reads back is what the registers hold rather=0A=
than what was asked for.  The divider spends two VCO cycles acting on a=0A=
programmed delay before it releases the output, so the registers hold the=
=0A=
request plus those two cycles and the read-back takes them off again.=0A=
=0A=
The window advertised to the core is one millisecond either way: the=0A=
device holds a delay anywhere within the output period, so on a slow=0A=
output the bound is the signed 32-bit picosecond attribute rather than=0A=
the hardware, and a round figure below it costs nothing and is what=0A=
keeps the subsystem from refusing every request; the granularity is one=0A=
picosecond, because the achievable delays are whole VCO cycles plus=0A=
thirty-picosecond steps and so form no uniform lattice for the core to=0A=
check against.=0A=
=0A=
Delay only ever advances, so an offset larger than one output period is=0A=
folded back into a single period -- for a periodic signal that is the=0A=
same phase.  The fold is counted in VCO cycles, since the period is=0A=
exactly the divider's count of them, and the quantizer takes whichever=0A=
of the neighbouring whole cycles with the fine steps lands nearest.  An=0A=
advance is held as the complementary delay and reads back as an advance=0A=
only where the period exceeds the advertised window; elsewhere the two=0A=
describe the same edge and the delay form is reported.  A delay the=0A=
loaded configuration left beyond the window is reported clamped and is=0A=
not carried into a later rate change.  A rate change on an output with a=0A=
programmed delay re-times it inside the rate change's own programming=0A=
window, so there is one sequence and one flush, and a flush that failed=0A=
after the delay was committed is retried by the next request.  The write=0A=
takes effect in the programming state, which is left with the loops=0A=
re-locked even when a write inside it failed.=0A=
=0A=
The device has no per-output phase flush, so realigning the adjusted=0A=
output restarts the divider phase of every output that PLL drives.  On a=0A=
part where outputs are deliberately skewed against each other that is a=0A=
visible edge jump on the others, and there is no register that would let=0A=
the driver avoid it.  A PLL the loaded profile builds without the=0A=
phase-flush feature has no flush to fire; realigning its outputs=0A=
restarts the whole PLL, so a phase adjust or a rate change on such a PLL=0A=
is a loss of lock as well as an edge jump on its other outputs.=0A=
=0A=
Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 662 +++++++++++++++++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/core.h |  22 ++=0A=
 drivers/dpll/sit9531x/dpll.c |  80 +++++=0A=
 drivers/dpll/sit9531x/prop.c |  22 ++=0A=
 drivers/dpll/sit9531x/regs.h |  37 ++=0A=
 5 files changed, 798 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 19aeabd3cd4f..8a8872b18d2c 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2264,11 +2264,422 @@ static int sit9531x_output_divo_read(struct sit953=
1x_dev *sitdev, u8 out_idx,=0A=
 	return *divo ? 0 : -ENODATA;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Phase adjust (PRG_RST_DELAY register-based).=0A=
+ *=0A=
+ * The chip exposes a per-output 34-bit coarse delay measured in VCO=0A=
+ * clock periods plus a 3-bit fine delay in fixed 30 ps steps.  The=0A=
+ * five bytes PROG6..PROG2 hold the field across registers:=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Slots 0-5 live on Page 3, slots 6-11 on Page 4, with each slot's=0A=
+ * block at base =3D 0x15 + 16 * (slot % 6); the slot is the physical=0A=
+ * output position from clkout_map[], not the logical output index.=0A=
+ *=0A=
+ * The chip only supports unsigned positive delay.  Requests are folded=0A=
+ * modulo one output period: positive delays wrap naturally and a negative=
=0A=
+ * phase adjustment (advance) is rendered as (T_out - |phase|).=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * Register of byte @i (PROG6 first) of an output's PRG_RST_DELAY block.=
=0A=
+ *=0A=
+ * The logical output index maps to the chip's physical output slot.  On=
=0A=
+ * SiT95317 the eight logical outputs land on chip slots {0, 3, 4, 5, 7,=
=0A=
+ * 8, 9, 11}; on SiT95316 the map is identity.  Page and base address the=
=0A=
+ * slot, not the logical index.=0A=
+ */=0A=
+static unsigned int sit9531x_output_prg_reg(struct sit9531x_dev *sitdev,=
=0A=
+					    u8 out_idx, u8 i)=0A=
+{=0A=
+	u8 slot =3D sitdev->info->clkout_map[out_idx];=0A=
+	u8 page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+		  SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	u8 base =3D SIT9531X_OUT_PRG_DELAY_BASE +=0A=
+		  SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	return SIT9531X_REG(page, base + i);=0A=
+}=0A=
+=0A=
+/* Read the PRG_RST_DELAY bytes of an output, PROG6 first. */=0A=
+static int sit9531x_output_phase_bytes_read(struct sit9531x_dev *sitdev,=
=0A=
+					    u8 out_idx, u8 *bytes)=0A=
+{=0A=
+	int rc;=0A=
+	u8 i;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_OUT_PRG_BYTES; i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      sit9531x_output_prg_reg(sitdev, out_idx, i),=0A=
+				      &bytes[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Encode a quantized delay into the register bytes.  @old_bytes supplies=
=0A=
+ * the PROG6 bits that are not the delay's, which are preserved.=0A=
+ *=0A=
+ * The register value carries the divider's own settling time: the=0A=
+ * quantizer works in the delay the caller asked for, the register wants=
=0A=
+ * that plus the two VCO cycles the divider spends acting on it, and a=0A=
+ * request of zero still waits those two.  Only the register value carries=
=0A=
+ * them; @coarse stays the requested delay, which is what gets cached.=0A=
+ */=0A=
+static void sit9531x_output_phase_bytes_build(const u8 *old_bytes, u64 coa=
rse,=0A=
+					      u8 fine, u8 *new_bytes)=0A=
+{=0A=
+	u64 prg_coarse =3D coarse + SIT9531X_OUT_PRG_DIVO_CYCLES;=0A=
+=0A=
+	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */=0A=
+	new_bytes[0] =3D old_bytes[0] & SIT9531X_OUT_PRG_OPSTG_MASK;=0A=
+	new_bytes[0] |=3D (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &=0A=
+			SIT9531X_OUT_PRG_FINE_MASK;=0A=
+	new_bytes[0] |=3D (u8)((prg_coarse >> 32) &=0A=
+			     SIT9531X_OUT_PRG_COARSE_HI_MASK);=0A=
+	new_bytes[1] =3D (u8)((prg_coarse >> 24) & 0xFF);=0A=
+	new_bytes[2] =3D (u8)((prg_coarse >> 16) & 0xFF);=0A=
+	new_bytes[3] =3D (u8)((prg_coarse >> 8) & 0xFF);=0A=
+	new_bytes[4] =3D (u8)(prg_coarse & 0xFF);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Write an output's delay bytes.  The caller must already be in the=0A=
+ * programming state.  On a failure every byte is put back, the one whose=
=0A=
+ * write reported the error included, since it may have reached the part.=
=0A=
+ */=0A=
+static int sit9531x_output_phase_bytes_write(struct sit9531x_dev *sitdev,=
=0A=
+					     u8 out_idx, const u8 *new_bytes,=0A=
+					     const u8 *old_bytes)=0A=
+{=0A=
+	int rc, ret, rb_rc =3D 0;=0A=
+	u8 i;=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_OUT_PRG_BYTES; i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       sit9531x_output_prg_reg(sitdev, out_idx, i),=0A=
+				       new_bytes[i]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+rollback:=0A=
+	for (i =3D 0; i < SIT9531X_OUT_PRG_BYTES; i++) {=0A=
+		ret =3D sit9531x_write_u8(sitdev,=0A=
+					sit9531x_output_prg_reg(sitdev, out_idx, i),=0A=
+					old_bytes[i]);=0A=
+		if (ret && !rb_rc)=0A=
+			rb_rc =3D ret;=0A=
+	}=0A=
+	if (rb_rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"out%u: phase-adjust rollback failed (%d), the delay registers are part=
 old and part new\n",=0A=
+			out_idx, rb_rc);=0A=
+		if (!rc)=0A=
+			rc =3D rb_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Error of realizing @abs_ps as @cycles whole VCO cycles plus the fine=0A=
+ * steps that come nearest, which are returned through @fine.=0A=
+ */=0A=
+static u64 sit9531x_output_phase_quant_err(u64 abs_ps, u64 fvco, u64 cycle=
s,=0A=
+					   u8 *fine)=0A=
+{=0A=
+	u64 cycles_ps, steps =3D 0;=0A=
+=0A=
+	cycles_ps =3D mul_u64_u64_div_u64(cycles, 1000000000000ULL, fvco);=0A=
+	if (abs_ps > cycles_ps)=0A=
+		steps =3D div64_u64(abs_ps - cycles_ps +=0A=
+				  SIT9531X_OUT_PRG_FINE_STEP_PS / 2,=0A=
+				  SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+	*fine =3D min_t(u64, steps, SIT9531X_OUT_PRG_FINE_MAX);=0A=
+=0A=
+	return abs_diff(abs_ps, cycles_ps +=0A=
+			(u64)*fine * SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Quantize a phase request: fold @phase_ps into one output period and=0A=
+ * split it into whole VCO cycles (@coarse_out, without the divider's=0A=
+ * settling cycles) and fine steps (@fine_out).  @phase_adj gets the delay=
=0A=
+ * the two realize, in the request's sign and bounded to the advertised=0A=
+ * range, which is what the cache holds.  Pure arithmetic against @fvco=0A=
+ * and the divider @divo the output runs on, so a caller can encode=0A=
+ * before it enters the programming state.=0A=
+ */=0A=
+static int sit9531x_output_phase_encode(u64 fvco, u64 divo, s32 phase_ps,=
=0A=
+					u64 *coarse_out, u8 *fine_out,=0A=
+					s32 *phase_adj)=0A=
+{=0A=
+	u64 abs_ps, cycles, frac_ps, coarse =3D 0, coarse_ps, t_out_ps;=0A=
+	s64 phase_norm_ps =3D 0;=0A=
+	u8 fine =3D 0;=0A=
+=0A=
+	t_out_ps =3D mul_u64_u64_div_u64(divo, 1000000000000ULL, fvco);=0A=
+	if (!t_out_ps)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Convert to unsigned absolute delay.  Both signs are folded=0A=
+	 * modulo one period: positive delays wrap naturally, negative=0A=
+	 * delays are rendered as T_out - |phase|.  abs() is safe here=0A=
+	 * because the core rejects anything outside the advertised phase=0A=
+	 * range, which is +/-1 ms.=0A=
+	 *=0A=
+	 * The period is exactly DIVO VCO cycles, whereas in picoseconds it=0A=
+	 * is a fraction more often than not: 7812.5 ps at 128 MHz from a=0A=
+	 * 5.12 GHz VCO, and a fold on the truncated 7812 drops the half=0A=
+	 * picosecond once per period folded away, so 100 us -- 12800=0A=
+	 * periods exactly -- would come out as 6400 ps rather than nothing.=0A=
+	 * Fold the whole VCO cycles of the request modulo DIVO instead, and=0A=
+	 * carry the sub-cycle part across as it is.  div64_u64_rem() rather=0A=
+	 * than the % operator: a 64-bit modulo has no compiler helper on=0A=
+	 * 32-bit targets and leaves the module with an undefined __umoddi3.=0A=
+	 */=0A=
+	abs_ps =3D abs(phase_ps);=0A=
+	cycles =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);=0A=
+	frac_ps =3D abs_ps - mul_u64_u64_div_u64(cycles, 1000000000000ULL, fvco);=
=0A=
+	div64_u64_rem(cycles, divo, &cycles);=0A=
+	abs_ps =3D mul_u64_u64_div_u64(cycles, 1000000000000ULL, fvco) + frac_ps;=
=0A=
+	/*=0A=
+	 * The truncations above can put a request within a picosecond of a=0A=
+	 * whole period a picosecond past it; that is the same edge as none.=0A=
+	 */=0A=
+	if (abs_ps >=3D t_out_ps)=0A=
+		abs_ps =3D 0;=0A=
+	phase_norm_ps =3D phase_ps < 0 ? -(s64)abs_ps : (s64)abs_ps;=0A=
+	abs_ps =3D (phase_ps < 0 && abs_ps) ? t_out_ps - abs_ps : abs_ps;=0A=
+=0A=
+	if (abs_ps) {=0A=
+		u64 floor_cycles, err, alt_err;=0A=
+		u8 alt_fine;=0A=
+=0A=
+		/*=0A=
+		 * coarse_cycles =3D abs_ps * Fvco / 1e12 ps/s.=0A=
+		 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches=0A=
+		 * one second of 1 PPS wrap-around.=0A=
+		 */=0A=
+		floor_cycles =3D mul_u64_u64_div_u64(abs_ps, fvco,=0A=
+						   1000000000000ULL);=0A=
+=0A=
+		/*=0A=
+		 * Fine =3D round((abs_ps - coarse * vco_period_ps) / 30 ps).=0A=
+		 * The fine field spans 210 ps, more than one VCO cycle in=0A=
+		 * every band, so the cycle count that floors the request is=0A=
+		 * not always the nearest encoding: one cycle more can land=0A=
+		 * closer than any fine code when the remainder sits just=0A=
+		 * under a cycle, and one cycle fewer with a larger fine code=0A=
+		 * can land closer or exact -- 210 ps at 5 GHz is seven fine=0A=
+		 * steps, not a cycle and a ten picosecond remainder.  Take=0A=
+		 * the nearest of the three, the floor on a tie.=0A=
+		 */=0A=
+		coarse =3D floor_cycles;=0A=
+		err =3D sit9531x_output_phase_quant_err(abs_ps, fvco, coarse,=0A=
+						      &fine);=0A=
+		alt_err =3D sit9531x_output_phase_quant_err(abs_ps, fvco,=0A=
+							  floor_cycles + 1,=0A=
+							  &alt_fine);=0A=
+		if (alt_err < err) {=0A=
+			coarse =3D floor_cycles + 1;=0A=
+			fine =3D alt_fine;=0A=
+			err =3D alt_err;=0A=
+		}=0A=
+		if (floor_cycles) {=0A=
+			alt_err =3D sit9531x_output_phase_quant_err(abs_ps, fvco,=0A=
+								  floor_cycles - 1,=0A=
+								  &alt_fine);=0A=
+			if (alt_err < err) {=0A=
+				coarse =3D floor_cycles - 1;=0A=
+				fine =3D alt_fine;=0A=
+			}=0A=
+		}=0A=
+=0A=
+		/*=0A=
+		 * A delay that quantizes to a whole output period or beyond=0A=
+		 * is the same edge as no delay at all; program none, so the=0A=
+		 * registers hold no residual past the period and the cache=0A=
+		 * below describes exactly what they realize.=0A=
+		 */=0A=
+		coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+		if (coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS >=3D=0A=
+		    t_out_ps) {=0A=
+			coarse =3D 0;=0A=
+			fine =3D 0;=0A=
+		}=0A=
+=0A=
+		if (coarse + SIT9531X_OUT_PRG_DIVO_CYCLES >=3D=0A=
+		    (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))=0A=
+			return -ERANGE;=0A=
+	}=0A=
+=0A=
+	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	abs_ps =3D coarse_ps + (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;=0A=
+	/*=0A=
+	 * Quantization can also land a few picoseconds past the end of the=0A=
+	 * advertised range, which the getter must not report.  Bound both=0A=
+	 * signs to the range; the positive one is also what keeps the cast=0A=
+	 * to the s32 the ABI carries safe.=0A=
+	 */=0A=
+	if (phase_norm_ps < 0)=0A=
+		*phase_adj =3D abs_ps ?=0A=
+			     -(s32)min_t(u64, t_out_ps - abs_ps,=0A=
+					  SIT9531X_OUT_PHASE_ADJ_MAX_PS) : 0;=0A=
+	else=0A=
+		*phase_adj =3D (s32)min_t(u64, abs_ps,=0A=
+					 SIT9531X_OUT_PHASE_ADJ_MAX_PS);=0A=
+=0A=
+	*coarse_out =3D coarse;=0A=
+	*fine_out =3D fine;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * sit9531x_output_phase_read - read an output's programmed delay back=0A=
+ * @sitdev:	device pointer=0A=
+ * @out_idx:	logical output index=0A=
+ * @phase_ps:	result in picoseconds, in the advertised range=0A=
+ * @clamped:	set when the delay lies beyond the advertised range either=0A=
+ *		way and @phase_ps reports the end of the range in its place=0A=
+ *=0A=
+ * The delay the chip holds is part of the profile it loads before probe,=
=0A=
+ * and a rate or phase request that failed after its writes reached the=0A=
+ * device leaves the cache describing something else.  Decoding the five=
=0A=
+ * PRG_RST_DELAY bytes is the only way to say what the output is really=0A=
+ * doing.  The registers carry an unsigned delay, and an advance is held=
=0A=
+ * as its complement to the output period.  The two can only be told=0A=
+ * apart on an output whose period is longer than the advertised range:=0A=
+ * there a delay beyond the range whose complement is within it reads=0A=
+ * back as that advance.  On a faster output every delay is within the=0A=
+ * range, and an advance that was set reads back as the delay to the same=
=0A=
+ * edge, which is the same phase.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA for an output no PLL drives or whose VCO=
=0A=
+ * rate is unknown, <0 on register access error=0A=
+ */=0A=
+int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			       s32 *phase_ps, bool *clamped)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 bytes[SIT9531X_OUT_PRG_BYTES], fine;=0A=
+	u64 coarse =3D 0, fvco, ps, divo;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	*clamped =3D false;=0A=
+=0A=
+	/*=0A=
+	 * An output no PLL drives has no Fvco to decode its delay against;=0A=
+	 * pll_idx then holds a placeholder, not a routing.=0A=
+	 */=0A=
+	if (!sitdev->out[out_idx].routed)=0A=
+		return -ENODATA;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, sitdev->out[out_idx].pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_phase_bytes_read(sitdev, out_idx, bytes);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	fine =3D (bytes[0] & SIT9531X_OUT_PRG_FINE_MASK) >>=0A=
+	       SIT9531X_OUT_PRG_FINE_SHIFT;=0A=
+	coarse =3D (u64)(bytes[0] & SIT9531X_OUT_PRG_COARSE_HI_MASK) << 32;=0A=
+	coarse |=3D (u64)bytes[1] << 24;=0A=
+	coarse |=3D (u64)bytes[2] << 16;=0A=
+	coarse |=3D (u64)bytes[3] << 8;=0A=
+	coarse |=3D bytes[4];=0A=
+=0A=
+	/*=0A=
+	 * The register carries the divider's settling time on top of the=0A=
+	 * delay that was asked for, so take it back off.  A profile can=0A=
+	 * leave a value below it, which describes no delay at all.=0A=
+	 */=0A=
+	coarse =3D (coarse > SIT9531X_OUT_PRG_DIVO_CYCLES) ?=0A=
+		 coarse - SIT9531X_OUT_PRG_DIVO_CYCLES : 0;=0A=
+=0A=
+	/*=0A=
+	 * The setter holds an advance as T_out - |advance|, so a delay=0A=
+	 * beyond the advertised range whose complement is within it is that=0A=
+	 * advance and reads back as one.  Anything else a profile left=0A=
+	 * beyond the range -- wider than an s32 on a slow output -- reports=0A=
+	 * the end of the range rather than a value the setter would refuse,=0A=
+	 * and says so: the end of the range is not the delay, and a rate=0A=
+	 * change must not re-time it into the device as though it were.=0A=
+	 *=0A=
+	 * The period comes from the divider rather than from the cached rate,=0A=
+	 * which is still unset at probe and whole hertz at best.  An output=0A=
+	 * without a programmed divider has no period to fold against; a=0A=
+	 * divider that could not be read is an error, not a missing one,=0A=
+	 * since the unfolded value would be cached as the realized delay.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_divo_read(sitdev, out_idx, &divo);=0A=
+	if (rc && rc !=3D -ENODATA)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * The period is exactly DIVO VCO cycles, so fold the cycle count=0A=
+	 * rather than the picoseconds it converts to, which would drop the=0A=
+	 * fraction of a picosecond of the period once per period folded=0A=
+	 * away (see sit9531x_output_phase_encode()).  The fine steps can=0A=
+	 * still carry the sum a fraction of a cycle past the period; one=0A=
+	 * subtraction folds that without anything to accumulate.=0A=
+	 */=0A=
+	if (!rc)=0A=
+		div64_u64_rem(coarse, divo, &coarse);=0A=
+=0A=
+	ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	ps +=3D (u64)fine * SIT9531X_OUT_PRG_FINE_STEP_PS;=0A=
+=0A=
+	if (!rc) {=0A=
+		u64 t_out_ps =3D mul_u64_u64_div_u64(divo, 1000000000000ULL,=0A=
+						   fvco);=0A=
+=0A=
+		if (ps >=3D t_out_ps)=0A=
+			ps -=3D t_out_ps;=0A=
+		if (ps > SIT9531X_OUT_PHASE_ADJ_MAX_PS &&=0A=
+		    t_out_ps - ps <=3D SIT9531X_OUT_PHASE_ADJ_MAX_PS) {=0A=
+			*phase_ps =3D -(s32)(t_out_ps - ps);=0A=
+			return 0;=0A=
+		}=0A=
+	}=0A=
+	*clamped =3D ps > SIT9531X_OUT_PHASE_ADJ_MAX_PS;=0A=
+	*phase_ps =3D (s32)min_t(u64, ps, SIT9531X_OUT_PHASE_ADJ_MAX_PS);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
 			     u8 pll_idx, u64 frequency)=0A=
 {=0A=
-	u64 fvco, divo;=0A=
+	u8 old_bytes[SIT9531X_OUT_PRG_BYTES], new_bytes[SIT9531X_OUT_PRG_BYTES];=
=0A=
+	u64 fvco, divo, coarse;=0A=
+	bool retime =3D false;=0A=
+	s32 phase_adj =3D 0;=0A=
 	int rc, ret;=0A=
+	u8 fine;=0A=
 =0A=
 	lockdep_assert_held(&sitdev->multiop_lock);=0A=
 =0A=
@@ -2277,11 +2688,44 @@ int sit9531x_output_freq_set(struct sit9531x_dev *s=
itdev, u8 out_idx,=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	/*=0A=
+	 * The programmed reset delay counts VCO cycles, and a rate change=0A=
+	 * moves only the divider, so a positive delay keeps its timing; an=0A=
+	 * advance, though, is held as T_out - |advance| and has to be=0A=
+	 * re-encoded against the new period.  Re-encode the delay the output=0A=
+	 * realizes, which is what the cache holds, against the new divider,=0A=
+	 * and write it in the same programming window as the divider: the=0A=
+	 * rate change then costs one commit and one flush.  A second window=0A=
+	 * would open the output loops and wait out their settling again, and=0A=
+	 * a second flush would restart the PLL's dividers again -- or, on a=0A=
+	 * PLL the profile builds without the phase-flush feature, the PLL=0A=
+	 * itself.  For a positive delay the bytes come out the same and=0A=
+	 * nothing is written.  A re-time that cannot be worked out fails=0A=
+	 * the request before anything is written.=0A=
+	 */=0A=
+	if (sitdev->out[out_idx].phase_armed) {=0A=
+		rc =3D sit9531x_output_phase_encode(fvco, divo,=0A=
+						  sitdev->out[out_idx].phase_adj,=0A=
+						  &coarse, &fine, &phase_adj);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		rc =3D sit9531x_output_phase_bytes_read(sitdev, out_idx,=0A=
+						      old_bytes);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		sit9531x_output_phase_bytes_build(old_bytes, coarse, fine,=0A=
+						  new_bytes);=0A=
+		retime =3D memcmp(old_bytes, new_bytes, sizeof(new_bytes)) !=3D 0;=0A=
+	}=0A=
+=0A=
 	rc =3D sit9531x_prg_enter(sitdev);=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
 	rc =3D sit9531x_output_divo_write(sitdev, out_idx, divo);=0A=
+	if (!rc && retime)=0A=
+		rc =3D sit9531x_output_phase_bytes_write(sitdev, out_idx,=0A=
+						       new_bytes, old_bytes);=0A=
 	/*=0A=
 	 * Step 4: NVM update + loop lock.  Always run prg_commit() so the chip=
=0A=
 	 * leaves the PRG_CMD state with the output loops re-locked, even when a=
=0A=
@@ -2291,8 +2735,22 @@ int sit9531x_output_freq_set(struct sit9531x_dev *si=
tdev, u8 out_idx,=0A=
 	ret =3D sit9531x_prg_commit(sitdev);=0A=
 	if (ret && !rc)=0A=
 		rc =3D ret;=0A=
-	if (rc)=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The divider may have changed all the same: a failed update=0A=
+		 * can have reached the part, a loop lock can fail after it=0A=
+		 * took effect, and a failed rollback leaves whatever landed.=0A=
+		 * An advance is held as T_out - |advance| against the period=0A=
+		 * that was, and the re-timed bytes may or may not be in, so=0A=
+		 * the cache no longer says what the output does.  Mark it for=0A=
+		 * a read-back: the core drops a retry of either request,=0A=
+		 * the rate because it reads the new one first and the phase=0A=
+		 * because it would match the stale cache.=0A=
+		 */=0A=
+		if (sitdev->out[out_idx].phase_armed)=0A=
+			sitdev->out[out_idx].phase_stale =3D true;=0A=
 		return rc;=0A=
+	}=0A=
 =0A=
 	/*=0A=
 	 * Step 5: flush the PLL's output phase so the new DIVO starts=0A=
@@ -2305,19 +2763,31 @@ int sit9531x_output_freq_set(struct sit9531x_dev *s=
itdev, u8 out_idx,=0A=
 	 * divider on its old phase, which is a realignment that did not=0A=
 	 * happen rather than a rate that did not change -- and reporting a=0A=
 	 * failure would be doubly wrong, because the core asks for the=0A=
-	 * current rate first and would drop an identical retry.=0A=
+	 * current rate first and would drop an identical retry.  A re-timed=0A=
+	 * delay is then committed but not applied either; mark it for a=0A=
+	 * read-back rather than cache a value the flush did not realize.=0A=
 	 */=0A=
 	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
 	if (rc) {=0A=
 		dev_warn(sitdev->dev,=0A=
 			 "out%u: rate changed but the divider phase was not realigned (%d)\n",=
=0A=
 			 out_idx, rc);=0A=
+		if (retime)=0A=
+			sitdev->out[out_idx].phase_stale =3D true;=0A=
 		rc =3D 0;=0A=
+	} else {=0A=
+		/* Whatever flush was owed from before has now run. */=0A=
+		sitdev->out[out_idx].flush_pending =3D false;=0A=
+		if (retime) {=0A=
+			sitdev->out[out_idx].phase_adj =3D phase_adj;=0A=
+			sitdev->out[out_idx].phase_armed =3D phase_adj !=3D 0;=0A=
+			sitdev->out[out_idx].phase_stale =3D false;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
 =0A=
-	return 0;=0A=
+	return rc;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -2371,27 +2841,140 @@ int sit9531x_output_freq_get(struct sit9531x_dev *=
sitdev, u8 out_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Phase adjust (PRG_RST_DELAY register-based).=0A=
- *=0A=
- * The chip exposes a per-output 34-bit coarse delay measured in VCO=0A=
- * clock periods plus a 3-bit fine delay in fixed 30 ps steps.  The=0A=
- * five bytes PROG6..PROG2 hold the field across registers:=0A=
- *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved via RMW)=0A=
- *                    [4:2] PRG_RST_FINE_DELAY=0A=
- *                    [1:0] PRG_RST_DELAY[33:32]=0A=
- *   base + 1  PROG5  PRG_RST_DELAY[31:24]=0A=
- *   base + 2  PROG4  PRG_RST_DELAY[23:16]=0A=
- *   base + 3  PROG3  PRG_RST_DELAY[15:8]=0A=
- *   base + 4  PROG2  PRG_RST_DELAY[7:0]=0A=
- *=0A=
- * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each=0A=
- * output's block at base =3D 0x15 + 16 * (out_idx % 6).=0A=
- *=0A=
- * The chip only supports unsigned positive delay.  A negative phase=0A=
- * adjustment (advance) is wrapped to (T_out - |phase|) modulo one=0A=
- * output period, which is identical for a periodic signal.=0A=
- */=0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps)=0A=
+{=0A=
+	u8 old_bytes[SIT9531X_OUT_PRG_BYTES], new_bytes[SIT9531X_OUT_PRG_BYTES];=
=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo, coarse;=0A=
+	u8 pll_idx, fine;=0A=
+	s32 phase_adj;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	/*=0A=
+	 * The output period comes from the divider the output runs on, not=0A=
+	 * from the cached rate: that is whole hertz, so a profile's output at=0A=
+	 * a fractional rate would fold an advance against the wrong period.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_divo_read(sitdev, out_idx, &divo);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	rc =3D sit9531x_output_phase_encode(fvco, divo, phase_ps, &coarse, &fine,=
=0A=
+					  &phase_adj);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_phase_bytes_read(sitdev, out_idx, old_bytes);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	sit9531x_output_phase_bytes_build(old_bytes, coarse, fine, new_bytes);=0A=
+=0A=
+	/*=0A=
+	 * The pin advertises 1 ps granularity but caches the quantized=0A=
+	 * value, so a repeated off-grid request reaches here with the=0A=
+	 * registers already holding it.  Rewriting them would still restart=0A=
+	 * the divider phase of every output on the PLL; skip it unless an=0A=
+	 * earlier failure left the delay unconfirmed.  A delay whose flush=0A=
+	 * failed is committed and only owes that flush, which matching=0A=
+	 * bytes would otherwise skip as well.=0A=
+	 */=0A=
+	if (!memcmp(old_bytes, new_bytes, sizeof(new_bytes)) &&=0A=
+	    !sitdev->out[out_idx].phase_stale) {=0A=
+		if (!sitdev->out[out_idx].flush_pending)=0A=
+			goto cache;=0A=
+		goto flush;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The PRG_RST_DELAY bytes live in the output system, so the writes=0A=
+	 * only take effect when made inside the PRG_CMD programming state and=0A=
+	 * committed to the NVM shadow, exactly like sit9531x_output_freq_set().=
=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_phase_bytes_write(sitdev, out_idx, new_bytes,=0A=
+					       old_bytes);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even on a=0A=
+	 * mid-sequence write failure, so the output loops are re-locked rather=
=0A=
+	 * than stranded unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The delay registers were written and the rollback may not=0A=
+		 * have put all of them back, so what the output realizes is=0A=
+		 * no longer what the cache says.  Mark it so the getter reads=0A=
+		 * the registers instead of reporting the value that was=0A=
+		 * cached before this call.  No flush ran either way.=0A=
+		 */=0A=
+		sitdev->out[out_idx].phase_stale =3D true;=0A=
+		sitdev->out[out_idx].flush_pending =3D true;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+flush:=0A=
+	/*=0A=
+	 * Restart the output divider phase so the freshly programmed delay is=0A=
+	 * applied against a known edge instead of the divider's arbitrary=0A=
+	 * running phase.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc) {=0A=
+		/*=0A=
+		 * The delay is committed but the output keeps the phase it=0A=
+		 * had, so the cache is left as it is: it still says what the=0A=
+		 * output realizes.  Record the flush that is owed instead.=0A=
+		 * Marking the cache stale would have the getter publish the=0A=
+		 * new delay off the registers, the core would then drop a=0A=
+		 * retry as a request for the value already reported, and the=0A=
+		 * realignment would never run.=0A=
+		 */=0A=
+		sitdev->out[out_idx].flush_pending =3D true;=0A=
+		return rc;=0A=
+	}=0A=
+	sitdev->out[out_idx].flush_pending =3D false;=0A=
+	sitdev->out[out_idx].phase_stale =3D false;=0A=
+=0A=
+cache:=0A=
+	/*=0A=
+	 * Cache what the registers realize, and only once every step has=0A=
+	 * succeeded: the core drops a repeated request with the same value,=0A=
+	 * so a cache updated by a failed call would make the retry a no-op.=0A=
+	 */=0A=
+	sitdev->out[out_idx].phase_adj =3D phase_adj;=0A=
+=0A=
+	/*=0A=
+	 * Arm the re-time a rate change owes only for a delay that is=0A=
+	 * actually programmed: an advance is held as T_out - |advance|,=0A=
+	 * which has to be re-encoded against the new period.  A request=0A=
+	 * that quantized to nothing stays nothing at any rate, since the=0A=
+	 * quantum is the VCO cycle and not the output period, so there is=0A=
+	 * nothing to re-time for it.=0A=
+	 */=0A=
+	sitdev->out[out_idx].phase_armed =3D phase_adj !=3D 0;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
 =0A=
 /*=0A=
  * sit9531x_clear_notifications - clear all notification registers=0A=
@@ -2894,12 +3477,41 @@ static int sit9531x_dev_state_fetch(struct sit9531x=
_dev *sitdev)=0A=
 	}=0A=
 =0A=
 	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		bool clamped;=0A=
+		s32 phase_ps;=0A=
+=0A=
 		rc =3D sit9531x_out_state_fetch(sitdev, i);=0A=
 		if (rc) {=0A=
 			dev_err(sitdev->dev,=0A=
 				"Failed to fetch output %u state: %d\n", i, rc);=0A=
 			return rc;=0A=
 		}=0A=
+=0A=
+		/*=0A=
+		 * The delay registers are part of the profile the chip loads=0A=
+		 * before probe, so an output can already carry one.  Seeding=0A=
+		 * the cache from the device is what lets a request of 0 ps=0A=
+		 * clear it: the core drops a request equal to what the=0A=
+		 * getter reports, and a cache that started at zero would=0A=
+		 * make clearing a programmed delay impossible.  An output=0A=
+		 * the configuration does not route has no Fvco to decode=0A=
+		 * against, which is not an error here.  A delay beyond the=0A=
+		 * range is reported as its end but not armed: re-timing it=0A=
+		 * on a rate change would write that end over the profile's=0A=
+		 * delay.=0A=
+		 */=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_phase_read(sitdev, i, &phase_ps, &clamped);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (!rc) {=0A=
+			sitdev->out[i].phase_adj =3D phase_ps;=0A=
+			sitdev->out[i].phase_armed =3D !clamped && phase_ps;=0A=
+		} else if (rc !=3D -ENODATA) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"Failed to read output %u delay: %d\n",=0A=
+				i, rc);=0A=
+			return rc;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	/*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 0554b9f28503..19efff5112a3 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -27,6 +27,8 @@=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
 #define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/* Output phase-adjust range advertised to the core, +/-1 ms in ps */=0A=
+#define SIT9531X_OUT_PHASE_ADJ_MAX_PS	1000000000=0A=
 /*=0A=
  * INTSYNC (the inter-PLL sync net) is modeled as two pins.  The=0A=
  * destination PLL that locks to INTSYNC sees an input pin=0A=
@@ -104,6 +106,18 @@ struct sit9531x_ref {=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
+ * @phase_stale:	the programmed delay may differ from @phase_adj=0A=
+ * @flush_pending:	the programmed delay is committed but the flush=0A=
+ *			that applies it failed, so the output still realizes=0A=
+ *			@phase_adj; the next request for that delay runs the=0A=
+ *			flush although the registers already hold it=0A=
+ * @phase_armed:	a non-zero delay is programmed, so a rate change=0A=
+ *			has to re-time it; a profile delay beyond the=0A=
+ *			advertised range is not, since what the cache holds=0A=
+ *			for it is the end of the range, not the delay=0A=
+ * @phase_adj:		phase adjust the delay registers actually realize,=0A=
+ *			i.e. the last request quantized to whole VCO cycles=0A=
+ *			plus 30 ps fine steps, in the request's sign=0A=
  */=0A=
 struct sit9531x_out {=0A=
 	u64		freq;=0A=
@@ -112,6 +126,10 @@ struct sit9531x_out {=0A=
 	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
+	s32		phase_adj;=0A=
+	bool		phase_armed;=0A=
+	bool		phase_stale;=0A=
+	bool		flush_pending;=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -281,6 +299,10 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitd=
ev, u8 out_idx,=0A=
 			     u64 *frequency);=0A=
 =0A=
 /* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */=0A=
+int sit9531x_output_phase_read(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			       s32 *phase_ps, bool *clamped);=0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps);=0A=
 =0A=
 /* ---- Notification clear ---- */=0A=
 int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index fa650cc3177d..436e4b76a727 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -959,12 +959,92 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const stru=
ct dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustmen=
t=0A=
+ *=0A=
+ * Returns what the delay registers hold, i.e. the value=0A=
+ * sit9531x_output_phase_adjust_set() programmed after quantization, read=
=0A=
+ * from the cache unless a failed request left it unconfirmed.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 *phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	/*=0A=
+	 * A request whose writes reached the device but whose commit or=0A=
+	 * phase flush failed left the cache describing the delay before it.=0A=
+	 * There is no poll of the delay registers to correct that, so read=0A=
+	 * them here rather than report a value the output is not using.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].phase_stale) {=0A=
+		bool clamped;=0A=
+		s32 phase_ps;=0A=
+=0A=
+		rc =3D sit9531x_output_phase_read(sitdev, dpin->id, &phase_ps,=0A=
+						&clamped);=0A=
+		if (rc) {=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Output delay could not be read back");=0A=
+			return rc;=0A=
+		}=0A=
+		sitdev->out[dpin->id].phase_adj =3D phase_ps;=0A=
+		sitdev->out[dpin->id].phase_armed =3D !clamped && phase_ps;=0A=
+		sitdev->out[dpin->id].phase_stale =3D false;=0A=
+	}=0A=
+	*phase_adjust =3D sit9531x_out_state_get(sitdev, dpin->id)->phase_adj;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment=
=0A=
+ *=0A=
+ * Programs the per-output PRG_RST_DELAY registers for deterministic=0A=
+ * phase offset; see sit9531x_output_phase_adjust_set() in core.c.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);=
=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Phase adjust failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
+	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
+	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 8270b8ee91be..3aaafb0efd78 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -228,6 +228,28 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 		props->dpll_props.capabilities =3D=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->out[index].freq;=0A=
+=0A=
+		/*=0A=
+		 * Allow phase-adjust over a +/-1 ms window.  The subsystem=0A=
+		 * rejects pin_set(phase-adjust, X) when X falls outside=0A=
+		 * [min, max], so leaving these at 0 silently blocks every=0A=
+		 * netlink call.  The device holds a delay anywhere within=0A=
+		 * the output period, so the bound is the s32 picosecond=0A=
+		 * attribute, not the hardware; 1 ms is a round figure below=0A=
+		 * it that costs nothing.  Only outputs get a range: input=0A=
+		 * pins have no .phase_adjust_set, and advertising one there=0A=
+		 * would promise userspace something every set would refuse.=0A=
+		 */=0A=
+		props->dpll_props.phase_range.min =3D=0A=
+			-SIT9531X_OUT_PHASE_ADJ_MAX_PS;=0A=
+		props->dpll_props.phase_range.max =3D=0A=
+			SIT9531X_OUT_PHASE_ADJ_MAX_PS;=0A=
+		/*=0A=
+		 * The fine step is 30 ps, but requests are accepted at 1 ps=0A=
+		 * resolution and rounded to the nearest achievable delay, so=0A=
+		 * advertise the request granularity, not the hardware step.=0A=
+		 */=0A=
+		props->dpll_props.phase_gran =3D 1;=0A=
 	}=0A=
 =0A=
 	/* Generate package label */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index eea38150b50f..7c41111dca20 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -202,6 +202,43 @@=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
 #define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
+/*=0A=
+ * Per-output programmable phase delay: 34-bit coarse (in VCO clock=0A=
+ * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output=0A=
+ * has a five-byte block PROG6..PROG2:=0A=
+ *=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserve via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY[2:0]=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  [7:0] PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  [7:0] PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  [7:0] PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  [7:0] PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Slots 0-5 are on Page 3, slots 6-11 on Page 4.  The block base=0A=
+ * within a page is 0x15 + 16 * (slot % 6), where slot is the physical=0A=
+ * output slot from clkout_map[], not the logical output index.=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DELAY_BASE		0x15=0A=
+#define SIT9531X_OUT_PRG_SLOT_STRIDE		0x10=0A=
+#define SIT9531X_OUT_PRG_BYTES			5=0A=
+/* bits [7:5], preserve */=0A=
+#define SIT9531X_OUT_PRG_OPSTG_MASK		0xE0=0A=
+#define SIT9531X_OUT_PRG_FINE_SHIFT		2=0A=
+#define SIT9531X_OUT_PRG_FINE_MASK		0x1C	/* bits [4:2] */=0A=
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK		0x03	/* bits [1:0] */=0A=
+/*=0A=
+ * The divider takes two VCO cycles to act on a programmed delay and=0A=
+ * release the output, so the encoded value carries them and the realized=
=0A=
+ * delay is the register value less that.  The reference flow adds the=0A=
+ * same two.=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DIVO_CYCLES	2=0A=
+=0A=
+#define SIT9531X_OUT_PRG_FINE_STEP_PS		30=0A=
+#define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
+#define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
+=0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
  * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
