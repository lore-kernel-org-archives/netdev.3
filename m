Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDC3D9DC0;
	Thu,  6 Aug 2026 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058695; cv=fail; b=EXhMcToyW6JRR7KP2AK0lNtT/7jJFOD4U5e7Z/my3fqLoTeREHj4ZQZqVTR6GEO4+ovwE0sO5qneRSHBOB8Y+8M7lFg8lTcylEpFt7D84iJnUbA5v4LKmIBthV4OcNcu+m4KjWSv8CYEXfqi+f4ss6zdlx11DdbZqwVh65xkMM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058695; c=relaxed/simple;
	bh=ob8Ym42w5b3cbNsRsSZ9Eaq+hlKFpBIC/u1Ni7UPUj4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T/Tyh6oRk3+DQEwjO9qMChvbyp51UQl1BlkkH/SYvEkhOYjsySBacITTM76siwvg3HM9ePMP7XxeesI1jFRLQWWca5PnRlxaW+TXRGSMkSarSTbSL54bfuX/RH+okJ0uEB+o9o6Q9sAoVZqTe8P62K0XWq3ILR4Qp7I4LxPs3IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=C/mNLlpf; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=ohDjqz8i; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="C/mNLlpf";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="ohDjqz8i"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7415F1CA8D5;
	Thu,  6 Aug 2026 23:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=7rmbwvu+YTfoRyWRVmyVvrgkNxXW4grHB1Rktsu07Wc=;
 b=C/mNLlpfFTylC4ELU00wnAwOxmvMhSFoWQ9IrwPJdvgtNmqrOOTnz5sE/GI8XoELENgUCryjyk8szCzVop+4Z6exOEj4Tu5vd2KPaEdZL1PaWzWfP//92myY4Y+cn/pdGKBm/6E4fetJ+y26k2kS27KeQJvx5rGoYAiwNYmbvVTnMCx96f7K6gmKu5SW4XDcuJuyRGAhZwZ6v7s7GKNHLFU6gH+85DKPxHNkOIzEpolZxs2ADFX59zM1LIgTmWGV4b+enKK6/0hFAHKefqT138OPZcYcRHQKdXk7oBv8er/OpMZU3hvnZqvbtqVjVsLpop9tlZGAt9+NNNjO4ylMlQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022118.outbound.protection.outlook.com [52.101.48.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5C27780069;
	Thu,  6 Aug 2026 23:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+mXn5Qwit8LvFnya4PNK+NIQF+CmIQJaCqD2HjFWN9jQIkzCCrbOAj92o+grXxa0ByxD7lxL3/Cwc+R02NmhSQqm7lJNr+CRySMUazbLmb/iAFBfm3r1qDNluvfMEfNy8BH9r0wAx3Ox/DxYqKdFLySeCBis8s7ei+4fjWVYuWZjIai4lvUD/QEaD03os4ZWlz1pne0iVfHCWnz0CtU9y6UXNK6MqONH4dtmRmB9xjFMp4YKzM7dNx4h68o0m5IDEVMeV5xyNZ9NKlqpaxKAu1+hjoQxbeoLfr+N16FUL1dSvTi5XU1EKLDv9o5/iMXwfbzX/EIejH4pq1vAaHHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rmbwvu+YTfoRyWRVmyVvrgkNxXW4grHB1Rktsu07Wc=;
 b=B/g28okSIrka9BH3zop1AvlvGgu+4XWnwrSfYW3AYxEKJvaq8P/UjC/UWJsf2G/VfrRo9G3Z+67NhAjSxVJ5DPItcJJ/XH1bCEEt9gtK2tl2POAT4xif/9OrSmtYL6QnvJZJuuXt23T9UsOHM+vLGIXAkKXsbqQIqdPhHKsdgaOyMpe1xm+Dd1V4cUL6yFQYxSAxONFmt5n3CPWO5CSDI2NaqjzegHilZIP2+g6yR34xs+crAtED60DVfVPv0h9K4cqCrb6UaGA0bU/OUEgd9E7kxl2IqDYelJByMqQ0ZMRZ682Zu1756nbW4ALzou2JudCjeYW5wKo5xWY7cP9Sow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rmbwvu+YTfoRyWRVmyVvrgkNxXW4grHB1Rktsu07Wc=;
 b=ohDjqz8i2nAWSUjrZbFhgg8QHZ/wYKKRZXWTnoQBZaTl+pFDtvLlW+EvfXt/2gNR/UlzRFda2EwHsztxgxoQhVyN8oTj4pkVmyzQFFJUX94tgM+yQFRrGKZecNOkhk2/4BJ8/+1vhx3apFgxvBe5fPoSAsPPh2hYPpSsHDuuHoP9o58io/kjm/OzN4Xm50h1DpmnfV6+aAOlCLqBoJdPEiPiYg1MbKcx52zVgBth0Z74Ge0fXRssW6iwMQ3o5o6cTNPWhb6cmN35tgbtNHVOJtJkNbP+dImi6lqHW/N8nwTsvjnBnhUG69j6VZaSev3/Q6JnFGaDdVS0/TBTwdK46w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CY5PR20MB5045.namprd20.prod.outlook.com
 (2603:10b6:930:33::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:24:41 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0292.015; Thu, 6 Aug 2026
 23:24:41 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v4 0/3] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH net-next v4 0/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdJfrBQv5VoGoeZU+xnMYALO3w2g==
