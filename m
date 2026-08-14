Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60A41D200;
	Fri, 14 Aug 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703491; cv=fail; b=IBJemNoAzW1sJ+/tq4L4+P4iTB1u4tCHV9L4CEAEQnjLN+Ie/oFmiGa63aDaiX4E3lKo+0xlJX9OK9plpbEAzgWDuLN5hNsx5ncJbplDaf1EG+1iMid7RoYLNpMUCt97iqkQhf9r1/P4pT1WnuNYBO6ek772Ykx0I9VlQIYKQV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703491; c=relaxed/simple;
	bh=meGefToAe6XQwuoJbmL/KopJMsUFqiO040mXIULrNPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S5DMWmxwEtJx/6V9c5pYlRsuhFhi0MyEx1bADClWtScqNCQPvFAKJqG4Ol6eCyULQrHAcD3cv6gfxMCOdiuU69alR17zMoQiPmK9qG/t5hVQEeZZ4R5OaBM0wRbviRyBF8TmJL0OvbNrsyhh4NnBYMb84GXotmPYKkm7Z13lYb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PIM2nNDC; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PIM2nNDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOE78eRRp/GKIhhkisPP9CakcH0mhYv+HUCdx9WAaqrbZsyzCNl0mSoYpORhuc7CYHZZLsIRoWAhfJiF30qLQYaCWAcPjLgJfsK86tdcUeGaZtUY+zryR48Mwjmribov/DJXZgE8bE1CrmeGVulW15wUClGud2YAcCnrsHPsi7jhi7fjh/zDyBjpDjWOuUiGP4wFP6u+iy5XCmCjOr5s8WughTDXLPRXGZQbbO4TnZEl4PYDPqPeyKgUVyT7zfqgeKRq7gHuIBRBD381CnS/gvvNAKEBqHMrBpE4kUgKgb+2M4pwSILNF+zlgZPR8rFx1ihlo4HIl6qEnlM+WOF07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meGefToAe6XQwuoJbmL/KopJMsUFqiO040mXIULrNPg=;
 b=szej1bCS5pfPguZpT+H9hevCzX5W1O0pH2OlLOYREoSqmN7OxjrkTomktFtSJK4UnjgIMnKfsH3kJTJb4rVG0/tf8bPousoeTv0N7KMkwbyMSN9B5O4nrhqOaeLMrHZ9nfVe8iYiVf0XxdQGm4H7aoZuAwyJf32qFW9Cut6V6xrzRPnlRXKYWkc2PpnwUuoAzR92Mh7ClB/IWtRJOc1anu24xlMYJNqZxAfKwYcaK09RXpbF9JdmPaJeGfnfkAkhHV6R1nIAGrGLAgCFdhXxh5FvfdYspUVf2qUBfV+4PNYJ16IC+C4zpa1CzqY2R6AL0p3TpczjLtzH6lx5AD1eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meGefToAe6XQwuoJbmL/KopJMsUFqiO040mXIULrNPg=;
 b=PIM2nNDCq0uaAEZqj0cdQspfeKq7eWa5btTAp54m0nt8NiUGgvCYp50BlU+AdejZK0Jz5JceayzwAPA+w17I5xGGrEGCHhw0Y6gwOAVre9zyXOCRyRiBrIq7Q/Mdk8fAq4F/iEx/RoFHCpTrSrB3Qv/4XwDTdJNSLvNfyRXDlw/55SSlOqChBfGCKscW3W/xTllUS2zJE8igsb36kNaDQ9jFdcJ5EOz+PnneSpKFzlY5POkTV4ykZcOZjWdq0toZLJlrPHkPfjL8+R9PiFhexuGD7XNK4rMJOspF9venFTDiA26k5Cje15jk2TMw/iHr3IUK4kGgq+M67GdletTn+Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB9335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 10:31:14 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 10:31:14 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-imx@nxp.com" <linux-imx@nxp.com>, "wei.fang@nxp.com"
	<wei.fang@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "frank.li@nxp.com" <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"shenwei.wang@nxp.com" <shenwei.wang@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: Re: [PATCH net-next 2/2] net: fec: support receive flushing via
 fsl,rx-flush-queues
