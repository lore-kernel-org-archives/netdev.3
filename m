Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A52563FC9;
	Tue, 13 Oct 2026 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931315; cv=fail; b=aUt2xZIEu/RSDJ8Mf8EeLygva0hu0R82GxvcWuFsj/rf0jv5pC9mL2OlpoioznMgYk3DTe1sFKi7i3At+ZAgc793WMi+HlX5RxnNixrE/oF1YZ76v6z980sQ3nE9bBeebk5XLhAkzCTv1Wb1beziifHsyFg6M2TxpNNhiaftpx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931315; c=relaxed/simple;
	bh=zqNOK67hw68VsaJjK97NrsH7K7V/HvQUTq5PyVDJSmQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cWf4aGlMLaKh5FHBkbIlJeiK45+9G/lSziePL0GCJlAqdJZa4TpqteA6vFfXoE/hcuFWgSMKvqIdkzDrQNDmUFCgo0uMZwnVUv8GF2RTBRk6rjHuFpgmxTNE82OwGDJbBqhbnEv3XmRBbNpcmEYWqsFtVycj1DsZuYzw9imNsNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=i9wDu7kZ; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=VlkkRqh+; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="i9wDu7kZ";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="VlkkRqh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=qvsV2ybl/RrudYaFfom3w65eAca7jflw6zZCFELOGGk=;
 b=i9wDu7kZaQAQoIYOWBW0kVYSVVV1PmSxYq/bIe3Fk2zBsX1hCCjqEDpiKsJMoKbMHhqpKOiXJvQUISDYNspnKFRHg3V6GHNYEokfuub3Iocz3SEeekwgP8ERf4haaPpMQhj8+zxTGut3qAeTBidFgW+YmD7KuoE/IF5KmYDiXWGjmUsLiemCuV+PepzDG8Gsy2lsvo0mIZU6fdzljHhito/ZvsQ7yo94JznMlXneg66RJYeBmuX5L/4lRsgk/CrTxnt43z1WSZlVWCAcUPgStDTzOxB6A5WIEQGgnrb/0hYyJPCTPBco35Qch+LvGLmyAYRhVru+LBgTHDAekSTGvg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021141.outbound.protection.outlook.com [52.101.52.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 27459800079;
	Tue, 13 Oct 2026 22:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbTh2g18lLkUhVJT2gdLRFS253QvqQTimKe1bInUC2+qzOibuWuffqCYZIflTUl1x/q9WBgs+1bdkhWe2TQBjRDUPfHsOLY/1ZlvFcxewbRaSyNxAXet6LP3qcyr/wosHRlI8A8vyRLG5Fy/JpDrfnWnzg2rUzMm1Xa51hffIyIa2XHfSAxvF/xCQLaukm5a4ranVHfUCPAGyo4GDSZtVBdIukD3Rha7E9ubNqxY+pIaWoPcSRtoUPkdsntUb5o7xf8SE2kjhpURkWaAsfy/xOMYFidr3hlOxPWafHhmlhRjqU3bghjl6sWJO8pv7V5ik25hswvBbz3XyqtLd1DUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvsV2ybl/RrudYaFfom3w65eAca7jflw6zZCFELOGGk=;
 b=knLVqkQ8IzuzuxAjZE+HeMNgBkrmxmd+9r21UoonajuGLVq0XQOuYLOTx/EONYxOqYzNfJRN2SV3eXEykLD28cXoYsAOenQu8FGrUl6jNF8ha70UoCTgQuM3SEGP7uDF/chK8wMyzSJ0CTkUSmKyVmdfQDiiteXmx5vwxrvn1Tnv8ShoAmEIKxsA1lm4xGXYZ8+66Ci7t/ONSf8Lx5DwLS6810QtMwHEoQmT3tP/kitc3HF+AgGKRssooS9Qog6ubshZvxpLCaIYPBy/eIwQC7AKlCWUVweONhPjEwYxHLzuxZdPUQrjr5O75LBOIlXZ72CZXMIwEWsRF330ks3APg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvsV2ybl/RrudYaFfom3w65eAca7jflw6zZCFELOGGk=;
 b=VlkkRqh+kWktljxGTdg6rIqyvspO5HdnSNhwLGuCxnjwQLBjMeY6xgK+lJ5lPGpVqA2wLF7oAbysYRzZ9lvopXmH79CbTtAvKEsY30TcfXmCE86LhnAOTcJyyV9Stw2ON4jkZJcUnLQnwsMqdWrqncHQlphyzV9kzp1Tv/7dMi8hr0nWV/ySNRm1UnazvFc8elZNTv5+A75/Orqzhk+ImguCrd0dQ1BXwGiSVHBSAb2CIJut7EI/UtQP6xPAIa797e5Eo3ttQIkJwBtZ2BXWTtNUOC/nJHOhra0IyTR0nQWjmUaEbcE6DjtlMN6Aq3PdeNg+a0h7c41MlbMx3q/r3Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by LV2PR20MB995388.namprd20.prod.outlook.com
 (2603:10b6:408:36d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:32 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:32 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 00/12] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v13 00/12] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdW2P+Hrf19NzUoUaJVa7NK54RWg==
