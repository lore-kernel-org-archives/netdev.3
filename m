Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792439353;
	b=rrYc57mJsVnhKIGVumVL2TU0pVuiK0fyUJvmSY0/CoLM/DwCCMwSSJAL7uPf5EzFmcY/
	 2AWgpPRvQFnLsJ1QPmgpg5Gpc4reR8RApxslJmdaOqyI6WnlgxTXmFdWwnyUUiDr7Mp4g
	 PhDM1/oniyasy/yVCbIhG/jCd3HzxVb9i/Sn9kBadCoGGj2qkyuQxN79k8UPqhy1KCMvM
	 u1VPi+clxWkppbPSQTKBE8hcg4WNu7J4dLqVOBCEvg7VgGrkr5ZuweEg2q4ob+N6gBqZo
	 jCCXHfP3Nb4XWj2xM1k76Zkl2WYY3eEys+O4+S7HZ4OOdFj2NN1+Ru3jN4/ZyqS+ePw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439353;
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
	bh=aco77vUL0atND8q+3AwB5GUWhEZt9pT3M6kDX+y7Tm4=;
	b=TC6RpgRJM85zRYYgNjLdX+YSQMIqmJBpMHGla3t1cVpAI9Mu9tJYyiTmyKFj3Jkw0x0W
	 KaWZLWmE7ms34Ui8rlYCwQlaAw/R2cN2lT2LpdW40Gyix4UKSVX43He2comw2WhF24X6V
	 7umRuaa72945MMeX4XROTvxajHR9Kkp88vldC3zfObDfscHLUG5vFLD2oGvfo4NVa9MtX
	 wBGa2oTQQcs5/Dw9vROBGtE08LW2y1XL0/YFqaOrHNJoofNW+UEFEXIRhAx55j+yix8pQ
	 uFpfAbrFISEw4xnhYgiNlchHWjHgnj1Lj3LnXbqFKLs4YSmY8fqu7Nly32z0aViW+Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=aQv4cauB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.37
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C7606A31A;
	Mon, 19 Oct 2026 19:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 959C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=aQv4cauB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuA0eX3u9ARBPX12rBB/+sP3ZobsyjDW/TGXACjKVWeLfgcfkcQljbK1m6YSZ7lK87w1SWeKoNylLAGTp/LWHNNJZrPky47EYRiN/oVir1STOAgUI63vqKgFwz1wWz27sEPAypCEWvF8Q/T+WMG1ExOfQzFXlvgcusqhEGiRpAig/0yDPA9b1XGls+tdK8Ym8vf2IoKqjbmvjCF6unTsc/suVmII4EXGlF1fQpwGwfs/ouG4FwQTxFKkUuFSW7BDkRcyJJaIkKUrYTmiSFhOD8l997JEMn+3zOeWa9QZEzK0EqNImwyS7hN03I4ivXrIXDSrArEEkyqziMdbYbttfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aco77vUL0atND8q+3AwB5GUWhEZt9pT3M6kDX+y7Tm4=;
 b=FkGKWoK1pT90HHqBLBTiSeThj+Y3SLT4dyzhmoaR7XK4h5llZbq0+TAHbv6yA9Pi1Vp/9mqRSKvsd23iAQ53jS+KXEN0nEvdGCrXJYYx7mcipxtcS6MRaHSEaYluZnJOH4fTwR5l2j7gKBURd0HkltNYhO3EG00RKdx2Dw7N4GmQwAPN27bJLROWXv9PXf99Sz9P0R5H4nIQCqf0C6X6bm15WEqYlUv524kHNNljk9gehjJ0lGpPk5cwUEvCkADjUbjYUW8JKrQzZzmMxfbrlVwjUjA9g6tg1K/0qN/mAP2RVrhI0i3cuBOW2qKGqM+sveXPW69YuftwcUDPdYcwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aco77vUL0atND8q+3AwB5GUWhEZt9pT3M6kDX+y7Tm4=;
 b=aQv4cauB865piXevLZbi9EwV40wCM+AvP8zYDk9JDqNWAu32nCWsfB0h1y/bGcTYtxNSs3TynoQnrgnVrjanuiqiyOqWDHXxc00wHMDsTOp7QvZvhMTPeZCfP0U88NrcMXXmPMseP+x3P0xMUzGdk3IWOulrzqC0Fe+doA7AEN1kzsqQkqlgyoIMvWweoKF8N4QH659fJgFUy3sCH/XfobF+inC4N3HvJYdR26x+3U6WtvmMHlYHARQtRYS1HH3yXen/0flnI0WZB9JU0341vw4KbOGdp2TIYQRX44KE3uEdG4+k6ek5Rc3c6rnkfnlF96tpIJz59aBMuVdmFCptBQ==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 19:49:08 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:49:08 +0000
