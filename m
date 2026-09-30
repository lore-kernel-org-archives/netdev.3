Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91E4AA00F;
	Wed, 30 Sep 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811442; cv=fail; b=ovnSmi2cGpcCTBfRzTl7K/s+N6cPHKa4ItuygP3duZCTnF/5yTglvF8iNfHo8uHcInTJDpL4v3gyoU5y+2H1ig0Qn1L0jboTaiztWEaHAQH0ERLYN0T09ayQSuXemUmCpDbAvSA8/DCDaFqx5yq/1Sw8vBStxZmpPzH6h3SyhDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811442; c=relaxed/simple;
	bh=R3FnNuLxSD0Bj7/xD8OdWiH7x5ulqv0NFh5CW5e4HFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LdnZlyxzoz0VGguqLv0uDp+VPA3fEHzwEKd9GoVACiq2bQRO/f9jMhuN0R/txaH8dL6jI2uayKRo34QkXO4SyJZFq8OAszxo4stCHzxLfy29fY8W2ySnUtW/wGiG1jjlhnEs3B0W8sZJJg4VOBt2hCbZ9sXjVu6LNVeT8nkupvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=duW3OojV; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=stJl/tbe; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="duW3OojV";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="stJl/tbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=7igSep4PJ5MIC5P9sAUyMqLtEBSFBUnFv3IdlyYa4ok=;
 b=duW3OojV1cTXfwfeRQVA14DykGaJjdTIAilApGXf6FJgZBFYhaWAp+0K8u7rnxy0J/PsRNBelEao7EJfETzqzYQ8ziSSuR4MpBE+U/vyyDOBE5P6lIMH4p+jMb4kuulwhGQd4M6L84tV78gvz2gL1jH5PpnRhITF3FhEPSjBlExjG1ei6kXTjzXiWOkzO4mNp1ULj82pnMIN3+hkc/hkAfLqpRETXr+4+CJbq5YaH/bXv2kyMDJgvatYv2rArtxJLxjCMF8m3NHfcWSJg5TEsy2awagZfXNwFPL6Sfatp9keNEUKnqrmyASyz18Tr1cJoC3FMuA4sN72djK525VZ9Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020134.outbound.protection.outlook.com [52.101.56.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E94BB100067;
	Wed, 30 Sep 2026 23:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjKrloaHZPGRFqDtX7OKrHHEV0cwWZEyczUZJzfpQQVnTnRxMdLjtJSAtKXuCmd3PLAq0ZcNCd5yG91kfZh4HCwP15Kry5I6y6562BkNZtydAzkpYjeY1Z3aMrQuHdHR8TRjdhHqk+ITCFSXzboeh5kbRa4EzHMex77M2OL1ru6R4E4EPmxrbfuDii1HQS7sW146PQgUi64nGhq4qTs718np3W/KN0t8TAor4PtxljmwB4rPpjO6UZFqvTlSWU0BfJ5Zk+1HMQxoeDjgX0Ivv4IsTp5Fq37G8BlTDQPAdBZV3a6u04y1+pgo9H98TI/nq3r59avU1jy5zeHDWzCJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7igSep4PJ5MIC5P9sAUyMqLtEBSFBUnFv3IdlyYa4ok=;
 b=KcPleC/aXLw3ao7/l5/rdIKqyafUGbLzg8YRVHUvSZ5d+QOqilJrc8YZ/hXIznZ+/dTcXCDOXwe0EIkUBddlGHJVSPcOByqc6laMXLJqVI1MyY43Maw7Rz4jo0krC0g3APD6xG8hNzOF6gChYP4uV7w27cul3ocMOev/2bgDzjcPSIioDJT4i0UOoepnPmuL064/RJUpd6Vx12Gd1u5ICdumn0mUSHQX3dbgOF5g5EGTv3Wn4rc8438bgiduAcNS1jiLeRYA8EO5XhKCnFRPMiC2y0O67wDNrRsQ9QS6kjINYcAMVbRSWm6xm7p1o4vUMxGJ/bNNKl1L7YXatEqgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7igSep4PJ5MIC5P9sAUyMqLtEBSFBUnFv3IdlyYa4ok=;
 b=stJl/tbeWXz6Jtu/MXi+yOByGLjIF806DuWqPxOKWUTleReU4BQKsYqct/RoJZ4nJiyWicUISAV5AJjtWGQgRh/HKoDL4ka3h/lTUrmC+xAvRfuYkmdDaRznQfFlJ8j3eGOCBBjF4rwWS1e6x204QHuT1qDt+GVlROo+0rdoXYVVsvu+A8dkLg91ciy3VfRb2u67MKj8ZykAa/8EKlfR/cRyUPtvZCiLfGVS14mxtVxYXKurel1rJtiH3w3hney6wXE+Y7VmGDeFeBhkNtdpLukdbNsOLBXZFIJBFeh3lAMH/qgd3Cuo/LsB0yh/9PV7M0lJFlgoLXj11tDAY6B6sw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:37:17 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:17 +0000
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
Subject: [PATCH net-next v11 01/13] dt-bindings: dpll: allow hex unit
 addresses on output pins
Thread-Topic: [PATCH net-next v11 01/13] dt-bindings: dpll: allow hex unit
 addresses on output pins
Thread-Index: AQHdUTSgq0nNanFY2E+2nz3ulHYwTg==
Date: Wed, 30 Sep 2026 23:37:16 +0000
Message-ID: <20260930233714.87679-2-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: f0814bee-7896-464d-5323-08df1f4bc380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|3023799007|10067099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 J9SlHYxsBcpozBYmZ9kERUk4gu0VQABoxPGO4/3wOZ+NoG4eUzifHGh6aBE3S9DISxKeEHNnd5igGMHiEs1xVXIxg8J5gSuSDXjK2cn/tkZ6BnUljfXWmbrtD7LhO8WLk28h2rt1KHaHuT07VIysFDL1QpgwWdWixwbK4Q5VKFK8lTyYJHcDn305YxPGeHUjQXGZHAGzEesMJbnmPuxxL4GWxRxCtmhD2aWxRSK+Q4yedYYLRxijJWN9vcdpYXagjk9Tc0oHgvjAtsVumAe/Sg4Os2u1hfBlnGvEcN+PIDCtEG6l3o3pjmvbaRcBIaGasjOEerg14tSj63KxtqasCaaKoxwPGwL2+hJef9VCAwBK1GU3dNQefUKjIT9IoO+wnQppQhCiLB/9pSjW5NTU6IDvineS2sPM0hnNfXMlHzbipbAsQPZhKsuWgX9/DA1yKsFmSfEbJMpnfYQtdUELL75fFur+ysKuxSCFo/WwQDCJzCbsE+u1xvqZtOn263ZY4pNjivLiFSXXxjmFGnrXvgW4h3CDD6qwTIrL6SqDgccbXpQG2Z5VnkcTnr7WG9E5QJBgmBAQB6uoWUIjiuuaVa+3Cry68IAEfEEf+PxMzhDO1vJeyw029maxf+xgm06cy/xRk7ENZYFxeS7fnZXmLl9UO0QsRkQHThHSp3FD4y71NM9lqvkhmHZLNTwXPhOyRperjMwunc8Gi3ADFHOO2kvaSz/ezlnmxxS+zVwKwEg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(3023799007)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7PnCN6vUuSWWtHEA1qq2o/nsWRoJS5SSm7LsSLa48wxKyRscKeMC/9AbHW?=
 =?iso-8859-1?Q?h9wCzZ234BgsaPfUfa6GPKSPZgXw7VVMcYpPXvktlH6gOm7KkyTugAWq+y?=
 =?iso-8859-1?Q?Smo50dcyCE/KYdAOF3Xn4SF3bZNK9EUe3QNgvK2zqB5gVA3YkzBiqI+RYF?=
 =?iso-8859-1?Q?PLKjMAZVxYt0Op0kKwhVIWqoUWCOOo+kkpXAC9cBSG2je2kC2ZzfM9OSEZ?=
 =?iso-8859-1?Q?6/kCkbca0fAuJML+cdn+y7gJ8EAnbUw35N5qlFm4IgB0ZAG6LYcBKNgHjy?=
 =?iso-8859-1?Q?y2oMuR/QYfAiXZ81KKOhBQ111BV3tEG+m4snt6xjnc2Kk6ALcX0mahyPSb?=
 =?iso-8859-1?Q?3ht8aymp/ngR1gD/RYjvSGi6MT4NNRZz7NCrjV2c/L0N5O/bpCbeCMQzGW?=
 =?iso-8859-1?Q?f1/+sznkcVzE8z/GqhVzyEaRccN6LiR1Jk7aI2qJkVe+q+jSJmWGICnE69?=
 =?iso-8859-1?Q?BeAnjgMetJFj+v9+inHvpxnGmotoKtGyk7Ed4AZ5bC95Wh0Gqy9PoW+Dxh?=
 =?iso-8859-1?Q?x3GgkwB0rrq3cfpXTXFjMFes3chq8qNsbIx8PycI3oHsA/VIJXCH1KYo6Z?=
 =?iso-8859-1?Q?PdGHcwfcbh3N8FX8V3YrcYimOPj0fXk+SIfaW5+4pgGHW0n/r3JaHtqjoC?=
 =?iso-8859-1?Q?MbLuTI47XEsEOQtnOiJ2DUTTowiqvwEoAodg22PHND1Kl0O77FpJl+Rv8L?=
 =?iso-8859-1?Q?LRMRk52UGWFaX3uJbVgKhN6TmqPmbw8SpnOCMntZ2D6Y4XwC5rDe0eHo7x?=
 =?iso-8859-1?Q?8K4IdFXSVhjyTnjnoPifC1dMeKAr8k8d1jxnW6Dx6y8g0R0fFezlpfdZGs?=
 =?iso-8859-1?Q?c8WKfXTgDJt/U8Fc0zIpanq28oGlIhj1G+dixLsuKCNxll+Ck+b0kezSMY?=
 =?iso-8859-1?Q?HBzem0c63bgY6fd0nw2QxJfmyUcE9DfCSC5SW65fie7G2KYgNGjhLIy0eL?=
 =?iso-8859-1?Q?Om4dOPRt0dQqQgZ4Y+v1+ccrHpRBggNzjdF0lpTrnzV8djA5Yt+53cYppa?=
 =?iso-8859-1?Q?Mct5auCiL5kRpidQKMps2auhLrbvh0q1ylVdvhAaY+W7WqbpObcQu67ucL?=
 =?iso-8859-1?Q?BQgIAeKGlGBoEGtm6qDfF3Cl+Yy9tGUxlB7HPWdu/tdBQ/OWGUF+JIp3fn?=
 =?iso-8859-1?Q?FKENjvEChritqSEq6Z5WEfSTgRJpO91t+r5SfQfSjDU1TnG2bipY9/K0I7?=
 =?iso-8859-1?Q?ss12bVnuA7xexpIf1OxsgceSs0MqJmweO6cZOhqeB7eJxiuRX09G1m7Nro?=
 =?iso-8859-1?Q?WzsnXCWr0OA2ntrVU82I2uoU3rvBehbWNlkZFcCFeR99mBTZL6vqL2WF5x?=
 =?iso-8859-1?Q?m4mqz6zJcAvqrYU/IYryvUZIBji1jIy4R26edMcUk4bVMWIXEz0+o6t2TQ?=
 =?iso-8859-1?Q?XkdOfj3jj4ru3od4CmuzPOyO66bEFc2SjgLzNtOfgYni3nRcOPn9+YW+z+?=
 =?iso-8859-1?Q?hSxv0M8U/X/flluSmztk1bzuCTkhA8HDLodCIzynCBwnz8qhMgUEK0gKzB?=
 =?iso-8859-1?Q?siy6rh32BAFx46Et2FZcO7pZVltg/Ws3EFbPFTz0z0YUR2BIErVwb3OgpT?=
 =?iso-8859-1?Q?ha+LyA+klXocJlKRblSYr+UpazRmMSJZsdXMwf3yyxcK9wZd9XxIKZNCH5?=
 =?iso-8859-1?Q?qsWIzYyM8aduKdfahVaR9IGh6lZQfHy76Uylwh/JpgNEWJvRjg/0oQsp1j?=
 =?iso-8859-1?Q?dR0ChBtq9+0y5XtOLfmoizUKi8VOaJRkKjix3c8hwmpyTmu3MgYInHGKVu?=
 =?iso-8859-1?Q?tDAvAAvmUW6szO4q8NC9KZ10+UTNjuCuguya+VHY7yDogO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ijItStm520DEDSIEqfRXguzo55A/wTY8TS2WnSZiNptk8eWr+ve6RbrpVpiEYsxKOGobxiZGk/MK5ItzcZtFuwFnzQlaEmouTEWZYuSIm8LxECUbTlKU3hZByj3VpcyEqnjBpI5eI0huMxeSJpg4jnQ6ht2r3FGc6Nbd65XTVLE84E/pRdTJwD2w2ROgQyC6Bx/IFod2jNW5z3SzKmYZV5FZ/GhLFg7KzAZqsOtz9qbfX1Jjl6aqHiyGTOY7AzI7BDE1x1kIjZA9hUst1HN/ea/rRJpldZDG3cVCOj91bmcHUg60YYJhiEFqHz6QB0GwSXn8CDFMQjClZw0zcInivg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0814bee-7896-464d-5323-08df1f4bc380
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:16.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7FWH5vu0tRrbInroj4w+3IqRdHjm+fvWIfOzGj380aDcBrpfwHyqRkB/0sTGtwhmU37uiEIQVWg2Edh37YiyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811439-9IgqifkzvIUf
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811439;9IgqifkzvIUf;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The output-pins node matches its children against "^pin@[0-9]+$", while=0A=
input-pins takes "^pin@[0-9a-f]+$".  A unit address is the reg value in=0A=
hex, so a device with more than ten outputs cannot describe the=0A=
eleventh: dtc wants pin@a for reg =3D <10>, and the output pattern refuses=
=0A=
it.=0A=
=0A=
Use the input pattern for the outputs as well.=0A=
=0A=
Fixes: 0afcee10dda1 ("dt-bindings: dpll: Add DPLL device and pin")=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 Documentation/devicetree/bindings/dpll/dpll-device.yaml | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Docu=
mentation/devicetree/bindings/dpll/dpll-device.yaml=0A=
index fb8d7a9a3693..4b5184500b9f 100644=0A=
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml=0A=
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml=0A=
@@ -65,7 +65,7 @@ properties:=0A=
         const: 0=0A=
 =0A=
     patternProperties:=0A=
-      "^pin@[0-9]+$":=0A=
+      "^pin@[0-9a-f]+$":=0A=
         $ref: /schemas/dpll/dpll-pin.yaml=0A=
         unevaluatedProperties: false=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
