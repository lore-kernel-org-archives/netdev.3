Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02895374756;
	Wed, 23 Sep 2026 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135189; cv=fail; b=rzyZIpywpgQXMOJeIzQP570VY4i68RbSjS2Ym6idJqmtwCHpHlm06BIrVzDeSXDXxZfL477Orh9WKSl794Dcc+zjBXsRg4pIQQSQbLypkpncFsaYbv3M+IBjEriQjA5XYAo61uLNSJS5fB/IpIf+rwIx6PFscQDZ5Z8SHLWY+Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135189; c=relaxed/simple;
	bh=vHCBiB0KYOZIBOVJhbRWM6BakG3t25BTTZ36vg0hDXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGyoJXeBUocqUWHQwWn+hsa3TUN8oV3ewpeIUt3q2TeVYay0Fsf4uFnoApbtf3sma9dCDgUqWoCd7tH8FcRJM3YTLUg3gNPITi8f1/ikAPKsHj0leOmOmuWg6+QIHN5pFagmJlfeEKzBsGUyAiUXpqKAMxZ1gbqYcK5iOK8gGfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=K8abk2P3; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="K8abk2P3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3mAgaPx3gAa8ZZ0ybxli3dNoBWtM5qxZS/Djf5Ao6BJ21zuj1unbdrNRzPMvYoVBOYoR81ALXGNV2IbUNjk3jou4tVSTwTCnwHSRnRkHSJhbdf3QgzW/ofDpQXdTQ/wsddJO4oaKfeufYBsFYV1Wzf1j+S2PadvOrj29NtW9gUs+YGN72qikGh+P+5U9cMmEUA8R27jOS1yxRz6Xo5JU/tJu1znzI4KC+hwOf6we6t2fJ3NT3RAUvImJLGsYZwbmgEgorZaNI9XaOEcBN5wf9CdfM9/ro4EICZBrzJds1PfayAUgJFbj6QrhCOoINTXB/zTH0MAv4UUVOqqp49Nmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LpmnAKDrZsGe7UqxhIo20OwaBtw6SN6CWYDmXjHQk8=;
 b=Qdy++vYmIZzxfjFUafEH6dlVDxTztOHps1p8+TskzO8srk9Xso7q7/u24/TrAhXi0u+Sr89poTiLBh0En5dX+CbNou8Bss6JXPERmkFHBdOtocOmbLITvQu0aqoJhrbvpqnR+JcPk/fq6fLobUTLfGzqYeYnfxutO1P5DGgOAsVVVo3ocNQGBom6ZkgIsNmurdwHDWR5moT3JuTYVMMkijX018nLhrEhiOzXOMLuGfX78293zCy7/OHDzA1sdliH4f+PlcuKt1FbJJ4RHgIoFOlX3XTRkHand7hnh9S0AIv2KMituIdz9m9ffEFd6x4LpJ3y9GtWOCpwP7NM81FLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LpmnAKDrZsGe7UqxhIo20OwaBtw6SN6CWYDmXjHQk8=;
 b=K8abk2P3vyMv+HmqMD27wWAHIfgtHxch2T8tIK9yv73XefnoP7fPm9fouCfS42awstGzNECEwnf1N80Wlc/i5Pa9wLH0Dhg0/dbBy/AX/rck+2y3o4lRgTqNke9g9ZIx8mnxkwGRw4ZiS70wMSxkwwP96+051kvd75X8gle/0AJMvyPRRia14pLTBTsCfMpcVwvoiAy4PV1SocTuOYq6RgHN47DPTpRWTkVjoM9h2RKFy+LMt+PuiA0kHEL7dCasXoJJBsLzHyKR7wZ7WuWLjV5wYoA4BH9j12x4XTdK/NfZpsremK58ZdUVO3Gn1a3jgmNsIH3pxqx1jrKglQ/zoQ==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PR3P189MB0954.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 03:46:23 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 03:46:23 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ginger Li <ginger.jzllee@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>
Subject: Re: [PATCH net] tipc: Fix a data race on mon->peer_cnt in
 mon_timeout()
Thread-Topic: [PATCH net] tipc: Fix a data race on mon->peer_cnt in
 mon_timeout()
Thread-Index: AQHdSmmsXnU97XITgkGix/x1s+3Q2rbbhtwD
Date: Wed, 23 Sep 2026 03:46:23 +0000
Message-ID:
 <DU4P189MB3750BC7727CAB912B9F51FF2C6822@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260922080909.21123-1-ginger.jzllee@gmail.com>
