Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.51.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055286;
	b=Ilgh7WDxvhAsyCuVyr09KKqDqPIqWvHB4ydDGsSpGNvOHScE9Oa5HlJXRT6l7XejAn6v
	 TK1Ngbgc5S9oPcoIX6zYPsFNuukLzOF0sVfzgaNBPxaFhx0sx2i8LAcztucPfRBBkBdH7
	 Z7t2UIaUL7+cL4urfQIySqZ4dQIbONfyGPUGXCDRIp7UccCskqkWIlGDFpLYq41LnhRjU
	 TSH0nZyxDMxRMz28f3EjL8bMd45eVaV/WOZhox8VvvnmDwbRLlKbZ3vgWMgTvAp5Zgnp7
	 LPk4ho4tz/Idi/MfEGCKec6TChudD0N83dajyAM+xjl+ANYj69zVGah7hJ5mklBhdEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055286;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wLd64Sz3OygtjU1OjNqgcLhWVqJOdxy+nYHhwL8hxdU=;
	b=QNKdVRgHS/rJEqzSVa/F3yhQNxgbnoOmetN88kpjaKGkml35F8BE0L6+l6tIRif2pMrl
	 yGNoWS7Pc6DdYShBrtYhV8Yvlk2ugpUeeH54RkX8/r5MC78lH+icw5zOjsgL1jm6oEAUd
	 nT5WXTiiASJDwBv3TjB0Yc7/UwOOebuS8CBe721mZeqIHmZQ6AL+39o+9F3VsmPzjr+QI
	 voi00OlAdj0T/0r3gOoITQIJ/VFFrtMlgNZpK6+f/3+pAjNnBtjTmjAKm8z4S6GBIqjgX
	 pAqyLkSvgAp8qQVMda8pmKCvWxHpG/DP7ciFZTJPgcUQIj/sphaDVe0NK/9O9Q2ypgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pnnl.gov;
	spf=pass smtp.mailfrom=pnnl.gov;
	dkim=pass header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=Guw9CKhI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.51.11
