Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAF3659EB
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243241; cv=fail; b=ZczLy/HahOt1VpYOcvo1LTcfe0p5YkNWxI0h5WRFiUgE15QcJi2XXgXqxrmFrGp6GmIer0aDOmSv3x/4IqjXnhV0ImNnJJhnt2UwB40q/QCEhXN16DLFksS8k/IdX05TCZ64XWos6xaG/GWHsJw/3AA09FHUgzCPYHWUlasosp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243241; c=relaxed/simple;
	bh=N+SC+esMEal7ev4ZfXeBBd30gwLrK2rOlw4eFdh6dBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aGHqK+q42U/RBiGJwe8rOE7hSWI6HZoJaLqaC7zyao6MhFtZdugBmY7s9ACtO+U76RpvCLkcozVqhRcXOKLtZAnWZ/R0bPD1WfbARl26y0MSVJzxQ+6psChztDuoMhhdhuvC3H+3lw0H+zTzjD39hrDxzh766wpeSh6MnDM6qX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EmBKaSPs; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EmBKaSPs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FY66iaVbgx0Wc1mDN3zBcWdcObk3MTA3hJo96SSspVAO2pGAA3jcpOoKuyw+ZI11bt2i40eVM14E6D8Op++KsLOx0RvSr/4Buj8ibSVkELi6kkz/c6XVo2z8IFXnsgtIbrHyhYT0Z+jAuaTuyi8CzUBHwiUmU1vjSTC0Q/+f59XQWH9wHWPUYOE62fHMLKXxjjgIsRo+sKISwaTpLAnlZWPjWYDbt8Ns9vpPGS1llY4lt9qmy5VcDNfmKXl3I5E/lgSR2FnmQojkyHig4bxTx7MZb1B2PlR8bxFH04hoIfwnq/z0w1k7XNIFezJBpRZ2LdFiLp7iicewQRjZTIWVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+SC+esMEal7ev4ZfXeBBd30gwLrK2rOlw4eFdh6dBw=;
 b=xXRRR9Z5ipmI+OwbK2r7NgKDwsIW1amtbgehTOW1IuQWBqojwpZzVEQQXhW+RS+cXnE4ZxdlvW9qo2ir5B64ZMIOhYZr/8LUj96a6Rh7myqWUiyHsmofol1s2AAERuNLQZ6tOytZFOPmD3u3JCXLPPrXZ8LOtwoZWNz5uTRs6acCNlmbIbjcNwUffTbt5fFlBG2ky5jbmus3n71gdt/I/j4ICtK3EBJa2g/ZZv9kijYVdAAKCv7PJ/UAqqA59c8WWXCm8si8JD6/fQQsaKPzIBEidUuWVX5Jz23yxAZ+Cw8iJgP7Rdhsyzy2+TGZbpUmqAdBaYpKS2mQFPnTgKvLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+SC+esMEal7ev4ZfXeBBd30gwLrK2rOlw4eFdh6dBw=;
 b=EmBKaSPsDXDPkut/lX//27PspOrNAk5pzxYbP+20IpMenUNGx/wnYT9rltwzEswgH2DiE8Q+qt+kK9nFTjHfLtpo1VWI4QcMDiwmzb5DtuL8PgtFrlQAv3+FSY1efHSdbCqzV9w9X2/tFo3i9JrIsXxFFzb6Z0sdSNwGpHTYcQ1QkObzYRvN+MQbPVh8T9+EMIjH4ngiCH26zYJ3OJZ6rg52V3HnF2WZp8kX1BOoc457YUkgd+6iP2F3RmcLEszif0IWf/YwXkbROa99Ma602GEAqFlWeBhwFk6/2v4rSt/xML3RtRwJH4CbMibZScBYnyXYv4GvljegsOEPsmrskg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA2PR04MB10122.eurprd04.prod.outlook.com
 (2603:10a6:102:40a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:13:56 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:13:55 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Netdev <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 01/15] net: enetc: add trusted VF support
