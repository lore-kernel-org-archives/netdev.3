Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657441442A;
	Mon, 21 Sep 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021493; cv=fail; b=Kpt2OpJl6wrqKubDGtKjztoDs6z+CXZFjb2giwZfJiMU5HCNSu3wTZhZouQ6uv03Modtqfgw/ZqsWj7+K4xTnKrZlsEJsUgUwT0vW7wuCqqhQRQ8nd4PkUdY01yEg7ph8O6CO7w44GREKhO46DrMoCFtKCTDnnUModvDgdJXSmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021493; c=relaxed/simple;
	bh=F0pbmz6Z3pyK73HddJSpV5gQhspfgJJ7ZWFQ0lLqmy4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HHxMydU1Ea9p0rMq90cFdEGsDF06OF+BmmwrqwPzP3iUOIYvDO8kzTWPQKof+/pyJ0KOoK3v5mXytf0RPnzK0FvaEdOboSACfveHgucGknrmnQrgn9wk427t+rjB5KSW/oVmkOFSL0RSdrm3XSZJZmqifrnxojrrzETvu7a9gdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Fcx/rPEu; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=cPu9uQr/; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Fcx/rPEu";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="cPu9uQr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=apRNgv3gZoqauaH/HsUnvad5sbmQPnhjo+RaoA1tZMo=;
 b=Fcx/rPEuOJXZaer2QfUZjYtWguqLRVmO4dBmBJibOkXo7IC121aZCo7QIixQgjUNxf9DmYQ69BAqAcE4gUIiul2CK+4SguXW+9K4UP/8tObz/HFMwKoDkO9Z34Ky/qdZMtKR1XWub1AvQF7Dg3EExoKTjDByKT+yH5qrcFgZCjtYdgNG8Pgp/fk1NhdUSR+ytjMf6LUVYQsqnoS2o/jXxzEd+xcCqRIm2V4nanI+RgDx1WGFEm0alk16S2eFNe3cQT8EvVf2x7cRkDOjp3GwQdaJBc1crpgPIOFlVpCDu8AO6adlqwJpeyXpCZ7EUHO47AqK1g8R/pu34XnPtWw08Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 519A99400B2;
	Mon, 21 Sep 2026 20:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaTIVk4YzukA1TuzKo0vDth9t7lPKoMPwO+n9SQ3QW9qyxOOmZnVyDG6grN1eLelv2SlkV0ZpkD3xcnL6YY/QglIR1EjM/4U0q5lgMMjNovc21eEMO+246NAGQTVMCymuMmrucViQV23zT96GfQf3mmMX7EVijYMO812N/IhOFhtrqZJZjSkeT9UNlsLbx4HpX1qB9eV+4v/9Z/eBidv89QJH8i71H6eJZRskUdMp1mgBD3G6cfijyr2BAPqEUmf+JYqunoITWe3MGGeg/W09BuKHk9r0aOcAJ+Zf26J2Wr1HYMykJQ1vzVyhPiNkP9GWpWAnPQVMRaPMZFMzLSguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apRNgv3gZoqauaH/HsUnvad5sbmQPnhjo+RaoA1tZMo=;
 b=dud6PCBBPAobR+4ihjjA7E4bsK4LB//eRk19GnmSJrkuOJ+YPkkaYtwapIbfu5K1Q8Bu9qrHvSon+ASiznlDG24wCdWJydPQ6xlV7fK4E2W7hexr7SaEBmeokGhj3tfPHF9x2ayV/KkPj4t7wCUTYKHbsBihaSeLMljjK6kPcNh/5HwszPMRH1uA3vRgKUlMcQYXD8t9M9Zv29DQe4lXAAqV6Hx0jeyDuWryiSBErS/e5nV8VHlo7hllDU7G7x9oyq3Pyo94MXFmVKRf2kHVMHqi5ny+2NcqiFMkvqkUPjoo8MxBIpT+BaHUk3Z0xM5kq6yooc8+wCxt6KZN+zOILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apRNgv3gZoqauaH/HsUnvad5sbmQPnhjo+RaoA1tZMo=;
 b=cPu9uQr/+JcIBmDEUO3Tbs9nkbzftlzNCdtpwuM5fOOOc6KXLn2xYkOhSC0wOFSHqrOlDfReo7ObULKQ4Gq3+UadRs9ZiiZTEY4zUqI/3FszjSxOyJ9XEgbPOtxiJIy/CVS8a+5/V7sg8xaCRWbXDWjGVjdpIuMljbAD5DodgaR3GIObfcTdYVKEgs/KJwPBKfvTRP67JBVBN+isRuUHfM2M0Uwf5rcKCfEd2eyBXsWOwIvVYRGBBI5gnDfoJ3tesFfUVzIQXrwGcJnwmjVMCvbPdI3dL2ue+WTn98CR7/K5XBaDDCPeCjaYYI6i8q5GGm9G+EF0DT8f5YfclZWKkA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:08 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:08 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH v10 00/14] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH v10 00/14] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Index: AQHdSgVX5pHuy2OFZkS5BUm+FBBzRg==
