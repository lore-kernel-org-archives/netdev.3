Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D63C1D54;
	Tue, 15 Sep 2026 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430441; cv=fail; b=gRJHcVfpKIY8AuCGb6eequzNGZAyBsW4jO8sj/NS/2+K8WCGyMoqgMz4YLYW4X79Cq4T6LnTEz6llf4oNDuBc+h49CnYckxut5Ep9es4IsWofi9VuHAnJhqyyMfF0W0YNbOZJRMI3WrkyWhW7hLHsqgEatGUMFSaoz0Fu7glBXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430441; c=relaxed/simple;
	bh=xbB0AOi3T+acjRZeySzZA2zuC6cR1YYGpST/o27HV+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTiKr1sQTjIZluPHyc397yRTJLPL6kallXH+UdWbgx+deJd6WaA2o2ws1DieFXx6BrfAJxpK3s+CE0XtkXj7DOyjseTvvrV6m+eYFG47Jkm/vUhVMm+ZuptcAp+wO1bcjGOfaNW+UbZW6KQIY1VmqdgUQTQRhspkpB+ii2pDLMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=CjuNZksP; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=B3xEd6uI; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="CjuNZksP";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="B3xEd6uI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=d6h4Tb2BGcgN5G4FUjcwAWqd1e+I8y6T1V2QLBp+dBk=;
 b=CjuNZksP88w+zFA2bhyMi21K6GnJoOVpPOIG/nS0B3WrY0DorwbYZHubr6+73Dhde32BXa+U0vQj6QMSU5NiJc46D4LMIyOmGu2Pt95qb45IHesOgkIwZdD/h4pqQfjoRbhSCQVKJXSngNziQx2XLXRU1WXVgXH2HXlmwQzJmbjk2Squ3Li4W6vNMrFc6t7lEaGzzBMNceITkECnb7EtOZab2ycc3PSsfk0q4EPRw/KD9RW8QQ7YOY0aMRG+t+e6jHLdCEH4oh+/xD/hEwR2eqvTyeB0Bc7WwqmaiRiXMiIvpDe5UcU7rHxi/M/olE24w+GUqNkQakRoIxkjQoRA2g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021133.outbound.protection.outlook.com [52.101.62.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 326F4B00069;
	Tue, 15 Sep 2026 00:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQLX9BifmBIfOFDM52V709yjzSG4+ViN/o1WJfE4nytnqKM1YqPDP+JA01SllWD0bD6oh/tAeX10cCTrWBuNv+P5X+zNfNT+CXTudB+G/UH7+9Zt6eR++ywrd7Gw+NrxJ2Ca4stc/eUa0sqKoKAeOx31FN8w05ZKnF44ZL6wjYqlyjdT8HwzrKOUjD/vF0z6L8653PlnGv+Mncur1eDQzz8Fmoo9Ro42arCYQGtMh5BhuSLLNQuDPoaQWOGzVGXQOQgFHx9eOs14MUBonM8vr9VYIYGkW1STaZoIe4IySgQZsVyGGqWPM/+OmMYf7IDb05l9NaxZOaqHticvOzxLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6h4Tb2BGcgN5G4FUjcwAWqd1e+I8y6T1V2QLBp+dBk=;
 b=OX7dX01q0GPhKV0rUhoBxPKln0t/99+Fdf2ZxAcKYBCzqLIZRWSExoig/fGTddzU5mlpSJJQJuHhRZx3Dx8z83sTmfazwokJtdfFXuW1hkrN7sLtYBbPc98PMLXEeSEI/caICLoV5+5NkV/2tiYIS0azGv5VZzWC+AqrWa+hCf4IIkbL7uHb8RrQ/lBsn1grSwWAsczfKzIeace+9Z37+i0YS4vqGWhTK3NhZZKP21/1vxRAfJwvwE8eh2TGuHDbJu2MifeWENeY7l42hcw3o2gOTKvRKw1pdZCkB9NAEkpuj9aRsvU8CXi9+AYZxh0pRHW32DnlhwS9sFjMDEDEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6h4Tb2BGcgN5G4FUjcwAWqd1e+I8y6T1V2QLBp+dBk=;
 b=B3xEd6uIEGvehbfeg/MAYx02jIABlIivJwdqxwmFKJUc/TB97PmJGs66lv1qt7hP9J2hnAUdv8wb9oXtv9PsKfErh/nwIx+OaZu9mb+wgaTvPW26sTtTm4CP25g6mguslwvuEaf6BpbFMRyNUJs5K92a3jJzC2BbFLYlwoi4UR2OcQDkOsu4/Khb+xncXrD8AYEVjT1L+cAzRm+WBUrBc/+aQ14nrGV18+vlCrEoMJG0xOO6zI4CbSq/btCb64Gc9EfKfYlvwF9yKyJB8/59Q2VFC7jS/tv7ttsNd6/6bi871IFEHxOHZb5asM90+Abgdx51wsP2aCtns9oe/DXltA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:33 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:33 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 15/15] dpll: sit9531x: allow the device tree to
 override two board facts
