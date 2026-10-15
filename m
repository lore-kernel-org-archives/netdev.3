Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890B261B8D;
	Thu, 15 Oct 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071122; cv=fail; b=Qpbrti04wPrUUPgNthZ4hDlfGR09S5wj0mCrqxxpDunZkkySdo6v8kfvzn5uLUfZnNdWmeExOtL3uGASJRGp7jBgppoY8XXP6QIapdwecsm8KWhrM3I/CamIOxIpjy7e5Xn40nhT8zGun+Ccf5dK7KsswkjHtkSR/s2/O3C4QqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071122; c=relaxed/simple;
	bh=T7nBmQ7lFLv9+J0Cua5K8JiPSLYRbqstXQD8PcDX4us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCsi95FJ97aB8xvx6Y0JUcYRawFgcYs/9T+W3d0JVHQKzOriIcdLFwvQxaSr+10JFeyy/0kWo9sYPJEaRlW1/7o5zUueErhSNuj4+FDolMHzJlX2XaKMmz1ccRJXPO6gBHum0hn0yGUWtfRfsenWM01vI3hd10KLHF7NOtEmBH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BRndIQDY; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BRndIQDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecQw/2kJgiQ3vW+vNMoaLZS5moJ7l/UZuTxFxyHDk+EMKVkeKre5jDbVaEyZYY2dSEUpzdGKLjbcy3NtuRgHsB7wnJ9gnFoRQ7NV2uFdcwrARc7vYlyL3A3htwItoVYvgoYBcpXNdzWd7BxqRrSmp7NmbI9Hjns1hTuZpi9lowxlw4blVwlvjzbyohmbi6WnTtBfO7STFci+E7isUcqueWyjIMewxusMHv64dIA1uVIjcmnbujf060hl03mM/0C5M4add9M4d2TowGyXJ10CCcHplJxKdbLFNCKJ6gqoFCDI3L22TV5vaseOq+3XeYiJs/GBZzaCgep/gOX5RKj6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7nBmQ7lFLv9+J0Cua5K8JiPSLYRbqstXQD8PcDX4us=;
 b=GMjeeUERmblAFNEDdVoXF1R3f/V4jf/SyFFBVxCeOJSe+2p6zZML5ywxpMaM7HfTJfLt6Znfqzo2KR6Zs7t9eVqYIZZOOMy7DTDmRZ7tPlhQ5EKNSBjOS2kHfKeRrBVcvouc391WsuriNWq0s/azXHfBpN8MLgJgyBPOxAt75OphVNvnKqAxvCXI22TEDQsErycLI6Czz6kS9iVqZKm3rD1MJq8EMePHRS9gw6y6dJSvaE7xm/hp8rVpW/TYp7q3+23UPBQXnaATyvyeJKI2Ss9alaOlZZ3zXGH6j9qHp4Px1mbXDwsGa8/f8CIY7oene57PAYjFjdJC3jQE0X+jAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7nBmQ7lFLv9+J0Cua5K8JiPSLYRbqstXQD8PcDX4us=;
 b=BRndIQDYD4LDMxFaYEYPeYFBq0FCDdy2ZUcUUxzsjPixg1UdMcpQmNrBJxDSYH4YqT6g3ElYK9oAOSSJHK4TgNBJnP4FlXSRL48ig5b/uVAaewhZOTLY23ySCP1DWPE26tqbM0pWDRYOUaItXIwbTu0aP3na3E6J9N1DrFrcaeI1Jg8KYvMDoJSd3cADtRwzSmgL0BA9EW1ZRvIIFkMC/TmsremL6cLMkLr4nJ4AI5hlREY22fmcy0IUVgZ0jwpl4j5PSQp1YTelE8PF9As1nboCfAZdVxE398e/FD+hTTLbKG8EPZbqeFG4ASXyjpnIhhOdjWkR8daNhcjIzZWVtA==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by VI0PR04MB11023.eurprd04.prod.outlook.com
 (2603:10a6:800:25c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:31:56 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 13:31:55 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/5] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v2 2/5] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHdWzYXCtJ+sMv5kEu9OLNZfqRlRrb91myAgADE4eA=
