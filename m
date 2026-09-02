Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A141BA69;
	Wed,  2 Sep 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385268; cv=fail; b=jVdfBb61dpUbQc6fSR85+V62fyh2am0zmIEkmyXLiqdmg1mr7YIlxrGnvcxNTOmf5t5QIfYg4lGdEWu8oD0HbH2oNOG83otks1brPLNoqNaI7nS3e60oyzylZtml4LlQ600zHE8861P1DghVOYHw56Wu+fJzA/hqMdA9owasl0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385268; c=relaxed/simple;
	bh=rwplb5CVM3Kb2i6KLnpZ6fg1eKs1GyvYBo3FmnDUn+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkpT2p83pDeIjVdva3e6MLbuKnWcOf996fiZTR0muhTFjY1WrA2MlGpm0k8iwIgkAy2Os5WDslfEZKT9MCefweOKVylmj2yerAFAEyLfsxSqFfRfh0c6xWbQZoIZolYppUtvfQjrNeLbj7zfhJhpQ1Wez99pgudhlHAiIHLHhX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Ytw7upWZ; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=sp6XUYPf; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Ytw7upWZ";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="sp6XUYPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=CJ+rPtCto67SFp48YxbbEGVJSsrZwZbl1Evv1kvvPe8=;
 b=Ytw7upWZ/kSSimjNNP/p4bUH/SPqsEZL0SgpOz8+E5e4iFoCODhPrsZMKbRs/t1GbLUfOtqAjCqQy4L9u159izKF27oMgEbjWyP+wWWW1hi0DthZbQRmmGXfD0QMxponBjaMO9QCsBWZi3MsF573eP1HUAZRugDEASdLY0fQibzqJZsHTDym0cqJ0tVzswuMp1ezf8CP48IW4PVJ7X87NzadklxgzQ8+eBI7JNparcrdaGxG2+rwrhECSo0c4BtVOV32oPc7gQvV9lsFqFfsUMzfRE3+BAb0W+EgkI+sr5uaco8rtdaWtnkXgv7Fr1u4/wmc0G+vSUWmyGPz/Y9JFA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BE06724006E;
	Wed,  2 Sep 2026 21:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/1gziCXMNnMYhqR1tLljxHYOgA6fckiACQl2kqrnb4RlIXwCIbBip8hG33U7U+Qh1iuR61GFEIsAoaAOFdcKVB7chDnvrhsYc0yA0yHBr6JdPq/sLqn2d9g2ePao5DXCYPI4yhGKizb964C24AvIKtqc2P5J9UGSWijl7HMtZg1Ij5YtxnlM/T0mcwD1Ps1C2N0f4IcctQrois8Eh4CU4ya2VbL2d+IbfV4poUWBGdF2dWof06FVmK2kn8gQakBlqRc2BpGci7VCubdt1jWnSKevVl5x6639aI9y4h7yFe0qdN1ziXVTUVtNUPnzPa2FevPJQH0NVQtQ8lRXw2AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ+rPtCto67SFp48YxbbEGVJSsrZwZbl1Evv1kvvPe8=;
 b=AN+e7ZOifbTf/HxvoxgCEI4BWGCaxE3RhM5MInyE+1hagNw6nIkz6e2T7OAMemH42vDUXgFEtxD1rMeoUH7VxvNJU9sfX6OnzMiVwIpN0v8/aif0oEMmVKYTqHJB3WAWf25TfIp5gP1DSJ/hT/GSOm7AOTRUMIJOWGDUw8orn8gg1SM59685akIalc+pw50fn/qQY1d0Tb4DFNU/m5MeNj2isMKpWaj1y86r0ARYFPAkJWDsCK5weW+sXoFbG5uVD6kdW6Py888NzlVN7D+7AENBB78HOsI97p4KYOkotNd1MAHfwgZdIGc5nwrH8AOKx8CeeQDiuMX9fEEAgG9xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ+rPtCto67SFp48YxbbEGVJSsrZwZbl1Evv1kvvPe8=;
 b=sp6XUYPfvZxjC+nTQPbhsuC5Qq78t0XZc52u/UZTUvfpKin4v7V6ooAzYNC/NESfKq3yod7lM4FpEp6aqDbd1Qw6DaLcbjPNLaGHoukwSW1JKKToClN5b2C4W0s92R1Y2TKY9L/QXPgrcV2NvlGjIFRUS6UD9UNCuPGasKzEWWstK8GaPB2fAGjgjV+FYFJtVLHDIujtlf4hxPRJLOpKoNGeNceK1ofZPg5bXS1TYwenVNtic6MFh7d0v1h5DUI0DNp15KWRe4CKe/NLoS2uvHMIU2LpgBEiit+0Xd2hyXjnvyMmtTQUaPiVFwEsXHAmXp4uEWq48QQhsF+CHmRijw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:37 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:37 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 12/15] dpll: sit9531x: add support to get phase
 offset on the connected input pin
