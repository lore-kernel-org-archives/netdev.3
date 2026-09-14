Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28939A073;
	Mon, 14 Sep 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426855; cv=fail; b=TzwxojCQAeuCO0VGNSc8Hsypmq3aOaQKNImOHRrY3smchA4ZehdNenHDbIPp5Wtcw1DF4+OiHXwvs148rrZg+Y7hA4aIdY0KmaNZ6XAWzJnRLg0kf19rG+ZUMbzbHOcR4zV98YWvIKHx3bFHa+iLKF6fuHk/ddn11FMXQ0/oSCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426855; c=relaxed/simple;
	bh=BubKSVtsj03CNnhwxydLjwhz1HlYgJJna9kyolCGFpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dW4fkgmCfvGglwCZx7c1ZJkD9rVueqnjVoutQGYgekgPy6xwRYDlnAuq9a7sotRAWnjCw9Jzg5Y/JKxb1SvQkqhO0O5TE8raiYvzT6Ec4Zg1QCfTib0vqjkPwFjB0XFyBgTq5iK8Ye4BB/H3Ue8U7oHrOiJI18VQ0JbEeYsq4ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Eq10vhwL; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=wrxB86qA; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Eq10vhwL";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="wrxB86qA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=RemoDOcDU0bwVanhZgvylmNlYG6ue1shW/72WDs4k2I=;
 b=Eq10vhwL+tQs42BcY78Jo3bcfjf4410ZyqpWo7t+Dd73uWawQyyfUE0/SG7X9Atr9KtFHyMpazOA+w3h0aRnLjgYEBrB/eYeIv/fjDONPPJPO8u8KzsnbvOiQBwI4ImyAQtHHelavvi+PDW0hmBLnLH9wYI54kcHUGevfyk7VPJ3rLqZPzu1mZFmGmTi1/b2IlSugih+VGRU3LxAAsA9EewsgcaWYXM5IlU5OiDaGT3OU4q4cv7uHRL+/PCe0qxQ8svIUW5v8BOtJ2odrJwq5T6cuKMdJYHsRV5BT7zavm4CD3MsA1m+x08hOZxHZJDqoWNl7iD+nSFM7CQe6qTOhg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DF912A8007E;
	Mon, 14 Sep 2026 23:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAliIu+rD2dgQXlXn0SAzik/Y/uMCuXBlvihuP4hRWXRiyTNcZMU9DpncicEBU76dYv6pAsFUA5LAwtdzCVm1uA5T7PgQlVwv3a3NWmQZgL1trkEa2eSQViv5o7jneqVNnJMt+foC+qDUC6/zad8l1AbEIky0yxQhIi0v2VR9+CU182OqpVI33HeCfvsomQJIol8GDz/FVfkUyvpbm2ZQgZi7h8sc3XqBU6uP2MZc47XZIseKYWmJS3wMspr4Tyi30E3lXksI7ho85gNnEnF9OERt34K6z9QTu7PoGBqjrlTR3Kyc/orfekOaDdAdkDwkp9rXGZULIcyz7JG6PwnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RemoDOcDU0bwVanhZgvylmNlYG6ue1shW/72WDs4k2I=;
 b=ey7N28PFRTypZAmZbAWi96mafvnoMXSr8gQsuV+TF9RZTqyBGdGQOk7+3cdceE7tooO1zAwyXJDKd6oSN0aidrA7hAGk3KjA8Bdu3+McFFYtYMTqgKEDyaIknDcQwJxEqrYfD2lY9z4JVxLlRYi2WWYXtnSjj8GGGFjEq70T422/aCIr+PR4sIIegxteVItEJ80pxahhC9kQyXSmdeQwQzIdAIqA8DWg9avyGCFThUX1fcY3njZhsnFmtAUntbaGKe4YJ1P2N8/feIFhlakATnudxv+Arlv+io8Hlk7SH71AarzMo+jv0hYYKMMNl+TZkCRj+2Cd0Sqg86ftgHG8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RemoDOcDU0bwVanhZgvylmNlYG6ue1shW/72WDs4k2I=;
 b=wrxB86qA6fF/ORc5bL4E1xUW2ps2TWkoWLjkUvmRjQ23s+j426kLdje6aslq1sfMA0CGb9TjJoQ+B21fhiecVw83olac/0jwGOys2ym7PXCSiYzrlPX5W3LKPvUqio714UliO9E2ikASqXCwrMnUFeU1/ivdKb4rhrvK6yNx1yooMWcrHchMIaoyCDFDZ5/UMN2II8GEUnA9WbBfwft5hIbbRt4JnPSHs351LkgRQDjK4+OmgezAGaSmR2duyKYnzPojomrMa6zvGfNjT9uRJYl6Ew/xWrl4sS8TOHWYXT65yyXYM7exhmNb1Wx+DBmWaTOOEIaep9cskZMEf5wtpw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:42 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:42 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 09/15] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Topic: [PATCH net-next v8 09/15] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdOyOw8Je2u6mSS0KzqzUNkg+/AbbEqYeAgAoZ24A=
