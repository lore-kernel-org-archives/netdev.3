Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AB2FD1A5;
	Fri, 16 Oct 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112310; cv=fail; b=T9UKJ9kWaUvKhwqBJxQkedm6ALFLIjEkyhM8fa8/CORxo20CJWEnhU1arwEmH+qAna+6lXVuK/EEmPCSIHnoifuo5zWPdzBDZy+mllnYQUnKPHvjVFdAxg5+2lJ390XmhUUdXaFxk7RTfo8QFnjKy14JPV7gfkyyDWQNaIiJZ9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112310; c=relaxed/simple;
	bh=C6aTK5qXEp2iLRwDlVj9M35CpLgEiX+AGr67ho01D4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qx0v65I+vIJIu2HNh58mWMWInl9MTDx1r/8/OzK3JUiH+0eKeQS7sCDmbGFWZhB2QY898mgeQf+tRa9jamaxrSQJX7wo/o5Bq+BpXzNFs5+NZVSCKDuhQxsjm1xZEPT4acvuggYck+dlUHdasGJwNw6073OP7d9IhFTRfyfDZ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=l261bQUY; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=hpvE+P1+; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="l261bQUY";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="hpvE+P1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=C6aTK5qXEp2iLRwDlVj9M35CpLgEiX+AGr67ho01D4I=;
 b=l261bQUYzBsioA3XKY4YTkfkGnJmJwJpHiugIAsu/BOiqGWSsQH91bXhuxxZrErVwxdQDMDhQTVxtwQANOQLazyyYTOI2xUCPb/d79qlN8NcjKAK4qUEvZ5zOVG2dwfNUfd4foWrM6BmG08jYMkLfa60PnKd35bHZ2AlFJvdHysJvvb08apyN5He50PaRsTmn1REaBKFYY7MfFpGfgRWmMeEDvL8IzS+KQQIlk/lIP9O1/OftoEJWufoKrI1S8DmGUBLhSuyZezc3DBRPjcLPOJXdL3anS/I69qNpGWQsSuliumYxxNvyi1lq+774DNOivE3XQqyVR4d5o0YHi0HEA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021098.outbound.protection.outlook.com [52.101.52.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7C2B2B00050;
	Fri, 16 Oct 2026 00:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPH1YyQznuXQ8owYzm8rxzihmOG/APnf61uVVIfPvKUN83/he7fwvDRHki6603Yx5Y799P1jRGVhLrhjeJM1EneeSdyQZmI3QzAq/a7fXK2M9pusZO8W/hII9ixkzvlaVQn4qZaVRZZ3VoC/Sh+GFDWaa0Y1beH1h3i42XWZ5gwb4r8OTIINAbaYf0YVGDL09EjYKxDRgrm3qpRSabYV3PU5DAkNB9LG5OY3Z0/Z9p8hM+nCfP//gx7P8s0/DnF0aVnoKSh+Eugsxe/1P3dR4LM6pQjTGOAu8Kx8bOpmoL1HQoPpneCIQ1PLr0Ox+WmcpnxvWKkEgdpXaCKwf6qKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6aTK5qXEp2iLRwDlVj9M35CpLgEiX+AGr67ho01D4I=;
 b=IARAVKrDep/7SnDJSF7VgK4A8pc7tN0KjMAujRz64EtBOhP+UOCkI40lVZzg+5d+qmXuDVmMKIVmCqJEYeJwfjHsNbvE4GXniKMBRwKjrVS0yFLO7hYAqgIH5xSkxoX9mRQkR/wOS04yqNaAO+mNyMiy4UWzFuLQ0UUJJJSs3l7tWUZ7zzAScXoP/ZMDXGxcOq8MoIiiseAaZ6gt19pLMUZPVqCfReGFHuxBphsTfdw+8QZK98CCEnlgv5Xt5ESncNk7WB56mID+zi+56rDGPb/v+a3etDmEgAZu+F16sSy9NOJ+ehm8PoES9PbfxiaDGkYAnmQA7kqH0iBLe2/fsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6aTK5qXEp2iLRwDlVj9M35CpLgEiX+AGr67ho01D4I=;
 b=hpvE+P1+77l8BSNDiZBCXXzxBIGA/6qhP5e8TpwAlSTKmOhufJiV/rCnH1GmnSrjoP2ZVWT8aIkOI4Emu5VQG71oXTa18CR30FUdXf9nWClPu9ytUq6aLgpQtyutZcpByZ6Tdv8hNYfryPXN1jq6dhpWWDuHRl8QupW9cjC/nOFXePPquyumKE8FknPW0En3wnvmCxeBMHfKYFlRTiCSE8tD4ORG4RQ/hWdfqtvpJ3u2fSmfEUCWcs+6J9yzh1noow9j4Z82VgRRnwD5TQHoH6Cu3t5m7BOafLqOX/s9dK4+zq8QFfCgN7x+PvZd/pVQtlQW9F3q3qwvvB7QOQNqBw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:58:24 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:58:24 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v14 01/12] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v14 01/12] dt-bindings: vendor-prefixes: add
 SiTime Corporation