Date: Thu, 6 Aug 2026 23:24:40 +0000
Message-ID: <20260806232439.27551-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CY5PR20MB5045:EE_
x-ms-office365-filtering-correlation-id: 99e8e708-1a96-4371-7580-08def411e3f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 Ziwf6TMWAianB8XhT1RaVS+9aMgUxRA2cvjvyEYPo8CC/9l1KAO57h6OwrAGmbc6F49Nx3eQjkRuIKLIeoKmrDe2tpuV2p19B/GoZgda+aDWufSd4zOqNHBAGkk/y9EsvcNVfzg5eFwKjDPp4z+0lmNItvOhd8UVYGqo5z2QBas2G49c0P1GhhduEH/al6QCR7YaavqJKuodK1A9wYurFQKrARlsUosCSUd/aMfaiXBPqrd9lQT/3rDhjOpTNd1Ns+gjsqiRuY/8aId2zysEvx09PJqlVGxaxymSbsusqdkZT9V0XePCl8wJwh5yDL32B2O0lqrqIDz6aG8wsFQOAt8Ajfo+DgqMIZLJG/9OPn+MO18DhvQBVhusajXQ4fZ5C1dBWQB+XxoF5LMBBrJTyr02RwzRppST2uIrUjnOtC1EEvFe1X/dI9zDzQUcOr/CZOXhprk1QuxdRkQEFdqiV3UkYD3EEoaljT7BsITMj/Vkraj2P8AXCbUlTK7xKjB8vvUChnZk9vXEqT4BFV4i/n7oCdMBfsIv6mWaBb3QBNGKMvDsM+D8Na/JzRGlr+IYarF32DtkPSgzJ69GlQWnXLeiBGHlC/8F5WPkeWHZffWxsLMVUVujklBn85W80sGXz1paqN+tEzY5x00Rmc4F8K7mOjiWtkatT2ZNb33EeeD6NL8rkIbxEUN2Y3KiVRMntDV89ilUTDboNik/a3MHJhkOXAXfi5HYQJVsfVBk1xc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VxEAu2KjbKo/7eCGpG+6Lqws7a7nP4wLjLW53OV0VumOsvJL1pJWGCX5NC?=
 =?iso-8859-1?Q?eKcz7riMEzqAs2Cc3YL2k9uagzQnqVAaRpoJsHOj22cJiRStH9g3+lkkqG?=
 =?iso-8859-1?Q?+qqgR/kUiLjkDWYosjDUR+x263lLWZxZZBXAzyoYnaycOGZfGPTGSp2+m9?=
 =?iso-8859-1?Q?sxXyk+a2Rel2Lmo2XQZ+1WKD/p+I2n1AGkIrGTyUfGyFAe42Zchce01JCC?=
 =?iso-8859-1?Q?7IBKnJiR84Qj3giOumajNoHjuFbIbmNm1jwzo06Dad7bB7OhC9K7tCBDWJ?=
 =?iso-8859-1?Q?bdhurKBWoIzXjV6wEqW/TsNQdRo4hFjYRys3z0ZMw2wGamH9Gpli9UzuyS?=
 =?iso-8859-1?Q?hX1iepTmBndw/RFzTEEkgZw7KyhzNKuok3lkp7XJEl3sd4j36ovkOkKa7F?=
 =?iso-8859-1?Q?QA61HuYrvjoYc6r2dwPT/Fn/fzcAboK+gsHDhP8UGVaN3FGnNAqfZbBCjh?=
 =?iso-8859-1?Q?VvG5cXqA7GUNY93FRkf+uVyI57RTNC6zM9tybQOd42wpoedYf4tJrU8w2F?=
 =?iso-8859-1?Q?6/N/XUxX/4T+g1flHP507ESeCNd5s6uiGkkii7yuXeYqQEOzVqbUKlTeFm?=
 =?iso-8859-1?Q?CMoIrIw965ha8bHe5qNUObhyUkjjgdY/dGgQU+hPwtBYYeLEp4MHgZ0Fb+?=
 =?iso-8859-1?Q?+NhygIfT2fxKZccPvgQlbtKiAzIV43PvuYavZc4A9qxI7SBW8wn5Vja8FY?=
 =?iso-8859-1?Q?oHpGatLG/zyeSWf6m9gf86kemhTHk8pxWQOifLPM5x+4+yCR2Kpg3sSneY?=
 =?iso-8859-1?Q?cIrsdEkTMSt1J4oFc5077zQ+vWbtms1csnTGK95NyE1DGvVKxdjVZ20FqZ?=
 =?iso-8859-1?Q?UbgGF5189fJHoSvkGPKDKRYFjOAogeoNvzMWd6FMGAWYcwr9HQlmfjV/7x?=
 =?iso-8859-1?Q?W+uWFTxb8HlLVA0rjfUSydOUg3ziakSC7emB2s3W4pMu0cjo9HPY7mIRT4?=
 =?iso-8859-1?Q?cqKJ6wcaFZ2rMeVQ/YWf6SrTPltU36p3G/wwRX/h0bETFPfVdA7hJeneTa?=
 =?iso-8859-1?Q?0VIi2RkFGCbaPszCrI4unuNUvOnRrNKx1Mxqq2/65+38SenLeWVNZpJgXk?=
 =?iso-8859-1?Q?1yIhOaHtMMoLrmbLukpOjzqCqB3j6gLZenlzjqR+arGr53VQL2kX8IQr2J?=
 =?iso-8859-1?Q?CDi87nW6+sQ8MEkvqAhnHBhQGExIP3l8XjMipYIBXcTlYlqTAvoRYzKPhY?=
 =?iso-8859-1?Q?L9uCNzWSy814Y8Nh3fWrwHByRzYeF8phTBQf8AUnPK3kNbOHRp3KKRBfvf?=
 =?iso-8859-1?Q?Hy7rWk8Qd3Wqdt2us00Im+Iv6bzHqsvet8O4i3icIvMUBQ/wcdCXpvj7mm?=
 =?iso-8859-1?Q?vAXQIn4IKXSRmJpD04PIN8dZ0ccuy7GpXJGpDFYIG2sJbRMv8P6nBzh2v9?=
 =?iso-8859-1?Q?FSmJF0XssDW1uHOW3K1XeIAtvEgNaPBwKy53dzh7gA7LSPg2SgZLVP8tgm?=
 =?iso-8859-1?Q?xvxneOvTVrIT7H40G4ERMv3u1vetO9X9mEzzceO5jVuqmMy54GE9HsIlrP?=
 =?iso-8859-1?Q?mgwKll3VzTqdTe1uNZNXBCj/lqx8nTL6hpNEl45dsL4HqrpwkhXT8M4iRy?=
 =?iso-8859-1?Q?23RdRydjunR7JWuhbtowBuDgJdjQRRVcKQQ5S4Kz75Ei/eEErCnhE5FwmI?=
 =?iso-8859-1?Q?hI5GfuIYisfRgCvlz2bQirYy/CSHgcLpIA337nx7E8WhwMziRm7ghEZ/Ww?=
 =?iso-8859-1?Q?ua/tuJsfKaQFfr78IS3HMy21i232S4j9AxeczvJnNoMRVMF0jH115Bzcfa?=
 =?iso-8859-1?Q?DfQQpg28O06yfss1gCTPbFhS7xm+7MNrDDwPYtssAxnCPX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iHBALZZOUsjKwn6XW33Qcsrt9eV48lW+PLled+XNe0TKSpIeIX1tY6bIuaESggkN2n6kIw2A/yRm6Z0aYkyArTZiUaSAz7bpP8aUd9qZ6H5K8ZrBjAdkzfN/HthckodL3/bqcr6FCCIL9bL3f+hZudItzFJy+ODUVN4wWag9yj83rs2Dk8yhH21VWw+VCheZsO/4WwjymM9zmacZHKRft2KKEwDelpXcEzugJ8ZfihLpSJBTujSxczUdq4WRaSn0CddlYlYrwCSjRJstJhHI7BIsbwTFGHMDZ1Z7CKKb8FANJYXCIjY3qi1SRKSj2WfNnSBfDit3HSo/zYHsjsvzmQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e8e708-1a96-4371-7580-08def411e3f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 23:24:40.9484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EIGjn9+pYCDoIyxRzqADY0ysnHXKLKw1Ftyw6LmHtTJ7ZHhiTrDgvSYURjevDh2pw6ciVFYONSAEhBXfmjFWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB5045