Date: Mon, 21 Sep 2026 20:11:08 +0000
Message-ID: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: af7d0388-d37b-4aff-efaa-08df181c799b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 rs2w6/c2ah8+LYqApiY9Pd5cgjZmebTnZxTqmMHAyZ5XkaJambh/1ClVrPq6PbSFrY/ExQgw860v/GvVCF4q91Y0lMUMvyRyAb4HlOEZtuQrgTn4A62u49ctn8q7W764opR3wRj/ShNH7+o5NfdTZ3pz5mzkOVoJ7FjOPDbm8nIiTspwCtSVj/2FQObk7jRdomqNyKMWb2W6R64Jyx0S9kgDKcjkbxhcYgvoTHNlqa3V7Gl19zq7ZiBQODMmzmf1lKrqJEuoLPslwnZ0hGS9/XuW7cgFKOm5Ls02Ec8kTjBJ15UQ6OuZCaP2JozqDDAwGFsM8WYi3Zl03GdNfzJmv9Qf5MlZrDElz4zU/XacFWPMDCkksp07Qv2rfKXzP5oMCsRO1EpN5pKJc9N1Hpla+fXvpqkdC5TvvrEewNxQDE8Ak0IFjvk06+bho7EJfVCaJ15uOsw0JmBcMbya2ANDX3xo5p8DrhEfUd856C8H4xk+/kj4BhRwYShFQKmRgsM+lvXK/vyOqi/1h0SXhpe7mL0QsDw6rpr5M2dp0v6abVZ7c0f2q+gQXX+4mGPWPdD/mrIQEhJF2bc/b0YRRvOvxaXNgO9yjR6XWK7FqKsv7tJa8mx9mutOnQcVOiMGj2Z4JoE8U9UDqw8UREGKJcxJ61DmEVG9+3CHjEwYBgPUKn8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?r7436dWeld14LVVu4A6ktfH8x7fHvgBpeXyi2i58bwCt4y0GmZSqYy+OdW?=
 =?iso-8859-1?Q?ZtuU/tytHjS7eC3aQpUyTeSczzfTbQFOBDCDA/pJLCESIbSi9x5MoXt4LN?=
 =?iso-8859-1?Q?nJOoUt4yjAjKI9g3+wyFoG5huwfmbbmtDyls7+hASJQiV+v7iqmpx0Ok66?=
 =?iso-8859-1?Q?/QOmQ72o7hG4aJBsFXlP0rbnVF0vky50WFKySXGA+0K1xudx3fQiDQNXxk?=
 =?iso-8859-1?Q?fDb+iRCKdNLdZBiN3zRXRfXFLLjyKfWunVhfBZNHOfUyPFyY9P/uKpHJqZ?=
 =?iso-8859-1?Q?J2wkBRqZfN57rDVxKzs3px3JA+C17C2NF8x6p0O68VK3bpoy+fFu9NDTq/?=
 =?iso-8859-1?Q?o02oj5UlHoGB1NbfG0E5Q3fqxJ7vlH1FGr9GESnVicHPJyC4J+pawpGsaM?=
 =?iso-8859-1?Q?V2oSE2q3yJgRcvHa5T0SJr11DcfAiOvS34Nox3ng/MhQP7YGwMjrHYrOQl?=
 =?iso-8859-1?Q?WIpfgQvBJ452pfZK3h1iAuY2nGxOtPREmUgbZlkMGAsD9le/YpuN0jeU1D?=
 =?iso-8859-1?Q?POI8dS0W1A//m51qNiHYnh119byjjrOfyl9bYyy6N20twCePqFc4D1KLQv?=
 =?iso-8859-1?Q?Z9mo6cftb86nStq6Y16ZL2KOEyHpZTJ/B1TmJiQ6Acj9RUokfLggtUKi6L?=
 =?iso-8859-1?Q?P7RegZ+03clXsG/NuJls3t+ZSsx3kxfVQHFz96jwxIOpbU5PLO0wgyovjn?=
 =?iso-8859-1?Q?DgWr1Mt2Fx8Fiqb2XHSdFMjnI8mJM3xskCAXtIggjWskMK5V8jFGm7jGv2?=
 =?iso-8859-1?Q?Nvk8+LxX0GF/VEiusPsqtDGnR0YaBVikvHzoerRCksm66C4X/pY6Cz2QhM?=
 =?iso-8859-1?Q?2vBCjw9Pzn8JAZjUF/rKuVnZw9S8hGyYXYz30MwzGrIRUS61QyIeVu6fuI?=
 =?iso-8859-1?Q?OA0OL4agFIDOZdAA1IBb2BVU39KMdJUW/UIhlsC1hANzwASw1ugZRaQp4I?=
 =?iso-8859-1?Q?vIUFwD0FXUUupOh3tt4Z/6FvuqB08mxoLXZ1hmsulgMupb3WfFxlpct6ci?=
 =?iso-8859-1?Q?um1mXBatoW9bxGr+2zp5Gk6lWH9/TgSxunLiiq3JkZgTVa/0Rv3/MUsZ2i?=
 =?iso-8859-1?Q?CeS5S/wAwI+JgniqBr2hwDdeSVJQlu210Z+iK/X28usxGMpNF8lp7UxTkS?=
 =?iso-8859-1?Q?FVmWBJtgrhFe9efwNGVNWhVoDZ7ys/LIzXNfWcGhrKNvnUlECN4nk2SIkr?=
 =?iso-8859-1?Q?sIZcd6kn/vEr2SCWK3vRfu/ToKvF9Jz/1D8TA0BZVL9TrVf1mVEAujWTa5?=
 =?iso-8859-1?Q?NE/EnnkJLVxfLyxYlgcTe/d/PAnHhiEj0Ndk2dJMj0PrMF7CDY7jiObxn9?=
 =?iso-8859-1?Q?3bJ6RD+0zkyMcg2rbXqcDM57cjLskdqhQhG3wV7gmYHMc176L3qhDwj+xV?=
 =?iso-8859-1?Q?12es5Az5ZySrrMmVCRQfE7I/Ow5dsNi6DLwUd6vie3yAn1w3QH940Qpt5O?=
 =?iso-8859-1?Q?DFKf2KR/AmvaaHwW5oXyL4EzAfjW5vXp/8lLgGFyduvCOcQgoOfBL/qzUj?=
 =?iso-8859-1?Q?t+qJ/BQAhgx0df3B4ZzfQnrkZJ4WXsC5ukOPBSvYZLPMnFXhhHuvLcnoXm?=
 =?iso-8859-1?Q?E24xQJPGPJQJ6r4cTJJLg7NgIM/SRxVCxLE9aijDEkifYNA/WMVgCi2+yj?=
 =?iso-8859-1?Q?oixAgiBAaYCYE2KOPLo5vfhFBTbwzmr0x0mK3qLoFgArUtW2xusHCmvYW/?=
 =?iso-8859-1?Q?AHMT4lUy5hRjwkNTnRVMlcUsYy6PxOT7mVbQn61wO1rJHic6UWJJgtgOe/?=
 =?iso-8859-1?Q?czhv6ry98jrueVM6PRF1Jd48aLgsydIxczYfLv3v9FmxSZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hyra+kXxbMKEgl2HpdMJUrBngkcQFyFFLCX2MxllBe2b2tZ+pQg2a/3PyvkQyd62GxN0u3+Lv80j94j8Bu0HSoRC8K5K2X0cfjEqz3JmE7xGV28eD1B5QYk90MykEJvsY6IlnUngMUC2WaVsy4gi6oZeWpdhI0bRwNfiI1qpWDZeOW0Xb1fDD0sHvxSP0mweJ7iFYUtx9UG0g2kscbJBux+hRLy6t4wxzf/NthlzypEqfLjkorzeresexfL18fGoBo9RtVpNgA7Az2sc5eaECVJRvzlYj4imjvc8v9e9G9L622KSi/YjSKg9L8rcn9TfFzYUbKCZE+lHbwQA9MnAtA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7d0388-d37b-4aff-efaa-08df181c799b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:08.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9pIVado/uixnZBu8OspVjMPjplcglXfY1cHPwYCzsVio9RPzZL9f7G/A6MVotov5O0GqOKdDhV22MUOy82aBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021479-TGiDmqOfEN0e
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021479;TGiDmqOfEN0e;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic reference selection and on-chip TDC phase-offset measurement,=0A=
and is used for synchronization in telecom, networking, and data-center=0A=
timing.=0A=
=0A=
The series contains the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
=0A=
v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/=0A=
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/=0A=
v3: https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com=
/=0A=
v4: https://lore.kernel.org/netdev/20260806232439.27551-1-arouhi@sitime.com=
/=0A=
v5: https://lore.kernel.org/netdev/20260810230439.22866-1-arouhi@sitime.com=
/=0A=
v6: https://lore.kernel.org/netdev/20260812175337.18155-1-arouhi@sitime.com=
/=0A=
v7: https://lore.kernel.org/netdev/20260815221919.64226-1-arouhi@sitime.com=
/=0A=
v8: https://lore.kernel.org/netdev/20260902214030.20955-1-arouhi@sitime.com=
/=0A=
v9: https://lore.kernel.org/netdev/20260915000015.80480-1-arouhi@sitime.com=
/=0A=
=0A=
v10 follows v9 by less than a week because three things did not want to=0A=
wait for a longer cycle. Carolina Jubran ran v9 on a board and found two=0A=
defects in input handling. A divide-error in the frequency path turned=0A=
out to be reachable from an ordinary pin get. And the embedded-sync=0A=
patch is withdrawn, which takes the series from fifteen patches to=0A=
fourteen.=0A=
=0A=
  1-2   bindings: vendor prefix, then the device schema=0A=
  3     basic support: paged regmap, variant detection, probe=0A=
  4     DPLL types and pin properties from system firmware=0A=
  5     register the DPLL devices and pins, and keep their state=0A=
  6     input pin state on a DPLL, with the pin-state contract=0A=
  7     input pin priority=0A=
  8     pin frequency, both directions=0A=
  9     output pin state (mute)=0A=
  10    output phase adjust=0A=
  11    phase offset through the TDC=0A=
  12    fractional frequency offset of the selected reference=0A=
  13    the inter-PLL sync net as a pair of pins=0A=
  14    optional device-tree overrides for two board facts=0A=
