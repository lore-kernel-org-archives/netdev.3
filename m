Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4703B811F;
	Mon, 17 Aug 2026 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953239; cv=fail; b=iNnSPOvDchte0/C9qLv4NUt/2sU6emT4bhF9PHYfEKwhvwQbFgYtYZP9hiGIKsWUU0PnIlYJRI4Lo/qHitOSBXzMO03JQWpNMQoCNjzBnC6K5E76ZCChi851fW3S35fbIPj7QVoXjzkDUwuw3AVZonb28SGP+KSE+VPcjEq5VSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953239; c=relaxed/simple;
	bh=hyaYKeB6PzqQpXzc0Xb0iwLjc9XIguUlbepBNQVxUSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUpWLg7qps0cwljab+eN48k+jhIB/g3ptMG3Dr7TL8OvVvWHYd+0mD/LDa6IjiSNBpPNP61YYfUhDZcBwDqvUktioHgN3QkSnALKQ7/UR7ObKkRV6+i3vEgD7W4FYI4XHB6FP7cbX0lt3ND/YtXR75thrINhdIOaZxMGLLXo0bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=GRj4n8IE; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="GRj4n8IE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM0s6o0JLJpODCfyKp5ZcdrV3nr+COoqPF55FozzLgeXGaGW41e3+a1BEkNnE8Q52Sk4dW5YlU0wb01bMjtAjyxHYSfRowwV+sSEHCE1pu0vnS6OOonsbM0Qk7MuZL2IrWik4tsBsvXaRSZxLMmqRgeYkgt9v4qLLk+Dl3fPxCqxIvFoAZl2WTT5JMjnCyxvJGNevsxYC5dQ32ojKakgLFomXkbnVQvsY8Oirvnqb296SIuGqppn8OblakQIYDoL5CIfQ0jPUV8HSjhSzwfJOOumcf4YCJZYoZbnlOvndaYbQudNTLx6fXPzdUoFBYL9R92qbh+n6HIPHdh0jmMqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0Bs91rCP7StOCmw1MtsQl5z8q9vbny4SUOZi0TF3Jk=;
 b=FLV5D+fXee0hQb7qDM6bJMaJEquz57vZsJFGByPiwU2YH15fTQctnE4E04RwVwAvU2JZAfou+QxQbwbsZjlQnFAKX1TAxAd+C4W7n/J0thtQ8ptQq976he1G+nBWnLQsUyhhXe6tL9T9k4ZX08QxB+eU2uTrQwVlVjGFuzQA1hxax1l+xv+BzVteo33Yk2ErQyXj+xD4oUpLFkb2/9XQ19YUbzIytIo1b3kOAIWA2I0cecA4BtuFOS69wiRNKiyWgwipAxwx9AAZSQtOJR6qXnPvqyRpWYbZp238RdiPvXaCyyIOIVdh3DE1yJx8MVuESMyIZvKhHLaROOpth0tNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0Bs91rCP7StOCmw1MtsQl5z8q9vbny4SUOZi0TF3Jk=;
 b=GRj4n8IEIsqlDezdMIIpZ6OwVFVbP61ct5fObaXY4sN0OWGZuT/5ULDPpC0vv3C8uCWsCRwY4+XlGXV94yY+5sCvpafZ19rqChn2xJngJTrVZ5gF38l4W2CM5rCRqCRxbRKh6AVxUXYoy54jIBTzpv1hot9fh4A37ioS9OHNmz0N3WSIsIxsc6Qfj3WqWgo7yfodPcu7XGGdjnpHIjBzR5HnXdHU0B/0Hy/UHxKbbpiJZb0WHZ1jKrs3HFFC0xqQSz5Dx3YwsteBG425Sw9Y0EW4wo7vLDYVo9o6QX5wYWJV1XSnfuFNlJ7kVyYOiI44dWIuxK9MGMBCZb989+IrIA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS8P189MB2531.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:638::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Mon, 17 Aug 2026 07:53:54 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0339.004; Mon, 17 Aug 2026
 07:53:54 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ajith P V <ajithpv.linux@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Topic: [PATCH net-next v3] tipc: replace deprecated strcpy with strscpy
 in tipc_bearer_get_name()
Thread-Index: AQHdKw27UrEd0upBxk2KDIwhW6eFmradP1FJgABDBoCAAAGxUYAANDsAgAQq3xA=
Date: Mon, 17 Aug 2026 07:53:53 +0000
Message-ID:
 <GV1P189MB1988B4FA71085BFFB31AF4CDC6A72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <GV1P189MB1988CAF7D299010DB0C80031C6DA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260814160846.338273-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260814160846.338273-1-ajithpv.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS8P189MB2531:EE_