From: <Woojung.Huh@microchip.com>
To: <cbabroski@nvidia.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
Thread-Topic: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
Thread-Index: AQHdXLZJRDal+7y/lUO1u0C2MYCT0bcFOV+g
Date: Mon, 19 Oct 2026 19:49:08 +0000
Message-ID:
 <BN7PR11MB283630E3A3DAFE8C50751201E7982@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
In-Reply-To: <cover.1792008404.git.cbabroski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|CY5PR11MB6115:EE_
x-ms-office365-filtering-correlation-id: 745e27d2-adc1-4572-0241-08df2e1a0a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|56012099006|11063799006|261009223027099003|921020|22082099003|10067099003|6133799003|18002099003;
x-microsoft-antispam-message-info:
 onVGWHwtrNFHOPD//y3QPlgRW10iiF6evEGsp4ofcORITOfP0GwYNkX74apc+IENiNItR3vDoDTknQSVx4StZwtIbJhTG+8aMCebdN51U+sRxgJHfWjX5a1CQ+Owp7Xv/Fefrh+kDlQiSGFxoHA6EsTbt0OqnzMOep8EAFI+HATAkDyB/X8BzA77VtZeVfGRotLarqtes8AYoqZzmDbqf5+L8GCZZ6WtqCrrXgG7kyVRJzl7L5jI30jLr6acjQPFkhlobGKDlktZM5XsEcVSqjemIrcpzloMfrRR7j6EQgTO64iyJusaNMNFY1GZa4OAjXLp/P7T/jNU3T3fBk5Kkj1YzkeJ4GVQuID1f4o5OSqhbH/KAinnGQjGGyOiPh38MV8fTtXgCsGofVI0MiisRBtL0MR2hNAq2s+7Wt7XVWgJDS+/c4sT920/9q9rlNm1to/bYEAukPVqQKgZQ5NilngolXyk/Qh4CehdugLAEl7yRqpJ6wZxUgGEFOzXM8TZGNOAUQ5EPnmNeCnqAHLtz+/thHgJAu8FPN3e49xkozHYSlEpzhmlmz8dH/XQ8+1hzbUZ6i1geLvHOC5VxCW+LqiSTVKEphTydHZWnaQ+MwdL1j4HyFwKvEbFGpj8KteLT0m3WnnGP57UwtYprYoRvK7yi8ym5qe+A4s4iYM6jnZU3LVKu9e7UMAIW6ZeH+/gWEMWELwAtpKdDJdSe8klnIwmxOtGjRMqgfS/4gsFp/wTx5kYhBVkfc8igYjM2hOX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(921020)(22082099003)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vdCwLehIg9cagjJuVto8sX3SPx+b2ClT0u35TcIJkgooWcQlYkDfMwkF34Hd?=
 =?us-ascii?Q?ADqbiT98Eri3kiBLrDs1uVCBKLclnABii5kLkBi7ZEqu+93R+HP8uEV1g65s?=
 =?us-ascii?Q?sfXIFpsbAy81XoJ6dvHwEgGZjejrUXvnrkO/ey2lVftWd4d6z6fjmFiF+YJS?=
 =?us-ascii?Q?mxfGh2/fDMv/N5lPbnfZq/26cHD04KD9eZ6/WWvCWEOrMVqRSfSAK8IxXeMp?=
 =?us-ascii?Q?NxnXaOCcDqIsfxedglhjgBuI1QOnPg0cqD9spo9HAp3jEGWO24v28FlXGW8Q?=
 =?us-ascii?Q?Tn+stYcWUymJhU/Izg0fWyG/arNKlUL0cr9sfOLgRb7Ze0X1onDENQGCHD8Q?=
 =?us-ascii?Q?MnHJDbyS1HkhY0rWCohDSel7hWHE62rIqB/maavDNwDXSsGkJdmgy8BxzxfJ?=
 =?us-ascii?Q?9RsN1A+UryOTrqu1IRbIdo9H+Nwz+RkytiCO+GHWG5Ysy0RG3E4GjlZnVflI?=
 =?us-ascii?Q?x5WnIAEneYMOw74UDJWA1dzqjxyIPhcCOK/o6RLJcYhkauwp2ZzPw5mJK1Ol?=
 =?us-ascii?Q?WcB4RYGBmOgZLquibILLB3lTiH2oIj573k0XYsdwNFGbLWzCH4O4lgY8mqGV?=
 =?us-ascii?Q?M7f7QTYk72W2fZ6ecWqQw4YbU5hHFSCFvcWpC/ngZI1jiJpZiuWRRebFmuai?=
 =?us-ascii?Q?aSVKb6FbpTUTxZieUMAv30tJ5iXoigG0d/5ZVolSuGWqgSLHLK32+D607J1f?=
 =?us-ascii?Q?6LMZYC7HaVEJuOR2wnYTVtG+M1D4wA6yjdNytWJo+YYyFDEpLyoo9XYIRJ/4?=
 =?us-ascii?Q?FvtliH4FVal7AA8DV0CX3pAwHsvXJ2aF78ljQGecoTAIEo3Y52ohDHxASCy5?=
 =?us-ascii?Q?mDX3PyMHjEPzNW0H+nyYt4GZifk6M4os43xdtTxFTYQxOZZEkOHZeRjcWPMy?=
 =?us-ascii?Q?Tu8DNwFle7HikbNdTqQ6GbgMOYycwKqik/VtjKcFa9fn39xjCqp/0Anm6o47?=
 =?us-ascii?Q?9eFUFA3vjtlOP/ckCbPzU+lT6uAaZMItrfNOBKY4NVhNNE5Gj/42BuA6D6xj?=
 =?us-ascii?Q?Il+ZG9jF/w0sGXmfqK+Y4rCwEESWKUzXdEuY/YLV5VAbyYr2keVblvWeyea3?=
 =?us-ascii?Q?O8h5v0+/CJGCJ0uzQ+u4Yp1vBAYvQLVHc/fpYREFlt3mf+7j53DTwf0mw0cN?=
 =?us-ascii?Q?299onw8pp+JCoMztL8faK2QIPkv/EniTIIXzAvHr40S5Pl00PW2wOX7G2igY?=
 =?us-ascii?Q?MBlmsHBUXU1uqQCIiIydmzao3YK+UlllS6PoxM8QOd+3VRrRx1CsHmjDHIZ+?=
 =?us-ascii?Q?CPmGotx3kA9aflt5NNK/ChoHMNK3Psto05uXC7Rs5YectS+2rf+gQsE4SFOU?=
 =?us-ascii?Q?2UyIf6xKDQaD02Ktef8r/j4PbRE6ih7eKb2V7Wrx3+liU19ruplESPWtjpKa?=
 =?us-ascii?Q?4uXyojZY8EmyJOJzNEoOx4W6UglnpCZ0n/YsFynQU5jmcMM/9qsg5s4loILe?=
 =?us-ascii?Q?Z24z38NtybbLjUj0RjPs/IkxkjAzd9Rw7tJBfeQU97urPSLo64ieHyPodh7k?=
 =?us-ascii?Q?9jzqKfp0eGrr+cgJg5vC0NQynj0QKMr4DgGGk+2UUViHih9kFKbjR6OelQgi?=
 =?us-ascii?Q?FFC0CgpEF0CgfcHKHXcilQRk9K6LKrGtbvu+PgNGK/2hTit4pkQe28V6sAjs?=
 =?us-ascii?Q?GteF+7h2dzE5iheC8wyFrP+LivMiN+43BaXgv1hCaZpaCTy1IlCUxwLelloL?=
 =?us-ascii?Q?jJzy8GADwDghLz8gv9Lsb8q8BJsEifJRxdSPT1mkh6YstQEdwvnySvo0II/L?=
 =?us-ascii?Q?dWe+D6zijw=3D=3D?=
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
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745e27d2-adc1-4572-0241-08df2e1a0a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 19:49:08.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FeUFTwKKn+XGqXNhRq6loPNqUXj64d8eR1x01w7iDu+nJ2r4OsoPZydKEw38XZlux3Ps4DlqDtQAXSnaUt2vG3MYs+Lu1f4+swrkJ+B+KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115

