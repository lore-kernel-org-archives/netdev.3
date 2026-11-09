Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.151.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244229;
	b=e6RCuL4IHXGog2A0WG0xhUNup7W8NdOe5hTlRIkvRWFpkJ8P/s1Z92yKIU982lh2ZW0a
	 8YfleRE6sA+OOtt5KBYhq+mbN6gBc1mUe8i2A6Dor8Smolnu1q+KbWc8LEyb3ntKeQeyU
	 jkgZGJQaV94bYsvQMSiLruuf4DhvP9/SPEnR/e4ySQIVbL25YNb4jYO1NCW80gfVGGfIJ
	 3dW9cGec5Qh/KqSPrjI4PfyGSmzG013ZXALYeIz6m0lGrF3S0LCfVA671pbcUavZ/6tfN
	 lySK/5V1Q6JWYARnHnDeTcdmuk32YTpU8zyfHR4QZQgOvmDfWaityS/9b2+zxi4iMdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244229;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=K2XDDt7kZKlclY8QgGb9Uc9zIkGVZnhfW2L9b2HpxRc=;
	b=whUIAonBD/E++7ZbK2XQXZBp15ldm+YGn3TjvqdLbKUjAaBUXr2U1Cp0yiBv71wI/h61
	 wMUgfN+QMi2Zb4QNt6LN2Hl91mYfzs9bopuq5nyLNOC9LoZ8mVvFAR+Q4ML805stZAzQx
	 vNlT7J6wzPST0ldVlCQ8YO8byJD1210YFROZuVNyHTEPFSuvwSPAh9llZ1YVSwNqPf1sr
	 ELpV8AyHlD4tClN5GMv4iH4NLxo0gV5DM+7mO0cqM9S67x/Fa1y6rIoG0cJ4hNCyqciGg
	 aNEfx5MC4VDzG5HJOdwc0cZRwZP4bBYIItTv+d34KWdXa6ThJVnQ4YwU9xj1MGzHJaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=Hy2Li1SY;
	arc=none smtp.remote-ip=170.10.151.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53D606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C53D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=Hy2Li1SY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1794244228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2XDDt7kZKlclY8QgGb9Uc9zIkGVZnhfW2L9b2HpxRc=;
	b=Hy2Li1SY/LeGxaGHcxRo3kPcnxO9X2RX9HwuRbkFW5lZKVpbwue34L1XtbZKCUuiRV1j/x
	9DWH4aE5pukmlHjy/CsTpL5IRR9WlPMuMlmfOexsLMjoGGhycM2F0fUH14biWNC4e3SdF3
	jjoTMFtYo7Qu/93yDLbxHmTGZwlx1dQnT9QokG2tMEacMRDkklXR39wfwI25Ua790mmUgp
	z/4poWlfusweuL296aom7Djcoo79yGQ7WvNepQZDNuBKWTs68eXGMsNqEv9ivBM1v6SKF8
	PtI8JZKJhsU6JGyl7nOHtBv466JTDRJjbidflfCWg1p/tFQX9sjS8pFD7vHkZA==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-45-YM-c8T2TM6mZteFslYmagw-1; Mon,
 09 Nov 2026 09:10:26 -0800
X-MC-Unique: YM-c8T2TM6mZteFslYmagw-1
X-Mimecast-MFC-AGG-ID: YM-c8T2TM6mZteFslYmagw_1794244224
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by BL1PR02MB247416.namprd02.prod.outlook.com (2603:10b6:208:28e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:10:20 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 17:10:19 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Marcelo Schmitt
	<marcelo.schmitt@analog.com>
CC: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin.sipraga@analog.com>, Ciprian Regus
	<ciprian.regus@analog.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/7] net: ethernet: oa_tc6: Allow custom reset
 settle time values
Thread-Topic: [PATCH net-next v2 2/7] net: ethernet: oa_tc6: Allow custom
 reset settle time values
Thread-Index: AQHdcCojBCiEkTu9dkq8z7U7yKQig7cl+Raw
Date: Mon, 9 Nov 2026 17:10:19 +0000
Message-ID: <CH0PR02MB78672CADFFBEFD294D82366883732@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
 <20261109085952.105331-3-iustin.stolniceanu@analog.com>
