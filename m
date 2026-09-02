Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35957419314;
	Wed,  2 Sep 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385275; cv=fail; b=Wx7wo+ab5QaqLGK9jtaCKuDxD7lP3DE9rMU6V3XnwZVR9pULlJDZXXJuN6sTw4Vae/RfXrvWKPwNEccCOSt40LD0QOdevnZ0cj0QreXb4yjbsxD4iFgXLCyZ9c9DtLBK/zr+uljTCx9wJNqzUCuzgMf1boHNPaLtd99LdHb7gq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385275; c=relaxed/simple;
	bh=db0J2i23D292h3YUAGIYzqRIkuKPRgAbx3fwY1v+Q5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxhjakrwH/YTD3fQZZhBCmLa2SCsnSHXDdWq54Aq89UgiVaCoZL6rf6PjkK8PBIKUlm6sWN7YrFqI3uE4ZeCh+N83Cgfmag5XjTrdUD8fbEdxPwZkG//r8heMdhfRUGk5d1MhCQ0jKqP2wccp3m8F5Fjm8SoglB57FBoJ/atSsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=SB0tqVGF; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=k3MT3VG4; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="SB0tqVGF";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="k3MT3VG4"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E3A96609724;
	Wed,  2 Sep 2026 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=THKTLIml6M5cMckA4VhqdsRGYRBcu9B3QWWRAUycu/0=;
 b=SB0tqVGFp8DOQIExkfJ8mqfCboWt0+3HYo5vIeOJhMPAlzbNl3Qhd/9wt1e+3pO4K9Dt2ewWw2a9ORO6I6Y27yoQ+c4H2EanbAAub+jt8qF9yhGg96Vq+j2oM5q9xWfTBaYuPfsnt+hiuwZxJIzcfENDpBRiZ/I7lkJ/uZOQKlL/vkDyNSknU49Ep+MVWj1+ufYQf4Z/nYRH/CZG3wlqP23PBxjRbLu+fWyFvgq6zqsbGhQY1K7S8BEmRJSXxm0SCuo1+e9NG4mH2MQ/L8DfJk//5UOQaGCphV3weF/Sq7ZY2O36VN1/ZjWnXMrZqa5HFncVqPVvuKp8p+ujNA8d4w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 399313C0070;
	Wed,  2 Sep 2026 21:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSnAgF7povXROFqzXzMOiXqdIyR8pPR79seXmQAPz8TfwGEDS2P3XGtNv4c4V3RexmJqzSXFroqlv7b8gdDGRBJrXYsmvolsE3Z3DLhkdlGjXW+k2tf+PFVMNxPmogEFSBcqYFrVO/eMhSWrICOEhMiEasjlp1h4oJm+SMSU0pXv8aRh9CW62sTmwBtkcUPAd3zc4OsmN66CDFlPVuHg0tQ3ikSd2iHvxOlPSPkC34gDLpPuayi4dzisJ4n84zPmeUWsYKUehYRf1aiBG9mEHB1V2A6YsCTnnzhP+mTTX1smWeZEay8P+p8CvL9jG4bPYNfoM2hmRvuY8Q17VqBwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THKTLIml6M5cMckA4VhqdsRGYRBcu9B3QWWRAUycu/0=;
 b=LChg4zn0GQfFk+nt9TqLZYPuSLgWODEracPxnHFMh1jwgW2bBpT2f4+82DonnljWpjCYQNsQN6xws/AWtatambMAYsB+Y5BjQdXBz/vc4It/sHntdZfPXZ5lGXdqHx55UB7WV7vewSdA5+Ivbypc8mCVX1smBCJ4NFC48Lb94GgcujPYjSJMFkt1xqz8P1szWAAvfitWEjqbR67aEOWdp8AuPCCO4Hmk1QGToKwwS0Wiqe1Qrjb6ZWJN49aF6uxeT6YCP6xPckl8BXVWoROlqMtvj8kQ8+A91GD4dviPF4EoUzCxQnvsgKMDdRDBQcPwnMfJyl1Epn+GQZzdtRt4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THKTLIml6M5cMckA4VhqdsRGYRBcu9B3QWWRAUycu/0=;
 b=k3MT3VG46drMDXLum0/hXgoNKc8WmbRh2baPtHs2fiadX0KMpXxKbDGP60l9urM6LXZPqAnme/xyKPOosAZUEPuGP/sT7Iw55SIqA4I2qsWgrkJ4h6DPTHgg5v3hjkyIgsQcmphV5UgSRh/zTQTfteG02w02lANF6pslU8vezHMHkbih0z8QrpQ5WLGhzK3GDS6MfoUSDvoLB3wGSdYhullMjKm/5pP5w8/Pup0FKE2kv6GMiwml2uRJidYZEk/F2T8cROPRk56/rFJAWcXzGWylInQ6S+gHI2Eo90RvPSp5WGBYQDfmR76hapyM7Hcz1Uwxq31XzmsJTVlhLaUBtg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:36 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:36 +0000
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
Subject: [PATCH net-next v8 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v8 10/15] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdOyOwjZgFSvu6YEO+bGTsW6Wpyw==
Date: Wed, 2 Sep 2026 21:40:36 +0000
Message-ID: <20260902214030.20955-11-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: f255b82f-54f1-431c-d6d8-08df093ad307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 3Y6am3MksklyG39f/XHaK8K2g/EXN3NdycbtFDJyIC54Sl8gvXpUUDACL017XnXsubF3DMwaGwRZ/sgKt1pwS1cO2Swed8i4Ko6JuZPBGMDbxEojVhDuO8bRohnTafVVOux9pE2w794QSFozIFf4FzQ2QhqPC/bC+yw+1yDiygZB/wRqGXbSxaE7avm6xsurnfCU4G+NO2+Vx+uOx3Iq506p10PATOUCPW+RfgcborzCNj9UBxxiGqiY0AYeuoeYk3MZkeVoLvzz+7WpGHrVlPC+W1QIDzasLHtXtpMwqEbf6ZZYrgAHNZkG/j636770lYdwGsdPXBBAcf0wzvQn2H/R6Y8QK7WG+tnQmjFzmQtx4RZUKN/JIy167kgSA0JnmJ4a40OHw4bGZT0ZJvhE5xgT9BhobJ5OTj1LC5sRn1SXHZLp7Di8urIjfbO0EolH8fqT80DwGbFfFx+YlEPDgdaAsMabvSgY671hdeqpGnsDAXN5zXWIOtx5zjtMDItKUNHl3ao7BmdzAAVFPJfyK6W2jBJgcYhzHhEFv33JLcLSk93jr7FOKfMf3o/ovXgB4jUCWnTNl6yrNvL6U4Qz4BWJenmaEdv22k7vQ2L79J7tmr+UGjsc4ZlzOgTaqsojC8JBE4DsKDgUN9fPHfOr8efE4StvE0+TIjCDsEFJ4U+5taAUK9fGeozNpt+6sn6thYa051bx3G9mr0MqKkmvjVwt82Dw7mjAGO4DNHbe6uY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tO9fmLpmotRwGBMLK00vk52MoEegrKtLcFui7seSpRlC4PSY86fw9chPVg?=
 =?iso-8859-1?Q?uYBrjnl7/nfoNy7xrxt4S6Rt88nK8kJoBYpHP73IijFYsxe8y6KpgTLc+3?=
 =?iso-8859-1?Q?5eHe5lEciWZhvZrEXQPfaKgWejKpT9n5YJZ6ZFV7Be1UgeQDRHR3oxIRGi?=
 =?iso-8859-1?Q?sRb+45f4yeje4Aoda0dJyKSoVeLs5O11CQN3B79+E6EE4Dp+k/EHN7ICz8?=
 =?iso-8859-1?Q?/Qv3vjvYwLEeS7p6Ckr/sHfNIB3TREuxEhpsV4yFa4i6gd5qliGx4VCtlO?=
 =?iso-8859-1?Q?YaJcehl7aT/Xu6T+z1rNhe+K0InvpusbD0gfzxin41a9WBotN9qCIGy3C0?=
 =?iso-8859-1?Q?Q5oHHVqwn0r49FYN38t8+p7OV5CVjg/+7D36iwFzEdU4jo0j2MKj5e2/Bs?=
 =?iso-8859-1?Q?f4GySyimPE7h4//suzzpSR/ypXf+x3TyA9n9W79mQ38kzXfeX3sWBD31UN?=
 =?iso-8859-1?Q?nvEBcQ7TootI6R7ELgfeUsDr2+m3d2nYrgyvJmH95iM7LKdvA9VjdYMAyo?=
 =?iso-8859-1?Q?GXr7/o+rlrXZn+3coyB1KTTNiXvsHsBgPwP8z/Q8s5GNbE1YgPdzjssCPd?=
 =?iso-8859-1?Q?jpS3NKemeLGVnqf4AtpdOk8tLPbd5Btksyj9hPj20PoQLwSG4+coE9LsPM?=
 =?iso-8859-1?Q?8Tt3RnpPEfaEJqiKwArCMYtP0QYchATlD6/Jt2YQ+bTsZkwaWVrTDHJp4I?=
 =?iso-8859-1?Q?ep94HjjuhS6s2R47uI+8RwG2ZyJKq4GTcyBb5qhJM4/VgU5FjZhdWgoQ3y?=
 =?iso-8859-1?Q?tb+gwdXWmT7K0wTx2nJ57Kxaji7HdaQ3vCCkDwsgYyjpYoDpzwEXmJ8UOg?=
 =?iso-8859-1?Q?/LstGyo7PxKIzlegCK/CCovHKv34WycrO5/NHC7giHGLlJ27fBHCX5rVU4?=
 =?iso-8859-1?Q?Wrrww1NE2RZAmf40lqms73+xqkkoBIhkgt4/+LIBZij631Ju0N2hi/AmFg?=
 =?iso-8859-1?Q?euEFlDE7k2f8SBz6Sd65OSre5Ja/g++Bob6lsuJCumSs14Z7rx6DaqeXon?=
 =?iso-8859-1?Q?8ywcrAPsYUTVYVE0gsVCuTZ+DfSgyAhZvQUhMRltXPsTJU+eOdClkKIjGB?=
 =?iso-8859-1?Q?BkgXKg2sByKy+XEXTT/0ZjbNpaqKcYopy8jnym5UUNoyPw/lI4fNGF+Vb7?=
 =?iso-8859-1?Q?gwlt/gxjzrKKAIkR/SvgSrht9CEOzrfrC8GQH36oAESfSxBO8uuh+FjOeK?=
 =?iso-8859-1?Q?cY0ftKQQRUOZr5SToxukgdmygoQL1fTKq8ZbaO2L/BdJFGx8bujdECuKFe?=
 =?iso-8859-1?Q?0ZJlYegT7EceIrzYzRiYvx/5od08kgypY1Rtaceh6FgL9m8AHGMou/OHNa?=
 =?iso-8859-1?Q?ybdo7fhkRU+kbRdhgWMJ7MSxrCmUt8dQMYUvIYRbGF6Y5SHrFx3EPW5lU9?=
 =?iso-8859-1?Q?zg+yjKSnC+Jyh/Ec/LAX5tH4JjyoPnLqGwP2ZiMEK/uNgAABifv5wP0Tmu?=
 =?iso-8859-1?Q?BvrEo3HCYPvMqQzp3s8r4ccHKR8RJJRBDnVf6D2ORHOnIsigeIRh+Npzmz?=
 =?iso-8859-1?Q?/RTRaGqqrZrnsCs5P1eeeLWY/XMpKPA35vgaxjF3aQnyNVQuGg4fyyavFe?=
 =?iso-8859-1?Q?06EWUcnuEzXuqCJTWB9QXC5vwTGjoa6cvWi0QmSExpGHFQEKSXFrp0tMlT?=
 =?iso-8859-1?Q?TnWShuqvwNMFulE5/szLSjoLPiMOEA8rzAQJ3Tp9dtAlgH0JuEHa5mWfvP?=
 =?iso-8859-1?Q?0RMf6E0MX3QuFQg810gUOv1XOsDV+/q0ZHzyPaJNpCfFYxbEl79ZDc1vNB?=
 =?iso-8859-1?Q?iX0VhcNIdRlV51syQ/kUmjwzNwFDvwcR8X+2wJ8uQrxC3+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dszrYu3V+FyP5E3fumGkyN9XkptxCo7Bg19gS84Y/yE9TktQi73SbmpRG0Vc2GHptkiAaJK44J+HjVJoW9CLWPv4RK2AV1abSWn3MTfKC+OjewdtkwPXBgI8VeU8a9KlJEHCU/2BTHNMw2O/JgPDPOsntbAOCfGYI5uiCvxFtQfqcdBpaxDcDzOXBQtMEuOKRpbrnev8PPTXRER1hlD8dJd1kvs9uId71JrMn8CCXp987xNEsdlyw2gs4Ehh9BsbztoULwGHCYyN47Zsv8GD9Xzzyo19cR7cmTZmgIpPFakQzDwVEbMfOcrTSLTxKshjIlbOlfOcQkvF71ZkUq0yZg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f255b82f-54f1-431c-d6d8-08df093ad307
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:36.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxKm2NgwN81hFWEtbEhrMQm6OKiwuNfnRVWVPFES1os+l0PBXs+K99YeaZCdX7fn8IAhzZQ/UIp7Dsx0IcvYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385243-54kRcb8s2Y6O
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385243;54kRcb8s2Y6O;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Shift an output in time against the others driven by the same PLL.  The=0A=
device has a coarse delay counted in VCO cycles and a three-bit fine field=
=0A=
in fixed thirty-picosecond steps, so a requested offset is split between=0A=
the two and what the core reads back is what the registers hold rather=0A=
than what was asked for.=0A=
=0A=
Delay only ever advances, so an offset larger than one output period is=0A=
folded back into a single period -- for a periodic signal that is the same=
=0A=
phase.  The write takes effect in the programming state, which is left=0A=
with the loops re-locked even when a write inside it failed.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 143 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c |  51 +++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  26 +++++++=0A=
 3 files changed, 220 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 0f886cfd1401..be033d7cfe7c 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1342,6 +1342,149 @@ int sit9531x_output_freq_get(struct sit9531x_dev *s=
itdev, u8 out_idx,=0A=
  * output period, which is identical for a periodic signal.=0A=
  */=0A=
 =0A=
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
+				     u8 out_idx, s32 phase_ps)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 abs_ps, fvco, coarse, coarse_ps, rem_ps;=0A=
+	u8 page, base, prog6_val, fine =3D 0;=0A=
+	u8 pll_idx, slot;=0A=
+	u32 freq;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	freq =3D sitdev->out[out_idx].freq;=0A=
+	if (!freq)=0A=
+		return -EINVAL;=0A=
+=0A=
+	fvco =3D sit9531x_get_fvco(sitdev, pll_idx);=0A=
+	if (!fvco)=0A=
+		return -EIO;=0A=
+=0A=
+	/*=0A=
+	 * Convert to unsigned absolute delay.  Negative phase (advance)=0A=
+	 * is rendered as T_out - |phase|, modulo the output period.=0A=
+	 */=0A=
+	if (phase_ps =3D=3D 0) {=0A=
+		abs_ps =3D 0;=0A=
+	} else if (phase_ps > 0) {=0A=
+		abs_ps =3D (u64)phase_ps;=0A=
+	} else {=0A=
+		u64 t_out_ps =3D div64_u64(1000000000000ULL, freq);=0A=
+		u64 advance =3D (u64)(-(s64)phase_ps);=0A=
+=0A=
+		if (t_out_ps =3D=3D 0)=0A=
+			return -EINVAL;=0A=
+		/*=0A=
+		 * div64_u64_rem() rather than the % operator: a 64-bit=0A=
+		 * modulo has no compiler helper on 32-bit targets and=0A=
+		 * leaves the module with an undefined __umoddi3.=0A=
+		 */=0A=
+		div64_u64_rem(advance, t_out_ps, &advance);=0A=
+		abs_ps =3D (advance =3D=3D 0) ? 0 : (t_out_ps - advance);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * coarse_cycles =3D abs_ps * Fvco / 1e12 ps/s.=0A=
+	 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches=0A=
+	 * one second of 1 PPS wrap-around.=0A=
+	 */=0A=
+	coarse =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);=0A=
+	if (coarse >=3D (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))=0A=
+		return -ERANGE;=0A=
+=0A=
+	/* Fine delay =3D round((abs_ps - coarse * vco_period_ps) / 30 ps) */=0A=
+	coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);=0A=
+	rem_ps =3D (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;=0A=
+	if (rem_ps) {=0A=
+		u64 steps;=0A=
+=0A=
+		steps =3D div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS / 2,=0A=
+				  SIT9531X_OUT_PRG_FINE_STEP_PS);=0A=
+		if (steps > SIT9531X_OUT_PRG_FINE_MAX)=0A=
+			steps =3D SIT9531X_OUT_PRG_FINE_MAX;=0A=
+		fine =3D (u8)steps;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Map logical output index to the chip's physical output slot.=0A=
+	 * On SiT95317 the eight logical outputs land on chip slots=0A=
+	 * {0, 3, 4, 5, 7, 8, 9, 11}; on SiT95316 the map is identity.=0A=
+	 * Page/base must address the slot, not the logical index.=0A=
+	 */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	base =3D SIT9531X_OUT_PRG_DELAY_BASE +=0A=
+	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	/*=0A=
+	 * The PRG_RST_DELAY bytes live in the output system, so the writes=0A=
+	 * only take effect when made inside the PRG_CMD programming state and=0A=
+	 * committed to the NVM shadow, exactly like sit9531x_output_freq_set().=
=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base),=0A=
+			      &prog6_val);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+=0A=
+	prog6_val &=3D SIT9531X_OUT_PRG_OPSTG_MASK;=0A=
+	prog6_val |=3D (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &=0A=
+		     SIT9531X_OUT_PRG_FINE_MASK;=0A=
+	prog6_val |=3D (u8)((coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MASK);=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base),=0A=
+			       prog6_val);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 1),=0A=
+			       (u8)((coarse >> 24) & 0xFF));=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 2),=0A=
+			       (u8)((coarse >> 16) & 0xFF));=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 3),=0A=
+			       (u8)((coarse >> 8) & 0xFF));=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 4),=0A=
+			       (u8)(coarse & 0xFF));=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even on a=0A=
+	 * mid-sequence write failure, so the output loops are re-locked rather=
=0A=
+	 * than stranded unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Restart the output divider phase so the freshly programmed delay is=0A=
+	 * applied against a known edge instead of the divider's arbitrary=0A=
+	 * running phase.=0A=
+	 */=0A=
+	return sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_clear_notifications - clear all notification registers=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 6365a83e4c52..c07fb2256510 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -736,12 +736,63 @@ sit9531x_dpll_output_pin_state_on_dpll_set(const stru=
ct dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustmen=
t=0A=
+ *=0A=
+ * returns cached value.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 *phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+=0A=
+	*phase_adjust =3D dpin->phase_adjust;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment=
=0A=
+ *=0A=
+ * Programs the per-output PRG_RST_DELAY registers for deterministic=0A=
+ * phase offset; see sit9531x_output_phase_adjust_set() in core.c.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv, s32 phase_adjust,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);=
=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Phase adjust failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	dpin->phase_adjust =3D phase_adjust;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
+	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
+	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 031c1a460d4a..91d33abd15c3 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -189,6 +189,32 @@=0A=
 #define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
 =0A=
+/*=0A=
+ * Per-output programmable phase delay: 34-bit coarse (in VCO clock=0A=
+ * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output=0A=
+ * has a five-byte block PROG6..PROG2:=0A=
+ *=0A=
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserve via RMW)=0A=
+ *                    [4:2] PRG_RST_FINE_DELAY[2:0]=0A=
+ *                    [1:0] PRG_RST_DELAY[33:32]=0A=
+ *   base + 1  PROG5  [7:0] PRG_RST_DELAY[31:24]=0A=
+ *   base + 2  PROG4  [7:0] PRG_RST_DELAY[23:16]=0A=
+ *   base + 3  PROG3  [7:0] PRG_RST_DELAY[15:8]=0A=
+ *   base + 4  PROG2  [7:0] PRG_RST_DELAY[7:0]=0A=
+ *=0A=
+ * Outputs 0-5 are on Page 3, outputs 6-11 on Page 4.  The block base=0A=
+ * within a page is 0x15 + 16 * (out_idx % 6).=0A=
+ */=0A=
+#define SIT9531X_OUT_PRG_DELAY_BASE		0x15=0A=
+#define SIT9531X_OUT_PRG_SLOT_STRIDE		0x10=0A=
+#define SIT9531X_OUT_PRG_OPSTG_MASK		0xE0	/* bits [7:5], preserve */=0A=
+#define SIT9531X_OUT_PRG_FINE_SHIFT		2=0A=
+#define SIT9531X_OUT_PRG_FINE_MASK		0x1C	/* bits [4:2] */=0A=
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK		0x03	/* bits [1:0] */=0A=
+#define SIT9531X_OUT_PRG_FINE_STEP_PS		30=0A=
+#define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
+#define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
+=0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
  * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
-- =0A=
2.43.0=0A=
=0A=