Date: Mon, 14 Sep 2026 23:00:38 +0000
Message-ID: <20260914230034.63861-8-arouhi@sitime.com>
References: <178887151995.219967.3640152255355236600@kernel.org>
In-Reply-To: <178887151995.219967.3640152255355236600@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 1166d5b1-0e6f-4be1-bb69-08df12b40068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|10067099003|56012099006|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 WiSm5UVMP8/Y1RdPQo2ZsW3SKvdiYicCOrPVsJzX55VSUdBOlPszcmji8oUdAP6Pm0mETno6IyOE4RBsZvOG6gHVLnrPxNbcr/AmGq6kcYWPEvcgulLqn8r5sTavXKSsLTShhwCKfcmuUdw8FkLGDpWgvcLQ8cbYOiDvE34gnKY9LaWKZuFdLSHYXzKhfVY+FtZIOpUpALrcur0vJ0hVZeD2KTphd3u2a3ISM8AJtSDPE4WCwYxP/PIlakP1zs4+cFawaLn0+1E2NncH5oD2YFo5Pv6O2RhkbEcnfr9sIaBYAmzr0UqVekhzkrAYtpfgb/DhCn6Pw3dwiavuqv+1S+eTjvOlm4IGINrRo6B8gA7zBrplaF46pBr9BPVs3gEiSqsCQ1Pox+MZitJBDYCK9tutnTEl2AbOhyQnHche1o6LzLmv2rQgDilXLMdYe2PryAXJjf1dB3cS5byG6lrx2aeiNTio8kV/6SvpK1FCVk9YjutYMuXLiCWaV9tUAMDSGzYJ48cclDYpmk/Jzjd826AeZWLQOlc8ALbrQyR2tQTfxclz1pX2VdmgDKnfLnwCrpgEgkONpt6fs8+6i70zW/gjl+UANw1LdxDUSv2HzQ7gsOGjnZN17Fbrifh6zfbbJCbbYlIxAdwZgMH0u7N6LZg54yCxOgx57FCWKux/g/DFZGCrBJ8YMdEwVsqizLuDmZZV9weUbxHx8RJBA71HcQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+Co39LWCNC57QTRw8J8sLD+e04leF29R8O1zeIgZDs78y15XY5m43H552Q?=
 =?iso-8859-1?Q?wOoX3rwHp8qP1kp2/I6w0eh8bSqVXG+tpT3MuK2jRtM9/gW/Os9ueJEtl4?=
 =?iso-8859-1?Q?xD2U6NHbWnNjSRylN9PrMKCawLA48KHl5BVq4kh4lX8x2WSzqY8GQsc5zB?=
 =?iso-8859-1?Q?31r/FYy26c+HC/qZ35OLkJD6fGE/8VK7+l/on34m20AaKqC6dGqrGbMcu2?=
 =?iso-8859-1?Q?e5+lDQFbDyQCkR0/T2do48edanLmwaPFwJIc/BWEy24iqxuK0rX7mU3uvJ?=
 =?iso-8859-1?Q?UI5yBkn/GA7iHcjL1P8kBPY/vR4hO3tBzny4ziKuqyiIIc7r4rs6egMLjn?=
 =?iso-8859-1?Q?FM+C69dXhquYqAQ1hIBD3dhvjDVzhRomjSkmebrehidtcguCJIRvGDoqpg?=
 =?iso-8859-1?Q?V5yLrATZ6SlYukvgHFmsfu8D/jW3n7pMJxfuERzZIOXkoZeZqE/Y8Krvxe?=
 =?iso-8859-1?Q?UGRanLI13sshkOUso8mDpFOPisUbGSd2rNKyQrM6sBGNd0uPt3g8naOMxR?=
 =?iso-8859-1?Q?PlWP+uhDh+tEcQgxLHu3AM64ojjqbwiSevkEYyIDEdd9nQcCZMIGkA5SYo?=
 =?iso-8859-1?Q?s4oTqpfG4wJ9p6aSRvDBbMUd8UY0uY1n5KRFHgzPnpV3iHVJDropRMtOhD?=
 =?iso-8859-1?Q?6zyF3bSG+fRMIXHIhBPLo+GtjxMz67bTmzFXRDU3AmJEzMblHOX8tLHXNg?=
 =?iso-8859-1?Q?a2HrHITT07FvkVHAyMr7GekH26+cfjDjr/pPCj9utt53Wd+z6VXDS9Zftu?=
 =?iso-8859-1?Q?AjhAaRuxrgAacndgfOa50L1uvMJRGu4kTsmare1liEZJdLjSb1ZVRNmpXu?=
 =?iso-8859-1?Q?UC7avDvCinBioq4nZ5BATO76PPDD0p4Fdl4H/rph/S8AbDbv28WbOiOMOh?=
 =?iso-8859-1?Q?8VM1hJUWs9LfxYUFbcibiNDPvIJxHPDw9JanWVFPIq8ThkotiMZ4l2idxS?=
 =?iso-8859-1?Q?JdR77qoWGlegqhcENmhuCO0DHq6GyHVyzXOzJcw+0lfPvts/QUzta958Ks?=
 =?iso-8859-1?Q?E9O2hSW+c+vvKy2OwMybqEiUup6E1JUcREA8IOO+bxlnDVwMtlFhSIMCWt?=
 =?iso-8859-1?Q?2SES3pjd3a5aCIF9cvwJAgS28JYVZl9YZo6LLiMI9EhW0D0HI4bzdqluxs?=
 =?iso-8859-1?Q?5j3rmZuTlWYjra1nOkJmul5TuTZOZjn8Gy6z73ohOl7xgmJypAgv/rHrq8?=
 =?iso-8859-1?Q?LlM1dCIvQCfuAS08ayf3XGRp1cBtKlF/tn8RLOHtlcLlAIc6IwRqjOU1HS?=
 =?iso-8859-1?Q?QJnsFj/xMvObC79qkksBORwJn9OrZ9MRbwtrlK07freFL8elBWzw9iHNfZ?=
 =?iso-8859-1?Q?NQqpfedoScdIhWNPy/SCnZVGaM3wzlFQXYOkcciXofD/MOy9OvZIMl3K1+?=
 =?iso-8859-1?Q?AlS4P1tE715+YHjph5w+4iY+61N60+M8qoj8cCRcpiIKbl5W9zKNl1xj7d?=
 =?iso-8859-1?Q?H9NnwljObUfK++Iil+rxJyymIAWMybm4B6l92dDOjJZroXF2mwPtSlC2fI?=
 =?iso-8859-1?Q?1hwWy+pJGQEquXcEynuoIdMGGGRmQ2OnVXxZJKIweikCvCmGEXTA+kuAbU?=
 =?iso-8859-1?Q?3WKkZQw0jUGYH+QrXHMG4zf7FdNxHBd7ouAV6mA/WAasjmxvRHHYSArS53?=
 =?iso-8859-1?Q?VkRr/U45Cf3vU70DCYzylD23wOEic3TwTTLOOes/d2hgC1mPkJQYVxHpF7?=
 =?iso-8859-1?Q?S9qm6QTqnfWI+Qulax2p0uim7Oy1JbsCYIPnGVnPOdCcsZaSKApo4SRmJQ?=
 =?iso-8859-1?Q?zQz9f0JjIGRkSU2JfHFqONhXZnWTpDxuySN6jC0AHGzGaQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	S7WMhnWaJKcQEp9mqunCVSp9dC/6kdqZpHFoV651VQNIHzkVZhRqCklDUKQfgCjlkVluzMzy/GNCkDnS3QxqYVAgearI3eJVakGkjXevNDyNyJv2hfc9OyxTDjOWrw2SBSs6LlkgXay+F+JBa2iObSnvQmkHyl99pCMvCEHHembwHrOrReULj+V/iqofB/2YjCHfyTHVJ/hlfXrzGDsPz0VNQyKWX8cp4EaU0NSuusGpAaWA1UlDiZM9SY4yNmuqWm+1fqqnUOJAdakb0gc+JpMjgpsZxOq/HOgHWP4WheHuAqIEaORjoy3vKe264/bdFfN/Tg7tKe1zImW57K7w5w==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1166d5b1-0e6f-4be1-bb69-08df12b40068
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:38.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNZeuAHFzi19/mbdevti9P+LaVkWiGR8wpwQQb3TkNR4OsTSR4jJHOQ6gRoFOX/PS4cSpsunTgVPNNyaqmfYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426844-E7ybTTwW-hVT
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789426844;E7ybTTwW-hVT;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> does the banner describe the wrong polarity?  It says MASK+STATE are set =
to=0A=
> mute, while the body sets MASK and clears STATE=0A=
=0A=
Fixed in v9 -- the banner now says "sets MASK and clears STATE",=0A=
matching the register description and the code.=0A=
=0A=
> Can a partial register sequence here leave sitdev->out[index].enabled=0A=
> permanently disagreeing with the hardware?=0A=
=0A=
v9 re-reads the force/state pair after a failed=0A=
sequence and records what the hardware actually holds, so the cached flag=
=0A=
cannot disagree with the chip for the life of the binding.=0A=
=0A=
> Does this read past sitdev->out[] for the internal INTSYNC source pin?=0A=
=0A=
Resolved by the v9 registration restructure: the=0A=
INTSYNC source pin is registered only together with its dedicated ops table=
=0A=
(the inter-PLL sync patch), so no commit dispatches it to the generic outpu=
t=0A=
getter and the out-of-bounds read is gone at every bisect point.=0A=