Thread-Index: AQHdXQlyAd4EH7DopUaIpVTBPzH5FQ==
Date: Fri, 16 Oct 2026 00:58:24 +0000
Message-ID: <20261016005823.13690-2-arouhi@sitime.com>
References: <20261016005823.13690-1-arouhi@sitime.com>
In-Reply-To: <20261016005823.13690-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: 0e569169-84e7-4090-3c21-08df2b2094cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|261009223027099003|18002099003|10067099003|260925021911599003|22082099003|260925022911599003|260925021311599003;
x-microsoft-antispam-message-info:
 yegfVvuK5GO+cAmwg3brswwW9oWWZLzza+kxI91sUxeRL06m5ntcCFQ6CHhkSXzEQWhjzvaWucGtukltZ4VQh8j9+hMoI6xOfh9KzSXOiOWLrsOxszsEmKtaijFZuRvmZsvtNiLB2LLSvx7g//siobtw+SBKJqF4PTTsQyALg7HisgXgRCuBhc50SlAPTjw6kp4FJfUpW2obHfeZchdpMIsEARHzpUAcKfmUho8qc1tXsjuojw0IeM3NfIp1TE94o5w9/GvRrIClj5MfsbQ+eRFQzO9rJpzIjhUWUvhMXTuxQsSFf2xoNqlcwN2yBesAPtbOa0thJlFtkcpjIt7WE5wBsyTL6stXiEp4387F+8AmsoADeTBT1eCLfK+nq4B0dNzTT0bCeVd4+Ewj35lBt43t04sWuVWHjRpj4zFsxQkX4mKLWo/c0dkuGlSOasrJqKuNU40g/qELSsHCTPsK+6rTvj3pPHhrXVK27xgIX+lfZ0ZlYNy/Z867l2sfTVty52KtGJnMgusp+nLNIBzqTQGdQ2jPqjH1ujnChQ7/bexZXMLKXawEKfNcKVsBXynElNFxqorgaEWAChp0ZSI7w4ctRz+P206/9YAA34MQTAbJ43FxKNwCQZ+Z9QNgcNUnImNrmwIkmjgrJtzTVEZhBlxhoIpV0oJl8rNwbsjiX/J4Zvhvbr/C33AhidTNOtLvlBQQpL83jBj2uKFmbpyMPYqiSbgT6HPhw2/XcoxR9ME=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(261009223027099003)(18002099003)(10067099003)(260925021911599003)(22082099003)(260925022911599003)(260925021311599003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUJVVldReUl1S3lMWkVCb1lNVzNoVzJMa2o0dWZRcGpuV0MzcElUMEZPNmZF?=
 =?utf-8?B?R1d0aDZ5TzNLbDdFZm0xc0hEamZxMzNNK2ZzT1pVbHRveWRPeXhEQmwyRjBi?=
 =?utf-8?B?R3Q4UnFiWmNPMTEvQ044d2Q4V2lDV2J4STlsVkZuOTlzbDlZK2JXOFlOd0Vo?=
 =?utf-8?B?S25wQWN6a1Jtck1kR0RsVUpqMkplOEFWbGF3UGRLSGdHcGFmcU9YRFp5cjhw?=
 =?utf-8?B?Rmt6K0V1b1hxT21WRTlONFB3SmtiUXk3WHQzZ0dZeDJXMDg2R29kenJhcnBC?=
 =?utf-8?B?SnE1TlAzcm5Yak9BclJOYlZVMk1ISSszNk5wcjVqK0c5ZVI2NC9vK1NkaGVG?=
 =?utf-8?B?VkhSZXh1OTRQNWR3R3RUTHNQMVpPZFUvaFdSaVU2Q3Q2M3d1N1hSTld6aGNW?=
 =?utf-8?B?MmpvSGVHSkJrNXZWYkJrTkx0SWZrZ2JYQlZDZDd4TlV2b2dqQTdjQS96WXdw?=
 =?utf-8?B?dW5zZVR3YnY3T3AwM3JZOXBXWCtEd01wdW10T1VsQnBxRmRtdG53ZHIxTWx3?=
 =?utf-8?B?Y0IyWjliQTM0QlVTcWtyR3hVNE1lYmtYdUJuWVBscjhQL01jVm9SRTRLa00v?=
 =?utf-8?B?dDU0WU5raS9QK3Y4YjN1UFpEb09iL012b0tEMk1kNVZXeWV1eEZTSTFScjdn?=
 =?utf-8?B?eSs4YXkzeHRzOHBMRERDQldWVXFJdzFFcUF2Q3U0MmxKM0p3L1hxd0pabmh1?=
 =?utf-8?B?Sk9NQ2x1Wm9GaHpPaUhxUElIYnlNMS9Ta3UxNlFsZ1RjNVVnb0xYemJwK2Zy?=
 =?utf-8?B?b0ZPNWxzbFFRcml2ajNhb1JEeERiT1J5bnZOdGN2QjNIS254M3BRWGhuYjJJ?=
 =?utf-8?B?K29rOW1ISExxZzc3dUh3Qjd1Yk5JZTljb1A4V3FTWW1FZzdwMC9zQmh3VWg3?=
 =?utf-8?B?WHB3U0dLeEpaZzJjWTFKQnRnZEZjT1p6ak5qam0wSllRSjRmbXFQK1pyeS9l?=
 =?utf-8?B?MWlBc1FzcDd3TzQ0Q0JGVnZpQ0lnZ3ZNaHVmejdFdDIwcDhabENLb0NjbnFz?=
 =?utf-8?B?U05SWmM5M1QwQTVVaHpLZVlXYU1BL1FZdmZXWjVITFhFTmkxZmpXR1VlVXFh?=
 =?utf-8?B?WGF1Q0J5MjV5RGJLUzhHMFE3dVZhYXRTRjAxYmIvenRDTkRpNWM0Nkg0L1NU?=
 =?utf-8?B?NHVMMEN4RHpZdEhCSHhWc3JRL25qb3pudUxlRkxuVXlOV1pPeVJFeWNNOExl?=
 =?utf-8?B?L0Z0aURVMjNHZ3NQdnpPTHhnek0rb3ZUNGJRRUVLQUVWOHFtYnVIazNnYlVX?=
 =?utf-8?B?OFdBTHpYcERmbFg2R1N4c3dTdGFuWUhLcVkwNElyUVpXQ1EwYUtMMmdtbUwv?=
 =?utf-8?B?MUs5WXJPbWw2MHZnOTMrZlhJVmNyclM4MXdlYTEyWlF6eVJxT3QzNDYyRXFK?=
 =?utf-8?B?Y0ZubTh5NWsyR0I3QmpaQjg4OEVyQnM4RE40RTN5cDU1ZUJPTTd1MXh0L3pD?=
 =?utf-8?B?K01RN3IzM1JWOHd3TmxGaW1uc1daazlyNFdPeGJXNkM5YTNleUxMeExhS1pW?=
 =?utf-8?B?RGw1endIaCt2My9JT1NUWmJ1bndtWG1RQkM1UGFONlZIREs0UDQ3WDVMbmJi?=
 =?utf-8?B?SHNPZHVBNGQ5OTRadjhEMm5WdnJBcHZORmVUNFJmU0VncmhQdnZZaXFmblpQ?=
 =?utf-8?B?UGpXemdCR1g3TlNnNkgxS0ZvYlk3SW5tQ1N2cHlGQ1JwYS9xd2o4WXp5QTB5?=
 =?utf-8?B?b0dzMUkzcWZ6ZWVUL1AzRi9sNU50cDdEaGhDb2ZMMGZPUE0wWmhBb3MwT3M4?=
 =?utf-8?B?YjBWMTAzakJzYWZZaUFEdS96bTRiMThBZVVRQnl2YUx3MFNqNHFZVGdkVFhw?=
 =?utf-8?B?UFZXU2d0eFg4dzhOcloxbllEeXdybDFNYkFXcUxaa3J2SGZldUZjYjhWK1lQ?=
 =?utf-8?B?aUhwd0pSRldOKzFjQm5oWlozN083dFBOYlMrVC9XUUVtZ09JOSt4eEM0QmpY?=
 =?utf-8?B?MjBsSy9Db3JFbDYzLzBvN2Q0bEczK1JWSWxSdUFoS2xFZkRNdC96RUliTTFt?=
 =?utf-8?B?MEFWdG15a00rTmpFdU1Wc0NwRFFYUkZvdDVJZEVTQmozY2pZbVlvaWcvMmZM?=
 =?utf-8?B?Q2tvb0oyRmlPSHZFK1Y2NkZkeSt1b09YMkJZZUlXc3o2TXl6VWdrbHQ3THRG?=
 =?utf-8?B?V0JaazJaUTZVdzJlL0N4NGlabmpaK3ZjMnA2RTdjMHo5VnNzRUZXYVNsSzZC?=
 =?utf-8?B?WjFESVZMSWhKY0ZHbEdFbE5xTlNrTEFZWEpKc05tbU1qVkJwOThpQS90S0lz?=
 =?utf-8?B?ZHI3cCs4dFJRNnNqWGcxdUV3YkJJREV0Y1NZQ1YweWQ1L0grQXVGMzVJdzd3?=
 =?utf-8?Q?EpWOnOhnIBZMAzbQlQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	k5/RQmdUsACODgzS1HgJPf7R7Rx/GXa//hlLGwx7kNc7KOFArJj9CRAdZuxPUwwc+NJlq5Remp9pnzn0mLl+DJBoviz/t587yVAJrEr7zSB347nQYq/3eL1F8/2Z7KCDHMJ3pirS6ugb/vplL1SJzUZrT6KoEB9UugxMI1bn1WzsyG8I5TZZySswTzjunEbVhZyTzyMWXmM1yM3gK+IJ/ss9b/qQe6oT/LkfHmJUiJjXZMg9i9E6ttzJ/J6ky7H59j1RPAMo3A5/IWatySkKJ6dh6IIEZK9SNu4g+0KKxomx/5sBnm227RUntDMc6I97btELiHC2iCk1BN1SSte2gg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e569169-84e7-4090-3c21-08df2b2094cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:58:24.4636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzjZ1IdVXYg+13f43Ux9I+J59jPpl2nKFenMMGnb+McfRXTLPsFlbUTZo+iOIjnwvx98ZF5Ja0TteoYJssCwPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112307-Jvr0FasWOuLr
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112307;Jvr0FasWOuLr;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

