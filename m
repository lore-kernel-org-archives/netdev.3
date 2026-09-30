Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730644A9D5A;
	Wed, 30 Sep 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811443; cv=fail; b=pk2v5wjC9mFDWQ/E4WinXcI+FazdAgS7Bnc9qFLIeAav0Lur+JHwja5QxsMHKBGeV9m9EREdl3DXLxCIBYp8JaaJsYBxswFNaaS4ogDjweemfn7YKZ+Zk7HD5UltLzy6ZPMS6mqbu3pqruelBwYdKzQFIGMOJmiwxpyg8V4toTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811443; c=relaxed/simple;
	bh=+oxDhA6CEHOJDOMZ6jHPwLwUvbKPL9J1WEuguWKfYFo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hj2bS5zuVbkVmJi9tNXxFLWOiGJ8AB8xLMkHJu+J6i8o2GYQe2Cck5lejCWY2QUvee0dDT4uIHeTt+qSVGmVyLYdt0o5vhEWyhMu8jw2HbDlc7uHrqUKxYYs/nkSnpY69CMD7dWkiiIFBIfKDdfITGjjXZVsvABRlmHBrdeEjcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=lV3e7TzH; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=KEYqAj5U; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="lV3e7TzH";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="KEYqAj5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=mail; bh=LVXjQ2oQCqYKsNANUt09wizOHQ/M20w1tSetvZsEjp4=;
 b=lV3e7TzHUZqTGSjaAE+cnJlRYazeKnjN8+94HHSbHmR5ueZl9D8uLfrerMCZPRctGojRo6qaYMzThvKOTTUEn9J45bCDC6E8Ors3tnXb5Lf8+egZh1WF/1pelRNgSocqCAY8JgKZ2HJ93UFu5nect60NrlEJhB9H5I+RiM/XHyHQgv/vEjlw5hfY7Os9Y30AZaEcbRVBTwxp+jD8vE1nFiBH48WxvK5x5reGQk3teCMTEtUGD4xjaSdvW/rDAwa9JW05y5lHrzpLA+rAd/7s970cmBJnuG9p7Q/AIkE60Vhr9o4snhYLdFwW/zC3JqxwsHie4Ij9P5TtWQvD3o5F3Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020134.outbound.protection.outlook.com [52.101.56.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8045B10006B;
	Wed, 30 Sep 2026 23:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqo1HypFKaIiTs0ZzQ6AD6Epbi+DiELXHgCcZNWAPopPM9Dj5gnC+mUnYfH9eAUqYwV4ZDQrVB4aG8TfX+s1Vw1ZwoXat/RtJDyhlfByjIxFQIMXsj0ATdREZv2ECSP1X198tEYz+BuU8kIcIcUaH3FsU34Cu3LbJOGQP9CyyruB4clLbzCKRlzH37Ag0t00Ppvjwq4WQ/5y2TV2LHlSEOdIpIW4OW9pml1Z8KJWcU/D7CSfAboLtJybsGYG8YL97xqV5AE+XwiMpofze5YOpsLErQy0bnzUoNQpSvAGUuHnLy3pXWBeiwZ5tqZkGgsC2wyyaygOMvtpi4SYI7oevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVXjQ2oQCqYKsNANUt09wizOHQ/M20w1tSetvZsEjp4=;
 b=l1QFEf4NhQaa640Me39lI3NrjjTWQzDtlHktg7nUTbGq+/QW77YOA7upvOZvwzR1775sEo0PooyNIVJauijZg2lrvytQ5dBNS6Y2WsqvuYI0AGlmT/il7/0eUY9woZXr+yP3QFQT0yvNN7qgVujUZOoFza1RHyOmrFAV2cafrWo/mJhDqyC4JhqA6IGX4aalkRP4addYNPcPzSukIbatpY+VPJxcZkNXPuMiErfOU3BgM3H2Mg+DeFhd989k+9DkAAOJttwmq7nbQvWRZXbUOyNQjzkJloEiQA/hmg4yYvy+NToQuCn1yg8XiE/GPretRRCp3SOL+PsKrNvt8rNt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVXjQ2oQCqYKsNANUt09wizOHQ/M20w1tSetvZsEjp4=;
 b=KEYqAj5Uvfhuw2j3ZPgZ3iOtXJesNDe3qzzuJXrdTr7xYw1C9IWWb5T9522K8s0D/agUWoq6WvLyCz3y3FyhrV28zq6jmy+RAZE95rmqiVwhtmjuTE7+Qcm4SM//eMewml0rVKeh1ExX5SCe2SPVG2WtPKD/03/WDq7Jc1JUms8nq75hpiCM9OfBKCTURuEyZ8Cu1z1v7BCDBGPEEhZXW4Rn6mPOgknrwN27BKvdH3039frqN0hfSKZrss86TI1kbw9/FlmzrQ2kPLDVneHLg9enB7eTVJLu2f9RMsEnOivDixVfek1SNuU8CW+4q0Ij8E+LyqxK4iVe9mUIJ2pHZA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:37:17 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:16 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 00/13] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v11 00/13] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdUTSgzjEIf6E2skKb+0KB809IzA==
Date: Wed, 30 Sep 2026 23:37:15 +0000
Message-ID: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: 33797a99-9134-4160-ad84-08df1f4bc2c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|38070700021|3023799007|6133799003|10067099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 Gp5JWLNmtYRoTG0L26XuFB/eSK7Y6BTaSFAG7papYk9FxJeY+5Qteb+aJDYOnPrjr4iyCaZ8GuoHIYolWMqbPzhC9Xuxlc72Vbt9/jkyjgu5oRHKBItCxdSlMJjR8vqHFLk167WGtx5kvavMtNwQAYnz/X5DSUp8550mIXQ3XjbRVr6MDE8NmBblm5FBNYyKV20ExyW5+v+0Rx8LHcg3XEr9CDyh3pR82aWI65DmTerHU2WDZCJdNlrQthLvHjwiwvpl9FRCX4oV8+Mm2rggIBMXiLkKdK2Kj6lsZQ0EDSGUa6Kb9VkPFna4MKAO0HEe/N46OfDDSojiGmPsFo2enpzRcg1RDMEFdAUCTSmiGiPEV1RWTLcAXMRESw/P/yOqdBpthbVL+vBSYwC+hgrS1TOrIFD5HXIiqXosXuchKsFjV0csK+GJjKKD3Dw7C4g7wXOHhmyWr1ovUsaRayy+4SswlTI0n6VZKpSfwJYw9ozWBel1UV/BsS0XpBB6hIYXXMSsdjLnbAX1oNt42vK5QBGpd/7+ef+IUIF58ZcVQm8hWSPGXRA/jsPi2vMDLy9U/k4r1Uj6V/9veEk2iBA/F6M5bXD3YwgW6iNfBs+6QVlVuWfnl9auBmF0rek7e1uHIk+hjv2nVpQnD1lCeRyc0qyezFDEK8BSBq3eJdOLI92g2XNYobj5iR3QG8VFRV79XzvDczLQmlA/iZVKHVUGeWAegD6576oEMDgZzOOZK9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?V8k6iBPGiU8RxMkvf9p+1qApcNyolyBPesxprn0CNwfJWeHEFjlnHNDlTq?=
 =?iso-8859-1?Q?yl0sI7bNf3bVFkoefYRgsj5rU1QnC7Fr8mE8oAouyNJaKQiFnysy1OBFHO?=
 =?iso-8859-1?Q?SRfo8t77Gx9hbxswm106s5fitU3n4HGEXAnUfZWcUQAxK1K095uf5nRUDz?=
 =?iso-8859-1?Q?0YB01i3++obAACgjL37wfQ/+PmKesIWwpFrnUJJladjfy1cSswvqP24tTi?=
 =?iso-8859-1?Q?QyLzTAQPXyBE7Af5rjp8ClxztRZdldWlnuejt6rhQrtNIkfTdVKRlDb+I0?=
 =?iso-8859-1?Q?xmxfpfXAcLDIlfTXT82k8VBRuKdtOm0F5/PMXMhUsRPdTP4FWSDDYXL+LD?=
 =?iso-8859-1?Q?kX4vyzQ/aMvfEQGWHWpJhEDt135UXMz6d5u1greACEtt4vVEiHPus7mrer?=
 =?iso-8859-1?Q?YVRbtburYASWlVOzOYLsj2pOKeb6ElarP3ROu24K9w1MTGrabRmbu0iyuP?=
 =?iso-8859-1?Q?MBxlgJtgX3JH3Z5n6KsVY1M6fn8hi+GeTxXDB26v/kvw0/iNAF1zk20SrT?=
 =?iso-8859-1?Q?rAA77AFZzbBAtOjP5j1H5tenLHteRzE3CUHiamUMcRHr2fQrpnQMH6n6AZ?=
 =?iso-8859-1?Q?GgebDfMbY5WeWPOQNmdPkWlWf9eAlIoAQUaAn6tiw80F5rCEHDYM5s7Zq8?=
 =?iso-8859-1?Q?4LzMxBK6EGacZDwwsBIHqUpJoJoQkd3H9q51B2ff7/5mZY9ISLRlM3Jhvm?=
 =?iso-8859-1?Q?J3nKb9KqqMLG7rY3SOg/4ZKoLRUYYwkUNnc8uws4eeYi5Ia7Zswf2wGAOW?=
 =?iso-8859-1?Q?F1pMUeZMze65QGJ+wuQQT/TH2NOz/2D95wA2L+yzy9QKbRZpROSSxNA7uQ?=
 =?iso-8859-1?Q?YhPHHr+HHr+EZ60tqF+PO2yspKrl5+X4pXT+bIn5i6l460XYevNhZ2OO70?=
 =?iso-8859-1?Q?5+ua7QB64xfW1mvB8sMJjuquUYFFiSYsY3c2dkfxas4PGlkL4I7YGuZUaZ?=
 =?iso-8859-1?Q?4EiMVaOsXQjFtmMyiIXwNvExZbMeMy2T27+z1/seWGQK1C5s7MBw8u28iB?=
 =?iso-8859-1?Q?VURwDaFGOjBfBsz0KLzRgN5KBNrF47skzxkV+056Kct9CZP7imQQ2sLiG3?=
 =?iso-8859-1?Q?hWv3sWsCskoCRW1fE/GSxdhrAw8yu6iet6oFG/wuY7PAk7JJ4ytfOADL9p?=
 =?iso-8859-1?Q?Q4G3hAIIkopZgZGS9G+4crOF0MT4DCVR35NLtmk3BaSVhxodD40W7PNlZF?=
 =?iso-8859-1?Q?aWrSTtSlqHsX0L6PttR9Mv3bj0YseHnh7WYGZPPaOtcgcaeAP9ej17e+pn?=
 =?iso-8859-1?Q?y/RYtAkTAqhqzHSzHMbWM7/XlEDBuC3alj5wdEY7LoZxQCHrfGm8EGJ8lL?=
 =?iso-8859-1?Q?UTKkHOSgeiTn0T0mDGoecnkYqWz+tLbi2KTw4no1YNvvC/I5EUtj25Ld4B?=
 =?iso-8859-1?Q?JWPDWFvjz+3Rr5Rodcw7838ggoCGJ9qYN58U0wSuvzIENz0zQOpkHFbW1y?=
 =?iso-8859-1?Q?49yLpWZFk2sE4O0RFU7OB/ngvXzenOXwEBaiYeWOBrT5AaZTmEfL0i87YA?=
 =?iso-8859-1?Q?yU2NSyf24RjVM5nXHgIFWZPJImwf1tAAeV/y2orSR4/9LA3hh/a15B4ttI?=
 =?iso-8859-1?Q?kPV3OGFd+Q0ENZE/OAae38eKIbzdw+o2dAmH7HMKhw6UvzIVBDvujpnHJy?=
 =?iso-8859-1?Q?sTKJx4tN/yzlz2vGqk4DOY3HvULw1FKWk/3hLyxBbVINBEObgyQR3XNjPF?=
 =?iso-8859-1?Q?1MUwbg0s0GichA+amgRZFUh7H4+VyiD+0xZ06PwYwUtRqRF8JoPgX1pQxw?=
 =?iso-8859-1?Q?zTut4HOupiiMjVOB/hRLiM1nZbvvUWGrQRxTNxV7EWI2Wg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wiaZzfZSS1MdaWrGdcNQDgXGDkex4QkkiIUIsGTukMbJiUtDiRG81YYz6YenQ/QJxAFnVoaVoFY0oIbXgQ4prAgXGqCJkYS1zYZUeuWBAW+gvwlZVfZwC/ANAVxwyfcCMDfoEVDznWb+jjoNKekGo3i9RAXws9AwzVcmLej8vvR1A/kBz+B4Ssr24uhdK3TGrmKZuhSb9gJn3qAEBeKTYl3Ju6vfYh8HouAWerl+nuuasGxJIF539s1Nj6i069KD3Gqt2k+YDnU/w+4WJdOssu27m7rxM0XnQk9rEdlq4KwP5xVbCDqB1LwPkI8+hLAlUju2dSL8Kke16TC4ssreTA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33797a99-9134-4160-ad84-08df1f4bc2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:15.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fIdcXZMlI+kuCTA1SEz8WAXi6izYGpREFgfdKV8ziQWQTxD0WqxhOEYFuXE7YdiA7V0rJKVUTiUWAV4FCR2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811440-dOLUdWF2ZyYI
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811440;dOLUdWF2ZyYI;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

This series adds a DPLL subsystem driver for the SiTime SiT95316 and=0A=
SiT95317 I2C clock generators. Each device integrates four PLLs with=0A=
automatic reference selection and on-chip TDC phase-offset measurement,=0A=
and is used for synchronization in telecom, networking, and data-center=0A=
timing.=0A=
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
=0A=
v10 was set to Changes Requested on the review of its binding patch, and=0A=
we asked for it to be dropped from patchwork rather than restored. This=0A=
is the promised replacement.=0A=
=0A=
The review of v10 raised 82 points across the thirteen patches it=0A=
covered. Seventy-five are fixed here, five are addressed in part and=0A=
answered on the thread, one patch is dropped outright, and one point was=0A=
made moot by a change made for a different reason. Two of the findings=0A=
were real bugs; both are described below.=0A=
=0A=
  1     bindings: allow hex unit addresses on DPLL output pins=0A=
  2     bindings: vendor prefix=0A=
  3     bindings: the device schema=0A=
  4     basic support: paged regmap, variant detection, probe=0A=
  5     DPLL types and pin properties from system firmware=0A=
  6     register the DPLL devices and pins, and keep their state=0A=
  7     input pin state and operational state on a DPLL=0A=
  8     input pin priority=0A=
  9     pin frequency, both directions=0A=
  10    output pin state (mute)=0A=
  11    output phase adjust=0A=
  12    phase offset through the TDC=0A=
  13    the inter-PLL sync net as a pair of pins=0A=
=0A=
The three bindings patches come first, so the driver never matches on a=0A=
compatible string before the schema that describes it is in the tree.=0A=
=0A=
Each of the ten driver patches builds and links on its own: no patch=0A=
calls something a later patch introduces, so a bisect cannot land on a=0A=
tree that fails to compile. That was re-checked for this posting patch=0A=
by patch with W=3D1 and with sparse. checkpatch --strict is clean except=0A=
for the "does MAINTAINERS need updating?" hint on patches 5 and 6, which=0A=
add files under drivers/dpll/sit9531x/ -- patch 4 already covers that=0A=
directory with an F: entry.=0A=
=0A=
Five things are worth reading before the changelog.=0A=
=0A=
The first is a change in what DPLL_A_PIN_STATE means in this driver,=0A=
and it is the structural change in v11.=0A=
=0A=
Until v10 the input pin state reported what the device was doing: a pin=0A=
read back CONNECTED when the hardware had selected it. dpll.rst says=0A=
PIN_STATE is administrative intent and PIN_OPERSTATE is what the=0A=
hardware is doing, and the review was right that we had merged the two.=0A=
State now answers what userspace asked for -- SELECTABLE when the source=0A=
is in this PLL's priority table, DISCONNECTED when it is not -- and a=0A=
new .operstate_on_dpll_get on the physical inputs and on the inter-PLL=0A=
sync destination reports ACTIVE, NO_SIGNAL, QUAL_FAILED or STANDBY.=0A=
=0A=
The active predicate deliberately requires more than the selection=0A=
register. It requires the loop to be locked, because that register holds=0A=
what the driver last wrote or the device last chose and not proof the=0A=
loop is using it; a free-running, frozen or unlocked PLL follows=0A=
nothing. And it requires the named lane to have signal.=0A=
=0A=
That second condition carries a limitation worth stating plainly. When=0A=
the device fails over on its own to another source in the table, the=0A=
registers this driver reads do not name the source it moved to: the=0A=
selection register still names the lane that died. We therefore report=0A=
no pin as active rather than report the dead one, so on an autonomous=0A=
failover userspace gets notification that something changed but not=0A=
identity. That is a limitation of the driver rather than of the part --=0A=
there are status registers that report the reference a PLL is actually=0A=
locked to, and reading those is work for a later version.=0A=
=0A=
That register is now written as well as read. Until v10 the driver=0A=
rebuilt a PLL's priority table and left the device's active selection=0A=
alone, so a table write could leave the selection naming a source the=0A=
table no longer listed, or one that had lost signal, and the PLL=0A=
pointing at a reference that had just been disconnected. v11 picks the=0A=
selection alongside the table, following what automatic mode is defined=0A=
to do -- the highest-priority input with signal -- with one exception:=0A=
when the write only reorders sources below the one in use, the=0A=
selection stays, so a change low in the table cannot pull a PLL off a=0A=
healthy reference.=0A=
=0A=
We believe this is what was behind a re-selection failure Carolina=0A=
Jubran reported against v9 and again against v10, where a DPLL kept=0A=
following an input removed from its priority table until that input was=0A=
removed from every DPLL on the device. The inputs are shared receivers,=0A=
so removing one everywhere powers it down; the device moved then, but=0A=
not on the table write alone.=0A=
=0A=
The second is the fractional frequency offset patch, which is dropped=0A=
and not replaced.=0A=
=0A=
Patch 12 of v10 advertised BIT(DPLL_FFO_PIN_DEVICE) on every input pin=0A=
and published (running - configured) / configured. The review pointed=0A=
out that this is not the quantity the uAPI defines for that attribute.=0A=
In the pin-parent-device nest the attribute is the offset between the=0A=
pin and its parent DPLL device; the offset of the device's own output=0A=
from nominal belongs to PIN_TYPE_INT_NCO, and zl3073x follows that=0A=
split. What we published was the offset of the loop from what the=0A=
configuration asked for, measured against the local XO -- a real=0A=
quantity, but a different one. Two drivers answering the same netlink=0A=
read with different physical quantities is precisely what the attribute=0A=
exists to prevent, so the patch is withdrawn rather than argued. The=0A=
finding was correct on the ABI and correct about the code. Offering the=0A=
right quantity means measuring the reference against the DPLL rather=0A=
than against the XO, which this part exposes through the TDC and not=0A=
through the dividers; that is future work, not a v11 fix.=0A=
=0A=
Nothing in v11 advertises DPLL_FFO_PIN_DEVICE.=0A=
=0A=
The third is that patch 14 of v10 is dropped with both of the=0A=
device-tree properties it carried, which is the other reason the series=0A=
is shorter.=0A=
=0A=
sitime,output-pll-map is gone because the routing it described is=0A=
discoverable. Each PLL page holds OUT_MAP_LO/OUT_MAP_HI naming the slots=0A=
that PLL drives, the driver already reads them, and it never writes=0A=
them, so the routing is fixed by the configuration loaded from NVM at=0A=
boot and no DPLL call changes it. The property was kept on the strength=0A=
of a claim that those bitmaps can be ambiguous; they are not, and device=0A=
tree is for what firmware cannot discover.=0A=
=0A=
sitime,pll-fvco is gone because the driver derives the VCO frequency=0A=
from the registers, and that derivation reproduces every rate these=0A=
parts are configured for. Keeping a property to override a value the=0A=
device already answers for is the same mistake in a different place.=0A=
=0A=
The fourth is two driver fixes that the removal of sitime,output-pll-map=0A=
made necessary, and which the DT override had been masking.=0A=
=0A=
Once the output-to-PLL association comes from OUT_MAP_LO/OUT_MAP_HI, the=0A=
bit order of those bitmaps matters, and on PLLC and PLLD it is reversed=0A=
relative to PLLA and PLLB. Our register map defines OUTPUT_ENABLE_PLLx=0A=
identically on all four pages and does not say which bit is which=0A=
output, which is why the driver had assumed the natural order on all=0A=
four. The map is being corrected separately. The driver now indexes the=0A=
bit accordingly, and it accumulates the claims from all four PLLs=0A=
instead of stopping at the first match, so a slot claimed twice is=0A=
warned about rather than silently taken by whichever page was read=0A=
first.=0A=
=0A=
The second is the forced Hi-Z path, which was asserting the override on=0A=
the CLKP leg and on the master output power-up but not on CLKN. For a=0A=
differential output that leaves one leg still driven by a mute the=0A=
caller was told had succeeded. Both legs are now forced.=0A=
=0A=
The fifth is that a PLL the loaded configuration builds without the=0A=
phase-flush feature has nothing to fire after a frequency or delay=0A=
change, and was previously left with its output dividers counting from=0A=
wherever they were. Such a PLL is now restarted instead, which restarts=0A=
its dividers from the PLL phase, as the documented procedure does.=0A=
=0A=
Changes in v11:=0A=
=0A=
  - Pin state and operational state are split, as described above. The=0A=
    input pin state callbacks answer from the driver's own priority=0A=
    model; the new operstate callbacks answer from the device.=0A=
=0A=
  - Priority is kept by the driver per source and per PLL, independent=0A=
    of whether the source is currently in the table. Setting one input's=0A=
    priority no longer perturbs any other input's, and a pin reports the=0A=
    same priority whether it is connected or not. The hardware table is=0A=
    rebuilt from those priorities: members are ordered by configured=0A=
    priority, ties broken by the order the table already held, packed=0A=
    from slot 0, and the remaining slots filled with the code for no=0A=
    source. That also guarantees each source occupies exactly one slot.=0A=
    Four separate findings about the old free-slot search dissolved with=0A=
    it.=0A=
=0A=
  - The device's active selection is written with the table rather than=0A=
    left alone, so a rebuilt table can no longer leave a PLL named onto=0A=
    a source that is gone or dead. Described above.=0A=
=0A=
  - The inter-PLL sync disable path had a real bug: on full success it=0A=
    fell through into the block that restores the global enable bit,=0A=
    re-asserting the net it had just torn down while returning success.=0A=
    The success path now skips the restore, which is reached only from=0A=
    the error gotos.=0A=
=0A=
  - The Hi-Z rollback had a real bug: it always cleared the override bit=0A=
    and never saved what the slot held on entry, so unwinding a failed=0A=
    request could un-mute a pad that was already muted, by an earlier=0A=
    request or by the loaded profile. The write now reads both the state=0A=
    and the override first and restores them in the reverse of the order=0A=
    they went on. The mute itself is now ordered value first and override=
=0A=
    second, so enabling the override while the state bit still holds what=
=0A=
    the profile left there cannot pin the pad driven for the width of an=0A=
    I2C transfer. A rollback that fails is logged as leaving the override=
=0A=
    half applied.=0A=
=0A=
  - Binding. A new first patch widens dpll-device.yaml's output-pins=0A=
    pattern from ^pin@[0-9]+$ to ^pin@[0-9a-f]+$, so a device with more=0A=
    than ten outputs can describe the rest; it carries a Fixes: tag. The=0A=
    device schema now bounds pin reg per variant, so dt_binding_check=0A=
    rejects an output node the SiT95317 does not bond out, and the=0A=
    example exercises the widened pattern with a pin@a. clocks now=0A=
    depends on clock-names, closing a hole where a node could carry both=0A=
    a clock phandle and clock-frequency. The argument about dtschema=0A=
    types moved out of a property description and into the commit=0A=
    message, where writing-bindings.rst wants it.=0A=
=0A=
  - The one remaining read-modify-write accessor that could leave a=0A=
    stale cached page selector behind now drops the cache and logs, like=0A=
    the single-register accessors.=0A=
=0A=
  - Manual-selection reporting covers GPIO_INPUT_FUNC_CTRL5 through 8 as=0A=
    well, so a reference pinned through any of those inputs is reported=0A=
    rather than half of them.=0A=
=0A=
  - Comment and kernel-doc corrections throughout, including several=0A=
    where the text no longer described the code: the divider guard that=0A=
    still referred to a band clamp that no longer exists, the two mute=0A=
    comments that disagreed on what a mute does to the pad, and a=0A=
    kernel-doc field description that named the wrong slot.=0A=
=0A=
  - Tags. Patch 2 keeps Conor's Acked-by. Patch 3 has changed again, so=0A=
    Krzysztof's Reviewed-by is still not carried across it.=0A=
=0A=
Two rounds of this series were shaped by bench reports from Carolina=0A=
Jubran. The probe path that accepts a clock-frequency property when=0A=
firmware exposes no oscillator through the clock framework, now patch 4,=0A=
came from her report against v8; the input-handling work that went into=0A=
v10 -- emptying the priority table when the last reference is=0A=
disconnected, giving a meaning to every slot code including the input=0A=
pair this part does not have, and reporting connected as selected rather=0A=
than locked -- came from her report against v9. Both came by private=0A=
mail. v10 is being dropped rather than applied, so the credit is=0A=
repeated here.=0A=
=0A=
Three items from earlier rounds are unchanged and are repeated here so=0A=
they are not re-raised.=0A=
=0A=
The phase-adjust granularity stays at 1 ps rather than the 30 ps fine=0A=
step. The delays this device can reach are not a lattice of 30 ps: a=0A=
request is split between a coarse delay counted in VCO cycles and a=0A=
three-bit fine field of 30 ps steps, and the two are added, so the=0A=
spacing depends on the VCO period in force. Advertising 30 would name a=0A=
step the device does not have. A request is accepted at 1 ps and rounded=0A=
to the nearest delay the registers can hold, and the getter reports what=0A=
they hold rather than what was asked for, so a caller that needs the=0A=
exact figure reads it back.=0A=
=0A=
A frequency request of 0 Hz is still refused with -EINVAL rather than=0A=
treated as a request to stop the output. Nothing in the ABI says zero=0A=
means off, and this device already has a mute control that says so=0A=
explicitly.=0A=
=0A=
The u64 truncation in dpll_pin_freq_set() is still there and is still=0A=
not ours to fix in this series: the requested frequency is read as a u64=0A=
and validated through a helper that takes a u32, so a rate of U32_MAX +=0A=
1 + N is accepted as N against ranges that are themselves u64. That=0A=
affects every driver behind the interface. It will be posted as its own=0A=
patch against the core rather than buried here; this driver range-checks=0A=
its own input in the meantime.=0A=
=0A=
Ali Rouhi (2):=0A=
  dt-bindings: vendor-prefixes: add SiTime Corporation=0A=
  dt-bindings: dpll: add SiTime SiT95316 clock generator=0A=
=0A=
Oleg Zadorozhnyi (11):=0A=
  dt-bindings: dpll: allow hex unit addresses on output pins=0A=
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
 .../devicetree/bindings/dpll/dpll-device.yaml |    2 +-=0A=
 .../bindings/dpll/sitime,sit95316.yaml        |  175 +=0A=
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +=0A=
 MAINTAINERS                                   |    7 +=0A=
 drivers/dpll/Kconfig                          |    2 +=0A=
 drivers/dpll/Makefile                         |    1 +=0A=
 drivers/dpll/sit9531x/Kconfig                 |   17 +=0A=
 drivers/dpll/sit9531x/Makefile                |    4 +=0A=
 drivers/dpll/sit9531x/core.c                  | 4887 +++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h                  |  434 ++=0A=
 drivers/dpll/sit9531x/dpll.c                  | 1448 +++++=0A=
 drivers/dpll/sit9531x/dpll.h                  |   69 +=0A=
 drivers/dpll/sit9531x/prop.c                  |  469 ++=0A=
 drivers/dpll/sit9531x/prop.h                  |   37 +=0A=
 drivers/dpll/sit9531x/regs.h                  |  412 ++=0A=
 15 files changed, 7965 insertions(+), 1 deletion(-)=0A=
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
base-commit: 4bb9710c6a68d35207f123aef55dcd50e7195ec5=0A=
-- =0A=
2.43.0=0A=
=0A=
