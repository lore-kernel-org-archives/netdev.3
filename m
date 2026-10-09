Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DED50E599;
	Fri,  9 Oct 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570724; cv=fail; b=Rs+3GA2gm8L0FRN5FvDkT3H6DZjwuQ5lSu2YvgB4FNLo7O40mzDRMWwNwobG/dpL15JmPkj7d6GL4gVrbgV8oZmkZVgR2kWDbJRCZcwnnUIssrq4Pre/NRt0ZHIUZ8rGsKFJkvWoFsDpNSCVbtN4a8q6mS0BzEbObKlZeCC7P4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570724; c=relaxed/simple;
	bh=ysbj2R46kWayKJhkXSJPqDXlVJFaXkI0IsYDzbwxsWo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q3yKJjZktSnUdWuWK23Ln8gBI9eENZlk9FQeKDChY8N0NA5ZoUenqLgHcq0RjEIDyEQszDKhPvzFb85msBRnLp089svWidKJCMPww4+6PCVUzIhja+O3QSbEQ1pxe5r79uO5cxuN/Yhf/iSpYwaq8yYYUjxcCRiIp5U8HgxePJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Wq5QmAaX; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=NYrBSfZC; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Wq5QmAaX";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="NYrBSfZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=S4rTiC6+zlwpG6u2hx2E0Yavn99aa328zd8wMoSmKMc=;
 b=Wq5QmAaXIghsPjksf9yyme15QE+wEJEQ7gUnzDejwGU3e2DgIrvWjDWvAsUT67Cw9CgTcogTCLwA66o2RNe5z85Yyt1lB/GHQDjsPyvg465V3ZiL5eXbCiggoU6bGg8VDe/3FZfO4g6yg/MtnO2IK93SBklyz1XDt2w0Z5ID9ncUtDRafd3htZYutgG7b3vsJgJEOckc9vuZ4A0IQax4rrhuF2yNcTYJJbhQWNl+SfsSz/qWGF2BYFxn/PMd3RkacXcO0QYBijXWj/mDdqkscc9Kqtbwf0OmomL8A6kbykNYSEHpU/7RbvG+62n2EIPc+YbxQNWaOOGmSjzEodyRig==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021143.outbound.protection.outlook.com [52.101.52.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6410A80072;
	Fri,  9 Oct 2026 18:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuEAKQQKf52F4L1NVvftut9B1bvf/B8JAMA+OfaaX34Iza4QIz/Dfyp1XW/vp69u6I6TE330eVzS8ViJFA0e8oVII5lVr+BmjaWF8tOWLKc3s1OEL1wtrMWQg+A5v+PLCQOy4AI4LpDv9R2ZouXAUoELRUc1jmNjNW2cKGrGjJEmzD4PwzslyG0xvcrUwV922ENydHVhppbQ97WNvncryvc4ZxcNAX/HCyEdtwzPpX0jyBt4AVie6kVy5mqUFwSVuN9OYedwVAAPMVy+GETwPuTuTHkWqOVozvfZf1b7s7Btxfig6tNG0ymmZRDhmuFifKgUiLQf56lZF0x8tPgWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4rTiC6+zlwpG6u2hx2E0Yavn99aa328zd8wMoSmKMc=;
 b=gFOfVxUySnmqAumvs4El7iUGMn+kBA30ZnUV0mBTtRDuJZHCMSbdTqiYeg0g9R4aMdQUpEN0elHibRztlko6JFKaUnI02RFzjF3qkxTQ5G/7gEUp5eOEA8DlbVbWabY6uugaVUudp7ckXKXYBJwjkcymLNC1Dw2AHrNFhDFO66Y6o7rK0lKNseG9n2053Ga0UWoSGClpx4nTtWr5rHc1Yt5nb06zgDZmO9KnAKtJqNRwMf4A6IcYN67QtiVMswDOBnfMZhDPj6kVcvbgHq89wqPoKpjhqr0y2dGFoZC7HVWw8n3eZfE8bLTRG0YvlH7+pM7xyjcyoHomPY1buIwzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4rTiC6+zlwpG6u2hx2E0Yavn99aa328zd8wMoSmKMc=;
 b=NYrBSfZCbg+bY/dkCO7NJf+b+gMekAzNOztrH9RCrRmASSAQr0sJiXeq4zus09vNvXn2SbfJyvFKpIu1+82u9IhfXb9u1IAH40ntSv+eC1bdgFy9zPNUCPLp11EWIBp8P4DD3+S3kLCoN2A533YEFCh6EHizrWoMPSkppLcXte7iZ6trgx97+G3u0pG+A3ZO8Wf1VP2ahDR+LMI/T3xYakGnwjxWBizu359eX65xJuNDZqkbYU/Trs945koBvSLiqSLjVa3Rjvmuq9CwXXowLjuiwrsxKyEf2wLN4lq6n4edN/5dbBVyWczVLYpH5yavqRDt6t9wC5LyV2xdS5f6bw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA6PR20MB994567.namprd20.prod.outlook.com
 (2603:10b6:208:5dc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:53 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:53 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 00/12] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v12 00/12] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdWBx0LlQ26jskMUiOl+ao9s5tFQ==