In-Reply-To: <20260922080909.21123-1-ginger.jzllee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|PR3P189MB0954:EE_
x-ms-office365-filtering-correlation-id: 5656b7b3-115a-442a-01a9-08df19253cc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10070799003|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Dgl/iUXpF9VRW8E/xsXSvg9nO+uErsTJm9Ix4NDREVcqu1YJmB2yyEt8YVjMlqknlz1cNo4ADqaP+k5hdG+NTBRDAfRJXGyUT2WZOJKZ6KUl1cnVhMkOKCHI4D8Lg4cXwrFm4hLdzsO0hMhan32smWqQwGCeWQqC6gUjwR1eAxQQn54zxGuwuj0718GvRlGTLQ7QGKvoxVKwEEiFhJ3DHj/2b5wwr5Cc4WJlqRY73mMFh5FDmRoOz+1plAjODrRl5eFIwEdE7wZLpCd3+MO0mn5Cn+IWgrkMoAvoMQXwcElui1t3jUNkMTjSwm4buNmxCbge8LCHRJ2qCl8BFF39OX+g8knBEmifCYFbpkS4zH8MB4cxd5a1N7sdjJAc4VTSMe1vU7vsdOzArMvvuYnpwxiWCN9RaNr5pV/gjD635Tb1168uiytaqVc/y9xkj84/1g6/7qxNxGfEfUtPt7CbFJqietmeKvvxi0aVPeaLzFAeifw+95jyCBcbDJKYszOsR6S2GhkI9vwn1uKbHXZ0mE1jJ1Vz9zpMTCBohpErifF0uDFYX6i4pyi+RF8hgYCOGvrW3IM04r1u/DOCI8W93rAZ3/8GiesJU9LtOJJ9gvA+Q+N+WgpfiZp7O3z1qWHD9KSETyQzd+j7SsG0iEHj+3r28sgwrU6DpzaE1NM31jxxuYqZ7IKZANW3d0zk31cXOcQpaFnf6bM44JDMCWr3mf7W5Cidu2zKDTu6+Wm3VOc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RP44y8C7Lx9NrqPJwzCtMyNg0fADOMeUHkwB/gQnzLBLmU7WEzcPVCm04v?=
 =?iso-8859-1?Q?0VAPRkOkPY9FTHoygW+N36mBa/YV95C/NNrL/H+Q73IMsTO1ZLpE6OA+Nv?=
 =?iso-8859-1?Q?Es3Cx9CoX1AOHRRHQr4pq4a3v8Qu9SsbBk3QAchh9YCLx8E0BL8grnwO/C?=
 =?iso-8859-1?Q?Y8eSuRSXk4o4p/3z17MvL8bl/gi6q98yTXCAbBN/cYLOQMoygU74tNJrZc?=
 =?iso-8859-1?Q?MI1aaQT7zUGtRUqBRySnL+DUTziCQXEa55Mf4GPFkCx6Dnm6vpHsUlaUrm?=
 =?iso-8859-1?Q?QqmcOGk74qXCGa/lAoo2G3yjUDAb4mW9g0rTDy9H8lwmEAP09yNMgmaby5?=
 =?iso-8859-1?Q?09L0rjx+79knoqr1tr3ET9oU4yTpCuttpprcR0kUNAqaU+Vc41xMK+g5by?=
 =?iso-8859-1?Q?TootUs7yVRRZdOZVCimiMqlkoPDPfJXR0tCcF4YIpehYKrUGbKVBccZGfh?=
 =?iso-8859-1?Q?N8O2nCpM7qJE/PRNHtox1mzeQ+Bx08Ub5YC0+s0+Pm6v1k8sauHTdWJE7T?=
 =?iso-8859-1?Q?3H05rssrfqWZ1yqzuU7lRRrvOoFtFGw9FKUAXFfddk1TT/LWTFx3ZbXA0K?=
 =?iso-8859-1?Q?DSPp/kF8qxaqDuiNEUiAeMYkj6qavk2u77osbwpsptYvKNdaH6TOOfVfA1?=
 =?iso-8859-1?Q?bByLX6ajGs2dtJbqmM57WuMKuNfjtdhyJFhqQhBxjfJnFTDGvRN/cUH4Xj?=
 =?iso-8859-1?Q?yQ4/bZMj5aCBa14wqL+WqsPmy0Ucg0GgSMv+8dwQi9TumFXH/rnnvS80Bo?=
 =?iso-8859-1?Q?L9iQdn/l3r6gDqtmJkm/7sXBSRq55XyUbKn0YneajDw6mGCi6ycxZuEqId?=
 =?iso-8859-1?Q?3FPZ9xVx4lLHxufJITequ8458owKjhRMwUNFr83obIu5KOx7AtY45aa/Ah?=
 =?iso-8859-1?Q?x6VauYRq15H0h49hpFrKNJQqyaTHtVVz+n7Z95acBXvHnm9Cdfw11A8Niw?=
 =?iso-8859-1?Q?DmuRaffMMo7z9OCkktVUFvep3baUlnbzSKT5Vgx3SMGGUxB9Qoq0BMGVRC?=
 =?iso-8859-1?Q?5DKXd3UcPwY0iPwX0OBeycArp7m4UOeWjB8UlMBlLH64ppDc7uJHh5PtKE?=
 =?iso-8859-1?Q?QhZv4z039+ON4zMzMXKyWzFINhxc5cUnuEIl654eU1w2IGJFCizSiixbBk?=
 =?iso-8859-1?Q?G0T3b1WRjCmiz7Fhu7bmcXQNRcyIzq7ycEbij13umBC6RtRtcIJJrpOacs?=
 =?iso-8859-1?Q?cr+bPsc2kDcjTY4smf2kFkqvrEvmXmcI6YI6rrpuQbZDQUAPXPkgi9BlaL?=
 =?iso-8859-1?Q?MpxOoEwY4dtfqFUXWrx91Jt2RMuOMohpwlojnymc/rY6gW240kp7aFznuZ?=
 =?iso-8859-1?Q?6v0rnmvgyX1r4yKvUvHFvwqMexvp0+lZa1mmMUOu8qvrgAfKeBAFyVppku?=
 =?iso-8859-1?Q?g9Wx+vbzwHoJPAMyBaRQDZ43ZnF7hzlStA4Mhk1LjkJYz40JcOdPGiFTgC?=
 =?iso-8859-1?Q?cBL7hUXoWqc5cJgSJdiSo7L2LW6XFpsuljzjgE8dMJdPGALE5+LsowqqxD?=
 =?iso-8859-1?Q?zc7J7/HFZ9Pniq4l+caCJzEBHdlaq+wgO6m3fihbRJQsA/OLSftZO3+cDu?=
 =?iso-8859-1?Q?IFlYx3S1oC8O6ffE8ngrB4ZGkoLsfKN2KFCyZvXL/OnZu2Vc1/MElS7VZi?=
 =?iso-8859-1?Q?F3FDVnQ66g7CZxtFoniwdc7MGaDLA7TNhiUX19zLr5BKqjF6KbfYLWxUn7?=
 =?iso-8859-1?Q?qFZcTgYDxagFo6mfErjF8wOqBZUcPv8VBJl1sIbLOXks/AZ9H7KaKjHhVH?=
 =?iso-8859-1?Q?xrnR8OycdrPNRyP2gU7vYpwe/hH0Nlm1hR4F5ePpTKqifR1wSw7dyLk4C3?=
 =?iso-8859-1?Q?wfCeNF1dFQR7uq9Nhb8Iu2I98LQnZqWGSeIUKRG8FNHOpye0s5PzpLiUYt?=
 =?iso-8859-1?Q?J+?=
x-ms-exchange-antispam-messagedata-1: /vwBwwkdwZ9qQA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5656b7b3-115a-442a-01a9-08df19253cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 03:46:23.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsMWf+WazuPxkEgd69bMU3Gh3UwCl4Oxf0DKsCQM32s/AbGRrdhjI46JvihKcgk6CPbCtkfcCtqIq2mMmjyZYanj4DHUSJ3+dRWh1kK6QH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0954

> Subject: [PATCH net] tipc: Fix a data race on mon->peer_cnt in mon_timeou=
t()=0A=
=0A=
> mon_timeout() evaluates dom_size(mon->peer_cnt) before it takes mon->lock=
,=0A=
> while mon->peer_cnt is updated under that lock by tipc_mon_add_peer() and=
=0A=
> tipc_mon_remove_peer().  The value can therefore be stale, and the decisi=
on=0A=
> whether the local domain has to be recomputed can be based on an outdated=
=0A=
> member count.=0A=
=0A=
> Read mon->peer_cnt inside the write_lock_bh(&mon->lock) protected region.=
=0A=
=0A=
> Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")=0A=
> Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>=0A=
=0A=
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>=0A=
