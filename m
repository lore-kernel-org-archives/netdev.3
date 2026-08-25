Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0F201278;
	Tue, 25 Aug 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655973; cv=fail; b=lIByUc2N3Wyf5AC4kOUUadPpE3S0S062w/hGH2fSKsrH2d1aLSk2QT30HR1+maECe5l/pGdFNf0a/L6J3pS7YL+6sW7KHtKc88pCFYq4Z40zATdLGV4+JPiQ/ZjX18UMiSdUhSsuxUQEHs5syqd+d6GqeSUvvx1q20T6yks9m08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655973; c=relaxed/simple;
	bh=NDnRjimJPQMnoKtaz3vNCZ7wxKvlAuutT8RBSQpKZ+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZG3a17VqovbcGsUU7FECe2IJKPnnkNt1IRBSfKlgN5jX5EBmrOfCfPbjRy2Id+YeEw5Hj+aP829W9Bdp0zrZy7uqUpQUL7lzJqwpVtVMoRukRwX1vTpupFcUvww2FuwtcnJIlhL6pyIISg3nHcXHXJ3bescWMsUtFRY0WbIkgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=iCXzLLg9; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="iCXzLLg9"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAvMAW2024232;
	Tue, 25 Aug 2026 04:05:49 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021084.outbound.protection.outlook.com [40.107.208.84])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g998006bd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 04:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tnj+lLnc4uhAkigw5ku5BZL4gxTnj5i2oaYpu7vRfCiG9A/sVDuyEW39UvuLgv7mhekAYEKNjOMmdWCreSBSpLua4bReP2GKbJ1n+EU9WcSglzG4i6XvTwMQEI4d58Dbv6DZlcagJQzq/Mk78V+RP0ToTLPrhzm72uvUxPlUSsZAqHMdVl2lI2m+4dSdsBHJn+zHhGqMSemQd37druMgeO6eU38e3XJ/RGRje5cZsADolNaChGN403B7t5GN9LO/9nM4oSwBPQKjnPoEOCdB6q3fQ9Jv4xwHTVdRRd3eKI0mLCeg0AL+0RXUrWmmiedWeTteydNEJE7oGSAfCEhGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8blP9YrKXTcX0YierdnJf6EJ3Kocev7q4nf4825vUs=;
 b=lL2rc0DbrPCOfMA8NhbuYRa/UZPYdal62b/sA9s9knEpLxTCm3IiRTZYFTvnckLxPIBnTpjPqHOkBVDVBkspJHOMLOBRZS5x8Fty1Oy1oJvv53qPWTfVV1dW6qQGSKZ54XA3ptRs1tJIYw8aDmhvTV03SodcQ1eaWvuj89pTwMzipYcd1gNGS4jNztilubtTSSR3Z8GVxOKOHJf6bj6w4bOgGLy7HUpkDOkv+KamdHLxMte22FDC9yjaozzyEsKAfqZZqDbrZun9gnWe/l2WfxV2FWPC0lZYsnXlQRRGU1BhVgzT/fu5Rt2St9l6hv9HR6NzhCAaGvrj28zksW8nEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8blP9YrKXTcX0YierdnJf6EJ3Kocev7q4nf4825vUs=;
 b=iCXzLLg9qZtRHqvl1BVO3MAUBkH1wCM2FiUQf90EBqwsk2XzqFBsI7tR2kwPU/zdDpu+JX0++b86jB1UR1nGXOaF7TycOxnsa8rdq6CmFgpegDm12NAhd4rBhhMIaz93kxFQupg4oBVWaWi7ZXWgCL+qP7SKlVjCAPBh8ei5TLE=
Received: from DM4PR18MB4384.namprd18.prod.outlook.com (2603:10b6:5:39d::13)
 by SJ0PR18MB3802.namprd18.prod.outlook.com (2603:10b6:a03:2e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 11:05:45 +0000
Received: from DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3]) by DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 11:05:45 +0000
From: Subrat Pandey <subratp@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v4 1/2] octeontx2-pf: Fix aura BPID
 assignment when CONFIG_DCB is enabled
Thread-Topic: [EXTERNAL] Re: [PATCH net v4 1/2] octeontx2-pf: Fix aura BPID
 assignment when CONFIG_DCB is enabled