=0A=
The two bindings patches come first, so the driver never matches on a=0A=
compatible string before the schema that describes it is in the tree.=0A=
=0A=
Each of the twelve driver patches builds and links on its own: no patch=0A=
calls something a later patch introduces, so a bisect cannot land on a=0A=
tree that fails to compile. For this posting that was re-checked patch=0A=
by patch with W=3D1 and with sparse. checkpatch --strict is clean except=0A=
for the "does MAINTAINERS need updating?" hint on patches 4 and 5,=0A=
which add files under drivers/dpll/sit9531x/ -- patch 3 already covers=0A=
that directory with an F: entry.=0A=
=0A=
Three things are worth reading before the changelog.=0A=
=0A=
The first is a divide-error, found by inspection rather than on a=0A=
board. The feedback divider is a fraction, and the frequency path=0A=
divided by its denominator without first establishing that the=0A=
numerator was below it. The device can hold that combination from a=0A=
profile the driver did not program, and the quotient then leaves what=0A=
the division helper can return, which on x86 faults rather than=0A=
yielding a value the caller could reject. An ordinary pin get reaches=0A=
that path, so we did not want to leave it standing for a cycle. There=0A=
is no trace to show; the argument is the one in the comment on=0A=
sit9531x_divn_static(). The fraction is now refused instead of=0A=
divided.=0A=
=0A=
The second is a change in behaviour that userspace can see. An output=0A=
rate the divider cannot produce exactly is now refused with -EINVAL.=0A=
Until v9 the driver programmed the nearest rate it could reach and=0A=
reported success, so a request for a frequency this device cannot make=0A=
came back as though it had been honoured. Refusing it is the smaller=0A=
surprise: a caller that asked for a rate and got zero errors has no=0A=
other way to learn that it is not running at that rate.=0A=
=0A=
The third is the withdrawal of embedded sync.=0A=
=0A=
Patch 11 of v9, embedded sync on pins, is dropped and not replaced.=0A=
=0A=
This device does not implement embedded sync. What it has in that area=0A=
is SYSREF-triggered output gating with a per-output burst count, which=0A=
is a different function: the byte patch 11 programmed sets how many=0A=
pulses an output emits per trigger, so the 50 it wrote was a pulse=0A=
count and not the 50 percent duty the getter reported. The patch had=0A=
been written to the shape of the ABI rather than derived from the=0A=
register, and the two quantities happen to share a literal, which is=0A=
what let it look right.=0A=
=0A=
The automated review of v8 asked whether that write could take effect=0A=
at all, given that the path never selects the SYSREF or SYNCB mode the=0A=
byte belongs to. This was the right question, and the answer we gave=0A=
then, and gave again for v9, was wrong. The patch is withdrawn rather=0A=
than fixed, and we are not planning to resubmit it. Nothing else in the=0A=
series depended on it.=0A=
=0A=
Changes in v10:=0A=
=0A=
  - Arithmetic. Besides the feedback-divider fraction above, the=0A=
    runtime tap of that divider is now guarded the same way as the=0A=
    configured one, and the denominator's high bit has its own name=0A=
    instead of borrowing the integer field's. The device-tree override=0A=
    arrays are checked against the part: the VCO override needs an=0A=
    entry per PLL, and an output map shorter than the variant's output=0A=
    count is ignored rather than read as a run of unmapped outputs.=0A=
