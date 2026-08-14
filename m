Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98663389DE0;
	Fri, 14 Aug 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717322; cv=fail; b=moqU3V4vrbJcp2IsqfsIW2BBOk+yLfiFQegAdUKDgqla+dKDIe/5ZvXDlGWjO/n7LIHiUy1R+bqeeCHMilsB/VU/1FFn6IMv4gI0U2vDeXBvXm9Q4SkMAOJ6F5iRwf5Id8g1059ol9Eq9Y4TISKF810Qsf1nZC6JNqBnlyXnrNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717322; c=relaxed/simple;
	bh=UQ+0qJh/2hrnmqknQtzCX5hTqqKEfQ6VLtj9Vl3vZTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9DFokeK28vzETojjaFPCJV608KyFuA/diQHgPQDSagkzIOBxSp9XNaG2D7VivFynmwyxNsXw+tK8QgLcO6EmuBUOtZ9rBvis3oLHu3NIk57U3gDZYcO7EKCQg+3zlNYa+vAw4NYD/Q1Vml2+sXgxvI1JxARrdE+znQgLSNFYEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iNvZ9QXJ; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iNvZ9QXJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9/i4NR4QX4VK8aYYC1B7qeN4RDhnQhZN630hoGyh5tdIW5V44LWu7iq4SiiNEl4R7hPrUfBzTEfOphU36DBqnMZFZEec9J/noV3NdtI9GPIwG8Zba9VphnfNIysIDCNF8B2udjETQYg20y34Vl5yeFK9CLOq39bl3FKdW5OhgthE5hnVNKRcTQEksEhx+ZNDzaD4nAd+PsRE5WZyKFVf2ezH5Mtun694yP1JZr4uuNcwv5vfYs02CT1L213Jghy2f7O6W+89w3eXRBE+u1v2Pw+5jDmK3DpjZXNrhUC3QteJ15dSoIBfE8P+Ezgs6Lo2XoPzF12C4VexaARL7aKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ+0qJh/2hrnmqknQtzCX5hTqqKEfQ6VLtj9Vl3vZTA=;
 b=jJQITpBpuyWe+GkSKZ0BOHa5vUyOptnMmC+BzTsaTjOQ1SaL/UjLilOgjRcs/nM9/wVgJ9SsxrRkfjPpH/aGhqYYG2LxXErd/0IQ+2pAWpkBnGYunDf7+/V0m4TqLXWHcQdsfsbDbSu0MJTQrT/f29Z6ehmikV/8OPVURyib65lYA0kK+fGw9BuPHKYEc4nkZ5OimnCsaC0KFVbNx4ZI8kcPFY6b1VgozIzlhqIzouj4O6jhnUNuv5tonVhG6+zSy8qGK/EQqubKWEVliXpasVyOPnxCnQN41yQM5hLhYvLo9b63zXj0kOSPeLwYlc3zMRwC5i1RNf5bI5sNys5a1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ+0qJh/2hrnmqknQtzCX5hTqqKEfQ6VLtj9Vl3vZTA=;
 b=iNvZ9QXJYQNOyt4FGDyO2MMDDFpOVzMmylY7SlZdIJXRDqkX8dYsB3gB5HCZtLSRnfRGrbd+vpdLLulopaolBL+wxpJbPTSAAYlTVwisQt+kKRGIB7a5gaPhgrEmYE+XK5YMtygZH3v4ne8VmYpAqE9YvmpJmyZ7LJ1YjYpdsYM6KxMnd8t07tBnP/aCNNz6B+f4MDXxvkkgt2m9x2Md5zPX6UsM706jMWpQ3j4XLzUqrwoeFhqxe6nzAUwguRxhZnsCkt/MdCbkQ5ZWBUnGPYzqNOWth/Vh4qbfS+bNsLbDqnPt2S7citrjTQ04BhRL0q8fcEsKME4VcOq71hj8tA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB5386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 14:21:46 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:21:46 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-imx@nxp.com" <linux-imx@nxp.com>, "wei.fang@nxp.com"
	<wei.fang@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "frank.li@nxp.com" <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shenwei.wang@nxp.com"
	<shenwei.wang@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net-next 0/2] net: fec: support RX flushing via
 fsl,rx-flush-queues