Date: Thu, 15 Oct 2026 13:31:55 +0000
Message-ID:
 <GV2PR04MB11740EA88D41475BADA25F116969C2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
 <537a977b10b3d76c30b1f879f423bde4fd6f42f8.1791908694.git.claudiu.manoil@nxp.com>
 <AS4PR04MB9338EE95020485A9C5C45BCD889C2@AS4PR04MB9338.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS4PR04MB9338EE95020485A9C5C45BCD889C2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-15T13:27:01.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|VI0PR04MB11023:EE_
x-ms-office365-filtering-correlation-id: 85bbd6a1-f132-4793-8b46-08df2ac0ae00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|22082099003|18002099003|10067099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 ggZca/CrvFdnh7zWCmE74ylsLDjqG5lUdux6ARnsGVZLsnEQMZ1smrcKfH1O6UoEHqQ0bqumCxVNq7T85VE7nFLp/ej0uy8D57R2DpOKDO4hWw5UVRaWqWyFa9L9QnaO91MHup4Yikf8Mux04oIF75mOF5C2a5dty+dVmwQjMs7B1uHzosmW5X/VBMkZT6ajVG7EjwPxLVlEjCuVDpspNyRAE74/N1AZMdNY31C7/K/pYpBxY/9xxYBmbGi4OSTKgHF6vEnyYAACxNH60jKxhnlfGdmxLwTLO0ewriTzIQ5sRfO1TpjyEovJm89XvbfJ+gvLxssrLOlG7J4aQa4kFrDgUeiYrCY+hFjjmArSFUZd78bwGJtqmTI2Dx+rxxgANJcVmJM2nQzWIHAjJEUFDnEwM1bVMyUkMgW5+IBtVuh238B86IvBsrB4tKQbX8PDgWq8GtFG8Nm45zaEAlFvEaVsj2lOA+Pqs3wTYlX8QLMIW/H90URGE46ALHBpc3lRNj2g1Rdy3I1lVGdjGYUXHs3aWyGX/kPKx12ppivnOEMQIP3hLWOZSkHu6JOXZEmyIaVXeFsrIJkZdHCFLDP8NgLa/3EkHYZsZiqcGoL/4a+nVZAbZYdmy4fIWrjop/Ir7aIMxDdLC/DqI4puNoLoliiUizZt1bFCnlKUxRbSilMrdmeJ+/p/bIxH1qURuI8xXsWHFfhJGl2hjc1o0PuKBSLRwr1LPy/qLcnnY1CGST0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2VUS0NaY2QvZExlYWZubFhKSmd6RDJ1aXlTU0ZyWk9YS0Z1ZGp2dkFuLzZu?=
 =?utf-8?B?YVM4dVBYemQzU3VlM3hTRS9ZQlU3Y1JzeGIvNlV6Y0pTRExZV0lHOHJOMUpZ?=
 =?utf-8?B?NUFNS2JJbW5RUGU3a01DM0xrbzN4c3pwR2w2YktXOXl0RlhHVkZhOEg2QkJW?=
 =?utf-8?B?RkpPdCs5cWp0bWlrcmJKclBHOVpNOWJJbUZrU0FMUGJDaG9zVFFiRWc1Qm1v?=
 =?utf-8?B?L1FPeXB2cXpPdTg0aFFzUXhFT1NPcG4wZzB1TEtES28rZFFkdS9kZWR3Yzdu?=
 =?utf-8?B?SklKWHpKU0Q2TDR0TUVyR3NMYk5JWnc3ZWFMUG9icVdTYWJJTG5GOEk2Q1Fw?=
 =?utf-8?B?R08wVmpGUVRlcVhGM25nNWZESE13NHVYQktoWXFZRXZmM0x4STlzNE5vR1lK?=
 =?utf-8?B?THZTRTZpaXFHSzUrTkxmcEh1VCtZcVVlK0lRdWdaRndjRUkwamMzR3hDSWVI?=
 =?utf-8?B?bnIwVzFPcjJhbnJYKy9OWFNSdUhRWkpONXRXdG9tQ3ZWYitqMVNyRXpnZHlT?=
 =?utf-8?B?TEdWUmJaQmFPZnlCOWliYWpFelFPa0ozUGx5K21LbVNUMHh0UVV5S2Q1aUcz?=
 =?utf-8?B?QWlKYmJleW9BNFZRNVZPY1Bmck9NMG51TkRYNEJneDVnVGFZdld6NzNMS1JP?=
 =?utf-8?B?WjJxVE91NnpoOWllbm9qZVhuZS94bXVXcmpoWm9lUWFEdkpTZEowcktaNU1p?=
 =?utf-8?B?cXZzemhZL0EvQTUxY2lVUlRkeXVBZHhFcitiRlRUNFJFWXY4OWd6S1FuT3gx?=
 =?utf-8?B?N3E0ODk4d0dvTWx4YjNZZ3Jka0pBRGc3UEdaSVd2djZFMG9oREpvdmxwaGlD?=
 =?utf-8?B?UFZwSGxsRml5YTZkOEJxMkhLZWx3eWpqQUpSYzNsTUlTd1AvbWVTVSt3MFll?=
 =?utf-8?B?cjZQMGRxajBCWFo3T1ExdnZtVlQydDIwUUR4a1FXdmcxRXd4OFp2VDZ5SHpZ?=
 =?utf-8?B?Zis2M1NuZFJKSkRraWpIdEpxUjNKMjNYb2JzSWhGR1dxbzArR1EwOUFwM2dp?=
 =?utf-8?B?VSsxY3d5dVdNd2NGNWZ3a3FiWXdwY1VQdWYwaDE0LzJhZk0zNGZsODNxQ1dy?=
 =?utf-8?B?MjVsS2o3KzZNdkZsUVFiS2J3N3dHWjVQZHdHNnVEUXFTUFFsNG56ayszM2Rx?=
 =?utf-8?B?VllqMFRtMjZ5dzlVSzVFb2V1WkExKzhHQ1BmdjB4U2EzZjdpcUFOMEVXUHRt?=
 =?utf-8?B?OUFpaWh5Sk4yaXdKaTBXd2tQblhHdlJBczRiWURZUW4zZWVkOHgydkRlYStH?=
 =?utf-8?B?MEE5THZGeCswbVh5WTNScWgvdGc0Z2xtcVdyK203ZHVQVmtaTTRhQkFndElH?=
 =?utf-8?B?SUovZDhQM2wwWnJlRHRLZjcwbU5DN3J1OTg4dGRFNUZ3TGNpcXduaW9zaHBy?=
 =?utf-8?B?OFJGL0VzdkJJS1pma2Ura082eGowRVEranNEZjlDVHRjaFZOQWdoS1hpajBU?=
 =?utf-8?B?VDRUVGZNUFlnTnNjOEJtY3dvSmluL0xEQlF5ZCtEemQ5QUEwYWdWWXRSTlND?=
 =?utf-8?B?SWZ4QzZjdG1DZzc5cE9BbU5FU1BzRlpPNUM5WkNmaUg0K25IM054T1UrVjha?=
 =?utf-8?B?SUZKYXRSQStsbjE0dmRiY2Q0a0VBS2dReHRmNmlYUmdFaUk0L2szd0pPQmtp?=
 =?utf-8?B?WW1DMWliL2REWmw4eDZVWkFPWk9wTldQUTZmNGZJSldKcXpnbVFabmxwUThQ?=
 =?utf-8?B?SzE5bWxVUjZ6U1hZK2h5SHNnL0pqWHF3bCtHQ2xIL1ppYW9oVU13eHN1Y0R0?=
 =?utf-8?B?d3lkcjgzbW15SXg3eldjaUZBVlNRY1Y5Z25kZTJtV3hpdzdWeEw3d1pvWDJF?=
 =?utf-8?B?YTBUUENjTHJ6VkZuZzJiUlo1N2tJSlBwbU9CUlZud3FEaDhidkxHeFliSlRR?=
 =?utf-8?B?L3FQQXZqaGtENkw0ZS8zUTBJV0lDRHdHcFRpalhXcm9NR21oMWVrNFo4VmpE?=
 =?utf-8?B?VExDSGt3elFaMmFNN1B0ZzUxWFFyOEx3a2piTEZHUG8vMWw3dUVwRmRvM0NY?=
 =?utf-8?B?ZkUvNndOQmtZenNIQ1Y2eHFOZ1k0Z21BMDBhdDdkcENlTjBYaUg4SSthaEpD?=
 =?utf-8?B?NkR0aE82aks3VVNBVW1lVS9XWmFaQTRTK05LMGYrSGNjT0wxNXhwSnpKbDdQ?=
 =?utf-8?B?L0lFdm1iL0hJOENyUlRxOU1qa1pZWnBoTVpwS0JtUDQwQXgvbTBZSlZxYmoy?=
 =?utf-8?B?UWduWTVKRkdBT2FKbE02NnhqcHJCN3BCQUxuckJzVExLL3RUZ0xDZjNlVWc1?=
 =?utf-8?B?eGJER1JIUjNyZkNhQWRlWnlrOVQ2KzNQOW5QT2dUTmxsTVVNSk5VL1lhUWVj?=
 =?utf-8?B?OFhJTnZYL2VUS2JXVzl0WFlvWXZqSFZPbCtZWUx3SVFhWTFSUnVOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bbd6a1-f132-4793-8b46-08df2ac0ae00
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 13:31:55.0867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFCu/7vPbRIfPcUtXhC9TNLY1poV7dZ29lMb4YfCiMJFSrBt7SdbKdw09BQmlZG57TY4x3pLUJFczZtBO2fnUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11023