=0A=
  - Input selection and state, from Carolina's bench report.=0A=
    Disconnecting the last reference now empties the priority table=0A=
    instead of being refused, so a DPLL can be left with no source at=0A=
    all. The slot encoding has codes for an input pair this part does=0A=
    not have, which read back as no valid reference, and every slot is=0A=
    given one rather than being left to read as input zero. Connected=0A=
    now means the device has selected the pin, not that the loop has=0A=
    locked to it -- those are different questions and only the first=0A=
    one is what the pin state answers.=0A=
=0A=
  - Answer from the device rather than from a cache. An output's=0A=
    current rate comes from its divider instead of the first entry in=0A=
    the list of rates the board supports. The programmed phase delay is=0A=
    decoded from the device at probe, so a delay a profile carries can=0A=
    be cleared through the ABI, and it is re-read when a request could=0A=
    not be confirmed. The reference a phase measurement is taken=0A=
    against is read at the point of measurement rather than from a poll=0A=
    that may be a period old. The input receiver refcounts are=0A=
    re-derived from the priority tables the poll reads, so a request=0A=
    that failed part way cannot leave a receiver gated off while=0A=
    another PLL is still using it.=0A=
=0A=
  - Leave the device in a state the caller can describe. A priority=0A=
    table that was written only in part is put back rather than=0A=
    latched, and the mask that is reported describes what reached the=0A=
    device rather than what was asked for. The forced Hi-Z pair value=0A=
    is written before the override, so the pad is never briefly pinned=0A=
    driven between the two, and the half that reached the device is=0A=
    released when the other did not. Ownership of the inter-PLL sync=0A=
    net is recorded before the read-back that can fail, and a disable=0A=
    that fails part way leaves the state describable so the request can=0A=
    be repeated. Entering the programming state closes the loops and=0A=
    the debug key when it fails.=0A=
