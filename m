Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EA30B529;
	Sat, 15 Aug 2026 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786832375; cv=fail; b=By6DPrEDXK+vHyp4c2gS78qqveZVgKnvENw9PnN+4OGs4ZDtOn9F+tQpQlnfwsA1zWZpxIZydRpR1RMICT7urt7SgPPKZ1fnbfs6FdqOgVQdaDwrsLbM/hpWO7XWmtZvzLqKPATeuYWTYOr/6BnakWVCpMkP9m7FgXRfar06cfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786832375; c=relaxed/simple;
	bh=YB0q48BvKxT3ttnHAEibJ4Pse+ZjrS7ejMU/4qEG4bY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jTN6c0RyQ4QQhYpUx/1ffeQ6+lUn2dlbmdoG3uj9p0SD39LyiQ84vz5jVRYfgkanpFlfFbCK8RTiyZdCtAQfRoHFCC/gQHSNerSQcMi61k89n0wpDIa0OtmzCggT9E4yTRUQFEezqbf+J9Zj0LpEvTgHsDeWXQeF/rCv34cB1b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=dQAC9NyN; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=JeOOuuFq; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="dQAC9NyN";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="JeOOuuFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=YB0q48BvKxT3ttnHAEibJ4Pse+ZjrS7ejMU/4qEG4bY=;
 b=dQAC9NyN1494qnK8D997AwfSF1nRw9LD6FqgmrhbdbYMhljCtVir1UodYQdGAUoN5TSFEsqALNQg/Vshe6vv4nM+ZjiMg53NuuFK8QQ8uN3z7ms422Zwy1cYvr4BCel/snlid8RBC+Xb/iwCFb95blItXZ8enhCgZtfl7O/7v+I2kPnbuYmT23D+oJuZH+awLKkWIjJYHDJk0c3ZHmwyh1W6G5K9pUJ8afLc5JHXk3dOxKtRrUtENAtUSnKFk2L5Ci8YYSAaa35TEiMPvGK/DwLj6RpTbBCdnjswk29uFA8fy1nMHEZbXVZzVitkSO1zAsx5pOGPft54nsrpbO3JJg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023089.outbound.protection.outlook.com [40.107.201.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4760F340070;
	Sat, 15 Aug 2026 22:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0WngASnvOBxUjLXFBjoVPcqBH4o6jPa6ODT4ipNHcjXJtpXdYCpaskT7cyvC1wu1yKXc6HIaO4XlqKjbC/bejrlFfpiJMZ1Vn//aGRpBB3IglRjqObE9VRM3hHa2xClUOQCVMXaxfErsp5Pid+YobktMnh8aYKtrWeQkE07vccwV4mN5pSMNhGwmNkusFQbRw0EgQ8SGYE/ctal896tkinc+1YU49QVYbyEfcutdcYpkSWNjekrb8winTVz5vXBFFhXXtEf+r7ToYtcz3U2HAICYNMhpm5tUEhEZq2dnuxMi0hx/U5qNcY06qJ5vIb0sh8ZbMwFEz4g/yexGKR7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB0q48BvKxT3ttnHAEibJ4Pse+ZjrS7ejMU/4qEG4bY=;
 b=cEgF/GzE0Oxa6ejAIWvQTBisrSFbPJbpHkn2MzvCMTITEjy59hMf+kEZMpP4fkFbvRsTsD3vUons8nrAsvUTwNyQD2Lj0gfM1/IRcsGlzXzDY0sYknTImFSddW5gQRrpVVYp9+Zvh9CBtJUNgyKD6C8JnYrApnycOnrWVM9aXBWrhMNcYwV/JDCX3Rslf6lhQjtLrlJFCzZKnyhKCcdDgeTJDEW0ACmTNO/EoOBUU1k9SgqdmosluUeM8AZ5/vzMhnXMD7egd/KTNZS0QAR3BYFrdNr7Gax078dKr0I9r3ZsjG2JWxPkYO6aYY4O0Hv0fN9EYoW+imNYWQkdsFWuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB0q48BvKxT3ttnHAEibJ4Pse+ZjrS7ejMU/4qEG4bY=;
 b=JeOOuuFqDFDhYjH/Q9CcwdbnM9ClyMUQbsXIBJhGGhWccpfyhXxJ54sYFR9mn42GUIdINgb6yEtlRqamAqJPDzgpj49Hmcp8ZhjmTqWJ6Xzk5/67BJ2ErL5lp5SNP7pV6NyQJMXApPfg9L7PLW0M6ZkiHCpzVFTZOds9eqKTyR8YqqYlMnqUszzpio1kLrT/FeZs4LmD/uoYryizpjqvbQSDVoZJy+CjVlp5QlKoPS++GqQ4ZJNA94+NUQTXWd4n3KHHGblYbWexyP0aOS6TbR1CavBdt/GIURLchGxzlh4TDnqlNf8lkHQH+weTdYCrl+ZgHJ4kfgkrcDS2ACAxcw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5128.namprd20.prod.outlook.com
 (2603:10b6:806:254::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Sat, 15 Aug
 2026 22:19:20 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0315.014; Sat, 15 Aug 2026
 22:19:20 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v7 0/3] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH net-next v7 0/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdLQQew/5VM9j/80G5FA87hS/1Eg==
Date: Sat, 15 Aug 2026 22:19:20 +0000
Message-ID: <20260815221919.64226-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5128:EE_
x-ms-office365-filtering-correlation-id: 95de1ffb-89d9-463e-75ac-08defb1b4114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|56012099006|10067099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 GADmvhWxMzqFKi4Ti2iRT3nquGuBx2/1Px+wK8l0YNK/VFkPzkgYI+Y6x9D7Iiy9/6tjNkS7BlRxHQTz5sHEP4ntnpWCfhWS2zRJujivp3JsolmUrsdgBhehD/g5scWziCW+ECQE9KbcS2sVshuSxz2EAuND36LxDa/ZIERF5ytHv5xHe27GFnPuL16pTNefO/DVfciJo9Kz2APSs768c6GuF8BbqrOY/qv5CzyXwM5SPMqxoIYktCUUoxLA0Bq8tWBvFu8V+a5ny8nfka/aPNc50+wpHL8hC2/6HvnFD6YWmE9v5AXoaCa95S2EPwDR8yNP/YpPMCdGoWFwkNcKRFCPViQEPqlYz7svq5eCvRiaT9DfrLt9uU4zGIgaLPQ02A35/g5v+7mUdoCNbM+ImjhsOXyh0K3Fwjaductc61PAWwaIo8CeleZQ9N008gLnet6HHOkWJXbgKgZvJHUKD8b4UFYJLwkNt+bdP/tmF7GUpqnkupzud3dnscRgGieMtdHX+TcJ+pi+9n2r6AZ9F6yRbx/oja522gYOKX7NnRgdugvyYKi5VJDFvsc1kj26yqusvtPUffGFS3KTMk1AvMNlq5l1W+XeX24HS+uzzhZteUB0+FH5j67ozB2sEszzMZXgAkZ9Njy7uLdkozsBH9Og6PYwGoX+fx58nL23zaf8n2OLf8HpPZwVoB2fGr8gYcRw/WsBpdjfnf5tjzy34lc9fJHEd0matZf4keAcQoc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk5wOG5PQWZSU1RMOUlCQVlXNWtUVXBFM3grSXBudG1IOWM1MHVxb2ZzNHly?=
 =?utf-8?B?Rm8ySmVDZVhOcURqaDQxOGJ6bm1FRCs1Y0xER1FjdEd1ZDBkT2dZWjFmZlRm?=
 =?utf-8?B?R1MwbjQ3KzlGdnpZUCtmZU10TXdRSFlYZHg1c0gyU2FUZUp6dzFlak5XMFA2?=
 =?utf-8?B?TGIwZGhlYzFjd2Znd2lnZG0vZXFSdnJyUjFsSndXK0pVTER0RVRwQ0NtdVkx?=
 =?utf-8?B?UEJZVFFsdFVOK1NWNm10OE96ZWpCRWdPNU5YUUVQZnVpYnNXdEVYMVE1Vk5u?=
 =?utf-8?B?OFFPUHJWQjBzS29BZ25JcW1BelljL1FwTGxhZFUxVDhVQWRhbmVQeDZrK2VX?=
 =?utf-8?B?NFRmc1hqUGd1enNtS002aER4b2JIa01OSXdRdnZabDMxcVNTZ1lFbVpNVlRW?=
 =?utf-8?B?ZmxBdGJPZllCREZpeFRJMWhMSjZ1Z2lzUS9oYjI2VER2ZFNxODdaYXd6OGpG?=
 =?utf-8?B?dzI4NFczRW1YTXJlYU92U3MyaEEzWC9LMUFpT05DaGU2aEJiaFFYam0vUFdR?=
 =?utf-8?B?alNPWWhNRGlsejZPWVRnL1JyVm91SXJCM3owS2pFbXFxUXBIV0VKOFVIMGli?=
 =?utf-8?B?THVkd2RBRUNsdkFzS1JrK3FxY3dUcmlldjRWVmhBZ09LL3RLNmNJTC90aU1a?=
 =?utf-8?B?OFhSc3Z0Q1pMSmhnUHhIRGJFWndLUXhQRm1NdUlybkJ0ZzhRajU2akNuUlNm?=
 =?utf-8?B?bkd2RHBQWk9iT0VQeG1PVWFEVUxnVmg5c1JTaWFkZXNYQldBV0hqY2pjWk5s?=
 =?utf-8?B?dVVQVlZwb3U1eWI0aGdrQXE0ZzlBZEw3V29rUTRWMk1Qdmh6S1BERzNlcXFQ?=
 =?utf-8?B?WEJvQXcyd2dmblZrOW4zWW9kcDhsMk9vTEprNnVINHl5bEVZU21FVXV0RmI4?=
 =?utf-8?B?YVJobnpoNkZuZzh3eGltcmNFRXpJQ013WDdPbXhwVG1QMElXTUpYczRFbWxP?=
 =?utf-8?B?MHVtUTRmSjlzMTJibHQ3aVA5NHk2NHIyeVhlbDI3a0xRVVBCZ0RhVytMNDlE?=
 =?utf-8?B?ZjBYbU55ZG9GSnpPekFmd2FDVVhCWkwxeDR1OVZ1UTdOZUlvdXkydHZpb0ov?=
 =?utf-8?B?WXR6eW9qMU1MMVR2ekNXZGJRSWw0UXNGNkZUTEdndHNlc3A5Y2dmQXpTZ1ds?=
 =?utf-8?B?OWs5amN3cVJ4NXdBdEp1YzFYWnk4U0dlRTBGMFB3eUxlTmJXNzMvYjkrQUFt?=
 =?utf-8?B?OVJLTlJUYXlpYWNINW52QjZ2bDgzNjhoeHBxYnhycjBrMVJQOGdqM3pwd0dk?=
 =?utf-8?B?T2FPdDVNN0ZYeUxEdFlVNEJqb09UZlAzZXJ3SGU4eUIyaHl5OE1pbHVETk1n?=
 =?utf-8?B?Mld5Wm9iRjB5WFdwQlB5TVdCdFpMK3NqU1Vra29PdE1JM0pPc0p0d3ovZm4r?=
 =?utf-8?B?WjQzb1RhZ2FBQUxtdlQza3RNaDlyYnRPWkJvdFVndnBBV3FsN1JzaHJoVGxQ?=
 =?utf-8?B?M0NpMWlrN1VncmpIS0QxREpXRHFGdklLa2FsZ3EwMlU0bTZERFhHZU5UUSt0?=
 =?utf-8?B?ZkhNTHBaR3FIWFYveGd1dy9IWmRwM2I2dzdhUnFMNmF3aTRBM1JrMmEvN3Rk?=
 =?utf-8?B?MWN3ZjhaVGdETWg3cXF0cDBxbjExRXdUMCtUcEZ2UUMvWnBudVYzYXBGeEd2?=
 =?utf-8?B?ZFVTZzNqTEdVdWZ1bVZkVzZ4aEFDOFdDeSsrSGVMYXRDK3R3Wkhtam9Db3ky?=
 =?utf-8?B?UFZEbXVUdFlCOXplWUZsTEMrMVZCZzJURkhZYWprSWNWODZaK2RmSFl1bHJp?=
 =?utf-8?B?QzRycnBlRlpINkNqVlYxTlRmQmxqWXRNck1uelBYc0xMbVBiRmpuNElnUVNQ?=
 =?utf-8?B?bkYydTBFYjF2VzVpZHZSN0k5a0lSZHdsRmxhYmNZbndDMUxCL3ByT1R4Y1Rq?=
 =?utf-8?B?WWNyUGlETE1JZksvbndLejN6UHc2YVAwYlYwOG1ESDhmZm1kSWFYWVVoa24r?=
 =?utf-8?B?M2RhaElLU0lpZzJJclFzRXQwUUdCWlBldzkrNUZxT3AweEJTQ0ZURjVBbklh?=
 =?utf-8?B?Ym1jZVQ0RmU0Mnp2d20xTmVoNUVoZlhYcjBhTCtndW55eUlyS0NvR3pQYnds?=
 =?utf-8?B?alpGVTV0WVpDbVYxRVYySUMxOEFYUS96c1h3WDV6cDFHdGdTK0tFVm9vcWxj?=
 =?utf-8?B?MHBOZEFBMzl4VGFGTERhRWhTazZIK2hSUnRWVGY3ZGNsOXRlQldvR25Yclp1?=
 =?utf-8?B?K1daK3k1dkdCQjVTSU1jbDFBTWRQY0hPeXpJWGljMkJ4VTlWNHprSFRya1E2?=
 =?utf-8?B?R0JCNzBIdmpFRTlkS0gveDh0VU1tbnd6MXdPcEJkcHZ2dXFQelQxZDRXQTU4?=
 =?utf-8?Q?RVpjfhJuhCuYGY318S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	otf4PLOuWmQVhJmB7ts0B+qWYVs1Xr9YNfJMRaYBJsVS9fTejl05V8neW3Caw6JnYsH279n8sulfjR00AtgYWxVwzVuuNoOZD43tGn/9kXhzdtqBlgMxSM5uuO2Q2aBMzEqPhtaAR2QWuEw6D0iP4eEhguJ72SumiNwpScVvStP0F8CbRUd4RiloTSc1v10iyxIJ6uLvSV9YyVo53BVRfGhngyzZCfYN5tNlSXUgbNO2eDZfT0LqDpnWaxsOLjT8E6P2K/Vwf60TmvHNHNQHJRgrRW6MJBccj3JX0Yl47OyxyflwdeXznmuwwEulblyNIqV0VEluFTJkq408Fp4aTQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95de1ffb-89d9-463e-75ac-08defb1b4114
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2026 22:19:20.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qk3tOfWUqibPAJPFzv3BN++F7PXhb0/PyHT4AxFqEw5CGDdEojULOq8mcRFiusrEXOSfRwy5JzAiMY+D5tVc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5128
X-MDID: 1786832366-PDLt0MZDVuv2
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1786832366;PDLt0MZDVuv2;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

VGhpcyBzZXJpZXMgYWRkcyBhIERQTEwgc3Vic3lzdGVtIGRyaXZlciBmb3IgdGhlIFNpVGltZSBT
aVQ5NTMxNiBhbmQKU2lUOTUzMTcgSTJDIGNsb2NrIGdlbmVyYXRvcnMuIEVhY2ggZGV2aWNlIGlu
dGVncmF0ZXMgZm91ciBQTExzIHdpdGgKYXV0b21hdGljL21hbnVhbCByZWZlcmVuY2Ugc2VsZWN0
aW9uIGFuZCBvbi1jaGlwIFREQyBwaGFzZS1vZmZzZXQKbWVhc3VyZW1lbnQsIGFuZCBpcyB1c2Vk
IGZvciBzeW5jaHJvbml6YXRpb24gaW4gdGVsZWNvbSwgbmV0d29ya2luZywKYW5kIGRhdGEtY2Vu
dGVyIHRpbWluZy4KClRoZSBzZXJpZXMgY29udGFpbnMgdGhlIGRldmljZS10cmVlIGJpbmRpbmcs
IHRoZSBkcml2ZXIgdW5kZXIKZHJpdmVycy9kcGxsL3NpdDk1MzF4LywgYW5kIHRoZSBNQUlOVEFJ
TkVSUyBlbnRyeS4KCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjA1MTEy
MTExNDMuMTk3OTItMS1hcm91aGlAc2l0aW1lLmNvbS8KdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL25ldGRldi8yMDI2MDUyMDE5MTk0My43MzkzOC0xLWFyb3VoaUBzaXRpbWUuY29tLwp2Mzog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwNzMxMTgwOTUxLjY1NzI1LTEtYXJv
dWhpQHNpdGltZS5jb20vCnY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjA4
MDYyMzI0MzkuMjc1NTEtMS1hcm91aGlAc2l0aW1lLmNvbS8KdjU6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL25ldGRldi8yMDI2MDgxMDIzMDQzOS4yMjg2Ni0xLWFyb3VoaUBzaXRpbWUuY29tLwp2
NjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwODEyMTc1MzM3LjE4MTU1LTEt
YXJvdWhpQHNpdGltZS5jb20vCgpDaGFuZ2VzIHNpbmNlIHY2IChkcml2ZXIgb25seTsgdGhlIGJp
bmRpbmdzIGFyZSB1bmNoYW5nZWQpOgoKICAtIFJlbW92ZSBhIGNvbmZsaWN0IG1hcmtlciB0aGF0
IHNsaXBwZWQgaW50byBhIGNvbW1lbnQgYmxvY2sgaW4KICAgIGRwbGwuYy4gSXQgc2F0IGluc2lk
ZSAvKiAqLywgc28gaXQgYnVpbHQgYW5kIGNoZWNrcGF0Y2gsIHdoaWNoIGhhcwogICAgbm8gY2hl
Y2sgZm9yIG1hcmtlcnMsIGRpZCBub3QgcmVwb3J0IGl0LgogIC0gVW53aW5kIERQTEwgcmVnaXN0
cmF0aW9uIHdoZW4gaXQgZmFpbHMgcGFydHdheS4gZGV2X3N0YXJ0KCkgcmV0dXJuZWQKICAgIG9u
IHRoZSBmaXJzdCBmYWlsdXJlIHdpdGhvdXQgdW5yZWdpc3RlcmluZyB0aGUgRFBMTHMgYWxyZWFk
eSBkb25lLAogICAgYW5kIHRoZSBjYWxsZXIgdGhlbiBmcmVlZCB0aGVtLCBsZWF2aW5nIHRoZSBz
dWJzeXN0ZW0gd2l0aCBwb2ludGVycwogICAgaW50byBmcmVlZCBtZW1vcnkuCiAgLSBSZXBvcnQg
YW4gaW5wdXQgYXMgc2VsZWN0YWJsZSBvbmx5IGZvciB0aGUgRFBMTCB0aGF0IGNhbiBzZWxlY3Qg
aXQuCiAgICBUaGUgdGVzdCB1c2VkIHRoZSBwaHlzaWNhbCByZWNlaXZlciBzdGF0ZSwgd2hpY2gg
ZXZlcnkgRFBMTCBmZWQgZnJvbQogICAgdGhhdCBsYW5lIHNoYXJlcy4gQSBsYW5lIGluIExPUyBu
byBsb25nZXIgZHJvcHMgdG8gZGlzY29ubmVjdGVkCiAgICBlaXRoZXI6IHNpZ25hbCBxdWFsaXR5
IGJlbG9uZ3MgaW4gdGhlIHBpbidzIG93biBhdHRyaWJ1dGVzLgogIC0gUmVmdXNlIERQTExfUElO
X1NUQVRFX0NPTk5FQ1RFRCBvbiBhbiBpbnB1dCBpbnN0ZWFkIG9mIHRyZWF0aW5nIGl0CiAgICBh
cyBzZWxlY3RhYmxlLiBUaGUgZGV2aWNlIHNlbGVjdHMgYnkgcHJpb3JpdHkgYW5kIGhhcyBubyBt
b2RlIHRoYXQKICAgIHBpbnMgb25lIHJlZmVyZW5jZSwgc28gdGhlIHJlcXVlc3QgY2Fubm90IGJl
IGhvbm91cmVkLgogIC0gS2VlcCB0aGUgcmVzdCBvZiB0aGUgcHJpb3JpdHkgdGFibGUgd2hlbiBv
bmUgaW5wdXQgbW92ZXMuIHByaW9fc2V0CiAgICB1c2VkIHRvIGZpbGwgZXZlcnkgbG93ZXItcHJp
b3JpdHkgc2xvdCB3aXRoIHRoZSBzYW1lIHNvdXJjZSwgd2hpY2gKICAgIGRpc2NhcmRlZCB0aGUg
ZmFsbGJhY2tzIHRoZSBjYWxsZXIgaGFkIG5vdCBhc2tlZCBhYm91dC4KICAtIFJlZnVzZSB0byBk
cml2ZSBJTlRTWU5DIGZyb20gYSBQTEwgdGhhdCBhbHJlYWR5IHNlbGVjdHMgaXQuCiAgLSBEcm9w
IHRoZSBTWVNSRUYvU1lOQ0IvcHVsc2VyIGNsYWltIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlOiBv
bmx5IHRoZQogICAgZXN5bmMgZGVmYXVsdCBpcyByZWFjaGFibGUsIHRoZSBvdGhlciBtb2RlcyBh
cmUgbm90IGV4cG9zZWQuCgpUaGUgQUkgcmV2aWV3IGFsc28gcmVwb3J0ZWQgYSB1c2UtYWZ0ZXIt
ZnJlZSBvZiB0aGUgcGluIHByb3BlcnRpZXMuIEl0CmlzIGEgZmFsc2UgcG9zaXRpdmU6IGRwbGxf
cGluX2FsbG9jKCkgY2FsbHMgZHBsbF9waW5fcHJvcF9kdXAoKSwgd2hpY2gKY29waWVzIGZyZXFf
c3VwcG9ydGVkIHdpdGgga21lbWR1cCgpIGFuZCB0aGUgbGFiZWxzIHdpdGgga3N0cmR1cCgpLCBz
bwp0aGUgY29yZSBvd25zIGl0cyBjb3BpZXMgYW5kIHRoZSBkcml2ZXIgaGFzIHRvIGZyZWUgaXRz
IG93bi4KCgpBbGkgUm91aGkgKDMpOgogIGR0LWJpbmRpbmdzOiB2ZW5kb3ItcHJlZml4ZXM6IGFk
ZCBTaVRpbWUgQ29ycG9yYXRpb24KICBkdC1iaW5kaW5nczogZHBsbDogYWRkIFNpVGltZSBTaVQ5
NTMxNiBjbG9jayBnZW5lcmF0b3IKICBkcGxsOiBhZGQgU2lUaW1lIFNpVDk1MzF4IERQTEwgY2xv
Y2sgZHJpdmVyCgogLi4uL2JpbmRpbmdzL2RwbGwvc2l0aW1lLHNpdDk1MzE2LnlhbWwgICAgICAg
IHwgIDE3MSArCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCAg
fCAgICAyICsKIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgIDcgKwogZHJpdmVycy9kcGxsL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAgMSArCiBkcml2ZXJzL2RwbGwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAxICsKIGRyaXZlcnMvZHBsbC9zaXQ5NTMxeC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAg
MTcgKwogZHJpdmVycy9kcGxsL3NpdDk1MzF4L01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAg
NCArCiBkcml2ZXJzL2RwbGwvc2l0OTUzMXgvY29yZS5jICAgICAgICAgICAgICAgICAgfCAzMTEx
ICsrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2RwbGwvc2l0OTUzMXgvY29yZS5oICAgICAgICAg
ICAgICAgICAgfCAgMzcyICsrCiBkcml2ZXJzL2RwbGwvc2l0OTUzMXgvZHBsbC5jICAgICAgICAg
ICAgICAgICAgfCAxMjMyICsrKysrKysKIGRyaXZlcnMvZHBsbC9zaXQ5NTMxeC9kcGxsLmggICAg
ICAgICAgICAgICAgICB8ICAgNjkgKwogZHJpdmVycy9kcGxsL3NpdDk1MzF4L3Byb3AuYyAgICAg
ICAgICAgICAgICAgIHwgIDM5NyArKysKIGRyaXZlcnMvZHBsbC9zaXQ5NTMxeC9wcm9wLmggICAg
ICAgICAgICAgICAgICB8ICAgMzkgKwogZHJpdmVycy9kcGxsL3NpdDk1MzF4L3JlZ3MuaCAgICAg
ICAgICAgICAgICAgIHwgIDM3MSArKwogMTQgZmlsZXMgY2hhbmdlZCwgNTc5NCBpbnNlcnRpb25z
KCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2RwbGwvc2l0aW1lLHNpdDk1MzE2LnlhbWwKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Rw
bGwvc2l0OTUzMXgvS2NvbmZpZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZHBsbC9zaXQ5
NTMxeC9NYWtlZmlsZQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZHBsbC9zaXQ5NTMxeC9j
b3JlLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RwbGwvc2l0OTUzMXgvY29yZS5oCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9kcGxsL3NpdDk1MzF4L2RwbGwuYwogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvZHBsbC9zaXQ5NTMxeC9kcGxsLmgKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2RwbGwvc2l0OTUzMXgvcHJvcC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9kcGxsL3NpdDk1MzF4L3Byb3AuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZHBsbC9z
aXQ5NTMxeC9yZWdzLmgKCgpiYXNlLWNvbW1pdDogMDAxYjVkMzQ3ZDhiYTM5YjJkY2NhZWZjYzU3
OTY3YjE4Y2FlYzhmZQotLSAKMi4zNC4xCgo=
