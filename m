Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CC4F797D;
	Fri,  9 Oct 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570221; cv=fail; b=XC3K0KKRbChev6XCiSg1kuAjuelg8xqk8KwBMzXX0c+rYmaNUjm87CGWrbDidoNic2IqMiihkJVkri4DchtxAYql7v51tXMqA5lFvfXf4/5mj9jydGqYMQcBfRxd1yefUbpzz9djbO6bLnPmU9Kb0wkKmuYCgRHV2Be+K6daJJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570221; c=relaxed/simple;
	bh=SYXUxgo8mAeo9f+KNih5bawPzy8uA2109PniKBA+nRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzMw1/mEkXNOb7JXhhNQ762zhM7XuJU+DxAmOd70Iv6Tu4L2daiDfTUvNwi39G2NBtFwSelgMHn5FMRV1tsqTWQko/B0FXgw6AnhN2uw/HQFjEYVyi3I4sedShqRZyiu5cK4MAwfGcXNKXm8n3KyuqjzNNeusL/J0PF9KPbA/oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=GPhyXlzO; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=DS9+70oX; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="GPhyXlzO";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="DS9+70oX"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7FD6524D791;
	Fri,  9 Oct 2026 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=SYXUxgo8mAeo9f+KNih5bawPzy8uA2109PniKBA+nRg=;
 b=GPhyXlzO1uEjZMEzQuCFeN3N5nhsoNEGfR8lrK00hIu3BTMTsl+N80VAtG5WOpFUmy7yMc35ccxjeUXNclH/M6JnKWLoRV2rrkVaPfU0F165nbJsVzbVudpV+jE0RQMCK1orvjnVcBIGxT1L1iQUsE08gV/KnP6+Cf96jEHrdz9/rqQCQbtIQaOrP0zTNknjQZ/Jgtq+vqHYZddqOJPQQ26NWDMsFDBE9N6oHd7kOnFSZLa1reipZwnheH0eETY2tbjTUbQinKMbxvZyaxFrYK7ptgxWjpIaKx5Nk8bwbkNF87mVwkOFJqwFMP21p/yeIQbUPTYuM49VdzOQ3pbb5w==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022092.outbound.protection.outlook.com [40.107.209.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A56D810007A;
	Fri,  9 Oct 2026 18:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WijDXlJbMqdkppA+/TZ6Umuk/KfW6tyzlFGmFhjBpMi0wT8WAjSNs2oEapPaVi7FIPl2IYFpVYJNY7oJzN3G+YSaAlvBJoe+dQExu6cvMSgWgPH3BC0aMxWvCjPKZxTEsweTa704sX73qznbdRQnvhF74DROcozphHrRb3z9cBYWRPrGj4PIK5zhsmD7Cei0xTHskWdj3xzEyb33ia0IO9Rm/4a9DBBKqHsk5AVmxLOvR9lIC5VIE00GKPLpeeScs2l0wEoIKWrQtcN3VSVbUIZXFZXt5W7mL7ebsBbu21RkXgN0/1jnP52lythIQUKZHIh+wnHZs6vV1RvIG+sY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYXUxgo8mAeo9f+KNih5bawPzy8uA2109PniKBA+nRg=;
 b=NJUQ/LNPUZn96zPbSGWsodtayq86a4lEYf9B68BLe94FgypFpRFrWce8rXPuQ6JF08n2JvpRscIS/WQxSbJFAetExXKEtJcLvMjaT5MGtaAy7AUI4W9POM6XRU+AlkxSAcJpOUEwWsqnigXMywF/hyeEPMEpYTgTOqdWJLTH8fRn+sZQwBC4xOvv0tayf9E9V57ilTXLG0inzCU/loxlVt5Ocr1+HUS/4EhsiRBwK3FlTTqxeBI2FdZ/4rJE/PpVn52I3esdDOsUfhS0g7FJduanD8gUj/wN3gTm1Ao/0qHOE8eheeaE/5mduJesjkVNg6GhesHtVM3x+wKiN8RpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYXUxgo8mAeo9f+KNih5bawPzy8uA2109PniKBA+nRg=;
 b=DS9+70oXEaDiCmRaqxj1aTxqW5EM6WrSn1LEmaI/smrvxo7qQLEGLZOY5m65/kQVi1gNUagdcaWB9OoEYS6+nkfznXEdo/QJAvrq6bwZvloj0CYgmxj60mD1xRXY6WvuqrmIlaP6o3VLMT0VCuTRtEsmY8jDpqiw+i3MCQBa2IZOH0jze61sjOTWgdKcxjSKKKEq4BVGsndwoBXEsxUllCRdKDeP8FTUzK0xpgUf8jkP6Uvuvk2QhAfRl+pN6WC/yv3IQs3voWLkJ/Gx3Y/wBkSVbgCBlIiFDYXYmbhVhS8SiyUX9vjK/FAAZQrAA82pk/ZKKBoceeRBEG76YjpE3Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:27 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:27 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 07/13] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Topic: [PATCH net-next v11 07/13] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Index: AQHdUTSirven4+BgMkagf2I9rPqrtLbuKhMAgAdqBYA=
