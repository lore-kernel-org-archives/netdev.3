Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577E4D0A1E;
	Tue, 15 Sep 2026 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472156; cv=fail; b=eBCrRWVK+0GqbtwaL3Dhwu/+c/V6jegqfhwhkwB7giowBafe3z0/ZBfZLfYy5haiqCwUqlSjrRETVY6mLG3F/uUXkZY37iMXDqjlnravYzWntGYNbChsD6e5M8waMSN7F2KuYSVYw6VtXflVpfL4xke1qMK+bkBlBTk6CPpXWBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472156; c=relaxed/simple;
	bh=vlf1Q0DGSZkH+qaR4aU5HgqpW/n3jjV4dP9+Tjr2Mls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pqj0q87jwydTrvk1r9LTrYF8BBBzK15esLmKBWEGL/uPP/R+FRGbzeLquWCmafNandMxlN3cm0ExfHgUwGsvwObgnHrA3fnk/QlVcJg34/1Uzl0+znT/rVMdvduk6GBEsRX4WdrT13A08nsXSOudNUV5LxPv0EsXYDfJPN/f9+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Dlzj5HWm; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Dlzj5HWm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTXCNCLZOOVx1Usg7S2RgfMuPiSKMFFIAOs2fMflKFafXo9KsTdrX33heqD2JEAbo+fZ5LIq6R6Uk9n7dxRUa9OOU/hwzy5g3hqquNHR9G6b6sTfF0DdwVu92nQ4UWtDzwJeCIQJfFXY3RpLcuHQXlKygdWdzBF2Hi7VTGYamYPZUyngParvYT+CUJ5+dSl1MYuTPIcQkDGTRuF4rLbJLH7pCbxS+woBKDlAJ5bphZjC+StgwWswqbw2d+ZkE4zidi83c+oC25NkA2kym1InQF2gj/O77VYNeubW5Zcu7jGEI33koE0kUIF9/ok7iNVkhpXs+z+C1vQdASLwcsLfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlf1Q0DGSZkH+qaR4aU5HgqpW/n3jjV4dP9+Tjr2Mls=;
 b=NrPdDI0qZJ++1nYT6V/9WBiC7fscHgGl+hjakE0XevLTbmKvfBpNRwFpbdu+m98xAWXERFTtG8FuNodpdCytiFeNGmPOEl48rAwj3UbJOLrPImYI5moIM7PQM1yPKlNDm8NNebk2m/XKW+IgB/WKxSQnawb0VsP2fZySJ4j7/WTfsdxkkDw3FN/bogfaNEMqrP+b2rlavfgG021vDCvVKlx1z+qdc0XIznTAzgYYvQoNC8s/T1NHlbiZhJkQ0GFDYPKEzAnSvP1W+U3BQwzjOIIr6MU1W2ksFErl0zefPJ3CFDRfA3y0r+oup58Hz4FZxPf+ok8TxRXz8/eKOquUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlf1Q0DGSZkH+qaR4aU5HgqpW/n3jjV4dP9+Tjr2Mls=;
 b=Dlzj5HWm73HQ9drCh9QntQYp+87flEHEPwaSGNJUK7V4uVg3rHsZmfFx84vzb2D68mXcmIgRFzf5MMJJa/PeihECueURdJ4YyGU8v0yfOvtPoX37rjAUidCg/8mSZlecAxfv/DUos0Qvi7q6m8g1MiH8vTN/dfdpe65Y6GX5U23djDOwt7ElO7JINb5tVhevDsYSz7fyc5VZlP/yVs+jfy19An+yAZ+AE/2ssPB+KSVskQfuyLz9a8J22QjB4KOjDeWQ2blkNzC3clvx7gqDE/SSjO1bVrZtd4BDCYYQOchK2faxKCpO4LIkW31CN8bGBFMJI+v7kHNiUXoD7mKTdg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AMBPR10MB9241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:35:45 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 11:35:45 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "hauke@hauke-m.de" <hauke@hauke-m.de>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next v3] net: dsa: mxl-gsw1xx: force internal PHYs
 into a known reset state
Thread-Topic: [PATCH net-next v3] net: dsa: mxl-gsw1xx: force internal PHYs
 into a known reset state
Thread-Index: AQHdRPNOgAcEZjIQR0KWWS9yufyrtbbPfZiAgAAFMQA=
Date: Tue, 15 Sep 2026 11:35:45 +0000
Message-ID: <f62cfca69a2516421d3a4b72be113b33afa11b79.camel@siemens.com>
References: <20260915091856.1375914-1-alexander.sverdlin@siemens.com>
	 <aqkpNVyoJdXpQz4n@makrotopia.org>
