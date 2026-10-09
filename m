Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E151C05E;
	Fri,  9 Oct 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570732; cv=fail; b=lSv+lAiE6iT8ZBQJBr4m3Zdn9L6FQwNeXwt/wWSok0zgElkZjocn7O6cxKNSmybdJVikz+VuGYUskJ39u2U7DtH2NO3VV9AIt8t2e2OC9IDJu4eTTZlyBdZ+wYxDLZTFfrEiAIyMgwRkLNdkreiWoY9BYwmTr7WXBOa67aEGv2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570732; c=relaxed/simple;
	bh=B7RXRN4BdahUP/7WvNJF/2Dl92GdM4uF7iVFD4xp/sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oedwIt9cxAXKFMgL/s1jdYgew8Y/eH3+EcYZXAlfjtD5SG7tp5OZ7h4hPCqSnQyA6gScBCJXR44WxDGHlnSV5oNXm8lez61MJJHYLSZ01aZh4QrjdZJh1UJo4Sn12cPZGUCradLZg21irnfgb8lGUs0jxdjkH9zUVEwszzB4yuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Ew/yT2KA; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=g+bwF28N; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Ew/yT2KA";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="g+bwF28N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=hQY2cPp1kVjc86be3MfhDiEZG5ZqxWoYorzeEGvxivw=;
 b=Ew/yT2KA1Jcmx1myFGVHNAGTvVbrFgzA1Xn1U+Hrv0IlZEkAhq0BxPgrba11Ubr1yQKdVk51gp5fCD0tcfHWBFz5x7Mih6WXL8BSp6LydNdlxT/+f9bjLAu/iA3ftrZBOLZA7x+T+qanJyBoCDbVGSNR2aSmqb91BKhlwdFDUBeAEWUsLOKBn3CXU3o1nXEC8GpAmVuuGyscjMKp6GtMybu+MtWhvhgHc17TcCgU+lgDW4lM1dBmao9uA7tkIZCFpa2jv0Qt8Fin3GKTAxD/onKzjL6sWlLohxZi9XfEBj2L1o2T24HLVN8jqjzsPLLYIyu8RjQrgqKfoLy7Y/BkGg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023094.outbound.protection.outlook.com [40.93.201.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 278B9A8006D;
	Fri,  9 Oct 2026 18:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoObZrvzxn4hNscLHskluDuPkhik9loMDvlTfBTO4kx9+z8TQAHXbnnJS4CnbleVyFU9wt+WwmrGFfwQWfOGYZVR/nSFsd7Tan2n86VH3mZw4kmUf4O/indW6+tfYfDLQzJ+IpGdgeVTeOJz+Z7o+GpB1dv7lNJsEzmCN11aEeBgIrbkoqVWWy4RECcHeBCzIUtXRzPh/1RdYg64nL5VRgApD3Ix/aa7J7i6XltxX2XFKkoSKnw7xHsfjpOh90YavazwvuS0ih80I3485u2enZXs5z57WMtlPOmgU1t5lrxurG6MTBRqhms/REJaP1/eifRznoX/GMh+4jN4BEHrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQY2cPp1kVjc86be3MfhDiEZG5ZqxWoYorzeEGvxivw=;
 b=XXd/jQoaS+nvcFV5Yrp3m+bRwMv6Fy/OdKdXgmjcjrfQhKAQwb971Ro6dV9acZZWoRxlMwrcnOeiVrrs6YpzogFw1UehekA3yks1hjffertgTAxeza7YlLBc+Q3aKsuIjuwPVxrGQ55D+snxnVlisiY8BSIta+GFKb0un9C+KKAgKBTh8c26m3VAf4DJB+IyshVy1eW6tvAaxvm/FIIUoVtGwpFSX6CRIgq5OkvLrV6qaqg4/Tls8J1UzJGbGbP96Hex/y12+YVPEjEn+VGsfBjvPTWPTYYkWr1llp7aT9Pv2hLlXyEBXSo3h8ee7wvjiCl/IfQQ7nxpjdlRgqP3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQY2cPp1kVjc86be3MfhDiEZG5ZqxWoYorzeEGvxivw=;
 b=g+bwF28NOFxFTYa3wH53hGDdh/SiCVtoMzj7KC04s3rlBLjEQqw3qSpn9vtmxCRiyX/gsm0eB2bSemXwpkYUu9mxqHfyGY6p0bJNpHwKnqXtf8G9eUQmik9M5iHOxzL7TsueqVx/s+2BNwvNhD7JBc5gYH/O+FjVlWLjuphOV3+QRNbtu6g0fwURpas64LTPO5a9xAOuyNtHoZxkwUufnXnfKPvNA4r+ALzGJrImT7GeoSpWYdp5d60xJcSSWM5WWKtwInKzqhVI1pu9zmDw2DDLDBjhjz09N9+YbcHtl7FknCuIVqMUK/afnUsqyRii5jTh/jtTZ+47/7gXJfIxeg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH8PR20MB995515.namprd20.prod.outlook.com
 (2603:10b6:610:2eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:58 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:57 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 07/12] dpll: sit9531x: add support to get and set
 priority on input pins
Thread-Topic: [PATCH net-next v12 07/12] dpll: sit9531x: add support to get
 and set priority on input pins
Thread-Index: AQHdWBx3kxFst3xrbkqysg0UkA/Lww==
Date: Fri, 9 Oct 2026 18:31:57 +0000
Message-ID: <20261009183151.78497-8-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
In-Reply-To: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH8PR20MB995515:EE_
x-ms-office365-filtering-correlation-id: da228592-a1e2-41d1-c12c-08df263399b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|10067099003|22082099003|18002099003|3023799007|6133799003;
x-microsoft-antispam-message-info:
 xkJcHCiQwyhPmFzn7mAYhOWULMiAdtE43hblu2aFKvswj5vh/KMzhAZ0n+wEq7c/WdEE8rVyro+mqQwNkWhnmRCGZRhOZFjBQ327qIVvkkCmM49wdQzEb68C5AOGLpLSoskZHomouNtugsT5xykZjrg4vPPn5qVDTeBpgNaG1fkCToLWO1I8DCTgbg9mh+rc6EiH3jzXYeWb0GpMX6fJMRydW1fyRJ67EGavjsUd72IPj1gPxECvZ6VW7/yvnB79dGjfdGJVe7LturyPBa63Irbd509iGInqpytBleQ2RLm5D3xarqGfOCWGNm7RzTuemOwRyUpyv3qPGhrItQA5Pdlzf+UAYfbH6yBZJ9WKlkwOJeS2DB1mPRl/C/eaOwj96JTqvhJhYAuxDzLyPYOTjQWOXPO6fB7xOHR7LDM5ItFd7BjFZ9m5YqhkbazlhHSjVZGn3ymViSr7Igsg5Uvjat7bT34uuFHpzUzLse0afx9epXUstQW7FNZ3vl52rLi6YdBJ//sDIFNlYXH+WLevHBLymEncK426sCC9KO8vXuCaNS+/HrF9ouMjBDVEBgC1efecFSL3Fs/zcChlthkBTyj9p2NzH9tFGmCjSfRqV6w1Ou4UEWY14bx8spT2k1q14xoutKjckE9bC2o/lUwMxa6As0o1wu4uhRQrikQbcGVuccfRZQZIsV57PJqGydFwe0t/fZKWosySMd0I1KwOmd6PP33/RtNtSNEiB1ysOrQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?H+NpZif1JOSs4tw4TYxds0UZ44MoBVvBPLT7SjXNwPbkcN2OnvaAa70V8J?=
 =?iso-8859-1?Q?3a6M3rgyutQGox/lnQe7W8WdKwX+nNPDfb0M6wkKBrL+Z4UUV8DuvbH9Oo?=
 =?iso-8859-1?Q?lajG1SVzLlONZOFr7bWWeyqpcFYwDVQ2AIuJtZrb1uo1YVLaEXxluuqNGs?=
 =?iso-8859-1?Q?kt2Q1nZpHZpz0gG5MXoeuT9UxU+Bw3ZPHPG6MKtxmSQCh/WP6Y4v6+riKK?=
 =?iso-8859-1?Q?/fH9ZlXtdFBDt65lBuH92rY/dYde10dfHsCy4cFm+DMBW+SEYfFEtkIaXQ?=
 =?iso-8859-1?Q?rQOwHGjhkU7J1ATnR/RTTsoXX8wgHw6+k0RSuO8Tnfc6q2gmRwPGKnfwNh?=
 =?iso-8859-1?Q?hQy8y5ErVSPeUs0/KVJQdQO/kD6YSZ87NDu/x2LlKEGeJNelqyaKud7CnP?=
 =?iso-8859-1?Q?IcIjM581uoMpinhxioXlabuPdzpWhchZAhtLnA8jMF1SHkzoserAQeXWL3?=
 =?iso-8859-1?Q?rQ/By2f7x2cFTmp0rsgWhwbVsB5oC3Nopt7HYfkwlN4od1UjlNQaYsrtG8?=
 =?iso-8859-1?Q?1SnVdTfEOoS5C2079lBQWREMNjZvn3fb7BQeyN5rlBP7EOzEl+/GWLUpdx?=
 =?iso-8859-1?Q?yzbpZhgQ7UhlFH9vzeXCQli2tLYdDJHyFfYV3D7kZuUvJ1CWB9J/dboIUN?=
 =?iso-8859-1?Q?J31QFjDDUMTJEGhUDfOs+ks5TH+WkQCUzRFVlRh6f7QAA0N6xdJRVrv4Ca?=
 =?iso-8859-1?Q?7m0N8fxiZyR3OLdd07P6z5OKzyQ6GEl+YigwqC9fhgFn2fQ5ISvHOEK+E/?=
 =?iso-8859-1?Q?yiD8DijrNWgLGXm/TUBPQp0AmQXE+QTTPs8GVFN5pkdAZUDr1poxo1Vf3y?=
 =?iso-8859-1?Q?oJd17aB1lwf9gqUEIx5XGtikFws/y9BgbcRz7Z6M0WmsPaSUMHlPVTL7s+?=
 =?iso-8859-1?Q?eiLIU3DoIdrgWUK40tF+HqjNTEbNuRNrM8m6l2Sv2cvTzy8T1dM6JuCmch?=
 =?iso-8859-1?Q?i+Xcr86IgMHW9C1eOTfhQVY8piwM4C8Y1Hcnq+LpmdpRYVFLbXEpaKmxBC?=
 =?iso-8859-1?Q?BNBORDIf2GyX3IDxXqQX4SCKnEFr2UQEfIjE7GjMjEc8CIi6KEfUDKpatY?=
 =?iso-8859-1?Q?/voWMV+d51KdqL2NB6hZtUCLwuQORNP9g/BetYc6Rk2Ys9OxmuCAgu5anS?=
 =?iso-8859-1?Q?lbcpt4JpUKtuJAcWsrvrBQP9k3sEi38+TVzofDFZnYOoCTYJVgUJ3Xhc4e?=
 =?iso-8859-1?Q?8JJ2e0KruL6a4DlpLIoBA53OtRWP1XTLMhsaPocOilGBO0pBciWuhDl1jR?=
 =?iso-8859-1?Q?XPlxMZ46D5N5MQseu0tIIn4ECXFI5oPlVOPuRgIVdZpezJMUdx8rDA4S+U?=
 =?iso-8859-1?Q?GOReEkbwXOgqJr3B6SdDay5jp6b6zcZ/6or/8go403F389IR+ydA7co0zN?=
 =?iso-8859-1?Q?6FN99qx7ELryIPG7RfV4GGrSdbKZ86zwqRNktKXu4qx/6Bd3vmqm+ZIS9T?=
 =?iso-8859-1?Q?TdxEtJrLoyVgk9HIlmZqKB83g9lDEIr23mkmEaO9FuokDFPMZtbE+ayONA?=
 =?iso-8859-1?Q?cRm6asmruVYFjwK6Jtrg+2DZSkg1ZzrS9uOXCfk2KbLUuyg1WAYPzhNBJp?=
 =?iso-8859-1?Q?atHfHEvtSjEb7o16ihIuazFxB1zrQRkw/Rj6qyRuXW2e9wTDLWuijZzwEA?=
 =?iso-8859-1?Q?RhOOBsYaft3H426iymOCTwh5fAibMhe0c1lITON/kdQfNm3ChNHdwWb07a?=
 =?iso-8859-1?Q?+moMDjEaRCDoC7dwpYG3O5LhNM9+XJXkE9PpnTOvmK3qhbUraxGZuuzTbJ?=
 =?iso-8859-1?Q?QKceIJ8saKGBJy6RYj21se499L5rA6T7uuqEJy28vV2gf6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jWJXQH1ArwjQS96n8SMd7eiDsCohROJQYpUHhakQWezGJt6bKHlHCr8uhuAcbQQ4NEZCuGBxzbs9LxsKf76xUYE1gtI9HGj4tfGTk1Phd4KsNjlugzWL7WGDA7pzihJYjpFRfH4kejmMAHVxVhz+WMXzTEfOZSWbb6gzvjAW9TtV+/yJ5vkNy+oXg879uO459mirVb95JiEDcm/tv6vTyzsVqNMHXxkNsi5N1wcEhLSRf/Pm4+3vDSRSYVkYXmEq7GUNvU9zx/tbfqj9f1Snf1LKDFS4Ni1qXe+sQT86NsonHyMUtye89wR1vzvl6hqa3lELFulc5bEPl9boPEInUA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da228592-a1e2-41d1-c12c-08df263399b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:57.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+Qf2G9ggqZ1tZBsDyxQpRYELn7JzV89H7DuVnsyIjVK9nmvkupgjfRkCOwna4bPc/Gf2kKbG4BJjh0Y3vFtIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR20MB995515
X-MDID: 1791570720-KKiANLRD6er4
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570720;KKiANLRD6er4;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
When the device has to choose a reference, it takes the first slot of=0A=
its priority table that has signal.  The driver keeps a=0A=
priority per input and PLL and builds the table from it (previous=0A=
patch), so getting a priority reads that value without touching a=0A=
register, and setting one records it and, for an input the PLL lists,=0A=
rewrites the table in the new order.  When the new order puts a=0A=
different input with signal first, the PLL moves to it; a change further=0A=
down the table leaves the PLL where it is.=0A=
=0A=
Priority and state are separate attributes, and neither moves the other.=0A=
A priority can be set on a disconnected input and takes effect when it is=
=0A=
connected; disconnecting an input and connecting it again brings back the=
=0A=
priority it had.  Setting one input's priority leaves every other input's=
=0A=
as it was, so the named pin is the only one whose priority changes and=0A=
the core's own notification covers that; when the new order moves the=0A=
active selection, the siblings' operational state follows on the next=0A=
poll.  A priority the table write refused is not kept: the configured=0A=
value goes back to what it was, so nothing reports a priority the=0A=
device never took.  The range is 0 to 255 against a table of eleven slots:=
=0A=
inputs of equal priority keep the order the table already has them in,=0A=
so distinct values are what fix an order.  An input the PLL has never=0A=
listed reports the lowest slot, the priority it would be connected at.=0A=
=0A=
A table rewritten behind the driver -- a profile reload, a direct I2C=0A=
tool -- is taken as the new configuration and the priorities are=0A=
re-seeded from it, so the poll now watches priority and operational state=
=0A=
as well as state, and notifies a pin when any of them moves.  The=0A=
notifications go out after the walk over the pins, outside multiop_lock,=0A=
since the helper takes locks the callbacks run under.=0A=
=0A=
A pin's baseline for that watch -- state, operational state and priority=0A=
-- is taken when the pin is registered, under the device lock, rather=0A=
than by the first tick, so a change between the probe-time fetch and=0A=
that tick is reported instead of absorbed into the baseline.  The device=0A=
lock status is seeded the same way, so the first tick announces only=0A=
what moved since registration.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c |  43 +++++++-=0A=
 drivers/dpll/sit9531x/core.h |   2 +=0A=
 drivers/dpll/sit9531x/dpll.c | 202 ++++++++++++++++++++++++++++++-----=0A=
 drivers/dpll/sit9531x/dpll.h |   4 +-=0A=
 drivers/dpll/sit9531x/prop.c |   4 +-=0A=
 5 files changed, 227 insertions(+), 28 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 999a6583853d..79520640dfc8 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -671,6 +671,44 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *=
sitdev, u8 pll_idx,=0A=
 	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_prio_get - read an input's priority for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	output priority (lower is preferred)=0A=
+ *=0A=
+ * Reports the priority configured for the source on this PLL, which is=0A=
+ * kept whether or not the source is currently in the table: state and=0A=
+ * priority are separate attributes, so disconnecting an input and=0A=
+ * connecting it again must not change the priority it reports.  The=0A=
+ * value is seeded from the hardware table, and re-seeded whenever the=0A=
+ * read-back shows the table was rewritten by something other than this=0A=
+ * driver.  A source that was never listed reports the lowest slot.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (chan->cfg_known & BIT(input_idx))=0A=
+		*prio =3D chan->cfg_prio[input_idx];=0A=
+	else=0A=
+		*prio =3D SIT9531X_PRIO_MAX_SLOTS - 1;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Take the configured priorities from a table the hardware holds: each=0A=
  * listed source gets the first slot it occupies.  A source the table does=
=0A=
@@ -2581,9 +2619,12 @@ static int sit9531x_dpll_pins_register(struct sit953=
1x_dpll *sitdpll)=0A=
 		/*=0A=
 		 * Pins registered before this one are already reachable from=0A=
 		 * netlink, and the walks over this list run under=0A=
-		 * multiop_lock, so the insertion does too.=0A=
+		 * multiop_lock, so the insertion does too.  The baseline the=0A=
+		 * poll compares the pin against is taken under the same=0A=
+		 * lock, from the cache the create notification just reported.=0A=
 		 */=0A=
 		mutex_lock(&sitdpll->dev->multiop_lock);=0A=
+		sit9531x_dpll_pin_baseline(pin);=0A=
 		list_add(&pin->list, &sitdpll->pins);=0A=
 		mutex_unlock(&sitdpll->dev->multiop_lock);=0A=
 	}=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index cf4dd5f82d05..fa1197bfc81c 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -255,6 +255,8 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *s=