x-ms-office365-filtering-correlation-id: 63ee3cc9-05dd-4e7f-b09c-08defc34af0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|38070700021|13003099007|6133799003|10067099003|4143699003|11063799006|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cHabRc55AbGBergt5KhTNBHvmcHxMMNyIacG5lHhVJzjs2ED8H2f4Ig7kNe7IRe2/EhJxPvHoL3rtViBPnJhkdQ8d3NQ2u1fkhQrOCQFvc0fXgOF263odI4YnZOPJ4BEPWlLsxn2Nc16DHCfeJAEVhEuNGGvEzdHWc7/rg5vr2b+1AyQYL2aF5/C5W8z/pkU3nBDGSoMh6DEA1TSTu9TwrcEP4ecqcXPWlpCR61hjCsR5GuuvfIpGrxYE/hZH5JSYJWUg+V/g8fbSzlinh9C2S6jJlmOwOYlPn3+DHXhrmDz1NUei2GuudY36RHgu0T2Cs5uuY0FiK79XO1YjunoBoxSoCL6T4wZ2kOLYI4+4H2m1RZ+kGUiNq/cCXYx5rDCaxWvYGVeAf6/TJ4uv45UJgrihIjmRQ6+ZE9Hihh/Rp0OUJnrzNOx1Eytsa/K/JKtupoSxhCjkuIQJBFRm7jpdZRLdSlHSOAfdBew45RKgcuaxUx0S5xPguEi593P7r9uyrADwO6URiMCUFVL9vR9C1o7AxVnpSBNKVfEBGIuup5qXTvumo0dB428pUQ3XxTzlJQIWOXN1+4WMZhuqCzr7FOiiEhEDtx1IQYpWUZXIZTwjvaAoxkLW/D8i8kv2l5R8WK0hB5+QHnxhx4eo3hPuiEC2zJo1nbVcr81DDvkbbWX//6GOvgN5yE/+idQ8l1U1kYZfqMPLG6W/E+VN7a3Npk55Bn0IyN6PtYmQCy6NtE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(38070700021)(13003099007)(6133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RSsuSLAE/+D9yea+Hw8XwGLblxkHAK7t1lOFuwc0sOvd4UtSi1pJUbph01Yx?=
 =?us-ascii?Q?Z8osc5/HzZ21E+OW44YSJr9lWkw9CSGIidXJonM9OnPtct6bqMfZjfD6j+N1?=
 =?us-ascii?Q?N2U/UimEKyAQn7Nc9v+0FW6IMCZutXDM7mfsF/BJmfLh82HWQefzQ+eW3mp6?=
 =?us-ascii?Q?phTbay0BNpwQBRcC9YN5Q/t/Q2k5sXdvG1QxCIqHqqGyDinOrdoTCzSUAIPH?=
 =?us-ascii?Q?bRuv8eJvkSAQ+gck5jJ3t7+PYKH4qkUsXucM2KU+LnZ8O+VvKZDcyB+W9fip?=
 =?us-ascii?Q?ZlIaqoxG/fnUFeEeYBc4wlfAOCnz8ufGFTEUYfCThQQv5Di1piBn6i3IB60Y?=
 =?us-ascii?Q?ugy7MMJoFt8G4mFnvW2fFAKWeyxg9py+j/C2AtroJFuAG1g6ne0yCz3zIPAf?=
 =?us-ascii?Q?j1RzIJwzc8OB+fTFR0S9xQC8DvrppOLHJuRj4sFieKbdpYs0GjV/j2/yMOLx?=
 =?us-ascii?Q?I9IN8SWkobWIIK4ICW8X4X89Faasp9nVQjsnmkQq0etPEkDkxPdrBRg6eRpZ?=
 =?us-ascii?Q?XKmeuy8kmlZg/2wXoIugWlCy8HUA/2MjhOSA6SxDmmmx7jLZJf4ynlAtjJQZ?=
 =?us-ascii?Q?vuTNxiFrcE6hOmtJEp7d+4sHUlAhxLx5LXXtTbCkodnfjpcb5S2npQ1r4xcf?=
 =?us-ascii?Q?ToAB5p65+Uwv1ePKAavSpX/0ze5K4YSqQO39S6481lMdFj+AScJVdF2ARsD8?=
 =?us-ascii?Q?zdnkoh0FpLJWwXJW72osb1VoyXxxYteST/cChbuAp6iNUrdI29tSdE1o/wsI?=
 =?us-ascii?Q?dTsVaAfPie/wsXwNULbgowFhRhc8EkJryyeP74P70n7iH08xoDetDo1nFWnh?=
 =?us-ascii?Q?a9KBF6e3zxQ32UxIua40fKSMCls6RLoiNMmyO5X9AIGAw+AuXRBQMKNg7F0j?=
 =?us-ascii?Q?Z7b5uSWVmzwr3ozTKCyOivjbAKfVJtvvXdKE+DSjSRBGaM/Q/cNEWQ3XfDU0?=
 =?us-ascii?Q?aXrYtb2SBtB5Q86l7Q2v7G0xTdZRA7lASLuMW6jTrXUn56o8X31upx8fMqCx?=
 =?us-ascii?Q?QoL7NA+jGKOV43s3b3Vf/jAAcGe35mhIedFnrSVvuxfpyxHbAcDnBbDKqKxq?=
 =?us-ascii?Q?V19OkHJHUgQh+0KIRimoLJjFdpEvi2RkolM/nvwZdaTQPNKwY9vVE8y5Jdbw?=
 =?us-ascii?Q?LetjtLSENRCgAXa0oSYBpLGG5bt6JZh/MPyuFfUpVk6M5PPSfgjjaJslDBas?=
 =?us-ascii?Q?utSLnFrwxTmdBWtzZ0p0M518TigEplBMINWrYXYILP7BKDSI1NuhL43aNFiV?=
 =?us-ascii?Q?p0BsW45sVwn5MwB0pRTI/QeTV8l3TdHuFNlmuliWOBkGts9ZUp8fUwdvNB/V?=
 =?us-ascii?Q?0Zs92P1BGkv062R7zrC+7BUo/6pgoCdlUTao4vWk6UXq9wycieFEIGiDSkH7?=
 =?us-ascii?Q?iEeaPaAzA1IcyiI0NDxI9X1G5ctVYwQmO7tIKif3bbv6u4/dhzr7znyL6K0U?=
 =?us-ascii?Q?svUDBS2fw3xx2ZcdlID8By9WzpoYQN8vjynvfDUIh8rYKmhjNDXWjZB6fcJz?=
 =?us-ascii?Q?x1rmWzU00tDYvkWD8MJ4I/684yMk3JygsgDHoe/EHt1VK4o/3JUOd1CeCcXQ?=
 =?us-ascii?Q?pXz0UMTf+8VJOB/L6jKD6DS6P7saj+JNKxjmH5tPRlm4ci4jcKk+YonnVRXc?=
 =?us-ascii?Q?jo0iNmbtDbMgvYSR9mIu0k5muIy3vXWaA2B0iDJFSkObL9CYGOlikE1WpSN0?=
 =?us-ascii?Q?4NDUGLwADXH8n0NQJ9ZZDksRkcey9l/DTHp+h9fRssAS1SENnIL0TQBrTgoH?=
 =?us-ascii?Q?4QWRuZfMYA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ee3cc9-05dd-4e7f-b09c-08defc34af0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 07:53:53.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGJqI7H1dofGdr0ieXcB5MRAZDv1IUPCMfSUREvykTWfVx/NFl3VCkZ0anqMbOes/aZZhLg+XgI9rXrgF3JR4WuMkpOBSJq5wCMhkIiJuKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2531