In-Reply-To: <20261109085952.105331-3-iustin.stolniceanu@analog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|BL1PR02MB247416:EE_
x-ms-office365-filtering-correlation-id: faa76508-aa44-4f4d-7927-08df3e845533
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|921020|38070700021|4143699003|11063799006|56012099006|261021135927099003|261009223027099003|10067099003|18002099003|22082099003|3023799007
x-microsoft-antispam-message-info: yMIXKsZzC+3V9ca5KH/SfYwqW4w0HVVVf5m02b5XSrF1jlsF1hWqIsN3lg2ZrIwlyjITx7eeui6Clw/2Cu++DctWXWNWr2kebDyBkKpX1eNoBLtLHC2mUqXmD6j52rcb0fdSnhjf0Hl8ompIeydYgoHqUwgZXaoW6XgE7pw2OFbdPxPmHV3QbjUqarEYrv0C98+Ms91TiEClzt8uKlv9r4aP71qoh8C6XA73qTxVKk4hPUDqzYFMNm0b/oOW+Gpz5Y1Feea9ZZCGdUJzpmiPNIO2zvU0grpHXHYoGrBuT5o1KYICsXh617apAXrgwpXA664v94gnj/zkYq/+DI85O9IpfTpx8lC5Dklqr+3AAhFwNXXh74SWqrlVEaWOEQOX3+OoGTtsXj9vMS/5Eh1H1pn6ZOzhcU1liy27DfdQEVgGq9fZ6sbzudTTMof8aVS7VPFWqa2REEZ/zccgqWWUeXyNVnCIyZpPbBc0ehCecqnHXFsVxBhvVGh+sTH/Ebp+nG3M+5xkiUbkj5njn59BX/SkHVaJLioFHIF3hAitQ2M+6dFLl/NvVSD0ac9Ut155VLVRkTKIQVmIljjf5oHclIVgjhgzLQqZoEFr8bksn3i6mQNvV4IMl1VcrmwTL19oOFMH52OGiKAdkM+AIt9StgDsLc5Ue3Q0sZPe+lWAz+0A5rzOlBQnwKwrR3VPPeAWtSzVaH3cjGaIgARqEfrFn3OT3MhOe0hAABV/SSPTTpuM3J5AiA4v98Fs+/2biy1Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(921020)(38070700021)(4143699003)(11063799006)(56012099006)(261021135927099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d05JTGFvZzNxdXNUOUIzR3FjMGs4UGYrUmpNVVdmSzFYbDcwakx5dWRZTmpn?=
 =?utf-8?B?TDcxUGtxcVc0WkJhM1pYNWxsWWRzWllJb3pUM2VGMjRITnBFRHk4NkJ1TWVD?=
 =?utf-8?B?ckRKV2FNanBwUzFsMUpmR2NVY3NFMFZ5MExLRDZaMWZnQVB5cGE0eHduVzdi?=
 =?utf-8?B?RTlqWEtBck5VNWhRMnNaenh3U1FKbHNpa0gzK2hjellERU9VaWM0WG1Ld0RL?=
 =?utf-8?B?anNxUEc1YkdFcXlydnlYUTVUWFJwN1hYYWZFZi9iTk5FNnFoR3BqQTFSOXNv?=
 =?utf-8?B?djdza1U5aDBxVmVXcjZ4bllqOUViRHh1a2NKUmpvRTZUUHpyaTFnWnd1eVIx?=
 =?utf-8?B?TTNrUUdCQzk1bDRZdkR6NHNGSGcvNTRId3hybUdHaFRybHA3U0dPZlFid08z?=
 =?utf-8?B?cWRUVWVseHBXWkNrVXZPQTNnVCtCNlJtLzdtWGlSMFZhSjVLNjQ2ME5rZ0NK?=
 =?utf-8?B?NkxMUTBiSCt4YTN3QStQeHlnKytWYXVwQ04xeXhkVmRVOE9sdDh1WlZYYjNP?=
 =?utf-8?B?dkdrdDIrZ2txYytlNCtGQ1diZjI4SS9IcHRXUm1VUWw3VXJIaHZUc1FkZ0xk?=
 =?utf-8?B?cmQ1WnNpcWFQL1VJY3RyU0VjZnF4R3BNaTRPQUtzUkF4ZVdrRXJ0YnhKbHFT?=
 =?utf-8?B?MjBXTnJMKzMwbld0c29PaFVnZzRPNTlTUWd0ZVZrREJ3NEJaQVdSYmViTEdB?=
 =?utf-8?B?VjVLemdQM1NKUTdmTzFDNVB3TVRldDNMYjVieUROTEtCUDNOUTEvdnpoZDJF?=
 =?utf-8?B?eXBERkJKa2VXY0QxLzFDd3FLaVExSnkyMlRBRDhsUlVTbjN5dFE4bVd2RytN?=
 =?utf-8?B?b3RROEd0a2w5emROZzFZY1lIYUh4dTZEY20yOHA2UTJodWgrMEVpUTVERWJw?=
 =?utf-8?B?YitZNlIydllhalk1SnRldjBXanp1NlgvU3RNVTN4d1p4WVNhaFhaRHNlaWdU?=
 =?utf-8?B?bHcyc1hwN3BuS2crTDh5VkFWOXlhTy9KSHlEVDAwcFZpNGxjaENROXZ2Y3NH?=
 =?utf-8?B?alBhWkhGMWdORHkrUWdwRG5JOEoxUTFOeUNlaHNseWM2KzAvSUFZcmdzZ0pM?=
 =?utf-8?B?TENoV3NjbTZmbk9YaktkNDJNUUV6NWJtL3c3Q2tFL1ZES3ZqVUlhNmdHY1l3?=
 =?utf-8?B?amJPZk9Jb2t6OHAzWlp2VENXK2Q3QjI4M01YMnFLQ01PUHFINzR1TFdIcjlR?=
 =?utf-8?B?cndJVG9tYy9UeVhGNEZXZ215a0ZwZFZ1V2ZQK1d4SUVEZDdheXYxZFdHTlVU?=
 =?utf-8?B?R2ttUktlUDlNUU5MYUZFUmJMRzZhSS85S1J0QzdacHlnNThNTUdiK3I0V2hU?=
 =?utf-8?B?b01EbjA0dEVqMHNyQ3JPZmF5TmVTdEZjaGQ2cThxYUlITnZnWmFyYlN6T21a?=
 =?utf-8?B?NjNBbnNMUWdLUVZWNGkzcHQvcy9COEp0dENOeE5naldRQ2tkWFZUYWl6ZW9m?=
 =?utf-8?B?ajlvTEtMV3lScm50OUxZeEJjalQvQUxXdk90YXI1eitJK1gyRU1ReHpuQStM?=
 =?utf-8?B?c2ZTL3FoQzFjbGpRVDNHTGhKZnRmQjkrcGJCVGkyTnJOVVIyRThxTHphM2tj?=
 =?utf-8?B?SHpkMTNuT1RyWnpOWEtKcjludGdiZWEvMXVmNVBueDM4SVZVRFBseUNsMXk4?=
 =?utf-8?B?aUpiRVgzZmdoR2VYRnczVzlMbEhLaXVQZDhNd3hrR3hERUo0a2VvOGIxVUx3?=
 =?utf-8?B?OVpMMU5OL2ZkdW5nWHlybFNCTXJEWTN4RnFHODhkNCtwZHdPT3FtSlkyb1Y0?=
 =?utf-8?B?U0c0aHRnZFUvdjJ1U05tK0tleXpvNUJaenNQVkRyb0NrSWpvR3FwV3ZMbWtG?=
 =?utf-8?B?MmRPSUhXRm9YRHR4aEFnc1NGWDJsNVU4UVVyazY5d1VEQU0zd0NLUU9laW84?=
 =?utf-8?B?QWxNVkxRbzhwdzhjYWM5TlVvQ2Zpd2kzSWZWSDJCSzdMZU9tTm5RL1F6b05L?=
 =?utf-8?B?VDlvOUJrQXlTWElzQ3hBemV0N0VFV3d3aVgxeVhRUGlMeGtoMW4rZ2ZucGho?=
 =?utf-8?B?U280RHNUemdFbHJVTjVmRUpGdjN6SlJDcitkMjVjY3h6WnFOMXZ3elF6NlJL?=
 =?utf-8?B?UmdHREJTOTZIeVE3K1IvT0ZPY1VBeGxYT1BSb0JhNG9TN1F2cDlvVitzUWUy?=
 =?utf-8?B?RkxpM1Q3NjVncWQ5b0crWXgwVUlUdjMxNzJGK2UvbWV2aFkybi9ubkF6bU9l?=
 =?utf-8?B?aVVMbngvYkYrTUNrQUw3aUZ6OUFUU0I3amFnUm1tZGNrb0pUQ1JIcGF4dGFm?=
 =?utf-8?B?V0YrZUlXK1lZSXA1UnA2UXM3dTBZSUpLZjNuVXNvbXdIYkVMYXJqZUxKOEJP?=
 =?utf-8?B?WkhvMjBybFlUUEtNZksrRkluNnh0VXRMZW4xcGF0dVV1SDVBa2xSMHo1OU5v?=
 =?utf-8?Q?ttuBo2k4dHM3jhwg=3D?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EklzSDwdA001uyNn3fxvxfnqqdNpOY9qR66TfH0SaxxyETuKamwkp0QT0YBdYmJnsd+HHvt+PUw0LJgEuRkDeIIqv3d0uYDhD6jEAs0GLXdEj3hnma1D5gr0GcpJL9N9s6nf9g9MMpspKVbyZ+ICGkE5DAVsrkPoNHdxC3cB2oqjIqSNzX4ByDEZenVSDKukHfDFQV4NjhR+SJmgT6Xmuw4rvZ++gFXqGVH1YwuEDJ9jzsblncRIa8b1Z0pi54505RILAmxqDgcgDqq5Qv63yfACxpb2q3i0K7SE9GiWFIPVWZsr19KBtJTJ232iLWtKpzRzyConypOeZKyvwNTpCQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa76508-aa44-4f4d-7927-08df3e845533
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 17:10:19.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3agVJ+BO+ymEky7u7Pci8UkwPJNUo6PxWwe5wEJrYvW0vMEAEdMo6G4/DBypMOjxqrVD/ZcYOXfgP+JUGSwwg4b5rUMJwmT5GWLT/hRYC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR02MB247416
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bo6H4Qf7k0Fu4Dzh0cK-bmCBK0LUWAECDqIpNtnNH4Q_1794244224
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEl1c3RpbiBTdG9sbmljZWFu
dSA8aXVzdGluLnN0b2xuaWNlYW51QGFuYWxvZy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQt
bmV4dCB2MiAyLzddIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjogQWxsb3cgY3VzdG9tIHJlc2V0IHNl
dHRsZSB0aW1lDQo+IHZhbHVlcw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L29hX3RjNi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMNCj4gaW5kZXggMzY0
MDI3YzM5ZmE0Li41NDk5OTdiYTM2M2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L29hX3RjNi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jDQo+IEBA
IC04OSw2ICs4OSw4IEBAIHN0cnVjdCBvYV90YzYgew0KPiBib29sIGludF9mbGFnOw0KPiBib29s
IGRpc2FibGVfdHJhZmZpYzsNCj4gYm9vbCBwcm90X2N0cmw7DQo+ICsgdTMyIGh3cmVzZXRfc2V0
dGxlX3VzOw0KPiArIHUzMiBzb2Z0cmVzZXRfc2V0dGxlX3VzOw0KDQoNClNob3VsZCB3ZSBhZGQg
dGhlIHN0cnVjdHVyZSAic3RydWN0IG9hX3RjNl9xdWlya3MiIGhlcmUsIGluc3RlYWQgb2YgYWRk
aW5nIHRocmVlIHBhcmFtZXRlcnMNCmZyb20gdGhhdCBzdHJ1Y3R1cmUsIHdoaWNoIHdvdWxkIDEp
IG1ha2UgY29weWluZyBlYXNpZXIuIDIpIEF2b2lkIGZ1dHVyZSBjaGFuZ2VzIHRvIHRoZSBvYV90
YzYNCnN0cnVjdHVyZSwgaW4gY2FzZSBtb3JlIGVsZW1lbnRzIGdldHMgYWRkZWQgaW4gb2FfdGM2
X3F1aXJrcyBzdHJ1Y3R1cmUuDQoNCg0KPiBlbnVtIG9hX3RjNl9xdWlya19mbGFnIHF1aXJrX2Zs
YWdzOw0KPiBzdHJ1Y3QgZ3Bpb19kZXNjICpyZXNldF9ncGlvOw0KPiB9Ow0KPiANCj4gc3RydWN0
IG9hX3RjNiAqb2FfdGM2X2luaXQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgc3RydWN0IG5ldF9k
ZXZpY2UgKm5ldGRldiwNCj4gLS0NCj4gMi40My4wDQoNCg==