X-MDID: 1786058686-z67DoJ07hOsR
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1786058686;z67DoJ07hOsR;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic/manual reference selection, DCO frequency adjustment, and=0A=
on-chip TDC phase-offset measurement, and is used for synchronization=0A=
in telecom, networking, and data-center timing.=0A=
=0A=
The series contains the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
=0A=
v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/=0A=
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/=0A=
v3: https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com=
/=0A=
=0A=
Changes since v3:=0A=
=0A=
  - No functional changes.  v3 was dropped from patchwork because a=0A=
    corporate mail-gateway appended a confidentiality footer in transit;=0A=
    that footer has been suppressed for the kernel lists and this resend=0A=
    is clean.=0A=
  - Rebased onto current net-next; base-commit recorded below.=0A=
=0A=
Ali Rouhi (3):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT9531x clock generator=0A=
  dpll: add SiTime SiT9531x DPLL clock driver=0A=
=0A=
 .../bindings/dpll/sitime,sit9531x.yaml        |  203 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    1 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 3609 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  388 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1580 ++++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   87 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  415 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   39 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  419 ++=0A=
 14 files changed, 6772 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.=
yaml=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.c=0A=
 create mode 100644 drivers/dpll/sit9531x/dpll.h=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
=0A=
base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6=0A=
-- =0A=
2.43.0=0A=
=0A=