Date: Fri, 9 Oct 2026 18:23:27 +0000
Message-ID: <20261009182323.76166-5-arouhi@sitime.com>
References: <179116260093.434549.16690142118388089479@kernel.org>
In-Reply-To: <179116260093.434549.16690142118388089479@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: 32c04b58-35a2-442a-84f2-08df263269a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|5023799004|22082099003|10067099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 1GuzcNbPr8+RvLa9nrYrbIj3+Jl55bQiJhZdsjTSxhaBdk5jWzJ+9agsoKcbl5rDB4f5ND91yCr5IiwcXNjQw43Eg4agnyW4gHdqsWQ4/8V3UGfLW731ON+IHbSw5sW0xxtmmZbTnz8eOz/6HLePcMJS4VKyWCAoSFnNKUgzaDtGEy8ECl9vMP1KW6NzqY76JhpRJRQerBLO/4hcpEcylkU3vrOdmnHHDRV/I1B1hMZFXoErB3zifbCdr1w/3A++YDK9VqXgF+ijT/zlDev4uKfLL3mHhw+j/HucNONVjM442hnCFr6F+0KqhQVwG0e4Kr02Nkuwh0/qOftIYNPrs4ZHZyU8lnRPIfrcAjNd8aenD6xNC8V0bDxIcMQ3h3NT51kpacL3p1LEbDwVcHspnwcXLe9icnbwaUa8qiSJpb/jKlcT4LkQxoaduPLG+ZbTQu32IRSTPqbwPi5pRJ0Bt/P07uVBaOk28BWrlS4ezgklWGY7Yal/6fR0I6G1mKAnOlsDsN5nd+F7UDLE7jdohvIU6/KoFYP5nk8d4SOmBU1zkmrTigEH22HqDQFgEdlmdq278LSQNJO9JB8KWFcnGU+Fn7XyHtpwqEh7AdsLwXFutLTmwTOT/9sgu+/UPBObfyt8jcajEgOFNp7qIiQCeiXHgSNRwAMXcAJq7Swnh4h1xBnc/3QqNsZeDd7zs6CPkl6DKzd/Zc0pPZPztzI+PDxVuHb56Zj1ytR1hbuaV0Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(5023799004)(22082099003)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mgtysWUxS6iQ1mmBPgIj8sdSarSa3dU17fW4VcnC2NZpnvMg+OaMtcTZ++?=
 =?iso-8859-1?Q?B3HzTy2ztxcDTCQxcReyYjNJDOmD+o9EXZsgRBcSQe9oK7B8gJcSmXsUc3?=
 =?iso-8859-1?Q?4ENIwiDssbm8psjYgAPMmvUqgZ/pcg2tqxhRt8XRjA2+n3QA1R2Wf8Mv6J?=
 =?iso-8859-1?Q?Kgngtn8inKqzv2upMFyM2UVeEad0xW7eQ049MfeSO9N+2eZLcZaN0wJ7wC?=
 =?iso-8859-1?Q?saJ5k6IGdbr8zV3tuq5l3ORUsKg0HqVSxSK43cY5ORr6JWd4tABHj88SoE?=
 =?iso-8859-1?Q?eSdNpgjnV+CDDA82JaTLjtxu0QTic46ACn7fr4NlXgGXXW5hdY6Yp0F4Do?=
 =?iso-8859-1?Q?4ZSOF3B/6jaweUyJ3pW0i49dxrHFcfxav4EsjryquYrGweoQBkotRynB0M?=
 =?iso-8859-1?Q?CqnYei1oYiVg4lRibUaLoY7nSvE2nJnBkv0ZKSUv7T5J6gAKv4ud8R/QVD?=
 =?iso-8859-1?Q?Kx4dnqSmH0d8yLoyaAvEjyTEwR10X9UG2vPG+nNln2n6iinWlOpvEts1Hw?=
 =?iso-8859-1?Q?0Cwu3YQKIrLphTVd9O2r+060DD1Y5QttPY1PT9elPOhHljWyK77duNU4Bz?=
 =?iso-8859-1?Q?Y9vmoFgvc1x4Prlvd2N6bJnmV5DLOLQ4b0+qvFCURoHl3iL8DGr1R+Mr3G?=
 =?iso-8859-1?Q?0kwmXXHCtOjBlM0cOzoiSNHI+qBZ1Do+u5WeupBdNEyFQooKLlr8f6l4sN?=
 =?iso-8859-1?Q?CJ3iS3u84FyVx9SyAZ4mWpnIYdN5g7656ReQ9efUzHDDIUx02j3LZ8Akry?=
 =?iso-8859-1?Q?/UR4tFiO5H9b2ZjUG8oXR8ij98N+/Wxlg7mr8QLyguH+7XrPXpBUaiqSck?=
 =?iso-8859-1?Q?yuqRMeUDUl46ps/n/Y8zgwA704hNMtI1qTzEdopioQBlLvYKn6JQfLSfoa?=
 =?iso-8859-1?Q?l2BEg7aI1MueaJli6DSkDmet7nBJIeHJx85y/DC5hYXb7oBFKpTg1Lrstb?=
 =?iso-8859-1?Q?f9SB0DjFyccz/nToe3VLQrOTxjtleoNLCFWkPzxZ06iNMYhEP9uwgVrre5?=
 =?iso-8859-1?Q?7fZer7HBr1zhcx2/DceNHSRREJvkbcC8XuvBnhIbHCRZkmqJNZZZnijhcY?=
 =?iso-8859-1?Q?x7GYsfdineHdWonjSavK1RgEinQo4ncvAayXfD6b3IpgVo1ysdiO5q7Jrv?=
 =?iso-8859-1?Q?MhQ7PlJlzKZo0muzyZxtcx2kREGcpmyDAVF+YAi9phy9eXedX5pc+kFNfo?=
 =?iso-8859-1?Q?o0RrWRKonUBWtXfWruvqb6AduYWgZqG36F8xoTNK80RrGjOm4AMs7d77ot?=
 =?iso-8859-1?Q?5/1RAghp303leAumV2KBYFq3v6Et7u6a5ifYyb4fhh6wp1ckI2+K90bHG0?=
 =?iso-8859-1?Q?Nf3fxjkkbdg/oMEKIeueDfSkn96yij3uuxHVrPIJG2/0MJT9wNaVGko6LR?=
 =?iso-8859-1?Q?QBzEBREiGap/Ijgs6PIEwILdLi2OfJ0XHkLJn7GCzQTDaW63E9UDy4ehna?=
 =?iso-8859-1?Q?ZV0E0DqtFhZDz1PlTB+8gHkkJn76EGj4XOS/3gtX5FW4r6zREEu1QW+l7L?=
 =?iso-8859-1?Q?Dn/omhH867XNJKR3KFDVxPsbRf4RrCWRBOGehaiI+EfUvkvtw5uNhETU/S?=
 =?iso-8859-1?Q?tJGNGcpytyzvIWGQb72KRtuMgzU7TSI8oaqY8qKAkTMAYfmHdMcc/CBpuT?=
 =?iso-8859-1?Q?QINQVYgwi6INV3IbrF6R3aasvrMyBI0KZ89fEDYBPdt3FPVBsMaLSaTU7Q?=
 =?iso-8859-1?Q?F6u0H8L4r48hZF9FfjEKQXWDG6whbD3K7PxZzaXIWhwl/E5F33WecB0ERV?=
 =?iso-8859-1?Q?AbhXaaUWZXN9irvVvEAjSBHn8CQODFjgTeqrBp3LiRwej+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cbn+u8Wtj7nTcQewryVUQ3teDIAqmUoOmzgqX07vK0dgPdsWglu8RvuY5XzNnrg4YhRfmPnZLeO/XLwlm+TDrZ3CbtH8J09etSflSdoVlUgZUbq1NfzHCY3dW+4wxy+Jn9jYh5vlGzfyl5UfvGr4lPKey+GQJ1vvT6FGQ8kwPum5O+rC/ZQNohvz76QYb5qfVWeVTgK1MpZ3ZLONorZflKW4n5oD2AzOWtQG9T1+P5XByi9FKwBoQUpWgOm9YAEF46w75Wm6A390Bbhu1RBNk4o93qfvVHyfIGPzAocfYXoKIZvm5q273ZNkxowAbdOFKtZWkvL8CsEgjVGjYLSmvw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c04b58-35a2-442a-84f2-08df263269a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:27.2270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQQdNDoVCZycdVkYje0gJXkm5pDssI1XybgarVRwvqrF6CJUHBUm6G4uqjSGCLNTjc71MT2LJz5q/6uUV6mgvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570211-2NGySACfz-cr
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570211;2NGySACfz-cr;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Replies inline, in the order of the summary list. The first, second and=0A=
seventh items are one question and are answered together.=0A=
=0A=
> [Severity: Medium]=0A=
> Is the active selection ever looked at again once a higher-priority input=
=0A=
> recovers?=0A=
>=0A=
> [...]=0A=
>=0A=
> Doesn't that leave the PLL on the lower-priority input indefinitely,=0A=
> while sit9531x_dpll_mode_get() reports DPLL_MODE_AUTOMATIC? The commit=0A=
> message says the selection goes to "the highest-priority valid input,=0A=
> which is how the DPLL interface defines automatic mode".=0A=
=0A=
> [Severity: Medium]=0A=
> Can this keep a PLL on a lower-priority source while a higher-priority=0A=
> one is healthy?=0A=
>=0A=
> [...]=0A=
>=0A=
> sit9531x_dpll_mode_get() always reports DPLL_MODE_AUTOMATIC. The uAPI=0A=
> defines that as the highest priority input pin being auto selected by the=
=0A=
> dpll. The commit message describes this keep-in-place policy, but it also=
=0A=
> says the driver follows the highest-priority valid input. How do the two=
=0A=
> fit together?=0A=
=0A=
> [Severity: Medium]=0A=
> Has the clock monitor had time to qualify a newly enabled input by the=0A=
> time the selection is picked?=0A=
>=0A=
> [...]=0A=
>=0A=
> The device only leaves its selection on LOS, and no poll path rewrites=0A=
> CLK_ACTIVESEL. Wouldn't the PLL stay on the lower-priority source after=
=0A=
> the new input qualifies?=0A=
=0A=
That is the intended policy and the commit message now says it more=0A=
plainly. The device re-runs its own selection only when the source it=0A=
follows loses signal; it does not notice a table rewrite. Moving=0A=
CLK_ACTIVESEL on every commit was the first version of this fix. Each=0A=
move is a re-selection, which takes the PLL through holdover and unlocks=0A=
it for about ten seconds, so a priority change further down the table, or=
=0A=
the removal of a source the PLL is not on, must not move it. The rule=0A=
became: move only when the highest-priority live source is a different=0A=
one than before, and otherwise stay on the current source while it is=0A=
listed and has signal.=0A=
=0A=
What that leaves open is the case all three items describe: the preferred=
=0A=
source recovers, or a newly enabled receiver qualifies after the pick=0A=
ran, and nothing re-selects. The device's own revertive switching returns=
=0A=
only to the source CLK_ACTIVESEL names, so the driver would have to=0A=
re-pick from the poll when the highest-priority live source differs from=0A=
the one in use. That is a re-selection, with the unlock it costs, on a=0A=
timer rather than on a request, and whether to take it under AUTOMATIC or=
=0A=
to document the behavior as non-revertive is still open. The commit=0A=
message states the rule as implemented and the open point; the mechanism=0A=
follows in a later revision.=0A=
=0A=
> [Severity: Medium]=0A=
> Should empty come from the table the device ends up holding, not from the=
=0A=
> requested one?=0A=
>=0A=
> [...]=0A=
>=0A=
> The release loop then clears HO_FORCE. Wouldn't the device be left with=
=0A=
> an empty table, no forced holdover, and an ACTIVESEL naming the=0A=
> disconnected source?=0A=
=0A=
Fixed: the decision is made on the table the device holds after the=0A=
refresh, not on the request. A failed write on a PLL whose table was=0A=
empty keeps the hold, and so does an empty request whose latch failed.=0A=
=0A=
> [Severity: Medium]=0A=
> What happens if the table write and latch succeed, but all=0A=
> SIT9531X_HO_CLEAR_TRIES attempts here fail?=0A=
>=0A=
> [...]=0A=
>=0A=
> Doesn't the retry then report success while the PLL stays in forced=0A=
> holdover? The poll does not retry the release either, so the PLL seems to=
=0A=
> stay there until some unrelated table edit runs the full sequence again.=
=0A=
=0A=
Fixed: the release is owed and the poll retries it every tick until it=0A=
lands, logging when it does. The request still returns the error, since=0A=
the PLL is not tracking when it returns.=0A=
=0A=
> [Severity: Medium]=0A=
> Should cfg_prio[] and cfg_known be restored when=0A=
> sit9531x_prio_table_apply() fails?=0A=
>=0A=
> [...]=0A=
>=0A=
> The poll sees a changed priority and sends a notification for a=0A=
> priority that was refused.=0A=
=0A=
Fixed: the configured priority and its known flag are saved before the=0A=
apply and put back when it fails, so nothing reports a priority the=0A=
device never took and the next rebuild does not use it.=0A=
=0A=
> [Severity: Medium]=0A=
> Should chan->ho_valid be checked before holdover is kept forced here?=0A=
>=0A=
> [...]=0A=
>=0A=
> Doesn't that keep the device on a holdover estimate it never marked=0A=
> valid, while userspace is told it is in holdover?=0A=
=0A=
The force stays: it is the only way the device follows no input at all,=0A=
and a PLL whose table is empty must not keep running on a source every=0A=
pin reports as disconnected.=0A=
=0A=
What changes is the report. When the driver itself forced holdover for an=
=0A=
empty table and the device has not marked its holdover value valid,=0A=
lock_status_get() now reports UNLOCKED, as the uAPI text asks; HOLDOVER=0A=
is reported only when the device says the estimate is valid.=0A=
=0A=
> [Severity: Medium]=0A=
> Is it safe to go ahead with the pick when sit9531x_input_mon_fetch()=0A=
> fails?=0A=
>=0A=
> [...]=0A=
>=0A=
> The comment in sit9531x_prio_activesel_pick() says such a write sends the=
=0A=
> PLL back to the dead source and it unlocks. Wouldn't that happen here,=0A=
> with the request reported as a success?=0A=
=0A=
Fixed: a monitor read that fails rolls the commit back and returns the=0A=
error. The selection is never picked from a loss-of-signal state that may=
=0A=
be a poll period old.=0A=
=0A=
> [Severity: Low]=0A=
> Can this early return leave HO_FORCE asserted?=0A=
>=0A=
> [...]=0A=
>=0A=
> Should this path also try to clear the bit before returning?=0A=
=0A=
> [Severity: Low]=0A=
> Is the old value of HO_FORCE meant to be thrown away?=0A=
>=0A=
> [...]=0A=
>=0A=
> Say the loaded profile or an external tool left a PLL in forced=0A=
> holdover. Any SELECTABLE or DISCONNECTED change on that PLL, or a later=
=0A=
> priority set, would then quietly release it and let it lock to a=0A=
> reference.=0A=
=0A=
Fixed, in two parts. A force that failed to write is released all the=0A=
same, because the write may have landed: the failure goes to the release=0A=
path rather than returning. And a hold the driver did not set -- one=0A=
found set with a non-empty table and no release owed, so placed by the=0A=
loaded configuration or by a tool -- is left in place by a table write;=0A=
only the hold the driver set for an empty table is released. The force is=
=0A=
written as the register was read with the bit set, so the=0A=
read-modify-write the finding points at is gone.=0A=
=0A=
> [Severity: Low]=0A=
> Now that operstate_on_dpll_get is added, does anything send a=0A=
> dpll_pin_change_ntf() when the operstate changes?=0A=
>=0A=
> [...]=0A=
>=0A=
> The gap seems to exist only at this commit.=0A=
=0A=
That is the state of this patch; the next one, which adds priority,=0A=
extends the comparison to operational state and priority, and that is=0A=
where the series ends up. Moving the comparison into this patch would=0A=
compare an attribute the patch does not yet report.=0A=
=0A=
> [Severity: Low]=0A=
> What happens to seen_srcs when the commit and this read-back both fail?=
=0A=
>=0A=
> [...]=0A=
>=0A=
> Doesn't that overwrite priorities set through sit9531x_input_prio_set()=
=0A=
> with slot positions from a table nobody asked for? The reseed check=0A=
> cannot tell a failed write by the driver apart from an outside rewrite.=
=0A=
=0A=
Right: two consecutive bus failures make the next poll adopt whatever=0A=
table the device holds, and the configured priorities become the slot=0A=
positions of that table. Adopting the device's table is the designed=0A=
recovery for an outside rewrite, and the driver cannot tell the two apart=
=0A=
from the table alone. Remembering that its own commit failed, so that the=
=0A=
next poll refreshes seen_srcs without re-seeding the configured=0A=
priorities, is a small flag and is noted for a later revision. The=0A=
priorities the poll reports in the meantime are the ones actually in the=0A=
device.=0A=
=0A=
> [Severity: Low]=0A=
> Does the rollback skip the register whose write failed?=0A=
>=0A=
> [...]=0A=
>=0A=
> Later in the series, sit9531x_output_divo_write() restores "the byte=0A=
> whose write reported the error" (j <=3D written). Should this sequence do=
=0A=
> the same?=0A=
=0A=
Fixed: the register whose write failed is restored too, from the byte=0A=
read before the write, which is what the output divider's rollback=0A=
already did.=0A=
