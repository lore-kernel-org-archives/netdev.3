Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2113.outbound.protection.partner.outlook.cn [139.219.146.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83D3812F2;
	Fri, 12 Jun 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267272; cv=fail; b=G33YImyk9t1xAG5dyILHUpcepy8YxbZGMWOphUWT/Qqvm3QMULjN3tzyczaROkAT+orpmWb/4Vn3PDh0zXvb47LU57XKx5lg4UEaLkIiKPPvIdVpIYBiGT/PHXzMMDq0owu45d0uHkj73ovFNlkHbRovAGoiezxhZtyB7yMNNvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267272; c=relaxed/simple;
	bh=cLLv2nKX37ex11u/TH7G1Wgqs7JHBp7LLdigUAKTFv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=er4GCXag72zh0CGwkGlL2BE1YBxAPtfYa/QkVYub+5vEbXurr4A/RqSKbuBbC03JtMzXWvi2ZknPSJj91PR1FK4ALFjPMxmu8NjxHNJnYrkxW7A1zstSEZ09eB0O5SwbQdXR90b9miSTDWdwTGWIWhN0OD+nrklB6XFo3PBKb70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPh8yS5jIWjyJeUulcOcyA0CxH4G9HEN7jH2OlsJcbd6Id2jzwxLg8DqdFzhjsKy81h8IrepNTd2rMIH/Km7eJHM3Jvf7cSVglU4JHq3VphycYZy1hwywQQKtK34VDJRODNnLYJHEcCHcqGXtTugAvSDBvRZW7kJZpqvUx0r6/47XaQMpqFUFn79ovJ5+uCYaKklZptAVObhD5ENYom3FOjfXhBo0Ztpo4mVe8Vu1/fFiQJnDnDI81EphFL1dKVanwLqhMKVz2mFha5zvc4E+JgknBspUcea1UpdZ0bhVyXeIdce6q+0Uhu1XMsAEA0iijlQF0dV2Q2AV0L6ooBymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLLv2nKX37ex11u/TH7G1Wgqs7JHBp7LLdigUAKTFv0=;
 b=Cor3OwvXYWR1Y15cqnZhngIYgqzUZ1nswMWnYWjA054ifyAO7WSMXJ5aY6H80iT2De+S22prPHEy/gDlSm7XX4rORKBV+b9A0WBjKndaA6ZRiQ7OzJ7mgpLPkcg24CTfSOHhHH8FTSm0ZuNlJJoXsuLdvG4zM7ZKwqO5lVx3QTr2NpZzdLQtPaF9Xte9/hLm+uciGekymplxaUABPFLkNFpb95PoH/ggipEcUT9BNMcbPvRba4AEdlKYqw8kN2tZvp4WUlhMFTYlwnY+sArh0DvWHe0cyBwrs0nXjX8/Zb8uLoCtIJXL7kdJvvzEt0l6yxse+lC8z40pgKN/oY4Piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0768.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 10:54:33 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.21.0092.017; Fri, 12 Jun 2026 10:54:33 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jose Abreu
	<joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW25ldC1uZXh0IHYxIDEvNl0gZHQtYmluZGluZ3M6IG5ldDogZHdt?=
 =?gb2312?Q?ac:_Add_snps,use-ncsi_property?=
Thread-Topic: [net-next v1 1/6] dt-bindings: net: dwmac: Add snps,use-ncsi
 property
Thread-Index: AQHc+Kos0bB42CjcQkupyH6AE8NcHLY3ccQAgANQGfA=
Date: Fri, 12 Jun 2026 10:54:33 +0000
Message-ID:
 <SHXPR01MB0863ADA1F99C2F6A82EA08F9E6182@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
 <20260610072420.64699-2-minda.chen@starfivetech.com>
 <a542aee0-cc4a-4bed-85fa-1ec6fdfe87d9@lunn.ch>
In-Reply-To: <a542aee0-cc4a-4bed-85fa-1ec6fdfe87d9@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0768:EE_
x-ms-office365-filtering-correlation-id: 977dcd9b-7b61-4a48-7a5b-08dec870fcdf
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|22082099003|18002099003|56012099006|4143699003;
x-microsoft-antispam-message-info:
 YXsgWOt/oxoDxxAAk0JLwF0+t2+HH2WU0rDb+QrLFOjjon18z+PrRnr8VywhvIR9CliB2mQ8I83I0PA86b+FDrRcfJ/M/2lFSZoLU+DPAZQtbqV6lVNYURmpHKdkxbzhhvtUoY/J0ySJU5QP42H2U7XIuHLTfXtap0w5hF8KKF0Wm1n19PWIYqDtW5JBs+0QganP84evh8vkkzLvRPz03+cpUnwHtrzZlB+UiRNDPfeu8spFM9bmqS15mfsuvrItXXdHjojTf7cOTugY6C+nHnxlji5jANbYVqEQ4oBZkvbZMQSMTAvRM/aDfaVegtR8tJHjOW6B2pFK8GyP3a29Jk2NMFMRYgPAnJ35ORv82vyucC/+qHf3P38zxhpNasSC/hP4jeiG6OFBIXrWW/2GYupwt8zAu9pm537ebkDR2RH+XjZSwWRO1jig9R/WNR/LcjQ7OP9jaYB8Ohvrn97WhPWP5Ug9iFUMM8QmlrPnIGJLaEh1p+f/ngMY/LJIUBmxR2j/OVIUTbM9yiFJZqPbjpIx82VqKdBY1RmI6JcSehlKv9A1y8Eo8RWoCDQ5lNBA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VFhkYS9NUEdEOFE2WjRacEt1cElpcWVzYnBnMlZ4S05QYkhkZW5tU1JzTDhu?=
 =?gb2312?B?eTA0YVUwZ1VKeWZaZFhUZkhjV05GdW8wQk15QS9JaVdyb0EwSmpzUE1malZP?=
 =?gb2312?B?NCt1NXdzMkI0ZkVQZzF0TVFYUkdDcytLOWxjNjl1emZaYUtFaVBITHQ4dnhC?=
 =?gb2312?B?b2lxbDlBaHg2dUdmYjU1b2JtV09ncXJhaGlOUS9MOVBwL1ZkTlFHSWsrdk9l?=
 =?gb2312?B?VGZRSjhEbmVSY20zamswdFhvS1M3RUIyeEt1dkVrQWxEKzJKcWNUY0hwS2Vy?=
 =?gb2312?B?VVpzUEo4Q1pXTUxxdVhpSFpNUWpwckdFN2MzSExlZWtDaXBYSzRYN2toZS9t?=
 =?gb2312?B?SUU1V0JITzIvK1lNQ3lPUlZGbkpOaWRJeFZ3MVFTRXY5V3ZsWVF4TldqbGNI?=
 =?gb2312?B?eW1DdVgrazkvNlVpd0hna0NZbXhuVFpXOEZ1b2JLclhkTjd4K3h0elNxcjE4?=
 =?gb2312?B?cU0xTlJJQkg1VXFZWkRGS3dUSm1Lc2JXTXBMSmppZW5acThGMWdHU1VXeDh4?=
 =?gb2312?B?TFo0YWZQaWxrSzZrQXJtc0dTRUpqVGEzSXZlMFFpdmtncVpkRVQ5NmRha1pL?=
 =?gb2312?B?eWZNa1M2dzBneG96RUh4eHgxYlRPeVJkVlVlN2ZQdmR6NFZYOUJZMTJTWXZz?=
 =?gb2312?B?K0MySTZkLy9SSGtLSEppaXJnU2R2dit5VnhUeTFVYTgwMjhiS2sxQ0FxMUhq?=
 =?gb2312?B?aUVUSW15UDhjT1RJeGtMMDFmSC9PRmxRaloxMGR4cU9LWWdLcEJQNlJFakJs?=
 =?gb2312?B?eGlIL1Y4VjBoSkcwQVpNbm9lRVNhb2NjQkIvQ1lnTDlKWlhndkVGRE5ZWDhG?=
 =?gb2312?B?SUdkbFN4ZHdXU29pWVFVV0syTVEyUllFSmNHZjRoYytZT0dNdkhOczZVYXhw?=
 =?gb2312?B?RFFSUkVGWmFObFRwMHhiSGNTYlhFTTJnMTh4a0VOd01md1A2OHhXZWpnYVFN?=
 =?gb2312?B?eFIrR2NPT3MyMXNIMlpDOU1FYjNMN0tLdlVsQ3gzTm4xalVKZ25zeFFHMUti?=
 =?gb2312?B?K3B4Ni83WVdMTUtRSFlvVXlpMm5EQXBheEtoWFZxMHpKQlpvTzR5Y2JCMXds?=
 =?gb2312?B?VFBhaEVnZjhnSGYxQ2Qwd0NRZ2JIU0xsTityNG0rWFRhb0VHZWxwKzlvcEp5?=
 =?gb2312?B?WlNjazFmNFNjYTYyczhwSmtZd1NVeS8rUXZXckRHOHNKWEIxSU41Y25yZ3Jt?=
 =?gb2312?B?aERSa2kwTUUydzFsNWkvNnVHeGc2bzFJT2ZtaTZYSVdyNlBlK1pjQ21XcWtI?=
 =?gb2312?B?STRaSXl5WTVMd2lEZ2U1MnBvNEVDTFB3b2ZSV2pwNGVYOWdlWkpBczEyOXBS?=
 =?gb2312?B?VTBMSi9Kd3dQWDk0WmhQUHpLZ3hiOVNEWGxZa3IwYWhnR3plYWtFbjJEU09W?=
 =?gb2312?B?Q2VpeWQ2K2FOVS8xaG5ONlM1V1Z1dFJjbk1wUGFiQzZPSGJsVFhvNFR2dVM1?=
 =?gb2312?B?NmtscHJpRUNoRU8zbnVXbkhibjY1NW13c1JVYk1uTk13RWNCWUQzcFU1cnQ5?=
 =?gb2312?B?TkpRdnVJdGJvWnNJblp4bTc0UGpkaUhHNnFrbzFRbUJSZTdlazRXSGltbURh?=
 =?gb2312?B?blg1bS9PTVEzdit4UGRlRzlBZ2I0c0I5TXVOR1lFMlY1cWVmMDdmSHJkR09V?=
 =?gb2312?B?RVFQZHVqMUVHNnhOL1JSUytaL0F2K1pMdTJuRHhYaHpHU2g5Y01xQXptRU0r?=
 =?gb2312?B?czRaNnpRcHVjWVFBaHgxaUhKZjVsbUZmanp1RytDa3lYcCtRYnEyTU1DaHJU?=
 =?gb2312?B?ekFMb1RIK2RETEpQbUhXRnhydGxuNzFacHVPUHlHajRTdmczNnl5bkVzMHl4?=
 =?gb2312?B?MVNZMUJnYmY3cGhFcTAvc1ljOFhZMHBjS1ZXQUp1Q3paUnJJTzZHNkxsWldL?=
 =?gb2312?B?MVVUOFhDSHg0cTBxYTJLeExLU1NoUTRtdk1EWEpyUjErTzJidm5hMmxneFJt?=
 =?gb2312?B?MEZHQUFwYXlhZU9Mcnl4NlJKdzJBRUpRdkJ4OE8rYnBHU0I5bktKSktEZFZD?=
 =?gb2312?B?MW8vekRuYldDMW9GbXV6dE00M2RPTVdvV0s4QUVadDV3Q3FLM010N0hjRG44?=
 =?gb2312?B?N29DMXl5Z2JPWGRNUUpRcGlkcWpheUk4UzMzY0NSZVBSV0VrZ1Z1UlZUNW4y?=
 =?gb2312?B?T1lETmhHeElZK3NZZzdhb3lnUFR0SEpTN0hEc3JOVElOOEZGYklRRFl6MWpn?=
 =?gb2312?B?Y2dTOHF0MFd3ZHhxVlZVS3FMS1ovNEtzK2dramIzSjhwdVVZSFBmR00yRFdy?=
 =?gb2312?B?MHpTd0VNbENTdWg2MWZGdFFHdjFWMFgvMlh4bUNTb2FPS0dNZXhyZFpsSHVO?=
 =?gb2312?B?bGtzeGg3RnlBV0REa1U1K2tLUHlISEYwV3F4SXNCMG9obEdpcFovUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 977dcd9b-7b61-4a48-7a5b-08dec870fcdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 10:54:33.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILSTqZP9EwVTxQUvHL3mAZuBA74XGZdKeF+LiWDt9w2YLE/sEY4pXY3VLfoOtg1yQnvpgPuq1Zps7Eu0kWwothYS2BGjLT1hv4QUxaFcD6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0768

DQoNCj4gDQo+IE9uIFdlZCwgSnVuIDEwLCAyMDI2IGF0IDAzOjI0OjE1UE0gKzA4MDAsIE1pbmRh
IENoZW4gd3JvdGU6DQo+ID4gQWRkIHNucHMsdXNlLW5jc2kgZHRzIGJpbmRpbmdzIHByb3BlcnR5
IGZvciBTeW5vcHN5cyBkZXNpZ253YXJlDQo+IA0KPiBJcyB0aGVyZSBhbnl0aGluZyBTTlBTIHNw
ZWNpZmljIGluIGhvdyBOQ1NJIGlzIGltcGxlbWVudGVkPyBTaG91bGQgdGhpcyBiZSBhDQo+IGdl
bmVyaWMgb3B0aW9uIHdoaWNoIGFueSBFdGhlcm5ldCBpbnRlcmZhY2UgY2FuIHVzZT8NCj4gDQo+
ICAgICAgQW5kcmV3DQoNCkkgd2lsbCByZW1vdmUgdGhpcy4gTkNTSSBhY3R1YWxseSBub3QgZ2Vu
ZXJpYyBmdW5jdGlvbi4gTm93IGp1c3QgZmFyYWRheSBmdGdtYWMxMDAgc3VwcG9ydCB0aGlzLg0K
