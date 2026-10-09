Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387E51B192;
	Fri,  9 Oct 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570737; cv=fail; b=sRfy98O937bUGhDowWmMmZN2plKllMLQLTseLmstkvIlUQ2zleqqM+j8ngs8lSI0T6VtaPH/D7E5p0r6JMbC9Eb5nabPZGo/R5P6vpXVtqa87eXJuw0fRoUx/D8jHKGUQUQ6v5LKOZpobW83DyImaRFLhWPpOzGkEMgtTSn6IdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570737; c=relaxed/simple;
	bh=70XRyuNnTRi/Ab+vnu8msWD/T9n6PHBFajQbBPKXxxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSE3S2i1chsXqcKLUjfUDIJvRzHUg4jPMh7hYMlAhqmRMTc3Qj+Q4X+4FHwNmfB3PFBolPlu4xaWC/2SCrosZLFjBMRFilhk7hjC6bBSemGlUylJ/AwyuP6pOjR+1TzgeXCGJYu/x0kFQVqgfOkTAq7FvPQHxrhwInWqhoC4whM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=hLGXZPQY; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=dqlgWZlp; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="hLGXZPQY";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="dqlgWZlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ruJcZr0XWuLhu+l8T2Zvowej3do1eJlNJb24oR9NVgw=;
 b=hLGXZPQY18SHStK3iXvKyDXzIP4u6mkWXPeH+d+fJgjHLTdT6UtGJIWNy8a/0I5/hvXJ3cmaOcXGQySHu0K7QDRxGgzs6yRA1lB/ize6mQUXIhd41FMxEYBG+FVTMdJ4Z57Bnz2pPeeeUZ19kyDc85WL4tiUoC8CXVVSQktIZK3J2Sggq+q/OuehOifGzDblzILuYe9/tNOGKAekVK1IdMHMmuZL9FoxWPD9+MIQ57G0+vk0RqoqO26f5YKAnI/4FYnxlz3rjE9LCTfajz13R2jzMk23jk115PpMyv7L7GjTKwqtFjY3tWgZU1cChzCwCADGzsvoJgJBN+g4tEp1Bg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023138.outbound.protection.outlook.com [40.93.201.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C73DDC0061;
	Fri,  9 Oct 2026 18:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyWJJg/plpOXDyPTBI7jT/j1RZsQ8A1kLjd1/mBqgAmIhm9RHjkF9IXTOYrSP07bCYJHd194y1ypoGhWjdEgWDdKg2OjIjoiA9+c3P/zZOXqqmzhhKbaXk7AX3PiuK5TfGgLzthbe4aYFE6s8pNjaYvMgEBDZ2zTK7I1LPyoQo0VPmxZYF7fFQGP9aekm4KgtdDMY2RN1CoJmkT0N4bj1x0i4BfkmAiQ9OH4nNRDStLNCZdvhB59BlGaLVeilamOOz4Eq5rqMbTNJ292Ac9vO+UQ1NnwV8ajYwo3UL/5+2M/jS6zatMJtmc4UTLi9zEp7+XOWiiQ2PgjNYoRZ9CVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruJcZr0XWuLhu+l8T2Zvowej3do1eJlNJb24oR9NVgw=;
 b=PR3OXnKgISkt7Nt9BPY+S2kvXJS1F0ynLiFlNOxkSvaEzXdASRbYqW9ehf4mRBHXqRaT+zeGN0l4LE/dSWM/pO84nv+nFHonOmv9VlSL/Wjb2ZCKNjkXXxKKLpP4OY6X3QsvwvThchsxU4L69uILHaOBPGFC7ufPUzTHfqKiWC2xC1OYykqyOhZxVhHaV0G4ueyakOUIeLyWFzV46p34qtDTjf3hZKE6Hna7a1ByBG7vZUqlE8KFDWccFX39P7WHDUTwHgNaEvYwCut6gjB2G5Ggk0T27OJjmaSmIivEr1AHu77DTTNVC+VVUY5pUuQt2XkiugLT2R344+3S0uFZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruJcZr0XWuLhu+l8T2Zvowej3do1eJlNJb24oR9NVgw=;
 b=dqlgWZlpAh+S68KpX8OUxoSH4YLZbwLI5wotNNl+JXWKbHWBI9CjsWIcZi6kaAqPERq3Zyn5bg+IgLajim986VxdQfIMwCjTLHGT654y1BXfnZzNdPb02xLJrlYS61GzCa5p617Pqrb7s7v7SCcTr0A7/5QycJdSisjFhNwYr36PaOkXtsW1bYRhaWGu9IK6ILopfYyfdKlQKoC2tdAm1vTOXGrtHQwDpcqKhiTjrw0HPFRLb26YSiVOUeWFTE5AVm6T29Xf170uwYj7iXtfTxxC8RHylpUERhfvQpT1Tfu541xsNo/DzAGpnWm+zoBgnJox4DZ9LLFR0Ss8bJKLfg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:54 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:54 +0000
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
Subject: [PATCH net-next v12 03/12] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH net-next v12 03/12] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdWBx115RL7jUfs0GLNNopB2dJ4g==
Date: Fri, 9 Oct 2026 18:31:54 +0000
Message-ID: <20261009183151.78497-4-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: bf67512f-0528-4d16-dace-08df2633980f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 7NCzOGwVpMSy4Jmgiv3Fb02ceIdBTKpj/yP3BLzaIQDTRjlhnZPnFA4wewRFpU40rc7nUeG4pwjQm728oWg9KkpYfB0IkRbzGql55lzaIjezLgEwc9rBn3zq8Gbsmbgnf3P3C6k9pF/Vg4IksQgimFyBknU/naiKjzwSlmTZWVvfbcA5WYvGrTDfRooUTJbfVB7Yaq/Jl2ZW6kmHKypwOcxXZhloAdDQcum8AXSBh/dNYf9ZLjV27F/UQ+LBfZG0VG2r9zvzTFgJqZc+9n20WIE4wkPR1ZxFo2NrVdDzXQa2ERvogUusq+ADp8oYaXAUPz1EMxKloUQyYTyClJbwR6Q2pimCF9lWUamDzs+y+tS8cNKhCVUI0+8AZX01WdwUqiNA01acamUDvPSw25wFELw0EyQhqLZ2AaiOjxKwUY/BKPPSljyF9J8iFk9C5KsWMJJNvXrIkh050QeLzstAnTirPXkLjo64jZq18ZNcVNDRJIfnApfVkxZOufxnCz46HRWjsUeYQgsPV7sqV6VcRStWVjulzdGNpNjebwstPMmqvgfXlupsS+BoR77ve3lLLLhVgo6dl1aYOvdU5ogVpLqtGKtUlDY619H2X+u0d+MQRcnGsPsbciN2G/oFbOR4tG/aSmKisad9uFABH2ZNoYe/ZQlRFThY/FSUAaDYG1NO2sdr5dpYW0PnJR1862fBIYHaW5VlquJMNNbMNYQc5UDVODQZJ1F5JQWBZiUT2tw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vSjItuB1iLLH31MPrVsly2S9w8CS7af6aa242Y9tCF32lI2WLQ9449cSKt?=
 =?iso-8859-1?Q?VLx5PVk6Vl3aAdI3i2F1ZsNoh4OaifM5EDoUepvomcN2e6pdyb0DkF1KY/?=
 =?iso-8859-1?Q?3R968ctsp5/a14KJU4RgR4bv16RDDEAH4Kji9s9WLMNfiGJVkkjBtrGuX2?=
 =?iso-8859-1?Q?75qzy6mivpaRG8pldCMWi1GaQme0XwDflzNKo5AuymB4PDOv/S9Jhr3Nn9?=
 =?iso-8859-1?Q?FdrF9eL0IbSd2Vp/U7tBLX8m3rJuYbwUNolTma34BAJeOLN3EOSnm2M0H3?=
 =?iso-8859-1?Q?zg+rnPqs98HwYtj3T09yhHDcUGNqbYEPF31BsZuxgzdCEFwsdfXee9RWu8?=
 =?iso-8859-1?Q?AqO7YLmqZRWgBRVGXk2GuQyfqMKbcH6SLpR8NnxZx+jBNGbTx1E5C5bE3h?=
 =?iso-8859-1?Q?Vw5XrbFfaG9bVfUXcneiI+SJHNKikSboi+Twex8QxV2xCeRl3VCBpU0rvL?=
 =?iso-8859-1?Q?gQ5UrfBaSKvYi7ZOU0zf0IdfGueYUpzpneeNVtQ3rIJSiKNwM4EZIzDc1e?=
 =?iso-8859-1?Q?y3l+fB6k34taVaoetro5EAB4gUzOxx2iHFsZxGWWZ8kiYxUj/pgY7bFM3p?=
 =?iso-8859-1?Q?04LQLQgnWEXl/tmxKX1yZkMt02mqfIwhNcJI0yEq4SWEM66yTke99VBZ//?=
 =?iso-8859-1?Q?3wKT14hWEaYAkcNmAoAMk4vyOjLch0Q6JxOQ23b554KWnnWS/AdFKm9Grv?=
 =?iso-8859-1?Q?nOdK+UHeQZj9z6gAa4Ohz6AVgySGpDXeWL1mxX9UMh4mFIjgVDRaoUIO8P?=
 =?iso-8859-1?Q?WEkmeR+HDK5VVruqeGuw4i8nc2HlcBVewFLO4zJhNDcXqjRJeOu3RWMPAy?=
 =?iso-8859-1?Q?ODY1xjl19rTjMP28X60dhhISlrzA32Qzy5WWSSAZHyg5SuXRiQG+MoEZA3?=
 =?iso-8859-1?Q?zLZx6jXUkkCqE66q9lTJDdVIacco2qvJN5ukirZRB+QTPk2zaS2igG+Trm?=
 =?iso-8859-1?Q?07BW+sH6yi+CuLZimF3h93r6FBr0Jg2aI7y6lJVtz/Huc5sw6QA1SE9yGb?=
 =?iso-8859-1?Q?9IPhslzlRjnrCu2u/ZtAW03r9rlrDllXzo/E1uHYn4nDmjIy0a3PMkPb2p?=
 =?iso-8859-1?Q?iqPBuIMCLO4X98s78Vbgaa1kqEJf1iK5jznZUXvpcdByCkdcktKXinHw/N?=
 =?iso-8859-1?Q?uUzxa1fu3/Yx2wxibVq+KzI7JhT+A40gfpJ+1fDM8WuKiLB//vjhcWxqNC?=
 =?iso-8859-1?Q?+VDDvaI8+RFqxUHSzspCBLER5oIDeemxOX5x+0cAR3BW4TUDOS101Qc2Z8?=
 =?iso-8859-1?Q?y7hSw79c6xAwzChn7jJE7/WDljhBVEBJhEvHlxDQ4CwiQXvhArAt1y1NDB?=
 =?iso-8859-1?Q?9qRDnHGj9V7Tu7HCeW4xurbPvJKCBI3fYrUgs/P30mjXR4dscHWeOLsh5w?=
 =?iso-8859-1?Q?BmJCw9F6V0rroSDDI9C7L0LGPGNbb2FIYHRfqAJOs1WUkgBeTmzNA7bscC?=
 =?iso-8859-1?Q?JYeDP5reAw6hcD5+oYDSfQENJLbNv9FECLqFECOoTJK30jM08vKQP6F6WF?=
 =?iso-8859-1?Q?42gaxcbDwJhP5OCLl5bZ6FgSh5nOqdV8TQi68zdneTDB9rl7uqhe4+EjFH?=
 =?iso-8859-1?Q?F0Wpty9rvGLyTYxb/e7wRgvYfg61wm+AKHm4k7pYAkumc+hkUQPW3N7HjM?=
 =?iso-8859-1?Q?+eWbzjVweINgfis6esBQn+ZTAefBdkZWFemtQVBeFls6kJO0CYtlDHDHAT?=
 =?iso-8859-1?Q?4h5As9nfSXhxYIxuSqhqSHYkNdwT2EpJ7IRbI14kqlbahH0QOMIYGyZD+R?=
 =?iso-8859-1?Q?ZgU3zu3DOZBQ3Cz6XHdpoE9WhBYKGsMxtS90xBy6ve9MrD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	U+a4kyxZcuDjGVSEjxxHD7Fy/YDTMRnNXxP2gnK94j/Zx8uAYgJmGNMbOIA5LsSBJPZs783nKzmgQUJd3kYtCeEHVvILQF8y2lFdMTZdsuMKskAxQHOAylkFOc/jaxSzS/mPA5riGv1FlSAom9ZW+yiTAq19jdXYXL0UeCOyY/UQcgQ1It3QqwEpDxv0BDLIx2sF8mDHGlOh6my0lo99Cb+LnWr5yAlwpSMS3H4JDergsFqV23wcsQgQnux7VzlegvWHcjMW9yYZHUU+MeUioFBun8k33LPVS1PhZmiKn4h/uIaSqoTegHM0XcVdPMTD7cavkRfsDhd6LstBr03nMw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf67512f-0528-4d16-dace-08df2633980f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:54.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AxdJ3eSOu/7StJ/5rDI3JKSXXATleFuBUcLY92iXKJlVN1driVF0z0A0n0CXTJJYBRCLZxD3Ze8+x27gtIkbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570719-F-lEtCcSTGFz
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570719;F-lEtCcSTGFz;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The SiT9531x is an I2C clock generator with four independent PLLs, up to=0A=
eight input clocks and up to twelve outputs.  Later patches register the=0A=
PLLs with the DPLL subsystem and expose the clocks as pins; this one adds=
=0A=
only what is needed to reach the device.=0A=
=0A=
The register space is paged: 32 pages of 256 registers, selected by=0A=
writing the page number to offset 0xFF, which is present in every page.=0A=
A regmap range configuration describes that window, so the rest of the=0A=
driver addresses a register as a page and an offset and never touches the=
=0A=
selector itself.  Pages come in pairs for the PLLs (0x0A/0x1A for PLLA,=0A=
and so on).=0A=
=0A=
Probe reads the rate of the crystal feeding XIN, since every frequency=0A=
the driver later computes derives from it; takes the optional reset line=0A=
and leaves it deasserted, because the device configuration comes from=0A=
efuse or from a blob applied before probe and a reset would discard it;=0A=
then identifies the variant from the single byte at page 0 offset 0x02=0A=
and refuses to bind on anything unknown.=0A=
=0A=
Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 MAINTAINERS                    |   1 +=0A=
 drivers/dpll/Kconfig           |   2 +=0A=
 drivers/dpll/Makefile          |   1 +=0A=
 drivers/dpll/sit9531x/Kconfig  |  13 ++=0A=
 drivers/dpll/sit9531x/Makefile |   4 +=0A=
 drivers/dpll/sit9531x/core.c   | 320 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h   |  91 ++++++++++=0A=
 drivers/dpll/sit9531x/regs.h   |  44 +++++=0A=
 8 files changed, 476 insertions(+)=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 858fe1c4332c..64e15831055e 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25187,6 +25187,7 @@ M:	Ali Rouhi <arouhi@sitime.com>=0A=
 L:	netdev@vger.kernel.org=0A=
 S:	Maintained=0A=
 F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+F:	drivers/dpll/sit9531x/=0A=
 =0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig=0A=