Date: Fri, 9 Oct 2026 18:31:52 +0000
Message-ID: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|IA6PR20MB994567:EE_
x-ms-office365-filtering-correlation-id: 6c3fe90a-5160-4702-227e-08df2633971d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|5023799004|10067099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 2Opybi1ZYcfToafgIOvPy3O+3Z+Dm06OkNS0884Rrg+T1RmPCwNMTnxe7oVKdK7mlX2DIpfUkksJP89Pf0J7vu/jy5iKOqxzrkSDWfqsJGY8QDCsHeDz1auOaY0bzNftSqPxhNzpi4aA05fr4Qhx7XhG2ebzQ+aOHW+I6CDUyUYvC3u38AKznTev4PeeQjF++4dFLoJ/Q2OFEgJZvPNvebB2M5jWO/m4BCArBrBcigacZe9LCCwf5twAs6qLMJTeYHEsMBAnygECkNMy8l7HcZwiOmu/fYVcFXVNwiU1s4wCcThZlq/kIrKh2dp7nC+qoe0Yhx0EcSmpJio9HC1dpvMIup9MYie51abDTjVkRh1zg/bpP1TZFD7FBOPChPSVM+v/+WmCWLpM5mTXYzSL0f/2J5OGl1am9Ss0fKhTCr3Bz+gFDRY8jN5JxPmhhJExKIdye6gJU9hX92MyIo1IX5AlTx0EIYHcvezA5TqzS/WCbJJYTp/2WJelR2ZIfiHi6OyKWKnR3N1PhVcao237Fp2wN4RGSGKKbQY7mexScSWs5IFc8YVlizODdUVtGT6vOVCPPhSAbsGnshb3mUfF9SmRS2J2ExC9GLungPSmn5r1McUdAwGFpKmlbEAaRU8LU0pHBBpw1+Lfjx4RpCZ0dOXOTD4oH7i9BkU5LntmvqtaBYkCh4Ma4rXB6OQpUl8UHW/fl5a8EYj8RbdxX2WekWoMVrGwe9mFpklpFgh/ysU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Np7oYbX3dUwbve0kMF8GxO94hD/fDNPUNGu5UWnzvj7QShVvTY92YxTeL6?=
 =?iso-8859-1?Q?mG6BCa2P6vtI0E0k78zVKJKKMz2HvrPueWzTbo012S30h+06ERAmvI910z?=
 =?iso-8859-1?Q?rkc/GcpU/mU9Iux8Gz515/XuHyMgm7lFMQly3YWCs+oR3u7bBq39gGeoiv?=
 =?iso-8859-1?Q?sv2EdciC5p9+H5EC9AyYjIqKYA/nZ7nD0jqqsRSlqzD/JaAa0fwSgrWbmd?=
 =?iso-8859-1?Q?IuHkmGlRec/VOLdYXm6EptbXqAqm9hl2MgSybuzrFfYGJqq95H3mqFn8Y/?=
 =?iso-8859-1?Q?GABPJvfn1G/dkrX96WDtNC8tVSoOf89SGsClyHraMw7aUijrxQ1uGL+HZm?=
 =?iso-8859-1?Q?bxRXs1TqiR1cSJgODHn+CXeq2P0bxU+OG6/etqBO7ADFBfFt2hDeI4hvvU?=
 =?iso-8859-1?Q?m/B/0WfuOgFKU3p01wpZfEAEDcliFBqcstix1uzuvCgsmewEnBG8Hp1u+q?=
 =?iso-8859-1?Q?kynYPFB/hAJvQoOZzhaDCHxbrkWHy0mw+YwXYcGXdjV1BDyFgHptNZ8kfV?=
 =?iso-8859-1?Q?JJXgftVcS2OQnAJLQmWS4HjO9yxnGjvJZOweSlWpaKuCCyHwJU/aywpJbC?=
 =?iso-8859-1?Q?CdZfg8MF09XR2Dl72f+XrVglncGAt3RLov7wC4QFrPiUP6LnEKaQ4S/fxe?=
 =?iso-8859-1?Q?uPhOt/nSpQTrurSDI9oyLIY3fsChXJh1z6fxEWLGIgOb2Fx96lUUBIYiSA?=
 =?iso-8859-1?Q?TuJFe3u2Hr/iiXK+vYaQw19yZq674l+9ZE2eS58Unwjtd43ns1Xs7nAixj?=
 =?iso-8859-1?Q?qJsREqb/N7uPmZebncA9EIfv4htWBwabStv2sydej/VVMcK6MQG2Laejnc?=
 =?iso-8859-1?Q?KbwLXjhRUAiv8t2OhOX0kDCkfW3RID7ZNZ6XZakWg/1Ti29RMYatNTq26C?=
 =?iso-8859-1?Q?74/bKxQbkTM3RmpYv85vbhKIDd5nIoNUxJTggCPQt7GivvY533F8+aF5jr?=
 =?iso-8859-1?Q?8vtFNZ8DLbQv/1d0jYR2BLvCTJFQmuD6w/xML5f7ZudZOkPbDJtCdLh7Qh?=
 =?iso-8859-1?Q?mborlmxA6j2r9Zkd+Zvg9zul9yijqx3ysI3BiDyPd0mzm0kOFeGCZo4OiS?=
 =?iso-8859-1?Q?3nwYTzE4PDPoDNpJ+Sk3hrJZp7NQIL3DUgpjgzZVjRE1m+Zp17GniKiZLi?=
 =?iso-8859-1?Q?MYddmCm+8rqgNZTnjH6edy2wgleeDGAYGGtejIYHTBGbaef4eSt5zjuv/U?=
 =?iso-8859-1?Q?DCKUvP7DvKmxkkR5e2dFyi8h8srUp40o20Z1tfgMYnBim+uj0aquVmhOmA?=
 =?iso-8859-1?Q?3eh3xYqUKVTxizyDchJnzgNS6GdgXdk4mt8z0BuW3jH5joJk3i706Y7sak?=
 =?iso-8859-1?Q?YmYIKD0FLkyl5xj+2B39bFd1HhFBtyCF5Dikm0603/ueSZL9VCvgSMQWy/?=
 =?iso-8859-1?Q?1d7vkRIK5HaEM0IXsCHEGsOf4EP8FXY8wLlDhNMW6r/bHFQIvWv36F1YaK?=
 =?iso-8859-1?Q?O/w1b/h0D9tiKD+N8SYBqFBBVXqaFaXnh/AsxGDWQUgGPSDJN4pFfWB8EN?=
 =?iso-8859-1?Q?0qnlFQ/YGyrvxKA34AntnVFX8CDrdmkxdhXtRaIhqwKbXmn5Hn7gNf9ws/?=
 =?iso-8859-1?Q?5pFRkvLnjhspR2O0WCPYrUzCP+L/smVYk7L+HY8bmXr45KcAxIxVyZV77M?=
 =?iso-8859-1?Q?J8HvdsBBjiLfgFZTwa3Ep/pSeKr14BE5kF4AYF6wV7OuirWkhLEfhP9mqq?=
 =?iso-8859-1?Q?vivaJR7LorKaJt3JAGLdjKc/y6KFA+yTvQDXSMA0LZEGeUZWN3WCJuuG5Q?=
 =?iso-8859-1?Q?dn8v3TAwbuVRJyDVX4ydqM+vy34JLqT2Ywl/KnxShiOurM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XnUx2wmw3yI0rDAZudbrv7DYlrsXgKbpD/Oyd6hyb0okKQQnNtJ3VI32o1J3ADaf1RB8C/cj9WIo4PIuzjQcIEtM8QN7/DZXo7xM+aJ9s7tUqM5wIthhHfKMR5pqdwgDVzoidK2V5W37d0Mg6eBIFevxfy1JMqqh/Z9tOSUvOOXmAxLgfhhLSKMHEu9nsZ5ckDwk/BVELMVdNPlXHAG6rH6PzXvUrfvtKLHn8jVptJ0KpZR8XEvR6y9L8TeKlIq7lQeE65K8jLNc3Ge1+0+4koUOcM+eQDxPzsVlmwhX6RDePB+lUHT4kjbS9FJEHSWYqU1gUr8hjx+FQIV4UvGy3Q==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3fe90a-5160-4702-227e-08df2633971d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:52.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8p9NFNUvMo+403Lxt4YNjria4cZJoWmq11zQdhAUpnggcAHCfRbwjd3HuyVo15aRWYettbu6E8oNi2hcZ/h4vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR20MB994567
