Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFD3A9D8D;
	Mon, 31 Aug 2026 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159527; cv=fail; b=Ou/uqWcU9rmjvzjQ3mM8N+39bo8/xEfDI+MSgbGKZ60Oex3aH6W5ZZrbmlNozIrlMDuP3wEytYS6sefWKXionyOCgfELTdGi7CHrn1nrYrZVA+//aYjo1Odm19DYf+CmnQi6DKdKsCEX5javY1vevKWrH7P4cwfC+3d41wSc7ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159527; c=relaxed/simple;
	bh=k9/Zch4xBR3wVTG1VDD7wG6ddfQ9z7Tivyrikafvymc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s3D0Z7s2n55sizLKJ0yLxu/XvQEDD9vv4JDtN9okpSqWgJom1FWnTuvfttLl47WaybJ2vW/+jKZHEYZELD/R+7w2xiAdOZ4ftyqV8XGCWVnZFdqtZ/zpsbHkyxLW23myxHCtjOANWhGkeRhq3Z+kJ/7+ws+XyN/RGahMYtkdnR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=q4izzL4o; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=r57IqH5n; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b="q4izzL4o";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="r57IqH5n"
X-UUID: 61b31a34a50911f18dc8c9802ae25ab1-20260831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k9/Zch4xBR3wVTG1VDD7wG6ddfQ9z7Tivyrikafvymc=;
	b=q4izzL4oHQHEmEA0BPw679HGuUnr+ho8bxo17cEwBs6DvsBcVRkWDIxLKmPk38JGd1+pvEo1bz7s59ahgiDa9hkCh+PGJwWdoYppDQHofYI6YdIjxXJVKCCHJBn5qNQCe/KPIu/5XPRCyzH7PWpOfhfLAZ8vN6ItFpoX2rIcdno=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f55f9e2a-81b1-4079-9186-3be68c2cc502,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:ad1dfbd4-16f9-43fd-8587-9be9868b2c75,B
	ulkID:nil,BulkQuantity:0,SF:81|82|83|102|110|111|136|836|865|888|898,TC:-5
	,Content:0|15|51|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:
	nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 61b31a34a50911f18dc8c9802ae25ab1-20260831
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <weiting.lee@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 182452429; Mon, 31 Aug 2026 14:58:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 31 Aug 2026 14:58:32 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 31 Aug 2026 14:58:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyQuLtKDo4JEHnMZPOiNs482K+82cbshr+Kh6h+O0KTwAq6DqDLmN+AvQ28XLqwAw6S/f+gs6u0teAL0wOiw9zrYqTKaAxKyF8KSIzqbSCZ6/0RoIveBAP/Y35E5Z4O+X/MA2vXIq6utOVGqiGIbdYecp3TrrWK9Gi+kvlWGGMtaHZTCLYJiRIisHYYcXkvmOHbp/2sv3pPUD1uSR83ZNzC/sM2B/ZEnOjlrI/Synn9R5eSsmavAgQFKyFFMt7139JoZljnzJUFVO4DdUhP4nGTY6SSimlO9YhXJ+p3qfxS7sVqIDVsQvKBKNENWn4ZS3eeSU7YEGrjScopfJCsX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9/Zch4xBR3wVTG1VDD7wG6ddfQ9z7Tivyrikafvymc=;
 b=quWtgrj7cxePLgi7vAXvJuvb2BE2/w8nQ14Ga//pCbgKlN1Y4I02TSqhJ7Ql8DEJgKlRbLezK6VpEe/pU0wlj2YdDVpPMDmdYIJhYebgTsc/ECxd4adXUnLU925rqcD2+gDU6gJ8nI05z6085xQTWp8Dxv4yc8BfipRR6r01ZqoYz3bHI4eFUGr6ufr70OU4hb2xKS/8DKacX6OcU4OvtFVjSCmz1Zr2SmY5KYtGfsm1vwK1BqXZjLETrR49JLgw78B+QpKDbpMae3v+GnFt7UeN5HAXZDPmJ+zmjNJuelv4xo3RPepo8uB+ZvOaNq+a/bjNFJ3iKB9zekfBja8Prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9/Zch4xBR3wVTG1VDD7wG6ddfQ9z7Tivyrikafvymc=;
 b=r57IqH5nug/ucq8F4oin6b7pmYBAmbJZ9vlA90oRr0AY+0rEArzm68kxJms1sIAWkpKpPKe3lCl+VkVl3DjRFpQTy6+Zu0qasq2TzYMfcM4VghgtYRr/T3GDJXgY8FxTYY8C5TkTI4QfHx7CY68g9Z8YjDCV/2k9kRK7zj7l0fA=
