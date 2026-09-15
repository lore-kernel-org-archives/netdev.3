Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2330216D;
	Tue, 15 Sep 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430437; cv=fail; b=JPtzBjsJXJF7KrQn9k0OuFtuc9SNeJKiHqYXmNNZs9Hm6xewiMRJDV7c8ALGRm/At9RnRz85ipe3wWFa4OFKhvmqpX8uFDjbeVH1HA0RWNLgH53OUumYAEWxJaCHA0WC3rMmcXKfoIlj3dO6Yyg8Es983ap2OTbf2MZnrwWXPs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430437; c=relaxed/simple;
	bh=BITyUUmsbNXipSOTHR0dpp/QOCaW60QJggPAJ3HEZew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SGvQ1PMZ1GRvnUdLVBCdM9/S7eufqMA4pZn0u/l/K/RY3zaEdUTTneQ8/tCoR+vqI/XrDYvmgKS7Yd4V2uLfI2b3ZYXzrNZs076grAA7nARGVTX2Xf8x81oYsKEC7iGBI2JHdh1TxQ71qGdfdjk/YPTMaoPwALTiwuZOCg3g25k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=GGkWHAtR; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=yHig4cDm; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="GGkWHAtR";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="yHig4cDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=WthKmcKIlvBIcM5HLv6kwiv4mOLO4xF2tJH9dJOBvQ0=;
 b=GGkWHAtRvAivH2BnzinmJOzP0U5Eu8a3icgbgCtE/A6NmiA8ipwqA63xziTVAuSVgKOuo1NZcpileiRb3iyikc9bu88KcCM/NBlXigi7WbuvKgMVO3d2eiqoBttiHWRBhvJkY7D9skr/yNUNiFRjlojF6q48EfdHqXNwppuAcyAK5RPDX7WBE0HCqUCDt/pta9VZf+ADXYJNdREIC7wqqcQBAxA8NPZYOBR3U1i2eG0tT52oD+dLJG8vksuDsUwN0R5bBvE5zpp5mDsUB9Jser8QcpxPmPEMryHEgRs3Si+LhAqgFsDgLQjWEUkyotsWRVBFxsHKJi6psCBBIJVBkQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 252871C006F;
	Tue, 15 Sep 2026 00:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+2qw6iq9UtXuPSRFXpHmPiCpVzrgUIJKZY7f3h/x6fb11nAC/fvAogTF4VtSdKAnvS8UpZKyOcedLD/8Hph+GyIiEdGflC9x8uyeoq2jb9XdM/7bttiBReMVbRpmNo7Ff3khQCJMrSCMoPm/kwvz4SYWQrAvYa3Q7+LYJ2BVIJUt/JC8awIdGRpy4eJpUd26iLWuDR0KgEVvU+k6SeeTLLzjlY70dtLJWnuUkf7axjgeHCEfgBBEvdoZnst8BKj8XVrib5nTmkxFwNyuKomTY65OcBDmEzv1VdjDMHIzo403sWj6sn6Th+eJag+rvFP4p7P1IRo2SzriiFeZ+8qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WthKmcKIlvBIcM5HLv6kwiv4mOLO4xF2tJH9dJOBvQ0=;
 b=Jvk6JexiUqbsPmLeDwA9UNipPLjGhQvKLvBvufC+LwH2XEPKGSg0+wBljBZq+GEylvsFh4YPyupMUPhVL6IISs3UZBb86Di1rmwnZfZG+ztUuRUlSqx8Xk1BIT3TrvTbKCRpi5CUMOZa5zr3ywL1rYXBMDwGc4DMYt2O6xIN4VxIo/4dJkcrAtSi9FeUHqvuZoeZwH4WNu42XU3bjbRC8gU5lypQk7PEcJZT0nDRX54LPFW3UZmhMhJ0ZNfGzbV8tbMhf0030lkecxtPfp5xjkcP3TdzrDTmzsntjdPaoOSmuPY8sfKdBS2Ux1KA4uR+CakoWRDYpmX9XChoMFOzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WthKmcKIlvBIcM5HLv6kwiv4mOLO4xF2tJH9dJOBvQ0=;
 b=yHig4cDmkwFIXb+9ghNKVGTJn0Q6/lVCIaUrQBkyXlHPw1ByNb6v+I+eFsir1nxvktUTuxmeTo2U09TvjthsnExDgcZTAIARFFZDPb/d+qXTNQ4v25NHh2bGk+2DBIcpSFiMPZj+lf8l5Fr4EIGknZVeBY4o+fW5WmacIYZWuNCosvjF/t+6c9SbWBjK7nnpj75rz+nhE/JqkASWTShMQU406d4Gsomh4egJRFxye2ARHhsKVurpMpE+eIqoGb4DvNW2zh1AtJWYwTRWZSYN+JS7TaTLUkWMOKZGIOgmcejy2faw/Cb5WfBdBZebjTbv40PmwXXwQ9r/elpRwsCyjQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:25 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:25 +0000
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
Subject: [PATCH net-next v9 08/15] dpll: sit9531x: add support to get and set
 frequency on pins