X-MDID: 1791570716-BCAPoZw_snq9
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791570716;BCAPoZw_snq9;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic reference selection and on-chip TDC phase-offset measurement,=0A=
and is used for synchronization in telecom, networking, and data-center=0A=
timing.=0A=
=0A=
Patch 1 of v11 was applied to net-next as commit 45ad84d2800e=0A=
("dt-bindings: dpll: allow hex unit addresses on output pins"). This=0A=
series is the remaining twelve patches rebased on it, so the count=0A=
falling from thirteen to twelve is this commit. What=0A=
is left is the device-tree binding, the driver under=0A=
drivers/dpll/sit9531x/, and the MAINTAINERS entry.=0A=
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
=0A=
The review of v11 raised fifty-five points across eleven messages.=0A=
Forty-three are fixed here, one is fixed in part, and eleven are=0A=
answered on the thread. Every fix is folded into the patch that=0A=
introduces the code rather than added as a follow-up, so each patch=0A=
still reads as the one change it describes. The replies go out with=0A=
this series.=0A=
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
by patch with W=3D1 and with sparse. checkpatch --strict is clean except=0A=
for the "does MAINTAINERS need updating?" hint on patches 4 and 5,=0A=
which add files under drivers/dpll/sit9531x/ -- patch 3 already covers=0A=
that directory with an F: entry.=0A=
=0A=
Four things are worth reading before the changelog.=0A=
=0A=
The first is that the reporting limitation the v11 cover letter=0A=
described is gone.=0A=
=0A=
v11 said that when the device fails over on its own to another source=0A=
in its priority table, the registers the driver read did not name the=0A=
source it had moved to, so no pin was reported active. The driver now=0A=
reads the PLL's debug status bus, which names the source the input=0A=
subsystem feeds the PLL. A pin is reported active when the status bus=0A=
names it, the PLL is locked to it with its outer loop running and not=0A=
frozen, and that lane's monitor reports signal. After an autonomous=0A=
failover the pin the PLL moved to reports active and the one it left=0A=
reports no signal, so userspace gets identity and not just a change=0A=
notification. The status bus names what is fed to the PLL rather than=0A=
what the PLL has locked to, which is why the lane monitor has to agree.=0A=
It is read only for a PLL that is tracking a reference, six transfers=0A=
per such PLL per poll tick.=0A=
=0A=
The second is the one High finding, which was a real bug.=0A=
=0A=
sit9531x_dpll_pin_unregister() cleared a pin's core handle and then=0A=
blocked on the DPLL core lock, while the output state setter read that=0A=
handle more than a hundred milliseconds of I2C transfers after=0A=
validating it, with no NULL test in between. Dereferencing it during=0A=
teardown would have oopsed with the core lock held, which takes every=0A=
later DPLL netlink call with it. The clear and the read are now a=0A=
WRITE_ONCE/READ_ONCE pair and the setter sends no notification when the=0A=
handle is gone. The poll's own notifications need no guard: the poll is=0A=
cancelled before any pin is unregistered.=0A=
=0A=
The third is an arithmetic trap on the same class of input.=0A=
=0A=
A feedback divider of less than one cycle yields a derived VCO rate=0A=
small enough that the picosecond conversions in the phase code and the=0A=
TDC path overflow their 64-bit divide, which traps on x86 and returns a=0A=
nonsense quotient elsewhere. Such a rate is not a programmed VCO rate=0A=
at all, so sit9531x_get_fvco() now reports no data below the low band=0A=
and nothing downstream divides by it. Separately, a frequency set=0A=
computed against a rate outside the PLL's band is refused with -EINVAL=0A=
rather than programmed and reported as success.=0A=
=0A=
The fourth is the binding, which now describes the power supplies.=0A=
=0A=
With unevaluatedProperties: false the schema did not merely omit the=0A=
rails, it rejected any board that tried to describe them. The supplies=0A=
are named by their pins: vdd-supply for the PLL core rail, vddin-supply=0A=
for the input receivers and dividers, vdds-supply for the GPIO rail the=0A=
SiT95317 has, and one per output-driver pin -- vddo0 to vddo7 on the=0A=
SiT95317, and vddo0_1, vddo2 through vddo9 and vddo10_11 on the=0A=
SiT95316, where the two shared pins each power the pair of outputs they=0A=
are named after. The variant conditional refuses the names the other=0A=
part does not have. The driver does not enable them; the binding gives=0A=
a board with switchable rails a way to describe them.=0A=
=0A=
Changes in v12:=0A=
=0A=
  - The active input pin is reported from the device's routed=0A=
    reference rather than from the selection the driver last wrote,=0A=
    as described above.=0A=