Thread-Topic: [PATCH net-next v9 15/15] dpll: sit9531x: allow the device tree
 to override two board facts
Thread-Index: AQHdRKU17u3aQzcz4kmgndzkzWf01w==
Date: Tue, 15 Sep 2026 00:00:24 +0000
Message-ID: <20260915000015.80480-16-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 3c17d7c0-746a-402f-530c-08df12bc5cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 XMxx6NOHKievh0Yg1PxpWy5DdkXfvXReisQbc466RBJmo5OFL5l7nAmgjqCRo3/ojfSnDCfxB/UsBqNqygnR8MNDMEjO+wo+t8oNOjVNi5wq5jFQlbFkw8brOcbBVo16zxJYTQevOuwU7BpiVopQivC70CnRdAy/lqdMpjUyhqRVSWKOhJ9kL/Yfs7K5kc3ODna7URQXq0dtPtXNyvOYeeM7Ny9UbDW4jp4digFfG7uIRVboLJ1AmokIGSyouxGvz3GpjIJdBkr3bftB9nmXdV4Zm7fDhIOodapkG2iiVsvdHedbvQYi2Yc0fUA1kpC8rn7aasUx4p9B8INtM+8xvWbYPxY3KXuk1FGf2lNhoK4GEuKnCp2OcnU6mHwFwtKMKAuORdwGPOOOUq0ykPQxfbfXJKRs/O1TwKTFzaFi9oI7G5HK1xYxYTeqmrc+WChviKBeVa8HK9q+eaaX9CBiitGsNFCzkp9x3XRIVXRGBahjj+nMbqfG7MPRIdQHPvgYJManiZHs/2nUY6xseVBNOkVfV+P+JJIg3pPWksZW9x2I6Jq/yt4hjMaBBlDVy+qHsKNifH0PzBn/RzX5gNVknCrWmQwnEhmjWJ3Haijh7Q/b7WiJkF4XF9VEN5v7w1bJwLoGEKjHIPNTQJhF+IAk6k0jbQA9zFaJ0OKhYHYgg9TMDk7BhSNMXAMeB2AMgz0pchNNH9atUGXHRN/1WF5azr859Kr+Kf/slndpK+OHMSE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fEn1A1kyeNuxZcEpX6BIgs89rDlLRxqzbj79pMHqMlsycv7VRiIgTfZF4U?=
 =?iso-8859-1?Q?uKiDr89Gm1/srZQDk7JaCBkLyeviUA3XxYuUCtYXVaCBQmw42/AI6j1Svw?=
 =?iso-8859-1?Q?6wQ4wpCaEpT0gUSjTjG38fWg4W5u+cZH1MFW7aoFvIGUhSxfZvdvA3BIx2?=
 =?iso-8859-1?Q?DvWOIwRV0ts2t8YkgAfigLxbIfYN3FnaFQFfehfhBVlmNYebhySVE/7r0p?=
 =?iso-8859-1?Q?wk41T4iIrVqvGY3PcbIt+e6B2mPTmlTvllygJ7mpftN/+wuSpFLBrU9Wof?=
 =?iso-8859-1?Q?pM4rdhSXvVJhN6AD4ku5zYylBbswCCfyqY3aFqhOHXsHi1mN91uZbnDCts?=
 =?iso-8859-1?Q?j3xsLPlLwssJCsIH10Y171rzHTTxVwHpUdEDHIJMIJiXSSDw6w0m9Y21w7?=
 =?iso-8859-1?Q?A7i2gaWeuvC/F6xY8Sr/DWOQlZg/4XCm4fP+VCQFUhXdLlZuqn4NPtH0kW?=
 =?iso-8859-1?Q?OVPLwdOZkRvHfPSh1T5eKKu8AGWP/LU8O+TGCSY9ylRRsTy9j/eVApW8N7?=
 =?iso-8859-1?Q?DwGAfZBzpNxHFTAsCwhBjBYlYMtC7XHT/Q+M/OhWqOuhh+gI26TFOtvPhr?=
 =?iso-8859-1?Q?dczqU90iU1UPbQByz9mQFAaTKHrv1tq1Qy4Wm23c9+mW8CXwa/AYO36ra2?=
 =?iso-8859-1?Q?u1mb7PlHvAZ7FN1x+sQvqzTjzfIWWXTK25lnpAWB+DLb28UTQFdGSWPxJm?=
 =?iso-8859-1?Q?MmuuB648Y8BlYvNsMm1onUIuaiRDb+Y8l4xFgC9/paKYbT1+ShbG+SdvAy?=
 =?iso-8859-1?Q?4nzlOkURyil+kI43NJHHCur44pgT/NyAeMQxnVeopkbbXkcecBV4RedM/z?=
 =?iso-8859-1?Q?ZaVWK5WfhelF+2WG7TsjSauGkflq63QA9SPv2VaByPZ9AVQ+xVcTXeOV4n?=
 =?iso-8859-1?Q?hPgX1pHHKN3BFZK8gxVkABcNHH3+DPASmRtQrbzVnaAzwhRxLBxhlAUHC4?=
 =?iso-8859-1?Q?s/zuNeYuB0njzXWOqOUTuWTfnvysO0cDq2HSZzW6sjKxfLTSzfENUmmMXm?=
 =?iso-8859-1?Q?+qc+cedoahh9Lbxh+vL/BkgxCtXcGQTjfAGrpv1D7kTFi1ZMqL0FYw0bZN?=
 =?iso-8859-1?Q?3T6rOrNNhDpCVjFGeEcnnzXl4cDe9bijzoSzwOmhzg6HDV2iOrmQdAF4gu?=
 =?iso-8859-1?Q?zxODOl7GsuKN218Ed/6/arijmUoc/QQqq4ePo6b4rkzMZm5u0AoQjaYv4U?=
 =?iso-8859-1?Q?NHZ+Z9Nwq+NDMHfsygHgPJoNQUs1z20SicxoAFnJPWsH7NnHq2Y2t4rC49?=
 =?iso-8859-1?Q?cpGvM4xNpX7WP5g72Oj1cl6tqEall28JlNzo3RGqp0k+Jh7HOVDZdPssJi?=
 =?iso-8859-1?Q?bojMZbyFufs/9IF4Y4HDyfzm1CzcfGcntS0bxthjcDH2irrYHRIoYBKFPq?=
 =?iso-8859-1?Q?Yp7xYGuZ3KhacxlxdYhbbA60A3GnQv0aafzrmLqGW5lzDTqQ+uKAyiQB0r?=
 =?iso-8859-1?Q?yEOL8RMvEZ5GHPHkCu8VqIjv0+dJxNZxL1dlnY8CmVm6NBsGxoFjWGzayb?=
 =?iso-8859-1?Q?bOWuVyelawbkNO0XX/wvz6jEryL/2CS/R7r9WEsmZkEYN5pCpt0HytAP3U?=
 =?iso-8859-1?Q?3VjKMRvJpxsV51sOEvpZLQaO7+GGUzcK4E6B50Hq0ozpg8KDzk5O99c9ko?=
 =?iso-8859-1?Q?IjT3sO356DZF6rB1Ti4YGM/XSmheW5qc6A+WXYRYgRqTLpV9f4ukfcvD+f?=
 =?iso-8859-1?Q?5clQ1oW9qsEIsjYNsZpoOhU4VuNaV8xI7N9qrP1cYxO1Qc7McSchuQygrF?=
 =?iso-8859-1?Q?rjYPFbEi789Vigklv3kUdZ/79IW3atxbldHuNuArcNigXf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	QTjzX6W+Pphl5d5hg6amJTDahhd8xJmQbjbU1ajRkFYr0KUR3JpmTP/GpWFtiPe6UXC7kK1VxmK52IxbeDrTgYMfFKmkiIucuPAxxe35iDNEBDjEirmwvbtFZPZuHzLPL/9EIOu/in68I9x3qc2deU6WAy0WwdIN5KM0iaNiRRABux2uVfl/hnRUJh5Dr5hM8JBASkAYFyeTVne+4vuc+MGSub/94P6YP4/vKD6+te7T2puT4GTSRn1J+AF9WpEnIGYewUcDfCP1wI5xB4wvu7xxmlHVhSwaeSRAohGU6s80Uf+SuCcTbxgYGQkjS5gLoZ+C1gZtDrh8AGuLn2IURA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c17d7c0-746a-402f-530c-08df12bc5cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:24.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+gcWPH7fja0WSrCDSwOhhCGdIg+MshUNzhRnJHNaHdE39Q4XImlz8nULktcf859+4fBKCHZ0wUqwqZqQhs66g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430437-FRKB3OWCEJCU
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430437;FRKB3OWCEJCU;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Two things the driver reads from the chip can be wrong on a board, and=0A=
neither has anywhere else to come from.=0A=
=0A=
The VCO frequency is derived from the feedback divider, which is exact=0A=
while the loop runs but not while a PLL sits in free-run with a divider=0A=
the configuration never programmed; a board that knows its own VCO can=0A=
state it.  The output-to-PLL routing is read from the output map=0A=
registers, which describe what the loaded configuration did -- and a board=
=0A=
whose outputs are fanned out differently from what those registers imply=0A=
can state that too.=0A=
=0A=
Both are optional.  Absent the properties the driver behaves exactly as=0A=
before, deriving one and reading the other.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 104 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 104 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index b15859890caa..51f7d8a4ea44 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -3862,6 +3862,108 @@ static u64 sit9531x_derive_clock_id(struct sit9531x=
_dev *sitdev)=0A=
 	return clkid;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Does an Fvco fall in the band the given PLL runs in?=0A=