=0A=
  - Interrupt and notification. The driver gives up the interrupt line=0A=
    after repeated failures to clear the notification latch, rather=0A=
    than re-entering the handler behind a still-asserted INTRB. A=0A=
    change in the lock-status error is treated like a change in the=0A=
    status itself. Priority changes notify the sibling pins through the=0A=
    helper meant for a caller that already holds the device lock, leave=0A=
    the pin the request named to the core, and skip a pin that is being=0A=
    unregistered.=0A=
=0A=
  - Output pin identity. Output pins are named and matched by the chip=0A=
    pin they drive rather than by the driver's index for them. The two=0A=
    differ on the variant whose outputs are bonded out from a subset of=0A=
    the slots, which is where the wrong pin would otherwise be=0A=
    programmed.=0A=
=0A=
  - Binding. dpll-types is bounded to the four PLLs the part has. The=0A=
    example is made self-consistent with the driver: the Fvco override=0A=
    is on a PLL whose band the value belongs to, and is a rate the=0A=
    example's own output pin divides down from exactly. Patch 1 is=0A=
    unchanged since v8 and keeps Conor's Acked-by. Patch 2 has changed=0A=
    again, so Krzysztof's Reviewed-by is still not carried across it.=0A=
=0A=
  - Housekeeping. The page selector is cached; it is the only register=0A=
    in the map that is not volatile, which removes a selector write per=0A=
    register access on a paged device. The sign handling in the output=0A=
    phase encoder is folded into one abs() and a remainder, and a zero=0A=
    offset skips the coarse and fine encoding entirely. Both of those=0A=
    came from Ivan Vecera. Two per-input status flags and the register=0A=
    read that filled them are dropped, along with a cached per-pin=0A=
    phase offset that was written on every path of the getter and read=0A=
    on none. Text that described registering DPLL devices=0A=
    moved to the patch that registers them. kernel-doc that had stopped=0A=
    listing members the structs still have is corrected.=0A=