In-Reply-To: <aqkpNVyoJdXpQz4n@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AMBPR10MB9241:EE_
x-ms-office365-filtering-correlation-id: e10a1f97-6495-43af-e098-08df131d7b24
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|55112099003|18002099003|22082099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 UHjJ2GI/pim+1eTSruAPzmtZWdQyADxH9cZMf9I1ltxCg9xEw4YUTCCtErwOdr6pEynkRKwuNu3NKjzBp5xLPpslMIQ1c8LJGdh22bok05XtZ9A7tQ2j0MjDFp//Hfhi19sEPqKWfJY8nXVEkHrnKZkuV6KShQIz13EyD1FYrNwk84/+iOXYnFTkMwJjq4F1tVAT4A+p8VPR0AOBMK7d1AYANuF/ip9hBrRfsIgjYtLZAk61//1dNm4upbXpnWkikAbA31oRLmrYmAIW1bKJuRfac6su0uvdHaYcMHYtv9Z6KypzdwKsS16EBGfX8tHSVzK76YwOVZ7bIOEUq6nsXdZoru84ZP30uNNKJzboOdwxdRG+BQiRg7NIqeY4Mk349r6xcSmJG7EG+Y/BIniWCr8o5O8bFJ20rZd7ZkgZFdsekmQhnXu6PQdW1Zkggx9a5JprmIq+hDX5Icdq/uhC0uizeTRQuzwJ5v06y1G8Z1GSCtKHjhM6SC2GKUf66bzY3i4TGgG9EKa6FofqQd086yjnuiOKSmMAapCvyZN4Ui+kaYEAzmD0kcW3WhLHiV0+pGMakc9hIRMNfsJK9nlXsQ3pWxCRNtcLvkfGuA3u6xEbXAWHn7V8uhAjvCJWwS4eg70of2EWKSrU3OH7f0cToa/3XUM4biFJzVfLT7hYSEQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(55112099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXFZWmlPZXlQVDdXako4ZWhiQ2hMaWdMY1BBVVpiRFBydk5DRE9sOE5nVzQv?=
 =?utf-8?B?anhKSnBwWnJCbXZISjcxRGZ2Zi9qUjJrc01MZWZsQ09jaCtrQjdTWk82YWtk?=
 =?utf-8?B?Tm1EWXF5VnBUc1dFKzZZQmZTclQzSDBpc3FCODRQK2V3TEhEOHU2MnFXOE9w?=
 =?utf-8?B?dUxBQ3lwbTk4ZFZFQXBUZjRQT3d1dUlDUHI3VEhJUUR2Y21yMHoySDA5TnlX?=
 =?utf-8?B?ekRyS3FUTDZGcUcyNENsS1VhVGtEN3Q5S3V3b1FsR005b2lrV0RoV3lRSldy?=
 =?utf-8?B?RE1aSVByejRUTDFnSlNseFR0aVdueEk2c1N3dUY5NzNTMUdJTDdvYzd6eDNR?=
 =?utf-8?B?MmVTa0g1RDBjb2pja2w5UU5jcUlMaUpOUHFuWnlTdlRKaHpKVm8wKzA3MHMr?=
 =?utf-8?B?S0sybURpdHJURHhaWndvM0FCek50WS9RNkI4V2JCYllpK3gwNWFpbVlKNlVw?=
 =?utf-8?B?cC93MFNGRmxaTDh0UGtrYmpLcXo2YUl6OUt1cmhLYXBtdndYTlN6cWhlb0Nn?=
 =?utf-8?B?dnc3MmRVR0Fjb0FRd1lCWUJMS2FDNktMZVg5cllMVjI3OFRUSmxpR3Rxc3hy?=
 =?utf-8?B?K1pOb1pRTUpRVWgwSDdGdGRqakhnUGdoRUlvVzFxVk01bE54U1RRRHBLZG9Q?=
 =?utf-8?B?YlRJbXNiUlV6MWtVWURlTkV3YXB5LzBRVytWWTBsS2llNW9hRm9iSHJPYVA2?=
 =?utf-8?B?ZExIZ2pQVHkzNk9BU3ZJdnhSZ3BzN3RWUGpzYXk2bE1VUUljNUxtbGgrYjF0?=
 =?utf-8?B?V01Ddm5zOW5UZmp1YThSdm80T0ErZFN6VkdhL25HUzIySWluYXE0aDBQYlhL?=
 =?utf-8?B?QjJBRlE2NkRmUWdobG1uZFpWVEFZeGl4MGMxb1lIcUtpbTFFMlNESENWYmNR?=
 =?utf-8?B?eEliQ3hjTWkrMGpZUmpZS3FQWDhMRkVqS0JTRmsxOWNvUm1KRnQ5V0FxOVJv?=
 =?utf-8?B?SFB2OUtjSmdPY1FqZXF1enFKWThWR1dzUHRQaEJKSWJ3L3lTTGNWeERxSTJV?=
 =?utf-8?B?V2s1WWZPMjJ3NXZnWjg5ZUVWOXFONmlaNURkWEJYM2diVW9QVC80eE1NQmZ4?=
 =?utf-8?B?cUdpcjlpd3JXc21Id3Jwd2EwWjZIdUVlYzVaSTV2UXRqS0VNUDVUTjVKLzMx?=
 =?utf-8?B?NGVReXFrbkY0OEtFem1SQUxOS2tFNnp3WEtQL3ZWa05MZGx6Z0E0Q2pJSHpp?=
 =?utf-8?B?ZVAxVmVLOEtjM2xBc05HQmNSSGVnMDk2Vk83VjJYZDRlVllsV3ZLVW9pSWcy?=
 =?utf-8?B?ME5pckdDVEZjVnlQKzJHYTV1aXp5OG1vWENrbE15RU9rd0lkQkNFTTgreHRV?=
 =?utf-8?B?L0JWUzJaZ2MxVXhDRlhFcGRkSTFYMzI3S3dRcDBMQmFyQTdVbXVpS0dYZHRx?=
 =?utf-8?B?eXg4bklGcEVwTHRmTzJqcFdLUzdVWXlycGgxdVJ5R3hodUFidjJ3bGtrVXVJ?=
 =?utf-8?B?QUZ2WWxEU2NaQUoxWm1LN2pqLzgvOGlxZC9YakRDVVlmYnZaVmVhZDJQdlpE?=
 =?utf-8?B?djBJc2hGbzNjdHdsRGtaM01QWmtldUZ5TmtmR1FaODFSZW1DQ3k5S2ZZQ2lt?=
 =?utf-8?B?emFubnQ0UnV3THVBWXdsVmlpZHFJTlY0ZWV5alI0MGkyNk9XM3dwRDhnVkVs?=
 =?utf-8?B?aWErWS9KN0Y2MDFHUXR6RkRhMmg3Y3RvSW1TbmkxdDVrTUpWYU5EdElwWXFJ?=
 =?utf-8?B?YjhWQkhOOGkyTFozTFNjbDgwWmZIQkhSOEUydjFRbEtNRmlwdXlOck1nZjVB?=
 =?utf-8?B?OXZvTkU5cXdHUWJmSFRrY00vb2Q4a3FLRjUwTE5VSFRyb2dmSGR1U2VNcEt6?=
 =?utf-8?B?Y2pPbmtwTWduaFR6L3d0K0pNb0R5SXZnNnpXc3l1YW1aa09aamt4SitsS3Yw?=
 =?utf-8?B?RTNyU3JScDhrdENoRi9GS2RzaDQ2a0JNVlptVEtycFBOM2g2MjhxTXI5RFRD?=
 =?utf-8?B?ZkQvM0lRMU5HdGpjaEZYdHExWHoyZDRUL0VqWE9nZEpxVzlVQkdWV2puc2g4?=
 =?utf-8?B?aWwzY0RJazFCN3NDSEl2ZEExNkFabUlwSHBSSnJWNFBsOHF0LzZ5L2FPSzFK?=
 =?utf-8?B?VURLVHpURWJLVFJrQm9YSkRaVjYwUVdyb29BKzBrQ3BTRUhzWlpmL29XcGJR?=
 =?utf-8?B?L09BNk5rRDllWkM1QTBsTVp5MEpaQlZ5aWJYU1VHY3V2eGN2ZExtWjRkUWY2?=
 =?utf-8?B?RVFjZHhVUmJPV0hYYytaS2ZraFFSM2VRb01ycmE3d3RmT0Z2RjB2RWpLSmYr?=
 =?utf-8?B?WG53L0lsZEIwalhoUHUyU1pyUXZqbVVZU3FpcEVEdGhLbVU5eEttSEVmUGFN?=
 =?utf-8?B?NkF0Q3RYRkxzQkdsdTY3WHdITlJ0SloyVWcxVmwrOHhOZW9RbFJYM21yRFRP?=
 =?utf-8?Q?93uiuG/TKtaZXmHA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA3ECCCAD04653499E99B9F03BC00184@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e10a1f97-6495-43af-e098-08df131d7b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 11:35:45.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2QsXrEQEQOviKa9M8DCLLfFKxuMrWxlLxjWAIShFXBiYutD0XtDZYF2l5I25LKw+tLZjnWlkMXpyEJbKJ/LBWLKsDKbRS2qofqS9hxlx0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9241