=0A=
  - The priority table commit's error paths. A failed write on a PLL=0A=
    whose table was empty keeps the forced holdover rather than=0A=
    releasing it and leaving the PLL following a source every pin=0A=
    reports disconnected. A forced-holdover write that fails goes to=0A=
    the release path instead of returning, because the write may have=0A=
    landed. A release that fails after the write and the latch is owed=0A=
    and retried from the poll until it lands. A monitor read that=0A=
    fails rolls the commit back rather than letting the selection be=0A=
    picked from loss-of-signal state that may be a poll period old.=0A=
    The rollback restores the register whose write failed as well as=0A=
    the ones before it. The configured priority and its known flag are=0A=
    saved before the apply and put back when it fails, so nothing=0A=
    reports a priority the device never took.=0A=
=0A=
  - A forced holdover the driver did not set -- one found set with a=0A=
    non-empty table, so placed by the loaded configuration or by a=0A=
    tool -- is left alone by a table write. Only the hold the driver=0A=
    itself set for an empty table is released.=0A=
=0A=
  - When the driver forced holdover for an empty table and the device=0A=
    has not marked its holdover estimate valid, the lock status is=0A=
    UNLOCKED rather than HOLDOVER, which is what the uAPI text asks=0A=
    for. Holdover freeze is now tested before the lock bit, matching=0A=
    the order the pin-state contract uses.=0A=
