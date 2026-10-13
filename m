Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77856853B;
	Tue, 13 Oct 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931316; cv=fail; b=CZN4u9e/1jPDt5wJk4VYzGDTxMdn/GZRpUJect+c3xmnB54ftn6fcuQnRc2uJj7CjArIN0UGVfGHZ/2/pRRHE8p7UPeRTS10Duf7mY1LkyV1h+zY5O4GthoMxwASGUlRrjs4V6Fw9QI5VsvPVSDJcAskkf+bjBJeYdebiKdoBYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931316; c=relaxed/simple;
	bh=M8boE4hLHA0cKpU0EZLsOF54CZYDHYhfqfQS+Zg8B9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LHvZSnGOgQLb625AtgWZmg4F6rTqFR+1h3Lk7q2ec/GVVs27h4JvLt8KaLNhyN0liHxkK/+BvW87eYDze2CqZWu7xBYB/Is0vFDRB4HxcL6cO7yYtj+ZlTIHojamGDgQe9aYpqSApN0avElY27V8sBlKsyjg2dsdT3pjWHWx1co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=dLTzb4L8; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=PXSBG7JZ; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="dLTzb4L8";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="PXSBG7JZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=68+a0ka02WQrUQirRPQnzIiOZGd5LM7HBItwF0eWBPg=;
 b=dLTzb4L8G+pziFHrW9fwYRpVXGexIR7MnDF0+ZULJkcsYRunQhznz1Juaezn6XOX/hWP3nOA3K0LzIyrNR7bLTpvtyQ9KWiuap62EdMRkQbzlHmjbvM7BvXQLq+lshKLJZ14sd18sEekXjg1HB85XIzmt2lMxekX42nSrRavqk6tuZ+GdJxWYo+mdrpgoOmYn7KvYLGxnUYSNFBb0emxB+jvwFyo2juMmyeywkUrM76WT0xl1BYaPMYPznpnrMfrurwsvAbM8AC5uyJSun5yoZWCI8IkrNuUMkQyAjw/4glxLy/NOsW2C/cv4uckAeXKoRKmmDoBpgZEhtT8kxVxfw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020125.outbound.protection.outlook.com [52.101.61.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 96B3E80064;
	Tue, 13 Oct 2026 22:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlJpu/fUBeTCbCRIf6i67jn6hoiPnCeZutYrzHPrr3T8KVKJv9/cj5zft6cXyDt51SIyzPp9FuU3imdKEgpNGy4m/Iv85eirj8awSgQGgFb3Jle+dFgn/b4qrmhRIbkR1g0NWSmRM8PIOEDdQLx3BSK0R0RIrg9Al7tC04NJc4oetpyBROroUNNNi4HnBWHXV76QTUjWqnsOxsa7rP4W7gaXkeU0VCrfLHwyvZvGf7zSgT5P1Z2exURfg5P0KkgK5qOAyIQuWFld9ScERgW9V6XgtQW0/RUs6jDJtASWXg9qdGb3K6lnsK4pca/1CtGj3DGZcuQIyVt962HPBufaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68+a0ka02WQrUQirRPQnzIiOZGd5LM7HBItwF0eWBPg=;
 b=wO5PqAvdn5DhjTGMQW+hAme+buJXCX5y3xGXdKvhgkgSzEhvxjoeOcsujAawLQu+gsFoeyF+OCf2qMdO60OEYz0XlwTLib/SntiNHoL0yuB5QxmIsuAXO8Tfk9/jywsaPmQoRxe3KZu5LvSfOxq7hfNqQ/S9toGjN66ROUwse+K6QcSE2SnUEea9Woh2ggnEtaQw+JfGvQxLBuahawg00ioMkRwnkXNTnwiJArcLa4zwC3tDOGt7F75cDbJXMQMSCuDJ3UQL3NtxKekH5TNid2gb2akwFuZRR/waKv8G5gNAe2yLI38RLR2I+rLjnax6osJ7wFrfpPbTl0pkBLKccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68+a0ka02WQrUQirRPQnzIiOZGd5LM7HBItwF0eWBPg=;
 b=PXSBG7JZxVL96I0D2yOtZ/P+EaluXt6pW7L+oICjtVhA729qyR+iy3Olr+MpLn9/nZ0a1K2ve8WSJA1Q/3/xbE68Fwpz8BMO561ya4w5Ch9mKH5ILthQutWaDIS6lkMAzD9FAjRyXvz2ctnbtWHcOdo4EBJEla53uRBKHCUPyZYOrbQ8AAUkfGjFc8CK9RtZevFNDmgVHhVbzTdwi3JkNsWqVZ69d6c+TZVgmMYP/CpZVGKUH8j0IyoMo0dsUhBof4Z1BMmPIY2I0EqhlUdr6Tr6Uq2CJllMXrTLrpT2ZP6fqfcHTHnWRPGNCROcdKOVuZ2DTq/h6Sq05T8okyVGZQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA0PR20MB6676.namprd20.prod.outlook.com
 (2603:10b6:208:480::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:39 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:39 +0000
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
Subject: [PATCH net-next v13 11/12] dpll: sit9531x: add support to get phase
 offset on the connected input pin
Thread-Topic: [PATCH net-next v13 11/12] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdW2QC4VqfSGMm80G+n3u4J2XHSQ==
Date: Tue, 13 Oct 2026 22:41:38 +0000
Message-ID: <20261013224131.27149-12-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|IA0PR20MB6676:EE_
x-ms-office365-filtering-correlation-id: b9a3859e-6969-4305-4f55-08df297b251a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|5023799004|261009223027099003|260925021911599003|10067099003|260925021311599003|260925022911599003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 s+Gy4wF0WFkZplTQsW6OcZNDRcMIm51itRpK/vjlRo+lMGVtmwSViQz0Sy3XmuICNlCWCTF/XHxVxz7zA4S9SRUrpasAgQENlabuWxc1H5Ows4KmzUyGIb72VZAnnn4hh1jqXNog4UDvqCABvUZEbCSYTdISp9ttQhTIJfVD/+vwBzjfZa5CLDbUhXdmCVCmQVVzgx2eEB3SKlr+iQLC1VsDIkKrdc1l0+OwQ+DA7KkJHTLXx4knmXMbhrfSpzbb6GruaNdt0tewUyHvkzXrhoXDPzSBnc50RHjTqmHlCUy3Ew8Kk6YGe0QjyNiXZkJrLS4VU9LSVXdogNdLUnuq/5v+Z/UkhSDYnY8hWE+RG1gQN/uOIrh4HsaPAqAAdqhqwKjxJqDCkQR0DKD6Q1/ED7O9r/TLDz7MleI1Sb+EP8XZJQB2vJoRLBjMEMp+gHkemO0NPpAn4iNdCpWChxFEfF8EiPwIJv6B2iAFBzVWvP+CrQ8U2mtF52Unh5PEawctI9q4UOtEHDQoGw8aA5FqVFN68mYnNqGOPOIL1adgs8ct/2qcIS44qjeLURo+l47c5WEw5ut2BBjKpfYil19yncfAD4L0jvZD/pZ0WkJuAWNp0f/hXEkVh9XZBdeF1F5eYHF6tJxBBofwB95yakjtC7DLwzRhCjtH/mrK/F8zY420Hp+nz9PWIQU/Q2P93Q2Te7nRhg02KrhEgYyGbzYrvWhPDKsL0IOUibEAOqMK0n8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(5023799004)(261009223027099003)(260925021911599003)(10067099003)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PHETsUsedsNI9jjbDAyj2lxQxnoQsWw78XFH5IuRyoJvGN56TIsEJ6B704?=
 =?iso-8859-1?Q?32MhhMm0ZiM1Bh1ZYBQnmIQpQSwBOkVizfddgAiBw4zcHgJTaBlrmXh0t2?=
 =?iso-8859-1?Q?8DEauvMwGpyosHusdSuF4HWIBALd/Ox4zFzPofjRHju6yRPD4sZolBKlTR?=
 =?iso-8859-1?Q?ixEN94wVmh20A4R3YVR1C8/4+fF6UMCMA4E70Zst8MqJKNp0mMHrPsxNZB?=
 =?iso-8859-1?Q?nSQ7jBfOxcyi5JYNQICl9ElDtL/Kcn5ZMiBuvdPEW+aOQvJmwesvPH8Ko7?=
 =?iso-8859-1?Q?s6hmQXEa97fRJ6gCzj4eCojgO7NtYWQ12byR1bfju8LI26CUKkyZ7A1qSO?=
 =?iso-8859-1?Q?qRPT225Xb+uBTLPCbZ8Bu0gm1XYgBTcRfSm9evz2VEIqTvE9Q3gZorLDjC?=
 =?iso-8859-1?Q?vGtHyevajnLumRngzgnrlRJAf95TMi646Ucq/aYN+WQdpf7JZEOLt/Zamk?=
 =?iso-8859-1?Q?gdGmgxpcesdQE2DDJHjxZESGqwn1ijq5qu37K9f+HHHqi4OJl1RkdboFFV?=
 =?iso-8859-1?Q?R+fxEkPmIilJClrSBnCX2PxIkn2hjCeFYRVulu7MyrIinv1AZZCNxR7xfL?=
 =?iso-8859-1?Q?O09eYvW417MJvc4uXozVdjpFXR7nzGujVB9HDxy4MhYeq5ekUOp6mzHP5L?=
 =?iso-8859-1?Q?ssJUM/I25wk6Z/4NViTys6vz+r8yjkDqZZ7nQsLco3JbyXOb7Bdb4O7ywd?=
 =?iso-8859-1?Q?4k41qvULkxeqWrBypuDE4nvLFMPaiMf/Db/jXox1bklJuhIisa6TKznZIe?=
 =?iso-8859-1?Q?6rcE4mD5tZJDPcDD/3caToQRsEVSFHCAnnN1KNL7xEsC+igoy8QzoNvMU1?=
 =?iso-8859-1?Q?o0Mz/aMZcyz+0Z8aKCt2AUcsGM0Zr91aE9GCeAp/30MJBt+gNtvFdFK/De?=
 =?iso-8859-1?Q?wIk5r++/+IOuDHzlLlEVXc71EttPMMREITobhMRHi053UzbGIOi5SsTxZ3?=
 =?iso-8859-1?Q?ZUJtK8ZkAIXaFRVO/YopaDWma+2VPAK7+2/OcO7xxCGmAAFC8yQk/EETjW?=
 =?iso-8859-1?Q?speFyUJGDA12zI/cSFs4DoNNmrSXdQ28XzzJopPDlPf70vym5/hrxWFoTh?=
 =?iso-8859-1?Q?du8xYMWiAxmkmHZB6NYr7QTKMMUO/9NeSzR2BxIr3no9erorYuiMKXsCSh?=
 =?iso-8859-1?Q?X9SMGF2zF+NjMmIXznRBFXHNDYeaZ5tYHRt7ChoNfnKs31aKIb+5LkROsH?=
 =?iso-8859-1?Q?NSzbFCelvVvpIfu4iTh/XmHBCSFZnTadsqHsfmDrUpOOJ6NfyQ94nfkaSh?=
 =?iso-8859-1?Q?XxqHjITPa1AM/OJtFyzRg7WfGlSzp99y5/kVpVtzXaEdf2LNtMNkNoA4CC?=
 =?iso-8859-1?Q?PsCk850141frKARtBOiLa6Mj8CdHA5l/KtJ02k06NNNT9uplon6Xm/rN8Z?=
 =?iso-8859-1?Q?sDD1Ghf3LmIprezgpyiKb7cuud5TMkm2u3GfTSomB2bMW2dyl9Actp8vxm?=
 =?iso-8859-1?Q?gwk+73oyfhOCQDlGLA6twqzADlNDo/h/2kgOeZ2Nvi6Kf2AdP0H/mwFj9F?=
 =?iso-8859-1?Q?EsZpa5dr9RN9xfZzt7dB2WNvJFrE2pL7qqgxgvCvQsYsI03a1GMecAyj8W?=
 =?iso-8859-1?Q?eK3Qg6iLNcHY6IyoT2RubSc39dohalww3bVIq0zXfJJ6mG43IquEPbEiar?=
 =?iso-8859-1?Q?6bp2eBe21YzKUY7yiv1wX0o98oa3/4ABWx+ZOnPEdm03Ia5g74T0S37Q4y?=
 =?iso-8859-1?Q?L+j5az0DecU6kBk2aYEC+twN4TAI0locm8L9EcQpGYYj1J5OaFToFvQG0A?=
 =?iso-8859-1?Q?NUTnJZ8CXGdCrBlsWvqsUM9KEMBlfwFPlP39xcmMmZ4tVc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MK9+rGg7Vs9ClXxCUjgj5Z5tlttrUoi5+Gc3cer1fnoYIn867teGD0kd4DDaNyq1ddj0xlhfukxPLO6coOuHUpHn6C6tcrGEq4A9MjfolR4b5TnPMnWASTDidX0iu9nQAhWcjOVCEWBvwBwaDKEN3+rBBCfyKrZ3+vb2j7l9cz6CeHCW+6vRHf9fqc2GcLOERmXnR7TrSLlvSFkyZ56CTHY5RdbDEKF2xMKG60FcsRVm3a205tAYlhk1x9XvfgZxq61wGmCvMW1D8kJbI5ng6Xqj4hqzG0pq+KkQN3cUdgy3veKOzD8RHUGec6ZCjh4v5EJxhYeWWr2A4SijlUnmuA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a3859e-6969-4305-4f55-08df297b251a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:38.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJ/7lcHsTkdVt3yhHYLh8bB49JWIS8mLNNRL+jdr1lISS6ltzh6/zIGwSurvVMFprCnagYuIZ/esR4N+IstVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6676
X-MDID: 1791931302-oDdG54bEx9bQ
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931302;oDdG54bEx9bQ;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
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
would look perfectly steady while saying nothing.  The offset keeps the=0A=
fraction of a picosecond the converter resolves.=0A=
=0A=
Only the input the device feeds a PLL has a phase offset against it.=0A=
For any other pin there is nothing to measure and zero is reported,=0A=
because the core abandons an entire pin dump on an error from any one pin.=
=0A=
That pin reads zero too when no sample was taken: the PLL is not=0A=
tracking, drives no un-muted output, has no usable VCO rate, or the=0A=
device moved it off the pin, or the lane lost its signal, between the=0A=
check and the sample.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Reviewed-by: Ivan Vecera <ivecera@redhat.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 222 +++++++++++++++++++++++++++++++++--=0A=
 drivers/dpll/sit9531x/core.h |   5 +=0A=
 drivers/dpll/sit9531x/dpll.c | 147 +++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  22 ++++=0A=
 4 files changed, 387 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index e15070ea2ae6..a744de2c7585 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -922,8 +922,9 @@ static int sit9531x_prio_prg_commit(struct sit9531x_dev=
 *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
+/**=0A=
  * sit9531x_input_mon_fetch - read the clock monitor status of every lane=
=0A=
+ * @sitdev:	device pointer=0A=
  *=0A=
  * Four registers carry a nibble per lane.  Loss of signal and frequency=
=0A=
  * drift are what separate an input the device could lock to from one it=
=0A=
@@ -931,8 +932,10 @@ static int sit9531x_prio_prg_commit(struct sit9531x_de=
v *sitdev)=0A=
  * selection and the pins report as their operational state.=0A=
  *=0A=
  * Caller must hold sitdev->multiop_lock, or run before registration.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
  */=0A=
-static int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
+int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	static const unsigned int regs[] =3D {=0A=
 		SIT9531X_CLKMON_P_STATUS_01, SIT9531X_CLKMON_P_STATUS_23,=0A=
@@ -3039,6 +3042,202 @@ static int sit9531x_clear_notifications(struct sit9=
531x_dev *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @phase_offset:	phase difference in units of 1/DPLL_PHASE_OFFSET_DIVIDER=
=0A=
+ *		of a picosecond, as the DPLL subsystem carries it=0A=
+ *=0A=
+ * Reads the Time-to-Digital Converter (TDC) code from the PLL page=0A=
+ * registers -- a 35-bit magnitude with a separate sign bit -- then=0A=
+ * converts it using the VCO frequency: phase_diff =3D tdc_code / fvco.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA when the PLL has no known VCO rate=0A=
+ * (nothing is sampled then), or the register access error=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_offset)=0A=
+{=0A=
+	u8 v, old_write_code, old_read_code;=0A=
+	bool have_old =3D false;=0A=
+	int rc, ret, i;=0A=
+	s64 tdc_signed;=0A=
+	u64 fvco, mag;=0A=
+	u64 tdc_raw;=0A=
+	bool sign;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Get the VCO rate first.  -ENODATA means the PLL has no rate to=0A=
+	 * convert against (a divider this board leaves unprogrammed), and=0A=
+	 * there is then no reason to open the debug window at all -- which=0A=
+	 * also keeps a bus error while it is open from ever being reported=0A=
+	 * as that benign case.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc) {=0A=
+		if (rc =3D=3D -ENODATA)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"PLL%c: Fvco unknown, skip TDC\n",=0A=
+				'A' + pll_idx);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	/* Unlock the debug page so the TDC registers are accessible. */=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Remember the tap selection so it can be put back.  The key=0A=
+	 * register is re-locked below, but the mux is not part of the key:=0A=
+	 * leaving it parked on the TDC with a slow sampling clock selected=0A=
+	 * is a state change the caller did not ask for, and the next reader=0A=
+	 * of a different tap would have to know to undo it.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				  &old_write_code);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+					  &old_read_code);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	have_old =3D true;=0A=
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
+		goto relock;=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				   SIT9531X_DBG_READ_CODE_TDC);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * Latch a sample by reading the debug status data register.  A=0A=
+	 * single read returns the previous latch, so read it three times=0A=
+	 * as the documented phase-difference procedure does.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_STATUS_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_STATUS_DATA,=0A=
+					  &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	tdc_raw =3D 0;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_4, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));=0A=
+	tdc_raw =3D (u64)(v & SIT9531X_TDC_MAG_HI_MASK) << 32;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_3, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 24;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_2, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 16;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_1, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 8;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_0, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D v;=0A=
+=0A=
+	/*=0A=
+	 * Apply sign.  Per the register map the sign bit is active-high=0A=
+	 * for a positive offset: bit set -> +code, bit clear -> -code.=0A=
+	 */=0A=
+	tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;=0A=
+=0A=
+	/*=0A=
+	 * phase_diff (seconds) =3D tdc_code / fvco=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco=0A=
+	 *=0A=
+	 * Scaled by the subsystem's divider before the division rather than=0A=
+	 * after it: one TDC code is 1e12 / fvco ps, a fraction of a=0A=
+	 * picosecond more often than not (203.45 ps at 4.9152 GHz), and=0A=
+	 * truncating to whole picoseconds first would leave the three=0A=
+	 * fractional digits the attribute carries always zero.  The=0A=
+	 * quotient fits u64 for any rate sit9531x_get_fvco() returns: it=0A=
+	 * refuses one below the VCO band.=0A=
+	 *=0A=
+	 * mul_u64_u64_div_u64() keeps the exact Hz denominator; dividing=0A=
+	 * by whole MHz instead would lose up to ~40 ppm of scale on a=0A=
+	 * fractional-DIVN Fvco.=0A=
+	 */=0A=
+	mag =3D mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,=0A=
+				  1000000000000ULL * DPLL_PHASE_OFFSET_DIVIDER,=0A=
+				  fvco);=0A=
+	*phase_offset =3D tdc_signed < 0 ? -(s64)mag : (s64)mag;=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+relock:=0A=
+	if (have_old) {=0A=
+		ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					    SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+					    old_read_code);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+		ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+					    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+					    old_write_code);=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Close the debug window again.  The key register opens every debug=0A=
+	 * register on this PLL while it holds the unlock value, and this read=0A=
+	 * runs on every pin-get of a connected input, so leaving it open=0A=
+	 * would mean normal monitoring permanently unlocks the block.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DEBUG,=0A=
+				    SIT9531X_PLL_DEBUG_LOCK);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
@@ -3137,8 +3336,13 @@ static int sit9531x_pll_is_active(struct sit9531x_de=
v *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Read the reference the device feeds a PLL.=0A=
+/**=0A=
+ * sit9531x_chan_routed_ref_read - read the reference the device feeds a P=
LL=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @ref:	result: logical input index, SIT9531X_INTSYNC_PIN_ID for the=0A=
+ *		inter-PLL sync net, or SIT9531X_REF_INVALID when the code=0A=
+ *		names no registered input=0A=
  *=0A=
  * The active selection names the source the PLL was told to follow.  The=
=0A=
  * input subsystem feeds the PLL that source while it has signal and falls=
=0A=
@@ -3153,12 +3357,12 @@ static int sit9531x_pll_is_active(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
  * free-run the PLL is fed nothing and the bus is not consulted, so the=0A=
  * caller checks the mode first.=0A=
  *=0A=
- * @ref is the logical input index, SIT9531X_INTSYNC_PIN_ID for the=0A=
- * inter-PLL sync net, or SIT9531X_REF_INVALID when the code names no=0A=
- * registered input.  Caller must hold sitdev->multiop_lock.=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
  */=0A=
-static int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev,=0A=
-					 u8 pll_idx, u8 *ref)=0A=
+int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  u8 *ref)=0A=
 {=0A=
 	int rc, lock_rc;=0A=
 	u8 v, i;=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 0c42bfc05b0b..b440e2d6011d 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -300,6 +300,11 @@ int sit9531x_output_phase_adjust_set(struct sit9531x_d=
ev *sitdev,=0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
+int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  u8 *ref);=0A=
+int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev);=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_offset);=0A=
 =0A=
 /* ---- State helpers ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index b3719370901e..dc8d84133b72 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -669,6 +669,151 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pi=
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
+ * documentation describes the reported value as one that may be averaged=
=0A=
+ * over prior measurements, which suits a closed-loop residual and not a=
=0A=
+ * one-shot open-loop capture; the core publishes whatever this callback=
=0A=
+ * returns, so the averaging, if any, would be this driver's to do.=0A=
+ *=0A=
+ * The chip can also measure the reference against the local oscillator=0A=
+ * with the outer loop's correction frozen, which is a different quantity=
=0A=
+ * and the one the documented phase-difference procedure produces.  That=
=0A=
+ * needs the digital loop filter held (and, on the 1PPS PLL, the automatic=
=0A=
+ * phase- and frequency-lock helpers held off), which leaves the PLL=0A=
+ * undisciplined until it is released.  A netlink read must not do that,=
=0A=
+ * so that measurement is not offered here at all; it belongs to a caller=
=0A=
+ * that can own the freeze and restore it.=0A=
+ *=0A=
+ * Precondition, which this callback cannot create: the TDC compares=0A=
+ * against a signal the PLL drives, so a PLL driving no output with its=0A=
+ * zero-delay buffer off has nothing to measure.  SiTime clock=0A=
+ * engineering confirms this is a property of the hardware, not of=0A=
+ * SiTime's TDC measurement procedure, which satisfies it by mapping a=0A=
+ * spare output and restarting the PLL -- side effects that do not belong=
=0A=
+ * in a getter, so a reading taken in that state is simply not meaningful.=
=0A=
+ *=0A=
+ * Non-selected pins and a PLL with no programmed divider report zero=0A=
+ * rather than an error: the DPLL core propagates any error from this=0A=
+ * callback and fails the whole pin dump with it.  The core has no per-pin=
=0A=
+ * "no data" for phase offset, as it has -ENODATA for the fractional=0A=
+ * frequency offset, so it is a value or no callback at all.=0A=
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
+	bool drives =3D false;=0A=
+	u8 routed, i;=0A=
+	s64 offset;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * The on-chip TDC is a per-PLL resource that always measures the=0A=
+	 * phase difference between the VCO and the PLL's currently=0A=
+	 * selected reference; it cannot be pointed at an arbitrary input,=0A=
+	 * so an input that is not the active reference reports 0 rather=0A=
+	 * than the active reference's value.=0A=
+	 *=0A=
+	 * The sample needs both: the PLL tracking this pin as the poll last=0A=
+	 * saw it (locked, outer loop running, not frozen), and the device=0A=
+	 * still feeding it this pin, read now -- the device moves on its=0A=
+	 * own, and a cache up to a poll period old could attribute a live=0A=
+	 * measurement to the pin the PLL used to be fed.  The device is read=0A=
+	 * again after the sample for the same reason: it can switch during=0A=
+	 * the dozen transfers the sample takes.=0A=
+	 *=0A=
+	 * The TDC also compares against a signal the PLL drives, so a PLL=0A=
+	 * with no routed, driving output has nothing to measure and reports=0A=
+	 * 0 like any other pin without a reading.  Output state is never=0A=
+	 * polled, so a mute or unmute whose read-back failed is read=0A=
+	 * through here first, as the output's own getter does, rather than=0A=
+	 * taken from a cache that was left describing the state before it.=0A=
+	 */=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		if (!sitdev->out[i].routed ||=0A=
+		    sitdev->out[i].pll_idx !=3D sitdpll->id)=0A=
+			continue;=0A=
+		if (sitdev->out[i].state_stale) {=0A=
+			rc =3D sit9531x_output_state_refresh(sitdev, i);=0A=
+			if (rc) {=0A=
+				mutex_unlock(&sitdev->multiop_lock);=0A=
+				NL_SET_ERR_MSG(extack,=0A=
+					       "Output mute state could not be read back");=0A=
+				return rc;=0A=
+			}=0A=
+		}=0A=
+		if (sitdev->out[i].enabled)=0A=
+			drives =3D true;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The lane's signal is read live as well: a loss since the last poll=0A=
+	 * makes the device fall back on its own, and a sample taken then=0A=
+	 * would be credited to a pin the PLL is no longer on.=0A=
+	 */=0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Failed to read the input clock monitors");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (!drives ||=0A=
+	    !sit9531x_dpll_selection_active(sitdev, sitdpll, dpin->id)) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_chan_routed_ref_read(sitdev, sitdpll->id, &routed);=0A=
+	if (!rc && routed =3D=3D dpin->id) {=0A=
+		rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_chan_routed_ref_read(sitdev, sitdpll->id,=0A=
+							   &routed);=0A=
+		if (!rc && routed !=3D dpin->id)=0A=
+			rc =3D -ENODATA;=0A=
+	} else if (!rc) {=0A=
+		rc =3D -ENODATA;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * -ENODATA means no reading: the PLL has no known VCO rate, or the=0A=
+	 * device moved the PLL off this pin around the sample.  Report 0 so a=0A=
+	 * full pin-get dump does not fail over it.  Every other errno,=0A=
+	 * -ENODEV from a vanished adapter included, is a failure.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENODATA) {=0A=
+		*phase_offset =3D 0;=0A=
+		return 0;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	*phase_offset =3D offset;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
@@ -677,6 +822,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -693,6 +839,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_norate_ops =3D {=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 7c41111dca20..1891679698e2 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -284,6 +284,28 @@=0A=
 #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
 #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
 =0A=
+/*=0A=
+ * Signal pathway debug readback -- PLL page.  Dig_Sys_ReadCode selects=0A=
+ * which point of the pathway is tapped, Dig_Sys_WriteCode carries the=0A=
+ * modifiers for that read, Dig_Sys_read7..read0 hold the sampled bytes=0A=
+ * and a read of the debug status data register latches a sample.  The=0A=
+ * TDC phase measurement is one tap among several, reached through read=0A=
+ * code 69.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3=0A=
+#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4=0A=
+#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [34:32] + sign */=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+#define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
+=0A=
 /* DIVN is carried as fixed point, in steps of 1e-12 of a whole divider */=
=0A=
 #define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