VGhhbmtzIGZvciB0aGUgdGltZWx5IHJldmlldywgRGFuaWVsIQ0KDQpPbiBUdWUsIDIwMjYtMDkt
MTUgYXQgMTI6MTcgKzAxMDAsIERhbmllbCBHb2xsZSB3cm90ZToNCj4gPiBXaGVuIHRoZSBzd2l0
Y2ggaXMgYm9vdHN0cmFwcGVkIHdpdGggUFNfTk9XQUlUID0gMCwgdGhlIGludGVybmFsIFBIWXMN
Cj4gPiBkZWZhdWx0IHRvIGEgaGVsZC1pbi1yZXNldCBzdGF0ZS4gVGhlIGRyaXZlciBwcmV2aW91
c2x5IG9ubHkgd29ya2VkIHdpdGgNCj4gPiBQU19OT1dBSVQgPSAxIHdoZXJlIFBIWXMgYXJlIHJl
bGVhc2VkIGZyb20gcmVzZXQgYXV0b21hdGljYWxseS4NCj4gPiANCj4gPiBQcm9ncmFtIHRoZSBQ
SFkgcmVzZXQgbGluZXMgdmlhIHRoZSBSU1RfUkVRIHJlZ2lzdGVyIGJlZm9yZSB0aGUgTURJTyBi
dXMNCj4gPiBpcyByZWdpc3RlcmVkLCBzbyB0aGF0IFBIWSBJRHMgY2FuIGJlIHJlYWQgZHVyaW5n
IGJ1cyBzY2FuLiBSZWxlYXNlIG9ubHkNCj4gPiB0aGUgUEhZcyBvZiBwb3J0cyB0aGF0IGhhdmUg
YSBwaHktaGFuZGxlIGluIHRoZSBkZXZpY2UgdHJlZSBhbmQga2VlcCB0aGUNCj4gPiB1bnVzZWQg
b25lcyBoZWxkIGluIHJlc2V0LiBEcml2aW5nIGJvdGggZGlyZWN0aW9ucyBtYWtlcyB0aGUgcmVz
dWx0aW5nDQo+ID4gc3RhdGUgaWRlbnRpY2FsIHJlZ2FyZGxlc3Mgb2YgdGhlIFBTX05PV0FJVCBi
b290c3RyYXA6IHVudXNlZCBQSFlzIG5vDQo+ID4gbG9uZ2VyIHN0YXkgcG93ZXJlZCB3aGVuIFBT
X05PV0FJVCA9IDEgcmVsZWFzZWQgdGhlbSBhdXRvbWF0aWNhbGx5Lg0KPiA+IA0KPiA+IEEgc2lu
Z2xlIDMwMG1zIGRlbGF5IGFmdGVyIGRlYXNzZXJ0aW5nIHRoZSBuZWVkZWQgcmVzZXRzIGVuc3Vy
ZXMgdGhlIFBIWXMNCj4gPiBhcmUgcmVhZHkgZm9yIE1ESU8gY29tbXVuaWNhdGlvbiAocmVmZXIg
dG8gSW50ZWwgWFdBWSwgTWF4bGluZWFyIEdQWTExMQ0KPiA+IGRhdGFzaGVldHMgb3IgdGhlIExh
bnRpcSBjb3VudGVycGFydCBvZiB0aGUgZHJpdmVyKS4gVGhlIGRlbGF5IGlzIHNraXBwZWQNCj4g
PiB3aGVuIG5vIFBIWSBpcyByZWxlYXNlZCBmcm9tIHJlc2V0Lg0KPiA+IFsuLi5dDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9sYW50aXEvbXhsLWdzdzF4eC5jIGIvZHJpdmVycy9u
ZXQvZHNhL2xhbnRpcS9teGwtZ3N3MXh4LmMNCj4gPiBpbmRleCA2NmJmN2UzMzE5MDU3Li4wOGM2
MzNiMmNhZWJmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9sYW50aXEvbXhsLWdz
dzF4eC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZHNhL2xhbnRpcS9teGwtZ3N3MXh4LmMNCj4g
PiBbLi4uXQ0KPiA+IEBAIC01ODksNiArNTkwLDUyIEBAIHN0YXRpYyB2b2lkIGdzdzE1MF9waHls
aW5rX2dldF9jYXBzKHN0cnVjdCBkc2Ffc3dpdGNoICpkcywgaW50IHBvcnQsDQo+ID4gwqDCoAln
c3cxeHhfcGh5bGlua19nZXRfbHBpX2NhcHMoY29uZmlnKTsNCj4gPiDCoCB9DQo+ID4gwqAgDQo+
ID4gK3N0YXRpYyBpbnQgZ3N3MXh4X3NldHVwKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gPiAr
ew0KPiA+ICsJc3RydWN0IGdzdzF4eF9wcml2ICpwcml2ID0gY29udGFpbmVyX29mKGRzLT5wcml2
LCBzdHJ1Y3QgZ3N3MXh4X3ByaXYsIGdzd2lwKTsNCj4gPiArCXN0cnVjdCBnc3dpcF9wcml2ICpn
c3dpcF9wcml2ID0gZHMtPnByaXY7DQo+ID4gKwl1MzIgcGh5X21hc2sgPSAwLCBhY3RpdmVfbWFz
ayA9IDA7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKnBoeV9ucDsNCj4gPiArCXN0cnVjdCBk
c2FfcG9ydCAqZHA7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWRzYV9zd2l0Y2hfZm9y
X2VhY2hfdXNlcl9wb3J0KGRwLCBkcykgew0KPiANCj4gVGhpcyBsb29wIHJ1bnMgb25seSBvdmVy
ICp1c2VyIHBvcnRzKi4gSXQgc2tpcHMgRFNBX1BPUlRfVFlQRV9VTlVTRUQuDQo+IA0KPiA+ICsJ
CXN0cnVjdCBwaHlsaW5rX2NvbmZpZyBjZmcgPSB7fTsNCj4gPiArDQo+ID4gKwkJLyogSXMgdGhl
cmUgYW4gaW50ZXJuYWwgUEhZIG9uIHRoaXMgcG9ydD8gKi8NCj4gPiArCQlnc3dpcF9wcml2LT5o
d19pbmZvLT5waHlsaW5rX2dldF9jYXBzKGRzLCBkcC0+aW5kZXgsICZjZmcpOw0KPiA+ICsJCWlm
ICghdGVzdF9iaXQoUEhZX0lOVEVSRkFDRV9NT0RFX0lOVEVSTkFMLCBjZmcuc3VwcG9ydGVkX2lu
dGVyZmFjZXMpKQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArDQo+ID4gKwkJcGh5X21hc2sgfD0g
R1NXMVhYX1JTVF9SRVFfUEhZKGRwLT5pbmRleCk7DQo+ID4gKw0KPiA+ICsJCS8qIFdpbGwgdGhl
IFBIWSBiZSByZWFsbHkgdXNlZD8gKi8NCj4gPiArCQlwaHlfbnAgPSBvZl9wYXJzZV9waGFuZGxl
KGRwLT5kbiwgInBoeS1oYW5kbGUiLCAwKTsNCj4gPiArCQlpZiAoIXBoeV9ucCkNCj4gPiArCQkJ
Y29udGludWU7DQo+IA0KPiBIZW5jZSB0aGlzIGNoZWNrIGlzIHJlZHVuZGFudCBhbmQgZG9lc24n
dCBtYWtlIG11Y2ggc2Vuc2UuDQo+IA0KPiA+ICsNCj4gPiArCQlvZl9ub2RlX3B1dChwaHlfbnAp
Ow0KPiA+ICsJCWFjdGl2ZV9tYXNrIHw9IEdTVzFYWF9SU1RfUkVRX1BIWShkcC0+aW5kZXgpOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmICghcGh5X21hc2spDQo+ID4gKwkJcmV0dXJuIDA7DQo+
IA0KPiBTbyB0aGlzIG1lYW5zIGlmIG9ubHkgdGhlIE1JSSBpbnRlcmZhY2VzIGFyZSBpbiB1c2Ug
dGhlIFBIWXMgYXJlDQo+IG5vdCBiZWluZyBwdXQgaW50byByZXNldC4gV2h5Pw0KDQpBZ3JlZSBv
biBib3RoIHBvaW50cyEgV2lsbCBmaXggaW4gdjQuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGlu
DQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