Thread-Topic: [PATCH net-next 0/2] net: fec: support RX flushing via
 fsl,rx-flush-queues
Thread-Index: AQHdK8yTD/IsIk0Q9UqvDop405QvL7adkccAgAAHF4A=
Date: Fri, 14 Aug 2026 14:21:46 +0000
Message-ID: <8c0cd8dec1a38f1d50e056666ef9f22637a86953.camel@siemens.com>
References: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
	 <d40f618a-8c04-42a2-904c-00cdb14ff988@lunn.ch>
In-Reply-To: <d40f618a-8c04-42a2-904c-00cdb14ff988@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB5386:EE_
x-ms-office365-filtering-correlation-id: 9b371f85-68b5-40f9-18a0-08defa0f5f5b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|55112099003|56012099006|38070700021|10067099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 Py569HznVKIF1WZWAomRF6yfEnd8SaKbRa9PwvuSkjEvAUHlovpjDO1uldYIAZ+nW0TCA0RrzN8+bgSFeylmWnFdnertSEEmezhSlXvqXuadgDzu7OoxWIryWQcW0gWOh9LLxQp6c0ELhCfohb64zfVlHwzOHUThfTNVyDzG5aTw4NL8qMz0meB/XlwhfWcaEVdcj70pDtC3SP67KOWzQOkyroocBXAuxt1gegc0LWLa60JEDWRqVyO2SCOxhBtEc6g/CGHEjZu6QplAhwQd0nt7zNCfHDW5Lc5lNKzo2p2ZMtk07DZ53UEPqvli/fmYAdponlfBEmAamao3aQGqAkanBf8riVtGXcPRcmLsVy0Uie+3GiltSAjKHd+2BY2vNUWhqeuVF7u62B85YyHRK3Y0Cv4+t7Y0Ha8vebPMpxKBNyVdLg5MwPMqm7HKhjGnZXoTSt/h0bS5OIPhKTJ+Q6Ms1sRvuYSI4xc2y69tluE+79nM/DyO+IzQ2NlN3KZr95vPMmlldrJ4xkJIaMPyk7MnbX355mwEYiVlSKNts3bVwqqBVfdNAMqhH4I1mltOcYRjC9bIeG9cDRWTKaV4ODvZ/QJVhKd702FKf7GhyUoFcuuncoNaA7RE6dLb78eYt5x6EMkBOBcYsP/WZAqKCmahDSdPvCnuB7HSiJMtEsU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(55112099003)(56012099006)(38070700021)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cktpYnRRUkJzSFJVelRPTm9lYXlhZjNaM2Iyb1VtSU9tSXk0NnZWcFF2ZUE4?=
 =?utf-8?B?UHlnVzNJd3JQakFnSlhyK2ZrZkhvN0lGeVpmUFhuc0lqbm1GVFVJZ2ZBLzdQ?=
 =?utf-8?B?QXl1SDQ5ZWlwbUZNWW1vdmc3VThZR0lHYjBkRitRays4cG9TVkxoMkozVnBN?=
 =?utf-8?B?dU5HV1loN0RKK1EzV0JBR1pDRmgxc0JhNGpoQjc3OTEwK0NCcmYrTWhMUkNC?=
 =?utf-8?B?aWpnRk1YbFRuOWhzdFhxZVRyS1E4MjMvcnkwbXZBd1NGM1lzRVJsVkpOQ2Vj?=
 =?utf-8?B?RGIvbXpzdk4ydnBZc1cxNHViLzN0NURQc2RWNUM0bkQ3VGFoenZtcnFrMlFi?=
 =?utf-8?B?TkgwMCtuWmVKNzc4U2FldkxWOTJab0RPd1QyeFRUakNvZzlXaUVxNFlrK1BV?=
 =?utf-8?B?TlpIME9PR1FiRXFXOWpob2w2MEFnZXZleWJJNjFNRWpUZUR3VVRmTllRZXdl?=
 =?utf-8?B?eWJ2TVZpb2RWSi90Tm1IQVRGTjFTZTVGSE5vQXVIbmhESDcrMDhveDgrRHpx?=
 =?utf-8?B?M0MyS2lWdzdxeXVYUlRUT3dyQ1dvdXQxeDY5VVREdUEwRFF4N0swNDBRWWJa?=
 =?utf-8?B?MFg3N0pYZFVyQU5Dc0prT1VJcUdtTWF1MXNaL2F4Y2QyOWR5bmpYMmZGU2d6?=
 =?utf-8?B?T25LVUxDQ0t6bWdPTkx1U0VmRkRpMi9teVpDWUdoUHVrNGJ1S3pXeTFCSEg4?=
 =?utf-8?B?anA5ZkhDcDl6TkRKVHBuUSt0dnNoNEMzTlh0c1c2ZGE0dFZoOUtoaERSQWlo?=
 =?utf-8?B?Wk13cUVmMlo5QVo4aGVZZ1ViRE5LSTM5OFMyWnFzYjZPQmpBYW9OcnFBSmE5?=
 =?utf-8?B?eENmWGFWdERzSlc0YkxXZFRTL2NrN1BnT2djSGw3blcyaTlXNkwzalhlUTd1?=
 =?utf-8?B?RXIrMEtYSWZESFlvS3d4OW1qQ3k2dm1DV3pKbVNzeWthVWt6Sy9XbEc3NTJm?=
 =?utf-8?B?U2w3T2lZc1gxK2JjRUh2VGVZRkp6aG5hM2F3cm9lb0g4WVpQMlU4NWdUNldq?=
 =?utf-8?B?RklJcGJsOGEzL0FHaGc0b0VkdmZiRElwaXg0bG9GdUVQWFFPcHQwMCs0Wklx?=
 =?utf-8?B?Qzc3TW5EckYvcWwvT1I5b2hiR1NDQjZaSlNibjhHK3hpa3IrRU9IN085YzNv?=
 =?utf-8?B?MkhGWjJQeVMyNUc3SmtCY2d6dXhhR3gzaFBOc1dEWG9icEc5bkFGWVlVcXRs?=
 =?utf-8?B?NFNtNzlRZXY1bWFDcm9Wa2RkRGk1K3ZjV1k1aGN0N2NEZnR4ektpQ2JWcWNm?=
 =?utf-8?B?NHNXYURRVEdicUo2ZlZNM0lKVk1yTlk5UjJTdlpTaG45Sk9mY1BiOXkwL3ox?=
 =?utf-8?B?V2dTamNPQkw0ZzhKV0N0bGhGVzdHdzJRKzF6OFhoZTRqZUpLVlpvWmtaQ0hO?=
 =?utf-8?B?Nk9Pdk82U1IxOGpldHc4VUZEcnQ0UDRPY29ZVkU5TGEzUWpaZWoxek1CK0lo?=
 =?utf-8?B?TVVTYktlVHA4MmE1S3p6UWRQcnhBbG00NERyZ0c1STg5ZjJ5TENJTU5qSGd5?=
 =?utf-8?B?UWc4K3BTUE5Gak1URkxhSC9sejNCd1g4Z09hd2JyL0NYamVpRklxQjFSVVlV?=
 =?utf-8?B?SHFNeFpyS3dKNXAyYUpPbHZncDJ5ck00UDhqd3hpbzJ2RzYwZE1nN3BVaDc1?=
 =?utf-8?B?eXVPbm1ZUXJuV0tFVzhVTXRnS3ZjWVVBYjhpcVBjZ1VGb3R3azdKQVMvQmg1?=
 =?utf-8?B?WEpHV0pVci9GOTlzbXd3RlVUZ0Zydm5nY0YvZ3JTZm1pRm5IUUxHMHRsUW9C?=
 =?utf-8?B?RzYvUmwwRmJXR1FUVDZLcFN5RG5oUUc5WExJbjJyMTZsV3h3Zm5mdUtmbVVV?=
 =?utf-8?B?WmJOY3VZc0FuMWZ5QmhFSFRZT3BXZGw2RWZQdk0yWWpyVTdLbGFmMm9JTXZR?=
 =?utf-8?B?eVMvZGprZ0lXNHhBc3k2cXdMdHc0Ris1akZRVk03eVo4ODVMYkpqd3BKWWVR?=
 =?utf-8?B?ZGVnTkNEa2w0dk56aFB2akNFRjdtVmtrSUFUdklvSElkNm9EQUZvYlhONW0r?=
 =?utf-8?B?cTc2eEVpdlF3SDhlMFlBZGFEb21aYmFIV2VGaUJHdVZ6U1EvMzFqVTlOd0xx?=
 =?utf-8?B?OE9GZDhrN1huNVBReWNHSzZ3TFpwc0ovbzlvUVB5Rm9FMzdvY2c5V204Wmw3?=
 =?utf-8?B?VFNURUpzUmo4VWxQZ0ZWc0JORVZJOUNiRTIrVTZEL3RJTVFRRW4vZUNsaE4v?=
 =?utf-8?B?K3ZhaEVpZkFDdnAycUtlUnNLTFFpaDBFV1dWZEdVU0hDakVaV3Ficm9EK0Ru?=
 =?utf-8?B?cTU3aFpyQ1dmdkZKUCtvS1RrQWptYWxycGV0eHluaGpGb3gybVJiYWFPU09n?=
 =?utf-8?B?cGh5ZWpwQXkrcGM5WEtmVjUxUkZWbmF5TTY4SUkybTZFMkp1eGNkdUl1ZGVM?=
 =?utf-8?Q?vwZCj+G3Tn0JkMOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61A39B238E821941B9F7332665F5F7CC@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b371f85-68b5-40f9-18a0-08defa0f5f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 14:21:46.3417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8bggDP1/ervEUbepK5lv6DPjyzyMb7lC1pHSmg3yFJa5ws+Gr2sBklbDFIvpfo/BYgA9fIf+QP4H3drELB+U29qPyWXGJvcYf3zEYB+F5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5386

