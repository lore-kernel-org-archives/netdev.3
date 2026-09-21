Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8E30DED1
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789957909; cv=fail; b=uHqbxV0FglAOKYW/z57wKFdIex7tvhO0/RVlpdsfQCh12cq8IXRJ2a24vnCeZx/p7bSh4h6vWrYEkjSxrnEy/qGEzVg7DlWYjriCLDyddFtOLr5Ft6tRkC1V4lBKCuiEOuyCWCCtljUaiR+I0t+gGDrClh4V1n2tsgdqmsSLY8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789957909; c=relaxed/simple;
	bh=mNt0ZFRomRGxWNQ2Qc/WAaefzjd9Al/9O/Zi1zS0FIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+XgkvvoZVN5lDcnxmf483zTC8UFMtuZVJQllj8fcdSl4w02Mrk39nNTK/7d97llDWpEt1SNJczzHibVel2RAcUXiMm/X0cS22wlKgFieiaQycxqSj8wwMyMclEWzIu4gA6wCh8ME84A+rWqz4PGYrYsduzogIQes3xcAQvkPHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IwyRwlTW; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IwyRwlTW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2hJHBgcalYwF2r82wFDMXI0IzuNYbURvVBDOf4EzDlNbp7rhko/aCVxNI631zz9ypnH8Xagcm+lEUnOIRxy1SJZQryECNFh4qzVdUw+nLZQxIFR22uqRsOOgCpLVBZkdw8A+zR7QVsZfLfjFVENoEw4Yl0ZOJ0r/MheThzrcn7WBIbZKw2cIUErSeXrwAm0ElntKHELNj99BykT/vHReN/yDCdP+FJn9Suv1JsKWAyPYp/hwJk+knzXfnLcOEpJM2sQo3xb6kIRZ8l5Ii7S/jhbYN6W44sEioqnzYAJxtDdx37qYjJZonFMmZZFIec2Q7+FLJ75QZq0EHfJx5UW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNt0ZFRomRGxWNQ2Qc/WAaefzjd9Al/9O/Zi1zS0FIQ=;
 b=aWSmHgnMRjDqs46pSJ40X8Zlk44H9xd/nvA9KguGB1lVtoDOzpiXrE1Uzmqce850o41u0WVocLqx2CUTQ28HFIcGFjVMJg/Gfjxi9Vcov/uaw4A/lgSYQijJ3wYEqjcH5T4dcEOBEFlCa497Hj6cqVRCc0qvLbVfTgwDB23GnbWQSKtmx0L+7+/SUcC0bmEmYVO4yKkEo3BgPhf6SF0JEzO84ogQgs19FdRgypUeBLAPem8ujwVXVWqRM6iCHsCCipBYpBCdBa2s7V//ZKNHKfRPtgKxKzGFTpgHzUoLIGcljLtQu9cwFo3UUJ3pjOzSU9Ln3mxE7xyB68Uqia3EDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNt0ZFRomRGxWNQ2Qc/WAaefzjd9Al/9O/Zi1zS0FIQ=;
 b=IwyRwlTWuOKJFwFRY8yT+7O6CXkoBN/3A5GYBidE79HpQOwEJBbb+eHLbq0vM7mf6muK/0+yH2AETXpxAZ84AWuouvk09yrcvTVGytfyvCMCL4xvts/VOHRig8PDrfmXkRoN9kkzWDigtCP5gq7cbwlN1KX0wmnJBOC4Kw1TXl4b/zJn+A+1EeEbQTS0N7he6sLE8wIc/J5okvEflLgCSm2saaAQv39gNlvr2koNxb5VdL4HCu7bNu/QQRkLvyeMn0qmNFyK99eSE+hM6UksolQmz2aovhxaZjNbm1oOob3xf4gMZTUYlHAha8koam9l3lr+QC9Ce8+FxzB+o5cCjQ==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by WAWPR04MB731403.eurprd04.prod.outlook.com (2603:10a6:1d0:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 02:31:43 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 02:31:42 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Wei Fang <wei.fang@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Topic: [PATCH v4 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Index: AQHdRz7mJNvdwL5OkEKz7kxCT3KMQbbVgdiAgALSVKA=
Date: Mon, 21 Sep 2026 02:31:42 +0000
Message-ID:
 <AS4PR04MB9338ADBB7EB19A290FF5371F88842@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
 <20260918072852.501420-9-wei.fang@oss.nxp.com>
 <20260919072621.D09DE1F000FF@smtp.kernel.org>
In-Reply-To: <20260919072621.D09DE1F000FF@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|WAWPR04MB731403:EE_
x-ms-office365-filtering-correlation-id: 5d17a914-f9ed-4c73-2b2c-08df17887944
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info:
 jaBLKcvTadCRy0rQhptgyK0FDCy99dX1OFG4si3lf+FA+kpj+qLG/03f6tx0M0I9+D7rZshb169pB7teyMegcu0UQfEqsQHuQ327vjjMYtcLcVF4IB23WmbkozkDUl4tV4sXON7O+Y/8Qmc8W9encYPud7IHvwdn2kkWUMXUUXxQepwQzmHcFFbN+0NBm9Sn/reb1YY7PyPWEe+2P74/WVp9fsTJyufdWqFzdzNsAs5LKW2I4vY2KA917QpWeae5yK3+t9FxqyeXwyYQ1bD29i57BDE2gq+pkxeq+1xS3+ToUhtKA5DyjvhDYEhEsATM7/Enr0vQ+WDgv8ltL6hnTdzoegS1rqEAQQUD/xhndNEzpqRmNPrbhID9mGY2dx7qurVqXyhfh9gsuDyhzRNLboG6wxdk5HNRC04kf61IL3lYrrJw9dwaRB7EsWvKZfUPBVP9KT0tsVUDV8Wye0cwmA1z/4vrdWtW1nefMrRDnW1pfPfo9DMmluv4HUOU3s1n0ezOB8450Ycv3Svbt5uxuCKJIx4ZJldm0hrKAWmQAa6zA8bG5ql6vtObcecGYskoAhZk8YfMzIk1IrQ2rS0/nJBHKrXAlCZSPA/hAvE6n4r1PG1iXDWaiUcW1Qfn60IPCCw9Q1ET8+2bZ51Z5k1cRJz8+YsmdKWzyF6ajQqxVfvzAF/gB/kQjR/cASWpdiEvoD7LlE3LKPDgRWIeqBTaS8bRjo+ZWHdvEfYJlbTHZ9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWZhMzJOc1BQNWVCSXNMeFpmdjd1czlWb0pwZXBVeGw2WTdxZVNTVGpTanYw?=
 =?utf-8?B?OEdmaUFCbjdUNzdxQlNnd0NKTFVqMEpWOElPazkyWWpGTE9Dby80dG9sWkht?=
 =?utf-8?B?TG85Yi9qV1NLQXpSbmppaVppRXkvbms2RmxVYzN1cnZVL0ZiTDN0UjlwanRS?=
 =?utf-8?B?VWVBWkQxSEhWTlJyQTBvcTZxNEhJaTRwaG92dUgrUEJHZGY1azBpd01Eak5Z?=
 =?utf-8?B?dEk4YW4veTVlZ2VTL1R3dEpiZ3dZYW5CUWVlTzRuZDh4dDJ4R1RZRklibjBq?=
 =?utf-8?B?Z1ZRUnE5Z1JTUkJLSkkrUzBFWE5Wa1Y2dHdTYWh4bDZrYkdDRjNiN3BYOFVz?=
 =?utf-8?B?K1Z0djV1VEFOL2hJeHBja3JmZCtTMWFUazFOT25CM3E0N0RPejFuemlvNk5r?=
 =?utf-8?B?RHRrdndFbnlGcERyRGd0cGx3Q1NOZnNyM3JWY0NvNXhXak1scURTV3pSSitR?=
 =?utf-8?B?NzhJeWRON2U3dWM3VEhNZW5sS1JqNVVGSFlocFlsa0lqWURtQ2p4cVFWSVVN?=
 =?utf-8?B?dzZtN2xsMHpZckRwSGMwVDhnbUgxRWxYazdHUFpFVnU1SWlobEhQL0NSSG1T?=
 =?utf-8?B?V0dJUTlrK1VqNFZ0MUpPSmNvNXp6dUM4bDVONzF5MUJrekE5b0VOQTlzV2wx?=
 =?utf-8?B?V0FUbkVRUFhQa0pXSE50T1REc0NEVDU3L2ZKZUd6V1FnYTl1MnQ5R1g2ZUpa?=
 =?utf-8?B?QXFHRXliSzdhMjlKZnVnTENMZW5IQ1czV3lvNU9HQ3IyVUlOMFRZUVY0UUZx?=
 =?utf-8?B?eGNkSDdmVXBkMU9rSjhGNnBNaDdCYktUbm1laDBiSlNWa0VQOE00ZDBKMEN1?=
 =?utf-8?B?QkY2ZE1OT0pSZWVBRytoOFUzc1k0bDlONGZrZXB6bHZOa25TTml0R0ZFVGVR?=
 =?utf-8?B?ZEVXNndRY1lmMGpGeHR0bE9UTFB0bHMxMWRMVDdydDcxSi9oaEpua2JKYk5R?=
 =?utf-8?B?aktBd3dEbkJlVVVxRmVSSGthZU5GS3cwdW5IMk5XZUdIMjJQdklvZWhnN1FO?=
 =?utf-8?B?aEF4Y2V6aTFub0ZlVk5aSHd6dEN0T0NpKzhLdG1ZdVNsd0Q5ZVptUkVDUmI3?=
 =?utf-8?B?Y29ueHI4Ynk5a3ZHL1kwTG5CWkVYS3FCMmEyTWlCZjh3dFNjNVZGOGhIOGxy?=
 =?utf-8?B?YVZYcWNIaUxnVDNzYThld3d6NktWV0tWaS9IS2RiQ2pRU0ZqY0JCbzVpS1Fs?=
 =?utf-8?B?MHFQb2doQ0hGU3JQd09weXo4emZ3Z0lya1I2U1ovMWhLNDc5Um8zZTcrRThX?=
 =?utf-8?B?Z0F5bUpDUDZPVGNobnhkUmdtUDFQeWdtWVd3M3UwWnpJRW15cWl6K2pyWVlX?=
 =?utf-8?B?Zjk2ZWxGQXlJc2JCVGg0UlZ3NjdZRlhyNlZPVzNEaDllTy91QXJuWDZMOGJO?=
 =?utf-8?B?UHlOcGI0QnRLNjNudnY2SGltSGNuT2tORUM2SW13VWlNenBUYmJPK0NMd0RL?=
 =?utf-8?B?dzhjQnJFRzk3dUh3MkwzSzMzb0dEeDYwazVqeWd4WFFLem91TCtZekFlVE4w?=
 =?utf-8?B?UU1MaVpUTHpvQTVJOXUxaG5WVmFobUJ0WTFUbmpUQjV0T1lPVnRobk55eVlv?=
 =?utf-8?B?NzJPTURjaDdKSTA1MDJTelRRbi9PVVFEWGhmRTd6dkFDcVphcXFheFcySlBB?=
 =?utf-8?B?REJrdDhiQ2hkMDVJM2I2OVY4YStQbTNTYUdqWDJXQjlKVEJyM0FycmJPL1cv?=
 =?utf-8?B?QktFYWF5eVpDL2ZQWGZkdk1QekJod1A0dmpFZWxrY1RmZFh6aThIbkcwTFZG?=
 =?utf-8?B?UVc0Z0E0QjFkMmxqc2oyaCt0eG1GK2d5amZ2MXlNWHJQazhnSXlma2xpa3B1?=
 =?utf-8?B?Y29uakg1Uy9OelpCMkFwUko5YXl1TjAzSWNKWXpMbkRxM2FsWjRLTnJJZmlN?=
 =?utf-8?B?ZzVtM1d5NUh2WHJIbmFKdkhOc0docDk3OFlCdi9qU29lTS9QUzRJVnBJQ2d3?=
 =?utf-8?B?Q2VBd1l6MjdtUTJLL25ZOG1CK1Ewa3JlMitlM05BV05mSkRHNE8yS1RUWDlx?=
 =?utf-8?B?NmNrVmp1Y2U0bkIzZFN5RjZHY2dQV1dGcVliMkRWYytaaWZLTFBBTEZoczdM?=
 =?utf-8?B?TnVEaHJTREZ3dHE5OTBNSjhGd3c3bFc3S0t3NTZQeDRZUUJTUktMcW5qOWpu?=
 =?utf-8?B?OGx0K0czQ1NxNE9PM09sOVlPSTE3MkdzcHpTNXJPZVlEZEpDRFBHVzVzTGds?=
 =?utf-8?B?VkRXSmRMMDZOZXRacVp4ZzRaTys3QVRiV2dQcm92MWlCYzF4Y2o2c2xFNEFh?=
 =?utf-8?B?OFhINjEvSmV3V3RsZi93ZURqSnZBR3U0ZGxDZXo0RDZScExuYlZxMDVJeGlw?=
 =?utf-8?Q?64GfWr/uiPXIRmuT/H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17a914-f9ed-4c73-2b2c-08df17887944
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 02:31:42.6813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxeXayJJyVnsl5jMKMexwxlCiPj8nb1Pg4UN6l7wo7V0Ws4EL3JF4VXZuHM49IMoJQKv7gVFcMLiDB2qEvkQQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WAWPR04MB731403

PiA+ICtzdGF0aWMgdm9pZCBuZXRjX3BvcnRfcHJvZ3JhbV9vbmVzdGVwKHN0cnVjdCBuZXRjX3Bv
cnQgKm5wLA0KPiA+ICsJCQkJICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gPiArew0KPiAN
Cj4gWyAuLi4gXQ0KPiANCj4gPiArCQlvbGRfc2VjX2ggPSBfX2dldF91bmFsaWduZWRfdChfX2Jl
MTYsIGhkciArIHRzdGFtcF9vZmZzZXQpOw0KPiA+ICsJCW9sZF9zZWNfbCA9IF9fZ2V0X3VuYWxp
Z25lZF90KF9fYmUzMiwgaGRyICsgdHN0YW1wX29mZnNldCArIDIpOw0KPiA+ICsJCW9sZF9ucyA9
IF9fZ2V0X3VuYWxpZ25lZF90KF9fYmUzMiwgaGRyICsgdHN0YW1wX29mZnNldCArIDYpOw0KPiA+
ICsJCWluZXRfcHJvdG9fY3N1bV9yZXBsYWNlMigmdWgtPmNoZWNrLCBza2IsIG9sZF9zZWNfaCwN
Cj4gPiArCQkJCQkgbmV3X3NlY19oLCBmYWxzZSk7DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0N
Cj4gRG9lcyBtb2RpZnlpbmcgdGhlIHBheWxvYWQgb2YgYSBjbG9uZWQgU0tCIGhlcmUgdmlvbGF0
ZSB0aGUgbmV0d29ya2luZyBjb3JlDQo+IFNLQiBidWZmZXIgb3duZXJzaGlwIGd1aWRlbGluZXM/
DQo+IA0KPiBUaGUgb3JpZ2luYWwgU0tCIHdhcyBjbG9uZWQgZWFybGllciBpbiBuZXRjX3BvcnRf
b25lc3RlcF93b3JrKCksIG1ha2luZyBpdHMNCj4gZGF0YSBidWZmZXIgc2hhcmVkIChza2JfY2xv
bmVkKHNrYikgZXZhbHVhdGVzIHRvIHRydWUpLiBCeXBhc3Npbmcgc3RhbmRhcmQNCj4gYnVmZmVy
IG93bmVyc2hpcCBydWxlcyBhbmQgZGlyZWN0bHkgbW9kaWZ5aW5nIHRoZSBzaGFyZWQgcGF5bG9h
ZCB0cmlnZ2VycyBhbg0KPiBleHBlbnNpdmUgcmVhbGxvY2F0aW9uIGFuZCBjb3B5IChwc2tiX2V4
cGFuZF9oZWFkKSBpbiBkb3duc3RyZWFtIGNvbmR1aXQNCj4gZHJpdmVycyB0aGF0IGNoZWNrIHNr
Yl9jbG9uZWQoKSBiZWZvcmUgcGFkZGluZyBvciBtb2RpZnlpbmcgdGhlIGZyYW1lLCB3aGljaA0K
PiBjb3VsZCBzZXZlcmVseSBkZWdyYWRlIG9uZS1zdGVwIFBUUCBwZXJmb3JtYW5jZS4NCg0KQXMg
c3RhdGVkIGluIG5ldGNfcG9ydF9vbmVzdGVwX3dvcmsoKTogIkNsb25lIGlzIGEgdHNfcmVxX2lk
IHRva2VuIG9ubHk7IGl0cw0KcGF5bG9hZCBpcyBuZXZlciByZWFkLCBzbyBzaGFyaW5nIHRoZSBi
dWZmZXIgd2l0aCB0aGUgbXV0YXRlZCBvcmlnaW5hbCBpcyBmaW5lLiINCg0KVGhlIGNsYWltZWQg
ZG93bnN0cmVhbSAidW5zaGFyZSBwZW5hbHR5IiBhbHNvIGRvZXMgbm90IG9jY3VyOiB0aGUgY29u
ZHVpdA0KKEVORVRDIHBzZXVkbyBNQUMpIHRyYW5zbWl0IHBhdGggZG9lcyBub3QgY2hlY2sgc2ti
X2Nsb25lZCgpIGFuZCBkb2VzIG5vdA0KY2FsbCBwc2tiX2V4cGFuZF9oZWFkKCkg4oCUIGl0IG9u
bHkgRE1BLW1hcHMgYW5kIHNlbmRzLCBuZXZlciByZXdyaXRpbmcgdGhlDQpwYXlsb2FkLiBTbyBu
byByZWFsbG9jYXRpb24gaXMgdHJpZ2dlcmVkIHJlZ2FyZGxlc3MuDQoNCkFuZCBQVFAgc3luYyBw
YWNrZXRzIGFyZSB2ZXJ5IGluZnJlcXVlbnRseSAoZm9yIGV4YW1wbGUsIHB0cDRsIHN1cHBvcnRz
IDEyOA0KcHBzKSwgc28gSSBkbyBub3QgdGhpbmsgdGhpcyB3aWxsIGRlZ3JhZGUgb25lLXN0ZXAg
UFRQIHBlcmZvcm1hbmNlLg0KDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICtzdGF0aWMgdm9pZCBu
ZXRjX3BvcnRfb25lc3RlcF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykgew0KPiA+ICsJ
c3RydWN0IG5ldGNfcG9ydCAqbnAgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IG5ldGNfcG9y
dCwNCj4gPiArCQkJCQkgICAgb25lc3RlcF93b3JrKTsNCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4g
K3NrYl9kZXF1ZXVlOg0KPiA+ICsJc2tiID0gX19za2JfZGVxdWV1ZSgmbnAtPm9uZXN0ZXBfcXVl
dWUpOw0KPiA+ICsJaWYgKCFza2IpDQo+ID4gKwkJZ290byBzZXRfb25lc3RlcF9zdGF0ZV9pZGxl
Ow0KPiA+ICsNCj4gPiArCS8qIENsb25lIGlzIGEgdHNfcmVxX2lkIHRva2VuIG9ubHk7IGl0cyBw
YXlsb2FkIGlzIG5ldmVyIHJlYWQsIHNvDQo+ID4gKwkgKiBzaGFyaW5nIHRoZSBidWZmZXIgd2l0
aCB0aGUgbXV0YXRlZCBvcmlnaW5hbCBpcyBmaW5lLg0KPiA+ICsJICovDQo+ID4gKwljbG9uZSA9
IHNrYl9jbG9uZShza2IsIEdGUF9BVE9NSUMpOw0KPiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+
IENvdWxkIHRoaXMgY2xvbmUgb3BlcmF0aW9uIGxlYWQgdG8gdGhlIGRvd25zdHJlYW0gYnVmZmVy
IHVuc2hhcmluZyBwZW5hbHRpZXMNCj4gZGVzY3JpYmVkIGFib3ZlPw0KPiANCj4gU2luY2UgdGhl
IGNsb25lIGlzIG9ubHkgdXNlZCBhcyBhIHRpbWVvdXQgdG9rZW4gYW5kIGl0cyBwYXlsb2FkIGlz
IG5ldmVyIHJlYWQsDQo+IHdvdWxkIGFsbG9jYXRpbmcgYSBkdW1teSBsaWdodHdlaWdodCBTS0Ig
dmlhIGFsbG9jX3NrYigwLCBHRlBfQVRPTUlDKQ0KPiBleGNsdXNpdmVseSB0byBob2xkIHRoZSB0
b2tlbiBhdm9pZCB0aGVzZSBwZXJmb3JtYW5jZSBwZW5hbHRpZXMgYW5kDQo+IGFyY2hpdGVjdHVy
YWwgb3duZXJzaGlwIHZpb2xhdGlvbnM/DQoNCkFzIGV4cGxhaW5lZCBhYm92ZSwgdGhlIGNvbmR1
aXQgKEVORVRDIHBzZXVkbyBNQUMpIHRyYW5zbWl0IHBhdGggbmV2ZXINCnJld3JpdGVzIHRoZSBw
YXlsb2FkLiBObyByZWFsbG9jYXRpb24gaXMgdHJpZ2dlcmVkIHJlZ2FyZGxlc3MuIFNvIEkgZG9u
J3QgdGhpbmsNCnRoaXMgaXMgYSBwcm9ibGVtIHRoYXQgbmVlZHMgdG8gYmUgc29sdmVkLiBJZiBu
ZXRkZXYtYWkuYm90cyByZXBvcnRzIG90aGVyDQppc3N1ZXMgdGhhdCBuZWVkIHRvIGJlIGFkZHJl
c3NlZCwgSSB0aGluayB3ZSBjYW4gaW1wcm92ZSB0aGlzIGxvZ2ljIHdoaWxlDQp3ZSdyZSBhdCBp
dC4NCg0K