Received: from BL0PR0901CU002.outbound.protection.outlook.com (mail-eastusazon11010011.outbound.protection.outlook.com [52.101.51.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2C606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=Guw9CKhI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX+qvmTUu+N/tscfcqolv6pO7VdxixF3rKE9RmNE3y3K/jcHeHM7C1O5vqnzDPOVQiMyfcQWsBXknYqVRpLQOGPp6wopv2tVjKQn2EeoGgZ940ApzAP8AaNdmF7YtK6Ql1pvU3hN3Abuz5EzmJ2gr8ZFtVVetM31/i12J58LvAnVEHJ2exdML+3jUaeNkdf6A1lp0+B/18km7QIuw7qY1Bkm7pkfPjIBvhhioBpeq4/zfC/KEdX6YCcE1Q/eioZ0+zxCSHHSO8oBXW3prHTeJyBUYS6hTGq8/iPUnnHe/GDg2/lOGMtyy3itdYW4SFkyDP1PqviIndZzOTQ9OGBkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLd64Sz3OygtjU1OjNqgcLhWVqJOdxy+nYHhwL8hxdU=;
 b=sYpY5MBjm0lL0iCXjKMxuwN9v0mbS5VE1aJadXZMwmgBPkOPysb6bGUYH/EC4Ol6OzVYBkwoVm/jjnNQkC+uVi9o/bd3XmbsxUrVxQZ5yMgUYfCUL5XgAEpOFKnZbeyPb0oC+fh0luHRLyugt4uzHBwiPM6yYxLtj/k/fw1zyZUWZAOCBSQyHw76ZmZYdOOhpMzD+kGwP+R2sCBMolu+N1H7Jl1oR9AIDotJXdmuCNtngONBlBGOt7cTz97tTp6dIsj3TY+dVLIgRDozmDLdyFVoF6ZAzMMN7F8iRQR0is4YG5JGN++USveEJ7kP9hpKsO0tTFBrQSVY2bGAdwUc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pnnl.gov; dmarc=pass action=none header.from=pnnl.gov;
 dkim=pass header.d=pnnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pnnl.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLd64Sz3OygtjU1OjNqgcLhWVqJOdxy+nYHhwL8hxdU=;
 b=Guw9CKhIdkH4ORVgFsFcRKA++BNxeEOchYfARBLeK+eph5PgPuUnj+PZTsOagyvnZ4/moTIut/CoD6/WnykO53+/p6pggjSOuiJTqX5TsYrigaKA1UiwmnROgejUQ3wHpyu4f+B3sXbS38B+jTADZcJ2qA7ZY/TC45tft1hwfk0=
Received: from PH0PR09MB11456.namprd09.prod.outlook.com
 (2603:10b6:510:2c3::12) by MN2PR09MB4956.namprd09.prod.outlook.com
 (2603:10b6:208:21c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:54:35 +0000
Received: from PH0PR09MB11456.namprd09.prod.outlook.com
 ([fe80::855f:d47c:28ba:4821]) by PH0PR09MB11456.namprd09.prod.outlook.com
 ([fe80::855f:d47c:28ba:4821%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:54:34 +0000
From: "Smith, Cameron T" <cameron.smith@pnnl.gov>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"boqun@kernel.org" <boqun@kernel.org>, "gary@garyguo.net" <gary@garyguo.net>,
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "lossin@kernel.org"
	<lossin@kernel.org>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
	"aliceryhl@google.com" <aliceryhl@google.com>, "tmgross@umich.edu"
	<tmgross@umich.edu>, "dakr@kernel.org" <dakr@kernel.org>,
	"daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
	"tamird@kernel.org" <tamird@kernel.org>, "acourbot@nvidia.com"
	<acourbot@nvidia.com>, "work@onurozkan.dev" <work@onurozkan.dev>, Sabrina
 Dubroca <sd@queasysnail.net>, "Griswold, Richard L"
	<richard.griswold@pnnl.gov>, "Phillips, Aaron R" <Aaron.Phillips@pnnl.gov>
Subject: Re: MAC Privacy Protection Protocol Driver Announcement
Thread-Topic: MAC Privacy Protection Protocol Driver Announcement
Thread-Index: AQHdYYdZ8RJuNPBMiUOi2J1usWg9T7cIXLWAgAFb44CAAJgcgIAFsNQA
Date: Mon, 26 Oct 2026 22:54:34 +0000
Message-ID: <8D2A251F-C6BB-49AE-84DB-459FD7532306@pnnl.gov>
References:
 <PH0PR09MB114568347F3E0622F9102AF628A662@PH0PR09MB11456.namprd09.prod.outlook.com>
 <c9f7ba83-ab92-4b2a-915a-1513c90a49a4@lunn.ch>
 <B0D3346C-ACAD-4938-8B3A-501F9CD52C64@pnnl.gov>
 <8546582a-e5be-471f-87e5-5eb68433083f@lunn.ch>
In-Reply-To: <8546582a-e5be-471f-87e5-5eb68433083f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.114.26102345
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pnnl.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR09MB11456:EE_|MN2PR09MB4956:EE_
x-ms-office365-filtering-correlation-id: 75b92430-9641-4805-0505-08df33b41ad8
x-ms-exchange-atpmessageproperties: SA
x-ld-processed: d6faa5f9-0ae2-4033-8c01-30048a38deeb,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|19092799006|23010399003|38070700021|261026140227099003|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|10067099003|22082099003|55112099003|18002099003|261026121527099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 VT16bpcsvyX8zXM216bFxRP1UzRcONI+ePAjj8vDoifWrSWeYJth0E1xuiD0hFfpMTyMHCGO1KwFZ5DWvbAwjFGkKQcH6d3Qxa0EQGjUl8bmtvOdsJrKy99r7elFqaN/bFL2CuUxcTXzFEXFB4WbSvmYg562H86WCSOvOfnQQnyn606dhVQAofpxsjAYwDroIHYXhylGs8zldRQrhr+mZhGlINgyVRsg7PgCikADcj69BDI6yqPu6CJa/JzhM8tyR/hSTjYCO7vXFf2YLOxXb3m7WAiQ9psoKivDPhJEQHwCsRWuNSKZxx3ZNPrXeLAsfIv95VMBvIUcYagLPCX6tDTkwFPY38uzGoLlYF+KCFG3ENRoUvxUwQy5RuH12NOe7igGnJarYP20+fN59PgX2N6u17IxQ38/f7QBQJa9E76x4rh10xhGKoH5MvwoHFhr12uP7gb6o6J6IuCLKH7xl7y98O9muMyctvkcM0nDC3ttYPqrBDM/T+Jk74Tyq0SgUbNRULkRvDMKsAjRBv170cnuZ33fOVXSDNblqsbWcfpQLNKyoQMd1C1YM2Ua5RRvbXRin2gqIfBB+M90w9gG6GY0nVeIyt7WPSK94YZqZauagpvpKr3vY2uwz2+YU/GfZglblkcFJlnOipcbtOgICLOEj/7I3R9EuAC+BNCBwHMoSDe3wIvuVGx7j7mi3iqwJY2jD6sF6FayEpnsjtPORkIOjNgbZ3pmzLjO3/zZOGY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB11456.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(19092799006)(23010399003)(38070700021)(261026140227099003)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(55112099003)(18002099003)(261026121527099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGVXQnhqWG5jbWt1SlQraWNXRUNhMG1tVDZUL1hKMVlnV3M4SzdPR3NWdUF4?=
 =?utf-8?B?UVU4RUZ3NzRaZXhBT0JRS0VwVmRNM2JhM21wUDNDTjdqRTRGVCtyNTVZMjZK?=
 =?utf-8?B?Q0FpbTl5aUZUQTNZU1Y0MXo4SUh5SCs4SkxDbG5WZmt6NWY3UEh1cUR3V3B3?=
 =?utf-8?B?cmhvTjEvUE5pbG5mRzVncFI0OXA4c05ZY1FVaGUwSDlRNXRtOUdnQ3BpTFBn?=
 =?utf-8?B?S2c1cEliN3V6Q0JsTitGNk9kaVNEQTRhK01tUy9teTdaNlNLTlh2RVVUNVhX?=
 =?utf-8?B?R01uUEl6eURZdEpVdERyYy94ZDRCU2owWlgwS1Fob2JOMzRaQ3RDdmp2V3M5?=
 =?utf-8?B?ODl2WURhK3g1MVd0MjQ5MXU4STcrV3oxWWdXeDNKN2ZkRm9vSTJLQnd2ZFVo?=
 =?utf-8?B?cWU1dGxIYjZ5K3ZYNzFEOGdDRnMyTHFSWjFTTk9ZaGprSDUwTU40dHBRN0Q3?=
 =?utf-8?B?TWExbW5SbE1aU2lITmpXM2kzRVZDdWlDOE1ucVRib3BNcndEc0F0TTNQZjNV?=
 =?utf-8?B?UWZ4UFZQSGFsU3IzaTlndTZ0UlprL2xtM3hJK1lKOEYybHRVcEk4MVFNb3Ax?=
 =?utf-8?B?OTF5Z0RzWklvL3FuQnVQY3RISjVlTVF5dnBjL2xWeUVFMGd6NFVNZFBSeVNZ?=
 =?utf-8?B?MXpKcy9pb3RzRjRsblVZYjFyL3N1U29DRVlJNnd3cjFaa0hPN1MxY0lkdGxS?=
 =?utf-8?B?ejdLQjkwT1plNU4xRUpFK0xTTXd5NFZNYzlwM1FGY1dFS2EwZHRrd2tRZU9C?=
 =?utf-8?B?SThhUHZ2ZVlabGpSNnQ4NWpDWmZxV0ZCQVRoemFpZUNmN05hQWhWdFNFelBn?=
 =?utf-8?B?TmJ2dld1ZEljWEtEK1ZXSDVHaFR3Yk1xMW11a2M1bmp0YW80am5lNzZITHdL?=
 =?utf-8?B?Y2lVbi8yU2VaaHpIeGdRK1F6N3NwSjJUY1ljNUJhbkhEbEJVNWVxYlg5eGor?=
 =?utf-8?B?bVpVcmJicFFGK3N1Vi9XcDViTko1dWRUTlZlK2cyS2RPN1JRSzF3YjJKQ1No?=
 =?utf-8?B?Q2dLZG9pSUFmSlhQRy9nMXgweG0xQjJ2VkFVL2hNMDZEeHFjVms0YUw2M00v?=
 =?utf-8?B?MTJHZ3Q3WURkT3g0eFFQOTY0bmpsSGJkTTlKT2F2MUdjT3JnNnNpQlIrR25r?=
 =?utf-8?B?SzJmeldjWGxvMzNTTjZ5WXVpWGhWRmRtMnRMN1BUNDkrVHM3Qms2QXo4cElp?=
 =?utf-8?B?b2gzWHJuOVlqaXAwaysvWHQ5aytNRWU4NWFwdUJXWHM3RnpSc29oY2lLd3pj?=
 =?utf-8?B?dGNLSE16UnR1RTdhOGJSL0JoVVM3YTJOcGJvOVdKOFNENUZaYXQ0dUhIVXcx?=
 =?utf-8?B?c0RVWVhROElOVXo4NzhTODhwWGVadytDd3lIWWJQNlNHN1llSE43TURzTU9Z?=
 =?utf-8?B?cGF4MEd1Q0FobjZXcVZ1UTJ3aHp4WGhITTQ4RERJeCtmaUFXWGhrU21sWEFE?=
 =?utf-8?B?b0JZQy8xdlhiL1puOTQ2aUVNRmJsUHNlZ2lUNS8rcFRkRkJzcUZPU3htTDkz?=
 =?utf-8?B?WHZrSGlqbWlhSGRNektNc3MycWFlUTl5Wm1FOTdCRlVuanBXVi82aDNId0NB?=
 =?utf-8?B?R3BHVUZaejFmMi9XOU5SeThBYVQvL3JsSzBLV29QcGpJTDhXR0M1a0NzeEpF?=
 =?utf-8?B?NDYrenB1WkgzNjZzTVMyb0o1SHJmcEhMdUYvbzZXN2JydVprZmFNV3Nib3lL?=
 =?utf-8?B?RVhTbmlFc1orbDlyVUJFeEswUjNkbXRaVGhQZXFIME1XNDNHcjRGbjJUYU9s?=
 =?utf-8?B?Kyt1eHNQTlRCMXFaVSs2SEtxWnNteU1BanhLc2l0RmpkOWNNRVBMVmxHVVo2?=
 =?utf-8?B?SkROUVNKVm5mekxKSjMzcklXc3FkaTJVTkwxMGNScTZmeXpIU1BWRkZHa2Ur?=
 =?utf-8?B?Skl5M0pBV0hrZUlkZllGS1lqdmJFbE0vRS90SkNFQUdFcFNGQzhqYnIraFhH?=
 =?utf-8?B?eHFmOHlHZHdBcGtabXgvVnAyV3ZTKzkxV0FIN2tkL0Q5SDh4QjVEUWJlMlk3?=
 =?utf-8?B?ZkdVVW0zazNPTzhFRUhpSFhBZEl0ODd4WE1FZWdHWXpLMVUxb3ZaRXFPNlpZ?=
 =?utf-8?B?MndWS1d2TG9sVFk4NitKdFNPM1N6dC90YTU3cVlRdHV3QmpaV3VUK3k4QmZ1?=
 =?utf-8?B?WnhRQzlJamlKdUcwT2s1akxiU2pOVjFzS0pqMndEUGVNNCttSG5qTVdyZmt3?=
 =?utf-8?B?NE5DYzZZZ3o0RXNsUnlNQ21OdVF5TFFmNWR3STh0V3hYQ0oxVGFVWHVHcWg2?=
 =?utf-8?B?TkNhN3kwd0pXakxSUEdUWkZ4UEdnSGtXYnFGUGtWQzJNTk5hNVRVaDFrUmhE?=
 =?utf-8?B?eGFVZFRPQ2VacDZCRUpnemlqMjI5Zi9sUm9oOTA0ZnlpY3F0OUk0b3d6alRS?=
 =?utf-8?Q?ZWn5WS5RAsnvDj7bB6oaBtz9ux7HEkyzuxpFgDd35IVMS?=
x-ms-exchange-antispam-messagedata-1: cMA8Ujwg/X49gA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CFAF8C4569A22458770FA3A068D0210@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: pnnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB11456.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b92430-9641-4805-0505-08df33b41ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 22:54:34.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6faa5f9-0ae2-4033-8c01-30048a38deeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR09MB4956

T24gRnJpLCBPY3QgMjMsIDIwMjYgYXQgMDM6MDA6MjNBTSArMDIwMCBBbmRyZXcgTHVubiB3cm90
ZToNCj4gU28gaWYgeW91IHVzZSBpdCB3aXRob3V0IE1BQ1NFQywgeW91IHByZWFwcGVuZCBhIG5l
dyBoZWFkZXIsIGFuZCBzZW5kDQo+IGl0IG91dC4gSXNuJ3QgdGhlIGlubmVyIGhlYWRlciB0aGFu
IGluIHBsYWluIHRleHQsIG1ha2luZyBpdCBzb21ld2hhdA0KPiBwb2ludGxlc3M/DQoNClllcy4g
SW4gcHJhY3RpY2UgaWYgTUFDIFByaXZhY3kgZGF0YSBpcyBub3QgZW5jcnlwdGVkLCB0aGUgY2hh
bmdlcyANCml0J3MgbWFkZSB0byB0cmFmZmljIGNhbiBiZSB0cml2aWFsbHkgb2JzZXJ2ZWQgYW5k
IHJldmVyc2VkLiBIb3dldmVyLA0KdGhlIHN0YW5kYXJkIGRvZXNuJ3QgcmVxdWlyZSBlbmNyeXB0
aW9uIG9yIG1hbmRhdGUgaG93IGVuY3J5cHRpb24NCnNob3VsZCB0YWtlIHBsYWNlLiBUaGlzIGZs
ZXhpYmlsaXR5IGFsbG93cyB0aGUgdXNlIGNhc2Ugd2hlcmUgbWFjDQpwcml2YWN5IGVuY3J5cHRp
b24gdGFrZXMgcGxhY2Ugb24gYW5vdGhlciBkZXZpY2UsIHN1Y2ggYXMgYW4gDQpFdGhlcm5ldCBE
YXRhIEVuY3J5cHRvci4gKFNlZSA4MDIuMUFFZGstMjAyMyBTZWN0aW9uIDIxLjgpDQoNCj4gRm9y
IHRoZSB0aW1pbmcgcGFydCwgaG93IGRvZXMgdGhpcyBpbnRlcmFjdCB3aXRoIFRTTiwgc2tfYnVm
Zi0+dHN0YW1wDQo+IFRBUFJJTyBhbmQgRVRGIFFkaXNjPyBDbGVhcmx5IHlvdSB3YW50IHRvIHJl
dXNlIGFzIG11Y2ggb2YgdGhhdCBhcw0KPiBwb3NzaWJsZS4NCg0KSSBkZWZpbml0ZWx5IHdhbnQg
dG8gcmV1c2UgYXMgbXVjaCBhcyBwb3NzaWJsZS4gTUFDIFByaXZhY3kgY2FuIHVzZQ0KVkxBTiB0
YWdzIHRvIGluZGljYXRlIHByaW9yaXR5IChTZWUgODAyLjFBRWRrLTIwMjMgRmlndXJlIDE3LTIp
LCBidXQNCkkgd2lsbCBuZWVkIHRvIGxvb2sgbW9yZSBjbG9zZWx5IGF0IHRoaXMgdG9waWMuDQoN
Cj4gQnV0IHdlIG5lZWQgYSBwYXRoIGZvciB3aGVuIE1BQyBwcml2YWN5IGlzIGluIGhhcmR3YXJl
LiBIb3dldmVyLCBpcw0KPiB0aGF0IGFjdHVhbGx5IHBvc3NpYmxlPw0KDQpUaGF0J3Mgbm90IG15
IGFyZWEgb2YgZXhwZXJ0aXNlLCBzbyBJJ20gb3BlbiB0byBzdWdnZXN0aW9ucy4gRm9yIHdoYXQN
Cml0J3Mgd29ydGgsIEkndmUgYmVlbiBpbiBjb250YWN0IHdpdGggbXVsdGlwbGUgaGFyZHdhcmUg
dmVuZG9ycyB3aG8gDQpoYXZlIHN0YXRlZCB0aGV5IHdvdWxkIGxpa2UgdG8gc2VlIGEgc29mdHdh
cmUgaW1wbGVtZW50YXRpb24gb2YgTUFDIA0KUHJpdmFjeSBpbiBMaW51eCBwcmlvciB0byBzdGFy
dGluZyBkZXZlbG9wbWVudCBvZiB0aGVpciBvd24NCmltcGxlbWVudGF0aW9ucy4NCg0KPiBXaGF0
IGRvZXMgeW91IHVzZXIgY29uZmlndXJhdGlvbiBBUEkgbG9vayBsaWtlPyBDYW4geW91IGdpdmUg
dXMNCj4gZXhhbXBsZXMgb2Ygd2hhdCB5b3UgdGhpbmsgaXByb3V0ZTIgd291bGQgbG9vayBsaWtl
LCBib3RoIHdpdGggaXQNCj4gc3RhY2tlZCBvbiBtYWNzZWMsIGFuZCBkaXJlY3RseSBvbiB0b3Ag
b2YgRXRoZXJuZXQuIEFuZCB3aGF0IHRjDQo+IGNvbW1hbmRzIGFyZSByZXF1aXJlZC4NCg0KQWRk
aW5nIGEgTUFDIFByaXZhY3kgbGluayB0byBhbiBleGlzdGluZyBFdGhlcm5ldCBsaW5rIG5hbWVk
IGV0aDANCndpdGhvdXQgbWFjc2VjIG1pZ2h0IGxvb2sgbGlrZSB0aGlzOg0KDQppcCBsaW5rIGFk
ZCBsaW5rIGV0aDAgbmFtZSBtYWNwcml2MCB0eXBlIG1hY3ByaXYNCg0KQWRkaW5nIGEgTUFDIFBy
aXZhY3kgbGluayB0byBhbiBleGlzdGluZyBtYWNzZWMgbGluayBuYW1lZCBtYWNzZWMwDQptaWdo
dCBsb29rIGxpa2UgdGhpczoNCg0KaXAgbGluayBhZGQgbGluayBtYWNzZWMwIG5hbWUgbWFjcHJp
djAgdHlwZSBtYWNwcml2DQoNCldlJ2QgYWxzbyBsaWtlbHkgYWRkIGEgbmV3IG1hY3ByaXYgc3Vi
Y29tbWFuZCB0byBsaWtlIHRoZSBleGlzdGluZw0Kb25lIGZvciBtYWNzZWMgd2hpY2ggY291bGQg
YmUgdXNlZCBmb3IgY29uZmlndXJhdGlvbi4gSXQgd291bGQgaGF2ZSBhDQpzZXQgc3ViIGNvbW1h
bmQgZm9yIE1BQyBQcml2YWN5LXNwZWNpZmljIHNldHRpbmdzIGFuZCBhIHNob3cgY29tbWFuZCAN
CnRvIHByaW50IE1BQyBQcml2YWN5IHNwZWNpZmljIHNldHRpbmdzLiBGb3IgZXhhbXBsZToNCg0K
aXAgbWFjcHJpdiBzZXQgbWFjcHJpdjAgdXAgMCBwdCBwcmUgcmRlIG9uIHBhZCAzMiBhcCAwDQpp
cCBtYWNwcml2IHNob3cNCg0KSSBkb24ndCB5ZXQga25vdyB3aGljaCB0YyBjb21tYW5kcyB3b3Vs
ZCBiZSByZXF1aXJlZC4NCg0KfiBDYW1lcm9uDQoNCg==
