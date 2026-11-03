Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.51.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793721296;
	b=M9IUV/LYAb849C9pggfVEjuZimC0wIWHVC5gWRoYZ/1u4p32tW1K4e/Fgkn+tL3zdAw3
	 W5Yeu6R7hJGWKdDDwh8K+uKia9jYNr1HB+/rh3rN33gjBiEVuN57jZjXlTQdKXmlEpS5o
	 RWbos4OMo4CJi0i91TlnPVtWvKzpMfI8nSjkNUMHbkPHHZXKuOrNzOmDGKFpqfPfLqBDa
	 jvsMhuyzMx8kAKg7DB9tmpDFcCqDaQxo57cQkmLbeiFpVv0wVnkAnK727H8I5HPkKqCeA
	 7NeJngMBZKHD3WujL/8liEsdlR5xVy5eebBmN2eqwo5ejBW0LBytjOgJOhqOMxNX6Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721296;
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
	bh=9D4hksLS+PZx03Hnje+xCR3p0I2WJ0We7+TrjuJtEbY=;
	b=vuOIIXZYSskFRtBMbZgKjsTrNbTyNnTjAsUWEXFdl6kjoHFeBlvhywi3LW9CguAKYecK
	 bfFZ1PxzAFCESo84G2yDdfERUK37PFtr3ocB4cZImwiXgkpdTO/W7pCzR9nkBOF1JIpX9
	 p6adeDaGHHRbxonvLFx2OfUbdW+knccXnfiK4bmMv5ArFpvypHfe4RDV5BqqKLNYor+aJ
	 FDC0YCPFItPgeI63cBmugWeJQI+frXxuF9ulvm5phEF6mFtCfD6A7EMmdPFy/p3oGIK5s
	 1/mYclREEg5fNRzXIoUCuH6914cAbjaZ7B10eNP1jyJHjyJk9nlT//X0E5Oony1KFmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pnnl.gov;
	spf=pass smtp.mailfrom=pnnl.gov;
	dkim=pass header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=cRztFPYT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.51.0