Received: from TY2PPF54E124228.apcprd03.prod.outlook.com (2603:1096:408::9d3)
 by KU2PPFDC87947C0.apcprd03.prod.outlook.com (2603:1096:d18::42a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:58:27 +0000
Received: from TY2PPF54E124228.apcprd03.prod.outlook.com
 ([fe80::de85:9a98:1e2c:6c6b]) by TY2PPF54E124228.apcprd03.prod.outlook.com
 ([fe80::de85:9a98:1e2c:6c6b%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:58:27 +0000
From: =?utf-8?B?V2VpVGluZyBMZWUgKOadjuWogemchik=?= <weiting.lee@airoha.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@mork.no" <bjorn@mork.no>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>, "frank-w@public-files.de"
	<frank-w@public-files.de>, =?utf-8?B?Sm9zZXBoIExpbiAo5p6X6JSa54WMKQ==?=
	<Joseph.Lin@airoha.com>, =?utf-8?B?V2Vuc2hpbiBDaHVuZyAo6Y2+5ZWP5pifKQ==?=
	<wenshin.chung@airoha.com>, =?utf-8?B?THVjaWVuIEpoZW5nICjphK3npaXpiJ4p?=
	<lucien.jheng@airoha.com>, =?utf-8?B?QWxiZXJ0LUFMIExlZSAo5p2O5a625a6PKQ==?=
	<albert-al.lee@airoha.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggdjIgbmV0LW5leHRdIG5ldDogcGh5OiBhaXJfZW44?=
 =?utf-8?B?ODExaDogc2VsZWN0IExFRCBHUElPIHBpbnMgYmFzZWQgb24gQU44ODExSEIg?=
 =?utf-8?Q?package_variant?=
Thread-Topic: [PATCH v2 net-next] net: phy: air_en8811h: select LED GPIO pins
 based on AN8811HB package variant
Thread-Index: AQHdNqtRxm+oSt9Aek+yJl0H57LSOLazbvaAgARMYCA=
Date: Mon, 31 Aug 2026 06:58:27 +0000
Message-ID: <TY2PPF54E12422885D2F854AEA8EE1E957284A92@TY2PPF54E124228.apcprd03.prod.outlook.com>
References: <8530a501-705b-45b2-b876-68855955bccd@lunn.ch>
 <20260828050537.2728253-1-weiting.lee@airoha.com>
 <8e7094bd-4880-436c-a86b-e13e07d331d3@lunn.ch>
In-Reply-To: <8e7094bd-4880-436c-a86b-e13e07d331d3@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF54E124228:EE_|KU2PPFDC87947C0:EE_
x-ms-office365-filtering-correlation-id: 71f6027f-3080-45b0-928b-08df072d41e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|3023799007|18002099003|22082099003|11063799006|5023799004|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: PHl6Th3HfbJp1L2YZugJNgI02Xn+TcN6woF+LOtidwLuCcVBq3FV/1m4O8TJgiH9j1dh09HAxgrwoEO5GfzaWgDAIMpEkuYlUpOeimG1Ir74WLVEhDa4MKSrJlfgO1bfmVQhZO+yH1sk3vOakqsjjQXjObPKUH2KdTvVI5L4uAug5qt71knusU/EsUxpIbejhF5YSAo41q77rHK/P3fNgCMvmgPTXfr4sYYOX7y0wFrKmDIumDJRgwwgrUS0GFR56+Umuyfffk66AZGdl33cCl3Kitf+wUT5bvNHotZNi1Wer9F2D5tmp56hfGoj6VJA/5a8421oID6QoTydr9cOIq9WJm3N7Xicrc1yylEDel2n+7VL0Cj1c/FcssN+hwPYAn3ZJx61E/mZtZ2IdQWffcTBM4Efq/SYBYnlRP6riTMT/EkxRc/17RlpVEPG8VV4RjaYbhTmu2MbxAdFNUaDFXXVsh1UaRFRReV7gC4uOxBl9Dt3cpfZ3EchekIiZU1/LWQxumwmkvxCZtcl8VIHc6DgAEgLFFP9NBBIgM6aIK1EJzmp1JC/dL5RzHA+h6QAsA2RdC4VsEi2UKMkvC9vPimj4BGC0Xz1Lxe8qKJ2PKqzZIA/sujoL40EYzRyda/BHX7S3LZb/lKh0AMoc6zfeI6en3X/hTPKqsK9amFMIovoJCaJag7xSV8f7aTJdV+JG8HirVyFhLz6s/P90g/rxE/R+Zi6ApW2FbJyASGPOvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF54E124228.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlNSWTduZVZiZ1ZrTW11UmZ2bW1ISkJhNGNPVlBZM0VtRnl6N0J4RGw3d2NS?=
 =?utf-8?B?djR3TXVBOWRpNWdPUFAxd2twMHJuNlF1K3pvMlZnSG9Yam1IcXFVWFBZU2xs?=
 =?utf-8?B?U3p3dXRrdVc5Q05xVjVGOTdFazRWNktBUGhTdGZiNXY2OEIwSlV3SktiQ2w3?=
 =?utf-8?B?dFF4QVFYcGlsMnNDbVBiN1ZtN25TT2k3a2VYSWcyRGNXdGd4ZEhORkZ4eUlF?=
 =?utf-8?B?Z2pyekxGNE9YVEVtajZQWDdtWkt3bkYycm9jMURYNmVwZjZGS1htUzNWZ1Qr?=
 =?utf-8?B?Uis4TTdsWXI4eUJqWjQvd08vNWdlV3V2U1BmVlVpcUlyNG9lSUhwSHNBMVJI?=
 =?utf-8?B?VWpGcU5tKzExcUNTaEZ2RHUrSW1mZmtYRmRmdzVmQjJwU05SRWI2Y2cwdEt3?=
 =?utf-8?B?ZlBNSWxtTG96MTROMkpWL200RzNzQ2w4eGRDYlZFNmRjTmhSS3BxTkJRL2VY?=
 =?utf-8?B?NGs3UC9OTUxTSlkvbUk3WlNYdE5XR0QyckNaZ0RXUkFqQlRvWHVBNU5zRnkz?=
 =?utf-8?B?SHFEeW5GbkpaT3JxZUYrZjdTOFI0bHgrNVd6RTFaQmNXUTVQMTNLOVVoc1M4?=
 =?utf-8?B?MmNxdTlmdTNJMFZYQndqZEpSR1c1WlhGNjl6NXVoVTRRQnBydFhldVVEZ0hi?=
 =?utf-8?B?N3hBNDF6bC9IVVJMUXBHMXdETXBDK1VzRHpXTCt5NzNaVXJnMy8rQS8wTDlR?=
 =?utf-8?B?T0lCN1lOb0JLVmUyTWR5cWVmZm1YTG8rN3JCOGphd3NmNlRhS1UvSHY1a0Jm?=
 =?utf-8?B?aWVabDR5YkZteWw4ZCs3OGtXaXdXYStxNS9aV3VaOGFwaHFYeFByekRBdGJv?=
 =?utf-8?B?U2JGVzgyUVZrYmNLZy9GOVg2TjR5Y0YwRXN4QmRqSDRQTWF0QTlPZFczMFhS?=
 =?utf-8?B?TkNNUVdEdEg4ZzB6cHJrR2ZwOVQzWm4rbTZYWkpqajdjODAxWmxwaWJVNXlG?=
 =?utf-8?B?NEFwdFBtQzhjREdpZzlLbXdKWEcwSWd1L3g2S044L3VtZjhFak8yVk9hWCtq?=
 =?utf-8?B?WVhwN0tyYkxmNnQ1SXlxLzhGVmYzVGhGaU55ckZjTzFxNm92SU80MElxRzZr?=
 =?utf-8?B?VlhaUHNlUmxib2xFQlp5RnJnVTBCVzV1YlJXbnJSM1NQTzBWTTU2VU81eEZa?=
 =?utf-8?B?WUY2Zm0wRHc5VEpadFdUS0tHUHRRcm9DVTNQTnk1VExTVUdNNGdRSUNubGxj?=
 =?utf-8?B?SDlaRmw4cDlYNDVKVTYxelpSVEdEbG1NWlRlRU5ycHFBWEJ1L1lYNTFEVW1N?=
 =?utf-8?B?eWVBdFpXbDFJWVlWT2J4OXdzWmVNN0MzWXJwY3hnRVF6R3h6VHVjSmdQREdv?=
 =?utf-8?B?WTBDdHE5azdVbXRhbVNmdjFFVEkyL29iT2RhR3l6elZrQ1d6MU9QUGVEa09v?=
 =?utf-8?B?NGYwaTBWUWdSSXVHZ2ZCMlRFclVJaGJlQnRJQ2tqaHl3UDlUSWd4T1h1N0gx?=
 =?utf-8?B?WVQvb0NINHFiY1p0Zjl2L3Jsc01xRzYxanpwaW1KRWk5d2VCUkpqcjRWcC9m?=
 =?utf-8?B?STBxTzZyUTcyMktpWEJoYnJ3a2RmT2lGYVJFdmo5VThwMldjVUQycmxucGZU?=
 =?utf-8?B?d0k1cHFxc01WNXBRZnBYemhCSWFZZm54akg1b3loVmloWmt5TDhQelk5R2o3?=
 =?utf-8?B?YW1VWVRLZkZJS2Q2UnA2WlpFR2pEUDFxMVo3a1RkUGYyKzNyZWdFVlY1Wjd2?=
 =?utf-8?B?aXBXK3hpUVVGRWVTQk5wTFcvcHI1ZUJqN1VWQXEraWdQNGUyb3JNcXZ3bXBQ?=
 =?utf-8?B?MjlNSWY2NUZFd1dmdjFEaUVYU1dHMEZUeEc4VFZ2WFFXUGxTaDJzRTNqZGkv?=
 =?utf-8?B?OWwxZWZ6QmlXcHpzR1RLOHdFQ0xubDJDcTZ6WVQvNzYxREVscHdOdHg3byta?=
 =?utf-8?B?Rm1tVzhBZjRJWUEvNk9hMktMTys0RDRoRnBuS1BVa2RCT2RVTTd1OVovU3A1?=
 =?utf-8?B?RHVyeW8rNGdSNmtTb0xMRUczRlRFSlFQT2dZRnhPYXA0anZONVZzZjdNOXhM?=
 =?utf-8?B?cWRsUWk1NjFCYWpBU1ZCa2pwQjdSNnpsb3NlT2kxdDFmQzA0RGFVWkNzUnpD?=
 =?utf-8?B?SXowdUI4aCsxRnB6QWpPc0J2YnVObDlCNnh0UENreHhDcFJHOXpwVHkxVDJK?=
 =?utf-8?B?MlA1YVNTa2k4bGVCWFVWVW90elpBWmsyamphTVlyMm8zQVJ6Y2J0WUdNOTJU?=
 =?utf-8?B?Rk9oSjZLb1pFRXR5Ym5KaDJ2TWRuWDFQNHBiUExiMTNOQjFuaFFaRDNqOCtu?=
 =?utf-8?B?bGlVUWI2eW1NbGFmTitXNGtjYytuN21zSkNORjAvZzBZZFYwSFhrTkNUTDlK?=
 =?utf-8?Q?xosOLGd0RcaU3Ayy0Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RTJdcHVqrR46pYy+NEIeYXSZkmAIZdKKIdhWOA+MzOgZw9IgUZ4+44Rp1tDk+XXOPqZChoP0QYzAdQe5VkpAeC5XgVF0oeVGo9Cn1q9nyHTJbi1Gj6HTZsnFjJEbxM07YwZEea7F/L8fKMjENiRrA5o4+24T8+CX8wIP33Y0lATHlvnNvI5h0GgFsSp3M5MhgNSpZGc0pwam3ShsnPaFVjLt468yY6ZSPsc+I4MT64rrEyIL2edyGdW7pkrJkKo1aBjmhLm6lfkmaa3a5ari3uBnpilIj+h3wW7I1JfV1dmkpaXjAS6Mba2xe5U/E81ABosFgpYr23WPfdllWWdmsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF54E124228.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f6027f-3080-45b0-928b-08df072d41e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 06:58:27.0136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hn6isQ8XbhBA5Me9t1eDRwio+eax/yl7UWOJ221JprHN0C5Nz08XnFN8V2UPD84de/VoLGnmGIdeejQVLSc2kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDC87947C0

KFJlc2VuZGluZyBpbiBwbGFpbiB0ZXh0LCBhcG9sb2dpZXMgZm9yIHRoZSBkdXBsaWNhdGUuKQoK
SGkgQW5kcmV3LAoKWWVzLCBJJ3ZlIHNlZW4gWml5b3UncyBwYXRjaCwgd2hpY2ggaXMgbm93IGF0
IHYzCihodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjA4MjkwMzM4NDQuMTk3NS0x
LXh1eml5b3VnbUBnbWFpbC5jb20vKS4KCk15IHBhdGNoIGlzIGEgc3VwZXJzZXQgb2YgWml5b3Un
czogaXQgYWxzbyByZXN0b3JlcyB0aGUgR1BJTyBvdXRwdXQKcGlucyBpbiBjb25maWdfaW5pdCwg
YnV0IGFkZGl0aW9uYWxseSBzZWxlY3RzIHRoZSBjb3JyZWN0IHNldCBvZiBHUElPCnBpbnMgYmFz
ZWQgb24gdGhlIEFOODgxMUhCIHBhY2thZ2UgdmFyaWFudCAoSEJDTiB1c2VzIEdQSU9zIDAsIDEs
IDE1OwpIQk4gdXNlcyBHUElPcyAzLCA0LCA1KS4KCkknbGwgd2FpdCBmb3IgWml5b3UncyB2MyB0
byBiZSBtZXJnZWQsIHRoZW4gcmViYXNlIGFuZCBzZW5kIHYzIG9mIHRoaXMKcGF0Y2ggb24gdG9w
IG9mIGl0LgoKVGhhbmtzLApXZWl0aW5nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwrlr4Tku7bogIU6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4K5bey5YKz
6YCBOiDmmJ/mnJ/kupQsIDIwMjYg5bm0IDgg5pyIIDI4IOaXpSAg5LiL5Y2IIDA5OjA3CuaUtuS7
tuiAhTogV2VpVGluZyBMZWUgKOadjuWogemchikgPHdlaXRpbmcubGVlQGFpcm9oYS5jb20+CuWJ
r+acrDogbmV0ZGV2QHZnZXIua2VybmVsLm9yZyA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IGhr
YWxsd2VpdDFAZ21haWwuY29tIDxoa2FsbHdlaXQxQGdtYWlsLmNvbT47IGxpbnV4QGFybWxpbnV4
Lm9yZy51ayA8bGludXhAYXJtbGludXgub3JnLnVrPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldCA8ZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldD47IGt1YmFAa2VybmVsLm9yZyA8a3ViYUBrZXJuZWwub3JnPjsgZWR1
bWF6ZXRAZ29vZ2xlLmNvbSA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IHBhYmVuaUByZWRoYXQuY29t
IDxwYWJlbmlAcmVkaGF0LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBiam9ybkBtb3JrLm5vIDxiam9ybkBtb3JrLm5vPjsg
ZXJpY3dvdWRzQGdtYWlsLmNvbSA8ZXJpY3dvdWRzQGdtYWlsLmNvbT47IGZyYW5rLXdAcHVibGlj
LWZpbGVzLmRlIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT47IEpvc2VwaCBMaW4gKOael+iUmueF
jCkgPEpvc2VwaC5MaW5AYWlyb2hhLmNvbT47IFdlbnNoaW4gQ2h1bmcgKOmNvuWVj+aYnykgPHdl
bnNoaW4uY2h1bmdAYWlyb2hhLmNvbT47IEx1Y2llbiBKaGVuZyAo6YSt56Wl6YieKSA8bHVjaWVu
LmpoZW5nQGFpcm9oYS5jb20+OyBBbGJlcnQtQUwgTGVlICjmnY7lrrblro8pIDxhbGJlcnQtYWwu
bGVlQGFpcm9oYS5jb20+CuS4u+aXqDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dF0gbmV0OiBwaHk6
IGFpcl9lbjg4MTFoOiBzZWxlY3QgTEVEIEdQSU8gcGlucyBiYXNlZCBvbiBBTjg4MTFIQiBwYWNr
YWdlIHZhcmlhbnQKCgpPbiBGcmksIEF1ZyAyOCwgMjAyNiBhdCAwMTowNTozNlBNICswODAwLCBX
ZWl0aW5nIExlZSB3cm90ZToKCj4gVGhlIEFOODgxMUhCIGNvbWVzIGluIHR3byBwYWNrYWdlIHZh
cmlhbnRzLCBBTjg4MTFIQkNOIGFuZCBBTjg4MTFIQk4sCgo+IHdoaWNoIHVzZSBkaWZmZXJlbnQg
R1BJTyBwaW5zIHRvIGRyaXZlIExFRCBvdXRwdXRzLiBBTjg4MTFIQkNOIHVzZXMKCj4gR1BJT3Mg
MCwgMSwgYW5kIDE1LCB3aGlsZSBBTjg4MTFIQk4gdXNlcyBHUElPcyAzLCA0LCBhbmQgNS4gVXNp
bmcgYQoKPiBmaXhlZCBHUElPIGFzc2lnbm1lbnQgY2F1c2VzIGluY29ycmVjdCBMRUQgYmVoYXZp
b3Igb24gb25lIG9mIHRoZQoKPiB2YXJpYW50cy4KCj4KCj4gUmVhZCB0aGUgcGFja2FnZSB2YXJp
YW50IGZyb20gdGhlIHJlYWQtb25seSBzaWxpY29uIGlkZW50aWZpY2F0aW9uIGJpdHMKCj4gaW4g
QU44ODExSEJfSFdUUkFQMiBhdCBwcm9iZSB0aW1lIGFuZCBzdG9yZSBpdCBpbiBwcml2LT5pc19h
bjg4MTFoYmNuLgoKPiBBZGQgYW44ODExaGJfbGVkX2dwaW9fc2V0dXAoKSB0byBjb25maWd1cmUg
dGhlIGNvcnJlY3QgR1BJTyBvdXRwdXQgcGlucwoKPiBhbmQgc2VsZWN0IGxpbmVzIGJhc2VkIG9u
IHRoZSBkZXRlY3RlZCB2YXJpYW50LCBhbmQgY2FsbCBpdCBmcm9tCgo+IGNvbmZpZ19pbml0LgoK
CgpIYXZlIHlvIHNlZW4gdGhlIHBhdGNoOgoKCgpaaXlvdSBYdSBbUEFUQ0ggbmV0IHYyXSBuZXQ6
IHBoeTogYWlyX2VuODgxMWg6IHJlc3RvcmUgQU44ODExSEIgTEVEIEdQSU8gYWZ0ZXIgTUNVCgoK
ClRoZXJlIGlzIGxpa2VseSB0byBiZSBhIG1lcmdlIGNvbmZsaWN0IHdpdGggaXQuIFdlIHByb2Jh
Ymx5IHNob3VsZCBnZXQKCnRoYXQgcGF0Y2ggbWVyZ2VkIGZpcnN0LgoKCgrCoMKgwqDCoCBBbmRy
ZXcKCg==