Thread-Topic: [PATCH net-next v9 08/15] dpll: sit9531x: add support to get and
 set frequency on pins
Thread-Index: AQHdRKUypBlEhMAeckWiWEJQQ1qaTw==
Date: Tue, 15 Sep 2026 00:00:20 +0000
Message-ID: <20260915000015.80480-9-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 59cbac08-ef9d-499a-1af2-08df12bc5833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 b+GcZAfwAjYBcM4XicqTY79ujkN4f3iQ7fiRTB/Pl0V4OPxpqCNME6zsb4jgQ1bYhGWVR0t6x5uD99bMHyh1y8Dx7MenIWUNDkZ70CGUo6T6mqciBOtZV2aM1BjA/rZXS2q7bVLD7xiKIk6imGaJim+br75DkeyG/dVePxgr+adNs0n308CnzrAvRmW7BZO1K2R2qO69ZgG95RbhmaS/sscJSPg+hqEYRAwLMc79dGW9l2lWFqXf6LWtk6ROcro4+MkP4WeC8g2kkakSCUYnAn3WOthiNjfopWarPkWiuKOKMzmvsHVw8oP8uWn3O/X+b3m6duEo/J97mthuRy+pTQh2JOTKCl9Q/piqn6XF0Ij04yu88Ih3j/RJmqcYJe2GmnbWkE5YTPQc1BdsDQo0coxkohIT0qOCNTF8tH2nrL91AjMGxVN03wxgarGIR+6VluT7ryXRBOd3pPvz0tFJKtLkYDDMf1f9ktRNkuKB4swJZwbHvd5fx+2Jx7hZc3b2nAl/CDqLk5iHWffNY5ZpsK7Xri/mXfiAMsIa3Xd197k/sUk4Ow4a3FxrgJXlFvcuruIDwQYqj2x93cx16FjN2PD0ce32l3uI+6ecp/FKdQUdgKJ/2+Rg7uhswd4oC2rJrZ4L/WQUq4NreoB9D15S/OCtIPswV5O8C/EmiL+q+hlXHIQw2Z7hEdysu/Om4pwPceU3/oYZEp0wlPF9YYX+kmBje3MYzx5qju/xVy3AfvI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?a4jBIZFd9sN1Jo6Y9U/x+AzYzDbEpfaV64h3pCXQ6TAMcKD3Cz6kIx6jZ1?=
 =?iso-8859-1?Q?REvWNP+ePTWCHhDTiuvsZh40vZQ6WB08NAwvMcn9ai9Dt/wb18x97AdfVJ?=
 =?iso-8859-1?Q?V2MIVgJ2A/XnaIsEO9qYIiGtmjaoQYa2l5iIZv6pFBgBx1eroiv49Dma0D?=
 =?iso-8859-1?Q?j8DDrrXPQ6ZfEcXdLGnsJZ1EUKk3ZX2q+eeUhDxAIZR+AVnk5GM4tLku3i?=
 =?iso-8859-1?Q?v3zOuiUDgk6Rkgr6DymbwP3DHoe8s+erdaGXhibrRedRNysPx+F9epK26/?=
 =?iso-8859-1?Q?7L7WamRMaKq0LAj+8fkRM8BZDxtkpVEX5EHmQ2NBK8ldVWgWYqOPfvRMgD?=
 =?iso-8859-1?Q?HXy0JXcA6TnswKo0A1JSx7/pySii9rrl+YDJUNF3JM49jVWTvHzEHFcgQD?=
 =?iso-8859-1?Q?WQbG/LsUMopW82oL4NzU0aAIfu1bbckw4PYWiqYdceCgbgHWktxja3uZLA?=
 =?iso-8859-1?Q?7ohT0/z6SSBpYW2LHU7La+jidaaCSaEI0uHsVnEtAKvN/EKrONSJoeQhlp?=
 =?iso-8859-1?Q?I4MoiDV1dBN5G5pfum8lFUmkC2bj0skbfZJQNeigH5/EFvhzjTge7uWldO?=
 =?iso-8859-1?Q?RMaR0YzuoJ09BTzoqDrUJH9rpR2FncANGTPNFT5TZc9RNRpME1MjcYmuk2?=
 =?iso-8859-1?Q?+SmKOa7hUUBOH0JMnmkZl57KM97hqH1G6U1oiNjENRSyIyrZdH9duMwwnx?=
 =?iso-8859-1?Q?L0B4G0zN5kUetGwi37h5nXXyNoL0dph+vubBFgGT9/hS+N2PZSo3svHHWk?=
 =?iso-8859-1?Q?VBCB6JppAHbic5u2wFjhPhiQ+vZlFqPy6r5mfAIPBQ4YczMUyQ2e335A9x?=
 =?iso-8859-1?Q?y6jjxf5KBi/ghP9NRI9VbdLw4/D4R8wV/+R9eZJ0icPnKGX1o0VHOcQs7u?=
 =?iso-8859-1?Q?OpSomLNn1zVVOVK1Pm08JlzYNXOT3g7ThiRxUNLTj7+zoYxa6kIAe7RpxL?=
 =?iso-8859-1?Q?zjaJ8e5zo31t9x0LtW2s4OEuIbIgNNRi3uT5uBLKK073VMEJ92m3MkIA2r?=
 =?iso-8859-1?Q?1g1l1j1kZDDQqqZYnQ9KTIf4jnFBQyyK6ssaZVNYle2qCxyjxdJ0RiixBF?=
 =?iso-8859-1?Q?9Cn7YCyiYCCbqESnJIn6CisvK1w4Dotkb5661GcX22ZAJyx90kK0/7WlhC?=
 =?iso-8859-1?Q?1nw7xHFX0cnEn3xKnCAGteoqt4Q4n6RsL+ujVAYGglnC8EYxL0qGV/CRIw?=
 =?iso-8859-1?Q?gyUAcqk5WcrrzQBFcYABr58Zb+ByYpoxzY/3CASGV+Qe+4OWfTwd6qcdPC?=
 =?iso-8859-1?Q?K41tQlfgbf+gT+nBMpv/8HpmFc54XW19n0WopIwpw7quwkWWD0Fd60lOvT?=
 =?iso-8859-1?Q?AOXLZQy562KWvS6oyeaMungb7OWKMzofRLVGxFbxodZqXyn74cz4tBp2yA?=
 =?iso-8859-1?Q?akX5BSg7FmgoprHGqTv9iuk/36lstPgeQzuV7Cw1jSpakz9z534AJcFHa6?=
 =?iso-8859-1?Q?N+u7+t+DKaJ4VG2IFh2xkj6PnosZ+/ACEEF8PUd5Y4x5pGHR/L8/Hbt1qY?=
 =?iso-8859-1?Q?q5hJMseQPgsbTKO/YFS+weQd9GQJOAxoi7C9IuOfwYYubnPRrWHKoiIb0Q?=
 =?iso-8859-1?Q?+eJ6UCPhLZg5ktCVSXosMenh8MkfFGuIVkb+ctGjqXBlSHgEZi2/u+FZJ5?=
 =?iso-8859-1?Q?/S5pqXLH7zkRb7M+aiI20625wAd4RdmXe5xLeKrsOEmNrnVA9+XyKdmb28?=
 =?iso-8859-1?Q?HlPzbO7dDOOZd4Pz32+Y+C6aeSbGv0JoYY3IpHC16AFO6mpKnFaSVGFS2C?=
 =?iso-8859-1?Q?Un4F5GCNtdXNDlQoWXPvdpHoBPHgGbDFKNb7RW/1M/xwxB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dzYZ4LS7QRiFOqlnRMIYTRccZV9+BRNDcTJaQL5IHFDDgHG6ddL8l5wkPKbIealODcokechH/ufHxiNXeZrI2jj/FsxFz3bxkSpNyP0XdT6+5ehSmxqN24jldLya8vVUXU2n7yDAWvaTsSGKcvLQth1loXIVgy2fI6fEYl9Mh4qh1TPqJCKGTy1/+mevsZyJU0te6Kvy3M+MXYa8Awsv4zTK9uGye/Dd5tSWsRLSYyJ9IlO4RiX/T7e+GNKXZra9NajAopSZxrmsGsIMSZCps6lL1gI1BfrFca/Co/ZvkCsaX0RIfwxLOVAlbf9UG+w1FrMuy0HhVTv3zj+BuiCwww==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cbac08-ef9d-499a-1af2-08df12bc5833
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:20.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDiYjbfRuQrP9Fb+hpYGiF5y4ePSYgbdDY85VdodUDeG1ujcc/SQ24MlspkaEMHSm/vdhWEXWP7qkFw+ZYjQQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430432-OqdWtSeXLP1K
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430432;OqdWtSeXLP1K;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Both directions in one patch, since they share everything that matters.=0A=
=0A=
An input's frequency is what the board presents, so it is reported from=0A=
the firmware description rather than read back: the chip has no divider on=
=0A=
an input whose rate it merely qualifies.=0A=
=0A=
An output's frequency is the VCO divided by that output's divider, so it=0A=
is computed from the divider read back from the chip and set by writing a=
=0A=
new one.  The VCO in turn comes from the feedback divider, which is why=0A=
the crystal rate is needed at probe.  A divider write only takes effect=0A=
inside the programming state, and that state has to be left with the=0A=
output loops re-locked whatever happened in between, so the exit runs even=
=0A=
when a write in the middle failed and the first error is the one returned.=
=0A=
=0A=
Programming a divider costs about a hundred milliseconds under the device=
=0A=
lock: a dozen or so register transactions, then the settling time the part=
=0A=
requires after the loop-lock command, which is a property of the hardware=
=0A=
rather than a conservative guess.  The DPLL core holds its own lock across=
=0A=
the whole callback, so a frequency set on this device delays netlink=0A=
traffic for every DPLL in the system for that long.  Splitting the wait=0A=
out would need the ops to complete asynchronously, which the interface=0A=
does not offer; issuing the commit without waiting would let the next=0A=
request program a part that has not settled.  A rate change is a=0A=
configuration action, not something a running system does per packet, so=0A=
the cost is paid where it is visible rather than hidden behind a=0A=
completion the caller cannot wait for.=0A=
=0A=
The phase flush that follows a divider write realigns every output fed by=
=0A=
that PLL, not only the one that changed.  The flush is a per-PLL function=
=0A=
in the device and there is no per-output equivalent, so an output whose=0A=
rate is set while its siblings are running will step their phase too.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 587 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c |  94 ++++++=0A=
 drivers/dpll/sit9531x/regs.h |  17 +=0A=
 3 files changed, 698 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 484c94def578..a83bf8ac83c1 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -396,6 +396,84 @@ static int sit9531x_output_forced_hiz(struct sit9531x_=
dev *sitdev,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Enter the output-system programming state: unlock the debug=0A=
+ * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
+ * writes that reconfigure the output system only take effect when=0A=
+ * they are made inside this state.=0A=
+ */=0A=
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+				 SIT9531X_PRG_CMD_STATE);=0A=
+}=0A=
+=0A=
+/* Attempts to re-lock the output loops before reporting them open. */=0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
+/*=0A=
+ * Commit a programming sequence started by sit9531x_prg_enter():=0A=
+ * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
+ * hardware its required settling time after the loop-lock command;=0A=
+ * it is intentional despite the caller holding multiop_lock, as the=0A=
+ * whole NVM + lock sequence must be atomic.=0A=
+ */=0A=
+static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc, rc2 =3D 0, rc3;=0A=
+	u8 attempt;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_UPDATE_NVM);=0A=
+=0A=
+	/*=0A=
+	 * Issue the loop lock even if the update failed.  Callers reach=0A=
+	 * this function through a goto so that the chip never stays in=0A=
+	 * the PRG_CMD state with its loops open; returning early here=0A=
+	 * would defeat that and leave the outputs unlocked until the=0A=
+	 * next successful commit.=0A=
+	 */=0A=
+	/*=0A=
+	 * Re-lock the loops.  Leaving them open is worse than any other=0A=
+	 * failure this function can report, and nothing else closes them,=0A=
+	 * so retry as the priority table does with its own latch.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
+		rc2 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+					SIT9531X_LOOP_LOCK);=0A=
+		if (!rc2)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (rc2)=0A=
+		dev_err(sitdev->dev,=0A=
+			"output loops left unlocked after programming: %d\n",=0A=
+			rc2);=0A=
+=0A=
+	msleep(100);=0A=
+=0A=
+	/*=0A=
+	 * Put the output-system debug block back the way the device powers=0A=
+	 * up.  Its key register unlocks every debug register while it holds=0A=
+	 * the unlock value, and each programming sequence writes that value=0A=
+	 * itself, so nothing needs it left unlocked in between.=0A=
+	 */=0A=
+	rc3 =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+				SIT9531X_DEBUG_LOCK_VAL);=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return rc2 ? rc2 : rc3;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -908,6 +986,11 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
 }=0A=
 =0A=