Received: from BL0PR0901CU002.outbound.protection.outlook.com (mail-eastusazon11010000.outbound.protection.outlook.com [52.101.51.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B2606D835
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 15:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44B2606D835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=cRztFPYT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHCPChtVkQwuLzB5HSRjB5M4mpnSsv65u+W4WjgU6GnJfROHhhxKNxaCfbPNylPquxcphzeRwNMSbZSB3icq8z6M/+IVMjJnpugxbtn5nHaGn5CDp7ks8YYw03PPaUq2I+cJW6KHtiE/XQ/DrxrMvLA1gdHKi89waLGf7SXT1FSO32A9kQVz3zwogYX8hk0QnSx/VkV7CMA+9Z8ddMjPIfQ/DxTJyNCtVO8nRtfgAmZn2Jlrtlp+H+HypdhU5yMpbK6nywiTgLMDc+ZV6jt13yhs1d9qkNzZMK9mAsoTlwHZfVKMg+9vVBk+9S0LlmK+DfRwVdfTDUingIG8TrVADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D4hksLS+PZx03Hnje+xCR3p0I2WJ0We7+TrjuJtEbY=;
 b=OHgpyVG/2Xb4UR+NdY7MY8IAIMfD6goaGB1pldTaumUGNNE+GprgXfaYBm1wvANI1iJjUVfwk1PcbnRMtkAYBFZo/AEKX0LCKHcKYa8XN2nJryZLRFQoJNJ2f5JwYAccRbZgZUSa3sbYC7OsJt3eObgGtEp6Mr3pr9e4LDLG9mFpphZQb7MHrw8hBZcntpqgaPrslXKd/7vHnCwUNhRLzQXpKPdzvuu/ekuKAp+kAn9cll5ebVrLxepoTubKcWZOw9L3vFjYx+kot5UZLGBoSXvbAZvsS9pKsFF4T8ROaUZlVnoTh1qN3GEJIxkdtWuk61rqvgJfbcTXs6+0O4mInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pnnl.gov; dmarc=pass action=none header.from=pnnl.gov;
 dkim=pass header.d=pnnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pnnl.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D4hksLS+PZx03Hnje+xCR3p0I2WJ0We7+TrjuJtEbY=;
 b=cRztFPYTVr/pOe14mfX9kT1z5ycIYKSUeSq6xGPzr3RNyzZrAonvXUiaoASPFyO/C66KVZ4wMPXGYbOuiis7su+GYQTuDo1MTrB+Ewo/rlfxOI37+swkIvSXHQp+bxHDAqcrR4JRUxcbULnQkwT3LfjKX4xzInClMAqbLqWq0Mg=
Received: from PH0PR09MB11456.namprd09.prod.outlook.com
 (2603:10b6:510:2c3::12) by MW4PR09MB9864.namprd09.prod.outlook.com
 (2603:10b6:303:1e4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:54:44 +0000
Received: from PH0PR09MB11456.namprd09.prod.outlook.com
 ([fe80::855f:d47c:28ba:4821]) by PH0PR09MB11456.namprd09.prod.outlook.com
 ([fe80::855f:d47c:28ba:4821%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:54:41 +0000
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
Thread-Index:
 AQHdYYdZ8RJuNPBMiUOi2J1usWg9T7cIXLWAgAFb44CAAJgcgIAFsNQAgAFl+wCACqaYgA==
Date: Tue, 3 Nov 2026 15:54:41 +0000
Message-ID: <B37414A6-E9FB-41AB-9056-D0E63AC9A100@pnnl.gov>
References:
 <PH0PR09MB114568347F3E0622F9102AF628A662@PH0PR09MB11456.namprd09.prod.outlook.com>
 <c9f7ba83-ab92-4b2a-915a-1513c90a49a4@lunn.ch>
 <B0D3346C-ACAD-4938-8B3A-501F9CD52C64@pnnl.gov>
 <8546582a-e5be-471f-87e5-5eb68433083f@lunn.ch>
 <8D2A251F-C6BB-49AE-84DB-459FD7532306@pnnl.gov>
 <364891b2-88ee-45d0-899a-cb2e919eae6c@lunn.ch>
In-Reply-To: <364891b2-88ee-45d0-899a-cb2e919eae6c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.114.26102720
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pnnl.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR09MB11456:EE_|MW4PR09MB9864:EE_
x-ms-office365-filtering-correlation-id: 5cd0f46c-20eb-4df2-2ad8-08df39c2c5f6
x-ms-exchange-atpmessageproperties: SA
x-ld-processed: d6faa5f9-0ae2-4033-8c01-30048a38deeb,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|10070799003|366016|19092799006|38070700021|4143699003|5023799004|56012099006|261028144727099003|261022105027099003|261102123227099003|261009223027099003|261021121427099003|261021135927099003|261022075727099003|261026121527099003|261026140227099003|10067099003|55112099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 70Qvne9Bgrnlc6SrkU2QEi1JCZXKJ8qnHQLmdtDsmDceW3kWX/i6F2V/reD0pJ0W3Uf2Y1+XoSPJyXClF2WYQzqwKmtFRGgo7dG3xi/q0p0vp+MtWQkEtbNrjS9KxqlT7LoYjUuvoZmr4SR1BNXvwjlDKDJiicqUYH770ipCrZZKJoP5XaPdmISOebrQjdW3MvmiUIPKPgpMywsgcfJHOB4NRlgH4BckST3D1u83dr1qHnoM6O3YU49P3aJyxy9e70/lzUT5RErxMhJ1SkiozcwaG0TD0PYsN34/O9KCQDY8Yt7g6BIu7B9LU276mCXaloszlj5Cw9ItDCdvw1wyXG1POO/xD3fIgGdD9xlf+UXYL6vYa05Fhg+HepA9WgoujmCFwnG5uzEzWKIK8EiHafB+Qx902O9Jpc9sk669YP4rSWXuAnXZYiPfEG99pFNMYvTxM0Y3ShzPNQEjamaDDraiatZEvoFf9ZvimUZP42O7yyT4FugeAhZwxXtWSgbCtE6iyndsf89+CSHIOJyLK2KWCNtlvQQygfzUoFAG+VwwUWIcd51z/l4YhmW/OdMsMgVNnh1MXCIrOYW74kh7nqOljr/JkorG+fYQjlRCcvTvHDUAqw3UtKJcSvaLkTFkkHOXG4irHRYPunX9o7LfTZ8Rk/2oYk0cIQqq7XVAig0oXt47jMstKrvlWCfwl08PjYvjtF5ZoimakqkRDIFRlbfKk1dYu7NT+xX0UVFcHtQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB11456.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(10070799003)(366016)(19092799006)(38070700021)(4143699003)(5023799004)(56012099006)(261028144727099003)(261022105027099003)(261102123227099003)(261009223027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmVXTHRHdmQ3QVc1MFhmOVo3QjBuZDliRnNiaHpJdTlHbThyK3B4ZjNDREZw?=
 =?utf-8?B?OU10aThEVjZHT3dZU2YvaTVyOGhmeVZ1dEl5amtMUnVvYlQvNmVZVHF1ckJq?=
 =?utf-8?B?SHRxUk9kZVdHYjhPNHF0S2lBSEFONGRyVzlFWW5xYm9Yb1JuTWkrV1NZS1dk?=
 =?utf-8?B?dWd4SkxiOFUrSWIrcW5DWFphU291SkdFay92TGlKbXNkelkzTHVrM0NHdmdw?=
 =?utf-8?B?RmYyRmhZNk00RW9VbzIxUThQSHZlclJ3YWZ6ZW1ZOEZNbk9QbWZHNWw4WkdS?=
 =?utf-8?B?TkkzOGw5ZE5tUlc2cmtrdkNQMCttbjdCT0t1QXVIemZ3ZERicmFWQURzZGRs?=
 =?utf-8?B?dXFxUW00Y1kyL3k0emFGRDNLdHJXZndLaXBYMWxxYzd5NC9kbEoyRFdlSDdj?=
 =?utf-8?B?TElZaXpJcWtoQ2VqcU9rbkFOUzNNT1hVMDJKZzVsVUVVYmo3TXFWZmMvQ2tC?=
 =?utf-8?B?VTlqSWtQaXlJR09FeHZoK0phTTBJWndLRUNaZE5jbDNYV1EwOWt4aWR3eWRq?=
 =?utf-8?B?dXhyRGpVZXRrK1ZFQUgzMEk4L05DSFdWRGdVNkllZWNKOUJSaUFEaXAxM1A4?=
 =?utf-8?B?dnFKSXVEWUJGOGpqdXB2cUl0RSt2bFhKU0l3YnA3eDA1bS9PM1R5MlZzeGNo?=
 =?utf-8?B?TzM4WGdJMU5aL0pVU3dvbXNDZ1ZYb3F5Z2Fva2YwNlNVdFlJUHpJQzNxT3pS?=
 =?utf-8?B?WWt4L0ZqcFVyazl5aDN1ejZINmpMTG5LZERKcm5jZ2cwSEMzUzZHRDdGUFpo?=
 =?utf-8?B?NjR3cklra2xQcGpxV1VjR214MEhZY284UEN5aGg0VFFWYlV1ZWpmbGhrdzBq?=
 =?utf-8?B?Kzc3SGhESVQvMGl1OHVUKzhWamFWanRuaVFFQzE4cWdvd25RUEhHYTNzWm1G?=
 =?utf-8?B?RTNsRjNDM2lGTWZyL09YakZvdnhRYklTK0ZFOFlESVpkVGpmQWJJOHFIcS9N?=
 =?utf-8?B?eGVtcUJCSXljdG1nQnVaREVNdU9QYUxRcFJUdGpTMDhsZmJWSmJyL2EwZkVu?=
 =?utf-8?B?MHJzS0dZb2RQNkp0QTNKUnkvMXdVSDFGNENOWWhpc0UxcFB3TGtocERkRFFI?=
 =?utf-8?B?eG9uMlFBTmRyOUwvSlBxVXo1dVRnMnVxOGR1TVdqNDlHdUFwa0swTnVpY1JC?=
 =?utf-8?B?T1BTdWJqNlJRR1gySUpuK3VITHhuYndhMG41RitSSnpVdmxmRStGVml3V3dz?=
 =?utf-8?B?azBiL1JwTnB2RnZ4SDdXM054ZzdSZmp2bFJSR1U3VmlwNU5hQ0diUE5XMnpW?=
 =?utf-8?B?VG1zcStjT0pPekIyTFhNVk83UEF6c0ZxU2xKSXBsYUtrMW55cHhJMFBsZlZu?=
 =?utf-8?B?K2hqUGZnRUhYZDFFVlp3RzZhcjJCZ0NhUkNhMzRlREJYMm5RRm83RDBnOUpO?=
 =?utf-8?B?dkRON3JGd0dzdUxmV0EvN1hsMmdZRzA0QUdwY3BIZHhUTE9iZy92TCswWTFX?=
 =?utf-8?B?RWRsanVRZEZBMHJjVms1K3RYSjc1bnBMdGtsc2ZWdDhsdzluL3JSajlHcnZx?=
 =?utf-8?B?d1lXTVFQcnlqYms5VGljMVp3VXZGd2dON0ZYNk05NUJuTEovbkkvMVRITmhp?=
 =?utf-8?B?b2tsYThsSUVxV3M2Z3lSV3dDSHJ1QTM1OVV3LzRLQ2RFOERiaEZYaWtlc2JL?=
 =?utf-8?B?S2pFa1ZaTjVvWlppc0tLeXhTWXlYVVRVQ2pvK1BSRGs1QVhkNTdvc3ZzSzlq?=
 =?utf-8?B?YkhQRU8rcHU2RXdPdFRqK2lwOWlTNGRsOHpRUitvZG5WckVMYzF1elFHZHdS?=
 =?utf-8?B?K2FSN1BBTm1ROTZkOHpEQWtyVERrMFlKZmkyVkhESkNBVitMd2tHajR2aWN4?=
 =?utf-8?B?aUczQ0hmRHdWMTV6Zm52Z2hESjNlZDhmajY0aUhUMXQ3Tko5R2xpdE1zOENL?=
 =?utf-8?B?dVA5SnpLVTd5VjFONkJaajArS3dYd1RaQzZMQnhCTHNaMXQvTWlNZkVORFUw?=
 =?utf-8?B?Nkw5MlFJUzJpVnhvKzY1NUMreFQzVStJY3BicmFyblJuSUcwemNxZWc2NDRv?=
 =?utf-8?B?MmFMdGQwYVlKNFVHcHIrYWNkMGFwYkp6WlBPMUpPTk5NTVVyQzJqZUJ3Z3Fh?=
 =?utf-8?B?UWhWUzRES2RBelJwVkNSeG1QTjU4MnN6cjU2SGRRTGttMTU1ZUMwRGZkQ0NF?=
 =?utf-8?B?cTRNWkp4bDZxdWdONjRlS2tCYTdtSldvNWk0R05aSG9yS0Zpd2pnY24rS2dV?=
 =?utf-8?B?VERxSDFsTWJVQ0VFN1h6S2pmcWVWeFZEeW1QZWE2bUd6dEZpSjlFOHdKSUhY?=
 =?utf-8?B?TFRIaVQ3dG1kUXdydzJlSlN4eHhVYWI5SUJYbzRUdVhBanJoZGdGRkEvbWYw?=
 =?utf-8?B?alR1TTcvUG9rQXNPSEhrRy9tRmFyTUxBZERuam96SWVXdmN3dXR5TFRLTi9R?=
 =?utf-8?Q?DjP+TcxyfkL6fyl40Jk53BjGst7LX2N57TPS/axgqn6Dv?=
x-ms-exchange-antispam-messagedata-1: 4oYMpAGXWthH0g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF5775AD2E19434BBD6E8A2DD49C54F5@namprd09.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd0f46c-20eb-4df2-2ad8-08df39c2c5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 15:54:41.6519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6faa5f9-0ae2-4033-8c01-30048a38deeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR09MB9864

T24gVHVlcywgT2N0IDI3LCAyMDI2IGF0IDE0OjE1OjUwICswMTAwLCBBbmRyZXcgTHVubiB3cm90
ZToNCj4gRnJvbSBhbiBhcmNoaXRlY3R1cmUgcGVyc3BlY3RpdmUsIGknbSB3b25kZXJpbmcgaWYg
aXQgc2hvdWxkIGJlIGEgdGhpbg0KPiBzdWJsYXllciBpbiBkcml2ZXJzL25ldC9tYWNzZWMuYy4g
VGhhdCB0aGVuIGZvcmNlcyB5b3UgdG8gdXNlIGl0IGluDQo+IHRoZSBjb3JyZWN0IHdheSwgaXQg
ZG9lcyBhY3R1YWxseSBnaXZlIHlvdSBwcml2YWN5Lg0KPg0KPiBEb2VzIGxpbnV4IHN1cHBvcnQg
dGhpcz8gQW5kIHNpbmNlIHRoaXMgaXMgODAyLjFBRSwgaSBhc3N1bWUgaXQgaXMgYW4NCj4gZXh0
ZW5zaW9uIHRvIE1BQ1NFQz8gU28gd291bGQgaXQgYmUgaW1wbGVtZW50ZWQgaW4NCj4gZHJpdmVy
cy9uZXQvbWFjc2VjLmMgPw0KDQpFdmVuIHRob3VnaCBpdCB3YXMgc3RhbmRhcmRpemVkIHVuZGVy
IDgwMi4xQUUsIE1BQyBQcml2YWN5IGlzIG5vdA0KcmVhbGx5IGFuIGV4dGVuc2lvbiB0byBNQUNz
ZWMuIEluc3RlYWQsIGl0J3MgYSBuZXcgTGF5ZXIgMiBwcm90b2NvbA0KdGhhdCdzIGRlc2lnbmVk
IHRvIGNvbXBsZW1lbnQgTUFDc2VjLiBGb3IgZXhhbXBsZSwgTUFDIFByaXZhY3kgaGFzIGENCmRl
ZGljYXRlZCBldGhlcnR5cGUgYW5kIGluZGVwZW5kZW50IGRhdGEgdW5pdCBlbmNvZGluZ3MuIFdo
ZW4NCmNvbmZpZ3VyZWQgd2l0aCBNQUNzZWMsIGEgTUFDIFByaXZhY3kgbGluayBtdXN0IGtub3cg
dGhlIGRlc3RpbmF0aW9uDQpNQUMgYWRkcmVzcyBvZiBpdHMgTUFDc2VjIGxpbmssIGJ1dCBubyBv
dGhlciBzZXR0aW5ncyBhcmUgc2hhcmVkDQpiZXR3ZWVuIHRoZSB0d28gbGlua3MgKHNlZSA4MDIu
MUFFZGstMjAyNSA1LjEwIGl0ZW1zIG4tcCkuDQoNCk9uZSBvZiBvdXIga2V5IGJ1c2luZXNzIG9i
amVjdGl2ZXMgaXMgdG8gc3VwcG9ydCB1c2luZyBhbiBleGlzdGluZw0KRXRoZXJuZXQgRGF0YSBF
bmNyeXB0b3IgKEVERSkgKHN1Y2ggYXMgdGhvc2UgbWFkZSBieSBHZW5lcmFsIER5bmFtaWNzDQph
bmQgVmlhc2F0IChodHRwczovL3d3dy52aWFzYXQuY29tL3Byb2R1Y3RzL2N5YmVyc2VjdXJpdHkv
a2ctMTQyLykpDQp3aXRoIGEgTGludXggaG9zdCB3aGlsZSBhbHNvIGJlbmVmaXR0aW5nIGZyb20g
TUFDIFByaXZhY3kuIElmIE1BQw0KUHJpdmFjeSBpcyBpbnRlZ3JhdGVkIGludG8gZHJpdmVycy9u
ZXQvbWFjc2VjLmMsIHRoZW4gd2Ugd291bGQgYmUNCmZvcmNlZCB0byBjcmVhdGUgYSBNQUNzZWMg
ZGV2aWNlIG9uIHRoZSBob3N0IGluc3RlYWQgb2YgdXNpbmcgdGhlIEVERSwNCndoaWNoIG1heSBy
ZWR1Y2UgdGhyb3VnaHB1dC4gSWYgaW1wbGVtZW50ZWQgYXMgYSBzZXBhcmF0ZSBkcml2ZXIsIGFu
eQ0KRURFIGNvdWxkIGJlIHVzZWQgd2l0aG91dCBhbnkgbW9kaWZpY2F0aW9ucy4gQXMgSSBtZW50
aW9uZWQgYWJvdmUsDQp0aGlzIHNldHVwIGlzIHNwZWNpZmljYWxseSBlbmRvcnNlZCBieSB0aGUg
c3RhbmRhcmQuDQoNClRoZSBNQUMgUHJpdmFjeSBwcm90b2NvbCBpcyBub3QgdHJpdmlhbCwgYW5k
IG1vcmUgdGhhbiBhICJ0aGluDQpzdWJsYXllciIgd291bGQgYmUgcmVxdWlyZWQgdG8gYWRkIHN1
cHBvcnQgdG8gZHJpdmVycy9uZXQvbWFjc2VjLmMuDQpJdHMgYWRkaXRpb24gd291bGQgYWRkIHNp
Z25pZmljYW50IGNvbXBsZXhpdHkgdG8gdGhlIGV4aXN0aW5nIE1BQ3NlYw0KZHJpdmVyIGFuZCBt
YXkgaW50cm9kdWNlIGJ1Z3MgaW4gdGhlIE1BQ3NlYyBpbXBsZW1lbnRhdGlvbiBhbmQNCmNvbXBs
aWNhdGUgaXRzIG1haW50ZW5hbmNlLiBJIGxhY2sgYWNjZXNzIHRvIGEgbGFyZ2Ugc2VsZWN0aW9u
IG9mIE5JQw0Kb2ZmbG9hZCBlbmdpbmVzIHRvIHRlc3QgYSBtb2RpZmllZCBNQUNzZWMgZHJpdmVy
IGZvciBidWdzIGFuZA0KcGVyZm9ybWFuY2UgcmVncmVzc2lvbnMuDQoNCn4gQ2FtZXJvbg0KDQo=
