Received: from ps82.spcmail.jp (ps82.spcmail.jp [35.74.107.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C0381EB4;
	Wed, 16 Sep 2026 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=35.74.107.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525750; cv=fail; b=cs2HFCesDm4ORqsSEEQ6N5EyF23GPmd1sNqCXoKf08/0gf4+6C34GRnJiQTA+v5sVnX6Ai22la/gMnfNMetSlCKUkyiAEoHyqneHLARwpaBLvKw2PK+uNnm1Y4oXYj6xMli740JLBXZNI4YuhY7YUicNNI3PK4B8xu+YMz8e850=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525750; c=relaxed/simple;
	bh=8xpCFKL6agTrx5A9cXfN5oK6Ov+BmlJh6VoqGs584xg=;
	h=From:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:To:Cc; b=TUvX+sU5GpoBIv4BikVjsBJ4Wv3GkdhMWAjy/ahFLC+K7DLfZK8LmK8oj8Q/kt1MziAG0dsWwNYCUWS4OH33cEdCtn0wHEmdx8UOFhE0BJCntsbJ1CtG3AVCxPlnkc0uXgEcq2n3rMqVGb9oSb3wY8mBVHT/WAXjKhhGTBbYiWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; dkim=pass (1024-bit key) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b=oDGv1Un8; arc=fail smtp.client-ip=35.74.107.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="oDGv1Un8"
Received: from ip-10-10-28-85.ap-northeast-1.compute.internal (localhost [127.0.0.1])
        by ncs81.cs.local (8.18.1/8.17.2) with SMTP id 68G2StCN1773086;
        Wed, 16 Sep 2026 11:28:55 +0900
Received: from ip-10-10-30-82.ap-northeast-1.compute.internal (localhost [127.0.0.1])
	by nmg82.cs.local (Postfix) with SMTP id 4hl2rR3PL6zMpsjF;
	Wed, 16 Sep 2026 11:28:55 +0900 (JST)
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011016.outbound.protection.outlook.com [40.107.74.16])
	by npr83.cs.local (Postfix) with ESMTPS id 4hl2r80Z9Fz3kMcZ;
	Wed, 16 Sep 2026 11:28:40 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE3sDsESAroZdnJpnBLJN67x7/yUC2F7EMlzRtynGo6UUx54FmuhVB7mg1q9LY7ESRqMTwlqDr08ONS3WQJm/WHgGJsom548WNVN75MzvLm5z0EhawO024zzZUzB3q7MsvSWJSqzLTJmDPPYogIRGBR00sdZsAODBw4Y2HUHp/lKwmuOUmhhV46l5va1TjE1vV7OdX+cd+kkjJHqcaCtjmRXsK6kQsZiWm8t5iAi5mqGfwlJD8lxeNNy2wxGDkj2YgNHL0WKLQ0GZbDfFbBFkQIZ+NHNh+6L9QkdFCWhYK/K6LMNLPSLfq0T+vFc5RSseJaT9oTnZxffhbxTCNusWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFtRpw66byt9o2+ni0uAQdTyvbYVEF9L2F5WhtqoPJA=;
 b=HaqsOSRW2kk7ybN60F10qAF6j5DzFdEQveUhP9Yifp1QMLvggPre5PJIO6YqAEum0EJzBirO2vlpXmi9u0Rfxc+7FP1si4brWgE1XEadHW/1aeivopxDLahWEB/eKJh0RcRo3L1Pyc1hYLfgemVm34+G31P3hr5FrtWCAVLqmzGp3+R3KKqXVTjvqxqfHWR4U93bvu7sex5z+cOB9bxsJkw36d0jIct1JR4AAfLOSQFYsZacYILq1Dragqfay/4pFNCrhQvf/MG+1m4DPNM/VbgE1Irw10oJ8ezS43po9NGI4rpvAtkfCIGthLzawmgCxa1ZtQJ08IgKE9pFXWvNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFtRpw66byt9o2+ni0uAQdTyvbYVEF9L2F5WhtqoPJA=;
 b=oDGv1Un84lOpyo7gMUfzfgIqoemakIBF8fI6OIeaaHCiWk7/CE7y+JJcHeUg8YMVkopWxAr5ERUgH0ES3OkRBRCZxcNOlcH+kDzYHEOdfIUJ04CpDr0FYpQMQxPNtwpeuJkUwl96vS2TuwSysSqchrDnAKvY+CxQpZByuhg13aE=
Received: from TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ca::13)
 by TYYP286MB1908.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 02:28:38 +0000