Thread-Topic: [PATCH net-next 2/2] net: fec: support receive flushing via
 fsl,rx-flush-queues
Thread-Index: AQHdK8yTaJWuwuEfxkyO5v+0MkuSUradWHWA
Date: Fri, 14 Aug 2026 10:31:14 +0000
Message-ID: <1804f32990a28fef39e5fe5553578c27cf3a179e.camel@siemens.com>
References: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
	 <20260814090906.2225075-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20260814090906.2225075-3-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB9335:EE_
x-ms-office365-filtering-correlation-id: bbdb9aeb-173c-49cf-d47a-08def9ef2ab9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|6133799003|4143699003|10067099003|11063799006|22082099003|18002099003|55112099003|56012099006;
x-microsoft-antispam-message-info:
 8dwELmHYau9w6vu7kmVH0cwZxoHu0nPnBxl31hIUVX7PPqHeePA5zRnRCVBoe+FvLEqCn4tocPlO2QoUUB2bNqMrk5sA1tA+FC0kWqagkzHLIW220h0FCHxPPk29M2eMSjunCzY6OJSAh8yUky/JaYNWQYtUD5GVajIa8UU9um6qcWwqJbFVtkDFHPrn0v2BpiQsf63ADhNPQVSqaVNgMPrdKgiys55ToApSgQQA3iLwW8Hu5goghYhwJtCulH0Rtg6hm1Q1mMIcc12OheFjZt7iE0J4P1x+sDBtMIOp6pebfBAF6flKySeYE2jYlRK7h/7LcwTOTm2M+vIkDwpKd1q6D//GImS4IoNbT+Q358v/F73vjIdgoxx9xBIEMyOWjgluPkJMqRrxfDuYAWQdQFuc+OB1y6uSkQZ9nn16Ivke3oDANcuL4CTcFXMP4PjyW9GnrX3nhyKWp6g1WhKh87tSR9YlDFi0xs0Ffdo8YrQK+/wJF6yC4l8FRDHnPHkm3ZLw0TqT4SRxYtOGyXqhhVT2q8D6vCIqvDfuOfX/IPgGFZUlCzmiA+SWjjca/b99bC6S0DAkqePLyaBpDS947YgbVvuEQbZSpk63XqlacFLkwDM709uPCO3orIcZtIezSvVzEZ6RLO4Qys3wB7B5lHm3VsyW7MyOJ9M5Jbo9a0o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(6133799003)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(55112099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUROV0hGeXF0aXVaT1NQb3VoV0JvcFVBWEtPZTNhbGhVTTRsL2dvaWRrOCty?=
 =?utf-8?B?T0lVMjZtNmJZQ0ZjVElxOHcvMkZzNC9vMXhCRVBLSFdwTGpzNGthMkFWUFhz?=
 =?utf-8?B?bkR0SmtaZElwM2E5UFdhZ0dRcWE0ek9qYXdGVEVwaEVqOFdUM1pmZXVvMEM0?=
 =?utf-8?B?NWFVcE1NY093WWg0cXhKQ09kbVJTMVBMcWQ1ZFZva1FCYnBYRFZJUmtFRnUy?=
 =?utf-8?B?eXJrWG1ZQzdZZW1CMlZXdVdFdHR1Ylhxc1lrM0NvdFh2aHRmaCtFNExZVkg0?=
 =?utf-8?B?bEVZWkpscHA1U0Y5SU1TN1BjSmV2VHZCWk1scVZOOGNlM251TzhNK2d3VzFt?=
 =?utf-8?B?S3RjZlhoT3NzbHdGWmo2cUYvcXl6MENyM1p3M01yeEZlRjlqeExKMXlZeUhn?=
 =?utf-8?B?b2J6QTVyaEsxYTJtZ3pUNWc1VXBWUkc0bDJ6UmpmT29YdnJrbWhVTnJRMzRW?=
 =?utf-8?B?ZEgweFJ2a2tOb0JyZEI3Z2txMFNjNlZiODRKaHhQV2R3Z0ZoNk1QTUhPaUlN?=
 =?utf-8?B?aTF5ZFpjN3MwRFZEMC9CeERxb1czeU50VlRKWUlyMGZ0SGlpL2Q2cVVqUEpi?=
 =?utf-8?B?ZHpaZ1UyUktoR2Rpdnh6TjNsTkZKdmpHMVlXMEhrR3hVY0p5T1BIemR2TDhY?=
 =?utf-8?B?K3V0NWZlOGdWdUx6WlJ2Nk9KMDVTT1U1UGRUazFZNGhLR3YwY1podktiRCty?=
 =?utf-8?B?dTUrODBraGJaTHdSaThYc1pmald0dFM1NUNtNysrZUdGcWR1TmxNakNjK0lx?=
 =?utf-8?B?L0wxNmtxYkJPbDNwUEFFYVRwL0NrRGs2ZEY3cWcxd3FtVXhMUmoxYnhuZ3pl?=
 =?utf-8?B?Ri9NdytpMDdPTiszM0xEN3RFK2hydWZVN0pOOHNrR05JWGJoNk5wTDloN2Vi?=
 =?utf-8?B?S3JHZGV3YWh2MTZZV0lvMHRXYVczZE5pYlBrOWdoTFNocVk2TEpiQ1k1enkr?=
 =?utf-8?B?ZllaR3N4eUp2bmh6ZFJETnBHOVJEMUdxWjRHNFdJSURmWEZtaUNqLzZhaFRo?=
 =?utf-8?B?MHhzZndxNzhrRktxR1NnVnJvNE16dm9DU2xYclpPMUd0aStFYXRoUWNhdHBJ?=
 =?utf-8?B?QkpwV2E4azZNMGIwL2ZSVyt4eFRLYkFSNTFJemZsNG5zY01hTXk0R3hIb2hE?=
 =?utf-8?B?Y0c1REV2QXFwRlpHUUtsSW5NNHBnbHdDd3lheEwzUWNLeWNvWU05bnlsVVI1?=
 =?utf-8?B?ZytXZXpqNUZIeFYyVG56RmhWVEZQT0VJZHljRnk2eWVIOXlSZXRJYXE3Nkxw?=
 =?utf-8?B?R0xzSkR1eWxRUFI2OVNBc0lzWnpSSmtDeWlnYjM3ZUp4bE16MXZNOGsxbW9B?=
 =?utf-8?B?R3FzNXJ3dnZIakNDSFpCNXE5WndVaHR2MGJoQzRKOFB6ZFhKZTFDN0FjRmlF?=
 =?utf-8?B?L3ozSHhSZW1wcnV5eDRBM2VYd1l2OEZ2VXRtb0JzQWhRWXcraUozcWNUN2VT?=
 =?utf-8?B?cTBnMDJUSGhoK0oxMGE2VGZhTzJoWlhNMVlITVVra1l0ejEwalYrWi9uUzdN?=
 =?utf-8?B?emtWR0dPcWh5ZGhTRXNxTU42VnUxUnFJWjZZQVpBZmo4YU9ZM0kvTWxwNzVr?=
 =?utf-8?B?di9OWkFwR0VOOXB2Wm1FQWFkVXQ4aUtlYm5lTUl5Y3h0NFBodUJnN2RKT3ZP?=
 =?utf-8?B?L212S1RWWDA2a3hWU3dzOVBvWW0zV1VSa0g5QzdYR3NQc2Q2aVhybUV5L3VB?=
 =?utf-8?B?VjFJZEw3dGp1WEJ3TzlFbGlJSlNxVS9CQkJoelFWQThHZDF0cHNGckJFdnh2?=
 =?utf-8?B?bGsxQm1oUzRWRW1TSjhSTXRibFNJQjhPS1Y1WEZCaDhnTk9pbmlOeExyWEs5?=
 =?utf-8?B?SjJ2eldvOWJvZjNFLzR2T1pVUHZ4b2xxWXNsZi95dG1FNE1CNkY4cHlkVHNE?=
 =?utf-8?B?dU9FZ3hQd0pUbGJJbmc1QVlzQm1pN1lIbUtwLzgyaWU5SW9zYlpCbFpoYkVS?=
 =?utf-8?B?Wk9YU0wzNjcxajZXSkROdUJ2N2c4S28yUUJqVXFYWlh1d3ptbVZTeUNXRnNI?=
 =?utf-8?B?NmFWOWx3UEErV0F0QVVQQ3UxUlFCZGhwM0hCOHhJWW5tQkJzZG9OcDdGYnFW?=
 =?utf-8?B?SDF4cXAzUm9ZMTlBdUNYTUI0aHdUaTNRQ0JZaUNpT3NQeDJtNEY4SHFXMFZx?=
 =?utf-8?B?YkpMWTV3d3RMY0w5RVptc3Y4VXlVY3g0cVJ3S2NIdmMyNlFjdXZIM1RhdXZl?=
 =?utf-8?B?WmJTWmJjVnBZWDlTcFRKNnlqVEhEOHZQMlBvYW5qUHUvY2tJMnN1cHBmTGFZ?=
 =?utf-8?B?clE1eHBtbnp2NTNtdjExTGsyUFMyRzBUcEZPQUhvcVN6eU5XQUJMNnFmR3FE?=
 =?utf-8?B?UlpGS1NCem9kdHM0VTBWYnEzY3pvdDFSVjJSRm5QNng0WG13SzFOOGtjaEdV?=
 =?utf-8?Q?dwY+MeU52t19gPF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F1B20D1301A9942BEB90D72F3FE9948@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdb9aeb-173c-49cf-d47a-08def9ef2ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 10:31:14.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/KBcz2+BE7bJYmJf+Yi/N1EBoRD3f276uQ+tOtv2BUklajFj6fCYG8Qs8Gb6yyOlrV5Ib+wIgTLQ8zl0gezHwcqoStSjz8TrJKj7CFFPAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9335