>Subject: Re: [PATCH net-next v3] tipc: replace deprecated strcpy with strs=
cpy in
>tipc_bearer_get_name()
>
>> net tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
>> net-next tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>
>Thank you. I tried the correct net-next tree. The same patch applied
>successfully here also as shown below.
>
><path of the linux tree>/net-next$ ls
>arch   certs    CREDITS  Documentation  fs       init      ipc     Kconfig=
  lib
>MAINTAINERS  mm   README  samples  security  tools  virt
>block  COPYING  crypto   drivers        include  io_uring  Kbuild  kernel =
  LICENSES
>Makefile     net  rust    scripts  sound     usr
><path of the linux tree>/net-next$ git remote -v
>origin	https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>(fetch)
>origin	https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>(push)
><path of the linux tree>/net-next$ git am ../../patches/v3-0001-tipc-repla=
ce-
>deprecated-strcpy-with-strscpy-in-ti.patch
>Applying: tipc: replace deprecated strcpy with strscpy in
>tipc_bearer_get_name() <path of the linux tree>/net-next$ git branch
>* main
><path of the linux tree>/net-next$
>
>Am I missing something?

I see that your patch was applied again successfully after failure.
There is one feedback from AI review that I see valid:
[...]
> @@ -209,7 +209,7 @@ int tipc_bearer_get_name(struct net *net, char *name,=
 u32 bearer_id)
>  	if (!b)
>  		return -EINVAL;
> =20
> -	strcpy(name, b->name);
> +	strscpy(name, b->name, TIPC_MAX_BEARER_NAME);
This isn't a bug, but the destination capacity is now hard-coded in the
body while the interface says nothing about it.  The declaration in
net/tipc/bearer.h is still:
	int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id);
and the comment directly above the implementation only says:
	 *     @name: a pointer to the buffer where the name will be stored.
Should the TIPC_MAX_BEARER_NAME requirement be spelled out in the comment
or in the prototype, so that the interface and the body agree?
In the current tree there is no behavioural change: the only caller is
__tipc_nl_add_monitor() in net/tipc/monitor.c, which declares
char bearer_name[TIPC_MAX_BEARER_NAME], and the source is
char name[TIPC_MAX_BEARER_NAME] in struct tipc_bearer, so the copy can
neither truncate nor overflow.
The strscpy() return value is also discarded, so a future caller passing a
smaller buffer would get a silently truncated name plus a return of 0.
Would passing a size_t len from the caller (sizeof(bearer_name)) and
forwarding strscpy()'s -E2BIG through the existing int return be preferable
to a hard-coded bound?
[...]

Please update your patch and send the new version after Aug 31st. (Because =
net-next is closed now)