itdev,=0A=
 				 u8 pll_idx, u8 input_idx);=0A=
 int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio);=0A=
 int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			       u8 input_idx);=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 4c7cae4ce93e..0400444d91a5 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -34,6 +34,21 @@ sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *=
pin)=0A=
 	       pin->id =3D=3D SIT9531X_MAX_INPUTS;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The pins the poll watches: the selection-role pins -- regular reference=
s=0A=
+ * and the INTSYNC destination -- whose state, operational state and=0A=
+ * priority can move without a request: the device selects on its own, the=
=0A=
+ * monitors follow the signal, and a table rewritten behind the driver=0A=
+ * re-seeds the priorities.  Outputs (incl. the INTSYNC source) change onl=
y=0A=
+ * through their own set callback and the XO is permanently connected.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_is_selection_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       !sit9531x_dpll_is_xo_pin(pin);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Status of a PLL whose outer loop is frozen in holdover.=0A=
  *=0A=
@@ -548,11 +563,93 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struc=
t dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority=0A=
+ *=0A=
+ * Reports the priority sit9531x_input_prio_get() keeps for the source on=
=0A=
+ * this PLL, connected or not; no register is read.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 *prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id), &slot);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * dpin->prio is not touched here: it is the poll's baseline for=0A=
+	 * spotting a change to notify, and a get refreshing it would hide=0A=
+	 * the change from the poll.=0A=
+	 */=0A=
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority=0A=
+ *=0A=
+ * Records the priority and, for a pin in this PLL's table, rewrites the=
=0A=
+ * Page 1 table in priority order (sit9531x_input_prio_set()).  The other=
=0A=
+ * pins keep their priorities, so only the named pin changes and the core=
=0A=
+ * notifies it.  A pin that is not in the table keeps the priority for whe=
n=0A=
+ * it is connected.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (prio > U8_MAX) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-255)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	if (!rc)=0A=
+		dpin->prio =3D prio;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -636,6 +733,55 @@ sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_p=
in *pin)=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The state, operational state and priority of a selection-role pin as=0A=
+ * the cache has them now: the baseline at registration, and what the poll=
=0A=
+ * compares it against on every tick.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_dpll_pin_snapshot(struct sit9531x_dpll *sitdpll,=0A=
+				       const struct sit9531x_dpll_pin *pin,=0A=
+				       enum dpll_pin_state *state,=0A=
+				       enum dpll_pin_operstate *operstate,=0A=
+				       u8 *prio)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 id =3D pin->id;=0A=
+=0A=
+	if (id =3D=3D SIT9531X_INTSYNC_PIN_ID && sitdev->intsync_src =3D=3D sitdp=
ll->id)=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else=0A=
+		sit9531x_dpll_selection_state_get(sitdev, sitdpll, id, state);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll, id, operstate);=0A=
+	if (sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				    sit9531x_input_hw_src(id), prio))=0A=
+		*prio =3D pin->prio;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_pin_baseline - seed what the poll compares a pin against=
=0A=
+ *=0A=
+ * Called right after the pin is registered, under multiop_lock, so the=0A=
+ * poll's first comparison is against what the create notification=0A=
+ * carried.  A baseline taken on the first tick instead would absorb=0A=
+ * whatever moved between registration and that tick -- a lane losing its=
=0A=
+ * signal, a table rewritten and re-seeded -- and leave userspace with the=
=0A=
+ * snapshot from registration until the next change.=0A=
+ */=0A=
+void sit9531x_dpll_pin_baseline(struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D pin->dpll;=0A=
+=0A=
+	lockdep_assert_held(&sitdpll->dev->multiop_lock);=0A=
+=0A=
+	if (!sit9531x_dpll_is_selection_pin(pin))=0A=
+		return;=0A=
+=0A=
+	sit9531x_dpll_pin_snapshot(sitdpll, pin, &pin->pin_state,=0A=
+				   &pin->operstate, &pin->prio);=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_changes_check - check for state changes and notify=0A=
  *=0A=
@@ -671,39 +817,45 @@ void sit9531x_dpll_changes_check(struct sit9531x_dpll=
 *sitdpll)=0A=
 		dpll_device_change_ntf(sitdpll->dpll_dev);=0A=
 	}=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
 	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
