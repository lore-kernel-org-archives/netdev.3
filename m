Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D52F7F0E;
	Tue, 25 Aug 2026 02:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623622; cv=fail; b=sOC8MJIgSiUcXrY5dxfsmBwL32RluC49YMSZZyjlJy7m+OD0ruz8xrBScEEhZhRPMJzLIgKb1hjjXubq1or5ALUitgl1Wyb93mpI8qtTlWqTLonrkW3D1TzBMbd4ovRI4qZKXF11kEtsiDA2tP0tgcOLWllhaWkTSsuKsMhUVME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623622; c=relaxed/simple;
	bh=SVY6CUSbxSQnS7GhIUB/QoWG9Mtq5+PK3KHuq+ouxbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JDHvltn7pxD1esO+xpAPpCBRGiRKdOBaF4Zt7wK5eHtuvXg4CqEqwXjIGNH9u7w8fsDarKGzAhMZqs3x3zS9EhH6bWVqOko4F7wJsJFBn62kejBsRJdJzufbRbbeFg+7ovj0D1+aeYYB5MJO4WJwrXhWZxGE/+zSS63BQ707br4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MkX9KqTg; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MkX9KqTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jakx3emd3XvBcT9QPnOz74Ec1ZZxWuQgPMjzon8TZNYOHGTXvIkz85b/cSGQ+C2k8pQmtPoZPZFGAA4cip2A2QlhwrdSXv1Kcww5dP+7/WI3fqQw/WzwNKtPzQLsZ+rY2TkTjk5NDmu41UWEJYbo8XzZpLudFfXmwqvgCSFAfgx7rLMSsF5+qnONYGMWUVFOfjPWuWuX9gLCZUuYUUrHZIIREvEwVvBXdvJE8pDDkvlNxIVFRYQ2T+6WNlLvPxLk+lBGwYQrt488vx7/CyPSLgUR/IKQpAxJMyt1/hgLUiMz6S78PRIju8Cvv77HZ8vRyNi1bj7kIv7CxuQ7jd4I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5vVr5z39fqcoTwLQfYhvBrucMwkg91+cHDGydVnccY=;
 b=AUku0U7+dTBIGi50Dpr+LwLpFJvIuz7AfayFThz3yelk7jjPB7xb5sbY8c3XfTn525zPK+Dd3M14fhXfvAsoxiLalHJKI/lKTOrAvZPzhuXtrrpmXdAsomdzknrSJnEiJmTHo6Xk0aYx9lGSLOmnr+uAkgqwCTXhW46S5pHrIwj/AwljSace+oTWzXgs73hb4Ke7XpC36XawQ2WJq4K1poM0DbSlgDTDE5Pto5DCPPUfPJUGtUID2/EP2EAFvHAni5AlYYzbSwMDYJNZfcP/PEsG5jiinMHtbX6TXLE7ZYEJjnnu6nuNfYLe0D4wfkA/oH9+FQYsRurU7kFUwLqRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5vVr5z39fqcoTwLQfYhvBrucMwkg91+cHDGydVnccY=;
 b=MkX9KqTgqU9gWvgN4mUJ0JJ1L0MaoJTlqUTsASFBY53IgJCQIenbZn7JlCPkgr6aR2WZ8nhDMFg8A5LTVYQdN2oKGDk1I7kGfDoxBuQ64Ny1prbhTOFUFYmFo/azVL+lmHePwmW45N6Gwmtx/f4hDHm2Eb13NtcFQ8OdI3+SrwpScdk6zqsE2vmLtDuxo1oiGlaHd1EihxpWQYTL3cwlMt3leGTuZNkjTTYRHuxtcYg9ck4HdEa1jGWy53mzEBE5QV9QSaYN4b9nbJA8sjiMBoTKXFojd5jebF2hshv+u6kBlrC3r5oszOJXrqDwlGrg5IGoMNIkD+b6FNJQmp27HA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM8PR04MB7283.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:06:57 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 02:06:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "phucduc.bui@gmail.com" <phucduc.bui@gmail.com>, Frank Li
	<frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: only stop PTP if it was initialized
Thread-Topic: [PATCH net] net: fec: only stop PTP if it was initialized
Thread-Index: AQHdM7CT11Cgo/bQ90GlTvYIf1N7nrauBKgQ
Date: Tue, 25 Aug 2026 02:06:57 +0000
Message-ID:
 <GV2PR04MB117397A9A870677685E1EBAED88AF2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260824100834.31655-1-phucduc.bui@gmail.com>
