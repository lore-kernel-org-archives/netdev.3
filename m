Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530FF248873;
	Wed, 22 Jul 2026 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784685897; cv=fail; b=Qyza/XMKOpjDTfSS/jdZlFWu+MggvQRnMEN6feGOcgN+btvA0SG8YskQgzy5h3qTu4+mpSDuSN49RW3l9puVnmxo4lu3jJB0c/trXRKaXHQ4zxLTX6lbUmMhDQ5p+fxQOHNCXBxC2CLAYVAgNy8LXHz4ig3iw6FJhrPpAhH9Oz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784685897; c=relaxed/simple;
	bh=5DZxh6U/M7Yp6bFDSwHlxpzjf0NXgr5m509moFjDIZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GjKvUuy4r/4HQN29BJ9t90i0oNAx8/N5UwRRoc/mrPuWyK3+VMrizrED4onGX1svYLFifK3QoiRXp0CqmsyNoyuXnMAgxRisdgEXAp0n3EUaxOhz94t5yPhJxsfVjacBbvq4jBu0ElA+6p3npVIXbB2hgf8NrKCESnEnckf9gNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=CYlqjw+g; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="CYlqjw+g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jr2ifCO+BQ1HqwcEE6Rv7jePgpxc0qCVW/2LdiQsNNErKERxtTW9U+WTIHE81/sNeqYdeeAkgXku4Jxq7IoKV2Glho1EAkjQlKqZAgq8uuj1f8jNTCKRhbIn/bjhs7/2qmEt+5xuiOikiGWpCtINo012zFBCprGbSF0H4VDlC5r0swtukhc31QrT90FY3KjrfdoFTHcOJyN+kO2pOVkp14KoauKc6bf0lDpEiKecu0OwyulfwlMmGmQJmr8P88yYyMOp39mumfN3w6x9x+2kNHw1iFMujlfgZqnez5ExUehFFAF+cdX7G23q5xNhi1np7gvdsO1AK8d/Rj085TOhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DZxh6U/M7Yp6bFDSwHlxpzjf0NXgr5m509moFjDIZo=;
 b=mCBZhTYyhgULcP6+0bXYltEzNZdArGQmyAKOVe0qZq84zHnTxa319UH8ccc4MGdtr6O8FfCz+0VOoqb+9NsL2+aRpvQljXZhKGIcinQ6JGksHWX1T6f1+mechEfmTK1KzIk3D1HnqNh9is1PZNZwIs6WqIy1lRLkz5vNSS0HVqhPSxjIGjNdNRJ/40OORus8ewka63vOzhC+FP3/OtLXUUtxy3ORdH78JTAtArsn54i+1K9ZkRCYI816Q9L484YczILTnVaDzt2De62fjIjLJvyJR48gY3TAh8JoghHm5NRO07busOf6IraR8fzibnAmVNdeljRYYRYdln2o55r/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DZxh6U/M7Yp6bFDSwHlxpzjf0NXgr5m509moFjDIZo=;
 b=CYlqjw+gelWTU36W/MKF7+0dSoAwPYMWL5hdvKmcZvkQg7Q+v1B2rEzH7o23HmAisppUdCzro0vTyl0WOqkGiMMc5VsSEQ4/+PAlrouXAsu8UsjPkNzvKEvjIvdcl3REO3NpGw0LtaATKQEwBxjxBv3GpdrVDnxDkuoYHjEIAbNdaV+fNR4kn2xJlpzajZGjTRj6QMZVIKAw0EiLmIWCAAR469QS9H+Hy5DCgM01Hjw0PHYcEVvgr8uBuSQd5PHVcmq5E+dJP10QurwXkybYTeBfAXvctTJM/nXgMvDJOOQ+nyjBoqggcCcreJ0V0mTvEPBXd5JLmWgm5t1SYVQDSg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VE1P189MB0925.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:165::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 02:04:51 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 02:04:50 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jakub Kicinski <kuba@kernel.org>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ibrahim Hashimov <security@auditcode.ai>