-		const struct dpll_pin_ops *ops;=0A=
+		enum dpll_pin_operstate operstate;=0A=
 		enum dpll_pin_state state;=0A=
 		bool changed;=0A=
+		u8 prio;=0A=
 =0A=
-		/*=0A=
-		 * Poll input pins whose state can change autonomously: regular=0A=
-		 * references and the INTSYNC destination pin.  Outputs (incl.=0A=
-		 * the INTSYNC source) change only through their own set=0A=
-		 * callback and the XO is permanently connected, so skip those.=0A=
-		 * Each pin's state_on_dpll_get resolves to the right getter.=0A=
-		 */=0A=
-		if (!sit9531x_dpll_is_input_pin(pin) ||=0A=
-		    sit9531x_dpll_is_xo_pin(pin))=0A=
+		if (!sit9531x_dpll_is_selection_pin(pin))=0A=
 			continue;=0A=
 =0A=
-		ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
-		rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,=0A=
-					    sitdpll->dpll_dev, sitdpll,=0A=
-					    &state, NULL);=0A=
-		if (rc)=0A=
-			continue;=0A=
+		sit9531x_dpll_pin_snapshot(sitdpll, pin, &state, &operstate,=0A=
+					   &prio);=0A=
+=0A=
+		changed =3D state !=3D pin->pin_state ||=0A=
+			  operstate !=3D pin->operstate || prio !=3D pin->prio;=0A=
+		if (changed)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"%s: state %u->%u operstate %u->%u prio %u->%u\n",=0A=
+				pin->label, pin->pin_state, state,=0A=
+				pin->operstate, operstate, pin->prio, prio);=0A=
+=0A=
+		pin->pin_state =3D state;=0A=
+		pin->operstate =3D operstate;=0A=
+		pin->prio =3D prio;=0A=
 =0A=
 		/*=0A=
-		 * The first pass only takes the baseline: the pin was=0A=
-		 * registered with this state, so nothing has changed yet.=0A=
+		 * The notification helper takes DPLL-subsystem locks that the=0A=
+		 * callbacks run under, so it cannot be called with=0A=
+		 * multiop_lock held; mark the pin and send after the walk.=0A=
 		 */=0A=