QWRkIHZlbmRvciBwcmVmaXggZm9yIFNpVGltZSBDb3Jwb3JhdGlvbiwgbWFudWZhY3R1cmVyIG9m
CnByb2dyYW1tYWJsZSBjbG9jayBnZW5lcmF0b3JzIGFuZCBNRU1TIG9zY2lsbGF0b3JzLgoKU2ln
bmVkLW9mZi1ieTogQWxpIFJvdWhpIDxhcm91aGlAc2l0aW1lLmNvbT4KQWNrZWQtYnk6IENvbm9y
IERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sIHwgMiArKwogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbAppbmRleCBiYTIwMDI5NjkzNzMuLjY1
ZGEyN2Q2ZTg0ZCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3ZlbmRvci1wcmVmaXhlcy55YW1sCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbApAQCAtMTU2Myw2ICsxNTYzLDggQEAgcGF0dGVyblBy
b3BlcnRpZXM6CiAgICAgZGVzY3JpcHRpb246IFNpUkYgVGVjaG5vbG9neSwgSW5jLgogICAiXnNp
cywuKiI6CiAgICAgZGVzY3JpcHRpb246IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIENvcnAu
CisgICJec2l0aW1lLC4qIjoKKyAgICBkZXNjcmlwdGlvbjogU2lUaW1lIENvcnBvcmF0aW9uCiAg
ICJec2l0cm9uaXgsLioiOgogICAgIGRlc2NyaXB0aW9uOiBTaXRyb25peCBUZWNobm9sb2d5IENv
cnBvcmF0aW9uCiAgICJec2tvdiwuKiI6Ci0tIAoyLjM5LjIgKEFwcGxlIEdpdC0xNDMpCgo=