=0A=
Four items from earlier rounds are unchanged and are repeated here so=0A=
they are not re-raised.=0A=
=0A=
The phase-adjust granularity stays at 1 ps rather than the 30 ps fine=0A=
step. The delays this device can reach are not a lattice of 30 ps: a=0A=
request is split between a coarse delay counted in VCO cycles and a=0A=
three-bit fine field of 30 ps steps, and the two are added, so the=0A=
spacing depends on the VCO period in force. Advertising 30 would name=0A=
a step the device does not have. A request is accepted at 1 ps and=0A=
rounded to the nearest delay the registers can hold, and the getter=0A=
reports what they hold rather than what was asked for, so a caller=0A=
that needs the exact figure reads it back.=0A=
=0A=
A frequency request of 0 Hz is still refused with -EINVAL rather than=0A=
treated as a request to stop the output. Nothing in the ABI says zero=0A=
means off, and this device already has a mute control that says so=0A=
explicitly.=0A=
=0A=
The use-after-free report on the pin properties remains a false=0A=
positive: dpll_pin_alloc() calls dpll_pin_prop_dup(), which copies=0A=
freq_supported with kmemdup() and the labels with kstrdup(), so the=0A=
core owns its copies and the driver has to free its own.=0A=
=0A=
The u64 truncation in dpll_pin_freq_set() is still there and is still=0A=
not ours to fix in this series: the requested frequency is read as a=0A=
u64 and validated through a helper that takes a u32, so a rate of=0A=
U32_MAX + 1 + N is accepted as N against ranges that are themselves=0A=
u64. That affects every driver behind the interface. It will be posted=0A=
as its own patch against the core rather than buried here; this driver=0A=
range-checks its own input in the meantime.=0A=
=0A=
Ali Rouhi (2):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
=0A=
Oleg Zadorozhnyi (12):=0A=
  dpll: add basic SiTime SiT9531x support=0A=
  dpll: sit9531x: read DPLL types and pin properties from system=0A=
    firmware=0A=
  dpll: sit9531x: register DPLL devices and pins=0A=
  dpll: sit9531x: implement input pin state on a DPLL=0A=
  dpll: sit9531x: add support to get and set priority on input pins=0A=
  dpll: sit9531x: add support to get and set frequency on pins=0A=
  dpll: sit9531x: implement output pin state on a DPLL=0A=
  dpll: sit9531x: add support to adjust output phase=0A=
  dpll: sit9531x: add support to get phase offset on the connected input=0A=
    pin=0A=
  dpll: sit9531x: add support to get fractional frequency offset=0A=
  dpll: sit9531x: model the inter-PLL sync net as a pair of pins=0A=
  dpll: sit9531x: allow the device tree to override two board facts=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  183 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    2 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 4553 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  429 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1445 ++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   66 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  469 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   37 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  364 ++=0A=
 14 files changed, 7579 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
=0A=
base-commit: 4bb9710c6a68d35207f123aef55dcd50e7195ec5=0A=
-- =0A=
2.43.0=0A=
=0A=
