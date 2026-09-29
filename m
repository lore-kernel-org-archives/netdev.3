Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4F2F9D98
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646115; cv=fail; b=cuODROxA1qBK78nUM98b5QFCMWf79nBMOMbeAQt5iglA7PSpygI9oKhFmiFpPYVNjNhyKBKs9ULk0Qf9Q7ZERfNYrEi4cpK1cq5WbVln94YlaoqeF8oEODZSfY9Y2aVXJya1kiEUiWO2c3f4B3Xr0LLS+rmpdAQltXMZYUbPjE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646115; c=relaxed/simple;
	bh=03KC3AiSwokEYbeimRHyDcGeWliEZ8pGe5C1vIcblwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lK27i4BmWVA4kPTuThIsrG3rbhnZYmN1YQvCsPvhXglmM2VnJkDSr5Swb1xUL+fDHUYrDJHl7brXmZSvj97j8Ju3HaZuAZOWG1szPgDWDzw+LJALN6nRKXYpBbYA06d3tbFkiAdCio4gw8Jza51yV66lCSUlAM4IQU8a55owQHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=appgate.com; spf=pass smtp.mailfrom=appgate.com; dkim=pass (1024-bit key) header.d=appgate.com header.i=@appgate.com header.b=mppoSfgP; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=appgate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=appgate.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=appgate.com header.i=@appgate.com header.b="mppoSfgP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgwH6t/w68hU1TWHnX20TkPRivn3JRrI+Vu59rQApH855o93avQ1lkNufXUZkew36OYCAlM8E0UBf6Q5/Cnr0pPfUiz9PlJJ0JoiO6RhGeceH0sKJnCxAeGtENA9geR0nzYYUeIbTS8OSQ+dDhYNOUm5UcKcOdI3ijYYY6sN4cESVcNLgmyel56cgtIsBDRjPQRMgDc/XCfPIQA+DICSuel17j4STYfeYX+PvdPDGONQ4+MjCB774PSF4fbjVCnh5M1WCDLvqoa2WltWs6VmZmsAqN86BeI//wrU1jNMVCvsFp5trvYyGKb/Opag0UO+2te/3rCpqkPITmiovkeeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=hDCbBmTFCo4Hyl+0Y75ENOzoSMlUOCmT2OXeisJ1L9M=;
 b=rk8XZG8NXIwcqDzu/dY/prgK/EYqmTHtYsb1WhRIOqHpzF3Ldcyty3V/CiKpZTZfUFfKruaAqgsaCUjDxixMLzlOExXOrGu/5DMac7YuWV6zjpbJ8ZT81TyqT0t+ZAE3NuPG0ykvkLZd93zHPhMOCI8mtxJK12K4K57ZTJho4S6F2dHuZJ4xJj2yWc0X4YK/QbPpIndsj6E/DlVAmzrHt37y4VIqvcf+rW9VLvXiKs32J8vWJaFKIphZun01RHqU5/S9yWoj+/JBaexWqdNJ6JZy45aATLKFPpsOkyj/uS35JOtscGcPQLwf/nqgDoze7nspFLjnEeguMrQEGI8QWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=appgate.com; dmarc=pass action=none header.from=appgate.com;
 dkim=pass header.d=appgate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=appgate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDCbBmTFCo4Hyl+0Y75ENOzoSMlUOCmT2OXeisJ1L9M=;
 b=mppoSfgP0NhfdK4nZcZ3mZjLJ1/RZhYbtOnupiMjEYRsznUh7H3seI+ddK0wkfK07mO5Rom/Q6k92YWiqg1YdKtOdIWRkkB+hkac9v9idxsGhT/TrEdK+k/sAqEVfHuaD3uwYbfNmXIYIoDNRnI4qsbAA4GDtWMsRUCe6Ka+ufc=