+/* Per-slot DIVO base register offsets (6 slots per page) */=0A=
+static const u8 clkout_odr_divn_base[] =3D {=0A=
+	0x14, 0x24, 0x34, 0x44, 0x54, 0x64=0A=
+};=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -921,6 +1004,510 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sit=
dev, u8 pll_idx,=0A=
 /* The output divider is a 34-bit field */=0A=
 #define SIT9531X_DIVO_MAX			GENMASK_ULL(33, 0)=0A=
 =0A=
+/*=0A=
+ * sit9531x_is_xo_doubler_enabled - check if Fref doubler is active=0A=
+ *=0A=
+ * Register 0x2D bit 7 is active-low: 0 =3D doubler enabled, 1 =3D disable=
d.=0A=
+ *=0A=
+ * Return: 1 if enabled, 0 if disabled, <0 on error=0A=
+ */=0A=
+static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 val;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_XO2_GENERIC, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * DIVN as a fixed-point value: int_part plus fracn/fracd, carried with=0A=
+ * SIT9531X_DIVN_SCALE steps per unit.  The scale keeps a whole DIVN=0A=
+ * well inside s64 while resolving far below the parts-per-trillion the=0A=
+ * frequency offset is reported in.=0A=
+ */=0A=
+static s64 sit9531x_divn_fixed(u32 int_part, s64 fracn, u64 fracd)=0A=
+{=0A=
+	s64 whole =3D (s64)int_part * SIT9531X_DIVN_SCALE;=0A=
+	u64 frac;=0A=
+=0A=
+	if (!fracd)=0A=
+		return whole;=0A=
+=0A=
+	frac =3D mul_u64_u64_div_u64(abs(fracn), SIT9531X_DIVN_SCALE, fracd);=0A=
+=0A=
+	return fracn < 0 ? whole - (s64)frac : whole + (s64)frac;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_divn_static - read the configured DIVN of a PLL=0A=
+ * @sitdev:	device pointer=0A=
+ * @pll_idx:	PLL index (0-3)=0A=
+ * @divn:	result, fixed point as per sit9531x_divn_fixed()=0A=
+ *=0A=
+ * Reads PLL page regs 0x30 (integer part), 0x32-0x35 (numerator) and=0A=
+ * 0x38-0x3B (denominator).  The numerator is a two's complement 32-bit=0A=
+ * value, so DIVN can sit below the integer part, and the denominator=0A=
+ * register holds the divisor minus one.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+static int sit9531x_divn_static(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				s64 *divn)=0A=
+{=0A=
+	u32 int_part, fracn_raw =3D 0, fracd_raw =3D 0;=0A=
+	int rc, i;=0A=
+	u8 v;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DIVN_INT, &v);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	int_part =3D v;=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_NUM + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracn_raw =3D (fracn_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	for (i =3D 3; i >=3D 0; i--) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DIVN_DEN + i, &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		fracd_raw =3D (fracd_raw << 8) | v;=0A=
+	}=0A=
+=0A=
+	*divn =3D sit9531x_divn_fixed(int_part, (s32)fracn_raw,=0A=
+				    (u64)fracd_raw + 1);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
+ *=0A=
+ * Fvco =3D Fref * DIVN, where DIVN comes from sit9531x_divn_static() and=
=0A=
+ * Fref =3D xtal_freq << doubler.  DIVN is the steady-state Fvco/Fref=0A=
+ * target programmed by the NVM blob and is authoritative in both=0A=
+ * free-run and sync modes.=0A=
+ *=0A=
+ * Return: 0 with *fvco set on success, -ENODATA when DIVN is not=0A=
+ * programmed (dormant PLL), or the register access error.  A bus=0A=
+ * failure is never folded into the -ENODATA case, so callers can fail=0A=
+ * a request instead of acting on a guessed rate.=0A=
+ */=0A=
+static int sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			     u64 *fvco)=0A=
+{=0A=
+	int doubler, rc;=0A=
+	s64 divn;=0A=
+	u64 fref;=0A=
+=0A=
+	/*=0A=
+	 * DT board-config override: some configs (e.g. an INTSYNC PLL)=0A=
+	 * run a VCO that Fref*DIVN does not reproduce.  When the board=0A=
+	 * supplies the measured VCO, use it verbatim.=0A=
+	 */=0A=
+	if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx]) {=0A=
+		*fvco =3D sitdev->pll_fvco[pll_idx];=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_divn_static(sitdev, pll_idx, &divn);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	if (divn <=3D 0)=0A=
+		return -ENODATA;=0A=
+=0A=
+	doubler =3D sit9531x_is_xo_doubler_enabled(sitdev);=0A=
+	if (doubler < 0)=0A=
+		return doubler;=0A=
+=0A=
+	fref =3D (u64)sitdev->xtal_freq << doubler;=0A=
+=0A=
+	*fvco =3D mul_u64_u64_div_u64(fref, (u64)divn, SIT9531X_DIVN_SCALE);=0A=
+=0A=
+	/*=0A=
+	 * A DIVN of less than one whole cycle passes the check above and=0A=
+	 * still truncates the product to zero.  Callers divide by this, so=0A=
+	 * report the unprogrammed divider it describes rather than handing=0A=
+	 * back a zero denominator.=0A=
+	 */=0A=
+	if (!*fvco)=0A=
+		return -ENODATA;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_phase_flush - flush the output phase of a PLL=0A=
+ *=0A=
+ * Fires the chip's on-demand phase-flush (PHFL) so every output divider=
=0A=
+ * of @pll_idx restarts aligned to the PLL phase.  Without it a rewritten=
=0A=
+ * DIVO keeps counting from an arbitrary point and the output edge lands=
=0A=
+ * with a persistent offset against the tracked reference (only a power=0A=
+ * cycle realigned it).=0A=
+ *=0A=
+ * The sequence mirrors the documented procedure: arm the on-demand PHFL a=
nd=0A=
+ * latch it with the PLL-page small-change update, then select the=0A=
+ * in-register phase trigger on Page 0 and pulse it.  The Page 0 trigger=
=0A=
+ * register is touched read-modify-write so the unrelated OEb bits are=0A=
+ * preserved.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll=
_idx)=0A=
+{=0A=
+	u8 ctrl, orig;=0A=
+	int rc, ret;=0A=
+=0A=
+	/* Arm the on-demand phase-flush on the PLL page. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN,=0A=
+				    SIT9531X_PLL_PHFL_ON_DEMAND_EN);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Latch it with the PLL small-change update. */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+				    SIT9531X_SMALL_UPDATE_CMD,=0A=
+				    SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Select the in-register phase trigger, preserving the OEb bits.=0A=
+	 * Remember the original register value (with the trigger de-asserted)=0A=
+	 * so the trigger-source select can be restored once the pulse has=0A=
+	 * fired.=0A=
+	 */=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;=0A=
+	ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl);=0A=
+	if (rc)=0A=
+		goto disarm;=0A=
+=0A=
+	/*=0A=
+	 * Pulse the phase trigger.  No explicit delay is needed between the=0A=
+	 * set and clear writes: each I2C transaction takes far longer than=0A=
+	 * any minimum pulse width.=0A=
+	 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,=0A=
+			       ctrl | SIT9531X_DIVO_PHASE_TRIG);=0A=
+=0A=
+	/*=0A=
+	 * Restore the original trigger-source select.  The pulse above has=0A=
+	 * already latched the flush, so a one-shot flush must not leave the=0A=
+	 * phase trigger permanently pinned to the in-register source.  This=0A=
+	 * runs even when the pulse write failed, otherwise a failed flush=0A=
+	 * would keep a hardware trigger source hijacked; the restore error=0A=
+	 * is only surfaced when it would not mask the pulse failure.=0A=
+	 */=0A=
+	ret =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, orig);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+disarm:=0A=
+	/*=0A=
+	 * Disarm the on-demand flush enable armed above.  Leaving it set=0A=
+	 * would let a later assertion of the restored trigger source=0A=
+	 * re-flush every output divider of this PLL, which is exactly the=0A=
+	 * persistent side effect the one-shot sequence must not have.=0A=
+	 */=0A=
+	ret =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				     SIT9531X_PLL_REG_PHFL_CTRL,=0A=
+				     SIT9531X_PLL_PHFL_ON_DEMAND_EN, 0);=0A=
+	if (!ret)=0A=
+		ret =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					     SIT9531X_PLL_REG_SMALL_UPDATE,=0A=
+					     SIT9531X_SMALL_UPDATE_CMD,=0A=
+					     SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_calc - work out an output's divider and its VCO=0A=
+ *=0A=
+ * Separated from the write so a caller that programs more than the=0A=
+ * divider in one sequence can compute the value before it enters the=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_divo_calc(struct sit9531x_dev *sitdev, u8 out_i=
dx,=0A=
+				     u8 pll_idx, u64 frequency, u64 *fvco_out,=0A=
+				     u64 *divo_out)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo, fvco_min, fvco_max;=0A=
+	int rc;=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (!frequency)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * The core validates the request against the supported ranges with=0A=
+	 * the value narrowed to u32 but hands the full u64 down, so a value=0A=
+	 * like U32_MAX + 1 Hz validates as 1 Hz.  Reject anything that does=0A=
+	 * not fit the narrowed width the validation actually covered.=0A=
+	 */=0A=
+	if (frequency > U32_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Determine VCO frequency band limits */=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3) {=0A=
+		/* PLLB, PLLD: high band */=0A=
+		fvco_min =3D SIT9531X_FVCO_HIGHBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+	} else {=0A=
+		/* PLLA, PLLC: low band */=0A=
+		fvco_min =3D SIT9531X_FVCO_LOWBAND_MIN;=0A=
+		fvco_max =3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Read current VCO frequency.  When the board supplies an explicit=0A=
+	 * Fvco via "sitime,pll-fvco" the override is the source of truth=0A=
+	 * (e.g. a chip variant that runs out of the documented band, or a=0A=
+	 * mode like INTSYNC where Fref*DIVN does not reproduce the VCO), so=0A=
+	 * skip the band clamp in that case.  A rate read from the device=0A=
+	 * is clamped rather than refused: the bands bound what the VCO can=0A=
+	 * physically run at, the readback is the only estimate available,=0A=
+	 * and refusing would make every output unprogrammable on a part=0A=
+	 * whose DIVN registers do not describe the running VCO.  A DT=0A=
+	 * override is refused instead, at parse time, because there the=0A=
+	 * board is asserting a value it should know.  A VCO that cannot be read =
fails=0A=
+	 * the request: programming a divider from a guessed rate would put=0A=
+	 * the output far from what was asked for while reporting success.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+	if (!sitdev->pll_fvco[pll_idx]) {=0A=
+		if (fvco < fvco_min)=0A=
+			fvco =3D fvco_min;=0A=
+		else if (fvco > fvco_max)=0A=
+			fvco =3D fvco_max;=0A=
+	}=0A=
+=0A=
+	divo =3D div64_u64(fvco, frequency);=0A=
+	if (!divo)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * DIVO is a 34-bit field.  With a band-clamped Fvco this cannot=0A=
+	 * overflow, but a DT Fvco override is taken verbatim, so guard the=0A=
+	 * field width rather than silently truncating the divider.=0A=
+	 */=0A=
+	if (divo > SIT9531X_DIVO_MAX)=0A=
+		return -EINVAL;=0A=
+=0A=
+	dev_dbg(sitdev->dev,=0A=
+		"out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu (effective %llu Hz)\n",=0A=
+		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));=0A=
+=0A=
+	*fvco_out =3D fvco;=0A=
+	*divo_out =3D divo;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_divo_write - write the five DIVO bytes of an output=0A=
+ *=0A=
+ * The caller must already be in the programming state.  Bytes written=0A=
+ * before a failure are put back, so the output keeps the divider it had=
=0A=
+ * rather than a mixture of the two.=0A=
+ */=0A=
+static int sit9531x_output_divo_write(struct sit9531x_dev *sitdev, u8 out_=
idx,=0A=
+				      u64 divo)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, divo_bytes[5], old_bytes[5], msb_old;=0A=
+	int rc, j, rb_rc;=0A=
+	u8 written =3D 0;=0A=
+=0A=
+	/* Map output index to physical slot */=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+=0A=
+	/* Determine page and per-page slot register */=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	divo_bytes[0] =3D (divo >>  0) & 0xFF;=0A=
+	divo_bytes[1] =3D (divo >>  8) & 0xFF;=0A=
+	divo_bytes[2] =3D (divo >> 16) & 0xFF;=0A=
+	divo_bytes[3] =3D (divo >> 24) & 0xFF;=0A=
+	divo_bytes[4] =3D (divo >> 32) & 0x03;  /* only bits [1:0] */=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j),=0A=
+				      &old_bytes[j]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	msb_old =3D old_bytes[4];=0A=
+	divo_bytes[4] |=3D msb_old & 0xFC;=0A=
+=0A=
+	for (j =3D 0; j < 5; j++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(page, base_reg - j),=0A=
+				       divo_bytes[j]);=0A=
+		if (rc)=0A=
+			goto rollback;=0A=
+		written++;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+=0A=
+rollback:=0A=
+	for (j =3D 0; j < written; j++) {=0A=
+		rb_rc =3D sit9531x_write_u8(sitdev,=0A=
+					  SIT9531X_REG(page, base_reg - j),=0A=
+					  old_bytes[j]);=0A=
+		if (rb_rc) {=0A=
+			dev_err(sitdev->dev,=0A=
+				"out%u: DIVO rollback failed (%d), the divider is part old and part ne=
w\n",=0A=
+				out_idx, rb_rc);=0A=
+			if (!rc)=0A=
+				rc =3D rb_rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u8 pll_idx, u64 frequency)=0A=
+{=0A=
+	u64 fvco, divo;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_divo_calc(sitdev, out_idx, pll_idx, frequency,=0A=
+				       &fvco, &divo);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_divo_write(sitdev, out_idx, divo);=0A=
+	/*=0A=
+	 * Step 4: NVM update + loop lock.  Always run prg_commit() so the chip=
=0A=
+	 * leaves the PRG_CMD state with the output loops re-locked, even when a=
=0A=
+	 * write above failed; keep the first error to return.  It also carries=
=0A=
+	 * the required post-lock settling sleep.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * Step 5: flush the PLL's output phase so the new DIVO starts=0A=
+	 * aligned instead of keeping the arbitrary phase the divider=0A=
+	 * happened to be at.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_freq_get - read output clock frequency from hardware=0A=
+ * @out_idx:	output index (0-N for this chip variant)=0A=
+ * @frequency:	output frequency in Hz=0A=
+ *=0A=
+ * Reads the 34-bit DIVO divider back from the output system registers=0A=
+ * and computes the live output frequency as Fvco / DIVO.  This stays=0A=
+ * correct even when the divider was reprogrammed behind the driver's=0A=
+ * back (e.g. by a direct-I2C userspace tool), where the cached value=0A=
+ * would be stale.=0A=
+ *=0A=
+ * The cached output state is refreshed with the computed value.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -ENODEV when the output divider or VCO rate=0A=
+ *	   is not resolvable, <0 on register access error=0A=
+ */=0A=
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
+			     u64 *frequency)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, base_reg, pll_idx, v;=0A=
+	u64 fvco, divo =3D 0;=0A=
+	int rc, j;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	pll_idx =3D sitdev->out[out_idx].pll_idx;=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -ENODEV;=0A=
+=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc)=0A=
+		return rc =3D=3D -ENODATA ? -ENODEV : rc;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)=0A=
+		page =3D SIT9531X_PAGE_OUTSYS1;=0A=
+	else=0A=
+		page =3D SIT9531X_PAGE_OUTSYS0;=0A=
+	base_reg =3D clkout_odr_divn_base[slot % 6];=0A=
+=0A=
+	for (j =3D 4; j >=3D 0; j--) {=0A=
+		rc =3D sit9531x_read_u8(sitdev,=0A=
+				      SIT9531X_REG(page, base_reg - j), &v);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		if (j =3D=3D 4)=0A=
+			v &=3D 0x03;=0A=
+		divo =3D (divo << 8) | v;=0A=
+	}=0A=
+=0A=
+	if (!divo)=0A=
+		return -ENODEV;=0A=
+=0A=
+	*frequency =3D div64_u64(fvco, divo);=0A=
+	sitdev->out[out_idx].freq =3D *frequency;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Phase adjust (PRG_RST_DELAY register-based).=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index e2ff21adfdb2..88122a368053 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -335,6 +335,28 @@ sit9531x_dpll_input_pin_direction_get(const struct dpl=
l_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_frequency_get - read input pin frequency=0A=
+ *=0A=
+ * returns cached frequency from DT or last set.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				      void *pin_priv,=0A=
+				      const struct dpll_device *dpll,=0A=
+				      void *dpll_priv, u64 *frequency,=0A=
+				      struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	const struct sit9531x_ref *ref;=0A=
+=0A=
+	ref =3D sit9531x_ref_state_get(sitdpll->dev, dpin->id);=0A=
+	*frequency =3D ref->freq;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
  *=0A=
@@ -571,6 +593,7 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pin =
*pin, void *pin_priv,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
@@ -629,6 +652,7 @@ sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpl=
l_pin *pin,=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_xo_pin_state_on_dpll_get,=0A=
 };=0A=
 =0A=