DQpOWFAgQ29uZmlkZW50aWFsDQo+IEZyb206IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K
PiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxNSwgMjAyNiA0OjQyIEFNDQpbLi4uXQ0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIIG5ldC1uZXh0IHYyIDIvNV0gbmV0OiBlbmV0YzogRW5hYmxlIHByb2Jp
bmcgb2YgdmVyc2lvbiA0LjQNCj4gZGV2aWNlcw0KPg0KPiA+ICsgICB7IC5yZXZpc2lvbiA9IEVO
RVRDX1JFVl80XzQsDQo+ID4gKyAgICAgLmRldl9pZCA9IE5YUF9FTkVUQ19QUE1fREVWX0lELA0K
PiA+ICsgICAgIC5kYXRhID0gJmVuZXRjNF9wcG1fZGF0YSwNCj4gPiArICAgfSwNCj4NCj4gWW91
IGhhdmUgcmV1c2VkIGRyaXZlciBkYXRhIG9mIHRoZSBpLk1YOTQsIHdoaWNoIGhhcyBhIHN5c3Rl
bSBjbG9jaw0KPiBmcmVxdWVuY3kgb2YgMzMzIE1Iei4gSG93ZXZlciwgZm9yIHRoZSBTMzJONywg
SSB0aGluayBpdHMgc3lzdGVtDQo+IGNsb2NrIGZyZXF1ZW5jeSB0byBiZSA1MDAgTUh6LiBBbmQg
dGhlIHN5c3RlbSBjbG9jayBmcmVxdWVuY3kgaXMNCj4gdXNlZCBmb3IgRElNLiBUaGVyZWZvcmUs
IHlvdSdkIGJldHRlciB0byBhZGQgdGhlIG5ldyBkcml2ZXIgZGF0YQ0KPiBmb3IgUzMyTjcuDQo+
DQoNCk9rLCB3YW50ZWQgdG8gZGVhbCB3aXRoIHRoZSBORVRDIGZyZXF1ZW5jeSBvZiBTMzJONzkg
bGF0ZXIsIGJ1dCBJJ2xsDQpsb29rIGludG8gYWRkaW5nIHRoaXMgaW5mbyBpbiB2My4gIFRoaXMg
aXMgbm90IGEgZnVuY3Rpb25hbCBpc3N1ZSwgdGhlIGRyaXZlcg0Kc3RpbGwgd29ya3Mgd2l0aCB0
aGUgJ29sZCcgZnJlcXVlbmN5LCBidXQgaXQgbWF5IGFmZmVjdCBpbmRlZWQgdGhlIHBlcmZvcm1h
bmNlDQpvZiBpbnRlcnJ1cHQgY29hbGVzY2luZy4NCg==