index be98969f040a..f8f7ca121b93 100644=0A=
--- a/drivers/dpll/Kconfig=0A=
+++ b/drivers/dpll/Kconfig=0A=
@@ -23,6 +23,8 @@ config DPLL_REFCNT_TRACKER=0A=
 =0A=
 	  If unsure, say N.=0A=
 =0A=
+source "drivers/dpll/sit9531x/Kconfig"=0A=
+=0A=
 source "drivers/dpll/zl3073x/Kconfig"=0A=
 =0A=
 endmenu=0A=
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile=0A=
index 9e7a3a3e592e..4adc50d748d4 100644=0A=
--- a/drivers/dpll/Makefile=0A=
+++ b/drivers/dpll/Makefile=0A=
@@ -8,4 +8,5 @@ dpll-y                  +=3D dpll_core.o=0A=
 dpll-y                  +=3D dpll_netlink.o=0A=
 dpll-y                  +=3D dpll_nl.o=0A=
 =0A=
+obj-$(CONFIG_SIT9531X_DPLL)	+=3D sit9531x/=0A=
 obj-$(CONFIG_ZL3073X)	+=3D zl3073x/=0A=
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig=
=0A=
new file mode 100644=0A=
index 000000000000..ac5b7f31a034=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Kconfig=0A=
@@ -0,0 +1,13 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+config SIT9531X_DPLL=0A=
+	tristate "SiTime SiT9531x DPLL driver"=0A=
+	depends on I2C && NET=0A=
+	select DPLL=0A=
+	select REGMAP_I2C=0A=
+	help=0A=
+	  Driver for SiTime SiT9531x family clock generators=0A=
+	  (SiT95317, SiT95316).=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called sit9531x.=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
new file mode 100644=0A=
index 000000000000..a221fe55386a=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -0,0 +1,4 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
+sit9531x-y :=3D core.o=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
new file mode 100644=0A=
index 000000000000..c7c14442df92=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -0,0 +1,320 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * I2C probe, paged regmap configuration and register access helpers.=0A=
+ */=0A=
+=0A=
+#include <linux/bits.h>=0A=
+#include <linux/clk.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/regmap.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \=0A=
+	{ .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), \=0A=
+	  .name =3D (_name), .clkout_map =3D (_map) }=0A=
+=0A=
+/* Per-variant output index -> physical slot mapping */=0A=
+static const u8 clkout_map_95317[] =3D {0, 3, 4, 5, 7, 8, 9, 11};=0A=
+static const u8 clkout_map_95316[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, =
11};=0A=
+=0A=
+static const struct sit9531x_chip_info sit9531x_chip_ids[] =3D {=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317, 8, 8, "SiT95317",=0A=
+		      clkout_map_95317),=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316, 8, 12, "SiT95316",=0A=
+		      clkout_map_95316),=0A=
+};=0A=
+=0A=
+#define SIT9531X_RANGE_OFFSET	SIT9531X_PAGE_SIZE=0A=
+=0A=
+/*=0A=
+ * Everything the device holds can change without the driver writing it,=
=0A=
+ * so nothing here is cacheable except the page selector.  Caching that=0A=
+ * one spares a read of it before every access: the range code selects=0A=
+ * the page through a read-modify-write, and with no cache that read goes=
=0A=
+ * to the bus each time.=0A=
+ *=0A=
+ * The cached value is only as good as the last transfer, though.  A=0A=
+ * transfer that fails can leave the part on another page than the cache=
=0A=
+ * records, so every accessor drops the entry on an error and the next=0A=
+ * access reads the selector again.=0A=
+ */=0A=
+static bool sit9531x_volatile_reg(struct device *dev __maybe_unused,=0A=
+				  unsigned int reg)=0A=
+{=0A=
+	return reg !=3D SIT9531X_PAGE_SEL;=0A=
+}=0A=
+=0A=
+static const struct regmap_range_cfg sit9531x_regmap_range =3D {=0A=
+	.range_min	=3D SIT9531X_RANGE_OFFSET,=0A=
+	.range_max	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.selector_reg	=3D SIT9531X_PAGE_SEL,=0A=
+	.selector_mask	=3D GENMASK(7, 0),=0A=
+	.selector_shift	=3D 0,=0A=
+	.window_start	=3D 0,=0A=
+	.window_len	=3D SIT9531X_PAGE_SIZE,=0A=
+};=0A=
+=0A=
+const struct regmap_config sit9531x_regmap_config =3D {=0A=
+	.reg_bits	=3D 8,=0A=
+	.val_bits	=3D 8,=0A=
+	.max_register	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.ranges		=3D &sit9531x_regmap_range,=0A=
+	.num_ranges	=3D 1,=0A=
+	.volatile_reg	=3D sit9531x_volatile_reg,=0A=
+	.cache_type	=3D REGCACHE_MAPLE,=0A=
+};=0A=
+=0A=
+static void sit9531x_page_cache_drop(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	regcache_drop_region(sitdev->regmap, SIT9531X_PAGE_SEL,=0A=
+			     SIT9531X_PAGE_SEL);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_u8 - read an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val)=0A=
+{=0A=
+	unsigned int vreg, tmp;=0A=
+	int rc;=0A=
+=0A=
+	vreg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	       SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_read(sitdev->regmap, vreg, &tmp);=0A=
+	if (rc) {=0A=
+		sit9531x_page_cache_drop(sitdev);=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to read page 0x%02x reg 0x%02x: %d\n",=0A=
+			SIT9531X_REG_PAGE(reg), SIT9531X_REG_OFFSET(reg), rc);=0A=
+	} else {=0A=
+		*val =3D (u8)tmp;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_u8 - write an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val)=0A=
+{=0A=
+	unsigned int vreg;=0A=
+	int rc;=0A=
+=0A=
+	vreg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	       SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_write(sitdev->regmap, vreg, val);=0A=
+	if (rc) {=0A=
+		sit9531x_page_cache_drop(sitdev);=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to write page 0x%02x reg 0x%02x: %d\n",=0A=
+			SIT9531X_REG_PAGE(reg), SIT9531X_REG_OFFSET(reg), rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_pll_u8 - read a register on a PLL page=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG(page, offset), val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_pll_u8 - write a register on a PLL page=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, SIT9531X_REG(page, offset), val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_update_pll_u8 - read-modify-write a register on a PLL page=0A=
+ * @mask:	bits to modify=0A=
+ * @val:	new value for masked bits=0A=
+ */=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+	unsigned int vreg;=0A=
+	int rc;=0A=
+=0A=
+	vreg =3D (page * SIT9531X_PAGE_SIZE) + offset + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	/*=0A=
+	 * A read-modify-write is a read and a write, and either can leave=0A=
+	 * the cached page selector wrong, so fail the way the single=0A=
+	 * accessors do.=0A=
+	 */=0A=
+	rc =3D regmap_update_bits(sitdev->regmap, vreg, mask, val);=0A=
+	if (rc) {=0A=
+		sit9531x_page_cache_drop(sitdev);=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to update page 0x%02x reg 0x%02x: %d\n",=0A=
+			page, offset, rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+}=0A=
+=0A=
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+{=0A=
+	unsigned int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
+		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
+			return &sit9531x_chip_ids[i];=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Fvco =3D Fref * (DIVN + frac/2^32) with Fref derived from the XO=0A=
+	 * feeding XIN/XO_CLK, so the rate is needed before anything can be=0A=
+	 * computed from a divider.  The rate normally comes from a "clocks"=0A=
+	 * phandle (clock-names =3D "xtal").  On platforms where the firmware=0A=
+	 * does not expose the XO through the clock framework, fall back to=0A=
+	 * a "clock-frequency" device property.=0A=
+	 */=0A=
+	xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");=0A=
+	if (IS_ERR(xtal_clk))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
+				     "Failed to get xtal clock\n");=0A=
+	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
+	if (!sitdev->xtal_freq) {=0A=
+		u32 freq;=0A=
+=0A=
+		if (!device_property_read_u32(sitdev->dev, "clock-frequency",=0A=
+					      &freq))=0A=
+			sitdev->xtal_freq =3D freq;=0A=
+	}=0A=
+	if (!sitdev->xtal_freq)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "no xtal rate: provide clocks=3D<&xo> + clock-names=3D\"xtal\", o=
r a clock-frequency property\n");=0A=
+=0A=
+	/*=0A=
+	 * Held deasserted, never pulsed: the chip configuration comes from=0A=
+	 * efuse or an NVM blob applied before probe, and a reset would=0A=
+	 * discard it.  Must precede the first I2C access, as a board that=0A=
+	 * powers up asserted keeps the chip unreachable until released.=0A=
+	 */=0A=
+	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
+						     GPIOD_OUT_LOW);=0A=
+	if (IS_ERR(sitdev->reset_gpio))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
+				     "Failed to request reset gpio\n");=0A=
+	if (sitdev->reset_gpio)=0A=
+		fsleep(10000);	/* internal boot after release */=0A=
+=0A=
+	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
+	if (!sitdev->info)=0A=
+		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
+				     "Unknown variant ID: 0x%02x\n",=0A=
+				     variant_id);=0A=
+=0A=
+	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return dev_err_probe(sitdev->dev, rc,=0A=
+				     "Failed to initialize mutex\n");=0A=
+=0A=
+	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",=0A=
+		 sitdev->info->name, sitdev->info->num_inputs,=0A=
+		 sitdev->info->num_outputs);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev;=0A=
+	struct regmap *regmap;=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
+	if (IS_ERR(regmap))=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Failed to initialize regmap\n");=0A=
+=0A=
+	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
+	if (!sitdev)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	sitdev->dev =3D &client->dev;=0A=
+	sitdev->client =3D client;=0A=
+	sitdev->regmap =3D regmap;=0A=
+	i2c_set_clientdata(client, sitdev);=0A=
+=0A=
+	return sit9531x_dev_probe(sitdev);=0A=
+}=0A=
+=0A=
+static const struct of_device_id sit9531x_of_match[] =3D {=0A=
+	{ .compatible =3D "sitime,sit95316" },=0A=
+	{ .compatible =3D "sitime,sit95317" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+=0A=
+static struct i2c_driver sit9531x_i2c_driver =3D {=0A=
+	.driver			=3D {=0A=
+		.name		=3D "sit9531x",=0A=
+		.of_match_table	=3D sit9531x_of_match,=0A=
+	},=0A=
+	.probe		=3D sit9531x_i2c_probe,=0A=
+};=0A=
+module_i2c_driver(sit9531x_i2c_driver);=0A=
+=0A=
+MODULE_AUTHOR("Ali Rouhi <arouhi@sitime.com>");=0A=
+MODULE_AUTHOR("Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>");=0A=
+MODULE_DESCRIPTION("SiTime SiT9531x DPLL subsystem driver");=0A=
+MODULE_LICENSE("GPL");=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
new file mode 100644=0A=
index 000000000000..76a2632f0ce4=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -0,0 +1,91 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Device structure, register access helpers, and core function=0A=
+ * declarations.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_CORE_H=0A=
+#define _SIT9531X_CORE_H=0A=
+=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/mutex.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_NUM_PLLS		4=0A=
+#define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_MAX_OUTPUTS		12=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_chip_info - chip variant identification=0A=
+ * @id:		variant ID byte read from register=0A=
+ * @num_inputs:	number of input clock pins=0A=
+ * @num_outputs: number of output clock pins=0A=
+ * @name:	human-readable variant name=0A=
+ * @clkout_map:	per-output slot mapping (output index -> physical slot)=0A=
+ */=0A=
+struct sit9531x_chip_info {=0A=
+	u8		id;=0A=
+	u8		num_inputs;=0A=
+	u8		num_outputs;=0A=
+	const char	*name;=0A=
+	const u8	*clkout_map;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_dev - SiT9531x device instance=0A=
+ * @dev:		parent device=0A=
+ * @client:		I2C client=0A=
+ * @regmap:		paged register map=0A=
+ * @info:		detected chip variant info=0A=
+ * @multiop_lock:	serializes multi-register sequences=0A=
+ * @xtal_freq:		crystal oscillator frequency in Hz=0A=
+ * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
+ */=0A=
+struct sit9531x_dev {=0A=
+	struct device			*dev;=0A=
+	struct i2c_client		*client;=0A=
+	struct regmap			*regmap;=0A=
+	const struct sit9531x_chip_info	*info;=0A=
+	/* Serializes multi-step register sequences */=0A=
+	struct mutex			multiop_lock;=0A=
+=0A=
+	u32			xtal_freq;=0A=
+=0A=
+	struct gpio_desc	*reset_gpio;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_pll_page - get register page for PLL index=0A=
+ * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
+ */=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
+extern const struct regmap_config sit9531x_regmap_config;=0A=
+=0A=
+/* ---- Core lifecycle ---- */=0A=
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- Register access ---- */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 *va=
l);=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 va=
l);=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offse=
t,=0A=
+			 u8 *val);=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offs=
et,=0A=
+			  u8 val);=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 off=
set,=0A=
+			   u8 mask, u8 val);=0A=
+=0A=
+#endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
new file mode 100644=0A=
index 000000000000..67077d112653=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -0,0 +1,44 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x register definitions=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_REGS_H=0A=
+#define _SIT9531X_REGS_H=0A=
+=0A=
+/*=0A=
+ * I2C register model:=0A=
+ *   - Page select register at offset 0xFF, present in every page=0A=
+ *   - Each page has 256 registers (0x00-0xFF)=0A=
+ *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)=0A=
+ */=0A=
+#define SIT9531X_PAGE_SEL		0xFF=0A=
+#define SIT9531X_PAGE_SIZE		0x100=0A=
+#define SIT9531X_NUM_PAGES		32=0A=
+=0A=
+/* Helper macros for page:offset addressing */=0A=
+#define SIT9531X_REG(_page, _offset)		(((_page) << 8) | (_offset))=0A=
+#define SIT9531X_REG_PAGE(_reg)		((_reg) >> 8)=0A=
+#define SIT9531X_REG_OFFSET(_reg)		((_reg) & 0xFF)=0A=
+=0A=
+#define SIT9531X_PAGE_OUTSYS0		0x03=0A=
+#define SIT9531X_PAGE_OUTSYS1		0x04=0A=
+#define SIT9531X_PAGE_PLLA			0x0A=0A=
+#define SIT9531X_PAGE_PLLA_EXT		0x1A=0A=
+=0A=
+/*=0A=
+ * VARIANT_ID is a single byte at page 0 reg 0x02 (95317 =3D 0x17, 95316 =
=3D 0x31).=0A=
+ * Reg 0x03 carries an unrelated revision byte and must not be combined in=
to=0A=
+ * the variant identifier.=0A=
+ */=0A=
+#define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
+=0A=
+/* Variant ID values (page 0 reg 0x02) */=0A=
+#define SIT9531X_VARIANT_ID_95317	0x17=0A=
+#define SIT9531X_VARIANT_ID_95316	0x31=0A=
+=0A=
+#endif /* _SIT9531X_REGS_H */=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
