Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792591390;
	b=3+zoSmcxhm1e2oLn/u2jeFBw2xusnb/b+CMiQGOG7eYVtpygxHU0Y/hHxgg0O27jEpJV
	 FKsZQ870wqQlURYBbWXi2J55uwN9efBwr7tPK9VGUkaw+WxesBIEcWF5Tcsw0BN+M/8ps
	 kfElN0QDc35bDNjgIYQJyHK4frDqA4QIEJhRjRJ9wY0u2P3hEF0ZSxHyXVsz++zOqkmTx
	 7Gd9BgswIAjpy1quEeYkdx00gfsRQ5ilIVO/cM5AQoyx0Jz+Xu44IX3kVpJdjvcevAePi
	 IaoO6Oo+SuG57yEczMdQrGgeYapKSiMHg+B1kC4tDLyqWL9XA2HyPrZPIBXa/BOvabA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591390;
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
	bh=+n0j+yhYMA2Y+Wp1ygeb2ZmEGuYdZIBzhNIeqCJv7R8=;
	b=wzd55kBm7Cg4+EWOM/afmc5xVkNExoJg9IKKiBbLjpVvvfHV07aPoymamCAU/yn/B/f7
	 NJ7pD4i9TvhKT46e34tuXvvQfpXIjVpUUhhlSYG4CWif6wexE7UfLTx7ngBqEP3z3t+qa
	 KAvBREB68Vbap3w/Qu2ZWkOqAdXucb0d2nGngPyAJJVDBtwhxNzt38GuCcl1yvPvN3eVV
	 4whpqRna6gMY8TziJv4rHUTAhT4YvKW2EmS9QzLAth5/Ovx7bWaDL51v4WJKWZs+Xp/uY
	 f60G4e5qCVbGqIaTA08Z2uOAGIcy43ovLQETg7Z0TiYHHrWojg3Gdwn6hCWKQuMsdRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L7Xe9hBX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF15606A31A;
	Wed, 21 Oct 2026 14:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AF15606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L7Xe9hBX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNw09ZGRyZgnmLcbHnjxYOBokFO+P/InJLeGA2s0DnAxlJe+GS8mZW7wFsRd3/mi822QA+ABeUZc9CNF2G0vVWm0A8DyWR8QWCNH4R2HVXW0OLovG1nkCaKmFEby3tjj5+zfDzmub6GK+uHqOGxOsjVr6kOp16xprnBScnAKoQmm2+VhQNtoyAr2zECHxmKwybhaeNX9MMd7kOTnBn5LIsp+ilf2R7SaAGufSnZ5KrlVTAzx0ltwCUAa/I8SZWH8GFmSDSpF8bFI80IDUk1Ae8KLPK+URowKoxUSUj4aApPpwuc0Rmni/STC7DjF3ScZcPn4K2QjIF10YxbADh4sAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n0j+yhYMA2Y+Wp1ygeb2ZmEGuYdZIBzhNIeqCJv7R8=;
 b=PnuAPy6fdR5Ef7vWLsFhhFpQ2F0g/oy+iLTer5UXeeVnSpwicabkb+6TwuOecuzMM84/wAET7heZuyRsfKZtJRCpfu91U0/EYnqMI0ozTj0XLry7Sylw8CEYTj0DW12HI78Wtb3yHewjr8qpL/UbGwh47zPAYHPWEtHHv6JAM+P38d5c7BKKZH9X8rXBrIOD0bdrLUE88ZDl1riNZIgrGgsUyRIUgE3JCPHI+4CTvPgsb96jb9phfNCHnW70MOm05ZPdRhBzZXbze+jrbt2eCy9f60VrvuvhCV1olNdxRbD5k34IjdzJCTImYDk8M3JXgyw31OpF22x8PdgvHKqZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n0j+yhYMA2Y+Wp1ygeb2ZmEGuYdZIBzhNIeqCJv7R8=;
 b=L7Xe9hBX7RBzMSK2w67ZIRAaZdNI3z/BApjfp1j6sYtEhMuFzZTRtXwCp8armbEH+MlgZquzvEBJjE45zEEvyQLJZBuY+n3c6huH3y1WJaQiv5Okfi+UQwfeAwkM+0d9iYdKWExLtT0bvZa3mieWK//wWQRFnKB/HnLIN17jvBSBmNGBLaWfpm0NUUMNVVv7CNw41My0hxU6xzWJJ04nYLkdHxOOVCYpieZCJXXGnv1kpc+EVDDOJrwTnSd/c+sMv95ztlSU8bvj/170nJT/uRU0qhX0siR61Mgt2ZkUrTy+AE8hrqaX6hinTq+9/Ugw1sn28V145XcPTXvtL2+X6A==