-		changed =3D pin->seen && state !=3D pin->pin_state;=0A=
-		pin->pin_state =3D state;=0A=
-		pin->seen =3D true;=0A=
-		if (changed) {=0A=
-			dev_dbg(sitdev->dev, "%s state changed\n", pin->label);=0A=
-			dpll_pin_change_ntf(pin->dpll_pin);=0A=
-		}=0A=
+		if (changed)=0A=
+			pin->ntf_pending =3D true;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+		if (!pin->ntf_pending)=0A=
+			continue;=0A=
+		pin->ntf_pending =3D false;=0A=
+		dpll_pin_change_ntf(pin->dpll_pin);=0A=
 	}=0A=
 }=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
index 9eb26505f94e..c2706ced92cd 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.h=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -31,7 +31,8 @@ struct sit9531x_dpll_pin {=0A=
 	u8				id;		/* hardware index */=0A=
 	u8				prio;=0A=
 	enum dpll_pin_state		pin_state;=0A=
-	bool				seen;	/* baseline taken by the poll */=0A=
+	enum dpll_pin_operstate		operstate;=0A=
+	bool				ntf_pending;=0A=
 };=0A=
 =0A=
 /* Per-PLL DPLL device state. */=0A=
@@ -63,6 +64,7 @@ void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdp=
ll);=0A=
 =0A=
 /* ---- Periodic change detection ---- */=0A=
 void sit9531x_dpll_lock_status_baseline(struct sit9531x_dpll *sitdpll);=0A=
+void sit9531x_dpll_pin_baseline(struct sit9531x_dpll_pin *pin);=0A=
 void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);=0A=
 =0A=
 #endif /* _SIT9531X_DPLL_H */=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 3635ea497e41..934db566c002 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -187,10 +187,11 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=
=0A=
 	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
 		/*=0A=
 		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
-		 * reference, so it can be connected.=0A=
+		 * reference, so it can be connected and re-prioritised.=0A=
 		 */=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D 0;=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
@@ -214,6 +215,7 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->ref[index].freq;=0A=
 	} else {=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