SGkgYWxsLA0KDQpPbiBGcmksIDIwMjYtMDgtMTQgYXQgMTE6MDkgKzAyMDAsIEEuIFN2ZXJkbGlu
IHdyb3RlOg0KPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBz
aWVtZW5zLmNvbT4NCj4gDQo+IFRoZSBGRUMvRU5FVCBjb250cm9sbGVyIGNhbiBmbHVzaCBmcmFt
ZXMgc3R1Y2sgYXQgdGhlIGhlYWQgb2YgdGhlIFJYIEZJRk8NCj4gd2hlbiB0aGVpciBkZXN0aW5h
dGlvbiByaW5nIGhhcyBubyBlbXB0eSBidWZmZXIgZGVzY3JpcHRvciwgaW5zdGVhZCBvZg0KPiBs
ZXR0aW5nIHRoZW0gYmxvY2sgdGhlIEZJRk8uIFRoaXMgaXMgY29udHJvbGxlZCBwZXIgUlggcXVl
dWUgdGhyb3VnaCB0aGUNCj4gUlhfRkxVU0huIGJpdHMgb2YgdGhlIFFPUyBTY2hlbWUgcmVnaXN0
ZXIgKEZFQ19RT1NfU0NIRU1FKS4NCj4gDQo+IFBhcnNlIHRoZSBuZXcgZnNsLHJ4LWZsdXNoLXF1
ZXVlcyBwcm9wZXJ0eSwgYnVpbGQgdGhlIFJYIGZsdXNoIG1hc2sgYW5kDQo+IHByb2dyYW0gaXQg
aW4gZmVjX2VuZXRfZW5hYmxlX3JpbmcoKS4NCj4gDQo+IEVycmF0dW0gRVJSMDUwMzk1IChlLmcu
IGkuTVg4UVhQKSBjYW4gY2F1c2UgYW4gUlggcGF0aCBsb2NrLXVwIHdoZW4NCj4gZmx1c2hpbmcg
aXMgZW5hYmxlZCBvbiBtb3JlIHRoYW4gb25lIHF1ZXVlIGF0IGEgdGltZS4gUmF0aGVyIHRoYW4g
ZW5jb2RpbmcNCj4gdGhhdCBsaW1pdGF0aW9uIGluIHRoZSBiaW5kaW5nLCBlbmZvcmNlIGl0IGlu
IHRoZSBkcml2ZXI6IHJlamVjdCBhDQo+IGNvbmZpZ3VyYXRpb24gdGhhdCBlbmFibGVzIGZsdXNo
aW5nIG9uIG11bHRpcGxlIHF1ZXVlcyB1bmxlc3MgdGhlDQo+IGNvbnRyb2xsZXIgYWR2ZXJ0aXNl
cyBGRUNfUVVJUktfSEFTX01VTFRJX1JYX0ZMVVNILCB3aGljaCBmdXR1cmUgcGFydHMgd2l0aA0K
PiB0aGUgZXJyYXR1bSBmaXhlZCBjYW4gc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFu
ZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IC0tLQ0KPiDC
oGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaMKgwqDCoMKgwqAgfCAxNCArKysr
KysrKysrDQo+IMKgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgfCAz
NCArKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWMuaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBpbmRleCA3
MTc2ODAzMTQ2ZjNkLi40YWYzYWUyODY4OTVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9mcmVlc2NhbGUvZmVjLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlYy5oDQo+IEBAIC00OTksNiArNTA0LDEyIEBAIHN0cnVjdCBidWZkZXNjX2V4IHsN
Cj4gwqAvKiBKdW1ibyBGcmFtZSBzdXBwb3J0ICovDQo+IMKgI2RlZmluZSBGRUNfUVVJUktfSlVN
Qk9fRlJBTUUJCUJJVCgyNSkNCj4gwqANCj4gKy8qIFJlY2VpdmUgZmx1c2hpbmcgKFFPUyBTY2hl
bWUgcmVnaXN0ZXIgUlhfRkxVU0huKSBtYXkgYmUgZW5hYmxlZCBvbiBtb3JlIHRoYW4NCj4gKyAq
IG9uZSBSWCBxdWV1ZSBhdCBhIHRpbWUuIFBhcnRzIHdpdGhvdXQgdGhpcyBxdWlyayBhcmUgc3Vi
amVjdCB0byBlcnJhdHVtDQo+ICsgKiBFUlIwNTAzOTUgYW5kIG11c3QgbGltaXQgUlggZmx1c2hp
bmcgdG8gYSBzaW5nbGUgcXVldWUuDQo+ICsgKi8NCj4gKyNkZWZpbmUgRkVDX1FVSVJLX0hBU19N
VUxUSV9SWF9GTFVTSAlCSVQoMjQpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5eDQpUaGlzIG9mIGNvdXJzZSBzaG91bGQgaGF2ZSBiZWVuICIyNiIgKHJlYmFz
aW5nIGFydGlmYWN0IDooICkNCldpbGwgZml4IGl0IGluIHYyDQoNCj4gKw0KPiDCoHN0cnVjdCBi
dWZkZXNjX3Byb3Agew0KPiDCoAlpbnQgcWlkOw0KPiDCoAkvKiBBZGRyZXNzIG9mIFJ4IGFuZCBU
eCBidWZmZXJzICovDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cu
c2llbWVucy5jb20NCg==