Subject: RE: [PATCH net] tipc: cap number of nodes per net namespace
Thread-Topic: [PATCH net] tipc: cap number of nodes per net namespace
Thread-Index: AQHdEH7vOeMZZOLUIkGeczXfiK58CrZrdiiQgAHOIQCACyJfgIAAc/Sw
Date: Wed, 22 Jul 2026 02:04:50 +0000
Message-ID:
 <GV1P189MB1988012CC007115E4421DDC3C6C12@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <GV1P189MB19881AB5829FF8B0B00EF158C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
	<20260714170306.71517-1-security@auditcode.ai>
 <20260721120459.17cae182@kernel.org>
In-Reply-To: <20260721120459.17cae182@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VE1P189MB0925:EE_
x-ms-office365-filtering-correlation-id: 5589f829-ac91-44b5-036d-08dee7959d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 oC/0fzxcY1GIUGhQ3fz/hGdg4tEjGRZE0TZ47OsAVCsKZqteXGH/XFZTr17gSojdWR5f53Rz6rv/Gr2tLxBGeZfOSNWHtXY6FqnWeaW0NZScvJ/fVGKqCiferq4JhFnXoK5z2W4SPvIQLs9xhgZ0aNXfECsurdiCCuB9420vDxc/n3cjCP/ZgnD7iOQri3Aykt0XUd7yrvFrkInsHZv0B1LikXJiQEzLtLupZwNdkE0/MreduqZl0RuQh3bKQXbHPklnheIGPGfQFiu7J/JZZOs7jT2l9UOxAEBZ1lhwNsevr01GqxXYnqwlPAPlc5Xyp/Cbd3gtVcSKXfK3937zJ9/7GZgjzDiOvXk3tUP+DVeJRFjckC8/VK/xyVF/UdulbdmjRN019fbcHyPsr337xYjxgbGh9gkiMiBkhMsnm3WmC81GEmJTKwNK2cT3ZFN3zbD0EZJ/k4l7gaU/WKxYzwa60yhM01W0w2pP3Mv+nUe8TndieNXYKur+/QhONNiIq6nwbaONWd8YYz0iDrXt571KB8QeL+Hk4ME6GT+7pLwvu2LwoSBvKZOCPTLnDgS01WztmWVN5pZAVfR+gttpMR/+g2cMK0IKqUj9JrQUR4Z6K7GzuLuOQInnBjStMxUiSJqnI+UvE2wcPkqL1r13Q0PXHVxx2J3yB7H5ebTwcscgXxHkulUpm0w05ekSw3KSSWRoP8uyJiJznn/wmhHIxA/Q3AeXMD/s1JZqwfUfBa4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o9l3dzUN4fFwxbRnCWSm/qnt2TdfzVt8dycrP6wl4dGF1YieGmrlUCJWCJKE?=
 =?us-ascii?Q?w33CXNzW6ahWZa0+RdrvP9kk44GNduFGRmksTKtzWeuRyKWnzCp9COafRFVw?=
 =?us-ascii?Q?Ut/S65/SU7p+Sx5svR7gCOeF+mIKX+mUexzP/qiP1pzIGWFysMUVM/uMAIcp?=
 =?us-ascii?Q?r35Yw0oNDkbCihR/4pBTpFd3ziJ67sqih25bcizLe3uRiZbiJHtchl9L/5t6?=
 =?us-ascii?Q?AFpp+/mKeqGF5qAZ444eQkhU2LHtHu4lemqKpSPpBY27X0fF9LMcRjOgToq7?=
 =?us-ascii?Q?ie++haQTCEMcE3aREQKJgAnkCtnYW9Fc7+4WdtTELtQ0KMOklgllhpOgmqRW?=
 =?us-ascii?Q?i/RUHeaOFuZuYSNPBhIhvXhmY3YtHcmmJyH5xO7eE/V5++YNcNwqOq4gxBn9?=
 =?us-ascii?Q?P7jiMk/0VNUyNNXuKe8lzfI/EkK/tmZrRmYykg3qgxTS5SK4jmWjJ0kqIzME?=
 =?us-ascii?Q?05YUOKhBhBkfVX9mLAaLAManSFDCWrWtv7tlHSDVg20vbCX02ouIGeeKT9Bk?=
 =?us-ascii?Q?GKA7ERAZnxlh2X4p8VIK7DVsW286OxitxICswAmfKN+KTX9WvsaS5sHUCM2F?=
 =?us-ascii?Q?tTciLlEkXu1KrobbWgCGpJ7BoGpwEJg8fIGOc0KO/TFxaVnCN03VXHQfF5ai?=
 =?us-ascii?Q?0LFKjyPntRcawHwiAUDypTW8nufWssvcd58PifhPRXlMJsegOlW1UN4pnVgC?=
 =?us-ascii?Q?URfGcnm1WWHVP7qGKMJ9OJ1jAP7W7XrfEGAq5GGhAMGYBbKDXLFUI0vyUAvg?=
 =?us-ascii?Q?58Do2bVufl8/lrbl8PTiOOzlCt1Tr+gxexXG393DgFtccBUQz7laJdEKOXC1?=
 =?us-ascii?Q?g1IgqxnInJ2bKEGagO8ltZbM5a1Ymqt1JTkDKJo4PZqhsfS0ln02PNF7Plwm?=
 =?us-ascii?Q?F5jerJItZ2GJXkZxztwSKvqD8Nx+lm78BEhlCgOggak07rqm3QFV5YBYMlDS?=
 =?us-ascii?Q?y8wGqlG1FRCCtJa9pkWGIDluX8twHx1eghxmeu0yDuq44cadV1Cd7cHFhtmb?=
 =?us-ascii?Q?T1GsptUZlqzoNvzUC91iljq+hWlPXR27+KpLJojOL9Qp7cA6ViPdbt/lIKAX?=
 =?us-ascii?Q?HHBv2xEP49UNgpMLtdgxlM+vUKmn7HUH+aJuAfCyESPciRa/Rq3PgJ7FSmMQ?=
 =?us-ascii?Q?OwK/zGzdFYIjMEtqBtYBbYrryDbGxPhrfX/acwFlRXvJ92R72zansmMwXxAf?=
 =?us-ascii?Q?XYR3YPos682NDZnxpDRqDkDnax3pHycN1nZheNJ20CPQflvvhJ000DLuIuF2?=
 =?us-ascii?Q?bEvEGICQ2yA/oZB0k8ER79XwGZs2W8tkj+otLFM3AkTaYSYxRcty52Q2lW0N?=
 =?us-ascii?Q?IF1D/UnGCoW1NPNs2+yFR74npT51O0A1EytpzAr3hA6sbTk27N6nEg/BZsvP?=
 =?us-ascii?Q?ObxaHfB0PB3sfFkded7CNLlSAUxO9pLMZecaL9UGvSNQYrkrFCyx+rfYo85S?=
 =?us-ascii?Q?eq6EyFkJiulO5e5zkaJMykTBFVL2ZmMAWknWhjhzXBaLdmdr/fWfMPnUFVIx?=
 =?us-ascii?Q?tYyrEMJ49EZvteXqXJ0A80nz7P26Lt59KyR24137Hqff9jhKyZ8xKP4Sm+zh?=
 =?us-ascii?Q?EGg7QegSpCKgjIjxrm/0h/t/fxHAGvjPKf+wZLji7a0WH2f+D3bTrxQvCVIO?=
 =?us-ascii?Q?ycKUaid3FYSheU6ZYlX9EwRiABh6FLqXYK+Fqup2tabcnAG9BVvKNtQTCkG2?=
 =?us-ascii?Q?L0DZXLfnK021IcUdthDC5Is0l938y81N5HbebyMeCA8OjkPPb3ezzRirP7fg?=
 =?us-ascii?Q?jMee/sRfcw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5589f829-ac91-44b5-036d-08dee7959d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 02:04:50.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSrjbV7AWIDcXRmM2ObtjnawvUkVo8BaczQTH9bwJjHDlVUbyR17nuBSDo6FOI01IvwlPPVQrXSVAbxwdtAbJmvogmaLrdzLGzadJNfFpK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB0925

>On Tue, 14 Jul 2026 19:03:06 +0200 Ibrahim Hashimov wrote:
>> That said, the bearer is a trusted-cluster segment by design. If your
>> position is that on-bearer discovery peers are inside the trust
>> boundary, that's fair enough and I'm happy to drop this. I only sent
>> it because neigh bounds the equivalent ARP/ND case, so it seemed worth
>> doing the same here.
>
>Any thoughts Tung? Does it make sense to select a safe upper bound of some
>kind?
No, it does not. The change does not fix any existing bug. Furthermore, It =
could break current users.=20