Date: Tue, 13 Oct 2026 22:41:32 +0000
Message-ID: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|LV2PR20MB995388:EE_
x-ms-office365-filtering-correlation-id: a4308759-5cdd-46f9-fdba-08df297b212b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|5023799004|56012099006|261009223027099003|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 q5CHwmxUo/aqFcNt3EuZuCIxxeszZtyzfQ/1UD0yROURLbF0mgNm0zKo6b3CulZbHSQ4lTVNdoNDnwOwupEF5kgrmUfghSqJ5YuzJXC9j4Mv/Fy2qR8qrf1Gjtw9CrKhsomPCPnLkDNoVy4R6kfzlVoWwYiqgEoYL6G0682YosHFnbCaVEJHwidaT1rfzRx8UfWp6yBOLR0W2d5lXHpvXej3viHkzw60JXtSuS3faKqr4kK16yAS/n62weYjGq1UtnyBL4BlmZTvycqBWw6jOd6aXaVSyvbXQ6Z/7E30m5KCsFm1++cUnp7mHrFSZ62ip2KH9ulI2DHwC9LdnRO2JAALKx7+YiW0XYYREdIus2bbxvjh3YyTTsfCNsukTD35byJJSlTOsR6LTy3lv8NdCde+G6StPecM5EK8oHie5M/YHjTlQGgXNOepauVioElfHg5HCx8ctqDsSh4AhvVAuo7gl/9lzvhnBLVbLcB3mh+rYxCZT8T4cBf3WWFa3SCd+/F/8fIeY04cdiwW0qqsGsbqsWzbRtAhnCNpG+o8RbTU4W81avUgWD1Gbz+MAv+3FPlsBVx3FAg6QYvcF8TVtpE+W9Z8YMjYjsTBfYhOWJ+LWfgbOcK0q965A/dBNU5AJVZFQ3hQyCJymiU3kHIkbT/mE/ee/RQDuIMYLPNTP+4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(5023799004)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yOuxbyidsWG/PxVmDXl9mBDixDuGMSkwMbfAkb4E8HFQaohOqTr/tD10Kr?=
 =?iso-8859-1?Q?caEmeXQBeLVpIvKyVdwQj8J7BvsXHLL0428G+2qpPtnTpGg3a1ywoemFvW?=
 =?iso-8859-1?Q?R8MnXEgKUNNQBAZN2IYAXF6UAq91a5YYoXOV8JUCUexykEzws6vlCHkGwZ?=
 =?iso-8859-1?Q?y18L0sIjlyM2kchXsKqrSKvaElymp3GLvWKc41ztRIMc/WG+Ewngwquuwx?=
 =?iso-8859-1?Q?qZ4MEeEutabCKcP0nKtfGZHS/yBvFpARCbpw7GyIMNfjs9QN4Mxt0Y+0Mq?=
 =?iso-8859-1?Q?f+zMG+1CblFcCSRMCKQo576Yibpz9ZhA/CmuvGr4gaodXHIMJwgNdD2mFH?=
 =?iso-8859-1?Q?tvoPzh36vjEVl7pCHgqBopu8LDbMVKLr4VJqOVe0I5WYkhyle+RcPQk3rz?=
 =?iso-8859-1?Q?MHgc2k952B4oELICr2Lqtlv4SHMc5xWviCCrcGAqu2nC9mFZ1JnAR1PeVu?=
 =?iso-8859-1?Q?Sj49SHVjxBYqWOa3kXaKvav0olWLupAZMWKkEc7e5ScSP6E85xRQk2Uia5?=
 =?iso-8859-1?Q?77hNEv4+OXh8wjyr02Ovh7/36CaIjrujJOZWRFFpyx8Fy0+VL43MpP2lkn?=
 =?iso-8859-1?Q?JVTz6HjMvNttilS86mT3Ofqnc3l/lC17raUYrupbZz/elKrlfj3Lr0iPDp?=
 =?iso-8859-1?Q?G54Ivq+mre7nYzb2ebBaMvlG47W0p2iAuQ2vsPhpNOvEwC6pNkg0/thhZC?=
 =?iso-8859-1?Q?HpQZPmve1+e9b7TaQOmc8ubh5iC2bOJSjK0TTNXGlnkbd2ayjQa1KRlxMl?=
 =?iso-8859-1?Q?Wn6z3vrN48fl35VLeapbnUjzTplKdzPBl9i9eKnOzmSTr0WxnfChyngM1w?=
 =?iso-8859-1?Q?c4scekRk3l7+l5/agF5P5h37JttDZh4ZmFzfwwQrlUw98RDIqJ24mz99/p?=
 =?iso-8859-1?Q?I4zCPqrNTRB+fJkxMEYVStsWXvZsc2UB+lW8nqmtQj+9tid7g2L7pQskyV?=
 =?iso-8859-1?Q?N857CCfJcOPatk3QgJRMSh+kXRM8D6PqWTh7+ZP93XXorlRo+q7TD05Ega?=
 =?iso-8859-1?Q?QtNL5M9NpUsmfd+QEyGhbSs1D2tZLWvipYMpRIBkU8bPwzfq0wkrcoV/dz?=
 =?iso-8859-1?Q?vTxLklAAyKjCjQ9Bh84XYJkHQxR8mThSSqns8dQZp1xzuK8hes6/J4Ca/i?=
 =?iso-8859-1?Q?twLlRLeWD6tbqqSu8NJ0tjrbpjMZZiaWUFAzGdCleRviBhwOukkbba3dEN?=
 =?iso-8859-1?Q?ZLlH88Pf8MSQaYEkhCUkY9MNYL7Z0k/CUFfNebJ9I9G7ieC1eJbcEBZKrZ?=
 =?iso-8859-1?Q?BgC0C058TkURezLimwTs11XiXoWF3oWkLF5vo3/kc9prJeXfMaUSwTuTHB?=
 =?iso-8859-1?Q?LHWHZb/i4vJpj6s59M45NItp+VNJGaL38rjE6es5/WVwLkvKC+7NnhrQ8M?=
 =?iso-8859-1?Q?M5mmPBnYDRN/N85mH1qWuEkpS3sQVooCPUJOQOPij3OatksAZp99TeIsVq?=
 =?iso-8859-1?Q?eto7jPSw8acUSMinrQ1L4/52JxKA0HyvvSAclVdJnoO6SVuICW2mHXG0QR?=
 =?iso-8859-1?Q?a5waJAl5nl7OvMCO5M7twvYQ6clBj6hMkkKaHAv6tpsRiOIVZaXS3dh0iN?=
 =?iso-8859-1?Q?XfOmInM7sNCVOAX7rYo9c2SpfBROMf8JcPvvLV47N9d3T7dnMloOHUsHzr?=
 =?iso-8859-1?Q?uCVM7Jewn2SecQW9ql6ko12rp///96XQwCqbBnaHYyvrJKEx77TX0Nhvjc?=
 =?iso-8859-1?Q?+T6RoLq55F4S1HrpdKoaUAi585G9vdCmXnVcZum3uIC+Uw9y2K8mr0gAlp?=
 =?iso-8859-1?Q?YxfAUhffv7QBSj0vsESOsWFchQ8eDvC4FcXcQlBHmRBdBM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oHfigKNRdkyC1FgooagG+jPT1GDIDLuWRcM7ndYLptzgm2caxzo4d2q0ZY7+SzjdHhO5J90hH8/TyAnyJY/O77KnsCl1mieVJ1y7U4CgdKEbCylTEMAgu7KlDXitVnRcI5B0n7IFOTxuFJNyzGtrp/jZLkKW8JZp+4Y0j9PeG9j4C0f2G7cQ9Pu/XIZsMLNsWvxdJQryxqNupal6Btf/1VRJn/ZgMGuWa21beZNAkU7rk+8dB317/I9ny98+J+XcOtS9c4GH6lgfmoQ/RUS8gEtD8A5AN30OwNvEqeRTYgIqzUBIcgu8G4V+49p5U1vEf09FDiDmWaQgSupqUyX+fA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4308759-5cdd-46f9-fdba-08df297b212b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:32.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyUvrXfkwPAca3Yx8gcnGIZ4W0fXuG23G/bSXizO58VbByXvrzSY0h7BMXJO7XHAwBuZiKZaj2g2zghV7h+9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB995388