=0A=
  - Baselines are taken at registration. The device's lock status and=0A=
    each pin's state, operational state and priority are seeded under=0A=
    the device lock when the object is registered, rather than by the=0A=
    first poll tick, so a change between the probe-time fetch and that=0A=
    tick is reported instead of absorbed. The per-pin "seen" flag is=0A=
    gone with it.=0A=
=0A=
  - An input the firmware gives no rate for has no frequency attribute=0A=
    rather than reporting 0 Hz, through an ops table without the=0A=
    getter. The core abandons a whole pin dump on an error from one=0A=
    pin, which is why the attribute is left out rather than failed.=0A=
=0A=
  - Output state. A request for the state an output already has reads=0A=
    the Hi-Z pair first and returns without entering the programming=0A=
    state. A change whose read-back failed is announced as well as one=0A=
    whose cached state moved, so a subscriber is not left holding the=0A=
    old value.=0A=
=0A=
  - Phase. The fold of a requested delay into one output period is=0A=
    counted in VCO cycles modulo the output divider, which is exactly=0A=
    the period, instead of modulo a period truncated to whole=0A=
    picoseconds; 100 us on a 128 MHz output of a 5.12 GHz VCO now=0A=
    folds to zero. The quantizer evaluates one cycle fewer, the floor=0A=
    and one cycle more, each with the fine steps capped, so 210 ps at=0A=
    5 GHz encodes exactly. A bus error from the divider read fails the=0A=
    read-back instead of being treated as "no divider programmed". A=0A=
    flush that failed after the delay was committed is remembered in=0A=
    its own flag that the setter honors, since the core drops a repeat=0A=
    request whose bytes match the cache. A delay the loaded=0A=
    configuration left beyond the advertised window is reported=0A=
    clamped and not armed, so a later rate change cannot write the=0A=
    clamp into the device. A rate change on an output with a=0A=
    programmed delay re-times the delay inside the rate change's own=0A=
    programming window, one sequence and one flush instead of two of=0A=
    each, and when the commit fails after the divider was written an=0A=
    armed delay is marked stale.=0A=