Received: from SA0PR05MB7323.namprd05.prod.outlook.com (2603:10b6:806:b7::17)
 by CO6PR05MB7652.namprd05.prod.outlook.com (2603:10b6:5:341::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:41:48 +0000
Received: from SA0PR05MB7323.namprd05.prod.outlook.com
 ([fe80::4a46:38d1:2952:3ae]) by SA0PR05MB7323.namprd05.prod.outlook.com
 ([fe80::4a46:38d1:2952:3ae%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:41:47 +0000
From: Dave Butler <david.butler@appgate.com>
To: "netdev-bot+sinfo@kernel.org" <netdev-bot+sinfo@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"emil.s.tantilov@intel.com" <emil.s.tantilov@intel.com>,
	"luoxuanqiang@kylinos.cn" <luoxuanqiang@kylinos.cn>,
	"bryan.fraschetti@canonical.com" <bryan.fraschetti@canonical.com>,
	"tristan@talencesecurity.com" <tristan@talencesecurity.com>,
	"tomasz.lichwala@linux.intel.com" <tomasz.lichwala@linux.intel.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
Thread-Topic: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
Thread-Index: AQHdT53B3qRvZUC7m0OkAHwEVzZAtrbknceAgAAiBn0=
Date: Tue, 29 Sep 2026 01:41:47 +0000
Message-ID:
 <SA0PR05MB7323DC46F887920C5983712A8B8C2@SA0PR05MB7323.namprd05.prod.outlook.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <179063700944.31693.1912265472568249345@kernel.org>
In-Reply-To: <179063700944.31693.1912265472568249345@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=appgate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR05MB7323:EE_|CO6PR05MB7652:EE_
x-ms-office365-filtering-correlation-id: 2c41b492-ce74-410b-8a69-08df1dcad354
x-appgate-rule-whitelistdomains: triggered
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|6133799003|56012099006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 BpGTZa787P6hnxdx38UrRhVVFx+uy5lbhKvztSXHnOXEx/J2JWZTQJnrD4jF24yXpI1kUv9soItli0lZQxJGr7002eidLWPZKeOwf+NV0tD7PAU4dri9ydhZ1LU11exXLC1OKCvxxZaA1BegmLG4rGlI0z3X8RcjUcZLCRr6ISN+y+6S6jo65Se1rWGaolCuilAPjI36NPok2zZ6hgGYZ67R9pFyhLk+ADtIYElXcN0AeNj6BfXw0Z251yLpFCx2R+yJlSgXuMgZRmu9RHeuJViqT1DWMI9lmVz5ZbziLCx+I5aqun9ZSl0bL6Bb2gh4QoSknRB8cTI+c40t2mJqRw1gIbBPLejh9UTuXchHTqtQMl/XqXPottxQ5L+cKfxD9jWnbnEHdWI/SCdnZEx6l23SoHmMkqPaFLzN2TszwkuHHWB7T5KS5s3aoLclZ1ANXNFbr5HQeSm+pEJ+JSIxrN5aLjXix2LhcFNbMjOlz7W4N7uUawLk07v4GHcHgOmkG0QhONxGpyOsFZM1dgJgBonQRQS8qj2NRCjApQw6KwTD25rugNPLOBUFBh2KuYGdpeGpRgGWZTeka4SUGTokjkha2twzZg6OmPn3xKSvbHZhb2QKPZCV0RJE4YNYzSYfu49VaLhb8NEF99SEUS/uh+UnzH0425zNayB+8jgbKAFoPl4fbhY0liV5D0hjgdq7LHza7JwV4zzhbkNo0Fu+efQZBzZdtof/w7yt14EHzq0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR05MB7323.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?T1kc6KuI8wLd5Atjgc+LI28p74Rol4X1qHO3DbMIwj4CdHrpV6LvCxmdVG?=
 =?iso-8859-1?Q?isuqoSbMTEdfRgC5io957AwTp9BnEEuJJnWKGLvPzDi49fGebr4C0CocGw?=
 =?iso-8859-1?Q?PZ4F5QYFBE9c1rfZdug++DbCK9g1JJFOIjl2q5gb3edLYMSv/nJIxAPYyt?=
 =?iso-8859-1?Q?XxiB596UURarpiyGU2jp9GSBbJuDyOcSdtu0PzcPxYkOPSa3qp6fw/5rRs?=
 =?iso-8859-1?Q?NP/+4KmdREcwZAy8/aBXM+S2kNE64mdUnrMIWHVHXFmg3E5kyX+CxfQ7xy?=
 =?iso-8859-1?Q?CGfvgFFr3YU6EFSwifpHy7V2x2IeiVf2r1HiyqIB1EnDSCY5MGUEL5caDD?=
 =?iso-8859-1?Q?DAtpTdxGlKqVyNqQq4kFK4QwIMpwcyYT1Hk2J/DkCdFnmcPZJVWCATzqQx?=
 =?iso-8859-1?Q?FjvAI4L9JTKUu83AN3bfgCHG4mPkx/ewuQrfJEUtlZnM2vcctaDa9tmQ7H?=
 =?iso-8859-1?Q?IauVEa0SF02Q+D37o+wxc+Kdic2jWf16fxBj9JI82TsF0z2F+qB/YnqTGU?=
 =?iso-8859-1?Q?Y+yH/QMEk0k1mM2bPkCRheitPAuQuwSKVJBhhwYxBqkcLcHMn0zpO5thcR?=
 =?iso-8859-1?Q?4dRQkYSJ513ZGMatTrkwvuRWkbYmC+CKoPdddVLe1l56N6sH8lnc6yB4H9?=
 =?iso-8859-1?Q?I4hxSs+k6eHp5GXUAL/GvTQW6jIwVinsquUhXeEOtB8myXxre5B/sdZy9P?=
 =?iso-8859-1?Q?gmK3GPFrWGwKyL9aZ8Ay0y4LD3P+CCSH1c/ojx7hDwFp1o5rxeArW45K3x?=
 =?iso-8859-1?Q?ADLOmU3Vy6YYn49gtK1JgBqWVgEws9Ncq6S8yO8+w94U9rSn7a9si0G9MI?=
 =?iso-8859-1?Q?hamZghYvga8Ioiuhz6v6gJoGWdJJEom4ff8GL1/1U7mbPKt1Dk6+3YhkX7?=
 =?iso-8859-1?Q?bDewyvVXT+x6Wj9cZAkINvqlA+f9NtuGWYaK+CokRXknH3yH1kTtOKv3y4?=
 =?iso-8859-1?Q?4vsz+6qzDiYv+FSuBthpLfDpYYG3NDxRM4tN520154hXPAZDAtAdMvGBZF?=
 =?iso-8859-1?Q?Z12Wvehv40XYz2iyrYigZJ6Ewkrgp0N70zK2ieq7mTRpkP3mUi8tGuXVEh?=
 =?iso-8859-1?Q?9lrUIZ2Sj0wstC5qo9iCSvyguVfjTDB92ZDbDViY384lDvi3pztJ3rjEns?=
 =?iso-8859-1?Q?VEVsjKSndck17VGhGXxFQF0Cz3f8pmPf+zJ7IAj386A29ddAogx/ggbnDU?=
 =?iso-8859-1?Q?cN5b9o1XxNedsblondzvh/tLnWzoe4wGerBZqJ9HQdFdGOs+xZwe3k+FUu?=
 =?iso-8859-1?Q?hnx5iZACVWQ62ifF0BMLzr/Gm8+9yQNajPvP9edTYUAGyEx1Uo/3LOW8ra?=
 =?iso-8859-1?Q?499nYCtt6riTXjK0LbLrPTquI/cZ2kROj1hVCXEkDSA1sqaEvDyMGBdP3/?=
 =?iso-8859-1?Q?ZmewpmgKR2p5IO8cX/V5Ayp7pC0KvZAKczXRqJB01cY5hxfNjGltDpsCqN?=
 =?iso-8859-1?Q?3C/mikXP783RZE8i3PZZRI0FirpbHFmhP+7LQMrhtQGkKnenhCx/FTRcnm?=
 =?iso-8859-1?Q?CPGLvVU//O6uDtlB+leny/k++VZptKpeI0ya77aYqgf3G7xVYELlvVGU9v?=
 =?iso-8859-1?Q?GAiXheyoLUdhKhqCTmbkGNXOR6b306K1I/5JhZEtFnIWPMVGiBY00eJahx?=
 =?iso-8859-1?Q?VxalMG1JJqbMwL4AgKUg8wFEfY7YI/gZ+PJ7cvhlZKRCwDSle0gwfMrA+i?=
 =?iso-8859-1?Q?D+Mx+8QjQ9wkZ9jx+wLVLtmEx1QFPF8JJeIVf68TusUV9dRWjofDbNJ75E?=
 =?iso-8859-1?Q?RDAg0dC20O1YogZ0srOyp3NPtYmp7aGXZHejcpo3DxsaP0YCdn6NhrDTTN?=
 =?iso-8859-1?Q?7t1Ou3Xeuw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: appgate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR05MB7323.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c41b492-ce74-410b-8a69-08df1dcad354
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 01:41:47.5734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b93e809a-49c5-4a0f-a606-82b846acc30d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWEWiKTJ9LARpwk2qgADt6x6SrYN7pWEY5XJKxGAxILewxtGC10p0xXY+PFb/DUTumnwU3y5XOXIEK3KA9o0ROSkxchBsLeguFAhUJNf+Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7652

Answers inline for :
iavf: cap advertised max_pkt_size at the single-buffer HW limit

> How the issue was discovered

Found in the field, in a real production environment, and reproduced in lab=
.

> Whether the issue was actually triggered, or is only theoretical. If it w=
as triggered please include the symptoms, like the stack trace or error mes=
sages.

The issue was actually triggered.  VM and/or hypervisor can lose all NIC fu=
nctionality, VM may stall or crash.

esxi icen logs may include the following:

        icen_ConfigureTxQueue: VSI 8: Failed to set LAN Tx queue context fo=
r absolute Tx queue 64, Error: ICE_ERR_PARAM
        indrv_SendMsgToVf: VF 0: Failed opcode 6, Error -5

kernel messages may include the following:

        iavf 0000:03:00.0: PF returned error -5 (IAVF_ERR_PARAM) to our req=
uest 6
        iavf 0000:03:00.0 ethX: NETDEV WATCHDOG: transmit queue N timed out

> What hardware the change was tested on. For driver fixes please mention t=
he device (and if relevant firmware version) used for testing, or say that =
the change was not tested on real hardware.

Key hardware for reproduction is E810 NIC, running on esxi (icen) with SR-I=
OV enabled.

E810 NVM revisions: 3.00, 4.51
icen versions: 1.14.2.0, 2.3.3.0

>The evaluation is done by an LLM so it may be wrong, if you think that is =
the case please reply and explain.
This information was covered comprehensively in the commit messages, but ha=
ppy to repeat here.
The information contained in this electronic mail is confidential informati=
on intended only for the use of the individual(s) or entity(s) named. If th=
e reader of the message is not the addressee (or authorized to receive for =
the addressee), you are hereby notified that any dissemination, distributio=
n or copying of this communication is strictly prohibited. If you have rece=
ived this communication in error, please immediately notify the sender by r=
eply e-mail and/or by telephone and destroy the original message.
