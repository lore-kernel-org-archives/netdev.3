Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793114399;
	b=fG1qQeT4Y422ZNcp4tofhr890N4p9Q/rhZ5gzyKqI4sXsDPV3+LjFPYBcAZGivogpH3Q
	 93vFQhUcWOJNb+1zhbVAkPfVMHmx5LeVnmtYblGRTzxeWufI4aOMfjJkBU4TCu1YH0MHO
	 G6noqQZ/ArcM3rjk2Xh/l4fS0DaXZc5LIru2JY6rsTWaWixt0Y7Qyk5Qt4tJ3RpclEo4P
	 ciV9E1DYc7cENMxZsBAzvOkTbyQQ+/uPN7rVcxzhLgIdgSo/GLp072IEA/DFuvVqv4GaQ
	 bppSxCBs2X5K+gzTWp0qI1EIv0wzsUV/uEEB/DktIjZcRzddnrAoeA1lgD1tS98J25A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114399;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=W/3e3Ku895xbllyY46UNyY23e2yvYzAn2AGZj5Qjdyw=;
	b=SrWggkpcQdV0FrktK5SjmW7ThBagyd7Cf9d35C0fvegA9jRZRv+IE1U5oHwhJSEHb9NI
	 CKr0DdVULxN6LvhPIv8i9MPdXGzJAf454Se2NJ0uBDsNzo/UiLBHqhjmm6z0SWrQZyEjG
	 F1IlSR8SP7Hj7syd8sUQBqLFd7HMxTKk/5RZMmmd+lIJi91iGT1J4iVMaaferszKw++DA
	 Jjvl9bUVeRa9Xgblgk3LxDOtXSjvmkR4PMAJfM6lbKdyDZ4uYOiEHheHB+UHqcV24tcE5
	 0+PHz+gAct6IZpc6MxrpWB8mvNBB7+6h9xaUZ1+dPwqNqjaSS6DIJkntXgAmcLayePg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FEx2P0s2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.20
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6D606A324;
	Tue, 27 Oct 2026 15:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C6D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FEx2P0s2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNPNqYZzNQzWdHS99zPShXVj5u8Ff9jYpl5n4BkxW2OjP84cN2u6pcjCH9/J2DZRfLFco3DFCb4MX2ls3MFgaLoJ1tizE6gxpEkiKkNRW2VTl6zb66t8ce/dZOBOVO5HeawMPWQiUKYKppDfGJrHT3nzsIVWOI1OxIKymB3FL9Fjmr24bnH5NZbNJFd3Z/0u8JDxQVPqwVHKi9JWSqEtknp9auI2eaZyNAViuRotZSTl6KhSMqkhpitI5it03PLDf2Hb/IC2l0ZqKIZfVCCtmHKKWDaqGFkr/1n4esNYxvy50ba3naesj+1lY9rz7fx3huZgRdkV7GmyMH4ELv7NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/3e3Ku895xbllyY46UNyY23e2yvYzAn2AGZj5Qjdyw=;
 b=fNW8KORTgl1Y9NQODi2tA0VaspKehn+ibClUMyjQLecIo4n9KgDeCHhbgN56opz2bXsTXraiMQcJqVH5W6J03cECfoXm18Ac6ic6ydH+3orZqZf9zU7Q8dWY9Pspt39CcgQBcaK2lPoSM8W3n16+ClGmjJI+VVwWbWl/hpd01wYkqK1rg0Dn7AUT4x4u0J9UsmKJtyhKM0f6ypLyYkJOsZph0EllJcDP2NzhvtEDBmGzkQA1HzuruBDuOusKpLD4bsBsCi1HyBhHEjHrv3uMakxho9D2H9iveGLewaQ/DqrQnpLZk4kAwX50cUNEnozzoyeD3I0f+Yt8ohSHS3TP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/3e3Ku895xbllyY46UNyY23e2yvYzAn2AGZj5Qjdyw=;
 b=FEx2P0s27bhoDrQnyaguN29HYpA/IABK73Yeygm6qSg32dahICKdeNUWrlJS998stQXpx97Eenr35cSwyV/Akt2DvDs6jLVo2l6hdmmo6GN8NT75w8qI11/1/WofqYwU7qMeaDjTaKpw7zclg+wJyamO3oRPuD+qApb9jAl/q1iwmZsZEJX2NE5pswrpdsKj6bIolicGZx86mTgkfWe6NS5JtrKeerBWx1YfYrL5L0CvS1dyQDiT+BGZwqAf6O3YdBnUUlS8+qEOLdaA8Ds1gLCZQX60vrpeXg+VP1WfWyKZEs/2PW72J4D3W6hYAHpseepkdBigQfjV8+dazEpOhw==