=0A=
  - The phase-flush error paths: a failed source select restores the=0A=
    original source, a sibling is marked parked before it is cleared,=0A=
    and a failed arm disarms rather than unparks. A failed entry into=0A=
    the programming state now leaves the device the way a commit=0A=
    leaves it rather than issuing a bare loop lock.=0A=
=0A=
  - Phase offset. An output whose cached state is marked stale is read=0A=
    back from the device before it counts as driving. The lane=0A=
    monitors are read live before the pin is judged active, so a lane=0A=
    that lost its clock after the last poll cannot have a sample=0A=
    credited to it. The conversion keeps the fraction of a picosecond=0A=
    the converter resolves.=0A=
=0A=
  - The inter-PLL sync net. A destination pin whose net no PLL drives=0A=
    reports no signal rather than standby, as an external input that=0A=
    lost its clock does. A failure of the final per-PLL latch no=0A=
    longer restores the global enable, and the rollback of a failed=0A=
    enable uses a variant that does not restore it either, so a failed=0A=
    enable cannot leave a global bit no PLL owns. A source whose=0A=
    enable, rollback and rescan all failed is recorded as a partial=0A=
    owner, so a retry re-runs the enable instead of being refused as=0A=
    busy. The restore write is followed by the page-0 small update and=0A=
    its settle, as every other write to that register is. A failed=0A=
    request that moved the owner is announced. Resume re-detects the=0A=
    net's owner and reads every output's mute back from the device.=0A=
=0A=
  - Binding. The power supplies, described above. The input pins'=0A=
    supported-frequencies-hz now carries a description stating that=0A=
    the property names the rate wired to the input, as a single entry;=0A=
    maxItems: 1 would have been the stronger form, but dtschema types=0A=
    every -hz property as a uint32 matrix, so the example's single=0A=
    /bits/ 64 value reads as two cells to the tooling and the=0A=
    constraint fails dt_binding_check.=0A=