Thread-Topic: [PATCH net-next v8 12/15] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdOyOxG8v/E+U7IU+jkp/1mUdhoQ==
Date: Wed, 2 Sep 2026 21:40:37 +0000
Message-ID: <20260902214030.20955-13-arouhi@sitime.com>
References: <20260902214030.20955-1-arouhi@sitime.com>
In-Reply-To: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: 034a9970-91d2-4ce7-e8c0-08df093ad38b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 zudqRZlmR2jgKzpMH50FGmxMW98QqoaYxK74In/VyvcTxsMPP4GWkewcoJH3neReVistCrjs/FmC6h9J6mEPXSOAihSwLKa9j8cJDisk890eRKLOcb8cm4BtFvGIY9ZkpJoqfkn00QUH+/l416LN5q1xwAUOCPUsUnRAcszaxwwTE19zn20UDL8j6tqO9FQ+ffrVghHyeME2q/FwCHS6u9APs3WQ8vUugfP9iOdIfZpYqdmxNDg0Rsai7DV+Tvl3C0mRsqqAd6bUlqJsRqsX8tlhrh1C5rKiGw1yFY8V1VZyA4/80i8/MQg/xT+q5DmeneodzN1mwhSnYIVtQ6EU7EKIm3Kg7cJTgfQUYBPxelVwo46sEPtXrdCUUUZTZGo+wPtemFHVUtEdqon/gWTS4ztfxlLXLQoFlXPYWglp387Bywv2mPADaC0hm4VZzvnIeecpCQg9iU9OjU/uFVlzyjbbCvuMDDivlP6abzOVup82smSxk4pwlMhIMsalAIeCtJ9EiXgWFVPBUBXCxQMgUG5uGNmVP4jLhasDwWyYUEzgS5P4GeU/t/++VUHiwNqeRoZ4BWiFmu7Z3drsN/fw2bi0vKifhmwZjoRq7tKwOQ4hHiMHcVcGhYiToJ/QzpEAtkRhT/we3NqAL65dtzPYzwK7c8qxytkTJA67VZkUvcE/hrW2Wu0Eso3kUOufa1P4zENcbLmdlwYAhHMUuXl9DUeprQz04XQdAqyp0O2lLmA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TVAhueesoh4yXNxtu10tQvzuWHylT3MACDrk/94ls0zLosblezbkMeRymX?=
 =?iso-8859-1?Q?TolsulNmwo4AESh/nLUZR8+YHfsA4BODqLZaFZYEUDOCbDiYG7hHHXxVSC?=
 =?iso-8859-1?Q?y2cIqR7D/rxG1mTUotmLoL/c3sY4zBpe8HQsHa5GbDlW9fDhkoLoMh3mLu?=
 =?iso-8859-1?Q?ZLOSDtn9wr5wKB9qLetkpyzEVds78g5tsu1SpuFDS7Gm7q5p0Ljui2d6GD?=
 =?iso-8859-1?Q?wVhnEICey/USHj+EjSK7HbV8fenIsaOWVq1bguHxP63cr7W5o7q6MjJzsL?=
 =?iso-8859-1?Q?p5xnWH4CU7oWZU3K64WEaWoOduyAz8Cd+S5BAkFr8Qzd60BKLYaQhbIKlE?=
 =?iso-8859-1?Q?EyiOHLPBWqpGO84E/VkUGmom/HYMUSWY+vskn8F+4uKHNvhmyKJ1kGYmQa?=
 =?iso-8859-1?Q?qsNBzTYePmTnweDpqI4e8+GHboJBAkRiFErk/x4oFsjSLwoCukkhl/ekXN?=
 =?iso-8859-1?Q?vnaz8pDSFJaKNK1jaUu1UxjpR2hoPcFW9UOM3t05QSAhfwF4zqW4BFYcUw?=
 =?iso-8859-1?Q?ukVH/HTdebqAioGZOh/CHQPhP5cVdfV+tj9di19GV9QoDlWW6MJcBHHZgu?=
 =?iso-8859-1?Q?YixlbhBatKTUaGN4kMpOfs4ehGu1LFUIFo8tq4i0uJcAyHzRBbt6562dFN?=
 =?iso-8859-1?Q?nFJsUuKurclXR7nqy7USp8YB2YWJho33zDvMQ+whrPmyy6pGBM8Tqg8O9v?=
 =?iso-8859-1?Q?VG75RquPil6Ml40SajdRHvzJ1ggerYPp8p8i0KDMd2gQWlU+LEAF6f7qY3?=
 =?iso-8859-1?Q?q0g3DRrLpxBjEB9jeXRMNoJZecdOepMEZ33WnzBZGXXvGmkOxWOAtE0hJT?=
 =?iso-8859-1?Q?3Cqg7/Jr+W7ITFsSawNjNLPsjZ1AgHzI34zMfDMk/HbHBWxTD3WEwcRwFr?=
 =?iso-8859-1?Q?/cqthwq+Vn7TwVyfEC/hGIcVP2RLmEAamgHnf26UbF09oagCgc2RuidGYV?=
 =?iso-8859-1?Q?LGi9L1j4EuS90iqHESloVso/8jwv4K4i65DBpx9CdvkUa8HuB1r7lAzsd5?=
 =?iso-8859-1?Q?OydmORMQyTgUQnFKVWQHs0/379iC5VO2qPqOerSCYoAlMB1zDy+3XQY5eN?=
 =?iso-8859-1?Q?QDglX3xwzMIe2oojhjm48yoMSVXuTxY8exgV4xcGVFJytgH+7R/Y+WE9IA?=
 =?iso-8859-1?Q?TabzN/Ac48PRKJtIgN8tKkCDZVa+xrFwPbFkxuo8w2W31psPOTM+Bk9YA+?=
 =?iso-8859-1?Q?PHt4a1Yv4uAUl/J8P9u/Zrwpg29PLKbaxkL9Iz5x5NQga5bLiGUG2Zi3KM?=
 =?iso-8859-1?Q?XOQs4TWH972+VV01Ura+QmHoJBx7SWC5FYmSqS6ky8+/RfBO/iYLEB9n4W?=
 =?iso-8859-1?Q?zo6dRnCJKFtS1oRBngmCYZkFljzB5WAk0CuEv395gmmIBnjdCZDOV2LfH4?=
 =?iso-8859-1?Q?Vswl9AeUYZ/eSGi7nNQRez84iWR6Q0JQmgTegIeJOANX0+TIjvajlZeCNb?=
 =?iso-8859-1?Q?CuHFvm4jHCIazkNRibvx8EYPzAJQBWyBSJ2qnseZO9aMrss+W1Pvu8LONq?=
 =?iso-8859-1?Q?us5WXmzOXlA9WYyFV8O7/n8qZb0Nhj1EQlHxfYcxd6UWnWgT8jtrq3N8RZ?=
 =?iso-8859-1?Q?8dlik6G7Os89RgeT5+IsXRspX5mbXn5nXjWmA29NnSeVopt4JRYn45dA9E?=
 =?iso-8859-1?Q?rY9sBXHCrzu1LncUpDYD0lwmRaZS2oMJNeNVlHlWFfjiAK92EV7jwd37uF?=
 =?iso-8859-1?Q?Wtufc+cdUqND0jQv17vcw5y1bnXnd+kgujvriyVwKJbsJNcviR4HnnX7Vc?=
 =?iso-8859-1?Q?Uwb9wmQlqgByYrTaSNEXpfPYcwbSwyhvZxE8vr7BW1Qs5i?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wrer44VDcexr+EkmzBgNo2KkOhf5im9hrMd133he3e3o9t2WvjnijG4/rvVQB5lfjLGCIuRcpKmAVf814/jXJ/4ZtoVlqDtYJc947hq0IvQkPlzENkRWaKos2C0WVVd5KccWZgR0LSp5qqLzXBBVKDwVXcx95wsb/0MWtGkE7XW7iPkdrFmqVf78kzIDVY7Yl1OIBXTNnyxSy7rtWLjMGoAD7SFobBq9PixMPiV7BpC8UJ9rxmVsoE1rljhR9p03ptkCLZL4WvZPtkiRssgm8leu69oTdQlPNYdaku1w5HIlb68FN7VGF2u8vlPN5wmU4JKug68LMqfJpGSop4twTA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034a9970-91d2-4ce7-e8c0-08df093ad38b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:37.1699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeEVnfz0XUPY6GNOr8E4DocQY3lQefJFQQpgDIvRmVL+pywr2AITAMMsPTQCUNe4eVPP5qpDHhBLUhmr/7F0JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385244-NGRLYFMKNlQC
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385244;NGRLYFMKNlQC;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report the phase difference between a PLL's reference and the PLL itself,=
=0A=
which is the loop's own residual error and therefore trends small on a=0A=
locked device -- that is the measurement, not an artefact of it.=0A=
=0A=
The value comes from the on-chip time-to-digital converter, read through=0A=
the debug window: unlock the window, point it at the converter, then read=
=0A=
the trigger register, which latches a fresh sample and returns the=0A=
previous one.  It is read three times per sample for that reason; a single=
=0A=
read hands back the sample from the last call, so a repeated measurement=0A=
would look perfectly steady while saying nothing.=0A=
=0A=
Only the input a PLL has actually selected has a phase offset against it.=
=0A=
For any other pin there is nothing to measure and zero is reported,=0A=
because the core abandons an entire pin dump on an error from any one pin.=
=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 125 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c | 100 ++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  36 ++++++++++=0A=
 3 files changed, 261 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index c93578f3b750..f552a9c73796 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1586,6 +1586,131 @@ int sit9531x_output_pulse_ctrl_set(struct sit9531x_=
dev *sitdev,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @phase_ps:	output phase difference in picoseconds=0A=
+ *=0A=
+ * Reads the Time-to-Digital Converter (TDC) 40-bit code from the=0A=
+ * PLL page registers, then converts to picoseconds using the VCO=0A=
+ * frequency: phase_diff =3D tdc_code / fvco.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_ps)=0A=
+{=0A=
+	u64 fvco, fvco_mhz;=0A=
+	s64 tdc_signed;=0A=
+	u64 tdc_raw;=0A=
+	int rc, i;=0A=
+	bool sign;=0A=
+	u8 v;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Unlock the debug page so the TDC registers are accessible. */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Select the debug clock for taps below 200 kHz, then point the=0A=
+	 * readback at the TDC.  Only the one bit is touched: writing the=0A=
+	 * modifier register whole would clear the fields belonging to=0A=
+	 * other taps.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				   SIT9531X_DBG_READ_CODE_TDC);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Latch a sample by reading the trigger register; see dbg_sample(). */=
=0A=
+	for (i =3D 0; i < SIT9531X_DBG_LATCH_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_TRIGGER, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	tdc_raw =3D 0;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_4, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));=0A=
+	tdc_raw =3D (u64)(v & 0x07) << 32;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_3, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D (u64)v << 24;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_2, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D (u64)v << 16;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_1, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D (u64)v << 8;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_0, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	tdc_raw |=3D v;=0A=
+=0A=
+	/*=0A=
+	 * Apply sign.  Per the vendor reference the sign bit is active-high=0A=
+	 * for a positive offset: bit set -> +code, bit clear -> -code.=0A=
+	 */=0A=
+	tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;=0A=
+=0A=
+	/*=0A=
+	 * Get VCO frequency for conversion.  Fvco=3D=3D0 means DIVN is not=0A=
+	 * programmed (PLL unused on this board) -- skip silently rather=0A=
+	 * than spamming the log on every poll cycle.=0A=
+	 */=0A=
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco) {=0A=
+		dev_dbg(sitdev->dev, "PLL%c: Fvco unknown, skip TDC\n",=0A=
+			'A' + pll_idx);=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * phase_diff (seconds) =3D tdc_code / fvco=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco=0A=
+	 *=0A=
+	 * To avoid 64-bit overflow:=0A=
+	 *   phase_ps =3D tdc_code * 1e6 / (fvco / 1e6)=0A=
+	 */=0A=
+	fvco_mhz =3D div64_u64(fvco, 1000000ULL);=0A=
+	if (!fvco_mhz)=0A=
+		return -EIO;=0A=
+=0A=
+	*phase_ps =3D div64_s64(tdc_signed * 1000000LL, (s64)fvco_mhz);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 76d7d7d21d3d..f813126077e1 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -528,6 +528,105 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pi=
n *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_phase_offset_get - phase offset of a reference=
=0A=
+ *=0A=
+ * What this reports, and what it deliberately does not:=0A=
+ *=0A=
+ * The ABI defines the attribute as the phase difference between the signa=
l=0A=
+ * on a pin and its parent DPLL device, so this is the loop's own residual=
=0A=
+ * error, sampled with the loop closed.  On a locked DPLL it therefore=0A=
+ * trends small -- that is the measurement, not an artefact of it.  The=0A=
+ * framework expects successive values to be averaged, which suits a=0A=
+ * closed-loop residual and not a one-shot open-loop capture.=0A=
+ *=0A=
+ * The chip can also measure the reference against the local oscillator=0A=
+ * with the outer loop's correction frozen, which is a different quantity=
=0A=
+ * and the one the vendor's phase-difference procedure produces.  That=0A=
+ * needs the digital loop filter held (and, on the 1PPS PLL, the automatic=
=0A=
+ * phase- and frequency-lock helpers held off), which leaves the PLL=0A=
+ * undisciplined until it is released.  A netlink read must not do that,=
=0A=
+ * so the open-loop measurement lives behind a debugfs operation that owns=
=0A=
+ * the freeze and restores it; it is not this callback.=0A=
+ *=0A=
+ * Precondition, which this callback cannot create: the TDC compares=0A=
+ * against a signal the PLL drives, so a PLL driving no output with its=0A=
+ * zero-delay buffer off has nothing to measure.  SiTime confirms this is=
=0A=
+ * a property of the hardware rather than of their measurement script.=0A=
+ * The script satisfies it by mapping a spare output and restarting the=0A=
+ * PLL -- side effects that do not belong in a getter, so a reading taken=
=0A=
+ * in that state is simply not meaningful.=0A=
+ *=0A=
+ * Non-selected pins and a PLL with no programmed divider report zero=0A=
+ * rather than an error: the DPLL core propagates any error from this=0A=
+ * callback and fails the whole pin dump with it, unlike the frequency=0A=
+ * offset getter, where -ENODATA makes the core omit the attribute.  There=
=0A=
+ * is no per-pin "no data" for phase offset, so it is a value or no=0A=
+ * callback at all.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,=0A=
+					 void *pin_priv,=0A=
+					 const struct dpll_device *dpll,=0A=
+					 void *dpll_priv, s64 *phase_offset,=0A=
+					 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	s64 offset;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The on-chip TDC is a per-PLL resource that always measures the=0A=
+	 * phase difference between the VCO and the PLL's currently=0A=
+	 * selected reference; it cannot be pointed at an arbitrary input.=0A=
+	 * For any input that is not the active reference there is no=0A=
+	 * meaningful per-pin phase offset, so report 0 instead of the=0A=
+	 * active reference's value.=0A=
+	 */=0A=
+	if (sitdev->chan[sitdpll->id].selected_ref !=3D dpin->id) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		dpin->phase_offset =3D 0;=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * -ENODEV means the PLL has no programmed DIVN (unused on this=0A=
+	 * board); report phase_offset =3D 0 so a full pin-get dump does not=0A=
+	 * fail just because one DPLL is dormant.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENODEV) {=0A=
+		dpin->phase_offset =3D 0;=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The ABI reports phase offset in units of 1/DPLL_PHASE_OFFSET_DIVIDER=
=0A=
+	 * picoseconds: the integer part of the attribute is the value divided=0A=
+	 * by the divider, the remainder is the fraction.  The TDC resolves one=
=0A=
+	 * VCO period (hundreds of picoseconds), so the fractional digits are=0A=
+	 * always zero here, but the magnitude still has to be scaled or every=0A=
+	 * reading would be reported a thousand times too small.=0A=
+	 */=0A=
+	offset *=3D DPLL_PHASE_OFFSET_DIVIDER;=0A=
+=0A=
+	dpin->phase_offset =3D offset;=0A=
+	*phase_offset =3D offset;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
@@ -535,6 +634,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 	/*=0A=
 	 * The measurement compares the PLL's running feedback divider with=0A=
 	 * its configured one, so it describes the device's own reference=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 251c98dc7cbe..aa60be243e6d 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -256,6 +256,42 @@=0A=
 #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
 #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
 =0A=
+/* Debug register unlock */=0A=
+#define SIT9531X_PLL_REG_DEBUG		0xBD=0A=
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3=0A=
+=0A=
+/*=0A=
+ * Signal pathway debug readback -- PLL page.  Dig_Sys_ReadCode selects=0A=
+ * which point of the pathway is tapped, Dig_Sys_WriteCode carries the=0A=
+ * modifiers for that read, Dig_Sys_read7..read0 hold the sampled bytes=0A=
+ * and the trigger register latches a sample.  The TDC phase=0A=
+ * measurement is one tap among several, reached through read code 69.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3=0A=
+#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4=0A=
+#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [39:32] + sign */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_5		0xBA  /* [47:40] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_6		0xBB=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_7		0xBC=0A=
+#define SIT9531X_PLL_REG_DBG_TRIGGER		0xD0  /* read to latch a sample */=
=0A=
+=0A=
+/*=0A=
+ * Reads of the trigger needed to latch a fresh sample.  One returns the=
=0A=
+ * previous latch, which the vendor procedures work around by reading it=
=0A=
+ * three times.=0A=
+ */=0A=
+#define SIT9531X_DBG_LATCH_READS		3=0A=
+#define SIT9531X_DBG_DATA_BYTES		8=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+=0A=
 /*=0A=
  * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
  * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
-- =0A=
2.43.0=0A=
=0A=