VGhhbmtzIGZvciB0aGUgcXVpY2sgZmVlZGJhY2ssIEFuZHJldyENCg0KT24gRnJpLCAyMDI2LTA4
LTE0IGF0IDE1OjU2ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gPiBUaGUgRkVDL0VORVQg
Y29udHJvbGxlciBjYW4gZmx1c2ggZnJhbWVzIHRoYXQgZ2V0IHN0dWNrIGF0IHRoZSBoZWFkIG9m
IHRoZQ0KPiA+IFJYIEZJRk8gYmVjYXVzZSB0aGVpciBkZXN0aW5hdGlvbiByaW5nIGhhcyBubyBl
bXB0eSBidWZmZXIgZGVzY3JpcHRvcg0KPiA+IChSeEJEW0VdIGNsZWFyIG9yIEVORVRfUkRBUm4g
bm90IHNldCkuIFdpdGhvdXQgZmx1c2hpbmcsIHN1Y2ggYSBmcmFtZSBibG9ja3MNCj4gPiB0aGUg
RklGTyBhbmQgc3RhbGxzIHJlY2VwdGlvbiBvbiBhbGwgcXVldWVzOyB3aXRoIGZsdXNoaW5nIGVu
YWJsZWQgdGhlDQo+ID4gb2ZmZW5kaW5nIGZyYW1lIGlzIGRpc2NhcmRlZCBpbnN0ZWFkLiBGbHVz
aGluZyBpcyBjb25maWd1cmVkIHBlciBSWCBxdWV1ZQ0KPiA+IHRocm91Z2ggdGhlIFJYX0ZMVVNI
biBiaXRzIG9mIHRoZSBRT1MgU2NoZW1lIHJlZ2lzdGVyIChGRUNfUU9TX1NDSEVNRSkuDQo+ID4g
DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBhIGRldmljZSB0cmVlIHByb3BlcnR5LCBmc2wscngtZmx1
c2gtcXVldWVzLCBsaXN0aW5nIHRoZSBSWA0KPiA+IHF1ZXVlcyBmb3Igd2hpY2ggZmx1c2hpbmcg
c2hvdWxkIGJlIGVuYWJsZWQsIGFuZCBwcm9ncmFtcyB0aGUgY29ycmVzcG9uZGluZw0KPiA+IFJY
X0ZMVVNIbiBiaXRzLg0KPiANCj4gRFQgZGVzY3JpYmVkIGhhcmR3YXJlLCBub3QgcG9saWN5IGZv
ciBob3cgaGFyZHdhcmUgaXMgY29uZmlndXJlZC4NCj4gDQo+IE1heWJlIHVzZSBhbiBldGh0b29s
IHByaXZhdGUgZmxhZ3M/DQoNCk1ha2VzIHNlbnNlIHRvIG1lLCBJJ2xsIHJld29yayENCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
