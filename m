Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DB53C3C7;
	Tue, 13 Oct 2026 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931017; cv=fail; b=KEmIKg0qu2hziyDa6J+hDy3dUhwX9Pl13TccuqL+2CT8G2HQtZIVQoKo78y9VJ6feWGRjCfIL2Ln30SM4xYSn6nztXd21YySZiIHnZCL0fPwleVBBvT5beLpI9/36APhogYzcln6s6JJt0YhIAvc0uwB7UqO9QO5SNjtAJjQcJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931017; c=relaxed/simple;
	bh=IMYouLaaCV9+xE9u4xZoQ7IC97M7vqFBv0MFZKzeTqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ta8HNPdMEXbiafpOMTqJucXYzg+AgOp7CfQ+oKqJ/BHuTfc47euGVWrIdSA6WHYLyLbioqPXAVruPxfMcqKtX/wgHXDjMdb+vVabhk6RglqVT70JSbjcqUxkYieNLqedt4e6lVQAgpxcJ4RE+VbuP+mpS432wCdmyydcT8SwCkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=GMms5aKe; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=sG+Bjp7/; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="GMms5aKe";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="sG+Bjp7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=MHqoTEkpT7piJ3fZ9HEJ2X+U4hNsI7vG1TCPOFX2eDU=;
 b=GMms5aKewGPoV7eUGMgcN0sWU/qAvtt7Zh9VyaeS94KpvB5biFEsBUPFNatQiHfkK4YWetuUhX1Fsgti6FrBBFV7aAXgMAZaWXk6o5RoClbBEB0Rcf1NdTQp2l2CFGMr7cY4f6P3+PizQozLhz0wWNAcXMrZzD/FvBG3ZTpLPKFNG+fYuooc41N8FxRc8JTuAFf8pDsDJ7ZGTbWhpLVELiq/FuR7xwny3tHwZBl/ZqpreJxKm081b1S76cbU8EOSLF9o9i20sT/tE3F7/Gk6w/FStlbKxWW1jq4aqdsdpnoCWBxui79Om0EGSSst1mJe4RYRMwC8pt9R34AYfZPaEw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020079.outbound.protection.outlook.com [52.101.56.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6703C980072;
	Tue, 13 Oct 2026 22:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NauzjtBoxKCce92rFh2zlrGoMQ/4+WmUeS58KrDdPV1fHPllDPYijs3j8cL3wYX5IbMLiP7PNWvVxZaU9CZnDn/vPvU73jGy2nZzvaVHVNxzL5dXtpcWQcnsqtdlhdmnbA52nuofKjnZW7TdjrtqmSglsB1pmH/ndnoA31Xa8P33BtQFbe+2knnQPt6EyHlusGHwNRwrwbgg6E5qz3FDuZQgFgKl5IKv1XU49r+GajAu0AKej0Rhggetbqhincst27XufaoaMeXYFGCFXrKwx/qQyKhidzJG0+0YSDjewjwvbZ6oAM4k5yd9gweWItjI4dFcctBBRw6b6KEjnfxh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHqoTEkpT7piJ3fZ9HEJ2X+U4hNsI7vG1TCPOFX2eDU=;
 b=dPzk4ahmV+ZR7of/oto5vpiRTJJp3t3oGFGtzwofd4En5WcvvJoGjiezp9bclUvlaCq9Vu8UjQryxUC4auYWeQoOtnme7mlDVrs6hcNCFzPYEl0iBKxlNF7Iw8b6lwoTgjG3s86oNDEvZuxJfeW6+V49dmVUqXiOMauLf16y38WYmhwQYRe0MO86qj/SsVsc4xEVrrhzAofEtmIau3ka7DQUc1KUKjuq5PzbNONUbgcyCBBc4ZGG70BqbiuD6r9RIdqqV2t8aG+yhNly+x5W0/2j+jwH1+16fCy6WCw08POLlJqtD3JrxCKDHNQUZBbD+/hcaAjbPSE6vbeJHeFh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHqoTEkpT7piJ3fZ9HEJ2X+U4hNsI7vG1TCPOFX2eDU=;
 b=sG+Bjp7/4vWs0khglUl+neP9VigTVZDNSqJ75F4W7HhH2R17kX1UwaNl8JncDvXJLzHQbavF5oBciwpAMVRp5KV5oyjdXzwmG63IoA3QrVzpS7Pex7dqaYsDs2SwhuL1yRlxLJSqSh+2gxPqpqe8P6MiI2P5KPQVXDOxffpZFlsCI6kwXBJFaZ/q2E1AT0jaEsThom8bAl5HWZUdgou7YOIDYGplCZ1D9R4a0APTXf8DxqkoHVZAHKzGT/JQePA5m681gxPe9963As9fsPTqiEpNpqqRwPizXSQvOwaxcPi5MrNQcglttfHy97ZNXQCHHZcxxPWtCiOpOI8mDO5cMA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB596672.namprd20.prod.outlook.com
 (2603:10b6:806:3be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:36:44 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:36:44 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v12 09/12] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Topic: [PATCH net-next v12 09/12] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdWBx3LaY7UiR/AUSliu6UQfWoWLb7P0aAgADXIQA=
Date: Tue, 13 Oct 2026 22:36:44 +0000
Message-ID: <20261013223641.25560-3-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-10-arouhi@sitime.com>
 <a68ee429-c63e-4948-bc98-d895ed8066da@redhat.com>
In-Reply-To: <a68ee429-c63e-4948-bc98-d895ed8066da@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB596672:EE_
x-ms-office365-filtering-correlation-id: 5f946ae3-b7d7-4a7e-028c-08df297a7559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|38070700021|56012099006|18002099003|22082099003|3023799007|261009223027099003|10067099003;
x-microsoft-antispam-message-info:
 r1el/TGla0gNe90nQqZX8zoo5rOfcTAm+bBIYcfyZXdLv7gvQlzpR4dTMR3okN4wSNSIe/ZmXKz+tHKOq71Ob717a826hqO6SWIvz/fwmGyBh6mQ9Vf9ChWRWWGIt1I/zdY4TYo4NozzdRkvfEgxLALP5i5pAn6+HPeL1M4pMuYT0jCp0qjuYsKkGNkjFu9ZSWJUBkpSAzq0xZaJYk18hQ3gjMxlbYIsorX/DstyCUY43Yw7nFjkb6Ps00Azw/zbXIW2QvcJw22WarD7dXs0CKibucXLyYzL0wzPvA/t7cqE/W072GHj1lN2JhQOXkvdz6CEYvGhnPFMovq7i0kzmq0Egb/wuUh7ZHiqg1C40Kwyf+zTWBsEmzk3VJcCJw+voIVJKWJB8rqAnDuhx8Cobwqw8WdLP5cQGbD/9E3cYGNkMvliMRr02cFSfte7aigxKkf1KJYMoIOyhE2mcsmhHl/mlujosmGq5R6wBF131rIOm9JP2+87mqPakZlyfbeOwMTHP/rTTIKEgiTbM9A8mMpFTCJ9rQKK6D6k0rvgqFRckUnN5dg9ud2qyiQBa9nOeJXoUt06AVnQU/6x59heC38bC4T0nSckpJj/xSpt5ynwbtYKYh7WBSvscLNFD2b0jVKkoGUmcdrE2dvMUhjMmVDJJpe7FlzLagSh8IChmLKS+Jdc4rJoawvqiJ4jncgtEfoDF5SuPQj9mAL08oAb+g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(38070700021)(56012099006)(18002099003)(22082099003)(3023799007)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?daKJDKnIZsY2wTlZM39HmvdRAuP64dRGaHDgIEbaPDQdtvkaYkbXtYlWEb?=
 =?iso-8859-1?Q?cbuHLOt4YECfs9GLNH7NA7i06aC2w5hfpYiH3ULN+29bVrZ30lZGx4x5Ny?=
 =?iso-8859-1?Q?KMVseUhE+BSVJRRCGnlC/phVVnCKwpLbDmGAoERwNkrKkjbsgrVlPHCS2e?=
 =?iso-8859-1?Q?OHiIbdzUVX1t2h0xmlPFI7anquDlRrEXhi6nc9svkXBITII/xmDfOBMUE+?=
 =?iso-8859-1?Q?RAF8UGI8aZzPzj/fXiXETAIZTVuGEuyJ9UAjcw5Gqm275ZvNVwH6fSYogq?=
 =?iso-8859-1?Q?+K/ZAqgp8NmNRtlyJo1Ee2xWri5j5JOSgwexuYQ4qvUG6qFZSd0FwP2IHi?=
 =?iso-8859-1?Q?vfUBq16dSVLPuC2YBW24iOQ/p9j6mwqCY9ADpRqfJdBc0XmjgZmc0jEZTg?=
 =?iso-8859-1?Q?G2ctjEcpfQr8/1NtLNq702x6CheozFS674omjU33kuanRA0LGs/HV1sfgl?=
 =?iso-8859-1?Q?5FxOpGkd598I1yHbYqNUOUaloFIFDMCyCooz/Uz3em051BwRNrrwPlIJcp?=
 =?iso-8859-1?Q?wJakk3f4uvHUT9NFriKLQjMC9KAWeOjOmwUhV5939c9mi+JRCJzuuavqPK?=
 =?iso-8859-1?Q?2D0FNP3LwUg4nMFWYAgpZqNW5ghsbnK2FJ3Qxv3KOzKRlfhE1XX4gdcp66?=
 =?iso-8859-1?Q?R4D9nBMzYtGdzMiQkgGnu/NpBY4gGcTsDBzRUmYR+TdLOXjp5AJ47iMc+U?=
 =?iso-8859-1?Q?Jt7o7tjeGbXF/D5VzX5TvX+x94miRxwL3B9hLdJdyhOZTdcMwEB/h5JP76?=
 =?iso-8859-1?Q?TkujbKhmNCWrzcoi0o6Uw0nMcDRvL/HwoMfduOfSU0N2vsJSMbL5fo/Nag?=
 =?iso-8859-1?Q?ceqbjXDjwuhNJ2yyOXTdORD/UgQreSPb1fHTQLkTNvs4uc9c+b5MWrGxuq?=
 =?iso-8859-1?Q?6J9SKPHMBPqsSgE9E70rpaoZ2cf03MgKNO9PWtus0s9SLN8g0qYPlxpPUH?=
 =?iso-8859-1?Q?NfYTjXdeNRnP9uZnzqIAgNn8eitHTgcOHL7iDnFFAsQMoPqrPE6Ga3Wq9b?=
 =?iso-8859-1?Q?RZQPpfircL2w2rtSx1HgiLZUdLbME52jXn4FhARvr/JsRsWuxmUiFoFzly?=
 =?iso-8859-1?Q?ZrBLV/GYuEspw5omcFdefFrXcHtUzUFnWItYDMpC4y3T52PU49XY9RHhdC?=
 =?iso-8859-1?Q?YmcD3/iFYP7uzx0UjXcOv3uHpOPxGufWNLnhKPYbe+MNa3+72mWnSIWXMJ?=
 =?iso-8859-1?Q?tSA2uPPm+FUcx7K/cc3SML/b8zS/iFsZmACGeRC5mQEQ/x9N1HW4hGbvbo?=
 =?iso-8859-1?Q?5jil3seQh1nbLBjUBqqyQklkwD38sWiqsRSy7bqkJi0XHZZ6J5M80Es3Nh?=
 =?iso-8859-1?Q?buVd08xnILO4N1WpSif9yIK/5ZrmtUZvYADKTQNgwHuOz4siYWvA/tiEe2?=
 =?iso-8859-1?Q?Bz6OHCPn0q+O3hBXuDG5DDh4EuFpo5rk8YPgOcYZbn5Dl0jJQP4FJW8t0W?=
 =?iso-8859-1?Q?QSdwTt7AZkFE5TH8l4KtXThmfnFoeJBUJp9sqzxqy2c3d1L2/92sXutC6R?=
 =?iso-8859-1?Q?4ij36oxp7DygUv6qQFTWhF/vIFLpzXUGMefEZGgzMAX30XWmaECy1/IcuC?=
 =?iso-8859-1?Q?inGi55la+46JI+FvzCMh1Jpl5Fx6tbp8GKD2Iv8O09iAkAb612xMrzM31s?=
 =?iso-8859-1?Q?PcYcWbZ8kRVajtw4+rNx4DoiiEux4JJUD8U+6wsaWYvXuLCrA4MGQr/KFQ?=
 =?iso-8859-1?Q?uOqLXZfH/Wv4Sy036NfxA/3191xAKEuYDl5XKSyJ+fow6VBT+feIXD3rhA?=
 =?iso-8859-1?Q?I30ijoWhAG5m21qgVk03Of7nvgn/hGLHxLbe7y+Pfaw96g?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	L8Apni6CNswWX+0lLXZHidSA2Qr3RgM517w5QnaZU1Ce3wnEGj9CQFPOt+pJU7oyeni3+AjEWbQvX6YcTN/sAs2KhJagmmWRivfln4tN4JWLzKatiTB7KOxtk+4HZvyJKmqRxQgbhWzajc5jE8BUMDXmZK1JajMObxn4A617qgKXH1LsgD2PdiMFyxCZznK+h9BNUJFecnhoKXKHvk12SSJxLJqhDXDOo2bsKB81cjVd8IFYqfb4ncy7zUQUrp3kjdB+Dy3OLU+THw6pq6TK87QaQIfMeOIonMfI3kXDRWW9wr63gTtbywSHf8UonUvfGl91WSKsxmskvv1UAxlJoQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f946ae3-b7d7-4a7e-028c-08df297a7559
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:36:44.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ra0FC0d5D7LpUJsomT44Qy7H/6CcRerqMOtC8PPSyvpmCoc+e26+YwMcyeZhSg7GEL1wsL3NvBQ4HZqgQNM0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB596672
X-MDID: 1791931009-YnlFida-TngZ
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931009;YnlFida-TngZ;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Tue, 13 Oct 2026, Ivan Vecera wrote:=0A=
=0A=
> > +static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 s=
lot,=0A=
> > +                                    bool mute)=0A=
> > +{=0A=
> > +       struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];=0A=
> > +       u8 mask[SIT9531X_HIZ_PAIRS], state[SIT9531X_HIZ_PAIRS];=0A=
> > +       int i, rc, undo_rc;=0A=
>=0A=
> Reverse X-mas here, please.=0A=
>=0A=
> With both of them...=0A=
>=0A=
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>=0A=
=0A=
Reordered here, and the same ordering applied across the driver=0A=
wherever the swap was free. The blocks whose order carries a dependency=0A=
are unchanged.=0A=
=0A=
Your Reviewed-by is on this patch in v13.=0A=
=0A=
Thanks,=0A=
Ali=0A=