Received: from DSVPR12MB213845.namprd12.prod.outlook.com (2603:10b6:8:4ff::8)
 by LV2PR12MB658628.namprd12.prod.outlook.com (2603:10b6:408:3ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:19:55 +0000
Received: from DSVPR12MB213845.namprd12.prod.outlook.com
 ([fe80::2c77:33d4:dc67:a568]) by DSVPR12MB213845.namprd12.prod.outlook.com
 ([fe80::2c77:33d4:dc67:a568%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:19:55 +0000
From: Chris Babroski <cbabroski@nvidia.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"Raju.Lakkaraju@microchip.com" <Raju.Lakkaraju@microchip.com>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Topic: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Index: AQHdX+ertnRhpLrKkkiyQk+P3vhTELcRiuBA
Date: Tue, 27 Oct 2026 15:19:55 +0000
Message-ID:
 <DSVPR12MB21384528E4F939AE07EAEADA46C6602@DSVPR12MB213845.namprd12.prod.outlook.com>
References: =?utf-8?q?=3Cbf487e5d01fe6352069d4314087f680fea717cc5=2E17920084?=
 =?utf-8?q?04=2Egit=2Ecbabroski=40nvidia=2Ecom=3E?=
 <179242764415.3135.15367182924729818631@kernel.org>
In-Reply-To: <179242764415.3135.15367182924729818631@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB213845:EE_|LV2PR12MB658628:EE_
x-ms-office365-filtering-correlation-id: 1c86be12-c614-4af6-aad5-08df343dc153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|261026121527099003|38070700021|11063799006|56012099006|261009223027099003|261022075727099003|261022105027099003|10067099003|261021121427099003|18002099003|6133799003|22082099003|261026140227099003;
x-microsoft-antispam-message-info:
 /suxJrhUs+lKth3Q8/WzeCjd8L3KAG7Ng/DySO+qUcpMflCz+CGk+/2/If5u8cx1WpA2/5AIb1yA/4L4pXYc+9nRMuTeGzL75ZXQ8ZKJuRisDbu6TwTfjS2PbRbNMDXsu0aQUaKBkBwkQb1VlZ3hyvNtSgEqJ34PHjLPRjTGhWFU3hfLA30fBXqF6qqJGT4dOuLOMx9Rf7Uy1xbLAJy0znWuDuEfGB7xcUCySIlD4iqpQ0liUN7fWOUqibY1MMycphoE4cJtdhnteeb+Lsm4wBHRl/nHfdl3cbwnmhn1iOGWn6GjleqoauotpoVqEslH/p47sJa1cH0q0hCW1XqOiH5JP0LLl1OEW45PGKW7b8UadMtSmWGUG2rOE8gr0VEufj3SVVQpC9o1mSbAb+ksVh2pooD7+9Ul5kbqs+XOH7g/S80nxfsP/tOZFpnOBWW2s9ci/chYQwzc1qZZQCRZhfYQNh2wJplgFeV1IvAP7YrSAHCybUTajlROfRjIPHv1yiHuQKks+j7yr4nE/UMfhPIQLU17nPC8M0k330MBN5UkYztWuN3jwTWNv5AVikqftwKa8mMh5gjYnRnfzI0OS9sHF0PbsNtCsMBmFTFaHm4EhbpJwKNMIab4MusH/qeApu5pMc1BG2uVAuUsAwwwwD0+ZZ2Ii2LjzFP8BMcmklu6v/Kb6aa+g96jGE6cgZQUcUTdKISmkecyRXe8pHCgyC4Yqufv/wTPX4vvzIVFUDc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB213845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(261026121527099003)(38070700021)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261022105027099003)(10067099003)(261021121427099003)(18002099003)(6133799003)(22082099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODBxeUZFZ0xoZjZLTnEzcEd2Z2lZUGtvZEF3Rlo1SzZWTFRYMHF0UVN0ZTJn?=
 =?utf-8?B?Z2IvOXVrM3VCRnRYSmYxRDI3L1gzQkZPbldjK2VRQmxyNVFyWldvLzNubWFk?=
 =?utf-8?B?RzJwdU96L3JPOUJsVFgzY0YwZW5DL2JhYVo1bFJpRGxiK2diR211NHMrcW1m?=
 =?utf-8?B?U0xpb0prY1RPTm5KTis3WWNyb0FpOUtkRnAyZ1RXcHUvb3QwcmNQdG9pUHZT?=
 =?utf-8?B?Q1RBQllGZHZlSDhZUWtCVmoxM0Yza3BweURjd0RPTlNpQ2IzWkFJbDluc21m?=
 =?utf-8?B?UjdWaGk2Y21hbnRaSFcwR245M09Db3pKWHJ1dHZ1R0dYemlHOTBnUFZiK3dn?=
 =?utf-8?B?THhKZHovOHFJaHZ0QkpGYzJuYTNVOGVRa2djUzdnOVdjOXBHSE9kemliMDJT?=
 =?utf-8?B?YW41cDJsQlZHMGZUbGJ3YWplblIxcVpWaFpRTHBpVW55K29VcjZDMXlGUG14?=
 =?utf-8?B?R3loRFdlNStCYW4xV3Y1cVNxcC9XZUFJeG9NQ0lHZTFzQmJ1QSt5Mjh0aDdw?=
 =?utf-8?B?UHJIdWZHc1VNZW1YVC9lS0VyYXloU0FVV2lBdFpGaURLbXFXeFhOMXZpcHY4?=
 =?utf-8?B?QXlkTzFOMGg4MExRclIzK1JKMXVOS01SQ250RWFmZDNWQm4zeVJ2enE5ZG50?=
 =?utf-8?B?bkR6RSt3RkdwWG1hRHpUQWtEcFhzVHNSdmM3UEx3ZG1hTm4vY0dEZjJWU0hr?=
 =?utf-8?B?MmV4azNkV2llaWpWSnN4K1BmSXNlTmdMbGU5bzJGRDdCckRjSExLb1B2cXV4?=
 =?utf-8?B?Z0VMVDJ1Zi93UUkxbHRwZStDR0hNWTY0Q3VPSHFRaFQ4a01tSTBXdmRXcXh0?=
 =?utf-8?B?Vi9rWk5UbWMybXFFTkVxdjFETGhYd3VCd1puQ0J1d0M4eW1UZFFUcnhGZVpG?=
 =?utf-8?B?ZHFENU1kS3dDRlV4UHVBTE9SZ2JnRVk5WWQvU2NmbjZEZmdyRUxlWHhvZ0Zw?=
 =?utf-8?B?bEFaa3I3VnVWYXc3VHZwNG10VEhhSVhPZjV5bXd6RTYxWHp1YzNhQ1llZmRV?=
 =?utf-8?B?bVF6UFcvL0VkMTB6cUlPcjFzMVMrSEI2MjJaQ0lPOTNMMHc4MFV3cjRpL1ln?=
 =?utf-8?B?Q01ZeGpRS0c0R1IrR1QwaU14RlN6cEtxai9zYmhTWVd6a0J3Ni9rMDFIdVZG?=
 =?utf-8?B?NnlRRnp4eHVlb0hUY3hEQmZGRFdxRTErcXVCUlVtSW1GWmZRTWREWm9HazJp?=
 =?utf-8?B?ZkI0WGY5Z3lxb3J4TjlOTGFSOVliWldVcGlaQUpadUZLcnFORDl2amY4bStu?=
 =?utf-8?B?V3dkUFJkQ3ZtZ2lRamVWRTU0OC82cU9wUWRrTjFRaXFVQmJBbkNML0ErMkQr?=
 =?utf-8?B?N3FiY3R2b05HUXpRYmptWjVmcmxGSE8zV0NzQkowQnFSemtIQ1hoUzR1R2VY?=
 =?utf-8?B?OFhEa1BJUWk3YVhTaTIzcCt1S3hRSUpqMG5vbG45Y3RQai9OS2tkbjdSaTlN?=
 =?utf-8?B?U1FKdE9CNUlyMmVNeWgrQ3hLbzQ4N29TbHBuTlF0VjRLV0pTVUlabmFjT016?=
 =?utf-8?B?ZEI0SDZRVWxJd09uTVYwWnFXbXQ1ZVNlYlczek1SODhTSUxFWkZMVmZlaUtD?=
 =?utf-8?B?S29qWDRHZnE5TllGMGFvWVBxQWlvd00veEZxTHJqTU9HWDZ1Vy9TRm9MbEdz?=
 =?utf-8?B?NTlVTWwyWGVSSmxmTVpRbThuVlVwaWFrNUdMNDhTVWdUREMwU3FMbG4rT2li?=
 =?utf-8?B?bG45bThoRERBTSs1WUZsQTh1QTlhRTMwYWtrMk41WVZxUG1QMWhLY1R2TEM2?=
 =?utf-8?B?aFkweUptN2laazdJQjJpSDVUY3ZoSWs2eExUcFR4L1p5bk9wclordS9keURt?=
 =?utf-8?B?QksxT2lRWG0rNzlyaVJLY1R3TGg0TDRTdzBhMkFSWE5YUUc3Z3l1MktQb3g2?=
 =?utf-8?B?UitrMXJFKzl1ODlKUmQvYkd5ZndmdnlnMFJ2aUhNb0FtaWMwdVRRck9wWUcv?=
 =?utf-8?B?SkxkdWNwMHpCWW9uSVdDZmR1OEQ1Y2VpcXFicXlRNERpNE9HQnNCUkM1SXpW?=
 =?utf-8?B?NHBQbXEwaHlWay9UeDhqNDhRT2hrZ1IwT3NFQm41eitKNjV1S0tCWUVmbzU2?=
 =?utf-8?B?MndhL0hvMjBOajFmNnFJcEFwS3preWtEN2ZjU1RMRzF1RmR1c0FXa2tKY2Vs?=
 =?utf-8?B?MjNuTk00V3M1NEZKMGgyVHE4WWZETk0wTnl5Zis1SWdZTThIVVFDbnQ1bFM0?=
 =?utf-8?B?ck1IV3R0WU1zVnJ3RmpBVDJCaWZGdmNzR1JSaGFBdWZqYnBVTmdSOFhVeHVj?=
 =?utf-8?B?RnZCK3BJdVQ4bGpac2JFM29KKzZabHFzbGJ1cVVlcjhWZGpUMTdwWFdNNEtD?=
 =?utf-8?Q?So6/LSw2Zt88i5pe3x?=
Content-Type: text/plain; charset="utf-8"
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB213845.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c86be12-c614-4af6-aad5-08df343dc153
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 15:19:55.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 540rIuDaNM+ugNf0apdTPU/3Xqq2h2XISWhTBngLu/+/wgCdVEBGlnn+jilu4N4/ZcLsq8l6AIdgSV84R9gITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB658628

PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFdoYXQgaGFwcGVucyBpZiB0aGlzIGNoYW5uZWwgcmVzZXQg
YWxzbyB0aW1lcyBvdXQ/DQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5cyB0aGUgc29mdCBy
ZXNldCBpcyBpc3N1ZWQgImFuZCB3YWl0IGZvciBpdCBiZWZvcmUNCj4gYW55dGhpbmcgaXMgZnJl
ZWQiLiBIb3dldmVyLCBpZiBsYW43NDN4X2RtYWNfdHhfcmVzZXQoKSByZXR1cm5zIC0NCj4gRVRJ
TUVET1VULA0KPiB0aGUgY29kZSBvbmx5IGxvZ3MgaXQsIGFuZCBsYW43NDN4X3R4X2Nsb3NlKCkg
Z29lcyBvbiB3aXRoIHRoZSBub3JtYWwNCj4gdGVhcmRvd246DQo+IA0KPiBsYW43NDN4X3R4X2Ns
b3NlKCkNCj4gICAgIC4uLg0KPiAgICAgbGFuNzQzeF90eF9yZWxlYXNlX2FsbF9kZXNjcmlwdG9y
cyh0eCk7ICAvKiB1bm1hcCBhbmQgZnJlZSBza2JzICovDQo+ICAgICAuLi4NCj4gICAgIGxhbjc0
M3hfdHhfcmluZ19jbGVhbnVwKHR4KTsgIC8qIGRtYV9mcmVlX2NvaGVyZW50KCkgcmluZyBhbmQg
aGVhZCAqLw0KPiANCj4gVGhlIGNvbW1pdCBtZXNzYWdlIGRlc2NyaWJlcyBhIHdlZGdlZCBjaGFu
bmVsIHRoYXQgbWF5IG5vdCBob25vdXINCj4gdGhlIHN0b3ANCj4gcmVxdWVzdC4gQ291bGQgdGhh
dCBjaGFubmVsIGlnbm9yZSB0aGUgc29mdCByZXNldCBhcyB3ZWxsPyBJdCB3b3VsZCB0aGVuDQo+
IGtlZXAgZmV0Y2hpbmcgZGVzY3JpcHRvcnMgZnJvbSwgb3Igd3JpdGluZyB0aGUgaGVhZCBpbmRl
eCBpbnRvLCBtZW1vcnkNCj4gdGhhdA0KPiBoYXMgYWxyZWFkeSBiZWVuIGZyZWVkIGFuZCByZXVz
ZWQuDQo+IA0KPiBsYW43NDN4X3J4X2Nsb3NlKCkgaGFzIHRoZSBzYW1lIHBhdHRlcm4uIEFmdGVy
IGEgdGltZWQtb3V0IFJYIHJlc2V0LA0KPiBsYW43NDN4X3J4X3JpbmdfY2xlYW51cCgpIHVubWFw
cyBhbmQgZnJlZXMgZXZlcnkgUlggc2tiLCBldmVuIHRob3VnaA0KPiB0aGVpcg0KPiBkZXNjcmlw
dG9ycyBzdGlsbCBoYXZlIE9XTiBzZXQuIEl0IHRoZW4gZnJlZXMgdGhlIGRlc2NyaXB0b3Igcmlu
ZyBhbmQgdGhlDQo+IGhlYWQgd3JpdGUtYmFjayBidWZmZXIuIE9uIFJYLCB0aGUgZGV2aWNlIGNv
dWxkIHdyaXRlIHBhY2tldCBkYXRhIGludG8NCj4gZnJlZWQgcGFnZXMuDQo+IA0KDQpBcyBkaXNj
dXNzZWQgaW4gYW5vdGhlciB0aHJlYWQgZm9yIHRoaXMgcGF0Y2g6IGZvciBWMiB3ZSB3aWxsIHJl
bW92ZSB0aGUNCmxhbjc0M3hfZG1hY190eF9yZXNldCgpIGZyb20gbGFuNzQzeF90eF9jbG9zZSgp
IGJlY2F1c2UgaXQgaXMgdW5uZWNlc3NhcnkNCmZvciByZWNvdmVyeS4gVGhpcyB3aWxsIG1ha2Ug
dGhlIGNvZGUgYXBwZWFyIGVmZmVjdGl2ZWx5IHRoZSBzYW1lIGFzIGl0IHdhcyBiZWZvcmUuDQpU
aGUgcmVjb3ZlcnkgaGFwcGVucyBpbiB0aGUgZm9sbG93aW5nIGxhbjc0M3hfdHhfb3BlbigpIHdo
aWNoDQpkb2VzIEZJRk8gYW5kIERNQUMgcmVzZXQuIFdlIGhhdmUgc2VlbiB0aGF0IHRoaXMgcmVj
b3ZlcnkgbWVjaGFuaXNtIGlzDQp3b3JraW5nIGFzIGV4cGVjdGVkLg0KDQpDaGFuZ2luZyB0aGUg
b3JkZXIgb2YgbGFuNzQzeF90eF9jbG9zZSgpIGlzIG91dCBvZiBzY29wZSBmb3IgdGhpcyBwYXRj
aCBzZXJpZXMuDQoNCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3Rp
bmcgaXNzdWUgYW5kIHdhcyBub3QgaW50cm9kdWNlZCBieSB0aGlzIHBhdGNoLiBUaGUgb2xkDQo+
IGNvZGUgYWxzbyBkaXNjYXJkZWQgdGhlIHJldHVybiB2YWx1ZSBvZiBsYW43NDN4X2Nzcl93YWl0
X2Zvcl9iaXQoKSwgYW5kDQo+IHRoaXMgY2hhbmdlIG9ubHkgYWRkcyBhIGxvZyBtZXNzYWdlLg0K
PiANCj4gQWZ0ZXIgYSBmYWlsZWQgcmVzZXQsIGxhbjc0M3hfdHhfb3BlbigpIHN0aWxsIHByb2dy
YW1zIFRYX0JBU0VfQUREUiwNCj4gVFhfSEVBRF9XUklURUJBQ0tfQUREUiwgVFhfQ0ZHX0EvQi9D
IGFuZCBUWF9UQUlMLiBJdCB0aGVuIHdyaXRlcw0KPiBETUFDX0NNRF9TVEFSVF9UXyBhbmQgcmV0
dXJucyAwLg0KPiAgLi4uDQo+IGxhbjc0M3hfcnhfb3BlbigpIGhhbmRsZXMgdGhlIHJlc2V0IHRo
ZSBzYW1lIHdheS4NCj4gLi4uDQo+IFNob3VsZCB0aGUgb3BlbiBwYXRocyByZXR1cm4gYW4gZXJy
b3Igd2hlbiB0aGUgY2hhbm5lbCByZXNldCB0aW1lcyBvdXQ/DQoNCkFzIGRpc2N1c3NlZCBpbiBh
bm90aGVyIHRocmVhZCBmb3IgdGhpcyBwYXRjaDogaW4gVjIgd2Ugd2lsbCByZXR1cm4gYW4gZXJy
b3INCmFmdGVyIGNsZWFuaW5nIHVwIHRoZSBwcmV2aW91cyBpbml0aWFsaXphdGlvbiBzdGVwcyB0
aGF0IG9jY3VycmVkIGJlZm9yZSB0aW1lIG91dC4NCg0KVGhhbmtzLA0KQ2hyaXMNCg0KcHctYm90
OiBjcg0K