Received: from TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1a2a:2bdc:a0d5:99d2]) by TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1a2a:2bdc:a0d5:99d2%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 02:28:38 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH net-next] net: netsec: fix device_node reference leak on
 phy_np
Thread-Topic: [PATCH net-next] net: netsec: fix device_node reference leak on
 phy_np
Thread-Index: AQHdQ0rnaeFU+Oh4RUi9ApGJ9s5DJLbQfi8w
Date: Wed, 16 Sep 2026 02:28:37 +0000
Message-ID:
 <TYYP286MB0924762C90163A2A847D72CEE3B92@TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM>
References: <20260913064102.37452-1-yigejiang86@gmail.com>
In-Reply-To: <20260913064102.37452-1-yigejiang86@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYP286MB0924:EE_|TYYP286MB1908:EE_
x-ms-office365-filtering-correlation-id: 11d13252-b750-4a1e-9ca0-08df139a370d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|1580799027|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 cDj1xwpdXn7JGKIWJiRww33d9aM4z/lcqWjEJRES/Qq45qMiLlQ3Tm1C6xPwKCi2F68tMqZkEPWWJv4AXEl+ujLWFX624xqBKokkUoW++GAZX+68DrwZX1pci0X0XAbOMjW7I87Zbhu5kJsDNlKb7Anvg6KrQ267T1tP6S4g4CYLtoIEKkoEJdu3NtHYEI23Y6/Zb1k6gekDKUz6gHMYDMYEC6kRp6ORvwRx05LVFD3OTakx2h6t5bl2LjyX4csoCRaZteOcZHoE68oCNTj4PLIPc74eCwY4QazcLV7XSO3YgnMNps0D2nfUFK8tvHy9lbLSc7UkyPQ8YHjQuLkspeSNqP3Ddjkp+9hJ8db4nZBsZlpGaIc3uZzAhgE0BbfdlfdbGoUT+KI0K+Wl7gRS/i60OYVeVBiqXDmtsVi4K0zpbk2mnSakuKO6ijFfgjW+dG4NeWSivzTa5kUlAqEZSwEdeWI1e6pq492zipa8MO/NKDciN2AszZrukrwZ5JvwljGTuQkJ9muXsY4h8jl3UJHY6Oe6HN95PcojoWmpuiP9SOYaok0xqygmXHkzVTxg/AAxdddTQ5lBfgNBNvXEyWHKIn5T7dif+h37KTP9nXS95tQX6EglNxnmAUGPQqdcORaAPdY1D48/Vum/BTuR4MLGtXwHgs6wczRMvDa/Mib5Js7R9cyuZRfaWtDfgiaK011PcEVVluxns8uwLAHaP6OJdvkPrYqd7EASsbk1WDgvvDmVuWgK2CLOfc1iQ5Lt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(1580799027)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dU1TSHk5ZHRadTdNQXEzTThMQXVpNEFaTnRkcXRlY0NSQmhDY2F3ZGZu?=
 =?iso-2022-jp?B?a2RxOFpoUWJuZlpHdFFjYmdFeUluT2lkSGR1THJMSGs4NkZ0S3BHeXJx?=
 =?iso-2022-jp?B?ZmNDdlV4b29UZGtlemtJSjVHTUtsdDZVY2oyMGhpSnFwa1J2cU9BOWNo?=
 =?iso-2022-jp?B?QkpuajBGa1NFL2tFUndEREJJWld2WXNZMUJGOFpDeGZCMGVGM2c1Uysz?=
 =?iso-2022-jp?B?ZkRwU01Pa3haRUtUM0tMTlQyZktQVVE2ZytlbzgxUForQ1ZFbHZXQTBr?=
 =?iso-2022-jp?B?eGFZU09kV0VDWWhianpnU2hJRGIvRlV5SUYzMzJyNVh5blNhSEhVMzU3?=
 =?iso-2022-jp?B?bkpMTkFwZ1FBbytkRHlPaGhvbkgwR25tSXBmNFFzK1YyTDlDZXFWTWxn?=
 =?iso-2022-jp?B?ZDdPYVJ5SDU2cnNqWVZZdXhWMnZCbCtiYUJHWm9qc0VMYnoxbHBvY1ov?=
 =?iso-2022-jp?B?RzRVNjZMV25sWEtPa29hS3JvRkJsQ28vV3BkVXV0ZGRkSEQySGdESEQ4?=
 =?iso-2022-jp?B?ZnB6QnFETEd1cWdjTHNHc09sRUx5emE0REdqVFltV1FYQ2dGTTZNVjZj?=
 =?iso-2022-jp?B?NXVzcFpXOU8wTDR2dUhMTExJN1lUUGxrcGhLRG91aVI4NHZZeHJtT2dt?=
 =?iso-2022-jp?B?WG5xcEp1SGY0VkxTQnlMWWovaHhIVzNYRkxYbThwNlVzS2J5Q0NMMnBj?=
 =?iso-2022-jp?B?b1B3ZXZBMW5xUk4rRHp6VEsrcVc0cm00RjF3Zno4K0FKVmtNeHBzSzJt?=
 =?iso-2022-jp?B?SWRXakRsMm5uLzdHTEIycW1YY2F6M3dmeWtPUDVaVldmOUhpZHUwWm5v?=
 =?iso-2022-jp?B?eUpoQzZVWUxxNUYzQlhJNFdTVXRNZWxva1RTblR0S1BrcEEzVWpicWlR?=
 =?iso-2022-jp?B?VXF1S25aSkVFVy8zQ0g2c0E5NTlpTU50NUptVjBSd1N2dFhKeTFXbWlS?=
 =?iso-2022-jp?B?Ynk2cUczbkNDRlFDVEUxamttZVd4bm8zZUluSkh0aUNwS3F1bXRnbW94?=
 =?iso-2022-jp?B?VnBzQjhoNVJ4LzYzZTRpSG5tUDNhMkhIWjBOS3lyeUNieHZPcWE1cGV5?=
 =?iso-2022-jp?B?bmdhT2w1TUdMSU1CdHlIanVJVXRXVXpRNXNtcytKclBVU0NjTzJRV0Fh?=
 =?iso-2022-jp?B?a1F1U01vYVZGSlNXRGUxYzV1cjJjSHRudmZtVjc3R2NFOGVxQ3RsYUQ5?=
 =?iso-2022-jp?B?dUh4VjNnQjJKMm5uQjQwWU5JTHVraGdmSzJ0TXBBSmFCRGFSTlVyVWJE?=
 =?iso-2022-jp?B?Zmk2ZTgrWjdhNE1aMHl6WU81LysxbnIvdmVLdWM1WHdwSXBVMkQ0bU93?=
 =?iso-2022-jp?B?UG1FUndLU2JnSkVPeUxNRjNmV2lCMngzTkxyTE9FeFpVZTh4eEhUVnFE?=
 =?iso-2022-jp?B?Rit4WkpURk5PajhNNkVQR1AwcmdrcWt1NStzbGt5blg5eXJ3aEVSMnRa?=
 =?iso-2022-jp?B?L2VHaStqTEJ3dS9FMFRIV3N3QkdQc2Z6NnFaS0JYMk1xQytyOGNiaW1W?=
 =?iso-2022-jp?B?Q3FmcmhCM0xlMnhGbndlUExYbkhyc3MyT1JEbjlZKzN6V05BQWJzK1hh?=
 =?iso-2022-jp?B?d0ltTStjM2c3c3ord1JNemQzZ2l0UC9weVhiNW5xdkxtcXczUURyU0FY?=
 =?iso-2022-jp?B?MS8yRkZyaWFjMjd0TENzOURFMmxDbUhWRkQ2K25WUndrOGZLbUw1UGdk?=
 =?iso-2022-jp?B?bU42dHcxTTdwOW83TWNNcnZEbmF2T1ZpSnBFYUlXaDlLNHgzMHVERlpy?=
 =?iso-2022-jp?B?eGFlTTBOTU1aNlAwT044QkhGQkdLaWRnRGVNZFdNUlJwNjRha053ZlZm?=
 =?iso-2022-jp?B?YTkzNEhlaG5EMENwNjFtN0J1dHhLNHFGbVF4RGg3eDlyRHJCdTBFQ0U3?=
 =?iso-2022-jp?B?UHZzVGFQUXFWZVRnLzJiNlZORTBhaVlub21vUDVnaUJOV09SOGRLdWhQ?=
 =?iso-2022-jp?B?NUtHYnNCVXRUWTVKbHJjY3c5WmRrNVlHYmZxWCtqZXRZK0VTVjIxY0di?=
 =?iso-2022-jp?B?K3kxNjYrVkF4cHo0UGZHbEpvSm5NbUpiWm40cTBObExyeHIvTVZHdDdM?=
 =?iso-2022-jp?B?bm5BVkpVNHZ1VTY3WXZTdjVXRGFZZStNcTZFZUZPMkJQRmlZMVN5aEhU?=
 =?iso-2022-jp?B?cFVzMGtmN3F0MHY2QVh5dktKOEJUOEJLUTBXajRadTE2a01DektMcTVs?=
 =?iso-2022-jp?B?cHhwK0l4RDd2YmZaeTEvRG1VWWJpTDA1NUNydkJMbWNNOU92ZnM5bTRl?=
 =?iso-2022-jp?B?M3l2Y3FYRWNCdGNiUXdqTUNsMmNUS1NjVXlhNkhJQmx3bFd4ZmhCaWdy?=
 =?iso-2022-jp?B?am90TkxXVkozTjFyTjhHc3NpdG92bUpFZVNTK0YwN2dhWDdGU0dVSC95?=
 =?iso-2022-jp?B?VW1TcHdTU0o0ZnM3OWFueXRiVVhIbE9pRHY5R0RPZCthcUVxSXcxUThR?=
 =?iso-2022-jp?B?Vmg4R3JuaGtiYUNDR0dWcUlycnh6WjA1VHlJeWZQZFlSUUYwNVlsd3ZO?=
 =?iso-2022-jp?B?UWsvd1BpaEE2YkdPbjJ3UGZaY0IzcDR5TDZLNUd2SE1kWm1la0NlS1R1?=
 =?iso-2022-jp?B?MTU1ZVBkST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ouVPqVBsbCDimBmcERzddCKrs4/aQ7I4adcb+xNM9uAMnohfocJnfWBbNcDFtr3kJOzIdgJuwEBtBwOxK2ls34IQUEb5bFAI7vNuPgLNmT9INJzAAHAZXXFR/KYO/QKbHYCCtyO/peI2DYfcTaCqzkkswNHmKimi0x/ZvQUwQueTfkDZfm1HBb3n4Gy70YwSdglP2viyE4DqYwKKmd6Dn+dsLXdlTkSnGN6L/sC50SMaKwZFLMbO8CJqZjfG6hyU/CAuoVBpp7z2d4d217je22oh9SYkd8PHMmpZoCcq94nPtOdrO1za+HRzpXVaVDtq8CVELcfGvK9w5qyclDHm7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p/8UdO7zKi2REXCLKcwNna8bo0HKVvIGmT7U3IpJ8vhXbgjB6198L8GnwNT5dHsd8G6kBeqHYTMlw6hM0YGcYku2jbdXIqOaCyXj91ao5lE14PToSz+ZAYyoestxlp9FL5YvL/jW58nQcNdikaCWXWGWTr51dpcPS99V818jeocib0sPu2eCK2/rUnf0lTKB11Ezb2NTh21+JSF5fRAaDhr5GYF2y7dxPC6MBAi5PDYw2l56f+sBiQw+SDLrQT0rFB1sibyHdpUx2xlLC9fIVb48HXOslKiAzcxiCl6PUdfGGZV8eHG2bqJtSgB2q8Z1ALR7UoK/QbGGfhpoOWIjD3yOWkkGtp82W36YmNoxjNragAoT11QdbwOBMc7VWsolXWCPKERb0keoSLDe87t0NfzLMX37E24u/KzZTUEWnSCRlspLKXlRCzvt24z/fVWuVVZukUgNxXoVs7w5kNfuEb18yXHsWAfoan6N8FQCiXsSiS/zaR++fnxXzBTPs3uCbef3Qqt3So9RUFxIk4duueOKcrSQtlTNKCqZXCQVTiNA0ipwMcY4hGvY5uCsRESiKpPGOwpgym4YXcOrAgpX0vzntKbUesWsYErQdIm4pyAPu4v//yCFKr9cYXKjSUpCu2XLG19BQyBStlSbKGqUESuHnqCtzaT/l3wIDK6MoeibDO1Ho/hJnban0/PdefiSENlxC58adorb+fncp3uIImi4J/7RaOLaHaLbmm686zi04dYL2864bnn2449/k/Za
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB0924.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d13252-b750-4a1e-9ca0-08df139a370d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 02:28:37.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJypcQFs2FmXGSI6mY4uKBp6HezuEo4RrVyT9wLtQpM6DTOSSiI7IzsYf9n3iNTp2B/fdXChgxzTsuNwY2YcDiSoHs9khq+3n39JEhObwK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1908
X-CC-Mail-RelayStamp:CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To:  <yigejiang86@gmail.com>, <netdev@vger.kernel.org>
Cc:  <ilias.apalodimas@linaro.org>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>