Thread-Index: AQHdLvGaf33a0xF+9E2hY4vwTjifHranRA2AgAdeOhA=
Date: Tue, 25 Aug 2026 11:05:45 +0000
Message-ID:
 <DM4PR18MB438451EA0AFA1DAA57D46922ABAF2@DM4PR18MB4384.namprd18.prod.outlook.com>
References: <20260818091124.1832237-1-subratp@marvell.com>
 <20260818091124.1832237-2-subratp@marvell.com>
 <20260820182317.GB265046@horms.kernel.org>
In-Reply-To: <20260820182317.GB265046@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4384:EE_|SJ0PR18MB3802:EE_
x-ms-office365-filtering-correlation-id: 63f61385-0fab-4b0a-2d16-08df0298cfe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|4133799003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 S1YXXDmNQvOsaXIfMgmzX5aGtH9v+NLvlHNAoXVp1X1GVMk8CmhsPIfZIKLdugXr+yO2wmxlOSqXIG1ogxy+o40P4DisD9ZKzDi5THH8WtyQ5HN0jCrzvUPLHRUD93PPGPy/fUPu1utXM+jNpMTigMatvoCHyvYqZi8O2a+VfRyDNste67eXWfO5Uj+P7Cxd8mEusa62ig1mw886vT6p/WZgzKYc0LZKmGa3P3b0jJkhskgLozhM95bYSHkdERz2wB2SC9MQFvcedmmMHlvUqWW6a/dnMWp7UgdCXiGxQFWRKDjb4z+1VrL96XKQ+KRdlgWBc80OEZtMtBFrAnpFP21MXb6GP7TKqEz/pZ4wY+nmVcNw6enoPLlWJYZjhUBcgFgzOOZHkt7xCtUNaWTVzDhsY0io0AUISu6X0mSZqx61trYoefHbqdKEJH+EdjkI7+wBJc/OL1zXEjlR8h5iY6xuX8sC+5Zv0ZH44GNDEZSiTd8AWdt1BD22jy/clg6m0lqP6aPBSBlq2XIkwqkTGHm+NW3ITNd+U57i6Q4tg1m/dtYcB8hBQfgCv1bWdekNxYSelRRWBIdz0kAkgweR/xRQPi81S1NhfNLACGDGev2bgQq1amyJ8+/wrTn3+kMA+El7BDKQzw9jgZWvIgR/vkcy0l2shgWFWRESGlJO1Yg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4384.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(4133799003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qQpdi51dnnQnUiTyngudEdXPMCwvfPV5Xw47syRQzaObPTWlExLJaHOkYM?=
 =?iso-8859-1?Q?LEZLQiZHrz7KPHPqNN74qBlVkXTIbZeEon50ttdV8tY5RpUjsam33mGtp2?=
 =?iso-8859-1?Q?b6dutBUCH7rPdbFus83jd80TTe/txrDoBGd2rIAsAJfk4ZjW8S6aSJQ6/x?=
 =?iso-8859-1?Q?ReLTfyM9/F2Tc/A/2+Jb1KVYCY/5WozrUXXlf02BeUmisZwNotbVsK04IX?=
 =?iso-8859-1?Q?GDJscGn0OZDbWS4S7CZZwGMUs0qPyfY6qsFNDHDAqzB7VnVhBJk6EWf5iO?=
 =?iso-8859-1?Q?SRxImqbB+D4ypU0Zfe4FCjbJlcy7BxpJ9vWX27aUZZSiHYo6ankLhuZ6xy?=
 =?iso-8859-1?Q?fhaTEEfnKFn5UG3MadMET4+UC/dvQjWOlg/0s2q08NyCkTvgEFQ0zY1Qlp?=
 =?iso-8859-1?Q?xXMV0rMo3h+wz0h6KGsViL7j661ccQ+UBcpdH2zig2KIhJCV7kDeHrO2E4?=
 =?iso-8859-1?Q?v2J3wSJ+PWxs5a0vl/tiDDNC84vtZZsJBdOc5K95xkyt61C2LckAw5MLtB?=
 =?iso-8859-1?Q?FbD6lotZ6zd/aciysWV3PqRpRl+B4ippmm0HD5ZYBN21sg5eaoP1TUqpnL?=
 =?iso-8859-1?Q?sj6pSeswrKdz/kFuHUP6amH+LR58GuNXuB/yJ9Cm066khS8CWxUB1qFgtl?=
 =?iso-8859-1?Q?7VFY3VNqb8+LIySRC2/2x9SevJ75PeZ7vEKPdQc1qXattHg6MrWxRKVy/b?=
 =?iso-8859-1?Q?dRIxtQabV4nTfuZk0PzJX+Wz5zausRyOQIfnFD6K/U6PSdClxPZhdNkB3g?=
 =?iso-8859-1?Q?Vd2kxcpZY4oqTOpsv7yFGTQzAJ99WDMlIct/M3cJSvyJ18wIJvVOn5L61k?=
 =?iso-8859-1?Q?L6DDeoy83LYwuiAcOiQbPeENdeX6MXkMNaqgpFdzYdDNtGLxsuBtaLxJ6n?=
 =?iso-8859-1?Q?iw/bBpqP0gfWDDV7GAGn9W+x+GI52Y1TEtGwHP73YzkEsLHufbnLoeLiiJ?=
 =?iso-8859-1?Q?aABudHZ/oo6/AXnitgnSWC5+H52caSl7IAi84FhYyMn+Bo6jNEhHTRoBm7?=
 =?iso-8859-1?Q?ypLs+qAP5MVEZV6/CqRuCZjeDbbFtNhm6E1bYkPH6wHSO7ZG5xJpqbkh9x?=
 =?iso-8859-1?Q?1L6b7Q6zQsgI6POCqmBylvvT4LGwAEfsRF3Oe4rEKWZR7RpAwURAA4uuCM?=
 =?iso-8859-1?Q?ZCBqinfl0Tt16OqBmWK7+zLGNVqcdDOSXiahTfNoXiIM4PVolpVXJYGZRR?=
 =?iso-8859-1?Q?fm2oalec7xPup28mN4kP5Z7sfi/lyTQDD2an9e6Bl782guh6fJbudWREu6?=
 =?iso-8859-1?Q?9Mrg6XJTQ75cU66cT+TvzVgr4Lq2a2kh6bsDn6/CDGBdUxj3REhFVnPmWi?=
 =?iso-8859-1?Q?9uyA22ZwQDMAcYZFsH/76opfxolUCRp2f0s3YW2GoYa7v9jKGKY4uCrSvf?=
 =?iso-8859-1?Q?RpKKVbBykjcQrmanIH5zSd4eqO4IetHCJQxOlTrhlHL6DlT/1CA8ndqhxb?=
 =?iso-8859-1?Q?2BpWtZI2RWNAwJISO+lT+GGx53JIaWibQHukCAAPpVBnPzgHQ+Zkl6gXyK?=
 =?iso-8859-1?Q?Z+kenziCVc9cfQqYnyJ5T7EL2rVv6yo+afKzIEwwV5eV6QveyQjEbtMFuB?=
 =?iso-8859-1?Q?h7M9yKWIxCtFEHLJgOcl0XeCk2dVqJj/C4NdTu31yT1/sMRVr3fJ9/nL54?=
 =?iso-8859-1?Q?QiHNGzRAUe5ruyIajphxRX6egkJlSiU+I1zr6uf7xtz9y5Ev4qcY6MP8+E?=
 =?iso-8859-1?Q?LtCKmgU8EOcozNT6YUn8VjHQB2PPQDEQphrJh0TuzTCebndxL1nlUuM2ej?=
 =?iso-8859-1?Q?KY0hy5Q7hV5KwQKEPkAGNY4jpWl9XpxAuyYeZoCKuF+xCZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	zisiuUT8kn+KYZ58ef9U9g+Jsb6vMaSzGHaCVV001CAUIynI8xMT4WYaA0Erg/9SqsHXxhuuw7SAAtf7ifkbwhnL2yopYMg9oEXkvD7P4Xzh5EBBp26c9JUPo2DArivlgWyeCovVmYY7M2dF8PNqXOBpKIZl4FlYMQVuonQOpTjhBtnb2SP8xA/BV629YDFwciWmLpcxdCCC5YyxaeFWblABh0cOy5GZ1kn2/DsztKPQWdxNiUvUHMVxgb5/92YOmt/X+YmEpToBdlDZ9wE50vSVOKUYuOCtwWObe2NT6VSIgSKGO0gDPui8h+hyrabvsXFsYFyKI9DYNf2LMOp9JQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4384.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f61385-0fab-4b0a-2d16-08df0298cfe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 11:05:45.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEK4Tnrf+Ea0O34EA0g0SPLae6hpW6Aunyh3gQChhFnSI0U/tDJBOFQNZe81mPRiLk5vN7lkVkdQvHZS/Dn4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3802
X-Authority-Analysis: v=2.4 cv=N8wZ0W9B c=1 sm=1 tr=0 ts=6a8d770c cx=c_pps
 a=0iCLHuH1wF6tAjvkAzcOzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=3cue9Em0WwkkKHH6wKYA:9 a=wPNLvfGTeEIA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA5NCBTYWx0ZWRfX6PUHB9NhJs7n
 Sn2qh1yquOmJJRxod0wzbiwrrcJEXHa0TnlwYdiBbJFieAW9An5Ar15KiTjrLdDiGOfHLY+0iYH
 LtP27GK29MBSGed2GyrvnKnI9t5j6pW3pQPjFo/CnbIOBrv8ysrm7l7yKpVCK53PpB/mIUe02y0
 NxQ5WQmTsegVSUzgKvjOJHD0OLY6SU9f4mD8xfIK3rg4RGkjIZArn5bx3o4s4alK9K4SiOTuHd+
 2D4h4TxRRLfvnRkMcLlnmIKOB8f6wXFIUJowl8ETLgaORs/dAluk/ZvzHY4JSZGNS4MrfH/9FrF
 qGcDHbCg152b92LvI4y5r5Rq9T/OjMvqkOI5q+GyoKenUw4N8f+o/gk5ZWJlSm+gzCIUjIGwHyt
 vEh9FB7UR7AA6ahTkd09SYjI3UgCvynb65kOF0uIqWzwwC+Hg8P4W7qG4iLuKIn5sES/kidD41q
 xjMwTNj6rOUj4gEokzQ==
X-Proofpoint-ORIG-GUID: hEHI2H-7j0WpyR4sE6xdFZGzyAmafifE
X-Proofpoint-GUID: hEHI2H-7j0WpyR4sE6xdFZGzyAmafifE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA5NCBTYWx0ZWRfX9Lclm1paxel6
 p/cibCnF+4pmdyjBavMIQG/yKzTOcovkH/x4UAo9FCy4nCWJKs2SInbOaBHkmbJJx/Iv7bQGekB
 D9Q04xEboKhThSUn0h4cce3I7MefuJ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01

=0A=
> On Tue, Aug 18, 2026 at 02:41:22PM +0530, Subrat Pandey wrote:=0A=
> =0A=
> ...=0A=
> =0A=
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b=
/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h=0A=
> > index eecee612b7b2..f39b293cc837 100644=0A=
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h=0A=
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h=0A=
> > @@ -1029,6 +1029,14 @@ static inline int otx2_tc_flower_rule_cnt(struct=
 otx2_nic *pfvf)=0A=
> >       return pfvf->flow_cfg->nr_flows;=0A=
> >  }=0A=
> >=0A=
> > +static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)=0A=
> > +{=0A=
> > +     if (IS_ENABLED(CONFIG_DCB))=0A=
> > +             return pfvf->queue_to_pfc_map[qidx];=0A=
> > +=0A=
> > +     return 0;=0A=
> > +}=0A=
> > +=0A=
> =0A=
> Hi,=0A=
> =0A=
> As pointed out by sashiko.dev [1], this will not compile if=0A=
> CONFIG_DCB is not defined because the compiler will=0A=
> evaluate pfvf->queue_to_pfc_map, and that field doesn't exist=0A=
> without CONFIG_DCB set.=0A=
> =0A=
Thanks for the feedback.=0A=
We will replace "if (IS_ENABLED(CONFIG_DCB))" with "#ifdef CONFIG_DCB" and =
submit next version.=0A=
=0A=
This will fix the compilation issue with CONFIG_DCB disabled.=0A=
=0A=
> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__sashiko.dev_-2=
3_patchset_20260818091124.1832237-2D1-2Dsubratp-2540marvell.com&d=3DDwIBAg&=
c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DwZZ_YCNO5D9RQSXP5bimZWkeOo8bsxUc4KuKiYhSdyM&=
m=3Du2Rftq_JL82yWJLQKv_1WEZOrHw6DDfP3Bc9OmHMehTc_5XcvYXJc2TFeQ6pvTjs&s=3DnX=
Anju47lUpaVCKMkQ8dr2IZ8L_TjyNG-Uvzl4izd70&e=3D=0A=
> =0A=
> --=0A=
> pw-bot: changes-requested=
