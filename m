Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793889905;
	b=iVQYT3z47pZGkX49DTGMFjkNFvWTV2HDWnzfOMm/dad8K89m7YK0hKUwXwSQOoC6ymEc
	 Zu9GYSj5hz2zoRcNgOQp/9ZtpcjLXqSAv0Ng+BBTEvs5zwy1gsf1N1NB6G7HfZjpiFGSs
	 Np0kQlDEYJipWMMFD9+nBS9oJ1t1WTXtpShvR1WP0pbHNH4kqzGUHHWD47ceibL3lag4T
	 y/0I4P3krT/w4MsoXFNem08gCHed1jbXMas0lk60FRrwDNTu0mkEufTmmti6YMVpt7T74
	 Aptl4yfmvMeakX+n68oLAWaEOqlsOtFg4nco2/5XyVolqn0mfWA4rrJ7hg/rp4NvVCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889905;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZoU4Vw+8JJ52nEcrjTNr1oBc0mvxDOKbbq39OHFduOg=;
	b=cn/4zqm+4vFYPLzaS8cVJaBAhkhtDDr7eG333z4XZfix0IiWkU7NG9oT48cBWzP6NbIM
	 OWkWCTSD83+In04WzmDrh3pn+EDyQbE2uCQAHZny4MjEU4/UrDv5yjvTPQfmHHrvylX/M
	 xY3AmTX9MaHZWRtDboSzfkE9NEfXZu8IBNiTHeAfsCaMdwI/5j+CW4EeAO3KbjPWEPdVi
	 IvqKqHLrKw9YqeEalz1zGQM6owxSfeYf1DBxX5Kz7NBvH0EI/ew5tdKkutnxu9jVP1uzy
	 eTwhPevXAi1LDeU9UhabwtyNcpGKFQ/k2iJmgO9xjlIPmRruwHwiecy5F/l0Suukamg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b="Pz0H/1vu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.8
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AC606A338;
	Thu,  5 Nov 2026 14:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 491AC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=Pz0H/1vu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsrJ+ATEQHdFcWvdt+USkBA7ZQpil/DYvP8aGJEeNO/iQsrZkT0HrK5vNhuK6Kku6hSYjdBarE1qigteJdUt3ki5CxktW6VO/OFxesQxoIYEKAzYe5X/Ff6HpC8oecMCrLHCqwnj+ckctsip4iCr3G77dy2veWjmTGf1YPKqtoY5X8p0PjnsRRpvjsn8xH3/OGg14BCvybvUIzFHY51sob6gSOykVePzcXUSGsIn36Wjw9cAFVXebvx/WJvgr7ShubFwJXEVivtD/+wcz2p6bhBEZecD59hkceEstGRue2TnjB+RdaAj3zNCsxCEdSd7KRC3/yTp66UOatMG6XrjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoU4Vw+8JJ52nEcrjTNr1oBc0mvxDOKbbq39OHFduOg=;
 b=wGLMSfnzFUw2sPAsrbBIqkr2nWu+2aR70eMqFOpV1mqzaCnYwsyCLjDXmCwHRz6zkFEMzMsoXEDvmOoKQNciNvSznTcTOWzY68v+b+zQgrNLsAYkDrx/gcknPcotbhQlhyN8BY+mPKJmBSe13UIEQPiBeqIfonx9KbxPh1DA6bRql+vmDaTAP0FKXBV3t2rGF5kepK/JWn0NCiWe3uUW6JLFq8n/r0fY4QEf4jh50T7CHh8akxz8sIBOsPlBMUrLi185jUmJH+W8WiQjcePwaujkgN/FPd0CuHTpps8x7aruUYILOQq5KyrQsWgVJgJXoqjgQmA7LlF8n4zwOEg6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoU4Vw+8JJ52nEcrjTNr1oBc0mvxDOKbbq39OHFduOg=;
 b=Pz0H/1vuk/OBe8TTTLvJikeNeP+zdQ0VLRUibX8a04WEOPLFgFtJV3Eo8nqdXHQwv3nCWMIjiRvCPehcOv3O65DDK2UqYvoOg7mWDDTTyJU9oxT8ktPBX3zEUwRd/H/l7kPFmmSWv9/oJpO6zRSsuCUEug+OzGwB3TEo9JJJa+JdjWQT1Cv959jm1Ut117wee9W2Vez8hs4r1bTn7PboD/y1TM4MtMdYatEvTm2F0nyfZ8ykilFNT9PdE7aKzLhLgZgnr/Ty99bfpjBbofZ+FAkLDZpjyL952k1D3LQcX0/31m9GQqf5uC4GUbxbnWfzaIq3hoSnSsE/po0Nu6xOZg==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AM7PPF8CB7473A2.EURP189.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::69d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:44:59 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:44:58 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next] net: pse-pd: Don't be a regulator provider