In-Reply-To: <20260824100834.31655-1-phucduc.bui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM8PR04MB7283:EE_
x-ms-office365-filtering-correlation-id: 7193c7a8-64e8-4388-f28e-08df024d8ae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info:
 bK+R8TshZ9OuEgGvyZjN8EMC8509p7X5uGBjki4HhrUe8E+jzKAxnqmvPOkX+YvglEsM9tIXMika60P9OJvwRpqtG4YwFJbydMDM4krdfarj2QsfNuXHGF12RzGmq3y1BZxp6vFMU55lwFGia4SFR9khiKxu+EdSH2W7tVg9zYO34EHPJW3wQQH9S7lXVsJJIqs7qlKD8kLN/g2EtoyAVDYuZBf77iu5riM96Dr1VGxeZZkiQxPt4ZGXPubSU6xAFOM4R5/iGF8ogpbi6hpDRV+vrP7FF4WayTeiz3dsi2S7Z48LkCPy1lLkyqWNmGrXskfkkbRqTv0W1Krn9tvRZ2puIkbH2hJ0laiPAbklA80xgjhYJWXFLFU/8BGALj0acQWkcLy8ezUO3qY2nb9zfrKKX4LUhzxp10p5VbXquCpPaVxrm1bG0tqhyPZSVsv80G4eEAdIZaVbMZgx8uC8wD/w9Rg33k474NbILP007J3KRCjBcpusjqs+5AlAeVw9zR76fHFgIXrRPblcYljqQPfQ1JaDlr3cp+3ssxjDktDtLBPifT62Wdcdyrxq4xXvxfCqOSwVz5MX6HKgUCb5F8ko2Ig976OKhsRmGn35HOXvhII9/vYLKxEkULq0tYoIQ62mc/b/XeyCMykSTooLGUGjqasDUc+J7yqa87Jn6x0P8Ub8cCvRp7eCnKc2CghO/k//g0aXucYFfqjgWpEZuIfJzALLTvAXDW4ZJpo2cBA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wxLOvZPUT3ideeDN3OhgvUsBvbqbJpF4J4v60or0e2aoiUmxUh+0f++REOdh?=
 =?us-ascii?Q?83/2LrMdhZFUCqV/2IYcLTpxyJ9K4Fbij7OCUQFfa/3Rr9qi9bPLByhVJYwG?=
 =?us-ascii?Q?QyJuWyw7dxl78VOC8XC1fnEZ+qan/iaFIUfgML4ZegT9d1DhSh7wOyG4GNwQ?=
 =?us-ascii?Q?3u0LY/9Wffzp6YwYMbRRFbevbxR2+BTCeoxE11j42a8qC4Hnf0JI9xex38KS?=
 =?us-ascii?Q?ZNks2txtIKJv3BIK+RU0rv2eHBaKGRsnxGfckPkoRFonrzDRrqvF+lRpQP7D?=
 =?us-ascii?Q?i9Ru4vr8fSfM4BIAnTEeOibdWpjo8n/ZBVtAzu6QphgVnhDSL1btvVO+uVuM?=
 =?us-ascii?Q?euSQcQPr+U/9UR+sQIo4NQyJUqysGJIVry5yaq8hCLOjFaqCyi6ZySuJMtqP?=
 =?us-ascii?Q?jtsNwgKAI3VLM1dy10QGT27vRHtmVuf95WWQqR7ChEYdeG5IYGKuXFHV6RIB?=
 =?us-ascii?Q?pqZ8VFbCDiFOKv5v9XsE3vZgMLdLXOxamMyWhjGUZXyDaosFNUqHHL3BNSPL?=
 =?us-ascii?Q?I4OC1nXHtcwXtso90KVgVVXeHNpfFXgEkOeEKYpaM/DO09b9XjSpW6Tm2aW8?=
 =?us-ascii?Q?gnp8gFKbkYvSBJPVh7hXZfDk27Htg6jKrP05T7TrXBUqDWh/zRm+4Qil9+nF?=
 =?us-ascii?Q?jLHD3P9TaZTpeRJtOg5MzCC/47CB2dmanQE+UlnAME6JI3QD8WrOyRVlCws8?=
 =?us-ascii?Q?xNXMMf4I98HjeNRXzwL4MywZawI6Z8JKjHNBGuqHSVbe8dghNQtuN5U81KEA?=
 =?us-ascii?Q?CCKKUjsciT5L5nvvmVqLtDpW7EpUZ95J7m7Pq0fzxG1QcFuozu4R1R8ZWHJn?=
 =?us-ascii?Q?uWeyIwjEdV335Ci4KoIhHcpUz+P5wJHKNnXVpvcR7Y+fA2Pz1rO4TlU6xYIN?=
 =?us-ascii?Q?gnXaHeYT69QY3R8lzu9n0i8LyEfBwIr1AlWyKYuaHjNNF+bCiBbMY4JkDQI/?=
 =?us-ascii?Q?QOP7336YCu2l+M634waAw6gU1K1z8/EH0kVmC910Xt/GlTowNSHLlT8CjPWd?=
 =?us-ascii?Q?3vBePKESPmjnapQfcvUxpY9AdniWuvqTYhhUCAU9QaTGeABKXHqSI4Pv1v/0?=
 =?us-ascii?Q?HfHNOhAHpbHHiYI8GQh+/xMz25iAxo1o04G+w3TpnUq4ypWyZFL+/Mt6QjzS?=
 =?us-ascii?Q?87EzJrjV6f20EuQ0+0ss3xhnXathyXEyRrhX8jaNnePijHFzfmyTBb/EHV3o?=
 =?us-ascii?Q?2gGkAtitQoQAqsFGDV8r0faRi6CJizOI447cucPDkpXvLCtAHAFx+eXkaxeJ?=
 =?us-ascii?Q?ByA0G4OF0Dc5mIKyahsE9vQr61x8dZHRox7xhQ20OoUjBmzKTGGYE2Cuo27i?=
 =?us-ascii?Q?KyegQwHxblxEL4UVWwby0paL1XERA89L+bLJkRTajR+iHSv/5fIDAxiJ4Uhk?=
 =?us-ascii?Q?EnFwWu7+NEoAGvpDoyartiZNixU9U3bhHUbqk2IC0OTYHT0SCnLmok1+oqlU?=
 =?us-ascii?Q?tBcPR5QjVKDuC8lqm1yY1ZeqTVVB8tdmrm/eBJfeNyH99SvXo5v463DvIb0T?=
 =?us-ascii?Q?JxGAHQS6qms7nhBhhnCz3rihXfUgWLWCyqfMJH0PqnZdAakWt6PApv8fniQH?=
 =?us-ascii?Q?PRK+2YjJ/8BbjIaTahWA9M41R7NGXQrenJsUQk08P3GBjDmD2L5OzuDReYPE?=
 =?us-ascii?Q?UWgyTtQAlHwIthc0UhIUmBvJhfB8Auw1L6Z0yPQ2u/WhuO3g8aZhiczCsmq0?=
 =?us-ascii?Q?cA9E6vMAD8u17uQW1j19Dg4cUEANOraMMxYzMOHgJR+TqhDK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7193c7a8-64e8-4388-f28e-08df024d8ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 02:06:57.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAMvgEuOv5sqi08IEofNma1wnrcxv6RE1pbNWy6YhwGctHRY6tCwycy/3SdUm1ouFuy4t4AXaSyLWaVpSEVZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7283

Sorry for replying this thread with same content, just to remove the
"NXP Confidential" label. Sorry for the noise.

> fec_ptp_init() is only called when fep->bufdesc_ex is available.
> However, fec_probe() unconditionally calls fec_ptp_stop() on the failed_i=
nit
> path.
>=20
> Check fep->bufdesc_ex before calling fec_ptp_stop() to avoid stopping PTP=
 when
> it was not initialized.
>=20
> Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe f=
ail
> path")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index ced4dbf8cd90..7a87f40d12d9 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -5457,7 +5457,8 @@ fec_probe(struct platform_device *pdev)
>  failed_irq:
>  	fec_enet_deinit(ndev);
>  failed_init:
> -	fec_ptp_stop(pdev);
> +	if (fep->bufdesc_ex)
> +		fec_ptp_stop(pdev);
>  failed_reset:
>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> --
> 2.43.0

Thanks for fixing this issue.

Reviewed-by: Wei Fang <wei.fang@nxp.com>