Hi Chris,

Thanks for the patch.
We (UNGLinuxDriver@microchip.com) are under review and
plan to test with our devices of different configurations.

Best regards,
Woojung

> -----Original Message-----
> From: Chris Babroski <cbabroski@nvidia.com>
> Sent: Thursday, October 15, 2026 11:01 AM
> To: Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>; UNGLinuxDri=
ver
> <UNGLinuxDriver@microchip.com>; andrew+netdev@lunn.ch; davem@davemloft.ne=
t;
> edumazet@kernel.org; kuba@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; linux@armlinux.org.uk
> Cc: maxime.chevallier@bootlin.com; Raju.Lakkaraju@microchip.com;
> cbabroski@nvidia.com; davthompson@nvidia.com
> Subject: [PATCH net-next v1 0/5] net: lan743x: automatically recover from=
 TX
> hang
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Background
> ----------
> On a custom HW platform that uses the LAN7430 NIC we have been able to
> reproduce a scenario where the SoC stops receiving TX completion
> interrupts, appearing as a TX hang. After dumping and decoding the
> LAN7430 registers we see that the TX channel reports that it is in
> started state with no error, but TX_HEAD stops advancing. TX MSI-X stops
> incrementing while RX interrupts continue to increment.
>=20
> This scenario has most often been reproduced in large server cluster
> environments, but it's also been seen locally during repeated SCP and
> iperf testing.
>=20
> The root cause of this issue is still unknown and we are continuing
> debug. It was found that bringing the interface down and up recovers the
> network. This issue has not been reproduced with the LAN7430 EVB
> connected to a standard Linux server.
>=20
> What this patch series does
> ---------------------------
> This patch series attempts to implement automatic recovery of the
> network interface after a TX hang is detected. It does not fix the
> underlying root cause of the TX hang.
>=20
> At a high level, the patches implement the following:
> 1. ndo_tx_timeout support to reset and recover the interface when the
>    netdev TX watchdog triggers.
> 2. BQL support to decrease the amount of time it takes for the watchdog
>    to trigger.
> 3. Stability improvements and error handling around the open/close paths
>    that now get executed more frequently as part of the TX hang recovery
>    flow.
>=20
> Potential issues and concerns
> -----------------------------
> * One of the patches adds new lan743x_dmac_tx_reset and
>   lan743x_dmac_rx_reset helper functions. There is no cleanup handling
>   introduced if these return an error, only a new error log. This
>   matches pre-existing behavior: if a reset timeout occurs then it is
>   possible to DMA freed memory. The datasheet states that these resets
>   are performed immediately in HW so I'm not sure if these will ever
>   time out, but I'm open to suggestions on how we should handle an error
>   in these cases.
> * The TX timeout reset flow does a full lan743x_netdev_close followed by
>   lan743x_netdev_open instead of individual TX channel reset. If the
>   stall is happening inside the NIC DMA engine then the theory is that a
>   full reset may be needed to recover. For internal use we also wanted
>   to reduce risk by putting the NIC into a clean state after recovery
>   with full reset. It would be great to have Microchip/LAN743x experts
>   confirm the best reset flow.
> * LLM review tools flagged several possible bugs during development
>   that resulted in the inclusion of three "Fixes:" tagged patches in this
>   series. They are included in this series with the ndo_tx_timeout
>   support because lan743x_netdev_open and lan743x_netdev_close are now
>   called more frequently as a result of TX hang recovery.
>=20
> Testing
> -------
> Testing was performed on a 7.0 based kernel using the same driver code.
> Please let me know if you would like me to run any other tests.
>=20
> Tests:
> * Verified the TX timeout watchdog triggers and recovers the network
>   interface when TX hang is reproduced. This was done as part of
>   repeated SCP loop testing and is also being tested in a server cluster
>   environment. dmesg was inspected for "NETDEV WATCHDOG" to verify that
>   the watchdog is being triggered. No errors were seen in dmesg after
>   reset.
> * Performance tests using iperf3 to measure RX and TX throughput show no
>   noticeable difference with the patches applied.
> * Repeated module load and unload cycles produce no errors in dmesg.
>   Network appears to function as expected when module is loaded.
> * Repeated ifconfig down and up cycles produce no errors in dmesg.
>   Network appears to function as expected when interface is back up.
>=20
> Chris Babroski (5):
>   net: lan743x: reset DMA channels that fail to stop
>   net: lan743x: start phylink last and stop it first
>   net: lan743x: quiesce TX before freeing the rings
>   net: lan743x: reset the device on TX timeout
>   net: lan743x: add byte queue limits support
>=20
>  drivers/net/ethernet/microchip/lan743x_main.c | 177 +++++++++++++++---
>  drivers/net/ethernet/microchip/lan743x_main.h |   2 +
>  2 files changed, 155 insertions(+), 24 deletions(-)
>=20
> base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
> --
> 2.34.1