X-MDID: 1791931295-ZRCYOxgSTeGd
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931295;ZRCYOxgSTeGd;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic reference selection and on-chip TDC phase-offset measurement,=0A=
and is used for synchronization in telecom, networking, and data-center=0A=
timing.=0A=
=0A=
What is here is the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry. Patch 1 of v11 was=0A=
applied to net-next as commit 45ad84d2800e ("dt-bindings: dpll: allow=0A=
hex unit addresses on output pins"), which is why the count is twelve=0A=
and not thirteen.=0A=
=0A=
v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/=0A=
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/=0A=
v3: https://lore.kernel.org/netdev/20260731180951.65725-1-arouhi@sitime.com=
/=0A=
v4: https://lore.kernel.org/netdev/20260806232439.27551-1-arouhi@sitime.com=
/=0A=
v5: https://lore.kernel.org/netdev/20260810230439.22866-1-arouhi@sitime.com=
/=0A=
v6: https://lore.kernel.org/netdev/20260812175337.18155-1-arouhi@sitime.com=
/=0A=
v7: https://lore.kernel.org/netdev/20260815221919.64226-1-arouhi@sitime.com=
/=0A=
v8: https://lore.kernel.org/netdev/20260902214030.20955-1-arouhi@sitime.com=
/=0A=
v9: https://lore.kernel.org/netdev/20260915000015.80480-1-arouhi@sitime.com=
/=0A=
v10: https://lore.kernel.org/netdev/20260921201108.42676-1-arouhi@sitime.co=
m/=0A=
v11: https://lore.kernel.org/netdev/20260930233714.87679-1-arouhi@sitime.co=
m/=0A=
v12: https://lore.kernel.org/netdev/20261009183151.78497-1-arouhi@sitime.co=
m/=0A=
=0A=
Ivan Vecera reviewed v12. He gave his Reviewed-by on six patches and=0A=
left comments on four; patch 9 has both. All four comments are=0A=
addressed here, folded into the patch that introduces the code rather=0A=
than added as a follow-up, so each patch still reads as the one change=0A=
it describes. The replies go out with this series. There is no code=0A=
change in v13 beyond those four, one locking change described below,=0A=
and the line wrapping and kernel-doc items the patchwork checks=0A=
reported.=0A=
=0A=
His Reviewed-by is carried on patches 4, 6, 7, 9 and 11. Patches 4=0A=
and 7 are unchanged from v12. Patch 9 carries the reordering he asked=0A=
for, patch 11 a kernel-doc Return line, and patch 6 the line wrapping=0A=
noted below. It is not carried on patch 5. That patch now takes=0A=
multiop_lock around the probe-time output state fetch, which he has=0A=
not seen; the three functions it makes static are the change he asked=0A=
for in patch 3.=0A=
=0A=
  1     bindings: vendor prefix=0A=
  2     bindings: the device schema=0A=
  3     basic support: paged regmap, variant detection, probe=0A=
  4     DPLL types and pin properties from system firmware=0A=
  5     register the DPLL devices and pins, and keep their state=0A=
  6     input pin state and operational state on a DPLL=0A=
  7     input pin priority=0A=
  8     pin frequency, both directions=0A=
  9     output pin state (mute)=0A=
  10    output phase adjust=0A=
  11    phase offset through the TDC=0A=
  12    the inter-PLL sync net as a pair of pins=0A=
=0A=
The two bindings patches come first, so the driver never matches on a=0A=
compatible string before the schema that describes it is in the tree.=0A=
=0A=
Each of the ten driver patches builds and links on its own: no patch=0A=
calls something a later patch introduces, so a bisect cannot land on a=0A=
tree that fails to compile. That was re-checked for this posting patch=0A=
by patch with W=3D1 and with sparse, and kernel-doc -Wall is clean on=0A=
every patch. checkpatch --strict at 80 columns is clean except for the=0A=
"does MAINTAINERS need updating?" hint on patches 4 and 5, which add=0A=
files under drivers/dpll/sit9531x/ -- patch 3 already covers that=0A=
directory with an F: entry.=0A=
=0A=
One change in this series did not come from the thread. A review of=0A=
v12 by the netdev AI reviewer, which reached us off-list, asked why=0A=
sit9531x_out_state_fetch() runs without multiop_lock at probe when=0A=
every other caller of a paged-register sequence holds it. Nothing runs=0A=
concurrently before registration, so there was no bug, but the fetch=0A=
walks the same paged registers under the same contract and now holds=0A=
the lock the same way. That is the seven-line change in patch 5.=0A=
=0A=
Changes in v13:=0A=
=0A=
  - Patch 3: sit9531x_regmap_config and sit9531x_dev_probe() are=0A=
    static and their declarations are gone from core.h.=0A=
=0A=
  - Patch 5: sit9531x_dev_start(), sit9531x_dev_stop() and=0A=
    sit9531x_clear_notifications() are static, the same change, and=0A=
    only core.c calls them. The probe-time output state fetch runs=0A=
    under multiop_lock.=0A=
=0A=
  - Patch 8: the output rate read-back sat before the=0A=
    skip_fwnode_props label, so an output the board describes without=0A=
    a rate list, or does not describe at all, kept a cached rate of=0A=
    zero and published only the 1 Hz to 1 GHz fallback range. The=0A=
    read-back was meant for every output; it now sits past the label,=0A=
    so each output publishes the rate its divider produces ahead of=0A=
    the fallback range.=0A=
=0A=
  - Patch 10: a zero phase request returns with coarse, fine and the=0A=
    adjustment set to zero, before the divisions.=0A=
=0A=
  - Patch 9: local declarations in reverse xmas tree order, and the=0A=
    same ordering applied across the driver wherever the swap was=0A=
    free. Blocks whose order carries a dependency are unchanged.=0A=
=0A=
  - Patch 11: a Return line in the sit9531x_input_mon_fetch=0A=
    kernel-doc.=0A=
=0A=
  - Lines over 80 columns wrapped in patches 6, 8 and 10. The one in=0A=
    patch 6 takes a local const u8 *prev for the two prio_srcs reads=0A=
    in the rollback loop; the rest are re-indentation.=0A=
=0A=
  - Reviewed-by from Ivan Vecera carried on patches 4, 6, 7, 9 and 11.=0A=
=0A=
Ali Rouhi (2):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
=0A=
Oleg Zadorozhnyi (10):=0A=
  dpll: add basic SiTime SiT9531x support=0A=
  dpll: sit9531x: read DPLL types and pin properties from system=0A=
    firmware=0A=
  dpll: sit9531x: register DPLL devices and pins=0A=
  dpll: sit9531x: implement input pin state on a DPLL=0A=
  dpll: sit9531x: add support to get and set priority on input pins=0A=
  dpll: sit9531x: add support to get and set frequency on pins=0A=
  dpll: sit9531x: implement output pin state on a DPLL=0A=
  dpll: sit9531x: add support to adjust output phase=0A=
  dpll: sit9531x: add support to get phase offset on the connected input=0A=
    pin=0A=
  dpll: sit9531x: model the inter-PLL sync net as a pair of pins=0A=
=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  213 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    2 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 5320 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  443 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1731 ++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   70 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  476 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   37 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  425 ++=0A=
 14 files changed, 8748 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
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
base-commit: 45ad84d2800e4a092fb8d96006a533b2d0ab13f6=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
