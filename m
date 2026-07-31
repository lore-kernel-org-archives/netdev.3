Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5044E648;
	Fri, 31 Jul 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521407; cv=fail; b=JgVkw3kqVXjE6BjUJqeAK8YT7NSafbI+rPNin3PGQctqrEprXbkIWLDqeP040M/OemvLlzc69uBM+/KNZ4vakzGbGJwkv/L2Ydph8O6W8vaLf8Nf3u4f01Ef5VGt6MX08w+47caFiqofHbhhL43M5uPOrC0lgFSMXJ9LIscYGDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521407; c=relaxed/simple;
	bh=QE/k0PCRg/jEs7ulQ+cz8GaDl9/VeaKcRT/yPQkZvX0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IKYzlNLMK2C1DsW7UZK8Pzt+ZPAeYCaQXJXxhBeuiKAppr32KDykYgEqFNpnDCNodCtgOnpZQ2gqnzTcyHBqa74O5OAo3XToMnkw6Zu+zsEve7tag6pO32G8pVKigneVe1wZPIBgNNohzf9axrih3a5oT7kOgThvzWr6u9Q1DsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=mTG0b8LG; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=hZcfX1q4; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="mTG0b8LG";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="hZcfX1q4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=pFnM+fPSu2lNtpRJ22hTmCiJVobwoB6fOUooVPs0FW8=;
 b=mTG0b8LG1E05HLQNuR8V+hLxYqrNhfv/JtRSUNsxR0i08Gi8Caxke0yjMh0TpB4UfYngvGamOiOann6/wz1eoK7+hFrMkuTfyW9Y/62d+UGQdnc4IOSUdnVEGQWkaAQlTer42CxgpIQaSzD1MB8OTneEHlIDkvAddDhZ5UPJFJBP8bOhsnrTr5brTKRxV8GqsBIL1XioN9DzbCpXMZQPJ88FqO2ew1f+XM9lZ4Y6I1ct9P/z3uNK0CbpJVB8Y9znVoOIPptgPP1kNccPCAkm3ZLh0O6uRktjMkhDBbc2HJgAeDPj+mowu8F7r/XqT3mrI3JCXshx3zoyyeVLCVDU5w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020140.outbound.protection.outlook.com [52.101.46.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5941D240076;
	Fri, 31 Jul 2026 18:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdRmg7PxOfCXZS83JnRZx4WA9tymI0g3XIKg2kYc72a4YI1S84y3oS1v9deKEc9/s7OeLaTOwLW7BAVh3e0XN8zQuojCUPPKJYdPYyoukpFgBGEsTeYu8+Yjqhtg82qsl+KZemi5Qwnd2LXyyfQr749Hdw2kRTpoqW8btqD4E8HXMxDqGfs969vcaXwzvjcGEiBB2kE2N83Bbi4cr41pv3bmBJ9kzf62O+tahSbsxKrzC8aMiY175QJ/AhPLYfkvjF4+Ws9TWmGi/HqS0FQ9nc2igd/8QYg2my68YPGCnEyBLX+51ehxIKTiSjhhOJyDh9r7GSMA4+L0abqoRMAPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFnM+fPSu2lNtpRJ22hTmCiJVobwoB6fOUooVPs0FW8=;
 b=SWbLXOXcZyeslRH45GhLbD09mmODI1Ph4jmp2cq3pexNZcSDpzAntmr0f8qTiShSn0kJUvxOSh6ar8e1gfd1RiFWPOntm4bWgjR2Q/Cmg+NoT99K/V7pub7D43Dn43AwEFucXpxoTorSqULOqLeissV+UX7Qk7rWIJQGTTwdGpTgYri4Ul30VovONYyyk5fx3y/LWuwJeC3PWeNc0whOsitGXdduIbdAPwKEoSAOZy6B4Ka7GqAHTmCPCr7VPBkRe/EerqVCPQCt7rRoKBArblRdIVj8b5bCoaXMICGINZGTLkRZu8l2w0kKkmXNYcl09fwlHPbYWQDLAi6CcyrvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFnM+fPSu2lNtpRJ22hTmCiJVobwoB6fOUooVPs0FW8=;
 b=hZcfX1q4D6CGKBWJtu6iD0+X6IPW+qr3TDAekaVAzvPeiV1W+VerrAkVzY9Hqm6YWrhmMlG0BgiZLV1X45h84Yxwo35GuF4ScphxbhuO2ekVyGhGDoBKv9GfhuHKkmTdDVGVF2lY+WI8q/NkSjhPjNUwU+TwkbYADoZYTzGcjveVzOxS2WXouOaYPEJLLNIS1ze9ruXuI86mFreaOkcKKLydC94F2aK8gprc8XocsvE3nuZsqBD12bvE4Rt8ECdVuMh13dxgFRQvqvVU87VoqeMBJdlWcCt0XcNT9Vt78wGPnTmAg2nywVhfcGFl2nauoPCSUb0DZkFBZ+jYlXStmA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH7PR20MB6618.namprd20.prod.outlook.com
 (2603:10b6:510:278::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:09:53 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:09:53 +0000
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
Subject: [PATCH v3 net-next 0/3] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH v3 net-next 0/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdIRfJFvu74RrUpEm9k4BsYCbmsQ==
Date: Fri, 31 Jul 2026 18:09:53 +0000
Message-ID: <20260731180951.65725-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH7PR20MB6618:EE_
x-ms-office365-filtering-correlation-id: d0c79de7-af40-44fe-12df-08deef2eeb9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|18002099003|3023799007|6133799003|10067099003|56012099006;
x-microsoft-antispam-message-info:
 kkkBk9h0ylK5CChUGdZaP32RaU8D5Wfgy7TOoMSgsNLP/mZ+p1bh6uuTzsShDKocZ2uPVR2g2fUMR2iDSaq2YeReXcBaxF4xMK9Sg3EU7OPMiBRq7FvbbYOCvH9c0BcbTAYtKtwU/C6avJx4Dn7W/DXSt9hK8BUApiYU1qpT+/h9ebmev6geOJR/z+bdW0C8VCLk8pVl6s6QbSxL0vbA7jo31YdOj54YD/AAwcp1wIBqpelTBHJ3NIJkEA14v+HxoD2Pzp+h4E6A3S35O98kKeVDYdpv9IaqzF61PesWsBxGawiTLbFWzdEjE40cKOaITnae93uIQ6RUUOClQC3H9cbbKifAPwXJe0NLrtUhdmi4oUqIUxkxMzj1kS77SLOpSaC/HXJ0mzlAOfcQi2SebqQq+TfkY737+b4sU0ulanKejaRyNNN+Gi3MU+CtDY71IKNfI7GFVtNUp2vNlfjVOZNt1jMmVmdckB++Z/8LhZ/DJvYVmOMwDpU4IbVt+sSPPg3HPFTFTm2F76VjVYX/8yiFnl7k1hxx6Kf9b/C5FV6lEFDO2tgQMMubzyXKvO4n7zNwsENFg54k2s6Mq7jlUqIkjSsFUU0fjdy4Sdd5pnviWe/1HHgWv3LKYI5OolMxnb5jF9Pou2s7ZVDseABPU0qbXhzAClf0z0514K5AClukcZjTjs2Vrqsmh/aYrHiJhy6tkgCpl5mDyHRFNzDfe0VVl0OOPN3wYf0VhcAwNmc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(3023799007)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sQax3xTYm3gITxSIGDAVlkyE5svH9s2wv+s118Rq4ljeErke4bpOv+NME5?=
 =?iso-8859-1?Q?IJEVqytf892+tJ63nD8Xksmst2Sdtz10kdn9W0sbOejsJYnn7bivX8cte8?=
 =?iso-8859-1?Q?1Vll0EqlbPv/ZQR4xsYvaKhrXh100HYGZIzsMol90MjBoyTPpd0HtNZSuQ?=
 =?iso-8859-1?Q?ymMSFo6h9tmvQdvWbOj7TSELFppzqECkFzLKxD3cp3VcC8btRplefol1Jm?=
 =?iso-8859-1?Q?7BIUzKztoE/o365eusIIMmFkW0A6RBFe7Atk40JT1UdMbcNoR3fiG26qAe?=
 =?iso-8859-1?Q?UiMMqkEhg3RV77Sk/k5kN9HXQuLbZj+gF1tnGqFWYtl2f3aGpSojn5a0p5?=
 =?iso-8859-1?Q?GI0IpCdwma8ncrvD2m/JcDP2cfz0kmbGJBTn9RksnnBnNkAyZgSU+SfMm5?=
 =?iso-8859-1?Q?x7pHdQgArxgkDojHkgetDYRl1F6yY4c7TnvZ4HW26+TK3gA0kGxnVyv+dj?=
 =?iso-8859-1?Q?1NFjkWYcOma7IL7KE/iSP47c86S1KoYZbNQa0cMExdq4thZVKN2tnvrD/F?=
 =?iso-8859-1?Q?QPg1e7SpkhXzrkkApuZzZe0XDVUtv8oYPOIVic64W7i3JDOuWMyBaY3Bwj?=
 =?iso-8859-1?Q?I2dPPhMN+duzRwMiU66Q+vqpywFOt1jXdBurBsyvFs3OVrhMq3iteflPLt?=
 =?iso-8859-1?Q?VPPYKAPgW2PafeUo5344Lqu12H04bdHP6Tl+kiAfyCGWZA2ekhJSKfEmT5?=
 =?iso-8859-1?Q?NYVVAQM/FgezVeZUSDE21PdGaKGuxIJeHVzny+3mBc9aUPEHgSNAfXDXy/?=
 =?iso-8859-1?Q?WX5iDsIL+Jsxow2nDNaEaEXJPoac0u4aE3i+isQo4k10t/cIwE+17jX6wo?=
 =?iso-8859-1?Q?2N1JuN/qifYLCof22/6D7vFOfwPHGC4+XVk7gHTA6TNjysYcY1NBdJhKLj?=
 =?iso-8859-1?Q?82Fkg57giUYoAghkjzJwiGS+aismWSlUOOK0e/xHx8jPpj/tddtsUDAQqq?=
 =?iso-8859-1?Q?n3xbUNi3MpoQZ5gcvL7UDl9KBy2FDHI6E8REu+zkjGQjoZOXx0mKfD62/O?=
 =?iso-8859-1?Q?idOnxbXcsIVFY2D45AT3sdkCbv8aQ0X8w0mfXem6csIRpE65yq3ZI08PKc?=
 =?iso-8859-1?Q?iWBbbILFSObGzeKNvcklfizgCyGh1BqzSb2U5pSl5x9rq9bk5144+Ow/uy?=
 =?iso-8859-1?Q?plZjyEIFhfvBG+mmBJ2wbgwMjuWroRJv4r9BCJeHxMI2gNASbJI/EmBg50?=
 =?iso-8859-1?Q?+d2905fTLjTR2tQc6YdQ01mWbNsbVSSOU1ipJNRzbbPZGNIxu2jWCcX1DB?=
 =?iso-8859-1?Q?KepFDyj9OF6i8JTUDzOpKHHvCjMOyulPmmqImGT46OCRAliHhtnThr7YrJ?=
 =?iso-8859-1?Q?1gcnJOIQHq9oXHRK48S7wI6NVlY9HKQN3nBvfAr9kDLXLSz8lgjR2l9oTy?=
 =?iso-8859-1?Q?uPDDUivmKk2EtLUUaFHFsIaqL4sH9ft+H/tA/yo2/ZMSpYZcxP9XS9S8yz?=
 =?iso-8859-1?Q?pdFlrFMozTdlae4uchvu9mAily37QPNRBkw8576MIjcxocjywYFvlJlpbb?=
 =?iso-8859-1?Q?IyYkKeFNvKblEi6kBWFla5U6W+0WJd15oVMlJe7tjLlkl5rqLhg1fyzkGr?=
 =?iso-8859-1?Q?NTGTdD5tfPgKEVwc5lQWq0rDIj8BOMxiN5q4RWc0oFWCwFObGq3+PgxzGp?=
 =?iso-8859-1?Q?BmGfAEFnIAAvtZGjq1UByXf/aNPvtAUBoGNE3D1FcxgtM+tEiEnJaUWJ3U?=
 =?iso-8859-1?Q?5MXBBSI088eFogJ+cJsoE269p8iQ7IBvqKJ431eHP+n2stogIXebYYgbKu?=
 =?iso-8859-1?Q?Lxl8ndGWZ4qn59o6702hQrEJXh1ocWHxgo2d8ffaT3VlRs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Dy/Pv01ZLlA9kf/UvciFx8RAFsyslB90gpPD7icPOW/3rKFLbuqXzewkNLyWUaH25kFFmRgJ6kb+lCCjUuRqoqXYbhtvtELpGARMsoF6aCJ3ppAVH17LxWlYpL4umGtR4s5ImWoTTxF9wIMAcdLL6SOva7lY4PfU5LTqPY8ZjauIotqhCPgpvINd1WWDzrh2BjptmbCBUJVmlkCCgMfWoYoznrZe22c2zu07AWN59YKPMjsjwseemTavB0osCcZ0D8kWxGSAEXghqhN3umuIAfZ14WzTdiN033YtAUdQN9DaX8+gxuUDcYFMNhj6a8puVJI4VV+e+xAYssTQUuK78A==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c79de7-af40-44fe-12df-08deef2eeb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 18:09:53.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrICg0sk64rRFSgYvmT/juxDyQ0bA7JSumtjjk1Sy9ydHCiTec1uAQ1dgBPhe+J06vYgN0tc5JGYH5iVIA1hwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6618
X-MDID: 1785521397-6ThN2RNyaVKw
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1785521397;6ThN2RNyaVKw;<arouhi@sitime.com>;3996c0438aeafc66d5842742ecf5d65f
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and
SiT95317 I2C clock generators. Each device integrates four PLLs with
automatic/manual reference selection, DCO frequency adjustment, and
on-chip TDC phase-offset measurement, and is used for synchronization
in telecom, networking, and data-center timing.

The series contains the device-tree binding, the driver under
drivers/dpll/sit9531x/, and the MAINTAINERS entry.

v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com=
/
v2: https://lore.kernel.org/netdev/20260520191943.73938-1-arouhi@sitime.com=
/

Changes since v2:

  - Scale the reported netlink phase offset by DPLL_PHASE_OFFSET_DIVIDER.
    DPLL_A_PIN_PHASE_OFFSET carries 1/DPLL_PHASE_OFFSET_DIVIDER of a
    picosecond; the driver passed the raw TDC picosecond value straight
    through, so pin-get reported every reading a thousand times too small
    (a measured -9151 ps appeared as -9.151 ps).
  - Fix the kernel-doc of the state structs and getters (parameter names
    and missing descriptions) so the series is clean under kernel-doc.
  - Sync the cached PLL mode from the mode_set callback so a later
    mode_get returns the value just set instead of a stale cache.
  - Report a forced Hi-Z output as DPLL_PIN_STATE_DISCONNECTED so
    state-get reflects what the pin actually drives.
  - Manage the input pll_mask correctly: seed it from the hardware at
    probe and set it only after prio_add succeeds, so disabling an input
    shared by several DPLLs never cuts a reference still in use and a
    failed claim does not leak.
  - Commit the priority table even when a slot write returns an error,
    so a partial failure cannot strand the chip in the PRG_CMD
    programming state.
  - Read input priority from the chip's Page-1 priority table instead of
    a software default; pin-get previously reported priority 0 for every
    input.
  - Remove a DISCONNECTED input from the PLL priority table, not just the
    receiver enable bits, so automatic mode can no longer keep selecting
    it; reconnect re-adds it at the lowest priority.
  - Refcount an input shared by several DPLLs; the physical receiver is
    disabled only when the last DPLL releases it.
  - Split INTSYNC into a source (output) pin and a destination (input)
    pin so neither role overloads the other; the destination pin carries
    priority ops and is polled for autonomous state changes.
  - Expose the on-chip XO as a read-only DPLL_PIN_TYPE_INT_OSCILLATOR
    pin, and read its status from the XO clock monitor rather than an
    unrelated input-lane monitor.
  - Constrain output-pll-map per variant in the binding (SiT95317 limited
    to 8, SiT95316 requires all 12 when present) and default unspecified
    trailing entries to unmapped (0xff).
  - Acknowledge the notification latches inside the threaded IRQ handler
    so the IRQF_ONESHOT unmask cannot trigger an interrupt storm.
  - Deassert the reset GPIO with a boot delay before the first I2C access
    so a board powered up in reset does not NACK the first read.
  - Commit the phase-adjust write through the PRG_CMD/PHFL programming
    sequence so the programmed delay lands against a defined edge.
  - Program the pulse generator on an esync set; the embedded-sync marker
    was advertised but never emitted.
  - Restore the phase trigger source select after an output phase flush,
    including on the pulse-write failure path, so a hardware sync input
    is not left permanently hijacked.
  - Wrap the PULSE_CTRL register write in the PRG_CMD programming state so
    the pulse configuration latches standalone.
  - Leave the PRG_CMD programming state on any output-system write
    failure so the chip is not left with the output loops unlocked.
  - Fix the implicit fractional denominator in the DCO helpers (default
    2^32, 64-bit intermediates); reject out-of-range ppb.
  - Restore the other PLLs' DCO mask after dco_adjust so their autonomous
    tracking is not silently broken.
  - Init monitoring work before DPLL allocation so the error path does
    not cancel an uninitialized work.
  - Propagate the holdover-release error and clear pin->dpll_pin on the
    pin_get failure path so the free helper does not warn on an ERR_PTR.

Notes for reviewers (points raised in review that are intentional):

  - sit9531x_dco_adjust() and sit9531x_pll_sysref_mode_set() have no
    caller in this patch.  They are infrastructure for follow-up work
    (the DCO path pairs with a loop-bandwidth netlink attribute; SYSREF
    mode needs a new netlink op).  Kept because the helpers are
    non-trivial and removing them would require re-review when re-added.
  - dco_calc_outer(): the DIVN2 integer part is read from a 35-bit
    register; for low-frequency outer references the divn2_num product
    can exceed u64 when fracd_eff defaults to 2^32. The arithmetic is
    split so no intermediate overflows: divn2_num formation uses
    mul_u64_u64_div_u64() where needed, and the downstream ppb products
    already use 128-bit helpers.
  - The reset GPIO is intentionally never pulsed. The chip configuration
    is loaded from efuse or an NVM blob before probe, so a runtime reset
    would discard it; the line is only held deasserted to guarantee the
    chip is out of reset for I2C.
  - Automatic vs manual mode: on this chip automatic means the PLL tracks
    a reference (sync) and manual means free-run. There is no separate
    mode to turn off automatic input selection while still syncing (as
    zl3073x has); the closest analogue, sync with a manually pinned input
    (MANUAL_ACTIVE_SEL_PLL + man_in_sel), is documented in the code but
    not wired to a netlink op yet.

Tested on a SiT95316EBX board (I2C, 96 MHz XO): input enable/disable and
priority, input disconnect and reconnect, INTSYNC lock, output frequency
set (scope-verified), phase-adjust, esync pulse, and phase-offset
readback. checkpatch --strict is clean across the series.

Ali Rouhi (3):
  dt-bindings: vendor-prefixes: add SiTime Corporation
  dt-bindings: dpll: add SiTime SiT9531x clock generator
  dpll: add SiTime SiT9531x DPLL clock driver

 .../bindings/dpll/sitime,sit9531x.yaml        |  201 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    7 +
 drivers/dpll/Kconfig                          |    1 +
 drivers/dpll/Makefile                         |    1 +
 drivers/dpll/sit9531x/Kconfig                 |   17 +
 drivers/dpll/sit9531x/Makefile                |    4 +
 drivers/dpll/sit9531x/core.c                  | 3609 +++++++++++++++++
 drivers/dpll/sit9531x/core.h                  |  388 ++
 drivers/dpll/sit9531x/dpll.c                  | 1580 ++++++++
 drivers/dpll/sit9531x/dpll.h                  |   87 +
 drivers/dpll/sit9531x/prop.c                  |  415 ++
 drivers/dpll/sit9531x/prop.h                  |   39 +
 drivers/dpll/sit9531x/regs.h                  |  419 ++
 14 files changed, 6770 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.=
yaml
 create mode 100644 drivers/dpll/sit9531x/Kconfig
 create mode 100644 drivers/dpll/sit9531x/Makefile
 create mode 100644 drivers/dpll/sit9531x/core.c
 create mode 100644 drivers/dpll/sit9531x/core.h
 create mode 100644 drivers/dpll/sit9531x/dpll.c
 create mode 100644 drivers/dpll/sit9531x/dpll.h
 create mode 100644 drivers/dpll/sit9531x/prop.c
 create mode 100644 drivers/dpll/sit9531x/prop.h
 create mode 100644 drivers/dpll/sit9531x/regs.h

--
2.43.0

This email message and any attachments are for the sole use of the intended=
 recipient and contain proprietary and/or confidential information that may=
 be privileged or otherwise protected from disclosure. Any unauthorized rev=
iew, use, disclosure, copying or distribution of the information included i=
n this message and any attachment is prohibited and may be unlawful. If you=
 are not an intended recipient, please contact the sender by reply email an=
d permanently delete and destroy the original message and any attachments, =
and any printouts or copies of the message and attachments to the original =
message. Thank you.