@@ -644,8 +668,78 @@ sit9531x_dpll_output_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency=0A=
+ *=0A=
+ * Reads the DIVO divider back from the chip and computes the live=0A=
+ * frequency as Fvco / DIVO.  Falls back to the cached value only when=0A=
+ * the output is not resolvable through the divider chain (e.g. not=0A=
+ * mapped to a PLL), so transport/register errors still surface.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 *frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_get(sitdev, dpin->id, frequency);=0A=
+	if (rc =3D=3D -ENODEV)=0A=
+		*frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->freq;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return rc =3D=3D -ENODEV ? 0 : rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_frequency_set - set output pin frequency=0A=
+ *=0A=
+ * computes DIVO =3D Fvco / frequency and writes the=0A=
+ * 34-bit output divider to the output system registers via=0A=
+ * sit9531x_output_freq_set().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,=0A=
+				       void *pin_priv,=0A=
+				       const struct dpll_device *dpll,=0A=
+				       void *dpll_priv, u64 frequency,=0A=
+				       struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Read the PLL that drives this output from its OUT_MAP state=0A=
+	 * (populated by out_state_fetch from the chip's OUT_MAP registers).=0A=
+	 * That is the index the output register programming below is keyed=0A=
+	 * by; the output is registered under the DPLL matching this PLL.=0A=
+	 */=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
+				      frequency);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "Output frequency set failed");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
+	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index da61a65ac2d2..058b892d656e 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -201,6 +201,7 @@=0A=
 /* Debug register (same offset, per-page) */=0A=
 #define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)=0A=
 #define SIT9531X_DEBUG_UNLOCK_VAL		0xC3=0A=
+#define SIT9531X_DEBUG_LOCK_VAL			0x00=0A=
 =0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
@@ -215,6 +216,10 @@=0A=
 /* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */=0A=
 #define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F=0A=
 =0A=
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */=0A=
+#define SIT9531X_PLL_REG_PHFL_CTRL	0x3D=0A=
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN	BIT(7)=0A=
+=0A=
 /*=0A=
  * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +=0A=
  * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be=0A=
@@ -227,6 +232,18 @@=0A=
 #define SIT9531X_PLL_REG_STATUS		0x31=0A=
 #define SIT9531X_PLL_REG_NVM_UPDATE		0x3F=0A=
 =0A=
+/* DIVN registers (free-run divider readback) */=0A=
+#define SIT9531X_PLL_REG_DIVN_INT		0x30=0A=
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
+=0A=
+/*=0A=
+ * DIVN carried as fixed point, and the unit the DPLL ABI wants the=0A=
+ * fractional frequency offset in.  Equal in value, distinct in meaning.=
=0A=
+ */=0A=
+#define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
+#define SIT9531X_PPT_PER_UNIT		1000000000000ULL=0A=
+=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 #define SIT9531X_PLL_REG_ZDB0		0x2B=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