Received: from DSVPR12MB213845.namprd12.prod.outlook.com (2603:10b6:8:4ff::8)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:03:05 +0000
Received: from DSVPR12MB213845.namprd12.prod.outlook.com
 ([fe80::2c77:33d4:dc67:a568]) by DSVPR12MB213845.namprd12.prod.outlook.com
 ([fe80::2c77:33d4:dc67:a568%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:03:05 +0000
From: Chris Babroski <cbabroski@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"Raju.Lakkaraju@microchip.com" <Raju.Lakkaraju@microchip.com>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
Thread-Topic: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
Thread-Index: AQHdXLXD7DNPHlOQokaU0yMKSD63mbcHN8uAgADW7jA=
Date: Wed, 21 Oct 2026 14:03:05 +0000
Message-ID:
 <DSVPR12MB213845196A32143D100A233BDBC6662@DSVPR12MB213845.namprd12.prod.outlook.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <20261020180757.0d08b6cb@kernel.org>
In-Reply-To: <20261020180757.0d08b6cb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB213845:EE_|CH2PR12MB4133:EE_
x-ms-office365-filtering-correlation-id: b6f31b9e-3b06-494b-771a-08df2f7c070b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 OpqreezWkHKE4nJ9gimPKmvD+HjcMnE4FVBxpb1lBl7umjVs/35aQ7RZy8Vcu7O9zAbR57yODbPf6O5gaZdx2vmOCet2ogUwabtQhbsU/WWyHt//lSY+KHgzaZ2yk0EelGZmymTa/2B/Iy6DTEWc7Ga17dsm6REisO4DX7lelXXCA9XeFzp2qVZEHRjfReqWZHV4yL08hV46wJZKK83PX7EJkykW8fgAJbl9gssqvUJF9LcWzfFDf4JZSFIGwCQH/Mt/prTNk3+4mYSClk8y45pr4uNmA4X2dsQuit5t9fIytdo5ncEri1oFvAE+TMSh67/HoKpAyKMs7/lKYsSHq03SQSFU1KPps4SgvIhQl9kaGuWP5+kkWbhjiHHRtEgWc7tmMUA7MsckmXPkpFLynbTW4dIjRTTGg6yTCvAzJTYZiL21DpdyMq9U+fjvQ94SMOUmKFKahRrhrEvassvibD/0pseBssvz7mEg6GE7NimPdMm2RVv8gbi6cF7hN890kKBTN63GwoRqsCFpu0Q3Uj7kZtMDx1xZ8eFfyusJk7cM1ePmlxfLLL98NTa3HQAuoyYnu+O/S/SqMCcTOWTHPPiiR1rNAe5CE9SMZxqrZsIERbpG1qxxhv10XCRqvbK4Qf+6YQQTfCQeVYuC4jFL3ksKu4zZ4lJC+Hu3GpK5Wuk+OVE/AVuoFXXMvDwW82+U7ORJejONwJ5/b3KW7LTv3S6mfo+IiaVUsaL801RAFRI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB213845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VjCQVicCi9U5Ff6nd302DN436VCWTlYCSdDjIx51+jJ/VO5wvnWUdh3jiR/e?=
 =?us-ascii?Q?QXDHYQqW0O/ciowXLgaIqZ9/iJdM2/jscyW3OZQQ7K+glL0vgqL4o8iIH0N2?=
 =?us-ascii?Q?UtM4xsHpl+dKmZhn5vWVuH43K9ApjE8RzfieAgKsSAXVg5fZg5/w4SJfXLcL?=
 =?us-ascii?Q?WeX+VJ37aMboGfnZoQTZcAopSDyqdjIPJJdvAUuZ/BfyVCkf3Hh3yVKHKT+L?=
 =?us-ascii?Q?VRZE0hBFAdMMOrUWdryigPyY9ExVhDJm5GH95uUO9X5MKLoVj9V1S9jnrf4M?=
 =?us-ascii?Q?r4zNH1a88mojDBe5yGWo1+HDveRueT0x4GaSMQARcJ/zfuoWZwAlNq+S4VV8?=
 =?us-ascii?Q?1uWsUAyhmdzAkTjjHcA2MrpTR0KGrwK676uSo32UAfDyE6sFGYDlgwr65QT8?=
 =?us-ascii?Q?bheTGicduPQ1YlbPlYI1DVpsqt6ZiN1H7eFS/fjmD9B4p+nVU9M969WqIx1H?=
 =?us-ascii?Q?/Cs2FnHECif3ms9eXEIVPhCR3wKU8/eaINKXdxauRXAyqf9seNg9areoVnaY?=
 =?us-ascii?Q?AIGBO94lx4j4DUcGEQSkeXghmcKxrvq+/wwO1B4g6nBCA1Mcu/9q4dX/X7L7?=
 =?us-ascii?Q?iMTW9RdPu4tQXMxbR/NkWsR1XUvdKYZWGtl9JZOEqG4aigZyD9L+oO6VvAne?=
 =?us-ascii?Q?AIHKkrWyKx3lMYVafEV1cWPdFDRWazKmx27SRoJ2j6DbwOoYdIcGvPPpx3YZ?=
 =?us-ascii?Q?hHkKEZ7YjzJZg+xVXNJCsFWylCUo9mHESZt+8WBxofv7Qm/F+1+fT2tAYM2W?=
 =?us-ascii?Q?xwZTdxEwZxjSw/5fR3WOmREJMhaILy6a3lXeJMPFecbNAP+aOeuu4YDoWP2Z?=
 =?us-ascii?Q?pXlQv6uJxnMbEE0rMflJ0mQfkFzieZU3yCI1vdFm7HnDrWoFxrOE4IHLu2i/?=
 =?us-ascii?Q?a4nlMYttKIqpQkI3jS9snhz5w+p5RbuIQF4YSIBt3QmkKSzxUQfMyMiESIXJ?=
 =?us-ascii?Q?URd3skRdki7zUlYly9Hxzz4yBlLEo9wo4f9moSI7MAu5cDSzc0YxlUBZVl/R?=
 =?us-ascii?Q?VHizBQX+/wL8wHS3cOlt64cfplj5BAtv+5O6/Wpy82tyeDcYQWdgv/GWJK2j?=
 =?us-ascii?Q?BVnz6iLfKECSoZDuic3c+T1hUbyvVUT+w81keXzSyAU82bah2bGT8L0tK4zx?=
 =?us-ascii?Q?FEsUw1DuFhZGYyuldG2mQZ2HZNszmd/48CNNmeQfUKQiH+8i06RQcdblZJOm?=
 =?us-ascii?Q?ACYHQ7x+88CZ0+ratgA7Pq0V0XFBhzDC5Aw8fIieog5Q2qoiuA2FjSYl9Z8k?=
 =?us-ascii?Q?8q9x02xTb/tMA4R2JWJ0VQ6C3l1FYqJ68pm64fgAvhCY017thnfGxYGetYNK?=
 =?us-ascii?Q?txnN5tCQLhl1LRt5y6hOGiaxA1VC7pICF9jwXRQYiGgsjo1F+aZzPm8f7n46?=
 =?us-ascii?Q?FdiBhqNdPNUkSj/+KK2+6+SqESKSPZ39lcqfSEjCwBj3MLUGxA3VQK/wzt4z?=
 =?us-ascii?Q?BKD9qrSaCCgFyo2p+1Ak5+sapSctElFoJUia6MRXbEBhrZwMIlN0D0zEUvCz?=
 =?us-ascii?Q?MumglCDOM4YikmuaFVj+jVHBhn2dUA3YxB71YqseL8tMeh856Vxo2EcgJqxQ?=
 =?us-ascii?Q?dXeGeaQriR2bai4IUrP5abwcUO7CqDyIjdweR9zRWxJ1F4U8oP6Z7I58g648?=
 =?us-ascii?Q?KcL1aUQia4Ko/YFeZY9QKE5Kid9QVXNYVBb1z4/2yu7JC3VYB8yLLsS47+qB?=
 =?us-ascii?Q?w4oIVgPLCPLo4ky4BrPSAThMxlFBqMoLWL4iCvezPX70WJw1ue47MkwjsoPd?=
 =?us-ascii?Q?gi5cwnpcDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f31b9e-3b06-494b-771a-08df2f7c070b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 14:03:05.0368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMOn8/P6bNP3JEn5f1tCzv5I37PaolexMUPLsL+WnIgD3Nq/bkzZuLPCbc6Xs4/RWFewKDdudQ4iBtKER9pyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133

> first 3 patches are sort-of fixes so they can be resent
> during the merge window. The rest will have to wait for
> net-next to reopen

Sounds good, thanks.

Chris