Thread-Topic: [RFC PATCH net-next] net: pse-pd: Don't be a regulator provider
Thread-Index: AQHdYMkOh36zgyecGEeWYdwgwK10xrca5ZSAgATBSYA=
Date: Thu, 5 Nov 2026 14:44:58 +0000
Message-ID: <auyWYhHyFLGy9VJV@p620>
References: <20261020-pse_regulator_fixes-v1-1-fd6084a22cba@est.tech>
 <b11e5cf0-7cbb-47f4-8d73-664ea2e5da0b@bootlin.com>
In-Reply-To: <b11e5cf0-7cbb-47f4-8d73-664ea2e5da0b@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AM7PPF8CB7473A2:EE_
x-ms-office365-filtering-correlation-id: 60150541-6f63-4267-da5b-08df3b4b5d97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|56012099006|11063799006|5023799004|4143699003|261022075727099003|261022105027099003|261009220027099003|261009221727099003|261009221227099003|261009223327099003|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 HSdqsZqcZmvrKpondioL4bMAZjRC8VNZdTpi/T49ZABUkT+6r9huSUzORutNDlygFev/pb2UfFNJ17iZa3anM8BEU3VYlOMVChObfLK+zGLHfMZZuqjbXfuENFwJzn/r1Ymc9fEU7JNGVU2qnZBY9uH+xkJctv2e2hyNM5reS/8gPKPE/SktCGqMg4lL7dxO4l2B9Nfu9QYrSbejW6/j4ioaovwQMdusgF2GkSNetYUxohG/QAWerBDgakT9zxE5p55G+BK7JSdsUMfSQCYL2n6Y6S9lhsomg5rRaP45EvywJftkbFIBpllZ+SFQjOuoeOKNRw44EcvE33v4jdIT+lUJPj8mRG9mWOtEWHKv8S37P64s5iDYNHa3xCDU0UzEQWzRDa113AE9wjWPY/wc9tlTiVAltVAQV0FZjVlhpBUpRzEaSKejfErNhjpLxKV658kOizUrbaMSuoractZAqg+acErbrK19b769Jms+WIf8B2l4Tp4QVxwveEpHFzGHzpZF7uwYTY24dypgOlUCUAYQWc/P2XrG0Fmzi2Kogqu/G3RJ/7wGzIUAXViI938NXWNHyUUWbrANGl0fg/ocJR2JgIfNLJO3qKUWxjLc/wsrX5RngHdQviT8zM7QG8SiHM7rLkvtmS+mxhjuZ8SqrScV+rHxKIdPkd1apPtDG5Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(261022075727099003)(261022105027099003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O7MB2bhHoZAnutg6+FkWuIhLZjPHPuriBjC1HbQgOHCFo7A4TDC7Dbc9Y0xf?=
 =?us-ascii?Q?8S1m/1GnEfbgF03PPvM4cC2vHJxRu8pT9LaEUQFO1mv2vjb6/yod33o+/cgd?=
 =?us-ascii?Q?47dVbFCIWDKpwauSEoMwJyyMKXD9jgMaEgpcMt2WG9/SnGZH24nQ1AmQorTG?=
 =?us-ascii?Q?nrgQqy2TUlLENhMUab79s+EajTEO5kljwRANbhTgyts5bUnVuXTAo6JzcY/i?=
 =?us-ascii?Q?R2zEozw8yZUVRyut9yRqYjMSdxJMyMOxrLhiC1OBeGbqWc6Ck+TzrhiDlgCa?=
 =?us-ascii?Q?0mCNCGtIixAmVc3HOU8HqSohE6lnS/ZU9dMqMJblWF6L53E4qDqmLhDAlZI/?=
 =?us-ascii?Q?/pnXOehxnrEDgq6oLxLKXsKHkVHmu3+xPxKP8EBAph/yxGwcWb+W8HZws+oU?=
 =?us-ascii?Q?QIr1t/miDPXW1i6YHs2v31t6eqE6MhTLlGBqrb6hRkAIC8kIjJyHAiL5cH7d?=
 =?us-ascii?Q?bYPCZg3qtg4OARxfCcTAgMzXVXSj9qdBnCC9iZmT8FK84ZF6w0OHEumn/Yhp?=
 =?us-ascii?Q?B0itS8+ZqG4jbkIC3zcijRGmku5FrjlbxZdDTae7dj6sMjUwKIErDqFZGZOY?=
 =?us-ascii?Q?kJtlwmPaBnfHqqtPNepXQ7bNhWnMQaJaJp+Tv974nuZ35CB+ugclvhKEi4ry?=
 =?us-ascii?Q?lXmis14YAhVNuqIHqWsRmPzGQlgHmrs79OfpZqQP3qXC5L6Ww4xbGlVAwFOC?=
 =?us-ascii?Q?QrHdjR7A83XRQg+iUJ3xX9gttnoFBRauWjrG2ni3+CQadaAYYmvIF81NsbQ8?=
 =?us-ascii?Q?X/7FuA9q7bcA/95iNAqQkEL26JD/cl7r6BN/pAbQZzm7zqCRKbUCt+XG27VN?=
 =?us-ascii?Q?PEWnCPyBgEJ5gCslEfD6nkQ8feNWMlCVY4U5dG1mu6H63RRWVkbIfaUBvI7L?=
 =?us-ascii?Q?Ope5iX0quuIMUCnknkYdJ1poM2PvLvQRKpZY/fqRljYkEx7zF/4UjNjCW2Ba?=
 =?us-ascii?Q?bVOixoU1STk6Cw1Rko38QDFllVrFBisEEg2DRe9IHu9FEACviZ0De3xRgGTy?=
 =?us-ascii?Q?ZZn2Z78Ps7bWvTHudXwXKQA8wBgn5DsdwNz6D4Xu9kn1hhF++kWMErzI0Keh?=
 =?us-ascii?Q?rMoJViG56GHvPvFthRh3NoWCsQZ7cwelv3/w32RWHkN3lE3Zucf3v04fLIwB?=
 =?us-ascii?Q?L/2+wjJ/F6OvtCR3/mv43tDNejkZ4gZf3Gwhz361Xc18CXd9UMMiR8bJkwpj?=
 =?us-ascii?Q?rQytVtdrU4U0seaWbwlHKl2GDWh8RG3TxpKu2gxobnM0aI8AakSbxmmmqbHW?=
 =?us-ascii?Q?lI2ebOT23lLNJCDYjFXcoOF9r/Z2yKwb1QZpqvIZIvmu1jIRzLLW0a4zz0qb?=
 =?us-ascii?Q?AVM+1frI1NmwXrjqCXW9J0Qs9nIN5hKDi9o1Z80q5HXjfs6K2/RPRaJmXwYV?=
 =?us-ascii?Q?m7gmZHP+ocWLEQzVAIGNsdfGNea2Ea5p7RsgtKSnQk2DxtaFfZaUvjB8Z5U9?=
 =?us-ascii?Q?IVjcRgNpEV6UdRXtOafV5OwAGlYotjejPQsomwr409Vfsuhg70UxCGuSVU2i?=
 =?us-ascii?Q?s4GWfkS+QOg2aXj1SJ4vo8Hn9kI0HRkM8SH0Y+PmDz6XE2zq1gZ/DBTy2IFE?=
 =?us-ascii?Q?BYjVfxkDz3UYT3xz2SDHpSfy5jtCiNhuvs/xK1XnwPn7TQ/NM/u+hpdM+3Pa?=
 =?us-ascii?Q?Yik5FZXeql5l1M2i0D4Mj2XaJNL9gp8OXHg6ddU3ixMcuc96P1SV619AXMw1?=
 =?us-ascii?Q?yNZ88rZ3IPP2fcyoKbmT6lHzG8px+4kIvExXwKqoPdO82+tWrQUXTs8lBCXj?=
 =?us-ascii?Q?asLByZJCDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A98B55BC2C1F93488C2D0D7EB9176D95@EURP189.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 60150541-6f63-4267-da5b-08df3b4b5d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 14:44:58.8511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/gqqbjPck2CEWDpJbk5Z37vl5ckEFoQ7hrBMstVvH1frHHlcLOCn1Hi1uXIAVc5xCHcjB8ZWpx8Z52jXuYtLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF8CB7473A2

On Mon, Nov 02, 2026 at 03:08:03PM +0100, Kory Maincent wrote:
> Thanks you for this work!
>=20
> On 10/20/26 21:27, Kyle Swenson wrote:
> > Commit ffef61d6d273 ("net: pse-pd: Add support for budget evaluation
> > strategies") introduced an unusual regulator usecase- that is, a device
> > that's both a consumer and provider of the same regulator: every PI is
> > registered as a regulator whose "vpwr" supply is also requested by the
> > PSE core for the power domain.
>=20
> The unusual usecase was not introduced in that commit but in the initial
> support for PoE. With Oleksij, we initially thought that a PSE PI is
> something providing power therefore it look like a regulator provider
> behavior. In that case if we nest PSE PI and the regulator framework, the
> featured added for the PSE PIs could improve regulator framework and feat=
ure
> already supported by the regulator could be useful for the PSE PI case. D=
ue
> to this idea, we had nested the frameworks and each PSE PI register a
> regulator provider. The thing is that there is no device that could
> represent the regulator consumer, the real device is the PD plugged on th=
e
> Ethernet port but it is not represented by the software.
> Finally we end up with this unusual usecase to have each PSE PIs to be a
> regulator provider and its own consumer.

Ack, thanks for the background.   I'll rephrase and drop the commit
reference.

>=20
> However along the development no advantage of using such usecase appeared
> except for the power budget, but it is different because it is related to
> the PSE PI supply parent not the PI itself. This is the "vpwr" supply
> described in the binding.
> This usecase was for now, only adding code complexity, function wrapper, =
and
> several deadlock issues as you have described below.
>=20
> > This ended up causing a significant amount of complication for the PSE
> > core, and can result in an ABBA deadlock that lockdep doesn't see.  The
> > deadlock can happen when PSE ops are running concurrent with the
> > pse_isr, and I noticed it when a PoE port is enabled via ethtool and
> > that PoE port has a device that is ready to be powered.
> >=20
> >    - As a regulator provider, PSE's ops (is_enabled, enable, disable, .=
..)
> >      take pcdev->lock while the core already holds the regulator lock
> >      (regulator lock -> pcdev->lock).
> >=20
> >    - As a consumer of the power-budget API, pse_isr(),
> >      pse_ethtool_set_pw_limit() and pse_ethtool_set_prio() call
> >      regulator_request/free_power_budget() (which take the supply's reg=
ulator
> >      lock) while holding pcdev->lock, from contexts that are not regula=
tor
> >      callbacks (pcdev->lock -> regulator lock).
> >=20
> > And this can deadlock because the locking order between pcdev->lock and
> > the regulator lock is inverted in the two paths.
> >=20
> > Lockdep doesn't flag this deadlock because regulator_lock_nested() take=
s
> > the lock via ww_mutex_trylock(), and apparently lockdep doesn't record =
a
> > dependency for a trylock.  However, if the trylock is adjusted to alway=
s
> > block, lockdep does report the ordering violation.
> >=20
> > One way to fix this complication is to not register a regulator provide=
r
> > per PI and reduce the pse_core's usage to only be a regulator consumer.
> > The regulator core used to provide some behaviour as a side effect of
> > the PI regulator, which the PSE core now does itself:
> >=20
> >    - Enabling a PI enabled its "vpwr" supply, and a PI found enabled wh=
en
> >      its control was acquired took a reference on it. Each PI now track=
s
> >      whether it holds an enable reference on the power domain supply.
> >=20
> >    - The "vpwr" supply was resolved from the PI node, then from the
> >      controller node. It is now requested with of_regulator_get() from
> >      the same nodes, and power domains are matched on the provider node
> >      rather than with regulator_is_equal().  Consequently, PSE_CONTROLL=
ER now
> >      depends on OF.
> >=20
> >    - A supply whose provider has not registered yet still leaves the PI
> >      without a power domain, as before. pse_control_get() used to retur=
n
> >      -EPROBE_DEFER until that supply resolved, since getting the PI
> >      regulator resolved its supply; it now succeeds right away.
> >=20
> >    - A failing hardware disable is still not reported, and the supply
> >      reference is still released, as the regulator disable callback did=
.
> >=20
> >    - A failing regulator_disable() of the supply is not retried, as wit=
h
> >      the regulator devres helpers: the regulator core may already have
> >      dropped the consumer's enable reference when it reports the error.
> >=20
> > User visible changes:
> >=20
> >    - pse_ethtool_set_pw_limit() hands the limit in mW straight to
> >      pi_set_pw_limit(). A controller without pi_set_pw_limit() now
> >      returns -EOPNOTSUPP, where it used to return -EPERM once the PI vo=
ltage
> >      had been read.
> >=20
> >    - The PI regulators no longer show up in the regulator sysfs and
> >      debugfs, and over-current and over-temperature events are no longe=
r
> >      sent on a regulator notifier chain. The ethtool notifications are
> >      unchanged.
> >=20
> > Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation st=
rategies")
>=20
> Not sure we should write this as a fix as it is a big change of the
> framework and it is related to the initial support for the PoE.

Yeah, I was unsure about if this should be a fix or not myself.  I think
not a fix is more appropriate, so I'll drop the fixes tag and reword
things to reflect that.

>=20
> Also as it is a big rework it is hard to read. Could you split this patch=
 in
> a series?

Yes, definitely.  I'll subtmit v2 as a series and broken up into smaller
commits.

> You could first add the new helpers, then replace the call for regulator
> consumer functions in the ethtool functions, then remove the regulator
> provider.

Ack. This is a good way to break it up.

> If needed, you can add "#if 0" around regulator specific call for the
> purpose of having more readable patch. Of course they should be removed a=
t
> the end of your series.

Of course.  I'll plan on keeping it RFC unless you prefer otherwise.

>=20
> After a quick look this seems good.
> You can also remove the pse_send_ntf_worker() and send notification direc=
tly
> in the irq_handler.

Sounds good, I'll address in the v2.

>=20
> > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > ---
> > RFC: I'm posting this RFC to discuss how the ABBA deadlock in the PSE
> > core should be fixed.  The deadlock was pointed out by Sashiko in [1],
> > and I've hit it in testing [2]:
> >=20
> >    > This isn't a bug introduced by this patch, but choosing the static
> >    > budget strategy exposes a lock ordering problem that already exist=
s in
> >    > the PSE core.
> >    >
> >    > pse_isr() holds pcdev->lock and ends up taking the supply regulato=
r
> >    > lock [...] An admin enable running at the same time takes the lock=
s in
> >    > the opposite order [...] The ww_mutex scheme cannot break a cycle
> >    > that includes the plain pcdev->lock mutex.
> >=20
> > With no PI regulator, nothing takes pcdev->lock from inside a regulator
> > callback, so only the pcdev->lock -> regulator lock order remains.
> >=20
> > This RFC is one approach of probably several possible ways to fix the d=
eadlock.
> > That said, after exploring this approach, I've found several other prob=
lems
> > others have hit in their drivers on the list get fixed as a result:
> >=20
> > Setting a power limit on an unpowered port fails
> > ------------------------------------------------
> >=20
> > The core needs a port voltage to turn mW into uA for the regulator
> > API [3]:
> >=20
> >    >     netlink error: Can't calculate the current, PSE voltage read i=
s 0
> >    >     netlink error: Result not representable
> >=20
> > Kory's suggestion was that pi_get_voltage should not return 0 [4]:
> >=20
> >    > To have this working the pi_get_voltage should return some value
> >    > even with no PD plugged.
> >=20
> > The Realtek PSE MCU driver already works around it this way [5]:
> >=20
> >    > core: return constant voltage when MCU reports zero, in case the
> >    > port is not delivering. This avoids "Voltage null" errors in case =
a
> >    > power limit is set while port is not delivering (Sashiko)
> >=20
> > The limit is now handed to pi_set_pw_limit() in mW, so no voltage is
> > needed and pi_get_voltage has no remaining user in the core.
> >=20
> > Overflow and precision loss in the mW -> uA -> mW conversion
> > ------------------------------------------------------------
> >=20
> > The conversion can overflow on drivers that report a measured
> > voltage [6]:
> >=20
> >    > For the largest allowed limit, 99900 mW, that overflows below abou=
t
> >    > 46.5 mV. Only 0 V is rejected, and si3474 reports the measured
> >    > voltage of each port. A negative result then hits the BUG_ON() in
> >    > regulator_check_current_limit().
> >=20
> > The conversion is removed, along with pse_pi_get_current_limit(), so
> > the possibility of losing precision on the way back to mW is gone too.
> >=20
> > Use-after-free in the PI regulator ops
> > --------------------------------------
> >=20
> > The PI regulator ops can run after the PI array is freed [7]:
> >=20
> >    > When regulator_unregister() flushes a pending disable, the
> >    > regulator core invokes pse_pi_disable(), which dereferences
> >    > pcdev->pi[id] [...] At that point the PI array is already freed, s=
o
> >    > this is a use-after-free.
> >=20
> > The PI regulator and its ops are removed.
> >=20
> > Regulator enable count out of step after a failed disable
> > ---------------------------------------------------------
> >=20
> > pse_pi_disable() always returns 0, so the regulator's enable count
> > gets out of step with the PI state after a failed disable [8]:
> >=20
> >    > a further disable attempt calls regulator_disable() with
> >    > use_count =3D=3D 0, which the regulator core rejects with a WARN a=
nd
> >    > -EIO.
> >=20
> > Each PI now tracks its own enable reference on the power domain supply.
> > A failed hardware disable is still not reported, as before.
> >=20
> > PI lookups returning -EPROBE_DEFER after registration
> > -----------------------------------------------------
> >=20
> > PI lookups can keep returning -EPROBE_DEFER after the controller has
> > registered, because pse_control_get() goes through the PI regulator
> > [9]:
> >=20
> >    > A PI lookup in that window still returns -EPROBE_DEFER:
> >    >
> >    > pse_control_get_internal()
> >    >   regulator_get_exclusive()
> >    >     _regulator_get_common()
> >    >       regulator_resolve_supply()
> >=20
> > pse_control_get() no longer gets a regulator. A PI whose supply has not
> > registered yet is still left without a power domain, as before.
> >=20
> > Power domain matching
> > ---------------------
> >=20
> > Power domains are now matched on the provider's DT node instead of
> > regulator_is_equal() on the rdev->supply.
>=20
> Yes thanks for listing all these issues, that was kind of all the ones I =
had
> in mind to express my wish to remove the support for the PIs regulator.
> I can add also that we can also remove the pse_send_ntf_worker() function
> and synchronize the ethtool notification with the PSE interrupts.
>

Sure, no problem.  Removing the pse_send_ntf_worker() simplifies things
further.

> > Drawbacks
> > ---------
> >=20
> > Maybe some drawbacks of the approach (but I'm biased, so hopefully
> > others can point out more severe problems):
> >=20
> >      * PI regulators are dropped from sysfs/debugfs
> >      * There is now a hard dependency on OF.  I'm not sure if this
> >        matters, since there's not a PSE driver with ACPI match tables i=
n
> >        the tree.  Perhaps if one is added, the supply lookup can be rew=
orked at
> >        that point.
> >=20
> > The broader trade-off of dropping the PI regulator was discussed in
> > [10], [11] and [12].
> >=20
> > Finally, while this is fixing a deadlock I've hit pretty often in
> > testing, and has a "Fixes" tag, to me it's adjusting an intentional
> > design point of the PSE core, which implies it's a new change.  I don't
> > have a preference either way, and it doesn't matter for RFC.
> >=20
> > [1] https://lore.kernel.org/netdev/179080386247.434549.1581704258707198=
5098@kernel.org/
> > [2] https://lore.kernel.org/netdev/asM8rcKC1n1Tn4JD@est-xps15/
> > [3] https://lore.kernel.org/netdev/20260820142429.2285172-1-kyle.swenso=
n@est.tech/
> > [4] https://lore.kernel.org/netdev/41dd51e5-ac20-48b5-9e7c-4d2d261f3402=
@bootlin.com/
> > [5] https://lore.kernel.org/netdev/20260728084307.2129515-1-jelonek.jon=
as@gmail.com/
> > [6] https://lore.kernel.org/netdev/20261018082314.48950-11-github@szeli=
nsky.de/
> > [7] https://lore.kernel.org/netdev/20260813200653.980170-3-github@szeli=
nsky.de/
> > [8] https://lore.kernel.org/netdev/20260818162606.3981504-1-kuba@kernel=
.org/
> > [9] https://lore.kernel.org/netdev/179239893933.3135.904626315525832871=
3@kernel.org/
> > [10] https://lore.kernel.org/netdev/bb8eaf92-2b5b-46a1-b39d-a29ae273a3b=
5@bootlin.com/
> > [11] https://lore.kernel.org/netdev/atb-3EIJynaRwuwe@pengutronix.de/
> > [12] https://lore.kernel.org/netdev/0378ccc3-4807-4d63-8e61-03b46595292=
9@bootlin.com/
> > ---
>=20
> ...
>=20
> > +/**
> > + * pse_pi_supply_np - node the "vpwr" supply of a PI is looked up from
> > + * @pcdev: a pointer to the PSE controller device
> > + * @id: index of the PSE PI
> > + *
> > + * The PI regulator used to resolve its "vpwr" supply through
> > + * regulator_resolve_supply(): first on the regulator device, whose no=
de was
> > + * the PI node, then on the parent device, the controller, whose own
> > + * vpwr-supply is parsed before of_get_child_regulator() walks its chi=
ldren.
> > + * of_regulator_get() walks the children of the consumer device, the
> > + * controller, so the walk over the PI node's own children is not kept=
: a
> > + * vpwr-supply in a child node of a PI is no longer found from that PI=
. The
> > + * PI node is used only when it names a supply itself, because otherwi=
se the
> > + * child walk would answer from a sibling PI's supply before the contr=
oller
> > + * node had its turn.
>=20
> Not sure I understand it well but PI nodes do not have children. We shoul=
d
> resolve the regulator for the PI node only, as described in the binding.

Ack, I think I way over-complicated the regulator resolution.  I'll
simplify in v2.

Thanks so much for the feedback!

Cheers,
Kyle