+ *=0A=
+ * The two bands are disjoint, and which one applies is fixed per PLL, so =
a=0A=
+ * single envelope from the bottom of the low band to the top of the high=
=0A=
+ * one would accept both the ~1 GHz gap between them and a rate belonging =
to=0A=
+ * the other PLL's band.=0A=
+ */=0A=
+static bool sit9531x_fvco_in_band(u8 pll_idx, u64 fvco)=0A=
+{=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3)=0A=
+		return fvco >=3D SIT9531X_FVCO_HIGHBAND_MIN &&=0A=
+		       fvco <=3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+=0A=
+	return fvco >=3D SIT9531X_FVCO_LOWBAND_MIN &&=0A=
+	       fvco <=3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Board-config overrides for fixed efuse/blob routing the chip registers =
do=0A=
+ * not describe unambiguously.  Absent properties leave pll_fvco[] zeroed=
=0A=
+ * (derive from DIVN) and out_pll_map_valid false (use the OUT_MAP registe=
rs).=0A=
+ */=0A=
+static void sit9531x_parse_board_config(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u32 map[SIT9531X_MAX_OUTPUTS];=0A=
+	int n, i, rc;=0A=
+=0A=
+	if (device_property_present(sitdev->dev, "sitime,pll-fvco")) {=0A=
+		rc =3D device_property_read_u64_array(sitdev->dev,=0A=
+						    "sitime,pll-fvco",=0A=
+						    sitdev->pll_fvco,=0A=
+						    SIT9531X_NUM_PLLS);=0A=
+		if (rc) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "invalid sitime,pll-fvco (%d), ignoring\n",=0A=
+				 rc);=0A=
+			memset(sitdev->pll_fvco, 0, sizeof(sitdev->pll_fvco));=0A=
+		}=0A=
+=0A=
+		/*=0A=
+		 * The override is used verbatim by the divider math, so an=0A=
+		 * implausible value (units typo, wrong cell count worked=0A=
+		 * around with zeros) must not silently misprogram DIVO.=0A=
+		 * Anything outside both VCO bands is dropped with a warning=0A=
+		 * rather than trusted.=0A=
+		 */=0A=
+		for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+			u64 f =3D sitdev->pll_fvco[i];=0A=
+=0A=
+			if (f && !sit9531x_fvco_in_band(i, f)) {=0A=
+				dev_warn(sitdev->dev,=0A=
+					 "PLL%c Fvco override %llu Hz is outside the band that PLL runs in, i=
gnoring\n",=0A=
+					 'A' + i, f);=0A=
+				sitdev->pll_fvco[i] =3D 0;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (!device_property_present(sitdev->dev, "sitime,output-pll-map"))=0A=
+		return;=0A=
+=0A=
+	/*=0A=
+	 * Any 1..MAX_OUTPUTS length is accepted so the 8-output SiT95317 need=0A=
+	 * not pad to 12; variant detection has not run yet and entries past=0A=
+	 * the detected num_outputs are never indexed.  Trailing entries of a=0A=
+	 * short map must read as unmapped rather than 0 (=3D=3D PLLA), which=0A=
+	 * would mark unrouted outputs active in sit9531x_out_state_fetch().=0A=
+	 */=0A=
+	memset(sitdev->out_pll_map, SIT9531X_OUT_PLL_UNMAPPED,=0A=
+	       sizeof(sitdev->out_pll_map));=0A=
+=0A=
+	n =3D device_property_count_u32(sitdev->dev, "sitime,output-pll-map");=0A=
+	if (n <=3D 0 || n > SIT9531X_MAX_OUTPUTS ||=0A=
+	    device_property_read_u32_array(sitdev->dev, "sitime,output-pll-map",=
=0A=
+					   map, n)) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "invalid sitime,output-pll-map, ignoring\n");=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The binding allows only 0-3 and 255 per entry.  A stray value=0A=
+	 * would silently unroute an output (m >=3D SIT9531X_NUM_PLLS reads=0A=
+	 * as unmapped in sit9531x_out_state_fetch()), so reject the whole=0A=
+	 * property loudly instead.=0A=
+	 */=0A=
+	for (i =3D 0; i < n; i++) {=0A=
+		if (map[i] >=3D SIT9531X_NUM_PLLS &&=0A=
+		    map[i] !=3D SIT9531X_OUT_PLL_UNMAPPED) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "sitime,output-pll-map entry %d is %u (must be 0-3 or 255), ignoring =
map\n",=0A=
+				 i, map[i]);=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < n; i++)=0A=
+		sitdev->out_pll_map[i] =3D map[i];=0A=
+	sitdev->out_pll_map_valid =3D true;=0A=
+}=0A=
+=0A=
 int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	struct clk *xtal_clk;=0A=
@@ -3906,6 +4008,8 @@ int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=
=0A=
 	if (sitdev->reset_gpio)=0A=
 		fsleep(10000);	/* internal boot after release */=0A=
 =0A=
+	sit9531x_parse_board_config(sitdev);=0A=
+=0A=
 	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
 	if (rc)=0A=
 		return rc;=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