=0A=
  - Comment and commit-message corrections where the text did not=0A=
    describe the code: "qualified" where the predicate means "has=0A=
    signal", "only the named pin changes" where the claim is about=0A=
    priorities, a retry that named the wrong latch, a kernel-doc that=0A=
    promised the advance form of a phase read-back unconditionally,=0A=
    and a comment asserting the fine field tops out below one VCO=0A=
    period when it does not.=0A=
=0A=
  - Tags. Patch 1 keeps Conor's Acked-by. Rob Herring reviewed the=0A=
    device schema as it stood in v11; that patch is 2 here and it has=0A=
    changed since, by thirty-eight lines of schema and a commit-message=0A=
    paragraph, all of it the power supplies. He has not seen that=0A=
    construction, so the tag is not carried and another look would be=0A=
    welcome.=0A=
=0A=
Two rounds of changes in this series answer reports from Carolina=0A=
Jubran. The probe path that accepts a clock-frequency property when=0A=
firmware exposes no oscillator through the clock framework, now patch=0A=
3, came from her report against v8; the input-handling work that went=0A=
into v10=0A=
-- emptying the priority table when the last reference is disconnected,=0A=
giving a meaning to every slot code including the input pair this part=0A=
does not have, and reporting connected as selected rather than locked=0A=
-- came from her report against v9. Both came by private mail. The v10=0A=
and v11 cover letters carried this credit, and neither series was taken=0A=
into the tree, so it is restated here.=0A=
=0A=
Four items from earlier rounds are unchanged and are repeated so they=0A=
are not re-raised.=0A=
=0A=
The selection moves only when the priority table is written. The device=0A=
re-runs its own selection when the source it follows loses signal; it=0A=
does not notice a table rewrite. Each move the driver makes is a=0A=
re-selection, which takes the PLL through holdover and unlocks it for=0A=
about ten seconds, so a priority change further down the table, or the=0A=
removal of a source the PLL is not on, must not move it. The rule is=0A=
therefore to move only when the highest-priority live source is a=0A=
different one than before. What that leaves open is the case where the=0A=
preferred source recovers, or a newly enabled receiver qualifies after=0A=
the pick ran, and nothing re-selects: the device's own revertive=0A=
switching returns only to the source the selection register names, so=0A=
the driver would have to re-pick from the poll, paying the unlock on a=0A=
timer rather than on a request. Whether to take that under AUTOMATIC or=0A=
to document the behavior as non-revertive is still open. The commit=0A=
message states the rule as implemented and the open point; the=0A=
mechanism follows in a later revision.=0A=
=0A=
The phase-adjust granularity stays at 1 ps rather than the 30 ps fine=0A=
step. The delays this device can reach are not multiples of 30 ps: a=0A=
request is split between a coarse delay counted in VCO cycles and a=0A=
three-bit fine field of 30 ps steps, and the two are added, so the=0A=
spacing depends on the VCO period in force. Advertising 30 would name a=0A=
step the device does not have. A request is accepted at 1 ps and=0A=
rounded to the nearest delay the registers can hold, and the getter=0A=
reports what they hold rather than what was asked for, so a caller that=0A=
needs the exact figure reads it back.=0A=
=0A=
A frequency request of 0 Hz is still refused with -EINVAL rather than=0A=
treated as a request to stop the output. Nothing in the ABI says zero=0A=
means off, and this device already has a mute control that says so=0A=
explicitly.=0A=
=0A=
The u64 truncation in dpll_pin_freq_set() is still there and is still=0A=
not ours to fix in this series: the requested frequency is read as a=0A=
u64 and validated through a helper that takes a u32, so a rate of=0A=
U32_MAX + 1 + N is accepted as N against ranges that are themselves=0A=
u64. That affects every driver behind the interface. It will be posted=0A=
as its own patch against the core rather than buried here; this driver=0A=
range-checks its own input in the meantime.=0A=
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
 drivers/dpll/sit9531x/core.c                  | 5298 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  453 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1731 ++++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   70 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  472 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   37 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  425 ++=0A=
 14 files changed, 8732 insertions(+)=0A=
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