> netsec_of_probe() takes a reference on the PHY device_node with
> of_parse_phandle() and stores it in priv->phy_np, but the driver never
> drops it.  One device_node reference is leaked per probe, on the success
> path as well as on every error path reached after netsec_of_probe().
>=20
> Neither consumer takes ownership.  of_mdio_parse_addr() is a static
> inline taking a const struct device_node * that only reads the "reg"
> property.  of_phy_connect() borrows as well: of_phy_get_and_connect() in
> drivers/net/mdio/of_mdio.c brackets its own call with of_node_get() at
> :364 and of_node_put() at :373, which would be a double put if
> of_phy_connect() consumed the reference.
>=20
> The node is still in use at netsec_netdev_open() time, where it is
> passed to of_phy_connect(), so it has device lifetime.  Release it at
> the probe error label, which every failure path after the acquire
> funnels through, and in netsec_remove().  Both releases precede
> free_netdev(), since priv is netdev_priv(ndev).  The ACPI probe path
> leaves priv->phy_np NULL and of_node_put(NULL) is a no-op.
>=20
> There is no end-user visible symptom on currently supported platforms:
> a device_node is only freed once OF_DYNAMIC is enabled and the node has
> been detached, so on a static device tree the imbalance is inert.  It is
> observable as a refcount that grows across bind/unbind cycles, and would
> matter under device tree overlays.
>=20
> Found by static analysis of reference acquire/release pairing rather
> than from a runtime report.  No reproducer was produced and the change
> has not been runtime tested; it is compile-tested only (arm64,
> CONFIG_SNI_NETSEC=3Dm via COMPILE_TEST).

Tested on SynQuacer.
Verified repeated load/unload cycles and network connectivity.

Tested-by: Masahisa Kojima <kojima.masahisa@socionext.com>

>=20
> Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
> Assisted-by: LLM
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---
>  drivers/net/ethernet/socionext/netsec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/socionext/netsec.c
> b/drivers/net/ethernet/socionext/netsec.c
> index d14a6584473c8..79a0a324c921d 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -2149,6 +2149,7 @@ static int netsec_probe(struct platform_device
> *pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  free_ndev:
> +	of_node_put(priv->phy_np);
>  	free_netdev(ndev);
>  	dev_err(&pdev->dev, "init failed\n");
>=20
> @@ -2166,6 +2167,7 @@ static void netsec_remove(struct platform_device
> *pdev)
>  	netif_napi_del(&priv->napi);
>=20
>  	pm_runtime_disable(&pdev->dev);
> +	of_node_put(priv->phy_np);
>  	free_netdev(priv->ndev);
>  }
>=20
> --
> 2.50.1 (Apple Git-155)