Thread-Topic: [PATCH v3 net-next 01/15] net: enetc: add trusted VF support
Thread-Index: AQHdOPfy3iCZeXJSl0qmUwc4NIN8uLa5ELYAgAAvedA=
Date: Tue, 1 Sep 2026 06:13:55 +0000
Message-ID:
 <GV2PR04MB11739CFEDBA3DD0B0522D15EC88A82@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260831025441.635045-2-wei.fang@oss.nxp.com>
 <20260901032358.B913A1F00A3D@smtp.kernel.org>
In-Reply-To: <20260901032358.B913A1F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA2PR04MB10122:EE_
x-ms-office365-filtering-correlation-id: 90cdcdd6-202c-41ae-c48e-08df07f03415
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|22082099003|18002099003|56012099006|3023799007|38070700021|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 JgHhEGH7Zy6L8/dqSDBzg/E2OTPmw5d1ugDf8Q/8w8ydn7oMGZOlNLpvPot0NdN6hBtopnJ0vmn6KKNAu11TrKErz2nt1zeaZWPz3jQzNOb35rNDwKSDVF3QKZlJQuyfiUyJkJGtPayXNEbZyMfxDffVM82fcKNkCY1D2j8jeZkt1pkBJquI19FhmnOYpEuw2kJ/5WFMbwZBdJmcLm+R01/5eyqyhHqbX3WOCB0fjT5Yz2MtstKpGeGwTLUKgIljgsN5hlcCJXtkRBRiLMYDllEZ+bA2CBeQyQbjQevJp1L2U+zfuoj2yh0CQ+zProH4ZCIoEBtVlxiEr4SoiNNdNNkTiRmOW/COEl65Vrmg2UPl6H3zaR5Ro493vc+Co4aX3HBA+CpbhJ4tHYqelv9rdTHN6GeWFAWeurjjf+r8s3PXLYBAXnk/IuQI2qTvvfmBtyK8EbPvk0Dsu5dkg+A7JwxZgnhTMGyBd+CROygnEF4786vfYWYZJHI9sm0fE6ZQrjMwHwVzVKwiL0PnaMjMLsspFJtiacy/at3IqElk7Jpbl6xVTVddAJZJUc17zHB+wSmiW9YVgWSV/zoI/kaFmZfRKuSTrPm4ZW8s4GBx4fzbJI85pmISnQKFnRtrQF8AK5FO/R57e66n6BYeUo+rgtMn1EZqoOW87k4lVcv/BFI8L2F6AeSoI3hF8lUn7vFsCK3dcS/7QIspuxSKdIiepw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDhCdFhvS3NkN3hmM082NHFPYU9zdjBYcXlkeVNmaXZPTzFmVTFoR3p6SXhC?=
 =?utf-8?B?bGFKS0IvMlRFOVNuUzlseWFrOEtwTHVEVVhUdTBjdEVLQTVzNWNOVytoOVRL?=
 =?utf-8?B?ckJBT0tHanNnc2NLdU8wYWRYQnF0L1RqZkk4cWlnMzd2TjU1NmxWNFB2UXlG?=
 =?utf-8?B?OVQ1WlZJTGV5UjZLNEhDanhQbTJkNzUrQ0xnOG1LN05kanV2blBvaWVreHdV?=
 =?utf-8?B?NHFrTlJqN2VJQmp0ZXV2bFRqbzBLbzlTWDU0TW8vZ2phT3VmMTNEWDVGTVJ1?=
 =?utf-8?B?eWZ4T0J5R3V1MjlQQ2Jld2FmMzR1UEJXSTA1T1Y2Z0hHOGx3WVdUMmcxNVVU?=
 =?utf-8?B?OExSUEhKTXZPbEVrMU5UVTBoMXJQQjliTFZYTGxxaVlTV2pjZ0NXak8rbHdE?=
 =?utf-8?B?VTBzVzVCdjM0RHRGbjFkMTFXc3FydWY3TlVyOENKenkrdVplRG9VQUMxVTd2?=
 =?utf-8?B?Z3J0QndaOFM4UHRMNDU2amZkVk1pUjNaN0d0K0dnL0kzOWZxUnFDVGFwa08w?=
 =?utf-8?B?eHBGNDRKOHV6RGF4Y2hRNlJVQk9EZ2JiT0ZGdzcyeU9qYndpT05Lcm5MQlJB?=
 =?utf-8?B?dFlOR3JYREdOeGdSTjJ1M1FjVUVmNFpOZFRDSHpwVFk0bzVoOFkzbElWVFVH?=
 =?utf-8?B?SnRaOE9iVy9HOXNXSlAyNlRaY2VacU00clF3d3NhbVdJQ0d6Sjc1L0pSZU42?=
 =?utf-8?B?S0NVcm9xREIxbzZ2ZVNJUUhwRXh4Y1hOMy8xUkNJVHdkS01hc1BUOHdzMDBS?=
 =?utf-8?B?eXdZRHhBME81Z1hFMkFlL1NIM2M2Y3Vackx6N0F4UDFMU3VWWUFJRWZvSUJj?=
 =?utf-8?B?MDdTMEx0cXZleS94dUUvUE14TnhxTnpQekJvUjIvSkF1VG9BQlZnZjZvbDhG?=
 =?utf-8?B?UjF3aFRvaGM1eHZYTHAxbkEwdUxtblE1djhKMUk2MXkxWG9JVVp5NVFmdWk5?=
 =?utf-8?B?Ym1NVEg0L2pFd3p1QWVaL3pySWVZOEIwRHhtL2t2T2VUaStPVjlsSVhCVDZi?=
 =?utf-8?B?T2tIZHphbTEwMlFsajN4aHFIbmoyY1czaVVadFhvb2hDK0lKUHZBYllneFZi?=
 =?utf-8?B?UitiT3MvY3R2SWdWcEFWaXdEUkhPNFZkNXRKOXZ0V2doWEl6c3NOUHg0ajNF?=
 =?utf-8?B?VDVTZkJPbC9aNEQwalhIUmFTU1d0TWxaejhGbXNaOWdqK3A1bDBaelBSZHcw?=
 =?utf-8?B?Z25zd0Jzd2lIM2xwcDRVSnFkSnBlUW9sbjRWTlBxOW5BTHdSTjQrc2puQ1E1?=
 =?utf-8?B?WFc1Z0VnQnJVa0QrcVpONlBWNWhBYVcxSzhacDlEOXhTOFNlV0xqaG0yWnNh?=
 =?utf-8?B?Yy9uMnhtTnkvckdkSTNMK1VNejRNMlp1MmNjbUZsYllQcW4rTjdFazVSMHJu?=
 =?utf-8?B?NVdrVWo3WGFKeDVlTFE2VjJIQkZXdVIySURScjNYdm5JeXJtcTdXOWt6N0tG?=
 =?utf-8?B?S09UeStGaFdSUzBtditKeDg1RHlqbmNML2VZeDhScnlkWThXaVhVWW5ESWZ2?=
 =?utf-8?B?MDV3cmM4bE5HTWxnUXNlUzNnTWtaRTR6eHJORWEvVXhPNHRSQzJ2a1RPRTlX?=
 =?utf-8?B?N1FuZFlSRkhhQ0JUUlRlNnFub3FJZkM1TU41SDNjQkszc0pBZmV2TE8rYzRz?=
 =?utf-8?B?dmJIZ0d1TkFsNm5IRExLcVBHd05FdVdOV2puQkYzMHY1TGxtdmJjOWJjckhV?=
 =?utf-8?B?eUJZeFpzZjY5a084Q2ZjUFRkZkk1RVpsd2hnUmNVWHlZVlp1citML0pFT3VC?=
 =?utf-8?B?c2xWb0xoZGk2QXZqdzNNS2FDNHhjcDlHeVl0QU9yVyswdWN5WWdtTk1QaEd0?=
 =?utf-8?B?RnlYUERjSzJ3VFgrQ1FvTGlBUENwS1JIQmxsSVNxcHAwUzVITE9wOXVvVm45?=
 =?utf-8?B?Q3F5ZHcyV0ZoTExsWE9oK2d4c0E4V1gzSzJaNjA4MCtFVEpzSGNFbndSZTBY?=
 =?utf-8?B?NXJBeHlSNnc5aUdzRXJBcGc2MDBoTHJJSkNBMjRwNEZLaVFBVTBtQThXUVYr?=
 =?utf-8?B?TEVwLzlLUVNYckwzbmFBcjdJRUlqb1dFUEhuSi9QalhSdlcyUmZCZkNSdGtB?=
 =?utf-8?B?MlpOc2o5NkQySFFDWUhVZjdLRElieDRTRllZZHppNjFHR1JkL0RaWXZLU1Zn?=
 =?utf-8?B?NmdFK3JsVkVxWmpMUFgwM2ZEL0liQ0F4Q1JrT2FoTTFqSHFqNzVvWS9hNm94?=
 =?utf-8?B?ZXJNMzRobFc5czhjN2RKQmRyWUFnMS96ZExxc2R5R3FSbFd2d3ZIamcyNDh5?=
 =?utf-8?B?OS84YXdacnc3K2VWTWYxWFUxeGFTeGw4RGk0bnZFZE9wVW0xOXVHd3MrRFl5?=
 =?utf-8?Q?XY53hBK+gppf6Mw4c6?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cdcdd6-202c-41ae-c48e-08df07f03415
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 06:13:55.7059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9u8Ur/A0jrPDspeQKIPmQ0gjQokpctRCirFbg2EeZVk9vtiSs2wZdzyYl2svzFifoSKXzJTR2di3zMIA2kU3Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10122

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5l
dGNfbXNnLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGNf
bXNnLmMNCj4gPiBpbmRleCBlZGMxMjc3YmI1ODYwLi43ODExNGFiM2U0ODIwIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19tc2cuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19tc2cu
Yw0KPiBbIC4uLiBdDQo+ID4gQEAgLTYxLDMxICs2Myw0OSBAQCBzdGF0aWMgdTE2DQo+IGVuZXRj
X21zZ19zZXRfdmZfcHJpbWFyeV9tYWNfYWRkcihzdHJ1Y3QgZW5ldGNfcGYgKnBmLCBpbnQgdmZf
aWQsDQo+ID4gIAlzdHJ1Y3QgZW5ldGNfdmZfc3RhdGUgKnZmX3N0YXRlID0gJnBmLT52Zl9zdGF0
ZVt2Zl9pZF07DQo+ID4gIAlzdHJ1Y3QgZW5ldGNfbXNnX21hY19leGFjdF9maWx0ZXIgKm1zZyA9
IHZmX21zZzsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZi0+c2ktPnBkZXYtPmRldjsN
Cj4gPiArCXUxNiBwZl9tc2cgPSBFTkVUQ19QRl9NU0dfU1VDQ0VTUzsNCj4gPiAgCWNoYXIgKmFk
ZHIgPSBtc2ctPm1hY1swXS5hZGRyOw0KPiA+DQo+ID4gKwltdXRleF9sb2NrKCZ2Zl9zdGF0ZS0+
bG9jayk7DQo+ID4gKw0KPiA+ICsJLyogVW50cnVzdGVkIFZGcyBjYW5ub3Qgc2V0IHRoZWlyIE1B
QyBhZGRyZXNzZXMgYnkgdGhlIG1haWxib3gNCj4gPiArCSAqIG1lc3NhZ2VzLg0KPiA+ICsJICov
DQo+ID4gKwlpZiAoISh2Zl9zdGF0ZS0+ZmxhZ3MgJiBFTkVUQ19WRl9GTEFHX1RSVVNURUQpKSB7
DQo+ID4gKwkJcGZfbXNnID0gRU5FVENfUEZfTVNHX1BFUk1fREVOWTsNCj4gPiArCQlnb3RvIHZm
X3N0YXRlX3VubG9jazsNCj4gPiArCX0NCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gRG9lcyB0
aGlzIGNvZGUgYnJlYWsgc3RhbmRhcmQgTGludXggU1ItSU9WIHNlbWFudGljcz8NCj4gDQo+IEJ5
IHVuY29uZGl0aW9uYWxseSByZXR1cm5pbmcgRU5FVENfUEZfTVNHX1BFUk1fREVOWSBmb3IgdW50
cnVzdGVkIFZGcywNCj4gVk1zIGFuZA0KPiBjb250YWluZXIgZnJhbWV3b3JrcyB0aGF0IHJlbHkg
b24gdGhlIHN0YW5kYXJkIGJlaGF2aW9yIG1heSBmYWlsIHRvIGluaXRpYWxpemUNCj4gbmV0d29y
a2luZy4gU3BlY2lmaWNhbGx5LCB1bnRydXN0ZWQgVk1zIHRoYXQgZ2VuZXJhdGUgYW5kIHNldCB0
aGVpciBvd24gTUFDDQo+ICh3aGVuIHRoZSBob3N0IGhhcyBub3QgZW5mb3JjZWQgb25lKSB3aWxs
IHJlY2VpdmUgYSBwZXJtaXNzaW9uIGRlbmllZCByZXNwb25zZQ0KPiBhbmQgZmFpbC4gU3RhbmRh
cmQgZHJpdmVycyB0eXBpY2FsbHkgYWxsb3cgdW50cnVzdGVkIFZGcyB0byBzZXQgdGhlaXIgTUFD
IGlmDQo+IG5vIGFkbWluaXN0cmF0aXZlIE1BQyB3YXMgYXNzaWduZWQgYnkgdGhlIGhvc3QuDQoN
ClRoaXMgaXMgYSBmYWxzZSBwb3NpdGl2ZS4gVGhlIFBGIGFsbG9jYXRlcyB0aGUgTUFDIGFkZHJl
c3MgZm9yIGVhY2ggVkYgYnkgZGVmYXVsdC4NClRoZSBWRiBjYW4gZ2V0IHRoZSBNQUMgYWRkcmVz
cyBmcm9tIGl0cyBTSVBNQVIwLzEgcmVnaXN0ZXJzLiBTbyB1bnRydXN0ZWQgVkYNCnN0aWxsIGNh
biB1c2UgdGhlIG5ldHdvcmsuDQoNClRoZSBjdXJyZW50IHBhdGNoIGp1c3QgcHJldmVudHMgdGhl
IHVudHJ1c3RlZCBWRiBmcm9tIHNldHRpbmcgaXRzIG93biBNQUMNCmFkZHJlc3MgdGhyb3VnaCB0
aGUgbWFpbGJveCBjaGFubmVsLg0KDQo+IA0KPiA+ICsNCj4gPiAgCWlmICghaXNfdmFsaWRfZXRo
ZXJfYWRkcihhZGRyKSkgew0KPiA+ICAJCWRldl9lcnJfcmF0ZWxpbWl0ZWQoZGV2LCAiVkYlZCBh
dHRlbXB0ZWQgdG8gc2V0IGludmFsaWQgTUFDXG4iLA0KPiA+ICAJCQkJICAgIHZmX2lkKTsNCj4g
PiAtCQlyZXR1cm4gKEZJRUxEX1BSRVAoRU5FVENfUEZfTVNHX0NMQVNTX0lELA0KPiA+IC0JCQkJ
ICAgRU5FVENfTVNHX0NMQVNTX0lEX01BQ19GSUxURVIpIHwNCj4gPiAtCQkJRklFTERfUFJFUChF
TkVUQ19QRl9NU0dfQ0xBU1NfQ09ERSwNCj4gPiAtCQkJCSAgIEVORVRDX01GX0NMQVNTX0NPREVf
SU5WQUxJRF9NQUMpKTsNCj4gPiArCQlwZl9tc2cgPSBGSUVMRF9QUkVQKEVORVRDX1BGX01TR19D
TEFTU19JRCwNCj4gPiArCQkJCSAgICBFTkVUQ19NU0dfQ0xBU1NfSURfTUFDX0ZJTFRFUikgfA0K
PiA+ICsJCQkgRklFTERfUFJFUChFTkVUQ19QRl9NU0dfQ0xBU1NfQ09ERSwNCj4gPiArCQkJCSAg
ICBFTkVUQ19NRl9DTEFTU19DT0RFX0lOVkFMSURfTUFDKTsNCj4gPiArCQlnb3RvIHZmX3N0YXRl
X3VubG9jazsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JbXV0ZXhfbG9jaygmdmZfc3RhdGUtPmxvY2sp
Ow0KPiA+ICsJLyogUEYgaGFzIGhpZ2hlciBwcml2aWxlZ2VzLiBJZiBQRiBoYXMgYWxyZWFkeSBt
b2RpZmllZCB0aGUgTUFDDQo+ID4gKwkgKiBhZGRyZXNzIGZvciBWRiB0aHJvdWdoIC5uZG9fc2V0
X3ZmX21hYygpIGludGVyZmFjZSwgVkYgaXMgbm90DQo+ID4gKwkgKiBhbGxvd2VkIHRvIHNldCBp
dHMgTUFDIGFkZHJlc3MgdmlhIG1haWxib3ggbWVzc2FnZXMsIGV2ZW4gaWYNCj4gPiArCSAqIGl0
IGlzIHRydXN0ZWQuDQo+ID4gKwkgKi8NCj4gPiAgCWlmICh2Zl9zdGF0ZS0+ZmxhZ3MgJiBFTkVU
Q19WRl9GTEFHX1BGX1NFVF9NQUMpIHsNCj4gPiAtCQltdXRleF91bmxvY2soJnZmX3N0YXRlLT5s
b2NrKTsNCj4gPiAgCQlkZXZfZXJyX3JhdGVsaW1pdGVkKGRldiwNCj4gPiAgCQkJCSAgICAiVkYl
ZCBhdHRlbXB0ZWQgdG8gb3ZlcnJpZGUgUEYgc2V0IE1BQ1xuIiwNCj4gPiAgCQkJCSAgICB2Zl9p
ZCk7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IElzIHRoaXMgcmVzdHJpY3Rpb24gZGVmZWF0
aW5nIHRoZSBlc3RhYmxpc2hlZCBrZXJuZWwgcHVycG9zZSBvZiB0aGUgVkZfVFJVU1QNCj4gZmxh
Zz8NCj4gDQo+IElmIGEgVkYgaXMgdHJ1c3RlZCwgc3RhbmRhcmQgU1ItSU9WIHNlbWFudGljcyB0
eXBpY2FsbHkgYWxsb3cgaXQgdG8gb3ZlcnJpZGUNCj4gYWRtaW5pc3RyYXRpdmUgcmVzdHJpY3Rp
b25zIGxpa2UgYSBob3N0LWFzc2lnbmVkIE1BQyBhZGRyZXNzLiBUaGlzIGJsb2NrDQo+IHByZXZl
bnRzIGV2ZW4gdHJ1c3RlZCBWRnMgZnJvbSBvdmVycmlkaW5nIGEgUEYtYXNzaWduZWQgTUFDIGFk
ZHJlc3MsIGNhdXNpbmcNCj4gYSB0cnVzdGVkIFZGIHRvIGZhaWwgd2l0aCBhIGNvbW1hbmQgbm90
IHBlcm1pdHRlZCBlcnJvciBpZiBpdCB0cmllcyB0byBjaGFuZ2UNCj4gYSBob3N0LWFzc2lnbmVk
IE1BQy4NCg0KVGhpcyBpcyBhbHNvIGEgZmFsc2UgcG9zaXRpdmUuIFRoaXMgcGFydCBpcyBpbmhl
cml0ZWQgZnJvbSBMUzEwMjhBLCBhbmQgaXMgbm90DQppbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gu
IFRoaXMgcGF0Y2ggc2ltcGx5IGFkZHMgc29tZSBjb21tZW50cyBleHBsYWluaW5nDQp0aGUgaW50
ZW50aW9uIGJlaGluZCBkb2luZyBzby4gRm9yIHRydXN0ZWQgVkZzLCB0aGUgUEYgc3RpbGwgaGFz
IHRoZSBoaWdoZXN0DQpwcml2aWxlZ2VzLiBJZiBhIHVzZXIgYXNzaWducyBhbiBhZGRyZXNzIHRv
IGEgVkYgdmlhIHRoZSBuZG9fc2V0X3ZmX21hYygpDQppbnRlcmZhY2UsIGV2ZW4gYSB0cnVzdGVk
IFZGIGNhbm5vdCBvdmVyd3JpdGUgdGhlIE1BQyBhZGRyZXNzIHNldCBieSB0aGUgUEYuDQoNCg==
